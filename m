Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEE2C02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 09:50:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2A58809A4;
	Tue, 18 Feb 2025 10:50:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RIyvCyse";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D48480C72; Tue, 18 Feb 2025 10:50:06 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D00AC807F1
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 10:50:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51I9nxX21521346
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Feb 2025 03:49:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739872199;
 bh=dPDaup+CZpoQBSbPz2YdW2N8fwEDToZYFVlEZgKlzYw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=RIyvCyseG4L54i6BBpoB/cJOSx/DwWZA7DiRJZC6fFHsgzR6JEd4ILoydteGzMGkW
 2j/dc6JCoFt5XL+4xTESt/zQWFTfFFq9B4payu0ElgUzcDDnaZJYO1v+drpJv/weSu
 s5Ac3XQLGxYA7wKjzOshfutSbPQGUsKbBOQaf90A=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51I9nxT5016176
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 18 Feb 2025 03:49:59 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Feb 2025 03:49:59 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Feb 2025 03:49:59 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.113])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51I9no5a064686; 
 Tue, 18 Feb 2025 03:49:55 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <j-choudhary@ti.com>,
 <n-francis@ti.com>, <m-chawdhry@ti.com>, <jm@ti.com>,
 <j-humphreys@ti.com>, <u-kumar1@ti.com>, <seanga2@gmail.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 1/2] configs: j784s4_evm_r5_defconfig: enable USB DFU boot
Date: Tue, 18 Feb 2025 15:19:44 +0530
Message-ID: <20250218094950.2542006-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218094950.2542006-1-s-vadapalli@ti.com>
References: <20250218094950.2542006-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

The USB0 instance of USB on J784S4 SoC is a Cadence USB Controller and
supports USB DFU boot. Enable support for it.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 configs/j784s4_evm_r5_defconfig | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/configs/j784s4_evm_r5_defconfig b/configs/j784s4_evm_r5_defconfig
index a307055c5d..5a5b0458b9 100644
--- a/configs/j784s4_evm_r5_defconfig
+++ b/configs/j784s4_evm_r5_defconfig
@@ -62,6 +62,7 @@ CONFIG_SYS_SPI_U_BOOT_OFFS=0x80000
 CONFIG_SPL_THERMAL=y
 CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_HUSH_PARSER=y
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_TIME=y
@@ -84,6 +85,7 @@ CONFIG_SPL_CLK=y
 CONFIG_SPL_CLK_CCF=y
 CONFIG_SPL_CLK_K3_PLL=y
 CONFIG_SPL_CLK_K3=y
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x40000
 CONFIG_DMA_CHANNELS=y
 CONFIG_TI_K3_NAVSS_UDMA=y
 CONFIG_TI_SCI_PROTOCOL=y
@@ -142,6 +144,19 @@ CONFIG_DM_THERMAL=y
 CONFIG_TIMER=y
 CONFIG_SPL_TIMER=y
 CONFIG_OMAP_TIMER=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_SPL_DM_USB_GADGET=y
+CONFIG_USB_CDNS3=y
+CONFIG_USB_CDNS3_GADGET=y
+CONFIG_SPL_USB_CDNS3_GADGET=y
+CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0451
+CONFIG_USB_GADGET_PRODUCT_NUM=0x6168
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_SPL_DFU=y
 CONFIG_FS_EXT4=y
 CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
 CONFIG_PANIC_HANG=y
-- 
2.43.0

