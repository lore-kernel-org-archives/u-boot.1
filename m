Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2915EC46CD2
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 06:12:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53368877C8;
	Fri, 22 Dec 2023 07:12:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Y5+t2DJq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C4BF877D7; Fri, 22 Dec 2023 07:12:48 +0100 (CET)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72839877C8
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 07:12:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6d939e2f594so1443717b3a.3
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 22:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703225562; x=1703830362; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u1OsPqfGmFH05ZPKbNH4dIRe46agPWiUEln2hoUy/k4=;
 b=Y5+t2DJqxxPbzZ3bl5YtUDePE+qmpYcZccWy3hZSjjRNJkRXBMGLNaCc4H8Z7h+SaB
 tBdUL8UBN3SKoEQOXexP6q/pJaZwu1TEpKg9Y8FcUdGoH8C19ozXZP9je6XBLLQj8GQ+
 3fLO9yYdDZkiJR3wDRmUCJO0xyMmDW22N70YCZPTu+WfpWZP0bwIlL/Orf39VrlSqpc/
 p9nhdhoAgJGlYsrhLu84/Txv+7oqTqea3r2ObB9tOF5e7ncz6qtYV1ubqjQcx5Mhs7BL
 ot0KkQxKHJ5h7u8NusArRmIk76mzgfLA8Ze0L2SHUggK9Cf3XarhShdrTnFZzoTMSdXy
 PJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703225562; x=1703830362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u1OsPqfGmFH05ZPKbNH4dIRe46agPWiUEln2hoUy/k4=;
 b=pGxDc4nGksno29ktFIzF8b7WXxWlT06IwU8zzgb+lss8i4r4boCFl5Ocp18vOV5m7O
 CNNumJcnyQ1G8/YndheO67DPMQAOeHk3vrihq7bsZAGuj494er75bHJgyB0bKxS3t1Ss
 8Qdu6BNJap4C4XclWt66MMyTF+j27sQbiRrWcGZ1Sqws+1DlUd0kgDvbWRMk/Fs0XLEu
 2O4999NtRhdrMl/UDz32b+Y5S14hMTlbMxAYtjNf7R3T7Y23I6tw9Q7mN+EkImVvdt6O
 nGNu5ReJDUHgpE8urq1EU9jdGiHUtWEZ+hhcBpEA4lmfj3Oyu0JbPW61iEwmtJa4OAYG
 qdIg==
X-Gm-Message-State: AOJu0Yx8rzYwYvvgu0xmFzrA5Smv9RMFqR2EgqOGdHmyqwcSoqyN4glR
 Yqi9qsKNibmS5OjC1ohYs19/20Hs3bzwF6FFNLOaufeqz5j3lA==
X-Google-Smtp-Source: AGHT+IHQvlgh8ng+qvJnK83Y/Bmv2Z72FaXl1DjCfrj+IJMSLgbdR+lzBC9ajEB/hWQOSM2rARzD/A==
X-Received: by 2002:a05:6a00:464a:b0:6d9:396d:730b with SMTP id
 kp10-20020a056a00464a00b006d9396d730bmr912889pfb.27.1703225562536; 
 Thu, 21 Dec 2023 22:12:42 -0800 (PST)
Received: from sumit-X1.. ([223.178.212.219]) by smtp.gmail.com with ESMTPSA id
 h6-20020aa79f46000000b006ce835b77d9sm2602883pfr.20.2023.12.21.22.12.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 22:12:42 -0800 (PST)
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
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 2/8] Makefile: Add support for DT bindings schema checks
Date: Fri, 22 Dec 2023 11:42:02 +0530
Message-Id: <20231222061208.3009970-3-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231222061208.3009970-1-sumit.garg@linaro.org>
References: <20231222061208.3009970-1-sumit.garg@linaro.org>
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
devicetree-rebasing directory to provide the DT bindings.

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

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 Makefile             | 20 ++++++++++++++++++--
 scripts/Makefile.lib | 17 +++++++++++++++--
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 750bbdb1b71..d8d168cd4c3 100644
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
+DT_BINDING_DIR := devicetree-rebasing/Bindings
+dt_binding_check: scripts_dtc
+	$(Q)$(MAKE) $(build)=$(DT_BINDING_DIR) $(DT_BINDING_DIR)/processed-schema.json
+
 quiet_cmd_copy = COPY    $@
       cmd_copy = cp $< $@
 
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 16bbc277a9f..27b9437027c 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -356,8 +356,21 @@ endif
 
 dtsi_include_list_deps = $(addprefix $(obj)/,$(subst $(quote),,$(dtsi_include_list)))
 
-$(obj)/%.dtb: $(src)/%.dts $(DTC) $(dtsi_include_list_deps) FORCE
-	$(call if_changed_dep,dtc)
+ifneq ($(CHECK_DTBS),)
+DT_CHECKER ?= dt-validate
+DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),-l $(DT_SCHEMA_FILES),-m)
+DT_BINDING_DIR := devicetree-rebasing/Bindings
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

