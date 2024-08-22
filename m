Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB91C52D7C
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 15:13:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADD8088A50;
	Thu, 22 Aug 2024 17:13:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VjP83fDl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F80888210; Thu, 22 Aug 2024 17:13:29 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53AFD88A5B
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 17:13:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5dca990cf58so724354eaf.1
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 08:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724339606; x=1724944406; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=e0N79+kC/RVF/SqlW3KUE8CR9Fdgd/vyiL8tjDdfiU4=;
 b=VjP83fDld0f402hJKl5HP/8HEu/yg7/91X4v1y8JUV4XTc8yc47u+cH/YWZneZmNYm
 9O2zbrzKMkv6a12Lof7LetfqOV1DLkD/x0XlXL7qq/nPN5+B36x0O0oEc7rKOQIPTukA
 os0pV/KL0RwJFI04tuQhC+fk62yRSWS0lCKT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724339606; x=1724944406;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e0N79+kC/RVF/SqlW3KUE8CR9Fdgd/vyiL8tjDdfiU4=;
 b=kZKOY7/JIdmpGc2cV7rgxTJhvdc1DGr0i9s/QvsnnyifMwON1lShEWU8M2v0xIeVRE
 wXvOUnkpUyGEp28y866jkvMvGiigTjPB8bkm6JWclnHlB8jSSaZovcTyd1S+ruCAz3+4
 qzc/ie3NlE9hTZWBWErfWAC3PMftzu+qI3UWgS+6w0aYbOo3E09fRmd9KO1/AOUpU7+6
 CFNIAwhN1lSQK2QWtHo/Fvs84Ev+xzfDwESvy2Kf///ISmWaF2WZu2EYvSgBe3xLXWGc
 ySd5OIGKWMzZXv6FdiaI3XzKAniL5STNA0AhynAHUnoyDJEcARJiO2Xe5jUaiS12WZUh
 Q7+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGgawYs6x0Wo0AOFPSlS9IHd6SO23lOwU/s6eB5sAMRAidopxvqVdle3SR5aUUAzEEARI3lX8=@lists.denx.de
X-Gm-Message-State: AOJu0YyftPoeF9/MDXE3uVna6r9XhOsfUs/bWPQ65P6cmNnOslj79XF6
 LxoOIA2cUsxpzmZB9jViQTizGEwwsDMJo5kOYtCvpr1dxw6GGf1rpCTWn86XWek=
X-Google-Smtp-Source: AGHT+IGU4JKP6P+gLSK5gdMCnDWmDNyDx3LiAj6x5rYGV2KpYZKyguSxqw0RlIaEC0AySdiYO0Rb9g==
X-Received: by 2002:a05:6820:200e:b0:5da:9204:6727 with SMTP id
 006d021491bc7-5dca06333bfmr7473652eaf.6.1724339605875; 
 Thu, 22 Aug 2024 08:13:25 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-236.totalplay.net.
 [187.190.197.236]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5dcb5e00f08sm301710eaf.25.2024.08.22.08.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 08:13:25 -0700 (PDT)
Date: Thu, 22 Aug 2024 09:13:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 37/39] efi: Avoid using sandbox virtio devices
Message-ID: <20240822151322.GU1626301@bill-the-cat>
References: <20240806125850.2316956-1-sjg@chromium.org>
 <20240806125850.2316956-38-sjg@chromium.org>
 <23093165-6af9-4582-8448-7bbae3c86be2@gmx.de>
 <20240807015613.GD1626301@bill-the-cat>
 <CAFLszThhn0240xt1j6GQB9QTKxiHiAg6J3vMXCnHBE15iYZSkA@mail.gmail.com>
 <20240808200634.GR1626301@bill-the-cat>
 <CAFLszThM=23AXCOfZ_uOyGGDQTRurDpAjR-t8X_NHjz4LgQ9SA@mail.gmail.com>
 <20240814175601.GP1626301@bill-the-cat>
 <CAFLszThU+vLUm_fveWUgV3Qt3J+F3=Sr1aBgbc4T5z8zJJz5sw@mail.gmail.com>
 <CAFLszThG_oM4B3beUfOrjXD2-B3sMo44U5-G-J8Eky1uZU=bAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gc0d8ddYD6BnSWBo"
Content-Disposition: inline
In-Reply-To: <CAFLszThG_oM4B3beUfOrjXD2-B3sMo44U5-G-J8Eky1uZU=bAw@mail.gmail.com>
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


--gc0d8ddYD6BnSWBo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 05:53:59PM -0600, Simon Glass wrote:
[snip]
> > Some notes from a little bit of digging: There are almost 1000 sandbox
> > tests (17-20mins), but qemu_arm only runs 62 (2mins). With 'make
> > qcheck' it runs about 2500 tests in about 4 minutes. I just got 'make
> > pcheck' going again and that is a little faster (2.5 mins). Binman
> > tests run in parallel if you use 'pip install concurrencytest'
>=20
> While on this topic I forgot to mention that the sandbox tests (~800
> of them) actually run in about 10 seconds. Try 'ut all' (although
> you'll need my test-fix series to stop it crashing).
>=20
> The reason pytest is so slow with sandbox is that it talks to U-Boot
> through a pty. Stephen Warren did something clever to stop it being
> horrible, but it is still very slow.

Seeing about addressing this more would probably be very helpful then as
most of the runs (by user, I mean) happen via pytest and not directly
running sandbox I strongly suspect.

--=20
Tom

--gc0d8ddYD6BnSWBo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbHVY8ACgkQFHw5/5Y0
tyxZZAv/clvp4IUymwIvPdzUnhFrKzVOqvAo/0MTayiGPUHuEhGN0WHl4RbtegzA
j14sldBhzym7nEmPR921OygTFJ62wYIAK/rbfvghgX0RvV0vO43BWRWLGVWjUWUo
iHaGKmf3FWvL9NkrLqA3PuPUlqNSBQPFgbdAJTLyk+CJQyfA0IK3BXK/PxAIvEud
VGqFXf7g/bgwXIQzRU1xTYK7cc329jAmmdNnQ+bb1F25gud1V/J+kTPEFpXYJKIf
f2adHlPjq4l0jHjRxP87rTealGPC/HF+gBTRcdBl/sncTeQT0aQba0vh+GKxrfrE
7OBnHRfCXIrWYgk0D9HCepIMOKkQv0Fk4orU9hcAhbGi430q3KuKbTCbDrLKGwDl
ZfTvSju0LlvuCxrVUegpzHU2bM3PyC+WQ0GO7HZRyXakIEV3pkPC5wyn36NBQ6rP
Qho1unxDviltoCHH4yrkLkBGPEbFb/nni+GdP9Ho4R5+caPg/oXoqr5HTvC8nmvY
TBU7rhzk
=Q/J2
-----END PGP SIGNATURE-----

--gc0d8ddYD6BnSWBo--
