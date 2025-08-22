Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5F3CA0EED
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 12:39:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4601180422;
	Fri, 22 Aug 2025 14:39:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="B7j104TA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3759280548; Fri, 22 Aug 2025 14:39:51 +0200 (CEST)
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazolkn190130003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d405::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9DD48006D
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 14:39:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=forbidden405@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQZnGvO1a+G6/jGuT3dl+9tCLg1mnPvCqoo5anYdzyYzoS2kHrOdvYXZ64tBOnIZ0DCzuLQiue0meruRGjY9AbGiLczmj1Kd1hGHrCQsXhWySd5zul6Wmd5EZICkSubWlYGxa5E7RCEKGfjeKsuMwJg5o6N2X8GR8LVC/A9dPLySsi5CBpHDeisEqM0zAGyZD9IA44SSc08M6xUpIEvQNYT5pgcolNX8OWQhnogZTuzjWFziWg3VY3X78X/q1XOdZRYgcpVGBLPxAyoFh/G4wiKTNxJvLSxRPeyWSA/U5mRagIGTJvyMmdq2nYU95kAO38dV7SbWa89cn4e5itWlbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0c3sd9OhS92cOEnOOp1WvNuwxtuGYeJRHhg1Hjv/vM=;
 b=r6JKYLOqS3mxGnNY8aAe4F5ZAzkYJXn6IanQDIJPotOwJJOJzqkXF6rxjGyBhvSJI36khc+veV9C5zXcLBO3AWqIsOD31b9OuLcLLBQOEXbYw4BHrLFPQvned7n+BV7IdjAKqHr8Av2DJ3AzCId6qt8EbcNuIbd6ZKKw7cHEDGMZJeSiZK52JKHxGhkRRLYecRvLgVxOXC4qNxKOu1wRyvOmrn4gR9LKvCnZZfFCE8Wmzt5J83DdLeYwX8bfxiGroZ2A8Mzqq/RAZPKL5ug1p988ADXNWKYL94EFyUenXHOs6JtLuSSoQYOaJ6mf2hS77KJyCbZwfE7v5OLi0Kixjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0c3sd9OhS92cOEnOOp1WvNuwxtuGYeJRHhg1Hjv/vM=;
 b=B7j104TA3DQ1UpizPqDY/je13inuEzayVNFFi33Qag1zNxNj/nhy/CGLvJnWkx3YQx4KrRVbbC4nusSn6EA9WPNY9RE9ksusUbrmJXryGHvfYUjqmd99kPT6MsQkyXLedIExGXxDwuL3rptUF89HLgClGr/Rt2DuEGjFsaIipej4JCx2sIy1PIvm5KYDmvWu21T8ZC+OtwG0oi5gya+3fGyfGUoGElvhHng5iu0vYT2iq+sIoyGYfFU3NT/rRvFfSufMplWrZa5g2s61uo01N0evOH8LWvmvcfqnKeUhtBojKVpyZklDkXos+AjFw61W07HqdVsS3o0BIxZAZKnl7A==
Received: from SEYPR02MB5557.apcprd02.prod.outlook.com (2603:1096:101:52::6)
 by SEZPR02MB7104.apcprd02.prod.outlook.com (2603:1096:101:194::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 12:39:44 +0000
Received: from SEYPR02MB5557.apcprd02.prod.outlook.com
 ([fe80::cb39:3489:a58d:107f]) by SEYPR02MB5557.apcprd02.prod.outlook.com
 ([fe80::cb39:3489:a58d:107f%5]) with mapi id 15.20.9052.012; Fri, 22 Aug 2025
 12:39:44 +0000
Message-ID: <SEYPR02MB555736C83188FF65B048EBA9963DA@SEYPR02MB5557.apcprd02.prod.outlook.com>
Date: Fri, 22 Aug 2025 20:39:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] clk: support arbitrary clk_register() sequence
From: Yang Xiwen <forbidden405@outlook.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
References: <20250621-clk-reparent-v1-0-48a7f2f31c59@outlook.com>
 <dc4a7b0c-b4d6-48ad-bf2f-6df7e156a626@outlook.com>
Content-Language: en-US
In-Reply-To: <dc4a7b0c-b4d6-48ad-bf2f-6df7e156a626@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::15) To SEYPR02MB5557.apcprd02.prod.outlook.com
 (2603:1096:101:52::6)
