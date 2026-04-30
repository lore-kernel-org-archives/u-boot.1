Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C86CCFA13
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 08:23:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3D378466D;
	Thu, 30 Apr 2026 10:23:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="X4z0OQbn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D85C84653; Thu, 30 Apr 2026 10:23:19 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E96F884661
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 10:23:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GqI0COIPtjw25c0YK80FcGlMk9iqSQpPKgjnwxbS1H4hiVi+AfRaj/scimUPr/z4DvfrXPhdKdWMguI36RikFcQdy+yMhULZFAbzdOtlQLgmI5Y/+hU6s4+EUMgbwHmcbyTIqkOYHxa9xy9p/TxaJtUuBVqco1hVDV/OjoRkgKBivYjnqxWs5sy6SdWzjKAo+vGlK+V/lyiO+TXTFjiPRmy67dm+Ic5hNzsbYP7IOOtXUJYCgsIgNrfQLw8/UNHucGuMn/6JfoTtSuNJctePpvbxbUQQHsNiGrN9KD47BufUFvc3SXNhxFBUda4MmrDtollFyScCN/MzwFJpzgb/QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnY15AgMaQbhqI4Za7s7oA9yIfoYsBHL4PN0lP1niVQ=;
 b=Iz/K9BBmnx0PNp+005Z7UxgQSAK99LOHP+NMYRNrnfjNaCB396zx2jRb/RZjumPAc49Lu+pWng/Z0n4CfscqfrC+GnZTJUMBCxannI5sN/K5dF6rX1PcdV8EfSIJ+umpjIBMBAwTb0CkjPsLuuHQGfVwpcr44IwnJlT7OvUDjD046KQfGY1vRAuRmlevP+r8M0bBi7Fb6eAqhmTt0zwuLDE9AmovPYyx5PWTByIqx5UAcs5mcqkfZ25rYKyS/BnQJoglTkzj52RyUKD/KWN9TJBG8g+LMOXpUx0K2/CiGECIzTvjl5XXV5YW49wSL7LwrMEfdSmBECGuzZptBwpuGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnY15AgMaQbhqI4Za7s7oA9yIfoYsBHL4PN0lP1niVQ=;
 b=X4z0OQbnO33tLNGDD77XBFm7zRsr80EPHDNUf533L5wE76ukCxG0aofGh80DCjce4ZWWEY4OijpA4Yf5LpA2WbWguiCbHdKSGGR4DHOxRV40TAxpMnP8Ro1p643g6+XDnvDYeWDNcfmd+5xzlPowujhhgPe85okigOJOpON+TgHs2A+KbKAmC8KUzCvwaT7RmZr0M2iGyl+D1lkdKtOd6N+0iNw3cZL4VNW1xDji0ZiqG7mroAHALLaQc/xhxa9OLQwun6cdQ5u/yBgxIuAckmvFeWsDqhrOnyUvOA5gsk0sYg3CKc18ju7cZJ9yShxCjCD6c04iA5YDwFixoOrenw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com (2603:10a6:800:306::9)
 by DB8PR04MB7036.eurprd04.prod.outlook.com (2603:10a6:10:12f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 08:23:14 +0000
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7]) by VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7%4]) with mapi id 15.20.9870.016; Thu, 30 Apr 2026
 08:23:13 +0000
From: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>
To: uboot-imx@nxp.com,
	u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, ye.li@nxp.com, simona.toaca@nxp.com,
 viorel.suman@nxp.com, fedor.ross@ifm.com, marex@nabladev.com,
 joao.goncalves@toradex.com, ravi@prevas.dk, ping.bai@nxp.com,
 ji.luo@nxp.com, qijian.guo@nxp.com
