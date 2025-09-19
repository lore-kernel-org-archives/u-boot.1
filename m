Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CFACAC59A
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 10:10:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D8ED833ED;
	Fri, 19 Sep 2025 12:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="ccTRRper";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 722318331F; Fri, 19 Sep 2025 12:10:15 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7391A8323A
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 12:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxiZiEZ0m2Bavaj2SzKcvrZrjN2IWMnvXlwWIAtgiJg0Ufzu0Nl+Ng4edZkRvwFa7ImkEkXMQdREfU+XtrcaFFRpZVgp5CWjftK4y57l1qtT7MhO2NX/uTEZbjbkiVVy04bYNHI4L/m7L1KOb4D7MvGzDVT9DEPmpTmPU8yyX8azq0LCDCCghFpy9Jw4yoyb4zH2WjRsiatcWbpc0BCg8b8c2qGwsWdQZ1s3QH+1vYgsig7beR70S+B/XlAqim1PzmfPsm7KVeLhI28XRtlVWpg+RIdY8/pemGSN7nUyutv6+fIpuLR+9pUFyG7GSPKu8wRfcfpqdFr+Id+wRZJ9gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJJTBPi5BwD8W+gSKzSadsInuCEKEnEFpb1o3HYaD80=;
 b=iH6Mg/JAAEQb7ZjDzSEtf7Ok4wMA3UI2kWZWV+lR03GrmDwiA5zVrsSz/4oScoawM4hUF9AhKdZIqUOo1kdGJLZy3UBmQfdc5j77TK7bxNUGZvnMASB2QMhqREi6ZgLn5P6IBUiPRUgFLtHlaCwPzWglNYo2+k7nqZ8lqJx9YxOowb3OWm0J6XCEpOHGesu3AfPihjbJDsGf4q8f4vvzknB7VTtytx1Ws+207JdtvO2x+hXFIt8ZiBa3F0jqmnhh1T7lDg98grNOryJEriEEnICA1ecNWXgWQt71BLjjihPENiG2Dd/Y8oSIHq5qysElvpnn+Ml48SeSl7c79KbRCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJJTBPi5BwD8W+gSKzSadsInuCEKEnEFpb1o3HYaD80=;
 b=ccTRRperPA6VSnYarzk4JOw3yzJzFGEUMXVXXoQ/QUgW1mWAG/4VlZb7L7r0hVrfxOEkVHJdsJPX6z7xzkkONDgCrFDdsQQdQIZHWu95AX8hw7J+tj9BXM96lvjtOrOJB3EMz09YPuf1hl2L93D8+vLu2VgbYR5VQhdiP45/tH4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AM0PR10MB3329.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:185::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 10:10:12 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.9115.020; Fri, 19 Sep 2025
 10:10:12 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 4/9] _exports.h: drop the last dummy entries
