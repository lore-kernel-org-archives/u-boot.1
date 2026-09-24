Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F9AC9830E
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 09:49:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1EE9940B41;
	Thu, 24 Sep 2026 09:49:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YTkK1E39SeLE; Thu, 24 Sep 2026 09:49:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 08D5640D2E
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790243340;
	b=Aox+keBMYd+Z6UNL9mQn3M78dSVSSXvm1TJZ40FQx576D1XMhjdum5gj3pFAEwy1HVkl
	 HiPb/18GMcIRFnA/JcNijfsMcKo4QLGPV3c2aXBbwmTamQYY/gMQ3K+JiSIN3jGZx4rvb
	 LdDfsTgHqiKDfCdfi7zT+IVESilqJGBDMBQPhISpyyhQohyxZS25EptEKOMSYS5dpZdwI
	 mRXVxYtWTtN5Yx7sIfNTn8iD+YQWREO8bWgdCeBkv10PdPRtRBj2zujpk0CzGaeUpFW4w
	 cXC7i4Ht1euuv+9exAS0zL2Q2EXQds/6i56KMNO2nSm0u1WnLNloae6dNpI9qZ5LBGA==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790243340;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:Content-Language:To:Cc:
	 From:Subject:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:x-checkrecipientrouted:
	 NoDisclaimer:X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
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
	bh=CekIizhxGHIka2+C0CwYG9e3IpSrxUysPq3Cb6YKaEE=;
	b=RNG8Wqvwc391w+suHINgk6XJSwqepdwAE+s9RiiCAWncGRo9Hdn/Ost2mESoL1nURdx9
	 po1UlMva76oM9X3IK9lb9zs+ss9BGVt4UQGcOIGJYCOSPPBqbZPi732FbwVz4ZxnFTYCW
	 eAqDc/LXC+fl+hTcJyA1N/c4/iRmi+ksX3NsF4CGzU/s6U5UKYtptIfSwoLZ7EnfMuosd
	 On5IzmYIPcPxgIUO9CtEBWhbvkgPwtUg16yjq6pK4YInge773dc/kM/fwOqprgDDBt6oS
	 CElbdkNKXHMI3GDr07HbwpNpl8UFZImetTUe3Q3BTkc1j+0FNsm7cm5O4BjGkbXQ+sw==
ARC-Authentication-Results: i=4; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790243340;
	bh=CekIizhxGHIka2+C0CwYG9e3IpSrxUysPq3Cb6YKaEE=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zFs6Cjm6DkX3xHuc/0G8og1j5cTw4t6qDxsk9yvOIuXAvm71Lg2TjrUrLQL9WFD5A
	 wY499W2gSIb1EnZw6z1+Cc6lRYKOJ5Qt3+3PKUgpu8ePDjigOvQGwU9+Tes8XTn+wG
	 GFvE433aGfuUAmwTSonkh251caLGo7ReDUFDoFYn1IXesP+Ei1gfdSWyfYc5Ms9Oa8
	 t8Qiyx70ps+W7M0c3C/65VbKvOY9Fw733eLjg/KOeoVNtEic3n02J0LgH4CFdTFRqu
	 UopTlMnJGeV/MJg0U0RjUlR9+u87+Q+YIV4FIaIn6CLafOuM+3YFUClQVgRA9nrx6v
	 C8iikZ7AIG43A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 08D5640D2E;
	Thu, 24 Sep 2026 09:49:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 69AB81DBA
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 09:48:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4747D40390
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 09:48:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uI4FqzEA2UAC for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 09:48:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 438964041B
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c200::5"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790243337;
 b=gsK03LKuPMVt62sDW4wl0chCQyTfzcjChO0nSb/96PDoNrxsQWaouNVzVGr4pBOoplrB
 gH3O1Ej0FaT3KSEXpnnhuEiSY0pqNfDY/Dw2W9fHT5x/gmo7nzxJtY19LBjBK4ySbE8MS
 eUmS354oqCGQi4yKNcNq5ZfSKCbIpDmr1svPT1eIWPRgwPIbgm7onnjRo+/0fuXfK2E0c
 fAjr5WbFDG/KUFo2IHWnAJiKkyiJq74QVJIhCKsqUk0oQ0kOU/40svx168NCQ3+m5FAth
 AiFWIz4fp0tqN6QK1Z9ZwyXsDmkFMOClOuLyRUb3RvkQK4MpGkQ4s8dN18SA2PHIrhA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790243337;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
 DKIM-Signature:Authentication-Results-Original:Received:Received:
 Message-ID:Date:User-Agent:Content-Language:To:Cc:From:Subject:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 x-checkrecipientrouted:NoDisclaimer:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
 X-Microsoft-Antispam-Message-Info-Original:
 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-EOPAttributedMessage:
 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=CekIizhxGHIka2+C0CwYG9e3IpSrxUysPq3Cb6YKaEE=;
 b=duaOy6uZOtYKlkXqEICrKrMoszWXJSkgtQqmNvG/fvqoWI+DT2xfslbobt845SxXXKON
 BlUuWFNu8VhHw0d+w1I+OlUlTYfHD47VXzHww/Aah1ZzfGmSNw/rpkXYLtCRJngzMQWde
 Wq1x2bKwaPQLE51xj4MSfPo+TBYB07IWr18tDwKTMGoyMoY9fNlc2GbVWIs+NS8731QY1
 9HoZHkYad523E0d2X8a22XYPJhDiVAL0hQl7sC29VOFIUjO1pbHiWSFyiSAbj4rQtsvns
 3XFf1JNWTGUxx/TIhMjpJh/U9LDtFtlM2k6ze0xgKVD62q+v5/VKH//+LFWJV2U15YQ==
