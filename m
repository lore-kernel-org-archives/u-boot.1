Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAEEC43458
	for <u-boot@archiver.kernel.org>; Sat, 11 Jul 2026 14:46:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D672D8497A;
	Sat, 11 Jul 2026 16:46:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="P5hGgTjz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B0AF8498B; Sat, 11 Jul 2026 16:46:54 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86129847AF
 for <u-boot@lists.denx.de>; Sat, 11 Jul 2026 16:46:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MxvijwxtteTkw1Ob3RG2gQRkWOWAL/pJusArHdnUvu3AbC7NLNzIMlSG9yj5ucH7Ljv43SXrHSzipjZdBlkY/QYHYnqApX7zQG7gJjYGdJW7oIu9sCeeX7EIBf4Q/x9tWV2TcttBuUlnvZOlo2ugkbTINoafUSPoAnIQeiWByUSlsN4vbXSQb/44yW2tu2GliM+VmnsxM/b4mX1T5nwmBP3qYRtFfyN4SR/V/SutCOOteVD6d6lAKXCo8Ia5/MZ46ZWxDsEavMNZyIeFhdfLeBSGwzZqFQuXm7T+cpkaI2BmaA8EYU9EsdtRsVLvDXK2LVUKrqx1W98KZw4P0WXJqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWObezM6YTAhQfW9u0wuQudFNAeQrqdSSr0Ppxd/Txk=;
 b=rQWzWYNz8//Jnv2OHU+mS1TfbU6sI4gyUtx9zaveKCWLxoRpfs7qRFcVkUFpPJJutU9m/aJlVq4xwJGEzwtT41ZclTZ++R3ci/NNLFoI7Gv9TB2m9UzKl4P7itjvQF5v9Vjk+2MdroBpZm9XBNvahPK14QMl2tomQiVlYLqD3oOSRfra9n7Q2QtiM/1938lrJ43mj/lami7aybkJaB7zB7QvB2gtibVK3BdN6AgY/A9Xv6fCi/OjsK/sSKwkwyIf2w2o7ra2Sji2f/hDUOlGlGWmVIT9sQ72fkcGM1oV78suhTfgxNzLGf/MutzB5Jpa41oO4tWr4cwDmddYOkZVtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWObezM6YTAhQfW9u0wuQudFNAeQrqdSSr0Ppxd/Txk=;
 b=P5hGgTjzD3x/9FRI+HuxpyfQRZp6jONtX/oXDvtRr9PoJHOqT8f0G4qL/pZ40IAJuhRJ6IY18wI5WYHRpgKpWA6VCISh9wZJHYrbYboEHhzCbWa37kP/XWrM19LwHpseJwXvtl0Wdy3CqzP5OWM6+nNEMehhtMipaPERlWUtOqp9Lau3uO5hBaR2NmGbM14UizmE4ZjI0J5VvXkxN4Doh6xkb72c7RRWiPHy9xV+Gc6uI/SfVgko2iUBlKakiWp8P/cXek+fCwCXVR8T3/lnvJJw9XFCpmccJxPgCgZeCANHKe1e6SVacgVHMC7I1xZ1/lAXPjYVeGKs/xyWQaLmUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by VI0PR04MB11545.eurprd04.prod.outlook.com (2603:10a6:800:2fd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Sat, 11 Jul
 2026 14:46:48 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0181.012; Sat, 11 Jul 2026
 14:46:48 +0000
Date: Sat, 11 Jul 2026 22:45:22 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marex@nabladev.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 dl-uboot-imx <uboot-imx@nxp.com>, Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Fabio Estevam <festevam@gmail.com>, Wang Jie <dave.wang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Casey Connolly <casey.connolly@linaro.org>, Ye Li <ye.li@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Alice Guo <alice.guo@nxp.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH v2 00/10] usb: Add TCPCI driver and DWC3 OTG dual-role
 support
Message-ID: <alJXAqtEOFb9ia3m@nxa18884-linux-1.ap.freescale.net>
References: <20260621-tcpci-dwc3-v2-0-990ecacc111c@nxp.com>
 <akMgh8AbN6BX9UlS@shlinux89>
 <a6dec76b-ed70-49a0-b7bf-affe1aa2f6e7@nabladev.com>
 <MRWPR04MB123305BC4FB40B7B6D083AED788F72@MRWPR04MB12330.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MRWPR04MB123305BC4FB40B7B6D083AED788F72@MRWPR04MB12330.eurprd04.prod.outlook.com>
