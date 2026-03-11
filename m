Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77604106286D
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 12:09:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 625F383FF5;
	Wed, 11 Mar 2026 13:09:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="bRo1pZA0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36B3A83FD3; Wed, 11 Mar 2026 13:09:25 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 384F283FD3
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 13:09:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rtiatkXHdY2Jl8Jn11ZjuXmjskMXJGXrBzuwktbQeH9xb0QvyIKEpFtkuh9YsOzJQJiEXbrGOTYoyXFPq8cRhxkNF8ZWJHd1F3w4ANx/LhXKtiNflFQJUPUbm8c0I4iHdL1fsThYH56C34Db8SjvBB8Y+5rCX36pOjoEu+ixX+qWuxC+4UA4IAQRwCl0OjtglIvGsrEs1Lxc45gGWh6ZG5D2V5jGNLjtKaIwf15KpqxZp392pSQGguMxDk7Au46U95XKce3Wysvd8lQSqMhFl1uYWQYJdfEBw6KYt7yXd4UQ6PBRfIA9qS7r1VsP32oxSuc0HHLiYTJxzlUsmWuXyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayMzbnGWzoIjuF3W3n+SlvUyCmj46IXqe7nt/18OApw=;
 b=VuhGAgvpyfStyo+GFI0cL8rpxYAVRYaBa/GRUE5AGmM2Ryf0IhEukXnb3ST8WPTofI/ydd+mi82wS5FIsxPKoZanSCuP8+qpLHZHmu8aFOoFYY2e9Pg+qR1Zkx/1R/5fNZiV5t6Rxwe5TxTcBqJALKSPMyF/tEbhiBWMDQS0B+Jdukr6cucdDB0rcECrCqrsQm6o39BvurAHJ+NgvlTp1egrdlN2wbwRDlNooXUeiQZGRbgma7NR0LG9FEUt7S0DbcDPeMp3h7IxG+vC9uwVejFEnUjlA4KZb7e/bse7txpUlChj5eE7Mi7NPd5eChJ1649BM41eGJ1uc1tjmRcLcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayMzbnGWzoIjuF3W3n+SlvUyCmj46IXqe7nt/18OApw=;
 b=bRo1pZA0qEc2ZUXkgQ7AWFEHVAjaWYbVIG3o2IJOcsK0zK4hybo6SzRM2jmggqeXTApEaa+o+2sfZRvivjbKbqmXt99WDOW96SRRqHDgDZLkk5cTA0gE7KevqXDeqlcPW4wgPx0UqlSBjqqSgeqHmBlsZO7++gdIWwO23sdNY/Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AMBPR10MB9706.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:769::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 12:09:22 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 12:09:21 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 2/3] test: add tests for left-bracket alias for 'test' command
