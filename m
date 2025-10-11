Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C06CCD184
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 18:08:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61AC583A2B;
	Sat, 11 Oct 2025 20:07:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="FPZ3Hze7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B420B83CF7; Sat, 11 Oct 2025 11:08:57 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE5AF83C2B
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 11:08:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X0pA63rnkAkEaGyjdP1SqDulGv5C/7WJqEtpraKrCPwV+bqc2Mve3nWCSM6cW2PIIdq+Avr/njUwoJZ+lmvqWG8QJNBynoF0sXf5e0q/yMpf7f6ac5CzPTs3fXByslhDE9VEvWcT00NAtiotSDM6gRcMusCohP/5BIG+2838+nj1bH9jTrx9gOevTQy9NYc1FGwVm2KL5OQWadifMI8wkUUuewJT2F00tE+WJlGxByI3yCr6KI2TDYxZBmFQr2sUxLHEgS5cMmhdYivl0J5Ad2MBlJHsv3BuGuEBTDlReVPdIAfUVsZxa3gk7WSROBXBV0xyHx/AbXsEmBFiwCXSSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMKnJnsjLg+W3u8Ehu/GOT+mqsuVM7iGL4GIK9Mf09k=;
 b=zTHWeq4KKqJKhzb8GvAnOJuEje2gcmFNieIbsRHvslKuj6wURQTCHTralIvk1shLL3FFPMTgsSgZ7v53kjq+MZD25h0tLLt1o5xCaS4wx+vLiu+4BKn7ZlsDR3/ivstLiFb4pYV6G+i++FMjGwduyRGUqpPHON5do0LXNdPoqwLHn7pfrp95D44gnnNByXsDCFsO62fgCsaGu2tvHfmPT/oYE8swif2y9dsrNmA3jk6M021fcXCRVk+QIj6DrEZwAy99ksa1zkwPpf8Bw5ErNlUSVSo4zHp5gsMlDmEdOgTUbUcPpZI86xUuskimP1wYpWYV4qiuVcX4KnEXSVoNMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMKnJnsjLg+W3u8Ehu/GOT+mqsuVM7iGL4GIK9Mf09k=;
 b=FPZ3Hze7ZURmfCJMe/5P86tlF0fPVTSzAaBlLetN6/OGgxu+HOONIiZsgY9XqVi41MB6NyJUoM+gEXsCXO7FTVQBqlsBY9M+6ZhSDJDJHOMzoEn5T+5nGaroF0ehF9lz2LzcQeWi4nVcbNaeRnNXKU43YhXv4G+FuOC9VJCT5LnO8IhK0Q80FPWjIr5L9mgZ25xiTdtU1WVGFtrghQBf0UV2ba0H6U1QX/Zaw3v0SBBO31gyLl6Ce+ANaRfIfT9dnTz36HJx6e4kb1iTPpCtE9UNqI90CeKcYBic6u2h5LBvVrPExgXxo2oG6QIroz8+DruzhSYRuplFYCVjo6yncg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU6PR04MB11160.eurprd04.prod.outlook.com (2603:10a6:10:5c3::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 09:08:54 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.007; Sat, 11 Oct 2025
 09:08:54 +0000
From: alice.guo@nxp.com
Date: Sat, 11 Oct 2025 17:07:51 +0800
Subject: [PATCH v2 04/10] Add serial# for SPL SDP download
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251011-imx943-v1-4-313444548ab3@oss.nxp.com>
References: <20251011-imx943-v1-0-313444548ab3@oss.nxp.com>
In-Reply-To: <20251011-imx943-v1-0-313444548ab3@oss.nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 marek.vasut@mailbox.org
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alice Guo <alice.guo@nxp.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Minkyu Kang <mk7.kang@samsung.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Roger Quadros <rogerq@kernel.org>, Tim Harvey <tharvey@gateworks.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Hanyuan Zhao <hanyuan-z@qq.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::8) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU6PR04MB11160:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ed66aca-2be7-471b-ce14-08de08a5cd40
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bk9ocnd2a0JlWjRjYnFOd1psalRKTWNtOXpLc0dyekVCTkJBMFFFb2YrT0F4?=
 =?utf-8?B?SEpiOFUxUDhoOUdrRWxIM0dCRDFtb0xxV3hzVVlKamJvWkJGWkd6ektBb2Y3?=
 =?utf-8?B?KzkramZ4aU14dDlvanB4cWI5TmxTWXpZajFRamRSZmlROWdWSTUxdUVpUEF4?=
 =?utf-8?B?d0hsc1lQU0xNMVRJRDJHQ1AwaW5DTzl6MG9kYXVCRWpLQklSYTZMY2hpdTFs?=
 =?utf-8?B?YkYrVGlTeVZuVDdZckhKMG8vSTZPQnhLekhhYWRWTlRFc05jSUJwSzh2enFX?=
 =?utf-8?B?a0FsTUxWbmF5eUNDRC9WYXAyTzhJVGl2dnRsMyt4YkJFbWxDbE0zbjhINGNu?=
 =?utf-8?B?Q3NPV0psN2UxcEwwOGEwcEY4K294UnBJUFRiekpXNlRvVGQrU2F6YjBsT21r?=
 =?utf-8?B?K04yVGt3d2pRWGxoRGNOa1JOR1VtMzgxYUYvSDhpbUdaLytOOERoSWR3ZDds?=
 =?utf-8?B?bHNNV0Rwa3djcHNkT1RrdW9yYlNydGk3Y0dhUFkvRS96cS8rYnBueHlrcG50?=
 =?utf-8?B?REdaMnBYNWI2QTZEVDFSR3pES21iQTRlRUsxbFdpd0pZWE9DdXA0K2VvN3pZ?=
 =?utf-8?B?azNSYWZxZ3M1MXdDZy9lNDZSaC83c3NYTUZpYkRMUDhqVW9TaXc3dGZDc2k3?=
 =?utf-8?B?eWtKSk1pTDM0VDdmM0ZaZ1pnU3lxd1RYcEJ2eWxpR2I0dE9ZS1k5U3NzbG5u?=
 =?utf-8?B?R01hOEFWUjVjZGJSY1VubzBhWkdMNWxTMy8wZmtNZldtend3YzJvb0h5dkhp?=
 =?utf-8?B?ZmN1V3JMU0h0TnVwR1FuelFLNVFXQkpOOHJveU5pWWRPRnUwVVNKWjZianBJ?=
 =?utf-8?B?MWNKRlgyUXNpV0FHNWlRWVo4cVN4RmxyU3FUMEhOMGhIVXNVV3pDaG5vWWk2?=
 =?utf-8?B?OWUvM3U2QmtTVldrazVLTS95VlhpcEx4WXBqNFNHb29Wa1R5YUFudWI5aGYy?=
 =?utf-8?B?bzRXYWtPYUg0c29UNTBOaWR6QXhwbHd5Z2R6T0xVTkVYajRUaHFkL1owN1Ux?=
 =?utf-8?B?Y1BTRlFNNmRnK2IzMHVCVlAvVjFRV3BxRVBmRVlPdGZnU08xM3RHOUpUVjlL?=
 =?utf-8?B?SFBRNlNwRVdjWUNMb1gweDhXWkVUdklWZUw1cis5blRCMzBpVEZ6K1Y5RmZ4?=
 =?utf-8?B?VHZweGxEQ0NCYlE5SmVYemx1WUhEakxScENPTytmdE1vaUFSMGhiQVorSGVy?=
 =?utf-8?B?c2FxQXFzWmdPNWNRVlYzNnlGY0JiQUt1ejc4UkFnSzVuYW9DY1dUS3BvMFpj?=
 =?utf-8?B?RGhFVkdFR1ROWWIrN0ZKWVIzenlnQkVOUmxlc2RmVlBmM1pLUDViZExHNUMy?=
 =?utf-8?B?RDVjdlBIeGZzcXZxeStLYnErcWY5bTF1SWs3eVhtMWJxRGNrc3ZlbTFRSTBJ?=
 =?utf-8?B?ajFpMHhkN3h3RGR0bXJVdE1VNlkzdG1CNFY3WnJJTGppKzNZTEZvQitVZmRE?=
 =?utf-8?B?WHZURCtQVTlqc1BkMjNlQzI3bWNuU05PZjBMM21MaHJPZG5xTk95QVkzZjB2?=
 =?utf-8?B?Ynd0QVRGR0pvNkU1SVUxT3p6UG1iVU1vVXFlcVpYSHQ1TzdnbnhiY3A2NnR0?=
 =?utf-8?B?cHZDYlc2Nmp1cW9BMWp5NDVVU0lyb3dEQ25GZ0xqOHFWK1Z4eFBHa09rOEhZ?=
 =?utf-8?B?WENKamFVOWVLaU1ieXJFRExqaElYakdrclFwOEk5ZFc4SGIwZlp6c0JWbElk?=
 =?utf-8?B?VG9VUUl0ZnRod1U4ZDI1N0tEYXhmcVlRbFVvWFBkZ2xUeHE2eVMvZ0ZGTjRU?=
 =?utf-8?B?LzM0SGwyU3ROenJzMmVFR2VzcDd3M0UyUEg5U3hYbGYxS1FxRXJLYzd0Z05I?=
 =?utf-8?B?ZUI1QWR3WGMrcXoyY2xDYXFSZ0U2Y0hYQThYNkprdDZoaEdobTBuSEpDWkZt?=
 =?utf-8?B?cWZFTGR2elhySTJFcjFhc3dSR3dQUlY5dnp5aGtGc0xpTnhDN0xhSHExVVNl?=
 =?utf-8?B?RFpVYnV6NHJEa3A1UWl2VUt0aHFEQy9qVURmS3NFUExaeTViWWxzdFlkVStT?=
 =?utf-8?B?Q0FtNkN0M0Z4RzNNa29XL0FWQTBDZ1pxajdxNGQ0ZE1lM3FPc3dLc3g4bmVT?=
 =?utf-8?Q?7eLNr6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(52116014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkxkYjFiTkFYMERQQmtkay85NEovU3R0Um9EMkZKQ0NJc0JkNHpVVEx6WDJS?=
 =?utf-8?B?Myszc1g3Z2ZXWUpQaG1KWEZKUjd6LzNwMU5Gdlp4YSt1eXVyNzBBMGhZRHJE?=
 =?utf-8?B?bS9aUlF0WWowb0ZyRlJnNHRFdGU0bERTNzhCa0NGenowTXdFTWdZWnpVOUZ6?=
 =?utf-8?B?bFFSSEhHZ1dGQzFRSFdTRmlYaWtoTzNEdWFIYm43d2huRmZNN3R5UjVtMmVP?=
 =?utf-8?B?ZGlXMHZYQmJYVEdQZENieWkvM0VxSzNxSGhTd1ZpNjd2aGFXNjdLOWFWZmNQ?=
 =?utf-8?B?T1lYSWpyd3FJSEhuNGVFdHdwYzVJZUlPTnJoNXJEdzgxcTdDVU1GVVpiTkc0?=
 =?utf-8?B?Ymh0Z1pFdVVlNXlPWXFHL1pFUzQ4UW1DNytIeE9vM051YlFyUlN0b1dIcDNV?=
 =?utf-8?B?VW9sdktUQVN3Z0U5djAzRGlvMFd4Q2RJaUYzdW1GZnJnZW8ycHZVL0xJL0E1?=
 =?utf-8?B?TTNTdk03WHRLODJiQmNZUkhUaFJBZXlmNXdZUGhCZVhybTlremJFTnAvS1Vv?=
 =?utf-8?B?NTlDTDFDOGJlTlF6d3dOR0I2RzROdldIbjdTTmdWU0tIaHVqQjlqOVdJOVBP?=
 =?utf-8?B?cG1qYUJndU9MOGdPbUlaUVFsWFljWWVsTW0rQkgvc0tQUVlZODM2emRWRVpS?=
 =?utf-8?B?UDY5UHR6UkN5azlvd2pldFdzdm9zV0kxUDhPTXByVmxWWHJzS3J0VnJ5aGk1?=
 =?utf-8?B?dS9IcWxaZlVqLzhzMkw1OEttQXdxdmdKTXQ4LzNHWmRqb1pBUWJERkpWc2th?=
 =?utf-8?B?dDRJQlNwdUc0d3FWaVdVLzNPZkVsdmlIMDJMQWJ3a3k0bTVGUDFCYjdWVTVo?=
 =?utf-8?B?V2Y4cnJGMlQ5QVRDeVZJY3N5SXg2RUdweHk5MjlSM2sxb1lPZFNlUlRVNmh1?=
 =?utf-8?B?QlgwMkdOY1QzbjhtZWZFUW1xRHBoWGN2TGRDVGJKREhQeXFWNVk0NUQyUmI1?=
 =?utf-8?B?WG5lVzFJdTJiMHAvenZCYkpJaGxDR3VobDB1YkVGNWE1d21kTmFCYVRMb0NS?=
 =?utf-8?B?Q0J4OC9CbDBlVE0rcmVtb3piYTlTY2JwQ2lnV3NIK1p6MDRFWUdLc043SGhJ?=
 =?utf-8?B?OWttaElBcnloWFBMek9KUHNlL1hDR3pQNmFhRzFDVmlBWHlROUVuS3h0eHhY?=
 =?utf-8?B?azVFT3FBRExIa01MRmhEelBDUlprTklNWHVCWUViUy9MNmtYS1lRekp5SHRr?=
 =?utf-8?B?b0w0Y2pnZENZWGQ2WkNSTVN4WlRsQ1NSOEJ5cEpsNmtib1dITm9tWmNteUxx?=
 =?utf-8?B?WFRzczlUbSsvVnp5OERGUmNvVGFjWG5wZ0pzb25uNitKeEh5ZWQxSW5BbkpC?=
 =?utf-8?B?Syt2bnhNcjZTVTRBVW9kUEpISFRFUVVzSG4vRGhBMVJXS1FWM3pUSFV4b3pj?=
 =?utf-8?B?dWQ5WGp0NFI5dlMrUThMN3JESmEzN2NscDE4a2tPUWNqckRPdTBzSVkzaVBS?=
 =?utf-8?B?UVEwV1JDTVBLMUFJMEtUQzE0L2xaQi9TYk9nT3BTSjBjY0pEbHN4M0RpZm5D?=
 =?utf-8?B?MUdyRWxYMFhLK0dwTlhXV0p6VUtCWEJWSnBsUHJGbUNzNVlQQnhRNC9uNGZS?=
 =?utf-8?B?T2U5WnpoaFREZEIrejJzZVlrakwzR2FpZHhaTFJKR29MUUFGcm9zcGl4RGxU?=
 =?utf-8?B?UmsrTy92dkxNaGI1NlE2QllGY1pCQ0hEVUtwN0VUUHJ3VkpvMFp5MmdwVDk5?=
 =?utf-8?B?VXkySUZ0T244cnlJbVB4RUlhdlhTYWRuVmxpenhqVmZuakpseVIyMzY0Y2Ev?=
 =?utf-8?B?V1pVNzBlZkFOanNkTm5Sbk4veWF5Wjl1WUs3TEJ6NVlGMUhhTStKMU1QWVZs?=
 =?utf-8?B?elBtdzlZMjB0ZnZQV1IyTGNwVlpMWWVHTmJVRHFNUGpRYlFRM3NBV2VlRGVL?=
 =?utf-8?B?UmVPTy9HemZsUkNPckR0RFFvWkpKanU3VmFLd09jMDlwMXloZ1RIZXE2V3FI?=
 =?utf-8?B?cEJKV2E5bjJFTmxTSDc2Wk9hWTJLMHByWXRDNU1GbzZOOVplUHpsUVk0bFRE?=
 =?utf-8?B?YlBUKzJYZmwvVitmYU1Wdml3a3dYVm1MOE9rNTIwMTdtdG52dmhQL3pZdmNl?=
 =?utf-8?B?Wit3L1crcndwZ0lzQmhKSGtFV3hkV1Y4cmJKNm9XNlczQkRuK1M4MlhXKzJx?=
 =?utf-8?Q?RQg0nlavSINtzSJtY+tT81jCu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed66aca-2be7-471b-ce14-08de08a5cd40
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 09:08:54.1016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+rCF8a08zCK+jaTs/y8Db8Gonc6RFj154RPavcu8YHj8N3hKVS8ggeMLwDuKIDSpW2uEaXXv554fkYgGKR/iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11160
X-Mailman-Approved-At: Sat, 11 Oct 2025 20:06:59 +0200
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

From: Frank Li <Frank.Li@nxp.com>

After update this, uuu(>1.6) can use below command to filter out devices
when multi boards connected.

uuu -ms <serial#> ...
[sudo] uuu -lsusb can list known devices with serial# informaiton.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/mach-imx/spl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-imx/spl.c b/arch/arm/mach-imx/spl.c
index 518d9cb1262..d4ede46b751 100644
--- a/arch/arm/mach-imx/spl.c
+++ b/arch/arm/mach-imx/spl.c
@@ -21,6 +21,8 @@
 #include <g_dnl.h>
 #include <linux/libfdt.h>
 #include <memalign.h>
+#include <asm/setup.h>
+#include <asm/bootm.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -184,6 +186,14 @@ u32 spl_boot_device(void)
 #ifdef CONFIG_SPL_USB_GADGET
 int g_dnl_bind_fixup(struct usb_device_descriptor *dev, const char *name)
 {
+#ifdef CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG
+	struct tag_serialnr serialnr;
+	char serial_string[0x21] = {0};
+
+	get_board_serial(&serialnr);
+	snprintf(serial_string, sizeof(serial_string), "%08x%08x", serialnr.high, serialnr.low);
+	g_dnl_set_serialnumber(serial_string);
+#endif
 	put_unaligned(CONFIG_USB_GADGET_PRODUCT_NUM + 0xfff, &dev->idProduct);
 
 	return 0;

-- 
2.43.0

