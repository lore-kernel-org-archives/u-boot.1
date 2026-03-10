Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F43EFD2D74
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 13:15:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73033840CB;
	Tue, 10 Mar 2026 14:12:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="pUPzUBey";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB04783981; Tue, 10 Mar 2026 12:44:07 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7655983FA7
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 12:44:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YIEbXcoraPYxeUFWDvNhBCMH7oP5KcizH2b/O6tAh8DvVkAwtmlmMSC8TgtAHrsnOkDG8Bc6lC5moj9FH4daLpU5UB4RHcFtO1j0sqISSlmXQG9py6QcH3dVea3FljV5K+Y4xRDfI3jsDMy0couchHkZs4FG4fwxp6iIrMR3QVkhR2rh3pIrhwhdOqeG+yJoIQRDKbFDtZft0l04DsGKu2d+MPsXz9qsypIfmWIlWEoIT4dCTTs8nL+e9EyzRFZh+loVfzKlPfiL4aRA9c9FkL7/qCbFK7FfPIvUoZ6bW5cyVgb+YT4IuEbAu8vWCMQrIhxZyMY8MzUVz9Se4xzFDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwW9GhVU1kxIMFyYfqoaOvh7ENXWMW9yltMKSwFnrj0=;
 b=inUQeyJdeeOgky6HY6yurM6KEDJTwR7+wB4uaaJRZbB16bVxYJTQw9uxw+l03ldbhUs6GOOYK7TTaQuHOzdgTp5FRDJSICF+qRj1wFCcHvm6N1WoNL/pXJKCd3mFgYX1zoR05Rronq2L867/TtLtFwO2xop+LU58seE4DDJakWY7la8bZb2re1oTfPEgEe0L5Xjl9n1vJtKb+Eu54QL3vtz5nAlUkeZflkK3FZkUhDOAAmLxryRap/GJcjTfXElkD5RPXBNwhSX4WmiyjogAkqzgNQoFL2xPAFHGinli9VsZb0fDepSwqlUgABTugQrd+GhsFOPHgAzYC6x6HqKPHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwW9GhVU1kxIMFyYfqoaOvh7ENXWMW9yltMKSwFnrj0=;
 b=pUPzUBeyyNS7imRM7reE8fB5H3Pcuna3T0BsY976mctryTo4T/YF62pElPiey0Eh9jcUAxcytcZj33yDJibHNOPSoCSfAAJKfu8vJF+HQIdMJr6GCiuBuyXqyBV3YtHHbDpVTvyLtRzwVCV8lhZ79p9o4AjeYTr+nFne5d3e2tozFcLptsePoCCGYuoxMY2X4ClkLYXEpRu+yVxqCsHAVX5or/QCca4wdxmBNEX+5WgjxhKkj5pRyGfrPxfzZGhiyHVO+xwdmIk9TIS/w/08E41YAe9+nwo5/aj/PLI4D3iSqPnVyktvx8+jMtQaAoHeN9IB4TcP2IKgeLNU1yn3Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com (2603:10a6:800:306::9)
 by MRWPR04MB11998.eurprd04.prod.outlook.com (2603:10a6:501:96::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.22; Tue, 10 Mar
 2026 11:44:02 +0000
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7]) by VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7%4]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 11:44:02 +0000
From: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>
To: uboot-imx@nxp.com,
	u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, ye.li@nxp.com, simona.toaca@nxp.com,
 viorel.suman@nxp.com, marex@nabladev.com, ravi@prevas.dk,
 fedor.ross@ifm.com, sebastien.szymanski@armadeus.com,
 joao.goncalves@toradex.com, ji.luo@nxp.com, semen.protsenko@linaro.org,
 sjg@chromium.org, tharvey@gateworks.com, ping.bai@nxp.com,
 qijian.guo@nxp.com
