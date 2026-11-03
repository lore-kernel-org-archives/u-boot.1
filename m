Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73645606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 09:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eJFoqJtT;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SWcZlu9r
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C1ECB405B7;
	Tue,  3 Nov 2026 09:43:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 55Q2xCG6gd21; Tue,  3 Nov 2026 09:43:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 726D040589
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793698993;
	b=lSzp49SH4Ht3Kd+zcxiFP9OUWYqQ6RL1ZR5hy/Z3AfN3YbeSVB5Z7PmNcbDn3M67fcmW
	 eKwJT3CB5Xgg5Ofhu214ctYoxrlZtUYl5TsgvvLs+b7CSg+keoDQz8x4QJSrx4VifVsbe
	 F5SEYkoOL/ZuoLFNlRDCznY15PG1gi720RZUtY/ggEPGzvNz1XGgqYH+vA5t1M14BF2nk
	 /EdtI2/5JzmtyecEB8X8Yt8GZoq9fvKjyDsnVrGEUTjO20euAYtkRpdSGV/a1Kn/t1pDR
	 3yMm0TWyHC/AFJiktYeZNcr4Ii4akIL5U9f/EPUr7g6cZcM3OeD4tUUTC5CHE4q7rzA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793698993;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bA9EU/0U+8aXEk4OA+rCX1IcNKWjbJr5Bt5Ag6qBAZU=;
	b=UjJ+DXFtZxso8IXnXo2956P4rdPknSUqKHnFAz86qXlN2aMgQtR+djnFDZ4TlTbC2n+S
	 5DkKPWqhuRzfKQXMIl+L9Wdx1VLn9VoolmZNA06D17+1Dsh98fO5c8pvAMqCv/58nCDWp
	 9Og2E5sfUmR53fNBvb/mE9iSfg1auRxoGUZB7qHEGhWhxTOi0MMxJCN/8No33Eg6DpZqW
	 nhhCDM1oM5TQpilmlFw3pK5y6TDJ7YHNkRp9EHfglpj3ad+M931H13EWXXdpweaXYRmX1
	 RD6NqRF/Cai2EBJ6OWeXryIqU8zxoqRGOle6vqDAo1gQpzCiv2AZ4D9tH918JbSYjRQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793698993;
	bh=bA9EU/0U+8aXEk4OA+rCX1IcNKWjbJr5Bt5Ag6qBAZU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eJFoqJtTbonUFQnXKg0uzbmwvfr9GrZcxyrF+qMp+T7jQoOyTodbnw6YP20SzlXol
	 oMV51Tumfv5Os5kvWyGn9pUvvF9GnMH49AFOvhehVyUS3LuqYYXTNd3z2IxylvKg3m
	 nWqkxTDGPDnfVAuEkFqm6bCvD96NZYIDMdXGwuoXccMF8hk97U+ZjWtRCyodD+99sN
	 2EEY/2GRjdKedUFkPATtMDwoQq8LIxYURBhy+os6dyCHURucLkTfho6eLGgckTMl2f
	 LkZK8i/oYXnZuLWdiz9/+taZVSArxzNvELq6fRrjFSdWYpoNdrGkACYwudNp6bo5Rq
	 LMRAfbmsWM5pA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 726D040589;
	Tue,  3 Nov 2026 09:43:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B000A11CA
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:43:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9317A40080
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:43:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id trM2e35VSurT for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:43:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 40D94401DB
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::9"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793698991;
 b=MgRfiP0NAVYiDU75NKyZAp8ny8tkqGh1aKovDil1GXznRdZG67dLg/S73+rkDnuwhiY5
 fsxhoe0wNIzx1X14aIc9/u4g+NecJTBuJIOez/DXcRXDkZqXq/blvG2UGy57DU1z80k47
 D58+EApiNBVi3PUO99Sf4cqaSPW7UdSjkKanIGjQ6PzcMYpayN+xTYJlc9ES6Ip1q89CZ
 ouQgf5LtzX3VnjxR4mJwDkuu7xQ7051avZSKNhCz4G/mpNvip7bUAsyFN1ML4MnhXUJEU
 R4QyWbUlVr/3JvAebdwRXUVMdN83Y6cGZd7Z3Rn2nlT7MUvWNOT5NcVxqVvFPozSD0w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793698991;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=bA9EU/0U+8aXEk4OA+rCX1IcNKWjbJr5Bt5Ag6qBAZU=;
 b=KYYkzpnUisz4UEDSAg3+2jhp2kDhE3vbEdRS9pRSMzsGLITWhFnqmJTOVVrPzvh0SAFG
 Y33r2j211sufCIip7sY9U+ikxzRcaQjDbU8NIG5Ti23zIMPcexmAaLUVML/PhIvvldgs3
 DXEhYk+Su9urbLfNaWh+YdVV87CMqcIiP5Z6J6redvkmdHLgzmBwfi70wD0toE+ex3OJF
 wyJJ27M7ZrdBz/ZddFK+lWAH94FwR68c04GzIN9WlZ4AOICLt5915WyoQ7f8SBQaLUino
 4RqMBkT+dIflFkdtHVeRcGE3Mh4sACJBAudiLcEJh3OgkJJZPjjJn6doxNrAxEKjC3g==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=SWcZlu9r; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c107::9"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::9;
 helo=ph7pr06cu001.outbound.protection.outlook.com;
 envelope-from=love.kumar@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=SWcZlu9r
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 40D94401DB
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:43:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHA/rTpZSk+ozPUwTUeAE39N4ZP6ckzjDwvlkqSyxmgN3DxSXVFc1Gj1lfVRRBxZ5CxtZx9VdI5I5xCTkzfvlf44MjrZmCK9DjODquiaKe4yG1h0m1hDJoXc5QY44VZitFFonWekaMK3gtgs9Xho/93uhiqd7XYqR9EVHSsUyoE22tJlQif575H1phiCH3lmA3AKNpGnfIyR/qlpmwfB0PnPUeTzAm4lJ6y9mcz8kCQxAkM4T76Asc5Ucv/6hEtUQ8M6dAl9wBCJcKDxk5doGueW5UP6tXdsZu4d4nAUMKjQ/dAf0mjU8zYFckJ8GY6PKOzzxj5OzHcAOq8rgtB7uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bA9EU/0U+8aXEk4OA+rCX1IcNKWjbJr5Bt5Ag6qBAZU=;
 b=PJVMAEn6HZZLLcDwe0zVX6E8TvGjqWzOLHmLt6ShB1adWtbuKGjpVn0zV3+uf0RifwZwS8VdiUAZ1O8839e3rskmvxVWJwDh8y7l6M9C3vg6PxGejccn2P7XKwntu5jbRx06iJadScWoEKJKl7ZRcZqb4jE/j9Ep05+CvqFCjtryE8YwkmeU/ZcPPlbMMY31X0KRBZpeMvehEGuDSlQinLYjN4TwCrRrrAVd0dv+BqDttWiTuiFvAyojK26Tm0swDlGzazGrkX01rTkJqoQQDKu4wMwbtAe5V9jrhFayNFaS9E1Awo7797QmlHZMjRtNxijVqmrRQ8Wi7yO3C1aVOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bA9EU/0U+8aXEk4OA+rCX1IcNKWjbJr5Bt5Ag6qBAZU=;
 b=SWcZlu9rQu7dN1g5sYH5PJxv5yzm0QzzYAvbyv0vtLCCU0PFN3Vdb0GdjC9skBPTTx3daTm0Qh021/PcWedkFdtFsGwPCUAiOBQLpJc85FcmRpFVMO77oerImeBbXu4pnh69l7iMid9LZki8RwMzkAZ1fIkDnYf6JrEPizNiAoc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PR12MB434898.namprd12.prod.outlook.com (2603:10b6:8:47e::22)
 by PH7PR12MB7284.namprd12.prod.outlook.com (2603:10b6:510:20b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 09:43:06 +0000
Received: from DS5PR12MB434898.namprd12.prod.outlook.com
 ([fe80::a2b4:c80f:65bd:1412]) by DS5PR12MB434898.namprd12.prod.outlook.com
 ([fe80::a2b4:c80f:65bd:1412%3]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 09:43:06 +0000
Message-ID: <06513b83-4197-4f64-ac8b-8f40798c44aa@amd.com>
Date: Tue, 3 Nov 2026 15:12:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/30] usb: dwc3: part 2, make the resynced code work
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org, 
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 quentin.schulz@cherry.de, s-vadapalli@ti.com
References: <20261028141554.3073545-1-anders.roxell@linaro.org>
Content-Language: en-US
From: Love Kumar <love.kumar@amd.com>
In-Reply-To: <20261028141554.3073545-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0140.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::10) To DS5PR12MB434898.namprd12.prod.outlook.com
 (2603:10b6:8:47e::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PR12MB434898:EE_|PH7PR12MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f843cc7-ba70-4fae-1b7e-08df398edc90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|376014|1800799024|261021130227099003|261021135927099003|261021121427099003|261022113327099003|261021123027099003|261022115727099003|261022105027099003|261022075727099003|261009223027099003|261026130827099003|261026140227099003|261028144727099003|261026121527099003|11063799006|5023799004|56012099006|22082099003|261102123227099003|6133799003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: A1MITI42vjA8qeNdGWRGzq9xL0EBsVvfVNABDBWv/LsTMgx5+65/jiY+hXLW6W4H8w9Du8+yk2vzXdF6FMQ9jAvp5KDNsq3xFIo+EuP3u5WdcBfAAsyXeG1zuFuO0QxbN0SWgLdGu9vtVhRNeMO0R1YCdXRUXa0SgTHPVDdNyTb3m3L88bZeFo+2o/TwUzX4I6rEXM/WFQOa5Ao1h/DvoIyrKFPKymCUVXeZ23rNkjW1rQZAVq9BdgVUK472vtx9r6LQeXsJ/lxnDwTpNRcBFlKHMbKbKxPaVAfAOKdz1g1KG7WHfrKS8GLAC1WW/54z2bH+26Lz0z4x9k7zTjsTetB0xbPqsuDddm9wG1wwDszOJw2j8ZHTAbu0v5ega1YMvsbXQQjLnvwfJlLdzIQro3Qh0aC7C3AI/BRY3P3P2GmG9By2HBnGzvsYcYSMlhL1kJHI4UPl5UKvFypOzMhZ2/TzQ0XR28cGnidmOj5E6NHnmATCrWMyOgbJITSJW//W/u7jNwLXnNb3/LViViURPrQqvkIOlDk85nOYT+UKBiF5CYJVU/wWm0J6EIroz+0y6Jp2I6vXcRrdPtn8l/wW54XhyN+sCj/aVEGEKuekXtaPyY7d8b30ryYM52Y5twT6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PR12MB434898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(261021130227099003)(261021135927099003)(261021121427099003)(261022113327099003)(261021123027099003)(261022115727099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026130827099003)(261026140227099003)(261028144727099003)(261026121527099003)(11063799006)(5023799004)(56012099006)(22082099003)(261102123227099003)(6133799003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjlsQVlwZkE5R0doY0VHeWhsUnUrKzFTdEtRZUdXRm10Q2Ixb05uSDBVSkZs?=
 =?utf-8?B?ZVhvTjlRMXhNb1p6OHFHanFiSmd3TGIrZzVSRjhSSUlyU0ZlSytkYjQxU1lY?=
 =?utf-8?B?NHE5eFJYTFRHc3ZpNjVLaWp1MjRxS2tYSytGbDdWek1iRUdJa1hzQ1dwblFp?=
 =?utf-8?B?ampNbUVpUjMvR0loSFZ1NjNxdU5VdGxhN0s5TlRnb1UwQUMweDFlUm01c3R4?=
 =?utf-8?B?bTkzdkpxUmtFaG9lMjBUSzVuMis2V3NzYWwzSGxLaWxXREJsNHIrVDVCQURR?=
 =?utf-8?B?TU5ISUw3VkF2WmdMMW5OeUs0REl5aUxqYWJpL0pielpnb0Ryd0g2cGM1RUc5?=
 =?utf-8?B?ZVVLNlZMMWo5cG8zUjBsM25HZVB2cUNpTnhIT2QxeUE2akZIOHBzTVJQaTBo?=
 =?utf-8?B?MHhPY3g4eFBPUmxtTmYrVzQ4eG9vSWdQTVlSc0FPODg1ZWU2SnZMMGhtbWJS?=
 =?utf-8?B?a2d5NmZYMnBSUFNLMlZ2TlNaRjNBT2EyNWo5VGJZM1JXbHY0ZXFiaFBFdGJE?=
 =?utf-8?B?UExZQ3lsaGN0Nmljdkx4bXg1UzRxbFJORjgyTHdwWFVTSVgxSS9XL3lsV1ZT?=
 =?utf-8?B?OTRrSXFHdkxzQnlucVBxY0owMzEycmo4cmRGWFhhTnBUejFpSFVRMzBNNEg3?=
 =?utf-8?B?cnpOR2RFVTBqTllCazhpVVIwMVpxYWlhUHhwOTlTc3E1SnB4cHRZOXZENSt6?=
 =?utf-8?B?ZkFFZHoydFA5SER4d24vT2JMMEpPb1B5TVNSdlh0WThZR3NoUU1ld2dPQlVp?=
 =?utf-8?B?S2Z3TVN2VXlTdGpMS0FOanBvZDJ4RWIzK0ZaMTM5QmtRZGNZNmd4dks1SGRx?=
 =?utf-8?B?V2NPRWZ2S3lnYWJHeDcrWHRCL2M3eENpZFRTUWlXeDFCekFqczRVYXVSTVdz?=
 =?utf-8?B?L0pvSGlDRGpOOFVBUk4yMjFBdThLMlpEMEdpTjdjUlhiVUQ1Z1NnODI3WERK?=
 =?utf-8?B?cmhvKzJiKzVyVTlZUnRNR3pkUHQ2QUdpSzlLZnpYbTU2L29Rb00zQXBXYThO?=
 =?utf-8?B?NDVpR2ZFV25yMW9jemQ2dWxoNXhHeHNTVkFpMVVqNkpVcEhoUHlRbUc1dklu?=
 =?utf-8?B?TTNRSFdiNkJDSHZEZzhKcFVndjhEOEZMWjhFUEtsOTdDbFQ1czhQUXY2TFcv?=
 =?utf-8?B?RzNOTWxIcUxON1RZaEZTVVNzWGhRZjlIN2ZHQ0pUNUFQRFpQVHArSnVxU1Bv?=
 =?utf-8?B?V2YvZDlPTHNhbTJUM0NyQTd0bGhEU3ZIcEIwbDdrZ082VkFpK2hHbTdzYWVO?=
 =?utf-8?B?V2R4VERBNzY3dW1wTXZaT2czU0RWYlhpYTFhdktWTVdKV3dWNHh6OEswNndo?=
 =?utf-8?B?RHkrWUZmeG1qdjlNTGVyUVZIVTg5ODVoNEd5RXpwdjhRNGM2U2wzTmQ1d2gr?=
 =?utf-8?B?V2MvRTVKMVdFelFEeTZTck4zN3p6MmtHZWpOTTk2M3V0STUxV0FQQ0xnUGp5?=
 =?utf-8?B?NXV3UGRCWERNaEtqVW9UM2tjTFRmLzcwVFdIMG5jVWg1N3RCTGtkbWk5OEh1?=
 =?utf-8?B?SDQ4bmJPK1VQbTQ0dFg0SWdCRlJ6cU55VUFxM3d2WUplSlVMa0lWeCs3azVK?=
 =?utf-8?B?eHBiZEZ4MTg5TS9BYmZweWpFd0pqTFM4QmlqTll4c0g4UytHb2VUSk9jT0hn?=
 =?utf-8?B?MFdMc0h5M05uVnJxWjNxRkUwd3lJYUhiUnR0anBkUzhzb0hhTVZzTktGMGox?=
 =?utf-8?B?NEdPbTZ0S3Y3QVNjWHpnSHVobE1aSnVoZTdLUUZRVDBoYXNwNURwVmM1V3Bw?=
 =?utf-8?B?ZGpVNGdwd2RSN0xYNmEvek1YMlY0SzBJZTkvY3VibFgrcGZFOTdkVE0zSkNh?=
 =?utf-8?B?a1NGWWZkQWdoeCt1ZEVFOVBDTDlmUzhlcm4rSnhqQVozbUZzTlZ2dnBnNm9Q?=
 =?utf-8?B?akdCRVpXSWJSQ25SRGpsNG5lb2N5aXh3bFR1WmJ3a3ppUzR3Q0RMaWhXZWln?=
 =?utf-8?B?MDhxSGp3b3YyYk5PSUIwTDR4UTBSUWtTc2FscENoWUQxWWVCemVXazNXL1hh?=
 =?utf-8?B?aVZiY0hVNUx0Vlc2cEFhWEx4SVU0VGUwL0VraHQzaVlBRU12RUtGbllVUXc5?=
 =?utf-8?B?NzNBL1dNR0pNZkZobkN2WnVWejNlN0g1QnpHVk92V2pGdFZuWkZ1a2FRb3Ja?=
 =?utf-8?B?aGxzQm0rM1Q0ckwzcDBDVVRNMUh4OHZWbCtCSnk0SHlPanRBSHoyeWxQMUoz?=
 =?utf-8?B?R2Z0WHZ3bUZ4bG9yNDFWOGhjRGtzL1BSK1FiTUl5azhidnNVbHRIT2tnREFW?=
 =?utf-8?B?bG9lR21udEtLR2JQSThlNHFBNkNlc3h3OTA3YVVLRnlJWEtpVjk5NXlCVVNp?=
 =?utf-8?Q?EfZXjyB2hXGUrzdSDc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f843cc7-ba70-4fae-1b7e-08df398edc90
X-MS-Exchange-CrossTenant-AuthSource: DS5PR12MB434898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 09:43:05.9203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gL6AkU0pzixov0LHpsRThYftbsdn3g68rKroZjRe7Dja7KIQE2be1KZA77fWs16X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7284
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 10/28/26 7:45 PM, Anders Roxell wrote:
> Hi,
> 
> This is part two of two. It applies on top of part one [1], which resets
> the DWC3 driver and imports it up to Linux v6.16. Part one alone breaks
> the build for every board that enables DWC3. This part adds back the
> U-Boot glue, the XHCI and UDC updates and the build fixes, so the tree
> builds and the gadget works again. It builds on Jerome's work [2].
> 
> The two parts have to go in together. Part one changed too this time, so
> I resend both as v10.
> 
> The resynced epautoconf matches endpoints on their caps field instead of
> on their name. Five UDC drivers never filled that in, so each one gets a
> patch next to its other fixup: at91_udc, atmel_usba_udc, ci_udc, musb-new
> and mtu3. With those and dwc2, every UDC driver in the tree sets caps.
> 
> Build tested one board per driver: every DWC3 glue layer in the tree,
> dwc3 on riscv (spacemit_k1), dwc2 with and without DM_USB_GADGET,
> at91_udc, atmel_usba_udc, ci_udc, musb-new, mtu3 and am335x_evm. 19
> boards, no warnings.
> 
> Tested on hardware, per vendor:
> 
> - AMD/Xilinx: Love tested and sent a Tested-by.
> - TI: DFU and ums on BeagleBoard-X15 (me), and on AM62p and BeaglePlay
>    (Anshul).
> - NXP: ci_udc with ums on an i.MX93 board (me).
> - Amlogic: gadget and host on Khadas VIM3 (Mattijs).
> - Rockchip: host on RK3588 Tiger and RK3399 Puma (Quentin).
> 
> The rest is build tested only.
> 
> Two things are still open.
> 
> Anshul sees a single "unknown endpoint event 0" line on AM62p during
> enumeration. Siddharth ran mainline with a debug print and did not see
> it there. I asked for the raw event value with this series. No answer
> yet.
> 
> On RK3588 Tiger, Quentin got "WARN endpoint is halted" and a failed usb
> write on one port. The resynced core clears SUSPHY when it puts a DRD
> controller in host mode, and nothing sets it again. The last patch fixes
> that. It is not tested on that board, so I do not know yet if this
> was the cause.
> 
> The branch has both parts [3].
> 
> [1] part one, subject: [PATCH v10 00/63] usb: dwc3: part 1, reset and
>      import from Linux v6.16
> [2] Jerome's adaptation work: https://lore.kernel.org/all/20251121153812.2076440-1-jerome.forissier@linaro.org/
> [3] https://github.com/roxell/u-boot/tree/usb_dwc3_sync_v10
> [4] v9 part two: https://lore.kernel.org/u-boot/20260916123826.517181-1-anders.roxell@linaro.org/
> 
> v9 -> v10:
> - Rebased on 8649a54d301a.
> - dm helpers: reset_control_*() moved to include/reset.h and call
>    reset_assert() and reset_deassert(). Kept Mattijs' Reviewed-by.
>    (Marek)
> - New patch: sierra and torrent use the reset.h helpers. Only build
>    tested. (Marek)
> - usb_phy helpers: x -> phy. (Marek)
> - "usb: dwc3: make the core driver build in U-Boot" is split in four.
>    The first only deletes, the second adds back the old U-Boot functions
>    unchanged, and the third has the real changes. (Marek)
> - Dropped the samsung usb phy patch, since part one keeps the file now.
>    (Marek)
> - udc-core: udc_bind_to_driver() is after the async callback helpers,
>    so no forward declaration. (Marek)
> - am62 glue: check dev_remap_addr_index() for NULL again. The rebase
>    lost David's fix in 83abf9120071 without a conflict.
> - New patch last: enable SUSPHY again after xhci is registered. Found
>    while looking at Quentin's RK3588 Tiger report.
> - am335x_evm SPL fits again, CI passes on v10.
> 
> Older changes are listed in v9 [4].
> 
> Cheers,
> Anders
> 
> Anders Roxell (30):
>    x86: asm: io.h: add rmb() and wmb()
>    dm: add helpers needed by the resynced DWC3 code
>    phy: cadence: use reset_control_assert() from reset.h
>    usb: phy: add the usb_phy helpers needed by the resynced DWC3 code
>    usb: gadget: adapt the gadget API after the resync
>    usb: gadget: udc: make udc-core build in U-Boot
>    usb: dwc3: core: remove the code U-Boot does not use
>    usb: dwc3: core: bring back the U-Boot entry points
>    usb: dwc3: core: adapt to the U-Boot APIs
>    usb: dwc3: adapt io.h, the Makefile and the TI glue
>    usb: dwc3: make gadget and ep0 build in U-Boot
>    usb: gadget: udc: enable async callbacks on bind
>    usb: dwc3: ep0: flush and invalidate cache around ep0 transfers
>    usb: dwc3: gadget: flush and invalidate cache around transfers
>    usb: dwc3: make the am62 glue build in U-Boot
>    usb: gadget: ci_udc: move to the udc-core registration
>    usb: gadget: ci_udc: set endpoint capabilities
>    usb: gadget: dwc2_udc_otg: fix up after the resync
>    usb: gadget: fix up the function drivers after the resync
>    usb: gadget: fix up the last UDC drivers after the resync
>    usb: gadget: atmel_usba_udc: set endpoint capabilities
>    usb: gadget: at91_udc: register with udc-core
>    usb: gadget: at91_udc: set endpoint capabilities
>    usb: musb-new: fix up after the resync
>    usb: musb-new: set endpoint capabilities
>    usb: mtu3: fix up after the resync
>    usb: mtu3: set endpoint capabilities
>    usb: host: xhci: fix up after the resync
>    usb: cdns3: fix up after the resync
>    usb: dwc3: enable SUSPHY again after xhci is registered
> 
>   arch/x86/include/asm/io.h                 |    2 +
>   drivers/phy/cadence/phy-cadence-sierra.c  |   18 -
>   drivers/phy/cadence/phy-cadence-torrent.c |    2 -
>   drivers/usb/cdns3/ep0.c                   |    8 +-
>   drivers/usb/dwc3/Makefile                 |   16 +-
>   drivers/usb/dwc3/core.c                   | 1762 +++++----------------
>   drivers/usb/dwc3/core.h                   |   41 +-
>   drivers/usb/dwc3/dwc3-am62.c              |  424 +----
>   drivers/usb/dwc3/dwc3-generic.c           |    8 +-
>   drivers/usb/dwc3/dwc3-layerscape.c        |    8 +-
>   drivers/usb/dwc3/dwc3-omap.c              |    2 -
>   drivers/usb/dwc3/ep0.c                    |  117 +-
>   drivers/usb/dwc3/gadget.c                 |  724 ++-------
>   drivers/usb/dwc3/gadget.h                 |    4 +-
>   drivers/usb/dwc3/io.h                     |   36 +-
>   drivers/usb/dwc3/ti_usb_phy.c             |    2 -
>   drivers/usb/gadget/at91_udc.c             |   83 +-
>   drivers/usb/gadget/atmel_usba_udc.c       |  114 +-
>   drivers/usb/gadget/ci_udc.c               |   86 +-
>   drivers/usb/gadget/composite.c            |    2 +-
>   drivers/usb/gadget/dwc2_udc_otg.c         |   86 +-
>   drivers/usb/gadget/epautoconf.c           |    2 -
>   drivers/usb/gadget/ether.c                |   21 +-
>   drivers/usb/gadget/f_acm.c                |   20 +-
>   drivers/usb/gadget/f_fastboot.c           |   10 +-
>   drivers/usb/gadget/f_mass_storage.c       |    5 +-
>   drivers/usb/gadget/f_rockusb.c            |   11 +-
>   drivers/usb/gadget/f_sdp.c                |   12 +-
>   drivers/usb/gadget/f_thor.c               |   19 +-
>   drivers/usb/gadget/udc/Makefile           |    1 +
>   drivers/usb/gadget/udc/udc-core.c         |  931 ++---------
>   drivers/usb/host/xhci-dwc3.c              |    4 +-
>   drivers/usb/mtu3/mtu3_gadget.c            |   10 +
>   drivers/usb/mtu3/mtu3_gadget_ep0.c        |   16 +-
>   drivers/usb/musb-new/musb_gadget.c        |   21 +-
>   drivers/usb/musb-new/musb_gadget_ep0.c    |   24 +-
>   drivers/usb/musb-new/musb_uboot.c         |   39 -
>   include/dm/device_compat.h                |   13 +
>   include/dm/read.h                         |   51 +
>   include/linux/compat.h                    |    2 +
>   include/linux/usb/ch9.h                   |   25 +-
>   include/linux/usb/gadget.h                |  529 ++-----
>   include/linux/usb/phy.h                   |   57 +
>   include/reset.h                           |   16 +
>   44 files changed, 1354 insertions(+), 4030 deletions(-)
> 

Tested on AMD/Xilinx ZynqMP, Versal, Versal-Net, and Versal Gen 2 
boards. No issues observed.

Tested-by: Love Kumar <love.kumar@amd.com>

Regards,
Love Kumar



