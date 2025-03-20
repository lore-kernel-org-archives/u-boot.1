Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D29C28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 14:22:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 851B9806FC;
	Thu, 20 Mar 2025 15:22:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bJZXHDCI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B94181101; Thu, 20 Mar 2025 15:22:48 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5A2380540
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 15:22:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-225477548e1so15042895ad.0
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 07:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742480564; x=1743085364; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GNBaz0dZF2C/5pHInEds8hgOWIpKbyRjVoOL/JUfREc=;
 b=bJZXHDCIgzhevg5vta7lqgeIDlbgq3sNSTu8Er0qjSi+pGC8vjt6Ybp1W5RUZRXYLs
 e7pdBJQbuFtBZuCN3RWEMb0pNQqTMwyAhZYfDNvalA/mhEhCDJgNIwkKp+2ktI8t+33z
 sVAU5Fg/J4sMq1k+aenlEOvgDlC82pBRnfKys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742480564; x=1743085364;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GNBaz0dZF2C/5pHInEds8hgOWIpKbyRjVoOL/JUfREc=;
 b=eTxhkPahhzmj31N2HyR7cfchZSjUZFmUHfYzrz7fuEnACEyv/sEobNzknm0jXoEfRq
 u4eBgLfV2jLvwpti8KMeKhDNAWcAjkV/mANZzqYWV+yGa4cpgb4AhXqVuAmz16gn823n
 bAy+OW4v0/Z3fyLzVAci0Ek1t9KWJO5yooe3lEU59V+q8knj0AjGVJpyjQ0Va2uZWxNv
 UT+85D74p0tMN1z/g4N7cicBlbA6GGRq/bFqkXWBcoByRU1QgWGDZ1toz0wi2Pky688x
 vI6lfl/zTfHWAJH78nl9p0AI7gqwYxOaHa4vleEW9rYeVbxOTR3lslbq66yUpYIP48KP
 UKUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIRUYvPUmKOiuOPi/kvJLhVhijs+PnodJSpHJtTC73WtB3VgvIgs+5slCz6rm1LNsv/ElJcPs=@lists.denx.de
X-Gm-Message-State: AOJu0YyXIVURfNHWpO6hv52IXtu7CES+gYt9e+7Y1qpqGvqVFZ2OzBZ9
 ccRTg6Wh9CN5PDh/oGICzzCOcvAJwT1z3AzXqkAgx43piGCCxDqwOs7qkj1Endi7/XsDcJDmIBp
 o
X-Gm-Gg: ASbGncsQ84DjJ9HpFvFtNx4zs7Z54hXfsTavQUCSm6Gu6y4GjRq+0Xm+nSvjE3pqyib
 6ai/gyj+cfKwEY0cvSTo6iNFt9C7jQLbHStAkj3BmDs+aQJCkcWmbD5V1oudmDtnhN7nQbBzK4/
 oZEpbFbOmkN1nzBsBBq6i5y29Nn/e+lb15jscTfZhEBmRa8sbTL2kdp50dgeceycxfWg3Sv3+aq
 Rqf7HrB0M75zM3xznUX6NTpjIwRnNRLQWvLw6KQeTocdfkeqm/1FcMw/2wl/fU4a2iLQQaSB8HU
 mHl+b+QZ9eRIrY8sPeiWaxapC62nBAYrWXt8wGFsGnBn3w==
X-Google-Smtp-Source: AGHT+IG/+igN3uG11Jp5oj0ndIA24SFj/Lp14/okbo2lnB5sxSB/fr06b6rc/lpyv4Oz6o3LCaPI6g==
X-Received: by 2002:a05:6a00:896:b0:736:6ac4:d1ff with SMTP id
 d2e1a72fcca58-7377a819ee3mr5146007b3a.3.1742480563951; 
 Thu, 20 Mar 2025 07:22:43 -0700 (PDT)
