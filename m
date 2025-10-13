Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F14CCD18D
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 14:40:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA285836EE;
	Mon, 13 Oct 2025 16:40:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MUUdpmsj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63221838F3; Mon, 13 Oct 2025 16:40:23 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 187288331B
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 16:40:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7b3e2a51678so3557483a34.1
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 07:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760366420; x=1760971220; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NxXW0lpE9Wt+m6Uu2HV4EoteoDzpgjpJQW5lqv3dAU0=;
 b=MUUdpmsjcX1c3RSqA5VCeAeUhn/7hHQ6snIBaF0tzZYQT7pGzJcxW6JPkk7xHNqVpg
 ZTj3TJS+Ix8MRLP+2waK7ma5n7gS+jQLzLhetjJRiPYsdL73gltWLAwA4Pk+7JeMR8Rn
 F7KJguWXSatc8NJQwOclz8Y5w1BmfShx3SWoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760366420; x=1760971220;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NxXW0lpE9Wt+m6Uu2HV4EoteoDzpgjpJQW5lqv3dAU0=;
 b=ws3Yl0UXhtaq4+hZ5qH9Z8QZC+zVSWb7aHuv2DxcTDhKdluWmRxgQemaSbMLVUP5+6
 Enjtqi7B5Wj+mR3c2uTZ7SJmszOO/7CIsJvJdfdnkb7aKCkU0gaaGjG7af7nBCtvxIGq
 F8PCjJMaIraaDC4KNEQG889G7RCGw/OmkhPgyUE79s1HXCyMQ1THXfBHx+goFY+7Yhrn
 5FvxHWWpopwXWoaZGAVQilLb0asJyhBEp59zPTH7j5eiiwUF9AxqHk8omWHR2nI1sGx0
 nRt9jeLqNKaerJ+9BynWRYfgKkpAJ/k1a3wqM2RAg1+1HWTqTTG7D7dlF4ykunNZ+zKu
 Yu5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWI/3VKpcItMA09dM14/eLg68b2tO79J4CeeTBGuaeOqYhoVXHA0fslq4MVcgmj9rGlE6a7f/E=@lists.denx.de
X-Gm-Message-State: AOJu0YyiAwX3EWK4OU2LxaSpw2olqT39VTI0y0V1wstg/Wg+bsJtvhK7
 FK2nPrrRe8oJ+JR2K43XaHpHfJakcgq7YsKq2fb7snu7gRMmtShmiQM0T+Mn2W+U0HM=
X-Gm-Gg: ASbGncsu3s+f/e803EcTLHGzVJlJH+6g8hLEJJxVnbdQTRVvXx2e3V097usUd+ZnUwn
 tS830g5SMk+GBCZr7A9NGomxACNcNWI0++3uPW0L05h6xcHO4JAp+8Izumus4trXf30+TiCr28f
 rMyLsqfWL7t151Hm0CKvmDVy/TTapECbTc6T1FG5XlT2Xft+xKUcDMVmwpbCdb+JOgv2qUlworH
 3EDlc71Qeqj6WUJEt8djzlylfoqkJ6oN5suMyIaL9jPGx10nC+EARiBIcmtumJrF9aTao2MGF4C
 pttq/UX+YspGr6VBlK9tqI/bfJdE0z1xvYmhnTuwotVdaacPAHmgpu+eMAtkoxNqEVRA18V7AMp
 E5bYE1pe1cS+uuF6JlHS5DspO0UYo0rdRT0wDxTOzwR8e4ucSPCPlU05VytTQgr/jvnn0WZfFgr
 r2OvwY
X-Google-Smtp-Source: AGHT+IHdTI+DCYGIKzj4t5C+MCXzYUeYJJWqBuVkl+srp3cW6OjNHIUmKsJhvTbwFcx4marfcAf+Xw==
X-Received: by 2002:a05:6830:82e4:b0:750:69c2:365a with SMTP id
 46e09a7af769-7c0dfe6a273mr12198037a34.4.1760366419660; 
 Mon, 13 Oct 2025 07:40:19 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0f911a992sm3549796a34.26.2025.10.13.07.40.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 07:40:18 -0700 (PDT)