Subject: [PATCH 1/5] imx9: Add support for saving DDR training data to NVM
Date: Tue, 10 Mar 2026 13:54:20 +0200
Message-ID: <42e5a0cc026ff2dce9163c18bb9dc744d9a6b7ea.1773137310.git.simona.toaca@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773137310.git.simona.toaca@nxp.com>
References: <cover.1773137310.git.simona.toaca@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0002.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::7) To VI0PR04MB11917.eurprd04.prod.outlook.com
 (2603:10a6:800:306::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11917:EE_|MRWPR04MB11998:EE_
X-MS-Office365-Filtering-Correlation-Id: a77082fb-b481-498c-0260-08de7e9a5340
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|376014|7416014; 
X-Microsoft-Antispam-Message-Info: DFqnp/GzfiHHaNTT0vsmSr58EindbnqIRx2yVn6jXTloo3dC4xRwOfp71f7ZbUA0PbOEbA3y1Y28mZLbUCrsGUzy9I4TEPajVZyw+RpJKRKpDeFbFgGLL7LhKOcYpbAzMSf2TKkF7IkTtmR/0+c8xdCqlojOXKjv3T37q9ug6F7+Cu+w1t1Cfucip8y/hbOiLawVov9Ks4ngmKg8LCcbCPvi01kfuj+Od8Bx/Hx2C1/aIEeuhObmflfG2vOp/QF9erWjNwUPM3MtSPwZE+B70NoByyYw4j/WnJrovntDSZqp9OneNWcM9pfJZIHYBPZ71k/f0lYn4V5gcWON3Chi2GD77q9r+Lx6ygDJgW0tZYNPSdmUa+1mUq9oKfYH85HGss7rDCciOi5YAKtEppGIsZ3GtED65bf8sv6QR7OMTOKGtuaZASKaqrrJuGT8XnUSmpQa+fi4P0JTf7jOH/GK7i8btHvFPNusAWtFAuabmRmqSSkvyqTgshbLR7KlTfbF4kWm8tRDhrLWw/42OZM1fnPRlSyhS/3CAjaaBib8Zo95CVcnXosECSbQmrqJGnt4I0EefjM3GoqBxrlcXQTlfhFhTmGox/g/6PyhFDwnT9O6ZDiofo82cJ04ULbyuLTyZHSXhZsyhwz2YgZnsUD+vGXX+fj+hq0Rf4V0uSQcv+XGyl5frJsemS+4OaEDhohZtXworHsyFcItLMWY1NBuYopvOf3EIvYLWLlLcW7dkf4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB11917.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6ueLuqNr3M74dK+2G1YACGig2fE2YCalTA417UopWYurqleX8PQpngBHKVae?=
 =?us-ascii?Q?IlvoZzZ/83jFDsgp6q8YTuz50WfJEgq6fkovqK54XUo2meFtpPP71yMaqry9?=
 =?us-ascii?Q?FurtpzQrcSbHQTdmSOR0JuFZn9VIoxlvmftMakKXjX5biTqhM6HbHcMjd7uj?=
 =?us-ascii?Q?xhQFO0q3CSFukqKaRnZFTBQg0pkz9o7BEqYoWroAN/nolbaQVXFlogcY3kTr?=
 =?us-ascii?Q?C9GMMwChRYkNiNTm8qfGRh9rOSHC7kYJ7yWnfff748F7dhbjZcNPANHnsUA5?=
 =?us-ascii?Q?ZuM3NK/1BYhD69huZrs1SzWDXDuKgnTiM7Cu6pzQy2cJKGIcmu054ykKKgzW?=
 =?us-ascii?Q?agjxKGCPNuO40CEBEuHoSA7R/kuP56JXz7asN+EQsQPAAhOgkQykHTpk7vb8?=
 =?us-ascii?Q?grjLMG6tIJKU+8Pj0ETNyzfMK/qwZ3v6uz5QCsFX064V/zDg7k4i0GjWOPpe?=
 =?us-ascii?Q?DYSSwWx31NIvvs4hsTU/ef0ZTI0DhjM+Xoiox0Ge4CyTGsC5/eAHeyY8Zl6G?=
 =?us-ascii?Q?R0gHz3GtQvWWOYVJZM6bWvyPnHyrkYkZYCnhtnVKp4/TQWMBKrH9DX8nLR/f?=
 =?us-ascii?Q?Ix+6kV3n1WfKzlaso10CDjXdFyD7Yu9/XzGdBDf+Si+dHlm93F6zCPQNxwEE?=
 =?us-ascii?Q?CDdOENXXrVJfZUIk/kDA7sNWtq705gMkgMU2QF2fNzJGVImm8b6b8+6nQ5EQ?=
 =?us-ascii?Q?J1nmMcKxC2LiTO0yxeNXTDyXNakCdcJnzyUQJxptkr5EwYpfUef3c4V9Nsuv?=
 =?us-ascii?Q?MpTXttfWMwHqCS60NVfAIzqaiLwYDAQdbXavk1wm2jSVZ7B+DCbQx2rPFWVS?=
 =?us-ascii?Q?kpMJHUdt0e1z6eoKPS6+7YW8x5HPt8ScVaP/xaWeIqKx75umY0XzmS9wyQJI?=
 =?us-ascii?Q?GX8s//YqqfsD1xIQuhhCkB17psOoy8ROB+7Z1hUEAqfkL/cXQ6IX7VJ/rORL?=
 =?us-ascii?Q?XlDbCu0toCZiyfrwJAwlpzhgm2AuVv8xlIhatBOSq3oKL1B2HjjGqsPEWN9R?=
 =?us-ascii?Q?doFBKF7cXLHTkm+rriiTnuls1FwF1nxpxubTcsXv8GmIPUh6MhG2XyEtbEnq?=
 =?us-ascii?Q?elrOGXR361X3JSJaWyDiRzHa0g2s9DclBjH9PHwHscwt9jZ6JfjF2cDrhXtb?=
 =?us-ascii?Q?BTP3VFLMW0vVc49NT7aV5M10OQkudxja3LjsOnBxlxW25ZA6Z0ahh3/vqSWX?=
 =?us-ascii?Q?hOaidD6TZqDyxkzw+OJ92tZoGqeQjPmsBOMWxHvKo8wKNKpaS8tfMlMIPusl?=
 =?us-ascii?Q?uuO8rqOfosC9vil2Hxm30vIKjmDzHvzLsKWRv1IMwvqLYAL9uwrh36V8iGlM?=
 =?us-ascii?Q?XsWfXdGbwcShWtvbIp2x18XgM2Iijcd/8HPgKvsndT6rk8eqiRNzN9sm3oUG?=
 =?us-ascii?Q?BNH4oOBI7q+B2vIYHdRNzHLaYlL+DiPLU0vZfxbQ2HH3tQ/nfK/r4+o+DDZc?=
 =?us-ascii?Q?dgHa7rrem3KeJGNQCxxEaTNYNkYysk4QVAc1I6oolfAe9Zn1OFiRrCdM2OSs?=
 =?us-ascii?Q?CTbNPr82LTcGKP6LyVhudj4fw3eKqzVjxtz7Ig/Kmkj0MQowk5X4V1HVrzWj?=
 =?us-ascii?Q?eZBsz+Zngx2stA56ymMrNd/L8PVQ3MjhfQ5hsUVt1oNRrTGjjnGWsluOfImO?=
 =?us-ascii?Q?294kk5O8nVi4nMnlh9jEsztkE4aC+J7xVDir+AJNw7aw9s7R2sr1w8Hn4Gnh?=
 =?us-ascii?Q?EfKW62cdqqL58dWJuseKVbmHl+ChivWkvlpD5zRloGnYdABN0rKMzA+XxtdD?=
 =?us-ascii?Q?WFUDTOBaIg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a77082fb-b481-498c-0260-08de7e9a5340
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11917.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 11:44:02.1514 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pTZIRI82oVGLo0TaIcgB1Xbxozr1r2QllwMdVohJyDdfyaA98tYvyP0KJnUtpwEE/V5JEBF4W/a6xGA7UulFMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11998
X-Mailman-Approved-At: Tue, 10 Mar 2026 14:12:35 +0100
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

Supported platforms: iMX94, iMX95
Supported storage types: eMMC, SD, SPI flash.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Simona Toaca <simona.toaca@nxp.com>
---
 arch/arm/include/asm/arch-imx9/ddr.h |  52 +++-
 arch/arm/include/asm/mach-imx/qb.h   |  13 +
 arch/arm/mach-imx/imx9/Makefile      |   8 +-
 arch/arm/mach-imx/imx9/qb.c          | 430 +++++++++++++++++++++++++++
 arch/arm/mach-imx/imx9/scmi/soc.c    |   9 +
 drivers/ddr/imx/imx9/Kconfig         |   8 +
 drivers/ddr/imx/phy/Kconfig          |   7 +
 7 files changed, 524 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/include/asm/mach-imx/qb.h
 create mode 100644 arch/arm/mach-imx/imx9/qb.c

diff --git a/arch/arm/include/asm/arch-imx9/ddr.h b/arch/arm/include/asm/arch-imx9/ddr.h
index a8e3f7354c7..a0eea6852d2 100644
--- a/arch/arm/include/asm/arch-imx9/ddr.h
+++ b/arch/arm/include/asm/arch-imx9/ddr.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Copyright 2022 NXP
+ * Copyright 2022-2025 NXP
  */
 
 #ifndef __ASM_ARCH_IMX8M_DDR_H
@@ -100,6 +100,56 @@ struct dram_timing_info {
 
 extern struct dram_timing_info dram_timing;
 
+#if IS_ENABLED(CONFIG_IMX95) || IS_ENABLED(CONFIG_IMX94) /* CONFIG_IMX95 || CONFIG_IMX94 */
+#if IS_ENABLED(CONFIG_IMX_SNPS_DDR_PHY_QB_GEN)
+/* Quick Boot related */
+#define DDRPHY_QB_CSR_SIZE	5168
+#define DDRPHY_QB_ACSM_SIZE	4 * 1024
+#define DDRPHY_QB_MSB_SIZE	0x200
+#define DDRPHY_QB_PSTATES	0
+#define DDRPHY_QB_PST_SIZE	DDRPHY_QB_PSTATES * 4 * 1024
+
+/**
+ * This structure needs to be aligned with the one in OEI.
+ */
+struct ddrphy_qb_state {
+	u32 crc;		  /** Used for ensuring integrity in DRAM */
+#define MAC_LENGTH              8 /** 256 bits, 32-bit aligned */
+	u32 mac[MAC_LENGTH];
+	u8 TrainedVREFCA_A0;
+	u8 TrainedVREFCA_A1;
+	u8 TrainedVREFCA_B0;
+	u8 TrainedVREFCA_B1;
+	u8 TrainedVREFDQ_A0;
+	u8 TrainedVREFDQ_A1;
+	u8 TrainedVREFDQ_B0;
+	u8 TrainedVREFDQ_B1;
+	u8 TrainedVREFDQU_A0;
+	u8 TrainedVREFDQU_A1;
+	u8 TrainedVREFDQU_B0;
+	u8 TrainedVREFDQU_B1;
+	u8 TrainedDRAMDFE_A0;
+	u8 TrainedDRAMDFE_A1;
+	u8 TrainedDRAMDFE_B0;
+	u8 TrainedDRAMDFE_B1;
+	u8 TrainedDRAMDCA_A0;
+	u8 TrainedDRAMDCA_A1;
+	u8 TrainedDRAMDCA_B0;
+	u8 TrainedDRAMDCA_B1;
+	u16 QBPllUPllProg0;
+	u16 QBPllUPllProg1;
+	u16 QBPllUPllProg2;
+	u16 QBPllUPllProg3;
+	u16 QBPllCtrl1;
+	u16 QBPllCtrl4;
+	u16 QBPllCtrl5;
+	u16 csr[DDRPHY_QB_CSR_SIZE];
+	u16 acsm[DDRPHY_QB_ACSM_SIZE];
+	u16 pst[DDRPHY_QB_PST_SIZE];
+};
+#endif /* #if IS_ENABLED(CONFIG_IMX_SNPS_DDR_PHY_QB_GEN)  */
+#endif /* #if IS_ENABLED(CONFIG_IMX95) || IS_ENABLED(CONFIG_IMX94) */
+
 void ddr_load_train_firmware(enum fw_type type);
 int ddr_init(struct dram_timing_info *timing_info);
 int ddr_cfg_phy(struct dram_timing_info *timing_info);
diff --git a/arch/arm/include/asm/mach-imx/qb.h b/arch/arm/include/asm/mach-imx/qb.h
new file mode 100644
index 00000000000..5efe68f0a60
--- /dev/null
+++ b/arch/arm/include/asm/mach-imx/qb.h
@@ -0,0 +1,13 @@
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
+int  qb(int qb_dev, int qb_bootdev, bool save);
+#endif
diff --git a/arch/arm/mach-imx/imx9/Makefile b/arch/arm/mach-imx/imx9/Makefile
index 53cc97c6b47..3018d128a36 100644
--- a/arch/arm/mach-imx/imx9/Makefile
+++ b/arch/arm/mach-imx/imx9/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
-# Copyright 2022 NXP
+# Copyright 2022,2026 NXP
 
 obj-y += lowlevel_init.o
 
@@ -12,4 +12,8 @@ endif
 
 ifneq ($(CONFIG_SPL_BUILD),y)
 obj-y += imx_bootaux.o
-endif
\ No newline at end of file
+endif
+
+ifeq ($(CONFIG_IMX_SNPS_DDR_PHY_QB_GEN),y)
+obj-y += qb.o
+endif
diff --git a/arch/arm/mach-imx/imx9/qb.c b/arch/arm/mach-imx/imx9/qb.c
new file mode 100644
index 00000000000..fc01d8e22e9
--- /dev/null
+++ b/arch/arm/mach-imx/imx9/qb.c
@@ -0,0 +1,430 @@
+// SPDX-License-Identifier: GPL-2.0+
+/**
+ * Copyright 2024-2026 NXP
+ */
+#include <dm/device-internal.h>
+#include <errno.h>
+#include <imx_container.h>
+#include <linux/bitfield.h>
+#include <mmc.h>
+#include <spi_flash.h>
+#include <spl.h>
+#include <stdlib.h>
+
+#include <asm/arch/ddr.h>
+#include <asm/mach-imx/boot_mode.h>
+#include <asm/mach-imx/sys_proto.h>
+
+#define QB_STATE_LOAD_SIZE    SZ_64K
+
+#define MMC_DEV		0
+#define QSPI_DEV	1
+#define NAND_DEV	2
+#define QSPI_NOR_DEV	3
+#define ROM_API_DEV	4
+#define RAM_DEV		5
+
+#if CONFIG_IS_ENABLED(DM_MMC) && CONFIG_IS_ENABLED(MMC_WRITE)
+#define QB_MMC_EN	1
+#endif /** DM_MMC && MMC_WRITE */
+#if CONFIG_IS_ENABLED(SPI)
+#define QB_SPI_EN	1
+#endif /** SPI */
+
+#define IMG_FLAGS_IMG_TYPE_MASK   0xFU
+#define IMG_FLAGS_IMG_TYPE(x)     FIELD_GET(IMG_FLAGS_IMG_TYPE_MASK, x)
+
+#define IMG_TYPE_DDR_TDATA_DUMMY  0xDU   /* dummy DDR training data image */
+
+/**
+ * Table used to implement half-byte CRC
+ * Polynomial: 0xEDB88320
+ */
+static const u32 p_table[] = {
+	0x00000000, 0x1db71064, 0x3b6e20c8, 0x26d930ac,
+	0x76dc4190, 0x6b6b51f4, 0x4db26158, 0x5005713c,
+	0xedb88320, 0xf00f9344, 0xd6d6a3e8, 0xcb61b38c,
+	0x9b64c2b0, 0x86d3d2d4, 0xa00ae278, 0xbdbdf21c,
+};
+
+/**
+ * Implement half-byte CRC algorithm
+ */
+static u32 qb_crc32(const void *addr, u32 len)
+{
+	u32 crc = ~0x00, idx, i, val;
+	const u8 *chr = (const u8 *)addr;
+
+	for (i = 0; i < len; i++, chr++) {
+		val = (u32)(*chr);
+
+		idx = (crc ^ (val >> 0)) & 0x0F;
+		crc = p_table[idx] ^ (crc >> 4);
+		idx = (crc ^ (val >> 4)) & 0x0F;
+		crc = p_table[idx] ^ (crc >> 4);
+	}
+
+	return ~crc;
+}
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
+	qb_state = (struct ddrphy_qb_state *)CONFIG_SAVED_QB_STATE_BASE;
+	size = sizeof(struct ddrphy_qb_state) - sizeof(qb_state->crc);
+	crc = qb_crc32(qb_state->mac, size);
+
+	if (!qb_state->crc || crc != qb_state->crc)
+		return false;
+
+	return true;
+}
+
+static unsigned long get_boot_device_offset(void *dev, int dev_type, bool bootdev)
+{
+	unsigned long offset = 0;
+	struct mmc *mmc;
+
+	switch (dev_type) {
+	case ROM_API_DEV:
+		offset = (unsigned long)dev;
+		break;
+	case MMC_DEV:
+		mmc = (struct mmc *)dev;
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
+	case NAND_DEV:
+		offset = CONTAINER_HDR_NAND_OFFSET;
+		break;
+	case QSPI_NOR_DEV:
+		offset = CONTAINER_HDR_QSPI_OFFSET + 0x08000000;
+		break;
+	case RAM_DEV:
+		offset = (unsigned long)dev + CONTAINER_HDR_MMCSD_OFFSET;
+		break;
+	}
+
+	return offset;
+}
+
+static int parse_container(void *addr, u32 *qb_data_off)
+{
+	struct container_hdr *phdr;
+	struct boot_img_t *img_entry;
+	u8 i = 0;
+	u32 img_type, img_end;
+
+	phdr = (struct container_hdr *)addr;
+	if (phdr->tag != 0x87 || (phdr->version != 0x0 && phdr->version != 0x2))
+		return -1;
+
+	img_entry = (struct boot_img_t *)(addr + sizeof(struct container_hdr));
+	for (i = 0; i < phdr->num_images; i++) {
+		img_type = IMG_FLAGS_IMG_TYPE(img_entry->hab_flags);
+		if (img_type == IMG_TYPE_DDR_TDATA_DUMMY && img_entry->size == 0) {
+			/** Image entry pointing to DDR Training Data */
+			(*qb_data_off) = img_entry->offset;
+			return 0;
+		}
+
+		img_end = img_entry->offset + img_entry->size;
+		if (i + 1 < phdr->num_images) {
+			img_entry++;
+			if (img_end + QB_STATE_LOAD_SIZE == img_entry->offset) {
+				/** hole detected */
+				(*qb_data_off) = img_end;
+				return 0;
+			}
+		}
+	}
+
+	return -1;
+}
+
+static int get_dev_qbdata_offset(void *dev, int dev_type, unsigned long offset, u32 *qbdata_offset)
+{
+	int ret = 0;
+	u16 ctnr_hdr_align = CONTAINER_HDR_ALIGNMENT;
+	void *buf = kmalloc(ctnr_hdr_align, GFP_KERNEL);
+
+	if (!buf) {
+		printf("kmalloc buffer failed\n");
+		return -ENOMEM;
+	}
+
+	switch (dev_type) {
+#ifdef QB_MMC_EN
+	case MMC_DEV:
+		unsigned long count = 0;
+		struct mmc *mmc = (struct mmc *)dev;
+
+		count = blk_dread(mmc_get_blk_desc(mmc),
+				  offset / mmc->read_bl_len,
+				  ctnr_hdr_align / mmc->read_bl_len,
+				  buf);
+		if (count == 0) {
+			printf("Read container image from MMC/SD failed\n");
+			free(buf);
+			return -EIO;
+		}
+		break;
+#endif /** QB_MMC_EN */
+#ifdef QB_SPI_EN
+	case QSPI_DEV:
+		struct spi_flash *flash = (struct spi_flash *)dev;
+
+		ret = spi_flash_read(flash, offset,
+				     ctnr_hdr_align, buf);
+		if (ret) {
+			printf("Read container header from QSPI failed\n");
+			free(buf);
+			return -EIO;
+		}
+		break;
+#endif /** QB_SPI_EN */
+	case QSPI_NOR_DEV:
+	case RAM_DEV:
+		memcpy(buf, (const void *)offset, ctnr_hdr_align);
+		break;
+	default:
+		printf("Support for device %d not enabled\n", dev_type);
+		free(buf);
+		return -EIO;
+	}
+
+	ret = parse_container(buf, qbdata_offset);
+
+	free(buf);
+
+	return ret;
+}
+
+static int get_qbdata_offset(void *dev, int dev_type, u32 *qbdata_offset, bool bootdev)
+{
+	u32 offset = get_boot_device_offset(dev, dev_type, bootdev);
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
+#ifdef QB_MMC_EN
+static int mmc_get_device_index(u32 dev)
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
+static int mmc_find_device(struct mmc **mmcp, int mmc_dev)
+{
+	int err;
+
+	err = mmc_init_device(mmc_dev);
+	if (err)
+		return err;
+
+	*mmcp = find_mmc_device(mmc_dev);
+
+	return (*mmcp) ? 0 : -ENODEV;
+}
+
+static int do_qb_mmc(int dev, bool save, bool is_bootdev)
+{
+	struct mmc *mmc;
+	int ret = 0, mmc_dev;
+	bool has_hw_part;
+	u8 orig_part, part;
+	u32 offset;
+	void *buf;
+
+	mmc_dev = mmc_get_device_index(dev);
+	if (mmc_dev < 0)
+		return mmc_dev;
+
+	ret = mmc_find_device(&mmc, mmc_dev);
+	if (ret)
+		return ret;
+
+	if (!mmc->has_init)
+		ret = mmc_init(mmc);
+
+	if (ret)
+		return ret;
+
+	has_hw_part = !IS_SD(mmc) && mmc->part_config != MMCPART_NOAVAILABLE;
+
+	if (has_hw_part) {
+		orig_part = mmc_get_blk_desc(mmc)->hwpart;
+		part = EXT_CSD_EXTRACT_BOOT_PART(mmc->part_config);
+
+		/** Select the partition */
+		ret = mmc_switch_part(mmc, part);
+		if (ret)
+			return ret;
+	}
+
+	ret = get_qbdata_offset(mmc, MMC_DEV, &offset, is_bootdev);
+	if (ret)
+		return ret;
+
+	if (save) {
+		/** QB data is stored in DDR -> can use it as buf */
+		buf = (void *)CONFIG_SAVED_QB_STATE_BASE;
+		ret = blk_dwrite(mmc_get_blk_desc(mmc),
+				 offset / mmc->write_bl_len,
+				 QB_STATE_LOAD_SIZE / mmc->write_bl_len,
+				 (const void *)buf);
+	} else {
+		/** erase */
+		ret = blk_derase(mmc_get_blk_desc(mmc),
+				 offset / mmc->write_bl_len,
+				 QB_STATE_LOAD_SIZE / mmc->write_bl_len);
+	}
+
+	ret = (ret > 0) ? 0 : -1;
+
+	/** Return to original partition */
+	if (has_hw_part)
+		ret |= mmc_switch_part(mmc, orig_part);
+
+	return ret;
+}
+#else
+static int do_qb_mmc(int dev, bool save, bool is_bootdev)
+{
+	printf("Please enable MMC and MMC_WRITE\n");
+
+	return -EOPNOTSUPP;
+}
+#endif /** QB_MMC_EN */
+
+#ifdef QB_SPI_EN
+static int spi_find_device(struct spi_flash **dev)
+{
+	unsigned int sf_bus = CONFIG_SF_DEFAULT_BUS;
+	unsigned int sf_cs = CONFIG_SF_DEFAULT_CS;
+	struct spi_flash *flash;
+	int ret = 0;
+
+	flash = spi_flash_probe(sf_bus, sf_cs,
+				CONFIG_SF_DEFAULT_SPEED,
+				CONFIG_SF_DEFAULT_MODE);
+
+	if (!flash) {
+		puts("SPI probe failed.\n");
+		return -ENODEV;
+	}
+
+	*dev = flash;
+
+	return ret;
+}
+
+static int do_qb_spi(int dev, bool save, bool is_bootdev)
+{
+	int ret = 0;
+	u32 offset;
+	void *buf;
+	struct spi_flash *flash;
+
+	ret = spi_find_device(&flash);
+	if (ret)
+		return -ENODEV;
+
+	ret = get_qbdata_offset(flash, QSPI_DEV, &offset, is_bootdev);
+	if (ret)
+		return ret;
+
+	ret = spi_flash_erase(flash, offset,
+			      QB_STATE_LOAD_SIZE);
+
+	if (!ret && save) {
+		/** QB data is stored in DDR -> can use it as buf */
+		buf = (void *)CONFIG_SAVED_QB_STATE_BASE;
+		ret = spi_flash_write(flash, offset,
+				      QB_STATE_LOAD_SIZE, buf);
+	}
+
+	return ret;
+}
+#else
+static int do_qb_spi(int dev, bool save, bool is_bootdev)
+{
+	printf("Please enable SPI\n");
+
+	return -EOPNOTSUPP;
+}
+#endif /** QB_SPI_EN */
+
+int qb(int qb_dev, int qb_bootdev, bool save)
+{
+	int ret = -1;
+
+	if (save && !qb_check())
+		return ret;
+
+	switch (qb_dev) {
+	case BOOT_DEVICE_MMC1:
+	case BOOT_DEVICE_MMC2:
+	case BOOT_DEVICE_MMC2_2:
+		ret = do_qb_mmc(qb_dev, save, !!(qb_dev == qb_bootdev));
+		break;
+	case BOOT_DEVICE_SPI:
+		ret = do_qb_spi(qb_dev, save, !!(qb_dev == qb_bootdev));
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
+	memset((void *)CONFIG_SAVED_QB_STATE_BASE, 0, sizeof(struct ddrphy_qb_state));
+
+	return 0;
+}
diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index 17269ddd2fc..eb9bfe19a69 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -281,6 +281,15 @@ static struct mm_region imx9_mem_map[] = {
 			 PTE_BLOCK_NON_SHARE |
 			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
 	}, {
+#if IS_ENABLED(CONFIG_IMX_SNPS_DDR_PHY_QB_GEN)
+		/* QB data */
+		.virt = CONFIG_SAVED_QB_STATE_BASE,
+		.phys = CONFIG_SAVED_QB_STATE_BASE,
+		.size = 0x200000UL,	/* 2M */
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_OUTER_SHARE
+	}, {
+#endif /* CONFIG_IMX_SNPS_DDR_PHY_QB_GEN */
 		/* empty entry to split table entry 5 if needed when TEEs are used */
 		0,
 	}, {
diff --git a/drivers/ddr/imx/imx9/Kconfig b/drivers/ddr/imx/imx9/Kconfig
index 0a45340ffb6..7c244ddb5dd 100644
--- a/drivers/ddr/imx/imx9/Kconfig
+++ b/drivers/ddr/imx/imx9/Kconfig
@@ -29,4 +29,12 @@ config SAVED_DRAM_TIMING_BASE
 	  info into memory for low power use.
 	default 0x2051C000
 
+config SAVED_QB_STATE_BASE
+	hex "Define the base address for saved QuickBoot state"
+	depends on IMX_SNPS_DDR_PHY_QB_GEN
+	help
+	  Once DRAM is trained, need to save the dram related timing
+	  info into memory in order to be reachable from U-Boot.
+	default 0x8fe00000
+
 endmenu
diff --git a/drivers/ddr/imx/phy/Kconfig b/drivers/ddr/imx/phy/Kconfig
index d3e589b23c4..e8d0c005689 100644
--- a/drivers/ddr/imx/phy/Kconfig
+++ b/drivers/ddr/imx/phy/Kconfig
@@ -2,3 +2,10 @@ config IMX_SNPS_DDR_PHY
 	bool "i.MX Snopsys DDR PHY"
 	help
 	  Select the DDR PHY driver support on i.MX8M and i.MX9 SOC.
+
+config IMX_SNPS_DDR_PHY_QB_GEN
+	bool "i.MX Synopsys DDR PHY training data saving for QuickBoot mode"
+	depends on IMX94 || IMX95
+	help
+	  Select the DDR PHY training data saving for
+	  QuickBoot support on i.MX9 SOC.
-- 
2.43.0

