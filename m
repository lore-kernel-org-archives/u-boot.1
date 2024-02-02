Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7041CC4828F
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 13:06:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5B9287C9A;
	Fri,  2 Feb 2024 14:06:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YcHt+IHQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF67287CA4; Fri,  2 Feb 2024 14:06:21 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B765687C7A
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 14:06:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d958e0d73dso6187715ad.1
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 05:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706879175; x=1707483975; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U8g6RRoRdXOFs+ZSWxtC9YsX9A3Xm32YH3XAA1dA0hA=;
 b=YcHt+IHQYIEYvISEiuqCY7cS9BVle5yxHDfYg5RKjHWmSU3aI6KFabtMpG1iNZZuzw
 HTrBXVWiFy1Ewi/aIY4mnGbrBD5pwfISgfYUVWwjBq6XtjrpdOSlSIFFj3pg8ubGSct7
 U/O8ij1+KNhP3j4B6z9JQDQbDbCle9N5ccJ1C8mUhoguD/I4+PpdoZXEMgnA+lsUr/dY
 hVk/J5Er44YYb8cN4uJcjSafpjpy5EyG6sMxv4eWKditgmtSQ6mNmip49J8YBWfxxMhX
 xJsUrr5TtYj6B7IE9/qoQXSP5ievdBUgcNVUMmBKsaocX4gWCMyfuOTU71UdxbWhTku3
 +7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706879175; x=1707483975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U8g6RRoRdXOFs+ZSWxtC9YsX9A3Xm32YH3XAA1dA0hA=;
 b=tzAyz3QsuRWtxdfHE8fScStmv+i8wYPRPcFQ59FTkA9Yae9Aq9J8IIqyNgJ6/KZpfr
 PT/SDC/M8CWLofVIH3WLU8yeQHk/f03va1RUpRYmuy7i9AFxA5OOSPDhalq1LWk1fBUY
 rpkwTi4ZvxQwAS28MuoIiWyRG2HYAgohdYS3/cbwqt2QFS4Oybl17OBilXEtKkdUjtwE
 +gDalUDYVFGjYDey2Ib/9pQV9Vs1r2uusKkCkyox6uvgMp5mj9eGhqFf3FU4KB3JIYYg
 Tlco7tCJ1GfucHpo/vMSIz6pYCpsNLrVI6xICDa2eNHCFH6JtD2/P09kClE+Ehha+UHr
 kf7A==
X-Gm-Message-State: AOJu0YyPw1ZrXW6uZYZrnUKk4EquL7seLuANuNmC7laly6ha6BI4Rmem
 QcSHm1gJ3Z+qskSwYiLQAsiVNw5M6S7f3eIDVTzDiiXiI1/GW73r5H+qKaJ9FVVm97frkro7LcS
 vjWA=
X-Google-Smtp-Source: AGHT+IH7Ou6ow9soEPJio/PkfdpHUYdK/ZvNR/+xXdaiCl9VTgKMSgHm3zTD4vSVTTySS90uUHp+cQ==
X-Received: by 2002:a17:902:ea0c:b0:1d9:6c71:19aa with SMTP id
 s12-20020a170902ea0c00b001d96c7119aamr3386984plg.13.1706879175616; 
 Fri, 02 Feb 2024 05:06:15 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVIBRRlDpg9elRWLYWHll4dUe4CQdF7GRppqQ0mylUOs/aCpAEe0E+fivShFUFTSDRAY7rzrit/kTOlZ6kUsdH/0aZzti7ahxRuy8Ju3qwDn8fPPA+D5Y0l37ia+kbbgljT95HJe96LtElFpWrEdVhqGfAM19Mfchs96J63nxfSRWys6uR2WI4QTUqQ/pqa3pjTBFMBtW7oTcZPaXk1cTMF7Z0jXM+e+1w8tju7bYVmfaahplL14+mzBj4Alombzx8OB4CnlnV0dcu07oIOUxcJpCJL9MIR1WVMyLqHJzC8jVAkFCo72AYCozuzHtRhubfX4Gn31sHuTlsV2mWI6cBJ9JsJs5bdmKjQy+5ftX+k5ijJuqmKx0D2X3te2aQ/9BALwRTWl+qQbFRtGvlo8GGyPDKwZY508ZFTh2ImSqbZyYRx/USll/VTepymMeaMgKYlmtm3JQu13jnwoVtMtWCrHo8IJ4DKgScFc4qC7wGVpybdQM0NYcm1DSW56sDsiKaszXbG9gfoXA4xIz3lzqc5/+IPoXxypXdKRSqa1ATomBWEzqsIoL/gcXyFF8Y0sFvsQjSpN4Fi5OSI1AGeJsGlQ/ozjizeJ4rmCeTihpaxVg0oqYL6xD0MoiW/mwiLl6kcHX3l3IHYqAIknY4ab9/bcxXHi9elf2eMxj+8h0KxxVK+NC7zntXy08JJWMgimCk64DXoO+h/eFfQNdOaV+XCPdIelUl0gkZnasZcF6j20BhLdiyisqITvKRvYLQyK4svsJzvYB8X6Ac4HhSkRkVDFyz+m6aHyvIljEHcguOaL8B1446tmNSr/XKy8hM9RJQ2pgwk3po8qsIfpc0h7gsdf8Gl0SEVx2wRFz7OonvKE/HX1tWVj487TZfA7miv/2RBYlxP6Xhfl2BVhzwIFUfv8K/hxpSxy4sI
Received: from sumit-X1.. ([223.178.213.44]) by smtp.gmail.com with ESMTPSA id
 q23-20020a170902edd700b001d923684323sm1542407plk.195.2024.02.02.05.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 05:06:15 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, b.galvani@gmail.com,
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com,
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com,
 rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com, bb@ti.com,
 mark.kettenis@xs4all.nl, festevam@gmail.com, nm@ti.com,
 andre.przywara@arm.com, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 02/11] Makefile: Add support for DT bindings schema checks
Date: Fri,  2 Feb 2024 18:35:25 +0530
Message-Id: <20240202130534.1051438-3-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202130534.1051438-1-sumit.garg@linaro.org>
References: <20240202130534.1051438-1-sumit.garg@linaro.org>
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

Changes in v5:
- None

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
index 3afe314679cd..c7e5e0384af3 100644
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
index 3e886194b043..e799963a599d 100644
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
index 1ca84195c997..f82b3169e874 100644
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