Date: Fri, 19 Sep 2025 12:09:57 +0200
Message-ID: <20250919101002.568488-5-ravi@prevas.dk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919101002.568488-1-ravi@prevas.dk>
References: <20250919101002.568488-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0083.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::24) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AM0PR10MB3329:EE_
X-MS-Office365-Filtering-Correlation-Id: f694d253-7e84-48a8-ec6d-08ddf764b835
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TIMXcwoNPooPLaQ9ITHRyQP0eSNpNEmxEiTXTEONyHzAURrtaZv5vLU7BBf4?=
 =?us-ascii?Q?N6NJwQt9N9ugqW1yznL+TE9ALNW+/wSMcI+uEBQX4WY/R3gffnLNd4ae0gUK?=
 =?us-ascii?Q?VeM/ljqYX7FgLSvXWTQY+16seUhaYAxDOkKmXiU7fFmefRswCStLgNi5gwbW?=
 =?us-ascii?Q?+9sl0vhlHmoY8gEOAkj4w5NlP6yQp58h3S8lx85E0LOawtLH8/3JnQt9L83Y?=
 =?us-ascii?Q?5IdsFTkFl3Zgr6OCj4vb59RkQN28UbFyTXe1jBlD2bV2PDvQo6hI6f8KaoD5?=
 =?us-ascii?Q?e/4XypZH/sVNkbKcEmu9oGUO/1r4ZTLKo3woq3j3CumBuWMFs+M6ZnMGAzIM?=
 =?us-ascii?Q?6XEwi3xBcRDdy/OQqSP8S9SgXVTmIT17R9CDPIKuj/LyTVmuNV9Ebz0MeafU?=
 =?us-ascii?Q?ZAxfv3e8S9TGLzq6bQpVRJ1T4nREPORvt4ICaNV+kB5+MBaFbsOcH066kcis?=
 =?us-ascii?Q?LC+mtY5NjL+mGaxnHgyBA6+nduYjIbUdm5eHg2bKeuCJMf09qAf5x8tSlgnG?=
 =?us-ascii?Q?Fvjj/EZ4V5s26tMD9BsLCGE2H/LjmwlMGAIBYR9yHtdtuks5J8SOnqyPE89Q?=
 =?us-ascii?Q?D3lovFTsDdqxNBLk37uD+RABwCxAxwGuXoKkKkZShvbs9MHkSPQIXvVSehFQ?=
 =?us-ascii?Q?ldSvnR71nDq709C7/XPJ7gcWDpSdgrrXSD15IkQAcAaJb2W7QT6d2RTSQIoP?=
 =?us-ascii?Q?SomiyLEFiEWjvDZdLX+93jUOsV26SypSNM/5zIa+I12ldIluqhkq+2wHqA2v?=
 =?us-ascii?Q?w066m2memF/KjejrvCt4bK9y2kAK3YgIgb+ximUnqG+V/JFgeEPmz7JOZfeS?=
 =?us-ascii?Q?YuGscb6pL9JU0a1N18yhI+LLcekQc7TUSTOgwm0SFE/tZ40nfFC2MBxgszBc?=
 =?us-ascii?Q?qT/j/kvuhd5evyjiCyI7jQkc9cg/ygJvvwJLRD5YD6nnn0TGd/xQxUPkUjUo?=
 =?us-ascii?Q?UZsz7/TbW6LkXw/R1hmn9oxx24vjTUVuqrlUo/klaPt5tIjnC5CaEUBjCyVn?=
 =?us-ascii?Q?ekU3KOTGBapAyKeFCM+JuK2npIBh4F3dF8qKXXMPweuHF6OjEMs79HxIdLOl?=
 =?us-ascii?Q?7R3GTlzYqNlhwjJqZQ3N3ohqmdaEeJZzmi4PXPy7pCbOdOIPQiCqnNBB6/Cm?=
 =?us-ascii?Q?UC0EoNf5nCo2hQCNvWllF6Mo2DigvRBS0GRncJ9ntQ1HOueQW4l+nzGDkcgq?=
 =?us-ascii?Q?d10aUMkupbFDskZbvfNIFTNHNWL2VCtyI9QpQZQoNxhrSXmZdJ7xU4pW3fSV?=
 =?us-ascii?Q?Ayyms1lT6j5jl4aqxqRGzhVwGSH5ZpXYPhpgAEKxXP9ksi7ptMEZaItdmUs1?=
 =?us-ascii?Q?62y6E23YYkmh16x5/X1SPFlP/RnBsvruzTt81lmW2c0dj6LfwJuS6zCQB0FA?=
 =?us-ascii?Q?kYOSZ+hoDYh1x5IuJA/7SEAcqLU2PtWPhMRorZ5BLHmc0+ZmXJUDW8bMV/nN?=
 =?us-ascii?Q?Vr5rMvA5R5GZBiOugok92Hy1Y2d58gAViVacTtFFivBz8N+tgc2r7Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RmVYosrYw0ejPKV9Tb0GUuq8rewgRfRRrvJeZpRNRemUQg0X9Oh5SpDpmeVG?=
 =?us-ascii?Q?krA0DIOwg7p+qQAn8rSNrf7VpLz+9VrQ+UaxQP5ht9aSFBxQ8qbCToqEOwfJ?=
 =?us-ascii?Q?CrTG0qbkC33vZEVY7OEp2RuiXoBeUxDMfuzDu8iksHefnz8M07osWFUz+4XO?=
 =?us-ascii?Q?/3uWSZPA/tvOoKz9CRWaBo8aeA+GKSG3vZXqD7Yc8hlAodNSQKEhtuQQ4c6f?=
 =?us-ascii?Q?XJcaKNhx28ypY/2SWtXqsu8Ku4wvNfhYef+rwwTK1/Cgc4KrWFukrIJCxW4G?=
 =?us-ascii?Q?suDcoXThKeTLxZc7e4F8W4Yy7/1FtunRBM+5sdcoZuPNrqC832TWYraUAqWw?=
 =?us-ascii?Q?ptwflCP1C9OcESmwfmR2tiFe2EONGUs9Bwg+tWH9y9hQr8cmIKJHNlgwltk6?=
 =?us-ascii?Q?KBferyTqXhTKcLlI8KT8fBUwLpjziu5oyV97vuAUsatQ6Ykbab8uP1UuKBCK?=
 =?us-ascii?Q?advZMTit1CYHspFypSzH9AwbLCMcVRuWtuK5dRHCfwgictHqnD+c0OM+OA5P?=
 =?us-ascii?Q?AJx0Xy7pCHcAnK1FJ3by4fPgVDciead468mUe0p0ILf8eK6eNtsVnFIB9q9E?=
 =?us-ascii?Q?1Tq3mAcr8PiAuEAJyqLWNF81qb9GcHm/h0xOQGlL7tZbrYstc8GTs9j8v1nv?=
 =?us-ascii?Q?E4Iq/yEljTYyiJTFdZv0xn/G0nAX9e/e68g8K7TWQlcQNITHK/o2Vgn0AD+u?=
 =?us-ascii?Q?nxSmcu3TbF8JVJcEVQtVL6cW6xka9xP7scXxmVROl+KTKw6y0KnZqr2+U3j+?=
 =?us-ascii?Q?ATFtg+PU+PAc4uZiOO4gQGG/Q3GHcry2vZKik1shHDRz2nwE9z6nMOAR5rDp?=
 =?us-ascii?Q?2QgJxmTKK+t78corRasA56g2KEBEIo4Sat3mmZ0Bp3nvSFlXTF+J6xvXN+Od?=
 =?us-ascii?Q?dOKYsUxK1o5WSIWxfsQOJRAMlNjk8NDPaBm7hTH/d6ObglUbLg48k5ccp0SQ?=
 =?us-ascii?Q?hyp3TVtUm8oDPbexznUmzI9qXqvT+bYkHTMLuuOLx9mvPzr8SW8h+7FAVmqE?=
 =?us-ascii?Q?rkI61C6rNNcWC1xjBzXbhTAw5j+ws+iH+I5XELEvGICHorXbn0+cKTSeDRd7?=
 =?us-ascii?Q?pxnMzvpwqjG/GYl+E3hZtd5ADwsbCr3tqEdzNXN+DDdTeesoYlu4cwM6AyT0?=
 =?us-ascii?Q?vd5E2qbWTd3LxjSpegtVekY7kFiCmrtZ3UwPq1Ga0RM4eMc5O1fDFFlE0K36?=
 =?us-ascii?Q?QuAC3c++sDshQAxaeXVvNnGcGIva/0bVKLyhGldwyEJbzVsIkE9ZHhaRVoCp?=
 =?us-ascii?Q?0wc2tjZBXAG6kcs8+NfN7WmaXNuOXzAh/DMszPW6vHK1nPIgqE0kq++SW5BJ?=
 =?us-ascii?Q?gRRLGtvvWdIUUOzOe8Z9ZTwSZH4mn8eEp0cFAGbf4IZeTa0NJNeQEWLN8hFZ?=
 =?us-ascii?Q?GGFPCZFwZkmN8T3HWeTrJAJ4zcV6n7zkvKX6rReoq4M5WcZECuhyl4O819Yh?=
 =?us-ascii?Q?OskaA2G8R4zXMxWTckibGWSd9J13QiIPpESXJ8hvH8xDAq4k+HtxJgZioJv7?=
 =?us-ascii?Q?HWdkiZigB8khyjwd13ttoQO/4pMh0KRXD+zhQU7O0FpRyxnjBUi/LCs9kPR3?=
 =?us-ascii?Q?hfO+UMWV8HjOmNOkWXyaBvq8blUZtXQvFqPSVX/LedMtnmbMugQ5tcwq2xHq?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: f694d253-7e84-48a8-ec6d-08ddf764b835
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 10:10:11.9417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OAFYzmZVl+nSAJVPPBxWB/kS5lRYLpqbIa9HMEkYcI6fF41/QsA2pvjAsitcFGvhLqeYjP17mHYx6ZTRO9+04j669OB2Xv5qhL2gQVRNxqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3329
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

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 include/_exports.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/_exports.h b/include/_exports.h
index c1511903088..21afb8d37f8 100644
--- a/include/_exports.h
+++ b/include/_exports.h
@@ -20,9 +20,6 @@
 		    int, interrupt_handler_t, void*)
 
 	EXPORT_FUNC(irq_free_handler, void, free_hdlr, int)
-#else
-	EXPORT_FUNC(dummy, void, install_hdlr, void)
-	EXPORT_FUNC(dummy, void, free_hdlr, void)
 #endif
 	EXPORT_FUNC(malloc, void *, malloc, size_t)
 #if !CONFIG_IS_ENABLED(SYS_MALLOC_SIMPLE)
-- 
2.51.0

