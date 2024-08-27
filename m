Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 572D1C54731
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 16:50:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B33EE889A2;
	Tue, 27 Aug 2024 18:50:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XVdCx51P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A15488928; Tue, 27 Aug 2024 18:50:33 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2147788800
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 18:50:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5de8ca99d15so2055088eaf.0
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 09:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724777429; x=1725382229; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=axNmJTpjYYqmpFOE/JyZ6z0D36G5bjabkzRaL3zRyik=;
 b=XVdCx51P/YjmObrQYS0SOLNsFFHmCrLH21IE0CKxZDVrvfhG8xbNWgX4Q9dAPiGz+B
 EaMcPzlqbNnmDL5CalXImZZT+1Ly/Vfxke76ByJrvXOjikNoAgVxeZzbH0tkMyhdv06P
 8UICy8V5UjZl6FOPL50r+bfCZ29LUW/pQ3G3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724777429; x=1725382229;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=axNmJTpjYYqmpFOE/JyZ6z0D36G5bjabkzRaL3zRyik=;
 b=BT3g6HXlmqUSVXrSdb4gzF0JVf1Y7Qyxp263dl5aiwcl0kVOJLMWn2nxMqXiH92RJ6
 Mc3OURIjDQ9vVLEm4TZ9ip8ZBEmHC1NdmRHQRaG2j/m47W/RKCNJuJQyA6/MBirN4xuv
 f7/+BkrCMfFVUt4WVBXVb0uPqfThOarTNYARNAkIMukrdMuBBh3IAd8B3LOVLkWopgVK
 9wAOC4rHRlyruBlTCrcYuI9Pa6BBQcO8+H9pnYeUe0qRRWnnV9Tj6jGnZyvYZ7Ud3GU4
 dX1lZLH7JuIk9aj1+lUEizfTjxE+oHgA/YhRmsgq7VngNwYhR6qvaWJoZJK/yYjWx4c2
 J/qg==
X-Gm-Message-State: AOJu0YwKZSHG2lvjND4SfjZq3LwG9Hx/gpEw1J1DdjYJkSTfAXUP8tAL
 WPzejQsd+NxjnYjfSpIH0kFAiXHIGjRzYtJy3Q8ny4RKFpO1MRBUOLrTlvQzE1o=
X-Google-Smtp-Source: AGHT+IHtkBO1krnZxnMSijIcEJeQDXirbhkTfhw+JNQOWzHS/eqt7NnS0oQN5tEG9UthaV670TaLKQ==
X-Received: by 2002:a05:6358:7510:b0:1b5:e9e2:cbe5 with SMTP id
 e5c5f4694b2df-1b5ec014206mr419265655d.20.1724777428677; 
 Tue, 27 Aug 2024 09:50:28 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a67f3d5cd2sm565867485a.82.2024.08.27.09.50.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 09:50:28 -0700 (PDT)
Date: Tue, 27 Aug 2024 10:50:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: xPL terminology
Message-ID: <20240827165025.GN2479150@bill-the-cat>
References: <CAFLszThRq1MmeAukYW+uwe5nBiku94qXALLMZ4S9ySFfbW0AkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="K8+RJcx40rD7eBrt"
Content-Disposition: inline
In-Reply-To: <CAFLszThRq1MmeAukYW+uwe5nBiku94qXALLMZ4S9ySFfbW0AkA@mail.gmail.com>
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


--K8+RJcx40rD7eBrt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 25, 2024 at 07:07:23AM -0600, Simon Glass wrote:

> Hi,
>=20
> We have the term 'SPL', which has a dual meaning. It is both a
> particular phase of U-Boot (the one that loads U-Boot proper) and a
> generic name for any pre-proper phase.
>=20
> You can see that in a few areas, but for example CONFIG_SPL_BUILD is
> enabled for TPL and VPL builds, not just SPL.
>=20
> I propose to rename the generic term from SPL to xPL (meaning any PL
> phase), leaving SPL to just refer to the phase before U-Boot proper.
>=20
> The symbol would be CONFIG_XPL but in documentation we would talk of
> xPL, with a lower-case X, so it is more obvious that it refers to any
> phase.
>=20
> What do you think?

I still worry this is just another part of the long symptom of needing
to re-work how we configure / build as we have 1 case of "build things
this way" (full U-Boot) and N cases of "build things another way" (SPL,
TPL, VPL, UPL?). And really we need a way to short-hand
"fooboard_defconfig" means "fooboard_spl_defconfig +
fooboard_tpl_defconfig + fooboard_SOMETHING_defconfig".

But on the flip side, I also suppose replacing CONFIG_SPL_BUILD with
CONFIG_XPL_BUILD would be less confusing.

--=20
Tom

--K8+RJcx40rD7eBrt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbOA80ACgkQFHw5/5Y0
tyxlBAv/VJsoUIQk0NH8AGkMs2TQtVzb+Ptq+S1m43oF4L7Cs80+KDOrAwWjWpl+
g01m7RKm9QcKDSfxuWlruAg+n0GPR6DgFaXxH0Qy0TkdSySbvMUnNOAGQ0B0Svur
EGx9xSDlZQo8qC4vT5AtD3ZpF16qLbrM1qiBWozK1AS1Kh12lfcd/hHYm6pF2inD
NX+ZJMmXxr/OAwMpiK6XKGV0yKRFzvhCOMp8ca5aRQN56aOfR0LqAvkLtJAL4H14
MalDI8kXHmklDdd7rBNUSzauC2vwcwXQ8IHDh8osexn3KieTCvRx6fusGZl6KVQA
elOhnQEqc0IKMk7aoJqbVJTGAYWsss4izCDeKXTDniMNv4LGJ2s3MruYrlLmncQQ
21b8RW+RUfhEILucZq7d4rbz8lzndbLOJU8o/M1Q4KSYDZg/+oKLbxjD9wJXLapJ
2UPcsDr/Ccz7kNnwtnP8HHIJeNxhmUYAeNYmrSKM9+A+rK6cD8efaIZxi8PwSD6j
UlLZHTi9
=cqiV
-----END PGP SIGNATURE-----

--K8+RJcx40rD7eBrt--
