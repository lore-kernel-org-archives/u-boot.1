Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53294CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 10:28:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B47B7846BD;
	Wed, 20 May 2026 12:28:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="NKYB6FqV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A18D5846DF; Wed, 20 May 2026 12:28:25 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA46083FB0
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 12:28:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtaPA/sflkb2bCT+Pp/C2+lMftQrbq0hdXftuWPtjmZXo47oNzAKKnCNMaBzI/hBxaAM2MY9gsJDzvdeVHrtBuySM6PcxllIuP8TVtxoFuoDLxNFHpqtnMXp+78eQn+S8o17fLvaFFKYodJfpi2tVmiOCz4q2u1Nem79ULpGuzKOagXEt6z8TdmNLni0f9GRQNul7VaLZv12KGypf9qgFIoVbZMRJvJBxdvWNgbrDoRh4QDJC1og0d4shMIP7S5EbzGH+43i/cQ9zN3X/2D2hqQz2VZVnqi+TmdNBh5ejRfgtDsjjsUt10CBgDOkwyAl6lw43gjdMpBZsdwfpoDSIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhcAIWcwH9wZUB+HAITSq5xkpLreuyDiVzkvpX6GSyM=;
 b=iaHhu2A5eto7Oldc4jhAset/xcOYOcLBf6gSW4q4zeOtkxI+RqJ197iI9TFgNZ6YUBUbnDuihX/FdAFiAmSQiAZt1DKa+fI2pCYUTwbrn1JgsTssxbh18D4hp+GBpy8Es1PxFHNM8D1+UumVPp5CsHOsl+WWoTVy5LAGENikGJCUq50ao1TGd9GxtroBhSIs1bge1ApZW+f0up1pnzbs0IkhPLuEvLDw73EGIvAATjJSOnjcwTpMJ4TmyiYgr3V447KVikPMm1HgE+4sBvQnPloKwWKGOhdnl7IMdd+6vph+cieSQdpHXj4zI+yiPh0llQ8VKjQkdnBTajx1V3TNGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhcAIWcwH9wZUB+HAITSq5xkpLreuyDiVzkvpX6GSyM=;
 b=NKYB6FqVTW6IEQsDwIOu8JvCY1EHRf5PPANHUDYpjUh2WfnVn+jYt0+77w3r5MlanjmfGZqEiaCMfLe5ji9MA2kKh9GXZNQy8OHv2lpHcI7ULrftU2UpLDBpst+Z8Jye591CrxaOAk0g6GTVxylml4jtRp21GDwKnsh7eTxQLSI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by GV2PR04MB11798.eurprd04.prod.outlook.com (2603:10a6:150:2cd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 10:28:18 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9913.009; Wed, 20 May 2026
 10:28:17 +0000
Message-ID: <f1af4ba2-22d2-497b-9c98-09487ff06cf1@cherry.de>
Date: Wed, 20 May 2026 12:28:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Add support for OpenSSL Provider API
To: Eddie Kovsky <ekovsky@redhat.com>, Tom Rini <trini@konsulko.com>,
 Tobias Olausson <tobias@eub.se>, Paul HENRYS
 <paul.henrys_ext@softathome.com>, Simon Glass <sjg@chromium.org>,
 Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>, a.fatoum@pengutronix.de,
 mark.kettenis@xs4all.nl, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de
References: <20260429180247.83091-1-ekovsky@redhat.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260429180247.83091-1-ekovsky@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: VI6PEPF00000232.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8fc) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|GV2PR04MB11798:EE_
X-MS-Office365-Filtering-Correlation-Id: 89372191-44a4-4805-80da-08deb65a81f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|4133799003|3023799007|5023799004|11063799006|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: fdVMh2ZAQf9qMwg8yg/fD/naNy1PUHU1ncVTPBc3oyYHJ/2IHKa4jonW7UeToFF9XutMYAH6t+VZ4/VBWJIbNeADor6Rbfc8h0EsNwxwk5SAdDmOthQrRAd2qisisAbuFU/gF+vv+UJv8hP4pZPUmzFGpkad+AcEHd8V8Y08CbxofssRlF2dqlivdjrLp8gFNxfJT0a8K69++NGniairTxpM3UPPkHa1lP/nC0VtT2TRn3Sls7ch19iFQG+iZZhSSpistj41yrpmwaQxUUBn/qPerPhC5lv9b5yudi1KcBhseDKrKKdboluB75BJKETQgAzy7V6L+17YrHGG+IQ/cNipzrINTArwDDoQmIrdD99dI/adPxRnw3gYYxPiUURUPvxjiC0gvbN9gNWcr/2aV3uVeZXlF+5nTWFkzAA3KUJgz/BAYcoqQKWBRWDHOTYcibp+5PD3TiLHBfhfzoyhHRNzEg2vx1usdx5TN6gpeo37PxioGTkRLoLH/1j0hL+lilhAMoAjmvzbo5Qf9A9VBFR+bSrZylVdTPEnUXjqQ6VUVfNJoMVSZcPGQ0MPz0uoU4N8ekmUiwywQ15CMJk1jjfpRfzyP+JsA8ziuJrr2WFAm7XokKOdcW6tRbKyLFc1xvt/dmNLydwfOnWD6xgmA8vGdDHRVMn2x0fNCHcAFAbzlxbx3saKKpR0an0N6k4m
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(4133799003)(3023799007)(5023799004)(11063799006)(56012099003)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmxNWThVdEdFc3JRVkJnZTNlcEhPU0hsU0cxc1RvMUhWckdFWUxMcmtPL3NV?=
 =?utf-8?B?MmxCc09taUJwVG1QQnEva21lakg4Z25kc3FRd3lSUFdUM3ppWFI0NkJQUTBK?=
 =?utf-8?B?ajlqVVIvN1Z4YVd6YVN6eGNiQzhpUHVCMUNxOXpRcUpOYXBNUkViSnA5SUZB?=
 =?utf-8?B?WTJqL1hReVhhK2pBV000azdjTUw5Q0RtejQrVHNNTUh2SlF3cEFDMmlBLzJr?=
 =?utf-8?B?T2RTMkMzdkZ1SmlXdDlSdUVIV3orM1BjNG9XREtZR0FwelFFVGpLckRCdnhX?=
 =?utf-8?B?a1BlS2dPMHN2TzlmakxKb3l5N1d0bmllMVRNTjhON2RkOUJMK3VYckNJSkg4?=
 =?utf-8?B?Q0taSjBLQUdRd0lPOXRwclNXek5LZU8xMEliU1ZhendZakE5T2lIaVQ4WjNh?=
 =?utf-8?B?a3hCRFgwdkFDTjcwL1IyS2tGYWtZOXFkV1FlbklQMzJMaVJtbE91eFV5QlJE?=
 =?utf-8?B?Rm5pTlVJWHE0V3VEK3RVL3pPZThxSitNUzd4bFBaSys5NFI2MWZ1Vk9LSmc3?=
 =?utf-8?B?Q2lBaUs0dkJaMzN5Qlk0VDI5cmt2QnVnU3BHaEsvYW9tMTFrcWtVSVl3SVlr?=
 =?utf-8?B?VFRpZlJzQTBrR2lpRVpDT09Wb0V3VUczR3BtS0RWRjQwaHhPZ0Ira0JqWDM5?=
 =?utf-8?B?aWdhQ3pFM0NtYm40UmtQTDE5QkUzM0VDcDRDdFlqN1Z6RXBpMU9oMGNvZXlp?=
 =?utf-8?B?NjRocHowWHpHcmQzZkc5L29oeXNTbDNtdVQ0dDhRd2dSZU5WTkYvUjdsOXl0?=
 =?utf-8?B?Y3FNVXhtRkFtMU0zZTV5WndxSXVYSjV2cWo4ZzJpeU5wQmFLbmVxUjRmUjZO?=
 =?utf-8?B?K2MzZ3YwQ0c3Zms4STc5SStBbmxDRWR6aXZGMFUzZEdCU0kxcEtjMVo5SW15?=
 =?utf-8?B?dTd3UzVBUEEyNHM4ZnRwYW16RXJ4TW00OXNGUFp1Z0VzS01NdWdudnlySWls?=
 =?utf-8?B?UWd5ZXNKNGRhRXV0SUdpbnFHTlBOekRDREpyT2R4N0xhcXprL3JlNmJ6WTkv?=
 =?utf-8?B?blIyVFBldWRiREJSbjdMYkNTcGVwY0NYcW53a01JVDdVSU9EeHhCbHVxTHN1?=
 =?utf-8?B?ZThkOC8xTW1uRUl3RUtVNC92d1QzeVZVY2NFYW1mczlXSHlpaFBqbnd0a2ZP?=
 =?utf-8?B?a0NNamc2cmNwM2daSUxHNkFGK0JONkJGM2FwS1ZoYWdOTFNTQWp0a0J6MjZl?=
 =?utf-8?B?K1lCUTdySVEvZEZoNE5EWEtKSk5OREh6QnQyZkFVSGtKQlNnckRkdzJuYm1Y?=
 =?utf-8?B?VDRYc3JXMjBMd3JkOW9SWFBXZDNUeEM0dmRKempudHN3SE1INE1EUkRmK0Fk?=
 =?utf-8?B?TW1uMHBmY1VVeVd2ZDJBcVJEdHIzN1IxVTFnUHRKK2ZUMTF1TFlLV2lZQnR3?=
 =?utf-8?B?NFBEc29MVWRqV2xHMFNXOVNJcFlDc3A0elRhS1NMNzhMb3JCM1orU0NFYjh1?=
 =?utf-8?B?RFJIVXlFUVZrSWlrYlVmeC83eFdNcVVvVk1xalFIV1VVWG9KK0tMYVNJbEJZ?=
 =?utf-8?B?Tkl1WXdCZUFJTFFtQXFGVmdoL1VVTm1HTnh2OXFmZ3FYZzdMQ1p6TnJvUWtw?=
 =?utf-8?B?Y0lmeStlY3NGL09TUjhUWDlaRnNpcmZiV3B0M1ZuQUxzRm1jVnFZSjNxZkN6?=
 =?utf-8?B?RjBDVCtrd2hSTjMwa0dOaHBnWFBXR2dQcVpucUxwN2xWWmg5a0FwNzA4UDA2?=
 =?utf-8?B?ZjV1RUV0TkJhdkptSzNoaGhNUERGQmxCWjE1T1FiMVJnYmZoYUJVTVF1a2lv?=
 =?utf-8?B?eEtlQTV5VFloeXkzVDdXUlNSbVJza0RFWnU1OFg4VTJodkdTWFZoZktrM2dh?=
 =?utf-8?B?c0VSZ3hNOFFPM1FlRXRpR05MVmViYm9HTGZxaWZucGZWNGQ5U3U5eG1raVdX?=
 =?utf-8?B?NnFpY0RjaDcxMldzUHN1WFBlVXJacWxKbHFBdmlXcEJHSFN3RFJXenBVUTZ6?=
 =?utf-8?B?QkxxSTFGc2xlM1JtOVJ2OFZGU1Q0WXh1MlpzS1UxeDIwWnhVU2VKNGUyQjRL?=
 =?utf-8?B?VlRhL3ozZ1IrdzJxb0Z2VU4vdk9ZY3lwRmpvZVBJNEJCQll5SXI1dlFCZ2xr?=
 =?utf-8?B?NzUzeU9INTZYZXdtamlOMk1kSWV0aUtvRXl2bUZ2VllLTXcrTTVsaG9vZGlx?=
 =?utf-8?B?VGdyVzlKck1MTTMzamV5S2VzbDF2eERLaDJuZWZQY20yTFgxRitIUENpVkpI?=
 =?utf-8?B?Yk5Pd3hoTkFlVkQzTDNnd295cmFEd1A5WEcxRi85ZjJrby9sdlBTREpIUERG?=
 =?utf-8?B?ZjVVdkhnS3h6UFpjUDdKTC92amc1ZnJRcDVYMk43Y2l2VGVqYVpvVG9pcGlt?=
 =?utf-8?B?TkErbGlPS1JHQ1hORnNyTkYzVnZUQ1RydzYzTTZ6aTg3d3V0MXpzdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 89372191-44a4-4805-80da-08deb65a81f2
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 10:28:17.8731 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sylYcdGR8IDYnq0hi82Jt+scvmseQVAVQKg4SQeDOC3m/QKZz+3sx62h02HyGUdHsb2k8Mi/in/yZOPzF351xl+09Nb0xxwSuIcP9Kfl/J4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11798
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

