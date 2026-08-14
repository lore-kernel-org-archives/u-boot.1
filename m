Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF4F4C5CFCF
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 14:29:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C2DE80DDC;
	Fri, 14 Aug 2026 14:29:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K5P-F-E4GZWe; Fri, 14 Aug 2026 14:29:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2A45180D86
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786717749;
	bh=dIcbggBH1yozrzZ8EBiGDkcoqrPRBBQ6tqQZCHaipO0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qt7fB7nBZa544hPngrxPcIqvwhvZRWiSUAUW1zeT4MoAsoNzBhknvYo69an8E+hMx
	 VnNLrUWo3yGeaE0Am4JuVMUiJmKfjtGb2N6o4Gr24mugA4xd8kF6OiW5ipZDz/zLgK
	 0poNJDPFGBgkOo2klsYC5PtebmhWMMp+d5vzPwRZUSZAz2bvHLs9Lw+fLMI4Z8xtZM
	 NTrhC6Y6J+ufbFXBC97GUBCU6kGppIKYqoLnvNiQtRj+UlQFzt1H/y4AV5rQegJhvt
	 vutHK67GB1327ebFZ3LzFv6s3qVZuvzSgrxnIbDM3a3nMOQ7KQ+CWC7RNSpzJFkJ+s
	 Flc/Q1BvOOcuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2A45180D86;
	Fri, 14 Aug 2026 14:29:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5CEC83DF
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:29:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 42F3160896
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:29:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HSs-uEW17yh0 for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 14:29:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org BF7BF60834
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BF7BF60834
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=rX2XzvRa; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=rX2XzvRa
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BF7BF60834
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:29:06 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=JLJZMLdsUoEHk8hdmvEduEf8lJVSpzGn6JmIJuqykC+glizzlpK/fE/wHtPXpc9WX1jhCQOCaIqp0URk2yJuOkkmx/Z3ZP0970ovAaRQMhCFpdMnImR8Q3gBAu+zeoMTkkfelLbaxPK+aFXuXbvISzJiMVi2CvWkqbIjA4CD69L8Vq3ZYNQRFwb+iJQN1zDw1X+ooLJQkAUneBKcEKz3Uo0s0jfBI4AL+PUk6e3FWKanrrLcJv2P+W5DA9obLCds/1WlsasTm9lmfIHjMo/gF5BiUms+aKQKI1sKdjlmdC3otlsNTObgM7qGFTytAZWxdX6/9n1IH388Ya6y/mpVbw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIcbggBH1yozrzZ8EBiGDkcoqrPRBBQ6tqQZCHaipO0=;
 b=w3R9+dCHQ8qP8l/3fL4L+DyBhpOzY+Gp1MyFWTCgSHO8F13usOxfmYJZcYxFtpYkr1h7HphMwD3CcjYrzpqzGKn69eWm3M9053YHd+cfaQc/N35AYzyxI6UMx06+vbtKsLTW+ZR1DIsX0EMAo5JzAF96ILElBndyNCyGVwlVjukFx2hqWvmpFdCmeJj2ZTBAu04AmCsG26d4w3Gj/fnUMnc/+BPs6DoBtwxECj//gsd8fNzsrqvi6Xxkzsw4708+EMoCo+7TmNO5+3V3zfUI2MTse+mE7Zu1oShgVIYC1BqNK+HzxFrg8KgbHURfL8Gzoq29O7mEovNnllJNABkuKw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=byteray.co.uk smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIcbggBH1yozrzZ8EBiGDkcoqrPRBBQ6tqQZCHaipO0=;
 b=rX2XzvRaW5AsUYAqS4nOCYKm10QlJ6NgQ0so1S9yiF97LdACQZetLWqTnLfXbDYKRQbpoIia0eufB9Tq8+HkhuADGll+dFGk3rPs0VbQb8XJQYCLBAoxutMfgyvTdxcW6FhEPZVK4gKOYcxRX3c7K/TPhinz5YCO6A6tw14MFwo=
