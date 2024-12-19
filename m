Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55666E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 16:04:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C04CB8021A;
	Thu, 19 Dec 2024 17:04:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="P62RqBzK";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="P62RqBzK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EF268022B; Thu, 19 Dec 2024 17:04:26 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::621])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8855380077
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 17:04:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Harrison.Mutai@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=XXoWwSlyglg9yXNFRgsOWwS0uQpbbNY85940kTIS600iJmutkcNH59S3a3MiPvP4ap4NinXD/rANJiHyjwbkUp+S7hUgwms0N+67MiqAyR+vrKOw0d/YYHqCzEthcv/X1zj1qtzXhJxH6R/I6sV6OiiicuM1PGwj4Uv2I//c4h3eVLUocQlkIP/UcebfkfHsS1S10yVnURZ+7BCmlWu788ck2ZwzEVXagqLSN2autcSYjoOME7bMnftGTbBd9cCx10hJY5+xpxUURJWM8ZXTti3ai7c7QMD5j6vL/NDLRu+BVPBK17+T3l5NlCEjRvEPYeUeT7mUnolkL0aizNJOLQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XssrC5hRyjA+FVExa3runyTJH79Qcg+Z70fUM33EREc=;
 b=he+6zBBro7HWUoeTFgQz9PC4KMOTuGncwN+op3P9aSYRpLPC1lms8h3gTs0skIQuuOpUemogxzrIgIPDVupsxpvvHN7nSqXtBDR3bS/Th8OOHUddyWKYBRPRGg1qgPFeW3BIVle6REsUi0VsRqL2n8B7HWLb95pyOoCz51cNZ0xPtGtXsz4hSWiw3p8Eit9QI1/zhnUE5WazxIaFsp9pglD9FGaADJf+GQBI97nixxZhHTF9FDE6tjZkrvoA3y+b5K9YMtyIl6kFpBG8MeMLtZB+aIcGLjEFYqCs/11HpQphUV9BFEe5TbnbdSA95mnrCxqAjudT/GL3WdUfPfSKMA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XssrC5hRyjA+FVExa3runyTJH79Qcg+Z70fUM33EREc=;
 b=P62RqBzKZ5CoRc4fr7lANm1e+MKr21oyuzXge2NejhMhwcwwTbkYAgfKjri7KspuNR1JypWyupWrC3pvmeqW/2+6gsgkQT9Fo9faGY7Ho2DEeQ5NT/2YXjWPp3WJ8rBDBxRP14oToyjwJSVBdhWUiC9AcPJdDw1003wm1+2kFWE=
