Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E31C5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 09:56:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F423980E9A;
	Tue, 10 Jun 2025 11:56:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="jGJebEnX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF88582B07; Tue, 10 Jun 2025 11:56:44 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 500A78070C
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 11:56:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R8VBjErUj4h+0U7rUxH3NvvWoO+WjYs7UGcbFs+RrjuB7HoBKlAOfQtZXelo328AG/ltnko76I9hgzxqCcl8CN7tsgl8NXc0t5wLpd5jOgnbqn9lUcdebDxr8z/ZjBWkUeABZJatNwUXY8aZuy9SVd8axV5kE/e7jDGWEbPjksIqAEzit0YKFbGEeZhPG5gY0GcQUlLj3h1RaAcbf3xx2atk3/YnXrI8pR0yIRBDBy9C4x97yjspgLBHiIAvjcpDe7eDjYJs/ZFxbWyLPQpVyRZD4Jc7fvVqg76xDYtWdjbk1qUKgkZFpNOpSePvhSTSTq/wJpZWxLyPyCoVWZZALQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agQZ/IYiYw46SXLaN9ipuGDuOIplpqBluHqx2C1k2Mg=;
 b=fCNkleqPEhhmiivAY/MRVCUJF4kO7rI/0cuXUHHBnp0Uass/8AVMn2JCLB1jTLbDvVlc8MbeZvZtlnw42zO1Bdzf1/u7FeRHl8Vaaxbnyv2RPzerConFqUYWakuuObaTAuuMzyb/0MG5lBUzwmtELYxmNZXh9DrqjbVXrh7iwcoMGK11hKZ8AwVztW/pxqp4KByJ9mvj4PxRN9iXP9QRiia9h71n+6OZzM3J6dDiKnRUI3x4kUuSPYlUDCZBBKf+DuT7wOf6i6WqeanTSCuOyl0vO0eWR13Ig4s6XW6Vd+3ByiBv5PO4AYJs1RXxhQ+MckwUs1h8C9DF6AiazI7SSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agQZ/IYiYw46SXLaN9ipuGDuOIplpqBluHqx2C1k2Mg=;
 b=jGJebEnXbMNXwqlG1OONaTQsBUI1M58J7UtxnPCCnnUjLzSL77cwWAoMBpwd545MQVGTJ+VoZiQV7KXf6QPMwF3JlY1x9fYKjql1ZEUa+tsVsBVWMF5kTPdONAZ+xxrVMlygR0JOAbfe4T5W0MSCFOAGfLhMrENdJpVsQ6TtEbErecvaYiNDlbF7zqr6VVtz71nSgwJAoJ+GiSt7DsftEKBi/W4/0V+V60/lCOha/fcxZlmbwq2Z2q+6WaEDpV8GClmLIZXRg6Ufe4IIJptmxVl40QkqRVKZqjKw+cbQCQXisn8Ig5DY8iI8rFBjMX133K+6EHpJiApuWnAFVcRlww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB6343.eurprd08.prod.outlook.com (2603:10a6:20b:337::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Tue, 10 Jun
 2025 09:56:40 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8769.037; Tue, 10 Jun 2025
 09:56:40 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Edwards <cfsworks@gmail.com>,
 Anshul Dalal <anshuld@ti.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v5 0/3] common/spl fixes
