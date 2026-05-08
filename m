Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B344CD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 14:29:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12E4584C7E;
	Fri,  8 May 2026 16:29:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="AuKD63Xd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4481E84CE9; Fri,  8 May 2026 16:29:08 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C5D784A75
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 16:29:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uHPqEKoFJxp28i975RIIlFFZMWsd2yQU1TJURlu1SPrBfjtu2BtYyt4HTPL7Pzvixh0UB7h/Fi0jf2Ge7GvJi+3h+olBFSdLaFCjc1ZFm4H+gGoObMBZx3C9xh9L1KhJECF7aMmBOA5O7sl13PRZLz6jVRKp0CIuCoL9mmW4JknIJ7ifYgursqUGWI7oIXRW+D2b5kEGwQxAIa9xFkk3GfPVZ0LZVSglY6ADA8CoK7BTsH6WDmY6xt1eV3mi9Y99LDBKJrdlVoAWsWxIECHWwaXNOvzLOadq0AADmEz2YquSevOVeNzTrGMGMPXHT28dW4vhmrcpk8HQ2IrWSCiL7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=baelh4S0NAgvwIrh64jSXw7QNCHvI8UEDpcLgqAl6yg=;
 b=gCCWnxT3B1f4PP/NZsMYxsWtVthdSFhWidEn99peMnvX9AoUiwoCAr/JGqBTGorpLVpCH1fnb2Mj+tIfYvmhoBosoTwRI45PJVDK6AVdvV/lMJY86gZSkTHDPPDZpR3PqHezqbzsJCyouHyw5M3nf2d3NHddlNbFZax1WgtZUMPIWZkaxGIRd3gmjyJQWk9dN9+hn/VHq+mmf0D5Uzk6Fb0/ZeC/fFa77zTzl2+0ozaLVFxYwrwgH/ERSxMeWxXGfoM2hQVxtACBYLaIg+CGtKNGs7ujCx3dSsD8esYzkRiHRmjBmt1wHMQwFBnmGpdQGMgVf1g15Tq0N/e+pflYGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=baelh4S0NAgvwIrh64jSXw7QNCHvI8UEDpcLgqAl6yg=;
 b=AuKD63XdqNBwSrrmy/bVbaDdR/rm0LNKEN5cWU4Phjkf5OZtNUytfW6IH+EANcDlAHBbYi+QlMT6HsCuSmmIVEf1n0c4w3EnrZp0ZaB1O8R35t/SWEUWUvFRcH53ZkVJjwcamqtJXmeBdUGI9ajBhV16JO5cCIYZ1slTCGDPIjI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by FRWPR04MB11197.eurprd04.prod.outlook.com (2603:10a6:d10:170::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 14:29:02 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 14:29:02 +0000
Message-ID: <d8659668-165e-4572-9b66-6419a1909cf7@cherry.de>
Date: Fri, 8 May 2026 16:29:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] binman: x509_cert: add PKCS#11/HSM signing support
To: Sergio Prado <sergio.prado@e-labworks.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org,
 alpernebiyasak@gmail.com, ilias.apalodimas@linaro.org,
 marek.vasut+renesas@mailbox.org, sughosh.ganu@arm.com,
 wolfgang.wallner@at.abb.com, bb@ti.com, y.moog@phytec.de,
 xypron.glpk@gmx.de, jerome.forissier@arm.com, afd@ti.com,
 Wojciech.Dubowik@mt.com
References: <20260423154536.768603-1-sergio.prado@e-labworks.com>
 <20260423154536.768603-3-sergio.prado@e-labworks.com>
 <df749b3b-0210-4b31-a4e0-8f7af9084589@cherry.de>
 <CANu7NGs0=o5H7o=qwoQj5EYMxDtB7_NTus_-18Q1UZBnk3DiuQ@mail.gmail.com>
 <dc13566a-b477-4580-8954-0c0f83608ff1@cherry.de>
 <CANu7NGsFtWuLH1AZ_B8oMS8+rjpjgANYuVuVtVAaTNW1HzgcNg@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CANu7NGsFtWuLH1AZ_B8oMS8+rjpjgANYuVuVtVAaTNW1HzgcNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR03CA0032.eurprd03.prod.outlook.com
 (2603:10a6:803:118::21) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|FRWPR04MB11197:EE_
