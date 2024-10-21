Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F117D15DBB
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 16:39:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECF5D88E8A;
	Mon, 21 Oct 2024 18:39:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nBd8Cyhg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEFDF88F01; Mon, 21 Oct 2024 18:39:35 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15CA688E8A
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 18:39:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7183a3f3beaso416996a34.1
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 09:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729528772; x=1730133572; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZaRwcL3QF/n9lw62CZk7kfE+APRDYnQcnjv0bFO6Bxo=;
 b=nBd8Cyhguchiwk5wJ34diD+g006zWqkkioo9gOWkGKrlqc2BVC6QDtYMSl0QRNPJl9
 2Fcz0PdBp3UrB2eFSO9sbwcRRmPPK81ommJeO4ajxgY/dWYslgsDxhpuIl/7gjNeAoYD
 S8RfA8TbDBBBGM+Aq3Qnifl3Jb+Dl78VpikjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729528772; x=1730133572;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZaRwcL3QF/n9lw62CZk7kfE+APRDYnQcnjv0bFO6Bxo=;
 b=XEN8vd4fWLMLGYaOA50b6jUUFa4UryduPX406FtAgaXFNRDtbJLZkfK36etj2zAeVl
 z1bICTcpRAXd1W5/qaLUhncs+NciEEtVq1vEHK4juLRy03oWHwVfBJu9xielUo5pT2uN
 ahbgG8QYuUuiElCGZ9QgxqNP9ylwmPWPN2lJy6w43V2GdYnS2qFGQpQiMDUCq5E6BAEF
 jHuC1FZdKqjmacmsiYAHQBBCh48oIWxEUtqYqqCIDFVb/7h2MZSHN57lQmTBUnErSxDj
 iOuoCOU5BG3ESOgSNb6JZ4GQ6LDjlNg9Mg3PsswUoycKkxTQaFYCtAUtEWgp7VhOZGoT
 xJZQ==
X-Gm-Message-State: AOJu0YxaXb+9sLO6X7qWL5rvHFuZoaMUul2vZzHahTsuERE4PhfyBkDI
 02D9iTDH0gQ/oxSwTBkUdeQxcw31yIh3rfpuMfoNjXcyl3coRZVq+wHp3rkJwcQ=
X-Google-Smtp-Source: AGHT+IFSdIpcilmYl6eOD+bYjBkegqce4j0QnfoGB+XQCvBtEwsKYLnEfFsZlO2keqTOloqp3QTBeQ==
X-Received: by 2002:a05:6830:91c:b0:710:fd8e:1727 with SMTP id
 46e09a7af769-7181a89dec5mr8361386a34.18.1729528771791; 
 Mon, 21 Oct 2024 09:39:31 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce008fbbd0sm19221336d6.39.2024.10.21.09.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 09:39:31 -0700 (PDT)
Date: Mon, 21 Oct 2024 10:39:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@denx.de>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, bigunclemax@gmail.com,
 Alex Shumsky <alexthreed@gmail.com>
Subject: Re: Please pull u-boot-i2c
Message-ID: <20241021163928.GH4959@bill-the-cat>
References: <7082f093-4e4c-7329-d10a-761753c8e16e@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="c7qsLVobyG6pCrgC"
Content-Disposition: inline
In-Reply-To: <7082f093-4e4c-7329-d10a-761753c8e16e@denx.de>
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


--c7qsLVobyG6pCrgC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 10:27:06AM +0200, Heiko Schocher wrote:

> Hello Tom,
>=20
> please pull:
>=20
> The following changes since commit fa0ed06a749c8e3c65d8b12a7d2d33a055a08a=
ad:
>=20
>   Merge tag 'efi-2025-01-rc1-2' of
> https://source.denx.de/u-boot/custodians/u-boot-efi (2024-10-20 08:27:15
> -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-i2c.git i2c-tag-v2025.0=
1-rc1
>=20
> for you to fetch changes up to f315a4813186ca098a6c698754a06b8297d400f6:
>=20
>   i2c: i2c-gpio: add support for i2c-gpio,sda-output-only (2024-10-21 06:=
32:40 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--c7qsLVobyG6pCrgC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcWg7wACgkQFHw5/5Y0
tyyMSAwAqRc0gO/1+mgrCUDzZFI2NAQx3ul461j2xVGf+bBFNyLHa8qSARDvd6wi
NVVWCIl4BNdJw6UphSudUcEZ0TVNNzp3zMKYwHngCFrecuP887vsjBTqsnd1E+5l
pqhRV9JEHwVOLIIfzXvAJ3vS91Ky++WlG2rV+mg2ixI26cXF6nYs4vHQoxssTKfb
37mpJVttsHNerfyxQVqzLmGUnBN3XyXNC87ZNIJa8HKWELdiykhqQzl6qXsvynFA
UJZvh/lmhAC85ZCugnl8yX55M3J5A/t9/kj9qo3cKzNIZHFkB+OARIZXQumwjA9f
1BOntmIdxQyALx68oMAKZ8ChwjVbQWzb7d9NTW0Rj2+ocP+MBXIp8+4WNyFHOu0d
vOx4gQNQBhs4Z7KXkEI/1XEuWGDeavWiETMGx7Lh/uvvyYjbnOagkO/2VTRmurb9
YOtAFQphWeAeXdllmOXP+KbRbC9HIY/TPhIS8r6QSKJnS6g8QMxmGrE9sDXgnZle
IuU5zLBn
=0Ldo
-----END PGP SIGNATURE-----

--c7qsLVobyG6pCrgC--
