Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E53ECD9B7
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 00:40:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AE57831AC;
	Fri,  6 Feb 2026 01:40:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Uc+QAMj2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E0128341A; Fri,  6 Feb 2026 01:40:09 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7F8383015
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 01:40:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=py5s0hssNgZwutK6ZjGBlrL1lxcMxMIHBOk+A1JnadZGXgZRM2ly+6vOSehZZXwaV1mp9xRQeS4nxfEnkF9ZBOPROhYxkcfHf6x62RtAY6h3FVLKjhRFNaO0FH7LNXVp1339yjbBOjh7S+iEwnOcuXSJltqKwZB1qpMAq73oJTBozeD0ghsZpgEWsNWJ3o4j/6stR9ZXzvc6FEkHb2a+6ll9r19B0gRRcZ58UfwlLwTZL4md+5ffbu52ck5L33uYk6KiLbivvYvwJZEGXNy5vX8/cjm9UA7jbLb4vWLDotTXQZiAg4+Ej/oQaQAGWpfr9IZwLvPdbgbCwGXvxtqFTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/G7ZFrzZGnIub/DqDxYL/P4njwwUMGF8/n3WoTooWic=;
 b=GqPbvRrwj+Sm30lGkwMDIhZ97j6MaH+rq0/DUs3PCg08yA0pwBJykGN7a0EfZPwy+bidyCu0CpP02DQ70v0U7JokyojsYPD2TO0nTlySfX9rOmpfTPApHByi2eEdNgvGlqrIQCs1FVp1dUATOCladzO1knEArOwp5xEkVdfOiDN/Zbzp6twooxDqrzglSNMlszdPtmjK1/JwKySz/TQ62uAzHhUWo5nT5B/u+ou/7bjBUOQz5jEIziWBsY+wSI2xe8YA/wxqDdy1trhSpkmJb3PzWbqVXOJQG9zN7AdBC+iDugvq9dwMkZd/dz4OerMcqZ9lKSM+uQPA2zZT7R40Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/G7ZFrzZGnIub/DqDxYL/P4njwwUMGF8/n3WoTooWic=;
 b=Uc+QAMj2L4h0If9YpzqxtZQcI+9EI8xQI2W0IryScBgTU+lrxnwIMV/oR6gPWVja5cB4WnvoOtfi7iEJAIxPLB63k4SbHYjGV53LvoKrPVlCpSj7jPBGs17m42arnGnNQ8FFmsB2oktAXQlpBX/dybC5PkvOJ7a7J24J7cNCwdgcipAJ2bG8wjhQ1lUwZlLs+53Hu9anIxVQOiPO9biYPTb62ZSv6BsSInQJBxJwZscGynHbp/bElkyArTffDium1JK610X/ogtHkYu/P/hrMNpwslfWSUp+40q3DCnfPMNlG+qfogZ1f/RD97MVAak3fNYP66ZkN/b/KHO6SrfwPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB11598.eurprd04.prod.outlook.com (2603:10a6:10:60f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 00:40:04 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 00:40:04 +0000
Date: Fri, 6 Feb 2026 08:41:40 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: alice.guo@oss.nxp.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Jindong Yue <jindong.yue@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Fedor Ross <fedor.ross@ifm.com>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>,
 Ji Luo <ji.luo@nxp.com>, Frank Li <Frank.Li@nxp.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Adam Ford <aford173@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 David Zang <davidzangcs@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marex@nabladev.com>, Joseph Guo <qijian.guo@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v1 07/12] arm: imx952: Add watchdog base address
 definitions
Message-ID: <aYU4xB9mac71N21Q@shlinux89>
References: <20260205-imx952-v1-0-2103d0222a0b@nxp.com>
 <20260205-imx952-v1-7-2103d0222a0b@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205-imx952-v1-7-2103d0222a0b@nxp.com>
