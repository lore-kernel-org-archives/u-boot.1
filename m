Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A024FCCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 10:35:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA0D083A45;
	Tue, 28 Oct 2025 11:35:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="W6rLQnQd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA84383A56; Tue, 28 Oct 2025 11:35:05 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33EBD839DE
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 11:35:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxXrjwtPGxojQ9f1e7WF49emUmBHbk77wylLD04olRNhBDWbB8j1Sw4FKdHAWsENb9tGpHdDTIjt7p6etiV1zfmjJciwcaPEDFCOn2nYrNfjSSxWt/fnxjqY7KT4jdI4FVOT4atAxDJ5Mp7LqpXwFYnH78Qh78Gzhi+DAbEMe/n3Yw4CqmlS9i/2a6DRsgwu+GvlKVgvveXAZYom7fhvXIh62GVz6LUB+GMCPkJY/eA+5BbR/OhFTJmn9NBJoE6HHx/X0rcaCm48kGhApftQO8BevcjQtHcgXee1cqurYd+nj3NsfaqnTwDv4QFU3dH/CB6cmkEaFt9XJ/XkI7qFmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBy+mQRjcKIrpSzb3NPNGPdRlx5/7QOp8UKT+bUTD/M=;
 b=Ul45WGMty1/xGHKxoF854YlJQqqM4MHXb2SOJjbxCiqQ/BiN9+jQW5JgCAFQnnp1+h2WNNP99DCxrhJpEQMBH8B+PRihjJlCron2p3zLq0ohz1pOdYriQPr3HP3tvOrkAKLIYqhj8RTfKuygW9J3sIqiV2yF1PF4e87cjyPwc98R6EfN3sU9UQ6jRdLtpQsY25JRZKSD6uQOgXbhJHPGH1rso0lFPS8hQbJqY2Ec32efvQK9CKRQIaDVC3uyv/tV/oGJQbj9a2H9C3aU+s+tDs2htar6es8oubbZEen6grL3oZiwTRgA/BSlLsL0exvWrfCYuj+lx6sGTl+c/Qkw/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBy+mQRjcKIrpSzb3NPNGPdRlx5/7QOp8UKT+bUTD/M=;
 b=W6rLQnQd4w+wS2rWZNfeN4QWKQI+vsxCLplizqeR6fQV3BSgYVYJCSOg3NZolHPnOIBmudF4pvvZABtS0n2yac/t+RNxBFxoKRidMrWRO6/PuXfs+MLdJ25bJ3PU8WYCSQpt7uYr/bbdq6VLP6iSuEElK/Jf6mFMxTwETGH2rD4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB8179.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 10:35:01 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 10:35:00 +0000
