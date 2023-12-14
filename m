Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB01C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 13:52:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C554287A42;
	Thu, 14 Dec 2023 14:51:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vwcZRWD/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A855787A72; Thu, 14 Dec 2023 14:51:57 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6EC287A76
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 14:51:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d345b187bbso24297045ad.0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 05:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702561912; x=1703166712; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u1OsPqfGmFH05ZPKbNH4dIRe46agPWiUEln2hoUy/k4=;
 b=vwcZRWD/82KtlBuHx+vp41+IupfMcpGej4keWor0NSto2/ukLlAYE6RPeHrwylndZq
 Uad0AiBmJxV+lhW4BkNG+T83F7nmZIegn+oAsDytkR3KT+QOerPFDwJCnuhByxZGmSDe
 UnW23ZEnXdLiNQDWeqFtxPjH3FGzc3Zqv6OQjhOCmwBIg5nyrist7XUcZ+GXqFgqWqpZ
 Uma4GV4YoOXEzre5g5t/4kI4QBtvK500Gvl5N/hSzLzXKvcF0ypQ2GR1siofBGH/ulko
 3L9jHkqzQKSK3j8uCLR1zz3YuPAh5HegBZ31mKalsTbc5GYJJK8Cu1+uTcIcjC+Jym2t
 59qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702561912; x=1703166712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u1OsPqfGmFH05ZPKbNH4dIRe46agPWiUEln2hoUy/k4=;
 b=NTdiebAGSBvDoODzK3mVdt5VH+WL7eyTG5weBlYn8ZWullxkQIulZfgo5kUioLQUKL
 4i7GtDIR9tKGUJ/nZZ4Kyhrn0v2dqen43zXUtUB16AszSYOA1fm8WIevbc2yX4Ctdspm
 pnIkh7EGfaN6r5s92IZ6zkXHi+d8MJejFksjj7F8A4d1xnPz5P+Fc1hpZX9FowAacWDd
 J+gZ4sabeqTNxvBmMO/y2kq9wJT4qxs+JD7SPaSN2VbdnTAEuyy8bIfqMK6yvDwMkLJn
 Z4GeMgOl85REGqTPBIbM7xCU0KsR5dp7ARil+a3kExSa4CNr21hwsPaq04l95lkvXvcd
 r59Q==
X-Gm-Message-State: AOJu0YypVhX+umlIqsbjjrnQenu0rpK81Y5733hHuf4RT9dsBkLaMn9I
 uwfiZyGvp4hJBGObNBRo1OYp1uUC68TtBZMKf0ktww==
X-Google-Smtp-Source: AGHT+IHhR0YSkpu47XWJ+3DVJO3OWFHipEKj3+HBPuTpPgDq5wQAXDjoSp2jk/yLFOln1irbjXuueQ==
X-Received: by 2002:a17:903:2b0f:b0:1d3:44ad:2156 with SMTP id
 mc15-20020a1709032b0f00b001d344ad2156mr5126443plb.2.1702561911882; 
 Thu, 14 Dec 2023 05:51:51 -0800 (PST)
Received: from sumit-X1.. ([223.178.213.6]) by smtp.gmail.com with ESMTPSA id
 j3-20020a170902c08300b001cfc68125desm12474956pld.203.2023.12.14.05.51.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 05:51:51 -0800 (PST)
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
Subject: [PATCH 2/8] Makefile: Add support for DT bindings schema checks
Date: Thu, 14 Dec 2023 19:20:57 +0530
Message-Id: <20231214135103.1606605-3-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214135103.1606605-1-sumit.garg@linaro.org>
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
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

