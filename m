Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58739EEAA58
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 16:49:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C1EF86A0A;
	Thu, 14 Sep 2023 18:49:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="bDRatgpD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18E1D86A49; Thu, 14 Sep 2023 18:49:01 +0200 (CEST)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (mail-tycjpn01olkn20812.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:7010::812])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 467D7869F1
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 18:48:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wiagn233@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iktV0tNlYldLCPRTKKrE5JJv9vKgEnMRw8z18Y4ntO69iER4r/3mqcE6xIdCEntyfViRA51cKqwPLbQtYwvu6e5TuJdCKmj7fa2L868qqoiVyNxnR8GmC+xMt/QG/YesklIee+LtvZzbeMDeLUhFaxtRrEmA7ftunPBUW/dkfyTOTJQN1s+XmjkohzSnmYa1dx35nlLA7ttH/O1uODIMl5hWQs6cPV1SUpoxoOkrK2BXVDnLgHeqJZI5qusO29LyeD/IDYu4yt63FKhpf5Xaf5geG+jx8iX21XyuYWDHDiLpRieM68RP0KRtPAaV0Bd8VMSuUE6j5rlekuY1QcZHMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9brc/ont8rYFupLsqa686JDID6DNzW4IcVnjpMlw9PA=;
 b=OKqE3ykvTJ6afl9hlnvkXcGcPdp455vPjf3CCYBmugyQyib/fqv7itGXz0iFmGAdTyqZHQeLR2OFVu0zbLBfiqlUlXBHyqulNDy2xO+Loug/c2Xc0dhYU7TjkwfYVwu7ZWN03ODvPj1R9el5c8ZEK/3fx3Q/N/9IzNXn8HpISM+xEhJ9U9Trx8WSuoZb+0BiAHP8eMH58/d2idOqo2jpNeB/M0l0si3UgDiNrCHixSD97O1QEq2ESBrW0uRg487kY8kgR4naKQX3Y2IuqPM0P2DHlesWgKcTrCKCsZunVB8ryRQ5Hw6nQzWVZOG/rx4PIWdmqQV7PTr7NZG0FcoFVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9brc/ont8rYFupLsqa686JDID6DNzW4IcVnjpMlw9PA=;
 b=bDRatgpD5ZutEd6ItvHAW19FMGgy7hzrsDmfwmPLeVn5N5cqGq8QFTquUEh3bCorYOtgJJwl3dCgGzFr53q1uuPtYG8JLuB8q4QKyEEHOyq6VZPVI+8CCzmagUf7F4CK1+b09zXU4Zq28Twc1444aSxCpgBrO3wMPIeHRsV5xNbA2z9ABUsFzZoQL3LYMLDM4q6PJQO/pPBXOIDx3gFrGYF2vbVJ1GDEeKF2JCaT1dZscz/PUZ4Pj71XUO42mHIofM67yaf58Qe7R+2MXTYqp4poFhIagi7zNLFqoDpnHomZd8Q+nooQR/BkMpKJtrC+21gqUpi42G0nzzNV9ZSQ1w==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by TYCP286MB3130.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:291::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.7; Thu, 14 Sep
 2023 16:48:53 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bfaf:cb8:24b7:f67b]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bfaf:cb8:24b7:f67b%7]) with mapi id 15.20.6813.007; Thu, 14 Sep 2023
 16:48:53 +0000
Message-ID: <TY3P286MB26111CD8CDDECF3E827C6CDC98F7A@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date: Fri, 15 Sep 2023 00:48:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Cc: wiagn233@outlook.com, Mason Huo <mason.huo@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Jami Kettunen <jami.kettunen@protonmail.com>
Subject: Re: [PATCH RFC 0/2] board: visionfive2: Select fdtfile based on
 revision
