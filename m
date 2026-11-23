Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432B4606A31E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 10:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EZ9sdLv3;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=SpYv6U3Y
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1AE6280B9D;
	Mon, 23 Nov 2026 10:03:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kYQITWsVL0It; Mon, 23 Nov 2026 10:03:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5280580BE0
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795428211;
	b=snfXvdUJnEBn2H2upEsEIgCBQUUr/sIq7t+PxmzAzmuddwqdzEiYD7iUlMEu/wXlRZdU
	 3WXcsFlFN9P4rsipZxhgrS5gzoQNb2pOlNnvk4uL5Jthv1+Mk1HhdF+siP+zl5dMYyXkU
	 Y/slnJsnwg5EDsr835Le5Sl6bm3dL7j7gZuKiB34OurPnNwJUeQ8JC4z10lXv8R9Te0wn
	 +dXIAur9HTS0WPIw/u20gmKUvY860CG6/dvZNBejKADAvzeHlcQMhStQWUp5xVdkWYoHS
	 8lMrqny6JHY6JpoQFXjpvFrW+qDAgRsloFrU8JvK9XkWZN3WTnlV53+6v+0UwCSkIzw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795428211;
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
	bh=HMeI5xfZIg4b5rCaYgukmP5IdhsD9ku9Ueki3b+BLko=;
	b=fAkfeSWzfOVHQyshTy1tlU0FJYUiA4fLtplStrerwOyxim2tXzG2LNQ0REEOravQ19j1
	 YrgVyFGFbI3odOT2JVDzOSUeE1DQnAr5QRd3YIhyqlDiC9Bcb8/UB4S81+lAmo8UT6WEO
	 /wFjsdLFTTfRW6QrIWKHM5j2Zr8/BJnB31q635JGRlfcakZOj3irOuiVxWsA6++8SW7i/
	 giWXu0Y93srNjIyMIwZentvh93T7MJrW1K2NtLgsMeJe5trG23+X4tIJXoCHEAzuaNiRD
	 aaV9xnLPAFPI7FsT6qev9/aZr+HUI4lYjvwzZg3Oaekddgr9rZsLzw6oImuCjR2jLFg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795428211;
	bh=HMeI5xfZIg4b5rCaYgukmP5IdhsD9ku9Ueki3b+BLko=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EZ9sdLv3MQzjz6W+BqqBf8r9QcIosmtNqhFm5RwSDJBgJ/TrENwfx4ip2YL5xJMMs
	 VA4VchtQx1elky2jaQMBh9/YcdxQZK5GeASR4qOvdlt5jKFLgnBsENz/Lmv3DYIEhl
	 D4Qlmiwi7qdyLlRF/9tTpeQQ79JkFoVUNBmeePw/0bGwB5HORJYRJonebr7PrWKZVN
	 C4Hif6EXfp06iBKU/NbijCBh97WxOa5ignm3gJdmMzK4uo8gloX9LoaeJvrKde24/F
	 Sp09TZnCGdjrjLJdUxNsrSyF67LJI2Hg3N+tpuWM/feQWy9D3lsd1+H/t4diWVTMNn
	 QRB/Uo1AZuRKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5280580BE0;
	Mon, 23 Nov 2026 10:03:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 51023260
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:03:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 35FE640098
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:03:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jj4c84yWKjMr for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 10:03:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org F2D014005D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=SpYv6U3Y
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F2D014005D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMeI5xfZIg4b5rCaYgukmP5IdhsD9ku9Ueki3b+BLko=;
 b=SpYv6U3YOKUVJZRO0QFfE6g/1WLujVdKdkKxWiyCnsWnrWi1bvSS/0d3jenQIsFE5bOWjo7kAAnAL/oQodGsLjDA9swLfMeA3pDj2lG1ysfwlzN67zZp8gWtMcmTzztahqykRW9wGodawR2mVguvDM6nu1+GaIfAxp6XKdVipek=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by GV2PR04MB11681.eurprd04.prod.outlook.com (2603:10a6:150:2a7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 10:03:20 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 10:03:20 +0000
Message-ID: <c696fda9-d2df-4ea5-beb3-d67c9b3724c8@cherry.de>
Date: Mon, 23 Nov 2026 11:03:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 3/8] clk: rockchip: rk3506: improve PLL_CON() user
 friendliness
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <foss+uboot@0leil.net>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Quentin Schulz <u-boot@0leil.net>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski
 <lukma@nabladev.com>, Alexey Charkov <alchark@flipper.net>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
