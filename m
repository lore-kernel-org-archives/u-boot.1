Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A61C5478C
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 11:25:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BE8C880AA;
	Thu, 22 Feb 2024 12:24:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="r70Jktu6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE15B8805F; Thu, 22 Feb 2024 10:36:55 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59CC78807D
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 10:36:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3c15dd2a1fdso3036495b6e.2
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 01:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708594603; x=1709199403; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aGR4wADzfSH9X0XpfjFR/OCL+oRi4FieX+1QxGsZgGE=;
 b=r70Jktu6npHgscmvo1MIwZYN9ovher/K17We26dW5VGOKNVQlNvfUhRgeInfQWsTUy
 v3EPqvUhnKiJRQNTfRQsWMkpsiC4IKxkH5UMyWZoo7VGxxDoLgHPX2iRFppGMQrJY0FS
 FRapBvPKIlfLZWTPtrpmfs1z6r9qTAxF84hEmzar1NJPJohL9gHeLgTewymaHPBdCkCx
 iD2JggA/mA+tDqA7KEWLTvFYPUqSXpbqstplAlThMa9rOFAyivTEqWVmqQSYLaJ3hWRX
 GIgScEWG3lobTMLW5UiuJiPEoCFaTvSExJnCc67rune5uPdc8nXAy5OAFNWzT2mLkvTW
 dfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708594603; x=1709199403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aGR4wADzfSH9X0XpfjFR/OCL+oRi4FieX+1QxGsZgGE=;
 b=MxC8iP14139WFgEj7kCHXG349m2Fd3iLmOV2iefi70oMUhHQgmI+qzX/8QLq1xQIfn
 6Mu54OeMCWrkhZQGYWI02R5C3z+llLXnFp6+2IhxmMLcUG1QFqiFoFWDe/rh3a0BKpqA
 8gb7ACpzYeamx45IhH4bHEnAWeQIkk4Wh1L47ya2NL3rcQ/OCc0jpXTSqyQkjNNJP+D5
 hb0AYh3j12f7LSsIKWsWnWqNQ5KlV+zFsgmyuk1wj0R3v5XaYGmuI6f2B3JG7hOBGEn8
 lbQ+vBMPgclQk8pC5UBD9EtLBbUnOTNbHAPIgHwblhRD8nRqTNSWgYjD4tw2seRHy/em
 /Lhw==
X-Gm-Message-State: AOJu0YzExBW4HBeznKTy8Is3ZRORCRO3Tg5RrPwdDkW2dcDVA/UKn/PC
 RgMbbYhMu6qFCB7tYYuuegdXZzd2xfkXzz1XoO5kDefCeWmWC8a7emH9zXrZoO/F6Bj62p79c2L
 k
X-Google-Smtp-Source: AGHT+IHFKLdpqggYSR+jnGTo5oe68QgNgq6aMjzfNfkbiO0bu59DNffHzt+vhyMW2MbTgnvcbAw0Ew==
X-Received: by 2002:a05:6808:f11:b0:3c1:4b06:7ac2 with SMTP id
 m17-20020a0568080f1100b003c14b067ac2mr16408912oiw.12.1708594603568; 
 Thu, 22 Feb 2024 01:36:43 -0800 (PST)
Received: from sumit-X1.. ([223.178.212.115]) by smtp.gmail.com with ESMTPSA id
 u20-20020a056a00099400b006e47300e4edsm6208404pfg.183.2024.02.22.01.36.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 01:36:43 -0800 (PST)
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
 andre.przywara@arm.com, ijc@hellion.org.uk, paul.barker.ct@bp.renesas.com,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v6 02/11] Makefile: Add support for DT bindings schema checks
Date: Thu, 22 Feb 2024 15:05:58 +0530
Message-Id: <20240222093607.3085545-3-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222093607.3085545-1-sumit.garg@linaro.org>
References: <20240222093607.3085545-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 22 Feb 2024 12:24:08 +0100
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

Changes in v6:
- None

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
index 3b5db90df6f9..9604a4c517e5 100644
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

