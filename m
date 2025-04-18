Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E4E4C369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 13:40:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D56E83121;
	Fri, 18 Apr 2025 15:40:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ei+3SO69";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 819428304C; Fri, 18 Apr 2025 15:40:00 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AE01831EA
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 15:39:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-72ecc0eeb8bso408571a34.0
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 06:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744983597; x=1745588397; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KKQTgeon9YeUefXk1DTxrN3Dw+SJU84X6QPXBC82MAc=;
 b=Ei+3SO69Nx5mXMxLjcaq7sQXXZS1KMhrqXTGlC4Rr5gZFB443X/uUC1cwoSI2YPmD4
 mMbZ3iIE3RFKqOb2hVBq2qjUi5sCMplOaZCtqe9sLO1dWVKO+AnoIM0rTGpSNOA1wr58
 DQHAlRJKJnhNLl1KdCKvZXcoNZOFk3LMNldhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744983597; x=1745588397;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KKQTgeon9YeUefXk1DTxrN3Dw+SJU84X6QPXBC82MAc=;
 b=kumhwNy6r31zpPSluT5+0CsHChg80weNG8lALFheRymiuk7Lvu4CKIjX+QEeXg2FxB
 e9EvMXvEdjR1Hg2Q1fsppSUgqa6buJo8mibX34QqX55jP3vyRXKJgAJqSTiBd1v4fZNM
 3SPEYhUqC6O/uHPnj9iA7Odz+Mk5iq/xuooSoI81d9L0IIvOSNGgRIivjfsLMhB7O1zX
 yh7uekEvYCJrI/2MILId+rTEFCk7MOI4yRD9xg4iGzduOif8yIEFjnpqkN57KAZamuV9
 0xPTYb1W3/9jWnqSY4RmuHdeB5NkLxKzRtG2cEqK25TYZYYQkw1AVF1rC8dbZMeEUGpr
 0VfQ==
X-Gm-Message-State: AOJu0YzNeqpqdxj3A0TiAWiHFALGQoPJzJKPAsKtUV59gsnsXfpdYGwm
 Uqu+UIiEbOh3aPb3+GYMgILbkuZa98L3W21ukk+UGGQMlmcYPXJpM9FJZm/hsDxSlDC/jRgdXnA
 4
X-Gm-Gg: ASbGncuDJgDvhOFzgp55+w9m0NetP/QsV/0PWAKIpNAoer4bt2G2Y3f59RP5LfWmTu/
 8t03QspJ5p1ETKI5XwOg/RQ4XkEjKj4RU97pZYJ8oknRGeB4YHy0W/qGPAnJgS2xmnlBxIXUkq/
 HVEOGzkBHDsT4m0ta0dJJTarOUvu0EkYqQm/KUXlwL6omhw9retzgiCpOMAjgWyPOInVk6zURJU
 WN780XPts6uFxch9BpW39hKrb4xJia7uyS2RH1MnV/8Cm+e4x0ut+xWOkXfXMGett70dXapW09p
 WmXQOur/e/OPjfBo1hLkUPmrg+cNhE5cNN2wPMlEAKpFLza/VykufqUn27PGdxT/QVIKgNXMGup
 J72W02g/GyafF
X-Google-Smtp-Source: AGHT+IFF/3zWHGH9kP1FUNPUoGYGB/EnO8LyQxreb1NycLB1g2ffobtBq7jH4gBYP/uF9ngDiLK8cA==
X-Received: by 2002:a05:6830:d8b:b0:72b:80b4:dbca with SMTP id
 46e09a7af769-730061ef879mr1578035a34.5.1744983597142; 
 Fri, 18 Apr 2025 06:39:57 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-730047afc96sm334985a34.22.2025.04.18.06.39.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 06:39:56 -0700 (PDT)
Date: Fri, 18 Apr 2025 07:39:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <simon.glass@canonical.com>
Subject: Re: [PATCH v2 2/3] Bring in linux/overflow.h
Message-ID: <20250418133954.GL5495@bill-the-cat>
References: <20250418105919.1645824-1-sjg@chromium.org>
 <20250418105919.1645824-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PVesFIjTDxHKcAkJ"
Content-Disposition: inline
In-Reply-To: <20250418105919.1645824-2-sjg@chromium.org>
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


--PVesFIjTDxHKcAkJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 04:59:14AM -0600, Simon Glass wrote:

> From: Simon Glass <simon.glass@canonical.com>
>=20
> Add this file from Linux v6.14 so we can use it to add overflow checks,
> rather than using compiler built-ins directly.
>=20
> Signed-off-by: Simon Glass <simon.glass@canonical.com>
> Suggested-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--PVesFIjTDxHKcAkJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgCVioACgkQFHw5/5Y0
tyz1TAv/VcTLw8myypPbWSk/y0TnbWjZUlXvFdKoyQp5h5/70Xr5gGf0gl0MI/9I
qyXzDaL53NirfJwcZ8AH7PAu9sBtqI3OXaOW8cIZ8xtRMxqqpKAeXX3NIhxnAhM2
eoi5ng9I7A/eXR0DDU2iuIaI4+eJJ7zkCBOKrI3NFnFcV1z/FwmKSDSpt8IuKpH8
CwQ7BvUiGdG5Q0DnzFECVu/VHmuYE0SoF1UPVvZ3CHZVPJL2iMc0bAuAHtDvWf6t
tfu9+kQNo4OfQIC0iLe8PD8oLvArX5oC9WCLIMyKIQLv1dv2e3vkINufGX/LUF8T
2/eFEMX6pZ9L21Xa+yWqVRhx8ns//cI7ZABD8bq/iLccBIobLkgHzSIyraBA5o1n
PCehG/8AGYNZDKGU2eNAKNE77kXGeFCP2SG3vo19ZYnWoiEwqJmPhmLzI6a7R8/F
ATV++4Sf9pxLTLRvjfJyBF1dtLcIGCFz2RYPJWMas3ZpMG1VZt8HYc297H2fr9ty
d3ujzhp7
=sx65
-----END PGP SIGNATURE-----

--PVesFIjTDxHKcAkJ--