X-Microsoft-Original-Message-ID: <31daadd0-3c48-4e42-ad3b-b2a296ec82ea@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR02MB5557:EE_|SEZPR02MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: 17e6e3c4-e301-4b17-33f0-08dde178f86d
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799012|23021999003|15080799012|6090799003|461199028|5072599009|8060799015|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ajlhaDJFOXF4UW5RM1FLcmlPam9RQkFTSDdBTkI2YWl0dWxxSkhuVGxQT2h6?=
 =?utf-8?B?NHQ1WXBnOG5lYUYwakpubDZZcGJaYmk0Z0l3bmJvT1l4T01aLzNJdjhKYnN4?=
 =?utf-8?B?OUtEWDNlSk52d2pBMTZPb2xaZjBxWmJnakw1RTUxMjNKek9uRHJQNVc0NTBO?=
 =?utf-8?B?SGpyb3I0MHI5WUlRNHNRdDV0RUlpYy9yREpHUkZJeU9qdER0bWpMQ0Qra21q?=
 =?utf-8?B?TVJnbWpYdC9CZVdhejZ3R0FMYy9JUjNmb3Z5TnpyN05FQ0h0a1p1UG5Iamh5?=
 =?utf-8?B?MlhxSkdSV1Q3R05oVjJHZlNEQkp6a2lBVnlHdnRKVURpeUxzMnJQZUZtWFAr?=
 =?utf-8?B?L1NnNktTVmJtMzA0SlJWSlJvdmZFdmE0UTJ2L1R4dHlhQXh4UWdaRTJVdFJs?=
 =?utf-8?B?V2tmc1hlUng0NnluVDdPS0hxKzc3UWNPOUZlNDdnWmt5NEdqYjB1UjcxLzgz?=
 =?utf-8?B?UFEzZXFXUmZLNDRtOWwwUDFjbm5LaHgyaDNlM0ZxMG5iUENTbklycE9neEkx?=
 =?utf-8?B?NFFqTkd2UW9TU1dBZ2p6SExoT0tackNqeElaZ2RtNmlUeHltVWRpdlJYOUtZ?=
 =?utf-8?B?REJjVUVSUDJqb1BmdWR4YzBqb0dlT2lOV3pWd3VUVm5zVS9yS1BMOVZoeUtr?=
 =?utf-8?B?L05nMG1QcmVIRWQwYlBLSGgrb3FaK1c0Y0txV1pPdHE3UHFxaWhDVkhPNldJ?=
 =?utf-8?B?K0pSZlR1bzJqSWJ3SVpZVTlsQ2hyeTV3QlgreUozenFGbnRpdXVaUkVWaVAz?=
 =?utf-8?B?MjczSHVzc2NQcUhjVWMxakFWU3JnOHNuZFY1NFVKL2ZnWEVzUDY5cEpxbXRx?=
 =?utf-8?B?SEFIL2paOThJZzRWYmxuRWVpN1FlcUZKTXNRQm1SVkxCZU9XSlRTTkVsL3dw?=
 =?utf-8?B?STJJNk43RityY0dyN3J4V3RjUTBkWFhITDhXK01CQ0VSQU1zZzk3MTZENEtE?=
 =?utf-8?B?RUVyZVFLcElxdnFybzhZa2pMSVBxUWIrczJ0UUQ3WUZnWnFzQzREZGpaeGht?=
 =?utf-8?B?R2xVK2NUdGpJclB1WDZBZnRCMHhhZW5oTU4xMVAwekdMNEI0RnEwL2ZmdDJG?=
 =?utf-8?B?OW1LQ2ZGRlhZMkE0cExyZ2hSamw4THpIWkluZnpxSVN0a3FGWkZqdDNXTTdu?=
 =?utf-8?B?eTJ2RlExRWdYdi9QdGNBYWxDdmVVTC82TzFuemQrNmFQVWhsZVJYT3ZpUWYv?=
 =?utf-8?B?aE5jOGluNDVITUR0WDdWeWtRUVFVZmo3cmJCUXQwNzFoelNHVmMxSlJMUFB3?=
 =?utf-8?B?aE80RXVoYzBOK1kyWTFGYStNY3ZsazIrTUwyYmtMZzVLL3JUTVI3VEM4d2o1?=
 =?utf-8?B?amlKRWlNRjlXRnkvUHZsYzR0M2dQWFZEaWVTeXRDR1h3NlNZRGRXZnRZWVJE?=
 =?utf-8?B?bGI0bFhpOENJOEI2ZTllb0JYU0p6QzBMNXkzZkw3aFFOSGZUWEdqdkZTWEhB?=
 =?utf-8?B?Q2JEc3BXWVlyU0RRZmpqWDkrcU1XV3g4Y3dLOTEyZmRHc2F3TWhyQjRmNlBs?=
 =?utf-8?B?KzNxSWhvUENOS3JDQ1g4TGRMMGRLSW43aU92a1hOSlk0MVErNWtmYmVXZnpY?=
 =?utf-8?Q?YACYi6ek8Nf3TJtNxQMQsVASc=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3Z2YUswbWxqVmR3SEFWdnY3NGlxU1hWQkdXTVFpOE1aQXRPdThiUWdzSUFi?=
 =?utf-8?B?NXV6KzlvYlVUWDdhMFhNQXFiUFBoODdlbU1QMlZDR3JwVkhwZTE3RndpTkVV?=
 =?utf-8?B?akI2UmtsR3UyVWRzc3o2YW5WS0xwYlVGdlcxTE1IMUdWZ1JyRmxwL28zODBQ?=
 =?utf-8?B?TDBJU1NCSVdtVHQ1T2E1dDBISThxRXhndmluVlB0WWkrVlhYNCt6MzJEck92?=
 =?utf-8?B?NENMcmlTbGJ0azlPMWl3Rm9SS2ZaSUlHMzVkRHZINkd5WWZUQWNuQmtaVkhW?=
 =?utf-8?B?bFVhVFhXOC9yZGtteG5JcUc5TWxoWDNENmx6RDF0WHJ1Uk9odEEzZHVEUjdI?=
 =?utf-8?B?cnpkL2xqYWdHdmNjSGVSamEvcXgrVFZTT0d4RDNNMDQ4UTlnZjFUMW9kYXdJ?=
 =?utf-8?B?S1FPZmg4VzVLWmREWHQzU2dRUWxmU2FDdy82eDJnWlNNakxpMUpXYUUwQXdp?=
 =?utf-8?B?TDBEenFwN0lWaVZmTUNKNW5UODZqRTBZbWtoRFB4UnlOV3BOeG1scTdoUUdF?=
 =?utf-8?B?dVIra2UxVitza3ZtTzVQY2hlU2hnL3lHTnN2NDBVNytzbUYxTWpGSmFMZzZS?=
 =?utf-8?B?a3RWdkMyTEx3dE9xd2JWYlRMemVlWElzSnhQaFRFbjJ5Mkh2b05tMTZnOC9p?=
 =?utf-8?B?eEpDYzRrRE5hYWwrVWR5MlcwQWFFYUVXUGVmQnkrM29pR1Q2TzVmNFpEdWMy?=
 =?utf-8?B?NXljRlU1SjRzWTcyS05HUDJ4bG5MZXd6UVN6Z05PRmo5OXBxaXQvNXordXNt?=
 =?utf-8?B?UkM0ZWR3Z1RLNXE3RVo0MnFBRlF3VkRDdjIwK3k2UXZRMnp4NFkrRVlUZFZS?=
 =?utf-8?B?UUdjUlp3d2ZUSWhjTTQrTDNsRzBGVU5WRWV6eThlbjBtQjg3dlpWU0tYQnRK?=
 =?utf-8?B?MlhhWTkrNThGZlhWSWtrc2VydWl5Nk9ydGQyczlNaXRlMVJzUG9hVVNoZWVv?=
 =?utf-8?B?aGsxMjBzT1JiUUFtSUxXNWZyT2lSaTcxQVlIY1lxVWs2MkN6RUF2ZGVOOUpH?=
 =?utf-8?B?RDNKUXBGY0xjaXJMYWJmckhLN2pwcWZUUDRvSEZ1RUorUHA4bzNHT05lYWN1?=
 =?utf-8?B?aThKUTlIWE5CTnc4QmRRV1RXNU8vbDJmYjFCNGtkdGtKL2c2cUFFUFpsWVF6?=
 =?utf-8?B?cW12VHEwczArci9uMTdMMWRveUZqdVdGeUlGVlRyUlB6S2I2KzVId3M3UDB1?=
 =?utf-8?B?Ujg2M1BqVldBbVRrZzR3Z3Z3RGN5RXlXQVRKWlRoemFJd1Y2dWZnUi9nNUJK?=
 =?utf-8?B?S0xuenc2MlZvSTdrR1ducjhGdm85NzlYRE40bitlNWV0UzZPUWNNRzNGclVR?=
 =?utf-8?B?dDRYNUdEQjYrU3RId2hiVjBDSG5zQzRtYU9obUduK2x4UWRwdE9KRFY5ckxh?=
 =?utf-8?B?Ti9SNUJYRzlpM1FTSVV3bWRPbERYcFhWcFRrRkYwT283Qm9heUtyWnJlTCtx?=
 =?utf-8?B?UEdaSUZDeEZ3d1k1NDZNd0F3Zk52ZjlwUDMzeCt0MFdMZUJ3MzFqeUdjMWNw?=
 =?utf-8?B?T3Q3SWZHR09SdVJmUjdDMGdpK3lvaGVEVUFrMm9hTk5FNFFtUXM0bkNPejB5?=
 =?utf-8?B?NkU3eGNOMndPU0dDL3BRR2hhSGJrdzJFVzREQ3BwdllaVDVpYVVJWk1UMTk3?=
 =?utf-8?B?OVUwVFMwK3dIQ240RE5mdkpLZmhWZWFLVDlTSDdBdTFmWUNmSUcvNU9TaEhp?=
 =?utf-8?B?TXVFeURKQ3pCZ2JIK1FKK0tTTkRXY0k3NjE4d3ZJUHhyV1g5RzBuRFB5UGlH?=
 =?utf-8?Q?hAJPfm2duMqemmHN3hE9SN/ve99yFS64RgnQMMS?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e6e3c4-e301-4b17-33f0-08dde178f86d
