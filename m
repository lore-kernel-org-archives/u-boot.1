Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B99606EEB2
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 09:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TSR29v7h;
	dkim=pass (2048-bit key, unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=uo4+faEl
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3854B4096F;
	Fri,  6 Nov 2026 09:35:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gi3qxNJfe-ME; Fri,  6 Nov 2026 09:35:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 791674097F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793957726;
	b=sf0Oa2or3FAPDMqfUZlRPsP1Ccp/IK0Libjcy/vRJTPw1lBdgd1lsWr9v4xJc29wU1iB
	 aXgTYS9v6BhXNMUKK86j3VbCxgbn7WEag0WQ25SMgqpEDbLjF4cMkWUw1n5sr9umXgzRg
	 Scv/VsAkfkN98E19Od8mpqX6WJgRO1HHcj3Y51cBwJhI3DLbZKKs7D95URwA2avphjAQ2
	 4g2WXhQlJ/Ywj7uHcYwLrJnEXIqCSh4+KKeK/dvQ0DuMcf5L6tQXYqhlRrCZmdtQGyhV8
	 KCy1jobnlQHx7WlfCoXpR6Yc1/r4Oh2mF124+GtBrfTl4MjFb2KVRUNjP8tlWv89fLg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793957726;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
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
	bh=R6nAcvrD5bHRcUwXOg3XhLfJMlySNMB6n2wIV73ZEew=;
	b=r7SyNLUaCugbOwB1vLcnWV9SbSUeJ5lUL9RDd1MN4YHhP9qLqcshqBXDJwEBxcmwNcMu
	 gi9OLkxaEUZnAD306g1ieRhusqcXX3guH4y3/Q2J52dWVQHYBtrGjqBtW2jxCqnh8VjXo
	 fNU7styLsupVck16F4/JDSeXMJaiRcH6Xkjt/EiW167zZz99VrrnmZwrWYHS97PXMm3N+
	 S78bgFOdo9bsdQsk3aFZTznb8qxGZK1JvZzSfTPI7Y1C84eVgsNgLAIEHr13Lpyn3SqsH
	 A7P1nLgWlaTuHFt4N9B3SwvBEPsppYN0jMWtqedbtzyUj6nwlAzeAp/BVHqrvfYQFhQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793957726;
	bh=R6nAcvrD5bHRcUwXOg3XhLfJMlySNMB6n2wIV73ZEew=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=TSR29v7hnK3jGut2SKOvgbJjzn/O057RV5bw41j034C7q9ayP28bRFJIyHijzFC0b
	 OvKUn1ew9lFTODUC469T4m2q4yyLHOFHnXjVpJIqZWHqFF0LijzhAPYVSf1r/Idb6A
	 8JpvoYTiqlXj5V+4ZRUZcAG7u6ntXYgg6brfOYLkRXryl0ymSST15nmMwpaNq5xeAZ
	 IxzzhF2Y3eqPMIjfAcSXOnXn3TvDaTy756EjYT2B+NTTgbltiPVdxx2y2lby/jHNzb
	 HkO3ksOoZGj/8LGF9A98Droy0ryvBGTQZhwPFuQXg5PRJLcI8RHMKBAYB5bjmXP3KO
	 JH1Fu8Zr9jO5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 791674097F;
	Fri,  6 Nov 2026 09:35:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C1FD1E3
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:35:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8E0176069B
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:35:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3m_WqrJxHBkv for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 09:35:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 075B7606A5
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
 header.s=selector1 header.b=uo4+faEl
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 075B7606A5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6nAcvrD5bHRcUwXOg3XhLfJMlySNMB6n2wIV73ZEew=;
 b=uo4+faElaM0EdsFdtvZUdjwV7i+eVB7QcU3irHw2TP2A44vi8EM51u65JAOKLeEUCbFU6VRGLe0CiquuEPsE325FYTb8As6z9iZHKb3F4Z9xMVe367lYVrpSYnRamkINy/Cv4rapkA91zXl8FoDinIwwgsTwZtV2/aD9vTjlVMVEADiA0oRWE5MK40IanzrfPwirtPDA1rqeGhkqFpvH06CpmkeER0QIygUeLZsuipw7LzCtT3dqQ5Pt+nEc4FFPqKljij8iA75rKqJHmLlpdtbhAF2llaMDw3Oq4sv51G0t5HEGeMyw61LByXXFLAXtd7aJfD6F30ZQ5T4cODviAQ==
Received: from DU6P191CA0057.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::15)
 by AS1PR07MB8710.eurprd07.prod.outlook.com (2603:10a6:20b:479::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 09:34:56 +0000
Received: from DB1PEPF000509FA.eurprd03.prod.outlook.com
 (2603:10a6:10:53e:cafe::6a) by DU6P191CA0057.outlook.office365.com
 (2603:10a6:10:53e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 09:34:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 131.228.2.20) smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 DB1PEPF000509FA.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Fri, 6 Nov 2026 09:34:55 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 6A6F4200D8;
 Fri,  6 Nov 2026 11:34:55 +0200 (EET)
From: Juuso Rinta <juuso.rinta@nokia.com>
Subject: [PATCH v2 0/9] watchdog: add get_timeout operation
Date: Fri, 06 Nov 2026 11:34:10 +0200
Message-Id: <20261106-rinta-watchdog-gettimeout-v2-0-07de25b6312a@nokia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABKf7WoC/32OQQ6CMBBFr0K6tqYtKODKexgWbZnCaGy1Lagh3
 N2CJu5cvsn//81EAniEQA7ZRDyMGNDZBGKTEd1L2wHFNjERTOxZJQrq0UZJHzLqvnUd7SBGvII
 bIjV5DbUoTMF0RVL/5sHgc90+NR8OgzqDjsvgN+HhPiRp/MV6DNH51/rRyJfrKudM8D/ykVNGo
 TQ535WqUlIdrbug3Gp3Jc08z2/mWfjG6QAAAA==
X-Change-ID: 20260824-rinta-watchdog-gettimeout-f39e924f40c8
To: u-boot@lists.u-boot-project.org
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Yuri Zaporozhets <yuriz@vodafonemail.de>, 
 Jonathan GUILLOT <jonathan@joggee.fr>, Jonas Karlman <jonas@kwiboo.se>, 
 Simon Glass <sjg@chromium.org>, Juuso Rinta <juuso.rinta@nokia.com>, 
 "Maxin B. John" <maxin.john@gmail.com>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793957695; l=6261;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=G7C+/pZhHCDgS+ohRFY4Iy75zAsRvs/PeguhTHPBqTw=;
 b=cTACCx7rKipE0rEE9hhF+DHwmpIET6AD6geFFbp7k4L92TOLq8ofvsdclBlOwrSDgpzs4d2KG
 PNgjYYEN9b7BtcTxdwoeO572u6Vtv9qvqb7S5/Y1jbsSN0pmT2ssdgj
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FA:EE_|AS1PR07MB8710:EE_
X-MS-Office365-Filtering-Correlation-Id: f89957b9-5160-491e-bcf6-08df3be937dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|261028144727099003|11063799006|56012099006|261022105027099003|261022075727099003|261021121427099003|261021123027099003|261009223027099003|261026140227099003|261102123227099003|261026121527099003|18002099003|6133799003|13003099007|10067099003;
X-Microsoft-Antispam-Message-Info: 0HltXpHaCCoSCcVc6cQsCzcPARt9bYCD/fKc2bBuZltqOKOVe+CtOXjRCTPZm+oaOJMXO071cCiB6CTvv9dRSRqiVaCJraSGnViWlv+mNiSNT09gEjA7/w2X6mCaISgCYfFjz2FdBkBsg7p4eVkMGEhNk5aAz02hxjyUqfw/QLLEhkSjTgyqac06E2JFKI7zwgolQpvbX0O6nLQ2qMtEodLHOaQvUeAYq//W7TqPDksn3v9Zd4nuYQwxyLB5i8V62QgRi1/yR7AYKF2rkSoIU2iCuhjj7wNlueAmDTIpMeYxxEIeJdMA53P81Kwu9I2b3oMrQDH0+cYvK/qnLOc6QcIwbXkG3udI+ArKiSUGnJ5/0QuN089CnrA87oWUdn7IQj2I5geiZIhaJYAshYEOUWRgixeOzwLW6gU8twMqQIb1CPzma/xLPoPuPx4FczvV1nRIDG3ROTCAQ5HjysPHjCOooIi0Ldxwq3D3icnXo+amI5hSWPwHtJ5KCH/qNV1zf1fNDJdId5HbCHBIppEqSE7A/y2uqrVMUCbv1OggVvBMejBUCcLlRUd+LNsh+TKjm+wrcBRLz1OphEzMt6RZPXGxSazWEtiqPrxr+DrVdnugp+iJVUKEh55jZkW1ZtOsaMGoxkGMBLbjEjAmxggfmA==
X-Forefront-Antispam-Report: CIP:131.228.2.20; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fihe3nok0734.emea.nsn-net.net; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(261028144727099003)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(261009223027099003)(261026140227099003)(261102123227099003)(261026121527099003)(18002099003)(6133799003)(13003099007)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YaQ3h/FtgGv02yXwJwtgscOQYkYkmXlJYN2Ru++cBtDuosRNJxjg4ptXxuipAQU6aerLAmIe5nqyheGUIAa6eeqf0B3B3b1znyfYXiNg3ThfzY7q9F/BdjsjAhsUUKBBy4fGMzfvCRmAlRgT/kixcQaew96nZoXx2hnTOPS5QTYIU+Qlel45vjKxC+JKmMSTvXPHOIC29PqzFu3z9XaOFAqCN0boXTNEBa/LjbAH8CrP8kW0U9l34inLEZ3i2RnBxXPu5w5jL/DViVcOE/MHqkRYEGwXNhGbBxOKvRfqBPX6LzjFiy9WPlqNplZRDX8wYGxacc7SztaWFEaJImsjmAeyBHAym7PzyTwoROoOcGjIRpftrOtpT3xBrV4Y0AwWJ4ym9Oz08sNrxtPanDzWBYuK7ZlDjHfFce9tKrHtbqgTAIK3f7hNaixwscf9IiRA
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 09:34:55.9398 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f89957b9-5160-491e-bcf6-08df3be937dc
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.2.20];
 Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509FA.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR07MB8710
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

