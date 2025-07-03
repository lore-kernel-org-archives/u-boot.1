Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC6AC83030
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 11:37:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AA4182103;
	Thu,  3 Jul 2025 13:37:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="fwzAIL0H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44D8182F49; Thu,  3 Jul 2025 13:37:41 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 744EC82063
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 13:37:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w4ZM7saKAmkP7uVTqN6SRPmf1wKIsUbmsei207XFoyKKMWupVZSKHWgjpsc7wPUhtzDrTyctR/11ZXE1gpm1qLO8pHx4BJTakzhmcRuAEbUJD31riCMjSQtChmf/Fs1Hi5m0PHfVrLn2KyWGg1aFFbArQTmLI/S2jVzFwbu4bq0O1T36j5QuIsl5ol60VtCK09TxH/24SB/Ycl3hV0/9G7a/m3N0QN3NWrLaM+zKW113avMEy96LxUoix+ufLJOGkg51BkQtMtmueq+vN/4yXxiYKhoAZR/VknQQ0oQ/Y5Au6IQ+Aph64TZF5NwjhGPdKVBiVS3LaeC8fDIEr0EtOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4sPErHfdCpny6XO1RGaJI6QqxJXjvvfVFkrNeXUHtY=;
 b=V4XZYb3j4OWlJkWmxjphS9R26wtifZtXcrhCXvLgTh/4RQPg5RgM0yGhGhyXjQPgQD392nWUcNo/A8g2g+n9Va/7bOxi2jkmczpHq30Akey1oslc/iD2yewbv4VkcJnEUpiacdAJh3XQBsw983YQticSyj5DvefaXvAX4QDHXkxD2S4FPlaJ3yaBYMlXb4w6ZRVLeFhfvACFqas+hxydU7ic0UrieUqWrEWuMfPjEvODmRcwxul+k6P2Dqnf2diV/uRzII24KV8m+fs1czx2WnffOwHGE9CkPKepC348J1LfGgaCAre9+uu7mVcESDIvyxz6sZ88MTPYVstzWGXfQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4sPErHfdCpny6XO1RGaJI6QqxJXjvvfVFkrNeXUHtY=;
 b=fwzAIL0HTjWgMUpFyY9y88oQKCLAXxxaih22WZDHY1LT+VqBGjFZzdzme6z9u9erg/hOzNo8s9pAuDZsxOUCHbIZ75+aFjPR3+qj9a/FV8ukPxO7CRT4UCjJ6iZen/xDpOv06xpZp76V/5zigPEc1lkKL9WxrU6nekEUKvv0n/Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS2PR10MB7573.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:544::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 11:37:36 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%5]) with mapi id 15.20.8880.029; Thu, 3 Jul 2025
 11:37:36 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 1/3] move more limits from kernel.h to limits.h and
 standardize their definitions
