Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7DDE7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 10:32:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDDC48027E;
	Fri, 13 Dec 2024 11:32:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PzoewFzc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B111780219; Fri, 13 Dec 2024 11:32:07 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AA468012C
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 11:32:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BDAW3SY3074886
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Dec 2024 04:32:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734085923;
 bh=GqwlAjIW3AtVGP2x4cjBybgVVyWKld51oq8E4m7KKYU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=PzoewFzcGSBN0MQLByQTJXUz6sFIwWhtRxxVK7tpPncAS6Q1gCfbooPLiBoBRCjxZ
 DUi7PaLZ4X6xrd3bQ8RY56ow5SO/niUekglg8qO+9xIsUZ0WlF63rkD5O3if+bMCKx
 LGnBOy8PZIrbR//sT9nhYqplBlTeESnMhntd03gI=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BDAW2LQ006986
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 13 Dec 2024 04:32:03 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 13
 Dec 2024 04:32:02 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 13 Dec 2024 04:32:02 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.227.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BDAVpq7067253;
 Fri, 13 Dec 2024 04:31:59 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <bb@ti.com>, <m-chawdhry@ti.com>, <vaishnav.a@ti.com>, <j-choudhary@ti.com>
CC: <u-boot@lists.denx.de>, <w.egorov@phytec.de>, <n-francis@ti.com>,
 <s-k6@ti.com>
Subject: [PATCH v5 2/9] ram: k3-ddrss: Use the DDR controller BIST engine for
 ECC priming
Date: Fri, 13 Dec 2024 16:01:22 +0530
Message-ID: <20241213103129.332246-3-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213103129.332246-1-s-k6@ti.com>
References: <20241213103129.332246-1-s-k6@ti.com>
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

From: Georgi Vlaev <g-vlaev@ti.com>

The 1-bit inline ECC support in TI's DDRSS bridge requires
the configured memory regions to be preloaded with a pattern
before use. This is done by the k3-ddrss driver from the
R5 SPL in a 'for' loop. It takes around 10 seconds to fill
2GB of memory, for example. Memset can cut the time in half
and using DMA currently yields a similar result.

The BIST engine of DDR controller provides support for
initializing any memory region with a pattern. This
bypasses the DDRSS bridge, so the required inline ECC
data is not computed and populated in the memory. For
some values like zero, the computed ECC syndrome is also
zero and we can use these values to preload the memory
from the DDR controller, without the assistance of the
bridge.

The registers involved in the process are described in the
'DDR controller registers' topic in [1] AM62 and [2] J721E
reference manuals.

The patch replaces the 'for' loop memory fill function with
the BIST memory initialization procedure. This cuts the time
to preload the 2GB memory from 10 seconds down to 1 second.
The bist preload function uses the lpddr4 APIs in the k3-ddrss,
so this is compatible with devices with both 16-bit LPDDR4 and
32-bit LPDDR4 interfaces (e.g J721E).

[1] AM62x: https://www.ti.com/lit/pdf/spruiv7
[2] DRA829/TDA4VM: https://www.ti.com/lit/zip/spruil1

Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/ram/k3-ddrss/k3-ddrss.c | 122 +++++++++++++++++++++++++++++---
 1 file changed, 114 insertions(+), 8 deletions(-)

diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index 6e9202b95796..c29eec62bd8f 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -6,6 +6,7 @@
  */
 
 #include <config.h>
+#include <time.h>
 #include <clk.h>
 #include <div64.h>
 #include <dm.h>
@@ -548,14 +549,118 @@ static void k3_ddrss_set_ecc_range_r0(u32 base, u32 start_address, u32 size)
 	writel((start_address + size - 1) >> 16, base + DDRSS_ECC_R0_END_ADDR_REG);
 }
 
