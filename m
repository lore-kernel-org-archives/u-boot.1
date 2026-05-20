Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27C1CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 11:19:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99F8C846E6;
	Wed, 20 May 2026 13:19:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="hJs8eXfs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0952F846FA; Wed, 20 May 2026 13:19:36 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48C8B846B0
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 13:19:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ifrlmULeqYnjzIy5FLNu3UrzrzGycTdCNik5/xZqP9/o/KPwuPZFxFEXRv2pA9GVCdpIOO9ukb+okbvphEm3xq7IhA9xPO1YDbzvEr+1KL21Mb05CcRRIOdRg60TYawWCIEDzH1IlCr+UOgi+F1y02pP/UHk4lIW74wy5iTCfU7r8+JdQGxK6u75LTfPW+2Cn6dXHjfLVoIKGkLytWFTVYIT3LLWh1zPejKWy+Mvhn7xPLMcnNLFjP89YHucYJ0ceOOBWTEYK26eQzF4RHvHYkreCkMTlEBbf/niUXDoVx8Dt7LIm6PBwCZYty+Q1kwjp/gZNf+4wa/lobbAB2q9Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDijlTcA/WhIojW06ot+aYqCeccHBnNOf/e8xe3u4iM=;
 b=RkiIrh4Lj4HZzbVfDgXD3ZvkuAGzyAVg4Gm0KQbdXwU6NA1e1BC2yH6WTot0Wo/CFmfIDiB4pBGkvD/eheIiOPD6VIxZx/xZuPndGJyW3ANWQ9u1lyBMNFVhBYW9XBcmsSlmuimEbtjEvZBad+FAAE8Mp1nwi6GZrn4Ql+kd5zf07G5Em/ChLr3RLDKImFyOnQy5YQZEr1vHgc6nIzHrsoxtg4VFE294SnGqbMrBA1NeUP4BxsRfEuau3ZanVu9juke5q3R1Fw0arEteNzgyA8Xz/6Ra8jucWOgVokVainNYWF/mwktCNn+m1YKTPR0lTv0QRugMx0WUZ6Ja3tCeIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDijlTcA/WhIojW06ot+aYqCeccHBnNOf/e8xe3u4iM=;
 b=hJs8eXfsznXaX2Gt0SImVXn6qq9ShbD1OjkGdEx/VHteLg7eZfeq57GdBy9VPmuuo1r5XLfzfmeA7KvVPZbZQmAz2yKa+EgLkmehk60KQVAPimbxi21fUDnuS4xZZ2lQ3FCsfAv6iOxV0apJEKboomwUOMkthlaCQND9I3ZgNNQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by VI1PR04MB10049.eurprd04.prod.outlook.com (2603:10a6:800:1db::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 11:19:28 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9913.009; Wed, 20 May 2026
 11:19:28 +0000
Message-ID: <19397895-224b-453b-8bef-b2daad30fc75@cherry.de>
Date: Wed, 20 May 2026 13:19:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] binman: x509_cert: add PKCS#11/HSM signing support
To: Sergio Prado <sergio.prado@e-labworks.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 ilias.apalodimas@linaro.org, marek.vasut+renesas@mailbox.org,
 sughosh.ganu@arm.com, wolfgang.wallner@at.abb.com, bb@ti.com,
 xypron.glpk@gmx.de, y.moog@phytec.de, afd@ti.com, Wojciech.Dubowik@mt.com
References: <20260513175640.1830541-1-sergio.prado@e-labworks.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260513175640.1830541-1-sergio.prado@e-labworks.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR09CA0120.eurprd09.prod.outlook.com
 (2603:10a6:803:78::43) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|VI1PR04MB10049:EE_
