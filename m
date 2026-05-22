Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A81CD4F3D
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 21:28:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1BF0848F0;
	Fri, 22 May 2026 23:28:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Mq+LiaAk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FBC0848C3; Fri, 22 May 2026 23:28:09 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB672848C5
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 23:28:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b78Luzmfs1qs1pkhs+hVztytWtmd8SJmME97sVqAls/MxP2LX5+3IDen1+GoVanEAjf6noXwfMb+YfHlEur4Wh2ZMxLdIzmOMXgT/bS5RtcRWh5MvHBV0PQyKt4J3aRDgmbIBuX3KQcpNesqTGwKYz4+xjQfjwMrHbNcl5FWU2oICwFLx73k0Opya+waiTp2fd6a5QedLGh7HuDN9lW3FOAQlGELehdNKb3P2OYUlQSABaAZFtSKvBPHCNlSiI/bkI9+iCy/G8h0MMApIusJYZL8sMYvHSDT33kDBklmWYvThPx9tTrZgxCYotIB6Qs3rOGrp1hTOzvSQYOx5JzYTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21A3G2QLGXNxUEO2UKU7lWqwFNsRcVVaKiGpe3p8cZ0=;
 b=PEjs1YZRvKXvAyV+tbi9sTxxCwciXBX1NpGauny5BNKr9/BPsUNsFEROINV1gImYAYFvz9WjpYGhhia0tJQGpyWelFxudYqtsnAgPFlAQYCPWOJL2W+BKHhtFs70G22858t2obnJVIGyLxP5pAdRJuRhNNxKe+NDsMtavmoh3eM0BEKNbLl78oXun0HHhLUPR0Tw/zVnPS0L42TiZl6Dov4w1RrgdjkW5TBEkerOHoSpyQ6zTfZwf+q0O0VWV6mvZEvIj63v8hOj7ZLbWHBewhFxxd//ezUF7+e+K8sYx+wrLlsVCAdSbZ+aTW+aKc6t2Mqz0ZlLbMagnkAU/xeptQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21A3G2QLGXNxUEO2UKU7lWqwFNsRcVVaKiGpe3p8cZ0=;
 b=Mq+LiaAktTzromvosVCNpzCAt5o/nLPz59jASclg6AVjdCI/S4BeiajldIsicnXqE6pmcDHFE0raFPnNnbRc3NQ0rD+f54kKDE11ciE2GTr+wjcte6wA5ytPGVKU3WR6NhSeeiU85VXrGRV8nTzv2EBegvQSW3TDiTXoyUXV6mU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU0PR10MB5385.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:340::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 21:28:04 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 21:28:04 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [RFC PATCH 3/9] event: Remove obsolete comment and __used attributes
