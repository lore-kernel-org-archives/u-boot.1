Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED40D1CDA1
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 06:05:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5367088FC4;
	Tue, 22 Oct 2024 08:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="bpYeBC90";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8778088FA9; Tue, 22 Oct 2024 08:04:36 +0200 (CEST)
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7BD388F4B
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 08:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 2024102206043260f325bcf053ba996f for <u-boot@lists.denx.de>;
 Tue, 22 Oct 2024 08:04:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=33QB1cQ3NTSXbL0UtgY6v2lJz57vchqb9Z8WGR6j4WM=;
 b=bpYeBC90UR2CB9yFjAonxVT/76Ni5N8pTsQOqkPaAOmVSDCSJ39pz6XrHgUcbBJR3eUyhB
 KGL6Y0c56xmizzU2cryyRK/1jWGTJIU98OC4vqimn82zA9JHTj4H2enokxrhVcZx+7nYPN1j
 xJYlPg0dyt795ClQKcWe3w3vNmUdVhR6z7COy2YBVsb8XRxDw9PxmtFH2daifkQYATRL361C
 yH7V4y8XVyOeb+HX77vMjYZWkIIM3SL4/R7wAxjXMo1jolbQAaa8xoPI1Esm2s2aTofj6GNF
 xxxJUH4gdehyMWSJydBYDD5v7gWGUiogbEIybj0HI6x6nK0olKJZkRxg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bryan Brattlof <bb@ti.com>,
	Nishanth Menon <nm@ti.com>
Subject: [PATCH v2 04/13] board: siemens: iot2050: Pass DDR size from FSBL
Date: Tue, 22 Oct 2024 08:04:21 +0200
Message-ID: <e9d96144f125af640a8d88609da0e164ee89c2f1.1729577070.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1729577070.git.jan.kiszka@siemens.com>
References: <cover.1729577070.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
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

From: Baocheng Su <baocheng.su@siemens.com>

Due to new DDR size introduction, the current logic of determining the
DDR size is not able to get the correct size.

Instead, the DDR size is determined by the FSBL(SEBOOT) then passed to
u-boot through the scratchpad info.

The SEBoot version must be >= D/V01.04.01.02 to support this change.

Also now for some variants, the DDR size may > 2GB, so borrow some code
from the TI evm to iot2050 to support more than 2GB DDR.

Signed-off-by: Baocheng Su <baocheng.su@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 board/siemens/iot2050/board.c | 39 ++++++++++++++++++++++++++---------
 doc/board/siemens/iot2050.rst |  3 +++
 include/configs/iot2050.h     |  3 +++
 3 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/board/siemens/iot2050/board.c b/board/siemens/iot2050/board.c
index 85cb999f17f..16082ae2afe 100644
--- a/board/siemens/iot2050/board.c
+++ b/board/siemens/iot2050/board.c
@@ -38,6 +38,8 @@ struct iot2050_info {
 	u8 mac_addr_cnt;
 	u8 mac_addr[8][ARP_HLEN];
 	char seboot_version[40 + 1];
+	u8 padding[3];
+	u32 ddr_size_mb;
 } __packed;
 
 /*
@@ -341,25 +343,42 @@ int board_init(void)
 
 int dram_init(void)
 {
-	if (board_is_advanced())
-		gd->ram_size = SZ_2G;
-	else
-		gd->ram_size = SZ_1G;
+	struct iot2050_info *info = IOT2050_INFO_DATA;
+	gd->ram_size = ((phys_size_t)(info->ddr_size_mb)) << 20;
 
 	return 0;
 }
 
+ulong board_get_usable_ram_top(ulong total_size)
+{
+	/* Limit RAM used by U-Boot to the DDR low region */
+	if (gd->ram_top > 0x100000000)
+		return 0x100000000;
+
+	return gd->ram_top;
+}
+
 int dram_init_banksize(void)
 {
 	dram_init();
 
-	/* Bank 0 declares the memory available in the DDR low region */
-	gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
-	gd->bd->bi_dram[0].size = gd->ram_size;
+	if (gd->ram_size > SZ_2G) {
+		/* Bank 0 declares the memory available in the DDR low region */
+		gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+		gd->bd->bi_dram[0].size = SZ_2G;
+
+		/* Bank 1 declares the memory available in the DDR high region */
+		gd->bd->bi_dram[1].start = CFG_SYS_SDRAM_BASE1;
+		gd->bd->bi_dram[1].size = gd->ram_size - SZ_2G;
+	} else {
+		/* Bank 0 declares the memory available in the DDR low region */
+		gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+		gd->bd->bi_dram[0].size = gd->ram_size;
 
-	/* Bank 1 declares the memory available in the DDR high region */
-	gd->bd->bi_dram[1].start = 0;
-	gd->bd->bi_dram[1].size = 0;
+		/* Bank 1 declares the memory available in the DDR high region */
+		gd->bd->bi_dram[1].start = 0;
+		gd->bd->bi_dram[1].size = 0;
+	}
 
 	return 0;
 }
diff --git a/doc/board/siemens/iot2050.rst b/doc/board/siemens/iot2050.rst
index ee3c5c95846..d0c0a412097 100644
--- a/doc/board/siemens/iot2050.rst
+++ b/doc/board/siemens/iot2050.rst
@@ -29,6 +29,9 @@ The following binaries from that source need to be present in the build folder:
  - seboot_pg1.bin
  - seboot_pg2.bin
 
+Note that SE-Boot D/V01.04.01.02 or greater is required, otherwise the DDR size
+will not be picked up correctly by U-Boot.
+
 When using the watchdog, a related firmware for the R5 core(s) is needed, e.g.
 https://github.com/siemens/k3-rti-wdt. The name and location of the image is
 configured via CONFIG_WDT_K3_RTI_FW_FILE.
diff --git a/include/configs/iot2050.h b/include/configs/iot2050.h
index 0f92e0d25dc..5c58c7bbaab 100644
--- a/include/configs/iot2050.h
+++ b/include/configs/iot2050.h
@@ -24,6 +24,9 @@
 	func(USB, usb, 2)
 #endif
 
+/* DDR Configuration */
+#define CFG_SYS_SDRAM_BASE1		0x880000000
+
 /*
  * This defines all MMC devices, even if the basic variant has no mmc1.
  * The non-supported device will be removed from the boot targets during
-- 
2.43.0

