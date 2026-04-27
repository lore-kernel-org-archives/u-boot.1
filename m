Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512A2FF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 10:20:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA8ED839D9;
	Mon, 27 Apr 2026 12:20:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ULLACrRC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FC9F83AA9; Mon, 27 Apr 2026 12:20:33 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C268380433
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 12:20:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p4ojFzBHX5BNY/9RzaQQyE42F8iQfwcwwlRFg8z10HafBoIjFoByeutRsCYEFI4coPmvtovZETPL45DjVhos7U1gY2gO7RcqbAPvFzATUOGPpD8g+S/S6f8J1WPKFExglMxWIqL7lhvgrDHpow07i2BhXldhcz4nn7Po4ox15jfoLx+AebirIJ4pJ82x/raSTYCBNXxj6IuLRA1EN6j9JRnhc7aDAGfJgkrLt+W035yeQV+FePwWjXUo75PLzpIxO6VhKoAA61Tjrk9TMYYthi2CkRoINDvDXfhFXBL75TI9p8f3roZ7grADX1SCFs3DRTGjpqyqetizqaQ4sA2UFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWYJ+L2UZ4XuLH2RWOR/bRgKJ7VDG8v0TVOgRxeu2oI=;
 b=izyymDP/5Tl0cAak+2oSbwBodx+GOR8pSua9eEOBj3+nwjkCe8+oVLlRIUqtHe1fCQEFojLNQTH/XCUBHN9drpxwVU+fg5GcjzwCBIvGiBX/KTYX5f2K9cEsQQ9M1ch7M3Bu90kql9npeqV+xjPoz+x80gtV2VahIUywfkZGduc3mDbBf4zRkkpchM3TkaHFM65jhyjKlSmOurbVVDGGIsn6V5lq4OrOb+LLLpMIzE1iSdrS5qAhkmqNegcVG4No34YG76tEv6mYOmSGbc4q8UdU4GonnwyXMHdxUeH0FpJhFGtAOHPFutrTJ5gUs4M4mXZcj31MfDeOP+22w2CThQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWYJ+L2UZ4XuLH2RWOR/bRgKJ7VDG8v0TVOgRxeu2oI=;
 b=ULLACrRChC+LrtnOD+DXTWtSrnrG02KrnOntJ7qHphkOMzesP7R9ufy6AJaWTOHcayIjA61H1NYMirCOFGb/qDhyc/1FJCij3yVV9wMKtmBRHpnlxoRQavavYj7zgz6T876WTg1Dj0Kgm96IiGQppExXulPv9NtdnF4FMxYUMlY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by GVXPR04MB11019.eurprd04.prod.outlook.com (2603:10a6:150:226::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 10:20:23 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.20.9846.016; Mon, 27 Apr 2026
 10:20:23 +0000
Message-ID: <df749b3b-0210-4b31-a4e0-8f7af9084589@cherry.de>
Date: Mon, 27 Apr 2026 12:20:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] binman: x509_cert: add PKCS#11/HSM signing support
To: Sergio Prado <sergio.prado@e-labworks.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 ilias.apalodimas@linaro.org, marek.vasut+renesas@mailbox.org,
 sughosh.ganu@arm.com, wolfgang.wallner@at.abb.com, bb@ti.com,
 y.moog@phytec.de, xypron.glpk@gmx.de, jerome.forissier@arm.com, afd@ti.com,
 Wojciech.Dubowik@mt.com
