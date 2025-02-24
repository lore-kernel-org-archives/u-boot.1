Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00CB5C021BB
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 15:34:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48EAD805C3;
	Mon, 24 Feb 2025 16:34:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tb8Ic+EG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DD2B8081A; Mon, 24 Feb 2025 16:34:46 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B9F480079
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 16:34:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-220d132f16dso69992725ad.0
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 07:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740411282; x=1741016082; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=o3SsOQnW05A019jAUoe3hl7qDXeMpj87lt99TMM+PN8=;
 b=tb8Ic+EGlZjmmesxJNeb1OSOfMqXDUQoCYvQVYDn0R3VUm87KviPljA/L6ROieGNEQ
 t0hqM/nWifaEAgfJQf0AFVmgAxhocZYXNTHF8oBHaetJPb3tiGvuV0yTqUknS3jKaYoN
 uiy9qHpykCr7R6LQJU9uCgCslzihheOn5T7Ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740411282; x=1741016082;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o3SsOQnW05A019jAUoe3hl7qDXeMpj87lt99TMM+PN8=;
 b=AwxJ5bcPme8yo3mHnspDPbK8IGgHtTv5KPjqoSkaV2KrXZQBWi3uHB0k1Ub/nEOJpc
 2VLTg1YyCJIYKM4BMiQ4YsrGXmrOw4Trrc8JebUtJGvdPSmxNi9upd3Hd8acvFK9uJw9
 zSQG+GSMWpB7ARL0imffmkp+niEPWryRGYiNpNbNjHZf0B988ddDWdwlNTxYhQRtG64h
 +B1g1kqT654B7pH70hgzwagdxnEDZq/fPircOmzwgAAEbkROJYWSs6IJuBDB8dCJ/EVA
 ESZM9Fq6bp6slnJGQA+nNgaYKFsDqUwLxLdnifkXkeXO2ZO3A0mFNabcKyFdlkmg2LBw
 lbxg==
X-Gm-Message-State: AOJu0Yy7MXXgKMW/MnKeEDQCJPRh1Fjf8eWEUUZpGnsU6O7lsO0fwywE
 JmNc50tmEX7PfKjjXmkqiyg0l/LnoM4DGFGiGU4syArcsYEq5tqPG2Lxtf4DnGw=
X-Gm-Gg: ASbGncs68Wlw1BIwD6x0lFqXEucC67e6pvNZhzWyM3OaqPUdMefiIhqZmd/Sg6gLjcy
 f/SziUfv0ei+1M0yuaUuzN8Xk473TGRb8FUvDECySxjyYex7OhtueLDtjQ7GqDPyadF0pLVwXO4
 Gs9Tdx6sl3uvyEs3okwvQqlUIvBCVGrqxuUA/43CcvWVtWQyWbkyr3RvSJ3B9gKV9evXZVQJwVc
 Air00pldKjJms+YgIrlB+xsJzjyorpLFwcysQfO9x8Fv4bqIF1hLOiuLuh9AM9B+OOchRfT8KWv
 E9OitbnOz2pPQ8JGE70M0Igk
X-Google-Smtp-Source: AGHT+IHfnyF2qnmLocl0m2vDNvh1EUUoWGAPvdHgQ5kpncJ/cGOIL37HXMauwa8pxZGwOuIsRr6aJw==
X-Received: by 2002:a17:903:32c2:b0:220:cddb:590f with SMTP id
 d9443c01a7336-2219fff43f7mr181740895ad.50.1740411282074; 
 Mon, 24 Feb 2025 07:34:42 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5349510sm179430665ad.13.2025.02.24.07.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 07:34:41 -0800 (PST)
Date: Mon, 24 Feb 2025 09:34:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, seanga2@gmail.com
Subject: Re: [EXTERNAL] Re: [PATCH] spl: return kernel image header size in
 os boot
Message-ID: <20250224153438.GE1233568@bill-the-cat>
References: <20250221151752.2618666-1-anshuld@ti.com>
 <20250221200401.GQ1233568@bill-the-cat>
 <D7YWPASRXTZ4.2VMSJ4O8HUQFF@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="z7wkcEqBFfBEgtB5"
Content-Disposition: inline
In-Reply-To: <D7YWPASRXTZ4.2VMSJ4O8HUQFF@ti.com>
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


