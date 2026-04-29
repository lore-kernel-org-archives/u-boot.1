Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC6DFF885A
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 02:27:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C3D0846CB;
	Wed, 29 Apr 2026 04:27:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ru8HYFPr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CEF1846D2; Wed, 29 Apr 2026 04:27:46 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B66BD846CA
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 04:27:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pgVcanDSh7yFOYSI76KGLJv1mkIPivWREA+pBvzZA6oBTVAiXSoHJxBJyQ3L+d8vB0ChHlYnh3Khq2bzXMfL562ssNXTUYhSkAI4TGwkJgI0QT86ggAoxq6zmGAh86RcaL0R+kEO524MbjzQ9p0YgrnhOgKiBIKUJTTm4DhWFKjxfeF/hmEH7ggxErwgonSajlmx3sARPUQA+Xm3PN78Jhdw61XwJvSkx4tXbUZNebGtcvO/5VwWNp9NFknHoqGW6c7qUWTubXpH06lUBJ12mdRCfJ9vzv/GsRT4cC417lSEHeH0pjKE4SSxnxiHZVyJ5faLUgBsGipPT2/kgwL1Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HssDf3RaJS4OG0+bSNSot94YXJKKOPoKGe2VB2Z2Mt4=;
 b=W2UawY4HD+R3NrpEHg0NJExhHoGDdxYExEd3z4g/L+c+3sGB8dB9Xdfb/VpdmGrNamqxf6YtYuh7Yxp1R0FwW4Q6uR94sCyhUpJJKtdvK9QpiaK1UHJ8jSNkB7/AWDgyFgYBWeabdLmXX1dXTVSp5q3TdEkBOnaRqpelWpWYVyXgKHSigG0e+A7Hyme1RW6nqnt6B0DqXYSU1lOUZzixPSeLuNPKgvrN7ZU4BHICGMwRGBiT4djPe6Fm8x0Ns42x0Y5NCfD9d78uLJVv4DNMmLyomHdaPac4g7o5S70uLdPkZF+3FW9rmjRmkz5RxGuOK4rhGAPRvkIeGwLUBW01nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HssDf3RaJS4OG0+bSNSot94YXJKKOPoKGe2VB2Z2Mt4=;
 b=ru8HYFPrnmhhzXH6XjDkaBGGihqNb5Vp7kqW8nSw94DbW3NQWXVjmNWjhNoHg6GJ0wGwjgAgexxgjiM0wj8+o9866yWu+HnlYJ1LkSYbspEKY5+56TjRpJ+c/1wyV5zZXITwyJ+3OAgUTNkm9oUWBEAtw1Zxjqw3TzLZ6ouEplKgb8r6kGoQISr+Z8ZQyBSykSucW1qCamFF2g2iyIcXiDP8Y6nizo3gfM5KRqSFjnb/EmQ50mxwyJ1a6kArZnKEa7BRDmj2Cffr0r97IeYftAuF0dOWJ3M/rrKDFffOJxRHWkMD2MTj2UlE9MIJ5BF4rqzh9luzDzm5CemAAEwbyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB10076.eurprd04.prod.outlook.com (2603:10a6:800:1e0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Wed, 29 Apr
 2026 02:27:42 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%4]) with mapi id 15.20.9846.025; Wed, 29 Apr 2026
 02:27:42 +0000
Date: Wed, 29 Apr 2026 10:30:22 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Ye Li <ye.li@nxp.com>
Cc: radu-nicolae.pirea@oss.nxp.com, u-boot@lists.denx.de, peng.fan@nxp.com,
 uboot-imx@nxp.com
Subject: Re: [PATCH] net: phy: nxp-c45-tja11xx: Fix incorrect usage of
 devm_kzalloc
