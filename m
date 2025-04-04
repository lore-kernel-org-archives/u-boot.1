Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB149C36010
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 22:48:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1036D82A4B;
	Sat,  5 Apr 2025 00:48:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AadA9g0q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E544282A56; Sat,  5 Apr 2025 00:48:09 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83BB082A46
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 00:48:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3fa0eb29cebso2085590b6e.0
 for <u-boot@lists.denx.de>; Fri, 04 Apr 2025 15:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743806886; x=1744411686; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/61rCGJDqPC2GOHUQjVwBsKF/fzM/oG7R69LkaFlwVY=;
 b=AadA9g0qPm56dJ81VWSbeqfY1cIaZl70qqZ4QLxUBZLaDom2Hi1xHnBq7fzdpsTBlZ
 njhh2Yp6BdembbJrPfar6bz2B24iR3k6QVkGNciz968hgz3DFX7R3ggWWCSniXkLHclf
 PBGpUPvgx2RoRfrTS7+loF044a5csMS4MtB+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743806886; x=1744411686;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/61rCGJDqPC2GOHUQjVwBsKF/fzM/oG7R69LkaFlwVY=;
 b=g5/L6sDUgwSuVnwgk+YFFhCyQC1cU44fQqm8CaNssG+TdCyjqtL/ALDCsuv0NhEOfD
 MRzh1G+sVRG7RRA3twRCi2evPBZibV9vl3IF4KHbwdMemltWCxbXUcN8rOVHorIJuYka
 lunuxOqQ7RQlbSKatg06nuP1EKezf8mQYNygDfeqnO382T8gewOeY8Oi5F09ECkrq9Es
 EEEsBmgP+lnoO49ZepNCTaJ9AaC4UoNa9e75jPRGAmwpZiJoXhOVBu0is7vRDehOz86B
 n5am/BSJyM0HLfXQ8IROFs1/9pbiM+U3U1pUgRVKoGhji5IThi5T8hs1pqhiNWBP7VOM
 KGVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYjKsN87OjkfanhWVfoh3iPmnbdnARPyMCkOVTAalMP09AZ4ayHesiWwnMWBvvd9EZRPR7hKc=@lists.denx.de
X-Gm-Message-State: AOJu0YxOAfDOfNerHumADdl86Nq348Wlcr4GAXAcrP2KErw/vsXpW8KC
 h+s+ROu42k2P4A/Oj7Lah0+L49BfVHLwIqVMsLh7btrcw6ZVRrECwM45yh467bU=
X-Gm-Gg: ASbGncu0YDHq9uoHjAChAUFM50laRIIoYdu8h1y7Qlx9vzGVFy0VlSmoPXYp+S9XClQ
 LZeYrHzukMdp9A9owtpkZQ/lJuHzxKLKq1C19OKNZZ3cCzYJSaRiINcyTfScX7WXC/rnDnJLRjQ
 p3LYjeKxNQw3dDPPBhuYTXMElhs1QuGxNA8ze5qA2rITu8HPFJ/cgyjIZXb+xVSE/9DmkL7y4Bn
 x7rIYb/ZoEgYQOR3agJZ9ldYTJOisrw2f0UrwA5h4gb5qEvDyd6vmcTCrKjUc63YLLYGt3N7F/Q
 rfOquwj1A43nYSelak44xiZWOFjXb75OI07OFrq7RNo2TbpZgRHRQp84q+QJFigX6/GwyGAoWBP
 UIVv4xQ==
X-Google-Smtp-Source: AGHT+IFxNN4mijUE1b7XHslkOYx5q7JzyAv+rgNBSZ1J6K83lPm9wq72Te181hFzdDx+ZIPNO/U4xg==
X-Received: by 2002:a05:6808:1c0a:b0:3f3:fe04:f86 with SMTP id
 5614622812f47-400453fa5a5mr2880415b6e.0.1743806886093; 
 Fri, 04 Apr 2025 15:48:06 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40040099665sm794149b6e.43.2025.04.04.15.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 15:48:04 -0700 (PDT)
Date: Fri, 4 Apr 2025 16:48:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Albert Aribaud <albert.u.boot@aribaud.net>, Bin Meng <bmeng.cn@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Julien Masson <jmasson@baylibre.com>, Leo <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ramon Fried <rfried.dev@gmail.com>, Rick Chen <rick@andestech.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH v5 00/29] pxe: Precursor series for supporting read_all()
 in extlinux / PXE
Message-ID: <20250404224801.GV5495@bill-the-cat>
References: <20250306002533.2380866-1-sjg@chromium.org>
 <174234008117.1788726.14383009154862416750.b4-ty@konsulko.com>
 <10a57d25-d484-4903-8f25-e373c451bc21@kwiboo.se>
 <CAFLszThrij_kGPdFcdJLoxJLpoZru=_M_vG4eVKwdPAqDfQJyg@mail.gmail.com>
 <2ad3b1c5-b6e7-47e2-b225-834b821cc5c4@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZagcHnswv5b9XJz8"
Content-Disposition: inline
In-Reply-To: <2ad3b1c5-b6e7-47e2-b225-834b821cc5c4@kwiboo.se>
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


