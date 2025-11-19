Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B87CF258C
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 08:29:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF55E83968;
	Wed, 19 Nov 2025 09:29:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2S7PXJ95";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A1788397A; Wed, 19 Nov 2025 09:29:21 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F35B83966
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 09:29:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jyFVIFKaKa5AReBYNW+MAH8pXGWT33gz8XdzykZ73QfqRb5lnQ05Rp9ZWRJwpBmbxrPBjRRYLrLpfh6vWoQVZ42Iw847zkBxkyq5p/kAWcUe1Jw4DOR953uEeuJh62WdkJhgviwC24RXCwGNczWKHhdifJ3jo3vTIjsHBqw24/BpKXlLAvmLx8TEQgjmyUsm2RvJ2zduH4oBEvCnXygmxCLI+9JnXSLh7b2tUTLbVcxCxEhny7BsQmSIpxDYczWul2w9saD/OSaB6Be1ghE+CzzRBogXeoctrO4gSf4JxmRiuBt8QR16rZg1WUkziEj7iTlqS2X6G/qIYuNW0mjKTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGVXv5ib4ntfQJLBPosPIzbmOIXn66N/rWFs1W9TSiU=;
 b=e1b2NCaMKJLLTZnYP9PhcoLW3NbeyfmDohMsPHBD3dhn8MCpAALsVmOhzgdj/ycNuPTSPOBF/H229qlqHzrYz/LfmZi7GOsa2g5019j9t7PxT/QJwFnFcVOGlM11QcR38tczWCG6J5eb2kjV5fHGxnA8oFYtaoHvNYPWL6MktIaoJ1C/O1K7pSbVl1AQfXPWdTLVQzpPq32QPi7sRRAz7RZqjFNG+qIpEKwxQbxwG9eh+L7ZRnIitNF56zNus0k7fDQtKUPLMm3FXDQ609CVzr0dAfbc4guxdr8I/4scely6lyWaaamw1E8jwoowfoodVE3MQSe4veyuwGeDlNguvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGVXv5ib4ntfQJLBPosPIzbmOIXn66N/rWFs1W9TSiU=;
 b=2S7PXJ95UMz1so9UNQSliwG+MxXomzNKEmTc1OWDQNNuiBoFaXPq2nstdfFzwNol1PIjPht7qC0KzX0iAu6RCOsCnaw7t7LqsHYSwjwsW8le710Xkc0ylXqytc0ScQXj1wWgbhVZh/4Cv1KWdpbfDEsimVqCSA42ab7yHFTSSz4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV2PR12MB5918.namprd12.prod.outlook.com (2603:10b6:408:174::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 08:29:02 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 08:29:02 +0000
Message-ID: <50af7a1b-4f09-4d93-8f68-ec597a85c116@amd.com>
Date: Wed, 19 Nov 2025 09:28:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: axi_emac: Fix compilation warnings
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Sai Varun Venkatapuram <saivarun.venkatapuram@amd.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Tom Rini <trini@konsulko.com>
References: <11b1d9b1a5589d06cff724e807832f366794c075.1762510401.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <11b1d9b1a5589d06cff724e807832f366794c075.1762510401.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:510:339::33) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV2PR12MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: c67ea03c-8cea-4648-6410-08de2745b196
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1VLU1dKSGxsZ1dkVHdLdXNVeld2bE5ScnpmZXhrbmNqMUlXMnRvTEtvWkJo?=
 =?utf-8?B?UzdOZjJYQTZpWjhzQlZuV3BneWRuSnFLZnZLTHZiWVVKZE5MdUQ2L0tiLytt?=
 =?utf-8?B?VFEvMk5XbG02YTVTWHVBY1QvQkM0ZW5oZUxCd1NVUklBRkFZRS80YWJzeTJF?=
 =?utf-8?B?aG96VmIwYkE2STN2OTNvU09sazVBTEI1ZkpGVHBUUWNiYXE1RDBUcE1pWGNU?=
 =?utf-8?B?aVRJN2lEWFh2czNLZnBzQVZGNjhISzF6UzE5THk4cC9CWVZMcDBySU9nNEhh?=
 =?utf-8?B?UDd2ZHNDYjJIVGp6S0ZDcUVDNHZIb2ZLMEFMVm9LWmpHNnp3WGxEN3B6eHdC?=
 =?utf-8?B?bWlXZ0xGZjhiclJOSjAyaWkyOFF1K3ZTbW9VTEhmU1U3dzYybGhtcFUrNFFa?=
 =?utf-8?B?RXVKSWRqY1hKQjNlZnRnWEhmenBKZFJSS1U2ZHlFaER2U0ltOFhsaGpHbTFl?=
 =?utf-8?B?NU9QZDQrRXpqek4yRzgxZ0pxWHJnU2RNczhRVUsyd3p4MmVGcEU1ZzhmeDNt?=
 =?utf-8?B?bWkwTjZKMkNYMnh2UkY2UTF2K01IYUI4dVUySlFmTWdoMGx4RzVQbFdBYVVG?=
 =?utf-8?B?N3ZyWkZkTGVHOGJRVU1XUlNlYUttZUtNVlhDeEVLNmpScURVaWQrYnN4MDRF?=
 =?utf-8?B?bjJvU2dheHlRYWNSdDVvWjdxRmJ3TU5ISkZtSDhuanNRZzZ1cG01Y2diakFK?=
 =?utf-8?B?eEE5MDQwUjNhdDhYRENJNS9MRVFIa0pvUzNNVGo3SUlKT3IzaHIwSENXZmtS?=
 =?utf-8?B?NlFrSzM0TXlvbUtnUUFIOTFlKzQ0bHQxcVpYc0I5b29PYXJLOXd5Mks2MmVm?=
 =?utf-8?B?YzgvRnJrVHBsQVBPNUxMRVBzMlhRSklwSGJBYlkzVVllOUU2TE42Q1ZMcWcr?=
 =?utf-8?B?R0taOXM2Wmh1THc3aXBLZ1dNTlVSTXNpclVKR0hwMXQ3RXNPSCtqeS9wTmJx?=
 =?utf-8?B?NFRSamgwWXJzM1l4QlI2akYrVzl2cEF1WWlqaTRKNFlmM3ZOenNmZG41YzJ5?=
 =?utf-8?B?OGdaMmhVK0hGQjBwOW8vN25Nb1VESytBK2d5UkFKZjZQelVQOElvVExoOE9i?=
 =?utf-8?B?ZDRNczZoK2ZQYkJid0J6dGtmRm1ZZy9SSjc0dW03dmhZNSt3cjM4NkRVN1l4?=
 =?utf-8?B?WVo2WFFJMFJueXpQaFdSQWFWdi91b2xHU1JRK3NSdVJYSFRlaGhxa1NHQWFy?=
 =?utf-8?B?Y0pZY0FqR0JQaVVmbW93S3ROdGVabUU3QkdlcU5KdDJ5Vm5KQVJyUEZ1aXFr?=
 =?utf-8?B?RUw5UXJCZjRSNHBqK0c5dHYrSHdqYWJpZnZpMVE5ZWJjL2QyNkJ3VStJZVF3?=
 =?utf-8?B?emgySnN1aFZJa1BWZk9PWFhDS29OcFpjTUZvbzFBa3U3eWEyZmpOSXI3WXJG?=
 =?utf-8?B?ZHZ0V3g3aDFKdEtXSWJSU3U2MzYzcExVWkJxRURnWVdUb3hOaWRxU3JReCtp?=
 =?utf-8?B?dHpWOWRxMTIzUmxzYUhrSk90WmRTSFgyc1k3NUx1T1lEM1dZcEl6TEYxS3Zr?=
 =?utf-8?B?NlBGdkhHSDZ5YStDR2ZnRHlnVHBpVkhldlZxeHBWaXlpeVBtS2pMbndtUTVw?=
 =?utf-8?B?OU1PazA0Nnk0bFE4cUxJc2ROZ3R4MGw3eWkvS1FVTzhJYmR0NU5ncy80VU05?=
 =?utf-8?B?T1R1RWNxSGRTeWVnVklWbGJBTFk4M29wTkEwU1ZUb2V0R3lvQjBSRXYvRUpv?=
 =?utf-8?B?YktuOWdHYVZWVUo2V2pqbXRvOEgvSllCN040RWpLTnhRRGtwK3I3c05lS2lJ?=
 =?utf-8?B?ZWxTWGZGMTBBRFg4OEdUWnpKL3ZoVmFaWDJXcVFFZ0pBTW1IYlE4WWRuM0p2?=
 =?utf-8?B?RUhXOXFKT09qMEhQbWJ5RDdvTnNmekJkMnFtSldEUFpqMjJTMi9xZkRuaXdz?=
 =?utf-8?B?UGVXS0w5L1dackowUDViaW9lQ3ZIZVdmamlKWEdxSzVJUFltQlprVjBzWW9V?=
 =?utf-8?Q?LVHhmO7Q/mtrW9aTUwE0MWo6RZ39XH74?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEgrK3ROVXdPbEZHbGgvWS93a21RVkczdmZsMDFGdkVHUHBnSDUzMzVoNzhl?=
 =?utf-8?B?cnNkMU9XZkNDZ0d1SlZIUWsrYW9HT255TGRoSksvTHhQRXNQVlE1aVdWTXVt?=
 =?utf-8?B?SkNOc1hxQlU4bU53SDRDWGZWSStiVEJXVkVsWUZsMEMraEVxcTB1NUpxVm1v?=
 =?utf-8?B?TFRHY2I3VktPRDRidzZCeGtNS2FETnBHSkJqRVg0MTY3cVY1L0psa1dQajg4?=
 =?utf-8?B?cm9tWHAwM2l3QkxRanM2THlwTHhDZWR2UTBVU3RFM1JlNklGdXpjR2FWY1B4?=
 =?utf-8?B?WExsdVhFVzFCT0xSRzFZbXl4ZkQvVzVCNHFUT01oUCtqd1BxRDJvRkdEd3hv?=
 =?utf-8?B?NjMvdDlFZ2creDkvV3lBRFhnYTRUa2RmeDRGUGQ1SUhBd3NrOGxITmtKaTB1?=
 =?utf-8?B?RnZwNEpDMVNNNyt5MnlIbmR5QkNKQ2sxVGgyY0hYVkQ4Z2xsZnVLL2dvL2U3?=
 =?utf-8?B?aHloTnVpSC8wQVdpN0UrNmNZelo0NitaZk13eFR1Nk9ieWlZTTlLNWpFZm5r?=
 =?utf-8?B?S1dacVpWeTF3SEQwMTQxUjNFcEQ1ZjVUSHI5ZnhadDMrQ0ZZTVE1NnQyQ0VV?=
 =?utf-8?B?QkZsdlk0dlNtTlIvQVdGcUhGS0hZT2I5enZGMUV4VVpoem5OclJyN3BiTzlv?=
 =?utf-8?B?R0FFc3E1TmFjeE5ucFRPdHZkM00yTHJ2UGpKY3dMWFBlYUx6NGVTZmlyckVh?=
 =?utf-8?B?NHRhT0pPUGNXcVRxUm04Nm5XSFJONjI3Wkt1REVzTVVTSVFNbzVtakRkbHBZ?=
 =?utf-8?B?VTNnMk13V3VwTUNCSmdNVUpxLys3a1A5eFhCYk01VVJMaFZVU2hEOXUxeU9E?=
 =?utf-8?B?MFc1OHkrejQzN0paOU1CV0cxcEJDQ3M0M05kbkJmeFFmempzSWRuTFNlWjRz?=
 =?utf-8?B?aFhBbkhGVWQ5cndrRWQ1YTdaWHZ4MjVqWVA3Z1kyZGJ0aGdnSTRySytrVWlh?=
 =?utf-8?B?aEs2a0lLWnJ2ZGdVOVpzdTdvQjAvejF0RkNPZjlTRmdid1FCQzVha0hpVUJZ?=
 =?utf-8?B?Q1RJR3FlaVcvLzZXeTJWQW1aMTc0V0tFRXNDd2lKYWNoZ3NNUzhSb0pEZXh6?=
 =?utf-8?B?WTJaZzRNYlhnYVNDcUpqZTNNeXdFYnIwekZoNWxyMGg2aWdEWXFkc0tiYStH?=
 =?utf-8?B?RE1Tb3VPbDNTWHJCWk10YjZQc2hZYjJGeDBQUXdDejQ3MFlMUk1NV0JUV21Q?=
 =?utf-8?B?UTN4bEVvMXA1ZmpDRHBXaHhFbVgwMVlQN09sVnRqTEdZQTR1aWlZN1lVbGNE?=
 =?utf-8?B?bE5zcEFhaWRRUnl6S0pPYy9ocjB0QkdXbEFkQ0R5bnRYcHFnSEs1TUN6SUNP?=
 =?utf-8?B?K1lXbjhZOGhPQXZOZmQ2Z0NyblZXNGs0cHM1SVFWUWVsYUNXak9PM2k5dGtN?=
 =?utf-8?B?SGpodHo5OU01QWozT3dEUWdpR3NsdUJVZU1OTUNabEw4ekp5eHNXajRNSG5J?=
 =?utf-8?B?b2JPZzdGWG5TWDd4NlZueDV2dEFodzlGa2dWRm1BTkM1RnJUc2UyWW8rdWhu?=
 =?utf-8?B?eHQ3OXRoNlVLV00zVEkwVXBEUFNPUEdBcFIxZU9xOFRDREVQc3BOWXFqcXZU?=
 =?utf-8?B?WmU3b3hPTXpiV1FOSnRhTlY1c3R1RUYwTkdnSytmeG5HNDhHTWJ3QWE4YTF5?=
 =?utf-8?B?K1Vjdk1aSGtWUXdqaEJSQzduSC9IZDZsV0tqajBuYWFjc3BFMmdNbEk5Mno0?=
 =?utf-8?B?Ky9BNy9kcUkvMDFDRjJKY2dTQWwvR3ZJdTM3Q0JlY1NqSGF2c2lvVzhQdXBr?=
 =?utf-8?B?alpJRnUwREczUkhTenRYbmRzOTFmbzRtNzA3V0k1WTFWQ1NDbHdhd3AxL2lD?=
 =?utf-8?B?RXlzNzVSdTQvV0RKTm9uc2pKTHFZOWRxbHdOcUxSN3k5bnVkamk3SUUvcVhx?=
 =?utf-8?B?aWdRdVN2YWMxNTRzeldJWFpsNTJzMjN4YXU4QXFDcnRBVVhvdmg2TUFHcUhr?=
 =?utf-8?B?M3U0VWVyWjFBMjBnTHNDdW5UUFZZNlNkMGtTNE9aN3k5N2tlZjdGRTNUcU1s?=
 =?utf-8?B?Y1FNV0JxdlRIUk96TEtiMG1aWGZOR2xqQkM5NmJJUXNjTUo0TVVZYWRydnJW?=
 =?utf-8?B?end6enhCUisxYXQ0NVBGY0FPYlZlcUYvTXBMcDZRSC9JTFQyR1pBQmcvNSsw?=
 =?utf-8?Q?xRqmL4b7Y8qcuLXfH8NNjdyy+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c67ea03c-8cea-4648-6410-08de2745b196
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 08:29:02.1386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pEtKZTnqzn26CAOlqdsh57KooUoQyi3PheTNClGgEe3zfYSGFjFilUH0SBFf83VD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5918
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



