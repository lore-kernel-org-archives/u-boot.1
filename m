Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE6DBC4167B
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 16:18:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 772EF8751F;
	Tue,  7 Nov 2023 17:18:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="EuDMmFpm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00E138751C; Tue,  7 Nov 2023 17:18:49 +0100 (CET)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E073187518
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 17:18:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.richard@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3DE311C0013;
 Tue,  7 Nov 2023 16:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1699373926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XEjNhwV11lLYJfLwEoEcPQ50k+zcLiL2H8TTcz2T9rI=;
 b=EuDMmFpmHM3GnfOnFXGOgl6i8xt1SnzPpiFR9uTyGLJDh6VsFPgst/OW1w39zVu5euSr05
 i5z8vbxUEOj/bGwPpj7CVfnEIAaCiP5BUgFraR3UXbkcvBKLxMRI5iE1q5CS3qMDIgaZ1O
 4NGdz//N1yB9DjCMNpzqgmhcoq7cgjS6JybSrEAW0byHZGmx0Prtq/HO3bpMuTq9sr6VKu
 ZOkONfn+9O7/RzhWRxiJHjbR9BHqiwesfdzseCy6zXmzvN7KL6ifL4HCflyX30eFlt1JrX
 iPZqiFBpIN9iX1T0O9L13JMcZweNxtw3SifvbZWjINVujakKabPW+w1xy5SuLQ==
From: Thomas Richard <thomas.richard@bootlin.com>
To: u-boot@lists.denx.de
Cc: nm@ti.com, thomas.richard@bootlin.com, thomas.petazzoni@bootlin.com,
 gregory.clement@bootlin.com, u-kumar1@ti.com,
 Gowtham Tammana <g-tammana@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 1/8] DO NOT MERGE: arm: dts: k3-j7200-r5-common: Add pmic
 node for esm
Date: Tue,  7 Nov 2023 17:17:55 +0100
Message-Id: <20231107161802.855154-2-thomas.richard@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107161802.855154-1-thomas.richard@bootlin.com>
References: <20231107161802.855154-1-thomas.richard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.richard@bootlin.com
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

(no changes since v1)

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

