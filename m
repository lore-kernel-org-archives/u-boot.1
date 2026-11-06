Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E053B6083613
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 09:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zgH7YeJn;
	dkim=pass (2048-bit key, unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=VP97HKfO
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF6DA811D2;
	Fri,  6 Nov 2026 09:35:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kX4nZ32PR36J; Fri,  6 Nov 2026 09:35:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E7918811AD
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793957719;
	b=dDbOdEIASmXFmtU97rNj34sYiLyXpCZupzoMVMxEfWcOVT+fjvzXfaPXj1aN7ma0buUj
	 5UEszFBkK63pBuHg83+gpbCnyJ5WkFZ3R3U7DZsVd1NxEC+Lt6JTBaMYq1Xyelg4+e4wX
	 U/7cobe4TG/l/nMw+v0wu9qDMfrVLlidfauv6dpV/tex4C6ZrtlE2k167aQ2m713H/nbL
	 vFTL4EraciTGLxBG8pAtS97ENMp9LTB1tfKPMzIOn7Czp6HJYJ2q5pVir391kNhx7Mqj2
	 hIx052s0grfJl01U9KKUW/LQI75tbMYEC4/dZ8PnqgtAHWo0UmqRc1jcJ+y6Lwa0D6Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793957719;
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
	bh=Q8sJn63w5Ljfw5QUV/VAIhXUw8wbx8Kenbf/QTE0svk=;
	b=i1fj3kd4g2m1UbCLyI3rHaxQ3PlWgmlOFA3w++XPv7yKfPS9q4hdXl2RbWAyvOA5WptK
	 XFJxOsstSXOXrLtFdAmBEnwqQ1YR12Ex1fKdR1RxgBt/OXkqnGmUiv0Aogev8GYxu2ZDs
	 CWjAFr8izK63zJEKbYapnvZgpuMJCXItEDg++iCt3jdVpRNhPJ5pydsOUQClOnlgSSnqd
	 x6gIwSHV458u+qri7bkdhtgccdD0JMU6ibXAKROtEQ0eDGuMpu9mxptG8YpNwWhLMMAhi
	 UXUo3MUkAJQnzRsN01eaOhD4A3J0dQOIDE0U8zSQAZ3dS9rYvfEeu2vEP3KjAXRWBWw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=nokia.com;
	dkim=pass header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=VP97HKfO;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793957719;
	bh=Q8sJn63w5Ljfw5QUV/VAIhXUw8wbx8Kenbf/QTE0svk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zgH7YeJnYBcEaEV9n8WwzwsKo8Wcl0ajK40bNTCU87d29LnAFVX8xu34LcYGdXXeb
	 Ol5F78QfRQYtXkenkPltiHAQE+h1bG3bZ6eMehw7ry2XlhdhVH8hfm1AaKI596iD7d
	 Sd0kLePM/0HsfyUvxXOF7evW3BYwc6dP7SiVH+PrVj1Fr029wxM19M3N4ndHmFxSF8
	 XDSrkk4gfWR9IUKINFHXUGyWT17jm8Ka++uiotf1STozkNHmMjvdDMY3GXGno/dGSw
	 loEabCiddwPBlTmM7U/SpjPEEPyD4xmd6kljioeNkuahRC1kHUuvvgISoMWMmN9fQj
	 gQbEH5bRPJVjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E7918811AD;
	Fri,  6 Nov 2026 09:35:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5FCE92AC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:35:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5D7A281194
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:35:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Eyz9xsWiOaO for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 09:35:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5E6108116F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=juuso.rinta@nokia.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=VP97HKfO
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5E6108116F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8sJn63w5Ljfw5QUV/VAIhXUw8wbx8Kenbf/QTE0svk=;
 b=VP97HKfOCyhOACrO4taigWFkZjCyVAz6MN2wACuC87oH/4GkiOkSB8QsWeDyzJGigPPH+EskV96iGFQDshuvThxvYFZtgy3afuMHrAqwv6FUYqcACxG5GiAZ+ZmTSqiF/mxnE59dOg26UDoBiHrZFItUsXRbdj9/jZjQrkvxIVi59fLtOT3sOSq/z7bO7uaLxGtiGdLBGsAttJ2cm4E8x5yQjNl8wivCDWdGVJHXaSzSRdrNf0qHmXWNk8c/sEnFImCXAtEz5Noc21HZ1LeAFGuuZ809TU+HpzGmVmjYcGjbx6bMewFQhvlOcneLvm5vL5BfWFK1SMUy2qdgGR5LyA==
Received: from AM8P189CA0022.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::27)
 by DU0PR07MB9140.eurprd07.prod.outlook.com (2603:10a6:10:404::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 09:34:57 +0000
Received: from ZR1PEPF0000E463.eurprd04.prod.outlook.com
 (2603:10a6:20b:218:cafe::56) by AM8P189CA0022.outlook.office365.com
 (2603:10a6:20b:218::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 09:34:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 131.228.2.20) smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 ZR1PEPF0000E463.mail.protection.outlook.com (10.167.241.56) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Fri, 6 Nov 2026 09:34:55 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 73A38200E6;
 Fri,  6 Nov 2026 11:34:55 +0200 (EET)
From: Juuso Rinta <juuso.rinta@nokia.com>
Date: Fri, 06 Nov 2026 11:34:11 +0200
Subject: [PATCH v2 1/9] watchdog: wdt-uclass: add get_timeout operation and
 helper
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-rinta-watchdog-gettimeout-v2-1-07de25b6312a@nokia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793957695; l=3474;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=OHfD01UrGDS88g6Ydphhyg6VznN9APgx9qdpxQJhnsk=;
 b=KXr12FlJXFh7moBHN5yHVNgzbeHhteESkeZf5bNknU/kzv3mZr3wEkdByfjfPagrXWMU8J4Ma
 Y/+85qj7OQkDyV5Ag0u3sSReztd4vWE8FaP+SQtcgpiozt1ovYpvAHk
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E463:EE_|DU0PR07MB9140:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b79e53f-94bc-4969-772b-08df3be937dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|11063799006|56012099006|261021121427099003|261021123027099003|261009223027099003|261102123227099003|261026121527099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: CJFIYkmejWYkf5UFnBfaVGANay1KrHFNCPYAe6ylUUwksGhFnOcNY5icuQWamAUvuUXHXSkxe8JozbF5vzjNWaExidyZxiGEOVbBwGGVQ5EP6qJtZijQR00aHgwvFZMk3zbA6IsObDGXa27+MaVeE0tBcPw5Is8kkNt2nkABeXBHMzI2V48K7JFXUuziTp9jbKPISlFoEbhDnxlUeD4ltFuJIBe9DhYWy0Fmh7cg+gS7t0j3+gQWdb3Tf3FTuQWExHjSgoqBXTLLbmePaH+TiWTI2D3M3QBaAn1eZ/2NyLEgH0FfO3Z7SClba1GWrco8Sp1OrKnDeaSwA8QmTxVL0O4Jq6bWNRs0RGQ95ZpVvm+5b98udz+uvQdKrIewANm/JTdDJ1L4qaCluwUw+QaMlUIQKpCjv3hFWtdTKfUleyu5/vfvt+xWCUpOO+4Dd/YEryDkFqdE54WXmqro4hrvwzJprzDcBNgOzhNRnizK5yMu0n0n7/H5UX9kbH5pOP6s8Up7gilY6uvqdQkaj7Nq4r9RGVJEQfmdbGzLTJa+50D8tp5MfFCxONeZelrBbMAWv76S4lCi05hTesGCw2xlH9985dE74yk7lXCok2BZXpaqDwYH7jJarwK8TDpzxrnF19fXrvHFR+F9iNWBWIk4VuD5dpiN0D9j95mNLym82CgYgNWMCqbe4PKLvGvoLqzp9ddTqyd3a/w2gjXMp6iEqw==
X-Forefront-Antispam-Report: CIP:131.228.2.20; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fihe3nok0734.emea.nsn-net.net; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(261026121527099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HxGM/bt/K+lGGiH9fhohejRtx/W8a+PUIFo7v56cIdG4tgFfuPPehGBO1aNwSu4dLN/9wPCp6KpuKrUs0Eq7tqnsBVJk3j3IvzK3yip0s0V+RmCTFioi84y8uoR3K5ppohpJB/gt4Lsmdo76GB7esMVCwz8tULgQSrRxZ2hrtBVZDJNGIqN/eI0FVKfETftVpDgq/cKEKh/9emqPHIpZYRi/R2rDEDUvIMkeF7iKI+5AvaIc7HgSOhISn/I1+E4vE68AAsznTayHup4P32Z34odd/y39yLk1reQTZeBCyhSgHMP4dNgTVLhQnqd+phxoA3N8TNqM6wnFkfFvq8zkUM/NVvO5pG0gIOCjl6y4DiStEXX2ju2CNmLtobaWJeFzYzAdQHwdLdfS8+VxQGDij6LIpkhskVDo3kzsTsWp1iYBauN8epd9G+ao8aXmd/ni
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 09:34:55.9512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b79e53f-94bc-4969-772b-08df3be937dc
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.2.20];
 Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-ZR1PEPF0000E463.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9140
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently the wdt_start() function uses the plat data to
check if a driver has reported a max_timeout_ms value and
clamps the requested timeout to that value. This is not enough
on devices where the effective value is not always static.

Add a uclass get_timeout operation and helper so drivers can
report the effective timeout. The helper returns -ENOSYS if the
driver does not implement the operation. If wdt_get_timeout() is
called while the watchdog is not running, drivers should return
-ENODATA. wdt_start() uses the helper to report the effective
timeout when the driver supports the operation.

Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
---
 drivers/watchdog/wdt-uclass.c | 19 ++++++++++++++++---
 include/wdt.h                 | 22 ++++++++++++++++++++++
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/wdt-uclass.c b/drivers/watchdog/wdt-uclass.c
index 88c5cbdf508..291f0187682 100644
--- a/drivers/watchdog/wdt-uclass.c
+++ b/drivers/watchdog/wdt-uclass.c
@@ -116,6 +116,16 @@ int initr_watchdog(void)
 	return 0;
 }
 
