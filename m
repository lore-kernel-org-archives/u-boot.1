Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66EB9C3DA7F
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 10:05:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B95EE881A1;
	Mon,  5 Aug 2024 12:05:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="iPZ1p7i2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B817C88286; Mon,  5 Aug 2024 12:05:20 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0B5C87C38
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 12:05:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ca+CYLW5TkKslDq5he1QCgd5r6uxu25T47r8rQ2mKDpYPRr8zG79GA6kx5TTWVilBPs1/VdRai9zA1fribx6oyBwIqz+H+1zIZQFf/C7P8pw/RAq3/cVmj6m+B2sOWS0biWH0w/XJ4BtLFdlFq3LYHnSjwwdF2/5jQNvdhfsaARMhSFKB4KBWbDH++nRlNts16Op3lrtz8b92ErRvO3TAfiN2WFWLvkZGYQJ5J1BvfBpWksAXwjTbBoc4S7xH2ToDWi8vI7f56tZgu6I/cXjETYyZuYjdo3Jq99itKpH/QWhvmY/Xym0wZhRwaybaD2ng2WJsGyHZbJzhbAK/jqMUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpQp/pIpfptN5eeWWQy8u/knRDhO4i0fUXwdxsZJiGc=;
 b=K2uoCtsuyurEuEl0VGAkrGkHuDD0+6nBbXpAyjKnZJYhj9Jp+WU2vGTcS3H634GV/C1StRxZkqbrNEBdYuvUCPSY6hRBlOvB+VzOnDCgwBMUyYD/BoRgsT+kRBX4KiO2qVKdRlrPA+lpM9vNDGOtGY7+URQWk7wf8jY7DluMhAKPM65+7GfE4JtGRff9yPxi0dlb4G+W2J2+WlkK3ulc9yUTvQwNnnCcjLi15cOl0tOdvqwHpoQoS12HN1BzzAVTLJXUsujSRp0T0mBRRoBHAI3Sn7ChcwDSNJ1OmG5OfJIIIpj3OVQED/lGmjlKXx5+dhUsWvK7VC1OHkPv7hYklQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpQp/pIpfptN5eeWWQy8u/knRDhO4i0fUXwdxsZJiGc=;
 b=iPZ1p7i2XRIbKHf9vtNeracIU/BXiDiSYMjg+goPD1ER3hFQ9z7XJjWuneqF/4l8QETqbekaJK559lAvS/osyg5L0KIE/S6V80LFyY4qoSNO2ueTuAfepuu8GKOeFL7QIRCuyjVxNiQoXfSbcyu27nTQ9U4YhkRywcEIQc6cuBg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM0PR04MB7043.eurprd04.prod.outlook.com (2603:10a6:208:19b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 10:05:16 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7784.020; Mon, 5 Aug 2024
 10:05:16 +0000
Message-ID: <5131e98c-3a6a-49da-ab03-2e61038f9de7@cherry.de>
Date: Mon, 5 Aug 2024 12:05:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: ns16550: Try get serial clock rate from DT before
 CLK
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240804150955.3521296-1-jonas@kwiboo.se>
 <b96a6544-05a9-46a0-8be0-379835a9c175@cherry.de>
 <5e9cd0ac-bc0b-4c82-aa3e-93339d43b1f1@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <5e9cd0ac-bc0b-4c82-aa3e-93339d43b1f1@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE0P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:a::13) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM0PR04MB7043:EE_