X-MS-Office365-Filtering-Correlation-Id: 54921c11-3374-4bf8-9c5c-08deb661a83e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|17002099007|18002099003|17092099009|22082099003|56012099003|3023799007|8142099006|11063799006;
X-Microsoft-Antispam-Message-Info: OWaYMi+kzLz1idFhAERaJNvcHnz+exaGzx7IdvzSYiBltU1LTnjBuUREFMxZ2/KBzFtj6AZtuV+NmHr4tT6FIgw/DUDAkttylTKqrDISHalXmQgnOTP+1IqxKU5Vwp+FF3KXcB8B9PHNkrxu48ybGAdGybhDHnG/OBWISVp1e9aMq+7eyD/03INXjkATD/tQTUWtN6NcE85i74ks9YWHY6LLhG2GZr9GGH9s4rWX/vmVtqwDFQTpBm1lr4vzmEsONz+8+WnShB5msdDg2CcgGx+UaDY6nYUIUTHis6Nw9Ry2SfrgRgeH0Odxztjk/DLYvChpkZGqORH63gYoKRJqKA6zZU1OzzB7fn8PUWTxX8rJfA/UMVSYEAgcyUZgyC7awOxJnwJNgmIp/YRGoIRkpCk2C2vmAkTmlzFLjFIk552hpyEFQALroeTq6xUWmob1ZJqM0n1TXFmq4NBygj1wkcY/g704yAiwhw3eru3Vk4zTah6+g//+dzEUlpe6g1h3KWD5GA4Dd1rJDs8Wa0lT5t5Wehhj5OA7E/06wTp+DonU4t3d8RmEbmRJ/8vVAOWDr4Xd0+LoteZtp2in0Dg0zquVIZ72XQPlI972vZz0zkMsDUP2UjGuJs8zcs6dNM3wowIdoghyCg6ugrNpJFkwzdE8gZT57q49ggBKdlmvXzNiD8/fHSb0D8zzJOYv0xqI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(17002099007)(18002099003)(17092099009)(22082099003)(56012099003)(3023799007)(8142099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnNmWml0T3djZ2dWMTJFeEpoYnJlZTVpc0ZNbGlpS3lYVjVCUmZJbFQ0UEZq?=
 =?utf-8?B?YlplUlh4UVBGQVZvNE5yUHM5bER6S3pXaTZ0UCs1cWtMVDh6Q05JZ3lreHhU?=
 =?utf-8?B?aHppZWtJUENKaEczYnBnbzVzVEw1WElLVHB6SFZ1dWJkODl3b0U2ZUIzOG9B?=
 =?utf-8?B?dzRvaVBwWWIxYk5aRXl2ZXBacjNEREJTSHU1QnBJd2hZR0xteGx6TEdQQWVE?=
 =?utf-8?B?cHdpQmdKMjhmZFB6VDBXcitDNlZqM1FOZ0dnNEY3S01PRDZ3OVZ2SjFqWW9S?=
 =?utf-8?B?ZllDYUVyMERoK0hxakFsd0R1eFZvcDNjUW0xZDc1aGlTNmROT2JpSGdDeTla?=
 =?utf-8?B?cU1nVk9Bb1lKbTY5dnQyaWk1NSt2ZkZpOHFLYk5PWXF6NlkvTXlFUExaYWpq?=
 =?utf-8?B?M2lQZUtqZE84RFRXUTh1cVJZbURjaUl4TVhvRUZVNzBkNHZhb3IwQ3pHbnUx?=
 =?utf-8?B?WnN0S1hYODc5VUtLUnN6ajlHZXUyOGhEL3MwNXdJcmlyN2pRQklyWWNZaEpo?=
 =?utf-8?B?YzlJdkhnQnRzN0RtZFJZZFF6UmxEaXc4NkkrWlpIdysxbThrSGVVQmpCZnJ1?=
 =?utf-8?B?KzFRT2RISmsxUFpoT21SRE14cWM5a0E4K09kdGlSQXVXWVR6ZE1xM29nRVZh?=
 =?utf-8?B?Y2hxV2Z0akVjancvRmFZMzBOZTN1eGZtdFNoYU9SVUtEeXRPT3RRTTlleEt0?=
 =?utf-8?B?bG9JSEVpeGdubFcxNHFkbE9TVzRzb0F2dUFkZlpIcU93NzMwUGFHWjZHL24z?=
 =?utf-8?B?UVY4RGJCMUkwQk9taCtxWVNIRUY4ZVJpN2w2WVl2YXRiTUlPTUVyV3pDYU0v?=
 =?utf-8?B?OTlBVkdOV1BxUC9QK1U2aUZHcy9RZFFuSTN6aS9oTklUb3FzcWJuQmxieUJ4?=
 =?utf-8?B?NkpUYUE2MmVaNTZYSzJFYU5Gdlg5ZTNlZFhzVDVUeTAzNlVLYlJZczdWVHRt?=
 =?utf-8?B?czRWd0ZVbmZXVU80TzV5RTZVUHNibHFJNWRkKzFkK1hGSVdiblcxcVNEdFVr?=
 =?utf-8?B?MXV1NWVMQ2JCQW5rQ1pKL2xlMlg5NGIyY3N6QkZja20vYTE2SkpVd1hVNXFv?=
 =?utf-8?B?bE96eGZDUjdTN0NNaVBHcXBnN1BaMjVyOG5ZZzdGUlBsbFduTFpCdnA0Zkhq?=
 =?utf-8?B?TUtQS1lKSFllZng2UDJlUEo2R0hWWG0wVjBnQzJZOEdqRGo5VXVNRDlGUDN3?=
 =?utf-8?B?Q0h4M281cEFIeEpVdGFpL0xIUWZnelVHUUcrZU1NN0NaT3V5elltUkUxNUxr?=
 =?utf-8?B?WkNUbHY2cmlySG01OFV3djF5eG1WMXd6OGNMUjM2TGFqaEtYWjBDTSsxOXBC?=
 =?utf-8?B?RzZaVSt2TlRJUk5Vb3daYzVwejZqV1hkVmpEdTRFdWZQN3FZV3RvOWg1U1Iy?=
 =?utf-8?B?bzlCa2Zqc0NvMGpSbnBpSXV0aTNaM2N0SVpzNSswUklFZ1FieG5nVENBbDZQ?=
 =?utf-8?B?alVFU1JBSmdYa0JtM1ZETW1sSTRnV3ZseG5HK1VFenB1WjM2UlFBeE9IYmxz?=
 =?utf-8?B?L1RUVzFEYVB2YTRUNllFcDFOd0U0UTBNUmJMUGhyRW55L3pRT1JtVW90RjJn?=
 =?utf-8?B?TXhUZUJmbjQ5c1NaYTJETlhQRzgxUHpXdFQxSStObk9hTHAzdmZGcWVvRkNN?=
 =?utf-8?B?bU5GY1l0bEZkK215WUpybWVGQ0E2cGtETEtUWW1pakZhZzNUcy9VR1JVaEFm?=
 =?utf-8?B?ajQzRWxkWUxQMC9zSm9kaVllTzJpYWpHZ0lsY3I5R0JRblVpWGRrMllYN3JG?=
 =?utf-8?B?MWlQbDliYVY0K2FlWFBNcWxTd0JSSjRXWFN1NkgzZW00QjRrVEFwVlZNYm5O?=
 =?utf-8?B?a01oU3R1THdCNm0zbXViOGl0bTdBN29hQld1NjlxN0JMS2M3dWRBWThNUVpi?=
 =?utf-8?B?WVpydU5OMGdHd2xjWWJyeW1jZFlJbU0yc3pkd3IvOUU4Lzc0T1hyTnM1QlIy?=
 =?utf-8?B?VTVmWGVTNXhVSENDRjBlQ3N2NjBTVU1nZWdXRDY5K1p4ZVhwV3Y4ZkIyaTdi?=
 =?utf-8?B?RGRCL203eWJFZkRzRmZWOGxxZVRaSC9ZUGd5b1VmWGVqUWw0ZERZRXlpeVoy?=
 =?utf-8?B?NVZML0NrY0RTYmNUSGhiYVNTVzljSXhDMW11R3RjaUxQdnVsYUNxZDV3cUVl?=
 =?utf-8?B?UVQrQS9PSVk0SlBiVVp3V3h1YmRaNlEvT2NVV0JUdmxHSzU2NmxaN1BwbUNU?=
 =?utf-8?B?WFpkUSthL3N5aGcxR05aTk9OSXMxc3d4NjVXcjhNMjFQYXloalhtM04yeU9Y?=
 =?utf-8?B?N3RBb0szQVZ1RFZhSEtSRldVcGJWWE1jbzVFU2dPL3N6bVhabXVtWXk4Y1Zi?=
 =?utf-8?B?dEZ2aU1za1JxT09BVytCWlN3ZE45bW90WHZ1L2xBZWp3Tll5Y1c2UT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 54921c11-3374-4bf8-9c5c-08deb661a83e
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 11:19:28.5668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RlDlx+M0LENZBKCYooFpjA0ThQ/J/gDRvMObrf+S/4KVwb2xVNU0EZMdjSPWiDovR5JLpiGTrZ+x0eE0sE+38eLn+Ys96hcCHlNdeR8f7pM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10049
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

