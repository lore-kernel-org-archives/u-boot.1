Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46C0C4829A
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 14:08:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E467875A0;
	Tue,  6 Feb 2024 15:08:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HcBtld/2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4001387BAE; Tue,  6 Feb 2024 15:08:47 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFDFC8753C
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 15:08:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-42bf29aff0dso38843031cf.3
 for <u-boot@lists.denx.de>; Tue, 06 Feb 2024 06:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707228523; x=1707833323; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=r41P3OCTlV61DbaYWF621UIcAjjaJXTjgs5PUAidSjI=;
 b=HcBtld/2Fec+i0hLzjTICnVcNO8clQhzqQOzSKYGKAvNCliv3Rev5TzKeh+tZBkH/h
 xC35GEFx4yYUok+zeD7w4Ht1LlBQwRxHPqPMBt6WrHAy/e6xbNUKuyM7zzDTmz57rj57
 cAs8BeTA/sC0PaDsyHQr5NED1HMTClzExmZv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707228523; x=1707833323;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r41P3OCTlV61DbaYWF621UIcAjjaJXTjgs5PUAidSjI=;
 b=ZP6EK6OPdYsuiATc83rr36OKszhjdb9jvai7ao8h9FjT3cUlCiAIToGfTqWYdye+1Y
 DlKUjI3SxjwP2ddG/i08p/tlQNIe779C8hp1fhBrEsa28k/xumJkW/Z89+SL9IIN22ey
 ulOnBGFGxQJemRLvPGVEMq/wzyWUyXMJuaIv8udW4mwhlJhynK+DnDMe+Lm34GcexuH4
 RbM/oy/coW+OQNhJOfse64Am79VIxD+dh9V299ybVSrHt/Ytxb2141jYLsoi+OozFeJJ
 iVPkUK810hAvp/uzRybRW052+3zYIlV266VkY6lAdvJr/AgSG72C1gH+3cPobNcQP31U
 Glnw==
X-Gm-Message-State: AOJu0Yw5BtnJP4qQ0f4c4ldjruUeDW/heco8+soP3YUujLzkdgHtf0Dk
 p7XvXGHnZ9g7GQNb1mqzo5Ue58ytDTdEGAdlHPejJBLKEnCDWtPO9PKdUUUjkKXhGscuiGPBObR
 J
X-Google-Smtp-Source: AGHT+IETMP+sk8RS3TfZVuq120hm6jhOOnkzLBzPbgekWk1sWYIWqk7IJX2KRSaIi4la+XdnF2p3aA==
X-Received: by 2002:ac8:748b:0:b0:42b:e44e:7056 with SMTP id
 v11-20020ac8748b000000b0042be44e7056mr2891847qtq.36.1707228523506; 
 Tue, 06 Feb 2024 06:08:43 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUB7OANrXkVoWroVd5j/j+BhkrB8nTS+pDFu8757Z3cqiqrz41CzGGAVeAzsHDxU1nTNj8WWX7oSfw5cgVh9zN4lklFvw==
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 d16-20020a05622a05d000b004281ce041f6sm907588qtb.21.2024.02.06.06.08.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 06:08:43 -0800 (PST)
Date: Tue, 6 Feb 2024 09:08:41 -0500
From: Tom Rini <trini@konsulko.com>
To: jihongbin <jhb_ee@163.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] xyzModem: Correct xmodem blk verification conditions
Message-ID: <20240206140841.GR1152441@bill-the-cat>
References: <20240205065850.7556-1-jhb_ee@163.com>
 <bd80e95c-b2bb-4ff2-8943-7a185a310546@moroto.mountain>
 <5cd09ba8-49a1-4ed7-8610-c62097caa45e@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="x5LSorp3C4iIro3w"
Content-Disposition: inline
In-Reply-To: <5cd09ba8-49a1-4ed7-8610-c62097caa45e@163.com>
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


--x5LSorp3C4iIro3w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2024 at 09:05:33PM +0800, jihongbin wrote:

> It may be that there are relatively few people using this function, or the
> length of the transmitted data is less than 128byte * 255 byte, so the
> triggering conditions for the above problems are not encountered;
>=20
> I actually discovered this problem during testing. Continuous transmission
> always fails at block 255.
>=20
> The following is the protocol's definition of blk cblk, cblk =3D 255 - blk
> The original content of the agreement
> (https://www.menie.org/georges/embedded/xmodem_specification.html) is as
> follows:
> -------- 3. MESSAGE BLOCK LEVEL PROTOCOL
> Each block of the transfer looks like:
> <SOH><blk #><255-blk #><--128 data bytes--><cksum>
> in which:
> <SOH> =3D 01 hex
> <blk #> =3D binary number, starts at 01 increments by 1, and
> wraps 0FFH to 00H (not to 01)
> <255-blk #> =3D blk # after going thru 8080 "CMA" instr, i.e.
> each bit complemented in the 8-bit block number.
> Formally, this is the "ones complement".
>=20
> <cksum> =3D the sum of the data bytes only. Toss any carry.

Please repost the patch with these kind of details in the commit
message, thanks.

--=20
Tom

--x5LSorp3C4iIro3w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXCPWIACgkQFHw5/5Y0
tyy+8gv/Zc2ta2GdrhsD7Vb8sHIZLnTWp5DKKdepb5gBdBaW8zZYN39yZAOnrLXl
oOQJPacYAvK7kiWWczvaNu277OT57IcAbuhkDiZgwW0+N3G7UpLo0EqAcS6B04x6
JNNJRCtsKIdDkPSXw06HXLiLVCE3hNWZjwQkQizU2kWkCdqojbCOEfZ0vi9KPDXg
p7MF1YByp2cHDOhGGgZU9Lt2eBb8O9Au5knuqRgcyNfFuHdCwTsgTKlgcr7hFmto
5dTx3Edj70n1N0gt6GApJdxiXIrZIc684DKODZLQi+X1skDJzanjpzSzJX1np/+u
mYp5QdjhjLgT55RiocMHaVWNZbQy3ROvEo7nRplWyFlo7Xi9rruRjBYJ+ltNVbK3
5gygV03xa5bO/8agjZKmyv5jvNvMlO/Dclgyum7vWkDyqfJbW8moYgn5Zj7kRlfZ
Q1bygPi/6qp+naVwp1ZABk5hj0UKo3fctLL4Amv9Fc9BrXKtKDVMcDUMOI97BbtF
HEckpoBk
=7SnF
-----END PGP SIGNATURE-----

--x5LSorp3C4iIro3w--
