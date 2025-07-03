Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCCFC83030
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 11:38:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EABB182EA9;
	Thu,  3 Jul 2025 13:37:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Eda2GGJ5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4907182F5D; Thu,  3 Jul 2025 13:37:43 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B88182EA9
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 13:37:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZHNHc0kVyNBdpXFjNUuIjzPS62eTGr4GbxnmVA20huItvwGvnuM9Z2QyEQPSFdsIxMqolRlURvukWPpjpj5qU0I7OiXLEHopFD8oZRwjTF+Zh3MeiChgJbFR+IFURUZMc+W6RkElMosm8MNtXkcBySMN0SpXjH+bzuB3mNEHwzWzOKib5UV2cmaw4+4fGw3u/aSwdAYPJFNRX0M4rSmSozelg/p38dYX2Uen3AuHI4MnAfH905Ynol4DE39OwkwvDS7eb5/wIDADfLPXvc2SuTrO4gjowCpardHz/si+CFjFj4vvulBGrMcDIoPhilKfEvQs4EAnkEIcZ4OSKZGdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyx1azTsGjuIsw6clgLBF+0P6YtvZPUYJ0W1s1KWRNo=;
 b=ebauy/rhTFFBddHl7rO694jKk+YdGNZDOrzMq8BNiubVbdFG5jrbNfHJB7xN94aVjxAMz8jhFuuHCcDRmB5KNX2S5MPxsB3phX0bh3cR5DPlhrlWjc6KLXGmlxiZyRF3GoDF8UnbqZ2ouA8yc9qN2BAkfHJLiXDnZyRXLaTbn9wZEnKg+djteg91LKnBDKAnsRbC/RUsTVsCTwv0eirSCyl1zZsptOWMJiS6C0KJxBQMATQEntWzlp40ULIMRSgbFw1TvtQ5RI4lZxJiV4pcZh02W0E7s2USVKRerKvHOfQ8Roa8zjbzqWVXN6OAQaGPa1N40flkR4pAF6u3OrzM7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyx1azTsGjuIsw6clgLBF+0P6YtvZPUYJ0W1s1KWRNo=;
 b=Eda2GGJ5zRRTFVoeeYTXSw/SezoxdrBvLjWgAZSHfBW+2aB/1f065vBvGZiom4ouoTvGldZ7H1FCbtdJ9MIQpUQXYfeA2odu/6y58RYx2RTZl8rGC25sVk8rNDKpuAKCt69K2vqTMRHp0SdYahUJp6WLD84q0T47mncez0mc41c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS2PR10MB7573.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:544::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 11:37:37 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%5]) with mapi id 15.20.8880.029; Thu, 3 Jul 2025
 11:37:37 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 2/3] move limits for sNN/uNN types from kernel.h to limits.h
