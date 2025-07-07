Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94431C71130
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 20:37:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6367831E4;
	Mon,  7 Jul 2025 22:37:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="NSgrPwV5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1F5783253; Mon,  7 Jul 2025 22:37:10 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 410FE831EA
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 22:37:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pwyv0MXJMnPXobqG+f2kRoIme7K/W/dVMyP3fpL6aC5hu6iePFJFv73U22PVUu8ns2LHWqmaP60efIf06euj//ZEzI7Luvq8oBaVolj15qU8r5WSlf83FkyWXKXawexvPt2UiOOHVg5r93rx8wUEGCHIdsvhfTNUaoDU4uCYWNs7YL7Bwg4vhFIBRqXQqSV7XsfTj++n4kttbX3tZMLol1pjqz3TqX/rx387ybzS3vKrTNI2t8aLavsqHL8VKBnJvB3ieer0LOXUfMNFGItBsg7G8nQm1Igtdk1jn9v13MAhSsCfbYuEdcJoRpnPijju6gsABWMGSYcrDy8bqojDkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1x8zt98eJuVhYGMZm2AvyUQ+i7TDP4G63K4Wae2Qu6U=;
 b=x2tORFJRmZHGi2aTRHCVD/Xb3Q9MAy/cIFIPZB8eeBcJTXKBuPnm0ZFFY9Sc0DHD1bc9InZRvo8kjZ/ciRNqcelNZEs7JXRCJXsENUGBEP+xegWuQ2LuE9tXf83Z7V7Vl53lhiVg47rr9thNfJ9M+zcOHWEmbASLiMf3nq8ArhlzpbA7KlxxUcZ10SZJlVGChO4U11T2M+FftPnJh5qBU95bSd101J3P09WCzkupEzF9SA7kcsax0FJRDw2cQwFFAQedVyy1owF2JbFEe43EEw/z1LpNN/bQUH1Brxg4Y9/eCdpCmHrCg+pe2yiQthPV383VDCfUrBEv/qU6OuZmyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1x8zt98eJuVhYGMZm2AvyUQ+i7TDP4G63K4Wae2Qu6U=;
 b=NSgrPwV5rlUIVFm4I4/VVHdvizvyFxTq3s7drqzUsskaf9PLgU7fzR7VxukI1yD/ibrxirAAZl19FsekNgpHSVAR5wUXiG3odH7cUWfwfRZFBCUa2cZTnz9F4t+IfS4g/t5wfBhvKDRjBrGqb+H8rhZIQiQ42nNBC+VPRHLNo5A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GV1PR10MB8860.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 20:37:02 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%5]) with mapi id 15.20.8880.029; Mon, 7 Jul 2025
 20:37:02 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 1/3] move more limits from kernel.h to limits.h and
 standardize their definitions
