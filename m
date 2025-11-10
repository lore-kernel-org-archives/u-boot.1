Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B708CCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 17:38:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC98083A43;
	Mon, 10 Nov 2025 18:37:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="JnWKk2Jt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68D9683A9F; Mon, 10 Nov 2025 18:37:56 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4AC183957
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 18:37:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YnrlLR/w9aP8+Ov17dXvdhzzuqG6fJf3Du+5xDGkGBTehNjXGYmIvUIeUUMLgaUF4kyXZv+2vXBAGGA5SkAP+rS8MTP/Wj+TtVy6/LRdEHpZO4ZllIXm32EE62tOA7S0tegMBKlFpPCrhSKli76hMTQuVWzqa4kohnyrRXTKGVHPVP1GWSMz2pSmwCu8ZCQj14UU8bvcMehDahYat78FIhya2IypiUgV6wGAI0NQWIRdnqCoaRiuLVGnlOS580FaSq7rovLHaMXAucnLEM5tUJeNz6VjYQmu5Gp2hRoDxzckThVNuMdznlIJWQ2zetMiFNFejGGi4PhfAVBSOvIpMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZS8/hAcKchNyADXz/8V+AFrWNDnxBvGJiyGzPH7ZZk=;
 b=d2qHJJAy7R7rioovHkr5YGsojraaMqwnqcJVMoFm3Q3GVDSmeqzd3EZc4o81gIaEZQYNJwMBr5dROPYeWDUo+1Lfvwo8UWVe+Ob1XXwfv/DjAU/eN8k8iMVcHMV9HdH2kpe6zR63r9cJS+ky2rB+9glzBUvooFsC6OqIN+Q+oDk/yDR9ZQ9Z/JAbuvZqJza6IopeOAZ/LoYMTne40dQ1GjcFeYD1y98bvGzKqfvKI6uzNC86/bl9zJl9c8BZGwkNaOxauXUyYghyl6Rwx7ynv+OJivQvvuyTck46SyVegYthSlAngsj5V9XCAqGlVPErQIA9v/JKexaoic51eg3Kcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZS8/hAcKchNyADXz/8V+AFrWNDnxBvGJiyGzPH7ZZk=;
 b=JnWKk2Jtt7bsJ7Qfi45yoi0GNiOls+FP9uQKO3n2cqL85Vc5bIFh6ibaU/lerKDV9PkX1+SdTBFiqJfzRILG48rQopis2N9KuhFZkxMP7HSqNa9aP8eUrS5KrlaMVVAMHXs1y0jBHOrv8jnaKUiKcVnVmW6lU/ebpuYWvxCLQXQ23IpdNaNKkhQP2OPgCkk/6YPo93JWvSZmN5WbIL0pv8cHk2Mv4SUPG377FovilNHT0P6Y4eGtUrwqIIhZ2PbvFsuL80MWidllnguvPx2tOpw5IYo6koR37NaTvoSC2AvzWa1OxpgrsR+XTwDda99xKtXGg7At/pW/GIvbZ2ogag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by BY1PR03MB7802.namprd03.prod.outlook.com (2603:10b6:a03:5b2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 17:37:50 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 17:37:49 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com, tanmay.kathpalia@altera.com,
 balsundar.ponnusamy@altera.com
Subject: [PATCH 3/8] mmc: sdhci-cadence: Set controller and PHY speed modes
 for SD and eMMC cards
Date: Mon, 10 Nov 2025 09:37:32 -0800
Message-Id: <20251110173737.24545-4-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20251110173737.24545-1-tanmay.kathpalia@altera.com>
References: <20251110173737.24545-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::13) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|BY1PR03MB7802:EE_
X-MS-Office365-Filtering-Correlation-Id: fdbc396a-44de-48e1-e484-08de207fde40
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|366016|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uN3Sv5xSqXVuLiupgkiQ31LrRRbW/b/yO2XZDRMhvb55rN4uuLUsPjkNcuAY?=
 =?us-ascii?Q?IjmrSNFsVIA0wnPgwW3shFu2jWQ3G/U2yefFjzAPsv1InjVCJqXWh1S6tvOC?=
 =?us-ascii?Q?LZsMCzoo1SQo4vL+mIsDRQGhfen7hxNfl1+I91wMbLN5uaNbsDXekB1CLHqV?=
 =?us-ascii?Q?5t5mRbCoaZ3J9/A2no1hzgl7ZBUnIovaf9vjWhsUDIG49oLQ9bWpQCebLB6F?=
 =?us-ascii?Q?zyYYpM+fAx1oFKYe/XHbsN3PI+0mBQJCWwUpSTX7A0CLu/BjfXsZfLTRWIft?=
 =?us-ascii?Q?ibX1iaQOQEA6Fuo+ieQijwHCC2ITuY3O/qumK3ihw8EuXeWaV8VcO/3Y0j4q?=
 =?us-ascii?Q?pPcTv/2fctl9wbF3xUGH+fqq+zJVb4UJUMSklv7tszN8znx3eHhuCgJXLwKh?=
 =?us-ascii?Q?v2J/TwhI+IKB+bB6ig137E/JOpGdKTLZ4q4+zmkl27bMknhjUWNr2DjOxJIw?=
 =?us-ascii?Q?JLGglHaCwCjkRCu4YXzi5Y0iQrkxNkaR0AssDVi8Ze3B9le4x4ElsEq54X/w?=
 =?us-ascii?Q?vc2I7nrXXSdNh7pCOrh3MZzvQ1b92VY1TX99MJKGeAHTOvIPTeaw6EYcOUTU?=
 =?us-ascii?Q?saLbjmJsED0ObUKQZX0uakqawqeuTElHl0MzJvU/M5QjgFkSYhq7BdHCOs1r?=
 =?us-ascii?Q?XU7TyR90yOyrnTNFa8KtoQUtlmor72oCuPgJVWhhLFj+Bsu7HgrK8GfRAF+R?=
 =?us-ascii?Q?e7tVIiyWhMPDtjqjjglyy/BUrGhUs4KXqlJ/TJuh8KeGXkCe4rb7tXE3QWIL?=
 =?us-ascii?Q?iVR4H6DjQMMAgJxzu0dlaE/ZX7LnHavx7btexWF5DhJrPTqZHKA0sJ70Fj8h?=
 =?us-ascii?Q?2voLi31OsO8AwHrKEaID2V/TPvNwnTA/LJvLKDGrK4+z5qUIUN+BTSgOkTJN?=
 =?us-ascii?Q?SjG/1BLCMO0PHD/kSR7muHeCO/RA78beBejH/EYn4tREoe9U0rukwsdf5LYn?=
 =?us-ascii?Q?SYmcREaOC4AZx1yP+HoP3xZ3LWzqAV5XKTxW0ZQ9IgNE95K9w4OAIfxjwYXc?=
 =?us-ascii?Q?Zcwg4guiyg/lFrLsRRra3w65RPmAvlJH58wNcLZbY07ByjWMaA4kEq+oR7dA?=
 =?us-ascii?Q?iWT1Y62loMMa7xTA9LzFqARXE2YsSbNUKHSDwcc7YAzD6JrZiz8B47GDdkGU?=
 =?us-ascii?Q?yeK+QmB1fjzWJ0bBYZ8Gpf3V74cowFlENw6OZf2MebJsHgjNelWOumKazjrj?=
 =?us-ascii?Q?2B61PYIEOnrtk9d1DdaCpLi0JFjtLWbk+BoxnrlcVi+qCKC4EVwhAgiSLrGZ?=
 =?us-ascii?Q?+wTRPWvNOikwlim5yQ7niKoA3J70CrYwpu83xFdgXX3LNY/uZ+ccH7TF1GbS?=
 =?us-ascii?Q?dQj/V7I37r3gKxeK/wlNjKdDG4ISwwFQzCFqXtSA1IE3S6BiHWdK2ynA81jZ?=
 =?us-ascii?Q?F9kurZndxmY5GpGr2uXdxAA/HrYb7yxx3e6AtN7mSJY2boqLEQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JmfgYFdcPj44Oai0QxfiDyP95cQzrkWOjTb1yXR0bSoXnNUACOsFJ87b0m5S?=
 =?us-ascii?Q?mpiJ4opoC8eZQpmdvud4E4WOtTZJNOuqPNG+QX/rKLFlJwwfHhBJ0AnXeTua?=
 =?us-ascii?Q?+sqRgyRPoRtnGeJZIMuVR1rckd53F38oqvrbYNp5EGRbEZKJjyxC3PxDB1Ur?=
 =?us-ascii?Q?sH40nOryBqE1QHvdbg2w0+frDPlEsY32IQPS8jz+Qhut96tMrvX8IOhDJKIL?=
 =?us-ascii?Q?O2VxYtBBi33FcUcmY3elYSKV3/XNr/5jpwBPKvHmUIgpt3jqBtSthfIjUJe7?=
 =?us-ascii?Q?iljfUnvdXMtAylq4tPHxzgZ8ILv9zcFRvEhRkLgobT/4zf87OyeFH7RTWZRp?=
 =?us-ascii?Q?3EzunQf0WOQaqp0ukUJkUfM5J5nFVh7BL4H/12CYN9ajHLknQ9+KTCwJUTqh?=
 =?us-ascii?Q?KUG3tt15hr93zwU/+5PYEd+XdgijziOBCkCTqCf38IYF0Ze2pXe2yQbvtQpr?=
 =?us-ascii?Q?TFZPKJtl2goisEF8WYwDnAFkfdqwTy8Vv3EXal8VP0VsNc8j595v9ENwI9NY?=
 =?us-ascii?Q?881APv0DZqvq6T9Pk1VTAilva/iPyof0eedkuTd5luTXZtjfToqWv2pnXGis?=
 =?us-ascii?Q?erTfjPCsKGf5dcfHxcBsQh/BgOK4z/2GpnBGc4T3MPiDafk+BoC0e0HV9fjZ?=
 =?us-ascii?Q?KWasOhCbbmEAtFNrpucakK/z/dsstAHZBf8SvK4QXGp6KxF8/G77maxcGrB2?=
 =?us-ascii?Q?g2OovI8OkyDLGLm+7a0iTpXJaAHHBQZbhtwayBo1N14nVX3RVIML1Y3/ejj7?=
 =?us-ascii?Q?IJbSovQo2rDK3gWhMf7R9QZvbq9KQYdv6jlBIPVVSfQ9bFv6qBUIxs7vR6kS?=
 =?us-ascii?Q?7PTp2mwjdiq0Kcz+0MzeVWRKO9KIVKcHsnl3zqZv1wFRZECKRT5pNXxK81eU?=
 =?us-ascii?Q?MH12fypB7+sKaaEUjlQ3vGxw/UL4k6SfN7ndHgOAQEphoLBVrPFMqHCnP85Z?=
 =?us-ascii?Q?tvkXYizAvqqFm2lTrqLWFx+Xm3UdGkQ1sOqYmFTxACLDwlpspPQh2p6lSkXv?=
 =?us-ascii?Q?nR8U1TF+qleUa9p0uMSe4DOe/0KkwLyvf2/rFLwcOk36XlWMOLx+UIia3sy0?=
 =?us-ascii?Q?rRKWGTsAi4IQGpV64g8QyjT6BVb0vcaJwBanlSI6j/Z9TSj3mbUECrKdz5WB?=
 =?us-ascii?Q?KKrds8E9NsvW1Af20vFxAYv4piS26IlThuAcCE/G+3lXk34QTAXWx7rruh3B?=
 =?us-ascii?Q?niMs18w4FExz+ywihTQ/IbcBxYjmO3CAPBiuf9dhxkJ+mUUcnqhLf3qmwhtl?=
 =?us-ascii?Q?FKrlCrNjmyQiM/uRRQiEJG28MhSHlSa/Ghbokd02QFOl+l2k7gw26GVfGNa9?=
 =?us-ascii?Q?CmOaDKsdmwZIY8Y2KVE4Y6XDr0JTpODP/DpGgLO3SEFl58GpMvHFXkR4NIEJ?=
 =?us-ascii?Q?m3piMcsuYHBp5TxKg8nNarUqtu0gLqHJCVon++cVheymtaiiMhxLK/iHbXT7?=
 =?us-ascii?Q?NBwTQM6uyf1tY/iYUa/4BuYK0jJBXRYpPhM/a2fMmcSGuI7Hi6VhuvB/CRkU?=
 =?us-ascii?Q?hYFRDTavQsUBkx4B9UptS+8otYNZ9Sazi/07hhPffO31XEf6r1UptJPb1LcT?=
 =?us-ascii?Q?eYdsuYghECAUH2nILb18EBbTvpcnI9lpxu8WL5uzTxtROuy4NCylBi1OVxXk?=
 =?us-ascii?Q?/Q=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdbc396a-44de-48e1-e484-08de207fde40
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 17:37:49.6818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxzk7wec0r4QfHrthHkV5oz5aw+ypY4g8TD388uOG4lJfI722BEhtz/omLooS0Yy702VB/PVyxo5lXISxF4IHhfLVuTRyVORe9yomYvgnWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7802
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

