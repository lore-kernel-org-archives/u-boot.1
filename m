Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC68C43327
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 10:29:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9097284AE9;
	Wed,  1 Jul 2026 12:29:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JE+Hkcjj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F1E384BA3; Wed,  1 Jul 2026 12:29:36 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F042684A7C
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 12:29:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-493a7bd27c2so4161655e9.3
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 03:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782901773; x=1783506573; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R2mZ5VzLeR//uWFEBLiRWNl7PqxKleqxZWS1sTfQjB0=;
 b=JE+HkcjjFgAP7Yle3NuUtAiuKA7JKJ7ul3ByMlEZg6wb21suSadJFPh+Bk7sl/2rNm
 N4C66Fs7GLZj1KoZ7BOoFMu5o0TiBDvZm0tWyb5Is9rDz0DUdp7GVofafvxlcYQ0TMcS
 Zm0GrdFnkuTSUFvkNc4LvC6oPEVATjBBOcO6xKfVjmwd/oAQbE2eq7kWUG3lCANoemKm
 0AzG2lZ0vZWSaeNTvfIJ1JjqjdnFtTJ8Px/3PVSAOyDh/F5Xd6TM0K90E7fg6DlX9mC6
 Y2RwycIZ/QAj4Ds0MfDrP1XUxL/5Cqymq7cv3exNuJInqqQdhyAcAgLA4MDeWZmpWGUz
 U0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901773; x=1783506573;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R2mZ5VzLeR//uWFEBLiRWNl7PqxKleqxZWS1sTfQjB0=;
 b=ZuYqAsFk3WRfnUDgDc7E+/2c/HdxxEeIwuUJYbxBeGeHY1R3az2EYsFJ4DiOBHymgX
 E2HdQr76yWQEF4+U0JSJxf89vyhRHPfqcLzzgQAf5cA5ALQZAsrCh62h1XT5W4/UkR8U
 kbXL5BWB2cVWW5b+9ry4+v8QeYJ0wqkQiqwRMXvLdL5dFRFaRyGe5iUVgiU00oW2RT7+
 NcB9uzuoYtGyurcgNlLr7hcHW90j4Kh+CE7JI6SmCQgX3+4IO15jMAut9/iYZ0YEoFl9
 osS23m3sVjEc8Sy+5xDjxo/qyr2XHQQ89A2UQwPqfo68cEEVUR56IsE6WAmLNzTXHjZG
 svLQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8VggAwbB7TJsZJ6w5heVfgFIH7oH3Ue6FGT/3O/1yoGXNf3NlNuuOxCWJh3ewAj8XrqhBfOb0=@lists.denx.de
X-Gm-Message-State: AOJu0YyYpnb/HAckWDWLJopT0vnt8OF5s6+Q1v+dtM9MIZ7yftytX5Hd
 rgY3RwafVTwM1moCoGWZJsBS2a+hpdaCc7JmH7v+K4Ir+oDq3+bWYCg13+hGcBKKkGs=
X-Gm-Gg: AfdE7cnc4L6DV45/ayauVwD21+wXsYHZBY0QscLpjM7fTQeqmi7i6D/F9x0iVDrP9Fa
 3Y73RoBWvcJ7ryTh6Hsxp721RKHfx8l6yrey+uMFRlUhf+NDjetBGbBCqTlOK02FAKPa3BBJZxC
 jPhhySoLx5fehIE0te/zyMlRLWerDSYGKSCXVuYGSuBw47ru5AgWRpEc75a0IKQAnLWIfMZ98wn
 13H/BcX7Eo0TWc2sONEmEX/yB7LHzeb4AI8Fll69E8UM/LCpIcjA6gyAgYp9KUVyLY7GSep5KuU
 BuRLbamGjrojyytv+SNP+SUHhOhR7cPfZRp0f1r6hMITiKO+AJmFjj3/30vDK7YvuITgQKbJApQ
 C5vFTWpFZ/Vtxtn3ArH9Ge3buzzyMBRf131qxbf8UNwCSZ02Xn4rjc7ky9NPrCwodnISY5T4pKu
 dDALokdigUJPX0Z0FfDC2mI+s/0ulT1W3bMpaw
