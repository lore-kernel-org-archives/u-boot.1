Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A59E606D829
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 09:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MjBECuKQ;
	dkim=pass (2048-bit key, unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=ig1bNIiL
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7619D4096E;
	Fri,  6 Nov 2026 09:35:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QQUkIvrH2v7Z; Fri,  6 Nov 2026 09:35:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5C85940966
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793957722;
	b=dethktV+IUWlok4KBC2xM3K2pSoCbm0T7dc+CcoBHdh5/KqEWQSOvj7g3/e7BP2aJ3a5
	 QktJWz8n2lBpAs+9VlIBQ+xGbUvzTZ/5UDw1+OjUOhZ+E6KQec8tmv2uIeWh/qsHHLaTF
	 ms9vIKh/FntbJbPQSgcNF4k4yQ1jtLF4xsgdHLIvGoioWBrm3vuFhvFuzop5mphQ9v2Zx
	 Nk6p6Cq7/LIxlGG2PHeUSwTKM2QMYEYQjbEfAsPZFmFIePBhszr+25m4uXSrw+hzq6CD3
	 Je2ihtObXZFOdJXNbMsOWDkWwrxkeM/YOZoqOF/zowDqRQ9eJx//BE1bcxdgXvopbTQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793957722;
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
	bh=0AzCRNzQXKUmGVWkXUnwx6zZntKTmXuf21M3TH5fxhU=;
	b=qtKXlB7eBrOviaDjWfeJlaPsiODIMD5uVNllU/qhHw5uBF9osfaRMQXCcCwuwsTIS10S
	 +dcgfBoiLxm5bLF3OSHyAFkkd/XUzE4TKDwr8L3614ZRr/Jt2UkjCT7k19eDhjd4RKThB
	 QSNI9USMBuphuOvdhCKi5Br0ww0Wj5OlnepiffyaLVhb04qmoPHanMp4NSkaDvPqAoKVB
	 U9tob5c6K1ZhqZkLggcLQvoxztOZo2yk9lMnGjPk3wXZETrUiDX2lta4j2pjZBPc4Q5fQ
	 bbdKrIPo0zOuJGHoZq9VXECgzvK0/gD4m28AH2g7Dww4TWueiE01uJbdC7PR/ahijtg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793957722;
	bh=0AzCRNzQXKUmGVWkXUnwx6zZntKTmXuf21M3TH5fxhU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MjBECuKQf1BKPACbq2TXabongZ/sJwjRMLZy3zflr7zcPwW7nayEjsdsKkCLj3TG4
	 BEqnw/ymPPuQ+kQFKvPljhKCIY6IphuYg2EzIxdJjS5j4Vc8tM/y8nAZOOlaPf6ZqR
	 0K/0nVwvs0PFF5+KgFoEbxRbAwF5gyQCvRNnyO5OntpdxsjI5fVlzXVLqPx6e+huLo
	 paOTynBPQvv2c10AZgm6j4A6fnJdHkWz0TAVoZSrBxeRUYg+xYubOBYZV9BNvlH4C2
	 mP7mNFl7AEIYkWVNXV8WE4xSroQYNsCw4bw9uilXwzSZBCRwhE1HO7Iv+e1TkapFqx
	 o3Y2EwoSS92+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5C85940966;
	Fri,  6 Nov 2026 09:35:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E040834D
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:35:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D1C7581195
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:35:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oIwooAjwqymq for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 09:35:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0738E81188
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=juuso.rinta@nokia.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=ig1bNIiL
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0738E81188
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AzCRNzQXKUmGVWkXUnwx6zZntKTmXuf21M3TH5fxhU=;
 b=ig1bNIiLcLJxjnLwW0b7yv1WnNNzRN2rGxr+n7719eG5RpBv8G9MHxkkZayCQWag6xUBxgwWaABRvS7xThDgNQBBYPUikVCtT3dnaCjrUyIGLq+b2EjLmETiurfFNoUr05zvPFZH3DjDec2qETmdtwJzTVvXpksrhokDjQnqTlT96pmUAeqDw+yd79aBWaN7B/K1zVouEJmIp0Jwi/9ZdVkvhOsQzQazCaVjDSAY09wJXnoateQeVmgeYGJs4pMpuy4+W0DWQI5RKUP0C53+e6fmhHOKZlAFusIQ4boqW+2BODgrXDLo/S77MyT+us6vOvOv/hDHyC1C9bmg3p/QSQ==
Received: from AS8P189CA0015.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:31f::11)
 by VI1PR07MB9754.eurprd07.prod.outlook.com (2603:10a6:800:1d7::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Fri, 6 Nov 2026
 09:34:57 +0000
Received: from ZR1PEPF0000E462.eurprd04.prod.outlook.com
 (2603:10a6:20b:31f:cafe::7e) by AS8P189CA0015.outlook.office365.com
 (2603:10a6:20b:31f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 09:34:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 131.228.2.20) smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 ZR1PEPF0000E462.mail.protection.outlook.com (10.167.241.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Fri, 6 Nov 2026 09:34:56 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id B04B42007F;
 Fri,  6 Nov 2026 11:34:55 +0200 (EET)
From: Juuso Rinta <juuso.rinta@nokia.com>
Date: Fri, 06 Nov 2026 11:34:18 +0200
Subject: [PATCH v2 8/9] watchdog: sandbox_wdt: add get_timeout operation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-rinta-watchdog-gettimeout-v2-8-07de25b6312a@nokia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793957695; l=1905;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=XQYzKkWrMGwyim1lfYaJleye1RbqK5xTxj9V+3eUQ4A=;
 b=gcqIOoNHFqQlc+YmCYEXsh57D27aVEQhHhZ2PTt+hv0305d4E9B6j2NFSzm3a+2cw0GmFMS04
 hpEcoaDXa/0CLVeYv2NqO6XZv9w/YHovJqh2UcfIeRM2eXhsljIAJ6o
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E462:EE_|VI1PR07MB9754:EE_
X-MS-Office365-Filtering-Correlation-Id: 4569aa0e-846e-4fc4-f514-08df3be93867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|261102123227099003|261021123027099003|11063799006|261021121427099003|261009223027099003|56012099006|261026121527099003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: ORPd7aDnpR1Dd/59ijXEjZx6JOzBfe3h8C7WFF71fD2RLQ0rSV8C9yYbkcrtI3qoYAFP6omLBSExaOuvGRNXB5Icqd2AMTMvMvY/mLku/TB/JCuj+/6eqiQIFieBt/HoI5alVn5A9DRhe9NOF1C4+rNQnY10U3wEsHtOsv7+L0lfewjF8AC0IbeXMEXK/v0F8GgPoOKd1b1bLdaFpALO0pN5uyaaOCb9LZqx2FM6tZwyeO9rZOuU5sCX8GxgYv/gRJGSobW8M+SRKVh78TIjn1CdiU09GCLmWtrs7bdHqrYBHkVqit7VLhMkJm1rpKlscwqVE0tgDQqpd9MtVm8lkc6iwMTDonWEAuvYZDdzXX/f1W3FqioXQhv0cl67FE0HKB6XdJddE1ZnHsr7iVWUHSWwi/TeW+Mw9K7i/IevcECRKNr7L+BKl70/fdLooe4bTVr67N42J+yGYq8FgHGwu0Bx82S5f6RILSaxuD7Qt59oMzbbTaXGCzZRZfGZFDc+Jq2Iu9bL+G9DXKXK/q/TyXvd9p1VQJewMfGFJ2I8D0kLv1lG0/cZ0jC+sN3dMZLchVPvlN8lb/rvn0uRDI/pqX9eMdmB7sqwb8H7oEhz8MeeLC46Noc88JxCwlztazalpZ+pFMiJYOUo21s7peqaWv9lpWwQedexs/P+QVkMMpidQxj0CcdZOKw7mKmajtN+
X-Forefront-Antispam-Report: CIP:131.228.2.20; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fihe3nok0734.emea.nsn-net.net; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(261102123227099003)(261021123027099003)(11063799006)(261021121427099003)(261009223027099003)(56012099006)(261026121527099003)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: f01+9aKQeRSM4HCGIpMj0bIOWPZAHwXJ9lDAwywWQrCg7eJW2obxOcGVu1YduKhHu3jcjfLu4pUBEj5wWkeqKOz6bFsXe0VKseRex4n2UgI2iF8BOrt9YEuQDz6ZKWVGuVbPWszr9lmhpWGgo4SyHOxEFjcwlsIINVsKl/e2+MS7bXm8juufjcz3MNfx9zKakbjxIKMc0J51KytVdGlXYDwXGDdOdGyEVhw0qpYBrYqVYtIVn+4WRj3UnGLQi70a9rdMOa1D89bfIz+kQre+LcX0o+SYZYZpqHakWx1Xe7PoLUenqtuL7epxhlLfuOrj5myXqNAwOiWfEZhKxZMEQHA0Qg/sBE2rVOfAsAraW5o4OV66SiKcZhGPluNFivc+J1gIV8/GzZtv3bIT0GF0okj+elcFA+I1CdLA5tJ6oVzuI3PE/wG//ew6TpwVHlJN
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 09:34:56.8643 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4569aa0e-846e-4fc4-f514-08df3be93867
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.2.20];
 Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-ZR1PEPF0000E462.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9754
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

Implement the get_timeout operation for the sandbox watchdog driver.

Round the timeout in sandbox_wdt_start() up to a whole second to
emulate hardware with 1s granularity, so that the effective timeout
can differ from the requested one and the tests can check that.

Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
---
 drivers/watchdog/sandbox_wdt.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/sandbox_wdt.c b/drivers/watchdog/sandbox_wdt.c
index 9a0cdac232a..7b1acb69a64 100644
--- a/drivers/watchdog/sandbox_wdt.c
+++ b/drivers/watchdog/sandbox_wdt.c
@@ -3,6 +3,7 @@
  * Copyright 2017 Google, Inc
  */
 
+#include <div64.h>
 #include <dm.h>
 #include <wdt.h>
 #include <asm/state.h>
@@ -11,7 +12,8 @@ static int sandbox_wdt_start(struct udevice *dev, u64 timeout, ulong flags)
 {
 	struct sandbox_state *state = state_get_current();
 
-	state->wdt.counter = timeout;
+	/* Emulate hardware with 1s granularity, round up to a whole second */
+	state->wdt.counter = DIV_ROUND_UP_ULL(timeout, 1000) * 1000;
 	state->wdt.running = true;
 
 	return 0;
@@ -43,6 +45,18 @@ static int sandbox_wdt_expire_now(struct udevice *dev, ulong flags)
 	return 0;
 }
 
+static int sandbox_wdt_get_timeout(struct udevice *dev, u64 *timeout_msp)
+{
+	struct sandbox_state *state = state_get_current();
+
+	if (!state->wdt.running)
+		return -ENODATA;
+
+	*timeout_msp = state->wdt.counter;
+
+	return 0;
+}
+
 static int sandbox_wdt_probe(struct udevice *dev)
 {
 	struct wdt_uc_plat *plat = dev_get_uclass_plat(dev);
@@ -58,6 +72,7 @@ static const struct wdt_ops sandbox_wdt_ops = {
 	.reset = sandbox_wdt_reset,
 	.stop = sandbox_wdt_stop,
 	.expire_now = sandbox_wdt_expire_now,
+	.get_timeout = sandbox_wdt_get_timeout,
 };
 
 static const struct udevice_id sandbox_wdt_ids[] = {

-- 
2.39.2

