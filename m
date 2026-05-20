Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86D2CD4F3D
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 14:40:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C203A846F2;
	Wed, 20 May 2026 16:40:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1ISuaoB4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F88B8488B; Wed, 20 May 2026 16:40:42 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFC69844CF
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 16:40:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qj5MhiBblLTqjeJEzghV3SQX2cqdw9tNFMrTUC/UGeIJ0gdEDIRXoWkj5uzy4HqBsPu6XXiSoWJ3oX+MJ2bXGE8fSYp/tNW+U/ckhvt9V6aT95C26hDO2gC2S0mHtTihhULICeqtz5wVYa2P/k6m6Ed2202ULgbFL54qkhktbZhS45eqziEInSFj56CVLFXXjslmt8XffAFnZoA+jHwnxMwhFs6USNGfbJn/JeBxf/yol/TuctobVqwSj9980oVfjIugNBw3yH9aMnQqw36BaVXrePxhJ6/MRItvZPyhCHB2mD6rZJcU1u7/W7lpbCYSFipR5Scj3FAus5ckV+gYLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9MLXHxangmHggoD3u9V34IvLqaW5L2ugCigtNYAlI0=;
 b=Vt65sp9DRJFrOCczzQQqH6rVt3EN0w4sCu91EBmu3TKwYEON+WSIpPtlQdGFWb6Xzmx0JmvHOY8P0AFRYQANLw0x36wgxAAKj5s7VgKb9LTPqL4ipdsMERv8xQ9lMeUZIHWa10RUd/soceDc7+zUJNIwoLzxLep4hPazEmBCaRVVG/yirtyyyb8EeI3mJMCz/84FVkDtNQTu8Qt0dohnqI85yRfhDHw4muNjOyGshQz3iIE9h76FifYyyUr73jcFRPnVjAmUJ+HTW1p5NDpKXfi/5o7v0SVsuiMS/oqLxAYN0VTF06tqT+00hOsTS8tZ6ykSbaaX4OxgOYBvyMG3gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9MLXHxangmHggoD3u9V34IvLqaW5L2ugCigtNYAlI0=;
 b=1ISuaoB4gP6lR6nzD5aNuJEoeZ3dXPqi1DLHlwQ+EsG/IZnr+PuznNcLyjH+RXh7abfHfKEq6brcCP2gFiN9qBvK7nJd14RHKXnGB/XUWycwJvgfjOVxLZbhO5+2hCYNLD7kamMg4FXHYs7OypJCve0k5uP/KUxhu48iI6msJBg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by BN7PPFFC4F04B28.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6ea) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Wed, 20 May
 2026 14:40:18 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0048.016; Wed, 20 May 2026
 14:40:18 +0000
Message-ID: <fcad82ba-73b6-465b-86a7-9a1014d5529f@amd.com>
Date: Wed, 20 May 2026 16:40:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] reset: Add reset_reset() and reset_reset_bulk() API
To: Maarten Brock <Maarten.Brock@sttls.nl>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "git@amd.com" <git@amd.com>,
 Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
References: <cover.1778665323.git.michal.simek@amd.com>
 <b8229b9f7b357cf6013e8423831a9af1d69fefdb.1778665323.git.michal.simek@amd.com>
 <GV2PR05MB1194140D0CFDB4D8C63BB998183032@GV2PR05MB11941.eurprd05.prod.outlook.com>
 <0f7c82f8-dfff-4c0b-84c5-41f189ee042b@amd.com>
 <GV2PR05MB1194186BCEE688E85977E22FE83032@GV2PR05MB11941.eurprd05.prod.outlook.com>
 <12534d6c-6961-4fb7-80c3-d83c3f8d13dd@amd.com>
 <GV2PR05MB11941B4DBA7BBB814C32BFEAF83032@GV2PR05MB11941.eurprd05.prod.outlook.com>
 <50aef2c8-562d-44c6-a8af-315a6266f07a@amd.com>
 <GV2PR05MB11941B769B4CC8DCBF3E7E27E83032@GV2PR05MB11941.eurprd05.prod.outlook.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <GV2PR05MB11941B769B4CC8DCBF3E7E27E83032@GV2PR05MB11941.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::6) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|BN7PPFFC4F04B28:EE_