X-ClientProxiedBy: SG2PR02CA0078.apcprd02.prod.outlook.com
 (2603:1096:4:90::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB11598:EE_
X-MS-Office365-Filtering-Correlation-Id: dd7388f7-c779-431d-60fa-08de651844e1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NfdlOB8OSQ/XFLaS/iXo21ZJ03OXwJuceD3mS0KVusWvn5kRbYVIeb9ujf46?=
 =?us-ascii?Q?Hr9T9sUeUdrCPS/aTib7LlFjvp9bhtFRyOqEVMeOvwj5IXkJKApq4itL8Vyj?=
 =?us-ascii?Q?Pw6miz3Ra0C43K4ZW+Q0X4otztghRJokCkaY6VT4D5MYy93R7ixDJZfMsTmA?=
 =?us-ascii?Q?EBDsEnxXc2Wm7SbT5RaBKe2BrJeVwMQojyYSyjhDrFLtktnhJB+1t1IUae70?=
 =?us-ascii?Q?rO021Tr3izWAAohDFhgHdeNrgFf6BthwjFmp4GG+ViwOckXcLuMVhRhPy732?=
 =?us-ascii?Q?4McX40m1ohfuZ3rx74GR7qq81M90r/E3p0YZjRE6+mvL/K7BEFGRfAPaOs+o?=
 =?us-ascii?Q?EaJjIXVqrUvUZcLueaPtaUUFxnDIFQsuxmUuqpWx9ntY4nZd60Iy16pMPrQS?=
 =?us-ascii?Q?PwZ8LdaHByYlZIogXUf/lLRnMgRs16z4yO2xffqFMtXknhOcTy0UCekuN3Ze?=
 =?us-ascii?Q?OHR3UCuBO7ZTy2FvC1XRlqebS60g50QkpYhs3Ysa6EbM2/DnLon8DUf0+xsg?=
 =?us-ascii?Q?MnVAQLJLJQIn9kkk12P34+wbGyEBna4Ogsv+btFXMUwlHNb2uQiwLf+MBKZH?=
 =?us-ascii?Q?po/bcTHjZ5I+FZ9kAZoX55ak4tzr2qpcbvXVuvZZtGb+UnO/EIsE+4qTnNgt?=
 =?us-ascii?Q?LdjumCrGsfzMVvTBCRAngKS/rCoVAYu5Qm403CWUGoVWhg91ZxLC5SCB9m2e?=
 =?us-ascii?Q?UArURN5xtD7BEJvfM2eRsNjSb+P6UNPXGee+08SPQeJPfY+pyl+yhgyXLfC5?=
 =?us-ascii?Q?5Na2Z5JXKawHO56oZpx+4+XoAiRWouXbL7p9A1mtMjYn5rJmNgUMINt9FprM?=
 =?us-ascii?Q?A2OkS7cOMyzsK0mVDEHJ99+wsj+iwLf0bjIkbwQIEc6Y0rEQIj9v9yP0wAry?=
 =?us-ascii?Q?7QkV9TwcBpN0S6k79OTRz7NJqlLbOlX3Y1ND38V1y+3r4B5SveIB/V3REc5v?=
 =?us-ascii?Q?2mvjqvvQBWJ0A8OjyYygdBAa2a6rEoLV+LfA8N1tOSTaKsFVMD8M0zAb5BJ+?=
 =?us-ascii?Q?x/DpKTzcKUlaH8usDpe9MgGD4OGMah7jof4mPXLynKozPSvqox8qBz6Uj0DY?=
 =?us-ascii?Q?lyAGxo+CIiymhQH8Y5AsQDpSFzRLudM9Q5LxECBkyxt3mxYO91o549Gamzsg?=
 =?us-ascii?Q?F+nh3bwNa48I+q8omHfDsjyrAM/jPKSTKb3w0/8zUY4NTDjz+uDu+XJdQuFj?=
 =?us-ascii?Q?nnStIMiNYXaGWPI25k1/Uvf8qdSUi76XK2c2xQ0APnKMN76eX95GjCnvnoiG?=
 =?us-ascii?Q?NtqKtO+oS1TnwWSxeJ7QGGu0SjKlftZCzNfwof0Q4fk+k+pB7y/qCFiEHOPS?=
 =?us-ascii?Q?WddK0Bn2DUhPE8i/HHdIx37MDHzbhikQ/5WcDiV2X3t71Y9WQWF8qrEmdZKm?=
 =?us-ascii?Q?rQHaFCGSBcN1Zm080lvH5zqjboQKUZ58O/H5/NJ2ICfWlupvagghcCEKddRf?=
 =?us-ascii?Q?7kzXjNZYEXanOZsyzhO02yJGVd4P7ysZz4eJn5hEmL+uav6oVWTjVvDa0ZLL?=
 =?us-ascii?Q?UsQICo2ZAsIQo/wKhftcWnNs/RWm0JyzNuCyBXhSyALGbofSQyUM0OAWx8sb?=
 =?us-ascii?Q?73qS4rHbiSsyNGQvcM8i7rupWfMbGP/TNMh7NlutszImBTsi0mPs/MnnQkgp?=
 =?us-ascii?Q?zR7tjPRgIVX8nUAgDSUQl2k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/UDg3NCxzi34pcfQhTdf/m6DNEocoFFOFfv4z+VCbRI2HJTBFjjlYoRQthRT?=
 =?us-ascii?Q?YXSZ95wJU7Uw+WJhTXZIBpYG8z+jxqZC/Tg3uu72XF8bcgQ/ol8QGxxagLNE?=
 =?us-ascii?Q?FJTwYXr0AqFCsi+jyL58lKKFRoxY7vLMY+JNypLmpaGAegaLal3sKprswLCk?=
 =?us-ascii?Q?2C2b8DROOwRcWHTKiSO/8nl2DQvhk6s5doZH4/0fe2X9YpbhVzrbazucV5pL?=
 =?us-ascii?Q?3MrDzNHO42mYFh00K86x8Ef495/Hgp4BYEDrej6GvunwmMv0Uy+stSdymqfK?=
 =?us-ascii?Q?NmGYXe+GqSxO4dsOSL4Ysd591eD2q1LxaCDb5HvM02JCc3CmbQfxCVM9Yyrh?=
 =?us-ascii?Q?5mW15YUhIp+TODL8nDbf2kWyeGxCnRoCkMw+v0uGXrXyzx7Llb2HtYMTrkVJ?=
 =?us-ascii?Q?w+0Y4QrSGERcxpsA/6r5CbT5Pv0tjDYsfp0bZJUJFshiaepcAowJ03Yh558C?=
 =?us-ascii?Q?wXV0dbdrHDIL1ZOufo7RQV/hoh0sC5vqpY0RG6Ulgid9M4GWmgEVlx8xoDZO?=
 =?us-ascii?Q?OyVxDMiiJ9tdSNB6IDHA70ZRTknu0iDrJZHyIDOg/omP7fGUPKwU4QWh5An3?=
 =?us-ascii?Q?fVrD6h0l679OpxqDH1kPpqtWuSK6x9jqnrv32bEZYSMZXnedmB86YImBBU5h?=
 =?us-ascii?Q?A4xxBoxAB3AidqxsX29/ew9StV2DSu855qQmRMnFHZfsLf41ryWRH+w2fDLt?=
 =?us-ascii?Q?tYxYgj+6MpMRQ1xWmb7SK8OhRXaH5PD7a2awJeh9FHPOd4qYDD+7H5RzCGZ+?=
 =?us-ascii?Q?LezQ68gpEUfCjRoZbej4Ok2wfYOoRLuXAG8JsSLYg4iZREyc5Oq6fDkBx0RZ?=
 =?us-ascii?Q?Fv3eY+ZMNZSVk8Yzc1qSuIbF4OSLTCT3SdK/WaQdiTtq2kxOBG/vse3x/Qrp?=
 =?us-ascii?Q?Xy76e9CwL+sp4laZcOF9Emy1ZQQ9EtebWF+11xyYWRweMHJ8HP8YmCThYnZI?=
 =?us-ascii?Q?cAwlRPxECnWr5wB1cVFDnVRla6hCuaKycfx5TKXuVQOtpltzi98nUI4JjwU8?=
 =?us-ascii?Q?bqOz9EeixoeKSP8UQQJgC6bjo1yt3hvdDOwc12pAtDi90P96aqLkuM7vbqTV?=
 =?us-ascii?Q?ybuPw18F4DxwY6TUK7ZtGQ1B5Mb1ypLF1Qm1rnsi0NdS7+bQH43/IKV+IDGd?=
 =?us-ascii?Q?q6kTxQNG8nKbbX2taY7nJhscfdUGpGILYe3jFL9lbGzlGpRe+V0e88iOUmkz?=
 =?us-ascii?Q?IAjvPqNv38BxI5WJy6ZaNti1WqNZPSvOZ38c1pxoArtEno6tvUW7B1wGU8EI?=
 =?us-ascii?Q?BbM+hadvz6We3kjgSroBPMlFh0kkyb0c8aVLbjZvQG8b98aGeZIiN2HdtNDt?=
 =?us-ascii?Q?QJJawOlYVG+qu4l6FpsJMlw2UvlX6GyQaXOClYCO9ZQ2pZV5Fne1swvzqlic?=
 =?us-ascii?Q?V2LBOGOrZXAgHq3ClIsGDngBr7bErUXKSqtBt85la2bFauPEar96O5tTxkxS?=
 =?us-ascii?Q?x/hIbkPrPwHa89fMDF6xWIcoZFkh6CYoyPUip+bPqNiSE7pbwvlxhuLEJYOb?=
 =?us-ascii?Q?0woFFEj4vNcCp7zWTUl79WzmJYxhO3zVSV3I0ggRISydCLVTwvBjXSnW8+2p?=
 =?us-ascii?Q?E6EqkciYhva5rncsUBdE6ABsZzy0OUAfJ9DysXUa8Yzt7Z3+PsstvscgiXjU?=
 =?us-ascii?Q?6v5USt8LbOZa+Fxy4h67UVOdVwkCQlhjyro8NnsLp2EbEqVsiO9Lit19Nuo6?=
 =?us-ascii?Q?VxnYr+bqsIj3R97r3rTNuWi2IUDQWCpfrxgmRMEhi6+jmRNURFftkD6KsVjd?=
 =?us-ascii?Q?dypr1V4ePA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7388f7-c779-431d-60fa-08de651844e1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 00:40:04.5614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WCyAHecHhKfeA4yOy+D+6vXO4e5hNEamkNiHCyaHh3qyGUA9F/N176b/TC2gZUIdo3XLI7ehj+TfXSclyguI+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11598
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

On Thu, Feb 05, 2026 at 09:55:13PM +0800, alice.guo@oss.nxp.com wrote:
>From: Alice Guo <alice.guo@nxp.com>
>
>Add WDG3, WDG4 and WDG5 base addresses for i.MX952.
>
>Signed-off-by: Alice Guo <alice.guo@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