Message-ID: <5f45b4ed-d01e-41f8-a05e-c617039228e0@cherry.de>
Date: Tue, 28 Oct 2025 11:34:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] rockchip: make rksd the default format for SPI images
To: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Johan Jonker <jbx6244@gmail.com>, Sumit Garg <sumit.garg@kernel.org>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20251027-rockchip-more-template-v1-0-430672840303@cherry.de>
 <20251027-rockchip-more-template-v1-2-430672840303@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251027-rockchip-more-template-v1-2-430672840303@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0063.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:26::8) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB8179:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e932ea9-1907-4634-9899-08de160da550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0dORWJHcEtOTFh2Z1ZSelVNOHp0U2FrdzN3bGVWSVkxejRiMlpIK2s4Qzls?=
 =?utf-8?B?RjdTQy8zSFU1V1NqbEg0MTJTeUFKR3Q0amdubVpDU3pvNzZJTkRSZ0VnNzNR?=
 =?utf-8?B?eExSOVVNNk9WWVlvTVkycFFUb0RWT2tnWStMMVlHTmRaL0luNFZtclJpRnN6?=
 =?utf-8?B?R29GYTN5VGxVa21kd0lEWkt5L2JsQXNaNEh1VTR0MjU3L2R0MDhnU0s0YTlW?=
 =?utf-8?B?UTZJN0JwRW4zeUN0SDhRbnE1WitwNnRaT2V6ZFkwcWxDblVna0gydjZSUHRF?=
 =?utf-8?B?UkZwTWZqRnRnRFBsMjlYcElXT0ZlbnBqaUFoRjJQM3U3ZldoRlVSNjZrUmlS?=
 =?utf-8?B?WW9LWGlId2hPWFRnQkNsNUVJTW56NTFQdWd0SThkUXBwR1BqcWdtdktnbGFZ?=
 =?utf-8?B?RVFRaFFTdHY4OU1UWmlSd04zNTgrYStFVElCS3FBZ2MzN0JGTGZJbWhIR1pW?=
 =?utf-8?B?R0NEemx3bGpKVDYyM3FVWHplT2ZEY05JeVRLNUUyZVJ2VVNpOUdjRnozWDMv?=
 =?utf-8?B?U2NNb1VjTm93Vk9Qa3J3RTBCOFk3eHpsUytZNWQ1RFR6VHdRc0JjL2sybjdy?=
 =?utf-8?B?cTFLRm56NGl0WWpwS1BoUStGY3hadk12cjJxaW9nWmRBdXl1bCtxUkhBdXJS?=
 =?utf-8?B?b2tpOGdDZ0tTdVRiZEN0MFprbWtIclI2b012cjYxbmhZRDgyN3VrdjVkeUU2?=
 =?utf-8?B?QkhXbitPMXlrUmIrRE8wWXd2bnVwUW9wdnRTVkdFTGh3Tm9Ra05lY0FiRTgy?=
 =?utf-8?B?WE1zNzFld0VydzBOZkVxN05RVFU1S0ZNcWZZVjJSLy9CVDlYU3ByMUpOUHFp?=
 =?utf-8?B?VjdiNkhLOUxJd05mV3gvYnltUjBOWEw5S1BvSVpCSkk3TEFIV0ltMjdkdFZv?=
 =?utf-8?B?VjAwcmtzcWY3RzlXVnY3N1dIWHExQVlmR1NrM040cFhnUzlHRTdwMFg1dlVx?=
 =?utf-8?B?ZkhqSHdScDN2Y3ZuL0hkZ1FSSkdsVjVWZ25ualUyOGhkQXBVdUM2UFVuOVA1?=
 =?utf-8?B?UUMxYUNReTAxTEpqUWVIT2hKM3RZL3JRd0xCVDVIK2UwVWUwSWpiVUFHMkFz?=
 =?utf-8?B?dDFvSlpIbGJyd0JVVWhmUmVkUzVSYWVhSStBRzNydklQdFVwRWNFcTJkb0pz?=
 =?utf-8?B?UjVQeUxvZ2s4a0J1bTlaOHBNZ0krQmRLeGptZXM1VlUwWCtOdHFGQVhsVXFG?=
 =?utf-8?B?VjN6dU9IMHU0Y2ZRV0lISGtCK0cyNEpscGg3aU1NcVNRejg5b2kxdzVmSklO?=
 =?utf-8?B?V1FnWHBDSG5xc0pnMkVISnMyL0duU3pmcUppbnN5cnlvd0wvSmFoVG0rWHNz?=
 =?utf-8?B?Y0I1ZU02MGFiN3ZhWWM0eVlnc2JDcXpiaTRLZlpPY0RkbnJEdjdQOTNORTZE?=
 =?utf-8?B?T29jdVlDcmNSSEw3clFhcmJTbk9sZERKc28ySkdkek1GSHBPLzh5NEJQOVUw?=
 =?utf-8?B?VzFZVld0endYZXliQUdzQjR4dVdRbjFXWUtlVlRaR1o2a0Ftb3BrTnNVdXJ1?=
 =?utf-8?B?Wk9sY2ovVk1odHF4RW9lYThBZkZFY2o1QVVaV1RRNmFOL3VDbVEzaFVtUy9U?=
 =?utf-8?B?blJCSW43bG1vZjJVM3VZY0R1WnlJM1RmYXpLNzd3ODB4OUZEZXRzelBnNW8y?=
 =?utf-8?B?MUdlaEhTdmZGeHg1L1plWlQ5UDZrcUhDbnRaZkR1cWwvSEF4ckFsRTB2bW1Y?=
 =?utf-8?B?djFCV2wxWllIOXpoUXh2K2V4WGhwaUdJVHdrc1kwVkFzOXpTcFJNREdXQXFE?=
 =?utf-8?B?cThuclhMaGtiYVdaSkQ0UUxJb29kVFRsaDY4eXl1dzZ6Ull1ZG5PQnU2MVhi?=
 =?utf-8?B?d0FLMG8vUGMya0kxVTZOMWVtMUdIeFp1Q0hoSXpUSDBRcTNnR1pHNUxDZUli?=
 =?utf-8?B?cStrZUpkRnhCdzZvK3puM1dRTGFhQUlSekNZdjNSV0dId2ZzeXVrZzF6TVVt?=
 =?utf-8?Q?09sdrUbEpcZmSWRl7KK7FN3CJZ/OJ+gp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzlJRTR0c0RaUmowNE1DZUFHOWhmZ1ZveWU3UDBldWFMY0Uya3IrV00xU012?=
 =?utf-8?B?eTl3UVJCSng5Q3Z6dVl0VHZSbnhZKzh0NFdMdVVycmM0TmNSc0l2Y1hSenhk?=
 =?utf-8?B?aFpGd3NCbExmMnhGdzUxUVg5OGdLZTNUZDRJUEFuWFBtdUI5d1k0ZnBOa0ZO?=
 =?utf-8?B?SlBqR2ZHd2YzUjRoUTBMd2tzYVpiU1FKNTJPeVAvQS91WUJNbjdacDhzMTZU?=
 =?utf-8?B?dU1uejFEN3Z3SUN1NUo3My9FRFA4T1RHUW1JZDVMOEVYK3RyRHdyQzcwV2Er?=
 =?utf-8?B?K0swb3U5Y0x6Sm1haFJjTGRqNDVOL21RZG8xV2lFelpDekRrSUNtQjZYckxz?=
 =?utf-8?B?MXhJTmRmeTExNXFxVzdPOHFUN294NjVVUVJBR3E1dkowZWpsbkV2V0V6SWpo?=
 =?utf-8?B?dGwyZDZqMkU0cWNJWlN5TzRNUU42cGFmVklzUGdTcjR1YWVhSDk3K1crMFR3?=
 =?utf-8?B?RWVmbmlnV1BtTHV2YjJaeTlIZ3oyV05vTGxjem9Na1BwcmQ0bGpFSEJxeGtp?=
 =?utf-8?B?bVUrK3EwdUhJUHovcUcxWkFWV1FJUXhFWHRiaTZ0QkR0MVdza09vZTliTlJ0?=
 =?utf-8?B?amxOQVVlNjlZWW9iM3grTXRlN1lsbmJZY3VETTJQV1QzSC8xSmExQzZ3eHV2?=
 =?utf-8?B?c0hrblpTQjVDTitKWi94VSt3Y2xZLzFIQ1JsNDBqY1ZuajNRK2VreGoxZGlK?=
 =?utf-8?B?QWhpUENnSzVZZHgyanhCdlBGWkF1NldRYjg2Rnd0SHFPaE1kWnBaajZKQm1N?=
 =?utf-8?B?TGFRMkZCZEhwSVZrK2txdi9jbVg2bEtUUTdLSStUbHJMcHZYM2lOYkFyVEph?=
 =?utf-8?B?NFhDRHdPMjRNcDc0WS82WmtXWUM1Y0s2VkhYcjRqMkZLOVlSR3N4NTJsQTVu?=
 =?utf-8?B?Nk0zUjFCWU9BZktpUTlEcFhtM3JmaEhmN08rc2ZPc00yUFBVL2MvTDFCUEkv?=
 =?utf-8?B?ak5ITTR5MFZGODZUeE5Gd1VxR2I1WGJGSmhKV1NnOGUzRFlGanhTbk1jaWxt?=
 =?utf-8?B?NHF1aktkazM3REdJMkJvYkpWcWM0YUpkNVFvN1FmUWtKR0Q0Tlk3VXBEVDB4?=
 =?utf-8?B?UTNGc2lqVjBWU016YitCTE9oQmwySlBoWVNFaW9oL2tGQkF5NFVQTVNMZlFL?=
 =?utf-8?B?M1Z6ODBoN2gyeHJYcitoVngvMkFycEpyeVJyQmp6QjNOUC96UWV5S2JGOWkr?=
 =?utf-8?B?Y2ExRk5qLzlra1NPTmxtUFZBMDhoRFh0UklkNFdWRytoZzlEaTJGN1ZTc0k5?=
 =?utf-8?B?TSt1eTE5bUI2NDNmZ2lTaEIxUTFGWnlyMVlvUkZ6Qld3YmZpeEF3S2t4ZGNq?=
 =?utf-8?B?QnIxRGtwOVdrV2hRQ0F5dWJBNGNmMXZpMUNKQ1MxMmg0S1RBNG0rdVBKS3RO?=
 =?utf-8?B?MW1wbHVad3F2cGt5cW9tc1ppYlBiNHhYWityZ25vNHNyWVI3c0trbCthUTdj?=
 =?utf-8?B?dS8wTG5IanE4UUxNRGVwUmlOSmNnRE1RZ1dqUjByWjNtSEpVdnJnTkR0QW5n?=
 =?utf-8?B?YWJ4U2xlejdwOHdJenJoN2dYck9WVUVBN3dKNXZqd1k2WXR6T3BTSGNGblJ0?=
 =?utf-8?B?TWoyOFNNZ3ZBR0tXMXM4TlY2TWZRU1VrV2hERTZ6VDl3UjNqQWllQkhObzky?=
 =?utf-8?B?dTBWd3ZBMTNJamVKbTh1bCtlZXFvMFZLdWRzU2QzY2U2R0czR2ZWd2lleFBn?=
 =?utf-8?B?T21RQ2dTYnVhZXhHc0E3RzB6Z1RmanhCbXVCNVpPNHArcEVZd2NhSEwxZEFB?=
 =?utf-8?B?NlE2Vmd5eEZjcEROU2V5SitsM2VaWS9RcjRYVWJIRm13ZGFwUDBjNWN2blpV?=
 =?utf-8?B?bENJSTZUWE9Yc3J6VmZHejF3L2NaSmswUlRVZGRyZjlOcjNtZlRZKzBReDlX?=
 =?utf-8?B?UUhVTEFIME11cjkycFJqd0hnMm1BSy9qKzJlVm1ZNVhESkV5bUFXaUJNVnFZ?=
 =?utf-8?B?M2d3LzVZcHFnQjdpclQ5NUR1V3l5OS9BeVgyYnRzT2VzZHdXbFpqekxqQ3VK?=
 =?utf-8?B?YkhndU15R1pSeVdqWTMrclFhSmdzS1J5WXlGTkVoOUxtdjNsK3VxeVhwYWwv?=
 =?utf-8?B?N2l1UkRvZTNQUGhSYlFTV2N5cDhvRHVRY2c3Y0NPOEpSd3d4TkIvYkVuQzdm?=
 =?utf-8?B?TTIrNmsxZGQzR3pjeUR1MXN2SC9GcXNkdmJ2cFJZcks3V3NjclJYbkg0N01r?=
 =?utf-8?B?bnc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e932ea9-1907-4634-9899-08de160da550
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 10:35:00.6122 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ulk1k5A4dBSKOWtQQQH9ng9nouDLbvZZicUI1ATsGQxX4dVm6h1+SoJcRxxvS+VOzM8zTr1zRoPuWqvQNGTg/53F1tnZtcqxVs16FKXwXMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8179
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

