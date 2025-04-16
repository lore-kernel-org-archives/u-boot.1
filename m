Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58ACC369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 14:26:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1858282E3F;
	Wed, 16 Apr 2025 16:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="b90qrTZW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CC0482F2B; Wed, 16 Apr 2025 16:26:10 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::631])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0D8182C49
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 16:26:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mh3DrjHY7WL21CsNBK+ERdXwp+MmpiAKPU0my1mqEpPM2tNkYdLz5lEPAMnkEX/B9PnAhFZWQ3DrMb3gdDZtMwN3e4eqQYAhoSaIVekpNnXD3151aVdwmuwTv1VCr7KD4PCmHH7cBPqW7kKTZHqfHKGWyrrDFGE1ziPfkL/CrbbBTJr/7L5tCTLLAl+CPkXiA2Z4hwxvRBO4qjM+B6FSYge19xOLnleiAeQSJXcdQN85Gbj9Euum78g/ou0EhBqxS+sKNlra0JkTlHN1U2XMmkdsHz920ILVVbbOhsAF5fqIseFeUEX9wyvUD0n2wVFmPPwd2ZbNUagYBTjpcb3K1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJKYEfzvYO93fEfklQKtLgcoVvLbRTkYM7LHAIB0QJo=;
 b=brywa3IwTNP31WnXNDxFEf+2tN3/6zONFzkmyqzvbYWl7PJpcAN2GUunSttvQuRzEFH6o6rp2TuMzS9CJpndgq9Gt7xWej1M/YvIg+6YtX9YkgOnbuiAhCp6TnoFarlFaxaZm67r7xNj6HZthKeRSi1Ph7mddxHNZRgB0HbQCULO1ct9VyG0dhM70n+WoDE1xBzpOGoi+QrZcfjYamj6GqQPlgvKJTdEhMkifjGiEXQE3rvju5yOOcLAA6Z5awZwchJq1ktGg8EnD0zWVMxfXELo/9MFxuTgvFl/cyG8TvRK/IPmJVR9QZZL6K1MG542SgDVcEbVTGBuB1If6JGVgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJKYEfzvYO93fEfklQKtLgcoVvLbRTkYM7LHAIB0QJo=;
 b=b90qrTZWQQwhPmFqVtiXrT726egHlkFBXrAW9Ius/fIhj/YKnwbvnLyjeDIr8rj6feYSs19aT81GaQqN54mQWWUobJBv2xioVA9f/u/Z3dZbTMS8BRW3I1OaFmDNGG4fCI5iJRSmrGohGkuNH5H6QdOo+Qj1yYRAjda3a3BfI9c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB8513.eurprd04.prod.outlook.com (2603:10a6:20b:340::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Wed, 16 Apr
 2025 14:26:05 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 14:26:05 +0000
Message-ID: <b9421f29-1b84-478b-8237-782b3fd0bbb2@cherry.de>
Date: Wed, 16 Apr 2025 16:26:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tools/make_pip: Use venv when invoking pip
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
References: <20250416-ubuntu-24-04-v2-1-bad2be600857@kernel.org>
 <7278a03f-57d3-4e50-9c84-8b329c2032e8@cherry.de> <87cydc4264.fsf@kernel.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <87cydc4264.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::8) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: 7633f471-d8b0-419d-4eb0-08dd7cf29efc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFZEUWRmYWlhOEpFNTlDeW8rSG9ub1FPcUpFNGRKT1NhWVd5MGJsMWNCdmoz?=
 =?utf-8?B?UDNtZ0N4dFFGNTNyYUEyaU9sSUxUTjFVTERCVXdiYVF6azQ0Ukg3U3gybFNh?=
 =?utf-8?B?Y1dZVTVXZHFoWGE1bjIvcTlmRUhLbWMxaGYwR3FaVEVWc2FnZDg1RGtSS09N?=
 =?utf-8?B?UlhIVjBUVlpZTjUvZ05nQzRGRjgweU9jL1NSU2R0VjBvVDBlNUl3eGtVQ092?=
 =?utf-8?B?MEdtTDBIbW8yN01xb1hLa01YV1FhR2dGWWFCbDBtVmwzVkY5WWNjZmRBdUZj?=
 =?utf-8?B?NisvTGxGWC9ySmZ5bENOWGhKQVp4WVpMbUEyWHZpMGJzUStPMjRQMWRZZGtT?=
 =?utf-8?B?T2Z4bjVRUXJTUGgxWjhHTVBxNzNXN3BmamtoaG9aOW1JZE9FRlNzTnk4MTEz?=
 =?utf-8?B?VTRPZW5DZGlyQ1k2cVJkSkpVMXhIUG5OaURuSW9yMWgxemprZ3d3Q3JSR0Fo?=
 =?utf-8?B?VlB6ZG5MdmEvZTRoRUR1RjhSUVVidjRiYVdTbEIxZW45akRZelNjVEcyTHJ2?=
 =?utf-8?B?QWJGUW9ieWtjVHdhU1F5c2JGUHRLMTJQWjUybTVRK1lBNWVtbDNvL3RLWTAy?=
 =?utf-8?B?emtNcStBS2pnb1BNTWMwV1JTY0tZWWZTVHhYL3dhNDRxNHZFdjRUWHl6RDc5?=
 =?utf-8?B?NEp3TTBySWpvbGdGVHhDSndmazNqT1AzNDgzODI5bitrb1BsZzFEc3RBV1FO?=
 =?utf-8?B?RlpCcDZFZmozdkFFc3dYaWxqVkVnNGhySzhkY3lUQXhJRFJOMDByN2FHdmNz?=
 =?utf-8?B?QVFFMnhBaFRPZmpnUVJsOWNuN2FiTVlYcU4yNTZVdUNLSS9jMXVTYnNCMXRi?=
 =?utf-8?B?QUdnVExNcVBaVjNaWFFWaXVxdks1VkNaQ3FPRzk3U1c5dTNKemNQWjYzMDhP?=
 =?utf-8?B?YW1EdU9yQ0J5Q0pTbVFPSFJjekZRQnlad2FkelJoREIzWHMvYTk2bm0zWHJG?=
 =?utf-8?B?K0hVOS90VlhHSFZGWFZBN0g4TlBJVXlRM0JJTjMxeEYvdjJ2UXRabUtHdWNC?=
 =?utf-8?B?R29ibk05ZGlCVEZIRFJOaHRTb3lTUWxUUjY1Y1J6emZmZFJPaXd6eGV3QjlF?=
 =?utf-8?B?VlgwODNhZFJoZzA4NENTaUhndFFUZnpHaHF6M0tZaTlxZElzMVF5U29hcm1I?=
 =?utf-8?B?WDYxYXJiQ01LSEhiWUd0UHM4Vk82NzJTUjFVQUNKdE1BcEhMSkcvY09VUzRs?=
 =?utf-8?B?M01keXp6N0t2V0FTejZKZm9qMnpyQytzQ3V3ckdqelUwTHRvemM3MUk3UkRr?=
 =?utf-8?B?OTJkQ05VNXZuTTc2Y1M4NkVYTUpzT0pST0l1TndXWmdUSFk3c3prdC9iRkxH?=
 =?utf-8?B?WWxUSnZ6bFY1SFp6WE96SU16MGl4dC9wOGFOZGlVK2h6Z3h6T3p3eSt1SHpS?=
 =?utf-8?B?allMZndXaDFJS2IrZUw3UENzRWRxYlpza3h2bFdFeTVyeGk5aXVxVThkcEdK?=
 =?utf-8?B?VXh5TWRwZjlxbTk3VDFvWmNTZHVKQW9nSi9NRkVnYXR6S2lRQlpzYnNBRlo3?=
 =?utf-8?B?U2tZMmJtY3dHVldoWWxTZVRqTUYyTGZyZHIrTkdxRTNwYzVvaTdtSS9rd2ov?=
 =?utf-8?B?dWVQNURIdUZDeHRKeDNMSlpKbEhraWhRRmUybUtDV2I5ejBiT0hZUnF4VFJu?=
 =?utf-8?B?a3hLUEkyTk9FUTdUNTZIRVU5M2dRZ2hxOWtxWktrOFFpOWsrWDZDNUZ5OXRa?=
 =?utf-8?B?MUNBWkRyTTRoNmV3UUI1bXFraHdiZFd5Q1RIaktLR2VhNHNzYkNTSFpTTzNS?=
 =?utf-8?B?OW9LSURFMGZWdTZDeDJaZXc0Ri90VGdvZlVqZDdiODREbFVGSGxscXUrUGo3?=
 =?utf-8?Q?z/WqN/Czjmf3SvUO7ItPqlhFbkv7M6Kr3x+vg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wk42VkdVdndJc0Jna24rSXBPMXRYZnpkbzNHYWNERXN6ekMzeXdoSG1wZHZw?=
 =?utf-8?B?b0tsWXJwNUV6bnZ2OUl1S01uQ3RxaXNTb2NBZnRCa1JqZDFmdm40ZldlVHdX?=
 =?utf-8?B?azdPWlo2eVQ2TFdxSHZrQmpGbXhtb1ozUDQ4emJNVnBOeHJTQjhwK1Y0cTFq?=
 =?utf-8?B?YklMRUhGTk90UnozazdyNnFwUEZobXUyZmFHZnpZRG1sTXBtWGIzbkt3Z20z?=
 =?utf-8?B?aHlGdlJyYmlrY09HRnp6SWh3TEl1dFBwMGxzaUVoTXVEcUVCNGczWHM2S3F4?=
 =?utf-8?B?cGFGdW5DcmJxS0tzbnIvM1lmR2xwdmJsVml1MVlJSU5LMHpmQ2RseUJBVEla?=
 =?utf-8?B?Zmk2SGZYYjkxK0p5dDlnaTFMVERuVU4xOVBraE50c0p3TittMElpWGVPM1lG?=
 =?utf-8?B?T3ZOMGZmYjYvQlpCSXQ0eGRrU29FdUZqRHlvaG5JWU0wc1AzL2UvbCtCekls?=
 =?utf-8?B?d2wrMEFIREVDcG0zb0hjRUFqWnE1OHkxNDBKSjZHUWhUdGRzeXVvMHJpZmFi?=
 =?utf-8?B?VjJXZjF1QVczNlZESk1LVFNuaE5VdnpvVXpaNTcyK0dDSGtxY1crZE5LTk5z?=
 =?utf-8?B?MlVXOWVsM1duTm1zQk1sVlJ6VGRKMVNvSkk4Mk82MXV6RHh0NUtxSzUybU9v?=
 =?utf-8?B?c29yRjd4V1UyTFNLUnloNTY1ZlkvT293NTVHeTY5Ym9EektQR21SQUpQbmwx?=
 =?utf-8?B?eXFkZHAyQ1FaUURuNWsrM2QwZ0E5N3RseHBUZW4yelgyU0xHUTB6WWJNQzU3?=
 =?utf-8?B?UlR1SE0wYlpDZGhjdmxWSkROZGpzNWk4b2h0S016UnNsOWRXcFp1WFl2L0xv?=
 =?utf-8?B?Y1pOL1FaYTdDQ3RNODVPV0lrblNJc2lYalF2SG5kczV2cUlZLyszS05mdnc3?=
 =?utf-8?B?ZXpsR24wTTlPTnVQTmRUZDZVaVc3aG5rcm04cC9MZFh5S3cyaXpUTVpGVDBL?=
 =?utf-8?B?aDEzRUowbFpjQ0p6cGY1ME4rZG8rNTR6ck1lRWdyeXZrVHlQOUxOV0xzdTlC?=
 =?utf-8?B?TkU4WGY3ckJLWXovSmpDK0JGaUZ6ZzFKaVdLK1FpeXdTNkMvd01uQmp0bDk5?=
 =?utf-8?B?eEEvaHdWMHU3amdmUHFBeXI0WC91N2hwNXhZaSt3NWxGczNnaTBNRDBubXR5?=
 =?utf-8?B?d3BHWFhnYlBCVkNMTWNSQS9aN21Kb2FMQ2g1N29uc1lMaDYvZWpCc2h6OUh1?=
 =?utf-8?B?V2pVeHQ3UlhQTkVkdFc5QTF3VWlOdGlSS0I0NzA4ejEwMmZzRVNkUXgzZVRY?=
 =?utf-8?B?QnRVSkVha0dzbG1uSkY5S2U3VkdRbzIzaG9iMmtOZWM5RlFSekxhaFlVQndP?=
 =?utf-8?B?RjVodDhrYzdtS21OZmhnYmZCYlV5K3RFYWlTblJGRS9abktNTXluLzJpUnZU?=
 =?utf-8?B?YXBpdnNNc0hBWDEzTllPYnVNUDloU3ByanJIV0VHNEtmc290czk3VjJ6S01y?=
 =?utf-8?B?VU1JSWNOVjJrSmFFMXNaSFQ0ZW56a293elh3VnhxNDd1dTBUVVEvUUFRNXRi?=
 =?utf-8?B?YXVwWUpEZFBGUTAxa1JuQlZKNjlkdmQxaGh2bzNuNVF6SnZWSlNiRUVyMzBO?=
 =?utf-8?B?SkFyK2xkOERNNDJhUXRQbzY2U3U2V1R3RlpnNFdBTDBWbHdYNjYrSTkraTk0?=
 =?utf-8?B?ck54ZjRsaWdsejhXd25LeWU0elcxcCtxNlI1YkVSSjFFaUYyZVFkaU5KdTBY?=
 =?utf-8?B?NkNqSlEybitGclBwMGpZRWxGekFqMU1jQ2JIVy9DditsK25mbHlaMzU4RmhU?=
 =?utf-8?B?Q3cxQlZkOVJEdlIwaFBhRENiNkNvNUg2UGpQMzh5bHN4VmpXVnU0bkNPTG92?=
 =?utf-8?B?Y3hBWURBT1RleUhDUGcrallYeCtxbG1DanNBaE00QWNTWEsxaUJ1STJRS3pT?=
 =?utf-8?B?RllmR1BvQkdEeGxGYlV1L3pUS2h0eFo3aGFJZ0Z5cmI3c2N5Q2hsMzRlek1H?=
 =?utf-8?B?ZkFMTnVOR2NlZjRZS3RETDJ2WllYK3RUWTVNbHc4WDBqaHNCb24vS3M1amVN?=
 =?utf-8?B?Ym5HblFvV2FVVVcreDlxNnEzVFJMMjd4UmdleWduekE2MFJnTEhUeFVpL1ky?=
 =?utf-8?B?ZHoxSkJXUmFqMTdVYU1JZDdjL2J5SnQ5Nkl6cks3YUxIQzVWY0cwVXVnc2Nh?=
 =?utf-8?B?SjJoWGRVWlNNTTN6ZWt5NmhUY3padTdXSUprOEM1RjNKbHh3K3pUY2dDb0Er?=
 =?utf-8?B?TFE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7633f471-d8b0-419d-4eb0-08dd7cf29efc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 14:26:04.9688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 16UrexiCzs6KKMjCPP7YAzAJHd2wDZGHCVs2SVm9FodiLUvJKagXEr3OPVHx74xGf0aBJ2JgJm5QFig1hLzq6Px9U/4629fJ3Gam3bYXVQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8513
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

