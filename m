Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0894BCE7A8A
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 13:26:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E24E6863DD;
	Sun, 24 Sep 2023 15:26:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2F35857AF; Sun, 24 Sep 2023 11:59:07 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02olkn20830.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe13::830])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20063864D7
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 11:59:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xo7ba9nX8QRsysdyWZgDLXPldWZ5Q5du+bZ1SVq++JyojGtwwV0A4wwD+bFU6cSmOkxMtMz40N970z284b2iboc7i0hkWfGAOBBxNxfj+RzyPEdBbRwWtlb3P+MQQvtDknGpGDJBcboqVfx9E5Ie04q8qUNl6jbAuSVghPTbs4Mp8JrqfvrYQNavRZmy/Gi90aKtpqHHXpZt4MyRT40mLPjPmZ0hcc3536lyQYuHmmOsdIbGIIAq1Jzl30D629tXbP8eF/c/3f5cXL1Mct5WGHmLmmtDh4Rxou3PodzjwHZ/budAP6u2sHbhibH9s2UOfOUK4+sGV+UY5agDGNBkNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LPW5tme/2ULj21lS8ZDJjzbrRcuy3AJKc1ZXifoF4c=;
 b=Hw0fb7PgtwVowdk868ZAb+W4wfME+1PWg6um3RbAephzd4RROZXpNKPvLz9DaL/Deq4FNuZZ692rL5/A1SsjHlF66B3oYq8nXimSu2YkCVJ7lBgVzpTsjsTb+wJdawaRXPzQLvLoBqBlYTAcwanNWa8Pi0oNFgq9Jg4VF8AxUdc8y66CNfVa25BaOd3Rv5VKbwUQ2lon988V+x03NYGpNvcYwJFRaZx6f5j8m6sGJZqahSy5ApQURJyr3ca/1s62zOyRtUZITAFYk+RcZrhP1iY1RZYvPtjpYQSyvqSPDroGa5Wsj6IfmxLS1U76mSo6NEijp5vWxOh0munpsjYtlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM0P191MB0689.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:159::13)
 by AM0P191MB0753.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:15c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.27; Sun, 24 Sep
 2023 09:59:05 +0000
Received: from AM0P191MB0689.EURP191.PROD.OUTLOOK.COM
 ([fe80::2014:b5d4:9539:9e21]) by AM0P191MB0689.EURP191.PROD.OUTLOOK.COM
 ([fe80::2014:b5d4:9539:9e21%3]) with mapi id 15.20.6813.027; Sun, 24 Sep 2023
 09:59:05 +0000
From: Francois Berder <fberder@outlook.fr>
To: u-boot@lists.denx.de
Cc: lukma@denx.de,
	seanga2@gmail.com,
	Francois Berder <fberder@outlook.fr>
Subject: [PATCH] clk: at91: Fix initializing arrays
Date: Sun, 24 Sep 2023 11:58:54 +0200
Message-ID: <AM0P191MB0689B51E17C13F50F658C4D5DAFDA@AM0P191MB0689.EURP191.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [6MD3VtADAswTEk0QlfSTmDft35RwdJyGpbv3rVNkOLE=]
X-ClientProxiedBy: DB8PR04CA0025.eurprd04.prod.outlook.com
 (2603:10a6:10:110::35) To AM0P191MB0689.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:159::13)
