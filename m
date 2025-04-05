Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E97CC36010
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 14:48:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FEA38215B;
	Sat,  5 Apr 2025 16:48:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YNkwBt+t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A6B482A64; Sat,  5 Apr 2025 16:48:31 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C42182063
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 16:48:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-603f54a6c8aso1741403eaf.0
 for <u-boot@lists.denx.de>; Sat, 05 Apr 2025 07:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743864508; x=1744469308; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jyEN4+D3qUXV8lplCbWLxBfFhs9hkqUauOgRjxvsb7E=;
 b=YNkwBt+thbkKnhGcu8mM8OkhQKoRwadvaGAekIUnCFMLh96BM2O77w6kSY+5X7iAre
 IHtRaTD1qfbFDm0R84E5yVj6/yQCt7wWRzIvpUy+9o4TVVuqEiS1rIYKHHz37ILnZwZ+
 NShJwx/cfz/elMHok0McmThnYe7FzENT/MzHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743864508; x=1744469308;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jyEN4+D3qUXV8lplCbWLxBfFhs9hkqUauOgRjxvsb7E=;
 b=Mlg0Ukex7j1vfyOveIod9yJV1eaSFBkvdcW2b5JDPpgyMhpn95EUoCqNsrkBpBf8ud
 pJKThjuIUyqK7lD4jIwUXIcD7RTfR9npIjIMRz4SZq2FnvA+ebSBc3wln4bQItffKj6f
 BgDGfRfMwOKDYdeE3a4Hf8RVdsV2+rXZ/g1LHAbX+lfhga2HeJkx4R5mLnM8Gp0d69My
 gZozDxUFD+oHPABI32TS4lxqBl9RhMT+8jOznry+cPqyw3/uVKSKv1NHc6d0Mid29dBx
 OMqoePHW+nULX7ylcfyS65azGFVdE+0xGVG4osM4aqYULvRLpp0V9slOBQGUv6ONpoOZ
 EXgA==
X-Gm-Message-State: AOJu0YxtzpPRSJ1ZU9y2kKIMLqCJe2WhkZj++nB1grgSabAnF/rVxS45
 3edNx7XTS0wX/mxMefr5YGQk6wrTq8dOSOFg7EF37+AJ9+kiRkWogvRtQsbWHc0=
X-Gm-Gg: ASbGncueltBMYkxIVsMSyU1osLN+EjIL2Z4A8wMTMCrXeuFleyqzaFt6m8kpJ9fggIx
 bOxaf5w4wHR0t3OAxHGzYDFiomX1hY8xdbTRYnK8qnVUhU8JNuU3ItWN6KJRp9VOyfrICesYLZa
 kTsX7RBCs0A2DHUvRR8suR6hV+TEys9B8aYZbYzAuIzzpcMRiV2xV72LVy6N1vNjYE/CW/eTkRy
 vDtjtN2tU8jeZ/fweTysElm69v/BVY3J6RJ5PDH8jDRMS/oSBhOeaCedJBIM+5+Kp9SqVa7Iy7f
 k4aVv2IOeq/EUyvZQ0/ycpo80Ba8ClGA05BvQplTR2v8wUzolvQXWegYI4F4fYOoyV5l7ZWw3Mg
 gqBNpGF+BOTUaq6Uw
X-Google-Smtp-Source: AGHT+IFRrq8ITnNUTQGJTB2tO9MeZhwY56Or9ibvBT8G69NwLaE2tl/cTTmutFqKcEisyoY06eCDpw==
X-Received: by 2002:a05:6808:3093:b0:3fe:ab15:5ed6 with SMTP id
 5614622812f47-400465987afmr3207266b6e.12.1743864507772; 
 Sat, 05 Apr 2025 07:48:27 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4003ff4e0e7sm1035190b6e.10.2025.04.05.07.48.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Apr 2025 07:48:26 -0700 (PDT)
