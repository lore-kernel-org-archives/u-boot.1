Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58DACC61DBE
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 15:52:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E35F9606BD;
	Tue, 25 Aug 2026 15:52:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HYQNZvpz3eZH; Tue, 25 Aug 2026 15:52:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787673143;
	bh=i4MV1NNukiwmP+Ygu23pO9lcgwsSIICuvDFGiG2YPrk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dZ87hH5jNK+//HcMV3+LJgtbDKm9hLsMFnpxwj5q8fJ2oHGfDaQ6PqCdrldbERdST
	 u5RXWjqKUFpprXB71uMWEHjw3ByaKsjrkzQgyrodAfli3YQnJBViufslq3mONw+kMo
	 EUE2Nv0lOlPxxkL/q3bhhH3A0UDhB4TWZ+wdZWSBHMDNHHKgoiM3G3s4zfqJz6jtVi
	 TEsxVS+vqS79X4+HRHBYEclOfP6o4W0Zm9jeb2HomnsqZ9BHpZyCpmPYyCmfXASkWb
	 q7OxcmK5VRRvU6BdPZfHIDUnpJVW8kGniRMG7TM4kxtDxYfaBRSXJ234+Q+1S+Tef7
	 POMJR0d0P2QpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5CCA960604;
	Tue, 25 Aug 2026 15:52:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 288E62FD
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 15:52:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1A6AF4058C
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 15:52:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JNH8bed6enRj for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 15:52:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::3;
 helo=sn4pr0501cu005.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=tzPEjyzs
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A3CC74058B
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 15:52:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1DunsszG1PM7v1s0IzzJSQBRwVAcpFP0GVTZ0vH82CDEzrly1CCLbLygFnnEOeSW10QhOClBoHa+EX3QMZgDD4GU/Xu71bxy6joZouARRTgCxqmiTy7vrvWa2M33zYrvtfdgZEFf/SDlj5R4whR9YtnovkGmhgDEVzjbPsnlg2cg/67YyRf9VJ8s7fjKZt194IRNt8DVJ3CT8RYqnLEEbk9dIZO4yf/fSuXGDaZipmjL9HZBIlqBY1XeczdLgFTm8AdqHH6AfTe0fq9aFkA5rXkSEjwK+PgibY3VMIzAxxPU8NGxl4sTkMb/FtUaSG2OVkJTubCZvktMrZ6RG0HvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4MV1NNukiwmP+Ygu23pO9lcgwsSIICuvDFGiG2YPrk=;
 b=zOIeFc5e3TC0b1t1AfaVhcJHEvlsLQYRF/xUmnEOaP1ix2ajNwkO83m/b736+pYAth8EGAHp329J3J+M3tIdsh6Kjz56vRXjQbiGsf6FFJAKKr3Jz17yefqINpZEf/1NVqWQ4X9Mqc+pjubgjHj03uetP7myv5nPgn5tNQXHRZ4quGiwme1fhlTVaPmuFLipt75GtueCf5k3Jo42U1uNmLk5o/jqU7c3gmX69xEwf+REYgidMczBa5ghZsrg28sj0aXX23Ijqz9f6vN1VRFLYkKqCZb5HXxWMPsdgiSmwF+o5OGnFOmKS35QUXmaFYaRo7B0epL4KoK6IJ4yMtAs+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4MV1NNukiwmP+Ygu23pO9lcgwsSIICuvDFGiG2YPrk=;
 b=tzPEjyzspkmwu25KKstoR8VUPyAValX/4EosmJ+jXQ1smUQzQ1sb44N3+QajhWRpUeEXgfsSh87vn6psQ6zMpnMS84AlC7o+JMcNgKwii8jLGeyV9ZxehXVRqrCzFegHOymus8/ImDXwb9zmXrq/sJDoJKYBnLxFwkieL/n9IDc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by IA0PR12MB8349.namprd12.prod.outlook.com (2603:10b6:208:407::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 15:52:08 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 15:52:08 +0000
Message-ID: <8dc770e8-d7eb-4314-8dcc-b154e18c662d@amd.com>
Date: Tue, 25 Aug 2026 17:52:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] MAINTAINERS: Remove references to not existing files
To: Bryan Brattlof <bb@ti.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <cover.1787555916.git.michal.simek@amd.com>
 <fbb28ac69d042b60ab6b27f1cbe52a2d872b4ada.1787555916.git.michal.simek@amd.com>
 <20260825134812.nlq25ymj5gsnmdvb@bryanbrattlof.com>
 <20260825142736.GV523975@bill-the-cat>
 <57548c50-e2de-44eb-944e-554438c2cfd0@amd.com>
 <20260825154602.33rs5mq553ojtgxj@bryanbrattlof.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260825154602.33rs5mq553ojtgxj@bryanbrattlof.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0166.namprd05.prod.outlook.com
 (2603:10b6:a03:339::21) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|IA0PR12MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: 43eee476-2c3f-4dc4-f261-08df02c0d188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: LRKk6vgTprbIyqb7g5UPnaLbFSMYMxSbLVUdM3WL4GYDbpXY7VWh1mTdDBU47lAUaSeTjsc7fxHhS3ucSsbW1EPCHd0JnTSOdIQtsIEv7slTWilUESczIXv6+TwaEXef79FUrLKVfqo0vikINpsKhE/KgIfK2cUYax6hOfU2P2tK/HZveimTVT4lX9Xus08JAxjOd7FvpPa9BsGz9jAuQSOlE2aoJKQUjMMXFDMKYLxMZzM2IedgAkm3G/dsN8Zs+u5k+j8TX45ddEHeBObd3FABMEDc6WcvhX90/hFOehlvuZjFWcHcb+09NlWWygxQ5EsfrKzK0peTqvjl5c586JTDNz8WPertkifcpkbL0J5l4faVMsgYhfnnCrJeCbnlgB3oLLEFmwTYnZtfI0bvIvrp7VaWaPBZWS6f8lbzG4BEUA7bhG798GhAEysUb8Ld+OpIcuPQ0Tt7T35WWApUlsJvEvRCiJZVTHbYctMhqxQ6/gNcdJdNXcj3sE6leinbi5H5KuT1jlJF1a/Xh301N/oVzxDI9lWoQ0QwoL27XBGxR6j86Bo4+bJGA5st5soZrkqQ+KRuZUYnn7shBHsQBQe+QSdjDzrImkqY9ykWf4aJH1uaoqBPx6lgrmWrG6dmtdA5fIjvXxKRtdz3uWXcbEdusc+X90Js6QCKUO2L6S8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1d3cG5VaGQvRVJ0enZudDhnVEQxRjNRUk0vSldNK2dxaCtEQmJ5bzBGenhJ?=
 =?utf-8?B?OG8rdTFDa1FScUUzR2hZWWFLak82S2locDNtLzhVMGxlckpIUnFFaVJxekVY?=
 =?utf-8?B?RDk4STZOeDlON3lHd3REdTNXcWwzb296TFJNeWVZVkVFaGs4WUxEeDlIM1lu?=
 =?utf-8?B?QUFxN0ExUUxLSFF1OU9WR2NDcWNPQVJBK2Nib1VMRXBPcThOaEQ3UzdtYmFl?=
 =?utf-8?B?QmNuZmp6K0FoS2JpRkl3Vy9qZFBJYUtOcWVqZHYrMldPVVpIVlJHNjZkZXJZ?=
 =?utf-8?B?T3hUbGZvZUFEUzkzMUc3cXNINW15Qk1sSmFDMGJpdWd6NHZxVTZsNkNxNWhu?=
 =?utf-8?B?bGE1N1ZLejRpWVl2dEd5L1VhZVhrallwWllUckc0WDRoaE1FaUtmWFJndFkx?=
 =?utf-8?B?aDhUTXh5R0t1SVVzOFRzb1RWYjRUMWtaSkVjZXZmbzZJTFFZZklMUzVVOG1W?=
 =?utf-8?B?cVNwcHlsem1OUUV3UU1PdXBVajFGOGx0NTZzWG9mdGNvOXd6S0hCM2UrS2pP?=
 =?utf-8?B?RDczOS8rZ0xxeURHNFNKbEJ2WXAyM1k4LzcxWWdFZUZQeFpPNzJWc0d3SjQ5?=
 =?utf-8?B?cEpIQ0FNVnYxcWNIV1lDWFQvUjM0MnN4eUxqcWRTSkV3dTM1RkxHQXR5Rm56?=
 =?utf-8?B?NUx4VkVZTldJcVpIdXhxQnFsME1MeFpCanlTbjI3NHNCUFJvR2UzUWYrVUpL?=
 =?utf-8?B?QlZ6cklsS1lCUWpjNDh0VCtjZ3JuRFEyWEVUMHpQLzZwdDBXZ1hVU1BlOHY5?=
 =?utf-8?B?anhWb1FVTTFRdk9GVC9VSjdaUVdmRk9nZnNDV2N1Yy8yTkdwbjV0R0J6eURL?=
 =?utf-8?B?N2h2REhWaGxXb1RmenIzU05Zc2E4Q0k0TFFJZllhYkltaERHanhXRWtWek5S?=
 =?utf-8?B?KzFQNzkwZVgzajhpUDdnR0VsUGIzYk1ObXJDTWtsRlZEaWVYRUYyRFcxb2py?=
 =?utf-8?B?bWJjRUt2RXR1UVZXUGJhV1FQQUE2MzdtRWoyMHk5RUxVay91TmxNMS9PUS81?=
 =?utf-8?B?dkRvNEJWR3FDekV1aVVtVW45TGVuQ1lpWThIVnJSNjBmZGhPd3EzbEdpYTVY?=
 =?utf-8?B?MHR3OS9SNkVpUWJvSTYyTmk1bUdzaGV0ZE1yUjJpZzVaU0p5UkhIMFQ2Y3E0?=
 =?utf-8?B?M0xwWWQvcU9UWWoxbXhuSmZjNFFjZVFXN2czUEVJU2NRY3c1dm90SkJqRDZt?=
 =?utf-8?B?QUJOL1VYNGRLbTRvZ1JaNjVTWG1leWdmNi8zY1phNDNubXJ0UFNSSGpGaGIv?=
 =?utf-8?B?ZzFRMEwraEJSWU1BVHgvZkh0cUhmay9HWE83VHJSMVh6WlZpMjM3bFUraGNF?=
 =?utf-8?B?QktNYzEvQ1VkOTEzTm5KNmZweTVJdUszK05BZ010R1NEM3MySkFLbmQ0NlYy?=
 =?utf-8?B?MjZTWGVpQnFpRy9YNnB0dENPSEFGZ1JjekJFdXAraHRFQmhBOHNzODllRWVl?=
 =?utf-8?B?dGpJaW4xV21MN2dHNWp3WFBHS0FmUk9hVUo1bjFFQ1NtbTBPa3Y5QitrM2t1?=
 =?utf-8?B?WmF4Z01GemhtbWg5MnBQN2p6WEFUczhid2owaHFma3NmZnIvZmJRc0RqUVF2?=
 =?utf-8?B?Yld1blhLT1M2WXBwWEMwazlEcU5NTzloWjRJMUREQStzZlNpTGU2R2RBNVJk?=
 =?utf-8?B?cVFTdEhjUHBuUFZQZmJiQy9SeHpDb0dDeDNsdTN4QlVKNU16QWgvaVg5UVAx?=
 =?utf-8?B?YXNpWDJBeW1PcitlTG14V0dYeHNJc21oT045MHFXZk04QzkyUzdxa2JxNEhZ?=
 =?utf-8?B?YnNJcTgyWUVYakpCUG1jL2hHQzJTWXYzVE1GNlNKVXZPMkJBVEFiZmFhNXFy?=
 =?utf-8?B?Nk85Vk15Q0I5WURKVFoxNnFKZjJxZFJSeHJaYUlPWnVTblloTk5ydTZDUFNj?=
 =?utf-8?B?ZkM0eS9PaFJZMFFxNmJIVG00ckdFdnRKYW9DaDFMVE1ZWEFzcG9vdGg3Y2tq?=
 =?utf-8?B?OGwwQnJKVUtENFRMd0JoRUczenhMOGsxNmdWREFLWFhkTVIrYmM2UGJqTHMv?=
 =?utf-8?B?QkJ2QnlVV3QvVTVVR1FWV1hkekFrMm5vR01Qa09lSnJsdVY0M0NIOWFUd2NI?=
 =?utf-8?B?RytIbml5VXVaa1lUWS9WWmxmYWNmSWJrQlMxbjZZNlNUZzJxNW1SMVZJVjNn?=
 =?utf-8?B?bzZHNSs5cFNqK29uejJDaTFxUFArRTNCeDNGcWM3a2UzSi9rYXVweGRBbXZ3?=
 =?utf-8?B?LzFENVdzTTBFMlNJYnhvS1FqcmRQd25wOHNVdEYzM29IZnZIS3BLV3daMWZZ?=
 =?utf-8?B?NVBUdm1qMXpsVjViNmJjWVFsMWNtM2FpdEFEc1pOdkk1c3Mrb3did3k3MjZo?=
 =?utf-8?B?bG52WHNmeHd0Q2tJdzB0dkZXN1BzdU9VZ3hlSXhvM1gvRmZCTUJndz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43eee476-2c3f-4dc4-f261-08df02c0d188
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 15:52:08.3214 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ItHrIlEnNIsBfc1dK7+SlBD7mqc/QLrwu2tWZdYwz0XvfwZT1FoYsBwT0ZXxkQV2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8349
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



