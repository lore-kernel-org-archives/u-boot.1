Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5546AD39404
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 09:29:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 216B784101;
	Thu,  2 Apr 2026 11:29:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="heFut8uS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45BFC8416F; Thu,  2 Apr 2026 11:29:36 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1ADE584105
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 11:29:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FVfBe5QTSVY4QcX2zI1r7GyARd3c8jOFh1d04PrSgv1UE/VxdZJUP9lodZ5KASztNGg8w2j0+WKUgBVb9iV+HfnjWINv/jcRG78JO+QoCMkcrGXFpJK6SNaUXXz6OWqgLhmbuP4JU302T4YjJ0GmeZU2dDh3kI1c5p0QVlJR7aLYS/KiIUrGNM0F2WXfMGSBdyyzQ2iWuD6IqTrm3ETvr3mVwGXfOqwJT7qYjfmKdS9YFb/JkxzNLEmdqjW0+JyT9+cdDgvW0W/El28+O0ZAbDrC8DuKQeJ8kdEXGX0Kn758k2l34cF+y2Zewd/6yStqshnjO0bDsgkrfrgxqnu6BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9i87pC02SZqITDDg6vBNSC75GOF//gNORXhM/kl/3AI=;
 b=Vnj62THmuRqMECjUAYZWHq+xTmL5ajecCMmVgnwuMIqAiiFDTfGgxutA+gl2rMMqkWVX42v+wAVPxObgpMFoOpRoxhO6yhZNfK53jTvg2+qHYhYQi6e3b4V8kedYOk02rtppVSkOSv73VliVjBJ9dWBAD0i+5cIm6qMDxZWjQY4+xlCEW0XKoGMRN8TqR1cexgSAM/1bqz49cEksjbbPpxFFauUrmDM7WpM5/0T5zpbagV7PV+5tPDnTgTL93j6sJ7GKtgAY9zvpybvyz8Ml5l+NqLejuMsdpWxZSzLjQeYzejA12HgIRCFcf3JEDnWPRZvFNBc+ZUwukSKsvmltjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9i87pC02SZqITDDg6vBNSC75GOF//gNORXhM/kl/3AI=;
 b=heFut8uSIBM2r8hdm3oa36twAzQpVszduNq3l/eyR0tPpBt4wD8ui+lc0rD9gwLFVtzCRn4ihKs/1DdDDH49eR4U+AFioe/sXYAPBR1BYhoq43FbBR3cLtnZB4S/jBfS79KW5D6jEtfDVRtSjQafZfS78tynuIUfYNN33w6Iip5oe5/z67VG1IfNK7hseTUzMIZ5P3Al0BmjVHJynrtFBKE8L7pB/RIh0naOMcDH8e6SqtfxONi6MW4rATf28pVFVOMCPa1zF4LZUx9gPJENb0VSnXAZT5AKwihlWG266p+AdfbbaYMMkWalBXYcp6wfP70f0x7Y3mVl75ZluniZVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com (2603:10a6:800:306::9)
 by AM7PR04MB7095.eurprd04.prod.outlook.com (2603:10a6:20b:11c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Thu, 2 Apr
 2026 09:29:29 +0000
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7]) by VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7%4]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 09:29:28 +0000
From: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>
To: uboot-imx@nxp.com,
	u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, viorel.suman@nxp.com, simona.toaca@nxp.com,
 ye.li@nxp.com, ping.bai@nxp.com, marex@nabladev.com,
 sebastien.szymanski@armadeus.com, ravi@prevas.dk,
 joao.goncalves@toradex.com, ji.luo@nxp.com, semen.protsenko@linaro.org,
 tharvey@gateworks.com, qijian.guo@nxp.com
