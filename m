Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E41C5C48260
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 14:12:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1852187CEC;
	Tue, 13 Feb 2024 15:12:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rzsOu3Pr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C66B87D58; Tue, 13 Feb 2024 15:12:00 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3879587BBA
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 15:11:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-dc745927098so3660469276.3
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 06:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707833515; x=1708438315; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8KAfagK1cvI2kBv6fAWAD6SyQNmDs+uggsnhsoa2OkU=;
 b=rzsOu3PrV+lg2T3I7Pajo7Tw+DXHq3DwChrJJDIp0yIl42nmv6QUSuT2OAJC82lljb
 cxmkaSpX2ho15GjVxbDicgLuJ3yRrUkXFF7gKINqkQEQOzVEUGn2lMLOE4pSiVxAEPH6
 RPa6ml4J2uLJD1BfD6EkIG1bQTAzVv5SyuoAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707833515; x=1708438315;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8KAfagK1cvI2kBv6fAWAD6SyQNmDs+uggsnhsoa2OkU=;
 b=XQOs0WtMM/9D8sUc2/W3NR+Xmf/TD+F99K42eZQWqc0ifRnnOONsmDuFU8xqbV4Rwn
 u1mDbuCJZxDVkRKszLEusuP4OutORsuI4MvON3QHaeMSD504bh4h7ZG5Ftl6K/RJp93A
 oWoU8EnYiyRyTt9refXpxxg65IhedcFYN6LxT7IjQ7AIfjJA0O2PTKhxCJo/teCQUt6h
 WnGzmgyze1tkebbh1ZGQSuPh4oDmI40u4b1iQPNzEjXS1y+qMlIipMkY2m674E9JxZNK
 tRpnYnbmw/KxZiDVJ9ZCScfKU2zgCnK3m361P0ZJr/JbuVjcrNFNQ181nfzP+aYSesec
 9LtA==
X-Gm-Message-State: AOJu0YxjEIxozKfl+4ZFZD5iM5HqbJCDu0ugPUlTLuCYSN63alorGFPX
 HqJh66JyOrMd7uPcw1pe+oxiTz+zKFefjyFN/Npls/uxv2cIDhNfqzA2cJ5qVpg=
X-Google-Smtp-Source: AGHT+IH50sBB7DaoB0sJyDFsX2eSfvKTKSS7cMXE2QfyyYcZRJ7OMPPrfo1XcArEuTkrirv7U0LJUw==
X-Received: by 2002:a25:e809:0:b0:dc7:4960:b0a1 with SMTP id
 k9-20020a25e809000000b00dc74960b0a1mr8376865ybd.11.1707833514914; 
 Tue, 13 Feb 2024 06:11:54 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWlwPGrvEyb2TT8AuIF8Mh2RhS8kPSG7IrbXqwqBYWnYL7G29erk1APishqbqUTVwid8H3gCHyUOOpqTY4qwvNzOXGx3rTDREjADXT8V8Qbr8jZxjk=
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 j11-20020a25ec0b000000b00dcd3487c8f5sm62952ybh.12.2024.02.13.06.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 06:11:54 -0800 (PST)
Date: Tue, 13 Feb 2024 09:11:52 -0500
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH v2] test/py: saveenv: Add a test for saveenv command
Message-ID: <20240213141152.GQ3040305@bill-the-cat>
References: <9ad8684f92d8c1b5e821c6b755c73925eff36e19.1707818884.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5VxIjOq0ald8TF+3"
Content-Disposition: inline
In-Reply-To: <9ad8684f92d8c1b5e821c6b755c73925eff36e19.1707818884.git.love.kumar@amd.com>
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


--5VxIjOq0ald8TF+3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 06:26:44PM +0530, Love Kumar wrote:

> Add test case for saveenv command in non-JTAG bootmode which saves the
> u-boot environment variables in persistent storage.
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>
> ---
> Changes in v2:
>  - Set bootmode through boardenv if modeboot is not defined

Please fix:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D warnings summary =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
test/py/tests/test_saveenv.py:115
  /home/uboot/work/u-boot/u-boot/test/py/tests/test_saveenv.py:115: Depreca=
tionWarning: invalid escape sequence '\('
    sc =3D "!#%&\()*+,-./:;<=3D>?@[\\]^_`{|}~"

-- Docs: https://docs.pytest.org/en/stable/warnings.html

Thanks.
--=20
Tom

--5VxIjOq0ald8TF+3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXLeKUACgkQFHw5/5Y0
tyyFXQv/XRwpGi9j412RnL5ssq37oWKgaRp17iBwlfB58pPz5ZVaIwiNsJfB/9XR
bCyfKHY2lTF1Eg+LXstIdlk/ZKdWw2WnxVAsh+G3a3j66OEaZDfd/R7mju/NHl/z
sHbqzKFhWoPVf/S2DK5x4BoOsGknpHscVltXMrXIcXkfkcm/gIhnUEpEkcViseCj
k9OFlQr8h8zvRhLJGqEYZKoL418Wu0hWE3E3E3gqq4LEfZtoGk8PX3FcxandbAG3
rEqcWFGWMyumPtwxmbP2COtlLekZA6oaf6GnT1ZS1DHTlyFCrDBXv+uiFCALei73
N7PsKIHYDRve1zPQU5tAw+08diT14VVzwGhklYXOwMgHQg2ry/V0KIzprObt86Jn
QfHxus1Ky0HIE1arR44eTbE/mZw9q0HuIAp8fHWMArfMPDXX9uKfT/QrZfN9RXvA
pfifWmsyg6xcxCTwJLBgoPZJdnmfWcTU7jrbJLOmxC/4DSPRQMnjGOii+rPFiukJ
3vruvb6l
=fsxu
-----END PGP SIGNATURE-----

--5VxIjOq0ald8TF+3--
