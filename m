Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C6B5C41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 06:14:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1424B87858;
	Fri, 22 Dec 2023 07:13:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="maMsNCdW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 262F38784D; Fri, 22 Dec 2023 07:13:40 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDC508783E
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 07:13:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3bb82d1d9d6so775017b6e.3
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 22:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703225601; x=1703830401; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iP5Aks3HCiKy1UBsb37inWX+Qi0v6OqanQQ0MOIxfR0=;
 b=maMsNCdWZH0PLvIHAb0ULt4X+hYMKPfnv22cxHQSFEo9k8ljcyvn+nosOZ/yaAg8lJ
 GRScO6arNfMa+3OxI43ujWhIlH+5ohJxfDugHR07+HaOWw9H8zBaCTaHltqg8irfxS3V
 tCsxdO6Dx/XhOq6Z9JHGNR/vJDj5itWm3OhwShIr9HFPXTXmdwZynxMwB9/QV+vLGEy6
 3f4Ku5SxfMMw1607ILOtOI14kbcFmD/VUxzLr7Iz/v7wVwfxkInTPl9ExRSFVx2YhqeL
 SWCu+8TOG0pEg06qsZhVXTzFHTX0FPxBXyAZurj4emBThZu7yHYKH0rhBSlbjIabNHeh
 7D6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703225601; x=1703830401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iP5Aks3HCiKy1UBsb37inWX+Qi0v6OqanQQ0MOIxfR0=;
 b=rBfE7vZDS5HCwp2HKwtYR5JzI26pRZ1zbZKkQWjZoUpPaPBsoujoZiXIozT+t5u9yd
 bw9UkGpRsUBGveeFqjmXaaegFF2BcoVd0Gb1GIc6ehzQqlzEFkM7jJvSDGDpjomsPoze
 F/hHiQ6DS8uclcJ49Hq76WAG1522NGJLbktacJm1fF/VHujvMCbNnHOaHRQ1uVjlXXZX
 kHQvg74FHL9hWfVh1KA2UNeL9UCO9dSlD6U7WzmSQ5DOLw4eEhml08oAKyDS0VXM0VdX
 BF40mQSz9MjPq9XCO5kOKfHP2yrUr8uon2n1COD2FGz/lx7t2oKnR4ctMO/BEOli/f/r
 pX/g==
X-Gm-Message-State: AOJu0Yzg9GM2ohxAuQkqMnDHqpnlH7V47BDI5cXR2hy9XOGyHQtPZD3v
 g5mZSIyyl31JoDG5bPi1d675tpYD3kNJwJhUquII7yf1c/vBHg==
X-Google-Smtp-Source: AGHT+IFArbjWWOYp0X/uxV3V4O0fU9IYmL5Rkon6csJFd54LoaeStF819h2fiGlt6bxZ+A1hWs+pcg==
X-Received: by 2002:a05:6808:1a26:b0:3b9:dbc5:2fe8 with SMTP id
 bk38-20020a0568081a2600b003b9dbc52fe8mr1154862oib.47.1703225601347; 
 Thu, 21 Dec 2023 22:13:21 -0800 (PST)
Received: from sumit-X1.. ([223.178.212.219]) by smtp.gmail.com with ESMTPSA id
 h6-20020aa79f46000000b006ce835b77d9sm2602883pfr.20.2023.12.21.22.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 22:13:21 -0800 (PST)
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
Subject: [PATCH v2 7/8] dts: meson-gxbb: Switch to using upstream DT
Date: Fri, 22 Dec 2023 11:42:07 +0530
Message-Id: <20231222061208.3009970-8-sumit.garg@linaro.org>
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

Although there were still some variations in board DTS files based on
meson-gxbb SoC but I think those were minor differences from upstream
and shouldn't impact boot on these devices.

So switch to upstream DT via mirroring amlogic/ directory from
devicetree-rebasing/src/arm64/amlogic/ directory. And thereby directly
building DTB from there including *-u-boot.dtsi files from
arch/$(ARCH)/dts/ directory.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 configs/nanopi-k2_defconfig           | 3 ++-
 configs/odroid-c2_defconfig           | 3 ++-
 configs/p200_defconfig                | 3 ++-
 configs/p201_defconfig                | 3 ++-
 configs/videostrong-kii-pro_defconfig | 3 ++-
 configs/wetek-hub_defconfig           | 3 ++-
 configs/wetek-play2_defconfig         | 3 ++-
 dts/arch/arm64/Makefile               | 9 +++++++++
 dts/arch/arm64/amlogic                | 1 +
 9 files changed, 24 insertions(+), 7 deletions(-)
 create mode 120000 dts/arch/arm64/amlogic