Date: Wed, 11 Mar 2026 13:09:09 +0100
Message-ID: <20260311120910.3934114-3-ravi@prevas.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311120910.3934114-1-ravi@prevas.dk>
References: <20260311120910.3934114-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPBP307CA0010.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380:1::9)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AMBPR10MB9706:EE_
X-MS-Office365-Filtering-Correlation-Id: dbd88e01-c913-4e6c-06ab-08de7f67077a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JRW7bbiqFftst7P3b3nRUNzdwl/DsphK2JHOM/Uk/RcpmfiaDzRsQG6xcFHwOGiLq3ik3wg4eQ+QKGamHrWSJ2niy0WfjHfHCgvg9DJOI2LDJ+SrbavJRTdFmUsbM7fELqOtL0+AInrcgZ/ntE8YXzumuk8nHtg1H8uWiownzv2i0wDW0GCih0dmkXonvAqP0P2jj8CGOOTCvE4toWOacQZab6Jas+1ALItkHeOzVJjoLENeT5y8I9pq5BKk+V3JeRiYVEQfEhD1E9I7LkTwYY5lDHK76hw55z8cW4oOQA1kXs52pIPL1+W/V7ZRub+gPhpvUZX/mP3y0He9tgrVsMCjT7idSXXlPtIp2g02wg1o6dwPdZlFbW+17xsmYrEr109VuQ/9NSIQYRMGOB3o56Q4PrJsDFbxNMUHhArixadBMUW/RYyEnUYl2i3w+CHCKamnsTs2p4eCDNZ/Yd+YM37KLg2MBunhkWlqAJ9EbDjAMTvKms2QwUbp7uNkANqfo+hzNdIoRKwBSomYGne4PQ3rW0FQjw+uAvJK2tlJqnmyJCM1AIRIJDSSnkFnMWact2Kf8HQZuoaHHzqQfCytUpwBuvQwYxvms9HGFYlM73IGWDBp80F5PM3mTPCo18f849gfnhRBciUF9xD6pv1N1CbQWc/n0zw4QCOkD+8pkYOgJ6V19pIhSwuwohv+7DgeRGZhuImsnYokmmMSDVHZt2/uaKqhpI7ndYW3tXtCO52fWAnHa1o0a7peVmnLhwDU6m2Pc3wv/DiloHgVVQd9GIRuc0AbjKm9o8wh1OWb6Ag=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M76gFf8YAYZ2s6rkI7eMUctCcng/KJlgZS3SczYqmZjtBdvX5NlwWrHNQgEB?=
 =?us-ascii?Q?L1Z5f7chgQvP/WZ/lUypFb0/hFq7BcC+ysk9GhN+8U50LHL7mMmK5cr221sX?=
 =?us-ascii?Q?Y7gnRbGPqrfBOylTZKOi6VtPIQ1378/LG1Xzx6B4q2BVZ4pylpIV4r5yFme5?=
 =?us-ascii?Q?eSlvprgk3OiUns1bpEHD8HSSEHSODrQikEAEthNpvjvokUEfjF8YM1wAptdb?=
 =?us-ascii?Q?93LvRwgzckygX0q7NMjyqixzqtLREX6krgzFvw1ES7+QzP6KM9vpR6S6LIYJ?=
 =?us-ascii?Q?jjORYc6haJqNwl5PXC0COK5vwfg1i9wO2kVkn+bH5FrYkfNNaRr72ISQQlXK?=
 =?us-ascii?Q?JrQe7qYEPQDBRQD0WeQ6hXJAOLLzmVKn9IXWQ9bdJyObdbUab6EwMsiy4loj?=
 =?us-ascii?Q?OC+gUb04NyM5vXnjIuEEAcSKulP8yKrMeI/R9mGhqshEcCDmvGkclNT4eWwK?=
 =?us-ascii?Q?HE+Edc3+zKXgTEdnZaKWbwUjBHcRHZEUn0k5Ahfe4Csl71KoEW6bKzz8W9qj?=
 =?us-ascii?Q?ws7z6ekxHQj2UQsn+Q8dd0Qtz37xtcj8ogAb0gBNpwWXJTv8K8PXkdqDAozM?=
 =?us-ascii?Q?oAtYzn4OiWR+KvLwO9nbYP8E5xXMZO2+V8CEmcj+pDuLdhQ0R9FQ9QU7gG7W?=
 =?us-ascii?Q?JUfXQETMvAgZqUKoTYiOOeePR1DcL4sJ+CtZ5c/qr/dx3PANyj68uYAjGsZ1?=
 =?us-ascii?Q?E3Kz0/cDl69Wfn8DMXRXEa98s7wvQayIVhrkTD+0SMzwQouw0RBqjfE9eka0?=
 =?us-ascii?Q?RYj3UtTOwajtEij5//S2E50XBoy9TQ0WA57raQAQidph9eXOW8wZPAHRDiiJ?=
 =?us-ascii?Q?W246U9JNy1KZSICoJEs1wVXbPNkrfEK/LzCWLP9j60XLj2v281Zg78L/r8ez?=
 =?us-ascii?Q?Nz5sEg9xrFeOoshjo0ibqvfehhdhqKJNpr3YoXx167J03ER2SXZujgIz5u0X?=
 =?us-ascii?Q?BPbPZQuXl2uejFmeMJc7y6OxEsqvKRl30NRlkWTcBQH69E2Tmqj5vCT2kFBB?=
 =?us-ascii?Q?eWDx1u9wtRSCf8bi0AtiAy6K0+hXu8DJKPmPoVZA0tZI0pJvc/s2kgsFVc5u?=
 =?us-ascii?Q?6JPTfB+97sZb11EqOz8HLMDQLp0d7ouvsfNDpkY5rWpSRvMZBcCiOshXfpsP?=
 =?us-ascii?Q?HIS0L6cyz3OKT+r2BQ4yoxplxhvQ0aYmWIvvt8LiNqPe2NCJF+0hpCSms+tf?=
 =?us-ascii?Q?qChNwOh7sRRkPUYZMmGaSqrk9hxkOZE75TqEcsd3kwcSSxQonqiht2E3llNM?=
 =?us-ascii?Q?SgQ9nYV5N5SXKQdBbTi1jtEuw9eGi/ClT2awYOPUtP/N3dW/sCswSrhCaPGD?=
 =?us-ascii?Q?u3nqHlapatE5jxXbytdfjGqv6DFHl0sG9vQZ6olQC5BVQs1hIoJmNdaF4Snl?=
 =?us-ascii?Q?M5WbW5/OpbxkOGYw65ukvKeSWGDE8HpfEi7i8IV7TZkBT+MLrUkkengUUrm2?=
 =?us-ascii?Q?Rs3V4hvY74vzHBwCW5EDev34306kt9wiSwoY2muoS/FETy4gXY2sfeOsjI33?=
 =?us-ascii?Q?WTHPx1Hi6ri7YBC4cz3vOyFp2YmSHSR7oc/H/hWCDUozUyKIBcnKUCZHLWF3?=
 =?us-ascii?Q?Kxa18L3RdrhuQr8Ss9Ll7hFPKoesX2k/Y3Da4QHWHNd60vQ/wJH5jC35WL1W?=
 =?us-ascii?Q?d8VZq1BOj76FIXG2Cn7wMoM4EFNt7yxWhnYlJnGq6c8AFfebQUT6MOPM7pCn?=
 =?us-ascii?Q?24VDpxxQGIXypdaqbi6JS532wEjewfw/hkvDGLPH8BC1Q/AEKENSCVyDVjs3?=
 =?us-ascii?Q?S0uF6bS93CBZxeB5mwbBxkXab0i5eeE=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd88e01-c913-4e6c-06ab-08de7f67077a
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 12:09:21.8618 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qpB3fSSwOj6JiweFIV5zRIj+9ydA5e2ph/cAvTJRRqzwP7hoztYgw+gkpON6V/Er3+a/aaRQO3b5evf7nMV3PXhu6/k5sRNTHn98WdkfL5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB9706
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

