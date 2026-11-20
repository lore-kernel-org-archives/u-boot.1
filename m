Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2638B606A331
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0mEY8mHo;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=P7xwLWHW
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 005A0812F8;
	Fri, 20 Nov 2026 16:43:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G95G6AovTx-O; Fri, 20 Nov 2026 16:43:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DEE74811D3
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795193004;
	b=k6QHOwZiMunWGhsLphIEOrXLMYiPl/IWjw6y8HRFGPX7qfPOGDf+5vmzyZjqikpQJP1y
	 Sz1ziQpz++kt4HuoaYr7GmdQ3BnTf2VhTXJC9EoOkPwxWyaMvlZhdxdovPiwRnX2o+w0Q
	 F/cHvrvgHQ9/sxv0tYXROX58O5fK2KsRk4g38Ws72TwNxSnCzfeOFURyBXmBKCBr4SHfX
	 NQXGId9DT0KtBhMrx5+WEEoq0v4ynuhPyUDeNHkyM77Ezfgakn6qLII90lxGL8gV5OXHR
	 w5NVfGqmalg6Q5yEYSyx82lvk2egSrazzCuYYT0RsWbCl3a1uXg/8sOi9MtslvazjWw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795193004;
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
	bh=UTIA0wlsO8CxaxJZ+MA/vI5P5Ucn+M4/HqaxKcRt+DA=;
	b=RqCVMzc06esicpxk4KhPmY15FWKqXijLvb/pF3GnzvwaqP91R4E5q5mgzsj9Guzp0yVv
	 6YiiZsOeQ3MtKev2kw6wJCxYhl496xL3HklmbTHvhSRSBWq9T+E1db1t4k9ptUVDwP2Jv
	 KGLqC117LdOM1iO4+vBkG7JZjg8pcQFaC/VVgSUirwa4TtaZCbk4eeXyrn78WQHSxEzsl
	 S8v87NpFtyiVTjzxIKjKQLRtWEfHca0MxwtDVf8tUy3a1emn1OJuW+d1AVktwNiyXDeBG
	 BIWPZWPqnz56blPJMZ8byiyF7fnaSCucAlxht8naGbb3iYPUnWwcuJvAVUcqe34sO8g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=P7xwLWHW;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795193004;
	bh=UTIA0wlsO8CxaxJZ+MA/vI5P5Ucn+M4/HqaxKcRt+DA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0mEY8mHomkTv2FL33zllh6opWFvmZ40ksvaUAGDs1SN709zqK/p2CcMNYuqSNT0XO
	 P7hwTVHxrzEaeovR0VTQ9F0qEoaNU5YDjM4OCxCmlRDJSs3ln7/HJXsT3ECnE5RFAg
	 WZKxgOlYgA3fERB/Yu4oDW+1FelYFExMtkzN4+XFROTFNxLj4HVsBgusQy1LPleFcQ
	 /tfyU/Vqaehh89sPyzbCegDv3SQqbeT5lX1J2wxKO+xy/MelWPH9HD+jh7H9KnTW/i
	 gKZHfv2G1VO0LkUGSLVSlH68FBia6ZWxhoTzILYlpq1q20BGu9t7+eC9VH4+ZKfu8O
	 pqq8y2PCKI1Xw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DEE74811D3;
	Fri, 20 Nov 2026 16:43:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 92F23E22
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 16:43:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 77F6C811D3
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 16:43:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3edFLLZwwf6U for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 16:43:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AFBA481174
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=P7xwLWHW
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AFBA481174
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 16:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTIA0wlsO8CxaxJZ+MA/vI5P5Ucn+M4/HqaxKcRt+DA=;
 b=P7xwLWHW1YKOjX9D9c8IEu1okcoZpS81/1AWFKxn/nqYMgj3PkNpVWxdFx1CUgEcD87adysuneua06qMJfBAnBNt9cvfNXMpA+yCEJfdV/vl/52AEiiubetmRpYSGASQcMq6UCg87GN+QrUjp8XeQxGIof+CqW0EPBpiS43dZV0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by GVXPR04MB10111.eurprd04.prod.outlook.com (2603:10a6:150:1b1::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 16:43:12 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 16:43:12 +0000
Message-ID: <77ff29fb-545e-4e28-be30-2a0e6c2fdff2@cherry.de>
Date: Fri, 20 Nov 2026 17:43:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: RK3572 / OK3572-C support on top of your rk3562 branch
To: Jonas Karlman <jonas@kwiboo.se>, Cunhao Lu <1579567540@qq.com>
Cc: u-boot <u-boot@lists.u-boot-project.org>
References: <tencent_907535C1D3F4C91824948CA407902292FA0A@qq.com>
 <eb5ff808-d165-44f4-8620-48d68028ff71@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <eb5ff808-d165-44f4-8620-48d68028ff71@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::11) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|GVXPR04MB10111:EE_
