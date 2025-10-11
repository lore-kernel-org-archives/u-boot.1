Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3908FCCD184
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 19:41:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82B6C83A5F;
	Sat, 11 Oct 2025 21:41:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DnNnnxQ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C688183A8C; Sat, 11 Oct 2025 21:41:20 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0FE483A25
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 21:41:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-63a0375d7b6so5300278a12.2
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 12:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760211678; x=1760816478; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tJZtg9RSD7PS8hwiuIp/ju0SxUOf5aANECVrC0zXb14=;
 b=DnNnnxQ43kk1uqkjixfMOMPdU2JKJt3APuzmFj5Aw5AtHKraToMccWtfPgeeG0KXvk
 nYpQWZGXIValnoV6o+54r0ZnzrkbR92YdNuZLIcl9uEWFo6gcv+fT60GkgjWD+hcmv8I
 vEqkAjBkNlOLzLALvSli5/apQZ/l0wLjKIpBdX0/moULLNor5xKG2AiByiHpu+ICjQCa
 +uZ2wkfHcq2af29J3rowEN2JU1mFhh3FJ5nBF4aJVR0/3gAw4o5pUVwmAgNHxr94xSPz
 pgQQ1fet6eGvHLsAELAXcHESFJXr63vyIsTSvrn5gQTOALLpNIgAb6AlJEEyPc8gqPk8
 f5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760211678; x=1760816478;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tJZtg9RSD7PS8hwiuIp/ju0SxUOf5aANECVrC0zXb14=;
 b=nR2oqJy2apFu1Ld2CiUuObgls+kBr/Mp+StoR/eVYYpjAJZGjxEd0DHhVfmPeXsv9Y
 ItNzzp3ANijaZPXGyMdJ6w//kswAnT7Nf9TiZ2Qjw5iQHtszLTKnt5FSIcAspV/r2TP8
 OoVxdHl0rthMaYexIORLXFOplS92hnAskoSOXoG8ZhV0aVuBwkvOajnTe3u2pgRNNfSp
 mFYpinr1kUqrNCN2S9iW4zIXnf/wVZHwcFOsBfu5yHrAl2HJdqOPgblkUa8tnPYDlBBj
 6hJrWaQeCkrGB3oHtHlr9UKg1cl1FnhdyHtXGxxmB3T6jlHqQu0XfRET+39KnPhn/Uu3
 H9XQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW27+iinnyWRBZEauQdt41IxIcDelMznz0doyhOFW+OGhkbVOwurD9XMCgqgd5qqHiixqA6IjQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyGTk6sDMj0rcfP9kvqtZxka4FedeM1mw4G3Q11wamo8FNjU2QR
 UJpzh4OWQcw7RkpmuQTDu6vnWHrU/cemPlPjKK2tGdk2BzXYgoC0Fx9v7eER0EYKMRDv9gfC3RS
 r7Sh7d7pU1CXhPVloQeDNAv9p6redG6E=
X-Gm-Gg: ASbGncvKlICuKc73lQI+DWosGH5sGJ6yu4f5zTNu47BAqAw8YAk9bT3joS2nu90jL/m
 TnDMhT8eApDm1ifSdgFxddKOECpoQKw1gD+QXOUrU2fyRWdN2dPEazZt0AV7Ylc5nUN4QKcOl19
 sCTu3ZgnHXMrJRyUouiV1qRBN8xOBPdv6c0zHfody538WPwrUXpl0H+8pUwhEEl+SqZrVM+IfAE
 KinWHApbb33rY250hzu0JtPLf8=
X-Google-Smtp-Source: AGHT+IEppF9FkThujxCfYdeiVnQ1pHHV4/kFZ9RO2en4CszZB1oo06zeGx3N9NuH/5WFzwvhsQ4A83M3FjMTvQwrQ+g=
X-Received: by 2002:a05:6402:1ed1:b0:637:dfb1:3395 with SMTP id
 4fb4d7f45d1cf-639d5b5f58emr14490243a12.8.1760211678037; Sat, 11 Oct 2025
 12:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <20251010053056.32495-1-mibodhi@gmail.com>
 <20251010142835.GY298503@bill-the-cat>
 <CALeDE9P8VP6YKS1qoz3Dxga+h287GHzRvczCq0YDd4tOJxNXGQ@mail.gmail.com>
 <20251011143713.GI298503@bill-the-cat>
In-Reply-To: <20251011143713.GI298503@bill-the-cat>
From: Tony Dinh <mibodhi@gmail.com>
Date: Sat, 11 Oct 2025 12:41:06 -0700
X-Gm-Features: AS18NWCWjgvlXK1ToBj5v6DSl6nFnwhdOsrmn76MHI_pibYfjs1STbRDXEMWfwg
Message-ID: <CAJaLiFyNCD1i_3=y_jF6Kyj8jGpAY3qwBwO=DMxB=BFGc-oXoQ@mail.gmail.com>
Subject: Re: [PATCH] bootstd: Allow PXE boot to be disabled
To: Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martin Schwan <m.schwan@phytec.de>, Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Nam Cao <namcao@linutronix.de>
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

On Sat, Oct 11, 2025 at 7:37=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Sat, Oct 11, 2025 at 01:03:39PM +0100, Peter Robinson wrote:
> > On Fri, 10 Oct 2025 at 15:28, Tom Rini <trini@konsulko.com> wrote:
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
> > PXE is generally being removed in a lot of cases as it's not
> > considered secure and now we have HTTP Boot there are other means of
> > doing network booting so I think we'll see more and more situations
> > where we want to disable PXE.
> >
> > This is actually something I've been meaning to look at so it's
> > something I would love to see :)

Glad to hear :)

>
> And in the world where we also can't just remove ATAGS support because
> distros (Debian at least) still boots some modern platforms via ATAGS +
> appended device tree, the high level options for "boot this anywhere"
> need to perhaps be different from "very modern requirements only
> distro". I'm not objecting to be clear.

As Tom suggested previously, perhaps looking from a different angle.
We can disable BOOTSTD_FULL and then try adding only options that are
needed for a board. Unfortunately this approach did not work when I
tried it in the past. It seems for bootstd to work well, we need to
take the whole thing by enabling BOOTSTD_FULL.

All the best,
Tony

>
> --
> Tom
