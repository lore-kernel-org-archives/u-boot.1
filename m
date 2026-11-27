Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEBB606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 13:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IShQ5khM;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=j8SFwKJ9
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E4C6781183;
	Fri, 27 Nov 2026 13:04:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vCDUORfBKoKD; Fri, 27 Nov 2026 13:04:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1E67181155
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795784674;
	b=L9IrX9VWGILOps8xIKqPYR6aDNbKvl6roCH+s7bavidnulJ7GF9ZSU/i7qv+bA4jgIXB
	 JjHK9aTCslamWzlQB7TNS7htgvR+wF198TsMK5cIPcJ3uaWm7Jq2U9SBwFrnohLKlJBQ4
	 b+gwr9e7Vg579/owhoiTBH/Lsm3f/Lam+xM6lORQVc1M5SV7xQowNtSBZPLaEHUgDm1ym
	 e6sXJ2fbu84rM4mxFuuogS+2jfNd8o2+/fivw36rtYV011QlCZnXImvOZIzF06zM1/Tw+
	 FYFFfM05KIKKf6iOsZRXAZvRODoXpnDLrBDanMJf1llErR+8Cr4FOmRttTVpTybbgYw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795784674;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bO1erZXZ+cpQN7ophSpwYqG3IT7+JlhJ9haxtt/e9MA=;
	b=mvfNKMwDwCTkXaalXIFlqt5SrdqjKVZJdL7153a+dyZZpyZC7pVk8+/0hT3mmTJI4uxm
	 eJd3Roy8dwPbg1DbEhK7ijdQUfRNTrXj/Qqyfaqw1afAbrTDSPKDcRxeHvmyt0t4scOCW
	 kk7e3Ew83cmKt7r4fM7ir2j5We4rqD2Oz0OvyjL2YFPSC9Mjaj3rGDPbq3kN67hF5Ul/l
	 QpfibQZOfbZCpJwToHnBa4dkmprGLJMG0nBqJX0hbZ3DksTnqVBoYCYSUqZe1sVdIsAOY
	 xsv9wqxMwhEu/6I5oHeKjawW1d4bq0tg35ih5dxILTxaPrsJzm9mrAPha3duZU/4RXQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795784674;
	bh=bO1erZXZ+cpQN7ophSpwYqG3IT7+JlhJ9haxtt/e9MA=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IShQ5khMaKDGipZTisOTDJCmaIY2Z4w6JzAQCC/0CkLqTFV0EzBQG4FJRIX9rPN40
	 lkssIGVwcvSjNuyy+SaNHTUbK7jkz3L/lc6jgQ2xgQnVd7vc8gwKYjzgJvTn3Ti5m2
	 44Ojja7IHbtYumv9OEDD5+WNGnosbShqw3RxyUL9aewfKAakEgza+Y5WyOFDJXEyA2
	 myXC4FOYv3kbHcpIk6L8QBB2fp23sqhZQNAxWmY+LpLM9YIXy90Cfpka/stTt4t8cq
	 U5hQ3AwuA2eufOGP/k0SJAVA+66/JA/vba/UEgwgef57IoPVz0crmN5jLlp2m/Hcq+
	 tUVPCqSp7vdnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1E67181155;
	Fri, 27 Nov 2026 13:04:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D6F1426D
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:04:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C8866408B0
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:04:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jB8jBhyY02GI for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 13:04:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D7E69406C7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=j8SFwKJ9
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D7E69406C7
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bO1erZXZ+cpQN7ophSpwYqG3IT7+JlhJ9haxtt/e9MA=;
 b=j8SFwKJ9IFLbBdjec3k6u0BOfzxWr8PkbED2mzHAhlqBNGXg1ACCM9w84AuumqNIbTLYMncCXk2krobVQWsTi0Tlssd2d6VHj46aoLHzQOjdilee8gZXxnynwie+4sqouYbmrwlmeRtAHrygt32xvHd5JsMDhbbZz07/O2VOjNaM2c/FPUBJXcAHTG+o2gS4iZ+x6MsJx8xBitwp/RtvysIX6dZIYrtgPDtWNz9VEdMFsOwJBDEdykduORXOt1p8f/lTJZfWXxGouPnc2JMmRcudTgOWv6qaBr2Qtxr3Qa0SPyo70KKoLNcK2sHT0ubmmgdg/A24h2S8V3bWfceCJA==
Received: from DU7P190CA0011.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:550::28)
 by VI1PR10MB3341.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:13b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.4; Fri, 27 Nov
 2026 13:04:22 +0000
