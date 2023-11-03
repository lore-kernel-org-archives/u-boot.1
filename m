Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E67C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 23:01:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9680487053;
	Sat,  4 Nov 2023 00:01:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="md7lbBGl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8764187488; Sat,  4 Nov 2023 00:01:11 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94BFF8703A
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 00:01:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5af15c3f734so3401167b3.1
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 16:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699052464; x=1699657264; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ek2m5EgU6prgnqXWBMO3d2M0QjEAfWuErANQ5crMJY0=;
 b=md7lbBGlnLrG1Bky+pP4aEDzsapABB/lNaOZwckmJZFUTR/u7LwwIIqFXb/KUBWpyD
 AJkYrSYP9W02O2ner9gBkC4halEPu5eNW7nLWzThHdEUBRnsaljvxT81XOTlyJHhMg20
 AAsA/3m2L1LKmi51qPNzNuAwZu8atVQtfemfIjPwrkEFw6QkLUctexh3QvZ01Y7/u+vI
 of+0RSNvTHRLW8SQF6qZnZzH+ZM6KinmYZFXPSRaBUHhrAxy1KPhmfQ+7eFZLv+JEN5D
 ybZUdZWMfLaiEmCACaxvx15KDA5JmRknUL/cFs3furugdHE8rVlt+SB0D5644g2uEwEp
 B5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699052464; x=1699657264;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ek2m5EgU6prgnqXWBMO3d2M0QjEAfWuErANQ5crMJY0=;
 b=AO+zx8KdGlkHmujoFcbsRRnvlMXti6231+8xji0xQdgEAFWcytzpRmPhCLvEtRj9At
 SHee2hYU6QH4NNGn14+G6PVRkVCD+fNcDB9eraP5wL7IhiI+Y/NmH+QKqwIxG9VdWetZ
 iKyJi46bGFRJxLTTO7+rRr2xoXa9pKssNcdpV+Kbn549ITILAOwzJOvFUP+c7ukuQIZQ
 36/wmQfpQPzdDpCQHIESjUVCBcJcnr84KynzTaRUXKYM0yuTF8Z4GYrO/pzwALKNmMWR
 fluhTgK+jq96Vai1DxgFzoKAQ1qa99bHprxrdlz809E0t4EJ/CPii8vJFtueJxn5exX7
 4fSg==
X-Gm-Message-State: AOJu0YxGZIngK/q7sSRh+B2CQNIeF3ZvkLiF2EZhOWBdpjsas0l04GKs
 /IZNxqsWogJJ905xQDVNbIM=
X-Google-Smtp-Source: AGHT+IGzgaUgcl2FmlNNyvjKRbe6hjYOususu3FPPWUOacGbOuCLCDSIOgGPNtmAp6jbMVjGpIGhTw==
X-Received: by 2002:a05:690c:3603:b0:5b5:9684:663e with SMTP id
 ft3-20020a05690c360300b005b59684663emr4207058ywb.0.1699052463747; 
 Fri, 03 Nov 2023 16:01:03 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:b4e9:3424:1f72:d6d3])
 by smtp.gmail.com with ESMTPSA id
 o63-20020a0dfe42000000b005463e45458bsm1472224ywf.123.2023.11.03.16.01.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 16:01:03 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: u-boot@lists.denx.de, egyszeregy@freemail.hu,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH] imx7d-pico-pi-u-boot.dtsi: Fix aliases indentation
Date: Fri,  3 Nov 2023 20:00:54 -0300
Message-Id: <20231103230054.64372-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Fabio Estevam <festevam@denx.de>

The aliases are currently indented using spaces.

Fix it to use the standard tab indentation.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 arch/arm/dts/imx7d-pico-pi-u-boot.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/dts/imx7d-pico-pi-u-boot.dtsi b/arch/arm/dts/imx7d-pico-pi-u-boot.dtsi
index 843b4583e53a..3a6294daff3b 100644
--- a/arch/arm/dts/imx7d-pico-pi-u-boot.dtsi
+++ b/arch/arm/dts/imx7d-pico-pi-u-boot.dtsi
@@ -1,11 +1,11 @@
 #include "imx7s-u-boot.dtsi"
 
 /{
-    aliases {
-        mmc0 = &usdhc3;
-        usb0 = &usbotg1;
-        display0 = &lcdif;
-    };
+	aliases {
+		mmc0 = &usdhc3;
+		usb0 = &usbotg1;
+		display0 = &lcdif;
+	};
 };
 
 &usbotg1 {
-- 
2.34.1

