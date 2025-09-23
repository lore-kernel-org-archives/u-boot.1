Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3D7CAC5B0
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 13:04:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBEF683443;
	Tue, 23 Sep 2025 15:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Kpevn8Mh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA74B80C93; Tue, 23 Sep 2025 09:53:13 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4037E8004F
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 09:53:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNlU7bTM2gWOp5aW4PzFS/G20quZPZIS1u16bAkUZb5AGpAcQf6x1g8Epg7WovQFnxeIpdbkHfIDzVLClhcF7casJF43J+jpNF2h3Ir+vbjEJXyT/vSq8uMeHKu6CCRtmrfCOPI+Z3KIP87A/br3/Mw3OMvEDpGX/ov8Qx8/N7uRXWvzw+7cnRp0SdzNKhS5ABavk5DZ2YrXo+Ki+NBSXu+YqFUf5Y1KMKxb53CRbGjZWOkrA3p1QN1hxlaI0jIdI/W1lSerbJapLjg/+TYnD7UXvRsnyaH8z+HsHwXmGP8z3mWyarxtUH0Uk0sdotXtsBXWzghUbt3T0g3Ha4746A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCi518BUPIpQHGvQmnMUfIGGeH3rPre6PQ9qEASgSbU=;
 b=by+1dGeyyEBHQu4pDYg9GM1aK7RDwy4AoLdqMHGT8DFBks1dSpCWP1jF0HisWhVV6Xkf0Uodo8mIyisV9I984/3sy9+MkM/LVQ1i1gtUkq6H5If4Wu93/9ZLWZzptCm8nWLqLwgByui387zczvgzsAYDmii33ccOKB5FEO2Otm2pHL9PexR5qV4wKYu6F04fFK+f21ylLAVW9NpGNWE9MQXUJS3e1cylVF6bFBITatz2ebEvb2qXwbfwtMQAigmEoVDBtOR+vNm5LqPPVFMvHvjgXJHZCeiVIT+hzMy2uh5TmqQiDN//wpOw6pSrZanF2fElxxJeO+QMXxCQx14gJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCi518BUPIpQHGvQmnMUfIGGeH3rPre6PQ9qEASgSbU=;
 b=Kpevn8MhGYFgYH5u2b92BZY+3p5zNUe4TJ93CeN2FzAn7Ag3yPH4OHkNtdaqibAvyP+SCvovc7kM0oEgCkGYisbHdfNVTe/ibLah8nWrFXw+Azc5E3GpKwnbg7ACa/aR2FVMboRxJ/n2Wws04YWAB998Czd49vKieHfzvqSNgLvDfwwaOWJWla/70BMfyi7V3MXEcdrb8gvb8YyGqo4FspJw0ZfY8oVSGKw9Ox8LAJU9DxMgSvBqAz/dogGJ5FiTEdQyj9UrYPbm6uTLcms95/Gck2Cf8RkEUaDPrKDYduCwvVUyytKSQBh7ygSR71sx/fiBPJuB+sGWqWEsN3/8kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB10460.eurprd04.prod.outlook.com (2603:10a6:10:567::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 07:53:06 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 07:53:05 +0000
Date: Tue, 23 Sep 2025 17:04:52 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2] power: regulator: Fix incorrect use of binary and
Message-ID: <20250923090452.GD31170@nxa18884-linux.ap.freescale.net>
References: <20250703-regulator_uclass_fix-v2-1-5ce6f258f5f9@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703-regulator_uclass_fix-v2-1-5ce6f258f5f9@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2P153CA0043.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::12)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU4PR04MB10460:EE_
X-MS-Office365-Filtering-Correlation-Id: cb30b2aa-d581-4d85-4110-08ddfa7639dc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|366016|52116014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EwXruUw94R3TiZj/QqMx+I11Y2DLqCGFoLWMzUvs6kBTdhNNb+/RfAl15rp+?=
 =?us-ascii?Q?6gV+3YMqzo5U2h1dL4G0IPnjAVSvdh6KOuRmlLzGPY3xSMYza+vq9kyc0HrM?=
 =?us-ascii?Q?a+ZBlbNW15IcWjvULg1tDnugo+PHMMUJsHMWgFh6b6+7NkOdiaBqD7Pg84XY?=
 =?us-ascii?Q?NnCDRD+RaD1B0Jo8u0mOffXdXmpVpabi3JJNGvgsbuZmc2KGzXGEMYVJEAYP?=
 =?us-ascii?Q?htjcmS2myjTo5lGB4+EQdSUDXFSstKpHnwZYx31DsVOhPZK8HE8ub3Y8FAhX?=
 =?us-ascii?Q?oghDBMNaYwqnY/zD9gegpNsSrIGJ8cW6aW2aVkv2E38Ou3h/OGD5UidETBbR?=
 =?us-ascii?Q?U5oHwin1+QhF5T1g5ZL8/Xi2QBerIz2rR6eZEijbdN4ALfKsMQZtWG8aY5ph?=
 =?us-ascii?Q?aF//Ic1YqueOxxw0Cr+TkmEUBsL2CP3kVlKxkYq6ob8iUlUI0LOwiUhbKEO0?=
 =?us-ascii?Q?VpGIJrvFJbkfnsQAGTkGqhGQLOB+wM9Hp7G2CLFw70Mu7O0XhKVULqJijzYM?=
 =?us-ascii?Q?OhO9qiSTpr2TIska5dC4kgKq8XCNG7RRytkxrd4i+38M/h0c4ghd6V+C/03u?=
 =?us-ascii?Q?nZKnl/BbWrQGoALfxCPMZZPyl8nZ6XmT2TUfaUe0ejOB+0PnGMt9/EL5D3Id?=
 =?us-ascii?Q?y8k0Jjo7vw1VGqOMfRA1maOihZi5fVP+SBbdKFaoVdmDkyDuIuSKuYle0MZM?=
 =?us-ascii?Q?cjKj+I+rn78zzopblcXALuI3k2gwS4uvlPMecmCwoUsvZjnUIqq7gTk9tA63?=
 =?us-ascii?Q?4eBc1KtwFjIhdhSeQ/ma7onHVetYpvApaPWGAVKRKw38c/AfLhJ3wmnbu9Wa?=
 =?us-ascii?Q?1n8KmBQFQQSrtZcaEsk+KzODoU3UBbSZ2yvrGaYl9Ldmhu0H8rvRY+/NEQ8k?=
 =?us-ascii?Q?cHDNX8VwcuUzsyl37kUuk8eUUwQgdkMbs1AW9ql7LHXYSk0K/3ERFVvo023k?=
 =?us-ascii?Q?GCz1jQsRAW3JSRMpQIWRr9kmsgH0TkOrFGMnXG6sHLLvzhHXk9gBTyJDSft4?=
 =?us-ascii?Q?F8a0ox435r58zCNLrZcUlpLYLMbkDZxwvA73o7S3Hgt0umLOnTF3bLNMK+ks?=
 =?us-ascii?Q?F0A+/U00xjdez3C0fNNzNxS+oTese8/GRbDVMvjKl0DXjTK2CGpvHr01OjEf?=
 =?us-ascii?Q?dFFjkS+/bXVR7C09/2ijEos+SDRgWKwiPHaE4P60hLORRVVpx9WrYgbT/OxE?=
 =?us-ascii?Q?nqqnmYzci13V1lkk9OWjxFBim3wW1MnLt7Lw2LmSDQ0ggUQVT4tM/5mxTIvG?=
 =?us-ascii?Q?dNv1wTjALilO9j6VBbsSYHXOlA7aVJr2/G/hODPZsC9R66IVKDtkmrdToFQl?=
 =?us-ascii?Q?bjFTIlF9rJAjEO0kTmcKqOotN7Tllc6/lKjf4HZstpM30Z+5g3wAveU+F/GK?=
 =?us-ascii?Q?QDt57G4Dv8x0t8l9rpz0+7O9Aw0+brNlpeeFs0ZGgHC2cMxbbXtPeSG4dCRt?=
 =?us-ascii?Q?s9rvF2wkh2LJqPnIO+4hXdzYOaDH5w2Hkw9WndCQgOnePgAkLEJOzA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(366016)(52116014)(376014)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XyxjYU+9P9xpGr+S4jGItnl5VxRyEgMgBJ/3Xw/vwE+IqL1A2+8IO0XCCzF1?=
 =?us-ascii?Q?bscXKl+OhRDP/wbbOf4zQyggY4Lm9/+19IhP7NPMXY01RMrV9/Tx8oD3CgNy?=
 =?us-ascii?Q?aiUzllJ9D/wckcpydp4qjyJrhobcs5K8nW9oJN9otpzsTFGaQKqkQMauC0WG?=
 =?us-ascii?Q?CMIuffCjlLDxt9fXidBG269o+BZ/wS7CgZDRDQAKw05klmkYlTrXfGmYd9Cj?=
 =?us-ascii?Q?WYISN2DQQlxJekLAX8+Cj0N9nZ35NBPnb1XBrFO/jYJj/ZUmuSuOaCIprDfz?=
 =?us-ascii?Q?21MN6T0Mh+pbgylT7zXqHFXSlrUepxOBbf3vX/jnSPzmCHcEp1Zj6Qx1VkLM?=
 =?us-ascii?Q?oSPMAhSSs/Q2r237oLx0qi89MATykv2dJZPnByLZSJNT7i20lLeBSk94Qsch?=
 =?us-ascii?Q?kLeWLXPs3tPjVK9Oc7MIt3sSxWgDAMyp4E4yMWQ/521+WPiBGEpbJVsAKgiP?=
 =?us-ascii?Q?/VTOfZHJix45dxs2jFXLEQsd1LeR/SxesAwZF6+J4+0oC07Jjev6RY+yK9S7?=
 =?us-ascii?Q?rVrr6+PisVS9Sj5ri8Gi8yny/ZdOlph2RWKn58gLiIPPfy8GKacmLC/Xk7vf?=
 =?us-ascii?Q?qNzZz40pYOYFgOwz2nDMCqbyUWikxNQC7itVkSu/mtk3RgkDTA3rl7cs1bz8?=
 =?us-ascii?Q?hMYodRhn0ZEV3SIt9/KpPFvUYFJ6yHSNGR0GNgNpaMcLk4IyF/8ciA56nuMg?=
 =?us-ascii?Q?JXGXcxtfriqTkwRVWNM59p2XphqoJcPiYfI/yiBFSCzdr7p5TP5g3peB3Mr7?=
 =?us-ascii?Q?QF9Y/C25vL94FxhO970qvNJtG2B23aiZ/kFfnh+FduzEFPxzoJ8Wby3ZnC9l?=
 =?us-ascii?Q?hkKemnFYVRbzjXiIEXvDPqlP9nNiAl9wk4oH5Hy88KbTSt+TZVNrhRlDJXTa?=
 =?us-ascii?Q?GjWhiwxwxVkRCNlDLyYQEBgvfUiIjCzM7DxL6fo4bUdldDHyP55qT+Ht0Xce?=
 =?us-ascii?Q?fvjmKf3DNFq9GSgF39YWe2x1cZrCrP6r+c0k1uN23VVPO9kAm75wGViw+mVb?=
 =?us-ascii?Q?FElRMxNNtPbF5iR0jz7HP4jVtQ35e5fXAJGpeudK8DP2vQVsoTTlhn+09RQA?=
 =?us-ascii?Q?mnsLbTPSARf72nOtM9+zomAAOF72Guz30Oxo/EK/PzhzgwZT+R/kDkz8Xojl?=
 =?us-ascii?Q?dhwFwApCGdP8nTwX1CiPMvKh8/ROh/J6yEfrBGLm9l5WSFbsLA5v8IPlpiBc?=
 =?us-ascii?Q?itgmQ1Qb4Ye6i+7jr5AlVNGsKTFXyLUB1TuapIdo12bLoPk/8W3w90ET/WCb?=
 =?us-ascii?Q?HcwrFciPHwSO3YTyZLJ9j4oEm8172sB5hZ7+Qk9nETFOcYYTh1O/gIXjRgU6?=
 =?us-ascii?Q?7b5C0BwrzB5wOOEMf0jGK6N8LDA7NPeidwF7flZXp20tniRwC65h9gb2Jj98?=
 =?us-ascii?Q?9Y7HHRtz5zUl49mwxFDbm9R8lq88C6tX/MuYJSG9lcp6AAZ/A9RPrEAZja5a?=
 =?us-ascii?Q?kRmZ0SIxc2X+xK5Ahlwt0Cx7cG9k7arlFqQLfXe8j9bASH4mBUsYbfDlBT+3?=
 =?us-ascii?Q?kfp7caKDkY3hpp7e3K6gRxg1S2wrg64AFdYT9bE9OVtLpfA+9m7XofXQPmV3?=
 =?us-ascii?Q?U2e1gkQ1tNhRfZJ3QImSrftH8E8FY77a9GoUwyWw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb30b2aa-d581-4d85-4110-08ddfa7639dc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 07:53:05.1877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FS/Pu/33yDINGEQai9PEh3pyZXGfNPRRlqhyrHyMY6R7I8msRpf8Sl+xDYCI1RCSDHzcUi9Zk1PbIKUt3Xn9FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10460
X-Mailman-Approved-At: Tue, 23 Sep 2025 15:04:30 +0200
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

On Mon, Sep 01, 2025 at 04:00:46PM +0100, Andrew Goodbody wrote:
>In regulator_list_autoset there is a test for ret being non-zero and
>error being zero but it uses the binary '&' instead of the logical '&&'
>which could well lead to unexpected results. Correct this to use the
>logical '&&' instead.
>
>This issue found by Smatch.
>
>Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
