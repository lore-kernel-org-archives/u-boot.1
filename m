Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24BDAC47074
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:50:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 666C187BE4;
	Fri, 29 Dec 2023 18:47:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NeEaMCgl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A4DC87B9D; Fri, 29 Dec 2023 18:47:18 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CF8E87BB7
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:47:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl1ZA088965;
 Fri, 29 Dec 2023 11:47:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703872021;
 bh=FwE3n6/sR4lepyctUuclFTlrP0v1oE914a6z7jj/ui4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=NeEaMCglFZeaaRTOhrqMmi+nXGnbsWlM6Vzd2T9uk5GBlEtQZ1PADhr9muzI0MmWc
 bHSra/Nxc1ZwxxQXuH6meCyFU8E9DsXp0rvEKtgVh0xfGMEkhvQuXajpwiww3LLjz0
 KvLSsr0vIxox19XQHr6vOWMkhxEJvJ20cLsh0YTI=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BTHl1Ob063455
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Dec 2023 11:47:01 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Dec 2023 11:47:01 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Dec 2023 11:47:01 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl1nh005083;
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
Subject: [PATCH v2 16/26] arm: dts: k3-am654: remove duplicate sdhci1 pinmux
 node
Date: Fri, 29 Dec 2023 11:47:13 -0600
Message-ID: <20231229174656.634065-44-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231229174656.634065-28-bb@ti.com>
References: <20231229174656.634065-28-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1966; i=bb@ti.com;
 h=from:subject; bh=BWiGtbQst7fB3faRE1OnjTD6k1MEkPgpbGpXdKP2brM=;
 b=owNCWmg5MUFZJlNZlkarbAAAXP/////bvzW8zXmWB5923kZn660u117t697lf7573nn/++ywA
 RszUh6gAABoGmgaMg0NA0aNBo0AAGmRoBoAeUDRkDQ0PKAaNAeoeoD0g9PSm9KHTRoGgABoxqDT
 1DTTIGgbQjQZMRoDTTEDTQBkA0GTTTEaekDR6gNGRpp6IxGQZEYCGGhANGgGCAaGRkMgaA00yZA
 0ZNAaGgGBGI00ZGhoBo0YhoZGQMGDb2lK3AicWKQ4MsRZXO5FqswD+LDOR6h23if3BjFJkBuhHZ
 PcBMBbNdnUUBu8QbdmXU4ntFXRzT3RS9bbzMb1g1LGQAGBDLibZ5ASsETai02CG4pFfwBjyOEbQ
 QVKhlyHAELH7D2Gv5fMlXa7TAs/0xKC79KfzRF0EwfdLnWqIwd54XV68IYpKuQbsOcuJGfyGyA9
 d3BQ/HbNGx7bcMDaxoq4lCV0mRanGfQkCo7mz7uqX5fWa7ABUl1aIBruTW8xceg8IJW4Xv1qJej
 9ZU9bw6ZN8UsQlKJ1w+6Jm5Q8Jl028q/VWUz5sfkoftaCX++FiJKeo/8MflvwVxZ9Y/tKNsOFzQ
 hPqg7fQJDGEICLvUU3y1at4oIRCJNUM9mTpmboKZuGCBcB2QjM1/kYBGOGcNOosW/cinCAOREHh
 16V6hAmQLuSKcKEhLI1W2A=
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
duplicate sdhci1 pinmux node. Remove it

Tested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-r5-base-board.dts | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index f28245b12b6f6..9d7467acd30c9 100644
--- a/arch/arm/dts/k3-am654-r5-base-board.dts
+++ b/arch/arm/dts/k3-am654-r5-base-board.dts
@@ -140,19 +140,6 @@
 };
 
 &main_pmx0 {
-	main_mmc1_pins_default: main_mmc1_pins_default {
-		pinctrl-single,pins = <
-			AM65X_IOPAD(0x02d4, PIN_INPUT_PULLDOWN, 0)	/* (C27) MMC1_CLK */
-			AM65X_IOPAD(0x02d8, PIN_INPUT_PULLUP, 0)	/* (C28) MMC1_CMD */
-			AM65X_IOPAD(0x02d0, PIN_INPUT_PULLUP, 0)	/* (D28) MMC1_DAT0 */
-			AM65X_IOPAD(0x02cc, PIN_INPUT_PULLUP, 0)	/* (E27) MMC1_DAT1 */
-			AM65X_IOPAD(0x02c8, PIN_INPUT_PULLUP, 0)	/* (D26) MMC1_DAT2 */
-			AM65X_IOPAD(0x02c4, PIN_INPUT_PULLUP, 0)	/* (D27) MMC1_DAT3 */
-			AM65X_IOPAD(0x02dc, PIN_INPUT_PULLUP, 0)	/* (B24) MMC1_SDCD */
-			AM65X_IOPAD(0x02e0, PIN_INPUT, 0)		/* (C24) MMC1_SDWP */
-		>;
-	};
-
 	usb0_pins_default: usb0_pins_default {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x02bc, PIN_OUTPUT, 0) /* (AD9) USB0_DRVVBUS */
@@ -180,12 +167,18 @@
 	/delete-property/ power-domains;
 };
 
+/*
+ * MMC is probed to pull in firmware, so any clock
+ * or power-domain operation will fail as we do not
+ * have the firmware running at this point. Delete the
+ * power-domain properties to avoid making calls to
+ * SYSFW before it is loaded. Public ROM has already
+ * set it up for us anyway.
+ */
 &sdhci1 {
 	clock-names = "clk_xin";
 	clocks = <&clk_200mhz>;
-	pinctrl-0 = <&main_mmc1_pins_default>;
 	/delete-property/ power-domains;
-	ti,driver-strength-ohm = <50>;
 };
 
 &wkup_i2c0 {
-- 
2.43.0