-static void k3_ddrss_preload_ecc_mem_region(u32 *addr, u32 size, u32 word)
+#define BIST_MODE_MEM_INIT		4
+#define BIST_MEM_INIT_TIMEOUT		10000 /* 1msec loops per block = 10s */
+static void k3_lpddr4_bist_init_mem_region(struct k3_ddrss_desc *ddrss,
+					   u64 addr, u64 size,
+					   u32 pattern)
 {
-	int i;
+	lpddr4_obj *driverdt = ddrss->driverdt;
+	lpddr4_privatedata *pd = &ddrss->pd;
+	u32 status, offset, regval;
+	bool int_status;
+	int i = 0;
+
+	/* Set BIST_START_ADDR_0 [31:0] */
+	regval = (u32)(addr & TH_FLD_MASK(LPDDR4__BIST_START_ADDRESS_0__FLD));
+	TH_OFFSET_FROM_REG(LPDDR4__BIST_START_ADDRESS_0__REG, CTL_SHIFT, offset);
+	driverdt->writereg(pd, LPDDR4_CTL_REGS, offset, regval);
+
+	/* Set BIST_START_ADDR_1 [32 or 34:32] */
+	regval = (u32)(addr >> TH_FLD_WIDTH(LPDDR4__BIST_START_ADDRESS_0__FLD));
+	regval &= TH_FLD_MASK(LPDDR4__BIST_START_ADDRESS_1__FLD);
+	TH_OFFSET_FROM_REG(LPDDR4__BIST_START_ADDRESS_1__REG, CTL_SHIFT, offset);
+	driverdt->writereg(pd, LPDDR4_CTL_REGS, offset, regval);
+
+	/* Set ADDR_SPACE = log2(size) */
+	regval = (u32)(ilog2(size) << TH_FLD_SHIFT(LPDDR4__ADDR_SPACE__FLD));
+	TH_OFFSET_FROM_REG(LPDDR4__ADDR_SPACE__REG, CTL_SHIFT, offset);
+	driverdt->writereg(pd, LPDDR4_CTL_REGS, offset, regval);
+
+	/* Enable the BIST data check. On 32bit lpddr4 (e.g J7) this shares a
+	 * register with ADDR_SPACE and BIST_GO.
+	 */
+	TH_OFFSET_FROM_REG(LPDDR4__BIST_DATA_CHECK__REG, CTL_SHIFT, offset);
+	driverdt->readreg(pd, LPDDR4_CTL_REGS, offset, &regval);
+	regval |= TH_FLD_MASK(LPDDR4__BIST_DATA_CHECK__FLD);
+	driverdt->writereg(pd, LPDDR4_CTL_REGS, offset, regval);
+	/* Clear the address check bit */
+	TH_OFFSET_FROM_REG(LPDDR4__BIST_ADDR_CHECK__REG, CTL_SHIFT, offset);
+	driverdt->readreg(pd, LPDDR4_CTL_REGS, offset, &regval);
+	regval &= ~TH_FLD_MASK(LPDDR4__BIST_ADDR_CHECK__FLD);
+	driverdt->writereg(pd, LPDDR4_CTL_REGS, offset, regval);
+
+	/* Set BIST_TEST_MODE[2:0] to memory initialize (4) */
+	regval = BIST_MODE_MEM_INIT;
+	TH_OFFSET_FROM_REG(LPDDR4__BIST_TEST_MODE__REG, CTL_SHIFT, offset);
+	driverdt->writereg(pd, LPDDR4_CTL_REGS, offset, regval);
+
+	/* Set BIST_DATA_PATTERN[31:0] */
+	TH_OFFSET_FROM_REG(LPDDR4__BIST_DATA_PATTERN_0__REG, CTL_SHIFT, offset);
+	driverdt->writereg(pd, LPDDR4_CTL_REGS, offset, pattern);
+
+	/* Set BIST_DATA_PATTERN[63:32] */
+	TH_OFFSET_FROM_REG(LPDDR4__BIST_DATA_PATTERN_1__REG, CTL_SHIFT, offset);
+	driverdt->writereg(pd, LPDDR4_CTL_REGS, offset, pattern);
+
+	udelay(1000);
+
+	/* Enable the programmed BIST operation - BIST_GO = 1 */
+	TH_OFFSET_FROM_REG(LPDDR4__BIST_GO__REG, CTL_SHIFT, offset);
+	driverdt->readreg(pd, LPDDR4_CTL_REGS, offset, &regval);
+	regval |= TH_FLD_MASK(LPDDR4__BIST_GO__FLD);
+	driverdt->writereg(pd, LPDDR4_CTL_REGS, offset, regval);
+
+	/* Wait for the BIST_DONE interrupt */
+	while (i < BIST_MEM_INIT_TIMEOUT) {
+		status = driverdt->checkctlinterrupt(pd, LPDDR4_INTR_BIST_DONE,
+						     &int_status);
+		if (!status & int_status) {
+			/* Clear LPDDR4_INTR_BIST_DONE */
+			driverdt->ackctlinterrupt(pd, LPDDR4_INTR_BIST_DONE);
+			break;
+		}
+		udelay(1000);
+		i++;
+	}
 
-	printf("ECC is enabled, priming DDR which will take several seconds.\n");
+	/* Before continuing we have to stop BIST - BIST_GO = 0 */
+	TH_OFFSET_FROM_REG(LPDDR4__BIST_GO__REG, CTL_SHIFT, offset);
+	driverdt->writereg(pd, LPDDR4_CTL_REGS, offset, 0);
+
+	/* Timeout hit while priming the memory. We can't continue,
+	 * since the memory is not fully initialized and we most
+	 * likely get an uncorrectable error exception while booting.
+	 */
+	if (i == BIST_MEM_INIT_TIMEOUT) {
+		printf("ERROR: Timeout while priming the memory.\n");
+		hang();
+	}
+}
 
