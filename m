Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CDE9C7115B
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 06:28:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8C5482CF8;
	Fri, 20 Jun 2025 08:28:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="cJgUeaIw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A806082D17; Fri, 20 Jun 2025 08:28:51 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CE1E82CBC
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 08:28:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VfmUUet2Tb8VP68jAaafSPXmGb2NFSMwuK1CVU5XzDZrq2JDTgoUZ1HZrHnsJmreuD6AxrhWVXCkL+yN9aoy3c6zJ2AFqbF7p8uxQmheacz2/wWS5TAJz1s7vw0enqUxq4viEjJoX3e+N3xYAbTopmCUr8MAF3o49DiQ11gm5bm7gr9x7/NkXJZz0MDAUsSYS6ZY3P6FtldPL58INEEMftYLlcRzYARTRl3UkuU/77IusFCQU8kGpF3vWK6s317e8m2br3HaRqQ29VT3Wnk9G8WD2IT8NigGIpNBiKiBiU8kMaoTkMoGCQB65QF6NGuzBCx5/uqpXSjzH78Sckn6ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFoFhFefdmSVwJFyjBK0M5U0sEjhZhQmFFx3L2WuBOk=;
 b=INYnguF8pQ60J4hvh9D7GV1NR6nkyayT/5qhMUYWvpvFzXIGnEtnv0T+ae5/Iwjme8ogwmwMNdJZ9ND4XYhS42ka0sUPO6ILPnx1DG0Jykpg+c3/BHP1NxYrcWOsAglNhWHrsg347pUjkApKTaJPI61UZcfSfY38hjDppG3YphP269vpT485itMKkKk+XXyjZ1Uj4yURxLc/yg//9RS4O5RARFkh0IfH+5cq8eXIcaaGubxksnx2PL4CFvB3C3eNneZHYoBkMm5CNH5NN4YscZthRB+KZoRBMEVdSzItB0qlPC8V5R8JQDCWVzYabAgmISTMG3a8lJKemZqq6W1iVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFoFhFefdmSVwJFyjBK0M5U0sEjhZhQmFFx3L2WuBOk=;
 b=cJgUeaIw+BK3C9G4KPKO3xXjLfk46JjuGHjQ476/R1XN4+06Wg1MJFPHnPSwVbRwiCMM4t68RskcLdOubdhw6RiYv2Jc0831MDAZ6OnHB9Du1d0G2FwCfEIC0B7DBWrQA0Dr8Iw36T7I/B7UOKV46zjZacS5MhE8lrQbltiUJ4PjnepfRoJVPxepXPtZOz7q8900DSddvLfiBabDvBeDjpOqnK9gHVR6rhi/naDR8cf3yVg/MK5pnU8xQSA1MTikNWnsl/reNUi/YCGC7YcY5jz4aUmPrZBQbNZNtQBCc11x2vhLzBKVvQ2z6/CICbkQ5/EJYSQyDhSE0PNEA5M1qQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA3PR03MB7417.namprd03.prod.outlook.com (2603:10b6:806:39e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Fri, 20 Jun
 2025 06:28:46 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8857.016; Fri, 20 Jun 2025
 06:28:46 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1] mmc: socfpga_dw_mmc: Retrieve clock manager address via DT
