Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47DC5D0EE3F
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 01:27:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A61BA88B63;
	Sat, 12 Oct 2024 03:27:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MCaWd2xy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0991B88B9F; Sat, 12 Oct 2024 03:27:24 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E316D88B0B
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 03:27:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6cbe700dcc3so18386496d6.3
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 18:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728696441; x=1729301241; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Anwf18baOz0v2omvlJyQmehmbXpedcaIKMjcgPluLXk=;
 b=MCaWd2xyy8vQG9SsFIFJj8qA2VCSZt6TN85pwIpzZU7Yg1jDFR3EAUhe3ukewktiP4
 THTtM6SQMjLiQQVl1Dmsri13Tlue5kBUF1le9WuY5pkib5aIwqIX3VDIhal3INgLxW7t
 vmkBc6qbu6EgjnZ2/7J83zjD5x80nyPTMtfag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728696441; x=1729301241;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Anwf18baOz0v2omvlJyQmehmbXpedcaIKMjcgPluLXk=;
 b=POfHvzGIZHAtl2uOhuHE+zwrHDR33MkmQxAV6N90LHtI0+cu8ohHZmSMX5W7j6JaOM
 ltoDrGtLdzgglMCClXvizkM0LHSR6bj9Rp3dSYq4UP3ixD4mOiQTTHLMVZKailcLMB03
 NGskrjBAno6kMAeqUx+MJ9ZjFAkIMX2ul0GaspY3L//2EYdaX325m6PUic3Q/u/z3Fup
 XThQyU3QLwluoJiou4l0BWCdbCUQW7lYJZl4sv1L6BxLpfrOaOY7grzFpkG5pEsFNW3c
 vLmw4kTeI2TfSLl+HxbVr96/Ti0jlSjMRbE3waJcJhMRWwytQ87g6JdBM8ne2Or7sy2u
 PNVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUg0dkcnbLx/27hNGzwNFjX/BZQsAf9KSqrZ/GiV2cgn31iPLF9uGHgmBAW3yDjRq0OlQ4AR+Q=@lists.denx.de
X-Gm-Message-State: AOJu0YwetAyj3Zg5P3BwegqSHPt41Rlg3LhBCmTgwkuRwW3j6/dPVdfN
 QYH7tz94s/ZvbjswSOWJ4ujQRBondw/J2uPFHPRSD9wQz7GLHAvNmDf/iS6bqNf/L0O0Faiad4c
 hd+q7tg==
X-Google-Smtp-Source: AGHT+IGnz13kVmkLaDl5qdVSxbcVdHwOnye807TnYRBWs0B1aqts1TDKkrCWDH8hm/rxyQvBYTkadQ==
X-Received: by 2002:a05:6214:2d43:b0:6cb:ed23:30d4 with SMTP id
 6a1803df08f44-6cbeff621f1mr66656476d6.22.1728696440810; 
 Fri, 11 Oct 2024 18:27:20 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe8608d73sm21208216d6.89.2024.10.11.18.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 18:27:19 -0700 (PDT)
Date: Fri, 11 Oct 2024 19:27:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: Re: [PATCH v4 4/5] efi: Reserve some memory for initial use
Message-ID: <20241012012716.GE14210@bill-the-cat>
References: <20241011212126.747741-1-sjg@chromium.org>
 <20241011212126.747741-5-sjg@chromium.org>
 <71ECC011-77EC-4308-AFE5-0E301BC27F84@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8tpffAjU0TPobFJ5"
Content-Disposition: inline
In-Reply-To: <71ECC011-77EC-4308-AFE5-0E301BC27F84@gmx.de>
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


--8tpffAjU0TPobFJ5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024 at 12:01:54AM +0200, Heinrich Schuchardt wrote:
>=20
>=20
> Am 11. Oktober 2024 23:21:25 MESZ schrieb Simon Glass <sjg@chromium.org>:
> >The 'point of cooperation' is where U-Boot starts allowing EFI to use
> >memory outside of the U-Boot region. Until that point, it is desirable
> >to keep more below U-Boot free for loading images.
> >
> >Reserve a small region for this purpose.
>=20
> Your commit message provides no clue why this should be needed.

The alternative here would be a patch to doc/develop/memory.rst saying
something to the effect of:

EFI pool allocations start at ... U-Boot stack pointer +
CONFIG_STACK_SIZE and grow downwards from there. These are done by ... a
brief description of how the pool allocations work ... Nominally, this
will extend for only a few pages worth of memory but depending on
requests made by EFI applications can grow larger. All of this is
covered by the LMB that covers U-Boot itself and is considered part of
the U-Boot memory map. It may be broken down in to further detail to the
memory map provided to the OS, in some cases.

--=20
Tom

--8tpffAjU0TPobFJ5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcJ0HQACgkQFHw5/5Y0
tyxaXwv/QbqDkEUJH27aCXLlbuezewlVI31s4ez36ow2+YL3bVoj9VR8UR0mc2rC
YPm4IJKbuFcqtDUwNv2//dWf1J/PZ05HnhfsuhLQKP1+q1NTao/kn2YyIEftnpmA
eIwIvl6F+l4ehZsIUzReJRCtpHpXVv1qp+QXgXHdZUIQ+KS9JIeviqcem7yBCMb5
r30VNvDrZzy5EQ3sfQXW8BLy4HbdQ33cBx4vhjWvu3HJLLeDpWz7XV3VUb70sUAM
ZCAbwsb3BwuMSSIxq9npaAkqxSwcVLQKSW4u7iRX4b5Dx0d+LLPZxh9nTtGI7mz2
iwhDzrsVl4bOZjeT4lpTpfDnnr6rXq+jOvrumLL97bgKnbrBTV8xxhaweM9A6Vr5
zTwkTEElbl1/qOa+MIyPIhHP7f5KC+wufQ2Q8Ei2AtBE66PaB29q9cbp+02mV9ot
53zeDIMKNP5XAPA4rTH2YWuyYAjHgDAm8pCcYQg1vRCD6iRH4fhu4nwylo5Ku6q6
pMXXDjbh
=/2o9
-----END PGP SIGNATURE-----

--8tpffAjU0TPobFJ5--
