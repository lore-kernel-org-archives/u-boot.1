Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940DCE9B37C
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 13:24:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C316883F9B;
	Mon,  2 Mar 2026 14:22:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="P5fwIVkx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11A8A83D17; Mon,  2 Mar 2026 07:41:37 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D82A83F14
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 07:41:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLor6LOXwsF0OBi63QH3sJtx9eh4X4ItPvGipjnkjBOquZDwyMsgdPMT6+zYZrU2RYDuYjtUh3YQ0MIn5mjnCa+2GCKX/RbACzoA/80qDZ+SRV0ApGm5qxzqETxozW7ARk3EnO6mrNm1SGJG85/4umpb7P9yl65F73xDEBslmD9dVyrsVXBK36bAA+LYvLmBN1WRF/CEYRItwsRewjPK5Eb3vOLcMk4WyiAvgLnOEfP1FsLIXx5DUWQdSOAl+qSmc6WnyRyMhoqGhmFQAIm8GrvHriNItcFTu8K77VbKIXkuWvmNdDus6aCYSjtFMzVekA835n2m6lx0TLxe6lHo0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/WCrpY8yzZ2UraHKuVL9a/I8eFpiWLw+JMGID+419c=;
 b=khzpkv+wrYJWoSPbJMjkXCjvfvOjnDuETYQJ1apFJ+twkW5PMDhKkErw89Uxw4SGPchTX1rE0J990Q2r07XmV5Un+7Ib0gqiGuTtV5hY/hHkPXI0ianhHe3BOGE9YKM5G6ydm1wLbFbxka2LGVqvKKmnmkfcihtCndb87793k3JFy7p1eEg3ndHeBSHaZ+p4ZpV8c30TW+ufx4KtRSrpzODW03FTZJlWxt78jQf0rdnmF42jF8NvAg52zotoLaHx7ug9gHro7RLX8kgCuf9PztZX6Nn4zipMgUqj/J5XkxnZO9OOXjk2cQfF1egmpnkonNk77yvyaB0neuc9QEFbBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/WCrpY8yzZ2UraHKuVL9a/I8eFpiWLw+JMGID+419c=;
 b=P5fwIVkxGEjXLtLdQtmP5rIv9HVwG8YMW48zwfWGlkPvDT9nPUlZp3Ba7EWB7uyJO2LLnZKkecZk5nYsPuLfnNiLOK+lNIhMl7jzOL1823pgaynwQASmsYLvzoK6B4lPpUJtN1Yhys6KqxeaN8Z3GjqXcBfCyS387GvnqjIxOQwx3HVCSSnT1Kq+qgS7VIZALbUfKRjoMEBdCvxBMPLqtPnLxq67m1vRbapWd6TAKMPHOtpCyTEAVO0Zf69DIMme8P9uxYAsjBKj2vUGISfp5ByXKh+xnRA0MM0xUBs1T0FsAJ90r62iT4PRyByeYcpr0Ge38AjfFNFO1XT5EXZ2OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB11728.eurprd04.prod.outlook.com (2603:10a6:10:624::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 06:41:33 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9654.015; Mon, 2 Mar 2026
 06:41:33 +0000
From: alice.guo@oss.nxp.com
Date: Mon, 02 Mar 2026 13:20:10 +0800
Subject: [PATCH v3 09/13] arm: imx9: Keep WDG3/WDG4 untouched for i.MX952
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-imx952-v1-9-069d6167c0cb@nxp.com>
References: <20260302-imx952-v1-0-069d6167c0cb@nxp.com>
In-Reply-To: <20260302-imx952-v1-0-069d6167c0cb@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Ji Luo <ji.luo@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, 
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, Jacky Bai <ping.bai@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Frank Li <Frank.Li@nxp.com>, 
 Niko Mauno <niko.mauno@vaisala.com>, Adam Ford <aford173@gmail.com>, 
 Joseph Guo <qijian.guo@nxp.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 David Zang <davidzangcs@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Fedor Ross <fedor.ross@ifm.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@nabladev.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, Simon Glass <sjg@chromium.org>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU4PR04MB11728:EE_
X-MS-Office365-Filtering-Correlation-Id: a0c4a743-54fb-48c2-4d41-08de7826be49
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: DF1S8/Wc5K68295kSQLKLacHFm6Pcp6XIsaAkb+i8LwyeniFkxlHEYJEL63O+nSMDI0bbjyu8HdzCQE8ib47DNx6OdM89s1PxTFIPmK9RKLw6QN7sqj2sBSIEUWw+d6PdXOHj+PGG/PIXKVnJNUcIbLY9ndinO7+PDqQqCRLEzBYPOoL46vKwdorc5EHyu8SmO+qhwbU+L5s6sC+90waayaSoHNZCkbRX+uB5FYp3aVTRHyUl5+plNqJJARl5ND2GmGzM28gO88SVHUaSiuCKmYS7O2H4QnluU86Z9F6e6xcKafc6Go/y0l5pYvmziXfJql5WCHMzLRUV+QTD4qpfDR76y9fKj1ftkNavT6nwDi2Vlr/jaJy3s/7Oe1GlIJ0x/Fe0zb/TVefXYg7Rllgbl3ySkGxqHjmPZzMSpc3E9dzxxUCQJ7O7Frjnd6EyPAB2C3W8xshzhzHMA6M+I7tiXf9Qk7DUqvrzYhbmuSBzjpcH69I+pGoDQjvKMxx1jl07k68H1MmD+yX6kdKeojgUuqQwLKcXgnjBZWsp7ujM06jCF6kgb0LuZEpkrx53Nhs01WRQlCA0f3nEEDLdH5FUBrmGpsQyOPtzBsIL2pMzjQ2682h//vHqDdliQJeRVyYvoB2IQ5GXE8MYbUv0Nr48ZYiPgr2LQsPN26DT2ZwX9GJ93nnvzqylCPy5rhy7ZqBmH48b/VNZsEe2njqr5MAI2sWglWbL34ctZSZsikXhNGCC0aJw7NXe5n3niotTsdLFjRzJxxBwCW3Z//w/Hzb1r6KkB86xR9/EQvnQ+dfVRs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2l5aVN0TzFRcGxvc3NkSlkvR2pCbWJYbEtCWWZJN1JyWktUam5xdkdKN3Fz?=
 =?utf-8?B?S0J4d202ZklYZS9BbUpWVHBXVXMrTmFubWpRNk9YMXEydVpsT0VTN0QyRVlQ?=
 =?utf-8?B?c1Q0bU0rcVVZNU1sSVJDU0hEcXBHTTdYYTRTRHJSWVZqOHFDTmU4N28wSXlV?=
 =?utf-8?B?UE96VTZweFViYk0rdE1jZFMxd3JUY2g5cnJmN1h1cGtkMWxnb1g4NFk2aFJH?=
 =?utf-8?B?KzJpdVRGYWJvYkpmeUYzM3lzbDZ4R0ZvbnVXWEtUWnNmSnowTWY5UG1RS01W?=
 =?utf-8?B?SWdzemVLKzZhcmlBZCtOMzN3ZnhrR042Q2FiUCs4bGF2dHpsQ1l1NzJCVGVF?=
 =?utf-8?B?YkFHUzNEVDkxQ05VU1hVbDNORTZzS3lmd2tnRElpOHY5QlR2SzlMNWMxZTh4?=
 =?utf-8?B?RFNTK0dydjJwODk4d1RNTzFBeTNqbUJFYmY0VHF0TExvYU13Qi9pQ1FyMkE4?=
 =?utf-8?B?VTI3NTBaaGhyZnJNclpUSHprVnk5VzdDRVBpYmJSUHNUK2c1SS9UblZ4OEFn?=
 =?utf-8?B?amJock1lR1lSSTQxV2pXcGxBVTVxRTFXbnd0RkhnUHFGZmJlV2RKSHlZQU5G?=
 =?utf-8?B?SFdsUU14YTB0dkFhQ3R0T3djMFg1T09zSEhHakMvaFl0Q3RCTHRpNGpra2lh?=
 =?utf-8?B?aW1HblJWNlJZK2pPSlFMVDQ0dFZKMENGYjlINm1xS245Q3FNMjNwWGRtN1Iz?=
 =?utf-8?B?QllITU9lYk02ejJkTWtpVU1weG5DdnhvL3E1aktqbWRxUnA2QUVzM2JWZXBn?=
 =?utf-8?B?S0F3SVliamtxYWJHRVNkVVQwRTlXQy9iUE5uMlRkTm1YR3h2TFhoMlBVUlUx?=
 =?utf-8?B?OXVTVVhITEdYekhqVUo3OVcra0U2K2ErMUUxbk00V1kvc3MvazNhVjNVQnhw?=
 =?utf-8?B?bFlVeG5hT3RYWTN5ZjVEVjlLdHBTcmoxUEFHMHovQm9Odm54dEpLb2gxL3pN?=
 =?utf-8?B?WStlbEx1TXlGcVlaQVRCWGNEUVcwa1Y5bDNxOGwvek8xbWJDSWZjNVdVNXZm?=
 =?utf-8?B?MmdRaStzZmoxSFliTW1aVU1uc1IwRXdtclJMK0UySWQ2SHBoU0J6YVJ3bDdh?=
 =?utf-8?B?NXg4Y3kvM3h6V2hkZU5oYklZbWhYbjl3bzlQZ0UzZVpQK25Jc0N2NzRZaFhK?=
 =?utf-8?B?SlBWQ00waFowTjFLRDJlSzhScFR0aEhYRlVUbTVMYmdDZy9HZDZzYlBPUHVn?=
 =?utf-8?B?N1NjTmpDNTdKSVRicmdVR2I5dnI5ZHlmR2c4d1dHNmpobDcySVNRMWVzSnd3?=
 =?utf-8?B?U0hZV0Q5RU5GaEFYcTYyVWFGTitDb28vNkR3YkVTMjdSUnpacVoxd0NiYzR6?=
 =?utf-8?B?OUo1TjU5dkZtdGhCVFVyQ3MrclFSbjdURUxRMjYvUzZUYmpjMGpjeVFtdGU4?=
 =?utf-8?B?Zk02MTFNUHVPUVk0VjRqTk9mZnJDMEVnSFFtbUI5MmRia2tKN25BUm5IOEZI?=
 =?utf-8?B?VkUwRjdDVVdVSHZOWFlDSVpTcFpSUnp6QTI1bkpua2pCbmhvanBaWWRJODFM?=
 =?utf-8?B?RnZzNFg1bmFVV2dHMmYyS1pwRGtlc0R5bzA2c2FuWUdtQi9jQ2Q5NWNXbE02?=
 =?utf-8?B?TWFxRURhT3lrZFJEOVdRU0ZWdVR0S0F1aGVvUUh4K2pMZkJsNEZzTGp5VEtU?=
 =?utf-8?B?YUdGUHBXbTJUNnJiK1JoY2NqMGVWb0NVZjZFUmRtR0RxVXkxck4rY0pWS0Vs?=
 =?utf-8?B?c3BBcjduRlNJZWNWbTRDdWtib3Q1S3daSHN3d3pGQXh5a2VvVC80WUZLYnI2?=
 =?utf-8?B?STNQaDhsNEFJK0VpK290TjVYWWxTcXU4bGtucHJlemQ1VmtaZXo4djdjNW5K?=
 =?utf-8?B?bTNrMVRFQzFaTDUxeFVlYzBRbzRlVXkwVi8xazB2c2g5RU9GSjlvbUFVS05j?=
 =?utf-8?B?TThNQTA1YVJBZmR3aWdwVHBQR0NPQVZ2S2FxbnBPU0RxTm0zaHVNSnFnWm1r?=
 =?utf-8?B?WmJBZGxxNWlBSWIwbFdDR3pPS1BZUUprdldzWm1jZ2pNMHZQaHVldW1pbFVQ?=
 =?utf-8?B?OUJjVzJpTTB6MEVxNk0yTWtjY2Z5c2w5TzBYRzJSdVJ6aExVWUhTRFdja0dK?=
 =?utf-8?B?NzdRZDgwcjVoWHRsQlVJOUNRcDZkeWdPVGVRMWExcmNsamUwNmEyYW9LTUFP?=
 =?utf-8?B?b2F0MlVNRStWejcyQ2lkeWh0RVdaazF0WHYrQWxEa0ViYVVvMlA5TjFTKzRM?=
 =?utf-8?B?cHg0ZXRNemh6dW1rU3grekRKaDNEVzRqUEZtWWNHQUpjTEtua1A5WGRGaWRq?=
 =?utf-8?B?YXdpRjd2WHVzODNjYkM0L1A5ejlRNFB2NFgvWkpJclFGcCtqQ3ByU0daK3di?=
 =?utf-8?B?Zjh1UUJMeXozNmhnYW5leW9xVlNaTkJQNXQwMEwyZWtSMSs2MGZDZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0c4a743-54fb-48c2-4d41-08de7826be49
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 06:41:33.1319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8+3GaoCidz7QIsm/UK6CltD9HlxROxOP9E7+GMKZEQLeiP11dixUCqWsnVQEk6wn3EtZbYIQ67ttJmObq9/eJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11728
X-Mailman-Approved-At: Mon, 02 Mar 2026 14:22:38 +0100
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

From: Alice Guo <alice.guo@nxp.com>

On i.MX952, WDG3 and WDG4 are not used for system reset. PSCI is used
instead. Keep WDG3 and WDG4 in their default state rather than
explicitly disabling them.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/mach-imx/imx9/scmi/soc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index 538190e23b7..67898012618 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -786,8 +786,10 @@ static void gpio_reset(ulong gpio_base)
 int arch_cpu_init(void)
 {
 	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
-		disable_wdog((void __iomem *)WDG3_BASE_ADDR);
-		disable_wdog((void __iomem *)WDG4_BASE_ADDR);
+		if (!IS_ENABLED(CONFIG_IMX952)) {
+			disable_wdog((void __iomem *)WDG3_BASE_ADDR);
+			disable_wdog((void __iomem *)WDG4_BASE_ADDR);
+		}
 
 		gpio_reset(GPIO2_BASE_ADDR);
 		gpio_reset(GPIO3_BASE_ADDR);

-- 
2.43.0

