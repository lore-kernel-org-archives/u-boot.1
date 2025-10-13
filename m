Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB4DCCD183
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 21:17:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A7EB83935;
	Mon, 13 Oct 2025 23:17:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cN2/RsfX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DABD08394E; Mon, 13 Oct 2025 23:17:33 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C528783710
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 23:17:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-63a10267219so2192707a12.0
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 14:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760390251; x=1760995051; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UQpwCHbYkCwMdjwTSl24xTwpil4lUhynthtflpO6QCI=;
 b=cN2/RsfXt/WXXTKlNjPGtoBY8Tvz/QzYFxclwxGllIwnQS8JWhFHvuQIKANtZGPqvC
 lMoli4sxRq55XletNhR2c4bnVmEbd/OndhFCEzsBlV28lWGn9f9kgTQmLzCffF660Jqt
 k3imnPkrMQjkbBj5mBKGzFCkHGqx1LffBH9kM7y2Xm//nqvk9wqRV+vpwwaHmYhsYRUA
 HZZFCq0uqFRZNo/MnKk5ELzRjQMAkldsOpYM7rWDlEpXZk7GPhHuJjSljChIWauCzIIA
 R0lDX5DMiEs2RH72ObyhU0uGkuE1d5ySuKQEsgHF3tJp152Q8xONHH6ZuGCObxU+1qPj
 4png==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760390251; x=1760995051;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UQpwCHbYkCwMdjwTSl24xTwpil4lUhynthtflpO6QCI=;
 b=cSldRCOIUJj38APPxXrfdbT+lH9RRAOolOBWm9WkeFkFQF4CcwImKKzVj6WtupXrk5
 4nfSqekUX25LN4cvo0HO+wCravqxs27hKAwZKUP6FI/wL+GqOftI1L92OAzNJSazwjIG
 DoO4MEaUtcHzFGmlk9eS8JU0Jfm/H82D5etzQxJENqXSx2ErsZhan1x2GzQEsGfGgVCO
 LidSnEjTYZy/Mgo49BKC/5hP440+5yb3C7F+ILS1GxNYlIjyAZp85tj1CJF8TYeaD1kP
 Kvu2YSP6TAxevoyNCCbXRlnAJlPKjrZ6YVWN1TQkhuINmFUs6MzH3ZwIIYEQc9bQQwTI
 6AEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmflfugtYaBBL4POkmQbH7woSA/FGcp4Zv8cOCEfq7ZGLykDDbcLf1kqMwWkkt/fKsz0XgjVA=@lists.denx.de
X-Gm-Message-State: AOJu0YxkPtBOvkhqJ5/zgg5Xuz/esDNB18BWVrkyJwlPJiXz0WzWrpZ6
 uGu/Hl6hfRYKx7QVaUVi5iRFND6mncWDIvmauUkplSJ1t7Dh7cldRj3eNX2x4B0i+elTh6rtiFR
 a6hW+fPKVofo8amJpWIfYav6mzCUTqoU=
X-Gm-Gg: ASbGncuDKjjemCfeaKP1Iq9KPgBNR1O/9YAvfCPAsaf3jvrkA4blDYvurptIOp2vkG1
 hpI8ICNSwMPj6giR0W5GQsf4ndc7Ko52JzACQV+DcuGMuA6SVlcrEahzowIpKXWKCa852qaFkhP
 eAm7kURqXO9Sl+BV9LYMnRznzqiAMtVFDdYuOEn39vJ/JtYrR6a3qvy1ZT1Vf/kSn6oMiEbAWr8
 74bWvcYTIbqcipLFX69nkd5aRI7Ccm8OFaUpg==
