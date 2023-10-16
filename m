Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AB8CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 14:16:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD26486BF2;
	Mon, 16 Oct 2023 16:15:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="pvegxQqv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80A7586BB3; Mon, 16 Oct 2023 16:14:18 +0200 (CEST)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [217.70.183.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5147386B73
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 16:14:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.richard@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 18FAC2000C;
 Mon, 16 Oct 2023 14:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1697465655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VD9vgSRn8jxD4E4kzTgsuTA+oliUA191br6OOE9otqg=;
 b=pvegxQqvmJM6H0IEvXudZuIcfBNvp3kxTNyPDlRz8+H1XRanwrOOjsiUa5EcDf2icLOg2l
 crYxo+vGy6t1vPGRxidSb/ttf6R0UC4FcdhARgqXofncpThbwxYCaV3Msoz2YmHmzkQLGO
 zls1iKKKtXdVXWqFgLg1EB/cKTquEtRqqqM058doz5QB2XcHoTiziLsMtCJTUp9+qFQPLQ
 khPxHu9gBRGb2SCHqqbGumKTxNDjm5s60tKetkZEoX02+zt5fc6gqpUIbQj/YyfXS8sVMH
 242Ob2Y72woqRXYvP+8ov/cMMbSKgPKFhzy24XyBAFxw7Kgt9w77GkQgDdmSMA==
From: Thomas Richard <thomas.richard@bootlin.com>
To: u-boot@lists.denx.de
Cc: nm@ti.com, thomas.petazzoni@bootlin.com, thomas.richard@bootlin.com,
 gregory.clement@bootlin.com, u-kumar1@ti.com,
 Gowtham Tammana <g-tammana@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/9] DO NOT MERGE: arm: dts: k3-j7200-r5-common: Add pmic node
 for esm
Date: Mon, 16 Oct 2023 16:11:27 +0200
Message-Id: <20231016141135.325698-2-thomas.richard@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016141135.325698-1-thomas.richard@bootlin.com>
References: <20231016141135.325698-1-thomas.richard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.richard@bootlin.com
X-Mailman-Approved-At: Mon, 16 Oct 2023 16:15:29 +0200
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

From: Gowtham Tammana <g-tammana@ti.com>

Add pmic tps659413 node needed for ESM error event handling.

Signed-off-by: Gowtham Tammana <g-tammana@ti.com>
Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---

 arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
index e62f9218e8..2bf0d5e3c0 100644
--- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
+++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
@@ -249,13 +249,24 @@
 
 &wkup_i2c0 {
 	bootph-pre-ram;
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_i2c0_pins_default>;
+	clock-frequency = <400000>;
+
+	tps659413: tps659413@48 {
+		compatible = "ti,tps659413";
+		reg = <0x48>;
+		bootph-pre-ram;
+
+		regulators_a: regulators {
+			bootph-pre-ram;
+		};
+	};
+
 	lp876441: lp876441@4c {
 		compatible = "ti,lp876441";
 		reg = <0x4c>;
 		bootph-pre-ram;
-		pinctrl-names = "default";
-		pinctrl-0 = <&wkup_i2c0_pins_default>;
-		clock-frequency = <400000>;
 
 		regulators: regulators {
 			bootph-pre-ram;
-- 
2.39.2

