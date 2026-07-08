Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B34C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 12:42:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52DCB84A8D;
	Wed,  8 Jul 2026 14:40:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="uU4HDK65";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE5728497A; Wed,  8 Jul 2026 03:13:45 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A64784118
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 03:13:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZBkj5b7TwCaK/TDAokU2YV34Pt48LqzqCCSv3KQuU2+UnWChQSS4X5g0Xaw0xHeYp7MOyFhM5Fo16KjIfizAk/E6fSTaRSIEtGdVdx792cBtzFhw7EMtFzDln5x5gvwHfe252TFKpF5aRZ0UL9RN6ptFu07RT9YAyeY397mizMDntuiobcwAo0k+N+kz1DHmYeOJctFxzAhNkkp0RPDyeQ5OXlWZ7p9OYhDhnalcGY5wuGLuWLUrZzqBjokOEn/Yuf2lSRDR/Fwrhaurmr6/cY1r3JEmo1HEDHibA+0HNj8QbVcY8sz/NQh42y0TMXsN55/VPv4Yh6RUqhUFzOJmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuyVwGgeRKw0YdcPgjD1TP0+cvRTWBSyQ6A+AKYWcNc=;
 b=WAKRkDsJ/KQKiYpu7AybJrAwlTWG2uxG9w8n+bS0Yc2kEZsbipc36UcOnApG2ymzQUP9RPAHmrsyhv7JdERU7rEjQg5IGsUp1cCD3SBgaB3Q4sByvcI6vQSd9lLt+uNz26pAc8tGH6h1AiByYXYRTucbJUktnuHRaBXnC9+FoCY8tdz0qnBRSJrZNBi0S/KEurpmfVqWqR/Y7s0ebvDj+Cu24+v1GBkkHyJ5MUtQXjzyIQJ00a1WQ4HHSgep/fYTKveUWzpLhYL4SowLtsVFCTV6szMtAt1FPmaJ7A/O8sYcrZHzcvuMdveoQAoIH4OGnCHCOuFGSMT1+JPnC07Jag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuyVwGgeRKw0YdcPgjD1TP0+cvRTWBSyQ6A+AKYWcNc=;
 b=uU4HDK65cwitB3j9Yv9INUrgBrwmazqEE2u3LuLn01nIqWWfWvnB7LtdaiNyATsG4TOdOMjk2K0wtu5Tj7FG0SrFShJ1A6jNvZuc7NkKMCYAhhthj3lK+bIv5+mzz6XJ9FDLFzyPz262RcnOEKoFpHWm0kOG1vXtMqNXhsainLHfCCwQhQ8kdnJg2XeAqFBZ7fZ2hFPfAu1di3CeYC2gq5a3ahNH1k5NjMpeHiOhEayVNmuD8lleb6ZXzApgxb6ps8yTQib2YSuZ+k+kWuU7l5EgMW+AwrodM/YtkrDXBD/SzVoisqn+fN24FxXvEbJATv9F15iTvqzcIdUZwgcYkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by MW4PR03MB6473.namprd03.prod.outlook.com (2603:10b6:303:120::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 01:13:40 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%6]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 01:13:39 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH 12/15] ddr: altera: n5x: rename is_ddr_init_skipped() and
 quieten reset log
