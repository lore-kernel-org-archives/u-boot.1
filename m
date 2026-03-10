Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE28FD4F04
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 16:25:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABB5D84101;
	Tue, 10 Mar 2026 17:25:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R08nGVrM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0ED0A8410C; Tue, 10 Mar 2026 17:25:41 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F29A840EE
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 17:25:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-41576c5c01cso5039672fac.3
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 09:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773159937; x=1773764737; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=K04IYS01+cnE0Di5hkKD/XiQwdjr+UZ4EmiXntXRkAg=;
 b=R08nGVrMZMa+MDjLjMJG0MC+1R3PSAAxwDGLO5IVY9fJKTlHOucBHF1rkJ8bsm4BpY
 ibxivu0CYp837KhVA3hSsWy8LWy+ULKBF5i8qjiAqAO6VonXhcujnjVTjeidLYRydtvU
 dGfpXdHsfFjp10E/bnvTvFakNTaQgUSwYM4Ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773159937; x=1773764737;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K04IYS01+cnE0Di5hkKD/XiQwdjr+UZ4EmiXntXRkAg=;
 b=m+SJjoruV6GdIlc9tybMCbkYhXI2+1z8JgqzmVnwIkY1MTtwyuDkhlKyZ34tpsgOjn
 nFUuHZ/ZzB6LMmyo4Yha2BL66QVWBjeRnROaleo4OLD9dvvMb0yW2XISS6FoSCiyfVp1
 CE/BZDaDQW8Yc4+eQ4i1KLU5kIEEBGzYZTIUIW0hBdtqjOi0iWVqXBSNHjz0onhatVmf
 eztIbgNGN/4BDWaA9McuatsPiCg6JvNCXZDwRBBdv7gO42aNHncsztLoQjzOnBEdxcg5
 422o0C3ET/svq+iIaCneHflu0lDKsKJPOf0qdhMHR0HCa1Zr/SuDxWZZ0jm23vAuJOFW
 xrEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4pVh4RjObdUb+gh1SwCV4434juKlm9zimioAfW89yDhIzx1XZ4A4AK3bneyK7JGiNDFQDKlA=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4JYxWC2T4Sh1druSvOaGZ66nHG0W7ObWBZoxgppeQZgzfxsLR
 UqBLNOfhKNqdv7EWNlgjmM8CBaJMu6SKpdoCcp4pZ+rfsKcWx4LHTnYD7ObY0sXuxLqBdjyoyzq
 sTu81uv0=
X-Gm-Gg: ATEYQzw6ZLaeayRjRzjXZCFEUZm2bOQPYQ08dDl2DGyL7Y/9COCF00JlTKHufY2ZAAR
 rjfJUphehQbAK+xdeaLLaPxSqnMUtHrHfHYuHp4b3Nvo9nwf1aqDwUSQtt6yDRdEX7UzhxFRLlb
 bOAbghCeLtNiyYEPpWLMk8i306eHyM2tM0TUTgcvc/1Se5FvhX8MAHGeqLhGNxXR/byKD2XTATV
 Lr+PuraX2G8BPluMJmg8BkKeGF2GhT8qifX+lvpJB08vW8ylm910Fa86QCO48y3PoKSIBV9AsjR
 av5fdeHwrjP8jybqzbhJ3Ewc9gJqtZ3G0fpR8zS8SyxLaoq7AvV7KqEu8qo6dM5b4nxzus+00sl
 xV3Fb6GMG2xWPfEu5tsL72CJejHIf+H/J6TZIk174g1plmudj3DiY1eoPnhAdn17ObCzZ45aY0y
 e7axMa9yhXYWitCPPC2SJWToS56rOzud0ghY4lzUvKlPpsTKhi+R5VPU18Kw6PPJg2Rk6ZvpZv1
 omTHSmyPYOgVPFmzjib7PqWcTf3amJFbUXyNllFo5Tpsw==
X-Received: by 2002:a05:6871:5e98:b0:417:21ab:3a92 with SMTP id
 586e51a60fabf-41721ab5e86mr4452834fac.22.1773159937189; 
 Tue, 10 Mar 2026 09:25:37 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-417715934ccsm811108fac.7.2026.03.10.09.25.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 09:25:36 -0700 (PDT)
Date: Tue, 10 Mar 2026 10:25:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Daniel Palmer <daniel@0x0f.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/3] serial: goldfish: Add debug uart support
Message-ID: <20260310162534.GK1388590@bill-the-cat>
References: <20260309105110.672832-1-daniel@0x0f.com>
 <aa-1OYXTCbsYImgr@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EYfPSafoHYUoEXHz"
Content-Disposition: inline
In-Reply-To: <aa-1OYXTCbsYImgr@google.com>
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


--EYfPSafoHYUoEXHz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 02:07:53PM +0800, Kuan-Wei Chiu wrote:
> On Mon, Mar 09, 2026 at 07:51:08PM +0900, Daniel Palmer wrote:
> > Add debug support for the goldfish tty so it can be used for
> > early debugging. This will be really useful when adding support
> > for relocation to the m68k qemu virt machine.
> >=20
> > Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> > ---
> >  drivers/serial/Kconfig           |  8 ++++++++
> >  drivers/serial/serial_goldfish.c | 18 ++++++++++++++++++
> >  2 files changed, 26 insertions(+)
>=20
> For the series:
>=20
> Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> Tested-by: Kuan-Wei Chiu <visitorckw@gmail.com>
>=20
> Hi Tom,
> Would you take this patchset directly, or would you prefer a pull
> request?

I will apply this to next directly, after it's been posted for about 2
weeks to allow for other reviews.

--=20
Tom

--EYfPSafoHYUoEXHz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCabBF+wAKCRAr4qD1Cr/k
CvWoAQDNZYw3OOyO6n/PerpVDfYYwae7+7NjYbJFPwJfKUNumAEA/8tDuKEvcTV0
5JYj22SeRxAe5svDPf+sgGvJP6lPNgk=
=8v3W
-----END PGP SIGNATURE-----

--EYfPSafoHYUoEXHz--
