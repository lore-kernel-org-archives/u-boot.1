Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9434C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 23:54:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1F7F88139;
	Thu, 28 Mar 2024 00:53:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Sxya6niy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7EDD8801A; Thu, 28 Mar 2024 00:53:36 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::607])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EA318809B
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 00:53:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XChjEKl0npkavB345w2ggUDqMGiIY9dx+9TmVkk2WMsBGRHALWudDqT6yLvoV+GfhGI91TIM40kNbkf5dV7SZbPObLi6VQIYezOg2ZtDN3tWTIb7klxWcH1yniJytVF+q55Jh04e/FvEIAkJuEdTsSRa+yWIlxX/QUuwGX9r8sMvYOMgVRBqqJRjC0IcaDmURG0WJe+IurEBI0IUAi7aOVI9haBNbC6Fnl8APDzekudz+KqpW0l8sMEgfvHH9O0TXRhrv6l4DnjGUR8zDS1BGDKmIIiTlXWLAgMd+EqKnWNdXdYMzgHkOa66iOAe9HEnipmPwkkC4eZv3LYi8/r24w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2apRpJ7rgh6shHzqqLbCaAC+wmcq2NUoYjF1/VDY0b8=;
 b=RNLvM1EKZi+5XyVrtk6QAUcDTahD4j4RAnAQvsMcVXwZF/e+NJ8kuQLb54j7fes0QStiWOPA/zT+GyaN38KQZT2k8Fyb7svvyDpivQFK30MAa52LXc9N3n+naE9b9wFv+f+qTYthaU5OKR/l88qKXifHA19fp4RpMDxVDCOMQxBRx0IBWSROnePynOdHedDdOh+KQ9oCag28ASwV/cUjUt2W8myjKphVGT8snVcoYukc2GrlrMNrzn2Akal3R2cV7dp+H1yyL8GPnGctVWGQkoRsHG6EEONkgD9eNfKsCqtu9VBveG+wFYx5nVheS2QGRj+PO1ay6yiDPf4WzgrIwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2apRpJ7rgh6shHzqqLbCaAC+wmcq2NUoYjF1/VDY0b8=;
 b=Sxya6niyaDWu/sSNuAyKRy+QFo0h54oUAlI4x69uihG1bFxmHP3LqazUSgFjFS9MgOPFdYUIXlTUFxlouTLMAXMfsex9SGQ9lW/vJZ4VpOa4eL93wbILaEm0yam6ZNxrrTXEditLpMnZ2Zfc+0E3AdhW+nvUmJAfx9h2AYwxn/w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DUZPR04MB10064.eurprd04.prod.outlook.com (2603:10a6:10:4d3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 23:53:33 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Wed, 27 Mar 2024
 23:53:33 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 28 Mar 2024 08:53:01 +0800
Subject: [PATCH v3 4/6] clk: imx93: fix anatop base
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-imx93-of-v3-4-4e7f341ed7ea@nxp.com>
References: <20240328-imx93-of-v3-0-4e7f341ed7ea@nxp.com>
In-Reply-To: <20240328-imx93-of-v3-0-4e7f341ed7ea@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SG3P274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::33)
 To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DUZPR04MB10064:EE_
