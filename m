Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDF4106F2F4
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 08:09:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C83981E18;
	Thu, 26 Mar 2026 09:09:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QNmeb9L1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 352EC838BB; Thu, 26 Mar 2026 09:09:53 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41C0D80517
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 09:09:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBRg96/eQ+zBUn6ZLP6Uid8J3BIunPYCM+22iGXnHmnYpRJ1B/p21q1YK4FDkAga+eOh2vdmU0DwxnbpSLdrwiQzcbFoYcdhNAY4ANY6HOZOUvpCZ82eTTXIyY/on8vO8F0rupqmWXebk56Xs1lALsR5WRr50RGJY/3ezY49aBLRJQjdNssEszMlLfO7tro8ykFBkL0dVBjFIK0R35/AV5BgS/2X8mviPYNfbE8vzJNcbs35Un2bB6hMZXkJL/3sMSs8bAfHh5LI7ak0wHgIR1p1KPV4qurQf+8iauXcIp4VyTsJqCWx2rrQQ434yQTKy0rnQiq7U6gVqKX+PDt9oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUiS+W/TqopBmyjwFTZD7kQkg0rkLf5OjQ5lpHz1Jhw=;
 b=pXTAlKZDEqXDiTA5rdb4+1UqxEFiOq0ErlzxwKop/HcE7hPydUM2RPtI9ewTvVBN2mTpktJ8cWw8dLQ3kNdKeKXse9R7fSzcQjfjCSINEIpjbZnQyJP2vA015uo6FTrb+jfBXMt7aDw3TuX008cgBMguQ+OXyDhNGo+ZEl2/uIr1gZ7s7i1hFR/3N8HDM4fDwPJYkKrlQ8MJmY0wWK4uHxrRw2bN7PUr1rBXI5Np6vpifQycut0oJdd8qXbNfHz24uhND+ep2o7mb59TQ1St0n22b6IArTxZKSHVzn+Vr+zot77pCzyE572El8x9/F8TBsXJFnVkKv3G6sRo/RsB0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUiS+W/TqopBmyjwFTZD7kQkg0rkLf5OjQ5lpHz1Jhw=;
 b=QNmeb9L1AA3fmH0xIc0H8ImHgHcR8JCfG2MbN1Cm/Ll9aqh5ZNMV9WZHhaQm7JSp16Jv57WKhGrWyrl+V8UM8vvxVtyqJlFHOS++kPl6gRlWy1QbDy/mnpYrqKFtL8K/JpA5GPSa/672WOcVHaWhR9uReann359zM2U+lWjLf5TtG3lp1FN7M4BMc8gsET2uLWJjd/u4jRk5Er0aoke5Ji6DFdNnUPh/YshKIYLIdX0D34GAsAt447rPrXMHTSg3i4k9rL3o545BZOLDjZPz1IpDWfYISdUIQbACIdBbPc9KzHKexEwdmE5Ek7v1uEvqI1wCvZI2ATDDxeDgVd0kKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB7106.eurprd04.prod.outlook.com (2603:10a6:208:191::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 08:09:48 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Thu, 26 Mar 2026
 08:09:26 +0000
Date: Thu, 26 Mar 2026 16:12:02 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Fabio Estevam <festevam@nabladev.com>,
 Gaurav Jain <gaurav.jain@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1] crypto: fsl: init caam_jr driver
