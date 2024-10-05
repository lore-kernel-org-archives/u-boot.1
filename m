Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BDECFB42B
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 19:35:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC1B9889DA;
	Sat,  5 Oct 2024 21:35:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b9tUFHAH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD66488970; Sat,  5 Oct 2024 21:35:01 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F77888A24
 for <u-boot@lists.denx.de>; Sat,  5 Oct 2024 21:34:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7a99fdf2e1aso439351185a.2
 for <u-boot@lists.denx.de>; Sat, 05 Oct 2024 12:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728156898; x=1728761698; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lHQbT6ck1sn94yu7d7UV6+SGacFpRwGcM4dzh/9sWAY=;
 b=b9tUFHAH8iVispHkyQTgZjoSnOeb3FuaFyH7i8typzAllfkxs0b/KoUQ0pfRNgcqAz
 BIlDB1BdcLevgtQY5p98VHidOAkRSNnKvFzvTY2ibm3JYPqcA6tNijTKpldUpqaaXnQm
 7fNac2AcoiY21lnspfGAUdKX0IaNf7OyZIbuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728156898; x=1728761698;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lHQbT6ck1sn94yu7d7UV6+SGacFpRwGcM4dzh/9sWAY=;
 b=qocPQN2nXnhvFgn1IvFYRY7269wurC582+9n3qsQUxCMipCqaxOvuVTbyXbU+5HVVd
 X3YFaDeFjnBEv8Vmuveo7MxyuM78mQLCFp1zQ2bGk5cU//BQNdPMpFMvex0JINzCY4nY
 +SZ6bcemvX1HK6iuWp9uf4yb4YP7cJNW27A47DMGwfagZcVjanB4Dls8GlKD+uxUI777
 R+jRySJuWiUFSIl7izmkJ7qMgsJLpZzyn9KvSzjqj4Z2SbgJcPhzchHf3f+8mc7xKs9L
 I0s1QooCLvin/UIalmA3QhfOs2K0AyLSN3OHgA1ZKOBWRSIfduZhKQBQY6Yiag5x7zl2
 5PzQ==
X-Gm-Message-State: AOJu0Yy4yKujFsjY+aFRc1HKz3pOv9haCD1MHdC9n+KlyaGMnr3ivPt9
 A89XS9y12aRiOoNBj1g4I2oy09bQ8Sd9ZE0FzW0/yk097ptROZGVM5XBwDmMS+k=
X-Google-Smtp-Source: AGHT+IHimStiUVLMLKRG+t8UqJczTJ7aN0r3OZsBw3xp6w4Vp9yJ7YStHukwNeI9i6jXNze1CY5EAw==
X-Received: by 2002:a05:620a:4307:b0:7a9:c8f3:999c with SMTP id
 af79cd13be357-7ae6f42ce18mr938564485a.5.1728156898298; 
 Sat, 05 Oct 2024 12:34:58 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae7562c8f3sm103754085a.37.2024.10.05.12.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 12:34:57 -0700 (PDT)
Date: Sat, 5 Oct 2024 13:34:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: U-Boot-Denx <u-boot@lists.denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
Subject: Re: [PULL] Pull request for u-boot-nand-20241005
Message-ID: <20241005193454.GO4737@bill-the-cat>
References: <CAOf5uwkVkZAz9d1oxW1EL+qYjWjm4mzfwxhLQ6nYhxQ2Yd4uCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="w+7FU82kUDW4DWS8"
Content-Disposition: inline
In-Reply-To: <CAOf5uwkVkZAz9d1oxW1EL+qYjWjm4mzfwxhLQ6nYhxQ2Yd4uCw@mail.gmail.com>
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


--w+7FU82kUDW4DWS8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 05, 2024 at 07:02:51PM +0200, Michael Nazzareno Trimarchi wrote:

> Hi Tom
>=20
> The following changes since commit af69289d61876d8e62449ee2da2dc6683bcb81=
98:
>=20
>   Update directories for new name of TF-A directories (2024-10-04
> 09:00:47 -0600)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-nand-flash.git
> u-boot-nand-20241005
>=20
> for you to fetch changes up to abd7258222188be745b6f3f698dd983d6ffc5755:
>=20
> These are a number of assorted upstream Linux fixes to the
> BRCMNAND driver.
>=20
> This patch set lowers the hamming distance between the Linux
> and U-Boot drivers a bit as well, while we deviate quite
> a bit it is still possible to bring fixes over thanks to
> exercises like this.
>=20
> The patches pass the pipeline CI:
> https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/pipelines/22=
535
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--w+7FU82kUDW4DWS8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcBlN4ACgkQFHw5/5Y0
tyzQigv8CJjoXve7YB6CvjxVvn3dUoD+YSg7CYjnlSYaneNYO85XDeitlhozsMqa
MLypNEbxB09H/SvRvUdbr4Nn1MdSTq/UjJE2t5oeBmM0Fvz2gmLVC5z57fHpb9MB
PZlAXR1+8UsOFKPuDLzzb5bAZdyVW4Bgqq2sR62h3+8a1cFboERXrD/Qj5jCMOdq
SJzoRnlUTZOtb10Mx8aaWSSCWvgl8mpFIZMiPGC1AFoU5BtzUK/E0zZgdf6+8Vt5
e6wgRr8QJyf/mJsRlppVKxF6N1F5/7HtCxC+zDr4zMgyFY1f5XM6K1/q/6bZzihh
9z+/r7GmX9hKwWTfTRjaw2zuif1aeLMsI+8xtI2sfYtR0tQ9EXBJmV7pw/JjMkVS
Mf8r48TZghUf5/Gh5IgZ2glNADG4F1mKf9vBLKMYqcYNatsbaDaa0EUW0KL0C/rt
Y+2kvV1ojubI+8qp7lENJnLFmrHCoQNDy6F5OT4b58x+hNYhD8D+6RRw75SqdaEd
kXQmMmd1
=P/EB
-----END PGP SIGNATURE-----

--w+7FU82kUDW4DWS8--