X-MS-Office365-Filtering-Correlation-Id: 241209f5-3425-4145-565c-08dc4eb91c47
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OL8lGLjAnYQyRyGnxyfQ8agLRMyUkeeM5Hd4KoczVQ76XK38+2SZhOwJ2I6RDsPw5uXgpcs/3VmYt7by0kxrwHiLVqG/uGGOKztPk+nYLJE9/jquqPVbVDyY4lxbyscrJevskNHWZj9Q1HyE3gugxgXCKYzVzIZHIDz9Ow/nz88C4XHxxWKLQ4xks8A/pjpEEud1+SHO0dcmVBc7GVdfK/MsAJv0l68PJozOObaijqS0pXN6Wm4syZ9WULToKr3T2V6l/ku2vxSFpgEJNVFz6XKwmZV0X4Yo2QxZe7cJvAVE2EFRjuU91chEZTtQB2slEZ00+fJCNSDMLromWr212E4WTW+VBsWb9GTFkzS/b01qGPb6MBNqPuc6xakkjPeEHm6h5+C5v0l5LiXxNIidHx7I5iO7XzmBTr8kXIk5KiasJ4VVhxH0Ezig2GYHDhMI5e4nB35SYOZbUEy16K6y+cXOs7Rp5ek0d599iJUQNA5a1zEwgcY42J8sDYFt7SFeY61D+KEagELaXxglyX4Plhavmd0jErPtsx2FJuGOW+PkqMpFNt+5g9nS3xmNBQzcYglwuXVA+ib9Rp3Ht641o3s4Ysr1EWY37T9X7UlFzx7AIGvz3JfE2mENCzPZotFWLW4q0PEOd+GusB4E+SkDr38GHVjIsA3w28Hkar6whVCPKY3/2Hz12/6hYLatuwdvXKWgWcV1hQbtSImJDTz4jg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFh0OHNtZmRzWnNSaGdrdXpVbjRHQ3NvV0wxaWc4dTlTOTJYc0FnSFN1blBo?=
 =?utf-8?B?QjB6WSt3ZFpzOGgzeUJ4OXVUQXFUMVJjZWJ4RHo0SXJ6ZEVkZWlXVVNaVHYy?=
 =?utf-8?B?Z01vQStVeTJWdVlQUzJaM1kyUUg0R3JUbTUxN1NBay9JU2xlMkk3ODVpY2xo?=
 =?utf-8?B?NDd3REEzYkdRaHdaOEgybG5Qd3cxM0xnU3hMTlVXVUdzc1ZQY3FxSWt5TUtM?=
 =?utf-8?B?M2dKWGJmSGlwbTkrcFNQNkFoS3lQb0poQys3cnRjYUlJZ0ovcW5tUHFibndj?=
 =?utf-8?B?SVJNSHJBTER4cmNSZE52NlRJRmR5QUswaTk4MzNCNXJOdmJPY1ovWjYyMzNL?=
 =?utf-8?B?TXhRSDFpVEl6eC9xMHoxMjZPUXdZS0IyRFI0VjZsRDBZcDk5eXRXZzF0K1kr?=
 =?utf-8?B?VTNoTk92dnVyZlJubjZKRDBUeUN4dWtGM2djS2JHNGYvSDkxUFV4WWFEQ0dk?=
 =?utf-8?B?OXNKazNWVjFUbUdkUFBBVVNjeHVUYndQNEgxZGFmbFYxdGoydUxPUk5vZzZR?=
 =?utf-8?B?c0tURkdwRWl3bm9TbWZKWDNWczdPSzUwa3ZQM2lrb01nbnNBOXVTV2Nob1Jq?=
 =?utf-8?B?ZWxhcThrRklMWWJoV1BtUWduY2kxOTc5UUFmb1RGVzVKcFNjQklwK2tnQkF1?=
 =?utf-8?B?S2JzbVhTSHJFankvOGNCOUJwZ09kem9HTHE5dy9aVjFyS0JrSUtGWTc5VlFv?=
 =?utf-8?B?d2hDSXNHdnpCenVkaEhjNkRhSU9oMUp2Y1dFbTFzRnNYekVEQWNGb0Q1R01p?=
 =?utf-8?B?VTJsZlJIUmZLeEdVNzlRUHhxM3FSRmZkRzFDSXp3bjNTd3FRMjlmc2VRV3VE?=
 =?utf-8?B?ZExLMHZYQ09DanNwRnVMdndoblJSTVNmQ2FiSFpGWjVGeUMyQTdNbU1Iektv?=
 =?utf-8?B?d3puSVdHcVdpS2FUKzhvbkhpWTVkOUphUW9VaEk2U1JXQU9RNitCYzM1Ync1?=
 =?utf-8?B?eTlkRERDTEFEb2MyZEFyWkd1cXRxL3doSDYwS2c2Si9JdVlIdzU3Ym5wOGpP?=
 =?utf-8?B?SFcxY1N3Z2tHOTBSY1VjemNJZ2pBL09rTlA0ditTZ3lNblJwTlhnN2FxMDJa?=
 =?utf-8?B?MlNpZmFLOEY3aFlTNFUwenRSOFBQZHd2V29LMEUwMzZJbkZ3L1NiR1MrUmhV?=
 =?utf-8?B?NWY3MTBpRTByWmwvYUxHNXhJajZDaUJsU1VYSmFDWVdwNnQ2TzB1MW1wTFdr?=
 =?utf-8?B?ZkxsNVNIUlVTVWxEVHRSY0xuc3RHbG5OM0wrdHNUYzhIanhLQnVCNHBNUVZZ?=
 =?utf-8?B?M3QzOWwvMlY5MWtWZ0tJMmZ0OFZKRDRGUGNVdWtYSWJoWC92YTNrR0xyK0RJ?=
 =?utf-8?B?dzNZbzJNN1ZDQ2VLOGZBKzFQZ0dSVUxleWNGcjVaZ3RCU3draUdsRFdhM0Vw?=
 =?utf-8?B?QmcrYUdEQTFWYzNXdHRpL3ZMU2RCTTFWVXpJTFVRaGlTY2c1K0l0RDJJTjNL?=
 =?utf-8?B?UFM1czhpV0ZYRFRFV2V5Q0dIa1lxbUtjZXM0UVJrdDNGeEovOVZUSzNOdllm?=
 =?utf-8?B?bWFDbmVWZUdGS1VoT3ByeFFRUDBsRnhpMUlCUU9QbFNLdlVaemFVaW16REdG?=
 =?utf-8?B?ejh5QWg1K1pJNEp5L3dzd3FDZTZBK0dYV25CWHZDMmRuUnR0SkZwZWFFbzJD?=
 =?utf-8?B?ZDZ2ZithcEJ5RDNRZFZURVBvQlZSVFNUalAyVEw1ZE04ekJwYS80dWRDTUhL?=
 =?utf-8?B?cWdMVWZ5SWpkN1R5elpyS1FDekFRNVNYOWdGTmlkbXFySkwvOVpGRDZmNnVB?=
 =?utf-8?B?aEw1Y3NaZlVlVkwyWXk0STZ6QVBvUzhpd09YNVlhRUFwcERWRmhEY2pJYjlI?=
 =?utf-8?B?M1FnVm5UeGE4WHNDb2UzT0s5ZXBWYlkxVDJnOFBjV0RpNlIySzYxdnU1cTBk?=
 =?utf-8?B?SGFSVkRUY09BOWh4eHluSldaNkZGSjROaVdDelFlb05jWXFDb1AzNWhZR0JZ?=
 =?utf-8?B?QWYzRGExaEhLUGhBNHZxOG9Jby96bVJONitDbWhIalpTazVFNUVjcGcvRURz?=
 =?utf-8?B?NWNON3VwSXVVZ1Z4WE52TzkyVnlkSVFwYkl4em8zZ05PdVg4bEpmcjg5MXNK?=
 =?utf-8?B?N2dHQTVRRnFXRkNlOC9Ec2t4dWFSSitaNStCVUJES3haTlRMZUNzMjlOS215?=
 =?utf-8?Q?KdL9MdvLBs6r1FtFl0zfuktFT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 241209f5-3425-4145-565c-08dc4eb91c47
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 23:53:33.1207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cE7FWPXnHrfltIOLkMKtfO7C7qAqKNQjDsBNALnSgCgSTMZ5QGTqy85lPiQhRXW00NGFEjsawHErhaFsEdiwBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10064
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

The PLL clk needs use anatop base, otherwise wrong PLL address will
be used.

Fixes: 9c153e46661b ("clk: imx: add i.MX93 CCF driver")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx93.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index ce10d795316..f0cb797d975 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -289,7 +289,7 @@ static int imx93_clk_probe(struct udevice *dev)
 	clk_dm(IMX93_CLK_SYS_PLL_PFD2_DIV2,
 	       imx_clk_fixed_factor("sys_pll_pfd2_div2", "sys_pll_pfd2", 1, 2));
 
-	base = (void *)ANATOP_BASE_ADDR;
+	anatop_base = (void *)ANATOP_BASE_ADDR;
 
 	clk_dm(IMX93_CLK_ARM_PLL,
 	       imx_clk_fracn_gppll_integer("arm_pll", "clock-osc-24m",

-- 
2.35.3

