Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977E1E7E0D5
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 18:33:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AF6D805D7;
	Mon,  9 Feb 2026 19:32:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VwRtZhD8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C9D383CE3; Mon,  9 Feb 2026 19:32:32 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59F5183C5E
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 19:32:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-59e4989dacdso2530778e87.1
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 10:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770661950; x=1771266750; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tbc6tIm7EI/lv6UGErsDcaMEAGG4sAnxPKcRCkBRjoc=;
 b=VwRtZhD8i19jcC4beqSZ2NoIGRTWNfyjceSqRJS1x287evYCZJvldWh0a+hdfT42Ii
 2ExtGh6jkR6pBx0jf5eqeyEXEv8x3F+g2V/PZStQmmG2RF6irMQJgPMUG4fKTROfWje0
 fRd2zHVG1OZltF8Q7VuEDrACl6AeMUIyXPJRjbebKczRvMGywphFfDaf8bGwqW6ouRv8
 avR/YcqJ9G7U6KAfptsVONQgeJkt/7NxYUx93Co17Goe5MCOUgoDCyVwp9doOjt03Ip1
 Phm2q+08WEyOcHhcYAMB6buAZ+rBarjJth5yE77D82Jm84Nu4YwEiQbkbeANdUVYbh/Q
 onWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770661950; x=1771266750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Tbc6tIm7EI/lv6UGErsDcaMEAGG4sAnxPKcRCkBRjoc=;
 b=W+hCqgXN/kNMYeoHvZq1xMiG6HK8/dtQsxdG22QlY20KKRWOwDy4Gm6Nmgni4lHD2e
 RtmBW7z9Vnw4kWIwXfUsw0aoRXO72bSRJyPgfcq4j3oylCUfVXDmW3tD955+Eeum37+r
 7dmJZGrsCWfIlITNKCU5hAFXvUZGSJW65jqqEZxVz6rXEqLMQu5bn39ayNdQEKV7DJUs
 +38/V2gYEsBwrfyJfRKfYKZ4nlv/vsm8e3uF+89zZZ8NESWAMRsSpoS8MQCqIOA6sIBd
 VDuVqGPQept37rpE4fUiJkqYe1fSfyaQOlldXs5Y+QSyQWiV6eq3Ra7hS+pXZ22U0/fj
 f7xA==
X-Gm-Message-State: AOJu0YxcorLpVVIy34mjrm6SKObuXwTgbsMviAGfoWsFJbice3E+xKyB
 BwmaqgcgFC45FPtLORB2KshEGCGNuBIQNCi6RjBKIyxaO1UNh64N18YV
X-Gm-Gg: AZuq6aJJ28Rdx8TbV4tK8xXUrxE6Nwe9+pnQvsLflL5dEfu7LD1+WTiQMx8lsgM+L6L
 YrQQt17LF9PVjdAiy+jFJV5VipRh0LFMuvW0L0JVcENkcIYIlTTJw8WKXgcVE3mrZxyoqzkou+O
 uziM2AauK5HRKFioS1G3D4RyuR3CQGrRJx+6xM91a7tOF6R7qMOZocNaBpP1LYzP5HknW2ziBXY
 DKP5E69XbZTWbyl6/QGHG0u/T+XxFjIVkcUBQVyRm7juwFjHzduZ9JDkMUPq1EsZe4wgQrpVQCb
 MNghPMpgicFC5CFAgI1IacrAIv7Y0ISB9pxDMOKLI6xm5azfMw5mGG5V5JriMhJjBNZmkJLqwWx
 raMysdclfQb+bd7d/JD3gdjAPr5zoneWtL+b5EuMygJEzzZ7dHSqZJhdJHtEIWVIIpZ5Ujw0Sff
 s3
X-Received: by 2002:a05:6512:1294:b0:59d:f545:f2da with SMTP id
 2adb3069b0e04-59e45045940mr4028564e87.8.1770661949431; 
 Mon, 09 Feb 2026 10:32:29 -0800 (PST)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59e44d299ffsm2815391e87.55.2026.02.09.10.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:32:29 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Ion Agorria <ion@agorria.com>, Peter Robinson <pbrobinson@gmail.com>,
 Peter Geis <pgwipeout@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 4/6] ARM: tegra: remove unsupported properties from the
 max8907 node
Date: Mon,  9 Feb 2026 20:32:17 +0200
Message-ID: <20260209183219.34250-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209183219.34250-1-clamor95@gmail.com>
References: <20260209183219.34250-1-clamor95@gmail.com>
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

Remove interrupt and GPIO controller properties from MAX8907 node since
the PMIC does not have any GPIO cells and does not expose any interrupt
features.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/tegra20-lg-star.dts            | 6 ------
 arch/arm/dts/tegra20-samsung-n1-common.dtsi | 6 ------
 2 files changed, 12 deletions(-)

diff --git a/arch/arm/dts/tegra20-lg-star.dts b/arch/arm/dts/tegra20-lg-star.dts
index 083598b1b92..8012b57e5bb 100644
--- a/arch/arm/dts/tegra20-lg-star.dts
+++ b/arch/arm/dts/tegra20-lg-star.dts
@@ -327,13 +327,7 @@
 		pmic: max8907@3c {
 			compatible = "maxim,max8907";
 			reg = <0x3c>;
-
 			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
-			#interrupt-cells = <2>;
-			interrupt-controller;
-
-			#gpio-cells = <2>;
-			gpio-controller;
 
 			maxim,system-power-controller;
 
diff --git a/arch/arm/dts/tegra20-samsung-n1-common.dtsi b/arch/arm/dts/tegra20-samsung-n1-common.dtsi
index 8223c5ece54..7225047caba 100644
--- a/arch/arm/dts/tegra20-samsung-n1-common.dtsi
+++ b/arch/arm/dts/tegra20-samsung-n1-common.dtsi
@@ -319,13 +319,7 @@
 		pmic: max8907@3c {
 			compatible = "maxim,max8907";
 			reg = <0x3c>;
-
 			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
-			#interrupt-cells = <2>;
-			interrupt-controller;
-
-			#gpio-cells = <2>;
-			gpio-controller;
 
 			maxim,system-power-controller;
 
-- 
2.51.0

