Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D851DCCD187
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 03:13:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E2AE837E2;
	Mon, 13 Oct 2025 05:13:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gyjiXmRy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04A34837E4; Mon, 13 Oct 2025 05:13:14 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE7F6837B6
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 05:13:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-62fb48315ddso5206470a12.2
 for <u-boot@lists.denx.de>; Sun, 12 Oct 2025 20:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760325191; x=1760929991; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sojpmd/mEaxUNPmTLS9wJgn1vHO6aSCFyKGmHtxAQ80=;
 b=gyjiXmRyzVXyG5wD6HQ0F1uT5AQT6rVoVUp4Evk2R3w5MqolqY2zUw6aNA0Gk7UrL+
 GNoeHZNX/Z9FOFnc3dUMlkv0hOkv6kyIcThm2KzhRX01l72O3xZw8XQRZPVJlYpT1M2S
 iGziRJfeasy1XnWJ+ePvmtopa5D9VwAg7p0OnA7vb5X0fglEHQOoidTiO+50xSrvApP4
 OzFFMO999xKKOUUcIg4R5uRH73DO3FKs9re5laQrJUHhxJ7cHaJW6sniJ+4e6AXNpWqs
 +I2Nxbkg6vN8f2HD+/FwXhfXAuby/Z9JOjPzVyYZFv6qyHWmfQnN2xE5lXod6tdjjEhO
 1p1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760325191; x=1760929991;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sojpmd/mEaxUNPmTLS9wJgn1vHO6aSCFyKGmHtxAQ80=;
 b=pbAOGSu4POkjZDk01Y6woXIuwLhozXttrjenhLzToGDTtVypT8atGVZ2VjReqc4nGT
 +XhtijrvRhZnODxXrkLEq49X2HGgqMkFdcGO+UFW9hJ9hZ67m/6igiij5sycTsy34BUT
 Q8Wv2WcCZ28MJ381RqWD0ILUEnhwJbIXOeYSTCXQ0tXtwrc8B0fmswP0Bx31N7gRJ33D
 fQdVmHcZti1zDBnWJxUInZzq8PASC67Q9ok591AHAvXy/TsDKIg+mQ/r5H65X5o2pyUo
 bYAjun9A80jOiVI5MnVDqfIleTU/LmgEGuirM/DlzaKVwcAefgAHRoXoK0EJEP3Xx27w
 aKkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZt1EHSLZ8et3BMZNZZ4ovV9GqxsFBBW3XXvJ+qnrG33yy88MZbAAmRA2D11U41lsJ39SMhDQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyzgNj4y9RJp4LONU/WuEmAvgjjnoFjYCvbqj8Do74WRV4MX697
 +hj1r/l0CzwevBf3U6VfgoGNDF/jBPT/nbg5zUj4LBY+8WM1Hh2NYp0B9sML1mnuwbeHJrJKTw0
 iWawO/E6+iZA9QnkXA0SSrf0iqMqVEg0=
X-Gm-Gg: ASbGncuv7KlhdabaJNm79OOYRQnsr3d3CiXajgWhvhrWXwat2eOMZCwEaIfy8bsNb3y
 7vysfbFp137cEh7FaKNf4p4KKEfszep0+AYiCx77CV9MCgG8YzZlHwqe72J8B0pfS20i6AL8+Lj
 bpvxNHgIZw2O7BnUinHjqHvnAaJwNz8hCgb3D5JfLVV0kfz0c0Wg9d4K3xOu8YiXN8TRGbk02Vl
 UccfhD8DVzqvm5V+MOZwlmWde8=
X-Google-Smtp-Source: AGHT+IERAvoy8wS6N95NU4ox6xe6FIRVQexBsEQheZ6rg41LtmdKWRPAs1lVO8XvkUOwzaH/d8KnZjS2vrBDbvOK3Dc=
X-Received: by 2002:a05:6402:1465:b0:63a:3e7:49f8 with SMTP id
 4fb4d7f45d1cf-63a03e75f1amr12774741a12.14.1760325191057; Sun, 12 Oct 2025
 20:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20251010053056.32495-1-mibodhi@gmail.com>
 <20251010142835.GY298503@bill-the-cat>
 <CALeDE9P8VP6YKS1qoz3Dxga+h287GHzRvczCq0YDd4tOJxNXGQ@mail.gmail.com>
 <20251011143713.GI298503@bill-the-cat>
 <CAJaLiFyNCD1i_3=y_jF6Kyj8jGpAY3qwBwO=DMxB=BFGc-oXoQ@mail.gmail.com>
 <CAFLszTh8azMKW7jmQF8sY-mCkWCPZnP6U=evRPV5hVMO9DdneA@mail.gmail.com>
In-Reply-To: <CAFLszTh8azMKW7jmQF8sY-mCkWCPZnP6U=evRPV5hVMO9DdneA@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Sun, 12 Oct 2025 20:12:59 -0700
X-Gm-Features: AS18NWDi3gfJo2kcbmYcZkZlnotujVq7zvKn03QCd27OHjxADLVcO7m9bYx3R4I
Message-ID: <CAJaLiFwHfrw4Fg16vH3RPD1PDqQMaA=tmecaf8CUi8cNE9D4Bg@mail.gmail.com>
Subject: Re: [PATCH] bootstd: Allow PXE boot to be disabled
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>, 
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

