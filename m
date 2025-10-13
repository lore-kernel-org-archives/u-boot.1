Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DFDCCD185
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 23:24:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 605A183710;
	Tue, 14 Oct 2025 01:24:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D6UG75+w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 700D4837E2; Tue, 14 Oct 2025 01:24:27 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41D01836C8
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 01:24:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-63b9da76e42so3289998a12.0
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 16:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760397865; x=1761002665; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xSN9jww2YZVZ2mIBuMuwb1PRGxy6Ps2P3TIw5UDAp7U=;
 b=D6UG75+wkgHyG4RBJIuSEWdPnPi6tJOE+cX5WFEk3NF6KLgNCJQAsIV5rJhyJ6owPQ
 p1N8c+mkseynMz4utP5PqkVpMC/hzmzX0Lgz93zYturqq+AI3NRJ4xHxtZzMZOWZS6VF
 qxQfqNAuDmS73XEB+EAfhkzBED0weOZ1BxpKJFvcU1e5oF8M73pEGkJICYVR5mx7wZ33
 jTOauMgeztOI5agzqL/d2Ww9zn3GVY3LsGCMxO+4hUs0R75fxHnagu3NjQt2sHXbiV+h
 /oYar7G2FGr7FHmajNvne0/v9Uuua4+VUFWZ9Z7j2NqNZU8AkAFVJChtI++z1+Nw4Vj3
 2bRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760397865; x=1761002665;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xSN9jww2YZVZ2mIBuMuwb1PRGxy6Ps2P3TIw5UDAp7U=;
 b=fc0i54637SyInOgBEfc9AWOtQRsLCdXohZ35ShiUEcMy0KXjjfy0HXJrk9wI9MbV2O
 Vxi4JgQXqTkyWjTIMVrGUW2Ngit0VeZ2bwQV3LwYI4KPtRtqwJDxrToViJ+XnnIty5j8
 iaM1Hoe0v4URW51ZgdtyCsDlYtmLeGtGpGO0LKOrRpyaE+2X3F7V2CrQ++aDLGyx1S69
 FrVO7arJi/f1plr/xpgiFnvp8O8ahbbq1pFTBqzq3+JQySNK3Tt0jrwyYyHYtjnG+J4v
 j2XRUOBEapn/vjV3Hrdf/q8/+6aOADzwfSPEnmC/i2yrJbKpdbphQy1VD6xKA+vLcZg6
 5a+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYL6XN3y1KhVLxNQ2tgDx+jc6OyBncOw1nPbJBD/YHMvmsW7Syhe6h+OiA+fwdppDzhSx1HL8=@lists.denx.de
X-Gm-Message-State: AOJu0YzVuyDN9UXZhWBvTSc+YLw6D5teTiGWP5TdXUke+fdFxdrVF1T6
 YPEIcVD2GkbH0iRWn8zXNA6q33c+9L4ELsuhX5HhxdFw0DT+7P40A0/uFA5a0cQLTT4cNUFxL+O
 ScwuAis5KCZ23U0PbsCXFX+1Q64c2Jwo=
X-Gm-Gg: ASbGncuC/4D+TMIKDfVT8JMwBhDBC/Rqe4dQ2RPqyiIS/7DXUSLmBy4VLHE+ToM5lxE
 XDj2iXgl40vCT4DtW0S0PrUDS5wsOJDZxdvoJoWVo7gUd5n9ko5kgK1niHVq51VK0tdGprGcRi7
 XP+2gqT0Q1d6+tWiaB2AtVqTTv32KTTGJnvA2aRAISpfJ6i7wFKcAncxLrN8DqMjeFsW8AW6QFQ
 FjC0H1mQ3xzbpNtggUDRg/QbbJ4jINT0iO5icZCBKsa6m3N