X-MS-Office365-Filtering-Correlation-Id: d4859f73-b134-4931-4626-08df47255d90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|261009223027099003|261021121427099003|261022075727099003|261022115727099003|261026140227099003|261026121527099003|261021135927099003|261028144727099003|261022105027099003|56012099006|10067099003|261102123227099003|11063799006|4143699003|5023799004;
X-Microsoft-Antispam-Message-Info: HTZdFmPgNvGtifx3zp40BaBqsLLec+fRZpKhd0a41DBD5qMepJxwkhJFA3FH1rrG+SXgBNl3KJu3sL0Xr+pozN4xDWTVGwmQED07xX7KFCOM/h4M7x1JR7lv2k59ZMs7wQrdr5XdXSAmmeWCab0I8oIvqSVKSaoYWRMtXXM6/Eze0Yv3e9FMljRhXLUP65btghs/CO3Hiy+6lqW0p/qIRFLgm5EzUnaEt8Lkv44CjvdQmOp4668uiDiedzHJ6VENJHh/I0Wgg3XQQjq3IR/5yGg6swoqZf4Ywy8QCOueKB5Xq67CPmDEUJyvn9osY4TiHKnavVCbQcaRXepAEKdw7FPIJ/jFgy55Fbv4jXHagBphOeUqyRi8bGXHSNDkw50btd489rLOV5TiygtRiWLCoz59pzS3kOq6goqHDe7ZQhoOuU1cPqJjjWMR/noZJJwaUf7UAXX9GhFI7LXRaOKWYlTatELVuQUkmAKvdTadzYrVNMu8WiI3NfT9cU2KcoKQjPSmHo89LrSgbk7DjDLmbxBh3ZJ2QpeuI3wOyCcCdG/sWHJsB+YsScqrkfdEk49gACa+AQ6N6qxjD8G/k4rvDEe20R7nBKREUXUaVZoIR59FGUPJ8QAp1ZGOH6pvXvXK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(261009223027099003)(261021121427099003)(261022075727099003)(261022115727099003)(261026140227099003)(261026121527099003)(261021135927099003)(261028144727099003)(261022105027099003)(56012099006)(10067099003)(261102123227099003)(11063799006)(4143699003)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmUzYzQ5UlI2L1FoblhadWRhaGF0M3BlREsxMGdZNXdGbXM5TFA1OVBEbjB0?=
 =?utf-8?B?SjZaYk9qcDhITWhpNGViV3JNV05sQk9oNDRMVEhueUFuMmZnOTJEZUNOQStr?=
 =?utf-8?B?cktXaHdVL3VOMUd6aVpteW9GRWo3a2hMYjBVdUZaOFhzMkQ2amg2ZG1NTTZk?=
 =?utf-8?B?LzFJSGNXTkJUY1Q5QUFwaHNMb3EzdWt6ZU8vL2JrRTc3ODVaM0xRaDI0M0ky?=
 =?utf-8?B?M0Z0bkNZaHNCVDhSekF3RjNIMmxBNktyNGczYTBnVkJId3NUSVNOZFlKZ2Nm?=
 =?utf-8?B?RkhqcGRkbEJPNU9FM1BXaUNmV2RoK0VYdlFHRXYxa2h3dGEwUjdOeHgwdERC?=
 =?utf-8?B?ME1keWJmWFRjVUd0NlJsa1FhZno0eWsrV2laTmpHaTNtVDFYRzBMTnpiWkFK?=
 =?utf-8?B?NjFtekdVSG1nRGJQV000Y2NUazRhWWxQbEZqNlk5SGhWT0Zxa3U3VksrSENr?=
 =?utf-8?B?VzYrK2hCQnVBaCtrMnBISlR0TkNreHp3eXY1cVFHdlJYc0VjakVCNUVMKzRq?=
 =?utf-8?B?MUFZSVcwbngwS2NnaEJBODB2Nk5iclk2Rm9hZHpGRHlFWGx3dGVnNUJpOEVC?=
 =?utf-8?B?aDQzN3JGTUJoemNzUzFpWDNFVlU5TDBIOTRLQzRqVDBqdk5UL1NYSmoyUkYx?=
 =?utf-8?B?NGR3UDRXemlPNEhFTHRwcHJNYi82b05rNld2cjEvQlpBRlR2Vy80VWthWmh0?=
 =?utf-8?B?bjdjNDBXM3BqNzJFTFpJQkFDVGt6eWg3Z3NXeHYwcW1kYmRObVN1OFBuVWhs?=
 =?utf-8?B?aUd3RkxIaHZRelZnaWc5Ym9SaWJKSDEzQ3lkZEJOQVUwb21yRmM4Wkx5ZFFS?=
 =?utf-8?B?V0pBT3NUZGhhdUI1MEVsWkdXZjdHbTluaEFMY1NIc0lrQzkwZ3FkbTA4UmRM?=
 =?utf-8?B?SnZwVFNHSnlZRmh0dEk4YVhIcFVzVnN5Z1VJSXJtMTFkWmptaVE5cXN5UVRR?=
 =?utf-8?B?d0Jnd1NvVjl0clNsZTE0ems5azFXMWs5S1MrcFYyTHgySCtEOGZaRkVsNmFr?=
 =?utf-8?B?dy90akdmamhVeUtlSTJzOGMrYVJWYmVxaFF1T1NQYlN0a1dnc1BodmdWTFBr?=
 =?utf-8?B?Z3Q3TTdpbmR5TnJRTnNZbkswc3QzU0FCdzRHZjlrMC9kZVdXMVZuL0NjanJz?=
 =?utf-8?B?WFdqQ1ZIUHJGUkZkSXROOVhLWGZxajkrNkZBU0kwSlBmZnBld3BlcFRmS1dI?=
 =?utf-8?B?OWFNRlFTenU2WjRFNlFrSVJYQVhETy81V0VBVEphOWE4dENJVUhyK2JBSEZD?=
 =?utf-8?B?Zi9RYUcrM3lDYlJ5Yjk0TFhKaUI5MU9LODZtVjBTakhyUkM5NU4vQ3dJWHM2?=
 =?utf-8?B?MmFIZnExOVR6bGY3VmJ3L2RlSlJ3djlzVk9yRVYxMlZtczlFVmtiTmcveUlq?=
 =?utf-8?B?RTloT3VocU4xbFhMS1k3NzdrQWhFVnF2OXRBY0NEZEx4dXFzb2JPYVpmejJl?=
 =?utf-8?B?WkdCbmY2WUd3YW9jYndqUnhVRnV1V2FSZGJna3htZXVudmxqSkRlRWFQZnMz?=
 =?utf-8?B?RUR1ZUl4cnAvZnJKWTZqVEYvSnJpVU9kWmU5Q2hLbVdHc2lQMEhLNVorTVpx?=
 =?utf-8?B?WHlBbXpjQjkwM3BDMGVydnY2SW95Qko4N2k2U0pOZ1drNmhLOUVnVnVtTGFz?=
 =?utf-8?B?c09WZHlodER2NUZkM0ZlREg4WTJZb2grdk9MYVhOSzdKdFVPSG5DckE1ejYw?=
 =?utf-8?B?Yzhxdmd0Y1cxOTI0RHNhQlJhakhRR3E4TTBMWmU4UGR6bk5hTnE2cUtadEI4?=
 =?utf-8?B?L3NLTEtPNkc0WFJNMXFLRDdyK2ptSHY1WWJaRnYySjdpaFdZQWFTTkEydk5O?=
 =?utf-8?B?N1BrdzRFUDAydGVOMzlGaGdkbU5iMHdyUDhSdHhiRXIwbXdWYmJQeW1nQ1hL?=
 =?utf-8?B?STVCQjVMdzViYzBiNU15OGs0REcyL1ZzbWVrS1ErbVV5UzYvQ3BCcDZIbndj?=
 =?utf-8?B?K2VTbnB4T3huV0pqci9lZWMweE4zcjgydHhNQkZpUzN1VmowTWNyMk01ZDla?=
 =?utf-8?B?MnJvYXRSbGdKcVVZdG01dG0ybzB5ZHpveXRVNFhwWFk4c1dZbFNlcm1jRnlh?=
 =?utf-8?B?b0V3TFlORnBlSGdsdzVTWllSaU51bmd3SE9LMVlBYXJoMHZoZGdzdEhLUjd3?=
 =?utf-8?B?Tms0bk5kMWY5YnpXVjlVWlpRNkFXbUd0U1lBRUJJWS85eVJNSzdQRFVLZXNP?=
 =?utf-8?B?RHBjZngza3VzSmJwVks4c1dOZWZPZ2kxNjYrYTNhZHQzdWFLNVRVZGVPQ2lR?=
 =?utf-8?B?M1RhSXlnZkpSV2tOU0dFNFRMc1NpRmZEVk9LTHU5YjRtVEtnQVdPdXczcyt0?=
 =?utf-8?B?SHRJSHlyS3p5NjJrN1ZLTnk5U2tlVFkyOTdvbnpRRnp2Y0ZKREd6Zz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d4859f73-b134-4931-4626-08df47255d90
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 16:43:12.1287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dPvOcaYpj0REh8MefFRebcAyDtWmCPrM6LqbYofjSUokq7AI0jFIVUSZETAxwZDl23w9TffVmbavT280NQ98g3C9DimK36hM895hiAXLvHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10111
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas, Cunhao,

