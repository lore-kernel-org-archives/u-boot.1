Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C105D606A31C
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 11:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DT1vXXr9;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ab3/AF/e
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8FF2D6101D;
	Fri, 13 Nov 2026 11:46:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hJIqVw7aPLBF; Fri, 13 Nov 2026 11:46:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CC03A60B0C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794570387;
	b=qBMkPfDdLid3AVP0DAuHf/5jCK03kQg+V3+uZML2wv/YRdylQFwiv18h1lC1nc/sfVcS
	 kRDLlaKTKLynK1doJWAPBQ/N+x81JBYKB1Ugp8AOK7aPmvCByb3/WbsmYKFFLYumqlbxV
	 h2NSSCx32QkqCnE2OoxuytQGBuKCNtx4yc8KEqVD2Ng6fS0PhSZELJUEM4J26JoHcWuUD
	 PSypiW8yqbwHiao2fgGQqw8TiMJHaZIEtl6wasVL8W1dvIMW9z+p7xZwL6ePg/0y5bOZk
	 8GmZePaAA5P5PZvmi8ENi3McUyJ+QG2xYl59WPRL5WqvVUv/zpRNPIURJulfwSXC6IA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794570387;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 From:To:Cc:References:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
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
	bh=IPjYQ8nLNJmTEiSw6XdByYF5nPLuu5gkOGWkNEv2feE=;
	b=pRiZJX+v5C/qQHOc7fxP9c8w/FJUF6mNFu5LN4sv+uWFEYIxdH8KiwtfEycQ9UwEeLt5
	 NABaJEjFy0jaNPRUo314TWFFOnxcl0rjda/HJJo1RJ8JwcQoNY8WKac5th+wM1DwYH8zx
	 pgCe/Bvh4IUp37kKsjbbIPuki6pF7+UfXfs/u+UZ64cpkwxlt2aUYRjqsKmvF4ypt+jKF
	 qR+2mVPnJ2Ub0IJFTBmd6yumKiscnpMAxxW1MwOnN9CWrDfh2M9RqXAgbN9+QaQ4IX0rp
	 X0er4m9fVtawvccWojwKhtt4R8kC8KZrCzL0k395nDcpZq2tYDYbnrmkNvIAb3XyvBg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794570387;
	bh=IPjYQ8nLNJmTEiSw6XdByYF5nPLuu5gkOGWkNEv2feE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DT1vXXr9cC5rcLCwVS94fVtOv8P9nSxjGQLaobAtvE8O+0Lo++AKIHE/V4BYnyDi/
	 X91hAR1WUFgKbKRN81DcL468Q57bqPNyNiFNJi0jWAe5mMeQ4GCTvam9PdgH0e8tjc
	 D03EbUoEaBxZ+M2NS6eBPT8JSDMPMmLOQE1KiBo4ETMiWIptUegbZYwotxQY3LuTLL
	 IeyvyRJaND7AxEq9hOC2Hy+B4TdtRUB1OXky+7INrprluxXsQEH/nACvC9RWkeLlJV
	 ipRr99AR8Go1zma4itpMpq+Ck4xQPOYP1Ttzq9LpSYOJHrlPojuwEmlvtqRUvWuNeT
	 aSTneA27NUWcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC03A60B0C;
	Fri, 13 Nov 2026 11:46:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F814D7
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 11:46:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5544740E38
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 11:46:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V_EemABilnsz for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 11:46:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8776C40E30
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::1;
 helo=ph8pr06cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=ab3/AF/e
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8776C40E30
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 11:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPjYQ8nLNJmTEiSw6XdByYF5nPLuu5gkOGWkNEv2feE=;
 b=ab3/AF/e2+GlbE/k70fU32M0wX6KR5trvqYpkOT2b7n9CbtcGPBtLfzzqqmLj8Wni2Eh+eI7x26htIwBGYFecjAQTtF+GWwQqinx0IIwVRB15Pc9Y0uiRnZFgQgr6UZle7NyvRg4z3rVrAwEeLpDi9Vd5Eyr+Ojl40AlVq0SRsg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by LVXPR12MB999195.namprd12.prod.outlook.com (2603:10b6:408:3dc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 11:44:17 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 11:44:17 +0000
Message-ID: <f6b90ccd-d474-4000-bb36-b7ca6eac0f04@amd.com>
Date: Fri, 13 Nov 2026 12:44:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpio: delay: configure wrapped GPIO as output on first use
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.u-boot-project.org, git@amd.com
Cc: Pranav Sanwal <pranav.sanwal@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <05b8bc65fe5c2cdc8b93400570b9f77f2684e571.1792504199.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <05b8bc65fe5c2cdc8b93400570b9f77f2684e571.1792504199.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0214.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::10) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|LVXPR12MB999195:EE_
X-MS-Office365-Filtering-Correlation-Id: b8edfc6a-789f-4eaf-cc99-08df417b72cd
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|3023799007|11063799006|261026140227099003|261021123027099003|261028144727099003|261021121427099003|56012099006|261022105027099003|261009223027099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: KhFFoaQLb/5vr9K8TmeiRM3jmnRabJ6fLiVwP26KoNQsUrz9yzNQ/hmzGLMIGqha9z6HQVtnSjAZchKYrWCMwl9d75M/gAbvpU2msFKLbjMj4VfefNg0JncQpjiy1JwJubhBS2dMBYhP9ABPivAKxuIsNHGgrSOLa9uIKq7+1IvoD60a6na8Vyf5GZkj6YYde23PtnHXHiT2CPmv5VLZ4DujJ8weBSgT6d9fQolo4NtPg873+ZEWpTOC40x+PRcOqBVO0RnB3cxbkHc23nJMV0O8nPNdWnmoLpIWxsXteqSXYtYeZAUgKb6PSUchtfCDFiqJ7kH0PMs2IzWoHlBZtIk647+lVWWh1LWWb77R0BE3K2vFd/IGEyHk0Fg+TV4NoImS1/me4RfAysjmWGukhzONaqe1J6AexuyafTcVLRc5zZ2WggY+oMJUbxm38N33gDAVRkZp38Y+We9MWxBA5tO1PR4FlF2TBww2e17fufMSUcXlh0026LnpWC3Fqmzeq7XFneR8ZOmOeH0by7MBYCxBZeZPL7JwK0CPWayumDaEwcUJ+rHmdk9xcjH49CEJ9SBBUDwzbCHWbUi3gVMY+xq9d8g+z6lHvRPgQyrymEGDBfM6ON/GMqz3GUX9n4iotxaTszytoaXDiv7O5N5hjbYaIX2UO6neVyxJ9FwvCJU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(3023799007)(11063799006)(261026140227099003)(261021123027099003)(261028144727099003)(261021121427099003)(56012099006)(261022105027099003)(261009223027099003)(261102123227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGVjUnpWYVdlaFRZWHVNSXI4ZENUQlJOYzhXOEVIT3lGMzVPbUpTLzYrOGdo?=
 =?utf-8?B?dExKVjEyNktRZEo5dk5HZklqRlNKUEFENm5EYTcrVFVJM0JpSFpDcGRiR3Rl?=
 =?utf-8?B?OE1sbWNJQTMrVGk2c0J3aTJHSXFGdUFmdGh4YkEvMUZ5K1hkc1hsLzlRem8z?=
 =?utf-8?B?NTVCOUhIM2tlbStveVoyVmhJbFoyd28xZTZ2L3M2VmdpOG5WdEpiT1lmWVBp?=
 =?utf-8?B?aHJFQ1lJbGVRazdpanRYMjVlTkE3N0dLVDJmTVdGZ1V6TnVzNEFOdFNIWWdh?=
 =?utf-8?B?dFYyVjFpNjFXQ01qUU5QUTRwemx3V2EwMkVyRHIvbEhGa0YyQ3NkQklRRlhE?=
 =?utf-8?B?cjQyS3hUTWFEeFl4ZWc2b3UwU0xxb3lTSVgrMzVqcGx4b1FKSVR4V0J6dUdP?=
 =?utf-8?B?L0pwOEV6RWk2Vm1ocVZDeEQxS3M5cDZ1eUc4RlFtUSs5TGRKWE5HbTJmYUp0?=
 =?utf-8?B?STQ4R1hVMUtpa2graUI5VFRtRFlmcjdFWnd2WTlSZVk4ZGYvclFmU2YrM1BB?=
 =?utf-8?B?NG5yWmg0Y2JhZlZKZGFRY0QyV21zaSt3SHhwd1JpMG5sZUU4Z0lIZE8wckNT?=
 =?utf-8?B?Q3JKUVJoRFBqNi9SZ1lMMnBZUTFJRWxHZVJiaGlrYkdWTkhYM3Nma2xMcmVp?=
 =?utf-8?B?cW9iaDk3KzcvWUM1TGhGT2xoTjlnOGF0T2E4cTBnNmxtWXlHWHpyTXVMRHVO?=
 =?utf-8?B?L3c2cU8rRURvNHJjVEdRK0s4cGZUd1RHQWR1SFJiWWxmS2lUNWc0eFhwM2Vu?=
 =?utf-8?B?M3RGZ0g4ci9CSlJJWG5iMHoyUERZQmpoTDdvbno5djd5L2p6Q2FkYlhqUklB?=
 =?utf-8?B?RFFMQ0JMcW5Qb1VBN3JQOFRiTlEvQndsNzdmb3lHa09DK1haaGpvK3ZGeTRB?=
 =?utf-8?B?Qi9ZblU2U1ZNcmwwbWFOUmpPMElzd1I4VjBhVFVJa3hYQlVRL1V1a2ZlOHVB?=
 =?utf-8?B?b0RJRzVpRzVKa0hFS2pDdUFZSWRpbWppMkx3SnhZUTRtb3BNdmtTc1BKNWtK?=
 =?utf-8?B?MDdoNFozOTZYTjljVXVMN1FqaEFqb1l1WHdaUGNKZDJGZ3RhOW1aUXY0NUVs?=
 =?utf-8?B?WmVzd01QY1lEZTFoVEE5ZVMxV2tlK0k1OUJUcEhGZWNDTnV3V0s1WTM2N2I2?=
 =?utf-8?B?VDFmMWE2S1FoMmd1NVhKMGtrU3VGYnlYNDRBYjRsTlN2N3lWQmxTS21MSGc4?=
 =?utf-8?B?bmk4b0xBNmVlamprU0cwcEEyODBMRmNjVEM4YnBLTTAxYzNycWo4ZmI1Z0pM?=
 =?utf-8?B?aGkxV3EwQnFzOGNFbldYVUtubS91V2NDdDUyakdEck9lanpaYnVHZHlkd1hE?=
 =?utf-8?B?TWhsOVpDV0pmV0VDekRlMm45RjZEb0U3VERhNnpIYXRHOXRFTXhUQldvWGRT?=
 =?utf-8?B?ZlNST1RjdDZYQXhYSUFXN1JScFcvUFVxRUNpbFJkKy9TcWl6MVRhclc5Kzhu?=
 =?utf-8?B?ek42bVdVWDZFcndxSFRKL2I4QU10VHBXN3hQS3dWWnVRc0FTNng1Qm1jVTRV?=
 =?utf-8?B?T0JaT1RkeDNRUU9nSXZXU0JRT3JLOWxGb3hoeW5oZ1JyT3cvSHlpT0hxNW0v?=
 =?utf-8?B?SXViSFFuVkNKMEVKQlMwTUg1ZFVHSWhqWFREYjBvVElVVXVOWTRidTBtbHBC?=
 =?utf-8?B?eXNxdlZVRVViSEdvS1lCeVFlT3pxdEhVV21lQ2ZtMEdUSnNBWXJwQmgyUUx1?=
 =?utf-8?B?bjZBS2hDYTdhdVlEYjIrVUJwLzQ1V00ydHFSSVZ1R09qM3J2amdCbVRvcndD?=
 =?utf-8?B?bS9aSU9KMXpsa3Q1dUlnT0twUkdZSGFqWnYzN1ZSdUszTE9LQkF6M0NkazN6?=
 =?utf-8?B?QmFMUjR4T3pMYWtVZVpFcjRtWDdSS1Bkcktka29SNjBBb3pYd2R2WnFweHp4?=
 =?utf-8?B?YlFTbVFzcjdVQnM4N3lsNVgwVERKRkZldzE1dE5PUko1OUJUQ3Zud0xOTFdx?=
 =?utf-8?B?VVF1bUNGOHFBeFQwRE1LMWhWd2RvdTBoVDF3MnFndDRBd1NpeVQxRDV2ZE9H?=
 =?utf-8?B?UWxpL284NzRhUVk3RjAyRGRxV0ttZHRzaXNWbWxrQklmcVJOMW5wWFVxOVRi?=
 =?utf-8?B?NVgvQ2t6WUFVUU9pTElPWWRXN3N6TnQ0S0h3UkdPTTl5bjNIR0pBWmRNY2Z4?=
 =?utf-8?B?ZnZUNzl5OGhsTzJ3ZStZQmt4NnBiK25zeUNzOGROdGsvS2RrMHJ3RHhPODlw?=
 =?utf-8?B?MDVwa1NXbzMyWVFGZVR2L3ZRUkQrNnF2MmltRjBUZmRnVjBuQVA5N2h0Sk0z?=
 =?utf-8?B?UG8xdTRGS05CTGtIbzRUVVdlTGV1bVhoTkVCY01zc3cwdzhqb1MzUnFRc2U5?=
 =?utf-8?B?SkJzVG01T1BwYk95UmNSL0pLa0lSWUp1bjBncHRBUndpa1dsRytMZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8edfc6a-789f-4eaf-cc99-08df417b72cd
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 11:44:17.3410 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oVR2LU3HC7KTTENEepJ37bHbRBpZMaIJrcYUl5aG3NCy3hrMZQpNtS+YS04CnXFw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR12MB999195
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



On 10/20/26 15:50, Michal Simek wrote:
> From: Pranav Sanwal <pranav.sanwal@amd.com>
> 
> gpio_delay_probe() requested each wrapped real GPIO with flags 0, so
> direction was never configured. On native SoC GPIO controllers the pin
> stays at its default input/tri-stated direction, so gpio-delay's
> set_value() never actually toggles the pad.
> 
> Rather than establishing direction at request time, defer it to
> gpio_delay_set_value(): use dm_gpio_clrset_flags() to set GPIOD_IS_OUT
> together with the requested GPIOD_IS_OUT_ACTIVE state. This way the
> wrapped GPIO only becomes an output the first time a value is actually
> requested, and that transition still goes through gpio-delay's own
> ramp delay instead of being driven silently at probe.
> 
> Fixes: c866f2f197e2 ("gpio: Add GPIO delay driver")
> Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   drivers/gpio/gpio-delay.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-delay.c b/drivers/gpio/gpio-delay.c
> index 747c520fb46f..5caa6d750460 100644
> --- a/drivers/gpio/gpio-delay.c
> +++ b/drivers/gpio/gpio-delay.c
> @@ -41,7 +41,9 @@ static int gpio_delay_set_value(struct udevice *dev, unsigned int offset,
>   
>   	dev_dbg(dev, "gpio %d set to %d\n", offset, value);
>   
> -	ret = dm_gpio_set_value(&desc->real_gpio, value);
> +	ret = dm_gpio_clrset_flags(&desc->real_gpio, GPIOD_IS_OUT_ACTIVE,
> +				   GPIOD_IS_OUT |
> +				   (value ? GPIOD_IS_OUT_ACTIVE : 0));
>   	if (ret) {
>   		dev_err(dev, "Failed to set gpio %d, value %d\n", offset, value);
>   		return ret;
> ---
> base-commit: c5a62cccb6212fa870c46c08232358f4712c954d
> 

Applied.
M
