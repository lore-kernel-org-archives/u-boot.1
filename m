Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 627ADCCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 15:49:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90B83836B4;
	Tue, 28 Oct 2025 16:49:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="XdoWDGVc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 678AD836D3; Tue, 28 Oct 2025 16:49:55 +0100 (CET)
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazolkn190130003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d40f::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2A6A80422
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 16:49:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=forbidden405@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=knWuElljt5wPbvMUTH2GNwuSyYj2LBefhfmMS5xinuSW/leITl6Z6vqswYfP8W2b6qrEMzbwSd7nZqFJ+WiZBbk+Ip7jJc1/dnhOmsuFpAaEm6QjNaQRzZZxqRNSVs77Vs7TWuuT8tjdIjC+zTnmAbEJYLKj5nlERi6OEaBY1/PDEL9iaYs24CR5z7BYcFEoWviPvGeQG046eueu1RkltEEKCiJlYZ6sTy8G2sGhEI1lNgZYbJgI45wEvadau0RM2/rIkYbeuHrd6thSxzPhyw56zCMzpbUc4+pDJfUEGm5QcMoh0hePdy8E+zHJhg2T9G8lDnlHd50SJl8KgadE2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgnY40KYi+/At9NQaVgrNzvUzv4Po+ZK8OtlonAXjbs=;
 b=kTMA8QNsph2JFeSsdXR9ZyZrfr7OoLBknb14yivTWd+9bp42fHkZ5FZ08itQzpLLE2F7D2llGfwwZGOyz5LLXahFwmiTwh33OIDXy52HV+MKnQ3rOM61RwsA4eGRYKUkcHgKCjcel3c8/wNNwYO9NYFWthH1a/ASXlMYrhasuCyCnBeihvAyaU93wEvCC0sZoeeEp6PlXXMK6NLjc00PqmylgZLCUQhJgtUXvRmuyFDS1b1deb5nMyvh5UawdooACppsGtJEIM3Ayryeoh+CZi1v2yTx/VWtUhFUSjpqSugJNCogMnbQJpE3J5RZAFNUfFVjJQiU6D2psBj0hUsCFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgnY40KYi+/At9NQaVgrNzvUzv4Po+ZK8OtlonAXjbs=;
 b=XdoWDGVc7+3CeZVs2e1bJDcOZgwwLiRgiMAojkGJFdgNsb3fTKQ5o2WYuz0Y98emw7t9JQ7xehoahwvk5GU/jP/lUFD/OgZLtnETYUh3VOlCV7hSQYovDcD0YTeDuTLStSndB68Q5knNznt5kITFS1sPeuYqmocHlNn9jgBu+kcC812guCXcu/wAK40J83byRxWPSQ4JP1zKj1BByDGaipnyJADaKqzSQNEqEB+gH0dbeZROgoBzJC4m0DpRLYr0rgXs0xF24PO9JNuQFQRrz571co1RQ5XUGdSVo0EuWMjShx4jYYAuE/s3T22JZ+F2EM+yunG8U0KRgttXP+hZ0g==
Received: from SEYPR02MB5557.apcprd02.prod.outlook.com (2603:1096:101:52::6)
 by JH0PR02MB7428.apcprd02.prod.outlook.com (2603:1096:990:62::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 15:49:48 +0000
Received: from SEYPR02MB5557.apcprd02.prod.outlook.com
 ([fe80::cb39:3489:a58d:107f]) by SEYPR02MB5557.apcprd02.prod.outlook.com
 ([fe80::cb39:3489:a58d:107f%4]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 15:49:48 +0000
Message-ID: <SEYPR02MB5557BC90C2AFE76428B73A3696FDA@SEYPR02MB5557.apcprd02.prod.outlook.com>
Date: Tue, 28 Oct 2025 23:49:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] clk: support arbitrary clk_register() sequence
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de
References: <20250621-clk-reparent-v1-0-48a7f2f31c59@outlook.com>
 <20251014220352.GA338016@bill-the-cat>
Content-Language: en-US
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <20251014220352.GA338016@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::17) To SEYPR02MB5557.apcprd02.prod.outlook.com
 (2603:1096:101:52::6)
