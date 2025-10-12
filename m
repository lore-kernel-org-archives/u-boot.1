Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21587CCD184
	for <u-boot@archiver.kernel.org>; Sun, 12 Oct 2025 06:52:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 601D083893;
	Sun, 12 Oct 2025 08:52:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="euZXE/kj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0636838E3; Sun, 12 Oct 2025 08:52:05 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF52A8388C
 for <u-boot@lists.denx.de>; Sun, 12 Oct 2025 08:52:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b3da3b34950so546527466b.3
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 23:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760251923; x=1760856723; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f3tpGhfaVk/s9u4e4nZaQCPcdrxHpoyBZ+RmG6pHuEU=;
 b=euZXE/kjOeVnKNKmXxo0hq91Ad0E5Ef2MTvoQBcpJxYdduPvNFd6hussFG8KNb7m73
 U93zGdNVDVoawl1eAadn6a4xBjfI7hjw1c2+iFl7LYQMwvsavCnkkenQtUCc46ca7qnb
 oHUyGPRcDJ35IhMfdHKI76zrsU7zLfaBI4u0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760251923; x=1760856723;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f3tpGhfaVk/s9u4e4nZaQCPcdrxHpoyBZ+RmG6pHuEU=;
 b=A2VMYcBWFy/CnnyQXLJIklglWH5DmOOYrOnxYwTYnzE45Eu71pP9guJzyRGqovtL4Y
 0y1THzOn9TPSh6g9l81TSOGJ2vXsp27QPSafmOmnh+snoiU6L1JAWDR+rzDoCUx8EM+J
 fpnq6l1rZwjXAgr7hOSRjo65XnfQvMVfRMAFTbQX7vzOtENsaNexOoxygaEerlIJjc+9
 rf1IpR16IBPId1H5YONHy0Enm5sbS6lkP1UweYxKT0vXbzOxaggrUc7o2ytks/HcPB0P
 LSNnWOPuWlEbCcj87F/un8rphBeXp//UNSP2vGE8hXcg5sj86wahJt68ETbztEtRFgR2
 yHVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7cI+9wcHApWYK7ISN+iBhvHW5YqaQkI0cMElabg6aSA9qmuQwVOYnegkGml3bsxRJkcl9sQo=@lists.denx.de
X-Gm-Message-State: AOJu0YzvqLOh4TZZNafGOJPqBEsk7RWzYUqqreko8DZArB9FpwYrtE1L
 B4OBzERr9Tg10lKrNj9US71lWe421cS7ItxnkrzSx5+8WzV/A5RhNd3zt5ygqcExlUldBn5doUf
 pxGU2luCONgK1Fz3OM7MghVQwNd2jlSBBl/6A98fu
X-Gm-Gg: ASbGnctVpcXtnqBk9mysdBUQ23xPoulxgBpkylA/hgpQmUIysX+xuVRtJWiiKLKrDa4
 qPQmuUNG62vd0aDGWbv+lvmtDfN/eOHrbVUg2GXVBbgsy9f9dgF0UTu+qOu944GkH0ZAwG9BiRw
 kcTnDnstMfdGsR+7JlprBX0bDXLq43MVo14190l3zpGglLIG71sTMF8ULjuFxPfde0Awm1PLKVj
 EZNEF7S6gIFZH7SmKDcY5t1Wg==
X-Google-Smtp-Source: AGHT+IHuNG+JblnVifEm2H5L0eWmmWeU2XVsE5VHbsq9NE6slPKcFZ5naldAXMffNj8S73iyA+Nb/GiH5n3ucJAPKAE=
X-Received: by 2002:a17:907:9706:b0:b39:57ab:ec18 with SMTP id
 a640c23a62f3a-b50abfd5472mr1728729966b.45.1760251923240; Sat, 11 Oct 2025
 23:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <20251010053056.32495-1-mibodhi@gmail.com>
 <20251010142835.GY298503@bill-the-cat>
 <CALeDE9P8VP6YKS1qoz3Dxga+h287GHzRvczCq0YDd4tOJxNXGQ@mail.gmail.com>
 <20251011143713.GI298503@bill-the-cat>
 <CAJaLiFyNCD1i_3=y_jF6Kyj8jGpAY3qwBwO=DMxB=BFGc-oXoQ@mail.gmail.com>
