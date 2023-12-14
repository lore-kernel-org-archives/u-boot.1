Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F37C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 13:52:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6342E877B0;
	Thu, 14 Dec 2023 14:52:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="q1PQ+3qQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E45B87525; Thu, 14 Dec 2023 14:52:35 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F122B877B0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 14:52:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d351cb8b82so8936005ad.3
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 05:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702561951; x=1703166751; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NmsHndC6oc2FsYxMykcqQqeyLL2RBBp2X/qx9cpH09c=;
 b=q1PQ+3qQKryytbWUqYEtPwERJ3VCw7dZrP2zOO4R1EiRDKzhfJshYFZMdMdbGLN1lx
 VQEz6QibAzlS+PG1zFRcn8O0XlYMAuzyh4znV8qRCgbTiop1T7ODo9vS5a+jd8+LjJMc
 c6qMsQblE2tZg63fsj8M1qassv4C8xedUeGIgea98hmiLyGMGwX2bcHy3kaoyfCwqfEw
 L38ZJbD5SHisrImNDL1CMF8BWD2tlDOk+Cgm7HZDGoSRPA5hUa+8LuPjCXtR2UtJgs/6
 ssNsEWSDZNH0aaqs3nKIzY4+MKPzdQRii78KxknLWKrVDkF1914PaLBPE3GXxNRcpsWr
 ahZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702561951; x=1703166751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NmsHndC6oc2FsYxMykcqQqeyLL2RBBp2X/qx9cpH09c=;
 b=Ynb7q+t6qYVhFSTpgR5k7m14Gqbnc3HEVaRc/LhA+dGmaWuTF4Z1uJIoY5yTR1dCHs
 7lkH7PvzYdJ75ikhmiBtNSi+NMJyzmFhPOvcO8Tj+sNdvlSjP3/l0cFUW/f9lxfm8q9o
 9bbpjZfWycXy0HsBKNsWFAT9CvvVl/CmeNDjBZhFb1QSB113mYgl/IycRg8RuhJsOr0y
 1Mk+0TnXaV04TjDelsqaSUcLZPieM7nVSJM8AyZDOD3gdj0zA1qkvUwyXFbC6nwnGRjP
 z5pAUOsdIg3LKgViq9Uj+/OtI7d42bEB1xyP0aI6Cx4K7hNnYCBIN7Cz68EURAEhSoAV
 M+1g==
X-Gm-Message-State: AOJu0YzIedrnKUuc6mwsBi00QkfnK41Ywsa8Hpc2WXDABcz/X4Kb9fen
 /+MLuWg0cWVOT8E/cu0Vdt6fYfU2sEwLsU3eup0nnA==
X-Google-Smtp-Source: AGHT+IEMCrqGonUZ4acPUktD2yTVN4EF+chGH/YJBCsLrIpXuguJ9NzBne3tAzws31xs/YvoVOBh7w==
X-Received: by 2002:a17:903:2344:b0:1d0:76f4:e41b with SMTP id
 c4-20020a170903234400b001d076f4e41bmr5316154plh.45.1702561951052; 
 Thu, 14 Dec 2023 05:52:31 -0800 (PST)
Received: from sumit-X1.. ([223.178.213.6]) by smtp.gmail.com with ESMTPSA id
 j3-20020a170902c08300b001cfc68125desm12474956pld.203.2023.12.14.05.52.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 05:52:30 -0800 (PST)
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
Subject: [PATCH 7/8] dts: meson-gxbb: Switch to using upstream DT
Date: Thu, 14 Dec 2023 19:21:02 +0530
Message-Id: <20231214135103.1606605-8-sumit.garg@linaro.org>
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

Although there were still some variations in board DTS files based on
meson-gxbb SoC but I think those were minor differences from upstream
and shouldn't impact boot on these devices.

So switch to upstream DT via mirroring amlogic/ directory from
devicetree-rebasing/src/arm64/amlogic/ directory. And thereby directly
building DTB from there including *-u-boot.dtsi files from
arch/$(ARCH)/dts/ directory.

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