ARC-Authentication-Results: i=3; smtp2.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=CfowcW2k; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=CfowcW2k; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=CfowcW2k; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=CfowcW2k
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 438964041B
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 09:48:55 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=XV/HC+NNyoEhn9szDzRiXeQNGI+JS5z4thCJYneUyHSxK4RGxyO3chseEDoDS0ZIrUYP3VeB/eu0h+naLPs7TOdY1uv/1pt/jz7Ph5ZYI74EQgjRKAaAY2+KS/YBflbJ5VVTckkEjQNLrQkdsPtxqgrCiEDxexJn6C3Naxet7cy4vrEdtYMdbql+NtINmX2CeqYbZx6OTQhqAkAYfKJKV3uyo6xR6OsdZv56Xa2LV2AZPrhykS5+SurXTCX5xZx+jKLic4T2qHXfMWo2HkYfx20aC8n6xoVvHpvGeo/atq6+T51/u2VQzzCvThu1gRQjC9YquGgcCLPGk8HVNfC1RA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CekIizhxGHIka2+C0CwYG9e3IpSrxUysPq3Cb6YKaEE=;
 b=FfYPjDhCd7KM6w5kxcSRaILjt7Qg2CADXgojWtD0W2g3uIWTHjNX6/bvDEI9XkQTMeH3YeRi+/2IkyPXUafFh3a4z4dxUoiS4WFL+fApGmT2GdC4YdNCHkWqoedGkj9k0+DPE3LtQwQ8JWCDz3WipxcIrarsgeg3tTlTcj/ilotexUBOFnDQBhIgbruOt7LOU+IlIPCByP7lr6rTD46coQwXL7g6ul7LzyiYeMx1hCLCgoxeyZPWAYiQoXQShZYQ9A+iKJP9d43sWpDsZCbtyaxbujR45HpSiIPW5xDJKRfdCdfFM/F18CGHDxdZvHJ0l6TLBYW1vKaFTHBE2ZuQyA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=konsulko.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CekIizhxGHIka2+C0CwYG9e3IpSrxUysPq3Cb6YKaEE=;
 b=CfowcW2kS+VKr0tAYFu24T+30uTghgelc6zzMzSzGC+7hJJdkArPEMZDLwtVvxNM5TphcbCakFjkSUJhj8dhpDVbVqHkIImL+JskNvxmospnaWffALw7M8cZpad4LSQ61KLr8V3n+2a5+QLDltZwOpzxzCezPmri+E6CyVKItQg=
