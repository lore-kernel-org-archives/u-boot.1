Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8162FE7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 16:57:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6EF98036B;
	Wed, 11 Dec 2024 17:57:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hlqs6yaZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D71D8036F; Wed, 11 Dec 2024 17:57:16 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08EE7801E7
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 17:57:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7b68e73188cso586967285a.0
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 08:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733936233; x=1734541033; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qE7YFJe2zqgY/w4uomw3QfsncqtMGLq+Y9M7+nriQ7E=;
 b=hlqs6yaZ2DkB1BY45VV4rUfYa9lNxn181Mw3BopbwuEKxrWRmME/2g64KRetJ3CUAN
 jzqIAW0z8bGKILje7mRgdA+D4SMtFyDg6O9QOrw1dTrtj1dNZkhRxGRlFsLiQ/+J6PWI
 mWlw4aLuT64JXDrugtKLnNtFu6Dng0VEc/r8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733936233; x=1734541033;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qE7YFJe2zqgY/w4uomw3QfsncqtMGLq+Y9M7+nriQ7E=;
 b=YEcn7xA7OHGbBQUVrbiKqYSgv/LCv4ifONJIJ0pboPHHaW/saB1hfuUn0Ta7e53TOt
 8PVW5x+wf+hCrHOqyUnTTm4EfDEJjIqa+Y1IVBD2/Z4yos0tunIS1IiJ9nlSCFhPa6tQ
 Ksu0KzQPFPeuVSKqiTif7GLSNUEKFACobPKAnvcCB48IJ61/5pCyIqB70iaUGbcNw2cl
 nvsBsNwyarAzLsgy5FvWfQUR8Z4LDf4OmeQSHa8gBnmD0/SBiDDfpf1sz3HebJyUEBOr
 cTDfKClnkm1PE3Rhryzo6+NGM4eHCI5VQ38Xg2Sc4iYTLi31ME/GDRtW7L4u+M2rTuMK
 Zl/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXhq1Wg0w6DbBh/rBvDwWtyI3tFXQa9km5iDNKOUnuQ32unBJiGfkHOLeeIxmXF0OcGqI7zvQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyLgtM0NFhCxVW1x8pz4QZ/qLZ/Z7/qbRGSSPWPgcFaGeF/lkQl
 CsR2NAKJPsWi2pTVTqSGk0KdxVMTX0EhwoGJJ07dcH5eXqz/7yDt4iP63Xpaxz4=
X-Gm-Gg: ASbGncvddSbyRZsZlLWwdfZn7eGmXWBjCOPsSqAkkNOGxoJSJDjTh9K/29L/7c4ARGf
 blbkPWvKr/bMcLpjBskAOeOdcEPjFTNFMe+cmfjWSO4unsCC1yzINTVg/q/L7820+MygB00gOGV
 BjQyoaw+m18Rs5t2BctxB72G+offjYKzdyBAg70nZVYt03EW6N8wXqPYe4irx7Fe+lzUihOXkaB
 k8WyeXKuse7+OQQz3xliUSxxpzXqAZiIwEYmMhBqFiIIZevqymQAg==
X-Google-Smtp-Source: AGHT+IEQOyTSecAbdY9Bb7BhuasRKH5OyNxg5QksThu57BSeHEtEYWvoxk3kj3OLZFz+WcrdxvMQ0A==
X-Received: by 2002:a05:620a:460b:b0:7b1:52a9:ae15 with SMTP id
 af79cd13be357-7b6f2527e95mr1190685a.9.1733936232725; 
 Wed, 11 Dec 2024 08:57:12 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6b5a9e348sm651066385a.101.2024.12.11.08.57.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:57:11 -0800 (PST)
Date: Wed, 11 Dec 2024 10:57:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Stephen Warren <swarren@nvidia.com>, Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH v3 2/5] rpi: Set bootm_size to 512MB
Message-ID: <20241211165709.GG2457179@bill-the-cat>
References: <20241209195528.730260-1-sjg@chromium.org>
 <20241209195528.730260-3-sjg@chromium.org>
 <CALeDE9P3GJitSOCA3w2RfZc-nJp3zdYQgz2rpg_CzCbhep84Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5G6TxZuX8M6OHL2X"
Content-Disposition: inline
In-Reply-To: <CALeDE9P3GJitSOCA3w2RfZc-nJp3zdYQgz2rpg_CzCbhep84Ew@mail.gmail.com>
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


--5G6TxZuX8M6OHL2X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 04:27:42PM +0000, Peter Robinson wrote:
> On Mon, 9 Dec 2024 at 19:55, Simon Glass <sjg@chromium.org> wrote:
>=20
> > Set this option so that all boot images stay within the bottom 512MB of
> > memory. This should allow us to drop the fdt_high and initrd_high
> > options.
> >
>=20
> How does this work for a device with < 256Mb of RAM? There's a number of
> the original RPi series that have 256Mb of RAM and that equates to less
> than that due to reservations for the vendor firmware.

I based this on the previous thread that said they all have 512MiB
minimum, but I guess that's just the newer ones that are 64bit too.

Top of my head? It's been a decade, but I _think_ as part of the
relocation we see that we don't have memory a base+512MiB and so go with
lower, but I wouldn't make any wager on it and would rather test (which
can also be done easy enough on another board, just set the limit to
more memory than exists, see where we relocate things to). I'll try and
try that out soon'ish, just neck deep in a few other tasks atm.

--=20
Tom

--5G6TxZuX8M6OHL2X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdZxGEACgkQFHw5/5Y0
tyzlzgv+Peco05GzCsPdw1ryQqejAH53wB0c1Phw9ifzvsn1Ba4Jbclp1ljSJ+A4
HU736vrJhX931NC76zLPs9HwhTjVObqAPaYIo9F8CHWKVLG8Pqzc424CmyJ/0ed0
CsdKB0lVWuc5mDnP4gfzmuKOHntwen/oAzm216ftmJRAtxXyknwO752Q7Z3K/YKP
AZPp8B2rh9P1ixoBlpyx7nyQqTJ+7iKwMrWGXoYUIys5rTNCKKDTKzdkkmsqxxSP
MRd1ZvMS5PEXSCVOlgqnBCa1y9wLDMcEu/HkrlMySs+eNhGBDw5Hrm11XmT75FJz
7ectBj52EX2hTcjtO8Mkw//r0m8jGGYjdX77RCkoi+Z8MCjED5p4BuW515JmCJSD
/alPaBa7LuCwqszCNTcii72X7a4NyJXjeA6JLriMDkIUNyS8VfYXSBBqQp+az3J7
yy5RNL3RIsdCdAc9X5GAhbY+lp0QUkMHblCWtD4SEaFy1nsCaYAWxgPtLUpfgTUx
wSGqK93q
=UJQM
-----END PGP SIGNATURE-----

--5G6TxZuX8M6OHL2X--