X-Google-Smtp-Source: AGHT+IEqq/Fqk8rxnA6KlKQWXmt1TK/Gs281FVZANWq6Wih2sqMQh1hSRch0DFiXX31DsFzKvWP+R3JKVh9KVUO+u3E=
X-Received: by 2002:a05:6402:50c6:b0:634:c377:e1ae with SMTP id
 4fb4d7f45d1cf-639d615df4bmr22705870a12.14.1760390250998; Mon, 13 Oct 2025
 14:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <20251010053056.32495-1-mibodhi@gmail.com>
 <20251010142835.GY298503@bill-the-cat>
 <CALeDE9P8VP6YKS1qoz3Dxga+h287GHzRvczCq0YDd4tOJxNXGQ@mail.gmail.com>
 <20251011143713.GI298503@bill-the-cat>
 <CAJaLiFyNCD1i_3=y_jF6Kyj8jGpAY3qwBwO=DMxB=BFGc-oXoQ@mail.gmail.com>
 <CAFLszTh8azMKW7jmQF8sY-mCkWCPZnP6U=evRPV5hVMO9DdneA@mail.gmail.com>
 <CAJaLiFwHfrw4Fg16vH3RPD1PDqQMaA=tmecaf8CUi8cNE9D4Bg@mail.gmail.com>
 <20251013144016.GG6113@bill-the-cat>
In-Reply-To: <20251013144016.GG6113@bill-the-cat>
From: Tony Dinh <mibodhi@gmail.com>
Date: Mon, 13 Oct 2025 14:17:18 -0700
X-Gm-Features: AS18NWCDQwyKETMTsZYG4p-TOIu-5Kj5SPMC69Xx4v3-CGDP_8k117AQw6FePSw
Message-ID: <CAJaLiFz-UQfHgsvB59kYGW0=tiKzKeN7bHYH5hZrVDFKRGOrFQ@mail.gmail.com>
Subject: Re: [PATCH] bootstd: Allow PXE boot to be disabled
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>, 
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

Hi Tom,

On Mon, Oct 13, 2025 at 7:40=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Sun, Oct 12, 2025 at 08:12:59PM -0700, Tony Dinh wrote:
> > Hi Simon,
> >
> > On Sat, Oct 11, 2025 at 11:52=E2=80=AFPM Simon Glass <sjg@chromium.org>=
 wrote:
> > >
> > > Hi Tony,
> > >
> > > On Sat, 11 Oct 2025 at 20:41, Tony Dinh <mibodhi@gmail.com> wrote:
> > > >
> > > > On Sat, Oct 11, 2025 at 7:37=E2=80=AFAM Tom Rini <trini@konsulko.co=
m> wrote:
> > > > >
> > > > > On Sat, Oct 11, 2025 at 01:03:39PM +0100, Peter Robinson wrote:
> > > > > > On Fri, 10 Oct 2025 at 15:28, Tom Rini <trini@konsulko.com> wro=
te:
> > > > > > >
> > > > > > > On Thu, Oct 09, 2025 at 10:29:17PM -0700, Tony Dinh wrote:
> > > > > > >
> > > > > > > > Make it possible to disable CMD_PXE.
> > > > > > > > Remove unnecessary PXE_UTILS selection in BOOTMETH_EXTLINUX=
 config.
> > > > > > > > In extlinux_boot(), invoke pxe utils only when
> > > > > > > > CONFIG_BOOTMETH_EXTLINUX_PXE is enabled.
> > > > > > > >
> > > > > > > > This patch results in about 9K reduction in image size when
> > > > > > > > PXE boot is disabled.
> > > > > > > >
> > > > > > > > Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> > > > > > > > ---
> > > > > > > >
> > > > > > > >  boot/Kconfig             |  3 +--
> > > > > > > >  boot/bootmeth_extlinux.c | 18 ++++++++++--------
> > > > > > > >  2 files changed, 11 insertions(+), 10 deletions(-)
> > > > > > >
> > > > > > > Is some part of the symbol logic here wrong? A challenge is t=
hat "PXE"
> > > > > > > is also where the logic to parse extlinux.conf style files ca=
me from,
> > > > > > > and I thought we had split those two out. And then there's th=
is:
> > > > > > >
> > > > > > > >
> > > > > > > > diff --git a/boot/Kconfig b/boot/Kconfig
> > > > > > > > index 2993cd7f9ba..403ce4c3d46 100644
> > > > > > > > --- a/boot/Kconfig
> > > > > > > > +++ b/boot/Kconfig
> > > > > > > > @@ -421,10 +421,10 @@ config BOOT_DEFAULTS_CMDS
> > > > > > > >       select CMD_PART if PARTITIONS
> > > > > > > >       select CMD_DHCP if CMD_NET
> > > > > > > >       select CMD_PING if CMD_NET
> > > > > > > > -     select CMD_PXE if CMD_NET
> > > > > > > >       select CMD_BOOTI if ARM64
> > > > > > > >       select CMD_BOOTZ if ARM && !ARM64
> > > > > > > >       imply CMD_MII if NET
> > > > > > > > +     imply CMD_PXE if CMD_NET
> > >
> > > If you only want scripts, then perhaps you can enable just what you
> > > need, e.g. BOOTMETH_SCRIPT? You may need to disable BOOT_DEFAULTS and
> > > choose your own options.
> >
> > Indeed, that was a missing config when I tried with BOOTSTD_FULL
> > disabled. But there is more, please see below.
> >
> > >
> > > > > > >
> > > > > > > This is one of the things where defaults isn't supposed to be=
 so easy to
