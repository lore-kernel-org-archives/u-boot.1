Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16AC1C47073
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 10:36:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A052B87AB2;
	Wed, 10 Jan 2024 11:36:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lf2vSiFA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 534F087A7B; Wed, 10 Jan 2024 11:36:30 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4916187A7F
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 11:36:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d44200b976so20897585ad.2
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 02:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704882984; x=1705487784; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X0Y8Nm6SxspwtBtpuDp0RvA2ZrL2DZZ90fWjbGeTz88=;
 b=lf2vSiFA05h5IxEOHW8yACwU5imBgEClifeMVXcCy3T01c4rZlv8f/DkD62H2lHUQ+
 RFJxCEuIr/1ZLwbE2pogaR+JJMTBia90iXZjm6UMxWCSIeyObzs18PHv0Wf8B2ozkEbR
 xbolyzha8LzI4GFZsljUdTvQgK92F0nPEED7gZdtTu8BOEmNq5VNQ2kEcG6+g4YOe1Fx
 JctICoDg4V2mf8P9BOSfMa3MIAX+ZH91QRFkwbcRDZ+zLR8KCDTtN/T0ghScQWE3jcFB
 yzpulipYBI2LKL90IJJPeuMPN4C9NH/cQRkuDQ9tzXesDDKH7OusAzf0H4gzIMP6Qr0E
 MpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704882984; x=1705487784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X0Y8Nm6SxspwtBtpuDp0RvA2ZrL2DZZ90fWjbGeTz88=;
 b=ryTeixIk1oUaQ+jkezlKXo9sCrcQxfdY2vMlAqrDGgVKAeLTWchWPSpoPZiBGQdJ0l
 oBo1IHkvxGphKnn7T5iCkjYE/j6L6DrNOaTIbPOQku0S4jM3ze2OBPS3kOHhY3Id3Ji6
 CNvRJxCP3Ozh5PAymqDJCtD3VvMoVdn9NBLaIoD94tJ/q9U+8KYU6b+cU0+svQFdhInk
 1vldbA1yy4+5T6O6s9j9kAyX68UGZRcr6EXLXwifupPxPcTIwbvQmmCxx3OLVKoSj37I
 jL+is6q00smJFS/UUNtoPvb/FUTpiXPOywK+YepgC0Y+1JpMJEVVcS5+sHjqaTpTQdYP
 KfQQ==
X-Gm-Message-State: AOJu0Yw3SaveECpYKwVBSXyIh2P23Kj+CS0L92tDi/0c5UxVFrKZ09gz
 bWHiLUWQSCQn/8pags1JPHcmT2Bmr4paGFGiNXe3dK+hj+M=
X-Google-Smtp-Source: AGHT+IE+5J47W5lZfE7xWqj1qlgRhJ1PZVfoUK5zUxAWxst7LRSQz2eqoV+Z/kXlGgSFIh+s+4bn3w==
X-Received: by 2002:a17:902:7c8f:b0:1d4:3872:30a2 with SMTP id
 y15-20020a1709027c8f00b001d4387230a2mr575449pll.57.1704882984435; 
 Wed, 10 Jan 2024 02:36:24 -0800 (PST)
Received: from sumit-X1.. ([223.178.208.66]) by smtp.gmail.com with ESMTPSA id
 i7-20020a17090332c700b001d38a7e6a30sm3332604plr.70.2024.01.10.02.36.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 02:36:24 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org,
 b.galvani@gmail.com, xypron.glpk@gmx.de, michal.simek@amd.com,
 seanga2@gmail.com, rasmus.villemoes@prevas.dk, peng.fan@nxp.com,
 jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de,
 mibodhi@gmail.com, bb@ti.com, mark.kettenis@xs4all.nl,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 02/11] Makefile: Add support for DT bindings schema checks
Date: Wed, 10 Jan 2024 16:05:38 +0530
Message-Id: <20240110103547.719757-3-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110103547.719757-1-sumit.garg@linaro.org>
References: <20240110103547.719757-1-sumit.garg@linaro.org>
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

This adds the build infrastructure for checking DT binding schema
documents and validating dtb files using the binding schema. Here we use
devicetree-rebasing subtree to provide the DT bindings. Along with that
adapt dts/upstream/Bindings/Makefile to align with old U-Boot Kbuild
infrastructure.

Dependency:
-----------

The DT schema project must be installed in order to validate the DT schema
binding documents and validate DTS files using the DT schema. The DT schema
project can be installed with pip::

    pip3 install dtschema

Note that 'dtschema' installation requires 'swig' and Python development
files installed first. On Debian/Ubuntu systems::

    apt install swig python3-dev

Testing:
--------

Build dts files and check using DT binding schema:
$ make dtbs_check

