Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAC0EC1430
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 12:41:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6FEA83F59;
	Tue,  3 Mar 2026 13:41:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="YyD8tmDu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 779318063E; Tue,  3 Mar 2026 13:41:14 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9710583F59
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 13:41:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXbkp0YZu4Iew0FDKiUkUqZv0Im6lAEVSndqOQp8GlOoW1B5zn+3Ed5ehK5LsFw1aLX99OAzDAD8pA+koll6Y+sZmgdoLj7sTF/RuuhwKdgizqpuurYTH91MrJcqL96QrOyUNqQcLZftUXfvEgR/+EizfE0DLCqputKUPQ6pBD5WLKmNhJCohRLM0t4wracEofBy3l6oedjg+dIc3PWSC6+iMWeWxRkRIkvfBjuuAx+2+qQGGORItbAnHBbbGtXisC4EYYn+1hoA2CKAWw+ZKJCrnT8v3Ijpq8O5j6SdKykj+h4OSeOOE8KLgYdpSLAV/T18Istm66uF4q/IzQ5p+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CVspJGSNckkS2ZMDLvtCx4TgjoinEyEHHBaq/qni4g=;
 b=ld4wwyaJFKYK2HiS90AgNvayTlNi8TWP8YQ+YuKB+Ay//X9kpXvQ4X25ph2FzkSsuTdl98wfNiDuzT9aC2DDX3EHR/HTmwuY7aTuwfi+kVSGkSQsNITSlaazaLHXC5zamuQjB3wxg0bbBT0uuJrJ59kwHG3DuBL+f9oxCbpBRxe/qTisgCSnC2/nZYPvuq9PqkO5rtvIT54sVqX1CcJMHl/6gXT/ZJ6J9hNDkPV6GerWs2Pugwk4bxdtBX/Zj2QRqUq6nUv3e5bSPECWtAkichk4NszGz5B6mbs8i6ZjsrZluzk18wyiLzDrvH8HWToxU6/Y9TNXPY6b6TOKzegT3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8CVspJGSNckkS2ZMDLvtCx4TgjoinEyEHHBaq/qni4g=;
 b=YyD8tmDuSBj7CDeu4K4cAt7W3039J9awNwecbYwcam19PwCBbtdeho1zgYRVYcLzWH1AaUnKLlwmuFAMPM7YL5LsUI1W0P/yICFKvk9t/pRHcdgVjHqE5u9WgqiuSMwhhFEstOeixymmIvvj6af5b4pRyG59U6iFf3ChYBFxEdg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AM9PR04MB7681.eurprd04.prod.outlook.com (2603:10a6:20b:286::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 12:41:03 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 12:41:03 +0000
Message-ID: <6a318143-7b58-4217-87f3-78fa6ef1348d@cherry.de>
Date: Tue, 3 Mar 2026 13:40:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 04/16] binman: test: Move FIT image test files to
 test/fit/
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Yannic Moog <y.moog@phytec.de>
References: <20260226234802.345968-1-sjg@chromium.org>
 <20260226234802.345968-5-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260226234802.345968-5-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0422.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::16) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AM9PR04MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: d0bb299e-7833-49f0-bb63-08de792221a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: fRvR0hYeDecHhc7COlrcSfLLuKnKtNExNiIhvIEfTPToidH7u3VFG1qA5S8rGQswbPrn4DefOTw38zLGF7GHwqvDmrO/wQ8q19t9z0xn3RknwPJulmPjY0VtIDa8mt4EQUKvVCCGwuJGOpZAzLQ4TRe4bs9dawIu3yCTef6JcqPlaaMHNBfRr6yYO2dwOGl/TRVoFfjL7CB4ZZwgvvhJ5jghBVVlIpjRYbEW8Dj6Tdqw07AaUxUhhyvTHg8SYzb6LGF0y11mjHC/R3iIKW9eiK1LP7qjA+897KgzK1rjKnUxo8QvfE4cpGyBryFAgULnlIbqW1I9Y8J8i0cpje9AKkavI2kgVDT9SMIotEIUedVW42T2+A/YnLwvm6Y8jFBn8jE89h2F23V9Rv5vQhQkhJUZAGOPxCTjxrA07VPbVFs9ZW9Iis0KX+Ed3iP7lxC9nWGRz3aaQfEJrB/w+jRnKHKgCkCTYlTjBt1nMY9dehtSlZBHsZNS8bwayEenSJzaFnliwyOwCPTYCGkjoYkoMiYlGh+jp9841y4wyJA/tiIoUa3S0mGS2PL1l+CPR/Op64dAYMRuKVkT0EWBQvf6AcWmjk1FQB+NBwk+mGS1fDt4aS6fzouGL9snY60ANap35+HC/YlHAmrkzgmF2YGhd1dyEfrrLrarGATKcih2QWruLkM2YXsajbKOz8gTcXZ81b0x3UZozm+vgDdAsboyyoOeRO6MUcFN4uXqIzHbi4o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1Zubm0vTUV1NFFIaDBiN3B0YXE4ZGd6QmRnY05RUlRnd2x0U0xKQnUrS05v?=
 =?utf-8?B?TmNKVDN1a3E2Njl3QnNBZUc2ZFk1WENlOEZIZ251MWMyUDQ3R05zS3VuSnQ4?=
 =?utf-8?B?QnRPQ1RzeURhN01yUVNwSms5d2ltWkcvS20wdlE3Zzc2b3I5UDlVZzdLRko4?=
 =?utf-8?B?bGtxQzl1aHk2djZNS0h0NGpGUHdua2x6V0xKMlRzTGppRG1WaXRRYXBhaEFD?=
 =?utf-8?B?bzJreUJtdkxuaVpTYUNqRkRMMjRJc0RlbVJ2WFIrWmVVMmhLWlFkYXIxQ0to?=
 =?utf-8?B?b3VEbGZIdWcyMnpKMFA3bnljQmpIa252UWlGWHpIbkdFV2IyS3c3TUYzZUMr?=
 =?utf-8?B?WmgzdUZ3TGVhcXZ6Vkc4OEFROFRwcmRuMXYrRTBHeEx3ZUJtbUJTbWdUVUFk?=
 =?utf-8?B?VTRNOXFtaUkydE4xZmhYY3Y3c1R4dGFMc2VMZ3lBaXRWOW9zTjFlbWdTVWJJ?=
 =?utf-8?B?SVcvK2Q4ZXRFODhsTkxVeklkQW8yVmI0Z3VBbVRCU0p4TWlvS1JoQkJCcUVU?=
 =?utf-8?B?RWJaOUp4QkRJYk9TVkE3MzVjMUl6ZlRaSGVQRmFIRXlTa0E3NXZtcUg3eGxM?=
 =?utf-8?B?NnJKb0xjNzIySjZuc0VpWHMreHZpa3lEK0tzaTJiMmtOSWhZYVM4YTRDRENa?=
 =?utf-8?B?T1FjclFSUVdTTC9iV3V1ZnpNa000eGxLTSt5MGJNMTcrbXZyek1kb3lOYzhW?=
 =?utf-8?B?YXFLemM3amx0VnFCQmJ4Z285bytlaFVHaFNZYXkyUUJzeEhxZ0xnMFYrK2JB?=
 =?utf-8?B?ZlVWamtMd0x2MGluU1VadVd1SjUwb0Mvc2VsYzkwRjJLTm1icDkyU1lIVi9l?=
 =?utf-8?B?Z3VQQkp5U1lCckRTZTV1MTg5THdWTmNObUFJNk1BVG91WVRLbHh0VkJYMWZj?=
 =?utf-8?B?aHF5Q1dpaGpnRlRyVVJTWXFxbC8rM0hzYWEwU2dsRUFscXVBSjFyWkw2M3V1?=
 =?utf-8?B?WVJ3MVJRYWsweXJKbnR2bG55WDNYRW9wRklkK2FZWjB0YkQ1dzdlSENrZ1px?=
 =?utf-8?B?VGtkK25zNGVGZ1orRHJMNGZ1THBhaWg0T2ZxN2hBaXArc2tXSE51OEN0K05L?=
 =?utf-8?B?M1FhVjA1cEdWa3dlNkdlNTlDRU1TYlE0NktjL1poQlc0RktJbkNKd2p3Q2gr?=
 =?utf-8?B?NzFKdkhQOXBHd0tTNE1wS0VFZFhJb3pZem0xd0hxTWF1dFFFNGdSQXFIRDZI?=
 =?utf-8?B?ZGx2TzBCeCtQNGZNUXJkcFdmNWdFcDB0SFZXZkhSYVJSTjJwUmdrb3NuWnl6?=
 =?utf-8?B?clJsVUJsUVYydjQwTDRONUFqbWozZTUwWXB4RXp4djUwekllbGorOHB4RG5N?=
 =?utf-8?B?cWFkMGdFdXdFUW9tWFVlVThaNjNxRmZRdTdjS2VXTkhqQ01rd0s2aVd5cWQ2?=
 =?utf-8?B?SmxQWWxlLzRzUmpuaUVHYUN3cnpyOUhaT3owWlJMUlFCbEkrcGZIamZ1dnBF?=
 =?utf-8?B?UzNUS0MrRkt1TUx3VFFmUyt2NVRvQWlxSGFvZ2xsSVBOWnVhNlNIdURxdTBr?=
 =?utf-8?B?NERLZCtxdktReXNMcFB5RVJmemhUYnpQOHlkSWRDL3RrSy96R3NXR0RRVnl6?=
 =?utf-8?B?QWY0R1o4cDdQNGlsU3R3RkROVFoxb2ZaSTZsVHlCMGFGZGZoN3FkWnFFYlBW?=
 =?utf-8?B?eDZaR1g0anY1RlRLVE53eGV1OWxXSXlmcENPQzVJaWxpT3ovamt5Nk1SaXgy?=
 =?utf-8?B?aWdhSmFXeUpOL1lLcnhCQ2tvczl0ckZqWHBLRXdSS1d1ZENuWWZDMHY1aE12?=
 =?utf-8?B?dDBaRjFGR3liRGh5ek5hdE50VjNFcnFlL0lQR2d5bU91b0s2bGpqYm9vNWVu?=
 =?utf-8?B?ZnFLcDU3MkNMYndPcmdDNzQ5U3d4ZUdYUDhyZXRaQXhaZThFYVpNTHFnaW1B?=
 =?utf-8?B?ZTRiSVhoR2lYaHhIcEhuS1RwQ21ucVhYd3pDekpVNFRycENWK1RuSm4rV1Jn?=
 =?utf-8?B?bHoyOXZKNitMdFBiVmNteUp3UTJzMXJiYlpjd0JNMXpXY0lLeE9pVElzcjg3?=
 =?utf-8?B?OENPNW5OajFCbjgzSlp0eHpFQTRzakxueWUzMEZDT2lDOGVzWWRvVzZLeGw4?=
 =?utf-8?B?T3NETlh2d3VkcmdFNlFnRXM0QURUczFTcitNV3dTa051NVBQQmlhYXhZVDdY?=
 =?utf-8?B?OUZ5ZjBFQkdZU0tTWVVnZ2hCSmVJK3lVYWFvMDI5b1VPdlV1Q1hsQ0ZDczdR?=
 =?utf-8?B?c3paMS83Q0ZLZmRKVW8vd2VjVGxCczlTWGZUUmMyUjhMaEM1SzRnZ3UySVNY?=
 =?utf-8?B?UFhBY2NaQUJZZ01ZSnpiV1ZUTGxZYkFrWEdBM3JJcEErS0VyTGQ3bVpmVk14?=
 =?utf-8?B?TXZoL3ljc1RRS0lCZHl2MThNRlYycHJBTHpDMW1aRmVFczlxWmxqdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d0bb299e-7833-49f0-bb63-08de792221a2
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 12:41:03.4823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LoyIx38MgR1jjMrGZna3PH4QWXfI+Ru7JwyLPHjSErpgT2TSDfQW0jmKFxq7QU6lPPOq/VdUSrSFgh7DUDETJEXO32Tab08loW2vUK1DvEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7681
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

