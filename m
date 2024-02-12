Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBDCC4829B
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 15:53:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FD6B871C0;
	Mon, 12 Feb 2024 16:53:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dde5YVoC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9497A876D3; Mon, 12 Feb 2024 16:53:38 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BFA5871C0
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 16:53:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41CFrYx9056951;
 Mon, 12 Feb 2024 09:53:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1707753214;
 bh=f5AKA1efAH97j9uStlDfKUXnIlSN7we7UkURMepdFoI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=dde5YVoC+OT2aXcazvm1QmSNQnXAdNcyeeWofFAV5GyXYvHxWXLTZ2fU42wJbj+sM
 ZIRz6d556FLuaXDq4wznYWTdVLdMVpHkErp4Kddw8LB0BNMz3NAXCRHJ8sdUFIGNRA
 PNuipB05uQ60adZjjjbFQcvJ66IRbu3gKWisEZC8=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41CFrYX3001981
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 12 Feb 2024 09:53:34 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 09:53:33 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 09:53:33 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41CFrXp4028869;
 Mon, 12 Feb 2024 09:53:33 -0600
From: Nishanth Menon <nm@ti.com>
To: Robert Nelson <robertcnelson@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 3/4] arm: mach-k3: am62: Add Debounce configuration register
 definitions
Date: Mon, 12 Feb 2024 09:53:31 -0600
Message-ID: <20240212155332.541949-4-nm@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212155332.541949-1-nm@ti.com>
References: <20240212155332.541949-1-nm@ti.com>
MIME-Version: 1.0
Organization: Texas Instruments, Inc.
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

Add the Debounce configuration registers that need to be configured one
time for the platform for the entire SoC.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-k3/include/mach/am62_hardware.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-k3/include/mach/am62_hardware.h b/arch/arm/mach-k3/include/mach/am62_hardware.h
index 54380f36e161..06fcab01a5b7 100644
--- a/arch/arm/mach-k3/include/mach/am62_hardware.h
+++ b/arch/arm/mach-k3/include/mach/am62_hardware.h
@@ -75,6 +75,9 @@
 
 #define CTRLMMR_MCU_RST_CTRL			(MCU_CTRL_MMR0_BASE + 0x18170)
 
+/* Debounce register configuration */
+#define CTRLMMR_DBOUNCE_CFG(index)		(MCU_CTRL_MMR0_BASE + 4080 + (index * 4))
+
 #define ROM_EXTENDED_BOOT_DATA_INFO		0x43c3f1e0
 
 #define TI_SRAM_SCRATCH_BOARD_EEPROM_START	0x43c30000
-- 
2.43.0

