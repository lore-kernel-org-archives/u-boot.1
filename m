Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E299606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 08:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bYRb5QyJ;
	dkim=pass (2048-bit key, unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=DFp/dPre
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E997E81080;
	Wed, 21 Oct 2026 08:08:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c1-jcr-aBkfn; Wed, 21 Oct 2026 08:08:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 17F038102D
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792570099;
	b=k6g9WFUmVDT4czj9cZKVrbXAWeM4AzpD0MhFY+fW5xxeebusoxwXI+AQyoSuR1Y/mMS0
	 uDyLjOK6XAc3Bpn9NY/kWi/PMaYqqnuNMmYaFhtT5xzrJKHKDGhCpWkmaVKUvYlC1qxt9
	 xDGJDoZbDr1AUVKXsmtMSawUQjVcy9XdkvVTh/IvWbEgtN440C/MEw5o/+CtNll0DDPc5
	 5u53O8LqS0rkaCzLCO/g4vhp/yDslm+LYSWZuiDFuxYbAbttpbHJU8DAWT5zHdPeySO2l
	 LY6/HlRw0LCsV1sr/qflCOMPV3j5kOvJ4EzhPfEivTX0j90p8ZiGO1V1Te1vWSwBvEQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792570099;
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
	bh=48gZj02KQK4iYggx0XCOx8yR1+7mdDC+2mjiV9gpogY=;
	b=p/Ln07oe7j3W4X/RYo1gp5+Ks1FRj4xlw5zyVnPzuaLGpsJ4JkEJVQAOXR8ChR+2UrUW
	 kTY5r1h8VgEdadbw5NB6kolAuT9fWZIAH0XU5NO3wngsrEN1MprQN17ayhi7BevU31yJx
	 sv4NYk6H3JIQbYb/ovUUEFZSU5rDckRlr52+r30aOvSYZsiorBUhXExkK4VMs2Ukge8eI
	 9PX4un4h22EH0EndnGzyLMegFSimx1iPV4Bdez4zJge+/cWoVNOzf9Tu0GwRtEQB2Rfid
	 iVhbfD4rlqloHtgzTzXfGMzWGUv//6GKdCf3hnyH37WUG4jErED8dCU2wKoHst2uJ5w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792570099;
	bh=48gZj02KQK4iYggx0XCOx8yR1+7mdDC+2mjiV9gpogY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bYRb5QyJLOkXUSJAcfrX4uT3jU8DiRy+Dc2zjgJ33lBdUduM289SDOnKq3lGOliGv
	 qbHK3bLa4tDAsWO2JxndF2A/aJvCcUqrRbr6H9sYg4owcC58ab8e8SXI4X4AkFDZA2
	 wHyB9dHEPWNGKG1/MW3bQpx7YPIUIZrPy8O0FSx9K+kpFRKtE/ef0X7sk0FweC6+kU
	 bmfbCfcBj7MRzPfCSZu75kjpl3QGyIY//zmJx9feXAeYHqJV5dtU4lUMhS+z3Bub11
	 OoKu4Pon9xqUeW9briHom/+WdIABU69uavORYlwUN4ooddfS0bD/Z4cNHa5HYG/B5U
	 qzJX0OGc5qvmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 17F038102D;
	Wed, 21 Oct 2026 08:08:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DE9963AF
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 08:08:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C40E540728
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 08:08:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TOXFykbZzDhD for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 08:08:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 37E1A40568
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792570097;
 b=kFMfRsQlULJHS/1bGxX6rEbhWQvm7nQbGuiV7G6VapWgx/H9neCJs86WpL4YmlEIOyGo
 lZuPRstkXe/utMe0NAhQUdGsIZmcbCM/ATO6eViBR8L+LBr7th8Qita4i1yXqOLyJWNcx
 0yihTmQl9A2/9faMASKQby1wILR1UikJ701AmcMaqxLPeMw0tYnABeQxj0hthxO64CnGP
 ijg6syK5Ep4LF5+3cVxAWw1IXhalvIATpkV7mXBDcr2bMVRofcpPBSLESQt0Y6NG6s7Fs
 Zl2q8IYZjHNBLo84pMlthnCA/pSVS/vsr5v+aI7mcrs2cPXxuY7GDM4CzoNLnHfLDDA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792570097;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-EOPAttributedMessage:
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
 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=48gZj02KQK4iYggx0XCOx8yR1+7mdDC+2mjiV9gpogY=;
 b=WfoOuMqQq8pwa4HJWFvV1YBhkJdbYX/GDgjdigo0/PwuocM9wulmpINpaLLUyglZyu2k
 S51GvR7cv3jxVyX2VA35wTR90s/2njcNCsh6e37XXOpN4Xo72WZCjcU8YkyDcmusogZNl
 8lU6FTIoMw9EWcKqCKW+BbEP6AJVGLUiRos23vCpRxLD3UAtn+mQz7O/PQ3wkCs5lm0GE
 rpVSOBNUEVKv7clRtFFXidahGyOcYvbsrvkQGYG+tChQVM6t92ROGRxtVLX0H+dRS1lbm
 L/Sf42c933wIr14GGnI24BkKz7R9LpPhnZzspolBu+NvKlyuHvypF9OIMRrzhza2DkQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=nokia.com;
 dkim=pass header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b="DFp/dPre"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=juuso.rinta@nokia.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=DFp/dPre
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 37E1A40568
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 08:08:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGm85vnmO7OVDSHvY7KYBOJgppmDwUfEcWSOHO9Npoq7usef3kAB6z/GqP+WbIL8KGbl9IQvPFkHcqQVadH9kAnZH+lK2OSS6wQ+JG8gdMquBQDfPSh/tdwEnduOB/2oiZsJglw6DkepYLG3NYH4oh8847IZnUZ4RgDOCnjGP0cUdSKTb0vdNiDtAP3rLJ5lz2n2tKOdBEEm0bgQy9MWDvCpFuDvw25vyp92SWQzMqp109DnhY2z9HdJnbASSZ++hSk8OAYFVWtDH51KpjH4sRiKMgaWVtlBnhCrR5NdRv7fGAnEvsiHSlLtGanVmxIJA9KEst89eqDEl2uIrzKc8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48gZj02KQK4iYggx0XCOx8yR1+7mdDC+2mjiV9gpogY=;
 b=dtMqJKHaDOw24s72tT4pzmpUFYbKBijZnXR9ioTGCmJCMZNDBcfwsnNG2vcjurQU7169YWG3syQve8UaYW0MrFDlCaDjllFmbXw86v7UnDtpGCEaH/OvBjU9MBHhLHGmZp4sw2weHI7JU3d47jsWFPnRQfJkYVbxDqjlWZZI8viagnrbCcQrNt/yOJY99SCbQXyz2b2j0Ar/C0Cyi7sh+ChSHc+vs2np0XT8FBdFbTduwCTk9SI5bbR8U+GQ3Zm748CCpPXLqOQIHmwJ+CFgbpbMtLvK201ZupgluH7pPBknVI0Pdp0aj6/rEsiDnVal8ZumS8Lw3booIP6itbmX+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=chromium.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48gZj02KQK4iYggx0XCOx8yR1+7mdDC+2mjiV9gpogY=;
 b=DFp/dPre1pEnHe8gA7lOd1vqcrLux03VhaSAWdsd7kFmZjE309i5lNQkUjhGR1UPs9XdtFyK6n31XsPtkjK9u3O11dyDnZteMibAtmqN/R5l0UZD+bDIAIlCp5WznauW0RJKfHPnHJ/K575WIRFV17TXM4TnK845lah+RLoSgVsXP2/QzYDLiRVg5CXSdcYvGpsTQZN1FD7UH0TE3jLqoNRI6YKYWVteCepILoZy52yu1r6kZ0GaSqXy94YZ2PwUcCrqq55l90peJHl9S4GCoPbDNoNe6rPCCA/qq2S76olFpttEA64lDQCgmoIhaJCjisq9YOV40slSoTU6rXYA9g==
Received: from DU7P190CA0017.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:550::24)
 by DU4PR07MB10206.eurprd07.prod.outlook.com (2603:10a6:10:585::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Wed, 21 Oct
 2026 08:08:11 +0000
Received: from DU2PEPF00028CFC.eurprd03.prod.outlook.com
 (2603:10a6:10:550:cafe::5d) by DU7P190CA0017.outlook.office365.com
 (2603:10a6:10:550::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 08:08:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 131.228.2.20) smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 DU2PEPF00028CFC.mail.protection.outlook.com (10.167.242.180) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Wed, 21 Oct 2026 08:08:10 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 4EB0D200D7;
 Wed, 21 Oct 2026 11:08:10 +0300 (EEST)
From: Juuso Rinta <juuso.rinta@nokia.com>
Date: Wed, 21 Oct 2026 11:08:13 +0300
Subject: [PATCH 5/7] watchdog: max6370_wdt: add get_timeout operation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-rinta-watchdog-gettimeout-v1-5-e7f3157b8bab@nokia.com>
References: <20261021-rinta-watchdog-gettimeout-v1-0-e7f3157b8bab@nokia.com>
In-Reply-To: <20261021-rinta-watchdog-gettimeout-v1-0-e7f3157b8bab@nokia.com>
To: u-boot@lists.u-boot-project.org
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Yuri Zaporozhets <yuriz@vodafonemail.de>, 
 Jonathan GUILLOT <jonathan@joggee.fr>, Jonas Karlman <jonas@kwiboo.se>, 
 Simon Glass <sjg@chromium.org>, Juuso Rinta <juuso.rinta@nokia.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792570090; l=1665;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=7ULxCEB09O7IL3aNI7ii2XE6KSJJK2foNgVNHPWLV2E=;
 b=EXLPhbAYokcaMkLOI+mhnnYEbYjEHygrbsbVo3Hp9+pWpOJBy+W5iPJo0pMETX9V6qH8PR5sb
 95sxSpcNBprCGG7d2/K/YuiDPDbiQ/RZP/piLBSanPd9aVEW9gFOEcA
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFC:EE_|DU4PR07MB10206:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d7db04-f029-4b19-29cf-08df2f4a72c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jL8Yt7vC+QbB5x0sRShYqaM4xlWpwQbdq5ODwfLkQ2vCDn7CNCBfFUmIlYVhjpm1gNmVVqazwPVnOsWVC1muHKOqjffcGLL/tWkzwXmoN1kjr5bUTTtRLVvR8YX6XWzIPH3nrXFr40U40/spQbaDgaSsTq70bUnHPY07M7dPXTLyaMjfdTH9vOc3dzNRBE5Xk4T2S0VzyOZC52aMIN2XU+7kY2DsnLfb8Q0Mq7bnVd1n5/4ztHXg0X0qXAhwEQIvPp8OG3BaPVWcZk4JHwAqr7+PymVsQJq8sYdSMK44XDjYNMcMghBc/NWb8l21x8HJ0ircgH8J35tgQhgZvD8ozwp57SIzZBrudGv/RJnq93mZP8tRBYbwvSCIqmo+qozl8R6fglYOGTiJCuQncSD4sxY1lZj4Hd7ZbU/zBllF37CAQ3qF64aNp7+omj8oS/sbGOSP6TPx2iRbsh/XfXaGL5ilhqYKoqZSRdOPZ/u59rgwBmu7ugtjg8RzOhgeTWcdAQF4WmU12EChtIlSKxlVFqQhyi8+k6krxiBxHoQnsT9mANMMlWQWs97foAmpWayybpWTkreJ84ja1TvwrNV9W+Sza1252zYZCqFnZCfbdEDggX+az+VjAoCBGg4p4aVSwH+mHKvYKiUu+rv76ESzhRGbtWOQ7ZIF4+JDdYEU8jfTCfkDBOByVvwTwggAWH1bCnT/1ZE7arcb+KwYpemNqg==
X-Forefront-Antispam-Report: CIP:131.228.2.20; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fihe3nok0734.emea.nsn-net.net; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DVkg7MpfDM7gx1GY6+2nJu+tjEyeeUmkR0L1kk++8YiryPIxAg5WAN5lrfYaGEarxFzg0j6Plno5aFJtAOnl8r4N16guvjubNC/ev+C2f9MUuGhy4GTuJGFVUKlYhDMEfE+4ggTQ+IfgTTretSN1xWZexc8YdbhAp+x53I6dKd2tEI37AtpVV1OcuDsfeBewo9BlZWB81fLpCfgVwkhMvrJI4coTZkxrxffn5bt1qlGX6RDIvGBlU7Pp9btVjooQB5Izb0h9387oBjBI8r/c7/lIVnbaW2K+K5h0NEmYOy4x6I0ku6AMCrzalxnHObBR9QtbkgCLtzOE/65yhD/9o03KTumwYZ5av5Q+Z+yLjbFyxnGL/TXj8S9oY0wGCBic59ZtUnfyne40jz0YkbZJo8gf5/9FHz2sYUkobhGUtAP+vAbHTH++xU+PlKx/GPIN
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 08:08:10.8283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d7db04-f029-4b19-29cf-08df2f4a72c4
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.2.20];
 Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF00028CFC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR07MB10206
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement the get_timeout operation for the max6370_wdt watchdog driver.

Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
---
 drivers/watchdog/max6370_wdt.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/watchdog/max6370_wdt.c b/drivers/watchdog/max6370_wdt.c
