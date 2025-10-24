Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4239ACCF9E0
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 14:54:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB09A838EE;
	Fri, 24 Oct 2025 16:53:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BR1xhFv1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F273683621; Fri, 24 Oct 2025 11:28:29 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 948998334F
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 11:28:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LrawU/mHDiTdBHfkaQnJTfeCADoMhear6xI4EC3WHTboq/pVuqGGKJteSxJye4o+dzG6em6AYy0nt2ybnxPj2MjrBOHc+KkZAvNleISwLA2qO5HzZp0WrA07I1RIVqiCVUAybgg2DWBrvfJC7HT1f8wSPipBz7TwXF/TBR7t5ofMuIey/IOYkDHG8pdB72hySsqCYtbLiIEhaOvYWJG2RZeoTJ8YS2jXNid0ZxEybaGIQv8MIIknvNoAnYiPjkNbN/+oQD+Gqd4PxCd/F1GSMaPNTb5sn7cNSGowPmKdiP25Lw5/C9DaQ0nHSmCsKr1F0T2y8wSNGoklGiGx34f4Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdrhA3p6Dpgev0p4DTvrTbyiUvufz8YJgUojSBRTcK4=;
 b=ZqWvJuuR6oirco1q7d7Fiqoqul66g8heVu6EoEVtvWr/b9KsuKRmAJsCAqL0q0edrw1nIiMmtIafsBmYMyx8zyFY76kmFx+G8pXrtCumVX8mpG6BCEIpeIwNf38DgtoeZkb4zEfEqGfYjBd2Q5MerJR/V8RUX8h4ebsY+kcKd/a4BvMdlL5gMP+q417OuqfDwKV6cVbkisP8s6X31ga8N+9v++MTh7gej5tNyxjEaPvXI28i0ds/CvcXfQB34wSBd2Vlt+PsFhXBK4FaWg/gjHaw6FpPh6xLNZxfF1Wnzu2i1HHa8mopl518pn4UcWeJaUyrshya1vBMIwSS6p2uKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdrhA3p6Dpgev0p4DTvrTbyiUvufz8YJgUojSBRTcK4=;
 b=BR1xhFv15/IhxvQtvMfObc29UV4/yP2u9jJhtg/UpA+awWIi5hqge+Cze20k4S2q7Nb9T6lZYHQylDs70jUetYIE5UJeDqNLgRZHmep6QVjoQKx2vt+KVe1WJ9EI/HulXq52gsoFtuDFAUYZxMHyrwC6inXmA+/SnqSC+JL2oPNdR8S+nWoba+IW4PUYugLbJmvLo81z6cqwNPLDvlFn7m+KoXG0ZA930d+/PBk9axcb0QNAzdez/keebQGOYl58fxwhtk7SVbcytC7tq/2DAMOWX6PGyQjJqPkJiAWEKw3unHoskLS7UsehaXqEXUtdNHBi7lJMDomKVrYDjXiglQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB7660.eurprd04.prod.outlook.com (2603:10a6:10:20f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 09:28:25 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 09:28:25 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: jh80.chung@samsung.com,
	kauschluss@disroot.org
Cc: u-boot@lists.denx.de,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] mmc: exynos_dw_mmc: guard execute_tuning
Date: Fri, 24 Oct 2025 18:40:33 +0800
Message-Id: <20251024104033.21653-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBBPR04MB7660:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f0e2277-98a7-41b3-70d7-08de12dfae8b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kjGcJtuC1QkWwv++d8oor7a/UGCBlw3dkA5uJuRkB0Xvt30IqMLHm4KJL1d2?=
 =?us-ascii?Q?eRjSHA8Lhyd2Z6x32e3h9i+46bhBLThJeaW8H/pi0Zo1n/xjycncz6BvF76x?=
 =?us-ascii?Q?K7Lfzs2QQbyyOQpnviiS93n5k/dqjSXa9ZEoXmDvijcekRg7c5VodItPSNq1?=
 =?us-ascii?Q?Rd2zrjd770fBkrqeudSpKV4h0CHXFhJ/095bY+5fGeiBIpHDUQzu0PyCRNhs?=
 =?us-ascii?Q?WSNKAsqwrF/Lapwkm9ZuzHGbSyGalwp1NUWbE+Ky+0rG8uSdWk2lXRZCj3KB?=
 =?us-ascii?Q?p1KEX3uUzM/XeBm+SasQsvFqe1YOfmDJ4CLEbHC5Sow3anBL2NipTZ3Wfwet?=
 =?us-ascii?Q?wIv9ZabFSgKigt4+IBSSFf1sU/5/Nld6XhsX/7QrHDFnQXMRbdZbtNL+TMDB?=
 =?us-ascii?Q?RB3JGFYdmdero91n0F6QrKOkppf5lEhK+Ci5n/jasAfvThw13PZqgSgcxa0c?=
 =?us-ascii?Q?odYvynm+iHgKxWjToiKh1gKUvhFRPG2906s0NccNnn5ovSpWx9nmv7Lk75Fo?=
 =?us-ascii?Q?eMLMZm2ELJGJ9Ij2UKfYJU/3UFJPsMnmAF1sbrtCjRVVSllT4Lh1G1zASpqz?=
 =?us-ascii?Q?UrkGa9V+BcaFFEUNHWROPtXef4tE74iAB5RQ5KO6YEzdGUZP0rbAChMml5Fp?=
 =?us-ascii?Q?ah9q7EPk7XriTOPF44wwlpy6hnO+RFLtTV2/kSUSZtBPNurH9Hbqc2Jzmt4j?=
 =?us-ascii?Q?bhfjAs8LHZHfHuaGuhz4AIAvTB2WKtAGBIdJRb7Rg1p6CU7r2nCrQi3uPtC4?=
 =?us-ascii?Q?k4NvuAtcEjfVuTZbna5A6SBKIzu+1NeycmQbicCyMF+/nwSdWeRjIn3VHqoE?=
 =?us-ascii?Q?otL3XdcfIxQtCZO4jarxx5A0I3ey19616omP9gZdRpWmuuxe1ygXo7UrkNoJ?=
 =?us-ascii?Q?Bo6EPCsFTvTLHc1paJ8NwK3T/ym56lEj18bB8dpCxk1zL074oPME3ogFqCeL?=
 =?us-ascii?Q?l1/CZcMi6UYXiWZ5F6/kpoMiK2roDWRhOrit1ufMzzUImokVu+GWkMgVEcwY?=
 =?us-ascii?Q?uUSTMptQ15MUuYz1BQg+gsGebTcCBswtrnUGPndcFuihR74ktoecKVyG+B3I?=
 =?us-ascii?Q?JoofZH9/eAlzn7U0hvla2o4MGRPyoJr71aQhY0WU1J5ogKTlrDAfSqnl2ceo?=
 =?us-ascii?Q?WGwUCldIySF4LUDGGlk73UE6sUol5G3KxdmXEn4pHSIlQE7wcpVXw/8uwJ1U?=
 =?us-ascii?Q?cBHWt952crVDuCuwZjxiK3x4ltil9rB89t56WnXYOnsqyne8Wt4h2sX2g8xh?=
 =?us-ascii?Q?Qsk1/H/3M5lSfTp/8rZVdqh1GNTYgCO9QIq8Oq1mQSXRtfLQxgu6h6PCkPl7?=
 =?us-ascii?Q?0M9oQMzzUoxxAsAcVshycBnUbhrQ3befbLdT3HoEZpDi+ssDmoXrtwjcbvd/?=
 =?us-ascii?Q?fR/LmvXoffAE9bi+sVbjsrOR/8PrTU/gVKOOQyTX5batlKHXKTIIj2cFEsj8?=
 =?us-ascii?Q?xH43m6MioZaS7mWX2m6/7msEKhwklve0jzazKlRYTC4irJjouCLDIThqB/Ii?=
 =?us-ascii?Q?bSz4p/2v+3DS6y3nS0fy8ilyNvcAOPr8XC85?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bkBrJ5FeleUbyHVXAllSmAyCDeGjfeizVn3a1IRQ52+zBXbOZT6BCDHLjJkg?=
 =?us-ascii?Q?XJmyXE3XzpONd0y2RhaBmqdauXEAb7pVizWsDHwj1lBwfjQ1QniWdAzplBpC?=
 =?us-ascii?Q?ymZG4dYAuqw1zxUnhFgl3sPV1jeGaXBCYS0Y0ZYg8W+0PEIJ/iOEo3aI21z+?=
 =?us-ascii?Q?43yWpqTedGJreMz6fi18M6lyw5FUFxRVNMX0yik/UhplE36SFvewFCOlHanF?=
 =?us-ascii?Q?vqrZmlZ6NBiV11NEkrxMd0fXsIEG0Jw5F3LqVotZiI/fK9jkapUsPIf0oCb7?=
 =?us-ascii?Q?a5/BxD2eFSFk/SEKkMPfrb0GS79WGc8Q6QIEdmFuQNGdRlUnJx1+3ZPOtAJv?=
 =?us-ascii?Q?lTClrcUN9Xsuz5aVZIAjkQojLr2Xo47RlZlIuDonlcvMtRx5aj0WfQzSePyQ?=
 =?us-ascii?Q?QG5uZb8SHwER0tQwGhqI+PRmAW/q2yxSwQcqNx/Edt2OepJzx8e40RSoewYA?=
 =?us-ascii?Q?PcOe+i2RVRdtb/I+d9lyag5N2xbwGPgN2+0+n+kPZBX+5LBfkIX8b5cGAeaL?=
 =?us-ascii?Q?RqSV3uluOSomvyEr5p9/vXdDL3OeTxliyu/9GWy8WlBEteTcHfwyi+HyULUu?=
 =?us-ascii?Q?oEk1tTuNvSqle1WAnSnlVu+vd1f1MXnP9U2XpXCHbWyKbBKeYfOyR+j/Ir1i?=
 =?us-ascii?Q?aksxeeaEkM9O5rszXUYK5aqReB8pDyt2uO2QnnU3WJOtbMCM9+lTW6ilVEJA?=
 =?us-ascii?Q?2jFSqCsDiFoY33/Ju11QNzS7hv0BFb7ywFGFcOQcm5Wt6gdzLhODO/FLndt7?=
 =?us-ascii?Q?E9Pypck3aSS3dJieK9tOvTL1ukd9oF5FofWdJKIIVp6SEwIJrr5OmL+cTmJ3?=
 =?us-ascii?Q?xbURWVlyaICirWRRCnfuEDSbxhnfzOvdm7IR0ApRE2WbtSADh+a9L0fBbPKP?=
 =?us-ascii?Q?oKKziiI4Et/LTgclii0/hdLfFwluUm6AekEkank6BD5IFr1CYtnzhjjh5w3E?=
 =?us-ascii?Q?w/cOhVn/k1Oo8YbEEMB0vr1Rqif+aTpRGVNxnfYeOaxThyVlPhs1T9biTCQF?=
 =?us-ascii?Q?r7sy6vUwiKQdm6f0q7/wpfbq9CCVvTBQ5vtdO8BuETwXIA9ZV33rSnx648YF?=
 =?us-ascii?Q?8LK/8wgn9iA4XZVvY2iZS2BfHO2UjUrE+cp7qFPa60flFSAovdjpAHSh9BZs?=
 =?us-ascii?Q?Aq5ZwGX9RPyKtURxCx+OCSVO8/e5xIbxu+4g9E/RSlY7Pt6ljlPQdyleykPa?=
 =?us-ascii?Q?BperMfghhVS/I7aH41as56MS/fY5R0meRrG+Nb0VSik69WDfo+XOHVgQpox8?=
 =?us-ascii?Q?uv9qad6sizDl77dunzJ2WiGkiPMBigmXSvg9wP5AXXBAWGFCmcSj32B2w/3V?=
 =?us-ascii?Q?hM8xAB3S92QYi6FopCODX/7+vrxAv1qDSmkhjMyutXfE/1LERiZ4GE+eSu9m?=
 =?us-ascii?Q?i/q9Y/VSN95OllGlcrn8UDdXwklsgOSWcakzdDwktIvOZTfLCrx3DUxKJQBK?=
 =?us-ascii?Q?BUWtGBPbKwZhwDtU7bLJHzKbuSPOIW37ql/ZY3ZYuwyNFB017H8MzZPaN6tP?=
 =?us-ascii?Q?StOY+CFB1GvxbBN45PH1b5u55LGzbaevKNl5XRkhzB5fXx7LhaOTZcn6vWpY?=
 =?us-ascii?Q?YHzf04Tkjt3nv6cjc8aLUmn6smK/jasOucSniinV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0e2277-98a7-41b3-70d7-08de12dfae8b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 09:28:25.2906 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: myBGGFk2OsmOV+B6BqyXQ1xjbqf1ANBTFHz57CTZE39zZ2XLYRBjsxcaYGjWj2pG269LJYymodP5mv3Bbfg3+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7660
