Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C836DC87FCA
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 06:54:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 087308318E;
	Thu, 31 Jul 2025 08:54:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="REFyYXLY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A9528319A; Thu, 31 Jul 2025 08:54:02 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1C138313B
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 08:53:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/Ne/rgjryir7/hhq2IISVLMXRXuad9cNCTtaciRm/WX7hbLlWTDR73+LAX15UWFPyat8RD0wjJlSdVJlOgYa8CYMSnqgv2epjnwpDSDwA2qAIa+YYWsgD1/JtnjFwqcuvEfgAjA//Thc/PA497mPsC4DUE7SJZ3DdQ9UcXVQy4ikE4eFhZ9BrK0dxjy9mx7ZQD2g87fPdzKJuZ0bfEdAIR33wK1wteXs8ObWPqW5A8cYFPUG8PW3OfPDwZGLr+FInUkT6zbi72ImdOm67sHwob604dq2zSKmUqromtTq113xbvBF8isrhNVHgcvWKXlVc1o0oEnBo7JvPWk/3UOnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNS04W0U9JyYLZkRwwmj3oIDxBgYzwRRfH7GDzUz3Ak=;
 b=UJ4AY8PHYkuY6cqQBAL/4IAXFerRiCcpzp2BrQ/wLc9ttshhu2SABUReHrq4PftAaD1WmicQhf3qLFos8RLcbrbV7Xsts9Xg+SA8Hu0+JEHDwYeQuSRfGjzpmKNXfAG1T1y2iT2gNdIzajl7IwVcr0IkupoYjP4HsCLsZyX1mGCFlfCnTRf98QCqjEaZuPtkbtjsSjNxDLyc4RPs2YXrblst1wT0deHIwgWhXc2e+5NDixROpNNzhMSZnJvSAWuGxD2F+HZM9GKEzQJVZVMo7CtgA6QXvB+fCA26ROKiJaB6Lfonyx8AaTIHdXAeBMdeO03wPjtPpfdQAtHSzfk/Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNS04W0U9JyYLZkRwwmj3oIDxBgYzwRRfH7GDzUz3Ak=;
 b=REFyYXLYGXJhxVZJnnhD9LXpksIAXg2fisq7Jpk2kt0iSEuWZONDNyHyFJa/cxrD+Z8qkJvuhxET09y71ODdNDpWj5jN7GUqayzVvii9XNsvPWNDxqX1lQSAWVBmvfw+eOpHcgqLMgyF9wDDp0RjXotqOJplcFhD6lGjUPzAG/Q9LZYQpmoLeRlfiwcHSjxbxToCwbeL+gh1a/r2tpGQQ+XRlaM46MSJsygG2BASgb6KIktw+bKrNd+Q19uCuE+SP83k9KI9nCNpRl5yWUkxTRK2qKJrTbNV/kzbJMbRTNXQ+x28/rIoHsOEo6ufQ1xLE7l5S1hY6FFMRW6w+C5deg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8801.eurprd04.prod.outlook.com (2603:10a6:20b:42c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Thu, 31 Jul
 2025 06:53:57 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8989.013; Thu, 31 Jul 2025
 06:53:57 +0000
Date: Thu, 31 Jul 2025 16:04:35 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] mmc: iproc_sdhci: Cannot test unsigned variable for
 negative
