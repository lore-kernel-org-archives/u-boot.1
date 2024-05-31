Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D62C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 17:56:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FB8F882CD;
	Fri, 31 May 2024 19:56:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RcatYmIe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D76987CFE; Fri, 31 May 2024 19:56:19 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BF7A882CD
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 19:56:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-794ab1bafedso147115685a.3
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 10:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717178176; x=1717782976; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PEL5N3weE+B14R9wa6TGM/Fb9WRaXtFuF1URjbOHGC0=;
 b=RcatYmIeDKywmSPQI0+HGxFJwug53V4Ew4wPvh0X+Wb22punrM84bm6lAEXPMtJgqy
 SZydF0XoSzMWhse+vlUL24FplgnLfv1GsSKo8fXbq2Sz9f8hxU00BOP+h/ilUllyr0SR
 NsfvX5dCIomBRswBNVPQuiBxoJnSefdenMnmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717178176; x=1717782976;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PEL5N3weE+B14R9wa6TGM/Fb9WRaXtFuF1URjbOHGC0=;
 b=qqotWswIZ77vSpg8rzNobCwRDamCgyAxGunwxAqJhGeLRVUOjwE+QxlFXrlE9hRbn2
 n7D4nIVzd+n1zcpxR7Jzok7TK21OIDMkK5qlznDrjTObMKmezwQz1/5JTTI2DatNd1eR
 HjHltfukMS8zoSel6nfRJbvAhsIYzwp1zx4L2h2SXZE/4DYoW3r+JrdAn9Jmi6ZEV1Cl
 wE6H4+KN8estTLgExiwJ1iNC8HSdP6WElzF47TG2BF4z07OzQzN+jNBoLzRQ/BQHKL+z
 PtKQ/ckwo2IhbS+zixkiije9N/Hhxy3IV8u38C4+gD+8ucFcYGk2pHA+c7ExUogvbn2w
 VBfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4v3R1Ypu7RFPyvjIPCXTeE5nUCJrbqXa7c7O3JY5JKEgnBv4GtdxgSW79d9bKY6Fp+H4xD7GhW+HTR+ZUuHVMLEyctQ==
X-Gm-Message-State: AOJu0YxDrFM6IhA8lYizWLYFTRIH2dxpxkBsCAxnANb8c2FOPeGS9RY1
 kNTX2MgWHd3gsU26v0V1MssSUoQGq/rj9KZZp38KVvNZkMvJYyjuD7P0Y5tUeOI2NTNPP8EgREf
 Li04=
X-Google-Smtp-Source: AGHT+IHTrLTEPXYATaczaAdFlWs/mYAZyvymJvBYIv2aGagZdcEC6WoIAid9F4MggWLNMX7KiQTADA==
X-Received: by 2002:a05:620a:372a:b0:794:bb6b:25d8 with SMTP id
 af79cd13be357-794f5cc6513mr328950085a.55.1717178175692; 
 Fri, 31 May 2024 10:56:15 -0700 (PDT)
Received: from bill-the-cat ([189.177.150.58])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794f3172a88sm74975285a.120.2024.05.31.10.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 10:56:14 -0700 (PDT)
Date: Fri, 31 May 2024 11:56:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: adding file to gitlab CI build directory?
Message-ID: <20240531175612.GP3714513@bill-the-cat>
References: <20240531183538.4999839f@donnerap.manchester.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Apuq5PZfbOCcOOma"
Content-Disposition: inline
In-Reply-To: <20240531183538.4999839f@donnerap.manchester.arm.com>
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


--Apuq5PZfbOCcOOma
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 06:35:38PM +0100, Andre Przywara wrote:

> Hi,
>=20
> some Allwinner devices use some kind of "secure boot", which requires the
> SPL image to be build wrapped in a TOC0 format instead of the normal EGON
> format. mkimage supports that for a while, but for that to work it
> requires some private key in the current directory. This key is easily
> generated with "openssl genrsa -out root_key.pem", and mkimage prints that
> command when no file is found, so it's easy for users to comply.
>=20
> However this understandably upsets the gitlab CI, and breaks the build:
> https://source.denx.de/u-boot/custodians/u-boot-sunxi/-/jobs/835423
> +mkimage (TOC0): error: Failed to read private key from 'root_key.pem'
> +mkimage (TOC0): info: Try 'openssl genrsa -out root_key.pem'
> +make[2]: *** [scripts/Makefile.spl:446: spl/sunxi-spl.bin] Error 1
> +make[2]: *** Deleting file 'spl/sunxi-spl.bin'
> +make[1]: *** [Makefile:2089: spl/u-boot-spl] Error 2
> +make[1]: *** Deleting file 'spl/u-boot-spl'
> +make: *** [Makefile:177: sub-make] Error 2
>=20
> This prevents me from merging the defconfig for a device requiring secure
> boot, so I was wondering what the solution would be?
> The actual key is irrelevant for the build, so we could either insert
> *some* root_key.pem into the CI build directory, or generate this key on
> the fly, using openssl.
>=20
> I have no clue what would be best or easiest here, or how to pull this
> off, so any suggestions are welcome.

The short answer would be that we should be using the same facility in
binman to allow _this_ binary to be faked that we do for others? And the
slightly longer answer is that if it must be in the source, not the
object direcctory, then you're going to break Azure CI as the source
directory is read only there.

--=20
Tom

--Apuq5PZfbOCcOOma
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZaDzUACgkQFHw5/5Y0
tyx2Pgv/YkLhIZ53MB1OlxsS0l8k3MKAuqAnRyiLhNgHgAG5M26VpeN4HYwRnpHX
/Acb8BiHCKrU7OUqDRoJJtFF5TZ8l11uKpv+fQeb/OMzswFMYtlu5vZqW3ySgOwG
MIW5+1am32cOMzR66usdMpvUCs222NDoQ6dOOuz0dA0jqinf5iY9O9JMTMEV9jUl
hUJM0ax48l9FJVK6BNKsld9g3Oq/uLSbp1RR4YY9Q8V5eYW4s7r5tT9tZIFBeLgn
kGnZ4xIH0wKMsm9XF9D9cyZS7B18Pm98HnPG0KWj8P1L+iLLDuoj3sxkQjunZyEa
iZCOkZ+T/IIGcTAOpkcIYsp2uoFcoDoysmMaoUhsb4MSISB+gBAp91ePsn0r++/S
d0Oa+auN48uSchkBODfBo/baKq1v5ZhZ67Hy4HwAjs4gqyCfDDVS2mHKwS45Q6wE
J1YoZnNwH3xRcAE/dBB06mRge+q9FIQtL/RlKRoDDxr+xrMMrBAqn5xQbYMzHWCF
c1ALRZg1
=jSSK
-----END PGP SIGNATURE-----

--Apuq5PZfbOCcOOma--