Date: Thu,  3 Jul 2025 13:37:28 +0200
Message-ID: <20250703113730.531225-2-ravi@prevas.dk>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703113730.531225-1-ravi@prevas.dk>
References: <20250703113730.531225-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0117.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::32) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS2PR10MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: b0d32bc9-c11b-488c-0383-08ddba2601e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Kq9oVx22eVPi15HUYRcRZ2JVupO5UcyrLZYhJYjnxQVsOEAiwLgiyRJzi++6?=
 =?us-ascii?Q?NTExXMa5Oj+1EebGJ8g1aZ7dX0JS5GIiKCp1Bnswu0Ti+YZtn6ygzKGf5Myp?=
 =?us-ascii?Q?Hq1lMZiSR81apkW29+wQzbTfqvHV4QGYBr4+0OWiq+Zklsf3rluwHWPZlCC4?=
 =?us-ascii?Q?7maO+JdE66RtnaRz2JQL6WuRGKla+T5kMqXM0KT+bCXXZ8XUL6BkY4WTD2q8?=
 =?us-ascii?Q?KQpfYVqYunWyb85PgL4oSJTFDjqrZulE2A4IPThveXyXaAeoDiN713somqgM?=
 =?us-ascii?Q?FNwXiUXMLCP7nnkfd5VwxmyNKNpT3jf/3+N00O4QFUskPuPuzIBXcFwzmlCL?=
 =?us-ascii?Q?YMoDlraCbsl1oicnjmc3L4D+DK8UKZ+/JAejEqN3unoXVvLkV640k5DjJD4j?=
 =?us-ascii?Q?yWqGqb67rqaprQDiUpfF6niYc3Mt0dEupwYXpKqAWQ5bxfbGBRDPsWNTw3bT?=
 =?us-ascii?Q?+uNVbjiSFUMjotuMSLUgloB8LHIzrAuJE3hp6/qphLFC8JZkA2iSzjXtzcu6?=
 =?us-ascii?Q?sFkOiR2W0s4ycxO9e8Tjf8qH/fVzBy3bFVwXev97X9qGBEUuH7Rm1zkUe/bG?=
 =?us-ascii?Q?TPpNa7kqNVbz8TNQmJk0nWs0gHDpn6Rj1Ch0Xz7slSk4zxnY1YIvfRR39geN?=
 =?us-ascii?Q?u85hS1wTZo6QR4A7BX7YSC3ggcccqBeUg56vlvyki90dgavIXAWgIAeJvnec?=
 =?us-ascii?Q?dCZMkAIearYzxMMADNwb4UBVFstEgVdY2Ipgjmac14nrtD2QDssolQqV3YN7?=
 =?us-ascii?Q?45rMXZbW2YmzuRiA1sxQsT6gDSf1NYwQ6eoDRXoK0GSsr7AnhKYgl4ittsPJ?=
 =?us-ascii?Q?3sXIbi1R3QmaQilKnIrX00gkaNnCJrnj9Cgu45AEaPmfuwX9zDi44C3gnoKL?=
 =?us-ascii?Q?+c5MRIKORkYyKN5yIrZvG0kpFC5av8dbwijW12G8VswmDw1BvdcLSz5WTlB9?=
 =?us-ascii?Q?5Zcup3aUVJWc5OKCLVaYU46AHRuudZaD0nc7mTZw0hO8LjX7MlhPVou/vVGU?=
 =?us-ascii?Q?4O6QAsTBcbIvZ50Cn7ecLO4iM6pCivjVJZbu4n8AbQMFWPQZSC86BIbfgyLY?=
 =?us-ascii?Q?RY7vuSvyUTfMqWVIUTf9gezBXAwxuTj6bXUlQi/toXaOVqsFrkED/CiQcjry?=
 =?us-ascii?Q?vL7HQwvZoyATXFkZIuLg7Aqc9FHZai57FdKJ6ZR3hqVRa4YIN7yHmJV7H0Vx?=
 =?us-ascii?Q?FY5qF0IJlWYb0fpK4Q1c53Ku2rIPnDkDH9pGWPZ6Ac2N2jVni5vNdsHmc4Jk?=
 =?us-ascii?Q?SZYwfLMAV3bl56iB2zi/giOGYfyv0EdNX1viFNxifEsZUyVBr5DFx1cjszBa?=
 =?us-ascii?Q?CAznBQBrnL8AKfw6gh2W9U31bEKlO2/uuSCkZGUYE0uWYww6oxa2gyL25UU5?=
 =?us-ascii?Q?JWLG5XotU+Z8S+3vFCMW6xkaHnIypsi1ls9+cKaNPB+BgsKESNwbmslZNfXa?=
 =?us-ascii?Q?o+2ntAq7cGb/tsAY9/tXhC2jWHJnYN9drQpK7psSu0/+iCCF2W6hJQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n2CQXcq8POrggt3YI+VFEueZNOnYsy/pOwUQUGB0aGu/0B7Pqj7F8VPhAzGr?=
 =?us-ascii?Q?U7pbE6SDiJ3TMBmo/A4S7AUOiv3S9+Y+wSJp3Xcxfile+Hu2pwM+nihSRDy0?=
 =?us-ascii?Q?JYY4Mvms0+iPwwB2Q0TKkP+dv6o+RyY3GtwzubUTcXIP7Nv+wMh9Bg+Gtk3f?=
 =?us-ascii?Q?HePPedGEREcVEVatu3LBH7Af/iRqPHUekgnk2/0LlDDuDm4r+M60zIkB8pdd?=
 =?us-ascii?Q?s9MKoZiW/TQUQxVQWXPoQj5PzMtvSdwo7r3VOrXvJUE1fQvUByj1jREVOThM?=
 =?us-ascii?Q?iKF1lxCWUx3IwVTg/sk6ZDEhihy6v502t5XlIY+8dq/W9kgpsD36yPQg0SHi?=
 =?us-ascii?Q?nKqQ1sdljgJjiLdndIr/JNAs0SAEz1ruGZTvdophj8vy4pT7iD353pG/SKXg?=
 =?us-ascii?Q?HNZf1JeBImqoLoZIP2STQMSwgW81ipCI6VtDDynX6b8EGHYjEbNpXDsXWkPU?=
 =?us-ascii?Q?b192GL2/a2gpUqF6GKGYvSpp/kDeJ9EtsFewckBYlE92Ut+NRHGQZmXemlpG?=
 =?us-ascii?Q?vzmsDGlCBsT4HpogWYI7BJjBnCCp1pCPLRiBARCM0HD2WGYsjGJNn4tBdHek?=
 =?us-ascii?Q?liYZvLrIVR5BFBR9cYyVncRM60pmeYUxqfx1okqaHu5cFQzEQoLej7b6omMb?=
 =?us-ascii?Q?JCnY6K4yiSisCuCz++knA9pJm7OHKucY2lnBczmusI5BYFCRb2/NMtYtfOY/?=
 =?us-ascii?Q?gtn0yMJlTBcjg38Sg+QQ72bZfNdbsUtx7U00Z0gQPCpMISL6TD3z2BC7SDnD?=
 =?us-ascii?Q?hnXk1jGxA4/oMSLWPyonW7exdadZLsJ2Xo3OVTjpLJ5kfnxjUb1O9gvc1TqR?=
 =?us-ascii?Q?3jeDE90h91GYJdTc8ADIjQY08ItBwGCVu0Jf9G73FnQJBnaO2gFNDmYlfbPR?=
 =?us-ascii?Q?/5myikVFpJJwhc6tugIhrXddG5/9G3bYm3W1P7ghV4RJkixHMfLSq2k/Di7m?=
 =?us-ascii?Q?QIvsF35F+qcnt/cB6PGlP/U/RlzHk9hCPnIt8SGuZYv8ApW374yZsDfzpqUz?=
 =?us-ascii?Q?P2BsGlV7vi5eBQQFl4TpTy3W4veXTMJ8k4OIzT2BrBGDFptrkrgbohL+2STk?=
 =?us-ascii?Q?MIW//59IfZx0msItrWMnhzso42ePgl5LF/VYhwYbAJLN96bzXy8wSTvSFVnZ?=
 =?us-ascii?Q?UqExAiVQr31w1x8ttDuxSrv85ZtIhcvWcfwtYOFXh9nJYEQ366xSOLm2237g?=
 =?us-ascii?Q?j0a/r3d2ntV02rk4Z9hHRF4WnVvfGT4omVlkwGoOnW5JpVvdROFsppN2Kvit?=
 =?us-ascii?Q?q3l6mWL7JXdXeA2Sb8/+7uWspF11qZH0HxHaTzRpEY+li/ktPMbhg3MRnY1I?=
 =?us-ascii?Q?7CwnIMxIW9mvwV3ufzzLeqwUoYNAoC37cVTJ2iE/gXl5q1spjN92ISW0qPW2?=
 =?us-ascii?Q?5oB1sDZ1tV9qI0cGPQ8mdTq7k9owrFSt6JQdEHQZtVKg3MBciLCG0ApmS+dH?=
 =?us-ascii?Q?5tUw8EFRNF7fRutErnCbNwMVYnaLDSbjzToMFJu4nlncQNTnywR0qMPzrbT0?=
 =?us-ascii?Q?SQ7aef8vGpGZ0240QqIUE1DkMqTkyztKhccQ+PaJXw2rTKvIxcC3RsBOzV30?=
 =?us-ascii?Q?6a/aPS3+nnYYg+VIPM2LVZOrF2/atxzzT6zqqZ9sTsPC2B4QxuUjImfZG1Cc?=
 =?us-ascii?Q?rw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d32bc9-c11b-488c-0383-08ddba2601e0
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 11:37:36.1420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XiPP9WLC57ir6fgnC99FwOHIuFE9pGEwYjP3GHq9MklS3pAFOQmWdqzCEkwS9sgnIicX9h+9ZwSxpWvBQvWLsRpzJYHNwsrgIISYKxDlNO4=
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
index 1d0bbf69be7..ec111023e00 100644
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
+#define LLONG_MIN   (-LONG_LONG_MAX - 1LL)
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