--z7wkcEqBFfBEgtB5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 04:05:55PM +0530, Anshul Dalal wrote:
> On Sat Feb 22, 2025 at 1:34 AM IST, Tom Rini wrote:
> > On Fri, Feb 21, 2025 at 08:47:51PM +0530, Anshul Dalal wrote:
> >
> > > During kernel build process the header size is computed including the
> > > BSS whereas it's removed when creating the uncompressed image. Theref=
ore
> > > the size of the uncompressed image on filesystem will be smaller than
> > > the size specifiedin the header.
> > >=20
> > > Therefore it makes sense to return the header size back instead of the
> > > file size in falcon boot.
> > >=20
> > > More info:
> > > https://lore.kernel.org/u-boot/20250214111656.2358748-1-anshuld@ti.co=
m/
> > >=20
> > > Signed-off-by: Anshul Dalal <anshuld@ti.com>
> > > ---
> > >  common/spl/spl_ext.c | 4 ++++
> > >  common/spl/spl_fat.c | 3 +++
> > >  2 files changed, 7 insertions(+)
> > >=20
> > > diff --git a/common/spl/spl_ext.c b/common/spl/spl_ext.c
> > > index c5478820a9b..6d8d6544092 100644
> > > --- a/common/spl/spl_ext.c
> > > +++ b/common/spl/spl_ext.c
> > > @@ -17,6 +17,10 @@ static ulong spl_fit_read(struct spl_load_info *lo=
ad, ulong file_offset,
> > >  	ret =3D ext4fs_read(buf, file_offset, size, &actlen);
> > >  	if (ret)
> > >  		return ret;
> > > +
> > > +	if (IS_ENABLED(CONFIG_SPL_OS_BOOT) && IS_ENABLED(CONFIG_CMD_BOOTI))
> > > +		return size;
> > > +
> > >  	return actlen;
> > >  }
> > > =20
> > > diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
> > > index fce451b7664..ddf85e2cece 100644
> > > --- a/common/spl/spl_fat.c
> > > +++ b/common/spl/spl_fat.c
> > > @@ -55,6 +55,9 @@ static ulong spl_fit_read(struct spl_load_info *loa=
d, ulong file_offset,
> > >  	if (ret)
> > >  		return ret;
> > > =20
> > > +	if (IS_ENABLED(CONFIG_SPL_OS_BOOT) && IS_ENABLED(CONFIG_CMD_BOOTI))
> > > +		return size;
> > > +
> > >  	return actread;
> > >  }
> >
> > Some image formats include information about the BSS as well, and others
> > do not. But this is just having some parts of SPL return the filesize
> > and not doing some deeper probing. Given that usually problems like this
> > arise from loading contents in to memory too close together and then
> > getting wiped out by the kernel BSS, what's the problem situation you've
> > run in to, where, and with what loaded where in memory?
>=20
> The problem is not about the allocation of BSS section but when loading
> an uncompressed kernel image with the check in _spl_load at
> `include/spl_load.h:95` which fails to -EIO even when the image is loaded
> properly because it compares the size form the header to the size of the
> file read from the FS:
>=20
> 	return read < spl_image->size ? -EIO : 0;
>=20
> This doesn't work for uncompressed kernel image because the size from
> the header (the parameter ulong size for spl_fit_read) includes BSS
> which is not part of the final image file. And there is no way of
> knowing the file size based on the header. Hence why we check for
> CONFIG_CMD_BOOTI for returning the header size directly.
>=20
> Although it might be better to have a different function altogether for
> reading uncompressed image that can be passed to spl_load_init so we are
> not using spl_**fit**_read to read non fit images.
>=20
> You can find the bug report here:
> https://lore.kernel.org/u-boot/20250214111656.2358748-1-anshuld@ti.com/

Thanks for explaining. You should include a fixes tag and explain a bit
more about the problem being fixed in spl_load, thanks.

--=20
Tom

--z7wkcEqBFfBEgtB5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme8kYoACgkQFHw5/5Y0
tyy9UAv+K6V33ew7O0FmwRqOi0ZJM3q1mhqfgraJXOmJAYaPD29lpVw1rvUCFh3E
+N+snLie7waXBgbvO3YZa7AfQinOU3D+TsLCozbYL9Upj6fDqN6BfZpcFyZ4DEj4
3EbLkAidkRV8qr29jqjFKznSnjy5DWMaltk0Tcs85bD7fsnnhIDpYO8o4Iwc7QCw
jo7K4HiJEduMVN4LkGl/iJ4SibhOpLEce4iUbiaDPbbZlu1V5a/5bwF51VY88lFO
yoiLADCe13TRnLmi/Avj6qiP9suGGVulYA96sQQh+RRRQzT9D3MnQdwtqDa8XnAS
Zf2AiDL8+AJFtNoF5XY4nm3OPBB/AitUmQ3nYKqUhjKSR89mMIe4td5b2cxg/M8M
WpEMrKIfIp1VPBcKkX1lV48Cpf0qKyB3V4DbgVutEmvQtGE/NthcMnxuFNM9WnCJ
O4Ox2kGsaYoxHDLRVVRMwiJy8Y7oFK/qZwf/+Aj2RJn6X49zzzRmIQ717ENb/L0q
12IERdks
=AsYj
-----END PGP SIGNATURE-----

--z7wkcEqBFfBEgtB5--
