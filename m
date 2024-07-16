Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3AEC3DA4B
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 03:18:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 347FD8897B;
	Tue, 16 Jul 2024 05:17:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HHbt2c+0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86C94885EE; Tue, 16 Jul 2024 05:17:19 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FB6388962
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 05:17:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-70211abf4cbso3442861a34.3
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 20:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721099834; x=1721704634; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eox7hDxxdJPMvWrRggCbwpK9jjwlgKk46vxPcVNeUic=;
 b=HHbt2c+0O6Vz2RHElkmJ+eRlDGJ6ahD1YdKbFgYxWecmcrJLe9TA+Lu8dwEkWlcJsw
 FHcsXclkb5sZM7Ie8ABU2nfnYfeh10IlMQMRq0CHDzPaMOWuRd0UjlY56nePvPQmxtmK
 9aoMRnaefJuY4LgcEnQT0GfHxXtFMbsNtx1MF+JfJx6F8yooQY2ozSEsxf51p+2QJwnT
 F1kHvx+F/xyzFzhU2iIDr+X8TFVHNVUKQ20Wgtxc0iJm739IHLyewajyy2cZZ1Cx2gIX
 GcHUEXucbx/pCWiGiJ5QHDzXqTAhHjUyIo/fzbDuaCvxKupfylZcbvi5eZFxZp5gbST3
 4izA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721099834; x=1721704634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eox7hDxxdJPMvWrRggCbwpK9jjwlgKk46vxPcVNeUic=;
 b=aHXWZwMNyNqTIl89KhBGw2loJy4Bc/jzt4JFkv5JiZ8oOySo68UcoCRnjVhsX1Us7a
 6XdqkhYySKAWclW3yF6QT5r6LFN4+hderTOkRoPPOfRKj976NRBewYkdD3msn2JeWJ0y
 jcn76nKAzY627cyfundMm4ZXqnv9YdMZxbQACTPCtcHyKemnaxa2ZwyR7tRwkS9rBLt9
 91cfHNW/kUgREZPAwksBuNINKLEbU8FNpQeC5yH5KIoUS8OwBdQdd1f1I5Wra/xYfgqK
 3SKh8a8G6rks9SkYn5yRxji4iMTR1nYZshPsmMu7h1zHn8iMtffqWeuhsr+kcS52aU6z
 y7Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtLJ5FXsWhdO4jKx7Nny4NGfCXXfAoONGT4VuwC6HAE0o7ClgS/9n0fafDWip7EzEj2DHYrIXQX5l7gzyrA+uq1OP65w==
X-Gm-Message-State: AOJu0YzqWgU0t9a6L8QIW2AdCxOtA/tJLd+cYu8psHxmc4K/EUas1bKn
 9CRVm8HWbKJX+YxmXXcgmcSSv4RcXX7mtjq9Yshu1smh6u6VbBzhjk91S6U0PSg=
X-Google-Smtp-Source: AGHT+IGxX50X3dNxn7m2Q3W/yOhRVuKdvD4Mmtaj0ECxXwh8xIXlO7/DfHJ8YAcq3XmdGmw6omc8UA==
X-Received: by 2002:a05:6870:80c8:b0:25e:c7b:ca96 with SMTP id
 586e51a60fabf-260bdd5b25dmr675943fac.10.1721099834169; 
 Mon, 15 Jul 2024 20:17:14 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708c0c826a7sm1188532a34.38.2024.07.15.20.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 20:17:13 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Anand Moon <linux.amoon@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v2 5/5] arm: exynos: Enable TRNG on E850-96 board
Date: Mon, 15 Jul 2024 22:17:09 -0500
Message-Id: <20240716031709.24943-6-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240716031709.24943-1-semen.protsenko@linaro.org>
References: <20240716031709.24943-1-semen.protsenko@linaro.org>
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

