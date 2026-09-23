Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BA1C9830B
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 16:37:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D4BFD4054B;
	Wed, 23 Sep 2026 16:37:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Habe7UJ-K0uh; Wed, 23 Sep 2026 16:37:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1C0C340520
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790181446;
	b=feB36LtFA6JvaER3MigfSd3/HcBMeQYLuX0ANcGFjG3SyroLMn52qWoaetfT8WIb2zRj
	 R0uA9E+MG8c0hROsujXpOb62pCh/bbf1GugoVR5QkJKGLjLC57sVEfcxMHSio2EeAXfvC
	 qttbTymLr0BXwdnMk6A7St+lMOTeVDAJUbYqXVCLyy0JSgcOoBMPZv0eltra2mCKcLkBm
	 XJf98siBN0Lvtwnj+PJlNvCIK0/CDIMcy7M8zK2lxc9zvG4Jkz1cFR+ZUR95AX1UQKGGx
	 Z9ypeLMs7QuFQ3knLeCfdkV91Z+skcsJ6FOKYTMMO1zwEbmS4Xc+r0b3V9+jPkGLj8A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790181446;
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
	bh=fbJK2ojHNK1/diV44OlyEXlNmYLLwlLA/u+OtQfxTAI=;
	b=AxGRjpb8Yzgt7S7u7Q/ULKDSJTWBBv2Oo6LvIeCao15YbO0+XzqWd7qb6nsvomQ4dqoG
	 IzGP9JXpjCHZFjIB5geAvJaVEncRogLtNejNXXtHwJf/y00AP6zPkdoZm3GmDXP3Y4HNY
	 4gwY4OrOI9MMRzr1kcClKRxyZk2NOfc9icmMbWrltl6ccVyX3wTamvz5CR6BYPWd3jqMB
	 RuqBASC6xWWhbFZPlOH29VMQMpy1My3T8YF9+8QrEZepwvvf5HrAyCEVNc2XcEIT7k8Jw
	 GdQy/PcqRiXtNBcxCxHxvmAdk8L5ZnG5T9seGoi9kw5hS8DYg2U9PY7ZzgyPAPuL4cA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790181446;
	bh=fbJK2ojHNK1/diV44OlyEXlNmYLLwlLA/u+OtQfxTAI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SfwQjQZS+hTEF4NPHB0+h5c4F2l4oOfBldUk1PIWBkFzXnDYkcr0mXbGCBfrd+ORY
	 12pfCO8HPBulJy6E4W85zcduI2AXi6TCdkcbHRFoClbofT8qrshPM0wHQuSmw4sinw
	 06JbOazNP7l6d6UUrr/SXZCRh0t7Z6VjrUZ0YeRDZ9hefptVgalruHo4vcgl2lIrWo
	 GLGYte9DkwqMwowgtrOXumsnZZCuvD0XBOaP1j1xYOQv2ZJgwbLUabdaDtDdJcGopu
	 Vvl/PRsn4wpP/SDKJTyWnthWT3VVPwgp1abaL216bAoYYzU2wEKykwMlxGg2X/L09y
	 VlZU2bCyA/D5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1C0C340520;
	Wed, 23 Sep 2026 16:37:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E6AFA29
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 16:37:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1342A60765
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 16:37:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JZWC2dtU48gS for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 16:37:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2A184606A8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790181443;
 b=Z1gUp36wCc7mK6GwCm9Hh48bfapl6wD5fHlbbIeie/5TD2NbZ7Lx7vO3bLwaXRMzh3Lo
 KvE7IjY24jAjtTPFdletcM6JAmHL4ele3bQ2GvzOcP2bUQ4g0c3Li5qrN4Nj3jyIFk+Qm
 sLzE6uT/8PVneXpqvA3R6l3X8gUUX83FB9eWNn4pikGJvyeTs/pP4fNB09Im1JWl6eesz
 yZO5ZYG8T5XMNTvgEueIuIDKSnjxnKxon7IvwFIIVnwtYrCVstFcOUNp8gyET3sTSPmGb
 W7z6UMAy2vipexO6YQ7GuWql6qlNfKjY7KLfHA1ld0wg8TQzvzyJXXZLnfKx/d7FNzQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790181443;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=fbJK2ojHNK1/diV44OlyEXlNmYLLwlLA/u+OtQfxTAI=;
 b=IeQyGGKnNXm4XIrbq//Xp2wO4rVWB5vI3FZCvaiM1brIeW1Zl4yIO2iqhlsnWzlzkAtN
 H3LhenI79WZrvjUgf25pse5zu27Prbv7IRat0cKW7zfGgUeqz15SJYqf0F+Bw+CXsoj/1
 Y2M3fnEymfjI80mycsm+vMcI9XlVdjq3Y1bA7BOEG6e1c+hzO3jwhZoJAr6X4JWZmSg6D
 GmNCWyefIcxHU+vlUPJcaGKUlfqrEr76LoRlCjteZrhWT7f0TZSdfzHt3YmvZm6tRib5E
 0aUNAvXx0+JqhCuZaNMoTG5hAi9V1F0Tml9SDye8O6z3mXkjjLfFly1gUe/Bb08Tsdw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=cherry.de; 
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b="X/WoDuRc"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=X/WoDuRc
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2A184606A8
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 16:37:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0jjwqe8M6uyko2bW1AcropZR+8h/ZWkLUijkXah5NYT8pk283oUzm34t1hyYPeMDmZ3EkaYzV9JZvhlE5+sgjl/oi+P9MsX7Vb3AGcROIyxU10rAfk7mA1NIkLo9rtu2O1vyjVpcHCtEkBiG0ICcPqrWSy2ZiaLggEaVLswAHurxfvGpwVzztJqCARsB/9Xjcplb0SCFbQtQR1cmu7utSt/PS766F/c3xfJbLShzF8SvhFHdpudcOeHvRN5xLZCRYDkfrUSVSCVslFEZxLmbzQlhquPSvQDpGt6OOJSb28VpC54oYynkuTBi85dowyZ0//xSSF1649W9hbMg8CeIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbJK2ojHNK1/diV44OlyEXlNmYLLwlLA/u+OtQfxTAI=;
 b=m2Spuj6Tj//ZQxn59XcfP7Q5b51Q4CCfBGQaRxrxIxGP0U/pwtgeHPscVBsBjexAsT+0x8hATuPcktU5PnCy6WLSlkYsKYSQxuFDS1TxBSzNlj+L+xiENPOkxgrlo4ooJdWJqXr6yXBWLK9Z8/VnRdLXflTnoKk5XU2nLuOcHVPZKcBjQwPFXkJFZ0hkAAghW4DR1MW1Rx7r4OKjVIyxbDmIWtMQdhoNRbt5E/9cPpIdnB3YrCAf27nL6kjEM0mQEin1oSdS+tR1qH8aaRqmStIORasqxQ3A+rpS9qOf2NrXx0twgKj+OfdbP5JcWEWNCc12bhfxiz5KHS1wUTjLRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbJK2ojHNK1/diV44OlyEXlNmYLLwlLA/u+OtQfxTAI=;
 b=X/WoDuRc3JMjFcAFQAs091hPavco+Y3wviKJ++So4NT1nXMcfJysupRH1YAxV1YYBTejkyuUqDIG9d7Wwa5M9x3Hf9SsJBDHzJ4TxoeJOx1HcHmI2Oi2emu4OQqCZwnaNO5kYdjRXNr3hJWfytenLTJh/Y3XftpJrloXsUrLabY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by GVXPR04MB10825.eurprd04.prod.outlook.com (2603:10a6:150:223::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 16:37:17 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 16:37:17 +0000
Message-ID: <b188e6b1-32cf-443a-a0c5-7a733e023517@cherry.de>
Date: Wed, 23 Sep 2026 18:37:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] boot: fit: use constants for FIT property names
To: Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, Anshul Dalal <anshuld@ti.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Anton Ivanov <anton@binarly.io>
References: <20260923154610.339153-1-aristo.chen@canonical.com>
 <20260923154610.339153-3-aristo.chen@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260923154610.339153-3-aristo.chen@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0128.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34a::9) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|GVXPR04MB10825:EE_
