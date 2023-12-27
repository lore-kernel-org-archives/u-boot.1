Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B628DC46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 21:37:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ED478775F;
	Wed, 27 Dec 2023 22:37:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="RVLhjbtq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96A408776E; Wed, 27 Dec 2023 22:37:30 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5479D87692
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 22:37:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703713043; x=1704317843; i=xypron.glpk@gmx.de;
 bh=OKm8lDtzYGTlqTsRYH12jzUpsEHGC9RfezKTSmZP/Yw=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=RVLhjbtqicFmVPcBkrdP0VegwqMYtWh4qOSnuqUNjbnvzKfpUNZozc1exyyQNSWQ
 i4uKMa6uHq0c2zolRQHxmFI3F/UmpVnpmF7PzEUqZ2NPqilLD7f4KQdZ7L/7gGj7C
 NkVnRRt8vAQTKzSGy4v9m21NH2Xu1gVK3GrDZdsJNv14ymI+pm0nt7ufSRk5yjHom
 uUV3TFKALpA/eOtjF6SVWrkAIQOuv5KF86NqFMvCF4/85gEUARUZgTX7etjmb+Jqi
 pB5hF38ykkkG9eAeUfX2D1E2UMh2wuxUCIjoqmkJNDp8H1HattjoKIeMZtyxd9t11
 SSWXhPuCPAxudV1Z+Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0oFz-1r4V0w2VtN-00wjQp; Wed, 27
 Dec 2023 22:37:23 +0100
Date: Wed, 27 Dec 2023 22:37:22 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Mario Marietto <marietto2008@gmail.com>
CC: u-boot@lists.denx.de, Anastasiia Lukianenko <vicooodin@gmail.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: =?US-ASCII?Q?=5BXEN=5D_Re=3A_I=27m_looking_for_the_sourc?=
 =?US-ASCII?Q?e_code_of_a_specific_u-boot_version=2E?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CA+1FSiiXs8aZnytEh1dKO+md9d3vC7i2AGTpejfNL3w85W1r_Q@mail.gmail.com>
References: <CA+1FSiiXs8aZnytEh1dKO+md9d3vC7i2AGTpejfNL3w85W1r_Q@mail.gmail.com>
Message-ID: <E10E0F67-AF38-4DBE-AA3B-48418E38F49B@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UqPsADq9ARSQqJoQ2VvAMDutBzVBz8Y9fwd3EkQUbolqKWz5194
 bOXbIBKJzEfwnfCaC4I61ya50Jdl7yhmJUclLDUPFj6eJv3y2M1eZUxEhQ3UY2UNEDtiEnk
 PdjfZ+zS5SR536qgBAwlPkAMF+UAnjktC98Et7rk/EKi7knMjRj0hcnvX60oAPj18ubteId
 ciHvLnGUqjmu+RxDRQDRg==
UI-OutboundReport: notjunk:1;M01:P0:BkY2+WFxvFg=;zw/u+lK9UrDdBnTRrsMOQZKqE9n
 iWN/EAnC4nag7Ury+uiMRX8BGwAoudKnIJtEQYb6D2e3JBv7mYPdTz3gc6CbaSlOAU9jb5D3r
 xzApHuuv7LIjt05i2GdHqF60l3eldPrQK8wcXi9FO8dUst4SXmJUUwIczquSeMVDEDw1uVghw
 +C1y/6WHcxP91G5oSgbjgj8bifpx/NtigLB4QjIMlBoNgcfT1Z4UUlR6ouJYS0IrSs49Uv0jl
 ebphuVqE/P61NScyBWfaKK5wJ2CkTYOXb4tgaQWCZDUHc9ymBBaVvqNf/bbZ72/WqervbVIaX
 RVcae5v/ovtofEReOij7/MMEswfZwDICtSDok/W+7ZdEG9lC5npLXe/kEgtcIBVL06Cm6XkWn
 V6oD5+7N4dVckMrb8vkuKGl08+wEXl2mFJ35f6oXFyRt9UMTn/8LeymuADVQI7IQSvIKKNXMB
 ERYp/g1CGrdspM4Qa4x1ZCSZAt0WJc/XSyQ8Eb0/3Jcr8hfKdC320jlDhKi3oEJJ/XQNAF02G
 VMn1DApVGZ+zwN4a7f73tknYgZ5pqDWvlA6kNZ6+NxQOLq4pwsrQFH33ujattdgTJ0xgfXGNE
 f4t1ZUCCdEyRqqcnw4NBpT4kH5FLq39yPp/OIsJELjE87ljNynTB5WbuFTDncXQoGggcW9WvI
 XWzGgCFjBiGkrSGgD1c11mCvgPvMMvvPQo3VyYmYbVgIoNnvsKufIIcq5BCd3xEP89HQzS2X+
 8Bp4WDMIHdVEAJX+b5uFPjZp8ANMvkTYd+aoAcjKQDyb9Pecp9KoXDxj7V/94pyeta1OwJcpy
 8gubLZolmjgAYKjfiFfiHyhH80W0VF6EPo3te6VlPMOL8j/m0Npqbcp0Flw8S9SWzspA2x9vH
 HBuhjW1kAN9yGCpzUmzIuv1WnnSirOKXYmhhTcuayr4USCmJomfQ27tSUQWSNfBXsY1ysWJcl
 z9lkbIPZ4CVBbsQttjhLbGFTf3VospIzt1U9DrOLyyJ2qGcSUO6lNEb0LRBcJV5e8kMiLg==
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



