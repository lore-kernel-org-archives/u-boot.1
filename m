Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EFE0C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 23:43:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1B9788804;
	Sat, 13 Jul 2024 01:43:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NoCnIQpC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0D2A887B4; Sat, 13 Jul 2024 01:43:13 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 235CC887EB
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 01:43:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3d9dfc7c5f6so1151893b6e.0
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 16:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720827789; x=1721432589; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YgI+u3vmFH/GWa1LxJwmFIOJR/1/k42pUmCgTi/cEXM=;
 b=NoCnIQpC51GJ0Ve5bCi10PpKcDoemMYqFJiPzxHkodbjZzpJ7XQzx9/YSG8uVeOBJX
 zU5E0lqaYajrd4yrvr+n1c3iMbR+6ydYuxJWttTChRmDwAqqPQQ5vaFn0+DSAy/Jah5K
 chSblnr27WOe4Xs2xoBZtee82izkN2Hm1lMv85hoKkNBbxWbBS2nKELAI7OEXEsSzegw
 7Yh8MxsiApi5hP61qEHzRP/2QPgBrz2Yt4x4STuZF2lUz8tD4qZnJQb5e76NXhnI0YyJ
 VQVm/qoKl5c15NP0gcTAC3Bw/j3xOivVjbeRWyBAqk9HC4/ytJ/e8lzSFxE1OQ1vzCNf
 +MAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720827789; x=1721432589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YgI+u3vmFH/GWa1LxJwmFIOJR/1/k42pUmCgTi/cEXM=;
 b=mS3NLeXWBnr4CHFN8pybYOR3+k6qmfoMvpC4vFow55dzAECwFKHVIA21h4miGaPTt8
 iyC6f7MeaTe6bXsIeLh6s2bqwAxQ002EUaEPjKfJnZUoD+12PD7v5aD6i0ydXZZRQImc
 FDBbxoeHGM9gc0J4ecaQooFMBCORPOFC2tIM05K6b4I8S4iHZ1ECa0xirj6El06bySIG
 A9Teafn1C4x6y5zLOn9vc0uU97PYFbUB6B3iM2Nx2zT6mZg0UzMJFD85LMLaXVVHFuxg
 ncOHg81O4XWcj4A/qUAEQK8/gEFlmWjL2dXZZtd9CLl5TUELrjgq6Zu16XRX3oU8sI8n
 tqfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUi1kbehAiyH0HVxyzmhbXIg5yq+jJRKVXZXK6OlXjZftD+EvcJMdsUfO4DOCfa5gOoxxLtV6SBOUtdPL4p9XR8ubTmTw==
X-Gm-Message-State: AOJu0Yx6+YmgAxKLPUztFQ0nrBLPCpkQd2s33B+aDEkmfVNopgwPnSxi
 EgF22jE3bTYK6ZCpAJ8MxLh/XSLLn2SUtHotxgdQegBxhkTEugECWZYoIb+Rt78=
X-Google-Smtp-Source: AGHT+IHeV120LusVREqche5ndJHFUjO8CmPiMvSVSqOX3CNNeRxa5gMYR9MoWIwws9mZAPeylyB+Hg==
X-Received: by 2002:a05:6808:1a0d:b0:3d5:64d6:9f1e with SMTP id
 5614622812f47-3d93c0aad4amr15425197b6e.36.1720827788868; 
 Fri, 12 Jul 2024 16:43:08 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3dab3dc1dc9sm9537b6e.9.2024.07.12.16.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 16:43:08 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>,
 Chanho Park <chanho61.park@samsung.com>, u-boot@lists.denx.de
Subject: [PATCH 5/5] arm: exynos: Enable TRNG on E850-96 board
Date: Fri, 12 Jul 2024 18:43:04 -0500
Message-Id: <20240712234304.9675-6-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240712234304.9675-1-semen.protsenko@linaro.org>
References: <20240712234304.9675-1-semen.protsenko@linaro.org>
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

Enable True Random Number Generator (TRNG) on E850-96 board. To do so:
  1. Enable DM_RNG and RNG_EXYNOS for TARGET_E850_96
  2. Add TRNG node to E850-96 device tree
  3. Enable 'rng' command support for easy TRNG testing

TRNG node is already applied in Linux kernel device tree, but it hasn't
appeared in upstream dts yet. Add it in U-Boot override dtsi file
temporarily; it can be removed once it appears in upstream dts.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 arch/arm/dts/exynos850-e850-96-u-boot.dtsi | 11 +++++++++++
 arch/arm/mach-exynos/Kconfig               |  2 ++
 configs/e850-96_defconfig                  |  1 +
 3 files changed, 14 insertions(+)

diff --git a/arch/arm/dts/exynos850-e850-96-u-boot.dtsi b/arch/arm/dts/exynos850-e850-96-u-boot.dtsi
index 6d7148f7264a..3aa5d8bb10d0 100644
--- a/arch/arm/dts/exynos850-e850-96-u-boot.dtsi
+++ b/arch/arm/dts/exynos850-e850-96-u-boot.dtsi
@@ -3,6 +3,17 @@
  * Copyright (c) 2023 Linaro Ltd.
  */
 
+&soc {
+	/* TODO: Remove this node once it appears in upstream dts */
+	trng: rng@12081400 {
+		compatible = "samsung,exynos850-trng";
+		reg = <0x12081400 0x100>;
+		clocks = <&cmu_core CLK_GOUT_SSS_ACLK>,
+			 <&cmu_core CLK_GOUT_SSS_PCLK>;
+		clock-names = "secss", "pclk";
+	};
+};
+
 &pmu_system_controller {
 	bootph-all;
 	samsung,uart-debug-1;
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index cad8bb044cf0..3fee5a4299b8 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -250,6 +250,8 @@ config TARGET_E850_96
 	select PINCTRL
 	select PINCTRL_EXYNOS850
 	imply OF_UPSTREAM
+	imply DM_RNG
+	imply RNG_EXYNOS
 
 endchoice
 endif
diff --git a/configs/e850-96_defconfig b/configs/e850-96_defconfig
index 29ad31d5f8ed..7e1e8adb4a0a 100644
--- a/configs/e850-96_defconfig
+++ b/configs/e850-96_defconfig
@@ -14,6 +14,7 @@ CONFIG_ANDROID_BOOT_IMAGE=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_HUSH_PARSER=y
 CONFIG_CMD_ABOOTIMG=y
+CONFIG_CMD_RNG=y
 CONFIG_CMD_CLK=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
-- 
2.39.2