Date: Thu, 19 Jun 2025 23:28:40 -0700
Message-Id: <20250620062840.6553-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0248.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::13) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SA3PR03MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: b3dfdb99-0ece-49d2-10f8-08ddafc3b5f0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QZXS7MANPP1RNZ+PxV3pyjYl5Z8hbSznjPQAfYRNeXYbgs6XfX2HI0Mqci46?=
 =?us-ascii?Q?s8DTQI8gHTJi0eoGcweHDPCk54z0c7Xf+iog5ctdPhwRsUWyPzgNo2LhTjXz?=
 =?us-ascii?Q?BYP5a2vatq02uKR8do2ef0BWmE6ZVqBoLpCY9tznNFbw9v853TFVS0NhjEYW?=
 =?us-ascii?Q?wnu7hJ5vWF20Y+wUTivmtKEIQRZfiyqUKPogCZE7NH30CU+uh9mOvyfgv9Ap?=
 =?us-ascii?Q?zSusTRLb2uphSbz84nrkuDYULBV35/QcwalkIR2wXRAM4SpygK5H7vZLFikK?=
 =?us-ascii?Q?5OxT7Vnnl7HBHvPMEZnmFLWR8yRLYtESz6xpKhCfaVMIkn0A5AMAkpHGxML4?=
 =?us-ascii?Q?Xk7Bs7G3eARoJPcbv3PIrktRWDtgkNCxolozC9SWNR4FDfnd7xV6t+cQxBGo?=
 =?us-ascii?Q?Wi+QbZ9BaXAI3Mur0qcqR2iXT8CNVXiN56+S0Qb/BNgLrHwp6/60ECFHp9x0?=
 =?us-ascii?Q?0ED/Sh+YHgeckDJ/CwJdEChSXoWFNuJKD2E3Nb2I05L4WRNyDqfYIWYIOaD2?=
 =?us-ascii?Q?XDELzS0A9UKM5I/Jzq5SaerTkBdDJZfpeKslIHkvk+8O7KJKnBSudGQXcS8m?=
 =?us-ascii?Q?gOl6+OJQesefxdpHkh7TUSjOsfz9ZaNdCEr4MSESc0PcGGbqRjUg2wEICTDK?=
 =?us-ascii?Q?gbHv/ImSbxPTKMzp/8akBpCPyHnn6EmQDoR9fhTKJbpNo78VYikg6+orc/Xe?=
 =?us-ascii?Q?3ZU2y8icH4hWM5gjz8MG80sdn0B1/g0ripDib9iisC/r6FU5BDVwF5AaQpoB?=
 =?us-ascii?Q?YayVCNuc+MgqKaG42Qv2jH4VtR3utc88r0oXu8Y10JHf0Z/JFie0GCsNOSFW?=
 =?us-ascii?Q?OzEyLYepXLB8IjD8qSc0ARclCZSAkz8z4uMJ6OicQeufYbQT/5Ab3cyKZFwU?=
 =?us-ascii?Q?kFlcaaU50twzaHWckBPVllKcdSsXrMSEFMMlmJEv6LDjLxU4sKcPmE37mkfd?=
 =?us-ascii?Q?G40CwssNJj05qE/3nhwHeXhtJiJFX5l8W+Gv/SlDmJAdmbMgetREW+sCj6tk?=
 =?us-ascii?Q?/syQTnjNfmKsdh6+ZYjpKhreF+423+FNFsWXF8Y6jGR45nXdCu822CfU6hw2?=
 =?us-ascii?Q?DVqyoyi8blobbVd6KmwcVlaI4whS6qq54auiovgt0agK8WL5i/dMjYAjLDWN?=
 =?us-ascii?Q?+1KYag3kYJVu2MTn6sQH/7oMpT79hq5xE0Lje8Zf0ZR863UhjjPbMLsTQg0q?=
 =?us-ascii?Q?Hl/zPlaGJs39S2HIWugVQZ6X0FwKhONlClDrSJxruGznn7GB0mfSedUvM4Yh?=
 =?us-ascii?Q?L28cKCWIVppyN1YwPtbQwbC2a4TD0hC7y64yU4LFdsf003nNysjSXIt/KZa1?=
 =?us-ascii?Q?ZJsZUGeYkLrYMlvjvKxp7lc2UwjaiSUCgNzCBv08ha/4pyOAw+/p2/lHjjIh?=
 =?us-ascii?Q?ZqWQ7EpbQQb8VJ1O4ExW6qgCqmD0oMsobBKKQV+HgjQnHSzfUq9EfTGJPicS?=
 =?us-ascii?Q?mlf72r9TTDM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IjyyoY4TtFtWeWoo/hBbbEIfMhHvkzKXL+gyXamps8Q1fAt+nNHY1Sy22ANG?=
 =?us-ascii?Q?f13TQvsqMFSoNcwvqe6MiFB/kNuLsNeHdWq02k+2wQ0QZi7alBHUk9LKz3UH?=
 =?us-ascii?Q?A+37Xxlt799me4InO05uh5k/ChFz7UM2GJEPBp3oCf3GpORMF0pX51OG1b18?=
 =?us-ascii?Q?m6Bz53Umrrbr1kgYGVevAdKor9xLtz9yfBRYURQ8Kry7izkb1gdKPpQRzzqf?=
 =?us-ascii?Q?BCnoxkobWExVk4bkVemb2vshg10j+Y8SxWbc0LiSks0iQo2ZT4WAKwP9/6tm?=
 =?us-ascii?Q?AQieZMBaR+p9r5SBnGdP2iMmJb4mePR0SFAUg3cMnKpy7+Vh3ncyPOM3EOx4?=
 =?us-ascii?Q?ii6OwToTMykLc105gYkjBttnDdkzYNItCKdr2kUxLdz3AbkfpGGWfTzceolA?=
 =?us-ascii?Q?32amTIGZMv4ZicqNWKAPTyYqh/aymqVE8buJTcw9eLFqbDePCMD89GEk2u0l?=
 =?us-ascii?Q?3nvFnIvdfSYvPUg1CHoddy6HWemL5//QdAIuiSUpH487qPjSZexN1kYi3BWc?=
 =?us-ascii?Q?2Pi8qLOfDTWgxJqKrK9gNpl1oeU82d3OirRHz1jQPc0bRQbTQF+myTKopgBZ?=
 =?us-ascii?Q?3tJlDt7QR98gqzvQXxvlWAmBz75N/TwWbXwg2hm1vDoZF0tqPPDij6kaB4ii?=
 =?us-ascii?Q?VNAMaYkMf8g7Q8G94/CFcXowAHvmdQHI4+MFXPJoqUbuFEP+zMpg2k+de8DU?=
 =?us-ascii?Q?o1VfCN4E+gkqggkQXL5APzr/uOwBQjGhDeGdy7MvLIAIWimopUTggZbqzVLU?=
 =?us-ascii?Q?7/t7I8tiHsIC/3d/jDZRAk0dzfy5XmG2iVnWhme0sALCmdvQk/MBZmEV3dtc?=
 =?us-ascii?Q?8Khn+JYjKvTHbZeR2o3W3RpGftjKuhtty9oAyu2HMFv35gj+B8RG2G+DcJX4?=
 =?us-ascii?Q?UbB7YPU9tPV4dLP0SjvxWs/sb/thOd/vhuO4i5ek506OMpA0PVPdsquWyVhm?=
 =?us-ascii?Q?6a2ZCbLQiIKQ6VCTOotm2EDqZqgYX9urI/kcfcdD3Er4itvRYMbQ7j76vA3S?=
 =?us-ascii?Q?jUgudf95UpYu/yZTbY1txlbGnW3WM51JaHCZfaGS5y4kOsgIB1vDu3+775SA?=
 =?us-ascii?Q?hByRhbDvBCgJoBIGFgu4m5rVaercEnlIgcHQW+CNE4z4/trbLUTCLz11RuFN?=
 =?us-ascii?Q?TU5THezoH4C5cF3SNtEsx03Vp/atEJU/pVfqXVynZ+3Yu4uzmskfWpppu7cR?=
 =?us-ascii?Q?zEFikbLWrGVjyRMJIWg48Cc01m4+Klu4c6tPtPd6oYsA2Y+gFLKcaKvvc5ek?=
 =?us-ascii?Q?G68gdDwIynV7ePqRmsh4dz4iO2MW23bPcnLthN8/CYi/pAPI7cUw9QABJNml?=
 =?us-ascii?Q?hh+9wPpRb5DI/nS9CE/jg2WaIAWs0uI1t1Ea3pic+hDkuCoQW4oZkG/L3lbU?=
 =?us-ascii?Q?I7mIwkc9u27JSG1BZlLZY5HXgZaCJTc4w+YINbqRhYfbzI42558z0AzzKUem?=
 =?us-ascii?Q?7oPf5FL94+r4/TLg+003CKVFtnf/vkIEL922idNLLcJ75BPJEo5NsJGXY5L0?=
 =?us-ascii?Q?SmD4lJeum22OGXl2WQMT2q+DOVfZRvmqMwHq9jRDAuAlQH22VJWieWHoGkTa?=
 =?us-ascii?Q?+JQab9pAusuARusIeF3wpRfqMgfg19biuEWphcquCkfBWODJFaL+zJXuG95J?=
 =?us-ascii?Q?OA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3dfdb99-0ece-49d2-10f8-08ddafc3b5f0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 06:28:46.4437 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F/8AyqaOlEGG/qq/lAUkgi859agxIcN/do1mxfWhrXXRmUoMZrZkzgN1acqEznlIEhSKSLv/nJWn454TXx0W91wlYxknumdnELHXVY0p2do=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7417
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Update the MMC driver to retrieve the clock manager base address via
probing the clock manager node in the device tree.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 drivers/mmc/socfpga_dw_mmc.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/socfpga_dw_mmc.c b/drivers/mmc/socfpga_dw_mmc.c
index 9dc1ceaa09b..3b86bc9b18c 100644
--- a/drivers/mmc/socfpga_dw_mmc.c
+++ b/drivers/mmc/socfpga_dw_mmc.c
@@ -54,16 +54,30 @@ static int socfpga_dwmci_clksel(struct dwmci_host *host)
 	u32 sdmmc_mask = ((priv->smplsel & 0x7) << SYSMGR_SDMMC_SMPLSEL_SHIFT) |
 			 ((priv->drvsel & 0x7) << SYSMGR_SDMMC_DRVSEL_SHIFT);
 