Received: from bill-the-cat ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-737116b1ed7sm14285481b3a.176.2025.03.20.07.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 07:22:43 -0700 (PDT)
Date: Thu, 20 Mar 2025 08:22:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Julius Lehmann <lehmanju@devpi.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v5 38/46] boot: Consider non-bootable partitions
Message-ID: <20250320142240.GR2640854@bill-the-cat>
References: <20250315142643.2600605-1-sjg@chromium.org>
 <20250315142643.2600605-39-sjg@chromium.org>
 <20250318140400.GX2640854@bill-the-cat>
 <CAFLszTgCZSydxeNoeVGrR9SF7-_9pZjU+NBGXVDgXG6WzYyCYA@mail.gmail.com>
 <20250318155256.GA2640854@bill-the-cat>
 <CAFLszTjC47nk3FmEyHw13zaaWwdcEavk3JY5iewKWF65iVqHiA@mail.gmail.com>
 <20250319154047.GM2640854@bill-the-cat>
 <CAFLszThVHKU+nZhmp5ysNxqTnLJ8AMX8E8eO2zvBhDQTZ5LYNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VIfhnSaT3LK/TzB3"
Content-Disposition: inline
In-Reply-To: <CAFLszThVHKU+nZhmp5ysNxqTnLJ8AMX8E8eO2zvBhDQTZ5LYNw@mail.gmail.com>
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


--VIfhnSaT3LK/TzB3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 03:43:36AM +0000, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 19 Mar 2025 at 16:40, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Mar 19, 2025 at 03:03:49PM +0000, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 18 Mar 2025 at 16:53, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Mar 18, 2025 at 03:24:02PM +0000, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Tue, 18 Mar 2025 at 15:04, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Sat, Mar 15, 2025 at 02:25:58PM +0000, Simon Glass wrote:
> > > > > >
> > > > > > > Any 'bootable' flag in a DOS partition causes boostd to only =
scan
> > > > > > > bootable partitions for that media. This can mean that extlin=
ux.conf
> > > > > > > files on the root disk are missed.
> > > > > > >
> > > > > > > Put this logic behind a flag and update the documentation.
> > > > > > >
> > > > > > > For now, the flag is enabled, to preserve existing behaviour.=
 Future
> > > > > > > work may provide a command (or some other mechanism) to contr=
ol this.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > >
> > > > > > Isn't this backwards as the existing behavior (prior to bootstd=
) was to
> > > > > > scan and use these files, and so that's the behavior we need to=
 preserve
> > > > > > by default.
> > > > >
> > > > > Not so far as I know, but I've already spent too much time trying=
 to
> > > > > decode those scripts.
> > > > >
> > > > > If you look at scan_dev_for_boot_part, that is what I was trying =
to
> > > > > replicate with bootstd.
> > > >
> > > > The feedback from the community call where this was brought up was =
that
> > > > it used to work and now didn't, I thought. Heinrich, I think you ha=
d one
> > > > of the cases here (something about RISC-V and multiple distros?) or=
 am I
> > > > misremembering?
> > >
> > > OK let's see if Heinrich chimes in.
> > >
> > > Are there notes for the call? It would help me if they could all be in
> > > a shared document, like we used to use[1].
> >
> > Yes, they're in email.
>=20
> What subject should I search for to find them? I looked for 'community
> call' and a few other things, but cannot find them.

They're in reply to every announcement email and sent to all three
lists.

--=20
Tom

--VIfhnSaT3LK/TzB3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfcJLAACgkQFHw5/5Y0
tyw/pQwAmmy+rNP9HDWdBPZuSgrWCN4RJp20rk6mA0oGqtHymIBvGxsC09d78lWr
tkR8rFucKzSEpNMJZL8Oh5DTPuTu9T2bjzzQZCUyxmJmOoe6tuWhsL8iV4wcb9GY
aRzlFU/vtg2qsF/4uCEVwb1hAj+sVRUlSqDy0T/eIVywDINgtzhBoWFK1yDQtV+y
2+kruwkIpckX/x/OeZLyRnh95ee0+bNvfwX7DaU4ceXa8lIdPOrhtLD/VpxeVhRL
YQwMnoYhLENom3nEa1hKMA02yNhVrazLnrDLgy3pL2bYxXs9ablzDvn9SrUd0ztc
5JbfNnfrf1vd0ENLk6N5xWZfqaTZ1SEniFgR1cTo2Li5QDGuMfJ/jj1DJQzyuydg
gfxTvxRZtriS3x8F3w30Pykbk2hZgjh7ay51uFz04/VEB10akR0q4bwPfIokxVpY
vAD+inxow36NCbRp2tf3UxRgXDVPu9LygmfXSMXydrDWfYYEnUlMJE4YjS1uGcR8
V3iNABgV
=BPA5
-----END PGP SIGNATURE-----

--VIfhnSaT3LK/TzB3--
