Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A07CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 11:17:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAC0E84A81;
	Thu,  7 May 2026 13:17:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Xa2KOpHU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3C2B84A81; Thu,  7 May 2026 13:17:07 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BDC884A6B
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 13:17:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KbtnFJkflbIrzFiTCjGIjTh8YOe9bR09JzyJhAVCjlR4al3ugwbyu0DaHGllYHGF1SUWxHFLyEwJCGINHAUqelDmTKLaIfNOwgiRaO8f5hHWNccGgtr2gniHgAu4wJqzvYhe/WGw2JsnL4Ga4yPhI37T6fC8exWHn0jg/QCJTJcKTz9ZFOHM3A9vvK6QmnfGyHpfb7MJPE6VUcJmsTGuXVnRQLawcJ0/g9s38UUTG+Y4j/2QSRqzO8q1n/cwovg4TnqNe543F+mZ3R8SNuFs1IhBeJ5BBrPm60MzTbj+H0pIcEJmv/iWd5huYkN6m9AV/OxG/WKAzOUmWc+uAoccRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMb95enmTZzD3Vb28KjxyHFgeB4oJ5uI2sxabizwk1A=;
 b=BQeCaEKv98t0WkuDEIweqhUwhuwahNJjmjmhf+HUP/3yeQSg4qWl0io4eFAMYtbv/dDiA/py0H9jhQUHmUyYKAzQUwbVLD3jK/SHJ3FEKJ9z+pjiZYDPfOyHmdBPQM3UhjHAfeXJPO6QbaCydi18tJN9WP9LykDbVTZEfVM0Cy2tluBhoMcIcnZjWJBwLK1P2LhcoADRkhfCJFAsGWSRmQ2C5auOudy/mx3F22hrvH6Q/U05e5GzTxlTgPKHDciLAwg5+MiJjuvQiw4qc6H6ukVSfaEUp0LuWpflLcgvWiUapxg+Z6/S/MQeAd7HemBbiavzhtsodzY+HCvtcAfxUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMb95enmTZzD3Vb28KjxyHFgeB4oJ5uI2sxabizwk1A=;
 b=Xa2KOpHUnlJi6vrW1ZLQsbPrWey4xp8YJHc1LqVbBF3qdKu0+1dDFqaeB9RChv6dNmIuYYZqLJHSoiaRHdDm59GGsW0LH3B2/Ect8hpgyX3wxGc3d5NnLjrR659HhhcvGcRggQgTfxWubJQnVkY18qdV0jehnngsAjUdL2INEL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AS8PR04MB8357.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Thu, 7 May
 2026 11:17:03 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 11:17:02 +0000
Message-ID: <f12da5bd-8bf5-4cca-9f20-0999ea36d025@cherry.de>
Date: Thu, 7 May 2026 13:17:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] boot: allow SPL FIT signature verification without
 DM
To: Lukas Schmid <lukas.schmid@netcube.li>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.denx.de
References: <20260430223319.2663939-1-lukas.schmid@netcube.li>
 <20260430223319.2663939-5-lukas.schmid@netcube.li>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260430223319.2663939-5-lukas.schmid@netcube.li>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIXP296CA0008.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a9::7) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AS8PR04MB8357:EE_
