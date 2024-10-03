Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC60CF34C8
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 21:29:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A738188FC5;
	Thu,  3 Oct 2024 23:28:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="OA3Fmz6F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 231CE88B2D; Thu,  3 Oct 2024 23:28:24 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::616])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F247788D5A
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 23:28:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fx6XYOqcmNmsFRT81W+PMI1mxWRyTp8Vhr3sUN9XRtElIkO1vjsZKK9KSpDnsSxk4q2HYs94+tz9kj8JPrLUWD5aYqH6SK+3XPcysqxCxT1gHIjlWgGt4lJdkzR8Wr+1E0bKycZMIyOAQgkAFCAtf0zIz4XMHQ5kqKUug797xxPW2UhWPQUYOPUSKkYzRbbGi8Lr5i7AppcjBKArFw+L0+khJO+pkjrKQWcYLMgcEtQzuP6pAegBEQACbgeyUMhq+xqQLXja8b6XhpsFXYRnz3zupSquIB465Q79mq3BoWVZyIyO0Cg5JVMHKtOGlvqcaVsPrh4JUIyVUtXpXPqlVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dq5WD0RLdo6pvbkkl9Vg1B8RF1HPXJSErVUyoQGKGYY=;
 b=hliB6ViyjYhflEJspyDCWLHKh+f1+b3iKIFgOdVPlP+FhVMOZWMKS24f5nwTD4F3kQTXIXKGJ12DhcF27LJVEs0KUbAtuPXY1SBF6+XxhB/OmgL0c2d1YwzLvLVnO6SGcsvBUUEwrT0Q6Wm3a18vGDf1qLgJHOmKnc/IH0NNkweHK7av7uDgkjiz6ir9ghEIQ4ys4B9RKUnwEOPwHQfk2QUQqG1Yy2mMacvBHLAglx/0le+zo+PYN62ry4QyCOCsmYE1vzd3S31g13t3K1pReI2LaIAXxSEjsR18poMDZn5ytl8mO1BUJVwW1ClevtRGy6kcSXye+xL5q9sEEzNaCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dq5WD0RLdo6pvbkkl9Vg1B8RF1HPXJSErVUyoQGKGYY=;
 b=OA3Fmz6F9qiwa6woZZQhQyg9WMLhSgLrqo/9+sB67GuyQ5b7Phc5p+ZRI0g6p0VrFVgqwjHlWJnEooNsVNH+gQ4A9Ks0E4+cj2Je9ruJz/cbrvpHBpJtI6TLCiG5l6izgnkQFVbwQ3pfhOOT12QQVgkBaJ+lVdzrfwjcekNUAaE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DB9PR10MB8118.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.9; Thu, 3 Oct
 2024 21:28:20 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.8048.007; Thu, 3 Oct 2024
 21:28:20 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 08/13] watchdog.h: change include of cyclic.h to
 u-boot/schedule.h
