Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B508AC47258
	for <u-boot@archiver.kernel.org>; Sun, 28 Jan 2024 10:49:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B481188187;
	Sun, 28 Jan 2024 11:49:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="IuK+9dBs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C3B788187; Sun, 28 Jan 2024 11:48:05 +0100 (CET)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (mail-tycjpn01olkn20800.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2814::800])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 781F188121
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 11:47:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wiagn233@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDOCQkNvT8ya1gejextQwNYlP9jKAgW32vpLhg9xndchAINu9lWdu7300X54OZPlifqNhVJOlM6UosCuRDwBlImb4h2k0HhmsqJef3HlGW3VdfqzXUMPRdCGHpqwHyHvBQfBthqLidn9ig+dK3XJaNnf+Ti/BgehUJrXuAedW9yHWaJxQ4CyfqGF+xCfgVwxeIUQFH9KaFvUmQvrf7+LtZUdbemsbUAyjCDZKTQhbEXaJxXom4DCZrBg9OaN6TQKHdjRWMdip5UlTxV0HvMRsHQMbbcskSevv940jC2Whp/BV2T1Fgqca4WrTjFw8y1CslbsrA9pAcbHGmo/rIMVeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBAsL6rRWQQ1RUdsNRbmKFmFVE1Nz0uUpw8ta6AZ4FU=;
 b=VoLapbHVCguWkJaPSpcdFn626+UblmVjzrIWc6Kz/RjN6qVc9tDdcVtqsF1ZqF2U6nUQP1sgRb1csZkoDt3LhoKJOSXT1lnmxmEYFZtvFjCRpaBrtUysBTIIanVM1QWR0ST6JHCJrP9ibHdJYUOF7N9DSQRmq3zYxWi2iXWQnNu1ONQ3PHGXpidF3qaWPdoVfG7URm5fRTJpGgIicvWZxw/TzOIR5MdZ/B2MYtyx/Ivx1PxNJkznlJVGyXgmr+/ZojUWeGstApLYFcrXiDzUyPl/n5F7PGshucUj7K3A+oPhmc3/IzOyUI3X/iOl6fFjmB9gg8WE1hVtvsKWbSLsdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBAsL6rRWQQ1RUdsNRbmKFmFVE1Nz0uUpw8ta6AZ4FU=;
 b=IuK+9dBsLovHjkMjsyP4hfONL3TtFA+Y3CsBTRuRHobMBj9RwI7NWkQS0NZ0pV9ESpIAva+KJWg7KYG9QyL4CMi1Pmu4alG3HZfA6Td3THXlg8ZVmZ4cxTQn0DLEKIlP5G8eGfjIPTpylzlFd7RqhR2vF14fQngtNnQWnTyl2EaaqWplYEfW0LaISZvqTEZuGyfJfx4vzbFDJKV8Cnc3YAXJMbt79PE4XIx+UTG4I7m1BUfgqyVgZ3oaBO5FMveiuuHTrsrJ3joATkR0fv9Ew93mnZABgf7GcXOtJprpDNqIB7FBPuNME0sd9GZXooARHR0EhhV3k4uJCu/7xZbOjQ==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by TY1P286MB3232.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2e7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.31; Sun, 28 Jan
 2024 10:47:43 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::6801:95d7:c963:398a]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::6801:95d7:c963:398a%5]) with mapi id 15.20.7228.029; Sun, 28 Jan 2024
 10:47:43 +0000
Message-ID: <TY3P286MB2611A17DBFDD9E65B1908152987F2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date: Sun, 28 Jan 2024 18:47:41 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com, E Shattow <lucent@gmail.com>
Subject: Re: [PATCH] configs: visionfive2: Disable ENV_IS_NOWHERE
To: Aurelien Jarno <aurelien@aurel32.net>,
 Yanhong Wang <yanhong.wang@starfivetech.com>, Tom Rini <trini@konsulko.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Minda Chen <minda.chen@starfivetech.com>, Simon Glass <sjg@chromium.org>,
 open list <u-boot@lists.denx.de>
