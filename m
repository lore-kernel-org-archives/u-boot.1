Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3456AC282C5
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 17:05:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A249E8141A;
	Thu, 27 Feb 2025 18:05:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HM/rs6z+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBDE98121A; Thu, 27 Feb 2025 18:05:02 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE0D4811C1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 18:04:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22328dca22fso19826865ad.1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 09:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740675879; x=1741280679; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FAXF7HeHKkoFXCPDq0cexGlQJEE92rPXNPdws7wl7So=;
 b=HM/rs6z+H1+WhCpiXxSCxLliFtAeT9RciSjuQP29yCUMxkcShU1G5t5wuXu1K3lruE
 PogoXP/VVnbvchlNc7y17t0SII/Zo/pVeGvFIgAb8KIwBOB58dZ3u0XU7THf//vYLLg2
 5C0MFbLzYOjoCrLFiQ78rDGpuEi8awY8NyIK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740675879; x=1741280679;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FAXF7HeHKkoFXCPDq0cexGlQJEE92rPXNPdws7wl7So=;
 b=sLV3b1X/6ZWYPuIpSiSyFj+VqeOFAO2ugvaT0pr4SZ3y8H3iKYSFESQfy8/zeCVHZJ
 dBkINAGQ31YrrZ74a0WS5/b4E4n+gmPpltKUAxpOKHvP1fC6lHpT1N/uv8RyTtCt3++4
 ikZHuqgJuhirAS2YzFAc3zDC4Fy+wNHIIuhjgJHPAU5cEzcxK/CjX4jlcBYmZoYnd0QU
 UVC2zaduX/DJ5rgYvAZJvqZLL2YntPcrOocp30gaL147Ev2C2XXKsKHi3bJh/WHkaPJy
 k6kD3tiYgMFe3nEv5vKBUq7RWUGz36pmYhALf/uWsVSSPLlxDWICbb6Y4UGhGhvQFho1
 66DQ==
X-Gm-Message-State: AOJu0YyIh+UfU+8G79JqxWVB2yavUJKiJGtO8+25JFI3+5aDOw0JAGqa
 +AFb5J7UYaM16Xj3n6uJ8V5kq2DwzzKJs/vKE25WjI+VgR6pVdhzRESdpmA5BYs=
X-Gm-Gg: ASbGncuQuFFuvhtLopQ1773bwwr3GHRD7YIqB4ebL8NLgh4PTMxeU5UDP9CCgBfYPQT
 xVe6wbAdM02P0zB4+kO0ecHNPgYsTqCNrDGUOtWRM3Frx17swqjicXkdA0a7RscNiN4A2Z30FUp
 Y34cmkjyWTwgS3VNcLzrxpXSkrl8H3tB3NGmWLpUw5BAcgBIaIE4KuLAQvbompZS+Q9EQdcpOPj
 aK4l0oZigrWOAEbZtl+f7fmGKzzcy7v3ENaKMZC7N4CNfStZ8qe71Tm7FmH//6DaBY3t+n4XYfy
 xNe9HJo/EZoxrLEbItLafwWK
X-Google-Smtp-Source: AGHT+IH8d3yt8Yp93YV3MiNQuiX7utHCralEbkd/Tra0ZbkdVTbU0JEMcDGJqXaA78wBWbE3MWX1Vw==
X-Received: by 2002:a05:6a00:1788:b0:730:949d:2d3f with SMTP id
 d2e1a72fcca58-734ac3632f4mr239963b3a.7.1740675878566; 
 Thu, 27 Feb 2025 09:04:38 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7349fe2ada7sm1881832b3a.36.2025.02.27.09.04.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 09:04:37 -0800 (PST)
Date: Thu, 27 Feb 2025 11:04:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Minkyu Kang <mk7.kang@samsung.com>
Subject: Re: [PATCH v2 2/5] samsung: snow: Use BLOBLIST_FIXED
Message-ID: <20250227170435.GE2640854@bill-the-cat>
References: <20250226162621.2681677-1-sjg@chromium.org>
 <20250226162621.2681677-3-sjg@chromium.org>
 <20250226211335.GM2640854@bill-the-cat>
 <CAFLszTjCQUb=vcNt5m9TqJC0AGcpEOanYwf7kOZoBS=DQDoK_g@mail.gmail.com>
 <20250227162613.GY2640854@bill-the-cat>
 <CAFLszThCnF3ijMKp3PP_U+Y-a6XNczGbzPz9eSnw07qcJZXzQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NUdMc0EX0ya4K2j3"
Content-Disposition: inline
In-Reply-To: <CAFLszThCnF3ijMKp3PP_U+Y-a6XNczGbzPz9eSnw07qcJZXzQA@mail.gmail.com>
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