To: Jami Kettunen <jamipkettunen@gmail.com>, u-boot@lists.denx.de
References: <20230911153253.20701-1-jamipkettunen@gmail.com>
From: Shengyu Qu <wiagn233@outlook.com>
In-Reply-To: <20230911153253.20701-1-jamipkettunen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [M9M4ZIp3sTz0oEdtQVeH5VKgaony5qrzWCRWGEvykDKkUF2lUaRYNlOmKTbhfOZM]
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <dc3ebedb-f732-a761-c972-7c1c200e7951@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYCP286MB3130:EE_
X-MS-Office365-Filtering-Correlation-Id: 7de64189-61b1-4f6e-6a99-08dbb5427a51
X-MS-Exchange-SLBlob-MailProps: Z9TzpHVL8qr2ah5thry8mvKQIiu16+k7HQGk0WPwO+rZQhR43zld5EU9EkhgOFdod0g++c+bM4I6KQ+k43A9NNLE8+QE1bVbOQNUoXmqMmy52TE3y1LM+BJyaLMGHqznvYhL8OjWKeh9sXns6NB8qsMo5sqFm90/FuFbhfbL4bhBNF3zzMGjASpJa1mV2qYiQqQS4B7CqwNhMKX3ht9ei1uT7QXP+9pRDBk8DLlzDZuR1tkhCy5paLvpuD+DFGbcR55Eb8PuLoJA4NdgkPDnEV3rm6Flu8ez45duzR+XDVoKf2wQTkOeDTvkxqF3dPXNUpXR45MufEkFoVaL7aAV/1XNc63FYf/ZXL3MK0b1Z2Ax5s32jGY/Y01VcLv0J7V1+51tf8plzQgDnSHbOEz5klFRyzU1KH/sBRy+x2WdXje3q3iWV09BpQBFsj916jVbtG4or8PKJpxzfECDC0MeRxsZ5r+owNtAqlE0iSgLicV4gDBeu0DbZF/mgc+LXB7Te+xdHaOnGPX0pDLEttEX/BXTaWEFGmee8xdEIHAdGNjfO9QcPfJ6CrHyEGQPTiSGGMx3lkImx8oRDw4c1zfQIVVSSAyRK10ZoGP7LlHI7kHuRocTBYwUL69zEJD7k+GJMRv5IPr0a3eH8KmLwkVv6DjPybXoL7jRz/Ud+6TIBM6DP/qWiaiz4EHa2QOQGy8Cx389KJki2ZEZuEEngj8uEmsQSmUAVYepYu0KO22fO3hJMzAJPEA1qd1gCijv0v5k5oL13poudlONB72vtX9dzpQxM89NaRhDFAPIWh/oTo0uyEeeICUjKgrLekR0zMDBVvYtO9wiAmoO1f5Oy4n6WRjFd1v0XVgE72i8M42p+2RHtImfCJS+EA==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rRX7kulms3eQ2Xt/wfAvod/V93u1kFwQe0jv5qfjKp8y9OTVctCRpq3l4LPo0emi4TLtmBEkxijizgJOP4ubpLW8UnbGPJA3fTAVjNTWx1OLsTtFWDqe/YVC/dP3qb3hnG9dveTSMaYd7k19+BbbppaGkIw7MThgC5I1QrTzZjyq2w9O7XTNsHUz77oJHSO3VK4JAE8AwYe7iHmwpiZHT7dudwpzlj7a+91jrKiPgtHYX56FGRsWb69AmV7aYTNFjkhE5e1/83x1kEcVR/YtMG5FIUkH0zKC20VM8mk0zYWt0zVXCb4u8wnKOpKAgSj54hyxg0PFvk4ZWaDhXF/YPVSnzFGMzzLYIXSCx5gwR7Gc4Vx/wl37bYpco6C5NT+3Dw6KbsbJuKf38etGGnoRNNqj931YZso4dTXkBP21LgBcdsYAFHgo7QQpWtdaVQxjfGsCtvN1WEVzLzLvEc2s3r1v5vuiBzZSrVyL6yfrfch9rnBnKKHNjfRCpJK4o34XVNaJvpbvZIf89dFwhYZM6IYQBeBgE9qgMRrRFy4a4ZkO187BMv4OrPxWWlymQwAccjzNEm4qVHqfFxmV+BCCxpYzY4wywjvjEFbQB4xpMsLMsuNrnKMVn5nr/mLsPGch
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkFCUG9TY09QMWRhZWhQb1o3aHRHY0w5TlRhWVRRL3kveWN4dzZiRUdqaVRj?=
 =?utf-8?B?NVBmRWdwUkcxOEtVZ1JPcDg1bkNxbFh5Q2I1eHNPTFQ3Qk5XY2w2TFcvNHhs?=
 =?utf-8?B?OXR0RFdmYXNaR1VQeXpsY0VhTmpNWmtjVTYvWTFFZWREVEE1UTBTN0dzcUZ0?=
 =?utf-8?B?Ly9Fd1RIU0FPWlJMMzYwalQzVzZCbk5CcThhMnJaaWIyY1FQbkJvd1VuTTc3?=
 =?utf-8?B?K3ZmdlpkUk4rTnpMWDJoTWxmZXBpOVp1WC8veVZlTnZsTnVxOFFqYnRkS1Vk?=
 =?utf-8?B?YlI1SlBkU3NwSkdWVHlnMXlUN2U5ejlzWVd4QzFQODkwQTgxaGtoUXduN1NR?=
 =?utf-8?B?WEs1ZmhrZkV1OGY1eG1BalFWMWdqem1NQWVhVGxDSjZydTZSOWIxTXhNazlJ?=
 =?utf-8?B?VkJ3czdhMjNseGdoTHdKcmxpZXdGMUZCQVRNY0JHWFk4dzNUOERoWWM1OU12?=
 =?utf-8?B?QjNSbFVESHFuM2M0b1pLaHJEcVVZZ2ZXUUtoR0cvYjVISVFPZk5PQStCSGx2?=
 =?utf-8?B?ZmxUY1p0ZFFjRVR1UzBZOSt4Vk9FbzlFQUhQbjZxTE9HRUZnYTdJKzV3Z215?=
 =?utf-8?B?TXROVGtGaklKcUVaYUlyMWw2dlpTR3RHTDFCMnhIazNwMUZRRU1PY0JQQjFl?=
 =?utf-8?B?SWhGMVIwMThmU0JVQmlxWkx2ZHpnSnRwQ1ZyY2hHbXh2YVFZdFVVZ2tRdEk2?=
 =?utf-8?B?ZjVPWTVUU1ExSzhwczQ2QkRnb3Y0czg1bThmcXZ6MVQzeGpwZ2FuSjBDR21I?=
 =?utf-8?B?U0xCSWhxRHBFTE9URG53eFp1NzhnbFRyRUFzQ2xsWFR2ZzF3aEhESlZSeElu?=
 =?utf-8?B?S2JmTTlGdDk2QVU4SngxT0UvQ2V5RHFyazEzY2hRZUR5dUwwYUxWWUV5bTBx?=
 =?utf-8?B?bXJxcy9iVThMYlc0ejlsblJrN2pkSzViOTJBeTdJSUhYTnFBREZiTENTTmx1?=
 =?utf-8?B?aGpCWHB0ajVrN1hNSFdIY3pTOHd6cXFkMlU1bjR4b05RY3IwOU9GSEFtMG5p?=
 =?utf-8?B?akc5U1FXcDgzV2tMS2dLSWVhSGEvcHNCV2s3S1d3M1Q2MmF1czBSckY5S2lE?=
 =?utf-8?B?djRyK29DUVBadjlHR3hCTUphYmpuclZNSzh4ditpT00rYkdzLzhid1BKL2xM?=
 =?utf-8?B?UTlabTJLOG01eGhaQUxWTm5FRVVlclI0MEwwcU9lc2N6SlZVWWJ2cHJxVlRP?=
 =?utf-8?B?VENLT3VnVXN1cEpzNTkwSC9iSTBCbXVYZXA1ZU9URlNqN01NRzl0Q29Pb3lQ?=
 =?utf-8?B?LzhIQkp5MkYzbGhQclpmOGJZZWw0dmZ5RHNQNVpIMXg3VU9MQVJ6RGJ1M2lI?=
 =?utf-8?B?eFVwRTNLNXROUXZ1QUpTZ3NMUUZLSXNvc0phVFgxWXZqMEFqanVPZlFXZmVC?=
 =?utf-8?B?d2ljZi9OZ1dsWk1vQ3orRzFya2h1eVVDTE5LcmtRZG8wTVhpRS9aZUxEY1gr?=
 =?utf-8?B?VXlUbE1ETC9KWnVCQXZzSSsyUitFWWtZQTdtOGZUaXZVamtVS2I5eXp4c012?=
 =?utf-8?B?RGRndFNjOVMxeDU4Qm1rSWdqd0J5OUtwWUFYUFM4K2c0KzB4TGxSdUlVS2JG?=
 =?utf-8?B?enFKak5lZmxjclhXOGd0MjlTT3JNWURuYkMweEZiNmplVXVZcUJVNTdWS2ZM?=
 =?utf-8?B?dGdzdzNaTnVJanl5YnNINmZveEw3N3dOTFVxVDRhUW1kQklwMVhqT3BTL09K?=
 =?utf-8?B?WXlYWmdlcXlyeFAzZUtnOGk4VmlCeXNhQW5ESzJTVks0NWJTeTZiVWZBPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de64189-61b1-4f6e-6a99-08dbb5427a51
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 16:48:53.1660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3130
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

