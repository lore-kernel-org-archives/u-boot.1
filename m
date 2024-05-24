Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6D3C25B79
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 21:10:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12487888F0;
	Fri, 24 May 2024 23:10:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="WQKex5zZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 443BA888F5; Fri, 24 May 2024 23:10:47 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68AAC888F0
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 23:10:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4uU7oah4s3CEV5ps0xCOioaOz/IShd6VW1uFRfFVh2zp4l88ZcEpw5cV7rC0zBt2Luq4WxnEPdv+1m5GmJDxC4PCz1NQE/qovPiazCIrOszmL5aWgAFtGverudNfqgcavMzL/v/AzMMC0GB+CmaMiDaoJrX/F8pFdUbKbZij/9GO1ohaDtznGtk/xOaIUu5DZ2iyZGUTN8ecTVu2QKwC2B8hR+8FcVjJFQpkcIiuQeAzkh+HnoQbDcdrsZa7IC2rz3wTiTEwuhLZfX8dJBw4HlZjoSb9baRVlStPEVRJmAS/72VY7uMOlk4Fq5aqhMbL21GOEy05ubgXtMSPmrPFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TmcCm0bfnWyFLvWGRZrivlHTpmwk5NGsYLMZqjpX0o=;
 b=lE6cOca6FnPZnK5AukM4WU2XwYQ7FGawFDVNWQ700QWxtOtAxwnpTtflZafMm7uhiS6+c06FsoxvV8CcJk182geBgVQnEZpSTk7U05VoUqWC+S0vZt8d6KDUDyphn0PNwcJs4o/kKlBjjFOuMI9/Qpi4Ptl1T411aLH1D8+veu/zXZm6GZGzyjdjtz20oi9RfwZJ3wVnhRNOLSqmlrAKGrJO+6sDwvEqw/5N8TJmvDcKQ4OropQoWXDLaVe64Z/L/nYjh4CyXsrqe24rLXsrD6ICZEcmj0+MmKKj0GybFVeB2SeSYFIFJbKAIkC4xr6t/eBwBepCO0XI/4pcyQakJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TmcCm0bfnWyFLvWGRZrivlHTpmwk5NGsYLMZqjpX0o=;
 b=WQKex5zZqhECGXDKDz7yhtWgU6sVcLs8R4B80jISaCuyL+pRKIUbkBEwVgHlYk6eH8MUihIEfCF+XDZby5h/Jdp5y5077gmh/m5Wyo9PPelzoAbhChx5FjgFphrU8R2LvXz+dF8P7/Kplna8fAEWbu6xxw+2p9UlTQkvziMgGDo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS8PR10MB6390.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:56f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 21:10:42 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 21:10:42 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [RFC PATCH] test/cyclic: try to avoid spurious test failures due to
 cyclic callbacks