Hi Mattijs,

On 4/16/25 4:21 PM, Mattijs Korpershoek wrote:
> Hi Quentin,
> 
> Thank you for the review.
> 
> On mer., avril 16, 2025 at 14:47, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> 
>> Hi Mattijs,
>>
>> On 4/16/25 2:36 PM, Mattijs Korpershoek wrote:
>>> Recent Ubuntu versions (24.04+) disallow pip by default when
>>> installing packages. The recommended approach is to use a virtual
>>> environment (venv) instead.
>>> Because of this, "make pip" is failing on such versions.
>>>
>>> To prepare CI container migration to Ubuntu 24.04, use a venv in the
>>> make_pip script.
>>>
>>> Note: This has been reported on [1]
>>>
>>> [1] https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/37
>>>
>>> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>>> ---
>>> This has been tested in docker on ubuntu:24.04 after running:
>>> $ apt install python3 python3-venv
>>>
>>> with:
>>> $ ./scripts/make_pip.sh u_boot_pylib "-n"
>>>
>>> And shows:
>>> Successfully built u_boot_pylib-0.0.6.tar.gz and u_boot_pylib-0.0.6-py3-none-any.whl
>>>
>>> Also tested with "$ make pip".
>>> ---
>>> Changes in v2:
>>> - Use venv instead of virtualenv (Tom)
>>> - Link to v1: https://lore.kernel.org/r/20250409-ubuntu-24-04-v1-1-056728207b6c@kernel.org
>>> ---
>>>    scripts/make_pip.sh | 6 ++++++
>>>    1 file changed, 6 insertions(+)
>>>
>>> diff --git a/scripts/make_pip.sh b/scripts/make_pip.sh
>>> index d2639ffd6e43..33ad51ada703 100755
>>> --- a/scripts/make_pip.sh
>>> +++ b/scripts/make_pip.sh
>>> @@ -106,6 +106,10 @@ fi
>>>    mkdir ${dir}/tests
>>>    cd ${dir}
>>>    
>>> +# Use virtual environment
>>> +python3 -m venv .venv
>>
>> Do we want to make sure there are no leftovers from previous runs? If
>> so, maybe add --clear here?
> 
> I've thought about this, and looking at the script itself it already
> suffers from those issues. For example, the $dir created with mktemp is
> also not removed.
> 
>>
>>> +source .venv/bin/activate
>>> +
>>>    # Make sure the tools are up to date
>>>    python3 -m pip install --upgrade build
>>>    python3 -m pip install --upgrade twine
>>> @@ -122,6 +126,8 @@ if [ -n "${upload}" ]; then
>>>    	echo "Completed upload of ${tool}"
>>>    fi
>>>    
>>> +# Finish using virtual environment
>>> +deactivate
>>
>> Maybe you want this in a trap so that if we exit early (which may happen
>> due to the script doing `set -e`), we're out of the venv?
>>
>> And I tested otherwise, with:
>>
>> #!/usr/bin/env bash
>> python3 -m venv .venv
>> source .venv/bin/activate
>>
>> and it seems that once I exit the script it's deactivated anyways?
> 
> Ah, interesting to know. I just added it to have a "symetric cleanup".
> 

Yup, absolutely makes sense.

>>
>> So, I guess no need for the trap or the deactivate, but we can play it
>> safe and still have it :)
> 
> I think using a trap makes sense, but this should also be done for the
> ${dir} directory.
> 

Indeed.

> I'd also argue that this would more be the candidate for another patch
> than to be part of this one.
> 

Fair enough. I believe the --clear addition to python3 -m venv .venv 
would still make sense though? What do you think?

Cheers,
Quentin