X-MS-Office365-Filtering-Correlation-Id: c5e881d6-f9c1-43de-53ef-08df1990ee55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10067099003|56012099006|11063799006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: oBV8z9c/wlJn99ZDXWBUjo7Zgji78im+isYVa5+0VXl30nrZKJ0XEIm67WObxbwWplRrjNhDkVGVqP5qJJi+dfqREPusUsPHvBJIYpbZUFpDrMjTgb33u9jlJgLurF8sCavdICctBZ3vpq2nqkUREfLJfDj/Al95+VWYwgDP7zYUhDieAUFg+fcixZV+MhIAEUGzNA0NJSxTF+vQbibDDHSFjV95lCDeuhmQ2DlIEJoSIz44zoO5ndY/eDLP04i3PCYjlnZm9ViG487XaSdPdq4oUlXv0zL2zsgEvWmuuA8aa1hZ4KsAakL1D/TcSVV4WY8/pndMLLmSUf2ESrjq1klWOa9UnvAJcnunf1ftd6cD+cx5UO0wceHijPL0gB/BhRRrF4CKQpAvpv4esHmdt07tfCm9cwDMN+AeDdOe/+C7lmXwqnyveTh+kgLb+XFZyD9iyKwjmZK9qidnk3tt/erOTMWDaQT6g0lQ5dGT8Jrmq05xTMHyVud4sX9BvE5Op37pAlk8+4VLQgw2DHXtwvBFyuG8cRimt/pXmuj2vPNR0lnc7pbMl/mdOEhMKcTU08Eg1cqkXQYhNc4e/AnTxuioyQh64YVrn5FPKGCfBsCphSoXg+KT1RBN9ms10OlQF4Bj5eztnptRRwU9hrxs2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b21uamNFWFVqWTBQTTdiajJjbFVqaVVTZEtEdUtoQ085Nk1GY0ErRFVGdXZa?=
 =?utf-8?B?d1hrM0JRQW1UK21jaDFhenZ3ZnFrQ3FVa0gyUVB3VGtoc0hkK1FPYjZkblNj?=
 =?utf-8?B?VlpaMTR3azZkd2t4NUtNTlVKaGMxcHMwTi9rYWlKQ3RZMVh0MG9ic3h2VXhH?=
 =?utf-8?B?cGNoQTdKY0JhVTQ0dXdPMUZIemo0cERmVTFsbjk5eEVPVXprcVE4WXgvYkxH?=
 =?utf-8?B?UVJqVWVxYW9oYXFiWHZ0R1hXNDZ2QTVkOWY4eDFWSlRlanFwVmlWbVFmWmFm?=
 =?utf-8?B?V3RlVTh1bHcvUFY2WVprTWIrZUg0MDUwVFY4a3Z2VS9SRzBsUm43amFCR2ZM?=
 =?utf-8?B?NGgvdkc4TEJpaU9jYjJ5RmlGOFVoT3ZlSFBrMTNCVEF4d005SHBEV3N1Wmhl?=
 =?utf-8?B?UFhkZnpEYjNFY3pVSlJjNkYxSk1GRXdqOSt0ejRIckUvSFpKQzNicnc5OW1x?=
 =?utf-8?B?OFBzZ0Q3MXBvWFJ5ZWs1d1dVV1dRblFxN09TYy9HZ2N3MjNKQ244NHYrM2tB?=
 =?utf-8?B?RWVCRFZSa1dEY2N3QUxVTE5XYzVlK1EyT2lFU0dQVlcyVmZMTmJ1M0JXR0ky?=
 =?utf-8?B?TnFhZTk3SXVrcWVjNk5UaDczK1FhNnYyd1JDbElLUkFQdDZlV1pRQ0NFbU9Q?=
 =?utf-8?B?Z2JuMURDd1dlUWNIWnJ6UjRkd2NDY2F1cTNlWkI3R2RtMjUwQVBIMnMxKytk?=
 =?utf-8?B?Qkt0WkF0MGdsckVzSjhFUmF2cGZ4T0FYaEFuMi82UTFwMkRLR0dvazdLNkxx?=
 =?utf-8?B?eVozbU5WM0NXUlVSV3JWWmVOb01ZcHhNMElXTmdiNGRaUE4rOTA3eWpEQlFO?=
 =?utf-8?B?aTVIR1JxeGNteVo3VlROUlpJNGwxYkNqcFVlM1ZHTS80TVBSRWFURlZNMnN0?=
 =?utf-8?B?Tk9xZU9BNml4b3dLWVhVWEU4YUdUZW4yZzhkMk16RUVlcCt3Q1Q0NlU4SmNC?=
 =?utf-8?B?eFJQNVdUT2lKMGdiL3JIbGFUam1rUTZqQVNPR2JBa3V4TEQ4QWN2RXBnS21z?=
 =?utf-8?B?YUpMcXRTRGZVQXVhbStvWGM3UWV4V2grZEpjWTlaOGVuUDFWYi9CNDFSakFq?=
 =?utf-8?B?MzJCTDBGSFQxSjVUQ044SHpEUGZuZjVCZ1Y5SmFVYkQzVDRxcEFnRWdJMzN1?=
 =?utf-8?B?dmZIOUt1YTRSZEF5Yno2UC9WU2g4ckdDZkZlZTgyUDlmdlRVQzQyMlZNN1dz?=
 =?utf-8?B?Zno0ZUxmaWpRUFhzSW9EejlMNmpXcnM3eUV4dThlSThiNkR6OUVYOG5LdkRZ?=
 =?utf-8?B?ckl0WEdYN0FFZVZDVUhrRkZZOGZFVG5kU054a09hVzh3R1BvdndQcCswM2pT?=
 =?utf-8?B?aEtlejBNS292VWlyRVJERlJRVjNJM3pzY2xUdVdkMm9wcVlGS0RDL2ZQRmpW?=
 =?utf-8?B?d01SbWN3Y3E4V3kyalEyWXZHMDFocDAvN3RjbDZ4UDdZYkNIZjRSbWxPLzNn?=
 =?utf-8?B?ay90eVJMR2MzaG9JYS9NRC9CaXZFclpZd2I0RFExRFlhYXh0enB5TUVkOVI0?=
 =?utf-8?B?dVZNakZ3R1cyTHJuYzh0MjIzSThCdWtNUnZvZmFSVENaTVNvbnlDMU5BSGxu?=
 =?utf-8?B?WVQyblpEdHFxaVlpajdFWUhoVUN3T0NsTHdYSHcvVERQZVIvZW5yNUJtN25P?=
 =?utf-8?B?RFhaRGFnRDdkdHNhWWpIZ0pYdHlUZHN6OXJZUDZKc0pxQnpYZEI1SER2OTR4?=
 =?utf-8?B?Y3czbHc5MEoyS0l4c2Z5WnlXTEhJa3VyMlVTMFpsODFXNklQTE52c2wvQjQx?=
 =?utf-8?B?MTlMSis2SDdjcHp5ZWZBY2YvcHQ1SlY4MUpKRTk3SndPbGlTd0hyVCs1aWFw?=
 =?utf-8?B?Ym4zOU1hVzZPazY1M0N1YzJpdjBFaE00aGVyWTZCNUp4STBraWFjbXhJaXlX?=
 =?utf-8?B?ZUtWMjRySXpjTlBPa0JIVmFsMEd4aWtDQWtWWWRtYTlBbkhhT1g0QXpNOXFJ?=
 =?utf-8?B?dWlnSlhVUnBnd3JiaGJTZDZGaVBjR1dhTjZzcFpFSFpKT3VaVDRBeFB0S1Jt?=
 =?utf-8?B?QTczblFVVGFKVU1mT2dTL1RSWjZxZFFsejN3NExrRHZCMGZNUlVJUGtBdlVF?=
 =?utf-8?B?emFUbGJnNThwNVR6Q0czVjk5KzVYMUcva3Q5VFVlMnRFVEUxRE54SWJRNUhU?=
 =?utf-8?B?RGZwSUlUcW9CZmJDcjY1U1NSN0MvalArZlNVRnkrQVRST3RwZFpQNEJ2a29r?=
 =?utf-8?B?eE8xakV6WWVsbUx3OGx5aGVYWkV6QVp1Ui81cG15NmRTNm1RUVYxNWd4K3pk?=
 =?utf-8?B?cGpVRjYyT3hINEJkV2FIUVVDR1dMTXZEUW4rY1ZuYkxUSGNxc2pCTzVCaFo2?=
 =?utf-8?B?Vm5hMHBqRG1EM0NFWUpRUUNQQVlZOHNpWTBwU2l0TDRJSmRaMXBZZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e881d6-f9c1-43de-53ef-08df1990ee55
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 16:37:17.6065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vE7+FEZAwnAwGmjueIA5TF+/PfuPeMhPfVk+MLjswElQLhu6eTmTwxKQvn3jWnz186fBI0fgWl59NVmGytFVDquISaxv3XhKY0diIfjp8VU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10825
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

Hi Aristo,

On 9/23/26 5:45 PM, Aristo Chen wrote:
> Commit 634dcda25924 ("boot/fit: use constants for property strings")
> switched boot/common_fit.c and boot/image-fit.c to the property name
> constants in include/image.h, but a few literals are left in boot/:
> 
> - fdt_offset() in boot_fit.c reads "data-offset" and "data-size" from
>    the FDT image node; use FIT_DATA_OFFSET_PROP and FIT_DATA_SIZE_PROP.
> - boot_get_fpga() reads the "compatible" property of the FPGA image
>    node. Commit 3059eb0c27dd ("boot/fit: declare (and use) new constant
>    for conf's compatible prop") added FIT_COMPAT_PROP and noted that FPGA
>    image nodes carry the same property; use it there too.
> - fit_image_load_storage() looks up the dm-verity subnode by a literal
>    name; use FIT_VERITY_NODENAME like the rest of the dm-verity code.
> 
> No functional change.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