--ZagcHnswv5b9XJz8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 04, 2025 at 11:32:12PM +0200, Jonas Karlman wrote:
> Hi Simon,
>=20
> On 2025-04-04 00:30, Simon Glass wrote:
> > Hi Jonas,
> >=20
> > On Fri, 4 Apr 2025 at 09:57, Jonas Karlman <jonas@kwiboo.se> wrote:
> >>
> >> Hi Tom and Simon,
> >>
> >> On 2025-03-19 00:21, Tom Rini wrote:
> >>> On Wed, 05 Mar 2025 17:24:54 -0700, Simon Glass wrote:
> >>>
> >>>> This series includes some patches related to allowing read_all() to =
be
> >>>> used with the extlinux / PXE bootmeths.
> >>>>
> >>>> These patches were split out from the stb4 series, since it will nee=
d to
> >>>> have additional patches for LWIP, to avoid breaking PXE booting when
> >>>> LWIP is used.
> >>>>
> >>>> [...]
> >>>
> >>> Applied to u-boot/next, thanks!
> >>
> >> This series broke booting a compressed arm64 defconfig Linux kernel
> >> (without module loading) due to changes in decompression buffer length.
> >>
> >> My arm64 defconfig kernel (Image.gz) is ~24 MiB compressed and ~85 MiB
> >> uncompressed.
> >>
> >> Before this series the decompression buffer was 10x the kernel_comp_si=
ze
> >> and now it is instead limited by the SYS_BOOTM_LEN Kconfig symbol.
> >>
> >> A broken boot using current next branch:
> >>
> >>   Retrieving file: /Image.gz
> >>   Retrieving file: /initramfs.cpio.gz
> >>   append: earlycon
> >>   cmd 'booti' states 1f1f addr_img '0x02080000' conf_ramdisk '0x060000=
00:394d3c' conf_fdt '3df16350' images 000000003ffe53a0
> >>      kernel data at 0x02080000, len =3D 0x00000000 (0)
> >>   load 2080000 start 2080000 len 0 ep 0 os 5 comp 1
> >>   find_other type 2 os 5
> >>   ## Flattened Device Tree blob at 3df16350
> >>      Booting using the fdt blob at 0x3df16350
> >>   Working FDT set to 3df16350
> >>   load_os load 8000000 image_start 2080000 image_len 2000000
> >>      Uncompressing Kernel Image to 8000000
> >>   Error: inflate() returned -5
> >>   Image too large: increase CONFIG_SYS_BOOTM_LEN
> >>   Must RESET board to recover
> >>   Resetting the board...
> >>
> >> Changing SYS_BOOTM_LEN from default 64 MiB to 128 MiB fixed the boot:
> >>
> >>   Retrieving file: /Image.gz
> >>   Retrieving file: /initramfs.cpio.gz
> >>   append: earlycon
> >>   cmd 'booti' states 1f1f addr_img '0x02080000' conf_ramdisk '0x060000=
00:394d3c' conf_fdt '3df16430' images 000000003ffe5480
> >>      kernel data at 0x02080000, len =3D 0x00000000 (0)
> >>   load 2080000 start 2080000 len 0 ep 0 os 5 comp 1
> >>   find_other type 2 os 5
> >>   ## Flattened Device Tree blob at 3df16430
> >>      Booting using the fdt blob at 0x3df16430
> >>   Working FDT set to 3df16430
> >>   load_os load 8000000 image_start 2080000 image_len 2000000
> >>      Uncompressing Kernel Image to 8000000
> >>      kernel loaded at 0x08000000, end =3D 0x0d3b5a00
> >>      Loading Ramdisk to 3cb51000, end 3cee5d3c ... OK
> >>      Loading Device Tree to 000000003cb3f000, end 000000003cb509df ...=
 OK
> >>   Working FDT set to 3cb3f000
> >>
> >>   Starting kernel ...
> >>
> >> Do we need to increase the default SYS_BOOTM_LEN for ARM64 now?
> >=20
> > Are you using the 'booti' command? Can you post a bit more console
> > output or a script here as it isn't clear what boot command you are
> > using? For now I'm going to assume booti
>=20
> Above was using an extlinux.conf with bootstd, not using the booti cmd.
>=20
> Use of booti cmd is not affected as it continue to use a 10x multiple
> of the kernel_comp_size env var for buffer size.
>=20
> The change this series introduced was instead of the 10x multiple of
> kernel_comp_size now use SYS_BOOTM_LEN for buffer size (320 vs 32 MiB).
>=20
> And because cmd/booti.c was not converted there is now two different
> handling of this decompression buffer size.
>=20
> If the change to now use SYS_BOOTM_LEN was intended this need to be
> changed as it has mostly been irrelevant for booting Linux on AArch64
> boards prior to this series.

We need to clean things up such that the path which is using 10x
multiple (and we lmb_alloc an area iirc) is used in all cases.

--=20
Tom

--ZagcHnswv5b9XJz8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfwYZ0ACgkQFHw5/5Y0
tyyRBQwApnkh27Op4QXcq/2S011MO65YNusbFo9q7ZzBbrk8B4NXOJKs8Z7ZjQZc
C2C0IzYev/982jqaHMlYimR+M2ZA91e35Ddz/t8fCCyyGnBTkw0HyxiyCV+AqDUi
FDWGIe6NfJKYEZjNUlBbGCqDXPuEiMPpTFHiB9+d+70fU1abpYuVQyjwahkTUwQ5
0dmwkW9QDpy6ZEx8/iJ/TQiYqZjcSFoIH90nFO2nr8V5bduKKXfsDMvMLC0E/Cv5
0ysPGwMR6tIbGTDYJ7MJSiILd+XEcitqoIDy8vUw/V9Hha4CzEiS7cdqsSZtdj2G
XtB8xbaHzeIJl9KE1LWKpx60ZbRmQOL8rkr59x1SkxQ3boBh9nw5qSxf0xTcEKn3
LudhEY8gMCvVxH2LqoUvYbBtHc3pWzJ2N/VPcYG0YG9wUdG4roicquJBeUdXhbbq
RAUjBNg7DSF7rTS/r9dKAlEB5qfSC46CWUA1A5Zn2tJ82lUSjAklcbuHD1Pdj8fH
ZLA6kbCz
=Ffam
-----END PGP SIGNATURE-----

--ZagcHnswv5b9XJz8--
