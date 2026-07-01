Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29317C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 07:34:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE28B84B2B;
	Wed,  1 Jul 2026 09:33:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kfPo+wIh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD94884B32; Wed,  1 Jul 2026 09:33:58 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF04884A1D
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 09:33:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NiSNlYCO5ae2MgoapB+xIsYO9H8TabAgTwfjaWt7bZB3WjiU7b1goPfMhyKLltcJVC+Cdpji9O6Gy2gCIxP3q7m/+EybVhXlcIUkCakru7fW9eY1BALC9R6NMAlpBoLI9ylhPhA641HJ6cgrXTyQ0NGqSowf7vteC8Pi45rwz73O/glAn6OeSV5IZ1mMEhsLzYUBuAXGN7ZC5KXW2XpFQSvV/g9qwb2UES2awy6r6OkjAU5de9u8/3O+vBqS6tOR+ZQQdPE0Lqa9p5vNKK2X9XgxoESDK51Nsn1fyYNoi69T6lc/0+Zihav3+O7xe5Mb1Db/oF9O122+tcT9iJEX1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImQO2lZrRF6eoUTNEJ4ZLld7VG+oaoepiF2AcauZlwA=;
 b=Sa3wj6dSG1KkwkRqxGUU2WYLx8TV25JjMAUCjpt7C7bsZlDCrRNUElA3NUdZoDnlTCAb/zE8r0lP7ZiZpFH3z+k7/YEWhuryhdU14tEsugVNsdE9PNJAQWE4dYvyl4Ddvx1DRI3XAVRHe5PZEjeGCqMvbMil5AaNu5C+WdAd0BCA7ycrO6Gv7ViysZe8uxDQcQw+zGs0FXPfeKCk+vBS9oM7F/pu5iYyKqROCiqY+TcRbOo785A/eo1u+QvM9+IY1lpN9Lkc1Pl9CZpFDTE10rkLUGR7sTwAYCk8NnWuUGSdXxwcm5cIrYCGOyeO7FGtrbiiUBk28F86GjK4WsrQXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImQO2lZrRF6eoUTNEJ4ZLld7VG+oaoepiF2AcauZlwA=;
 b=kfPo+wIhs64CaXptx8SzjCMibSsFOShSzT8RuyYvS+WXFLs6464nYIn1rCHm59MP0AmvyjbRVRctxkbAb1dGNQkPfCn3t7dCbj7FVA1IOhQiHB7cf0umZH3H6jVaM3UnWCrTkHLPwyj9tmIdLqrk2mRjFdgK9pNLrqIka+JLkxYAZqYjX4GtGEBic0NVI2Am+OwaY44qi3uyB+SbDl3OeJlbYHMw88aCuIKpSojVQxN1BGaRFvwmsSZSmi5GsB7M0zWSlY/kwo51Wgw7HqvumiP2xA0C/zms7P2F9DofEl4gn9duVciTOEfznUGbYK6Q4JxW77cgy0N2VKpD0Q4I2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DBBPR04MB7497.eurprd04.prod.outlook.com (2603:10a6:10:204::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 07:33:55 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Wed, 1 Jul 2026
 07:33:55 +0000
Date: Wed, 1 Jul 2026 15:37:19 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marex@nabladev.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Yannic Moog <y.moog@phytec.de>
Subject: Re: [PATCH v2 2/3] arm64: dts: imx8mm: Drop nxp,fspi-header-filename
Message-ID: <akTDrysgTbm6pfQw@shlinux89>
References: <20260630084112.13259-1-marex@nabladev.com>
 <20260630084112.13259-2-marex@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630084112.13259-2-marex@nabladev.com>
X-ClientProxiedBy: SG2PR01CA0183.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::16) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DBBPR04MB7497:EE_
X-MS-Office365-Filtering-Correlation-Id: b8644889-c2b8-423f-e745-08ded7431b2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|23010399003|366016|1800799024|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: mTYUprzIRQ9AMKs9Tj6z7SLhqR9gxIOWrfhQontZlt7KPOI+zB47YZykdD/1UbdKZDPTBwmmhn1BOZh/+xReYqjkk1GfoeK9HvntTTEiM9mp3ZVSLxKne8kyPsjcO72qqaTdu+cLO5x7zmqEg+sr1yKcNEVBTS1dZqhGxCXck4S5P7vln64blfQack6Tuy4Ej4/HwQbrqTedV0vrNi8lyKdnf27dXIDsxwAbnfaJFGCtucj7Yt1Djr7RS1ngwIQQTD9U8fXH/5KfapQ8R5MZE7jtSrCox7cZihdYDKEYloFqSwdym76VYYmj00AanUhSryVqSS07FFDiiPxnH4McLJghrH/tx1W6YR7GgLG7hFmtB27XAH1aAgWjggm2BdEp45WPzxIyOIfIKblc36Hri2g6chheOqqTcajTnZD52Gmk3AwMI/qAYxWXHTlYhx8cGpWKLlrlPiYwTg+E+60HB/9WJaIVLei/Ncp4dXu1vANl2/n8LJxQ0F79+iribaBSPdrCFAYvMd7SSvFoirEkIlTihO0z2L1Pum7cHzQLWubgtyc8yfWMfmH/w/2Ig8czvteum5TM/p9gtCCBchTU1ap7xVpYA7RD/fltjT/lX6jsRIgoUmAWhJ1FnL5JrYbi1nI6EUIq5vFs6zj1teJT28Sl28QP9WDvtjhRso4ePEw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(23010399003)(366016)(1800799024)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r5xhtH2PD+dcVxZkDUIryK7CwrRneEiMJENMHAU8Eg5/whmcPMBxS1rsUtrl?=
 =?us-ascii?Q?y8AAslN3pa/Fi/YiLIYrU57tHCXIW3MbyySJXW5NF2iZrcv1AvlZa8INXg5Q?=
 =?us-ascii?Q?LXebBvpK4tUAzfq1Huwl5IJczS6kjbnSerSrucvgmNdKp5pg4OyhoOiHUsap?=
 =?us-ascii?Q?tw0ieIRdI1lBFI6bOfi+ct/O53FFB6U7r1mzz1XhXIPp0Epsw3Bt3vVOMKJA?=
 =?us-ascii?Q?YKNa2+DYypFRkwmZBP+MkFoJTx93y7coTuyuxj2FZfRQ8arzbV8afT7V5RJP?=
 =?us-ascii?Q?XZ1qJbzqU0AwuEuJ2pnUBG1QlAU/oIXIY47Sx0U3+Ip0HkBww7WNKWjTv6B2?=
 =?us-ascii?Q?e/hmwR9kqpin9O1nA24um1dcCu7jCN4d1+nh+yzKf7dETKg9VT/DBgY4+YhM?=
 =?us-ascii?Q?MF+U4hOs20c+PFwzRqPhU277pd175FmCbh1ner+dsJZoVcCkZNFL1TeZViRI?=
 =?us-ascii?Q?Vvx9WcUNrNjDM3LFdFoOSeB5eTB18GxhWPtt0inQgE0W5u1FR1i4MxC6yNw5?=
 =?us-ascii?Q?vuV02zfxkuZafXuhtcbEDHzsLMuaw9Y6VfeKGMXhkdQWK8Ac5tFBF0xEUctL?=
 =?us-ascii?Q?g4Dn/0axYE3ZOOwlU/IzrI8fvhMzSCO6dXct6bx4qoEEgMEfdTFrpgCAURFg?=
 =?us-ascii?Q?8Xs10EO2F72SEIOAKBS27UE/cIYtyP7yoEwK43hA7k0E+KzSSh1Y2zT3JxNR?=
 =?us-ascii?Q?Aae39a9xorRc4+oxc0G9XLzBh+r4wkd/qjYtMIqppVtoBx/jPjN1860kbttg?=
 =?us-ascii?Q?PnH1Yy9Hk45R01EO8SWYb+aLWeozrgCMHwwxL3wCaRsNg9hh13ioImdiTMJ0?=
 =?us-ascii?Q?nq38pHHGMugjHh/t2U1xjRcOcorh8B6bWPZdKkclzyURBqJOfo9iPp4ZwhV2?=
 =?us-ascii?Q?tIuX/eEYXiaNsWgZ7gHXDmzoIkTJSEhKUnkellPDhScCgiJM4ormK/2Moi0E?=
 =?us-ascii?Q?nZCJ4JzlpKobg0sTotyDUNtW2edCgbhhhjuk9C/XZjaRvo+p0M8fn+xDJY+E?=
 =?us-ascii?Q?/oGzXNO0Lh0s2zA7ZqPx/PwO2B8nKNuK+e+ZXq3Xn90DHabibVKqKfNQ4Udy?=
 =?us-ascii?Q?YRuZwfyC4BWF8u7w1KBMgZTPRMvLdNLUu5XlGoVR8aq/Luw3x8WWmqUld/E+?=
 =?us-ascii?Q?PdcvT8Cv28aHIkO9A4UPs6HPnuYZuVvicZO6g4pUsPhDz67EGEyinNEJW95P?=
 =?us-ascii?Q?5WGjpXdmVGtKla/zvFJJSUrJGS3x5fGxVai0tGZ81atPWHhMIVQGVSnxQ24t?=
 =?us-ascii?Q?bFQfDVSLW4WjJFgkYcH4j9UF0FTq87Hvw0a2r+j4/AqnRhufh/Vh7cJHRP8w?=
 =?us-ascii?Q?ewhR8vo14cxrIKZw3SbdILKWCUFqSTKdvlE98IESGrlpRaviTMlgCLQMcFa8?=
 =?us-ascii?Q?pwcqCIyAJlO0r/zo2raHHkcTHXRYPCyZlY3MbdZFj+w5ekZLFO4XUUYIkhlw?=
 =?us-ascii?Q?5gOKTzOEdd5XvZksFnqqQ4aLgcLEUDEJ6j96kIf4mS9Ni2fbbV3bPQn6Lv4u?=
 =?us-ascii?Q?Lao/I6AV5cIgwdg5Tqb/EriqShh14GmIdYRlWhABvFU+1qUXZZI67Mwc0HnS?=
 =?us-ascii?Q?WyDewbD0DgV8UgY7WzkxtlUsYWP4DfuyRJVtI/qtn3ALIboJmjenku9XhMq5?=
 =?us-ascii?Q?7Hw8B9Vx0QJLD9oWh2mDcdWzYcEv3ymTmKXkdMyEM3prsKVZ0sjW/KutYzHJ?=
 =?us-ascii?Q?59i7V9DLtg+mA9quExJI9bYweb5ShgUJ6zfLGkRbXq/yQDbpnVuWG/I7/8Dq?=
 =?us-ascii?Q?v6NVPPF00wvcLTKKvXcaff0MT4N4/KYENA2knXbisWUnegvmfE/6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8644889-c2b8-423f-e745-08ded7431b2e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 07:33:55.3105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gqujJvhW4tCIoF9LYW6nNifCcQFj51sVnbyY4iHGnqJYQ52HOjXWsiFlradmtVel4xAOe/qgzF1KPCzIBFr4O7rb/xbHikB3ihb6T6TUPrKipDTyjah/nHq67YOR5LXr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7497
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

On Tue, Jun 30, 2026 at 10:40:47AM +0200, Marek Vasut wrote:
>The FSPI header is now generated purely using binman, drop no longer
>supported nxp,fspi-header-filename property.
>
>Signed-off-by: Marek Vasut <marex@nabladev.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
