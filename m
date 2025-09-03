Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC295CA1010
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 22:10:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44E568365E;
	Thu,  4 Sep 2025 00:09:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i7MbrsZ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E89B483655; Thu,  4 Sep 2025 00:09:50 +0200 (CEST)
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com
 [IPv6:2607:f8b0:4864:20::a2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7558A8360D
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 00:09:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-5449fc0a7f1so364895e0c.0
 for <u-boot@lists.denx.de>; Wed, 03 Sep 2025 15:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756937386; x=1757542186; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WGa6HxZSnsrz69prvuYuGsvP87mYjtxw7iweBDmH1yQ=;
 b=i7MbrsZ/k+hT+TBmCjTntMSZgywlW5kqz8H9qGpVdGElUUPHi6s5zc/fHt0ek3Wz+i
 8zSVEzmAJwyQtJidx7NHRHFXmjUVM1LeD1LV9WlORTVJUe6AUT5Qq/c5XtxNvAmP+X3v
 OuureLuSSHkIn8OATQgbWkRZo6z8kV8IMR6fuHCv2W3hp/53OHMP92UbSO43E1/SGlzm
 tzy826L3KLVOrHW7LrSgpsXuwE7Bj37pfbvQs8r2aX/dZYBMyC07ThDT36HoR1j0jKcw
 h9uxR+fqLOeHXefhuMeXP3yQTQHlUkNWjocJQwUvUtYmWYE51FO2KV1F0PoYJlOUQ2sf
 PYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756937386; x=1757542186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WGa6HxZSnsrz69prvuYuGsvP87mYjtxw7iweBDmH1yQ=;
 b=WDwU0euxbhD6N1TgQKF960MlIMymNi5pdlzL++Yx7AupHZJMETOGsfOEMTiuRcod3b
 +0PrlGn5IkGblLuUCw7hMBtRPDq4EAvJB0F77wIWI0XAlH9Yyyldgd5qVYK6WyeUDchi
 s7Ns+b3zHL22U32L65C+xzOIU8P5L7DHQxdbfgqfVyv7ZG/HBINoKs/6QdofGB2mB8k2
 30rDx4aS1r+sRMgpUx1RN6Py6picl5pABTKA99xX8WLdhzBYDXqSlsl2/0lR3sNpVI+v
 OeOTMtf7/ecHWx/o0uQbQQzsmPY9SOybJ+XL26ZYWa3Ugyc/9J2zeMViL1+v37wnsj8/
 IjKA==
X-Gm-Message-State: AOJu0YyoZeDbuf4B5+g6VMbbJFYr7ewwRMBxC1UeV8PWHe/+addN265y
 3YqYhY7OOi6xpjZJqwnlXoCP+5OpH3pyqtpEUeKCRgs26MQhJ4rPVNVKCR74ZhY4ZvxoDdAB+rB
 qKqka
X-Gm-Gg: ASbGncv07MhbogOqIdCH6r30L4i/M3/f71a5cSHNp3LgGtjMT+0UfPhJrxUCqArpaRF
 zlvJqUe32itMNqueCu1xbmpObEB57npnNhQNjpFXQ6yD3e+pBswCmt1G5gGdpC381FniA5e7M7c
 QWh/NRNBivIXWMaxv8lMVtkCgU78YKZ9Xph0xPd298VwWO5GesAZKGVrDGZokmg0395KLa+dd9l
 CzpdrKEMH6jBtICx0vdRGU5x433XBtH9KOOOsXxjtYW75z5u2F1KyYteaizZAgrWA5WYyMVM+kj
 97ZX1X3nMpu5L4xBPKr2LNP7gvFdVdaGIr4frLi5di7t/2KiNNqldEK/1oPmkjAZPNtVBiA6IvC
 kNcXSPplW6Tgo7OOfR/s7oa+Ac5fcoSPy7/g8+yb4QdbH6pe4qQ9UE9R6vTU=
X-Google-Smtp-Source: AGHT+IHl5Gb9eqJHdgGHw337Rjb/Qe9wMsE3+qJiN/Z6ccijbgKK+LdIfhXV/RJpwDofSb8XWdEYUg==
X-Received: by 2002:a05:6122:6b05:b0:545:e04d:9e80 with SMTP id
 71dfb90a1353d-545e04da135mr1156685e0c.16.1756937385911; 
 Wed, 03 Sep 2025 15:09:45 -0700 (PDT)
Received: from jetm-rog-crosshair-hero-x870e ([177.93.10.181])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-544912c7125sm7474211e0c.5.2025.09.03.15.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 15:09:45 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/4] clang-format: Add configuration file
Date: Wed,  3 Sep 2025 16:09:38 -0600
Message-ID: <20250903220942.473282-2-javier.tia@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903220942.473282-1-javier.tia@linaro.org>
References: <20250903220942.473282-1-javier.tia@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Introduce .clang-format configuration file to U-Boot, providing
significant improvements over the existing scripts/Lindent approach for
C code formatting.

Benefits of clang-format over scripts/Lindent:

- More comprehensive formatting rules: While Lindent relies on the basic
  'indent' tool with limited options, clang-format provides extensive
  control over code formatting with 800+ configuration options

- Better handling of complex code structures: clang-format understands
  modern C constructs and handles nested structures, macros, and complex
  expressions more intelligently

- IDE and editor integration: Native support in major development
  environments (VS Code, Vim, Emacs, etc.) enables real-time formatting

