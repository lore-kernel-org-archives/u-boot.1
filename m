Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C64FBCCD184
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 03:19:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE2FA807B1;
	Tue, 14 Oct 2025 05:19:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jiFZoaxi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96B3F809A5; Tue, 14 Oct 2025 05:19:08 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CD9C802C1
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 05:19:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-634cef434beso9136678a12.1
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 20:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760411946; x=1761016746; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C4/1gl91myj+ZJQFwnO4MblaXXSm2gn7Ig9iLnAjcB0=;
 b=jiFZoaxiEIDR/VNFxcrQv7V7o0Ou7GHoPXgAjs7ZAos5KbffLrwehfFoc/L0b2IW8I
 824UEtGRKEPweEYfYTV0eqbKLWECes8JKDPLAU9xn3FkxQbEsscChR54LnSBmu7aEpkJ
 OMeJvpQalGqzYALJa9yAorlwwakCfrl0ofbXcyI4nDnmxynL8mM0BK+P/nHhNA6TmcEC
 hBDiYDZMQbzDBY0usi+qbwz25530mRp1RKQ+OSeJN2j+6+u/9DMsq1gq3Y5wHXRhGJSN
 l1EJzxrkQhVwYI4fW3is9ZDLh2kLvZQEJ6uJ2fFPm6ak18M4Ss1WqUn54t3K0VGZ/Wi7
 6p0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760411946; x=1761016746;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C4/1gl91myj+ZJQFwnO4MblaXXSm2gn7Ig9iLnAjcB0=;
 b=M+IEDqnqc/UKsp7LP0dJlU1CDlpPhsfNT7HttvkYYzk9OS3YRyWr9n/0/YEff2YP7F
 6n2lAbGRQXkkIZ048/H9OYGR6yIxO19sr/CCLaGuM2xrGaIyFrcROY9VOfXjp8FEyKCc
 P9kPxqrMoRKUDLFTJ5jz2/+0lqGZZ53UhgQsGu3k7ITq0cIA/LApSfKvlaerhipJ2NTP
 uTk6a5NrU7xP6X3qwaOqGneZAyEFx9ZTNMyOOMT7xeXasCO1XT9IQzhzbjwgFC2GdBiv
 mxyCcWAAf0wA9QaxezpZitBtq7pnLncVkPA4mV188/hX1Fc5OCHb1MZIkdoi+XrxcnxA
 GQqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuvEbgMWduuEkstzfPTBQ2eK+fyipN9k9oA3iS/in9End0w2BiEtdKd8UwQQtUwKq81obgYyk=@lists.denx.de
X-Gm-Message-State: AOJu0Ywfx0tAjZPlOlVHTKEogaD2mGC76cPmBL9hnXtCmq1dlu7B/eLt
 xhx3cqWx4Ofd7GsMr76EFcTJmooBr3c/BvNlTA7d6GTMY7DswvdUhaCuv+irw9uFZ0uXlmyw5Sn
 n9TE2Q8DzD/H2hlOSYnWEAfW6h2eBi7Y=
X-Gm-Gg: ASbGncsM5F3I49Y4GdMjrBdg6cyUQaAy7aiZ80so7Gea0XXEcS3Qum0gXhFmCd7QWaW
 n1lOLAJS3hgrIfZkWGenUqCKuFpcfd4fQMngff5Ps+hqPq7VTwb6hjCzkTei605LU+QKEq6jmuR
 ujBAB4TbzeLyUjStQ4q4jAn7dhScQaHifTQ6FtfbKORXxcKeGVV2sqrwoXEFc+rTPEVIJSZfB6J
 O/a8agjD7js6Re3HaA0aRYsTyhjGvrpM/w+WA==
X-Google-Smtp-Source: AGHT+IG4Ap4yxBbzX+gP8mscx568Nm2M5adnwrPMO+T9vExGR7UCeBQJVghwO/cocThGVjZJWdGkI9FOGuTsX0sYB+8=
X-Received: by 2002:a05:6402:2547:b0:634:11d7:f70c with SMTP id
 4fb4d7f45d1cf-639d5fc0224mr23572925a12.2.1760411945508; Mon, 13 Oct 2025
 20:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20251010053056.32495-1-mibodhi@gmail.com>
 <20251010142835.GY298503@bill-the-cat>
 <CALeDE9P8VP6YKS1qoz3Dxga+h287GHzRvczCq0YDd4tOJxNXGQ@mail.gmail.com>
 <20251011143713.GI298503@bill-the-cat>
 <CAJaLiFyNCD1i_3=y_jF6Kyj8jGpAY3qwBwO=DMxB=BFGc-oXoQ@mail.gmail.com>
 <CAFLszTh8azMKW7jmQF8sY-mCkWCPZnP6U=evRPV5hVMO9DdneA@mail.gmail.com>
 <CAJaLiFwHfrw4Fg16vH3RPD1PDqQMaA=tmecaf8CUi8cNE9D4Bg@mail.gmail.com>
 <20251013144016.GG6113@bill-the-cat>
 <CAJaLiFz-UQfHgsvB59kYGW0=tiKzKeN7bHYH5hZrVDFKRGOrFQ@mail.gmail.com>
 <CAJaLiFxJooQWQUyjAZWViYVqJN4g53N73EQVH-SJnW8rLHnCVg@mail.gmail.com>