Hi Simon,

On Sat, Oct 11, 2025 at 11:52=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
>
> Hi Tony,
>
> On Sat, 11 Oct 2025 at 20:41, Tony Dinh <mibodhi@gmail.com> wrote:
> >
> > On Sat, Oct 11, 2025 at 7:37=E2=80=AFAM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Sat, Oct 11, 2025 at 01:03:39PM +0100, Peter Robinson wrote:
> > > > On Fri, 10 Oct 2025 at 15:28, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, Oct 09, 2025 at 10:29:17PM -0700, Tony Dinh wrote:
> > > > >
> > > > > > Make it possible to disable CMD_PXE.
> > > > > > Remove unnecessary PXE_UTILS selection in BOOTMETH_EXTLINUX con=
fig.
> > > > > > In extlinux_boot(), invoke pxe utils only when
> > > > > > CONFIG_BOOTMETH_EXTLINUX_PXE is enabled.
> > > > > >
> > > > > > This patch results in about 9K reduction in image size when
> > > > > > PXE boot is disabled.
> > > > > >
> > > > > > Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> > > > > > ---
> > > > > >
> > > > > >  boot/Kconfig             |  3 +--
> > > > > >  boot/bootmeth_extlinux.c | 18 ++++++++++--------
> > > > > >  2 files changed, 11 insertions(+), 10 deletions(-)
> > > > >
> > > > > Is some part of the symbol logic here wrong? A challenge is that =
"PXE"
> > > > > is also where the logic to parse extlinux.conf style files came f=
rom,
> > > > > and I thought we had split those two out. And then there's this:
> > > > >
> > > > > >
> > > > > > diff --git a/boot/Kconfig b/boot/Kconfig
> > > > > > index 2993cd7f9ba..403ce4c3d46 100644
> > > > > > --- a/boot/Kconfig
> > > > > > +++ b/boot/Kconfig
> > > > > > @@ -421,10 +421,10 @@ config BOOT_DEFAULTS_CMDS
> > > > > >       select CMD_PART if PARTITIONS
> > > > > >       select CMD_DHCP if CMD_NET
> > > > > >       select CMD_PING if CMD_NET
> > > > > > -     select CMD_PXE if CMD_NET
> > > > > >       select CMD_BOOTI if ARM64
> > > > > >       select CMD_BOOTZ if ARM && !ARM64
> > > > > >       imply CMD_MII if NET
> > > > > > +     imply CMD_PXE if CMD_NET
>
> If you only want scripts, then perhaps you can enable just what you
> need, e.g. BOOTMETH_SCRIPT? You may need to disable BOOT_DEFAULTS and
> choose your own options.

Indeed, that was a missing config when I tried with BOOTSTD_FULL
disabled. But there is more, please see below.

>
> > > > >
> > > > > This is one of the things where defaults isn't supposed to be so =
easy to
> > > > > get out of. How many platforms are you wanting to then disable CM=
D_PXE
> > > > > on to save space?
> > > >
> > > > PXE is generally being removed in a lot of cases as it's not
> > > > considered secure and now we have HTTP Boot there are other means o=
f
> > > > doing network booting so I think we'll see more and more situations
> > > > where we want to disable PXE.
> > > >
> > > > This is actually something I've been meaning to look at so it's
> > > > something I would love to see :)
> >
> > Glad to hear :)
> >
> > >
> > > And in the world where we also can't just remove ATAGS support becaus=
e
> > > distros (Debian at least) still boots some modern platforms via ATAGS=
 +
> > > appended device tree, the high level options for "boot this anywhere"
> > > need to perhaps be different from "very modern requirements only
> > > distro". I'm not objecting to be clear.
> >
> > As Tom suggested previously, perhaps looking from a different angle.
> > We can disable BOOTSTD_FULL and then try adding only options that are
> > needed for a board. Unfortunately this approach did not work when I
> > tried it in the past. It seems for bootstd to work well, we need to
> > take the whole thing by enabling BOOTSTD_FULL.
>
> If you end up trying it again, please give a few details here as we
> might be able to improve this. When bootstd was first introduced we
> had very tight code-size constraints, so quite a few features are only
> provided if BOOTSTD_FULL is enabled. Tom has suggested enabling more
> features in the base implementation but we haven't really figured out
> which.

The problem is when a board already has enabled BOOTSTD_FULL or has
been updated with Distro Boot (CONFIG_DISTRO_DEFAULTS), all the
necessary configurations such as ext2, ext4, efi partition,... are
implied, therefore were removed from board defconfig. They must be
added back.

I actually tried this just now and it does work booting a script from
USB drive with this combination:

CONFIG_BOOTMETH_SCRIPT=3Dy
CONFIG_DISTRO_DEFAULTS=3Dy    (this also selects CMD_PXE, but it's OK
for this test)
# CONFIG_BOOTSTD_FULL is not set

I think it's quite cumbersome to add each of the necessary configs
back to the board defconfig. Not as easy as removing CMD_PXE, or other
CMD_x to remove a capability.

All the best,
Tony

>
> Regards,
> Simon
