Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC670CE7D12
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 12:05:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4920891A3;
	Tue,  1 Oct 2024 14:04:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Rda/ipFs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E06A88E6C; Tue,  1 Oct 2024 14:04:44 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A223891B0
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 14:04:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K0iLQF7C27FUmEtY0YczaCshgXa7ghjvCVCbivW3NfM/y/G65ifBYeiOiZFTUIUFY5P5tOTOfAM+x1UkWv23JlJKQOKdo215BFo9DxhDZbZxYOgff/6H3uvu7UTJyI7WvGTlsdpSg6d7VYWQz6CLD9RePH+vx2htxhg/wVyVo4OeOb+4mLnoOoUwAAmRl6mBDBqU6HyGDXGJexDZq3hskPtzVr1BPYNJL5FjLfCFPwvpVMM60rbucBpnwPrhLTQ4XV6Qo9uRLczQfH6MdBajL+CNypVE9L0BchynO1vr7yTyqFIO27TixEVfZVgLOpCoou0oeUjYB9FomWiT9JjTQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mubpaebA6DzpoF/grBZ8tGrkq6I+TKtWKsoIzMiDEFY=;
 b=wwC/srl9x8Q22yuI2MfO7blbUcRgUVQtbBg3A2Ar0CjmSriLdpEZzYkDqrQklUZObYUE+LANGFXpxUY7S0cfkuws4WtfoDaF3gA66C3WwXXCEAvhJZgk8tkNa3iP6PC+H/rUzOOXOyJqQejo7tR7X8cX5GDDhJCIYZ8kUQ4jTJ9gJ+gdsk6gMQO10fHM4CutjKrulfQzp8Nq1hcF/b9pXh/hYMb7QTAcoc0YBcNMz4Nk4rnR7yR3IuF8YmAhkHXpHCWQgv7BBXfF8fFG688JkSAOq4gvVWZNUXvDT+VVASnBXB6lkvNIaqsJfKvI66nFj+7fZO48w5ZxDCwQqWtN9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mubpaebA6DzpoF/grBZ8tGrkq6I+TKtWKsoIzMiDEFY=;
 b=Rda/ipFs4/WgvSPsvMi9kahSx1QN9jvCMZezN0i00wNIcu1g4cyFEhw5MC6MNAUWCVjQ4g2YM4UFUxio1/VY06lHu/N9Y2ipUrHuKiZKuVEUIiPGv8p6SEy0RAxwTeVwlr6nKk75cKzPmt7H+OaGFEudlQNYwwQhJ8liJASPEjn5d6atQAfVBbkUEjiBMv/sL2Zl1/YHXfHVyI6Flt7P80MY7XTORKxViCNdSiqhOoPLuEWfZ5Ze3VqOro1mpZilhEinWus53+zAQ9rUNPu19P9mTRn8HTc67Dk47L9ghI3qmXwb0tyUv+gy85OzHXpP/dLZKsUT5/yKmkI9+/ZsKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB8533.eurprd04.prod.outlook.com (2603:10a6:10:2d4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 1 Oct
 2024 12:04:39 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Tue, 1 Oct 2024
 12:04:39 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com, sbabic@denx.de, u-boot@lists.denx.de,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>
Cc: uboot-imx@nxp.com,
	Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH V2 5/5] mmc: fsl_esdhc_imx: Reset tuning logic
