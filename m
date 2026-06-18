Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF654CD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 17:42:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F087D80287;
	Thu, 18 Jun 2026 19:42:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="PKOeGL45";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D52208056B; Thu, 18 Jun 2026 19:42:30 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADCFC8005D
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 19:42:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dq0mS9WnSHUkVcrm+op+cm55uLHFr4o3FXtNSdHTqdo874XWJ0PX40nR0gMTg/HA7DZ+mBOp2J9xYC6hEjZHSw97Ip0ufclq39Z50aF9Qg5mK0y4StbCd0gxoxebvJZYAyGFUVgJz3qkcFIe6BZGBqY6ZGl2JeqZP5At2d9uaCoYGeCe9AK5Gk0FLJohz+4niJ62DotpbOAp8+bxb5iXmggTmYEkDP5+EfXbC7M6GSia83vBqssi6zN67hWQoIcfESrR5WqRehXodL8pISpM5NP6f34oMiB15IYBXsGPfF8LtAJMK12ZCRdUKnH4WvgzG/vu+ho80TvONLFqSvU8Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3CY64fHiT+dwx2Tv6rdRvMw/Y3CP/SPxIF64seghWg=;
 b=qhlfDwO3Hj7ruow193S+06grMtN1oqIz2VY3HUQx1BRdY1oyLrcDbBcvu5QEI2ft+o2Yb5xiqkGc06JnDZNoM41njGXlPMJnkONTxl7op9B4kawLQPqd7yzk5QTY6e22Kg2hjims+dcQ0yQaElNDLqN4/SBEZXVdya37TH8sigwU+a6TqffS+G0RORbvyJTcsDxcN+3I/3KHf4aw0CGjVbGtVNeF5bHT/d7ioofoGuO7Ioc+EH8wqb2zcgN/UrSGcF1UsbmDhI4bc4MokfOn+PDt1zUKqS32TKXBRgIjMn3OfpNwhx+n3spScGjO2uRjQzrj1PZD6cmkDrTpaz+5PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3CY64fHiT+dwx2Tv6rdRvMw/Y3CP/SPxIF64seghWg=;
 b=PKOeGL45cK7RKmbk5eLZtliRkTO4UitQ68HC9xl4aFl/SLntBHmPkmIz6LCDjt31hlrBO6IvXeYum+KrKeejcvbHcpQ/xTgi+Jo8t+wj6A11VGtJf0eQ9pGXSI9Y7XQpn2ODQ4kyjuuWjCFNc3RmqbUzND336AXpifJOq54PB+k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by DB9PR04MB8480.eurprd04.prod.outlook.com (2603:10a6:10:2c6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Thu, 18 Jun
 2026 17:42:26 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0071.010; Thu, 18 Jun 2026
 17:42:26 +0000
Message-ID: <cb1c95f6-bb58-45ec-a064-08422b7a8d72@cherry.de>
Date: Thu, 18 Jun 2026 19:42:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] binman: x509_cert: support PKCS#11 URI in keyfile
 for HSM signing
To: Sergio Prado <sergio.prado@e-labworks.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 ilias.apalodimas@linaro.org, marek.vasut+renesas@mailbox.org,
 sughosh.ganu@arm.com, wolfgang.wallner@at.abb.com, bb@ti.com,
 xypron.glpk@gmx.de, y.moog@phytec.de, afd@ti.com, Wojciech.Dubowik@mt.com