X-MS-Exchange-CrossTenant-AuthSource: SEYPR02MB5557.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 12:39:44.4663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7104
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

On 7/2/2025 10:47 PM, Yang Xiwen wrote:
> On 6/21/2025 6:54 PM, Yang Xiwen via B4 Relay wrote:
>> Currently U-Boot clk framework mandates the sequence of registering clks
>> to begin from root, and then its children. This is an addtional
>> requirement that doesn't exist in Linux kernel, which makes clk driver
>> porting more difficult.
>>
>> Let's handle this entirely in clk framework and give driver the freedom
>> to register clocks in any order.
>>
>> This is done by assigning the parent "lazily". It will cache the parent
>> name in the core clk struct and try to refresh it when clk consumers
>> call clk_get_parent(). It's transparent to clk consumers as long as they
>> only use APIs provided by clk framework.
>>
>> I've ran `ut dm clk*` and verified these commits does not break any
>> existing testcases. Though no new testcase is added because I think
>> existing testcases already test the logic very well.
>>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>> ---
>> Yang Xiwen (3):
>>        drivers: core: device: set new parent when old parent is NULL
>>        clk: allow assigning parent lazily
>>        clk: sandbox: reverse the order to register clk i2c_root and i2c
>>
>>   drivers/clk/clk-uclass.c      | 47 
>> +++++++++++++++++++++++++++++++------------
>>   drivers/clk/clk.c             | 14 +++++++++++--
>>   drivers/clk/clk_sandbox_ccf.c |  6 +++---
>>   drivers/core/device.c         |  5 +++++
>>   include/clk.h                 |  2 ++
>>   5 files changed, 56 insertions(+), 18 deletions(-)
>> ---
>> base-commit: 721eecd9cbf2cc59c5230abd37d02d4a02f75cc7
>> change-id: 20250621-clk-reparent-89d75f6a8e09
>>
>> Best regards,
>
> Ping for review. This will be used by upcoming Amlogic meson8b clk 
> driver and is tested.
>
It's been 2 months already. Is clk subsystem still actively being 
maintained?

-- 
Regards,
Yang Xiwen

