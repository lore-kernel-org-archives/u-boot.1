Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ABEDCA0FED
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 10:32:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A367783106;
	Tue,  9 Sep 2025 12:32:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="h7ip/CjB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CF8F8313B; Tue,  9 Sep 2025 12:32:01 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11880830B4
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 12:31:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWK+8MIQA5xdTgBRl3xEu03JzuU8YQZJSCxTkSSJ00msm0H4krcj64nx3F/xZEpE+GcnDnKsncaZ+wEvIkEdIrIHegX7HR0UOI9dhYrZQIEsS7aqdbp1JcEEE4lX7gkXLm/pOdgfqS8DOKFzH5q2duMYOkDc35upze9KcldSY7zlvPRGMERzyjBDZKvusRMI3zotiyGWpvQSJZ3MiikfC4D4SoYA1jIrFKO6lBML0MNmHX3+g3d/zL0ZOjfOKwq22PZsaIlAg0f234wBd+yB8CGT8RVFaRAtnbbvHX/utYuvb+DCy5AdG5uqUlyCCtttGY8JDydh1OrxS59Tz5uUAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keIUKBSFLvo6AabiDkzATlpvzyulFKGUoi7rUk9aco4=;
 b=WDL14Aj+GV36p9n5sknm2fy3uVlvqg8oisK5kAukazpfbcjkbJgQCQeV3t1bdHei9rIc8QjfWSqvUfO9nBQBj0lT3qZl507eqbxx+xngsZ9MGH/2DIY0I93bHYw7iKosqOyQgf7jTq95xkjE6L8HcFSradjZqQpigS71NOQng2+GLvniVRlhu3rKmS3w+4WqxZrN3pV1AheQY/awpiK6biCzPmUIfqP8wA2xkb+GGJXfgPzXTcLLKYFRcHAVOEktE7VaXfg0sGt27/ugKUv+QC0BlUoqKIgd++EfyaGgOrPpLiC7/hDbwZXWrkQJ6yjvYG3YUQWPH96WBR9Z34LrHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keIUKBSFLvo6AabiDkzATlpvzyulFKGUoi7rUk9aco4=;
 b=h7ip/CjB6skI3wV4fD+4JeHDOU/T+LM1ogwyND4KFBTNB3ZQBcnmj88pMkz88YMPR8C3U+fyoJpZ8WirGEJ6uM0HMZgRlum9H9EG0lACy3BhvmSQfnq85NIETc8WPufx9xqkjGg+R4m+ggrbFFthBGXa+8HqFfsamTIfQCci3IIxZTWxS3fguhG3mSf9lzBAODzuZPk++zduvftD3/h0MYExl0W4YyTO49P8A+T0KdjvofOMGnSXFSQL2xY44CEVHybnjceDV5MTPC1rphvp/1KQwO0uOYednjB2HTzY2Ux40M36ZLCW7+U843Z0eGd3vOCLZaL/YMc+RxICPO/iSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8585.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:444::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 10:31:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 10:31:53 +0000
Message-ID: <2cbe57e3-f7aa-491f-9896-93f85e8a7a41@siemens.com>
Date: Tue, 9 Sep 2025 12:31:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tools: Do not generate logo when cross-building
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>
References: <b18a4f45-77dd-4f78-ba6c-2e017abc98b9@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <b18a4f45-77dd-4f78-ba6c-2e017abc98b9@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0029.namprd18.prod.outlook.com
 (2603:10b6:610:4f::39) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8585:EE_
