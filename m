Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFBAC83030
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 20:37:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44F13831C3;
	Mon,  7 Jul 2025 22:37:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="jc50UcId";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7FF68320C; Mon,  7 Jul 2025 22:37:08 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9CF2831B5
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 22:37:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jYwQMWJwUxrCHFVdhKfmUZpvCCwKAB915OrtEnqZiXDISxIoASvyhN1L4EoK1PSmDGtynVhQ8LV1pLWAt57iBkP9KcdPs7rT0hJyXAM+JPEKHXZfeQmIJTNzj4nPgwcUjIH/W7zZR+K1mU/vh9DgV1g1IOw+0Vtt0xdHGeyAxkR3BhLjvMABiBPpyV1y6oQZVlDacg0V3gywTZwwtKX1DlL8yap2z5fl9DlmWcdKxTGLlGyGk2Raru8ppnZ08b/NtAw2ZvLKYuAJ3eKnZuODYG7R7uTbikxe+vJ8zO3b8RTq+HmA3OjGL6njHDid4m9NUlYMpYVVBeO+15UJcdz4Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBdf2GGEzjm0J+Y6M6VzyqloeBsEUpkNnyLNeRvZ/pY=;
 b=Xvkp2oIk8EdK8lkZiCVyXkCXpqxTCEckt/ITj50vmKd9qFxrM0BoZ9avaaCwS+4YiXtbOnA0+NFGczMO3uFbcWF1ZDk1KTLETHfGYzn3dBxTL8GtTUBEACHkZ/9ljfz7n4uq3k++y4oRHqw3YuXlaPmPxQdpqY/h3SRVZlLvUoKab2+HI5bxraYGgRp85iMaaWpWTFrxFB2e/MUFUFI3uq+63bQsEGfI1w/CalH+9wV2O6CW8/839MoCMbu7RuepKwsFzVu/x9Wjs/hEek+6yjZuNmpo2B+r9KWw5i4nr/pTCMFJG1ZTW7tUTITcuNkWlhfbwjZBiKY16cwB/zvFSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBdf2GGEzjm0J+Y6M6VzyqloeBsEUpkNnyLNeRvZ/pY=;
 b=jc50UcIdE58u915KjDRXYSHEHo+ZaT87XaFN1ngUlRUuPLNzzL8cfV+Ha60CXObHs6duUeL7XGq8lEMGI60HJrl6wZ6Y9duewE/YiM0tdXDnA3SYYQF7RUCf1HeDNrytKSkw6CGPEm99k2lu6MN+EB7NyR81ZJUiJot1P7vd1lY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GV1PR10MB8860.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 20:37:04 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%5]) with mapi id 15.20.8880.029; Mon, 7 Jul 2025
 20:37:04 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 3/3] limits.h: provide all limit macros for standard
 [u]intNN_t types
