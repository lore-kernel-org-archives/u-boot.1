Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8117FC25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 16:39:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A2898825A;
	Tue, 21 May 2024 18:39:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qWFyRXdO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5A99882E0; Tue, 21 May 2024 18:39:29 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E14A881C1
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 18:39:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-792c7704e09so362385a.1
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 09:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716309566; x=1716914366; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+cbwW8k/AcrWkyS7KOPW+jzZPo4ERSBBjqnu1lUyuY4=;
 b=qWFyRXdOD00MTZxFXHFDnwV6idEi/QDFgFwSUvOTDQtGIp3RkLeVFtkyXk6qP0iDk8
 pAJOAZs8jY/Qb4J5jkxMC71D6/XrtxOv8FyFBTtPzt2YwTHsU0/cWy9jiUuOK1YIFMJc
 Hee85OuMOAbudyrwSsE25xPsaHGUofiTyrb3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716309566; x=1716914366;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+cbwW8k/AcrWkyS7KOPW+jzZPo4ERSBBjqnu1lUyuY4=;
 b=YlLNJ1VvMHQcX7JAHGjgH46wXzYpEdKPaCeCkhY3vMM6ddIqf5DvUbinhxK+U1opLe
 RYNCzaLg3Cx3bjYYDT7LCA07icz4/70FFNqzIA1rnKaoQlJALfbQrKPBYaNd2wtlTtjr
 chLwR5SBQ6xDADCGfv3IZjA3LhwWHlfdr10MTGbIgkkvTeZTtrEm7Oev4yd6zTk8rAab
 9nEBlY+h8DI/FyC5BpZpf4IQpnJ6kdz4ckm2CpYemVCDf6mdnUASF7XGOEVWOOpqUYuW
 7hC1jTvzhVwWfiopmVNRi0jC7fnyX2iYCWPx/FdAnkQv5mUmOTrh5fPJE9mY35DRqazq
 lwrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcWF7jPcZI0+BzOxkgSDR4UHTzd5NIZZ+D4TmRXcvNgCUAiHl+CrabltxZ4iSJE9rUxD+1WJKnrCeIRT+cUtjDI9+Iog==
X-Gm-Message-State: AOJu0YzHqEftqHMtr8SWJ4fF5DrZnqATjgJsVd0tr8td0Q27cVlJOfJa
 HQR2MbTXtc/RDgA4TvqRE0NwP4W8wuRn9C63KYrKqAur+C1fhPNqPtUu4raXnBo=
X-Google-Smtp-Source: AGHT+IH1cCwWJryEdo6NGxeZzA8R/2Dr27CB04gVycFD9Do3yEiV2IlwBAn3FjQJ+VfFbUWjvdud2A==
X-Received: by 2002:a05:620a:2697:b0:790:c18f:5d94 with SMTP id
 af79cd13be357-79470ebc401mr1645563785a.4.1716309566291; 
 Tue, 21 May 2024 09:39:26 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792e36d8d9esm909393285a.110.2024.05.21.09.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 09:39:25 -0700 (PDT)
Date: Tue, 21 May 2024 10:39:23 -0600
From: Tom Rini <trini@konsulko.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>, r-gunasekaran@ti.com,
 Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH 0/2] Add AM64x Support to PRUSS and PRU_RPROC driver
Message-ID: <20240521163923.GX2568172@bill-the-cat>
References: <20240430104633.1445311-1-danishanwar@ti.com>
 <171536955294.3410219.3302090701043655645.b4-ty@konsulko.com>
 <26c9c7f5-1544-46b2-a3fd-3a4d01c2d813@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="e5DnMr3YNjYcoohg"
Content-Disposition: inline
In-Reply-To: <26c9c7f5-1544-46b2-a3fd-3a4d01c2d813@ti.com>
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


--e5DnMr3YNjYcoohg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 02:31:44PM +0530, MD Danish Anwar wrote:
> Hi Tom,
>=20
> On 11/05/24 1:02 am, Tom Rini wrote:
> > On Tue, 30 Apr 2024 16:16:31 +0530, MD Danish Anwar wrote:
> >=20
> >> This series adds AM64x related compatibles to PRUSS and PRU_RPROC driv=
ers.
> >> This series is a prerequisite for ICSSG Ethernet driver.
> >>
> >> Once Support for AM64x is added to PRUSS and PRU_RPROC driver, I'll se=
nd
> >> another series to enable ICSSG Ethernet driver for AM64x as well.
> >>
> >> MD Danish Anwar (2):
> >>   remoteproc: pru: Add support for AM64x PRU / RTU cores
> >>   soc: ti: pruss: Add support for AM64x
> >>
> >> [...]
> >=20
> > Applied to u-boot/next, thanks!
> >=20
>=20
> I was working on the latest u-boot/next (d4781422d1 (origin/next) "Merge
> tag 'v2024.07-rc3' into next") and I don't see this series being part of
> u-boot/next.
>=20
> I checked the git logs, you had merged this series but on 18th may you
> committed [1] ("Revert "Merge patch series "arm: dts: am62-beagleplay:
> Fix Beagleplay Ethernet""") which reverts bunch of changes and as part
> of this commit, this series was also reverted.
>=20
> Now when I am trying to verify ICSSG, it doesn't work as this series is
> not part of u-boot/next anymore.
>=20
> Can you please pull / merge this series again to u-boot/next? Or do I
> need to send these patches for merge again?
>=20
> Please let me know.
>=20
> [1]
> https://source.denx.de/u-boot/u-boot/-/commit/d678a59d2d719da9e807495b4b0=
21501f2836ca5

Please re-post based on current next, sorry for the rework.

--=20
Tom

--e5DnMr3YNjYcoohg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZMzjsACgkQFHw5/5Y0
tyyHQwv/ed7yj5fQnkzAZqVlREcmubT5inx4iI4eZO9NaEbf2vvmTgZCes8b/XnE
x8pEoYgxsqI26RLDX8LDglwmGYHhhsBKWR3dM7W/+z3bqQr4IHuZkD1N1+Mab5aW
PVwqLvpu/rnrNNg5gzTJAxjw/iLob/X//AlvdaeEyOcaNR44nWC3iHg4Cdgj2YBn
HqaSOu/MToN5h8AV1ThzOt6gsTedsa/k6SS0fGZS0vYjtBto5J4h7sQNvAV2POWi
qKtyV+GMXq24xmYToRUhKOtOGIVkoGE5oVnwYlmmt5FpJgjj3DGta2py3j+AUR4g
Bx8zFAo7XnUVVBP7T+LF2Ry/K9jfJ9ix4U1UtjdJXnYEi8Mhj/XUuAJfMBz0sOdV
vm5lLFQqfG68fAXMpgnc7dZM61jg1SLJw0TFThdlenYicGIZWG0IUzu9bL9XCRCA
8YM6960VsO2DtQzekUvYjJQQGDeZSGo0+Hu2QKE5RUFM0X7l1rk05ZF9rQ1M6MHr
klr1BNPY
=uGeQ
-----END PGP SIGNATURE-----

--e5DnMr3YNjYcoohg--
