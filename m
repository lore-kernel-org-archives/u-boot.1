Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBC3C83F1B
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 14:58:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAB9A83666;
	Thu, 10 Jul 2025 16:58:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2Ja2GuwA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37A428367F; Thu, 10 Jul 2025 16:58:14 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::604])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7B0B8363C
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 16:58:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xSb6n1eGPnyqYlnnMNn7DYX0hqDBTq3F06uMa37gfpM0nqZFuRINQvWY86B3GBQG1nrKa5oh6bUoic0TxDXTHI5X+NUPo/Nd9EcUO/b5Lv9DYuvPh6JNrT5FE2gdoLTRArG6dx2w9pz6GaeQJH6vSpP4O0NwJFQlwdXyrlVSfwl0UMdnul0Dd3UsLOlufKsvKS5dFk8E1dwbNB2qlV9IUvGLAhr9cYW1NykA1F3GaTRoD+bDjwx1aVvXMWDxHGJh8vujULZ60MDHATYzJmKbiA2ZJGGQWw/zBUaejFUQ119pSufRlR+3su0dIqoJ5cbiEIRRTAwFyVN+EPB1SJRfGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nda36poXQFx9hBTMf3OgetknUT+gCcGwHDO8LjcT+o=;
 b=OVQgdht25C1BrO0XLLlTIbctKdoJJ/Dduh5ak9rHc0p2Mib1oB0LZHBSD908KH4rKNU+26lWyRZkgzbGYvVXhtTvOyHLX/b0dTa84Ufwj8jXvC7enrk/sL5Kasz06jnjw05Gtbl9Xr3siGA1PvRFrC8knh28iF2PqdCUku1R0pHq18jM0B+rwgFGnsRXezI9oVQmwGWN2F59rTIcGQDgaRpRxSTgDOFmKxcmCWWYGyuo2msg0eBSDe/ai69xbqZNWUWyx1n2N7srj2L+Fn3LPtqjihEZ3JavMivqBGkQ3dbuKCROBAkedmn3M5fUjDt6M0hlEiT9EcGSvlsGIPE1Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nda36poXQFx9hBTMf3OgetknUT+gCcGwHDO8LjcT+o=;
 b=2Ja2GuwA3NVAxJiEKNEsD2m7m5LsqrmZNn6clOsXrp9a8D78e5c1AZvfbfQVIp0EiLvs7cDMDvPSKYLDIOBXkgnQKrTxA7AYZpXpD7m5hJAJRWLFUQ3YmqylCJsivozOhe2qKJfgbldYaqp3c/JcaalDJPlM2LMPlmp74zhdpbE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS7PR12MB8203.namprd12.prod.outlook.com (2603:10b6:8:e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 10 Jul
 2025 14:58:07 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 14:58:07 +0000
Message-ID: <8df9cfba-662d-416e-ac21-5ae6d4448708@amd.com>
Date: Thu, 10 Jul 2025 16:58:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] kbuild: Bump the build system to 5.1
To: Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: trini@konsulko.com, sughosh.ganu@linaro.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Stefano Babic <sbabic@nabladev.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Marek Vasut <marex@denx.de>,
 Olaf Mandel <o.mandel@menlosystems.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Yannic Moog <y.moog@phytec.de>, Wadim Egorov <w.egorov@phytec.de>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>, Sam Edwards <cfsworks@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, u-boot@lists.denx.de
References: <20250627185723.342553-1-ilias.apalodimas@linaro.org>
 <20250627185723.342553-2-ilias.apalodimas@linaro.org>
 <CAOMZO5DP=8Jebnm32mPQ6s7rcTX62dgKqyzyrdco9dHNewyWKQ@mail.gmail.com>
 <CAC_iWj+rJgUGkpEV-vYRei9R-UPj3J_2ix++K3P-ZXK8C7Vneg@mail.gmail.com>
 <CAOMZO5CDkeD633fG-pELUF+QyzW3ftP_eQ3LmrjUTuaidY1c1g@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAOMZO5CDkeD633fG-pELUF+QyzW3ftP_eQ3LmrjUTuaidY1c1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::19) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS7PR12MB8203:EE_
