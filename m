Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926D0C44507
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 10:59:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F4DF83946;
	Wed, 21 Jan 2026 11:59:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="FC8UAK4X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B89D83A6A; Wed, 21 Jan 2026 11:59:20 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F92E8341A
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 11:59:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6X5Wa67Z+QCxA82pvkPE1Qu0BD6+/2wdXcSNXVw7EqrRwafpGw+VOv53y20MwsOcTKNfjfx/D2k03BnryXoQRMfeGHsPCMHLFzhwqfPKTb7LniB/E6o2lmF7DAv4XQAV+HTnAojfIO/kjORuQfgrRBmTSu5iVQSA5GsiLnRtw9ffQmPqoxPhVuTgMOTK6921dDqVvQ2n8c18a+FBZ/ZO08MQUPmue8crECbRUBjO5m7/vy4Bv9t+J9b/KvxaQ4U8Am3ElDc5z2DEHHG9d7IqT1H6yXFV4itAobyRZr7UgnbhsaWEPSsau9h9FslGwh2TyGLgFKzc5sIpmcaV//y8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zj3V4eFywSc4hg24EBBM+Y20FAutZ2ZnfnsVp6I7d70=;
 b=XQzQG1r+LZPPSFBtVESJcrG/ljwlkaE6R8JAjcS+VepfENUU1LaoAwojxTR22nPkV5HSoIbhWjxtFIUt7B0Fm/gTTkxZxOz+z2vYWy8cSdyuRjyBrK6BaiCgUpAQoMmLSw5RvMxmXX4UytXSJE+svnrORiJozf8MtNEOXSK7nAgDuUXMHNP1tn7HiYWBWHalN6EIkQU6Ckt63g9vsLsYNkDtpwhQ8hAmz0x8EIV80DfT7jnU3RikfrJUZFwDzh1XYT4Kp/TZ7B6aT1GKIMKrRdsX9hUNbEVkoBXzLNm6u8DsmM8ecl5ceEBzOUMN72NVGNVauDhBDk9vAnHg5p/Pdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zj3V4eFywSc4hg24EBBM+Y20FAutZ2ZnfnsVp6I7d70=;
 b=FC8UAK4XxI9YGTDwDD6/rsWCiK3oHs01rvffcKUhW5pleZ50Nv6xfsbTOgWjKZP6LBFD9AtsoHpRT6U5EmQT/9mKOeu2PtkZND6C3zJ6bM+ItBA+k2DfTSbmITfbVc9KMWAqtdbgGQZ77qyIzZVmLhzbVxEdwXg2vVbSdTZI350=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by GVXPR04MB12127.eurprd04.prod.outlook.com (2603:10a6:150:313::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 10:59:16 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.011; Wed, 21 Jan 2026
 10:59:16 +0000
Message-ID: <b8797028-e150-469c-a317-1e00f7071449@cherry.de>
Date: Wed, 21 Jan 2026 11:59:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] doc: develop: sending_patches: Update link to
 patchwork
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260120223405.469050-1-trini@konsulko.com>
 <20260120223405.469050-5-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260120223405.469050-5-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0056.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::6) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|GVXPR04MB12127:EE_
