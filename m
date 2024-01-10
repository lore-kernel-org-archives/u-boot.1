Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7252C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 10:36:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F97387AC2;
	Wed, 10 Jan 2024 11:36:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YLC/SHMy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDF2787AC7; Wed, 10 Jan 2024 11:36:36 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5076E87AE2
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 11:36:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d542701796so18841785ad.1
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 02:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704882992; x=1705487792; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XnrWsmumWdWqbos15AFnT70rACmbaMyZSLSmWekGnk8=;
 b=YLC/SHMyYXj1JPnroKs8xvM8BZ5Asy6QvND1CT8NX1luiFxjJLVugxQiBbMRF3yxty
 CnuiCE6doYaitkaHMNLmDd3KWU3pgT9VOvxfvybgJrvxCRgfQeUa5IunDJ2AsFRid9vh
 386OJlI31ABE2cNyUwJu80P+lrVCSumbKYyw+SrtUEVnBcBeba/p6+sJh2YG5lN0f9bq
 6oESblGI6aJQPHs+WmZXinD/cVq1pv9y2DMQ+MwveH08fAk+NJCksMR6kiixNshhnDwY
 iBIbty/vlfqwXz9lSVs4E0EEGQfbDgKX98B3GQkPRuyQ5iULWN6e9vMFcEM7g5Zw4SEI
 G2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704882992; x=1705487792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XnrWsmumWdWqbos15AFnT70rACmbaMyZSLSmWekGnk8=;
 b=ritFvPyrqfEcUealjR+mjm+ZdhlW8WImZPRPqC0FJRNMEQ0guU9bh14g2O5C17tS+U
 finkjkhJTeO9Sz3AcBUtMc9Scmnigc6wSzVigHBPlAOeJX5/qcHhQV0/3+HtKZj9NOaD
 I7k3RDJqhtqAX5Lb/vbu8Ruu61WeWamHapdGq3cT93Myr4lPPscfj98cOTZseUlYntZ9
 BHJwLOznJ8wwQEEa5d9sFySCIw53Ftoq+xjocR1W2WyUm927m3MrkaIIzRR8OC+H3IZ2
 GR5Q4tbeBWTMTwNLY8FBnhOebZI72xoanPdiy/VTG19a0rNxftxMbaeHyQVu1lntpW8C
 LiPQ==
X-Gm-Message-State: AOJu0Yx6ecr5WuAPmg9wHQ4GtmIT9N7dCpn61PWZ5SOR/oORZEoILyF2
 ThoxWROZLJFjs32Jv1Xi8vBgnO8air5c9v8sl1M7640gwfg=
X-Google-Smtp-Source: AGHT+IEAb7E6cYgneKf36cQsKMUATDa5u6EX4B/Mpy0fyzMP2+AHR/0TrdJ+nn+p+EsZaRxi9U/ENw==
X-Received: by 2002:a17:903:41c6:b0:1d4:ac33:10bd with SMTP id
 u6-20020a17090341c600b001d4ac3310bdmr678576ple.104.1704882992422; 
 Wed, 10 Jan 2024 02:36:32 -0800 (PST)
Received: from sumit-X1.. ([223.178.208.66]) by smtp.gmail.com with ESMTPSA id
 i7-20020a17090332c700b001d38a7e6a30sm3332604plr.70.2024.01.10.02.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 02:36:32 -0800 (PST)
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
Subject: [PATCH v4 03/11] scripts/Makefile.lib: Statically define
 *-u-boot.dtsi files location
Date: Wed, 10 Jan 2024 16:05:39 +0530
Message-Id: <20240110103547.719757-4-sumit.garg@linaro.org>
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

Changes in v4:
- Incorporate fix to resolve rk3399 migration issue reported by Simon.

Changes in v3:
- Picked up review tags

Changes in v2:
- s/UBOOT_DTSI_LOC/u_boot_dtsi_loc/

 scripts/Makefile.lib | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index f82b3169e87..fe2a0aadc41 100644
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
@@ -354,7 +357,7 @@ ifdef CONFIG_EFI_CAPSULE_AUTHENTICATE
 dtsi_include_list += $(capsule_esl_dtsi)
 endif
 
-dtsi_include_list_deps = $(addprefix $(obj)/,$(subst $(quote),,$(dtsi_include_list)))
+dtsi_include_list_deps = $(addprefix $(u_boot_dtsi_loc),$(subst $(quote),,$(dtsi_include_list)))
 
 ifneq ($(CHECK_DTBS),)
 DT_CHECKER ?= dt-validate
-- 
2.34.1