On 11/7/25 11:13, Michal Simek wrote:
> From: Sai Varun Venkatapuram <saivarun.venkatapuram@amd.com>
> 
> Fix compiler warnings about casting integers to pointers of different
> sizes by using uintptr_t as intermediate type. This ensures proper
> type conversion across 32-bit and 64-bit architectures.
> 
> Signed-off-by: Sai Varun Venkatapuram <saivarun.venkatapuram@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   drivers/net/xilinx_axi_emac.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/xilinx_axi_emac.c b/drivers/net/xilinx_axi_emac.c
> index 22e119370c84..fb48feb4469a 100644
> --- a/drivers/net/xilinx_axi_emac.c
> +++ b/drivers/net/xilinx_axi_emac.c
> @@ -619,11 +619,11 @@ static int axiemac_start(struct udevice *dev)
>   #endif
>   	rx_bd.cntrl = sizeof(rxframe);
>   	/* Flush the last BD so DMA core could see the updates */
> -	flush_cache((phys_addr_t)&rx_bd, sizeof(rx_bd));
> +	flush_cache((phys_addr_t)(uintptr_t)&rx_bd, sizeof(rx_bd));
>   
>   	/* It is necessary to flush rxframe because if you don't do it
>   	 * then cache can contain uninitialized data */
> -	flush_cache((phys_addr_t)&rxframe, sizeof(rxframe));
> +	flush_cache((phys_addr_t)(uintptr_t)&rxframe, sizeof(rxframe));
>   
>   	/* Start the hardware */
>   	temp = readl(&priv->dmarx->control);
> @@ -675,7 +675,7 @@ static int axiemac_send(struct udevice *dev, void *ptr, int len)
>   	}
>   
>   	/* Flush packet to main memory to be trasfered by DMA */
> -	flush_cache((phys_addr_t)ptr, len);
> +	flush_cache((phys_addr_t)(uintptr_t)ptr, len);
>   
>   	/* Setup Tx BD */
>   	memset(&tx_bd, 0, sizeof(tx_bd));
> @@ -691,7 +691,7 @@ static int axiemac_send(struct udevice *dev, void *ptr, int len)
>   						XAXIDMA_BD_CTRL_TXEOF_MASK;
>   
>   	/* Flush the last BD so DMA core could see the updates */
> -	flush_cache((phys_addr_t)&tx_bd, sizeof(tx_bd));
> +	flush_cache((phys_addr_t)(uintptr_t)&tx_bd, sizeof(tx_bd));
>   
>   	if (readl(&priv->dmatx->status) & XAXIDMA_HALTED_MASK) {
>   		u32 temp;
> @@ -791,11 +791,11 @@ static int axiemac_free_pkt(struct udevice *dev, uchar *packet, int length)
>   	rx_bd.cntrl = sizeof(rxframe);
>   
>   	/* Write bd to HW */
> -	flush_cache((phys_addr_t)&rx_bd, sizeof(rx_bd));
> +	flush_cache((phys_addr_t)(uintptr_t)&rx_bd, sizeof(rx_bd));
>   
>   	/* It is necessary to flush rxframe because if you don't do it
>   	 * then cache will contain previous packet */
> -	flush_cache((phys_addr_t)&rxframe, sizeof(rxframe));
> +	flush_cache((phys_addr_t)(uintptr_t)&rxframe, sizeof(rxframe));
>   
>   	/* Rx BD is ready - start again */
>   	axienet_dma_write(&rx_bd, &priv->dmarx->tail);
> @@ -831,10 +831,10 @@ static int axi_emac_probe(struct udevice *dev)
>   	struct axidma_priv *priv = dev_get_priv(dev);
>   	int ret;
>   
> -	priv->iobase = (struct axi_regs *)pdata->iobase;
> +	priv->iobase = (struct axi_regs *)(uintptr_t)pdata->iobase;
>   	priv->dmatx = plat->dmatx;
>   	/* RX channel offset is 0x30 */
> -	priv->dmarx = (struct axidma_reg *)((phys_addr_t)priv->dmatx + 0x30);
> +	priv->dmarx = (struct axidma_reg *)((uintptr_t)priv->dmatx + 0x30);
>   	priv->mactype = plat->mactype;
>   
>   	if (priv->mactype == EMAC_1G) {

Applied.
M