On 10/22/26 9:16 PM, Jonas Karlman wrote:
> Hi Cunhao,
> 
> On 10/19/2026 9:49 AM, Cunhao Lu wrote:
>> Hi Jonas,
>>
>> I've been working on U-Boot support for the Forlinx OK3572-C board, which
>> uses the FET3572-C module. After finding your RK3572 support, I rebased my
>> work onto your rk3562 branch and now use your SoC, clock, pinctrl and RAM
>> drivers.
>>
>> I have three follow-up patches:
>>
>> - Add optional RBOOT + DDR + SPL three-stage image support to mkimage.
>> - Add optional RBOOT firmware support to binman.
>> - Add the OK3572-C device tree, defconfig and build documentation.
>>    (With Forlinx OK3572-C BSP Alpha1)
>>
>> I have verified the complete boot flow from eMMC on the OK3572-C. The
>> bootloader, kernel and root filesystem are all stored on eMMC, and the
>> board boots into a minimal Debian 13 system.
>>
>> Do you have a submission plan for the RK3572 support in your branch?
>> Would you prefer me to send these changes as a separate RFC series based
>> on your branch, or coordinate them with your SoC support series?
> 
> For Rockchip platform we typically require device tree for new SoCs and
> boards to be picked from upstream Linux (the devicetree-rebasing tree).
> 
> So the first step is usually to upstream dt-bindings, device tree and
> core drivers to Linux before patches for the SoC are submitted to U-Boot.
> 

