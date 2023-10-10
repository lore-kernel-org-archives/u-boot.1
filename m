Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7593CD8CAE
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 18:28:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD9E5863C3;
	Tue, 10 Oct 2023 20:27:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XAfHwyoJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DABE863F9; Tue, 10 Oct 2023 20:27:51 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99E8286335
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 20:27:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matwey.kornilov@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-504a7f9204eso7350632e87.3
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 11:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696962467; x=1697567267; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Kq1GVtswWBkpzob0/tIl4K+Gj2dUwgQ1UsZP/FPx7lg=;
 b=XAfHwyoJADc7FZQRUe2vE93qNn1t8DFen0bEZRmBcG5mb/HRVXo4Am9z+RcnjWJgHT
 tb1YMMRizzqB/AgLYW41ePt1CkbmvAeWdGnESo5e/e2WNjxXQBlyejz7XNFazpGzdGVX
 4Yk4xQOos89LYwDMt3aApcmKX0TZrYIO3lV15lRHF2BWt3hcSTP3/O73tSG416BH2tNR
 vn2C8uDgmIFiiZKdLyUViKph0WfrkQFjgMJH/lZy3iPzTei6A8B8QhmFaAu8ov0LeIuI
 RrAIK7CcF49qL4EP7rj/EeES9/5b+j+eW5VpHveQwQb05FyGAvGKziI4rrBrHRfICXYk
 wo/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696962467; x=1697567267;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kq1GVtswWBkpzob0/tIl4K+Gj2dUwgQ1UsZP/FPx7lg=;
 b=F2ujoRgDf3PamxIRf3bJoPMba8RPmwuHaDpeLAL6K18PkaKYNg+RT0vlQAuV1ZeQrq
 YP7/6C58F3sev3Y5tphVKyOZkaCvS/qq4eXOKP8ckIdprS/E9Zw+Zgwdspt4K4WnfNaw
 Ue73EUpw49mR5FY+gCvg+2Ge94ye22hVHrz7DyX59jJHMvy4/zCHKSXnNC9UwBH3Ehtt
 kO55Yokj548btpeSqNu1ch7Y01b0BPuZHGA2Y4CRokjJQ7zL1/T8CphUOIPhzQXruL35
 5XKpzIos0zkcGjGEtPQ0Q8oEQXX5FZPJrbsEnBtO8P9DCED62vGqf+YBjfUD1KcJXeR7
 xqsg==
X-Gm-Message-State: AOJu0Yz6ojNGIw0Lz5tJXr8+xqwmcOjhMdFHDWw6D8OzLGtNohw4z12W
 2FBqNFtvcl+TgjU4hrXAMyw=
X-Google-Smtp-Source: AGHT+IF2VbCw1W3QSXMxh9sLs8r5uiTHQ5T9ddEq2Lp7jVLaRMVaSo6k3z1Iml/N8UzT+tM67xH+5w==
X-Received: by 2002:a05:6512:3ca4:b0:500:b5db:990b with SMTP id
 h36-20020a0565123ca400b00500b5db990bmr20555542lfv.47.1696962466383; 
 Tue, 10 Oct 2023 11:27:46 -0700 (PDT)
Received: from oak.local ([2001:470:dcf4:ac:3d32:3f57:7d31:52b3])
 by smtp.gmail.com with ESMTPSA id
 f15-20020a056512092f00b004fe461aab36sm1914775lft.129.2023.10.10.11.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 11:27:45 -0700 (PDT)
From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
To: sjg@chromium.org,
	philipp.tomsich@vrull.eu,
	kever.yang@rock-chips.com
Cc: u-boot@lists.denx.de,
	"Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Subject: [PATCH] rockchip: dts: rk3328: Sync rock64 device tree file from Linux
Date: Tue, 10 Oct 2023 21:27:38 +0300
Message-Id: <20231010182738.31929-1-matwey.kornilov@gmail.com>
X-Mailer: git-send-email 2.35.3
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

Sync the rk3328-rock64 dts from v6.6-rc5.

See Linux kernel commit for details:

    03633c4ef1fb ("arm64: dts: rockchip: fix USB regulator on ROCK64")

Signed-off-by: Matwey V. Kornilov <matwey.kornilov@gmail.com>
---
 arch/arm/dts/rk3328-rock64.dts | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/arm/dts/rk3328-rock64.dts b/arch/arm/dts/rk3328-rock64.dts
index f69a38f42d..0a27fa5271 100644
--- a/arch/arm/dts/rk3328-rock64.dts
+++ b/arch/arm/dts/rk3328-rock64.dts
@@ -37,7 +37,8 @@
 		vin-supply = <&vcc_io>;
 	};
 
-	vcc_host_5v: vcc-host-5v-regulator {
+	/* Common enable line for all of the rails mentioned in the labels */
+	vcc_host_5v: vcc_host1_5v: vcc_otg_5v: vcc-host-5v-regulator {
 		compatible = "regulator-fixed";
 		gpio = <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
@@ -48,17 +49,6 @@
 		vin-supply = <&vcc_sys>;
 	};
 
-	vcc_host1_5v: vcc_otg_5v: vcc-host1-5v-regulator {
-		compatible = "regulator-fixed";
-		gpio = <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&usb20_host_drv>;
-		regulator-name = "vcc_host1_5v";
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&vcc_sys>;
-	};
-
 	vcc_sys: vcc-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
-- 
2.35.3