Replace the legacy clock frequency-based timing mode selection with
proper MMC timing mode constants.

Changes to sdhci-cadence.c:
- Add sdhci_cdns_get_hrs06_mode() helper function for mode selection
- Replace clock frequency logic with mmc->selected_mode switch statement
- Use proper MMC timing constants (MMC_HS, UHS_SDR104, etc.)
- Add SD card specific handling with standard SDHCI control register setup

Changes to sdhci-cadence6.c:
- Add SD high speed PHY and control configuration arrays
- Update sdhci_cdns6_phy_adj() to use timing modes instead of HRS06 modes
- Support both SD and eMMC timing modes with appropriate PHY settings

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Reviewed-by: Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>
---
 drivers/mmc/sdhci-cadence.c  | 72 +++++++++++++++++++++++++++---------
 drivers/mmc/sdhci-cadence6.c | 39 ++++++++++++++++---
 2 files changed, 87 insertions(+), 24 deletions(-)

diff --git a/drivers/mmc/sdhci-cadence.c b/drivers/mmc/sdhci-cadence.c
index f31437e5eeb..a151ce10ddc 100644
--- a/drivers/mmc/sdhci-cadence.c
+++ b/drivers/mmc/sdhci-cadence.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2016 Socionext Inc.
  *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
 #include <dm.h>