X-MS-Office365-Filtering-Correlation-Id: ce87395e-e18a-4cd9-f83c-08dead0e268b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fmtCG7B/hZLRzY4/+P8jAnaaiZESCd2pjR3uWhRPb+mJ20cppFvpiuz6k6USqnxJ9s5osuFO1G/wWmad7ZFv67IuTONZSKyLZ9HGuLUFxl0A75J0w1nOM54ygDsDGnTUO6iCrPzsOp0aE5NSqaUrdiHIOQYmPsBCIz0paqhy7aGB1gnqcrN3OvL8uwM1tGiaNr25s+d4w1xyCdojIbRnJtUf4ajbBhGyYteC9fVP13H5CTjIyA3zWo8QdiFOvbjH6dyX5JLuVcOkW8/jBrYfvE4hOkR+f7VY88GfYHUtccFT6X99Ieb9Ho6zAqf2zh2LcWwd9ptlXTwxsKEO6nRaHDtKe+l0Zqu+W6cBVVOXSiy2RRjEAP4KsPqn5vbgYjxgNAr2ueoa5UebH50SkYiBzpyHHdQbsi4vp1/i+az2TyfsAZC91+RgaDFN09+rtVazvTRs4PnxmZhzp2mc1MrJBvxe09tDx/Sv84fu2ZQgN6HXLpVUP/Mf2vWJ8F5lB529Z+G5pFOk6V1gmNk1zcAwJgGktyIrWnyaY8pQupw+27r8nFrlix8fKcKYVJSY5qN0lxRyjPkrUWbtTB/P1dKK/HFTjkH17hut1OE/z9isOj4iyNbu2F8+tPYyJlvW72eYvkYL5WhhmvWClOKduxVfWHp9qkGoO/aKTHcPW5CpBHo0PvsTmB9bjoVIrQsXx2lA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlE3cGgxSWVLVHhIOEhaNWxUMHdteWVBNzdBZmtzb2RrZTJZaUh0YXFBUEFC?=
 =?utf-8?B?Q2owL0FiSEJVTFJZSVp2S1ZERnBBc2dOOUY4REI1Sml4ZytxbkIzR1hhV1pY?=
 =?utf-8?B?OVc3SjFoL0EwdkNIbVlOQ2tJdmZWVnU5RVFSY1hucmkxbE55Y2kra2JZVFBs?=
 =?utf-8?B?UU0zWE12Ukt5ZDdaRjNoaExvM0w3eWNCcjZvWGpOQ0FKS0FNR052MVdLalFu?=
 =?utf-8?B?T25kbFJNMDZFUHlxQ2Z1R2orckFCUldFdng2QVBzMytvUTZhQ3VCUmFSQWgy?=
 =?utf-8?B?OWpQS3hxUngvZzhrRUxnOGFFMzUzSnMweU91QzJya2xsVUVHYy9mZnFBK1da?=
 =?utf-8?B?K1lLOVJEMStmNWFhMnBURlhBczRacjBzeW1xb3p0NFFEd2VNVzNGTzdNemxW?=
 =?utf-8?B?a01aTDVHSVZCQ0syQ3hmKzJBTXZjVEIzU0xjOFYyVWxLaEZjL3ZmWTJ3RkI0?=
 =?utf-8?B?SGhIVk5KMFRucjEzSzdlWjVieVdyd2l3Rzl3VjhmeE45YXo1Um0rWjhHSWRk?=
 =?utf-8?B?K1M2SGtqNzgxT3pKd3dmaExvTWxLbTRic0RTb3JvTDFrbHBuUHRGeU9Ua3hQ?=
 =?utf-8?B?MFNIWXV6VFowam5iL3M4eFplRXVOdVpFM0RocGNUaC9iaC8vMDd0aHpQZ0VD?=
 =?utf-8?B?YkJwZlNRMFAvU0ZnTnQ3ZlJsN2p4UVlocVJubVZIdXFPRkZGc05IOGhVQ1Ix?=
 =?utf-8?B?cVUwMHdRSmlUS1pSekltSW5HL20zenBBb25xcnpxOGNiWE9YSlNJOTAvcU5v?=
 =?utf-8?B?YkdkaHo3NXZVSHFEa1lxNGtiN1ZEWjQ5OU8rWXQwbXYzRC9KRHA3RkVJNUlG?=
 =?utf-8?B?NFdDbVZwSlVqaDhRMVloOStFSUtyZ3c4UWJWVzJKeWd5U3BnSGJiOGlvNnhI?=
 =?utf-8?B?V0Y0TlQ4NGIwbzhpbHRYaE9YREgxQ3U3MDFMcXhwZTVZVy9adlRLRWQ1M2JQ?=
 =?utf-8?B?QlJMdlBBOHFGaWZzekg0UGlHay9STisyNmRBZGN3cVVMUy84WFVYNVhoWlVV?=
 =?utf-8?B?eTlDaGJ6ZHlXd25KT3ZaT3VrTTlkRk1oSGtuM091cFBHMUtIVCtobVk2M0do?=
 =?utf-8?B?Y1NoVjdhSVZyOFFwVXNyNjZlc0FVbDdQc2hrSXBrcXQvOTlZRTNXRTlEYmh2?=
 =?utf-8?B?WnB1bmxXaWw2bExkN2laMzNwd21nQXJheFcweWx0K1FnS05JSklVSjdwb2p3?=
 =?utf-8?B?ajd3OGJ1Q2NCTmFXdGdPMm1ORjNNRkVoWmw3NllIeGRJUVIzV05tTXluRm1E?=
 =?utf-8?B?RExqSkk3clRJWFkzSytMQUUyQVliWEo5SjhCV3VPQXYwbVQ4dll0RmhValRi?=
 =?utf-8?B?cWYwK1NoWUZEWmdaVk5lUGlJZVp6VC9jV0UwYVpWTmNvdnNuUUJQR0JhR29Q?=
 =?utf-8?B?N1ZHeDJZOS82dFM0VWI4bXlLajJDbndBSndNdWh3MC9jL0NLa1dmbE9VM2V5?=
 =?utf-8?B?NVBBd003NWp5Vk1MUU5XZ3d2NHowTGZLWHhHQ2tSdm5KRktucGtmNnFCSWlh?=
 =?utf-8?B?ZytpOHBnUDNXWXJMcGM4UFFBSUdNRzZna0wvYmUwUEFqRHVRdURwRjFRcWlr?=
 =?utf-8?B?dkdSUFJVYU1XcVl0MGxVTEhuL2trK28yVW9hVHFqT29sdk5ETFE0dEkwSVVn?=
 =?utf-8?B?dkw2VnJEaVZBQ2k3WU1xc05UYWt3ejBJWXIxeFRyWEYyVG9hYnRIRE9oNXBY?=
 =?utf-8?B?RkFUNzd0a3U5aC9qYzRLWnk1eWlCSlo4SUR2NTdLTlpsVVdDbkZGNEJDVEZl?=
 =?utf-8?B?ZDBNbUVEU1c5eVJDVkFodWV2bDFQN2laSlhKMDJMUzBuTEordnZyNDVGcjVs?=
 =?utf-8?B?SFluWEdMSldvT1ZuUVhKYWpNYlZJaVN2RVIxR2xoV3pMbktsWkVwMWRoUTYv?=
 =?utf-8?B?STNFNE5tNmk0QmhvL2lPd1llN1NuUGJ2WlNBMlJKU3RkMy9DUFdGMFk1Qzdi?=
 =?utf-8?B?ZnpSd21OUlpUams0bGcxOFYra0lCY29TMnQzeE95SDZFbDEwNDYwTiszdng3?=
 =?utf-8?B?WlJFL1hxNEtubzFqc25yUjlITlNsNWtGSHpQanNHbjhhQ0JHdVJPWW94MXda?=
 =?utf-8?B?amRLKzlWSzdNSGdISFlxaE16Mi9qQ1Z3MHIyaVBsNkMrNUxPcUsvajl1K1Vi?=
 =?utf-8?B?NWo0UlplZzc3TXJieHhwOGRybGJrSUtBTWVuWkIya2NCeGtwK0hoNEx4R1NM?=
 =?utf-8?B?REgvYTM5V0ZQNFZEN0hneU9TOGxVcWpDQUdXZXg3Q3c0VUs4Tk5Zbk1JM1Bi?=
 =?utf-8?B?WnVYM3NpaTNqVDdkZ3NyN0FxNzR3QkQ5K0xMdDVRcVEzd1Zmb0l5ZUs2NHgv?=
 =?utf-8?B?ZkVvS1haYy9tSmRWNHFqYzBTWldPMDFNTWlXOEJoajlRUHFUUzBQUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ce87395e-e18a-4cd9-f83c-08dead0e268b
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 14:29:02.2478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IVpR+Vz8IdGPO53k3UqK9Ckt/URVPbt4puGlSXOaPiZ1vaeXn/EcngXpEXMZrxX6PdsF3v+hmNWfecNAQRhDfvZaLxSPYITyEa+dNPzsYrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11197
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

