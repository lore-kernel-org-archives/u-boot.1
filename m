Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B62AC5DF94
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 05:12:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF07B404DE;
	Tue, 25 Aug 2026 05:12:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cIpScylO4YiE; Tue, 25 Aug 2026 05:12:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787634776;
	bh=1BrhgimM5tfImvJTXHehTSMPqkDWmpILekoES682zwA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G35RXQ2wN/4mBc/37yswbwxPO73iyVIk2uDdnDOGrr3M8yXZIKhM2ypYU84JGKWmF
	 N/UudEMS1TekWPW9cZKrO5Z4NASv82GorZzUFjmRbotVymY4npbZi/C7mbWwEG8AxP
	 VJss1YqDEg44RL1P5YH/hz1h5qnzpUN6fr5Xbc3rcbfffEP0ywe4tG8Rr4Ef3i3X0q
	 867+tf4FrkveW5KwxUUGZL4PjsQ/yAWQA5W4CweD+1vuJ3Q1JGAjDYcTv9var1ecJn
	 KBtY5Fg10HQyIW/lmEJ0+vZvCnMLfewcMjtqx/jtIuABdHJSUcVvoZv4x+zgeeybsA
	 1hIJDVYY4cNLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E4089404EC;
	Tue, 25 Aug 2026 05:12:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 27BEB118
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 05:12:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 194D760672
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 05:12:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O7ZZ3yYhGGo8 for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 05:12:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c005::5;
 helo=co1pr03cu002.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=lRdsBnrB
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8167A60667
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 05:12:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0PlsMkqi1F1HVxzfPON6+w214wqX3nxNsk0evJIsd/aRn6tlY1k0IBA0E+wDcQu2VekHGlCTeswJhFlppfghkIhMSN6T9PDXYF6+xb3EXfn4GX/6+o1C+KhKhRD1jLcoqcC4xihNjAz/FD8D2qaZ4jkqYnJVrdGNJwIi8EA0ns+1xgmiI5xDgEw9QMY2qjUsYljqsjXEO4bRZYIqaUJCQfh/d23LUC0p6PSrqdf6icwue1hrrvMPjWjk5Yl7MdH02FKKRqSvu29FDdNCg2M7HfNA/IRcnfXgkQjKUSep+utb2rkfgzysa3KXRoZ/WKSOy+WqO2VmMT+na/9v8gcjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BrhgimM5tfImvJTXHehTSMPqkDWmpILekoES682zwA=;
 b=B9p6eiWYvGjUaO/nxEWn7G1fVskjQVNmv1UrkFMn9W0uqjCFu6RAL591uB4kh2Gpp0+UYLEv1Dmq7ygy4xisGAokNRcyYr6kNYxZeu4iL/xoOEI6Tgtgkerdjt+z4RlqSqpyeybWeNYyiBnRymtv5W1CVXB032KgwnzLqTPyP3vTA1wf9eHV+2atNvzYUAPsJgFJwcEjmUuO0JNA3QznF95pULuwLlFLBBTj1mk7sKAVkxx4QG1LBPtlWeaC/xVq8w/iaL/J4XCNWZJPEwunThvK/GCHhWotjyJsYukMTpA+hyZCiXILOeVW8vsG/HeboRAuZV8i172iIVgWGPS55w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BrhgimM5tfImvJTXHehTSMPqkDWmpILekoES682zwA=;
 b=lRdsBnrB87Fb6JN5sEm7ExsNTz1E9/LRwzkA81P3sme6BmAq+aVGmJw28r/aAKbk+WhpAS5d/n1WHC200e9NNoNjI6lLrgf0sA3a/kdrf89dUKGD2dl7N/9D6o9OhsUeoF4srdzPFOZ12MGqraWVvEzCno08GkCW0yubFUVhbu4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CY5PR12MB6204.namprd12.prod.outlook.com (2603:10b6:930:23::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 05:12:49 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 05:12:49 +0000
Message-ID: <e44012b8-f9b5-45dc-b3ec-78a1a4c0fdd1@amd.com>
Date: Tue, 25 Aug 2026 07:12:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] MAINTAINERS: Remove references to not existing files
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
References: <cover.1787555916.git.michal.simek@amd.com>
 <fbb28ac69d042b60ab6b27f1cbe52a2d872b4ada.1787555916.git.michal.simek@amd.com>
 <20260824162426.GG523975@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260824162426.GG523975@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::15) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CY5PR12MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: 667bdf4a-d0cb-4d44-231c-08df026781cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|56012099006|10067099003|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: vxX0ZHXkIG39pvF2JdlqOPAFXC+7eg6g4JZrt3lkbiwEfmwLt9C73hezjXszksPosvE+D2BedHq7tCctSPNbFLmh7X86yY2nIj+PJpF6lk4G1KEcja6cxgqBKiUb8O8JNr3AjS1KlSWWbKcM+kDZpQSX70/P88m9AB7rsat1mUPFdSCegm8cRZmTrgSoy2bxtklqMSThesWiPq1zxdSkxOkIy6vGpzxBBtIUvMX1fHglqzjPAB7KBQP3qJNgd3ypI3l/w2GtfsQ5FaaPSxPjd6T5zbd6jy7BUdXSTKfcb8iC1fifDvUpHpUPF/ZIhxxlxNdxOOCXLjgy50sBDg08dqLFCY/t2iuC8zs6QV+er5GZUWw2JGMjWHdq73sf4kCWPgNFERE7joQ0aaONPvdv8cqfdUqRT3OJvf0fNj82VtAOLU/iOr1asQkjmNANvjJMWRXVM8glBn36Ma74O0Wjp3OdQMI8ZE8V+OEFT+Jnk+pCoBCRLDSBXjiEKMjCngx4o94I4YYK5eEn6tS/l/z/wypANRCUosiMKKDg9RudUyZhaE1ibqb6B8+o0mS+MBS3rL+qvBEfBjpRrqoNn7sDiYxxm/fmw2h7jG/ss7yUS3uGw6d832EsDUwDv2gi2QpAaly8FfoXSuh1Fv+n4aKCq0gNKUZzg6jMtto0PATVFOo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG9TNlp2RzRzZVB1SjFaZXkzM3ZlT1JkWk5lTG03VmxXS1ZWb1RmNGV1d29Q?=
 =?utf-8?B?SlJnMjN5QzhVUnQ0Wml5dDRuQTN1MWkxUisra0ZyMEVjZ0Vvd3B0K3FKL25v?=
 =?utf-8?B?V2JRcWRYN2FJOTRDa285dm41eHRDcFRSVGNFMFNsVlNsWVFRMnFTK0g4cWF6?=
 =?utf-8?B?UktyUkJpcllDOTFLb0FqMHExam1zdXJwVWVOQVU2VVJVMnVyV2w4bHBZcDAy?=
 =?utf-8?B?enVRYUtFVjVFV3MwdTR4ODZETWIzVFVwV1o1NmJoWHFDZ3E5M3lVK2hhY0dl?=
 =?utf-8?B?SWQ5U0JEN3lsSDJNUmV2Qk04SkJYUjVlaHR2ODJPTE9VUFFmU09ROE1LZmo5?=
 =?utf-8?B?R0RNUTZ3eTkzTW10RnByT1NKcWpGbTNWc2RBUFZhdU9pcUVlc1l1aDNwYUFN?=
 =?utf-8?B?WnRTSVlPMWVOTjFMS0VGZXlnd0ZQMUNsTTdvOU5peUp3OFNST3BUYUN1SXlP?=
 =?utf-8?B?MmxnQnEvbjdDaFdmNk1Yem5vbHZLaUUxMnl2ZXVYeFBaVTZrTTZpRjVaZnZt?=
 =?utf-8?B?YmJTOUdzeXNSQUhqb09DVFRFbTRFLytybEYvejFra08yUjV6TnBTQ29RQytP?=
 =?utf-8?B?TkVoZVlhNFVhRDErNmFOUUJWclZidTFWekpYbTNsSnRkMlVVdmt2aGZTeW5m?=
 =?utf-8?B?M1dvUkRsZHV6SGhrY1hvZzdJSG9IMFFqM2N5ZG1mb2lJSDJlTFBnTXRLb2lN?=
 =?utf-8?B?V2V3bmNpanAySGNwZ2oyV3BOaUNYUHNvRW9weUZXOXVoaDV0SWhzcU9Sd3Fn?=
 =?utf-8?B?OUtMQ0VIbEpsYjdNK2txV3JqVklqSndaNnFjNlJ4U1JvWk8xMVlTRlNqMzI0?=
 =?utf-8?B?bWxsUHFTNUxXcnNWWjhHMkdhcDZZR2g2RmN3WFU0bUVFdlJEdDRpZ2pJWkRk?=
 =?utf-8?B?Mm9Pd1NnckVVdmFJb2h2cWxGL3dZNjc5WHFMK1FIUmVvbXN6MFZmUnAxZjRz?=
 =?utf-8?B?cC92eFVwM3RpQk1wakJ2ZmdQdk1VNldOUGgvWkpCREQwRW01bm9HK3hQRVls?=
 =?utf-8?B?Z09sUXRacEYxc0RXekc2UWZzaDdYSUFsdHRWa0JPQVd0Z2NsUXBSVExXSWQx?=
 =?utf-8?B?eVIyczJkTk9XOUFsZitVTkI5SzZ3THl3VWM1V1kyN0k0Y3JYaGlYV1dLWmQy?=
 =?utf-8?B?czBoREFQdE5IbVdjZWhzZFgrdThTL252bkk5R1FEajFvclBsVXgrcTdQa2RE?=
 =?utf-8?B?S0NqeGFPKzhwSGFOT3lXQUkySzJrUkc2WExialJtQldZcFc5WGF4N3VWMmtr?=
 =?utf-8?B?UXNSc3VRZXppT25GZjZoTXFTWlpZL1E3Y1lqOUUxR3JSeHNxcVFUWUNVTGl1?=
 =?utf-8?B?NXZreVBZTGJza0Rwd3ZOS285anJxNXhwU3JyYUVoS3JiazF5cjhuRXIyck5V?=
 =?utf-8?B?a1BEc3BTbGxCNERtVitjb2xYY2RDbjdvWUlGaC8xK3Z5dm44MllzNW8zM0p5?=
 =?utf-8?B?cWFia0wya1VWZ1BKMEZUaU5TNXpCdlU3NndFVnZPc0hQcnRCOE1CbEJ6a0l4?=
 =?utf-8?B?c2U0ZnI5V3NNSUdPZzZRaUNCbUZjUW5DTTlzRkJDNDNJZXh0Q3RFV0ZjME9a?=
 =?utf-8?B?dDBkSmdWWkFMZ2NkVnkzdUhYeitmUit1MGp5T1lpTEcrbDRlMVN4dS8rUERt?=
 =?utf-8?B?aThsQzZaQ0gvR0ZBTnY3Y294TENKaXorWEdRUFVabW1wNE9lT1M1ajI1K09X?=
 =?utf-8?B?dWdyS2R0NDdoZ2VJSHp0VlJCQ1dIbmh4RERja2ppdFQ2aGZhUjI0ZEVyRWt0?=
 =?utf-8?B?WUpHSkhNR0FWM3piYi85V05QdkhhYmNKU2MySWt3cXBJWHJmcE1JM2RHbnNn?=
 =?utf-8?B?N1BYS1lRcExBNDBWaS81S0krNlNZZnVWZ0ZyUlA0M3hLa2FzTXFDWjdhZS83?=
 =?utf-8?B?SjNhUTl5VnI3NmV6dU4yeGVicFVESG9sSXppMmNwanJDSWh4WjEvVXVsazJS?=
 =?utf-8?B?N2U5R3VHc0VacTM2U2YrMVB6d21aOHNWUjRocmg3TnBLMUhZTmN3dzkyMGJm?=
 =?utf-8?B?TTZYYmdBb2VNVFBLWXhrUS9mUi9mSytBQlhpTlJ5QjlwZnlkQnkvc1JuYzEz?=
 =?utf-8?B?bGxmWXdQVit0T1pFWkc1Qmd5ZHNpN3ZaTmZCYnVza0pDOThUdWc5OFRoM2hY?=
 =?utf-8?B?eWpqakRmZUZFMzkvdjVmdDhOd1NTNDJoWklDM3hDNXE3R0lseEpoOFlEa2li?=
 =?utf-8?B?Rzc3SzJURE9xUzY1TXdXRytMY0FrbWY2eCt5Y0s5aGJxeWhQSnhBb2RhYlJM?=
 =?utf-8?B?WllKZU5qQkxwUFVXN2VmZ0pqN3pIdzVuL0g1UmpIaEpBOEIvMTZEUW9XaVJ5?=
 =?utf-8?B?d0V4ckRaNWhpWVF3UjI3SVpxWEhRbk5sRy9sWGJqcGFHREkzenJCUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 667bdf4a-d0cb-4d44-231c-08df026781cc
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 05:12:49.3312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +NIbqOMq3K+KUCQ4COYxOh7t8MlstwTWVVkFyGijnyDQoGdNudVWcZQ67P0tJH85
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6204
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