In-Reply-To: <CAJaLiFxJooQWQUyjAZWViYVqJN4g53N73EQVH-SJnW8rLHnCVg@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Mon, 13 Oct 2025 20:18:53 -0700
X-Gm-Features: AS18NWAMiDlsNfs6k0NlBGq4vg_Xef4JtobLtKXBxeAiATzCiItIIYVGzrKXLBU
Message-ID: <CAJaLiFyDDq86dQYHpiiK2XtZWV9LiW_oTQ0+Oqi4FwCnA7tbyg@mail.gmail.com>
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

On Mon, Oct 13, 2025 at 4:24=E2=80=AFPM Tony Dinh <mibodhi@gmail.com> wrote=
:
>
> Hi all,
>
> On Mon, Oct 13, 2025 at 2:17=E2=80=AFPM Tony Dinh <mibodhi@gmail.com> wro=
te:
> >
> > Hi Tom,
> >
> > On Mon, Oct 13, 2025 at 7:40=E2=80=AFAM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Sun, Oct 12, 2025 at 08:12:59PM -0700, Tony Dinh wrote:
> > > > Hi Simon,
> > > >
> > > > On Sat, Oct 11, 2025 at 11:52=E2=80=AFPM Simon Glass <sjg@chromium.=
org> wrote:
> > > > >
> > > > > Hi Tony,
> > > > >
> > > > > On Sat, 11 Oct 2025 at 20:41, Tony Dinh <mibodhi@gmail.com> wrote=
:
> > > > > >
> > > > > > On Sat, Oct 11, 2025 at 7:37=E2=80=AFAM Tom Rini <trini@konsulk=
o.com> wrote:
> > > > > > >
> > > > > > > On Sat, Oct 11, 2025 at 01:03:39PM +0100, Peter Robinson wrot=
e:
> > > > > > > > On Fri, 10 Oct 2025 at 15:28, Tom Rini <trini@konsulko.com>=
 wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Oct 09, 2025 at 10:29:17PM -0700, Tony Dinh wrote=
:
> > > > > > > > >
> > > > > > > > > > Make it possible to disable CMD_PXE.
> > > > > > > > > > Remove unnecessary PXE_UTILS selection in BOOTMETH_EXTL=
INUX config.
> > > > > > > > > > In extlinux_boot(), invoke pxe utils only when
> > > > > > > > > > CONFIG_BOOTMETH_EXTLINUX_PXE is enabled.
> > > > > > > > > >
> > > > > > > > > > This patch results in about 9K reduction in image size =
when
> > > > > > > > > > PXE boot is disabled.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> > > > > > > > > > ---
> > > > > > > > > >
> > > > > > > > > >  boot/Kconfig             |  3 +--
> > > > > > > > > >  boot/bootmeth_extlinux.c | 18 ++++++++++--------
> > > > > > > > > >  2 files changed, 11 insertions(+), 10 deletions(-)
> > > > > > > > >
> > > > > > > > > Is some part of the symbol logic here wrong? A challenge =
is that "PXE"
> > > > > > > > > is also where the logic to parse extlinux.conf style file=
s came from,
> > > > > > > > > and I thought we had split those two out. And then there'=
s this:
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > diff --git a/boot/Kconfig b/boot/Kconfig
> > > > > > > > > > index 2993cd7f9ba..403ce4c3d46 100644
> > > > > > > > > > --- a/boot/Kconfig
> > > > > > > > > > +++ b/boot/Kconfig
> > > > > > > > > > @@ -421,10 +421,10 @@ config BOOT_DEFAULTS_CMDS
> > > > > > > > > >       select CMD_PART if PARTITIONS
> > > > > > > > > >       select CMD_DHCP if CMD_NET
> > > > > > > > > >       select CMD_PING if CMD_NET
> > > > > > > > > > -     select CMD_PXE if CMD_NET
> > > > > > > > > >       select CMD_BOOTI if ARM64
> > > > > > > > > >       select CMD_BOOTZ if ARM && !ARM64
> > > > > > > > > >       imply CMD_MII if NET
> > > > > > > > > > +     imply CMD_PXE if CMD_NET
> > > > >
> > > > > If you only want scripts, then perhaps you can enable just what y=
ou
> > > > > need, e.g. BOOTMETH_SCRIPT? You may need to disable BOOT_DEFAULTS=
 and
