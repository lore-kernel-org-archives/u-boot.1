Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022F5606D83E
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MDmBQCQW;
	dkim=pass (2048-bit key, unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=riuQJkq2
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB7484095B;
	Fri,  6 Nov 2026 09:35:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z61zB0vMetaX; Fri,  6 Nov 2026 09:35:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8F8BF40955
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793957717;
	b=Cr4ESMSwDUyz0o8Iv0QcTCtUpRMTYBvTo8FCbgzDMmeyhD7h3wfV6C5ByX+nOAHN+3v1
	 JKLlKtCZeCLoxbz4ND7nQjw/Fi199OdsjKJ8Kz+pQqVqq9XbxzuxozjdXMeW/Z/TUZmhk
	 zT1WjFsBk2+mAw6QmsVa+4YmxykXdoTIuR0PRRFRDgshBRu8MO5wt5TvgP5T7R5CLOsVJ
	 nXPymQECAPZOVIXF3W6xFXhoo31v5B0YfaSFK/v4BKs2C5zMEQCUYN7Nx6aKJpCG515kp
	 PTiF6f4y61yKU7oxlQ8l/r1Cp9oACLmnyNGygejtabbYSKn/5MSi+b5hsTEqfL+460w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793957717;
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
	bh=MJli6vRYJrarQvLP9Xr+PajYXfw1dTHBuGD8JhnsMUM=;
	b=i+N4A8JGIegVLoOrx3fKFdOG76ifz8jtGQBb8Pc4haJdv6cVSlduSFCibnD8DxC4XJkS
	 RElirHBgfcXwb9c2WE47d85g2j/1lHGy2piZGb2FCJANIHfQB+wu/+4zUcV9h35U/DEMd
	 aTC975nCUWFhXdiw6RQFv7GwOZZ1yXXVbIEy1qneNBqW6GJrLyGgJ9m66YS2GXd0m9yME
	 iR9/cK/lHhQsiJ72gx8etPdChdGACBfDusDXnrZo3dq8T62JZGC7FAhQ5JTDNQjCyuuaA
	 gH+axLV5KtVHcVEiJ5OXbVG+a6YzC7BiOpOkeIBBRs+sLkUmJketUjCUYCgXVwyyTUg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793957717;
	bh=MJli6vRYJrarQvLP9Xr+PajYXfw1dTHBuGD8JhnsMUM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MDmBQCQWpg2q9dXKJ9fMGay1v6nN4Brmhl06KwUvgJgl6sgd9PeXCaszukloyRqLE
	 zB05lIh7PDzJ0a2aeFOJBNTVSDs5OXsYSARqmW33S8dRToSOnG7zr4DO+cWwUF7Lbo
	 dlK3TfZceMQnH7/f0tIjQx98L3plXKWvwhFn7d8w1BJrejvw0956moxn+7UKtpzosX
	 QE2JvzNt/Rmb6tHC4XhKEaj6Zc+1Lpth5UvwyjQzDfDeaZI4qkxfnvgk0YMSEv8XKt
	 OZgh9dYRWBsa3kedXwf2szX9fvyu2lH1Whhp26IYYBA518S1yb08qCUzLFEuXcLoEi
	 V7hWdl4axTRBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F8BF40955;
	Fri,  6 Nov 2026 09:35:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 562B931F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:35:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 48099403A6
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:35:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VTsRDFvjPxCp for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 09:35:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 31E6A400D5
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=juuso.rinta@nokia.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=riuQJkq2
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 31E6A400D5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJli6vRYJrarQvLP9Xr+PajYXfw1dTHBuGD8JhnsMUM=;
 b=riuQJkq25yIunc4T4d7kH5R7YNiaimI8TbrkdO3E7qAJJz6a7YT8UJKyDH9bh+/xCESAZP8kc5i4+w+WzVM11ELRzfAzqr0Ct6W91cOI1WoLkrMupMz7+rqW0j6TNL8+TtlCK0aDB6rnL1VV+5McB2NtqMLIs2l+nGbFGmQOX+K1icg0vHVqvNOAEPOCZCHn/iCqU2yJn1N6CdRQpIHM0S524sEr3AcfsqvGu4USS35BmStLInWQouT9mFWa4L+5gIPEpe7aHUm50P8Q+fX1+/9QONNmdIVSskFIk32k+rcoKEELnp9s5ci/tHmhVjSYle2QTppvSPaI1i1bjZfFeA==
Received: from PAYP264CA0009.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11e::14)
 by DB9PR07MB10074.eurprd07.prod.outlook.com (2603:10a6:10:4cb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 09:34:57 +0000
Received: from ZR1PEPF0000E6B4.eurprd05.prod.outlook.com
 (2603:10a6:102:11e:cafe::68) by PAYP264CA0009.outlook.office365.com
 (2603:10a6:102:11e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 09:34:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 131.228.2.20) smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 ZR1PEPF0000E6B4.mail.protection.outlook.com (10.167.241.91) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Fri, 6 Nov 2026 09:34:56 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id A484120109;
 Fri,  6 Nov 2026 11:34:55 +0200 (EET)
From: Juuso Rinta <juuso.rinta@nokia.com>
Date: Fri, 06 Nov 2026 11:34:17 +0200
Subject: [PATCH v2 7/9] watchdog: max6370_wdt: add get_timeout operation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-rinta-watchdog-gettimeout-v2-7-07de25b6312a@nokia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793957695; l=1334;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=3bL2QSOdibhwXECr6AFyFaQ9RFrzkrqHQTZVZlcXbtU=;
 b=Lxa1urTsEbWevjzmOvWAsRxFkU0lIP8myz/r14zBViw49VP3EvkCKLH54ONwqDFEwm0/ZmPij
 4JG/h6JMx+DC2EkQ7quWNpZlvAfT+NTV9jORX4Y+/BUiVHH6Q33fpzz
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E6B4:EE_|DB9PR07MB10074:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fba6612-b71f-4e9a-35b5-08df3be9387a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|11063799006|56012099006|261021121427099003|261009223027099003|261102123227099003|261026121527099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: WnFlR759lZfMknZnrO9quPMkwqF4WQyA6+rrBpYfZfc1Up/We9yvhB/f/0XhT6FJx3C5GZq+XVsRyUYqEgtvCoH6D+yOWorZQjU3Hc/V+dCut5RfQktChg2+AhqAz3iJ8dmB7LhOIUukCBVacFtpfLZ0cnT9hdip3NvRnLbbcLYrvdlAc79fsyolmibM76XfwqfjFuDb4hs21Xl31rP4N5TZMGBoitLmjOMeTp9a26fdx2HnDVHW/6+MIFJsSXdmqoWfEAB6c9tak3fLKScfWTVOtxrswl5ICQ1Bf6+UrkPAROcHjL0BV/GYC9DIra2xSfcVYQHjviib9a4gWAYWFp+L5/+yTBkEN+DJ18fpMDK96WAoL1OEsHXQ48iDMxG2aVoEBddb8nOcZvHTaEWH2h4r8YxXX+qXnogDUywUVoE3nFDgo2jeKBKnpCqa8nB1KNDfhAymf1Lqd2OYH6FbbfFrCriSpwsisQc8EEsFdO6F9VWgJGQHXB0Q8PQapw9Lma8O8dR68gOUl4glYLNwYyH+Dek1mLg1Ni+jEc3+E83Ps8x8qG2eyuMWLeYkb1qRa2bRRN46FJOB/r/jJiAPSTTG1g9s/FWGGr8/xW1KjlBP1chtMtM1Y32RZE5ldfpMel+Aa5GSscdPIQukbcwyxNTvaAIgdL6mbfr30zhJ0ZecuQgVJa/1DejQUoEbsFcDFTBz25Le2lDW9tp+K+1k5A==
X-Forefront-Antispam-Report: CIP:131.228.2.20; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fihe3nok0734.emea.nsn-net.net; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261102123227099003)(261026121527099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IWY27VoC2T1rps9v4LbvZsvZohz6j0X/5DN8g05kMYbtcehyeYEXpemx/8Oxmb1iXvivwnaHJmU3Zn0LSn8xi7BIoqrUSbdFlHTBbrZZJcWVrOT7hEwvHkjno3+l6z7pib3ivFBAQZW7qKeyJlkxRNTW9aZSjZzBxU3yAeaIX8mfx1/JXdrTSD6Uqa5z3g3tymeGnF17RIMy1aXrBnwT4puGcPYruHLocf9zicuHxDDmsBlSMPEpXA82NYaCc191unMbliKbOh7ufI+DXhz4bOB5yx4y8j7oZKv1vtJ5pyiK5AqQ5aWXggjbKwqcfrfXH9rC0PbRvNo9GBNEP0rtXbn5je3gRZpSnI+LaroEihZ1Ruruhj73eKCFiVL6MDypWyh5rn7Z34Wz9MLfzb64CEDdFlzpN9oxPiN9U+HWsz98D4GAZ8rjTcf4a8+ghbR8
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 09:34:56.9837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fba6612-b71f-4e9a-35b5-08df3be9387a
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.2.20];
 Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-ZR1PEPF0000E6B4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB10074
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

