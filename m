Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A963DEA3F35
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 10:23:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFC598388D;
	Tue, 10 Feb 2026 11:23:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="gWSeASyu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 398F683CB5; Tue, 10 Feb 2026 11:23:53 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 841A28341A
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 11:23:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Th+esi94DCVTFsBh7WPZv8ht8GvmWIc1ixohuKoQ/I83Xu5nj/t+quL331duVmP9IGxI+2NMKoY90hluHyh0fs5tRmBjmFHh4LDXYowYum2T7YZ2m1arUP3wG4ZG48ilfS1hVNPZdyXJI/sywLEksqFAKzyu9+JibjtteIiZbQ2/0/6YII6HlBSNGVVgP0vePtyCDcbRxxn3JvtusOndaXwZDLCFlRhU8WGjHlaXU5QavU5j7FJbgSWIWAd6fVdCdLf9dSfmHaaCGvT/ULx1nwhT10FqjL4vXRCDk7wKN81s+OYebb0qY1SkciIrtu5cjElvc7EYE//Ti3csQW3cUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfuoT4rlT3CT3zO4p8Y/wC9eF5RQKsBqRmKBfqYB4pg=;
 b=UboTcA1azxtpN+Xw+jLckMw6rO9R9EsB/Q6gOpBUXDvQC496Vk+SASiUzdcKndsgn3FDKaSkHGwgqKrHPS6CqLyR7mEWAlAhvBgj4sixiFQefPFUPobAt3vy5Nn30qzJit7jkXkLWw7TVzOXRwyMslTpKRlQAQHHc3ec9+GmPTMvuhlySUP2958+dZGK27gq9cLMhAgh8qj3PqMTn/wCi1xWAUv2dMKOsC+Tu18NGfgJ4qMWbjRDZRiZmY0uM19S9sxESl00ZD1kzEpG58aA9stSvjqCwogFw4R2IomZqRsfzD1xnjvdKAWcCf8CEtrcNM8aADOl/+nqWr5fOqUO5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfuoT4rlT3CT3zO4p8Y/wC9eF5RQKsBqRmKBfqYB4pg=;
 b=gWSeASyuO5opXOWdXwQy8lyXoZ8IEzBvKwNyOeX35c5odUarjrRWwiEyEXXK/vdgYUy4H8zlVh96QZ2L986FICqHJ+SikQLExgOPl3Z0Cf7aeNKUbNXHDw6x5tI7JYKm13vnwLrHsNp3JTCDgksoNG68nFcavOFVRUiDuluPw1ytG+Xck1AXQtoOn8u5G5u32JhzzbdS8dpGYTXBbeFp4xVMZHGYME0lhLyajr5RAWoa7axHZVch8RJ5v07pbHXcWEaXw2HkpOAEmZDqFpGN+T3OHoPf5GqUhXfIsTAVWz9zu6zYAsbnKju6+Gw2/PVeeNLcLRKmL+vo1/Dc8yj9tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by AS8P195MB1272.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:3cb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Tue, 10 Feb
 2026 10:23:48 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::295f:9a59:b66a:621a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::295f:9a59:b66a:621a%6]) with mapi id 15.20.9587.016; Tue, 10 Feb 2026
 10:23:48 +0000
Message-ID: <4338d5e8-ea88-4f9c-9edf-65b07b725324@phytec.de>
Date: Tue, 10 Feb 2026 17:22:13 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Verdin AM62/62P not booting with 42b3ee7fa524
From: Wadim Egorov <w.egorov@phytec.de>
To: Suhaas Joshi <s-joshi@ti.com>, Tom Rini <trini@konsulko.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, Anshul Dalal <anshuld@ti.com>,
 Bryan Brattlof <bb@ti.com>, u-boot@lists.denx.de, vigneshr@ti.com,
 n-francis@ti.com, s-tripathi1@ti.com, k-malarvizhi@ti.com, kamlesh@ti.com,
 vishalm@ti.com, d.schultz@phytec.de, ggiordano@phytec.com
