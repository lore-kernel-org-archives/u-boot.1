Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC21E606D829
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 09:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JwEkPLqr;
	dkim=pass (2048-bit key, unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=Ntk6N6aA
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 93DC240967;
	Fri,  6 Nov 2026 09:35:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8z9z-yt1ztGc; Fri,  6 Nov 2026 09:35:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 956BA40963
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793957720;
	b=PkjY2Uh8ETDL2sLsGSvUN3fbAX+1DTlKik3t+Xzfnz7N9JdV+T7EfYP/AiwgljXAiN2L
	 UBpieFGCPWIrxfRJaiBgChGyEcOqBohYw402Uuod+ECAk4cdn4+RG1ZVFu5pSzRHS02Uh
	 zRA4ob1WWRYMndJmdnN1fGjCHzcjbvIlzbFMrvXBp+piGdIF3HTdmU6BEiXLPTaW3GH2S
	 smj8ztH+OdyAOYpGyy9bLbU5x0G03exbO9mQJCibDkN8W1czftplAD3Ohkv88rKsmct+w
	 kVpaSWzt3eafWkWhHTwwL8lZdhtNEpJmZqvnXucS8oDlUI4zMZph4rx+8xSki5/0t1g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793957720;
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
	bh=z3o8NlgYvH06eKt45sKGUkCiVcPB8MmrRqtzZTst8y4=;
	b=WI7nXV1uxoukwi8P3Ub4N/qpVGA2P2MYEaOykzjCsOTSdX/rydH+kxmKF9/O0f3mtkL+
	 jB/IWT1+nmn3Y8y3xEPkAwvv7x4vIi+mraSdvjFQaOMYjCZE+Mn78qPFdP4Sg9P2eDtF2
	 tXlQDFGt+jt2v9GE2a8VoZ/M6lkdGXOm7A1084hTu3UQAfn3GGL3pfyq+w4Nm5+m4nDQV
	 pLmU0u7J9pqKsZYlpaM4YNU/OjHcaPgsdktrY706ComCLDlXkZYtbLyngpod5eohv+9J5
	 Bs03Zktu+5xws3/lPtJBuSTpDcY4l2Fok2T2RfDawKf/Z+X5tMJoefNe1m4nf0OcVDg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793957720;
	bh=z3o8NlgYvH06eKt45sKGUkCiVcPB8MmrRqtzZTst8y4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JwEkPLqrfRLGIIjwLqDTZ39vekrv3PNEv2kKtU3tn09rztqVSSNTLCaTY/ju1pTu1
	 80L+W0W1rHrYJh2rXEvCCXCNyGv4oKwgT37SQtUtjORfCnNBOuf2EQoXgfVavE5E/3
	 KJSXL2DLuft0lCuS7KTFT+0vSKAZJJjJxYyyhmSGr167mXv3zgEJjmiNkjYeDv1BJ2
	 HTY8dxIHulc55PC+RMyKQ2YiDaF4G+oETPJbjelKWi6MYzjq6Iaf9CnbEhlpuTco8i
	 j/tHyteIkGZN6wLW8IR2yLVHB2NSbb2jWk1VgAy4XulPrqy5v2VBJhVGOmnSncKbW5
	 19Bh1B4eQfS1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 956BA40963;
	Fri,  6 Nov 2026 09:35:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C203634D
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:35:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7E96960774
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:35:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JTCqnsQBkLWe for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 09:35:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 43E066069B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=juuso.rinta@nokia.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=Ntk6N6aA
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 43E066069B
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3o8NlgYvH06eKt45sKGUkCiVcPB8MmrRqtzZTst8y4=;
 b=Ntk6N6aA81dIMClMLeiBYOL5Helqj9bvPRKv+O8wDmnRSFWzOFoI0tV00PXq96dz+7JiAlRYy8PLEe/IZc9PeKFIbTsFu/hZBOQ/FerkkG5TCW9Av+KUPorliLrAHsNxzpvK4fNiw+kDu4MI4Q/oVnZKIK+YMLoRWcNPTxZjFK4+9Kn2qeg6KttgPJmMUXr2WOgecVRc5VxIKOrKjGwpS7VBMVzU1m2O1qkhhCqpAR+T/OHmFiJsrJjo/sgSnPCCz9UVWYzmcT6wIDkdOSPFwQV5q8vwi2WlNP5+tJ1MvXD13YT3XFSs8xmxm67UDF12oF9T070VY16XJBma/NK4XQ==
Received: from AS9PR05CA0102.eurprd05.prod.outlook.com (2603:10a6:20b:498::27)
 by GV2PR07MB997967.eurprd07.prod.outlook.com (2603:10a6:150:31e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 09:34:57 +0000
Received: from AM7PEPF00000054.EURPRD83.prod.outlook.com
 (2603:10a6:20b:498:cafe::72) by AS9PR05CA0102.outlook.office365.com
 (2603:10a6:20b:498::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 09:34:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 131.228.2.20) smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 AM7PEPF00000054.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.2
 via Frontend Transport; Fri, 6 Nov 2026 09:34:57 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id BAE132010D;
 Fri,  6 Nov 2026 11:34:55 +0200 (EET)
From: Juuso Rinta <juuso.rinta@nokia.com>
Date: Fri, 06 Nov 2026 11:34:19 +0200
Subject: [PATCH v2 9/9] test: wdt: add tests for get_timeout support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-rinta-watchdog-gettimeout-v2-9-07de25b6312a@nokia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793957695; l=7069;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=U5hexThMD/osdI76zU8spNAO7k2SuKweXkStIZb7i60=;
 b=6yNtYXa5dfgGwJIAuIzZ8Dp3jhku0ApAE3unV3WlERLMMheKDA/iVgtSSlsupmYcuddLu9CzD
 1n3vsl/8fdABl+8YOFn/Nk3UwOpwOpZEWNSHqvJ38I5VEutybp92s/d
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PEPF00000054:EE_|GV2PR07MB997967:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d20877f-0122-42e6-3430-08df3be93889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|261028144727099003|11063799006|56012099006|261021123027099003|261009223027099003|261021121427099003|261022105027099003|261022075727099003|261026140227099003|261026121527099003|261102123227099003|18002099003|22082099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: Q3DiglG6riJxRhDV+2isGyB2ORxzkoljqxoa9goIggbPWV/YfObrL3H8ayHQYwy+6yt643dj8MOqU/cGkY63N18LaCde5TirU2TafVNhRphkq8AbgUS7olECDBD8qqf0EdEsqIWXi4SH/roMO33jLe9wwt34k9VXC/Frdrc1vCSAhc7vr93oJQ63ZOSzuvvqiH4vH/I2S8nhrltUj52COoXgH8lD07yLBThtJj8MCYPg0boEUXdU7tEFxHcaRx6W3NCLBvyYYjTnt0lBP9hIgcPx6PXiL2Y5rYtWAWn0OFbEdiAWDe+l5Lfsc7WCaPnDcYFnfC6Pk3LH3ZJCyTHC/jXymTQ3itRAzi1TN5jS2VHhIbG6qk/FW6dgzi3ybYyALGvM+pvwWTv3SO0aX4kBnIJEw6c6dz9HZDU9IUBuMksR7TQFl1NqoyamQrKgyg8uuIoD9gvg/BubtPoZ4Y+r+5+iFR2Pmg81RGepzozkTZC3cviQE7j9814FOQn+B9q77QJmshuz4Cf76kbpHPPvd7JzhcqU7WwyAV89efb388DXgFwMGx3104mIMUi69WrajPpQoRgpM6FatTGWASa9pO9Nuu+W1pFMdxejSBJeF69jArQHXmU28l1ZxCYbsyOmmHxKON6aJL7EvHSmGmyzPQzrOtLoKu1ctJnqif2jWkfR0N7KGwLuzGvsoeWa9JSokOAsDGeOWvw25kwvIuAqhg==
X-Forefront-Antispam-Report: CIP:131.228.2.20; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fihe3nok0734.emea.nsn-net.net; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(261028144727099003)(11063799006)(56012099006)(261021123027099003)(261009223027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261026140227099003)(261026121527099003)(261102123227099003)(18002099003)(22082099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HVUkPZTfUM/AM9Srw6woztxFE/Ao6wKy2en+lCLGDFW3b4cursxpMmqmpc0MjU7od0Hp7He7nWaUes2Mp3dahyWnkRuCMbAYO9r/HXHmrg+lDrrWoOZk9GBhSlDnXsqdHEx37O0l3EJD93cWUBgEsVMDEv4jbaZbxM5ie/X/mxkdBCf17C4s8ewM6yRHxnuCD7E/jzuwmoEdaGVHFDhZcm4TwqI92d3XnSKvs3tRQPghNh6YXNikrQk58OpkOIzIc2AVxF4aOOnN6uYaUVsuN+yrYeK5z1/tQQagshoOt1k98h1EJ6MBzvtLFANBVFF7KJ4m6QERYnKukr0HyC3BPLCuLxvDRDHNpC3yFu3CjOUM9TZTHZ7LeJL328DEiJEYQ4+MDY3Rs5gWJiz0y+D+sI3c2SLbVjzc8MbcC9KuSNkuBuAyc3KohaR6Htzr9HGU
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 09:34:57.0420 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d20877f-0122-42e6-3430-08df3be93889
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.2.20];
 Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM7PEPF00000054.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB997967
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

Add tests for (1) get_timeout operation, (2) warning print when
the timeout is not longer than the servicing interval, and (3)
the wdt gettimeout command

The get_timeout success-path and not-running case is tested with
the sandbox driver, and the not-supported path through the GPIO
driver.

Warning print is tested via the gpio driver. The sandbox driver
rounds the requested timeout up to a whole second so the timeout
is never set lower than or equal to the 50ms servicing interval.

For the 'wdt gettimeout' command tests, a new test/cmd/wdt.c file
is added and the file is included to test/cmd/Makefile.

Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
---
 test/cmd/Makefile |  3 +++
 test/cmd/wdt.c    | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 test/dm/wdt.c     | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 134 insertions(+), 1 deletion(-)

diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index 79cbb291250..9ecc665262a 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -43,6 +43,9 @@ obj-$(CONFIG_CMD_PWM) += pwm.o
 obj-$(CONFIG_CMD_READ) += rw.o
 obj-$(CONFIG_CMD_SETEXPR) += setexpr.o
 obj-$(CONFIG_CMD_TEMPERATURE) += temperature.o
+ifeq ($(CONFIG_CMD_WDT)$(CONFIG_WDT_GPIO)$(CONFIG_WDT_SANDBOX),yyy)
+obj-y += wdt.o
+endif
 ifdef CONFIG_NET_LEGACY
 obj-$(CONFIG_CMD_WGET) += wget.o
 endif
diff --git a/test/cmd/wdt.c b/test/cmd/wdt.c
new file mode 100644
index 00000000000..186c32c521c
--- /dev/null
+++ b/test/cmd/wdt.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2026 Nokia
+ */
+
+#include <command.h>
+#include <console.h>
+#include <dm.h>
+#include <dm/test.h>
+#include <test/test.h>
+#include <test/ut.h>
+#include <wdt.h>
+
+/* Test the wdt gettimeout command supported path */
+static int dm_test_wdt_cmd_gettimeout(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+	const u64 timeout = 5000;
+
+	ut_assertok(uclass_get_device_by_driver(UCLASS_WDT,
+						DM_DRIVER_GET(wdt_sandbox), &dev));
+	ut_assertnonnull(dev);
+
+	ut_assertok(run_commandf("wdt dev %s", dev->name));
+	ut_assertok(run_commandf("wdt start %llu", timeout));
+
+	console_record_reset();
+	ut_assertok(run_commandf("wdt gettimeout"));
+	ut_assert_nextline("Timeout: %llums", timeout);
+	ut_assert_console_end();
+
+	ut_assertok(run_commandf("wdt stop"));
+
+	console_record_reset();
+	ut_asserteq(CMD_RET_FAILURE, run_commandf("wdt gettimeout"));
+	ut_assert_nextline("Watchdog not running.");
+	ut_assert_console_end();
+
+	return 0;
+}
+DM_TEST(dm_test_wdt_cmd_gettimeout, UTF_SCAN_FDT | UTF_CONSOLE);
+
+/* Test the wdt gettimeout command unsupported path */
+static int dm_test_wdt_cmd_gettimeout_unsupported(struct unit_test_state *uts)
+{
+	struct udevice *wdt;
+
+	ut_assertok(uclass_get_device_by_name(UCLASS_WDT,
+					      "wdt-gpio-toggle", &wdt));
+	ut_assertnonnull(wdt);
+
+	ut_assertok(run_commandf("wdt dev %s", wdt->name));
+	console_record_reset();
+	ut_asserteq(CMD_RET_FAILURE, run_commandf("wdt gettimeout"));
+	ut_assert_nextline("Getting watchdog timeout not supported.");
+	ut_assert_console_end();
+
+	return 0;
+}
+DM_TEST(dm_test_wdt_cmd_gettimeout_unsupported, UTF_SCAN_FDT | UTF_CONSOLE);
diff --git a/test/dm/wdt.c b/test/dm/wdt.c
index 2e9d641d6bb..5c524c7482a 100644
--- a/test/dm/wdt.c
+++ b/test/dm/wdt.c
@@ -18,7 +18,7 @@
 #include <u-boot/schedule.h>
 #include <watchdog.h>
 
-/* Test that watchdog driver functions are called */
+/* Test that watchdog driver start, reset and stop functions are called */
 static int dm_test_wdt_base(struct unit_test_state *uts)
 {
 	struct sandbox_state *state = state_get_current();
@@ -75,6 +75,72 @@ static int dm_test_wdt_base(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_wdt_base, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_CONSOLE);
 
+/* Test the watchdog driver get_timeout operation */
+static int dm_test_wdt_get_timeout(struct unit_test_state *uts)
+{
+	struct sandbox_state *state = state_get_current();
+	struct udevice *dev;
+	u64 get_timeout_val;
+
+	ut_assertok(uclass_get_device_by_driver(UCLASS_WDT,
+						DM_DRIVER_GET(wdt_sandbox), &dev));
+	ut_assertnonnull(dev);
+
+	ut_asserteq(false, state->wdt.running);
+	/* wdt_get_timeout() returns -ENODATA when watchdog is not running */
+	ut_asserteq(-ENODATA, wdt_get_timeout(dev, &get_timeout_val));
+
+	/* sandbox_wdt_start() rounds up to a whole second */
+	console_record_reset();
+	ut_assertok(wdt_start(dev, 4500, 0));
+	ut_asserteq(true, state->wdt.running);
+	ut_assert_nextline("WDT:   Started %s with servicing every 50ms (5s timeout, requested 4s)",
+			   dev->name);
+	ut_assert_console_end();
+	ut_assertok(wdt_get_timeout(dev, &get_timeout_val));
+	ut_asserteq_64(5000, get_timeout_val);
+
+	ut_assertok(wdt_stop(dev));
+	ut_asserteq(false, state->wdt.running);
+
+	return 0;
+}
+DM_TEST(dm_test_wdt_get_timeout, UTF_SCAN_FDT | UTF_CONSOLE);
+
+/* Test wdt_start() warning prints when timeout not longer than servicing interval */
+static int dm_test_wdt_warning(struct unit_test_state *uts)
+{
+	struct udevice *wdt;
+
+	ut_assertok(uclass_get_device_by_name(UCLASS_WDT,
+					      "wdt-gpio-toggle", &wdt));
+	ut_assertnonnull(wdt);
+
+	console_record_reset();
+	/* Warning, timeout shorter than servicing interval */
+	ut_assertok(wdt_start(wdt, 24, 0));
+	ut_assert_nextline("WDT:   Started %s with servicing every 25ms (0s timeout)",
+			   wdt->name);
+	ut_assert_nextline(
+		"WDT:   Warning: timeout 24ms is not longer than servicing interval 25ms");
+
+	/* Warning, timeout equal to servicing interval */
+	ut_assertok(wdt_start(wdt, 25, 0));
+	ut_assert_nextline("WDT:   Started %s with servicing every 25ms (0s timeout)",
+			   wdt->name);
+	ut_assert_nextline(
+		"WDT:   Warning: timeout 25ms is not longer than servicing interval 25ms");
+
+	/* No warning, timeout longer than servicing interval */
+	ut_assertok(wdt_start(wdt, 26, 0));
+	ut_assert_nextline("WDT:   Started %s with servicing every 25ms (0s timeout)",
+			   wdt->name);
+	ut_assert_console_end();
+
+	return 0;
+}
+DM_TEST(dm_test_wdt_warning, UTF_SCAN_FDT | UTF_CONSOLE);
+
 static int dm_test_wdt_gpio_toggle(struct unit_test_state *uts)
 {
 	/*
@@ -87,6 +153,7 @@ static int dm_test_wdt_gpio_toggle(struct unit_test_state *uts)
 	const u64 timeout = 4000;
 	const int offset = 8;
 	int val;
+	u64 get_timeout_val;
 
 	ut_assertok(uclass_get_device_by_name(UCLASS_WDT,
 					      "wdt-gpio-toggle", &wdt));
@@ -104,6 +171,9 @@ static int dm_test_wdt_gpio_toggle(struct unit_test_state *uts)
 			   wdt->name, (u32)lldiv(timeout, 1000));
 	ut_assert_console_end();
 
+	/* GPIO driver does not implement get_timeout op */
+	ut_asserteq(-ENOSYS, wdt_get_timeout(wdt, &get_timeout_val));
+
 	val = sandbox_gpio_get_value(gpio, offset);
 	ut_assertok(wdt_reset(wdt));
 	ut_asserteq(!val, sandbox_gpio_get_value(gpio, offset));

-- 
2.39.2

