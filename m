Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F118BFF495E
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 14:02:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35C8D83DBF;
	Mon, 30 Mar 2026 16:02:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="T00ROJ1i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFB6783E7A; Mon, 30 Mar 2026 16:02:37 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE44F83D17
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 16:02:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UrWzpl1yYTaJsFRrlSxG6VCWTqUEhdMuUVu/WMdfcFKdMDDU3yAjv3yJlpLN9W9xEjK5AwY5hf17brqGms6nvKKNk+CvK19GY/KYmp8gCmWHZmBiQ3LyOQjM+McE96T6P0aoRwiONkkQf3hNsiUh8nEP1g3rbNSTT+tCzNJmQcny/aNWQlV6xcIxcy+17Bxyv+deaWqayn9XEmmVUUUb5xMcyR8pAiI+020SpygB1ToOjVmkqnkGrujvlnK1vWot83GEauUxhbCVdNoQ6IGVI+oymmZKcqjlapKC6R+u3U3GUVZxQIjQr+miZ/IL84yvJTSFXKytiJiOKKPVlF2RCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5hw4PQshPvUyGP7a7qkZ3h3QTg+JM2o0MitvR+j0SY=;
 b=QDWnXeJf/PaU+GkbOlwX910viYjhD9ahB0WnPa3mTzsAqZHkXHzQYEov47AClM+X0hcCkp1YQFqN476QRR6CvbtTUVbO/W9/dHzFfy03BXa2LxCf5vb6D0+9dBN3CY8vWjR7yJQnGcspPS1Nqp4z4IMwguGKjAS6sdbHnXO7ypF6VYV5zolSd3G7OJxfj2cp+eWSU9SDtX2otB0Lc5nimfDUwJZGMXXKMJO0T/ywLGblOzkdVCB4X7Wc3I1+jF1XFj8bLQzvbWqaUGry7J+0cr3Hg12F1s9gsAjMsS5zwq6lT1tyamHLWJtOrD8He2P2ArElQLTiUDdKp8vV97PqVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5hw4PQshPvUyGP7a7qkZ3h3QTg+JM2o0MitvR+j0SY=;
 b=T00ROJ1ichNsx5hcAH3tO0GpiKVWHgOCUnh8rbWM8FA4PbAMCofGvGSyPXCfXMKZtry8ZUh9gm2il2TO1YWKDs+koWdc0vduSo3RiUtZf2eMOYruLmfWMa707pb7W4RSwFsmNgngzMb+7V99rALJ3q8KNqVa4VewP/B29YvFAqs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU0PR10MB7508.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:427::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 14:02:23 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 14:02:22 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Franz Schnyder <franz.schnyder@toradex.com>