Date: Fri, 24 May 2024 23:08:17 +0200
Message-Id: <20240524210817.1953298-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
In-Reply-To: <20240521160709.GS2568172@bill-the-cat>
References: <20240521160709.GS2568172@bill-the-cat>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0086.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::10) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS8PR10MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: 06b636a0-a400-4e8a-3b74-08dc7c35f853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|366007|52116005|376005|1800799015|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?teCp/dfdR0HbShhnhAsGv7oTumanH5t//EB3KsRBnm2XEfqjSACstMUo4Exf?=
 =?us-ascii?Q?TRmZd8TeUgagw9jYJC66qa8V++luAhG2Q3ky8d5aKoVQ03N1FtZfJAJA3K0G?=
 =?us-ascii?Q?YQYqqEii7PejJ2mSqKU5EIfxNGW5gOBknRzEbnxAThpsxFeWUMg6QSMfHdJZ?=
 =?us-ascii?Q?RiQn0kCRiEVD1t8st+1TmfLZ7qlmTc8jv3p68jjk2UwRJO4b2kW+R3rKTIAD?=
 =?us-ascii?Q?7RonATno6Ct6v/FQsgErfXmH2y3B3K6sIfinzDzOE2dwLLDzhfJISvb3s7vk?=
 =?us-ascii?Q?bmv4JW6x7NyVFgiXX6uOxALrHoRBCMCm+wgiOOHFRzJRbbZUoT0KIot5ThdT?=
 =?us-ascii?Q?JpyNFCoQZ2/f7DupoWuEGe4VcEztXkpwLOKdFxwZofC5klabsaiJUGNO9Eld?=
 =?us-ascii?Q?kWTLkcH3SlEaG3xd+QrVUsXS0jJfEz8MOX45wPUSw6jGxKKDSG1Tf/NnGc2v?=
 =?us-ascii?Q?zh3SUF0ExAQnzShhKAXuybaSGhE5QNB25Pu50eKAGmQuXj3iSYx4dAjd2wb1?=
 =?us-ascii?Q?Va56Dn0Rdr+Gdpm+p60NrgBXHmje5HyIIyUEo30ezybzsPg9ttseEdONvDPN?=
 =?us-ascii?Q?f9Py5H1I26QNJ/ZivLb3jfJGEzFxdLIy6kDnMG5BRzINNXsg22wTH3w9zJvy?=
 =?us-ascii?Q?OGN0Ns+Xo+IHns+qF2Vvf1XrpjnYD2q4JCAEtczuROzvLlGqEByBvw2xho/a?=
 =?us-ascii?Q?lXtia0+qo4t5mlsK0l9l1pxhEf7+a5SwJn+7mt0eskgI3oO/rRR+V3bd6xOy?=
 =?us-ascii?Q?8qPQxGstDRrZAi9r21dMdbU5yl5L5w7Sbegj/DKBxKT1RJ2WOXXtJXYikBmB?=
 =?us-ascii?Q?yNIREVbR/myoA/XOoBcQ8V466ljKnwKilFshp8MmLaayYQIUR1ZW3ls/wCh0?=
 =?us-ascii?Q?XCVxshJ9x25eUAKQOOhbXVaB00qBTTpJB8m5hSBjeMtYwWWeDQvzKl9CtTIC?=
 =?us-ascii?Q?AkabIFsGtimZmOAPWWxX//FFIb70ZTZZUSPVEVOQK+OlLhOGi7Qv7xzGo2BG?=
 =?us-ascii?Q?M6vf/gTvGZBWVvISN0ehSzqaYOORcg/pdzQgTq7+QQGEqrFB6/THmtTPstjQ?=
 =?us-ascii?Q?OIV/5l5/ycu0L9vjpCZZcyaK+2mUM2iRa2wqg9w8Y9Zv3vKaGy7MYiZV1KbW?=
 =?us-ascii?Q?b8T92jBALvRiz0fgdOITdXObmZpARqcdyBZdT9KzomOFkkftIhaAmA+6pvIi?=
 =?us-ascii?Q?EjGwYjB69Xte+AAbbnMUTadUwohx1gFhvsshlIfKGkO7IgWZkUcg+p6bgOD6?=
 =?us-ascii?Q?QE0s/r73/cyZwTh8CJS+byd903kdkbMjbFjWqJTAYw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(52116005)(376005)(1800799015)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PJ3hoFe/7Raj0JvbokPec7IvxNEnGCt+x9BPZMVYZNqGgGZ6b7j0IkH/YwRg?=
 =?us-ascii?Q?B4AKMixyOz8pCd6GqlT7pd0s3hQVx4E6nXUAWaTB2qKq1+R9WhcmjFwebQcW?=
 =?us-ascii?Q?z4wwBAVu4LymdfWf3q1hUj7lUd7sOYpLrKDD0IWbJ+4x3NdL7uWXNDUuORN/?=
 =?us-ascii?Q?pKPYowpkjX2MlwWddBYwzCn2/xozCtcpFqh9clwjnxoYyTGW6FE7YNnjE4/M?=
 =?us-ascii?Q?Ut0ACFbi8Xz1yABeBtP8AJBSsqXAjRZ7pURCmx0C3IwM59adU0UIXKD1//EC?=
 =?us-ascii?Q?atsa3NztXBbXHZcesqBMY+Rtsa899vkBzOL4yQ37nbdrYeRvSAHOnh71QpW3?=
 =?us-ascii?Q?z22yjm00M7U3FzDWHQrbxPd0toq4D5M2Yb92/VrdMBz/20hQGGSBTb5Ny2L1?=
 =?us-ascii?Q?VXBmJAjXFvsvTUHHPSOq7FoedmtZZJSDTZzHruqUezSBhPuXxyicRi1qANzQ?=
 =?us-ascii?Q?YrQLoK4/GZPPAebmv172bJltbbG3hCzvj8BWk0PfhzVbAd6IIwk/9inMlHaM?=
 =?us-ascii?Q?MhInOSoRLTRprGOWBiZdGQE/f2UxTlTNXjSr8S4XjIEE1KhyhluaGal+Ksrh?=
 =?us-ascii?Q?Yo4P3WWedcTzEo+g9zTFTdCoZLDMmjftzGGxpFitoOAasfc+PgEKv3rIxIK0?=
 =?us-ascii?Q?6u+kNmEKvotRAjTBMFJqSA0IBGwKxHdtQ4S8+TXr7pg88OCXPyGVnbuzOkkr?=
 =?us-ascii?Q?/Kkzi1LsVOoUWexLFlLv2rH+UneJk7BwvKHFI78ANTuX/5o+lJe9iMkxgXS0?=
 =?us-ascii?Q?l0GE7Z+m39jOSm+hC8lNAi0J2d6OYx0z8NbKlipq+xINpdbBmV/A87HPSiFM?=
 =?us-ascii?Q?LGskg91Ad+K9vKUvTIy5Sd/j2gvTb5sFwQ11yePWNdcy1dgcWONcVuiPd8OT?=
 =?us-ascii?Q?UzEE9A5iaMWmGEFtK5ffrYjrx5R7gcMDANmkOVy+uq0cXEm0xPyz/Y2lXDJL?=
 =?us-ascii?Q?D31mXpT9DdcwlxnWaxrPN5CWwR/DfRm85/csvDtikHO8PqYwIVYL5nR3Rdyz?=
 =?us-ascii?Q?x+5lm1QO8RmJ/pP8mkLieACDTWq7KqaWWfuUCAKU2+I7uPo54/dmFn9RslmH?=
 =?us-ascii?Q?M2pt43D8GbTx4aOjFYYqMyC1Gg4LqVAwxZMUHv9rsMhxPX0SclQk6pBbrfB3?=
 =?us-ascii?Q?BovgHTSW6oabyesqP1rKtkUhynxb6k6jXsWulCR5JRDj26Upv93erktcAVRz?=
 =?us-ascii?Q?UAKUyBzd/GZoBtNDjg3mfDlbvdSzranlzpTh2sNxEFXw5tDpnLIhEIgIP5n5?=
 =?us-ascii?Q?wMSnNhj+00iW9lnWjDZ4gSD74Q62PlYJ41DNNvi9/fgJHQeOQf5R7tIfVP0g?=
 =?us-ascii?Q?P+DLeQG/5E/QaXqKoSd7lT7FuImQsrKWr0Xg0Q9zLbesqrf2NEQWWN5/jADT?=
 =?us-ascii?Q?wWd9V7F92oBKdHYhWgDlcUm3ZsdNlafc+pdMLjaJ6e8FltxcinDDCzMmaE0s?=
 =?us-ascii?Q?f4PSJeedtTYxDz/jvI4Azf3mNdEWE3o4PmDGA95AeMx+Yf3e1CCOC4BXuMoK?=
 =?us-ascii?Q?W2Om8i6IzWXgIeRnG7EFSWKHE5wLtdfNQRTxBQLZ7zXXuGvQZdjFAX9MjPuj?=
 =?us-ascii?Q?TPKigDHYKlypvmceUBWg1qKvtRdQj1JN7fEQZje0aNNL7lBICZRkksAIoUK1?=
 =?us-ascii?Q?pQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b636a0-a400-4e8a-3b74-08dc7c35f853
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 21:10:42.1821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jK+yvOr0lFi2aFDy5B9PUn5OY8bTSZuUzfiFHNohz8NPIXWuoNTYPDq6BD7w3QjAUIqKyUXvCnWf7XlvvSEeRb3yREzHy+2OpkV9y2b94b8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6390
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

