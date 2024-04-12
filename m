Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF697C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 18:52:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E49C881CD;
	Fri, 12 Apr 2024 20:52:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KhSdg3mu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D4E487E91; Fri, 12 Apr 2024 20:52:04 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2F6F88137
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 20:52:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6ea0db2727bso714067a34.2
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 11:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712947921; x=1713552721; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=woJJPWKzGBNaUS1SlhzX3Nk+XPXtt1NduPZ05i4gap4=;
 b=KhSdg3muw4reTr3HKHrNW7ph7WNUMUM/e+QFRoEPIXsiX0KsH4HxsQcRPFmSUcg6Ig
 wqTL8mMgXiWOrWXtNLwgS+Fl4jatKXZELDInE1PbI+N1Uio5NKidiPmpD1kO8mLB4vUM
 KyAw4pe+xrKMP3mihVp5lFMu031Nmzejl4c9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712947921; x=1713552721;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=woJJPWKzGBNaUS1SlhzX3Nk+XPXtt1NduPZ05i4gap4=;
 b=bOhsbdHxVc8fjjyzg07k4k2lQA1X4uDWPj6qcdJotFqPgDytxue2o8KZ29kYNS0QPq
 +k7rpRnxN948nkOMtbZy9F/nsF6kOw7lkEid4ja3OPD1scTvQt7Tv6l/Kmh30xV/T1AN
 c9Im1aZspwX1dJtgLOaXDHjgottYE7ou+cT3ZrqLR1N4W4SfxPtZ/n+tqPFHoaPj+xA6
 DMGwxOIrHDWp4I7/VpEEyJBzBHanpotC8SIOZq+T+TxgBq3AJb7TjSOT8O8kuhEMDukV
 UFrLOMczHMD1WaAZarwlYoSyl5rV9r5unX2sibQuewCrGqQMgzptms1vyGxVwfArEW/3
 f0mQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgF/SjbOqkGg8JwPJcrwkgh+BisHgP+qCaCyyNKSdVjR0x7eyJHSFZZxXJ7Gpe6YVUv0SaO0HSeSx811lPWp+q6sVZFw==
X-Gm-Message-State: AOJu0YzopoQ2gwKA/KfEYET5aamhsfoIMZ/7KiOOETp1uOSvKJ1yPQUl
 4wSt4YCrph3FeDQJzytv5uSoyGTKkA/cVdBWPEabNPs35P1jSqKBIKprwHfXb/A=
X-Google-Smtp-Source: AGHT+IGLe1B5Vfi0m00M0rgnl7Kp/d0K6ZvuRxDkSwNGlR/5K7d9InUttjDIhlPnzKbL/NkHRF6XXA==
X-Received: by 2002:a05:6808:1484:b0:3c3:d60d:e8e2 with SMTP id
 e4-20020a056808148400b003c3d60de8e2mr3701373oiw.34.1712947920667; 
 Fri, 12 Apr 2024 11:52:00 -0700 (PDT)
Received: from bill-the-cat ([2806:102e:18:245e:b648:93e1:5c61:68a3])
 by smtp.gmail.com with ESMTPSA id
 jr13-20020a05622a800d00b00434c25cb61bsm2545234qtb.73.2024.04.12.11.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 11:52:00 -0700 (PDT)
Date: Fri, 12 Apr 2024 12:51:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] sandbox: move sandbox specifics to booti_setup()
Message-ID: <20240412185157.GP2493117@bill-the-cat>
References: <20240111080344.112746-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Epn0lY4cyYeDLN8p"
Content-Disposition: inline
In-Reply-To: <20240111080344.112746-1-heinrich.schuchardt@canonical.com>
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


--Epn0lY4cyYeDLN8p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 09:03:43AM +0100, Heinrich Schuchardt wrote:

> Instead of checking a configuration setting in booti_start() adjust the
> sandbox implementation of booti_setup().
>=20
> Write a console message when trying to run the booti command on the sandb=
ox
> indicating that it is not supported.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Applied to u-boot/master, thanks!

--=20
Tom

--Epn0lY4cyYeDLN8p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYZgs0ACgkQFHw5/5Y0
tyw1Hgv8CWl/aRS3NJMirVePE6XJ2cT0RH//5ipKmVBI/xsD3M+5trvCVwRn1JlA
tjlCaneocgpCrYtWOrerksdcvO/eLUkIf0Cs33SITBui9LLdQjk4e1wirZNwqHMh
773xyvWd3eoEbnlCKiXnW8pT8h2IPkwDmsEcBH2tS1MIshrp/M1hUR4cJurqoaWs
+sM+AX27a3YaZWx6rJK4skXs1IaintY+0i1MBO/HVS3A2noEYRr81Zkemaz3gLci
Ke9CYoO9Swmxr66sGRnJCNlNmJcxrClJRTYBBsmWYpWHJ9242vldc+98imEutlnW
PhiAIbfZPbkipJP43zeWn5/ELnpfDXBc4Vxh1TMG+4WZ9FGRB6ODh/ryXdErQMcA
lhqg9dzVtw3lYQpQqztaQvG2e4VuBNQcxVKvKJL6Ns16Rh/9zQrmF/HjpkYMwzCz
xL7bKAUEPqxeL1v/RjfJwZzBedKIiR3yo5TqaZpSwIcYexWdNiNBDfzYeQ5070Bt
tEBvXDxu
=Sxbc
-----END PGP SIGNATURE-----

--Epn0lY4cyYeDLN8p--