X-Google-Smtp-Source: AGHT+IHTAuOa/rzTbNs35uolQ4WSklgvmoNA+LAxfNs0xzuoyq04M4iHmuDzjD0W/DkGGcorAdmCjhuzCFxh7hJvsVA=
X-Received: by 2002:a05:6402:4402:b0:639:e580:6335 with SMTP id
 4fb4d7f45d1cf-639e58068ccmr17864537a12.2.1760397864357; Mon, 13 Oct 2025
 16:24:24 -0700 (PDT)
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
In-Reply-To: <CAJaLiFz-UQfHgsvB59kYGW0=tiKzKeN7bHYH5hZrVDFKRGOrFQ@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Mon, 13 Oct 2025 16:24:12 -0700
X-Gm-Features: AS18NWDwA4xz3ZaanlYmkiUtz5va5URoqXfuH-vzFtlYJdakQr2LDF1m_0hXO-c
Message-ID: <CAJaLiFxJooQWQUyjAZWViYVqJN4g53N73EQVH-SJnW8rLHnCVg@mail.gmail.com>
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

Hi all,

On Mon, Oct 13, 2025 at 2:17=E2=80=AFPM Tony Dinh <mibodhi@gmail.com> wrote=
:
>
> Hi Tom,
>
> On Mon, Oct 13, 2025 at 7:40=E2=80=AFAM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Sun, Oct 12, 2025 at 08:12:59PM -0700, Tony Dinh wrote:
> > > Hi Simon,
> > >
> > > On Sat, Oct 11, 2025 at 11:52=E2=80=AFPM Simon Glass <sjg@chromium.or=
g> wrote:
> > > >
> > > > Hi Tony,
> > > >
> > > > On Sat, 11 Oct 2025 at 20:41, Tony Dinh <mibodhi@gmail.com> wrote:
> > > > >
> > > > > On Sat, Oct 11, 2025 at 7:37=E2=80=AFAM Tom Rini <trini@konsulko.=
com> wrote:
> > > > > >
> > > > > > On Sat, Oct 11, 2025 at 01:03:39PM +0100, Peter Robinson wrote:
> > > > > > > On Fri, 10 Oct 2025 at 15:28, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Thu, Oct 09, 2025 at 10:29:17PM -0700, Tony Dinh wrote:
> > > > > > > >
> > > > > > > > > Make it possible to disable CMD_PXE.
> > > > > > > > > Remove unnecessary PXE_UTILS selection in BOOTMETH_EXTLIN=
UX config.
> > > > > > > > > In extlinux_boot(), invoke pxe utils only when
> > > > > > > > > CONFIG_BOOTMETH_EXTLINUX_PXE is enabled.
> > > > > > > > >
> > > > > > > > > This patch results in about 9K reduction in image size wh=
en
> > > > > > > > > PXE boot is disabled.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> > > > > > > > > ---
> > > > > > > > >
> > > > > > > > >  boot/Kconfig             |  3 +--
> > > > > > > > >  boot/bootmeth_extlinux.c | 18 ++++++++++--------
> > > > > > > > >  2 files changed, 11 insertions(+), 10 deletions(-)
> > > > > > > >
> > > > > > > > Is some part of the symbol logic here wrong? A challenge is=
 that "PXE"
> > > > > > > > is also where the logic to parse extlinux.conf style files =
came from,
> > > > > > > > and I thought we had split those two out. And then there's =
this:
> > > > > > > >
> > > > > > > > >
> > > > > > > > > diff --git a/boot/Kconfig b/boot/Kconfig
> > > > > > > > > index 2993cd7f9ba..403ce4c3d46 100644
> > > > > > > > > --- a/boot/Kconfig
> > > > > > > > > +++ b/boot/Kconfig
> > > > > > > > > @@ -421,10 +421,10 @@ config BOOT_DEFAULTS_CMDS
> > > > > > > > >       select CMD_PART if PARTITIONS
> > > > > > > > >       select CMD_DHCP if CMD_NET
> > > > > > > > >       select CMD_PING if CMD_NET
> > > > > > > > > -     select CMD_PXE if CMD_NET
> > > > > > > > >       select CMD_BOOTI if ARM64
> > > > > > > > >       select CMD_BOOTZ if ARM && !ARM64
> > > > > > > > >       imply CMD_MII if NET
> > > > > > > > > +     imply CMD_PXE if CMD_NET
> > > >
> > > > If you only want scripts, then perhaps you can enable just what you
> > > > need, e.g. BOOTMETH_SCRIPT? You may need to disable BOOT_DEFAULTS a=
nd
> > > > choose your own options.
> > >
> > > Indeed, that was a missing config when I tried with BOOTSTD_FULL
> > > disabled. But there is more, please see below.
> > >
> > > >
> > > > > > > >
> > > > > > > > This is one of the things where defaults isn't supposed to =
be so easy to
> > > > > > > > get out of. How many platforms are you wanting to then disa=
ble CMD_PXE
> > > > > > > > on to save space?
> > > > > > >
> > > > > > > PXE is generally being removed in a lot of cases as it's not
> > > > > > > considered secure and now we have HTTP Boot there are other m=
eans of
> > > > > > > doing network booting so I think we'll see more and more situ=
ations
> > > > > > > where we want to disable PXE.
> > > > > > >
> > > > > > > This is actually something I've been meaning to look at so it=
's
> > > > > > > something I would love to see :)
> > > > >
> > > > > Glad to hear :)
> > > > >
> > > > > >
> > > > > > And in the world where we also can't just remove ATAGS support =
because
> > > > > > distros (Debian at least) still boots some modern platforms via=
 ATAGS +