On 5/13/26 7:56 PM, Sergio Prado wrote:
> Allow X509 certificates used for TI K3 secure boot to be signed via an
> HSM using the PKCS#11 standard, so that the private key never leaves
> the hardware token.
> 
> A new make variable BINMAN_X509_KEY_URI is introduced. When set, it is
> forwarded to binman as the x509-key-uri entry argument, overriding the
> keyfile property at signing time:
> 
>    make BINMAN_X509_KEY_URI="pkcs11:token=mytk;object=mykey;type=private" \
>         OPENSSL_CONF=/path/to/openssl.cnf
> 
> The OpenSSL pkcs11 provider or engine and the PKCS#11 module must be
> configured externally via openssl.cnf. Two URI forms are supported on
> OpenSSL 3.x:
> 
>   - Provider path: pkcs11:token=...;object=...;type=private
>   - Engine path:   org.openssl.engine:pkcs11:pkcs11:token=...;...
> 
> In both cases the user is responsible for configuring OpenSSL externally,
> as binman simply passes the URI to the openssl '-key' option. This keeps
> binman free of any PKCS#11-specific knowledge.
> 
> To run signing non-interactively, the PKCS11_PIN environment variable
> can be set; its value is appended to the URI as ?pin-value=<pin> (or
> &pin-value=<pin> when the URI already contains '?'), so the PIN does
> not have to be embedded in BINMAN_X509_KEY_URI.

