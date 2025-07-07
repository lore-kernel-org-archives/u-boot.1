Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53AEBC83030
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 20:37:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AA9483242;
	Mon,  7 Jul 2025 22:37:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="b5e+6SAO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE9A8831B5; Mon,  7 Jul 2025 22:37:08 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DC54831C4
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 22:37:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FjhbMpDKlj2Llh92JX7aZbaVDR0nQVMhu3bDdHMdGmg3TZmuZtKn0h9nMOFWs6CYKAYelDP3l78DdjsUDy4NonECxBWzw/9x6pAm5IKP0dbO7nBJOzS+cWV4koNUNy6HCDWuPU4bH1nRWhLCCeyiKQOGkSA91eZhv6WSrrYJWi75q63mT86bdmBlJlW8wdQgXRGzEcA6aVCW3dqliN15jTvJwlEe2fl26V/fpYZv1j61bFbnXILfhsBCZyPuTzxFAWM262X5Jb0METCA5P3MKehvuyahxcq8c8SX6Vu04eUsiVHnpg2K/893c5IXRWBg6EfCpCUfuC4ZyGAIKjMCHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEenBCCRcq+x7tMV8THnDiIcs73uL8DIKjWYTYADxRQ=;
 b=tGb3Dsxpgv0DuGeTRhkqFO/azwCP3H2iyLi0ORvcMwDkl9Wf2sjELP18AL9+5Zc2AxJzKWm5hdBR/ZlWkgGDBtIV403+20ZZk9CPPuXGKqAfGXponfoSJcGrAkPii7GXWmaUFGW8ytZQbx0ZRcyJ7dvQpSHWQDEgx5zL6l61TXrg/y6FdNhWexUvrUbxhRFOUlS2q9IscKVsz6VWy12KTrUOLuvISDlQ/EkeqEgwfqnS8GHdRYI91LP0e8cxI4vYYIG1wydV7Xzv7S2uHfLeLM11oDpUkZXVoSmJ508nToZNQ63PN+uc1EFomiIgOJgXKxMj7nUyb9czIvh5FusqmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEenBCCRcq+x7tMV8THnDiIcs73uL8DIKjWYTYADxRQ=;
 b=b5e+6SAOLhjuJ+qXhxo/o3KtGuTL16ey21NlLWq+cjbxKS6574oRqmvyVt+7aphzw1Np3drghJKDEkMKTeby0K6yzaj4sSb31ldRwblLxKdRsHSNKFd12fTZXH3uPFuxFO1GkT9+8WvQe5eLhUI+NYnsBI6HvdAswU4TPFau2ak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GV1PR10MB8860.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 20:37:03 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%5]) with mapi id 15.20.8880.029; Mon, 7 Jul 2025
 20:37:03 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 2/3] move limits for sNN/uNN types from kernel.h to limits.h