X-Microsoft-Original-Message-ID: <07a65024-f888-425b-bbd7-bdf979a1523c@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR02MB5557:EE_|JH0PR02MB7428:EE_
X-MS-Office365-Filtering-Correlation-Id: 1be04791-f9b3-437f-4289-08de16399f21
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|5072599009|461199028|6090799003|8060799015|19110799012|15080799012|23021999003|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UlREdnovcFIxbTI1RXBFaDlnM0dZWThCTWFGZzh1RGdESDlGamc1cm9IYnJN?=
 =?utf-8?B?dlZiVDhSRUVRVEliVytaM2duWXF4Z2lJbmo3TkpKUkFzbitEVWlkbDBxbXhk?=
 =?utf-8?B?T2twTXVnUkVnYnRQT1BEMzB4MEJRWHdnYzdZY1FjNEt4WlQ4SEoxdm82dm1x?=
 =?utf-8?B?bGxtSTRESmE0NUJVa0lCYjVybjg1MHZaRnlvMDVHaE9yZGd1YTZuNm1kbTgr?=
 =?utf-8?B?dFlLL3hXY21KaTQ3Sm5oY21CQmhLSHVTalJWQk4wV2tKR016NDkwMlNUYTZv?=
 =?utf-8?B?Nm9Fd3FmSWhXWFJVYVFFQ3NlWTZJck1rUlJXckpaL001aEgvSjRPL0ZETFF1?=
 =?utf-8?B?T1F5cHJvclhyQU4xaVBpWG1lb2lKZ2dXYTNZSm9zbDhnZmlKcUErcFZGTmho?=
 =?utf-8?B?Vmp1S2tWZ1RJVnlZTmxiSzBJMW5UblhRNm8ycXZhMUU4a2Q2RlVWSkFqNUdT?=
 =?utf-8?B?YjkvaVJzMlJyK3JqTzFuMzlzNG94aHdNSFJpbFpTM0RHWmU1ay84aVdSajVt?=
 =?utf-8?B?eDZQYTZaYmF1bDM0bVVPOW5reFluejBRbk9PN0E3b1dHRFRMN2I1QUo2ZkxK?=
 =?utf-8?B?QkpUM04wNU9DbURTQW4vZE8wRmJVR1dmWld1aVljRGZub2xUMWJOQTRWQ1dn?=
 =?utf-8?B?QkJWK0tDTnNEY0FsQUNoOGh3WDBwUVNSWnBnUTFLa3g0aCs3NDhhQmo3d3BM?=
 =?utf-8?B?blRmK01BQWNEcGVOeUt3aEEvTnNCTyt1c1F1NDJZTEpNMjlpNE5OZFo3dUJ0?=
 =?utf-8?B?Z3loRk9CaWo2Q3g4MklHRE1Fakt5WHNxY1FnVGZiNm1XcnJsaDc2cFQvb2cv?=
 =?utf-8?B?R3J3a2lSWXZCMWJidDNLYzlLQmwyc29Kc2dHZFV6TXRhY29oOGRzRW54dlk1?=
 =?utf-8?B?bjNRNUJBdGlQa1c0Y0QzT05YeHV2WlJCSGhobHpPVCt3UFc2VE1KU1RmdTcx?=
 =?utf-8?B?VEwxa0dWQkZzMTBwRlFKNHhpMXMvQVdJQm9zbWhQb1VPRE91ZUl1QThuNG5L?=
 =?utf-8?B?UEtZcTl2RzFQS1lKOHVQSE5pY0w3c0FzTG9BSGltU3BaekN0dzR3VFBvZFM1?=
 =?utf-8?B?bUhKKzJQeU9tdmFBakE1NnR5bnlDendnVEQ3VDhMektmSVJrTC9xQmlwTWx1?=
 =?utf-8?B?YXluTDd2NXhnak9IQkpSTHNlcmlJTFJHYVJ1c2IzeUptTGRxTGh2WW9HUXI4?=
 =?utf-8?B?emhsOUovT3MzVWVFeGpSSmpCaXVYb1IyUUcyd1ZyZHRFdlFsZndqdWtreW1j?=
 =?utf-8?B?UFFrWFEwaFRxNXRLbnNNZlRLbWpFaXRtOUIvTU5uNnJoVnFselFwNEV2QXhN?=
 =?utf-8?B?b0N2UVdsTUpjWmFUdTcwV1MweDF6alJFc2J1TTlpanlqWVUvOE9qREcySnhx?=
 =?utf-8?B?KzhHbThaMzNVTDNncjJQWGlJWG5XTmNSRUFYcHBjM0NJOXQ4SDlCN2F1L3dE?=
 =?utf-8?B?ZUw2RGZVcERYeU44K1o5NG5UMC9lKzRFUm1zcWh0Q1BHVVJwNTNJZVp1MUtp?=
 =?utf-8?B?aXg5NmhuWHlyNEdKa3dsM0JjZ1RuN1JVMXBmZ3owSnpTQzJoRGNWeTR5Zkpv?=
 =?utf-8?Q?jpMlpV46yQx5F9boaHqCBjvlc=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjhCRG5DN2tFYlpoL2JlR2k4UjB5NTNUZ1ZmT01ueVF1M2UvWlpINGpsMENx?=
 =?utf-8?B?Qy81bVBjeDZHRHl1cG92Y21HbUc0WHJiTkVreXNGTDROS1ozeXR1Y2FDampX?=
 =?utf-8?B?Y2hiZVI0ckpCUzVTQ1M5U1hMU21DekRtL2F2WnhYRW9jUXN6cWRkeDhueWVF?=
 =?utf-8?B?dHMzVVo0cVZDM0E2ZlQ5dWkzWXV0cjk3ZnBFR1hBQTl6UzZpTUM0Z2luTWda?=
 =?utf-8?B?UC9UemI2MWpMem9FbzFJNzdvVCtyZnZpQXN3d0tqcUVPUVpkTnhBRjVUQW5W?=
 =?utf-8?B?bnFiY3ZuUWp4WnFWRWVHTTVTT2UvZkhLcFpNS0pnNFhRK0RMZzk5NnY1aStn?=
 =?utf-8?B?bGd4OFc3QllTcFB6R0xSbEZ6YVdyRTBNbVQ5SU5NakpwcWE4ZlZHRnovMWgr?=
 =?utf-8?B?VFUxS0Zqd21kbUorZVIxUDR0c0Q4bVYxbnE0RVNYQ1R6NlVtazdKN2UrSUlh?=
 =?utf-8?B?ZkIxRVBpblZ1R2NvSHJiSGpuMmw5RzNlUFc4SUltWUozRFVnNHRURlNhemF1?=
 =?utf-8?B?U3R1WGl6clBxVGFpS1FwN0xuTFJIKzdsbHBxSjJReTYzREpFM0FabVZBVGlq?=
 =?utf-8?B?bFBWV0IwVVArWDNXd2VHeWg0bGxEcm9ZelBZQWNEVmdyUzI0RVNER08zTXNj?=
 =?utf-8?B?YWZINitIZU5URFVFdlhHN2J1eXovYno1RDZEczhZbjhza2tSeDhCNVo5NUgw?=
 =?utf-8?B?ZFExMG5Id2F6eG1VY1AwYWhmdjQrR0k3SHR6em93YnlJUTcyWGlScWdNUDU0?=
 =?utf-8?B?V2wwdnpiN3Z3VWhramgwdnVTQlh2WmVKdE1xZm9mdWZXSmFlQzZFQjZBYkRx?=
 =?utf-8?B?dVM0L2pKMS8xVlkydVpsWEpGQTc2VWVVNUwxV0JUMm5OQTFFNHFRVmZ6dEhk?=
 =?utf-8?B?eGgzUCs0Z2JocklFS0FTclh0c0NxWERPS0tPVGlZTklqdHgzK2MvY05wamFX?=
 =?utf-8?B?b2hxMjVTb3doWnpTZ000Y2dDOXJxUS9HUmJERm1UOEVGZ3Y3NGpNUzg4eVE5?=
 =?utf-8?B?N0FtQnlKR0c3NDdxRXNJR0NMaFdDN2ZyTTRRVWI4bWZKd1JMOEpCNjl4eWM3?=
 =?utf-8?B?UVpSTmJwamd1K3J1Sk1TVE1yV3AwTHh1RWNZLzJUNTM2Y2NaZDZPOHlqMU5D?=
 =?utf-8?B?QkJrWDA3bGZOdG5SSEs0L2VsaHZ4RHJmYzBLKzRpRmpJSFcxeHM5dVZOWTVR?=
 =?utf-8?B?RlcyMmQxc2hTV0ZycS9SU0dPNDcrQitmaTdqMUFreFNubFlpTENMWDM4Qmxm?=
 =?utf-8?B?UytMVkJTM2NjWGdWSENIc3FzVU1jQUdMOGVtN2JCbkRKUzZjY1dvT0ZUZjRZ?=
 =?utf-8?B?WmhrYXFieE1uQVZPZXZYcDFueVVNWGNLaTc0WWRLOUFKV3B1VUhheW1yYkpp?=
 =?utf-8?B?TXFIWWh6TzB3V1JzZVZGZ1RrM1lnKyt6RkNIVEtOV1FQaWZLaVhaOW9iWFV6?=
 =?utf-8?B?VmxObXNzQlRJMVg5Ly85NnZHbEljYVBOUlVFb3JBM0Z3SHJPV0tBelpmMG9M?=
 =?utf-8?B?VWNzY2RnK0VNcFNabVNzcU03eDg1aVd5cEtDc3pNdkh0Q09rT2pkR1hzZ1pp?=
 =?utf-8?B?ZGhPZHhJNmt5ajBWNXRRZlpLQkkrVEF2c2xERWowMnUwdTBGQThRa1pKREhj?=
 =?utf-8?B?YUJzVEFJVjNiM2FYb1E3NTVjMm1idEdaTjhyYVhQdVF2QlMzOUEzZmFuQ2pz?=
 =?utf-8?B?ZkRiM3BWVnJzSFdLT1hFNmRTY2hNanNzMWk4K3dxQlQ0ZjZ0OUxvQyt4SXEx?=
 =?utf-8?Q?NvkK/Xed3QUWTr46LbzxAH6HRQrhEbdu66fZDQW?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be04791-f9b3-437f-4289-08de16399f21
