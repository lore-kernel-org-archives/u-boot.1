Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA00606A323
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 10:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HlkSv3/W;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=PDxcqM/K
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5DCB405DC;
	Mon, 16 Nov 2026 10:49:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jfxN2g6va3wP; Mon, 16 Nov 2026 10:49:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 02B85405DD
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794826195;
	b=Sz8uKzdOWCekOocfNMyxLdcCv3lPzWU/yQRZUH4wloGlFJHf+6aBXQb/NpjCEt+4b0gg
	 qCWXZ4I1VJG6qYgIAgbdL34pEfl0EoKBwPGx+kqNycIR31O48vBIBVYAM4PbAvd7qzZ/l
	 Gx3bbp+LAZZR5LOB1XihM+X2rj9DHVLI23XoJB8Nano/s0/PyLAuuDat0L9j5dUHsy/Wt
	 HVC7A9S9AmvGQByKJ94VQGXY/ZaJDMHdRfbGXLvsyvkymnR6y4Fki092U/16igKjFqqPV
	 9a6DJF32ne2jW0UjD1OWEebGr3BLfMO6ENdI3KxbKGRV50iMb1qwVPgqaCbQm+ke6Tw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794826195;
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
	bh=PdepA0F4Nz7rQ1fuJ1jz/lEM+36rA71XKZwYBrWjtBI=;
	b=iFEUExU8OgWnzfU1cJOeRKXWAA1Fi4/Hlu+uaDmQmO2q+Z1YB26Ni9vyfm7gLKTFZs5W
	 yfEUWDfWrFOXybrUE+O1E6hBc8unGeufGwc+6sKdY06CR41uiDlK886fwwtyGulUouI7q
	 i8AQeCiZikEplyTvHefHJuC7L+G6pi//J/tsW6ymFB5U/GlhEMjl89Uq5I/GjMNINSaSm
	 eodiwZfYbLiwIns7SX3wskJNyCpBv0V+pJstfK/N/JFYaWAO6q0rvh5Vk6vMzPWf9PnWB
	 +al03EBn2zo5c2P9XLCGw/rXaRdVwUKBpYukt+WhctJZly2t0qR/cFjS2Wy4loMXFcw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794826195;
	bh=PdepA0F4Nz7rQ1fuJ1jz/lEM+36rA71XKZwYBrWjtBI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HlkSv3/WdxnJrWfYl1JsJHOUkpXVBdeF/25LY6hmfqLA6QLJBcsYF1c9w43wl3+kS
	 8ckHWefLUmcfRolGxegNBxFzO9MfYxzWDXzGzQhMc2aZkOD6CoBbgJn/R+ildq5lpr
	 nNz+v/ByGwPb5/Gt5Znvvu8XdS24HUsYJflxcdMmp9jYkHiZvF8T/ixJ+INeRMZrWR
	 RuD5/HO+HAkfcKcvdYmzBAfLdyIPRho+fTE6Z7Wf4lXPWNaoCcWwg4mayUBpZBB7+x
	 xgpZuimuLYSG8dC18KvnjOcy58Hhq1HrtVwoJ0Y3kbJ55/d2Ql05u0UkOmvGH98B5I
	 qnHOdxzaAVS/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02B85405DD;
	Mon, 16 Nov 2026 10:49:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 36B621E7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:49:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 286EE606F7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:49:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rxRmDVFsbUe4 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 10:49:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9784E605AD
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
 header.s=selector1 header.b=PDxcqM/K
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9784E605AD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdepA0F4Nz7rQ1fuJ1jz/lEM+36rA71XKZwYBrWjtBI=;
 b=PDxcqM/K8ygqxe0TaF99fmJRagamBGCtu5Xnknjxj5JarUzs2UEEUy2W7/NFxZ4Vx+ZvjK7fQ74Wj1NdbVFLR4/JmCQ6ZNrWMHs6kJ7AlGu1m1mbVkFiAOdyb1AajBP3teRxvV332VqXC55LzqIsxKXQCTYLF5zjKMkNZ3tH0j0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by ZR6PR04MB143515.eurprd04.prod.outlook.com (2603:10a6:910:d9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 10:49:46 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Mon, 16 Nov 2026
 10:49:46 +0000
Message-ID: <077d6120-3de7-4638-95d1-cb552cef43c6@cherry.de>
Date: Mon, 16 Nov 2026 11:49:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] clk: rockchip: pll: Fix automatic PLL fractional
 parameter calculation
To: Jonas Karlman <jonas@kwiboo.se>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Elaine Zhang <zhangqing@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.u-boot-project.org
References: <20261115195600.119868-1-jonas@kwiboo.se>
 <20261115195600.119868-3-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261115195600.119868-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI5PEPF0000092A.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::825) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|ZR6PR04MB143515:EE_