X-MS-Office365-Filtering-Correlation-Id: 93387f42-3c8c-4da7-7ada-08deac2a2a20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: aB6o3NnyOgrOCe946Rqap8yYiIdmTds2jTogEnqkULtJeG9kAz4qIwxydKOtKklaoFYK7RFAT6WnHAEVq/YNVFfwQuB/wcirZ+BT2vRrHMoxzVBytbfRyzxhblEoA+6RTOP3QFTfSsC32CsmV+yoC884F84ebjb01fg0gyYb+c5gV5qc9MA+4NL2nVWEDpbsk8c/lAUdIUifRQg1A5mhchkaXoHKUZ8u8Mvx/0/eG1pgnqEcuogHnFEzxk6zGisK1PA8dNs6bDlqtkC9LdzXn5IBDx74yFE3nIQ3nITqnugE+aM2WPnIeGEV/KblTDjBDOtWCBEttYiMT0ovXbswESeYcXlEhcaneb/I0Obm9VT6AV65ch1j9dvDS2oUd5nBVyHqCqJCpgMXr2AhT+kJChg8ssI222+uxq2whx0tKRrnSzFDYG7kXH8oue8Q50Mb9aIeDwaLv0bnWKAP3ygSQRgshlXCpuW0j1QElDjdAxNNdstljWJDinURJtCyfQYHjDRf9NMqmdoE3KQRk3DwaExQDqXzrcnJWGrACpK0nrmTY9VZuiqx0mdY09iGx/cHWTq1ujxNhrp6WCqSerqiVltYpIZHhkmkMS2BsAqbQcCchqmB9A2PI8Dphn9JxuFhXXLCXINoSQrWexdkGODfzvG2aGYKFO2iMItXuTwaQUXyAuXABPENb/u76HCVGj4t
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGdGeUhXMFQvQW5XOHRNRVllRndFZzI5TnFLUXB2cW9wYzBmdGpjRFd6SkhT?=
 =?utf-8?B?OFpvd2ZaOWw4NmUvMkZwb1dnSmc0WE0zckl5bk5OdGtKZ0hpMlNVcW1tYW5H?=
 =?utf-8?B?N05icFZvdXlRUlM1WFBQUjJKNWQ3NXRzU3paZVdXQXl2L3NocTBibTc3c1c3?=
 =?utf-8?B?RzExOXQ1TXg2Zjl5eUhUYS9pODIzNmdXRXlxK1JrQnJzaC9xa3I3TytDSjZ6?=
 =?utf-8?B?TUNidUNqUTVaY3BFYVpqZUdpRHQzQTJmQ1Z4ZXAxSktzdWNXamg0Rk1tLzJr?=
 =?utf-8?B?VG1DK3h3RmtoVUZxcGdxcTJJMFF1YUpoZS8xQ01LdG5uYWFoS0hkVTB2WjVG?=
 =?utf-8?B?YXZmQlFZTmtoamNqT09KcnFDMGJjd1I3UGlBS3I3STMrN1RvTWZmd0VHaDV3?=
 =?utf-8?B?U01FcExibEZRNFc4WFNnaVdqV1pRa0tFVXpuMjJHcFVKcnZVTDdXNjl4MmxR?=
 =?utf-8?B?M3ZOdEVackdvbTRkQ281T0hYRU8rOFI0SlV3d0dHMm9zS1h2Y21KMVRTODN6?=
 =?utf-8?B?OGRSWWNIM29YS3c4NHV2MWs2aTcrdExhREljaVNMSVFNUWl6bDBXWENGb2FY?=
 =?utf-8?B?aHFKMVh2aHB1MXpQUHdIMFdUU0I3Q0hNNVRyNkVMMUFsN2VvK0h2WWhFVVlO?=
 =?utf-8?B?TDNkUVcyRzJMYUpaR0tjNDZSRHhnQ3dxTkRaYXBUY0c5WkRkdm80aVczWmFr?=
 =?utf-8?B?b3NPNE92S1c2MmdGeStHdGlZQ1B5Q0Z3WHFSczFaTDkwSjJvVlZIOVZZeUxY?=
 =?utf-8?B?RW9lY1hsQ29IZExSenFWdzJub1U5Z2ZoMi9GOWJ0cVZrSGtPeWx5dlB2SFNl?=
 =?utf-8?B?NXdLYlJUcUttbU1lZTdWYVFNbXdBMVVubXo3QVl4WFhLbVEwNFd2eXN0aitJ?=
 =?utf-8?B?M2htelRDS0VML01QcjBUVmRJUVZmWkF2ZTVnNzBYZVhWaDVTUVovTWNMR3Bz?=
 =?utf-8?B?d0J6VFBnMTBTcWk5TndDdVhWN0E1RlU4QXlSWGczbmNOMnJoWWlHRXozVkdM?=
 =?utf-8?B?QzJIcmoycTJIaTlpbG0xUzRKQUpuMm81Y0hBdy9nd2QrN1E0UC85MmcrVW9w?=
 =?utf-8?B?b2lPaGZCcEl0N1EvWGtSdTZNUHNXdDlOYjRqaFFaOE81SWp5Z21uT2pTaGNs?=
 =?utf-8?B?dUcxUlpUNzJ1em5jVDB2Tk1PYng5a250bGtmd3gvR3loR3NHQ3hQQ0ZBOGxt?=
 =?utf-8?B?WG5CaklhcXZYdTRvaGdWSTlSMCtRV0hKemVjT2xXMVlEeDdySnJmM0JoQitI?=
 =?utf-8?B?bVVqQnV2aDJsM0xLZDdiMy9YT29PNEptVkxBTWdYcHlPWksvNlowaGgvMlJG?=
 =?utf-8?B?SFh1eEx3L0RlWXlTMVNtVCtiVXNrTEFUSjB0bmc3Ukk2dXdZSFhNYStyY1JH?=
 =?utf-8?B?c25BaEFGRlJndjUyc1JwK3lDMHlHd2lzbFFpWTNqcjNkNWJGL3B6Ujl5RDRY?=
 =?utf-8?B?YlUxcUpZUmhmd0VlSXp2NExPUENjTHh3aHFxQ3ZOVXFTa0RUempMdUp0Vko4?=
 =?utf-8?B?V1Y1c3hiRExFMjhuc0QwSW5Wd2VmbythY203bC9qall1SEF4d0xrZzdHd2pZ?=
 =?utf-8?B?V1lhdjRuTUdUUE9TTzhKZkUrbmo0NHVFVlQ0QXJUV2pncFBRSWkzYUMzQ1dC?=
 =?utf-8?B?R0kvYk4ya3orSzJCUjNlQmtaY21yaCtHdGFlMXlGUGNFdEhVamJUZXBuVjQ1?=
 =?utf-8?B?bXdldXRJdmlaRVROaVlpUit4NUNIaDJ5WVZTV0pnayt4VmdvYmdVU2w3K1ZP?=
 =?utf-8?B?dDB1VUpuY2xaVkxCQUNJclZtb1lDWTQxcG9ndTUxQ0NmTUJEbVVrM3Y5U1Y5?=
 =?utf-8?B?U2dpS3NjcDl0RHdwVUVDTWJBY3BORlhJbGM1OUtoWGc0M0pMVE5SUjU1ZFNv?=
 =?utf-8?B?RjJzb0s4RlEyZUNjT1NYck9wSk1XSWVOd3UrNDRldEQ3YStEOUluR2VYWnMr?=
 =?utf-8?B?d2x3KzlvajRBSXROZzlwZXR2Q0JaNXR1bTg4ZXh5YnhDNWN2T1hVV2YxK0w2?=
 =?utf-8?B?aTlibk56a1BRNk5nMG80OXU2eTBXWWVaVWhQY0NZU1ZtTTRNMU5sdWRHZGZ1?=
 =?utf-8?B?S0FYY2I4NVJPdHgzbWNocjZ6dzZjS0hFNXZrM2YrTnNCRW9Zcm11TE9Kcys1?=
 =?utf-8?B?NUlQZW1zM05rUXU1OXFTckxpTG9MZlloeW8yQllCUUFXcHFFY1ZkUFpUSzlS?=
 =?utf-8?B?TFdVQ2RpdExtYVdSdGx1czVWNE55QlBFcWFyTnBFSXJFMWRTdlluWWN0ZDB2?=
 =?utf-8?B?bDRVVkNFWU53NmhFOG9VL0RyLy9hVFJSaW80R2M2cHhUZ2ptaWwrVWs1ME9Z?=
 =?utf-8?B?Q1paeWtqdk96MUNwMlJWUnl0OWZvYndOa2ZpTlgrWlJEcjYyN1BuQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 93387f42-3c8c-4da7-7ada-08deac2a2a20
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 11:17:02.9337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ES/A1Xc5KXzx8REcUmvNGUBjSgqTD9x96y2+6UJyMqnR+wpBc8DGaKdc+GmAr9bYDgZ/rtxXDDlTJ/MO/uObmPaeYznYrVE4QXuElIisBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8357
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