Received: from DB1PEPF000509F3.eurprd02.prod.outlook.com
 (2603:10a6:10:550:cafe::2) by DU7P190CA0011.outlook.office365.com
 (2603:10a6:10:550::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 13:04:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF000509F3.mail.protection.outlook.com (10.167.242.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 13:04:22 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 14:05:28 +0100
Received: from localhost (10.252.12.59) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 14:04:21 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Fri, 27 Nov 2026 14:04:19 +0100
Subject: [PATCH 6/8] rng: stm32: add STM32MP21 support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20261127-upstream_stm32_rng-v1-6-b8b4a9fdc8a8@foss.st.com>
References: <20261127-upstream_stm32_rng-v1-0-b8b4a9fdc8a8@foss.st.com>
In-Reply-To: <20261127-upstream_stm32_rng-v1-0-b8b4a9fdc8a8@foss.st.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.u-boot-project.org>
CC: Sughosh Ganu <sughosh.ganu@arm.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>,
 =?utf-8?q?Maxime_M=C3=A9r=C3=A9?= <maxime.mere@foss.st.com>, "Gatien
 Chevallier" <gatien.chevallier@foss.st.com>, Nicolas Le Bayon
 <nicolas.le.bayon@foss.st.com>, Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F3:EE_|VI1PR10MB3341:EE_
X-MS-Office365-Filtering-Correlation-Id: c8a2543f-db57-44c4-f711-08df4c86f4cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|82310400026|376014|10067099003|56012099006|261021121427099003|261102123227099003|261021135927099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: LkZgW7tqIDuy4WUx67xV2Gr1ztS/WlzFv7/yLumJjRASf3wwINdeIkBKuMJr/hZjq88b/78vt16fjxXbSyXLV+iMwzM40YUKpitKTrSTec30hZYd7RYb8XKqdILMph0Qp3er2wmD2VLtcazNKZbCKCmVie2D3Hu8MniKIur7uh+vZThjLQKQ9RvLZ2Ghp/aULKWkjnLZV3TYhZhJ4vs6gWetV18DRo4quk11HEEi1wY8wTg87SmcDg/SPplg4YmjBDYX8poUXVt0TGd/8M8qsi/LDNASAv+nibxj4MA9ti7dhSMwXflLjNXVqNlGBsW0RcVBI5AE6Z3v7eQMcq/GSgL70We1W3nwkbzafrdndvxbhiQnpK04rV/JqcwKBiM6lZpsjE5n9+M1dFMjUMriDjtMRsuaXiYeeZdY2Z1PPPn3+FUzK5YPjy6W3cZs5gMNreRhGIrEIFB0pRf7khGOy/n8fkkOl+NQYyDW8euYPMFmSk+Q0VIHTs08dfpt3GFSTStCGLUoRQugKTDGIfa+IEQe7LqPG16EZ+pI/c8Zqm7yIcktuLlRbyPqtNbMAEjiD04smj2upEk7+O48JGOOsQnHxFPX90EgYOa7bP8rUqDlRAFm0v7J6+kr81mYmlMFSt6y4JfRs5eH9oVbCcX4Wra6eZmOwtLKLekWTm3400fiVNeLeE+1kxg4VX8qdAVCTaRrCV0TEdPIQhjtJZdLEg==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(376014)(10067099003)(56012099006)(261021121427099003)(261102123227099003)(261021135927099003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XHk2Yiwo2gVwmd0xmjwQsJcrQvFMRLbwR73ZxbVdNRxLW6i/J2AaSYGUIFKtaWBLA2fnb2RpuWf5uuyaYD7YisBP5MOx1eOSu2iRWFQQrRciweyLkXT8hvFsoXVa7EQNDW++tLBNUi3u6DK+Ypfez5WktiJ2AXDTUHDCVWiRlkOICa/n7r+Ja83C7Rg+K4gU7hsqKk+7DyKlYAIzMtjUC9eLFbPGuCBn3Y+GFC/y8GX7oeiL00BbKFF9iVowL3WRZM8kKEPf3754VstLx02HCWo6MF9ddPIqSRhzjbwGulBAzZ4+9OBQPydKZrwjk/LXs0drkkUwE1RGaQziuQG0y8deOunxLN5IQIoJa+16+2xj/RfjXuALE6/NHGuiBFrQERuKRRp8ZwR4fvfYGNFTXYTbJ4goiAB8urUu6k5dRuWTQkqPkmdjEdsTgwUwSYcc
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 13:04:22.5049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a2543f-db57-44c4-f711-08df4c86f4cb
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3341
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Nicolas Le Bayon <nicolas.le.bayon@foss.st.com>

MP21 needs specific NSCR, HTCR and CR values to work properly.
Set STM32MP21 clock speed to 8000000 Mhz to improve stability.

Signed-off-by: Nicolas Le Bayon <nicolas.le.bayon@foss.st.com>
Signed-off-by: Maxime Méré <maxime.mere@foss.st.com>
---
 drivers/rng/stm32_rng.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/rng/stm32_rng.c b/drivers/rng/stm32_rng.c
index d96485a64fb..e3ef98e8d5d 100644
--- a/drivers/rng/stm32_rng.c
+++ b/drivers/rng/stm32_rng.c
@@ -409,6 +409,15 @@ static const struct stm32_rng_data stm32mp25_rng_data = {
 	.cr = 0xF00D00,
 };
 
+static const struct stm32_rng_data stm32mp21_rng_data = {
+	.has_cond_reset = true,
+	.max_clock_rate = 8000000,
+	.nb_clock = 2,
+	.htcr = 0xAAC7,
+	.nscr = 0x01FF,
+	.cr = 0x00800D00,
+};
+
 static const struct stm32_rng_data stm32mp13_rng_data = {
 	.has_cond_reset = true,
 	.max_clock_rate = 48000000,
@@ -426,6 +435,7 @@ static const struct stm32_rng_data stm32_rng_data = {
 
 static const struct udevice_id stm32_rng_match[] = {
 	{.compatible = "st,stm32mp25-rng", .data = (ulong)&stm32mp25_rng_data},
+	{.compatible = "st,stm32mp21-rng", .data = (ulong)&stm32mp21_rng_data},
 	{.compatible = "st,stm32mp13-rng", .data = (ulong)&stm32mp13_rng_data},
 	{.compatible = "st,stm32-rng", .data = (ulong)&stm32_rng_data},
 	{},

-- 
2.43.0

