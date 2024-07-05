Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14F9C3814E
	for <u-boot@archiver.kernel.org>; Sat,  6 Jul 2024 13:37:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E22288685;
	Sat,  6 Jul 2024 15:37:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="JhE6PKR4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05AC2889E1; Fri,  5 Jul 2024 22:30:15 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::619])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93E35889D6
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 22:30:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obYlJ3UvLMDGooPULFnDG/p5agMSgQb4daFCJdTxdXeNfZkYQcTrxvYbFd2+11KmBivIHoSRZhBRfCo5NCe9mX1Fn9lZnGK0e216XpkQpVr+ewa1ICp+7enAcaDzI5kKbv2oFU+18IF3olMPUHKbnK5AITeXKr4cVPu513ShQH22WJ8le35FJQ2x+YyP1u86HcFx+qJKXnHyV9yteDSBz6lf4bWpUk/Om57QC+s5SBQQk1WzJxqC7mWXRljij/uh1RGGBR73KlQpzvnwMS/NsJVrTj66+9E7N8YkuvX3E+uryZjy0kb/YPqEVPkUfZC7bJ7hN+3uFVITZ/+oG9zaGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cI2JEv5VbqdLHHdJv9Q9c6Qs+kJNaSkK9wGITUb2kY=;
 b=aLdS8DnSgi9Nk5jRPrD6diWWpy258WE5z3WC97Uv0e3NoVsTAz4nhaE4881rH+ruOxu3vbbOOifiiUo+KzKjh/uy3bmH1bM4+L/U6T9CCdDxd71zV4PUKlmBXkjmNCYnG+c48R5tnQjS6BFG69F6COvZiwHcahG+GwVfy68VZXv6u5qiAZ7sLbvCgpeb1Gpi+JGAsC50CChc2ljeN283brZOVof1AqDS6XLWsYkhG9bk8oZVN7sw3EKvbTbPsUkHlHz6H4FsUYSmP+lbPZZTZVnJPQIUrg9ojkrdvMlpq3mm05we7JqffWd8z+oYWuBKDEvC4g7lKLR6xmjH/XUYQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cI2JEv5VbqdLHHdJv9Q9c6Qs+kJNaSkK9wGITUb2kY=;
 b=JhE6PKR4LSJzp9e8boE9VyrCU47pLoeD6yduX5EAIdvNsvEEYVXLPN8XIm8xggZa6WhCnEZvHkp2E/CV7R03ltnJU9a4eSOq0n/IShLcBpypSg98Q5X37iBabx0FgiLt8Bkd2tmsvWRE8g6j9j3oY3hgqosWPO37FJh0TZqdQ78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by GV2PR10MB6307.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:7b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Fri, 5 Jul
 2024 20:30:09 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%4]) with mapi id 15.20.7741.017; Fri, 5 Jul 2024
 20:30:09 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 3/5] test: overlay: rename overlay source files to .dtso
