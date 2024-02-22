Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74397C48BF8
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 11:26:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03BFB88083;
	Thu, 22 Feb 2024 12:24:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bkwoFSOi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D169387E6F; Thu, 22 Feb 2024 10:36:59 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF82C87E6F
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 10:36:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5a03417ec1bso67479eaf.0
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 01:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708594613; x=1709199413; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/+CQ/xsM2Sv+jdq8dNho3/YaVJZaPCz3kJVYnhGLGRA=;
 b=bkwoFSOi97XN9bEvJYekHgN6+g2IjX8g7gDz7z0+nozIstTw4cVi8RVnjmcJJ6nM2s
 jJTRScaIZCi7J3Hx+4nVQT1UF4/Hoa4a4ZkSHFG0OYyHCvt6lQH0TzBl/dXzxsGukxDr
 vfx9Bt77SuBgQVu9ts7b9zAvXC1qgyi6i1aotBxyMddRKO8x9RA4ndY2tPH4uxG0aeCY
 +Y7TAm1ykrOombsE3xr5MQ5NISmfcPxe+e2KedilQUfUMu9RY2mvIISSEcu9Mi8i+2aF
 IgAcJbNIFkUeLm60dhMpm0FXNkmJSRwT1YW7+d1uucsjfhkzmIGx2OodvRz3ubW5xfWZ
 ksng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708594613; x=1709199413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/+CQ/xsM2Sv+jdq8dNho3/YaVJZaPCz3kJVYnhGLGRA=;
 b=OgEV0qR/79iTuz1MdCmLBpaj4hBSuWQGnRBMQmh81LvOtvgp2Kvfg2DyCwhjyX3B0S
 9MjmvxsxmXdWdUyuCuf+8YZsgXLpHVJucjf9HiXee413lfAVvP8tEIL9xmJ8IB4xXvJC
 kJK3FfmfPglLI/5oF+x/zNjAO+rYVx+jEMuXlKq9igHMSkiy2OWmuK2jPIXsoyiKRzsz
 nhA/XilqJ+jcsLIMhCDe+ZdOBsOhNtXXqcjvWzzd1AdrtjjoTjxAQlU1U9akg5ssaJkk
 mTbYoM2uU04qMQsNV+Gd15vTe8ZgYCab24OakRnf1WXGQvImrFUL1x/HmRfp5Fkx+Nyy
 wPXA==
X-Gm-Message-State: AOJu0YyHuKlMDMRnBgBBchKo8GPZYx9GGU6jXT+WUQsouNfFRb18qnav
 Y2O6cCqg1Z6naCE+19uEo+7g0yEIWbuGM/HvWCy8IfUSHGrK3brRGeyNGy78sB0BUxRbOFs5fp6
 U
X-Google-Smtp-Source: AGHT+IF90ubSPxXkO7oJgzcxJ5o96XnDqQcrCZIxbC/e/Qn5yLAUnrlRt5lA+06gbUAa6OIMUDwQ0g==
X-Received: by 2002:a05:6358:881:b0:17a:d84e:c106 with SMTP id
 m1-20020a056358088100b0017ad84ec106mr20957334rwj.5.1708594612910; 
 Thu, 22 Feb 2024 01:36:52 -0800 (PST)
Received: from sumit-X1.. ([223.178.212.115]) by smtp.gmail.com with ESMTPSA id
 u20-20020a056a00099400b006e47300e4edsm6208404pfg.183.2024.02.22.01.36.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 01:36:52 -0800 (PST)
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
Subject: [PATCH v6 03/11] scripts/Makefile.lib: Statically define
 *-u-boot.dtsi files location
Date: Thu, 22 Feb 2024 15:05:59 +0530
Message-Id: <20240222093607.3085545-4-sumit.garg@linaro.org>
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

Allow u-boot to build DTB from a different directory tree such that
*-u-boot.dtsi files can be included from a common location. Currently
that location is arch/$(ARCH)/dts/, so statically define that common
location.

This is needed for platform owners to start building DTB files from
devicetree-rebasing directory but still being able to include
*-u-boot.dtsi files.

Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v6:
- Incorporate fix for sandbox CI failure.

Changes in v5:
- None

