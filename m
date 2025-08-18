Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BDECA0EE4
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 03:36:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EE638346A;
	Mon, 18 Aug 2025 05:36:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BZu3PRG5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CA89834AD; Mon, 18 Aug 2025 05:36:05 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B24683429
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 05:36:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7IDMykGBpWft9H/kS49oX5tGgOGbHu61BmdVeNSy+dpnyuOMsuPI13HPo/ca+Jr+vRYxPn3Hr4dbfuDuVKhk3wnxaEuc3RhKNEn59kDw9QNSl/pPyyrL8g/ytfhQvWKBu/im4+9lNuskLXGtlDsl9/JnmFpxzm0NUgLpt3ACE/IfPC4rWFL4h5cqcH+cX/Xx9XELTHq7jGtGhv+FCn8RSeoePEjd8C3ITW6xFQoBYFsX0n3EXzpTyVQRqjIzCq6l2B5zGuFlj2wKYRkIfuHwOexxGtEGurQoEwRHhuI3AsqlMJxbzxg8WkbetLk+66NenfX/LLcojJ4uAI/THpXSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8u/3alEtnah4q5tyDMdNPTQML/fOlkwfVzVw1Pfd6c=;
 b=g3VU1yoN3vacd5pd0/VsyPgQxus2otsEvtoLVXfz2I12ryrscxWbJjFy5LRX3zfBNtB1PUjON+Sy/Gqo2FG5HqLoMlSVSIJ4xB4z16QLTbkyYF6s6PJ4BAuibgbMAFkGXbVA665qSBK0Q9zWbGrh7uxU9YCRQwWfwkreXVib1QCNXfavksOtx11GLck1FrRKTiP+tsUJ2fz3ogKPH//6raussD3T4UZPAgq1dLGNrQhk7omBHG+FsoaaV+XeHmloBTs8gnSn9OcXY2joOKDEW2cMSHzQSNA7lEUvmZCMIkEVkfCCQTv20kTZ+9K1wQ6DZTKmGzqOVMOU+80DBd4pSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8u/3alEtnah4q5tyDMdNPTQML/fOlkwfVzVw1Pfd6c=;
 b=BZu3PRG5J8Ez5hqrSb6wox5TJUu1Z4sABYFAFQw0JwcQd2MKHzL6oMyJABA8rsdjn8HRMSXksc4LLq720mHQnTj4grYgsKADtq94mCyf+3R3YJWGACCFHHtWKmGtzjC/r+iEoydRRy3tAgs+Y1KrOI6I4O7W0HmXTsFsndvgGo0ZEF2BwfjP3IYttqvlG9QMEPvw55Z2qI1znJLNe9AyaDpOpA1qYEvVtcw/NWJd84po9Ov0aYGmUaAG9p67jMjvlmW0n3CN1eAQD/ayQn7h1KF62qNbrzA3hvK0Es3q93Z7X5bgrAX76Vt7puuAI6mBuWv71eDM8PFwNeGQHuJLVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9808.eurprd04.prod.outlook.com (2603:10a6:102:383::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 03:36:00 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 03:36:00 +0000
Date: Mon, 18 Aug 2025 12:47:07 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Kamlesh Gurudasani <kamlesh@ti.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] clk: scmi: fix set_parent support when CCF is not
 being used
Message-ID: <20250818044707.GD13772@nxa18884-linux.ap.freescale.net>
References: <20250813-b4-scmi-v1-v1-0-bef20fc32d4b@ti.com>
 <20250813-b4-scmi-v1-v1-1-bef20fc32d4b@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813-b4-scmi-v1-v1-1-bef20fc32d4b@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9808:EE_