Date: Thu,  3 Jul 2025 13:37:29 +0200
Message-ID: <20250703113730.531225-3-ravi@prevas.dk>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703113730.531225-1-ravi@prevas.dk>
References: <20250703113730.531225-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0068.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::35) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS2PR10MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: 04fa49eb-d9cd-4888-b241-08ddba26029a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yeoBJLGVhYSBJyxyc+3Uo68TutJuUjah+HqpISYVQGGoP9St8lUre6TfU4rU?=
 =?us-ascii?Q?swM94732H1bFhyur7U3alCzycuR+wwE5IHX8hZvzzmoZMQw3KNbVmL/6Eakq?=
 =?us-ascii?Q?8IU3f2NxQvQ8ERWmVQc/lSkPUpBWxfACxrGv9zvUmimZ4wWzAdkf5mnZ9X+P?=
 =?us-ascii?Q?4N1U0mtoIa7gk/2fAbsuwi95VALafNQIhaR6HbTk+22qVS7zkI2QzyMq8cN6?=
 =?us-ascii?Q?q639pcCPHla2pemuywjmbAR1PaQGsg1EoCsDisogKBe19+tzp3Jr21j3cVIL?=
 =?us-ascii?Q?A5JdmzJXv4Q7eTLv7CIwduIu2g1aKYNyUXI+/wIQ7xCSwIwNeyv9pXA5rZ9U?=
 =?us-ascii?Q?qPtKOz8x3KhE2OKmPbQe4+p9B7nfsL4O4LeLmaSz+AKUX5M8qhqI94WU1hbM?=
 =?us-ascii?Q?QUfspQRY2aAZnWyJ0NzN3aSS5Cnflx+oIkdsVFe/ZhVKNC+4ZDfuhNblizW8?=
 =?us-ascii?Q?drpR+RU7vnqDDOXJDT3QGawjuF96XAg6xa2B5JKGLFfTagBclWbpxJ2H2M6Y?=
 =?us-ascii?Q?RqFIznJuQ7tzRJx34ygHhn5sNxmw0y49KpDG61eAOoBAxWxFssxVvuYBgkac?=
 =?us-ascii?Q?iH9lqJ6MrGMCiQPqkystsumrqC+JkHAHL072FoNpuBB44C9pXtic9awVOAdj?=
 =?us-ascii?Q?EIscuPV253Wt2s5JqADW3//VwZtbfRWULQr9vlAQ5KqEXz68P2NzKGlCRHVN?=
 =?us-ascii?Q?Ng50o06g3l6d5TGlcaEprTF66XW27cyRad9JF7EBSwLwR66/hV2HWj6Ae80G?=
 =?us-ascii?Q?E+mzlMzfUKZH7lhMPmwfc+6nu++CWB7nvTgFm+aAW5ZFabIKF5DmGLZZCcNR?=
 =?us-ascii?Q?eM2FY2Gu5TFbBwBe53bcaP5OssHLfJZfX99y8Khi4rdV/vQIYibztOxM45cK?=
 =?us-ascii?Q?kZnQYsZXUQ87FSZqoN5NzYyI+DbUJ2Wl/1gds18EheAU6hd72BEM+XigjgbV?=
 =?us-ascii?Q?F0Er+6vIgPizc/4a3yf+gAioTN5nFKpBTLlSWILFaJLXKtmx/D7ueUoyyEYV?=
 =?us-ascii?Q?u3aW6DjgTJbE4GUCdqOgOeRPWAcXVOgq8YlksIK0mP/Oj8tZocC6ylmxC61O?=
 =?us-ascii?Q?T54wLvcjl3xNSBRsIs6qLyrAwOOei+vXg04sgkOSCgxozcv3PwoIXD454Vpu?=
 =?us-ascii?Q?V7BZkfgCsrxFzogGE2eWgEhP4cbVCT6hURzcMvUzeiQzgBkgF8cKXkj7wnLt?=
 =?us-ascii?Q?4e0PGOFmu0YMJgmdCTlMaSl/agwYhDdECX+DSIc1wMVcIHS/HuHnpqqNmAun?=
 =?us-ascii?Q?x28heLfHok0gbu+tj/FEO0IHaps3x7k2jfwF5t9fQqvVCQpzF/wjP91445e8?=
 =?us-ascii?Q?+rgoiLbVdMaVHyzZTwMjoQcS8ECmTj811oE9fgMl2RY82E0g3oVJy6W8AdOj?=
 =?us-ascii?Q?7wAgGVju9swomacBJMkmioifeKD1fttFNwfCDqv9gZ7m59AwnId77a+i25D+?=
 =?us-ascii?Q?EeYtcmXY1xbh/R1FuP/uVmSU8eDZEvnGcY2GBeCcj3MZDKi7enqH0A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8Q5c6KQjhYBF0aYlTdDdclW4wy+edce9u8ZC3TFPYttLO53U0RewUwRkMU0Q?=
 =?us-ascii?Q?5sqPOZ9cDIok402nS2M7EByNjCIBlCrAYDJUYFeEfvZO0djZntGhfHX0K/j2?=
 =?us-ascii?Q?Fsht9oVWjfnPyPh1xi2L3gtdQ7NIeBsPWmA4lx7GIlgVMrci9Y/uX9ZGdd/l?=
 =?us-ascii?Q?S4vG6PFaKStJcSB878T2KGretguFFC8w/mjCOt7qZ46q0NLD6xzKiiNalbXm?=
 =?us-ascii?Q?TkXllNUcEpd4KxLBrMZRM7pIDlOjiPwT43Kz6afj264hj8LmY8gCCtNl2aU5?=
 =?us-ascii?Q?fnAyEL4vO2yT2m+7Ri0pVzk0RL0oHuSzKtr2sxi8yk8WlkdwuuWul4EaQY4J?=
 =?us-ascii?Q?7IZ+8Xrp5Y7BBjx7KSi12sGuHAzohOmNszay7+Kg1Gut5gyqRwcOkFTTL+pG?=
 =?us-ascii?Q?VsAHrcS/8HxOHFzB5TWkFxyAVhJkg16H652kt73R6XKUWbu1NfGilOXI0pa2?=
 =?us-ascii?Q?4oh8nZbI+9qLcctg44gA1kv6CPBRd5Xwl57vLmTyheF+AHedGoJ50xFYoqTp?=
 =?us-ascii?Q?TU/IjoOGa1igLV30i3KQSeN6MmjTSjMLBqoM/2CbNOVLO1TbOvnTcXX/KETs?=
 =?us-ascii?Q?Z+Efa/QnHoxkb+1PdLIP221QYHOL7iWmcYtBALRm29iThz7VUlyrpvcArW2f?=
 =?us-ascii?Q?r8IX38sqZ4g8k9JmsaPR/Oa/7WmhiAl+/lNnhN723gA5bVTl/kJFav3++fno?=
 =?us-ascii?Q?sP7hv+FEsF6NJ4wYoAFQJqGNTofc4CszPtGo5gNDjXyAkkwTx6w3CewFwJx6?=
 =?us-ascii?Q?EzuuPtz0p+Mkf23c8eX426OYNGY/GBJ9+WELb7d4tzoBsvDEjFCsRYXZsRHP?=
 =?us-ascii?Q?SvkOzaK2NbKfbjIsXSdcUsvo9hQQHACKULvsggEMqwQQr+fn9gxfieV7zePR?=
 =?us-ascii?Q?YExATuHHivwEkcYx75DoXXg03KNrsr5lo5bRrFdpVNJoxFQu96MS5PtQIoIe?=
 =?us-ascii?Q?do1TqHRLvOIDeol9rW8ONW/FW7kgIzDPhA8CFapa1JCPHjYDjaM7/OraR/kC?=
 =?us-ascii?Q?BrTUN6xxRPAlZN6XLfGBfX9YiTk0HLc1WjInNSqdfCtAcA7eq224Za+LRgXB?=
 =?us-ascii?Q?bh2xvtOm4wRXLN4G2bMyd8weoLt6IiUPU9f0DvqYVoMLbcKtthPzKAgZ1lym?=
 =?us-ascii?Q?o9fqVAjCnrvY3KdWOqwmRwKf7CXfQXI8e90YQuSAAAqBlC0jpZ/TgcZm6YYD?=
 =?us-ascii?Q?9PeRbNKsnwaiNu8XEGbsr6SUBnATChiYnxRTpe9OEOFn6uaR+Cb/gZqeEGRU?=
 =?us-ascii?Q?nuHDMkKwwk8VhoQy5wU9Z92JW5u4AweNDVmc6hXEv0kftzgeXCajF+7Z6UiF?=
 =?us-ascii?Q?943laHV8AY1FxYjOBkHaUfgnGrsXbwSzvLC98yilOt4dfH5WQjeDD+ax+YzI?=
 =?us-ascii?Q?aT9hvi9KAP/doTiKLgCqhlNITtJx4FOYL3qx5rXBg19tIxAZvymuSYujhMvR?=
 =?us-ascii?Q?nvd4c0GdWlcF1mXtlTRjGj8sS2N9VjcNcwoN0+2qVGyUz9VLJM+qNKICYVPe?=
 =?us-ascii?Q?KB1LKaAH4TT1K+QJDHTW6+YV0GnLrOYUsWAGUP3sJuNCxLVb9VHZkHHzeJ0y?=
 =?us-ascii?Q?lf9jrCLieTeYvhm7kd06sK1XS1G6Q5Z1yJjbiPep4B0khv7TnpRAbUaj7i7Y?=
 =?us-ascii?Q?ow=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 04fa49eb-d9cd-4888-b241-08ddba26029a
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 11:37:37.2683 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t57l3o/fkLUhLkg6tUNj2rtc+q11J+3QB+2Y2391pbJOhMvy7QnZly+y7MIkrj14RYMyi5LJqLkq+OezMjWT7cqctAKaJpXirwylPXoHtlg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7573
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