Date: Mon, 13 Oct 2025 08:40:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH] bootstd: Allow PXE boot to be disabled
Message-ID: <20251013144016.GG6113@bill-the-cat>
References: <20251010053056.32495-1-mibodhi@gmail.com>
 <20251010142835.GY298503@bill-the-cat>
 <CALeDE9P8VP6YKS1qoz3Dxga+h287GHzRvczCq0YDd4tOJxNXGQ@mail.gmail.com>
 <20251011143713.GI298503@bill-the-cat>
 <CAJaLiFyNCD1i_3=y_jF6Kyj8jGpAY3qwBwO=DMxB=BFGc-oXoQ@mail.gmail.com>
 <CAFLszTh8azMKW7jmQF8sY-mCkWCPZnP6U=evRPV5hVMO9DdneA@mail.gmail.com>
 <CAJaLiFwHfrw4Fg16vH3RPD1PDqQMaA=tmecaf8CUi8cNE9D4Bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dTOUpvbLeAhU9gp4"
Content-Disposition: inline
In-Reply-To: <CAJaLiFwHfrw4Fg16vH3RPD1PDqQMaA=tmecaf8CUi8cNE9D4Bg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--dTOUpvbLeAhU9gp4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 12, 2025 at 08:12:59PM -0700, Tony Dinh wrote:
> Hi Simon,
>=20
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
> > > > > On Fri, 10 Oct 2025 at 15:28, Tom Rini <trini@konsulko.com> wrote:
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
> > > > > > and I thought we had split those two out. And then there's this:
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
>=20
> Indeed, that was a missing config when I tried with BOOTSTD_FULL
> disabled. But there is more, please see below.
>=20
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
>=20
> The problem is when a board already has enabled BOOTSTD_FULL or has
> been updated with Distro Boot (CONFIG_DISTRO_DEFAULTS), all the
> necessary configurations such as ext2, ext4, efi partition,... are
> implied, therefore were removed from board defconfig. They must be
> added back.
>=20
> I actually tried this just now and it does work booting a script from
> USB drive with this combination:
>=20
> CONFIG_BOOTMETH_SCRIPT=3Dy
> CONFIG_DISTRO_DEFAULTS=3Dy    (this also selects CMD_PXE, but it's OK
> for this test)
> # CONFIG_BOOTSTD_FULL is not set
>=20
> I think it's quite cumbersome to add each of the necessary configs
> back to the board defconfig. Not as easy as removing CMD_PXE, or other
> CMD_x to remove a capability.

There's two parts to this. In turns of changing the defconfig to start
with, you shouldn't need to "add back", if you do:
$ make foo_defconfig
$ make menuconfig # Disable full, etc
$ make savedefconfig
$ cp defconfig configs/foo_defconfig

But the second part is that yes, it's at least currently intentional to
be cumbersome to break the "all stock distributions work in all expected
use cases" option. If you have networking, networking works in U-Boot,
but you're not allowing users to install distros over the network like
they should be able to expect to, it shouldn't be easy.

I am open to splitting the current option up in to multiple parts, along
the lines of legacy options, modern options, disk options, network
options since as Peter noted earlier in this thread, PXE is going away
in favour of HTTP(s) boot. But we still have lots of legacy boards and
distros to support.

--=20
Tom

--dTOUpvbLeAhU9gp4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaO0PTAAKCRAr4qD1Cr/k
CjC3AP9V1YzoAzTyHEpoEaQZCcNDQIIMxiG1WvhfB0+EODRKTAD/flEG2vmd+lOS
1Uq8vBShn5YgVdlM1tkpU5Wb8EeeMQA=
=1jfE
-----END PGP SIGNATURE-----

--dTOUpvbLeAhU9gp4--
