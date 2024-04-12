Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92439C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 13:25:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8043881A8;
	Fri, 12 Apr 2024 15:25:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LHj0XHnC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA1CF87FE8; Fri, 12 Apr 2024 15:25:00 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C91487FED
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 15:24:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U92crY4rKd0gIRRYGJG2n+yA/nDJEjHP2mf2Zn8BKcmSxKxGyviZXyIwRmsNDdtt/SuBQJA9C91L0QYknaz238OBB+KvT+vtmOW2Cd0NH2s407YxNGdkVGq6DVLy6bC90Bjhq0xU/qL5OvH9JBcSvo7/ud+tKsjl97e6bqkYWmRFMY3XP7oQYU27Kz7iIao0zHWcgdTNmyGgml49inkFpAI8HUYpqWmGse/cZNHoR+hvmXnWigM0zvVyBKMDETLo14Z0GPrUAriz09pfmxbiAVri32xxh6AcufFJkzDpIchKFtEJnoyy/egJKJQn8xM4uCfR1eRmJVrRbfvxfpFVtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2apRpJ7rgh6shHzqqLbCaAC+wmcq2NUoYjF1/VDY0b8=;
 b=g+67ooR1whwARNKkNp7HcqjtUW0efaYwQ3jIYOMM+d2rtwEe6XzSGQz5v1guMLqf82I2tybesF83neozWQhuPYVaMCW5RQceG7IXL/y4h/wVKVP/qmqySqGJpZYlE+j4BF3OwXBDyLYIJpS8N7QREiXy/KXEcpjHSt4nLRI78Ax5mBnOQ+8kQ/zj8KyKRtnvbiVYuIvLCbTElkujR6SRcg8TPKuBwE0ExdObccUFLPCYsrJ3wC40fzhj6IiHgxrkKJT8QCXhqF2auOhTokHaW6t6OShkhn2E8vB4g2YE90bJxJnQRXt3E8uU625p/KJtq9hiZVqONxEczdKD+1jCSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2apRpJ7rgh6shHzqqLbCaAC+wmcq2NUoYjF1/VDY0b8=;
 b=LHj0XHnCF3KRwJgi5sm8ZSxcaZWVAGTwy2J0ae49ZBtFRaq/qJEg5a+aY9MIJu5EY6eb8gTgj/SYVF3MqcAGcbVnF7O2sEVOIZvU5K92obHUCpmePadoO7YtSVdixWulYylPacVxZTdBM/w8cHN5k87Gql3JZdzAvggmnsnbI5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by PA4PR04MB7966.eurprd04.prod.outlook.com (2603:10a6:102:c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 13:24:57 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9d65:d883:afbd:7f54]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9d65:d883:afbd:7f54%3]) with mapi id 15.20.7409.039; Fri, 12 Apr 2024
 13:24:57 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 12 Apr 2024 22:24:54 +0800
