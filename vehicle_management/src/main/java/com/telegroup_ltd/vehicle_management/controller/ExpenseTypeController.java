package com.telegroup_ltd.vehicle_management.controller;

import com.telegroup_ltd.vehicle_management.common.ReadOnlyController;
import com.telegroup_ltd.vehicle_management.model.ExpenseType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("expense-type")
public class ExpenseTypeController extends ReadOnlyController<ExpenseType,Integer> {

    public ExpenseTypeController(JpaRepository<ExpenseType, Integer> repo) {
        super(repo);
    }
}