On 5/7/26 10:09 PM, Sergio Prado wrote:
> Hi Quentin,
> 
>>> Good point. I’ll scope this more precisely to X.509 usage. Would
>>> BINMAN_X509_PKCS11_URI be appropriate, or do you have a preferred naming
>>> convention here?
>>>
>>
>> Is this really PKCS11-specific? Is there no other way to get an x509
>> than by PKCS11 or plaintext file? Trying to think about potentially
>> having other providers needing something similar and then setting
>> BINMAN_X509_PKCS11_URI for that would be confusing.
> 
> Hmmm, good point. What if we rename the variable to BINMAN_X509_KEY_URI and
> the entry argument to key-uri?
> 

We should have x509 in the entry argument as key-uri could mean the URI 
used for signing FIT images for example.

The other thing I'm worried about is "will there always be only one x509 
certificate per binman invocation or can we have more".

For signing FIT images, it's pretty simple, mkimage only supports one 
configuration for the whole FIT last time I checked so it's not a worry 
as much more plumbing needs to be added to support that. Though what 
happens when you want to sign two FITs per binman run each with their 
own key... Not sure there's a usecase for that though.

>>>   From my testing with SoftHSM2:
>>>
>>> - Provider-based flow: configuring openssl.cnf is sufficient. OpenSSL
>>> dispatches "pkcs11:" URIs via the STORE API without additional CLI
>>> arguments.
>>> - Engine-based flow: configuring the engine in openssl.cnf alone is not
>>> sufficient; "-engine pkcs11 -keyform engine" must still be passed
>>> explicitly.
>>>
>>
>> Being curious now, I'm wondering if setting the -key to
>> org.openssl.engine:pkcs11:<key> would be enough on OpenSSL 3.x? C.f.
>> https://docs.openssl.org/3.0/man1/openssl/#engine-options
> 
> Good catch! It does work.
> 
> $ OPENSSL_CONF=test_engine.cnf openssl req -new -x509 -key \
>     "org.openssl.engine:pkcs11:${PKCS11_URI}" -nodes -outform DER \
>     -out cert_engine_unified.der -subj "/CN=test-unified-engine" \
>     -sha512 && echo "exit: $?"
> exit: 0
> 
> With this, the implementation transparently supports both flows on OpenSSL
> 3.x - the user picks the URI form to match their setup. I'll document both
> URI forms in the binman documentation.
> 

I guess that's acceptable. I don't think we should bend backwards to 
support OpenSSL 1.x :)

I've realized that we have only one test for the x509-cert entry type, 
seems like it'd be nice to have more :) I don't think we need to make 
this a requirement for this series though.
We also have virtually no documentation for the arguments (they shoiuld 
be in the docstring of the Entry_x509_cert class), this we should fix 
and add the new arguments/properties to the docstring.
Finally, Entry_ti_secure and Entry_ti_secure_rom both extend 
Entry_x509_cert and both call super().<method> on the Entry_x509_cert 
mtehods so their docstring should be updated to reflect that and 
possibly add tests for pkcs11 to those entries as well.

Cheers,
Quentin