Looking at failed pipelines on
https://dev.azure.com/u-boot/u-boot/_build, it is easy to find lots of
examples that have failed spuriously for the same reason: The "cyclic
function ... took too long" message being printed in the middle of
some console output, causing the 'expect' machinery to fail to find
the expected output.

This mostly happens on QEMU and/or sandbox, i.e. cases where U-Boot
isn't really the only thing running on the CPU, so random host
scheduling can cause several millisecond delays, and if that just
happens to interrupt the U-boot code while one of those cyclic
callbacks are running, that message will be printed.

This is one attempt at trying to avoid those spurious and annoying
failures: Add a "backdoor" that allows bumping the threshold, and in
the test framework, make sure that every time we boot we set that
threshold to a high enough value that should eliminate 99% of those
warnings.

I chose an env-var-with-callback instead of, say, teaching the
'cyclic' command something new. The latter is not always enabled, so
it would be more complicated to hook up; setting an env var that is
not used for anything is, to quote Douglas Adams, mostly harmless. I
made it "hidden" so as not to mess up any existing "print the whole
evnironment test", and also to sort-of emphasize that this isn't
really meant to be an official interface.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---

Not really tested except booted into sandbox, adding a printf in the
callback to see that it gets called, using 'cyclic demo' to register a
demo callback, and using this mechanism to _lower_ the threshold to
see that the new value actually takes effect. In particular, I have no
idea if the test/py/ part of this works as intended.

 common/cyclic.c                | 17 ++++++++++++++---
 include/env_callback.h         |  7 +++++++
 test/py/u_boot_console_base.py |  1 +
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/common/cyclic.c b/common/cyclic.c
index a49bfc88f5c..50cc7a02ba5 100644
--- a/common/cyclic.c
+++ b/common/cyclic.c
@@ -9,6 +9,7 @@
  */
 
 #include <cyclic.h>