--NUdMc0EX0ya4K2j3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 09:31:24AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 27 Feb 2025 at 09:26, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Feb 27, 2025 at 09:17:15AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 26 Feb 2025 at 14:13, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Feb 26, 2025 at 09:26:15AM -0700, Simon Glass wrote:
> > > >
> > > > > Snow requires a fixed bloblist to operate, so re-enable this opti=
on.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > Fixes: 864106f3c47 ("bloblist: Make BLOBLIST_ALLOC the default")
> > > > > ---
> > > > >
> > > > > (no changes since v1)
> > > > >
> > > > >  configs/snow_defconfig | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > > >
> > > > > diff --git a/configs/snow_defconfig b/configs/snow_defconfig
> > > > > index 7a1dc80b1cc..f9fd76daa67 100644
> > > > > --- a/configs/snow_defconfig
> > > > > +++ b/configs/snow_defconfig
> > > > > @@ -33,7 +33,9 @@ CONFIG_DISTRO_DEFAULTS=3Dy
> > > > >  CONFIG_SYS_PBSIZE=3D1024
> > > > >  CONFIG_SILENT_CONSOLE=3Dy
> > > > >  CONFIG_BLOBLIST=3Dy
> > > > > +CONFIG_BLOBLIST_FIXED=3Dy
> > > > >  # CONFIG_SPL_BLOBLIST is not set
> > > > > +CONFIG_BLOBLIST_ADDR=3D0x43d00000
> > > > >  # CONFIG_SPL_FRAMEWORK is not set
> > > > >  CONFIG_SPL_FOOTPRINT_LIMIT=3Dy
> > > > >  CONFIG_SPL_MAX_FOOTPRINT=3D0x3800
> > > >
> > > > I'm not going to NAK the patch, but:
> > > > - "snow" does not require a bloblist to operate, just to run the
> > > >   bloblist tests on hardware
> > >
> > > That's right. 'snow' is the platform I chose to try to run more of the
> > > sandbox tests, although I haven't done much with that.
> >
> > I use a Pi for trying to run more tests on and yes, good to know.
> >
> > > >   as implied by d985f1dbddb2 ("bootstd: Add a
> > > >   test for the bootstd menu"), which also don't seem to run anyhow?
> > >
> > > The bootstd tests all need sandbox at present, since there are images
> > > required. If you were interested in my idea of building the
> > > 'image-setup' stuff into the pytests, then we could change that.
> >
> > I just mean it wasn't clear that test/common/bloblist.c was run when
> > BLOOBLIST is enabled on snow. But I didn't dig too hard and compare the
> > output with sandbox when we pass stdout through pytest output too.
>=20
> Yes, they do seem to run OK...I put part of the output from 'ub-pyt
> snow' below[1]
>=20
> >
> > > > - We could just as easily continue to use an allocated bloblist if
> > > >   CONFIG_SYS_MALLOC_F_LEN is increased to say 0x800 from 0x400 (whi=
ch is
> > > >   the same size as the requested bloblist allocation).
> > >
> > > OK
> > >
> > > > - This very tiny SYS_MALLOC_F_LEN is just the old default value from
> > > >   when it was bumped up to 0x2000 for most platforms and is also sa=
fe
> > > >   from a quick test.
> > >
> > > OK. I didn't get time to look at bloblist last weekend and this one is
> > > not looking good either, but I will get to it.
> >
> > OK.
> >
> > --
> > Tom
>=20
> Regards,
> Simon
>=20
> [1]
> test/py/tests/test_ut.py sssnow # ut bdinfo bdinfo_test_eth
> Test: eth: bdinfo.c
> Skipping: Console recording disabled
> Tests run: 1, 8 ms, average: 8 ms, skipped: 1, failures: 0
> snow # .snow # ut bdinfo bdinfo_test_full
> Test: full: bdinfo.c
> Skipping: Console recording disabled
> Tests run: 1, 8 ms, average: 8 ms, skipped: 1, failures: 0
> snow # .snow # ut bdinfo bdinfo_test_help
> Test: help: bdinfo.c
> Skipping: Console recording disabled
> Tests run: 1, 8 ms, average: 8 ms, skipped: 1, failures: 0
> snow # .snow # ut bdinfo bdinfo_test_memory
> Test: memory: bdinfo.c
> Skipping: Console recording disabled
> Tests run: 1, 8 ms, average: 8 ms, skipped: 1, failures: 0
> snow # .snow # ut bloblist bloblist_test_align
> Test: align: bloblist.c
> Tests run: 1, 3 ms, average: 3 ms, failures: 0
> snow # .snow # ut bloblist bloblist_test_bad_blob
> Test: bad_blob: bloblist.c
> Tests run: 1, 3 ms, average: 3 ms, failures: 0
> snow # .snow # ut bloblist bloblist_test_blob
> Test: blob: bloblist.c
> Tests run: 1, 4 ms, average: 4 ms, failures: 0
> snow # .snow # ut bloblist bloblist_test_blob_ensure
> Test: blob_ensure: bloblist.c
> Failed to allocate 3e0 bytes
> Used size=3D30, total size=3D400
> Tests run: 1, 11 ms, average: 11 ms, failures: 0
> snow # .snow # ut bloblist bloblist_test_blob_maxsize
> Test: blob_maxsize: bloblist.c
> Failed to allocate 3e1 bytes
> Used size=3D400, total size=3D400
> Tests run: 1, 12 ms, average: 12 ms, failures: 0
> snow # .snow # ut bloblist bloblist_test_checksum
> Test: checksum: bloblist.c
> Checksum b3 !=3D b7
> Checksum b3 !=3D b5
> Checksum b3 !=3D b2
> Checksum b4 !=3D b3
> Checksum b3 !=3D b2
> Checksum b3 !=3D a0
> Checksum b3 !=3D 64
> Checksum 64 !=3D 63
> Checksum 64 !=3D 63
> Checksum 64 !=3D 63
> Checksum 64 !=3D 63
> Tests run: 1, 34 ms, average: 34 ms, failures: 0
> snow # .snow # ut bloblist bloblist_test_cmd_info
> Test: cmd_info: bloblist.c
> Skipping: Console recording disabled
> Tests run: 1, 8 ms, average: 8 ms, skipped: 1, failures: 0
> snow # .snow # ut bloblist bloblist_test_cmd_list
> Test: cmd_list: bloblist.c
> Skipping: Console recording disabled
> Tests run: 1, 8 ms, average: 8 ms, skipped: 1, failures: 0
> snow # .snow # ut bloblist bloblist_test_grow
> Test: grow: bloblist.c
> Tests run: 1, 4 ms, average: 4 ms, failures: 0
> snow # .snow # ut bloblist bloblist_test_init
> Test: init: bloblist.c
> Checksum 0 !=3D b3
> Checksum b3 !=3D b2
> Tests run: 1, 8 ms, average: 8 ms, failures: 0
> snow # .snow # ut bloblist bloblist_test_reloc
> Test: reloc: bloblist.c
> Failed to allocate 400 bytes
> Used size=3D40, total size=3D400
> Tests run: 1, 11 ms, average: 11 ms, failures: 0
> snow # .snow # ut bloblist bloblist_test_resize_fail
> Test: resize_fail: bloblist.c
> Failed to allocate 3b9 bytes
> Used size=3D68, total size=3D400
> Tests run: 1, 11 ms, average: 11 ms, failures: 0
> snow # .snow # ut bloblist bloblist_test_resize_last
> Test: resize_last: bloblist.c
> Tests run: 1, 4 ms, average: 4 ms, failures: 0
> snow # .snow # ut bloblist bloblist_test_shrink
> Test: shrink: bloblist.c
> Tests run: 1, 4 ms, average: 4 ms, failures: 0

Right. And if you look at
https://source.denx.de/u-boot/u-boot/-/jobs/1040117 there's no matches
like that in the output.

--=20
Tom

--NUdMc0EX0ya4K2j3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfAmyMACgkQFHw5/5Y0
tyy5Fgv/RKQjbSZ0WP0lU6oCVNwCLRSMv6wEJQTb4z9iuPc/zE5EfxNJjtpXKBCi
nEwyiAkTsqs+jmcK/m4GWWvUwvTGtPlTAFFysNUwADPnCp09RjpNBzutVg5Uz7ay
HQolilmX55pEGu4uYxLteOcWkf65BBdOStHQ9ipBNGfDsV8G8Ph5VdPxMjSO0Qlw
xKbVvhzazBW5xwljjqIZ9PYKOkDDoAh8xO0ZjFX/WfVH7110NLYBZ/05EZoL4lmt
Owo4fjanyZ/DP9vmH9hP/PGD6m7dwwjagGQCo7Tl2vdTvUE5gLRDZfxCl56fMPaw
yZoaQOI+ogLygNU8Y+BiS+Gq1cXIKe7x3yOEIftduz0Z/dFt/+2z0HKjRMMOvdPF
0qmHfoL1K9bk8iSPm6avolSvBd1q8oqqhLe4BwL+HwrQazLEFDCJlajTHT4lHvfW
/tu8w9JkSdeu9FUy6RMdegEmZzx8SDdmpw0KfUbN1ejFjfTPuAUxWD3yvBF79fpf
ZZqe4GO/
=HnkJ
-----END PGP SIGNATURE-----

--NUdMc0EX0ya4K2j3--
