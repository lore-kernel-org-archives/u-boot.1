Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4D4C47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 11:45:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48D3987CE2;
	Wed, 31 Jan 2024 12:44:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gyoI+6HJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A04087947; Wed, 31 Jan 2024 07:02:50 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54F198792D
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 07:02:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40V62jIx117552;
 Wed, 31 Jan 2024 00:02:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706680965;
 bh=7hT0oPmsTABgG8Wa/nMKLygmsmEb5ID7JqAGv2TCwss=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=gyoI+6HJj2Vi0GwTqr7vc4930uBl/h5pQEjhudIwhkngCYOx2MVVZer8La821JFIb
 AItn3Y2jg9uRzrDpgwFah7GaFPIaP1XEp2r5YA+Y4qk5ramGBFWj/C8eHyyrKlYFmc
 /MPoF3nA9wdAkAAVOeV81b9ObF75Vtc89cnIu5pE=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40V62jGG107390
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 31 Jan 2024 00:02:45 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 00:02:45 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 00:02:45 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.227.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40V62Uth062916;
 Wed, 31 Jan 2024 00:02:43 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <vigneshr@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH 07/10] board: ti: am64x: evm: Remove redundant DDR functions
Date: Wed, 31 Jan 2024 11:32:10 +0530
Message-ID: <20240131060213.1128024-8-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131060213.1128024-1-s-k6@ti.com>
References: <20240131060213.1128024-1-s-k6@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Wed, 31 Jan 2024 12:44:04 +0100
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

Remove the redundant DDR functions and include the common file to
access the functions.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 board/ti/am64x/evm.c | 71 ++++----------------------------------------
 1 file changed, 5 insertions(+), 66 deletions(-)

diff --git a/board/ti/am64x/evm.c b/board/ti/am64x/evm.c
index a7ca6be436eb..e3ba4bd70801 100644
--- a/board/ti/am64x/evm.c
+++ b/board/ti/am64x/evm.c
@@ -16,6 +16,7 @@
 #include <env.h>
 
 #include "../common/board_detect.h"
+#include "../common/k3-ddr-init.h"
 
 #define board_is_am64x_gpevm() (board_ti_k3_is("AM64-GPEVM") || \
 				board_ti_k3_is("AM64-EVM") || \
@@ -31,28 +32,6 @@ int board_init(void)
 	return 0;
 }
 
-int dram_init(void)
-{
-	s32 ret;
-
-	ret = fdtdec_setup_mem_size_base();
-	if (ret)
-		printf("Error setting up mem size and base. %d\n", ret);
-
-	return ret;
-}
-
-int dram_init_banksize(void)
-{
-	s32 ret;
-
-	ret = fdtdec_setup_memory_banksize();
-	if (ret)
-		printf("Error setting up memory banksize. %d\n", ret);
-
-	return ret;
-}
-
 #if defined(CONFIG_SPL_LOAD_FIT)
 int board_fit_config_name_match(const char *name)
 {
@@ -97,52 +76,12 @@ static int fixup_usb_boot(const void *fdt_blob)
 }
 #endif
 
-#if defined(CONFIG_K3_AM64_DDRSS)
-static void fixup_ddr_driver_for_ecc(struct spl_image_info *spl_image)
-{
-	struct udevice *dev;
-	int ret;
-
-	dram_init_banksize();
-
-	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
-	if (ret)
-		panic("Cannot get RAM device for ddr size fixup: %d\n", ret);
-
-	ret = k3_ddrss_ddr_fdt_fixup(dev, spl_image->fdt_addr, gd->bd);
-	if (ret)
-		printf("Error fixing up ddr node for ECC use! %d\n", ret);
-}
-#else
-static void fixup_memory_node(struct spl_image_info *spl_image)
-{
-	u64 start[CONFIG_NR_DRAM_BANKS];
-	u64 size[CONFIG_NR_DRAM_BANKS];
-	int bank;
-	int ret;
-
-	dram_init();
-	dram_init_banksize();
-
-	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
-		start[bank] =  gd->bd->bi_dram[bank].start;
-		size[bank] = gd->bd->bi_dram[bank].size;
-	}
-
-	/* dram_init functions use SPL fdt, and we must fixup u-boot fdt */
-	ret = fdt_fixup_memory_banks(spl_image->fdt_addr, start, size, CONFIG_NR_DRAM_BANKS);
-	if (ret)
-		printf("Error fixing up memory node! %d\n", ret);
-}
-#endif
-
 void spl_perform_fixups(struct spl_image_info *spl_image)
 {
-#if defined(CONFIG_K3_AM64_DDRSS)
-	fixup_ddr_driver_for_ecc(spl_image);
-#else
-	fixup_memory_node(spl_image);
-#endif
+	if (IS_ENABLED(CONFIG_K3_INLINE_ECC))
+		fixup_ddr_driver_for_ecc(spl_image);
+	else
+		fixup_memory_node(spl_image);
 
 #if CONFIG_IS_ENABLED(USB_STORAGE)
 	fixup_usb_boot(spl_image->fdt_addr);
-- 
2.34.1

