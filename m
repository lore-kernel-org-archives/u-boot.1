Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFC8C5B56A
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 13:39:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 769288112A;
	Wed, 12 Aug 2026 13:39:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 39APpbZYZqv0; Wed, 12 Aug 2026 13:39:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 96F1780FB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786541983;
	bh=44idAgkrurRqpwIRzjAendYMyTdgjZbLo6cmOYIwAIU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o8dLJHeePsLCSHlOYb5pr+lwg62POoMXg4cAnnwFkU8GmJHfht8ST6RNhQSRShIOo
	 y0e7hZjLQGxJtv5djzqvJmNvqKErZ1YwxLMYU7PsGoUt1doHGKBdIu3K0IeIyYsnWG
	 aSMh/eN11F56yWPxUvmv4fx4Hh9d1sAofpBsEuGl9MhSFsQarkQ66YwS02c8MvcNvy
	 kbU+fpvkB4Suac/Qf1JXRDfnEJg5xKulnu6v61tw4o7Ac1twSEDF1MdZIbh6Z/xonI
	 Egm+QzGZtYzhtz1UjG9Ymghz2A0dSkZY5WY6ujt2xBn+KafGaHKvKpo5uGFMNoUCYG
	 w4soKrjpncZ3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 96F1780FB5;
	Wed, 12 Aug 2026 13:39:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 37BA4282
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 13:39:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1D6EC80FB5
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 13:39:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FEV2hxCpASkO for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 13:39:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E230D80FA9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E230D80FA9
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E230D80FA9
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 13:39:40 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=K5Hofg5xpmwK5m8qUIqQLOBzjFvJ3l4e0KrtkRGDZb9X42SmrXeGeF2wjDCPvrZzuQgF3skT/YHXWjg3TBMDqDDQqEVNYzQYZv209wpA3HwZtwG8vNRCHTvjt3u9ztf2m3QLMZmfkZtGV03SVIroX8z4NTJ+71i5H3Yb83j6eii4AT+mCw+p2axFg7GGIDgS7OKHWq8rxIJ1vb/BXV2wPWuXX5rE/sTEkOC5PLZ4CH3ZUIPfYSa4hJHCqFfQI0ttHawJQxhb2BDqLDSZqRHuCEnDe14acK6QVD1idDzPGoI9MF/POFIuCQo4YBUWA6vU9axT1uvrXXxff64V0PSDiw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44idAgkrurRqpwIRzjAendYMyTdgjZbLo6cmOYIwAIU=;
 b=wFxCwWOe9P0FwELs0BN6fV78WgGMFhNmDv/PLVSd/jbiC16TsxSb3OJnb6qDQK6lu086gYhRQOET5I944xE5IOj00e6swPfUfLuYgi1cahFYC94LgOjLC16PAdk1DPNqeDAGC9Yg3hM2gj1NQ4LPcwF9LFcfoK79aL5xXABQH7FS6Jz7rHp3RUJfJSjDf/mWYuUoUpgIFu8Zes92+HmPm6lJjddyLDRZTbvNLAPC5S1eRSa7fgul2tX5wF5AFgg+iifXLAIiNL8anESpilcMQAaTNTyvNxGdC/PV7NRIM8Nz+KM6umL0l6c58sezzE0t5kBBBx171yJLAKr31/6HHw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=byteray.co.uk smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