Received: from GVZP280CA0059.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:271::8)
 by DB9PR08MB6331.eurprd08.prod.outlook.com (2603:10a6:10:251::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Thu, 24 Sep
 2026 09:48:46 +0000
Received: from WA1PEPF000099D2.eurprd04.prod.outlook.com
 (2603:10a6:150:271:cafe::50) by GVZP280CA0059.outlook.office365.com
 (2603:10a6:150:271::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 09:48:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 WA1PEPF000099D2.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Thu, 24 Sep 2026 09:48:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVGuRp1sHxdxEAYAP3C4vK6YedGuoHOvbIcyuz0n+lVH5iQywRMAocRjBYUrgSAakNAfs+cQ8CCaZqCMpX74y2C2qODuK9wIzb/Vo1VJLxeq1yzaYsLyvq42l/DyBgeecvc+/9zB32BNTVV/Ro+CNhnDHrz3TKQKbYA+X4Abq3ab4MD2aPMc9ulDgmX/7a6KK9/WLxMTzn/EMNopa+xfkaH0ChA0TjRrQa8KpHXw1AasSB9nbu/Nf8EyvWiVMmE6gpDkdaHt33youYbc73u5HQNeHMzJmdz0hVesP6nN3C1xJ6zxraVTTnIof7v7L3IFwhQ/jc4HNNeWoInt9mCLcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CekIizhxGHIka2+C0CwYG9e3IpSrxUysPq3Cb6YKaEE=;
 b=xgrlVQJOVJ2JTFpP5sVZ2ZNPQQlC1RL9pWDJUgdV1ehq109CmDOukaUC2nsyep9IFaNrm5iVIP2+/c8FI3kGXB6GdcbMsNfT+c1CTkOtPsa03UdWTHCabBhdduEi/cy4XfKGidbrrwbgzq6DSQaH/LIfSisRSLERD09vri20v0Nr0kVtcRgVqj9JrBP3IjwpOZZXe7wxTFgHyzTYXIVZ7i+k2NFfrp/cbMKFpJYZaIyzKkaPZ3bz0kpkVUg8mRtd9jJB0M/PgHI+UEfuAGwkSSToC09x9zrHzZpifPtBIzI950gX4imN6Zfzr8yDASu7W0kgsndMNFKNMxReuAyzrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CekIizhxGHIka2+C0CwYG9e3IpSrxUysPq3Cb6YKaEE=;
 b=CfowcW2kS+VKr0tAYFu24T+30uTghgelc6zzMzSzGC+7hJJdkArPEMZDLwtVvxNM5TphcbCakFjkSUJhj8dhpDVbVqHkIImL+JskNvxmospnaWffALw7M8cZpad4LSQ61KLr8V3n+2a5+QLDltZwOpzxzCezPmri+E6CyVKItQg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by MRWPR08MB11235.eurprd08.prod.outlook.com
 (2603:10a6:501:76::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 09:48:12 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 09:48:12 +0000
Message-ID: <3fa59a87-81f9-4ba0-80c6-bec70294dacc@arm.com>
Date: Thu, 24 Sep 2026 11:48:11 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 nd <nd@arm.com>
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Please pull net-next-20260923
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0563.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::11) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|MRWPR08MB11235:EE_|WA1PEPF000099D2:EE_|DB9PR08MB6331:EE_
X-MS-Office365-Filtering-Correlation-Id: 5402c6e0-7563-4673-d45d-08df1a2106e2
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info-Original: NYPEnNNBumFHIrWOvTJTKiQQL8Z+BqwtIZzSvP3764i3FpIN8139W7vZnaqvD9uMhZSjnWP9yRzLyUNa/Pa4AarVvKrmNHP1BRhz5QmEGc8jNgY9SCZSXMFsN/6IWy9xkPOydDf7RugvzNaW/7wjnuXgd7iucuMTCQMgluFUBy9zcFgGOxEwzbg9IuJ5l9r9PRqFgZQsZgLCTAX1oKAZhz8+B98ko85cScdwt41kcVodKPFJNvHJ1MDQkT43RZ4oj9Hmo8A/fQL0X39izY7zR2nAez9TtX0LJtBVGn319b+ekOnpP0fBLFwKuWp/Eaa8aW3FxyW9CUXKvLJ8ImNBFYftwb+sZvW4cZoX5Ekdrq1rPTw+/TD4X4CqX2FhQun5KclPi5sdhLT2UdPWFv8WRuTN4px2CdE2oZ+ANxsmqEUbrLk0jI3NDLoA2HZYzljGCZu+EOkz2wQDZXTxYt5mIQ0g746Sofl8WB9uRAuHK0ba0G5+zW4gOQNQUtsiFU/v9bCGGAfl5v3JkBB8nEVKSgWRqUoJWpYnmekjPKJzDHVU8GDDGOKhL4lIdLpV3455f6Ajutgya5dk5IQ2u3eU9BndBPlarnSwC0Ak6XL4uj4mvn9pKbft3EaPAkrfWD93
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: 5X+MvEDsrQstvyD/XIXylQGBBtdPZ7ZTTyfz9w4mmet6llfQbXYxpX22Su9Q49sm1AZz6jWehhQ3zedzJ0gwcWwsHlVZnvI7ZugHwSbMD8lCsYgkjNxZGo8LaYAg5M3H3X5j4AjXFQfmK+MgzMbXHmEGmRbqoj1FJXOE+NYWrOoof/8iD16N5kvXdY+qOgRMY6QE2cqm9y7kQpQ/7tLiAVHGuvPhQ/KFfzdQEJKD8PIu0ZdScXEVZCPQI2AVy2lICyHT9K2flwJzjEMDUz4iC+v2fV0xd12rtJBUtgtm9zmdyBv998vJHHTVUkLHmsVrxci/7bmXtOJ9R52wTdtFVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR08MB11235
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: WA1PEPF000099D2.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 05b8f5b9-c1d6-49d2-f24e-08df1a20f2d6
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|14060799003|23010399003|82310400026|376014|36860700016|35042699022|13003099007|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 9ZPkVlDRJPJsI98XAGODUCcil+LholJyVHE+/6mFc1nByaCDpcfEgGAaslB5ETrUdW1Xrmvy52zT2KBXlBcX9c8JoaynmbiG6qhhU4+JvRtfW/QfUQ3GCkyfi7EkE43oP0Fps0//U85YNszuPFK/TjzwKTIpj9rqxrY3ySiShzUnQXnl4sf7d0UWarHy9tcGLxFDr3g7Zy3lygtXDbyMZoUriSbXfngKiOhQESRTCVPZC2tPdSwTFs8rFZ/vg60QwUmSKhGO128VubOV+CY/bZybyFrIqqjHM75BqHmUogI9PjlebJshSrYnu6diV/p+oBehgVNXZ+9lpqSNKtbU3QcsifTbzxL9TUxPXSOoenhiQiMHAXe7smUGvkDI02ASUzfmBHm6Z7Nrg80+57/DKn6ypwhKT+prrQHa6k09hxBzh+7FzMkPdsRHSWz90EvjvgEtGa5NvbeCxXvimfM+Fwb5VqI2z4Mp1nQyxzIH2RTjZWQz8jOhtpcAl4l+cm8lozCL96TuwenM7QhG6pN8TpyLpLZUX2nGTOGUzToi/pT5KJ/XKlqg4m1I8J3l4t6jc+w7ZW3ftQQdRNPorN+98NSrlGUQB4Hr94rfAtVYJTpzLahu8t//mMijf9gbG5Isw/UW4F2OC5LQ+PZClZiWFg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(14060799003)(23010399003)(82310400026)(376014)(36860700016)(35042699022)(13003099007)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KUXUX23G2dvIlUJJB0opyb3Ef3Rj2wynUpLlO77wAsGwLjj0e8moQiKnzgcAcRz6ktXj65dWpdIQl2sw6q07sXzg/VuCWSBJC97J5Ku9t5l0i0xl9gNxShQKkXwvXwFLIKGhnQiAuZUX+7F64r5h97K0xCow3VRmoPhHD1A2C/s/st2MMga6ZZbXOgbl+ehWrpV0YoMgv1msWC5qjwS8En+yBWtB+KU0UhQBQw3MuxAoq0g4Qb5fgSbxrUmfZn1CwjNV2wLlFVu1nSPENry+Wjtnl1IJThnHtBy5Eynw9LGQQ35P5WbYWjVApS3YKWqkqTwpIK2+c8z+s6OuBkBO6KB3zqd4HGnlyr5Ds+SibbNqhigOOf7mM3tWBNK2pQhaBaZ8MAq2rU+631Qg22Xmu/LPlel00V5G2xixfZMcn+N+bFePWrpt0enb0+/GOwu7
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 09:48:46.0532 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5402c6e0-7563-4673-d45d-08df1a2106e2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: WA1PEPF000099D2.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6331
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

Hi Tom,

The following changes since commit 9e002445cd0d47d3965312f12e97a18e1ed8bd53:

  Merge tag 'u-boot-stm32-20260922' of https://git.u-boot-project.org/u-boot/custodians/u-boot-stm into next (2026-09-22 08:59:41 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-net.git/ tags/net-next-20260923

for you to fetch changes up to 805693c5923bf5a456339de018af8fcca62aa038:

  dhcpv6: support rapid commit dhcp6 option (2026-09-23 13:27:10 +0200)

----------------------------------------------------------------
Pull request net-next-20260924.

net-legacy
- dhcpv6: support rapid commit dhcp6 option

net-lwip
- Share the lwIP runtime and support netconsole

----------------------------------------------------------------
James Hilliard (10):
      net: split netconsole transport from stdio frontend
      net: netconsole: use unsigned port numbers
      net: netconsole: cache environment settings
      net: lwip: share one network runtime between clients
      test: dm: cover the shared lwIP runtime
      net: netconsole: add an lwIP transport
      net: lwip: support syslog
      cmd: ethsw: support lwIP
      net: pcap: support lwIP
      net: sandbox: support raw Ethernet with lwIP

Yuxiao Zhang (1):
      dhcpv6: support rapid commit dhcp6 option

 arch/sandbox/cpu/eth-raw-os.c   |  85 ++++++---
 cmd/Kconfig                     |  24 ++-
 cmd/lwip/ping.c                 |  41 ++---
 cmd/lwip/sntp.c                 |  19 +-
 drivers/net/Kconfig             |   2 +-
 drivers/net/Makefile            |   6 +-
 drivers/net/netconsole-legacy.c | 156 +++++++++++++++++
 drivers/net/netconsole-lwip.c   | 200 +++++++++++++++++++++
 drivers/net/netconsole.c        | 201 ++++++---------------
 drivers/net/netconsole.h        |  29 ++++
 drivers/net/sandbox-raw.c       |  52 ++++--
 include/net-common.h            |   7 +
 include/net-legacy.h            |  10 +-
 include/net-lwip.h              |  53 +++++-
 net/Kconfig                     |  13 +-
 net/dhcpv6.c                    |  43 ++++-
 net/dhcpv6.h                    |   2 +
 net/lwip/dhcp.c                 |  57 ++----
 net/lwip/dns.c                  |  24 +--
 net/lwip/net-lwip.c             | 346 +++++++++++++++++++++++++++++++-----
 net/lwip/nfs.c                  |  25 +--
 net/lwip/tftp.c                 |  54 +++---
 net/lwip/wget.c                 |  70 ++++----
 test/dm/Makefile                |   6 +
 test/dm/lwip.c                  | 375 ++++++++++++++++++++++++++++++++++++++++
 test/dm/netconsole.c            | 344 ++++++++++++++++++++++++++++++++++++
 test/log/syslog_test.c          |   2 +
 test/log/syslog_test.h          |   4 +-
 28 files changed, 1816 insertions(+), 434 deletions(-)
 create mode 100644 drivers/net/netconsole-legacy.c
 create mode 100644 drivers/net/netconsole-lwip.c
 create mode 100644 drivers/net/netconsole.h
 create mode 100644 test/dm/lwip.c
 create mode 100644 test/dm/netconsole.c

CI link: https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/pipelines/1361

Thanks,
-- 
Jerome
