Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224BBC4828F
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 13:07:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70D8A87D25;
	Fri,  2 Feb 2024 14:07:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cgWLHstd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E01387C74; Fri,  2 Feb 2024 14:07:32 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CED4E87D27
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 14:07:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d934c8f8f7so18333785ad.2
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 05:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706879247; x=1707484047; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=86cKOKOIikWvdQz1MxkWVNRFRquhuv/5USEoeTEMH30=;
 b=cgWLHstd5oDSVSDHfyYAN4bDNWJMeBk4bEYsrvC7mWWNKjHRCHFIxdigSb9SQCNovv
 KtWZDgCqET9fRUkgnaVxyJ8bO91qRqO+k/XVkZ72qMSPiZEpVeYFZ8dc5MPMwdT20P1N
 aXWqPczSyavrqds2LxnYBl9kw5kh7vJ9hJ5VA1RvnSZlbLLDj8qCiZdOtMREenA+QrOZ
 LddYrRD0JGrgLVBTzRbzJetwN3pjPn+l8xk6TIa3xYipKIaYxE827qZSNzMs8BQC+ROj
 qeKAtSC3qCDNhcTyHUv04KFnv8yP999tYMTSQ9nhwOAuPrBH1ZgrcIELYwknZowRS+5O
 M9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706879247; x=1707484047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=86cKOKOIikWvdQz1MxkWVNRFRquhuv/5USEoeTEMH30=;
 b=EGkUTv6MbvewOic4bA1MzUDi4723PpyejCy07wXZ2OIicmAeDWS0ENSgEE1epzZtWC
 Po55SKSXvgjKcvR4oUsdYINibB04Bo2l08yOAhkcB4wsVK4n1UgleVvTckLVCVw6ExDm
 GinONRg09BEAelnVFVgGrnHOeuKQ42CMMY8vgi3roKX25WELCNqG2+08FUJCCN3aPsns
 QLYwGRJOSKS5iIrwceHrbRPDZq/efzDHPAwxxHEtjPVtPvvrsqY1Cq02o3iY5d8ZCQJ8
 sFp3OdRdWtL0mlVYNdBP+MYohQHZt+noTxe8rBjFZf6TGNpf5pJk42CBMn/VeKDQY1xF
 6G6A==
X-Gm-Message-State: AOJu0YzU7dL+boOd2QRFeHOU2f9c+xY3o+LW/vjYd9mmmusb8nl2KZ5p
 S10YzTcv3YJhMY+LX3VCgQSMfKx4uJL7vXKpNuE7cNDqxMLwBzaAkMdWCkUV7o0tMMDb9niOkMX
 7KOY=
X-Google-Smtp-Source: AGHT+IHoFwtYPG/jAclBrU0SB9v6mZHKgvCKNlMSyNsoiD9dcB576LRO0MrB4k5TqJhYfecHmA3/jg==
X-Received: by 2002:a17:902:f545:b0:1d9:5d65:c1b with SMTP id
 h5-20020a170902f54500b001d95d650c1bmr3745991plf.41.1706879246687; 
 Fri, 02 Feb 2024 05:07:26 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWgEEmRJ4IBTSafseozLfZ2qsD1NrKFTUPaygSAWUhF+kp7j0VYFQJ8Oj3PeDOuWZif6/St8ETNe6aTpalr5P/hb26kXAuI30tetAcC5Q0SSk8LmXbIk70AmVN2DaEEHvjSCkNHGTBgWe3wzp0uIHWzlE85OJbsXOM9AYyLq+rDHbWVcAp6Vn6e47og+8oR/BmT2BnXw7X/jKPeXOq8Ml9tyyH44vHHDxkJ4fEnCy7KMug96iekmK8LQHSQEqH07ahYdagZlJzJ+I6L1yo/k2+Ink9QsAbAYTghCrpCsBPy2G4cxRVTzfVua+flLKSE1Ke9qGq0SNeIwOQzsPwtKFWiO0IE7IWiwSMZiR5MxdDzNnmE/hgRXLwzwcMur1KyqYYtUPumTlzvwlJYimJoNU14WrlYvknzwD17sTvCaVNvhbFAThJnpZhEa/TNfa2Ffao1JjJP24j6sroeaW9zkh7GSTU8pi5lealnLPT+2sfEH+k+bnX/U2rFs1mwiOV1eg5Jf+DNV2oCivICYUs89pSPTGzvfYSDSjI4bQySoWeouaEWtrqVjI3XchvUoedPqH4OIJaOKGbU/l+pF0H1S+ykFg1EliX2dV4W249xZR7BuSAj1lKwZUr8P6LNslyKttRc2eIfVwB0GAMfKj6KeV9IOkuGVBq+okx+D35jiw4aIACo2UhZjpHGiepYttTG7sqpjHExZK6WxNQnr+HCgFKfYx6Rf+386HVOCCrtxy0KFDDawWhAo6DM8M00n5jpQMytOHW8gOhgoUDsdFil6h6ywlrmP7nVVFmHLpID1R9l3IUsxn+5hFKtwFDILzgpGW6Z6Quk3CaPg56ji1UI4FsQScsu1fVOm0mT6M+hYKbosjR3N3oILJyFYI/479isnqi9dz9qW++muGjy+zQeRR3jDaT8nEBmzGLv