Implement the get_timeout operation for the max6370_wdt watchdog driver.
This is useful because the device supports a fixed set of periods, so
max6370_wdt_start() rounds the requested value up to the next one.

Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
---
 drivers/watchdog/max6370_wdt.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/watchdog/max6370_wdt.c b/drivers/watchdog/max6370_wdt.c
index fadf4d41e1d..48866a5880f 100644
--- a/drivers/watchdog/max6370_wdt.c
+++ b/drivers/watchdog/max6370_wdt.c
@@ -72,6 +72,19 @@ static int max6370_wdt_stop(struct udevice *dev)
 	return 0;
 }
 
+static int max6370_wdt_get_timeout(struct udevice *dev, u64 *timeout_msp)
+{
+	struct max6370_wdt *wdt = dev_get_priv(dev);
+	u8 val = readb(wdt->reg) & MAX6370_SET_MASK;
+
+	if (val == MAX6370_SET_DISABLE)
+		return -ENODATA;
+
+	*timeout_msp = max6370_timeouts_ms[val];
+
+	return 0;
+}
+
 static int max6370_wdt_reset(struct udevice *dev)
 {
 	struct max6370_wdt *wdt = dev_get_priv(dev);
@@ -108,6 +121,7 @@ static const struct wdt_ops max6370_wdt_ops = {
 	.start = max6370_wdt_start,
 	.stop = max6370_wdt_stop,
 	.reset = max6370_wdt_reset,
+	.get_timeout = max6370_wdt_get_timeout,
 };
 
 static const struct udevice_id max6370_wdt_ids[] = {

-- 
2.39.2

