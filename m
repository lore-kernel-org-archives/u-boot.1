Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC553CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 21:41:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 694798403D;
	Fri, 10 Oct 2025 23:41:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AwwIPEcb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAEC48403E; Fri, 10 Oct 2025 23:41:04 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EA1A841E6
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 23:41:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-43fc147aee3so485056b6e.1
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 14:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760132460; x=1760737260; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Bwjl9ktuSxJiPsfvjI4Iu5k8iRZh0sAaBP//yTQf+JM=;
 b=AwwIPEcb54zqvAlpkVAqNlhmhJLpE8cbWLSDJTNyZCy7hC8yIxIjjJKLWNUj45a6i3
 dksr4MCM2VqMsbchWMg+lMO/Ggms2JaIcHg1NIDBfMorM9pgqmPFH4lYfdGcmk5UothO
 K8HRPQbuzSNT2lPUZjBdOrAbim2AGV1fMBdRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760132460; x=1760737260;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bwjl9ktuSxJiPsfvjI4Iu5k8iRZh0sAaBP//yTQf+JM=;
 b=SHkFAXpIVxNUsVTN8GZvYpyjLc+Q42s2Fzh4/8R3ofhLT6T4qqgQhi87odiKKgUVIM
 QEDL6aGmeg5f2W6IWh91F/vG4RdBOvY4fFtAbfRTHLb5KMG2w3P26yTWV/nYDj5dYnoB
 7TrZ/+3rXTaTc6/IfPN6FyHgzTQjZaQJq6aT6+uVV4CLlPBrwS7nM298UD8DBywlI+Tl
 MI5qiHLP3DVDL22+HtlVsBZgsHJ1Jayf/vH0jAPyYn9JunvmKdwSd0CQeKG1CAiJ0lKi
 VT3N+u8Mo97uBbVHVX7QxpFQfnMvmtd9HXs+n5XNGHxhtnK7ftkzIV6+23/qG51sSvZa
 fGqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsitFjdjYETWUiP+6N5K9aZvRjwJM5MkKXK+uJMdtVGm/RVm9j4AnJtR4DJcUW55VbKpkpk4w=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0VZ4+vy2dv3oWhGtp3ZHGe3o0UQYG6wBFRHCXJ7d+hZzg6UIi
 a11Wh3hxC6yH/h1Gz55r2yVOrqMCKugzOQV3NljAIXdoyFoB6DN1nRC9Xd+Q15cn3Rc=
X-Gm-Gg: ASbGncuK6Bm1HmuivQslYEzJxfP9sdWWZF2t61K8L/veZBFXwBZ/WbDt54thymamU2r
 yZgdjC/tcfBUVtoeq2/842rYB+lNewwKBcaL5PkkfPR1LNd7uZpMXSarMsrMQNcVr94D2MBloSA
 nvI77T1lEPsvbvIN2MvHDndSa677ep0FO2FwGLQGdCC7q8QHoaOMqp1/+xvsXTecVTyRu+0YhjX
 3U7YPsk7tBwHJ3DxfcPUTGlG9juYTA9p9UuplUTQSjJS8U8B6/nDxZ2lUDzQ4qu+ugplt5XjahL
 xeEmebV0UD8VyElpwu5lSL7RjoECGLSElONZiZJ+4V12kk3MHiuvcHUsqqEY570Vp8aYxco/LGm
 HNBeetHHDdaum2nD9VIOMjH6HJCBmDHnx4pPCDi4CV8PPGb4dhkRYKaUazoaFqKQY7Y40MLPpqP
 IRd+5mwVKCVFLWMew=
X-Google-Smtp-Source: AGHT+IHyVdLoOYtxAVUVtu5le18HYrF55faF4Ymjr0OZK38625Hn3iMSFccQ4wZt3T2dT0hREQcBQA==
X-Received: by 2002:a05:6808:50a7:b0:43f:a2eb:861f with SMTP id
 5614622812f47-4417b2bbcbfmr5827019b6e.8.1760132460203; 
 Fri, 10 Oct 2025 14:41:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4419889ffa4sm938538b6e.10.2025.10.10.14.40.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 14:40:58 -0700 (PDT)
Date: Fri, 10 Oct 2025 15:40:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Nam Cao <namcao@linutronix.de>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH] bootstd: Allow PXE boot to be disabled
Message-ID: <20251010214056.GH298503@bill-the-cat>
References: <20251010053056.32495-1-mibodhi@gmail.com>
 <20251010142835.GY298503@bill-the-cat>
 <CAJaLiFyYGJjO=BjvL3HXAfbE1V2bwB_CSkcOTC6tQTJAR_DMVA@mail.gmail.com>
 <20251010200724.GF298503@bill-the-cat>
 <CAJaLiFyTVXY4c+zS0RNPwCgzbzH968a2Zgo5s=AYh9y0wu800g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fPUuK9Nx9H8f8vte"
Content-Disposition: inline
In-Reply-To: <CAJaLiFyTVXY4c+zS0RNPwCgzbzH968a2Zgo5s=AYh9y0wu800g@mail.gmail.com>
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


--fPUuK9Nx9H8f8vte
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 01:59:43PM -0700, Tony Dinh wrote:
> Hi Tom,
>=20
> On Fri, Oct 10, 2025 at 1:07=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Fri, Oct 10, 2025 at 12:38:58PM -0700, Tony Dinh wrote:
> > > Hi Tom & Simon,
> > >
> > > On Fri, Oct 10, 2025 at 7:28=E2=80=AFAM Tom Rini <trini@konsulko.com>=
 wrote:
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
> > > >
> > > > This is one of the things where defaults isn't supposed to be so ea=
sy to
> > > > get out of. How many platforms are you wanting to then disable CMD_=
PXE
> > > > on to save space?
> > >
> > > I'm simply trying to compile out PXE for a board that I'm working on!
> > > The only thing I need is booting with scripts on a block device. And
> > > it looks like we have to include everything in bootstd to use it. It
> > > seems wrong to make the image a lot larger than needed for boards that
> > > never use a specific feature.
> > >
> > > I would agree about  "defaults isn't supposed to be so easy to get out
> > > of". But in this case (and similarly in other CMD_x), CMD_PXE brings
> > > in all dependencies for PXE including pxe_utils.
> >
> > So, as a preface, it's quite likely that we do need to tweak some of the
> > Kconfig logic here. To help better understand the use case:
> > - Does this platform have networking devices in U-Boot?
> > - Are you wanting to support arbitrary off the shelf OS distributions?
>=20
> Yes to both. Networking is enabled in U-Boot, but not used for
> booting. And it should boot various off-the-shell OS. U-Boot is on a
> 512KB partition on SPI flash (why I want to keep u-boot image as small
> as possible).

This is the hard case then. The point of the options is that if you
enable them, all of the common cases like network booting work. Without
knowing the device itself, I'm unsure why no one would ever use the
network to install the OS.

I suspect you need to look for where you can change "select
something-boot-standard" to "imply something-boot-standard" and then
turn it off for your platform, and turn on what you want to support for
it. It's taking the Kconfig change you proposed to start with one step
further.

--=20
Tom

--fPUuK9Nx9H8f8vte
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOl9ZAAKCRAr4qD1Cr/k
CouSAPwOhNWZP46C80Su/gRcAKAcp4aUIuhPZqQ/mc+40NbXMwD/aeG4XYdyYABE
OB+q1N1jFPaAJd+Qr2ifEK5MCG9pJw8=
=pJtL
-----END PGP SIGNATURE-----

--fPUuK9Nx9H8f8vte--
