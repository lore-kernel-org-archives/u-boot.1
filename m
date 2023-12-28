Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69625C46CD4
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 00:14:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEA7C87988;
	Thu, 28 Dec 2023 01:14:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eUZf0BRc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EC4C8798B; Thu, 28 Dec 2023 01:14:55 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31A9E876C0
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 01:14:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-55569b59f81so827570a12.1
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 16:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703722492; x=1704327292; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t2GFQ9d+WvVcpzU6SR1t3Cv0I7w4W1ReYTwAiYGB544=;
 b=eUZf0BRccpAAP2ij829J0HKGLZcD5ueFzFX+WYqc97OWlo6Q8cbjL9OKiEXZK6rF3K
 gQidAjzbKNtD1Mo0cHT3nPLGKZRsnDdFW8+uAL75ZpQot1y6vUpoumGmPSs03jSUxt5U
 +/d1iu4e2NQpW9ooWb9DMl32aAkKy5t65dbCwU332Acj1xidWg8SOC3gOfZay8DB26tB
 5P7pcr2oYA7KS5Z2W1cH4ii/SI0uv1tWVYSt86vvMnirUGp05N3jzwl0jN3FINiYpvCX
 tiXSzm/WkOu2Zv6hOGtdOrOjyXnMkJAg9QYSxb61DZvDmFU4S+suW6Li+M7AyfGYn+w4
 El0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703722492; x=1704327292;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t2GFQ9d+WvVcpzU6SR1t3Cv0I7w4W1ReYTwAiYGB544=;
 b=kp4aUDrHgmaPxAwghTQNlNuIgr5kab1AuWrQZHTu3uF1gV+698+xevdS4jz+mgpJmP
 r0sqSzQL3WJ8MrGyroftOVBAdKH5HWCShbTcI7Jdh/B2UbYAyTAf7QkP83soR3taa4E1
 pTsm2F9X4PHZyvKS38w3eOsgmfEhJkEJA1bYhSbLPVLsyH/Ymwk8j6fMJ3bFOLK3SjLm
 ljIPmX05fInSUujewVtVnAWEneM/WPkApRVuHleJtTg4H/WynhXLZs/Gl+EYjwufYRqh
 JIaWQ+DwhmxFEO7Ko9VQ7Vw9fJIy55knl4Ezo7Danv9gCiaOcMB831l34hQ03c6VXN8P
 Yyvg==
X-Gm-Message-State: AOJu0Yyx1kJQHzPctzdm8TEHKaLgRNQDolqyDMeQ7W2TBvk2vnJwnD21
 g1MWdMVb2i5ZPl8969YGGUAYmdlxX3t6X9MEJyNnnM497L4=
X-Google-Smtp-Source: AGHT+IF9NguAJgyI4TftxdzW87GWEHnly+6jD7HU01fTcqoeMD6qceP8oaDwHqWzaBL+NXzzdcNOQtDPMpRVZqhrhnI=
X-Received: by 2002:a50:c018:0:b0:555:3b23:1d60 with SMTP id
 r24-20020a50c018000000b005553b231d60mr1759665edb.51.1703722492334; Wed, 27
 Dec 2023 16:14:52 -0800 (PST)
MIME-Version: 1.0
References: <CA+1FSihxOraiDgHXcq=0oiJpSaGnJt+2fvvNGK7JKCkaPCv3jQ@mail.gmail.com>
In-Reply-To: <CA+1FSihxOraiDgHXcq=0oiJpSaGnJt+2fvvNGK7JKCkaPCv3jQ@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Wed, 27 Dec 2023 16:14:40 -0800
Message-ID: <CAJaLiFxnbuxa6Svmf7BN86u2wgRJZJQR+cBGWrdyAXpPQSyKNg@mail.gmail.com>
Subject: Re: I'm looking for the source code of a specific u-boot version.
To: Mario Marietto <marietto2008@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Mario and Heinrich,

On Wed, Dec 27, 2023 at 12:23=E2=80=AFPM Mario Marietto <marietto2008@gmail=
.com> wrote:
>
> Hello.
>
> I'm trying to boot FreeBSD for arm32 bit as DomU on my ARM Chromebook
> SNOW with xen. Basically there are two ways to accomplish this task :
>
>
> 1) to write a patch that allows the FreeBSD kernel to boot as a zImage
> file. This could be accomplished applying this patch to a specific
> file that's on the source code of FreeBSD :
>
>
> https://xenbits.xen.org/gitweb/?p=3Dp...8;hb=3D0782e25d98cc1391472717035f=
986c979edef0c9
>
>
>
> This patch was written by Julien Grall a lot of time ago and now it
> does not work anymore. This is the reason explain by the xen
> developers :
>
>
>
> It appears FreeBSD-CURRENT removed the last step converting the kernel
> file to kernel.bin.The patch can be readily rebased, but without
> kernel.bin that doesn't do too much.
>
>
>
> So,without a rebase of that patch the first option is not applicable.
> And I'm not able to fix it.
>
>
> 2) booting FreeBSD using U-Boot,as explained to me by a xen developer :
>
>
> I was trying to explain why and how Julien's patch works so that you
> could be the one to re-do something similar or fix the patch on the
> FreeBSD kernel that you are working with. I am happy to help review
> and write patches but I don't work with the FreeBSD kernel so I
> wouldn't be able to help you quickly. However, I might have a
> suggestion. Do you know if FreeBSD can be booted by U-Boot ?
> Because
> U-Boot definitely boots as Xen on ARM guest firmware/bootloader. You
> should be able to build U-Boot and use the U-Boot binary as Xen guest
> kernel, then U-Boot could load FreeBSD from disk or network and start
> it. For instance as domU config file:
>
> kernel=3D"/home/petalinux/u-boot.bin"
> disk =3D [ '/home/petalinux/test.img,raw,xvda' ]
>
>
> Actually I'm working on the idea n. 2. Basically I need to find the
> proper u-boot file that's able to boot the image of FreeBSD that I
> have installed (13.2 for arm32 bit). Maybe I found it here :
>
>
> http://commondatastorage.googleapis.com/chromeos-localmirror/distfiles/nv=
_uboot-snow-simplefb.kpart.bz2
>
>
> I found that link inside this tutorial :
>
>
> https://wiki.freebsd.org/arm/Chromebook
>
>
> the version of u-boot that has been embedded in that file is the followin=
g one :
>
>
> # strings nv_uboot-snow-simplefb.kpart | grep U-Boot
> U-Boot 2011.12-gc1f6280 (May 27 2013 - 15:06:59) for SMDK5250
>
>
> So the question is easy : I need to find the source code of that old
> version of u-boot,because once compiled,it will give me the proper
> u-boot.bin kernel / bootloader file that maybe will be able to boot
> FreeBSD.

Yes, it can boot a 32-bit ARM board. I'm not a FreeBSD person, but
I've helped a FreeBSD user booting a 32-bit ARM box with u-boot
(GoFlexHome Marvell Kirkwood 6281). The u-boot version was 2017.05. I
used an out-of-tree u-boot build. This u-boot executed the ubldr to
boot FreeBSD.

Please see here:
https://forum.doozan.com/read.php?3,49039,82059#msg-82059

It's been so long, I don't remember the details. Just to confirm what
Heinrich said that u-boot can indeed boot 32-bit FreeBSD, since many
years ago.

All the best,
Tony

>
>
> --
> Mario.