References: <20240127134850.582763-1-aurelien@aurel32.net>
Content-Language: en-US
From: Shengyu Qu <wiagn233@outlook.com>
Autocrypt: addr=wiagn233@outlook.com; keydata=
 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
In-Reply-To: <20240127134850.582763-1-aurelien@aurel32.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------mdk1GNgW6SHWHAt14npJ7u8S"
X-TMN: [uIIjKASsT5gQ8Y2nOt5r0vzR3d3LOouO+Z64KirOu/8ecEsfATGQxncw0R0x/mmj]
X-ClientProxiedBy: TYCP286CA0256.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::14) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <4d10136a-d56a-4ae8-8fbc-85ca31ad711b@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TY1P286MB3232:EE_
X-MS-Office365-Filtering-Correlation-Id: 8801c432-fa38-4ed5-51fd-08dc1fee8e47
X-MS-Exchange-SLBlob-MailProps: dx7TrgQSB6cgSMvDRefB/F5fP4mMZq7rLR4pEEKkrgpLVI4s+joXUr7wB0zuUfwDMXSARzkD+xhvMOXhKvOu+YMc3GLM3jcvgasICvCPd9i7Egasj0TP4BDosktLm8VAVXDjhLafveqOAv7kzD2LOXMVxDZh9gNNOlM+rQYWWdktfi7kpgyqgmCdDT8B0ZUkFLuJqao/IfLVGih7zNZdOwF+xaWY5f2vDBbTToxdtZrpucsrXzQ0pccYRXt37Md3mq6vfQtzUqqF3KULwBiQuaa8D7csBd2IAzbpjnEqsxJhcIc2pdKFg8/G6DijJZLeZ7ujedZmQ8e1sGu5dlqmMvOV4Jw4+ZMqkizXwjiJ4x7FPHlH+GiC4+orjAmogWSVqEKsK+TTmDFIav4EvQhU/kDfTweWYFz56sYn3VWRELVdaE6ekqwe3ECWr1krvTFoRYpZjA2ZPqEagkOEbkDlJph1toGONoVeMB1O2f2XBQw6ftkTfCXBD4zWsrJn+CMNoC2/OR1oa0XanE2OInmmrcvYtiSJdMdF4/zaxg7QzTtUolwQmcPK2Qz0g+j3PTd3JcmWVttl/YjbMOgtrYkXRi9o3TUXE6XFl4cowGrOBgqXwTC4HUBysgVE36fNbK8ectnOv1wDCYMn8qryxs/b7YPRicS1BVGWyFO3XMo5rZzVPI18Zg+zHgO1iR2z30XBrmjplsBdf0QeMijH0fr1PpOErtHK8l0n5rUj2y5AHeyqEcFOVxDU/oCJa9MwauFCU1VW6dvf5sI=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F4x0oZPJ52R9UTfm7uEkK9hTW1CGbMVYkPKE3paauWfHO2Wm8Y7X+M8KdG4GivJdZ+dVNm0Ggepxjzxs81SZAML++x4ESYore1APSLhKzMmBC4pNvScsRDrGUnF2XDPYoai5PU70nyE118uBIvPGKoBjJo1nP+PVVQtZVzfmUUVtk47rJBvM1gUIcdZiaTIUjDREsiUglnB0CKfe6nPAWjuSh/NWpdLYf9bKnWqHiOAdMPJcpnfxYhhOTbm93BzhpK46jYyHmSfQ646n7Bko5fQhwUizsgpO8Y4aZbX1Mcyn7h2TxuMBk9X3BFdZNp5feNzu6I1uBiCVPL/lAEUo+npenxjln9ulI7EPELEBy3Bdhia6Ln0FLYdFSW+9fVxbDYNaTBdd+RgmE/XQs+rpqGZN9Ppf/VF0oN/C4fN1N3Yfo5lWd+ubO+lZcvwHMfhHk90rinD1XxHJjZKsXhtdPEKAn9+ZRGZLhwCTa72B/Kp/n/4065KMksewbLDgm5ORJp00HUBQkI7J4L0ZL7Vcv/cx+XRFgOwpVRoGsBEPW2tT9wQ5zW9Z8AGx/1mT27R0JRT1cc5V+3Tg36X1FimVChZfYj2TZZYOr8BxpVcnqhMg8n45dyFMQCENEeDJA5Hs
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vkl6NFNEMjlnK3k5Nk5LZG5GSWlFYVhuQzh0WC9nWWZHREVEKzY5amhHZHI0?=
 =?utf-8?B?ZWZZMSsybDU0clhPOEJmRGxPZDZFVnpmL0lPMjZaYnFFdURzQ01CVDBjUytX?=
 =?utf-8?B?dWJzNmFENnA4cE5qL2M0UUJ6Uk1DU0FvS0xVTGNpUzh3VTM2UnROODYyc2pZ?=
 =?utf-8?B?cWp0UkFNRnFYMThSMHc5bzk1TGgrcTZUeElOSGw1OWZSNlNORkdydzVVQm9O?=
 =?utf-8?B?VTNFWjhYck11eEtuaFg0MTAreEhTMjFQSWNxTmx4ZkpGZlUxWXZoQUU3czNZ?=
 =?utf-8?B?VFlsUm1FNFFsZGVUOFhRN2JpbUIweU1TSnkxenpiQ1g0VWppSnhhdXYzTXFZ?=
 =?utf-8?B?a2Uzc05sTW1HbWRQSTBPdFNscS91S0NGRHFIbVJWZmgwT3hPWVREbU80N3Ra?=
 =?utf-8?B?YUdzREpQc1dqVkNxMm41QUtxQ1VoUFVsS0p5ektvK0lNeUdVT1Z4RzFSQVdD?=
 =?utf-8?B?eUNDSTVuUXZvOGJIdjZFUVJ3L3pQVmVMbjgrN3VkaVlZcjJPMG9kOTN6Ly9T?=
 =?utf-8?B?Ni9Nb2cyWU1lODdlRXB3OHJFcEdGem1DcmtGcUNWZ21peUhLY1JFNHdncTZk?=
 =?utf-8?B?SjlEVTBtM3hLckpEWUxsZ1VmMHNVUkNySEpCZkFBbDhKMWlRZldaTHRGcUZN?=
 =?utf-8?B?RDJlNE5KcDZkSTFSR0JnV3VFTjQrRXNOWVdRVVIva2lVQ3BUWUl4OHlvaG4z?=
 =?utf-8?B?Z1VMQ3dtNGlZNjVzMW1sa2ljME5yNWpJa2dnb0NjNEpSek1kcitXM3h2b3VO?=
 =?utf-8?B?a0hmc0xEcnhwRUlFSitBSUF5N3JVbEljc3BEcWtiNHhmVFFoWnBWRVJ3cDRl?=
 =?utf-8?B?M29pNkY5UHF5cTZUQ2l1cHI5dFhZTzBIRWVIREJSMFUzbjdxOGNDOGUrS1pt?=
 =?utf-8?B?dnpWblFHTzFxSlUyQVNhVVllaUkzUjZYNHg0d1I4TlRwUW9oeUhacFNocktX?=
 =?utf-8?B?WnhJcUdGeGI3WEsyR0ZrQndZWmJNUnY0MndhQXBXbkNaYmFoNFAvUVJDYm5W?=
 =?utf-8?B?dmtsY2lVQmNIS2ppNnMyMGVWYTZaREVxaXFteEVkalhNblpOY3hKQkhxNFp1?=
 =?utf-8?B?OWtjM0VtYVhiK0F4Y011ZFRvVllmVHA4N2xuZjBmeUVBYnVZelR0UFZHcDM1?=
 =?utf-8?B?NDVPUFhuMUNSRGN6Y0pvUnYyQ3p4YkdBZlpZTVliZXQySUpacEV6Vzd6eEts?=
 =?utf-8?B?b0J3Q1JnaGlCOFZoUEN6aFZITnRMV01wWlM2cUQrMmtaeXhkREliQnM3ZUFG?=
 =?utf-8?B?UHFNOGlDMmVUY3ByY0pWNGRjZ0FiaXliZ3Z0UXpLZlpmc0xVQWs4NVRON0g2?=
 =?utf-8?B?RWYzRXAzNTVTWXdrdU4xL3g3RkFzY2RvTUJVR2lLMnViZStiRHhyR3hrTERy?=
 =?utf-8?B?Z0wrcG0wcU54MTNVY0xPM21CMHF0eXZEbXRxaG5ZYUFtWHZNSEdScytTUzVh?=
 =?utf-8?B?K0tKN0RmNkoyWHRxV1ArTzZ2QWxNVXBZUDJteDFDRVNBVm1CRjQ5STJZVVRh?=
 =?utf-8?B?WmZBY1RUY2xoWFBPTXRwcjB1NnVhbVgvejQwdU9vOVJvMGxSUHBValZ4eG9j?=
 =?utf-8?B?STY0VjZJeWJSdTFTakF0V1lBcmhuYjFTTmk1NGtlc0ZPY0tHbGluOHg1eHJZ?=
 =?utf-8?B?ZjNwVU5nWER5TGxhcmRmc0t3MXowVklNRm45Z25QZE4wa1pQcWU5SG0yY3Np?=
 =?utf-8?B?UjMyeHkrckY0aWRFYWpUTHNTKzk5ZjNCaUJuL1RrYUh2L1RMYnRIRWlKeTJ5?=
 =?utf-8?Q?h8lmeUbeWG48D5+WhY=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8801c432-fa38-4ed5-51fd-08dc1fee8e47
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2024 10:47:43.1101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1P286MB3232
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

