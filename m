Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC2A606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 08:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ff2Ssmbh;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=JKhTugRl
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6062F409F4;
	Fri, 27 Nov 2026 08:25:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 31GKPDVdgCVJ; Fri, 27 Nov 2026 08:25:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 93E2840911
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795767925;
	b=hMmxkECilu6TuL1XE8Lv4y8bnvGV1m3idAF3YHAXyQe7z59aBwaF8VThx9t7t7Y/LDjZ
	 CDAtlaGRZdb5VZJJ1JEyCKZ05Dj007PVJDQfWmqHxrhKYDC1OdIpfL5i6xCu6JK9aXWpS
	 AKS1uASzPDf4NPBKVXWO5Hw/JV74uahNkKA1RSOdSiwbZgtrFcrpGOSGsbIE2zHr8IOoq
	 UhDBXC4WhKzwLXXd6utVpN6Spr33ze21dFXUXMC/5utG9kdYbzdWq7NVyQoGENjyLb1hg
	 EuyOfAefSgXUN1Q+7Fmsn5/kbCdjKx64XGyCmwQm4cZQSbjT6zSKF3vt6dEpV3lKl4Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795767925;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
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
	bh=c8WLaVO0vmZLrgaBRAQ/86+GQcu0ncKxjMnARFKkpMI=;
	b=DolQT+HqIUpje5ORcyU+X6FhE2ESXpFuEuGdgbgHmKkn+wtvBAEO1qm7/7O1mZx0rEHo
	 Jep2VL67MMIVDRlPMiHkIgo5QyctKAII9rDbItzZiGrFaLGehcsomPpVfnJ+DlXT8iJbd
	 Nt8P4fL66LO5cBHW/YHpkjJroTMf8ezaBbqoePoCN7Zt6fZBQKEK2MLn+DgKCXKDSHHBa
	 E/I1/lw1zFcfofvGv+o170SSmsBYTVM3lt/CADJevT3VLnrxKVmDydwW3vodH6Mlr3Ft7
	 uQ6pO8YymovqziFUaXR1r5cBZji70Iv9r9gRJ8bq4QQd49J/hrOGjYCaQ+qzLLgRqWQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=JKhTugRl;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795767925;
	bh=c8WLaVO0vmZLrgaBRAQ/86+GQcu0ncKxjMnARFKkpMI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ff2Ssmbh9SFh9oWTAyNBQL2+1MSfTgAnvvbeyPolUzjXyqptGDHZimSOS9eAISycf
	 tLOOW8zFpNVL8fZBn17hS6cnOLKgq3M9QDedLJ0bY4azyBwzXux0BrSaIOnU8bJVxf
	 SLJA5RP0IRJ67wEyat+7sba4/23Rxik8jUACBEKrOyy0wvIR5C6wxMXH0Qv/L54lZo
	 55bHEB6I2Fsv56qn/bvUsJb4XsCvdIOeQAa+ihbU6OeSmvAEVNroo7kWjZzKZbsHfI
	 YSKKFIUH+IFhZsL1wQUrBQtU6rM/C5I0vKZjXjPALw+eEeueDWssPQ9qBNZXy2tVmD
	 7NZS+iOnG/G5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 93E2840911;
	Fri, 27 Nov 2026 08:25:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1BBB1325
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 08:25:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 18E9440911
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 08:25:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9XVyaXtfU1JH for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 08:25:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C714240902
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c111::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c111::5;
 helo=dm1pr04cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=JKhTugRl
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C714240902
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 08:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8WLaVO0vmZLrgaBRAQ/86+GQcu0ncKxjMnARFKkpMI=;
 b=JKhTugRlI8gU1INaiJg2x6TdD9rj92Y8eBk55SE9zPRMGPs8lvQefKlCk1P8QF9hbA/kqrMdv/ly+HlKP1cAi2rCeHFTcWEdC9np1MnOzC1IkJInSjpchfKJLEg69iL+sKAtLhqu6oIZiwV10pFKcv1B8FkZdPho0Difu9aU7Fo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PR12MB052986.namprd12.prod.outlook.com (2603:10b6:8:47e::11)
 by IA1PR12MB8261.namprd12.prod.outlook.com (2603:10b6:208:3f7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 08:25:15 +0000
Received: from DS5PR12MB052986.namprd12.prod.outlook.com
 ([fe80::4e51:5777:a687:af48]) by DS5PR12MB052986.namprd12.prod.outlook.com
 ([fe80::4e51:5777:a687:af48%3]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 08:25:14 +0000
Message-ID: <0341c17c-4bd0-4fde-99fc-f61d4f34593f@amd.com>
Date: Fri, 27 Nov 2026 09:25:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] spi: cadence_qspi: Versal/Versal NET OSPI fixes and
 improvements
To: Padmarao Begari <padmarao.begari@amd.com>, u-boot@lists.u-boot-project.org
Cc: git@amd.com
References: <20261028111123.1198451-1-padmarao.begari@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20261028111123.1198451-1-padmarao.begari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0065.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::42) To DS5PR12MB052986.namprd12.prod.outlook.com
 (2603:10b6:8:47e::11)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PR12MB052986:EE_|IA1PR12MB8261:EE_