References: <20260423154536.768603-1-sergio.prado@e-labworks.com>
 <20260423154536.768603-3-sergio.prado@e-labworks.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260423154536.768603-3-sergio.prado@e-labworks.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI5PEPF00000978.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::806) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|GVXPR04MB11019:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ee35e17-e66b-481f-005f-08dea4469794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|366016|1800799024|8142099006|22082099003|17002099007|17092099009|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 7QdhyDcYHyTo2adkOWkLn+msZW1xQ4XOTWjyjzGY2jyKjosFKAZvXIS+VFu6xpXN4qpnxa2Ed6FYKQd2mYwVplzi4CxewqEXnwmEhP3MWOXKVLcGP7kvw7V1LSsJYDYIZZgxP+b5L0Ig+OTihwJoBvDKe+mRggJbJl1+oaNfHDkU+JUAngu2/wuG3vh0ASaWzg/zwTwqM6+OJOwtvVAOFRNOhX9/a8x9YWoEJ+iq3dKeE0A01ZfbZ6HpPJWyLioKiFrNkcwOJN0RJ2MA/m9suIGnQ9Y2Mpg/IHPRZ8Txq0lbuU/1FE1nqHIEmJ7Qorj8biaTZLJZaicSUVU9rjoadAFksOMlzhc+bxi9fHhbtec5l0HBqf+DTFRpVf8xZsRnbr+NoaGyXZAEE/brI+rVyHjSlt0tfuB5QT8Vm/t+feG8eCrWsp/f+khPwm7tzM4DSTUTvS44esbDZo+SrHNzSgHeDybdmKroeYyKUzVIXxy4gxfRk6Gs2H8dSTJC/ylU54xodxzaUtNAsrumbOAvzqfP+MlIEqkHEGXzvZtwWP0IQEdtUSP2RQpxMOXU8jSGb/m4q7aE+kt4fBeKec8auq46hM11YbC0C0bCJFom8FUt/bSYo30VH/gMqdS8uwSHQQcF7+UAkcjetRMkxZ9VGve8PzY1M3TylWlTH+Rea2GZ1JEikbx1miXi8ijrPwTk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(8142099006)(22082099003)(17002099007)(17092099009)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzJGZlp5MktlTzcweG5DSFB1aFJvSlJFcVR0MlhqNUF1TlpWOExlR2VHcVIy?=
 =?utf-8?B?UmFnRHdnaGlwOGkremhGWE52dFJNNEdGNGVTeFd5VThiYkFnL2VxWDZKanA2?=
 =?utf-8?B?cXl3SXprUXUyaW0wZ3FWMlgybWVJelBPbEtUSTBqTVM2RlJoT0h0VUEzU1hJ?=
 =?utf-8?B?VUNLOHAraW1NWnpkL2RxTzVlSTUvSWp5ajd2bVkxQjZQS1pDb21ndVQwYVIy?=
 =?utf-8?B?NHBQRHI2M2ozazJzVjhYRU1IeC92TmRnR3VIWk5xb1NjbDFKYTZaMHg0UVJ4?=
 =?utf-8?B?c0ZjUFl3R3BGYWFQQUVIY0ZvNDhHRmtLYU4vbVdnWURJcnJxOHRUTi9zLzhZ?=
 =?utf-8?B?Q21JN3lpRWxQc3h3QjdkWFFvcGxGclMyV3lJZ3dNREpPQmtJa1hRMGt2dThQ?=
 =?utf-8?B?MWtTSEd4dUtXNXZFRGJIUk1INFo0UXJFemQvU0tqenBwK1Rnd1ZCQ3RUR0tr?=
 =?utf-8?B?NjlaeWtsT1pKRW92cDRsS0dVNFY0Tzk0THNxQjZZajNMRlp3cnE5cEZBa2xU?=
 =?utf-8?B?a3h5Q3lTa1orQVlvZEFmTDJPbm1uNlUvQWxiUlRvYnJFZ1FFR2d4OEt1OFJo?=
 =?utf-8?B?NXpIdDIxdzRHT3d1Zmkwa2lubmlUcGxuT09Ka1lEZ3RaalJNOFB0d0JIaU45?=
 =?utf-8?B?ZDMxaGNMWE9zTzI5YzdrVHcyY296cW9WbzdnbkxCMFJOd01CMURDNXcxem5T?=
 =?utf-8?B?bWdUU0cxaXlRWTZEbytXRkxjLzZwRkUyK0twSndwWVlEQ0EvVUtsQ2hpRUtF?=
 =?utf-8?B?d0F5eEs1d0pyUitsQmh5cm04STBRNkpLRjYzVGtxOUJPOEd0c1NmaDNEZ2hU?=
 =?utf-8?B?cHRXMGVvTzdmYUFidnFWM2cwc1dPdXdXNUZMOHA1Z01rVC8wbS9YYlNmVkl0?=
 =?utf-8?B?RjhISTFIS29LazRSWU1qMmRzK05JbkkvQW9NNnVLZi9IMnFWRjhjaGdoNjVr?=
 =?utf-8?B?Y25QclJiZkgvYUxMTkpEYXZZWmlmbnBMTnI5RlVMZlZzVnRBUkR5VTZwL1lz?=
 =?utf-8?B?YXQzV3BZVVZMOXRxQ280YlRwVEZxRjh0YmZMbFdqVHpJOGVoczc2M3lrZktp?=
 =?utf-8?B?NFZwVWFEUlIwdmpVMitZcXRVM3JmQm15QU9pQXRSWGhTSkFqV2I3SjhpN1RZ?=
 =?utf-8?B?VFVuWWlsUTM4WmhkcGpXc0ZxTThKOWg5akNoYklrd3ZuQnVONTRtbnRLTWlR?=
 =?utf-8?B?eE1zL3dDVENmaVpzL2xZTVJFT2hoZnUxRnp2TnJjWnBMdEJ2aTkyeUxiRC9Y?=
 =?utf-8?B?SEpWQmhiSVBvWjNpbW9NTnlORkoyaHpYSWY3NURuSjlsQjBUMTk1ZkcxbHI5?=
 =?utf-8?B?RGxDaEgybHlqRW1HVXJyMlhtbzU2cS95SFgra2JmeDg5VEJOekVmeWJsZWRx?=
 =?utf-8?B?S3A5VlZWYW90UUw3YlVNUHgyZ0J3dXpUeWEwTTEvN1hZbG53MkxrdnFmYk1m?=
 =?utf-8?B?WisxaHJGdk1raVc0Wi84ZStjQkNLTkhIUDhyd2x3SGdtNndVQUNCZ2dHU0lR?=
 =?utf-8?B?MWc0emNGTmcwbVVIdkkwMnloazV0UFhuZ3hZUjNTQmU0U01uTHJocW9nR3E2?=
 =?utf-8?B?alBlV3JhL1BlNVZ6N1JYeWh3amZ2b2trQ3htd3M1TTlZWXJ0YUppZ2NLeUFt?=
 =?utf-8?B?cytmT2pIallaVWwvWnQwQ2JXaUNuYkNZM1ZJOVRCSEEwcmw0L1BOcDFOeUZL?=
 =?utf-8?B?RzR4aXVTcTgvT2Z0a05KYk9EQWRFYW1BWEp6SnJiKzkrZ0ZiRmwwUzBXTUtM?=
 =?utf-8?B?REMvVUlzMWVmT0QzRjdORHlQbk5LSDQyejJtOTBreFJuQ3ZpbXVuQlVQRHNH?=
 =?utf-8?B?YWlSV1RXZHdWZUdlVysvK2NrZXZVYjRSYVFTcE1ibXlWejg5Sk5vVXRBNmdK?=
 =?utf-8?B?KytiZzBRTm90YWxSd2tBVjF5cTduNzRUbWcwS2FEWDJNQ3BpejVEZlBpSkpM?=
 =?utf-8?B?dHhwdjFlMnFHSS92Mm44L3kzRkVXRnYyN3o1RWxCdVVSVllCOEpkUDlQOGN5?=
 =?utf-8?B?U3pzMlo0TTduOUFzcFQzanZuTDBvK2xGalBpOFptcmFqK0xqdFZjamNOU2VV?=
 =?utf-8?B?TUE3RVdKc1F1YVRsQ1loTEpMTEZkNjVDTWMwWCs0cjViYm0vcHZIREthc0ph?=
 =?utf-8?B?aTBZV2RqbitNRHpVSVJ1ck9rbDdtV2ordVpob0tSM05TczFRWUJBSU5BemZZ?=
 =?utf-8?B?aVJuY0xBRDhHS3BSTXo2Z09Cc3dpREFETTcrSDFrOTFrcGJHcHFYV3FXR2c3?=
 =?utf-8?B?MmhTbC9KZ3hETEhSSmhaMEMyRi9CR1VQd0tjbzh4NmFrelpBQ09PZDdzaU9W?=
 =?utf-8?B?blVxQXhsUGd0S09XSjQ5VWhYZncwd0VNRndqdVNQZG9HOWxEY1lsd2Z6Q1Br?=
 =?utf-8?Q?9de5Oea2MBnsg0OlHAT5a0OzdzLGYO5FAugwT?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee35e17-e66b-481f-005f-08dea4469794
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 10:20:23.2570 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YMZ3vI6M0evQgQ00lpOuYadv8eutAfJUBjmlxHw9csGkZ/T5jvtB0TtAPg/QjuoawkrTi3DPPCLpN85NUzZKp/JRRFo8mdB+WsEFFXTd/nM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11019
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

