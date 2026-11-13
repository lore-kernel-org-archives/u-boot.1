Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80083606A323
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 17:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zJakMOSy;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=f51Q/XgC
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5AB1040B2B;
	Fri, 13 Nov 2026 17:09:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 08VgpKdFDGou; Fri, 13 Nov 2026 17:09:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 24A7740AB1
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794589768;
	b=tTh1uYkI6Ma04hdYOazH9PT9m9gWWeqJ6GbpZKJqcMHBQqpZU1tXMz13tnlWCl9oS5N4
	 ojqOMQHQ34mGkijf1vUuNX+36gVVzpRtdZ0YEsejEraNIFo6j4tyGls2tWSdpTq+H7h4E
	 xfZ9J+wKtYb/pWCn6ti4/agaI/ABKTeSsV7eFvaK4kQmH5bmE9NZzItqVN+twkM5ZppfT
	 h3vKmNLRmrU0GV5WYmPjR3HrCwsRouDa+F4TRloUnbTIiLNRFoYR/Mi+HgGiqpyP4hQRF
	 PAmzWG26TUsze/A3FDXzriGLz6u0mDkfRXqV6gS/LGYE/1+p88xutj9aIUXRmYloc/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794589768;
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
	bh=TVNamTo5ekrAjYa7Cfp4cDvBaCL9VjHZA1W494Iwge0=;
	b=mwuy2DEkINgsVUBzFauWvpjAklkMFvmyhKCQLo8VBxORkTYkgGZdpTagkX9EmZRhrc7v
	 Eo/13lW3qOFfM2K435s1w/NbeYUZvZi8ign0/8lBarpgcHPRCoUpMO82mnI0zOHXBjYfY
	 V+AgxROnLzv3EvwgVVd9+bDXMgO2+7pOhtwsraHld6N81YqP0vEuk4EzoAJpXwrX9Pizy
	 PNpYoEaxyI9YSW4TVYCel+b1L+FYwRsv0nWBXa9KBfkas2Rb963nWJJzOhiEVg3hMiB8U
	 FXeFx2mrR2BOdh++BICH92BtECKe5CkfxWfbaFgE1ETPNoQSkigy0MTJYdP7J1yPj5g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794589768;
	bh=TVNamTo5ekrAjYa7Cfp4cDvBaCL9VjHZA1W494Iwge0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zJakMOSyOAMIOZDrmefAziZ0JcoWozcnzV6D0paXCLqg801uQbUZhjBYizaneI786
	 YZaOD820u3Pj90gltFTeZXYpnZynHMpje0/DuDx4tVS4r6wue/d9oiO0PHQgZCl1Ld
	 P3FIhm1xjEI5IfWmKisV2yQSz4OcJvTy6crCD9g2eJZm+stARDm0y4RIVx6gOSg0Kn
	 R26gp7H62YBCHXSZgLhRBESVG15pir0cXaCQJbME/tLbyUX7bhy9O0FhdY781vKlTc
	 d7XpNtOlgW1nlVHmTkqN9S9k6e7qq3yq3exvyG2Z/FX/tf7pMHqCv6M6DRweW8IU2l
	 kBywUZJAag02g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 24A7740AB1;
	Fri, 13 Nov 2026 17:09:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F3500178F
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:09:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D8815606C7
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:09:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mw9FEyXeYvDl for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 17:09:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4089A60663
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=f51Q/XgC
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4089A60663
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVNamTo5ekrAjYa7Cfp4cDvBaCL9VjHZA1W494Iwge0=;
 b=f51Q/XgCRk2ikHFG2ZKFVlojR76/OpHXpTLkj5UlQom1czZfqM4tiRqSdIBf+4HVOw6qNB9ONYYMD+kPBGCWdmPfe6pC53AFpe2o2je3I8AET8Qerd6KWwp38MaoA2rnh2r0AsS52o9MbOUmv8Myl0wbOYlzqgeHfyEP6GFWZfY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AM9PR04MB8538.eurprd04.prod.outlook.com (2603:10a6:20b:435::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 13 Nov
 2026 17:09:17 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 17:09:17 +0000
Message-ID: <2a8ec4b6-cdc0-4b9d-a582-8d01c96e7166@cherry.de>
Date: Fri, 13 Nov 2026 18:09:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] clk: rockchip: rk3588: Remove redundant PLL
 register macros
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>
Cc: Lukasz Majewski <lukma@nabladev.com>, u-boot@lists.u-boot-project.org
References: <20261111231251.160051-1-jonas@kwiboo.se>
 <20261111231251.160051-6-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261111231251.160051-6-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI5PEPF0000092A.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::825) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AM9PR04MB8538:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ddee47-2bd7-430b-a300-08df41a8d988
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|4143699003|56012099006|261022075727099003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: yfLoDGpNjmnJ7CrdCmoKwwxoCgn4IKm3nIkQdZAd7aVRhKOmJnCs77p01Amwa4Y0OvuyybJDh459HRJne0JuaTJXvzyUojTH6WqTP7K4GsPrchuCUC8+WAp1XAtb/d0vccqMkYwj9COdb4Zbs0tZRZ1pQMsasqIP31hu6Gy/UG3IVv6mZDTMpJ79PfsbzgMZ04gkw1yK/8+UIUofHvBEF/ZdhfUe2lwm5/0/ymTjIn1VTXp34C+Cb/OgTBDBqN9Zc/IaqaGrY3sZXIPO1kZIkIZG0hQd9A9Sbferk7VOIwgDPd6hUVENcof8EO9CK3eWbrsCA05bGbTjgJUfwQbWPe3P/yiGy0XO9v+N4lKvwc5ok9HD5I1FAn1/5l5bw9YjqOXHxbR8Z2yaCXnhvxdAd7ifVua2akbE42AexkYNXOiZjNoHAisWl4Zr3Dei/tW02ADjiyTVu0AX4eZTXoCbiYc9qIsX6fSP4QRS1x1QT66EL9+CYQYpCQ3EAeRtyJVoAvVSsKoi/ID2pBZQ4K99jrqmfu1LFHQTWNIUKhzrRn48MxBdIZBx53IS2bElrWrGd6s2x0otlatzAL7rFSQFn2lhT6T61yZwRV57KIjkn9u/5C/4LzNYOPvAzkvN+si5tgp8WzcYJ0cTpwoQ5IgV15eTh+J6VYE6jlDsX79VNx8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(4143699003)(56012099006)(261022075727099003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHVIOWo5R2txTXhvQ09CQVJQWUxrME51N2hwdEhlMnRwbU43ditVaTZDSjBj?=
 =?utf-8?B?UHozUW5OOEtHTm9JT1p0V00rRG9jdmpPYURXZ3Z2MFdHQVZRMUw0NjlncEZJ?=
 =?utf-8?B?dFNHUENvcGJZUExxWlNrWHRrdGRYdjRZQ0RqckxTRmJjWnkzL3o5bTJtd0Ny?=
 =?utf-8?B?enpkZERzMTg3Y3dNN0M1d0NuZXoyVitJVEZzWkxtSVdnV2dXZGlmZm5iSHdo?=
 =?utf-8?B?cUpjcGxYcmViVkRHOUlPMWpGOVlUdkZFV2dKUjFra1FhZzBxbjROTDNYYTBk?=
 =?utf-8?B?OVZjVVN5SVFlcDE3ZkhTRjJld3Rac0JXd1d6aTFyaE56ZjRRMDJkbDFZelA3?=
 =?utf-8?B?aFkzZmhMSGpBYjMyZGV1MVk0UlBtWWRybEVvL0diczY0cXR5VjMzeWFoaWNi?=
 =?utf-8?B?Tm15SHZrdzlNVmxkcmw5aTFZODZDcWhnenBHdVZDUi80NjJiVnNaSjh2Q1gz?=
 =?utf-8?B?UEdkWnVBbCtzdkpJVVhnV0NPeldxVWpSZG16em1vY01sNWwyelRaeE9zQTlq?=
 =?utf-8?B?eTdBbDVPaVVBK3FNcHdVcmx3RUtoU0hKSnNEUXhPQyt6RjJudWk4ZHhJZUln?=
 =?utf-8?B?V1JXeWcwaU8vNGdKQ3hQeDBIVmNERmkvNW9zNVJZYWlmRlVOZ0UySVZFNitV?=
 =?utf-8?B?d08yck1DY2R6cTNxVFJmRmdQWlkzbGtQWkhkUzFudVZpTCtPRE1RMXN1eDQ2?=
 =?utf-8?B?MFhWTlNxZjMrcU9HcHhwc3RxU1BPZkorbDBtbnhFWEV1dkh1R1RPTm1RaDUr?=
 =?utf-8?B?TThZajFpRTF5SSt2STR1MDFGQ3pGSDJyT1VQVU5Vbk9kWVVqSTJJaCtESmtj?=
 =?utf-8?B?MEoyYXFCOUN5MUd0SldiZGxVOVUycCtwbWFHY3laSWVTNS9URFZtMW9ubkNx?=
 =?utf-8?B?bW05SVdkR0RlZjBRTUpZcDF4eDJkUVljRHlhUy8wOEFqY1RadUFwVW9ydXBG?=
 =?utf-8?B?T2NuUi9xdm1iTmE3T0pEZzZCQ0RiV0kvUDh3dXJGTnJHSVVoZ2s2TVdlZkFJ?=
 =?utf-8?B?QnB2dFVnSC9OaVQrNGZkcHNLUkVwZFRrUTNmUmxCREVWL2phcXBrcjAzQkxn?=
 =?utf-8?B?cUI4Q0dmc2pVTUFTbzJ1aEQ4VXBsQUo5QWpTL1l6VkZ2b0VpYnRQTmYrS3I1?=
 =?utf-8?B?bXJiZmVLcFBwTDFRM3JwOUZ4bnl5WkJzbzhjeFdLSXExVmlLQWVlNFpRdllB?=
 =?utf-8?B?TDlwZzI5S0lqeEpUYTNIcFZRRzQrb3hnekQyTWlIRnFhQUhrMlVTU2NNY1dQ?=
 =?utf-8?B?M1d6SFBrV0s5UFZjUGlvR0NFMW5ydFl2b0s1UGJVVCtmZjJaU2pXOENNZEZK?=
 =?utf-8?B?MTlsQno4Q1dFZEIvVFN0QnErU3gzVkdSQXRPdzFOakJFTzNiait6a2owN0d5?=
 =?utf-8?B?d216OHl6Tzlzd3FTb3dhQ2hEK3g1Yk9saTBIT3FrZmFkTjlpckFNdVcyMjIx?=
 =?utf-8?B?bjZpRnhWRHdlTzFubmQzaVJuSWJhb3VCNlNVbEVSdTl5b214emZIbEV3YnVX?=
 =?utf-8?B?Nkt6eks3V2VWdG15dWdxUGJxK2ZoUTc0MXY0RkJiRmdxMk1jeEg0eUlUN21w?=
 =?utf-8?B?eFlzalAxdml6Qk9MZTNKeWhxY292OEtDN2Q5emtscGtGTldueFJCaHJlRVNJ?=
 =?utf-8?B?YldkMmYrQ3c2UFdQSGJKLyt3eTJBQW1hTWY4aUhJbVozZ3ZhdU13TldzWGRs?=
 =?utf-8?B?MUk5cWJkTThuZEZDWUhVeEh4LzZjTko5R1ZOVndQV3ZDZUpMaWM1am9DbHRs?=
 =?utf-8?B?MkdJL1BuT29xcE5OenpYQUVGam5RejBBTVQwRC8yMWM5bW03NFBSbFlNZWMv?=
 =?utf-8?B?V2xhS3hNeXVLSXRoTmd2bGsyRXB6QVJzM0R6dVRhdWE0V1laOWYxblgxbnkv?=
 =?utf-8?B?R2pBUHg3M2NlQ0J2T0MwSHZMd2U4TnpZdzYrUHBqdGJPVFY1dlJ5Vzk0SVlk?=
 =?utf-8?B?Q1FobEJYZHdlVXc2UlZwRmFyQ242K1NicE1SVEROSU5HazZkc2xWQ0p1TFJ3?=
 =?utf-8?B?NDR2d0pjbWN4Y0pvbUlqVmlxUHlGd01zQkM4MGhOQWsyZ0tTbjV4b0VLRWI0?=
 =?utf-8?B?VGg1ckNiK1ZRWFJxcWFnTnZsYVJGVDJCVzNpdC9wM3AwYjhrbEVtUmFXZ2hZ?=
 =?utf-8?B?WVhCWFBkNWRGaElBdE1PUnZ2TXF1bTIyZEVaRm01WUNLU003U1hUbTAyUVpx?=
 =?utf-8?B?dEl3bC96NUpsdG1IcGxIR0RqMkRxaTBDbTduR0xKcUNMLzluRHRsdWttcVZI?=
 =?utf-8?B?OXR1eHJqQUNLdnVRSnpvMHYzMUVLT2YyUkdJb1NVSlRUQmk5SVFVUExCZERF?=
 =?utf-8?B?dTd6S2htOGlEUHdyU09FdjREemRJZjFNRDd0NEZiVXZQRkhOTUpjZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ddee47-2bd7-430b-a300-08df41a8d988
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 17:09:17.2483 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/LmWHGgAVFL5Zgql0OgG0vZ0SwXClmYEJx4R1cntXo0IlrTbc7LXmnIvoL44QzNUPFJj0L1pvfHq9fFRXv+BKERbiKmnMIpascqeOdt0BQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8538
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas,

On 11/12/26 12:12 AM, Jonas Karlman wrote:
> Remove the duplicate RK3588_PLL_CON definition and the unused
> RK3588_MODE_CON definition. RK3588_MODE_CON0 is used by the driver.
> 
> Fixes: 165d258386a7 ("arm: rockchip: Add cru header for rk3588")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
