Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30BBDC47074
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:48:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82DE887BC3;
	Fri, 29 Dec 2023 18:47:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CT89/WaA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F115587BDC; Fri, 29 Dec 2023 18:47:14 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C547087B8A
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl1LV032448;
 Fri, 29 Dec 2023 11:47:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703872021;
 bh=HeGty3E8gcYKOsANSvF3viRYtVtL+cm9nZROa9Car/A=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=CT89/WaAFD1QELVzhx7239CsvbQRa9zr0++/YeE4HpJjEG567NbY4bZVfXkAOyrHc
 nv8W07Q7yd57Y1nH4yPcS2Cn95UwS0TZlqmzTPcya3JG0/yw5lQuPj+cImr9q3yFSd
 8/Kn9XYBeCdkLq5w/mU84b2vj5jqcODssP34JVeI=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BTHl1A8115356
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Dec 2023 11:47:01 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Dec 2023 11:47:01 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Dec 2023 11:47:01 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl1U5005097;
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
Subject: [PATCH v2 20/26] arm: dts: k3-am654: remove duplicate mdio
Date: Fri, 29 Dec 2023 11:47:17 -0600
Message-ID: <20231229174656.634065-48-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231229174656.634065-28-bb@ti.com>
References: <20231229174656.634065-28-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=950; i=bb@ti.com;
 h=from:subject; bh=zW1APBGhL8FVVbJdv2ZvgQO55NZ6/xf6RD4zWHRePbw=;
 b=owNCWmg5MUFZJlNZ3Hv2XgAAaH///7bP42+2eVbX7Z/++/p+0rv6+5f13n+n9Y7J//9bvPewA
 RswjtQNAaDJo0aGgNAAaAaBoNAGgBoNBpo000AZNMhoNA0DQZBp6mjJoyNGDQxRBkZBiMgYQAAA
 0ekyaMQA2oDQAMj1Gg00xGNJkDRoBo0eoekaGgBoZGgaADkPUD1MgaGE0GgMjRkyYmTIaAAAA0y
 MQxBkMINGhoAZMEDBNA00ADQaAABmDXhobFAhAUQEYQ6E5DICDgR+ZhMzNFHJRUgE5HIXLub0c9
 C1er7+BNqbnAieHaogC+RXTPFt7AohoIAN4NZOXlztXaSYWgjotK1n3FJKS+iy3zLQR2uSZWfjh
 UM4bEF7KgNn+C/JJ30+utDHjWT7IaXlwtmnxThwMFgB8M6xMrOgjM42mRchY79krVlOPN0HcDRM
 EaY6pX1HyqfiRoV6SKzQLhmqCYaHKZfWQ38EXC+4Ml9Oi5wYrXqxE5l0cWriZf0wIS5p1zJtDNP
 MSmdKEvGkIazI63m2bNWUQoQD+DAsVpXXYoY7dMHolobPBMWbUcJPhKe1ANcuCPVXDKkgTQZg55
 stQW5QV2AbbAFopEEDS2COrcvGnS7MepUMCDTBj495XhrEpw+GJ32WosIyqIn5CqE+2BvD60mdW
 26FL/f4u5IpwoSG49+y8A==
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
duplicate mdio node. Remove it

Tested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-r5-base-board.dts | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index 8e57c77cba923..14bf1b4c8a462 100644
--- a/arch/arm/dts/k3-am654-r5-base-board.dts
+++ b/arch/arm/dts/k3-am654-r5-base-board.dts
@@ -159,15 +159,6 @@
 	/delete-property/ assigned-clock-parents;
 };
 
-&davinci_mdio {
-	phy0: ethernet-phy@0 {
-		reg = <0>;
-		/* TODO: phy reset: TCA9555RTWR(i2c:0x21)[p04].GPIO_MCU_RGMII_RSTN */
-		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
-		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
-	};
-};
-
 &mcu_cpsw {
 	reg = <0x0 0x46000000 0x0 0x200000>,
 	      <0x0 0x40f00200 0x0 0x2>;
-- 
2.43.0

