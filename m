Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BC7FF512E
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 17:23:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8440A8404A;
	Tue,  7 Apr 2026 19:23:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.b="TpOQTbr6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 889B28405F; Tue,  7 Apr 2026 19:23:21 +0200 (CEST)
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DCB483F75
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 19:23:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan_b@posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 55684240103
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 19:23:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
 t=1775582599; bh=hsiZ4KDMFxbSWhjbWEgSHiucEdd7qPpFItgrltZaC7A=;
 h=From:To:Cc:Subject:Date:Message-Id:From;
 b=TpOQTbr6j1SUntan1AGUaO7zSNz+4poxhZSJS8e4dhAPFiS4pIvcMpGe4s5rWCnS3
 CK1eUBlivPPeKVQvnB6ew5COff1hbLzyTKyeqC8UEo/w70G0++sP7Vn6Nhgtjjxws4
 FV2QVAq2KT3NjjM4SnxFgeo14CRDoL4/eTpr/VyManDQFTbVvwbKp1Vr/VLuKDVtQT
 JjFLWKpjvJPp5cjtklciF53Z30/ff6CiExBjqRgoKaNtxHu4vJEX3v9rspzTaJSLGx
 H9uhP4s45shBTZYP0GeQzx2cmpPapWLOwRZfnWY3bvcmkJKEmSD3cJ7/i2DIBEN2Rw
 tf4vtD5LLeHiw==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4fqtMB5mZ7z6tvx;
 Tue,  7 Apr 2026 19:23:18 +0200 (CEST)
From: Stefan Bosch <stefan_b@posteo.net>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Stefan Bosch <stefan_b@posteo.net>
Subject: [PATCH v1] arm: dts: s5p4418: fix "mmc write failed" e.g. at cmd
 saveenv
Date: Tue, 07 Apr 2026 17:23:19 +0000
Message-Id: <20260407172155.3419-1-stefan_b@posteo.net>
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

s5p4418-pinctrl.dtsi: Fix mmc bus definitions to fix "mmc write failed"
e.g. when cmd saveenv is executed. Initialize all four GPIO of the
mmc-buses instead of only the first one.

Signed-off-by: Stefan Bosch <stefan_b@posteo.net>
---

 arch/arm/dts/s5p4418-pinctrl.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/s5p4418-pinctrl.dtsi b/arch/arm/dts/s5p4418-pinctrl.dtsi
index 0768d80fc95..639b6d2ca6d 100644
--- a/arch/arm/dts/s5p4418-pinctrl.dtsi
+++ b/arch/arm/dts/s5p4418-pinctrl.dtsi
@@ -35,7 +35,7 @@ pinctrl@C0010000 {
 	};
 
 	mmc0_bus4: mmc0-bus-width4 {
-		pins = "gpiob-1, gpiob-3, gpiob-5, gpiob-7";
+		pins = "gpiob-1", "gpiob-3", "gpiob-5", "gpiob-7";
 		pin-function = <1>;
 		pin-pull = <2>;
 		pin-strength = <1>;
@@ -56,7 +56,7 @@ pinctrl@C0010000 {
 	};
 
 	mmc1_bus4: mmc1-bus-width4 {
-		pins = "gpiod-24, gpiod-25, gpiod-26, gpiod-27";
+		pins = "gpiod-24", "gpiod-25", "gpiod-26", "gpiod-27";
 		pin-function = <1>;
 		pin-pull = <2>;
 		pin-strength = <1>;
@@ -77,7 +77,7 @@ pinctrl@C0010000 {
 	};
 
 	mmc2_bus4: mmc2-bus-width4 {
-		pins = "gpioc-20, gpioc-21, gpioc-22, gpioc-23";
+		pins = "gpioc-20", "gpioc-21", "gpioc-22", "gpioc-23";
 		pin-function = <2>;
 		pin-pull = <2>;
 		pin-strength = <1>;
-- 
2.17.1

