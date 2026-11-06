Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95867606A329
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 20:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hul2ML3+;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=exlgKynf
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5C55040994;
	Fri,  6 Nov 2026 20:10:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v1cn7RIC4oLF; Fri,  6 Nov 2026 20:10:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 50C0440996
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793995809;
	b=pxFMILTEc/h1kZTPAu0zu+f7O49vlkuW+Nvpv8X0GavraS1b7tRxTIYQnfDuCjmZPGyN
	 T8+b+j3oRhMNBpcuPaUgKHTBb7BIGCempNYBt4AjSCkW0IxHYfrQrYLz4+bdA4/h+ZpAN
	 u4raoLsMJWjQr3+SpC/2Oc/njQu18HoxqyoiHQTp14+I5W7rjEfZrzbQxs5lSpTe6Id6B
	 9rP9Y+Y3zQhHWjCjR55lKMzr+/uWMcE8wz+esq56fMT4BhhQlIE9sKh12og6HCBFqOeGf
	 yanNHVjTP2sJasGTFqWGWsXdyMcvCGqqPO5z1R1MQECJHF9t3BSSiSDfC7RkwZJ5ySA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793995809;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
	bh=IGUcxdAbzH9Jbp1OYUmxQRbEwXYWW2D3WL8zTsQ9nEg=;
	b=gXvIM3ctj0jrpDdQGoovaDgddULO9dGwitu65OGH2OtKAiOdKdURHdxUrcGRMb02kabb
	 8WqvzKMvjOGhxtr4otVVpSae6hQabkXevEJ0BQ1gOJj6JP0/yEU6YR5F3sxGKIXBLEM2g
	 9nFGcJ3jEASe8d74lzn3jvLZm42YeMPTrPxi6qibS2Q+1umyaJtHLvShp0Rrp82hzYGM9
	 xlrgmWAQgjPOmsF2tGulWc8A9w9QvP7WYD+T9qnhDZtkkpxOW+OpNqT+y1dGEyK4itvoH
	 KINqYVMhkaPC1lI63tD+SAtbaNSZPOZcQw/qI9aJzD5fueXFq7wEnoqScKUoJiOPMlA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793995809;
	bh=IGUcxdAbzH9Jbp1OYUmxQRbEwXYWW2D3WL8zTsQ9nEg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hul2ML3+ZtWLyoCsFJutWTwZMZHFTtcjF8i9C3ZziiTJxKbbAKYngVTlxcCB1GZTo
	 S9hZj+v/QrGJAjyActVXIr8nurIwg0uQZQKisFGZjE3trmkVp3v8l7RZiQAeqcAU7J
	 ablMH2jz1PyZqpI1yksPJbLCIfMTCo8v6dMENnFUgsxPhMYj2tlI3XRggXAuhmOaIr
	 MJY81MGYmdWF1sWgdnD5oZqINMvMePTJzSzEzj84+pkvwG7MmGAsCUIOKs1MWy9pqK
	 UM0mCFzD6ziItwmRW82C5fJtl+qmNY5L5dY0ZFGO2aD3Hg4APgRKhARwSkaGoveb3d
	 wtglDWYwJ5SYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 50C0440996;
	Fri,  6 Nov 2026 20:10:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C0B5C31F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 20:10:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B2761606EB
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 20:10:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qDZ5ESlvTMul for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 20:10:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9E6EE608B7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c001::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c001::5;
 helo=byapr05cu005.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=exlgKynf
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9E6EE608B7
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 20:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGUcxdAbzH9Jbp1OYUmxQRbEwXYWW2D3WL8zTsQ9nEg=;
 b=exlgKynfQKwGc1T+DOgzVdDWrQ3hNMpjFKg89nJiqNTF8x/LmuhbOZVvniLhmKpuh7nshg5moTur0qoIaVd7ONciUibGdNxh4awFHoq+oETezbjJdiAkQr7wXMVqfwrOW/9ksvQbe9cCwt1LWQWqwGEtoME9Pg4F5KK0IK9UPgLCBaATXWtaG6Mkq1EFTkCv33mWoMpMybM0/CuiTLhL0O9wQ/Laxb348G9QSuLIwiitKlWynneKHHXl1JNi9vXI7HSwN8k5lNaq2PlzKet5GhL7qKwRte1HgL4behx+zFSebz8+KFmTZmiyrh4VlgPJA3V28JVOVy/F+3d/n4Y2Sg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by MN6PR03MB7646.namprd03.prod.outlook.com (2603:10b6:208:501::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 20:10:00 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0569.011; Fri, 6 Nov 2026
 20:10:00 +0000
Message-ID: <afc2b0a6-8d41-4aa7-a367-aae6e819c2c3@altera.com>
Date: Sat, 7 Nov 2026 01:39:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] mmc: k1: multi-block SD reads in SPL and a probe
 failure fix
