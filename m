Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA9FC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 18:30:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05F72865ED;
	Mon,  6 Nov 2023 19:30:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tw1mc4iC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62E4886366; Mon,  6 Nov 2023 19:30:27 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC3BD86B75
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 19:30:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7788db95652so335983085a.2
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 10:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699295423; x=1699900223; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=78flX3t6XbZ3umLRWmYflaqWaA2+bST0RI0Wn6VTCg4=;
 b=tw1mc4iC7Fv5a4EWIrtGg36EPryhavy3BJK3vq7z14SvBclUw/8BW4FcdCRjfoGhWr
 YP8+Mvx1Fj8blHe+CKuOPbrxn5woVyKCnpE9Ygay9Qk7uMWfpzLfJWiZJhjyCjogp6MM
 ZgfCOEwgzHG7dlRUy381ZkSAgnewBC5PQSblE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699295423; x=1699900223;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=78flX3t6XbZ3umLRWmYflaqWaA2+bST0RI0Wn6VTCg4=;
 b=SG+FuCGblpdOLqAYsF/xXbwB8DGF9trEwSz4g5Zn9JDTTY1d4MtJSIIq38VQIJ0CXP
 Q8kuri42ccdP/LEzJDW1ODugU9Ad9bYM93UuwCkrdnM9LVlbvKuB6s1DCUocmDRHgIBc
 OukckOQRFr5GV/4sN4YEH0AfrUTPxuPMM1tddkHLAPx6y4E818m/ybv7aoXrZpF2iEn1
 t9Oi9pou2QrGoNbtfE/F4cBvumn2L+ffZ4ssx1U29APvpYrrffZXURDucezTZBP2uB7U
 mgAYBa29jmMTJUWgMOWs3W2EBdPPD3c4gR7PokdYmb3tWCzfUv5KoXXbyfQym2zHTPiL
 AReg==
X-Gm-Message-State: AOJu0YxxYzkX7Yh+mN7W6kbPEqPxFkNGaJ2SPPvXZzblbp+prjJBAJOn
 XTUhJ+z5GuEImh83P7ivAKlu4g==
X-Google-Smtp-Source: AGHT+IGlwYfPTN4C7aKZBe4cwK/BlRWaEKt4t4uAmdBSb8zmu1Pl1PhLwu4omKK/uwoioDDF99oL/w==
X-Received: by 2002:a05:620a:4551:b0:777:5044:8c2e with SMTP id
 u17-20020a05620a455100b0077750448c2emr35572155qkp.9.1699295423419; 
 Mon, 06 Nov 2023 10:30:23 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 s21-20020ae9f715000000b007788c1a81b6sm3520392qkg.46.2023.11.06.10.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 10:30:22 -0800 (PST)
Date: Mon, 6 Nov 2023 13:30:20 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH 1/4] bootm: Allow ignoring the load address with
 kernel_noload
Message-ID: <20231106183020.GB496310@bill-the-cat>
References: <20231105200453.1887418-1-sjg@chromium.org>
 <20231105130351.1.Iae1cd9e0e207784e680480ee52021ec5caed877e@changeid>
 <20231105211910.GE496310@bill-the-cat>
 <CAPnjgZ26DyfvayO8BgQvCoEVDfmxotG7A7GMWc9T0wK0Okho8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="y3Qz8DKGCVBrfpnz"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ26DyfvayO8BgQvCoEVDfmxotG7A7GMWc9T0wK0Okho8w@mail.gmail.com>
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


--y3Qz8DKGCVBrfpnz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2023 at 10:25:00AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sun, 5 Nov 2023 at 14:19, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Nov 05, 2023 at 01:03:51PM -0700, Simon Glass wrote:
> >
> > > This image type is supposed to ignore the load address. But at present
> > > it fails if the load address is missing. If it is zero, the image is
> > > loaded at address 0, which may not work on all boards.
> > >
> > > Make use of the kernel_addr_r environment variable, instead, since th=
is
> > > seems to be a more reliable final address for the kernel.
> > >
> > > Another option would be to create a new Kconfig for this, or to use a
> > > region of memory known to be free, e.g. calculated from the DRAM bank=
s.
> > > But in any case we should try to avoid conflicting with the
> > > kernel_addr_r variable. So the approach in this patch seems reasonable
> > > to me.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > How are you creating the image in question here? A noload FIT is
> > supposed to just supposed to go from where it is. Where do things fall
> > down later?
>=20
> The image is Image.gz built by Linux, for example. So compression =3D
> "gzip" which means that it has to be decompressed.
>=20
> Things fall down as soon as U-Boot looks at the image, since it
> doesn't have the ARM64 magic.

Can you provide logs and env? "booti" is supposed to handle this case
already, and if it's not we should figure out when / why it broke.

--=20
Tom

--y3Qz8DKGCVBrfpnz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVJMLQACgkQFHw5/5Y0
tyxJrgwAnyy5iCAPaGF2oRkTYQ+n3oRckUdpSAoW4ANvTHjhpjm/9ASq2ousHKqn
GCM6TKvX3XtAeFC3sJ3I4p0KnCpDcJWbyOg6XXW0riCkA+VLgP+I2UDWvFCka5xB
CZpSnXN3USWH2WnVbiNWg+qfhciN60IDM2vZ1NkiQFxvvjS0ncD8R3ExhWYZ2vyU
eMiT5rJQeaOZL4j06cFMiU9KszrEJrA2/gk9KIaJyJQIIiXOrrFBsIOwjNRNj/gZ
OHWL/799PGCZ1OwLZmk/ZtDW8lvSCa5l2kJJ1EM2MddM440roIPXg3PCL3oMHg8T
wlCMUdkDwHZd3j7S+gW0ZAeHcMah0gP4vp4C6SWap3WyVAD8qryOXosvWbGp0l7l
Db6ZFLaRNxAlWpDrHn2zOSuxGcniQ2gaBEOZUz3K0C0GCx13qa84szJEYG2R+pJj
esUghrhmuw7g/PcCZ9cq282GqCDweeAs8++VmxMFw+g3XpWb9z6uAM3E8E3uhQkb
7YIgv3pK
=obVZ
-----END PGP SIGNATURE-----

--y3Qz8DKGCVBrfpnz--
