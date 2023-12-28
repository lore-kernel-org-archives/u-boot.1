Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A9AC4706F
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 14:48:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCB5E87A13;
	Thu, 28 Dec 2023 15:48:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LlWQxvHv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14FDC87A52; Thu, 28 Dec 2023 15:48:23 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1319879E8
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 15:48:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marietto2008@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a26f73732c5so298451966b.3
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 06:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703774900; x=1704379700; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R1vdkOQXPTb8UjBP5A0Qht5YPuLeDxQIHX0n8l1EzrI=;
 b=LlWQxvHveWTWMiVLK1NHyboykG2Yyi9ImQ9SBKXeOzdCrfDduua9QxUJ96MiHHQq2g
 YegxfL+4Sgzm4z5r7Z12v/zqcX/J2X094UE1kMs6cDTd2qZcsNhzg3qOaODDK2devsjL
 MPuPsVbXhezC4wvNuufgjPsU2XqCfKTXPx1bMTyAgBPIpjWnM4Y5ECgKfwjQfTdUGj6O
 n4+0IAAElnHP8bP9zWD0WQtAVUQHRNgKkI3p4R/A8ojSdrygPkDx72ErJUz6+LS8enC6
 soGHkB5aEbr0F9u0DykNki8ONE18k3kD05mOqpjGYrpHF+TCkg8ra8IPb6/dwDrI9TmX
 b0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703774900; x=1704379700;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R1vdkOQXPTb8UjBP5A0Qht5YPuLeDxQIHX0n8l1EzrI=;
 b=UDZ0l21RcWBZ1InKtxSep0E0AFMLEoOenXrA8ww7NSzhz/g5meMMFNQXPOLXt6KQoZ
 EXhdBf9siWPLuSBxYxkx0KQjJccAc1/FFKpOw9O+bTgiauOiN9dA0kUhiF7L25C+i9TL
 ScVM/aaHbvrIb57ZcjJK9SPl1y6v4G7VIUMjmt2vxI0pbySULKDhuf0RAwn0kpDJ1YwG
 Exl1QN0YN9ggL0czqh+D8Ddlw3zbFSZPp1I6JY37y39gRBg0XTgo8zgnTo/vf1OgRj7+
 N8MyJ8rdkth1spyhz9HO17JN8sb1uNm/2VJ5itFHo3MP0onM9QtuojPpz3jQjUnAdTm+
 vWNg==
X-Gm-Message-State: AOJu0YyxoakKZgKG1GfdOr5BNd87ND0RtDCoMQM7W/rjZ82GhLmit66R
 x37qlD7H/Lpb3rVedVJyK7ZJTLHy6n48DSJ8i/k=
X-Google-Smtp-Source: AGHT+IGLBiKcF1HfS5ox50TJ+cwboeZNYFDzQAzkWGT7EoKVb5kJ2VY0c1Zm4JnnEwLEESRmZaUc88vQGD5nXeb0Uwc=
X-Received: by 2002:a17:906:b385:b0:a26:8f35:7130 with SMTP id
 uh5-20020a170906b38500b00a268f357130mr4188714ejc.48.1703774899775; Thu, 28
 Dec 2023 06:48:19 -0800 (PST)
MIME-Version: 1.0
References: <CA+1FSihxOraiDgHXcq=0oiJpSaGnJt+2fvvNGK7JKCkaPCv3jQ@mail.gmail.com>
 <CAJaLiFxnbuxa6Svmf7BN86u2wgRJZJQR+cBGWrdyAXpPQSyKNg@mail.gmail.com>
In-Reply-To: <CAJaLiFxnbuxa6Svmf7BN86u2wgRJZJQR+cBGWrdyAXpPQSyKNg@mail.gmail.com>
From: Mario Marietto <marietto2008@gmail.com>
Date: Thu, 28 Dec 2023 15:47:43 +0100
Message-ID: <CA+1FSihKXuqLMTbZzSdKXwMKAnO0nKu1ne92UXS_m9A1f8jqYA@mail.gmail.com>
Subject: Re: I'm looking for the source code of a specific u-boot version.
To: Tony Dinh <mibodhi@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
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

Hello.

Can someone provide the right link to download u-boot-2017.0.5 , please ?

I've found it here,but I'm not sure that it's the correct version :