References: <20260525132828.3348679-1-sergio.prado@e-labworks.com>
 <20260525132828.3348679-3-sergio.prado@e-labworks.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260525132828.3348679-3-sergio.prado@e-labworks.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::6) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|DB9PR04MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: e85f0d20-99a3-4e9a-c95d-08decd60f5d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|3023799007|6133799003|11063799006|56012099006|4143699003|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: piYJxYE5OKTlXLzpzuOito9fnnhVp6WeVLKyAkZSOJhu4v7wfKfjphGQtNwIXNLBExF8H+eLBJJIScY8UB/isIkZ6pCobS5W1xPN9QJ3jlAyuRh9L/0vxxqJLXaUDHvn3nRXQit3bNjkrWaRr/hLOmrP58NpBWmfFkdT2KaZnSPRNrVfGfuMLDEjAbawUMDRZJRUATpihSggaZTeF0NrHeDyB9ex6DdTnGr9l/o6OJzukZV7Q3c0zogX3Pdq5K59eZFFxx+pBVnNqva9f/j/+YeCyGbseryHlEbo/Dxb3UhsJvKkaIczMJVECsYL7Hs1ottd4YHkJVgeTvMfr3mRU0+5UBDOEJlYuDUCFqlW51aJThjvZFlnUssB5o9lDwMaokZAkBOJkUsA6J4Q45TAu79LoQBrqtThIrZ11fHtILEeb0FDdG6ogBrRsmswJzJwsWRAm3rrHVj1EivTf/iyXpZshSegqMaFVb+4kh+FA7Suyn41z8LHXyJ+f57nBJ++/7CVFEt8H9BzLG+xUQCO1OXT9OE+ybEYV1KpoVfopvjSiNJAaPARffVEdRG2Q2vX5Emt2CiSuQRtdrxWNvIk+Mc9hsNdFGMgXS0jvu1W/A9IESQnTqwPJcII9mcwRUC8TU+bLbaRUPgVkIk6qg5KdvscKNbWYiuCS5OnLkeuIeNIXtWyXQm3jECAiqiBnW+E
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(3023799007)(6133799003)(11063799006)(56012099006)(4143699003)(5023799004)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eW0xN0pmZG9VK0U4SGl2cnFYQWZsY2ljdWp0OGNwSjAya3ltNWZJQnNvQ2ZC?=
 =?utf-8?B?cUVwdHVDQmxpVzZCRS9DM1h5bThXMnZSczc4aXpRUkVXU0hQRmV6KzR6Sml4?=
 =?utf-8?B?Qk8wd0VmOG5UYlVhYy9xT3NUTXhDNjA4WDNBYXAzbHNpWDRKMG9PQWJkSENm?=
 =?utf-8?B?bDNJTjgvOHhJdVQ0VlpqSUZ2MHBnZ212eTJaZDUrNWlPM05kUjRmSHh0a1cz?=
 =?utf-8?B?ekJ0cTdpQXNHOUNrQXBUSTV0UUhUQWlNWG5KejBnVHZMK09YemVMeEpiSk1G?=
 =?utf-8?B?R0Q4SE1xanNIUXMzUFBFYTF1Y0pnMHpBR0RlWE0wY2lFeGhwR3JnakZ2MFlW?=
 =?utf-8?B?ZXJFNzFKYmlVdDQ1eE5ZN1NoTWZ6UlZmMVZHOHZOV2FaMU1NaDBOaE5vM2M0?=
 =?utf-8?B?TXhhMW5UWTh5ZGJ2U2JBUlF3akRrSnVzUlZxdlNuTDJmVWxkNFZ5enlSU05v?=
 =?utf-8?B?YjlBZlZJeld4VW1FbW1IR1VLTnRwSDAvSzBFOUhreHRLelZJUjdkSG9yVWtH?=
 =?utf-8?B?VkExM2RaQU12ZG9ZbjZPWWo1b1VzUmFhVGVFQnJLSWpUSWhVRVlGY0gzdllU?=
 =?utf-8?B?THNzWlliVDJWY0JyUjVkVE95SHR2djcxUDVYNUFZeUJueWdwTjVEc3B0S2dN?=
 =?utf-8?B?cFhDR21tTmhDTFRmZ25OOHU2bmJCaTUxbEtkMis2N1diOXc1a1Q4VStacTRV?=
 =?utf-8?B?UGYwb3IwaGgwcGZOUjRNdVdoTGFzYXhnSUNNbWRFRmJXS3huQlg5RkF6QmJC?=
 =?utf-8?B?bXRqSmliSFVobW55WVd1ZkxmN1BveXhsaGUvcXhyNGtpWFdZSTc2ZzBJSG9R?=
 =?utf-8?B?aHYvVE5xYkNOazkwRUdIZ0lVMjRQNk1wN0V5ZDFmZVpnSTRQVkFFR2xCQndw?=
 =?utf-8?B?eE1hb1lMNStEZExjTWM2dlpKZko2bFBMWTRhM2JhWWRaR2M3eEFVaGZ1RVJS?=
 =?utf-8?B?VytxQytVYzZzWDhkajRoUmtrSzFPT2ZVNnBXWFZxcjIwNitGdi85Z3JLalJ4?=
 =?utf-8?B?TVlCRXhVK3REOHNMWEhuUGpJMGE5c2o5empkeWxBWjdqbWk0Y3RaQVBicXFX?=
 =?utf-8?B?MlhRTm5VWlAzZldlb280UGtIMWlsYm8yL29UNlBwSGlYLzU1R2Z0TkpiNTYy?=
 =?utf-8?B?NmY5Y2hnU0MyRHJkL2kzNEhkeGJwbkRKTVdIcWNuNUVodDY2WExrcmJ1MWxN?=
 =?utf-8?B?VThyRzZkekxUS01Cc2pvNk9YU1hjaFg0L2IxYnZNQ2YrL0RWU3RXMStqQXBm?=
 =?utf-8?B?d05SWGFmZlo4ajdpak1KYnF4ajJxbHdpTGRmMXFjRnZsREFteERhdEVLOEhy?=
 =?utf-8?B?T2ljYlpsRCt3c2p2QkNPWDZqNmNlL090NjdiWXI4emVFYWhkTm05cWJKQnBy?=
 =?utf-8?B?WWx3WTBaLzVzdVRNei9VbFRkamMrN216MkxkYXpOa3NrM29XOUtMNXltWVZF?=
 =?utf-8?B?WlRyY0lodkpWRFVKSGdKL2UwQVFiYlpYV3FIQS9ZeDAyWCs3TzlRdFdMSG0y?=
 =?utf-8?B?SUNuNGl5RHFBZXl2cENnSjVwMzRJSnI3Mml6YnFFM1lhczFiWFB1Q21scnVO?=
 =?utf-8?B?VGNrR1UwbVBXLzZpZ01UcmFFcXVqRzJxUTZuRFdXSHgxOWxQUjA0R0d5cjRp?=
 =?utf-8?B?TGhPOWpwb3Y2TnI0SFVpVmZJRzd0OUVaWXBSOXhRM1lWQTAxc1pXaGpvWDdP?=
 =?utf-8?B?VjhRRUZJV1JOTzY5TzdCNk1ITU5CQkUzOHRpWnpnditSMnRXZDMzNFg2M28y?=
 =?utf-8?B?TXF5cUc5RDlWM2tCYzNhc2s4N1A1VTMzdEkwWEtyYkFmTmZvMHdGdTBXSXor?=
 =?utf-8?B?Zm5SSXp5b2FNbUJpdUYvWDJKZmtTcE52azZta09vaFFFODBWZ3NKM3o5b0ZW?=
 =?utf-8?B?cjlqQ0h1LytWTkN0WEdSbUJHNXpoelErWXdSNVY0bmJCN1FOdkNXRjIrSkFu?=
 =?utf-8?B?T1gvTjc5ZU9qNy9vMXFRc2FwY2YvU1liZWQ0TGN5TDlrM1d4VVQ0YVNOZytN?=
 =?utf-8?B?QnRVRmhab0NEYnpreUFKOFBmZlRLUUVEUkZUaER3QVNnbml2MDN4QmxUNUJL?=
 =?utf-8?B?cUNoa2pJSVRvTXFoNm5DZGRWMWR2Z2x4T3hOajJQeFJVTG9qaDYzQVZkdXpX?=
 =?utf-8?B?ZEg2dVFRcXJuS0RhZ0VTWEZyUS9IMkhqdlNjWXZuYWZZeEpBR01YOXQyaEVL?=
 =?utf-8?B?TWhjY1g4amtabjRsd3BIOFhLTEdQYWV3M3FKSWxHMDlUbVo2QWhGdWpBdlN4?=
 =?utf-8?B?ZHY4ZkZ0OG5PNkpWVjd5SUJqcVVPd2ZHL2Jwd251Q1g0UVhPQVpVb3BISlUx?=
 =?utf-8?B?QldtM0VSLzhqMU1xMGFyNjd4aCtraCs3ZTlYN1dNRmFwZEprdmNmQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e85f0d20-99a3-4e9a-c95d-08decd60f5d6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 17:42:26.0402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fpTGSSLZ/vCB7l2qJeOgpqbD6DbuMDBqmWwMcLrt29v0Vl3zm8NNpyXjYYGBkwxgNn/uy1Nlg1uXeL5Nf2OuvuTOlmOPbnYp5UDedgJmCE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8480
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