Duplicate a few of the existing test cases, using the [ spelling, and
also ensure that the presence of a matching ] as a separate and last
argument is enforced.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 test/hush/if.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/test/hush/if.c b/test/hush/if.c
index ea615b246a9..148e9a53e90 100644
--- a/test/hush/if.c
+++ b/test/hush/if.c
@@ -315,3 +315,34 @@ static int hush_test_if_z_operator(struct unit_test_state *uts)
 	return 0;
 }
 HUSH_TEST(hush_test_if_z_operator, 0);
+
+static int hush_test_lbracket_alias(struct unit_test_state *uts)
+{
+	char if_formatted[128];
+	const char *missing_rbracket_error = "[: missing terminating ]";
+
+	sprintf(if_formatted, if_format, "[ aaa = aaa ]");
+	ut_assertok(run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "[ aaa = bbb ]");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "[ aaa = aaa");
+	ut_asserteq(1, run_command(if_formatted, 0));
+	ut_assert_nextline(missing_rbracket_error);
+
+	sprintf(if_formatted, if_format, "[ aaa = bbb");
+	ut_asserteq(1, run_command(if_formatted, 0));
+	ut_assert_nextline(missing_rbracket_error);
+
+	sprintf(if_formatted, if_format, "[ aaa = aaa]");
+	ut_asserteq(1, run_command(if_formatted, 0));
+	ut_assert_nextline(missing_rbracket_error);
+
+	sprintf(if_formatted, if_format, "[ aaa = bbb]");
+	ut_asserteq(1, run_command(if_formatted, 0));
+	ut_assert_nextline(missing_rbracket_error);
+
+	return 0;
+}
+HUSH_TEST(hush_test_lbracket_alias, UTF_CONSOLE);
-- 
2.53.0