Date: Sat, 5 Apr 2025 08:48:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
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
Message-ID: <20250405144823.GZ5495@bill-the-cat>
References: <20250306002533.2380866-1-sjg@chromium.org>
 <174234008117.1788726.14383009154862416750.b4-ty@konsulko.com>
 <10a57d25-d484-4903-8f25-e373c451bc21@kwiboo.se>
 <CAFLszThrij_kGPdFcdJLoxJLpoZru=_M_vG4eVKwdPAqDfQJyg@mail.gmail.com>
 <2ad3b1c5-b6e7-47e2-b225-834b821cc5c4@kwiboo.se>
 <20250404224801.GV5495@bill-the-cat>
 <20250405144008.GY5495@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5KrTmhBUq7GWMKrA"
Content-Disposition: inline
In-Reply-To: <20250405144008.GY5495@bill-the-cat>
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


--5KrTmhBUq7GWMKrA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 05, 2025 at 08:40:08AM -0600, Tom Rini wrote:
> On Fri, Apr 04, 2025 at 04:48:01PM -0600, Tom Rini wrote:
> > On Fri, Apr 04, 2025 at 11:32:12PM +0200, Jonas Karlman wrote:
> > > Hi Simon,
> > >=20
> > > On 2025-04-04 00:30, Simon Glass wrote:
> > > > Hi Jonas,
> > > >=20
> > > > On Fri, 4 Apr 2025 at 09:57, Jonas Karlman <jonas@kwiboo.se> wrote:
> > > >>
> > > >> Hi Tom and Simon,
> > > >>
> > > >> On 2025-03-19 00:21, Tom Rini wrote:
> > > >>> On Wed, 05 Mar 2025 17:24:54 -0700, Simon Glass wrote:
> > > >>>
> > > >>>> This series includes some patches related to allowing read_all()=
 to be
> > > >>>> used with the extlinux / PXE bootmeths.
> > > >>>>
> > > >>>> These patches were split out from the stb4 series, since it will=
 need to
> > > >>>> have additional patches for LWIP, to avoid breaking PXE booting =
when
> > > >>>> LWIP is used.
> > > >>>>
> > > >>>> [...]
> > > >>>
> > > >>> Applied to u-boot/next, thanks!
> > > >>
> > > >> This series broke booting a compressed arm64 defconfig Linux kernel
> > > >> (without module loading) due to changes in decompression buffer le=
ngth.
> > > >>
> > > >> My arm64 defconfig kernel (Image.gz) is ~24 MiB compressed and ~85=
 MiB
> > > >> uncompressed.
> > > >>
> > > >> Before this series the decompression buffer was 10x the kernel_com=
p_size
> > > >> and now it is instead limited by the SYS_BOOTM_LEN Kconfig symbol.
> > > >>
> > > >> A broken boot using current next branch:
> > > >>
> > > >>   Retrieving file: /Image.gz
> > > >>   Retrieving file: /initramfs.cpio.gz
> > > >>   append: earlycon
> > > >>   cmd 'booti' states 1f1f addr_img '0x02080000' conf_ramdisk '0x06=
000000:394d3c' conf_fdt '3df16350' images 000000003ffe53a0
> > > >>      kernel data at 0x02080000, len =3D 0x00000000 (0)
> > > >>   load 2080000 start 2080000 len 0 ep 0 os 5 comp 1
> > > >>   find_other type 2 os 5
> > > >>   ## Flattened Device Tree blob at 3df16350
> > > >>      Booting using the fdt blob at 0x3df16350
> > > >>   Working FDT set to 3df16350
> > > >>   load_os load 8000000 image_start 2080000 image_len 2000000
> > > >>      Uncompressing Kernel Image to 8000000
> > > >>   Error: inflate() returned -5
> > > >>   Image too large: increase CONFIG_SYS_BOOTM_LEN
> > > >>   Must RESET board to recover
> > > >>   Resetting the board...
> > > >>
> > > >> Changing SYS_BOOTM_LEN from default 64 MiB to 128 MiB fixed the bo=
ot:
> > > >>
> > > >>   Retrieving file: /Image.gz
> > > >>   Retrieving file: /initramfs.cpio.gz
> > > >>   append: earlycon
> > > >>   cmd 'booti' states 1f1f addr_img '0x02080000' conf_ramdisk '0x06=
000000:394d3c' conf_fdt '3df16430' images 000000003ffe5480
> > > >>      kernel data at 0x02080000, len =3D 0x00000000 (0)
> > > >>   load 2080000 start 2080000 len 0 ep 0 os 5 comp 1
> > > >>   find_other type 2 os 5
> > > >>   ## Flattened Device Tree blob at 3df16430
> > > >>      Booting using the fdt blob at 0x3df16430
> > > >>   Working FDT set to 3df16430
> > > >>   load_os load 8000000 image_start 2080000 image_len 2000000
> > > >>      Uncompressing Kernel Image to 8000000
> > > >>      kernel loaded at 0x08000000, end =3D 0x0d3b5a00
> > > >>      Loading Ramdisk to 3cb51000, end 3cee5d3c ... OK
> > > >>      Loading Device Tree to 000000003cb3f000, end 000000003cb509df=
 ... OK
