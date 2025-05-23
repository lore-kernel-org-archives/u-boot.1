Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7911EC54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 17:04:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7190E83285;
	Fri, 23 May 2025 19:04:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="KsiSRBFj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D34C183335; Fri, 23 May 2025 19:04:53 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB61783249
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 19:04:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1748019887; x=1748624687; i=xypron.glpk@gmx.de;
 bh=okUQTQrlBsKDSUxSyVFP1SgrhYcjHiKJhqWqDYq1pA0=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=KsiSRBFjHN6Kfbe2UtkavxC1mGp80Mm/u04Jc8phwnRRyWenNP/AtORK3NZJc66k
 P/s0rJU/hspLBS8bdq0RvpGOtaMoI7/FlqkuIqxmXs2dnbMW5o4wDIrC5SAxzQJGP
 WWfJTfZd74Pp+1TefxUzyz7YuyP+lgeqKwFbv8okLDByYynwoIqVXgAr5NWHWt+Mk
 +KwkHidJVa0XkKHjNG7Y2zhllYZt4mqWojCkD21YH8EcpZLn1uOV6tIkc3MFa28VX
 +gaG/h/kehXFic2M7akDdn3Xl3LRUH8YatzeMqLprZJayWLzSEzbQWMJUwqJfHxL+
 dP0Say/aD4ZSTZSUJw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYeMj-1uNmtY10lP-00XGMX; Fri, 23
 May 2025 19:04:47 +0200
Date: Fri, 23 May 2025 19:04:46 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>,
 =?UTF-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_bootm=3A_Pass_SMP_core_ID_an?=
 =?US-ASCII?Q?d_DTB_address_for_ELF-formatted_kernels?=
User-Agent: Thunderbird for Android
In-Reply-To: <CAFLszTgpYgVfrf4P189tcNM7xOvoiVjMu_sP1nrP+FGfAYHYSw@mail.gmail.com>
References: <ME0P300MB13096732AF44AC5409B9D0D49F96A@ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM>
 <CAFLszTgpYgVfrf4P189tcNM7xOvoiVjMu_sP1nrP+FGfAYHYSw@mail.gmail.com>
Message-ID: <28BD711D-9449-46DA-AD38-8142B0CAF7AB@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2c78nPLbIAmauiIzn95h9b8j1ESzyujymKFF4Z6HD6Br/kQi6lI
 WNW4RuLxovINR5mkUeGeo0Chyz5/kExW8uhVEc680AGM3aux7bDfL/ezv0xeHtGpZQbpapc
 WKl0CkqRISuIQZIVmNnCUuIpEZ+CZem/RdGgTgu9wIlkdkDaN9yAZQrWP4JihlstENZgwbn
 0mr6fOHnsnfHNVx0IzmJg==
UI-OutboundReport: notjunk:1;M01:P0:/1zIVMqrhzE=;8E7RApBuz0uzvqkWd5PwYZs1y+r
 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
 7ssKhQaotms9I=
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

Am 23=2E Mai 2025 18:41:45 MESZ schrieb Simon Glass <sjg@chromium=2Eorg>:
>+Heinrich Schuchardt
>
>Hi,
>
>On Tue, 13 May 2025 at 13:28, =E7=89=9B =E5=BF=97=E5=AE=8F <Zone=2ENiuzh@=
hotmail=2Ecom> wrote:
>>
>> When booting RISC-V ELF-formatted kernel images (IH_TYPE_KERNEL + IH_OS=
_ELF),
>> explicitly pass SMP core/hart ID and DTB address to comply with modern
>> SMP-enabled kernels' boot protocol requirements=2E
>>
>> Signed-off-by: Zone=2EN <zone=2Eniuzh@hotmail=2Ecom>
>> ---
>>  boot/bootm_os=2Ec | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/boot/bootm_os=2Ec b/boot/bootm_os=2Ec
>> index a3c7cb5332e=2E=2Ea0f310b1359 100644
>> --- a/boot/bootm_os=2Ec
>> +++ b/boot/bootm_os=2Ec
>> @@ -402,6 +402,11 @@ static int do_bootm_elf(int flag, struct bootm_inf=
o *bmi)
>>         if (flag !=3D BOOTM_STATE_OS_GO)
>>                 return 0;
>>
>> +#if defined(CONFIG_RISCV)
>> +       bmi->argc =3D gd->arch=2Eboot_hart;
>> +       bmi->argv =3D (char **)bmi->images->ft_addr;
>> +#endif
>
>If this is a kernel, it should really be using a FIT=2E  The Elf entry
>is for general ELF files, not Linux=2E Perhaps RISC-V is special in some
>way?

A defconfig kernel is booted via the booti command or via its EFI stub=2E

Why would you use an ELF formatted kernel? What kernel configuration are y=
ou using to get such a kernel?

Best regards

Heinrich=20


>
>> +
>>         bootelf(bmi->images->ep, flags, bmi->argc, bmi->argv);
>>
>>         return 1;
>> --
>> 2=2E45=2E2
>
>Regards,
>Simon

