Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43EF4C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 07:18:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCAD48870D;
	Wed, 10 Jul 2024 09:17:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="c787SSuI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 169F5886F0; Wed, 10 Jul 2024 09:17:36 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E4788870E
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 09:17:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rio5FzboUidatirPMxK4YVdH+wWIDTYXFK0pgBTG+UCvNlVIA+56+akqJEg4kb0poSUx0WwktrRalqqEqLLKUBZ7sOzKb/aZToAV0YHW1JoBjuBcn8HE8iVKmFHkwODA0Q4j3Hmxdzz6JTzD1ppVnBqwkxNn2vRKRfN8wWHnMLRHtcHBbIbSfc2ynip2+XIV0xGyQASg1voacHsu+wGgidJu/LHMRPLuW6WpYDce6jTInL+/Ppr8KwBymJzUzVTjTIwTbiepqkhWhc0bT0oCZLA0DnYWJ3N8bOO93VVLmquKa3skzdnCGbTNUF44tXC6R86dt+d3n58Q615a5gFeHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cI2JEv5VbqdLHHdJv9Q9c6Qs+kJNaSkK9wGITUb2kY=;
 b=Y0pGwB3DsTJZX182OmP5U6how4/M4bvkCY0logmuAGKZYGiUnpEu3HJrdsN3NaTISza9cb73SaZkXv0Qmyf5HxPtxo98W9G5N2IGH/MddlF/nFPoERZyKYjbiFdrGqOC8PRvfiyuQjLynvH+4JoNGsWC9fr6fZxKgHmnPmzd+ZpAJp9IirZHXRMjp6NtUBGam+qPpmFeQq1NrGr4ZxIshKB6AAdSHrvruFQGqrGhwayciUQ+CyuoLuERA7uzxXbBmS5uQ/rLN2ror2yaawLx6K1wGkSBlVtphYtzOR+x3wtFOJL5GoNSolO1AT+ryLQfAUfBcqrw64Yh0gZ1kcrcYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cI2JEv5VbqdLHHdJv9Q9c6Qs+kJNaSkK9wGITUb2kY=;
 b=c787SSuI9RvhZ5qVwSanzjIfj+r4QhudwhFD0v4/9L/EDd/PRWML17D7Ba/ub5lTMf/H+DE5etA9P7tR4qaz7gmwWB7iipdHy8f0D3TH6nHOVaxhROfB6Bp/2CxzmZ7Pt5ObPzTrqvv7ozzF1NR8WSOvbEL8lN6q0PkrFeKhsBU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DU4PR10MB8831.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.33; Wed, 10 Jul
 2024 07:17:32 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%5]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 07:17:32 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 3/5] test: overlay: rename overlay source files to .dtso
