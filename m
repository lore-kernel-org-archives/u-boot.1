Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E10FD2D79
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 13:15:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02369840F1;
	Tue, 10 Mar 2026 14:12:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Ev/TMzZE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 519DB83FA7; Tue, 10 Mar 2026 12:44:12 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 764C683FC0
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 12:44:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bFMo8E55LUEZGIQESnmeJQZzuhO/AU+zZJuOWuzfGzvbeMe9uYgSLXqSUeNrapyKVrUgnhiyTzs2KZQgLZvJDaOzOvgo2eC98om9vCi+odnzglpjg48ANI9q94/OHAxzEvKytGPYTPrdnoKU/MAwp7+ALDpDQpyNjpSShZXjsdy50W+KZnjiDW+eoVvrR5c+dOqSx1eXQriYejvRFCzH0IpAaETuKZ2tGdv9hfeN/KeB9sOIKxMKFV5KAQwfzIbZZWn3svXtb0W+Zlk1tX0BI+Mtq6OjOdtU59o2mk8sMMQxuItEeGK1tzFQfMZx37IzfpvfssxBO57JbbOrNWrAig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NIUaHjFII0k/9pHGgQtHAVjud8vJhWhQCXTRVxLVjn4=;
 b=Eyu1sfL8aHNnH5mh8WjZ3br2jbwtPTtFOTHnDXc99r0jpGGdmb34zcux1cIDMZ7+1LIeGHnGN281XXh4wkfZ5YtOHJyrziuMiyKMFDbnvSKA6qDbMWb8DxkgcqZuorqaWkJ1LChlbJtyCNvcWcFAtWD+FlOQBlt4AmG4jWMkhjZkFjEsEA8BiZD/eV/aRoPGKSOhFZFmKjzXJMk3BhzGD677BQTFmxCaeLjosK6Nvo6RBnGhh4+sHmN0HamJy10e47pIWWIVlzCdyf8LHPhi6zDZneHQL9FgqkY4YcsqtOmtlizDJ6j66tyZdP1rwvWJiIJGXtOWH/P1GpONYLZguQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIUaHjFII0k/9pHGgQtHAVjud8vJhWhQCXTRVxLVjn4=;
 b=Ev/TMzZEh5KUHZdG3lSUNg23ceNMDJwz0y8zgLk05E6heMk7b753DqyOfdezLsJiLo9vmYlpekK79ADOo1hD1D1+PTG5vmDRo7GJKQytPfJvbN9vxE7s5qVfplSSRK0j1DdaVhufo4Fq8EH7u/MfE3BrLoc2C1jJ3sjtiWAVbaKvyadqZWSJbbhlDX0WYCPjdWNQ/68y5pOuIxN0Mohsi5wFNfg4rwRIJj0UaqiX0+aI31tjppSqTcsqK/ecggVN8wYTRJb65tIEYNlYnOrC53I9Bi8V5M1R0+tQnX5FfUqufNWr0yWjuaR+7CZO7rNBb5VOYvKt4VVvTBVY9ddnHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com (2603:10a6:800:306::9)
 by AS8PR04MB8753.eurprd04.prod.outlook.com (2603:10a6:20b:42c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 11:44:07 +0000
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7]) by VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7%4]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 11:44:07 +0000
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
Subject: [PATCH 3/5] imx9: Enable QB data saving for iMX9{4,5} EVK
Date: Tue, 10 Mar 2026 13:54:22 +0200
Message-ID: <055453f88fd611f1282e36f2d8b3d294a8bd88dd.1773137310.git.simona.toaca@nxp.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR04MB11917:EE_|AS8PR04MB8753:EE_
X-MS-Office365-Filtering-Correlation-Id: ac5f683c-ea8f-4b99-d395-08de7e9a5623
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|7416014|1800799024|366016; 
X-Microsoft-Antispam-Message-Info: MaZbGcCHcqEru2WvLp0nSEyRIx9tUCzvGzCL+bk1+8ObyHTA0NrF+/S36dDqoFi36g7n/FJHcjQwX+ePpkF94cpS+G3QpNTqb9ax4wC3GOLy7JPyXaFXfBWczFSHxHLobZSneKmSl3huWJ8af4iDcBpE33hAAr09WGqp16i9ckvoRDLHsk8xfAkSEJr6kBub/W+6NYvxOk+Ga/xPo7yK+oQsC4ojf/4FnQa0gdfJB7YQ5geYpuwOdFjfHsPSz06TdGy9hawPX8P1Ta2XcoKQlRHU+3aUueQ3/C6rLG9glZIUIR3J/F3TpeWQVmNjvZZEfw+Ng+WlEQp0Av+gRFZXmxkcxJFGOOFSv8E1sD3jhi1Pgv5I9QeYoHQ8RrOp+8M1TVrcCqa0FHNm2jy0tKkwFHqZDt0Uoq+h1PcnP3RNQ6pd8ws3oG9ZqCsFQTVWECiR5ZiMpeljCC1+t4Ssb9KB6rRUdmHdA/qQczD6Ckl8fnAbS2GJvgHRyPFNAv1c+7zpEUUiNOO1vEKekiSH/3XtnqLuZO5CZ6+pVP3g+IA3MljMzEX2xfkdgNE6J2mfWdWcQlvPnys2pZMeJaUCKgGIOWO0mqO7Sm2sTx5ctKs6AZv8ZDrLaCePAO2lCiivipFPPtnJfXV68W8vduaAr1OcHtMO+fK9tiuoHHKcTBkXgoqmZ+Ay9hhwULCLZFnV/nfavh5htQW6lxkED7KCgNRl9W+ELnUEz7xTdmdciHQU/bc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB11917.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(7416014)(1800799024)(366016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pU4sk2yiODOb/IGDC1CLoqp0Qxxy+GCb0ecYj7UJvo4Zhuj22WdKhnW2fjbg?=
 =?us-ascii?Q?P7RxOsKYkbZf9hGz/UMzzt4NGLT+gDEiZHXy3pIw5oncOZDDwuWDR7w1Q1jg?=
 =?us-ascii?Q?iNJ41Cv1933fpjF6hhBvd90w7JU/wrBCJCTu4ZLg0/K+mckTStbdNpfoTCZ0?=
 =?us-ascii?Q?r32assGCSnGDBAwm9ae1SITaYMt0KfTqHrQr8Gi6UNqof8vnXv9iDMA+gigL?=
 =?us-ascii?Q?Fgf1Ywy5TnqlVqImCi95zAmdQI9z7urJMAN7dC00g8V+aGWw2rT1ooXGPzMr?=
 =?us-ascii?Q?cXxmRu6SvHyNX5j/xEDFoQNCqANpqPc6+gOgenrvP8hA9tIsKEUdQLzEQp3W?=
 =?us-ascii?Q?LAlIS2bs9epuJY7+ru4I+aS6GGWsCdReTpkV5K6+L92ayVGis4gtr4ZE4zq6?=
 =?us-ascii?Q?Ez7osqtVakWjnZYD6p2twAuHlW1S3xdr1uI/ySjk4bybK6zZvda8tuZRzXyi?=
 =?us-ascii?Q?bW0nm1r5V1hoXEuzHmYijFOK9L5pbEyK6C25pf640d8/YcO6pt06VFDfgNYg?=
 =?us-ascii?Q?5hWJ/06APluUwMZN7X2YpeJzSt3WrVNF9Ty1WXb6vIVxmBQS582HcxYi4Vey?=
 =?us-ascii?Q?orocQFPZX/y3QkUrmPtmNx/TslmxDPmJXD3uRH9TU27OKBgKNPtaGgBq5giu?=
 =?us-ascii?Q?+28vdA2aj+hZleA4IBkp1zkYUCTFu0+2lj6/+gHPlF96innsXFE2RkJxib7f?=
 =?us-ascii?Q?U3qcziAA0S+5fYX1JMf62suzw6+/BDnqHKiDUpSdgoAJ5CDuy6rMvXlgbxoP?=
 =?us-ascii?Q?9XPYAPYTU/FlWnpja44sP44KP/7PQ6Q8arS4qTzrjcTfgjX1tZLr5Y9FlM8u?=
 =?us-ascii?Q?Yq+U/5wLBB7AHbi5BTYUoTMvgk1jZ3modULJM9CJjuiUF94AlWtyTNoxZ5R4?=
 =?us-ascii?Q?e8TTsMCHaTYCyQeDoT3tMApW9mFpApuQGMlq3CxUVO086m/ivM3Aenfzh3Ri?=
 =?us-ascii?Q?XWTTeH8fwcdlawbzCK5w0ONIKx01lWWpFqVND8Q/x9Y6uOzxuAMvEG/+eUfE?=
 =?us-ascii?Q?AbS6DoEPoOdYZFKuVnD9Bp42hd5+xSTkxS8Y71Gq9N/HAFXg6wyN14qI5f78?=
 =?us-ascii?Q?4wjJSd5+NxcISWEH9bb5M5HHC/4+68vB+MHHcyc4nEcxh3yadSfVx6o6t7Pw?=
 =?us-ascii?Q?0zxTegt32pBuwjiLyxAXB8T1k9DzJfP7Yf7EbwZ3TMEqTwmSLxwH3NI2PhW5?=
 =?us-ascii?Q?/RmMIzvkBrc+nEuyeXqR/g/YwCDo+1jvlbwNwwzDaVs1aJ7Rm+PPZeQnyw8z?=
 =?us-ascii?Q?R0wIa8+TxQvKeaKMaA9nF51P0OOiVATTh6bjeBI54k4osF3INXiCrumOQvnl?=
 =?us-ascii?Q?X7KxqFzxhhQKq14mq/v/XiOETgkGYbVFoul+HESb/yIcoZ3MPcU7XFZTk2XO?=
 =?us-ascii?Q?pwBUjs3qrvrI78qVUTkfPFIa6rCZHV3Mriql5TvkQmdXtGzX5V0q1XHve8Ro?=
 =?us-ascii?Q?qAgZNxFjkcb8z8qrLKQ8IR1m6VmyNLEFgefHJEbqWaChF//gnBsMTls6kx5c?=
 =?us-ascii?Q?oul9YFG+NhyR0NtUIpQ9JiDoRUyCpUZPdmu2WI0EqQ6RsPrwm5ifUvlALZd/?=
 =?us-ascii?Q?TCWLaRWDvJRWfeddL4y8PB5YfXSVldrvGaz3OhFJHlMRQbOP/8T34iys8dPr?=
 =?us-ascii?Q?vyn6iDfh0fWGmGGeZAENtCeZ9PNtdYK3xElnOMIgxFfZph0vnDeIzX9XMEPB?=
 =?us-ascii?Q?zoDM0IJWTX6fK5Nn7jOUJnzN9IAGNlfE4jK39VbVy1wje6mROCLRffnv7DeW?=
 =?us-ascii?Q?hlIcWPB/mw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac5f683c-ea8f-4b99-d395-08de7e9a5623
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11917.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 11:44:07.0339 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pAtQID+YQH21UnhoFMiMKBfa5UQVwWlmhQ5gUB+lBNNWrmNtmGWRXx8Yo9q2601fpV+5QWZYxoQRNuNUdwGlvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8753
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

Add the necessary options for enabling DDR training
data saving to NVM and running QuickBoot flow.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Simona Toaca <simona.toaca@nxp.com>
---
 configs/imx943_evk_defconfig      | 1 +
 configs/imx95_15x15_evk_defconfig | 1 +
 configs/imx95_evk.config          | 1 +
 3 files changed, 3 insertions(+)

diff --git a/configs/imx943_evk_defconfig b/configs/imx943_evk_defconfig
index ef4f9a8fcbc..57d4240ba26 100644
--- a/configs/imx943_evk_defconfig
+++ b/configs/imx943_evk_defconfig
@@ -96,6 +96,7 @@ CONFIG_SPL_CLK_CCF=y
 CONFIG_CLK_CCF=y
 CONFIG_CLK_SCMI=y
 CONFIG_SPL_CLK_SCMI=y
+CONFIG_IMX_SNPS_DDR_PHY_QB_GEN=y
 CONFIG_SPL_FIRMWARE=y
 # CONFIG_SCMI_AGENT_SMCCC is not set
 CONFIG_IMX_RGPIO2P=y
diff --git a/configs/imx95_15x15_evk_defconfig b/configs/imx95_15x15_evk_defconfig
index 38a855417d0..03c9b71f8bd 100644
--- a/configs/imx95_15x15_evk_defconfig
+++ b/configs/imx95_15x15_evk_defconfig
@@ -100,6 +100,7 @@ CONFIG_SPL_CLK_CCF=y
 CONFIG_CLK_SCMI=y
 CONFIG_SPL_CLK_SCMI=y
 CONFIG_CLK_IMX95_BLKCTRL=y
+CONFIG_IMX_SNPS_DDR_PHY_QB_GEN=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_SPL_FIRMWARE=y
diff --git a/configs/imx95_evk.config b/configs/imx95_evk.config
index 3db583cce59..b34d3f9c935 100644
--- a/configs/imx95_evk.config
+++ b/configs/imx95_evk.config
@@ -101,6 +101,7 @@ CONFIG_SPL_CLK_CCF=y
 CONFIG_CLK_CCF=y
 CONFIG_CLK_SCMI=y
 CONFIG_SPL_CLK_SCMI=y
+CONFIG_IMX_SNPS_DDR_PHY_QB_GEN=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_SPL_FIRMWARE=y
-- 
2.43.0