Optionally, DT_SCHEMA_FILES can be passed in with a schema file(s) to
use for validation. This makes it easier to find and fix errors
generated by a specific schema.

Note, at this point dtbs_check is an optional build target as there are
many warnings generated due to custom DT properties used by many
platforms in u-boot. It is expected with these checks that compliance
with DT bindings to take place. Once that's done it can be added to CI
builds to remain compliant with DT bindings.

Reviewed-by: Simon Glass <sjg@chromium.org>
Tested-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v4:
- Switched subtree to be imported as dts/upstream sub-directory rather
  than devicetree-rebasing sub-directory to better suite U-Boot
  directory structure.
- Incorporate build fix to adjust Bindings Makefile rules to old U-Boot
  Kbuild infrastructure.

Changes in v3:
- None

Changes in v2:
- None

 Makefile                       | 20 ++++++++++++++++++--
 dts/upstream/Bindings/Makefile |  6 +++---
 scripts/Makefile.lib           | 17 +++++++++++++++--
 3 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index a519397ef71..69cffb16ee2 100644
--- a/Makefile
+++ b/Makefile
@@ -1158,12 +1158,28 @@ endif
 	@# disabling OF_BOARD.
 	$(call cmd,ofcheck,$(KCONFIG_CONFIG))
 
-PHONY += dtbs
+PHONY += dtbs dtbs_check
 dtbs: dts/dt.dtb
 	@:
-dts/dt.dtb: u-boot
+dts/dt.dtb: dtbs_prepare u-boot
 	$(Q)$(MAKE) $(build)=dts dtbs
 
+dtbs_prepare: prepare3
+
+ifneq ($(filter dtbs_check, $(MAKECMDGOALS)),)
+export CHECK_DTBS=y
+endif
+
+ifneq ($(CHECK_DTBS),)
+dtbs_prepare: dt_binding_check
+endif
+
+dtbs_check: dt_binding_check dtbs
+
+DT_BINDING_DIR := dts/upstream/Bindings
+dt_binding_check: scripts_dtc
+	$(Q)$(MAKE) $(build)=$(DT_BINDING_DIR) $(DT_BINDING_DIR)/processed-schema.json
+
 quiet_cmd_copy = COPY    $@
       cmd_copy = cp $< $@
 
diff --git a/dts/upstream/Bindings/Makefile b/dts/upstream/Bindings/Makefile
index 3e886194b04..e799963a599 100644
--- a/dts/upstream/Bindings/Makefile
+++ b/dts/upstream/Bindings/Makefile
@@ -47,9 +47,9 @@ quiet_cmd_mk_schema = SCHEMA  $@
 		      rm -f $$f
 
 define rule_chkdt
-	$(if $(DT_SCHEMA_LINT),$(call cmd,yamllint),)
-	$(call cmd,chk_bindings)
-	$(call cmd,mk_schema)
+	$(if $(DT_SCHEMA_LINT),$(call echo-cmd,yamllint) $(cmd_yamllint),); \
+	$(call echo-cmd,chk_bindings) $(cmd_chk_bindings); \
+	$(call echo-cmd,mk_schema) $(cmd_mk_schema)
 endef
 
 DT_DOCS = $(patsubst $(srctree)/%,%,$(shell $(find_all_cmd)))
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 1ca84195c99..f82b3169e87 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -356,8 +356,21 @@ endif
 
 dtsi_include_list_deps = $(addprefix $(obj)/,$(subst $(quote),,$(dtsi_include_list)))
 
-$(obj)/%.dtb: $(src)/%.dts $(DTC) $(dtsi_include_list_deps) FORCE
-	$(call if_changed_dep,dtc)
+ifneq ($(CHECK_DTBS),)
+DT_CHECKER ?= dt-validate
+DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),-l $(DT_SCHEMA_FILES),-m)
+DT_BINDING_DIR := dts/upstream/Bindings
+DT_TMP_SCHEMA := $(objtree)/$(DT_BINDING_DIR)/processed-schema.json
+
+quiet_cmd_dtb = DTC_CHK $@
+      cmd_dtb = $(cmd_dtc) ; $(DT_CHECKER) $(DT_CHECKER_FLAGS) -u $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@ || true
+else
+quiet_cmd_dtb = $(quiet_cmd_dtc)
+      cmd_dtb = $(cmd_dtc)
+endif
+
+$(obj)/%.dtb: $(src)/%.dts $(DTC) $(dtsi_include_list_deps) $(DT_TMP_SCHEMA) FORCE
+	$(call if_changed_dep,dtb)
 
 pre-tmp = $(subst $(comma),_,$(dot-target).pre.tmp)
 dtc-tmp = $(subst $(comma),_,$(dot-target).dts.tmp)
-- 
2.34.1

