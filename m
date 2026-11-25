Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E99C606A323
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 17:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bOSsfQpw;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=Gk+8kWQd
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 246A840471;
	Wed, 25 Nov 2026 17:07:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ImFQFhhZJoBt; Wed, 25 Nov 2026 17:07:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7A1234052D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795626430;
	b=G8qnES34PH0nKII/Nz+wJlAAtgBoSpmUorNHiv1QPvrpU0uRrwmZ8APAFzB15zP9U2df
	 G9eSSvcvsH8L0728r2QifaHEPMd2TvjypmWaMEJz7rNPO6PaMm2bwZM75vBntsFJIL5Bj
	 cdFD5v4nRHotYvFm6gpc67kLPQ0fnbJgEudRg/yh4vasP11kBCfXz2nQvF83xEwbUTu3T
	 cVHnYIGX5YLWA2mYLlXt0FgiUUttqoKO92ak8S1UxqkLVJSSS80+Q9LZE4vX1eYee5oZC
	 VpUAAKIlEBSkrgAraV+pSR0Q528Dn/MzfBQnGEb2h2KBWn4zmb7RObPS+7GBhKCzoQg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795626430;
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
	bh=lSvArlBf+gQSKG3bfvpdQX8tvTAXGfOAkplg+7aV8Ys=;
	b=LOK/3WR+ekV4tpLqebTqJaBv0FLZNErSdz3akpoovlTr4YbSrH89k4UB+MS1qUZjbEHh
	 QlFcTgWYz1XrWKNbT45h4vWLCh5U4xnCHRrduS1u5cL1vlFooPhWK3+EBcSNNagfdBA8d
	 lLmIBSJfvcyQ9Q6vbPTrkX+IYsQdVSGFN5HXIE5UeSXF4jL92RdtCVHrPFfRO0i11K0re
	 H/o08QfHcVCEccxLLgBXHLYbmzwVX0GXqEfTyBcYXXUle1mhCzApbDQ34b3jQZV4two2T
	 QDs65s5WHyT6E/3qnzlV6KNnREHrMHIFRAX+iYQkeOwJ7uBdedYDAzpwwab9LBTMsLA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=Gk+8kWQd;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795626430;
	bh=lSvArlBf+gQSKG3bfvpdQX8tvTAXGfOAkplg+7aV8Ys=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bOSsfQpwhpXE0/jnZoizOGp13yGMbnqFEKByHsSFS1uc16KqpGXIeAe3tpQzkpVg2
	 sWzsk9p7VhEAt04ejpHGlPPBXKH4qrCwBpQBZ0TDVMYP+mM6TJOr6V33Y+MjsRw9Wp
	 GeGEef8U3K/1QJK50XFZlN427JBKadNRUQeicYjAEDjfNXf67f4kGax0ToWahY1m9G
	 XCHNLz2LALglLy1Mj26ZobQ2tki44AGE9FQEESDBeZq8x43qY29rnN531lig9ioZwu
	 Er7VBXr5ehrt4FRqwvPnAfGHwa/HMEmrLj48L1VoEjBC5a2gKgTYCTEF6NMoVx56Ko
	 zA1qkQnvPVmcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A1234052D;
	Wed, 25 Nov 2026 17:07:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3319A22B
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 17:07:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 248684052D
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 17:07:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AOSlUGoqsI2s for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 17:07:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0720240471
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=Gk+8kWQd
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0720240471
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 17:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSvArlBf+gQSKG3bfvpdQX8tvTAXGfOAkplg+7aV8Ys=;
 b=Gk+8kWQdupaf12g9X087XmLndYKY+9f6GfF9R40wp6qcwQe0qGrR1yR16cTeLJLa6vRMg0CHA4gxBT0w9ss1blI+OPcfUUDPokcTqWBVZTGd1VevWc0Y79Y34Vf7kTPoPYPF6FWQlsWCxVXOiTkSaZ0WVe22P/fdlT+bQEv4Do0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AM0PR04MB12098.eurprd04.prod.outlook.com (2603:10a6:20b:743::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 17:07:04 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 17:07:03 +0000
Message-ID: <ddbf51b3-7b66-490f-ba99-88209bced490@cherry.de>
Date: Wed, 25 Nov 2026 18:07:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: relocate: convert relocate_code to C
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, trini@konsulko.com,
 richard.henderson@linaro.org
Cc: casey.connolly@linaro.org, u-boot@lists.u-boot-project.org
References: <20261125074122.1965495-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261125074122.1965495-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI4PEPF0000012A.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8bb) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AM0PR04MB12098:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a67785-e5dc-4642-9142-08df4b168705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|11063799006|56012099006|10067099003|261102123227099003|261028144727099003|261026140227099003|261022115727099003|261022075727099003|261022105027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: S7M44ymd7bdgZkozQJbIjWZGASdSWyvVz1t0p9adtaIEYH7ocwaAFKePfILsJqyZ9LJg5cxz2lR0lTr1DUzHINCuwwGdWr7KUCitcHgUK2tC7XGN5CvaiVrLhZ2BA17ppcg1X9jg519vgtKD6x5qSHcYirqz5AjpVaNs3Y49mugeu3df3EtBq9yvRUAjmItzlS1/OOEa4f2Ip70p0tWExf96KdLvIIOzsOwhs3/Joo4+KaprxXQ59rIkXLQJIqh1RVlj1L9egnrQG1UXtSSrN2FCVPVYjgkfV4qd6uOSlW2cU2ckkT9bzR+fUSDWbdIV1yeYCk3uYhbFHpP8IQJ1KWT5DatVYL12kD1NvCVdMEAaI3QO5X1SEtNMWcsfaYLFz8s5/blIDgds+9ORMDE/zeBH3wgyMrFxdcT/t4ru6l20OSWvlUOFBy8tO83/5xe2YBserU3U+GjpHcjnE68CUb+GkWNIyA2gWG9v6GBRq02hA5R09c8JmhWgjzKjISEWc3yUgOKrE5MGi/yPGCuMkG9c1HLufVxCp8v0u95rHVhaGb7fJ9KmemYjJB5bgtyeJEOMzyYSdV/v4eAh21NZ9sl4zBZ2SZtK6e44iNsLL5IzXc7vW0XFHmS+RXkpa3d8ue5CxXWyWrNnj/B/xnG9Wwd67QZ0UsVCdjHcvZ+5/I8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(261102123227099003)(261028144727099003)(261026140227099003)(261022115727099003)(261022075727099003)(261022105027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmR2Ync3L1YyNTFlNVo4UTU2dFZKekZwamZYbEFTekkrbjlzOUt2MjVrZW9a?=
 =?utf-8?B?OU15Y05PeWx0MDhVT2RNUlN5QWlRMUZ4d3YwUE95YlArVEorUkd0NmVNM0o4?=
 =?utf-8?B?TzdxNjBuNU5VSlMxWkkxWDBxdVFqa3ZxNWZ1SDg4L2c5M29oYXNQQUFrQ1NQ?=
 =?utf-8?B?dUFKQWNTVTMwS1lpNk9QMm5jQXZ6UkplNE1HTnBZcFNkakVQZGJ6VGdpZDRE?=
 =?utf-8?B?WEZQL3V4dk8zTUsxZWJNbUhKTlZSSVR0eW5kNWJxbXhyd0FVcE5QbkVOY1dM?=
 =?utf-8?B?aFJrQm9jUUtETTVZZ29Tc2N2dnBQVVB6encxaW9SZDNTMy9rQy85STN6d0RZ?=
 =?utf-8?B?WlE0QWxrV1JDVFBxRUp3NXhhYVdWTG4rRnRxZGxmOFAweE5pMGNNTVNuaHd4?=
 =?utf-8?B?NGc2akYzcWg1cDBtUmt4WmhYUzRacmJqa1FqdXZkdjlpVWI1WlVRYytWT3c4?=
 =?utf-8?B?c1hGSlRpOVVNQzFjZHg1eDdqRnRqOU5pUXdFZ3h6alVYNFNCZ0IwY2t2RkpV?=
 =?utf-8?B?SE1waDljNEtMMWlBWFJNUW5FVy9vNzNJd0MzMCthNWFOWVRhWHJhUDlJc0gw?=
 =?utf-8?B?QzZvSUpmeG00RiszaVpGQWlpa2xvS3RFajAxQTdDaC9oUXZpNDQzcGJEeGNl?=
 =?utf-8?B?Sk9BYTdYNWwxN2JxODNGUmRvQXRTK2JrV1RKK0hIR3VlSTVyeEV2cW5SZ1Nx?=
 =?utf-8?B?YkluTVpCK09rK2xoR0wxMzdrSEpsUmJNeDhFaVMzNkdKemxQMm1YYjRpREVW?=
 =?utf-8?B?bkhUUHJURWF6TTRqYmdYMWk4Rko5RnZpNmV1aE56amR3VTZSelJkelZ5cEZ4?=
 =?utf-8?B?cWZITkJtNEQ2RXg0NG5Mc2pPdWRjWXAxOFNUVUJGczMxc2tSRkcydjZ6WVFE?=
 =?utf-8?B?Sk1vcmJBMjMwdXJpTVNyZGxKNWNjeGN0V1V2Q09EWnRadjQ0bSs4ekVoQ2tB?=
 =?utf-8?B?cmdCeUZham9MNmVIeUNraVVTcjFtT255WUxxOWg3OS9ienNGaXVicHBGRzJH?=
 =?utf-8?B?ODFyVW13ZXY4d1N1VG9xVlpZTWFtS0N1RE5IVm00RWpyY1kxMG14SWh3ajVW?=
 =?utf-8?B?anpjTlVKQVYrMkwrRmhkSTAwKzhIQ2I3clcrVDFlRzRROXhxSFg2WVJBTEZD?=
 =?utf-8?B?VlBqQS9oZkx2MTJLdDFhR1dhQ3FWcm1KeElHMzRNdlhjZlVYNzQ1M2t1VDY4?=
 =?utf-8?B?Qy9QSEJaMCtnc25TazY0SHRvdnhhL0NOT1U2NUdxUHE3N1NUemRtZTYyV2c4?=
 =?utf-8?B?NGVHN2VrL0VSc0JNcnpQWlZFL1NMVzNLZ25CNGhsSEVONzd6M1RRT1hocUxs?=
 =?utf-8?B?TWNXWlF0YldOa1FkOEp2TDZORXVGMXhyVndDWitiVGxSUXdmVUgxaXJYeGdM?=
 =?utf-8?B?Qk9tZ2VYd2NkV21ZTmJ1NytMcmRUeEI3L0JLMzZOSlIrV0xTM0dKYkF0a29h?=
 =?utf-8?B?S0JUK0w5cWFjUysyejJ3VSswZFFtQk82YXZpM0N1TzZhWXVyc2U5bXVuMU96?=
 =?utf-8?B?eXVqL0t0SzEvOGZLZXpNOEJBYWRvVWNiVHFMSlo2WURhb0FPWEd5Ky94MjE5?=
 =?utf-8?B?ait3UzlBYTExbFIrUmd5U1UvYUV6djUxNU1DRGh1VnBiaTJPWEp0TUVUQW5D?=
 =?utf-8?B?Y3J1WDBNRDJSb3Nld1VjenZCK3JVdm5kOUdTK1J3bHg1TzVDQThXQnBLTGtS?=
 =?utf-8?B?ZlZ1dzZCR1drSW5qUHJLTElxcTU0VFNYN003QlpBeWhiOEFYeCt3RE5JQ3Ey?=
 =?utf-8?B?VExacUVQZ1luM2ljaTcwWFNPQzBHUmI5OGg1VEdRang1b1BZTmRrWlFQczZ0?=
 =?utf-8?B?ckRKUkFNOU9kblhFYUN3aVBGWGs4a2Z1YkUrN1JLSlI1S0xPUVQ5LytkS1o3?=
 =?utf-8?B?YTJNUTRHbUVDN2RHbzU2ZDlzekNFOWNoVWo2dnhFZ2orYk5PZTN4TityUDBZ?=
 =?utf-8?B?NWRzQVQvMzF1WWJtdk83Qld0V1pQcVpuSDBxeWdRMHVweSs5cmF0dWgyb3JI?=
 =?utf-8?B?RzhxSTYrWUhNRzYzVE8yZ09PaFJYSVJiTHFGaGlDQ2luN2RvY2dScVpYOXli?=
 =?utf-8?B?bDErNTRIUVlVVllrS2VMTDhGWUxlZ1NYNWtOeHMrblZwYVBpQUczYW1QSHhM?=
 =?utf-8?B?YVlQQjNhN2x4OFNDTWNnbndqVzVkaUlJcjBhNFRURzA5NWlkaUF3a3RHbDE4?=
 =?utf-8?B?ajdHTDg2bWVqS3dqYXRSMFRPYlREUDlURlBrK3JIV1hpQlZQN0EyRUFhVlJR?=
 =?utf-8?B?TWFqOGRuWnl1Y1Z6c0Q1VWlqRHhmaTMrZjBDZk1oOEhmY3daYjIrVzR4M01T?=
 =?utf-8?B?OWdteFhNaVgvUGNjSzhvREY1ekFHd2NRZENCS0ExVUFGdURZdDBTQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a67785-e5dc-4642-9142-08df4b168705
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 17:07:03.8733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B4H0QBCpE3VRmFWcuxfZIAqyTFTn+f33dtLzLshDnbyfD9/xBy+bX46lSQc6F7Y1ir4zG7hYem78miLUGjpAM0xa9CgDGWjKExvaN6OLBao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12098
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ilias,

On 11/25/26 8:41 AM, Ilias Apalodimas wrote:
> relocate_code() on arm64 is called from _main with sp and gd already
> pointing at the relocated area and lr pointing to the relocated copy of
> relocation_return. By that time pie_fixup has already run, if
> POSITION_INDEPENDENT is enabled, the image is fixed up and plain C works
> fine, like the rest of board_init_f(). So let's convert it to C which is
> much easier to read and maintain.
> 
> While at it change the behaviour and order of cache maintenance.
> Invalidate the I-cache after the D-cache clean instead of before
> and add a 'dsb' between 'ic iallu' and the 'isb', which is the
> architecturally required sequence.
> 

suggestion: can you please make those separate commits?

That should help us if we ever need to bisect this change. If it was 
only in the conversion from ASM to C, or if it's related to the cache 
changes?

Thanks!
Quentin