Thanks for your patience!

I think this could be split in multiple commits. I could identify the 
following unrelated changes:

1) documentation on how to use PKCS11 signing (+ test for it). I believe 
PKCS11 is already supported via OPENSSL_CONF for the provider, with a 
pkcs11 uri in keyfile property in DT + additionally the pin either in 
OPENSSL_CONF or in the keyfile property directly, I haven't tested 
though so maybe I'm wrong
2) support for PKCS11_PIN environment variable to pass the pin, (+ test 
for it)
3) support for overriding the keyfile property via a make variable 
(BINMAN_X509_KEY_URI), (+ test for it)

Do you agree with this split?

There's quite a few comments below, but I don't think they require big 
changes.

On 5/25/26 3:28 PM, Sergio Prado wrote:
[...]
> The PIN-rewriting step in GetCertificate() uses a local variable
> rather than mutating self.key_fname, because ProcessContents() calls
> GetCertificate() a second time on the same entry; an in-place rewrite
> would double-append the PIN on the second call.
> 

Should we rather move this logic to ReadNode() instead then? Hopefully 
that is run only once? What made you chose GetCertificate() for this 
logic? Maybe I'm missing some clue.

[...]

> +BINMAN_X509_KEY_URI
> +    URI of a key used to sign x509 certificate entries via an HSM instead of a
> +    PEM key file on disk. When set, it is passed as ``-a keyfile=<uri>`` to
> +    binman, which overrides the ``keyfile`` entry argument for all x509
> +    certificate signing operations.
> +