X-Mailman-Approved-At: Fri, 24 Oct 2025 16:52:55 +0200
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

Guard execute_tuning with MMC_SUPPORTS_TUNING, otherwise there will be
build failure:
drivers/mmc/exynos_dw_mmc.c:484:10: error: 'struct dm_mmc_ops' has no member
named 'execute_tuning'
         .execute_tuning = exynos_dwmmc_execute_tuning,
          ^~~~~~~~~~~~~~

Cc: Kaustabh Chakraborty <kauschluss@disroot.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 guard exynos_dwmmc_get_best_clksmpl and exynos_dwmmc_execute_tuning

 drivers/mmc/exynos_dw_mmc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index b6660fb2cd5..b230e9dbbf8 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -299,6 +299,7 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 	return 0;
 }
 
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 static int exynos_dwmmc_get_best_clksmpl(u8 candidates)
 {
 	u8 i;
@@ -364,6 +365,7 @@ static int exynos_dwmmc_execute_tuning(struct udevice *dev, u32 opcode)
 
 	return 0;
 }
+#endif
 
 static int exynos_dwmmc_probe(struct udevice *dev)
 {
@@ -481,7 +483,9 @@ static const struct udevice_id exynos_dwmmc_ids[] = {
 struct dm_mmc_ops exynos_dwmmc_ops = {
 	.send_cmd	= dwmci_send_cmd,
 	.set_ios	= dwmci_set_ios,
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 	.execute_tuning	= exynos_dwmmc_execute_tuning,
+#endif
 };
 
 U_BOOT_DRIVER(exynos_dwmmc_drv) = {
-- 
2.35.3