Date: Wed, 10 Jul 2024 09:16:10 +0200
Message-ID: <20240710071612.1717460-4-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710071612.1717460-1-rasmus.villemoes@prevas.dk>
References: <20240710071612.1717460-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0079.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::12) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DU4PR10MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: e7e0169f-8fa7-46bf-e921-08dca0b05d4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CaRVBLaRmpGaSKnei5O2DEyN+6GM52uG/Ufl5x0cac5o4iIuKMdhvcKYLe7b?=
 =?us-ascii?Q?1G+jzFrwzCLtegP2Xv660UEPdNWcZKQQCYQyNeA9z59oMr7iukK6Ogyf0QX8?=
 =?us-ascii?Q?/Vszjcx14CRTAl1H4pO2RBEwU64IsupZKCSaX/lJ/DzOoRWA/eNH65Rm50Nd?=
 =?us-ascii?Q?XaT109in0d3WV71lD3Fb7eE6zd/hlGSHYpQjiLMMPuZ/I/m78USyXeccqov0?=
 =?us-ascii?Q?f0scgYHXVTvM5fGe+YPydDci20gg6GRkYIcuKs0A6xAoPH9V7k6CGtzyjOe1?=
 =?us-ascii?Q?jwsyLsxnO7NXlZBdwgMgUAv4J3lWXIqM3QGgbzNVMVYQxOeD2q59sxT4CFN9?=
 =?us-ascii?Q?AxUG6RFUYLqqorlHk+WM6bSbcJmdL34yo+XNqC9PY96Gfem5I2+qJZg/4wXK?=
 =?us-ascii?Q?QDlXGJnaoQEJN+MV61NrYFs/sKznLKCB99QBi4FNVMwAsWrAWdtqWaTgFDoN?=
 =?us-ascii?Q?NBvlDtTOQYk+XeBZ36o9lQU8SOWq8f0gaaFHRuUGad7IjmXzYWfZt6Ng4XEe?=
 =?us-ascii?Q?cm9tv69hUs6ER3KsSypC0TGHtJ7x1RIM+4PtxGOhlyhY/AFmuE48bBRHf1eK?=
 =?us-ascii?Q?+j/Vis/R44zJ17JKNLjI1MPUKg/MChO8D2XOFbKX5ZvvscmDRU5MCQA9u0w1?=
 =?us-ascii?Q?H8vVdy3jASIEJqlJoF8zdA/7Z6Bk7oHxiVjWGv0Tnv0k5eTDUaeBtIpZjjrW?=
 =?us-ascii?Q?Wqz8at35+k0Ml/xj6zJ6SLPLxrrNRcb511hAGdLOIoOxOt1zTLCTLrnjpSuC?=
 =?us-ascii?Q?YSag5XQ1bQ/XLXLgu7kHIEZtSQ9AiJYpvehIcftTZ579xsEKWM5J7wJSFaXq?=
 =?us-ascii?Q?LCqfNJurii/q6kGhc1PO8rBXf/rmL1+s1dZN/rfw2jbpHLpxc8vVnLzsbo/h?=
 =?us-ascii?Q?SALswTVutetPwOazoQOYri/B2zZMa0DhmnRpEW/EynEHY7Ypu1mbjLhTETfi?=
 =?us-ascii?Q?pMJAQyykhAo+m2krV2BoN/HiZ6KT9yvVxHkjr0ufnIhpDvRzNp1dWatPzuS9?=
 =?us-ascii?Q?FHb4AulOgIlrRNIAaqta8KXXBHzUhXVp3bntvvj5uMo1F0OG7OCOuQtfVF/a?=
 =?us-ascii?Q?+qiA43Fr8Jn+kf6EV+mc6v6DeqwVZ/lc9BEHXIeeMTjvmSry+CbXPG1O4YEl?=
 =?us-ascii?Q?rgCo3QkQ6aOE75p3h+hbEPjsb5PH0zIwYJ87BhMgJcqhU5r7fJpqioOW2P6A?=
 =?us-ascii?Q?jKUpa7lbhjs0foliH2QlZukS7Semny+HqL6NMwXyz/M8LAAwbsAfnld8I9DE?=
 =?us-ascii?Q?0pSRoeHS4mGX//zzZJBKxV7V7HYO26DGgBn61fKcdhtfO2d0ujxu5gO1SA9F?=
 =?us-ascii?Q?CZ/BLS/MPYXN9yGDizLHGwqHW5r1WNat4B/IH/tlh6dUiy5qqNMphsto/nrI?=
 =?us-ascii?Q?VfDWlYi05dAOzuJ4gHPR72zV9XVCCQ4fwgEctUDd+tHSF6tHMw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GXZd5LLomu1vR6CEN08Mx+lOxKa6MMvecR37CQv9YkeQj+JBu7F1mcVJdvQT?=
 =?us-ascii?Q?vXmehK0wUu8YbXZaB/rZx402NgUdZBFSak/p84u1zyCtbVd3ayjKF2+ovt0E?=
 =?us-ascii?Q?dVMcAgFew8wloqUjg81tTJKP6MKj+kfMpqP3qn8v3tAgz/5petegYS/wBhpz?=
 =?us-ascii?Q?jvHAv/wAhUo2l4yEzgl32fDypRZBWgSbU3z6/IsoJyR8i23wlXR5u57CCQ5o?=
 =?us-ascii?Q?2zOe9UKSmpRUgnu85OOCfHftLT1rrHoiS2iEWTEJO8eXnIL7YsiTFYHq+0I1?=
 =?us-ascii?Q?znJC2MLTw8zGN77hfJsW4dbFzhgAs2Ra3ni0IdhuKIP83vXdtLnB5LEgFIW0?=
 =?us-ascii?Q?a5iSU7LzIhF6I/mLFo8BJz03qHPPWaxlwb8Yuiv5oj8T8A/o6fmSbdDjfD87?=
 =?us-ascii?Q?L4qSLx1zzemNjcuB2K+YDwLB3MAzDy5lWOjdIFsaklMFK0NeePdfpW/bUrOw?=
 =?us-ascii?Q?mrT2QZUJgjMitYdoNwpWFoERAiSQ/Z5Om4p6zq68E1nve2UI+3+NCW7qBIol?=
 =?us-ascii?Q?/1owY+DWzUWJkbL50ZznBi2q3ssbz31QYnDkT4UIv8IVDSDCVODvQOYCRMUD?=
 =?us-ascii?Q?3r/h+ulYSwzXrYDOH/eBURXld0FBnN4aN0Y9+eRDknQM0O6r3bfxhccl0ThG?=
 =?us-ascii?Q?XZRQh54egtYHSikUq+/FFSlCzgM6pSj0u1PtAfqNkhmm0izGo5lE21hlqmPd?=
 =?us-ascii?Q?XOJn4wM5yqK+nUdSO0uqFDDj37MaMeVScpImIZekUg/1THE1bmuO3Xk7GY7I?=
 =?us-ascii?Q?VhtBN39EiZQCZW2UPgbgNkWSqJUarNe22UKocUJl0Ucp2z1WJH2LO2xCiYqy?=
 =?us-ascii?Q?ecfF/77FORupP7cdrzBzn/knj+NOCuf0jK6LX04klVb9T2iSFmfmI6SKX4yv?=
 =?us-ascii?Q?+p3sfMmI9Z8B6l0GCC9bXHObkrBQ2nUBujvKkff8dSVNXmcbCKWGHdb0onLg?=
 =?us-ascii?Q?PO2AjpM8ny17XBjHg2cDZwojGikCuXdAuW4gIRKcUUGmhb68EROVMIrjrUyH?=
 =?us-ascii?Q?srosC1BRhXr6zjbNQFI33jaB6A+sip+KMsXTkAEbxeUljO4RrZv+dO5FWEXj?=
 =?us-ascii?Q?CebraDTcyQyP5DQC3tun1YoQ5S3afnwf7MAX3oGHXS+PNMqV4HeFz/+lAc3z?=
 =?us-ascii?Q?Q/RH4bjXDenp3a8fIAOKdr4YiiOJ/10+jmNJoP8lGpQRGNQmJn0ET0CAKggj?=
 =?us-ascii?Q?Prz9PT3KXdZiVTFopQ4pOeqGbxA5+q60o7paJrScxXUFZReGn7dnuL64MHex?=
 =?us-ascii?Q?yx7I74voxSq8N5ODpOIg8DF1JCNLCOhw9Ibl7P03Kth3S9nxtxENyg6/9KJ4?=
 =?us-ascii?Q?88IxEI3PBoNcEvKINiehYhNOkAN6AB58P1EKs89rDt34sCZUin2kh13WyBeV?=
 =?us-ascii?Q?k7+lJzPxo36KhcxJXpIbILXEwj6aWlmj6TWCbGvXqKEBND6ECgKwP8TbLRVJ?=
 =?us-ascii?Q?/jYZY0wTA/URrTb2TIjSglfsi/E59G65i21X8wG6gHTuJ7U/J+tDHxsnPudZ?=
 =?us-ascii?Q?V3Aj5z22TXEIPp22AAiw5P1i6+5s3BXGZjPT4V79dKEQAGNnUN+D7fVaoW/7?=
 =?us-ascii?Q?BN3C3jtawh7AdDgR/i1jATx0cga33b7eOgo55U+RlBV1I78SFnf36OWozGS7?=
 =?us-ascii?Q?Rg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e0169f-8fa7-46bf-e921-08dca0b05d4d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 07:17:32.0787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GTDgcc1rITGU7ujS4D73hApG+tjhUs0z0QfYZ9AeTHovZ6V7FCT27HsOqxU+1OMwrrTbQnbgHWzACw20j7L3iB9ov7aQnnpsl10vsFMb/Eo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8831
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