Received: from AS9PR06CA0033.eurprd06.prod.outlook.com (2603:10a6:20b:463::25)
 by GV2PR08MB8510.eurprd08.prod.outlook.com (2603:10a6:150:b1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 16:04:19 +0000
Received: from AMS0EPF000001A3.eurprd05.prod.outlook.com
 (2603:10a6:20b:463:cafe::54) by AS9PR06CA0033.outlook.office365.com
 (2603:10a6:20b:463::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.23 via Frontend Transport; Thu,
 19 Dec 2024 16:04:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF000001A3.mail.protection.outlook.com (10.167.16.228) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Thu, 19 Dec 2024 16:04:19 +0000
Received: ("Tessian outbound a83af2b57fa1:v528");
 Thu, 19 Dec 2024 16:04:18 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ba84f7e36bdbbea3
X-TessianGatewayMetadata: RPgLR+mh9s+szEtAzgCuIsOD1I/AfDsyhK3guIIzrjdjEESNkWzmEgEeYro0u55fVaYsFtOsbpUDLNZ5bgrTMvpoVAU08GOM3Tc2/3g2aKy2xjXpyJp+Co0h6wtAlTcJQlUmb/AjxFtyw347BB7CJmvGxeNFYks7I9xz7wmJK5s=
X-CR-MTA-TID: 64aa7808
Received: from L2de8fe6551de.2
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 8ADDFAF3-2FC5-4FF8-9A5C-C0FD1AF23B26.1; 
 Thu, 19 Dec 2024 16:04:08 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id
 L2de8fe6551de.2 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Thu, 19 Dec 2024 16:04:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6ohsU0Bx9zpYQY1XOzNeqmJVQ5I397NUkdCy7EcQ3NcLvPSDtMHkrOFRHfyDr1MLq/H6WSi8PGVnm1XTIJ/yj9vIvgwkEw/PwccWGtFeH2Mdaz9bJ+3Ok3PfdLsdgX2Xt0RaDUzPsJDnfbl5VE6d9au6v2+PS12qadE75qlsyXa1Z/+OAAgGWyOSnmLyLSJV6GHEyyjYs2aVSoozGU8qfS3S84wqFI1N11r7VoMeVvhMsGF2CS55Ozp5p+T/IMImAsjlwncGhO1qxZs/xaz45ppxhm5S6EszOQQdpBYauCs2lDR6SiKy5MrihXBVwumFvZr9wnwPJWvc++Q7j9C0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XssrC5hRyjA+FVExa3runyTJH79Qcg+Z70fUM33EREc=;
 b=reMIf7HZHfymcbyeyMC6iN/Xyv+4gRN/YKvTGC9oMTXtPn2gmJrTB5fz0Dvw6G0fW95Frffthg0M/2Yz9DAavnQH6U6MvUr6HvyZfJnl1HqWCGnoxxX8YPoQXgBLBV+42bnvV5JTTVMEksLqcMGI1ONSMo1Zd0DiQ2rW92EGkM4HNMKqtRawRkk8jSgIGxHyQpBNDwm5uxEMiiTog41q+nSYuhqLQ2B9h15rHNWHOYxrJsqSbz8C5ZvS6N34ok76R/I0HF10zczRMs1JneQTLLjK/WtqCoX6rh1HcoChXybdGv38bvcUrRZwoVk/CT2ay/h+aLI1GOiG5Jy4HTKpCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XssrC5hRyjA+FVExa3runyTJH79Qcg+Z70fUM33EREc=;
 b=P62RqBzKZ5CoRc4fr7lANm1e+MKr21oyuzXge2NejhMhwcwwTbkYAgfKjri7KspuNR1JypWyupWrC3pvmeqW/2+6gsgkQT9Fo9faGY7Ho2DEeQ5NT/2YXjWPp3WJ8rBDBxRP14oToyjwJSVBdhWUiC9AcPJdDw1003wm1+2kFWE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DU4PR08MB11188.eurprd08.prod.outlook.com (2603:10a6:10:571::11)
 by PAVPR08MB9675.eurprd08.prod.outlook.com (2603:10a6:102:31e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.12; Thu, 19 Dec
 2024 16:04:06 +0000
Received: from DU4PR08MB11188.eurprd08.prod.outlook.com
 ([fe80::5926:9f0b:ea5d:24df]) by DU4PR08MB11188.eurprd08.prod.outlook.com
 ([fe80::5926:9f0b:ea5d:24df%6]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 16:04:06 +0000
Message-ID: <8eaca7d1-2cce-475f-93c1-4023ea30a843@arm.com>
Date: Thu, 19 Dec 2024 16:04:04 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] board: vexpress64: enable bloblist for SPL handoff
To: Tom Rini <trini@konsulko.com>
Cc: David Feng <fenghua@phytium.com.cn>,
 Linus Walleij <linus.walleij@linaro.org>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Liviu Dudau <liviu.dudau@foss.arm.com>, nd@arm.com, andre.przywara@arm.com,
 manish.pandey2@arm.com, u-boot@lists.denx.de
References: <20241218153933.37649-1-harrison.mutai@arm.com>
 <20241218153933.37649-5-harrison.mutai@arm.com>
 <20241218163126.GG1505244@bill-the-cat>
Content-Language: en-GB
From: Harrison Mutai <harrison.mutai@arm.com>
In-Reply-To: <20241218163126.GG1505244@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0279.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::14) To DU4PR08MB11188.eurprd08.prod.outlook.com
 (2603:10a6:10:571::11)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DU4PR08MB11188:EE_|PAVPR08MB9675:EE_|AMS0EPF000001A3:EE_|GV2PR08MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: ded8c614-dc26-4f69-59e2-08dd2046cbb2
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?Y1lTWkowdTFKeE1vNS9NSW1mby8rTFB5YzRPeWpqemw2VmhrNEx0dGhLNXg1?=
 =?utf-8?B?NFprLzZGNThIZ2NreXJQcm9OTGRrd3d3cS9JQjFzUHVQL2RaTk1uSTR1TDRo?=
 =?utf-8?B?RC9Ndm0yYktINGxhUTFFeTR6bXZsbjlqUFM2QXkxZklqQUpPakw2d2VzSGpC?=
 =?utf-8?B?UGhCWjRqMG9NOGRoenN5L3YxSzFiOHBGa3dYVlVYSFlQV21GZTJFcGxlSmtT?=
 =?utf-8?B?Sk9KZ1Jtak15Y1h4MVd1TVlvcW40MmRTRVNnS0pQeDc2Q0NBVDJNZUl6NTFT?=
 =?utf-8?B?RDQvRW4yUGtKWE9IU2laZWFZMGpQQjh1aVNxZi9Tc0xyc1pXMitCNzBMWUhP?=
 =?utf-8?B?UzNHWkl6dk5WbWd6d283cWdOZ0RKeFBCNkEya1pSc2h4YU9iamg4QzBXU1FZ?=
 =?utf-8?B?WjVKK2FZd29uTjFraHdrUXFRUjQwZXYyZGZndXg3M0t3TmpKZnJDRHprTis3?=
 =?utf-8?B?dVNja09hNjlFK1c2cy9ZeFpkRHE5OCtYMHA3NG55cmFTTzBRRGVzZlcyenVR?=
 =?utf-8?B?b0w3TFRpaUpWZy9VUmxodlNUTGtFZ0tWNVhKY1FVSnRLSzZ5MU1RSWxDSDY5?=
 =?utf-8?B?TmNMOTZ4ald6c1V1WnpOSG1wNjdYbkVKSzlUZlBmV0RyVWdLSFJSTUlKcFVK?=
 =?utf-8?B?THdFTzNMMk80N1g2NXgyZ2NHcmRMU3RYbGFNaEYzRDBOMUpQRkFHektMUUtq?=
 =?utf-8?B?WERicFIzdDB6SExhSndQeHhWcU8yWmU2R2VYVFJsZHZyaHFKMnV0VVFmdE1H?=
 =?utf-8?B?Rk1rN1h1eUVRUW1mNXBIbGRVS1RiYnZDdUdrcjVqbHJ1MmFQSUJIbzlpNnNV?=
 =?utf-8?B?NjlTQUxKdEhXOVRxamF2SDhwYStUcFJndFZ2eXZYRnJTK0NGYktpbFFIbHNJ?=
 =?utf-8?B?TEVBRXUrYjM1My9sQ25NNnU3VS9ueGtCZjMxcS84K0VaWVRLVkxuL3pnaTVG?=
 =?utf-8?B?ZDVFd0wvdkJyeVBYTzQwV0kyT1hGei9JME45UTlmbkQrTTNDNWFEVThxR1E3?=
 =?utf-8?B?Zkt3QitPUzJndWhHc2FUa1hJb0Mra0RFZDU2a0h4R3JMellrTzJhV2hadFor?=
 =?utf-8?B?T21TQVBCdkVONDlJUmFTSDRQbE9LbytQS1U5NmpXbkdkSHFpOFNuUkxQUXBs?=
 =?utf-8?B?SUdoR3c5M2EvdjJTcUg0djRSQlhQdjd0cHhYRVVYcnQ3MTdpZFU0c2FPdTR3?=
 =?utf-8?B?MFU0SjFPL0MvLzFNZExVVHZDdDA5UkVCTmt0T2ZEUWtQUWVucmpodlNMWStU?=
 =?utf-8?B?Q09DQXdEM1BHMlpQaTg0bkpQbG11L09VdkJRMzZvbGc5THBkZG9jay8yMXR0?=
 =?utf-8?B?dElkVmt5Q3ZJVkxaRnllaU1kc1hTakYzYlhQUzFJb25qaWtuT3hHWjBLQldk?=
 =?utf-8?B?YWtBOHF5Nmlobk9oVkExYVE2NUovVmNjejk4QjVjUEk0R3FOZHd2K1ROT1JO?=
 =?utf-8?B?YXMwWHVDb2wzcHIwQTd2clZQL1pmWDFFOVI2M3ZUTEhxSlM0VGQwV1Rrbm9w?=
 =?utf-8?B?azE1ZkJCTFB0aThVNlFIaGxZb1hWMXk2S1M2YmpQUTlMZEJmdVM1Mnc0Y0cy?=
 =?utf-8?B?dWlLUXREK2g2V1FkYXRTS1MwTnUxZWdLZkNMc2N0MEdyTFJudVJ0Wi9Ec09y?=
 =?utf-8?B?MmNZK2llZmVWVi9zYnFqa1BLWWd5QU1TR0dRUUpRekxnZys0K2JuWERPNTMw?=
 =?utf-8?B?NVl5V2dwM2tmQUVYUHRBb3lNNTJuZGN3TVN0VmlqeGQ0SHpOZDlGYWdQemJv?=
 =?utf-8?B?MSsyUnp2MDVJa1lKaHRzcHU5dmUrS1hlUVdyUnJpZnpWa2JjZVFYOXhVMVlW?=
 =?utf-8?B?LzZRUGhsL2puS2JybVNMS3BZd0krOVRCdXZrem1admFVejVSRXFhRTR3Q2ZY?=
 =?utf-8?Q?/JmvbQosC62my?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DU4PR08MB11188.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9675
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[2603:10a6:10:571::11];
 domain=DU4PR08MB11188.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF000001A3.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 913dd880-9643-4edd-bb08-08dd2046c3a5
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|35042699022|36860700013|14060799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NzZISzJsNmY2S2JRa3VINjBlZndTYjQ5a3F4Y3dHMzFtOWFqYmFxVy9Jb1dE?=
 =?utf-8?B?Z0FYd1ZFVGZadTkwWUJBTXB1ZFpKM3JRdDlVRnhGSFZLRVZFcUZxNndmcFNO?=
 =?utf-8?B?Vk04Y2QwekdBY1F6U215VWZXZkozcSt4b1dTNjgvczFvM1ZGeU9FWitvcWcz?=
 =?utf-8?B?eGI4bWlCakQzZk95VFBhaWVsck0wYzc3emNsclgrVzNGMmw3RWRFWGlCTndx?=
 =?utf-8?B?L1Q3OFljYmU3UFpVUnN0cmgwbkJycTVRY3YwbFZqYzRLdml2R2ZhSE9pSDNH?=
 =?utf-8?B?bHhjbjcxRUtueTh2ckNDKzVsUjhhMXZWeXdZWkpOSVdMMFFnN2JpWllLZDIw?=
 =?utf-8?B?R1VKYmV2ektsNy82eWxQSXFhYTluNFBwODVxb1NWRXdYVkVBaEN3bks2TmxV?=
 =?utf-8?B?VUxtdlVTcnNIa3UweFlDQXFVcGtpUzRjbmJoeVV3ZnhLcGZER1BOanQ0blRH?=
 =?utf-8?B?UjdzWDE4dGlZSWkvdVZseVhCa21XdENtekNpeFpaYU0zY0t3V1poRVpDVFM0?=
 =?utf-8?B?ODM5dmVpelI1ZmNpNVVYUEVOYUFxWHJTajlWQ2psVDB2eDZGK3FQeHg1VmEv?=
 =?utf-8?B?cFpvMDBsVU4yQlR6V3lZSnhlWWRpbFZEN3c2Z2FaNGxZaEtNMnMyZkp3ZHJT?=
 =?utf-8?B?cjdKYWdPOUZpcTVNeHg3dnlidlBYdlVUVWJ1OEpZc1Q0eGpudkM5bThHQ3pu?=
 =?utf-8?B?RG5xVWdOKzRZV3AwYVM2dzJFT25uZWU2enJEQ2poRHZWQ256bGdRQ3FhQ0xS?=
 =?utf-8?B?ZDY0ZWcraDJsQndseXJZS2pmRG5wUTU1b2FOY2tLQ1c5THE5OXg2cE1nT0sw?=
 =?utf-8?B?OEFhcnZkcW9VUkM2eVRFaHZVSWRUU2VZOE81a3hZV0JKeEJldnJhdndSVU5E?=
 =?utf-8?B?NGF1QWN0MHFWd2ZhOTJ0YUZCM1hqcFNhbFFpL3dvREFjMzhFRlJaZzJiTmxI?=
 =?utf-8?B?SFNmWWRNNTNlOGVWUERkV1V0QzlRTm5DK0Z4M1VGT3FiK1dibW1ia09VcWY3?=
 =?utf-8?B?dXI1c2RSVjAwRkdORElYeUM3cDFwcEcrVFJUZGwxT1hCOE11ZVJpNU52Zm93?=
 =?utf-8?B?dDd1blkzYlFrRk8rcTdPV1JHUHU2djBwS3RYTUF2L2dETFA4YXZrY2puK2Fa?=
 =?utf-8?B?Vzk3RHg5L09MQ0VSVzZJU1BhbkxnRHl1QWM0RitiRjdueVRjaCtVaktSQ2lF?=
 =?utf-8?B?WTRRd0ZPcjRhVlNiRzh1SHJ4cFpiQjN4YmdIQ3VQamhSU0Rmblg3ZnpvUGxI?=
 =?utf-8?B?Sy9BNUhQWFlxMDNoZ0xsOVJkYnRDVUlTODN6RU5XOGZrVksvUkFCc08yZ1E5?=
 =?utf-8?B?TVFSMm1vTHJINVliZUlPa29hU0U4cXlaa2lWREhRSjhqRlhRN1MwYlRWcGsy?=
 =?utf-8?B?N2JGVFF0dnJTQThPc0lSQnRTaDhFbnhzbXh4OTBwWGxVNUpId3E1UXV1cmIr?=
 =?utf-8?B?QXRrcDJaTnZqM0E2VWNSRFhPc0tDSG1qejcwOGRRck83WGtYT3B6VjBhaDVH?=
 =?utf-8?B?L1FZdDVYR3p0SUQzejVrUmJLNVZMUXV3KzNyMWgzTmtXVzVZTVU2bzFLOUFQ?=
 =?utf-8?B?YzNlejlQZVNtbVQ5UUsydE52NUwwUlRuS0xVVkUyNkc3bzFQVUdYUmVGTWk2?=
 =?utf-8?B?RXROSnR5Z0RRb3lmQ3FSTVhhRDd5cjRoZ0htZTJmS2Y4QmpiQ1ZkQ2QvNk5Y?=
 =?utf-8?B?cVdiYzVoUDc2L3VhVXlNUm1zdlhGdGN5SlFhL2hFL3JVM1g5ejJoN1BjTjNo?=
 =?utf-8?B?VE9LcWh0T1RNRTUzMDljOFQ5aG9oejRya2tKdHhtLzR3enZNUWVmZUo3NXFQ?=
 =?utf-8?B?MEdUVlgzUGM2eTd2bjBxemc0NDJMVm8wL3Q4YmJib1YzTWZrZEErdDU1b0xy?=
 =?utf-8?B?QTNLUThxSG92TEl1M1ZRaTZOS1RvblRUQml1NWpOZDdhNStqL0dCUmJjQWpJ?=
 =?utf-8?B?cFRFMU9ISlVNNXlpT0FnYmhRN2NDME9mU1Z2OHd3MDB3QkpNUG9JSVE0SEJM?=
 =?utf-8?Q?R4t3xzPZyajJ4X0WJUDLPEeIcGkJiU=3D?=
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:64aa7808-outbound-1.mta.getcheckrecipient.com; CAT:NONE;
 SFS:(13230040)(82310400026)(35042699022)(36860700013)(14060799003)(376014)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 16:04:19.3272 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ded8c614-dc26-4f69-59e2-08dd2046cbb2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8510
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 18/12/2024 16:31, Tom Rini wrote:
> On Wed, Dec 18, 2024 at 03:39:31PM +0000, Harrison Mutai wrote:
> 
>> Enable bloblist on vexpress64 platforms to facilitate information
>> passing from TF-A using the firmware handoff framework.
>>
>> Signed-off-by: Harrison Mutai <harrison.mutai@arm.com>
> [snip]
>> diff --git a/configs/vexpress_fvp_bloblist_defconfig b/configs/vexpress_fvp_bloblist_defconfig
>> new file mode 100644
>> index 0000000000..dcc87db872
>> --- /dev/null
>> +++ b/configs/vexpress_fvp_bloblist_defconfig
>> @@ -0,0 +1,5 @@
>> +#include <configs/vexpress_fvp_defconfig>
>> +
>> +CONFIG_BLOBLIST=y
>> +CONFIG_BLOBLIST_PASSAGE=y
>> +CONFIG_BLOBLIST_SIZE_RELOC=0x10000
> 
> I wonder if this means we should also do:
> 
> diff --git a/common/Kconfig b/common/Kconfig
> index 11066ec64315..cca33ed28f32 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -1087,7 +1087,6 @@ config BLOBLIST_SIZE
>   config BLOBLIST_SIZE_RELOC
>   	hex "Size of bloblist after relocation"
>   	default BLOBLIST_SIZE if BLOBLIST_FIXED || BLOBLIST_ALLOC
> -	default 0x0 if BLOBLIST_PASSAGE
>   	default 0x20000 if (ARM && EFI_LOADER && GENERATE_ACPI_TABLE)
>   	help
>   	  Sets the size of the bloblist in bytes after relocation. Since U-Boot
> 
> Because in this case we do need to set the size of the bloblist we use
> internally to non-zero?
> 
That makes sense. The relocation in board_f will fail, as 
reserve_bloblist relies on this value being non-zero. However, if 
CONFIG_BLOBLIST_PASSAGE implies GD_FLG_SKIP_RELOC, then the relocation 
may not be necessary?