> > > > > > appended device tree, the high level options for "boot this any=
where"
> > > > > > need to perhaps be different from "very modern requirements onl=
y
> > > > > > distro". I'm not objecting to be clear.
> > > > >
> > > > > As Tom suggested previously, perhaps looking from a different ang=
le.
> > > > > We can disable BOOTSTD_FULL and then try adding only options that=
 are
> > > > > needed for a board. Unfortunately this approach did not work when=
 I
> > > > > tried it in the past. It seems for bootstd to work well, we need =
to
> > > > > take the whole thing by enabling BOOTSTD_FULL.
> > > >
> > > > If you end up trying it again, please give a few details here as we
> > > > might be able to improve this. When bootstd was first introduced we
> > > > had very tight code-size constraints, so quite a few features are o=
nly
> > > > provided if BOOTSTD_FULL is enabled. Tom has suggested enabling mor=
e
> > > > features in the base implementation but we haven't really figured o=
ut
> > > > which.
> > >
> > > The problem is when a board already has enabled BOOTSTD_FULL or has
> > > been updated with Distro Boot (CONFIG_DISTRO_DEFAULTS), all the
> > > necessary configurations such as ext2, ext4, efi partition,... are
> > > implied, therefore were removed from board defconfig. They must be
> > > added back.
> > >
> > > I actually tried this just now and it does work booting a script from
> > > USB drive with this combination:
> > >
> > > CONFIG_BOOTMETH_SCRIPT=3Dy
> > > CONFIG_DISTRO_DEFAULTS=3Dy    (this also selects CMD_PXE, but it's OK
> > > for this test)
> > > # CONFIG_BOOTSTD_FULL is not set
> > >
> > > I think it's quite cumbersome to add each of the necessary configs
> > > back to the board defconfig. Not as easy as removing CMD_PXE, or othe=
r
> > > CMD_x to remove a capability.
> >
> > There's two parts to this. In turns of changing the defconfig to start
> > with, you shouldn't need to "add back", if you do:
> > $ make foo_defconfig
> > $ make menuconfig # Disable full, etc
> > $ make savedefconfig
> > $ cp defconfig configs/foo_defconfig
>
> Of course you're right! "make menuconfig" works as described above.
>
> Thanks,
> Tony
>
> >
> > But the second part is that yes, it's at least currently intentional to
> > be cumbersome to break the "all stock distributions work in all expecte=
d
> > use cases" option. If you have networking, networking works in U-Boot,
> > but you're not allowing users to install distros over the network like
> > they should be able to expect to, it shouldn't be easy.
> >
> > I am open to splitting the current option up in to multiple parts, alon=
g
> > the lines of legacy options, modern options, disk options, network
> > options since as Peter noted earlier in this thread, PXE is going away
> > in favour of HTTP(s) boot. But we still have lots of legacy boards and
> > distros to support.
> >

I'm withdrawing this patch.

Using the Kconfig approach Tom and Simon have suggested, I was able to
remove PXE and include only the BOOTMETH_SCRIPT for block devices in
bootstd. My test case using the pogo_v4 board showed a saving of 17K
(before: 508K, after 491K).