This isn't specific to HSMI/PKCS11 though, is it? So it's just a way to 
override the keyfile entry argument by an environment variable. Yes, the 
typical usecase is to use it for an HSM but nothing forces you to use it 
for an HSM?

[...]

> +
> +    URIs currently supported:
> +
> +    - PKCS#11 URI (RFC 7512)
> +

Aren't we missing "local PEM key file" here?

> +    PKCS#11 signing requires OpenSSL 3.x. The provider or engine and the

Is it requiring OpenSSL 3.x though or did you only test on OpenSSL 3.x? 
Since engines were supported in OpenSSL 1.x, I would assume PKCS11 
signing also worked back then? Are you aware of a limitation? Also, does 
it NOT work with OpenSSL 4.x (which distro will slowly start to migrate to)?

What I'm trying to figure out is whether we should reword this to 
"PKCS11 signing is only tested on OpenSSL 3.x".

> +    PKCS#11 module must be configured externally via an ``openssl.cnf`` file.
> +    Either rely on the system default (``/etc/ssl/openssl.cnf``) or point to a
> +    custom file via ``OPENSSL_CONF``.
> +
> +    Two URI forms are supported on OpenSSL 3.x:
> +
> +    1. Provider path (recommended) — requires the pkcs11 provider, e.g. via
> +       the ``pkcs11-provider`` package::
> +
> +           make BINMAN_X509_KEY_URI="pkcs11:token=mytoken;object=mykey;type=private" \
> +                OPENSSL_CONF=/path/to/openssl.cnf
> +
> +    2. Engine path — for setups where only an OpenSSL engine is available
> +       (e.g. ``libengine-pkcs11-openssl``). Prefix the URI with
> +       ``org.openssl.engine:<engine_name>:`` so OpenSSL 3.x's STORE API
> +       routes it to the engine without requiring ``-engine``/``-keyform``

Ah yes, now I remember why it's OpenSSL 3+ only! Mmmmm then wondering 
what to do for OpenSSL 4.x, any chance you can test whether it works 
with OpenSSL 4? If not, then keep the previous paragraph as is and 
ignore my comment.

[...]
> +    OpenSSL 1.x engine usage is not supported transparently; users on
> +    OpenSSL 1.x need to provide the engine flags through other means.
> +

Yeah, or just say "OpenSSL 1.x is not supported." and be done with it :)

[...]
> +        PKCS11_PIN=1234 make BINMAN_X509_KEY_URI="pkcs11:..." \
> +                             OPENSSL_CONF=/path/to/openssl.cnf
> +

question: why suddenly the variable before `make`? All the others are 
after so it seems like an odd choice to me.

> +    Note: ``PKCS11_PIN`` keeps the PIN out of the ``BINMAN_X509_KEY_URI``
> +    value itself, but the PIN is still passed to ``openssl`` as part of its
> +    command line, where it is visible via ``ps`` and may appear in verbose
> +    build logs. For stronger isolation, configure the PIN inside
> +    ``openssl.cnf`` as described above.
> +