Hi Lukas,

On 5/1/26 12:33 AM, Lukas Schmid wrote:
> SPL FIT verification was effectively tied to Driver Model. The RSA
> verifier assumed a DM-backed modexp device, and SPL_FIT_SIGNATURE
> depended on SPL_DM. This prevents non-DM SPL platforms from using
> FIT signature verification even though the software modular exponent
> fallback is already available.
> 
> Drop the hard SPL_DM dependency and only look up the modexp device
> when DM is enabled. Non-DM SPL builds then fall back to the software
> implementation and can enable signed FIT verification.
> 
> Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
> ---
>   boot/Kconfig         |  1 -
>   lib/rsa/rsa-verify.c | 16 ++++++++++------
>   2 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 4e9bc9491a0..6ccb7d44a5e 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -202,7 +202,6 @@ config SPL_FIT_FULL_CHECK
>   
>   config SPL_FIT_SIGNATURE
>   	bool "Enable signature verification of FIT firmware within SPL"
> -	depends on SPL_DM
>   	depends on SPL_LOAD_FIT
>   	select FIT_SIGNATURE
>   	select SPL_FIT
> diff --git a/lib/rsa/rsa-verify.c b/lib/rsa/rsa-verify.c
> index 3169c3a6dd1..24b23ab565a 100644
> --- a/lib/rsa/rsa-verify.c
> +++ b/lib/rsa/rsa-verify.c
> @@ -355,13 +355,17 @@ static int rsa_verify_key(struct image_sign_info *info,
>   	hash_len = checksum->checksum_len;
>   
>   #if !defined(USE_HOSTCC)
> -	ret = uclass_get_device(UCLASS_MOD_EXP, 0, &mod_exp_dev);
> -	if (ret) {
> -		printf("RSA: Can't find Modular Exp implementation\n");
> -		return -EINVAL;
> -	}
> +	if (CONFIG_IS_ENABLED(DM)) {
> +		ret = uclass_get_device(UCLASS_MOD_EXP, 0, &mod_exp_dev);
> +		if (ret) {
> +			printf("RSA: Can't find Modular Exp implementation\n");
> +			return -EINVAL;
> +		}
>   
> -	ret = rsa_mod_exp(mod_exp_dev, sig, sig_len, prop, buf);
> +		ret = rsa_mod_exp(mod_exp_dev, sig, sig_len, prop, buf);
> +	} else {
> +		ret = rsa_mod_exp_sw(sig, sig_len, prop, buf);
> +	}

Mmmmm I'm wondering if in the event we build with DM support but cannot 
find a modexp implem we shouldn't default to the software implem if 
available? Security-wise I'm not sure we're losing here, it's just that 
I'm assuming SW-based RSA verification is slower than HW-based no?

Also, this function is only defined when CONFIG_RSA_SOFTWARE_EXP is 
enabled (and we don't have a toggle for xPL phases (should we?)), so we 
need to handle this here to avoid breaking builds.

Finally, I still see RSA_SOFTWARE_EXP depends on DM at the Kconfig 
level. So bringing this in SPL seems wrong, as we would depend on U-Boot 
proper having DM enabled for it to work in xPL. So either the dependency 
is incorrect or we're missing something in SPL. With a cursory look at 
it, it seems DM isn't required so maybe we can drop it.

Cheers,
Quentin
