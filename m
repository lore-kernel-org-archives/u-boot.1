Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 617FBE77188
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 01:50:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 502208062B;
	Mon, 23 Dec 2024 02:50:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bTmlS03X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9721880642; Mon, 23 Dec 2024 02:50:18 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7EBE803A9
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 02:50:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ij+cnHIyH2xURfCsIOsH75mY/SeaVMUPTG299rM4GNJ78oZEcUuROQJlIgJxuS1oHo1o5h+Z8b7PP6P+RE4GzQtGGY8CJ8krDAyeQXtQGatWmTeNUlwOsRbw1YiRqhRTxTxE5fGKE+ZcwKd+ugqxgkpVv/6ETquCUhfWWNvnkXXpE4wuxS+7zWtycFZ96BnMPs6EnQ83gX5ODoCXvoiPI3QR4VjFCStYCFjR6gSNWyAXJ0cPJ8pFCaoojjqS5mfz7uBQgGxXR61oJrUuBzSgYXALyXooa5vzkhc2LFm0YFt1Gie0BOSWP/GM71p4P92Jd2/yl+/RAsIPVfWsUxFWMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBtXU404BI1mm5aZRrxaeJNB5/UGgNhDaRmlWaHqGi8=;
 b=SCHzcKqX+lnsOIug2HjYieUOXP7JcIRqmSWw2KjpJB3Te/eJkj7rv8jSgBFa7jl/Rx+Qseqdj9Lg5w6Mi3ZBHR7TdPLEeoVmfGxJAHM7XAmuMGOgrz/txbRhGPOI2RV6F1c6HQkcvv6V3jT1BSsJU5B59yVR2YocNnEwHrPd+GVuS080JbJmLmi9PQSoS0ZeyFpsTTcJJDwuF8d96fWSHVUYKn7W85IEM1C31wO6dffQ+OjAu/p0f7ToEH/+xoOPWFVyu2scoDQPUyN6fXgvzdGKUzT0iOKL87/T0tHQeXN/cgL1CsLeu2rZUHvJ8TDwV3ibL6zcfnyj1lvAd2xWNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBtXU404BI1mm5aZRrxaeJNB5/UGgNhDaRmlWaHqGi8=;
 b=bTmlS03XlEsR1jTFZkJ39O18VB23Tk7A+ZTlsEFDiNQ+Lo9qTC/qPS+c0MqjaPv0GdvMorKWldE7iV7Yf/m6v6bUT8sCiH0csJ2N5APEddWiqp93h83oH0qs6czRfytciqoaOyOi3HOHPCx88qLDVPmhEyuEZs9LXn8e4ECWsC0WlV3NRBzaa0k3FFvLgojFMRKp/5D2ZyVU+WA7OQURd8mkfo18q4UTa6VO2mltIgTPdmJGZcXfbt4bAVTU2hiPX01XLF1jPHUlweDE1r9Er1tPlqaXIJFtAa5O3mM0e82x6HTPfmt8jh2iglA2zoLActCPH1Cf5aN0OlyOI7LeEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI2PR04MB10666.eurprd04.prod.outlook.com (2603:10a6:800:27f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.19; Mon, 23 Dec
 2024 01:50:09 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 01:50:09 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com,
	sbabic@denx.de
Cc: uboot-imx@nxp.com,
	u-boot@lists.denx.de,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] imx: Use per board ddrphy_trained_csr