Date: Fri, 22 May 2026 23:27:50 +0200
Message-ID: <20260522212756.3169222-4-ravi@prevas.dk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522212756.3169222-1-ravi@prevas.dk>
References: <20260522212756.3169222-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6P191CA0023.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8b::36) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU0PR10MB5385:EE_
X-MS-Office365-Filtering-Correlation-Id: 30e91ed5-4156-4036-14bc-08deb8490218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|11063799006|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: rvlniXuWBzdQAErmf1mYxx00oXL0j/PNUkU/D/huAYTentoyLfwHRuXmhByAYWIOO6MwPbfffDmeHugkSUAZi5zE+qbpcrVj3DH4NJqv5shHzcK4Ul/F7/bnmKZ7i0MkFNVuBvbbfqs414Daogsqe6GZzFSWGueH6UfM6KT5tcUZf7Xx/FP+cvxIpIovGbTWZ22ixiZL/BdfSlmINm46c629rHyZVDjy7Vy0EtXy//546lvlbVJT7vUmycER4CtFDcRI0rTGY8furJCZ+iBdcVjcF6WVylp9EKiGG2Qub3lCizdNYyAeEyHAAWhdpJfPEEAVUWcywD7IrsOqWLPLgnd4W4rBsNF7T+eJA6SK3/RU1XWdJ4m6ayuRnJFbkJkeXIdYIl5unaieaInjYoTHmTauyxtglS9LHyQcQiVtktVI5PMFKlnv1t6/74LlihsjDIvMDNoleQ1+hMnyxrKARJqR543e7Y4cxNSeImhLlhLFzRUAduZSIjg6A48VHthDF/sWqLzlEYy0pwpchL9wiVHTN7WEPj8pDM3+BDifG32QWnIEpmdWH2kqZdIpEhvggFQ0+OPACZSLrQX0wDGuIpdvRaYODjuh2PKSsXxNqxnAJNr6Uo4/TUHDOlztdVksH/u05ynxeEaRtJOcqY18lht3skrkhMLVEpcyUNTt5ApzaU9lvT2Y+kNr8f33flA5hegVa3JRskmnBzl70DqFLVGfATAz3vSVRAI1ijzoPmgH4OIZNTlDUqMjCL54nBVA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(11063799006)(56012099003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iBD2OIeDSdVJmmavgvDKPC4W4CZTZl2+PYl2oet2QUWFY/r0gkE0NDeAiYg1?=
 =?us-ascii?Q?+l9BeH1bk3xyZ3sLjoT3FrpsQNbRc6gUSnUs03/23JAPCBywvRreDXvoSwQx?=
 =?us-ascii?Q?tsTHTMe1gCymucE91DnWKg+vEuSJ7UKrFOLkPoLz5c0+LjnfSVuFpyUaX/WN?=
 =?us-ascii?Q?i4RPn/WsnC9jAzUKFoqPwNOi4du++NUxxqKrYnPtChv/m55l20dh05QdrTHM?=
 =?us-ascii?Q?usTHMnVG5Gd9L+Tdqfzj8co2M9evQ1VqTRz4jNQIYcpN0W3gQpKVVB5KBSiE?=
 =?us-ascii?Q?DkuJBw0nIt8YQ3Hj9RU5cV8w3dRa98j1wJ9Cn5YA/asWN2gK198dmjpNjPnO?=
 =?us-ascii?Q?4l4RSGW0AY/YIG7L7trgiYDWT5KqwJp9RZUOlycS9rxUQ7bWCx5j3gwDP+x2?=
 =?us-ascii?Q?v1h0yfHAIgdiLOJk/1WrnF0APqAAQKxbJfV4OMiChUb9u8SOjjaMLw6Xrvzl?=
 =?us-ascii?Q?3ZxfyGq7C7vCWU2/T7BOEDbxUMkr1YEYhTIRkkc+uG+gC+lOINSvlCQ92+mh?=
 =?us-ascii?Q?mBnZYcRbx3X2hJR16/mCHbZhd7HkAweGinnWs7+Z0+3Qf35NLAjPoHeXHMPK?=
 =?us-ascii?Q?yVSeEAtDFJJ8RgYvcGoB4QU4fNtJZerB2r16nC8vJrsywJBW26EfhDWDOSYy?=
 =?us-ascii?Q?f/JlnSRcRjvAtRG9viIer2J0NeUaCeLkMQeVh4+klm9XeqLNT5i9yWJwOQWd?=
 =?us-ascii?Q?x+mh5qG2QP197t0CUSNruY3X1IxW/l7A4IR+ntSN/doExMR6ji4iHuEjalrk?=
 =?us-ascii?Q?I12VaZLfmV9DQ44IRMaxYWC/P8GUTpRm0nWocZu5ajyoL6fGCios6d15SFs3?=
 =?us-ascii?Q?3r9SiRMRBRqQ7Oqx5wydooEoTPjbQq50XTjN/rq0LNshV92PWCEBIsBRMDKB?=
 =?us-ascii?Q?T/Waqd4AiFSrfghcOqdDRF1c2fQrlyKa+JAl3BkOZEqvzHMbOQHoaDvOnL9m?=
 =?us-ascii?Q?rg3ZAL2t3d0iUIGYU5brA1aYUCGyIs+LwZZ7tBDttFvKbOBmq7p5pv6p1RJ2?=
 =?us-ascii?Q?bOxoNmZDnT6HeKcrserq+iyoTHsit1hXDm3hpixs+qI9XszKlarM51IQNauJ?=
 =?us-ascii?Q?e2A6+18BqhzeYxDTBjRaL8GRm9FrBaIm6jZV/b2TBQaA4tP84GZ6nv3HhdfJ?=
 =?us-ascii?Q?yI7KvRA8b3i1k90dyW5YvuJ4/qOQTIJ695/FEWTtlmc9g9qjtfukYkYxFHBR?=
 =?us-ascii?Q?0WU+PAGXI46eAztxBPGaSLOaZj3vY9+wYJN5W2sQhdQshW4b7wnGs1DltJbz?=
 =?us-ascii?Q?+jykCzPfbs4zcMRo4SKDeNVgBvbxMFuhXD5hITae5CotaLP15ae5h0l3H/aQ?=
 =?us-ascii?Q?ySJJO+gU3UXmr96rbDttncPDVynz054Ym1caBH3ezCkqDDkvuST+sQoMTkOr?=
 =?us-ascii?Q?EpTBKebpklKAMy/YYcfbouK7LoeGTz6OidALZ226WBZLHtODQiJ4o0dMDfqo?=
 =?us-ascii?Q?JzLZnjoFZpoRe0ZNXE2FdoRAdbXGSd4TK5hIMxTxQbx8ozjbZpxis6nrehF8?=
 =?us-ascii?Q?xaQs6e/HO2GjF2d57kFUBrW/XCX/6IKGr6fJvQHpoB7kb94M/7QaJBC6+Qe4?=
 =?us-ascii?Q?uBSKSfv9p5TwyPuPi1PQGtYaCJIFFUMfiN84QUVb9fzdPenjzzN5zdltHjOI?=
 =?us-ascii?Q?7JdAO34CTIFdnw2MfSH6FevWIz8MHlBRQUNFApPd2LKiZ7A95RNQHmXQjGyR?=
 =?us-ascii?Q?xidmSa+Sn3v2ofup4073tmtOagl1tsHkpH8I2YolkFTABewRyqecyGU9QUe6?=
 =?us-ascii?Q?5HfBf9c4vclrlGIy0jpu7Wrz6n6t7ss=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e91ed5-4156-4036-14bc-08deb8490218
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 21:28:04.1773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IcQ7aHTzCiOk0//I924iwkmoZhJS5vspkEoz9E0UJ7Wp/o/K73oYnRXlvSUE1C62ld5zE8ynfKNmlcVtfpy9znQeBguCySqrTLq9CO3AyiE=
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