Message-ID: <afFtPvydwmsKEEnx@shlinux89>
References: <20260428083733.1803100-1-ye.li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428083733.1803100-1-ye.li@nxp.com>
X-ClientProxiedBy: MA0PR01CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB10076:EE_
X-MS-Office365-Filtering-Correlation-Id: 65dabbe9-4d1f-498e-b30c-08dea596e3e6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|19092799006|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: QCo0WUV5h36G1zukGxPCKQWWTsQtGKB3jSjkPm3GzWSatY+FnAMCxgMyVmP7kciuLLxJR+2lYZOdn7mF3vDvROn7TBTqrfH+YEhJmCj1Gmghu8hJEc+4QxdPN3xfGYJSE9YOj0vWCwbr4WIeQeqZWFs+erF6LMemD4R0JzpY+/5JiVxQM/F0tE1rt3wNbYHbn7XpziftQQEHqRlTyklXKw+1m3p8Qr/BBLF2W+zjtDpwjD+3d7sdXXnjzpgDX+nsTVwOYwOSh1W/3E3nL6/pR51z3V9F7K5yCymjssWwmFHgiYCVmpiz3YhKb5f9tegZIK/+uSQZxX50CzWT+B0bAeqq8tHx+3CfWejGTcGwJp+ATv8WBFPg9VkYscRzGDkkCR6MU87zE0F4JZlUEM+SxneCBqx7FsVMWLjLeDBmpDDPH58Or1z52uNO8qQrwyiOa5jigikZquYdtPXYjfXkvZ9GH1oqz7BQQ8bIjLT77vG36eny+zWaSK5Prtc1bcBwoI3a0LDtVDssPLPAF/Zfhnu9CmnJnXnL3eIYfsqAaK4sn+o57SGSwksNzQ3uq9J+xSEuMwWRPTBvIQ87eB72hOl9RuzUDVOuoKhJE9KUCEpsD3LlLGccEmAZSB6j64ywZ5CMCbAu6SYX6mmY7oMmu1MHmvLtaK1eS0ivItVnZnxnDOmhIT2sbqUHC1DfgYPnd50rrDzhIe9PjPOpnqbpLbCuSYsCD4t/F0cKK4C7Pdgxkocaf6J2DxQvq656stbM0Dcajk18+IuPCzBl5hUVyI5JskOQIbZETinxnK3XFIE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(19092799006)(56012099003)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KcfU+BPhXoo58po3Rn7qUFYQ1eAUi7OhrMaYWWHi/MJhEnLhWw0eBTAhjobq?=
 =?us-ascii?Q?V6+5tkywSi77tlhcnX/s5FpFd5R+CKJZwMLnGUhkkMQHi3OiVAN+w6FlFqR5?=
 =?us-ascii?Q?DRiV4jEfBWdCf/RTS4CnFa/obgQPafIDJEOWyOLIxb/yncds63+ahez/lyOl?=
 =?us-ascii?Q?5IHoY2iC6cg+4gY70dcLg+s2nfw04cm0vZdLa2anTpiM+b7bNq7iOqfAHIVM?=
 =?us-ascii?Q?icHyppUx0uXy+ODW0jyyA7WrRFDQSEzG2QMzhkslpKLMVn1doK1Os0FYyXeV?=
 =?us-ascii?Q?JNiBvlz7AOG72UZe0jZS77nV7xaUetrhbUpkBxGN4sqh/fWMVdBfg0ALrWVg?=
 =?us-ascii?Q?SxFSc83pfUVKlmyUZIT1gbfZIf8Kao+WgelbdVeYZZZR4urKIFf/Zn8tRcL/?=
 =?us-ascii?Q?9IJyPj9bbfJszL5L53W7wtaWF5iXZPDZvgtH4xO4aB6v3z3e6cgI4zIZ/V2G?=
 =?us-ascii?Q?kBPenKMr2X0Wf2yLrDpfbnAbi8sVqsN5Td8zmbKA8M5Ci1AbpzKQQ090THlS?=
 =?us-ascii?Q?TwtbyrmFtS4oSVSadE7KyjjBneSTei7kXn5QJ+zEEBL2+p4BVyDcrFX+B33/?=
 =?us-ascii?Q?3ryG95u7Mg3rUEPJS1JYZhIdUFIYdt0vTpHGSgHaSXD4+SD7R3mUM1R0ylCh?=
 =?us-ascii?Q?i5Zx1Kw6yIEku1ulhwTV3o07eHLbQEJUMWWgZ4n2rC2RaSzE3/SDEnmLWH68?=
 =?us-ascii?Q?0zwuIZudbaUMhEEtE6egl/mW9w/TVb0PbNSQg1cmJrYZMI8KRK7x4qQMdxsd?=
 =?us-ascii?Q?o6RrsH+CCdoHB4+yynjluPozecdDKCp2LyShbrUKhm8ywYEC6yCXZmmQXTuh?=
 =?us-ascii?Q?/NgOcoZhCUcG+fBUQSILmZHNtbEMWVL/EDNYFQTWYPAvbFnAphtr7y854BbV?=
 =?us-ascii?Q?0RYDxPMeVa96Nju1StRgcHx8Cx8wUSg7vNfHrcstd3rBYzio7ZY4stVF8BQO?=
 =?us-ascii?Q?UuS+6TjG/8A/+58K3x+5VgKGircMri7nnRie/5h7W7R07x3uDufHAqFRxlew?=
 =?us-ascii?Q?PhjGnsHY+uPZplnsIyLyqmuoFUt4Vf402id4nRvl//PPMdXrvpvL0DsExFQ6?=
 =?us-ascii?Q?72p8fT/JQCYopaTwMdB3MCl95DkhGwoUg/T+EOQH/SPNzggKdrUMreCQaDn6?=
 =?us-ascii?Q?uDcvHvAlOp74U+DfdTCfY0wizBFph9f1p+TIuJTDKICKrC552r/lsefgkABD?=
 =?us-ascii?Q?NwGkOnJHxoYr3Z0yRo41MMumCgwunUys0DZRLXg1hEWd/Hh1nU3zbPnZG329?=
 =?us-ascii?Q?HXOaoFjLWRb2pOE/5yNbLyk6ym8W649Dcyuo3NssvLPbVC+CMU4qB6Ds8kHy?=
 =?us-ascii?Q?BPotC4EQsV/wLhhknKc/mL9IBb9hcIJxMEV+4UaF2dCpfNCv7swVYElb17tm?=
 =?us-ascii?Q?VdGRxsrTQDm8+/r/hov6hsQ6dTJZnz9EFz7GX/V72qI9Phby1nCOvAVjB/Ga?=
 =?us-ascii?Q?OyI4MREgRpCW6wCMrwuHybpBgn+C6IXWvHhfBbdN4fqEUlWUFBYjgF7nOxbg?=
 =?us-ascii?Q?ZehIC5RaovVdBRQnVm3f2y6cTL6juU1X11PVVTbU4bqqf4QFO19w6/sumIt9?=
 =?us-ascii?Q?thPTIcO1ooxB5lUIHQf1sTwyW4gM2MS36izAZph38jW/XsJ5264xiuoZXFGg?=
 =?us-ascii?Q?6W+IP6UMFduxsDYCX0vQRjFvut1YGlTFmizeF7D8pzV0Am2K+Cz4FvmMBt3S?=
 =?us-ascii?Q?O9bIHkARRVWhR1i80QuJXOeKAgssPpLLPwcFSfQGn/IiTyQOvxCaYiHWhY4V?=
 =?us-ascii?Q?pFJicKJA/g=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65dabbe9-4d1f-498e-b30c-08dea596e3e6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 02:27:42.6121 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9dmRJ7+r+A/+faaqUEXiAozBdCB3uWpxscqfpr69joUGyMQIpcR11mFrpABmBzfSJUBnDmDv0hjwhcpZtcTdmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10076
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

On Tue, Apr 28, 2026 at 04:37:33PM +0800, Ye Li wrote:
>devm_kzalloc needs to pass udevice for first parameter, this phy driver
>wrongly pass the priv in phy_device. And because the dev in phy_device
>is only valid after phy_connect, in probe phase this dev is NULL, so
>we can't use devm_kzalloc, replace it with kzalloc.
>
>Signed-off-by: Ye Li <ye.li@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
