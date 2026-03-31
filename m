Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED0D1109B47A
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 14:38:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3561983DA6;
	Tue, 31 Mar 2026 16:38:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Seq09G7L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7970983E7A; Tue, 31 Mar 2026 16:38:17 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FB0A83A41
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 16:38:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-467e8aaa865so2958656b6e.2
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 07:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774967893; x=1775572693; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=usP+cw7PZvytAyIqcowDxe2yiw537Xjen1bNuRPi1PY=;
 b=Seq09G7LycHdQxofW4V3EmKvMGvkGzNMTsHLvgWTkxpDS87n2Z7NOFMkcC2osm0TLr
 P7ZSLUJn2b0nqeCpPwBY4/24RpyYqCVTh2Qc8qRiZbpmYwhfhGbgkIXeqTmSwMrd91HE
 gnFfKdHFD1T/5n51iKgIxvLCeOF7pnTgmHNoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774967893; x=1775572693;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=usP+cw7PZvytAyIqcowDxe2yiw537Xjen1bNuRPi1PY=;
 b=T669KuTRdnvrImReiJxL9uYIJH+k2d17FOS09F65i2lI8vecKkyAj9Rn5eB5hg8Y64
 ATzcKUsRdlJ0U6lhX/INV9d4ixXLCbGI/28PdZNOLYRN8Cr3gxzhdhuZbPnI250Vn5j2
 ONn1LKDNW/UGe5uY2GtCwxirCCDf+ZZCQ/+9tZ74kZQlSbiVOWi4shr+u0DQO2+Pdxgx
 6mr1+LLjvUfV8KinVPOFtQ4YLDff+CcGHCxUOxIfzFSMQHw49Iyy4QFcM105l6N9bl1t
 vqZsFmvetTE7f9uw5flI4ze0JrYGNMEq5jbj1tECSd3AxBskEVdbayGjTu0FW1LqVugs
 rFQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUR15SM+H9WY35d9lRLs/u6cFp+hmE5MFqoLJUU/dC1XFNbt/4ZLowAqi75s0DSJNS9Yu/9a/4=@lists.denx.de
X-Gm-Message-State: AOJu0YwDuxLRwRpLPVFnTL9sKJHeUbyOSBhyPZhH4CZf+wGPbtzpRm8D
 6++Pet9936P4e8kGsg6VOZJ6l6LQFboODTVQ2dNpUtk6LyuDyUbUmctJ/f0p9PWzkRI=
X-Gm-Gg: ATEYQzz1xKjS+4Tuw+CfRNOEKCiWgzN66BCgMGDmrSVOroi0L6tc9LpGk8iZbkKa8Em
 bj1/GZuIqNCi9CZwX1zH7lGZmFCK2NwOS6U5YaiPldF6ipBrk1hP16EhHjq4VnmUF2QzIVZv8wp
 KTbKaNUMLz8jmmgS2tKtJ8p9POUBNJGCYFc25cWoHAO7uiGN/XDtgq9jm0ynNbJu3hEOqhlh9m9
 EXU7e3wGHaxi48hbmh8LrQgjHvYDUhjko0R28tvMNKPQhKBS2Wm2HMG05OBhTJ3eKtZ9wn6GtR4
 oCVMrdViL+kPT+6/4BhPoFcspCavUJLrk3IxGe+nCSIVue9eaYOKlAraRR7I/QYY8+0xVgqW3CZ
 KT5KHiI1s83mpugzwDLKCOnA93VLOZtGVhd8qJ+CXFTQKtHWMBRFXKltYQm0J7/Jmqp8NqU0ak0
 VB8ViKDqoOHyO1IQJBeMVxdYuH8tv3XS5lw+SBX9Dc3IEkQhzBZP6cAZZE4mUTyoOHyaqqIAZ3B
 Kk6O0JsBhiHIVUzZmJxTwRhLrNXKfQg6SIU/7nH5CgY/jYs
X-Received: by 2002:a05:6808:171c:b0:467:5573:3d3b with SMTP id
 5614622812f47-46a8a641cbfmr8137538b6e.44.1774967893153; 
 Tue, 31 Mar 2026 07:38:13 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41d0e47178bsm7245609fac.11.2026.03.31.07.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 07:38:12 -0700 (PDT)
Date: Tue, 31 Mar 2026 08:38:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 simon.glass@canonical.com, u-boot@lists.denx.de
Subject: Re: [PATCH v3 00/15] add software ecdsa support
Message-ID: <20260331143810.GC41863@bill-the-cat>
References: <20260331100047.34618-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CaHyDO3GsGzFzR0S"
Content-Disposition: inline
In-Reply-To: <20260331100047.34618-1-philippe.reynes@softathome.com>
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


--CaHyDO3GsGzFzR0S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 12:00:32PM +0200, Philippe Reynes wrote:
> This serie adds the support of ecdsa with software
> using mbedtls. So boards without ecdsa hardware may
> also use signature with ecdsa.
>=20
> To add the support of ecdsa with mbedtls, I have:
> - enabled ecdsa in mbedtls
> - add a function sw_ecdsa_verify that uses mbedtls
> - add a driver sw_ecdsa that call sw_ecdsa_verify
>=20
> I have tested this code with sandbox, and I have
> followed those steps:
>=20
> 0) build u-boot using sandbox_defconfig and adding those options:
> CONFIG_ECDSA_SW=3Dy
> CONFIG_ECDSA_MBEDTLS=3Dy
> CONFIG_ECDSA=3Dy
> CONFIG_ECDSA_VERIFY=3Dy
>=20
> 1) add a signature node to an its file
> 	signature-256 {
> 		algo =3D "sha256,ecdsa256";
> 		key-name-hint =3D "private-key-256";
> 	};
>=20
> 2) generate an ecdsa key
> openssl ecparam -name prime256v1 -genkey -noout -out private-key-256.pem
>=20
> 3) create the itb file
> ./tools/mkimage -f <file.its> -k . -K arch/sandbox/dts/test.dtb <file.itb>
>=20
> 4) launch sandbox u-boot
>=20
> ./u-boot -d arch/sandbox/dts/test.dtb
>=20
> 5) on sandbox u-boot prompt, load the itb and launch bootm on it
>=20
> =3D> host load hostfs - 1000000 uboot-ecdsa.itb
> 4628674 bytes read in 1 ms (4.3 GiB/s)
> =3D> bootm 1000000
> ...
> ...
>    Verifying Hash Integrity ... sha256,ecdsa256:private-key-256+ OK

For the next iteration can you please add this as part of the series, so
CI tests it? And also put it through Azure at least to make sure there's
no other testing surprises that come out. Thanks!

--=20
Tom

--CaHyDO3GsGzFzR0S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCacvcTgAKCRAr4qD1Cr/k
ChQ2AQDXgRJs91CFVmaldu5hgUFiPVg+srgZAjUQWr/7seTyZwD7B29PIGcQrOZe
GzLzN9kfdrfoci46bcosUh6b0f3w7gE=
=l1BL
-----END PGP SIGNATURE-----

--CaHyDO3GsGzFzR0S--
