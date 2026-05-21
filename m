Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2F5CD5BAC
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 17:45:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7805184713;
	Thu, 21 May 2026 19:45:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="iro65bxh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DFD6847C8; Thu, 21 May 2026 19:45:22 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 632D4846FA
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 19:45:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bn4ZgVvdgYPBh8QP4m0juuVIGgIVCG8fm/qs/AOe9pC8J5Ukg1Qj5054Tp+INgHP2n+q9+QSIQf4HEEsd5ZxOUYqNzELOBjUHydTa6Q1CQpkTgRmcDRfxY+mtwJRUPrMtNeTgzUXdH8LyRcW5WziNoPZe+ZZK3Dcl8b7lwto3BZtdZESKa4RMyg7034kXWlz3PVevMuIcf+LzT76mDDx3rooYuKrIGscljztLYwBruoZNEY77INGYJ+jQqWXeOcA2zoRT4S6Fghjwh5Wlq34sOxIFvSZcztQtXkOz84eb9tAyoOSTdKPoU8IrW1HyTkzgEVHbDpLq2C4I21DSc0QXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqNDSAczAFWF+RUXF3V/1XDfX6ncBUWALgHW5oaZjX4=;
 b=bha8gt5MYesiWgTSTA4dAOt0YjlFiAOIVUwpbPGOuQkcYma6g9K7T9P+KGLxqy+fDHlDD+FYdt1yrU4SjcvobRGETk8fv4NxbFeGq0HlHyRE37bXoxHEPTEja4mDwI4Q18QHr1w48TfyWeX+6ONx8abQcQm6ZQ7Q9FPiamXanXFryRpbBxfVjJKXUfPd+sbXvL09v0W3i0k2XIx7lnCz14SFdne+RZRASKHKdakgvjpoJq5tpVfNx3ZHEj8e4yGEoFyEEjsS2JtqUn9wGoWqvEWP5ZI5LW0aWYKanxb4rqaCR9vRDAeMTvRq0AGY20X578qF08BrAxG+NCU/mQw2ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqNDSAczAFWF+RUXF3V/1XDfX6ncBUWALgHW5oaZjX4=;
 b=iro65bxhyH3Y0HplIcv5GUCUBtv/fparbzWnV+hH+lJAAE8gTlUrTlVWGFBg0ZL7e6tc3/D7hOYw9M+/X6KH8fah3mVbZpZ/hVfTiPjPpjiX4c5VRjxwMTWBZ+ZUoaO2jmY/hVbxKb8jChfqMraYg0H5OCw8QoOP8XoGgEcDDng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM0PR04MB7140.eurprd04.prod.outlook.com (2603:10a6:208:192::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 17:45:16 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 17:45:16 +0000
Message-ID: <d8b15735-0b3f-4a72-a2a2-9ac6e12f4dbf@cherry.de>
Date: Thu, 21 May 2026 19:45:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Add support for OpenSSL Provider API
To: Eddie Kovsky <ekovsky@redhat.com>
Cc: Tom Rini <trini@konsulko.com>, Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, Simon Glass
 <sjg@chromium.org>, Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>, a.fatoum@pengutronix.de,
 mark.kettenis@xs4all.nl, u-boot@lists.denx.de
References: <20251027195834.71109-1-ekovsky@redhat.com>
 <c2b48b27-9d4e-4be8-b94a-4aac7ef922a8@cherry.de> <aSCsgniomRMN0u1m@daedalus>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <aSCsgniomRMN0u1m@daedalus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI6PEPF00000222.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8f8) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM0PR04MB7140:EE_