--------------mdk1GNgW6SHWHAt14npJ7u8S
Content-Type: multipart/mixed; boundary="------------kI9G5Ozr5Ok9jdI8Y8EtYd6x";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Aurelien Jarno <aurelien@aurel32.net>,
 Yanhong Wang <yanhong.wang@starfivetech.com>, Tom Rini <trini@konsulko.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Minda Chen <minda.chen@starfivetech.com>, Simon Glass <sjg@chromium.org>,
 open list <u-boot@lists.denx.de>
Cc: wiagn233@outlook.com, E Shattow <lucent@gmail.com>
Message-ID: <4d10136a-d56a-4ae8-8fbc-85ca31ad711b@outlook.com>
Subject: Re: [PATCH] configs: visionfive2: Disable ENV_IS_NOWHERE
References: <20240127134850.582763-1-aurelien@aurel32.net>
In-Reply-To: <20240127134850.582763-1-aurelien@aurel32.net>

--------------kI9G5Ozr5Ok9jdI8Y8EtYd6x
Content-Type: multipart/mixed; boundary="------------a40iymyWpK6pNfduQmKW1E8R"

--------------a40iymyWpK6pNfduQmKW1E8R
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

TEdUTS4NCg0KTWFpbnRhaW5lcnMsIHBsZWFzZSBhbHNvIGFwcGx5IHRoaXMgcGF0Y2ggdG8g
MjAyNC4wNCBicmFuY2ggd2hlbiANCmFjY2VwdGluZyBpdC4NCg0KQmVzdCByZWdhcmRzLA0K
U2hlbmd5dQ0KPiBUaGUgVmlzaW9uRml2ZSAyIGJvYXJkIHN1cHBvcnRzIHNhdmluZyB0aGUg
dS1ib290IGVudmlyb25tZW50IHNldHRpbmdzDQo+IGFyZSBzYXZlZCB0byBvbi1ib2FyZCBT
UEkgZmxhc2guIEhvd2V2ZXIgdGhlIGRlZmNvbmZpZyBlbmFibGVzIGJvdGgNCj4gRU5WX0lT
X05PV0hFUkUgYW5kIEVOVl9JU19JTl9TUElfRkxBU0gsIHByZXZlbnRpbmcgdGhlICJzYXZl
ZW52IiBjb21tYW5kDQo+IHRvIHdvcmsuIEZpeCB0aGF0IGJ5IGRpc2FibGluZyBFTlZfSVNf
Tk9XSEVSRS4NCj4NCj4gRml4ZXM6IDdkNzliZWQwMGM5ZSAoImNvbmZpZ3M6IHN0YXJmaXZl
OiBFbmFibGUgZW52aXJvbm1lbnQgaW4gU1BJIGZsYXNoIHN1cHBvcnQiKQ0KPg0KPiBSZXBv
cnRlZC1ieTogRSBTaGF0dG93IDxsdWNlbnRAZ21haWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5
OiBBdXJlbGllbiBKYXJubyA8YXVyZWxpZW5AYXVyZWwzMi5uZXQ+DQo+IC0tLQ0KPiAgIGNv
bmZpZ3Mvc3RhcmZpdmVfdmlzaW9uZml2ZTJfZGVmY29uZmlnIHwgMSAtDQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2NvbmZpZ3Mvc3Rh
cmZpdmVfdmlzaW9uZml2ZTJfZGVmY29uZmlnIGIvY29uZmlncy9zdGFyZml2ZV92aXNpb25m
aXZlMl9kZWZjb25maWcNCj4gaW5kZXggMWI3ZDU3YmFjNy4uYzY4ZjNjMmRlZiAxMDA2NDQN
Cj4gLS0tIGEvY29uZmlncy9zdGFyZml2ZV92aXNpb25maXZlMl9kZWZjb25maWcNCj4gKysr
IGIvY29uZmlncy9zdGFyZml2ZV92aXNpb25maXZlMl9kZWZjb25maWcNCj4gQEAgLTc3LDcg
Kzc3LDYgQEAgQ09ORklHX0NNRF9URlRQUFVUPXkNCj4gICBDT05GSUdfQ01EX0JPT1RTVEFH
RT15DQo+ICAgQ09ORklHX09GX0JPQVJEPXkNCj4gICBDT05GSUdfRU5WX09WRVJXUklURT15
DQo+IC1DT05GSUdfRU5WX0lTX05PV0hFUkU9eQ0KPiAgIENPTkZJR19FTlZfSVNfSU5fU1BJ
X0ZMQVNIPXkNCj4gICBDT05GSUdfRU5WX1NFQ1RfU0laRV9BVVRPPXkNCj4gICBDT05GSUdf
U1lTX1JFTE9DX0dEX0VOVl9BRERSPXkNCg==
--------------a40iymyWpK6pNfduQmKW1E8R
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------a40iymyWpK6pNfduQmKW1E8R--

