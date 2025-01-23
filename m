Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A81C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 17:04:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5D98801B0;
	Thu, 23 Jan 2025 18:03:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="YhOWI9GM";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YhOWI9GM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66AA980214; Thu, 23 Jan 2025 18:03:57 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABBBE80137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 18:03:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Harrison.Mutai@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Ma5XFQ5BIl0ntkItKI+ZEVx67BbQWsjhiGcBI4ksG4kRLb9/ofKBTy2849Bt8KAs/WqdEj5XvJlw2KUfT56us5wWautyfttZjCzvw24nDReMk5I7rR84h+pkdzZLUqOfhfg1XI/qSIPLAtqBGPaRuVwmW3UwhJS9MnK1qb/YHNCyV4VqLj3A1UNAX5NOor5n6lZ8SFRG4crNi/O6azTRkJrM0yCKEXWk6zEOiYdEkWjcYnbBdkG9xgdGvapAHG3rMqqJrlIzSLxcGtkmwwQ4RCsIWgul0FPfbhFhogWhJMYTDLIM5VKIkMF8pkBVu8rQEA6SujOEL1zhTeftzt4q8A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ww2l/Va3x5njv+FiaPjpK/10Lg0YRaNabE/2S8PKJUQ=;
 b=XIHP79QGEBQgPWvwoQCUuMV8wqbnQXktG/IunVKNmLRF/08GMLHzufKYPwrd/g37PPvw1bmzBYovQWuLZhPpN7wYDukQXYnm/sU3CJ7NSgJfKB7Lzl0AmiHoVnocsPqsc3tFTqBI100WCNBd1mGmWnaYzer8OGp4ETD1dG+wv6unmaPCCW9JzbOTH/31cqVbMLQND9W79eW8MqWXqy2+cw8rf92MD+1VznrYigZ/ljK8RdTdb/Yw43dkisYiNyGEGTJzw9ajqqwoCNKlVqpWodV4CNW7MUs9xtQZk6zQX5D/HfGtzxOtzFiaD3yI05FixdbJNuEzdc8ennu17TARLg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ww2l/Va3x5njv+FiaPjpK/10Lg0YRaNabE/2S8PKJUQ=;
 b=YhOWI9GMfu0Xs+UV3rKtWnfY5Cke65GoeMz/1N+QQCeWmwg0BqD3sTTj3QbLqixyvr3NtV0lnzWyHDKiedY28GgZWhToJ0B2Qw5qUsTYgnYXsPBLADAwYh16ue28LZdMFf+zZ9pOZtSoNmk8r4EhLTULQCUjXqhyldGe8rjHQUo=
