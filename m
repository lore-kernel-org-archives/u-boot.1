Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BC2FF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 17:33:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D800484413;
	Sat, 25 Apr 2026 19:33:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qAjC8f9S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D06078442A; Sat, 25 Apr 2026 19:33:21 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73BA3843FB
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:33:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
Received: from AM9PR04MB7554.eurprd04.prod.outlook.com (2603:10a6:20b:2da::23)
 by DB9PR04MB9401.eurprd04.prod.outlook.com (2603:10a6:10:36b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.24; Sat, 25 Apr
 2026 10:18:14 +0000
Received: from AM8PR04MB7876.eurprd04.prod.outlook.com (2603:10a6:20b:240::22)
 by AM9PR04MB7554.eurprd04.prod.outlook.com (2603:10a6:20b:2da::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Sat, 25 Apr
 2026 09:00:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i04i4fTcm6jElnXt0lc2rbbB27GGzpjpxz7+35/Sdku/bQk/Sso8Ek8+Ihwc2AnaQiGL4QOs3MZwWE0kujMtgarkw7nbPt1BUQdQMHV8qKMq8mRSRz2dc0sXig7xmpUr8NRSpwJicF8fcaM5JzetzGMaiO60RAw/cz6b3hwk4pjPqUJWmjZ9waxuv8CGvhX/ZXdzvouyVd8eqd8aZbI70tM1EAL9EpJN+d4GHxXZk0lhAxmMXLHbXQ0RPi3m9S5DkjU9I0bxsGBh8CxpNWpn4SI9hvlTazASdVm3aU7IfCud7t5vxj8uZQM/8M5Eh1ZTZ58U07XpQLaVPDQ9Mdnpug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igZxtaMfB076DostNYtp/PqYDBYB8Wm68/ohn3VPFmk=;
 b=cUjYhOT0OfkkKAteVLgyvZn+JEoMiWGKkPPk1Z7wCCmrNLyGbYlJgUUjALw/8Vp9m2CvnxoWRNhEJt3mJbqILhxeVMzJZ58sSNGyXGkK2GZmAcnWmNL8l8FyhuIXZNEefEx7IskNwzjHRfTT3Rwvi/yAV3AaSXAmW/upxaX9xqjMuV6Sut2pVTw/CDxASXXDvxF0hyv+3wXw0y7mebwX+DF+PFnSSwmsJEpLSzYTCo51hDluT0Yg59Zp45aYj1hmKF1pmYj63yBp/3a5QSO6XR9AxCVK/hOHvZbTWawqx+bkDcy0KAVVPuZZ8yCg4Y4crFWPEI4fS79lOmBofZgYWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igZxtaMfB076DostNYtp/PqYDBYB8Wm68/ohn3VPFmk=;
 b=qAjC8f9SpzKOKv1r1c2xBLSr8tLdA3MmCJ52PFOvo8YpkhT2Evxc+SlFWqZEs9ug3Mr2RmpJOeL4df7kQz5sQ6OCoihstGFqrbB64p7GprtBYl2/OMKJyO5xZfhfbBQEg8TwD/tdJBbdhZLMqBj3jtM4dEpV18EIVhgHg664cvKzZBjzwTyQBHpHFDSgi2CCpf0GJHCAEh/bd9b4FX0/12sh8++GNhCkK4rWpcaTipJOfjb0gb9VOUQPIibKh3AXGpp8yUQX+jeffcc5td9nVB4I7WgGXCZOdmunDxV8mz1ZH8Lm0gmFSSHLmku8BLMdZdRfmD8bTj41aAv+PoTw6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB7876.eurprd04.prod.outlook.com (2603:10a6:20b:240::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Fri, 24 Apr
 2026 23:20:40 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 23:20:40 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 25 Apr 2026 08:36:55 +0800
Subject: [PATCH 03/13] imx8mq: pico: Switch OF_UPSTREAM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260425-imx8m-of-upstream-v1-3-07527be92e5d@nxp.com>
References: <20260425-imx8m-of-upstream-v1-0-07527be92e5d@nxp.com>
In-Reply-To: <20260425-imx8m-of-upstream-v1-0-07527be92e5d@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 kernel@puri.sm, u-boot@dh-electronics.com
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, "Lukas F. Hartmann" <lukas@mntre.com>, 
 Patrick Wildt <patrick@blueri.se>, Ye Li <ye.li@nxp.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Benjamin Hahn <B.Hahn@phytec.de>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marco Franchi <marcofrk@gmail.com>, Alifer Moraes <alifer.wsdm@gmail.com>, 
 Angus Ainslie <angus@akkea.ca>, Heiko Thiery <heiko.thiery@gmail.com>, 
 Olaf Mandel <o.mandel@menlosystems.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Matteo Lisi <matteo.lisi@engicam.com>, 
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM8PR04MB7876:EE_|AM9PR04MB7554:EE_|DB9PR04MB9401:EE_
X-MS-Office365-Filtering-Correlation-Id: efb04bf9-b431-4612-e9ed-08dea2581954
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|19092799006|366016|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: mO+uJ8DNPT6DMDkzx99Va952K/zZ9mDI5DV02NYfw17WmEVFD6zqRD7R+ZTtXKuZ9vrRm7ZUrQpE7aj2DxfFelII+gYmyigwb/uYkxoI7mrOr09DICUU6uIk1dudgpwA6cfm+4pgHiPfzq2+4VA5+d85YphNZnfGvndATiIpNJzGOHFjEyITwlOpddHcmnUsU5JrdM26fyBqFSwDwdj2145pZlXHOkG7GCiOu6H5NL1xY8U69ErN8wy6vsZGFEZjLxsL3/IW0/tLJJf5YZvkxA5ssu//RXguUlbpHXgGXD6smty/s+SP8zG7yKtxO0vXGTe3Qon2Q2FK7jCrgIYtJqSMlKzGhWz7sA2kNqR5D/Vbogi9a8yIcc6e0MyG6GKGiCil5U5JmMEComA/QprSpUlczM/6COKMlnTpCRldGOHp4iR/rTpBJRWAaOhP3gnufJhW9qND3cBE814j6hRhkgs/LOoXDqg/Ll8LW2x3B0RVL1keJ3JMexIeTnwfz9e9wuHhIXkh3TeGqk4J08pJy7fw7pplVNm9NJ2rB6jVipnTIkYwph1kwLhz1ue768HRvRHKjs4TMpwRUFnpVNs/oWiQhJRIxdnaj10gq7238oNOTVDwT8HSySTpjP0sn34YxCZOJHcRVE/8oxoN9UYQqt1Q2GzIxXJQwq5Am/eiE+ABpCEPj/Y4c1TvmbgZkP96nGwIxq4iObijd+wrmQuRe39eV+AeClRB+6Klzf3XDVuMh1AQpO6N+Yg+eBTaE7P2J4hxB3ZogrHkDk11sSL0AKhEVMR1lp06MEeWTiVRcJ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(19092799006)(366016)(56012099003)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGsveXBOM1VHcTgrUWVZbjJ2RzY2UjJGWSthT1MzOW1iRnA5YkFHMERxRjNs?=
 =?utf-8?B?OHhZNTJwYUVFandyL2VvY0xlUkllZzNRajBpekM3bnpjUXJPNGRoZm9RejdQ?=
 =?utf-8?B?UUI4MEtWbzJuN0VFS0hkekVZNHlqUVArZXpDSzJJb25jMERTTFVnK2NzcGFH?=
 =?utf-8?B?K0VCNjhyZnJzTnpYUXlQVHBXczkxTEltNXZ2TWhUcXpad25jWW0xaGU5M3hP?=
 =?utf-8?B?ZWxzcFVvbklVenhibGs2TnFHQTBEVWcrcjF1OGVrbFl1ZDBRVnIzZ2txWHh6?=
 =?utf-8?B?ZzV4UUdtcTI4SWJsL2o3QlNOcG9GaHQyaGhPc2xUOUhtNGk0TGsrcDRPRWd3?=
 =?utf-8?B?MVRmRGZBZkJvQ0pyVkRBOWFsVU9xaHZMRmt2amIxYnIvSlg0U0tLM2grdWln?=
 =?utf-8?B?aTZZc1o3VitTbEFYVjZ6V3dnUks5VWdES29CakY4L3FXbUJERlVlWjlJM3o4?=
 =?utf-8?B?b0RWQ0w2UnRIOVIwTDhWRnpOdW83RVNQRmpweXhqZUlubWdyU3hpUjgxV2tF?=
 =?utf-8?B?K0QyaUtMbU9JS3NFTUR5dDNrZmlRMXRrMmRMcWVEOERNWnFYWUJEcVRZVkIy?=
 =?utf-8?B?ODVHYjFHdmpXYjd1TlMvU3Q3UEhMTjQ5WWJ1UmFZdE5lanREVXpuSFI0UXZu?=
 =?utf-8?B?NXNmZFpWT1loY093aG9OZTVMTnJqaWJvbW5kN0dRdjFEOFRuRDcrTnNINFA2?=
 =?utf-8?B?RGtMSVVlQ0RZd1ExaHVDanJUcTA3WnNFdEZVd1dsbDQ3Z2ViUUFrb0MwaUll?=
 =?utf-8?B?Yld5WERHTEZnWjc3cllwVFZOK09tVTRpSXdBdWJnVW01MTlJbDhLTTd6eDdo?=
 =?utf-8?B?WWdpdFFaV2ZVRVhOREVRYnErSnd0ZlZtZllWcnZxd0t4L0NQa1hWMTI3QjQr?=
 =?utf-8?B?cGhGUHRqUU4rWmlnaDFxOEhXdXpJN2hsbkFVZlk0VXpOKzFHSmR5Vjltd1Vn?=
 =?utf-8?B?WVNHMHkvdytPWExVU2ZnaE1UTFVzODFwLzRqYkVqTm91VXdIQlVvOVhqOGto?=
 =?utf-8?B?SDVXV0xrSVNGZmk0SndhMDFuR01hWW8wOU1NOUFsNDhpelpPTDk1UVBkY3J4?=
 =?utf-8?B?RVhqQjJBWi9mdm1Md1pKOHR2M1g2a09xcEpxMWlVa0hCREU1c2J6WXE5OThq?=
 =?utf-8?B?cnRSK2ZEc3RpMUg0MEJUTUpiSFpwNW1HK1hBQWlkS0I4YUg5QW9HdTZXWFg3?=
 =?utf-8?B?Q2xXWnRWdkM4UDhNTWxla2xXd3BVUEVIMCtpT0ZzY3E1b01rNmluZ3Eya1dt?=
 =?utf-8?B?VVliU1Q0Tk9yTFhBZFFzS2pDTE9ha1V0Z216MWF3b3ZNek50TWVQOE1kdHN0?=
 =?utf-8?B?REJ0emRBNGxvemFiVUFwajFvSGRiRjcwdGg5Q3ZWL3hQQkJLS25VeFFUS2d6?=
 =?utf-8?B?THFsM2sxNXg1Q2paMzFYWG4xandZa09LaE9DRDVhRUN4WE8rWmo4SWJuSzV2?=
 =?utf-8?B?TFA1MElCbFFQSnErSy9Kb3hSOUtFeVNudzNTd3lESWQycldTUjMvbHFIMmZ1?=
 =?utf-8?B?RE1hRkM5VzFkNEFJajI3K1grVlNyRis0cCtQS1Z6Z20yeEZVaXVNYWdxeDFr?=
 =?utf-8?B?RFFyQXN2bTN4T2xmdVlyVHFYK25IM3JyNkFmbXFPOHRmUm5NcDdVbDVONEYr?=
 =?utf-8?B?MFBicUtOZlNoT3V4OC9TR1IrOEpBSWVrY3ZuSW1oOVRnRGo2RjVjMG1YY0Ji?=
 =?utf-8?B?M0xFUVdSMjNDRFZMeWNwZ25SM2V2ZkNDSTN1ZG5hVGV1MHp3Y0ViamVJK2Nx?=
 =?utf-8?B?RmtOTHBpRFlzelpxQjg3UHB2bzBCTjVqMjhLR2ZzaVJzQStNSjFKQzhHZjdU?=
 =?utf-8?B?WmFVSkJqUEQ1QllESU8yNXlpVzlSNE9mQzgvRlYyRjl0K1prcW5VVkR6N3ow?=
 =?utf-8?B?TW41VVV6bmZlbDJpUW9OeDdVRjRhYXZUUTYreXBERzc1VlJXNGkyRUh0TEVv?=
 =?utf-8?B?bTZ3U1ZjY1M2eVQ1ODJtTDBNZ3M4aXNCRCtaQ0cvaEtjNVMxRzlqZFVnWXl2?=
 =?utf-8?B?SzF1akcvN2RUQXVlZzR3MWZuLy9PYVZXRmFLekRqV0wwMW1XSEtJYjJla2I0?=
 =?utf-8?B?Z0xIY2RjT0laVXM0ZTdWSDJGNGMwbktZY095YVpxZmhIMjRxazYwbnN3dTgx?=
 =?utf-8?B?WWpvK3oydWxFYlBJUkVuVmhJTFc5cndJNnZOT21aTlRPb3NuQ3o4QUFRVWRP?=
 =?utf-8?B?U3V0VVl1LzduS3hFZEVTZGQ1Z1RKbkUzemovd1V2YjVucFA5T2E2cG5ob29N?=
 =?utf-8?B?RG5YM1AzYXRXamNGbjBHTUhYdG5xWWZkYlRCMGpFeEdHRTE2ejVjaUZJUUZQ?=
 =?utf-8?B?VVd6RkF2a1lyWkxwVDJQZjR1QTdKcEtVV2NiRVRtSll4Q0YreVA1QT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: efb04bf9-b431-4612-e9ed-08dea2581954
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 23:20:40.1435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2n0YXKylL3nrVPnN2KscQUCXiRTNiMIpIqrxlWwDzgjkKuqI6Om3m7qEqiSj5PLgX1gbqFXEu8efGEdd/vgoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7876
X-OriginatorOrg: oss.nxp.com
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

From: Peng Fan <peng.fan@nxp.com>

arch/arm/dts/imx8mq-pico-pi.dts is almost same as upstream Linux dts,
so switch to OF_UPSTREAM by dropping the U-Boot copy of the dts,
enabling OF_UPSTREAM and updating CONFIG_DEFAULT_DEVICE_TREE.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/Makefile           |   1 -
 arch/arm/dts/imx8mq-pico-pi.dts | 418 ----------------------------------------
 arch/arm/mach-imx/imx8m/Kconfig |   1 +
 configs/pico-imx8mq_defconfig   |   2 +-
 4 files changed, 2 insertions(+), 420 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 4564544bc00..019928af9df 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -889,7 +889,6 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mp-dhcom-picoitx.dtb \
 	imx8mp-icore-mx8mp-edimm2.2.dtb \
 	imx8mp-msc-sm2s.dtb \
-	imx8mq-pico-pi.dtb \
 	imx8mq-kontron-pitx-imx8m.dtb \
 	imx8mq-librem5-r4.dtb
 
diff --git a/arch/arm/dts/imx8mq-pico-pi.dts b/arch/arm/dts/imx8mq-pico-pi.dts
deleted file mode 100644
index 89cbec5c41b..00000000000
--- a/arch/arm/dts/imx8mq-pico-pi.dts
+++ /dev/null
@@ -1,418 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2018 Wandboard, Org.
- * Copyright 2017 NXP
- *
- * Author: Richard Hu <hakahu@gmail.com>
- */
-
-/dts-v1/;
-
-#include "imx8mq.dtsi"
-#include <dt-bindings/interrupt-controller/irq.h>
-
-/ {
-	model = "TechNexion PICO-PI-8M";
-	compatible = "technexion,pico-pi-imx8m", "fsl,imx8mq";
-
-	chosen {
-		stdout-path = &uart1;
-	};
-
-	pmic_osc: clock-pmic {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <32768>;
-		clock-output-names = "pmic_osc";
-	};
-
-	reg_usb_otg_vbus: regulator-usb-otg-vbus {
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_otg_vbus>;
-		compatible = "regulator-fixed";
-		regulator-name = "usb_otg_vbus";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		gpio = <&gpio3 14 GPIO_ACTIVE_LOW>;
-	};
-};
-
-&fec1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_fec1 &pinctrl_enet_3v3>;
-	phy-mode = "rgmii-id";
-	phy-handle = <&ethphy0>;
-	fsl,magic-packet;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy0: ethernet-phy@1 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <1>;
-		};
-	};
-};
-
-&i2c1 {
-	clock-frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c1>;
-	status = "okay";
-
-	pmic: pmic@4b {
-		reg = <0x4b>;
-		compatible = "rohm,bd71837";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pmic>;
-		clocks = <&pmic_osc>;
-		clock-names = "osc";
-		clock-output-names = "pmic_clk";
-		interrupt-parent = <&gpio1>;
-		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
-		interrupt-names = "irq";
-
-		regulators {
-			buck1: BUCK1 {
-				regulator-name = "buck1";
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1300000>;
-				regulator-boot-on;
-				regulator-ramp-delay = <1250>;
-				rohm,dvs-run-voltage = <900000>;
-				rohm,dvs-idle-voltage = <850000>;
-				rohm,dvs-suspend-voltage = <800000>;
-			};
-
-			buck2: BUCK2 {
-				regulator-name = "buck2";
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1300000>;
-				regulator-boot-on;
-				regulator-ramp-delay = <1250>;
-				rohm,dvs-run-voltage = <1000000>;
-				rohm,dvs-idle-voltage = <900000>;
-			};
-
-			buck3: BUCK3 {
-				regulator-name = "buck3";
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1300000>;
-				regulator-boot-on;
-				rohm,dvs-run-voltage = <1000000>;
-			};
-
-			buck4: BUCK4 {
-				regulator-name = "buck4";
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1300000>;
-				regulator-boot-on;
-				rohm,dvs-run-voltage = <1000000>;
-			};
-
-			buck5: BUCK5 {
-				regulator-name = "buck5";
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-boot-on;
-			};
-
-			buck6: BUCK6 {
-				regulator-name = "buck6";
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-			};
-
-			buck7: BUCK7 {
-				regulator-name = "buck7";
-				regulator-min-microvolt = <1605000>;
-				regulator-max-microvolt = <1995000>;
-				regulator-boot-on;
-			};
-
-			buck8: BUCK8 {
-				regulator-name = "buck8";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1400000>;
-				regulator-boot-on;
-			};
-
-			ldo1: LDO1 {
-				regulator-name = "ldo1";
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo2: LDO2 {
-				regulator-name = "ldo2";
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <900000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo3: LDO3 {
-				regulator-name = "ldo3";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-			};
-
-			ldo4: LDO4 {
-				regulator-name = "ldo4";
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
-			};
-
-			ldo5: LDO5 {
-				regulator-name = "ldo5";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-			};
-
-			ldo6: LDO6 {
-				regulator-name = "ldo6";
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
-			};
-
-			ldo7: LDO7 {
-				regulator-name = "ldo7";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-			};
-		};
-	};
-};
-
-&i2c2 {
-	clock-frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c2>;
-	status = "okay";
-};
-
-&uart1 { /* console */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-	status = "okay";
-};
-
-&usdhc1 {
-	assigned-clocks = <&clk IMX8MQ_CLK_USDHC1>;
-	assigned-clock-rates = <400000000>;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc1>;
-	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
-	bus-width = <8>;
-	non-removable;
-	status = "okay";
-};
-
-&usdhc2 {
-	assigned-clocks = <&clk IMX8MQ_CLK_USDHC2>;
-	assigned-clock-rates = <200000000>;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
-	bus-width = <4>;
-	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
-	status = "okay";
-};
-
-&usb3_phy0 {
-	status = "okay";
-};
-
-&usb3_phy1 {
-	status = "okay";
-};
-
-&usb_dwc3_1 {
-	dr_mode = "host";
-	status = "okay";
-};
-
-&wdog1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_wdog>;
-	fsl,ext-reset-output;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_enet_3v3: enet3v3grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_GPIO1_IO00_GPIO1_IO0	0x19
-		>;
-	};
-
-	pinctrl_fec1: fec1grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_ENET_MDC_ENET1_MDC		0x3
-			MX8MQ_IOMUXC_ENET_MDIO_ENET1_MDIO	0x23
-			MX8MQ_IOMUXC_ENET_TD3_ENET1_RGMII_TD3	0x1f
-			MX8MQ_IOMUXC_ENET_TD2_ENET1_RGMII_TD2	0x1f
-			MX8MQ_IOMUXC_ENET_TD1_ENET1_RGMII_TD1	0x1f
-			MX8MQ_IOMUXC_ENET_TD0_ENET1_RGMII_TD0	0x1f
-			MX8MQ_IOMUXC_ENET_RD3_ENET1_RGMII_RD3	0x91
-			MX8MQ_IOMUXC_ENET_RD2_ENET1_RGMII_RD2	0x91
-			MX8MQ_IOMUXC_ENET_RD1_ENET1_RGMII_RD1	0x91
-			MX8MQ_IOMUXC_ENET_RD0_ENET1_RGMII_RD0	0x91
-			MX8MQ_IOMUXC_ENET_TXC_ENET1_RGMII_TXC	0x1f
-			MX8MQ_IOMUXC_ENET_RXC_ENET1_RGMII_RXC	0x91
-			MX8MQ_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
-			MX8MQ_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
-			MX8MQ_IOMUXC_GPIO1_IO09_GPIO1_IO9	0x19
-		>;
-	};
-
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_I2C1_SCL_I2C1_SCL			0x4000007f
-			MX8MQ_IOMUXC_I2C1_SDA_I2C1_SDA			0x4000007f
-		>;
-	};
-
-	pinctrl_i2c2: i2c2grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_I2C2_SCL_I2C2_SCL			0x4000007f
-			MX8MQ_IOMUXC_I2C2_SDA_I2C2_SDA			0x4000007f
-		>;
-	};
-
-	pinctrl_otg_vbus: otgvbusgrp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_NAND_DQS_GPIO3_IO14		0x19   /* USB OTG VBUS Enable */
-		>;
-	};
-
-	pinctrl_pmic: pmicirqgrp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_GPIO1_IO03_GPIO1_IO3	0x41
-		>;
-	};
-
-	pinctrl_uart1: uart1grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_UART1_RXD_UART1_DCE_RX		0x49
-			MX8MQ_IOMUXC_UART1_TXD_UART1_DCE_TX		0x49
-		>;
-	};
-
-	pinctrl_uart2: uart2grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_UART2_RXD_UART2_DCE_RX		0x49
-			MX8MQ_IOMUXC_UART2_TXD_UART2_DCE_TX		0x49
-			MX8MQ_IOMUXC_UART4_RXD_UART2_DCE_CTS_B		0x49
-			MX8MQ_IOMUXC_UART4_TXD_UART2_DCE_RTS_B		0x49
-		>;
-	};
-
-	pinctrl_usdhc1: usdhc1grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x83
-			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc3
-			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc3
-			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc3
-			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc3
-			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc3
-			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc3
-			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc3
-			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc3
-			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc3
-			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x83
-		>;
-	};
-
-	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x85
-			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc5
-			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc5
-			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc5
-			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc5
-			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc5
-			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc5
-			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc5
-			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc5
-			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc5
-			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x85
-		>;
-	};
-
-	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x87
-			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc7
-			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc7
-			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc7
-			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc7
-			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc7
-			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc7
-			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc7
-			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc7
-			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc7
-			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x87
-		>;
-	};
-
-	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SD2_CD_B_GPIO2_IO12	0x41
-		>;
-	};
-
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x83
-			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc3
-			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc3
-			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc3
-			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc3
-			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc3
-			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
-		>;
-	};
-
-	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x85
-			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc5
-			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc5
-			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc5
-			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc5
-			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc5
-			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
-		>;
-	};
-
-	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x87
-			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc7
-			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc7
-			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc7
-			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc7
-			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc7
-			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
-		>;
-	};
-
-	pinctrl_wdog: wdoggrp {
-		fsl,pins = <
-			MX8MQ_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B 0xc6
-		>;
-	};
-};
diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index ef1146cd7f6..6b5903104a5 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -310,6 +310,7 @@ config TARGET_PICO_IMX8MQ
 	bool "Support Technexion Pico iMX8MQ"
 	select IMX8MQ
 	select IMX8M_LPDDR4
+	imply OF_UPSTREAM
 
 config TARGET_IMX8MN_VAR_SOM
 	bool "Variscite imx8mn_var_som"
diff --git a/configs/pico-imx8mq_defconfig b/configs/pico-imx8mq_defconfig
index 2567c5b4715..66fb671c2c6 100644
--- a/configs/pico-imx8mq_defconfig
+++ b/configs/pico-imx8mq_defconfig
@@ -11,7 +11,7 @@ CONFIG_SYS_I2C_MXC_I2C1=y
 CONFIG_SYS_I2C_MXC_I2C2=y
 CONFIG_SYS_I2C_MXC_I2C3=y
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8mq-pico-pi"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mq-pico-pi"
 CONFIG_TARGET_PICO_IMX8MQ=y
 CONFIG_DM_RESET=y
 CONFIG_SYS_MONITOR_LEN=524288

-- 
2.51.0

