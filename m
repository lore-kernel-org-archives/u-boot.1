Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106AC606A327
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 18:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xS99blz8;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=AIVxoTN4
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8C13640E1D;
	Fri, 13 Nov 2026 18:02:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EZ4Z3QTajFp0; Fri, 13 Nov 2026 18:02:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 84E1240E0E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794592962;
	b=S5GIOCC5CfzkAAxa6peAELPmlS9jQ6zeNslzLROgKD9k6CkD2LZ7ju5SB9Vf4bl6+C8b
	 t6lS4b1jrli1GfcwejLNQglHHxm+fVloF+UPw7Lyo1gUsvc8MikLuAe4seftkat6cmhXx
	 W6y/H3ahlaHjAS7lv1OJwzlfQW6FbwLrwaa72yKd6dS2QVz9l5HYpLdHRx7Davq+kfDdj
	 Kc+Tyj1P6U+0tPryu5kI6yaRIE+l4obKyutAMjMHpo2HBfDCEO61amUd/91KuzSwbjgJK
	 PMZ+wrXhgmjEL54YKQyzgAsOLzXFFG/Jd2s05CoMJMCCm9NXvNK9m7n30oI2pCSRs3g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794592962;
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
	bh=6m1P+7x3ZWnGBA5Do2MnQHr18rJVXTj0rvntO4W8vec=;
	b=cVJn8FVwsqeRYkp+fjNyWpWAu+LpEh/sF84pmuPGAPHl0je/XPn5c13JId3NZHCAiL4o
	 SBMy078rhCnQLcmRLDVxwuOg8RWrU2mzIua39t/oCCHjPBbr1z81u/MpaRinZ1Uv+IWQH
	 iQTbEPug/6vBQe+dfata0vxegf8hjbybYCV/tQc64yC6tRN9Mfq01RgUQPdtdvyH1hPc3
	 nfZQA1eykEKDYv2SVcXAhP8bvTnO8lIXvkDMEqko7+IpJHAIP2yzMgagxQFEhA0//m2sC
	 M25j0nP/bG61yvACzInq9CC2fdumxiIKadnHMRbCIb9nag07zZ+4pbj4sWEAC2sowVw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=AIVxoTN4;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794592962;
	bh=6m1P+7x3ZWnGBA5Do2MnQHr18rJVXTj0rvntO4W8vec=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xS99blz8M/a5XozVSJDoy4axGJ5rprDppaQ27w58JQVXfZBepicx2T4P+ca3GA+PW
	 bx78TZj+Px6FSs4zlmoa701AM3/tAHwDrJBEZRE0KMMJ1amaublVdP7vZbE+qnJNOl
	 8NozzJJf8fg5TZ2WFAePxn/N3KJabINrACI7hBH72upkyYCbvIIZRzEsxh0ovMA710
	 T5cd/zBCTaOau6ugWPqLKshIyb4lluhwFzkLBZpqSdvNrujaRvlynruBqrsFeyNefa
	 UDq4B0Abxs00y6opDQe1FUrrkx+2eIFp7zBZ03MZXDVfU3JEh1K2icJP68xayNAnCp
	 LaEOrvqZHUdXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 84E1240E0E;
	Fri, 13 Nov 2026 18:02:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4DB04235
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 18:02:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2CCE240E17
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 18:02:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ByYSHLmW4RXu for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 18:02:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 086DB40E0A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=AIVxoTN4
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 086DB40E0A
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 18:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6m1P+7x3ZWnGBA5Do2MnQHr18rJVXTj0rvntO4W8vec=;
 b=AIVxoTN4UdNLwWILjvVHDPHlEYZFhi552qheqXGQLfnaCXum99a0+s5hZocYTFgUls4PpOcB5mP7yc8BdXdg6350zojT8REiV2IMgB1FAXB79rKE2P+LJE/symjJ/A1dHgGS3BumxEGbdH80rKtTU6o3J0WEzIAXpXfFiSgAIxY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PA6PR04MB11780.eurprd04.prod.outlook.com (2603:10a6:102:522::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 18:02:33 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 18:02:33 +0000
Message-ID: <70c030a3-1262-4efa-8c32-f1840bec7cae@cherry.de>
Date: Fri, 13 Nov 2026 19:02:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 27/37] clk: rockchip: rk3576: Rename PPLL register macro
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@nabladev.com>, Elaine Zhang
 <zhangqing@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.u-boot-project.org
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-28-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261011222930.1085075-28-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0149.eurprd07.prod.outlook.com
 (2603:10a6:802:16::36) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PA6PR04MB11780:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d438cdd-5933-4a52-c258-08df41b04a80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|261102123227099003|261022075727099003|10067099003|11063799006|4143699003|261021121427099003|56012099006|261009223027099003|261022105027099003|261021123027099003|261026140227099003|261028144727099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: EcIXPOgJBaPxEAtjYtOPQ1kxU49sAI9ZBvqMPM+h9AUweAp9m4nlSIYRBYQf5bxZMHdc4INY11Y21m7focVH8SrF/TGuQvUtPqQ7Pl8UEGHEMXvjPvaeZHy7XCFan5mzV8FCCwZimK6xOnsQjsi1Dhw4b/IAZJ2DNLACKx1cChyTjSrNu5OLbN0JhMKZXRLFx1IZT5qictp2buJw87NaqN/KJIyjoJFvmOb1m7o5bAbZXvh9bNn5SesYEC/jIbafLZQatIQSaPW6/PiW3LY/qVsvJ1P7zk06klgdh//w1NyMiUK/O5MVPyr9Dz6RGj/Aro/CQTAFHpoJskZBd80WfHR09iDEY7hg9lMq/s4LexkQ4oJRX8s+zY52/5+XJ+exrQrx4xSOCNs5dJNft8Mnh0uCEfBdmfB1+odqIMB6uxCVSRhp345vvIYP3qE4OoJTRnSEhiZU+TTNxoVSR/J26NffEZbeoAkwxV943OBQlJI3Pi2jxVleQ4au0DESktt2WdFybXa52W3F7zmHkyq4xBhu5fSAisgfehgNi3IAYKiAvEwpS82asaPDnRlu/W8ubUOPassco0p8tIBZgW9T3WlV+8oXoMgLIZChbriAD7A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(261102123227099003)(261022075727099003)(10067099003)(11063799006)(4143699003)(261021121427099003)(56012099006)(261009223027099003)(261022105027099003)(261021123027099003)(261026140227099003)(261028144727099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0MzaXpsTDh6bHdXbGdkaWx4TnV2N3RwUEZPTnovMnNVM3NOeGVPS1Qwdjkz?=
 =?utf-8?B?SEl6UjZVRHpEMzFaMzhScnJuR1AxY2RjZWxtMHZwVUt3Y0h2b0tSa0Z4MWNJ?=
 =?utf-8?B?SHdDc0RqcnRUWVFoNzl6Ty81Y0xaeitlRldUWWFZT2E2TjFka2pTU3VtYnFV?=
 =?utf-8?B?dHMzQWwzY2U3ckxKMDZGbHp1eUN0OE5uYm45K1g3a0tab3VVZkp6Vmh3dU5m?=
 =?utf-8?B?bWZmLzJXT2Z4MFpsWHord1FjS1VIVDNmOGdpNVl0K3h4QXV6UTQzK0pWeEdQ?=
 =?utf-8?B?SnAyb2dHL1FFOU9leWRGN0JsUWdNUzk5eWRDSTdya2xnQ1ZJcTRNdXh6cUds?=
 =?utf-8?B?djlxcHp6Wk9sRHhQcnlHR05MMVkvcUJ6cm1FdnZ1aW9EZEtDeTZpTkVjWUtH?=
 =?utf-8?B?TUFNTCtSdzhrOEdBcWphL1c0MmkveWJaZlllU3luVUV3M1g0VmRDblNUOGhx?=
 =?utf-8?B?Z1krMHdBVGVnVi9EZEhyUGZPaElJZ0tpWTBuZWpvbnl1WEE1ZVVjdndkWnJk?=
 =?utf-8?B?S3hlWWUyckhTeUVwTythSGtCYzVqdHQ3ZkRVdXB6U0diTkxINUVnSUJ1dEJq?=
 =?utf-8?B?TkZKeVVtc25UaVl6YWtiRVpoOVZYVkxjajdhOG53SFFhY2pHb3FZczUwTTlH?=
 =?utf-8?B?MjJ6ZTk5RWtobmE5Mnk2ekRQKzhhS21LejhjTzdQRURteHB2SXAyMjlJUWJ4?=
 =?utf-8?B?NlFvSnR0QWljQmRlNVBrODFtS04vRGM1RHREVUREU0JHMEhxaEZETCtWZlV2?=
 =?utf-8?B?dytNSStLdmhBSXBDTVhML2c4VlVFSHlDQzd1OUx1aUVzUzFybFhIdlNiRDlP?=
 =?utf-8?B?YkgwUG45SVFIbWE4MjBEK29La0ZTanJDc21NMGlyb3dDcWFVQWREMnh1Znlr?=
 =?utf-8?B?YlBTRHB5RU5wdWQ5MFVPTnBJSlVDMUEzOTB3OHJoaW1qOUw1YUNMMFE5SGM5?=
 =?utf-8?B?SGQxRU1FYW5JNDhOVmxQbzhMRFVJNktFaDNEbHk5SzluMy9BaXdlNjA2c09x?=
 =?utf-8?B?K3BsaW42NDFMN1BSVnFkMENqUThWQzBDZlYxdEhvQlZkdkkyY2tyNDV0elpM?=
 =?utf-8?B?SGtmc1Q4bHdjelNGUGU1b29QNG9GTFpyaXBpUFh4TEVkZVZOYTNNdTJKL0ZI?=
 =?utf-8?B?UkhUU1ArL3Z3cjBRQXVPbU0xOFl4em1ZMHBIRlBrLzBlOVB3Si9EaGdnL2lv?=
 =?utf-8?B?R3duSUhKUDI5ZGRPNzJxMXIvaWt2cUZHK0hudU9VT0ZCcEhmd0NHZExKOWVx?=
 =?utf-8?B?eXEvTHlaaWZ1Q2tCQ0hUcHNoYnFlTDhqaHNQYlMyVzRXMmIyVVhKMlBhemdj?=
 =?utf-8?B?L0lWR0hoeDhTNjBhYWM0Q1Z6N0xDU1AwbVBpeHBXeTlKOVZRelZkbmxyTHVZ?=
 =?utf-8?B?Lzl2RDlZZ2VUUDFQN2p5c0hCeDh6bGVud3IrbTFvMnlBNjJGd3lIZGRhQ1p5?=
 =?utf-8?B?TmJnWSs0aUZ6VlVKRjZnbXYyK2RCai9zZUtBMmN2WnBtQytvSC9nOHRwOGRa?=
 =?utf-8?B?dmJlenNQMWVnY1dxRkNOMFdjdjQwTHlUU2lHY3ZNM25TU0c0MVZlNVoxbENZ?=
 =?utf-8?B?bElkWkd1UFA5TThrRzlya1JRV2kvVWVCOFNNbU9DajBkYXhucVJ0aUhhNjB5?=
 =?utf-8?B?WklTWXNOZVhXbnZML2U5NCs3Q1Y4eGxHQVhGMlkweUV4bE15TWRpSWhRNi9o?=
 =?utf-8?B?czFwaGh0dTNBUWVKYU42SUFhbVVJYVRtRDdaUDlQdUhrK0NIdjljT1RHZ1pn?=
 =?utf-8?B?TzgyYjBQL1Z5aFFodnJkcEVjWFRQOWhtaEVaa2xvUS9KenZXRlZ4aXBlSzFw?=
 =?utf-8?B?SDd4R3FYemVRejlrYXJtK0tUcmVEbG9xTWdTeHRjUHVydjA4cVRvc0lsREQ0?=
 =?utf-8?B?a2JuQ2o1U0Q4NGJVWUpOdGNXdlVTVEc3aWlVamJ0WVZpQjZ4bG80cHpWK0Ry?=
 =?utf-8?B?NHdiL05JQVVmYlJWblRuTjZ5SnlqdGV1SlJVTTMxenhHNHNzTWZjbzRiVzBW?=
 =?utf-8?B?Z0pzUDc4VkRxMmpyUUFYZk5PYk8vUWVoODBQSEczSUlibFFCMWF3dmRQU1JO?=
 =?utf-8?B?M2xHZXBmQXNTT2xER3U5b1Y4ajVKMmFIRlhqN3kyMW9Sak02dHoxNlNnd0cw?=
 =?utf-8?B?dW1LOXBzUEhKYnZTM3ljdS9uRlVtbU5HcDA5MG5EUWFrUzZTMGdqUUhxR1dt?=
 =?utf-8?B?UVYybU1JK0wxRkt4UU5CcEo5TDc3TVZlR3drMGh0N282RklwVmd0d0M2MW4r?=
 =?utf-8?B?a2ZxdHhLZHM2amNQT1ZmNDhCQjhVdHo5TnFna1NjSkVPMGtzdlh5Qk51eENH?=
 =?utf-8?B?SXgrdmR5MWc0STl2MUtUL004bTk4YUhJNzFybDRFbytKRCsyZUdNdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d438cdd-5933-4a52-c258-08df41b04a80
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 18:02:33.3411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lie+eLNDYwDEYgOOAYJGPlDlugM/ELVmBhO+L7g1qDzya+AfRCi2f2gCWnM8sHS70yTfmN3jEzj1b7S0LowtIMOhjlTHEgrUSSHaUJij0kk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11780
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas,

