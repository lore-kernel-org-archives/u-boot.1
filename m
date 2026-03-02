Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE852E9B37D
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 13:22:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A31983F54;
	Mon,  2 Mar 2026 14:22:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="X7Ur6Hma";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 935D783F14; Mon,  2 Mar 2026 07:40:40 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B5C083D17
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 07:40:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IyXVJWMbjA7aIWkYXTsfrjJxcvrc1R+m8pt6Xv8Mr8CN4XEtax//YqIyXDQuTKkvdCUujdOgXM6vy7wG4TR59FvOMCp77TmPsmm6WEv9W+XAtS17vQ7vyA1k4/i007bIQy/AkOhbrISioIHlixNGnxYeNlmdKvcROIZwh0ganA1+rCAnAmZFez31s4+hMr6ds4hADHjsCMTCtdjOPFJUJRk9jrLf0b7Qy82oE+OBsfRhz6+IdZIMuiKiyXrJcf+4zRlXdDfOnB/OscLXhmU1+FoN3y+08DoglmRZuk7g8yWX6T440VwUfULqmIef7w5doXMvxe4DBwfQ+tD6YmBM1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jooZTkGYL0HyEvUYxNg94UbLq2Z9wCIb23sbVwgynKA=;
 b=x5TWaNWgETchRD1ixt+Fte8SdjAQpCtEZLlg/e0DqsIxQn2WvuV4bOprJWYhcZ/g6mhHttNvblCuAmMHkOVX2F6prw2RwD/Cec0Y73q1wnInKwZ7OJeNFgd9zqxTqDRgfmiXzcCAISvwlpCI9OQ63oH+mBnYtW/foOrR2QftoQLcCs4tqPG485G7VLRdo2lIdIEAvRpOKnK+N31vmTMjnxi2wKZzduYGrgQjKMsPt1fRnmRyUg5vBtfSGcM0XXFwTs4UMwyCvvcjO5y1HeT8FtteuFX1eYL/qoUvQA4RBd8aq5Zqi0caJBsIvWOriCUREBPpAV3K8HZU4ovmCu/VYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jooZTkGYL0HyEvUYxNg94UbLq2Z9wCIb23sbVwgynKA=;
 b=X7Ur6HmaY5NSbFUbv6s0qSMK1qvQJICmoyFwHeXPQ6hMO5PdqR4aNFAs38BAtG7Lq54VZXDVdaYQI13REZCeR0If4Wzu1kTt+7GqK+0DCjLP1pUgoD56V+0VDAeLQparX61XdETjB8oJlE4tRsi3NIIdQyBjHJ8z5q9OZ2pzaZ2MHsMZDXmdkCYMsZ9BrnnN6qbiznbv1eTIZLu4XjTlfctNJ2tL8oRYbwSI7u53+UXbOmTkq06BZZplpwT+r1AItMvkqPJc68KiHEiQ5POO0ssiuQRqOouhVIE34txSg+nG2NNJMCjY1/VJyZf5ySP1Ey+BP+q1OUr3OYN1ub/WCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB11728.eurprd04.prod.outlook.com (2603:10a6:10:624::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 06:40:36 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9654.015; Mon, 2 Mar 2026
 06:40:36 +0000
From: alice.guo@oss.nxp.com
Date: Mon, 02 Mar 2026 13:20:03 +0800
Subject: [PATCH v3 02/13] imx95/imx94: Remove board_phys_sdram_size from
 each board
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-imx952-v1-2-069d6167c0cb@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1b06d9e6-5dcc-442d-efe5-08de78269cba
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: I1duP1+lxg5O0QmWkw/bQt7Drw72wfAXbyYlDDRzYiGJSeJylU4/9WAoqaDl3fCd98ma4cAEpEj9zN+YUIKvsMKLVvEYU9Vy1yl3UNSZI1OaYASDNbSB7KYWzXpOL7q3rqajlTyZKsdEwENoV7oeCpfV7t1cSDiVnmoFkUPWTBBCmVKWmd22fwLKqU4uTTt94mvXmx6AEb1EJ5cJHIQ3+RzofrvvAl7e6hoJvvef88xC/YiYJyfb37Otbjcp/G+2fDkftFrlXHaUHv7hOxIocoqESrh4G+D0bRUU6yWNrOMqijWCrI43obGrwGvBdIjXTha2hrr3XRD92vozskLEIgtHnnD+Cfau16ydVE4LiLJs6C4n/6OBVlDPxSaZgl2RZ6zTQpMlQ2tbvEzFwUswBR2luY08/IECDGGv7g78PybHhxcY0faxBPUICnvS7WrDB3Lvj+F+vLA3mLmJquHa2pmfEEKhAhVh/Kkwa+8i3A5cml7wIemrg9fkqjtpfE8TmnXTIQaGC8CNgs1a2UdT3C1gB31Evo1f5hbYckdHalFE4mGFya4pFE35tSTd1fts7uo4UKscn25DVgTVT6um2TGzXfG7JQ/ScjgSf8pgumYqiPMywxwlWbfDlGEbb+rVyhdIj3VI8U/fYWtICspJPqxfmrg7R6yhg4QCc0Jow4X7/1Z9YAQjtzdXZaykeMvN/RIz2/u1N+DmDNU+IZ7JFcoD9GPkQk4PE5T2Itp14wwOHXXpKTrk7Dfrq4zk5AoNuzt3Po6FcSTMub+ACA27LIr8UtaAORhw69bCl+XimT0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFJ1SkxIWUdqSE53UDVWNWNUaVlZL2k1SzBpdDdBY3dUUFM0cW8zSmEvUXBW?=
 =?utf-8?B?ZzhQWVlmaG16cUVpZXlOai9XQXg0Z3JFdXBHV0tlSG9wR0dDTkEzbFBiNWxa?=
 =?utf-8?B?WVM1K1NOVTV6Y3lGNHV2bUpUSEltdlNtMzVsTktYRGk1U25CVUhPMm1mc1pV?=
 =?utf-8?B?K2sxSnFBVG5xRjkwelRpb1lOTXZxdDdSL0ZOWHo0c0RFZjZsZDBHUDRjbjIz?=
 =?utf-8?B?V0NQb0FJdVhBbGV6aGRSN3Rnc3JxV2J6YVh1ekVOVDU2Sjk3NGs2cUx6T1cv?=
 =?utf-8?B?MU4rTUJ6TzZWaS9sK1VYbVhHdDVDL05IL2hoTWJqbk1TRHVicFpHWExXTHRu?=
 =?utf-8?B?TEdod2xralplaXRXR1did3JHV1AzUS9ocFBrc2ZJZzVsTVlRUmFNSDlLWkZ3?=
 =?utf-8?B?cEJTT21sK21rWlAvMFRsNDlhSG12UDYzSEVoVVNVbTVVeTgwekk1NU5USm1q?=
 =?utf-8?B?S0ZxZUJrZXUzc0NOaGxpY2UvRjY1TWQ3ODJuVmF4bUlhVEpmQUk5MXpZODZU?=
 =?utf-8?B?QzJDUWZublA4VWN5akhhTE5NbUlMazl1aWNBaXkvWWJ3NXhTcmNUdVBCSklB?=
 =?utf-8?B?TCtXNExnUWkvdjRiMkJ3SXhneER0SW1oUzBaaTFCZ1grUnFLajQ0Q2JybFpv?=
 =?utf-8?B?d0ZOUFFQMlpqU1R6UzloeFREZHREcVEwbmludEFCZ2JEZHpEeVZuWFVMelNk?=
 =?utf-8?B?SDlJY29pdkh0UlNlTGRRSGRFS01jODNTYUFuRGsxUUtadjZFN2lQZVhtQWNU?=
 =?utf-8?B?c1l5MjZOWndidXoyMDVtSnlkRjI4U0RZQ29WbEJYU2NGeklpb3JtV1ZCT21v?=
 =?utf-8?B?VnNaRmpDNGVOMW1PT0RNTzZMalIxYmczalg3dDcrKzQwdGNhRjZGL2tiMDZ4?=
 =?utf-8?B?ZmxyclFINEdseWpuSFhGd1hJUkhvUnQ3YVNRMWRIOWRoVCswMkd1UFlXS01o?=
 =?utf-8?B?MHFaS1pFTkZJNUtITFd5Y0VPY3B3cTBVZUVjbDdMVUZUeDhtS1hrMmdBUTNm?=
 =?utf-8?B?QU84Y2pac1FNMmtETVc2SzRFUlM4V2JSTnVWZlpxemxJZ3k5dXk0c1gycEE5?=
 =?utf-8?B?Q2lTS2JZVVp6L2drV2xwc240V2FvNGpBTFl3RGgxeHQrM2NIQm9tNHAxUDJN?=
 =?utf-8?B?R2tEMVZ6TVlqZk94S1pEdFM0L0VvNDRUUEhBa3MxTVNWV1pIc2hIVUlJMnBr?=
 =?utf-8?B?VjJsdUN6YVdoTFlkeTFESXI5TEpmQnkzNkdBREs3K3BlMmpyZ0ltaFU1V3pz?=
 =?utf-8?B?b3ZIaFpOVFRoRXlUd3VNWFVoNy9QbWlHZktKS3Y0bU1LZ0sveFdRTG5seURX?=
 =?utf-8?B?cW5BWU1EM3o3MTA2cEZ5T1N5MUNuVldpdlJFUllTVHEwbk1Wdi8wUmROOFNm?=
 =?utf-8?B?OHd1QUdwYW9GRDZRMnNBMUIvbmN4Nk9VSzFubklsMXBTbEg0dUVGOU5vdits?=
 =?utf-8?B?SWpaRzZqODhJOUtSNGd1TmRJSUhWVTRNRkpIa1JqK2dKWlB4VkJiVEN1d1JM?=
 =?utf-8?B?RUZ0ay92UllZb0JLeGFidXJCZXJrbkJVdlNhY0V4bFpENGhmdk5UYWx1ZU0y?=
 =?utf-8?B?MGFZUTFIS2xyYmRxQjROTTd4RktOajdTY2trQ01QbHppcUtGLzM0MmlYSkRs?=
 =?utf-8?B?eUN0MkdDSFhuRTRZOUdJZVNFYW1YU2lGS1hzTG5KRk5qUGFIeElkVk5SSFRJ?=
 =?utf-8?B?RkYyMVNiN2Rzd1lCLzltOWtFSWpFa3JGNzJyTDU2enp3VTFqZmlOZG9lenh5?=
 =?utf-8?B?eVhKR1N2OTNSaDVxTE9jKzkrL25pWUoreXcvSzRic09WNElhVDU5eGpEYlAy?=
 =?utf-8?B?ZHFnTDZvaHkydDA3V1lpVmZ6SHkwUUpqYmxnd21vZE9JcEhaelFRY0pJbU8v?=
 =?utf-8?B?d3o4Qm5TRVpWZ0pIazg0a3ZNUU9HWDc3Yk1DVytNT2laODgyUXBvQ3FVcTky?=
 =?utf-8?B?eFRuQ1MrVmdYQ3hJeDN2aXVaZVhMcnlhenpST0RQTHdzcFV5ZlIvQkU2NEN4?=
 =?utf-8?B?em1rTkVHTld5UjlCWjRiRG5TdlRFT3pLNzJXcGNCbzQ2ZDZQaWNXOExrd1lR?=
 =?utf-8?B?UFl4ZEhrdS9hclU5Zm1YNnhZa1YyQnBjSnVrUnhDc29ob05jdmpzWGZOc1RS?=
 =?utf-8?B?YjcraXM2Qmw0VGd0QmhYZFNiT1VSM2VrZVJuU2xXSS9peDFBMHYrNkVLRndl?=
 =?utf-8?B?R1JoRXlvUm50ai9JaDlWRmkyMnpDUXphNGs1cFJ6bHpFZ3FaVE1PTVN3dS9G?=
 =?utf-8?B?ekluUjlLekp0MldoNm9EbnRtTkJ3R0hWOTcrUmk5OGoydk0zdmRzRXFiQzlR?=
 =?utf-8?B?b0lrUVR1NnY0R1lmd1AyTVpFYzNUbzlOaU1jTzU5ck50OHczaG84dz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b06d9e6-5dcc-442d-efe5-08de78269cba
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 06:40:36.8079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +D8PXpuZ3uKcXWlamC1CHGvCKP9RbzAJmDIXfWRfittQ5VIBuW+T3GVBIdTKlj7bQSgMPLG7ReGOdlMuw2tdag==
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

From: Ye Li <ye.li@nxp.com>

Change to use default board_phys_sdram_size implementation in soc.c,
which will call SM API to get DDR size.

If board has special implementation for DDR size, then board_phys_sdram_size
could be implemented in board file to override the default one in soc.c.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 board/nxp/imx94_evk/imx94_evk.c | 7 -------
 board/nxp/imx95_evk/imx95_evk.c | 7 -------
 2 files changed, 14 deletions(-)

diff --git a/board/nxp/imx94_evk/imx94_evk.c b/board/nxp/imx94_evk/imx94_evk.c
index 2aeb21c1de7..4731b79b55d 100644
--- a/board/nxp/imx94_evk/imx94_evk.c
+++ b/board/nxp/imx94_evk/imx94_evk.c
@@ -26,10 +26,3 @@ int board_late_init(void)
 
 	return 0;
 }
-
-int board_phys_sdram_size(phys_size_t *size)
-{
-	*size = PHYS_SDRAM_SIZE + PHYS_SDRAM_2_SIZE;
-
-	return 0;
-}
diff --git a/board/nxp/imx95_evk/imx95_evk.c b/board/nxp/imx95_evk/imx95_evk.c
index 620a69b53e5..99a37e0593f 100644
--- a/board/nxp/imx95_evk/imx95_evk.c
+++ b/board/nxp/imx95_evk/imx95_evk.c
@@ -14,10 +14,3 @@ int board_late_init(void)
 
 	return 0;
 }
-
-int board_phys_sdram_size(phys_size_t *size)
-{
-	*size = PHYS_SDRAM_SIZE + PHYS_SDRAM_2_SIZE;
-
-	return 0;
-}

-- 
2.43.0