IMHO, we should still pursue the worthy goal of "splitting the current
options up into multiple parts". That will make u-boot configuration
much more robust.

For posterity, here is the Kconfig test using board/cloudengines/pogo_v4.

diff --git a/configs/pogo_v4_defconfig b/configs/pogo_v4_defconfig
index 1c0e0de8d4f..aaaa3fd51f2 100644
--- a/configs/pogo_v4_defconfig
+++ b/configs/pogo_v4_defconfig
@@ -17,15 +17,23 @@ CONFIG_SYS_LOAD_ADDR=3D0x800000
 CONFIG_IDENT_STRING=3D"\nPogoplug V4"
 CONFIG_PCI=3Dy
 CONFIG_LTO=3Dy
-CONFIG_BOOTSTD_FULL=3Dy
+CONFIG_ENV_VARS_UBOOT_CONFIG=3Dy
+CONFIG_BOOTMETH_SCRIPT=3Dy
+CONFIG_SUPPORT_RAW_INITRD=3Dy
 CONFIG_BOOTSTAGE=3Dy
 CONFIG_SHOW_BOOT_PROGRESS=3Dy
 CONFIG_BOOTDELAY=3D10
+CONFIG_USE_BOOTCOMMAND=3Dy
+CONFIG_BOOTCOMMAND=3D"bootflow scan"
 CONFIG_USE_PREBOOT=3Dy
 CONFIG_SYS_PBSIZE=3D1050
 CONFIG_BOARD_LATE_INIT=3Dy
 CONFIG_SYS_PROMPT=3D"Pogo_V4> "
 CONFIG_SYS_MAXARGS=3D32
+CONFIG_CMD_BOOTDEV=3Dy
+CONFIG_CMD_BOOTMETH=3Dy
+CONFIG_CMD_BOOTSTD=3Dy
+CONFIG_CMD_BOOTZ=3Dy
 # CONFIG_BOOTM_PLAN9 is not set
 # CONFIG_BOOTM_RTEMS is not set
 # CONFIG_BOOTM_VXWORKS is not set
@@ -35,16 +43,26 @@ CONFIG_SYS_MAXARGS=3D32
 CONFIG_CMD_MMC=3Dy
 CONFIG_CMD_MTD=3Dy
 CONFIG_CMD_NAND=3Dy
+CONFIG_CMD_PART=3Dy
 CONFIG_CMD_PCI=3Dy
 CONFIG_CMD_SATA=3Dy
 CONFIG_CMD_USB=3Dy
+CONFIG_CMD_DHCP=3Dy
 CONFIG_CMD_DNS=3Dy
+CONFIG_CMD_MII=3Dy
+CONFIG_CMD_PING=3Dy
 CONFIG_CMD_SNTP=3Dy
 # CONFIG_CMD_BLOCK_CACHE is not set
+CONFIG_CMD_EXT2=3Dy
+CONFIG_CMD_EXT4=3Dy
+CONFIG_CMD_FAT=3Dy
+CONFIG_CMD_FS_GENERIC=3Dy
 CONFIG_CMD_MTDPARTS=3Dy
 CONFIG_MTDIDS_DEFAULT=3D"nand0=3Dorion_nand"
 CONFIG_MTDPARTS_DEFAULT=3D"mtdparts=3Dorion_nand:2M(u-boot),3M(uImage),3M(=
uImage2),8M(failsafe),112M(root)"
 CONFIG_CMD_UBI=3Dy
+CONFIG_ISO_PARTITION=3Dy
+CONFIG_EFI_PARTITION=3Dy
 CONFIG_PARTITION_TYPE_GUID=3Dy
 CONFIG_OF_CONTROL=3Dy
 CONFIG_ENV_OVERWRITE=3Dy
@@ -72,4 +90,5 @@ CONFIG_USB=3Dy
 CONFIG_USB_XHCI_HCD=3Dy
 CONFIG_USB_XHCI_PCI=3Dy
 CONFIG_USB_EHCI_HCD=3Dy
+CONFIG_USB_STORAGE=3Dy
 CONFIG_UBIFS_SILENCE_MSG=3Dy

All the best,
Tony
