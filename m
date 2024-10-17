Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E6CD374A0
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 14:26:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C96F89011;
	Thu, 17 Oct 2024 16:26:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ahHZfVFW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8649C88FF6; Thu, 17 Oct 2024 16:26:20 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45CEE8901D
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:26:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b15495f04dso22162685a.0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 07:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729175175; x=1729779975; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AeTKZQFGMVQMJm/TK4AB6a6/vwILx0BKUranQVcxiw8=;
 b=ahHZfVFWEgzTCKPvI/2uiXC1x47T6IYSVFAWBjF2u5uVrQ2JFW1NicrsxSIXsYsrpn
 /qKhs7tMpgpZpTu10Qnoj9dC8tRl6WF71Q8k20o1i2cIdRWMFl208jVkwltFRZBN/0CA
 nmZJh8ikWsPNZUoCzaaTPf1yx9Oa0AnBVoXcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729175175; x=1729779975;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AeTKZQFGMVQMJm/TK4AB6a6/vwILx0BKUranQVcxiw8=;
 b=HUpWq3ITku8jyvJx8UDLVjuL32YwW1BfBaphrKhRmvmEOfx7Ngp718V9woAoji023A
 hWV1NgEUwSxqbZv8rv5wJMlHMa/ZSufL9VWC6AvI9p050aRvOP8QuSPMFH/iG3eUoRTo
 sYwinSJ/kGbiGA634vxu64HQiU6nzfQXdmrXo7wYRrL0JSqQZMZ1up9nowgIW6+5iumE
 pg/uSi8V+2iQH1DHGENvYdhFUXoQSdIjrgQRbXZgQWTxxlB8XI/HVrWEcl7/0ZPg5I8K
 kMFN6CNOxRGoBjVG6zZiipgRbKbgvZf/scjTbfcPGPClEdbc9dtVpehtMF6mNhnyq8Nk
 YBUA==
X-Gm-Message-State: AOJu0YxhpImiydLfwUIPDLiAmQNMlwHX/PbNs1qylAgDpiSRko9PBazJ
 EI4CL33PAF7bGV9NBACwJ3zYSXEzPmyZgYKLEl4lGPQASmNDqF6FG9SbBmLNDoQ=
X-Google-Smtp-Source: AGHT+IHcxfFbXxoo5bnb51tWt/IFM9ksbMHfhtFsJh3ZG7P83DXzlJU0S2gHwKFV+05HDsf/sv50Kg==
X-Received: by 2002:a05:6214:4808:b0:6cb:eb51:a272 with SMTP id
 6a1803df08f44-6cbf9eb47ebmr241739456d6.50.1729175174351; 
 Thu, 17 Oct 2024 07:26:14 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cc229245f1sm28729296d6.57.2024.10.17.07.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 07:26:13 -0700 (PDT)
Date: Thu, 17 Oct 2024 08:26:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PULL] u-boot-usb/master
Message-ID: <20241017142611.GL4959@bill-the-cat>
References: <20241017031327.158132-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jw9T5oDi705EslKO"
Content-Disposition: inline
In-Reply-To: <20241017031327.158132-1-marex@denx.de>
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


--jw9T5oDi705EslKO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 05:13:00AM +0200, Marek Vasut wrote:

> The following changes since commit 608a31bdec6284ad6f821226e4c62c9cd30528=
74:
>=20
>   Merge patch series "Introduce the lwIP network stack" (2024-10-16 11:11=
:57 -0600)
>=20
> are available in the Git repository at:
>=20
>   git://source.denx.de/u-boot-usb.git master
>=20
> for you to fetch changes up to 6852a2c82e695c418c744b0fcb4298bc0e759842:
>=20
>   MAINTAINERS: add TCPM section (2024-10-17 03:12:47 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--jw9T5oDi705EslKO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcRHoMACgkQFHw5/5Y0
tyxtQgv9GM3FHkozKcsf/uWumd1DsUIYG5eAVGBDs0hHWYdE9oHLWQMDZVLKrWI+
ybVPwbr4nq/JJuWU+Ra7Al9yUI1U4TLGpKuny9hoK3HkQZ6k7eT4aUiUFO+MdlyE
C8Jy0fn+/Xgzjaqvfp3Fil3SqcK2Baw9DtCr/zxWfYjVAuWDHTka0g8sxCBVp+pP
nqkEFq20nM8s8A+MPAR1u4AYgM7EIgsqkhRjfHJ4fHO85VLce4CmJMB2jK64g+qd
l6f06ZPyWPdg4AvAlyA0ukgeUMJS799CX6LDzN/LO8kW8r5cpuBIzPBEt6vQN5OZ
xr0+BWEtIYLKQ8tFs/i8Zx6AoHLt1G3GqEs0hMAsq2onSq9dpcTYGoXGe8Y9YpxI
i5X0hZRNEVQR2hAKuckd5rcwM6/YyDn9PgaaT/MTidrWcuHG/XnDtB8I1w9c/PS9
adioghCQZg9wAvkVPRFbDlyllp5U6MMgMIBwdgH9fX1uIIMdI4zoY/L3i/UDHDkC
lfEtknF0
=pxwU
-----END PGP SIGNATURE-----

--jw9T5oDi705EslKO--
