Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA40606A31E
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 13:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sKoz3yBI;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=n5WMIiJc
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 28C2A40A5D;
	Fri, 27 Nov 2026 13:04:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MHeIARREJHQl; Fri, 27 Nov 2026 13:04:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 693D8409CB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795784678;
	b=MLuMd85/pXY4Ag+dW1xN3tN6i5owzG0+U+Q4lHgc7xvL2S+YIZAjV5MquqzXopIiEAAQ
	 QWF9tCODPZUZJ9Y1/kXWedL5QGxAuzekPK8bIFzArR+rBGCzS+ri6KfB13RiB0j8D7OLj
	 COD99xcEMDTU9Ll0Zt9jVgStEpFcJHDMGw5QEgT6MM0n42RzvgYoxw2bTOLzOfCIPGTFo
	 bO6U5ldxsZiu0ahChkqs45HbOpHkGX9l2HIfIFbNS+KxNhw9Ikf2FNUGzXQcqrDB9Yl3e
	 UXISY8T27H5dEw6JCSB0v6MvW6FBBOw6oU7/ft4aOiqS8Lzx5K2c3UojiQ3Q217sOxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795784678;
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
	bh=S8akdd4UTZrj7EDL5Hz3AWBJHnbCHw4WE8dOmfedR8A=;
	b=lKZWW8YcA6R7HVazaoMGHikuId4y51KYEUnkA8+0k3B+PhDTwlYiDUYg6fiNA/EgO4/+
	 UW6r84tgRxtZfVSrnoTby61PmVbLKPSA7BGek7BtKGH+O2eVneqb67wlAWdhPuIwRmlWZ
	 676zJLU3fTCVEz17uOlB5d2edTdROfMlWhCDi4dizB1DhviR19vdQiiJOiSSWW508VSXD
	 jqNbE4Zda0PbHxqFg8rF4bQ3FiWj/y9KWEUz7/bYFgGBK3j0mh9nLSjmdZFNY8eA9kOTd
	 o3Bb0rNYQR6eRIXDEfWfzza7eJQ7J81yO2u8PEHQVv9BUYd+8hY8ySQEujCZXgEYsOg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795784678;
	bh=S8akdd4UTZrj7EDL5Hz3AWBJHnbCHw4WE8dOmfedR8A=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sKoz3yBIokL+G/nrV7iSAOM+4NNmsXVvLcT8duq8XONHRp8QiLptsrWP4BpZ+OHKq
	 cKATIlUJIK2Kx0N1QTD6fnU914Aoo/UVS0FtVymqOA+oYtaDBWsjnENvyS3oTTkt0G
	 7gz76HISgaW/WaVHivHUR5Uer1otdOxug6+St30io7VWtYmlf7NAMgW7ZSzZMc8v+y
	 yzrgZ+SlLb8/FOHqHQgnjY10AOIY8IHnjXloGTgf0GRM/2/D2HR5G/RYvbNojuhGYM
	 oh4w9U+8fS9BnHfR1qi8L4LG/jVbHoNiQ753SnTIOmo6T2B+PTRnVVLSXQNxX9G/CB
	 ooFt86yxAwhwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 693D8409CB;
	Fri, 27 Nov 2026 13:04:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 825BC26D
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:04:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6727C60A54
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:04:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yR-PlA5RHEiU for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 13:04:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8D42560AE4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=n5WMIiJc
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8D42560AE4
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8akdd4UTZrj7EDL5Hz3AWBJHnbCHw4WE8dOmfedR8A=;
 b=n5WMIiJcAzUa1zzPq/KqVpv30mjJJq7yNattc9/mn9ZUE470LFzs3fsyI0VRX06BoLfqCUFy2OWZbhLD8i9QFdRNZV2gTF60bEqULmJUHdZ2Bpm9N0Ry4U+lXFmWXun+RzcMiczm4wl0nPYSthtQbeKm7Za4KZH4UlZHb/J/A3pocDKuSnNePg3wZt/2PNHNY8OqJMPaPRu07GuJYhlCIQvOPZwSNA06Ku1oBiFLhDyO/qo5PsX0Z0xkFYPkt4embMOYXzojwvt2YLwo0/aMmmlnmL6d4S21ZRJbp/BRM7LwoFX1li7Y/2aI63WsASLUHifMQxZ5alnGl/1V/l2Mcw==
Received: from DU7P190CA0030.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:550::7) by
 GVXPR10MB8631.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1dc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.5; Fri, 27 Nov
 2026 13:04:21 +0000