X-MS-Office365-Filtering-Correlation-Id: 188812a9-a00d-4089-1a2f-08dcb5361aa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RDMzSWtKUXNJSkRnd3lmZ3IzMUNLc2hvMEEwOXZKU2RYSjRlUE9UMDN2ZEFM?=
 =?utf-8?B?bzNvRExJd3ZEQTFxTEhvRWVYTGF0N2VnRkRRZFRtSHljMUxWaHdheXprK09j?=
 =?utf-8?B?YmVTbkdMTWxzYjE1KzlzYStvRjY1akQ0L0Y3ejdvY3pUSDV1d2tGaktXam1t?=
 =?utf-8?B?WW9MNmk2U0V0RGhSekxWRm5iNk1GU0wyNnQxRGw4dHdCN2Jmc29aMjlwWlJq?=
 =?utf-8?B?aE9naDh2c2hzcXZKOWZEZHc4MjBXQlBLMC92cWphMCtJOTJiZ1pkUTNMaTMv?=
 =?utf-8?B?blRTRGdncEdDSkJaUjNQWEFVT253WE5rWXhYcUs0eStFM0w5UnZSVjJkZjlC?=
 =?utf-8?B?TFV5WnVlNDBjLzRKUmpJcnRHZksrd0NJNkNTSW1mT3VmUERwUG5NWHZOUGYy?=
 =?utf-8?B?T0R1RU4wLzhSb1JKQkxTQlZMS3NFT0R3dGZTTWV6TXF5bkFST3c3MDUzL2Ni?=
 =?utf-8?B?cmRRMlkxMlJiZG5iSWJLTk9DWVR1VU8vTm53ZWNIVXZ5MjhKelJBRGpzV0wz?=
 =?utf-8?B?aVhKNDFYLzN4RlN6d1RCZUVUcER0NGRqdkU3SFRndlRobW92MXRjZUM4R0ph?=
 =?utf-8?B?ZmFWczdwUWJNOFhTbE02bVdNUnZ0NW14MmtFWVJWRC9zWlVBeFNzUm1HTHp4?=
 =?utf-8?B?czRFSXZBK2huWWJMaGdvaktoR25RbzhrVk1sT25ESkVIUnZsNisxK3JUc3Fi?=
 =?utf-8?B?c3JMdW9RNjlTaDVsVVBSTlYzS1hjR2cwMllkcjAyWUxBTDM4RVFSZWZLTlVZ?=
 =?utf-8?B?R0RFWlpLeitqendqZ2JKMlBsRStHVENXSEJLMVE0WDVUY3ZGaHNRUm9RQmJn?=
 =?utf-8?B?ZjczWDluWm1BU0VnVDhsaEprSDlNRVVGTlFoQ3lVZmxNOGttNlI1OC9WQldV?=
 =?utf-8?B?MWNCNkVPOGJaNjYwQ1VPbkVPRXRvVnVDcVp0Zkc4SGdrK3VhZ2dPbmN0K3lE?=
 =?utf-8?B?aFN1YlhvMmNWMGhTK2xqT3h3YTN0ekczejEvay9qQThLNHVzOTRySGR2dk8v?=
 =?utf-8?B?dm53L04zVUtpZCtLWG50Nkcwck5VeGJ1OEJSQUs2T0d1TXhmWTdXNktiOE9D?=
 =?utf-8?B?NjNoMkZhaldKUFkwb3J5cnZReTR2dXkxczZwTnBxdGNzN1FZL1NPMllPM0dJ?=
 =?utf-8?B?TFl4M1I3MEZIRUE2VkI3QjU1eUl2QkF0dERTYThKR21qNDN2ZWtVV0Rad2gy?=
 =?utf-8?B?eHE2NFlWRXpIQ1lCY29mUXE2Z0cyRTV4MzZkZTVZMzRkL3MxNzZDcUdSQVV1?=
 =?utf-8?B?VkdtQ0xTcjl4U0dLckRmMnA4aXQ1bm5PRWJJbHZkY3BLaFdIOW5LU2Y5OEZl?=
 =?utf-8?B?dUxDSTV5V3FlREVDYU84Ky9iWjFBYzVYclE1dDkrdkhQL3JkNjIrQTVnRG9V?=
 =?utf-8?B?aEVTanhBVis1MVRVVEtYYXQ4Qnlwa1Z0R24xWjVTSXdhZ1VtRS9iRnNPSmJK?=
 =?utf-8?B?czRienNIelkrTHpxYVNmWXI0aXV0cHV0d295Y0lKZXRubTY5UUhtajh5b2ZD?=
 =?utf-8?B?Ri9YVUplWWxaNFpSaVZoYlRnYmh6UFUwZ0dFMEtQQmZoMkZJZE5hUk0yTmtZ?=
 =?utf-8?B?Z05NdkVvVmdqc3phNWw4SUo3TmhaTmxLaXNoa0hrVDBrNmNhTldzRDdmOEhs?=
 =?utf-8?B?eVZNcW5NeUFGUGpEa2J5OE90eTk0REZGTmdlK3VLcmlldE15bXRMR2tDK1Y4?=
 =?utf-8?B?cEVidS90N0xXZms1WVg2QU5IMFQ3eHhVaXd4WVV4Vm5MQTNRdmVmT0FZT0pk?=
 =?utf-8?B?cmFJRWFuT0RtNHpqbjM3akc3SHRnS3ZnbWRJV0dWaEJhMGxEVWtma2VKazRo?=
 =?utf-8?B?dVJ0VGJkMDE2a1lQWGpTQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTJkelBrcEZjOFphQjF1MUN6L29UdndKKzhZaXNHelF1eldIeGxQb1VUdzR0?=
 =?utf-8?B?cStERk10L3VPZWM2a2QzY2gxY0hpS2pUSHNDS0IvM1Bvb050RnB2ZEx2ZWlG?=
 =?utf-8?B?aHdNbVRWUDBjMldTN25pTkw5L2x0RkZXZ25WdXlwRk5UbG5FaHRlRDlJZmw5?=
 =?utf-8?B?M1Y4TW5nSlFUYjYxNkkyWHBwaytkOHpVWDFmR0dFTWwvY1ZmNE00WE52eGE4?=
 =?utf-8?B?Zm5hSVhkdWo2ZGp1d2pkYS8vWHdsd2E5T01mM05vdmtPRkZGM2N4TzR2bXRr?=
 =?utf-8?B?bHVGUStrTStqZkpzOFo1QkhiM1hzdEttV3pVd1BCWE5HWTBLeUpwNE40S1F1?=
 =?utf-8?B?QUE4SWdEWmNETVFyNHZVMnJ2NFd0NEFtM09CdE11NW1GU1dZQVB5SitNYkVo?=
 =?utf-8?B?cDdMbjNsOGx3d3NiT2I1UGhEVWZvNUtPVGZuSlBVWG1HRURnRjFvUDBudE1B?=
 =?utf-8?B?Wis0SDY3Y2RzSmFrTHA4aE0zVHF3blFuOTRoKzczcWJ6akI0RlpWdHMwQWUz?=
 =?utf-8?B?SkpFN1gzd29JZ1J5bG5DNGJKU2xuRDFZdGxta2c3TTZ5ZVE0Z2xzZHFlUnB3?=
 =?utf-8?B?WlJHUUxNbE9UUVNaaFJKbmo2ajMwTlJ6Q3JoTExPaW9WVUxLZnRTdG1uVGUx?=
 =?utf-8?B?endiU1NKZytmdTlrTnZMck56WTBaOG1MakxyVVh4NHB6RUo0ZitGOGhiR01x?=
 =?utf-8?B?Slh2amtLYkdHWGZXaVJaa2taMDEvTUFkQW5xcGErenQ4OU9TdW8vdUpiNTFT?=
 =?utf-8?B?cndPN3FSMUJqK1dRZ2t6Y0pjQnpVTThvVHNwa2dHLzVDQkFYV1lVb2ZHTUpU?=
 =?utf-8?B?S1BIQmFqSlNLbGk3M21QQjlRVUVsNnpvcTlXZ2d3QTBuT0ZxN1hHN3pjUVhi?=
 =?utf-8?B?c1B5bVdBWnc2SFdieFk3aW5CRTU1dGxUeXBqVFEraDNLT3o5TmVmcDQxaVds?=
 =?utf-8?B?c0lvcm9rUnltdlYxa3ZQRmh0QWxCOUxjMTVuZ0VTSEdscm1EQ2QxYTNXY2Y1?=
 =?utf-8?B?cWNMZ21uR1FRTm5hQzRzbDg2enR1V3dlUFd2ZVoxZHBheWNZVUlYTjRqajRt?=
 =?utf-8?B?MzBrOURISjdENXpPdEdRSEdEOVZhY1o2Ky93aElLZjhLMnY0LzRTYjlpR1Qz?=
 =?utf-8?B?RGs4MEg2NW9GT3RZVTBTdHZjbWFxUFFrRzM4bnpOMllxV2NuK3dabHhWaXVI?=
 =?utf-8?B?d2ZTa1N3aXV1eVo4eWVKNy9mMUs1Sm4zQ09FV0NZeWx2L3J2UktSeWFoSG9W?=
 =?utf-8?B?bjQ2V2l3NVVhWlJFWTFPaVFXUmdSalMvQmF3Mlc5cWkzWkJmMlY4N1E3bHFQ?=
 =?utf-8?B?OGhkVWdmQmd3Q3F4ZS9halBOOHorODlLR0VpVmV4bHNXRVJqVXpvSDUwOFFi?=
 =?utf-8?B?elFWR2p6RHRaUHVLMjJwK1lBdTlrY0pXLy9Bc1BOSFp6QXVSTkh4Yk9NTUxy?=
 =?utf-8?B?SlFLeFRueU5YRFJLUkVVZTBXTlNjWDJWSHRvbHE2VDZnckNiWE1QSHRnWGNp?=
 =?utf-8?B?bDc1ckJGcnRlNzhueVU1dlBHbkhKN1ZNaXNXMGlKZmRrc2FxcTNPVUhxNFdU?=
 =?utf-8?B?UHUyT2tYck5CZi9DV2ZBK0FPa3dDYThFQllleEVzaU1GSVhBWVpVc09XdFVW?=
 =?utf-8?B?QXlIMlVNK29rWE01RVMyQjYyQ1ppVGM2U05ZbnRFdDNROTg1T1F1VktzNFVF?=
 =?utf-8?B?VHp6SVZWVDFia3VVNkxoYjhuWGMzSzZXeGpSWEQxbEhiaWdqekl4ZTF6UWJ6?=
 =?utf-8?B?bk1PdjJHcGF0OCtPR2FDRW0vTXdQckpCSUZGWjByQ04zMS9aWnByQzNjZVVP?=
 =?utf-8?B?eGFzeWJIU1o0aGp1bitZaWZYT09KWU1ReENmdzhidW5RU0hPaGUwWlhFN1FX?=
 =?utf-8?B?V3hhcXhYNVJaNTUzRFFQK0lkZHJ3emFvSXgwRWxSQndPQ0hOdFYrQXRtbklQ?=
 =?utf-8?B?Mjl0NDlTNlljVXVZOUptaGlhVzdmVS9JdithbkRLeUVmaW5HNTZDUEIvNHNT?=
 =?utf-8?B?RG10NVhwSC9qZFgzRVI1TC8xSTBvL21SaDZRbmg3QVM3em1rcCtLQnJ1RVVR?=
 =?utf-8?B?b2dyMWhHSTJVMzMyZGdHcmkyUzhZZWMrYVk3eGQ2UHhFampmWTBsL0g2Nk9s?=
 =?utf-8?B?Um9nZDdYbEdlTVE5cmZuRnBuWktCNWZsaXBnSXJMVlZDTytHZUNEVVRNTG1x?=
 =?utf-8?Q?KTouZIb6mvArfa3li9jeEU8=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 188812a9-a00d-4089-1a2f-08dcb5361aa5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 10:05:16.2995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AXTLCrBwvkfU/VaR/gxxiquNlXAxj74tCKMwltUe5NoIcm5ekm/10/7v6wLYLZN0pIcDICJfGNf7I92woPSWlJh3EvBTCFmuR8ywkqWiGps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7043
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