In-Reply-To: <CAJaLiFyNCD1i_3=y_jF6Kyj8jGpAY3qwBwO=DMxB=BFGc-oXoQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 12 Oct 2025 07:51:51 +0100
X-Gm-Features: AS18NWBLoUKcZ5Y3fzwr9rZZuVePaL6Rk4cw5HWg9gxnA7wKZqL17NY_ZEY3rQQ
Message-ID: <CAFLszTh8azMKW7jmQF8sY-mCkWCPZnP6U=evRPV5hVMO9DdneA@mail.gmail.com>
Subject: Re: [PATCH] bootstd: Allow PXE boot to be disabled
To: Tony Dinh <mibodhi@gmail.com>
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

Hi Tony,

On Sat, 11 Oct 2025 at 20:41, Tony Dinh <mibodhi@gmail.com> wrote:
>
> On Sat, Oct 11, 2025 at 7:37=E2=80=AFAM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Sat, Oct 11, 2025 at 01:03:39PM +0100, Peter Robinson wrote:
> > > On Fri, 10 Oct 2025 at 15:28, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Oct 09, 2025 at 10:29:17PM -0700, Tony Dinh wrote:
> > > >
> > > > > Make it possible to disable CMD_PXE.
> > > > > Remove unnecessary PXE_UTILS selection in BOOTMETH_EXTLINUX confi=
g.
> > > > > In extlinux_boot(), invoke pxe utils only when
> > > > > CONFIG_BOOTMETH_EXTLINUX_PXE is enabled.
> > > > >
> > > > > This patch results in about 9K reduction in image size when
> > > > > PXE boot is disabled.
> > > > >
> > > > > Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> > > > > ---
> > > > >
> > > > >  boot/Kconfig             |  3 +--
> > > > >  boot/bootmeth_extlinux.c | 18 ++++++++++--------
> > > > >  2 files changed, 11 insertions(+), 10 deletions(-)
> > > >
> > > > Is some part of the symbol logic here wrong? A challenge is that "P=
XE"
> > > > is also where the logic to parse extlinux.conf style files came fro=
m,
> > > > and I thought we had split those two out. And then there's this:
> > > >
> > > > >
> > > > > diff --git a/boot/Kconfig b/boot/Kconfig
> > > > > index 2993cd7f9ba..403ce4c3d46 100644
> > > > > --- a/boot/Kconfig
> > > > > +++ b/boot/Kconfig
> > > > > @@ -421,10 +421,10 @@ config BOOT_DEFAULTS_CMDS
> > > > >       select CMD_PART if PARTITIONS
> > > > >       select CMD_DHCP if CMD_NET
> > > > >       select CMD_PING if CMD_NET
> > > > > -     select CMD_PXE if CMD_NET
> > > > >       select CMD_BOOTI if ARM64
> > > > >       select CMD_BOOTZ if ARM && !ARM64
> > > > >       imply CMD_MII if NET
> > > > > +     imply CMD_PXE if CMD_NET

If you only want scripts, then perhaps you can enable just what you
need, e.g. BOOTMETH_SCRIPT? You may need to disable BOOT_DEFAULTS and
choose your own options.

> > > >
> > > > This is one of the things where defaults isn't supposed to be so ea=
sy to
> > > > get out of. How many platforms are you wanting to then disable CMD_=
PXE
> > > > on to save space?
> > >
> > > PXE is generally being removed in a lot of cases as it's not
> > > considered secure and now we have HTTP Boot there are other means of
> > > doing network booting so I think we'll see more and more situations
> > > where we want to disable PXE.
> > >
> > > This is actually something I've been meaning to look at so it's
> > > something I would love to see :)
>
> Glad to hear :)
>
> >
> > And in the world where we also can't just remove ATAGS support because
> > distros (Debian at least) still boots some modern platforms via ATAGS +
> > appended device tree, the high level options for "boot this anywhere"
> > need to perhaps be different from "very modern requirements only
> > distro". I'm not objecting to be clear.
>
> As Tom suggested previously, perhaps looking from a different angle.
> We can disable BOOTSTD_FULL and then try adding only options that are
> needed for a board. Unfortunately this approach did not work when I
> tried it in the past. It seems for bootstd to work well, we need to
> take the whole thing by enabling BOOTSTD_FULL.

If you end up trying it again, please give a few details here as we
might be able to improve this. When bootstd was first introduced we
had very tight code-size constraints, so quite a few features are only
provided if BOOTSTD_FULL is enabled. Tom has suggested enabling more
features in the base implementation but we haven't really figured out
which.

Regards,
Simon