--------------kI9G5Ozr5Ok9jdI8Y8EtYd6x--

--------------mdk1GNgW6SHWHAt14npJ7u8S
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmW2MM4FAwAAAAAACgkQX75KBAfJsRlQ
vg//URDC8XezkQwn6olBanO55kcadgqBvhcMvPJDN2x/M81UYgzwEetnF9JWLjDYajlcNgExHZfR
dg47SetZnHM3F2mYo967ASClXmAHi0PuNE7OTPjKYJJNZRNr79U3G4+Y7Ui6vmPpkqvGouHipDO2
uLbQBUfdqrJvQyGY4Mgfox+jOjGCzHVsTsT1htGTv/847z9qZ76dGTtzamDhHJsj8E1gTZ6NIa26
zexHTgM6F4rUOyMy+v/P00KJzW1kWTNGRgfUK4RiJDx2S9COWTAcV1qUxgFA+JqSNAGbLpFSreR2
E0UoIrh55yD0XB94Vw5HlJ464ORfI4kgfOga97nsywa4rDcbRCBlgVfdIdf/u6xe2qB4guAzRjas
aok5ZkYJPtNcKgG+jzDX/yyhd7gEsj5jG+nnDyuJbuT5SbGsFsV19deOijcJQmVmsjizybBDoM/9
+M+9NFSdSRI2cc1X0mZkDb485xO0J1x/iRY5PNwVsmM6cNPxPFffPA/vUAuJElwTjt2JWK88IcHX
zDphWisqZOhYz3JvccAI500jREtoqJxYiAelT6jYHhpJ8J9zPDPCGbrLfcLDIkVLSYOumE7yqaHf
Kst/lH3Qtg3Zo+89vLZX1sCrm0JgC1Ofjqo2DOBPsRYCVIg7xLhz9t7CyPPGosRCCcBAu1nUUewM
xX4=
=p4Jz
-----END PGP SIGNATURE-----

--------------mdk1GNgW6SHWHAt14npJ7u8S--
