Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FDEC001B0
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 16:44:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9E1E8698D;
	Tue, 15 Aug 2023 18:44:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vWPl/cJW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FC2F869B4; Tue, 15 Aug 2023 18:44:48 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 168F38697B
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 18:44:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37FGihlc049228;
 Tue, 15 Aug 2023 11:44:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692117883;
 bh=cti9+mw8FVl1xw2gSuE4H+YhSIU64Jm5qwr5y50n++M=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=vWPl/cJWoKbW1wjHFNcuOYox0eP480Z3BksUaRDIZDE+IxpbLVT11Ynvx7GNy61uB
 J1+xfEnH50KdHEgLHfY5hntD8tFvNUZeArGXsINtKHWaWGx+p2U3RAzI4Iedkw2l+b
 0QLE7R0JWMMtvSw4fS+oMutkmaofPkCK0+IDa5iQ=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37FGihgc093252
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 15 Aug 2023 11:44:43 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 15
 Aug 2023 11:44:42 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 15 Aug 2023 11:44:42 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37FGigvV103636;
 Tue, 15 Aug 2023 11:44:42 -0500
From: Nishanth Menon <nm@ti.com>
To: <n-francis@ti.com>, <trini@konsulko.com>
CC: <bb@ti.com>, <praneeth@ti.com>, <afd@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V3 3/4] board: ti: am62x: Add am62x_beagleplay_* defconfigs
Date: Tue, 15 Aug 2023 11:44:39 -0500
Message-ID: <20230815164440.2713726-4-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230815164440.2713726-1-nm@ti.com>
References: <20230815164440.2713726-1-nm@ti.com>
MIME-Version: 1.0
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

Add defconfig fragments for am625 based beagleplay

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes since V2:
* Switch entirely to config fragments.

V2: https://lore.kernel.org/u-boot/20230727234446.3651836-4-nm@ti.com/
V1: https://lore.kernel.org/all/20230725185253.2123433-6-nm@ti.com/
 board/ti/am62x/beagleplay_a53.config | 20 ++++++++++++++++++++
 board/ti/am62x/beagleplay_r5.config  | 11 +++++++++++
 2 files changed, 31 insertions(+)
 create mode 100644 board/ti/am62x/beagleplay_a53.config
 create mode 100644 board/ti/am62x/beagleplay_r5.config

diff --git a/board/ti/am62x/beagleplay_a53.config b/board/ti/am62x/beagleplay_a53.config
new file mode 100644
index 000000000000..4889e1bc6f2b
--- /dev/null
+++ b/board/ti/am62x/beagleplay_a53.config
@@ -0,0 +1,20 @@
+# Defconfig fragment to apply on top of am62x_evm_a53_defconfig
+
+CONFIG_DEFAULT_DEVICE_TREE="k3-am625-beagleplay"
+CONFIG_OF_LIST="k3-am625-beagleplay"
+CONFIG_SPL_OF_LIST="k3-am625-beagleplay"
+CONFIG_BOOTCOMMAND="run findfdt; run envboot; run distro_bootcmd"
+CONFIG_EXT4_WRITE=y
+CONFIG_LZO=y
+CONFIG_AUTOBOOT_KEYED=y
+CONFIG_AUTOBOOT_PROMPT="Press SPACE to abort autoboot in %d seconds\n"
+CONFIG_AUTOBOOT_DELAY_STR="d"
+CONFIG_AUTOBOOT_STOP_STR=" "
+# Uses Realtek phy rather than TI phy
+CONFIG_PHY_TI_DP83867=n
+CONFIG_PHY_REALTEK=y
+# No SPI flash on Beagleplay
+CONFIG_SPI=n
+CONFIG_SPI_FLASH=n
+CONFIG_SPL_DM_SPI_FLASH=n
+CONFIG_SPL_SPI_FLASH_SUPPORT=n
diff --git a/board/ti/am62x/beagleplay_r5.config b/board/ti/am62x/beagleplay_r5.config
new file mode 100644
index 000000000000..ce64561bee92
--- /dev/null
+++ b/board/ti/am62x/beagleplay_r5.config
@@ -0,0 +1,11 @@
+# Defconfig fragment to apply on top of:
+# am62x_evm_r5_defconfig
+#
+CONFIG_DEFAULT_DEVICE_TREE="k3-am625-r5-beagleplay"
+CONFIG_OF_LIST="k3-am625-r5-beagleplay"
+CONFIG_SPL_OF_LIST="k3-am625-r5-beagleplay"
+# No SPI flash on Beagleplay
+CONFIG_SPI=n
+CONFIG_SPI_FLASH=n
+CONFIG_SPL_DM_SPI_FLASH=n
+CONFIG_SPL_SPI_FLASH_SUPPORT=n
-- 
2.40.0