Date: Wed,  8 Jul 2026 09:12:25 +0800
Message-ID: <20260708011228.15613-13-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260708011228.15613-1-chen.huei.lok@altera.com>
References: <20260708011228.15613-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:a03:331::7) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|MW4PR03MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b127384-dca0-4c61-15de-08dedc8e24e9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|18002099003|11063799006|55112099003|56012099006|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: jlgt1SHB0E5Xmkln2KmX9g51QKBglMIWmR1+UrEZeiRh8nFuJcmqg2E/LFekZi93tVcub/pLYZadkCToU7C6RawzyWkj8Dbcb0KZ1we8AFsIJp+Y5UyHLHs4/xcPCvpcJuo4bGc4UjxoyzLBw4aEFbsi5gxvRySGx+/rKDF9c0/ACjwpUQ+/rj3Z2xoE/NToo/NnnVcnF6l5NO4v4qkc87MlJ7V2LdTlYcGUrpq5KskXItr493WN6kFBGTyiTESIM8ol+2rEkL5Sm+EbgsX9INNBQetJpmzEB/gw90CdYAb1FcHnoGRVGQkLNw27b/3S9xue6kyOliyCbJR89N//4hsKj4zGM4dsUE4xPPBx5o1Rz8+PIDw9tT1jztY/+FgHMRD4oSzzIpBi99Cvbx+60uOlZdzhDCXV9x3rquVbHT5UYUxx/t5Nf3gObe/EOpTlHsbn4dxjF2ymMC6qI/pX2X5DCJzVgQAIrfD+AGamd/kRw6+KeLklgTqaKUPuoOhCsmDRAc5zQw7iZNrtvFRy32d07Evd76wSzNF0oDwiI00GHjScV0wkpAcKPB/acAXUpDAj+BqizQt8GzzkT/V7aPy+5Lg5c1TjTv7VfzSCKp1qj6HW4z0ePxdxlNoDXbfLyf4eivQofmIEw6B2GDRDvUmMUwuKLO+r15WSgf/H9vY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(11063799006)(55112099003)(56012099006)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?igNF7K6InEaD2lc7d9qdl6MA52u1CxpOJl4AJwAQVPEqqMz3mP83cakpqEU2?=
 =?us-ascii?Q?5dQu9/oFTR3xVrsJdmGv1wa0aP/KmXpRrS5pkvmNe3VujxEqcxsLh1xz2ut5?=
 =?us-ascii?Q?0ifRzLBMBiBqBhgUVb5Zc8NcsuLrEEp3s5i0ya5MIpWq7CB6iD5uTBtHkgf4?=
 =?us-ascii?Q?xw3JPSiWNcxur96eUfmHIJ47WAM6zSR1Y+j60FgS7zz+FTHb9qyozYlODCeV?=
 =?us-ascii?Q?rg+FbZN7QpPTgCVJUDz/YmHx9B9nBOAfNt5DVg8MdcmtzDpDq+4e4f9F7dSe?=
 =?us-ascii?Q?QChh27OFsELMAGKGQfchukNU0LyozLKOMAViVDNxCBZSlWJkQiUELAULB0Sz?=
 =?us-ascii?Q?CEKnyixqGWxK2XqsvYL3ks97nOUqXIRqPRHBJ/5Is55yew8umuaQ20mAsYjL?=
 =?us-ascii?Q?I+xLVvIH6rZnNyW0AIon0r3HGUGspVv9zOld/FKSc37po6Ui1uY4u7nVBaPE?=
 =?us-ascii?Q?otdg3WSFIvOEow2EAA6+vpBHobHvSzqEia3rcOoouG20vdn2zoM1aHapuDf2?=
 =?us-ascii?Q?Ll10Luhf2p7ahskEaKop5BXmuMPO69UuAeDvTpzE89I3IhErYQF3uxbHTrdm?=
 =?us-ascii?Q?ITQ0IbVN7ZGFy24PtaB1IwmuGN3mIMbWBYge+N0vGIGjuoQ6a1fXIU+rgaAS?=
 =?us-ascii?Q?p7XW3kuuU5Bunzr5mQ7KbZ3FOLh9co5z/yJ0bardss9MBQF5Ev39uamQRbUC?=
 =?us-ascii?Q?9tS5lbyH1mT6CreByULS84bUiQkG1LVLkiIRescp8yRAfkDsLjZkmAyeBQB9?=
 =?us-ascii?Q?8vF4xrUhDpM+N/KV/DU9C0OfY0txIqFZCP1tJW11T/TG3k24qJM84aSKywv4?=
 =?us-ascii?Q?tUFxyZwCksVsovQt29l1uLzeH+SqIoaX0ITDjvULXv27Z5OOjfrGeAXWiN+Y?=
 =?us-ascii?Q?oIzm3aWmC0u3wMLGhNVG2AGABr5COe+T1OJzOTzxMHlie98BZnv8BLFQkcMe?=
 =?us-ascii?Q?wOMUB4QS3s2q0l5dU3OYx6DgLxShYOCQclEBlM7ZH+uZlseFNVs4r/vNgMJ+?=
 =?us-ascii?Q?5m1w9tzBpZz6kclBaKocEe5/vWsf1y8AlnXZxjFtuecoUDMpgq2R8gRrkebA?=
 =?us-ascii?Q?J5sNU1oZo25Se4FsCidr+b8FAxPGZKS+Sa9GhxEJTaEs7LD7XRXrnmMZ0q/9?=
 =?us-ascii?Q?+O+6ZUwO2DpVk44aLBI7Xs6BgrvXHMacEzlLLEZCp1+MtM8iQui3X/pMAVI3?=
 =?us-ascii?Q?LO8lA91xVTSjnYsiDD9H9NQo4ZVUgUHQmrz4XW9pJqbhvq2+TtW1pmVE+PhI?=
 =?us-ascii?Q?6KSAVAKDX6YXSBWjFwdx1AAzLpMXuY1Qo7pQVIH5rGZ/imehatiZdbQ1+pYk?=
 =?us-ascii?Q?r6SfG5IOpqpvupCYaUaZ8secbztuYy8X6O/Cgd2RDS5NYem1Cn3hYksn3BKE?=
 =?us-ascii?Q?n/cDoJIiuSxv5S3rCNA1WkNmumoulEZR6rpGFbLUUQXc8BovQHrNwxY/1Pnu?=
 =?us-ascii?Q?/pdzCyFKpqeN9bcfqPXoZkew6fYibkOfAEIGHf0naEKz7n9VmNK1xq+2gxTs?=
 =?us-ascii?Q?U5wrE0wJooKQPqyOdUOeej1t9/VvV4A0lNiVEJe8D60DrNk5D2W2CG8pOfgv?=
 =?us-ascii?Q?Ij5UKOJxHDp/OZbZywkPH2DD/oxm6PA8qDQaltXA/ltNqGtsVUL3PbetZef5?=
 =?us-ascii?Q?LsMj+EVSB1fX5hv9VV4KzyjW1SVBbNNUMOeKWbiYBsDlvmlaxbKUWo4PZ+Wo?=
 =?us-ascii?Q?WX53rSmrGRqj0ioDWOejIOnAeUXoXI6DoVvyztSRNjvOkgj0A2AoslemOBlB?=
 =?us-ascii?Q?wldjI2Z3FJmhPR0JQu43ycFYygVJLQ4=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b127384-dca0-4c61-15de-08dedc8e24e9
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 01:13:39.9233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SiNRQvpnPLYJLT+sc6dS285pD+1AQ0sctWj6z6Coc+QtZ00sn8AfQ5CkMFR3av8/fxSsi0IGR+8t343In47hxR9p8qIdEExIXasse9sOl4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6473
X-Mailman-Approved-At: Wed, 08 Jul 2026 14:40:34 +0200
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