Just to be clear, the limitation only applies to dt-bindings and the 
various Device Trees, but not to drivers. You're free to submit driver 
support for new SoC whenever you feel like it. Of course, without a 
dt-bindings agreed with upstream, the driver may not be compatible with 
the dt-bindings once finalized, hence why it's a good idea to wait at 
least for the dt-bindings for the driver to be merged in the Linux 
kernel before sending patches for it in U-Boot. I think it's a 
technicality since they (driver and its binding) are usually contributed 
together in a single series, but you could do that, that's fine on my side.

> My rk3562 branch contains a long queue of new RK SoC support, some are
> waiting on Linux upstream support, others are waiting on open U-Boot RK
> refactoring series and/or other mailing list discussions. eMMC/SD-card,
> Ethernet, RNG, OTP, SARADC and USB2 should be fully working for all the
> pending SoCs in the rk3562 branch. All (or most) patches in rk3562
> should eventually hit the mailing list, at least that's the goal.
> 

I think I've caught up with all your patches? Three series awaiting a 
new version (or feedback) as far as I could tell:
- https://lore.kernel.org/u-boot/20260805174509.2968252-1-jonas@kwiboo.se/
- https://lore.kernel.org/u-boot/20260804214442.2592597-1-jonas@kwiboo.se/
- https://lore.kernel.org/u-boot/20260804105721.2402406-1-jonas@kwiboo.se/

Is there something I missed that I should be doing? Let me know if I 
somehow skipped a series or if I need to act on something.

@Cunhao, the typical policy we have is that the first who contributes a 
patch usually gets to work on it until it's satisfactory and can be 
merged. We also typically do not care about unofficial trees, however 
close they are to upstream: if you have patches, and you feel they are 
good enough, you can send them even if another contributor has their own 
patch for the same thing in their tree (and haven't sent patches yet). 
Of course, do not go to a contributor tree and get patches from there 
without having permission to do so. Please do not use LLMs "to be the 
first" (or at all, we don't really like those here).

I know Jonas has many many many patches in his tree and he's been a 
relentless contributor and reviewer for anything Rockchip in U-Boot (and 
I know he's very active in other communities as well), I'm very grateful 
for that. I'm pretty sure Jonas was careful not to send too many patches 
and overload me, so that is also very much appreciated.
I'd like to both avoid duplicated work (Jonas and someone else doing the 
same work) and also putting too much pressure on Jonas by contributors 
"having to wait" for patches to land on the mailing list to start/resume 
bring up of SoCs. "Putting all eggs in the same basket" kind of issues :)

No promise on when I can look at patches, I'm the sole custodian at the 
moment and there's some decent backlog already :) That shouldn't prevent 
you from sending patches to the mailing list and/or reviewing other 
people's patches to help out, it's just that things will take time to 
eventually get merged.

Cheers,
Quentin
