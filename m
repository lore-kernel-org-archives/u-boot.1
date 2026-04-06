Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441F5F46C44
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 14:35:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B45BE83936;
	Mon,  6 Apr 2026 16:35:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VyzWDYS2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0041E83EC6; Mon,  6 Apr 2026 16:35:34 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D61468352B
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 16:35:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-408778a8ec4so2431781fac.0
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 07:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775486131; x=1776090931; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=M0Z5QalHwdVgR+8lZZkQcQ6qeqN3TvBbShLBXvYBBfo=;
 b=VyzWDYS2zLNyHg4lKA0QkGL4WvF2eHCWrV2vLiM6IxodBYTLCnMSjiJhStJq5xOuzV
 adb4Muz8XApozqt8UPYDhmBTNl0v7ekpyBrqjY0tLG5G+jsHFf7UatBmAvnAzKmQOB++
 vXV1NVRg88ZSGfBRGhwP55B3t/PBgtJ2XycWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775486131; x=1776090931;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M0Z5QalHwdVgR+8lZZkQcQ6qeqN3TvBbShLBXvYBBfo=;
 b=B1DmSBHNPdfNHVT3BHjc37TH/j3q/nKHolx8aBWmGv0kAH3QD5WEL/4IVy3KFAh/hf
 B7aWl6t+5WLsI61b0z38wKCIiCuOK486XqYLGwmC6ZodmwBqnAmhuIpNjZ7XfsXMvnAV
 7L4TauJT8WOj41RNMDvRNPgRhLdiSBiL8quoSe1vMwmsjeCD3MEDojV1uSSbPQ+E/LqD
 +AwVhRYQVWJN2uswY7V9BlD2sGmZ0DUGEw3+e7kTxDa15EvaS5ssvo2h95nAj+3NHiHG
 sumY6nTUGu58pbZwagExyzzFuETnO63Ifw9ii9ffJqS2OkxFDPPi3wxJTHFcKdKAes2R
 6Qhw==
X-Gm-Message-State: AOJu0Yy+7LMOd8ETOUJYkoiR6ti1eyTPHnXFy7jD2tey/jqsSpmylhah
 lKvkIyyFg40C3/gcVKhLdmsaqpxssdS9MrVBUBzyJ8bLRqHUwZhhlOYP3TDHpRkt24g=
X-Gm-Gg: AeBDieshmcV63XG4FGUL+gWn7ifswSaFd7Za87qzr3avmA25LVc+Krwf+BdfGlCgcno
 Lqy0XEUnJACD/s7uoLUyxRJU4doEuFHYBzxTYqSLV7EKE+Yv0Ur9hO6Jzs7i1scKB7r6hGe2L6U
 +OmWhTXJ1czp6Oy2Bf4OHbc68mW1tK4lLR14OQuJuT7OSBfPLJrmfeeQqK+zKM9Li2qGOgit815
 NmmGy8TJ/Nq4vgD3W2d1zUT313vHZNLGjCPRlWUGStiZ8Zw5HKaLYXkf85OnVe4DeYbvHFzenBq
 Bz0uePDZraawNIeWliDVxz3minIlUxeYDCZzBft3zAVjAhsQYle4l6MV1w55239o5+W0/XgoRDu
 CN6yPZPikpowTxWv5hNLiG4S/1upPb1d8oQz03Bbv2VX+M2WXhpvO1m9jnVAUy6kmcZcXfibXnb
 6Nw5PAWVTW3flyQeRGVjV9YEXCyYFsjs7GvbuwR7NkoYsvc5VDY3htNFvyRd3m0rEGLpooiN92V
 h+yx8v0ASIVpgm+/3DYJ4iNGio6ZaYyDuVciBdv9DQrHA/c
X-Received: by 2002:a05:6870:d330:b0:417:2d6d:b7b0 with SMTP id
 586e51a60fabf-4230f6b3127mr6931096fac.0.1775486131553; 
 Mon, 06 Apr 2026 07:35:31 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-422eaf2c7c3sm11420219fac.5.2026.04.06.07.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 07:35:30 -0700 (PDT)
Date: Mon, 6 Apr 2026 08:35:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2 6/8] test: Convert FIT test to use a class
Message-ID: <20260406143529.GO41863@bill-the-cat>
References: <20260405111206.945185-1-sjg@chromium.org>
 <20260405111206.945185-7-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="y9IqBPCS9mdsdCzP"
Content-Disposition: inline
In-Reply-To: <20260405111206.945185-7-sjg@chromium.org>
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


--y9IqBPCS9mdsdCzP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 05, 2026 at 05:11:51AM -0600, Simon Glass wrote:
> Move this test over to use a class instead of a function, so we can
> easily split it into some related tests.
>=20
> Move the TODO so it is part of the comment for the class.
>=20
> Tidy up some function comments while we are here.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> Changes in v2:
> - Remove doctest examples from find_matching() to fix Sphinx warnings

You shouldn't need to drop anything. It does likely require a different
quoting. If you look at the changes between a865d1d25410 and
02e5d344a0d7 you should find an example that helps. My first guess is
that the backtrace needs a ".. code-block::" around it with possibly
some indentation changes.

--=20
Tom

--y9IqBPCS9mdsdCzP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCadPEsAAKCRAr4qD1Cr/k
CoZQAP9aFpMmhYKkqkS7EXIRBMz6TIBe4Wv8ZtkE8+TMiSuLywEA4+vEXRTj4mZo
98KcLbv+y+HJZn0b04hi9xmjQIit5gM=
=vwj8
-----END PGP SIGNATURE-----

--y9IqBPCS9mdsdCzP--
