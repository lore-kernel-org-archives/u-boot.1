Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A55C04FFE
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 12:27:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09B81880C5;
	Tue, 14 May 2024 14:27:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iXu4yCs+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30185882B5; Tue, 14 May 2024 11:37:16 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B32FB88229
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 11:37:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=antoni.s.jankowski@gmail.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-43df14d8a27so28350251cf.2
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 02:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715679432; x=1716284232; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/78klB8+fDpCxWdyLU+R7l9SzBgdAAEUC2w8LnRFqyg=;
 b=iXu4yCs+Eqwad64YG+clHq3e+iyaLD6dixmOxL7eTyWhV471Vn1nceP+J3wtL6Oi21
 q8cG+T0SZDNQYhVNd7ruzdkrn0/PL7+lk8t/msU6CfbmGP6BK6A4I73EvHxkkQIbnBjt
 KqVdQS+AItXQM1IcBK5iioUFFTy0QMlTGuVCezdew7cojUNiNTDZ4wZQm2cERjojRMQH
 HG/W9TbX+LRdPFC3cNhynuIS4bUJiqhum+dsGmrpmcVb4Q19rOW/vlsugLfpaZZ7RAOy
 HS8tw0ukyImMPvPcRi884IjkTEAuNQiO9cRfeWWXSNiVF6ES+y7vDrZ8fdZCRWq0p/C5
 jRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715679432; x=1716284232;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/78klB8+fDpCxWdyLU+R7l9SzBgdAAEUC2w8LnRFqyg=;
 b=cj/R14IGc6I+Lkah7CyCxw9N5zYnuFDWBWSuLjae8+EIIIj9Zc7ETM3/WCyzkUReJC
 WvkB9/p/Dxmq0bxcgOrQSYmJkDmNKy0M7Sk3Yxwv7DcLO2Lv5LWoBdHZnoYktQRbP2+w
 OJ930blA2s+Yo4sBnnVVZAZ4EgoaM3/1echOgH2QjHva352kZaFMBPnfMHMF6rpAkKtK
 SIFnn56HOI901uMbM8ZnQPnyI6soEhhSgdUGSgisiSRrvrFnSTZ3sZFN3+QsSVwEFNKI
 0SWWi56I0Oe7R4G8h8UgP+cSjvpvoPlAkdlESZjcqndCAyjBF1KyzEVGGBc65b1XKNmW
 sAqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUpSSyrQxN9S83jxogpn+dGHUzU0Ab/ORi5u2QgL/u6f4LdvSXHJ9uFfV+Gm1p/8y0GVqQoYA75GxPsR1DQF4bDq/jyg==
X-Gm-Message-State: AOJu0YxA16alL5SV5hQRo0lnQ7ieq534oxEst1XJrbnut50FRBABFnRV
 G8UOkaDT0/ZpJWbAIqJpPs3exNH2yLpJgcr/3h7O/Y+PLRXyJUtR6WNjV6AP6AH9G2um2ixsEl8
 7oEUOntJRiy2APstdqkPbgpa93gQ9jvD5
X-Google-Smtp-Source: AGHT+IGWqxeG7HdqJ6sqaYGRjSvI2yUQ6kgHuBQcerOHICVSt8+hJH8RVeIJN65wR3IXefhozlCW5Q3GBOdXHBDFlts=
X-Received: by 2002:ac8:5e48:0:b0:43e:19d6:ec15 with SMTP id
 d75a77b69052e-43e19d6f223mr58377721cf.37.1715679432445; Tue, 14 May 2024
 02:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAM4sPk-un78JmrMQpAe24nWMp0ytrieyL3zrZd_Qg9HOm--gtg@mail.gmail.com>
 <CAByghJZx=KFcygY2=N13=Tw94e3=7+gg7h6Usad2McjaBV2KKw@mail.gmail.com>
 <87zft1he71.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <87zft1he71.fsf@bloch.sibelius.xs4all.nl>
From: Antoni Jankowski <antoni.s.jankowski@gmail.com>
Date: Tue, 14 May 2024 12:37:01 +0300
Message-ID: <CAM4sPk-XioK7+_AskiavrYHZFQKdZGOqAkaJbTfERYqz22to-A@mail.gmail.com>
Subject: Re: Distro Boot instructions with examples
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de
X-Mailman-Approved-At: Tue, 14 May 2024 14:27:49 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Thanks for your suggestions. I read the docs and it seems that maybe the
standard boot procedure is a bit too much, the current u-boot config for
raspberry pi CM4 is very simple and I'd like to keep it that way.
By default the u-boot environment on CM4 is kept on the boot FAT partition.
Would it be a good solution to simply copy all the CM4 related (but not
u-boot) files like the kernel image, the device trees and the rpi config
files (config.txt, cmdline.txt) to the rootfs partition and only tell
u-boot that they are available there?
I suppose that the files *.elf files should also stay on the /boot
partition along with the uboot.env.

Best regards,
Antoni

On Tue, May 7, 2024 at 5:46=E2=80=AFPM Mark Kettenis <mark.kettenis@xs4all.=
nl>
wrote:

> > From: Igor Opaniuk <igor.opaniuk@gmail.com>
> > Date: Tue, 7 May 2024 16:30:17 +0200
> >
> > Hello Antoni,
> >
> > On Tue, May 7, 2024 at 4:14=E2=80=AFPM Antoni Jankowski
> > <antoni.s.jankowski@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > I've recently learned about the Distro Boot feature of u-boot. This
> sounds
> > > interesting, however the official instructions are sparse and example=
s
> seem
> > > to be non-existent.
> > >
> > > The platform I'm working with at the moment is a raspberry pi CM4, ar=
e
> > > there any examples of how to implement this concept? Distro Boot seem=
s
> to
> > > be suitable for updating all the rootfs at once, including what
> usually is
> > > a separate boot partition.
> > >
> > > Best regards,
> > > Antoni
> >
> > There is a nice manual from Toradex about Distro Boot integration [1].
> > You can also find a bunch of examples of integration of existing boards
> > just by grep-ing:
> >
> > u-boot.git$ grep -ine "config_distro_bootcmd" -r ./include/configs/
> > ./include/configs/pico-imx6ul.h:86:#include <config_distro_bootcmd.h>
> > ./include/configs/kp_imx6q_tpc.h:84:#include <config_distro_bootcmd.h>
> > ./include/configs/imx8mp_venice.h:21:#include <config_distro_bootcmd.h>
> > ./include/configs/stm32f746-disco.h:30:#include <config_distro_bootcmd.=
h>
> > ...
> >
> > Hope this helps.
> >
> > [1]
> https://developer.toradex.com/linux-bsp/os-development/boot/distro-boot/
>
> However, "distro boot" is being superseded by "standard boot" in
> recent versions of U-Boot and the raspberry pi boards have already
> moved on.  See doc/develop/bootstd.rst for some documentation on
> "standard boot".
>