Date: Mon, 23 Dec 2024 10:55:36 +0800
Message-Id: <20241223025536.18588-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI2PR04MB10666:EE_
X-MS-Office365-Filtering-Correlation-Id: ee32f84f-f650-4850-bafe-08dd22f421db
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dIzQNES+43B3qQhTViCcK/3UPQlEq8Pl7lvqNw/P4j2gzkxz5fVVobTBQiwH?=
 =?us-ascii?Q?AmUyceoJkY/Tx0EUzNJLDETsYP+Rkbs1F0cCQzd5gu7TloV/iDSG/0SGxf6Y?=
 =?us-ascii?Q?oHJP7ecHHoVPJLaAZ6m96P4pAHTGItL4mTzZ4HSfT0K5KMVeVRufLfYYiE8c?=
 =?us-ascii?Q?pVbw/UI6Xm9SP5DiU7UrzOh1dQX3twhETFywTm62zvSrSgHcQZCci1qOJQjh?=
 =?us-ascii?Q?yBMptHOEAbKiDWunCWPc3BoZSzBiTRH6x90B+nZoH5OHcsR5SodW7s6i3bjq?=
 =?us-ascii?Q?u2uneenapiQ/3PMRyPEQ16ZSv82+qmTwpg+R2Q23B9oBD69HyTVxOt5491ht?=
 =?us-ascii?Q?cZQsQd2YKSJ6lgLcVsopQOkQ22B+Zpx2ZdRY4blNOiKok+irnDZmHBdhoFv8?=
 =?us-ascii?Q?Tb72wRXWS02WQmGoSq0K2NZoeh4X4S5uxgLsVYnxUlvVMCUSfoWzdZ0VDd6n?=
 =?us-ascii?Q?oxYLlDmBqWfE0PwrMXkye1tdbo73iWOb0SxS5DoNEm1/G+zhKEIxPjwpCEQV?=
 =?us-ascii?Q?veOeDML1j15w77JRGxt0vpuLUiIX6hThErn6q6l2fSLphIKWCq+R9WXLdt8e?=
 =?us-ascii?Q?P+/g+j7wDDBvl4O3ldAJpL8URcKTxDxml/OL+nsbbQ7EfKn6XVGknUO8WJae?=
 =?us-ascii?Q?NkhxLsmOZOO/zszeasqQWGJpSbbuudupHIrsbrXCQ/7i8g37VdyRrM/vnpPY?=
 =?us-ascii?Q?7WCZHhrMj1pu+Xouy5ZW8ja5QeoeE6MxuM9GlcYoBqqxVyDZfjgRWkpAxRcu?=
 =?us-ascii?Q?o80MIPPXwo35pDGmsagJMiN4Y84owzA/anmJTYSlwp+jEYrXXyOwFsFdOyi1?=
 =?us-ascii?Q?YTxSb2lb07iPgdqmbL6fYjtjG5ZgUDAPqj0zhrWgU5W4MzIh2sKCxtDXH4cz?=
 =?us-ascii?Q?dgtJj24p2trUJtdAvFrkW3u9d+cjDb7HMibZ5aOGotVAQWCGHJ240hwXuaQQ?=
 =?us-ascii?Q?Yw1xJQTwdUdetc13IPhOuUAYtHp8y+iedcNyHnxq2ipLHIRVKjv6V0eDMda4?=
 =?us-ascii?Q?OGZM0qHhR/xP59WtLRnbD/lS2vOc9kMiu5A4kf+FrvNW7BN7UWzHTghQePQC?=
 =?us-ascii?Q?gn1YeATNYhRA3F9s+R2hi1FziYFFPUdGulRHOW14JIUJSEUvOr/A8TAy81d+?=
 =?us-ascii?Q?NkH1b7croSzAs6H33w+OAxutSyqZDodb7f6qWPIocQbmpQLy9a2sWzPQgwBa?=
 =?us-ascii?Q?Tr4soTAj70rKZX2zlR2vufX6rHWt3/ViLM10NJCTAkYp/2kuiu8qMWPkdfPp?=
 =?us-ascii?Q?oUlhmnYrMmX8ZwO8E84mZsO6t8dfZeNFLz5yhVLi9Rk+zNgyDbONEjnDRDjI?=
 =?us-ascii?Q?X4bfRRvoOykz3jMyL6RQQGRM8NLaWRguVCm8A2ZFiUIQOMDumBv+Q9ZUzygp?=
 =?us-ascii?Q?PZ8kVlR7Lb3e8idxx0zlvPmE1dPN22ufE2bEX7IOjPdRC6mz0XfkRbVU06nF?=
 =?us-ascii?Q?pOHydO/2cRttWQMx7jSU/qp6vTX4D6Kw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?26X3qRUaCLK+xL+e+/NhkcNXkECKihW1bqutZvYt182bdI1p/j6cycnYOHHK?=
 =?us-ascii?Q?s0vz/Xsx7N2noiJPcGxJNxWdFkMrjVq98jPzI6h0raQTBfOdDVLgOXuYiUm9?=
 =?us-ascii?Q?trK0OsGTrFXeOtg2wsQI4BmGnI5UKsnOafpaa6q3rGvQeC2z10A8/rgxz7vg?=
 =?us-ascii?Q?IR6Q79WD0qsSKq/e5HlG8PapptXrJFHkySVSRDbTJMD3Kf+28/9U0f9Zmt1X?=
 =?us-ascii?Q?/q+6TJReU870itMFWFGJEBFAfujvdqZ4rzhDEHmyJziEB3lipNsY9z6UZUiN?=
 =?us-ascii?Q?G3GjmKpfselsFYCbSJvfMyjfeIZh1SYlqjjo3r6tw8tNtCcfg8YY5JMXbRry?=
 =?us-ascii?Q?Xy6VhwhRVjyaKluhGhMphbMibn0SLHRk3KxEBuLzMYewyuXrkCf7dgbdByd+?=
 =?us-ascii?Q?uSJ/RwX9ysiQc9XxRdmIRQOuzxExs+ZJVbDilLC+D+1ZCoA3+kCcMg6sLlGe?=
 =?us-ascii?Q?rTSBwFRJfrj9FsglqK1YgOxEinoej2boY5XtIsXDpQSASrqp5dBtO9niMRR7?=
 =?us-ascii?Q?mr3BZ0Oj1z+bmeey/9B5LCXalAVYQWleYZs28NnGVW/hWHyw3jAGnBP2QMdC?=
 =?us-ascii?Q?91X5FeG4UQWnBvRUn14c/lZL/UF7SwikJMP/XxTgSAJ3lQi1LY9ZWxSEOK1F?=
 =?us-ascii?Q?eE8UUvnuykA0GNjnz0xsPnTzkBlx4gZyg+gpPxQmWg8sj+0K08pW1x8jwnzk?=
 =?us-ascii?Q?X7f5X6ixQu+7RVV4c73B/+W6+qteyFpIEv76ZxlfAJ0I3sbbxVFRiGI6NWud?=
 =?us-ascii?Q?YjgN+itVN35k+ZjiLilVSaKaSeJDQ7ZmSsY4JdYqTM2KuiYqNwqYRskSBzks?=
 =?us-ascii?Q?guoKiFkY86Mz4FdTt0o0ySfpPb8UNoG13EH3SNYyWuF1VGowWkIJRFc3UUoP?=
 =?us-ascii?Q?ANhDdpqCe1z3by5jVccCBbPua0ipND4vDdjcr5aPlj5t9xQstGtbJIhnjQ8X?=
 =?us-ascii?Q?30ZuXm6w7hBlGWTs/+lR8FhgcohqU6yzAgveK7KVBa+hrocg02lOZgyk9sYq?=
 =?us-ascii?Q?V9DHp8II6LFI1WcCAflytgRmcjM8k9/UhEfQG+d+SnwLLTqlRtEkqbwm9RoT?=
 =?us-ascii?Q?20JrTpbHVI6yJ6Ig04bEjvlyi3fMLDdfSSr9lhaLZsagrzVb0bg0jmt1BV8t?=
 =?us-ascii?Q?wPVK7DammJeYbaAH9tZPxP5mXhOfP9In09UxzldHrNsuopCODUgGKvGPSR7i?=
 =?us-ascii?Q?ckR06k5P0uzgViGyPZNdAz4xzl1UJtIxO0Vv6sYmVKyKb+0OHYJnPLF8flSk?=
 =?us-ascii?Q?VN1CrA4jFS0b+6KOy5OsfF7DnoQ0pRhnVt5Sdl/ZhV50Uq8E0PAlAFEwiz9a?=
 =?us-ascii?Q?i4TSTHbUHdxejbAYXLFqSMNa2MDKqbmXqu7f2Kzo+7TV0t2H6v8txJQiGVtl?=
 =?us-ascii?Q?HP2Ctg1xHuiN1NtzZlEPC+T2hG2LojL4DnfcDVcAt5PoVkzbquuQ+0eo1u6/?=
 =?us-ascii?Q?K3rmohyOgNg2KTm5hTMyomPrJ7Q9UfaaQF9CJ+9DGoZyBWzWBrHewICVd+82?=
 =?us-ascii?Q?gs1QlBKu3qmjQRMBq3r4l4zmApO1LUrXdw8DisMGSIhPoFwnoAdvQKo2teXL?=
 =?us-ascii?Q?IenIATDBD5Js1+p5y6xsSXkcNNwhBCOecTXJrat5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee32f84f-f650-4850-bafe-08dd22f421db
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 01:50:09.7262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3UomARAoWlR36FIm9/3W1FLJslE+L9XmfS9Etytu+Sw8cJfU4PcVZ+FU+QdmsA/EQ6+oxshbUwOAEnDg9GW5Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10666
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

