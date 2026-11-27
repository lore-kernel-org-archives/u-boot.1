Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0C6606A331
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qaNo1YGp;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=abNYx3MP
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9CD948122C;
	Fri, 27 Nov 2026 15:17:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BYQO_hNArz17; Fri, 27 Nov 2026 15:17:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 79FE68127D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795792642;
	b=rbZzM/+zKodNXYsy3plQx5HE6rrDyMyuaWoRf2LyWcalbfYwp9kUNtEMbARuaXIzjw2w
	 DkuVlRXm2oztARXGim//fHsUAiqy2lNtz3LziJQVmrOttm9n3nD3FSp1AO5XUh7JUx/us
	 cIZAfLBQekaot/BruqtV5uDg8rsSXJ5/CcuJxxuS7R7jboN1Te0zOQ5vnkzfjVs1fHhKO
	 GQsV77x5gFSsnJm5rM7cvh/OZpRW9onkvoYVFvBvYOeMZAU9VIPT4aqDvJTEuefLJARII
	 Am1DU0jVTRc2IQdIcyRTKBmCyke8WoWOJHILiS7auwd3ChY2+XJbDhTgwK7yRITGroA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795792642;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Content-Language:
	 From:Subject:To:CC:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
	 X-Virus-Status:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=fSkrDsVKYcoas6PKa/3lpcbqPp6I9jCgWMjeOxHdoWw=;
	b=VGMe3RDzPYWsFH4CLrOrsKeDWMARx6qjMAIHCq/zcDQIaZA8pPbvUndTdH0M6M6kzmP0
	 NDZcB+6SFDqjd46rQjedmUrTrhnpm4SFm3k7pnvNRhetQXwm1ZhiOTjV8648ZimtnJAYK
	 kX4tLgQest2lglz4XIyY1+zdpmlm2Um6tWCo2b6DAV2hBlhsVSwZ2At8uhZSjiwDsaVGc
	 7OjkuwNAiqP9Xis8YSw2/WnZ+eJsyNp63l6k3sULZsIiULnyQZpVbPIk14S+106rgjmAn
	 7FUF84LrxF1Qy9CM4s5EfZGtE+g6QIjmWQ+sWtJaw5Qn/7RDb7D1L3f/Vz6htTcltQg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795792642;
	bh=fSkrDsVKYcoas6PKa/3lpcbqPp6I9jCgWMjeOxHdoWw=;
	h=Date:From:Subject:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qaNo1YGp3xxNHEx52OQ/Y1BdkDToCRBXJNSDvejHzdSTZfF2GoENB9HHJKQe0ZheK
	 ky2SjpI66z4cl32HHoamS6AryN3348o/aiWThK110Fqls1GA+cxycAH+pcpdix9qpZ
	 q+LE5W1EwHI8DM2FAHiLpE+MAszkfWnlzOdIFr4X1bCV5n1UJ5Ox0nSEQfyiKb8MoC
	 +g2xkCN/aY24wUamSgmeXJaLRZarm4xDx+6b9+W5sOqpm7zvrQGhNqbvwktWgbt3Ho
	 RnpgCsj/w81FuFk1ERFrkWN4Btwvf1mXoqgvYDnXAo7U/T8ZGOIq+W3MCri1RKm2j4
	 doZ5dOfK0Q+4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79FE68127D;
	Fri, 27 Nov 2026 15:17:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C30352BD
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 15:17:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A98D9400D2
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 15:17:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f--R9moN0Spw for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 15:17:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A8EA840012
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=patrice.chotard@foss.st.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=abNYx3MP
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A8EA840012
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 15:17:19 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05456847DF; Fri, 27 Nov 2026 16:17:16 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B129183108
 for <u-boot@lists.denx.de>; Fri, 27 Nov 2026 16:17:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSkrDsVKYcoas6PKa/3lpcbqPp6I9jCgWMjeOxHdoWw=;
 b=abNYx3MPEFjR0b8NfONjHmwdHvCUke4SIHyOxvs+MS/nUZmh5R0VEQNfTf3u7fswqTsLZHhT/GQJRF/OV2qUd0YdT9Oe0FRVdWRE/YetKfwSpMiG5TIK8a7UG17pv6B1Nko4JPAqTZERMebkIlG+7RPOXs3137/VQBolI+j9XKZqNKWm49AD0+zg14HxOpIq0vTlxbzAnifJSchMiulySZE26Zg+YIRpt/FR/q3SwPbquriL9xlX1+SbS4aD44Nvclzudk1bDZNVTAAeyA+dpwr4hsA6/yLxEkT8YlvERMRcartTs9Afy6zXgFEYeElnhN9opk+AC84eNXoIh8h3rw==