Add an optional get_timeout operation and a wdt_get_timeout() helper to
the watchdog uclass so drivers can report the timeout actually programmed
in hardware. The requested value passed to wdt_start() can differ after
clamping, discrete steps, or rounding (for example power-of-two periods).

After a successful ops->start(), the uclass calls the new operation via
wdt_get_timeout() when the driver implements the operation and uses that
value in the start-path print. The series also adds a warning when the
timeout value is not longer than the servicing interval.

If wdt_get_timeout() is called while the watchdog is not running, drivers
should return -ENODATA, so callers can tell that case apart from a real
error. This is consistent with arm_smc_wdt, which maps a disabled watchdog
to -ENODATA.

Add a 'wdt gettimeout' subcommand which exposes the same helper to the
U-Boot shell. This command returns CMD_RET_SUCCESS when a timeout is available,
and CMD_RET_FAILURE when the device watchdog is not running or the operation
is not supported.

Implement get_timeout in designware_wdt, max6370_wdt, and sandbox_wdt. The
designware and max6370 implementations have not been tested with hardware
as I do not have access to those devices. Use a lookup table for the timeout
selection in max6370 so that the start and get_timeout functions do not
drift.

Add a timeout rounding up to whole second in sandbox_wdt driver so that
the path where the requested, unclamped timeout differs from the programmed
value when checked with wdt_get_timeout() is testable 

