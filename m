Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48DBCCCD195
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 07:24:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E98EC838EF;
	Wed, 22 Oct 2025 09:21:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="x0eGQQYV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B1AD83303; Wed, 22 Oct 2025 09:07:38 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9657C82E34
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 09:07:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lgvR0X1FDFemoKnWaGSSilUwcIZcRYs7jo/DUiyp9ml0nwGkv/WprjGYQBSC6N5gKfci77JBDFU81gZn+SCN9qIEc/RDAeAN5nUt98Lz9AAYF8PmsDLFo6QNZNMtScl6zwuC0Bant8a+V/AsfBvIV3+w1/JyR8rbMDJnAFZ+UnO7cxib/lpZxYxz1F9XWoRjbRTMw7KQ195LN+sgcl/eAXUooPZiFXQLFg7B/IBZU/SPcAiFnitjt0lqw67iIXD1w1lKrIql2eoOTeLrSrrtdUygojMaZCtU1gsRmuhn8cjMOlXe+Ta8jKDMeNg3Iviso+j0X8Oj40D683Qiquhopw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAH58Zi/CxuBxjTAVE/Z62IRhOUi7XNkWQsqnQCsRF8=;
 b=uvKZ+mPGSfBQF+NY4wPQhBaitPLK4/V85AIJaqhJ3wLvQQzoLUjADcIGThmJ/cILcADb1Wo0FNP8W5chLGlWfGfeKpjOtxaU/8B9tkYeul75L8n/9AROjihUvl47+ghV+UDlevJjTdOpJlKP2VkZZ+kGukOzJmKpJw9j61odXQQUon0NfiI3n3CxlmRxhizT9SqmdqtuW2ZjzSEm6+aXakAESPxsbqUw3Cwf/vrMler8jHLZogWJsz7MO2jxLwlDo2E6hX0zJlEp12hVL6ZXnJAMHi74gnNBb4UI1WBDQ1yCzAyRqDAB2ARz6omSpDDFlSl1pRaxLY04sCN5xwdrZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAH58Zi/CxuBxjTAVE/Z62IRhOUi7XNkWQsqnQCsRF8=;
 b=x0eGQQYV/otE9fjxEMk6d/DMTqhe/cFgxLiWUC8Fzee8C3PCusHL2RfMYfSMxweTDUN2D6U2mnWhpzPlCNMWWpoHTBvwj7Q5gStFJsBQeMDhCnxKoZyKxUw38aAiZMHATUG+5yrrUjIVuh/Z7fapP57OE2bN90OSUMaRilcqp2SB/umdwVM6yvacWWzZoOHU+FU5Uw846nzVscfNU6ViseG4PsjH24u9qHovJgzBJwWQZGUK12XlOgZoY20RTJNcABwy4s6us8KXApWfAkpRJA2fg9XaOCBNJ3RcwPZ8vEVRAVBMuFO+mUG4+wRggUTQZO/XEqDA3wqBqTOC+yGX2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB11879.eurprd04.prod.outlook.com (2603:10a6:20b:6f9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 07:07:33 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 07:07:33 +0000
Date: Wed, 22 Oct 2025 16:19:43 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jean-Jacques Hiblot <jjhiblot@ti.com>,
 Ronald Wahl <ronald.wahl@legrand.com>, Anand Moon <linux.amoon@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Henrik Grimler <henrik@grimler.se>
Subject: Re: [PATCH 8/9] mmc: exynos_dw_mmc: add support for SD UHS mode
Message-ID: <20251022081943.GH30163@nxa18884-linux.ap.freescale.net>
References: <20251017-mmc-dw-exynos7870-v1-0-a2c5139d9afe@disroot.org>
 <20251017-mmc-dw-exynos7870-v1-8-a2c5139d9afe@disroot.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-mmc-dw-exynos7870-v1-8-a2c5139d9afe@disroot.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA5P287CA0100.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d4::7) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM0PR04MB11879:EE_