> > > > > > > get out of. How many platforms are you wanting to then disabl=
e CMD_PXE
> > > > > > > on to save space?
> > > > > >
> > > > > > PXE is generally being removed in a lot of cases as it's not
> > > > > > considered secure and now we have HTTP Boot there are other mea=
ns of
> > > > > > doing network booting so I think we'll see more and more situat=
ions
> > > > > > where we want to disable PXE.
> > > > > >
> > > > > > This is actually something I've been meaning to look at so it's
> > > > > > something I would love to see :)
> > > >
> > > > Glad to hear :)
> > > >
> > > > >
> > > > > And in the world where we also can't just remove ATAGS support be=
cause
> > > > > distros (Debian at least) still boots some modern platforms via A=
TAGS +
> > > > > appended device tree, the high level options for "boot this anywh=
ere"
> > > > > need to perhaps be different from "very modern requirements only
> > > > > distro". I'm not objecting to be clear.
> > > >
> > > > As Tom suggested previously, perhaps looking from a different angle=
.
> > > > We can disable BOOTSTD_FULL and then try adding only options that a=
re
> > > > needed for a board. Unfortunately this approach did not work when I
> > > > tried it in the past. It seems for bootstd to work well, we need to
> > > > take the whole thing by enabling BOOTSTD_FULL.
> > >
> > > If you end up trying it again, please give a few details here as we
> > > might be able to improve this. When bootstd was first introduced we
> > > had very tight code-size constraints, so quite a few features are onl=
y
> > > provided if BOOTSTD_FULL is enabled. Tom has suggested enabling more
> > > features in the base implementation but we haven't really figured out
> > > which.
> >
> > The problem is when a board already has enabled BOOTSTD_FULL or has
> > been updated with Distro Boot (CONFIG_DISTRO_DEFAULTS), all the
> > necessary configurations such as ext2, ext4, efi partition,... are
> > implied, therefore were removed from board defconfig. They must be
> > added back.
> >
> > I actually tried this just now and it does work booting a script from
> > USB drive with this combination:
> >
> > CONFIG_BOOTMETH_SCRIPT=3Dy
> > CONFIG_DISTRO_DEFAULTS=3Dy    (this also selects CMD_PXE, but it's OK
> > for this test)
> > # CONFIG_BOOTSTD_FULL is not set
> >
> > I think it's quite cumbersome to add each of the necessary configs
> > back to the board defconfig. Not as easy as removing CMD_PXE, or other
> > CMD_x to remove a capability.
>
> There's two parts to this. In turns of changing the defconfig to start
> with, you shouldn't need to "add back", if you do:
> $ make foo_defconfig
> $ make menuconfig # Disable full, etc
> $ make savedefconfig
> $ cp defconfig configs/foo_defconfig

Of course you're right! "make menuconfig" works as described above.

Thanks,
Tony

>
> But the second part is that yes, it's at least currently intentional to
> be cumbersome to break the "all stock distributions work in all expected
> use cases" option. If you have networking, networking works in U-Boot,
> but you're not allowing users to install distros over the network like
> they should be able to expect to, it shouldn't be easy.
>
> I am open to splitting the current option up in to multiple parts, along
> the lines of legacy options, modern options, disk options, network
> options since as Peter noted earlier in this thread, PXE is going away
> in favour of HTTP(s) boot. But we still have lots of legacy boards and
> distros to support.
>
> --
> Tom
