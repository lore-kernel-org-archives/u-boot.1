Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38BD9CCA471
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 20:37:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4C3A8384C;
	Fri,  3 Oct 2025 22:37:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VNOVcI99";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18E708386F; Fri,  3 Oct 2025 22:37:43 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F09B983826
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 22:37:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-42d7ef9a402so15301055ab.0
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 13:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759523859; x=1760128659; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wCL2oXe+K//D0CNqGymXIWCcYUk9QpKlHUJ/jeVdEAE=;
 b=VNOVcI99Afr+erQXE72lYbRPtWZ5nDzCLUcChTI8mF2B7fxYDwOUm1c16dhOs+sz2Q
 sv7B9hcKqrPmKnHdZiMtsqUEEZ2G1/bsTkCH14CEM6gQp1zciyw5u0SDg+y1tNmsP7s8
 wtaxmO5vPj9Q6L+vAq9Xzr/S7L2pATkqkPd/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759523859; x=1760128659;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wCL2oXe+K//D0CNqGymXIWCcYUk9QpKlHUJ/jeVdEAE=;
 b=PZqAOpqo6+wSuoB+1X/Y6kzSPMynzrHQAVVhAujSIw8SABxSX7ZOqN9dr3czerH/3j
 gTFVs6vqZGiqKcjeKVjcnQfSjqtMiwvPHNc5aondmU76IP7tsE6WZmN3RCZL3vT7xCka
 O9ZugH8YGZW9W3gtUee8oa3vIG1scvmGQ+u9TIONi2wT5j6IieYWMO9CsWh9Ok/1kzr4
 ZvtNn7v7Bjs2VPdnFArO8S2P/GWQ6QAjdEdEcjF6TJPch1mkF/C6GA8mRIJsat4RYN5M
 SiNWE3wgLJKSELmAejts6MjfBIhYGNETn6wToQFHlX2JLltjhgr/vOUwfC9PqKp4DQEQ
 w1kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnKfbPA/6RgakWvpk9dsm+itCy31APIwN/roIQ9mE7CxO4nmGJ+pVXL/ZTeg2EewVry64+f5s=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0GVl8wxKTHX6CEGV9HQphKKJH79T0DW8wK+P+HGvn4TQD+YwJ
 F/+WbUpfdS6cEH7+V3RuxOjFH7Py6T9SZIiN8o3K6IkMthiXRxdP/bHWOMw4Gn9S+Gw=
X-Gm-Gg: ASbGncssdAIgnpn0jKeWjhrA+A3FClZtppIZGpp1wAVjZtTPOOQDNtxfxDf59hiU0VQ
 cvdfL0yI3/ve+ZE6BfIHu4W/8tdQVxvigYrtT9DNAv+UrD1013IiC4mEP/p2IgZjhs5bbtEK/dd
 svnGzLwa296A7J9EjzmgsD+V19Fwu+R8G9/F5+d6MGW8yrIUaIbh+eZrblGb0J3skOCqksKL6pO
 +7c+SSWucxUa/bI5pbN0H5CNWDR0sBekJTdKB5EwMo3kTgtI0W89yiuwfu3UcQBz9HSk+WtRcDp
 4SSm8TVNWaswf6dOGod85+a7IV+6HV+4hWZIEp0KStwjfAHYC+MvO6BOG3QXTjozswsgnvZ0hTD
 tRCAV7SLV/rzwmn9v1xcI3dM6i7Dk+qHfROaJCVDP80ZCG+pNSxmHS5i6HLPmvd8fHtOEF+WL6U
 OY8QlLKm+CBWC2/z3iLKDX
X-Google-Smtp-Source: AGHT+IFeZb1Q6oc8ICVfnP+Dd3VqLwL6L5RTPKJkpD4MsZZHpy32fAz6afogZiU7b6XrNiiDkSe1Xw==
X-Received: by 2002:a05:6e02:378b:b0:425:86d9:91ea with SMTP id
 e9e14a558f8ab-42d8b215f76mr86140045ab.11.1759523859067; 
 Fri, 03 Oct 2025 13:37:39 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5e9eb49fsm2235007173.1.2025.10.03.13.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 13:37:38 -0700 (PDT)
Date: Fri, 3 Oct 2025 14:37:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Simon Glass <sjg@chromium.org>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 00/16] Convert extension support to UCLASS and adds its
 support to boot flows
Message-ID: <20251003203735.GW6093@bill-the-cat>
References: <20251003-feature_sysboot_extension_board-v1-0-458b8bf85325@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YtiZC8emcbeTvHvb"
Content-Disposition: inline
In-Reply-To: <20251003-feature_sysboot_extension_board-v1-0-458b8bf85325@bootlin.com>
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


--YtiZC8emcbeTvHvb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 03, 2025 at 06:33:40PM +0200, Kory Maincent wrote:

> This series converts the extension board framework to use UCLASS as
> requested by Simon Glass, then adds extension support to pxe_utils
> and bootmeth_efi (not tested) to enable extension boards devicetree load
> in the standard boot process.
>=20
> The UCLASS implementation provides one driver that manages all
> extension boards (alternative would be one U-Boot device per
> extension board). Simon is that what you would expect?
>=20
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

This seems good overall, thanks! I'm assuming you were able to test this
on a few platforms? Which platforms should we try and find someone to
test this on to make sure there's no surprises down the line?

--=20
Tom

--YtiZC8emcbeTvHvb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOA0CwAKCRAr4qD1Cr/k
CnX2AP9yKzDYdNxPnirUlwl0hvSmYEPq45VC9EzbwZcLPmSnuwEA+KypZWFQx9Rw
9tuYea3A30V0WHwNNq3GvittncOJogE=
=vG7K
-----END PGP SIGNATURE-----

--YtiZC8emcbeTvHvb--