> > > >>   Working FDT set to 3cb3f000
> > > >>
> > > >>   Starting kernel ...
> > > >>
> > > >> Do we need to increase the default SYS_BOOTM_LEN for ARM64 now?
> > > >=20
> > > > Are you using the 'booti' command? Can you post a bit more console
> > > > output or a script here as it isn't clear what boot command you are
> > > > using? For now I'm going to assume booti
> > >=20
> > > Above was using an extlinux.conf with bootstd, not using the booti cm=
d.
> > >=20
> > > Use of booti cmd is not affected as it continue to use a 10x multiple
> > > of the kernel_comp_size env var for buffer size.
> > >=20
> > > The change this series introduced was instead of the 10x multiple of
> > > kernel_comp_size now use SYS_BOOTM_LEN for buffer size (320 vs 32 MiB=
).
> > >=20
> > > And because cmd/booti.c was not converted there is now two different
> > > handling of this decompression buffer size.
> > >=20
> > > If the change to now use SYS_BOOTM_LEN was intended this need to be
> > > changed as it has mostly been irrelevant for booting Linux on AArch64
> > > boards prior to this series.
> >=20
> > We need to clean things up such that the path which is using 10x
> > multiple (and we lmb_alloc an area iirc) is used in all cases.
>=20
> Looking at the code this morning, I was confusing this with what we do
> for compressed FIT images, oops.

Ugh. Simon, can you go and fix this whole problem? Both do_bootz and
do_booti have non-trivial amounts of code that's missed by changing from
calling do_bootX() to bootX_run().

--=20
Tom

--5KrTmhBUq7GWMKrA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfxQrcACgkQFHw5/5Y0
tyylggv/UCbZO6fwY85UipR1CGirm1p3synetwRu7eRI461XABeotztBBS0reXVU
ORDeyvC9caXi3Uh5T+toyzGdasc1CXXNwHIQA4426aWGCor+St8/N4xV/q0dS1HP
HRmX5iJoaOHrblE+1XVMjfOalsZ5nmlOoMRAa+lRkujkRkfnhBJ9tn2LClgE1c/P
owwky9Rlg33r7ui6EO1O557Tuk/4xQHUvzOCW7nrFKkfcJG+LWVqwm3aQF1aPcuK
5CeJlgBUgPAR48T+VIN9iLmzvz6z4SvZyVVAY2McgwMCQMHol6r5R9Re8urU+/er
ijFjgXHdlX3LRy2+q1+YsbdYB7XX7Y+3QDdk5w+dnT83dPLokCKwzQnBuAEy69bD
ZKrK2YIbHqDHbtN0wOXdx8e7haIjSfgM5df7DPL69NUcskoCH1Ke6mkvBR9tAdrX
+Ff2tFvYQ6ZAO+aJG3MbdfvcKmCA+u2JJWiix5zYk3zx63mISqZRW5BuBT2YIfEp
q3oQLSRT
=P1sA
-----END PGP SIGNATURE-----

--5KrTmhBUq7GWMKrA--
