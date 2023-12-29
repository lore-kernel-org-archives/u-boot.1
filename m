Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C451C47074
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:51:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC53787C24;
	Fri, 29 Dec 2023 18:47:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RE1yCKAl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3368687B82; Fri, 29 Dec 2023 18:47:22 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A59A87BC6
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:47:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl1tq025732;
 Fri, 29 Dec 2023 11:47:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703872021;
 bh=okjgfNjXIyXAvxSoLkCId9UkgJQ4qtBpojpT6BFRE1I=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=RE1yCKAl/rpFgUXYghJjMmA1WbteNZBvQ4s7/95agT2IzCBYjHq+JqPW9sPsT4Q5z
 8aWby9ZAbsc+W5/YO0SpOArl6RbQQmSHgrSbg+ToVusYhTUfKrNuldctzPewArN0Vv
 ZwUwA3Phe+FpIch6X732jK6qEdhgAlKf27NlhwUg=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BTHl1J8066047
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Dec 2023 11:47:01 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Dec 2023 11:47:01 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Dec 2023 11:47:01 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl1oS005076;
 Fri, 29 Dec 2023 11:47:01 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: UBoot Mailing List <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Martyn Welch <martyn.welch@collabora.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon
 Glass <sjg@chromium.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 Bryan Brattlof <bb@ti.com>
Subject: [PATCH v2 13/26] arm: dts: k3-am654: remove duplicate mcu_uart0 node
Date: Fri, 29 Dec 2023 11:47:10 -0600
Message-ID: <20231229174656.634065-41-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231229174656.634065-28-bb@ti.com>
References: <20231229174656.634065-28-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1552; i=bb@ti.com;
 h=from:subject; bh=XMs0cGmPRC/Hi42pED30lyVFkdcWepe9hqQHNGpGpCY=;
 b=owNCWmg5MUFZJlNZ0TRHZQAAYv////d7l733brr3k56K+zvv3L6v296jv/a7/v7P3Xd/r/ewA
 Rq2B2oyA0aMQAANDRoAaGgBoaaAaA0AAAAGQyAADQyNNNMhjSNA9TIyYaaaiDJpoZANMIxGQDRi
 ZNDJhBpoAZNNAGEwjEGQxGQ0DQAMjTQA0aAANBoAGRHqA9IAaaAaaaNGhp6mjQBoaA0GRkAZA09
 Q0aNAA0AaGnqaGjIAZMmjE0GQNAAIIoVO6IjIL4FMvyAt4IwIx3syf8EOsewe/gCq14wklyKXdP
 k+cSYZjAbmWIJVBkJ/MIC5YEqMaSRzj2F64EjNqSt0LZpjaZV0FDsusCerlLalGKE6OVIL9hr3T
 cUpCSYabQjgCoh11aaLfxczIeB7FdIOVtxrNPjCfHJDd1gqRU0aaJVQ2J01JfWu9e//PZy9aqzi
 WJVuWObeVL55VPcbJ3hWm3Zlxm736PG6cbHm6fm7z3y2hNj8ElEikbVyMrem/dZGGzXstWrhAjA
 NEIAPZ9KP0bZL8yPNkiFar3BvDgauJduR+kGN5ayIYxFqrBMkPDxmfxUz+WRsKwOVA8kir0x4+3
 mtFF+sQ+xgHHQIA1CvqV4Egdyk4qfzZNODU1ywGR1qRwjUmK4Cj84S4/iZc7BuBdM0HoB07fkWA
 bQlDYjRBRc//F3JFOFCQ0TRHZQ=
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

With the Linux and U-Boot board dtb files unified we now have a
duplicate mcu_uart0 node. Remove it

Tested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-r5-base-board.dts | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index 19806ec4e2309..bdee47802b047 100644
--- a/arch/arm/dts/k3-am654-r5-base-board.dts
+++ b/arch/arm/dts/k3-am654-r5-base-board.dts
@@ -18,7 +18,6 @@
 		ethernet0 = &cpsw_port1;
 		remoteproc0 = &sysctrler;
 		remoteproc1 = &a53_0;
-		serial1 = &mcu_uart0;
 		serial2 = &main_uart0;
 		spi0 = &ospi0;
 		spi1 = &ospi1;
@@ -98,8 +97,6 @@
 };
 
 &mcu_uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mcu_uart0_pins_default>;
 	clock-frequency = <48000000>;
 	/delete-property/ power-domains;
 	status = "okay";
@@ -126,15 +123,6 @@
 		>;
 	};
 
-	mcu_uart0_pins_default: mcu_uart0_pins_default {
-		pinctrl-single,pins = <
-			AM65X_WKUP_IOPAD(0x0044, PIN_INPUT, 4)	/* (P4) MCU_OSPI1_D1.MCU_UART0_RXD */
-			AM65X_WKUP_IOPAD(0x0048, PIN_OUTPUT, 4)	/* (P5) MCU_OSPI1_D2.MCU_UART0_TXD */
-			AM65X_WKUP_IOPAD(0x004C, PIN_INPUT, 4)	/* (P1) MCU_OSPI1_D3.MCU_UART0_CTSn */
-			AM65X_WKUP_IOPAD(0x0054, PIN_OUTPUT, 4)	/* (N3) MCU_OSPI1_CSn1.MCU_UART0_RTSn */
-		>;
-	};
-
 	wkup_i2c0_pins_default: wkup-i2c0-pins-default {
 		pinctrl-single,pins = <
 			AM65X_WKUP_IOPAD(0x00e0, PIN_INPUT, 0) /* (AC7) WKUP_I2C0_SCL */
-- 
2.43.0