X-MS-Office365-Filtering-Correlation-Id: a9d5708f-a81a-4b5d-c978-08de1139ac0c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|376014|52116014|7416014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C8uY9PruFm71ZqDtIqMQx5iEC0ifnKmSoJq1c33ChUWBIMn1CHwB3vnghz7W?=
 =?us-ascii?Q?4wrVXzraKpPc/rki9Lz2GVH75Ed//ULwepNNmC/iQClNaYnShKCQPJLBoOgc?=
 =?us-ascii?Q?herPLZZo1+tNrRiuhmLBuZzJEut+GXZxyxlyy8doaox9CwpOdjaUarbMnDgY?=
 =?us-ascii?Q?jOFhPXFYmY8MZezzLLyQhzkVE37UDijVsCGU4qOYzALkEa5PkJwWXN4sY+Uy?=
 =?us-ascii?Q?sIktNzsejG5pAivWWNLTAIKcT1GHY9tMEKKa6XQrEAzLj6iuKggwr+sKyzo1?=
 =?us-ascii?Q?LMdNvIIMP4iyf2PK+zcjDs/aESvBrICq3wTFbObdkSA0ZrZYGkbWRfZRtner?=
 =?us-ascii?Q?x8LW7/FleTOl+wSTrw7A3qU4dUZQ7bSpr7ZFrsybEdqTx1tWF5OyibNHrT+i?=
 =?us-ascii?Q?MEKaptazb7WuukSkVzNNGo3YE/4plWOwJ0HzX6gVKqR86VZhw9oIKZJEF1MD?=
 =?us-ascii?Q?MfaMaOlWEqlW+fULLk/i4dHgp55MzcZHcokU4w/9CILpn5M3LejGrot5VmyA?=
 =?us-ascii?Q?3o+QMYLdYLIA0rsu8wETwqUVwf+MvCgIDaOSX1uuh/cnXnhbsH0EvnMrXnX8?=
 =?us-ascii?Q?yOpjHAI+XH4n4+9/xBmvnJ/jwYTv/aRTM59znzYG0NoGW6FXDW1bv5fvrJZs?=
 =?us-ascii?Q?aArenX/TK3B0q34PAFbS8O8yqJAxZMdsK/r3Rr/qxlUdXgelNhfQiw8wcTyo?=
 =?us-ascii?Q?+CC8anvWO/tm0nx6BNg7UlxIKffAJDzqD7s1vrxBjteEDGoTtL7hELafsod1?=
 =?us-ascii?Q?j6pRjcskIPtD5ufBQ+lqxwJ3cuh3BIIfgeQ4FRbyqQJfv38LjSkgsRXhIr3Y?=
 =?us-ascii?Q?744hVVUPwj62z6Z1BFLsWWrs/FRZZFPvM7iwqbLZ33M8AVRjxc6ec5qxNZ37?=
 =?us-ascii?Q?U7gU1ffLTd2378eeivxHuPM2ybPmzT0ymcM9tp9ng2W3D7EGEqIF5+GtUWKJ?=
 =?us-ascii?Q?s3WqDeC9YmVgRNZKs/npaTIYGJ5HZowOgTy5jtRNZGVvbt3Yo2E6hDiywBPD?=
 =?us-ascii?Q?elpae2auPO//7OLaJVdGRjiZvuv92ht3iN+T9iOaHBFRuPvpRrUPOrLbalsy?=
 =?us-ascii?Q?8GjIlKbuUrkMruq6tI8KGMvnmAfi4Fph8dbebljA8JHvRCCR8MCf18phVBO9?=
 =?us-ascii?Q?EAS8MWsbdnCLO4a+fkj3pzJNjluUQysy9RPqZve8zE4A+N9zdWQJjhu4F3L9?=
 =?us-ascii?Q?xnyqbnsIFKnFTHdCbM++fUZZM9cRiX84Fae7DLyMr9hTItZV7LzlA4p0xuYr?=
 =?us-ascii?Q?gd9LmcWl03Zgx8Vn3jziVne2Uu5ega2A909YRicYtGjFPyUrbJawvKrAU/2J?=
 =?us-ascii?Q?aACcJRolRd9dA6NgU1lwpMiPn5OAMbO0VQje0uVRCTHtUlmnkSXHJsdG26iQ?=
 =?us-ascii?Q?Cp511NNvyDso/u86Saft/p3Q5K4puYEPmNd2yDKeLswa3dL50xv0IFFhqJu+?=
 =?us-ascii?Q?dT70Zaze8aCHgytrtEw4ui+0p5J59aMZuCQvz7IkXue1r6/Upbdu6nL9g0tS?=
 =?us-ascii?Q?r4h/aDCsUn79yBzYx48dnIlta1TvYO1pvfiI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(7416014)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?llccNMVG3rVfb6YIyWWh7X4E42H4jUbWfCBpON+NfMLq3JUiLtSaA/TRZD2T?=
 =?us-ascii?Q?YdS10aaJfe1voaESgTrkdewikRLsuLgLm4tMQF+AFlM5VsUEkiKHiPWiKZ2G?=
 =?us-ascii?Q?uKyg5qE+2+EV8TLklN6mN5Y8CHkRLlgUDPWaG6r6z/H8L7Qe3PUS/2S4j0rp?=
 =?us-ascii?Q?DIBC81J1Il8t0LwCjrcd6qknnrgo7W08EUArI20tbczM7e1c41qjABAolp0y?=
 =?us-ascii?Q?/wcTawAmfsthuIcSIJEl8LtY0V+bgyqwRaqedg5tYs0Y0N39v5C0v29F9vnW?=
 =?us-ascii?Q?Qy64hpETK240cj6duvaxgO9UuDxbBg0fG8D8pA15sKY52Eikk5gAyBBxKgbh?=
 =?us-ascii?Q?iK7KhdjK/JJikMRyNzZjUntqG4vDE/1pCu5Xc7OKy4f1ovje0AHmMNjTwpkG?=
 =?us-ascii?Q?dpUl/xCLg2ZBSMHqAbTKlAQKP2LXTYLPr4Ne5X/Hw05htn8mkoQLHmYO81/7?=
 =?us-ascii?Q?+aQi3fB+XGOdBB4Yt6aRU0PpS9CcSSurUtsEOsGnf8et6tR1JK0FIqf9NOr3?=
 =?us-ascii?Q?ho9jF19E32mOXAwxf/uTpWozUso5R2HxPZmgkERes+LzZ67PRW45Ui4yyCMw?=
 =?us-ascii?Q?HLrvc9fL+JxkivchLoYSUjSTuzogbLvphaVWdfaQr76gVsglD05oUN0vw93q?=
 =?us-ascii?Q?6CDgdb2vvbg/Lj+ZeMR7tK6cGoWs1nFfhBmRM8chuUDpllTgZk0TE3SCd9pI?=
 =?us-ascii?Q?mRdeXDh6ZDcGlIq50URbKgUqnol5FsA4ELoRqHB/eVUzPLUrD//9EBwdKYjw?=
 =?us-ascii?Q?KLJfgxEZaqxHTk6ueKxqSHdKGswpyFGkQ6ICxQCnB75A9Qc/Vjy88hvJKBJX?=
 =?us-ascii?Q?zk9Db956YpkSQRS32c8kh/GgofWAuJWECpFNRHvu9uFYrLWMjz7J6AaVrU7r?=
 =?us-ascii?Q?qb7kBCTvnMd3/k66DFScsmh/Te7eWgxyMXhF3V4JkNCi7XhjSn62rSwSs+DR?=
 =?us-ascii?Q?zR7J3I51XvzCZDNbl2lyuboUSwE9AQ0nE+Eb+JGgE1IePCbyG6Qp85UJwsim?=
 =?us-ascii?Q?X5ElUiefQTvU9RDsSakNSIRng3P2XID2UQQQ17xyYIW5+xNXYzPwmcsFH/gu?=
 =?us-ascii?Q?VM4mWusGmtIEgq5BGzwDTHOE1ARpTQJL0D9+4BcWGMSFcuXuiq1SI9A1VxCZ?=
 =?us-ascii?Q?7UEaQrKNBCn/iSEVzffitLFkJvMUI2iox+uVV1Widoc9CtAh+8Dz/x6xE6LI?=
 =?us-ascii?Q?S/2NdjwZg4mCPqlSS/YQ/ctIYL5GpDK2nDn12av65tNm/b5QCWf+J6Xy7V2G?=
 =?us-ascii?Q?9bBecLV3NhQmPv3/1KHm4gJq2PZy+PBqITjHgiX7C/H1iFeNPn1Yuj7v7n1K?=
 =?us-ascii?Q?fvQXPTHjzBHIsu0R56JCm/K/rfJT6OBVKAJA8ZIC9TF1t6Bj9NJkMw3MXj55?=
 =?us-ascii?Q?i6pkWsYuU+NG7m/zQwAUtfdv7a81w5jyJuvgYd0chRfktwfSAZsiRXMz39Qr?=
 =?us-ascii?Q?B4p4ji6L2QTFxwWffGpNvUyVIjntY3n8eL6ZRPZLKn1cT50zY3Ocz/nTzap4?=
 =?us-ascii?Q?fN3EyI59X4W4c2mX5dH4VBBsMX0X+ZvzVJMX4bEUM85JvojnC7N24joX+/aw?=
 =?us-ascii?Q?HvG6SA51f5Y7M6cAkqr48cnDvRztj+CkyWZAuNDM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d5708f-a81a-4b5d-c978-08de1139ac0c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:07:33.1992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ow3moW1CNlwNhc6qlqtxNumlAQqJxPvHNG7Mg56BdiSb8ziNra7JGQ17/O1rhA3DiZT2Ua7KQ51sbzCYyXBmZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11879
X-Mailman-Approved-At: Wed, 22 Oct 2025 09:21:43 +0200
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

On Fri, Oct 17, 2025 at 08:54:13PM +0530, Kaustabh Chakraborty wrote:
>SD UHS mode is already supported by the Exynos DW-MMC driver in mainline
>Linux. Using that as reference, add support in the U-Boot driver.
>
>The maximum frequency was capped to 200000000, increase it to 208000000,
>which is the required frequency for UHS_SDR104, which has the highest
>frequency of all UHS modes. Moreover, add UHS_CAPS to host capailities.
>These changes allow both host and card to recognize support for all UHS
>modes.
>
>SDR104, SDR50, and DDR50 have their own CLKSEL timing values, which
>requires the CIU div value to be set in bits 18:16. Move the function
>exynos_dwmci_clksel() below exynos_dwmmc_get_ciu_div() so that the
>latter is accessible from the former, and add cases for said timing
>modes.
>
>Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
