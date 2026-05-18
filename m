Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA2CCD4F3D
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 01:13:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87A2E846A4;
	Mon, 18 May 2026 03:13:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Yi+yp711";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DBAA846C6; Mon, 18 May 2026 03:13:25 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5419B83AA9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 03:13:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bR36DAj6hRISv7gftapNt91gTaNA29Gnqc9MVgsa+QMa14Ud3Oncgo2/brotooFJJNMwB6Mg76xoIP0Wr8gqIpj4/57YvrMEnKhxdT8ziG8kioUZf7tQkRWPd0mwEqSJGkaS9IMNPylkHDmXqa7a8D8rFkjwtVlWShVCm1gQv5oZyIG5ChlTn09RSib5NoJBa3dm/Fq/BNBlxIunmb51DQvTJXcdIRWufm3hEC1jam+tUxt9VziTZqm/EpdHefzUFVy4RGMoQKxEIKdpafUKZCzWchoJp4kiK1oGtwIeJnC6N0uYgCmH5Y51ebWQ82fjtcZyZGiw0BmIRSVQt+vmlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOh5R+ZIMbCiawcio+iagJODd7E2l7uCvOQ6PLralgU=;
 b=TLCm8gw40FHA4isIUNZmJxB/4U6rxhNh8MzVOykoorgCngBTQjOiXu43bzO2ymmcYBB8L1aAdfJJaOElyF3FndNRftYV+Njwu3tXkel51QovFQb8JONHozVOQCaCaE8JINk8oDFlBGKDg2UDj/W/ORRbR+QzwXN61llmUYsoIDiVPdMJPTkuEYlLnKOQBiTWXOqa9wBG8rckYb17jvMYMUeM+Va+zVuv3YwVOOHYhIgrgQNZj2RSOVuY1vsYXpln4wnPzEUL5MzCJY8vYzup0wwMVndV7jNMERToQjUKLcC8D6m+RgvCOJK9CjyKjKraDrZR4tyeMx0NNYXmUTLDnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOh5R+ZIMbCiawcio+iagJODd7E2l7uCvOQ6PLralgU=;
 b=Yi+yp711E4PMDyF4GBUmexAKhPycq2y+LmJItxBjB4ZPDTeBtY0WcN6+8wrcdvX8upyyDgfnDbN2fRu88psEE0XL8k+mHqWJvDBZR5IJ7iNYUx5qPNBnbY4tncNZWW6s0KqbcVtvEwoKmTjh+Ad8Cx1Qu6ejZun8tafDMPcZZREJbNrPEUph1kx9d9UiRqW4p3U/n1+B/8edXPAgAW5Gkcre/7yV6gcStNek3Ub5UqPt1ag8biDOzTJ1TlCnj+C47bswolw6BfZiwoDqkCo0OMaK2TSUav/8KmixUY9aSsmjsGKkCxvz7JuryQYWub7oR9CmcArbkwoEzSfJK2MZ5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SJ0PR03MB6928.namprd03.prod.outlook.com (2603:10b6:a03:43e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 01:13:20 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 01:13:20 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v3 6/9] ddr: altera: soc64: Add secure region support for ATF
 flow
Date: Mon, 18 May 2026 09:12:42 +0800
Message-ID: <20260518011245.19083-7-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260518011245.19083-1-alif.zakuan.yuslaimi@altera.com>
References: <20260518011245.19083-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0181.namprd05.prod.outlook.com
 (2603:10b6:a03:330::6) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SJ0PR03MB6928:EE_