Subject: [PATCH v3 1/6] imx9: Add support for saving DDR training data to NVM
Date: Thu,  2 Apr 2026 12:40:43 +0300
Message-ID: <7edcce04b39aabc1f58e09814e7fadff226e2bb8.1775121078.git.simona.toaca@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1775121078.git.simona.toaca@nxp.com>
References: <cover.1775121078.git.simona.toaca@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::6) To VI0PR04MB11917.eurprd04.prod.outlook.com
 (2603:10a6:800:306::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11917:EE_|AM7PR04MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c71b885-b63d-4dbc-2732-08de909a5692
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: ygE95mLB/fLNhRmnlj5ob6UxgUUCtvLYtXLkWG7qA+o8pOtETOl+DVvLUoTOKgFTXK4JNzeWg9VBd/l7l4CunzADC8+zu1oKYwRBZ9MMeN0yC9satj0DvdTrSHg7AN3bOt2EjIKk9+v8myKGJN98mBZ6O0Zz4q/ZQWGf/cG1mqf8tvjBdHzSOjJdUtQ5QVJw5l/9PT9wMhXsXd0pELSOlWP0mCRd8+V5T4uk4sR8VYMEsQeYOpgE0X6MILM3hu/tn/oVpodmCmappkQEdzhkWWbjoOLpKDF39ozgRudAx/Ef8CnWO3T4GtnT72501q8UxGGQ8qllSfgeKZA37elunEXxBGt1j/YvRm94sO7jgXvGqSxMWHzbtbeImlH42QJ08FjcU7chJCov/oQzzdA43+0CLg3sq7KlgF5Wo6WcVwBmBmPgTBflLZe1C+1EJJc3Aq+jGHMJ9s5yuOiLcYM65Ok9rBQwrHjvRkTomtqJRrPpELATi8y6HP28AAWon7CX23+g939JSfi186+Ga8mEv7wjw00+dP9QPd/jtUcmwiv3UepOX+ci0sGQpmBpXcWyea0oBUATeuu8uXHD55LijwlCnaxfJnES2jRyPddS2kKDAYKcDtgLEar7X30SSo4cALxKbwwhXMmh32VTfaXJtx3elvQ13yUhtBIcfhzs+Gdmpxgvs93fkW8jo48D5mMpNCyUUB6lajRppNUFQiSDUcq/dWrnJVrzTHu03uzAy14=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB11917.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w94le6s5+0M24LFTBtYp4VpRzyaNEGoZJV27TGpuDX8EOZgRaUudK05/mLtl?=
 =?us-ascii?Q?Zqpx71umk5fLUGBisTlvL0vJgnh6rIidv5t9LqscoIGe9vlWSlmYXoykD+CH?=
 =?us-ascii?Q?FgVMHNAVYKUDrke98BUw6CX+D+fjBD7P/8hjnGOpDQjjlVSFajW95I9NgoES?=
 =?us-ascii?Q?vrJGb8e4cei5Yx03ZnvUq8je3c/haQdD1qoiBvTKrzBLnCQxAqIwKSYFr5yF?=
 =?us-ascii?Q?zBzusDeMQcaonGgHPoZGO3W9bmQhYNTj2NmkQZ4wzln+2Z1gfFRuzIvdnlCm?=
 =?us-ascii?Q?R4NcsjQico4XMv7xthr/d0B1txc/mTVEamCogWWMinlep9VJe1I8l+9ubHuD?=
 =?us-ascii?Q?hh9UanovkAM3Hp3VPDxiC7kLfepG/ir2kPOS04mNPckjqW/5+pJsMNCaKGyI?=
 =?us-ascii?Q?RLr0IUtZP3hCVdDxClYvYJ/2Ckw4z4OeFnsqT5JNqdRmqmXDPmzsyEugJgvQ?=
 =?us-ascii?Q?1p9CK7n/b1uRxxxihsSmeAH4/vPTqLSAl3/oRSsAlHsqkHOYBrJ6WV+f+Ono?=
 =?us-ascii?Q?3/tvH0n6AFSXDoZSWmWTmqJx6r19u4v7+UBqiB0WW4jCQ2oKB7NFSXTfOCAb?=
 =?us-ascii?Q?YfxtuXzjJmW0dM7Gb2P3EIAVjQgZ1G7jUujSz2uScWzxuQU8XhHnE1iaDxE0?=
 =?us-ascii?Q?sPr7LeuxnW3hEaWkZLcoBR1CejUPZVMCy9Z31Lxx91i8MVHGzkAgsYKEeY5r?=
 =?us-ascii?Q?3JaehwZWyQA2oTprf5LjU6libD/PxA0mUiFQThC2hvccE+N8iWY67AhvlVCM?=
 =?us-ascii?Q?DLPvzpGFEGnGtqhszMNMev1uexSeWpKJ71O+EypjqaktSs65E9cR2kwgfBbx?=
 =?us-ascii?Q?lAr4FNxUnGs5blhYQfiEywBWgifVj75xZC6/JV4O2rTULiUomeieO/Ec6Dcj?=
 =?us-ascii?Q?WHeoX5fuyOGV+PKGyH3YnGdNaV9y02I8O4ljIaJ9ENvDKmyPsKyhG5jlsihS?=
 =?us-ascii?Q?o0cdv7Fxkd5lRIzRt904vT/e0Pfd+nckv5L7AlBVqApEy4GzWxP+tH0bEZEn?=
 =?us-ascii?Q?n9CW8S3VFtu2bIEP1YhQvdmjQGKsCyuOUSMZlAleuNUr7H438gJgAOflYM9p?=
 =?us-ascii?Q?0fsA4YAGT92NSgQA6ld2sjKOC0TSUfPoWtrxs1BHAAF3Pue7Hs0C0P8c2x5M?=
 =?us-ascii?Q?dtBR6uqg08toEEvwK2jI3ofDNYARnJMqGwVlm6oYVxMxQ351DLlHwYE/cwpL?=
 =?us-ascii?Q?/xsm5WSobfCXTGqZ5D2O37297mI3dL1Y5fPyKBWeeZ8OBy3MSrVb2IauxVLm?=
 =?us-ascii?Q?2Rhfy2fB2ElYEhXFFF+awGDvzZBBfHN6X9RB9+T2hfLwKT4Y59YVRN8kK2GV?=
 =?us-ascii?Q?+aGdDWRA7lI1/T2kPq4pVv1BJ/9rpKnPkiMeRFgZWxBXVh0I2i0en9KfVBYW?=
 =?us-ascii?Q?pLikDw86ZNz9R/CQ5tAtsPKl6+tgja/Hs14LlrGbLcFHNHi2ks1dMYNuviV1?=
 =?us-ascii?Q?2wX7TwYg9oRvqfLmFi3a84ZQLAsJmdSCt48CsYyXOEh9s2HYV3J3TAkbqj+w?=
 =?us-ascii?Q?FyH2DFSbEsOdCEwsEsdh2bDEqalOm2Cfa37dGot58Kvky69lRnRzlbjG80xP?=
 =?us-ascii?Q?XtuoMkurUvq8WwGxTA42shlCvMtmLcf7AvJiCs1GxVqmaUE6S/WycZkk7FPj?=
 =?us-ascii?Q?gqSur7yQkFgEcjQo6nXyKCaJFAC+JTU2hfXwHhLSvQZna7lBrvCJFGwcNVdY?=
 =?us-ascii?Q?K5eFNTOYPiPCQfLqQDRbqfVWtAWyXRJnwYOMnLMEE0Q/i3PhqbiBaRCaX0Tf?=
 =?us-ascii?Q?zPkhXgDewg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c71b885-b63d-4dbc-2732-08de909a5692
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11917.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 09:29:28.8564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQkQ++/i/GrN0MzrdlaHk0CwE0QLyJaS5eOJBwf99UriAh93/9NhCQLnAln3YmhRQOZ7BZwYJo7PWUmmCGYBpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7095
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

From: Simona Toaca <simona.toaca@nxp.com>

DDR training data can be saved to NVM and be available
to OEI at boot time, which will trigger QuickBoot flow.

U-Boot only checks for data integrity (CRC32), while
OEI is in charge of authentication when it tries to
load the data from NVM.

On iMX95 A0/A1, 'authentication' is done via another
CRC32. On the other boards, authentication is done by
using ELE to check the MAC stored in the ddrphy_qb_state
structure.

Supported platforms: iMX94, iMX95, iMX952 (using OEI)
Supported storage types: eMMC, SD, SPI flash.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Simona Toaca <simona.toaca@nxp.com>
---
 arch/arm/include/asm/arch-imx9/ddr.h |  48 +++-
 arch/arm/include/asm/mach-imx/qb.h   |  15 ++
 arch/arm/mach-imx/imx9/Makefile      |   6 +-
 arch/arm/mach-imx/imx9/qb.c          | 379 +++++++++++++++++++++++++++
 arch/arm/mach-imx/imx9/scmi/soc.c    |   7 +
 drivers/ddr/imx/imx9/Kconfig         |   7 +
 6 files changed, 459 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/include/asm/mach-imx/qb.h
 create mode 100644 arch/arm/mach-imx/imx9/qb.c

diff --git a/arch/arm/include/asm/arch-imx9/ddr.h b/arch/arm/include/asm/arch-imx9/ddr.h
index a8e3f7354c7..290e3e4e06e 100644
--- a/arch/arm/include/asm/arch-imx9/ddr.h
+++ b/arch/arm/include/asm/arch-imx9/ddr.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Copyright 2022 NXP
+ * Copyright 2022-2026 NXP
  */
 
 #ifndef __ASM_ARCH_IMX8M_DDR_H
@@ -100,6 +100,52 @@ struct dram_timing_info {
 
 extern struct dram_timing_info dram_timing;
 
+/* Quick Boot related */
+#define DDRPHY_QB_CSR_SIZE	5168
+#define DDRPHY_QB_ACSM_SIZE	(4 * 1024)
+#define DDRPHY_QB_MSB_SIZE	0x200
+#define DDRPHY_QB_PSTATES	0
+#define DDRPHY_QB_PST_SIZE	(DDRPHY_QB_PSTATES * 4 * 1024)
+
+/**
+ * This structure needs to be aligned with the one in OEI.
+ */
+struct ddrphy_qb_state {
+	u32 crc;		  /* Used for ensuring integrity in DRAM */
+#define MAC_LENGTH              8 /* 256 bits, 32-bit aligned */
+	u32 mac[MAC_LENGTH];	  /* For 95A0/1 use mac[0] to keep CRC32 value */
+	u8 trained_vrefca_a0;
+	u8 trained_vrefca_a1;
+	u8 trained_vrefca_b0;
+	u8 trained_vrefca_b1;
+	u8 trained_vrefdq_a0;
+	u8 trained_vrefdq_a1;
+	u8 trained_vrefdq_b0;
+	u8 trained_vrefdq_b1;
+	u8 trained_vrefdqu_a0;
+	u8 trained_vrefdqu_a1;
+	u8 trained_vrefdqu_b0;
+	u8 trained_vrefdqu_b1;
+	u8 trained_dramdfe_a0;
+	u8 trained_dramdfe_a1;
+	u8 trained_dramdfe_b0;
+	u8 trained_dramdfe_b1;
+	u8 trained_dramdca_a0;
+	u8 trained_dramdca_a1;
+	u8 trained_dramdca_b0;
+	u8 trained_dramdca_b1;
+	u16 qb_pll_upll_prog0;
+	u16 qb_pll_upll_prog1;
+	u16 qb_pll_upll_prog2;
+	u16 qb_pll_upll_prog3;
+	u16 qb_pll_ctrl1;
+	u16 qb_pll_ctrl4;
+	u16 qb_pll_ctrl5;
+	u16 csr[DDRPHY_QB_CSR_SIZE];
+	u16 acsm[DDRPHY_QB_ACSM_SIZE];
+	u16 pst[DDRPHY_QB_PST_SIZE];
+};
+
 void ddr_load_train_firmware(enum fw_type type);
 int ddr_init(struct dram_timing_info *timing_info);
 int ddr_cfg_phy(struct dram_timing_info *timing_info);
diff --git a/arch/arm/include/asm/mach-imx/qb.h b/arch/arm/include/asm/mach-imx/qb.h
new file mode 100644
index 00000000000..aeec26718cb
--- /dev/null
+++ b/arch/arm/include/asm/mach-imx/qb.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2026 NXP
+ */
+
+#ifndef __IMX_QB_H__
+#define __IMX_QB_H__
+
+#include <stdbool.h>
+
+bool qb_check(void);
+int qb(int qb_dev, bool save);
+void spl_qb_save(void);
+
+#endif
diff --git a/arch/arm/mach-imx/imx9/Makefile b/arch/arm/mach-imx/imx9/Makefile
index 53cc97c6b47..d2e44f0d5f9 100644
--- a/arch/arm/mach-imx/imx9/Makefile
+++ b/arch/arm/mach-imx/imx9/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
-# Copyright 2022 NXP
+# Copyright 2022,2026 NXP
 
 obj-y += lowlevel_init.o
 
@@ -12,4 +12,6 @@ endif
 
 ifneq ($(CONFIG_SPL_BUILD),y)
 obj-y += imx_bootaux.o
-endif
\ No newline at end of file
+endif
+
+obj-y += qb.o
diff --git a/arch/arm/mach-imx/imx9/qb.c b/arch/arm/mach-imx/imx9/qb.c
new file mode 100644
index 00000000000..220545192d4
--- /dev/null
+++ b/arch/arm/mach-imx/imx9/qb.c
@@ -0,0 +1,379 @@
+// SPDX-License-Identifier: GPL-2.0+
+/**
+ * Copyright 2024-2026 NXP
+ */
+#include <dm/device-internal.h>
+#include <dm/uclass.h>
+#include <errno.h>
+#include <imx_container.h>
+#include <linux/bitfield.h>
+#include <mmc.h>
+#include <spi_flash.h>
+#include <spl.h>
+#include <stdlib.h>
+#include <u-boot/crc.h>
+
+#include <asm/arch/ddr.h>
+#include <asm/mach-imx/boot_mode.h>
+#include <asm/mach-imx/sys_proto.h>
+
+#define QB_STATE_LOAD_SIZE    SZ_64K
+
+#define MMC_DEV		0
+#define QSPI_DEV	1
+
+#define IMG_FLAGS_IMG_TYPE_MASK   0xF
+#define IMG_FLAGS_IMG_TYPE(x)     FIELD_GET(IMG_FLAGS_IMG_TYPE_MASK, (x))
+
+#define IMG_TYPE_DDR_TDATA_DUMMY  0xD   /* dummy DDR training data image */
+
+bool qb_check(void)
+{
+	struct ddrphy_qb_state *qb_state;
+	u32 size, crc;
+
+	/**
+	 * Ensure CRC is not empty, the reason is that
+	 * the data is invalidated after first save run
+	 * or after it is overwritten.
+	 */
+	qb_state = (struct ddrphy_qb_state *)CONFIG_QB_SAVED_STATE_BASE;
+	size = sizeof(struct ddrphy_qb_state) - sizeof(qb_state->crc);
+	crc = crc32(0, (u8 *)qb_state->mac, size);
+
+	if (!qb_state->crc || crc != qb_state->crc)
+		return false;
+
+	return true;
+}
+
+static unsigned long qb_get_boot_device_offset(void *dev, int dev_type)
+{
+	unsigned long offset = 0;
+	struct mmc *mmc;
+
+	switch (dev_type) {
+	case MMC_DEV:
+		mmc = dev;
+
+		if (IS_SD(mmc) || mmc->part_config == MMCPART_NOAVAILABLE) {
+			offset = CONTAINER_HDR_MMCSD_OFFSET;
+		} else {
+			u8 part = EXT_CSD_EXTRACT_BOOT_PART(mmc->part_config);
+
+			if (part == EMMC_BOOT_PART_BOOT1 || part == EMMC_BOOT_PART_BOOT2)
+				offset = CONTAINER_HDR_EMMC_OFFSET;
+			else
+				offset = CONTAINER_HDR_MMCSD_OFFSET;
+		}
+		break;
+	case QSPI_DEV:
+		offset = CONTAINER_HDR_QSPI_OFFSET;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return offset;
+}
+
+static int qb_parse_container(void *addr, u32 *qb_data_off)
+{
+	struct container_hdr *phdr;
+	struct boot_img_t *img_entry;
+	int i = 0;
+	u32 img_type, img_end;
+
+	phdr = addr;
+	if (phdr->tag != 0x87 || (phdr->version != 0x0 && phdr->version != 0x2))
+		return -EINVAL;
+
+	img_entry = addr + sizeof(struct container_hdr);
+	for (i = 0; i < phdr->num_images; i++) {
+		img_type = IMG_FLAGS_IMG_TYPE(img_entry->hab_flags);
+		if (img_type == IMG_TYPE_DDR_TDATA_DUMMY && img_entry->size == 0) {
+			/* Image entry pointing to DDR Training Data */
+			*qb_data_off = img_entry->offset;
+			return 0;
+		}
+
+		img_end = img_entry->offset + img_entry->size;
+		if (i + 1 < phdr->num_images) {
+			img_entry++;
+			if (img_end + QB_STATE_LOAD_SIZE == img_entry->offset) {
+				/* hole detected */
+				*qb_data_off = img_end;
+				return 0;
+			}
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int get_dev_qbdata_offset(void *dev, int dev_type, unsigned long offset,
+				 u32 *qbdata_offset)
+{
+	int ret = -EOPNOTSUPP;
+	u16 ctnr_hdr_align = CONTAINER_HDR_ALIGNMENT;
+	void *buf = kmalloc(ctnr_hdr_align, GFP_KERNEL);
+
+	if (!buf) {
+		printf("kmalloc buffer failed\n");
+		return -ENOMEM;
+	}
+
+	switch (dev_type) {
+	case MMC_DEV:
+		unsigned long count = 0;
+		struct mmc *mmc = dev;
+
+		if (!(CONFIG_IS_ENABLED(DM_MMC) && CONFIG_IS_ENABLED(MMC_WRITE)))
+			goto get_dev_qbdata_offset_exit;
+
+		count = blk_dread(mmc_get_blk_desc(mmc),
+				  offset / mmc->read_bl_len,
+				  ctnr_hdr_align / mmc->read_bl_len,
+				  buf);
+		if (count == 0) {
+			printf("Read container image from MMC/SD failed\n");
+			ret = -EIO;
+			goto get_dev_qbdata_offset_exit;
+		}
+		break;
+	case QSPI_DEV:
+		if (!CONFIG_IS_ENABLED(SPI))
+			goto get_dev_qbdata_offset_exit;
+
+		ret = spi_flash_read(dev, offset,
+				     ctnr_hdr_align, buf);
+		if (ret) {
+			printf("Read container header from QSPI failed\n");
+			ret = -EIO;
+			goto get_dev_qbdata_offset_exit;
+		}
+		break;
+	default:
+		printf("Support for device %d not enabled\n", dev_type);
+		goto get_dev_qbdata_offset_exit;
+	}
+
+	ret = qb_parse_container(buf, qbdata_offset);
+
+get_dev_qbdata_offset_exit:
+	free(buf);
+
+	return ret;
+}
+
+static int get_qbdata_offset(void *dev, int dev_type, u32 *qbdata_offset)
+{
+	u32 offset = qb_get_boot_device_offset(dev, dev_type);
+	u16 ctnr_hdr_align = CONTAINER_HDR_ALIGNMENT;
+	u32 cont_offset;
+	int ret, i;
+
+	for (i = 0; i < 3; i++) {
+		cont_offset = offset + i * ctnr_hdr_align;
+		ret = get_dev_qbdata_offset(dev, dev_type, cont_offset, qbdata_offset);
+		if (ret == 0) {
+			(*qbdata_offset) += cont_offset;
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int qb_mmc_get_device_index(u32 dev)
+{
+	switch (dev) {
+	case BOOT_DEVICE_MMC1:
+		return 0;
+	case BOOT_DEVICE_MMC2:
+	case BOOT_DEVICE_MMC2_2:
+		return 1;
+	}
+
+	return -ENODEV;
+}
+
+static int qb_mmc_find_device(struct mmc **mmcp, int mmc_dev)
+{
+	int ret;
+
+	ret = mmc_init_device(mmc_dev);
+	if (ret)
+		return ret;
+
+	*mmcp = find_mmc_device(mmc_dev);
+
+	return *mmcp ? 0 : -ENODEV;
+}
+
+static int qb_mmc(int dev, bool save)
+{
+	struct mmc *mmc;
+	int ret = 0, mmc_dev;
+	bool has_hw_part;
+	u8 orig_part, part;
+	u32 offset;
+	void *buf;
+
+	if (!(CONFIG_IS_ENABLED(DM_MMC) && CONFIG_IS_ENABLED(MMC_WRITE))) {
+		printf("Please enable MMC and MMC_WRITE.\n");
+		return -EOPNOTSUPP;
+	}
+
+	mmc_dev = qb_mmc_get_device_index(dev);
+	if (mmc_dev < 0)
+		return mmc_dev;
+
+	ret = qb_mmc_find_device(&mmc, mmc_dev);
+	if (ret) {
+		printf("MMC %d not found.\n", mmc_dev);
+		return ret;
+	}
+
+	ret = mmc_init(mmc);
+	if (ret)
+		return ret;
+
+	has_hw_part = !IS_SD(mmc) && mmc->part_config != MMCPART_NOAVAILABLE;
+
+	if (has_hw_part) {
+		orig_part = mmc_get_blk_desc(mmc)->hwpart;
+		part = EXT_CSD_EXTRACT_BOOT_PART(mmc->part_config);
+
+		/* Select the partition */
+		ret = mmc_switch_part(mmc, part);
+		if (ret)
+			return ret;
+	}
+
+	ret = get_qbdata_offset(mmc, MMC_DEV, &offset);
+	if (ret)
+		return ret;
+
+	if (save) {
+		/* QB data is stored in DDR -> can use it as buf */
+		buf = (void *)CONFIG_QB_SAVED_STATE_BASE;
+		ret = blk_dwrite(mmc_get_blk_desc(mmc),
+				 offset / mmc->write_bl_len,
+				 QB_STATE_LOAD_SIZE / mmc->write_bl_len,
+				 (const void *)buf);
+	} else {
+		/* erase */
+		ret = blk_derase(mmc_get_blk_desc(mmc),
+				 offset / mmc->write_bl_len,
+				 QB_STATE_LOAD_SIZE / mmc->write_bl_len);
+	}
+
+	if (!ret)
+		return -EIO;
+
+	if (!has_hw_part)
+		return 0;
+
+	/* Return to original partition */
+	return mmc_switch_part(mmc, orig_part);
+}
+
+static int qb_spi_find_device(struct spi_flash **dev)
+{
+	int ret;
+	struct udevice *udev;
+
+	ret = uclass_first_device_err(UCLASS_SPI_FLASH, &udev);
+
+	if (ret)
+		return ret;
+
+	*dev = dev_get_uclass_priv(udev);
+
+	return *dev ? 0 : -ENODEV;
+}
+
+static int qb_spi(int dev, bool save)
+{
+	int ret = 0;
+	u32 offset;
+	void *buf;
+	struct spi_flash *flash;
+
+	if (!CONFIG_IS_ENABLED(SPI)) {
+		printf("Please enable SPI.\n");
+		return -EOPNOTSUPP;
+	}
+
+	ret = qb_spi_find_device(&flash);
+	if (ret) {
+		printf("SPI flash not found.\n");
+		return -ENODEV;
+	}
+
+	ret = get_qbdata_offset(flash, QSPI_DEV, &offset);
+	if (ret)
+		return ret;
+
+	ret = spi_flash_erase(flash, offset,
+			      QB_STATE_LOAD_SIZE);
+
+	if (ret)
+		return ret;
+
+	if (!save)
+		return 0;
+
+	/* QB data is stored in DDR -> can use it as buf */
+	buf = (void *)CONFIG_QB_SAVED_STATE_BASE;
+	ret = spi_flash_write(flash, offset,
+			      QB_STATE_LOAD_SIZE, buf);
+
+	return ret;
+}
+
+int qb(int qb_dev, bool save)
+{
+	int ret = -EINVAL;
+
+	if (save && !qb_check())
+		return ret;
+
+	switch (qb_dev) {
+	case BOOT_DEVICE_MMC1:
+	case BOOT_DEVICE_MMC2:
+	case BOOT_DEVICE_MMC2_2:
+		ret = qb_mmc(qb_dev, save);
+		break;
+	case BOOT_DEVICE_SPI:
+		ret = qb_spi(qb_dev, save);
+		break;
+	default:
+		printf("Unsupported quickboot device\n");
+		break;
+	}
+
+	if (ret)
+		return ret;
+
+	if (!save)
+		return 0;
+
+	/**
+	 * invalidate qb_state mem so that at next boot
+	 * the check function will fail and save won't happen
+	 */
+	memset((void *)CONFIG_QB_SAVED_STATE_BASE, 0, sizeof(struct ddrphy_qb_state));
+
+	return 0;
+}
+
+void spl_qb_save(void)
+{
+	int dev = spl_boot_device();
+
+	/* Save QB data on current boot device */
+	if (qb(dev, true))
+		printf("QB save failed\n");
+}
diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index fbee435786c..86570e763d7 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -310,6 +310,13 @@ static struct mm_region imx9_mem_map[] = {
 		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
 			 PTE_BLOCK_NON_SHARE |
 			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* QB data */
+		.virt = CONFIG_QB_SAVED_STATE_BASE,
+		.phys = CONFIG_QB_SAVED_STATE_BASE,
+		.size = 0x200000UL,	/* 2M */
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_OUTER_SHARE
 	}, {
 		/* empty entry to split table entry 5 if needed when TEEs are used */
 		0,
diff --git a/drivers/ddr/imx/imx9/Kconfig b/drivers/ddr/imx/imx9/Kconfig
index 0a45340ffb6..de1f59bfaf5 100644
--- a/drivers/ddr/imx/imx9/Kconfig
+++ b/drivers/ddr/imx/imx9/Kconfig
@@ -29,4 +29,11 @@ config SAVED_DRAM_TIMING_BASE
 	  info into memory for low power use.
 	default 0x2051C000
 
+config QB_SAVED_STATE_BASE
+	hex "Define the base address for saved QuickBoot state"
+	default 0x8fe00000
+	help
+	  Once DRAM is trained, the resulted training info is
+	  saved into memory in order to be reachable from U-Boot.
+
 endmenu
-- 
2.43.0