X-MS-Office365-Filtering-Correlation-Id: cc3ca6c8-b0e2-4d48-4b32-08ddbfc22da9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MCs1eVZGT1Nlemc3NFRUWFdkcVJ0azExSFFydXpnMHpVOXpPbFBoQWhCTW04?=
 =?utf-8?B?djNtQzZrRjhYeWFwTnNwM0tQZkttSFUzSFRGY3MrZ3ViYTJGVTVuSmpGS2Vy?=
 =?utf-8?B?OVB6WnZMWEQya1FCQkVtTkpjdzgzWFNDS2VaTGs0NUZtMFFCdGhrdk04LzJE?=
 =?utf-8?B?RVhCSDhHajA1TTVvdmlVZzAwZml4ZFVqeWpNNnhDdytBb3BiTWdqZ29SdTNJ?=
 =?utf-8?B?cnNRK1ZRN2JQVEdCeHQwajZkUVlhUER0Zkhnd2hOOWlzcmRrckJYOEZOVDZR?=
 =?utf-8?B?VUpPYzBuZlVXZWFRdUdvTGFjNFVReE8vSmxBcktLY0pRZ3JPT0ttN0JsQVp1?=
 =?utf-8?B?ekFGbmZEZHNoNDZBSnh2dzFtdUpCdjB0VDJXM3pwMkNHRmxHcU95TG8yamp0?=
 =?utf-8?B?YTFhd1VMYVhYa2ZJb0k0bFFZcElzYmlrMTZwbGR0aHRqeXExbHpKc094SldX?=
 =?utf-8?B?SnMvYlBoYW53c1RkY0lsNi9FN3NhOEhIN2MrQnpOYUdLVHRGQ2duYXdOT0Va?=
 =?utf-8?B?YzZielc5U29JWHFhd1d2MkRCY0h4YjVZd2c4R2FxcFZiZTdseXlSTVpLQUQ0?=
 =?utf-8?B?U3lxTTlHeUQ0Y0oyaWRQbzVxaDVnWWR1MnA4b1hPa2UxOFY3SmpxYUxUWENM?=
 =?utf-8?B?Uk81d0NoS0JnN1RYWWNQZ29ncC9aWWh5czZYTEQrY2VnK1diNzQxYWRqbk5C?=
 =?utf-8?B?ZmRKQ1FtcE5IYVJ0bk01OU5reWRZVGxVM1g5cHRndURTWDRzUVBzdHN3c1JQ?=
 =?utf-8?B?YXdWZWorem55WDdWUFZpRTVDcHIwOHh6SStUZ2xJc0s0N0ZNZEFhamJuaXlz?=
 =?utf-8?B?YUVyQTVOcFAyMFVBdnp3bDV6ZjJweWVJVFgrOTlaUVFnSUVIV1N3Y2xVMTZN?=
 =?utf-8?B?TU9paDRydzhjeDRMS0t6TzZjcGVzazB2VmRna21mQjNYd0g2bUlyMWZORDhQ?=
 =?utf-8?B?VDZQRTdNL1RrcFhKcjFNeERWYUVKWHBTUWtYRitwcHNOeURoOFIzcnRkdldp?=
 =?utf-8?B?dkpYVEROZk5ndThZRkplbVhqZnAvbFl0bDZ6UjcyeGlzVFhUZ0N0RjFrN09R?=
 =?utf-8?B?V25kRVl5c2g4K0c3U2UzZ1B6ZHNKM3RQVDIzQ1hVNC9sSnlnNEdRdEI0aE1P?=
 =?utf-8?B?bFZ5bC9JY1NaTWJRR3cyckpVWTBNZW11TGtoR2prWEE5NGUyaTlUVzFDUk5j?=
 =?utf-8?B?QUFQN01wRVgxT3dvSlpDeHdRRnlMdW4xME4wQlZiNEwwbDVTSGNKSXVBazVo?=
 =?utf-8?B?TCtKZ2duYjN0WUVLUUtJMy85UU9wSjZ3QzVxZm94eW16Qm5DU3B0WWEvZGJM?=
 =?utf-8?B?WTk1c0llOFhtTUx0N2lFMk5iVm1OWFl0ZUsvZHJpSGcxM2hqUWpER204SS9x?=
 =?utf-8?B?eGh2Q0ZLb0RwOTgyVEdXQ21SR3QvNWtpSTJJWlNxUmFuZnNSYWoyUkplTyts?=
 =?utf-8?B?ZHJUSkFzUU9VVkdScmpZT0RHNWZMU3FyemM5czA1VU9VamVWZExSalI5N2ZE?=
 =?utf-8?B?M0FFKzh5ckwrVTlVR1IrSVdGeGxnM3dZQlJsRDU2aXdEcUcweFY2RkxWS1pm?=
 =?utf-8?B?VTRFcFN6QWwxaDk1VHVFVGRWc2ZSeENuc0NjQlRoclFFajZibFNMSktiem9G?=
 =?utf-8?B?T1ZoZVgvNGE1aWZHRzdobUp1UzRDdmhka0lNNmdxWUJEWnFVQXBjTUFwQWNC?=
 =?utf-8?B?UmZ6WlJMakdZbTB3RW1rWFcwZm5VdHg5N0FZc3I1alJxckxEU2pBTS84UnNR?=
 =?utf-8?B?OGhWZjEvY1JHR3VzbTdrdS9ZdEZGVmpFeXBrMWxDK1RxcU1VSmJQc2RLdzJm?=
 =?utf-8?B?dldINWF3UklCeGFwT1NCR2hHdTd1U2FISFZ5MDNZU2NEWExqV254MTgzWmFV?=
 =?utf-8?B?N1NWTHNyczZlK1hjKzRpUng4d21PMW95aGZ0MExUQW9Oa0NBSlc2dGl5aFJX?=
 =?utf-8?Q?I+44W9alyfk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEpVbiswcE96R3QwUUJMNW4zWU9jWmVlcmsvQVRZMkt3eGUrMnQrTlRUUitT?=
 =?utf-8?B?Z3U3UHVzM3gvS1Y1clVqbGRnTE5sYlNOZ0xDWEhGbXdRSkpRdXZWYWQxcU96?=
 =?utf-8?B?QkNVNHpYcy9za1NVR0NZRjB4ZStCMHVHYWNDYU9PckcxOFhYL3g5RzJQb3pF?=
 =?utf-8?B?VEwyQ2gyRVRjSGY3Y0VRU3VuQlF0WmNzM1VaeGhrTVEyV0hFOERNRy9IdGNp?=
 =?utf-8?B?MTlKb0tNWVMrRC9DdU5hTkJCdTNwNXczaDJ1d3dWMDd0dWlxaGpmbERhUlJv?=
 =?utf-8?B?bUdDQUxNdnd5MzBla0liVWIzUEc1ZE9IT3oxRVNCWVhnMjBNejVuNFk4eEVQ?=
 =?utf-8?B?YUQvVG00T3FTSXo2SUdzYUc5T2pNUjBYczdYeERJSk1kcmFVOWhva0lQSS8r?=
 =?utf-8?B?WDM2ZTJHazNQR2hQb09MYnprNTFHbVdSMlFBdSt0MUd4Z1ZOdmY2M0pRT1NE?=
 =?utf-8?B?Y1dsekhSVEIxYytuSGY2b3lraFZzRXlmRW92bzVvRm5Tb0NuT1J1aXVvQlZH?=
 =?utf-8?B?bTFVZFNCRkNiMG9Yd21rdlE2WUhGVmprYUFVYStSM0NpRHdQU2tITWdvZkRF?=
 =?utf-8?B?WFNYL2thZjVqbllIajZtUC83dmtaR3dBMmRCd1M3UndBNDkzSGUyRXUwTmt3?=
 =?utf-8?B?VUVQZXp2RDAyMEdNTzNINVhxS2RDRWpKT2ZzeWxMaXZqditqR296b1F3SHV0?=
 =?utf-8?B?dCtBMWVFS0RQUXBLc2wrS0lFWFpVbnlBLzgrRndlNGwxVG9yaklDc2lhYlVD?=
 =?utf-8?B?NldkUmJ2WmJqNnVNbUN6amhKRXFBUEdQUTYvUmN2Z0pBaytEMnFKOEhGWmdj?=
 =?utf-8?B?cE51YjNRbHJjUStGQlk3WEQ5cnRVek9YSnloV3B4RktTWk5HQU8waXRxNEJQ?=
 =?utf-8?B?a2VZM1kremxrbmtDYmNmY0paMVVwd0lQSWhHWnhZM3lHWHpEUmIvRCtEd2ph?=
 =?utf-8?B?M3JVaS9OTjc0VUg2eExqUytaQ3JTTjBFM1NPaFpGSXdpbnhXUE95Mld2Sndo?=
 =?utf-8?B?bjMyeFdGUXlMVG1yTytVNjlNemJHdEpPdjFCSytLNFJ0bFRnbmpPMHlvOXlM?=
 =?utf-8?B?emV0TzJBbVAwSmpSanB0MGVMTWR4QTREUzVkbUJaaGx6ZEFLT1k3QXZwMTY0?=
 =?utf-8?B?MUJOVzQyN1VJbGpNZVo1emdrTXpaL2Zjb0s4c3F0Mis0TDFiZ2FudEtYbllq?=
 =?utf-8?B?eFY1eHFIWUROSEJ4ZThhU1hkVzA0NW5iZVN0MVlVS2duNGtxS2NCSzZoTkgz?=
 =?utf-8?B?bUZPVHlBMm50ZWkzd0h3cWt4NzhTbWhOYVgwaHErRExKRFpGRWEyZUFjeEJr?=
 =?utf-8?B?SmphSnUyUjREbjNzT0xTbnZWc3VKakxhOFExQmJGWjViY1B1dlpxRUpZWHMz?=
 =?utf-8?B?S0RlZkxsdTRmaEhSMmwzZGRnYVBOcndIdWQ3cjBMNXFKUXUwTEtEV2xvcW5L?=
 =?utf-8?B?OUNBeldVclhCL3JIQ1BTcnIzRXUyWUNVK3RwajNNYXQvVnhXRWdIZDJKRjQv?=
 =?utf-8?B?eUdmYmYwZmJXLzFhcXova1JINHBMOTdGZXBxaVJkMjRtbEtWOTRXZVpYUzNP?=
 =?utf-8?B?WGtPOFdpTms2UTFkVlRmZC9iZm14cUpmcDhnMEJ0dCtDYzdSSnI2cW9ReDBw?=
 =?utf-8?B?NG9xQWVxNThPUUNPWlVlVFdoU1p1K1ZuS2RUalBhcHdwcUI5ck5YZUFHL3ZV?=
 =?utf-8?B?b3dyK213RFFVTjB0QTN5SFlNK2NTT08rRkg1VysvbTNNbUZ2NWlUN2c3UzZr?=
 =?utf-8?B?T3F5bE1Vcmt1YmdUNzh3a0s3MnNyS1MyWUFoWURiV2R6N2JjaVgwVmpFc1k1?=
 =?utf-8?B?ZmFGNDNFSThWT3JmUmlFV1VpMThMUHM5M0lMSHRiMVdac3d1QUpqbEFleXJq?=
 =?utf-8?B?a1dlN1dZeDhqK29NK3FDdmVxL3N4aTk0aGY3OUhXZXY2MHpiMEpCejlKMFky?=
 =?utf-8?B?ZjFiRXI0dnpOdVVBbWJaekliRUEwM2NIblV5U2dQcW42emtDVEdmUzNDSkg0?=
 =?utf-8?B?TGhxT1V6SFpveFhCVy85Vm5Lb240Smg0dmM3eUdDME1Xd2ViSUtabmZlRUlD?=
 =?utf-8?B?SWRBQjdNemZDMU5UWCtBTmdXdUZiRi81TzlwVWR1TXlLQ1hTUjBuZ0J3TmpQ?=
 =?utf-8?Q?GuRW4WeWcq/9pZX/3kp/xGKam?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3ca6c8-b0e2-4d48-4b32-08ddbfc22da9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 14:58:06.9613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7gptMjgb8wAZ/ODgS+EWF9h187Y+jaoOvOphLSDmaSvr6b7TX+E7UK+VGLBt59Xz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8203
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

Hi,

On 7/10/25 16:34, Fabio Estevam wrote:
> Hi Ilias,
> 
> On Thu, Jul 10, 2025 at 11:28 AM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> 
>> Thanks I'll try to reproduce it later today and let you know. Do you
>> know if we build this defonconfig in the CI?
> 
> Yes, mx6sabresd_defconfig is built in CI, but no CI error was seen.

I have seen this with other targets too. Toolchain from binman has no issue with 
it that's why I expect it has something to with different toolchains builds.

Thanks,
Michal
