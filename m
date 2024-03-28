Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C9BC47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 23:47:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFED2880FE;
	Thu, 28 Mar 2024 00:47:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BL+ppqST";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C098A87F36; Thu, 28 Mar 2024 00:47:28 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::60b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24065880DD
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 00:47:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dG5FwUHmzunbKc7EjdOlnmvCpdKF+h0pwMkYq9SmTWEUH634lyF197wqS0qGuq4t3SZL1hVYNMyltCdnVerxuBuaVd4dVGp/D+2ICA0zuWDF9AkULLtTmFh+lg/UVVHyO4+o+Jne8785ogGp6dVQGI2jNSaZTXY+OUDGvhp0vKUmOPozJhMj8+b46+CLWuPspmbciWWJJHX6bC8RZqqZPYBqnPR3IWUbMxLhRl32qhz0RI7OpWb1cHkYPOV31Dc8JkMXcxNMeAa7yMw/kTosmkA0dA7hY+g7DG8lhNHeBIqOAJINpJpIHMOLoJM96EsCIXrSzc/IjIm2Th3x5i+3Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2apRpJ7rgh6shHzqqLbCaAC+wmcq2NUoYjF1/VDY0b8=;
 b=HCaZTWcIwxz53ZkNzHIrPS5K+b6S1lB2lSWDNXOT5s5q6eN7QTQW4qGasIhK4aZfi9qLnVaRpAl+jDIDUQXEwej86YpazQ7tadJja2nAifC/FiYSXgTQz2MHif29eFkfl1JVcZ0HXQO1XXnSha6Pi7d+u6DSHukACUUqq+NEOLVfa20o0KzSMtTccrZVzpl1ba7gLcAXxaRi0FUwVeZCTEcqm6SfhSgmECVaxHVDDixu5wLb/celgfl6cZIeAUx0NglqYpN14jz53TpETyq1x9R4rU9mFirlT3Nc7rHV5duDl/tRbtrqOHcpHPONYaTWy27lG3SlZO6Pyu7Dhjn0WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2apRpJ7rgh6shHzqqLbCaAC+wmcq2NUoYjF1/VDY0b8=;
 b=BL+ppqSTUfyCsILPifc9L5c7yvhiIVmYdhylNZ2ieCZlz/CzG6baTHkY+nwgixNPQQEqYa/1kMPGfcHsJoNCvUMRUjJUhyP7VV04EivsRUpPJ/WJB+NfldN7LWJqI8/trAqWS9P5VpG2oeuTC0vq4qieQxDqVklF6AQm6coyTeU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS5PR04MB9999.eurprd04.prod.outlook.com (2603:10a6:20b:67f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Wed, 27 Mar
 2024 23:47:24 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Wed, 27 Mar 2024
 23:47:24 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 28 Mar 2024 08:46:50 +0800
Subject: [PATCH v2 4/6] clk: imx93: fix anatop base
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-imx93-of-v2-4-909f5d37da87@nxp.com>
References: <20240328-imx93-of-v2-0-909f5d37da87@nxp.com>
In-Reply-To: <20240328-imx93-of-v2-0-909f5d37da87@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SG2PR01CA0177.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::33) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS5PR04MB9999:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bc4a48f-5833-4aaf-95d0-08dc4eb840b9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: npoxJW//+ZHylu67NsHP9T6jyhyGs2BkejAzaK7Mv3Y8vhdwhVC47u+vpQd3Ud3WeucI4AWnCphq0hUzAzIaReRC+K3imrsuNqApq6uCp1BecbCWlzx0C3FVOYY20jhyjptW5CKC4Jidag3K+HBMG7HPC+54YltgqGYjCGlO7pkO+1m7qNA/rM4gTcnUxbTCFVwFmXv3Ldc7B5chr/r7zLYg7GAuD3J+6Wr9k3uD+UBFQIObMSMSx+m2qVe9Qk52o7oqgoQOd/TRh7lGutX3PoU5WtGkhyOrhkU5Tc/ZKFRkbU3uuSE2sgUpncFt63ghp20dJ0NXbM1+r7c2YLxkP6ucwopYo8TafDXiKV2uYvBAuziewZ2zVti5zEPbB+iftWCmxW+rvkLRSpa22ZVSjF/Ck4C0n+koyv/iYb8//AkbFXak3GboUJ173ds4utTLPSzrdl+UYc1yLYSF12wtN+W7PdQtGfeK6ttShXeXM+WRAQF09mvdNsvxUUlf1cF4ANwLS18HEIwsrStafhyQA8gy22fZi2QnlrLmwcm/Gsvjjxy1H4xVvQRz5BTgByqK6E47pkaiIDTFJiYZx2Un/EJPAJKmDgWXRcFsSWZ36UZw5Ym1+qvpn8fGhoQ32GFx7rddQkT3IgnmOI+7HYBZ/XYAsxKo3xXcnaEPAPBZcaChMdLtDQR14me7FFMJ35KE9Q6f/I+wga+tygot0bEs2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(366007)(376005)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVZPR0g4N0lNbllSNFk5eW5JQVRrYjVaVFhMRDV1V1pxTjRZZjFLaFlXZ3lo?=
 =?utf-8?B?cFAwSkJHSXRDMUQvdGhKQ0pWQVUzZFZtQllWSm4vdTRzMXlCZnFvdjlrWlpv?=
 =?utf-8?B?REVBWWJkcDRMNkwxbkd4SmRxOVQ2eEJxUjhqdHRlSVVHekVtWWVwbmJIZUVs?=
 =?utf-8?B?N2hQV2dzZFJKYUlIMFlqZjJMNlgvL1NETFkvZmVxdGlVNGZGMnNDaE1XSUN0?=
 =?utf-8?B?N3FVU21BRWhhTEpOVUlVRVpWOWFuaFZ5MGlDUTlOaTR1Q25NMUxKL2FmVVJv?=
 =?utf-8?B?WkdldFRMMktjWXI2dWpDejlRTWlrNWd4RXJncWtkWEdtbUhIR3ovZGw4OS9O?=
 =?utf-8?B?SVU5akdMN1ZwNWFpaytyQ1JSUkNndFFJM1FPNWlzWFZMRXJobGlpS0Y2dnFh?=
 =?utf-8?B?Y0hpcGRqZTlJVnIzVTR5eG5IV3Iyd2lsREpkUlZaYzU0eWFhQmFNWUtNQVJ4?=
 =?utf-8?B?NG9DeWM0cGJxbUJoVkdVNTl3WHVvdG92elFTdVdFTHljak9KbG1LaUVMaXdt?=
 =?utf-8?B?cWM0b1FIQ3pxc2ZMUmlSSElweW1iUkZkd0RuTXN2MjhPZFdTUXZ3ajRkNWdp?=
 =?utf-8?B?Nm9uczBBVEFGOEVZTEM2Y1BTc1UrQlBRdVl4b1hyTVVvcjRwbURUVnRKOGxN?=
 =?utf-8?B?b1dUeWdRdnBISWtwS3J4eSt1Y1lHOXVkUjEra0JicEtzSVYyR0JwZ2FjWEVC?=
 =?utf-8?B?NG42MDNZZFZ1Q3c0RkFrZzdjcVpnTEVOVXZWaHNZNjh0YlBBajhRWDg2TDRz?=
 =?utf-8?B?aUg5czk3QTdUaFdvR1Rjc3Z5eTFkcVZmYUVvS3A0WkpYTjZLZkEwcXpCbXN0?=
 =?utf-8?B?VzkybGxoOHFNbjBOcm9KMWdYU1pNcWpDK2F0SW4zaU5UbU1HcnQ5QjFIdDFI?=
 =?utf-8?B?TTNDV1NrbU9zZkZlZU5wZi9lbjBCbzY3a2dSQjUwdzNjcGdRdDFFZWM2WUMz?=
 =?utf-8?B?eHhmdlI0TGowYmtqbERBWHBvMmtGWlg3RGtjQTYyZmFSRkFHQTNXUnpmQTBO?=
 =?utf-8?B?aVVxVDJGMDdCVFRsL01CVzJUZDUxN3QvaXNDUTlqNS9kNDQvRUxXSUc5aVZr?=
 =?utf-8?B?c0VEc2I3TG5kQWVRMFV3NTQvY05rbjdWdHBSNWFhK1Z4RTNUWExkenQrRHRE?=
 =?utf-8?B?UGMwaTE2WUxyd1lIc0J5bUYvUHpSKzAzbG9URjdGZCttVUZsam5HOUp4N0wv?=
 =?utf-8?B?TFRWczkvenNtOVlzL004bWNyK3I5eHBFQVdSYjNvd1l5QnQ4Mm5xdk43bkhn?=
 =?utf-8?B?WE10OWRkWG9qSDBEbFRSMjQwRlFUeDh2YUxEc1FzdGg0b1FYOGdtVFVWOE8w?=
 =?utf-8?B?SlVFTk1LS3RGbk9RbUhwakIrZU9hTVU2d0ZnK0UxdFh2OEU3TnFTTDJwMEtr?=
 =?utf-8?B?dTI3akNJSXF0Y3REYXJYKzAxOEx6RkpES2RVajd1Zy9ZQkcvRjJ0ZlRQTkll?=
 =?utf-8?B?ck1YT0FYTFR6YzlHWHZwOGU3ZnFZU3RialQzc0R5Skl2N1lQa1JSNndPYXdr?=
 =?utf-8?B?d0N6OG9ZUURmTFlhSmNZemFFNmxiL0trM3B1WTZjZHdtbDJBTjNSWlJ6UkZq?=
 =?utf-8?B?U0d5SHI2d2gxQ3NIMHA0L3MrL3NZNjNVcjZDajRoYWoyeWRNTXkzVmpCK3ZP?=
 =?utf-8?B?ejJ3T1VJWkk1aGp0Yy82dytVc3hiS3hScElSN0FEUzREb0duS29LUXpETUNl?=
 =?utf-8?B?eUo4dGF4dTY4MmFReVU1ZEE4dnd5cnplRjdJVVdjd3diOGw0ZDBTZlR2NHlt?=
 =?utf-8?B?YXFHaTdmdFZLVW4wbFA5OW9BQnQ1YzNRSnpwNHgwR01RaDF3bDFSQTZzMVlz?=
 =?utf-8?B?U3U0M1BCUUIwdWNEN1JLaHl3aHU3a09iamUxSWk5SDF3aTdJTWxGQnhPanRD?=
 =?utf-8?B?cEcrRDVyd0JBUStKVUo4SXdEaUgvbUFiR0VzYVVTWWNaV1B4YVRFYlFQUnY3?=
 =?utf-8?B?WXdMajkrZjR0d3VZbUxBMGN5UXBNVzByanJ0QmMyMHFYZzExOGZNd3VLL3dj?=
 =?utf-8?B?RHFBOU92ZXVjZ3MrUjdxNU9xbkxUYnBoSFJyR0lGdmV3c053eHRHYU1BdTdV?=
 =?utf-8?B?NDBiVFV2WUdpc0x2TitJY3JHZnZvclNMOVVsZ0h4YitsRlU4NlRYeExINHgx?=
 =?utf-8?Q?NFxbzORjbStx8vVDVhFOtUcf/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc4a48f-5833-4aaf-95d0-08dc4eb840b9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 23:47:24.7347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJPYYB5uLnLG7nLv17x40BGP1D6nHlGaW0XBVxqIUn4AbcfCe8hOqLRAZRQm5lfr40/be3zPU+PI45U49WA1NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9999
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

