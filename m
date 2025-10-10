Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405D3CCD187
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 21:00:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C256484042;
	Fri, 10 Oct 2025 22:59:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ByIunIKd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EED7841E6; Fri, 10 Oct 2025 22:59:58 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2641383FAD
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 22:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-61feb87fe26so3645712a12.1
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760129995; x=1760734795; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gVop63PJ37w8GnavUes/HJNa65cj48ccjWLhX6odMlE=;
 b=ByIunIKd3ajVlqE1XrkbqUJLhzyL/VlHsoHm9kHAOU5o6GQqAA/oK/JKqn+OqIkgR7
 iJp7vf4kLIJHOMI6wK0anRawuo+t6wSKwWq5zE/baK9JHJUcO+wBKdlzJxi374INx83O
 /+U0aukBrPiPL8OY/eOEEEn6l2FjEwhHlYnzlwI+Ppt2aL+YEnVHfE3H0242q2thjft+
 lGn/Xs/mS6fh8bYHrRYcJtxkyeiO0yhWEw5/HCdKmEerZZffxXVmB+AELN3MM85vW3ky
 pEpqJ3tBR5azop7s9e2gJ3/VTdPUnbst5alWB7ZC3XszBvK3nZ1qINjyu1mitmbGKSPG
 D51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760129995; x=1760734795;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gVop63PJ37w8GnavUes/HJNa65cj48ccjWLhX6odMlE=;
 b=XjwnDG7JnizXD/70EsvjJJJ4UrJc9rSgngndOsh995TeoAp3VBpFXTCxRXaZf7w5jJ
 buU38hytkVaTGujLL1nuovr/NcfxS2gCqvzS6pbVZ1QxRvm4bRCXA/XwEqDkvc9d9efz
 l9hjnKQupBDrKGa6VL4XHr0rwmBhQKPAyfXcNQTt4Mg/3Dw4hTAgsjf40MYzUawCim0f
 sYa0tLuIcIzSXfwuHOQAzSAPbxFXDXouWWiz4+xCIILsxJRwwgLNYeROnVZnLEMX3R2a
 d5I3ull/PINUJAdhxm9CHTba1f+f8pfy6HBXU4W1k0H58kf4cKQFogF3mLOJwNyl39FK
 QT5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9qf5e+7ewrr2iSyIL5kncFmvZtxCr5S6dHFimZRq44ZRDArviCgv5Dgb36+0e5daZevNb6d4=@lists.denx.de
X-Gm-Message-State: AOJu0YzWMhT0QobBt7lZz6ll9zqsCCDJgXIrJYkGbMAh9MVN4jJCUpHJ
 +cIC4ZligAMfUSjTxvuN95tn0LGt+nteperVCrDW7Tp5NhL7MndRLisrRKI6oqo2EYQX7HQQhPf
 v7fT7Tcb5kSvtg+WBz+vcwZR8sovhAOY=
X-Gm-Gg: ASbGncuDpxbrsIKSDX2fgDhm+7gK8xjDy981/pMMwP2uxfrOKEQDFyo+AB/3zX7pzmi
 CzJkPSQXV9OVLVKAr8ck3gXhP00N+PKm//JRgwQDxt2rpUP/nBFQFWvXIRGUhDuHrHnEnNEdRDy
 c2pXtkmeteg5PQLKMKBN10fXx2YsCEHET/WP+UeCjiO3fmgC+td40yvF7tPaBJE2oiaQVbAEU2x
 qAQuvSf/spLuS9rvQ2eEZXZHUtMRGFh2YkkBg==
X-Google-Smtp-Source: AGHT+IHVx+AlzNcCIaNZ/8DncjBzoCtU+cPlUtv6lLDEMBoOzoJtQ/w4iXfkLLka3JHXKWdOjZ4UsIXgjg+NEFEr2eE=
X-Received: by 2002:a05:6402:50c8:b0:61c:cf8d:e51d with SMTP id
 4fb4d7f45d1cf-639d5c2f5a8mr12449572a12.22.1760129995362; Fri, 10 Oct 2025
 13:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <20251010053056.32495-1-mibodhi@gmail.com>
 <20251010142835.GY298503@bill-the-cat>
 <CAJaLiFyYGJjO=BjvL3HXAfbE1V2bwB_CSkcOTC6tQTJAR_DMVA@mail.gmail.com>
 <20251010200724.GF298503@bill-the-cat>
