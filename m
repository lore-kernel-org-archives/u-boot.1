Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD50C54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 17:20:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6CDE8338D;
	Fri, 23 May 2025 19:20:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 487608338D; Fri, 23 May 2025 19:20:32 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEF188337A
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 19:20:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1uIW4J-0076pt-Dr;
 Fri, 23 May 2025 17:20:27 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de,
	Stefano Babic <sbabic@nabladev.com>
Cc: Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 04/13] board: venice: fix dram bus config for
 GW7902/GW7903/GW7904
Date: Fri, 23 May 2025 10:20:09 -0700
Message-Id: <20250523172018.4164647-4-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523172018.4164647-1-tharvey@gateworks.com>
References: <20250523172018.4164647-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The GW7902/GW7903/GW7904 have an alternate databus layout affecting a few
of the DDRC and DDR PHY registers.

The 512MB configuration used this alternate bus layout. Change
the 512MB config to the standard bus configuration and add a generic
function to patch the DDRC/PHY configs for the alternate bus layout.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 board/gateworks/venice/lpddr4_timing_imx8mm.c | 46 +++++++++++++++++--
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/board/gateworks/venice/lpddr4_timing_imx8mm.c b/board/gateworks/venice/lpddr4_timing_imx8mm.c
index 39e4e46490fd..956071c5125d 100644
--- a/board/gateworks/venice/lpddr4_timing_imx8mm.c
+++ b/board/gateworks/venice/lpddr4_timing_imx8mm.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/kernel.h>
+#include <string.h>
 #include <asm/arch/ddr.h>
 #include <asm/arch/lpddr4_define.h>
 
@@ -1333,7 +1334,7 @@ static struct dram_cfg_param ddr_ddrc_cfg_512mb[] = {
 	{ 0x3d400304, 0x1 },
 	{ 0x3d400030, 0x1 },
 	{ 0x3d400000, 0xa1080020 },
-	{ 0x3d400020, 0x203 },
+	{ 0x3d400020, 0x223 },
 	{ 0x3d400024, 0x3a980 },
 	{ 0x3d400064, 0x5b0062 },
 	{ 0x3d4000d0, 0xc00305ba },
@@ -1385,7 +1386,7 @@ static struct dram_cfg_param ddr_ddrc_cfg_512mb[] = {
 	{ 0x3d400498, 0x620096 },
 	{ 0x3d40049c, 0x1100e07 },
 	{ 0x3d4004a0, 0xc8012c },
-	{ 0x3d402020, 0x1 },
+	{ 0x3d402020, 0x21 },
 	{ 0x3d402024, 0x7d00 },
 	{ 0x3d402050, 0x20d040 },
 	{ 0x3d402064, 0xc000d },
@@ -1410,7 +1411,7 @@ static struct dram_cfg_param ddr_ddrc_cfg_512mb[] = {
 	{ 0x3d402194, 0x80303 },
 	{ 0x3d4021b4, 0x100 },
 	{ 0x3d4020f4, 0xc99 },
-	{ 0x3d403020, 0x1 },
+	{ 0x3d403020, 0x21 },
 	{ 0x3d403024, 0x1f40 },
 	{ 0x3d403050, 0x20d040 },
 	{ 0x3d403064, 0x30004 },
@@ -1459,9 +1460,9 @@ static struct dram_cfg_param ddr_ddrphy_cfg_512mb[] = {
 	{ 0x120a0, 0x0 },
 	{ 0x120a1, 0x1 },
 	{ 0x120a2, 0x3 },
-	{ 0x120a3, 0x4 },
+	{ 0x120a3, 0x2 },
 	{ 0x120a4, 0x5 },
-	{ 0x120a5, 0x2 },
+	{ 0x120a5, 0x4 },
 	{ 0x120a6, 0x7 },
 	{ 0x120a7, 0x6 },
 	{ 0x130a0, 0x0 },
@@ -3535,6 +3536,28 @@ static struct dram_timing_info dram_timing_2gb = {
 	.fsp_table = { 3000, 400, 100, },
 };
 
+static void apply_cfg_patch(struct dram_cfg_param *cfg, int cfg_sz,
+			    struct dram_cfg_param *patch, int patch_sz)
+{
+	int i, j;
+
+	for (i = 0; i < cfg_sz; i++)
+		for (j = 0; j < patch_sz; j++)
+			if (cfg[i].reg == patch[j].reg)
+				cfg[i].val = patch[j].val;
+}
+
+static struct dram_cfg_param ddr_ddrc_cfg_alt_patch[] = {
+	{ 0x3d400020, 0x203},
+	{ 0x3d402020, 0x1},
+	{ 0x3d403020, 0x1}
+};
+
+static struct dram_cfg_param ddr_ddrphy_cfg_alt_patch[] = {
+	{ 0x120a3, 0x4 },
+	{ 0x120a5, 0x2 },
+};
+
 struct dram_timing_info *spl_dram_init(const char *model, int sizemb)
 {
 	struct dram_timing_info *dram_timing;
@@ -3557,5 +3580,18 @@ struct dram_timing_info *spl_dram_init(const char *model, int sizemb)
 		dram_timing = &dram_timing_1gb;
 	}
 
+	/* apply ddrc/phy register changes for alternate dram bus layout */
+	if (!strncmp(model, "GW7902", 6) ||
+	    !strncmp(model, "GW7903", 6) ||
+	    !strncmp(model, "GW7904", 6)) {
+		apply_cfg_patch(dram_timing->ddrc_cfg, dram_timing->ddrc_cfg_num,
+				ddr_ddrc_cfg_alt_patch,
+				ARRAY_SIZE(ddr_ddrc_cfg_alt_patch));
+
+		apply_cfg_patch(dram_timing->ddrphy_cfg, dram_timing->ddrphy_cfg_num,
+				ddr_ddrphy_cfg_alt_patch,
+				ARRAY_SIZE(ddr_ddrphy_cfg_alt_patch));
+	}
+
 	return dram_timing;
 }
-- 
2.25.1