Date: Mon,  7 Jul 2025 22:36:55 +0200
Message-ID: <20250707203655.613340-4-ravi@prevas.dk>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707203655.613340-1-ravi@prevas.dk>
References: <20250707203655.613340-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0058.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::25) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GV1PR10MB8860:EE_
X-MS-Office365-Filtering-Correlation-Id: a5f9024d-75e6-403c-eff0-08ddbd960863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q6rQOo0L7OXd80mrU/pXuGQRHWPGIkrUS8Oz9zdDxYdTEj/kGQ/NYmjEdks7?=
 =?us-ascii?Q?kRRCguXJgairoGNQ/+RXIb36yD+DMtae3DV821IcOEQOf1waWnzWIzXljP8m?=
 =?us-ascii?Q?nXUBopHFNI3J0iXd4S7Cwl4RXYbwFp5imt771a1NcqBw1WQt+zBkR8MrX5CG?=
 =?us-ascii?Q?I+tQ21T4vUZ/1vEsXYs7UebE7K+kB37BuHrqR9KVZOejBWuVcV7JLzjRJiXq?=
 =?us-ascii?Q?mvKMlWDit2wmr4GV6Ji5YyZV9DutG47jBDou3yc+tyNKeNyV6J+IJTEWl/qG?=
 =?us-ascii?Q?2VWlQqhk3uu2STgtkQhKTMLwcyfaegNi9ia3j7qO4NDds1y61E+F8C5l7EQE?=
 =?us-ascii?Q?pTSL9Q1eZlfLChiT6iWXfsVGt4P0TevtAHOIGH5leUU2yyl72XQb7CijGur7?=
 =?us-ascii?Q?ca6ltQ2HH9s4tcypXXx2iPlUfPFAYlMNftceDoeJjWmaHsPvxc0Jf3Wwt4Gq?=
 =?us-ascii?Q?Dz0vivQkXkJhH/KhmHOtOTb9sVAhSBvJYR/sVpPYeasPvt/I/bwVzKvdyFg6?=
 =?us-ascii?Q?VuB5LntbyK8JHMh0qnPhHp93UydGlSsW2Km7FmlGKN9fKQzrQHVo7wV0KFJC?=
 =?us-ascii?Q?Z0ojgxeM2nT25n8FFPpAzIaMLvgTFFLDzv8TngykRnBcoV7xq/sAeUTmznQj?=
 =?us-ascii?Q?bEeBLyKMCinWX3Kv9d6DR1h0N6LpSbYu60SMyPCmGsFn2z3Bdp8BzG02e8Xb?=
 =?us-ascii?Q?248Dz/k7KqNB/QURJAtqg+xYP/6Ksp7nkuvE0k/o6CVDPepfknWpTUQDwSGT?=
 =?us-ascii?Q?R0qzXkIAshgc7Pch2D9VBPq2KQWp14an+o76H92dPMrFjbzxrFOhsRWMJ6uK?=
 =?us-ascii?Q?9HAmy/gIk9kNcrWtFxLdXLDko62LeBZ6I4xzWAlhsh2PzBPchHXl0RjDqz3t?=
 =?us-ascii?Q?AHK+BbCzec9ka2H5RmvmxgMI0s2fWVTdHwOZrrhaGV+ruG9CJTN/2kQQZP6+?=
 =?us-ascii?Q?+eWI9hsPE+TvdKALMDlVuEp9cKAexSZU+OYaPbaq6P17kwRVHNBF1/fwoFgv?=
 =?us-ascii?Q?P3svzRAU/XEnwJ9vpcRcDe9MQWaAjPD4r3LkBa8gjEAssyYbo4oX7FJghFmt?=
 =?us-ascii?Q?Kert9WhTojpNQLpC9gmRUCnVEzDgh7gMW7dsXWP/pUHEd06jJ5HkawWpYD98?=
 =?us-ascii?Q?OJxbR9HTmGR5M9N5JDN7WLJvNDEKzzL9NINLKdU9OsGprskilnZT9IwQkYHo?=
 =?us-ascii?Q?8Mzk+tS7e8qLHudk9EsLgGzdbh6OnzNiY+bLY5VA2+tuH8gEIPQ3YDkFJvBz?=
 =?us-ascii?Q?GhlMZyUhXB+XToVrBEgwaIZgr54JjUw9s45vu7a5likM3iPOaAd7KzeSo4ue?=
 =?us-ascii?Q?k1vxqLn9bAeMioAFWCN0vNEgo+b6/hBgB2mGGFs6y0KTVt/jp14x52GO9ARy?=
 =?us-ascii?Q?2v4M7/G4zFGYUA/RW5LLn/ChM9gWnrttmo9Ol1NZr99e3VBC1wmAb02FBAX8?=
 =?us-ascii?Q?od1/S+/Z/ibVFyOeKkgsquPCMBO0T5+jAquydzMjOGRlPjEPyjKPyg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j/iL91sNLfbxyPvU9MbXT2F/aA/dg4YUfgb2HDn3MUwHCIuXrIUkYyNfVpln?=
 =?us-ascii?Q?wWVwdk8BqTdxrPXR/VR4mQHNJyiKYxIckkUSTBaIsDWdsxSAemkf90emA9N/?=
 =?us-ascii?Q?u6a4T01AV3LegM05+0jdEnso2wafYv7OF6OwYPBgV4iy+ho25fLZeHm/ZhGB?=
 =?us-ascii?Q?XUJDxGMozq9Xxt4KwGsKE0wYA9/UvfTeriFjuTLf2q+FltEZoexe2jf4bqpF?=
 =?us-ascii?Q?mW8Wu6DwRmbBxuFswM0dK/iNIW7bfCr7clmvhrazRDz6OgMAVYqpRv1D+6Xj?=
 =?us-ascii?Q?FfRTnV9tRKsKMtanxAsuEI6RB/18EU2xTKyBkKKtM54lw595Y7EMt0I/tBSx?=
 =?us-ascii?Q?W5EmU8Tq+PwhiWvtxTHIlxNy516geM1fr2QqjN6geiEz/Yyh2cVDeQPE3jUz?=
 =?us-ascii?Q?fm2fsqxfokjLJyiySrer9kTRbdHqqWawskQcQBX1z47c5wbf5O4yH2F8j+Hm?=
 =?us-ascii?Q?6CNlTpRfhNvlgrMyh2LwFRG4A59xbIhGwC90y4gEy/UgqoY7Dx2CnWnHPY39?=
 =?us-ascii?Q?ST5lNx9IbQmOACaQ3ULv71shB/UgMSS6Oo99i/Q+fJzDkyuLQzmXlMmgbGY1?=
 =?us-ascii?Q?iET1W3g+1nWMo+MnpzMBfY/cOHCFkOaRmZFYAmDTqOENGIxs91XNi78CcVGh?=
 =?us-ascii?Q?dwYZiDYYHiEVDo5HQILJqlHCT1VlkFj4govWhQacmArk1tMi8TvjxUJA4SUQ?=
 =?us-ascii?Q?SZ3e88OWp/JJZy1qClx7z+kvFRm4IV69GhDl0P7sy9DUuSuTYBOSOunng6eG?=
 =?us-ascii?Q?IGE8gJNKiuMQOkAn9INh5PfbkmPhN1Dquo85zIdZGvxCHS3K9sf2WR/Z8n3V?=
 =?us-ascii?Q?MPF7chLhyp/Oeav0ocBqCRsl2wgDWoNnY3niDgbBKUaRqz5VzWRZx79QjbDu?=
 =?us-ascii?Q?2esWrudCcYXYtPF7sxGPn9wP/eSYYJAoCwOkXZaABTA6hsu0W0QgSj8+Owpc?=
 =?us-ascii?Q?HjNKDbVLHduhSMGcrstepy/GQgpcJ2+1GiPjK29HvqNHST9lequq6W3Kx4pb?=
 =?us-ascii?Q?LtpUApgy1qq+IyUKmCW7fiGBiHjDScd1sn7ehuIN5dO4ncv9qe3R2IX6i/oT?=
 =?us-ascii?Q?eSjrA/6E3XEtUygmpbgihH6yMSYCZ/uPPTFpeAU3r7P7bo6OVFrUL3v+2xwt?=
 =?us-ascii?Q?hysXR63OMlopunhGJa87rcAO1xTwReoqIDDFLMwkdQHezEbc9EbclDnotMxB?=
 =?us-ascii?Q?ZYpM9jROqLY6WbgKukFzBD8oqX5VpyZNIHobqPBaq3jvRSMvvgYu7DzTFgRJ?=
 =?us-ascii?Q?ZNyPqPw9CDgx/c/OsbOJ0eFW/29AkSIP6ILIi3hQezLQTt86LdMV5SXjFhm1?=
 =?us-ascii?Q?8SUot8Ae4f9R2jTizLgC55+OLaeTAxLE+zpsmpSLrY0ADhO57q8h4qvoua9I?=
 =?us-ascii?Q?S++BDvaqD+VOzqDUmJ/eFCsqAHuflmOEoQ5zQVRRUr7fgXyBoGPIclqeMpZx?=
 =?us-ascii?Q?ur6VluWNtdsMCpBmc5YwdcPQ5frwCxL+EIDATbaY6KCEzZVkYS0RVru+dUWt?=
 =?us-ascii?Q?g+/6laojlssB77cJuwjYR95Bj79fs2Yke/I1b81E7mI6WPE+uthwJz0SAg8M?=
 =?us-ascii?Q?QyflWa7JhOuHdkmkUbhHpGaUITYyjCCKOAiYSUA5aWc7AkGVfdmnnjtQhmra?=
 =?us-ascii?Q?WQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f9024d-75e6-403c-eff0-08ddbd960863
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 20:37:04.0907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /6cXiAo9XRhlMm9M84uDbx6D+GgJ2qiUglxMkCpyJR4BMSlkzSLPwLzKLmv3tWy+zQ2BhhoALHq5sRPuV86GIdfuIwZ9w5pkQOwINS8JhkY=
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