In-Reply-To: <20251010200724.GF298503@bill-the-cat>
From: Tony Dinh <mibodhi@gmail.com>
Date: Fri, 10 Oct 2025 13:59:43 -0700
X-Gm-Features: AS18NWCSSzlHrmOo_1qetMJNoqVWS1VRnFAV3Diyfen60F0SPuI63sWlM7Vaew0
Message-ID: <CAJaLiFyTVXY4c+zS0RNPwCgzbzH968a2Zgo5s=AYh9y0wu800g@mail.gmail.com>
Subject: Re: [PATCH] bootstd: Allow PXE boot to be disabled
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>, 
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, Nam Cao <namcao@linutronix.de>, 
 Peter Robinson <pbrobinson@gmail.com>
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

Hi Tom,

On Fri, Oct 10, 2025 at 1:07=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Fri, Oct 10, 2025 at 12:38:58PM -0700, Tony Dinh wrote:
> > Hi Tom & Simon,
> >
> > On Fri, Oct 10, 2025 at 7:28=E2=80=AFAM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Thu, Oct 09, 2025 at 10:29:17PM -0700, Tony Dinh wrote:
> > >
> > > > Make it possible to disable CMD_PXE.
> > > > Remove unnecessary PXE_UTILS selection in BOOTMETH_EXTLINUX config.
> > > > In extlinux_boot(), invoke pxe utils only when
> > > > CONFIG_BOOTMETH_EXTLINUX_PXE is enabled.
> > > >
> > > > This patch results in about 9K reduction in image size when
> > > > PXE boot is disabled.
> > > >
> > > > Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> > > > ---
> > > >
> > > >  boot/Kconfig             |  3 +--
> > > >  boot/bootmeth_extlinux.c | 18 ++++++++++--------
> > > >  2 files changed, 11 insertions(+), 10 deletions(-)
> > >
> > > Is some part of the symbol logic here wrong? A challenge is that "PXE=
"
> > > is also where the logic to parse extlinux.conf style files came from,
> > > and I thought we had split those two out. And then there's this:
> > >
> > > >
> > > > diff --git a/boot/Kconfig b/boot/Kconfig
> > > > index 2993cd7f9ba..403ce4c3d46 100644
> > > > --- a/boot/Kconfig
> > > > +++ b/boot/Kconfig
> > > > @@ -421,10 +421,10 @@ config BOOT_DEFAULTS_CMDS
> > > >       select CMD_PART if PARTITIONS
> > > >       select CMD_DHCP if CMD_NET
> > > >       select CMD_PING if CMD_NET
> > > > -     select CMD_PXE if CMD_NET
> > > >       select CMD_BOOTI if ARM64
> > > >       select CMD_BOOTZ if ARM && !ARM64
> > > >       imply CMD_MII if NET
> > > > +     imply CMD_PXE if CMD_NET
> > >
> > > This is one of the things where defaults isn't supposed to be so easy=
 to
> > > get out of. How many platforms are you wanting to then disable CMD_PX=
E
> > > on to save space?
> >
> > I'm simply trying to compile out PXE for a board that I'm working on!
> > The only thing I need is booting with scripts on a block device. And
> > it looks like we have to include everything in bootstd to use it. It
> > seems wrong to make the image a lot larger than needed for boards that
> > never use a specific feature.
> >
> > I would agree about  "defaults isn't supposed to be so easy to get out
> > of". But in this case (and similarly in other CMD_x), CMD_PXE brings
> > in all dependencies for PXE including pxe_utils.
>
> So, as a preface, it's quite likely that we do need to tweak some of the
> Kconfig logic here. To help better understand the use case:
> - Does this platform have networking devices in U-Boot?
> - Are you wanting to support arbitrary off the shelf OS distributions?

Yes to both. Networking is enabled in U-Boot, but not used for
booting. And it should boot various off-the-shell OS. U-Boot is on a
512KB partition on SPI flash (why I want to keep u-boot image as small
as possible).

Thanks for your reply!
Tony

> Because if you don't have networking at all, then we should indeed be
> able to bring the library part of PXE (parse extlinux.conf style files)
> without bringing in all of PXE.
>
> If you don't want to allow arbitrary OS distributions then it should be
> possible to turn off the CONFIG that brings in everything an arbitrary
> OS might want (for example, install via network) and still have
> standard boot available for block devices and scripts and extlinux
> support.
>
> --
> Tom
