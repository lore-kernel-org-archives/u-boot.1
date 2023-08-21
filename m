Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C11EE4993
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 13:59:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66A908689A;
	Mon, 21 Aug 2023 15:59:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dLHUSs0n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EEFF8679C; Mon, 21 Aug 2023 15:59:17 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 952E5807BC
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 15:59:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37LDxCXa060622;
 Mon, 21 Aug 2023 08:59:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692626352;
 bh=3Muj25T4QZ4hfHlcPmSvR/5ykAOrNR4AR12j6YSmKQw=;
 h=From:To:CC:Subject:Date;
 b=dLHUSs0njoV+xEW5+8nbZ2ymsi/JNVNbZgzYqfw4kWhxRQzzH33GI3qXT4oPV6Kjb
 WZRMTIsN6DS/yl771m5FlBJ2dB3Aka9oUvJL3dUA/b9Vv+TgJ9c55ZOqVDja6Qat40
 Z4XVvIFIfW2df6f+WPW/lKNVh5VAqfX/xWLqohHM=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37LDxCtf105318
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 21 Aug 2023 08:59:12 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 21
 Aug 2023 08:59:12 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 21 Aug 2023 08:59:11 -0500
Received: from fllv0040.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37LDxBF2061359; 
 Mon, 21 Aug 2023 08:59:11 -0500
From: Andrew Davis <afd@ti.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>
CC: Andrew Davis <afd@ti.com>
Subject: [PATCH] configs: Enable CONFIG_DM_SCSI in am57xx_hs_evm_usb
Date: Mon, 21 Aug 2023 08:59:10 -0500
Message-ID: <20230821135910.55795-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
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

This should have already been enabled but was missed when converting the
base platform defconfig, fix this here.

Fixes: 3c5aa6caccab ("configs: Enable CONFIG_BLK in am57xx_evm and am57xx_hs_evm")
Signed-off-by: Andrew Davis <afd@ti.com>
---
 configs/am57xx_hs_evm_usb_defconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/am57xx_hs_evm_usb_defconfig b/configs/am57xx_hs_evm_usb_defconfig
index 404e714d4f0..9ed59ac9aec 100644
--- a/configs/am57xx_hs_evm_usb_defconfig
+++ b/configs/am57xx_hs_evm_usb_defconfig
@@ -70,7 +70,7 @@ CONFIG_NET_RETRY_COUNT=10
 CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
-CONFIG_SCSI_AHCI=y
+CONFIG_DWC_AHCI=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
@@ -102,7 +102,7 @@ CONFIG_PMIC_PALMAS=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_PALMAS=y
 CONFIG_PALMAS_POWER=y
-CONFIG_SCSI_AHCI_PLAT=y
+CONFIG_DM_SCSI=y
 CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
-- 
2.39.2

