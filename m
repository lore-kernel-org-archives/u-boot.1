Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A471DECD6D3
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 18:25:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90FFC83E72;
	Wed, 11 Feb 2026 19:23:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="n9iInW3U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59E5383E81; Wed, 11 Feb 2026 19:23:36 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73FA083E69
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 19:23:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hCZdnWwuSxiPJBLPaov6lkQWEe0hJWVjHrs71f0RquxJjPAufdasc7GXUDHEHPxEiKLNz4vVHn3rjkAJSOA/t7hwxChOOgJk4lv1BsmfVW/unqD6fu/taXfn0EzhYowbhvKGHJYSKVuMBR/3QuBwGvFKwqPOhBDsAYu2y67ahJwO+evkeGiNW8ttxTqt8UWZpPTH8LEaqF+vfnzMIVALdCN77crZB/Q0DkoZ9mJj6ULxSfpMdEIMWjEaXWsUbJQ38YiDYkXPEXXqerKQBC2rMtnGCHckoj1kRo3Aytc40UMt/TmBmTkSe3qN43RddxLw0eiaAkOJr70l3xJ62c2pqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzGvpcVGa2SNugNKK8/ozCIAhsQBRiTVnjHn7PtvF/I=;
 b=FxHYfeHDkd0sFVksyspPITztRKuo7gQYSSYSyPL9P2gUMxb2k73KMVA0C/diyEn0U0UZMsy/GhaL2knNDYrGlCoEDjZd55ect5ldAkAav/lBqf7EueFC/q7ghRA3yxWjjjiLMbHgs6ijuoP3PvT/rZ6C/e69d4cxAUD35L8KJiBYWLmm15+yJwaACOdyfP/N+8uF+483nomd0Xk+WrAqvByw6HbiQ7mmSjVs8czsZR9AAZNbCjbpsYjbtDnMNoAHC+VMDQVaN8/9ygTmVbDUcG6PmmBcCNKrZppu3KWLFgUq0ioZSFnR3nWIY7hRDjYUSOiUdq/f9riZpuhMfpL9fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzGvpcVGa2SNugNKK8/ozCIAhsQBRiTVnjHn7PtvF/I=;
 b=n9iInW3Uq2QqUbXWn8i3ZEE9tf9Sh2yVqmjtQACfM/LYBrcD1AxZcZTT1tiOibdpn4/xJq6uN5+ttCJy57dzMmutNO2WvYE+jqTEBNXy7axdoda0zI1P2+cIzFBcQQCI5VmCLnFFIqVEcOQCvy3x15ytcmK508XPXjA3EpZxYL+lkdmFKDcsHWmtDZYaY6XbSt1N14gF6x+cHvUkvaL5OX6s/wQSu1bPolbkzX2xS0M1iJzi/uk57CSxeknkYthMfs42UXdZjmPSIOkMUbPxqLgVhmuGGr0nhO2EFFsmzPtLBGpsVJVj3I6/NFEgauAYKExhg+n/WWqjlwZAppXjbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAWPR08MB11040.eurprd08.prod.outlook.com (2603:10a6:102:46f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 18:23:33 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9587.010; Wed, 11 Feb 2026
 18:23:33 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Ray Liu <ray.xy.liu@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Robert Marko <robert.marko@sartura.hr>, Yao Zi <me@ziyao.cc>,
 Greg Malysa <malysagreg@gmail.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 13/16] configs: enable PCS for Airoha AN7581