index 584a4ed468c..ee6b514f802 100644
--- a/drivers/watchdog/max6370_wdt.c
+++ b/drivers/watchdog/max6370_wdt.c
@@ -65,6 +65,44 @@ static int max6370_wdt_stop(struct udevice *dev)
 	return 0;
 }
 
+static int max6370_wdt_get_timeout(struct udevice *dev, u64 *timeout_ms)
+{
+	struct max6370_wdt *wdt = dev_get_priv(dev);
+	u8 val = readb(wdt->reg) & MAX6370_SET_MASK;
+	int ret = 0;
+
+	switch (val) {
+	case MAX6370_SET_1MS:
+		*timeout_ms = 1;
+		break;
+	case MAX6370_SET_10MS:
+		*timeout_ms = 10;
+		break;
+	case MAX6370_SET_30MS:
+		*timeout_ms = 30;
+		break;
+	case MAX6370_SET_100MS:
+		*timeout_ms = 100;
+		break;
+	case MAX6370_SET_1S:
+		*timeout_ms = 1000;
+		break;
+	case MAX6370_SET_10S:
+		*timeout_ms = 10000;
+		break;
+	case MAX6370_SET_60S:
+		*timeout_ms = 60000;
+		break;
+	case MAX6370_SET_DISABLE:
+		ret = -ENODATA;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
 static int max6370_wdt_reset(struct udevice *dev)
 {
 	struct max6370_wdt *wdt = dev_get_priv(dev);
@@ -101,6 +139,7 @@ static const struct wdt_ops max6370_wdt_ops = {
 	.start = max6370_wdt_start,
 	.stop = max6370_wdt_stop,
 	.reset = max6370_wdt_reset,
+	.get_timeout = max6370_wdt_get_timeout,
 };
 
 static const struct udevice_id max6370_wdt_ids[] = {

-- 
2.39.2