It'd be nice to specify in the commit log the recommended way is to pass 
the pin via pkcs11-module-token-pin in OPENSS_CONF file.

> 
> Existing behavior is unchanged when BINMAN_X509_KEY_URI is not set.
> 
> Tested with SoftHSM2 and Yubikey on OpenSSL 3.x using the
> verdin-am62_a53_defconfig configuration.
> 
> Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
> ---
> 
> Changes in v4:
> - Drop the v3 bintool extra_env commit entirely; binman no longer
>    sets any PKCS#11-related environment variables (Quentin)
> - Drop BINMAN_PKCS11_MODULE / pkcs11-module entry argument; the
>    PKCS#11 module path must be configured externally via openssl.cnf
>    (Quentin)
> - Drop provider/engine auto-detection (_pkcs11_use_provider,
>    _build_key_args, _run_cmd_pkcs11) along with the threading.Lock;
>    the user selects provider or engine via OPENSSL_CONF and the URI
>    form (Quentin)
> - Rename the v3 BINMAN_PKCS11_URI / pkcs11-uri to BINMAN_X509_KEY_URI
>    / x509-key-uri to scope the names to x509 certificate entries
>    without locking them to a specific URI scheme (Quentin)
> - Document that the engine path is supported on OpenSSL 3.x by
>    prefixing the URI with org.openssl.engine:<engine_name>: (Quentin)
> - Replace the mocked openssl test with a real SoftHSM2-based
>    integration test using the provider path and OPENSSL_CONF (Quentin)
> - Use 'p11-kit print-config' to locate the softhsm2 library at test
>    time instead of hardcoding a distro-specific path (Quentin)
> - Use 'openssl version -m' (MODULESDIR) to locate the OpenSSL pkcs11
>    provider .so file, so multiarch paths like
>    /usr/lib/x86_64-linux-gnu/ossl-modules on Debian/Ubuntu are handled
>    correctly
> - Generate the test RSA keypair with pkcs11-tool; softhsm2-util has
>    no key-generation action (only --import) and silently exits 0 on an
>    unknown --generate-keypair option, which would leave the token
>    empty and make the openssl step fail with 'Could not read private
>    key'
> - Add self._CheckBintool() to all PKCS#11 test paths so tests skip
>    cleanly when bintools are missing (Quentin)
> - Extract the URI/PIN combiner into Entry_x509_cert._build_pkcs11_key()
>    and add a unit test for it
> - Document that PKCS11_PIN keeps the PIN out of the make command line
>    but is still visible in 'ps' output via the openssl invocation; for
>    improved isolation, configure the PIN in openssl.cnf
> - Document all Entry_x509_cert properties (content, keyfile,
>    x509-key-uri, cert-ca, cert-revision-int, sw-rev) in its docstring
>    (Quentin)
> - Add inheritance notes to Entry_ti_secure and Entry_ti_secure_rom
>    docstrings, pointing out that they extend Entry_x509_cert via
>    super() and therefore accept its properties (notably x509-key-uri)
>    (Quentin)
> 
> Changes in v3:
> - Split into two patches: bintool infrastructure (1/2) and x509_cert
>    feature (2/2)
> - Fix global environment mutation: _run_cmd_pkcs11() no longer writes
>    to os.environ directly; it now uses the new extra_env parameter so
>    module paths are scoped to the subprocess only, which is both
>    cleaner and safe under concurrent execution
> - Add module-level threading.Lock to serialise concurrent PKCS#11
>    signing calls and fix intermittent login failures caused by binman's
>    ThreadPoolExecutor
> - Fix URI query string separator: use '&' when the URI already
>    contains '?' (e.g. module-path already present), '?' otherwise
> - Test cases updated
> 
> Changes in v2:
> - Add tests for _build_key_args() (PEM path, PKCS#11 provider, PKCS#11
>    engine, PIN appending), _pkcs11_use_provider() (caching),
>    _run_cmd_pkcs11() (with and without module path), and end-to-end
>    x509_cert signing with a PKCS#11 URI (testX509CertPkcs11), ensuring
>    btool/openssl.py and etype/x509_cert.py have 100% test coverage
> ---
>   Makefile                            |   1 +
>   tools/binman/binman.rst             |  50 ++++++++++++
>   tools/binman/etype/ti_secure.py     |   5 ++
>   tools/binman/etype/ti_secure_rom.py |   5 ++
>   tools/binman/etype/x509_cert.py     |  52 ++++++++++--
>   tools/binman/ftest.py               | 118 ++++++++++++++++++++++++++++
>   6 files changed, 226 insertions(+), 5 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 552328f9f2c2..ac9b05668635 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1701,6 +1701,7 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
>   		-a vpl-dtb=$(CONFIG_VPL_OF_REAL) \
>   		-a pre-load-key-path=${PRE_LOAD_KEY_PATH} \
>   		-a of-spl-remove-props=$(CONFIG_OF_SPL_REMOVE_PROPS) \
> +		$(if $(BINMAN_X509_KEY_URI),-a x509-key-uri="$(BINMAN_X509_KEY_URI)") \
>   		$(BINMAN_$(@F))
>   
>   OBJCOPYFLAGS_u-boot.ldr.hex := -I binary -O ihex
> diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
> index 366491089ad9..b12dfe50679c 100644
> --- a/tools/binman/binman.rst
> +++ b/tools/binman/binman.rst
> @@ -2161,6 +2161,56 @@ BINMAN_INDIRS
>       Sets the search path for input files used by binman by adding one or more
>       `-I` arguments. See :ref:`External blobs`.
>   
> +BINMAN_X509_KEY_URI
> +    URI of a key used to sign x509 certificate entries via an HSM instead of a
> +    PEM key file on disk. When set, it is passed as ``-a x509-key-uri=<uri>``
> +    to binman, which overrides the ``keyfile`` entry argument for all x509
> +    certificate signing operations.
> +