+	/* Get clock manager base address */
+	struct udevice *clkmgr_dev;
+	int ret = uclass_get_device_by_name(UCLASS_CLK, "clock-controller@ffd10000", &clkmgr_dev);
+
+	if (ret) {
+		printf("Failed to get clkmgr device: %d\n", ret);
+		return ret;
+	}
+
+	fdt_addr_t clkmgr_base = dev_read_addr(clkmgr_dev);
+
+	if (clkmgr_base == FDT_ADDR_T_NONE) {
+		printf("Failed to read base address from clkmgr DT node\n");
+		return -EINVAL;
+	}
+
 	/* Disable SDMMC clock. */
-	clrbits_le32(socfpga_get_clkmgr_addr() + CLKMGR_PERPLL_EN,
+	clrbits_le32(clkmgr_base + CLKMGR_PERPLL_EN,
 		     CLKMGR_PERPLLGRP_EN_SDMMCCLK_MASK);
 
 	debug("%s: drvsel %d smplsel %d\n", __func__,
 	      priv->drvsel, priv->smplsel);
 
 #if !defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_ATF)
-	int ret;
-
 	ret = socfpga_secure_reg_write32(SOCFPGA_SECURE_REG_SYSMGR_SOC64_SDMMC,
 					 sdmmc_mask);
 	if (ret) {
@@ -78,7 +92,7 @@ static int socfpga_dwmci_clksel(struct dwmci_host *host)
 #endif
 
 	/* Enable SDMMC clock */
-	setbits_le32(socfpga_get_clkmgr_addr() + CLKMGR_PERPLL_EN,
+	setbits_le32(clkmgr_base + CLKMGR_PERPLL_EN,
 		     CLKMGR_PERPLLGRP_EN_SDMMCCLK_MASK);
 
 	return 0;
-- 
2.25.1

