Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C33CDB483
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 16:59:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B068C86F16;
	Fri, 13 Oct 2023 18:58:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h4/H1td3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04F07869DA; Fri, 13 Oct 2023 18:58:13 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F6C086F15
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 18:58:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9be1ee3dc86so38574566b.1
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 09:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697216284; x=1697821084; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pjRLYV9vXQqIbM6Q6fqinI1FT24cV3Ipaczh4JYdYYk=;
 b=h4/H1td3bh/JQZTTfqge9xvY0we31va2A6KiTDQdQ1q3E4Yrz8HfZqpyIWRszcbyz4
 s1DIi8BSxYheBMy49q35b7yMbmt3f+4WvaHbyR75DcpgWcLKAuKY4rLhDbb9lJUPdBF5
 xIVTRH4wHPvTXO5LR/4Cf4VZnF2WesZX6yGo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697216284; x=1697821084;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pjRLYV9vXQqIbM6Q6fqinI1FT24cV3Ipaczh4JYdYYk=;
 b=eOOYbE3n7HlI3JksJNe31+LfFFAb/Ol0SaHyhyzA15jh+0x/S+gWdCehz1/Pyz7QLY
 +Jtku0eYkIcRJlZfqu5/OiFQjmwjWYsIO/hpFSpIMI6LSajr2xA0H8wRjxdWt3rpN6Sf
 OARjXuls6TYT0tpcwoPdZHTAp0nE6dKxB32rFJwKyGTL3MeWgx5YLtVYxTkJmpqD0MDE
 YFz44F+xKFK9Rvp/IqglcZTMEanMdmD5xmTW4hNnHmbO9EE77SfXtU2S20lk++m0jlqM
 6fGVOs8zHd2wCq3LI7JAqIszCh7OSP+5JikvPmlLTnPFlJrhmJoLZIAAeJjfRSR20Oa0
 Pa2A==
X-Gm-Message-State: AOJu0YydNat8c6VVDUZixUNSYdkzL+g1r6aUu7eWigLhaiMjERfC3P0h
 g+j3rHdhFMNfCW+Y/qw9fIvjOtiwm0E7yo6zODdo7w==
X-Google-Smtp-Source: AGHT+IFgok6KhNoIQCMnJPT6jkoxCkUuKPeTtw1FQGfjUti51nQUyncnH9OTnUddLg1VeXvEoY3V5l9Te+SecD+Ue90=
X-Received: by 2002:a17:907:75da:b0:9ae:40d1:999b with SMTP id
 jl26-20020a17090775da00b009ae40d1999bmr27282230ejc.16.1697216283841; Fri, 13
 Oct 2023 09:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <VI1PR08MB2847E276099DF7263424F70083CDA@VI1PR08MB2847.eurprd08.prod.outlook.com>
 <CALeDE9N6nhRBwtYqJ=7nqYuCsmbw03j3RBXRQ8jYsD=OMY=gBw@mail.gmail.com>
 <VI1PR08MB28474179AFB989B308072B1E83CDA@VI1PR08MB2847.eurprd08.prod.outlook.com>
 <CAPnjgZ3t9-trzoLGc7Jcj0=J0sQLQcHSGN3_Pf+3=iZ6=rPPqA@mail.gmail.com>
 <CALeDE9Oh9c+X5tG9RswuE=a=yQRW-j93q2oHJeOehLHHY2bSgw@mail.gmail.com>
 <CALeDE9MnMuHSH4sgAC+Z2_+71QgToHt8e8rib3igxFDKV+DYWw@mail.gmail.com>
In-Reply-To: <CALeDE9MnMuHSH4sgAC+Z2_+71QgToHt8e8rib3igxFDKV+DYWw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 13 Oct 2023 09:57:37 -0700
Message-ID: <CAPnjgZ2qOaP+u=LoMZUZN8pS0MJd=FrwpfWST0so-hszH75qEg@mail.gmail.com>
Subject: Re: U-Boot 2023.10 does not boot from uSD on RPi4
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Guillaume Gardet <Guillaume.Gardet@arm.com>,
 Matthias Brugger <mbrugger@suse.com>, 
 Ivan Ivanov <ivan.ivanov@suse.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Peter,

On Fri, 13 Oct 2023 at 09:22, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> On Fri, Oct 13, 2023 at 5:09=E2=80=AFPM Peter Robinson <pbrobinson@gmail.=
com> wrote:
> >
> > On Tue, Oct 10, 2023 at 3:58=E2=80=AFPM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > Hi,
> > >
> > > On Tue, 10 Oct 2023 at 04:39, Guillaume Gardet <Guillaume.Gardet@arm.=
com> wrote:
> > > >
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Peter Robinson <pbrobinson@gmail.com>
> > > > > Sent: Tuesday, October 10, 2023 12:22 PM
> > > > > To: Guillaume Gardet <Guillaume.Gardet@arm.com>
> > > > > Cc: mbrugger@suse.com; Ivan Ivanov <ivan.ivanov@suse.com>; Simon =
Glass
> > > > > <sjg@chromium.org>; u-boot@lists.denx.de
> > > > > Subject: Re: U-Boot 2023.10 does not boot from uSD on RPi4
> > > > >
> > > > > On Tue, Oct 10, 2023 at 10:26=E2=80=AFAM Guillaume Gardet
> > > > > <Guillaume.Gardet@arm.com> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > U-Boot 2023.10 does not boot from uSD on RPi4.
> > > > > > This has been found on openSUSE Tumbleweed. The only diff we ne=
ed is:
> > > > > >   -CONFIG_OF_EMBED=3Dy
> > > > > >   +CONFIG_OF_BOARD=3Dy
> > > > > > To use firmware provided Device Tree. But that should not affec=
t the mmc
> > > > > behavior too much, I think.
> > > > >
> > > > > I've been booting Fedora fine on a RPi4 BUT there's issues with t=
he display
> > > > > turning off [1] when the accelerated display modules load
> > > > > (vc4) as a result of this patch set. Can you confirm if that's th=
e same problem
> > > > > you're seeing?
> > > >
> > > > No, that's not my problem. My issue is grub was not loaded by u-boo=
t from uSD.
> > > > It seems more like Simon's problem: https://lists.denx.de/pipermail=
/u-boot/2023-October/533162.html
> > > >
> > > > @Simon, can you check if the patch below fixes your boot problem on=
 RPi4, please?
> > >
> > > This has been reported at least twice before. There is a fix [2] whic=
h is in my queue to apply.
> >
> > Looking at that patch it scans the first 3 devices, how does it handle
> > non storage devices like SDIO WiFi modules? It shouldn't be trying to
> > scan those.
>
> And in the case of the RPi the other enabled SDHCI interface is the
> WiFi, why would we even be trying to boot off a non storage interface,
> something here just feels broken/wrong in general.
>
> The patch does make it work with pure upstream, and I'm not sure why
> the Fedora build boots it fine out of the box, but the patch just
> feels like it's hacking around some other underlying problem with
> bootstd, we didn't have this problem with the previous method and
> trying to boot off non storage interfaces feels like it could cause
> other problems.

Does U-Boot assume that any SDHCI interface holds storage? Does it use
a different compatible string for WiFi?

The call to bootdev_setup_for_sibling_blk() in mmc_bind() is what sets
up the bootdev, so I suppose there could be a condition there.

Having said that, I doubt it would cause any problems.

If your comment is about my patch, then could you please reply there,
to avoid confusion?

Regards,
Simon
