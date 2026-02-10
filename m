Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027DEE9463A
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 03:47:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F0B98388D;
	Tue, 10 Feb 2026 04:47:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="luDiEVKZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4683A83BDD; Tue, 10 Feb 2026 04:47:08 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86D058309A
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 04:47:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFtYJ9cnK42aAw49Y7LAat0ybN/n0wM2yR7LeAJDC7Xp94wY9fnugt68CBG2yITS3YutSeT5hVs1a/aVPLNuU6+P8hv7MZ56ka16gEGJaGj36R6eXWyUqLES3nibMkHod3bunxOYFi8bWUIGiMn9JCkHchN5rglp9vfGYVpZ+Egr9lmsCLgt90eH6WSauT0ZlNk+gllqxnJGfKh8c3WghxULnK+dh8aVKa/9QmdHnj0HqEVSMRPgbAueVr6dYUjK4YisYZx1JhpYv3vyXD1OKupwsdDsrDlX/REEm/uf9Cj37SFbhr7e/ZeR07HXk1o3waUytcIaa7W+ZcDQfPnI1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNnWhnDncQp4X/L5Xby67uCXwV9WnGxlGUx88i/KJvY=;
 b=zPJ5d86lzokKYsSqm4OghrQ7GP+2ZJWv8dFSx21BAyMq6L3h+KErOuhj8Xfkecppyn+WvYBMUoXVhdo7+IT2jGRkE5FAGS23NQYY2b92KEx931Paw5aZqfPywIjrsO4S17RVkzky3PgYIi334FYK1S6HYxvbJlfqfLYiKPjbFYYtlL4b6NzZFKXpJpsiuGTZ1loLONdzxK3nxHbi+Y1eGXQAJBHEZuZR6XguGUoAQrtvq3z35QJZrt9PFxPKvgNSLTFJuuvI6bzsa3+kKXIFrIll04it88aJtWngb/Gb4Fd7qkAhZFUZXMKwf1PRMqNiKq0SNOFxDAZEuSrAb7Q1Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNnWhnDncQp4X/L5Xby67uCXwV9WnGxlGUx88i/KJvY=;
 b=luDiEVKZ5UMeskAn2z5/ohRHUAHM00ZhP8woSOzRAuBegel5XGNyBmcWvHb3FC+Fq+JPdK+WXA93RJugOcdwRjlbJku4BeNLpwohvDsE5azGJXh/CvG6nK04gVxT3pr/jTfp5l3ZiDHOtNBNyvUB7s9fvrB+EcLR0cxc35cXU0a1J6MJNESnYANZgatGpVmtT88JfR2qBF98OtHWDAR3Uw0ladXf21GvPRUPqz+TrXqs/KvDOJZ+G0ilpbErnEJOL6HGOPdxFDg2QI/0AHRF+M1yLHDx2/BAjulu63maeuYil7eGfaCYXdHMU3Wj1oTwSNqdaonkCAIlne4vvZS7fA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ2PR03MB7072.namprd03.prod.outlook.com (2603:10b6:a03:500::15)
 by SA1PR03MB6580.namprd03.prod.outlook.com (2603:10b6:806:1cb::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 03:47:01 +0000
Received: from SJ2PR03MB7072.namprd03.prod.outlook.com
 ([fe80::7d1c:7fcb:cd62:6cd8]) by SJ2PR03MB7072.namprd03.prod.outlook.com
 ([fe80::7d1c:7fcb:cd62:6cd8%6]) with mapi id 15.20.9587.010; Tue, 10 Feb 2026
 03:47:01 +0000
Message-ID: <0e6c098c-5ed0-4d8d-905b-46a087f53273@altera.com>
Date: Tue, 10 Feb 2026 11:46:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/5] ddr: altera: gen5: Add DRAM size checking
To: Sune Brian <briansune@gmail.com>
Cc: "Chee, Tien Fong" <tienfong.chee@altera.com>, u-boot@lists.denx.de,
 Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Boon Khai Ng <boon.khai.ng@altera.com>
References: <20251216084623.19589-1-alif.zakuan.yuslaimi@altera.com>
 <20251216084623.19589-4-alif.zakuan.yuslaimi@altera.com>
 <fb37af46-c84c-4438-a7a9-c9476f2511f8@altera.com>
 <CAN7C2SBDat32aNjROeet5BwZTpJxN-8DOKx4gU12QY_ibbDLtg@mail.gmail.com>
 <827bec45-c680-42f6-828f-0d7020503a10@altera.com>
 <CAN7C2SAMk+y36zBAiY9UP=hVViWvPyDQgJzC0US3jFVC7N=trA@mail.gmail.com>