X-Received: by 2002:a05:600c:8214:b0:493:9cb3:53fc with SMTP id
 5b1f17b1804b1-493c2b253abmr17995175e9.11.1782901773376; 
 Wed, 01 Jul 2026 03:29:33 -0700 (PDT)
Received: from toyger.tail248178.ts.net ([212.133.41.27])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bef1807asm41352975e9.1.2026.07.01.03.29.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:29:31 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>,
 Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: u-boot-qcom@groups.io, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH] dts: qcom: remove hardcoded memory maps
Date: Wed,  1 Jul 2026 12:19:33 +0200
Message-ID: <20260701101937.234609-5-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.54.0
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

Qualcomm boards have traditionally relied on a prior bootloader stage
to populate the memory map in devicetree, and when that wasn't available
the memory map would instead be hardcoded.

With proper support for SMEM in U-Boot the memory map can now
dynamically be read out of the SMEM database which is populated on boot
by the preloader (sbl1).

Switch over all the boards that previously relied on hardcoded memory
maps to use SMEM instead. This has been tested on the Rubik Pi 3 and
db410c however other platforms still need testing (see below).

This affects the following boards:

* IPQ5424 RDP466
* IPQ9574 RDP433
* QCS615 Ride
* QCS6490 RB3 Gen 2
* QCS8300 Ride
* QCS9100 Ride

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
This patch is based on the qcom-next branch found on the Qualcomm U-Boot
Custodian repository [1]. For testing please check out that branch,
apply this patch and then build/boot U-Boot. Ensure that you have
CONFIG_LOGLEVEL set to >=6 and look for the "Memory map loaded from"
message during boot, it should say SMEM.

If nothing is broken in U-Boot and Linux then please send your Tested-by
indicating which board(s) you tried as a "#" comment after your email.

[1]: https://source.denx.de/u-boot/custodians/u-boot-snapdragon

Cc: u-boot-qcom@groups.io
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/dts/ipq5424-rdp466-u-boot.dtsi  |  6 ------
 arch/arm/dts/ipq9574-rdp433-u-boot.dtsi  |  9 ---------
 arch/arm/dts/qcs615-ride-u-boot.dtsi     | 14 --------------
 arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi | 23 -----------------------
 arch/arm/dts/qcs8300-ride-u-boot.dtsi    | 19 -------------------
 arch/arm/dts/qcs9100-ride-r3-u-boot.dtsi | 20 --------------------
 6 files changed, 91 deletions(-)
 delete mode 100644 arch/arm/dts/qcs615-ride-u-boot.dtsi
 delete mode 100644 arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
 delete mode 100644 arch/arm/dts/qcs8300-ride-u-boot.dtsi
 delete mode 100644 arch/arm/dts/qcs9100-ride-r3-u-boot.dtsi

diff --git a/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi b/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi
index 36640f31d616..3b7897b909c7 100644
--- a/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi
+++ b/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi
@@ -5,14 +5,8 @@
  * Copyright (c) 2025 The Linux Foundation. All rights reserved.
  */
 
 / {
-	/* Will be removed when SMEM parsing is updated */
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x0 0x80000000 0x0 0x20000000>;
-	};
-
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
 };