Date: Fri,  5 Jul 2024 22:29:52 +0200
Message-ID: <20240705202954.1149590-4-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240705202954.1149590-1-rasmus.villemoes@prevas.dk>
References: <20240705202954.1149590-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0036.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::34) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|GV2PR10MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: 740e8a01-821e-4c8f-1779-08dc9d314361
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xbyokwUEK1X0tUyYtRNLoW5xksTAsNvH3YRqGiJFEP6gvwAndxtd/VR8nAKA?=
 =?us-ascii?Q?kh/fg6XtSOyIhcdH+tF6wzOc3mc6AoylyktQvWIB9PtRsqs/uiiEHJl1Fz7P?=
 =?us-ascii?Q?oNCdZu2Jzhyw7de0VnllKNG/ofNznon0yqamuUTFBd52xM1mVSsUg8S0J5VE?=
 =?us-ascii?Q?WXa/5sGaigEpUoyXN22Xf6aUNMGIiZ2yvM6a/Ko6aAfhsREVgTyXmGCP1e9T?=
 =?us-ascii?Q?QK5UVi8+0+mGc8XKVpD3M7QPHPqpsi+9TWsn+KpNKElrUH8ydouamO6MkIzb?=
 =?us-ascii?Q?Hid1u/6XH+3qQRi0m+nT646o8QJf54qqk+MprmmeYkaJBm4mXg46EYilEHZh?=
 =?us-ascii?Q?yJyZgE8BSbIxyILvU1zboLIUNUBB3MILqBx1HqyjHfEqtFhmCIkCPTHn11nn?=
 =?us-ascii?Q?/K3YtLW/duKsrTHdaqkYfxMHmX6JsKHP5X1FBpcNBxX401UgZM9mn63HO4GF?=
 =?us-ascii?Q?jx0CPGVJU5pnaZpTNDWkEXAukgk0bXAUHP/3hlUGQQXeGZPFjey0AVNnZY6L?=
 =?us-ascii?Q?OO5NCbwYNnxDtaGXCkzSwloSRI5vz6pmuGA83rw7k0KFV/5x0CsIZEEKHi8Z?=
 =?us-ascii?Q?lHm3QCHuSZUo4z9wd22MNgkZayPoRqoBduGQOM4ZAU1HDs4L1f/EOiXiTbTO?=
 =?us-ascii?Q?4lzEMp+sJaAERzQO+hHjU1vM016giLeBKgBKUSg7oz/Vgkdn4w9i2zZPELMM?=
 =?us-ascii?Q?dLcQLwq0AaVRhEQMz0L27wk0LIg9picyt1+TxS6tVe5xIevUA/Z9f/6vuZlr?=
 =?us-ascii?Q?o+cPrPjz6+49mYRTYPRnbVczOGr6VhjUBSZ+gHodvHOuAYmMSWAGosU8NyJR?=
 =?us-ascii?Q?RzZELog2NdHkIYLsCJbhHIlzKYQ02t6ioqHsOrLbiTsIpEKi0GbrAzRaR8Ik?=
 =?us-ascii?Q?blmvIbkkCqgzBHmwqd6FUhDPZuLwvWaZ1knA55IAAkbyaGRiCrtpQEHpyLjS?=
 =?us-ascii?Q?yd2d15uzOcN52J30Q+RfjojZ/zb3fI/Djj4IyugayZd8kOneuleqazV/GfgW?=
 =?us-ascii?Q?GUQDu5AfuIBivxYcqvlm5Tz56bZJXxfTqBZ0DO7Q+zQByjZ31T+EJcR4C2TL?=
 =?us-ascii?Q?/2FbQy1rl+43lfHdtpu/dLmHrUXtBoynid+OhVApcepGiWwBY+BILXlUS8F2?=
 =?us-ascii?Q?wUGiB/oeZyDwjWCj2hW2smpzxLwvSnGl33tThuX1pkrxwGx3V6pspyXOd/I3?=
 =?us-ascii?Q?qpFiCK26Wj/bsElJMxIIji6G90HL+9UIs+To8AruUrme3djo8Mjyh/uAwYoY?=
 =?us-ascii?Q?SxaOkV8blWE08yGJjm2tOgjL0z6VlaI2h7Ukl6ymKnNNMHlArGiHqdeEflCK?=
 =?us-ascii?Q?DzL9Wou2R5oyGWVNifFc6tLPbi3UYcQ4/flkEBQTFu7h2mzFni68kM2Lk/g7?=
 =?us-ascii?Q?UJ5k17BuM+iHnGispG9DKKAhmRU1hS55RC9gw9d0dF4OEA0ZLw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kz/yESMnIUhDg+OqqXs++ZrN/OiCvq0ehCHiCzzo3f+N2BXtn8J0VYt+tSRE?=
 =?us-ascii?Q?ml6DMGVnNKZ4B58L4tH00g7DV2XlxzCB+QQMzAxBfZNQfzSjnRgj7yYUU/gA?=
 =?us-ascii?Q?h0IixVyiNe+lgi9RrTglVx1gz4JsKe9dmmQeijwh9bVyyosNsbexmy4LRXtn?=
 =?us-ascii?Q?1y3nc8d7AwbpEbRUwH4R7J/My3CXnk9jOMf9V9le25fMK3s52Ala5Npyh4gE?=
 =?us-ascii?Q?3fasCUIMPoo5za6GSr51EcWNJzHc+faeE78OhDum7Rfilo54+Kzv3Tw3KOEf?=
 =?us-ascii?Q?Nl0cBNXaQIOqCELfIsL2zHjvYUym8KcFJX0V+WGUGRw3pweXTfsucCJkBQf/?=
 =?us-ascii?Q?BfHh4hvS0PWgZ+1hp9m4HpVK7ix6Tz8RV6gm/zmWGN01u0FBN3btigScIqDq?=
 =?us-ascii?Q?/gv/q4HoY9jd4t+ePbcydKE7gcTavvZSHCmN85hPMkCrR7quAbDGQ6fhFwiH?=
 =?us-ascii?Q?Mm2F2ETtvk57U/VDWnbsAs25rj+RU86IUmm4upWbcQN8dbTHoyoFjqp1q8VT?=
 =?us-ascii?Q?hMRQ1hHHvpUPzei129urWMwVLveEWLIJuU9ok7XjWEUr0jDGPuKiktHxTkCD?=
 =?us-ascii?Q?T9sC9NirBLqgG/ewgMSHcwYxf6NmsXyjmpJBmD0RXlznaH7UehjA8Uj4dPxn?=
 =?us-ascii?Q?w0Lf4bSxG9Bh4G2pCgvfYBuo3NZWKaXAWW0iYap3YWAcxVqRPP1doygIFr3r?=
 =?us-ascii?Q?eoqij5ZGSJhJIm2PLGzHjv0sud4eUyM1ZRuaMeLF7PxgeOzpEUZCBKbl8dN/?=
 =?us-ascii?Q?1fmix8mfsKyATveOrv8/+FS5HohFMZGbALyQJ05IIDIQyenjE93TBX854waZ?=
 =?us-ascii?Q?lq3NX0HvJzAs8ZZwX1bkdeHAdboqrnoipKUQyykYPP9wYk5UOEOR6T2zqv2h?=
 =?us-ascii?Q?blJlD/7pRbablxxNgMMBi1De9Bpg3AyGhobv3mzWN0x89cKNFx/sUV+ATNdX?=
 =?us-ascii?Q?2GckU0zDssApfketLL+PO4bFkVIc6iAcPdvFy8Nzc0Pe0YwFWIxOLkd892S4?=
 =?us-ascii?Q?sqiYrTUQZi0u4khYTKmFOujfFrxrSDr4IQkGYw/qgLuRVEVZ8pFR510zHCiC?=
 =?us-ascii?Q?2xr6dSLm78t3+BolVpZuOwNP6K7wtXcg6FyGbXfxnLhIYi0H0zPKiE+3ZSKT?=
 =?us-ascii?Q?YHLNnFcTOAcHv0P/3D7SqQXbt/Jgd28KyiahpXp0HUx3dSiY6UaeB4TtcBjw?=
 =?us-ascii?Q?ye9wuW+g6YJ5oloPEbJ5H3WyuF2GuHWN5rVdN6YxOsBISUiPvzFqlFi9b2qd?=
 =?us-ascii?Q?WV9EFOxa1pU57iv3zQJLsIdMfoXwG/qlnxRdV1n9C0r9bNxDLo3qrcOk6Zf1?=
 =?us-ascii?Q?3GS7jGhnbapKxRi02uMUsYIlrkZl5UZygWTz6vauBxpi4lfVhJOAAOYVixwJ?=
 =?us-ascii?Q?Vl4EuU6tCGGu/OhXfeNYKtzDfRypv6T5PXI3cn4SF/eCChg1Syz9dAfZzZXZ?=
 =?us-ascii?Q?4HA7ePuTyP19nD0E7lmZppyqI9DKMPrK71QFvlVNTmy8/fYNAa0UgMMczfQ9?=
 =?us-ascii?Q?H2Yt/X/FvUWB0cSXo24VwT8kzdsaYfzI1pEjwPtwVrjP91C8A90fIBHCNmiM?=
 =?us-ascii?Q?7FVc/sN5i91ZAppTuJCkydQOMMyRkSfyalJiQ94C8g78pFS4UnLejhSSTGF2?=
 =?us-ascii?Q?2A=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 740e8a01-821e-4c8f-1779-08dc9d314361
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 20:30:09.0281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Ftu+bWxAPlYvUrL7vL2cdZTjuBWwFdtSsKnwSnfJ1gwb+7pHnkLmRqnslfRW16AHTfMXaA6T1Zftq699/d+5Kv9RFhDB59Cc3n7LQGWGyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6307
X-Mailman-Approved-At: Sat, 06 Jul 2024 15:37:18 +0200
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