Received: from sumit-X1.. ([223.178.213.44]) by smtp.gmail.com with ESMTPSA id
 q23-20020a170902edd700b001d923684323sm1542407plk.195.2024.02.02.05.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 05:07:26 -0800 (PST)
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
Subject: [PATCH v5 10/11] dts: meson-gxbb: Switch to using upstream DT
Date: Fri,  2 Feb 2024 18:35:33 +0530
Message-Id: <20240202130534.1051438-11-sumit.garg@linaro.org>
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

Although there were still some variations in board DTS files based on
meson-gxbb SoC but I think those were minor differences from upstream
and shouldn't impact boot on these devices.

So enable OF_UPSTREAM to use upstream DT and add amlogic/ prefix to the
DEFAULT_DEVICE_TREE. And thereby directly build DTB from dts/upstream/src/
including *-u-boot.dtsi files from arch/$(ARCH)/dts/ directory.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v5:
- None

Changes in v4:
- Picked up review tag

Changes in v3:
- Dropped Makefile portion and enabled OF_UPSTREAM for SoC instead.

Changes in v2:
- Picked up review tag

 arch/arm/mach-meson/Kconfig           | 1 +
 configs/nanopi-k2_defconfig           | 2 +-
 configs/odroid-c2_defconfig           | 2 +-
 configs/p200_defconfig                | 2 +-
 configs/p201_defconfig                | 2 +-
 configs/videostrong-kii-pro_defconfig | 2 +-
 configs/wetek-hub_defconfig           | 2 +-
 configs/wetek-play2_defconfig         | 2 +-
 8 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index d6c890580617..8ddb59161a0d 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -25,6 +25,7 @@ choice
 config MESON_GXBB
 	bool "GXBB"
 	select MESON_GX
+	imply OF_UPSTREAM
 	help
 	  Select this if your SoC is an S905
 
diff --git a/configs/nanopi-k2_defconfig b/configs/nanopi-k2_defconfig
index 41dbf7981f8b..2e1c756bf7a8 100644
--- a/configs/nanopi-k2_defconfig
+++ b/configs/nanopi-k2_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-nanopi-k2"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-nanopi-k2"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_DEBUG_UART_BASE=0xc81004c0
diff --git a/configs/odroid-c2_defconfig b/configs/odroid-c2_defconfig
index 5f9f323e06ea..ce5eaec3cd2a 100644
--- a/configs/odroid-c2_defconfig
+++ b/configs/odroid-c2_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-odroidc2"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-odroidc2"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_DEBUG_UART_BASE=0xc81004c0
diff --git a/configs/p200_defconfig b/configs/p200_defconfig
index cd579ef5f142..b69460347954 100644
--- a/configs/p200_defconfig
+++ b/configs/p200_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-p200"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-p200"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_DEBUG_UART_BASE=0xc81004c0
diff --git a/configs/p201_defconfig b/configs/p201_defconfig
index b2f0a0ccdb4a..dcc1454be16c 100644
--- a/configs/p201_defconfig
+++ b/configs/p201_defconfig
@@ -7,7 +7,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-p201"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-p201"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_DEBUG_UART_BASE=0xc81004c0
diff --git a/configs/videostrong-kii-pro_defconfig b/configs/videostrong-kii-pro_defconfig
index 3eda8f14a21b..7a5af234471f 100644
--- a/configs/videostrong-kii-pro_defconfig
+++ b/configs/videostrong-kii-pro_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-kii-pro"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-kii-pro"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_DEBUG_UART_BASE=0xc81004c0
diff --git a/configs/wetek-hub_defconfig b/configs/wetek-hub_defconfig
index fd92b041e739..85cff73f50f7 100644
--- a/configs/wetek-hub_defconfig
+++ b/configs/wetek-hub_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-wetek-hub"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-wetek-hub"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_DEBUG_UART_BASE=0xc81004c0
diff --git a/configs/wetek-play2_defconfig b/configs/wetek-play2_defconfig
index b887419a6bab..efdf820165b5 100644
--- a/configs/wetek-play2_defconfig
+++ b/configs/wetek-play2_defconfig
@@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-wetek-play2"
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-wetek-play2"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_DEBUG_UART_BASE=0xc81004c0
-- 
2.34.1