Subject: [PATCH v4 1/4] imx9: Add support for saving DDR training data to NVM
Date: Thu, 30 Apr 2026 11:33:30 +0300
Message-ID: <d9038d69963976399d8e8e26dbf84b98ee1f82da.1777536451.git.simona.toaca@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777536451.git.simona.toaca@nxp.com>
References: <cover.1777536451.git.simona.toaca@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P250CA0022.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::27) To VI0PR04MB11917.eurprd04.prod.outlook.com
 (2603:10a6:800:306::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11917:EE_|DB8PR04MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fa4e2c3-e757-4795-a9f9-08dea691b89b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: ihchGrCtiovIBI/LKTKvOUVMK3qvZCu8YWDsfFBVl1TTIA5ae7Lyz4XI80BrHie05+I6bPV+qWHDcwnXp0NEgJIbpyMe5s+3w3FtkWlZNiTtMuzRJybB6DVZyigb31pymTs831gw+UKSzm2rReMQjM9JOBTEUvaR2ws9AVCjaCpGn+DnBQfxiSA5emWKzdm07L/LGgk3Uq8+hXt01h0FlkswSxbNqw/5v/jg21YHl0SE63pLmCUX7VOk2v2kD4wwfimjOpuad15X5AzTD5mi5XcxpRVpca5zjyGkLk2x5sS6VEUwkuLf0+CEEbsTKW2699l+NYpLmz5t/MtAIhsj0EQMSUWX1ixwoMUiUChNnbBWMNcLqPi6wpZRKV76VVs1FOsch38s/oW2oz30g/YieqDT+K4N0pcV0exafHIijvIEAZEUfHrARzjXxVYGtqM4Eg70H5sAkwkQZiD6977kbsj9a2lzCF7WSb2mLgkcLan5uQnbfUkxaLwm58+LPvec52vxmxz4wiNgL8A2GRkwHyMpZ3NchDzlppea6mK5XdekhQysSsi4MULQV/jUPn17QL9UeMlCFDTbm/sbR5bkjUB3oB7PYKDj38ld0C3AmqUCZnFzMrX0rs0p4uuPeZYKp/c86H/fwpYF2b5MsxNbU9gogT7YqFB7Z+LiCRIr1svRH1ZBiwyaKKNosYkyFXCe3n4uLj+vNvoQC0+YML+NAClHTLSjiPqzhOVQ4IX6H4g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB11917.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DZpY5rwCx9jxlzBt8ULfRDKRHP7ROmXYpiBr7KQZtFUpP9G3LkefFRme/k5I?=
 =?us-ascii?Q?ikLXweHPmNO37js5yk3Kv004AmF1srbllLi8ewmjspawykYRsFEB8EBiZhEc?=
 =?us-ascii?Q?dF1c6lCz7a71CUflr0tVt+2XkJhK29dCbqaAMzlI7e65JyYERjhpY3OVmB5z?=
 =?us-ascii?Q?jLuLIjAnWHrMqoeGOI2i6PqIuoWy7qCdIeGeJicophc0tJNLpGgqT8B/Wwvu?=
 =?us-ascii?Q?WbpJ3rfVFX72H3EYUnEik0jV7nk475tudNrkpS0sdMtBEAqZVJ2DehwtQXgH?=
 =?us-ascii?Q?mw8pKB9MJt8+ExE7rr9EMil/RM5qhw03H8ayhA7trOWMwMZ3T5cnVVkxJMx1?=
 =?us-ascii?Q?zUD3I0Is8TeLhuI8dY/kdr2Zisb+TMbEn1vPXdnUa+dEVGo/z+J7Vbfu/dft?=
 =?us-ascii?Q?qicwQY8BkenwOaDtr8N4Xn6INy6VtUfrTfqKXTGPTNlQigfXNXOJQmCqNaKk?=
 =?us-ascii?Q?ytcnYarNMQqSzHaa3+HlKNtXvKPDXTVLwsnmNjPiGFjR2Zmpfnw5iJeYxLxI?=
 =?us-ascii?Q?tpGlZ9zs9mS14kkY3hzwmZcB2c+slAwy6JBmr6jMaKPUobYSCicLnyTJraql?=
 =?us-ascii?Q?F+svmX5SPKzIg3p0jfBsM/Rk5noK1TE64I2Kt89ff5Xe0pd84Y4N08lmLlGF?=
 =?us-ascii?Q?LfgNGpDPdmCWJovW+kbGxnptU05m3T3LXdbhbE4Y2nu4XKgtaqpdohelv6le?=
 =?us-ascii?Q?cQmSnNrcgVeSQw33RQQJdnNLctD9gBO3OGWGfUHnBOjj7QOa022rDfIzJ9vN?=
 =?us-ascii?Q?ky2q1pjaLunrVZ/rFUwIpFglP48RrEwGVJFFBpp6U+8mAWNyJyTXpcj80GA7?=
 =?us-ascii?Q?OxGS+aHFCJak41S/T1Qgs2kihtgCp0DKankSMYXT0XOl8Nv0Yob3QqvR2VCt?=
 =?us-ascii?Q?O/COHpFIL4Bl/wxDztxeXU+mgzeTmpm8OJSFL/3AuZUOTnlQX+Vv7KwRfrxx?=
 =?us-ascii?Q?vuB3PDJxOCk5ycLaQ/tId996IR4L8c9wvLS654hr+Rm3PtDoL88ZHwVwrp2A?=
 =?us-ascii?Q?OwhdFxnMApr3deO9Bh3Sy0NfBjbg6OPR4KxsiZ31Jl21BW23LWY6MCazFXTw?=
 =?us-ascii?Q?MbkGkL1Z9+36c6kfqiUYBlUpyOC6nR4hNu4W6pn7QpkSRo1gcz7xCryVk7M7?=
 =?us-ascii?Q?f9RsNRXQmnTPKwROCXcQYWXnaZ2/Ww7l5R8AsJ2Tqc1dO6Two80TCSlGCzs2?=
 =?us-ascii?Q?p9X4Z+vPnzIFk5HEkus9OSauNqZFCrkvh61qlabOI1nkNa/V8gg+vjkPXlpW?=
 =?us-ascii?Q?okjvQCeaNZHeNjiU50EgLjcDe4Nmad440TS5hHuKjaMfBpWbYJTPRys+mLC0?=
 =?us-ascii?Q?lPIhsrGK7wMxw5fXQIBZ+ZsRCjfTezYOLZ2mtLYZ9tBtHcMyskPsT6h8oU7/?=
 =?us-ascii?Q?HB87plwy0znJxQlGmSqSRF8MyW1yyyzMIa8wOJTJN4rSOuGVDmYNUWuvWfpJ?=
 =?us-ascii?Q?Es+4O8nNFqNbBGpOasu6xs82XRHuBRtYAlIbLYktu7YN5ozRwHjXWG1pm5u+?=
 =?us-ascii?Q?C5brAB8OEPtcvH0q9OI+Q9OM2F7laolToIbhSkpBvjo1eg7F8zrveAP1DZfn?=
 =?us-ascii?Q?zF7XKwnyUkKdvwaDxw/0qoYY4Llt7Z4G/QO+GD+S4pyAwgyD3xKGtHxsCWrV?=
 =?us-ascii?Q?o2MdC6oCtGIQyXC+2Vx4OazUSDvx3S0KQ/Djq7BK23F9VzPvxrYAis5WSrF8?=
 =?us-ascii?Q?D9R1zKYR0pJ7NlwNo82hRkv6xGY3wj1O7Sg6MsIcE7JrMG+0FAT6gE61Xq9i?=
 =?us-ascii?Q?ZoNygD0xUQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa4e2c3-e757-4795-a9f9-08dea691b89b
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11917.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 08:23:13.3676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xr3m7M6pLcaMDby9PnMwIJlz4zgDyZoUCGwZ5rfE6gG/FMRfQJjfztf8fTHmZlKRGMrdQn8SeRWf6wf2MS2h5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7036
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
CRC32. On the other SoCs, authentication is done by
using ELE to check the MAC stored in the ddrphy_qb_state
structure.

Supported platforms: iMX94, iMX95, iMX952 (using OEI)
Supported storage types: eMMC, SD, SPI flash.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Simona Toaca <simona.toaca@nxp.com>
---
 arch/arm/include/asm/arch-imx9/ddr.h |  48 +++-
 arch/arm/include/asm/mach-imx/qb.h   |  15 +
 arch/arm/mach-imx/Kconfig            |   9 +
 arch/arm/mach-imx/imx9/Makefile      |   6 +-
 arch/arm/mach-imx/imx9/qb.c          | 403 +++++++++++++++++++++++++++
 arch/arm/mach-imx/imx9/scmi/soc.c    |   7 +
 drivers/ddr/imx/imx9/Kconfig         |   7 +
 7 files changed, 492 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/include/asm/mach-imx/qb.h
 create mode 100644 arch/arm/mach-imx/imx9/qb.c

diff --git a/arch/arm/include/asm/arch-imx9/ddr.h b/arch/arm/include/asm/arch-imx9/ddr.h
index a8e3f7354c7..bba12369f06 100644
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
+#define MAC_LENGTH		8 /* 256 bits, 32-bit aligned */
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
index 00000000000..a874c9c5e36
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
+bool imx_qb_check(void);
+int imx_qb(const char *ifname, const char *dev, bool save);
+void spl_imx_qb_save(void);
+
+#endif
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 259f4a4ce99..bb62a0cf2f6 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -71,6 +71,15 @@ config CSF_SIZE
 	  Define the maximum size for Command Sequence File (CSF) binary
 	  this information is used to define the image boot data.
 
+config IMX_QB
+	bool "Support Quickboot flow for Synopsis DDR PHY on iMX platforms"
+	default y
+	depends on IMX94 || IMX95 || IMX952
+	help
+	  Enable the logic for saving DDR training data from volatile
+	  memory to non-volatile storage. OEI uses the saved data to
+	  run Quickboot flow and skip re-training the DDR PHY.
+
 config CMD_BMODE
 	bool "Support the 'bmode' command"
 	default y
diff --git a/arch/arm/mach-imx/imx9/Makefile b/arch/arm/mach-imx/imx9/Makefile
index 53cc97c6b47..80b697396ea 100644
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
+obj-$(CONFIG_$(PHASE_)IMX_QB) += qb.o
diff --git a/arch/arm/mach-imx/imx9/qb.c b/arch/arm/mach-imx/imx9/qb.c
new file mode 100644
index 00000000000..1a0a12de3d4
--- /dev/null
+++ b/arch/arm/mach-imx/imx9/qb.c
@@ -0,0 +1,403 @@
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
+#define BLK_DEV		0
+#define SPI_DEV		1
+
+#define IMG_FLAGS_IMG_TYPE_MASK   0xF
+#define IMG_FLAGS_IMG_TYPE(x)     FIELD_GET(IMG_FLAGS_IMG_TYPE_MASK, (x))
+
+#define IMG_TYPE_DDR_TDATA_DUMMY  0xD   /* dummy DDR training data image */
+
+static const struct {
+	const char *ifname;
+	const char *dev;
+} imx_boot_devs[] = {
+	[BOOT_DEVICE_MMC1] = { "mmc", "0" },
+	[BOOT_DEVICE_MMC2] = { "mmc", "1" },
+	[BOOT_DEVICE_SPI]  = { "spi", "" },
+};
+
+static int imx_qb_get_board_boot_device(void)
+{
+	switch (get_boot_device()) {
+	case SD1_BOOT:
+	case MMC1_BOOT:
+		return BOOT_DEVICE_MMC1;
+	case SD2_BOOT:
+	case MMC2_BOOT:
+		return BOOT_DEVICE_MMC2;
+	case USB_BOOT:
+		return BOOT_DEVICE_BOARD;
+	case QSPI_BOOT:
+		return BOOT_DEVICE_SPI;
+	default:
+		return BOOT_DEVICE_NONE;
+	}
+}
+
+static int imx_qb_get_boot_dev_str(const char **ifname, const char **dev)
+{
+	int boot_dev;
+
+	if (IS_ENABLED(CONFIG_XPL_BUILD))
+		boot_dev = spl_boot_device();
+	else
+		boot_dev = imx_qb_get_board_boot_device();
+
+	if (boot_dev == BOOT_DEVICE_NONE || boot_dev == BOOT_DEVICE_BOARD)
+		return -EINVAL;
+
+	*ifname = imx_boot_devs[boot_dev].ifname;
+	*dev = imx_boot_devs[boot_dev].dev;
+
+	return 0;
+}
+
+bool imx_qb_check(void)
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
+static int imx_qb_get_blk_boot_part(const char * const ifname,
+				    const char * const dev,
+				    struct blk_desc **bdesc)
+{
+	struct udevice *udev;
+	struct disk_partition info;
+	struct mmc *mmc;
+	int part;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_XPL_BUILD))
+		return blk_get_device_part_str(ifname, dev, bdesc, &info, 1);
+
+	/**
+	 * SPL does not have access to part_get_info,
+	 * so get the partition manually. Currently only
+	 * supporting MMC devices.
+	 */
+	ret = blk_get_device_by_str(ifname, dev, bdesc);
+
+	if (ret < 0)
+		return -ENODEV;
+
+	if ((*bdesc)->uclass_id != UCLASS_MMC)
+		return -EOPNOTSUPP;
+
+	udev = dev_get_parent((*bdesc)->bdev);
+	mmc = mmc_get_mmc_dev(udev);
+
+	if (IS_SD(mmc) || mmc->part_config == MMCPART_NOAVAILABLE)
+		return 0;
+
+	part = EXT_CSD_EXTRACT_BOOT_PART(mmc->part_config);
+
+	if (part == EMMC_BOOT_PART_BOOT1 || part == EMMC_BOOT_PART_BOOT2)
+		return part;
+
+	return 0;
+}
+
+static ulong imx_qb_get_boot_device_offset(void *dev, int dev_type)
+{
+	struct blk_desc *bdesc;
+
+	switch (dev_type) {
+	case BLK_DEV:
+		bdesc = dev;
+
+		/* eMMC boot partition */
+		if (bdesc->hwpart)
+			return CONTAINER_HDR_EMMC_OFFSET;
+
+		return CONTAINER_HDR_MMCSD_OFFSET;
+	case SPI_DEV:
+		return CONTAINER_HDR_QSPI_OFFSET;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int imx_qb_parse_container(void *addr, u64 *qb_data_off)
+{
+	struct container_hdr *phdr;
+	struct boot_img_t *img_entry;
+	u32 img_type, img_end;
+	int i;
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
+static int imx_qb_get_dev_qbdata_offset(void *dev, int dev_type, ulong offset,
+					u64 *qbdata_offset)
+{
+	struct blk_desc *bdesc;
+	u8 *buf;
+	ulong count;
+	int ret;
+
+	buf = malloc(CONTAINER_HDR_ALIGNMENT);
+	if (!buf)
+		return -ENOMEM;
+
+	switch (dev_type) {
+	case BLK_DEV:
+		bdesc = dev;
+
+		count = blk_dread(bdesc,
+				  offset / bdesc->blksz,
+				  CONTAINER_HDR_ALIGNMENT / bdesc->blksz,
+				  buf);
+		if (count == 0) {
+			printf("Read container image from MMC/SD failed\n");
+			ret = -EIO;
+			goto imx_qb_get_dev_qbdata_offset_exit;
+		}
+		break;
+	case SPI_DEV:
+		if (!CONFIG_IS_ENABLED(SPI)) {
+			ret = -EOPNOTSUPP;
+			goto imx_qb_get_dev_qbdata_offset_exit;
+		}
+
+		ret = spi_flash_read_dm(dev, offset,
+					CONTAINER_HDR_ALIGNMENT, buf);
+		if (ret) {
+			printf("Read container header from SPI failed\n");
+			ret = -EIO;
+			goto imx_qb_get_dev_qbdata_offset_exit;
+		}
+		break;
+	default:
+		printf("Support for device %d not enabled\n", dev_type);
+		ret = -EOPNOTSUPP;
+		goto imx_qb_get_dev_qbdata_offset_exit;
+	}
+
+	ret = imx_qb_parse_container(buf, qbdata_offset);
+
+imx_qb_get_dev_qbdata_offset_exit:
+	free(buf);
+
+	return ret;
+}
+
+static int imx_qb_get_qbdata_offset(void *dev, int dev_type,
+				    u64 *qbdata_offset)
+{
+	u64 cont_offset;
+	int ret, i;
+
+	cont_offset = imx_qb_get_boot_device_offset(dev, dev_type);
+
+	for (i = 0; i < 3; i++) {
+		ret = imx_qb_get_dev_qbdata_offset(dev, dev_type, cont_offset,
+						   qbdata_offset);
+		if (ret == 0) {
+			(*qbdata_offset) += cont_offset;
+			break;
+		}
+
+		cont_offset += CONTAINER_HDR_ALIGNMENT;
+	}
+
+	return ret;
+}
+
+static int imx_qb_blk(const char * const ifname,
+		      const char * const dev, bool save)
+{
+	struct blk_desc *bdesc;
+	u64 offset;
+	u64 load_size;
+	int part, orig_part;
+	int ret;
+
+	part = imx_qb_get_blk_boot_part(ifname, dev, &bdesc);
+
+	if (part < 0) {
+		printf("Failed to find %s %s\n", ifname, dev);
+		return -ENODEV;
+	}
+
+	orig_part = bdesc->hwpart;
+
+	ret = blk_dselect_hwpart(bdesc, part);
+	if (ret && ret != -EMEDIUMTYPE) {
+		printf("Failed to select hwpart, ret %d\n", ret);
+		return ret;
+	}
+
+	ret = imx_qb_get_qbdata_offset(bdesc, BLK_DEV, &offset);
+	if (ret) {
+		printf("get_qbdata_offset failed, ret = %d\n", ret);
+		return ret;
+	}
+
+	offset /= bdesc->blksz;
+	load_size = QB_STATE_LOAD_SIZE / bdesc->blksz;
+
+	if (save) {
+		/* QB data is stored in DDR -> can use it as buf */
+		ret = blk_dwrite(bdesc, offset, load_size,
+				 (const void *)CONFIG_QB_SAVED_STATE_BASE);
+	} else {
+		/* erase */
+		ret = blk_derase(bdesc, offset, load_size);
+	}
+
+	if (!ret) {
+		printf("Failed to write to block device\n");
+		return -EIO;
+	}
+
+	/* Return to original partition */
+	ret = blk_dselect_hwpart(bdesc, orig_part);
+	if (ret && ret != -EMEDIUMTYPE) {
+		printf("Failed to select hwpart, ret %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int imx_qb_spi(bool save)
+{
+	struct udevice *flash;
+	u64 offset;
+	int ret;
+
+	if (!CONFIG_IS_ENABLED(SPI)) {
+		printf("SPI not enabled\n");
+		return -EOPNOTSUPP;
+	}
+
+	ret = uclass_first_device_err(UCLASS_SPI_FLASH, &flash);
+	if (ret) {
+		printf("SPI flash not found.\n");
+		return -ENODEV;
+	}
+
+	ret = imx_qb_get_qbdata_offset(flash, SPI_DEV, &offset);
+	if (ret) {
+		printf("get_qbdata_offset failed, ret = %d\n", ret);
+		return ret;
+	}
+
+	ret = spi_flash_erase_dm(flash, offset, QB_STATE_LOAD_SIZE);
+
+	if (ret)
+		return ret;
+
+	if (!save)
+		return 0;
+
+	/* QB data is stored in DDR -> can use it as buf */
+	ret = spi_flash_write_dm(flash, offset,
+				 QB_STATE_LOAD_SIZE,
+				 (const void *)CONFIG_QB_SAVED_STATE_BASE);
+
+	return ret;
+}
+
+int imx_qb(const char *ifname, const char *dev, bool save)
+{
+	int ret;
+
+	ret = 0;
+
+	/* Try to use boot device  */
+	if (!strcmp(ifname, "auto"))
+		ret = imx_qb_get_boot_dev_str(&ifname, &dev);
+
+	if (ret)
+		return ret;
+
+	if (save && !imx_qb_check())
+		return -EINVAL;
+
+	if (!strcmp(ifname, "spi"))
+		ret = imx_qb_spi(save);
+	else
+		ret = imx_qb_blk(ifname, dev, save);
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
+	memset((void *)CONFIG_QB_SAVED_STATE_BASE, 0,
+	       sizeof(struct ddrphy_qb_state));
+
+	return 0;
+}
+
+void spl_imx_qb_save(void)
+{
+	/* Save QB data on current boot device */
+	if (imx_qb("auto", "", true))
+		printf("QB save failed\n");
+}
diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index 47e8fc247df..ab0f7394c9e 100644
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
index b953bca4f06..7b3dbf53dff 100644
--- a/drivers/ddr/imx/imx9/Kconfig
+++ b/drivers/ddr/imx/imx9/Kconfig
@@ -29,4 +29,11 @@ config SAVED_DRAM_TIMING_BASE
 	  after DRAM is trained, need to save the dram related timming
 	  info into memory for low power use.
 
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