X-MS-Office365-Filtering-Correlation-Id: 146d0988-4cdd-432b-f5f2-08df4c5ff644
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|261102123227099003|56012099006|11063799006|261026121527099003|10067099003|261022105027099003|261022075727099003|261021121427099003|261028144727099003|261021123027099003|261026140227099003|261009223027099003|261009223327099003|261009221227099003|261009221727099003|261009220027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 09+yftSnU5rmQeFDKmEC6x7YbXwlwP5pSolOkCnJZr5eNUGRdA1RcKzIXZx53G+GU2vtKX4GT8gyGw062vP0RTuGMmm6Ttxx2VC3RiaPqtBDvQjT7n2c1bDl8xT+UDta5knk0mvQOKXGBkuGdo4wDvBpTQCKyauAsgtuJXfSZk1GlNZPt2SkLX7yYEOT0JTiWpATBZ6XKY5x1ZQVzZNGttvEGXAj9oPpOPXplaUtNjlbxPrPbFiQZEwpXvmSKVf/xVtU3k8Tzi+gzDxNosJdHV67Bqt0eszrj0nGyLDS1aYhajCdbU2ipvNSZZLlILyvd/t18W0CHjNf++EAq/F3eVPvUSo85CxMTt7IKRGAivDlVrPHICyJ9xP7vh2Gcxm0P0o64+p6u3QjH1BUQcXGI+GaF33nRtKYRocSghwze1EN97Mbnm8zKiEfRLE39QUH6j8onkfwXQFDzEJuAhVSgCxP/PZgasdlCHj5v0pW6BBu+T/JwVwmtI5an+6zu1VAPpYM53WZTuXNbxS6El0oxdvl8eB297VlzNZA8A8t3wjXQ2pQIwbDgzeLl3apCjJDO6kQtoPHLebzpguKwtGpwu8/m+Oy4HigJcBCLi18T2yJw0wFHMt7I3m9uNb4HTyZBGRlq6vqUneTjLvdhhj8Bg06/bOxjawCrfXbXPPbeas=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PR12MB052986.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261102123227099003)(56012099006)(11063799006)(261026121527099003)(10067099003)(261022105027099003)(261022075727099003)(261021121427099003)(261028144727099003)(261021123027099003)(261026140227099003)(261009223027099003)(261009223327099003)(261009221227099003)(261009221727099003)(261009220027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWxQcmFrWlY3eUpIaE12Y1hhdk5rekNyWHY0blkxYVp5SzFtZUNsUk8xRkk1?=
 =?utf-8?B?cjc4cDJTMEgvK21NWlNnMFhESmdyT3psdGlFQVk2Yi9uQU1OczgrNklxZ3hN?=
 =?utf-8?B?YmsxT25RSTFwK3JCZ1YwTGN0Y2pNVis4QzBVODlqVHg3R1BVY2x2TG5FZTIz?=
 =?utf-8?B?TkZpNUxjbkIzRXVpMUtoTlBTVDJjeG5HN3dwdWtuSUNtMVdLemw5eWRFTk9R?=
 =?utf-8?B?alF3M1NTclZ6cW1qZzRBYmJMSFRaUHZINkJHT2FjZDdwMlFVSEh1SFl1dFQ1?=
 =?utf-8?B?NEx0MTNtSjZmSGlZbEVmbXBOV0NoTWRGSXpZbkNiNXRoeGszZHVpZlRZUUhw?=
 =?utf-8?B?dkh1dHVrMHZ1QW1GV2VlME5uaEZsTEF3NTZXRHExZFdKN1l0Q0RnU3JmRUNy?=
 =?utf-8?B?SWxycCs5RDhCM0tLakpWUmgvdzdJRU83MnNwMEgvb1cyTi8vaFVsL1NBVU1Z?=
 =?utf-8?B?RFh5a3NPOWhhM3ByeVB1eHdFRjRKMjFuTEN2cUVKMlhqb0RRaUErZ2JITjZQ?=
 =?utf-8?B?UDU3YWpodkNJeDZpV3hxVGZFaVdRQ2dGT29LdnFRT0VzWlZEV2x3Vi80Z1Fr?=
 =?utf-8?B?RVRIKzVtdjlBUVJFNjFGbUhIM29iZkppb0hjdnNsZFowdUlUZ3MzRHVaUU9Q?=
 =?utf-8?B?cjBsZ3YxazYxdXZPdjJPU1FHNFQwZE8wWDY1Q1E1K0tEQ2pSYmk5T0dBNWJR?=
 =?utf-8?B?bFpza0I3Z2VycTBOOHczRUxUaWR6dDcxZGFSaUZIMkljeVMvY1FxSkJnRVJr?=
 =?utf-8?B?VzlFU05Oc2FrNUVzT0hkMWE5R3BnWDcrc3JtQTJrL0pKRjZyWEFiYXoxV2pM?=
 =?utf-8?B?cmdYVEhScDV2enB2TXR0SXA5bkNKQ2ZaS1ZhVEp5Nk82bnBMVmQvNS9LcW9F?=
 =?utf-8?B?cXg5WFg2VXVHNEhrSjgrKzNMNmRqVU1IVzEvTHVIelVPeGYzd09Wdy9VTWVs?=
 =?utf-8?B?YzZSd0syc3lzaDlCNitlRlkzV3ltUHhUWVhpMTFtOEZWL3N2SkVqK1NuTkpW?=
 =?utf-8?B?aHd5dVpxRTIrc21VZVQ3Q2s4cmxvUWUyNGRsc2FyTGJFSW9WQUQvRGtXbGQv?=
 =?utf-8?B?MkJGbTJkekFRbGdKdmxQcHV4RWExcStINnN5alVmZmVYdStoc0psZEx6S0ho?=
 =?utf-8?B?aUU1aTFTUUpSWitNQUtIajNYQnhNdFc3OURRNDBMMnhjYmJYb05uaVBJaWFm?=
 =?utf-8?B?UEhGM05DUUxza1Q4eUNFYjJIVG42QXJEVXVwREpKSjZhaUFiNkVXa3pja1VY?=
 =?utf-8?B?c0tyeXBQVjBObE5ZcWlYMHAyM3pNbEZ4YWpQQlV6anRWOTdtdTVHMWRRMkVn?=
 =?utf-8?B?bXZndXRQOWdTRGJRczNoYU16dXE3VGowSS9wVFozZmpjV1VCSmJ4R2Z4NExt?=
 =?utf-8?B?Tm5GU0s3TTN4aFc3dk5WdmlmY2xnV0xWdXVjUzFibG8yRGNFaUFPWEIzcHpR?=
 =?utf-8?B?UDJzOFJvVUhYNzJGNzdtSWg1SGtoTkdJSUtXMGFjdjJyNDdJNlh5NzZsRUxJ?=
 =?utf-8?B?UURxQ1FUYXpMSEhpelVISU9tcUQ0cGRoSGdJYmFsdTQ1YVVMdTNQM3VqQk96?=
 =?utf-8?B?ZmN4Mkd1cnhBK3FvRGw4L09Oc1NmcmtMb09XOVcvS2tzd3YwOVI0QVZwZWZK?=
 =?utf-8?B?N1FaTDdTOU83VU1CZTI4YUpPa1ZlNnJiVkc0a2gvK3REWERMNjBBUlhZYVB1?=
 =?utf-8?B?TC9PTjVxdnJrY21NMkt4OWUwV0dmc2Mvc0dlM3doSmUrNHREYjdiNEZudkRN?=
 =?utf-8?B?bUdDamM3Qk5jT3hmVlhXVlh5L2Qxc0EwWmZzckRjZVM4b0pCTWJTYjRYclVj?=
 =?utf-8?B?T05aM29NWVIxcU5LaXNBaGhTZ2c2SHFWVWJXSzlOcVJsOVM0TVl3ZWIzR09L?=
 =?utf-8?B?djBhTERJamc0MHhvdGYwOVhnZ0RDMEtlNm5taExwM2t0ZHpmb0lZTklUZXVV?=
 =?utf-8?B?YkZzSFNucG82VEZFeVJkL3pQWkJaNUdxYVZoS1hua21Pem5lMlYrUUpuK0Zm?=
 =?utf-8?B?QlRFNEQzZjJOY2lQdzI4YWpZMHQwV25IZjlwOVoycnh5UWFHSjR0Rnk5VmVy?=
 =?utf-8?B?clRuTWZkY1FHNnczTkZvbE5haTQxSTFmVTBheG1zN28zUEhhMmFjLzZRRlJ6?=
 =?utf-8?B?QnpPOTlXSDg5RW80WkI4UGlHZmhqSy9YdEdJL290YWZYOU4vMkluT3lFelJ3?=
 =?utf-8?B?UUpKWVB3SXJmcTFlalY1Ny9jdjVHRGpvM2VjVkV3NlNhWUR3QUVMdG1laHdC?=
 =?utf-8?B?elpQMHFCUCt4dzBoWXVtd2lCTTlwalVJSkZlN1AxcUJHUkFWelNOZUpGbDZZ?=
 =?utf-8?B?bVNxV0VMbFkyZnpDK2pyR2pQb3ZzTFdmTWQ5UUJhRjdjc2NzcG5JUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 146d0988-4cdd-432b-f5f2-08df4c5ff644
X-MS-Exchange-CrossTenant-AuthSource: DS5PR12MB052986.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 08:25:14.8838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Ld6xpCSzUQyFdzDrpQzVJHQH1HyvDHTz2RKwTSL91KLC3RMSuI0pX3p+yWqoGWd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8261
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/28/26 12:11, Padmarao Begari wrote:
> This series fixes and improves the Cadence QSPI/OSPI driver for the
> AMD Versal and Versal NET platforms.
> 
> Indirect write handling:
> - Poll the Indirect Operation Complete bit in the IRQ status register
>    instead of waiting for the SRAM fill level to drain, and increase
>    the indirect write timeouts to 500 ms as in the Linux driver. This
>    fixes indirect write timeouts on Versal and Versal NET.
> - Write a 4-byte aligned word to ahbbase for the unaligned tail of a
>    transfer, avoiding AHB bus errors.
> 
> Controller initialization:
> - Clear stale controller register contents left over from a previous
>    boot stage after a soft reset.
> - Initialize the read and write watermark registers (1/2 and 1/8 of
>    the FIFO, as in the Linux driver).
> - Set the tap granularity selection bit in the ECO register on Versal
>    for reference clocks of 120 MHz and above, which octal SPI needs to
>    work properly.
> 
> DMA and reads:
> - Enable the DMA DONE interrupt and wait for the DMA BUSY bit to clear
>    before accepting a new command.
> - Stop overwriting the dummy cycles in RD_INSTR with a hardcoded value
>    for partial reads on Versal, which caused data mismatches.
> 
> Padmarao Begari (7):
>    spi: cadence_qspi: Fix indirect write timeout
>    spi: cadence_qspi: Clean up registers in init
>    spi: cadence_qspi: Initialize read and write watermark registers
>    spi: cadence_qspi: Enable ECO bit for higher frequencies
>    spi: cadence_qspi: Write aligned byte length to ahbbase
>    spi: cadence_ospi_versal: Enable the DMA DONE interrupt
>    spi: cadence_ospi_versal: Remove explicit dummy cycle setting
> 
>   drivers/spi/cadence_ospi_versal.c | 24 +++++++--
>   drivers/spi/cadence_qspi.h        | 19 +++++++
>   drivers/spi/cadence_qspi_apb.c    | 82 ++++++++++++++++++++++++++-----
>   3 files changed, 110 insertions(+), 15 deletions(-)
> 

Applied.
M