Received: from MI2PEPF00000B7B.ITAP293.PROD.OUTLOOK.COM (2603:10a6:298:1::411)
 by DU4PR10MB9617.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:63d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Fri, 27 Nov
 2026 15:17:05 +0000
Received: from MI3PEPF0000848F.eurprd03.prod.outlook.com (2603:10a6:298:1::56)
 by MI2PEPF00000B7B.outlook.office365.com (2603:10a6:298:1::411) with
 Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id
 15.21.662.10 via Frontend Transport; Fri, 27 Nov 2026 15:17:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MI3PEPF0000848F.mail.protection.outlook.com (10.167.240.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Fri, 27 Nov 2026 15:17:05 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 16:18:11 +0100
Received: from [10.252.12.59] (10.252.12.59) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 16:17:04 +0100
Message-ID: <34f9f758-4fa2-4469-8fea-a6cb5c75ade7@foss.st.com>
Date: Fri, 27 Nov 2026 16:17:03 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
Subject: [PULL] Pull request for u-boot main / v2027.01 = u-boot-stm32-20261127
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Gabriel FERNANDEZ
 <gabriel.fernandez@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Thomas Perrot <thomas.perrot@bootlin.com>,
 Petar Krstov <petar.krstov@kontron.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF0000848F:EE_|DU4PR10MB9617:EE_
X-MS-Office365-Filtering-Correlation-Id: 529cc264-2328-496e-469b-08df4c997eeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|261009223027099003|10067099003|56012099006|261028144727099003|261021121427099003|11063799006|261022075727099003|261026140227099003|261102123227099003|261022105027099003|261021123027099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: klWJPyNz978WcrRoFTUwnAk5yDTd9eX/2qdwh6antIV0QWZVPkCJ5XwdPryva2Z+FFSNSADCm7rwRdAkofARcDxlzZS4FiLjiUEDOYmnFPsFWSaqPrXNXlG8HAWci411oD8AphWhQXciS5RYeffnzIQiIsn7dTbc2nLwNxFdJMfh4O3CAsNLx+kdG78GpBhBZJijduFk2s7d5Rsru6PIqHrKidBUXo2lkd7smwO+UFGCelsTkYmkpCelATwLiiJrOZl0cmm5YG7SSrDgGdF9TgCAt1kdsjPCtP1/jCCmBfa2VPR03EUD8NLSqP3WMcd6GjX0r7/WRwe2VFpn9niFxo8XllJx+jLmoY8kixnscHnA4QYp8Tt1Ycl8VKrIQNemKmW5RsC3zl4Re5x88xSJF7DCrSSlARoEIwR9ipMTh73Tdh6VPLOvoBPUSkOmnHAbaJsXkUYOsAl86hIJ9ZIUOuisIoXb8TPYreKfRGsFxAx036Q1C3E5bhaIbBAc3jXOiH6oh3luNdYMb/2W4RUphWF+sb3v1AmB1IPhhqShTQ5OLroLJByJrCe28bD5kj51FKxHcXDf23J73yc08WFS0O30kyknFuVDWzjJCnFGLP/g2c+1ufm/epaPtVyj6jhi4rs0Jq6mXtgNSFjGuHQ2Fw==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(261009223027099003)(10067099003)(56012099006)(261028144727099003)(261021121427099003)(11063799006)(261022075727099003)(261026140227099003)(261102123227099003)(261022105027099003)(261021123027099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gHvOvnwxPLziSV7U5q6368+RTWemw5A9NagWg9Gq8Y8f2fxTAdggnySX2MXSsDnUTTy7kbK/4+bdrtQNJptd8WFYCxJJAE7edpieg1TfX2vbRzT7M31C0yQps8reLJfdN0NzrNmLHEeSY7CvKOFT5cbQYt2C2VmXXcc4ClmL6oBtSmwX67ZLuNPGfmQPkntveINLMIDPzYh4Uqrnmhh/oX+2E2tezl9/hTKXl57R7aaNzt5pNyMQqGPc1NOGC8w0X3XOJF5pHr+L+H7xbyDJscUZj8sTb38FDZOGu56HMBnxPeYjAjzgLGbFeS0CXArYLtO0mCYqCTxg88YXi1OHmkHApmdytDerQzO8Rc6KkazgBiKm/RvIc8ApzBRmBfrfy9Qg+JlPMwpe36g11d6pX0qlQ7wBIEPM7OizOck0BRGJTZVF9hXXCgxdtFBGs7WH
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 15:17:05.2329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 529cc264-2328-496e-469b-08df4c997eeb
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF0000848F.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9617
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom

Please pull the STM32 related fixes for u-boot/main, v2027.01: u-boot-stm32-20261127

CI status: https://git.u-boot-project.org/u-boot/custodians/u-boot-stm/-/pipelines/2184

Thanks

The following changes since commit ee1b3477e3af6af1ae9b8f98bc84d2cc6f32a3a6:

  Prepare v2027.01-rc3 (2026-11-23 16:10:46 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-stm.git tags/u-boot-stm32-20261127

for you to fetch changes up to a89f7d98f2f4723da0b90a007d280b89d36d0754:

  video: stm32: ltdc: stop looking for the panel once found (2026-11-27 14:38:47 +0100)

----------------------------------------------------------------
STM32 drivers various fixes:
- pwm: fix division by zero
- i2c: fix zero-length transfer used during probe
- stm32mp2: fix off by one test in mmc_get_boot()
- lvds: fix NULL pointer dereference on missing data-mapping
- clk: fix set_rate propagation for parent clocks
- spi: ignore the cs-gpios polarity flags
- dts: Fix qspi nodes for stm32mp157c-ev1-scmi-u-boot
- ltdc: fall back to a panel when no bridge is connected
- ltdc: stop looking for the panel once found

----------------------------------------------------------------
Dario Binacchi (5):
      arm: stm32mp: stm32mp2: fix off by one in mmc_get_boot()
      video: stm32: lvds: fix NULL pointer dereference on missing data-mapping
      spi: stm32: ignore the cs-gpios polarity flags
      video: stm32: ltdc: fall back to a panel when no bridge is connected
      video: stm32: ltdc: stop looking for the panel once found

Gabriel Fernandez (1):
      clk: stm32: fix set_rate propagation for parent clocks

Patrice Chotard (1):
      ARM: dts: stm32mp: Fix qspi nodes for stm32mp157c-ev1-scmi-u-boot

Petar Krstov (1):
      i2c: stm32f7: Fix zero-length transfers used by i2c probe

Thomas Perrot (1):
      pwm: stm32: Fix division by zero for 32-bit timers

 arch/arm/dts/stm32mp157c-ev1-scmi-u-boot.dtsi | 16 ++++++++++++----
 board/st/stm32mp2/stm32mp2.c                  |  2 +-
 drivers/clk/stm32/clk-stm32-core.c            | 11 +++++------
 drivers/i2c/stm32f7_i2c.c                     | 17 ++++++++++++++++-
 drivers/pwm/pwm-stm32.c                       | 11 +++++------
 drivers/spi/stm32_spi.c                       |  9 +++++++--
 drivers/video/stm32/stm32_ltdc.c              | 19 +++++++++++++------
 drivers/video/stm32/stm32_lvds.c              |  4 +---
 8 files changed, 60 insertions(+), 29 deletions(-)