Message-ID: <20250731080435.GA329@nxa18884-linux.ap.freescale.net>
References: <20250730-iproc_sdhci-v1-1-310015b22944@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730-iproc_sdhci-v1-1-310015b22944@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8801:EE_
X-MS-Office365-Filtering-Correlation-Id: 731dd691-e1f6-4d3e-9f35-08ddcfff0572
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|19092799006|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+Bn1IvCtQz3YdBeestu/31tx9qujZ2rHygWTeXaST+dGgSc53zsdvBdfSyi0?=
 =?us-ascii?Q?o1mJl1gb2JjfZx1C7nTwI8cPitM1AX6/70I10acM4ZhWGk0zE4TCNKnc3MBE?=
 =?us-ascii?Q?QEQ18lqcnm+EeiR3pWkYH65VeKg/0P3H/Oocvz0J4tMzbdyEMJAAxhJfKKmy?=
 =?us-ascii?Q?XF28SZlLA2fReGbFCYfbgYKu0brJkBSWo3YNh2pB+GQB44W6hkRawUJn68/t?=
 =?us-ascii?Q?TerfwORIEbJkv9nyDBH71LUJ2rW3iF6qxqqWMjAUYtj/IlmMOpe004UliRd6?=
 =?us-ascii?Q?e8e+FYkUB+YH+tsDRo0CEDBtEKVZYx3Djk397NeewVFNZYamDJSDTYPbeDD9?=
 =?us-ascii?Q?dgtwyvKcRM/0qVBkMpSh5MDOlDPMC/YUoXkpBQSp2hRaxPZbEJsIDsatgO9l?=
 =?us-ascii?Q?/iB+KyDJ1+z2zA/wBirjYx2dpi/4jKnWeUr0NX6jrbZkLyJf3T0THdlclGMR?=
 =?us-ascii?Q?UFRFMpSXX/54wXVVb6zZfDzbwy9QFyBzjRgRzXU8263sqsS26pjSBkc0w+LO?=
 =?us-ascii?Q?7/4qNefRCy0rT8XgnvS4SgN77AaWnCPyi+YGSU0YExtwVUSjd08vBa4bnCz1?=
 =?us-ascii?Q?Bwpa2upO+YtV30GWiJv1EEIeivbcgPhLQMv5wwjOVLTnXvAtoQXAVDTKfWMM?=
 =?us-ascii?Q?LR/A8jNh/eQAhBI2n+UeBHrlWgA31IbirBmz5A28fPX3DAV4+90EpdrZsz1H?=
 =?us-ascii?Q?KRybJbFSBDyvTydFsvAD4w/HfL/K4CNlgP23dZjjwEVBAgVwNrINum8NkuO+?=
 =?us-ascii?Q?xyaXLErYiedCRblQr2Nm2bTOQbFqaCHxxb9eGQlRJHvT7WF2z1OYDsPEOQCC?=
 =?us-ascii?Q?CFrhGlwKjma/+/tcUBUduww/rTkh8MBGPqHVdh6Wj37ZGLA1IuOR8GgiA9RE?=
 =?us-ascii?Q?IFhwRDrlXaC0PxqFchqOEYjdVRS71ffTSw8LgrtmygmB5O+gO2IRIoX7nC9Q?=
 =?us-ascii?Q?SbfIdfMvxKVF74Jno3olhmAxLO1C5hN6C3dxtgY6OSXciGOuXYFuegUu9whD?=
 =?us-ascii?Q?e5jYZHEC6l+aD4lnyQIAlDpz3TAo+TuLDyGOoGI/nq5tGog5wZUCPvaf/Rue?=
 =?us-ascii?Q?ua5D6cA4v3jdAxu0B+LYpS2tNOymKcN/jmSx52ONpECcTLzPQQq4qWAQq6K7?=
 =?us-ascii?Q?N4xBAZ1BuhK4/72hGRH0mr9ktkMWQzIDnqH3FAilHflRrpx21vnwZi3Xv81X?=
 =?us-ascii?Q?e0Wspv9AvRpqcKlO3yMnTgZvVsy8atPFYlTYVuFByA6JSHSaT3OCsrKueuZ9?=
 =?us-ascii?Q?W/24vhSH1U/uBQup0Sfpc3DqzYbRGBGrhGsxbD0IO/EmhgNw/KczZN1kfP+s?=
 =?us-ascii?Q?yg/FqSSYyIXxUz5H63uS+vd2IPaZXKG6fNlJnzArrhxtvlyZICIRUtAhF5j5?=
 =?us-ascii?Q?NJR3UbuWUWSCFs2UKNyTk1yBpjzjfALpa9w3FnnpN7nO4jt034fUq2tZqfcC?=
 =?us-ascii?Q?sh83GhS+h/Psho3TKSrlfeDgP+GLFekAREDZ7Wu7DOq8ad+itzCoqA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QmCu+I+EWZC6ZADNiVtlJPklciuxVVHaeN5D7KJWVAJQHaPlQiUyCfZXdHep?=
 =?us-ascii?Q?0OqPxSfd7TIObjliaJixCoILzMNO2DteacsLNMK1BAq3/YriYscssk1BAgFE?=
 =?us-ascii?Q?dcGbtgYi2kLA3yblWLfnrYfgXocOY1xKWfdNvU8qXhwMG+ajkQ0OVALQM1bk?=
 =?us-ascii?Q?/gyOBQNFJkDNJ/dA6Ce1aKVoUXku0FqxEihCoyrVuCnyBhznvK7uPv9xtYzH?=
 =?us-ascii?Q?VQQXquSQlB4icnL2iKkeH6jJGurwHVN+XgU0oAoimUxwKkq/ObDFARpZimRs?=
 =?us-ascii?Q?CLH5bbCXQVoeuOhF6wqoWZiciwf1KiovU+25gFpLkXOIDjuwuESh11F18R3A?=
 =?us-ascii?Q?gihkbheCQErPSy4b05zd6z3hYBcqDMQN+DhmtyntBo90ab+4MHG+jWXl9DQb?=
 =?us-ascii?Q?HsyZSYsPeSs5jvBrlz412yURRXmNqVhIAkCkRELVhFCc+9GOwUr2ksFGtefa?=
 =?us-ascii?Q?Ac2Q/D4jdqdM4ev4PpCi3PDnkOaXEkJPHA6JQCF2VkcizZk2lZOeQkzQm/C2?=
 =?us-ascii?Q?LEcr9w/lybq2vBsCSY2ry60YXt0RSi0jubHfOsHSzyACvF23NKYP4wcwDEjL?=
 =?us-ascii?Q?Nnv/IslXiSuxTEQs/V4zsydhDTcegpxi/Yyl+/05XvNLdyii5fx90ytdeFkJ?=
 =?us-ascii?Q?iHheCMwmhUdysc5Kd1uMOdEv7aAF2zakQ6pCyKR0shCNo/m0Ex0zIOKxbG4s?=
 =?us-ascii?Q?j+Oz9SW+BvwD9pv+CqBlQd7EGTf5O6YVqkZ8X9YCfTeTD74VezmS/FziMqdG?=
 =?us-ascii?Q?tqtsjx2Pr+upgjjaMrfH2jPgqd1RaGcE1sgJWsY7xI7QO7XAjLDB9buAGu9/?=
 =?us-ascii?Q?u/OHFpj5Xp+434LTDq0rZbaJK/OAWMr4S48DgVJ8RuiKMC1FM82mOEVGcf+S?=
 =?us-ascii?Q?7vhm6Q35lb0JzDDv1SCVBSVPsBf98anGF9m1ho794cVqOzAXTBcOOC+rfkbn?=
 =?us-ascii?Q?JB1kFfbKZI2qWriqLZ+u97qFB/v/EjOLJzCd6mo1y0MFjN4RDmatoblUmTN7?=
 =?us-ascii?Q?lCoq6cvPi3uAQDviBKOQ0wZTDC5ZCHcvRAplYgqPFVFpAhu9m6U92C6h6xWS?=
 =?us-ascii?Q?bD/G7ktEMlBuJs7ag4394q/wz2oWNZWMNZtoLe+jg0azj8vk1x3Zsuce5p2F?=
 =?us-ascii?Q?HmP+Jnr/8Qpi3Ez3PdiYKAW+Nqsk/baup4jVO0SsyRHH3jv2D06SZzgBzACk?=
 =?us-ascii?Q?aGhV5+bKt0OOje/aaFXyLCN+CJWSxxiY1mB2PVWw3YdmjEkpxa1DqFw28Q5O?=
 =?us-ascii?Q?F645SwqKI4VckFKWe2l6GVCphNqvL99JtmKOGb5HVtT0rLDj8nZF8dEnqAV7?=
 =?us-ascii?Q?qP9KrAz94IK9gC/u9CgIHMIuwFf7bCk3DzudjUVNFNE5HDn9/rGsFNhq569h?=
 =?us-ascii?Q?tW/8WxxG2+nLqJq9Rvrb5DFSujg2uyPuLT5kRSRz8dhyiuyjerGn+ZDhvUTW?=
 =?us-ascii?Q?3cY+tOXeAUlNFSc9Gon28PlEca5jNpjRsu6wq8lpFIygarFJH9g7zORkWfH1?=
 =?us-ascii?Q?o3sBIg4EoPxEWjh0cHXFhuXtZSBswZBgYUkX1UltSPaDSymuDmxXg2wTHzYk?=
 =?us-ascii?Q?h6Z7feTYAN6U+nLX0bt5C+Qwz9znvPmqwGMq7YbO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 731dd691-e1f6-4d3e-9f35-08ddcfff0572
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 06:53:57.4449 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bt/I45NW1KQDb6HudKsy2R2whUZprCg7v0D0RTfgOwdizzO97C03hqu58UNhKj6myMTs+XaQzRP6f0EfRKX7fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8801
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

On Wed, Jul 30, 2025 at 05:52:56PM +0100, Andrew Goodbody wrote:
>In sdhci_iproc_execute_tuning the variable tuning_loop_counter is
>unsigned and therefore will always fail the test for it being less than
>0. Fix this by changing the variable type to be s8.
>
>This issue was found by Smatch.
>

Per my understanding GCC default takes char as signed. But after
doing some study, char could be signed or unsigned. So it
make sense to use s8 to avoid potential issue.

Reviewed-by: Peng Fan <peng.fan@nxp.com>

Thanks,
Peng