Currently, we only have UINT32_MAX and UINT64_MAX in limits.h, and
then stdint.h and kernel.h somewhat randomly define UINT8_MAX and
INT32_MAX, respectively.

Provide a full set of definitions in terms of the min/max macros for
the types that [u]intNN_t are defined in terms of, namely the {s,u}NN
ones.

Try to avoid breaking whatever depended on getting UINT8_MAX from our
compat stdint.h by replacing it with an include of limits.h.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 include/limits.h       | 15 +++++++++++++--
 include/linux/kernel.h |  2 --
 include/stdint.h       |  2 +-
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/limits.h b/include/limits.h
index c2e3d0302b7..a032bc5b84d 100644
--- a/include/limits.h
+++ b/include/limits.h
@@ -44,9 +44,20 @@
 #define S64_MAX     LLONG_MAX
 #define S64_MIN     LLONG_MIN
 
+#define UINT8_MAX   U8_MAX
+#define INT8_MAX    S8_MAX
+#define INT8_MIN    S8_MIN
+#define UINT16_MAX  U16_MAX
+#define INT16_MAX   S16_MAX
+#define INT16_MIN   S16_MIN
+#define UINT32_MAX  U32_MAX
+#define INT32_MAX   S32_MAX
+#define INT32_MIN   S32_MIN
+#define UINT64_MAX  U64_MAX
+#define INT64_MAX   S64_MAX
+#define INT64_MIN   S64_MIN
+
 #define CHAR_BIT    8
-#define UINT32_MAX  0xffffffffU
-#define UINT64_MAX  0xffffffffffffffffULL
 
 #if (defined(CONFIG_64BIT) && !defined(CONFIG_SPL_BUILD)) || \
 	(defined(CONFIG_SPL_64BIT) && defined(CONFIG_SPL_BUILD))
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index d3d979834ae..e0443ecac84 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -5,8 +5,6 @@
 #include <linux/printk.h> /* for printf/pr_* utilities */
 #include <limits.h>
 
-#define INT32_MAX	S32_MAX
-
 #define STACK_MAGIC	0xdeadbeef
 
 #define REPEAT_BYTE(x)	((~0ul / 0xff) * (x))
diff --git a/include/stdint.h b/include/stdint.h
index dea83c8226a..90fd2bdee08 100644
--- a/include/stdint.h
+++ b/include/stdint.h
@@ -9,6 +9,6 @@
 #ifndef __UB_STDINT_H
 #define __UB_STDINT_H
 
-#define UINT8_MAX	0xff
+#include <limits.h>
 
 #endif
-- 
2.50.0

