Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14ACECD6E74
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 09:49:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2FA3848E2;
	Fri,  5 Jun 2026 11:49:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="ab82tdZ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 868ED848F5; Fri,  5 Jun 2026 11:49:02 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C98A0848DC
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 11:48:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FrU6mSweHUmKIUMuvDfd8uJE8ZkPtYTEDensUbcYCoK84JPNWXYSMK9h6Bu/D9dZAX78c7J1VCJc43/uLfiiNUFPxqBqkha28UYQKnlhK7uBbECmRcM1g1gHrVlC+Shvun+l5divI8oQEW1UfqyPRO74ZBiYwvJ6AqGfgNgc/3iQd1gfFkonhQ/jXJXJzU10zgH+ZgeNJ1Nx8+8dfaMUWwVioyQpy0Gw4SFIrjryHq093x4ZMEqXY9TJxM1U3StfKSdwhTk5EjxkL3KmhZNT/SI83qAuswUsDb6AmyWP0NuAVo7/xMCy291Q2NBJrrqYaAMopI3dDVNjSbjv7tdiHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uWO47NypctKwyevzBPrt4Mm8pwExw41hFISk3nbPCE=;
 b=WBOgXI2CVDirz1QoLIAmL2C/CDbxbNn6aj9FfnpHnnZe3dcChoMOwMIT5nZyOGhXctu7AqCFxuwoiICH+9RRChPk+DwlDQfutWSqSRJmBh5NX99djA/p4EuwN931V+/tqXmEfjaqy/W/qbzKEzjsuTd2oukHDosJGZ/soUq/tmEOqFb19Cw/3V5oLaNJxf4h+jyg7oNKIx8yA7kBSIs/QQss3t+OGodr45UEdbF+7MPS0t7Mmknv3SNcwz39cybljcQQBvY/5gLf6rdOtofZaiMH35EbtjwLe+rVwcopTNEAdxprgBnN9WdgSYaQUXlXpu3cobOu4DawElfW6EC7bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uWO47NypctKwyevzBPrt4Mm8pwExw41hFISk3nbPCE=;
 b=ab82tdZ+JJp9gvdYSCgo0eiY/JWaWhx1roru5DVK3vGCC86+tGP6Z/0lwjnmOTIw+LIynXYDu48tK3B1Fl5wW7jGXMhpb6/msdHkWxqBLieJXjZUToRdnhomBfBbkZ8W+7jYQmGkfFkerSgyeTOhTVvFzMcl4x01uCWhrAa+BFI/D8pIHprxRUyy66SYT9vX9ykGt5mcT44c2vXr4rgIjeX3n6255fW0rCzvHnNs9qIEyjqUf2xy1VJxUiSBti6DzpG5uyTWGlXTMuftwL6Sfgrjxgsx7/nL6kQFRGJSNlEqISGLNrVim3aJSC0Pur6vZ6BGJtUsuOIdwjTRvt6OZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV2PR04MB11760.eurprd04.prod.outlook.com (2603:10a6:150:2d1::6)
 by PAXPR04MB8333.eurprd04.prod.outlook.com (2603:10a6:102:1c0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 09:48:57 +0000
Received: from GV2PR04MB11760.eurprd04.prod.outlook.com
 ([fe80::4960:3035:f3de:c0d6]) by GV2PR04MB11760.eurprd04.prod.outlook.com
 ([fe80::4960:3035:f3de:c0d6%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 09:48:57 +0000
From: Ye Li <ye.li@nxp.com>
To: festevam@gmail.com,
	u-boot@lists.denx.de,
	peng.fan@nxp.com
Cc: uboot-imx@nxp.com,
	ye.li@oss.nxp.com
Subject: [PATCH resend 2/2] cpu: imx8_cpu: fix the mpidr check
Date: Fri,  5 Jun 2026 17:51:07 +0800
Message-ID: <20260605095108.3223321-2-ye.li@nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260605095108.3223321-1-ye.li@nxp.com>
References: <20260605095108.3223321-1-ye.li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0276.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21d::6) To GV2PR04MB11760.eurprd04.prod.outlook.com
 (2603:10a6:150:2d1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11760:EE_|PAXPR04MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: f3d371cc-d48c-4189-97d4-08dec2e7a95b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|19092799006|42112799006|1800799024|376014|11063799006|56012099006|38350700014|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 29qtEzJrL6AE6ZWu4XMp3DT20c4rTS9MXt1c3zDSWq1g3d+qkysdgZm8dNKSmM5Hi43/Y1AenULPCwDlRxRkyUMHh3FrDGiLfrNCQ0ujMzzZfuRMvANnUScooRJvRFqRWTc3Gj/IGFw7NKS6a1oW/ucqeZsAM+DyuzrAf2CMb4Sd57JRcqbK0D0lsGTtTUsHQCraWGfsXbv5U22ocTFJOqWhgNUCaJKJEJylmVT71W6MO3md/v1ONifIaX7NjSBG7V7dsX6F4pq4cwGD7LPDqkKqWxczlBFCLubM+jXOWB/byhX0HJ5c6mUoc87TykbgDYSOmxOcrIoLtxWAmssozK1TWXh5RVsl//nb4NJlPc/4L1i9Q+0q8RsGDPYHNHxaJq+rGyRa9W8gBNGhbSjYA0GuHXWWgCOADQd0bke1b0YEWVS5hr5LqzfJf+oyTJ1GaTPrHZjzBfAp5Pz7+SRj/6A5lCwH6Z6d6wevwNKZ8tBE7wfBh3M0idCa2ATLpk1e2iTZi9APDn7vTpsH5NO5f3Du3kR1OExKtetzBlwr5Pg6jB7aGNlnvV6oyKoTcglUAUxVoCiuVryqL+wCY5lCqKww0W8r0B3GwiGVSv2zv7sntS5GPIX6fkspZKpCJkPP1oyQMTZy28z0szEVSE0H/2VRrBevqBvjmFdp12e78N5uIZiZdT5iVbhuJI2oV/g8hGcNO3VGGZE9Rh1e9Z6DYYBkEeLv84Y0dNU3g/JTG66gmlyXHNJHJYeUVarofqvk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11760.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(19092799006)(42112799006)(1800799024)(376014)(11063799006)(56012099006)(38350700014)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yvYoibRHpbK6TJTAQmcgssEX/xBNlf08irIj5ba/hCZ5p5U3qBYpaHI1ZQbL?=
 =?us-ascii?Q?prA5D2Y8UOrAVh/3zYJD7LOmI0x/tv/32WDHUdGJ1Xh09+T+vZEgikKglO4s?=
 =?us-ascii?Q?MfCAWJiudU0bZz4xed3c1z/AwL8IxFHM+lnsbWWSEcUjOCfFni47MXRI73IP?=
 =?us-ascii?Q?JNdXERn6M9RwY4kaZ+73y8a3DP4cQw030FYaR4eH6zcUdQBpChyxHC23mFzi?=
 =?us-ascii?Q?2cDZfvEad21Txmv+hUsfS2/m/oTO3yk0X06fae5HWTfJhOviVzz7aDYBQckY?=
 =?us-ascii?Q?wQK4D8qRUPkxXskpWuob4WiWXY9bndi1w3m+KrxCxxepxWWwdNtyui2H9+yB?=
 =?us-ascii?Q?57a7km8kTNqiZNBKPWron1qxv1PSWDl7Dq3iL96GRCry06dXf0JRf3reDtV5?=
 =?us-ascii?Q?fKVLCvu9zWgmJx2nOwzYB1mdMtim/SXxJVD3nKjsNf1qXpUxonmzSn4Xn7Z+?=
 =?us-ascii?Q?RDQ5xszsck/QZ3fCTDEeSA3L7BvAK2jQnMaMJJIHgQjVRL1bQnJebdlPrz12?=
 =?us-ascii?Q?tYmI6anCm4Ut52Cmc/eDysLOchLJvFapG+kmHhNa3NI2rEm2RV094NMYVmfz?=
 =?us-ascii?Q?iZYbRhaVOKvzhi+XBbU+BqrYejoEnvqYZLD6DA8X8V5w/3DiC+GfbhdGwvoi?=
 =?us-ascii?Q?xzfilos4YbKUq+3GCbQXaBxh0c3IKMAVuLnzHGrrSyYKKaZV6cIZsKdk6JGd?=
 =?us-ascii?Q?pyPhZGolTgRSxq8xmhqwoQ5xeNLk3pgITZ43SKVr7/xOGkiJR/12x919va/S?=
 =?us-ascii?Q?Q+DvDb0svyddtxOGNKcPl3ZsrP80oKUiJOPtHqy8ytShagHCcOvyqpuDxm23?=
 =?us-ascii?Q?KS6JGOP4fu2JngDtsv32Q1UL9H2VBcwWptIglGhmVGdAR3HQtxmztmfJ1IZ6?=
 =?us-ascii?Q?lNRupIpnHKyuWfcoIApaayAC8lZrsZOhYYhb2yXDNUzB9X+V+YCmyaDuYKxa?=
 =?us-ascii?Q?q3GlwY2wuq4Z4ZYCS4ii/1MaiwsAWuBbxCjh8bd+g1AoKVuLVtkW0/kk/fYB?=
 =?us-ascii?Q?mHXWwaxwPHSfvymw3kEg8gIcBFFA9QPmKQ2CHPFcpHRBt259cx0JRrCdUx0Y?=
 =?us-ascii?Q?mMM5/Bw7RTxs4bM9vCpyz6ymB7olj7iMEBurPfGvnpT/xd4GrSNOUGLQoJQh?=
 =?us-ascii?Q?Sz808Dy/O90xPaaWPpVO6O06tRE5xPnWHeLLFyLAm/zo8ebfbbAtRK7dfh1e?=
 =?us-ascii?Q?viU8lkTgKddYPiNkb188l5wg4sobQxhM1CAkFfHcG5/f3dRrZa8LtD4XeHu5?=
 =?us-ascii?Q?W4ey/6rZDUt7B6OeT0+jCSC6fAseXa6uzDc7JJFDEBwopAp81YOAeT/WnC9D?=
 =?us-ascii?Q?3chej388lvKgYv+MyKNQeUoCcM7tiPVhNpUnLHMl++5E/xLIpgfv00AQYbur?=
 =?us-ascii?Q?9sr3WpV7eIM6bU+GBkpVytKFoXso3fYj3B1VIqlFemP1/8FBUuxvn1YYVCEY?=
 =?us-ascii?Q?1qicxaDOwBy9ZQ+SHak5ZfHArZbzxvX1Ji7P2wM6NFwUE7YenbTtwPftKjyM?=
 =?us-ascii?Q?AuqMBFYP3hYgE0gnwIJfNGJuXCgbixaYkC0CTkDbjJCYKay39zpzR4TH4mlB?=
 =?us-ascii?Q?sM8u+5Atq1WFfMaOQ+jXYst2w8Townk2OCCn3UxtxLoojPQv0+BhsJtaMkhe?=
 =?us-ascii?Q?/C/C3cB/iCS3bbecY9vuenHE7XasLfW/uzci0+utiswvrMwxKIXn/ctU3Xgw?=
 =?us-ascii?Q?IoJkeMJBNMaDix6tD8YGp2vwB4g+8x+Eoodx898QX4WqTWAu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d371cc-d48c-4189-97d4-08dec2e7a95b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 09:48:57.0027 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uj5RCxx6RLtmJA7hn+9d5Nl5DRLVcC94AZlI8gdg2X9SFdLs6p9ZIF11vlSPlcDM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8333
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

The mpidr's type is u32, however dev_read_addr returns a value with type
fdt_addr_t(phys_addr_t) which is 64bit long. So the check never fail.

This patch we still keep mpidr as u32 type, because i.MX8 only has max
two cluster, the higher 32bit will always be 0. Use a variable addr
to do the check, if check pass, assign the lower 32 bit to plat->mpidr.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
---
 drivers/cpu/imx8_cpu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c
index f93477c993b..d26de8cb5da 100644
--- a/drivers/cpu/imx8_cpu.c
+++ b/drivers/cpu/imx8_cpu.c
@@ -376,6 +376,7 @@ static int imx_cpu_probe(struct udevice *dev)
 {
 	struct cpu_imx_plat *plat = dev_get_plat(dev);
 	u32 cpurev;
+	fdt_addr_t addr;
 
 	set_core_data(dev);
 	cpurev = get_cpu_rev();
@@ -383,12 +384,14 @@ static int imx_cpu_probe(struct udevice *dev)
 	get_imx_rev_str(plat, cpurev & 0xFFF);
 	plat->type = get_imx_type_str((cpurev & 0x1FF000) >> 12);
 	plat->freq_mhz = imx_get_cpu_rate(dev) / 1000000;
-	plat->mpidr = dev_read_addr(dev);
-	if (plat->mpidr == FDT_ADDR_T_NONE) {
+	addr = dev_read_addr(dev);
+	if (addr == FDT_ADDR_T_NONE) {
 		printf("%s: Failed to get CPU reg property\n", __func__);
 		return -EINVAL;
 	}
 
+	plat->mpidr = (u32)addr;
+
 	return 0;
 }
 
-- 
2.50.1