Hi Simon,

On 2/27/26 12:47 AM, Simon Glass wrote:
> From: Simon Glass <simon.glass@canonical.com>
> 
> Move about 40 test files for FIT images (signing, external data,
> split-elf, encryption, alignment, firmware loadables, templates) into
> a fit/ subdirectory. Drop the numeric prefixes and the redundant fit_
> filename prefix, and update all references.
> 
> Rename the three signature.dts variants to have unique names:
> signature.dts, signature_multi_key.dts and signature_no_nodes.dts.
> 

What about aes256.bin, 340_rsa2048.key, dummy-rsa-engine.c, 
340_dummy-rsa4096.crt, 340_openssl.conf, 340_softhsm2.conf, and dev.key?

Can be done in a separate patch.

> Signed-off-by: Simon Glass <simon.glass@canonical.com>
> ---
> 
>   tools/binman/ftest.py                         | 118 +++++++++---------
>   .../test/{275_fit_align.dts => fit/align.dts} |   0
>   .../{227_fit_bad_dir.dts => fit/bad_dir.dts}  |   2 +-
>   .../bad_dir_config.dts}                       |   2 +-
>   .../bad_oper.dts}                             |   0
>   .../encrypt_data.dts}                         |   0
>   .../encrypt_data_no_key.dts}                  |   0
>   .../external.dts}                             |   0
>   .../extract_replace.dts}                      |   0
>   .../test/{170_fit_fdt.dts => fit/fdt.dts}     |   0
>   .../fdt_compat.dts}                           |   0
>   .../{333_fit_fdt_dir.dts => fit/fdt_dir.dts}  |   0
>   .../fdt_list.dts}                             |   0
>   .../fdt_missing_prop.dts}                     |   0
>   .../fdt_name.dts}                             |   0
>   .../fdt_oper.dts}                             |   0
>   .../fdt_phase.dts}                            |   0
>   .../firmware_loadables.dts}                   |   0
>   .../binman/test/{161_fit.dts => fit/fit.dts}  |   0
>   .../{219_fit_gennode.dts => fit/gennode.dts}  |   0
>   .../image_subentry_alignment.dts}             |   0
>   .../key_name_hint_dir_signature.dts}          |   0
>   .../missing_blob.dts}                         |   0
>   .../replace_sibling.dts}                      |   0
>   .../test/{280_fit_sign.dts => fit/sign.dts}   |   0
>   .../signature.dts}                            |   0
>   .../signature_engine.dts}                     |   0
>   .../signature_engine_encrypt.dts}             |   0
>   .../signature_engine_pkcs11.dts}              |   0
>   .../signature_engine_pkcs11_object.dts}       |   0
>   .../signature_multi_key.dts}                  |   0
>   .../signature_no_nodes.dts}                   |   0
>   .../split_elf.dts}                            |   0
>   .../subentry_bintool.dts}                     |   0
>   .../subentry_hash.dts}                        |   0
>   .../tee_os_opt.dts}                           |   0
>   .../tee_os_opt_bad.dts}                       |   0
>   .../template.dts}                             |   0
>   38 files changed, 61 insertions(+), 61 deletions(-)
>   rename tools/binman/test/{275_fit_align.dts => fit/align.dts} (100%)
>   rename tools/binman/test/{227_fit_bad_dir.dts => fit/bad_dir.dts} (71%)
>   rename tools/binman/test/{228_fit_bad_dir_config.dts => fit/bad_dir_config.dts} (71%)
>   rename tools/binman/test/{224_fit_bad_oper.dts => fit/bad_oper.dts} (100%)
>   rename tools/binman/test/{343_fit_encrypt_data.dts => fit/encrypt_data.dts} (100%)
>   rename tools/binman/test/{344_fit_encrypt_data_no_key.dts => fit/encrypt_data_no_key.dts} (100%)
>   rename tools/binman/test/{162_fit_external.dts => fit/external.dts} (100%)
>   rename tools/binman/test/{240_fit_extract_replace.dts => fit/extract_replace.dts} (100%)
>   rename tools/binman/test/{170_fit_fdt.dts => fit/fdt.dts} (100%)
>   rename tools/binman/test/{334_fit_fdt_compat.dts => fit/fdt_compat.dts} (100%)
>   rename tools/binman/test/{333_fit_fdt_dir.dts => fit/fdt_dir.dts} (100%)
>   rename tools/binman/test/{284_fit_fdt_list.dts => fit/fdt_list.dts} (100%)
>   rename tools/binman/test/{171_fit_fdt_missing_prop.dts => fit/fdt_missing_prop.dts} (100%)
>   rename tools/binman/test/{345_fit_fdt_name.dts => fit/fdt_name.dts} (100%)
>   rename tools/binman/test/{223_fit_fdt_oper.dts => fit/fdt_oper.dts} (100%)
>   rename tools/binman/test/{335_fit_fdt_phase.dts => fit/fdt_phase.dts} (100%)
>   rename tools/binman/test/{276_fit_firmware_loadables.dts => fit/firmware_loadables.dts} (100%)
>   rename tools/binman/test/{161_fit.dts => fit/fit.dts} (100%)
>   rename tools/binman/test/{219_fit_gennode.dts => fit/gennode.dts} (100%)
>   rename tools/binman/test/{167_fit_image_subentry_alignment.dts => fit/image_subentry_alignment.dts} (100%)
>   rename tools/binman/test/{355_key_name_hint_dir_fit_signature.dts => fit/key_name_hint_dir_signature.dts} (100%)

This file doesn't exist. What is this series based on? I'm assuming 
https://lore.kernel.org/u-boot/20260225225040.2568118-1-sjg@chromium.org/ 
but can you please specify series dependencies in the cover-letter so we 
don't have to guess. I'm also thinking the parent dependency have two 
patches we wouldn't need with this series here (rename and drop the 
number, patch 1 and 2 of the series).

Cheers,
Quentin