Add unit tests for wdt_get_timeout(), the wdt gettimeout command and the
servicing-interval warning.

This series is a follow-up to "v3 watchdog: report effective timeout"
[https://lore.kernel.org/u-boot/20260818-rinta-watchdog-gettime-v3-0-423f5caf526d@nokia.com/]

Patch summary:
- Patch 1: Add a get_timeout operation and wdt_get_timeout helper
  function for wdt-uclass. Update the wdt_start function to use this helper
- Patch 2: Add a warning print in wdt_start() if the programmed timeout
  reported via the get_timeout op is not longer than servicing interval
- Patch 3: Store the device sequence number instead of a pointer in
  cmd/wdt.c
- Patch 4: Add a gettimeout subcommand to the wdt command in cmd/wdt.c
- Patch 5: Implement the get_timeout operation for designware_wdt
- Patch 6: Use a lookup table for timeout selection in max6370_wdt.c
- Patch 7: Implement the get_timeout operation for max6370_wdt
- Patch 8: Implement the operation for sandbox_wdt, introduce timeout
  rounding for sandbox_wdt_start()
- Patch 9: Implement tests for wdt_get_timeout(), wdt gettimeout and the
  warning print

Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
---
Changes in v2:
- Rename timeout_ms to timeout_msp in wdt_get_timeout() and the driver
  implementations
- drivers/watchdog/wdt-uclass.c: move wdt_get_timeout() in wdt_start()
  before the comment block "If the requested timeout was clamped..."
- drivers/watchdog/wdt-uclass.c: issue warning print for timeout not
  longer than servicing interval in wdt_start() on all devices instead
  of just for those that support get_timeout operation
- cmd/wdt.c: store the currdev sequence number instead of a pointer
- doc/usage/cmd/wdt.rst: add a mention that the 'wdt gettimeout'
  returns CMD_RET_FAILURE when the watchdog is not running or the driver
  does not support the operation
- designware_wdt.c: replace hardcoded 0xF/15 value with a define, include
  div64.h and use lldiv() in the designware_get_timeout() division
- max6370_wdt.c: add a lookup table for timeout selection, use it on both
  max6370_wdt_start() and max6370_wdt_get_timeout()
- sandbox_wdt.c: make the sandbox_wdt_start() round the requested timeout
  up to a whole second so that the path where requested and unclamped
  timeout differs from programmed timeout when checked with
  wdt_get_timeout() is testable
- test/dm/wdt.c: move the 'wdt gettimeout' tests to their own file,
  split the tests that exercise the wdt_get_timeout() function into
  their own function, and the tests that test the warning print to
  their own function
- test/cmd/wdt.c: test the 'wdt gettimeout' command with both the sandbox
  and gpio devices (supported and unsupported path)
- Link to v1: https://patch.msgid.link/20261021-rinta-watchdog-gettimeout-v1-0-e7f3157b8bab@nokia.com

To: u-boot@lists.u-boot-project.org
Cc: Stefan Roese <stefan.roese@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Juuso Rinta <juuso.rinta@nokia.com>
Cc: Yuri Zaporozhets <yuriz@vodafonemail.de>
Cc: Jonathan GUILLOT <jonathan@joggee.fr>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>
Cc: "Maxin B. John" <maxin.john@gmail.com>
Cc: Rasmus Villemoes <rv@rasmusvillemoes.dk>

---
Juuso Rinta (9):
      watchdog: wdt-uclass: add get_timeout operation and helper
      watchdog: warn if timeout not longer than servicing interval
      cmd: wdt: store the device sequence number instead of a pointer
      cmd: wdt: add gettimeout command
      watchdog: designware_wdt: add get_timeout operation
      watchdog: max6370_wdt: use a lookup table for timeout selection
      watchdog: max6370_wdt: add get_timeout operation
      watchdog: sandbox_wdt: add get_timeout operation
      test: wdt: add tests for get_timeout support

 cmd/wdt.c                         | 66 ++++++++++++++++++++++++-----------
 doc/usage/cmd/wdt.rst             | 12 ++++++-
 drivers/watchdog/designware_wdt.c | 23 +++++++++++--
 drivers/watchdog/max6370_wdt.c    | 49 ++++++++++++++++++--------
 drivers/watchdog/sandbox_wdt.c    | 17 ++++++++-
 drivers/watchdog/wdt-uclass.c     | 24 +++++++++++--
 include/wdt.h                     | 22 ++++++++++++
 test/cmd/Makefile                 |  3 ++
 test/cmd/wdt.c                    | 60 ++++++++++++++++++++++++++++++++
 test/dm/wdt.c                     | 72 ++++++++++++++++++++++++++++++++++++++-
 10 files changed, 307 insertions(+), 41 deletions(-)
---
base-commit: 709a97a05df66e394f40d249105d0baade46f107
change-id: 20260824-rinta-watchdog-gettimeout-f39e924f40c8

Best regards,
--  
Juuso Rinta <juuso.rinta@nokia.com>

