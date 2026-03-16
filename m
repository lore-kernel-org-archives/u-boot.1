Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AFFF013C5
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 08:05:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1E8683952;
	Mon, 16 Mar 2026 09:05:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lH99Y3cz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1174E83A1B; Mon, 16 Mar 2026 09:04:59 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B944483981
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 09:04:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vzdng6VTRBZrHRm4VwPxU5IjqVbH1BvUvRuA/HE+qf3oyBOYmlBWxRIv1QD6g8gF4BWHciBn7+NJDrZ5hSxDGA5SJnhu7/x158jmnHncbf/Cy/kTxD1TWnduqtNL7af1hoi8CvgzcBGopoT+3r09qZoCQag1Wx7CuvCSCMJmCpj/1nLrCGo62vz5pokWT2ypRiDwpizmDOyT4mbdudjxHuIJikdzaGUtoF+Qgkl/7ZDkIQa2ZkRCFNhku895uwDbQz0ZJPZLot+3nJau9goVTN9s+jEc3jyBqKPCrGPISnGyT6mAMhZ7estWU11x4ZhDwyIdt6domjsU8PRnggxzsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8ik2srbFdmT0GGdNsH3SiDaWJTH/axWFmaC4VJAO7w=;
 b=Q60/STkNzz1Ev2w4qpGTB9ROQNhPv0KVyZANNE5+GhlrgTvU3usTsIonScc2j4t7WbU2LxqvH0aQ2gqZjn1g7li9MSaI8yQUpHsIgmDGAZ6uF5+qef6Clrc/L0sxQlfTCJqLoweFuSoKwkoANoNlMb+b59XZj9PJVkZIpF0Lar8UGsPg9pUMXuJiaugrxXtQXRV9rhQ8VtBckqH+VgOwePtbmiNbmpSLHbpXwuOKj84/wF418b5kiyiIibOuGUhccwyftq+WTX9LO7GElvquu8lS0WFPYUggcyD5v76Q8PLkZIXXulMe4ExmdKPzAtLG8weVFqmFaM8P649xenoqaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8ik2srbFdmT0GGdNsH3SiDaWJTH/axWFmaC4VJAO7w=;
 b=lH99Y3czdALpigadn5CWmouyEqNXIpQCcw4EfnkAJjm8byKw/xUZ0df2t/10eq3+R6I5XLs3LJXY/QjpS1m/GM8WUfHVjvUwsHT7NMx/JMVDtW6MUwNbj1RKl1a1u/2Fn4GVo0qtV0+zdj/DVXK0Um5fQwerAFf0mfNg4JtQE+PwUXfblt6C8CBr16r3AHRkSs16cmJJTSWgvkGz4hJRNlgVFcQRdFlcZ2lshwv8OLo/UgmorO3el0TJKVkc+JG230S19+khTp6rJZ/gOJ3WowOfPsORM2b3TGc1XNz0JhgPNVSiNa9KZGuiXc+qScc9lV7NjRldMsNhNrDmDJYBaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV4PR04MB11901.eurprd04.prod.outlook.com
 (2603:10a6:150:2eb::21) by GV1PR04MB10128.eurprd04.prod.outlook.com
 (2603:10a6:150:1af::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Mon, 16 Mar
 2026 08:04:23 +0000
Received: from GV4PR04MB11901.eurprd04.prod.outlook.com
 ([fe80::601d:ca21:9592:9a12]) by GV4PR04MB11901.eurprd04.prod.outlook.com
 ([fe80::601d:ca21:9592:9a12%4]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 08:04:52 +0000
From: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>
To: uboot-imx@nxp.com,
	u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, simona.toaca@nxp.com, ye.li@nxp.com,
 viorel.suman@nxp.com, ping.bai@nxp.com, marex@nabladev.com,
 sebastien.szymanski@armadeus.com, ravi@prevas.dk,
 joao.goncalves@toradex.com, ji.luo@nxp.com, tharvey@gateworks.com,
 qijian.guo@nxp.com
Subject: [PATCH v2 1/5] imx9: Add support for saving DDR training data to NVM
Date: Mon, 16 Mar 2026 10:15:52 +0200
Message-ID: <5a7a3063ce3a429c67396c1d0bae95444ac3f996.1773648510.git.simona.toaca@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773648510.git.simona.toaca@nxp.com>
References: <cover.1773648510.git.simona.toaca@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0193.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::17) To GV4PR04MB11901.eurprd04.prod.outlook.com
 (2603:10a6:150:2eb::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV4PR04MB11901:EE_|GV1PR04MB10128:EE_
X-MS-Office365-Filtering-Correlation-Id: ce5ec80f-e450-4454-534f-08de8332b3c5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: czlObu+Dc4GJBy62xaqn1bBFeiFUOAznfLgpKqzHkgi7te2A6hiOh/YRsiFyteoZqlIeLOFezA0l/V3lFBwoZrAa043MDN5gRrs7J8X+2rDqrKSxbvGLOYhul4/b9M8bV2lskN82uE1GZcvjf3OOhBtiV7wxnhy8K1ZAZdNSit/IKvlawE9ENHiLDxrzfdEYsFVQ/wztJZTTJf4YxfMcvhNtJyxlE2S0FIX+r/bbz/GHqu/7IV57uRlUPxOESWQ2xSdVJhL6TkTzA0AQS/tXqV24ehzj8+/EWXjhA2yxdNJjESdSHdtIuVkHiU+/lohFH52MIlhZui4ZXYwxW15MxdkC0R3qmhAWVZSPlBDLNKHEi8FEYiS8Cy9kLNSxhTDYS6uezryeFGEs0e1L26Ilw5fOIUHlA8d597MQO8at71NeMQ1Xvrz3xIZHKA7Cc7pDchvhqklPwG38FJrFt5hdkUE0pFwBc+0DWSQ0CGZev7YCQkr5AGGidCK2Yl8Rn+Y0EVM8SC8WeR83i7s+htDCjGJ/qqD/6/ibzv3eXPL6tDv82yau2dSY31+bzH3R+pqpKeyOoJRTTFv3f73wvkr5a5OuWXugtaqColf12d2aABrjUBwbii9MZ3DtzI1J18lSnsLoVDFVRhv7s5RpCVQ2tielzVSpPnZx45AsFmUTOfel4guRHrP/VgFaIBl+SAPNjQVyaEFV0XBTPjRrTfTadd+w+EfY1N9JTcwhAg7l+h0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV4PR04MB11901.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QrW+m9X3l7BuJ3nUBQquVqxcy0KLIBTo26+s/TsbMVzinSyVOkBN/FoTdJL2?=
 =?us-ascii?Q?MWmlfqLd2oLE099jpFtXYg29iQxUi0fGCL4OAth7ZhZ1yfiwXAY3/Jc52ijm?=
 =?us-ascii?Q?3kbvFjOSl/udvXPcEhKGR/G+jujkkBqnVsRWbIMS9KXBsyVK7qGioFuRG1hJ?=
 =?us-ascii?Q?d0JJUUODOVQi+nKgqENJVt3z0tV7e9e/173SjeY8o8utYNHyaE/nUAUx17kN?=
 =?us-ascii?Q?UznZlJZR3B2Mx7Bj5vJdRfYmNWTt+TZ7MvGGLZuKpQNQ0Yz+0nnSG+chUCGu?=
 =?us-ascii?Q?CMN1W2OUQUMBYPT2SagntILl1XWc7W/JKcO6tibfImeg1zhjtWQf4xPA3RgE?=
 =?us-ascii?Q?+ie1qBmr9rJN38mBn3Xjlf+M1VOUNF3XmSwR7PL5jkOAdUWymwSILuBKCBBP?=
 =?us-ascii?Q?iZhlSU/v/YVPTkIycjzMF7GYX30WRQgULhSDD49bPm4IhzAue7E1ySGNTxRb?=
 =?us-ascii?Q?y+0v4W0GbXUCOHHRM2ca/98unJYUizE5FeChxQj4/KdWhBgubej1zGuek81b?=
 =?us-ascii?Q?DrXM/AuiVIC1zKeewZA8N8dvPioo8YCcjLDZzdsp98fYso19D4NVcpXMkDXE?=
 =?us-ascii?Q?5EQZGPXxuwt0+N1TxPiWYkqP/BXyNgtgXXXeFGWxjtGn+7e647hw7JnB3y1O?=
 =?us-ascii?Q?47WLg1RADEZIt2WJS4svHcQuNq0hMW6UsW7i42rFegVwfAcXRttzih5rRlZ5?=
 =?us-ascii?Q?zj6ggPvJxhaEqPxXM69ZDMN8m7V4vDawOqZtPL+BGlyFQlPgqgDP+bKmBluI?=
 =?us-ascii?Q?wXeAyPJdXYapdm4ne30IT5UupbLMrQ1qdiWzTqwXmf/XOCCZiVaFSkGHyz5t?=
 =?us-ascii?Q?ZKlJfE5++Mi3sjeZgxTJ4i0WT5y5jKytcEnaffQUGPaZ7JDVVFLcvXEzbbql?=
 =?us-ascii?Q?rUEM0Ypi1f6FehJROErYBNx3ORQPWWVcU0otwK9ajmwvMHiCpn5uhdWi08PB?=
 =?us-ascii?Q?9RhDP+hUOlkqTw1ikX1OTt8kWAPCM7EolSBZ+0BOwDGgubP3YSCvPy2HrzwB?=
 =?us-ascii?Q?Yb7fr788lueUfXknWFbEFV2BeW3cM6DRjEKsMyUHlzONvtn+s3sZXtL/A6JI?=
 =?us-ascii?Q?O5oW+PASc+D9NfQMemnV/ZxMtrWrZ0ob/JN8dQqcfnv61FX1YiT4ZjHrkaiz?=
 =?us-ascii?Q?l0Hydo7HN1XQ68dptaDNv6+I6VbFVhyykGYQjJj2idZHclzqV1/t5GyDJMpH?=
 =?us-ascii?Q?7BfHfqeFgokhdXV3HEhm1Cx+eyW/PdMYmUXkMlwlCD0kxpvRBDZsnDs+LdQF?=
 =?us-ascii?Q?IvrLMnRP42pfnW7Vk3ELWE3vT+1vi2xnYo/TsEna9k/BUj2A+i5usVOMxrb4?=
 =?us-ascii?Q?etlML6d8Ip1VmDJG84iNfNg21TlfjhUhEgVdvYDcMq3mdswltG0Cl4GJgb7C?=
 =?us-ascii?Q?wPuBUFtIsMYjLbsHWtxMPv2RdfFnahtK8bXbjvpIVnH8uWNtEt8UAFjKJAB8?=
 =?us-ascii?Q?23UbJ1/bNP8+JqQ8gDlKktIldyQ40WsgtVZUEQmVhaG4mUhg99glFFnM+klu?=
 =?us-ascii?Q?wCVoV97fGHO8nBl1uAH2/1Fu4eN8qfRz+iaLf1M6M3ozLJ5V2F9qAkbP6f/W?=
 =?us-ascii?Q?FpfxEeMAg1QCT1fXF98DGS2NmYsaz1xKU3xW6yOjfd7NCU0MIIqGUfReJXaX?=
 =?us-ascii?Q?jdYv5UH/8QM33pRwoAT6Mnh/o1+FpjKDLpwsdvvPYG2oOyVUfsxa0vz/61HQ?=
 =?us-ascii?Q?yYoWl/5iE0KoR6MF5bUtJeQYqNFBWR9BBgMh3YTESisgul+9JJXcCUP336TH?=
 =?us-ascii?Q?YcIiHF5Cpg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5ec80f-e450-4454-534f-08de8332b3c5
X-MS-Exchange-CrossTenant-AuthSource: GV4PR04MB11901.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 08:04:52.2825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nn1097W00INsyUZuAT7PaSIOCNwkZKn3xmi7ttar7VvUFOBXg/hO/Hnoynx4d0TIiRnFwClPjBczKNl1I26ULg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10128
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

Supported platforms: iMX94, iMX95, .. (using OEI)
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
index a8e3f7354c7..d2afbe59ffb 100644
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
+	u32 crc;		  /* Used for ensuring integrity in DRAM */
+#define MAC_LENGTH              8 /* 256 bits, 32-bit aligned */
+	u32 mac[MAC_LENGTH];	  /* For 95A0/1 use mac[0] to keep CRC32 value */
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
index 00000000000..9987c57b16a
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
+#endif /* DM_MMC && MMC_WRITE */
+#if CONFIG_IS_ENABLED(SPI)
+#define QB_SPI_EN	1
+#endif /* SPI */
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
+			/* Image entry pointing to DDR Training Data */
+			(*qb_data_off) = img_entry->offset;
+			return 0;
+		}
+
+		img_end = img_entry->offset + img_entry->size;
+		if (i + 1 < phdr->num_images) {
+			img_entry++;
+			if (img_end + QB_STATE_LOAD_SIZE == img_entry->offset) {
+				/* hole detected */
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
+#endif /* QB_MMC_EN */
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
+#endif /* QB_SPI_EN */
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
+		/* Select the partition */
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
+		/* QB data is stored in DDR -> can use it as buf */
+		buf = (void *)CONFIG_SAVED_QB_STATE_BASE;
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
+	ret = (ret > 0) ? 0 : -1;
+
+	/* Return to original partition */
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
+#endif /* QB_MMC_EN */
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
+		/* QB data is stored in DDR -> can use it as buf */
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
+#endif /* QB_SPI_EN */
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

