Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 355A8C3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 14:17:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7574D82A0D;
	Tue,  6 May 2025 16:15:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="d32iIDvN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF7F282A64; Tue,  6 May 2025 16:15:39 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::61f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92AC482AC1
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 16:15:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZDIP7qofJPXvAtsLfRSEGQkvu5vo/WT8BUjqwd0sS/F535aVYLQzud4CpzxfmAe0ACqP7GozpUIn/sHUppYPPA0YSgVCYuyGmf+SGYOGcstQgShhf0UHyZszZT1M9Xw7mJvX11ArURM2gsleu/0WSMclDT7yTr+6UXJZSFpt24nM9LB+cSORF6zx2ro9i6i1t2Ha/CqwBitaJuUp9kW4ECzTODbh9s7i1pmCXdUOzOACduG1A/Ek4tpN4sC25GFbL+HavXiFX6DmtsPNXNurEuCbnx6o9OFTYweH8IYqDarmBIxWacti5HmuDX/WE+KLtxALlj5p2fHqA2vfUktfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slaI+vUCkzTmR2qkQh1rbcej9Tv6g/LaQdsUEwUVaV8=;
 b=swc3kOxRyn7GcZEdfWoe7GsdsVJx1OgxnnwFAXzUVLIMx2An7vxHDhEHkqFPThWdB+SVlYbYcb2W+u/cYHEgFaeWocuc54PTz24+hA5EnUjL9lVLx+cbPzicP0jlsfWUUprfYngTv7bcsdD1s0ooVLcTVYUE/Qo3XKYUAU2/WqPAOc21Y7S2dz9oD2VFWAJ+COdgZXO4LDdJj54K+tDCC89ls0jJIgrCweWZAKOLVsXs1hXEzAWBDxUEor8xVCRgoJTQap1EiQmw8+51JkSukRQs93uK6JhHuYarE1P5KNyo9j/CqYaSMjglOa98qUjsExBVO5KjsZGGIs2Bhr4BIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slaI+vUCkzTmR2qkQh1rbcej9Tv6g/LaQdsUEwUVaV8=;
 b=d32iIDvNng/v8Zu9Ur0JZsHGSF7bRcrJEpPvMAEXyAvaB/DQmARZeiHYuKNzlgt+4qgKiUP8K2UjpwuDk0JEO0uo7WTrIkrNQHeC0tjLq5FyhMwR51Rl5me7l6xS/MDMTg9buq7A/GcntUQ3A2WqsfxA2+3caqHY1rm5whlQm5I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ca::21)
 by VI1PR10MB8208.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 14:15:32 +0000