References: <20260209083855.GA9367@francesco-nb>
 <20260209084529.GA12200@francesco-nb>
 <20260209100851.abaf46pr77uq46zi@ula0507357>
 <20260209101635.GA28492@francesco-nb> <20260209172546.GA281089@francesco-nb>
 <20260209174308.GG2603314@bill-the-cat>
 <20260209180726.GB281089@francesco-nb>
 <20260209181307.GH2603314@bill-the-cat>
 <20260210092646.w5bugrscifmsh5px@ula0507357>
 <4803a086-700b-462f-ae36-2fd55e9dcac2@phytec.de>
Content-Language: en-US
In-Reply-To: <4803a086-700b-462f-ae36-2fd55e9dcac2@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0043.apcprd01.prod.exchangelabs.com
 (2603:1096:820:1::31) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|AS8P195MB1272:EE_
X-MS-Office365-Filtering-Correlation-Id: f90e7c6b-8268-41e5-0cbf-08de688e7aa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dFBFQVgzMFY2dW5IWm9ocGRDNVloR0I0MmxoeFNlWElnU1VHMzEyMDdSQ1Ev?=
 =?utf-8?B?MXVqY0xTSHVFMDQ5SzVjYTFLNUQrVzJmRzdiQWl0UXRXYVlwR0MyT2x4Sksx?=
 =?utf-8?B?Z00ycTlPRGxLdFJ5bHJQWnpLUTJCUXdKLzBwWEhIMmgxbElmSzRxaFRXUHZR?=
 =?utf-8?B?RDN1MWlOV1dSa0VjZDd0WlErTTdIbnJreGV6a3VJZDNXQ0htQnNzdGw2dXB3?=
 =?utf-8?B?MHhYRVRFMkRyYTNxeVQwVmFSYjdTTzhEemhnbGRVaWdLOUhENXBTamhNUEtk?=
 =?utf-8?B?TldVRGN1SStUSllHYTRzdWdESTdnNGVra3Y3ZkdlZkxjUUo1Unl4MnhHNmVz?=
 =?utf-8?B?L3N5WmJkM1FoaTRDQTFNazVyVEYxL1JKR3FtMVpwVlFpWTJSRXpBTWJYT1VY?=
 =?utf-8?B?ODJLZ2ZxWFJJN2cvcURXcUdwOVc5eUl6VTBSTHF2cHhaZTRoQWpxQ2JoVWIw?=
 =?utf-8?B?NzErWjc0cnFIdm1jQmFsNjcwN1JOMkRiVm1jaEU2bXB3NldreGtSU0Q3QlE2?=
 =?utf-8?B?Y0dPbEdTeVJTMTBWWTg0cXVKdjdka1hCY0IvM3M3aUpRb3VvVktLSlJuVi83?=
 =?utf-8?B?ZWttR2tPemcwOXprYktHaXIrWlZBVVNiZ283eU5OUHk5bFZ6cmlkdjhEUjhC?=
 =?utf-8?B?ekN2SUY0MDhqSTVqQTFqZGZ2M2xOTi9sTEg2RFFydCtwaUh5OCtnZWRTREhy?=
 =?utf-8?B?ZmpIS3BmNndseGhBSHp1SmRTaFNsL2NvQ3IybXBNUkR0dk9lbXFYczVLTTFE?=
 =?utf-8?B?NnMxTGlZcFY0a2QyRWNuMWpVSUkvU0RKb251YmRsY1RpcEdaMDZjZGkvbkpz?=
 =?utf-8?B?SzQ0K0U4UUliWVgvMzhoY2JXNzlKOVdqZ3ZJVi9xaVRuWlFDRGlneEU3eVFH?=
 =?utf-8?B?UjdzMDBpQm56d2svQVpTenZ0Nk42M0dFclRsUVljbm5JT09OT24zM1kzODJN?=
 =?utf-8?B?eEpVRUtCQkxub2VhVFluQjlsVjUvZnoyQmVtY08zajlOMmRURmJpK0RkaFM1?=
 =?utf-8?B?SFhmUVBwS0dBb3RqWTRTUnpYaytFdW5aTVM2T3cwL2VINFJuYVZoTEQ1QXJM?=
 =?utf-8?B?WlhQbHUzblBhSlRUNjhhdU5iV0ptZ2dwQ2xndW9FeEt2YjBXamVJTCtHSnlo?=
 =?utf-8?B?cklLV0srajE3VFdiVHFNRmg5Z2lvdjZmd1RLL0o0YUcwdGUzQmQzbWtldC92?=
 =?utf-8?B?UUwzTjZjRXc5eE5iRmRaWkMwQno1M24zTmFOTUtCdkt5cnlENm5XL2hva2xJ?=
 =?utf-8?B?QS9qblZuMUpvVC9ITTlBZElHN0taZVdmaEgwZXpaNk55aTY3ZEdWa2h4QU9Q?=
 =?utf-8?B?Sml2dzB5eTVFZVRkSjlrM25BUlBHaEppc25seU9jaUFSZVo1R0hteGhPRDNT?=
 =?utf-8?B?c3NTMVBqSW4yUkk0OGt1L2xTUVA5ampqb09MUS9nTGc1WHdCdGw0ZE54ZlFi?=
 =?utf-8?B?TllCSmd3QmE3VVJuZ2F4YytKUzJsano0T2JKUUg5Z0hIM1d3cE85cTMvbzJX?=
 =?utf-8?B?ZHFaaysvdUI4UGd0eW1CSzRqMkU4ampnc0lKZFIwUHhnbHBqc2lyWE9YSXVq?=
 =?utf-8?B?Y3BmOTNGbUtKR3IxanRjaW1ZdEJBeGZIbzdjd0FnSVUrbWcrNElpUE9GMTZw?=
 =?utf-8?B?ekdhMGZPMnRFV0pQSk42MlBJK21CcjNCSi9CU1lrNzJmTmdUOTcwZHVyLzRP?=
 =?utf-8?B?SGFuRTB1a2Z5M21rbmVhTWQrdkl5eTA5MlZteENTVGFQQlhTdGh0M2JHVFJv?=
 =?utf-8?B?R2syNXBSYVE0ZXR5UnNDeC9sYW9EV3NURXJqSXF6T2tLMFFTRGlQM24zM3lw?=
 =?utf-8?B?cmxNUXF4TzVQeU5IR2JKbnh2b3B2cElRT2tBTDVOUURudThtMFZJRVNvQUpm?=
 =?utf-8?B?M3hmTjEzb0lWallGNmp0Z29GZGwvMlI0bHBIam5jOUJUWUIrbUJJT3U5bGlq?=
 =?utf-8?B?VVlzNTNXK3dqWHAzaXNnaVBFTXZRWmw3TFNkSERTemhtTGZ3cVh2YmxXbU1j?=
 =?utf-8?B?NktJbjZsbVF6VjVpQ1ZWSDV5dHZDdFEweDVCS3hJbXJOcEhOWm5RQ2dWV0lW?=
 =?utf-8?Q?7DEWyi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVFzWFYxUzVXTzIvVmpOVHB1WkZnU2w1K1RuM0RTUGIybDhMcldBYTNJSXBk?=
 =?utf-8?B?M3RKOHpoQ0ZoaUVxWXVYb2ZXbTR1WXRRajFoTU5FMy9oN0FGdWZCWmIzdHB3?=
 =?utf-8?B?UEdiaGFuTUdwOTA4S3RvUXU3NVRGUzJQU0dhVjI3VGF4bDAzQzVudi9QRThl?=
 =?utf-8?B?QUNqYXNjV2RLTHo4by9XdnZRV20rbHMrWW1LK1NQOWRpdTRZQk0zYllvaElD?=
 =?utf-8?B?K3pHUHIwZ0JzSjE3R2JLUFBCL1M0UDRVMVpZYUxnanJVaU54bWxJTStVdnp4?=
 =?utf-8?B?eC9kYVhucDYweEk0YVB2T3N3QkNJT0x3MTdVNHkzNlNxWW5Md1pyOEdlRHNN?=
 =?utf-8?B?TXpVWHRpZldpN0xXYVl2SHg3VFFXZ2FvMnZCY0NhcVp1RzFnMWtlU3ltM1hJ?=
 =?utf-8?B?WmhvN0hRUlQyY2NTUitEU1JBM2FBRTNGNngxak0xbnZJMDVNZWJvSTJhTlpV?=
 =?utf-8?B?a01WMFkzd2l3WjBGQVZrVzlpTjk2YnV5Ym9JeFFST0FTYTF1SElaVWJvMUF5?=
 =?utf-8?B?SXp2SFBPYWRlSitWakxuZk9EbWZiNkpBZ2oxRGlkU2dsMU5rMFIwWUp3ZUdI?=
 =?utf-8?B?dzBuOFJsNjNuUmlXVDQrZC9SdDhRR0xDYTR5OGUxWjlGdXc3WUJIRldzSXhW?=
 =?utf-8?B?RlZBRFlFRVVjQTNqTUFVQkNrTENGTW1BTFhtMjRlUzdjUndVeU5UaTNMM3Nw?=
 =?utf-8?B?N1VsLys5M2tjTm1ad1cwTVJURlFUYnZhQTNYSkNNY0hyclFqcmsrd2tXNlUv?=
 =?utf-8?B?bDlRbGFYN01LZlVhVytSeTJkemc2RDdJYWwvVTBVbWJ2cU5uc1poMkt0Ry9F?=
 =?utf-8?B?UXBudVdPQk5BeUtrTXVJTSthNXE0b3ZLQnZiUVRuZ1BibXVWenRpcm9ZcDMv?=
 =?utf-8?B?aVdHQ2xNdVltajJpOVdDTVBoN2lRSzVqVXE0cVBuWDhjRTBuSTF4L2g5MENt?=
 =?utf-8?B?emxaTUZtYUphYXNjNm9SNzI0ZTRNL0lYbVZjcitRWC9zaC9MaXVWTWI0SjBS?=
 =?utf-8?B?QnZkWmNyK29GaEkvdXpYMkx4U0Y2NEx1VkZWQ3QyMDNhYjdXRDgrei9qckE1?=
 =?utf-8?B?VnRFb3ZxL1F5Q0RudEE0US9BeFFVVWVZQmRlanp3Q2NlYUsyblZ5Um5LSzJY?=
 =?utf-8?B?dTZIOEtaZjltY0x4d3RxSTNDaFRHZUx0eTdpSFFld2NFTFdqT3dJQzkzSzVn?=
 =?utf-8?B?SEQ5eDFab0FTZG9xR1lLWFl6RWIrSzY2RDM2dW9ZZmNmTE9UdTk4b1cvcE5N?=
 =?utf-8?B?enNJcUFDMld3YUNWeC9ONXpYMFRnK1JBU2piUjF0VGRXNWVDL0ZySmZiVjI3?=
 =?utf-8?B?OGFuMVNYcVQzTVJhZFFyckwwQjhNWkZGZjNxcGJDN1Y0aktnNk43TjR4SGN6?=
 =?utf-8?B?dkdGTzlFY1h4Z1F6ejVPVHBCblFlOHFaOVA4UFFyWklSVFZ5TWRhRHVnTWdj?=
 =?utf-8?B?eGhoalFwb3djQUU1VjJ1d3VwVVZZRWZnUHg1Y3RBZHhJVkZENHNIV3FwdHBH?=
 =?utf-8?B?QWpwdkM3TlVxWVh6Y2tDeDl0V3VsakdZMGhTTXNaVEJGN3Z0MzJJK1lMNzlw?=
 =?utf-8?B?ZVNuWENaMWxubWtGSGtZbnFVNlM0eWVXUkw2QWQrdWlER0FZbXhIOWVENnFQ?=
 =?utf-8?B?R2ZSekpGUWh0RUhYNGpoVDhLZGVnSW96bGlqOTJoL0V2NElKc3VXdEpHZ0t0?=
 =?utf-8?B?Z3EzM25DTXQ4Q1BpL3ZwL0RvdUVBbTRUWWtYcnFxRG1xWjBTUnM5a3k4T1RH?=
 =?utf-8?B?MWxybkVaNjRLZXZQek5MQUt4VElUUTRXMVkzQ05zV1RxbExQaVBqL3NZWUhl?=
 =?utf-8?B?Mm52Vy9BcVJTVGZxME1oR3VqZGV5cHdpZ2JMbjhNODFmdHUwYk4rOE9lbzVB?=
 =?utf-8?B?TS9YNlJWWFMvWVdqWjlIekVpQUxiVFpWRFpKbGZpY0NOV0RUVzdyQm9pQnJt?=
 =?utf-8?B?ZHRLVTdxaUxzbnNXajhPWVcreG5LeWMxbGJIdnhVb3FRQ2R2YWZrMHg5cTk0?=
 =?utf-8?B?Ylp5RWo3WFlJN3V6bFZJNlgzanRJVjZlRDE2VFhQNGVrbHpYQjNjUGptVkg0?=
 =?utf-8?B?cFE4eVliTGhvUmdHZHUxYjVNa1NsSW45U285bElOdk1NOFZZSVVsRFFjYk9R?=
 =?utf-8?B?TDZGQzJEQnBWUk0wWldsQkprR0N4SEg1a1h5VnpoaWNQd3BHUWhFdGNKSmFx?=
 =?utf-8?B?Y3NzMUhzeG1JVUFjeCt1TkVSSUlZYVFGNEh6MVhFeVRnYTZ5djZiNk5QKzNh?=
 =?utf-8?B?MVcxdlVLZHdjeUlXU2FyZEtUOHJ1dVp5K1QxdW1YbXdDTzBqWmxXbXplWmVy?=
 =?utf-8?B?ZjdiOE9xREthU3ltdkxVTnpwblp0SWJOT2s3UHkvWm04Wm1lblJxdz09?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f90e7c6b-8268-41e5-0cbf-08de688e7aa5
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 10:23:48.8076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uVnQ+ybj7hpt3KOZuZwVYrSL+hJLpb6DpzNPrP9H3duGB2lwuXHVyacntH3mGWue8PGJFSIf042a1WGq4EKT1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1272
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