Date: Tue,  1 Oct 2024 21:07:57 +0800
Message-Id: <20241001130758.9810-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241001130758.9810-1-peng.fan@oss.nxp.com>
References: <20241001130758.9810-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:196::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU2PR04MB8533:EE_
X-MS-Office365-Filtering-Correlation-Id: 31668494-9199-4e0a-f422-08dce21139fb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|366016|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xpatpsBGVG9B5Kfi7WDKrbapWYOpSnfsMDUiHOZlmlh026bleKgObDDgNj+A?=
 =?us-ascii?Q?Jp4hWl11u2rMgAyc5wQByv83y4uKb0iDOHAeO/2mhH8jB5/J0wtZAa+8BsHS?=
 =?us-ascii?Q?352M/3Um2/cvAy68x7sLX1zw/7IaXqE8/mVKxXtRtSGik9mYyGjVYDUzuXNl?=
 =?us-ascii?Q?J4HhtAgsSf3y4RVRdBVZoJRNhqz85HxRWA5qBEvCX2jeHJiPUXU7R7TmMFb/?=
 =?us-ascii?Q?w31b3yN79n2ZaDpzqGMEVp/B49ANEq7Ea/hAEOVc6NxwHyGlkHkfZG5riYl2?=
 =?us-ascii?Q?SLxxlaiuKe86gwONlxf8DRlW8zpA7mzYbzWRUelckRRJZ7hbjlcR8Fu1x3Cv?=
 =?us-ascii?Q?ioTSm7pEZ5t7AdKPPoTlDHxC1jVSjBajwshLY9VCsLy/KT2l1GpOtKAti8CK?=
 =?us-ascii?Q?dOLBbrmy6KrUVH1aZ/aiXZmJKfVdgePnvoIShxiAP/NKpuqOprR+QaqCGQXU?=
 =?us-ascii?Q?F+DKwUlzKY0V7p5XxBGtNgItG0T1KlQfFgAE1lnUuG/lEUzBIVnjiYjdmEvg?=
 =?us-ascii?Q?s8V6fAQDuRGmZgwiW/ki456NZCZ6i9c7lxDoNilc8rTmh5CKz465k2mbukw7?=
 =?us-ascii?Q?izHKm7R2HqGRGtbWz57M8jcDsKSRpRV4RfDwyQhcbHgEl+VqHwMjgPdOXgQw?=
 =?us-ascii?Q?SqMuNwNmEBqe03+nh9ixxE6gOGWt9+JvO97tLaK6GCOgw6b8OPSWf1ILPtmS?=
 =?us-ascii?Q?A9UzUezF3o1sM/wA99pY0va5XWzLwLbHvL75BX5pfZeub9nArWAmdqfcZdFB?=
 =?us-ascii?Q?m1mITN8dDv8S3bLLI/JOmkWvKr/xDwblaVwr8Qbrnjt/fawx0E6oB7NTYalW?=
 =?us-ascii?Q?e7C3U2krephCTgjH9nVyAFpSdjnZF1MuiPThokEIo/5kivQt1eqc2K+SqsYw?=
 =?us-ascii?Q?nfugrnhihTTu041e25W2oJphkJlQ4HzTa09uKDjtcSvhkLvrLlPky7Kwlxeh?=
 =?us-ascii?Q?im1dGedl43zpNJBIP3+mGNMTwQmmtIAyw9WsAeZQeWC3D4RxdOSYz1XSR7RS?=
 =?us-ascii?Q?vYh06A7BVM++s6MoY7BD/6QjOeWGeFs7aT7frfbCjL6bs8k3ZdWEcFxRt85w?=
 =?us-ascii?Q?3cEXqTfjf0t7ImHDMiG66NuY0Ld2J+dy1vyfzvIBwxgszQrYqXBbYFqrxAjM?=
 =?us-ascii?Q?9E/MWv9Y0lLxp4wVsmPKvdORkuhPTJwZSmKJJf/995E2dIZHnVnMb8//5rnm?=
 =?us-ascii?Q?4+W06j+sczXAMADlyrlbP4W/slj2mbaSNZSLHmpyzLcZYkJ41ggA43NTaggZ?=
 =?us-ascii?Q?C6V6+JIiOaG3sf8b0c5eKysLmwQ9io9ACgASeu3OCSuNtCJXHlqjLaEDMU0P?=
 =?us-ascii?Q?+B/uco95eCJLz2QbIPRlQIZ04hOyamJRe9Nk4GvBEkh/pA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bDxeC2eZo9ifX4obEklWV19mYi61TjHdfnd+R6BDeZKQugrpwxfl0TczNrJX?=
 =?us-ascii?Q?bXcjYWxMtZzb4ED79oP28HIhk+aPtcpBKuLukvVoK2BJfwKDTh1lGLiPhMEh?=
 =?us-ascii?Q?ArwDH57m/AQfkrXp3WKYSFfOe4ctcURxRHvAIGYYfilHafqTVeQtdoAd2ZVY?=
 =?us-ascii?Q?mdF2oNOlZkC2PiirfkhkhGYJl5mukFqQgvHZZ48UbLAFkSE6vQ7WSo/lujOw?=
 =?us-ascii?Q?Tn2vK3meESqVxqHGEBui2AeSlLEazyQg0v4Hfb8xzi/bviVM7JRV6ENs4FOZ?=
 =?us-ascii?Q?gzS1uZY89rPGfujPRt1fwCa01gzmZfWTw/CIPSRkUBEdxvbO4wVTJunvRetQ?=
 =?us-ascii?Q?RfgqKC1KAFzagMpUS/TZMKq+DzbP6WheLVkNzmoP//AxwzbmeCViBxpvJ034?=
 =?us-ascii?Q?JAHwixBzuSRiP373o9HnhHjbXBCwnnFd6W328lX1W8kc8q4EH6iTQIXo5CTQ?=
 =?us-ascii?Q?Jx0jGYvH9EufR+TQpygBPBRUw84WSW8cYdDRXHulZybNYVrQGSYVE617JAkk?=
 =?us-ascii?Q?OcPXXrwOgc2rsKu3TakVQVYd6wea/ZfKaAwRFUMphtiAHiBN69oBvh78fVFY?=
 =?us-ascii?Q?cIlG4qNLV7bj3iQ1FTdFI2LF++fphyOlhu5SvjYt2RMEG7Ii1u4v0CAR1RcG?=
 =?us-ascii?Q?Qy8+B+1fEQW9CuhsKTO+LNrhXOMISWLDKSp6hbCq/5tYm65VXLveOPTssAmb?=
 =?us-ascii?Q?yddDr6rAnyaZeMPJ1E5ypdq1K6jMfVtUpQciJ07qo5SMDe+t2YPXqe3z/pVX?=
 =?us-ascii?Q?kmvZpK8eoG7HHy/Nhz0EzpmuZQ7PLuhxJ4sLQ30mHwRh2u+GZ5msHu0pmgWD?=
 =?us-ascii?Q?f5A1AgZM8Zjrn5cAT+deLblIeF8s4AaWWW9HuU/cz2lZE9Kxt+wzTXkVmd7f?=
 =?us-ascii?Q?vW2KL7krOAH0sLWrBML9wN7WS+24qseWbyxdmIkYjEhufYg1lZooylVnvnFO?=
 =?us-ascii?Q?5i5xNiN7OHtIBztxQE0neJGxd2K4ODRGmSmq1mxjoa83qmlVy4YP3Y7GhRUn?=
 =?us-ascii?Q?G/1TfdAtoG7OHTYyYiP6aHKX5jIJbF2LROuenY0LieXM37MzEXW3VVK6geAJ?=
 =?us-ascii?Q?m5OqYKphmPfKUAVXdNS3Fvw7nf3fklp3J2ZuG70i9GBbxA1ySo5kpbgO4t+t?=
 =?us-ascii?Q?/IKCWn43mPMqnJdstHRU7mUn9gIHbYeXOhqIGfcIEGtkAulfIXwZouRNFixU?=
 =?us-ascii?Q?KULcZ1uCaPPgtRZBohUYA3ws5CFORfAtQhFATfbQ4IIgil0xgELuSoBEFRQ2?=
 =?us-ascii?Q?bs3tGlMdvbZRi/3k8EuPjv7Nvziwap9Q2T4M8bT6Lw9g2OpJkF7h6G8J5tjj?=
 =?us-ascii?Q?MbC0f5n5gPKvSdILsCkUAtq1N9NXyFZgXhkcnOSpJMTg5MRe9QCKlYzzw/ga?=
 =?us-ascii?Q?dZDeYdU0XpWvff3Xip6hrSbtkboo/IZmaLSW/th1VWzFWBQRznCOH1BnAaqh?=
 =?us-ascii?Q?cRiEsCn9/eMr1s3ByKSrgNPMhFOuBQbB1W4+UBtzK1yjEUrkfPrQAQe5Uoiv?=
 =?us-ascii?Q?CUfejI3Pph5ahQeeip8j5VzJtAFgyplxVQIKgP7WI8kRB1RvZRJmzFjxmblT?=
 =?us-ascii?Q?CRIah8MvsbRyzqkU5VCXbPiB6YreFJZyUkHttjYQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31668494-9199-4e0a-f422-08dce21139fb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 12:04:39.6999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LPMG1M2mWRfTZGzdhWjQpP+pRBiNY/IbskrIBdohOW9TuzXT7qPbhh2/J7Quy9n/vbbMMEdSel+NRoCzu1VOjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8533
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

