Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212EB606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 08:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FmG5x6b8;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5KnPlnn6
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 785C140945;
	Wed, 11 Nov 2026 08:15:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KJiee3ZIHmih; Wed, 11 Nov 2026 08:15:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6D63F408BE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794384951;
	b=AuTCxup59X/uDtDsDAl5t1j7tDtDM8ylVwrxcdRMhpcFGqdfV9EezOnxUN6HWECmlmWk
	 /yNDi8K9G3Z+cV5uLj0wd4BLy1WzKOxX19IcIL04KfVfxv+YDbGlfijPb3OgBlYjy7clX
	 n25HNcrLt2rVwQk12G8KCAF8VpEziGt0buFog8tzlP3U5un6Q9FowiZzqWtZr5IBy1oWI
	 TvIZ8IAgcUSHyvFmzgpmN7Bxh3M0zjkMHEPC9CYCw8zFr6htyTun8RXAB+XZ5/eZpI72c
	 gwv6GR9CiUlgEIf3dOOauufrwffpjR4XljeR8BCi4CxxelZSsajGi/0GQulWkUdJPVA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794384951;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=G0SFDbHrR4L+Z4EfN5KjSOXJ3Oyo2mlAZHq59jiaLl0=;
	b=MsKE+Zb1+Sx4Ae1i1uDgBcquUo9kJOt/kUJ+pJnS8Ezk1YZ8MtJsJRD8TKtzHwc1atFK
	 gAGrSYIBIFp2oLKSs21eheOCS3ZOiB7V8iTqt7Q3f2kcPEQseWeLfO9wRsmh0Jr1C+VtK
	 g6+O+FMb3Zw3QcRCaFFcvwAWDe5RE1ihw2S1wJIwYA+p42gQqiW6DjfWe0i7VOfWQQfRj
	 Jujc5q9tNRHPjuAMWRQxWkmxy5kMCz5Xo2b89T4l0q4eWBo+3n6cUWCP4VkV+23TTPzn+
	 UdL0Qzdi3tIGA/8TdGI/aA597n5mJzbhlPvqC6uAzQJ3KbTRGGFepsU4DNFPXms3UnA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794384951;
	bh=G0SFDbHrR4L+Z4EfN5KjSOXJ3Oyo2mlAZHq59jiaLl0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FmG5x6b8C0DZMMPdWpNFlB8Jdva4/YyUWJsZyjRZT8S/vzp4yZ2baI0hO3yC37uvv
	 hNIrWf13/jJjq2/X7c51121Il6KaPxm4y/oxgrjQ3KcnUWlR6CwCNkcJBWayrx0V6U
	 X6QySnpm5mRFdBEaokZkeMEoZrz6wo/qLcPL0FZpAtdDi+moa0RnJl8EnT3EK83bvI
	 pcGbCdCxxu0JOBdxR70avIohFe5Ig5k6RoA5Z0I8uPffX5M+9v4GqmtHCbIKhiyFQJ
	 K8GOMigPzO8m0xv47GZbNWECOqLsWS4yfRjW00rU0kUUsW9LybZ+brxKIkBSkhdGyS
	 9zEr6QrjA83Aw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6D63F408BE;
	Wed, 11 Nov 2026 08:15:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 31F8D17CB
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 08:15:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 17F0B40318
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 08:15:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gu8U_TD1n7dS for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 08:15:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CCD61400B0
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c007::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c007::2;
 helo=mw6pr02cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=5KnPlnn6
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CCD61400B0
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 08:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0SFDbHrR4L+Z4EfN5KjSOXJ3Oyo2mlAZHq59jiaLl0=;
 b=5KnPlnn6Bd8SGXoOjQCa54JCcv2ebFH0uAeaMsmNPOI/2VB5Xoa7m6YDWK/a16ghNxDeOIc6gnARTXAFmmJ5RRHmWd59IS0h8fdmzajnB9gNP8jhvbKbDKDAw+TqzAldgmjvoOQuxS/ellB/rf/5lM5XGhs57UlRIuibivF2fjw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by MW6PR12MB8705.namprd12.prod.outlook.com (2603:10b6:303:24c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 08:13:43 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 08:13:43 +0000
Message-ID: <7d5f0c9f-6f04-4773-a0f6-1cab069a2f77@amd.com>
Date: Wed, 11 Nov 2026 09:13:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm: zynq: Add missing handoff script to XSA flow
To: Brian Sune <briansune@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org
References: <20261111062128.215998-1-briansune@gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20261111062128.215998-1-briansune@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::23) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|MW6PR12MB8705:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c6d6fd9-e106-43b3-732f-08df3fcbb369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|56012099006|261021121427099003|11063799006|261102123227099003|261009223027099003|261026121527099003|261026140227099003|261022105027099003|261021123027099003|261028144727099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: MocPW+m3Z1Du6M+M5rlyz8c1iEFZLe/hoMgeI7gw21xz6YWuztqKA2KDB79aXB111DEQyZTmm6Qah+8JpbB3KslmZ5QE5r9PLTnx41LCKQHUxHE+9dIVfuN06d3SWENIH/ECzGqu8rzqqrZ7B1/xa8BbCl4dlmcta/il8RzKfHNiGXVT+0jYQkw0qIRGl0srPNVNMFcRS3Xw7KUruK/ok9k909FjA99g49w5kVIA9NMoHwIiU+nr9PmHVRla7OQev7nNPaHmVbYCFPz5B2nPpt3+Uwon8ZQOBqWfQsdfu9sn1VjyJVr78Z7pO3s3eHGAZ0bpruDtlFjtGA4t0TDx/WgoNrdM7mlatiJjtd+g9Tr1uVu7NDCL6nEeHbCyHK0Lf14TBImT+/GmezZN7rAXnRoCIf3dyAWiB8yVZ8cx4TZe/Vt+kDpMrOLbVtmgDoE/yxbLvQ7Y9Xb31qfUau0e/V6rUrY2Gk6IqTWqHlsLSCE+rfjk4F6G64WrW0BIoE6IPCI0zNV4em4g2bSW8MkSzbFixVHcxkviL9xiyZDnM4OwfNaI94z6bxZ1INsv0bL3h4pnVLjcAzKCDAiGryzD96fuF7TWmJY9fGZWLVjclrwi0idSgANV4/YQFlA+AP6TPjPdFhNJVHhgpCYeX8O4ydkAhvJDaO7DcYK49cH8pjc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(261021121427099003)(11063799006)(261102123227099003)(261009223027099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021123027099003)(261028144727099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGg1TDdyenU1ZU41cW9ZYXdNcVpzUi9Yd2xOVzVTd2t0U3ZZSGlXQithWHdP?=
 =?utf-8?B?YjFHc0dsNWJ5VkQ0L05HRVBCR0NBMG1XdXZvaWV6SzFLSmVsNkNhc0RGTElV?=
 =?utf-8?B?NHVISTV2RnY1UDlUR1k3SmUwanIvSmhHNnJvemdVcnlwR2prMURLaVZJWUtN?=
 =?utf-8?B?bGNLQUlIWWlwUlJCc3RhWlFMTS9UUkV3SmtXYjBYUVBkb09WQXNDZ1VrMWM4?=
 =?utf-8?B?a05LUmkvZTk0QklaUFgzbkdOSTF3c3pMWURNQlUwbUtYVkh4Mkk0RlRpREJK?=
 =?utf-8?B?ekJISzA2L1BodWM0c1R2OW5Zd25pRVVIUE5kTzBEY29VNi8zUVBZWTFMMjh3?=
 =?utf-8?B?NGdiNEt1M2Fmek9LYTBiTXNOaEtXM1ZlcGVydFJGeVN0ai90YVZOQ3pGbTR1?=
 =?utf-8?B?cUtaZ0liaXNQd3U3VUJoc0hmcFFMMjAwMUdhZmtRNlNrTnpQMElIWkhyNGl0?=
 =?utf-8?B?ajB4SEppb0xlZXc5U3B6ajk5dnNUTHNJOENkaDJzOVhlSDdyUFVoS0dCOTVj?=
 =?utf-8?B?ZjRxUi94cmVPOFRIdEtoM2FrM2dKSXJJcmxSRHV6WUh5L0NldVJLMU5GZmNp?=
 =?utf-8?B?TEZUdVVpTElZZnlKQWdvQm45OVBaay9WS0dvVy9OM0ZucDh5UUlhbTJ1VUlV?=
 =?utf-8?B?MkhKbGIrNUtMbFA2VythcFhpWmhNamRSM1I1S2xCUjJ2NHA4K2o1dDBpZFJR?=
 =?utf-8?B?Q2kyc2U1WFJFV2t2OXdkQVFYTWFUWkFlRUVMYVZsYTlyYVZSTEZUSjdvOFhq?=
 =?utf-8?B?ZGJlTDNialN1NXU5eUQvcm5JTWJCOUU3em5Xci9DQTNkTW9NZzlwQ0p6cnhK?=
 =?utf-8?B?RE5Uc29UZlQyeGNrbkg4MGVQdG1FTGdRaHczSmgvdFdXbGxPK1IwZXNMOXhl?=
 =?utf-8?B?bnBSa0dMaWRvanBHSC9EM3I2UVE2VEgvSmVKdnE2VWEybWkvMTRNRjFnbm56?=
 =?utf-8?B?NEpjSHkrK0xuT1pIUFhTVHMyeWxHbWVCSzNWSlhFSWhEZWZEUFNRNlVVVWh5?=
 =?utf-8?B?cVQxMG9CdjIyMFA4eGVGSHFHNWtXWkxNQkdmUTgrU0UzalkrVUlLd0paeitx?=
 =?utf-8?B?QU9DNUNVYmY2OHE5NWFhRWNaMU1kdUlxWGw5eklpQ05Zb25OemEycGdUTFF3?=
 =?utf-8?B?YzhjMW5OVVZBRGJlUDd3eklVUE9zWU9jc21pb0JueFJMSnl1NHF4TXRxV2l4?=
 =?utf-8?B?b3JPaFc3MlMxWWxDdDBhd1JmS0tkSHBJWWtEZlRzY0trWGpnRjdRY21rWHZR?=
 =?utf-8?B?bjQzbjJneStIc1k5MVc5R1pEd2dyeFV6bCtoT21hbktORnY5ZEU2N3RBU2x2?=
 =?utf-8?B?d3pZMW81ZVFYUUFKYmowRlJaUmdsMnBqclpvdmQwR3Nxc2VOLzkvQTQ0eTMx?=
 =?utf-8?B?M09ZMWZEQXN4blVCRldJd3R2a0xYSHZIdUo3MkZVdHZxN3ZyU1FvSi9nTDJP?=
 =?utf-8?B?UW1NOENhbEFlenBucTZEZmlWTmlkdGl1OU9IaFdpMU1qMkJMR2FuTmRCSUdB?=
 =?utf-8?B?S05YVStYWDdWVDFBN1BmUzlzcldjWmVNNGQ5SjBrNUhUb1ZJQzRhTUZHdlh1?=
 =?utf-8?B?Rys0SWo2UUNvVG9EdzBuSURncjNsNU03SlkwRjJzWU1YT016WHBrYUNOQzk5?=
 =?utf-8?B?SzY3ZDErZkwyZkMyMGd5SXhiTVlSR2VMZmtSQXRuVHlLT0tEbC84SHprTlNS?=
 =?utf-8?B?R3BvMTQ0MDlsZHFiR1VkT1diSGZERDJ5OWVzakh1akVhSE1OZ2huNkgzcVJS?=
 =?utf-8?B?TWcydTFzOVhrRWhSVnhZbWdOZkdLMDhSczdsQ3lFbXZzZEtqMFZhSjJYMnFs?=
 =?utf-8?B?dFRFa2ptUVU1N3E5MmxRT2hYcXl4SEMyZS8rT1V6SXNZaVJCcDgvTHlHWUNO?=
 =?utf-8?B?cWd5VW1CZFVlR1Z1ZlFhVVJCbW80M2tqS1pUcHZhMG96SWszSTNKRE5vajQ1?=
 =?utf-8?B?L09ob2RwOC9Hdkcwa1hyZjYrYlZxV21aZHdQcmRDVnFQZHBBZzgyeENrOEQ3?=
 =?utf-8?B?TG1GZ2d2UFZWdWN6TWtxRUtYcEtQZEVQOUFmd3VyYnUvOHlrcVc2NVhIK2N3?=
 =?utf-8?B?dWRGRW03a1Q1WFp5Z2VkNmJ2SVZoc2tnVDVzcXNRVStGeHNBUHZYYTF0aFd3?=
 =?utf-8?B?ZjF2Rld3WXVCMlZlci9XbFEvcnZOU25IQW1YdGtIVHBwQ2MxVnBUNHBVMElj?=
 =?utf-8?B?RERQQ0FoVFB2NVFMMUxjbmdoMk42ZHFPUmdGSURiUStnVHYxd2JyY0NwdnRx?=
 =?utf-8?B?MkVidG1ZdFdkOXJMSFc1MDRudWUzYkc4ZytrY2o0bUMxT3lqb0JnSjcybmti?=
 =?utf-8?B?aWZBdy8wMVJNMXhCSDIxSnQ2N09yaElPdUxaWDNXT09vNWF2UFo4UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6d6fd9-e106-43b3-732f-08df3fcbb369
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 08:13:43.2301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVsEswXyTUgsc8PSihGETKyrcfBs+jdYNQysWZ3oMwhm54Y0fJEitlT9j7IXb7EC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8705
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/11/26 07:21, Brian Sune wrote:
> This patch adds XSA handoff for ZYNQ core modifications.

Add XSA ...

> 
> User now can place XSA file next to the board folder where auto
> generated from Vivado build flow.

What would be intended workflow?

> 
> Signed-off-by: Brian Sune <briansune@gmail.com>
> ---
>   arch/arm/mach-zynq/config.mk | 97 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 97 insertions(+)
>   create mode 100644 arch/arm/mach-zynq/config.mk
> 
> diff --git a/arch/arm/mach-zynq/config.mk b/arch/arm/mach-zynq/config.mk
> new file mode 100644
> index 00000000000..2680db85d25
> --- /dev/null
> +++ b/arch/arm/mach-zynq/config.mk
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Brian Sune <briansune@gmail.com>
> +#
> +# HANDOFF_PATH
> +# ------------
> +# Unset - Board path where ###.xsa locates and "ps7_init_gpl.c" should be placed.
> +# Set   - Custom path points to "###.xsa" file.
> +#
> +# HANDOFF_KEEP
> +# ------------
> +# Unset	- Clean ps7_init_gpl files.
> +# Set	- HANDOFF_KEEP= , Clean ps7_init_gpl files.
> +#	  HANDOFF_KEEP=0, Clean ps7_init_gpl files.
> +#	  HANDOFF_KEEP=1, Backup header files and rename to "ps7_init_gpl.c.handoff_backup.<timestamp>".
> +#
> +# Version Log
> +# -----------
> +# Date - 2026/11
> +# 1.0.0 - Initial Release XSA handoff for custom boards and existing boards
> +
> +ifeq ($(CONFIG_ARCH_ZYNQ),y)
> +archprepare: zynq_handoff_prepare
> +endif
> +
> +define COMMENT_C_FUNC
> +	FILE_PATH="$(2)"; \
> +	TEXT_MATCH=$$(printf '%s' "$(1)" | sed 's/(/\\(/g'); \
> +	C_FUNC_HEAD=$$(awk "/$$TEXT_MATCH/ {{print NR; exit}}" "$$FILE_PATH"); \
> +	if [ -n "$$C_FUNC_HEAD" ]; then \
> +		C_FUNC_HEAD=$$((C_FUNC_HEAD - 1)); \
> +		C_FUNC_TAIL=$$(awk -v start="$$C_FUNC_HEAD" '/^\}/ {if (NR > start) {print NR; exit}}' "$$FILE_PATH"); \
> +	fi; \
> +	if [ -n "$$C_FUNC_HEAD" ] && [ -n "$$C_FUNC_TAIL" ]; then \
> +		sed -i "$$C_FUNC_HEAD,$$C_FUNC_TAIL s/^/\/\//" "$$FILE_PATH"; \
> +		echo "[INFO] Commented out lines $$C_FUNC_HEAD and $$C_FUNC_TAIL."; \
> +	fi
> +endef
> +
> +zynq_handoff_prepare:
> +	@set -- $$(awk -F'"' ' \
> +		/^CONFIG_SYS_VENDOR=/ {v=$$2} \
> +		/^CONFIG_DEFAULT_DEVICE_TREE=/ {b=$$2} \
> +		END {print v, b}' .config); \
> +		VENDOR=$$1; \
> +		BOARD=$$2; \
> +		if [ -z "$$VENDOR" ] || [ -z "$$BOARD" ]; then \
> +			exit 0; \
> +		fi; \
> +		BOARD_DIR=$(srctree)/board/$$VENDOR/zynq/$$BOARD; \
> +		if [ "$$HANDOFF_PATH" ]; then \
> +			echo "[INFO] Using manually specified handoff folder: $$HANDOFF_PATH"; \
> +		else \
> +			HANDOFF_PATH=$$BOARD_DIR; \
> +			if [ ! -d "$$HANDOFF_PATH" ]; then \
> +				exit 0; \
> +			fi; \
> +			echo "[INFO] Try auto-detected handoff XSA: $$HANDOFF_PATH"; \
> +		fi; \
> +		TEMP_DIR=$$(mktemp -dp "$$BOARD_DIR/"); \

When you do out of tree compilation you very likely don't want any script to 
change your code under your hands.

I don't have issue with this idea to automate this but I see this more like a 
tool not something what you want to run in every build. Please look below.


> +		trap 'rm -rf "$$TEMP_DIR"' EXIT; \
> +		XSA_FILE=$$(ls $(srctree)/"$$HANDOFF_PATH"/*.xsa 2>/dev/null | head -n 1); \
> +		if [ -z "$$XSA_FILE" ]; then \
> +			exit 0; \
> +		fi; \
> +		echo "[INFO] XSA: $${XSA_FILE##*/}"; \
> +		unzip -q -o "$$XSA_FILE" ps7_init_gpl.c -d "$$TEMP_DIR/"; \
> +		if [ ! -f "$$TEMP_DIR/ps7_init_gpl.c" ]; then \
> +			echo "[WARM] XSA unzip unsuccessful."; \
> +			exit 0; \
> +		fi; \
> +				if [ "$${HANDOFF_KEEP:-0}" != "0" ]; then \
> +			echo "[INFO] Preserving old GPL files..."; \
> +			TIMESTAMP=$$(date +%Y%m%d_%H%M%S); \
> +			for f in "$$BOARD_DIR"/*.c; do \
> +				[ -e "$$f" ] || continue; \
> +				echo "[INFO] $$f -> $${f%.c}.c.handoff_backup.$$TIMESTAMP"; \
> +				mv "$$f" "$${f%.c}.c.handoff_backup.$$TIMESTAMP"; \
> +			done; \
> +		else \
> +			echo "[INFO] Clean old GPL files..."; \
> +			if ls "$$BOARD_DIR"/*.c >/dev/null 2>&1; then \
> +				rm "$$BOARD_DIR"/*.c; \
> +				echo "[INFO] Removed old GPL file..."; \
> +			fi; \
> +		fi; \
> +		sed -i 's|#include "ps7_init_gpl.h"|#include <asm/arch/ps7_init_gpl.h>|g' "$$TEMP_DIR/ps7_init_gpl.c"; \
> +		echo "[INFO] Masking GPL unused functions..."; \
> +		FUNC_NAME="ps7_config(unsigned"; \
> +		$(call COMMENT_C_FUNC,$$FUNC_NAME,$$TEMP_DIR/ps7_init_gpl.c); \
> +		sed -i 's/^ps7_debug(/ps7_debug(void/g' "$$TEMP_DIR/ps7_init_gpl.c"; \
> +		sed -i 's/^ps7_post_config(/ps7_post_config(void/g' "$$TEMP_DIR/ps7_init_gpl.c"; \
> +		sed -i 's/^ps7_init(/ps7_init(void/g' "$$TEMP_DIR/ps7_init_gpl.c"; \
> +		sed -i "/For delay calculation using global timer/,\$$d" "$$TEMP_DIR/ps7_init_gpl.c"; \
> +		sed -i "/int\nps7_config/,\$$d" "$$TEMP_DIR/ps7_init_gpl.c"; \

This sounds very similar to
tools/zynqmp_psu_init_minimize.sh

obviously you target Zynq and not ZynqMP but one part is extract it form xsa and 
second about cleaning. And there are much more things to clean.

You should divide it to two parts.
1. just unpacking xsa and installing it to certain configured board
2. ps7 cleanup

Thanks,
Michal



