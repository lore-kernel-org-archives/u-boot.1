Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26BEDC47258
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 03:07:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7535487C8E;
	Thu,  1 Feb 2024 04:06:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rxpiRoWE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4209287C93; Thu,  1 Feb 2024 04:06:50 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E1CF87C9E
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 04:06:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41136bP2082247;
 Wed, 31 Jan 2024 21:06:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706756797;
 bh=wfmN+lkHHbAJHIrfJV3F9S3PY7GDFsk7sLdrJ7AWr70=;
 h=From:To:CC:Subject:Date;
 b=rxpiRoWE39i/0A2dGtfpT76MgEFsIfPKNo1fd/4n8ud9HlkFA5iaeWjGMl9L8YIEX
 /Kxr48cLYWhhQW2cVBV9I6UTrKoT9CrzeVq3qTK19zpAoKPSU7W8FgnnN4R1f09vw3
 0BnuFu3Rmkm/Fbl4mXbFbZ7MjO79oiSoXB45B1PI=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41136bZm013781
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 31 Jan 2024 21:06:37 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 21:06:37 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 21:06:37 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41136air098171;
 Wed, 31 Jan 2024 21:06:36 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Hari
 Nagalla <hnagalla@ti.com>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Nishanth Menon <nm@ti.com>,
 Andrew Davis <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 UBoot Mailing List <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH] arm: dts: k3-am62p5: enable the wkup i2c bus
Date: Wed, 31 Jan 2024 21:06:35 -0600
Message-ID: <20240201030634.1120963-16-bb@ti.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1322; i=bb@ti.com;
 h=from:subject; bh=bMbm6EasAoULcYq4OYaetVllJEo5DnKCeF6bSWpgeV4=;
 b=owNCWmg5MUFZJlNZSeW4eAAAa3///v5J769/G37/3c/+3r9/6717y9faj/83X90r7f39+V6wA
 RtWUhoAADQAaAD1A0AaGINDTTQaAAGhoAAAAGQaDRkaAaZA0xDCep6maTTNqiHqAGgaA0AAAADa
 gNADQ0A0ANDRhGJpoMCGT1HqNNGgADTTTIAaA0G1HqeiHRp6g2oyNDamg0Bo0aAGmjTQ00GhpoN
 DQ0AaMhoyAGmIaGg0PU00AAyaAyBiAaDQAApBOAu1+AMeZsIaaJE0UOKy45E6C+gIaIpQ2Ij3nB
 ORUF0ARaK50nc5ScGckt5N7sSGnnMNQ1ng5qYqw8IOt4RGXo8r1DqVLBhTBDfrz7WiVVaoTn1h9
 8gBKa2KYWkgxmTMZy5Zex5rAWvtXF9oZPw8SHtPTKviL1irYXy8EuMQnNjoMTN3gRKu/4Dtlhq3
 I/enI/kaJ4jVjDnn8Gzx5KtRs8XiJ5A5eXf4sLqFGoy2IsUl4Jr19CCTEPdEsnBZwriXlzLSPXC
 5nzzjJKhRS+oQiQk2i+GWnJPZ9r1Bdg5Tv37dgHVfoRZmmrzGYmmUwsUnB4c59WoJ/vpN/iZTxc
 IQNQxM/dUlgoB4+KMMf+LNuQHCs1M+Ak+QVpsZFIIG7ANDskAeMTZNOapFV/zYxdPr7/RMIO6Sy
 IeUKMFmFAGYU60GfQTQP8XckU4UJBJ5bh4A
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

The PMIC for the am62p5-sk is connected to the i2c bus on the wakeup
island. While we do not have a driver yet, enable it anyway so we can
begin development of the driver and characterization of the board.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am62p5-sk.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/dts/k3-am62p5-sk.dts b/arch/arm/dts/k3-am62p5-sk.dts
index 9e4479aa78886..77298d31a986f 100644
--- a/arch/arm/dts/k3-am62p5-sk.dts
+++ b/arch/arm/dts/k3-am62p5-sk.dts
@@ -790,6 +790,13 @@
 &mcu_pmx0 {
 	bootph-all;
 
+	wkup_i2c0_pins_default: wkup-i2c0-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_MCU_IOPAD(0x04c, PIN_INPUT, 0)	/* (A13) WKUP_I2C0_SCL */
+			AM62PX_MCU_IOPAD(0x050, PIN_INPUT, 0)	/* (C11) WKUP_I2C0_SDA */
+		>;
+	};
+
 	wkup_uart0_pins_default: wkup-uart0-default-pins {
 		pinctrl-single,pins = <
 			AM62PX_MCU_IOPAD(0x02c, PIN_INPUT, 0)	/* (C7) WKUP_UART0_CTSn */
@@ -801,6 +808,13 @@
 	};
 };
 
+&wkup_i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_i2c0_pins_default>;
+	clock-frequency = <400000>;
+};
+
 &wkup_uart0 {
 	/* WKUP UART0 is used by DM firmware */
 	pinctrl-names = "default";

base-commit: b0d717b732ee28e446baf94522b3491e590f7fbb
-- 
2.43.0