X-MS-Office365-Filtering-Correlation-Id: 8056d353-d248-4cb3-50a4-08deb47aa635
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|55112099003|11063799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6IPZ7t0KZvlf113S3OA5XnE+vhXlqzjHfLA2GFsxo/m1sDyk0QGRai2+xVWrA/IrZDkUoszJcoHxfhHAD3d7AUNznjXQtBIZxut7b7fhuZvaUskCEP6i8hGYS6BkV3bh1V3sGG1Kvrd956WZrxTMpip1plZ/Xtp9dncihKei6l/AriKgwLR/7Ep3RCDg2v4wTaQfVSOZy70EBndV9ASeeS+w5i7ffvAG1YkFUuJQIAMoTQjwgC2Jbwk+xeFzfDfZjaNnpBOeDkktfuFRzFQXCwJLrBWZRQaS0GnYxQUCboxiPCAaIPcpeInAo7JlodexCmEfh83t5CYRRv89MMWwiRcYqwRAOOrVrkpwh6BL2XjXPk6BkrKKJ1fM5/ynros6YG+LiRGGmDNpd+76xUAYBssKP9437Xwo9UYMiRCQOsk1IXcHfTGtFqB41FBDae9qKSMk1m1rzXVN8iBZEtaYsSrzMuGa8P5zZCINUfY+z9rokDv5npQgxEgLOoxyW1M+MV8CzVPHrRYUAB2HFHkrP0b1bHu0iNsKb1iDCLWuVbvSIAvV2KUO51BMA6o0ge/9TU/DNuzpm2ue66Jb5Uk/xF9oaasJRsXtETVVN/Db5DrI2oZD4xPAn8nzqlDO8nzuycQQbsGzIa+h55Ezq1wBOIJ+RnDi2a7+1YmMDFlwHP6vqPaXWaMnLJ9HGR51ImWp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(55112099003)(11063799003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zWW/zjit8MRUy5bDu30sHMgAebtrKdRn4b/TZB7wMy0rO06+QaXVsbH2a2bl?=
 =?us-ascii?Q?M4+8RPSnEOKmtQnwTRedffynde4prN4NGvuSU/mct065SdJcrvRjoJ5JsyKJ?=
 =?us-ascii?Q?8ajH6PK5Sg23H2uoluXFo2GXwxsclXXzRk7H7Y9Pu6l7sSJ9nV7VVWqCHPhp?=
 =?us-ascii?Q?vPWgxwKmA8wCLCN9ueGToU4XVfj31Mk0QcP86Zf/rMFfqkwUnDD1qr9z5Q+X?=
 =?us-ascii?Q?toBdKu/eHfH1MDOlrVyu6KJTFZ/dRDrMU+jE1HER1xQjXC80fIixCsBwo0/O?=
 =?us-ascii?Q?FectsZdjHbZszc0RZdf4j1AmGCF9DlUM3Z20wlxQcPw9Tfk/zm3w9XwR2RZA?=
 =?us-ascii?Q?jdIrB6a4YOkOU8lid88qfiVDOUnYPX64BJjvB/T4Su8a9Y/2Q3BMp7tiCjFD?=
 =?us-ascii?Q?T6kwr/aSovhQ4SLNtoT/JIPPSZzVgaE162giOKas1c9Vy1MY9mQC/AFjyYTh?=
 =?us-ascii?Q?ugCYaz0Tc1m/O724rLFhEaWMW+Y7AIzbbgMJ0MI51heTbUD6yTHzlwWs2wiK?=
 =?us-ascii?Q?v5exms8iMZAfRfQQ7fs0KIv5DiKYiAXq7EI9fLcp4IIC1O3hOWsK8cFcJLO0?=
 =?us-ascii?Q?6klY9FI1YMaTd+6UhCp3kmF5WCUOdjV/Otd8+1ExgDBFQUlMM4imytxmHyuP?=
 =?us-ascii?Q?tFZd0QFMGiYWP2COxtLA1EVxADKqrHta10AIz/5/wXlEkHdBcDLzrqBdPtqe?=
 =?us-ascii?Q?mO4Fo9z1lDxGmC9Iq9Bz1L//gHJZe0aljg01+LUyXY3MbwO33Cww013DY9wK?=
 =?us-ascii?Q?xUqdfkU79oYcbM1jpwSibFKvM1oLjKG8eOjqrWe2yUjJO3G8shYQ0rPThdFt?=
 =?us-ascii?Q?3tj5eWnftNKILQznLXRXgLEusqIUooEbbFPgj64giPutaKEQiuuaPIRQoZ/u?=
 =?us-ascii?Q?cOPBA4WGiwH4LcVpNXF2165iWrdwv59X9iV6YfeW8nb13WMX0Aa+RDoAzf+L?=
 =?us-ascii?Q?yW3lY/SelDVJ5sd55iW/oXtfKYkDX8GwgYx5yJT/g/F4vX1KA58jM3xdd1xH?=
 =?us-ascii?Q?IzYWO02uUEk+1sGyDGsJhBznYuOBMIb2fthbxnLIqRheF+G6BpUNadvQKR47?=
 =?us-ascii?Q?QErYwH00FAiWmd00dUxSvnUFkzKndAP83176WyYi4hlZ87dNdnYfcS+r8EGq?=
 =?us-ascii?Q?vWOcpNAGHnf+dUrq2lw8+zlNks3HSqL10B5ZCr1/hC3MW3TvPxa6RX+0ciiW?=
 =?us-ascii?Q?pCYGkFOecK5mtYhkcVjF81nEnNow+CdgdyLD25S7a4UHO2FA7xDSEVp7bJFr?=
 =?us-ascii?Q?KXKzZOY6h15rKIPEWzXg4WLJPTBbqE/ZSv51s9YP2kW5mf9Kio8VjRV5pa3n?=
 =?us-ascii?Q?PGoLqPUGTRD69YmAN0Wp7LkIHPWbnh3ldJjkwMXg6nllzYCpiBOpOkUU4Tkb?=
 =?us-ascii?Q?lQyR9RCBHS68xtBNJCvZlcKC4haOInz2Q3P919NHQyk2Vxuoe8lUGQJD2vZn?=
 =?us-ascii?Q?I3TJMtJNPs9uEEKUftSCEGZBXofljJWJX4I9NHqT8msqP/95b1mDByWMvRIX?=
 =?us-ascii?Q?VjjvL1mMw5hg7bfr5HCp0e5BdkjqosUfBjegYElj2pnMFhrWnNvH452Iy+ZK?=
 =?us-ascii?Q?ewt1sRahVrW19Cf62gTSRwFG0ja2aQu7HBcW5sUhDRhjVBdEyD23LDYwRW/F?=
 =?us-ascii?Q?piPBBwQR/aBgqbCPfLB1zBXhA/XaMkyWF1Vggy2uw2OcIZQc+I1duGcakW8Y?=
 =?us-ascii?Q?b4++IERAyW6/ANFDRVgojeRBo4/66jvexoYVf0pDSXLallbFSis+EbuwzUQK?=
 =?us-ascii?Q?yxeCyNFpPs8J8zFTq1H0V11LEf9T05s=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8056d353-d248-4cb3-50a4-08deb47aa635
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 01:13:20.3992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sFYEDtS5NWMVVa1SCb85u3Znp15EVZBiZygycb8jU38Ar+2pcOUq7ZeCKEWmZUkjphoORegUdYoEor9MBgMxN1G3Md18i4yfZboaisxE3zg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6928
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

Setting up firewall regions based on SDRAM memory banks configuration
(up to CONFIG_NR_DRAM_BANKS banks) instead of using whole address space.

First 1 MiB (0 to 0xfffff) of SDRAM is configured as secure region,
other address spaces are non-secure regions. The ARM Trusted Firmware (ATF)
image is located in this first 1 MiB memory region. So, this can prevent
software executing at non-secure state EL0-EL2 and non-secure masters
access to secure region.

Add common function for firewall setup and reuse for all SoC64 devices.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---

(no changes since v1)

 drivers/ddr/altera/sdram_s10.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/ddr/altera/sdram_s10.c b/drivers/ddr/altera/sdram_s10.c
index 1497a8e4aab..aed53ae58eb 100644
--- a/drivers/ddr/altera/sdram_s10.c
+++ b/drivers/ddr/altera/sdram_s10.c
@@ -78,20 +78,6 @@ int sdram_mmr_init_full(struct udevice *dev)
 	phys_size_t hw_size;
 	struct bd_info bd = {0};
 
-	/* this enables nonsecure access to DDR */
-	/* mpuregion0addr_limit */
-	FW_MPU_DDR_SCR_WRITEL(0xFFFF0000, FW_MPU_DDR_SCR_MPUREGION0ADDR_LIMIT);
-	FW_MPU_DDR_SCR_WRITEL(0x1F, FW_MPU_DDR_SCR_MPUREGION0ADDR_LIMITEXT);
-
-	/* nonmpuregion0addr_limit */
-	FW_MPU_DDR_SCR_WRITEL(0xFFFF0000,
-			      FW_MPU_DDR_SCR_NONMPUREGION0ADDR_LIMIT);
-	FW_MPU_DDR_SCR_WRITEL(0x1F, FW_MPU_DDR_SCR_NONMPUREGION0ADDR_LIMITEXT);
-
-	/* Enable mpuregion0enable and nonmpuregion0enable */
-	FW_MPU_DDR_SCR_WRITEL(MPUREGION0_ENABLE | NONMPUREGION0_ENABLE,
-			      FW_MPU_DDR_SCR_EN_SET);
-
 	/* Ensure HMC clock is running */
 	if (poll_hmc_clock_status()) {
 		puts("DDR: Error as HMC clock not running\n");
@@ -284,6 +270,8 @@ int sdram_mmr_init_full(struct udevice *dev)
 
 	sdram_size_check(&bd);
 
+	sdram_set_firewall(&bd);
+
 	priv->info.base = bd.bi_dram[0].start;
 	priv->info.size = gd->ram_size;
 
-- 
2.43.7