Can't we reuse keyfile directly? keyfile can then point either at a file 
on disk or be an OpenSSL provider URI? This would limit the required 
changes in logic. It's piggy-backing on keyfile variable whose name 
doesn't indicate it should support provider URI and maybe I'm trying to 
fit something where it shouldn't.

> +    This only applies to x509 certificate entries (e.g. TI K3 secure boot). It
> +    does not affect FIT image signing, which uses device tree properties such as
> +    ``fit,engine`` and ``key-name-hint`` instead.
> +
> +    The URI is currently a PKCS#11 URI (RFC 7512). PKCS#11 signing requires

Rephrase maybe to something like

"""
URIs that are currently supported are:
- PKCS#11 URI (RFC 7512)

PKCS#11 signing requires...
"""

The wording is a bit odd currently but maybe you have something better 
to suggest?

> +    OpenSSL 3.x. The provider or engine and the PKCS#11 module must be
> +    configured externally via an ``openssl.cnf`` file. Either rely on the
> +    system default (``/etc/ssl/openssl.cnf``) or point to a custom file via
> +    ``OPENSSL_CONF``.
> +
> +    Two URI forms are supported on OpenSSL 3.x:
> +
> +    1. Provider path (recommended) — requires the pkcs11 provider, e.g.
> +       ``pkcs11-provider``::

The syntax is confusing here, is pkcs11-provider the provider path, or 
the required pkcs11 provider.

It's the latter, so I can suggest:

"""
e.g. via the ``pkcs11-provider`` package::
"""

What do you think?

> +
> +           make BINMAN_X509_KEY_URI="pkcs11:token=mytoken;object=mykey;type=private" \
> +                OPENSSL_CONF=/path/to/openssl.cnf
> +
> +    2. Engine path — for setups where only an OpenSSL engine is available
> +       (e.g. ``libengine-pkcs11-openssl``). Prefix the URI with
> +       ``org.openssl.engine:<engine_name>:`` so OpenSSL 3.x's STORE API
> +       routes it to the engine without requiring ``-engine``/``-keyform``
> +       flags on the command line::
> +
> +           make BINMAN_X509_KEY_URI="org.openssl.engine:pkcs11:pkcs11:token=mytoken;object=mykey;type=private" \
> +                OPENSSL_CONF=/path/to/openssl.cnf
> +
> +    OpenSSL 1.x engine usage is not supported transparently; users on
> +    OpenSSL 1.x need to provide the engine flags through other means.
> +
> +    To run signing non-interactively, set the ``PKCS11_PIN`` environment
> +    variable. Its value is appended to the URI as ``?pin-value=<pin>`` so the
> +    PIN does not have to be embedded in ``BINMAN_X509_KEY_URI``::
> +
> +        PKCS11_PIN=1234 make BINMAN_X509_KEY_URI="pkcs11:..." \
> +                             OPENSSL_CONF=/path/to/openssl.cnf
> +
> +    Note: ``PKCS11_PIN`` keeps the PIN out of the ``make`` command line and
> +    shell history, but the PIN is still passed to ``openssl`` as part of the

Not sure to understand how PKCS11_PIN is kept out of shell history?

