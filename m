Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01158F8FA6D
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 12:25:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EADF683BC4;
	Tue, 21 Apr 2026 14:25:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="us01KyPI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1319A83BC4; Tue, 21 Apr 2026 14:25:08 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 260C9801A9
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 14:25:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYtiBLZgLQVN7xRx/Z7zogX9nnK05RMHtpt9fEuXnbKZGZCiRZti2H50Yk+WOIjgAFtTyUBPT/ipRvsTtsjCSsMDOjRXDa8qnjlCMBGTl64Q0KSRICm5cEDe9f6rS6o+NESdo6UGBLTTfxFAw+W3poJ7byEI/eMm1GifOSf52kgaXlH0hHQSmBSg5FuNcXWy6E2qr3iwFkw1ev+i07aEdThGsoot89YsLZ7/m5Z/VYSEyOr4Ev9UXVUF86P/KiK0IglM0jGbV6v4bhHKfumaEen+R3f3S1a3HbeI5zo2p7OykHbuyHKEmwh7IcRn0nZlyJSwF5LDVizYZoSnj/7GBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqtJKKbwiH3tBBLpkClI3uGHicK7CbwA4muUvaIN/W8=;
 b=vLLmPQgULQ6RdXdnzlSZsSKB89H9iplyKrLCIP3LpmUeDUR8oBOfSVTDQ3bSIaVQuoI20R39P83Rdtl+7hTHOUsbPTjzrAYGvt0AamIT/TMjqRgzxmjqElT0qlf9KxkHXrONkFpoSA25pdw3M2lNee5A12DhfTDCoqdHgeDvNjKP6U8ylFwJzw7kJn5E8bhui9TD78nS6W0YtqY2NvwTP7klC/khPXejyoocqwWDzK7gtMfZvMnWJ/1+tVx8doG3B6sgRfmuoSuIPTWjwbnFE9IqbptHzdnJRDGnF9L8vU70z2TP/cdrgCUY/+dRg0mI6zU0a886p/CwowK/qZEk5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqtJKKbwiH3tBBLpkClI3uGHicK7CbwA4muUvaIN/W8=;
 b=us01KyPIR6PPcURkZA2J7FerSiXoLmxbjotj3F+SPBMM4MYWn19ekgnnhBr06VnVkkW0rJC9/wAcRNJntzuCjSAGMcv/fW7pUSwQp4fRWX56QC+OA10n6DhjLcBLJ8nSgHQSFd+Wl27mnza00nOkrx2beZp26T2gZkkQvvvKy85KmY6PbUMTEEB3YnKzXKEDDQwJIq5f/cnd435FW8A/pWZnYg9DzlCAE2oUz7Un2A+vzmlaQzAUBu1wXh5Op+9wTYo/uiFndHpODKPQmsRFOHeWEIMyddN7AIikH8I2Xfrzv2/rB69/FhuZd5hlbsITjyxfcslcgTeDc2l4XsX8ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DUYPR04MB12667.eurprd04.prod.outlook.com (2603:10a6:10:65d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Tue, 21 Apr
 2026 12:25:04 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 12:25:03 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 21 Apr 2026 21:41:14 +0800
Subject: [PATCH 02/15] imx8mq: pitx: drop redundant gd clearing in board_init_f
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-imx8mq-dm-pmic-v1-2-0e2b490542b1@nxp.com>
References: <20260421-imx8mq-dm-pmic-v1-0-0e2b490542b1@nxp.com>
In-Reply-To: <20260421-imx8mq-dm-pmic-v1-0-0e2b490542b1@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 kernel@puri.sm
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yannic Moog <y.moog@phytec.de>, 
 Ye Li <ye.li@nxp.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marco Franchi <marcofrk@gmail.com>, Alifer Moraes <alifer.wsdm@gmail.com>, 
 "Lukas F. Hartmann" <lukas@mntre.com>, Patrick Wildt <patrick@blueri.se>, 
 Marek Vasut <marex@denx.de>, Heiko Thiery <heiko.thiery@gmail.com>, 
 Ilko Iliev <iliev@ronetix.at>, Angus Ainslie <angus@akkea.ca>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MAXP287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::24) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DUYPR04MB12667:EE_