X-MS-Office365-Filtering-Correlation-Id: 711d6d74-0005-4611-1605-08deb67db6be
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|4143699003|56012099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: BaxuftKsBDozeSqouz7/9IFpPS2ZGLNYQJc0fyLl8dSv4c0pBdybdyGmYWKGGo6B5eBKeJ2KmtHfNzcXSbOSeJ/YGFsE967QgGE1BcRfTcoRzxl0589CtabJuEZcglCljtOa6uHUsI9QAnW1/EkNyIw2/noKSdOGc49OKFYE1PIprmtOFgAieDc4r8J+fv0hGakVFONYy8JwCrHEkDhd1BKR67nxK01XVyHTyf2SfINxsQrjMVAYSltfsGu2BFv2lbzd+qyPCAoVwb5wDbBvVSDVLVcPQW1htlpQsWvrvPko1natQyzpfYOyFakRoYCA3rz1lwfeXkUBAeATbm/a/lSVfvAeDYqhAokXqB95KqBP3IjlaZa0JximU73mN7bhDV41M3M95H+IujQeEUrJEvoaoDlAkIEdhcRr0yJ1hStCifwQEWhbaTB87nJHm/4rSUEJwvNG1g51rMfCanWtvEwxRTRnaX4vCfmQzJIkAWLG73HbcO0zOsGm/vFj8Uq1+WhgKHc70OxBR5QkJBFm/f+gzoZ8MZvBYQlnA7PpdlFX+hVNNlKrN0O3Kadh3pEX4l2TQZncEpnj5dJAyaAa+rcfg/42YRAR7AiQbg7GCbvysRG0Bz2q9Tl6q6Upe46AbsQpxP+NESHYPQ5rYtjQpxkC8O/4BZE+/286yf+IiLGlvCab5adt6bkZD6rG3R3e
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(4143699003)(56012099003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTNNZzNvRjJhYW1iRU5kYXFCRWFOaFp5aVI3VU5xbkJ5Zkg5MmdaaEQ5SDJr?=
 =?utf-8?B?dldTLzR1NVN2THJIY05DN256ak0wYjd0YWdrR2dHZGlmcE1Dcm8xYnFsdTZk?=
 =?utf-8?B?bnR2TUN3YXhJRi9vdzRERVl0NmtndEdHMTZlK1c2MEZkU0tob0J5RlQxcXFR?=
 =?utf-8?B?czR6N3VDa3NRYXZkaDVrNzZscnBHVEs0NzJTLzBDNEVvNE9oc2dTb0FzS2p2?=
 =?utf-8?B?MHY0SmNyM3VZaGxrdmdlZmRyOFhnS0FvOWlKVld3VTNFUjZxTmJRejhQU1ls?=
 =?utf-8?B?V1ZsNVNudVVjR3U3K2RCazVGQ2RCU0Jqbkd3Tm9xVEVmKzZvMG9CbzdmVno3?=
 =?utf-8?B?VUVlTms1ZXZmTWFHMDJiZEtQUnhrY0JmWUxuMGY2bUtXVE84endzbk1WaFVj?=
 =?utf-8?B?c1IveTlZT3FXbnFWQkxqUDFSdFJWZEJHaEp4dTRvd1J1V2NTaXI1MVJIUUta?=
 =?utf-8?B?TU1vanJLanVka1NPeHNPVG9ldjZIREFYMXBjemV5bXBJdks5alJReDJRdVZN?=
 =?utf-8?B?Q285Ujljb2xVWHNoNUt4dVZSRUxNWnlLRnFuU3NMMFplZFkxRUVEUzBBR0lI?=
 =?utf-8?B?b09vcjY5MlBSVTlqZFlFSktta0ZPaklkemoxUGJnNVAvSmY1MEg2b1pJUkZh?=
 =?utf-8?B?eGhOTkxiQWRGZjhpbjVDVXZ5WmlMTG5UdElTTW1CYmg5OGdDaFk4N1F4ODhh?=
 =?utf-8?B?QnR0dWhtU1ZDQWFZaWlRYmZlVEVDWjJzdkNuaWI5NXlNa3hFODV0dTFaOTJE?=
 =?utf-8?B?Z0xacjU0QWVxMitUYlVZZVM5d1o2eVI2ZVN1eWh6b1IrTGh4bkphTENqUStt?=
 =?utf-8?B?ZHN4WDR1M0RuZmZsNlo2WUw3VzdpVGlFejdBYzdyaXlUR2dmbVZsNE01ZUpP?=
 =?utf-8?B?cU42dVlWQmVnNlVmemVkbSt4eGljcm9lTE5ZQmdGbWUyTndRclRlZFlBVEQ4?=
 =?utf-8?B?ODhqbXhVMFhxWUVLTmZBRGN4aDZSWVMxSTRLV3RjeVpnNGFYMGFTOHJUTFho?=
 =?utf-8?B?OFVqZitEYWpFYzI1amp2UFJyNlM4RENTOTNDY2VtaERQeWdvZkRhNU0wek45?=
 =?utf-8?B?Vlg4eFBvSjVPR0pobkFNYWk1S2RRT2NaM3J6K0JQdG9NZW1vRkNNOXJFODJl?=
 =?utf-8?B?b2JVYmxZOEVUcThib2xOTlRzeEZWWWk2RUtRMW1MWXVQbzl5d1FpbStwTnRL?=
 =?utf-8?B?VnRLZjRNckdsdk14d2Z4bXBndXVkTHpTMUZqdjBZYnNuejk3UmtsWHlLV3J2?=
 =?utf-8?B?SUlWRjBHd3hoSlZQNEEzZU9ZcXBjaWRtejJGSkVyWGt3aE4yelJ5d3FTd2hr?=
 =?utf-8?B?WlJFQnI3aktQUFo0LzNWbTVGM1lQS3Q2N2ZKY1JiMjMxN05ic0Y2QW9aQUZS?=
 =?utf-8?B?a2pwY01ndi9FSmI0bWhSUUdKTTNGOTlWMnBSTU4rdUZQU1k0MWh4YUVYeGs3?=
 =?utf-8?B?TVQyYWk1UUozS2VVaGlqcDJxUjM4ZU5qV3hJQks0bTRYWnZzTkg1R1V4U0Rx?=
 =?utf-8?B?UDVTeWZrUUFNZ2pNYWpTNzNvV0k4ZEQ3b2xvSkRWVy9aRU1YTkhnTHZ1ZUt0?=
 =?utf-8?B?Z0JXcmpOWXlyaUpwNzFyWEcybGFETEJQUUN4bmhSbHBUck1JbFV0TExrcFFF?=
 =?utf-8?B?Z085bUFEdGVoVGViRENKMVVPRkp6OWhhUzVkaHMzUHluOS9RTHI1ekE1bkFE?=
 =?utf-8?B?cXBpT016K3FRMEQwN2Q2bjF4dmtuS1U5cmd1bnBQaXJYaDUxQ05pOWRvTVls?=
 =?utf-8?B?WUZER054Ny9PTmUzNW9JV0tyR0w4S2o4UkhKZnorR3ZPT1o3Smdjbms0SmdX?=
 =?utf-8?B?NW9SRG0vd3prbU9KbkpWUXYxamRzalArNWozY2cxWWlYcFR0OU9ZK2dnYSt4?=
 =?utf-8?B?WVdheGZVSmtEam54Y0RMaUQxcGpGeHFJVEkxMkVGcVdVMG80WHJ4VmR0UTcy?=
 =?utf-8?B?VGhBazN6N040Q253UDMwVElpeUJYdGtEWUkzYS9wR1ZNSUUwWlhPOWpuZFN5?=
 =?utf-8?B?YVNHYjZKYktqNkNXYjhrZFRWYlZ0YTd2VEV4NHE3YUNWekZ1bFlOd3NzQmV2?=
 =?utf-8?B?a0FUT1RLQkZJamIyZHVLU0RBeDVmMTMydkZUQWFudVg3SU5yVUtRcVEzS2Ir?=
 =?utf-8?B?b2c4dHVqVjc2eXpZZlZGaTdIZDQxclhtN25TSW0xeTBXZjRLNngxejRiWi9m?=
 =?utf-8?B?bUpJMFUwVm5tTW5CMnpwbytUblFIRGp1WWlwVzFuQnRpdC9Ua2c4NS95eWhS?=
 =?utf-8?B?ZzBzRmF6T0tFZTVlOTJ6eCtFMENDSUdiTi9wR3BqbXFzVEtHRFRRb3FjR0l2?=
 =?utf-8?B?MzQ4cUk4Tm93ZllwRkNwUkRtc3FNb21DWFZJdEJZaE5sM1hpK0RKZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 711d6d74-0005-4611-1605-08deb67db6be
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 14:40:18.7801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7wEra9r7Ups8pgf8+WFDoMpPvsXWD/9F7r+IGLp6fjrztTES1aEys0WMbgyVl0mV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFFC4F04B28
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



On 5/18/26 16:05, Maarten Brock wrote:
> Hello Michal,
> 
>> From: Michal Simek <michal.simek@amd.com>
>> On 5/18/26 15:40, Maarten Brock wrote:
>>>
>>> How about something like this?
>>>
>>> int reset_reset_bulk(struct reset_ctl_bulk *bulk, ulong delay_us)
>>> {
>>> 	int i, ret, soft = 0;
>>>
>>> 	for (i = 0; i < bulk->count; i++) {
>>> 		struct reset_ops *ops = reset_dev_ops(bulk->resets[i].dev);
>>>
>>> 		if (ops->rst_reset) {
>>> 			ret = ops->rst_reset(&bulk->resets[i], delay_us);
>>> 		} else {
>>> 			ret = reset_assert(&bulk->resets[i]);
>>> 			soft++;
>>
>> But this will have weird behavior when you have multiple reset controllers where
>> one has rst_reset implemented and another not. Then on that one with rst_reset
>> another deassert is going to be called.
> 
>>          for (i = 0; i < bulk->count; i++) {
>>                  struct reset_ops *ops = reset_dev_ops(bulk->resets[i].dev);
>>
>>                  if (!ops->rst_reset) {
> 
> Did you miss the ( ! ops->rst_reset ) here? It will not call deassert for the rst_reset cases.

ah.


> 
>>                          ret = reset_deassert(&bulk->resets[i]);
>>                          if (ret < 0)
>>                                  return ret;
>>                  }
>>          }
> 
> I do agree that timing might become sketchy. But I don't see a one-size-fits-all solution.

TBH I think it is too complicated and we don't have any evidence that Linux 
implementation is wrong. I think that make sense to use what Linux has and if 
there is any problem we can change this sequence.

Thanks,
Michal