X-MS-Office365-Filtering-Correlation-Id: 1de249b5-956f-4ca3-9ae1-08ddde0859ec
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zpLq13zGyHPP9xZL+/a/OQJFcAioJaJvW8ZxbDEOZ9fJ5GUN10fG2YcU0hWG?=
 =?us-ascii?Q?eo1QIW4JgTPuXQuvWAdZyE/YIUKYPa/EChvdTd/vdQXLZBGLKyXcw4qGy7V+?=
 =?us-ascii?Q?hBdSojNozfFKzcwz0hysnhQE+ls89jvihvzetMrtWLyE3+Hi5EQeycs4PEHP?=
 =?us-ascii?Q?LaBdSkMEQsAjuHMSQEEDJxy3AmXoKwSqIUueqa8MEw/sFnMx0afXivrx8oMH?=
 =?us-ascii?Q?LM8NAssVmi8I12NvuQnNOj7vsvLRHdLpqrpxlcJJdUZRygZ2vM0OaVckcE38?=
 =?us-ascii?Q?wqwnoV9RLqSe4J7FaZKygPspT516199jjB56u5A4n2YguGfT8lOcmWtYhryz?=
 =?us-ascii?Q?aAUKR34RqJFDFMm5qvikoyER+u8zSClc+XacZCNt/AHU0hnuy9dOu/0Gi0TT?=
 =?us-ascii?Q?sbRQpr2I7h4ca7/ZBOpgKf/lfPMXx3tV0zZplmo6rL1BQw6KNnEI9XenKwBN?=
 =?us-ascii?Q?gZDHp82KkihZPudnlvAR2ogt8qapqRkw6a/qNY9iRTly3YNLu7aTt3ujPtFy?=
 =?us-ascii?Q?e0mDzXTRPBLRXceCv9/y/jbQ+9C6BhAJimq072OyZ+rsXgkSDCTuOyKya2SE?=
 =?us-ascii?Q?Yz+UevPWkpibKHJ45pY5KQWgucnIGUq5KXNyHMeDOfFoNdDSkqJmKowQmokV?=
 =?us-ascii?Q?pAsuJ39T9pzNY4PyYsnUGJYBNjOei8ctegZru7Me9vHR5UXrRVaaMnIQ+YAg?=
 =?us-ascii?Q?Io8BrbO2ThqNSABqYUQOCLlhyh/Upss+2riAanYdXOOGt1o0FYi05CTqfGjU?=
 =?us-ascii?Q?QiYkZX+8JCbjAEB0V57GM+cO7LK1aAzwzCoFQNHVDC9wqEm9YnP/kdPP0PSb?=
 =?us-ascii?Q?arTvauOm/2e9R1usVmrw+dmApHSMrPRJJ2wUpOWLVk5jnRlBwYvbOh5ZfJ9P?=
 =?us-ascii?Q?J6/vyYeOrJIWN8OiN08c88jGxh0h/8Japr0rjgguVrtIFvsHPHhkJ859XRX7?=
 =?us-ascii?Q?kOCjknOTvQubBam7YuUiL6cX4EhbbcP97kfYcqaM6PkJOZ61VeFNp8t0ds7I?=
 =?us-ascii?Q?IuCk2WcskrZ1xVpNf15MwbDyFHY+HFhzfFq6HWuwfmV+RvpvWbFWe0flyJ5r?=
 =?us-ascii?Q?8KM81zHKfh60VHGuCt2uBF7WUZv0+F9D1E4M0k4t/0JrQ4fq7vTvs/8ZZxCE?=
 =?us-ascii?Q?yS+MW3f+6GEZoTnukuWM/wesxiI6bHTvE8LutSrrps25Vqmd9yNllP4KYEpJ?=
 =?us-ascii?Q?R55JVuy85uwu0/h0jxc/3T9n66VIc9L7tZeTf/+wosZmd1e2ToR1u+SWp7Rd?=
 =?us-ascii?Q?0MbU8j3Sg4Ok/hb8cKdsCcP+xL9ggdkBFFK/bci9mlfDl0UUox2ZrMnpy5aH?=
 =?us-ascii?Q?aen1t+lrSNlLzFol1nKM04ERBpqQD2jAyded9jky8nYCGcKYMsDjYqUPskcR?=
 =?us-ascii?Q?Vi2/7L7QPR1m0ay2qfFbc5PtwXGEpDJhygYeopknOsCXMDImKYJGhqdNYoIF?=
 =?us-ascii?Q?Q8YgdnMxl0LV25J6CwirrQbLQdvTrU030Yvot8jzbmMCmi/UKPmfjA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xb8on10xvSu0HWak2HNCqT31D/zD6tjPO4jeqNKvn2yRcqpVeQJqBRm7fOEN?=
 =?us-ascii?Q?54YllXLCzmK0U+GKrKSyXNKijR4cy0gjbg8hnQeGu0H92nqHQxBA3Z/3wqx8?=
 =?us-ascii?Q?cbR1hepG6qC7B/1kUvvsqxfbSRkvqLvs2ZHSwWf80pZddVvEwcMvJBZBMF39?=
 =?us-ascii?Q?Og+DDl/ILnxCUMf03B6zY1U+3rWb2DhmtARc4buZXP/M4KgVxG+mPZ9PNks2?=
 =?us-ascii?Q?xRgyaBxzofzMMFl+qMY1Lm6Yq/lHEQ5rR96rgh4AJoI0slWp2kk+7RZVlvhI?=
 =?us-ascii?Q?rwK6zvB8UMCPAdBTCSWAf9iEt907+h+TdsBBrA2t/kFNI1oiri/ZK30IWHSY?=
 =?us-ascii?Q?oCQwslvK0VHuirT+3e0vDNBe1N65QvsH0ZoCnGURrfnRowYnBOFQBBSC1ez7?=
 =?us-ascii?Q?HhFfHSH1rKxQxhOHq1XP6l+sSxegiAckcoQjlQSw+1SVOBfFnVJhKZhLrz7M?=
 =?us-ascii?Q?ULtbM+pYJX1hHLBU4CaVXIz3XalLWWcW2431KG5EvijdeSzL5MHztbJW4kXF?=
 =?us-ascii?Q?2vjQ+TigrPiLrHx2vUNEftymd7VI3/1u7TzXnf7oRz2C+PI2yPdIXoMWkSrr?=
 =?us-ascii?Q?UDNZD+xwNktSwLjVWfdj6KKxdDsvGbiRKF2BtqdIdQVhBwDeFqEpLb2dq0NP?=
 =?us-ascii?Q?evk9xWf067Bu1eCcpv3HeEnye/iH68MlAaIrg8r6ETqtdK6UaHsR8w8JwjRY?=
 =?us-ascii?Q?HjremlzztjIHNQwTieTs/N7kZC+x4u/zW+1lQcCSmJkK1xfzAW2hFnFMnB/x?=
 =?us-ascii?Q?qLnAGdBvPfzgeXnTMsLqbzqWbry76k4h4Y/1x26WrXXOqqW8C5q1V44cCCMC?=
 =?us-ascii?Q?hNjiFhB3vsKcwHRiPPVpkJSGQnwpCjKnypuOF65iz4xHsCmfRwbH5ZrDRuXr?=
 =?us-ascii?Q?WHFtWhzXNinJu0j8cD5uZPZ5+3eD5d8TYVTHpkUG1svXo0QTDmrVTQWsZfwv?=
 =?us-ascii?Q?FnE4ZZ7I+0ypth2vY6JbyiNT2GYeoTmkspli5SBjfJKRPABpO+xcB2UDS7A9?=
 =?us-ascii?Q?qvHnr7l1YAGhApK9Tb5rghf4jxlmhzGrSGwqKIIpbX+68p3pXZg878B3xZTp?=
 =?us-ascii?Q?uj+saZ2xKTjDxHNnph1VJcyEK7nVSjLc5FHQHQufib+q+XoaT8x6w8yPisPc?=
 =?us-ascii?Q?cZHmiv2RmnfeW5OfzXsY0Q4FQBsSNuj/L4M80+3i3q0YNucUj7PCBMa1K4SI?=
 =?us-ascii?Q?97WmovZiYOBe4qltG52/FFWKIat/eAzElw62WkhIiuueTAo+slmx19mcu4xp?=
 =?us-ascii?Q?4cgqxIg8wvsKERo61DEKL0M2R0odbWLrm37Snf5b7HblW9+T6xDys5MP9dzG?=
 =?us-ascii?Q?t0ZppZCxJ8ptiduxLnt6mxRgzF/1XpBCsQY6xzWCWKoNmdiLdhj0kU4hx3aB?=
 =?us-ascii?Q?m8EQNxSg9HcdSGV/DqoQ2taIFisaVzCs1M6jB2yMyemoHNSbV8HQMKwuwqmL?=
 =?us-ascii?Q?VNy9pPG4fJid6xBuHx+u+w+xSzWGPp8y87PFlq0skziHKoglp1JZ2P82jbg6?=
 =?us-ascii?Q?2PYk9QlMlqgZ1bCWLYlbIeA1kH9Gkc7lp/y6K6kIoB6/tzMBjPurWd7dR2XS?=
 =?us-ascii?Q?5zpeivWNlCTtT2AQJqbus2dbmWpjZBBHqBQavb72?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de249b5-956f-4ca3-9ae1-08ddde0859ec
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 03:36:00.8060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ei5XO5hpIqZtCgTT+Yv615KsLgF47FvfaGDnXsG5O0xuagysXtjH0+xNQ0leNvrXBMUJP7yBX6/LQbqzRovEqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9808
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

On Wed, Aug 13, 2025 at 03:59:35PM +0530, Kamlesh Gurudasani wrote:
>When not using Common clock framework(CCF), calls to
>scmi_clk_set_parent returns -ENOTSUPP, which should not be the case.
>Fix that.
>
>Fixes: 15fdfef6642c ("clk: scmi: check the clock state/parent/rate
>control permissions)
>
>Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
>---
> drivers/clk/clk_scmi.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
>index 0c9a81cabcc..83ea7bb4286 100644
>--- a/drivers/clk/clk_scmi.c
>+++ b/drivers/clk/clk_scmi.c
>@@ -359,7 +359,7 @@ static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
> 	int ret;
> 
> 	if (!CONFIG_IS_ENABLED(CLK_CCF))
>-		return -ENOTSUPP;
>+		return __scmi_clk_set_parent(clk, parent);

The CCF check should be dropped per my understanding. The function should
work w/o CCF.

Regards,
Peng

> 
> 	ret = clk_get_by_id(clk->id, &c);
> 	if (ret)
>
>-- 
>2.34.1
>
