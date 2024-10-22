Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 445B2D2C55A
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 14:01:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50EA488FBB;
	Tue, 22 Oct 2024 16:01:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dW1q8NTR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2642B88FBD; Tue, 22 Oct 2024 16:01:50 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1433288E89
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 16:01:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-71822fabf4fso1831896a34.2
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 07:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729605707; x=1730210507; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=h+NbJ7+Iar+zJGYEldTuu7/m91vrIrdMrzVpUktH8SQ=;
 b=dW1q8NTRqLolKTzIQj/lBD2gSGsY2Z8lM02clnl2yCzpzzkAEW2l9yVPd3RLotzzVR
 EynwffCKB0laYKBytgzuYHNB773eC/Mer1ietdTjpTDzMFEMi4b4AfuTXW4r+AOmco+r
 X9NLo60hQ+x/EmEsSTgL62tlxVB7Ih4gEBHfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729605707; x=1730210507;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h+NbJ7+Iar+zJGYEldTuu7/m91vrIrdMrzVpUktH8SQ=;
 b=OJrDTNoKrfjjtKpu4wVeY3jwlkEb72EtYUlkaMFPLcjgW/SJq9BvKkD69ZfKG47Xqb
 nIywrvjl4uHvkOrJ/d0FCvUoJayWE1N4ZVpJNURKVVhI2IzId7vAgwOpXAHHp/e9qzTU
 paMnAzm7tnsqzkEdi9Wf8olypAsjcexhGDSifcjk/DSZ9x1ExSiIURju4brczwJhj16A
 Yx39IAvhTsS+FMyL20lF2g7ry+x4mmWCkUsPg6a9L0Uk4bO5EZBbEK66HJBbmgZoJecl
 iyfezlGG/kJNZavmHn3yVvF55p4NnU1tDfxUJHa14Tdf5zpaZyi72zw2mLdiXBlxHZXv
 Qz4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQk4/+YLdp1fNwJ5aqqI8bJirRGh1kpeg2h5B2I/TQs7RJ+vWO18W8T+1wf7xzNOe+SjXcMA4=@lists.denx.de
X-Gm-Message-State: AOJu0Yw9lKzJK3UEMJ4dsHnhRROHqQ2lmPcDTf4++bpeMK4HK3a6Gw9+
 qPKdJl9qSUNzynKvrW2gtx142I+2bvupn6YEW6IcivogZkkBtMkM5OeHaBvYzeQ=
X-Google-Smtp-Source: AGHT+IFz8fVx2QXPF9JLR2MQHyQv4ujenWmNTdz74B5huYIoCr4tN+fNvGrIEXzwiwLt7APKOgd2/g==
X-Received: by 2002:a05:6359:4593:b0:1bc:8d9c:e55a with SMTP id
 e5c5f4694b2df-1c39de9e57bmr546930955d.1.1729605706596; 
 Tue, 22 Oct 2024 07:01:46 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b1659c6566sm282375885a.11.2024.10.22.07.01.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 07:01:45 -0700 (PDT)
Date: Tue, 22 Oct 2024 08:01:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Andrew Davis <afd@ti.com>, u-boot@lists.denx.de,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Christopher Cordahi <christophercordahi@nanometrics.ca>
Subject: Re: [PATCH 2/6] memory: ti-aemif: Make AEMIF driver architecture
 agnostic
Message-ID: <20241022140142.GW4959@bill-the-cat>
References: <20241021151330.1860929-1-bastien.curutchet@bootlin.com>
 <20241021151330.1860929-3-bastien.curutchet@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ExSxpcXUM2oP3gCl"
Content-Disposition: inline
In-Reply-To: <20241021151330.1860929-3-bastien.curutchet@bootlin.com>
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


--ExSxpcXUM2oP3gCl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 05:13:26PM +0200, Bastien Curutchet wrote:

> AEMIF controller is present on other SoCs than the Keystone ones.
>=20
> Remove Keystone specificities from the driver to be able to use it from
> other architectures.
> Adapt the ks2_evm/board.c to fit the new driver.
>=20
> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--ExSxpcXUM2oP3gCl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcXsEYACgkQFHw5/5Y0
tyyemwv9ETu/aEm1UZcS97dbxKhGxukpsn5CctWEBpLKGkwK9gY5Wl+tdINynJ8g
/r0d4B2+NR05SIY2iGdVGCALGJ92dRt3l5NJbBr5CSV8nsQJjOnICo51KYUw+maN
6UI/bIk14X5S0mCHKlP2y+xJAlDKeSnMIbmRozNYdqOFa9BLkTppFyFJELzqyNw3
idubI5mXD3CjzWau+jGbAW0SRpw0ey9I7tmyOFlpoQbRRNqhuuRn9IHMHdsc0o42
/WClHHjBromKDXpaWNqfIXVlwUDdONlThD3fZ1IobCv9OdjprJxp0us2Sgoadl/q
K25cNBT0gsjBaS6CX029QVWIBc+1ZibpTUanKLeHupl8MGB48tJjmWnITbPN2OVt
91fFbfxg2hft7S9+QCNjnR5jGhestiyArki/iAni+A12vXYENedoFqIG9wmqbBaX
RHILTo5gq7t6ypTBiewqNr2PgQJlCVkroIwdnvCuoyqZpiiEc8HxCxHZFCxSlCEi
+UEiB5/w
=8vVL
-----END PGP SIGNATURE-----

--ExSxpcXUM2oP3gCl--