Changes in v4:
- Incorporate fix to resolve rk3399 migration issue reported by Simon.

Changes in v3:
- Picked up review tags

Changes in v2:
- s/UBOOT_DTSI_LOC/u_boot_dtsi_loc/

 scripts/Makefile.lib | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index f82b3169e874..9e38d75443c9 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -159,18 +159,20 @@ cpp_flags      = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(UBOOTINCLUDE)     \
 ld_flags       = $(KBUILD_LDFLAGS) $(ldflags-y) $(LDFLAGS_$(@F))
 
 # Try these files in order to find the U-Boot-specific .dtsi include file
-u_boot_dtsi_options = $(strip $(wildcard $(dir $<)$(basename $(notdir $<))-u-boot.dtsi) \
-	$(wildcard $(dir $<)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi) \
-	$(wildcard $(dir $<)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi) \
-	$(wildcard $(dir $<)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi) \
-	$(wildcard $(dir $<)u-boot.dtsi))
+u_boot_dtsi_loc = $(srctree)/arch/$(ARCH)/dts/
+
+u_boot_dtsi_options = $(strip $(wildcard $(u_boot_dtsi_loc)$(basename $(notdir $<))-u-boot.dtsi) \
+	$(wildcard $(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi) \
+	$(wildcard $(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi) \
+	$(wildcard $(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi) \
+	$(wildcard $(u_boot_dtsi_loc)u-boot.dtsi))
 
 u_boot_dtsi_options_raw = $(warning Automatic .dtsi inclusion: options: \
-	$(dir $<)$(basename $(notdir $<))-u-boot.dtsi \
-	$(dir $<)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi \
-	$(dir $<)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi \
-	$(dir $<)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi \
-	$(dir $<)u-boot.dtsi ... \
+	$(u_boot_dtsi_loc)$(basename $(notdir $<))-u-boot.dtsi \
+	$(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi \
+	$(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi \
+	$(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi \
+	$(u_boot_dtsi_loc)u-boot.dtsi ... \
 	found: $(if $(u_boot_dtsi_options),"$(u_boot_dtsi_options)",nothing!))
 
 # Uncomment for debugging
@@ -190,6 +192,7 @@ dtsi_include_list += $(CONFIG_DEVICE_TREE_INCLUDES)
 dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
 		 $(UBOOTINCLUDE)                                         \
 		 -I$(dir $<)                                             \
+		 -I$(u_boot_dtsi_loc)                                     \
 		 -I$(srctree)/arch/$(ARCH)/dts/include                   \
 		 -I$(srctree)/include                                    \
 		 -D__ASSEMBLY__                                          \
@@ -328,7 +331,7 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
 	  echo '$(pound)include "$(f)"' >> $(pre-tmp);) \
 	$(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
 	$(DTC) -O dtb -o $@ -b 0 \
-		-i $(dir $<) $(DTC_FLAGS) \
+		-i $(dir $<) -i $(u_boot_dtsi_loc) $(DTC_FLAGS) \
 		-d $(depfile).dtc.tmp $(dtc-tmp) || \
 		(echo "Check $(shell pwd)/$(pre-tmp) for errors" && false) \
 		; \
@@ -350,12 +353,13 @@ capsule_esl_input_file=$(srctree)/lib/efi_loader/capsule_esl.dtsi.in
 capsule_esl_dtsi = .capsule_esl.dtsi
 capsule_esl_path=$(abspath $(srctree)/$(subst $(quote),,$(CONFIG_EFI_CAPSULE_ESL_FILE)))
 
+dtsi_include_list_deps := $(addprefix $(u_boot_dtsi_loc),$(subst $(quote),,$(dtsi_include_list)))
+
 ifdef CONFIG_EFI_CAPSULE_AUTHENTICATE
 dtsi_include_list += $(capsule_esl_dtsi)
+dtsi_include_list_deps += $(obj)/$(capsule_esl_dtsi)
 endif
 
-dtsi_include_list_deps = $(addprefix $(obj)/,$(subst $(quote),,$(dtsi_include_list)))
-
 ifneq ($(CHECK_DTBS),)
 DT_CHECKER ?= dt-validate
 DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),-l $(DT_SCHEMA_FILES),-m)
-- 
2.34.1

