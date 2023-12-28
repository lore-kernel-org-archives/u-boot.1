Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E27C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 11:58:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E77187A0B;
	Thu, 28 Dec 2023 12:58:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DxBoE7CZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2BE287A07; Thu, 28 Dec 2023 12:58:47 +0100 (CET)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 191FE87A05
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 12:58:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5c239897895so1777619a12.2
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 03:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703764723; x=1704369523; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iDPS55DFd0c8Rb3rEcH+LRja5l5dvTmJa9ZgRbve2Rc=;
 b=DxBoE7CZLyejDMrsEnoCq9/7YqtZ6ECCF61lkFtuW0hJJf2rcjFXJXVs6au+r24BVk
 vEDiJUZ/AAHLEXUnd9lj58swZdUeTYThyYTCVRzyAAiKr+aGdoVJV9EJX524ngJTe1Po
 erW21YROIQheATtVs/aKgzDzq75txMsjcSe7SVdXhZCIqf+lfQHwEu0S1HLbagw//twy
 dntmHPtn5LMZ6WStH2UCunhAg04jjdMEHrVeiU+24KWeeWiTOUGPgLCluKEYXpIVEAhk
 YSHX02eKz2Pkxq2Wx3ukJavO5Nw9TSPWWtHkGG/1bDTyCNyapnTVCO18rZlgbqc+DBiR
 kEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703764723; x=1704369523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iDPS55DFd0c8Rb3rEcH+LRja5l5dvTmJa9ZgRbve2Rc=;
 b=hRWM2oWTQ8IB7XZCTYEwmQBiBLvs0InRV6YSodhXt3aP5DqIw9zHOQ0/f/savNj1fP
 PwJJW+YrRg0snl7+NdJj0+DeVmSyUz37xt9tYhyelJCU7Q3tx8G9QuI91rUFPOZMPPrZ
 noF4JK79oLBw18s6tGP7JAgopPpBa1/hX+DFg9yW21rPf7PkogvOHWEuc0XCi0Ob+GgW
 eylU4UbnDJ3CxRvx0iSk1u7WVNbIIGknmt/l4QZ+unUW9xjbICsXKZ83BaxM2D/kyZ31
 eyNsJUQqz2kAJ3xhNrUzFoBHxL40xCeC5WCZJ4/F//C3dD0Cm/9Yf0Q46MhXuXME/FY7
 rirw==
X-Gm-Message-State: AOJu0YzNxzsDd4qioJyndUA4ze7cGsnMd7IpxBJmHY8ElquN8pwP7X6Y
 bMvcWj2XsUUM4Xqff0WuET9VaQnkcEb55kakOwLa2tWf7DF5QA==
X-Google-Smtp-Source: AGHT+IFknfFK4DxHGi4VZ9OBEQWoEqVOP3Ebnhx3FOf+JQd1uBV6f7pvdteVYwjCfYSK7aeEwn3R6A==
X-Received: by 2002:a05:6a21:a58c:b0:196:47b1:9a34 with SMTP id
 gd12-20020a056a21a58c00b0019647b19a34mr649619pzc.56.1703764723185; 
 Thu, 28 Dec 2023 03:58:43 -0800 (PST)
Received: from sumit-X1.. ([223.178.209.202]) by smtp.gmail.com with ESMTPSA id
 r4-20020a170902ea4400b001d3f285157dsm13700579plg.124.2023.12.28.03.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 03:58:42 -0800 (PST)
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
 mibodhi@gmail.com, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 2/8] Makefile: Add support for DT bindings schema checks
Date: Thu, 28 Dec 2023 17:27:58 +0530
Message-Id: <20231228115804.3626579-3-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231228115804.3626579-1-sumit.garg@linaro.org>
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
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

Changes in v3:
--------------
- None

Changes in v2:
--------------
- None

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