Hi all,

Collected some feedback on IRC on #linux-rockchip, so putting it here 
for future reference.

On 10/27/25 4:51 PM, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> I believe (hope) that the new SoCs should now have this fixed and not
> require the "hack" implemented in rkspi format which almost doubles the
> size of TPL+SPL (idbloader.img).
> 
> It's known to be fixed on RK3566/RK3568 and RK3588(S) (according to the
> DTS setting the mkimage format for the SPI's idbloader.img to rksd
> explicitly).
> 
> Since I do not have any board with a bootable SPI flash except on RK3399
> where this work-around is required, I simply invert the logic by having
> rkspi explicitly set for all SoCs that didn't and remove rksd from SoCs
> that did. It doesn't mean that the SoC actually requires rkspi format,
> just that it's been the case until now (maybe because nobody tested).
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   arch/arm/dts/px30-u-boot.dtsi              | 12 ++++++++++++
>   arch/arm/dts/rk3036-u-boot.dtsi            | 13 +++++++++++++
>   arch/arm/dts/rk3066a-u-boot.dtsi           | 12 ++++++++++++
>   arch/arm/dts/rk3128-u-boot.dtsi            | 12 ++++++++++++
>   arch/arm/dts/rk3188-u-boot.dtsi            | 12 ++++++++++++
>   arch/arm/dts/rk322x-u-boot.dtsi            | 12 ++++++++++++
>   arch/arm/dts/rk3288-u-boot.dtsi            | 12 ++++++++++++

RK3288 is confirmed to need rkspi work-around to boot from SPI as the 
Chromebooks Jerry and Speedy had build instructions to use rkspi.

>   arch/arm/dts/rk3308-u-boot.dtsi            | 12 ++++++++++++
>   arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi | 12 ++++++++++++

RK3326 is confirmed to *not* need rkspi work-around to boot from SPI.
Considering it's a lite version of PX30, I'm assuming the same can be 
said for PX30 but since I cannot test it, I won't modify it.

I'll send a further patch once this gets merged (or if there's a v2 for 
this series) to make rksd the default format for SPI booting on RK3326.

Don't hesitate to provide feedback for other Rockchip SoCs.

Cheers,
Quentin
