Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816EBC55160
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 13:30:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3159980E73;
	Thu, 30 Jul 2026 13:30:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1JlmZydSa_kv; Thu, 30 Jul 2026 13:30:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 79EFE80F2C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785418200;
	bh=Bnv1L+7VCxaISuRJAKJRk7F5B5BabL0HVFIS+5+IrmM=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A3ru4vo7R+m6QpE2WNPbL4LIwNeY4wouu/Tpgufi2+Z5LTqcbVYw9tiAsYz4BACR6
	 fveKiNN6aDbigywNMZrErVCDRsAiCLut07dKcbRledzol7B+2ef7vRmlhO3yos+2+V
	 gXO0XxO8SWjaY8+VSojn5QiHGmF7sQ3apsGf0owr6cST829jnd6MO5Kux1g2iNDVtV
	 TKpJP6Y9DNYhIPzocJXbkpg9kNGwrIi4x9TQkc1zErJqkgN8fIdMBrVKcCRTUzNrq8
	 VC5uMnpLUx/HH8KExpQtPy90JLw9DV0xG7J3sW6x6OKEiNrJ7Cy6SprmpRvch60CtH
	 dHijtFrZ+Lprg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79EFE80F2C;
	Thu, 30 Jul 2026 13:30:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0511A27C
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:29:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DF17F4008C
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:29:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sTAqT1Dk4-Tu for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 13:29:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=jerome.forissier@arm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 51075401A3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 51075401A3
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 51075401A3
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:29:56 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03520849AA; Thu, 30 Jul 2026 15:29:53 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EDE18498B
 for <u-boot@lists.denx.de>; Thu, 30 Jul 2026 15:29:50 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=nISl3Qt3VK5PdMpt/1ma33Rpej6tdl0HVrxT9cGohfHvHVpa5eU1qSBQmmoo9N7dUSTKbw2JRXKNtSDJ2vmznBNcpSxEoki2o3CQCkm0Iy0jGD7u4FHSJ+zuU4/XCHYPXyHkukr8ki8sTnT0mrKc2G6TK6b2EhqMcNY13SJoJiKQIzIiAsm3Uwq9SBBS0PMLR9vD8JfeqtLElJS8V7tSY0R1vrt93ubre+zBSrlrtpdljzEWZVQIbjfDwhfTFVZET2ZDC9UYeybFceuPOln+ChFIxLZy2kbJGerLaLV7do3L6JhQKLsOxSlik5ld90LPv7lQkBu3+NjPnD8N9G84GQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bnv1L+7VCxaISuRJAKJRk7F5B5BabL0HVFIS+5+IrmM=;
 b=yU1XpE0SQkFUg0PUFS/2J0uNZXTVlos6/lReICiyVOafTcE3E5kj5ipKWl34LjGBQTY4iIrcYB5V/lxjGIqePW0dEkQxOfCbWmLDgwD5XY5FnuKaNXcGaDIDBjWhg6qTrXlU3LrY/KxUyvZfntlaP3MpGDVZarhG78r4IzPpzYtt5XzT5Oyt2hlu8KGtg9DZ+mE7z5eH9o4UuayIo2h5Rhy4aPrdhy3PuGQXqm4LRtrv5xjAXFU1h9iHCtFmcoStmAXZeYGL1GEzzVlM83ZemtFZXsNFi3v1c1OrZ9czvXxlkJ5Fy/GWDztiu6YNVRMcT3rmlk9TDYppFpM7lvvncg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
