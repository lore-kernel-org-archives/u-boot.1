Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E645CA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 10:48:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0ED1380CF8;
	Mon, 12 Oct 2026 10:48:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z1zi8gvHGKv2; Mon, 12 Oct 2026 10:48:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C801C80CEA
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791802113;
	b=QPZtYnru42Co58e/JEvoeyJfZhAqvlN73AQ/Lfg44WxjZNwKe5B/57Yh5Gaa0IJ2GQya
	 ufcB8v6DmeJj1nf1C4V5rku4P46EtxIQqdhgY4Heoz7hZzCS13BtJz8BqDX4GcMDYacOv
	 BZP2Uif8xn5IRqpB1aFGjkQ4KBPWRdSjlTsPbclUvIfPnCzKmBud0iJHnSgW20kgK9rcm
	 br2D6aiSS+cvwyRITtLIsXgVRWpL9DlsfxkW7fe7vMDKfA4ndlk2PQ0snaXJ6J5EtIcLt
	 xYQaYoC++JG+1akQ/azFg6DV/PU/wraPinMxG70IK8oqKQ/VelxkwbuanivZOSkuCbQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791802113;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4dTxpInqlPTtn8b3uR437k0WxgicjNnH3+2uKseCVs0=;
	b=pX8ma2X61glVSrB9E7SNASOVZwnQwDcZ21AIKK1Qz3TW/sXwAcm+gUfNPXye1LG1d4+4
	 Uz/GGyacBmRbmxaUsJg9gsPKlK+9KNXIZfqKToeH7XPI7Z/uppNg3bfW0kI98amAG9cyG
	 g+Ao9EYzq8l82ewjHPLmXrplc89G/dLgF1v3rfM7Zxtv9DWvon0O8b2hWXfA3jCsJ21FM
	 KV+ErnAnW7BMndGn9XqlAwvhHwaWQgsJfWt473Kw6HDzOU6MSFSloHuobPgANmL/xrqUC
	 RmMpP76gO5fCPrCBZ8Iy0ojxwihvCOf2rgjbSmzoG5UplYip5vMP+7yCWcuaheqK7cQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791802113;
	bh=4dTxpInqlPTtn8b3uR437k0WxgicjNnH3+2uKseCVs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GfTAus5h4wCWiV4tooSUcrlks6xJ5MlRr3GsEacvEmBVwn0GrIpEQ4LHfyj2TrY2K
	 YeK5lYWgyvJYW53y8UwVkJGj7DqmoosAAmTrYleaZnop5Hl4F8u5PVLgA2blvi7SqL
	 IuX2H3BIaui0+D10CAo+5cGpvqowUwWYovCTqJsMa1+CQslhXvt9rPbpaeP7PQfJRZ
	 Ju0n20E84tGxSVVsF5zwqIyb+r4ec5/HmZfHvYeKkGib4CubY/X7MZoUR2gONmO61o
	 OKtGePR37WO00oSFkQXpgrZNWjwAb+d76d4zi3FYNe3EAJr022WywVXaQI771so2H3
	 9w1BwLm27G14Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C801C80CEA;
	Mon, 12 Oct 2026 10:48:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 05095A58
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:48:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BB5F2605ED
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:48:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SPQtR_xo5HLX for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 10:48:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 496EA605DE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791802104;
 b=n/233LsrARL71aUjiXSumYVtl7sCPV4Ex6C4Wpm5hGqV3PAkNhqh7KRvuAm8UnwJvF3I
 PsqaEUw1ecPCsh06gssu2WV2idRin79CU2Cun+04eTnhs8ZIRktHNHYjD4keDlHnIfIPk
 h3GGOVI3Pxqy1/PxRTrQ89eFZgYA6xEyB9ic2gsVKIclYTl/A2BXlov725qcA/7GmCTDb
 mQhfOTlhddjri542Jzl+duK+QDYGN42cfjEjuKJrwRSwti9YiqfkNR84EO42fVJvfnEhT
 zTs0r/sQV1sgmuyTU07M44oXaMMvl7EiEK2fSA44UFQiAEDSK3G7ZufFSsakG440hnw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791802104;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=4dTxpInqlPTtn8b3uR437k0WxgicjNnH3+2uKseCVs0=;
 b=NGqUYhD6Oi9V80cxfxkxdG/CFUbYzJO6ULpUv9p9wPp5jOqdp5kMEMyZtrahqSxkg05Y
 K81ABlC3Z1ok4DpdNh+0reWs61ShA9xZxfG7TccqKjf2UusAGbd+MS/rg7UyuSqDr0RES
 N0D+htAP/+6yEzvLFzlHpIlpQvm3/7aDwNDFLnTRxrTBI04gmswmD1aOMWMMMUjw9dw3G
 S7UPz/Q0fSu/NL/ejZJ9VQDa3dq2UdsFm908S00dmrwilUOvMdRruNjCKk9DBqac1w0mf
 ByOS3sJd1hySdzR9/mXcMg967xKWk8eMKOdOBtI7BqF0kIZ6kPFMJxfCTB3EVuE7sjQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=none header.from=softathome.com;
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=azhfIY2K; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:c20a::;
 helo=pa5p264cu001.outbound.protection.outlook.com;
 envelope-from=yan.wang@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=azhfIY2K
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 496EA605DE
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:48:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bUtx+QeGKPcrlfHvLi5pileIOPq5VkkUHB1jzCzPKKAPHlRs+ACyFvZ1ixTljLGEEKppaGl5wf4IkjMIuLurDbAznCNpqDpaXGVPef6N4G6tQz3X1OSRtVYW4CaSzeLw8yBvdcy9157IMl5qxE5x6SA5h5BdSC8/avI/XXsz4neEnUMjLeNljdRMDJlPYHXs0D1Mb/D/ilr7GGjOXNd39//8OWERDr9kpW3uHTGu8gE29SnHcLwUzDTnZdKKGMNKQLols2bazGCdHUEm2e/B+uucU9FaW9JcWP3YLDeTO75bV2dJtntLa8WFE8OAn7/lf9+7wk4RQ1Jk2A1Q9rWvsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dTxpInqlPTtn8b3uR437k0WxgicjNnH3+2uKseCVs0=;
 b=tNltda8LVHFe1two3A2ei98QP4+dGn4paioY8DEOzamfgjK165mTQORVfz1/5aRRjttdINsBkqunt0Ae8U64V3neaZAUV7PYSuoa2V9D/OqtEf/fNrWh2RZ4M7aFNVMlKcu/H/1oiD+qzug/Wvl9Pr0ZfWzzh4CNICbjbbIZOKjceJQCHh+lu06G5LBKI9JEf/9b6eu1154PEwMpWwo238QiIJqsSvVrXgPhFkF65nJ7U/gbLAq68Tv1EA1UFLbwAHpE88nJPTEWfWkWGIcbnS8w2BIQblys6wuJUWkBtHhmuIfkmLZIml/WG/MnwmNoXoJCfutHKBwTr/WIukOEIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dTxpInqlPTtn8b3uR437k0WxgicjNnH3+2uKseCVs0=;
 b=azhfIY2KVPyzkaZcBp19UqLo5y7ODG7jaOaLR1F7wazxymOiE6dGH4c+lqztbHydtVIYmNrvg+w+KTg3wQJK76T2rAG8nMOZQxvY9kBjTngDMVRFUlqHmROE3+ockMWFuC4RjJXxmYLlvWsmVJpAEWJWOfUOD2IBUrrRnqDzlfNUY+Iztv6W5qtY52stxl+3+4MoZgcgymadZMQaGD5holGtd0/z3aXgWpxhIlWW3AWSVqJgynl2lwkm1+KUHJqje3hhhYfaErgGHtQnAF+1NwuQEIzFvRfJbeGDPH0My9Pc9U2+MCFCIzestLJV33lT5mxNHgAXiuv61X37p7yAKQ==