> +    URI on its command line, where it is visible via ``ps`` and may appear in
> +    verbose build logs. For stronger isolation, configure the PIN inside
> +    ``openssl.cnf`` under the pkcs11 provider section
> +    (``pkcs11-module-token-pin``).
> +
>   BINMAN_TOOLPATHS
>       Sets the search path for external tool used by binman by adding one or more
>       `--toolpath` arguments. See :ref:`External tools`.
> diff --git a/tools/binman/etype/ti_secure.py b/tools/binman/etype/ti_secure.py
> index f6caa0286d97..433445207ef5 100644
> --- a/tools/binman/etype/ti_secure.py
> +++ b/tools/binman/etype/ti_secure.py
> @@ -48,6 +48,11 @@ endAddress{unique_identifier} = FORMAT:HEX,OCT:{self.end_address:02x}
>   class Entry_ti_secure(Entry_x509_cert):
>       """Entry containing a TI x509 certificate binary
>   
> +    This entry extends :class:`Entry_x509_cert` and chains through to its
> +    ``ReadNode`` and ``GetCertificate`` via ``super()``. All properties of
> +    ``Entry_x509_cert`` (notably ``x509-key-uri`` for HSM-based signing) are
> +    therefore accepted in addition to those listed below.
> +
>       Properties / Entry arguments:
>           - content: List of phandles to entries to sign
>           - keyfile: Filename of file containing key to sign binary with
> diff --git a/tools/binman/etype/ti_secure_rom.py b/tools/binman/etype/ti_secure_rom.py
> index 7e90c6559409..7676f1234433 100644
> --- a/tools/binman/etype/ti_secure_rom.py
> +++ b/tools/binman/etype/ti_secure_rom.py
> @@ -22,6 +22,11 @@ SHA_OIDS = {256:'2.16.840.1.101.3.4.2.1',
>   class Entry_ti_secure_rom(Entry_x509_cert):
>       """Entry containing a TI x509 certificate binary for images booted by ROM
>   
> +    This entry extends :class:`Entry_x509_cert` and chains through to its
> +    ``ReadNode`` and ``GetCertificate`` via ``super()``. All properties of
> +    ``Entry_x509_cert`` (notably ``x509-key-uri`` for HSM-based signing) are
> +    therefore accepted in addition to those listed below.
> +
>       Properties / Entry arguments:
>           - keyfile: Filename of file containing key to sign binary with
>           - combined: boolean if device follows combined boot flow
> diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
> index b6e8b0b4fb09..9bfb0aceddaf 100644
> --- a/tools/binman/etype/x509_cert.py
> +++ b/tools/binman/etype/x509_cert.py
> @@ -18,7 +18,25 @@ class Entry_x509_cert(Entry_collection):
>       """An entry which contains an X509 certificate
>   
>       Properties / Entry arguments:
> -        - content: List of phandles to entries to sign
> +        - content: List of phandles to entries to sign.
> +        - keyfile: Filename of the PEM key file used to sign the binary.
> +        - x509-key-uri: URI of a key to use for signing instead of the PEM
> +            ``keyfile``. Currently a PKCS#11 URI (RFC 7512), e.g.
> +            ``pkcs11:token=mytoken;object=mykey;type=private``, allowing the
> +            signing key to live in an HSM. When set via
> +            ``-a x509-key-uri=...`` (or the ``BINMAN_X509_KEY_URI`` make
> +            variable) it overrides ``keyfile`` for the signing operation.
> +            Requires OpenSSL 3.x with the pkcs11 provider configured via
> +            ``OPENSSL_CONF``. If the ``PKCS11_PIN`` environment variable is
> +            set, its value is appended to the URI as ``?pin-value=<pin>`` so
> +            that signing runs non-interactively.
> +        - cert-ca: Common Name (CN) embedded in the certificate. Used when
> +            generating a generic x509 certificate.
> +        - cert-revision-int: Integer certificate revision number. Used when
> +            generating a generic x509 certificate. Defaults to 0.
> +        - sw-rev: Software revision number embedded in the certificate by
> +            the sysfw/rom variants used by the TI K3 secure boot subclasses.
> +            Defaults to 1.
>   
>       Output files:
>           - input.<unique_name> - input file passed to openssl
> @@ -53,6 +71,7 @@ class Entry_x509_cert(Entry_collection):
>           self.dm_data_ext_boot_block = None
>           self.firewall_cert_data = None
>           self.debug = False
> +        self.key_uri = None
>   
>       def ReadNode(self):
>           super().ReadNode()
> @@ -61,6 +80,8 @@ class Entry_x509_cert(Entry_collection):
>           self.key_fname = self.GetEntryArgsOrProps([
>               EntryArg('keyfile', str)], required=True)[0]

Well... we'll override this with x509-key-uri if present, so why should 
this be required?

>           self.sw_rev = fdt_util.GetInt(self._node, 'sw-rev', 1)
> +        self.key_uri = self.GetEntryArgsOrProps([
> +            EntryArg('x509-key-uri', str)], required=False)[0]
>   
>       def GetCertificate(self, required, type='generic'):
>           """Get the contents of this entry
> @@ -80,6 +101,15 @@ class Entry_x509_cert(Entry_collection):
>           if input_data is None:
>               return None
>   
> +        # Set keyfile (override with the PKCS#11 URI if provided). This
> +        # must live in GetCertificate() rather than ReadNode() because
> +        # subclasses (ti_secure, ti_secure_rom) overwrite self.key_fname
> +        # in their own ReadNode() after calling super().ReadNode().
> +        key_fname = self.key_fname
> +        if self.key_uri:
> +            key_fname = self._build_pkcs11_key(self.key_uri,
> +                                               os.environ.get('PKCS11_PIN'))
> +>           uniq = self.GetUniqueName()
>           output_fname = tools.get_output_filename('cert.%s' % uniq)
>           input_fname = tools.get_output_filename('input.%s' % uniq)
> @@ -90,7 +120,7 @@ class Entry_x509_cert(Entry_collection):
>               stdout = self.openssl.x509_cert(
>                   cert_fname=output_fname,
>                   input_fname=input_fname,
> -                key_fname=self.key_fname,
> +                key_fname=key_fname,
>                   cn=self._cert_ca,
>                   revision=self._cert_rev,
>                   config_fname=config_fname)
> @@ -98,7 +128,7 @@ class Entry_x509_cert(Entry_collection):
>               stdout = self.openssl.x509_cert_sysfw(
>                   cert_fname=output_fname,
>                   input_fname=input_fname,
> -                key_fname=self.key_fname,
> +                key_fname=key_fname,
>                   config_fname=config_fname,
>                   sw_rev=self.sw_rev,
>                   req_dist_name_dict=self.req_dist_name,
> @@ -107,7 +137,7 @@ class Entry_x509_cert(Entry_collection):
>               stdout = self.openssl.x509_cert_rom(
>                   cert_fname=output_fname,
>                   input_fname=input_fname,
> -                key_fname=self.key_fname,
> +                key_fname=key_fname,
>                   config_fname=config_fname,
>                   sw_rev=self.sw_rev,
>                   req_dist_name_dict=self.req_dist_name,
> @@ -122,7 +152,7 @@ class Entry_x509_cert(Entry_collection):
>               stdout = self.openssl.x509_cert_rom_combined(
>                   cert_fname=output_fname,
>                   input_fname=input_fname,
> -                key_fname=self.key_fname,
> +                key_fname=key_fname,
>                   config_fname=config_fname,
>                   sw_rev=self.sw_rev,
>                   req_dist_name_dict=self.req_dist_name,
> @@ -168,3 +198,15 @@ class Entry_x509_cert(Entry_collection):
>       def AddBintools(self, btools):
>           super().AddBintools(btools)
>           self.openssl = self.AddBintool(btools, 'openssl')
> +
> +    @staticmethod
> +    def _build_pkcs11_key(uri, pin):
> +        """Append pin-value to a PKCS#11 URI when a PIN is provided.
> +
> +        Uses '&' as separator if the URI already contains '?', else '?'.
> +        Returns the URI unchanged when pin is None or empty.
> +        """
> +        if not pin:
> +            return uri
> +        sep = '&' if '?' in uri else '?'
> +        return f'{uri}{sep}pin-value={pin}'
> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index 9a3811c17322..98431ed17d98 100644
> --- a/tools/binman/ftest.py
> +++ b/tools/binman/ftest.py
> @@ -35,6 +35,7 @@ from dtoc import fdt
>   from dtoc import fdt_util
>   from binman.etype import fdtmap
>   from binman.etype import image_header
> +from binman.etype.x509_cert import Entry_x509_cert
>   from binman.image import Image
>   from u_boot_pylib import command
>   from u_boot_pylib import terminal
> @@ -6905,6 +6906,123 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
>           err = stderr.getvalue()
>           self.assertRegex(err, "Image 'image'.*missing bintools.*: openssl")
>   
> +    def testX509CertPkcs11(self):
> +        """Test X509 certificate creation via PKCS#11 HSM using OpenSSL provider"""
> +        openssl = bintool.Bintool.create('openssl')
> +        self._CheckBintool(openssl)
> +
> +        softhsm2_util = bintool.Bintool.create('softhsm2_util')
> +        self._CheckBintool(softhsm2_util)
> +
> +        pkcs11_tool = bintool.Bintool.create('pkcs11-tool')
> +        self._CheckBintool(pkcs11_tool)
> +
> +        p11_kit = bintool.Bintool.create('p11-kit')
> +        self._CheckBintool(p11_kit)
> +
> +        # Find the softhsm2 library path via p11-kit
> +        p11_kit_config = configparser.ConfigParser()
> +        p11_kit_config.read_string(tools.run('p11-kit', 'print-config'))
> +        softhsm2_lib = p11_kit_config.get('softhsm2', 'module', fallback=None)
> +        if softhsm2_lib is None:
> +            self.skipTest('softhsm2 module not found in p11-kit config')
> +
> +        # Find the OpenSSL pkcs11 provider module via the modules dir
> +        # reported by 'openssl version -m'. This handles multiarch paths
> +        # like /usr/lib/x86_64-linux-gnu/ossl-modules on Debian/Ubuntu,
> +        # which OPENSSLDIR does not point at.
> +        m = re.search(r'MODULESDIR: "([^"]+)"',
> +                      tools.run('openssl', 'version', '-m'))
> +        pkcs11_provider = None
> +        if m:
> +            candidate = os.path.join(m.group(1), 'pkcs11.so')
> +            if os.path.exists(candidate):
> +                pkcs11_provider = candidate
> +        if pkcs11_provider is None:
> +            self.skipTest('OpenSSL pkcs11 provider module not found')
> +

Can you explain why you're trying to find the module path? I don't think 
we need to know it?

If you want to check whether it's present,

openssl list -providers -provider pkcs11

will fail if not present, otherwise succeeds.

e.g. with a typo:
"""
$ openssl list -providers -provider pkcs1
list: unable to load provider pkcs1
Hint: use -provider-path option or OPENSSL_MODULES environment variable.
00B3ECA1B57F0000:error:12800067:DSO support routines:dlfcn_load:could 
not load the shared 
library:crypto/dso/dso_dlfcn.c:115:filename(/usr/lib64/ossl-modules/pkcs1.so): 
/usr/lib64/ossl-modules/pkcs1.so: cannot open shared object file: No 
such file or directory
00B3ECA1B57F0000:error:12800067:DSO support routines:DSO_load:could not 
load the shared library:crypto/dso/dso_lib.c:147:
00B3ECA1B57F0000:error:07880025:common libcrypto 
routines:provider_init:reason(37):crypto/provider_core.c:1026:name=pkcs1
$ echo $?
1
"""

"""
$ openssl list -providers -provider pkcs11
Providers:
   default
     name: OpenSSL Default Provider
     version: 3.5.5
     status: active
   pkcs11
     name: PKCS#11 Provider
     version: 1.1
     status: active
$ echo $?
0
"""

> +        prefix = 'testX509CertPkcs11.'
> +
> +        # Set up SoftHSM2 token and key
> +        softhsm2_conf_data = tools.read_file(self.TestFile('fit/softhsm2.conf'))
> +        softhsm2_conf = self._MakeInputFile(f'{prefix}softhsm2.conf',
> +                                            softhsm2_conf_data)
> +        softhsm2_tokens_dir = self._MakeInputDir(f'{prefix}softhsm2.tokens')
> +        with open(softhsm2_conf, 'a') as f:
> +            f.write(f'directories.tokendir = {softhsm2_tokens_dir}\n')
> +
> +        # Write an openssl.cnf that loads the pkcs11 provider
> +        openssl_cnf = self._MakeInputFile(f'{prefix}openssl.cnf', b'')
> +        with open(openssl_cnf, 'w') as f:
> +            f.write(f'''openssl_conf = openssl_init
> +
> +[openssl_init]
> +providers = provider_sect
> +
> +[provider_sect]
> +default = default_sect
> +pkcs11 = pkcs11_sect
> +
> +[default_sect]
> +activate = 1
> +
> +[pkcs11_sect]
> +module = {pkcs11_provider}
> +pkcs11-module-path = {softhsm2_lib}4

Why do you need those two lines? It doesn't seem to be required for me 
with my local work on supporting signing FIT images in binman with 
PKCS11 provider. I have the following:

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

This would also allow you to simply have this config file in-tree 
instead of generating it like for 
tools/binman/test/fit/openssl_provider.conf, this is not a requirement 
though, it's just what I've done for signing FIT images with engines 
(and what I'll do for providers).

> +activate = 1
> +''')
> +
> +        pin = '1234'
> +        uri = 'pkcs11:token=x509-test;object=testkey;type=private'
> +
> +        with unittest.mock.patch.dict('os.environ',
> +                                      {'SOFTHSM2_CONF': softhsm2_conf}):
> +            tools.run('softhsm2-util', '--init-token', '--free',
> +                      '--label', 'x509-test',
> +                      '--pin', pin, '--so-pin', '000000')
> +            # softhsm2-util cannot generate keys (only --import), so use
> +            # pkcs11-tool to generate the RSA keypair directly in the token.
> +            tools.run('pkcs11-tool', '--module', softhsm2_lib,
> +                      '--token-label', 'x509-test', '--login', '--pin', pin,
> +                      '--keypairgen', '--key-type', 'rsa:2048',
> +                      '--label', 'testkey', '--id', '01')
> +

Please use a file so we can run this test as fast as possible. We don't 
care if the key is truly private for tests. Can you use 
tools/binman/test/fit/rsa2048.key for example?

> +        entry_args = {
> +            'keyfile': self.TestFile('security/key.key'),

Please add a small comment that this is added to make sure we override 
the argument with x509-key-uri and that it has no other purpose than that.

Cheers,
Quentin