+int wdt_get_timeout(struct udevice *dev, u64 *timeout_msp)
+{
+	const struct wdt_ops *ops = device_get_ops(dev);
+
+	if (!ops->get_timeout)
+		return -ENOSYS;
+
+	return ops->get_timeout(dev, timeout_msp);
+}
+
 int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 {
 	const struct wdt_ops *ops = device_get_ops(dev);
@@ -153,10 +163,13 @@ int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 
 		priv->running = true;
 
+		/* Check programmed timeout from driver if op supported */
+		if (wdt_get_timeout(dev, &timeout_ms) == 0)
+			tout_s = lldiv(timeout_ms, 1000);
 		/*
-		 * If the requested timeout was clamped, note the value
-		 * when it differs at whole-second resolution. Sub-second
-		 * rounding is ignored to avoid noise.
+		 * If the requested timeout was clamped or rounded, note
+		 * the value when it differs at whole-second resolution.
+		 * Sub-second rounding is ignored to avoid noise.
 		 */
 		req_str[0] = '\0';
 		if (req_s != tout_s)
diff --git a/include/wdt.h b/include/wdt.h
index db1faa321b3..dc31d2db606 100644
--- a/include/wdt.h
+++ b/include/wdt.h
@@ -74,6 +74,19 @@ int wdt_reset(struct udevice *dev);
  */
 int wdt_expire_now(struct udevice *dev, ulong flags);
 
+/*
+ * Get the effective timeout in milliseconds.
+ *
+ * The effective value may differ from the value wdt_start() passed to
+ * the driver, for example if it has been rounded and/or clamped.
+ *
+ * @dev: WDT device
+ * @timeout_msp: Returns the effective timeout in ms; unchanged on error
+ * @return: 0 if OK, -ENOSYS if the driver does not support this,
+ * -ENODATA if the watchdog is not running, other -ve on error
+ */
+int wdt_get_timeout(struct udevice *dev, u64 *timeout_msp);
+
 /**
  * struct wdt_uc_plat - uclass platform data for a watchdog device
  *
@@ -131,6 +144,15 @@ struct wdt_ops {
 	 * @return 0 if OK -ve on error. May not return.
 	 */
 	int (*expire_now)(struct udevice *dev, ulong flags);
+	/*
+	 * Get the effective timeout in milliseconds (optional)
+	 *
+	 * @dev: WDT device
+	 * @timeout_msp: Timeout in milliseconds, written only on success
+	 * @return: 0 if OK, -ENODATA if the watchdog is not running,
+	 * other -ve on error
+	 */
+	int (*get_timeout)(struct udevice *dev, u64 *timeout_msp);
 };
 
 int initr_watchdog(void);

-- 
2.39.2