From: Tom Rini <trini@konsulko.com>

Now that we have both resolved the problem on sandbox that lead to a comment
about linker list entries being omitted as well as made linker lists
never list themselves as unused, we can update the event header file.
Remove the now obsolete comment and "__used" attribute marker.

Signed-off-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 include/event.h | 35 ++---------------------------------
 1 file changed, 2 insertions(+), 33 deletions(-)

diff --git a/include/event.h b/include/event.h
index 3ce5f992b04..450281f666a 100644
--- a/include/event.h
+++ b/include/event.h
@@ -308,44 +308,13 @@ static inline const char *event_spy_id(struct evspy_info *spy)
 #endif
 }
 
-/*
- * It seems that LTO will drop list entries if it decides they are not used,
- * although the conditions that cause this are unclear.
- *
- * The example found is the following:
- *
- * static int sandbox_misc_init_f(void *ctx, struct event *event)
- * {
- *    return sandbox_early_getopt_check();
- * }
- * EVENT_SPY_FULL(EVT_MISC_INIT_F, sandbox_misc_init_f);
- *
- * where EVENT_SPY_FULL uses ll_entry_declare()
- *
- * In this case, LTO decides to drop the sandbox_misc_init_f() function
- * (which is fine) but then drops the linker-list entry too. This means
- * that the code no longer works, in this case sandbox no-longer checks its
- * command-line arguments properly.
- *
- * Without LTO, the KEEP() command in the .lds file is enough to keep the
- * entry around. But with LTO it seems that the entry has already been
- * dropped before the link script is considered.
- *
- * The only solution I can think of is to mark linker-list entries as 'used'
- * using an attribute. This should be safe, since we don't actually want to drop
- * any of these. However this does slightly limit LTO's optimisation choices.
- *
- * Another issue has come up, only with clang: using 'static' makes it throw
- * away the linker-list entry sometimes, e.g. with the EVT_FT_FIXUP entry in
- * vbe_simple.c - so for now, make it global.
- */
 #define EVENT_SPY_FULL(_type, _func) \
-	__used ll_entry_declare(struct evspy_info, _type ## _3_ ## _func, \
+	ll_entry_declare(struct evspy_info, _type ## _3_ ## _func, \
 		evspy_info) = _ESPY_REC(_type, _func)
 
 /* Simple spy with no function arguments */
 #define EVENT_SPY_SIMPLE(_type, _func) \
-	__used ll_entry_declare(struct evspy_info_simple, \
+	ll_entry_declare(struct evspy_info_simple, \
 		_type ## _3_ ## _func, \
 		evspy_info) = _ESPY_REC_SIMPLE(_type, _func)
 
-- 
2.54.0