Drop global ddrphy_trained_csr which maybe different with per board
ddrphy_trained_csr. DDR TOOL generates ddrphy_trained_csr for each
board, using the global ddrphy_trained_csr has risk that values may
be not up to date.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/arch-imx8m/ddr.h |   3 -
 arch/arm/include/asm/arch-imx9/ddr.h  |   3 -
 drivers/ddr/imx/phy/Makefile          |   2 +-
 drivers/ddr/imx/phy/ddrphy_csr.c      | 732 --------------------------
 drivers/ddr/imx/phy/ddrphy_train.c    |   3 +-
 drivers/ddr/imx/phy/helper.c          |   8 +-
 6 files changed, 7 insertions(+), 744 deletions(-)
 delete mode 100644 drivers/ddr/imx/phy/ddrphy_csr.c

diff --git a/arch/arm/include/asm/arch-imx8m/ddr.h b/arch/arm/include/asm/arch-imx8m/ddr.h
index 1f81d91977c..5092ccae188 100644
--- a/arch/arm/include/asm/arch-imx8m/ddr.h
+++ b/arch/arm/include/asm/arch-imx8m/ddr.h
@@ -747,7 +747,4 @@ static inline void reg32setbit(unsigned long addr, u32 bit)
 #define dwc_ddrphy_apb_rd(addr) \
 	reg32_read(IP2APB_DDRPHY_IPS_BASE_ADDR(0) + ddrphy_addr_remap(addr))
 
-extern struct dram_cfg_param ddrphy_trained_csr[];
-extern uint32_t ddrphy_trained_csr_num;
-
 #endif
diff --git a/arch/arm/include/asm/arch-imx9/ddr.h b/arch/arm/include/asm/arch-imx9/ddr.h
index 2b22f3a5bea..0dd2d62b9ef 100644
--- a/arch/arm/include/asm/arch-imx9/ddr.h
+++ b/arch/arm/include/asm/arch-imx9/ddr.h
@@ -141,7 +141,4 @@ static inline void reg32setbit(unsigned long addr, u32 bit)
 #define dwc_ddrphy_apb_rd(addr) \
 	reg32_read(IP2APB_DDRPHY_IPS_BASE_ADDR(0) + ddrphy_addr_remap(addr))
 
-extern struct dram_cfg_param ddrphy_trained_csr[];
-extern u32 ddrphy_trained_csr_num;
-
 #endif
diff --git a/drivers/ddr/imx/phy/Makefile b/drivers/ddr/imx/phy/Makefile
index 592d0c6ebad..95c93ba16d5 100644
--- a/drivers/ddr/imx/phy/Makefile
+++ b/drivers/ddr/imx/phy/Makefile
@@ -5,5 +5,5 @@
 #
 
 ifdef CONFIG_XPL_BUILD
-obj-$(CONFIG_IMX_SNPS_DDR_PHY) += helper.o ddrphy_utils.o ddrphy_train.o ddrphy_csr.o
+obj-$(CONFIG_IMX_SNPS_DDR_PHY) += helper.o ddrphy_utils.o ddrphy_train.o
 endif
