Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8796083608
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 09:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=X4ADWHu2;
	dkim=pass (2048-bit key, unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=ot0yA9gk
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CFCFD4091B;
	Fri,  6 Nov 2026 09:35:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PMLDNFYTh8oA; Fri,  6 Nov 2026 09:35:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F084040910
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793957709;
	b=mIbu2GTslkSww6KnjtkpMj9JNry1RoQxUEO3EQH/oZS0h6XtI+0qFjO9j0hFjFNZwa6K
	 VI9syE9SMQ2E1tBB31wkAcKZ2+i2MvdTbkfccD1mcGooqDb0l6soYmNjRYgJ0Hrp49WXS
	 x75nV+k6gci63BUkaoFi4ywAxZD7crHtsVLbrAhxLvt6cUGMmR5YgxnRw1oQkiBEbTgtA
	 z/JD7I3gP8wwTA4Tb6TgWO8jCEOThkKDSFk2KEaldyWfJL0U6Cb5FJUhjpkm6JTKurMI8
	 FoLei9LCRZFCmoMKjSug2o0EGJQNUcTf6xVNAf/6kr+WbmWl+2R4s1n0VUhtZ3NCPyg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793957709;
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
	bh=91tj0VcTWF6h8rNojDqKNsisJmUzMPSzVt62dq/g6uw=;
	b=BAqAVmkLQ6MXcFL7AUPWUKmr/cPx/Av9HN0nyG+rXxE3FJrSfjsdYalrwIbA7WFOuyCr
	 xEgASnfbMSs78mbhfD4OUCmjUcpAjVSnazMSu6Rz55Iryy0PN6jf28VdcubwSYRc/SdWq
	 xFUxLE3X1DEWCe/qGxJcZpbiDskV7BEaV+pcATm0iZFvegvr2NTM7OjBr76p3J7iEyhOK
	 tp/zOns8UM4jxNHovIGw3SMLU/itRzhw79WYLXSlVFo6pNxHEvCmNVYf95TiJHoMbj4mg
	 O7UisY8z2W3O1keD2nwPPBIRZcoRdp5IuvHG6VfoPxmTulbgsUaxFHBHoIs+QZg5jCg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=nokia.com;
	dkim=pass header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=ot0yA9gk;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793957709;
	bh=91tj0VcTWF6h8rNojDqKNsisJmUzMPSzVt62dq/g6uw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X4ADWHu2gF1iB5wHVqREVlvBP3NU0D+3aQiV72hBfe4iA1yjblEk9flCCYeU3mIn3
	 MkZaNV+Nf8gzjRVHNND3wP5yeH7ou6jO5OzDpJUQ5OA6qVH+KXRcHeXdv39Jsxt+9B
	 1lgpMImDBtQhtVPVYO3KCqJcvI7J2ijOPJzDP+o4A4ii6F3Z17l8ig6sTeVxElYcLe
	 E54MHGpvAeNA2dZEWwJXxX5cddT0E7+Ep3KmB7uwMqcPRZqVbsDAegNXfuopdYjM1Q
	 mzYnMryV7x7G1ojHNQLt1/q8NJ7QyUxsPdIpluF1cN+S3WaSOr/bOJyoLLaSp8c8iz
	 otOOMZnQY3qEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F084040910;
	Fri,  6 Nov 2026 09:35:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9A3412AC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:35:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 80056408C3
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:35:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yTaxGP740CYF for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 09:35:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 31A67407C4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=juuso.rinta@nokia.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=ot0yA9gk
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 31A67407C4
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91tj0VcTWF6h8rNojDqKNsisJmUzMPSzVt62dq/g6uw=;
 b=ot0yA9gkrbQqDscEk95qHN6AN310jPoHbrJy7Y0SJdN4Hs+5Ps8GgqcCv+A+OmD6Z197S7LkkGL+PUoMgUwIqog5bI+OmL/cxWYSVQx7A+7nH7Yq5Mn8fP+IeoxByQDAbkyYKKGWVuc3OQo2G5mN7GUq43J4tkndU0t0SYm+MTB9Upvip4soglcSskSAjY6CCsD3Kux8Y3X5n1A2pYDnOA083P2OMyqhlr4rFoSUUaX+SsvycnmMnxt6TX166RGfbpRhsHBnluExKXgFfu/4IMFjoAZ1vxbCitJkWUIw7fM2ChjLOYkD6GbnVbjJxgiIqtFIZJqXByhmONtG61R2lg==
Received: from DU7P250CA0004.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::19)
 by DU2PR07MB8061.eurprd07.prod.outlook.com (2603:10a6:10:2b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 09:34:57 +0000
Received: from DB1PEPF000509E4.eurprd03.prod.outlook.com
 (2603:10a6:10:54f:cafe::3) by DU7P250CA0004.outlook.office365.com
 (2603:10a6:10:54f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 09:34:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 131.228.2.20) smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 DB1PEPF000509E4.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Fri, 6 Nov 2026 09:34:56 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 950C4200FD;
 Fri,  6 Nov 2026 11:34:55 +0200 (EET)
From: Juuso Rinta <juuso.rinta@nokia.com>
Date: Fri, 06 Nov 2026 11:34:15 +0200
Subject: [PATCH v2 5/9] watchdog: designware_wdt: add get_timeout operation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-rinta-watchdog-gettimeout-v2-5-07de25b6312a@nokia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793957695; l=2250;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=UpmAWSYS2vaWtLFhwjA4oxCI1AeQF11m5kZiQWtu1R0=;
 b=p2LC+Rb9pePSUci1wL8XC1cHxkLoWvzoJbAKRsKq8S4Yh/MhigPXRv1SdZOxe16RAlEdSjB41
 rFLh6/KMwJ8CCJzmjnh0m6WkzBwO9UtRwXvgzCII9RzeNuMpq/wpOty
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E4:EE_|DU2PR07MB8061:EE_
X-MS-Office365-Filtering-Correlation-Id: ba30d283-198f-4bbe-a629-08df3be93863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|11063799006|56012099006|261021121427099003|261021123027099003|261009223027099003|261102123227099003|261026121527099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5p8rR4m+cBj2Yig1Solo44IPWsHF5yn1wgRaKQjbtQQzAtupbIvnbpSc5izmTQhlLtlAaV5cYvVNn1oR5lL9z33Wpz8mJlWs8Y/MTDY8sOUzZsy4wmT7TR/A5/rq7A+uIepw2MqYDEoXqkjek8kJAH+2gXVDSAGMMKe5WzSHovv/yVvn9LevKHVr7myyiAFBHgh6ixvACNkf99JWq5lXpYArFLeNR6qnJptS/jVLjknuOm19qs747zL6/8ALXrzSZ6iEsnnf2fKPcH1/2/RBMrU6m6ahSP7KZTTwXNjmMQMXrTtTx4FW47Jpmuvb+jpUj87UZeJ8lmUVnVHDSoP9rFrbvBM6PKK80CbGsGIw0lDtfB4cOYnuLuiahd4XOs/7IVmPzWulxgg3QvJysMr5/1YXK00UZUxkpNWeosgPtJwdyYt8V/vrgfZljeZwtHHSXHJfF4gc7IQ4hvTC56yGJSarRdt78ezBVR2fNBnJxjg+kEsWfWFd1R3EPanQluBZzq5z2Y1RJ1Pse5TarbElqExzvpplPpv6nuh2rXefW9vIdvMIVEv+6nTd64G9F4s+M1HxX/xZK8d1yl9XBAmCkDXe8P8jWUafXeJlk4Sc2Ba5FS7f+8BTYRLP4THdamHeQvisJ8NTlfr68e1Z0xjyd7eKmkr70xftpv6k8Cr/iuU3riYiQDBKQnAIJbiCQGkIL3dmtW5mF4SZNIt2035vlw==
X-Forefront-Antispam-Report: CIP:131.228.2.20; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fihe3nok0734.emea.nsn-net.net; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(261026121527099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yY1+Fxtj2ZjWg7vm+H3ROfdNr/5EpGN9a/pmuFxdUXYzvXPbPN/1PIbSmitslFWjzcRAtgps3qrJLnESUG/bJiP2NSwgDjSEh4P1imSRohf4fKVAPvFoUmziMUz1M48BtSjr/CWFrdeElUCF7q91l+xHPfahKLgF+pOgwFBl8u4ak+sE0T1xfcAq9wT3wjlXvsladnDvcj7IlH+LHYHjUoAE3HxOjVLH4mBQFlJzbHCjVZ3tI2NlAHjpt77KkpALeDdGoJxOTmxvt4Luja3blcwUYc9PPArh40cRuRS4Ns7LXgPh99uvGe1oGGtPzRNGVYpt8uroOBrHkSrvKmmpcESBW2B1fMhYWtceaN/T/eDOIhm+jOW1nQlwRE8oFruJXXe77bp/Yuzo3ATeL3g5q1ZQ55wyDCd8KGmDyb38CFnQ20hRe6vxD9/X0iDXnMzJ
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 09:34:56.8235 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba30d283-198f-4bbe-a629-08df3be93863
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.2.20];
 Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509E4.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB8061
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

Implement the get_timeout operation for the designware watchdog driver.

Add defines for the timeout shift (16) and for the mask (15) used by both
the getter and the setter.

Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
---
 drivers/watchdog/designware_wdt.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/designware_wdt.c b/drivers/watchdog/designware_wdt.c
index 91228de5e8e..0d7f69002ac 100644
--- a/drivers/watchdog/designware_wdt.c
+++ b/drivers/watchdog/designware_wdt.c
@@ -4,6 +4,7 @@
  */
 
 #include <clk.h>
+#include <div64.h>
 #include <dm.h>
 #include <reset.h>
 #include <wdt.h>
@@ -18,6 +19,9 @@
 #define DW_WDT_CR_RMOD_OFFSET	0x01
 #define DW_WDT_CRR_RESTART_VAL	0x76
 
+#define DW_WDT_TIMEOUT_SHIFT	16
+#define DW_WDT_TORR_TOP_MASK	GENMASK(3, 0)
+
 struct designware_wdt_priv {
 	void __iomem	*base;
 	unsigned int	clk_khz;
@@ -34,8 +38,8 @@ static int designware_wdt_settimeout(void __iomem *base, unsigned int clk_khz,
 	signed int i;
 
 	/* calculate the timeout range value */
-	i = fls(timeout * clk_khz - 1) - 16;
-	i = clamp(i, 0, 15);
+	i = fls(timeout * clk_khz - 1) - DW_WDT_TIMEOUT_SHIFT;
+	i = clamp_t(int, i, 0, DW_WDT_TORR_TOP_MASK);
 
 	writel(i | (i << 4), base + DW_WDT_TORR);
 
@@ -90,6 +94,20 @@ static int designware_wdt_stop(struct udevice *dev)
 	return 0;
 }
 
+static int designware_wdt_get_timeout(struct udevice *dev, u64 *timeout_msp)
+{
+	struct designware_wdt_priv *priv = dev_get_priv(dev);
+	u32 top;
+
+	if (!designware_wdt_is_enabled(priv->base))
+		return -ENODATA;
+
+	top = readl(priv->base + DW_WDT_TORR) & DM_WDT_TORR_TOP_MASK;
+	*timeout_msp = lldiv(1ULL << (DW_WDT_TIMEOUT_SHIFT + top), priv->clk_khz);
+
+	return 0;
+}
+
 static int designware_wdt_start(struct udevice *dev, u64 timeout, ulong flags)
 {
 	struct designware_wdt_priv *priv = dev_get_priv(dev);
@@ -151,6 +169,7 @@ static const struct wdt_ops designware_wdt_ops = {
 	.start = designware_wdt_start,
 	.reset = designware_wdt_reset,
 	.stop = designware_wdt_stop,
+	.get_timeout = designware_wdt_get_timeout,
 };
 
 static const struct udevice_id designware_wdt_ids[] = {

-- 
2.39.2

