Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33992C4828F
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 13:06:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79F3187C7B;
	Fri,  2 Feb 2024 14:06:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Bh5L8SzY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0FFD87C7B; Fri,  2 Feb 2024 14:06:30 +0100 (CET)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F11187C78
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 14:06:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6de24201aa6so1296022b3a.2
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 05:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706879184; x=1707483984; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XZ2DFBwhO2WYJwi8rn6sF84aQnhnxv9yyY/a8AQ1ExY=;
 b=Bh5L8SzYBTXzf+Ehgjt0h8pO5s+rfbPxfCM0sfGPQ8MpHxRTcboOXtn5fA7KP2TTb2
 C/BSfF1JiIa1fgtnXXd2VvWuYkvRsM37Vcv5Tw+6e0GgRAbOnSob+vZnUJIzH6UY5qyB
 zNyn+7KfTtEcMhgFwIyDHHahxlsn73gDqdVSA0w8WOlcya83qy82e7luBONWjmzz4U9K
 +W4WRNoqrROzC+XVt1OrIGdyH2AVyzS2owAoZGXSdnOAkaSr/gsuYx6ZHOoPTHJO3kOh
 vtXsOQIkm3zDZaiY0rYhaI192ThbScP1WaPtQA5bAhZJ27lxpN5f5/x2JG1jRnXVSEdZ
 5TKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706879184; x=1707483984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XZ2DFBwhO2WYJwi8rn6sF84aQnhnxv9yyY/a8AQ1ExY=;
 b=HAEEhJVr3VOWe7CjWOaXbkwgfbJfNCQ26rrzCtAZTXwd2BFcaxnZ9GntvkvzLfzrFV
 1KcDtkBfA5gj8rPlgtSgnK6I8nJij6bf97FpoG2Gei8Awy/4XtiZkFMTXsKXFx4nPQyg
 Qg6bYl+VIdWa+DKtELt/hMoxUv/IOhhEOQ923Dd6hQUfGTIetsbE4z0Ni1srPxgmixz+
 PuW86AQof4LogZauSUDA3BeCqFW/okphjQvwfJk7KITzstbHPLCSVV8qIXWX/nBvCB9O
 ygKzNVO0UaZOtrBFtwlUVET9+yru2E3TT20tSkr1u8pyj6/amCb2FgfiZPqE98ExAetm
 nqRg==
X-Gm-Message-State: AOJu0YxTAdbdR/045hB5NBxdFfUuOwo67pfi7ERtDCZVrO5x96XAZvV2
 jkGMYb2fnS0bDsdRWuG5w4dAS8TWt1rp9x2d4IlvGyiQzCxWCNCVJCHLExAPCMuM0RbdO6Jon5Q
 n9Gg=
X-Google-Smtp-Source: AGHT+IE21rKAedGyz9KXKPmh1gR2NyFun0IGrdndgwdUOGKfqA/vSm0ETJDz5yyl0j9q3MPgDZ4P4A==
X-Received: by 2002:a17:903:11d1:b0:1d4:47d4:82b4 with SMTP id
 q17-20020a17090311d100b001d447d482b4mr9306724plh.15.1706879184573; 
 Fri, 02 Feb 2024 05:06:24 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXWkBIJI0LFF3IR1B6s/yaV5wIJYWIvViRHOE4id0GtC7iYCqfYI3s9RmVOdq8h3rIU8Kaob8LvdVzBDFX4og+dW3nFti9uwE3zkjK0YsPJzqfc6MFP343xYECDkCdMui/Vc24RfiEctEVWagq8Jy0w+zQ/V+X3EwvO3T2JyTLhQQHcAWQC8jcAMB39bQ+1NBCbsSkr99/ZWDN7yop/90zJ7ULpfZ124IpKdj1vrWFXuHoyQNwR7YDU6B2FKLkGQlsR6BhSH6y/ApMNRNIh5S6IhZzl98J9HF7rvLmMwm+VEqUxUEOBsgzz9N6zBq+qNm0+71W9IR5fOMypl12iyoFXUkeZm6O8wNJlnVXXDLzzZNcmnxrPselrOGr8W4FwcCsnbvTGIP7fo/J33Bf8s75wy9hLYVfScDh0+jVrGYQihTd3eSoRcG3YUfpJDsQC0klb4zLHgwE2nelHlrLVqVwPHZLcUYtbljCj/KTuypCZyoyRQ1/ArEMpz6Kga+oK/PZtdGK550naS+NaR1u0z+rIgJM3SIMf41j1ZCst1JRt6ELi8X6z2V4ypvqIq/vcDrzM4Et9ZOKgckmKDVKQj5wQz1w50CEUy37bB1BA2hNClEB+T7iOITH7b4WOpqY7GaJhyDAj9pvRA/syac7UaImRt53S1cbMlG1IqPcGiPt6ebNseHmUdMj5hFUvyyy3UI2Y6Hu9LnxAzxwvAC9BzfPLrnExIrEYJIjlTE8vsP1uZsZQMi2w4k38ZXcCQELpFo+Mtb9rKeH4WZsAdBy5RFXwm6bmvQdfNThrxtZHL3jCYky3XdsJpTqV/w4yEGcyM7V+Xaq9khxruo8yLVv5UQtCIxQGPMjuDH1dUs91nODKa30Fz/zKe6Fp17HSJQ5Vf1R7rX2+s+Ef9I38rO2l8jjOTN1QMmqtZ3di
Received: from sumit-X1.. ([223.178.213.44]) by smtp.gmail.com with ESMTPSA id
 q23-20020a170902edd700b001d923684323sm1542407plk.195.2024.02.02.05.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 05:06:24 -0800 (PST)
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
Subject: [PATCH v5 03/11] scripts/Makefile.lib: Statically define
 *-u-boot.dtsi files location
Date: Fri,  2 Feb 2024 18:35:26 +0530
Message-Id: <20240202130534.1051438-4-sumit.garg@linaro.org>
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

Changes in v5:
- None

Changes in v4:
- Incorporate fix to resolve rk3399 migration issue reported by Simon.

Changes in v3:
- Picked up review tags

Changes in v2:
- s/UBOOT_DTSI_LOC/u_boot_dtsi_loc/

 scripts/Makefile.lib | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index f82b3169e874..fe2a0aadc417 100644
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

