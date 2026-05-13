Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 123B4CD4F24
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 10:01:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B71384690;
	Wed, 13 May 2026 12:00:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="C5r7rj0T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65CAC84690; Wed, 13 May 2026 12:00:55 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 986F480086
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 12:00:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u47VtA8SEIM2wzLh29GFotHAVfyUGgHtzvBMkM/UKh3Rl/n1EGlb8oafw90XVyZUQhVPR5JW8OZnVIcZQ3TPhKCrLRq8dWIYek96DLT4f2R1aFBDomITdyVLjxm3Gz35Y+yX6/bTU09OVZ1omimF098ktgWlzF+1tnzjQwvrsNYWkO/bRax6xhahZEpjwehUigoN1Z29ZC2NHE5TawUCO40YdCHp0nmCC8YsrL+dJIRFQPAp3ki6VV8mto4Kb4VNRIMfKOrFxxRISwnSsj3VBTrVwR5us4wqUrKkkJRczT9OpjmqBR2vH73DO+nmypyX/FmqPT9qC4bb9Jw8wcI/cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21wi1UBiN9xR0elH+mHqRMe4cbetPLm6t0GlfT37SGs=;
 b=jZJy3rrVLq74DNPub9BxFqI5mJJlT4U5K7Ii2GlZB/J2rsyrx0VVB1bOWz5Lp9lKWoV8rp5s3ENse5Qe/J6TfSQs8IR3EujexYCbQqpDMRysud+KzLKqpEYzCAgjtXdN9X4TuyB29adXz2tqA1AHytWil+Ur74MFIXNyVMRWvtce6o9ur8txV6gDi5wTCK6c/UySZUu8i5Rw+btjjWay3RxL9yQaWJ4UZvHXyOaHnPKkKGoV24sWXeeJiAjmX7kcrwJ2UAbYnmztxFmpwT62auDCftq+u437Yy+HLc+5zAEe//nLWg8wUKIJTrnxKPTK758kFQxJUKU/x5zCl/R/3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21wi1UBiN9xR0elH+mHqRMe4cbetPLm6t0GlfT37SGs=;
 b=C5r7rj0Tp9c44Wx9nWyqFuR6+inmtGZzx1TbL+nSvYT2yI7I/pJAvl70e7KCUwp929TKtCaiOkKVvNjeYSaFmKdfMIcsBQKTP5YfqZ/pOPZZ8eFGHsW3+pQd34XAsKwEdKjyp5pKmy4fwxHzthnd6X7w2P4G5f4fNTk8Iz6nfCzhsx7EQkxmQqfHfusxzOBxx5RSeKGjNQlAM9RWmYTfKJNVniko7ZsDKGuMFyXn6P8tWuZR9JEZeDuuJEXWArE2O6MAVeBFx7eyaIPtdD1esHcADajeLn2+cz/exw46Zy0o/byfhM30jrMp+Nu4Ex6Pb3goeXcxPM0+T3HjI9oRKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by VI2PR04MB10836.eurprd04.prod.outlook.com (2603:10a6:800:276::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 10:00:51 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 10:00:51 +0000
Date: Wed, 13 May 2026 18:03:39 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 David Lechner <dlechner@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Julien Stephan <jstephan@baylibre.com>, Peng Fan <peng.fan@nxp.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Tom Rini <trini@konsulko.com>,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: Re: [PATCH 10/14] power: domain: mtk: Staticize and constify driver
 ops
Message-ID: <agRMe4oSmyp2dJjB@shlinux89>
References: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
 <20260508122247.512862-10-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508122247.512862-10-marek.vasut+renesas@mailbox.org>
X-ClientProxiedBy: MA0PR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::16) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|VI2PR04MB10836:EE_
X-MS-Office365-Filtering-Correlation-Id: dccfd342-9809-428b-ebbc-08deb0d683cf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|52116014|7416014|1800799024|376014|38350700014|56012099003|11063799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8M3QKGVSSvktTedhI72PIX28f39uxox8KpnClTIJOui+IpDCjpK81lomGycJ5L4IlzSkxMNGp6aAZFt6LRl79Wk/1mMjlK9iaC0yZw/PAc/KQTobzmd0Ht9kZTRU5wgyzl39NS5I3meQb13/6wJxlI+wd4iM14TQPcuxZ1ivUxsOU742Coy3illv+pUnAZVcD/hwE/iRbq9qFBtRoceV5JTwtVfozul5j9Q9Kz+ukziqWnNU0qkt2K4lj+rEhKs4UKCS191QMbsRzzK+ZC7Kf+/uPCnYrd552cBtSEFOzurfKHhPlNqatdsqe+aPngLwwqt7d6uULuF+OEcJpZB/OzMB6SxDF6LQ8SfFTaID1KBCDNv4rmRUH1goULH4MG2cCgRhHdqnL7lsrQN0Z4iQlNtWKbz3gfp5mxtg2vySTddu1asFEX5GcZvvEt5MYclHoagzirVA/34y1d35uM9LkwfvydrIur0gCj2W25ZvlfIxBraW1Xpdp8aQhT04zPkfkEIsMblz0TUED3gcaejbSNUI9GGJNhKpAfxygOsjhsVlXkYmXR7pWgc4aCDIQ17pbY6BpPf/kAFZHZi6iEpr/gqWPQl/F9r10DdCJcH0CfCMvHRWkTOLJEv3KaVaL2+wDgsIp3LQWo7g+/fLC/A3/IhUAeptY1ZS0kYWaeAT2r752ijjgTkNlhqMls/LPYxSSCtOqktCLXY20u9Aoi48u9CNP/vAjrUe+1K9qusMahkp1jbgbTEe4J3xnFY7cJWT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(52116014)(7416014)(1800799024)(376014)(38350700014)(56012099003)(11063799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vytqF2kn/G9BqCU3gXFwZ4vKL+KHO3RRVPTMRcvMnyAikfAvl2ojFdSxfRTg?=
 =?us-ascii?Q?CctAkqooRysi+wXzOm3NBjHLx3gyK8iT2PSD9puBdcSP9GirZFQ2BYlVlYeg?=
 =?us-ascii?Q?rhjMTDemteer+obvMfpUTbkOrZSpaaBssrb5ZFbvxEqChXSSI9tsZIP9H0NB?=
 =?us-ascii?Q?uX55sdqr450MjIfB20ZNh9bg9Fr4e3jDMtT3vZSfC5pK7CjXljFe0vYH1dQO?=
 =?us-ascii?Q?6DgNXIpycukLU/UsKrjPUg7oZRkt0qe+eaaRiFVAoK9lQbayHQWAZvcSKusR?=
 =?us-ascii?Q?cuJOghaOq2HGza39pQcyrRNoypgJ7F8yJGETbuPD18MhbbomVpLJ+YyfVNzo?=
 =?us-ascii?Q?4VjJIF9Vu21/boIoNgZ74uiKemB69c+WfOIbWverTPbgjpvEJGjgZf7UmEpx?=
 =?us-ascii?Q?An33yBFnnPgOYjm7pTkNTbp18nLR87iekKgbFRz5IBnYXjHNTvE7lZ0NcuxT?=
 =?us-ascii?Q?+T1hvADxGdMvws9bzOvj98OFFVkuEi/41jny5z1Pcfd06FsbD/PjP/g9uiaG?=
 =?us-ascii?Q?CTk/tV4aIvyHoF/EWPu4t3EeS245QT8kArpVKMhAHnSra+xSAD3KCkZ306eW?=
 =?us-ascii?Q?1Smjm9PUlTmTXklT/uz+nRKtdrgSHkpg3BAjKDAb+4ydTJ/fWDcOfeKx9Sfw?=
 =?us-ascii?Q?EQGLltycs0ne9vqO6Z+pfBSvs/DfvI4JM2FxDPieb9qLIzkLIn7EpwI/tUlo?=
 =?us-ascii?Q?ln6ivQJHw11IdhIB89Te8CJgh8qtKss8SjMMd7JEsjuxs/sSXxwDcslp5Z6C?=
 =?us-ascii?Q?W5MKky7XuJHde5aiS6Xw/2Pe23gh/9af4EhFQ5+bCvnwE1JUcdxlmUJahxw1?=
 =?us-ascii?Q?kbi4/JgQVA9w2cV1yBaitjcIIsST6hGIUKNuTusSmdo5HJXL+3GNzZnWAXFY?=
 =?us-ascii?Q?KyFdejITkXKhDHnSrk2kQTfX3OjT77wvuKDFRT26J6c3H37vtPqwyG9llnFC?=
 =?us-ascii?Q?uJCpEG9n6UQoZOov8BTdW+nVTa+7gAo6a74jeoujbzLJfOg2zNt23TZEUhTC?=
 =?us-ascii?Q?brE45Cg4WTYchV+kSV2PbVQgPJR556CZ5JBQkztupNK2dZ+HDDnPb/idsXYJ?=
 =?us-ascii?Q?O+xeGQPv6tegcVS0cSGUICSakYkJ+8AJG8b9ujC7gB9E1h2kQZC66/oNTK/c?=
 =?us-ascii?Q?qLHA8Gk6o8QXycaJUd26pqDER/DIlhtglppiBon8AZLF8LX2xDIUlXeopwdk?=
 =?us-ascii?Q?5QyN6pfDNNofKCOLb54vj8jnTc2kCVGkPtZCC8RinFs+y3wXU7VRPfxYpOXo?=
 =?us-ascii?Q?G7MzdB4FRKHx+Bv9IHxBTbBx1chsGkb8RCWub0lCCafDQ7igBp28Sp2nVAL8?=
 =?us-ascii?Q?iByAKJOemWDD2z5QVDlyGVDaEec5DDK3foVKqYdbPBdLcLsmarWOmyXCMDQA?=
 =?us-ascii?Q?q1hARfiKiY7qou4C/z39jZqdcmX+xsxNvpOyCWFxucW/YmgtjJBDFDl4KfJX?=
 =?us-ascii?Q?HlJibPiinYqw4yQ+nOrraNdLWGvSl67I5IcQr18Hat5xrsFkPoe+pTCjKdTO?=
 =?us-ascii?Q?d4qV5Ts0LAxQyhgWO7Z1POn7iadglzRXgH6F0N2S0XGiXw5IvVvWPiWVN9Y1?=
 =?us-ascii?Q?66hv9QbWNYi23hapZHc9nFVKvddUUthuDB0WeKy37GAUUekHLB5NMADfkCZ4?=
 =?us-ascii?Q?GmQXBSR76gMFC4vg9TicxF45lSozt2JeZxHsPT08J0bLDkhukk26Am/SDYVB?=
 =?us-ascii?Q?+sOkttlLPieBlVgKmZEoF3TkleQVAld7SLY/Nn6RWiDFGGniwdWGXWII+135?=
 =?us-ascii?Q?B3Q03XGisQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dccfd342-9809-428b-ebbc-08deb0d683cf
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 10:00:51.4880 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CWz+SqZbXUYW3Dn+qfLcuZonWA2gkcuQ0h08Eq0hsLI4pgQYqERmvetSaLOzGDkVx3+evlnCXE2/9JJTyR1jnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10836
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

On Fri, May 08, 2026 at 02:22:10PM +0200, Marek Vasut wrote:
>Set the ops structure as static const. The structure is not accessible
>from outside of this driver and is not going to be modified at runtime.
>
>Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