Date: Thu,  3 Oct 2024 23:27:57 +0200
Message-ID: <20241003212802.3810-9-ravi@prevas.dk>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241003212802.3810-1-ravi@prevas.dk>
References: <20241003212802.3810-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0029.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::17) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DB9PR10MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: fa3d863f-4346-49ee-9670-08dce3f24dcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b1oW0A2xW2U25RRZlHM6coKGcG6xOxj4dpHNhp2updFkXgBcvEq8hhpEZFVe?=
 =?us-ascii?Q?qnd6ohAjTdCg96iEA2PuDb++taB1f7SxYtN082tLZMZaz+G8R3OCwpusG81H?=
 =?us-ascii?Q?RId1BVLT9l03KxoK1hPht6SbgHN9Kf/dPkKr4KoVws0k52Dq0AT6Z/C2kcjX?=
 =?us-ascii?Q?60wHs03t524ftzRUyAGL7I9tkan+6bDofaP6LSWY0ZEPeHD4sWxl+es653/D?=
 =?us-ascii?Q?iWZtHxQgZo6+TveiLn+aFR3dNy6HYp5IejQ4sCwtwsFtRBP3Rak9KlPO75IW?=
 =?us-ascii?Q?Xe8Q2hVNr8/LPj8dok54LmxYRYc1pwsuEtaTy/nS1649UoFqLK3lTA092YQ4?=
 =?us-ascii?Q?gEUtt83bIs13SxyvysELYCADqNUadfsT5zevvk1R56tk8ti6LsJvvtRwtSWZ?=
 =?us-ascii?Q?+siNzMwiu+SWmp83ov9AilxNZXeOKMbAQzkuwBpem4VCzABRvRrRxU9LZ4bp?=
 =?us-ascii?Q?M36uEqqcEQjp5fvwxRhQb2zytka4gCazspPpJTT+rlljA6aS/mG/cdOmDzbZ?=
 =?us-ascii?Q?p3omVQWhTzQ651SiByxxhoPCjvfDuASo/+5rGX142f3QQ/E5BikTNwAfSrnu?=
 =?us-ascii?Q?wclRnyteyHyMzMGXQ+fEVVqa75U01l5qpksDjHrfR0MHdEWDYoBQxI7XiseD?=
 =?us-ascii?Q?D5A3y4ZKi5bpeoNOMyziAaYtogZAvTMGizfVRWxbq3S3sUXleY8bmuhuuZGs?=
 =?us-ascii?Q?HcdicZRzZAaPHtrpYbSTUpyVWRtgx0sOw3QDZItavnRecWJuoja+Gq3Gi28+?=
 =?us-ascii?Q?6J5Hj9U2saoHwznR2/9hwRS0r+C95GYPnOP7ZkzUNoaDzWq5ld/jaC7NH+KZ?=
 =?us-ascii?Q?IxyEiWzOzBwJsRs72k0jeHTot79cWDAtFVk010o96Kn9hZZ8dhhK8RSnyhRN?=
 =?us-ascii?Q?VV8Dai82p1c4OCnzJyPaCxeBBhdfTesqtKEtpv3F9xFmWRO8Gzw6MbijEBpa?=
 =?us-ascii?Q?owK6mZ+y5Wt4lMmiiiT5TZeIfASJUX6XUKaiCCI6KfjnlF1L0qyFKI0K1rFn?=
 =?us-ascii?Q?pNuax8udk4S0ubPMP8qZjVzxhOnP6qIgpZFaUOVUyrwZhLyB1Yp84YZXdWjh?=
 =?us-ascii?Q?KhfL6yLhvOmB56YoZe2A7wYw1O3DbvD0ul+wGeEXVVWYBoB1PsGeuuvPKA7F?=
 =?us-ascii?Q?4wVvn8QaH/5z5jcXzgfLr7TpOFUFv8APb1Fjhe9Mhzpxrk7GgaKVSO5AgX7P?=
 =?us-ascii?Q?BG7D3+/gpmwQAPrsZ7ngBg0Tn8F3/zhdoCr2Yy2hdEaR43wsV8SKpDeiuYuB?=
 =?us-ascii?Q?ASsxYclh7asIOGmNZeacUIOn52xE6ddo6myDkqFbsnu+/ol+liIYNkFYkLlF?=
 =?us-ascii?Q?AwBpg4Rgujn395dl2S3JcoVinapoXVERVsI1iEXsm1Uiuw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tocDucfiEFKU/sWfmBCfphYJfrVU9ydtnZKetn96fPkHsDq+eKoZWJtrSPwq?=
 =?us-ascii?Q?mCjXj9FVZ96x6wAD1LZ0IUeOT4AMTBTqo7vhwWR8xBgkVykZhOlWn9e207ok?=
 =?us-ascii?Q?NVMjV7mVhEwhJtt3k0tMezZopGbHeIuhOCb/CdAuiMzmXZ1Ga09aOuJpFskZ?=
 =?us-ascii?Q?nPd7DrSfe8FDKS7NSHKqWPC01Bn9x99hyBho6L4o7RBShBjCmbB7V7wB/hiB?=
 =?us-ascii?Q?Gl4k/Ms74CjmQUThCziIP3qmArMOiyAedNTtupM44yNQq7r3l4MpqjwHMjie?=
 =?us-ascii?Q?trWGFt9BtIJh1kTVdKMXFYLOMNHLZh2FVFFRxDtw9QnkUzpFBmWGBheSdy5W?=
 =?us-ascii?Q?jK4bssNbhtyts+cGwrrPjwg18KJtJVBsLhjGWp9cHsjinxNRGOtNfmPLuB1B?=
 =?us-ascii?Q?fpeYGq/psRoiFIJVqiugZE24608kiOikh2GhsDk9h+ukizBPDYWcoG0aOGrE?=
 =?us-ascii?Q?lsIfhOmVsatav8P9R2kxaGDywmj/V4dcYzUsRp3i+EI2/uFj5HCkCKE74DEI?=
 =?us-ascii?Q?uoEGT6fGOUpACJVRyTsd6yoBebkAhbX5IAHuXevu/v/nZ34uY/hzRHk7eTsq?=
 =?us-ascii?Q?ciMQ0FT31FrNxSboXnwbjTSblf7xXv+zDSwO0oSMJhb2+iLPLwFA7QN2g8yI?=
 =?us-ascii?Q?DUPiSc1qQdkGv2XhvfrhfzAwL948zcLoCzetHhj09xGPqcHW/rm/nZujXFJN?=
 =?us-ascii?Q?BXbExUxcmEXSEIDH2wtj6kZwSVnTYy2pLJfC1sOpHkVdiw3p4EZo/TniIz67?=
 =?us-ascii?Q?CPaA8FmRLZAga9FGeA93by6QlQKi3vZEIqdssfy4qVS+YT6SdrRZUlNAO+wh?=
 =?us-ascii?Q?3g06drOaeseWhynXMnzk5K0rRnN6n61r38MS+ucdqzF9bCc7QxQl3yUxnRkU?=
 =?us-ascii?Q?7SpyDH8Vym9o1E6piIImYRcSUnPUnsxoGOUaqxiqcenco25+dgXBnU2cwZBo?=
 =?us-ascii?Q?gRRverOj0dy+0jrd/5JUAIWbMW+0BS+ognFwyPHvIZBs92r2u6YW8+eH7WvX?=
 =?us-ascii?Q?HgROsnk0WSAxq6qDFQFpgQ/8UpiYgT39PS6xualnrhPkETUYW11w+UrIGx6H?=
 =?us-ascii?Q?0aQRBooqHFNxxORQ22fiHVFtSXrG5w5JwVhuFmIKhmm2Cymk4lqEKlCZIdzG?=
 =?us-ascii?Q?fuP2BzAJXDxPaCzRp6Wmpv0yXzc3wPb76c8VzaoWc7u4qUOL/QC7JN6m4RTb?=
 =?us-ascii?Q?EwYYzl5zzK8XFCCCAX3e4IirUhX8vhl8F5hlto5hSQsuivBqU0J/YMQacfKJ?=
 =?us-ascii?Q?XbrBrlfRGCnWmfcfW5vVJg+BG8ZeGfjfXkeQDMQ8XeYlwXWvyRguxU4aZ4N7?=
 =?us-ascii?Q?p9NZdqzHFmHvsjMhoQWq36PCzxaPIyP+yo1PAmttJctj8mHmxAYeltZLMXt9?=
 =?us-ascii?Q?QNBZRYckdPDCssGxcpZQaqwphoRKoi7YnqxkXkfYt4LhUC5rwbRhTTM0H2Bp?=
 =?us-ascii?Q?yrLm2QrBSMy5w0rzMh9Suj+a9dC0UsrGHn8P5QFnlU5suwsSLHe+CpGXHLU4?=
 =?us-ascii?Q?oroGTH/yPUQWgNXdlmTCiwDwoxJTrZ5fAfnbiDpWGCQNSEGoAf4drrhyyHrJ?=
 =?us-ascii?Q?jFZZ0SiYf09BeYU3uSF/oVFUqFXtvUOD8owngC/nBYuKGENF88G+FuUrO4pu?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3d863f-4346-49ee-9670-08dce3f24dcf
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 21:28:20.7382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9dwPYXhrc1/GAocISbT5r0VI2MkK4iHRnHFO7yn6GwN/3+gEurGBcj4SpSfnVStz3Psc+r8kowVE10/8c6HW+lYcskIZ0TMpr2+1F7g+fHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8118
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

Nobody relies on getting the cyclic API declared by including the
watchdog.h header, but for historical reasons, many TUs include
watchdog.h to get a declaration of schedule(). Now that we have a
dedicated header for just that, include that header instead of
cyclic.h.

Eventually, all TUs that call schedule() should themselves include
u-boot/schedule.h, but this is a step towards getting rid of
unnecessary include statements in cyclic.h and global_data.h.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 include/watchdog.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/watchdog.h b/include/watchdog.h
index d1956fafca1..0149b44d077 100644
--- a/include/watchdog.h
+++ b/include/watchdog.h
@@ -10,7 +10,7 @@
 #ifndef _WATCHDOG_H_
 #define _WATCHDOG_H_
 
-#include <cyclic.h>
+#include <u-boot/schedule.h> // to be removed later
 
 /*
  * Reset the watchdog timer, always returns 0
-- 
2.46.2