@@ -84,39 +85,74 @@ static int sdhci_cdns_phy_init(struct sdhci_cdns_plat *plat,
 	return 0;
 }
 
+static unsigned int sdhci_cdns_get_hrs06_mode(struct mmc *mmc)
+{
+	unsigned int mode;
+
+	if (IS_SD(mmc)) {
+		mode = SDHCI_CDNS_HRS06_MODE_SD;
+	} else {
+		switch (mmc->selected_mode) {
+		case MMC_LEGACY:
+			mode = SDHCI_CDNS_HRS06_MODE_SD; /* use this for Legacy */
+			break;
+
+		case MMC_HS:
+		case MMC_HS_52:
+			mode = SDHCI_CDNS_HRS06_MODE_MMC_SDR;
+			break;
+
+		case UHS_DDR50:
+		case MMC_DDR_52:
+			mode = SDHCI_CDNS_HRS06_MODE_MMC_DDR;
+			break;
+
+		case UHS_SDR104:
+		case MMC_HS_200:
+			mode = SDHCI_CDNS_HRS06_MODE_MMC_HS200;
+			break;
+
+		case MMC_HS_400:
+		case MMC_HS_400_ES:
+			mode = SDHCI_CDNS_HRS06_MODE_MMC_HS400;
+			break;
+
+		default:
+			mode = SDHCI_CDNS_HRS06_MODE_SD;
+			break;
+		}
+	}
+	return mode;
+}
+
 static void sdhci_cdns_set_control_reg(struct sdhci_host *host)
 {
 	struct mmc *mmc = host->mmc;
 	struct sdhci_cdns_plat *plat = dev_get_plat(mmc->dev);
-	unsigned int clock = mmc->clock;
 	u32 mode, tmp;
 
 	/*
-	 * REVISIT:
-	 * The mode should be decided by MMC_TIMING_* like Linux, but
-	 * U-Boot does not support timing.  Use the clock frequency instead.
+	 * Select HRS06 mode based on card type and selected timing mode.
+	 * For SD cards, always use SD mode (000b) as per Cadence user guide,
+	 * section 12.7 (HRS06), Part Number: IP6061.
+	 * For eMMC, use selected_mode to pick the appropriate mode.
 	 */
-	if (clock <= 26000000) {
-		mode = SDHCI_CDNS_HRS06_MODE_SD; /* use this for Legacy */
-	} else if (clock <= 52000000) {
-		if (mmc->ddr_mode)
-			mode = SDHCI_CDNS_HRS06_MODE_MMC_DDR;
-		else
-			mode = SDHCI_CDNS_HRS06_MODE_MMC_SDR;
-	} else {
-		if (mmc->ddr_mode)
-			mode = SDHCI_CDNS_HRS06_MODE_MMC_HS400;
-		else
-			mode = SDHCI_CDNS_HRS06_MODE_MMC_HS200;
-	}
+	mode = sdhci_cdns_get_hrs06_mode(mmc);
 
 	tmp = readl(plat->hrs_addr + SDHCI_CDNS_HRS06);
 	tmp &= ~SDHCI_CDNS_HRS06_MODE;
 	tmp |= FIELD_PREP(SDHCI_CDNS_HRS06_MODE, mode);
 	writel(tmp, plat->hrs_addr + SDHCI_CDNS_HRS06);
 
+	/*
+	 * For SD cards, program standard SDHCI Host Control2 UHS/voltage
+	 * registers for UHS-I support.
+	 */
+	if (IS_SD(mmc))
+		sdhci_set_control_reg(host);
+
 	if (device_is_compatible(mmc->dev, "cdns,sd6hc"))
-		sdhci_cdns6_phy_adj(mmc->dev, plat, mode);
+		sdhci_cdns6_phy_adj(mmc->dev, plat, mmc->selected_mode);
 }
 
 static const struct sdhci_ops sdhci_cdns_ops = {
diff --git a/drivers/mmc/sdhci-cadence6.c b/drivers/mmc/sdhci-cadence6.c
index ead96dc0c91..d4e2cb1c83e 100644
--- a/drivers/mmc/sdhci-cadence6.c
+++ b/drivers/mmc/sdhci-cadence6.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2023 Starfive.
  *   Author: Kuan Lim Lee <kuanlim.lee@starfivetech.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
 #include <dm.h>
@@ -77,6 +78,13 @@ static struct sdhci_cdns6_phy_cfg sd_ds_phy_cfgs[] = {
 	{ "cdns,phy-dq-timing-delay-sd-ds", 0x00000001, },
 };
 
+static struct sdhci_cdns6_phy_cfg sd_hs_phy_cfgs[] = {
+	{ "cdns,phy-dqs-timing-delay-sd-hs", 0x00380004, },
+	{ "cdns,phy-gate-lpbk_ctrl-delay-sd-hs", 0x01A00040, },
+	{ "cdns,phy-dll-slave-ctrl-sd-hs", 0x00000000, },
+	{ "cdns,phy-dq-timing-delay-sd-hs", 0x00000001, },
+};
+
 static struct sdhci_cdns6_phy_cfg emmc_sdr_phy_cfgs[] = {
 	{ "cdns,phy-dqs-timing-delay-semmc-sdr", 0x00380004, },
 	{ "cdns,phy-gate-lpbk_ctrl-delay-emmc-sdr", 0x01A00040, },
@@ -112,6 +120,13 @@ static struct sdhci_cdns6_ctrl_cfg sd_ds_ctrl_cfgs[] = {
 	{ "cdns,ctrl-hrs07-timing-delay-sd-ds", 0x00080000, },
 };
 
+static struct sdhci_cdns6_ctrl_cfg sd_hs_ctrl_cfgs[] = {
+	{ "cdns,ctrl-hrs09-timing-delay-sd-hs", 0x0001800C, },
+	{ "cdns,ctrl-hrs10-lpbk_ctrl-delay-sd-hs", 0x00030000, },
+	{ "cdns,ctrl-hrs16-slave-ctrl-sd-hs", 0x00000000, },
+	{ "cdns,ctrl-hrs07-timing-delay-sd-hs", 0x00080000, },
+};
+
 static struct sdhci_cdns6_ctrl_cfg emmc_sdr_ctrl_cfgs[] = {
 	{ "cdns,ctrl-hrs09-timing-delay-emmc-sdr", 0x0001800C, },
 	{ "cdns,ctrl-hrs10-lpbk_ctrl-delay-emmc-sdr", 0x00030000, },
@@ -186,27 +201,39 @@ int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 m
 	int i, ret;
 
 	switch (mode) {
-	case SDHCI_CDNS_HRS06_MODE_SD:
+	case UHS_SDR12:
+	case MMC_LEGACY:
 		sdhci_cdns6_phy_cfgs = sd_ds_phy_cfgs;
 		sdhci_cdns6_ctrl_cfgs = sd_ds_ctrl_cfgs;
 		break;
 
-	case SDHCI_CDNS_HRS06_MODE_MMC_SDR:
+	case SD_HS:
+	case UHS_SDR25:
+	case MMC_HS:
+		sdhci_cdns6_phy_cfgs = sd_hs_phy_cfgs;
+		sdhci_cdns6_ctrl_cfgs = sd_hs_ctrl_cfgs;
+		break;
+
+	case UHS_SDR50:
+	case MMC_HS_52:
 		sdhci_cdns6_phy_cfgs = emmc_sdr_phy_cfgs;
 		sdhci_cdns6_ctrl_cfgs = emmc_sdr_ctrl_cfgs;
 		break;
 
-	case SDHCI_CDNS_HRS06_MODE_MMC_DDR:
+	case UHS_DDR50:
+	case MMC_DDR_52:
 		sdhci_cdns6_phy_cfgs = emmc_ddr_phy_cfgs;
 		sdhci_cdns6_ctrl_cfgs = emmc_ddr_ctrl_cfgs;
 		break;
 
-	case SDHCI_CDNS_HRS06_MODE_MMC_HS200:
+	case UHS_SDR104:
+	case MMC_HS_200:
 		sdhci_cdns6_phy_cfgs = emmc_hs200_phy_cfgs;
 		sdhci_cdns6_ctrl_cfgs = emmc_hs200_ctrl_cfgs;
 		break;
 
-	case SDHCI_CDNS_HRS06_MODE_MMC_HS400:
+	case MMC_HS_400:
+	case MMC_HS_400_ES:
 		sdhci_cdns6_phy_cfgs = emmc_hs400_phy_cfgs;
 		sdhci_cdns6_ctrl_cfgs = emmc_hs400_ctrl_cfgs;
 		break;
@@ -263,7 +290,7 @@ int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 m
 
 int sdhci_cdns6_phy_init(struct udevice *dev, struct sdhci_cdns_plat *plat)
 {
-	return sdhci_cdns6_phy_adj(dev, plat, SDHCI_CDNS_HRS06_MODE_SD);
+	return sdhci_cdns6_phy_adj(dev, plat, MMC_LEGACY);
 }
 
 int sdhci_cdns6_set_tune_val(struct sdhci_cdns_plat *plat, unsigned int val)
-- 
2.43.7