diff --git a/arch/arm/dts/ipq9574-rdp433-u-boot.dtsi b/arch/arm/dts/ipq9574-rdp433-u-boot.dtsi
index 390e2338d659..f50d75d59852 100644
--- a/arch/arm/dts/ipq9574-rdp433-u-boot.dtsi
+++ b/arch/arm/dts/ipq9574-rdp433-u-boot.dtsi
@@ -2,17 +2,8 @@
 /*
  * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
-/ {
-	/* Will be removed when SMEM parsing is updated */
-	memory@40000000 {
-		device_type = "memory";
-		reg = <0x0 0x40000000 0x0 0x40000000>,
-		      <0x0 0x4a500000 0x0 0x00100000>;
-	};
-};
-
 &sdhc_1 {
 	sdhci-caps-mask = <0x0 0x04000000>;
 	sdhci-caps = <0x0 0x04000000>;	/* SDHCI_CAN_VDD_180 */
 
diff --git a/arch/arm/dts/qcs615-ride-u-boot.dtsi b/arch/arm/dts/qcs615-ride-u-boot.dtsi
deleted file mode 100644
index 68fffc70fcb4..000000000000
--- a/arch/arm/dts/qcs615-ride-u-boot.dtsi
+++ /dev/null
@@ -1,14 +0,0 @@
-// SPDX-License-Identifier: BSD-3-Clause
-/*
- * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
- */
-
-/ {
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x0 0x80000000 0x0 0x7a00000>,
-		      <0x0 0x89600000 0x0 0x30100000>,
-		      <0x0 0xc0000000 0x0 0xc0000000>,
-		      <0x1 0x80000000 0x1 0x00000000>;
-	};
-};
diff --git a/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi b/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
deleted file mode 100644
index c3ec4a317f7c..000000000000
--- a/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
+++ /dev/null
@@ -1,23 +0,0 @@
-// SPDX-License-Identifier: BSD-3-Clause
-/*
- * Copyright (c) 2024 Linaro Ltd.
- */
-/ {
-	/* When running as the primary bootloader there is no prior
-	 * stage to populate the memory layout for us. We *should*
-	 * have two nodes here, but ABL does NOT like that.
-	 * sooo we're stuck with this.
-	 */
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0 0x80000000 0 0x3A800000>,
-		      <0 0xC0000000 0 0x01800000>,
-		      <0 0xC3400000 0 0x3CC00000>,
-		      <1 0x00000000 1 0x00000000>;
-	};
-};
-
-// RAM Entry 0 : Base 0x0080000000  Size 0x003A800000
-// RAM Entry 1 : Base 0x00C0000000  Size 0x0001800000
-// RAM Entry 2 : Base 0x00C3400000  Size 0x003CC00000
-// RAM Entry 3 : Base 0x0100000000  Size 0x0100000000
diff --git a/arch/arm/dts/qcs8300-ride-u-boot.dtsi b/arch/arm/dts/qcs8300-ride-u-boot.dtsi
deleted file mode 100644
index 8c353ace71e1..000000000000
--- a/arch/arm/dts/qcs8300-ride-u-boot.dtsi
+++ /dev/null
@@ -1,19 +0,0 @@
-// SPDX-License-Identifier: BSD-3-Clause
-/*
- * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
- */
-
-/ {
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x0 0x80000000 0x0 0x11a80000>,
-		      <0x0 0xc0000000 0x0 0x10000000>,
-		      <0x0 0xd3100000 0x0 0x26b00000>,
-		      <0xe 0x80000000 0x1 0x00000000>,
-		      <0xa 0x80000000 0x1 0x80000000>,
-		      <0x0 0xb0800000 0x0 0x0f200000>,
-		      <0x0 0xd0100000 0x0 0x01800000>,
-		      <0x0 0x91b00000 0x0 0x1e500000>;
-	};
-};
-
diff --git a/arch/arm/dts/qcs9100-ride-r3-u-boot.dtsi b/arch/arm/dts/qcs9100-ride-r3-u-boot.dtsi
deleted file mode 100644
index 5905dfad18f1..000000000000
--- a/arch/arm/dts/qcs9100-ride-r3-u-boot.dtsi
+++ /dev/null
@@ -1,20 +0,0 @@
-// SPDX-License-Identifier: BSD-3-Clause
-/*
- * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
- */
-
-/ {
-	/* Will be removed when bootloader updates later */
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x0 0x80000000 0x0 0x3ee00000>,
-		      <0x0 0xc0000000 0x0 0x04d00000>,
-		      <0xd 0x00000000 0x2 0x54100000>,
-		      <0xa 0x80000000 0x1 0x52d00000>,
-		      <0x9 0x00000000 0x1 0x80000000>,
-		      <0x1 0x00000000 0x2 0xf7500000>,
-		      <0x0 0xd0000000 0x0 0x00100000>,
-		      <0x0 0xd3500000 0x0 0x07c00000>,
-		      <0x0 0xdb300000 0x0 0x24d00000>;
-	};
-};
-- 
2.54.0