Date: Mon,  7 Jul 2025 22:36:54 +0200
Message-ID: <20250707203655.613340-3-ravi@prevas.dk>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707203655.613340-1-ravi@prevas.dk>
References: <20250707203655.613340-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0001.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::10) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GV1PR10MB8860:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ccf0109-0000-4670-5fb8-08ddbd9607d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?civ5+/tkKESVz4TjDuiAOnZs/llU8uFiq6cwKF0YCV06M/pa4Ajuq+T3tmRQ?=
 =?us-ascii?Q?sAqTD9CIGNuwhVJMi0V+eEIET7FJjeuEEbu/kBIgTQ0mvI5zwM2VqgTzmlMQ?=
 =?us-ascii?Q?3zoQcfI26zEqRk5ELl8m6EhP0eOw8kQEbD6UbMNRIbd9g0kjQ8Z0vcB/o4GQ?=
 =?us-ascii?Q?5WHcYMlsnMMFuFBIsp0EgRUT1D8sUBd/gwiNGZCRI4e60pziMx96/58GIMP+?=
 =?us-ascii?Q?j3SjmrBtxWuSeWmYwVsaC17nYb22GMIUV7sc7rRXgtG5ARi/jWHqpBZrLwhF?=
 =?us-ascii?Q?XIQX4XEswMepdpkf/IYNXrqPQTHsmRSNpsxrvWhiVOCNoYIS706DP4JiFf0h?=
 =?us-ascii?Q?FM6UCRnNq2eqQe8udAfIbj+1+dl0T5zsx+1RMnMsC4fWpvVuzEslAuCVpMx2?=
 =?us-ascii?Q?9bIbeuRijpWIUvbScdY4hBlVE8o4dyk3dISl8l93ZeoVL2U30AlTAz7gREOX?=
 =?us-ascii?Q?BFZ4ChuOrrQcy+aUxyA0nSSNNCcTLBv/mpx7dCVNBzo2LcoukYS31usIH4EV?=
 =?us-ascii?Q?IRqPPQLbT41lfd7T0H9OoWdtVy8uya2v10XknCPApPKvLvZgM6GkbKneMUjD?=
 =?us-ascii?Q?L6wptgk2tJmx2JHldDA636cWhjtocbrJUSpEwGhIDE/QSnhHrEUJBGgtM/fP?=
 =?us-ascii?Q?AOxW3wCVpyFzcmbUrtUceNZj0f/wx1gDtAItTFyrkJ6cTeXuEW4SoYGZEqJ/?=
 =?us-ascii?Q?h58TMx3atVvqpBWpZdBD0ZJ0LWJOGIV8POsf5GfXUagyQoJmlXCcvE1S+OWS?=
 =?us-ascii?Q?EwqOqx3So/5EFCDbADSocRPoPh79k6kEVSiCaXBY4H+DcVhsrSSSH9TdU7Pc?=
 =?us-ascii?Q?2xgT+hNJ6CQ4TSDb9c4NPKpPn+P/M08M5GJOHE2JVqxvvM/6rHDGaLMiJ3ic?=
 =?us-ascii?Q?PiSxZXx7HlwPgPKRdfUGN0smZnI1dagnBMfXeGymc1GEq40SF6GdeNpsDXNL?=
 =?us-ascii?Q?KnRWxDaTunuBm9c/EHEPxww/Mlmlc2qvh6lAZlQSpH3+5TioG4Vw+XRLmXfJ?=
 =?us-ascii?Q?mHiJW/cO66HdpNU7I6yZ/fA1qjMHOuhz6dzl6Z0XTEQddnjW8VyKuMzwO2Pk?=
 =?us-ascii?Q?EsBnpJre89f7h40OZeeGiUVvijCVtNJsr4QH8FvjbhGUD093/nDa+NV23LH5?=
 =?us-ascii?Q?sVcHa2BLMtQL6eVGo6w82Vu90pO+F6n/oC6Fa0+XD+qFsw643EsCu8JWsMgX?=
 =?us-ascii?Q?6LvDQA0oyoZ6OjmSa/hWI9eeH3fS/WzvlnCJyrac8ZhCRoUBHQMbBubWwAxD?=
 =?us-ascii?Q?Y0M82agln2GmrsO+WMhPq3WyU+wG7SV6n9wadkjTgaVp30VXO2mVRyRp4vR2?=
 =?us-ascii?Q?2h4TXnQoR3ncy+28jrXge5c3bG3mNDy9JHs2EJuZYqSgjbE4T4e9DfGUoYvC?=
 =?us-ascii?Q?zPQo+l313my5kd5u69bsbMaUaoBhpFM1UNFY3brt6QVKFgdC0QDfHVLD1gaz?=
 =?us-ascii?Q?dONKEGmjVmgSQ9PlnWWaYYGTuX2UDe5e+MVDdO0116+vLouXXCQNZw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4OjjY8w8Jas5cLJkOH2Q4Bn/fvs6zznaIFTGJOkZUFsmlqxA4l8vmtSiyATG?=
 =?us-ascii?Q?Jg9H3xUbjMSN/1P2mm1ThZfR/gKALpI4wEl5MwsbVMVIO6Ik7kWoNSRQUQtq?=
 =?us-ascii?Q?EaHqpxgY0HV8b19DE46Aao5gnD4a6XryAAg9cdUVIpffiR0VaMj5Qb5CrLMu?=
 =?us-ascii?Q?oo3I3Xm88gv+zsm1cO5e9AcKdFKTi56oetucJtL9RiNtxfjcxYIFjCj51oEA?=
 =?us-ascii?Q?buCHW/3pR3o6zTh9MAkcxoWWtD6ZCdGGkgHIAvJSne+WXmehKAu8C1n4E+5G?=
 =?us-ascii?Q?K4WK27G+rJJRpulCncKXNoEHKdI999BFx5uxw/PeS8X/gu6caKd+b8WqPaPc?=
 =?us-ascii?Q?Sx61kpwZ1P6u+Fw5PHgyZP7fzRC2wQuzY+hLmxyT5UaaC+bfYmz4IdkxJfSe?=
 =?us-ascii?Q?mJGbghZwOoJ1hA/Ct7TmZgsp59lEhqA9TJlZRc/YPOYgblJ3fePpioD0JDnW?=
 =?us-ascii?Q?L+y6jNJn7NUUw50eD10dWOMnwE0L/CjdHR09dvFpajeyH50TwG/Do0G5Ni7I?=
 =?us-ascii?Q?zuYGZtTfk6/5Y2x51QI4sXT5DbW62oZvbe9XC6uYPIup0Y5YafqUM6sTUwZW?=
 =?us-ascii?Q?KpailsCr8I6uYDiulk5kEIjTWonlUJ5dOuCLa/YxMvHqKB4kEkfoR2KZEZZF?=
 =?us-ascii?Q?WZR/s8W16Zc9kjmXuAugXagV2+bY0TcZTQBMZTZv0btlUoMq6T8ZgA4e0y7b?=
 =?us-ascii?Q?xbJFXcJNVO/zy0dLGNXk0PLUuuhAHgGrVG4C6nmZDL58GPn2whn8mqCy8ES/?=
 =?us-ascii?Q?YJ1JhYAJ6rbHtn8MHX0GxIm6kSJNtMYfLdcjhiZ9OD/Wbi9AeTAzqLiKYVGJ?=
 =?us-ascii?Q?Vp8Ac2Nr52aXgedCBUdXQ1ne7y3/Psd6+qCQfZAZ5eD7zX3GX+Suy2UUQ593?=
 =?us-ascii?Q?kAU6bALGAgsenyLHeEKB7pwkMFskVsCx6Sk+j5how6nGgzG00NAA7Kw9ZXh+?=
 =?us-ascii?Q?M86ckixBWAvTan58Meq5/98HTxg43r7RLf/GsafF9WaD6NekjT/hnU656khM?=
 =?us-ascii?Q?jcHXrgWBXXjlcyTeOMINQT7AqxT1uoSQiUl9hGExDQj64Eo0N5VZqE2b0/IA?=
 =?us-ascii?Q?gbl2pHIGvYakFhO7yQ9SyOqDSifK4zqAYTjQh9+T4ASfKEVG8+0dFm0xzkVk?=
 =?us-ascii?Q?aHSIZUXABFRYSWT94zagbPS2/77FtEyNU6IMetx8FoEMchfuowgoszSuKySa?=
 =?us-ascii?Q?K7tNtUOkFhZbch1VUm3GLWOndCntjXCQVCK+/lpJmhhm+5onIB3CLaYZ5AN7?=
 =?us-ascii?Q?J3SaeV44pOkF08NNXAg1FRQlhx3VB+DIOLQCaTPDnjUKSRwxF+6G/DK5XMBI?=
 =?us-ascii?Q?xRP7sDtjLTkCY3HKkOc41X01OdUJpr4BD/Sr9n0Hb9nClDsbpsP0HxB6MJVw?=
 =?us-ascii?Q?gha5099MIPD95kvBmpKam6TezSrZA0L18MBnpCCRpwubU0kqzk3idPKPmcvl?=
 =?us-ascii?Q?CG4YVkGJdzuqsIwr/rhnj8XKEzucSF0pGVbbyP+ad3LpExQYtXIAe41df9uN?=
 =?us-ascii?Q?rwXCq2XYo6XRD9tEPlrKsTVVC9wNXddri+2Itc96zx8xBpd+mBf+0lcpU5kZ?=
 =?us-ascii?Q?yhzgOOc0M3VPOOjF0Z9lDYq+A5Qrc8D0eBL44ZcXMF+bhB/LDYl6s0BgAVJE?=
 =?us-ascii?Q?2A=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ccf0109-0000-4670-5fb8-08ddbd9607d3
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 20:37:03.1601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p8i+BGwq8f/Kak5xg3yQLyYAKEawg1Sxbtp41BEvOpE+24WNRHrUOMG20Md2vt1/z/NZNpIN33X1ANXUghZTXLSXIBXjiEiL2R3K/oQaxuc=
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
index 4dcfbe9b156..c2e3d0302b7 100644
--- a/include/limits.h
+++ b/include/limits.h
@@ -31,6 +31,19 @@
 #define LLONG_MIN   (-LLONG_MAX - 1LL)
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

