Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E707CCCD19A
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 08:31:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F119983D7A;
	Tue, 18 Nov 2025 09:30:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Pq/1/cAO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24F5183B99; Tue, 18 Nov 2025 06:09:44 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E7FF83B8B
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 06:09:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NNZevIBbPsomElmCwbgDUMjF3KSvbHo6n9xmNUQc05bJPpJJvCwh2S7BoQ0d6sTZGYPBYo+Ks53iotjSCeT4urN3luweE7GVedA34hJV0hjwIQjRD1EOvc5siyVMXn94XQkjOpycvOZLbDilah59AOjBOaorLJxY1HSbnJgEP5jVtkVkrUug4C4FLJRueuEexfUa4QZEhJMGxuff3rxGiJCEuN0HOmQS0dgcxmjFc8vJQGLC0Trd/Uslm0W8uDOHnPNBHDcsltprODbHzNImBicRVW+JuQmkJsNOftAuHcI1DNZ0xtev0dKjRkZnoRNywARTUQSviuq8WbPWbo873w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oIAUU9+u1xEXr1dDONF8KWMLsv/x+HXx/tYAFF9Y+4=;
 b=qHfEqpo0E8M7AOubmtj+oD7EZkw5diM9SxNNPsptJPwTMYKUjdlNHTh2SJRIJKTlddi92PpW86fgcIq81XMexx5App8D6PM3LgF9f+IxuQTE3+hBsIM+xSAAukMj/PXK2K9OvvwEtAhnbYHtonJ9F8XE+K9Rg6M6iHDo+/NUDDNi3Z3LuTh431qGArkyamdMYg1G5gCHO4IlOdthdazbE6ecE3G9StbqyT4b3aSD1FfLZRxem5NEPhAlLm5lwv1ClNT/k+8SDwTVRtPAUUhZg/QOlk5FoLxNHL2OCYCnttzAQoY5fIs4C4cOBd0gnsWM3dSbiAM+8xr+hO3dfMlm5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oIAUU9+u1xEXr1dDONF8KWMLsv/x+HXx/tYAFF9Y+4=;
 b=Pq/1/cAOXQUabVfyiajt8hSOrihgAq1srOxx0SO2GQFb5CluTNoiO4Y8tokczd7T7X3ritXNOgFY9tpQuRyEnefUepbMvKM03z8x6Mp1S6RZtPXPqE1FR0IIcqZU65HvbZTjk7PeaJ+Um7oDaGR8bYNuKsvGAy744za9T+y2AxcD16DDGeTBr+ZVNEjUbTUQbECTELbMxpJ7DRBFfAqp3l4dmWbTRDGH3OZlmIFaMHaP1DG5rWxJjjMlQeUQhsdDPPN5WELfOygfZbAvvjuXEf8OOfrDstqpYWyZoMzGcRESd2I8dOruC/4XjTZo+LjOcxCazsJCeZGIrqpjGUa17w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB11722.eurprd04.prod.outlook.com (2603:10a6:800:2ed::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 05:09:40 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9320.013; Tue, 18 Nov 2025
 05:09:40 +0000
Date: Tue, 18 Nov 2025 14:22:32 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, jh80.chung@samsung.com,
 trini@konsulko.com, marex@denx.de, tien.fong.chee@altera.com,
 balsundar.ponnusamy@altera.com
Subject: Re: [PATCH 7/8] mmc: sdhci-cadence6: socfpga: Fix DT property naming
 convention
Message-ID: <aRwQqNaCcn6f9-Cg@nxa18884-linux>
References: <20251110173737.24545-1-tanmay.kathpalia@altera.com>
 <20251110173737.24545-8-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110173737.24545-8-tanmay.kathpalia@altera.com>
X-ClientProxiedBy: SI2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:4:186::21) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB11722:EE_
X-MS-Office365-Filtering-Correlation-Id: a646dc99-e60d-4c9c-64ec-08de2660ad4c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pCTNQP1B8JmK4rqh9Ffr/aMBAra9ZiG9pKy5Hj4kMThsJ3UYmkJ/EFEJoKsY?=
 =?us-ascii?Q?0kdvkAQFzta6XGuLPJ4xac3ZfSUZrjB7RxHxhs5L9A2/NWEvXjleHbmyIsXH?=
 =?us-ascii?Q?GYd9Uv0YEyWj7aN0W2RW7z5UQhr0II+LheU5xWRpTanVTtfrV5ufUN7qHm9o?=
 =?us-ascii?Q?woxo1rTnwvWx1nKnKXIMHspyhWMBzkErcU7WG1v8giDIXai8rgUtyvsXhMW1?=
 =?us-ascii?Q?Fd6sAqVDrGd1MbzR69MBKJ99JGS6cIGI56Uc+zGC6b980AIVa+YPVRxh5Ls2?=
 =?us-ascii?Q?abzZ7IfusFtghk5w2wWeJdusauBdoCQH/FwtFXrjzFe03CduWW7k9508Ev7F?=
 =?us-ascii?Q?oTIvR4+IrQoZM8Cxxhu39TTtZg5t/3T/yQfJKEdGPRYYZD8R9+c+ZURb3/0/?=
 =?us-ascii?Q?2aZEbQ8hoUk3E8ZvNLDq/JAqvTjp+VBqPPP5XFkc6pKaK8AS4y+nB8IV+7rF?=
 =?us-ascii?Q?8qGkcy5HmfeKej2+Poo2NWRcI0HkN3WPcr+AKKDDSUpznhumzHiTevplf3FE?=
 =?us-ascii?Q?J89fhEi+wqbULfb9ztA82acrWF4j9RF7VGpn3uPp7kyZr96OGo4yU1owUsGA?=
 =?us-ascii?Q?1CTQsd+dlXYbpboTFBI/3ZdRPdGLnpzkDmM+HiYgDHC3smq1by5cAvJNhI6a?=
 =?us-ascii?Q?BTpb59zCpqdH3A7B5Zx3M67M29qu3AMoJ0XYNAr84xVhZFN2fqUSViTmlQ2J?=
 =?us-ascii?Q?PYrvZxG/ChESvnt+Dm5RzTrRdSvwG+nNLjwI6Im+OySMzB6KoiYd7xuNf4U/?=
 =?us-ascii?Q?tqefnhrQoQwWjWRWiuGxJsdFDYFtBMIz7TwdOeAaIDS6gskbh8g34H4ekYxg?=
 =?us-ascii?Q?HGGSJ2o2L0C7MGg4Hz9qZa7mTkrbd+u5B3sh1XhqNqf+mdSMLRPcIBqd6lQ/?=
 =?us-ascii?Q?lQpIlxHXmYviOmaO2D0WM17o5eQQ58XHQWxTKniqJqQPuAF6V8ut5lWlz08K?=
 =?us-ascii?Q?7NxuUGb3OYYTJ4K4bZ4xQXBaDlHltabJHXXLOZj4crDXLiuV3KbbF6YGXXn7?=
 =?us-ascii?Q?UtgV5bdl9Dk+vhcw2P5lnyJiFfvaANJHC7hqF3KzicWmTgKpQHZQSWv6Yr9/?=
 =?us-ascii?Q?5vLpYa6wXqzkt3J2AkDB9K7RNxwTxzcY2ZvXT/pMWN8dZfV40sDT9BpYj0S/?=
 =?us-ascii?Q?9RcIoqn21X04VsVZNcrEKVoS1gDGa+XUdosTzVltMrz1QQaGUQ61xHuHIB/F?=
 =?us-ascii?Q?kcOvWtXZOKi/n6h3nUn02QADB19WzWGavohVnPc63grxjqOYb3KbtjX/aMgj?=
 =?us-ascii?Q?l7AFStZkO7tjL/s8Z9hhnpNlHIDHZaOE9xva4f4A86yoT45u5mRDuSvwmh6R?=
 =?us-ascii?Q?4epAwxhY5BVDrLkgDTSYIEj3F9lhNsxuVpvTx/2Y1hj3Phvz9gCrGsrNcOUH?=
 =?us-ascii?Q?UxEeHnZmZj8ScSmOqNVCVA2cSno+sG2sMqyNLc0JFEiuzXrkK45mNvBq7oUk?=
 =?us-ascii?Q?5sSpvgcmMVnzS0/oPf9hfeKOypWvB1ywnPz9P9SYRm1/Xnu8hJRdXS/1BG0p?=
 =?us-ascii?Q?oogNLR46E+A3Okxr6o5UEb42b6Qa0HKjXVC1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nnIy5jXNkwMdbRWxmhxni7XvwY1rp8/w+mxJuZIZSA+FEitalVRKwVWjc3qo?=
 =?us-ascii?Q?D9DrSomtG/sZejynZspXNl/t3d1mKFVP6hQHNOzVT38pTOohGo+zctf5INyT?=
 =?us-ascii?Q?329jqgM6JL256IumL5Y+Mds7rPbm73h4RZyy+TiEMD3O52qrSCsKRXUn4+l3?=
 =?us-ascii?Q?JYNNINSWEPkey/c0DzeBd4RRNbjCJ1mkFd26A0efP/mQHzDQRat6vSljeaCT?=
 =?us-ascii?Q?jjAKYc/L60AN+13zE9JWU6G/2iaWGpNSf0zCJPnmqawRQzG7PM5A1mEOuzL2?=
 =?us-ascii?Q?pAYFYZ1u1NaddpC2W/MStkQx+SckTBI9rYRsnfuHnW0wkFPRAZn02W2OHJ65?=
 =?us-ascii?Q?2j+cmZJ96JXfucL0WuImm8kE+K0lI8W2F/5gVcwb7//WKJ3W/yWx+JtU65hS?=
 =?us-ascii?Q?u5lIe8AtGuWvXpVow9Lfi3mGLLnZeQtwmj1dUF8olmtoIEylgc0MTnVUV+b7?=
 =?us-ascii?Q?g3sdeC74TP8n6X0jpgZ2Ry/2D0S9/g6IMiDZIEUlVs1gTrURcoHK38f3jUKM?=
 =?us-ascii?Q?aUff4OMIOncRlO2aJxsZcqij5eHH8ll23WzWca7Tm6XSdh1tehoITUrmhUQD?=
 =?us-ascii?Q?4JB+Vk5PN6Bsne4DjspkQoAlZrE1NJ6wfBG7Xpmian7S2n0Q3sUkhk5eDuA8?=
 =?us-ascii?Q?Z32oV5d9vxs14qtMVuAvjJ0Y1feOhGpx5kLMTeLcCKxc5WVigcPTwFdWxkeZ?=
 =?us-ascii?Q?FIgde/Mwv9S1Oio5zdSB45i9Ok6i+WFBCRjXNkeO1z33C9uFTnCBJDb2Go5S?=
 =?us-ascii?Q?IUHTEy0aFGWtGW5Nn9jwknXWUgiK6y2gEJ+htFEKbvszb4OTN8nGLZvR74yj?=
 =?us-ascii?Q?R2+l+K2M0uxp41GbLYcZxrGfUn8jhtEkw58I4NagmmvzFoGqNBQwyMgxo+lh?=
 =?us-ascii?Q?5jkKpeGHVlPaDCIG3fY5z0vYZqYKAmlItkAMw3kVqLCj8EvBVX1l34vOhLU7?=
 =?us-ascii?Q?5QqPxmfdPLZt6rs1iFLyWsosCsG1wMxc9awj/JOLcYk0z0NYWtmzTO8orGyr?=
 =?us-ascii?Q?82PUb3+Vp8Rkga6WIqScxzphgaZtiKiJVCSzb/VV/FaUBFZNLr6VYLvAgjMb?=
 =?us-ascii?Q?IxIlY374RCrBhwTzD7JfYtxZx2oTWgm527DRACPsbU3NvJjXJ1Ku2yzvyQHy?=
 =?us-ascii?Q?jeJRqqyLp1F+QTl3svsDGG6++FGQ58oI2kIUJIM9K2CxtLrBHuMNpSAbKzfk?=
 =?us-ascii?Q?VyyMivE6qpzK1cq4jh03gpAmmQ9rHuifRytMYEIm+qDIF41njF3n99D16/fb?=
 =?us-ascii?Q?RqH0N739pdLnnv1prc/XRoP+pDzgQxXPv7Nk2uBMyyL6ZIF8aoRQ5VramMSV?=
 =?us-ascii?Q?a8emOgLJSA0n76SmzuoutIdr3+kff2nbilNlDwrm6rgjCBwtnXrB6C+5JjnY?=
 =?us-ascii?Q?MZmlND7hhqw8BDaSp1b4Z72U+d0ka3B89S0NVWnOYfO2Q25SBB6i59oS0ez9?=
 =?us-ascii?Q?DLkxpe5sJ/5/k7urJH5xWe07iWAXhtXzInIOTjg0VmlnIRsNnk7OClnWD9qh?=
 =?us-ascii?Q?U9Za3BkOJt9DQGrGEvcBKNTayetL5C8y4ImmL3z3FzOEmIqlz6jclo/6/iOY?=
 =?us-ascii?Q?OkAh26tCV+YzVtOpVjc51Lt8eLBIlTL274aOd+D2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a646dc99-e60d-4c9c-64ec-08de2660ad4c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 05:09:40.1526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YJHTssN5fuv0I+YHHb2EiuM6EUN7KTvMPdTAbMKnuiLY42QZsIlXngmnqGs9gU6ZJB6pqFICnI2SKv7r7ZUHMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11722
X-Mailman-Approved-At: Tue, 18 Nov 2025 09:30:32 +0100
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

On Mon, Nov 10, 2025 at 09:37:36AM -0800, Tanmay Kathpalia wrote:
>1. Replace underscores with hyphens in device tree property names to
>follow the standard DT naming convention. This affects all
>"lpbk_ctrl" properties which are now correctly named "lpbk-ctrl".

Are these properties in Linux Upstream tree?

I not see users in arch/arm/dts and dts/upstream for the properties.

Regards
Peng