References: <20261117-rk-clk-better-con-names-v1-0-25521d4e37c3@cherry.de>
 <20261117-rk-clk-better-con-names-v1-3-25521d4e37c3@cherry.de>
 <94e836e4-fe65-4891-839b-1998c02c2b77@kwiboo.se>
 <d4467ddf-13e3-405e-9c89-93bdeb02a5e1@cherry.de>
 <c336839f-36fd-42ec-9db0-322d5c13eebe@kwiboo.se>
 <01cf9193-94e5-43ef-a566-a428b2ffea8e@cherry.de>
 <CAC928HbeN5Qibkie1_scStvvxKZb-5PxKPe578DQhLE2WpC8_w@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAC928HbeN5Qibkie1_scStvvxKZb-5PxKPe578DQhLE2WpC8_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0559.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::15) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|GV2PR04MB11681:EE_
X-MS-Office365-Filtering-Correlation-Id: 58cd6e94-201d-4707-ef93-08df4949000f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|366016|261102123227099003|261026121527099003|261026140227099003|261022105027099003|261028144727099003|261021123027099003|261021121427099003|11063799006|4143699003|56012099006|10067099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: HTEWwNl8k2lpq6kuuSB+oOnKTdi3qCoNXZUlxmmD8lBxPIleAJY1nSBh+OwWsN3maFT3VEy7lt1SpqWNVcatuT7lRmBPy2IcO2dGibGIzP9nLjM9mWpNTAp5MxWeRLivSJfymtUMvWBe/eTYpvLLIdvuZupD/AZWg4VIBNQY5W5jAv77bwWV+q6hGIiRdwC6LupZ7SWilHhV7LRymA3m0mf+wFcqZvD2ZuuNzvImREFMGhel2yX5Y7HGJsijWcyFA8CKhGLZyIfMLruV5dUb5dWbLMJ9cOijBv6E8jY1egBJzxnisjvpwofUeauCEyIk2qaU9nUIPvFhyKJNnjDGbtNE1B9s937B9RRGk84iBQdXL2Wfbc3phWPHy8z20agUY4RAm5paVNZ335OgaL0ceoF4nRBTTd4BvFZcyIVeTj4+p7/8iyIrR5AQor0a0ZxV0C3+mvRGnNaspGzHd0ESJPe7fngAqj4j+AoWPoRKtaE7e+kYbb99v+Q4TciB6HWBbXT2bS0tJByOBGQhAEAjP8rjoIV9GiUVBDaZY3NMNs4TtmiQp24OfX65UPw5Mv5fOLgwE1j3p35wl3BpqfpY2cPTHB+qBXVB5g3s6t7xgppuM72T5+rGWlZKECZP9RYLfWzlMBbc0zuPWmnPPxYMMcBkFdmNtycDS8RHv2Qqdvc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(261102123227099003)(261026121527099003)(261026140227099003)(261022105027099003)(261028144727099003)(261021123027099003)(261021121427099003)(11063799006)(4143699003)(56012099006)(10067099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDFWb0ZLcVJpbHU1UlBGY3lmSmtxd25jbUtNdTZKWENIZlhMQ0k4ZjlsVVk1?=
 =?utf-8?B?UXNkMCtFdmxNWG5WNFFoSURTZXNaS0FBK0tsbllDYlgxZGRZbmo5dThBb2kw?=
 =?utf-8?B?Y1ByQ0d4d0RSZ3owQXRRSEJNUEMxSW14YVJJWC9KWXZySWZ2SUlkU2h3Ym5J?=
 =?utf-8?B?ZDV3Y2N2eE52WU9SRXJMWnJ0NnpwSnkvU29yZXhkR01uT0dhQkQzWFZQZ0dD?=
 =?utf-8?B?Q0E5OVZTM0JjWHVTTlF2QzhlVCsxOGQ3RVdlWnlNYUlQeGd5OXNHN05lTTBB?=
 =?utf-8?B?RG1NWmFHT3pXeXhiV2wvMTNQcTF2bzZGcVVkYk9yTmMzOERkSnFZZDFhazdi?=
 =?utf-8?B?UHZZTXd1WlY5ekExZEQ5ZW9yTEs1OGtEeVB0SEc3a3dVMVFEWFRRUncvcFVE?=
 =?utf-8?B?SGhKTXhYT1R0eDYweWpjcHJabjZqRGN3ZVJ4NU9jZjd0SU5IMXdpK1U4NTY5?=
 =?utf-8?B?ZEdST1FKaTNHdU82bFBCUEhXT2w0SnJOS1Q1V3UwM1RHMkt0Y1R1dXpLK3ZO?=
 =?utf-8?B?bVh6ejF4MVJEa2Y5TlZoRFJrTENMd0J2eGlyamdyQ3dzaVI0aHEwdkxoZjdW?=
 =?utf-8?B?czBpMlFoOFBmMG5KRTI3RHdQV2hqaTZxY3hjRnJlcXdBRTNOZ01uSjJ5aldO?=
 =?utf-8?B?bndqQUJ5N1lyNDlBVllMdlVPQTl1QWpYc09qNlU4WUUzMHhJV25CN2h1MTM3?=
 =?utf-8?B?UytLUVA3cGQ4Sm42aVc5QlhFTm5ONlI5TTBSWVU4MFFuZXZJOTlqSzd4OWYy?=
 =?utf-8?B?b1hqVTg3QTVUdkdUaW01Z0tEY0g3bkhBSnY5Nmx1aC9sR1ZUU2pyOEdFa3Rv?=
 =?utf-8?B?TkJveGR2V3Y4eDRFOWRSMTg3OFJySFdzYllWRHQ0d1VobldoWWFjZE5jVjBK?=
 =?utf-8?B?U0FjTUhQLzJ5UEpqei9HTTVlWHFCNmVnVldoMmRpOFBuWFU5SUJmR3Roc2Zv?=
 =?utf-8?B?TG12MzRtZy8vM1FINVk5c2MyZHpkSmxaV3lZOUpoTGxnRkI1UFhSV1JpaDA0?=
 =?utf-8?B?WUl0QjN3TnhxeTg0OGw4SmxTRTNzU1pOd3Y1RlRzQVFiTk82MSs2WGxLeFIy?=
 =?utf-8?B?ZzRJOGtrTXlWTGZlYlF0ckIySVdTK1NvNlQ4ZFdJaHcyaTY1T2U4TzNDcnZ2?=
 =?utf-8?B?ZE1DK2NFVjJPRngvNGFOMnBxaWM1cDhUMTdCbDhScVdaNVpTNlNLWE1nODls?=
 =?utf-8?B?M05rRWVvRjJJWWs2TThNT3ZLRzFPSDRoWDJQbXEzeFozVFIvRmRhUUhIaGh6?=
 =?utf-8?B?WjR1T3VqZU5uSWpoekc2Q2hoTEp5LzdMQUYyejNrZ1NTN1V4Y3E5V2k1Z0Nn?=
 =?utf-8?B?SHJGZjE0ZWZxWGo1WUtuUHM5T1hOU3o5aCtEc3Mya0ZJeGFjUzZuNk52MFda?=
 =?utf-8?B?MUMvMHNpd2FLazJDVmg1RTRod3pManpnOWhpVUlYWXRkTDNkZ01OR3JKNnl1?=
 =?utf-8?B?N1Q0LzUxTGM4WjNZWndPWm84SHRDeFJtS3pjNmZZenczS0ZUVkhLaXYrYVBY?=
 =?utf-8?B?K0cvamtQZnVGUm1IYTRjRXRJSm5NdkpJN2JUMXkyVnhhd1B5S0Nua1JjQWds?=
 =?utf-8?B?WGdibVNJSXgwRUhYbGxsakJaN3hDZ1dtOEtteHMxRWVvdVlVOVc1c0FDT3A0?=
 =?utf-8?B?azdzczEwaFFjR1Q0QzVTSVJjbkYzUXhiU001WDg2UklzUzdUeldyYUJIMzU2?=
 =?utf-8?B?bVlUNmpUZWFXcXYzVU9ZNmFRUHRINi9KOTdFMFo4aVg0aFB5dVNxS2Y2UkF4?=
 =?utf-8?B?Z2RxRXh3T1FOMzlqOFo3V1c4dE1MOXl2cW84c1B2ZkZYUkpkSVFFeEQwR0JR?=
 =?utf-8?B?UVFSSFp2NFp0aW02b25qd2JmZVdSQURzNndFMUVQbk1hUmZHQURaTVUxQjlZ?=
 =?utf-8?B?Q1hTNUxPSTJZZGxmaW0ycGFTT2VHWGN6NjNXTzJld1YwRG9GTzJlaXM5bnpP?=
 =?utf-8?B?ZjU1VVVnNDA0bWJxbmFwc0hISTFxWENzWjRRRTgxOG5TN2ZVdVpFakM4WWRU?=
 =?utf-8?B?QjA4d3FYYXZSaDlyS1AyQTBTRFJIR1NKdnpnVTVnWFR4QzdNSzd3ZlRsaG1p?=
 =?utf-8?B?ZTNvaDR5Y3F3bVNzc25heHAzamlkU0lBbGhrNzFPZHFVeGR1YUJZMU5GOHN4?=
 =?utf-8?B?c0p4T2R5RDltR0JiRDlYZWJ1T2dDc200VXZqMW0xdDIwdlNkZ1pwUjBuM3No?=
 =?utf-8?B?QXVCRlI5N1VMaUt0MzdnSksrRGFpbjNBcFBZQ3hhcGQzQ3B0YXdZeFVMcE9a?=
 =?utf-8?B?bDZ2ZkxYUjREbVNZZmYyRURtSlB0blR3N1EwWnBCbTBuQnhVYjk0WGltYVlk?=
 =?utf-8?B?c1JuTk9ISkRFcjFESjdvNGdjU3FHU3VlOHhEQWozbHR2eEpiaVBhUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 58cd6e94-201d-4707-ef93-08df4949000f
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 10:03:19.9676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1tFfdddD/FvTDSJGgh4py0LS+/dMdJasBZKpseHYdbzLNY17+JH8XvC3dmaMvjnWDwSD5WbA2t8l9NPbsYK86BlsKLRhE82sZsiIwYm91Dk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11681
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/21/26 11:38 AM, Massimo Pegorer wrote:
> Il giorno gio 19 nov 2026 alle ore 14:15 Quentin Schulz
> <quentin.schulz@cherry.de> ha scritto:
>>
>> Hi Jonas,
>>
>> On 11/17/26 7:49 PM, Jonas Karlman wrote:
>>> Hi Quentin,
>>>
>>> On 11/17/2026 7:06 PM, Quentin Schulz wrote:
>>>> Hi Jonas,
>>>>
>>>> On 11/17/26 6:59 PM, Jonas Karlman wrote:
>>>>> Hi Quentin,
>>>>>
>>>>> On 11/17/2026 12:37 PM, Quentin Schulz wrote:
>>>>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>>>>
>>>>>> There's no PLL_CON8/16/24 in the TRM so one needs to do an additional
>>>>>> lookup the header file to know what exactly this refers to.
>>>>>>
>>>>>> Use new macros that reflect the names used in the TRM.
>>>>>>
>>>>>> No intended change in behavior.
>>>>>>
>>>>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>>>>>> ---
>>>>>>     arch/arm/include/asm/arch-rockchip/cru_rk3506.h | 4 +++-
>>>>>>     drivers/clk/rockchip/clk_rk3506.c               | 6 +++---
>>>>>>     2 files changed, 6 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3506.h b/arch/arm/include/asm/arch-rockchip/cru_rk3506.h
>>>>>> index 9ddd6215fc53..331b100ced54 100644
>>>>>> --- a/arch/arm/include/asm/arch-rockchip/cru_rk3506.h
>>>>>> +++ b/arch/arm/include/asm/arch-rockchip/cru_rk3506.h
>>>>>> @@ -48,7 +48,9 @@ struct pll_rate_table {
>>>>>>     #define RK3506_SOFTRST_CON0             0x0a00
>>>>>>     #define RK3506_GLB_SRST_FST             0x0c08
>>>>>>     #define RK3506_GLB_SRST_SND             0x0c0c
>>>>>> -#define RK3506_PLL_CON(x)         (RK3506_PMU_CRU_BASE - RK3506_CRU_BASE + (x) * 0x4)
>>>>>> +#define RK3506_PMU_GPLL_CON(x)            (RK3506_PMU_CRU_BASE - RK3506_CRU_BASE + (x) * 0x4)
>>>>>> +#define RK3506_PMU_VPLL0_CON(x)           (RK3506_PMU_CRU_BASE - RK3506_CRU_BASE + 0x0020 + (x) * 0x4)
>>>>>> +#define RK3506_PMU_VPLL1_CON(x)           (RK3506_PMU_CRU_BASE - RK3506_CRU_BASE + 0x0040 + (x) * 0x4)
>>>>>
>>>>> Please consider something like following:
>>>>>
>>>>>      #define RK3506_PMU_CRU_OFFSET           (RK3506_PMU_CRU_BASE - RK3506_CRU_BASE)
>>>>>      #define RK3506_PMU_GPLL_CON(x)  (RK3506_PMU_CRU_OFFSET + (x) * 0x4)
> 
> I agree and would also suggest to keep drivers aligned not omitting 0x0000:
> 
>            #define RK3506_PMU_GPLL_CON(x)  (RK3506_PMU_CRU_OFFSET +
> 0x0000 + (x) * 0x4)
> 

Yup, I too saw I had missed that in v1 and already had it fixed in my 
local v2.

I'll wait a bit more for reviews on other patches as this one here is 
just a cosmetic change.

Cheers,
Quentin