On 2/10/26 5:02 PM, Wadim Egorov wrote:
> 
> 
> On 2/10/26 4:26 PM, Suhaas Joshi wrote:
>> On 12:13-20260209, Tom Rini wrote:
>>> On Mon, Feb 09, 2026 at 07:07:26PM +0100, Francesco Dolcini wrote:
>>>> On Mon, Feb 09, 2026 at 11:43:08AM -0600, Tom Rini wrote:
>>>>> On Mon, Feb 09, 2026 at 06:25:46PM +0100, Francesco Dolcini wrote:
>>>>>> On Mon, Feb 09, 2026 at 11:16:35AM +0100, Francesco Dolcini wrote:
>>>>>>> On Mon, Feb 09, 2026 at 03:38:51PM +0530, Suhaas Joshi wrote:
>>>>>>>> On 09:45-20260209, Francesco Dolcini wrote:
>>>>>>>>> + Bryan, Anshul
>>>>>>>>>
>>>>>>>>> On Mon, Feb 09, 2026 at 09:38:55AM +0100, Francesco Dolcini wrote:
>>>>>>>>>> Verdin AM62 and AM62P are not booting anymore with U-Boot 
>>>>>>>>>> 42b3ee7fa524,
>>>>>>>>>> everything was fine with b5213bbfdcb1.
>>>>>>>>>>
>>>>>>>>>> Looking at the commits between the two revision, I would say 
>>>>>>>>>> that the
>>>>>>>>>> issue is with this series https://lore.kernel.org/ 
>>>>>>>>>> all/20260127081652.506357-1-s-joshi@ti.com/
>>>>>>>>>
>>>>>>>>> We have also commit 3382d75f7a6c ("arch: arm: dts: k3: refactor 
>>>>>>>>> common
>>>>>>>>> nodes to k3-*-r5.dtsi") that might be the root cause for this 
>>>>>>>>> issue.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Hi Francesco. Unfortunately, I don't have Verdin line of boards 
>>>>>>>> with me,
>>>>>>>> so I cannot reproduce this issue. This is also why I wasn't able 
>>>>>>>> to test
>>>>>>>> my series on my end and had requested board-specific maintainers 
>>>>>>>> do the
>>>>>>>> same.
>>>>>>>>
>>>>>>>> Since I don't have the boards, could you run the following test 
>>>>>>>> to help
>>>>>>>> us ascertain which of the 2 suspected commits actually broke the 
>>>>>>>> boot?
>>>>>>>>
>>>>>>>> * First drop my AM625 Verdin patch, and compile and copy the 
>>>>>>>> binaries,
>>>>>>>>    and boot.
>>>>>>>> * Then let my patch remain in the tree, and remove Anshul's 
>>>>>>>> refactor
>>>>>>>>    patch, and try the same thing again.
>>>>>>>>
>>>>>>>> This could help us ascertain which commit broke boot, and we can 
>>>>>>>> try
>>>>>>>> fixing from that commit.
>>>>>>>
>>>>>>> Sure, I can bisect it.
>>>>>>>
>>>>>>> Do this difference in the logs
>>>>>>>
>>>>>>> Failed to set clock rates for '/a53@0': -22
>>>>>>>
>>>>>>>    vs
>>>>>>>
>>>>>>> Failed to set clock rates for '/a53@0': -61
>>>>>>>
>>>>>>> ring any bell?
>>>>>>
>>>>>> The boot failure start with commit 2ffab9da9142 ("Merge patch series
>>>>>> "Firewall ATF and OP-TEE memory regions in Sitara"").
>>>>>>
>>>>>> With commit 24338c81ec2f ("arm: dts: k3-binman: Use configs for
>>>>>> ATF/OPTEE addresses") the board still boots fine.
>>>>>> I have some concern that this commit is changing something, however
>>>>>> CONFIG_K3_ATF_LOAD_ADDR is 0x80000000, while before in the dtsi 
>>>>>> file it
>>>>>> was 0x70000000. I tried changing it back without any positive result,
>>>>>> I just got an EL3 exception.
>>>>>>
>>>>>> Any more test I should do?
>>>>>
>>>>> Should I revert that firewall series, at this point?
>>>>
>>>> I did one more test.
>>>>
>>>> It seems that the issue is some interaction between the firewall series
>>>> and commit 24338c81ec2f ("arm: dts: k3-binman: Use configs for ATF/ 
>>>> OPTEE
>>>> addresses").
>>>
>>> That's the first part of the series, and to be clear I'd revert the
>>> whole series.
>>
>> This series is confirmed to be working on TI boards. I just tested it
>> (again) on AM62 SK. See [0] for logs.
>> Verdin boards are the only ones that are reporting this issue. Is it
>> alright if we revert only the two Verdin-specific commits, and let the
>> rest (TI and PhyCore ones) stay as they are? The patches are pretty
>> un-connected to each other.
> 
> I have not tested the patches on the phycore-soms yet.

The phycore-am62x boots, see the logs

https://pastebin.ubuntu.com/p/P3GHhZw8xc/plain/

But I can also see this new error

   Failed to set clock rates for '/a53@0': -61


> 
>>
>> We are working on figuring out why Verdin is seeing these issues, in the
>> meantime.
>>
>> [0] https://gist.github.com/jsuhaas22/b4d153eedf25e2269ddefc992c6020be
>>
>> Thanks
>> Suhaas
>>
>>>
>>>> If I keep the firewall series in, and revert 24338c81ec2f, it boots.
>>>>
>>>> IMO, unless we understand what is going on exactly, we should revert
>>>> both.
>>>>
>>>> Suhaas: is current master working for you on the am62 SK or beagle 
>>>> play?
>>>
>>> These changes boot and some pytests run on am64x_evm_a53, am62x_evm_a53
>>> and am62x_beagleplay_a53
>>>
>>> -- 
>>> Tom
>>
>>
> 