- Consistent results across environments: Eliminates variations between
  different versions of 'indent' tool and system configurations

- Active maintenance: clang-format is actively developed and updated,
  unlike the aging 'indent' tool

Alignment with Linux kernel practices:

Continues U-Boot alignment with Linux kernel development practices,
maintaining consistency between these closely related projects. The
Linux kernel adopted clang-format to modernize its code formatting
infrastructure and improve developer experience.

The .clang-format file is based on the Linux kernel configuration,
specifically copied from Linux kernel v6.16 tag, which itself builds
upon the initial introduction in commit d4ef8d3ff005c ("clang-format:
add configuration file").

Signed-off-by: Javier Tia <javier.tia@linaro.org>
---
 .clang-format | 804 ++++++++++++++++++++++++++++++++++++++++++++++++++
 .gitignore    |   1 +
 2 files changed, 805 insertions(+)
 create mode 100644 .clang-format

diff --git a/.clang-format b/.clang-format
new file mode 100644
index 00000000000..48405c54ef2
--- /dev/null
+++ b/.clang-format
@@ -0,0 +1,804 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# clang-format configuration file. Intended for clang-format >= 11.
+#
+# For more information, see:
+#
+#   Documentation/dev-tools/clang-format.rst
+#   https://clang.llvm.org/docs/ClangFormat.html
+#   https://clang.llvm.org/docs/ClangFormatStyleOptions.html
+#
+---
+AccessModifierOffset: -4
+AlignAfterOpenBracket: Align
+AlignConsecutiveAssignments: false
+AlignConsecutiveDeclarations: false
+AlignEscapedNewlines: Left
+AlignOperands: true
+AlignTrailingComments: false
+AllowAllParametersOfDeclarationOnNextLine: false
+AllowShortBlocksOnASingleLine: false
+AllowShortCaseLabelsOnASingleLine: false
+AllowShortFunctionsOnASingleLine: None
+AllowShortIfStatementsOnASingleLine: false
+AllowShortLoopsOnASingleLine: false
+AlwaysBreakAfterDefinitionReturnType: None
+AlwaysBreakAfterReturnType: None
+AlwaysBreakBeforeMultilineStrings: false
+AlwaysBreakTemplateDeclarations: false
+BinPackArguments: true
+BinPackParameters: true
+BraceWrapping:
+  AfterClass: false
+  AfterControlStatement: false
+  AfterEnum: false
+  AfterFunction: true
+  AfterNamespace: true
+  AfterObjCDeclaration: false
+  AfterStruct: false
+  AfterUnion: false
+  AfterExternBlock: false
+  BeforeCatch: false
+  BeforeElse: false
+  IndentBraces: false
+  SplitEmptyFunction: true
+  SplitEmptyRecord: true
+  SplitEmptyNamespace: true
+BreakBeforeBinaryOperators: None
+BreakBeforeBraces: Custom
+BreakBeforeInheritanceComma: false
+BreakBeforeTernaryOperators: false
+BreakConstructorInitializersBeforeComma: false
+BreakConstructorInitializers: BeforeComma
+BreakAfterJavaFieldAnnotations: false
+BreakStringLiterals: false
+ColumnLimit: 80
+CommentPragmas: '^ IWYU pragma:'
+CompactNamespaces: false
+ConstructorInitializerAllOnOneLineOrOnePerLine: false
+ConstructorInitializerIndentWidth: 8
+ContinuationIndentWidth: 8
+Cpp11BracedListStyle: false
+DerivePointerAlignment: false
+DisableFormat: false
+ExperimentalAutoDetectBinPacking: false
+FixNamespaceComments: false
+
+# Taken from:
+#   git grep -h '^#define [^[:space:]]*for_each[^[:space:]]*(' include/ tools/ \
+#   | sed "s,^#define \([^[:space:]]*for_each[^[:space:]]*\)(.*$,  - '\1'," \
+#   | LC_ALL=C sort -u
+ForEachMacros:
+  - '__ata_qc_for_each'
+  - '__bio_for_each_bvec'
+  - '__bio_for_each_segment'
+  - '__evlist__for_each_entry'
+  - '__evlist__for_each_entry_continue'
+  - '__evlist__for_each_entry_from'
+  - '__evlist__for_each_entry_reverse'
+  - '__evlist__for_each_entry_safe'
+  - '__for_each_mem_range'
+  - '__for_each_mem_range_rev'
+  - '__for_each_thread'
+  - '__hlist_for_each_rcu'
+  - '__map__for_each_symbol_by_name'
+  - '__pci_bus_for_each_res0'
+  - '__pci_bus_for_each_res1'
+  - '__pci_dev_for_each_res0'
+  - '__pci_dev_for_each_res1'
+  - '__perf_evlist__for_each_entry'
+  - '__perf_evlist__for_each_entry_reverse'
+  - '__perf_evlist__for_each_entry_safe'
+  - '__rq_for_each_bio'
+  - '__shost_for_each_device'
+  - '__sym_for_each'
+  - '_for_each_counter'
+  - 'apei_estatus_for_each_section'
+  - 'ata_for_each_dev'
+  - 'ata_for_each_link'
+  - 'ata_qc_for_each'
+  - 'ata_qc_for_each_raw'
+  - 'ata_qc_for_each_with_internal'
+  - 'ax25_for_each'
+  - 'ax25_uid_for_each'
+  - 'bio_for_each_bvec'
+  - 'bio_for_each_bvec_all'
+  - 'bio_for_each_folio_all'
+  - 'bio_for_each_integrity_vec'
+  - 'bio_for_each_segment'
+  - 'bio_for_each_segment_all'
+  - 'bio_list_for_each'
+  - 'bip_for_each_vec'
+  - 'bond_for_each_slave'
+  - 'bond_for_each_slave_rcu'
+  - 'bpf_for_each'
+  - 'bpf_for_each_reg_in_vstate'
+  - 'bpf_for_each_reg_in_vstate_mask'
+  - 'bpf_for_each_spilled_reg'
+  - 'bpf_object__for_each_map'
+  - 'bpf_object__for_each_program'
+  - 'btree_for_each_safe128'
+  - 'btree_for_each_safe32'
+  - 'btree_for_each_safe64'
+  - 'btree_for_each_safel'
+  - 'card_for_each_dev'
+  - 'cgroup_taskset_for_each'
+  - 'cgroup_taskset_for_each_leader'
+  - 'cpu_aggr_map__for_each_idx'
+  - 'cpufreq_for_each_efficient_entry_idx'
+  - 'cpufreq_for_each_entry'
+  - 'cpufreq_for_each_entry_idx'
+  - 'cpufreq_for_each_valid_entry'
+  - 'cpufreq_for_each_valid_entry_idx'
+  - 'css_for_each_child'
+  - 'css_for_each_descendant_post'
+  - 'css_for_each_descendant_pre'
+  - 'damon_for_each_region'
+  - 'damon_for_each_region_from'
+  - 'damon_for_each_region_safe'
+  - 'damon_for_each_scheme'
+  - 'damon_for_each_scheme_safe'
+  - 'damon_for_each_target'
+  - 'damon_for_each_target_safe'
+  - 'damos_for_each_filter'
+  - 'damos_for_each_filter_safe'
+  - 'damos_for_each_ops_filter'
+  - 'damos_for_each_ops_filter_safe'
+  - 'damos_for_each_quota_goal'
+  - 'damos_for_each_quota_goal_safe'
+  - 'data__for_each_file'
+  - 'data__for_each_file_new'
+  - 'data__for_each_file_start'
+  - 'def_for_each_cpu'
+  - 'device_for_each_child_node'
+  - 'device_for_each_child_node_scoped'
+  - 'dma_fence_array_for_each'
+  - 'dma_fence_chain_for_each'
+  - 'dma_fence_unwrap_for_each'
+  - 'dma_resv_for_each_fence'
+  - 'dma_resv_for_each_fence_unlocked'
+  - 'do_for_each_ftrace_op'
+  - 'drm_atomic_crtc_for_each_plane'
+  - 'drm_atomic_crtc_state_for_each_plane'
+  - 'drm_atomic_crtc_state_for_each_plane_state'
+  - 'drm_atomic_for_each_plane_damage'
+  - 'drm_client_for_each_connector_iter'
+  - 'drm_client_for_each_modeset'
+  - 'drm_connector_for_each_possible_encoder'
+  - 'drm_exec_for_each_locked_object'
+  - 'drm_exec_for_each_locked_object_reverse'
+  - 'drm_for_each_bridge_in_chain'
+  - 'drm_for_each_connector_iter'
+  - 'drm_for_each_crtc'
+  - 'drm_for_each_crtc_reverse'
+  - 'drm_for_each_encoder'
+  - 'drm_for_each_encoder_mask'
+  - 'drm_for_each_fb'
+  - 'drm_for_each_legacy_plane'
+  - 'drm_for_each_plane'
+  - 'drm_for_each_plane_mask'
+  - 'drm_for_each_privobj'
+  - 'drm_gem_for_each_gpuvm_bo'
+  - 'drm_gem_for_each_gpuvm_bo_safe'
+  - 'drm_gpusvm_for_each_range'
+  - 'drm_gpuva_for_each_op'
+  - 'drm_gpuva_for_each_op_from_reverse'
+  - 'drm_gpuva_for_each_op_reverse'
+  - 'drm_gpuva_for_each_op_safe'
+  - 'drm_gpuvm_bo_for_each_va'
+  - 'drm_gpuvm_bo_for_each_va_safe'
+  - 'drm_gpuvm_for_each_va'
+  - 'drm_gpuvm_for_each_va_range'
+  - 'drm_gpuvm_for_each_va_range_safe'
+  - 'drm_gpuvm_for_each_va_safe'
+  - 'drm_mm_for_each_hole'
+  - 'drm_mm_for_each_node'
+  - 'drm_mm_for_each_node_in_range'
+  - 'drm_mm_for_each_node_safe'
+  - 'dsa_switch_for_each_available_port'
+  - 'dsa_switch_for_each_cpu_port'
+  - 'dsa_switch_for_each_cpu_port_continue_reverse'
+  - 'dsa_switch_for_each_port'
+  - 'dsa_switch_for_each_port_continue_reverse'
+  - 'dsa_switch_for_each_port_safe'
+  - 'dsa_switch_for_each_user_port'
+  - 'dsa_switch_for_each_user_port_continue_reverse'
+  - 'dsa_tree_for_each_cpu_port'
+  - 'dsa_tree_for_each_user_port'
+  - 'dsa_tree_for_each_user_port_continue_reverse'
+  - 'dso__for_each_symbol'
+  - 'elf_hash_for_each_possible'
+  - 'elf_symtab__for_each_symbol'
+  - 'evlist__for_each_cpu'
+  - 'evlist__for_each_entry'
+  - 'evlist__for_each_entry_continue'
+  - 'evlist__for_each_entry_from'
+  - 'evlist__for_each_entry_reverse'
+  - 'evlist__for_each_entry_safe'
+  - 'flow_action_for_each'
+  - 'for_each_acpi_consumer_dev'
+  - 'for_each_acpi_dev_match'
+  - 'for_each_active_dev_scope'
+  - 'for_each_active_drhd_unit'
+  - 'for_each_active_iommu'
+  - 'for_each_active_irq'
+  - 'for_each_active_route'
+  - 'for_each_aggr_pgid'
+  - 'for_each_alloc_capable_rdt_resource'
+  - 'for_each_and_bit'
+  - 'for_each_andnot_bit'
+  - 'for_each_available_child_of_node'
+  - 'for_each_available_child_of_node_scoped'
+  - 'for_each_bench'
+  - 'for_each_bio'
+  - 'for_each_board_func_rsrc'
+  - 'for_each_btf_ext_rec'
+  - 'for_each_btf_ext_sec'
+  - 'for_each_bvec'
+  - 'for_each_capable_rdt_resource'
+  - 'for_each_card_auxs'
+  - 'for_each_card_auxs_safe'
+  - 'for_each_card_components'
+  - 'for_each_card_dapms'
+  - 'for_each_card_pre_auxs'
+  - 'for_each_card_prelinks'
+  - 'for_each_card_rtds'
+  - 'for_each_card_rtds_safe'
+  - 'for_each_card_widgets'
+  - 'for_each_card_widgets_safe'
+  - 'for_each_cgroup_storage_type'
+  - 'for_each_child_of_node'
+  - 'for_each_child_of_node_scoped'
+  - 'for_each_child_of_node_with_prefix'
+  - 'for_each_clear_bit'
+  - 'for_each_clear_bit_from'
+  - 'for_each_clear_bitrange'
+  - 'for_each_clear_bitrange_from'
+  - 'for_each_cmd'
+  - 'for_each_cmsghdr'
+  - 'for_each_collection'
+  - 'for_each_comp_order'
+  - 'for_each_compatible_node'
+  - 'for_each_component_dais'
+  - 'for_each_component_dais_safe'
+  - 'for_each_conduit'
+  - 'for_each_console'
+  - 'for_each_console_srcu'
+  - 'for_each_cpu'
+  - 'for_each_cpu_and'
+  - 'for_each_cpu_andnot'
+  - 'for_each_cpu_from'
+  - 'for_each_cpu_or'
+  - 'for_each_cpu_wrap'
+  - 'for_each_dapm_widgets'
+  - 'for_each_dedup_cand'
+  - 'for_each_dev_addr'
+  - 'for_each_dev_scope'
+  - 'for_each_dma_cap_mask'
+  - 'for_each_dpcm_be'
+  - 'for_each_dpcm_be_rollback'
+  - 'for_each_dpcm_be_safe'
+  - 'for_each_dpcm_fe'
+  - 'for_each_drhd_unit'
+  - 'for_each_dss_dev'
+  - 'for_each_efi_memory_desc'
+  - 'for_each_efi_memory_desc_in_map'
+  - 'for_each_element'
+  - 'for_each_element_extid'
+  - 'for_each_element_id'
+  - 'for_each_enabled_cpu'
+  - 'for_each_endpoint_of_node'
+  - 'for_each_event'
+  - 'for_each_event_tps'
+  - 'for_each_evictable_lru'
+  - 'for_each_fib6_node_rt_rcu'
+  - 'for_each_fib6_walker_rt'
+  - 'for_each_file_lock'
+  - 'for_each_free_mem_pfn_range_in_zone_from'
+  - 'for_each_free_mem_range'
+  - 'for_each_free_mem_range_reverse'
+  - 'for_each_func_rsrc'
+  - 'for_each_gpiochip_node'
+  - 'for_each_group_evsel'
+  - 'for_each_group_evsel_head'
+  - 'for_each_group_member'
+  - 'for_each_group_member_head'
+  - 'for_each_hstate'
+  - 'for_each_hwgpio'
+  - 'for_each_hwgpio_in_range'
+  - 'for_each_if'
+  - 'for_each_inject_fn'
+  - 'for_each_insn'
+  - 'for_each_insn_op_loc'
+  - 'for_each_insn_prefix'
+  - 'for_each_intid'
+  - 'for_each_iommu'
+  - 'for_each_ip_tunnel_rcu'
+  - 'for_each_irq_desc'
+  - 'for_each_irq_nr'
+  - 'for_each_lang'
+  - 'for_each_link_ch_maps'
+  - 'for_each_link_codecs'
+  - 'for_each_link_cpus'
+  - 'for_each_link_platforms'
+  - 'for_each_lru'
+  - 'for_each_matching_node'
+  - 'for_each_matching_node_and_match'
+  - 'for_each_media_entity_data_link'
+  - 'for_each_mem_pfn_range'
+  - 'for_each_mem_range'
+  - 'for_each_mem_range_rev'
+  - 'for_each_mem_region'
+  - 'for_each_member'
+  - 'for_each_memory'
+  - 'for_each_migratetype_order'
+  - 'for_each_missing_reg'
+  - 'for_each_mle_subelement'
+  - 'for_each_mod_mem_type'
+  - 'for_each_mon_capable_rdt_resource'
+  - 'for_each_mp_bvec'
+  - 'for_each_net'
+  - 'for_each_net_continue_reverse'
+  - 'for_each_net_rcu'
+  - 'for_each_netdev'
+  - 'for_each_netdev_continue'
+  - 'for_each_netdev_continue_rcu'
+  - 'for_each_netdev_continue_reverse'
+  - 'for_each_netdev_dump'
+  - 'for_each_netdev_feature'
+  - 'for_each_netdev_in_bond_rcu'
+  - 'for_each_netdev_rcu'
+  - 'for_each_netdev_reverse'
+  - 'for_each_netdev_safe'
+  - 'for_each_new_connector_in_state'
+  - 'for_each_new_crtc_in_state'
+  - 'for_each_new_mst_mgr_in_state'
+  - 'for_each_new_plane_in_state'
+  - 'for_each_new_plane_in_state_reverse'
+  - 'for_each_new_private_obj_in_state'
+  - 'for_each_new_reg'
+  - 'for_each_nhlt_endpoint'
+  - 'for_each_nhlt_endpoint_fmtcfg'
+  - 'for_each_nhlt_fmtcfg'
+  - 'for_each_node'
+  - 'for_each_node_by_name'
+  - 'for_each_node_by_type'
+  - 'for_each_node_mask'
+  - 'for_each_node_numadist'
+  - 'for_each_node_state'
+  - 'for_each_node_with_cpus'
+  - 'for_each_node_with_property'
+  - 'for_each_nonreserved_multicast_dest_pgid'
+  - 'for_each_numa_hop_mask'
+  - 'for_each_of_allnodes'
+  - 'for_each_of_allnodes_from'
+  - 'for_each_of_cpu_node'
+  - 'for_each_of_graph_port'
+  - 'for_each_of_graph_port_endpoint'
+  - 'for_each_of_pci_range'
+  - 'for_each_old_connector_in_state'
+  - 'for_each_old_crtc_in_state'
+  - 'for_each_old_mst_mgr_in_state'
+  - 'for_each_old_plane_in_state'
+  - 'for_each_old_private_obj_in_state'
+  - 'for_each_oldnew_connector_in_state'
+  - 'for_each_oldnew_crtc_in_state'
+  - 'for_each_oldnew_mst_mgr_in_state'
+  - 'for_each_oldnew_plane_in_state'
+  - 'for_each_oldnew_plane_in_state_reverse'
+  - 'for_each_oldnew_private_obj_in_state'
+  - 'for_each_online_cpu'
+  - 'for_each_online_cpu_wrap'
+  - 'for_each_online_node'
+  - 'for_each_online_pgdat'
+  - 'for_each_or_bit'
+  - 'for_each_page_ext'
+  - 'for_each_path'
+  - 'for_each_pci_bridge'
+  - 'for_each_pci_dev'
+  - 'for_each_pcm_streams'
+  - 'for_each_physmem_range'
+  - 'for_each_populated_zone'
+  - 'for_each_possible_cpu'
+  - 'for_each_possible_cpu_wrap'
+  - 'for_each_present_blessed_reg'
+  - 'for_each_present_cpu'
+  - 'for_each_present_section_nr'
+  - 'for_each_prime_number'
+  - 'for_each_prime_number_from'
+  - 'for_each_probe_cache_entry'
+  - 'for_each_process'
+  - 'for_each_process_thread'
+  - 'for_each_prop_codec_conf'
+  - 'for_each_prop_dai_codec'
+  - 'for_each_prop_dai_cpu'
+  - 'for_each_prop_dlc_codecs'
+  - 'for_each_prop_dlc_cpus'
+  - 'for_each_prop_dlc_platforms'
+  - 'for_each_property_of_node'
+  - 'for_each_rdt_resource'
+  - 'for_each_reg'
+  - 'for_each_reg_filtered'
+  - 'for_each_reloc'
+  - 'for_each_reloc_from'
+  - 'for_each_requested_gpio'
+  - 'for_each_requested_gpio_in_range'
+  - 'for_each_reserved_child_of_node'
+  - 'for_each_reserved_mem_range'
+  - 'for_each_reserved_mem_region'
+  - 'for_each_rtd_ch_maps'
+  - 'for_each_rtd_codec_dais'
+  - 'for_each_rtd_components'
+  - 'for_each_rtd_cpu_dais'
+  - 'for_each_rtd_dais'
+  - 'for_each_rtd_dais_reverse'
+  - 'for_each_sband_iftype_data'
+  - 'for_each_script'
+  - 'for_each_sec'
+  - 'for_each_set_bit'
+  - 'for_each_set_bit_from'
+  - 'for_each_set_bit_wrap'
+  - 'for_each_set_bitrange'
+  - 'for_each_set_bitrange_from'
+  - 'for_each_set_clump8'
+  - 'for_each_sg'
+  - 'for_each_sg_dma_page'
+  - 'for_each_sg_page'
+  - 'for_each_sgtable_dma_page'
+  - 'for_each_sgtable_dma_sg'
+  - 'for_each_sgtable_page'
+  - 'for_each_sgtable_sg'
+  - 'for_each_sibling_event'
+  - 'for_each_sta_active_link'
+  - 'for_each_subelement'
+  - 'for_each_subelement_extid'
+  - 'for_each_subelement_id'
+  - 'for_each_sublist'
+  - 'for_each_subsystem'
+  - 'for_each_suite'
+  - 'for_each_supported_activate_fn'
+  - 'for_each_supported_inject_fn'
+  - 'for_each_sym'
+  - 'for_each_thread'
+  - 'for_each_token'
+  - 'for_each_unicast_dest_pgid'
+  - 'for_each_valid_link'
+  - 'for_each_vif_active_link'
+  - 'for_each_vma'
+  - 'for_each_vma_range'
+  - 'for_each_vsi'
+  - 'for_each_wakeup_source'
+  - 'for_each_zone'
+  - 'for_each_zone_zonelist'
+  - 'for_each_zone_zonelist_nodemask'
+  - 'func_for_each_insn'
+  - 'fwnode_for_each_available_child_node'
+  - 'fwnode_for_each_child_node'
+  - 'fwnode_for_each_parent_node'
+  - 'fwnode_graph_for_each_endpoint'
+  - 'gadget_for_each_ep'
+  - 'genradix_for_each'
+  - 'genradix_for_each_from'
+  - 'genradix_for_each_reverse'
+  - 'hash_for_each'
+  - 'hash_for_each_possible'
+  - 'hash_for_each_possible_rcu'
+  - 'hash_for_each_possible_rcu_notrace'
+  - 'hash_for_each_possible_safe'
+  - 'hash_for_each_rcu'
+  - 'hash_for_each_safe'
+  - 'hashmap__for_each_entry'
+  - 'hashmap__for_each_entry_safe'
+  - 'hashmap__for_each_key_entry'
+  - 'hashmap__for_each_key_entry_safe'
+  - 'hctx_for_each_ctx'
+  - 'hists__for_each_format'
+  - 'hists__for_each_sort_list'
+  - 'hlist_bl_for_each_entry'
+  - 'hlist_bl_for_each_entry_rcu'
+  - 'hlist_bl_for_each_entry_safe'
+  - 'hlist_for_each'
+  - 'hlist_for_each_entry'
+  - 'hlist_for_each_entry_continue'
+  - 'hlist_for_each_entry_continue_rcu'
+  - 'hlist_for_each_entry_continue_rcu_bh'
+  - 'hlist_for_each_entry_from'
+  - 'hlist_for_each_entry_from_rcu'
+  - 'hlist_for_each_entry_rcu'
+  - 'hlist_for_each_entry_rcu_bh'
+  - 'hlist_for_each_entry_rcu_notrace'
+  - 'hlist_for_each_entry_safe'
+  - 'hlist_for_each_entry_srcu'
+  - 'hlist_for_each_safe'
+  - 'hlist_nulls_for_each_entry'
+  - 'hlist_nulls_for_each_entry_from'
+  - 'hlist_nulls_for_each_entry_rcu'
+  - 'hlist_nulls_for_each_entry_safe'
+  - 'i3c_bus_for_each_i2cdev'
+  - 'i3c_bus_for_each_i3cdev'
+  - 'idr_for_each_entry'
+  - 'idr_for_each_entry_continue'
+  - 'idr_for_each_entry_continue_ul'
+  - 'idr_for_each_entry_ul'
+  - 'iio_for_each_active_channel'
+  - 'in_dev_for_each_ifa_rcu'
+  - 'in_dev_for_each_ifa_rtnl'
+  - 'in_dev_for_each_ifa_rtnl_net'
+  - 'inet_bind_bucket_for_each'
+  - 'interval_tree_for_each_span'
+  - 'intlist__for_each_entry'
+  - 'intlist__for_each_entry_safe'
+  - 'kcore_copy__for_each_phdr'
+  - 'key_for_each'
+  - 'key_for_each_safe'
+  - 'klp_for_each_func'
+  - 'klp_for_each_func_safe'
+  - 'klp_for_each_func_static'
+  - 'klp_for_each_object'
+  - 'klp_for_each_object_safe'
+  - 'klp_for_each_object_static'
+  - 'kunit_suite_for_each_test_case'
+  - 'kvm_for_each_memslot'
+  - 'kvm_for_each_memslot_in_gfn_range'
+  - 'kvm_for_each_vcpu'
+  - 'libbpf_nla_for_each_attr'
+  - 'list_for_each'
+  - 'list_for_each_codec'
+  - 'list_for_each_codec_safe'
+  - 'list_for_each_continue'
+  - 'list_for_each_entry'
+  - 'list_for_each_entry_continue'
+  - 'list_for_each_entry_continue_rcu'
+  - 'list_for_each_entry_continue_reverse'
+  - 'list_for_each_entry_from'
+  - 'list_for_each_entry_from_rcu'
+  - 'list_for_each_entry_from_reverse'
+  - 'list_for_each_entry_lockless'
+  - 'list_for_each_entry_rcu'
+  - 'list_for_each_entry_reverse'
+  - 'list_for_each_entry_safe'
+  - 'list_for_each_entry_safe_continue'
+  - 'list_for_each_entry_safe_from'
+  - 'list_for_each_entry_safe_reverse'
+  - 'list_for_each_entry_srcu'
+  - 'list_for_each_from'
+  - 'list_for_each_prev'
+  - 'list_for_each_prev_safe'
+  - 'list_for_each_rcu'
+  - 'list_for_each_safe'
+  - 'llist_for_each'
+  - 'llist_for_each_entry'
+  - 'llist_for_each_entry_safe'
+  - 'llist_for_each_safe'
+  - 'lwq_for_each_safe'
+  - 'map__for_each_symbol'
+  - 'map__for_each_symbol_by_name'
+  - 'mas_for_each'
+  - 'mas_for_each_rev'
+  - 'mci_for_each_dimm'
+  - 'media_device_for_each_entity'
+  - 'media_device_for_each_intf'
+  - 'media_device_for_each_link'
+  - 'media_device_for_each_pad'
+  - 'media_entity_for_each_pad'
+  - 'media_pipeline_for_each_entity'
+  - 'media_pipeline_for_each_pad'
+  - 'mlx5_lag_for_each_peer_mdev'
+  - 'mptcp_for_each_subflow'
+  - 'msi_domain_for_each_desc'
+  - 'msi_for_each_desc'
+  - 'mt_for_each'
+  - 'nanddev_io_for_each_block'
+  - 'nanddev_io_for_each_page'
+  - 'neigh_for_each_in_bucket'
+  - 'neigh_for_each_in_bucket_rcu'
+  - 'neigh_for_each_in_bucket_safe'
+  - 'netdev_for_each_lower_dev'
+  - 'netdev_for_each_lower_private'
+  - 'netdev_for_each_lower_private_rcu'
+  - 'netdev_for_each_mc_addr'
+  - 'netdev_for_each_synced_mc_addr'
+  - 'netdev_for_each_synced_uc_addr'
+  - 'netdev_for_each_uc_addr'
+  - 'netdev_for_each_upper_dev_rcu'
+  - 'netdev_hw_addr_list_for_each'
+  - 'nft_rule_for_each_expr'
+  - 'nla_for_each_attr'
+  - 'nla_for_each_attr_type'
+  - 'nla_for_each_nested'
+  - 'nla_for_each_nested_type'
+  - 'nlmsg_for_each_attr'
+  - 'nlmsg_for_each_msg'
+  - 'nr_neigh_for_each'
+  - 'nr_neigh_for_each_safe'
+  - 'nr_node_for_each'
+  - 'nr_node_for_each_safe'
+  - 'of_for_each_phandle'
+  - 'of_property_for_each_string'
+  - 'of_property_for_each_u32'
+  - 'pci_bus_for_each_resource'
+  - 'pci_dev_for_each_resource'
+  - 'pcl_for_each_chunk'
+  - 'pcl_for_each_segment'
+  - 'pcm_for_each_format'
+  - 'perf_config_items__for_each_entry'
+  - 'perf_config_sections__for_each_entry'
+  - 'perf_config_set__for_each_entry'
+  - 'perf_cpu_map__for_each_cpu'
+  - 'perf_cpu_map__for_each_cpu_skip_any'
+  - 'perf_cpu_map__for_each_idx'
+  - 'perf_evlist__for_each_entry'
+  - 'perf_evlist__for_each_entry_reverse'
+  - 'perf_evlist__for_each_entry_safe'
+  - 'perf_evlist__for_each_evsel'
+  - 'perf_evlist__for_each_mmap'
+  - 'perf_evsel_for_each_per_thread_period_safe'
+  - 'perf_hpp_list__for_each_format'
+  - 'perf_hpp_list__for_each_format_safe'
+  - 'perf_hpp_list__for_each_sort_list'
+  - 'perf_hpp_list__for_each_sort_list_safe'
+  - 'plist_for_each'
+  - 'plist_for_each_continue'
+  - 'plist_for_each_entry'
+  - 'plist_for_each_entry_continue'
+  - 'plist_for_each_entry_safe'
+  - 'plist_for_each_safe'
+  - 'pnp_for_each_card'
+  - 'pnp_for_each_dev'
+  - 'protocol_for_each_card'
+  - 'protocol_for_each_dev'
+  - 'queue_for_each_hw_ctx'
+  - 'radix_tree_for_each_slot'
+  - 'radix_tree_for_each_tagged'
+  - 'rb_for_each'
+  - 'rbtree_postorder_for_each_entry_safe'
+  - 'rdma_for_each_block'
+  - 'rdma_for_each_port'
+  - 'rdma_umem_for_each_dma_block'
+  - 'resource_list_for_each_entry'
+  - 'resource_list_for_each_entry_safe'
+  - 'rhl_for_each_entry_rcu'
+  - 'rhl_for_each_rcu'
+  - 'rht_for_each'
+  - 'rht_for_each_entry'
+  - 'rht_for_each_entry_from'
+  - 'rht_for_each_entry_rcu'
+  - 'rht_for_each_entry_rcu_from'
+  - 'rht_for_each_entry_safe'
+  - 'rht_for_each_from'
+  - 'rht_for_each_rcu'
+  - 'rht_for_each_rcu_from'
+  - 'rq_for_each_bvec'
+  - 'rq_for_each_segment'
+  - 'rq_list_for_each'
+  - 'rq_list_for_each_safe'
+  - 'sample_read_group__for_each'
+  - 'scsi_for_each_prot_sg'
+  - 'scsi_for_each_sg'
+  - 'sctp_for_each_hentry'
+  - 'sctp_skb_for_each'
+  - 'sec_for_each_insn'
+  - 'sec_for_each_insn_continue'
+  - 'sec_for_each_insn_from'
+  - 'sec_for_each_sym'
+  - 'shdma_for_each_chan'
+  - 'shost_for_each_device'
+  - 'sk_for_each'
+  - 'sk_for_each_bound'
+  - 'sk_for_each_bound_safe'
+  - 'sk_for_each_entry_offset_rcu'
+  - 'sk_for_each_from'
+  - 'sk_for_each_rcu'
+  - 'sk_for_each_safe'
+  - 'sk_nulls_for_each'
+  - 'sk_nulls_for_each_from'
+  - 'sk_nulls_for_each_rcu'
+  - 'snd_array_for_each'
+  - 'snd_pcm_group_for_each_entry'
+  - 'snd_soc_dapm_widget_for_each_path'
+  - 'snd_soc_dapm_widget_for_each_path_safe'
+  - 'snd_soc_dapm_widget_for_each_sink_path'
+  - 'snd_soc_dapm_widget_for_each_source_path'
+  - 'sparsebit_for_each_set_range'
+  - 'strlist__for_each_entry'
+  - 'strlist__for_each_entry_safe'
+  - 'sym_for_each_insn'
+  - 'sym_for_each_insn_continue_reverse'
+  - 'symbols__for_each_entry'
+  - 'tb_property_for_each'
+  - 'tcf_act_for_each_action'
+  - 'tcf_exts_for_each_action'
+  - 'test_suite__for_each_test_case'
+  - 'tool_pmu__for_each_event'
+  - 'ttm_bo_lru_for_each_reserved_guarded'
+  - 'ttm_resource_manager_for_each_res'
+  - 'udp_lrpa_for_each_entry_rcu'
+  - 'udp_portaddr_for_each_entry'
+  - 'udp_portaddr_for_each_entry_rcu'
+  - 'usb_hub_for_each_child'
+  - 'v4l2_device_for_each_subdev'
+  - 'v4l2_m2m_for_each_dst_buf'
+  - 'v4l2_m2m_for_each_dst_buf_safe'
+  - 'v4l2_m2m_for_each_src_buf'
+  - 'v4l2_m2m_for_each_src_buf_safe'
+  - 'virtio_device_for_each_vq'
+  - 'vkms_config_for_each_connector'
+  - 'vkms_config_for_each_crtc'
+  - 'vkms_config_for_each_encoder'
+  - 'vkms_config_for_each_plane'
+  - 'vkms_config_connector_for_each_possible_encoder'
+  - 'vkms_config_encoder_for_each_possible_crtc'
+  - 'vkms_config_plane_for_each_possible_crtc'
+  - 'while_for_each_ftrace_op'
+  - 'workloads__for_each'
+  - 'xa_for_each'
+  - 'xa_for_each_marked'
+  - 'xa_for_each_range'
+  - 'xa_for_each_start'
+  - 'xas_for_each'
+  - 'xas_for_each_conflict'
+  - 'xas_for_each_marked'
+  - 'xbc_array_for_each_value'
+  - 'xbc_for_each_key_value'
+  - 'xbc_node_for_each_array_value'
+  - 'xbc_node_for_each_child'
+  - 'xbc_node_for_each_key_value'
+  - 'xbc_node_for_each_subkey'
+  - 'ynl_attr_for_each'
+  - 'ynl_attr_for_each_nested'
+  - 'ynl_attr_for_each_payload'
+  - 'zorro_for_each_dev'
+
+IncludeBlocks: Preserve
+IncludeCategories:
+  - Regex: '.*'
+    Priority: 1
+IncludeIsMainRegex: '(Test)?$'
+IndentCaseLabels: false
+IndentGotoLabels: false
+IndentPPDirectives: None
+IndentWidth: 8
+IndentWrappedFunctionNames: false
+JavaScriptQuotes: Leave
+JavaScriptWrapImports: true
+KeepEmptyLinesAtTheStartOfBlocks: false
+MacroBlockBegin: ''
+MacroBlockEnd: ''
+MaxEmptyLinesToKeep: 1
+NamespaceIndentation: None
+ObjCBinPackProtocolList: Auto
+ObjCBlockIndentWidth: 8
+ObjCSpaceAfterProperty: true
+ObjCSpaceBeforeProtocolList: true
+
+# Taken from git's rules
+PenaltyBreakAssignment: 10
+PenaltyBreakBeforeFirstCallParameter: 30
+PenaltyBreakComment: 10
+PenaltyBreakFirstLessLess: 0
+PenaltyBreakString: 10
+PenaltyExcessCharacter: 100
+PenaltyReturnTypeOnItsOwnLine: 60
+
+PointerAlignment: Right
+ReflowComments: false
+SortIncludes: false
+SortUsingDeclarations: false
+SpaceAfterCStyleCast: false
+SpaceAfterTemplateKeyword: true
+SpaceBeforeAssignmentOperators: true
+SpaceBeforeCtorInitializerColon: true
+SpaceBeforeInheritanceColon: true
+SpaceBeforeParens: ControlStatementsExceptForEachMacros
+SpaceBeforeRangeBasedForLoopColon: true
+SpaceInEmptyParentheses: false
+SpacesBeforeTrailingComments: 1
+SpacesInAngles: false
+SpacesInContainerLiterals: false
+SpacesInCStyleCastParentheses: false
+SpacesInParentheses: false
+SpacesInSquareBrackets: false
+Standard: Cpp03
+TabWidth: 8
+UseTab: Always
+...
diff --git a/.gitignore b/.gitignore
index 6d85b3aa238..fa2db08dead 100644
--- a/.gitignore
+++ b/.gitignore
@@ -58,6 +58,7 @@ fit-dtb.blob*
 #
 # We don't want to ignore the following even if they are dot-files
 #
+!.clang-format
 !.get_maintainer.*
 !.gitattributes
 !.gitignore
-- 
2.51.0