Received: from AS9PR06CA0353.eurprd06.prod.outlook.com (2603:10a6:20b:466::30)
 by PAXPR08MB6416.eurprd08.prod.outlook.com (2603:10a6:102:152::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 14:28:58 +0000
Received: from AM4PEPF00027A64.eurprd04.prod.outlook.com
 (2603:10a6:20b:466:cafe::13) by AS9PR06CA0353.outlook.office365.com
 (2603:10a6:20b:466::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Fri,
 14 Aug 2026 14:28:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A64.mail.protection.outlook.com (10.167.16.75) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3
 via Frontend Transport; Fri, 14 Aug 2026 14:28:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w2Zeho2S6nRvfRnfTRukwOmibrMMIzQBD3p1L93I2ze+SEp1MQJxWuj/sJbGHaC0/k7BDc+4gm+2+x1omSHNOQ7RFGwiDGi6QbZO3BLVS2eIl7SiTHEEp5/NLmf2Aq0hUpSjGlpfxyylHVKk+Bq0LSv4CmTOgRIlJ1KVbmXRpwzTkgMdk0Kf+BZFkJdiOZJawy/XDjIThxWfamndXY1MXRHeSpMqIg5VClX7u/ezzHzeN1w7ymgPhsJ+wdL6eufhjd1OTFmYYWaJu3eqwC5sAQS3cuFdSLgwKV7ucfWzVdaJBgsx7yS0cFGA6bVMygWr6Q00LITfhukRcVP5Jvd4ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIcbggBH1yozrzZ8EBiGDkcoqrPRBBQ6tqQZCHaipO0=;
 b=IORz/1LZJO3gwuYH+RlkCIvPj1iQHuTPoCWAcxMOYIzGIbNEu/imJgrDdVZmvgqQZuHz0pGi4Zg+rmAlvIAa3y3mdhHdCZ1BpCN1e03zbqSi/sPiFoYlyQ6uhlDAqY5dc0Xr3fCm5qXmpNCJTrne+zbR3Khh8YH7E46y9F4z5BOaUTWEg1aKZUP62zNMyhwSQJQEXXH4/J8ECqh/+g3ta1brzU74hV9MC3EbkCI6lpA3bxN8VSNyZ/UHPs/Ra61aKgfTtKZYkt48QyMcp3FrBvbX9q5f4VF93q6XxQ50cskvtaqlg7vzpJ69tnJqrBWCv7iMUGiMQ3m3NDeygYfOcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIcbggBH1yozrzZ8EBiGDkcoqrPRBBQ6tqQZCHaipO0=;
 b=rX2XzvRaW5AsUYAqS4nOCYKm10QlJ6NgQ0so1S9yiF97LdACQZetLWqTnLfXbDYKRQbpoIia0eufB9Tq8+HkhuADGll+dFGk3rPs0VbQb8XJQYCLBAoxutMfgyvTdxcW6FhEPZVK4gKOYcxRX3c7K/TPhinz5YCO6A6tw14MFwo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS2PR08MB10153.eurprd08.prod.outlook.com
 (2603:10a6:20b:64c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 14:28:24 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 14:28:24 +0000
Message-ID: <7d18b896-cf1b-4953-a513-b9ea53ec86e1@arm.com>
Date: Fri, 14 Aug 2026 16:28:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] net: lwip: wget: free the transfer context after
 an aborted request
To: Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>,
 Argus <argus@byteray.co.uk>, nd <nd@arm.com>
References: <20260813-lwip-httpc-uaf-v2-0-1c3f0b3aa1eb@byteray.co.uk>
 <20260813-lwip-httpc-uaf-v2-2-1c3f0b3aa1eb@byteray.co.uk>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260813-lwip-httpc-uaf-v2-2-1c3f0b3aa1eb@byteray.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0252.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::23) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AS2PR08MB10153:EE_|AM4PEPF00027A64:EE_|PAXPR08MB6416:EE_
X-MS-Office365-Filtering-Correlation-Id: 6441f7da-6db2-446f-ff68-08defa106039
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|11063799006|10067099003|5023799004|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: 3hNdgrJe2CDGmyD2joEhheH0NEJM/cdyDfnr83itXtnPHIFgzH/aR56zbEfubr3ojcW3oAatb+2GQQBkzfTN0SVj6q6WEg+1bThy0FPNIW5usSjNgpc6Gn//AkoJrBpTAWFAHuHMCyv9h+vZewO4YGKNSkYo4HKdH8U91iDv+bwJmLcpoiNpLfV2bqSaWyqshsMZaMCcMBVR2CgWnDP4082NAIehLSwwjUDecRx9O/DvsmxrQRaTEmI/pCG2QLCI2DMOSSNPMaRm+bF8Hmany8yFmnHjKijmItpb4xfYRbruGzqBoBvk+Y6axTJ29vPgIHNlMqtBe78fMtmbOl5mvrl0JZo/VI/cFEBlgCNMC6MILXFhBNwiZduxZPkXhAQGXzNM06UV4YnfHpE+5hxJv6zpCzPpvLNkh66aoCyla5a6lDhWb6qLAXEJO38kve5aPQd9LsES3B7DVa2LmfXsx1XWIzkrP2n8q3YaiS0F9YL9KnUbuDSsfJyT4pHQNdcjjWZobEcCY6EKwQ0XgY5+19X1u7XnG7d3cDGNQNGxXAalKiV2YN6NFUvFfE+EXMflWSbZCAfdplSt/U3o/nCGLOC7b9pJ9YzxVftbgJXfSPMvSQ7aE8w6pCCAMuuyqhXAJilR4iLz9B53L/6hCtml1t2xNGBgWtMu4mcQ3nqWxPs=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(11063799006)(10067099003)(5023799004)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: XFbbhswkc9Gkyye/BrNA6F6yxsNDWxk4IlcfWah38EB5+2YIVDlC7dSeH99ePWZG/T3iYcddTg+NOjzDE60SyDXjNLewqv/b35jf4X/Qu/WK0FJBOZ+hxOisK25PlY02yd4GBEhJZkxdzLmyTb1LkGzQhc8PXW/cOoqtpJjD8MFi2ichHMbi+nLf2ESJthD8iS6iQP+goT3QK4FwH65I0wd2946d9jA/vvMYgjk19x+nKrtRY4Fzjfd/xBVfGqbh+5e6Ts1prYLF221oAOT0/vieAzptlvdhFnVQTHn3WSkPUIclF4TYQq6XkFTgRwWx/CjMRQiKEdZ9d6bQmYSccA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10153
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM4PEPF00027A64.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 57c7cafa-6683-4835-2270-08defa104cb4
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|36860700016|23010399003|35042699022|376014|82310400026|1800799024|4143699003|10067099003|11063799006|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: RNg+/xJo4MQ6hD9zQ7IHXYwuSCn+XIOhLWZhkckHwB2mGXbB/wWCacqcvZ05XvsK/PjsA0ZxiYUk8eBRhDxEu6pbBNxd8aPqOA6OSYbaaXhzoZR4TxgF4FqKipsqsOJjzvB6AFgpn6mBLWwP12xGr96pPbm1f2qRMBh0OPQOatlvghVd57gL4f7J7XoWnQuiWayqT3loz8tpHr+4HI0JNcfmQIN0wAPprAZMcZaEkXTfdH3M3JpKK9kOsC4t6fCt/hXosAbBUkGEdf851N+JW6wcYSHJeRjYX3gHTt7oDQENXsgJFpqJDUk2JL7TMF2KxUGDBiBpmM8h6enTTRzV6+VuTQy0X+ZTuCHHxYv8xGpzucKxXfUHPACC8D79QFC3bRtrISDVcfXCsKTa6UBlEJyj8R6CvJwKCVOHCRIESvtCsZSipy8w83Y09JLsJcov0eqMPZUdh6WV2DwAfk0l7UOiJ7Gl+1TDrlKqsqey0GPsNW5v9zdpNQOKue1ILBf/DS8ZQv7rizdhMw+69GPRuil2SO2d4HVTyH4uOKrcbPXMw7wEqtkbmhzudOv9PhTebEwH5qbJlGFQFG4yeYAHNVB6SoJXjYUMQxtsgjZAkNvr7MUb2p/zGAtFoF13pZOOvoBjBL+Zzl6vk2fzFxjt2G/LNQbwn60U8fjnxSpvzG+PIHsh1lFOixw1FTJ7Beic7Tlz5x1sqmzWirWIYeKKtw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(36860700016)(23010399003)(35042699022)(376014)(82310400026)(1800799024)(4143699003)(10067099003)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cAFPqIfP8QQCNLypd8KMg2iZz54DUzfflohi677LkxqaXURRj5XqDIY80tX6ktCMODC5GVhpfW7XcZyjb+moXDYx309RwQ9L5iy096UmjCwWiCtE2anctIfmPYX1g15rD5ulxVBHk/0/QjuMJ8iTXaRsti3zi+0Nhthsjb8EEDp1KZ0kj65BGWEPcxZhFR5C7NUyodqzphJIW3qLpe4yRkLhFWpkTKzGnAQz+arTzspIKK4HFdIek4FEMf1HmruICRFPZRmXjjBwLRzNjRnc5nTj2nkRoNP+5azoTSnZ1OU2Jdg0sa9FXIgbGkqsCsTE5gA8VXwXrn+9IQPlx+vzAbtjQ1TYOSJ6VWfFSP5eGjTiHZnhhvJh0EYsNfRlPUYJnYf+z9ZSnQ3J6+nhZaH2rDVQtIZJigxblWP7sSaOBRyhRO01czFDVEzSK0h6ScPy
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 14:28:57.3037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6441f7da-6db2-446f-ff68-08defa106039
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A64.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6416
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

Hi Shahriyar,

On 13/08/2026 18:28, Shahriyar Jalayeri wrote:
> wget_do_request() keeps the transfer context on the stack and passes its
> address to the lwIP httpc callbacks. If the user interrupts the transfer
> with Ctrl-C while the host name is still resolving, wget_handle_request()
> leaves its receive loop without tearing the connection down. The pending
> DNS lookup (which lwIP cannot cancel) later resolves, the connection is
> established, and httpc_recv_cb() runs against a stack frame that no longer
> exists. It writes attacker-controlled TCP data through store_block() to
> map_sysmem(ctx->daddr), with ctx read from reused stack.
> 
> The httpc_connection_t passed to httpc_get_file_dns() has the same lifetime
> problem. lwIP stores a pointer to it in httpc_state_t.conn_settings rather
> than a copy, and dereferences that pointer later for the result and
> headers-done callbacks, so an abandoned request reads its result_fn and
> headers_done_fn from a stack frame that is gone.
> 
> Allocate the context on the heap, move the connection settings into it
> (along with the TLS allocator the settings point at, so nothing lwIP
> retains points back at the stack), and add an 'abandoned' flag. On Ctrl-C
> with a request still in flight, mark it abandoned and hand ownership to the
> lwIP callback, which frees the context when the connection finally tears
> down; the receive, headers-done and result callbacks return early so a
> stale callback neither stores data nor touches wget_info.

The problem I see is that this relies on a later callback to reclaim the
heap context, but that callback is not guaranteed to run, especially once
the command removes the netif and stops the device. That fixes the UAF by
extending the lifetime, but can turn Ctrl-C into a leak.

I suggest cancelling the in-flight lwIP operation before returning from
wget, while the stack objects are still valid. That likely means adding a
small DNS callback cancellation helper and an httpc_abort() helper, then
calling it on Ctrl-C and freeing the TLS config before returning.

Thanks,
-- 
Jerome 
> Fixes: 3c656c928bd7 ("net: lwip: add wget command")
> Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
> ---
>  net/lwip/wget.c | 95 ++++++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 67 insertions(+), 28 deletions(-)
> 
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index 9e93765926d..7359094f6be 100644
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
> @@ -39,6 +40,11 @@ struct wget_ctx {
>  	ulong content_len;
>  	ulong hash_count;
>  	enum done_state done;
> +	bool abandoned;
> +	httpc_connection_t conn;
> +#if CONFIG_IS_ENABLED(WGET_HTTPS)
> +	altcp_allocator_t tls_allocator;
> +#endif
>  };
>  
>  static void wget_lwip_fill_info(struct pbuf *hdr, u16_t hdr_len, u32_t hdr_cont_len)
> @@ -200,6 +206,13 @@ static err_t httpc_recv_cb(void *arg, struct altcp_pcb *pcb, struct pbuf *pbuf,
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
> @@ -227,6 +240,12 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
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
> @@ -282,6 +301,9 @@ static err_t httpc_headers_done_cb(httpc_state_t *connection, void *arg, struct
>  {
>  	struct wget_ctx *ctx = arg;
>  
> +	if (ctx->abandoned)
> +		return ERR_BUF;
> +
>  	wget_lwip_fill_info(hdr, hdr_len, content_len);
>  
>  	if (wget_info->check_buffer_size && (ulong)content_len > wget_info->buffer_size)
> @@ -299,10 +321,6 @@ static err_t httpc_headers_done_cb(httpc_state_t *connection, void *arg, struct
>  static int wget_handle_request(struct wget_ctx *ctx, bool is_https,
>  			       struct udevice *udev, struct netif *netif)
>  {
> -#if CONFIG_IS_ENABLED(WGET_HTTPS)
> -	altcp_allocator_t tls_allocator;
> -#endif
> -	httpc_connection_t conn;
>  	httpc_state_t *state;
>  	int ret;
>  
> @@ -313,7 +331,7 @@ static int wget_handle_request(struct wget_ctx *ctx, bool is_https,
>  			return ret;
>  	}
>  
> -	memset(&conn, 0, sizeof(conn));
> +	memset(&ctx->conn, 0, sizeof(ctx->conn));
>  #if CONFIG_IS_ENABLED(WGET_HTTPS)
>  	if (is_https) {
>  		char *ca;
> @@ -351,23 +369,23 @@ static int wget_handle_request(struct wget_ctx *ctx, bool is_https,
>  			printf("WARNING: no CA certificates, ");
>  			printf("HTTPS connections not authenticated\n");
>  		}
> -		tls_allocator.alloc = &altcp_tls_alloc;
> -		tls_allocator.arg =
> +		ctx->tls_allocator.alloc = &altcp_tls_alloc;
> +		ctx->tls_allocator.arg =
>  			altcp_tls_create_config_client(ca, ca_sz,
>  						       ctx->server_name);
>  
> -		if (!tls_allocator.arg) {
> +		if (!ctx->tls_allocator.arg) {
>  			log_err("error: Cannot create a TLS connection\n");
>  			return -ENODEV;
>  		}
>  
> -		conn.altcp_allocator = &tls_allocator;
> +		ctx->conn.altcp_allocator = &ctx->tls_allocator;
>  	}
>  #endif
>  
> -	conn.result_fn = httpc_result_cb;
> -	conn.headers_done_fn = httpc_headers_done_cb;
> -	if (httpc_get_file_dns(ctx->server_name, ctx->port, ctx->path, &conn,
> +	ctx->conn.result_fn = httpc_result_cb;
> +	ctx->conn.headers_done_fn = httpc_headers_done_cb;
> +	if (httpc_get_file_dns(ctx->server_name, ctx->port, ctx->path, &ctx->conn,
>  			       httpc_recv_cb, ctx, &state)) {
>  		return -ENODEV;
>  	}
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
>  
> 

