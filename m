Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8E2CD5BB3
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 00:05:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B64A2848FB;
	Sat, 23 May 2026 02:05:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qBJmqY0a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A97C848FC; Sat, 23 May 2026 02:05:40 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28C80848EE
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 02:05:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-47cacb4ed99so5008383b6e.1
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 17:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779494737; x=1780099537; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+gpcYXXNhPzaqXHRRXfLKCw9iFj60CsqDv3E1nRCuro=;
 b=qBJmqY0aQOcQcmccZw/tO1dBaykDc5UNfCYLD7usqOMNvPcfOl9eO1gSMsX2Lc7mNf
 Nxvv0iQ+saGoVPeqvHsEE5CV0mIqjdyCkf+7O4eSNAeCOZmlL0RUy5aSddmxwlCcTOwG
 JQZUHDLe/Cd09g6nSo0a3x8nS0CAZ8YizEFwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779494737; x=1780099537;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+gpcYXXNhPzaqXHRRXfLKCw9iFj60CsqDv3E1nRCuro=;
 b=fuAcLfWDuGxiqrM8BbK4MHAp/dgpM7vpk/M34mJ+vU4i8WWbDj5Wo+SpFBSGpwWdC2
 ZimLYCEcPD+rm2Djjxm0jyzJbYuv/TjFGjkw54TkwdZxI53Am28dgc+tak1tiO/WPwY+
 V3j0IdU2cLfhmww9s06OF56orrJDSldW01H49LKOboS9l8m2rKGGH+VoX/6RM9P7C6EU
 OTDr6Qrgl31KIUfda7gZVZD8FjVdc2ojy+5zNaIWwsje6C2qA9zjB7/+ruUF5VY2i9+1
 EwlUtJQ60RHitzWGAYrG8Vjnk5GRrQaLdzUvQVEZfBO9znKvCoEw267vmypQ1xk+T3JM
 rKkA==
X-Gm-Message-State: AOJu0YzQ2ZDTj+8rqXFaoEKh+lK19Fk6Tgah0vTb7fTDwslozfFKD9Gj
 bKTtjf5J1H/C9lHpkMCXvff3A0PmxJh3c2vdrZ7VGGnM+3xDr5o02zLroHFv0Tun0bwwe3izCet
 sPnMmUNw=
X-Gm-Gg: Acq92OHG7fRwdJ6Pi3VE6UASfI/L2Y5Pib6zjcyjCHcPDPFuTpvQhMROHMtK7rMaSrW
 A8BHvxmIVwxflBj2gPLaCXCq6XLwxwhjpeBJjLQY5gPoxx1GZz8q9dXVL1DrcLNdrMzJCAycMc2
 Gu141u4NOedHLPJl74WCTdx1HyU/2YuvFKa+pltSyFmvzPXDsfDIy9M4wNnCgkr/HGkJzewbEVi
 CW2yzZztpbGn/+qp41ZgZffqU1YRyHlTqI6Ok8YrajMU3hp65dNA3HaMq6ySzTE6ymfPQrmgsB/
 wjK7JHD3M97HzDdyiinyqMa3sSFYXcnLTBmg9nr9bgzq9ZWEeGTHwa1jRKNzbBJTpiJXI9pkMt6
 ek1PNlJ6GqV3nEWCFw6HfBFt2CuC5vHq5VWWt31zp3TDffotL6rZ8qac3IbQbAb5j1qLTEaGuP5
 Dg28ZjXur6Dm8dslmHhUR8s9xmr3dYmlGQtCdmFWeGxuNCU3VOpQGNZaCnihOBbpnTH3IVrVERi
 6VlqFJK/6QZ98NXBlF15Yfvqz8e8yPVXT7SUpnRfNnab21yQ+hRYSB8
X-Received: by 2002:a05:6808:3a0e:b0:485:403d:9b8c with SMTP id
 5614622812f47-48549ed03e8mr3586079b6e.10.1779494736764; 
 Fri, 22 May 2026 17:05:36 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-485545093cdsm1312835b6e.6.2026.05.22.17.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 17:05:36 -0700 (PDT)
Date: Fri, 22 May 2026 18:05:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [0/5] Remove some empty bootdev_ops structures
Message-ID: <20260523000533.GF1858239@bill-the-cat>
References: <20260519152101.716714-1-trini@konsulko.com>
 <CAFLszTh3vk3FbrOXWrxY1JP_Se7ewuoQhHETZhjrkKcQLZ5pzw@mail.gmail.com>
 <20260522150014.GQ1858239@bill-the-cat>
 <CAFLszTiNu_pQb9Lzuy3R6wy5-KE16NSh93EUcjfJRZhLuVSX3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fYIWEpqwQrnfFT/C"
Content-Disposition: inline
In-Reply-To: <CAFLszTiNu_pQb9Lzuy3R6wy5-KE16NSh93EUcjfJRZhLuVSX3g@mail.gmail.com>
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


--fYIWEpqwQrnfFT/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 05:14:54PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 22 May 2026 at 09:00, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, May 21, 2026 at 05:30:12PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On 2026-05-19T15:18:15, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > > This series fixes bootdev_get_bootflow to not require the ops
> > > > field in the driver to be set and then removes the empty struct fro=
m the
> > > > places which had been creating one.
> > >
> > > Two more empty bootdev_ops structures fit this pattern:
> > > nvme_bootdev_ops and usb_bootdev_ops. Please can you fold those into
> > > v2 so we clean them all up together?
> >
> > I'll follow-up and remove those later, and also update the doc and
> > remove the mmc one.
>=20
> OK
>=20
> >
> > > > As part of Marek Vasut's work to add static and/or const to structs=
 that
> > > > should have it, but do not, it exposed a small problem with the boo=
tdev
> > > > uclass.
> > >
> > > BTW for patch 1 it would be useful to update the comment for
> > > bootdev_get_ops() to indicate it can return NULL - normally, we don't
> > > allow this.
> >
> > Don't allow which? I get the feeling you're saying I need to audit the
> > reset of the uclasses for optional ops fields and then see who is just
> > setting an empty struct and fix them too..
>=20
> No, I just mean that there should normally be an ops pointer, unless
> the uclass itself does not support any operations. The case of using
> NULL for the ops pointer is really just an optimisation. I'm fine with
> it, but it might create confusion for people, so it would be good to
> document it in the uclass header file, where supported.

I'll make sure the documentation is clearer in the follow-up series. I
think at this point the majority of implementation do not set one, btw.

--=20
Tom

--fYIWEpqwQrnfFT/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahDvSgAKCRAr4qD1Cr/k
Chb+AQCTaomeW7NCU73vuYoLKUqsfr6V1ziE/zf8pa0XIC+LSgEAgvr63Ch3GASH
xkW0kmXqur91y/uWhiFVwVvpPDWA1QY=
=jsIR
-----END PGP SIGNATURE-----

--fYIWEpqwQrnfFT/C--