Subject: [PATCH] cmd: test: add bug-compatibility special case for 'test -n'
Date: Mon, 30 Mar 2026 16:01:06 +0200
Message-ID: <20260330140106.401876-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPCP307CA0007.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380::7)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU0PR10MB7508:EE_
X-MS-Office365-Filtering-Correlation-Id: a457416f-c996-4129-bcba-08de8e64f711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: pzGclArbkO8QEIl5gh3a2J9+GF/IJptSsIhXUKy+JkWFDdRUSKzlu56AJQKi8lBBnJDWmLxU0QWK8YBmJvKrO+/T/LpVw/ax892ryhBOBg9CAOxh2BSnG6vWA9JUld8PKTZ6iyk5Dl7t2m3WVpcFHCnvZC9AWMb/wOFyKF3dH4OJrleSbpEnL6iRUeKt3gGC6kVGGCYYBV8MJcjqnojhf9OX7HCRhuKSGRcU2msJQ6h7dty38x1endL0MZHC420RDituNNgQruXEA2lKCMNhtPP7ySjaZp9ZEKresegXJZoXFWMwqRkS++bn3G0lqEd8EVsmMcKin1jrAFgtPVzdkVAmhlmvcmWdGOOLxPq3giF7pfiyTvq4ZnlhztUco4TM6/J476UElxEeZyER+hNs0MylkeCDAE9CT1FXt7I21XufFQ38YVw6Y7k4YP/YHhx8ydhNBvipz09NKusrpPNs5GhvSj63JhOHlauiyzQeJlWY3LylqSu41KKDnWMVqL6vbyA7hve6z8Gcvef/m0WpFYbI90bumxNazLpc1NcftjvQ5PxwNHTj4lsn1ZVGPseyWOA49+r1BByeUFalPlFY3HOBMUXQXnnSjx54IXAemX0vGNvpbI7tX0nHsZn/Tqorm9/S3bdO3EJ16CA9+l01Xuz+NBzKoCOBkT2h7pzdo91OYY+Z90nfU6VdUerEhx5F+MI0uNiM7z1HYAKKv4/0PQY8UcyRWyBLHvUDURvaxOZFiYd9qElcZKU+fXhiGeGyhZF/BJrHMOCTwSRHLgu8qmulYGhYFgHpNB5iq1/wcX8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mv8+MdYq0649EUIJqp5Vh4tLsIPvCT5CrnhwhLQeXTuZsJXuczkWMpez1wR+?=
 =?us-ascii?Q?YuifVNCw/1P4oYEOtr9MFux+8ILFQu0cPVAHa9Pwl390v6JfqvU9RFY4yXdF?=
 =?us-ascii?Q?0WP5CryBYEfqDB1lalr4bSd0B0Oa0yacPnM3S9SvHa7UKXwdKs6E2fxqxmzG?=
 =?us-ascii?Q?tJGNb3Bn/XQTNRfv1rTwfcHS3V2K2EkLNFW/NSNgzO0cl1jf2DWwnHUaaABC?=
 =?us-ascii?Q?9qXYALcHwl1waI2RG3spqtoGESW1aewjP9pxFKnBf2yPjTV8lhkAjPe+Lnoz?=
 =?us-ascii?Q?EYwR53VqcBUhXC9hMmADtfv9aXd+40PWAM2VR6Q+hhYyVDQMmWh9on87AO05?=
 =?us-ascii?Q?0iNM4vWDB/dMybNz1cYJm6Ji4NsZ8GQkzqJxfOj2yQMBI1u7FkAt4eeAk2+y?=
 =?us-ascii?Q?jFdrEvXAxzvPAI1dPiasgIAYs9a+PtyVg5VfSTGoRplKMsGKEMtTIUYZDL6w?=
 =?us-ascii?Q?4vhKPUlBFEmAcf22fmYNSMe5shTkVTlp/vJ3wc/zm9gI8D7VeqFatGMqPj6A?=
 =?us-ascii?Q?f9B2dXNTRZHX09+ohOoDJ45dBOegKovkVGqk6AzT2KhXPqx18IgPj+iFoMjZ?=
 =?us-ascii?Q?0rqFXoRIhJr9mZu/yshDRGbqqFSawcaMntDm6OV2xZEhvBq8ZRxz2JEiih2P?=
 =?us-ascii?Q?9Q48TLELqCnN0mfGjsflRo8AtyCi01TyBKHADs1/qmFwyikfO0StCx9faBSz?=
 =?us-ascii?Q?QyPS3nHcfetwa1y/LKNvXFme4WFMumP0xaklWgWrgQR8S3hfRYvodw63lJR8?=
 =?us-ascii?Q?l/L63bfgkAF6+l/O0/fwq0Z5CXBBX+6f95QmufoV/uQmJywj8TDF3op2Ihqh?=
 =?us-ascii?Q?a4zgekqE8VxnjZycPI8Po6/+1zIdyJpUMVApi76kLAvUFwC+J952xhYvK9FT?=
 =?us-ascii?Q?kDmjd7itDES7RNAO5g403qLce1d9WcyxSgkU8svEXYRLVtamYTZFiya/nk+6?=
 =?us-ascii?Q?KJe12Ei1uJAIK9KOH407BwCVXZD8ZsSsh7oWUFC+iJV2kqOvTr/cb/okIgfP?=
 =?us-ascii?Q?TeTRGec4PmasuyfRntxZgkPQ7jdR/ey4YVPWt9GB91iJWgWuVOLHPbjxIGOq?=
 =?us-ascii?Q?RXa1Q7TI+6PzSt9a0FKdHtS23us4RBF9SYSA+HmfxMlhTt1Y5LmKeYS9WZTn?=
 =?us-ascii?Q?jzVmx+BTPVpcQiKx4mMDS8Ra8uskOyMH5eD8M8sk9YMoovWD+1G1OT5Ts6mR?=
 =?us-ascii?Q?x3i5fN83QPvRPVlIHK9cCZRabiuL5UT5l/hujZwYaE1gQ8lzhizTCld5G93t?=
 =?us-ascii?Q?tw7WNigYwIf9KUCvEoYu5w0qEPxTS/uJxaWMK4sjGxIDkRsmb+PPYIRA3NlG?=
 =?us-ascii?Q?x+RIMkC5Tjw/8tqlDbXXM4+C9xkmOE4NKH43H6V0Pz68W0taiJ6sbLBTdXhD?=
 =?us-ascii?Q?PAJaA+h7FIGsjcW6Nw/WbVw8cGbqP+JqH2yJEWIlVScOYsJ1M1qAz6zUryxQ?=
 =?us-ascii?Q?5iQnZG1V+kyPb9qoFJNzI93g3HMi/THRREJd90q8elAyMMdnVkGd8HivJPJs?=
 =?us-ascii?Q?9da1nvMa5wnXZbYv3AvnsuO0bCMj/Aavh/l/0PsQU2LEZHFNuK32nC6/ZDZ0?=
 =?us-ascii?Q?4lLBhuNcy9+Wttfh6HQBV56YQY8e++xbHXAhx+SE+4XP4H3Ot+RaCbBUF4bR?=
 =?us-ascii?Q?U8xQLsfnhwo1YLxLKweYJyTELRvnSnpw/jwMIzuodIGBjtTHScBC+xJ58iT7?=
 =?us-ascii?Q?S4crETklfq8jq9N9e3bpHT487kkB3btMLd1bC5Qi7wdiEIbqQFdc7RxIBWIi?=
 =?us-ascii?Q?yf2Z0oc1if5cz7P+5N8k90TbHh6FaLk=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: a457416f-c996-4129-bcba-08de8e64f711
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 14:02:22.8690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CdeYqhDUXc4eakm+FP8ElKm3Ezzg1IBtE4pus3IRFz22zPWBMGNussHO1r/E5TsXAlx1C8WZwkAkvDidW7Zd+O4wfHzhoZEYnii4tTRb0u0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7508
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