Received: from DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bb5b:4bac:5471:b769]) by DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bb5b:4bac:5471:b769%4]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 14:15:32 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 11/11] test: slre: add tests for character ranges
Date: Tue,  6 May 2025 16:10:35 +0200
Message-ID: <20250506141035.385756-12-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506141035.385756-1-ravi@prevas.dk>
References: <20250506141035.385756-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0012.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::31) To DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:4ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB8248:EE_|VI1PR10MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: 2695b982-401c-4d65-457c-08dd8ca87627
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cx5lw0d/ut2O/TdRbQkw2iiqDvzI1BUEH3ybs1W+9Aiek8Wl2M2kFEx8rnJY?=
 =?us-ascii?Q?t7anhFudmNFsvFpmEiht1Carl1Vr2e9ARsuXa2YeFBKQbGM1I9LBPvD0hpyq?=
 =?us-ascii?Q?GvGjDhCoi90bKMe7pID3C8bM/YRv+6HaBrUyIOj43JwFB4QF9gvb+vKWLM2Z?=
 =?us-ascii?Q?3bMtoMOfXXvfvZGtJTQGXTR0/2FFHjsBO/Mvs5IanE088g9B9QI/K+QCl1hn?=
 =?us-ascii?Q?zMjLKe5hhR2xxYYUJMsV9b4KBkW1WeQWxOjKeMcjM3JCv4AFvZIKEDvDW9z1?=
 =?us-ascii?Q?QKLpSgZH7UbJWy9pFG0alvbKazXfbxTYCFuZ8ZNQgwYUGFz9zc7hdu4PbkWG?=
 =?us-ascii?Q?3hxHVcQXfBcZQn8pv11xXJQZOee8XLq9aPJc8IpkH7JOGxcOAu8RauB6CDtT?=
 =?us-ascii?Q?3fs//4bXkPrmYizbb75vXEBWAT6HOK9RdzFStNn3AYc9WyN7B17kazzsLUPW?=
 =?us-ascii?Q?icYT9KPUETQ9b/mbFEt382yumfylBCbHXmKV1rpH1iqnXV0jK1TJgXox/ypA?=
 =?us-ascii?Q?j6k4RSmRvxQzEXppKIYS8IInzx/Z8RPgb5MKBtx0gC3OpMV56W+jP+oncojc?=
 =?us-ascii?Q?rbZuxpahXyrLvCtC7YsMELFCTbn84LM+j2pUrAvjUSff6ChyWMTE5nK2YuS2?=
 =?us-ascii?Q?MDExjOP0pr8RiHsPfv089wM6mINONaHnmzGuQzICy4KSTkcQmcVEr5+vH/fX?=
 =?us-ascii?Q?FRsRcyYS3TVbjOC5vKvZJ2b0vYbZzS7nvhn/iu/o0nmW5nqGNlaYOK6lH5Jp?=
 =?us-ascii?Q?W9ObIAYVrpdjr3l/i5gFmTNo3D1J35YVzZHR8VfYpg9Ba+1Mc+oYHUVyvT5p?=
 =?us-ascii?Q?C2n1xlHeFRyNnnGtS0fh8+8xqfcYd0u2i2b0a/L/S3nwed94bO9SXY5kq6dn?=
 =?us-ascii?Q?z7JmmBmvKeO22TUrLjPtahs+hGnzFIAIotn1qNncube8iwZHTYpoOPmYkBbO?=
 =?us-ascii?Q?IChiigXU3Z/3+tmi5iCSR2azTtXOHP5W0GaEJPHNobtmT0HU9lkU0yIQMXDo?=
 =?us-ascii?Q?aatIphrGLBqrDst4Jp+uPA2IJccGo0lsX5njqaDM4W8B52EdrpBYHugF+FWw?=
 =?us-ascii?Q?FwoW6nrLPRKnFppZFLT/vrytYYjLDsZMDP96FX9YbtkZHHAyPYJnCkoe+bXd?=
 =?us-ascii?Q?vCmzZu+PrHSn3UQqivtj75eDH1Ml1W1/48ri7j9U2/XOv+aIxufy+ZWUMy50?=
 =?us-ascii?Q?8acSFfGLpJVWeeTgZ7FFa/QEbiXTsslzudGlTj3sUHZ2JrgqRO3GKVv1mxOt?=
 =?us-ascii?Q?UJYkoUXZlOGhg/v8+SZDSP6784WqrCLRcEsptCNfnOkB1w5FkeO/0TSxz01m?=
 =?us-ascii?Q?CnDJKz4pxpUSiRbAi9FBmUOYECjHbqem23uexj5xpA10oU/ZckdAqa/7Bf3z?=
 =?us-ascii?Q?F6IvlSsifWOD68GWZr9bBJCc6i/hTig+FFl6d8W2QHMjKgBdkyLXIPnXOom8?=
 =?us-ascii?Q?s6ZNC/fYCsWLD26jrMCue4RVIHrMYakdM56H0ViqvOZEKkQb8wFOoA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pCo9vUdWyom0dXIcR2l3G255xFW0o9hpQEm7CEXAzO15N92iIwK4kGvFYvCI?=
 =?us-ascii?Q?jPQFWoEy89zB/8ItdqLGLBSwceDsIDhFFDTLAFSNJBw4bl5ACmclioEARBoG?=
 =?us-ascii?Q?7gjxvs5WKFuY0SpHblBZUhpFd63zBpDKodozOEzbp7iF7If+4KelkF5w8grJ?=
 =?us-ascii?Q?yMUocOOBgzHMAHSbQL5wfaOlLQt8yinTX2ZKRwFTmTcpw1AT+s/+sNNgfbUS?=
 =?us-ascii?Q?Uz3CVVUAIKXZ2IVpoeQacOV9kkRF25yWg6l4cbpAvD+Huba3x2i0LBu8/wAU?=
 =?us-ascii?Q?LN4jYwj5PDxVM39zJQ0Kok6+2pCwYd9HBGMfxqsCCSOdgLk0qTS9k7IB3Y7t?=
 =?us-ascii?Q?T0i4Igx2r1HMbF7QJP+asp+FZJc1ZFvCak8/LmA24yd5Is8qOXqHpcXpE2HB?=
 =?us-ascii?Q?Npcb+dIIHjPRZGZ4sond0Mu3J2HuGDkVEiHazMbckXXUCylJgbpcHj0js4mu?=
 =?us-ascii?Q?wOtVVBvduRENGz/znkPBDe5OlcLbR3O29fO0SCwVHgJFobrbqR0Adwf8TpE6?=
 =?us-ascii?Q?oGn72aMosxWMNCtH//Qt2T/cRlwBA+eg4G+dJG5+wchHsxczr3xJaVKRaP1r?=
 =?us-ascii?Q?mDnT5OeQSuPXR4VbE8kncb+TYz0xdRl3Gp8iIPPoq/itKq/Wd5XFrNSY8FML?=
 =?us-ascii?Q?DKN5JBfq8PSs84gxTTUmSn89kfzahYJKVpiqqGl9L03cMBsxVLbjpE33GR7p?=
 =?us-ascii?Q?Z2KDkH5BH/85FXhiAiHmBon8bl1afpZetd3C6LI+o4fURh6Ec1iU+d9UgZfa?=
 =?us-ascii?Q?71ZBhtY1e4JH3PGnxMv9XNSnstueAAWuXL0N3L4RM38siVdT+TWzWSPlyOm7?=
 =?us-ascii?Q?on30gj/1opmGBkW43V4JPVfPeQES5X93F09FSceYRxNrzkmEuAfsFqkbg3FZ?=
 =?us-ascii?Q?UN2+DxBSBzYS6/NzgHaPRGqhItI3Qgq92VZ1hqGp2pXpOBAzfJDUkdKRFqUI?=
 =?us-ascii?Q?7JNS4HTKGQ613+GmY/Tkr8zV1BhdwVol3j2NK+rKdXLiBdEYXu9A/Wl8ESTn?=
 =?us-ascii?Q?/A7OhzuQZQT23Y9ujn41CZ/D5gcKXty92vuuEqKn58gTitAH+c2qgplaa/PP?=
 =?us-ascii?Q?WX7K2OKhDOIGb9XHBHYFo67dH6GUiSf7+jX0RnwGSjmTPbjBsXB0DLgaWkYt?=
 =?us-ascii?Q?HPY0nD7tMx81KdAFieh6nQOjmjzw1ATCCN1DCEdxZ0ltogIKeIbKjhyILIjM?=
 =?us-ascii?Q?oqIae/I2yf0pg12vBPLPptmpWMKtVXn4c9BilK/XZmTxVew3QXxzjQz5MyAS?=
 =?us-ascii?Q?j8E6ERwt5WuO5005z0BllwwGM/w/V0MpLyaFB2mUGNCbfqKQKF/y/KOMCDqv?=
 =?us-ascii?Q?grgLlOpVNUmx9s/wGnswjzYM+vwui91oI5PqSTK0lK7drslxY/HRerQj8fJM?=
 =?us-ascii?Q?KgkUGvzXN0g5bjab+TpB6noVRAyqdeVE1ISMMSF2y1qcCNF/s9PR2zLcsdYV?=
 =?us-ascii?Q?Qro4+k9S12NpVSWC4EWnrII3ItkSyEbYkQobFBE6innI1USEO1RA/jj46nho?=
 =?us-ascii?Q?7ruC608IG/mluvScsFHksZWcqFR8vgZ+NEdJSI8nVF147B+wwnlsKEJAHkIB?=
 =?us-ascii?Q?NLLVRA4lREg6RMGctq5nCDanVMmPDobSzKpDCIS7TUUzA+bYHFaz2DDlLg+9?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 2695b982-401c-4d65-457c-08dd8ca87627
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 14:15:32.3070 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5vkUQkF2AiB5/xl2GDnXxA8MabpYec8Q8hCcorhF8+9MMF/an4gFuB8ujJPg7myrRRd9D63LKwGfjQ2vGC8YUgO3KHSaqQr+4MUIeMA6w0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8208
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

The first of these, { "U-Boot", "^[B-Uo-t]*$", 0 }, would match
previously when the - and the letters were all interpreted literally.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 test/lib/slre.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/test/lib/slre.c b/test/lib/slre.c
index 053d046075e..ff2386d614a 100644
--- a/test/lib/slre.c
+++ b/test/lib/slre.c
@@ -29,6 +29,14 @@ static const struct re_test re_test[] = {
 	/* DIGIT is 17 */
 	{ "##\x11%%\x11", "^[#%\\d]*$", 0 },
 	{ "##23%%45", "^[#%\\d]*$", 1 },
+	{ "U-Boot", "^[B-Uo-t]*$", 0 },
+	{ "U-Boot", "^[A-Zm-v-]*$", 1 },
+	{ "U-Boot", "^[-A-Za-z]*$", 1 },
+	/* The range --C covers both - and B. */
+	{ "U-Boot", "^[--CUot]*$", 1 },
+	{ "U-Boot", "^[^0-9]*$", 1 },
+	{ "U-Boot", "^[^0-9<->]*$", 1 },
+	{ "U-Boot", "^[^0-9<\\->]*$", 0 },
 	{}
 };
 
-- 
2.49.0