X-Microsoft-Original-Message-ID: <20230924095854.87047-1-fberder@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0P191MB0689:EE_|AM0P191MB0753:EE_
X-MS-Office365-Filtering-Correlation-Id: d71d421e-b338-4561-ed16-08dbbce4e2b4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gi/OqQ+o3K4gQOkICgfwyKrKavuyyFaKpXsoGIXN+z5eO3tuQZqM9xb3GKXOVnMTw0p2dfcZ7zQyorWjw1ZJxcN+ETIg9D5Fv1PKJDQ5mBiNJIpMiupxqHOuJeRjbq0wfx8p25Hg/2iz4vTMH3pcCKkFnI/Ud89o0qsUu/qDA+YFod2t1O+nh2bWmrgkW+5sE9wvS9xFGj+6B43QtclKKAwPjeYgQMHo7jHUwfCUHiFPxDUCCyvRJRXohfnY3YY4i4jHbL72iywb6dwuuTG+fx9jEcxY92u2+T3r1YxbMP+AIQJyBtu0TWeTtjRXMIcwAW392JkvNVYOsyfI/f0HQSHowwT54LdB4OaKhCRyJRsaMIPDopfM7z2nk0XDZ4MfsI8oi2CC0YkSPWRQFPPsHCE2JGrZhjRRuWO4Tds8bXcdHLsqhYiHsiamdkd/QVOmHZqA+P65suxrcxZCLq8ALOzvmhDOt3AZbXzuv9AiydABQ8MVlngGMVEdwXTjPT3O554YUUnwlqGDhaCV1P2jBmuqd8NDvq9g26dI3hu8BsUqI95uOzHGNxfc29C252Rsns4YQ78GF/FxROjHW7j+jarZnW6TUPuZPaI4jVxzNSy/lX2IgRXmo0ltDnCrbAbM
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IsFHiQ9xukBfhLIliNb0T9pq79omNIlOXDuTLNDTGLUzCSpMwuy3lE2wvnd8?=
 =?us-ascii?Q?eSd1CHty+qNIaNBMhDu1ZxumKw4BUj30sbBuLatpN3+9lhbvMKxyEbv0CyoF?=
 =?us-ascii?Q?PH7mEgb9nKSee4o48XMdglcW+AmIS6IAyTcp3jS83uvOXDBNVCBA6+j8hsn8?=
 =?us-ascii?Q?zOdJ4claY1goKHsK53PXR+ElZTaVPwmUM8fVuY23ijm1lYTINBUGC5+bULBr?=
 =?us-ascii?Q?Te4GtKaRJCm2glecrKoJarm1gURJQnmn5KsWbJF7Qq+GiCqW2pDokIIAqoW4?=
 =?us-ascii?Q?VIZdBT4NcFtfuoi8NdTpV+uI2+bd15L2ZXNVwBsqXM/IOC+fl8PMfu/eXihZ?=
 =?us-ascii?Q?TQ4LeUphjxarb5nc1MM+qJlOIGXCAhmW2M5WDZ4I+CtSNgrpJYbFIU2aOr+V?=
 =?us-ascii?Q?ajIbz2mHjM+II7azUYWurVVu/AQfPKIHOGLz5BzSKOEhZIBDOZU4H/Ws7pNS?=
 =?us-ascii?Q?9s38sBnbR3dEq0pHmCsVPrNXEHAz4bSAy6RPwZ7dlGQj79BhsM35L+BTcjCq?=
 =?us-ascii?Q?FU9zRdK4VgVN3S739lklxnHiF80N2Wo6k2U6jGlpDbQYgfSeeHzEP+f6dpI5?=
 =?us-ascii?Q?8pnfP4mnt8L3pDQQyYe3TRv4n0ztKRMDN0bxEKRTa9Tpt6wso4Xm5inI1bIg?=
 =?us-ascii?Q?zYgCOpegJi5far1iYBJbnHG14vfb4nNht4C/VjRwrG455gU59G49Ph9Xhwsr?=
 =?us-ascii?Q?bcHaMPYn/yfLpWWTSVniZDH4e4N6SYpFejJIEml4ZvUHD5jZ9e6hwF+T34ZA?=
 =?us-ascii?Q?lQxyMPOzass+xNetQCQ+gyqA5rM7MRbLKSsXJXQ6Rz6E6hBnUAaXKIAXXsF1?=
 =?us-ascii?Q?1Q3zWXVP3Gn/TLa7S7Jma+vYfdSz0LsVmSENI4fsKpMmlDTn5ssv95TbZDnj?=
 =?us-ascii?Q?Ja/Mk1TBOSEkQ/fbw+iSa0pUVKjXmQNH9HEGUt9jmJMcpyKyD+SXkxLFYwbY?=
 =?us-ascii?Q?GGmAchunzMNEnJkgXbQkpSr67bUMNcebXK8mVyHKxLn2f/+8/vMAdnITF04e?=
 =?us-ascii?Q?I2zIQRHF0oUzAFddRb1A6/zd6PiuEmJNwcHYea4BdVWfQMV/TT7aPedCViHu?=
 =?us-ascii?Q?gwMqFqMbG9DmmrfcF2Q0keKdFKAb3mE/zWlsEl35/zA+OKBgamAmjaW7q3PU?=
 =?us-ascii?Q?UdmS0+Dzst6/2sqNBXRFeQ+bSiEv0wjooJTzv+q/diDrx5p/G5eirA3NTLKm?=
 =?us-ascii?Q?twkbqs0wIJ2DkWKqesUET8NxGeaLmmMCL4llVw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-50200.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d71d421e-b338-4561-ed16-08dbbce4e2b4
X-MS-Exchange-CrossTenant-AuthSource: AM0P191MB0689.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2023 09:59:05.0345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P191MB0753
X-Mailman-Approved-At: Sun, 24 Sep 2023 15:26:35 +0200
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

Arrays are not cleared entirely because ARRAY_SIZE
returns the number of elements in an array, not the size
in bytes.
This commit fixes the calls to memset by providing the
array size in bytes instead of the number of elements
in the array.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 drivers/clk/at91/sam9x60.c | 4 ++--
 drivers/clk/at91/sama7g5.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index e2f72446d5..d858c860f6 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -429,8 +429,8 @@ static int sam9x60_clk_probe(struct udevice *dev)
 	if (!base)
 		return -EINVAL;
 
-	memset(muxallocs,    0, ARRAY_SIZE(muxallocs));
-	memset(clkmuxallocs, 0, ARRAY_SIZE(clkmuxallocs));
+	memset(muxallocs,    0, sizeof(muxallocs));
+	memset(clkmuxallocs, 0, sizeof(clkmuxallocs));
 
 	ret = clk_get_by_index(dev, 0, &clk);
 	if (ret)
diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index 3abd220803..3e62fb1f58 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -1115,8 +1115,8 @@ static int sama7g5_clk_probe(struct udevice *dev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	memset(muxallocs,    0, ARRAY_SIZE(muxallocs));
-	memset(clkmuxallocs, 0, ARRAY_SIZE(clkmuxallocs));
+	memset(muxallocs,    0, sizeof(muxallocs));
+	memset(clkmuxallocs, 0, sizeof(clkmuxallocs));
 
 	ret = clk_get_by_index(dev, 0, &clk);
 	if (ret)
-- 
2.34.1

