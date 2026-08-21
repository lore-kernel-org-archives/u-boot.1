Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D77B0C5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 07:59:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4B35580E0A;
	Mon, 24 Aug 2026 07:59:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NfhPQFJ2SySF; Mon, 24 Aug 2026 07:58:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787558338;
	bh=qDKbHucRqB7toqrrlCEsxZY61Zb/23dSbKkzHBGT04o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VVq31ttilu54OcJqJEuWLge8DHSGGe9layu9VhdxYjVfyRwY0g/ItZ0QeXkOIW7Yl
	 uuYMBeeXmfa1L/el8XwtceQRLJEdagNAUHfJNoX1CNXi8RgmQoomc0RiV0ycYOldxY
	 yGtXbMpdltup/v3QAjEZZHJIuHQ+51yxAYmX66CdY1dbmo8OB9UqiXCJbHjIfCPg/g
	 lgYYnygh81AAIMH/QRYvGxiz//vWpI/snGucfNsUYTmGIu/Y/zElQtyKlDQYM+hzi/
	 LnzKh4wENoFepFdvTCv/np3EOtsLzLWeuFxT4AzgoLSKtfS4ECTVwc2znySGKjhO48
	 nlXZkhqn1TTsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9512280DE4;
	Mon, 24 Aug 2026 07:58:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2FF6841A
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:58:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1457B4065B
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:58:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pKgP_Urw08CT for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 07:58:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=aHLrsEG+
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3DD7040649
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:58:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLUAyqvmQDTYrQKNANBH48yecitsyyoCdsaK3uEXU2+PhnkGA4iX7LwZP8926djzGA+ymoLGaxCGq4sdJ0+R7Oi6H51BcWGHeDpUF8uDYBIf4Sqd15Eq875f9r8wRgX+9zzMmUgpYa2qR+EBtaehqOObc43AVUB20JS1HlqlFlS2pFbnSd9Vpxe0UFRkPicgk2AcSqRnqNdEvtos/5Uqf/jGM/EszjBixhDApe/UFNiBz9aaFinMIroxqGUqaYQKL26UWe5sOlpSzuRUIzLOk7sK7yfYUzu0PxUgNXaYDtitKQmXM0CWVBAJW2NJcJtX7dXIH+xL7W246je9aZNGJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDKbHucRqB7toqrrlCEsxZY61Zb/23dSbKkzHBGT04o=;
 b=u/4p9xLq3OxQEa5frbED9sF/88HMHdVVduSXeeczadrLgkliFJIiHwkn9HUIqf0B/7PTA23Lh/bSu8aYf0nEl/L6Rk96Cp0B2kt1f/D6ivjJSPWTSqJUZ/6n+k3CdSnUj4jfjPF0Rthaup4s5MtplJZ3DJzRpufVcNpieMIqzc3NEnZLwadLZDPFGU18yF9sLOSATf09pYGrLMyEc6/hesHDyalU7LZsPhHuHQlxnldf2vB8ggJC5QwVXc8fd3r59BoHNAYPJPFVrCxUjBN2bzU+6jHJb63qH7kn1APhSXzeiKUn5vX362tXktfk1KpcEE35/x7chYOIl/NTRelhAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDKbHucRqB7toqrrlCEsxZY61Zb/23dSbKkzHBGT04o=;
 b=aHLrsEG+fVv6tESOwWgVp+1dGrlv05qyEjUT7ZRAyIv84buNEBeGPOl9YvZbkAyRdD6KscFmWMzsuGQv/iGA7Hp0sC04Vv0BSwkxBuXuc9Y+UvWchus9hY3jChM7b+kpBjqBDsIjU1c6+ene9aMlbE7eoxe/A0AVJV7VvUyi0vk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PAXPR04MB9121.eurprd04.prod.outlook.com (2603:10a6:102:22b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 07:58:49 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 07:58:49 +0000
Message-ID: <54b4beb9-2410-4107-a087-eb75bb82c219@cherry.de>
Date: Fri, 21 Aug 2026 20:26:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci: pcie_dw_rockchip: add PCIe reset configuration delay
To: ok563595@gmail.com, Simon Glass <sjg@chromium.org>,
 u-boot@lists.u-boot-project.org
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Yao Zi <me@ziyao.cc>, Peng Fan <peng.fan@nxp.com>
References: <20260814-pci-rockchip-perst-delay-v1-1-dde1904d9b87@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260814-pci-rockchip-perst-delay-v1-1-dde1904d9b87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI4PEPF0000015B.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::87a) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PAXPR04MB9121:EE_
X-MS-Office365-Filtering-Correlation-Id: eff14017-4f29-4e39-de39-08df01b58804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|23010399003|376014|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: MN5taNPhu/V0REA7MU12cvDmeUZr1J5ZBZmrkxL/HnYnbo/5egFyOEwIyCHy31C4tiFHq6zQ8TnwAdDVCjMv0YqXANOvTgoUu/j5ZvxyBZ3kAhv2mvBnsdChpFXseKF7QiGxxE2RoGnufq9VrHliJy1TSiI7hkrwDObPdu+yih6NQyWYwoY7ebnt8PdvH3boSQ43dHQZnO6QOpij8/B1abjbZilY+a7t/Ai9OBnp3fpQ8vH529xJX9a/Pu1ZGZPCVjnaKy53xAe3xngBZieWEvNievdZIUzNExpayQQ37HTmVDKnRBU7MtoBgVNmjsT3Q6F0kP9Q23V5JsIQse7q6ztdMYF46vcDPdBgBjXnUhaWbrLUBXcPo+0zEYaPU/tbnDqa8W3VJromr393RhTdTW8sIttaJV8x5zupWW+JyHdvdFQ8ad3rok3hcqTArhywRLBIa9I1m6y8Mi1j0aV98sqvHQikADGSOJa89MW+ul+Bn8KbRx8Bir9oMTxv5KYJ+qw1ZyevklZ60ecT0hyTz9b3cDUzGa4wy/GICfm8aOnb6eQ1Td7u4D7OqB/vnAwTCQ+LBuVFUnlUWF/88t1g2WHAtIua1XxdguYs7vr+3WUmXahpjP9zJQvNySwGmub2AYx2QH5Nb8SaszsCvjDJwohgii0LMUoszX1+IE7iTro=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(23010399003)(376014)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clArTlVTc1plZ1NuNTRRR2xIWUFDZWdwaHJtTEVHYjB4d3IrQUdjK2pRb0Ew?=
 =?utf-8?B?ZzNid05NK0FtdjI4b2daK3pZWFB0T2JBNjdXbHFyVFVibDZmakxmZjZMOFFl?=
 =?utf-8?B?VllZSFZrRndRZlJEZlZtRmRxRkVGdWRBTHpTOTgxalRpVVNGaklEU1lvUjlO?=
 =?utf-8?B?ekkwZG5WUWh1ZWkvV2hxMWpvdy9ZTzdXamNpdVVpcUVORkhKR3RzK0tzL0VY?=
 =?utf-8?B?WmlFK1dVUmNGMTZabDhUbjdPRURhcU9ncTQ4YjRvejdZNXkrT2k5STRyZjh0?=
 =?utf-8?B?QTRPcmlCYkJlMTJZZjE5RmQveFVydmR5VjhXZFRwWUxqZGhhVi8vbHYzNUg1?=
 =?utf-8?B?RHdpczZDWlFaN0ZpL3BvWk1pWFF3VUNHckFsVGxGcjUyT05UeHFXMHkybzdp?=
 =?utf-8?B?RjlWd0plam1HWHM3NlVqZnd6L0l5RWlkbFdCa0xrQnVNTVdkdm4xNDRWTi9u?=
 =?utf-8?B?Sy91MXlRSlRFQ0s5VlRnc0JGM0ZHZHR3WVlpanV5NFFEUC9CUXl3UUZHQ1Nt?=
 =?utf-8?B?eGFnSndjZk1CS1V4VUFSQm1xVkt2MUhtREs4QTdxQjBGUEtRMUdqMjVVellN?=
 =?utf-8?B?bWQwVnhqTlN2UVRCZVQvRzNqczdsZEVJTTVXMXFaSEZvT3hSWWp5am4xK0xO?=
 =?utf-8?B?OGdDMXE4d2EzVjJZSjBjUmxoazEwdXFWclpUVDZ3QVZGa1lYY0xtdzlFaXda?=
 =?utf-8?B?Z0t6akFvRk91aTIwVGUxbERtUXpiOFdJcnREVEpLZk5DKzRHTE5Yb25kSFdk?=
 =?utf-8?B?NG10anVBemdBWHVxR2hVYTVGUmkybzhKa0IveUFweElaYmFXbkFjVFNwSjlZ?=
 =?utf-8?B?VEpJcDFXRm9FS0k3Q2FHcTlXb0lHd0wrNXBtaG5aU2FlQmFzcmtRK1gzUVVp?=
 =?utf-8?B?MXA1aG5JN3Npb0ptbzJqQXFMNkF6alhXTkxVMHF0bDdaL1lhTzlRSW1Fd3RR?=
 =?utf-8?B?TWdDUVBoaVd1Ni9pWnNRVkttS09TL0xBTFpmaGk1RFZNOEhzK3VRYStsWURB?=
 =?utf-8?B?VHJFTlU1UWUwbVp4VDkxaThSSm9RL1A2VWxRbUVEcGlKMDloUXN5RjNaTGhN?=
 =?utf-8?B?bWt5THBsUkw3azFBZTJOd1dhRjhiazNvbFZDTU1Bd0UvWFpiWFpsVGlUUkw2?=
 =?utf-8?B?dkx5S0lEMERyc3NRK0pXcldoNVZzL1I3KytXRGJIUUh0TndLTXNLUGhuNVJt?=
 =?utf-8?B?bjRtUFpaaHJER2pBNi93dTYrc1N6SjBXYWNTRHFuOGhjeFRsZXZoQ1Z0M2lW?=
 =?utf-8?B?M0x2MzEvTE52S01LeUthZzdCZGd5K3FROTNLelZwM3ZzSHEzVjAyZ0s3UmdU?=
 =?utf-8?B?a3loNWxuZXRzaldmcklSamFlaGw4VzU4a3RmUE9VRGhqK2kyd0UxRDFHNUpV?=
 =?utf-8?B?bHJBc0xENmt0UGhLSFJoOXdMRmFKR285ZXl4OUFJM1NxNk8zOVd1TWJaNlNl?=
 =?utf-8?B?RjJkWUJOUUlySGRmcUxlZzdCYkdPNjJyQ2p4cyszcW5JL3VuRVJ2YXJvMmF3?=
 =?utf-8?B?ak5NNUx5emk0WHVLR1BPL3g5S1gzdkd3SjZoMGFaNWV5N1BMSW0vQnRRZ0xi?=
 =?utf-8?B?Wm9Ubk9GYUpoZi9DSEpCZkd5TzRsTHRSM3ROeXFjSUYwZ1BvdFhObDg1MzYy?=
 =?utf-8?B?eVF2QkFpTmlTYXoxYkNBcnN6UHJYM3cxb0xWcW93aWUzSjNQMHpvWEM4YWNq?=
 =?utf-8?B?QUZmN0ZrT3VHVFBXMnY2aUpYcU5ZSXgwRC8zbTdYVWZ2UDJSaTc0TDBnSW9r?=
 =?utf-8?B?L0FnY1JJVFBEZ3Z6MndsbEhjVndOdkpmdC9yS3VSUUwrSjltNTBrdGJEUmFC?=
 =?utf-8?B?UGZBcXR5VnJxc29TNkR2d3VIQWE5MnFxMElzZStZVVd0ZU9QVk5PMk9xSEJU?=
 =?utf-8?B?dk9oRC84TVVxdEFHbmNPS1BRWFF6VVVEWjVmKzZ0WnRaSHc5WXpoWkw1VDht?=
 =?utf-8?B?d25pTXRpZHZKTFlnNnRMMGtIUUVteEVidkxVR092TlVERk0zSWtpb3NCY0tv?=
 =?utf-8?B?ajFqUkd3VFdZQk5IVitXNENRR0UzMXpiRTRvU1doaHVKMytqU1FJWU1qZTkw?=
 =?utf-8?B?Q2puL1BLMkp2NDJIYWRsN2ROamgrVWI5eXJLSTVkWTY4cUpwSjRSaGk1SHkz?=
 =?utf-8?B?emdRbU9wMFprSklkRXk2U054a2N6eEtFbk8zaWpDQ1lLenJaV0I2UDdITkRq?=
 =?utf-8?B?d3JLbEw1dytLa2ZiY3ZjdGRpeGkxREltMzMxWEF1RkJLN1BrVTlnaGtWc1Fr?=
 =?utf-8?B?M3JqUE1jRGllZkFHM0lhanFKaUl3clhVbU5zOUFzR3JUNjc3Z3RGWEdQQkp4?=
 =?utf-8?B?Y1VFY2VkeVgvek5KaEptSzQ1OVkxMkM5cWtUcW03U2RsNm1TZGl6NmRiMmVE?=
 =?utf-8?Q?tNdny2VQJb6IhNKwXyH+/vAvqwf6O5EIflYMVtHwmNTfr?=
X-MS-Exchange-AntiSpam-MessageData-1: CKHXfOALZ42o7H4J08+eTGwd6iXbu5ZxPeg=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: eff14017-4f29-4e39-de39-08df01b58804
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 07:58:49.5430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BiUTYUgRMTNjjcc+LM6tXQEqwwLoA5+O3JVTgqu5IaD2iYk503vOujXmpzFLHmXW5GGVYxvasAYqsI2lRcjJ+FCAQwxQjMyWvEa40DEjjE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9121
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Oleg,

On 8/14/26 3:42 PM, Oleg Kombarov via B4 Relay wrote:
> From: Oleg Kombarov <ok563595@gmail.com>
> 
> PCIe r6.0 sec 6.6.1 requires a 100 ms delay before the first
> Configuration Request.
> 
> For ports supporting up to 5.0 GT/s, the delay is measured from
> the end of Conventional Reset. For faster ports, it is measured
> from the end of Link Training.
> 

Could you please explain why they should be handled differently?

Cheers,
Quentin