Received: from PA7P264CA0206.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36d::12)
 by PARP264MB6345.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:4a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.19; Mon, 12 Oct
 2026 10:48:15 +0000
Received: from PA3PEPF000089BB.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36d:cafe::a0) by PA7P264CA0206.outlook.office365.com
 (2603:10a6:102:36d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 12
 Oct 2026 10:48:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not
 signed) header.d=none;dmarc=bestguesspass action=none
 header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089BB.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Mon, 12 Oct 2026 10:48:15 +0000
Received: from localhost.localdomain (unknown [192.168.72.213])
 by proxy.softathome.com (Postfix) with ESMTPSA id 07E872010C;
 Mon, 12 Oct 2026 12:48:15 +0200 (CEST)
From: Yan WANG <yan.wang@softathome.com>
To: trini+nodisclaimer@konsulko.com, sjg+nodisclaimer@chromium.org,
 alpernebiyasak+nodisclaimer@gmail.com, marex+nodisclaimer@nabladev.com
Cc: philippe.reynes+nodisclaimer@softathome.com,
 paul.henrys_ext+nodisclaimer@softathome.com,
 u-boot@lists.u-boot-project.org, Yan WANG <yan.wang@softathome.com>
Subject: [PATCH 3/5] binman: Add HSM signing support to pre-load entry type
Date: Mon, 12 Oct 2026 12:48:02 +0200
Message-ID: <20261012104805.17297-4-yan.wang@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012104805.17297-1-yan.wang@softathome.com>
References: <20261012104805.17297-1-yan.wang@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089BB:EE_|PARP264MB6345:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 924030fe-6653-4aae-4bd5-08df284e51a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|22082099003|17002099007|261009223027099003|6133799003|10067099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: JF9R89o6Vz+D+JTP7QSOBZ6i7HqbvwwM9AyQ/zoyf+eS6QHiRCrcsa2LJqZu8DJ3DlSWBWmafBHzBhtvfM++CZMF3oO5Ahbn1IboL/Cwz0wvS3abgkc8TP6sQAcBunMRwLovj8KkrYbG8CWlfbi9WCDkPTVlNCkWyh99jslBNc1arEuwoCK2VtbT6puMAFiinDaQmfA3tsQYaGFmp3KmYq1dYYYBGmqcH1NVkp9anNOlyOw5AyLyMi0i9/wrbma2hUR1JQx52McjwhHKi83wTzMSQUA3Tz/q9ZWAx6Jddrbo9ONPsS4abzVSFLSIavfzYMJaIByZUIScz1z6G7N1RinzTCYFSmkcuA3C87lCMQ4jUVemdeNjyb/s3np+gNRydjUwqqFV4XNh99d26fxcC0vRWfJ6dEZltafHM+t8Mps4WRO+v0S+7vK/7fyETgr2ZYfJmFKkmdJWLPqmSG1onEcFVIKD3Cs/2mWnGVscj462+T+bqcKA7J0ediMSouVjMfcO5lQkWY2ZIrSa5ZcrYq7j+p5KXJSOL91hChSlLoWMs0jElkEOsT8C8cv72WLHLpCjW9E2KZZ8MRI2xURTspCHRzjtseY4hKDPJz5ZXZXPbP+iPyyQttFVDHWDmeYW9Y+WcDLVN4H8QJ54eQ5kQnbxgTkrXl+GilMy3S3/U1WVqowUBBN7SlBRQ+K40wuB0No3eN9nt1ts3aN05bzBaw==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(22082099003)(17002099007)(261009223027099003)(6133799003)(10067099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eQjy5OcxRJq13WCOotLXnxvI8KrJ/cKKG0YwkKt3njKHeyIdiOqsF6hYX8c3RQ47VGptwluR/P9T6f0mX0S9EM3xDUiRdtebkfplK8RYJuN+batmjVpMlz9gSBSzqwDRQgpUPlgtS2RGaogIbjDcIDEDLw2fkbjbB8W2ZaKCLeRWz7tv60COqoeRBFW1fdaJwtk9MyaGxis4S5vXFIlAyP6ARdA6OmkWbtXCYG9sJN33jWLsHwWdz6qMpgB1aCqxEAJFhXCH/eepohkZiE1CCHBAW1OHXPaErhyoPgEk00/z6n3UqNyx5OrSjpKGqzPIIU8qd2rN9QSRVzS8xwjF39t873x9IgCcukEV6TLfpKSN6vAVp0zAGe26ChBpAEquM7RA1lszz2mtb/ouizkKZxC2IzH6YzDApkeeC9biyhRwFijm3YxhP8mhAM9TRiMx
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 10:48:15.1722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 924030fe-6653-4aae-4bd5-08df284e51a4
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089BB.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB6345
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Extend the pre-load entry type to support signing via hardware
security modules (HSM) using PKCS#11. The implementation integrates
with the pkcs11_tool btool to perform signing operations.

Signed-off-by: Yan WANG <yan.wang@softathome.com>
---
 tools/binman/etype/pre_load.py | 285 +++++++++++++++++++++++++--------
 1 file changed, 214 insertions(+), 71 deletions(-)

diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
index 0d953cb258e..26e2c5eb3be 100644
--- a/tools/binman/etype/pre_load.py
+++ b/tools/binman/etype/pre_load.py
@@ -2,7 +2,7 @@
 # Copyright (c) 2022 Softathome
 # Written by Philippe Reynes <philippe.reynes@softathome.com>
 #
-# Entry-type for the global header
+# Entry-type for the global header with file-based and HSM signing support
 #
 
 import os
@@ -22,9 +22,9 @@ from Cryptodome.Signature import pss
 PRE_LOAD_MAGIC = b'UBSH'
 
 RSAS = {
-    'rsa1024': 1024 / 8,
-    'rsa2048': 2048 / 8,
-    'rsa4096': 4096 / 8
+    'rsa1024': 1024 // 8,
+    'rsa2048': 2048 // 8,
+    'rsa4096': 4096 // 8
 }
 
 SHAS = {
@@ -33,8 +33,9 @@ SHAS = {
     'sha512': SHA512
 }
 
+
 class Entry_pre_load(Entry_collection):
-    """Pre load image header
+    """Pre load image header with file-based or HSM signing support
 
     Properties / Entry arguments:
         - pre-load-key-path: Path of the directory that store key (provided by
@@ -46,29 +47,57 @@ class Entry_pre_load(Entry_collection):
         - header-size: Total size of the header
         - version: Version of the header
 
-    This entry creates a pre-load header that contains a global
-    image signature.
+    HSM Signing Properties (optional):
+        - hsm-support: Enable HSM signing (boolean)
+        - hsm-library: Path to PKCS#11 library (.so file)
+        - hsm-token-label: HSM token label
+        - hsm-token-serial: HSM token serial number (alternative to token-label)
+        - hsm-key-label: HSM private key label
+        - hsm-key-id: HSM private key ID (alternative to key-label)
+        - hsm-pin: HSM user PIN
+
+    This entry creates a pre-load header that contains a global image signature.
+    The signature can be created using either a traditional RSA key file or a
+    Hardware Security Module (HSM) via PKCS#11.
 
-    For example, this creates an image with a pre-load header and a binary::
+    Example with file-based signing::
 
         binman {
-            image2 {
-                filename = "sandbox.bin";
-
-                pre-load {
-                    content = <&image>;
-                    algo-name = "sha256,rsa2048";
-                    padding-name = "pss";
-                    key-name = "private.pem";
-                    header-size = <4096>;
-                    version = <1>;
-                };
-
-                image: blob-ext {
-                    filename = "sandbox.itb";
-                };
+            pre-load {
+                content = <&image>;
+                algo-name = "sha256,rsa2048";
+                padding-name = "pss";
+                key-name = "private.pem";
+                header-size = <4096>;
+                version = <1>;
+            };
+
+            image: blob-ext {
+                filename = "sandbox.itb";
+            };
+        };
+
+    Example with HSM signing (SoftHSM)::
+
+        binman {
+            pre-load {
+                content = <&image>;
+                algo-name = "sha256,rsa2048";
+                padding-name = "pss";
+                header-size = <4096>;
+                version = <1>;
+                hsm-support;
+                hsm-library = "/usr/lib/softhsm/libsofthsm2.so";
+                hsm-token-label = "uboot-hsm";
+                hsm-key-label = "uboot-key";
+                hsm-pin = "1234";
+            };
+
+            image: blob-ext {
+                filename = "sandbox.itb";
             };
         };
+
     """
 
     def __init__(self, section, etype, node):
@@ -79,6 +108,19 @@ class Entry_pre_load(Entry_collection):
         self.header_size = fdt_util.GetInt(self._node, 'header-size')
         self.version = fdt_util.GetInt(self._node, 'version')
 
+        # HSM properties (optional)
+        self.hsm_support = fdt_util.GetBool(self._node, 'hsm-support', False)
+        self.hsm_library = fdt_util.GetString(self._node, 'hsm-library')
+        self.hsm_token_label = fdt_util.GetString(self._node, 'hsm-token-label')
+        self.hsm_token_serial = fdt_util.GetString(self._node, 'hsm-token-serial')
+        self.hsm_slot_index = fdt_util.GetString(self._node, 'hsm-slot-index')
+        self.hsm_key_label = fdt_util.GetString(self._node, 'hsm-key-label')
+        self.hsm_key_id = fdt_util.GetString(self._node, 'hsm-key-id')
+        self.hsm_pin = fdt_util.GetString(self._node, 'hsm-pin')
+
+        # Will be set in AddBintools if HSM is used
+        self.pkcs11_tool = None
+
     def ReadNode(self):
         super().ReadNode()
         self.key_path, = self.GetEntryArgsOrProps(
@@ -86,68 +128,169 @@ class Entry_pre_load(Entry_collection):
         if self.key_path is None:
             self.key_path = ''
 
-    def _CreateHeader(self):
-        """Create a pre load header"""
+    def AddBintools(self, btools):
+        """Add required btools
+
+        Register pkcs11-tool btool if HSM signing is enabled.
+        """
+        super().AddBintools(btools)
+        if self.hsm_support:
+            self.pkcs11_tool = self.AddBintool(btools, 'pkcs11_tool')
+
+    def _SignData(self, data):
+        """Sign data using either file-based key or HSM
+
+        This method provides a unified interface for signing data regardless
+        of whether a traditional RSA key file or an HSM is used. The signing
+        backend is selected based on the hsm-support property.
+
+        Args:
+            data (bytes): Data to sign
+
+        Returns:
+            bytes: Signature
+
+        Raises:
+            ValueError: If configuration is invalid
+            RuntimeError: If signing operation fails
+        """
         hash_name, sign_name = self.algo_name.split(',')
-        padding_name = self.padding_name
-        key_name = os.path.join(self.key_path, self.key_name)
-
-        # Check hash and signature name/type
-        if hash_name not in SHAS:
-            self.Raise(hash_name + " is not supported")
-        if sign_name not in RSAS:
-            self.Raise(sign_name + " is not supported")
-
-        # Read the key
-        key = RSA.import_key(tools.read_file(key_name))
-
-        # Check if the key has the expected size
-        if key.size_in_bytes() != RSAS[sign_name]:
-            self.Raise("The key " + self.key_name + " don't have the expected size")
-
-        # Compute the hash
-        hash_image = SHAS[hash_name].new()
-        hash_image.update(self.image)
-
-        # Compute the signature
-        if padding_name is None:
-            padding_name = "pkcs-1.5"
-        padding = None
-        padding_args = None
-        if padding_name == "pss":
-            salt_len = key.size_in_bytes() - hash_image.digest_size - 2
-            padding = pss
-            padding_args = {'salt_bytes': salt_len}
-        elif padding_name == "pkcs-1.5":
-            padding = pkcs1_15
-            padding_args = {}
+        padding_name = self.padding_name or 'pkcs-1.5'
+        padding_btool = None
+
+        if self.hsm_support:
+            # HSM-based signing via pkcs11-tool btool
+            if not self.pkcs11_tool.is_present():
+                self.Raise("pkcs11-tool btool not available for HSM signing")
+
+            if not self.hsm_library:
+                self.Raise("hsm-library is required for HSM signing")
+
+            # Normalize padding name for btool
+            if padding_name == 'pss':
+                padding_btool = 'pss'
+            elif padding_name == 'pkcs-1.5':
+                padding_btool = 'pkcs1v15'
+            else:
+                self.Raise(f"Unsupported padding scheme: {padding_name}")
+
+            # Use slot index if provided (simpler than serial lookup)
+            try:
+                signature = self.pkcs11_tool.sign(
+                    data=data,
+                    module=self.hsm_library,
+                    token_label=self.hsm_token_label,
+                    token_serial=self.hsm_token_serial,
+                    slot_index=self.hsm_slot_index,
+                    key_label=self.hsm_key_label,
+                    key_id=self.hsm_key_id,
+                    pin=self.hsm_pin,
+                    hash_algo=hash_name,
+                    sign_algo=sign_name,
+                    padding=padding_btool
+                )
+            except (ValueError, RuntimeError) as e:
+                self.Raise(f"HSM signing failed: {e}")
+
         else:
-            self.Raise(padding_name + " is not supported")
+            # File-based signing (traditional method)
+            if not self.key_name:
+                self.Raise("key-name is required for file-based signing")
+
+            key_name = os.path.join(self.key_path, self.key_name)
+
+            # Check hash and signature name/type
+            if hash_name not in SHAS:
+                self.Raise(f"{hash_name} is not supported")
+            if sign_name not in RSAS:
+                self.Raise(f"{sign_name} is not supported")
+
+            # Read the key
+            key = RSA.import_key(tools.read_file(key_name))
+
+            # Check if the key has the expected size
+            if key.size_in_bytes() != RSAS[sign_name]:
+                self.Raise(
+                    f"The key {self.key_name} doesn't have the expected size "
+                    f"({key.size_in_bytes()} bytes vs expected "
+                    f"{RSAS[sign_name]} bytes)"
+                )
 
-        sig = padding.new(key, **padding_args).sign(hash_image)
+            # Compute the hash
+            hash_obj = SHAS[hash_name].new()
+            hash_obj.update(data)
 
-        hash_sig = SHA256.new()
-        hash_sig.update(sig)
+            # Setup padding
+            padding_module = None
+            padding_args = {}
+            if padding_name == "pss":
+                salt_len = key.size_in_bytes() - hash_obj.digest_size - 2
+                padding_module = pss
+                padding_args = {'salt_bytes': salt_len}
+            elif padding_name == "pkcs-1.5":
+                padding_module = pkcs1_15
+                padding_args = {}
+            else:
+                self.Raise(f"{padding_name} is not supported")
+
+            # Sign
+            signature = padding_module.new(key, **padding_args).sign(hash_obj)
+
+        return signature
+
+    def _CreateHeader(self):
+        """Create a pre-load header with signature
 
+        This method creates the pre-load header regardless of whether signing
+        is done via file-based keys or HSM. The signing backend is abstracted
+        in _SignData(), eliminating code duplication.
+
+        The header format is:
+        - First header (64 bytes): magic, version, sizes, hash of image signature
+        - Header signature (variable): signature of first header
+        - Image signature (variable): signature of image data
+        - Padding: zeros to fill header_size
+
+        Returns:
+            bytes: Complete pre-load header with padding
+        """
+        # Sign the image data
+        img_sig = self._SignData(self.image)
+
+        # Compute hash of image signature (always SHA256 for header)
+        hash_sig = SHA256.new(img_sig)
+
+        # Build header fields
         version = self.version
         header_size = self.header_size
         image_size = len(self.image)
-        ofs_img_sig = 64 + len(sig)
+        ofs_img_sig = 64 + len(img_sig)
         flags = 0
         reserved0 = 0
         reserved1 = 0
 
-        first_header = struct.pack('>4sIIIIIII32s', PRE_LOAD_MAGIC,
-                                   version, header_size, image_size,
-                                   ofs_img_sig, flags, reserved0,
-                                   reserved1, hash_sig.digest())
+        # Pack first header (64 bytes, big-endian)
+        first_header = struct.pack(
+            '>4sIIIIIII32s',
+            PRE_LOAD_MAGIC,      # 4 bytes: magic number 'UBSH'
+            version,             # 4 bytes: header version
+            header_size,         # 4 bytes: total header size
+            image_size,          # 4 bytes: image size
+            ofs_img_sig,         # 4 bytes: offset to image signature
+            flags,               # 4 bytes: flags (reserved)
+            reserved0,           # 4 bytes: reserved
+            reserved1,           # 4 bytes: reserved
+            hash_sig.digest()    # 32 bytes: SHA256 hash of image signature
+        )
+
+        # Sign the header
+        hdr_sig = self._SignData(first_header)
 
-        hash_first_header = SHAS[hash_name].new()
-        hash_first_header.update(first_header)
-        sig_first_header = padding.new(key, **padding_args).sign(hash_first_header)
+        # Assemble complete header: first_header + header_sig + image_sig
+        data = first_header + hdr_sig + img_sig
 
-        data = first_header + sig_first_header + sig
-        pad  = bytearray(self.header_size - len(data))
+        # Add padding to reach header_size
+        pad = bytearray(self.header_size - len(data))
 
         return data + pad
 
-- 
2.43.0