On 8/25/26 17:46, Bryan Brattlof wrote:
> On August 25, 2026 thus sayeth Michal Simek:
>>
>>
>> On 8/25/26 16:28, Tom Rini wrote:
>>> On Tue, Aug 25, 2026 at 08:48:12AM -0500, Bryan Brattlof wrote:
>>>> On August 24, 2026 thus sayeth Michal Simek:
>>>>> A number of file (F:) entries across the MAINTAINERS files pointed to
>>>>> files or directories which had been renamed or removed over time. Drop
>>>>> these stale references so that every F: entry resolves to an existing
>>>>> path.
>>>>>
>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>>> ---
>>>>>
>>>>>    arch/arm/mach-rockchip/rk3576/MAINTAINERS         |  1 -
>>>>>    board/CZ.NIC/turris_omnia/MAINTAINERS             |  1 -
>>>>>    board/LaCie/net2big_v2/MAINTAINERS                |  4 ----
>>>>>    board/LaCie/netspace_v2/MAINTAINERS               |  6 ------
>>>>>    board/Marvell/octeontx/MAINTAINERS                |  2 --
>>>>>    board/Marvell/octeontx2/MAINTAINERS               |  2 --
>>>>>    board/Synology/ds116/MAINTAINERS                  |  1 -
>>>>>    board/acer/picasso/MAINTAINERS                    |  1 -
>>>>>    board/advantech/imx8mp_rsb3720a1/MAINTAINERS      |  1 -
>>>>>    board/advantech/imx8qm_dmsse20_a1/MAINTAINERS     |  1 -
>>>>>    board/alliedtelesis/SBx81LIFKW/MAINTAINERS        |  1 -
>>>>>    board/alliedtelesis/SBx81LIFXCAT/MAINTAINERS      |  1 -
>>>>>    board/altera/stratix10-socdk/MAINTAINERS          |  1 -
>>>>>    board/amlogic/p212/MAINTAINERS                    |  1 -
>>>>>    board/amlogic/q200/MAINTAINERS                    |  1 -
>>>>>    board/amlogic/s400/MAINTAINERS                    |  1 -
>>>>>    board/andestech/voyager/MAINTAINERS               |  1 -
>>>>>    board/asus/grouper/MAINTAINERS                    |  1 -
>>>>>    board/asus/transformer-t114/MAINTAINERS           |  1 -
>>>>>    board/asus/transformer-t20/MAINTAINERS            |  1 -
>>>>>    board/asus/transformer-t30/MAINTAINERS            |  1 -
>>>>>    board/atmel/at91sam9260ek/MAINTAINERS             |  1 -
>>>>>    board/atmel/sama5d29_curiosity/MAINTAINERS        |  1 -
>>>>>    board/atmel/sama7d65_curiosity/MAINTAINERS        |  1 -
>>>>>    board/atmel/sama7g54_curiosity/MAINTAINERS        |  1 -
>>>>>    board/atmel/sama7g5ek/MAINTAINERS                 |  1 -
>>>>>    board/avionic-design/medcom-wide/MAINTAINERS      |  1 -
>>>>>    board/avionic-design/plutux/MAINTAINERS           |  1 -
>>>>>    board/avionic-design/tec-ng/MAINTAINERS           |  1 -
>>>>>    board/avionic-design/tec/MAINTAINERS              |  1 -
>>>>>    board/beacon/beacon-rzg2m/MAINTAINERS             |  3 ---
>>>>>    board/bosch/acc/MAINTAINERS                       |  1 -
>>>>>    board/cei/cei-tk1-som/MAINTAINERS                 |  1 -
>>>>>    board/compal/paz00/MAINTAINERS                    |  1 -
>>>>>    board/compulab/trimslice/MAINTAINERS              |  1 -
>>>>>    board/comtrend/vr3032u/MAINTAINERS                |  1 -
>>>>>    board/comtrend/wap5813n/MAINTAINERS               |  1 -
>>>>>    board/coolpi/genbook_cm5_rk3588/MAINTAINERS       |  1 -
>>>>>    board/davinci/da8xxevm/MAINTAINERS                |  1 -
>>>>>    board/embest/mx6boards/MAINTAINERS                |  1 -
>>>>>    board/engicam/imx6ul/MAINTAINERS                  |  3 ---
>>>>>    board/friendlyarm/nanopi2/MAINTAINERS             |  1 -
>>>>>    board/gardena/smart-gateway-at91sam/MAINTAINERS   |  1 -
>>>>>    board/gardena/smart-gateway-mt7688/MAINTAINERS    |  1 -
>>>>>    board/gateworks/gw_ventana/MAINTAINERS            |  6 ------
>>>>>    board/ge/bx50v3/MAINTAINERS                       |  3 ---
>>>>>    board/htc/endeavoru/MAINTAINERS                   |  1 -
>>>>>    board/imgtec/xilfpga/MAINTAINERS                  |  1 -
>>>>>    board/intel/agilex-socdk/MAINTAINERS              |  1 -
>>>>>    board/intel/agilex7m-socdk/MAINTAINERS            |  2 --
>>>>>    board/intel/n5x-socdk/MAINTAINERS                 |  1 -
>>>>>    board/keymile/km83xx/MAINTAINERS                  |  2 --
>>>>>    board/khadas/khadas-edge2-rk3588s/MAINTAINERS     |  1 -
>>>>>    board/kontron/sl-mx6ul/MAINTAINERS                |  2 --
>>>>>    board/lenovo/ideapad-yoga-11/MAINTAINERS          |  1 -
>>>>>    board/lg/x3-t30/MAINTAINERS                       |  1 -
>>>>>    board/libre-computer/aml-a311d-cc/MAINTAINERS     |  1 -
>>>>>    board/libre-computer/aml-s805x-ac/MAINTAINERS     |  1 -
>>>>>    board/libre-computer/aml-s905d3-cc/MAINTAINERS    |  1 -
>>>>>    board/mediatek/mt7981/MAINTAINERS                 |  2 --
>>>>>    board/mediatek/mt7986/MAINTAINERS                 |  4 ----
>>>>>    board/microsoft/surface-rt/MAINTAINERS            |  1 -
>>>>>    board/myir/mys_6ulx/MAINTAINERS                   |  1 -
>>>>>    board/nvidia/beaver/MAINTAINERS                   |  1 -
>>>>>    board/nvidia/cardhu/MAINTAINERS                   |  1 -
>>>>>    board/nvidia/dalmore/MAINTAINERS                  |  1 -
>>>>>    board/nvidia/harmony/MAINTAINERS                  |  1 -
>>>>>    board/nvidia/jetson-tk1/MAINTAINERS               |  1 -
>>>>>    board/nvidia/nyan-big/MAINTAINERS                 |  1 -
>>>>>    board/nvidia/p2371-0000/MAINTAINERS               |  1 -
>>>>>    board/nvidia/p2371-2180/MAINTAINERS               |  1 -
>>>>>    board/nvidia/p2571/MAINTAINERS                    |  1 -
>>>>>    board/nvidia/p2771-0000/MAINTAINERS               |  1 -
>>>>>    board/nvidia/p3450-0000/MAINTAINERS               |  1 -
>>>>>    board/nvidia/seaboard/MAINTAINERS                 |  1 -
>>>>>    board/nvidia/tegratab/MAINTAINERS                 |  1 -
>>>>>    board/nvidia/venice2/MAINTAINERS                  |  1 -
>>>>>    board/nvidia/ventana/MAINTAINERS                  |  1 -
>>>>>    board/nxp/imx93_evk/MAINTAINERS                   |  1 -
>>>>>    board/nxp/ls1012afrdm/MAINTAINERS                 |  4 ----
>>>>>    board/nxp/ls1012aqds/MAINTAINERS                  |  1 -
>>>>>    board/nxp/ls1012ardb/MAINTAINERS                  |  3 ---
>>>>>    board/nxp/ls1043aqds/MAINTAINERS                  |  7 -------
>>>>>    board/nxp/ls1043ardb/MAINTAINERS                  |  6 ------
>>>>>    board/nxp/ls1046aqds/MAINTAINERS                  |  7 -------
>>>>>    board/nxp/ls1046ardb/MAINTAINERS                  |  7 -------
>>>>>    board/nxp/ls1088a/MAINTAINERS                     |  9 ---------
>>>>>    board/nxp/ls2080aqds/MAINTAINERS                  |  4 ----
>>>>>    board/nxp/ls2080ardb/MAINTAINERS                  |  6 ------
>>>>>    board/nxp/lx2160a/MAINTAINERS                     |  2 --
>>>>>    board/nxp/mpc837xerdb/MAINTAINERS                 |  1 -
>>>>>    board/nxp/mx6slevk/MAINTAINERS                    |  2 --
>>>>>    board/nxp/p2041rdb/MAINTAINERS                    |  3 ---
>>>>>    board/nxp/t104xrdb/MAINTAINERS                    | 13 -------------
>>>>>    board/nxp/t208xqds/MAINTAINERS                    |  5 -----
>>>>>    board/nxp/t208xrdb/MAINTAINERS                    |  1 -
>>>>>    board/ouya/ouya/MAINTAINERS                       |  1 -
>>>>>    board/phytec/phycore_am62ax/MAINTAINERS           |  1 -
>>>>>    board/phytec/phycore_am68x/MAINTAINERS            |  1 -
>>>>>    board/phytec/phycore_imx8mm/MAINTAINERS           |  1 -
>>>>>    board/polyhex/imx8mp_debix_model_a/MAINTAINERS    |  1 -
>>>>>    board/qualcomm/dragonboard410c/MAINTAINERS        |  1 -
>>>>>    board/qualcomm/dragonboard820c/MAINTAINERS        |  1 -
>>>>>    board/qualcomm/dragonboard845c/MAINTAINERS        |  2 --
>>>>>    board/qualcomm/qcs404-evb/MAINTAINERS             |  2 --
>>>>>    board/renesas/blanche/MAINTAINERS                 |  1 -
>>>>>    board/renesas/eagle/MAINTAINERS                   |  1 -
>>>>>    board/renesas/grpeach/MAINTAINERS                 |  1 -
>>>>>    board/renesas/v3msk/MAINTAINERS                   |  1 -
>>>>>    board/samsung/starqltechn/MAINTAINERS             |  2 --
>>>>>    board/seeed/linkit-smart-7688/MAINTAINERS         |  1 -
>>>>>    board/siemens/iot2050/MAINTAINERS                 |  1 -
>>>>>    board/sifive/unmatched/MAINTAINERS                |  1 -
>>>>>    board/sunxi/MAINTAINERS                           |  2 --
>>>>>    board/ti/am62ax/MAINTAINERS                       |  1 -
>>>>>    board/ti/am62dx/MAINTAINERS                       |  1 -
>>>>>    board/ti/am62px/MAINTAINERS                       |  1 -
>>>>>    board/ti/j7200/MAINTAINERS                        |  1 -
>>>>>    board/toradex/apalis-tk1/MAINTAINERS              |  1 -
>>>>>    board/toradex/apalis_t30/MAINTAINERS              |  2 --
>>>>>    board/toradex/colibri-imx6ull/MAINTAINERS         |  1 -
>>>>>    board/toradex/colibri-imx8x/MAINTAINERS           |  2 --
>>>>>    board/toradex/colibri_imx7/MAINTAINERS            |  6 ------
>>>>>    board/toradex/colibri_t20/MAINTAINERS             |  2 --
>>>>>    board/toradex/colibri_t30/MAINTAINERS             |  2 --
>>>>>    board/toradex/colibri_vf/MAINTAINERS              |  1 -
>>>>>    board/toradex/smarc-imx8mp/MAINTAINERS            |  1 -
>>>>>    board/traverse/ten64/MAINTAINERS                  |  1 -
>>>>>    board/wandboard/MAINTAINERS                       |  1 -
>>>>>    board/wexler/qc750/MAINTAINERS                    |  1 -
>>>>>    board/xiaomi/mocha/MAINTAINERS                    |  1 -
>>>>>    board/xilinx/zynqmp/MAINTAINERS                   |  1 -
>>>>>    board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS |  1 -
>>>>>    board/zyxel/nsa325/MAINTAINERS                    |  3 ---
>>>>>    134 files changed, 241 deletions(-)
>>>>>
>>>>
>>>> Thanks for the cleanup!
>>>>
>>>> For the TI boards
>>>>
>>>> Reviewed-by: Bryan Brattlof <bb@ti.com>
>>>
>>> I want to call out the TI borads here, because I'd like to see the
>>> entries fixed as the first thing I noticed was "it was called
>>> am62a7_evm.h downstream, not am62a_evm.h upstream" and we should have
>>> an entry for the include/config/ file :)
>>>
>>
> 
> Yeah I've let this get out of hand for a little while :)
> 
>>
>> Maybe make sense to find out which of these configs are not covered by any
>> fragment.
>>
> 
> Yeah that's probably a good idea as well. :)
> 
> Should I wait for this to go through before I send the fixes? I want to
> avoid causing you from having to rebase this constantly.

 From my perspective if you see there any issue just send a patch for it.

Thanks,
Michal