It turns out that there is lots of code in the wild, including in the
U-Boot tree itself, which used to rely on

  test -n $somevar

to yield false when $somevar is not defined or empty. See for example
all the occurrences of 'test -n $fdtfile'. That was really only a
quirk of the implementation that refused calls with argc < 3, and not
because it was interpreted as

  test -n "$somevar"

which is how this should be spelled.

While not exactly conforming to POSIX, we can accomodate such scripts
by special-casing a single argument "-n" to be interpreted as if it
comes from code as above with empty $somevar.

Since we only just added the ability to test a string for emptiness
using the single-argument form, it is very unlikely that there is code
doing

  test "$str"

which would now fail if $str happens to be exactly "-n"; such a test
should really always be spelled

  test -n "$str"

Fixes: 8b0619579b2 ("cmd: test: fix handling of single-argument form of test")
Reported-by: Franz Schnyder <franz.schnyder@toradex.com>
Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
I'm offline for the next 7+ days, so wanted to send this out now 
since v2026.04 is about to be released and next merged to master.

I'm not sure this is the best fix, an alternative is to just drop the
argc < 3 support and rely on the previous quirk.

 cmd/test.c     | 15 ++++++++++++++-
 test/hush/if.c |  8 ++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/cmd/test.c b/cmd/test.c
index 0d0f090386c..c76ebf800ee 100644
--- a/cmd/test.c
+++ b/cmd/test.c
@@ -75,12 +75,25 @@ static int do_test(struct cmd_tbl *cmdtp, int flag, int argc,
 	 * Per POSIX, 'test' with 0 arguments should return 1, while
 	 * 'test <arg>' should be equivalent to 'test -n <arg>',
 	 * i.e. true if and only if <arg> is not empty.
+	 *
+	 * However, due to previous versions of U-Boot unconditionally
+	 * returning false when 'test' was given less than two
+	 * arguments, there are existing scripts that do
+	 *
+	 *   test -n $somevar
+	 *
+	 * (i.e. without properly quoting $somevar) and expecting that
+	 * to return false when $somevar expands to nothing. It is
+	 * quite unlikely that anyone would use the single-argument
+	 * form to test a string for being empty and a possible
+	 * non-empty value for that string to be exactly "-n". So we
+	 * interpret 'test -n' as if it was 'test -n ""'.
 	 */
 	if (argc < 2)
 		return 1;
 
 	if (argc == 2)
-		return !strcmp(argv[1], "");
+		return !strcmp(argv[1], "") || !strcmp(argv[1], "-n");
 
 #ifdef DEBUG
 	{
diff --git a/test/hush/if.c b/test/hush/if.c
index 6129e2c530c..6117c37e53c 100644
--- a/test/hush/if.c
+++ b/test/hush/if.c
@@ -41,6 +41,10 @@ static int hush_test_if_base(struct unit_test_state *uts)
 	sprintf(if_formatted, if_format, "test 'abc'");
 	ut_assertok(run_command(if_formatted, 0));
 
+	/* Special case: 'test -n' interpreted as 'test -n ""'. */
+	sprintf(if_formatted, if_format, "test '-n'");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
 	return 0;
 }
 HUSH_TEST(hush_test_if_base, 0);
@@ -385,6 +389,10 @@ static int hush_test_lbracket_alias(struct unit_test_state *uts)
 	ut_asserteq(1, run_command(if_formatted, 0));
 	ut_assert_nextline(missing_rbracket_error);
 
+	/* Special case: '[ -n ]' interpreted as '[ -n "" ]'. */
+	sprintf(if_formatted, if_format, "[ -n ]");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
 	return 0;
 }
 HUSH_TEST(hush_test_lbracket_alias, UTF_CONSOLE);
-- 
2.53.0

