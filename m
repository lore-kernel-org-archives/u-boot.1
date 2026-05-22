Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F76CD5BB0
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 21:29:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC413847EF;
	Fri, 22 May 2026 23:28:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Q9mNaf3q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A825A84913; Fri, 22 May 2026 23:28:12 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3F24848DF
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 23:28:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nc0hcG/GuBQjUbobg9SHAkN8SLvCmRT5ku8a0s2/t1zVzqtnpzRJH43JHaX+Pa2LNKWlfSpvqj3f2Ug7Cgc8Kk/m9yZj4HxaFmmNXTsqz5E3TwPQfXrBs568hYNfBqvtodByKrB6zyCylk+Fzrvj8uy6Ho+0rVYQhvVc3vHG40myXEa/AmXs6VbmgIF7SjE8Dva5VVebtBLavXyOGolJGJalieE63bJ6DPcgR5aOi3LKswREG7BrsoWbyx1/Qovl2ocSCnia2j4jpvPnocUe9s5Uqg2+jflUhT6mzZf8A/4SnbOI7vNEernafYLeAhFXufOrNYjAeIfUG9mR8uyqcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZeqY0CEM98pN2Wt72yb0tUNhytGN71rzS0QWNay/boI=;
 b=Brf4xzLdnE8NuFCk+T9NlFwjlRvzFG5X/9cb24B1k/2gSjqMmL+rm1QXvxfz9xoXv7sc6Yg0kT9O2z9zYfV/u6PSfK15AR+8h5TKbDjuf263i2Q6j4RD7m9LhUfc7nB0xknNJvDUjGhAHZDNFfjfdv2fj1KzxFWbLjXka4ipgBPM66KeT7lcX+++LlY83FumzrqbXNd52l8/K4daR1kok+RJAU0mVNhr18sPUTbmZGLaM+M+PLygX/+ADRlh67SKOQ0Y/iMRf4ZkKFy1vmV655RQM5H8oGMb96clHDTS9pmvabj2zR4BHsbzLlejJyLaibcNDnwXi01RKDPvHI4ONg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZeqY0CEM98pN2Wt72yb0tUNhytGN71rzS0QWNay/boI=;
 b=Q9mNaf3qO8HdOlWntRW6oUJd1qNm2sM5BgnZ/sp9pIgvm3Vbx6mWkUGnNHwFVLrrQRic8Rdneed5aM+jG16IeOJn6LSK9B4kHeh1kv/D0FgS3VMQU2AAeLXAS5qelp/ClVhpnbBYlZSOvkzab2A4Sbx6Xqk3s4IjrTWcQ5Jt70g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU0PR10MB5385.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:340::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 21:28:08 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 21:28:08 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [RFC PATCH 7/9] test: avoid use of special characters in ELF section
 names