From: Peng Fan <peng.fan@nxp.com>

When supporting partition reset for SoC such as i.MX95 , the Linux
Kernel may have configured the tuning, while after force reset by
wdog or else, uboot CMD0 will never pass unless config RSTT to reset
tuning logic.

Since RSTA and RSTT are independent, so need both to be reseted in the
controller.

Acked-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 None

 drivers/mmc/fsl_esdhc_imx.c | 8 ++++----
 include/fsl_esdhc_imx.h     | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/fsl_esdhc_imx.c b/drivers/mmc/fsl_esdhc_imx.c
index debfc78b7f0..fb410104c1f 100644
--- a/drivers/mmc/fsl_esdhc_imx.c
+++ b/drivers/mmc/fsl_esdhc_imx.c
@@ -987,11 +987,11 @@ static int esdhc_init_common(struct fsl_esdhc_priv *priv, struct mmc *mmc)
 	ulong start;
 
 	/* Reset the entire host controller */
-	esdhc_setbits32(&regs->sysctl, SYSCTL_RSTA);
+	esdhc_setbits32(&regs->sysctl, SYSCTL_RSTA | SYSCTL_RSTT);
 
 	/* Wait until the controller is available */
 	start = get_timer(0);
-	while ((esdhc_read32(&regs->sysctl) & SYSCTL_RSTA)) {
+	while ((esdhc_read32(&regs->sysctl) & (SYSCTL_RSTA | SYSCTL_RSTT))) {
 		if (get_timer(start) > 1000)
 			return -ETIMEDOUT;
 	}
@@ -1095,11 +1095,11 @@ static int esdhc_reset(struct fsl_esdhc *regs)
 	ulong start;
 
 	/* reset the controller */
-	esdhc_setbits32(&regs->sysctl, SYSCTL_RSTA);
+	esdhc_setbits32(&regs->sysctl, SYSCTL_RSTA | SYSCTL_RSTT);
 
 	/* hardware clears the bit when it is done */
 	start = get_timer(0);
-	while ((esdhc_read32(&regs->sysctl) & SYSCTL_RSTA)) {
+	while ((esdhc_read32(&regs->sysctl) & (SYSCTL_RSTA | SYSCTL_RSTT))) {
 		if (get_timer(start) > 100) {
 			printf("MMC/SD: Reset never completed.\n");
 			return -ETIMEDOUT;
diff --git a/include/fsl_esdhc_imx.h b/include/fsl_esdhc_imx.h
index b8efd2a1664..8612b56609e 100644
--- a/include/fsl_esdhc_imx.h
+++ b/include/fsl_esdhc_imx.h
@@ -31,6 +31,7 @@
 #define SYSCTL_RSTA		0x01000000
 #define SYSCTL_RSTC		0x02000000
 #define SYSCTL_RSTD		0x04000000
+#define SYSCTL_RSTT		0x10000000
 
 #define VENDORSPEC_CKEN		0x00004000
 #define VENDORSPEC_PEREN	0x00002000
-- 
2.35.3