Received: from AS8PR07CA0014.eurprd07.prod.outlook.com (2603:10a6:20b:451::11)
 by FRRPR08MB11968.eurprd08.prod.outlook.com (2603:10a6:d10:1ce::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Wed, 12 Aug
 2026 13:39:34 +0000
Received: from AMS0EPF00000191.eurprd05.prod.outlook.com
 (2603:10a6:20b:451:cafe::68) by AS8PR07CA0014.outlook.office365.com
 (2603:10a6:20b:451::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.11 via Frontend Transport; Wed,
 12 Aug 2026 13:39:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF00000191.mail.protection.outlook.com (10.167.16.216) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.6
 via Frontend Transport; Wed, 12 Aug 2026 13:39:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vwfOzR03nea/gmuIznfnZrM/moX2cPbNcgm9w8WqdL+Y3YDidrhGw//mb+85jTh4OZA7GzC+BYrKX5HcAjHCIPPse4ECSMSTbKy+FK1iJXYsnpd8UCqHN7NajFUbE0KAcFnN0/LifgXl+QsUmC4MLU05RT0a9vYFvujmN6krdMdq4VF3YXoeX/USXhBT7CIAA5sa1t5pdnegaik91VFCy/5KtJ25JP0hsg3a5BsssPgiOAWKGNHBt5f/kVqcX8hlgkMzFu2A1yDgC2vI6y/dOXn8H0VApC1FACeFjSfO13cJ0XqrbEoLf56BxudYbkYG0OQofoAFbv/0dSPRvKfxlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44idAgkrurRqpwIRzjAendYMyTdgjZbLo6cmOYIwAIU=;
 b=kaKYwc1ywvrUVXy/iDN0d3rir5qO09BzFQ837kgxDthnjbhtKlRvG3l7GttWsgYp0VVDXr7I1xi7/Hs54/o6/UxEsABoS3xoGsOYxsI40TySYYznZrjToV66F8dDWbnVelxpXOwaGNHnU07l4O9sPpKahvt5BavSlAlrnvX4WWZ/Ch7s1MOC4OZSH4j3Kkc6EzIBgLjk3kcxIAJU0mvHxiirZxzLZNi9zxooEu2XiSWAwlIf9YrzX8KE0y0SWRVTGu4Z8tgIaJX7t79/gA3Z5NhZP4Uq0LceLgVqwEJmQgCy2dj7dafT4WxDH44/7SYv2/zHs6S4byFF+yiXLpiLUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS2PR08MB9976.eurprd08.prod.outlook.com
 (2603:10a6:20b:646::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Wed, 12 Aug
 2026 13:39:00 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 13:39:00 +0000
Message-ID: <d8c2edf5-e0c1-481f-a2e5-7ae2cb869a63@arm.com>
Date: Wed, 12 Aug 2026 15:38:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] net: lwip: wget: free the transfer context after an
 aborted request
To: Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>,
 Argus <argus@byteray.co.uk>, nd <nd@arm.com>
References: <20260811-lwip-httpc-uaf-v1-0-9f0ba7331dea@byteray.co.uk>
 <20260811-lwip-httpc-uaf-v1-2-9f0ba7331dea@byteray.co.uk>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260811-lwip-httpc-uaf-v1-2-9f0ba7331dea@byteray.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P123CA0008.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::7) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AS2PR08MB9976:EE_|AMS0EPF00000191:EE_|FRRPR08MB11968:EE_
X-MS-Office365-Filtering-Correlation-Id: f7301ae3-2134-4fe3-3e75-08def8772557
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: kFyNZZr4gSmQCYqve3lWqxn7sKqlbKkPUQrPAUapZHVEU7xS0YTDxxVreVdvqbfZGyzRUeHx+Ls6CO1IHqmrFSTN8FtlRq610Q7Z6aU4/UPmbn60yrxNPLSgncdDX/UwioUHUXwN+cdQ6Ka/IVi6i0ZyK8odBMQ+9JqQLy6jcspaZSVM2Gsx9rJQNH3Wy0HaEo2LpDMb8P8L4SfcargM3LTLoP20dlIVBglAU86KGplLGNB+Trpyitn7cEPqXESovmqfKF/W4EU8C06UCg2uvHfm9ZHq1Tt/r8n7sJgCvmvOFM0uoKge/fF7ai7msIcUyjU/7HhrRKsjbm0yIWtxIxW5WMhdh6ggcEezzVsQHX6hv1/9WF4n9qq8osPl/yR8yw5u+vxJCEIO5yFqyLc4GQtB/6MqU7WGG75AJhq1wSxOcL0Sxya5HhilMDMweYZzefXHlg0awFlaPF0WKxhdVVpyV6V0FscRU1l70Yo7mYZcbIaFdcsuKUQuEvv+CJvH+SfH1tA3bkpgXthEanSbExV+fTCMtmV0ciusAnGrYnwjXMftE6Q7KNgwZ6qK/YyCNWx0yJN3caSw3WIfmhlL0AINDauof9X4GvrMNjpV9r/JNBwc4Rx4gDnPgbKhtxO0JOKW/QX9M+Tg6Qh7H68YX+Oi1oWQKTZCDuD+YX6kzTg=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: PIFeuiHHXDkPsAPkUFGw6j9muVWz2qJd1/Sp3mghbVdCdK94sn1To0MiQn9eqFfsiqFVeHaMlY2K1oHMVeReTm8lsUOFVjrr5hhMVEtvzr7u/onuFh/y5y72SCDTPpBJ1ZSK6FE+n1XisnggBau2F9Ulfy9E5AkNvdA2pt1Oc+5RjA80aJETOHP2vuiFRZVuMsUxV463AlR+6d4j0zcafm+McOwtSWNoTEOCpho67S6B6mWtfAgJd2wgPTZOwikPoPfvbWXD3gBdIxYa6/EA8IELL8MjdjdpEu2+/wxWi8fvMCUTHghBpGJDG7sej1XPbHk8N7/bKQsTfPU+HR5Ivw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9976
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF00000191.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 87af54bf-b1c6-419b-3d8c-08def87710c5
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|14060799003|35042699022|82310400026|36860700016|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: ihw0BebmcQ8tcn6OXSxQTcA+lL0a7RU6mwLtDcBN8JPzhEIXqznKKXT4VygvKeE57UcdZETuoHHs8+yXHBoM647sw+ctrlAICHH2WnU8dYxWaiM94FRlOs8/RAUUP9WR5LkwmGXYTUvZ8IAfdmSfwu9mwLYF1zdeYE+YNPYIwg3rrHtAuP39nKaImu1jojaqC7mrG/kozq6gAZfZ4iQqyoz8aWJWNlnwJK8836I4mx/N7I9VG8DUDXOG9HAlW08NY4hoOd5/UXt7HhOHenMHBzIDQoFe8claFWTmR1WECpTKuRHFIwIl6/fkweDhPXh5KpUHmyD0AE4HlCap56PnbPckQM/xKLq5YpP4xoGC2SIwvNWTm7pb9vyqGMH/20OEJC1E3CmFn8fyIFChE66ZACV+hztGGq/wE5YFmKZ6MA35wJZSGI056CpB0T9HCPXVrhJL1gqHMlhtBSbIPBu5T59LB6PpVkfLe5WSX0bmTJk/mPi35lVMEEQcmL/Wnt5z9sgsPnSKTE0BLQZMliPDID4HU9ornHKlS5qFbmDrsY2ffXp89kWZIWcEVezLI5CftaqmW+Ro1MhJ097BKI0puULDm68vDl704nhArMUXuwTm5B0CR+JvktWlayc040wr9E818cZAF/dT4x3ux8VB41YpfuzPTsPBvuOXxNfB48nfnTL4RqAKRMaMBKpAIoiU0rNvq4PrXq10cbyBV1d1UA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(14060799003)(35042699022)(82310400026)(36860700016)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5RlYtYhgdDrZP5mRQ9i+nJXXvmiT/r27edppdcgiyz3fa6Iqt4tH4s8UIDV1J4wGnSMj3iJYchJHhdpZFeRYI+dprw5cMcokjuKzgAjIHy2Z6gQkkPF/7+VwUoOOVGpI0VO2z4y/7/1sIGX6XaKEixpmFXRrz0naIp3TAFQLajgwD+jFX4YaQ+wehIKlTNx2syyhEvQFcDTKfZeXOtty6Fw8DmxmS5rt7SspMRPdqS97wGL03BckspOW1KAEU0FZum4vEFMaAd3HvQRdqZTS0N+yQJGl9L7597Im6F3ePXPUrAz6m/s8vI7N+ZYoNuAGDTKDOyB5tRBHCcK2gh2MX+ziNS5lWJgk2dxxsFz2krx+qCgoEb4PemDywMAAG/Z7kTAbeciTSlfJKYuBq3oAdZlasFf2Tmx55VOmlyD089q4mVjV90o5CORm6o/+13Jf
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 13:39:34.3459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7301ae3-2134-4fe3-3e75-08def8772557
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000191.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRRPR08MB11968
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44idAgkrurRqpwIRzjAendYMyTdgjZbLo6cmOYIwAIU=;
 b=HxOgViolCI2G4S7WVA0PQAoiR1FgI/437VJoW59etRAIfNrDqjQQyG8RSsq3jr5RKcvOE22wFq/f8m2slVy5oRVqpNdLPrqhApMC+SchDiGf3mY0ljVOa1V8ZPQcNc+HKGWzDWjoTnMuOaxflcb5y23KQYFPxRbIBJQ9f4lDZZA=
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44idAgkrurRqpwIRzjAendYMyTdgjZbLo6cmOYIwAIU=;
 b=HxOgViolCI2G4S7WVA0PQAoiR1FgI/437VJoW59etRAIfNrDqjQQyG8RSsq3jr5RKcvOE22wFq/f8m2slVy5oRVqpNdLPrqhApMC+SchDiGf3mY0ljVOa1V8ZPQcNc+HKGWzDWjoTnMuOaxflcb5y23KQYFPxRbIBJQ9f4lDZZA=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=HxOgViol; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=HxOgViol
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

Hi Shahriar,

On 11/08/2026 20:48, Shahriyar Jalayeri wrote:
> wget_do_request() keeps the transfer context on the stack and passes its
> address to the lwIP httpc callbacks. If the user interrupts the transfer
> with Ctrl-C while the host name is still resolving, wget_handle_request()
> leaves its receive loop without tearing the connection down. The pending
> DNS lookup (which lwIP cannot cancel) later resolves, the connection is
> established, and httpc_recv_cb() runs against a stack frame that no longer
> exists. It writes attacker-controlled TCP data through store_block() to
> map_sysmem(ctx->daddr), with ctx read from reused stack.
> 
> Allocate the context on the heap and add an 'abandoned' flag. On Ctrl-C
> with a request still in flight, mark it abandoned and hand ownership to
> the lwIP callback, which frees the context when the connection finally
> tears down; the receive, headers-done and result callbacks return early
> so a stale callback neither stores data nor touches wget_info.
> 
> Fixes: 3c656c928bd7 ("net: lwip: add wget command")
> Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
> ---
>  net/lwip/wget.c | 71 ++++++++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 55 insertions(+), 16 deletions(-)
> 
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index 9e93765926d..b81509dff3f 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -12,6 +12,7 @@
>  #include <lwip/errno.h>
>  #include <lwip/timeouts.h>
>  #include <rng.h>
> +#include <malloc.h>
>  #include <mapmem.h>
>  #include <net.h>
>  #include <time.h>
> @@ -39,6 +40,7 @@ struct wget_ctx {
>  	ulong content_len;
>  	ulong hash_count;
>  	enum done_state done;
> +	bool abandoned;
>  };
>  
>  static void wget_lwip_fill_info(struct pbuf *hdr, u16_t hdr_len, u32_t hdr_cont_len)
> @@ -200,6 +202,13 @@ static err_t httpc_recv_cb(void *arg, struct altcp_pcb *pcb, struct pbuf *pbuf,
>  	if (!pbuf)
>  		return ERR_BUF;
>  
> +	/* The caller gave up on this request; drop the connection. */
> +	if (ctx->abandoned) {
> +		altcp_abort(pcb);
> +		pbuf_free(pbuf);
> +		return ERR_ABRT;
> +	}
> +
>  	if (!ctx->start_time)
>  		ctx->start_time = get_timer(0);
>  
> @@ -227,6 +236,12 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
>  	struct wget_ctx *ctx = arg;
>  	ulong elapsed;
>  
> +	/* Last callback for an abandoned request: reclaim ctx and stop. */
> +	if (ctx->abandoned) {
> +		free(ctx);
> +		return;
> +	}
> +
>  	wget_info->status_code = (u32)srv_res;
>  
>  	if (err == ERR_BUF) {
> @@ -282,6 +297,9 @@ static err_t httpc_headers_done_cb(httpc_state_t *connection, void *arg, struct
>  {
>  	struct wget_ctx *ctx = arg;
>  
> +	if (ctx->abandoned)
> +		return ERR_BUF;
> +
>  	wget_lwip_fill_info(hdr, hdr_len, content_len);
>  
>  	if (wget_info->check_buffer_size && (ulong)content_len > wget_info->buffer_size)
> @@ -376,8 +394,17 @@ static int wget_handle_request(struct wget_ctx *ctx, bool is_https,
>  
>  	while (!ctx->done) {
>  		net_lwip_rx(udev, netif);
> -		if (ctrlc())
> +		if (ctrlc()) {
> +			/*
> +			 * A request may still be in flight (e.g. the name is
> +			 * still resolving). Hand ctx to the lwIP callback, which
> +			 * frees it once the connection tears down, instead of
> +			 * freeing it here under a live callback.
> +			 */
> +			if (!ctx->done)
> +				ctx->abandoned = true;

One more object seems to have the same lifetime issue here: httpc_connection_t conn is
stack-allocated in wget_handle_request(), but httpc_get_file_dns() keeps a pointer to it
in the HTTP client state and later dereferences it for the headers/result callbacks.

So if Ctrl-C makes wget_handle_request() return while DNS/connect is still pending, ctx
remains valid but conn does not. Could conn be moved into struct wget_ctx (or otherwise
made to live as long as the request) as well?

>  			break;
> +		}
>  	}
>  
>  	if (ctx->done == SUCCESS)
> @@ -392,27 +419,26 @@ static int wget_handle_request(struct wget_ctx *ctx, bool is_https,
>  int wget_do_request(ulong dst_addr, char *uri)
>  {
>  	struct udevice *udev;
> -	struct wget_ctx ctx;
> +	struct wget_ctx *ctx;
>  	struct netif *netif;
> -	bool is_https;
> +	bool is_https, abandoned;
>  	int ret;
>  
> -	ctx.daddr = dst_addr;
> -	ctx.saved_daddr = dst_addr;
> -	ctx.done = NOT_DONE;
> -	ctx.size = 0;
> -	ctx.prevsize = 0;
> -	ctx.start_time = 0;
> -	ctx.content_len = 0;
> -	ctx.hash_count = 0;
> +	ctx = calloc(1, sizeof(*ctx));
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	ctx->daddr = dst_addr;
> +	ctx->saved_daddr = dst_addr;
> +	ctx->done = NOT_DONE;
>  
> -	ret = parse_url(uri, ctx.server_name, &ctx.port, &ctx.path, &is_https);
> +	ret = parse_url(uri, ctx->server_name, &ctx->port, &ctx->path, &is_https);
>  	if (ret)
> -		return ret;
> +		goto out;
>  
>  	ret = net_lwip_eth_start();
>  	if (ret)
> -		return ret;
> +		goto out;
>  
>  	if (!wget_info)
>  		wget_info = &default_wget_info;
> @@ -422,14 +448,27 @@ int wget_do_request(ulong dst_addr, char *uri)
>  	netif = net_lwip_new_netif(udev);
>  	if (!netif) {
>  		net_lwip_eth_stop();
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto out;
>  	}
>  
> -	ret = wget_handle_request(&ctx, is_https, udev, netif);
> +	ret = wget_handle_request(ctx, is_https, udev, netif);
> +
> +	/*
> +	 * If the request was abandoned the lwIP callback still owns ctx and
> +	 * frees it when the connection tears down; do not free it here.
> +	 */
> +	abandoned = ctx->abandoned;
>  
>  	net_lwip_remove_netif(netif);
>  	net_lwip_eth_stop();
>  
> +	if (!abandoned)
> +		free(ctx);
> +
> +	return ret;
> +out:
> +	free(ctx);
>  	return ret;
>  }
Thanks,
-- 
Jerome