Distinguish more clearly between source files meant for producing .dtb
from those meant for producing .dtbo.

In this case, the files are really meant to be compiled to .dtbo ->
.dtbo.S -> .dtbo.o that get embedded in the image, which means that
the begin/end symbols generated by the makefile rule changes to
__dtbo_ rather than __dtb, so the consuming .c file needs updating,
but this should not result in any functional change.

Note that in the linux tree, all device tree overlay sources have been
renamed to .dtso, and the .dts->.dtbo rule is gone since v6.5 (commit
81d362732bac). So this is also a step towards staying closer to linux
with respect to both Kbuild and device tree sources.

Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Simon Glass <sjg@chromium.org>
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 test/overlay/Makefile                                     | 4 ++--
 test/overlay/cmd_ut_overlay.c                             | 8 ++++----
 ...-overlay-stacked.dts => test-fdt-overlay-stacked.dtso} | 0
 .../{test-fdt-overlay.dts => test-fdt-overlay.dtso}       | 0
 4 files changed, 6 insertions(+), 6 deletions(-)
 rename test/overlay/{test-fdt-overlay-stacked.dts => test-fdt-overlay-stacked.dtso} (100%)
 rename test/overlay/{test-fdt-overlay.dts => test-fdt-overlay.dtso} (100%)