Rename is_ddr_init_skipped() to is_ddr_init() and invert its return value
so the helper reads naturally at the call site (true means DDR must be
initialised). The decision is otherwise unchanged: init is required on
POR, skipped on a warm reset, and skipped on a cold reset only when the
retention bit is set.

Switch the reset-type reporting from printf() to debug() so the reset
cause is not printed on every boot, and add the NCONFIG, JTAG_CONFIG and
RSU_RECONFIG cases. Define reset_type_debug_print() above its first caller
so the new call site does not trigger an implicit-declaration warning.

Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 drivers/ddr/altera/sdram_n5x.c | 56 +++++++++++++---------------------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/drivers/ddr/altera/sdram_n5x.c b/drivers/ddr/altera/sdram_n5x.c
index 6fed9b79257..d7f00b6d2f5 100644
--- a/drivers/ddr/altera/sdram_n5x.c
+++ b/drivers/ddr/altera/sdram_n5x.c
@@ -469,17 +469,17 @@ static enum reset_type get_reset_type(u32 reg)
 		ALT_SYSMGR_SCRATCH_REG_0_DDR_RESET_TYPE_SHIFT;
 }
 
-void reset_type_print(enum reset_type reset_t)
+void reset_type_debug_print(u32 boot_scratch_cold0_reg)
 {
-	switch (reset_t) {
+	switch (get_reset_type(boot_scratch_cold0_reg)) {
 	case POR_RESET:
-		printf("%s: POR is triggered\n", __func__);
+		debug("%s: POR is triggered\n", __func__);
 		break;
 	case WARM_RESET:
-		printf("%s: Warm reset is triggered\n", __func__);
+		debug("%s: Warm reset is triggered\n", __func__);
 		break;
 	case COLD_RESET:
-		printf("%s: Cold reset is triggered\n", __func__);
+		debug("%s: Cold reset is triggered\n", __func__);
 		break;
 	case NCONFIG:
 		printf("%s: NCONFIG is triggered\n", __func__);
@@ -491,34 +491,39 @@ void reset_type_print(enum reset_type reset_t)
 		printf("%s: RSU_RECONFIG is triggered\n", __func__);
 		break;
 	default:
-		printf("%s: Invalid reset type\n", __func__);
+		debug("%s: Invalid reset type\n", __func__);
 	}
 }
 
-bool is_ddr_init_skipped(u32 reg, bool is_ddr_hang_be4_rst)
+bool is_ddr_init(bool is_ddr_hang_be4_rst)
 {
-	enum reset_type reset_t = get_reset_type(reg);
+	u32 reg = readl(socfpga_get_sysmgr_addr() +
+			SYSMGR_SOC64_BOOT_SCRATCH_COLD0);
 
-	reset_type_print(reset_t);
+	reset_type_debug_print(reg);
 
 	if (!is_ddr_dbe_triggered() && !is_ddr_hang_be4_rst) {
-		if (reset_t == WARM_RESET) {
-			debug("%s: DDR init is skipped\n", __func__);
+		if (get_reset_type(reg) == POR_RESET) {
+			debug("%s: DDR init is required\n", __func__);
 			return true;
 		}
 
-		if (reset_t == COLD_RESET) {
+		if (get_reset_type(reg) == WARM_RESET) {
+			debug("%s: DDR init is skipped\n", __func__);
+			return false;
+		}
+
+		if (get_reset_type(reg) == COLD_RESET) {
 			if (is_ddr_retention_enabled(reg)) {
-				debug("%s: DDR retention bit is set\n",
-				      __func__);
+				debug("%s: DDR retention bit is set\n", __func__);
 				debug("%s: DDR init is skipped\n", __func__);
-				return true;
+				return false;
 			}
 		}
 	}
 
 	debug("%s: DDR init is required\n", __func__);
-	return false;
+	return true;
 }
 
 bool is_ddr_calibration_skipped(u32 reg, bool is_ddr_hang_be4_rst)
@@ -2806,23 +2811,6 @@ static int ddr_post_config(struct ddr_handoff *handoff, bool *need_calibrate)
 	return ret;
 }
 
-void reset_type_debug_print(u32 boot_scratch_cold0_reg)
-{
-	switch (get_reset_type(boot_scratch_cold0_reg)) {
-	case POR_RESET:
-		debug("%s: POR is triggered\n", __func__);
-		break;
-	case WARM_RESET:
-		debug("%s: Warm reset is triggered\n", __func__);
-		break;
-	case COLD_RESET:
-		debug("%s: Cold reset is triggered\n", __func__);
-		break;
-	default:
-		debug("%s: Invalid reset type\n", __func__);
-	}
-}
-
 int sdram_mmr_init_full(struct udevice *dev)
 {
 	u32 user_backup[2], user_backup_2nd[2];
@@ -2855,7 +2843,7 @@ int sdram_mmr_init_full(struct udevice *dev)
 	 */
 	writel(SOC64_CRAM_PHY_BACKUP_SKIP_MAGIC, SOC64_OCRAM_PHY_BACKUP_BASE);
 
-	if (!is_ddr_init_skipped(reg, is_ddr_hang_be4_rst)) {
+	if (is_ddr_init(is_ddr_hang_be4_rst)) {
 		printf("SDRAM init in progress ...\n");
 		ddr_init_inprogress(true);
 
-- 
2.43.7