X-ClientProxiedBy: SI3PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::16) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|VI0PR04MB11545:EE_
X-MS-Office365-Filtering-Correlation-Id: 4188a8d9-c029-4294-b8e3-08dedf5b3c4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|366016|19092799006|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 21t28qFoT22VX1/GP2T/pPuZ9AKQ0roOq25+EkfHeRbL1oAlFsqDUF+r9oogsuj+Fbv11chi05vdMf3AmoJGauZDu80j29XJJB40ClzBg2OhiltXyQfn40nlMhkKm+r30X6+wgD5WCTHuP5PN00e4GDUbgQrlCr/4RfpmfxmWKQgcshgsvAmX19+aihzSp7DNUkMWvoYlwexaD8RGp8JXdRsH8E1BLvRsRdrDDRmRtftiNrxqHhWz2Z3qFaQQXtq8rRgyDJxDQBjp/qnpqphIfw1IFpV00DlSLcKVOUUDxmiMZ0PQyzMItzJHp2/mF3Y0z/2mxKpsJzXaoM3JpGtBwAnPb1YJKJyEVdhNyk5nxptPfSASmlr51UhfgtY9WpbSiOCZorhQArtJQfzxAgirPfMV8zX74RnBekquUiVLQt2S4wybcCDIJfaE9J2QTMtICxonufcd/uFc6nKjsZSBL00JmB5KGZ/mHA654pYU1CYrsH63qSg9S5xohrPoQ+r92QdOGiac9TkQvZ53wfy1smPckBHhP7gKE8RXKYIdPrrUGZYLvR1fzShsVnOxANA53aQSu4ZJLIBbaRkJna9iKqIGZ7Af2mcKS+F7RcQp/JO3jyXliehAu3hhPvADAkXAP4tTo2PW95Xl6wtbwt2kdwq/cvwAnbb+dkcxCSykeg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(19092799006)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cr2jaCf3Cpr4APTUdYj/Xks6UBylkuk9s5odLw7uZeKZeOBX0MB7OEziAtTq?=
 =?us-ascii?Q?Tskpaw7bekJZeAltRwooPdVzCcvdRs+bWGvxZuTsPk2yNKYYDp8lx3Q4ehDS?=
 =?us-ascii?Q?KbwThdMH0ZrNJlgEjTNXkG0ub+tk+Mt75qLIvWkWsP5l4ycUT8MYhIutgPJU?=
 =?us-ascii?Q?XCN7NIMvHrV3z5c36qVI98IU5KddmzTF3S6Wui8EnpZxOLa0VEKNfWe0LSxk?=
 =?us-ascii?Q?tP+hlRql9A4V+2DjLzGk0diFwK2uwhzQbO+hfthyd3ItZ9oivTDVYn9Zljs+?=
 =?us-ascii?Q?lycGDPSvaOgBteQkbK9QiEzDR3D8jOVX5dpniDGAhZZ550+EemONpkpL9QTx?=
 =?us-ascii?Q?Q8evYNrFb2WcuJYMK7nDTzsJhVy7Ar1cK8JXEPjuEY2g52WACqJIGkUcLmN1?=
 =?us-ascii?Q?OxsSBwsoXIl5cuHlAQC0uKV7ovhHBekCefUmnOUHwAJhK/uR7HzN1+GXY92t?=
 =?us-ascii?Q?jiZ4O6h4xRJNIlQYokzWSbjjRLAlMgQPzixkg124uL8U1Rfpv54kV828WuSa?=
 =?us-ascii?Q?9ZOaAshucSNEooVn1pvUE9uiWJB+7gpkYHQzgK1i2Pkl71GK6PnzCfaTHxV1?=
 =?us-ascii?Q?vuRk6iixTZi1zXkWua/HMILXOg6eI0p6KBAodVtONncpgpT4xjvhJ/08XNe8?=
 =?us-ascii?Q?rBVfqXEpfbQ0eGoOF7Ik20QRS5H+w3RWHrMSzSe4P5yvPw+kXG3bg19gOEck?=
 =?us-ascii?Q?Qp4QsP8ZSqHw+LNMKJoyH9E04vhCE8PE0TYYSxx6jPaxCkZsS0Aaf0VzvNXr?=
 =?us-ascii?Q?D7Vu86Tl1JrSG3hlhOY4ExAj6kbVZJFOEWaoK6SRghAqXK26tPUR5cczLfbl?=
 =?us-ascii?Q?8KMsevt3jA3oEzNVGCOmiUXYQECaLLzbcUizFQnrwN+BPo6zxDjqP6GchvOt?=
 =?us-ascii?Q?BqJDkv+fD8NJs/gOoM537zYdDbj58SjZugt55pIm80UFNtH3l/olzOMOhWoY?=
 =?us-ascii?Q?058+kUYCLVP+5wPrfVQryF2g0XqKKzRHpInr9vVKFauheGvFOWxMi57tQj45?=
 =?us-ascii?Q?IbC+d6abN+yihyVXsMncYd+GlZLTRKrBx11/oD0yT1O7OqCwf/YdJtf7Cqg6?=
 =?us-ascii?Q?7IYXtcQEWIHrYtyi1nk/oR5aezGAAQKjrFB4vdWyr0dnD/FBgWk5kjvqeTd+?=
 =?us-ascii?Q?wJqbkmTj4UVfi7uSRi1NG+VC52Kso356c1JrS/fXYbBlzqagRZRzAIOVoxIM?=
 =?us-ascii?Q?isGDpIGd/E9f52UU9Xlfd5Hl+yUNYBwuV7FOqBSq4gAcWQJ5qYx2JKMrHo0O?=
 =?us-ascii?Q?3B2rCmqTEuSBUtJtN8LTjSJQe2woA4CLoE5hiLg1FZI1M/h90xiOQHSMLnQ4?=
 =?us-ascii?Q?lhAW2EmYcrL8xAUK+OS7P2u5W1RsjYene0GkHdUfTUZT4NS9dsfCw5si3HZO?=
 =?us-ascii?Q?OBYqef/rV4H9P0XiXY/DpinRmO1+0YuxM7PljCkmHfD1KeL4uoBed1tq0Oku?=
 =?us-ascii?Q?+c7nV+vpRSi/RP+noeFAjXfN3z4ABYM5Kl5ZCDxtho/gvtT+bSMLdqgc3xxB?=
 =?us-ascii?Q?rpG3Th840tJqGxAGOIOTvGm4B0uoH11cjHN1c8oZh0FmxEmdU5Zifu1PoQTG?=
 =?us-ascii?Q?oPJUpyglEEe1QblDnMaClf+U7KjdDCm0QOiJz9dJDoVd9Gj0iYSkZnBSl+nN?=
 =?us-ascii?Q?3W04Ee3KqnaiMehDiHLMfzSKURaLw4+XYdlIJOjJE+6JL7lZveW/yDJ2zmUN?=
 =?us-ascii?Q?5SdnUZuU4Ym0SwC4fN/yf6SHEVhzAJKe5mJJrUaXWbhey4Ow5pYhr9ms8UTn?=
 =?us-ascii?Q?0gn3kDihjF/jfUCuP43eEApgLAYjFJCnBtmmXmzyje1QyZsV9SwN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4188a8d9-c029-4294-b8e3-08dedf5b3c4a
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2026 14:46:48.1528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hdqUsWCbZ0spo7hcoHb1WmWTVSSrjHrZT/GfQesAVJ++rI9Rmn3upoLA1RvbwBuO4HFnBATTLbU3vsmxX3gLQyLiklg7Gpny98WS5kXkLhsWi8IpD2+90KtqDq5Lhcpd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11545
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

Hi Marek,

On Tue, Jun 30, 2026 at 08:16:46AM +0000, Peng Fan (OSS) wrote:
>> Subject: Re: [PATCH v2 00/10] usb: Add TCPCI driver and DWC3 OTG
>> dual-role support
>> 
>> On 6/30/26 3:48 AM, Peng Fan wrote:
>> 
>> Hello Peng,
>> 
>> > Do you have time to give a look at this series?
>> 
>> No, sorry, I am recently entirely overwhelmed by emails and my
>> backlog only grows. Did Sebastian/Jonas provide any feedback on the
>> TCPM part?
>
>Not yet. I have other parts depending on this patch set, so hope there
>are any feedbacks and we could move forward.

Since merge window is open, and there haven't been any review comments
for some time, would it be possible to merge this series? If any issues
are found later, I will address them promptly through follow-up fixes.

Do you have any concerns with merging this series?

Thanks,
Peng

>
>Thanks
>Peng
>
