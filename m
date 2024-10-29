Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3646CD3A694
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 19:12:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DFEF88DC6;
	Tue, 29 Oct 2024 20:12:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cftBp+7D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2F1989185; Tue, 29 Oct 2024 20:12:37 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFAD988F69
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 20:12:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-460ad98b031so37536741cf.0
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 12:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730229154; x=1730833954; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dq3NOkZymPx7CdqMv29snOsQsqY4VphTm2WK2py2irM=;
 b=cftBp+7DxMx2YJIDkolGqU+DwEAQ+p0Nz3SMg5nyDGc6m3LN0Crrfnfk5GNv6DNDHO
 OYViXjNg+4cA4UGJcjJvUHCMDEy3wVBpwboeAwVt0R/NFRJxvSx3oJZBc0fVJoksvv92
 FurlastQwtZSsGgynRX/b6YTP4WHYidmXCWjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730229154; x=1730833954;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dq3NOkZymPx7CdqMv29snOsQsqY4VphTm2WK2py2irM=;
 b=Hv+xRQJJcG5y8qLU6WmOSpPflYJVwCkghZYEMw12wUBS64x+h8IU5bJCjhp/be7vU+
 w5/82Rw8oCkNquurofw1C2Nvqr/FwK8NxESEelTO+1l0t5aMBwts0hDjqnfpbD3JazX5
 +zm4sQZIUUdeDIoLjD5Y5KBRpkNVlLACO4LEPljYn2XFjkg969N3Mq1oBdJRY4mG1IDT
 9QP1wHLxd3Gc733JIrgaVRlStwX5tgiYgY61reHAbwuXrs4a+JFKdC+n9dRsVbFHdwlw
 D8jV0uQjTfccedP3MFebXqhWM9VYzm/nlEV834RXBmbE4h5nXkkN7KouWMj4Ue834IEc
 FCug==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2pkily4uks0G4o6UZzDsq9TTO5dyCVCVrtvFii7VdQmNw5XJa0z/fJGsXd8y6Babkh2E8lN0=@lists.denx.de
X-Gm-Message-State: AOJu0YzLAeVi8Mvdha9I4DGbaWn+OAlKTPtwrDN3HxjJ/zdZS1W5wPkj
 bggrkFd7y9hBfMgRYt73n5L1yNE0qJK0bAtHQdrH8HnMNgFg2cqR1b3nzzZfF1U=
X-Google-Smtp-Source: AGHT+IEJz7N8LrUZ9QiSPYdDSJmZtqgxmfwdIzo96nDE8d6xQdUx6tcbZuXenYagcbFaJpSfyR2DQw==
X-Received: by 2002:a05:622a:148f:b0:461:1396:96fd with SMTP id
 d75a77b69052e-4613c046cddmr187878381cf.25.1730229154518; 
 Tue, 29 Oct 2024 12:12:34 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-461323a9640sm47345361cf.91.2024.10.29.12.12.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 12:12:33 -0700 (PDT)
Date: Tue, 29 Oct 2024 13:12:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: michal.simek@amd.com, hs@denx.de, pro@denx.de, sjg@chromium.org,
 vasileios.amoiridis@cern.ch, u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/1] bootcount: zynqmp: Add bootcount API
Message-ID: <20241029191230.GG4959@bill-the-cat>
References: <20241029185814.7937-1-vassilisamir@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wbOY02/RRTnFqVkb"
Content-Disposition: inline
In-Reply-To: <20241029185814.7937-1-vassilisamir@gmail.com>
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


--wbOY02/RRTnFqVkb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 07:58:13PM +0100, Vasileios Amoiridis wrote:
> From: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
>=20
> Add support for the bootcount API by utilizing the internal Persistent
> Global General Registers of the PMU. These registers get reset whenever
> there is a Power-On-Reset so it makes them suitable for the API.
>=20
> Questions towards reviewers:
>=20
> 	1) Is the licensing of the file ok?

Yes.

> 	2) How am I supposed to add a maintainer for this file?

This should be caught already under the zynqmp regex in the top-level
MAINTAINERS file.

The code itself looks fine, but I'll leave it to Michal to further
review.

--=20
Tom

--wbOY02/RRTnFqVkb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmchM5oACgkQFHw5/5Y0
tyxP0Qv/eOGdN6R4SqeoY1lg/ASwwxye3x8o6gP1S1lMibiUjA5xcr3nbU3dlrFP
g71jg4b+GSrjhTVtni9EohNgWdcBE6RjgMJqd+T9aiALtSsEt8c3Auyw1HpHs4ry
bOt3tVY678euJesWQiN85IsFpW3zC+6PgenyIN7d55+uY18aMmBvcAnT3kCJ7yep
OomsaZjL4fnJBumHgRwtIjuq4sEV9Y8qBx5lmXMtiz5yE4MAfgBwdLe/uPxpFDBi
xFOGhU+LcGE/PslYQup8desfIZkTShvu9SpSG38xsdOV4irr2hdD7RhdjWc98E+m
abPpY3YRcbvSJoDix7xgG7UYY9COMKGH9U4j/h/2B6Cg1L2auFCOs0YdTA3vg73n
/1F4QyVendWvty5yjJxf/RgJNry33/+TCxX7VpVCGtp5W+CLR0XCqtJklh9nuVDX
jV13XXsbHgdvnwi/5SKfqAH1zN3iAM0tERg0NRH3MjulUlRGxNWRmip9ZHquQmwH
RDvIlUtX
=qAn/
-----END PGP SIGNATURE-----

--wbOY02/RRTnFqVkb--
