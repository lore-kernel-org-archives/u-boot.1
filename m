Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A68C47073
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:50:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E759987BFF;
	Fri, 29 Dec 2023 18:47:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KPlNkc6v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6A3C87B9D; Fri, 29 Dec 2023 18:47:18 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 364C887BB8
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:47:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl1pj025736;
 Fri, 29 Dec 2023 11:47:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703872021;
 bh=HKfO+/bTaIhKm4xdTJYdPm0dEN1YbMBC+y0rh4+9yaM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=KPlNkc6vsg9weREmmTU/t5rcjHIdTnHa9ovipcpLeGfkfCsrOBNCIp9Q/ynP1o39t
 xCe0L2CtIqPL5yCpKAtjY5AokxTshBKfFehpGT8yIINS415J5ZGpF5DXtODG4iUrR5
 6awiEvrmRy989n2yueGTBii5wUAL2byNJ0MbVvTM=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BTHl12P025024
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Dec 2023 11:47:01 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Dec 2023 11:47:01 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Dec 2023 11:47:01 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl1J4122691;
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
Subject: [PATCH v2 14/26] arm: dts: k3-am654: remove duplicate main_uart0
Date: Fri, 29 Dec 2023 11:47:11 -0600
Message-ID: <20231229174656.634065-42-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231229174656.634065-28-bb@ti.com>
References: <20231229174656.634065-28-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1584; i=bb@ti.com;
 h=from:subject; bh=Z8ksQB4sncA3Ya6Yk0mCyQo3DVerPp8VRH8jHlSDJbU=;
 b=owNCWmg5MUFZJlNZyY7BUQAAcH///v/b37Fz3Z3f//dN//v//7327KZeXdNF1P4v+f3v8nywA
 RswjtQA0ZANAGnqA0BoAaaAGTINBoaAxAABkGjQAAaAGhpkabU9R6hppkehMNIgHqDQNHqMhtTT
 QNAZGgDRkaD1AaAekNMQaAAPRAaDTINDJoNGQ0B6g0DINAyNDkPU0GmmRoAaDRo0DIGjJiBoDIy
 ZAyDTQaGmhiaMjEGgGEAZNAAyaYTRoAaAAG9CxtoETABwoiczQWELCTSbzrearDBosQCdeIu+L9
 oNXYzJ7FmKce7dg6CGoiKQFdpbizjwiSpuA8hGb2wA6E3Mwf86+R43AuUEBCysMoKEwQ11f5jQx
 IbwxczUGSBNhewPu8jd1bKqfxUAqZzWIe5ETpWRL9fq02HcguN3R4n3a4ccWe3qXEmj3YQv0j/v
 psRSfUvtjnqKI+QEZWQIqdG87AeR7p63bLQZQJV1kaBid6lfcGTLsFBgU0Cc5jPIsqI02ESRoRw
 all4Mzf76kQRhdCjFiF4hoEp6O04fzN5YcQ4oCvhjCqoJ0MLnIPdZhGTpvJn1g47riloAu2WsdK
 dQDxKEVdryHQwWpANF3WpSYENcaZVMi9l6oZugrjIALdk0MDhRw9o4aDNmrUw25ZoTKcEERKTPF
 xnCUAQo7UbxQXlJ/i7kinChIZMdgqI=
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

With the Linux and U-Boot board dtb files unified, we now have a
duplicate main_uart0 node. Remove it

Tested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-r5-base-board.dts | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index bdee47802b047..3d599a5413812 100644
--- a/arch/arm/dts/k3-am654-r5-base-board.dts
+++ b/arch/arm/dts/k3-am654-r5-base-board.dts
@@ -18,7 +18,6 @@
 		ethernet0 = &cpsw_port1;
 		remoteproc0 = &sysctrler;
 		remoteproc1 = &a53_0;
-		serial2 = &main_uart0;
 		spi0 = &ospi0;
 		spi1 = &ospi1;
 		usb0 = &usb0;
@@ -103,13 +102,6 @@
 	bootph-pre-ram;
 };
 
-&main_uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_uart0_pins_default>;
-	power-domains = <&k3_pds 146 TI_SCI_PD_SHARED>;
-	status = "okay";
-};
-
 &wkup_vtm0 {
 	compatible = "ti,am654-vtm", "ti,am654-avs";
 	vdd-supply-3 = <&vdd_mpu>;
@@ -148,15 +140,6 @@
 };
 
 &main_pmx0 {
-	main_uart0_pins_default: main-uart0-pins-default {
-		pinctrl-single,pins = <
-			AM65X_IOPAD(0x01e4, PIN_INPUT, 0)	/* (AF11) UART0_RXD */
-			AM65X_IOPAD(0x01e8, PIN_OUTPUT, 0)	/* (AE11) UART0_TXD */
-			AM65X_IOPAD(0x01ec, PIN_INPUT, 0)	/* (AG11) UART0_CTSn */
-			AM65X_IOPAD(0x01f0, PIN_OUTPUT, 0)	/* (AD11) UART0_RTSn */
-		>;
-	};
-
 	main_mmc0_pins_default: main_mmc0_pins_default {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x01a8, PIN_INPUT_PULLDOWN, 0)	/* (B25) MMC0_CLK */
-- 
2.43.0

