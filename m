Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE681606A329
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 10:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OmlWAQOg;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=UnpW2vub
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9636F405CD;
	Mon, 16 Nov 2026 10:58:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y4OC3_AxLbxJ; Mon, 16 Nov 2026 10:58:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EE664405CF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794826730;
	b=JkGrUyanGTpyN9T/HEqaf7JgqWt6Lg1jUu/r+QSiWdIOV/a2gzrVzm0WYPc6EGYTi/yo
	 9M895AONi1KIpUPboFaNkSI5LtGFobzDMmyYotffgku4y3gSgpVMwnlf8ZoPe0jvVuAnQ
	 W3vQ5CkoBV8Ikd6sqPx4Sheqlqp30Vf9G/EKj4z9COBKF4swPGnJi0FIoRlL8EYJ0gHd0
	 RdACQ+sUdk1FKGxZu22RP4RuSbNxNid6RD0Rpb7MOxByagIDsabIvo+uzbdH/dfFuoS2H
	 gsb6cyKbSZ3Fjwha9CAJrwU5AWqXI+3ojDhFoelk3FFKcO5icOvsjZfuYtwegU24MvQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794826730;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KAgeexYgyuDHvkwSa1gW4GtYkM3aRZFOUYjqWe3/rts=;
	b=FNx+Y1Vom3ptHPQc3b+N4JINaoqtKcVTdxhIwg5Zc35f2PP22ZYL9y/RgSKfSu4axf5j
	 xTkTF1cIVxQkp8DAjpay3yMcL5wybreR3elzkEpHmesaN/EaSukKvEXRMShHJtApworSF
	 1SbeeSdmq4tZwvZOgeUAPPjHqK/rSbNDV6ylIs+6HzD/Xr/mv25JCAWDeCtYrcWCNKjzG
	 lnHXg469YLcuMkDM+72uYt/N9Gko2ihLSl0X8c6rVK0Jl5pH/X7DKrvvYLUCt7Ctj/0ch
	 WYZvG6YHvd5SgI+varRKCNJjlbaKjcL2Nt/RFq4CqBwfuDAAL6VbWvAEbjJa44JBWhQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794826730;
	bh=KAgeexYgyuDHvkwSa1gW4GtYkM3aRZFOUYjqWe3/rts=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OmlWAQOguEFMDIIdYK91yaUMYGWvkFj/z6ZQbCsgPRwRrbQ/ZQ6VwSlJOa4V1yU/V
	 ydJ+jYXYLvPLm1/Yf6tOeDazmpA2TTHdJYW/FVRp1JExqrbTu+WHIh7cLTgw3dbBDu
	 LNvgv6WG41S5Hljo45nOIggPzV77YVpwBuiioce9zcDiqGIapoaa9nzLAaSDWJzyc2
	 DSdYoULh6uccNermB2RSQqTI2pnvs6wZaem5LsbYz8R9yZ4fkrb9eKEXLcSr6mgLhJ
	 A3GMqguFAZbhe9oPdeVNNefojXN/KnQ+uZnMrFVn4gCzHoB13HoWDyjHbvcE4po+l0
	 PFD+D4iDYhPgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EE664405CF;
	Mon, 16 Nov 2026 10:58:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D5EB1E7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:58:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 531A5606AE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:58:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C5g0Ef8wh9uS for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 10:58:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8A20A605AD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=UnpW2vub
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8A20A605AD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAgeexYgyuDHvkwSa1gW4GtYkM3aRZFOUYjqWe3/rts=;
 b=UnpW2vubfS9OG0rm14/Y0jrpLZFQmsNw0+MWbbbCHv83HGFnVQV/ASKcwE3cYL9Q2juB8u/wQjlozrH5QkRSN3pQQm89DOBpSMkbQz+qBlY6wdro2bs76DKEA7bRhqABoRLpDbjXoaEwaoQ9y+grQBvcRRgev2lwFIgmcyO2NUA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by GV4PR04MB11971.eurprd04.prod.outlook.com (2603:10a6:150:2ec::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 10:58:39 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Mon, 16 Nov 2026
 10:58:39 +0000
Message-ID: <ab08733c-2b37-4bd8-ae9a-ceb8c1784cae@cherry.de>
Date: Mon, 16 Nov 2026 11:58:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: rockchip: rk3576: Use correct mask for UART1 parent
 clock
To: Jonas Karlman <jonas@kwiboo.se>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>, u-boot@lists.u-boot-project.org
References: <20261115200526.120871-1-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261115200526.120871-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0237.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::12) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|GV4PR04MB11971:EE_
X-MS-Office365-Filtering-Correlation-Id: 621f75de-e07d-4d66-ae36-08df43d091eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: IELNmyaNw1W78D+A0QFqZaDTBq/RsuJNbOlxYCXmeEni0hD33bnVMVFbAhtz6phtF+kvxoPBQ7nNBfzJxumiReSbqDX91DwLeAjux2sYiUCgUn5/crIgEpSxpirk2gLwmMZwPjk7K7WsvwvZMMM5KALR+5NjQCIH9K/9+2zTztJzbnBbmQRR0CA1bDaheyQU4NcqQbdbFZXVn9/rSLpiGL9pIWV6m+bn8u46OlWQ/RnPGAny2LV7fpPowiB7Ju4u0YF7FDqjeQr3K3vh3XehNVJm7ug2aozS6LAQqKtE+Lp4pL+6p8D5CohpSWIlnMkt2kODT4yweZI9EnhOnzLfWrQ2LHRuKl5OZhRogzyhdc8LrnrRle+AXwi814UuzvHtUsTDdjSXiSithJ62afahqFyYv+ybBSQ8YZYyPLjE7E03oHzByyCfZtRNedvCXvpRwLPgFyfoAFkgHsrfTdrgquqRuENGRFYMCHjACpt5KbqGQSU0u/ONHoUW968WKNuNyGVju8eAz50hZ/sk/bn3wDFM8+NXTGkK+LXYklQWmmYyDmj4jd5JK0ABcXcNkriWQw3WZW3MJmWc993p/009xguyictUYeGDE2urBBsjH0QFiXJo5XqrukivGA0s9pZr53B/BBEpJBx9FroAoxs29n+zDlDPRlAHvq05p+JOTbE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzN1bFZKRkN5STI1cmJ0RVJiMzVGeC9saTVORENoK3JvVmxiRnA2Y3JmS25O?=
 =?utf-8?B?eFZrbjhWVnVBdUlFeEg4YzFybWkyUzB6V1FkcnRsM1NaUFYvc1p6LzNzN21K?=
 =?utf-8?B?MVVXRkpvTlcvNFB0ZmFPbUhEK1ZWZENRdXFPdUV5d3FHOHVZVzdLOURabitL?=
 =?utf-8?B?ZVZ3ejJkdmpvQmpnbFNGUEV5Q3lFemp6Y1RJalFTemJoMWp4S3dqajFuUkxR?=
 =?utf-8?B?MEhYYVkzWE9PNGJvZXM1MjJsQ2h5MlluYjdreGNOakZSTEhZMmlnaG1sQWdo?=
 =?utf-8?B?NDVScG12RkVZRFhwbjZvMnFOQXdpaW9nY0FJYmM2bVgwVHdqS0tDZU40YkV6?=
 =?utf-8?B?VFI4RlExYUdPbmRqK3VpTjRmaklERU9vMFdKclNIOE1SV3VwOGlMOUdYVGRT?=
 =?utf-8?B?TXViOURwTzFNWU9TaHFkSlF6b2RZZWIyNTNPaElTa29hdldIL0kvWHVxM1ZI?=
 =?utf-8?B?dTZtWU5wM3Axa2x4aEt1eTdqbmwycS9uWG1hQVNrK054Rm9nY0ZQUi9UWUx4?=
 =?utf-8?B?Vm5lVTREMGw1S3dUWUNDK2JETzNkbnNHYUZER3NqKzNCd1p3NHc1c1dTY0k2?=
 =?utf-8?B?VnBKTy9EUGswSTQyVFFxdHpNbWhJTlFaYWdxRkpqYXdqSlJKMll0UUZSQ2ww?=
 =?utf-8?B?TnR3b1NIbFg5bkRUYStGSldnOGpYUmVnV2RsNFJZUkNadjZGQ3FCSzU1S21P?=
 =?utf-8?B?Z1RtejRQQXgvSnlDeVNoQkZ0dUtaUHRNaDBwT2JwZWpybUE5VlVIMDU5MHI2?=
 =?utf-8?B?T3BuL080ZGNDWW9pekJONm9wOVIwMnVZQlk3Nkl5MUUxNHMvbHhSdXRhdzJW?=
 =?utf-8?B?WE1Ea05XYTJ5NUY3RjhnNjFwK2RKVjlVNDd0UENQKzF4b3QxejU3czR6QS9h?=
 =?utf-8?B?cit5bDF3YXJFNlJDcFhYZVVKYzJGcGladXQ3aDkrT1NMam9aSkxNZ2lqMWxI?=
 =?utf-8?B?elFxd0hTZVlzaEFoUVdTVzhVQnBoYnVZa2NvSXJtK2pCdmhnRVhJQ0NOSmFt?=
 =?utf-8?B?eDk5SktyWFlRVVhTc1hIMnZBcHVFTExaVHBzN0lESVBxK0JkaXBQV0ZHbTFI?=
 =?utf-8?B?Ry9SS09ja21OUksxc05GNXlFSEo2OVFBOGhEaS9EVG9VTG04YUd4Q3FpK0pt?=
 =?utf-8?B?dm4vb2dRQlVpQkRjM2RMZW5RSElQTE1XRXdQbmRVd3ZtSWFuMEV2UGlpdmNY?=
 =?utf-8?B?VGdEWHh3Ly9MeUxjdm8rb25BeFJjczVmMjYwTWhFZCsrbmhXMHZOME5TRnlC?=
 =?utf-8?B?R0xPdkF2cTVUemE4dzdwYTNid3ZacVZzT0JKTllER0ovdld3U1hJaVgvM1pp?=
 =?utf-8?B?clVqTTZ2K0N2TmVYZ3lrQnk3R09IS25scmxTOXE2TTNjemlqaDFnaGI4bk1I?=
 =?utf-8?B?M1FhRkFFRVpESTkvUVpVNVlYejlIV0FtRU5MdzRPdG0yNXJrOHZrQm9WUWhh?=
 =?utf-8?B?MFRrcGNoMnhzeVJaaWxmSXhOL0Q5dGZmQ1IxQzMrUzlZUmZ2UXVyL015V3FN?=
 =?utf-8?B?dlo0WjdSVEZNT3l5T0liUFNtVERaSS9nRVVlUHlxOUJFb0FqVTk0MG50SVk2?=
 =?utf-8?B?K1NEc2lFOEczd3MvM1RoYWJhdVpSWUJwdEptam92RnN3NmRIZGhMc2I4N1ZX?=
 =?utf-8?B?eUJTd0F5a2JxekcvZG9XdXpPcC9TbXg1aWxMZHpwMTMrc3huMHM2dlVLS2ow?=
 =?utf-8?B?K1FNcEV1Y2V5Z3FoR05ndCtzdnFJbGhDOGYyeWIyUzZGd3crNWFVdXNFSDNN?=
 =?utf-8?B?dGpzVEo5SzVjNmJQQmp3ODkwZXhHMlZqVU9USXlsTDdSYmNCZHFoMjE0OXlN?=
 =?utf-8?B?SzQ5VzF0QnVCWWtsQWtwcGxqSDV0OW9aOW5GVmU4VSt1Q1hjbzJxVjVHdy9S?=
 =?utf-8?B?Q0RnUDM2TlVWNU9iNVFSWXdGY0o5QXhmNEFmVEJKN0pUanJNS1g5eU5SY1N5?=
 =?utf-8?B?QmtwRUk3Z0JQS1NLVHd1V3RaM1NOTWlUU1p2T0N4NFhnb1lwNHNuaGlLcEcr?=
 =?utf-8?B?WXpmZlNCRVJXUGVnbjlFNFpsNG42Ujk2WUFabS9qbHJraU9tM3lRN05uUDlj?=
 =?utf-8?B?cnRuYmJlRE12QUIvcE9pa2lDaUxobjJmYXkzc0U0QXYyejNMai9rcXhiK3h4?=
 =?utf-8?B?eDFrNjNhWmxlYklIeGZnb1djbkFIdmxGaWlsL3hqMnUxN3ZWS01jbjBXT01F?=
 =?utf-8?B?dHZnNHRHdTBvQkFOYS8vWTNFb2U5ZlVLZ2VaN2NzVGY5WHYwRzg4Qk9CRThI?=
 =?utf-8?B?a1IzUGd4bGF3amtPS1pDTmpuZXRzWHBSMFFWaHd3MlVDaG5qSWVXbDN6amhK?=
 =?utf-8?B?NFVENHJia0ZEdTJXUjNSZEF4WnhtMmpVTVZrTVZ0Ykh6VlEvRzRLZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 621f75de-e07d-4d66-ae36-08df43d091eb
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 10:58:39.1633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2LnVIj7Y/kbdFmIKYJADrNL7vf6FJZhxggrMUkOYM99v55O1R2je0xC3Kkv6r48PIL7hqwW/FtlP1cmB+RbSthGZP834gDTEJ7mBqovi9l4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11971
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas,

On 11/15/26 9:05 PM, Jonas Karlman wrote:
> Use the parent clock selection mask instead of the shift value when
> reading the parent clock selection to correctly report SCLK_UART1 rate.
> 
> Fixes: 3919310b37ec ("clk: rockchip: Add rk3576 clk support")
> Suggested-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