-	for (i = 0; i < (size / 4); i++)
-		addr[i] = word;
+static void k3_ddrss_lpddr4_preload_full_mem(struct k3_ddrss_desc *ddrss,
+					     u64 total_size, u32 pattern)
+{
+	u32 done, max_size2;
+
+	/* Get the max size (log2) supported in this config (16/32 lpddr4)
+	 * from the start_addess width - 16bit: 8G, 32bit: 32G
+	 */
+	max_size2 = TH_FLD_WIDTH(LPDDR4__BIST_START_ADDRESS_0__FLD) +
+		    TH_FLD_WIDTH(LPDDR4__BIST_START_ADDRESS_1__FLD) + 1;
+
+	/* ECC is enabled in dt but we can't preload the memory if
+	 * the memory configuration is recognized and supported.
+	 */
+	if (!total_size || total_size > (1ull << max_size2) ||
+	    total_size & (total_size - 1)) {
+		printf("ECC: the memory configuration is not supported\n");
+		hang();
+	}
+	printf("ECC is enabled, priming DDR which will take several seconds.\n");
+	done = get_timer(0);
+	k3_lpddr4_bist_init_mem_region(ddrss, 0, total_size, pattern);
+	printf("ECC: priming DDR completed in %lu msec\n", get_timer(done));
 }
 
 static void k3_ddrss_lpddr4_ecc_calc_reserved_mem(struct k3_ddrss_desc *ddrss)
@@ -583,9 +688,10 @@ static void k3_ddrss_lpddr4_ecc_init(struct k3_ddrss_desc *ddrss)
 	writel(DDRSS_ECC_CTRL_REG_ECC_EN | DDRSS_ECC_CTRL_REG_RMW_EN |
 	       DDRSS_ECC_CTRL_REG_WR_ALLOC, base + DDRSS_ECC_CTRL_REG);
 
-	/* Preload ECC Mem region with 0's */
-	k3_ddrss_preload_ecc_mem_region((u32 *)ecc_region_start, ecc_range,
-					0x00000000);
+	/* Preload the full memory with 0's using the BIST engine of
+	 * the LPDDR4 controller.
+	 */
+	k3_ddrss_lpddr4_preload_full_mem(ddrss, gd->ram_size, 0);
 
 	/* Clear Error Count Register */
 	writel(0x1, base + DDRSS_ECC_1B_ERR_CNT_REG);
-- 
2.34.1

