Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F14DC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 14:45:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB57788368;
	Thu,  2 May 2024 16:45:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jd+ioaFz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC5798833B; Thu,  2 May 2024 16:45:53 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B535A88368
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 16:45:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-790c36dcee9so421041785a.2
 for <u-boot@lists.denx.de>; Thu, 02 May 2024 07:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714661150; x=1715265950; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7732bxBz5lvRWuTujUsd/nLDYTM9orrliZtLJggkX6c=;
 b=jd+ioaFzRwvYTxkxANriO1XjoPPPoAIga70uyuKhL9R5JJVDEeLvWdDen7mZv2N3Pq
 zyKBwg0/h/V4S3KcD+P7PhH5LRdOPt7MSqsc4C9ItHd9ZbkQH7NRXGtwAKQEriwo4eGw
 KxmIg88Fn6RiQ/xy4jAB//xYlxaq8C/Pa1Jjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714661150; x=1715265950;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7732bxBz5lvRWuTujUsd/nLDYTM9orrliZtLJggkX6c=;
 b=NysNCBMulI46cGVOC3hK+oS0fnbU49Wlw7TE2C9G6rrF+uPXdYuDsjxGWI7CBrVWGB
 z+MbtpOT5soFTay1aOPHl5+QiigXvhFy5eeFsM5/zQQwnWKx2Mcw5ywb5tGVdC5rUrlJ
 DRZo8GIqpDOk3Tika8VneVEUDg5PhQnwMQlotpA3deVVXANfX/WrGor1K4TVMxAvNLTX
 l5qWHqgEPkQsEvITp5mPKA1pqFr9PdPMH9ImZ9E4yexmAdiiO45rU6fdVoFHgT5fyYMm
 50PTst8uv2mxTm290TTGXU+/ULa8JasSo7uciuEpNC81pQAAgNv5wWfSD+nZrFKMDX4u
 TpMA==
X-Gm-Message-State: AOJu0Yw7fIG/8dlcfV1ubHJhhkstj/WXnN4R3FEZaHkmjarSeKQuRz1C
 utObRTUCZLxjQYIXnMiWRjbm7alVeknl2cno+iTgf9WapcaaGLpQA1akTEBef7A=
X-Google-Smtp-Source: AGHT+IEEJE1HZe2Dp4Wdv4BrQVKHWk0EyNSHtXFe5vv9HkqpUs39NLppNE9lgAKnH53KkEiHM8xs5Q==
X-Received: by 2002:a05:620a:3622:b0:790:8ddf:9cf with SMTP id
 da34-20020a05620a362200b007908ddf09cfmr6063627qkb.77.1714661150398; 
 Thu, 02 May 2024 07:45:50 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 pa20-20020a05620a831400b0078f13e59dc9sm411177qkn.102.2024.05.02.07.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 07:45:49 -0700 (PDT)
Date: Thu, 2 May 2024 08:45:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH 25/81] dfu: Remove <common.h> and add needed includes
Message-ID: <20240502144546.GV1054907@bill-the-cat>
References: <20240502013138.2383421-1-trini@konsulko.com>
 <20240502013138.2383421-25-trini@konsulko.com>
 <87ttjg4qrg.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EJS0ed8/4AZ9BGyq"
Content-Disposition: inline
In-Reply-To: <87ttjg4qrg.fsf@baylibre.com>
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


--EJS0ed8/4AZ9BGyq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2024 at 09:28:03AM +0200, Mattijs Korpershoek wrote:
> Hi Tom,
>=20
> Thank you for the patch.
>=20
> On mer., mai 01, 2024 at 19:30, Tom Rini <trini@konsulko.com> wrote:
>=20
> > Remove <common.h> from this driver directory and when needed
> > add missing include files directly.
> >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
>=20
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>=20
> Since this is quite a big series, I'm assuming you will pick it up
> yourself.
>=20
> If it's expected of me to pick this up through u-boot-dfu, let me know.

Yes, I plan to grab all 4 of the series once I open the next branch.

--=20
Tom

--EJS0ed8/4AZ9BGyq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYzpxoACgkQFHw5/5Y0
tyyq9Qv8DyITejvZFKfQm0xzH6IrDBgIEVZpWQI0zINnNQCHBtG7WZGgWrFag6Bp
re0uv9nHf0yBZgwSBjGcxqvcmMM2yto8xnn87gyr/BWzIP/qDH7irMShepU3QoFy
7Dnkilb6XziOKsqG8BcDZ3Gzz0EIOcTq7JMwDyhgU1Kunc5kktJkQR2XUwgIDI4r
2BonMv8aHcki+v/mR015Ew/qvf91u1TPzrrUlkfqwsiPvs1cGd1UMIaoUUUD0Rkv
S2LU3b0LiyRuP6pLg4lKV8s+EMAoEzXkFlf44IqSqH9o5HM1Rfd6dQ4DrtRBDuoA
g5CV11TSBDSagId68T9FJVQvcS4lQEvi1OpSsI2QDEMZNVuDXN8z3nRIm22hucLA
jjbOu2sTDkZOwCEfdmCfa+AuvgvLPinSlQeEO67/9Bt7SbGJw+kHRWIDfSILQyz7
j73LmL/UbsPKdU7cGU4SnRO2cHVqTqcHbG7ILBTAXGR3CuVm/1cZdJCTj3rpJ5hM
+zdLZ1am
=hOan
-----END PGP SIGNATURE-----

--EJS0ed8/4AZ9BGyq--
