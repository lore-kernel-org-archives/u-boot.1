Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00118CCD185
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 06:08:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 366FC8383F;
	Mon, 13 Oct 2025 08:08:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NmdTOx8T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21BDB8384E; Mon, 13 Oct 2025 08:08:53 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5717E8383E
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 08:08:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-62fa062a1abso7113582a12.2
 for <u-boot@lists.denx.de>; Sun, 12 Oct 2025 23:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760335730; x=1760940530; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nR8Q5CsdlfmXQ17SQF1IcNfgcdQ0nn2gefaWEZXYM5A=;
 b=NmdTOx8TwD24W3avoB9hEptx3LfdUtYZax3wLkhhMNv8tLTblIP0wu6RFta2NyXbM5
 57e0reFf2Cs6MIHV96NDezJ1+UCNiLt30SrDMD6YJOYaV5H/b15FkjzZFDrEcE3blkU3
 iINHM8Suee9brJctfu9boWHcn87lYpCbFJzd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760335730; x=1760940530;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nR8Q5CsdlfmXQ17SQF1IcNfgcdQ0nn2gefaWEZXYM5A=;
 b=p4cf/R1vYqovlI4vlMB7LtCP3TkyNdbBuICPpnEAXY/DaeCOGkgcH3Tz3BrnZasllG
 yyPTyeSUe4CCvFiP/MwSekWxYZr5tHrnPvY4bMCetKFIYBP6vA/DJ0+PIL+ve+oK+jzf
 YEPcH6C9R+BVMF9xH/a1LAt4oi6+xsD5AtwyQUM3UpCOK/7J1MfEcJE1s6D9YSv19bmT
 TfLfvKEQyiJP1tO+u9aaO1PRe4HTvgFuLZSG54R/P/3Av3UWiU9XkZ/rjcjvq4UptXMd
 yeXmWaLN5Sele/JFN/fL+64tGtErzeqyn3ZE/azRNj+kcKjMHD/WSoWdg4fLrV78f1Xh
 rH4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVu8CsrBx53lXKjRC8el9kI5GStw9/OduBqw9TnLdKWDHsgZrdouenxRqZW1nfjiu/KUIDn2m4=@lists.denx.de
X-Gm-Message-State: AOJu0Yy6mV2NUa5gnfUuap5xS1/XPYV2Gcne716umjjZ7FWqGVozZcDK
 xGkTQdhlup+sgX4xf1oKI/KGn4dLWbI3S6wLcZSZhs1yXuA8ZFvBVIQWhgGwPAA9g+W+yr4Sj84
 zMJv5Kb2WddjlaNEkLoLjSaYdZJaGcYN2H9z6k24t
X-Gm-Gg: ASbGncuLyd0U/jhu5L5eZPCbDom/kuVOXWrIZK1bdkGuqG8T4uaNNnOxIZY4ylfrRZB
 JUFM+EELOuErJZI57DpoAN2qXy4z+fkYYFPdOgHADccYXHDuPe9wbekauGT/zFTTe/n/EV3sNU/
 W2g7c0E47KavI5gjhGs+2jg+A919dw7vzSG/oAXh3fdckVXV4YlCX8LcNfqtW8O3jUA5JmJBmo6
 Tvy5S5EvumZRiKmYq97FdJrMOU=
X-Google-Smtp-Source: AGHT+IEoZdktknK/06So2rRWPS1BF16j2IeAKLyYVFf5/oCPzNA0Vb6cfBDUpACFlluCiAdMCh1CjDvOrbRRl4ipo9M=
X-Received: by 2002:a05:6402:13d0:b0:639:f4ac:c1cf with SMTP id
 4fb4d7f45d1cf-639f4ace041mr13459352a12.37.1760335729749; Sun, 12 Oct 2025
 23:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20251010053056.32495-1-mibodhi@gmail.com>
 <20251010142835.GY298503@bill-the-cat>
 <CALeDE9P8VP6YKS1qoz3Dxga+h287GHzRvczCq0YDd4tOJxNXGQ@mail.gmail.com>
 <20251011143713.GI298503@bill-the-cat>
 <CAJaLiFyNCD1i_3=y_jF6Kyj8jGpAY3qwBwO=DMxB=BFGc-oXoQ@mail.gmail.com>
 <CAFLszTh8azMKW7jmQF8sY-mCkWCPZnP6U=evRPV5hVMO9DdneA@mail.gmail.com>
 <CAJaLiFwHfrw4Fg16vH3RPD1PDqQMaA=tmecaf8CUi8cNE9D4Bg@mail.gmail.com>
In-Reply-To: <CAJaLiFwHfrw4Fg16vH3RPD1PDqQMaA=tmecaf8CUi8cNE9D4Bg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Oct 2025 07:08:37 +0100
X-Gm-Features: AS18NWDhsvEi96Gf3G_HxvX_SqoGJZwygktFg1lHxWuxhKW1MbP5sFAPKvBuPL0
Message-ID: <CAFLszTgvwOvdx4tmRbk51kSOEkP8qod7npyzYsvUfnsMafLViA@mail.gmail.com>
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

On Mon, 13 Oct 2025 at 04:13, Tony Dinh <mibodhi@gmail.com> wrote:
>
> Hi Simon,
>
> On Sat, Oct 11, 2025 at 11:52=E2=80=AFPM Simon Glass <sjg@chromium.org> w=
rote:
> >
> > Hi Tony,
> >
> > On Sat, 11 Oct 2025 at 20:41, Tony Dinh <mibodhi@gmail.com> wrote:
> > >
> > > On Sat, Oct 11, 2025 at 7:37=E2=80=AFAM Tom Rini <trini@konsulko.com>=
 wrote:
