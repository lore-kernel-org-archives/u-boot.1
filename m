Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8693DD597B6
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 23:11:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34633894C1;
	Wed, 13 Nov 2024 00:11:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BlQv/bIg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46DF6894C0; Wed, 13 Nov 2024 00:11:21 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3910488C0F
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 00:11:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7b15467f383so464040185a.3
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731453078; x=1732057878; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=V/z3iSG7roPnGO7fYFrB58XiD/+M5rK6Cjkx/2Bmho4=;
 b=BlQv/bIgaU/vUFeqFsw1xlVBocDol0jwHqbQljCUTooRwBE/51PhCVCNt3sC7V8pxK
 oPIz6ws44msjSH1CgXt9ScRUxGaKuU2uffzkvb4RsTMn7T3TJCr2+hzSGrFbU1Pxoag0
 SGadAH6XL5Fma3gY/cqfaQnh53gvVdt5EXAp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731453078; x=1732057878;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V/z3iSG7roPnGO7fYFrB58XiD/+M5rK6Cjkx/2Bmho4=;
 b=d/gcpPDV7F0yOHOCCbiWLzP/0azqJgm0+Oog70rgvXjQ5aJVNvnLjZpvBKkeC1pCq/
 RaxsEcFHheKcqVXsXikmhhIvN2zcWTJRKBp/3lZHEUeSlJt7KIMhzctzXhbGGYWNkvT/
 f/MhcFRs0TJIcdO2M3eysQd645sf8RoSm+JqMzpsGBGJvZOj8ODtMSBBoPv1Y1XnPwck
 R0d4fsBjvcHYpefA1UKSrn1twGsSV8SnHOCt0KgQFAEVF1D0cYSBGP+MfGio0PceUVdX
 2+n0PYWi3cgXsfll650gk7faIF9OSu8g3FPpmgZehuhYisJ87ZDgbD1xsBtt0JBqEiSB
 kCQQ==
X-Gm-Message-State: AOJu0YxjQ41+HYaVEMLfRidu2yrUgzqPwPWYPwGOL8bQAipf0TibQ8Kp
 crczqUSMjEkMRTvHgbyQG/f6mBMnwQQPGY4o0D9lC66lqK62rACXJEKV+ihEiiU=
X-Google-Smtp-Source: AGHT+IGEq7ZHDIXaq7m7o4ldLUP6Sby7Fd0+1+FEnwztNjOiq9IEm+t1YTJwB6cah9WHhW8ADdcMuw==
X-Received: by 2002:a05:620a:400d:b0:7b1:14ee:2948 with SMTP id
 af79cd13be357-7b3528fbbb6mr92342085a.41.1731453078114; 
 Tue, 12 Nov 2024 15:11:18 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b32ac54e5fsm636618985a.49.2024.11.12.15.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 15:11:17 -0800 (PST)
Date: Tue, 12 Nov 2024 17:11:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v3 7/9] docker: Install toolchains on arm64 host
Message-ID: <20241112231115.GC3600562@bill-the-cat>
References: <20241112141105.640189-1-sjg@chromium.org>
 <20241112141105.640189-8-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HfHfOce4AnfZPEXz"
Content-Disposition: inline
In-Reply-To: <20241112141105.640189-8-sjg@chromium.org>
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


--HfHfOce4AnfZPEXz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 07:11:03AM -0700, Simon Glass wrote:

> Refactor the code to support downloading toolchains for arm64 as well as
> x86_64
>=20
> There doesn't seem to be an xtensa toolchain for arm64 at the same
> location, so download that only on x86
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--HfHfOce4AnfZPEXz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcz4JMACgkQFHw5/5Y0
tywW/wv/axaBedmThQFONqDsk5cihGd0hlVIcsVBzzcYinDcQAdGlW0KJmFIRFnu
B/ViWRMcKINU7yKgHodqnMOMAhitf+o07jtyfr5tSP6LDxqSK2K3pZmlSIEiqBZ2
NOtrhyLfOpdpKvC+SnOrdo1Bck0GmZpaNnPqla6H0x1hFuYxNW6+TG69pL1ENhYT
LC48S00nFh4DKSZU2CWaALhLu2v8KYSMLLL4aExeMsU9AoNpZMN8KjOUMU0vgI96
DXC6eo9iUUv5NaojOH7DiNfu+tOtJXJ5nL5IuecXEkIE/p6k0tGH1NdxbCi+11Dr
cVhd0TkGlHKQAuw0q2P746DtC82jiOjvm8UuiRYSDFeN7FoynetcWwN6E+ykYE/a
wH2tHsdmPzSfK2eJ1+LL0/S4hqgARO2OK9RgmZ8hJpPruevqlUnsuuYI1e1fM69q
3bJAfKhc0dmOJTbw1MFLG2/qnJLjwDdUPrbxM+lsEbIhSNOlebpUhwDoHFL/OCYy
LxtX/Hzj
=d4kp
-----END PGP SIGNATURE-----

--HfHfOce4AnfZPEXz--
