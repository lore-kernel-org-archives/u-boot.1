Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22462C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 13:52:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 466EE87A7C;
	Thu, 14 Dec 2023 14:52:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TBySlIwo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 735F987A7F; Thu, 14 Dec 2023 14:52:04 +0100 (CET)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABF4B87A8D
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 14:52:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6d089e8b1b2so3031225b3a.3
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 05:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702561920; x=1703166720; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LJhXFrv8uHuP5uiECV7lR9faylLwkNArQN5KLLNNmik=;
 b=TBySlIwoCrsDETK9i0GYV1dZ8HoVmD/xOpXN/Q0GjRCQNjxZASH6TecIiqeb9FleJ2
 ovpzDvxjB0gXwioWJnalY4gccq1Dfm2A1AQ78v9VvqUC24gKcZ+pzQxmNTsKZJ2P7pTN
 zU9WDobRrCos8WKUmnaypZNjDbzr4FCEHmTFWq3zypsNhR3M0XpEKl17W2AgJvOJx+lY
 P1cq9eFELG1rjmVPJ17F9s/7RZbbWR0+XQQbiwRPaYM9zPSHBkN5guztygCpSSOD9bui
 TfpjXYkngWjCWpHoM1k7b4Wf9Z8LA7Tf3nCh0FaicbRvxdcrCYo+SHv7GnyyerhgBde0
 HvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702561920; x=1703166720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LJhXFrv8uHuP5uiECV7lR9faylLwkNArQN5KLLNNmik=;
 b=sWg1wMwbQeKcIH/g5cpACNX5wZWClf1FwXL4eQ24igJOWHnwVT/tdNmpBXVw0lzU2B
 AdIk9DJE10DgbtBpB1rXo7b7Ccaub5qsXBJ/XxpDP+ZpwAme1nJaq15hBx7OdERExDPq
 Oez2NA3hU0zy4TIgAyggWcHkTIhWyXRmY4LUPw5snjs/cxjYytxkbcacP0ejKM0UUdMY
 A/b0ohOfaYBKKF6QkYGZ2Jp4nxAcc7YFr1iGnDImCIDwJw0Qx9kqsUcECuRiUQLGl+cO
 nc4sKkrKvry79fj4/krFDZ/AHQrXTSUMlNZ9yFy3EKwaRPSCdBQklHpsGmyhfFIon6Jb
 UOvQ==
X-Gm-Message-State: AOJu0YzWNZHMmMoN8VvQE0r0zH1LiL/Rm3oCJ+0R50/hHWsWy6bMnTJj
 eAWOLAo6lI2Kasog1BRyyvZSj/p8HKqcZ6F9cp9giA==
X-Google-Smtp-Source: AGHT+IEVp+TymXBW+Ef+yFfKdEgCKG+pW8pT9fVUog8dTTjR5053ODURKLiiiN8f0VPqRlDyCVF6eQ==
X-Received: by 2002:a05:6a20:daa0:b0:18b:6f9:dc22 with SMTP id
 iy32-20020a056a20daa000b0018b06f9dc22mr5676623pzb.41.1702561919810; 
 Thu, 14 Dec 2023 05:51:59 -0800 (PST)
Received: from sumit-X1.. ([223.178.213.6]) by smtp.gmail.com with ESMTPSA id
 j3-20020a170902c08300b001cfc68125desm12474956pld.203.2023.12.14.05.51.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 05:51:59 -0800 (PST)
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
Subject: [PATCH 3/8] scripts/Makefile.lib: Statically define *-u-boot.dtsi
 files location
Date: Thu, 14 Dec 2023 19:20:58 +0530
Message-Id: <20231214135103.1606605-4-sumit.garg@linaro.org>
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

Allow u-boot to build DTB from a different directory tree such that
*-u-boot.dtsi files can be included from a common location. Currently
that location is arch/$(ARCH)/dts/, so statically define that common
location.

This is needed for platform owners to start building DTB files from
devicetree-rebasing directory but still being able to include
*-u-boot.dtsi files.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 scripts/Makefile.lib | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 27b9437027c..4a002b0e0ca 100644
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
+UBOOT_DTSI_LOC = $(srctree)/arch/$(ARCH)/dts/
+
+u_boot_dtsi_options = $(strip $(wildcard $(UBOOT_DTSI_LOC)$(basename $(notdir $<))-u-boot.dtsi) \
+	$(wildcard $(UBOOT_DTSI_LOC)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi) \
+	$(wildcard $(UBOOT_DTSI_LOC)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi) \
+	$(wildcard $(UBOOT_DTSI_LOC)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi) \
+	$(wildcard $(UBOOT_DTSI_LOC)u-boot.dtsi))
 
 u_boot_dtsi_options_raw = $(warning Automatic .dtsi inclusion: options: \
-	$(dir $<)$(basename $(notdir $<))-u-boot.dtsi \
-	$(dir $<)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi \
-	$(dir $<)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi \
-	$(dir $<)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi \
-	$(dir $<)u-boot.dtsi ... \
+	$(UBOOT_DTSI_LOC)$(basename $(notdir $<))-u-boot.dtsi \
+	$(UBOOT_DTSI_LOC)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi \
+	$(UBOOT_DTSI_LOC)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi \
+	$(UBOOT_DTSI_LOC)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi \
+	$(UBOOT_DTSI_LOC)u-boot.dtsi ... \
 	found: $(if $(u_boot_dtsi_options),"$(u_boot_dtsi_options)",nothing!))
 
 # Uncomment for debugging
@@ -190,6 +192,7 @@ dtsi_include_list += $(CONFIG_DEVICE_TREE_INCLUDES)
 dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
 		 $(UBOOTINCLUDE)                                         \
 		 -I$(dir $<)                                             \
+		 -I$(UBOOT_DTSI_LOC)                                     \
 		 -I$(srctree)/arch/$(ARCH)/dts/include                   \
 		 -I$(srctree)/include                                    \
 		 -D__ASSEMBLY__                                          \
@@ -328,7 +331,7 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
 	  echo '$(pound)include "$(f)"' >> $(pre-tmp);) \
 	$(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
 	$(DTC) -O dtb -o $@ -b 0 \
-		-i $(dir $<) $(DTC_FLAGS) \
+		-i $(dir $<) -i $(UBOOT_DTSI_LOC) $(DTC_FLAGS) \
 		-d $(depfile).dtc.tmp $(dtc-tmp) || \
 		(echo "Check $(shell pwd)/$(pre-tmp) for errors" && false) \
 		; \
-- 
2.34.1