diff --git a/drivers/ddr/imx/phy/ddrphy_csr.c b/drivers/ddr/imx/phy/ddrphy_csr.c
deleted file mode 100644
index 67dd4e7059f..00000000000
--- a/drivers/ddr/imx/phy/ddrphy_csr.c
+++ /dev/null
@@ -1,732 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2018 NXP
- */
-
-#include <linux/kernel.h>
-#include <asm/arch/ddr.h>
-
-/* ddr phy trained csr */
-struct dram_cfg_param ddrphy_trained_csr[] = {
-	{ 0x200b2, 0x0 },
-	{ 0x1200b2, 0x0 },
-	{ 0x2200b2, 0x0 },
-	{ 0x200cb, 0x0 },
-	{ 0x10043, 0x0 },
-	{ 0x110043, 0x0 },
-	{ 0x210043, 0x0 },
-	{ 0x10143, 0x0 },
-	{ 0x110143, 0x0 },
-	{ 0x210143, 0x0 },
-	{ 0x11043, 0x0 },
-	{ 0x111043, 0x0 },
-	{ 0x211043, 0x0 },
-	{ 0x11143, 0x0 },
-	{ 0x111143, 0x0 },
-	{ 0x211143, 0x0 },
-	{ 0x12043, 0x0 },
-	{ 0x112043, 0x0 },
-	{ 0x212043, 0x0 },
-	{ 0x12143, 0x0 },
-	{ 0x112143, 0x0 },
-	{ 0x212143, 0x0 },
-	{ 0x13043, 0x0 },
-	{ 0x113043, 0x0 },
-	{ 0x213043, 0x0 },
-	{ 0x13143, 0x0 },
-	{ 0x113143, 0x0 },
-	{ 0x213143, 0x0 },
-	{ 0x80, 0x0 },
-	{ 0x100080, 0x0 },
-	{ 0x200080, 0x0 },
-	{ 0x1080, 0x0 },
-	{ 0x101080, 0x0 },
-	{ 0x201080, 0x0 },
-	{ 0x2080, 0x0 },
-	{ 0x102080, 0x0 },
-	{ 0x202080, 0x0 },
-	{ 0x3080, 0x0 },
-	{ 0x103080, 0x0 },
-	{ 0x203080, 0x0 },
-	{ 0x4080, 0x0 },
-	{ 0x104080, 0x0 },
-	{ 0x204080, 0x0 },
-	{ 0x5080, 0x0 },
-	{ 0x105080, 0x0 },
-	{ 0x205080, 0x0 },
-	{ 0x6080, 0x0 },
-	{ 0x106080, 0x0 },
-	{ 0x206080, 0x0 },
-	{ 0x7080, 0x0 },
-	{ 0x107080, 0x0 },
-	{ 0x207080, 0x0 },
-	{ 0x8080, 0x0 },
-	{ 0x108080, 0x0 },
-	{ 0x208080, 0x0 },
-	{ 0x9080, 0x0 },
-	{ 0x109080, 0x0 },
-	{ 0x209080, 0x0 },
-	{ 0x10080, 0x0 },
-	{ 0x110080, 0x0 },
-	{ 0x210080, 0x0 },
-	{ 0x10180, 0x0 },
-	{ 0x110180, 0x0 },
-	{ 0x210180, 0x0 },
-	{ 0x11080, 0x0 },
-	{ 0x111080, 0x0 },
-	{ 0x211080, 0x0 },
-	{ 0x11180, 0x0 },
-	{ 0x111180, 0x0 },
-	{ 0x211180, 0x0 },
-	{ 0x12080, 0x0 },
-	{ 0x112080, 0x0 },
-	{ 0x212080, 0x0 },
-	{ 0x12180, 0x0 },
-	{ 0x112180, 0x0 },
-	{ 0x212180, 0x0 },
-	{ 0x13080, 0x0 },
-	{ 0x113080, 0x0 },
-	{ 0x213080, 0x0 },
-	{ 0x13180, 0x0 },
-	{ 0x113180, 0x0 },
-	{ 0x213180, 0x0 },
-	{ 0x10081, 0x0 },
-	{ 0x110081, 0x0 },
-	{ 0x210081, 0x0 },
-	{ 0x10181, 0x0 },
-	{ 0x110181, 0x0 },
-	{ 0x210181, 0x0 },
-	{ 0x11081, 0x0 },
-	{ 0x111081, 0x0 },
-	{ 0x211081, 0x0 },
-	{ 0x11181, 0x0 },
-	{ 0x111181, 0x0 },
-	{ 0x211181, 0x0 },
-	{ 0x12081, 0x0 },
-	{ 0x112081, 0x0 },
-	{ 0x212081, 0x0 },
-	{ 0x12181, 0x0 },
-	{ 0x112181, 0x0 },
-	{ 0x212181, 0x0 },
-	{ 0x13081, 0x0 },
-	{ 0x113081, 0x0 },
-	{ 0x213081, 0x0 },
-	{ 0x13181, 0x0 },
-	{ 0x113181, 0x0 },
-	{ 0x213181, 0x0 },
-	{ 0x100d0, 0x0 },
-	{ 0x1100d0, 0x0 },
-	{ 0x2100d0, 0x0 },
-	{ 0x101d0, 0x0 },
-	{ 0x1101d0, 0x0 },
-	{ 0x2101d0, 0x0 },
-	{ 0x110d0, 0x0 },
-	{ 0x1110d0, 0x0 },
-	{ 0x2110d0, 0x0 },
-	{ 0x111d0, 0x0 },
-	{ 0x1111d0, 0x0 },
-	{ 0x2111d0, 0x0 },
-	{ 0x120d0, 0x0 },
-	{ 0x1120d0, 0x0 },
-	{ 0x2120d0, 0x0 },
-	{ 0x121d0, 0x0 },
-	{ 0x1121d0, 0x0 },
-	{ 0x2121d0, 0x0 },
-	{ 0x130d0, 0x0 },
-	{ 0x1130d0, 0x0 },
-	{ 0x2130d0, 0x0 },
-	{ 0x131d0, 0x0 },
-	{ 0x1131d0, 0x0 },
-	{ 0x2131d0, 0x0 },
-	{ 0x100d1, 0x0 },
-	{ 0x1100d1, 0x0 },
-	{ 0x2100d1, 0x0 },
-	{ 0x101d1, 0x0 },
-	{ 0x1101d1, 0x0 },
-	{ 0x2101d1, 0x0 },
-	{ 0x110d1, 0x0 },
-	{ 0x1110d1, 0x0 },
-	{ 0x2110d1, 0x0 },
-	{ 0x111d1, 0x0 },
-	{ 0x1111d1, 0x0 },
-	{ 0x2111d1, 0x0 },
-	{ 0x120d1, 0x0 },
-	{ 0x1120d1, 0x0 },
-	{ 0x2120d1, 0x0 },
-	{ 0x121d1, 0x0 },
-	{ 0x1121d1, 0x0 },
-	{ 0x2121d1, 0x0 },
-	{ 0x130d1, 0x0 },
-	{ 0x1130d1, 0x0 },
-	{ 0x2130d1, 0x0 },
-	{ 0x131d1, 0x0 },
-	{ 0x1131d1, 0x0 },
-	{ 0x2131d1, 0x0 },
-	{ 0x10068, 0x0 },
-	{ 0x10168, 0x0 },
-	{ 0x10268, 0x0 },
-	{ 0x10368, 0x0 },
-	{ 0x10468, 0x0 },
-	{ 0x10568, 0x0 },
-	{ 0x10668, 0x0 },
-	{ 0x10768, 0x0 },
-	{ 0x10868, 0x0 },
-	{ 0x11068, 0x0 },
-	{ 0x11168, 0x0 },
-	{ 0x11268, 0x0 },
-	{ 0x11368, 0x0 },
-	{ 0x11468, 0x0 },
-	{ 0x11568, 0x0 },
-	{ 0x11668, 0x0 },
-	{ 0x11768, 0x0 },
-	{ 0x11868, 0x0 },
-	{ 0x12068, 0x0 },
-	{ 0x12168, 0x0 },
-	{ 0x12268, 0x0 },
-	{ 0x12368, 0x0 },
-	{ 0x12468, 0x0 },
-	{ 0x12568, 0x0 },
-	{ 0x12668, 0x0 },
-	{ 0x12768, 0x0 },
-	{ 0x12868, 0x0 },
-	{ 0x13068, 0x0 },
-	{ 0x13168, 0x0 },
-	{ 0x13268, 0x0 },
-	{ 0x13368, 0x0 },
-	{ 0x13468, 0x0 },
-	{ 0x13568, 0x0 },
-	{ 0x13668, 0x0 },
-	{ 0x13768, 0x0 },
-	{ 0x13868, 0x0 },
-	{ 0x10069, 0x0 },
-	{ 0x10169, 0x0 },
-	{ 0x10269, 0x0 },
-	{ 0x10369, 0x0 },
-	{ 0x10469, 0x0 },
-	{ 0x10569, 0x0 },
-	{ 0x10669, 0x0 },
-	{ 0x10769, 0x0 },
-	{ 0x10869, 0x0 },
-	{ 0x11069, 0x0 },
-	{ 0x11169, 0x0 },
-	{ 0x11269, 0x0 },
-	{ 0x11369, 0x0 },
-	{ 0x11469, 0x0 },
-	{ 0x11569, 0x0 },
-	{ 0x11669, 0x0 },
-	{ 0x11769, 0x0 },
-	{ 0x11869, 0x0 },
-	{ 0x12069, 0x0 },
-	{ 0x12169, 0x0 },
-	{ 0x12269, 0x0 },
-	{ 0x12369, 0x0 },
-	{ 0x12469, 0x0 },
-	{ 0x12569, 0x0 },
-	{ 0x12669, 0x0 },
-	{ 0x12769, 0x0 },
-	{ 0x12869, 0x0 },
-	{ 0x13069, 0x0 },
-	{ 0x13169, 0x0 },
-	{ 0x13269, 0x0 },
-	{ 0x13369, 0x0 },
-	{ 0x13469, 0x0 },
-	{ 0x13569, 0x0 },
-	{ 0x13669, 0x0 },
-	{ 0x13769, 0x0 },
-	{ 0x13869, 0x0 },
-	{ 0x1008c, 0x0 },
-	{ 0x11008c, 0x0 },
-	{ 0x21008c, 0x0 },
-	{ 0x1018c, 0x0 },
-	{ 0x11018c, 0x0 },
-	{ 0x21018c, 0x0 },
-	{ 0x1108c, 0x0 },
-	{ 0x11108c, 0x0 },
-	{ 0x21108c, 0x0 },
-	{ 0x1118c, 0x0 },
-	{ 0x11118c, 0x0 },
-	{ 0x21118c, 0x0 },
-	{ 0x1208c, 0x0 },
-	{ 0x11208c, 0x0 },
-	{ 0x21208c, 0x0 },
-	{ 0x1218c, 0x0 },
-	{ 0x11218c, 0x0 },
-	{ 0x21218c, 0x0 },
-	{ 0x1308c, 0x0 },
-	{ 0x11308c, 0x0 },
-	{ 0x21308c, 0x0 },
-	{ 0x1318c, 0x0 },
-	{ 0x11318c, 0x0 },
-	{ 0x21318c, 0x0 },
-	{ 0x1008d, 0x0 },
-	{ 0x11008d, 0x0 },
-	{ 0x21008d, 0x0 },
-	{ 0x1018d, 0x0 },
-	{ 0x11018d, 0x0 },
-	{ 0x21018d, 0x0 },
-	{ 0x1108d, 0x0 },
-	{ 0x11108d, 0x0 },
-	{ 0x21108d, 0x0 },
-	{ 0x1118d, 0x0 },
-	{ 0x11118d, 0x0 },
-	{ 0x21118d, 0x0 },
-	{ 0x1208d, 0x0 },
-	{ 0x11208d, 0x0 },
-	{ 0x21208d, 0x0 },
-	{ 0x1218d, 0x0 },
-	{ 0x11218d, 0x0 },
-	{ 0x21218d, 0x0 },
-	{ 0x1308d, 0x0 },
-	{ 0x11308d, 0x0 },
-	{ 0x21308d, 0x0 },
-	{ 0x1318d, 0x0 },
-	{ 0x11318d, 0x0 },
-	{ 0x21318d, 0x0 },
-	{ 0x100c0, 0x0 },
-	{ 0x1100c0, 0x0 },
-	{ 0x2100c0, 0x0 },
-	{ 0x101c0, 0x0 },
-	{ 0x1101c0, 0x0 },
-	{ 0x2101c0, 0x0 },
-	{ 0x102c0, 0x0 },
-	{ 0x1102c0, 0x0 },
-	{ 0x2102c0, 0x0 },
-	{ 0x103c0, 0x0 },
-	{ 0x1103c0, 0x0 },
-	{ 0x2103c0, 0x0 },
-	{ 0x104c0, 0x0 },
-	{ 0x1104c0, 0x0 },
-	{ 0x2104c0, 0x0 },
-	{ 0x105c0, 0x0 },
-	{ 0x1105c0, 0x0 },
-	{ 0x2105c0, 0x0 },
-	{ 0x106c0, 0x0 },
-	{ 0x1106c0, 0x0 },
-	{ 0x2106c0, 0x0 },
-	{ 0x107c0, 0x0 },
-	{ 0x1107c0, 0x0 },
-	{ 0x2107c0, 0x0 },
-	{ 0x108c0, 0x0 },
-	{ 0x1108c0, 0x0 },
-	{ 0x2108c0, 0x0 },
-	{ 0x110c0, 0x0 },
-	{ 0x1110c0, 0x0 },
-	{ 0x2110c0, 0x0 },
-	{ 0x111c0, 0x0 },
-	{ 0x1111c0, 0x0 },
-	{ 0x2111c0, 0x0 },
-	{ 0x112c0, 0x0 },
-	{ 0x1112c0, 0x0 },
-	{ 0x2112c0, 0x0 },
-	{ 0x113c0, 0x0 },
-	{ 0x1113c0, 0x0 },
-	{ 0x2113c0, 0x0 },
-	{ 0x114c0, 0x0 },
-	{ 0x1114c0, 0x0 },
-	{ 0x2114c0, 0x0 },
-	{ 0x115c0, 0x0 },
-	{ 0x1115c0, 0x0 },
-	{ 0x2115c0, 0x0 },
-	{ 0x116c0, 0x0 },
-	{ 0x1116c0, 0x0 },
-	{ 0x2116c0, 0x0 },
-	{ 0x117c0, 0x0 },
-	{ 0x1117c0, 0x0 },
-	{ 0x2117c0, 0x0 },
-	{ 0x118c0, 0x0 },
-	{ 0x1118c0, 0x0 },
-	{ 0x2118c0, 0x0 },
-	{ 0x120c0, 0x0 },
-	{ 0x1120c0, 0x0 },
-	{ 0x2120c0, 0x0 },
-	{ 0x121c0, 0x0 },
-	{ 0x1121c0, 0x0 },
-	{ 0x2121c0, 0x0 },
-	{ 0x122c0, 0x0 },
-	{ 0x1122c0, 0x0 },
-	{ 0x2122c0, 0x0 },
-	{ 0x123c0, 0x0 },
-	{ 0x1123c0, 0x0 },
-	{ 0x2123c0, 0x0 },
-	{ 0x124c0, 0x0 },
-	{ 0x1124c0, 0x0 },
-	{ 0x2124c0, 0x0 },
-	{ 0x125c0, 0x0 },
-	{ 0x1125c0, 0x0 },
-	{ 0x2125c0, 0x0 },
-	{ 0x126c0, 0x0 },
-	{ 0x1126c0, 0x0 },
-	{ 0x2126c0, 0x0 },
-	{ 0x127c0, 0x0 },
-	{ 0x1127c0, 0x0 },
-	{ 0x2127c0, 0x0 },
-	{ 0x128c0, 0x0 },
-	{ 0x1128c0, 0x0 },
-	{ 0x2128c0, 0x0 },
-	{ 0x130c0, 0x0 },
-	{ 0x1130c0, 0x0 },
-	{ 0x2130c0, 0x0 },
-	{ 0x131c0, 0x0 },
-	{ 0x1131c0, 0x0 },
-	{ 0x2131c0, 0x0 },
-	{ 0x132c0, 0x0 },
-	{ 0x1132c0, 0x0 },
-	{ 0x2132c0, 0x0 },
-	{ 0x133c0, 0x0 },
-	{ 0x1133c0, 0x0 },
-	{ 0x2133c0, 0x0 },
-	{ 0x134c0, 0x0 },
-	{ 0x1134c0, 0x0 },
-	{ 0x2134c0, 0x0 },
-	{ 0x135c0, 0x0 },
-	{ 0x1135c0, 0x0 },
-	{ 0x2135c0, 0x0 },
-	{ 0x136c0, 0x0 },
-	{ 0x1136c0, 0x0 },
-	{ 0x2136c0, 0x0 },
-	{ 0x137c0, 0x0 },
-	{ 0x1137c0, 0x0 },
-	{ 0x2137c0, 0x0 },
-	{ 0x138c0, 0x0 },
-	{ 0x1138c0, 0x0 },
-	{ 0x2138c0, 0x0 },
-	{ 0x100c1, 0x0 },
-	{ 0x1100c1, 0x0 },
-	{ 0x2100c1, 0x0 },
-	{ 0x101c1, 0x0 },
-	{ 0x1101c1, 0x0 },
-	{ 0x2101c1, 0x0 },
-	{ 0x102c1, 0x0 },
-	{ 0x1102c1, 0x0 },
-	{ 0x2102c1, 0x0 },
-	{ 0x103c1, 0x0 },
-	{ 0x1103c1, 0x0 },
-	{ 0x2103c1, 0x0 },
-	{ 0x104c1, 0x0 },
-	{ 0x1104c1, 0x0 },
-	{ 0x2104c1, 0x0 },
-	{ 0x105c1, 0x0 },
-	{ 0x1105c1, 0x0 },
-	{ 0x2105c1, 0x0 },
-	{ 0x106c1, 0x0 },
-	{ 0x1106c1, 0x0 },
-	{ 0x2106c1, 0x0 },
-	{ 0x107c1, 0x0 },
-	{ 0x1107c1, 0x0 },
-	{ 0x2107c1, 0x0 },
-	{ 0x108c1, 0x0 },
-	{ 0x1108c1, 0x0 },
-	{ 0x2108c1, 0x0 },
-	{ 0x110c1, 0x0 },
-	{ 0x1110c1, 0x0 },
-	{ 0x2110c1, 0x0 },
-	{ 0x111c1, 0x0 },
-	{ 0x1111c1, 0x0 },
-	{ 0x2111c1, 0x0 },
-	{ 0x112c1, 0x0 },
-	{ 0x1112c1, 0x0 },
-	{ 0x2112c1, 0x0 },
-	{ 0x113c1, 0x0 },
-	{ 0x1113c1, 0x0 },
-	{ 0x2113c1, 0x0 },
-	{ 0x114c1, 0x0 },
-	{ 0x1114c1, 0x0 },
-	{ 0x2114c1, 0x0 },
-	{ 0x115c1, 0x0 },
-	{ 0x1115c1, 0x0 },
-	{ 0x2115c1, 0x0 },
-	{ 0x116c1, 0x0 },
-	{ 0x1116c1, 0x0 },
-	{ 0x2116c1, 0x0 },
-	{ 0x117c1, 0x0 },
-	{ 0x1117c1, 0x0 },
-	{ 0x2117c1, 0x0 },
-	{ 0x118c1, 0x0 },
-	{ 0x1118c1, 0x0 },
-	{ 0x2118c1, 0x0 },
-	{ 0x120c1, 0x0 },
-	{ 0x1120c1, 0x0 },
-	{ 0x2120c1, 0x0 },
-	{ 0x121c1, 0x0 },
-	{ 0x1121c1, 0x0 },
-	{ 0x2121c1, 0x0 },
-	{ 0x122c1, 0x0 },
-	{ 0x1122c1, 0x0 },
-	{ 0x2122c1, 0x0 },
-	{ 0x123c1, 0x0 },
-	{ 0x1123c1, 0x0 },
-	{ 0x2123c1, 0x0 },
-	{ 0x124c1, 0x0 },
-	{ 0x1124c1, 0x0 },
-	{ 0x2124c1, 0x0 },
-	{ 0x125c1, 0x0 },
-	{ 0x1125c1, 0x0 },
-	{ 0x2125c1, 0x0 },
-	{ 0x126c1, 0x0 },
-	{ 0x1126c1, 0x0 },
-	{ 0x2126c1, 0x0 },
-	{ 0x127c1, 0x0 },
-	{ 0x1127c1, 0x0 },
-	{ 0x2127c1, 0x0 },
-	{ 0x128c1, 0x0 },
-	{ 0x1128c1, 0x0 },
-	{ 0x2128c1, 0x0 },
-	{ 0x130c1, 0x0 },
-	{ 0x1130c1, 0x0 },
-	{ 0x2130c1, 0x0 },
-	{ 0x131c1, 0x0 },
-	{ 0x1131c1, 0x0 },
-	{ 0x2131c1, 0x0 },
-	{ 0x132c1, 0x0 },
-	{ 0x1132c1, 0x0 },
-	{ 0x2132c1, 0x0 },
-	{ 0x133c1, 0x0 },
-	{ 0x1133c1, 0x0 },
-	{ 0x2133c1, 0x0 },
-	{ 0x134c1, 0x0 },
-	{ 0x1134c1, 0x0 },
-	{ 0x2134c1, 0x0 },
-	{ 0x135c1, 0x0 },
-	{ 0x1135c1, 0x0 },
-	{ 0x2135c1, 0x0 },
-	{ 0x136c1, 0x0 },
-	{ 0x1136c1, 0x0 },
-	{ 0x2136c1, 0x0 },
-	{ 0x137c1, 0x0 },
-	{ 0x1137c1, 0x0 },
-	{ 0x2137c1, 0x0 },
-	{ 0x138c1, 0x0 },
-	{ 0x1138c1, 0x0 },
-	{ 0x2138c1, 0x0 },
-	{ 0x10020, 0x0 },
-	{ 0x110020, 0x0 },
-	{ 0x210020, 0x0 },
-	{ 0x11020, 0x0 },
-	{ 0x111020, 0x0 },
-	{ 0x211020, 0x0 },
-	{ 0x12020, 0x0 },
-	{ 0x112020, 0x0 },
-	{ 0x212020, 0x0 },
-	{ 0x13020, 0x0 },
-	{ 0x113020, 0x0 },
-	{ 0x213020, 0x0 },
-	{ 0x20072, 0x0 },
-	{ 0x20073, 0x0 },
-	{ 0x20074, 0x0 },
-	{ 0x100aa, 0x0 },
-	{ 0x110aa, 0x0 },
-	{ 0x120aa, 0x0 },
-	{ 0x130aa, 0x0 },
-	{ 0x20010, 0x0 },
-	{ 0x120010, 0x0 },
-	{ 0x220010, 0x0 },
-	{ 0x20011, 0x0 },
-	{ 0x120011, 0x0 },
-	{ 0x220011, 0x0 },
-	{ 0x100ae, 0x0 },
-	{ 0x1100ae, 0x0 },
-	{ 0x2100ae, 0x0 },
-	{ 0x100af, 0x0 },
-	{ 0x1100af, 0x0 },
-	{ 0x2100af, 0x0 },
-	{ 0x110ae, 0x0 },
-	{ 0x1110ae, 0x0 },
-	{ 0x2110ae, 0x0 },
-	{ 0x110af, 0x0 },
-	{ 0x1110af, 0x0 },
-	{ 0x2110af, 0x0 },
-	{ 0x120ae, 0x0 },
-	{ 0x1120ae, 0x0 },
-	{ 0x2120ae, 0x0 },
-	{ 0x120af, 0x0 },
-	{ 0x1120af, 0x0 },
-	{ 0x2120af, 0x0 },
-	{ 0x130ae, 0x0 },
-	{ 0x1130ae, 0x0 },
-	{ 0x2130ae, 0x0 },
-	{ 0x130af, 0x0 },
-	{ 0x1130af, 0x0 },
-	{ 0x2130af, 0x0 },
-	{ 0x20020, 0x0 },
-	{ 0x120020, 0x0 },
-	{ 0x220020, 0x0 },
-	{ 0x100a0, 0x0 },
-	{ 0x100a1, 0x0 },
-	{ 0x100a2, 0x0 },
-	{ 0x100a3, 0x0 },
-	{ 0x100a4, 0x0 },
-	{ 0x100a5, 0x0 },
-	{ 0x100a6, 0x0 },
-	{ 0x100a7, 0x0 },
-	{ 0x110a0, 0x0 },
-	{ 0x110a1, 0x0 },
-	{ 0x110a2, 0x0 },
-	{ 0x110a3, 0x0 },
-	{ 0x110a4, 0x0 },
-	{ 0x110a5, 0x0 },
-	{ 0x110a6, 0x0 },
-	{ 0x110a7, 0x0 },
-	{ 0x120a0, 0x0 },
-	{ 0x120a1, 0x0 },
-	{ 0x120a2, 0x0 },
-	{ 0x120a3, 0x0 },
-	{ 0x120a4, 0x0 },
-	{ 0x120a5, 0x0 },
-	{ 0x120a6, 0x0 },
-	{ 0x120a7, 0x0 },
-	{ 0x130a0, 0x0 },
-	{ 0x130a1, 0x0 },
-	{ 0x130a2, 0x0 },
-	{ 0x130a3, 0x0 },
-	{ 0x130a4, 0x0 },
-	{ 0x130a5, 0x0 },
-	{ 0x130a6, 0x0 },
-	{ 0x130a7, 0x0 },
-	{ 0x2007c, 0x0 },
-	{ 0x12007c, 0x0 },
-	{ 0x22007c, 0x0 },
-	{ 0x2007d, 0x0 },
-	{ 0x12007d, 0x0 },
-	{ 0x22007d, 0x0 },
-	{ 0x400fd, 0x0 },
-	{ 0x400c0, 0x0 },
-	{ 0x90201, 0x0 },
-	{ 0x190201, 0x0 },
-	{ 0x290201, 0x0 },
-	{ 0x90202, 0x0 },
-	{ 0x190202, 0x0 },
-	{ 0x290202, 0x0 },
-	{ 0x90203, 0x0 },
-	{ 0x190203, 0x0 },
-	{ 0x290203, 0x0 },
-	{ 0x90204, 0x0 },
-	{ 0x190204, 0x0 },
-	{ 0x290204, 0x0 },
-	{ 0x90205, 0x0 },
-	{ 0x190205, 0x0 },
-	{ 0x290205, 0x0 },
-	{ 0x90206, 0x0 },
-	{ 0x190206, 0x0 },
-	{ 0x290206, 0x0 },
-	{ 0x90207, 0x0 },
-	{ 0x190207, 0x0 },
-	{ 0x290207, 0x0 },
-	{ 0x90208, 0x0 },
-	{ 0x190208, 0x0 },
-	{ 0x290208, 0x0 },
-	{ 0x10062, 0x0 },
-	{ 0x10162, 0x0 },
-	{ 0x10262, 0x0 },
-	{ 0x10362, 0x0 },
-	{ 0x10462, 0x0 },
-	{ 0x10562, 0x0 },
-	{ 0x10662, 0x0 },
-	{ 0x10762, 0x0 },
-	{ 0x10862, 0x0 },
-	{ 0x11062, 0x0 },
-	{ 0x11162, 0x0 },
-	{ 0x11262, 0x0 },
-	{ 0x11362, 0x0 },
-	{ 0x11462, 0x0 },
-	{ 0x11562, 0x0 },
-	{ 0x11662, 0x0 },
-	{ 0x11762, 0x0 },
-	{ 0x11862, 0x0 },
-	{ 0x12062, 0x0 },
-	{ 0x12162, 0x0 },
-	{ 0x12262, 0x0 },
-	{ 0x12362, 0x0 },
-	{ 0x12462, 0x0 },
-	{ 0x12562, 0x0 },
-	{ 0x12662, 0x0 },
-	{ 0x12762, 0x0 },
-	{ 0x12862, 0x0 },
-	{ 0x13062, 0x0 },
-	{ 0x13162, 0x0 },
-	{ 0x13262, 0x0 },
-	{ 0x13362, 0x0 },
-	{ 0x13462, 0x0 },
-	{ 0x13562, 0x0 },
-	{ 0x13662, 0x0 },
-	{ 0x13762, 0x0 },
-	{ 0x13862, 0x0 },
-	{ 0x20077, 0x0 },
-	{ 0x10001, 0x0 },
-	{ 0x11001, 0x0 },
-	{ 0x12001, 0x0 },
-	{ 0x13001, 0x0 },
-	{ 0x10040, 0x0 },
-	{ 0x10140, 0x0 },
-	{ 0x10240, 0x0 },
-	{ 0x10340, 0x0 },
-	{ 0x10440, 0x0 },
-	{ 0x10540, 0x0 },
-	{ 0x10640, 0x0 },
-	{ 0x10740, 0x0 },
-	{ 0x10840, 0x0 },
-	{ 0x10030, 0x0 },
-	{ 0x10130, 0x0 },
-	{ 0x10230, 0x0 },
-	{ 0x10330, 0x0 },
-	{ 0x10430, 0x0 },
-	{ 0x10530, 0x0 },
-	{ 0x10630, 0x0 },
-	{ 0x10730, 0x0 },
-	{ 0x10830, 0x0 },
-	{ 0x11040, 0x0 },
-	{ 0x11140, 0x0 },
-	{ 0x11240, 0x0 },
-	{ 0x11340, 0x0 },
-	{ 0x11440, 0x0 },
-	{ 0x11540, 0x0 },
-	{ 0x11640, 0x0 },
-	{ 0x11740, 0x0 },
-	{ 0x11840, 0x0 },
-	{ 0x11030, 0x0 },
-	{ 0x11130, 0x0 },
-	{ 0x11230, 0x0 },
-	{ 0x11330, 0x0 },
-	{ 0x11430, 0x0 },
-	{ 0x11530, 0x0 },
-	{ 0x11630, 0x0 },
-	{ 0x11730, 0x0 },
-	{ 0x11830, 0x0 },
-	{ 0x12040, 0x0 },
-	{ 0x12140, 0x0 },
-	{ 0x12240, 0x0 },
-	{ 0x12340, 0x0 },
-	{ 0x12440, 0x0 },
-	{ 0x12540, 0x0 },
-	{ 0x12640, 0x0 },
-	{ 0x12740, 0x0 },
-	{ 0x12840, 0x0 },
-	{ 0x12030, 0x0 },
-	{ 0x12130, 0x0 },
-	{ 0x12230, 0x0 },
-	{ 0x12330, 0x0 },
-	{ 0x12430, 0x0 },
-	{ 0x12530, 0x0 },
-	{ 0x12630, 0x0 },
-	{ 0x12730, 0x0 },
-	{ 0x12830, 0x0 },
-	{ 0x13040, 0x0 },
-	{ 0x13140, 0x0 },
-	{ 0x13240, 0x0 },
-	{ 0x13340, 0x0 },
-	{ 0x13440, 0x0 },
-	{ 0x13540, 0x0 },
-	{ 0x13640, 0x0 },
-	{ 0x13740, 0x0 },
-	{ 0x13840, 0x0 },
-	{ 0x13030, 0x0 },
-	{ 0x13130, 0x0 },
-	{ 0x13230, 0x0 },
-	{ 0x13330, 0x0 },
-	{ 0x13430, 0x0 },
-	{ 0x13530, 0x0 },
-	{ 0x13630, 0x0 },
-	{ 0x13730, 0x0 },
-	{ 0x13830, 0x0 },
-};
-
-uint32_t ddrphy_trained_csr_num = ARRAY_SIZE(ddrphy_trained_csr);
diff --git a/drivers/ddr/imx/phy/ddrphy_train.c b/drivers/ddr/imx/phy/ddrphy_train.c
index 2a2161dec33..1a2d071d6f1 100644
--- a/drivers/ddr/imx/phy/ddrphy_train.c
+++ b/drivers/ddr/imx/phy/ddrphy_train.c
@@ -90,7 +90,8 @@ int ddr_cfg_phy(struct dram_timing_info *dram_timing)
 	}
 
 	/* save the ddr PHY trained CSR in memory for low power use */
