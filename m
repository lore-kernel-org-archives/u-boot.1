Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5926083611
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 09:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=H0Ay+vgK;
	dkim=pass (2048-bit key, unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=iSMSE6a8
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3FBE740910;
	Fri,  6 Nov 2026 09:35:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bYzAkL3PHiQR; Fri,  6 Nov 2026 09:35:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5876840926
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793957711;
	b=oa5PtEoNUyYcvXhHej65gE1OFl4Tm10Fbyuw/rfRY85e5K6SKIaGsvbJ8WHGDwdCARmg
	 cjkSm9GbROenD18uAuW5bdL1293lVBiHA498AuHV/N85h6OT1o3KltH6Z1FdlwVTd+QWa
	 wg1vkQH3ZcRFbj/vuDbXMejODxZRqQPfuP+6X6UGVvbj9Sk+Qn1SDoqp9vWR5Pn1xpgw8
	 stJtUSEyKFd1LF0lnQ0jZfj/DKFU7W1helUMrJSTVj96oldtg5Dtjl1UR6s7wmQ2+CNt3
	 lV5UV6cUwB+IsmJRtBO0VUKmBHG6qNeduTQzVZ28F5Zr4XIZL64whI4d6VBcAULAQdw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793957711;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=I4s9qH8HItudqfK4afMDgntOcx9cAgs/pyv7yE8Encc=;
	b=LdQjAD0mz4HxfWdK4PFDXDQyVhQm2OHw0F6TnZ6SJNIQyznZQjTK7Jk03WoCSgCpEJ0j
	 SNN+ywNWYEx0DXXrieAQM52SOWvdjoJp8BAxhOn4is6ls4xehHNPgXU5XgNh5KuBM9Edx
	 CC46g3FpKGx4XWoKFUSyXppwXS3LIb38ib3hAT0OjsrZe4uedZpMvqNsPjF1NORjk4Pz1
	 uJ6cNthKJVA/xKRc1S3u/66NaRTQr+hcVF7Qt0FVuc72G3URVV/2/3VJ7A+lr8r16u9HN
	 TyQ2zf6OFF4sGR8ykoAd+ET6UYuoI820MPUUFnmsp5k7FBvo1+jlGe7haDiHJPlUyfg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793957711;
	bh=I4s9qH8HItudqfK4afMDgntOcx9cAgs/pyv7yE8Encc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H0Ay+vgKOazlsVLBS4QFplDziUq4vx88mUz3dCaocCcV2kgYiDvtkUq7L4w21RwBK
	 MpRz9RmGXEKLyJcrgxOcuwl6AhNMjUao+Brw9leQbRN5YF0PorFqEEi9KHP8TN1tRr
	 GjJ3WgYDXug3P7zZrvXxuMvGIs50VuH/3Rv8Ua30dMINnj9j9mFHxlSl+21QsX9lkm
	 A1Kin9Eyrvt6djh8VHEJtLzVypwP5LE8AytaL6GYj2WRpW/Z7F/5Qetf9yzZDzu4oR
	 6fIlJgsNkOTEQsL9Z7/azLaY0PVn3d7QczLU9Af+kvzmhFxZ2COdJKoCzqUMxo2lkf
	 utTBThfgZTLKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5876840926;
	Fri,  6 Nov 2026 09:35:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A4F5637D
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:35:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 95A058116F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:35:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KuY20HDiEc6a for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 09:35:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5224F81188
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=juuso.rinta@nokia.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=iSMSE6a8
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5224F81188
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4s9qH8HItudqfK4afMDgntOcx9cAgs/pyv7yE8Encc=;
 b=iSMSE6a8rLhMFgcusN7VNr8mpO6W3NSMVIPHGlNC0TqMcecD3gclh4oSU5/74PPtphj/GbzvZ0P35C0iRhiIYVT4+lLZavXq+lG20DwgJK6cZ5aVsNYEwl03BI1npJMM/fwIQ2DkuXpuCTVkLaW48SQWti7fdlLYIH3LnL62IFE6M3N+91DrqnrXYgQku8ZZ8S1f1mNBUist9Ko5tJPD+H3mmrMciLychK0MXcGkstME4iRzom3RNzJ/dpQmyGAXn4iHLPrFR2JihYMX43apWp1WE1PNiS72oNQStZEpapwyC0OllPHYTKCEO/EOC/HX4d9xvUJQ/eVN8synFvxlPg==
Received: from AM9P192CA0030.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::35)
 by MI7PR07MB215118.eurprd07.prod.outlook.com (2603:10a6:290:112::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 09:34:57 +0000
Received: from ZR1PEPF0000E461.eurprd04.prod.outlook.com
 (2603:10a6:20b:21d:cafe::73) by AM9P192CA0030.outlook.office365.com
 (2603:10a6:20b:21d::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 09:34:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 131.228.2.20) smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 ZR1PEPF0000E461.mail.protection.outlook.com (10.167.241.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Fri, 6 Nov 2026 09:34:56 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 9CC9220108;
 Fri,  6 Nov 2026 11:34:55 +0200 (EET)
From: Juuso Rinta <juuso.rinta@nokia.com>
Date: Fri, 06 Nov 2026 11:34:16 +0200
Subject: [PATCH v2 6/9] watchdog: max6370_wdt: use a lookup table for
 timeout selection
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-rinta-watchdog-gettimeout-v2-6-07de25b6312a@nokia.com>
References: <20261106-rinta-watchdog-gettimeout-v2-0-07de25b6312a@nokia.com>
In-Reply-To: <20261106-rinta-watchdog-gettimeout-v2-0-07de25b6312a@nokia.com>
To: u-boot@lists.u-boot-project.org
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Yuri Zaporozhets <yuriz@vodafonemail.de>, 
 Jonathan GUILLOT <jonathan@joggee.fr>, Jonas Karlman <jonas@kwiboo.se>, 
 Simon Glass <sjg@chromium.org>, Juuso Rinta <juuso.rinta@nokia.com>, 
 "Maxin B. John" <maxin.john@gmail.com>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793957695; l=1723;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=c01Gsjm2fDmEHgZMdQIL9x8u+8GFV9r9/WepZ/PohhQ=;
 b=3JyFiQIgdoqAS4G2d8eZSxCq5JLrXkSs8Kp5Lq6m0hIjPJhiigHksLKkV66kaeuNcebCMNIuS
 knn1mWCM3dHAqrvjDAftDTckdGKYA2SHlxZhExDysjAbdabL0aTegvi
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E461:EE_|MI7PR07MB215118:EE_
X-MS-Office365-Filtering-Correlation-Id: 73d60d07-4255-4bad-1986-08df3be9386f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|18002099003|22082099003|10067099003|11063799006|261102123227099003|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261021121427099003|261022105027099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: mREbBnkDc0mGbxfNyxayimZBXrIHSkwwPaL+jIwkvsfXQYJjmIodI91fdowYvXbVbNcSFBkeZ30j9ApfwN0fmS8qRONYTOlC4TOWd8lti043ENxUpzCrWt/d/j0KULL18bh7WMzQbKUKm/SgnkLeOv3qVOqWjptlZqTEYbd97hzq6V9JPiGng5xXO75vCAdk+T8TSw49JL4FbV7ymSWuHgEfNUbtgf8jr25pHWiGS6S6mlfktCxi/T3gFbrSkw2wthfJNattmAQkaM9P1jFsP+D95e/oIV05yOyId2kPa4Rqixx2OL9ol50OotG4DRQuni8HV1jXwN74l8bbF5oF1yuZ4U2YP+iIQcAP0bc/7XvawuJoDeq4JRzLuSMArO0/DbRWZmIiUtu1vzj10902pJOOMZkrBgN9K0yO6gKa0knkr3+VRiTO0Es1Ah4N7KBm9z3IU8BK7kF81TZk9ijm2EDOTZl5PMCQmIOmo4fF0NjqKDGkqcNwdbGRo3VP4DZu+jmwpc8ym2r6TX6dmHCdVQpWcUsxYD8T11KpcELxepcS2hCH8Klxdkf2Lc6XIr6Js+kkf59qFTxf8JD1516SisukKbTIqIIrvUHqrr0crIt0PFbLiv2QTRYI1lSnZs1hNYouzcrIhZxq+FbXnNzfX6NAqwFVU7g47m6sVGneLFCV/dWeh/4GmjLXYHIVbH6W28zeNR+RksOm6XimTwI5Yw==
X-Forefront-Antispam-Report: CIP:131.228.2.20; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fihe3nok0734.emea.nsn-net.net; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(10067099003)(11063799006)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022105027099003)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XZtVztz6CBsB0ly+BkFFAc2BUhSoJg3tAYVWXqSBJigUiybH4lGh/EjC02DjVkGe9cOpM7n7KRwpVoc+QbjX7TyGcMfbRnmI/8pQrhNzNF+BzkN9aShM4qyn54at3zHcP9NqxB9gitcjWtWok5UfMQ/SWDU+fWDQZy2qqEwmnORVD1fMt8RKs8LPMNje+zCrw2bIpHk23K45uXKEIUWUZXmM/VWzFCnYO+jeEK3tGuZm2Dpdff2m9yjRH0KT0KJ3z3smT2hcz1xjdCB6912o3SerIJbA7mpQOfTGozGkPeIdqatbFjwH9VpU/2Iy0xDdbFzXmt12uv5x8stkt4hUIHFcCQvA4p/c/aOm5FE1OPkoSljVwfVgiR3Cg6XnyMAZS9eL1m3gK5ZttymVjrttnXv3ngjjS8RDKSdPnnullbP6qHQTy0ljsJ/GEaD2uRBs
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 09:34:56.9091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d60d07-4255-4bad-1986-08df3be9386f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.2.20];
 Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-ZR1PEPF0000E461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI7PR07MB215118
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a lookup table for the possible timeout values. Replace the
if-else chain with this table in max6370_wdt_start().

Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
---
 drivers/watchdog/max6370_wdt.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/watchdog/max6370_wdt.c b/drivers/watchdog/max6370_wdt.c
