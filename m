Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF58ECD9B5
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 00:35:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FF69831AC;
	Fri,  6 Feb 2026 01:35:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kOo/NA4u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDD32836D3; Fri,  6 Feb 2026 01:35:21 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E850083015
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 01:35:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N6+UT+E+D349zbewkYca2tA2UMBRmcvlWnLyVpRCvUytstGVmBzsv6vTJutYjaMIuWsWJzrd0pmzQ0z5GZnsAxmd0eoASMSyDO9Qkv3YsoxGecZSoMKNfPH/g05DH6tVW/TJrrUCqcbe3OT+xRK6gR+nm90mvb806xSsO5KA+JxS0p2whLunO7ERRuIZF7+K/W6+U1rLnKIoonN4e0cjaN750Wy6xYXjdNdgoE2165vqO3QuQbJuRrZAzXJQxwfdbnIeETgSL97HquYafq13fMUNYlMZK7KMNptDSiDwfkhuQee+ocu9muHT6qhrOsZftqVPEk7dIG+doLWrDknBmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b90R16Bz3TfyokcdQxvtr8vvoJ8Wirlg8Mx0VbOL9Wc=;
 b=nwycLxrJbBwrzfojN+d63ni+qK2FCboh3V0AIGXyoqX7tL1USCgMIcilCTOtg0k9YkXYZzrJoSlmc2Hxq3qDnIgCP5iYzxzwQ1H9iSnBMd/AcqojgnhkvQYDaFtY7CQc6RLiorPmphGktiVO/8oE0P4M4i1k+/KefPQ4W3RO4zBdKfyi9y4+tGlENVWH+1a0u4jYLBU5ARCy+W/YRxOsy9iSEQR1PHuvpobIxJPv7fDLDBpG/Krn/8apY6ytI8mtz5OW+YbM0kjt3e4wScCwT79JQotk3i8dek04o6kx/D8cLGMkyqtlwTbf4Xz/CIPqyLv2Gv9+oap8LyATr/B37g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b90R16Bz3TfyokcdQxvtr8vvoJ8Wirlg8Mx0VbOL9Wc=;
 b=kOo/NA4uliVXz3K6R2z5xShrPu60bdayXJK2uFAN5vd2OMzve0PA3a3p9LX/wppbuBOcYUv094r46lDpjbEsdLw+599xc2xtym2hv1hhdxm1o+QjrfPFn0q6V+4sr80sgQQohSP4IfWd2029T8BHn47kR2tfeEIHOu7EIexmpSjiPF/hrLZg/6WXiopXqv+Ujj3vTVmMP2ljByEDoxisMuaLQhfNKj/551qdXbvp5oqQkgDUeAClwErTIH8AFQ7yWa/XegGD4XJ+TeO++wjy3oAyjvTLg8Tvl+d/clg6oRd4wpksLfUp/JM7xiHOw7gpCNqi1IcPOUvdO75L0flfnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10925.eurprd04.prod.outlook.com (2603:10a6:800:25b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 00:35:17 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 00:35:17 +0000
Date: Fri, 6 Feb 2026 08:36:53 +0800
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
Subject: Re: [PATCH v1 03/12] pinctrl: nxp: Add i.MX952 support
Message-ID: <aYU3pYMzRA/2CFus@shlinux89>
References: <20260205-imx952-v1-0-2103d0222a0b@nxp.com>
 <20260205-imx952-v1-3-2103d0222a0b@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205-imx952-v1-3-2103d0222a0b@nxp.com>
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB10925:EE_
X-MS-Office365-Filtering-Correlation-Id: d5460d9e-cbc0-4dd9-3173-08de6517998e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|376014|366016|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ybCN9rrANtZ3X8+z7ydb1yyGXxSEx5BryHP8NoYWs+FmXRGt8kLJch5yfNTI?=
 =?us-ascii?Q?vFjoHK+Zo2OKWqhaO3rQXwpZnJmOD5jryWXTmRq9eZYwR1/P3c828s7XVGD2?=
 =?us-ascii?Q?ILRyJF1VektIwmmx4YA/2k3WDGBkdGON817jtpU5m/yof9wVkixdh9XB3iag?=
 =?us-ascii?Q?H6Oe8B5q3wdCSs3ptrhTXvbOMjmjzi9FsA2PM7TvFG7IB2IHGjkoeWUQngJw?=
 =?us-ascii?Q?xPZnBieDIUuWMTtn6CBHA61IqwgHeqSiATDK0YXc/4TIMWExCaYivBH6nEq7?=
 =?us-ascii?Q?tkTg3OTLWfooBUitfq+uykLas9JaZh69SfNjHy2nNrtr6/ZqcEjeGec2WFtH?=
 =?us-ascii?Q?3cACYq8VdrA1/5S9DwscN6EdeponsUIzMQ9RqUDHQCvau0S8Fs9d+5qt4N4z?=
 =?us-ascii?Q?1p3SOPLKtUwpQQ1V8QTPEnD5QSFct3DUD1mJtYYfkri00wKpxkHJlzmPbWMM?=
 =?us-ascii?Q?wC44Da3VZzTy8AtYA6Uc/j3Wf5UN4EXq82GUjBRXcgZxLGDPILPjpm/GUcVf?=
 =?us-ascii?Q?KmH2AahI6A+cNX7tjCP/UKmqArUakxTNaPrOKTbTV0O6VuBFpT7VwB7ktznW?=
 =?us-ascii?Q?l0CmoFpBZhdBlbc5WlSGzx718mBV8qA6uBSKYUhLYosNvZw6C72YC47PT7l3?=
 =?us-ascii?Q?alDL+PpBk7rkIP+wRUE7Va/MKHW5KoEHxbOFtSTRRv6FNX+SF+M0KQNFFyXk?=
 =?us-ascii?Q?f2cFT10Atvdid+eZ6/9H5bwKhq6XIeLhXo069BaQ9oxUNEAqm0mlOatmwXEo?=
 =?us-ascii?Q?yKmPZMKmJcYc8VM9hLEQsRvRaykKf4f/xT0vwfgIvig2N7Ldy4gmcZ7dPbBt?=
 =?us-ascii?Q?Q+QwIgOD7SYgl087fLPEl1zXs33LMoIk19CBoe9IhWMyq2l0ZakMCr5Tng2z?=
 =?us-ascii?Q?iShrQJaFgq1YNQdZNXBK/FeI99ISRKu8xv0jr5wQ0qEdyVEp9cPWmIhO7lXC?=
 =?us-ascii?Q?CQtfYZk8wHdKpoXEHyzNl4wybPeb3BxcfQoJ6F8ZZf874yrp10yjsy5JO0qq?=
 =?us-ascii?Q?QH0tZipp08vAPzpioHrN3Ibgyu9a8sOsHju2LY2JBiRLRjuuPnUbvMkXTkLl?=
 =?us-ascii?Q?NM7niDD/2tfYnkj6aZ8WN8lODOOMfA8f8S7zeviv6tF5eFmaeBzZYRbQdqJ/?=
 =?us-ascii?Q?MlyV0mEoaor4JiADNim4UKbUEePd3n/wz2UBn7YxLzfGvskKPV+y3XFmZmSX?=
 =?us-ascii?Q?32PIUselw2N3JCgq9fDBY82xaOdMhJyLXptoEQk6tJTkO4XuzW3EA9QH9+XI?=
 =?us-ascii?Q?HKKeMf26mCWMOjH09yLNUAVdM86tWeLKpBB15pJKZgfS4JRXG0SHUnsT20mH?=
 =?us-ascii?Q?y6tY47O3g1f2L6F12y6FF/XmpI0h0KavMv64uuJllBsGBbkJu5EA5nCQTG6S?=
 =?us-ascii?Q?NXHHZPdIF7ZApTsVkhg9C4EW203hZ6G/3Q77JCVDnaEUDETyn1dRHY5GGkim?=
 =?us-ascii?Q?5mD9zbnilVMpT3x8i7idP5ZXbGhW6ZDX/9uvbZX5aKRTYjbgb0PsRE028H6o?=
 =?us-ascii?Q?DLTbsh/TzXsZcVKDVW/fBRjO9K6k3UvM+Dod4akEq1iuLqlBOgf2aflQE3nU?=
 =?us-ascii?Q?OUpaurO55Gfg6EgZNzT6vYML2NSX0wlOsRd8vzoNN+v4BODEvqV+b5nZG9E5?=
 =?us-ascii?Q?KzwZMMhwjiNkO2JDZQVjPDM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(7416014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bgUxKHL4tuE3904Pohml2m840lmJvT6a1AGBjaBSVNBm8Qm4ZydU3NeX5+Jo?=
 =?us-ascii?Q?H78TpBNEZ+CwpGDVYmwECTMvn8qtMTQBsZPnK1vPxprB8ALhAehXBU5LZ/1L?=
 =?us-ascii?Q?2A2xpG+MD46r2T9xS6PdCXQxZwoaGiQ/6Up9jRF53oC1OOxVv9pcrFusfd3+?=
 =?us-ascii?Q?HTB0k6NFerepOlLBB0FZFPqOaODlrLGysTaYcnXHEcDW5lOd8lRLuO/X2USj?=
 =?us-ascii?Q?OSK0/hbwU1IxAaRXdYliQaUvuQIPjSjKSTENP0pPBUQh/bzwj2pdg7ykMidr?=
 =?us-ascii?Q?iEzlpV6aR+5GG9F27+AqcR7HQl7AdjPAheCuxPROFTO5H0WxhVMUyk/7ax5N?=
 =?us-ascii?Q?ltB19Ev8OSN1MDiwew5iJSnRrOUvMHVoomFRKPXP18hvbGOMrpkUstXogYcY?=
 =?us-ascii?Q?QD2V8nmOz4RuDfnzMnS7b+ZY+2BzctBmik6256INWMNEeflxPfly9fvOWHS/?=
 =?us-ascii?Q?+TkBkhuXix84F0wOjRFwpKiqDRbK4p/3iG/K7wG+F3jFW/4ar7tjNN9LmQYO?=
 =?us-ascii?Q?FupBgKMnoCYMRvLMYrfUdZ5CBhfTuVEIQ8G3yQ3D+7RrOkc/gUrbIRU7KE9x?=
 =?us-ascii?Q?LYp0S2nFBxkVBFlT0U4CQJ7sG80e5cS6YvQsN7v07yBTsVJrf1M5Lf6xT1ji?=
 =?us-ascii?Q?vmBtt8mOrLy7r0gYBMeUC1ckSQNNEVDWsa/hPWJiDmuPQIc3RmLKTgG3vL3z?=
 =?us-ascii?Q?GvOltkvvWZ1gWCzp5V0AK5LSxzF1ERgN9kR2IdDtfGE96GlX2z5F2dZi2kJM?=
 =?us-ascii?Q?bRnHA4IpV19kQA2Vp1KcRGyZQKY0viuvtlmg/D0SvIrY4JNfqvuMJpCb1heh?=
 =?us-ascii?Q?O7xjCdLgwN93eaS60m3Kjmvwf7V9PBlfsL9+mMw7vd0elhz+jk18bDeXeidl?=
 =?us-ascii?Q?rNhczu3jzPcK/iS38iWOOV+vaWUWUIx+ZSn/jtdpEWuMKNKQqfgUh4gYN3pp?=
 =?us-ascii?Q?YdrGK/sPVFiDdTqZNgNT9YX3cO0i9X8n2BLWuEzWZ8TBCuMRZpKQxNYPhuO/?=
 =?us-ascii?Q?eNUd+FPIYCeB+/uggArj2mVAgUO4aw+o4xpJCAJSQgRZ5dNAHcw7Nl5O8VKR?=
 =?us-ascii?Q?ZamN05Z6pmrMIWPhvnq55pRkuXoHL350yXWjvkh3Ra9jOPIhEPOYPoKgXFFE?=
 =?us-ascii?Q?fEBWSKNmQVq293ONiKqV5bRkH4EHONA+hWjwq4FBBR6jAHoevAr81mumPuSb?=
 =?us-ascii?Q?WSY31Q8hbzAtnlv7z6swbIlLQHFYSKhickHG9wDdX0FypUGWRVApBGMpt+xF?=
 =?us-ascii?Q?RyOBizm3TS0bsgRmXuEA9hAyikCboOzrpUxZmsC0WG4cnjVKRZMTpVP4MP7w?=
 =?us-ascii?Q?hG3dk8e+LnT9j8b9+XpChBgPn6fPM6Zh49GJuHt8R+vQtb1RjCs/TJ8ZEH/D?=
 =?us-ascii?Q?Kf5l0eo65yp2awha9gdg1V0yBR1Rx5Yg7NH10UT1mvNikHIaw7v7Lg/I3QDf?=
 =?us-ascii?Q?tzXtCCT/1LUVfXq8LoCnJBapC+JYiuyUUVQHtBn/NqZU0GjcN4C9vzTq3+0Y?=
 =?us-ascii?Q?aDci9ng3yAUGw398j0z9zGwAdLqKhXq99IPiYv5DJammvHIhqt+pU0vX8Cyd?=
 =?us-ascii?Q?aJCZcPifMTKdzN8B9xsDTIOAvtvfqCBBrJOGO2zI/K0CBFtXrDHc96eDQ0Zs?=
 =?us-ascii?Q?+YLtWq2CB7AsSEeoXr4tYETZqzrLeTOIDSGMNCQRGQrgbf1NQ3a7QpzqgwHU?=
 =?us-ascii?Q?EWl212j3N9Y+r6ho+yfOIhWwAdrk4TKz+x1pgKfrDM8o+qjA4/aILnFelMqf?=
 =?us-ascii?Q?rJHmO74jWQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5460d9e-cbc0-4dd9-3173-08de6517998e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 00:35:17.1024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJ8GkMrTJ+ZgJn7JNQn3bPHr6Pj7kCU3anYLcXeZblcdMWGG7cny9TLhsRVw9LSzPuaofupZnQGWWyCD8x4m7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10925
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

On Thu, Feb 05, 2026 at 09:55:09PM +0800, alice.guo@oss.nxp.com wrote:
>From: Ye Li <ye.li@nxp.com>
>
>Multiple pads can drive the same module input pin, and a daisy chain
>register is used to select the active input path. This patch defines
>DAISY_OFFSET_IMX952 (0x460) and allows binding on i.MX952.
>
>Signed-off-by: Ye Li <ye.li@nxp.com>
>Signed-off-by: Alice Guo <alice.guo@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