> > > > > choose your own options.
> > > >
> > > > Indeed, that was a missing config when I tried with BOOTSTD_FULL
> > > > disabled. But there is more, please see below.
> > > >
> > > > >
> > > > > > > > >
> > > > > > > > > This is one of the things where defaults isn't supposed t=
o be so easy to
> > > > > > > > > get out of. How many platforms are you wanting to then di=
sable CMD_PXE
> > > > > > > > > on to save space?
> > > > > > > >
> > > > > > > > PXE is generally being removed in a lot of cases as it's no=
t
> > > > > > > > considered secure and now we have HTTP Boot there are other=
 means of
> > > > > > > > doing network booting so I think we'll see more and more si=
tuations
> > > > > > > > where we want to disable PXE.
> > > > > > > >
> > > > > > > > This is actually something I've been meaning to look at so =
it's
> > > > > > > > something I would love to see :)
> > > > > >
> > > > > > Glad to hear :)
> > > > > >
> > > > > > >
> > > > > > > And in the world where we also can't just remove ATAGS suppor=
t because
> > > > > > > distros (Debian at least) still boots some modern platforms v=
ia ATAGS +
> > > > > > > appended device tree, the high level options for "boot this a=
nywhere"
> > > > > > > need to perhaps be different from "very modern requirements o=
nly
> > > > > > > distro". I'm not objecting to be clear.
> > > > > >
> > > > > > As Tom suggested previously, perhaps looking from a different a=
ngle.
> > > > > > We can disable BOOTSTD_FULL and then try adding only options th=
at are
> > > > > > needed for a board. Unfortunately this approach did not work wh=
en I
> > > > > > tried it in the past. It seems for bootstd to work well, we nee=
d to
> > > > > > take the whole thing by enabling BOOTSTD_FULL.
> > > > >
> > > > > If you end up trying it again, please give a few details here as =
we
> > > > > might be able to improve this. When bootstd was first introduced =
we
> > > > > had very tight code-size constraints, so quite a few features are=
 only
> > > > > provided if BOOTSTD_FULL is enabled. Tom has suggested enabling m=
ore
> > > > > features in the base implementation but we haven't really figured=
 out
> > > > > which.
> > > >
> > > > The problem is when a board already has enabled BOOTSTD_FULL or has
> > > > been updated with Distro Boot (CONFIG_DISTRO_DEFAULTS), all the
> > > > necessary configurations such as ext2, ext4, efi partition,... are
> > > > implied, therefore were removed from board defconfig. They must be
> > > > added back.
> > > >
> > > > I actually tried this just now and it does work booting a script fr=
om
> > > > USB drive with this combination:
> > > >
> > > > CONFIG_BOOTMETH_SCRIPT=3Dy
> > > > CONFIG_DISTRO_DEFAULTS=3Dy    (this also selects CMD_PXE, but it's =
OK
> > > > for this test)
> > > > # CONFIG_BOOTSTD_FULL is not set
> > > >
> > > > I think it's quite cumbersome to add each of the necessary configs
> > > > back to the board defconfig. Not as easy as removing CMD_PXE, or ot=
her
> > > > CMD_x to remove a capability.
> > >
> > > There's two parts to this. In turns of changing the defconfig to star=
t
> > > with, you shouldn't need to "add back", if you do:
> > > $ make foo_defconfig
> > > $ make menuconfig # Disable full, etc
> > > $ make savedefconfig
> > > $ cp defconfig configs/foo_defconfig
> >
> > Of course you're right! "make menuconfig" works as described above.
> >
> > Thanks,
> > Tony
> >
> > >
> > > But the second part is that yes, it's at least currently intentional =
to
> > > be cumbersome to break the "all stock distributions work in all expec=
ted
> > > use cases" option. If you have networking, networking works in U-Boot=
,
> > > but you're not allowing users to install distros over the network lik=
e
> > > they should be able to expect to, it shouldn't be easy.
> > >
> > > I am open to splitting the current option up in to multiple parts, al=
ong
> > > the lines of legacy options, modern options, disk options, network
> > > options since as Peter noted earlier in this thread, PXE is going awa=
y
> > > in favour of HTTP(s) boot. But we still have lots of legacy boards an=
d
> > > distros to support.
> > >
>
> I'm withdrawing this patch.