Subject: [PATCH v6 4/5] clk: imx93: fix anatop base
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-imx93-of-v2-v6-4-c2ad48e46eca@nxp.com>
References: <20240412-imx93-of-v2-v6-0-c2ad48e46eca@nxp.com>
In-Reply-To: <20240412-imx93-of-v2-v6-0-c2ad48e46eca@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9416:EE_|PA4PR04MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f1735d6-004b-4b70-26cc-08dc5af3f2c0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U+H0Fj3UdXHTgT+AjRjqxUpLMWL2d4LrsfF1QlcRMeJnfCEzu8G41PwuARPLiR0L+d6zLJsgF9TPxRYxvtsD5Se20Ca60/t8/+8weB4KsMTMWZ+opbjP3yszP3ppdkp7UoBWXcbnXLbbFGx/80duN9uUpfQIIwQbM6w65hsVwob4Cxa3s6jQ4OmGQs8UQKYOvpDoi1PhT6LDG4PSwJs93cfhek0GDI23dcqo1go6yYOwjWgsbCOgrbTaBF/VyiVO8ni7WTgvZOIZ3t5Tg+R+2GIqIaPBbPSvpItq/j44euTdLDotFi3H1R17bLbBsPo//LVxaeLcz8BPSa9kZsCu+KHUBMuxhSxiZjLMGNX9JAu8Bx7ZTqkbnZswe+zN9UC+Cvn1/D3w1ApL4lRO1ziSPB6UpLQ8ZDwx3Tx7O7flPciXlYlgnL2BIwyW1s3oIbLXXUoaG+1xAcA/ncZAE42gfgJwdBlhLvi1iKfqpr7LBpL2lSbixbtQ8bb4Qv+QWxckdBVcCHcwxqfdbQZbSYHOHNBJIq3QV3rIO5u9MJOlyfBSctl/u5UG1zAIU/zqghlSGcb9mEj9BKm1oYbhtaNprqcAg/v6bOd5wevrzZ9vUzTYmEF8PWUzCkcFnjw5MhT3/YQLY7wvSUMwO8geXkQU/KVXLwzXwW0+3zxHAMwFQXDSKS9Qjt0w96hHzsnM5kEoJCcMRigxtLbLdaMSbFjo9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB9416.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(52116005)(376005)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0trMFhtR1hGdisxdDNOMVhkcUYzWC9Ld2hTQ0dWaXdSMjdPSWRtKzI4MnN3?=
 =?utf-8?B?ckV3K05rTE1CbzRnWVQ0Yk5vUWh6dkVsVnFZdHB6TmJaNVQzVEVWZWZ3b3FF?=
 =?utf-8?B?SkY5ODFsSCtCWVlwNXZJT2VCc1RWdU5LVXhhYTFBaFpYZjJ4dXhxZ2x6N1dX?=
 =?utf-8?B?N0lyTzZiOVFQbU5FSnFIT2wzUVFpcUJwYVhZWkEza3B0bm1hNzkzY2p6K2NQ?=
 =?utf-8?B?Q1FuL21nZ0pVa0dJL0J0V25IVXljRncxbmg5RzErQ2hXSjMxakNBZXRKQmN1?=
 =?utf-8?B?Vk11cGVJUFJaWGQ4eHJRclBLOHB1UDloTE5haGNnZVg4VTR1TndoU2ZkUFBK?=
 =?utf-8?B?dWx5Q2J0RFhIK00zMHY3enI5SGc0cGYxV2dFNlRNb2s4Um1IckU5OXNiNzA3?=
 =?utf-8?B?U2lsSnVoY2cva2xRMCtIODRCTnRlNHJxb3ozWnVZYjFTcG5BcXNUUm0zMDh5?=
 =?utf-8?B?VWYwcm56Y0o0Z294QkhWcS9vTjJSK0RpdlJINGhPY1NPS2pCaVlKK096eGpZ?=
 =?utf-8?B?NzNoTVZHYjhxdVMvN2lhVVdoSjFjbjI4MmRqYUhscldQZWZNLzlOK2pPVzI0?=
 =?utf-8?B?VXZ1WndQTnhNNDAzRFIwR2liaGVhVVBjMFlBaStVWXdGem8xZEhqK083d3ZZ?=
 =?utf-8?B?b0VsMEc1bDVibmM1TFFCOTZRdE9FdUlUTzlGOS9wYS8wWVBSZGhmMXJmZTFs?=
 =?utf-8?B?aWRzUkxvbnJpWEwvbldnQWZwMG91YzkyV1VLSUZmM1FiUkRMUnVLNkpmdndB?=
 =?utf-8?B?dFlZZFhoKzRLV2psY2RvOUx4VmVvZTU4blFZWDc4aDh4WFRIbndidkcwMkUw?=
 =?utf-8?B?blVDcUVnTnMyUWFuZUxuMnZualV0YjVqWXVIa1VpTTczbnJ4cVdsNkFZZmh5?=
 =?utf-8?B?aE1aa0lCNzhyTUNFc0VyN2lieUVvcHhSdXFXbTJZMDJUMUpGaXhTZnRNbEZz?=
 =?utf-8?B?MFpBQ005TUFUM0p0M3Z0ZFRST05nZVp2b2hwbEZUTExYQit5aFcxY2ZmR2o4?=
 =?utf-8?B?ZGxWQ09YWHBiODZFd0NWSEk3bHNNNUNleS9SeTFWcyszNnU3cGhxalJlRlJ5?=
 =?utf-8?B?a3A5Y3pCWVpYVVFnRnhPSmpHS3FYcEF0TXFzamM3cU1BY0RqRHlyVTRBVUdt?=
 =?utf-8?B?dzNTTHlXQkFwc2lsM3lRTHVqYS9aUTFTdWRHYjBacEoxRXVERzVwZytNa1Q2?=
 =?utf-8?B?ZU9ISUVOMFJiZFdkQ1pOT2NrWkk5cTFMckdYWVR6aXFuVnNleHpwVzEwNU8y?=
 =?utf-8?B?S0RNRVFldTNkREllR2hkMDF0Z3R2V0djR2gwMnJIZTBPNHErK3FUcG9HTzN3?=
 =?utf-8?B?N0JoTVUrQit1YnRVQkF2YWwyd2dBUDVvcmF5UkhyeVNsbEFkbTZyRXdoQjZq?=
 =?utf-8?B?UnhqVFVJVjJqOHN4TUphZTJoZUp5VnE5ZjVYNmgyVEluQXZMeS9jRlBPRUdY?=
 =?utf-8?B?MmNqREh6WmQ1TU9JdTNWbHhQL2xjZkRVS3FqZzlKeWtubVYwVjJTT0h0U3pD?=
 =?utf-8?B?cE5LNUdobGg2N1NINDNYMExMamtFOXl5Ym9nWkJ3QWJ5UXZDN3p4citlVXN4?=
 =?utf-8?B?Q2packNtVXdBdlBzRzJ1STdPdUNwcHowRGtQVmJJYmp0bEFnNy95Z0kwSEJj?=
 =?utf-8?B?d1ljdkE5d1FpQlRiaUdhendSOHNjQkNscU9tNFdNTXNLbGZIZlpLdzJLRzZx?=
 =?utf-8?B?NWJ2RE0xb09tUzcvTWttd1gzcllWZ2YrOERxVTlQNEdTOE4wVW1EVy91eWp0?=
 =?utf-8?B?d0c5OTVrYWtyQ0VnWUswY2kxbXN2OTVWS09JRHI1RVFiVWY5dW5vbURRb3BO?=
 =?utf-8?B?bWhISWx1ekU2bnRPdm9LNWN6Q2NqTDc4U01SZFJNNG4wWkNaMDcwcERjb1pZ?=
 =?utf-8?B?UnN6WGlJUFhUMm4xazBDa0NWRTlWZ0tqWC9RWlF4MS9ycU1JSEJuOVJETno0?=
 =?utf-8?B?VjhKeDNpZHdpVXpvMUcySWNGS0kra3liekpJS0tGTkFLMHMrK3FpRkF5OVZi?=
 =?utf-8?B?ZkRsSlpxQkdQZXNpR3lacVFjZjJmVFRxQVFSQnFjOUNaTkplWXVDc0FMNlUr?=
 =?utf-8?B?anVzaDZWNmlYTzJlWUN1alRVaWNRZWhFUkpSUElFWXo5VmdQV2tPQVUzWndZ?=
 =?utf-8?Q?lEZkkr/AMZ7grbLr4f4DqLTa0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f1735d6-004b-4b70-26cc-08dc5af3f2c0
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 13:24:57.7285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l9Gk3M8pnYm+B5LSrVZ14UE8C0mW41Odm+9zyYgDP0RLVw8HSZJcOPLVof8ZcToreikR1MrgCY4nuq9qo/xwWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7966
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