Received: from DU7PR01CA0023.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::20) by GV1PR08MB10691.eurprd08.prod.outlook.com
 (2603:10a6:150:162::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Thu, 23 Jan
 2025 17:03:51 +0000
Received: from DB1PEPF00039231.eurprd03.prod.outlook.com
 (2603:10a6:10:50f:cafe::5a) by DU7PR01CA0023.outlook.office365.com
 (2603:10a6:10:50f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.18 via Frontend Transport; Thu,
 23 Jan 2025 17:03:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB1PEPF00039231.mail.protection.outlook.com (10.167.8.104) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.8
 via Frontend Transport; Thu, 23 Jan 2025 17:03:50 +0000
Received: ("Tessian outbound e98dd339b993:v554");
 Thu, 23 Jan 2025 17:03:50 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 73dc918816fc47ae
X-TessianGatewayMetadata: a8sWWU17lUY+wNsP6jt6aHv59aP/jzIcLcXr21bJegV6DLWzgTKTBblki/RjVKDGb/t/Z5jaZqLfMFBj5bOlxwYe1fQjcVP//JAiTRUunJdE8/oTJbMZnu1xO47Vqeek6a5XkhGpRlZZIKx0A3idGRnM3Vl5WN2IIQBXfxrQfhc=
X-CR-MTA-TID: 64aa7808
Received: from L648e4ef4bfd3.2
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 2327F483-23AC-4A5E-BED4-4E6E5FF67766.1; 
 Thu, 23 Jan 2025 17:03:43 +0000
Received: from AS8PR03CU001.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id
 L648e4ef4bfd3.2 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Thu, 23 Jan 2025 17:03:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHw2yb7Hxk9TjjxCZr+Z1WKDtTZHzC4jgO8BAEjvRMssiILY3ZHptjUEzo5sHWmzaonEChn9nszDooHMkl4ctmoByvPV4t7iMIddM0XNXui3x9szvwz6nDUyIVWWiAxBZbbYBMZYFWktGo0dYTqtweaEIINsIZB4GZB/jgEmqlsVr2l/+jB40hAr6Bf2L6H079CzO4WI1492k/fOgJH0W93lzxt3tEldfj+0y4nOLLH0dVATa15Wl1VOSeWfJwO6gYW/xUgQbSktD1SmDJapOckNIljNfJ5JUzZFMUY3jl/liBW1Mmcc0nht5bjasj3mnAQDXQwIdP3QYXTiyVhW9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ww2l/Va3x5njv+FiaPjpK/10Lg0YRaNabE/2S8PKJUQ=;
 b=nAGmbqA1MqJm52ydYSXyG+0SOU/fFKKS9XlhVmjrD40lLWc1eg7tWFj+ADAn8+S3wS6vZTDNZaTg7pSd6LHbDqKxkMWCtXQmka7ECLmS0x+pskuj1V4S3Ar4rAmRuAQs7wgoq7xzwHdXTzKLzROugiobZOGs67+wgtfrOdBudajiTAWBN4pk8TjsYC069Rr+DEGLf177NjnnjsX+wMoHq9rCEJ7EKWOHs0l/cB2VxZ6YyuSxFcLypRy+3VbVqiBUd1mFHHW2EV+tK71AYJ9M6opX5GPzpL5jWPNP0oUELoLnjdrtM27ny+zOW0w/4LSPcjw2hjsa20IQ8P9LKnLMFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ww2l/Va3x5njv+FiaPjpK/10Lg0YRaNabE/2S8PKJUQ=;
 b=YhOWI9GMfu0Xs+UV3rKtWnfY5Cke65GoeMz/1N+QQCeWmwg0BqD3sTTj3QbLqixyvr3NtV0lnzWyHDKiedY28GgZWhToJ0B2Qw5qUsTYgnYXsPBLADAwYh16ue28LZdMFf+zZ9pOZtSoNmk8r4EhLTULQCUjXqhyldGe8rjHQUo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DU4PR08MB11188.eurprd08.prod.outlook.com (2603:10a6:10:571::11)
 by PAXPR08MB7333.eurprd08.prod.outlook.com (2603:10a6:102:230::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Thu, 23 Jan
 2025 17:03:41 +0000
Received: from DU4PR08MB11188.eurprd08.prod.outlook.com
 ([fe80::5926:9f0b:ea5d:24df]) by DU4PR08MB11188.eurprd08.prod.outlook.com
 ([fe80::5926:9f0b:ea5d:24df%6]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 17:03:41 +0000
Message-ID: <71c99ce9-673f-43e7-8bdd-86afb64c3707@arm.com>
Date: Thu, 23 Jan 2025 17:03:40 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] bloblist: add support for CONFIG_BLOBLIST_PASSAGE
Content-Language: en-GB
To: Tom Rini <trini@konsulko.com>
Cc: nd@arm.com, andre.przywara@arm.com, manish.pandey2@arm.com,
 u-boot@lists.denx.de
References: <20250115135209.13946-1-harrison.mutai@arm.com>
 <20250115135209.13946-4-harrison.mutai@arm.com>
 <20250122172103.GA52306@bill-the-cat>
From: Harrison Mutai <harrison.mutai@arm.com>
In-Reply-To: <20250122172103.GA52306@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0202.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::9) To DU4PR08MB11188.eurprd08.prod.outlook.com
 (2603:10a6:10:571::11)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DU4PR08MB11188:EE_|PAXPR08MB7333:EE_|DB1PEPF00039231:EE_|GV1PR08MB10691:EE_
X-MS-Office365-Filtering-Correlation-Id: f962b003-78a6-4e20-389e-08dd3bcfe893
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|13003099007; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?cTBPTFZuVUhhWCtJVlEyNlEyYWZuc3lGSlN2Vy95U3UyNUFWV081enozTGZk?=
 =?utf-8?B?cUhsc0hHd2RTTk4rbnhPM1AxaThjdzVEL3FTcnJzQ0JlOFJYcnZSZlNTeVdD?=
 =?utf-8?B?OWhqeklmNGQ2OFl6b2dzNFZiUXhidlRybmJQcVRYdzIyNG1ILytBNnRDUXlm?=
 =?utf-8?B?ekFHQ3BXR2JKTmxTT0VBdThQMXM1MjhheE5PcEFOdDJkYXpVbW4vN1o3Sy9E?=
 =?utf-8?B?eTRGZ3BWMGtGRUJ1Z284VXhPblpCa3VFVTExZGhXaG9JRlFZV2ZKeTlCSUdj?=
 =?utf-8?B?VmZDenVyVzBCQzRPMXpnZmtOZ2N5TmVlRWQvQXN0RWxsMU05N3lzMll3ZkJI?=
 =?utf-8?B?aE1qQVA4OTdsN3dGTDNjcDNHRGlvYVNza0RsMzhOQlRGSUlJak9LNjJXODBT?=
 =?utf-8?B?SmI3RlVkU2ZueUJEYjZBQi91bVpOUzl2bkoyenBPb3NwQzNSeC9sZ0NZbTcy?=
 =?utf-8?B?dkhWeVNHcDdJclhFUzhKQ2RxZDJ4ZUlaTUswMXB0UG1OTDY4Y2kyOXlVa2dq?=
 =?utf-8?B?eVpYdE5VcTc1eU9BSk8vNkp6Yi9tUDg4N3QrUktlellUcWp6aU5GK1JDSDZK?=
 =?utf-8?B?ZjNqQUtremR4SjJ6ekg3MFp4dHFwbVo0Q2RhODVxNnl6TmZiSG42Tkc1dzkz?=
 =?utf-8?B?SjcvK2N3T093NUdISlVLUHBGVE5vdFIrTldhZFFhc2pkcUNpUURObllTaHQz?=
 =?utf-8?B?YVIvbXVaVjJ0ejZhUklZMmtDQSt6QTBIdFFDekxpYlJISU5Gcy81NG5QVml6?=
 =?utf-8?B?ZWRBRDMzRXB5NTg4Mm5LYXVMa2VRVGNhdlNtVDZqM245YWk3RGQ5VjZ1QXlw?=
 =?utf-8?B?bnBORk5MQVhvZVY1UDI2NW9md005Zlp4Y0dCRXNPa2RJUVNQQzJnNTdhL01a?=
 =?utf-8?B?cXZCemM0L0ptYUZaRTk5b0pJTksrNlhRZmdrZW5INE5EbFYxcTNWTG9SV1lS?=
 =?utf-8?B?TXU1WDNZeHFXRnd6SFQ1Zmhab0VyakRVM1RXYiszKy9aL2dNcktTUmxjYkRv?=
 =?utf-8?B?RnpoSGVnRWFiVXhnOGNXUiswdjNNb3ppNW1WMEQvRDA2M1ZlaFlrNXNySW8x?=
 =?utf-8?B?OTRTeTg2dUxHSlByYmYzUWthR2pnTWhSeDJxSHNaSkVPd0N4NWNzSldhVkov?=
 =?utf-8?B?RTdoemJLWGtuUlI1eDljN2Fid2ZGRStUbXZ4dWNPQ0RjdUdQYkNTOG94RUtS?=
 =?utf-8?B?ZjR1Zm5GUnI1YWpuL1BzRyt3U3kzQzA2a204REdPTDhtUnUwVDFGRlgvdVhw?=
 =?utf-8?B?b0J6QzV3ZFhhZS9EZno4MjZBWWRWMDRUL3h1YTJIdTZRd1U2SmhDeVpsSGYv?=
 =?utf-8?B?aDQvMUxsa1M2R2N3Q0JMWVlZRlJsWFZZWGFYL01wMHhnN3FzOTZoQTNMYnlF?=
 =?utf-8?B?dVVaSm9QTTBqWUpHMXlWQnZXamtHUjU5M0hlcUcxbjVIYjFONGZxM0xxenRx?=
 =?utf-8?B?YVZiZ20vUU9GWFkyeGNhMWpaaThBY2ZHR1Z6ZnNLYk5MZzJJeERQU2I3Q1FN?=
 =?utf-8?B?eVJIU1FZc1FrbU9YdngyQkdwYi9yaWpPbWV4RlFhTmM5cUQ4djI3dFVPdVBK?=
 =?utf-8?B?akdIVDFvSVJhNC9IS0ZsejNaZlNtM3dMTWlqVFRIaFNhTkpaYXRVNzdJZDRC?=
 =?utf-8?B?dEpTZ2dVNHUveGNvekFXS25jRVpJWlUzdmhvSEtMMVQ1bzhWelA4aU8zZDJs?=
 =?utf-8?B?RGQrSnFaR0hrbzEreTNUODgyNS8wenQ1SVNMOUVEM29GMUsyaCtxcjhmTjAv?=
 =?utf-8?B?S2tRb2V2TWlZQUVNcVNuVDZzZm10VUJ0RWo1c3Zaa00xTzFhTEJxVWJ6cEdP?=
 =?utf-8?B?RWQwZ2JVRE1QcFp0ZlFoWWNDbkVrbFFzWEQ1R2FxU0JwSVp2MjZ1VC9hVUNo?=
 =?utf-8?Q?mWykfbYuRBu8x?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DU4PR08MB11188.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7333
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[2603:10a6:10:571::11];
 domain=DU4PR08MB11188.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF00039231.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3f76bbbe-630a-44f3-429e-08dd3bcfe32b
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|14060799003|36860700013|1800799024|82310400026|35042699022|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RlNtSlF4cExXVVNoanhZNU1ReE84SmN6L3pVS24wYU1BelFPekdjQ2NHQVFx?=
 =?utf-8?B?VDhNUEU4WnV1SlpOcWZXV1RoWHlRWCtydW9lYmQwdVIxa0ZIVldoaVNrTjI2?=
 =?utf-8?B?dnRMSVowYVRvTTZ4TXJQZXFvbGJEZGxud2dXOTdTZlh3YXZmYTFRcG1nT1hV?=
 =?utf-8?B?RmF5ZzZMT3g3OXVvZXFNUU40OVRCV2hwd0g1Y0p2N05TNGxHOXB1S0M3SEFZ?=
 =?utf-8?B?Yi9FYVI4YzNEQitaMmh0cXBjM0pvRWpFMGJBUTljNTJWUWVDV25SdmgyWUdm?=
 =?utf-8?B?S1FQRnhPZTZkVkt1dFBhMTBXcm53cTNzUDl2MG8yS2k3ZFQvN05JV3Uwbm91?=
 =?utf-8?B?QkVZN1pyWXlVdHRQMGE0RnV0WnpGa2ZMK2pHcTZFYkdJYVFBMVdNUTJqQlNB?=
 =?utf-8?B?QU5RNjZGaXhoYW5JRGZUK2tkTUFlWUxYcTArMXFHSy9oL3ZDaDJtTGRISFBW?=
 =?utf-8?B?NG9YcllFeVhoVkx5YnFKdlRBeGlSbHNnZ0hqcUtrRnUwZ0F3aTBxZ2w2RUU5?=
 =?utf-8?B?NkM2a3cyNmNnZmZBTysyWENMZ3d3ZWtPUGZVdUhBVy9tZDcwbVRVRlZWUk9r?=
 =?utf-8?B?VjVnc1lrZVBTMVAxRWdiTE5hcksrS09QRDgwQXo4QmtzWHU3THZtOVFNdU9n?=
 =?utf-8?B?L1RBenFvUXkvdW8wQ2JBMitlcU1PWkdYbTMwRXJvM083cEVHdmZlS0V2Z0ht?=
 =?utf-8?B?NHNYMmhxZ21CaTArWjBRKytzcFY1c1ZjMnpnYUY4TnRtTVRscmk2RnpEcjBR?=
 =?utf-8?B?V2JXTi9KU1B6cFdhV1AyeHhRTnllYldQcElleFVLMmg4QzlBT2JRTGJrTFhR?=
 =?utf-8?B?V0J0dFFHMGdtaGJPYnFodDRGOWpxbzBBTEl5d0xhNzk1T0pNNkxBc2lZZDBQ?=
 =?utf-8?B?M2J0czRXR0pLTWg4S0pTSlNMQTZkMlduRXo1NkZIWjc3R3Q1Ym1WMHdBSy96?=
 =?utf-8?B?MGZVSFJpVWdkbjFnTFl4UUxKcHV2Zm4wZUlZcll4ZkxaUVJ6Zm5ET2NpVFdQ?=
 =?utf-8?B?VTJweUQ0aGJ6L3pGSHV5TzFHbHhnSlhyZktJMVgzam0rWTdybTRYbEQrSm1h?=
 =?utf-8?B?dnB0Ulo1R0dMZDEyQjRtbEpibDJBL21NNFQyb3l0UTZQOHhIYnYwZDYvRUEr?=
 =?utf-8?B?bHl6WkVSK05WRkFUZUtuY2VEa0FsbWU4Ukpib1hoVUxSbHlnTXVucDZxT2Jo?=
 =?utf-8?B?UkdrT01TOUx5L2wzR290aVlpeFl2cGtsZjV3TzZSU2xjcG5pb3NtekVUTkFs?=
 =?utf-8?B?Q1RjSVBVeXl6NzBCM0NXbTVrdkF1U21PYjE1b245VmFmS3BTVzZpQVVnbUhT?=
 =?utf-8?B?eXpudVpUeDFINkhaY05lMU1vV3gvbEVTajVIMjMrVHFlS202MUprdmhabzQ0?=
 =?utf-8?B?UExjR3luODB0YlZTRWtacHdHd2l1R1IydEZjQWRWYzFrclhmTFhUMmxzd0NR?=
 =?utf-8?B?OEFlVDdBb2oxV0pHcy81TW5hQzBzUzZQbHA1SW81TE83eFpQbDlXWXNLZHJ5?=
 =?utf-8?B?R3luRXozeFRhSzVwN1BROXFmdlpNWEp5RWE5T2RpOVVVNm5WNll5b21ZMzl1?=
 =?utf-8?B?UlpqQUsrV2luVXJkQzViZW13MHhTU0hwUzlTRmtsZzBnT1dLS1VScWtwS1Rj?=
 =?utf-8?B?d2VaQ0Q4UVFHMnVGdHlGZHpINjZ2Vmo5Z1hHL212TzVWVlY5S3BDcVBVeXJq?=
 =?utf-8?B?SVMwY1pnb3QzU3p3WFBReXVBUEtTWmxrTEJEbklkK04yNE93WXVYdXV5S2ZP?=
 =?utf-8?B?UGdnMGtXcmp6V2VXc0xoQXdqUmJyQXF6TjB6bU5qOHFLUFM4SktNNmsyWldr?=
 =?utf-8?B?YkRWL0tjallTSWpMekZIbkxzcnArRXh1UzZjOWNNSzN3UkxHb3QyTUpJWE9C?=
 =?utf-8?B?MWxIQWVaRHpoTDlEVjhEc1F4cVhuNUw2WlZ5RnM0SzI1RUIyMUdTa0k3Y3g5?=
 =?utf-8?B?WXdhMGxaaEtCbXNvc0xpeDJPKzhEdC9Ec0tGTmFyQkxpTDJ3UDRlTkpTQUdo?=
 =?utf-8?Q?Sra99IKAE/Dgrjk6dkF69Gidd9j6FM=3D?=
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:64aa7808-outbound-1.mta.getcheckrecipient.com; CAT:NONE;
 SFS:(13230040)(376014)(14060799003)(36860700013)(1800799024)(82310400026)(35042699022)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 17:03:50.2709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f962b003-78a6-4e20-389e-08dd3bcfe893
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF00039231.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10691
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

On 22/01/2025 17:21, Tom Rini wrote:
> On Wed, Jan 15, 2025 at 01:52:06PM +0000, Harrison Mutai wrote:
> 
>> When the configuration option CONFIG_BLOBLIST_PASSAGE is selected, the
>> bloblist present in the incoming standard passage is utilised in-place.
>> There is no need to specify the size of the bloblist as the system
>> automatically detects it using the header information.
>>
>> Signed-off-by: Harrison Mutai <harrison.mutai@arm.com>
>> ---
>>   common/Kconfig    | 8 +++++++-
>>   common/bloblist.c | 5 ++++-
>>   2 files changed, 11 insertions(+), 2 deletions(-)
> 
> This leads to failure to boot on qemu-arm-sbsa as seen in CI:
> https://dev.azure.com/u-boot/u-boot/_build/results?buildId=10392&view=logs&j=ac5e904b-a30c-5e1d-9570-462b8181c990&t=863544fb-ed04-5d34-fdac-10f5bbb057bd&l=423
> 
Sorry, I'm unfamilliar with U-Boot's CI but I can't make out what the 
source of the failure is. All I see in the logs is what looks like an 
intermittent error.

https://dev.azure.com/u-boot/u-boot/_build/results?buildId=10392&view=logs&j=ac5e904b-a30c-5e1d-9570-462b8181c990&t=863544fb-ed04-5d34-fdac-10f5bbb057bd&l=423

Would you be able to share the results XML?

All the best,
Harrison