Sorry for forgetting to mention, I will send in a new patch to deal
with pxe_utils.

All the best,
Tony

> Using the Kconfig approach Tom and Simon have suggested, I was able to
> remove PXE and include only the BOOTMETH_SCRIPT for block devices in
> bootstd. My test case using the pogo_v4 board showed a saving of 17K
> (before: 508K, after 491K).
>
> IMHO, we should still pursue the worthy goal of "splitting the current
> options up into multiple parts". That will make u-boot configuration
> much more robust.
>
> For posterity, here is the Kconfig test using board/cloudengines/pogo_v4.
>
> diff --git a/configs/pogo_v4_defconfig b/configs/pogo_v4_defconfig
> index 1c0e0de8d4f..aaaa3fd51f2 100644
> --- a/configs/pogo_v4_defconfig
> +++ b/configs/pogo_v4_defconfig
> @@ -17,15 +17,23 @@ CONFIG_SYS_LOAD_ADDR=3D0x800000
>  CONFIG_IDENT_STRING=3D"\nPogoplug V4"
>  CONFIG_PCI=3Dy
>  CONFIG_LTO=3Dy
> -CONFIG_BOOTSTD_FULL=3Dy
> +CONFIG_ENV_VARS_UBOOT_CONFIG=3Dy
> +CONFIG_BOOTMETH_SCRIPT=3Dy
> +CONFIG_SUPPORT_RAW_INITRD=3Dy
>  CONFIG_BOOTSTAGE=3Dy
>  CONFIG_SHOW_BOOT_PROGRESS=3Dy
>  CONFIG_BOOTDELAY=3D10
> +CONFIG_USE_BOOTCOMMAND=3Dy
> +CONFIG_BOOTCOMMAND=3D"bootflow scan"
>  CONFIG_USE_PREBOOT=3Dy
>  CONFIG_SYS_PBSIZE=3D1050
>  CONFIG_BOARD_LATE_INIT=3Dy
>  CONFIG_SYS_PROMPT=3D"Pogo_V4> "
>  CONFIG_SYS_MAXARGS=3D32
> +CONFIG_CMD_BOOTDEV=3Dy
> +CONFIG_CMD_BOOTMETH=3Dy
> +CONFIG_CMD_BOOTSTD=3Dy
> +CONFIG_CMD_BOOTZ=3Dy
>  # CONFIG_BOOTM_PLAN9 is not set
>  # CONFIG_BOOTM_RTEMS is not set
>  # CONFIG_BOOTM_VXWORKS is not set
> @@ -35,16 +43,26 @@ CONFIG_SYS_MAXARGS=3D32
>  CONFIG_CMD_MMC=3Dy
>  CONFIG_CMD_MTD=3Dy
>  CONFIG_CMD_NAND=3Dy
> +CONFIG_CMD_PART=3Dy
>  CONFIG_CMD_PCI=3Dy
>  CONFIG_CMD_SATA=3Dy
>  CONFIG_CMD_USB=3Dy
> +CONFIG_CMD_DHCP=3Dy
>  CONFIG_CMD_DNS=3Dy
> +CONFIG_CMD_MII=3Dy
> +CONFIG_CMD_PING=3Dy
>  CONFIG_CMD_SNTP=3Dy
>  # CONFIG_CMD_BLOCK_CACHE is not set
> +CONFIG_CMD_EXT2=3Dy
> +CONFIG_CMD_EXT4=3Dy
> +CONFIG_CMD_FAT=3Dy
> +CONFIG_CMD_FS_GENERIC=3Dy
>  CONFIG_CMD_MTDPARTS=3Dy
>  CONFIG_MTDIDS_DEFAULT=3D"nand0=3Dorion_nand"
>  CONFIG_MTDPARTS_DEFAULT=3D"mtdparts=3Dorion_nand:2M(u-boot),3M(uImage),3=
M(uImage2),8M(failsafe),112M(root)"
>  CONFIG_CMD_UBI=3Dy
> +CONFIG_ISO_PARTITION=3Dy
> +CONFIG_EFI_PARTITION=3Dy
>  CONFIG_PARTITION_TYPE_GUID=3Dy
>  CONFIG_OF_CONTROL=3Dy
>  CONFIG_ENV_OVERWRITE=3Dy
> @@ -72,4 +90,5 @@ CONFIG_USB=3Dy
>  CONFIG_USB_XHCI_HCD=3Dy
>  CONFIG_USB_XHCI_PCI=3Dy
>  CONFIG_USB_EHCI_HCD=3Dy
> +CONFIG_USB_STORAGE=3Dy
>  CONFIG_UBIFS_SILENCE_MSG=3Dy
>
> All the best,
> Tony