The third option is to have the pin in the URI directly (which is 
equally bad, but is possible no?).

I'm wondering if we should support replacing the PIN inside the URI if 
there's one in it and we also have PKCS11_PIN.

Side question, what happens if we have a pin set in openssl.cnf and also 
via PKCS11_PIN/pin in the URI?

Trying to figure out if we should explicitly document those 
incompatibilities (if they exist!) or test them if we want to support 
those cases.

[...]
> @@ -88,6 +93,15 @@ class Entry_x509_cert(Entry_collection):
>           if input_data is None:
>               return None
>   
> +        # When keyfile is a PKCS#11 URI and PKCS11_PIN is set, append the
> +        # PIN to the URI so signing runs non-interactively. The preferred
> +        # way to deliver a PIN is to configure pkcs11-module-token-pin in
> +        # openssl.cnf; PKCS11_PIN is the convenience fallback.
> +        key_fname = self.key_fname
> +        pin = os.environ.get('PKCS11_PIN')
> +        if pin and 'pkcs11:' in key_fname:

I agree with Simon here, we need to check the key starts with pkcs11: 
(and if we want to support OpenSSL engines with OpenSSL 3.x like we 
document if in here, then also org.openssl.engine:pkcs11:).

[...]
> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index 9a3811c17322..5ee118993390 100644
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
> @@ -6905,6 +6906,97 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
>           err = stderr.getvalue()
>           self.assertRegex(err, "Image 'image'.*missing bintools.*: openssl")
>   
> +    def testX509CertPkcs11(self):
> +        """Test X509 certificate signing via a PKCS#11 URI in keyfile"""
> +        openssl = bintool.Bintool.create('openssl')
> +        self._CheckBintool(openssl)
> +
> +        # Detect the OpenSSL pkcs11 provider. -provider asks OpenSSL to load
> +        # the named provider, so the command succeeds only when the provider
> +        # module is installed; this works regardless of OPENSSL_CONF state.
> +        result = openssl.run_cmd_result('list', '-providers',
> +                                        '-provider', 'pkcs11',
> +                                        raise_on_error=False)
> +        if result is None or result.return_code != 0:
> +            self.skipTest('OpenSSL pkcs11 provider not available')
> +

Idly wondering if we shouldn't do a simple try:except and let 
raise_on_error to True and skip in the except.

[...]
> +        with unittest.mock.patch.dict('os.environ',
> +                                      {'SOFTHSM2_CONF': softhsm2_conf,
> +                                       'OPENSSL_CONF': openssl_conf,
> +                                       'PKCS11_PIN': pin}):

Please add a test for when the pin is passed via the URI directly (as I 
assume this is supported) and not through the env variable.

> +            softhsm2_util.run_cmd('--init-token', '--free', '--label', token,
> +                                  '--pin', pin, '--so-pin', '000000')
> +            softhsm2_util.run_cmd('--import', private_key, '--token', token,
> +                                  '--label', key_label, '--id', '01',
> +                                  '--pin', pin)
> +
> +            uri = f'pkcs11:token={token};object={key_label};type=private'
> +            entry_args = {
> +                # 'keyfile' is set to a PKCS#11 URI rather than a filesystem
> +                # path. binman forwards it to 'openssl -key', which resolves
> +                # it via the pkcs11 provider configured in OPENSSL_CONF.
> +                # PKCS11_PIN is appended to the URI by Entry_x509_cert before
> +                # the openssl invocation, exercising _build_pkcs11_key().
> +                'keyfile': uri,
> +            }
> +            data = self._DoReadFileDtb('security/x509_cert.dts',
> +                                       entry_args=entry_args)[0]
> +        self.assertEqual(U_BOOT_DATA, data[-4:])

We should add a keyfile property in the test device tree to make sure we 
override it with the entryarg.

I'm also surprised tools/binman/test/security/x509_cert.dts doesn't have 
a keyfile property, isn't it marked as required in 
tools/binman/etype/x509_cert.py? AH! It seems like we pass it via an 
entryarg in testX509Cert and testX509CertMissing.

It'd be nice to check the engine works as well with the prefix. Not sure 
how to properly test this, if it's easier, I would be fine with checking 
we pass the key with the org.openssl.engine: prefix, at that point if it 
fails it's an openssl issue and we've already checked with the provider 
the code path is correct so that'd be an okay compromise to avoid 
testing the whole code path.

Cheers,
Quentin