Hi Eddie,

Thanks for working on this, this was a good base for me to work on 
supporting pkcs11 and custom OpenSSL providers for signing FIT images 
with binman.

On 4/29/26 8:02 PM, Eddie Kovsky wrote:
> The Engine API has been deprecated since the release of OpenSSL 3.0. End
> users have been advised to migrate to the new Provider interface.
> Several distributions have already removed support for engines, which is
> preventing U-Boot from being compiled in those environments.
> 
> Add support for the Provider API while continuing to support the existing
> Engine API on distros shipping older releases of OpenSSL.
> 
> This is based on similar work contributed by Jan Stancek updating Linux
> to use the Provider interface.
> 
>      commit 558bdc45dfb2669e1741384a0c80be9c82fa052c
>      Author: Jan Stancek <jstancek@redhat.com>
>      Date:   Fri Sep 20 19:52:48 2024 +0300
> 
>          sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3
> 
> The changes have been tested with the FIT signature verification vboot
> tests on Fedora 42 and Debian 13. All 30 tests pass with both the legacy
> Engine library installed and with the Provider API.
> 
> Tested-by Enric Balletbo i Serra <eballetb@redhat.com>
> Tested-by Mark Kettenis <mark.kettenis@xs4all.nl>
> Signed-off-by: Eddie Kovsky <ekovsky@redhat.com>
> ---
> Changes in v4:
> - Add comment that @engine pointer is null when using pkcs11 provider
> - Remove extra line break
> - Add pkcs11-provider package to build dependencies
> v3: https://lore.kernel.org/u-boot/20260120164524.253188-1-ekovsky@redhat.com/
> 
> Changes in v3:
> - Removed Kconfig option
> - Changed macro symbol from CONFIG_OPENSSL_NO_DEPRECATED to
>      USE_PKCS11_PROVIDER or USE_PKCS11_ENGINE
> v2: https://lore.kernel.org/u-boot/20251027195834.71109-1-ekovsky@redhat.com/
> 
> Changes in v2:
> - Remove default for new Kconfig option
> - Use #ifdef instead of IS_ENABLED macro
> - Remove comment after #endif
> - Remove unrelated checkpatch cleanup of 'sslErr' variable name
> v1: https://lore.kernel.org/u-boot/20251017171329.255689-1-ekovsky@redhat.com/
> ---
>   doc/build/gcc.rst       |   4 +-
>   lib/aes/aes-encrypt.c   |   4 +-
>   lib/rsa/rsa-sign.c      | 102 ++++++++++++++++++++++++++++++++++++++--
>   tools/docker/Dockerfile |   1 +
>   4 files changed, 103 insertions(+), 8 deletions(-)
> 
> diff --git a/doc/build/gcc.rst b/doc/build/gcc.rst
> index 1fef718ceecb..29a6a632e7e3 100644
> --- a/doc/build/gcc.rst
> +++ b/doc/build/gcc.rst
> @@ -25,8 +25,8 @@ Depending on the build targets further packages maybe needed
>   
>       sudo apt-get install bc bison build-essential coccinelle \
>         device-tree-compiler dfu-util efitools flex gdisk graphviz imagemagick \
> -      libgnutls28-dev libguestfs-tools libncurses-dev \
> -      libpython3-dev libsdl2-dev libssl-dev lz4 lzma lzma-alone openssl \
> +      libgnutls28-dev libguestfs-tools libncurses-dev libpython3-dev \
> +      libsdl2-dev libssl-dev lz4 lzma lzma-alone openssl pkcs11-provider \
>         pkg-config python3 python3-asteval python3-coverage python3-filelock \
>         python3-pkg-resources python3-pycryptodome python3-pyelftools \
>         python3-pytest python3-pytest-xdist python3-sphinxcontrib.apidoc \
> diff --git a/lib/aes/aes-encrypt.c b/lib/aes/aes-encrypt.c
> index 90e1407b4f09..4fc4ce232478 100644
> --- a/lib/aes/aes-encrypt.c
> +++ b/lib/aes/aes-encrypt.c
> @@ -16,7 +16,9 @@
>   #include <openssl/err.h>
>   #include <openssl/ssl.h>
>   #include <openssl/evp.h>
> -#include <openssl/engine.h>
> +#if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DEPRECATED_3_0)
> +# include <openssl/engine.h>
> +#endif
>   #include <uboot_aes.h>
>   
>   #if OPENSSL_VERSION_NUMBER >= 0x10000000L
> diff --git a/lib/rsa/rsa-sign.c b/lib/rsa/rsa-sign.c
> index 0e38c9e802fd..f456f3c58e65 100644
> --- a/lib/rsa/rsa-sign.c
> +++ b/lib/rsa/rsa-sign.c
> @@ -19,7 +19,47 @@
>   #include <openssl/err.h>
>   #include <openssl/ssl.h>
>   #include <openssl/evp.h>
> -#include <openssl/engine.h>
> +#if OPENSSL_VERSION_MAJOR >= 3
> +# define USE_PKCS11_PROVIDER
> +# include <err.h>
> +# include <openssl/provider.h>
> +# include <openssl/store.h>
> +#else
> +# if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DEPRECATED_3_0)
> +#  define USE_PKCS11_ENGINE
> +#  include <openssl/engine.h>
> +# endif
> +#endif
> +
> +#ifdef USE_PKCS11_PROVIDER
> +#define ERR(cond, fmt, ...)				\
> +	do {						\
> +		bool __cond = (cond);			\
> +		drain_openssl_errors(__LINE__, 0);	\
> +		if (__cond) {				\
> +			errx(1, fmt, ## __VA_ARGS__);	\
> +		}					\
> +	} while (0)
> +
> +static void drain_openssl_errors(int l, int silent)
> +{
> +	const char *file;
> +	char buf[120];
> +	int e, line;
> +
> +	if (ERR_peek_error() == 0)
> +		return;
> +	if (!silent)
> +		fprintf(stderr, "At main.c:%d:\n", l);
> +
> +	while ((e = ERR_peek_error_line(&file, &line))) {
> +		ERR_error_string(e, buf);

buf must be at least 256 bytes long, and it's 120 here. Either increase 
buf[] size to 256 or use ERR_error_string_n(e, buf, 120), c.f. 
https://docs.openssl.org/3.0/man3/ERR_error_string/#description.

> +		if (!silent)
> +			fprintf(stderr, "- SSL %s: %s:%d\n", buf, file, line);
> +		ERR_get_error();
> +	}
> +}
> +#endif
>   

OK so this was somehow unclear to me this was imported from Linux even 
though you stated that in your commit log. In the kernel, the macro and 
function are stored in scripts/ssl-common.h, I'm wondering if we can 
import it in a similar way (separate file) so that it's easy to keep 
track of changes made to the file in Linux and backport them to U-Boot 
whenever necessary. The origin is at least clear that way.

>   static int rsa_err(const char *msg)
>   {
> @@ -94,10 +134,11 @@ err_cert:
>    *
>    * @keydir:	Key prefix
>    * @name	Name of key
> - * @engine	Engine to use
> + * @engine	Engine to use or NULL when using pkcs11 provider

No, because this function doesn't exist whenever provider support is 
enabled. Since I would like to support both providers and engines in 
parallel (see the other review), this function can actually be built 
even if provider support is enabled. However, we shouldn't be calling 
this function with a provider. If engine is NULL, this function isn't 
called, see rsa_get_pub_key().

>    * @evpp	Returns EVP_PKEY object, or NULL on failure
>    * Return: 0 if ok, -ve on error (in which case *evpp will be set to NULL)
>    */
> +#ifdef USE_PKCS11_ENGINE
>   static int rsa_engine_get_pub_key(const char *keydir, const char *name,
>   				  ENGINE *engine, EVP_PKEY **evpp)
>   {
> @@ -157,21 +198,24 @@ static int rsa_engine_get_pub_key(const char *keydir, const char *name,
>   
>   	return 0;
>   }
> +#endif
>   
>   /**
>    * rsa_get_pub_key() - read a public key
>    *
>    * @keydir:	Directory containing the key (PEM file) or key prefix (engine)
>    * @name	Name of key file (will have a .crt extension)
> - * @engine	Engine to use
> + * @engine	Engine to use or NULL when using pkcs11 provider

Well, a provider isn't an engine, so I think it's pretty clear engine is 
supposed to be NULL when you don't want to use an engine? Also, this 
applies to all providers, not only pkcs11.

>    * @evpp	Returns EVP_PKEY object, or NULL on failure
>    * Return: 0 if ok, -ve on error (in which case *evpp will be set to NULL)
>    */
>   static int rsa_get_pub_key(const char *keydir, const char *name,
>   			   ENGINE *engine, EVP_PKEY **evpp)
>   {
> +#ifdef USE_PKCS11_ENGINE
>   	if (engine)
>   		return rsa_engine_get_pub_key(keydir, name, engine, evpp);
> +#endif
>   	return rsa_pem_get_pub_key(keydir, name, evpp);
>   }
>   
> @@ -207,13 +251,44 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
>   		return -ENOENT;
>   	}
>   
> +#ifdef USE_PKCS11_PROVIDER
> +	EVP_PKEY *private_key = NULL;
> +	OSSL_STORE_CTX *store;
> +

This is sneaky here because it's not in the git context, but above here 
there is:

"""
           if (keydir && name)
                   snprintf(path, sizeof(path), "%s/%s.key", keydir, name);
           else if (keyfile)
                   snprintf(path, sizeof(path), "%s", keyfile);
           else
                   return -EINVAL;

           f = fopen(path, "r");
           if (!f) {
                   fprintf(stderr, "Couldn't open RSA private key: '%s': 
%s\n",
                           path, strerror(errno));
                   return -ENOENT;
           }
"""

This means this function will fail if path cannot be found on disk, 
which I am assuming is the case for every provider. I'm wondering if you 
actually tested this with a provider or only with a file? (the 
OSSL_STORE_open() supports files in path but also providers (with the 
scheme (e.g. pkcs11:) as prefix)) (my grep-fu may be lacking but nothing 
in test/ seems to do anything with pkcs11?) If your only worry is to 
build with an OpenSSL without engine support but have no real interest 
in supporting providers, then just ifdef the engine support and let 
provider support be done by someone else (I'm looking into it now for 
signing FIT images, I've got something locally already).

Also, we have some logic for generating the proper path for pkcs11 from 
keydir, name and keyfile for the pkcs11 engine, c.f. 
rsa_engine_get_pub_key(), I'm assuming we may want something similar for 
pkcs11 provider.

Locally, I've gone for:

"""
          if (keydir && !strncmp(pkcs11_schema, keydir, 
strlen(pkcs11_schema))) {
                  // Create the URI for the PKCS11 provider
                  if (strstr(keydir, "object=") || strstr(keydir, "id="))
                         snprintf(path, sizeof(path), "%s;type=private",
                                   keydir);
                  else
                          snprintf(path, sizeof(path),
                                   "%s;object=%s;type=private",
                                    keydir, name);
           } else if (keydir && strstr(keydir, ":")) {
                  // Create the URI for specified provider from keydir 
and name
                  snprintf(path, sizeof(path), "%s%s", keydir,
                           name ?: "");
           } else if (keydir && name) {
                  snprintf(path, sizeof(path), "%s/%s.key", keydir, name);
           } else if (keyfile) {
                   snprintf(path, sizeof(path), "%s", keyfile);
           } else {
                   return -EINVAL;
           }
"""

> +	if (!OSSL_PROVIDER_try_load(NULL, "pkcs11", true))
> +		ERR(1, "OSSL_PROVIDER_try_load(pkcs11)");
> +	if (!OSSL_PROVIDER_try_load(NULL, "default", true))
> +		ERR(1, "OSSL_PROVIDER_try_load(default)");
> +

You can ignore this with

export OPENSSL_CONF=/path/to/my/openssl.conf

"""
openssl_conf = openssl_init

[openssl_init]
providers = providers_section

[providers_section]
default = default_provider
pkcs11 = pkcs11_provider

[default_provider]
activate=1

[pkcs11_provider]
activate = 1
"""

This will allow supporting any provider, not only pkcs11 and allow to 
build without pkcs11-provider installed if another provider is desired. 
Note that you're modifying code used to sign with RSA, it's not 
necessarily pkcs11 (unlike in the kernel from where you took inspiration 
which is explicitly pkcs11-only). This also allows to pass a pin for the 
pkcs11 provider without U-Boot needing to know about it.

> +	store = OSSL_STORE_open(path, NULL, NULL, NULL, NULL);
> +	ERR(!store, "OSSL_STORE_open");
> +
> +	while (!OSSL_STORE_eof(store)) {
> +		OSSL_STORE_INFO *info = OSSL_STORE_load(store);
> +
> +		if (!info) {
> +			drain_openssl_errors(__LINE__, 0);
> +			continue;
> +		}
> +		if (OSSL_STORE_INFO_get_type(info) == OSSL_STORE_INFO_PKEY) {
> +			private_key = OSSL_STORE_INFO_get1_PKEY(info);
> +			ERR(!private_key, "OSSL_STORE_INFO_get1_PKEY");
> +		}

I have been told that calling OSSL_STORE_expect() with the expected type 
should make it easier to get the object we want directly.

Something like

OSSL_STORE_expect(store, OSSL_STORE_INFO_PKEY);

right after OSSL_STORE_open(). I'm assuming this should allow us to get 
rid of the OSSL_STORE_INFO_get_type(info) == OSSL_STORE_INFO_PKEY check 
since OSS_STORE_load() would only return objects of expected type.

c.f. https://docs.openssl.org/3.0/man3/OSSL_STORE_expect/#description

I've not tested this myself yet.

> +		OSSL_STORE_INFO_free(info);
> +		if (private_key)
> +			break;
> +	}
> +	OSSL_STORE_close(store);
> +
> +	*evpp = private_key;
> +#else
>   	if (!PEM_read_PrivateKey(f, evpp, NULL, path)) {
>   		rsa_err("Failure reading private key");
>   		fclose(f);
>   		return -EPROTO;
>   	}
>   	fclose(f);
> -
> +#endif
>   	return 0;

Not much is actually shared in rsa_pem_get_priv_key between provider and 
no provider support so I think it may make sense to ifdef the whole 
content of the function or maybe the whole function even (or move the 
content into other functions).

>   }
>   
> @@ -226,6 +301,7 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
>    * @evpp	Returns EVP_PKEY object, or NULL on failure
>    * Return: 0 if ok, -ve on error (in which case *evpp will be set to NULL)
>    */
> +#ifdef USE_PKCS11_ENGINE
>   static int rsa_engine_get_priv_key(const char *keydir, const char *name,
>   				   const char *keyfile,
>   				   ENGINE *engine, EVP_PKEY **evpp)
> @@ -293,22 +369,25 @@ static int rsa_engine_get_priv_key(const char *keydir, const char *name,
>   
>   	return 0;
>   }
> +#endif
>   
>   /**
>    * rsa_get_priv_key() - read a private key
>    *
>    * @keydir:	Directory containing the key (PEM file) or key prefix (engine)
>    * @name	Name of key
> - * @engine	Engine to use for signing
> + * @engine	Engine to use or NULL when using pkcs11 provider

Same remark as above.

Cheers,
Quentin