X-MS-Office365-Filtering-Correlation-Id: 2918df2e-a831-4f95-3270-08deb760b771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|6133799003|11063799006|4143699003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: qSDSA5j/kOsqgiQzKQiAnhMqL7202orj3DEwjCpH7oUgC18nDPJFiec+Mslh1OEcJ72oOHUFO+oNZNQyx00/eQVaMDRxO/s7YNNZNP97fAXiFyndzhCLVXCC0iq30yW8GV2ae+HAwWmTvWyU6xZSmm9NwkXzgTs+0XNh/Bw5SyHhU6RUtxISoR0Y3PGEpe8aCFiEwhOLJm0T19ld2Cb7dw6YKmqnKqaOpsb7ycNjOFQJ4Mhh3Ck3rdfSJZ8LFM80MLGxEUZvFPODsNDmngENAW3xcG8YKseYknBKwLpPZhm1ctdomd6ExHzh1OylyJsSZl/8sVvRNFdIBoB0h1QE9DFtdCB52u6FR81YXtT4pmBuaH0ieY0+4F9j6FOm5N6cordlHfkFFMiLSXYZ1HoE+iMYSX6P6CWP2Tfz2Yxcjc4qoZ9WCVOdTpqfXDT0Dc7ijKSYOP3TnP4Pz/0C45eHLsK+1CtBKpi6b9NLVxoWoRoT7NNM7dMJZ8+b219yC6uYZVxejJJrevcL8D5j6JIsh/lwYSe+1JoS3m5dLe3ud9nDGFgYhych/2wSRXNvVrnpB4a8B9kPqbVUGoAme07oAiE50zpRFGZrmT5IRn3vtDZ745vFfNAGQ7eosQBbmgrgf6kD947QEgyBYs7m/Vdr/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(6133799003)(11063799006)(4143699003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUNBREFrN1hkVDI3cEpodDIzRlczUm1DZWlLRHZEU3BOOVJZSmY3K2MvY0Ey?=
 =?utf-8?B?R1FPU3JGMWhYNTBmL1Jyc3huTnFTRTJWUmRTdHRZRVdFQ0ZvVFZjbXZ4VFp3?=
 =?utf-8?B?UkNRcHljUktZd1RtR3Rjd1dyUmhNZzZNdHpTcVNidjYzazZQbUs2czg4enlz?=
 =?utf-8?B?bjRSaWJxM2I5L3ZOczJDTm9lVUZnbjN6V3RneTN2SjBvMFdXeFYyK2JJaDZq?=
 =?utf-8?B?WWRNcWJMV0F0M3Q5QzU5WW1GTHNRQlh1ZGloY3dzZXRQVk9zeUlndUw1RVlq?=
 =?utf-8?B?alhTUGJYejF2QzAyVEpmUFdwMlRtZ0NHcEsxRkN2QklubE0yOXlhYlpWTWVY?=
 =?utf-8?B?bk93d21XZXJkT2hsWmI2cHg0NVBDVVJNMXNhdnZwWjlaMXFReDhsZDBiem9D?=
 =?utf-8?B?UURHRm9TLzhXWU5hWTdRRFVRMExyZkMyOVdyK2Z5aC9KNFNORjlObHcxSXFI?=
 =?utf-8?B?TFRaRWx3THVWWDJ2VFVjN0RKYmxVSWcxR2FQYk1zRVk5WU4zdHN5WmtEM2pX?=
 =?utf-8?B?NEs2VmFZdlA4eDAycC9KTjNMWG9xTmhBdTVRQ2RJaFMzRG00dXliSERFT3BU?=
 =?utf-8?B?ZEV2NEorN0pFT1BTZG5FSnc1bEx2SXFMcUxkQ2xCS25kVWx6KzZBZGgxdGpl?=
 =?utf-8?B?RjJienhKNGFrOU1tMzJiOG1ZZEJvdk5VdDVkZHpPZUc1L0xpMVlPMTBjNTEz?=
 =?utf-8?B?eitZRWVMUEY4SFg4NmROblNNV0p0ZnA3QXFvbWhsOW9yVG9GcHc3NWExMlhD?=
 =?utf-8?B?M3gxZVNURG5ydzM1d3pUMVRjNHNBM01wb1dTdFp0Q2srbW83WWFFc0w4Zlpr?=
 =?utf-8?B?cUhIaDFsNGNiTGp0NTVFaVZqSjZvbnBSYzRCak9BRkt6VmdQNDUzMTd4NXRN?=
 =?utf-8?B?VTVlNElXNHN6V3ZtYnBTS3IwTWNUcWFyZHk5QzVCUEdIekdiR2tkK2lzaEVZ?=
 =?utf-8?B?dVY2UWdKbEZnekJNVHBFaWxudEl4UDFRdVEzVVNDZFpOOXltbHp2ZWEvbm83?=
 =?utf-8?B?UDROajZKbFF4Z00rTFdLRVBvL2R0dHBCN3ZLYkdscys0ODBPck5wNWlaaXA0?=
 =?utf-8?B?TkJkVmFBYkhQcWpqR1JOUDdRL1RLK05VUG5KSmcyZ2RYRkZLbHJsaEp6REM1?=
 =?utf-8?B?RDZpMllzRGlzL2Q5UHNLSFZ5M0FiS25OM3lHYTh5RDhFdDY3TStUdTNDRWRy?=
 =?utf-8?B?ekpFQ0Fodmh0Ukg5NGYzajROQTFHcjRQWVJIeXBzYkdaY2FWdjFVaGorVmVv?=
 =?utf-8?B?OHQ3dlVlU01jemcyOVNpNlZpTVEyUnZQRFpCdkhCOGtKUmRJMlZIT3ZLZG5q?=
 =?utf-8?B?ZElTZnpsM2tNUlBBYmIzeFUxcFVaZlFUSTNrQ2owVCs1ZHZQcnBET2xraExt?=
 =?utf-8?B?NmQyeFpIZzMyM3FQSHlldEpSRXdUVldVcmpGaDkxRkNGRnVRY1ZDMzQ4SFJh?=
 =?utf-8?B?RnNlR09FbjZlSm8zMnpHSXp0UzlDUlBtc0pHR3RZbG8yNDNxMU1CazhtcFI2?=
 =?utf-8?B?eGNVVWR6LzhWYkdidXpUUWtFMnlzMnJ4d2Uyb01lNmxPODhWYjByL2FBNXk2?=
 =?utf-8?B?T25JYjR6T1BValE0MEFrZko3VUxodUdMZ1VhK0xMQ00zUHR6TmptcG93TjNj?=
 =?utf-8?B?UnAvMXhwaWpQYmtqZVV2TDRvSGZKUWw0d25IZHU4cTlBNWtndjFQdnBIdlpP?=
 =?utf-8?B?R0xQMzNXTGlyREJsSmZPMy96NndDM0VvWUZrbnRYOWF1WllrWkV4U0hGTXhl?=
 =?utf-8?B?Nmt6eHh5YjBBdDBiM3YwS0g0NEE3Q2htTUNvSy8xZnVUL0FtallabUpTVnRa?=
 =?utf-8?B?Y0VtOStZelEzNVV2U2xJZkVvUEdORnRCSW9PeC9qMVl6ZDc5a2Y4MnkwZ256?=
 =?utf-8?B?NlZZUDMyWEd2SWhUTmUzNTJKWTVGR25oTkNYN2dsTmZLdVl1WVl3UCt1WjV6?=
 =?utf-8?B?bnRhWG1vRU14TnZqRGNjYmJORnBEd0kxMDduTWFMekRpRFFueDgzMHhHSHJY?=
 =?utf-8?B?bWhzUmpXSFg5eWxzVElnTnc2eUUweThyQTVmNVZSVStuSXcvTVUzU2xXY0x2?=
 =?utf-8?B?MFRsTkNmOWpHY2VOZHplbStqbkFvVmtKVFFqOUd6dUxmZ3BsZ21FOU1IQlNo?=
 =?utf-8?B?ZktPaWFDSVM4a3ArMmFqSGFadmlwa0tKanBZdzVoSTZrVkdJKzg4b3Rxa05T?=
 =?utf-8?B?MTc1U016Z3VLRktSQkVvNDZEUkxsNHBLR1JlSzVxdEtyMDJyR1IzVHJmNmxi?=
 =?utf-8?B?ODhIT2UwMUpNZFRZa01LR2dPejBiQmgzT0I2N2ljMER0eEN2ZGdSQ0VBYmt5?=
 =?utf-8?B?WVJqME1IaG9aVmx5a0duVytXSHBMNFRFRU9SRGVxNmhDaXFhZ3hLdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2918df2e-a831-4f95-3270-08deb760b771
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 17:45:15.9312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HkRTvtHLz6g/COZznlVA8iQmsvYAvIfvpq6YwSDKJG5M15XxrbSB70VNo5dra2nMU+R4jPXlvhicegwKB7pW+dgtN1IrgSOe1a02sQgGdwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7140
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

I'm only a couple of months late to the party :)

On 11/21/25 7:16 PM, Eddie Kovsky wrote:
> Hi Quentin
> 
> On 11/17/25, Quentin Schulz wrote:
>> Hi Eddie,
>>
>> On 10/27/25 8:58 PM, Eddie Kovsky wrote:
>>> [You don't often get email from ekovsky@redhat.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> The Engine API has been deprecated since the release of OpenSSL 3.0. End
>>> users have been advised to migrate to the new Provider interface.
>>> Several distributions have already removed support for engines, which is
>>> preventing U-Boot from being compiled in those environments.
>>>
>>
>> Which ones? How do I reproduce?
>>
> 
> As you are probably aware, OpenSSL deprecated the Engine API with the
> 3.0 release, and engines are likely to be removed entirely when
> OpenSSL 4.0 is released in 2026. [1][2]
> 
> [1] https://docs.openssl.org/3.0/man7/migration_guide/#engines-and-method-apis
> [2] https://github.com/openssl/openssl/discussions/21832
> 
> I don't have a comprehensive list of all distros. Fedora, RHEL 10,
> Arch, and Debian 13 are all shipping OpenSSL 3.5. If you try to build
> U-Boot in those environments the compiler will not be able to resolve the
> engine API symbols and the build will fail.
> 

That does not seem to be true.

host$ podman run -it --rm --security-opt label=disable --userns keep-id 
-w $PWD -v $PWD:$PWD docker.io/debian:trixie
host$ podman exec -it --user root --latest apt-get --update install -y 
build-essential make bison flex bc rsync kmod cpio libssl-dev 
gcc-aarch64-linux-gnu debhelper ncurses-dev python3-pyelftools 
python3-setuptools swig python3-dev
container$ touch bl31.elf
container$ export BL31.elf
container$ make CROSS_COMPILE="aarch64-linux-gnu-" O=build/ringneck 
ringneck-px30_defconfig
container$ make CROSS_COMPILE="aarch64-linux-gnu-" O=build/ringneck 
-j`nproc`

You can then see that 
./build/ringneck/tools/generated/lib/rsa/rsa-sign.o is built.

host$ podman run -it --rm --security-opt label=disable --userns keep-id 
-w $PWD -v $PWD:$PWD docker.io/archlinux/archlinux:latest
host$ podman exec -it --user root --latest pacman -Sy openssl swig 
python python-setuptools make gcc bison flex bc rsync kmod cpio 
python-pyelftools aarch64-linux-gnu-gcc
container$ touch bl31.elf
container$ export BL31.elf
container$ make CROSS_COMPILE="aarch64-linux-gnu-" O=build/ringneck 
ringneck-px30_defconfig
container$ make CROSS_COMPILE="aarch64-linux-gnu-" O=build/ringneck 
-j`nproc`

You can then see that 
./build/ringneck/tools/generated/lib/rsa/rsa-sign.o is built.

I'm also pretty sure OpenSSL is built with engine support in Fedora even 
without openssl-devel-engine since I could run the binman test suite 
using the openssl pkcs11 engine in Fedora without that package.

Some OpenSSL engines are available in the official package feeds:

$ dnf provides '/usr/lib64/engines-3/*'
Updating and loading repositories:
Repositories loaded.
openssl-libs-1:3.5.5-2.fc44.x86_64 : A general purpose cryptography 
library with TLS implementation
Repo         : @System
Matched From :
Filename     : /usr/lib64/engines-3/afalg.so
Filename     : /usr/lib64/engines-3/capi.so
Filename     : /usr/lib64/engines-3/loader_attic.so
Filename     : /usr/lib64/engines-3/padlock.so

openssl-pkcs11-0.4.13-4.fc44.x86_64 : A PKCS#11 engine for use with OpenSSL
Repo         : @System
Matched From :
Filename     : /usr/lib64/engines-3/libpkcs11.so
Filename     : /usr/lib64/engines-3/pkcs11.so

openssl-gost-engine-3.0.3-11.fc44.x86_64 : A reference implementation of 
the Russian GOST crypto algorithms for OpenSSL
Repo         : fedora
Matched From :
Filename     : /usr/lib64/engines-3/README.gost
Filename     : /usr/lib64/engines-3/gost.so

openssl-libs-1:3.5.5-1.fc44.x86_64 : A general purpose cryptography 
library with TLS implementation
Repo         : fedora
Matched From :
Filename     : /usr/lib64/engines-3/afalg.so
Filename     : /usr/lib64/engines-3/capi.so
Filename     : /usr/lib64/engines-3/loader_attic.so
Filename     : /usr/lib64/engines-3/padlock.so

openssl-pkcs11-0.4.13-4.fc44.x86_64 : A PKCS#11 engine for use with OpenSSL
Repo         : fedora
Matched From :
Filename     : /usr/lib64/engines-3/libpkcs11.so
Filename     : /usr/lib64/engines-3/pkcs11.so

p11-remote-0.3-23.fc44.x86_64 : Remoting of PKCS#11 modules across sessions
Repo         : fedora
Matched From :
Filename     : /usr/lib64/engines-3/libp11-kit-engine.so

tpm2-tss-engine-1.2.0-9.fc44.x86_64 : OpenSSL Engine for TPM2 devices 
using the tpm2-tss software stack
Repo         : fedora
Matched From :
Filename     : /usr/lib64/engines-3/libtpm2tss.so
Filename     : /usr/lib64/engines-3/tpm2tss.so

openssl-libs-1:3.5.5-2.fc44.x86_64 : A general purpose cryptography 
library with TLS implementation
Repo         : updates
Matched From :
Filename     : /usr/lib64/engines-3/afalg.so
Filename     : /usr/lib64/engines-3/capi.so
Filename     : /usr/lib64/engines-3/loader_attic.so
Filename     : /usr/lib64/engines-3/padlock.so

$ openssl engine dynamic -c pkcs11
(dynamic) Dynamic engine loading support
(pkcs11) pkcs11 engine

So it seems the only thing Fedora (and RHEL and other Red Hat distros I 
guess) is doing is moving openssl/engine.h (and a few others) to a 
different package.

Note that Fedora modifies /usr/include/openssl/configuration-x86_64.h to add

# if !__has_include(<openssl/engine.h>) && !defined(OPENSSL_NO_ENGINE)
#  define OPENSSL_NO_ENGINE
# endif

which is kinda odd since technically, OpenSSL is built with engine 
support, regardless of openssl/engine.h presence on your system. It does 
however prevent you from building a new engine. I'm honestly not sure 
what the intent is by moving this to a separate package? Fail everybody 
but provide a fallback until OpenSSL 4.x is packaged where the fallback 
won't be available anymore?

Note that OpenSSL 4.x still ships an engine.h, although with stubs (if 
OPENSSL_ENGINE_STUBS is defined).

> Fedora is currently providing a bridge package openssl-devel-engine [3] to
> help make the API transition easier, but that is only a temporary
> solution. (I think Debian is currently doing something similar.)
> 

Considering Debian happily compiles rsa-sign.o as well as the dummy RSA 
engine in tools/binman/test/fit with

gcc -lcrypto -lssl dummy-rsa-engine.c -fPIC -shared -o dummy-rsa-engine.so

I'm not sure that's true, do you have a source for that?

> [3] https://packages.fedoraproject.org/pkgs/openssl/openssl-devel-engine/
> 
>>> The Kconfig option OPENSSL_NO_DEPRECATED introduces support for the
>>
>> Please consider renaming this, OpenSSL itself uses OPENSSL_NO_DEPRECATED
>> constants for many things. I would recommend simply renaming to
>> OPENSSL_NO_ENGINE which is also the symbol OpenSSL is using. If there comes
>> a time we have more OPENSSL_NO_ options, we can always have a "virtual"
>> symbol called OPENSSL_NO_DEPRECATED which would select them all if one
>> wanted for example.
>>
> 
> I did give some thought to using a different name because I don't
> like the double negative that comes from this construct:
> 
>      #ifndef CONFIG_OPENSSL_NO_DEPRECATED
> 
> But I kept it because the name is advantageous precisely because it's
> already recognized by the OpenSSL API. OPENSSL_NO_DEPRECATED is a
> user-defined macro.[4] When combined with the OPENSSL_API_COMPAT macro,
> which is already defined in lib/rsa/rsa-sign.c, we can ensure that
> deprecated symbols won't be available in sections where
> OPENSSL_NO_DEPRECATED is defined.
> 
> [4] https://docs.openssl.org/3.0/man7/openssl_user_macros/
> 
>>> Provider API while continuing to use the existing Engine API on distros
>>> shipping older releases of OpenSSL.
>>>
>>
>> One can use org.openssl.engine: as prefix for provider arguments when one
>> wants to use an engine still.
>>
> 
> Sorry, but it's not clear what you are referring to here.
> 

I meant to say one can still use engines without using the engine API 
explicitly, by using org.openssl.engine:<engine>: scheme in 
OSSL_STORE_open() for example or when a key is requested on the openssl CLI.

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
>> Are there actually tests using an OpenSSL engine? Because otherwise it's
>> simply checking that local keys are still working... which isn't that much
>> different from what we currently have with engines when not using engines.
>>
>> I'm implementing FIT images signing with OpenSSL engines, and it'd be nice
>> if we could have something that doesn't require changes to support providers
>> (or if it does, not in a confusing manner for example).
>>
>> https://lore.kernel.org/u-boot/20251031-binman-engine-v1-0-c13c1b5dac43@cherry.de/T/#t
>> for the v1, I'll soon (next hours or tomorrow) post a v2 and Cc you if you
>> don't mind.
>>
>> [...]
>>
> 
> As mentioned above, the motivation for this patch is that the Engine
> API has already been deprecated. Projects that depend on OpenSSL will
> need to move to the new Provider API in order to continue to function.
> 

Yes. At the same time, OpenSSL 3.5 is supported until April 2030 so 
until we are a few years after that, we'll probably still need to 
support engines.

> The FIT Signature Verification tests I used to exercise both APIs are
> documented here.[5]
> 
> [5] https://docs.u-boot.org/en/latest/usage/fit/signature.html#u-boot-fit-signature-verification
> 

Did you follow 
https://docs.u-boot.org/en/latest/usage/fit/signature.html#hardware-signing-with-pkcs-11-or-with-hsm 
which I believe is the only section which uses an engine? Specifically, 
the last code snippet "Sign the fitImage with the hardware key:".

I don't think we have any test in ./test/py/test.py --bd sandbox --build 
-k vboot using engines (git grep -E 'pkcs11|engine' test/py doesn't 
return anything).

Cheers,
Quentin