Hi Sergio,

On 4/23/26 5:45 PM, Sergio Prado wrote:
> Allow X509 certificates used for TI K3 secure boot to be signed via an
> HSM using the PKCS#11 standard, so that the private key never leaves
> the hardware token.
> 
> Two new make variables are introduced:
> 
>    BINMAN_PKCS11_URI    PKCS#11 URI identifying the signing key, e.g.
>                         pkcs11:token=mytoken;object=mykey;type=private
>    BINMAN_PKCS11_MODULE Path to the PKCS#11 shared library (.so), e.g.
>                         /usr/lib/softhsm/libsofthsm2.so
> 
> When BINMAN_PKCS11_URI is set, it is forwarded to binman as the
> pkcs11-uri entry argument, overriding the keyfile property at signing
> time. BINMAN_PKCS11_MODULE is optional and only needed when the PKCS#11
> library is not already configured via openssl.cnf or the
> PKCS11_MODULE_PATH environment variable.
> 
> The openssl bintool gains three helper methods:
> 
>    _pkcs11_use_provider() auto-detects whether the OpenSSL pkcs11
>      provider (OpenSSL >= 3.1, pkcs11-provider) or the legacy pkcs11
>      engine (libp11) is available, by inspecting 'openssl list
>      -providers'.
> 
>    _build_key_args() builds the -key/-provider/-engine arguments for the
>      openssl command line. When PKCS11_PIN is set in the environment,
>      its value is appended as ?pin-value=<pin> to the URI so that
>      non-interactive signing works with both the provider and engine
>      paths.
> 
>    _run_cmd_pkcs11() sets PKCS11_MODULE_PATH and PKCS11_PROVIDER_MODULE
>      before invoking openssl when a module path is given, and serialises
>      concurrent signing calls with a module-level lock. The lock is
>      required because binman's ThreadPoolExecutor may invoke multiple
>      signing operations simultaneously, and HSMs (including SoftHSM2) do
>      not support concurrent logins from different threads.
> 
> Existing behavior is unchanged when neither BINMAN_PKCS11_URI nor
> BINMAN_PKCS11_MODULE is set.
> 
> Tested with SoftHSM2 and a YubiKey using the verdin-am62_a53_defconfig
> configuration and both engine and provider OpenSSL APIs.
> 
> Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
> ---
>   Makefile                        |   2 +
>   tools/binman/binman.rst         |  18 +++++
>   tools/binman/btool/openssl.py   | 117 +++++++++++++++++++++++++++-----
>   tools/binman/etype/x509_cert.py |  47 +++++++++++--
>   tools/binman/ftest.py           | 110 ++++++++++++++++++++++++++++++
>   5 files changed, 274 insertions(+), 20 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index dfc95d314ddd..8d6c584b2731 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1701,6 +1701,8 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
>   		-a vpl-dtb=$(CONFIG_VPL_OF_REAL) \
>   		-a pre-load-key-path=${PRE_LOAD_KEY_PATH} \
>   		-a of-spl-remove-props=$(CONFIG_OF_SPL_REMOVE_PROPS) \
> +		$(if $(BINMAN_PKCS11_URI),-a pkcs11-uri="$(BINMAN_PKCS11_URI)") \
> +		$(if $(BINMAN_PKCS11_MODULE),-a pkcs11-module="$(BINMAN_PKCS11_MODULE)") \
>   		$(BINMAN_$(@F))
>   
>   OBJCOPYFLAGS_u-boot.ldr.hex := -I binary -O ihex
> diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
> index 366491089ad9..e60eb7f572eb 100644
> --- a/tools/binman/binman.rst
> +++ b/tools/binman/binman.rst
> @@ -2161,6 +2161,24 @@ BINMAN_INDIRS
>       Sets the search path for input files used by binman by adding one or more
>       `-I` arguments. See :ref:`External blobs`.
>   
> +BINMAN_PKCS11_URI
> +    PKCS#11 URI used to sign boot artifacts via an HSM instead of a PEM key
> +    file on disk. When set, it is passed as ``-a pkcs11-uri=<uri>`` to binman,
> +    which overrides the ``keyfile`` entry argument for all signing operations.
> +    Example::
> +
> +        make BINMAN_PKCS11_URI="pkcs11:token=mytoken;object=mykey;type=private"
> +
> +BINMAN_PKCS11_MODULE
> +    Path to the PKCS#11 shared library (.so) for HSM signing. When set, it is
> +    passed as ``-a pkcs11-module=<path>`` to binman. Only needed when the
> +    module is not already configured via ``openssl.cnf`` or the
> +    ``PKCS11_MODULE_PATH`` environment variable. Typically used together with
> +    ``BINMAN_PKCS11_URI``::
> +
> +        make BINMAN_PKCS11_URI="pkcs11:token=mytoken;object=mykey;type=private" \
> +             BINMAN_PKCS11_MODULE="/usr/lib/pkcs11/libsofthsm2.so"
> +