diff --git a/test/overlay/Makefile b/test/overlay/Makefile
index 2deec929abf..47937e3c108 100644
--- a/test/overlay/Makefile
+++ b/test/overlay/Makefile
@@ -10,5 +10,5 @@ DTC_FLAGS += -@
 
 # DT overlays
 obj-y += test-fdt-base.dtb.o
-obj-y += test-fdt-overlay.dtb.o
-obj-y += test-fdt-overlay-stacked.dtb.o
+obj-y += test-fdt-overlay.dtbo.o
+obj-y += test-fdt-overlay-stacked.dtbo.o
diff --git a/test/overlay/cmd_ut_overlay.c b/test/overlay/cmd_ut_overlay.c
index bcb29a26e21..256afd115d2 100644
--- a/test/overlay/cmd_ut_overlay.c
+++ b/test/overlay/cmd_ut_overlay.c
@@ -21,8 +21,8 @@
 #define FDT_COPY_SIZE	(4 * SZ_1K)
 
 extern u32 __dtb_test_fdt_base_begin;
-extern u32 __dtb_test_fdt_overlay_begin;
-extern u32 __dtb_test_fdt_overlay_stacked_begin;
+extern u32 __dtbo_test_fdt_overlay_begin;
+extern u32 __dtbo_test_fdt_overlay_stacked_begin;
 
 static void *fdt;
 
@@ -216,8 +216,8 @@ int do_ut_overlay(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	const int n_ents = UNIT_TEST_SUITE_COUNT(overlay_test);
 	struct unit_test_state *uts;
 	void *fdt_base = &__dtb_test_fdt_base_begin;
-	void *fdt_overlay = &__dtb_test_fdt_overlay_begin;
-	void *fdt_overlay_stacked = &__dtb_test_fdt_overlay_stacked_begin;
+	void *fdt_overlay = &__dtbo_test_fdt_overlay_begin;
+	void *fdt_overlay_stacked = &__dtbo_test_fdt_overlay_stacked_begin;
 	void *fdt_overlay_copy, *fdt_overlay_stacked_copy;
 	int ret = -ENOMEM;
 
diff --git a/test/overlay/test-fdt-overlay-stacked.dts b/test/overlay/test-fdt-overlay-stacked.dtso
similarity index 100%
rename from test/overlay/test-fdt-overlay-stacked.dts
rename to test/overlay/test-fdt-overlay-stacked.dtso
diff --git a/test/overlay/test-fdt-overlay.dts b/test/overlay/test-fdt-overlay.dtso
similarity index 100%
rename from test/overlay/test-fdt-overlay.dts
rename to test/overlay/test-fdt-overlay.dtso
-- 
2.45.2

