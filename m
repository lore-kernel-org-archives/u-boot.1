Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B698CD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 19:45:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB35187A00;
	Wed, 10 Apr 2024 21:45:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bbqioD/F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 801FB87A00; Wed, 10 Apr 2024 21:44:59 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 500568815A
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 21:44:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-69b236a942dso1915316d6.0
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 12:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712778296; x=1713383096; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hvc0WvfQaVIVsSpdi3aXHw5ql0VrC9mg9iHvMVPRsiE=;
 b=bbqioD/F/lRe+pa0cGjVjhv3/QNrxBwZ0057KaDisyitveWZvOGaC7UvRQZn/lFRB5
 0Y/rgSlPmbsJPH72dk83sdHCj+FJ1gkY9GLGVozDXBivtYh1ntRisbRwvD07SQpBMudB
 XogtF1zM5ZLU6PHFRXoaj7acVDTL8SbJ4IJtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712778296; x=1713383096;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hvc0WvfQaVIVsSpdi3aXHw5ql0VrC9mg9iHvMVPRsiE=;
 b=Gz8CrvwM5x2djblB3oPk03zEShRtN7mfLSrgBfDR2Yp5BwQwDddwHq0ddMFMrMS+bf
 mEE3usPuYC2ac7kW2Ad7IAma2/NYqZe5KYGQBDNk9wUX5TgnUaYUPDyOIhcxRlo5ggYi
 dReMLy9XFQOK6LmcBnWwVLp/AswlnC8iFiTIj44PtFYKpHYRGjAHz5C26FNaQYdWAbC5
 6U1nPuIBzqygsFaTFykuNs9G4S4aiXmnZ2ir3uVc/hQInsnCgLxGLEc+QEuGVC2b0i6c
 jNLfSM/y1I/bmZl6Oczr0Q5grynoK67quSjKjLfxjyCmtDXdWwN4Vn1Z7EBfwNX+hz6w
 0p5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXexz4fZqn4k/GjLCD83TZAack+hJOfuDD6epe8tARRP1b94gnu55ZvjKa9g3iQ1hcx5Ws0MF6cWcVopcV/SZY0bxNd8g==
X-Gm-Message-State: AOJu0YzCWbYWBA4huidHPOAizQz52lBNmOFKGb7qZL2C48JENmMIJSsP
 fyn4LSjtzSIzmuPNenv2F9jHGs6fDg8guaH88uV3QHpXzbRwnf8Qg5BYWIVUG/0=
X-Google-Smtp-Source: AGHT+IEmzw/9gp/6gdkLYLzIXzuDHLQVQZfTcQ4pyXkCC3uud1zbVxTAkggTG0N3X1/RjIPJuBBxog==
X-Received: by 2002:a05:6214:2d04:b0:69b:432c:3004 with SMTP id
 mz4-20020a0562142d0400b0069b432c3004mr1146597qvb.11.1712778296132; 
 Wed, 10 Apr 2024 12:44:56 -0700 (PDT)
Received: from bill-the-cat ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 j6-20020a0cc346000000b0069b192e63bfsm3393561qvi.91.2024.04.10.12.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 12:44:55 -0700 (PDT)
Date: Wed, 10 Apr 2024 13:44:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] dm: core: add support for fallback drivers
Message-ID: <20240410194452.GG2493117@bill-the-cat>
References: <20240410-b4-stub-drivers-v1-0-6935bd2c07d1@linaro.org>
 <20240410-b4-stub-drivers-v1-1-6935bd2c07d1@linaro.org>
 <1EFAA3ED-7C3B-43DA-AA0A-FC520FF16290@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NBTYSzoSUqo9BWx/"
Content-Disposition: inline
In-Reply-To: <1EFAA3ED-7C3B-43DA-AA0A-FC520FF16290@gmx.de>
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


--NBTYSzoSUqo9BWx/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 07:27:17PM +0200, Heinrich Schuchardt wrote:
>=20
>=20
> Am 10. April 2024 19:06:57 MESZ schrieb Caleb Connolly <caleb.connolly@li=
naro.org>:
> >Introduce support for a uclass to provide a fallback/stub driver which
> >can be used when no device is found for a given node. This might be
> >useful for handling non-essential clock controllers like the RPMh on
> >Qualcomm platforms, or during early bringup to get UART output before a
> >real clock driver has been created.
> >
> >Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> >---
> > drivers/core/Kconfig  | 10 ++++++++++
> > drivers/core/uclass.c | 24 +++++++++++++++++++++++-
> > include/dm/uclass.h   |  3 +++
> > 3 files changed, 36 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
> >index 1081d61fcf01..09075b9b7a15 100644
> >--- a/drivers/core/Kconfig
> >+++ b/drivers/core/Kconfig
> >@@ -466,5 +466,15 @@ config BOUNCE_BUFFER
> >=20
> > 	  A second possible use of bounce buffers is their ability to
> > 	  provide aligned buffers for DMA operations.
> >=20
> >+menuconfig FALLBACK_DRIVERS
>=20
> Wouldn't it be preferable to mark individual drivers as fallback drivers =
in their declaration?
>=20
> This would allow alternative fallback drivers and would not require any d=
efinitions at uclass level.
>=20
> Just by building a fallback driver you would enable the fallback behavior=
 for its uclass.

I think some of this is addressed in the cover letter. My concern /
questions come down to I think just a matter of naming. Both "fallback"
and "stub" are used at times. As a concept, we have some areas where we
need a no-op driver because whereas the DT describes a relationship in
the hardware, here in U-Boot we can just accept things as configured. To
me "fallback" implies more functionality of the driver when it's really
just a generic no-op driver to fill in the dependencies within the tree.
Can we rename things a bit along those lines?

--=20
Tom

--NBTYSzoSUqo9BWx/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYW7C0ACgkQFHw5/5Y0
tyy/VAwAq1IMce9ZxzKkxR6RfJRgOgyseVwkzJ3Sccq1Sq+PHOU6z45QqEl9wmve
ykQFjBG0J4/yxHguQPAXsY1zEI0KXB+UaOd7OFymOGsuFLRdUZdWcKKTra5wY1Tt
E6Zw9pqOPZ2c7UVWUBKhnYdSFMXWt6vb2vhHgRyvdf5SSC8Gy5v5M87khm9utypT
nVEBY8AZwbaDxIqDGSaRa3F+T/6Ll6sdx5o96kQfj6IPXvE/xQFR9GwfYB3yFQyO
kwEYDYQpQjNCABwEj2jmUp6+55Gs3pMUprVzezrElof6pN0asovioNRuIJjPIbKN
Oe0ws2nnB5LxPbIrF82crNEca21jDX8grKIZmWz/kWeGkPHoNKYZMtxxVacBkj6F
Cok4+nbD/soJcRLi2U4/i7Ac48WxBAVXoQJ2PhJmn6HeeR20kionT7BlVSVhgPdF
+Q6+nX0zZoQ5ygPMUcTk6kSSy+63ZR9+aOtgPFBsiyUSoPx6VpQKwhkcmtike8hQ
5nu2reN8
=45Zc
-----END PGP SIGNATURE-----

--NBTYSzoSUqo9BWx/--