https://src.fedoraproject.org/repo/pkgs/uboot-tools/u-boot-2017.05.tar.bz2/=
sha512/be270f9242a72b05463092a022bbabd54996762de1ff23bf7575124ac02e62f49572=
a4e2f6f571a5019047d40027e56e35593b5cc373c4a5a39b100c3377ba93/

Can you confirm it ? thanks.

On Thu, Dec 28, 2023 at 1:14=E2=80=AFAM Tony Dinh <mibodhi@gmail.com> wrote=
:
>
> Hi Mario and Heinrich,
>
> On Wed, Dec 27, 2023 at 12:23=E2=80=AFPM Mario Marietto <marietto2008@gma=
il.com> wrote:
> >
> > Hello.
> >
> > I'm trying to boot FreeBSD for arm32 bit as DomU on my ARM Chromebook
> > SNOW with xen. Basically there are two ways to accomplish this task :
> >
> >
> > 1) to write a patch that allows the FreeBSD kernel to boot as a zImage
> > file. This could be accomplished applying this patch to a specific
> > file that's on the source code of FreeBSD :
> >
> >
> > https://xenbits.xen.org/gitweb/?p=3Dp...8;hb=3D0782e25d98cc139147271703=
5f986c979edef0c9
> >
> >
> >
> > This patch was written by Julien Grall a lot of time ago and now it
> > does not work anymore. This is the reason explain by the xen
> > developers :
> >
> >
> >
> > It appears FreeBSD-CURRENT removed the last step converting the kernel
> > file to kernel.bin.The patch can be readily rebased, but without
> > kernel.bin that doesn't do too much.
> >
> >
> >
> > So,without a rebase of that patch the first option is not applicable.
> > And I'm not able to fix it.
> >
> >
> > 2) booting FreeBSD using U-Boot,as explained to me by a xen developer :
> >
> >
> > I was trying to explain why and how Julien's patch works so that you
> > could be the one to re-do something similar or fix the patch on the
> > FreeBSD kernel that you are working with. I am happy to help review
> > and write patches but I don't work with the FreeBSD kernel so I
> > wouldn't be able to help you quickly. However, I might have a
> > suggestion. Do you know if FreeBSD can be booted by U-Boot ?
> > Because
> > U-Boot definitely boots as Xen on ARM guest firmware/bootloader. You
> > should be able to build U-Boot and use the U-Boot binary as Xen guest
> > kernel, then U-Boot could load FreeBSD from disk or network and start
> > it. For instance as domU config file:
> >
> > kernel=3D"/home/petalinux/u-boot.bin"
> > disk =3D [ '/home/petalinux/test.img,raw,xvda' ]
> >
> >
> > Actually I'm working on the idea n. 2. Basically I need to find the
> > proper u-boot file that's able to boot the image of FreeBSD that I
> > have installed (13.2 for arm32 bit). Maybe I found it here :
> >
> >
> > http://commondatastorage.googleapis.com/chromeos-localmirror/distfiles/=
nv_uboot-snow-simplefb.kpart.bz2
> >
> >
> > I found that link inside this tutorial :
> >
> >
> > https://wiki.freebsd.org/arm/Chromebook
> >
> >
> > the version of u-boot that has been embedded in that file is the follow=
ing one :
> >
> >
> > # strings nv_uboot-snow-simplefb.kpart | grep U-Boot
> > U-Boot 2011.12-gc1f6280 (May 27 2013 - 15:06:59) for SMDK5250
> >
> >
> > So the question is easy : I need to find the source code of that old
> > version of u-boot,because once compiled,it will give me the proper
> > u-boot.bin kernel / bootloader file that maybe will be able to boot
> > FreeBSD.
>
> Yes, it can boot a 32-bit ARM board. I'm not a FreeBSD person, but
> I've helped a FreeBSD user booting a 32-bit ARM box with u-boot
> (GoFlexHome Marvell Kirkwood 6281). The u-boot version was 2017.05. I
> used an out-of-tree u-boot build. This u-boot executed the ubldr to
> boot FreeBSD.
>
> Please see here:
> https://forum.doozan.com/read.php?3,49039,82059#msg-82059
>
> It's been so long, I don't remember the details. Just to confirm what
> Heinrich said that u-boot can indeed boot 32-bit FreeBSD, since many
> years ago.
>
> All the best,
> Tony
>
> >
> >
> > --
> > Mario.



--=20
Mario.