Date: Mon,  7 Jul 2025 22:36:53 +0200
Message-ID: <20250707203655.613340-2-ravi@prevas.dk>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707203655.613340-1-ravi@prevas.dk>
References: <20250707203655.613340-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0073.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::23) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GV1PR10MB8860:EE_
X-MS-Office365-Filtering-Correlation-Id: d0482407-85e6-41c3-3c4b-08ddbd960730
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PwaOO7dGBMKUBe+9j+cZNQjVLmM5heznIQUzkmJXJmy5lRc7HTGw1soW4tXZ?=
 =?us-ascii?Q?s8OspKyGTwJEcLBX2HUYFw8zVfPoHGj8xtZtK/0o58M79X9HLsFrUmmg6pqK?=
 =?us-ascii?Q?sZk8kQA8ogTkpgoTHrX/mT5nLJLLhRVAGJoGsAOBosjyhBzjuSSJCcvMW229?=
 =?us-ascii?Q?eF2S3tnEapuahCkMBfbni7l2gjgNlLJRstd/Op0DVlKOrmjUJtY5JGGw/Je0?=
 =?us-ascii?Q?OvUBuinwcawKgt/rhSU19D7OfDNinXf5hDAS5YPbuiND/DI8kW2dMIuTsJSf?=
 =?us-ascii?Q?Tz/aYaqKNAtQTv0bEb5yJ8+7T3afUUKlPTH24fFcRI9vPhAbW8pbj16z4qXH?=
 =?us-ascii?Q?UmUeJz1et87hczSP3jvq+ERUMNR7+15DAHRrFkhzA3p9n4mB7nb+JY1/ZWPe?=
 =?us-ascii?Q?jmgKUVZwfUMEJkHKlEwuQJ8XKTPUyIcCCjiBoDkcYKQEAOIJPLaKfzP8ZVfS?=
 =?us-ascii?Q?pQbZ61C374puf0zDzREYSAwSTP0slrfYBHtiSEAYfRiHracqkbKhqTw0JkXH?=
 =?us-ascii?Q?vKok2TE8HnirSPh38av0fqfck57AoL6iQieC4Z9WMLCEWjmybF3xsJHk4/2v?=
 =?us-ascii?Q?dbfu88TwWwGkvu/LpEXW2pfe0CXwZs9SIiMj4xYv7/fErsk7g2P0pYV/0sgb?=
 =?us-ascii?Q?pZn6gt363ggf+EjfB19u/JWNUMKxfgmGl+IO/v61lYGfyiu6u+MMZjO8T+3L?=
 =?us-ascii?Q?9GKddUJopgW7SuaAwwjkxeIksoNChkOgHhVaXfvUySYAh4AMHev+S2VqC7qu?=
 =?us-ascii?Q?38SPm+28zAiug4XfcO5dRxvNqQjZ9skd+fPUwKiVPWU39vVPAkk7/4U4EOPu?=
 =?us-ascii?Q?eBjkzEAYoc+v6IJ99P7FQnPh7myLRulr+kVW+kyw5OwnS1dTF6s6oLqwJ2Op?=
 =?us-ascii?Q?PRY1VBZ2DTAto4crZt2CSKGZjTdbbxP9A8UdlgmIuJHGLLMkHQHfLWU75AmM?=
 =?us-ascii?Q?wKy0G6X9d6C0z/q/JMPz/BoSKjqOlLdfsE5k+a2ZH5AT9Tc+2PSfRKvz4JxT?=
 =?us-ascii?Q?SAvjiMf7kSoS/WjBaFhlH+KfXfiPmk5H/7F8FIAqbHfdz+JwAfTeI7ZD/OCJ?=
 =?us-ascii?Q?e+3nnRYB1sMzTPrIqzlBDb2YIOjSJvJNpJzAn/JwtKHmp7kvD6cQs2d434EM?=
 =?us-ascii?Q?AUAVVR1n1XbjPt+DvyXdgOnmLMp73OoJ8s2cuJFCzQepTgUQl+KXkxa1TON4?=
 =?us-ascii?Q?bVvePMog9poEllf3kzNzCEn+0Pe6IwlPN0Pa/uwEYSkBMCyrGDrI79yPjsGg?=
 =?us-ascii?Q?y9kARTTvsAaTD3kIte1P0POwECnRJ/Qo+B+OoqKDX/FYuRQ/KuD+Lwvf3tht?=
 =?us-ascii?Q?z6BvJTMLeG61Mb6H8gCvdVn3XwYDuwbtCccI3TaX7DE1229Hiz6Pk99OoRjw?=
 =?us-ascii?Q?RcUdNv90ZC2TCykuf5aLFbF1gQYP6mK1znrueaHOHQckKN9u49m9yrP8RPgf?=
 =?us-ascii?Q?Zyiz0DQYprq0HQqciKDsZv0NmaBKdwNRKr6Dfgth0iBtH5M2BuPVmQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XZaUMhRZmoUkQtwyvhEE6YH7YmJd7jBeEvj95ellutgBOJ2Zx9fWDIF/c9g6?=
 =?us-ascii?Q?zFQ2sCFHFnMCedFAeiwanj6Df0LqN76et3AKwTlUZ97I1bJUiOW02gBnyFeG?=
 =?us-ascii?Q?ZY6otzw5npJNQeTgr0T+L78QIcQEW3Z1XlZ2cDvvxv80s/hAnNyeQaSd/Z/p?=
 =?us-ascii?Q?G9Up3AxMXs1Tj2T2fXA0f9Ovl2HvUBsSm7Ax9d/m8Jw6THoeD6/Lu9UxJYG7?=
 =?us-ascii?Q?9Yh46vY3avOoEwp3FiSi+uL7P1SFmftcMxUpGh+RsvJWvLI9LiaPdrHntO6I?=
 =?us-ascii?Q?j7E6eENi+ho2IqCDzvUXWi3DsOHzezhOxyvwrUW7grsuYdsg+D+tyfxKGdNI?=
 =?us-ascii?Q?WtjVN0Kr47r6v9LtKGf2NIdDc+FBqsT0NDbVjR0Nl8XX54rvYB/Gc8DYy+Yb?=
 =?us-ascii?Q?24G6mfLEpvM9hdI6K8o570lGYWOwr9MTwgo+lp57xpBtJEAUH3mLYT7Af70t?=
 =?us-ascii?Q?TsD3x9GhlMgOcaO7s8zFXAIqFRkIQeRU8R43fwNaOKaprhOBdBqh978Tha3P?=
 =?us-ascii?Q?ZU1Zddcps8GZRilE+vn9Gm+fHPTpagyjH955xXY1kSDYscmVXpLsmXEbdNHL?=
 =?us-ascii?Q?O6xpoJ0xvZ5hdOkM/0GmOMMZgs9zMHsej5R9tcWG8VinSJKp4tdjLLEdv5+z?=
 =?us-ascii?Q?NPHIM8mpXLJ0CUDWo1/uC/HHndyEkfFifOe8ndCf9tIjdMEQjqGf6oggV3Fw?=
 =?us-ascii?Q?vnWgKsxgnilsLXayuW+SeQ2bnY/f5TYilr93J8Ve0nPrDaDpBtWQqI9B0HF4?=
 =?us-ascii?Q?JZLfuykMq4y2QeIf4Qq9/3K2y3NUrwbhMdaI9seBJcYegqGQdtdjjpCKYDEu?=
 =?us-ascii?Q?ubBQdHoCNtfcTI8eGtUVKtuvge4eyIXcKx+JAxGvuwkUuD8l6cPiESFuMyd8?=
 =?us-ascii?Q?ZO+uZGjHpRudyv7t/xCkB6Bt82fPNbzaEJg+WvVKPMS46WBJlKcHLeMlBbr/?=
 =?us-ascii?Q?rqE4W+fBY85Z+L/JzTbobcl+r4B3b7iZPkIsPlk4/ZKGxZuXN5VU9lYZvZMu?=
 =?us-ascii?Q?eLOS/oP7+4eInQyGBK+V/j4KqdtFh4GL+ssv/FYQpoWFXHt90liDlgLksxbU?=
 =?us-ascii?Q?mpWHk4ohIe6Y2K1CXw/WcbCb2GC0CHy+nT7P9TM6+VJ7cS1CI2ovn4FI8iRP?=
 =?us-ascii?Q?oaTbsHPhilk46T9vxd3V2wSYwyT5ab8O6hKXzscdKOsDhMZYg7cbjY2a5GM7?=
 =?us-ascii?Q?KLA++QdvQmhjsiM5CwrMu1BGW5QHjSr8jQq2t73WKv34+2NlP3CtRrak5+yW?=
 =?us-ascii?Q?tGTjvIhF+STuuB5s3+X5xm0jwJD4dzC4PX7Rkb4X6UtDW3YENP8PwrQPnzRm?=
 =?us-ascii?Q?NJtbUzMJJNdYVXUTnOw+EPtdVRRKD/4ebU8yzkaTeOPEZfwfv/4JfKjVsgNy?=
 =?us-ascii?Q?K9zkwwwFRlADJRKtpwP6Z7cCNCKouWpyneJLd75oCrBTBHp/0/rhxxhpAW/F?=
 =?us-ascii?Q?Romoe9FTzQEYJmC0MyPbPqwA1FjuzHxUsqDbscKS87WjRLj5kFtAHBWXr2vn?=
 =?us-ascii?Q?E7mKwhgKtumHXKS5BTfdpFzZTeivCwNGnfIYEXaMInmIXg83fal5a7mrOkOW?=
 =?us-ascii?Q?l00OkNddmEL+1B4yEe9/vmy/UkDMiAnZcJvSi3fvstFVxlunhjfuJGBMC50H?=
 =?us-ascii?Q?8g=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: d0482407-85e6-41c3-3c4b-08ddbd960730
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 20:37:02.1642 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1cLpcMwNhJ9b4cph8y0rcW3HDdlucJHqF6H0PVRqcamnaZrsk3QOHvJrQeMT1JPfxLCzElLTBsyH1i+fYKFq9V8aQE6tmr155jkm0trpRgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8860
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