X-MS-Office365-Filtering-Correlation-Id: b8ef1c67-bfb9-4bb4-8c5d-08ddef8c17b0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmU0VlIwQktpZVhSUVRPdW1ES1V3S1hDYmNxU2JyQzJkVFMxWDdnQ1lZaXov?=
 =?utf-8?B?R0RLMUQwSlR5dmJQUSt6OUh3bWRWc0x5d291M0E4OFNFVkF3Q1hsUzZKTHU5?=
 =?utf-8?B?Q0JCNk4wVTZuaTZKamRoOWpHSUh3NjEzL3RyeXR1eGVITURVa2FtY2xoc1Ax?=
 =?utf-8?B?UjU3SkMyVVkrdGNWaGtESVgyVWo0ZXpjMU9NMEZ5YTMrK2V4YjVyblYrNEpK?=
 =?utf-8?B?T003MmlMWlYyendyRE1yNkNhWDh5RldFL0ZnWDEwRFFNWi9iaGFLU1R5cHhq?=
 =?utf-8?B?Mi9FTmdlVGgwK3NDd3Z4amNzeS96K3BoMkUreElRYzh1bHpjZ281SEwvVWhk?=
 =?utf-8?B?UmhXSGpoVUpIS3BJUXg3aklhTkkrVnZ2c2xwRE1IbFR4QXozTnlHSGZMOUl0?=
 =?utf-8?B?QThOSmFBOXEwUFR4VlFwUzc0eklOL3ZqdHV4bFVPckI2aGU0bEJyL2N5NG8x?=
 =?utf-8?B?eXY2YU5GMkdpVzBFUTJMWERMVHFBcGJYd3REK0VPbWdsUmFsRVYyQjRaUXNl?=
 =?utf-8?B?b242enZIMkdPeHh4dExjMTRKSlBGTnJoSThhbmZNZkhrcEwvQWIyWGJaeGYy?=
 =?utf-8?B?bUNaNmpHWm5EajIrMFY5VStnajZEZk13U2JpVStpZTdJejFya2pFUlRFZ1RO?=
 =?utf-8?B?RnBsMk1lY3lqQzFHbTQ1WFE3QUpTeUl0T25EbUxxTmdOKzc0TXRTd3RTNnp0?=
 =?utf-8?B?dEw3Z09wRWs1RFBuNlZrcVNpMW4wUzZ0THRGcmh6Ny8xdWJReGVvaEVtWi9k?=
 =?utf-8?B?MXdvNTdxaHRLcjdLbjRiYSswbVJuRTNkWklkbVM0Z1RVbk1jZFBaS3hnRFFL?=
 =?utf-8?B?L3Z2NUtmQlV4WXoxNmNWZE44WSszdi9FZS9adytJb3VUVW1aMmdzcGxrbTQx?=
 =?utf-8?B?cUF2cDFpRXdKQzRlYnY2dEJ6QmpnRjcwVmhGYkpWaXlOVHY4WnAramhOU1dt?=
 =?utf-8?B?Z05ZQ1VaOGF6d0ZiN2VhWEo2Tm84TDFtUjl0eVJJbXB1Z3Q0VWtEOVFHY083?=
 =?utf-8?B?eVB3aEsyN043aHpyTDJKWFNWYm1EL0hzM21BUE9CRVY4TXAyWXp2QTRQMzJm?=
 =?utf-8?B?QmVVQUplV1VkTEk5K2VFcjVBRmdTdUhUalkxYkdkeENqZ1ZTeHNYT2FFQmV2?=
 =?utf-8?B?eUdMTmpDNkk3TFhxOFNDU3B1N2dkeVovakx1RTk1VTBUQjlVZnlhNzI2UG9a?=
 =?utf-8?B?bklQeGhKU3VKY3NYZG9yUU4ySWJuWU1Hb04vYVhsV2hKUHl6QTFlQXFDN3Ev?=
 =?utf-8?B?dDA4WnE1aXpLMExkQzRGSnNRWHZTZU1RVmxGVFZlUlFjYzhrSkRobDB4U2pQ?=
 =?utf-8?B?Y2MrUDlndEZsdkE4TVE1bUZ2RUhtQlJXeHp2VDVSVy9zQkh5R3M3TGVjRTlO?=
 =?utf-8?B?N25RSHdQSjY5QlJvSlpEMk1WNjl1K1JaT2I0SnZkSDVRMytmSXZJNktiQXEz?=
 =?utf-8?B?WUl2bmp4WVh5ZGFPcnFBbEJTUENiYUkweVNmOS9CdnorVU50OHlvamk5WjY1?=
 =?utf-8?B?SXFXYldHd1JvZHI1QmtIV1RIcUFmejZ4R0xmK3FkRmk0bHJUNTN3RTJjV05V?=
 =?utf-8?B?MmJTcDhOTE9ITk0xV0FscFkwNlNUa29VQ0U0bHVKZFZlWUdwaVlFb3gzU3U3?=
 =?utf-8?B?TTgvSDR0Tm9PYTlITUxndTZQVGNvQTVPSEVlb2tGa0NFMTJBU1pQVVVzNGUz?=
 =?utf-8?B?cUs1SmRHdnh2ZWJLUE1mQ0cyOVFzZEVGV0xIcHBnVS9aVmRSUnF5QmR3L2Ey?=
 =?utf-8?B?NVgrbmE4eStUUjh2Y3dUNmc5dDM0ZU8xaUZXczhWWFIyWEtQUmZmUzRuUTd2?=
 =?utf-8?B?NkE0TkRTVUpKMzJyQmt6eGpIR3p6OWY5SUVSNkVVWHRTdUI4RDIrdjZhSDNq?=
 =?utf-8?B?YmUwckxXM1c3Y01vQnVpTnhMWlhpdFZDeGJOdUtINHBOOWh6cEppTUYwcHU2?=
 =?utf-8?Q?gLt50kxQGjM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aE1tcTN2MjhFa3p2VmwyTUFFUkUrVDlxZ1VqZmJ0bmd2SlY3V3VsbC85N0ht?=
 =?utf-8?B?ZzVub3c0RHJaVERGZTBhaHVwZDhqSkY5RXRZbHk4WlNVaWlZQkM5b2ttcVVy?=
 =?utf-8?B?SGNObDVMaklWaEZkeWo1YjQ1NkJ1dFNPazlOR0VvekRnaExjeG9aY0JJMkRu?=
 =?utf-8?B?TndSMTlwa004OUE3M3YzVVVkbUhOZHRWZFF6emxTYTRXdk45RDYvejU3Q3po?=
 =?utf-8?B?bmFGK2hKdXYxWnVVWUpFZk1NR0lWN1lQYWwrdjI3REZiMHZmcm1GZjBDVUVj?=
 =?utf-8?B?SFNzVDY4VTlHSXE5cmtPdWlzRWxIVkxyTDRaTGhOeU5sNzR5cG93Ui9kK2s3?=
 =?utf-8?B?MnNEWEFVV00wVXNnV1lqUDhsK1JRdVc2YlFaR2ZRTnpkUVBJTlJTblE0azJI?=
 =?utf-8?B?cEI0VmhnenpScGxxWFdZYzhvSGpYdEg0T01vc2tFcm1JazFCTjczWlFiWVFq?=
 =?utf-8?B?RGtzRHNmL2lOODU4OEpUb3ZmVklkSG1lS01CQ01nUG83cnBvckhIQ2x1d2l5?=
 =?utf-8?B?L1VzQVRhWldyelNWV2ZIY2duRTBWWnFscnQ2MDZVeE1Eb1RhcVVKaElTUEov?=
 =?utf-8?B?SklvMFNOZFQvMWlPRERucTJOWHZhMm5GV3ZDR1hpQWRWZXlsV2dNMFJ1Njd6?=
 =?utf-8?B?R3BGbDJoaEtFNW1XU1FRa1Y1RDcrRG9GWE9XdG1IZ2VBblpicGpYL2Q2eW01?=
 =?utf-8?B?QjZKZTRPOExBN3lhbnhEWW16c0MyN2FxNW1JUnZud21wT3BYaVVhUXU5UTlj?=
 =?utf-8?B?YW5MbkJYSTJkVVYzcFJQOFdJWVZkU2JzSGJ0ZTI5d1E1bkNDWDJwWFFRQmJn?=
 =?utf-8?B?WGYrc0xPci9CZk1YbXJJVWpGWmNTSWpWdUJoU3IxOVlyQld0RDJNUmVnVEto?=
 =?utf-8?B?M3p3dE96U1pnZVVmS1lzbUkyekM2a2orRVJOVTlnNlNzeldnYmRnbVhQM2or?=
 =?utf-8?B?Q0dLT2xSd3BHeVEvbHh1bkdBbk1hT1VNN2ZUZ1Vsc2NyS2dvME1YYnF0ZXJW?=
 =?utf-8?B?NGJUTmVGV3lveEdNNU5FU0RxTE9NNzArVlRGMm54YWNJQ2lxTGpKZ3hLOWRa?=
 =?utf-8?B?QnliYkdtTTJNVGhOTlJMblpiQmhFZEVrZWtnS25lTjNERXUwcXdpWjNueXJ0?=
 =?utf-8?B?NFFncGwxTlZtcmZaWlhpSW4zTExmVlkzeU5GL1BDU0YwVTlIUVRXTVNxR0ZU?=
 =?utf-8?B?Z2ZkaGlPY212SHF3Y3FaWkphN2N0S0FvVXBDYWtBMDBFS2FaMVZBUE5ZVVYv?=
 =?utf-8?B?RUhJMURqRks2UldGQlV3UHowaitTVmMxOTE3RVhPN092UXB4MDU4RWNnTzl2?=
 =?utf-8?B?OW5SMXB2M2t1K1pGK0IwS2dzVExhUHFTcGtEMVpvclVWRzRrOWhVM0lacVcw?=
 =?utf-8?B?ZHZjVTZjaHNjbVBHSDZ4S3J2M2lJRkQ4aWZWdGdwN25vaktqM2lxc1RidnJX?=
 =?utf-8?B?ajNLclJpMlZkcytma2ozNnBTMGlzVXBMcS9USzNpMkhVZUMyaThFR3hXRUUx?=
 =?utf-8?B?SW5EYWplU3B5eVJuS2MyN2xjWkFXSzRrRTBmV2lpZFI2c2hXeDhjK2lOalNQ?=
 =?utf-8?B?bWpob1ZOYldvZ2djcTZoRGtMZmlIejRQQ3MxWkt5L0RFYkpUSjAvaTIvTTRi?=
 =?utf-8?B?dFQ3eTlzd3BMaStlSG9NWXpqV0JncmJQWmFWaDU1Skk4alI3SUZvb3Q2UWlG?=
 =?utf-8?B?WnhrZ0JGVlJiVFRzSTUzWXpHd0Y3SjV2aGREck1ncXJHQmJnS1dvV0RqeTAv?=
 =?utf-8?B?Vkl5N1YvYlRUKy90NlVFWmlFMFpocjUwbG5yY2JWZU9LY2EvaTN2MDVUNVFX?=
 =?utf-8?B?cmlhcGRsemZrbXhNL04xcHdOYlFIZXdsNS9jbW4rWXA2Z3RxQ0twenhZeXla?=
 =?utf-8?B?OGNFZmRsWElJN0NQYUJhdjNNUG9zcTNKMDludFl0UlhHUW5YMzRDMkFFZVI1?=
 =?utf-8?B?eEQ0ekg5Y0tPZXdkWTkzMFJ5dUc4MmxOUjF2Rk1LNlVGS0plcVEzM0pTY3Nu?=
 =?utf-8?B?ZThFcldZYjlRTjluYnZMc2l5Z0VvNjROV0R5eTRNOGpMRTJsckhzY3ZxUmhK?=
 =?utf-8?B?SUhzcGlzQTRjczkrK2ZGVzI0NEtVTHh3ODU2MERxa3VFbjNDRnhYNkhoZkpt?=
 =?utf-8?B?QjN1QkVab2l4YzlxQmh3SjZBbW1sajlueDd5cUVGUXgwTDB4OUxoVmF2N3ZP?=
 =?utf-8?B?S0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ef1c67-bfb9-4bb4-8c5d-08ddef8c17b0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 10:31:53.7799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M6lmBlE+87aUok73nqajkbzUhBeCYgZMMpz1402VP08u0EEi9wsHuS4aG3myaxAh0Sjq3RqMr5IxAI+4T99JVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8585
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

On 23.08.25 17:21, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This cannot work (unless qemu-user is registered in binfmt_misc) as the
> tools will be for a different architecture.
> 
> Fixes "make cross_tools" in case CONFIG_VIDEO_LOGO is enabled.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Changes in v2:
>  - improve commit message
> 
>  tools/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/Makefile b/tools/Makefile
> index 7eb17f92116..ae6a3052646 100644
> --- a/tools/Makefile
> +++ b/tools/Makefile
> @@ -333,7 +333,9 @@ HOST_EXTRACFLAGS += -include $(srctree)/include/compiler.h \
>  		-D__KERNEL_STRICT_NAMES \
>  		-D_GNU_SOURCE
>  
> +ifeq ($(CROSS_BUILD_TOOLS),)
>  __build:	$(LOGO-y)
> +endif
>  
>  $(LOGO_H):	$(obj)/bmp_logo $(LOGO_BMP)
>  	$(obj)/bmp_logo --gen-info $(LOGO_BMP) > $@

Any comments on this build fix? Or should we somehow get the logo
generation out of the tools build?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
