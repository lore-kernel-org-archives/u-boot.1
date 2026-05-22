Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE1BCD5BB0
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 14:37:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46D17847C4;
	Fri, 22 May 2026 16:37:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="F/CqCdr9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42071847C8; Fri, 22 May 2026 16:37:54 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FDF2846DF
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 16:37:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iz3G+fWj7jdCUqoID9obpNIlCsdp3aGkANLBV/xvpWzVJcXgEZ6gskL/7nxXnfgiSOM23ps/CUMHpwX+70+X6f4Or4ktkPEp+t88DCFes00WXCIiz/SvV1IjkPWebQ23BkSARTt4ajutK3A+HpiqdsapMxhyeEgoy4JDGEBG8/tiir5Lq78vKl6E0Lrch9jx88io2zV9WttoZJU+DpdJa4cirXclhWhBMNoaJP1KkMq1gchezjAr75Q/Bxrc2Q6mHwNfFvD1L+k3Nldf5qk3rvAEqVhP+t/hYG1TeC9TJ4juPsbcyd8vZQcFaZkEN79UKYofVarv+Wz1xo1/bjtdzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBjCjBbFOZuDKP4LFhkbC+xOPUjlujfy5xcuf6iMV2Y=;
 b=YPZLxfxULN7x+0F9HzwiHD4UeNxOSdYN12Vtdk3VNSeb+usF3A06dhOfhWIZ5i9IUuuCVBZrRpDE5Yr9piL5moTTQL/MiF4QdSFEkFsjHix5lkoyCxEZnoomX7eNWiXb8x4wl7kyEDYrU3p/theIQPhkf3Tx5kT4D1V7p4HcfQ1FSjpHG9Pu8txxvwSAx92elA3tf5yKF6qqzz0ldW+yhgafgAr18aETFrc6tbZ69ExvwG6IsH76LsTheT5o8tJ/dBATV6rCGv8lJjcSCRcmxnXSCPe6c/Pn7Ej0z/x1P6NNqSJeoiZW8H5Elb/rI2lUwJN6ax4EXDn6veM6wvI6mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBjCjBbFOZuDKP4LFhkbC+xOPUjlujfy5xcuf6iMV2Y=;
 b=F/CqCdr9CplAsB7GkjdnXiKHOZTnkOxdWCQzSZxlIseYW/Oqf8+cg3fDDByCXydUn11gAUy8QJwGQvFAvyxVJxkXhIlY+9CxnHDChXWJPcJrsHyAyBnWrjDH/RIJrCFPIFg671FtRE20GKPjX3L46vgbK5M8/Lz9HmM325AA2cg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by VI0PR04MB11868.eurprd04.prod.outlook.com (2603:10a6:800:31e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 14:37:47 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 14:37:47 +0000
Message-ID: <8d7ff3b6-abb9-4441-8491-99c538ea5f2d@cherry.de>
Date: Fri, 22 May 2026 16:37:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Add support for OpenSSL Provider API
To: Eddie Kovsky <ekovsky@redhat.com>
Cc: Tom Rini <trini@konsulko.com>, Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, Simon Glass
 <sjg@chromium.org>, Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>, a.fatoum@pengutronix.de,
 mark.kettenis@xs4all.nl, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.denx.de
References: <20260429180247.83091-1-ekovsky@redhat.com>
 <482dbc09-e78e-42e7-9915-bdc105652494@cherry.de> <ag-EpjuQlre9QmYN@daedalus>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <ag-EpjuQlre9QmYN@daedalus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::18) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|VI0PR04MB11868:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cad2a65-3302-4b44-ca04-08deb80fb0ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|4133799003|11063799006|5023799004|4143699003|56012099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: DVo+ofr3uek+7HS98BHsOKy3a4sQ1uVelVxf5HLOTGanu492pJ3Rw/D2+twjAzUmOJRjKR0VMcnB6rwdai5X/1+REEO8pMMi8a3BfCRNpP8C1QmVUxkr3aJSonu6griAjRhM5XcMATSi0HqDxtBLH2IaXpQgX8oqCQFPE0OMBZiXFeVAFBExF1LIW97t3cI79LBLZ9DVhYdOuSsAHXbjTrIxMHkwLFGkUjW+0pWt6Z+s33/LDo3lj+fkrqzJbk1biYcSksQ8UotWmA+W8WzbEPg3Wiau3AD+KxQAgGxotwj6XUN9ZngmHbaQbIjKttFYFF5JdztxjrABra0APeuGE/dJTKq+AactwO6LLA1kjwCQr4CI6DGBdL7GcJa2yEqzCprK/T5Xapfkv2L1Nrb8V33/gnutNyXtQYuSppm5ePd7UsQk/9jtxQ7a3rz1wy7MRQUltsWowCUzK3vyJEPNxhYvBsNLNGP0gfg0KSz9qkFUAx/9hy4rwH6Uxw00l7ZZcLeiZPADxfnH76/V3EZJAFWFrVB7vDFj05ZxJtwSLEEefFOYePvrchaoORhqusMG1Atg1QHQl/razTp9M5uEfI3SF3Y2ZdDnXxfPPM58G4uNrNGoMUBX+4ZeJLv+CKUw/OzhdgbWxwDhycF4Eq5+lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(4133799003)(11063799006)(5023799004)(4143699003)(56012099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2tkanlqYVZERnhFTTN6aUtndk92d3RiYy9PT0lIRE1iY2xVU0MzZWJlS0dD?=
 =?utf-8?B?aTBVWjdiMSs1S2ZpY2dEV0NOa0U4T29PaEhTemRUZHk4NSthdmcrM3ZLaVlr?=
 =?utf-8?B?OG85aUY3Y0RBSE5TTlFFZEVKVHB0S1Q1S2JPdkllUXM3UVRmNVBkK3FrdXBm?=
 =?utf-8?B?aWwxdlgwVGhKNVdIRWNkaVZUQi9WeEs0TFQ4V0FMeXQrYVZpdW1iTzNXSUZF?=
 =?utf-8?B?VWtUT3U3RjJVWWFLTjUxOURmVU1FQ2VoREh5QjJlMHVyTkcvVm1kZjcyYUM4?=
 =?utf-8?B?OHFaSmp1MENjeDNHRHZ6ai8rMjJxb1VTc3dTL2dVZ2dRZFpiUU8walUxTnl0?=
 =?utf-8?B?K0NtQUc1OW0yaTlpaWtHelVITjZhVTVBaVFSTTBVL1QrY2JjMXRIa1l4VXFE?=
 =?utf-8?B?RnlHemY2dS8zeWRSOUJzQU9jQlI0TVhFbFI4eDZGSGRjanY4cDB0cE5ab0Rk?=
 =?utf-8?B?TldHYzBJMlRtc09aNTR5TGRyRmg3Zzh6UHFSOUhPK2M1TnF3K3VTRUQ1anVa?=
 =?utf-8?B?ZEpFcDB2NWpoem1maDZlbUNzVkY4eE9LOGRRSHIxQ3RGK0VpTXlGQWh3Q0M2?=
 =?utf-8?B?MGhiL1hVcGRhZGlvYzBScDJ3a3BHWVUxQ0lRZ0YwMm1vRk8rY1JFT0NQY3Nk?=
 =?utf-8?B?d3VtQXNmMjFqb1FHZlZVOHdLMHB2WDBPaTVza2wwZmhFZjJvWHFZcUcvS01Q?=
 =?utf-8?B?bHFTU2piMWNJcUhkUzFpNGFhWnZOOVVVSFF1R2dyMFhVMGRQUDJhN1l6dzNT?=
 =?utf-8?B?SzFmc3kzTWZzRHNCMTZmQzJ2SUc5SzhweHhBaGJlY2pJczBFVzQ2Q2JQaFVH?=
 =?utf-8?B?MkU5a2RGNlgvRjlrY1dXNS9yVFE0c3U0UzdQUTZBSjhjaksvTmNmQXRZaDBw?=
 =?utf-8?B?N1ZCVEZENjVOd0ZKTHJNZ0EySCtGUmhnejIzcUxseGFwTURkaXZVdTBpTTB5?=
 =?utf-8?B?OFdoRGNWYytCL3MvMVFzZGpTQjdhNGhkSVRJWDYwTkwyb3Bkdzl6WklIVGJO?=
 =?utf-8?B?TjVRQlVHNEdvNXFVUllpRHdGOW54a1lKZjlaNFN5bHM3d1g2TmJTYmNPRUg1?=
 =?utf-8?B?NTdHN25ZQlltd2gxMkRCVG5JUlJIUVRxaXdkTlpzRjV3djBvVlVTRHVOSjdm?=
 =?utf-8?B?SkMwTUFWTWl1WCtJekVGa2MxQkN4N1FoWWdRVXcvME1lRC82cGhtQ213Wmdn?=
 =?utf-8?B?SEI0SlI2Ukt3eXhXa2VVeThOUkdlMjFGUFJzRWlxSW10d1BaQnRqUUhnTjdq?=
 =?utf-8?B?VXo3MkplKzRiL28wSFNjekRDdEJBbmpUUFBSVm1XbXVFWU1Qc25Pd1dtdWRh?=
 =?utf-8?B?YzlOeFNVRUg0bFdkYjAwUCtpYk0yYWxPbGo2eE5RREhxOUYwUGJ1bXBrdWEv?=
 =?utf-8?B?YnR4cGF5M2ZlcTZaSFJ6Ujd2UWM5UDVBdlZRbmRBQVkrek5YbFM5ZUxlT0RO?=
 =?utf-8?B?cGlvVVp3M0lncXZma2NpbmhLNWhCdXhZWmtjUDhBQ2pjWHYxcXVmcFpQV0RD?=
 =?utf-8?B?WjREQjJ3QnlUOEdjdUs1b21wWEtSYUJJSzBmaXZlSkRpZUxUWm1ZMFIvTENZ?=
 =?utf-8?B?eEkvZ0tKUmd1dEFTczJXMWxKa2RETm5FMkhpMXJLWTI4aGNGQUdjM2pzVEVF?=
 =?utf-8?B?UE1FRGtZWENITnRCcG1uWHQ3WnZrRVV0T1FmazZlUG10akowQnNSQXJ2Z1Rt?=
 =?utf-8?B?dWxHMzZXSitTL25kazVWM3JWTTJ4TmtJd0NRM0NUNEVwU1NuRXVRZWRCOWNZ?=
 =?utf-8?B?S2lZOUgxRkpselJPa2g5R21uNXpDK2tmOVMxWDFNVm1nK3pLRTE4RTQ0eWxo?=
 =?utf-8?B?T2gwOHlVcUgvZkdReHpZMjJadlA4UUVXNXRoQUY0WHc5dk5uYXk3RGVoRG04?=
 =?utf-8?B?ZThPTEp1STJLQUlVT0ZGVU8yZERhY2w2S2dTd3QvdGxqalpqL0dMMFlFVWRB?=
 =?utf-8?B?WHRtMDRzR00zR1pEQlAxcGs2RjUra201UmZ4VURMN2lIdis5aVdPalBvZEVC?=
 =?utf-8?B?N0VzbUZRdmNBeG5YZHNUOURocGgwdTY0blVjcXpoSlIyQ2NqTXJIbVliOGdW?=
 =?utf-8?B?SjlNYzF6anZtNWVPaS9WWjJ2ZysrQUxXQ1o4ZU56UmNRR0JhWWpYUEdxVDg2?=
 =?utf-8?B?MkRjWUdpbG1PZEsvcVp1Zk5iemYzdDduRDJ2bXNJbHNsNG1NTUoweTdoTXNs?=
 =?utf-8?B?KzBVeVYzMUFGWFFUOXUxbkhXK2JQM29iWnAzd1ZHMExsVzhXUVp1WVkzT2s4?=
 =?utf-8?B?MldVSmNxaFZOeVI0a0tTVXZRRGk4RG4rZmdiR0g4Wk14Nm1VMG5NVmVXSXdy?=
 =?utf-8?B?R3NPNkIwaXdIYU5Ndm80TUlTcHp4Yi9RdFhTd0dnV0NqbDhQZDZiQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cad2a65-3302-4b44-ca04-08deb80fb0ff
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 14:37:46.9141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CNrPgAVJ/fMFqvljWPfDK5lUlLuNDG5FiZcjhA3akmVcIG2Ca78yGLWFx52Qkx/CiH4tEn9HEHG/D4biB6CTtWq7JKg+q5JgcePiXKJ2wHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11868
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

On 5/22/26 12:29 AM, Eddie Kovsky wrote:
> On 05/12/26, Quentin Schulz wrote:
>> Hi Eddie,
>>
>> On 4/29/26 8:02 PM, Eddie Kovsky wrote:
>>> The Engine API has been deprecated since the release of OpenSSL 3.0. End
>>> users have been advised to migrate to the new Provider interface.
>>> Several distributions have already removed support for engines, which is
>>> preventing U-Boot from being compiled in those environments.
>>>
>>> Add support for the Provider API while continuing to support the existing
>>> Engine API on distros shipping older releases of OpenSSL.
>>>
>>> This is based on similar work contributed by Jan Stancek updating Linux
>>> to use the Provider interface.
>>>
>>>       commit 558bdc45dfb2669e1741384a0c80be9c82fa052c
>>>       Author: Jan Stancek <jstancek@redhat.com>
>>>       Date:   Fri Sep 20 19:52:48 2024 +0300
>>>
>>>           sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3
>>>
>>> The changes have been tested with the FIT signature verification vboot
>>> tests on Fedora 42 and Debian 13. All 30 tests pass with both the legacy
>>> Engine library installed and with the Provider API.
>>>
>>
>> But does it actually use a provider or an engine to begin with? I don't see
>> test/py/tests/test_vboot.py calling mkimage with the -N argument. What are
>> the tests (or command) you ran to validate this? I briefly saw the CI failed
>> in v3 because a package was missing, but wasn't it simply because the
>> headers or provider libraries which are now necessary for building
>> lib/rsa/rsa-sign.c were not present? The logs aren't available anymore
>> unfortunately. If that's the case, then that's also an issue. We shouldn't
>> need to install providers if we aren't going to use any? Yes, I know that we
>> currently cannot compile if we don't have openssl-devel-engine (on Fedora),
>> but if we can improve the situation, we should.
>>
>> How did you test (locally is fine) with providers?
>>
> 
> The FIT signature verification tests are documented here:
> 
>      https://docs.u-boot.org/en/latest/usage/fit/signature.html#u-boot-fit-signature-verification
> 
> The tests currently fail in build environments (like Fedora) that don't
> have engine support. This is how we originally became aware of the API
> issue last year.
> 
>      ❯ ./test/py/test.py --bd sandbox --build -k vboot
>      +make O=u-boot/build-sandbox -s sandbox_defconfig
>      +make O=u-boot/build-sandbox -s -j8
>      In file included from tools/generated/lib/aes/aes-encrypt.c:1:
>      ../tools/../lib/aes/aes-encrypt.c:19:10: fatal error: openssl/engine.h: No such file or directory
>      19 | #include <openssl/engine.h>
>          |          ^~~~~~~~~~~~~~~~~~
>      In file included from tools/generated/lib/rsa/rsa-sign.c:1:
>      ../tools/../lib/rsa/rsa-sign.c:22:10: fatal error: openssl/engine.h: No such file or directory
>      22 | #include <openssl/engine.h>
>          |          ^~~~~~~~~~~~~~~~~~
>      compilation terminated.
> 
> Github provides the Azure CI pipeline as a free service. I wouldn't
> expect them to retain logs at that tier.
> 

As said, I don't think we are testing OpenSSL providers in test/py. 
rsa-sign.c and aes-encrypt.c can work perfectly fine without using 
engines, but currently it requires the engine.h header file to compile 
(and if missing, then the functions, macros, constants defined in that 
header file will need to be compiled out like done in this patch) even 
if it doesn't use engines at runtime.

The issue is not that OpenSSL is built without engine support, it's 
rather that Fedora has decided to stop shipping openssl/engine.h by 
default. For some reason, they still compile OpenSSL with engine support 
(I don't understand why). You are fixing a build issue, sure, and we 
must fix it, but I don't think this patch is doing it the proper way. So 
I am asking again, did you test with an actual OpenSSL provider (and no, 
the implicit file: scheme "provider" doesn't count)?

See 
https://lore.kernel.org/u-boot/d8b15735-0b3f-4a72-a2a2-9ac6e12f4dbf@cherry.de/T/#m7454283f474aaee33736e1ae7154569da846f14a

> 
>>> Tested-by Enric Balletbo i Serra <eballetb@redhat.com>
>>> Tested-by Mark Kettenis <mark.kettenis@xs4all.nl>
>>
>> Please do not forget to add the colon after Tested-by so it actually makes
>> it a git trailer instead of just text.
>>
> 
> That's an unlucky typo because I added the trailers manually.
> 

It happens :)

For your info, with b4 
(https://b4.docs.kernel.org/en/latest/contributor/overview.html) you can 
run b4 trailers -u (if you started the series with b4, though you can 
probably create a new branch from an existing series with b4 prep 
--from-thread?) and it'll automatically fetch the trailers from answers 
on the ML and add them to the appropriate patches.

>>> Signed-off-by: Eddie Kovsky <ekovsky@redhat.com>
>>> ---
>>> Changes in v4:
>>> - Add comment that @engine pointer is null when using pkcs11 provider
>>> - Remove extra line break
>>> - Add pkcs11-provider package to build dependencies
>>> v3: https://lore.kernel.org/u-boot/20260120164524.253188-1-ekovsky@redhat.com/
>>>
>>> Changes in v3:
>>> - Removed Kconfig option
>>> - Changed macro symbol from CONFIG_OPENSSL_NO_DEPRECATED to
>>>       USE_PKCS11_PROVIDER or USE_PKCS11_ENGINE
>>> v2: https://lore.kernel.org/u-boot/20251027195834.71109-1-ekovsky@redhat.com/
>>>
>>> Changes in v2:
>>> - Remove default for new Kconfig option
>>> - Use #ifdef instead of IS_ENABLED macro
>>> - Remove comment after #endif
>>> - Remove unrelated checkpatch cleanup of 'sslErr' variable name
>>> v1: https://lore.kernel.org/u-boot/20251017171329.255689-1-ekovsky@redhat.com/
>>> ---
>>>    doc/build/gcc.rst       |   4 +-
>>>    lib/aes/aes-encrypt.c   |   4 +-
>>>    lib/rsa/rsa-sign.c      | 102 ++++++++++++++++++++++++++++++++++++++--
>>>    tools/docker/Dockerfile |   1 +
>>>    4 files changed, 103 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/doc/build/gcc.rst b/doc/build/gcc.rst
>>> index 1fef718ceecb..29a6a632e7e3 100644
>>> --- a/doc/build/gcc.rst
>>> +++ b/doc/build/gcc.rst
>>> @@ -25,8 +25,8 @@ Depending on the build targets further packages maybe needed
>>>        sudo apt-get install bc bison build-essential coccinelle \
>>>          device-tree-compiler dfu-util efitools flex gdisk graphviz imagemagick \
>>> -      libgnutls28-dev libguestfs-tools libncurses-dev \
>>> -      libpython3-dev libsdl2-dev libssl-dev lz4 lzma lzma-alone openssl \
>>> +      libgnutls28-dev libguestfs-tools libncurses-dev libpython3-dev \
>>> +      libsdl2-dev libssl-dev lz4 lzma lzma-alone openssl pkcs11-provider \
>>>          pkg-config python3 python3-asteval python3-coverage python3-filelock \
>>>          python3-pkg-resources python3-pycryptodome python3-pyelftools \
>>>          python3-pytest python3-pytest-xdist python3-sphinxcontrib.apidoc \
>>> diff --git a/lib/aes/aes-encrypt.c b/lib/aes/aes-encrypt.c
>>> index 90e1407b4f09..4fc4ce232478 100644
>>> --- a/lib/aes/aes-encrypt.c
>>> +++ b/lib/aes/aes-encrypt.c
>>> @@ -16,7 +16,9 @@
>>>    #include <openssl/err.h>
>>>    #include <openssl/ssl.h>
>>>    #include <openssl/evp.h>
>>> -#include <openssl/engine.h>
>>> +#if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DEPRECATED_3_0)
>>> +# include <openssl/engine.h>
>>> +#endif
>>
>> Considering there are no other changes in this file, is this include
>> actually needed?
>>
> 
> The header is still needed to maintain backward compatibility for engine
> support. I maintained the #ifdef style to be consistent with its usage
> elsewhere, based on previous feedback.
> 

What am I trying to say here is no symbol in the file comes from 
openssl/engine.h and I can compile the file perfectly fine without this 
header included, so we should probably get rid of this include.

>>>    #include <uboot_aes.h>
>>>    #if OPENSSL_VERSION_NUMBER >= 0x10000000L
>>> diff --git a/lib/rsa/rsa-sign.c b/lib/rsa/rsa-sign.c
>>> index 0e38c9e802fd..f456f3c58e65 100644
>>> --- a/lib/rsa/rsa-sign.c
>>> +++ b/lib/rsa/rsa-sign.c
>>> @@ -19,7 +19,47 @@
>>>    #include <openssl/err.h>
>>>    #include <openssl/ssl.h>
>>>    #include <openssl/evp.h>
>>> -#include <openssl/engine.h>
>>> +#if OPENSSL_VERSION_MAJOR >= 3
>>> +# define USE_PKCS11_PROVIDER
>>> +# include <err.h>
>>> +# include <openssl/provider.h>
>>> +# include <openssl/store.h>
>>> +#else
>>> +# if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DEPRECATED_3_0)
>>> +#  define USE_PKCS11_ENGINE
>>> +#  include <openssl/engine.h>
>>> +# endif
>>> +#endif
>>> +
>>
>> Sorry but that's a NACK.
>>
>> As far as I can tell, this effectively disables using engines when your host
>> openssl version is 3.0+, which we currently support (and I currently use
>> it). You can have this for 4.0+ as engine support has been removed, but not
>> for 3.x.
>>
> 
> You don't get a choice here. OpenSSL deprecated the Engine API starting

Providers and engines can cohabit in OpenSSL 3.x, so that is possible (I 
tested it locally with the binman test suite, with both providers and 
engines local test suites working with the same OpenSSL version (Fedora 
44 + openssl-devel-engine).

> with Version 3.0, and removed it completely starting with Version 4.0.
> If the environment you're building U-Boot in has a recent version of
> OpenSSL then Engines are no longer available to you.
> 

This only happens because Fedora (and not Debian, or ArchLinux) decided 
to stop shipping an engine.h header file (while still compiling OpenSSL 
with engine support).

I can use engines with OpenSSL 3.x, with the current state in U-Boot, so 
you cannot unilaterally decide to break that.

What you can do is either remove support for OpenSSL engines entirely 
when it's factually not possible to build mkimage with support for it 
(and no, checking for OpenSSL 3.x is not enough). That is, when OpenSSL 
is built/shipped without engine support (that is, for Fedora, unless 
openssl-devel-engine is installed). Or migrate engine support to use the 
provider API (by e.g. prepending org.openssl.engine: in the OSSL_STORE 
scheme) for OpenSSL 3.x. The user API must be identical though, what 
works with engines on OpenSSL 1.x an OpenSSL 3.x with engine support via 
the provider API must be the same. I would suggest to NOT go for the 
second option as I don't think it's worth the added complexity.

>>> +#ifdef USE_PKCS11_PROVIDER
>>> +#define ERR(cond, fmt, ...)				\
>>> +	do {						\
>>> +		bool __cond = (cond);			\
>>> +		drain_openssl_errors(__LINE__, 0);	\
>>> +		if (__cond) {				\
>>> +			errx(1, fmt, ## __VA_ARGS__);	\
>>> +		}					\
>>> +	} while (0)
>>> +
>>
>> Is this really related to the PKCS11 provider? I think there's a mix between
>> "using the provider API" and "using the pkcs11 provider".
>>
> 
> It's a helper macro used for the Provider path when OpenSSL is v3 or
> later.
> 

I'm arguing about the macro being called USE_PKCS11_PROVIDER while 
having nothing to do with pkcs11. It's misleading.

>>> +static void drain_openssl_errors(int l, int silent)
>>> +{
>>> +	const char *file;
>>> +	char buf[120];
>>> +	int e, line;
>>> +
>>> +	if (ERR_peek_error() == 0)
>>> +		return;
>>> +	if (!silent)
>>> +		fprintf(stderr, "At main.c:%d:\n", l);
>>> +
>>
>> main.c?
>>
> 
> Not clear what you are referring to here.
> 

The error message would state "At main.c:" which is absolutely not 
related to any file this is called from. I guess maybe you want __FILE__ 
here instead?

>>> +	while ((e = ERR_peek_error_line(&file, &line))) {
>>> +		ERR_error_string(e, buf);
>>> +		if (!silent)
>>> +			fprintf(stderr, "- SSL %s: %s:%d\n", buf, file, line);
>>> +		ERR_get_error();
>>> +	}
>>> +}
>>> +#endif
>>>    static int rsa_err(const char *msg)
>>>    {
>>> @@ -94,10 +134,11 @@ err_cert:
>>>     *
>>>     * @keydir:	Key prefix
>>>     * @name	Name of key
>>> - * @engine	Engine to use
>>> + * @engine	Engine to use or NULL when using pkcs11 provider
>>>     * @evpp	Returns EVP_PKEY object, or NULL on failure
>>>     * Return: 0 if ok, -ve on error (in which case *evpp will be set to NULL)
>>>     */
>>> +#ifdef USE_PKCS11_ENGINE
>>>    static int rsa_engine_get_pub_key(const char *keydir, const char *name,
>>>    				  ENGINE *engine, EVP_PKEY **evpp)
>>>    {
>>> @@ -157,21 +198,24 @@ static int rsa_engine_get_pub_key(const char *keydir, const char *name,
>>>    	return 0;
>>>    }
>>> +#endif
>>>    /**
>>>     * rsa_get_pub_key() - read a public key
>>>     *
>>>     * @keydir:	Directory containing the key (PEM file) or key prefix (engine)
>>>     * @name	Name of key file (will have a .crt extension)
>>> - * @engine	Engine to use
>>> + * @engine	Engine to use or NULL when using pkcs11 provider
>>>     * @evpp	Returns EVP_PKEY object, or NULL on failure
>>>     * Return: 0 if ok, -ve on error (in which case *evpp will be set to NULL)
>>>     */
>>>    static int rsa_get_pub_key(const char *keydir, const char *name,
>>>    			   ENGINE *engine, EVP_PKEY **evpp)
>>>    {
>>> +#ifdef USE_PKCS11_ENGINE
>>>    	if (engine)
>>>    		return rsa_engine_get_pub_key(keydir, name, engine, evpp);
>>> +#endif
>>
>> We should probably at least print something when engines aren't supported
>> but the engine parameter is passed, or maybe even fail as that's an
>> incorrect configuration.
>>
> 
> We discussed this in a previous revision and decided the comment was
> sufficient. The correct path will be taken depending on which version of
> the API is available.
> 

mkimage will still happily accept the -N argument which sets the engine 
parameter, even if engines aren't supported.

I think if you have a file key with the same name as in the engine, 
you'll then sign with the wrong key.

Think

mkimage -N myengine -g key

and you have a key.key in the local directory. If you compile with 
OpenSSL engines supported, you'll essentially use myengine:key, if not, 
you'll use key.key, without mkimage even notifying you by using the same 
command.

>>>    	return rsa_pem_get_pub_key(keydir, name, evpp);
>>>    }
>>> @@ -207,13 +251,44 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
>>>    		return -ENOENT;
>>>    	}
>>> +#ifdef USE_PKCS11_PROVIDER
>>> +	EVP_PKEY *private_key = NULL;
>>> +	OSSL_STORE_CTX *store;
>>> +
>>> +	if (!OSSL_PROVIDER_try_load(NULL, "pkcs11", true))
>>> +		ERR(1, "OSSL_PROVIDER_try_load(pkcs11)");
>>> +	if (!OSSL_PROVIDER_try_load(NULL, "default", true))
>>> +		ERR(1, "OSSL_PROVIDER_try_load(default)");
>>> +
>>
>> Why are we unconditionally loading providers and specifically the pkcs11
>> one? As far as I could tell we should know from the URI whether a key from a
>> provider is requested by checking if a colon is in the URI. And we can
>> automatically load the requested provider based on that?
>>
>> Otherwise the easiest answer to this could simply be: "let the user
>> configure this externally via OPENSSL_CONF environment variable".
>>
>> Do we also need to update tools/mkimage.c (and doc/mkimage.1) to remove -N
>> engine from usage if the tool doesn't support it? Do we also need to update
>> doc/usage/fit/signature.rst to explain how to use pkcs11 provider?
>>
>> FYI, we (my employer) are migrating from engines to providers for signing
>> FIT images with binman so I'm starting to have a look on how to do this now.
>>
>> Cheers,
>> Quentin
>>
> 
> Additional changes may be needed down the road. I'm sure additional
> patches will be welcome. The scope of this change is to introduce
> support for the new API while continuing to support developers who are
> still building in environments using the deprecated Engine API.
> 

But it's not doing that? This is removing support for OpenSSL engines on 
all systems shipping OpenSSL 3.x? We cannot accept patches that break 
things under the pretense there can be follow-up patches. I'm not asking 
support for signing with OpenSSL providers in this series, I'm asking 
you to not break existing users.

I'm still unsure what the goal of this patch is. It says it adds support 
for OpenSSL provider API but I don't think provider support was actually 
tested. It also says U-Boot cannot be built on Fedora anymore due to 
engine.h missing. Both can be be separate topics. The urgent task is to 
fix building on Fedora, supporting providers can then be tackled later 
on (by either you, or someone else; e.g. I already have support for 
providers locally, just need to write nice commit logs and wait on what 
this patch will become here). I commented out everything related to 
engines and ran the testSignSimple, testSignExactFIT, testSignNonFit, 
testSignMissingMkimage and testSplPubkeyDtb to check whether using keys 
was still supported (meaning, we aren't forced to migrate to the 
OSSL_STORE interface for simple keys).

I'd be fine with guarding all engine support with
if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DEPRECATED_3_0)
and making sure we at least warn (or fail) if an engine is asked by the 
user but we don't support it, so that you can build on Fedora again 
without openssl-devel-engine.

Cheers,
Quentin