In a customer project that was building a stand-alone application, I
hit a problem related to the fact that our LONG_MAX and friends are
not standards-compliant, in that they are not "suitable for use in #if
preprocessing directives"

... /toolchain_none/arm-cortexa8-eabi/sys-include/machine/_default_types.h:25:31: error: missing binary operator before token "long"
   25 |   || ( defined(LLONG_MAX) && (LLONG_MAX > 0x7fffffff) )
      |                               ^~~~~~~~~

So following up on commit 13de8483388 ("mbedtls: add mbedtls into the
build system"), move the rest of the macros associated to the standard
C types {signed,unsigned} {char, short, int, long, long long} (and of
course bare 'char') to limits.h.

Make use of the fact that both gcc and clang provide suitable
predefined __FOO_MAX__ macros for the signed types, and use a standard
scheme for defining the FOO_MIN and UFOO_MAX macros in terms of
FOO_MAX.

Note that suffixes like L and ULL are allowed for preprocessor
integers; it is (casts) which are not. And using appropriate suffixes,
we can arrange for the type of e.g. UINT_MAX to be "unsigned int" due
to integer promotion rules.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 include/limits.h       | 30 ++++++++++++++++++++++++++++--
 include/linux/kernel.h | 11 -----------
 2 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/include/limits.h b/include/limits.h
index 1d0bbf69be7..4dcfbe9b156 100644
--- a/include/limits.h
+++ b/include/limits.h
@@ -3,8 +3,34 @@
 #ifndef _LIMITS_H
 #define _LIMITS_H
 
-#define INT_MAX     0x7fffffff
-#define UINT_MAX    0xffffffffU
+#define SCHAR_MAX   __SCHAR_MAX__
+#define SCHAR_MIN   (-SCHAR_MAX - 1)
+#define UCHAR_MAX   (SCHAR_MAX * 2 + 1)
+
+#ifdef __CHAR_UNSIGNED__
+#define CHAR_MAX    UCHAR_MAX
+#define CHAR_MIN    0
+#else
+#define CHAR_MAX    SCHAR_MAX
+#define CHAR_MIN    SCHAR_MIN
+#endif
+
+#define SHRT_MAX    __SHRT_MAX__
+#define SHRT_MIN    (-SHRT_MAX - 1)
+#define USHRT_MAX   (SHRT_MAX * 2 + 1)
+
+#define INT_MAX     __INT_MAX__
+#define INT_MIN     (-INT_MAX - 1)
+#define UINT_MAX    (INT_MAX * 2U + 1U)
+
+#define LONG_MAX    __LONG_MAX__
+#define LONG_MIN    (-LONG_MAX - 1L)
+#define ULONG_MAX   (LONG_MAX * 2UL + 1UL)
+
+#define LLONG_MAX   __LONG_LONG_MAX__
+#define LLONG_MIN   (-LLONG_MAX - 1LL)
+#define ULLONG_MAX  (LLONG_MAX * 2ULL + 1ULL)
+
 #define CHAR_BIT    8
 #define UINT32_MAX  0xffffffffU
 #define UINT64_MAX  0xffffffffffffffffULL
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 9467edd65ab..f26274fbe1d 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -5,17 +5,6 @@
 #include <linux/printk.h> /* for printf/pr_* utilities */
 #include <limits.h>
 
-#define USHRT_MAX	((u16)(~0U))
-#define SHRT_MAX	((s16)(USHRT_MAX>>1))
-#define SHRT_MIN	((s16)(-SHRT_MAX - 1))
-#define INT_MIN		(-INT_MAX - 1)
-#define LONG_MAX	((long)(~0UL>>1))
-#define LONG_MIN	(-LONG_MAX - 1)
-#define ULONG_MAX	(~0UL)
-#define LLONG_MAX	((long long)(~0ULL>>1))
-#define LLONG_MIN	(-LLONG_MAX - 1)
-#define ULLONG_MAX	(~0ULL)
-
 #define U8_MAX		((u8)~0U)
 #define S8_MAX		((s8)(U8_MAX>>1))
 #define S8_MIN		((s8)(-S8_MAX - 1))
-- 
2.50.0