Message-ID: <acTqUswlElmkADc4@shlinux89>
References: <20260324163036.94787-1-hs@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324163036.94787-1-hs@nabladev.com>
X-ClientProxiedBy: SI2PR01CA0043.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM0PR04MB7106:EE_
X-MS-Office365-Filtering-Correlation-Id: 74395b64-a96f-47e1-b125-08de8b0efe55
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|19092799006|366016|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 8MW0OUGUQG/sN1oKZFVlOwrrRmsycdI6lIKHJiTltryA7qkD14lxaM4XHv2djaUUyn3KWwULVcQqQQ9dUH57dGZF6+AWC+AP7CRMcLJ1dkpz2Z9v2LLWmFVWXnK8zM/z0s9km1t/RqgFhL67zl7yDvFiWStK53sLhA4zb6c711MHjmeDgJvxHOWv6OQ745j/xskp0gLaGkKZSN7KdsJMDvrh2GGWgnlvkzjBOc3nRP+cFHQ3VzH4HN5VzXQeWY1dYI/4wNawlyej3rFpOJRIUmQLRGx5rwLvsXFxmq4QASi5bh9+kpbo5e3aSngdowe1v4+wcGQ9CLiYtUgC80FUC6d0R9AQUdwnIMgmczL4bnuGjpNjHfbXOuzMhAbCi3jO4Jt9qXa2arxyIk7W4jRjrNdd8dnX0yqt3POSIT34R0ypnFieB/avzlNJc4/CyUVQjJFoU1EAicznVLVxHBSHVklHyVcN2cckYjpw4BHXRZeWxWv6DsMnUnDzuaVyeH5Le9Nmy+I8d0yrcZWyoaowjTAESsT5FKjL93Mo/0Z8oVEXrelaSb+xKMGTAHFP8ewu7f1rLPraSt+7QsR4jLm3MpFj2sCTHng4utyYOo+LWwFGb9T94Jva+lReee4SlPW1DjbNxZ2z7tB++AfexiNPULzEOywLrEnm4X4yYyVl7pcvU8OiPobhcDmZ/VZvt4ioL0Di5MGj2q5r/7T91tBpib/I0G3a33dmFHuFZHh/uXFnmNYhIbWamTcpwvVoecjNxsRLB50OQOG7/iamkNCtOP4INdW9GbRp8TIsKvYiVuc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(19092799006)(366016)(38350700014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1RUx9hP1VJpWks5U90ytgnly5Xaw3M/jXsIvTUkzF6jLJM0xDU0We5BZa1p9?=
 =?us-ascii?Q?4a17xEd3JE8kDpln/9JzschwIqsI17m61mtWj6nMl69Z7tDpSnrCTnHr94yR?=
 =?us-ascii?Q?d06ZlujBVz9ZN8tqYoBkIbVDWuuDywIVmrpvPPifUSiiHS3hd7rlYqDqXUl1?=
 =?us-ascii?Q?sGGb04fZXpPrpcorEnB14yJc6jGBhyF+EwMPMPMIBzCnEtH052ROPc+QqrDS?=
 =?us-ascii?Q?QMjMqRkUkqws3cPP+mDh8V/BZZeO3m45c9p+g1T94hA1BbjyLbWfeNXnaHY7?=
 =?us-ascii?Q?EKZ8lupKX7hf4HWu5X2DeFbevIVbnlLjKBKEyV6iTYO26tXS5oYxglKA9/Hs?=
 =?us-ascii?Q?+A+Iav7GbF1d+1VXU6rfK75SJo7RXhj8d06cqwm9danj555omhquAIvOJTYm?=
 =?us-ascii?Q?JQA8PVFoqG9pvBmRQN9OTTnsgYhqQh/DWDUSE+7+tL8E1pRR5DsSiIiaXDKH?=
 =?us-ascii?Q?0JghzaYBZj/XUWQ4wU+sgk7IWj0LbYNCJGASwaCvENx6e4MpN23ze/7tSEJi?=
 =?us-ascii?Q?gyzZ4fjC1iLYMFPHNhEeXhhwsXP9nxdGGJXb/YTYWAJx2S83AFZoHlDEOKgp?=
 =?us-ascii?Q?fRYyrr/7dX7K6saJ6BpCoWpRNhJ7vmoJUU093gTD1Mk1qPISP6cKVyXJM/bx?=
 =?us-ascii?Q?BN5YjfKzlTI2TF8/GbCrUJExMUW5Bhs7Ru6oWjgouEgdKQBpvi+0npfWur6I?=
 =?us-ascii?Q?ywZ+Ta+4aToKpxTn2Tuw9ESWJjw3kyC52bvw0frN+QyU4zPEK/nrL9fpK3R+?=
 =?us-ascii?Q?eWvsCgOgKj9rTY6dYlgFhV8FKfVHfjHBxCKPt3mQnVDJ9uBwiYr/TLZ/PN5S?=
 =?us-ascii?Q?BH83LNTIDkVPUUXtC8adgpG8M5PR534LDJsgarnxGMv9maCZS6/s2aqDO5+C?=
 =?us-ascii?Q?uyznC8QIAvX9ABwywkKnTGHRg/mQ5v0E7gClIppLq7egUFZOf7qEg+lBT3QT?=
 =?us-ascii?Q?dV454L6W//yKiBr5Kkn2H55Gsntsf8SsLewMRx1SfmeTG+uKqGmwyGC41sWq?=
 =?us-ascii?Q?yDYFq/ZYAvPukkqqNMwg789Y/z9miJRO+rRiA7VvOXPlgAPw0R0qQD8E7eFL?=
 =?us-ascii?Q?1JSx4HV6USag+C9poeHfo6PZJAzCV3N0digr/UM3BFHkUEdV/sHWyQGTZGo9?=
 =?us-ascii?Q?eSeVmJWDAkyCMJ0Y0+yv0UerHndd3KkGqIAVsRS6KXCTcLfp0fMZvuCkVdli?=
 =?us-ascii?Q?/twC8nN02cTCcI3MOWDwVRXPfSmRLHDFCrrO0jB1GgtsXjU8IC8A5htMM2za?=
 =?us-ascii?Q?QUg0fiZHSKeHCrGfFXUL9Er7Zxd8leTrXB9yjgM69klw/jPGZjnb5/7u+aSU?=
 =?us-ascii?Q?vARw8PVF+ag5wtY4EMYc+iJ9aOvWcrs/a6kz2q/rODJ9UbFgcUoBiEhgiFP8?=
 =?us-ascii?Q?gRMW3Xd9JL0KE4Fb4xciLz3WVmwgnc+HLUjn5N8n0zSLwATWpT5dUd/25Hbq?=
 =?us-ascii?Q?sPpw+6uqBxpNeu14I8ZHX4ic2UoT6yooeLPapZ8W37zXsKB09VfT09TrH366?=
 =?us-ascii?Q?9psew+wXNOTb2YrldnFmFQ59qU4qEeMwBPOcC4wwBigk5iAuXZjI0cdVPTHI?=
 =?us-ascii?Q?bbVMyWUgFyciBnsn5v1SD73Vgo692d/DNDzsTqhZuDb2GJjflnYT1RZK9E4y?=
 =?us-ascii?Q?C5iAn/egC9t50YsHOCPUXk+sEhp4XvnMht/1TX34kT9jLhOsWVKgnRsKqPPo?=
 =?us-ascii?Q?vCc9y2qGeG8WcQ22E40ym7Iz2rnZCZX6pJubjCFCfyDfizts45GX0cNhZxJN?=
 =?us-ascii?Q?8xZ0CGemOA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74395b64-a96f-47e1-b125-08de8b0efe55
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 08:09:26.3508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dw4ynM9HchBZl5nsRoQ4CrRGMsfzwYmI3U8JO6TM9Fk2ekhD3l5xdXCPRHgRgRJd8S33rQx2F/VSw3zwFeWM8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7106
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

On Tue, Mar 24, 2026 at 05:30:36PM +0100, Heiko Schocher wrote:
>select ARCH_MISC_INIT Kconfig symbol when enabling
>freescales crypto driver support, as the init of
>the caam_jr driver is done in arch_misc_init and
>not enabling ARCH_MISC_INIT leads in crashes, hangs
>for example in hash calculations, as caam-jr driver
>is not initialized.
>
>Signed-off-by: Heiko Schocher <hs@nabladev.com>
>Suggested-by: Fabio Estevam <festevam@nabladev.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
