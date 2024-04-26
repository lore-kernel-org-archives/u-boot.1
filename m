Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B426CC4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 15:44:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1FFD88354;
	Fri, 26 Apr 2024 17:44:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dC7/4BdB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F03EF88384; Fri, 26 Apr 2024 17:44:29 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 883AC8833D
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 17:44:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43QFiOEO094152;
 Fri, 26 Apr 2024 10:44:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1714146264;
 bh=nRX+ZAX+6hjl+tj3MUv2LsEFk4sMr297iIOdWsBKRdA=;
 h=From:To:CC:Subject:Date;
 b=dC7/4BdBFfL7OgZDghdkbtMdqB9yg/45t+m3BxnN2UINxC/fDj//3qgiCU5dNzOXO
 24GDu1fgDoDbWr5a0fGQuAEvI9aqrzSdTwRrJHH1ZOEELJI/ndrypNZrd8mhoRtNMN
 ybdSoxS2ihMt4KVQ+yYnpX5zdeWWVl4RHa7RvHTU=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43QFiNkr017160
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 26 Apr 2024 10:44:23 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 26
 Apr 2024 10:44:23 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 26 Apr 2024 10:44:23 -0500
Received: from ula0226330.dhcp.ti.com (ula0226330.dhcp.ti.com [128.247.81.8])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43QFiNW8069470; 
 Fri, 26 Apr 2024 10:44:23 -0500
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH] arm: mach-k3: am62ax: Fix typo in ROM data macro name
Date: Fri, 26 Apr 2024 10:44:23 -0500
Message-ID: <20240426154423.10547-1-afd@ti.com>
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

s/ENTENDED/EXTENDED

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/mach-k3/am62a7_init.c                 | 2 +-
 arch/arm/mach-k3/include/mach/am62a_hardware.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/am62a7_init.c b/arch/arm/mach-k3/am62a7_init.c
index 2a0221a3718..658828cf75f 100644
--- a/arch/arm/mach-k3/am62a7_init.c
+++ b/arch/arm/mach-k3/am62a7_init.c
@@ -31,7 +31,7 @@ static void store_boot_info_from_rom(void)
 	bootindex = *(u32 *)(CONFIG_SYS_K3_BOOT_PARAM_TABLE_INDEX);
 
 	if (IS_ENABLED(CONFIG_CPU_V7R)) {
-		memcpy(&bootdata, (uintptr_t *)ROM_ENTENDED_BOOT_DATA_INFO,
+		memcpy(&bootdata, (uintptr_t *)ROM_EXTENDED_BOOT_DATA_INFO,
 		       sizeof(struct rom_extended_boot_data));
 	}
 }
diff --git a/arch/arm/mach-k3/include/mach/am62a_hardware.h b/arch/arm/mach-k3/include/mach/am62a_hardware.h
index 11080801c4c..cd61abe0185 100644
--- a/arch/arm/mach-k3/include/mach/am62a_hardware.h
+++ b/arch/arm/mach-k3/include/mach/am62a_hardware.h
@@ -66,7 +66,7 @@
 #define MCU_CTRL_DEVICE_CLKOUT_32K_CTRL		(MCU_CTRL_MMR0_BASE + 0x8058)
 #define MCU_CTRL_DEVICE_CLKOUT_LFOSC_SELECT_VAL	(0x3)
 
-#define ROM_ENTENDED_BOOT_DATA_INFO		0x43c3f1e0
+#define ROM_EXTENDED_BOOT_DATA_INFO		0x43c3f1e0
 
 #define K3_BOOT_PARAM_TABLE_INDEX_OCRAM         0x7000F290
 
-- 
2.39.2

