Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343E0C4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 14:53:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F92286FCE;
	Thu,  2 Nov 2023 15:53:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OtT8k/Tk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B137C86FCE; Thu,  2 Nov 2023 15:53:24 +0100 (CET)
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com
 [IPv6:2607:f8b0:4864:20::a2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F8BB8721D
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 15:53:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-4a06fb5331bso415822e0c.0
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 07:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698936798; x=1699541598; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/AdiPvUe7R7hfY0XmjRgH/D1y7ndY8UvULkeWy60vwc=;
 b=OtT8k/Tk5NknjuSdu9VCrBkEZsYFOpcgEXK7XtbWzy7tj5nqvl8h6a8Lpf7WeuBkFN
 oTtaeHwtylR3+ltiew5B6M1HL9NeURxfeoeK2BcWew+FLY25nSsCuVpgQtQeF0GmUNo1
 rgPbFRr3jaT6rAWFFK/ZqWLxA/6boM4OWTE1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698936798; x=1699541598;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/AdiPvUe7R7hfY0XmjRgH/D1y7ndY8UvULkeWy60vwc=;
 b=eqN0n/luDP8nT1q/UumUHresJUpftrDwtcBZbsHIR5hZuIc/oZBhL1nhnDJDjUZaLF
 BszA2SqJDxT+GfjXL7KDVzVTnh1l3mm5kdU5zjyfrOkzBQ9oSAOItuD56QZRqM8zldko
 qZZSqZskynMGDMqVmNx9jI/zu+JmYDo3VOmGi4osGEN9mATT9mt7mQgJXCdzdx8uEV7u
 q+8jQ8nNv6DtUWw+ps3lpxzicuttEa+qO/QPbgyn+esbHcEMZuQUXk7DQTm4KYt4ydkw
 PCSb+unw8+wUtPW2BBfUUrZYxkdqTDFu1CtTl6RrOeaJgb7ugyW3aCU8HBkXeRnMeEsT
 Q9LA==
X-Gm-Message-State: AOJu0YyvqMqRjnU3siX6apW8m6sg9Njr0BSpIN4bIxupKNPlG8TOQmHD
 sJUR+4NgW8CnwBPmZ64JUIMmzZfbIfWWs00lo/8gZw==
X-Google-Smtp-Source: AGHT+IFUpBYoyP8tJsCCgaLowHzuBtzoef2OKx1iaoecVAj28u26NKXZj4zGcDX05tNNIkt74f3p8Q==
X-Received: by 2002:a1f:a90d:0:b0:4a0:6fd4:4334 with SMTP id
 s13-20020a1fa90d000000b004a06fd44334mr17519460vke.12.1698936797154; 
 Thu, 02 Nov 2023 07:53:17 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 c16-20020ad44310000000b006585c7f64a3sm9705qvs.14.2023.11.02.07.53.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 07:53:16 -0700 (PDT)
Date: Thu, 2 Nov 2023 10:53:14 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/2] bootstd: Handle a few special cases in
 cmdline_set_arg()
Message-ID: <20231102145314.GI496310@bill-the-cat>
References: <20231024181740.1938934-1-sjg@chromium.org>
 <20231025071736.1.Idf6184075aeff5599d9205c7efd61b10869cccea@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qzEfKDYmsus14a5U"
Content-Disposition: inline
In-Reply-To: <20231025071736.1.Idf6184075aeff5599d9205c7efd61b10869cccea@changeid>
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


--qzEfKDYmsus14a5U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 07:17:36AM +1300, Simon Glass wrote:

> Two bugs have appeared:
>=20
> - arguments can have an equals sign embedded in them, which must be
>   considered part of the value
> - arguments must fully match the name; partial matches should be
>   ignored
>=20
> Fix these and add a test to cover both.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--qzEfKDYmsus14a5U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVDt9oACgkQFHw5/5Y0
tyzkVwv/bbocoT0OP1aHV9yz1OxTHs2u/3ZRlXrrvX5vSgrrq57hSYYt83l+GLSw
sERSsOzoCvu+3cF/D5WHdvhcy+wgWEufGxDxwpdUrt8q2BKpYoequB+UKFOoooMc
HXiMJE8Xe8PNtf+KEW3KqbXg+OSRSlFG1Oi34dLO/1ZRaVXJxNjpCjRoTfBjyy61
0nDMm28iFc0JXGJL9PTCrudNGKrX0jNDOXz2/7UN724OQWNxjYIco2nZSwfhQX2U
oqyJzF3nXXqsgAI5Kan5zVwhwRp+NqJBGrASUd0qzbLRDj5vNgqHxrRxtiwUKKIG
AxVmyYVFEbG1GYOfLObOb5gXP8WoG/i0+b4rwLV0AkZA44gZ9Hss6OciUYMvLYoQ
o86pHyuzCqER3RoEZXFFShmwEXyMIfsg06gV8tueSmHi8pnxbFTyYUTQhnhxVa4s
M3eL9ituAIFxqTtsa2D/1D33BPswEOIDUETvcC452pc6jeZ0fUut8ZeFONMd5gnh
a5iWG/Xa
=hp8l
-----END PGP SIGNATURE-----

--qzEfKDYmsus14a5U--