OK, but why do we want to have this variable for storing the path to the 
module lib instead of using an openssl.cnf?

Also, this is stating it's for signing boot artifacts with an HSM, but 
that isn't true. It won't work with FIT images, which use DT properties 
instead (see fit,engine, fit,engine-keydir/key-name-hint.).

I'm assuming it's possible we want different keys for different boot 
artifacts, so this is also a bit too generic of a name?

>   BINMAN_TOOLPATHS
>       Sets the search path for external tool used by binman by adding one or more
>       `--toolpath` arguments. See :ref:`External tools`.
> diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.py
> index b26f087c4470..ec477a46a3d7 100644
> --- a/tools/binman/btool/openssl.py
> +++ b/tools/binman/btool/openssl.py
> @@ -11,10 +11,16 @@ Source code is at https://www.openssl.org/
>   """
>   
>   import hashlib
> +import os
> +import threading
>   
>   from binman import bintool
>   from u_boot_pylib import tools
>   
> +# Serializes concurrent PKCS#11 signing operations. SoftHSM2 and many real
> +# HSMs do not support simultaneous logins from multiple threads, so binman's
> +# ThreadPoolExecutor would otherwise cause intermittent login failures.
> +_pkcs11_lock = threading.Lock()
>   

Is there really no external mechanism to make sure this cannot happen? 
or maybe some sort of session concept?

binman tests will run on multiple processes (see ConcurrentTestSuite) 
when not instructed to run on one thread (via -T 0, used for test 
coverage). My worry is whether this is multiprocess safe (hunch is no). 
Look at what we did for the FIT signing tests, we use different softhsm 
and openssl config files per file and I hope this is enough for openssl 
and softhsm to not get confused. Considering there's a 
multiprocessing.Lock(), there must be a reason for it no?

>   VALID_SHAS = [256, 384, 512, 224]
>   SHA_OIDS = {256:'2.16.840.1.101.3.4.2.1',
> @@ -35,18 +41,89 @@ class Bintoolopenssl(bintool.Bintool):
>           super().__init__(
>               name, 'openssl cryptography toolkit',
>               version_regex=r'OpenSSL (.*) \(', version_args='version')
> +        self._use_provider = None
> +
> +    def _pkcs11_use_provider(self):
> +        """Return True if the provider API should be used for PKCS#11 signing.
> +
> +        Checks whether the pkcs11 provider is available by running
> +        'openssl list -providers'. The result is cached after the first call
> +        to avoid spawning a subprocess on every signing operation.
> +
> +        Returns:
> +            bool: True if provider should be used, False if engine should be used
> +        """
> +        if self._use_provider is None:
> +            out = self.run_cmd('list', '-providers') or ''
> +            self._use_provider = 'pkcs11' in out
> +        return self._use_provider
> +

Why force the user to use providers if one is available? Can't they use 
an engine even if a pkcs11 provider is available (e.g. you have both 
pkcs11 provider support via softhsm2, but only engine support for your 
HSM). Isn't this something the user can specify via openssl.cnf?

> +    def _build_key_args(self, key_fname):
> +        """Build openssl CLI arguments for the signing key.
> +
> +        Always add '-key key_fname', and for a PKCS#11 URI (pkcs11:...),
> +        prepends either '-provider default -provider pkcs11' (if provider API
> +        is available) or '-engine pkcs11 -keyform engine' (legacy fallback).
> +        If the PKCS11_PIN environment variable is set, appends pin-value=<pin>
> +        to the URI.
> +
> +        Args:
> +            key_fname (str): Filename of .pem file or PKCS#11 URI
> +
> +        Returns:
> +            list: openssl arguments for the key selection
> +        """
> +        if key_fname.startswith('pkcs11:'):
> +            pin = os.environ.get('PKCS11_PIN')
> +            if pin:
> +                sep = '&' if '?' in key_fname else '?'
> +                key_fname = f'{key_fname}{sep}pin-value={pin}'
> +            if self._pkcs11_use_provider():
> +                args = ['-provider', 'default', '-provider', 'pkcs11', '-key', key_fname]
> +            else:
> +                args = ['-engine', 'pkcs11', '-keyform', 'engine', '-key', key_fname]
> +        else:
> +            args = ['-key', key_fname]
> +        return args
> +
> +    def _run_cmd_pkcs11(self, pkcs11_module, *args):
> +        """Run an openssl command, optionally passing PKCS#11 module env vars.
> +
> +        When pkcs11_module is set, PKCS11_MODULE_PATH (engine) and
> +        PKCS11_PROVIDER_MODULE (provider) are passed as extra environment
> +        variables.
> +        If already configured via openssl.cnf or the calling environment,
> +        pkcs11_module can be None.
> +
> +        Args:
> +            pkcs11_module (str or None): Path to the PKCS#11 shared library
> +            *args: Arguments forwarded to run_cmd
> +
> +        Returns:
> +            str: openssl output
> +        """
> +        if pkcs11_module:
> +            extra_env = {
> +                'PKCS11_MODULE_PATH': pkcs11_module,
> +                'PKCS11_PROVIDER_MODULE': pkcs11_module,
> +            }
> +            with _pkcs11_lock:
> +                return self.run_cmd(*args, extra_env=extra_env)
> +        return self.run_cmd(*args)
>   
>       def x509_cert(self, cert_fname, input_fname, key_fname, cn, revision,
> -                  config_fname):
> +                  config_fname, pkcs11_module=None):
>           """Create a certificate
>   
>           Args:
>               cert_fname (str): Filename of certificate to create
>               input_fname (str): Filename containing data to sign
> -            key_fname (str): Filename of .pem file
> +            key_fname (str): Filename of .pem file or PKCS#11 URI
>               cn (str): Common name
>               revision (int): Revision number
>               config_fname (str): Filename to write fconfig into
> +            pkcs11_module (str or None): Path to PKCS#11 shared library, or
> +                None if already configured via openssl.cnf or the environment
>   
>           Returns:
>               str: Tool output
> @@ -76,19 +153,20 @@ shaType                = OID:2.16.840.1.101.3.4.2.3
>   shaValue               = FORMAT:HEX,OCT:{hashval}
>   imageSize              = INTEGER:{len(indata)}
>   ''', file=outf)
> -        args = ['req', '-new', '-x509', '-key', key_fname, '-nodes',
> +        args = ['req', '-new', '-x509', *self._build_key_args(key_fname), '-nodes',
>                   '-outform', 'DER', '-out', cert_fname, '-config', config_fname,
>                   '-sha512']
> -        return self.run_cmd(*args)
> +        return self._run_cmd_pkcs11(pkcs11_module, *args)
>   
>       def x509_cert_sysfw(self, cert_fname, input_fname, key_fname, sw_rev,
> -                  config_fname, req_dist_name_dict, firewall_cert_data):
> +                  config_fname, req_dist_name_dict, firewall_cert_data,
> +                  pkcs11_module=None):
>           """Create a certificate to be booted by system firmware
>   
>           Args:
>               cert_fname (str): Filename of certificate to create
>               input_fname (str): Filename containing data to sign
> -            key_fname (str): Filename of .pem file
> +            key_fname (str): Filename of .pem file or PKCS#11 URI
>               sw_rev (int): Software revision
>               config_fname (str): Filename to write fconfig into
>               req_dist_name_dict (dict): Dictionary containing key-value pairs of
> @@ -101,6 +179,8 @@ imageSize              = INTEGER:{len(indata)}
>                   extended certificate
>                 - certificate (str): Extended firewall certificate with
>                   the information for the firewall configurations.
> +            pkcs11_module (str or None): Path to PKCS#11 shared library, or
> +                None if already configured via openssl.cnf or the environment
>   
>           Returns:
>               str: Tool output
> @@ -146,20 +226,20 @@ authInPlace = INTEGER:{hex(firewall_cert_data['auth_in_place'])}
>   numFirewallRegions = INTEGER:{firewall_cert_data['num_firewalls']}
>   {firewall_cert_data['certificate']}
>   ''', file=outf)
> -        args = ['req', '-new', '-x509', '-key', key_fname, '-nodes',
> +        args = ['req', '-new', '-x509', *self._build_key_args(key_fname), '-nodes',
>                   '-outform', 'DER', '-out', cert_fname, '-config', config_fname,
>                   '-sha512']
> -        return self.run_cmd(*args)
> +        return self._run_cmd_pkcs11(pkcs11_module, *args)
>   
>       def x509_cert_rom(self, cert_fname, input_fname, key_fname, sw_rev,
>                     config_fname, req_dist_name_dict, cert_type, bootcore,
> -                  bootcore_opts, load_addr, sha, debug):
> +                  bootcore_opts, load_addr, sha, debug, pkcs11_module=None):
>           """Create a certificate
>   
>           Args:
>               cert_fname (str): Filename of certificate to create
>               input_fname (str): Filename containing data to sign
> -            key_fname (str): Filename of .pem file
> +            key_fname (str): Filename of .pem file or PKCS#11 URI
>               sw_rev (int): Software revision
>               config_fname (str): Filename to write fconfig into
>               req_dist_name_dict (dict): Dictionary containing key-value pairs of
> @@ -170,6 +250,8 @@ numFirewallRegions = INTEGER:{firewall_cert_data['num_firewalls']}
>               bootcore_opts(int): Booting core option, lockstep (0) or split (2) mode
>               load_addr (int): Load address of image
>               sha (int): Hash function
> +            pkcs11_module (str or None): Path to PKCS#11 shared library, or
> +                None if already configured via openssl.cnf or the environment
>   
>           Returns:
>               str: Tool output
> @@ -231,10 +313,10 @@ emailAddress           = {req_dist_name_dict['emailAddress']}
>    coreDbgEn = INTEGER:0
>    coreDbgSecEn = INTEGER:0
>   ''', file=outf)
> -        args = ['req', '-new', '-x509', '-key', key_fname, '-nodes',
> +        args = ['req', '-new', '-x509', *self._build_key_args(key_fname), '-nodes',
>                   '-outform', 'DER', '-out', cert_fname, '-config', config_fname,
>                   '-sha512']
> -        return self.run_cmd(*args)
> +        return self._run_cmd_pkcs11(pkcs11_module, *args)
>   
>       def x509_cert_rom_combined(self, cert_fname, input_fname, key_fname, sw_rev,
>                     config_fname, req_dist_name_dict, load_addr, sha, total_size, num_comps,
> @@ -242,13 +324,14 @@ emailAddress           = {req_dist_name_dict['emailAddress']}
>                     imagesize_sbl, hashval_sbl, load_addr_sysfw, imagesize_sysfw,
>                     hashval_sysfw, load_addr_sysfw_data, imagesize_sysfw_data,
>                     hashval_sysfw_data, sysfw_inner_cert_ext_boot_block,
> -                  dm_data_ext_boot_block, bootcore_opts, debug):
> +                  dm_data_ext_boot_block, bootcore_opts, debug,
> +                  pkcs11_module=None):
>           """Create a certificate
>   
>           Args:
>               cert_fname (str): Filename of certificate to create
>               input_fname (str): Filename containing data to sign
> -            key_fname (str): Filename of .pem file
> +            key_fname (str): Filename of .pem file or PKCS#11 URI
>               sw_rev (int): Software revision
>               config_fname (str): Filename to write fconfig into
>               req_dist_name_dict (dict): Dictionary containing key-value pairs of
> @@ -259,6 +342,8 @@ emailAddress           = {req_dist_name_dict['emailAddress']}
>               load_addr (int): Load address of image
>               sha (int): Hash function
>               bootcore_opts (int): Booting core option, lockstep (0) or split (2) mode
> +            pkcs11_module (str or None): Path to PKCS#11 shared library, or
> +                None if already configured via openssl.cnf or the environment
>   
>           Returns:
>               str: Tool output
> @@ -342,10 +427,10 @@ coreDbgSecEn = INTEGER:0
>   
>   {dm_data_ext_boot_block}
>           ''', file=outf)
> -        args = ['req', '-new', '-x509', '-key', key_fname, '-nodes',
> +        args = ['req', '-new', '-x509', *self._build_key_args(key_fname), '-nodes',
>                   '-outform', 'DER', '-out', cert_fname, '-config', config_fname,
>                   '-sha512']
> -        return self.run_cmd(*args)
> +        return self._run_cmd_pkcs11(pkcs11_module, *args)
>   
>       def fetch(self, method):
>           """Fetch handler for openssl
> diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
> index b6e8b0b4fb09..cdeff1a227a1 100644
> --- a/tools/binman/etype/x509_cert.py
> +++ b/tools/binman/etype/x509_cert.py
> @@ -19,6 +19,18 @@ class Entry_x509_cert(Entry_collection):
>   
>       Properties / Entry arguments:
>           - content: List of phandles to entries to sign
> +        - keyfile: Filename of the PEM key file used to sign the binary
> +        - pkcs11-uri: PKCS#11 URI for signing via an HSM, e.g.
> +            ``pkcs11:token=mytoken;object=mykey;type=private``. When provided
> +            via ``-a pkcs11-uri=...`` on the binman command line (or via the
> +            ``BINMAN_PKCS11_URI`` make variable), it overrides ``keyfile`` for
> +            the signing operation.
> +        - pkcs11-module: Path to the PKCS#11 shared library (.so), e.g.
> +            ``/usr/lib/pkcs11/libsofthsm2.so``. Only needed when signing via
> +            HSM and the module is not already configured via ``openssl.cnf`` or
> +            the ``PKCS11_MODULE_PATH`` environment variable. Provided via
> +            ``-a pkcs11-module=...`` or the ``BINMAN_PKCS11_MODULE`` make
> +            variable.
>   
>       Output files:
>           - input.<unique_name> - input file passed to openssl
> @@ -27,6 +39,16 @@ class Entry_x509_cert(Entry_collection):
>   
>       openssl signs the provided data, writing the signature in this entry. This
>       allows verification that the data is genuine
> +
> +    To sign with an HSM, pass the PKCS#11 URI and optionally the module path
> +    at build time::
> +
> +        make BINMAN_PKCS11_URI="pkcs11:token=mytoken;object=mykey;type=private" \\
> +             BINMAN_PKCS11_MODULE="/usr/lib/pkcs11/libsofthsm2.so" \\
> +             PKCS11_PIN="1234"
> +
> +    The ``PKCS11_PIN`` environment variable is used by the openssl bintool to
> +    append ``?pin-value=<pin>`` to the URI when required.
>       """
>       def __init__(self, section, etype, node):
>           super().__init__(section, etype, node)
> @@ -53,6 +75,8 @@ class Entry_x509_cert(Entry_collection):
>           self.dm_data_ext_boot_block = None
>           self.firewall_cert_data = None
>           self.debug = False
> +        self.pkcs11_uri = None
> +        self.pkcs11_module = None
>   
>       def ReadNode(self):
>           super().ReadNode()
> @@ -61,6 +85,10 @@ class Entry_x509_cert(Entry_collection):
>           self.key_fname = self.GetEntryArgsOrProps([
>               EntryArg('keyfile', str)], required=True)[0]
>           self.sw_rev = fdt_util.GetInt(self._node, 'sw-rev', 1)
> +        self.pkcs11_uri = self.GetEntryArgsOrProps([
> +            EntryArg('pkcs11-uri', str)], required=False)[0]
> +        self.pkcs11_module = self.GetEntryArgsOrProps([
> +            EntryArg('pkcs11-module', str)], required=False)[0]
>   
>       def GetCertificate(self, required, type='generic'):
>           """Get the contents of this entry
> @@ -80,6 +108,13 @@ class Entry_x509_cert(Entry_collection):
>           if input_data is None:
>               return None
>   
> +        # Override keyfile with the PKCS#11 URI if provided. This must be
> +        # done here rather than in ReadNode(), because subclasses (e.g.
> +        # ti_secure_rom, ti_secure) call super().ReadNode() and then
> +        # overwrite self.key_fname with the DTS 'keyfile' property.
> +        if self.pkcs11_uri:
> +            self.key_fname = self.pkcs11_uri
> +
>           uniq = self.GetUniqueName()
>           output_fname = tools.get_output_filename('cert.%s' % uniq)
>           input_fname = tools.get_output_filename('input.%s' % uniq)
> @@ -93,7 +128,8 @@ class Entry_x509_cert(Entry_collection):
>                   key_fname=self.key_fname,
>                   cn=self._cert_ca,
>                   revision=self._cert_rev,
> -                config_fname=config_fname)
> +                config_fname=config_fname,
> +                pkcs11_module=self.pkcs11_module)
>           elif type == 'sysfw':
>               stdout = self.openssl.x509_cert_sysfw(
>                   cert_fname=output_fname,
> @@ -102,7 +138,8 @@ class Entry_x509_cert(Entry_collection):
>                   config_fname=config_fname,
>                   sw_rev=self.sw_rev,
>                   req_dist_name_dict=self.req_dist_name,
> -                firewall_cert_data=self.firewall_cert_data)
> +                firewall_cert_data=self.firewall_cert_data,
> +                pkcs11_module=self.pkcs11_module)
>           elif type == 'rom':
>               stdout = self.openssl.x509_cert_rom(
>                   cert_fname=output_fname,
> @@ -116,7 +153,8 @@ class Entry_x509_cert(Entry_collection):
>                   bootcore_opts=self.bootcore_opts,
>                   load_addr=self.load_addr,
>                   sha=self.sha,
> -                debug=self.debug
> +                debug=self.debug,
> +                pkcs11_module=self.pkcs11_module
>               )
>           elif type == 'rom-combined':
>               stdout = self.openssl.x509_cert_rom_combined(
> @@ -143,7 +181,8 @@ class Entry_x509_cert(Entry_collection):
>                   sysfw_inner_cert_ext_boot_block=self.sysfw_inner_cert_ext_boot_block,
>                   dm_data_ext_boot_block=self.dm_data_ext_boot_block,
>                   bootcore_opts=self.bootcore_opts,
> -                debug=self.debug
> +                debug=self.debug,
> +                pkcs11_module=self.pkcs11_module
>               )
>           if stdout is not None:
>               data = tools.read_file(output_fname)
> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index ca5149ee654a..a23719c767c8 100644
> --- a/tools/binman/ftest.py
> +++ b/tools/binman/ftest.py
> @@ -6884,6 +6884,116 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
>           err = stderr.getvalue()
>           self.assertRegex(err, "Image 'image'.*missing bintools.*: openssl")
>   
> +    def testOpenSslBuildKeyArgsPem(self):
> +        """Test _build_key_args with a regular PEM key file"""
> +        openssl = bintool.Bintool.create('openssl')

Please always check the bintool is present with

self._CheckBintool(bintool)

such that we can skip tests if it isn't present instead of failing hard 
later.

> +        args = openssl._build_key_args('/path/to/key.pem')
> +        self.assertEqual(['-key', '/path/to/key.pem'], args)
> +
> +    def testOpenSslBuildKeyArgsPkcs11Provider(self):
> +        """Test _build_key_args with a PKCS#11 URI when provider API is available"""
> +        uri = 'pkcs11:token=mytoken;object=mykey'
> +        openssl = bintool.Bintool.create('openssl')
> +        with unittest.mock.patch.object(openssl, 'run_cmd',
> +                                        return_value='pkcs11 provider'):
> +            args = openssl._build_key_args(uri)
> +        self.assertEqual(['-provider', 'default', '-provider', 'pkcs11',
> +                          '-key', uri], args)
> +
> +    def testOpenSslBuildKeyArgsPkcs11Engine(self):
> +        """Test _build_key_args with a PKCS#11 URI when only engine API is available"""
> +        uri = 'pkcs11:token=mytoken;object=mykey'
> +        openssl = bintool.Bintool.create('openssl')
> +        with unittest.mock.patch.object(openssl, 'run_cmd', return_value=''):
> +            args = openssl._build_key_args(uri)
> +        self.assertEqual(['-engine', 'pkcs11', '-keyform', 'engine',
> +                          '-key', uri], args)
> +
> +    def testOpenSslBuildKeyArgsPkcs11Pin(self):
> +        """Test _build_key_args appends pin-value to URI when PKCS11_PIN is set"""
> +        uri = 'pkcs11:token=mytoken;object=mykey'
> +        openssl = bintool.Bintool.create('openssl')
> +        with unittest.mock.patch.dict('os.environ', {'PKCS11_PIN': '1234'}):
> +            with unittest.mock.patch.object(openssl, 'run_cmd',
> +                                            return_value='pkcs11'):
> +                args = openssl._build_key_args(uri)
> +        self.assertIn(f'{uri}?pin-value=1234', args)
> +
> +    def testOpenSslBuildKeyArgsPkcs11PinExistingQuery(self):
> +        """Test _build_key_args uses '&' separator when URI already has query params"""
> +        uri = 'pkcs11:token=mytoken;object=mykey?module-path=/path/to/lib'
> +        openssl = bintool.Bintool.create('openssl')
> +        with unittest.mock.patch.dict('os.environ', {'PKCS11_PIN': '1234'}):
> +            with unittest.mock.patch.object(openssl, 'run_cmd',
> +                                            return_value='pkcs11'):
> +                args = openssl._build_key_args(uri)
> +        self.assertIn(f'{uri}&pin-value=1234', args)
> +
> +    def testOpenSslPkcs11UseProviderCached(self):
> +        """Test that _pkcs11_use_provider caches its result after the first call"""
> +        openssl = bintool.Bintool.create('openssl')
> +        with unittest.mock.patch.object(openssl, 'run_cmd',
> +                                        return_value='pkcs11') as mock_cmd:
> +            result1 = openssl._pkcs11_use_provider()
> +            result2 = openssl._pkcs11_use_provider()
> +        self.assertTrue(result1)
> +        self.assertTrue(result2)
> +        mock_cmd.assert_called_once_with('list', '-providers')
> +
> +    def testOpenSslRunCmdPkcs11NoModule(self):
> +        """Test _run_cmd_pkcs11 without a module just forwards to run_cmd"""
> +        openssl = bintool.Bintool.create('openssl')
> +        with unittest.mock.patch.object(openssl, 'run_cmd',
> +                                        return_value='output') as mock_cmd:
> +            result = openssl._run_cmd_pkcs11(None, 'version')
> +        mock_cmd.assert_called_once_with('version')
> +        self.assertEqual('output', result)
> +
> +    def testOpenSslRunCmdPkcs11WithModule(self):
> +        """Test _run_cmd_pkcs11 passes module paths to run_cmd via extra_env"""
> +        module = '/usr/lib/pkcs11/libsofthsm2.so'
> +        openssl = bintool.Bintool.create('openssl')
> +        with unittest.mock.patch.object(openssl, 'run_cmd',
> +                                        return_value='output') as mock_cmd:
> +            openssl._run_cmd_pkcs11(module, 'version')
> +        mock_cmd.assert_called_once_with('version', extra_env={
> +            'PKCS11_MODULE_PATH': module,
> +            'PKCS11_PROVIDER_MODULE': module,
> +        })
> +
> +    def testX509CertPkcs11(self):
> +        """Test X509 certificate creation using a PKCS#11 URI instead of a key file"""
> +        PKCS11_URI = 'pkcs11:token=test;object=mykey;type=private'
> +        PKCS11_MODULE = '/usr/lib/pkcs11/libsofthsm2.so'

FYI, the path isn't stable across all distros. Hence why we went for 
checking the path with p11-kit print-config to identify where it's located.

> +        original = bintool.Bintool.run_cmd
> +        signing_args = []
> +
> +        def fake_openssl(self_tool, *args, binary=False, extra_env=None):
> +            if self_tool.name != 'openssl':
> +                return original(self_tool, *args, binary=binary)
> +            arg_list = list(args)
> +            if arg_list == ['list', '-providers']:
> +                return 'pkcs11 provider'
> +            if '-out' in arg_list:
> +                signing_args.extend(arg_list)
> +                tools.write_file(arg_list[arg_list.index('-out') + 1],
> +                                 b'\x00' * 32)
> +            return ''
> +

We need to check with a real openssl too, otherwise we just check the 
interface with openssl and not that it is actually doing what's expected 
(and may change, e.g. with a newer version of openssl).

> +        entry_args = {
> +            'keyfile': self.TestFile('security/key.key'),
> +            'pkcs11-uri': PKCS11_URI,
> +            'pkcs11-module': PKCS11_MODULE,
> +        }
> +        with unittest.mock.patch.object(bintool.Bintool, 'run_cmd',
> +                                        new=fake_openssl):
> +            data = self._DoReadFileDtb('security/x509_cert.dts',
> +                                       entry_args=entry_args)[0]
> +        self.assertGreater(len(data), len(U_BOOT_DATA))
> +        self.assertEqual(U_BOOT_DATA, data[-4:])
> +        self.assertIn('-provider pkcs11', ' '.join(signing_args))
> +        self.assertIn(PKCS11_URI, signing_args)
> +

Why going to such length to avoid actually using openssl? 
Generate/import a certificate in softhsm2 and check that the bintool 
actually returns what's expected? We do this for signing FIT images so 
I'm assuming this is something you could do here as well?

Cheers,
Quentin
