Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4531C47077
	for <u-boot@archiver.kernel.org>; Sun, 14 Jan 2024 14:39:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA5F287707;
	Sun, 14 Jan 2024 15:39:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lAerDBSe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 767E487849; Sun, 14 Jan 2024 15:39:57 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52F1586E05
 for <u-boot@lists.denx.de>; Sun, 14 Jan 2024 15:39:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-67f9f6ca479so53833176d6.3
 for <u-boot@lists.denx.de>; Sun, 14 Jan 2024 06:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705243194; x=1705847994; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+XUY5PReW55vWuR2br3C6EmM38qZtDJbrHxCfXeIgsg=;
 b=lAerDBSehSf3OV1/sUYA1EeUeeKg5yPech0tAqJDaXlY8MOsfzoVjUelfPS22jeRXH
 EGtYA3ezsJDDo/S3ADbljbl0yGFGnjtfxxh5zk+dnPT1hJ/NZLu/LvLHBtPIRViOu7Yn
 zco4sCg10GlyJ7rlNo+5ZleZQt4s+f3ve7T0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705243194; x=1705847994;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+XUY5PReW55vWuR2br3C6EmM38qZtDJbrHxCfXeIgsg=;
 b=DrZcOyH7Yh1PkRLVzwBYvaUiPKPyrwbT4VrW+QbwNFs9dRxKxVo5aUlp2uNjMfgNLb
 BJSlP2KZTmhjsQ23Tb6Bmx0ePypCH16wT5csb/qptrEA3A+Tt0TRZLFMwXH539q26nFW
 n/exodvYkhblcyJ03+n9TONLW0DhVdsKr7/xnhra2isEbPLmSTCgx/lKeRETIpQSht6B
 2s1McFI8AJ6dNI17c9NcSXNOIfBw4TueKf3fNW+mgutuN0/KbxC3YO6yyNmzayT9U0Sc
 8391ZeO01DuHG0j49x7NIseM2k7Ewj+i9HMt7wYd44qJ1GCxLku7jUpRUG//fFfDOttX
 woiA==
X-Gm-Message-State: AOJu0YzMp255zjKdE3szI/REWaY93VA4XGTOoOacIV4M49ei8vSpxjdF
 A21wj1CfgTt6I69MsLV56ZnyovG4QP3+pw==
X-Google-Smtp-Source: AGHT+IH6NQto8HLDvVQHx96UUtgTqd0gzVBJpYoxo/1t8kU9KkNaLKzJ/BBCKHRSe+noShONDrmiPw==
X-Received: by 2002:a0c:aa9d:0:b0:680:fec5:874a with SMTP id
 f29-20020a0caa9d000000b00680fec5874amr4279862qvb.76.1705243194103; 
 Sun, 14 Jan 2024 06:39:54 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 z7-20020a0cfec7000000b006815748969esm684837qvs.13.2024.01.14.06.39.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jan 2024 06:39:53 -0800 (PST)
Date: Sun, 14 Jan 2024 09:39:51 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Nishanth Menon <nm@ti.com>, Jonathan Corbet <corbet@lwn.net>,
 Oliver Faso <erer1243@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 5/5] doc: update requirements.txt
Message-ID: <20240114143951.GK1610741@bill-the-cat>
References: <20240114131824.68298-1-heinrich.schuchardt@canonical.com>
 <20240114131824.68298-6-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EvwkBhTPlFbBMdxj"
Content-Disposition: inline
In-Reply-To: <20240114131824.68298-6-heinrich.schuchardt@canonical.com>
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


--EvwkBhTPlFbBMdxj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 14, 2024 at 02:18:23PM +0100, Heinrich Schuchardt wrote:

> Update requirements.txt to most current packages as produced by
>=20
>    python3 -m pip install six sphinx-rtd-theme sphinx-prompt
>    python3 -m pip freeze
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Note that this will also fix CVE-2024-22195 (Jinja before 3.1.3 has an
issue that's unlikely to be a problem for us), but I don't think we need
to spell that out in the commit message, I'm just noting for the record
here.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--EvwkBhTPlFbBMdxj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWj8jcACgkQFHw5/5Y0
tyzmuAwAladbGCmwgfp+BlHFo7aimnuYSyNJ/qPXCec+dH7y+XGDMxaKJxG7e4Ji
kVGCV6DZfTWTfRKjHZxXw9PQgh+VUcir9tRrg2Nlhk3oas+dgDfBVpuIpZFwNk6a
1xWRob6TE08BD3FDo2vGYKOVWM9PyhBTaAEqv1tTrSw3aZ3eG7MgRLZ1w/mLS6vq
cMgTwzy871kGZ6SP/geU4n6I11tjLslBcjXjVHMOLTQVdfVV+xl5awzIh1VS9XZG
ILbmS2fH7EHyP8+ZM0V0Wewakx7sDPWU9hbeHAD67vqutNvWiXfgjPe6FhZ1j2VU
3vsEIw1Xfkp48G1gA5lCBi1ky+P2BwCyRFy6woJrepz6pCuq0YjM033aYIg8GYMa
dztaSoLbSe6LeIcbLQbEkGDpSB8C8+VrtXzstUqLv6wn3j+S8G1x3TKBQgxf2uqc
Cc2HlwSw7Cv/Ycf/mMa5VLI8qqT/w6a3CliAsLfuJh1C5J15xHWuvICk2wy+QVKE
n2OaJLrE
=HdXB
-----END PGP SIGNATURE-----

--EvwkBhTPlFbBMdxj--