To: Zixian Zeng <sycamoremoon376@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>, Eric Chung <eric.chung@riscstar.com>
Cc: u-boot@lists.u-boot-project.org, u-boot-spacemit@groups.io,
 Dave Klotz <DaveWK225@protonmail.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>, Anand Moon
 <linux.amoon@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Guodong Xu <guodong@riscstar.com>,
 Leo Liang <leo.liang@sifive.com>, Tim Ouyang <tim609@andestech.com>,
 Yao Zi <me@ziyao.cc>
References: <20261031215452.16013-1-tanmay.kathpalia@altera.com>
 <4b3f9200-ebbd-4e17-9205-58827c426edd@gmail.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <4b3f9200-ebbd-4e17-9205-58827c426edd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26d::15) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|MN6PR03MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: bb45fd6e-5620-473c-ee98-08df3c41efef
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|1800799024|366016|376014|22082099003|18002099003|55112099003|11063799006|4143699003|260925022911599003|260925021311599003|56012099006|261009223027099003|261102123227099003|261021123027099003|261022105027099003|261021121427099003|261028144727099003|261026140227099003|261026121527099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: 0kqSkrYSYANtCIm+x2zD1nVwxQhjLxvzXzrtFRKXVMgu3kH3BgaSgM/EfH75Q13rxsxWok6Go2LwofCuUZV6m7XJxL3xLPx9ab9SkpWfeyjC+bGyvHJPPs27IaxdpmKWxrVbwUPYjPh3P/F+aUMP/n3RzhoUWMs2O2OUmBbBBq/YiLTrrKdKEdUqvKmTHmZrmwZRUvtMxxIVTtGIu1BV+pXsyp5Om3dFaRywkcARm9KLJpIaj380LVe8ZlK5+tANgir3J2EZVmDZSC8091j9011ClJG+pLSHH4rzA+WzlMaSQheVsabaY88/GQi0dI3N1uUyKv7GaZFUNfUqSNEYDyom9ULaKciTyz/LFoeSFLMJeQ1As5ake82ZYaD/frOgZdrOeoZaJjXtKcrsj0T+pJxXZai9IfNYNO4fvoJ3LpvVnuJ9QCKpPyLToxfmFHtKxLQYih9iCLv5TPtkhZRb3nIH5X4Wwa69Gmvy8stSKNdiwVwrBb8lgs8zrKKNEK06TQyZRSHfXmjDSr+RYecJaY8sktxD7c4+hJRklexlf3vcJNMplMeHeXp3tftNlFvqpoldZ5MDSTtLymJK7PfXNTxtCalReTsAyey7ZjnIlPKmOHOhcn0af743Oprn5FBi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(55112099003)(11063799006)(4143699003)(260925022911599003)(260925021311599003)(56012099006)(261009223027099003)(261102123227099003)(261021123027099003)(261022105027099003)(261021121427099003)(261028144727099003)(261026140227099003)(261026121527099003)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDA5MU1lb3lLTmFmSzlMNXRyenVVSkpSdXd3VUVBb3NDNkpydkNvejI4MHUx?=
 =?utf-8?B?VjJyL3hVMTFhZWRET2J3R3Exb1NYZ203bEdPQ0pWZTJ1QjJCOGNLQlNQZU04?=
 =?utf-8?B?Z2lScWFUSHVrUGxzTWNaYXJ3Skg4Q00wUHRpTEg2RE1BcmRxVzhPUVE5bGsr?=
 =?utf-8?B?YlJ0SWtYSTl5NVFvbmxZV3JRR0xQcTJtdTJudEFVajFGbWtITGV0UjdUWDZl?=
 =?utf-8?B?TzdnSDRGellTa3l5UHF6UWdVU1dhWmIzOEpSZldIOWxlVEJCcVZmcXRBclg1?=
 =?utf-8?B?cWpGZVJOQnRrOHlpbDZ5aE9MUjNEUENzelU5THZGLzAwR1Jud2luUmZQWGhX?=
 =?utf-8?B?Z1FTYldWRWFDOUZyZVN2c2N4VXNSeVR0NHFXS1B1STdhV3FPTzRsS0pUclVw?=
 =?utf-8?B?MElZS1BvL2RZZnY0Z2sxK2NWZG9IMW1BTnVldnZteUo3THdKN3hmMU1zZzdF?=
 =?utf-8?B?MG55VDZoNE5KTmFkeFZ2RHkrMUVKbE5QSmpCTnBka01JR1ljVi8vTVdMekUx?=
 =?utf-8?B?YUVEaExiV0hrUjFEdE8vY0tIL2R2K1p0WVdzL2ord09BNUJoOXMvUHRYUWwx?=
 =?utf-8?B?bjFsdTJnR3hoMnNKYmJRMWoycloyRFZsOWZja2JDUkYrcVh3TndBT1JPOGoy?=
 =?utf-8?B?Q2JCVzAyL3c4MURBR2hPbEZ1cTBObG9ud0lOK2tUSFI2K2pEYXhoUVRkMWxZ?=
 =?utf-8?B?UHBkS3hZYnpOQnpHaHU1aE9oZW1ibVpNNmhyVkZ3QUptY3FaV2FBUVVsNURx?=
 =?utf-8?B?Z3llRHc3VWJSRjN6ZytmU1NJOWtLQnd0b0pXTDVMQzRZd2FZajRVRTVJYUJI?=
 =?utf-8?B?Zm1hMDVMOXBQSnhLRThxL0lKMUtaVzZ6Z1oxeW5vVnBRTjI1ZW5QdkxoOVMr?=
 =?utf-8?B?YXU3c29LK3Bsc0FFakl0UDJndmdNZ2YvVStMWCtGdDZIYUF0bjk1c2ozcHA5?=
 =?utf-8?B?VElZR3JqR3dackpDWUJiTVZRVTEyeFNndXdkNFhla2Flci9XamgxeEJ6dlhC?=
 =?utf-8?B?RTY0YmZ1RS9zOTZkd29zVEFKcC8yNkVzVDI0RjhuR2s4NXJ3M0kvN21Nc3A0?=
 =?utf-8?B?VWNVeTZ6KzJwci9zbmM1TjEvNXo1Zld3bkdQQkwxQVppSDdyaVMwZjFTZk5L?=
 =?utf-8?B?Mk0xSHJKU0daLzJWc1F0UkdtMzZ5WmQ0VWtSYlkweVoxcDFUYXRwZytORVNr?=
 =?utf-8?B?b21hd3BmU0Fsb0MvdXhEZm90RWt4dGMvYXV0SG1mSzgvV3hSS1YxZDlOWEtO?=
 =?utf-8?B?NGNNYm8zdlBIazZkYXRHMGdSOGlJVFh6RG9ScWNOR2lYVEViUTVHTWE5SXFV?=
 =?utf-8?B?NlAxMVE4QXNzdUZDVUY0Rk93NmtnNG5reEhRNmY1WXMvMk90aCtLZDBXKy9v?=
 =?utf-8?B?UFppWklrSVBodEY5RWJVK0k5MCt2blBtZk9nZitoWVhuWU9GamVjM2pPNExK?=
 =?utf-8?B?NXRheFFOMGV2UVBIbzF4ZUU0TDVkUkF4TGk4VHQxWlhKMmhnRHJvWE1tZmR0?=
 =?utf-8?B?a3I2bVZsbXJmZkk2dWpUa2FnK2V0TjArWmhCOVAyVjdRbVZsam1xOVRVUFZ2?=
 =?utf-8?B?VEpyQWJxN1RHSVEwMmNSRWRldE15aGpLcUw2Y3EwMWtNNFhzWXBEaDk1Smh5?=
 =?utf-8?B?d0ZxOTFiYUJneWR1SUNRSUFDaWZ0MUkreGdJbXQ3WjROMkVhbllSOTZiQldV?=
 =?utf-8?B?RVBYS3MvQmdqb3JvTVhQQURYcStQcFgrQWNoV0NDZzBWdXdsZVl4YXRZUzBF?=
 =?utf-8?B?L3NaY25EZlFvbVcvYkcvazZTUkw1T0ZubmUveFlETFI0R3kyeEhQK1Rjam03?=
 =?utf-8?B?ck5LdVZGU0xLWUcwWkdnYWJqbWQrVHNXZzNWMnZ6dTY4eDdvQlhIeU1BVWVM?=
 =?utf-8?B?ekd6eG1YNWgyK3YxODFwQ2RLb0FaK1ZmMkdkTisvck1Va0dXUVo5em5jTkRB?=
 =?utf-8?B?c0p1UTlIQTBPWk9PSTBYbGl6d0l0bUJJc0w5cmgrclZlOGxGRms0cTBEd1BK?=
 =?utf-8?B?V1BLVnlrRStCTkpWTjZVb0NvTm9IdWNBZHVOd3l6Y3VMcEF0T2s1RzRicVNo?=
 =?utf-8?B?ZUxOSGZ4M0d6M1VrcUlwdEh1azBkajkzSzR6cExoVjRLemc2VkFQbGhTTVZT?=
 =?utf-8?B?TnlEbjNvcExSMHBneDJTV3c1dEpKS3dlUUJXa1orcUF1NlZYdmI4WE94TUh4?=
 =?utf-8?B?OEFrc2IwVDJ6aUtRZ2xqbnFhSFdjazQrSTVDV2FTalNrS1EzdjBGV0c5dGFx?=
 =?utf-8?B?M1Joa1cwZ2plZHNTUndxQVRZODVYekJEaWN4OVNQY1VQVXlWQ2M4UHNXbW0w?=
 =?utf-8?B?aWtreUFoU0JFOTh5dUIrcTBhem1lbTBJcnhnTWxiaVdXaklDOHp2UFo4U2sw?=
 =?utf-8?Q?Wc/ZLPk/J6iMXWWg=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb45fd6e-5620-473c-ee98-08df3c41efef
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 20:10:00.7659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Ldj7EmSJJG3QDsNUwvfK/3SHeoZi2nP2Z4ksnooI8bcQdOCpLbrpw2yrxPM8Y5C2hFfYTByssVKSwoSdGre9OzbC4gmRrqa2Oll30m+4UY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR03MB7646
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Yixun, Zixian,