On 8/24/26 18:24, Tom Rini wrote:
> On Mon, Aug 24, 2026 at 09:18:48AM +0200, Michal Simek wrote:
> 
>> A number of file (F:) entries across the MAINTAINERS files pointed to
>> files or directories which had been renamed or removed over time. Drop
>> these stale references so that every F: entry resolves to an existing
>> path.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   arch/arm/mach-rockchip/rk3576/MAINTAINERS         |  1 -
>>   board/CZ.NIC/turris_omnia/MAINTAINERS             |  1 -
>>   board/LaCie/net2big_v2/MAINTAINERS                |  4 ----
>>   board/LaCie/netspace_v2/MAINTAINERS               |  6 ------
>>   board/Marvell/octeontx/MAINTAINERS                |  2 --
>>   board/Marvell/octeontx2/MAINTAINERS               |  2 --
>>   board/Synology/ds116/MAINTAINERS                  |  1 -
>>   board/acer/picasso/MAINTAINERS                    |  1 -
>>   board/advantech/imx8mp_rsb3720a1/MAINTAINERS      |  1 -
>>   board/advantech/imx8qm_dmsse20_a1/MAINTAINERS     |  1 -
>>   board/alliedtelesis/SBx81LIFKW/MAINTAINERS        |  1 -
>>   board/alliedtelesis/SBx81LIFXCAT/MAINTAINERS      |  1 -
>>   board/altera/stratix10-socdk/MAINTAINERS          |  1 -
>>   board/amlogic/p212/MAINTAINERS                    |  1 -
>>   board/amlogic/q200/MAINTAINERS                    |  1 -
>>   board/amlogic/s400/MAINTAINERS                    |  1 -
>>   board/andestech/voyager/MAINTAINERS               |  1 -
>>   board/asus/grouper/MAINTAINERS                    |  1 -
>>   board/asus/transformer-t114/MAINTAINERS           |  1 -
>>   board/asus/transformer-t20/MAINTAINERS            |  1 -
>>   board/asus/transformer-t30/MAINTAINERS            |  1 -
>>   board/atmel/at91sam9260ek/MAINTAINERS             |  1 -
>>   board/atmel/sama5d29_curiosity/MAINTAINERS        |  1 -
>>   board/atmel/sama7d65_curiosity/MAINTAINERS        |  1 -
>>   board/atmel/sama7g54_curiosity/MAINTAINERS        |  1 -
>>   board/atmel/sama7g5ek/MAINTAINERS                 |  1 -
>>   board/avionic-design/medcom-wide/MAINTAINERS      |  1 -
>>   board/avionic-design/plutux/MAINTAINERS           |  1 -
>>   board/avionic-design/tec-ng/MAINTAINERS           |  1 -
>>   board/avionic-design/tec/MAINTAINERS              |  1 -
>>   board/beacon/beacon-rzg2m/MAINTAINERS             |  3 ---
>>   board/bosch/acc/MAINTAINERS                       |  1 -
>>   board/cei/cei-tk1-som/MAINTAINERS                 |  1 -
>>   board/compal/paz00/MAINTAINERS                    |  1 -
>>   board/compulab/trimslice/MAINTAINERS              |  1 -
>>   board/comtrend/vr3032u/MAINTAINERS                |  1 -
>>   board/comtrend/wap5813n/MAINTAINERS               |  1 -
>>   board/coolpi/genbook_cm5_rk3588/MAINTAINERS       |  1 -
>>   board/davinci/da8xxevm/MAINTAINERS                |  1 -
>>   board/embest/mx6boards/MAINTAINERS                |  1 -
>>   board/engicam/imx6ul/MAINTAINERS                  |  3 ---
>>   board/friendlyarm/nanopi2/MAINTAINERS             |  1 -
>>   board/gardena/smart-gateway-at91sam/MAINTAINERS   |  1 -
>>   board/gardena/smart-gateway-mt7688/MAINTAINERS    |  1 -
>>   board/gateworks/gw_ventana/MAINTAINERS            |  6 ------
>>   board/ge/bx50v3/MAINTAINERS                       |  3 ---
>>   board/htc/endeavoru/MAINTAINERS                   |  1 -
>>   board/imgtec/xilfpga/MAINTAINERS                  |  1 -
>>   board/intel/agilex-socdk/MAINTAINERS              |  1 -
>>   board/intel/agilex7m-socdk/MAINTAINERS            |  2 --
>>   board/intel/n5x-socdk/MAINTAINERS                 |  1 -
>>   board/keymile/km83xx/MAINTAINERS                  |  2 --
>>   board/khadas/khadas-edge2-rk3588s/MAINTAINERS     |  1 -
>>   board/kontron/sl-mx6ul/MAINTAINERS                |  2 --
>>   board/lenovo/ideapad-yoga-11/MAINTAINERS          |  1 -
>>   board/lg/x3-t30/MAINTAINERS                       |  1 -
>>   board/libre-computer/aml-a311d-cc/MAINTAINERS     |  1 -
>>   board/libre-computer/aml-s805x-ac/MAINTAINERS     |  1 -
>>   board/libre-computer/aml-s905d3-cc/MAINTAINERS    |  1 -
>>   board/mediatek/mt7981/MAINTAINERS                 |  2 --
>>   board/mediatek/mt7986/MAINTAINERS                 |  4 ----
>>   board/microsoft/surface-rt/MAINTAINERS            |  1 -
>>   board/myir/mys_6ulx/MAINTAINERS                   |  1 -
>>   board/nvidia/beaver/MAINTAINERS                   |  1 -
>>   board/nvidia/cardhu/MAINTAINERS                   |  1 -
>>   board/nvidia/dalmore/MAINTAINERS                  |  1 -
>>   board/nvidia/harmony/MAINTAINERS                  |  1 -
>>   board/nvidia/jetson-tk1/MAINTAINERS               |  1 -
>>   board/nvidia/nyan-big/MAINTAINERS                 |  1 -
>>   board/nvidia/p2371-0000/MAINTAINERS               |  1 -
>>   board/nvidia/p2371-2180/MAINTAINERS               |  1 -
>>   board/nvidia/p2571/MAINTAINERS                    |  1 -
>>   board/nvidia/p2771-0000/MAINTAINERS               |  1 -
>>   board/nvidia/p3450-0000/MAINTAINERS               |  1 -
>>   board/nvidia/seaboard/MAINTAINERS                 |  1 -
>>   board/nvidia/tegratab/MAINTAINERS                 |  1 -
>>   board/nvidia/venice2/MAINTAINERS                  |  1 -
>>   board/nvidia/ventana/MAINTAINERS                  |  1 -
>>   board/nxp/imx93_evk/MAINTAINERS                   |  1 -
>>   board/nxp/ls1012afrdm/MAINTAINERS                 |  4 ----
>>   board/nxp/ls1012aqds/MAINTAINERS                  |  1 -
>>   board/nxp/ls1012ardb/MAINTAINERS                  |  3 ---
>>   board/nxp/ls1043aqds/MAINTAINERS                  |  7 -------
>>   board/nxp/ls1043ardb/MAINTAINERS                  |  6 ------
>>   board/nxp/ls1046aqds/MAINTAINERS                  |  7 -------
>>   board/nxp/ls1046ardb/MAINTAINERS                  |  7 -------
>>   board/nxp/ls1088a/MAINTAINERS                     |  9 ---------
>>   board/nxp/ls2080aqds/MAINTAINERS                  |  4 ----
>>   board/nxp/ls2080ardb/MAINTAINERS                  |  6 ------
>>   board/nxp/lx2160a/MAINTAINERS                     |  2 --
>>   board/nxp/mpc837xerdb/MAINTAINERS                 |  1 -
>>   board/nxp/mx6slevk/MAINTAINERS                    |  2 --
>>   board/nxp/p2041rdb/MAINTAINERS                    |  3 ---
>>   board/nxp/t104xrdb/MAINTAINERS                    | 13 -------------
>>   board/nxp/t208xqds/MAINTAINERS                    |  5 -----
>>   board/nxp/t208xrdb/MAINTAINERS                    |  1 -
>>   board/ouya/ouya/MAINTAINERS                       |  1 -
>>   board/phytec/phycore_am62ax/MAINTAINERS           |  1 -
>>   board/phytec/phycore_am68x/MAINTAINERS            |  1 -
>>   board/phytec/phycore_imx8mm/MAINTAINERS           |  1 -
>>   board/polyhex/imx8mp_debix_model_a/MAINTAINERS    |  1 -
>>   board/qualcomm/dragonboard410c/MAINTAINERS        |  1 -
>>   board/qualcomm/dragonboard820c/MAINTAINERS        |  1 -
>>   board/qualcomm/dragonboard845c/MAINTAINERS        |  2 --
>>   board/qualcomm/qcs404-evb/MAINTAINERS             |  2 --
>>   board/renesas/blanche/MAINTAINERS                 |  1 -
>>   board/renesas/eagle/MAINTAINERS                   |  1 -
>>   board/renesas/grpeach/MAINTAINERS                 |  1 -
>>   board/renesas/v3msk/MAINTAINERS                   |  1 -
>>   board/samsung/starqltechn/MAINTAINERS             |  2 --
>>   board/seeed/linkit-smart-7688/MAINTAINERS         |  1 -
>>   board/siemens/iot2050/MAINTAINERS                 |  1 -
>>   board/sifive/unmatched/MAINTAINERS                |  1 -
>>   board/sunxi/MAINTAINERS                           |  2 --
>>   board/ti/am62ax/MAINTAINERS                       |  1 -
>>   board/ti/am62dx/MAINTAINERS                       |  1 -
>>   board/ti/am62px/MAINTAINERS                       |  1 -
>>   board/ti/j7200/MAINTAINERS                        |  1 -
>>   board/toradex/apalis-tk1/MAINTAINERS              |  1 -
>>   board/toradex/apalis_t30/MAINTAINERS              |  2 --
>>   board/toradex/colibri-imx6ull/MAINTAINERS         |  1 -
>>   board/toradex/colibri-imx8x/MAINTAINERS           |  2 --
>>   board/toradex/colibri_imx7/MAINTAINERS            |  6 ------
>>   board/toradex/colibri_t20/MAINTAINERS             |  2 --
>>   board/toradex/colibri_t30/MAINTAINERS             |  2 --
>>   board/toradex/colibri_vf/MAINTAINERS              |  1 -
>>   board/toradex/smarc-imx8mp/MAINTAINERS            |  1 -
>>   board/traverse/ten64/MAINTAINERS                  |  1 -
>>   board/wandboard/MAINTAINERS                       |  1 -
>>   board/wexler/qc750/MAINTAINERS                    |  1 -
>>   board/xiaomi/mocha/MAINTAINERS                    |  1 -
>>   board/xilinx/zynqmp/MAINTAINERS                   |  1 -
>>   board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS |  1 -
>>   board/zyxel/nsa325/MAINTAINERS                    |  3 ---
>>   134 files changed, 241 deletions(-)
> 
> My concern with doing a big change this way is that similar to the
> xilinx platforms, there's a lot of mistakes to correct, rather than
> drop. With some detective work (and, time) I think most of these get
> corrected rather than dropped. For examples:
> 
> [snip]
>> diff --git a/board/CZ.NIC/turris_omnia/MAINTAINERS b/board/CZ.NIC/turris_omnia/MAINTAINERS
>> index effce8a753b4..530ca5b420fc 100644
>> --- a/board/CZ.NIC/turris_omnia/MAINTAINERS
>> +++ b/board/CZ.NIC/turris_omnia/MAINTAINERS
>> @@ -5,5 +5,4 @@ F:	arch/arm/dts/armada-385-turris-omnia*.dts*
>>   F:	board/CZ.NIC/turris_atsha_otp.*
>>   F:	board/CZ.NIC/turris_omnia/
>>   F:	configs/turris_omnia_defconfig
>> -F:	drivers/gpio/turris_omnia_mcu.c
> 
> This was committed as drivers/misc/turris_omnia_mcu.c
> 
> [snip]
>> diff --git a/board/Marvell/octeontx/MAINTAINERS b/board/Marvell/octeontx/MAINTAINERS
>> index 1f3b12b1abf2..c66607c01d5a 100644
>> --- a/board/Marvell/octeontx/MAINTAINERS
>> +++ b/board/Marvell/octeontx/MAINTAINERS
>> @@ -2,7 +2,5 @@ OCTEONTX BOARD
>>   M:	Aaron Williams <awilliams@marvell.com>
>>   S:	Maintained
>>   F:	board/Marvell/octeontx/
>> -F:	include/configs/octeontx_81xx.h
>> -F:	include/configs/octeontx_83xx.h
>>   F:	configs/octeontx_81xx_defconfig
>>   F:	configs/octeontx_83xx_defconfig
>> diff --git a/board/Marvell/octeontx2/MAINTAINERS b/board/Marvell/octeontx2/MAINTAINERS
>> index eec1d77dd108..8502c119c352 100644
>> --- a/board/Marvell/octeontx2/MAINTAINERS
>> +++ b/board/Marvell/octeontx2/MAINTAINERS
>> @@ -2,7 +2,5 @@ OCTEONTX2 BOARD
>>   M:	Aaron Williams <awilliams@marvell.com>
>>   S:	Maintained
>>   F:	board/Marvell/octeontx2/
>> -F:	include/configs/octeontx2_96xx.h
>> -F:	include/configs/octeontx2_95xx.h
>>   F:	configs/octeontx2_96xx_defconfig
>>   F:	configs/octeontx2_95xx_defconfig
> 
> 
> Looking at board/Marvell/*/MAINTAINERS those files are gone, but
> include/configs/octeontx2_common.h include/configs/octeontx_common.h
> exist and should be somewhere, probably one and one.
> 
> And so on. So, I'd be happy to take over this part of the series, if it
> looks like a lot of work you'd rather not take on at the moment.

As I declared and you can see from my series it cough my eyes because of issues 
with our platforms. The amount of people CCed in this series is huge and I hope 
that pretty much it is going to be a reminder to fix their platforms.

I think that would be the best if board owners will look at their boards. Fix 
them (fix emails, etc) and send them separately. And this will be just rebased 
on the top of it. At some point in future this patch should be quite minimal.
Also it is good indication about boards which none cares which would be good 
candidate for removal.

And definitely feel free to take over. Would be good if you can take 1/3 to your 
tree :-).

Thanks,
Michal

