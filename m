Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91522C3DA63
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 18:16:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 840AE887D6;
	Tue, 23 Jul 2024 20:15:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h+LFVVYH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17B64884BC; Tue, 23 Jul 2024 20:14:58 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C4BB88852
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 20:14:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-704494efa7cso2972404a34.3
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 11:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721758484; x=1722363284; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8gq0A8rChaBn6EPPkSZgzwRXNnHZA5AQoq4NfD5Yfog=;
 b=h+LFVVYHkSUthhDM2QR3bG1IQG+VSWMstvjkaqo5TVeVRo8r5ExjrIGKUG0bLddB04
 kb3qNiZXTQ5pHb9wWiTs5xZ9e9A1jo9V6G7eEecWl92612hH+asGMp6xPqQdG5DruTtn
 bmC94xr8d9VHxs5lmiGdrY01RA9b33YCf6oy6Mdh/H+sLck8UKYqsKsl4sMZL/g8wPeq
 KrtzjzEvDjIuufFDAg4Sn+aRaC2bHmsXXufaRwmRTcS23Cbzspb4xrWfWufD7LKIZhPg
 POOGW76hB+jdDFReiv1kMtX/rXy9utP7n8Hwp7f4ZVEWT/cXVA+RXN4wxsjgFgNI7Qtn
 h0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721758484; x=1722363284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8gq0A8rChaBn6EPPkSZgzwRXNnHZA5AQoq4NfD5Yfog=;
 b=K+unwbIv8HK3Kev4A8Jpjmb957L071PIbY4a9M8VnQa+rWIUwSJMAeqyYr+fEDEEkE
 29Z/4kr9pBBqbqmi9cWMNr5ffhzw2S4A61AHrqDRba5GpZxljVrNAExsVNpwK9TDBLGC
 kwTqKGMab1y9XhUtw+iSOSV21J7iPTfgS4q1GSk3dAz4f95eyJiEL4+F+Yacj2Tiq92D
 +U3+vFN/KyLT7ZaMSOsgncjrUUfADKyx9uZnEEsiQD6oAFam8XRnrVSYFOc4I3DdEGxj
 OIyW/2y6Ps/7wkS0RO2kabSpsdNDNaB8yoWQqFFjtKlwbhQaBb9ggF7Fick+x5WzjbHS
 d3HQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRnW/b41C6m46yldb+/HnNmjvnUfE2HEqa69hiDtBBuUdacb08QvS4S8luXEePaYy/0+f8Mj3aVkGNZSi9bTYA2N3m2A==
X-Gm-Message-State: AOJu0YzoVhfxrWQxntHQ+cXWI/W29FrWvWsiZPENxvrz6uC+mRcHJOBJ
 kJbhfu5FDQHXv54UEsu51kCiq++OWhKuA1UlYjDggbAQKioy3RViDrWdsB6ef7U=
X-Google-Smtp-Source: AGHT+IEt3nkdkOXxivC2YGdCjaoldYiYUmJxNJzA0TyNBmJBoLV1ShQVPioF11Uhe7d82JZHrKc0HQ==
X-Received: by 2002:a05:6830:6b0d:b0:703:6a3e:d3ca with SMTP id
 46e09a7af769-709234a9492mr749477a34.26.1721758484102; 
 Tue, 23 Jul 2024 11:14:44 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708f60d5368sm2137771a34.33.2024.07.23.11.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 11:14:43 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <promsoft@gmail.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v3 5/5] arm: exynos: Enable TRNG on E850-96 board
Date: Tue, 23 Jul 2024 13:14:39 -0500
Message-Id: <20240723181439.7089-6-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240723181439.7089-1-semen.protsenko@linaro.org>
References: <20240723181439.7089-1-semen.protsenko@linaro.org>
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
Changes in v3:
  - Fixed applying the defconfig changes on U-Boot/master branch

Changes in v2:
  - (none)

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
index 38b9968c1671..2949da24267f 100644
--- a/configs/e850-96_defconfig
+++ b/configs/e850-96_defconfig
@@ -11,6 +11,7 @@ CONFIG_DEFAULT_DEVICE_TREE="exynos/exynos850-e850-96"
 CONFIG_SYS_LOAD_ADDR=0x80000000
 # CONFIG_AUTOBOOT is not set
 # CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_CMD_RNG=y
 # CONFIG_NET is not set
 CONFIG_CLK_EXYNOS850=y
 # CONFIG_MMC is not set
-- 
2.39.2