Hello Jami,

I made a fix for memory size problem based on your series, but I can't try

that because I'm using 4GB version. Could you test this?

https://github.com/Headcrabed/u-boot/tree/ddr_fix_v1

Best regards,

Shengyu

> From: Jami Kettunen <jami.kettunen@protonmail.com>
>
> Currently booting a mainline Linux kernel via extlinux with fdtdir set
> doesn't load a proper DTB but passes on the U-Boot one to the kernel
> which as far as I know is very incorrect and prevents user (normally
> distro) provided DTB usage in a sensible/generic way.
>
> A uEnv.txt or similar manual environment changes were not used and
> should not be required to boot the board as per:
> https://u-boot.readthedocs.io/en/latest/develop/distro.html
>
> This also currently needs a kernel patch[1] for my board to have the
> full 8GB of memory available to Linux instead of just 4GB it shows with
> these patches alone.
>
> [1] https://gitlab.alpinelinux.org/nmeum/alpine-visionfive/-/blob/main/starfive/linux-starfive/set-8GB-RAM.patch
>
> Jami Kettunen (2):
>    board: visionfive2: Select fdtfile based on revision
>    configs: visionfive2: Enable MISC_INIT_R
>
>   .../visionfive2/starfive_visionfive2.c        | 25 +++++++++++++++++++
>   configs/starfive_visionfive2_defconfig        |  1 +
>   2 files changed, 26 insertions(+)
>