Date: Wed, 11 Feb 2026 21:22:27 +0300
Message-ID: <20260211182230.968921-14-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211182230.968921-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260211182230.968921-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::10) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PAWPR08MB11040:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e7f4d49-ff17-4ffc-bf37-08de699aa9d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Mwmh5kss1q7xRm7oT/iZDDkLZZYqbeSzd+M85lTIrXIPhrCjUuVtMqykQiTd?=
 =?us-ascii?Q?fwJpvh44MX7NFXMbZbCH+EurJYeEAmW9tKYQkX5JeDUdR/e71a2CkuP+YXy/?=
 =?us-ascii?Q?tm3x2G1lbxCKrgsQL4hPEWAfk/nQBf0VF8wt/RCLOXI6rEhP7eiXpEABolIh?=
 =?us-ascii?Q?28KRT+pHa2UGT1qrubSBShxavswEEZIT8jcT8B01U0Dw9/GgeFYZyA1KOdfp?=
 =?us-ascii?Q?B7z6GmCrkxM6Gzp2ug8GoLPLWuKjzcrLJ4Pl7G6FZm59X6/A2fH3OCQjWqAB?=
 =?us-ascii?Q?Q85gl56KgHJ+CYhKc+8dfCl88wji4waW4KOdn0qQpblCqg5JSWQTFni1vKSf?=
 =?us-ascii?Q?mILD2SJSdRyy+bYk23hmaJ7NeurYPC1swHXpKUxYdcLN4szt/w1M54F3cQ9G?=
 =?us-ascii?Q?+IJ+x7zvmRKud+OXOKO1/LpmIBR9/0gJdV7VrWD9tBHmwhv5LlrBQ2FY02sA?=
 =?us-ascii?Q?o7NOkadYiS7K5LJP2GIqR8KF3YF8SICXNXnmIBz+gg47yadqDNlUodwEC0BP?=
 =?us-ascii?Q?7W+dWunVNonf/pKuL1BX+YOrrs2Yho00o+XxCewZUdGHEIFokyb3WEQX15Qf?=
 =?us-ascii?Q?1CvncQDSVsSaBz/RBd7oF8l/wQHVhidMbRX0SFUL34rAh8ebfwa6V604PGPi?=
 =?us-ascii?Q?8TkqtMV6vBqjtIrZi/iCKYjtu4tYei5gCEP289FSzJIY9j080b/3gvZxXlCd?=
 =?us-ascii?Q?hapX9/H0Jm6oiumxFtNSfyzMl8kJA9ZuMGRH6UgSXPF0uqY1Ty8G9+vVrmvJ?=
 =?us-ascii?Q?N7ES8bs94npy+HvHD8JnTRvhK8rQRR6H7FhSWM2VN5AUYbG38FK2QlPXOXrO?=
 =?us-ascii?Q?PlZ75k2PDMWf8ZrkVoS3RluH5USYwJMUXrPTjVCn89fOjmlJMmkfSA7Xw4eP?=
 =?us-ascii?Q?tt0aLQItZ2H6U7kCVn1CTUVYpOHkAwe8PYk1OL1Hoe92LhrsHgmCMXJ2C0I6?=
 =?us-ascii?Q?hOPALPs0UeknVEdqc72+rdxjS+mfyBvkHWmSYm3fHMVIcHDhnfFtYOIHGz1H?=
 =?us-ascii?Q?6A4OJjJhc4Js57LwGWKD3bC9DZk4tYTzz/JuX7QTWGyQ4R5O0GwAWlu2Y4+O?=
 =?us-ascii?Q?rd7fswJWvFdqZ1vH8/9CjIYTVdAaDGAmXSsMa50b5r1vpIwCBFsvMqdB59vq?=
 =?us-ascii?Q?iv76HPmw7B8D6pavOrFhifjT/9yxK5S22RaU3l8iV7zpeQz0nxqc4BnsaXYc?=
 =?us-ascii?Q?vGlEG/520IZKnAXIcPIuf3A+hmB/RIpESxQtl89cvT5UYw0Yps7F6lOyqcPy?=
 =?us-ascii?Q?iniu+0wimy/HzIvq0xCdueY3i9n4cICvVT5mhqQwJ3tqiWVQKSfOKqORM9lv?=
 =?us-ascii?Q?sBrR1y2NX2c98XOIsQ6MkWA8yfFfCWUUKR8nRuI6wbLH51r8h0hXJ67/Pn0P?=
 =?us-ascii?Q?CjyhS4uDU2tcgdaVQXq4cCk37xXmzAQ6v7T/dUmBTF0mElXZ40HXOAAMxhgh?=
 =?us-ascii?Q?OAheJNXJruXeEEcwsqiP4M4Zg+5whZ4hNzTLxS4uNQHLdxnXxDreO5BvI22f?=
 =?us-ascii?Q?N5lI28wUImX5x9+8BGwQlChL6NX1yTeqnGdTv2cArs9oCvScGB7oOaI1OIov?=
 =?us-ascii?Q?QVZiMOFhRx/vCwDS3nFxQPt9vf70XPnPLuKKbxYM9lnI832es5vTLsUEmCve?=
 =?us-ascii?Q?6gC2mcP7pO7e5+VVZArV7aQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uhGCDowmxkO8f6ZztSm3QWj4LI72Gixq63dpbDprq4qfjaoPmlDNHVaf7Rw0?=
 =?us-ascii?Q?V2gBz6TB2LWbbGJxMOboQ6Em9lDQX+vIsM4UmzYF6rAgduElDuxjUGBM70wK?=
 =?us-ascii?Q?kmQw66igDavFIj6SWmhIKjou9hzE7XIv1HXQaq8+FQ4FmRyQf0pR/PcTsfnq?=
 =?us-ascii?Q?YIY8r31OnDYn0OmKUnzGN80fjumeYs0nEEf32qbOPY9ZUuqIgytwre34Ie+Y?=
 =?us-ascii?Q?WWt1/XuXfLRk1iLKol0hrhmIY9w+Ccb5RHllpZ0HN9DXUUMi9CxhrYBkmgKu?=
 =?us-ascii?Q?Bkj1/I57La67/q+pMQaU+ej5U+XHKa91XhD5dXAhE+26V0/CkmwJxwLMvckq?=
 =?us-ascii?Q?1Ch1kpf7IUx9DTOnUavu0BQpq7M7fOjxBV5UDryo0/vt+mldtFfSiUwzFt77?=
 =?us-ascii?Q?t2YP5Zc/N8jrcZr7BSLt1g1E/GThjjZJP72/lx6xv68ki26fu3ONBHgtN/sJ?=
 =?us-ascii?Q?THXVpZcQEV5kvj+EtwCT/vvUNqYVJTPUCwVjqQClkOAR0XR1a/L09rq9jr6S?=
 =?us-ascii?Q?vpIqb7ITQSvaOcEJidqo6vRlR35S+YmJHSqo/KU4EjnqVIKmMfJQfzPaUA5p?=
 =?us-ascii?Q?4Lp0KB89E6UC374FKQ+NJcyAFo2/bq3dQlnmVr38LKi8ncNW54k0B0rU2D18?=
 =?us-ascii?Q?s49gq/1d3l0VQPE8zhKanjE7dm9/YNkt4pWUqayBjR7awkM7hDbzDaNwL2Bd?=
 =?us-ascii?Q?y5FggGea6C8f3LSUTKADxu3ud1thOavh6uwIE9QD964sngOn4jQiHsOzvJHX?=
 =?us-ascii?Q?pJMIJC3VBWGg0i9hOng52tQonVpSxmAUs2q/L8nUoGFH1J/J2xhWB+SDr069?=
 =?us-ascii?Q?FbqvazDKWVIPF2PkllY78HbOqx4yYVFWsF+1XnQiXoTjw+Lk3mXuR+ecsib2?=
 =?us-ascii?Q?xcZup8Q0pjvLCeahQayvIHecJDrW/SS/MbQQV8EKD4+wAnD3+W6NTsAT5tcj?=
 =?us-ascii?Q?8M9UzfrolaPHI6+7DwHdsG0DyrcRW0R5de0pQNcBy8nsLeYrD0xWq2VC0Wkd?=
 =?us-ascii?Q?GuSkOBk13ewLIWU4AbVoGhtJ4SoEeOqIblOaUj8aL7P7dIbFbE2XciH66s1g?=
 =?us-ascii?Q?ioMU/aROYMOHfkJ0t9gZOHy1AqMwixw7BzGe6uMpOT8pICzWe4Rox03Mwz9D?=
 =?us-ascii?Q?J5ZADjP+Kr8WqfmcSGbnzwfZiorpA0zlLeNspIRtqVSQcy9J4VXvFv/EiJ1L?=
 =?us-ascii?Q?i4PZAZGR6kIfCiHDpLTq+kccz+hcvNa5A6rmGB300huG0+7DU+dBskaxIRKy?=
 =?us-ascii?Q?olT0oBU2Xl8OAhadmgcrNyaEJCeYzozEgWpcpoWP+TwFs4DRdPHD5+ibvlfg?=
 =?us-ascii?Q?u5mdQJLkVyBxcJsSdUwvXyEQW30qaD1sYIdLs7itKDdiT2ZA6orHXSlN0aby?=
 =?us-ascii?Q?TWuhmrAbVPR32pU6R1cBiylYMkfi9NMEIGake1EgGBYUSzWn/tY1wx8Z3l/g?=
 =?us-ascii?Q?TZESO9W0fdog5irExCD1tyKyF1moYdXRdZ916eEFowPk5ZFX2PegkMaW3xn5?=
 =?us-ascii?Q?66/PoJhvfdUhlh1Ck72nvg9903mcupHtoniDKJ4eBKo1LB9oIi9mOnUBHUYs?=
 =?us-ascii?Q?A6ZkjIFlTTca8UkViIfGC9hu+Na/pp4eqSN6NlONad5y5xRpxWTlZtZ1NkpQ?=
 =?us-ascii?Q?sFOYpwzKGvLLV2EBIMFxg6QC0HBmUp4VNiOkzvigrKQWAaSMfgWZh+6h1HvX?=
 =?us-ascii?Q?AtgMVp7hIVtuUh2ly66giuvFPUYyVljmTAU3JoRQuO8wxiI9ergr2H28dW9M?=
 =?us-ascii?Q?L36fF/zKoszNQrPPG+ZYvH0RBhrRGbs=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e7f4d49-ff17-4ffc-bf37-08de699aa9d1
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 18:23:33.0630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D6hkCoAtTshRQw9/hfEe5G3QELSs5qoJXwK98jOZcCx4O6VeXd/qruDgtuQJgETvNgjCd/INictqT1+6CE5M+8B5o5PrPC0FOi9Ew92MGqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11040
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

From: Christian Marangi <ansuelsmth@gmail.com>

Enable PCS config for Airoha AN7581 SoC by default to enable
support for External PHY.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 configs/an7581_evb_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/an7581_evb_defconfig b/configs/an7581_evb_defconfig
index 7c1c6cf45e1..a94730cf564 100644
--- a/configs/an7581_evb_defconfig
+++ b/configs/an7581_evb_defconfig
@@ -68,6 +68,8 @@ CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_DM_MDIO=y
 CONFIG_AIROHA_ETH=y
+CONFIG_PCS_AIROHA_AN7581=y
+CONFIG_PHYLIB=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
-- 
2.51.0