Date: Fri, 22 May 2026 23:27:54 +0200
Message-ID: <20260522212756.3169222-8-ravi@prevas.dk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522212756.3169222-1-ravi@prevas.dk>
References: <20260522212756.3169222-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6P191CA0005.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8b::18) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU0PR10MB5385:EE_
X-MS-Office365-Filtering-Correlation-Id: b85bc591-5f46-466c-9359-08deb84904cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|3023799007|11063799006|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: d9YJq+5AttkPg42ELHrSi864CAOV1kMzMayECDKfwismFMIlkk+fHIHMYrF+KKiC9iW6qijtQPhE0GQQMHH5x8cWjwvleeeUB6JqB0fuCnXWTO3+EUq/qm0yLLmTD85SNx1ywthrVrS5OJjzVZ7cK8Gax4Wug7Kc5WlbabGLrv/YHM/0EOcI4AUbyV8byWC9z35b1d2LUB7DF7UduClZ4fjCwiut6p/rw2Jc54biofJ/HeEFbew6S/KPxeRVVBl+3uaJptRlQNDsVQKdphs7VuGbnJ0Eetsg/hHCpIoIY69GVSmU6sbls4KEuyArFH+Ut0H7k3m8+WKcOEPlp4mJvuAwMD16fKZHmbmkjboTAfXyan70WXRqOss0BDWm3zb5TxVnHuu/BUB4pkGoSlLsACp8WNdxtO0zfL7NYvQ6nEnjRl4hVJs4Car2LGO7lU6kmIsWtyF0vMfaK2uMKgpOKM6GGJQQ5w5S9Mt/51VlhYBc09RXRvY41Iam8nK8ifQQea/GgpjAA2zDxB1ZmDDxpMRnpUvNFeNfTH9HNCbHa09hvh04gux0uAsS79evLWTKSo1wI8t/a3iHVkmg66Bd3v1JtzteIo84XIYL+OXjNUQvrgxFN5IWJuKM9v9i/03eX46AVLs3R4cAwI9x8aYoR2ff+AXMeR4IF8IZr9zq5aRC5b8313xwfJ5Fo896vpisnKJwkHDzVJzW0JVToQ1lBWal42HbMNsdYxX0D+rgUS1QxzbM9iyr15hw3JFJOQOr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(3023799007)(11063799006)(56012099003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bzb8fmUxe+w+wKNzud0YEp+ThVcfD18cKAKEU85R/5jmbx7Er4wSBEMPdoKO?=
 =?us-ascii?Q?36akFQF5hH/UBCAj1Ed9SFcKQU7zIjCfE8SQJAPazdoafvnpWp4woGCfX9H6?=
 =?us-ascii?Q?uaRpZAD0g2X2xmxznFt3FYSh0YN0l+PD2ZTnBtbAYN73Oilo0+Nd0VJbTAA3?=
 =?us-ascii?Q?pnlpFzA1hk7egcV7+MlaYCXd1wwqjvg2qQe+Xsn0birg33G1TAOGEWKOv7ci?=
 =?us-ascii?Q?3Hh84vcVPk/AdcCiBToXz5qRgqTlAsLqfCI5uYlqkX51eQrg6d9N0BSP2EPH?=
 =?us-ascii?Q?9qhpGiJvHttpcbV3p6THpEOIc0OLbdgZBX97aIdwL7NdPehgGzU/Snl1PQzF?=
 =?us-ascii?Q?UnqQN3phe9NQJQB6SCjOxHIcL4haYmTOurspMpcKmtX/FgJKvsWOYEqi61Xp?=
 =?us-ascii?Q?7Si5IuIQRGL1PysMH3TwZpu84V5IUEYmMAGxQ4r2MDYZgtyz2Srp9mewVDVl?=
 =?us-ascii?Q?UV0AMjG+pQdcIBYkB6Sd/d+pHqMEEqb1ELJ2vTx7fVKNfyj0BFPfy4dpHzLO?=
 =?us-ascii?Q?//9Rc4ylFIT+CLyO+xyFpEIaaPmTMRiI5awdsODZyERLHvRp++FBNXWDLHok?=
 =?us-ascii?Q?0VKtSCHAkt3UMDK+f2X/26vVR8gKck2nR3FZirJm0+SkFZqy1V+vPqGo0+SO?=
 =?us-ascii?Q?3/AGSu8POERt6JYRzUTi0NeXEpMcljcqgxnQYnzstZfglwf7aj2O53VK6maA?=
 =?us-ascii?Q?dfoYB0dx+n8zPtLAm/08VNXeb0fJu1co8S+nAqRzxqBP8kXIBdYO3uzN5w6p?=
 =?us-ascii?Q?eEB5F0amgUFTHGkDwQKRPQTahMsQNmVEI9uYeIunANSBPeIr2puNt5UG1NTT?=
 =?us-ascii?Q?O33FWD4pyFzjRWSKzj5g5eCm8bC53RE4o9SEvdoQjRvZCC0bJDMXajRQQBeq?=
 =?us-ascii?Q?I1IwDDyQ9LFguqjQ7OEbJ4Pf1tCHlvAk0SGmQ0iOa2B/5CqMbgutgZCAxsNv?=
 =?us-ascii?Q?JnxrE7G7Vbe0ycpXC1Enj9W+QmBnLQAurV5VgXntNZTku5eP/MDzphJzMU1g?=
 =?us-ascii?Q?KG//kxT1+4I5KSVDG37o2nWsIoIQYqLIhHC8YtZnGP3jE9/TVen0mdMIzAQB?=
 =?us-ascii?Q?stkVBEtm3V7luXlDMalRmcdvSJyQwLcP7O5G6pzZbXdP/px7kkkh68usEjsb?=
 =?us-ascii?Q?YoI+GHRHJiqv4gdSvo8u/JW+5QX5yvrtgAAXG+ljVSCtQFBkU0RcW2SHsS4l?=
 =?us-ascii?Q?T/1Qb+NA5QBUjy2uzu2iRPDKv3rpa387p9iofNJigi6yniF5gLI8/ZtJ+JYM?=
 =?us-ascii?Q?bsZHxd/oLx1s64+mXYUP+KC868ioJtjDaqODItDEc3jr75NGPOlXcZZRsvyf?=
 =?us-ascii?Q?WO1DLxeLiUeNk5a9HZ2gSvrUT4Ai3S2Oq83U90rscECWnX49qu3bDBHcMbss?=
 =?us-ascii?Q?BzGs2PcDdUXxvWn0CWe6g6x0hCutnGJ6fnQ89J1GWfgRin/+VZQRL93mGYqH?=
 =?us-ascii?Q?5NOOpmyw+lY4wZf0QyD3938HMXHpNvV4EpyLI74fStZJn0a3++R57uWtLsBC?=
 =?us-ascii?Q?s6/qHWyMMOUSJTSE6Mo3rYSm+faaUZoVKedAw7XneJLqYtSIHkNDl8+eLQ4g?=
 =?us-ascii?Q?xikuI4ywMXRVHOUJe4L2S//frAolNcdgZiCENRkk4epEyvMyGhmnWAJ0aBS4?=
 =?us-ascii?Q?p9HNoJOu+uHXhNGqK23DdSfWFlwRF7RGBywHQ9mvBD4LuGUj2XbQg70bL/Kf?=
 =?us-ascii?Q?AxNqRrR2wnix+YS/hpVZ89hD2hgzYS1NwcT/eIdeks9MZNfLU1olWdK8M7Ym?=
 =?us-ascii?Q?thkv12rLlC7U7GHTVu1GiOY1bKIC/hI=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: b85bc591-5f46-466c-9359-08deb84904cf
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 21:28:08.7219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NiZXuzxFAfWL6ycElAKcmSSVIB+v0LDsa9lfBCEiZFDPLyylJdjtC44xZDPB0cX5zCmChBd9YOn3azKJGF/aKcfg2wjLAfeV98PitMN13fE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5385
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

While the use of the ! and ~ characters currently works, it is a bit
hacky, and conflicts with later patches that will require the
arguments to ll_entry_start() to be allowed at least as assembly
identifiers.

linker_lists.rst actually describes how one can do what the test
framework wants to do: We have one "outer" list, ut, with individual
"inner" lists (each suite). In order to be able to delineate the outer
list using the ordinary ll_ helpers, we just have to make sure that
all the inner lists use the section name ut_2_<suite> instead of
ut_<suite>.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 include/test/test.h | 15 +++++++--------
 test/cmd_ut.c       |  4 ++--
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/include/test/test.h b/include/test/test.h
index 0f2b68a5dee..6423f3486be 100644
--- a/include/test/test.h
+++ b/include/test/test.h
@@ -142,7 +142,7 @@ struct unit_test {
  * @_suite:	name of the test suite concatenated with "_test"
  */
 #define UNIT_TEST(_name, _flags, _suite)				\
-	ll_entry_declare(struct unit_test, _name, ut_ ## _suite) = {	\
+	ll_entry_declare(struct unit_test, _name, ut_2_ ## _suite) = {	\
 		.file = __FILE__,					\
 		.name = #_name,						\
 		.flags = _flags,					\
@@ -151,7 +151,7 @@ struct unit_test {
 
 /* init function for unit-test suite (the 'A' makes it first) */
 #define UNIT_TEST_INIT(_name, _flags, _suite)				\
-	ll_entry_declare(struct unit_test, A ## _name, ut_ ## _suite) = {	\
+	ll_entry_declare(struct unit_test, A ## _name, ut_2_ ## _suite) = {	\
 		.file = __FILE__,					\
 		.name = #_name,						\
 		.flags = (_flags) | UTF_INIT,				\
@@ -160,7 +160,7 @@ struct unit_test {
 
 /* uninit function for unit-test suite (the 'aaa' makes it last) */
 #define UNIT_TEST_UNINIT(_name, _flags, _suite)				\
-	ll_entry_declare(struct unit_test, zzz ## _name, ut_ ## _suite) = { \
+	ll_entry_declare(struct unit_test, zzz ## _name, ut_2_ ## _suite) = { \
 		.file = __FILE__,					\
 		.name = #_name,						\
 		.flags = (_flags) | UTF_UNINIT,				\
@@ -169,13 +169,12 @@ struct unit_test {
 
 /* Get the start of a list of unit tests for a particular suite */
 #define UNIT_TEST_SUITE_START(_suite) \
-	ll_entry_start(struct unit_test, ut_ ## _suite)
+	ll_entry_start(struct unit_test, ut_2_ ## _suite)
 #define UNIT_TEST_SUITE_COUNT(_suite) \
-	ll_entry_count(struct unit_test, ut_ ## _suite)
+	ll_entry_count(struct unit_test, ut_2_ ## _suite)
 
-/* Use ! and ~ so that all tests will be sorted between these two values */
-#define UNIT_TEST_ALL_START()	ll_entry_start(struct unit_test, ut_!)
-#define UNIT_TEST_ALL_END()	ll_entry_start(struct unit_test, ut_~)
+#define UNIT_TEST_ALL_START()	ll_entry_start(struct unit_test, ut)
+#define UNIT_TEST_ALL_END()	ll_entry_end(struct unit_test, ut)
 #define UNIT_TEST_ALL_COUNT()	(UNIT_TEST_ALL_END() - UNIT_TEST_ALL_START())
 
 /* Sizes for devres tests */
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 44e5fdfdaa6..9d74f091138 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -36,8 +36,8 @@ static int do_ut_info(bool show_suites);
 
 /* declare linker-list symbols for the start and end of a suite */
 #define SUITE_DECL(_name) \
-	ll_start_decl(suite_start_ ## _name, struct unit_test, ut_ ## _name); \
-	ll_end_decl(suite_end_ ## _name, struct unit_test, ut_ ## _name)
+	ll_start_decl(suite_start_ ## _name, struct unit_test, ut_2_ ## _name); \
+	ll_end_decl(suite_end_ ## _name, struct unit_test, ut_2_ ## _name)
 
 /* declare a test suite which can be run directly without a subcommand */
 #define SUITE(_name, _help) { \
-- 
2.54.0