Received: from AS9PR06CA0133.eurprd06.prod.outlook.com (2603:10a6:20b:467::34)
 by AMBPR08MB11939.eurprd08.prod.outlook.com (2603:10a6:20b:762::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 13:29:48 +0000
Received: from DU6PEPF0000B622.eurprd02.prod.outlook.com
 (2603:10a6:20b:467:cafe::97) by AS9PR06CA0133.outlook.office365.com
 (2603:10a6:20b:467::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.14 via Frontend Transport; Thu,
 30 Jul 2026 13:29:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000B622.mail.protection.outlook.com (10.167.8.139) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8
 via Frontend Transport; Thu, 30 Jul 2026 13:29:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TLlnnQtR0wsd4kQFOXGwAhZRrJfwT39p83btYm9DUfgaK84rBu93nxYOm4R2H8m3xzaSfuB5VmeI9QmsJkcQQ4bCjjpD4HhnQUHlApM/BnEAt3utSnBwNHPcdXGtAlFk5wGwPBmsQmbz6j7XgEAvNnlIrMo+IqvAhL7OVmRu5jUrR1pz0er6Opn3FnZmo6ALt8It3S6CjrmEzSYbuDWwpNceK0yWuxTRkC8toc7u3B5YSbXjxZ3k/gObxzU3ekdVjkxvLav0UpduBe2Bx1zAChidGiik9xyNDY9V6XRRF3Ye/UEiiaDRUEvVLuuupikLbNZ45b+8AnCvHtn/79LJbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bnv1L+7VCxaISuRJAKJRk7F5B5BabL0HVFIS+5+IrmM=;
 b=ZMtDOGinabeT814D4e7kJWDX/wiBHW9EbGj5n/oLSMOaVx9kH5/+hZn9pJKTmys6VLb9hbFyPmmNXy67RVM48OwpU6Ayu1NykNJ7ZYY7TJvo2wYUpbmwuu+15y8HZqomrwBofXIByqwBd5J4UPukpHslys2x0XvVAVn8uWEkR7ikLIXKVifiI9QpG+SKWSeSjh2O4t9/G50irsgtqIEJ2WMxfzpO9GYlVJN79S9niVVlPU7EUyBSae1qaTFLRrD5Nk7PhlQ9uaB5S8F7oDw7eac7d/lT+JYC5d7Ja9HegRjhuEhAHjm4R+6u8tK0GgMJvgwWNb3G0GRsxGQRdj63HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GVXPR08MB11741.eurprd08.prod.outlook.com
 (2603:10a6:150:312::22) by DB9PR08MB9442.eurprd08.prod.outlook.com
 (2603:10a6:10:458::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 13:28:45 +0000
Received: from GVXPR08MB11741.eurprd08.prod.outlook.com
 ([fe80::d47d:7756:5c28:de2c]) by GVXPR08MB11741.eurprd08.prod.outlook.com
 ([fe80::d47d:7756:5c28:de2c%4]) with mapi id 15.21.0270.009; Thu, 30 Jul 2026
 13:28:44 +0000
Message-ID: <2a00406f-0685-43f4-aed6-e94611e2d583@arm.com>
Date: Thu, 30 Jul 2026 15:28:43 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH v2 1/2] net: fix out-of-bounds write in IP fragment
 reassembly
To: u-boot@lists.denx.de, Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Cc: Tom Rini <trini@konsulko.com>, Wayen Yan <win847@gmail.com>,
 Simon Glass <sjg@chromium.org>, Argus <argus@byteray.co.uk>, nd <nd@arm.com>
References: <20260728-net-oob-fix-v2-0-eae61b883ed8@byteray.co.uk>
 <20260728-net-oob-fix-v2-1-eae61b883ed8@byteray.co.uk>
Content-Language: en-US
In-Reply-To: <20260728-net-oob-fix-v2-1-eae61b883ed8@byteray.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0551.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::19) To GVXPR08MB11741.eurprd08.prod.outlook.com
 (2603:10a6:150:312::22)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: GVXPR08MB11741:EE_|DB9PR08MB9442:EE_|DU6PEPF0000B622:EE_|AMBPR08MB11939:EE_
X-MS-Office365-Filtering-Correlation-Id: 869731dc-a54f-41f7-b1f4-08deee3ea053
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|18002099003|22082099003|10067099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info-Original: cm59rR8stmEtvokSpfin6zRvGgyRE7HhCrdbWrnYgSJOSrxHFeZdaR3nZY+sN2IeWnB3agiIWu8rwop0eQ/Ylgf7XLCxbQX76JeF9jwI0N+lwgNLAN9kQzQaNHBX9JJ/EQil/vnJNxTMC5dCWyqS/iOptwHbb72pW/0fR/mLqw5wbHALgW7a5z9MJwW4Tqc7qdSj253csdSBn1AEY7DbPfZ4rH4wTuzWvJ483WSf+SFcq2LrM8w1h1B/iFslT5yvFVF3b+/8dhSRp9jq5/R0fQjSQqYn9GoytfNOTguGk9W2+AbWtqqzsMGRVyJLy2yy7plO/amRBNxG9D2WbIXp7elf1AGgZ+Gx/H3L7iGHSS9L7hruBqrc2zVT7I25vYbHWw5cdBkXyGmeaiVZCeIdek1h2fGcPxdEonbWEcCh07YITmJbreR77691zy9312eVtNttTgyg3F9INByrQ8yhL+mPyoHS+/SGFgmwDPJdWEhEww49MXIhB+L8Aix04fse2KxCeH0eTIF782J0W3iCHLoXPmQ9JLIP+NaYscP23KqPayrLmWtsoeajmwnpVPx1dhNZuDjGD0Gx/+fJX9um7Rlxxx2RlaS/pILrCCOhY4/p0h2VU+PilGwoHTsxqyCM1DjYoCfBq9uC6WJWMjMh6mHthTgLcmTOLD6Zyc5i3eY=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GVXPR08MB11741.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(10067099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: k5oP0hf6wxiKc9yrCbcBQ5FkECXIuc/5LP843ZBj+UgL1QeDsUX0ZvW8utyNRaAMRlWLYxU+XrXoVipy9j1BjXsKLyBKplvFNGdX0300zRXMW7UaRjO7fJJGl/KHP+HBK7mlRxfNbaBU5+xiFCcZCr12v8WiKNJcIg7D5cmB1bR/+5MCXUDE5TgaEQE4gecJquMQQ6NC2yy5sep5a4M8zHRku2xRA72CSPPM14RoKEgrUMWyLBaxSCFCkSSHFS+JYg9h6npv5Z83OecigtBeokNFGEVOPtwi8hqcfEsCld1Iwa63NDrOb3jvob6Lie+931otcXVbIFqBGvHWxDbqzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9442
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF0000B622.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6b2061e2-828b-46c2-506c-08deee3e7a9a
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|376014|36860700016|1800799024|23010399003|14060799003|82310400026|18002099003|22082099003|10067099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 35EfbPy2tlD04VtBPhV7RTApRJd9qcMu1rniYfnbNqcu6TzeXL6hxKVRBc/z1BxWVBoVixH/oUICtVop3/9OyY0M2DA9aEZe1X77JuZ1dGLO94tcO9MjMhfRVFCJ+rxkgBm4k5E3o8uU4Ce/+N0CAjiPmSJ5IZc76dj3QdcVUg1gHDwuzIvmIoEEfv0DYYMVBYY19/r6f5TfI9l0+SvDpgvSNa8OUuwnbqBNQ6OJGwVGavBYIryehiZWvGoGOfzFfhG6gOTU9Mt1cLGsBqIFhCdMaVkypwWgExcAP5TImFOX4lJTYrI0sGds3X5LUS+1rCw4Lr0JMeBvhLnE3sekiYNt8ulyb77TeMOmh5gGOMDVS3mBSegiUP6Xz2BUtCxXo6NzcWRJUCLEE+pWspGBth4CThsUN+HRf4wq0ao3/YzdFDyNRq9kDsUXyh9m99ppIzI7qz4cjWGAjF/lTJznHo8y1q+nx2TIPDOBPu0xDKVyjPKew9eAW+BGvHeeyao1SnpJxMTf4qjO1WG2Xv/Eh4nJj2TwqgfkdTuOVY2ssunSfmPy1j0gnbBIzAg02ZoyukHNDDJvrwUq6zxYLkL92a85cjZB5hIGHpRyAK1zmszmhF6ttNr2X/wDzNOa396rOTcdPdv4T2sJuoiFjYWlk6Q+CcLuuN3Vtip7QRxSHvQODdK7uPe1l01IUEmZARErFosG8SzY9EwWD8KAf6Lubw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(376014)(36860700016)(1800799024)(23010399003)(14060799003)(82310400026)(18002099003)(22082099003)(10067099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o/Bf+FC9/zZyMHo3Arm2UQE/HrpJ1vzzQFTKqGHvoHqlyyyXqkRDM7UVDAab4FNAw4mg71zUze8EYsqAQVlnywyYCR3U076Wt+YzbHjUgZrF/WlU15E2IJmA0rnAAinBlUhsLfb1gM7OiP2ufaJNhOx40MUXiZsoOF17AZC+e5xwNMo52PBd/vKuf7D49tU+3ZHHwblltRny/W4GNV9CqIt2qWhfVs+cSLKGMCFFyqMsaMUeXOEH3jlwPp4WLkA5tmRaxN2uCp2YzH4qIFXXKRGPp4pdX2rq525S5oeEMeZNTG7KSSguTbZ6A/IPfGSACJx7TcRYevRgR6wuGXvyHYa39TVHDNvT/zRfwmY3iLWPxQWPScLXxW21l7RhslsgpPpVLUOI02pYDBooNvBaLyrmF8XecoVq/oMrPxJ9OaymnjDzGrdcnDJj/3oQPimL
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 13:29:47.7397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 869731dc-a54f-41f7-b1f4-08deee3ea053
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B622.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR08MB11939
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bnv1L+7VCxaISuRJAKJRk7F5B5BabL0HVFIS+5+IrmM=;
 b=czFIH1xnJzFUFIRxBM0DXz94Zp7y7CTqYtFpFFskJdOG2U+lafmW4ClM/kho5Bl9/dgD59RvbCRBj+pd6f960q/D+vr/Jt1IIU1XV/2EamOpQEe0rnoXoiOpPWXxpkKMiTdav91XG+OBsSQFt8Rr63DXfjaO0oOOIkC1ORZ2+r0=
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bnv1L+7VCxaISuRJAKJRk7F5B5BabL0HVFIS+5+IrmM=;
 b=czFIH1xnJzFUFIRxBM0DXz94Zp7y7CTqYtFpFFskJdOG2U+lafmW4ClM/kho5Bl9/dgD59RvbCRBj+pd6f960q/D+vr/Jt1IIU1XV/2EamOpQEe0rnoXoiOpPWXxpkKMiTdav91XG+OBsSQFt8Rr63DXfjaO0oOOIkC1ORZ2+r0=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=czFIH1xn; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=czFIH1xn
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Jerome.Forissier@arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=arm.com header.i=@arm.com header.b="czFIH1xn"; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.b="czFIH1xn"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


On Tue, 28 Jul 2026 08:50:07 +0200, Shahriyar Jalayeri wrote:
> __net_defragment() reassembles IP fragments into the static buffer
> pkt_buff[CONFIG_NET_MAXDEFRAG].  The bounds check
> 
> 	if (start + len > IP_MAXUDP)
> 		return NULL;
> 
> only covers the fragment data copy.  The split-hole and move-hole
> branches additionally write an 8-byte struct hole via "*newh = *h" at
> newh = thisfrag + len / 8, which can land up to sizeof(struct hole)
> bytes past the end of pkt_buff.  A single fragment with a non-zero
> fragment offset and the More-Fragments flag set reaches this path, so
> a crafted fragment received during netboot overflows the buffer.
> 
> [...]

Applied to u-boot-net branch for-main, thanks!

[1/2] net: fix out-of-bounds write in IP fragment reassembly
      commit: 04ca915d5bf39dda5d1bce62d04d2b59d293c5b9
[2/2] test: net: add regression test for IP reassembly overflow
      commit: 7946774a0feb40a4abc71e749e61071ffce56979

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>