Received: from DB1PEPF000509F3.eurprd02.prod.outlook.com
 (2603:10a6:10:550:cafe::71) by DU7P190CA0030.outlook.office365.com
 (2603:10a6:10:550::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.9 via Frontend Transport; Fri, 27
 Nov 2026 13:04:20 +0000
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
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 13:04:20 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 14:05:26 +0100
Received: from localhost (10.252.12.59) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 14:04:19 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Fri, 27 Nov 2026 14:04:17 +0100
Subject: [PATCH 4/8] configs: stm32mp23: activate CONFIG_RNG_STM32
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261127-upstream_stm32_rng-v1-4-b8b4a9fdc8a8@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F3:EE_|GVXPR10MB8631:EE_
X-MS-Office365-Filtering-Correlation-Id: 100fe5b4-2230-4c02-e5b1-08df4c86f3ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|23010399003|1800799024|11063799006|261009223027099003|22082099003|18002099003|10067099003|56012099006|261102123227099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: 44TfTGYI/kkjN1ndmOvQkW7FuObikJ0KLOIM/7IQ79GudxaO4FSmYovWrEUkLDFZtUsSje1nZu0JpfCcnp61ISoTD7svrsPuZVJJ67bpLm8vQXV8c6BPos+KLR22UoFx31pN5eIVNX3B/k/Q+t/7aZ9mRaTNhjn3rrc+/k51GIO2RGHsaerbPrwhHv4Cmr//6WtkMc0Uk5O0Mud65cIkxgzvyJKZsmbCbriNwTwSJT+C0EroyOyKe3YApy7D+NL7PJiAh62Za/C6wxuj9DertHV9BKw0dP04iTk4gWKAmTazbBQzcYG5LoD2uMZO/qtY48MsB3AkwWk3Iz7pd59QnMUFKEAWNnrgM/IvKyNF9K+grB+NmjpylIc6RtZiCIEMKrSg+wCA2cI08yhGfPXXNJDTubQo1KS4hh0SYqt/xfChjFjGZOeRPcGjmVdxQqzGMAn8cd8Crmq3TmxspJuTSKcnnNR1y58Oq9hEMqPxMumECQOjO2CtjcfUL/hRNo/peXaCluW9XyYgIb3SHzGd7qNIIlyhqF4gqcnAW+zZv8tjBYG/W6ajdvbiSwHi9ifqaxteUEbEbMF6kQrppXvtSbQ5F10GURxQPUo2wodchWpxGwGq+hnmW2xFKfUmmznpPBFC3SSVHDlMAFYERRKTT4LnqkdoEsp74uXlF1Qt4/2dBvYjKh2Ram+efHV5niGWlXSiCARRv4h/FSr5kcTcMg==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(1800799024)(11063799006)(261009223027099003)(22082099003)(18002099003)(10067099003)(56012099006)(261102123227099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: a0VIBAa1NOArRrJ+fU5hEcHsOnasxuXOpAMuRfOvvhT3I0jEP9klrZAQzf/xM8GYZVC4rDXmIJC0mn7OkZiq1QYyi3HqG1f/cDEctYEAV3X4UZJToo0lAfi0apIx/e7pw+FINlzSjccDepElzpYkn5P+rxKZFmVPNwmqikHQpmoUAYEoZ1ALNzG0glLgShcBq46uycXCFBcy1Hg01aVCU/AywSUQr3VshcFOAm8/vBJj9uSB0GYWHjhTL8VkMVkOADMWdQ8wNHFdfV9c8Ifl+lnohWckJwYyE4MIdraGVPq5cmVeqL8gIIEvGQJ4pNgwwRwRvI76eaLSolt3Itov0BBefAY+RwJHx0c1yc0+gqecSUz4QArA/a132cgTUI9NM6xVsofuS9poSfQkWd7D7k/1WGX/5WcvaemH8Hgt90ZHszgB/C2elrhCu3QHgAHo
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 13:04:20.6359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 100fe5b4-2230-4c02-e5b1-08df4c86f3ad
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8631
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

Activate the support of RNG on STM32MP23 platforms.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 configs/stm32mp23_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/stm32mp23_defconfig b/configs/stm32mp23_defconfig
index 04aaa0f6b26..a7818cfcd8e 100644
--- a/configs/stm32mp23_defconfig
+++ b/configs/stm32mp23_defconfig
@@ -89,6 +89,7 @@ CONFIG_PWM_STM32=y
 CONFIG_RAM=y
 # CONFIG_STM32MP1_DDR is not set
 CONFIG_DM_RNG=y
+CONFIG_RNG_STM32=y
 CONFIG_SERIAL_RX_BUFFER=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y

-- 
2.43.0

