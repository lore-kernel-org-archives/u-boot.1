Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28CED6392B
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 11:13:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1487A893F9;
	Wed, 20 Nov 2024 12:13:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="cHsqRV8N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9815D89684; Wed, 20 Nov 2024 12:13:38 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::61d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 717C28901F
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 12:13:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJ6Uns+E0O2/YE/XEmVIs1B0iJaXUl7rs+vkRWEhJRT0lUiSRrSc73321sEhnGQdcP1XImancBX7AP7GfEBLg5NAxr1x9X2O3/6jEtRGa7b6wJ5eTl/xCy6hRcTIC0dHrlsWRz/jpr6sCNH9XjOzAh8qC8gAtQjyS5qM7AtqCWxmOpsnuopGZDe6oOTV6E2gJf5aiHj5kZXXvc9JEMedMNiO4EYwRDZLQQin4KxR0VFd1LbnvlUaczZCODWq0dPe6E53oCJO44hCrKEQHSWVxZTN2BIYQha1bvioDTBTNfuTrf7hzxHQiK6CKM+aBNQTc7lmKAomKX1g66gdOwFgag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+TusBG3jS4m6eeAtn/AVe92GjXIOSxIaxyY8jqOgUc=;
 b=tJQAQJqAioQxC2jUj8ixDYbwtfgQ0SXKp7QtjuIqiomjbxRwXIx4WjnmTe3hAijTpEXtrOpTbaq96c/3bGvea1igvVMOwNGzkUoUGczABTax0jGRfnbjeWGBZkrKyg9fPZEckMaW6dlwfcByAroVfyGOGPABbCaN5M4ESVJnckHRAbPZZKmBxXwczqHmIbHQktJmkLOdUAcFd+/Qo1ojO6PvpHOTeaNEFAkRCSk2jEKxRZGpG8pIpMQ8868Ev0WBcttrh+ANC7zRpM6loTz0g5W+uidiCvXirypY0+RhJYrUdbsiv231qiX6AOvhs3bvoBHTSjAKDRxz1zdbVYkOYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+TusBG3jS4m6eeAtn/AVe92GjXIOSxIaxyY8jqOgUc=;
 b=cHsqRV8N4MoOir710yASDAjh/cK20oS7Z708l5inIqY8Sk3CULNiWJXOZ+LZZRbjh8PBsJh5MrWXQHZMbOadzYzyEkh+WwJHS6V7QonCRMoOjAlpNDuWugi1sfXOlGU1Zi/bcCxzSrC8REyoxF+IfFyMXIlRGiYnijztyY/FyH0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PR3PR04MB7404.eurprd04.prod.outlook.com (2603:10a6:102:8f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 11:13:34 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 11:13:34 +0000
Message-ID: <4527740e-34c5-4669-b3ae-86792160b59d@cherry.de>
Date: Wed, 20 Nov 2024 12:13:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: rockchip: rk3588: fix mask define for aclk_vop_root
To: Heiko Stuebner <heiko@sntech.de>, sjg@chromium.org,
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com
Cc: u-boot@lists.denx.de
References: <20241120101911.1142500-1-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241120101911.1142500-1-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::25) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PR3PR04MB7404:EE_
X-MS-Office365-Filtering-Correlation-Id: 56485313-17cf-473a-19dd-08dd09545f43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWU4UnpQaG9jMWFMNGlBRXhqNnZZOHFJSTgwVDVtMjFRa3pvWHR0dmNTOWJv?=
 =?utf-8?B?WWkzOGlLN004cnBnTENQbk84ZitWVDdVQThWaVY5RzNjdGN1UW9yWEFSUFBM?=
 =?utf-8?B?NUUvYzYvc29XQjJxbHIwbU9PNWE1WkZQREZTYnAxOXVlSDRnYUhtRnVFZDJs?=
 =?utf-8?B?L2lpUkFKUi84UE9uemRuRGJEblJVY0ZWcmpZRnFGMXY5UnBOdXpYTUdsVllC?=
 =?utf-8?B?d1VwbE9MenVZR3JvdEU0MGJ6MFB0ZGx2WHd6clR4RzBpS0lrVWRxV0wrSEJz?=
 =?utf-8?B?M09pcXFLRVZLTnFWWWZiTDZISlkwTHp4ODlLUnVVZFQ5cERINEtxcllLV3Za?=
 =?utf-8?B?YlF0WmNLeHZzdE5qemdFWXVjSWZkbFNuK3ZkaGozUUtRdGtDeHlzN2lhc05U?=
 =?utf-8?B?QUZlWk1ZLzN0VFZWWnpBcHZrajdWU3JNMEVraDJMdTlFdzdYMmF1d0w0NUx4?=
 =?utf-8?B?d2F0UHR2OEVVWXVWTU1vRm5Wbi8vQTV4MWpZSzF5ZUhnTTcvbk5WOGd4K3hK?=
 =?utf-8?B?MmJ3YkdkM1RtUGxwMklEZkpZbzVtNlhKN2twNitmNUE3VHVkMmlHWThVQW5w?=
 =?utf-8?B?RTA0eWtYT3BiaWdCVVhuVnRVbi9jWDMrTXdmTjF6Mk4ycWJ4OG9JRzdEOGFK?=
 =?utf-8?B?TGdSenNkTWFHZFJMWnRxeWY2TTdiUEtWU3NYbDZPcXFiL3VtM2sxZnZIQVd3?=
 =?utf-8?B?bEx1ZXEwMnNqUTYrcThLdXdLak9RbUY3YWxaTjNQaEs1MERIdkRGdlBRWGlV?=
 =?utf-8?B?dzB6WlMxTE9Sa1BNZW5BSDUwSjRtZlZ1WGJjS1JaVjZVOFlXQmhTWjhudVBO?=
 =?utf-8?B?eTRwdUs0NVBkWmY2bnh1bVNMTGlVakt1R0NLMC9BZSs1U1NGVDJBMUZiOEVM?=
 =?utf-8?B?UGlpMjZlaUVyMEpvVlpMbXlSazM4eVp2Yk8zS1F5M0IxOTkzNElNbE1MekZv?=
 =?utf-8?B?YnRjeTQ3TEdpWGV6a1hxZDR1QUlJOWFTa29YdTEvL2VNMlphb1JIbURVRDVh?=
 =?utf-8?B?QnRPd3VWU2ViWlJvblNHTW5ZZmhDQ3BiQU1qL1hFdk1La01mVjdHOFFqa0dL?=
 =?utf-8?B?cmt0N25ZSmVKK201Ungwdm1aVHlkQ09XQXJuWVhlL2xyTVBITFI5emhYcFNp?=
 =?utf-8?B?U3BIcVErMjJiRm9KOTdIVkcxS1FhVmlIS0UrYkc0ejJwKzVvTllMZUpzbmRi?=
 =?utf-8?B?ZkJVU2NLV205SHEvVVNNcVp4QkVVSG12bkhZZFpjL2daT0RIdmx6cTFKNFk4?=
 =?utf-8?B?SkVwdmJOd09QUHo3NHUya2U3Y1VlNnh4YlV5Ti9ZMjkxMmU4K04yUjRzS0gw?=
 =?utf-8?B?ZFVuYTl2MVBDakxBNmJrSFBEbmJMS3Bqb005eWc2SFZOQm9EZ0ErTC9nTjRV?=
 =?utf-8?B?QUc2WFlLOHEzVndFZzdiWXlIaTRTSlVjczdqTnA1Z01qQ0p5cFJlOTBwR0M5?=
 =?utf-8?B?Z3hYL3lBVmtSd0lmSnoxUHVCUGs3RnBnakQ0Z3k5TkRVRjVabE1OQXI4L1l3?=
 =?utf-8?B?cCtUNk92SzFJVnJGNEEyOThiY1hQMWhIbWhXQUtQQkhzZGxsbFBFSTVpZHk5?=
 =?utf-8?B?b29YZks4Ni9wMkpXcE9HZjZFZFFzWkkweEZuV2t4SnBSbjF0L1VjcnlhTUds?=
 =?utf-8?B?bW53c2FoM09XTXBzU1l6QjhtVmZCc3RaMWVvakxiSytvUWZLQk9IZDRBNFNm?=
 =?utf-8?B?TFA1NCt2L2RCNkpoODJhbG5FRlliZWNuWUFGSmpKWEltVUdPcWdjVm5xUnc3?=
 =?utf-8?Q?Emi1bxRoLzq11RtlcW0nYrv/XcJXb935P2zi/N+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3FxWmsweUxjSWFKdCtHUkdhalRRM1AwSTdmQlU1S2ZVR1VCY25uUnBhWFpx?=
 =?utf-8?B?b2ZycEVRVW1XWFo1NzRaL3BqTUFpNVVqNTBtaXZBaDRORWk4UmNQZWNpQnhk?=
 =?utf-8?B?R0ZFc0k4OUI4VW93QU5zM0VJSWw5Q1l5NDdwVmw0RHIwcmlFeUVwTmI0V01j?=
 =?utf-8?B?MzRWU3pITUNzVFZGakVHNUFNU2tyYzk4V0hpYkUyWlRTbFRDUDFMZXdnL3NC?=
 =?utf-8?B?eUJ3NUtHbStHSm12N0hkb1J6RW54WFRSN2Z0aGZrV3pCK2VzWllWdXh5SG5H?=
 =?utf-8?B?SStqYUNBbXVkR1h0QXdiUGJISGVJZng1Ymg5YmJORGRHNVprTU04dWNTTnB6?=
 =?utf-8?B?NGk5V05ZOXVYR3dUNkpGYTdZNU1KT3h4d056Z0xWaFhKdnU0OWlzZEN2cFcz?=
 =?utf-8?B?RFFTVGZ3UXBCREQ1Q0J3dEt6dUdadnRnOTF1a09TSFB0QUY5T3BjdEM4YTJB?=
 =?utf-8?B?NC9xSGVhcTBHaVdHRXpId0NCcEZ6N0s0VDA0VW5zZFdtUk0vMmhLWGh1SENu?=
 =?utf-8?B?V2ZlNzBZaGdBY3pxM2xoRzJPRno4emRFZmlwNUgwTkxsU0JXM0xHNXBaM29S?=
 =?utf-8?B?WG5TS0dsTnFtWUt6ZTZxOFdGdWNXQWNNWlIvcndxWkFxU0o4M1FScldCNEwz?=
 =?utf-8?B?ME5EN2tqOGNMYjVncmUxTkJ2U0wxSkJ0UGVVZTVIOFdVclJmSTBDL09Wa0lN?=
 =?utf-8?B?UHZqL1RaN0pTRUx2b0lSWnR3RG93NldHMkpPWGRHdGZwc2I5N3VWZXNucnJV?=
 =?utf-8?B?UmZ6MDlxZWtIM0phbFIzQlRvQlZhMnJNSlhDNHo2Ly9PV2N5Y3JldlV4WDhK?=
 =?utf-8?B?NE9DQzIybUpPQkIvekJYNEpNNHBhZTV3M2pxUkFrMy8remtNaHpYbGRmQklX?=
 =?utf-8?B?MWtOZk5CWnlhdnQ5YU1McEZ0TGE0TmNFUGFaSmQ0aUhrbWo0YjQvMnlGOGtx?=
 =?utf-8?B?cDdLQmV4QklmbFB4amszUVlQSkZRNkN5cGdLdklqN0FHbWlDdXk1aWg5ZzJj?=
 =?utf-8?B?Y0gzQkYxT2x5RU5LUnlESzdRQ0t6aE4vTVFOeFJObnhIditxbW5maWZST0ZS?=
 =?utf-8?B?SVhuK0I0OFRyZFdGOUtuMnJFWkk5S1RBdkpyVlpuTkwrazg5NTFMRldEeERq?=
 =?utf-8?B?cnl5RVhteUx6TG9xN1dOVW12VVQzQXFWeGVqdUszVWJmbHRWLzFOODRoaExE?=
 =?utf-8?B?WXlOQW83YW5SMUF5K1NlTWtLNHQ2NFZDWXRrTzViMWN5cnNTcDhvdnlIV3I2?=
 =?utf-8?B?RjE2S3lDdVpmZTl5Tk5ESDQ4R3Q2SkRpdWhuazJzOGIwb1pQNzhPYzd3eGYr?=
 =?utf-8?B?UHJ5bDkrcERUeW9McUY3Lzg4QWJyeU9GYWMvcDgvRW9NbkZFS053RW9TUUZG?=
 =?utf-8?B?ekpwZ2o3NDU2RkdMcmU4M21kK3VtRStuOEJUUUVFSXoyVGl4WmVpOEIra3ZJ?=
 =?utf-8?B?MTArcHoycDBWNWduNmdTRXdGSkhyMzk0ZGpoOTJzL3BLVGtyVW1PODlaS1JJ?=
 =?utf-8?B?eG4rSE5jTFVTMSt1MlYrbWdlMFJ1TEw5elA4M2hCNjZjMGtCN21oT3BWSVJm?=
 =?utf-8?B?aXRXYkpPOHZDWm5XR0RQaDR6ZytNdU9RZVFPZ3JhTGNpbHpZT0w0RThsTEVM?=
 =?utf-8?B?djNadmdxTWQyaW5IdnZLWmRBeUFWcGlhU2Q4REMwRkNYN1czSlZFSnIrYmxS?=
 =?utf-8?B?dEdGTTFqZzJHZmwrWEI3RHQ2MTY5WHBJSE5GeFkybTFETmhJTE1SMVBKc3dX?=
 =?utf-8?B?NFZ5RGVER3RraGVobkhGVVZ0c0lQa0MyUWhtYjZZWTVZOS9rMEhoRG84MXdC?=
 =?utf-8?B?UGJRVklndEl6TTJYUUZxUG1zdE42SzJCcTJ6R3dsblVXYnlaMkhDN3BGMTY2?=
 =?utf-8?B?Y09qZTdPcmFyWUljYnFIa0hvTDNuaWhEZVkva2hUY2NLbWlTV0NLWEhVeVl5?=
 =?utf-8?B?UXZWN0NVc2ZGditINEtDaWRFYXJpQTlGWGliWGVHdlp4alMxeWNuSi9obSt2?=
 =?utf-8?B?dmpQOFl4TmVlZmJkMjI5L1k5K2VGeEJMMUJyaFJMR3lLK24vc0NPN2xzb1Yx?=
 =?utf-8?B?SHdETmZEaDV5REFtWW9RYXU1NVJEZ3lLaHZnWXBxa29hQVNuUWRGNHFsdE1a?=
 =?utf-8?B?SW1Ub212cTh2QWVyMUNlblR6UVY3Z0M4RzVmRngwdXVIK1gvYWJtNjNkcjBx?=
 =?utf-8?Q?ujV4psErjpItQzLLj5g2TBU=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 56485313-17cf-473a-19dd-08dd09545f43
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 11:13:33.9514 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: coXrgoDdhOdsodm7GsxSJLhMXxdL4fRcAfAFVGG76WzLzkSeJC0z2puwXrePph/6l6M3Tu1WaS7722YafPorDqbtp+kLeisIDXnFjY1GEvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7404
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

Hi Heiko,

On 11/20/24 11:19 AM, Heiko Stuebner wrote:
> The mask for aclk_vop_root is 3-bit wide, not 2-bit wide according
> to the TRM, so set the mask accordingly.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Was this a drive-by bug fix or did you actually experience some bug? 
Basically trying to figure out if we should push for this being merged 
for 2025.01 or if it's fine if it misses it?

Thanks!
Quentin