X-MS-Exchange-CrossTenant-AuthSource: SEYPR02MB5557.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 15:49:47.8030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB7428
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

On 10/15/2025 6:03 AM, Tom Rini wrote:
> On Sat, Jun 21, 2025 at 06:54:17PM +0800, Yang Xiwen wrote:
>
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
> Sorry for the very late review. When I build this on say
> rock-4c-plus-rk3399 this is the size growth I see:
>              rock-4c-plus-rk3399: all +228 spl/u-boot-spl:all +500 spl/u-boot-spl:text +500 text +228 tpl/u-boot-tpl:all +552 tpl/u-boot-tpl:text +552
>                 u-boot: add: 1/0, grow: 1/0 bytes: 228/0 (228)
>                   function                                   old     new   delta
>                   device_reparent                              -     120    +120
>                   clk_get_parent                              56     164    +108
>                 spl-u-boot-spl: add: 4/0, grow: 1/0 bytes: 500/0 (500)
>                   function                                   old     new   delta
>                   uclass_find_device_by_namelen                -     172    +172
>                   device_reparent                              -     120    +120
>                   clk_get_parent                              56     144     +88
>                   uclass_find_device_by_name                   -      68     +68
>                   uclass_get_device_by_name                    -      52     +52
>                 tpl-u-boot-tpl: add: 5/0, grow: 1/0 bytes: 552/0 (552)
>                   function                                   old     new   delta
>                   uclass_find_device_by_namelen                -     172    +172
>                   device_reparent                              -     120    +120
>                   clk_get_parent                              56     144     +88
>                   uclass_find_device_by_name                   -      68     +68
>                   uclass_get_device_by_name                    -      52     +52
>                   strncmp                                      -      52     +52
>
> (using buildman's 'bloat' features to report size change). I'm fine with
> the growth in U-Boot itself, but that's just too much in SPL and TPL and
> we need to figure out if we can avoid that somehow.
>
I'll make this feature optional for  SPL/TPL, but would still like it to 
be always enabled for U-Boot itself.

-- 
Regards,
Yang Xiwen