Am 27=2E Dezember 2023 19:54:06 MEZ schrieb Mario Marietto <marietto2008@g=
mail=2Ecom>:
>Hello=2E
>
>I'm trying to boot FreeBSD for arm32 bit as DomU on my ARM Chromebook
>SNOW with xen=2E Basically there are two ways to accomplish this task :
>
>
>1) to write a patch that allows the FreeBSD kernel to boot as a zImage
>file=2E This could be accomplished applying this patch to a specific
>file that's on the source code of FreeBSD :
>
>
>https://xenbits=2Exen=2Eorg/gitweb/?p=3Dp=2E=2E=2E8;hb=3D0782e25d98cc1391=
472717035f986c979edef0c9
>
>
>
>This patch was written by Julien Grall a lot of time ago and now it
>does not work anymore=2E This is the reason explain by the xen
>developers :
>
>
>
>It appears FreeBSD-CURRENT removed the last step converting the kernel
>file to kernel=2Ebin=2EThe patch can be readily rebased, but without
>kernel=2Ebin that doesn't do too much=2E
>
>
>
>So,without a rebase of that patch the first option is not applicable=2E
>And I'm not able to fix it=2E
>
>
>2) booting FreeBSD using U-Boot,as explained to me by a xen developer :
>
>
>I was trying to explain why and how Julien's patch works so that you
>could be the one to re-do something similar or fix the patch on the
>FreeBSD kernel that you are working with=2E I am happy to help review
>and write patches but I don't work with the FreeBSD kernel so I
>wouldn't be able to help you quickly=2E However, I might have a
>suggestion=2E Do you know if FreeBSD can be booted by U-Boot ? Because
>U-Boot definitely boots as Xen on ARM guest firmware/bootloader=2E You
>should be able to build U-Boot and use the U-Boot binary as Xen guest
>kernel, then U-Boot could load FreeBSD from disk or network and start
>it=2E For instance as domU config file:
>
>kernel=3D"/home/petalinux/u-boot=2Ebin"
>disk =3D [ '/home/petalinux/test=2Eimg,raw,xvda' ]
>
>
>Actually I'm working on the idea n=2E 2=2E Basically I need to find the
>proper u-boot file that's able to boot the image of FreeBSD that I
>have installed (13=2E2 for arm32 bit)=2E Maybe I found it here :
>
>
>http://commondatastorage=2Egoogleapis=2Ecom/chromeos-localmirror/distfile=
s/nv_uboot-snow-simplefb=2Ekpart=2Ebz2
>
>
>I found that link inside this tutorial :
>
>
>https://wiki=2Efreebsd=2Eorg/arm/Chromebook
>
>
>the version of u-boot that has been embedded in that file is the followin=
g one :
>
>
># strings nv_uboot-snow-simplefb=2Ekpart | grep U-Boot
>U-Boot 2011=2E12-gc1f6280 (May 27 2013 - 15:06:59) for SMDK5250
>
>
>So the question is easy : I need to find the source code of that old
>version of u-boot,because once compiled,it will give me the proper
>u-boot=2Ebin kernel / bootloader file that maybe will be able to boot
>FreeBSD=2E
>
>

Hello Mario,

U-Boot supports booting EFI binaries since 2016=2E I don't know if some ar=
m32 bits are still missing in FreeBSD (see https://wiki=2Efreebsd=2Eorg/UEF=
I)=2E But looking at https://cgit=2Efreebsd=2Eorg/src/plain/stand/efi/loade=
r/Makefile=2Edepend=2Earm and https://cgit=2Efreebsd=2Eorg/src/plain/stand/=
efi/loader/arch/arm/start=2ES arm32 should be  supported=2E I guess the wik=
i needs an update=2E

The U-Boot documentation only describes arm64 Xen support: https://docs=2E=
u-boot=2Eorg/en/latest/board/xen/xenguest_arm64=2Ehtml =2E

I have CCed the U-Boot Xen maintainers hoping they can indicate the missin=
g pieces for arm32=2E

Best regards

Heinrich