+#include <env.h>
 #include <log.h>
 #include <malloc.h>
 #include <time.h>
@@ -20,6 +21,17 @@ DECLARE_GLOBAL_DATA_PTR;
 
 void hw_watchdog_reset(void);
 
+static unsigned int max_cpu_time = CONFIG_CYCLIC_MAX_CPU_TIME_US;
+
+static int on_cyclic_max_cpu_time(const char *name, const char *value,
+				  enum env_op op, int flags)
+{
+	if (op != env_op_delete)
+		max_cpu_time = dectoul(value, NULL);
+	return 0;
+}
+U_BOOT_ENV_CALLBACK(cyclic_max_cpu_time, on_cyclic_max_cpu_time);
+
 struct hlist_head *cyclic_get_list(void)
 {
 	/* Silence "discards 'volatile' qualifier" warning. */
@@ -82,11 +94,10 @@ void cyclic_run(void)
 			cyclic->cpu_time_us += cpu_time;
 
 			/* Check if cpu-time exceeds max allowed time */
-			if ((cpu_time > CONFIG_CYCLIC_MAX_CPU_TIME_US) &&
+			if ((cpu_time > max_cpu_time) &&
 			    (!cyclic->already_warned)) {
 				pr_err("cyclic function %s took too long: %lldus vs %dus max\n",
-				       cyclic->name, cpu_time,
-				       CONFIG_CYCLIC_MAX_CPU_TIME_US);
+				       cyclic->name, cpu_time, max_cpu_time);
 
 				/*
 				 * Don't disable this function, just warn once
diff --git a/include/env_callback.h b/include/env_callback.h
index 23bc650c162..c0979b14302 100644
--- a/include/env_callback.h
+++ b/include/env_callback.h
@@ -68,6 +68,12 @@
 #define BOOTSTD_CALLBACK
 #endif
 
+#ifdef CONFIG_CYCLIC
+#define CYCLIC_CALLBACK ENV_DOT_ESCAPE ".cyclic_max_cpu_time:cyclic_max_cpu_time,"
+#else
+#define CYCLIC_CALLBACK
+#endif
+
 /*
  * This list of callback bindings is static, but may be overridden by defining
  * a new association in the ".callbacks" environment variable.
@@ -82,6 +88,7 @@
 	SILENT_CALLBACK \
 	"stdin:console,stdout:console,stderr:console," \
 	"serial#:serialno," \
+	CYCLIC_CALLBACK \
 	CFG_ENV_CALLBACK_LIST_STATIC
 
 #ifndef CONFIG_SPL_BUILD
diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index 26b6de07f88..908b06359ec 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -186,6 +186,7 @@ class ConsoleBase(object):
                     continue
                 raise Exception('Bad pattern found on console: ' +
                                 self.bad_pattern_ids[m - 2])
+            self.run_command("env set .cyclic_max_cpu_time 100000")
 
         except Exception as ex:
             self.log.error(str(ex))
-- 
2.40.1.1.g1c60b9335d