X-MS-Office365-Filtering-Correlation-Id: 80514854-998a-4a1d-4c9f-08df43cf5403
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|10067099003|11063799006|4143699003|260925021911599003|260925022911599003|260925021311599003|56012099006|261021121427099003|261026121527099003|261102123227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: EVTOiPXHGm0GqbwD+Qbrp3UOtKmOR4Ay/uDkAay7zBrmXJ680yG3M2MhumavMAKPwsOipxG1BNjVIiDY4xl/63Al56N7vnz52+XAjHN+jt1p6EySBbcjKJ2NRNioGPK5inujWEqV/l+4UGkMkdVioPwdviGuz/Vv4HJlgvfK/Baqa0h6qNngSA0AqkIOMrSBj0xln1A3FfQG22JnqkrFCWZ33pli9B331uQUfZHLvxrhk0ab41CZ036FSwgFYjwF5R7aRKILElShdzxGAdfBIIWY1xAP1yRjc0ez5446SERbPvOURNm+3MIrfe0/Xxr/NO1mpiPmZ7FIMlVg83N6tCAJv2EYLaXj/OUllEJBBsorvwMoPeh5SMdBV12HgU5lHgm1AIFXKJy+mxYjacVRAEGJ5CcpMEgwDzYkykC1ygGOe3GjXYUtUdgt3Zq6k+Su4CTxW5ToJ3cS1ftMCCVA6lbVuNcR+HK1sQyDCl1jsFOpUxl/vUWRdOAKcDWsumGa+DX/gnzB0R4Ovs2g2bQOWnJY/zV/tNDf3GsTQAxjcZhs3tz2utC5QXV4Z8+QVfVTx6uOnZfbMnMVE5G3XBuJv4zhCf2Cc3sB5pJkGtfOYlPae2n1pXaNDQZyonXOXraSaq5wfWXKHRM5GswxQZtqLEN/4KotYef80c/hTSq+QyI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(11063799006)(4143699003)(260925021911599003)(260925022911599003)(260925021311599003)(56012099006)(261021121427099003)(261026121527099003)(261102123227099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0VxdjdKZVV0eEY1eUZrNkdpUWVwSHAweFpFeCtwM2VpekpMRUlhbnI5ZFRD?=
 =?utf-8?B?djJPamJoQjVOdFpvdzlwMHRneDEvWnFnYkFUTnI5VmlOR2N0cHRSM3pBVHFr?=
 =?utf-8?B?Wit6L1hRTTlJTmh3d3pFby9Mbk44Sk9tOG1VWTZOQUtzTWs0eVRNVmdWWmdG?=
 =?utf-8?B?cFVjRVdpUHR1UTdVaVpCdWZLUDhQWGZpcEJMUTRzSldBL3YxQlB0MmNYdC9H?=
 =?utf-8?B?YTdjdWhvVTVTUFU5T0dTOUFmYUV3emlaeTJhQWZ4VGVJV1F5STNUL2FJQ25q?=
 =?utf-8?B?ZjV2R05TNzMrRGJ3SEl1R051UGJvL1FDWEJaZDdpOTBhOFJaUXhDUkpJSktE?=
 =?utf-8?B?ZldrTzlNNnphbzVRZUI5VURrTm85bWtjc0Z5Tk0yY2dESUlycUVwQllVclFT?=
 =?utf-8?B?ckhZb3U4c2RRRXhiaUlKd2lLcDFKb3FpYTFrSHRtNVRiZXRDWWc1bjcvZURv?=
 =?utf-8?B?Vklwbjh6dDhsMGxTTUprZDdPWTF5OXB2R0FVZm03TmlQNUVoamZmR2ZqbXhD?=
 =?utf-8?B?QlhsL2FROHFTOGxNS2c3aUZjRE1xMHQ2aGp6NDFISFU3MGczNk5JRll5c0Fi?=
 =?utf-8?B?amlJbWl3MEUwRlZqOGdSOFR2cndPOWY1eWNZL1lHYWJ5THR0NEZkcVlyQXdZ?=
 =?utf-8?B?UloyNnh2b21aYVJockd3TVRKMSsyY3EydVJDWDF4M2FUb3BjZXlaRStxOW0w?=
 =?utf-8?B?Q3dFZkt5ZTZabE1nVnJMWVhtNWJXb09yS083NXdjTUlLcGw0L0ZiYnY5UlJ6?=
 =?utf-8?B?TlMvQndvTTBoN1gva0d6dUhpbTZqS2dJMFZOK09OWjRwS3hFRG0vblNFUFZC?=
 =?utf-8?B?bDQwTEpEb0ZQRnVyTDVtelgxTDcrUThKRkoxRGtMT2RGT1VxbkF2bElORktD?=
 =?utf-8?B?U0ZTYzB1QXRjR0NYTThjRUFxWDFXZUJrV05wT0pLbkJvTUFhMEg3bkplQWJ5?=
 =?utf-8?B?NlNCckhvSzltM3ppRTViNGU0RlRhUXVtRlVjb0EzWXRPN29nSDZsNWZidThV?=
 =?utf-8?B?SW5vRzJIdkJ2UGZpdko3Z1ZMTzBFMWhRQzQ4SDJ5VFNGU2krMnF5dVVnUlpm?=
 =?utf-8?B?UVlrY2daSFVSWkRLOHdLY1hneW5NSHpQaURPUDZjaXE5MzJzZ1B0cWpObElZ?=
 =?utf-8?B?eEVvRmRhYm83WmFQWjlYNGIwYmJYWndYbDJrbEFLNWQ3ZE95WWxxb0ZNT2hk?=
 =?utf-8?B?MGtPLzQ3L0dmNjgxRU9uRlhmMWZrSVkvaUxHUGNFNkxaVFJ4YVRYZjJsSktU?=
 =?utf-8?B?UzNwZ0JMVVlTR3lEY25KQmZtTmhHcTFUVzd1anZuMzNKQ1pKQUF4cXZEelNm?=
 =?utf-8?B?OFl3cGFoZnoxN2VNZVRUSEhvSCtPdHFVbXQ4R0p4VEtQTSsxUitFOGdycjBY?=
 =?utf-8?B?YzJiQVBYQUdsRk1ibzJlQTFMYld0KzNtZG15SGNQUDB0ZDl4UTRKNEhIamtu?=
 =?utf-8?B?c1ZGT0RBVkMyNjBIMHBkZ3FlRzdwSlBaOG45VFJxSi9hb090dW90SXZBMHZs?=
 =?utf-8?B?NEd1QjZlbWFXZFRjaWhtcWlvaTErL3JIb0JoUFpTRXpoYkdkTlhSQ3JuQUVP?=
 =?utf-8?B?RGhzWTlmRVhDWURwMHpNUGZYMHhibTBiVWo4RHpQRXo5d2plUzJhZXVmK0Np?=
 =?utf-8?B?KzM4UXJhM0NTSTVsMEo1T21QU0FIWDE0L3cxZUNYRFdPTXZDL2prZGN3azVU?=
 =?utf-8?B?YmduWkRyNHF2QzMrRGprZGhLVms5V0hIS0UvSWtGQzR1UFd1Z1pmL3o5eldj?=
 =?utf-8?B?YXJDKzdpR1dTVWNITEZicnhJdkl3VFpLcG96aGhZNHlPTmJ0TTJ4d0pHRStX?=
 =?utf-8?B?SjlvK0M1dVViQ3lYcWx6MkFYU2J6TFU5blBTYnBVa3lRN2V3dFVhSFZveTF1?=
 =?utf-8?B?SVBFRmRvK3BlNjlhK1VNamM5dVprbC9aSUtRSFM5UjkvT2VtUkh6NzFKYlNY?=
 =?utf-8?B?NzBPN0tXa3AwYyt2YStLZW9XazhJLzFvcHIzZk9pL0JhSkZ0Z2dyT2tybnZk?=
 =?utf-8?B?MGZubjlrMTNSSnV5ejdNZ3VNVEpwamVYb2pmL0xpTWdHdmtNU3pzQlByQVY4?=
 =?utf-8?B?NGVLL25vTmM1d243ZWlEQi9sQjhUOFN5YS85YmF0akkyRndqOUdJenZjcnpR?=
 =?utf-8?B?VzBsa2Rqekdzd2JsVFR6dEFtN3F2cnhoaW9ndDczWWUxNHkyNXVVemhUZG5t?=
 =?utf-8?B?MTY5QkxIVmhEL2NabXAyU3lWT3ZRUmdjTktVOXJUMWZjRnpRL2FCQ01QZVlx?=
 =?utf-8?B?RlQyZmdqWHVYVzFIYXdmcUFiaUJ1eVZDNUpjQUpMaHpnc3dleGc1NmJsTFg4?=
 =?utf-8?B?czBBanhhQjVoTVBTTnQyZWZnVGZaVldqOC9CZEFXcmJkNjV5ZTJ1Zz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 80514854-998a-4a1d-4c9f-08df43cf5403
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 10:49:45.8961 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fPtlV2qUnhI6w/yOKeUL9eD4hcowY5p9fh4rbnASfvC7MQt38tUpB1wFIc/EJ8hMRUlhOCecJe4V0Hu2a/wJh7F2H3m8Xb5rS0+jybaBXvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR6PR04MB143515
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

On 11/15/26 8:55 PM, Jonas Karlman wrote:
> Requesting a PLL fractional rate missing from the pll table, e.g.
> 786432000 hz, may result in use of wrong fractional parameter.
> 
> With extra debug logging something like following could be printed:
> 
>    frac div,fin_hz = 24000000,fout_hz = 786432000
>    frac get postdiv1 = 1,  postdiv2 = 2, foutvco = 1572864000
>    frac get refdiv = 2,  fbdiv = 131
>    f_frac = d2f00
>    fin_64 = b71b00
>    frac_64 = 0
>    frac = 0
> 
> Use u64 arithmetic for fractional parameter calculation to prevent
> truncation when automatically configuring fractional PLLs. With the
> typical use of a 24 MHz oscillator, u32 arithmetic is enough for the
> denominator value.
> 
> After this following values would be used for the 786432000 hz rate:
> 
>    f_frac = d2f00
>    frac_64 = d2f00000000 (before do_div)
>    frac_64 = 126e97 (after do_div)
>    frac = 126e97
> 
> Fixes: bbda2ed5840c ("rockchip: clk: pll: add common pll setting funcs")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