Hi Jonas,

On 8/5/24 11:02 AM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 2024-08-05 09:19, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 8/4/24 5:09 PM, Jonas Karlman wrote:
>>> Initializing a clock driver to read a known static clock rate can take
>>> some time at U-Boot proper pre-reloc phase.
>>>
>>> Change to first try and read clock rate from DT to speed up boot time,
>>> fall back to getting the clock rate from clock driver.
>>>
>>> This help reduce boot time by around:
>>> - ~35ms on a Radxa ROCK Pi 4 (RK3399)
>>> - ~15ms on a Radxa ZERO 3W (RK3566)
>>> Time that is wasted getting a static rate known at compile time.
>>>
>>
>> I guess this also makes some board perform worse as well, the ones
>> without a clock-frequency set?
> 
> I do not expect that this change will add anything to existing boot
> time, however in some circumstances it may reduce the boot time.
> 
> Before this change the rate was retrieved using first successful of:
> 
> 1. clk_get_rate()
> 2. clock-frequency prop from DT
> 3. CFG_SYS_NS16550_CLK
> 
> This patch swap 1. and 2. so driver first will try to use any rate that
> may have been defined in DT, thus possible skip a probe of the clock.
> 
> Boot time is only saved/reduced if the serial driver was the only device
> that needed something from clock device in current phase.
> 
> As long as the DT contain correct rate in clock-frequency prop or no
> such prop this patch is not expected to change anything.
> 

Well yes, that's what I meant. If there's a board without DT or without 
clock-frequency in the DT, then this board's boot would be slowed down.

The ns16550 being used for many many different SoCs, I don't think we 
can necessarily assume everyone is using DM.

All of this is merely me highlighting this fact, not arguing whether 
this patch should be merged or not :)

Cheers,
Quentin