-	ddrphy_trained_csr_save(ddrphy_trained_csr, ddrphy_trained_csr_num);
+	ddrphy_trained_csr_save(dram_timing->ddrphy_trained_csr,
+				dram_timing->ddrphy_trained_csr_num);
 
 	return 0;
 }
diff --git a/drivers/ddr/imx/phy/helper.c b/drivers/ddr/imx/phy/helper.c
index c1fc800f191..b0dfc3a0b4f 100644
--- a/drivers/ddr/imx/phy/helper.c
+++ b/drivers/ddr/imx/phy/helper.c
@@ -181,7 +181,7 @@ void *dram_config_save(struct dram_timing_info *timing_info, unsigned long saved
 
 	saved_timing->ddrc_cfg_num = timing_info->ddrc_cfg_num;
 	saved_timing->ddrphy_cfg_num = timing_info->ddrphy_cfg_num;
-	saved_timing->ddrphy_trained_csr_num = ddrphy_trained_csr_num;
+	saved_timing->ddrphy_trained_csr_num = timing_info->ddrphy_trained_csr_num;
 	saved_timing->ddrphy_pie_num = timing_info->ddrphy_pie_num;
 
 	/* save the fsp table */
@@ -209,9 +209,9 @@ void *dram_config_save(struct dram_timing_info *timing_info, unsigned long saved
 
 	/* save the ddrphy csr */
 	saved_timing->ddrphy_trained_csr = cfg;
-	for (i = 0; i < ddrphy_trained_csr_num; i++) {
-		cfg->reg = ddrphy_trained_csr[i].reg;
-		cfg->val = ddrphy_trained_csr[i].val;
+	for (i = 0; i < timing_info->ddrphy_trained_csr_num; i++) {
+		cfg->reg = timing_info->ddrphy_trained_csr[i].reg;
+		cfg->val = timing_info->ddrphy_trained_csr[i].val;
 		cfg++;
 	}
 
-- 
2.35.3