On 10/12/26 12:29 AM, Jonas Karlman wrote:
> The PPLL registers belong to the PHP CRU, rather than the PMU CRU.
> Rename the register macro and update the PPLL entry and users to reflect
> this.
> 
> Fixes: 3919310b37ec ("clk: rockchip: Add rk3576 clk support")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

> ---
> Changes in v2:
> - Split from "rk3576: Fix trivial clock configuration errors"
> - Add fixes tag
> ---
>   arch/arm/include/asm/arch-rockchip/cru_rk3576.h | 2 +-
>   drivers/clk/rockchip/clk_rk3576.c               | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3576.h b/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
> index fb77fbd7307a..380151e0f8d5 100644
> --- a/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
> +++ b/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
> @@ -127,11 +127,11 @@ struct pll_rate_table {
>   #define RK3576_SDMMC_CON0		0xC30
>   #define RK3576_SDMMC_CON1		0xC34
>   
> +#define RK3576_PHP_PLL_CON(x)		((x) * 0x4 + RK3576_PHP_CRU_BASE)
>   #define RK3576_PHP_CLKSEL_CON(x)	((x) * 0x4 + RK3576_PHP_CRU_BASE + 0x300)
>   #define RK3576_PHP_CLKGATE_CON(x)	((x) * 0x4 + RK3576_PHP_CRU_BASE + 0x800)
>   #define RK3576_PHP_SOFTRST_CON(x)	((x) * 0x4 + RK3576_PHP_CRU_BASE + 0xa00)
>   
> -#define RK3576_PMU_PLL_CON(x)		((x) * 0x4 + RK3576_PHP_CRU_BASE)
>   #define RK3576_PMU_CLKSEL_CON(x)	((x) * 0x4 + RK3576_PMU_CRU_BASE + 0x300)
>   #define RK3576_PMU_CLKGATE_CON(x)	((x) * 0x4 + RK3576_PMU_CRU_BASE + 0x800)
>   #define RK3576_PMU_SOFTRST_CON(x)	((x) * 0x4 + RK3576_PMU_CRU_BASE + 0xa00)
> diff --git a/drivers/clk/rockchip/clk_rk3576.c b/drivers/clk/rockchip/clk_rk3576.c
> index a7110b86c063..ce97997c73ea 100644
> --- a/drivers/clk/rockchip/clk_rk3576.c
> +++ b/drivers/clk/rockchip/clk_rk3576.c
> @@ -56,7 +56,7 @@ static struct rockchip_pll_clock rk3576_pll_clks[] = {
>   		     RK3576_MODE_CON0, 8, 15, 0, rk3576_24m_pll_rates),
>   	[GPLL] = PLL(pll_rk3588, PLL_GPLL, RK3576_PLL_CON(112),
>   		     RK3576_MODE_CON0, 2, 15, 0, rk3576_24m_pll_rates),
> -	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3576_PMU_PLL_CON(128),
> +	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3576_PHP_PLL_CON(128),
>   		     RK3576_MODE_CON0, 10, 15, ROCKCHIP_PLL_FIXED_MODE,

I anticipate an issue when merging here as this series was based off 
https://git.u-boot-project.org/u-boot/contributors/kwiboo/u-boot/-/commit/989305aa79a2791da67497fe67ce2cefec61d6ac 
and not main/next. Will fix when applying.

Thanks!
Quentin
