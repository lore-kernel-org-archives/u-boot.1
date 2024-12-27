Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418CAE7718B
	for <u-boot@archiver.kernel.org>; Fri, 27 Dec 2024 21:53:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7732C8036E;
	Fri, 27 Dec 2024 22:53:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="szW5dxSH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1197180422; Fri, 27 Dec 2024 22:53:35 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1A7A8036D
 for <u-boot@lists.denx.de>; Fri, 27 Dec 2024 22:53:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6dd420f82e2so12465666d6.1
 for <u-boot@lists.denx.de>; Fri, 27 Dec 2024 13:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735336411; x=1735941211; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3HQa0zjEubYugnMcRxV/RqVhMIVFvdTirvvduL7hsaE=;
 b=szW5dxSHTTec+j4MY0sO9s98wsdo61jRWHGoN/ofb1JPziiyRFHv9VKjWDqQVpiT9q
 wP8qRWKxhKm/ek+Zqk70gk736gsgiwAMgo9O44gywBxSNNqIo77uuJIFyb5E6lonN56Q
 C0yGfrIF3wx7XM0cNcJyOD3to0jUtdo5lkrYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735336411; x=1735941211;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3HQa0zjEubYugnMcRxV/RqVhMIVFvdTirvvduL7hsaE=;
 b=IZEYayTTKjpgBGpNvQZIpVWtuZ8YxbPXH5jsYUDIi1jiQdaF0LXOlbAk4vh/85QcJS
 239q5R7+pkPOgp9nJpdh8ieW/KFsEvPxkTyYSwZeo97NfBQHvd1tKg4PJnpPdV8TTd5Q
 lnEdI/ZHi6M9FdsM1l2UfiOtn0/Jbl2/3vd5INcIWNlIaLsiVxlKK7SqDJMNEU+qxMab
 d1Q5GMOsGs1R+10eg4WNaqDWmn+y38yYsqvm7fNmbkj3ZRaw2cSo1I+WlvfLds66MxX/
 8tZgPEPVsEOMab8mAxqPnyGCW4Mu2/jyELYx/bN07HV5IdLqMQxa98wVXSSk274Q0G9H
 jpGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvHVPPZcn2LpY+OkQUP4LwIDIExhRepAWS97ITMmkUb3DxtK3vVo2Y66DiPqbc5bipNifu9r4=@lists.denx.de
X-Gm-Message-State: AOJu0Yw55L6dB0oAOgg+02Ik+n70j8zNjpKVqAaBXvVGWffEpYZtB/KG
 MDBvCLLD34VTNo2j59SZJ3gFirjE0ZU2Nj/QtpzSUeh6oWWmppTzWvPI/Br6Sg4NOvPDeEEvz8K
 xuuY=
X-Gm-Gg: ASbGncvJBAUG/H8QtbBeyFnqxWMtcwSmGyCihAsja1UtJqiscn1SzcBKg1KHfdfBI+a
 x1hotOV3s5nMwwZ7W2aFNHPKRw5VKhyjSatCtg31iqzAoGeKkcTy7IeIbUwGE7mowlqzCNaBTI8
 +dKy7XtddlYb8R5OQNU/6rlXOgKClCJuqNhYT90oBaLCilbaPHHIXmf2qSVbgKOft6TofQpxWeQ
 14t11K9Tsdu0Hv34sjW2seaxqST+efDd5mQhKI6IUMmwOeZiqKeavkNrg==
X-Google-Smtp-Source: AGHT+IGecHXk9DJIkyTnMRIBkJnA+qCKJ5gg1IFSDtMbl5FUXNgXK5REvnJa7UdBeTmmMbAJx75Spw==
X-Received: by 2002:ad4:5fcb:0:b0:6dd:13b0:1008 with SMTP id
 6a1803df08f44-6dd2338c7d9mr391757576d6.30.1735336411678; 
 Fri, 27 Dec 2024 13:53:31 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd180ea955sm82016856d6.21.2024.12.27.13.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Dec 2024 13:53:30 -0800 (PST)
Date: Fri, 27 Dec 2024 15:53:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Karel Balej <balejk@matfyz.cz>, ~postmarketos/upstreaming@lists.sr.ht,
 u-boot@lists.denx.de
Subject: Re: [PATCH 0/2] Initial support for PXA1908 and samsung-coreprimevelte
Message-ID: <20241227215327.GH1505244@bill-the-cat>
References: <20241227-coreprimevelte-v1-0-ac8243eee4e6@skole.hr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="i7tqIE42rDzzhtJD"
Content-Disposition: inline
In-Reply-To: <20241227-coreprimevelte-v1-0-ac8243eee4e6@skole.hr>
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


--i7tqIE42rDzzhtJD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 27, 2024 at 10:22:14PM +0100, Duje Mihanovi=C4=87 wrote:
> Hello,
>=20
> This series adds initial support for Marvell's PXA1908 ARM64 SoC and
> Samsung's Galaxy Core Prime VE LTE, a smartphone based on said SoC.
>=20
> On this board, U-Boot is used as a secondary bootloader to work around
> certain quirks of the factory S-Boot.
>=20
> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>

What is the status of getting these dtsi files upstream? Thanks.

--=20
Tom

--i7tqIE42rDzzhtJD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdvIdAACgkQFHw5/5Y0
tyzROQv/Qy8NsjjOZdF8hF5J+LjRxCvmskN7b4+BLJU8gd+l2kn74vzTxOaTtJue
KX1/WxU+WcOjW5Kj6ZWZcQ8bSWqbDYQbJ2tgvx/mrB6fTnz5/nSjXLwB/B5kYkoA
deWFwl2WSbTcMoZoOoMjF3cQl50mpN10kwQqOL+WJcK7q23QctW8vkZSGFzqAbiY
VYxX8ihouxaBn9M9/CDm8FcUuj4nzCoq2Fll5UKTk0TolMD02hXV9da91gLkQkLU
2J3u1NWBX97v1L+5ydk5c4F8BTQv7qO8AFdRGxYoIcQJPGMekST0SQsgMP4zLprY
bVkhVHXnveOJYBVyxwc00AZrlf0+EiWh2/7UrkDDBub8y0m21lO9JpsQupdGAAAi
++7pE3J5+8kRpx7js9CiXISl511y0cz8JnthADVbjs1qhn/akYAF1+p5EMgQNRFi
c6yImDOMF3opT71dCdsnD//+d5lN8LJEHo7bEPmMc0DQzER2cbQIVJ2exPU4dbTb
qjnzXJtN
=FXi3
-----END PGP SIGNATURE-----

--i7tqIE42rDzzhtJD--