X-MS-Office365-Filtering-Correlation-Id: 705cbcee-b0e5-4067-4dc0-08de9fa103ad
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|366016|1800799024|19092799006|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: zXm5KDh2mFgV5RLdeDfGuXsKXviHZs+uRwxEzkRzp0QpsZrOq1JK7YPij8IZluEug2CcWfxhYWAoCj0Bhhg97t3kxVOv+cnk/jGNlyAGvro3A8Y3hiYLqxqg4x9k8mEzkziiTXwESJ68eiLOag83OPtzMCmujesiFnhxwGr98sop/n6RYAPXTOD5aZXzxaTKIreRXyRnCKc89vRiV6y6Nr7u23AYLp9ZspbMTP1eZX4t5YdlyPvTV/52b1sqMnllmya3ZR2s3fHV0BRtREAi89wbXH+hRdjO0jwQnFeFMe4AeD4x2Ia3XR5Z7MF5RCbhydld0oDXFlp/qYXBgi3W1rAsn6kvb+pVa4ye9PqoG6AOXfCngtrBNrFMReRt7IiTvvNvStkmEJ9s/Q9hDgdKwxF54LB8ra5POlsvadf23l/aqNj4eFhic9g6CEWMfX5nTRBMTjEqqrQGUCoP8/7UM2GGLrEiiqtN3jIKSeXtsyu2Am+DnEWW9pRgF60pvVYNLCv/hVws2B07za9xiwZBkzk2HFFmyGAKylCEtV9IzVKn0eZLhWkZNjSeYQwasRdssR2QqkCBoBGJP2HEqB4dDmdaGHI8p6Th17msp2YhzFP6gMGHVQqJwRDAqDLAfVLOPoH9ctpTio19ufB0qz8HRObH5YAqDEAgn1OnTWfMOoxrzeodnHiy3EtOB6HmXzHA6GJWHHBKvib/3MoIGgYu7oBJOrRiLRDd06ug2Nw6DQJqIrYhI9FCYkKZf3gth69jpAPI6n2m4KllEElsdO1KKhve8GX5XyG5hrrdwE2wsaI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(19092799006)(38350700014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVRHMDY0eXJyNjFxdzRQM1lhY2FDbkFXVkhrSEdBWWFjRm1EMzBMTmVHTTIz?=
 =?utf-8?B?SFlEdFl5NythUHlUWkJXeVErMnArUUw5OHFnc1A2SXR3UllBeHBxZHFUOWx4?=
 =?utf-8?B?NjJMZUpWL2JWRGFzcStwbFhDdVVZNG5VRWNYeXkwVlozNFkwTytqbEZYNW1o?=
 =?utf-8?B?bGRyTnVzbHEwbkVYQ2l6OHZpcldPZHdpYWJ2NTRHa3NNcXdPQ2tRbFNmKy8z?=
 =?utf-8?B?dDFUOUhJanE2TjFaN2hZajBJWk5KYjhScTJZRnJzaXVCWW5EdnhDdGN1MmtR?=
 =?utf-8?B?enI1a05ONzhlellCNWpJNFFMRTRTWUF4WFdqbE5FWHdCaHduUGNld1p3c1RE?=
 =?utf-8?B?YmVRUi96anl3dXpLM09xM25BcGFtZ0tZOVo3UjNYalk0NVg1TElDWkdXK0F4?=
 =?utf-8?B?VGlQbm5PZk4yNld6R0lKanNRNnFqa1FURVBKajZtYnJXalhtNFJSK3RYMFpE?=
 =?utf-8?B?Rkt6RGZGcFpINjVoQ1J6bmNFS0lrcjNjc2s4NGlRY2QrSG5Oai9pV1VlV0lM?=
 =?utf-8?B?R2s1TlNLdWwwU3MxMnhvVGRrbWdPY2RSK2svTFcwc29zRjh0VXluQmhoS2Yv?=
 =?utf-8?B?MkNxYU5iWkRoVWo3VlBoUW96MGZnL1JwM1hFMlRrYjJveE8xOGhzMTI1T0Rn?=
 =?utf-8?B?MFE0YkRhcllST21hRzFySVpXYzhuZFRTQlp4TThwNHExUnlVeUR3WEpiSFZv?=
 =?utf-8?B?SkVUVU9iMW96RTZ6UTEzZkhhOGtuWldkbkV0bFNCUmMxVmJXcDdJYU5JOXFN?=
 =?utf-8?B?ZU5RUmlYZitlYVVOc1h2MXlSQzY2bHF4TW9VaGVFQ2NLazBlcExHdm1PeG4v?=
 =?utf-8?B?ZlVRY2VCZ080RXpLZGY4bUdTbDJNNGhOZyt5R09pNnRMcTd0SFZubG5Wa3Fr?=
 =?utf-8?B?bktsYjVsT1Zxa09WUko1dVhTbGpPZzVVU01sWkNza0g2cnRjZC9QbzR3YlZr?=
 =?utf-8?B?YVlYb0tVTEgxdU41WHJhdVdCKzZDVHdZdnpiTFpUcm9sVUZFTWRUMXUwcWl3?=
 =?utf-8?B?UXZkNzIxcm13TGk2cHp6S3NSdlpsTVRYVFJJMk42ZDJ0ZHZzZGR2UDRyQXJ0?=
 =?utf-8?B?WUplTDAzVnduSUZBMlBqSkdzY1A3T1NucVhnT2w0OWVWV1pyQXR0UFdmRHl5?=
 =?utf-8?B?bW5pMlBhU2FhRFBFdDJqLy94V0Nmci84SzlGK0FTdURDeVhSVGNsci9ZVmhK?=
 =?utf-8?B?bEJydWs2Q3J3Sk5oZnhrckVlSnVvdlM2dWRPTVV3WTBUTjNxT1ZuT3RmTXBM?=
 =?utf-8?B?R3FSd3g4YlVnR1VtN2xYSlpobm1MUDlsTHlHN1FBUzBPNGtra01vNXRQcS9M?=
 =?utf-8?B?SjlPcnoxRXVaT2d3cHV5UXVKNW1OZDk3Y3NVS1NvSFpvZlp3akUvWWlrZEgy?=
 =?utf-8?B?YllkUHRJNWR0OUd3azU0ZEMxYjFzalFHd01SREZPRCtySnFUMncxcUR6czJJ?=
 =?utf-8?B?Wmx2L095VmR2UUpNY3hYVGFycFZYb1ZWRmFaM0cyYzFWbzBQcEhyR1pFVWUr?=
 =?utf-8?B?Skdmb3VGUDdYTnJRQlJUQWhHa2swWGxXcUsrTEptQStGbzU4MmJDb2prbmxV?=
 =?utf-8?B?U1FBK1U4RWRYOXhNQ3ZJT3MzbTV5WFRQK2JEQXdYUTcxZXNEcmJtL0Q2a3V2?=
 =?utf-8?B?bW5rSG55aWk0WFlTdG1uditwQmNMK0lLOEN2dk13cTJONXl3VjQ4c2FOeGlw?=
 =?utf-8?B?T3IvWXZLM0Vwc0NqUVVsekVDLzc3UHdkVHRtZFFJSHJNem1QMlhpcXB2Q01O?=
 =?utf-8?B?Qm5wd2JqNnVVZFhOSmNMMU9Pd1l2YXJYb1VMK0kxWEFmekZQOHJNRkZTcGRH?=
 =?utf-8?B?eXQ4QzdEbWVseVA5SjRkYndLcEFmemFoUmw3S3pCVFloTU5jMURrcUZqeFFT?=
 =?utf-8?B?QkZ2OXBnUGhyeW9ScWtLTHMzblQwN2JZam1YSUxnQWwyMDdqamQvQUxOZ2Uw?=
 =?utf-8?B?c0ZRbjJPaUR2bHplaXlVTU8wd0c1MnBEaHBCMXRKT0Zoa0wwUER5cmVrZk5s?=
 =?utf-8?B?Qy9aeW1reCsvdVQrYktXV0Y5V1RWbGdQYkcvcmRobGVTVUR3b2gzL1lLVGht?=
 =?utf-8?B?RWNjOVJ1RERzbktRaDhiUFJWSjJJemY3R0t6NUlOMEF3N1Y2MVN3NFRXNGpU?=
 =?utf-8?B?Q0dpdXhGQ3U4M3VLQ1U2VjdFamNwUmZYVWxuZHlWRm5jZUhkWVVJZnJXYWZa?=
 =?utf-8?B?eHdKbUJEaFc3VHErN21ENWVSOFZaZTdYTGlla3ExajlZSnErZ1RkVHlpbUVi?=
 =?utf-8?B?YWYvZnJzRTRWai83SlVGTk9nVEcyNzRDK0Fqa091dDB2cDNLRy90cGtNV0Qv?=
 =?utf-8?B?NkhNc0ZDTlZ2TFhnU2ZUbGtDRGtuK3pEOVlGS2JZeEJvN3pSaEtLdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 705cbcee-b0e5-4067-4dc0-08de9fa103ad
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 12:25:03.6971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: urp+esCkiGkY5sVx+qhrq4QfD/DxO2TZepz8o4RDI2U39kzWjyfekBagK1CBX1lwhCROZkZhTdRXPCB/ZmUFFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUYPR04MB12667
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

The global data (gd) area is already zeroed in
board_init_f_init_reserve() before board_init_f() is called.
Remove the duplicate gd clearing from board_init_f().

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/kontron/pitx_imx8m/spl.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/board/kontron/pitx_imx8m/spl.c b/board/kontron/pitx_imx8m/spl.c
index bd5981bf694..b9e864d3f05 100644
--- a/board/kontron/pitx_imx8m/spl.c
+++ b/board/kontron/pitx_imx8m/spl.c
@@ -11,7 +11,6 @@
 #include <asm/arch/imx8mq_pins.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/clock.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/mach-imx/iomux-v3.h>
 #include <asm/mach-imx/gpio.h>
@@ -26,8 +25,6 @@
 extern struct dram_timing_info dram_timing_2gb;
 extern struct dram_timing_info dram_timing_4gb;
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static void spl_dram_init(void)
 {
 	struct dram_timing_info *dram_timing;
@@ -261,9 +258,6 @@ void board_init_f(ulong dummy)
 {
 	int ret;
 
-	/* Clear global data */
-	memset((void *)gd, 0, sizeof(gd_t));
-
 	arch_cpu_init();
 
 	init_uart_clk(2);

-- 
2.51.0

