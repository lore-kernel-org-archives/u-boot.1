Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4913DC87FD2
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 12:46:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CBFA8329B;
	Mon, 11 Aug 2025 14:46:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="GblGaxAb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 247F9832BC; Mon, 11 Aug 2025 14:46:54 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34D1D83291
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 14:46:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yY755Db7v779e/qxBoT4lA35udFk6mc81jfa6jwD7tGiQ6KGW/qwQ/NXQcfa+eUdg5OEw+W5xTNCIlQ8afzL5T0fJ660Z07sh21wRGIhNByqyht78nmrDOfYkZV1XiXaGt6Pxiv/ml0VV0pE6aSoVBYv+v/2nUfD4MHhM2iGhpRZGZdU+0Y2ORyRnh4AnImFjmuBczU6iCzI5XELT6uo/5UElXfEJiTbhQLKRlPx+RrcmTKGeXyzgOsiUhvNJ8HGFzPkzGA6hX0VejBXeNaTEE5U8Owdh1aVP0uhixX3w6ks/jb4utadmz9Ftf+0mgLcNININypEuoFySzyzsGrBvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMM2Q01ZAxgskdRJl8CfOy0fNT3/ndVk54WGHRWyYUw=;
 b=vedDi0HspXyhGQBqyYMwE7VCo84RdDINYK+Ku1x+Bqw0Scs6LPVL3gQ7ORXvcWlSw+ls5g4XNZDqU4mgZRHIRlhF6MA6L4BpeT9PkgVedo62sji0JCvJVXWYv46nT0ExA/cDfQupovMw4SDFoRjlCRpz4fyQ5ePKYguvPn+1ArOrV3IWy7RbTomwYUZS/wdF8bLTjo4QQ2Op7iGL7/PTY2fdB1CbegWp/g3Kjabh041wXxE/s0l6ZbixGDcc9EBkroH/m8ev4kahAENLOW4S/C+G7JD0rHLS01xTZQsoxlw5kJx+P2OWOTLbykIYQ7xeZKB/InTCqajqGq7lhqRXaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMM2Q01ZAxgskdRJl8CfOy0fNT3/ndVk54WGHRWyYUw=;
 b=GblGaxAbWwyKtulhhWYGuO1gvQTWiR3sHNN4QOkbyuTLBpGqmI9X0oipOvN8IfeFt+frwQk4GIJ6D5l7x1QmNLmgvxfGgyKXCyM0EAMUba5XRVlrW25UvyK7VB6eAUzTvZYZHEl9u0CH1KOKfVC61+WtavwTXst+/vB+h2lXPVM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA2PR04MB10375.eurprd04.prod.outlook.com (2603:10a6:102:41a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.12; Mon, 11 Aug
 2025 12:46:50 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.9031.011; Mon, 11 Aug 2025
 12:46:50 +0000
Message-ID: <101c443f-9f91-40f9-a4b3-e537a5743528@cherry.de>
Date: Mon, 11 Aug 2025 14:46:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: renesas: r8a779g3: Invert microSD voltage
 selector on Retronix R-Car V4H Sparrow Hawk EVTB1
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
References: <20250806005933.284462-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250806005933.284462-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0201.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::10) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA2PR04MB10375:EE_
X-MS-Office365-Filtering-Correlation-Id: 26b4c31c-e9d7-4801-1127-08ddd8d52433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2xGeHg1TVFUeWMrMGZOakVmaUxtdkEvL2ZyQVdyTEw2YUEyKzYwRW5YaHVX?=
 =?utf-8?B?UDlzdmxzRFo0a09aZ0NPb0I3Z2lYeDZkR1lWdy9XWlJrL1VzZ1J0WVJEZ2N5?=
 =?utf-8?B?ZjVWSTFYUnhnYTdzNlZpZlVESmtjYStSSW0weWJha0ljbTlnR1NzcTdiTG9y?=
 =?utf-8?B?ckVKWXZlT1JNR1FDbjFDaU1TellXZjBHK21QTXhMRXZUWnUvOXYrYy90VERT?=
 =?utf-8?B?OGt6WjlHREVzMFdXVTdMTncrUXpnTGVZRzRpM0N0Qnh0TVdlbUJwWWhGQURZ?=
 =?utf-8?B?WHhPbm4yOExGaFBCVlp1ZStYRDFIaSs5UW5yL2tLaFF3SFk4MTNVenVhUWc3?=
 =?utf-8?B?S1dsRlRUbzZxRGdSSVM5aWpMVFRHZmZEL0RJWG95QUluYlNxSUhybnBKejVV?=
 =?utf-8?B?cVR1U1VHNndLY056VWttOWJ0cGFYMlBqcW16MUZYOE0zNXE1NHgyQzlUbVZZ?=
 =?utf-8?B?L2Jab0FkVzVLNE03aUEwUnBtZkx5UFJMcVJCMi9LWk1QVXhkc1VWaE5rRlRu?=
 =?utf-8?B?QkY5MkNFMzVpV1VlVEpPZVdXZ0U4L0NwQ1IwUnozY2Vob1ZnR0UyRU1QREFp?=
 =?utf-8?B?em9iNHJBRGNsWE5hcldSMTZBQ2JiTHVPTVlqcU1IV256U0dhYXplYlVOMjFs?=
 =?utf-8?B?Y1JFYlVXNXdmalYxWUJXOGpRV1JDcXpwYUF5Y1puRTlJM3JCKzUxSTlsUDFk?=
 =?utf-8?B?NWdvTFd4N2hmY2xXbEtDVGFCTUE5UWhvV0tlbWJIRFN5Njl3UWNMM2RWdWlt?=
 =?utf-8?B?a0JEWUo3RFJGUHpZL0hmS1BHVW9mWURFQnVIR2tjb0todFBYMlliTUt3UUFt?=
 =?utf-8?B?b3pXTEQ1MjRwcVZPY0djWmpWM3ZNUnRpRUhaUnlpM1d3azhCREs2dGQvUXQ0?=
 =?utf-8?B?d1JlcVovZ3U2TlQ1U1ZIdlp5M1ptc0lsZ3FkTGNkL3JMdklEUHE1QnQ2cVFl?=
 =?utf-8?B?MUpBSDF0TmRIMnYvTmxrajBvallSd2lrTEp4aExHWjdYdVRUeHVkeGdoS0t2?=
 =?utf-8?B?SDc0WmIwWno5OFdmY0VleldWUG1sNkdWOE9McFB5TUQ0MmFnT3ZlL0VMVnBy?=
 =?utf-8?B?dkdlSENHYjhJRk9RcDZ3MllBbXRwN2d0SkJLZHR4d1BKMWR1RUZGYi9NcmNI?=
 =?utf-8?B?ajRoSWFJT1Q2VnBoemM2cWJjak44T0VCdFdzdG42RUd3c1hKY3JJOGMvQ095?=
 =?utf-8?B?ZEhMbG16WGl0d3lRTWl4d2JmdVBTS2g0RGJMRHI0emVpdHJ1TDJwTjdoTWpQ?=
 =?utf-8?B?ZEVlV1h2RWZHeDZ4eFhvdUpTcVAyM3Z1NmJNb2FwcWZPa1ZVSzR2Q081QmUw?=
 =?utf-8?B?YTVQd0Q0UU10cER1a2Y1TElzQWdvL0Jmb2UyTTNOTTU5bzNzc2E1Z0tmZ2ZN?=
 =?utf-8?B?cE9hWU45Y1ZJVVdyRWM4SjUwbWs4QmtFeE5nL1VubXQxVTFDWXZ5ajEwSHpU?=
 =?utf-8?B?QzhXNE9lUENqT09NQXpEOS9nNzI1Y29JL1Mvdk9wVjMzN0JWaHQwTGF2WC9G?=
 =?utf-8?B?Um5RczJWOHVRWjdEZDZXdnIyYktqclRjNU5tNnFBMmk2eVdCOHZieWZsQVJJ?=
 =?utf-8?B?QmJvUDZWNXdhUi9YcHlSY2pOOHk1dnVhYW5WWVlJUFphQkVteURWUnZLajgw?=
 =?utf-8?B?TWovc2l5YmhxTjhkSTl6WUdpeWx0NlVJOFZXbDN2TjRNSnFzb0plVThFTmM3?=
 =?utf-8?B?VTgxQWRkMDk3VHdvOWF1Ry9oU0dTZmlKejFmRzlLWmdVSXRuU3pxRmZFOFhC?=
 =?utf-8?B?U3BPYVM4cXpSc3oyQUg4MUROTTlRZzlYV1VwWjVsYUkrekZOOE90RzcwS21D?=
 =?utf-8?B?cG4rMVMzTHVzNU9idGFSeFFNWkpwOEl2a3NKdXBNQ1VhWDRxTzVJQXYyNGk5?=
 =?utf-8?B?VC9Nd3JpOFdUSldIQ0NHdjdjMHBRUURIMkhMOC9xTG9lZzZkOHd4UHVTNVBI?=
 =?utf-8?Q?bOYy39RJ1sw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFRYeHYxN0JYNDhsOURjYy9QYTg1MjhvVHljZWc4TS9Hd05wRGk1K3UzbUVI?=
 =?utf-8?B?UndVd1FWeSs1eDE1N2U1ZlczTndVd3h6OHl6bWtIVzk3UGxEZFJSTk5LOTh2?=
 =?utf-8?B?blIwUFNEZVJEMjlobVdYQ3R0cDVGdjNWTmcxOHdUK20xMXNqREQzZ2NWN0w5?=
 =?utf-8?B?OTdpOXE3cDhwTS9RbHkxb2dteG5zTTZwK083c2JNeXZBeHdzZzBCR0hGTHVE?=
 =?utf-8?B?OENWWEpiK2I0V2pNY2pSWmJLalFiVWxwQzl4VlJyNXROYXRqODM5Wkp4UUdF?=
 =?utf-8?B?WnVwakZLVC9ibjdCbml0UkhVTm4vVmJ6WWxteUl6UWI3ZVZSQmZpeWZoaUxF?=
 =?utf-8?B?TlZNYUdoQU83WVQ2L09vL2ZiUWplTm5pNDRLU3lQb25XOC9xRE1TNE1SZUZl?=
 =?utf-8?B?ek1WbTdlS3BoOHR0eUZ0OEY0RnJ4YlUvWmE4YTF4M3d0UjRQTXF0VkdOaTBT?=
 =?utf-8?B?YUEyNTdXNlZXK0ludE5ncllRVTRmTlpia2RocXcyMENoWUQrVTFnN1JwZkZ2?=
 =?utf-8?B?Y0szWmd4SThTanBqRDNoYkV5RkFYeU1wb1dMOUI4RW9xZzZONmwxVy9XZ01W?=
 =?utf-8?B?amJ1K0ZsVmNmVWdIOWZrVmZ0VE5RNDEyOThyWm5xdXBnakxnbGJNOUlYdy9s?=
 =?utf-8?B?TEp1RHVoNytjRnBTd291TktoWFJkdmo1UStKeWY2T2QxMUZxOWpVcERNLy8r?=
 =?utf-8?B?N2h5emxKbUFmL2ZCRGhyT0pMMlc4RUFjRnZ5S3J6aXpTdUpXVFQrR0dFYm5w?=
 =?utf-8?B?R2w0ZS8wSVMyazNEU21idzU4RVhKYWtlZUlBRHRQQXRwSzIySUxQRloxajBP?=
 =?utf-8?B?VHNWNFljdUswd0MyVGFvVllIbGEzYkVkak8ycnp5TzJxaUV6QjhtSnZiaEU4?=
 =?utf-8?B?L2lCNkx4cng1QkNsMStkV3JCYWorcXZoM1FIWjFPckhXZnF3RjJYWUZIMytW?=
 =?utf-8?B?ZW5FOWs4ZGhzbTA4dmRGdU5telZ0dEpPTlZmZG03UjFObEFtRENoT2ZXdkJr?=
 =?utf-8?B?RzhqYXNFK040ajIwdVc4VnJiQmdRYXJSNFhyeGZHUlJlRVBTK1pEamo1UGpy?=
 =?utf-8?B?QUJWNzRQaHBLMnJJcEwrTnh4SytZNTkwV21rbSt6S3FQdlcyaUpLMUQvMjUz?=
 =?utf-8?B?WHdHNGdINWl3MytDeFBuUytLZmFDT09ibGtuMGg1TCtUbVNjZEVxVHdLcnV1?=
 =?utf-8?B?eXlOdnVWRk54SGxoWUFxZGpMMXNIenJRVlBsbnJMcnJIdkhOL2ZBNW5DWU5Q?=
 =?utf-8?B?d2hCTy8rT1ZocGZJbFpjZ1hPZ21nWVliZUJ4U1ViLytGY3I0K0FWYjBLY1U2?=
 =?utf-8?B?WGFUNzJ2UlBhQ0xjRnFKaVIvNngwYktPaFNzYkx5emR1TGwzNDI5OVJ3aGI4?=
 =?utf-8?B?YmNPTnArNGs5VXJNc3ZDSmJLcUxjbm4xSWhDbVZFWGxLQ2Z4dWdHcG5ENlRx?=
 =?utf-8?B?RGUzRDk3dVIyWm9MVEdES0FGUHE4UHVESDBYRVZrenZaajZXRS9TaHRjZEtt?=
 =?utf-8?B?cmlNZEVvNUg5RkNIanc0TENyUHFzVVh4U0RmZytTMVZKWldBMVZUN0dNb3BZ?=
 =?utf-8?B?QXkzZ2dFb0ZOc0p1NW1XSHpGTWtQZzVXekFlWXlHc21lY0Rub1loYjltdU5r?=
 =?utf-8?B?dzQyUFhjRnk5SWtwRHEyUS8xU1d2SmNnQllXRkF6Q2xvTEsxZkI1L09hM0Na?=
 =?utf-8?B?a25BNUZrekhxeTNTOUdoZWZXV2ptdzN5ZDV3SkNoSGY3YUVCam1Jb2xHRXM5?=
 =?utf-8?B?REhlNVp0QzZOMTU0OXNsREc3WHBWTFBSMjNQZHI4S2ZJWFpwMDIrWVNvVHpE?=
 =?utf-8?B?Q2NvOUlJSlpzMmdsMTJGWHZHd1VZdmNoeDB0Z1d5ejV3WDdHOGo3Zll3ZmN3?=
 =?utf-8?B?U3FqdlNleWF4Q1hEUnJFQ0oyVi9nODRkc0R4MEI4Sm8vT3JQT1BMa2w5dld0?=
 =?utf-8?B?azR6N095d2dBVFAyVWJZVnBOL0hKMVVkQVpvclN1dllwSTQrYXZIbUVVQUxE?=
 =?utf-8?B?OUV4SUxXckFhUnZ3dVFUS1RxQlRlMmFIVmNPYmtsbVREMUlHUW5PbGovaVJ6?=
 =?utf-8?B?TkdVSnRsbUp6Z1FRK1BwdWp1M1VGUFZyQ25ISzRBcndUZy9qN2ZHOXFWcVVE?=
 =?utf-8?B?d0pORDJ2bnJCelVsanZPQks0aEcvZG54a1N3ZDhtRGFGK2pRZW5jYm5UOVlB?=
 =?utf-8?B?SHAzcGZUOE9vQ1VQWlpRa2wzTnBha2w3alhwMTJKYjgxRVBONmtnOWYxb1VZ?=
 =?utf-8?B?SEkwMmxoVUcxNkRFQXRFcGVpMWRBPT0=?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b4c31c-e9d7-4801-1127-08ddd8d52433
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 12:46:50.4812 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Asfh78astZejMtkAlGgSn4aVTa0tT/B5nELov83TcKII3hfSOYY8xMe+bKUpDImKAptQFbN7N4Oqf7YcVdIfizdkPItzwjISASTGc415l4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10375
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

Hi Marek,

On 8/6/25 2:59 AM, Marek Vasut wrote:
> Invert the polarity of microSD voltage selector on Retronix R-Car V4H
> Sparrow Hawk board. The voltage selector was not populated on prototype
> EVTA1 boards, and is implemented slightly different on EVTB1 boards. As
> the EVTA1 boards are from a limited run and generally not available,
> update the DT to make it compatible with EVTB1 microSD voltage selector.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

NACK. We only take cherry-picks in dts/upstream. Use 
tools/update-subtree.sh to cherry-pick the commit once merged in 
devicetree-rebasing git repo upstream.

You should however be able to patch the property this a -u-boot.dtsi 
counterpart of the upstream DT if you really cannot wait. Have you tried 
that already?

Cheers,
Quentin