index 584a4ed468c..fadf4d41e1d 100644
--- a/drivers/watchdog/max6370_wdt.c
+++ b/drivers/watchdog/max6370_wdt.c
@@ -19,6 +19,16 @@
 
 #define MAX6370_WDI		0x8
 
+static const u16 max6370_timeouts_ms[] = {
+	[MAX6370_SET_1MS]	= 1,
+	[MAX6370_SET_10MS]	= 10,
+	[MAX6370_SET_30MS]	= 30,
+	[MAX6370_SET_100MS]	= 100,
+	[MAX6370_SET_1S]	= 1000,
+	[MAX6370_SET_10S]	= 10000,
+	[MAX6370_SET_60S]	= 60000,
+};
+
 struct max6370_wdt {
 	void __iomem *reg;
 	struct gpio_desc gpio_wdi;
@@ -28,24 +38,21 @@ static int max6370_wdt_start(struct udevice *dev, u64 ms, ulong flags)
 {
 	struct max6370_wdt *wdt = dev_get_priv(dev);
 	u8 val;
+	int sel = MAX6370_SET_60S;
 
 	val = readb(wdt->reg);
 	val &= ~MAX6370_SET_MASK;
 
-	if (ms <= 1)
-		val |= MAX6370_SET_1MS;
-	else if (ms <= 10)
-		val |= MAX6370_SET_10MS;
-	else if (ms <= 30)
-		val |= MAX6370_SET_30MS;
-	else if (ms <= 100)
-		val |= MAX6370_SET_100MS;
-	else if (ms <= 1000)
-		val |= MAX6370_SET_1S;
-	else if (ms <= 10000)
-		val |= MAX6370_SET_10S;
-	else
-		val |= MAX6370_SET_60S;
+	for (size_t i = 0; i < ARRAY_SIZE(max6370_timeouts_ms); i++) {
+		if (i == MAX6370_SET_DISABLE)
+			continue;
+		if (ms <= max6370_timeouts_ms[i]) {
+			sel = i;
+			break;
+		}
+	}
+
+	val |= sel;
 
 	writeb(val, wdt->reg);
 

-- 
2.39.2