Date: Tue, 10 Jun 2025 12:56:29 +0300
Message-ID: <20250610095632.1085431-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250610045054.1038235-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250610045054.1038235-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0010.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:272::9) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB6343:EE_
X-MS-Office365-Filtering-Correlation-Id: da0a9930-3dd9-45f0-b094-08dda8051874
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vL4YMO3atQWphRb6bsjABpGlbeaMQD1iVhqSjkQaQ+bk4DuQZvX9uIfxd5w5?=
 =?us-ascii?Q?v0gFhPgjZI57P5yWdTB9MKXtMvE6jnBpwVBegWiuUwTswkl+Uck/s1XyDttm?=
 =?us-ascii?Q?ZCGwEnpPB+AmZ4Yyx6OnZ52mXiPSKfrNNg9P6OFD4+L3fWCMu71JH2nNJaal?=
 =?us-ascii?Q?1OuJpuaylGJxUCcJTyBxYAieX2Zrqi6T5CwPPW3ptBma1ds8JxQBpkXtL33N?=
 =?us-ascii?Q?2rWxmZV+6yB730R+vDmhb2amMM05JHnsd9xqjcJaVCQf0wCstuIU1TPxLlng?=
 =?us-ascii?Q?vr+34dtR6PQk1kXA9aMImrh6CSSQ6FT9t49RT2ND+Q/6zcCoLFBIuHMOPDJP?=
 =?us-ascii?Q?WqY1Sr40YoOx7YQlmQjlV27Ga0Gqf1ynattavTtpsWBQlaPVZEd2BjqHdGaT?=
 =?us-ascii?Q?O1SBgYyKA/etG0v4u4GNnGXUgGdr1tmJ5s1eX5vsboRQVjwJ1jQVse7z2MlV?=
 =?us-ascii?Q?mQCpMXdf3+uYxW05JW9Hy9usOjbeQgPb1jT6a/ENczEWlugS0JBik170iI+I?=
 =?us-ascii?Q?31l8zjeINybaz3hqzmNw/1vvfuJh2Xr8Z6vx4fn6IlN/ahcwaE3TfO/MTcAU?=
 =?us-ascii?Q?6LLegDtzuM1zQ04cA25ORrG/sw4f/eha/mV7aP620OupWYRY8+HSAJGexPun?=
 =?us-ascii?Q?QZo5zcTOoN4kRJZMc2qSSquVmAY099jFpHlqSCZf9uEbXV10FZ/St5oGKZFp?=
 =?us-ascii?Q?qO7GYUFKjsnt/8HUMKsCEvgg5zG+Pa4NlLiBHDifXKOGTN+ynyXUFvUzTVrS?=
 =?us-ascii?Q?iJhhfwOCBs3aZQ1fo3eUG6an7dcOZ/dcgP5iq0BcAIU6tsz9WUbLa0DP9oy0?=
 =?us-ascii?Q?lXOOKwv7hWHN0A6b88nvUnGQK37OizheP5O1DGnpWqtfWMnqedSW0iEX9FKE?=
 =?us-ascii?Q?4e9TFKTf1p0jZnIJwbUyoANcI707ZHzkpTxluYG1ImPILWQkXBbrHgjvxudL?=
 =?us-ascii?Q?QPhEqjSXUUL6nsYuLEToSgCCkL7FXl21wVJ875/rBDEkCYX949MK4QlUcqHS?=
 =?us-ascii?Q?aefURBZzW3N0KVBxZsnjED/Q6D6fX8GIk0CuHmqvNq+9a6tFYQ/B5YDSE6BF?=
 =?us-ascii?Q?bdizhjm15szxKl8mtMKOOQShfB/p1eZiTFCBoeKB0xqVOgZ3ESb6Xcmy7bj3?=
 =?us-ascii?Q?1Vexl8JO3c3oUjVPvCDyHREkn2r3Wu/HB2Go32eOQDePp8Sx95wRv2yXyYJX?=
 =?us-ascii?Q?Aj0FAiwqIlLpdx0KkQT7YtdMW2pF6RSRMGmVyWu7OhEauDtNqxr5eaDtWpUl?=
 =?us-ascii?Q?U0t7940ZH+uG0Dtjsz5qHMJ/ZZUxNemoG4s2scfoXpiYcwdIv48E0OlIMUaK?=
 =?us-ascii?Q?aBq7aXC6aTRVwHXL/NC8ktbcPBfhRCqLj6nWfmfk2vXF5a3yaTDDOApngW6y?=
 =?us-ascii?Q?nJxhfV+Gc+xkEYhGhgRjDIgJRauHqP4J5r/DEmm2R+4xQxq/USc3zVw62Ykp?=
 =?us-ascii?Q?TqKQwCi+NF4hprAPyLscJE21x9xRtlv8+YPaTllPWcoNm22bHw0ZsA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?drSoZP++Ggl6QxoqMkg2yH1+JPDPLT2ZJlu6Gk5KsAK9xqwGbyUFl7OaFh20?=
 =?us-ascii?Q?gjcDCJ4lusFnb2HXd0GP1PhV7vA+rNhcf+OXR20dkHS0y4dG3ayNO+mRzE15?=
 =?us-ascii?Q?gTDk/NMrqsABXTZqTBlvMSvHXylMUAzOa07pds4cKSncRSNu/4w9p/yFP396?=
 =?us-ascii?Q?LeebXbTbxtAGuNYwJxyrLlcJDvmtVRr7XNJauw0kYN836WnYFQ2yuznHLXzs?=
 =?us-ascii?Q?3fQWIBk34DW1LoNAkzTe4xf6M4wuWRahlC3Y/Kce/rrxMgcfSwI3Rw4VP0+7?=
 =?us-ascii?Q?/y6R1WNynkGQUkh/6JrfeiB0C5Y4TnnAUOnIw9vWI4aMUtSx1MDQ5ZlsPTCs?=
 =?us-ascii?Q?/upMGbislwbx9h/JLSUtQIcQf0BqbMHKESiBuaJ24ZfExCvlBlCGEgErGGx7?=
 =?us-ascii?Q?xhpCNleGuln4trZUguZJHB5VEsSUR4p6DnuQ7Hs7XXWhkx+HEdLWEKN3++vE?=
 =?us-ascii?Q?A+htet2VpLGUy/oI4kR6joKFp7CpunqQ/4rj3NzSoIF+7rZooZEo6YvsJKgt?=
 =?us-ascii?Q?Dzfyornp/qZ2WEfh2RlKe/ikbDr0GCXiTgIX1t1z8zNjd0F64AOM0mJ/SSSN?=
 =?us-ascii?Q?Amo9LctyyEPcdTYM9WCnikkVbeX4O6zaviAmz1v5lxsFdSS6ZWfYgW4xFlVD?=
 =?us-ascii?Q?y9UOxHPu7cr3w1Gcy2eQ1o7fF5euHdSDzviT6xs+rYRz+ZUScxhcw4N1Q9P7?=
 =?us-ascii?Q?fuighgUs4EoeGvP294A75iKr60cGFKNPeLKMqM8RNoSqi8Ivv428n1Bp98Us?=
 =?us-ascii?Q?oMJPhfnKAKDutWRq9wZYtzi+HGfjWdLX6/Fb+d7CeFqmih7mc2Theo28t4S6?=
 =?us-ascii?Q?yjf/uPloqegbyLtLgFUQlUpagH34n8v7na5Gg/w1m1x/Bmst625CIoMbxW2k?=
 =?us-ascii?Q?0IfmX8Qtpu405NToLzy1S4ztCa2+kj5VwDhNYprGrnm/wuUm7NsSEQsPw4tp?=
 =?us-ascii?Q?diq7d/jv/eLvGBjFzjbgXAZiH3QTG3Cw9WiOq5SvvrRs7enHhr17Lg12XpJm?=
 =?us-ascii?Q?43l9H6kSwTFY/3kY3O3IVcToKWEcyfZYLQpW1BnK5I6aszQp9z2LpT2fzFAP?=
 =?us-ascii?Q?GmiU3xEJa/+gn2clZh5r3aoU3ZVz8W0l/TVAjUmxbL9ilqBZAlZc3sloeC0z?=
 =?us-ascii?Q?ovIKCtp11ItyGPn4IyzzmNiMli4a5dbczk0+oPsQamztSn4MHks0xUdaePhA?=
 =?us-ascii?Q?O2/QhhbnbiSvzxDCT1/lyiz5hGi0nvC/spiKbr+Gwab2aFfTGLmQWUqHvHx2?=
 =?us-ascii?Q?AOIgqBjiblGEFkM+6x+LRGWbLzL0IZt+vIqbKDj5vss6Q+57odaMUZ9hn3K6?=
 =?us-ascii?Q?U7cN+GnB9uByu+KGex3j/dc+VZs6xa//El/GuFivb5b57UuYCnMYauKynYR1?=
 =?us-ascii?Q?14Waf2LorofrcIhZ/5c/wfz48qvaQIlaaokdPujgIIMQXc8a+aF6185pJI9E?=
 =?us-ascii?Q?d5oPQBh78m7vKvnje1ujTs3/JNfU6hIJMBhUADedGqzIfBsGgjiWzV7xrTVv?=
 =?us-ascii?Q?hDD2weJ2P7+xhdCGoq8+nKEk26sS732B6R18efT1onTvWyjgB2WhS5CRPDiJ?=
 =?us-ascii?Q?HHoGtPKU9+41NVEkiahVYElaRYtNjpyYHcjaPt8HMPfVDF95P3VzhYJKms6k?=
 =?us-ascii?Q?RgXX3Wzke6jvYod+8qD3/tI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: da0a9930-3dd9-45f0-b094-08dda8051874
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 09:56:39.9098 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jvOtqB9okSUavstfBTHiNzY7C1BJjO4HntUXch9eq94mOo2fIY82kLR699pneJOn+n751pD5MVcfFGiGCjs2gTgPVezDiCJYQ5WDxEJHUQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6343
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

Changes v2:
 * added more details to the patch descriptions.

Changes v3:
 * fix commit 873112db9ce68c38984ff25808dde726f8dd5573
   ("spl: Support selecting images based on phase in simple FIT")
   instead of fixing loading of image with bad checksums
 * add more comments about memory usage by board_spl_fit_buffer_addr().

Changes v4:
 * spelling was fixed

Changes v5:
 * improve description of regular malloc() case

Mikhail Kshevetskiy (3):
  common/spl: fix potential out of buffer access in
    spl_fit_get_image_name function
  common/spl: handle properly images with bad checksum
  common/spl: improve error handling in spl_fit

 common/spl/spl_fit.c | 53 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 7 deletions(-)

-- 
2.47.2