Since we define the {s,u}{8,16,32,64} types the same way on all
architectures, i.e. everybody uses asm-generic/int-ll64.h, we can just
define the associated limit macros in terms of those for the
corresponding types. This eliminates another set of limit macros that
are not usable in #if conditionals.

These type names and macros are not C or POSIX, so there's no language
violation, but certainly a violation of developers' reasonable
expectations.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 include/limits.h       | 13 +++++++++++++
 include/linux/kernel.h | 13 -------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/limits.h b/include/limits.h
index ec111023e00..aa30f5dc8d8 100644
--- a/include/limits.h
+++ b/include/limits.h
@@ -31,6 +31,19 @@
 #define LLONG_MIN   (-LONG_LONG_MAX - 1LL)
 #define ULLONG_MAX  (LLONG_MAX * 2ULL + 1ULL)
 
+#define U8_MAX      UCHAR_MAX
+#define S8_MAX      SCHAR_MAX
+#define S8_MIN      SCHAR_MIN
+#define U16_MAX     USHRT_MAX
+#define S16_MAX     SHRT_MAX
+#define S16_MIN     SHRT_MIN
+#define U32_MAX     UINT_MAX
+#define S32_MAX     INT_MAX
+#define S32_MIN     INT_MIN
+#define U64_MAX     ULLONG_MAX
+#define S64_MAX     LLONG_MAX
+#define S64_MIN     LLONG_MIN
+
 #define CHAR_BIT    8
 #define UINT32_MAX  0xffffffffU
 #define UINT64_MAX  0xffffffffffffffffULL
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index f26274fbe1d..d3d979834ae 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -5,19 +5,6 @@
 #include <linux/printk.h> /* for printf/pr_* utilities */
 #include <limits.h>
 
-#define U8_MAX		((u8)~0U)
-#define S8_MAX		((s8)(U8_MAX>>1))
-#define S8_MIN		((s8)(-S8_MAX - 1))
-#define U16_MAX		((u16)~0U)
-#define S16_MAX		((s16)(U16_MAX>>1))
-#define S16_MIN		((s16)(-S16_MAX - 1))
-#define U32_MAX		((u32)~0U)
-#define S32_MAX		((s32)(U32_MAX>>1))
-#define S32_MIN		((s32)(-S32_MAX - 1))
-#define U64_MAX		((u64)~0ULL)
-#define S64_MAX		((s64)(U64_MAX>>1))
-#define S64_MIN		((s64)(-S64_MAX - 1))
-
 #define INT32_MAX	S32_MAX
 
 #define STACK_MAGIC	0xdeadbeef
-- 
2.50.0