> > > >
> > > > On Sat, Oct 11, 2025 at 01:03:39PM +0100, Peter Robinson wrote:
> > > > > On Fri, 10 Oct 2025 at 15:28, Tom Rini <trini@konsulko.com> wrote=
:
> > > > > >
> > > > > > On Thu, Oct 09, 2025 at 10:29:17PM -0700, Tony Dinh wrote:
> > > > > >
> > > > > > > Make it possible to disable CMD_PXE.
> > > > > > > Remove unnecessary PXE_UTILS selection in BOOTMETH_EXTLINUX c=
onfig.
> > > > > > > In extlinux_boot(), invoke pxe utils only when
> > > > > > > CONFIG_BOOTMETH_EXTLINUX_PXE is enabled.
> > > > > > >
> > > > > > > This patch results in about 9K reduction in image size when
> > > > > > > PXE boot is disabled.
> > > > > > >
> > > > > > > Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> > > > > > > ---
> > > > > > >
> > > > > > >  boot/Kconfig             |  3 +--
> > > > > > >  boot/bootmeth_extlinux.c | 18 ++++++++++--------
> > > > > > >  2 files changed, 11 insertions(+), 10 deletions(-)
> > > > > >
> > > > > > Is some part of the symbol logic here wrong? A challenge is tha=
t "PXE"
> > > > > > is also where the logic to parse extlinux.conf style files came=
 from,
> > > > > > and I thought we had split those two out. And then there's this=
:
> > > > > >
> > > > > > >
> > > > > > > diff --git a/boot/Kconfig b/boot/Kconfig
> > > > > > > index 2993cd7f9ba..403ce4c3d46 100644
> > > > > > > --- a/boot/Kconfig
> > > > > > > +++ b/boot/Kconfig
> > > > > > > @@ -421,10 +421,10 @@ config BOOT_DEFAULTS_CMDS
> > > > > > >       select CMD_PART if PARTITIONS
> > > > > > >       select CMD_DHCP if CMD_NET
> > > > > > >       select CMD_PING if CMD_NET
> > > > > > > -     select CMD_PXE if CMD_NET
> > > > > > >       select CMD_BOOTI if ARM64
> > > > > > >       select CMD_BOOTZ if ARM && !ARM64
> > > > > > >       imply CMD_MII if NET
> > > > > > > +     imply CMD_PXE if CMD_NET
> >
> > If you only want scripts, then perhaps you can enable just what you
> > need, e.g. BOOTMETH_SCRIPT? You may need to disable BOOT_DEFAULTS and
> > choose your own options.
>
> Indeed, that was a missing config when I tried with BOOTSTD_FULL
> disabled. But there is more, please see below.
>
> >
> > > > > >
> > > > > > This is one of the things where defaults isn't supposed to be s=
o easy to
> > > > > > get out of. How many platforms are you wanting to then disable =
CMD_PXE
> > > > > > on to save space?
> > > > >
> > > > > PXE is generally being removed in a lot of cases as it's not
> > > > > considered secure and now we have HTTP Boot there are other means=
 of
> > > > > doing network booting so I think we'll see more and more situatio=
ns
> > > > > where we want to disable PXE.
> > > > >
> > > > > This is actually something I've been meaning to look at so it's
> > > > > something I would love to see :)
> > >
> > > Glad to hear :)
> > >
> > > >
> > > > And in the world where we also can't just remove ATAGS support beca=
use
> > > > distros (Debian at least) still boots some modern platforms via ATA=
GS +
> > > > appended device tree, the high level options for "boot this anywher=
e"
> > > > need to perhaps be different from "very modern requirements only
> > > > distro". I'm not objecting to be clear.
> > >
> > > As Tom suggested previously, perhaps looking from a different angle.
> > > We can disable BOOTSTD_FULL and then try adding only options that are
> > > needed for a board. Unfortunately this approach did not work when I
> > > tried it in the past. It seems for bootstd to work well, we need to
> > > take the whole thing by enabling BOOTSTD_FULL.
> >
> > If you end up trying it again, please give a few details here as we
> > might be able to improve this. When bootstd was first introduced we
> > had very tight code-size constraints, so quite a few features are only
> > provided if BOOTSTD_FULL is enabled. Tom has suggested enabling more
> > features in the base implementation but we haven't really figured out
> > which.
>
> The problem is when a board already has enabled BOOTSTD_FULL or has
> been updated with Distro Boot (CONFIG_DISTRO_DEFAULTS), all the
> necessary configurations such as ext2, ext4, efi partition,... are
> implied, therefore were removed from board defconfig. They must be
> added back.
>
> I actually tried this just now and it does work booting a script from
> USB drive with this combination:
>
> CONFIG_BOOTMETH_SCRIPT=3Dy
> CONFIG_DISTRO_DEFAULTS=3Dy    (this also selects CMD_PXE, but it's OK
> for this test)
> # CONFIG_BOOTSTD_FULL is not set
>
> I think it's quite cumbersome to add each of the necessary configs
> back to the board defconfig. Not as easy as removing CMD_PXE, or other
> CMD_x to remove a capability.

Yes I agree, it is cumbersome.

The problem is that if you don't enable building pxe_setup_ctx() then
it really doesn't make sense to enable bootmeth_extlinux since you
cannot actually boot.

Changing from imply to select seems OK to me as it provides
flexibility. As you say it allows disabling things piecemeal rather
than starting from scratch and having to enable many individual
options to get back to a booting system.

But there are disadvantages too. There was quite a lot of discussion
leading to the way it is now, e.g. [1]

I think we should wait for Tom to weigh in again here.

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20230221193920.3546499=
-2-sjg@chromium.org/#3063438