X-MS-Office365-Filtering-Correlation-Id: 51ed8b8d-4524-406f-d0be-08de58dc1ed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|10070799003|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WE1EaE40SWRjNnhTWkw5VnZwclpQc3EzdFRQL2pGNHZ0YjJhMjkyUlQyWjVy?=
 =?utf-8?B?UFBieC92b1A5Q1cwbjV2Q2RpVzJqb1NDWHhIeTR6U0lvVjBPRFlwMFdJdU51?=
 =?utf-8?B?emtPV0lqakZrL1d6R0RaZGE3RXZ2cUo3WkQrUkw3b0ZqUzZCNmFCRHVRQU40?=
 =?utf-8?B?NHJVcTlTVjhFQUgwVTV5RTYreSs0UFdjTnpUK0txNm55d1RMZUdPcnRhdEZl?=
 =?utf-8?B?YUhYdmNxRDhZUTVoYk90dllDdnovQ3JiTHJybEZHQUhkc05lV082bjJEYTY3?=
 =?utf-8?B?MHdNWno4T2pLM0pQMm1WUStwSm5LdDZpTG9MSjBLSGYrMDhid25UbFBRTTFG?=
 =?utf-8?B?TzZFdUV6VXRVMzZBWFQ4L2Via09Ma2xQd3ZOdFFIYkQwYzNkZGFkd1BtMG9a?=
 =?utf-8?B?Y0VOZDRwR09qNldYWGQwT0xkQzdicUE3akozMTRMR1JNYWR0ekUrcXE3aURG?=
 =?utf-8?B?R2E1UEx5UFdvbzl5Y2F3cTlFNTkxbEYzLy9BNGFXTHVURHVJWW1WV0RtOVJC?=
 =?utf-8?B?OXB1bW1IM0FzOWJpVW1LNnFSc1JwSEkyWnhEbEdpc05oTkdFR3lEeWhpTzM5?=
 =?utf-8?B?RGkzUGZwb2o4WVhBaHdaMDRpQXFtSW8xVFpwWEN6NUlxejgxVDloeWs2NFhR?=
 =?utf-8?B?bWtZdVQxM2EyY1BpalVBRFVxdWZEZlpZZDByS24xc3VDcFNHOVluSDRGVS83?=
 =?utf-8?B?d0gvNnkvUnVGcTlodGFUWHZFTVV4UTNDQWhxWkwvTmRvT0JYTUROaTFPUE9U?=
 =?utf-8?B?SHJxTlNnUjZpVVlUdUxnaU9wY1ZhR2dRNXNQL2YySW1xZUl0T0J4UDY5N0xh?=
 =?utf-8?B?VzdhZzJSLzJ2ajd3cDVvY21UY3VDQktERVBnWWRqNGxPcTFqTDJjZTIxbFN3?=
 =?utf-8?B?WUtub1l1VlI3alhsb0MxOUZJMU1oYVFyYzQ4SXFiRFRaZXZUd2NRS01wd25O?=
 =?utf-8?B?S0c5WTJIc2ljSzRubkdjYmllTWVDM0JIQmRMMkNUajEvTCtvakdhaWZJQkt4?=
 =?utf-8?B?UWJlNHdGZnRicUFscDR2VDRNbkwxZVdkNi9ZSWpvOUFCejdnZ0dDMStLRE5R?=
 =?utf-8?B?bUpaOEpxNWhDcDJhYW1rYmJPaVVWVWU5YU0yd05RajlQeDZmZ1JkYy9NQk1Q?=
 =?utf-8?B?QkloTkZIbTRVSE1velFKdHI4d2l6K01tbUxEaUZZVWVWZE9MK3ZMUXVsaVg0?=
 =?utf-8?B?ejk2VzRYc0dHd3BJQlQ0SEliTGJqOG94V1pwUHhIc3lEQ1RzdDN2LzVXZFJi?=
 =?utf-8?B?MkhocnBmSjZmZW9zYnhHU1hxL2ZlOXRlOGU2NEY2Tmg2bjVxZzMrV3FPRmpS?=
 =?utf-8?B?VUMwMHJUb05nVFRHZkZEVVd3cExFbDZNN1htSjhQL0YramduZUg3L0tLRDI0?=
 =?utf-8?B?SmlidDdEZFFmOUpKeEEyVGFXaDBNRWxhQnZlSFZ0N244VVhlVFpIb3NKd0I1?=
 =?utf-8?B?ZWd2WFdvblZEWlJXalEwNitNUGUzSDhscW9jQnc1dTUvK1JEaXlnSjFzNTI3?=
 =?utf-8?B?a3QyUTJZOSttNmhnNWd3MU8zYzd0U0hESU41V3E2VEdraHJ3dGFpd0VqUS9w?=
 =?utf-8?B?Nk5RSUNZK0VSWXNtaFFqYTNIYVpnK1V2TFJMQzZYdkV0M0lEY044WUhJUkhi?=
 =?utf-8?B?SG5xVXJrS3FPMThWc0UxNVlqTWtrWlljMDVvdENvWE04RzZPNU9VZ2hjbHVy?=
 =?utf-8?B?THJGQTlnTFJxaE5xQmcyTlUveWJmT3lpd2kxdFloc24yZENwRFRrZHBQSmlm?=
 =?utf-8?B?QnlZdW1lOGQvODN3MHBDL2U0UUVCR2VRSHMxUVhtNXN2S1hlQU9oZURRWnQx?=
 =?utf-8?B?c0JZbmlJd3FSM3BmeWtaWmFUUXlIUWpBZktLVUl3OWF5amlLMEpKbHo4bjJC?=
 =?utf-8?B?SjlSWFNaelY4QjZBc1hUMk5Fb1JTb1oxeVVOSkZkQVNIZjhtdW0xd2pTaVJ1?=
 =?utf-8?B?NTZTZlBGTkwyb2hTN2tHNHVDRnNnM3NlWDh0c2Z5VTVNSTdqMUpqby9QNlpY?=
 =?utf-8?B?ZTdyb2xWa2hIT1h3VHRGVldxNUljVmY2MmdRWXAzTitxc3kxZEQwQ0hsbi8x?=
 =?utf-8?B?cVhnUG5CQm9pNC9TbGVaZkdRSWQxZXRFaEs0UjhsK1M3aUlRVmU3RDJzT1Fr?=
 =?utf-8?Q?av4Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVZveVczbmNLcFQ2Snp4SGYrL2dkbkVhZEsyRWh1RVFvMEVlRFU4WWFTR0xS?=
 =?utf-8?B?Q0ZyM3EzN29tdnVMNWd6bVV5akhVckFWT1crZDV3N21TeGRKZEFGRjVFancw?=
 =?utf-8?B?dmZxa0lUOHpmM3hXTHhvbzJqM2FWNVgrVzRJV3dXbWdIREluOWkwQWNrblV1?=
 =?utf-8?B?OGk4bVBDS2NrQy9pUEk0M0VPSGhtbm12dmluaUNTWTFuUmhrQTBJQTNmWVFS?=
 =?utf-8?B?ZWRJelphZkZieDhFbzZwdC90SW13QmFtV1dEK0FqYlVvWkxmUEtOM2ltVENs?=
 =?utf-8?B?SExmMGZrN1Ezb2ZsdWw5SWdDQ0Rhc1NOQXF6SnFzUmpackFUYUFlbkhpK0k5?=
 =?utf-8?B?cXJTbmJQTE5INkNkM3FCMTBOZ0drcGYxbWhQTGdsRzljRkE4TkYzL2lLSGxO?=
 =?utf-8?B?UzRrYkNpSGhvSGpvTEdnY090a1ZMOFBjMzJ5M3hxU3dGRGZlOGhaa2FHNStM?=
 =?utf-8?B?Rm5wU0swdzZYMnhiaXhWOVBMSjNuSmlGNGlNL0lqaXNCeHJ6ODdPSm5CZWxG?=
 =?utf-8?B?Z2p4dnFOVzJkL1RZOEp1YTdlRVZGbjdIRVEzdzM4c3g1RFFzSmpqeDRRbnhx?=
 =?utf-8?B?RkYvcHlGMjFqcmlySUY1Z201MWxteHc5T0l6ZGFMU2VjNTdjMzF3UmFJem4z?=
 =?utf-8?B?dFNVNW9FcDhHeElYQkN3eVN3R1JPWGhoSVdDTUxKMUIydU1XU1Bjbkd2MUht?=
 =?utf-8?B?WktkTjk1R2FMbHl5dE9VZkxiNFU4blJ1ZHlabHVrbGRLZ3dJemltUWIzbFZU?=
 =?utf-8?B?V3NkdUJzMDRPY1hudTZkc21IY3JpNWx3cVdNalJjcUhLSDlsWWJyL21LUElG?=
 =?utf-8?B?Y2ZSNU05OUx0UWJ6eUl3dEJlOWFHN2JlajYva2x6TndQbWRDTCszbTRTNGVr?=
 =?utf-8?B?MHF6eWNOM2NEWFpMQzhLaHFnNGFkNGtyallZbE9OMWNJRDNzbzl0cWVlQ09U?=
 =?utf-8?B?ZU4wZzQxaFM5eFlmVndWVm44VmNidVFYNHcwMGtWeDJqb1QyeTc2OUZEWFJ5?=
 =?utf-8?B?aVZQMXpGVkUvK3FXaVZPZi9ZVWpsWGlIN2dFQXU4RENxKzdtSmVjQ3Q1WGJI?=
 =?utf-8?B?L3FLWEZwQ3R6NGFIa0dIZE5vWVVJRDZROXBDMXp5TE5mcnh4WHJudjlTK3dZ?=
 =?utf-8?B?eWdDa1kvQmFmeHpJZTZ0THluT1BlMXlzNDhySEt3a2VuNi9iZko3bE1hOTRM?=
 =?utf-8?B?akN1MHJTRVQ4dDg2bnBwOHMzR2UyOEFMNCswT0tUUFlqdk9NNTk3YjE0NERT?=
 =?utf-8?B?RGpUb3pBREw2djhCeEMwMzl0M1hlb1pLMHlVV1pwR2dldTM0UjdzZ0grK3pC?=
 =?utf-8?B?TjJtN1N2dHZ5cXE4TTJ4bG5welBXR01KYWduckZZejVnL3ZmMit2MEVaZ3FZ?=
 =?utf-8?B?cVBkYzdjRW9sdy8wQnllMjcwQ01pUEp4WHFUKzNjQjdqQ3JRcHd3bjR2WEFX?=
 =?utf-8?B?T1Bvb1RjcUJid1AzUlgwU0kvMEZpMkFScXg1cjMzeHd5WFBNM3M1VGNNOENh?=
 =?utf-8?B?OVpiQjNKdnNydUlUTEwrUU9JYlMwcnZVcTZBRnVTb1NEaUdqNDZqZ3pkOFBI?=
 =?utf-8?B?bEM1MkJWeVQ1aDhqQTAvYTIyWFJ3bzdrQTJueHRURXpBQXdiUWtoM3JrQTlB?=
 =?utf-8?B?NTV5MTdJU0M2eEtRV21LYkljNEMvY0s5c29kNmcyUE1CWWQvdHJXM01Lektv?=
 =?utf-8?B?TFJLZUZiZmlHQ0ViOVgxM0NpNjZzSEZNVGh3eDcwbUhaZHpyRWlDQzhPRUVE?=
 =?utf-8?B?KzJVRjdHRWdVRzZDVVRrdHd6ZXNFOFFBVS9IdDVPS1hmeVRUYU0wNDB4WWJI?=
 =?utf-8?B?M1E0VSs3T1BCM0ZCNmYvTWxCVnBHT2dCWWMwd2RlYTFuclNCcTJHK2lvSith?=
 =?utf-8?B?a2s5aGZiOHdJWjVDM2k1a3M3VTJiYXFLb3RLOEhVL1Fyenh5YUY1Qk9tNElT?=
 =?utf-8?B?ZDFTeHBPWUlxTVI5UEJXdVExTmNIY3ZweFdqcGdubXUzR3BGU0pGMjVreEJu?=
 =?utf-8?B?VGtKQm1tb2Z6S1FqZ2UyZ0llNUlhcDRjd3dwdjhyWnJ4ZTI5cGpsVnMxRjdV?=
 =?utf-8?B?QmpjdU84cXFpNEVtbWNJc2xUSmEyN0lNQnd1MExBTTJ4ak1IZnFCdStvTDBE?=
 =?utf-8?B?a3Q5RHhJMitBUU1jZi9QN1RCWENScWF3QlNaaWJweko4T1kxaHNXN3ZtMGZm?=
 =?utf-8?B?RlVjQmN1ZUZlUmZIV3JJUit1OHBEVXZqaFVGa0hadzJGcFdDUmNVdCtwS2pj?=
 =?utf-8?B?MDVXcTFZQW5ucDFGQy84aU5ERVY5ZFRZOXJIQ2ExcGVyVTR2N1NvUElwNU82?=
 =?utf-8?B?RXRMR3ZFcGxnSXRWdlU1TnF1K0preUY4NUhZRHYzaUF6SzRhMFc4bkVMS2J6?=
 =?utf-8?Q?1vYngRNrUSH0fDohjJpBksvMCigtOdywOdJbc?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ed8b8d-4524-406f-d0be-08de58dc1ed4
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 10:59:16.8147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZHXpzMCpveawd/zRl64cFl9xfOoCero+fV2tUMp4R5FbitvfSrTT2Mi4lzS5JMIyc1q0xixqNjA9SJ+E2TBpFeRxRZhzLE4AtoxaquJiCUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12127
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

Hi Tom,

On 1/20/26 11:31 PM, Tom Rini wrote:
> Make use of an anonymous reference for the external link here, per rST
> best practices.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