On 05-11-2026 20:10, Zixian Zeng wrote:
> On 2026/11/1 05:54, Tanmay Kathpalia wrote:
>> I am taking this series over from Dave (thanks, Dave).
>>
>> Testing v2 2/3 on a Banana Pi BPI-F3 and a Milk-V Jupiter showed that
>> multi-block SD reads in the SPL fail because the SD I/O rail (PMIC
>> aldo1) is at 1.8 V: set_vdd_mmc() sets it, and without
>> SPL_MMC_IO_VOLTAGE the MMC core never sets it back to 3.3 V. Patch 1
>> lets the MMC core set the rail, patch 2 drops set_vdd_mmc(), patch 3
>> is Dave's multi-block change, and patch 4 is Dave's probe error path
>> fix, narrowed to the resets because, as Yixun pointed out, the clocks
>> are reference counted.
>>
>> Not in this version:
>> - v2 1/3 (missing max-frequency). As Yixun suggested, the io clock
>>    should be set up with assigned-clock-parents/rates in the DT, which
>>    also works for Linux; that will follow separately. Hung-Chun has
>>    withdrawn his matching RFC.
>> - SPL_PINCTRL. On its own it links no K1 pinctrl driver into the SPL
>>    (there is no SPL Kconfig symbol for it yet), so it would not program
>>    any pads. It will follow separately once it has been tested on
>>    hardware.
>>
>> Testing: I do not have a K1 board, so v3 itself is build-tested only.
>> The changes were tested piecewise in the v2 thread, and in each case
>> multi-block SD reads in the SPL worked: Zixian enabled
>> SPL_MMC_IO_VOLTAGE on a BPI-F3, Yixun dropped set_vdd_mmc() alone on
>> a BPI-F3, and Hung-Chun set aldo1 to 3.3 V on a Jupiter. Zixian,
>> Yixun, Hung-Chun: a Tested-by on v3 would be much appreciated.
>>
>> Thanks also to Anand for testing v2.
>>
>> v2: 
>> https://lore.kernel.org/u-boot/20261005T135220-0400.mmc-v2-0001.DaveWK225@protonmail.com/
>>
>> Changes in v3:
>> - New: configs: k1: enable SPL_MMC_IO_VOLTAGE
>> - New: spacemit: k1: do not force the SD I/O rail to 1.8 V in SPL
>> - v2 2/3 -> 3/4: commit message explains the BPI-F3 and Jupiter
>>    failures; code unchanged
>> - v2 3/3 -> 4/4: keep clk_release_bulk(), only drop
>>    reset_release_bulk()
>> - Drop v2 1/3
>>
>> Dave Klotz (2):
>>    mmc: k1: let the SPL read SD cards more than one block at a time
>>    mmc: k1: do not assert the shared AXI reset on probe failure
>>
>> Tanmay Kathpalia (2):
>>    configs: k1: enable SPL_MMC_IO_VOLTAGE
>>    spacemit: k1: do not force the SD I/O rail to 1.8 V in SPL
>>
>>   arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi | 10 ++++----
>>   arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  |  2 +-
>>   board/spacemit/k1/spl.c                   | 21 -----------------
>>   configs/spacemit_k1_defconfig             |  1 +
>>   doc/board/spacemit/k1-spl.rst             |  1 -
>>   drivers/mmc/spacemit_sdhci.c              | 28 ++++++++---------------
>>   6 files changed, 17 insertions(+), 46 deletions(-)
>>
>
> Working fine, sorry for late testing.
>
> Tested-by: Zixian Zeng <sycamoremoon376@gmail.com> # Babanapi-F3

Thanks for testing the series on the BPI-F3, and for the Reviewed-by
and Tested-by tags (Yixun) and the Tested-by (Zixian).

Regards,
Tanmay