diff --git a/configs/nanopi-k2_defconfig b/configs/nanopi-k2_defconfig
index 41dbf7981f8..3db296916e9 100644
--- a/configs/nanopi-k2_defconfig
+++ b/configs/nanopi-k2_defconfig
@@ -6,7 +6,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-nanopi-k2"
+CONFIG_OF_UPSTREAM=y
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-nanopi-k2"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_DEBUG_UART_BASE=0xc81004c0
diff --git a/configs/odroid-c2_defconfig b/configs/odroid-c2_defconfig
index 5f9f323e06e..65857ff478c 100644
--- a/configs/odroid-c2_defconfig
+++ b/configs/odroid-c2_defconfig
@@ -6,7 +6,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-odroidc2"
+CONFIG_OF_UPSTREAM=y
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-odroidc2"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_DEBUG_UART_BASE=0xc81004c0
diff --git a/configs/p200_defconfig b/configs/p200_defconfig
index cd579ef5f14..c1792db51fd 100644
--- a/configs/p200_defconfig
+++ b/configs/p200_defconfig
@@ -6,7 +6,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-p200"
+CONFIG_OF_UPSTREAM=y
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-p200"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_DEBUG_UART_BASE=0xc81004c0
diff --git a/configs/p201_defconfig b/configs/p201_defconfig
index b2f0a0ccdb4..202e1da5bcc 100644
--- a/configs/p201_defconfig
+++ b/configs/p201_defconfig
@@ -7,7 +7,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-p201"
+CONFIG_OF_UPSTREAM=y
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-p201"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_DEBUG_UART_BASE=0xc81004c0
diff --git a/configs/videostrong-kii-pro_defconfig b/configs/videostrong-kii-pro_defconfig
index 3eda8f14a21..d09333d3b96 100644
--- a/configs/videostrong-kii-pro_defconfig
+++ b/configs/videostrong-kii-pro_defconfig
@@ -6,7 +6,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-kii-pro"
+CONFIG_OF_UPSTREAM=y
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-kii-pro"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_DEBUG_UART_BASE=0xc81004c0
diff --git a/configs/wetek-hub_defconfig b/configs/wetek-hub_defconfig
index fd92b041e73..73f3d4aad5d 100644
--- a/configs/wetek-hub_defconfig
+++ b/configs/wetek-hub_defconfig
@@ -6,7 +6,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-wetek-hub"
+CONFIG_OF_UPSTREAM=y
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-wetek-hub"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_DEBUG_UART_BASE=0xc81004c0
diff --git a/configs/wetek-play2_defconfig b/configs/wetek-play2_defconfig
index b887419a6ba..26f57b4214a 100644
--- a/configs/wetek-play2_defconfig
+++ b/configs/wetek-play2_defconfig
@@ -6,7 +6,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-wetek-play2"
+CONFIG_OF_UPSTREAM=y
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-wetek-play2"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_DEBUG_UART_BASE=0xc81004c0
diff --git a/dts/arch/arm64/Makefile b/dts/arch/arm64/Makefile
index 16e9fea622d..d548584cf5c 100644
--- a/dts/arch/arm64/Makefile
+++ b/dts/arch/arm64/Makefile
@@ -1,5 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0+
 
+dtb-$(CONFIG_ARCH_MESON) += \
+	amlogic/meson-gxbb-kii-pro.dtb \
+	amlogic/meson-gxbb-nanopi-k2.dtb \
+	amlogic/meson-gxbb-odroidc2.dtb \
+	amlogic/meson-gxbb-p200.dtb \
+	amlogic/meson-gxbb-p201.dtb \
+	amlogic/meson-gxbb-wetek-hub.dtb \
+	amlogic/meson-gxbb-wetek-play2.dtb
+
 include $(srctree)/scripts/Makefile.dts
 
 targets += $(dtb-y)
diff --git a/dts/arch/arm64/amlogic b/dts/arch/arm64/amlogic
new file mode 120000
index 00000000000..73f7c3e7bd0
--- /dev/null
+++ b/dts/arch/arm64/amlogic
@@ -0,0 +1 @@
+../../../devicetree-rebasing/src/arm64/amlogic/
\ No newline at end of file
-- 
2.34.1