Content-Language: en-US
From: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <CAN7C2SAMk+y36zBAiY9UP=hVViWvPyDQgJzC0US3jFVC7N=trA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0063.apcprd02.prod.outlook.com
 (2603:1096:4:54::27) To SJ2PR03MB7072.namprd03.prod.outlook.com
 (2603:10b6:a03:500::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR03MB7072:EE_|SA1PR03MB6580:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e76ed45-feac-4863-7fea-08de68570c17
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHFNWUVMcjU2Y1BmNW1STWdtSnhwaXVabVhiNXVWTlBRUzhXY3lFS0w2K1dP?=
 =?utf-8?B?RG1FUE5EK3g4VVZ0dmxwc0NDZVJCcy9JR3FFNnpMNVM3eDJMZU5ZYUlBMU13?=
 =?utf-8?B?cStJemZ3UTBGSWMxWDJNRk1KWEs3bittSFg0S2lCbk5rcjI5VnhOSmprYWdR?=
 =?utf-8?B?eS9DbUVDRjNqYklOOW5mVFJoVmtDZjlCTGhnRmo3Z3lza2ljVHoveU52UEp5?=
 =?utf-8?B?NVZRWkp1MHdYZWo1MXNJbmF2cHZyMS9NWFVaWFhkM2Z1TkQrWThxeGZXZWFN?=
 =?utf-8?B?RFBvNTlSalFsbUVSZXUwWW12Mkp6QkNDNXhDYjR0LzFDbC9YWW5xQnVEcGpN?=
 =?utf-8?B?em5NMzhoeG9uNGlqU0F6MzFKd0VhUzhQMHNnVEwyelovaEhxckN2cFJGRXh3?=
 =?utf-8?B?d29tRy9ZMlEraDRISnFwRkF1azZHekdJb3RwQXBGTEN1VGhTZ3F4WFRvNHR6?=
 =?utf-8?B?dXZNOW5GekJnYmV5d2xjNWN6ZU1KOFZmOXloKzcvWnNoRlRLb3NJVUVPSzkv?=
 =?utf-8?B?cUZTL3VmUnZhSWhOVitxZ0NaSlMraldINkYyUTBOdWZzVEtUZWpjVHp6UWxQ?=
 =?utf-8?B?aTc4M0VzNnRIcDdzeE9Qc3pYZElIOUxyT2xDT0orTUJUYytuVmFqVnM0VDVB?=
 =?utf-8?B?L2lwOWxrSFFKdnJjZlpGeDIydVhmRklVbzdRQXFONVV1MXVFZXRwanlmVlhN?=
 =?utf-8?B?K1JEZUxKNUtpNWJuRzVrUVVFb2FJS1QyM1I5dWdJOUVQM2o1M3Jham5HSE4z?=
 =?utf-8?B?WVFlV2p3c3d1aE40YlRzQkw2VHBCdUYzcGtyc0MyWjB3cHROV25wb09LTHJa?=
 =?utf-8?B?UmdhMmZwcVlKVFMyZUZjODNVblRqT0RFRE8wVG84NGlFNmpqNzA2dWMrdlh3?=
 =?utf-8?B?eUJycEVsYWVRZ0h0NkwyVlV6Q1M0WGNhNWtIdFo2NlZ2bnY1L2VhVGdqZTls?=
 =?utf-8?B?R3V2QzhZK3B6TWxjTUVCNzEzWDFNdnlzNElCS0ZJOTcwakVkN01tRHF6NEkw?=
 =?utf-8?B?ZGxqR2tRSGpqeWpWVHVySU1MSENmOXhJZUMyMkdBV0ZJTitnamlhZ3BuYlpp?=
 =?utf-8?B?alBLMG5zZGNUdmdWMHk2VzRaTDFkU0dObENuYmlDYzF4c0xTb1c2SWx0WWpZ?=
 =?utf-8?B?N1E2QTZINEdUKzJKd1kxQXJ2NHBxTTVIa3ZLWTV6cVZDSnJ6RWVDTFR5LzNp?=
 =?utf-8?B?Um5XV1hHS0Y4NVJ2eTExN21iMWxITFlUYjNUeXhUT3ZoczFZM2l5K1gzeWg2?=
 =?utf-8?B?d2swMnJQZk96eU1YOTNrOUs3bDBhbkpDYkplVGxrQW9nb0E3VmFzQ29hbTdX?=
 =?utf-8?B?NysxSkdoMzNjbG1wcXZ1REgzMjdtVlZZSW8wd2YzMVdpaGVTeWc0YUVpclln?=
 =?utf-8?B?cWhGdnplWjZnWHdKdzROTTRrZTRXRHUwRGJkaHhsdVloQmdKTGIwVGdHT0R4?=
 =?utf-8?B?bm5UODEyd0w3WGJGRE1meGRPYXpmczBVamt5L3FyTGJmUkdGcjdFcTVQQTBh?=
 =?utf-8?B?VUJFVXJkNVNsZDVxOXRFbWJXNHVFdmRLTzJQSTQ5VUFtWk14RG1Ma0Rid2tj?=
 =?utf-8?B?SW5PdlJQdWYzSG0vWGYvL1pIVmFWUE5OZFIvR1p4cU5WbzUwdSt1V2dKYkhO?=
 =?utf-8?B?QUhZQ1NFOVI5VjY1VHNQOVdDYS9NcWE2M255WlE5cjdJYnhPRk1DM3M5RWhk?=
 =?utf-8?B?QmE5REh4Tm94SkJ5NWpLbGhYZEd1RlRtTjZSTTRId1JFOVFSWENkMWlubDRE?=
 =?utf-8?B?UkVNU3VTMUFDbExDR0hPRGErTVFiS29kRVdjV3hPK0V4dEN3TWhLbWY5WXV1?=
 =?utf-8?B?eDNOaEROUWgwb3BiUkVTS05xSEtkeloyZGJYajNXZStxd1JHakVDWS9mRTNL?=
 =?utf-8?B?elVTQWRxMmU2Zko0WHdTY0ZNQnVTbFFmM3B2M2hrSDFaSGRUTDZsaFRZTUo3?=
 =?utf-8?B?aGdPN3g4R1pwaENsQVhnYzRCNURzdFFacG44bVpLZWF5YzQ2YTRXZ0tZY21G?=
 =?utf-8?B?dVpXNCsrckdTeTVFdjRwUmh3NC9GbzArZGxBSXFQMUUzZFVhYlNON2NiSnNZ?=
 =?utf-8?Q?AwfT3r?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR03MB7072.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXl6aGNDNk9tRUNmMnZ0RS9RaGlTOUJ6d0RmYlZIS1FZM1FoM2VRNEVhcU9I?=
 =?utf-8?B?Q1BHSE80VXNCalZzSSt1bzd6MjFZc2VJUjVEZEdCTzdRclZvUUF2T0pRdzlI?=
 =?utf-8?B?TjlndFJlSWtDM0Q5WUtKK2dRVUExcEY0MnhMSjFKYW5xV0Nab3dJQ2FhdXc2?=
 =?utf-8?B?MkwvZ255L0dMOEV2Slk2SHV3Y1ZDRHBpNE5zVDdkS2NoN2RQUTV4MDBRenJB?=
 =?utf-8?B?MkJtdmdkbUdWZ2FGd29kVUdsQ1VhY1BheENhbkhJUENacXV1M3BtZURDM0RT?=
 =?utf-8?B?d2dFN1RZMmpJWElYZFhRbjYvbkVLSXhtWW9ha0x3ZFZOMERyWXJ1RmJwcE1u?=
 =?utf-8?B?MzYwVTQwMFgweUJzYXpTeGovbU01UUVscEkxcFJSUFVGcWlBc1NNNFVxTlVG?=
 =?utf-8?B?UlhxUFF3aE16a3l4WXZrTVJ5SDNXQko4K0g5dm5YVThueWdXdWg1ZHB5M3dD?=
 =?utf-8?B?aUx4TGFReVo2ZUVsWFVnNHg4NWEvaFdmNWxMYjh3RjdIOWZZaWhxQ3A2Rk5o?=
 =?utf-8?B?RW5VbHIxUDNKb3J6bHlweGNWK1FhcVVZZkJZeGhvdjlnQlRydEh6SnNlZG9u?=
 =?utf-8?B?SXA3VjdHOFpZRG1IYTFxRmlUdjZKU3lKZWtsRzZPaTl0YlV0MjVLOHk4MnBO?=
 =?utf-8?B?L25TbUlYM01HZUhzRU1keGRhcVdXWHVJOFhGR2NETmQzVnY2ZCtMTHRPRlhB?=
 =?utf-8?B?NjZjVy83elFoTjZGMVlUY0RJK2cyczhMeVU1R05vK2wwZjJuNjN6bUNNdU9i?=
 =?utf-8?B?QVdVZERuWC9weDRhQXBrb0lPTXF0VjlZci9VQzRjSjQvYmxaVHl0bmxseEZK?=
 =?utf-8?B?bmc2aFlXV1k1V1BDYTFBZVprYlJ2YjIyeFNrbnJhRUhZR3JodXIxb0N1Mm15?=
 =?utf-8?B?eFhncjlKTG9yU2VmbS9lZzNHeUdSZ0s5VnN6L0RiTUt6Q3pwek1DS0xOWDcz?=
 =?utf-8?B?cWZWb0ozbTBhOFNwWU8rZGY5cGZZOEhMTXVQdU1JYmcvOGdqZ3kzaHIrV3I4?=
 =?utf-8?B?dGlha3NkaXNGcWpQTEI2aXpXZVlwNk91ZWowdEJEYmJ2RVVmcGVudDZLZFhB?=
 =?utf-8?B?OWFBdzVRY290QzhyMFF6V2tVKzhiTEd2MzlxVit2dERXZE5oallXd2JTQ0o2?=
 =?utf-8?B?eituaVBuYndaSS9zNFkyNzZuL1B0TUJuak5ZNVlZYlg4MW9YU2EwWUJJK3Y2?=
 =?utf-8?B?VHR0WDhpbEtNUHlWVWY0NW51REEzbXQxb0VaTlFVLzhvRjFpUVIwV2hLUTBs?=
 =?utf-8?B?WEllUGsvR0hicjFwZE5DSWF3MXdaOE44bzAyMitNaHc5UThtMlBoc2IxVGw4?=
 =?utf-8?B?NXNvU3RSem5DTHZuZ2pDdUNIY2EzOTRxa1JvWURkRktqbFNVWEVxY1FPU1lF?=
 =?utf-8?B?YVN5UFpRSXUzcGZRVEd2ZWU0aXFNNW4rR09tYk1XRGVsdUhIUlYrU2E3M0hz?=
 =?utf-8?B?Sy9ObnFwRDVkK2RGZ3JIRkJCWXhpd01XeUI3VVl0VldqUmtYM0ZsUmYySktG?=
 =?utf-8?B?eWs5NWN4dDZsN0c2WFZ5anVENEZKVGh3cEgyMm9GaGlTTlJHSzJsZVhkY2Ra?=
 =?utf-8?B?ckZuMFlhdDJ4c3MwTXRrU2lRVWhtUmlOVVR3U0tZOUIvakJZWCtRRzVaMSsz?=
 =?utf-8?B?NzF2TzZSTmtjWWxzR29OaFpQQytGMjJPRncyd1NpQ0hpbjJpTGJnOWMrbWhq?=
 =?utf-8?B?MlAyeVZhNFNZcDQ3b1o3ZDBHZTg4RG1uQkVaMVpOL3BYN2M4RXRYNS9wajRr?=
 =?utf-8?B?c3JSZGxXbXp2b3QwTTNCTlRGR0d5d1ZXSkN0enVtM0VxZVJtdE5xSDNSa3d3?=
 =?utf-8?B?MEdxK2I3cDQ2UVVnNCt3UWNMYzlDeTcvUVN1OGpCeEozR3BzdEdzdUxGbUIw?=
 =?utf-8?B?ZW4xUXhpdDJoOGZtMkNDVE9VWndwQVBIeG13OEZQWm9GdXBtaU5sbFZKUElL?=
 =?utf-8?B?VTVPaUo1T0lySWZ2aEVBUHJEYUd0aVZoNHZ0bkxoQWJEYWw0TE94b1lhVVNZ?=
 =?utf-8?B?NGxaL1ZZYXhLeU5GRndVS0huSlg4MnpHRXVUR2luQ3FYYUdWc2JHbjAwRE1N?=
 =?utf-8?B?ei9RaFNZN0VvOWM2eisvRWpPR1BUeFNNRC9CWTRtcTFzTFI5NkVPRmZlYVk4?=
 =?utf-8?B?UTZRUnU0YnlXaHdJc1FRcmNCR1ZXaE04RDNpNzVCWXV0TEpHd0JWVG56UHZ1?=
 =?utf-8?B?TENCQzZGYVhlTUw0emxyM2U3MGdkYmphVFIrYjZ4cjROREFodnVFL3BySmxa?=
 =?utf-8?B?NUVWcjA0ejNQWndLY2xxVFNxR294YlF6R1BNQ2NQZnlacEVFRWJZUE1hWENh?=
 =?utf-8?B?OTJHbG1scndXRVM4TGxuNzZUZ1pQTDJlRkwyODRNRGQzOU9neGgvVEVjZU5I?=
 =?utf-8?Q?EciMgdeVd9/TnZMc=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e76ed45-feac-4863-7fea-08de68570c17
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR03MB7072.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 03:47:01.4586 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wF8y9zWQbmN/p6PhIa7ub2eWCIY4paaKHvciy8Tx8AC9G429hdaj0vICPcek+HwGZTDBaldQuFOL2TXZtfF0GUZZ1ambDJk/rhm1BqwehqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6580
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



On 6/2/2026 3:50 pm, Sune Brian wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
> 
> On Fri, Feb 6, 2026 at 11:33 AM Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@altera.com> wrote:
>>
>>
>>
>> On 6/2/2026 3:17 am, Sune Brian wrote:
>>> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>>>
>>> On Tue, Jan 27, 2026 at 4:03 PM Chee, Tien Fong
>>> <tienfong.chee@altera.com> wrote:
>>>>
>>>>
>>>> On 16/12/2025 4:46 pm, alif.zakuan.yuslaimi@altera.com wrote:
>>>>> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>>>>
>>>>> Add DRAM size checking compare between size from device tree and actual
>>>>> hardware.
>>>>>
>>>>> Trigger hang if DRAM size from device tree is greater than actual hardware.
>>>>> Display warning message if DRAM size mismatch between device tree and
>>>>> actual hardware.
>>>>>
>>>>> get_ram_size() uses size from device tree. So, it has consistency with
>>>>> other device families.
>>>>>
>>>>> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>>>> ---
>>>>>     drivers/ddr/altera/sdram_gen5.c | 20 +++++++++++++++++++-
>>>>>     1 file changed, 19 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/ddr/altera/sdram_gen5.c b/drivers/ddr/altera/sdram_gen5.c
>>>>> index 7a0a043557b..d5892850da7 100644
>>>>> --- a/drivers/ddr/altera/sdram_gen5.c
>>>>> +++ b/drivers/ddr/altera/sdram_gen5.c
>>>>> @@ -6,6 +6,7 @@
>>>>>     #include <dm.h>
>>>>>     #include <errno.h>
>>>>>     #include <div64.h>
>>>>> +#include <hang.h>
>>>>>     #include <init.h>
>>>>>     #include <log.h>
>>>>>     #include <ram.h>
>>>>> @@ -615,6 +616,22 @@ static int altera_gen5_sdram_probe(struct udevice *dev)
>>>>>         sdram_size = sdram_calculate_size(sdr_ctrl);
>>>>>         debug("SDRAM: %ld MiB\n", sdram_size >> 20);
>>>>>
>>>>> +     /* setup the dram info within bd */
>>>>> +     dram_init_banksize();
>>>>> +
>>>>> +     if (sdram_size != gd->bd->bi_dram[0].size) {
>>>>> +             printf("DDR: Warning: DRAM size from device tree (%d MiB)\n",
>>>>> +                    (u32)(gd->bd->bi_dram[0].size >> 20));
>>>>> +             printf(" mismatch with hardware (%d MiB).\n",
>>>>> +                    (u32)(sdram_size >> 20));
>>>>> +     }
>>>>> +
>>>>> +     if (gd->bd->bi_dram[0].size > sdram_size) {
>>>>> +             printf("DDR: Error: DRAM size from device tree is greater\n");
>>>>> +             printf(" than hardware size.\n");
>>>>> +             hang();
>>>>> +     }
>>>>> +
>>>>>         if (sdram_is_ecc_enabled(sdr_ctrl)) {
>>>>>                 /* Must set USEECCASDATA to 0 if ECC is enabled */
>>>>>                 clrbits_le32(&sdr_ctrl->static_cfg,
>>>>> @@ -623,7 +640,8 @@ static int altera_gen5_sdram_probe(struct udevice *dev)
>>>>>         }
>>>>>
>>>>>         /* Sanity check ensure correct SDRAM size specified */
>>>>> -     if (get_ram_size(0, sdram_size) != sdram_size) {
>>>>> +     if (get_ram_size(0, gd->bd->bi_dram[0].size) !=
>>>>> +                      gd->bd->bi_dram[0].size) {
>>>>>                 puts("SDRAM size check failed!\n");
>>>>>                 goto failed;
>>>>>         }
>>>>
>>>>
>>>> Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>
>>>
>>> Hi T.F. and Alif,
>>>
>>> I know you reviewed the code.
>>> But I am not sure on 2GB w/o ECC run it will pass SPL stage.
>>> However when applied to the patch 2GB w/ ECC it does not pass SPL.
>>> I would like to confirm that ARM GDB cannot be used to test ECC or not?
>>> As I do see it involved D-Cache on
>>>
>>> "drivers/ddr/altera/sdram_soc32.c"
>>>
>>> Thanks,
>>> Brian
>>>
>>
>> Hi Brian,
>>
>> The code has been tested with RAM boot via ARM debugger on our Cyclone V
>> SOC Development Board with ECC enabled, we are able to boot up to Linux
>> successfully.
>>
>> Our board specs can be found here -
>> https://www.rocketboards.org/foswiki/Documentation/AlteraSoCDevelopmentBoard
>>
>> You can also refer our documentation here on running U-Boot with ARM
>> debugger -
>> https://altera-fpga.github.io/rel-25.1/embedded-designs/cyclone-v/sx/soc/boot-examples/ug-linux-boot-cve-soc/#appendix-2-run-u-boot-with-the-debugger-from-command-line
>>
> 
> 
> Hi Alif,
> 
> Yes, if you use DS5 to run this patch series it will properly boot on
> a 2GB case.
> Our side changed to use openocd with GDB.
> In that case it will simply be stuck on the "DDRCAL: Scrubbing ECC RAM".
> 
> Thanks,
> Brian
> 
> Under DS5 boot message shows ECC init passed.
> 
> U-Boot SPL 2026.04-rc1-00154-gb5213bbfdcb1-dirty (Feb 06 2026 - 15:43:21 +0800)
> DDRCAL: Scrubbing ECC RAM (2048 MiB).
> DDRCAL: SDRAM-ECC initialized success with 1051 ms
> 
> 
> U-Boot 2026.04-rc1-00154-gb5213bbfdcb1-dirty (Feb 06 2026 - 15:43:21 +0800)
> 
> CPU:   Altera SoCFPGA Platform
> FPGA:  Altera Cyclone V, SE/A6 or SX/C6 or ST/D6, version 0x0
> BOOT:  QSPI Flash (3.0V)
> DRAM:  2 GiB
> Core:  32 devices, 17 uclasses, devicetree: separate
> MMC:   dwmmc0@ff704000: 0
> Loading Environment from MMC... Card did not respond to voltage select! : -110
> *** Warning - No block device, using default environment
> 
> In:    serial
> Out:   serial
> Err:   serial
> Model: Cyclone V-5CSXF6C6U23
> Net:   Could not get PHY for ethernet@ff702000: addr -1
> No ethernet found.
> 
> Hit any key to stop autoboot: 0
> 
Thanks for sharing your test case, Brian.

I now see delta between our test cases.
This is most likely because OpenOCD reads DDR before ECC is fully 
initialized, which will cause DDR controller to return error, and 
causing the hang in during DDR init.

Another extra complication is added as dcache is enabled during DDR init 
for performance. As the CPU writes to cache only, DDR is not updated, 
and ECC is not generated yet. As OpenOCD tries to bypass the cache and 
reads the stale DDR directly with the invalid ECC, it will throw error 
and cause the hang.

Arm DS avoids reading unitialized memory and does not poll the DDR 
constantly, hence this is why the issue is not observed on ARM DS.

You can try to boot without ECC enabled in the hardware, but still keep 
dcache enabled with OpenOCD to confirm that this is not a software issue.

Thanks,
Alif
> 
>> Thanks,
>> Alif
>>
>>>>
>>>> Best regards,
>>>> Tien Fong
>>>>
>>

