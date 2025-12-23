Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2693E6FE24
	for <u-boot@archiver.kernel.org>; Tue, 23 Dec 2025 18:08:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0769784171;
	Tue, 23 Dec 2025 19:08:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qi3d4tq2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8060684172; Tue, 23 Dec 2025 19:08:02 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 614F584167
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 19:08:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-3f0ec55ce57so3571519fac.2
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 10:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766513279; x=1767118079; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eClGfDyYaRNblj8MVUi0OBaGmKsOlseSs+m1TLtsqN4=;
 b=qi3d4tq2NFT11n4Oc5hKaKtQd4X9ExirxGd3BTKS1xFCrF432UUnI9yaJ3XVqL1yew
 RAwvLtv/X9Xj7OZsBJHTkKQYi0Ya/NVm70ki56PVgnsJQagQwZukAjMHH9AsnXKALrMr
 p0TQFA8iUPh6vt4NC+POM1PkP6QFFrE9Zt0o8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766513279; x=1767118079;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eClGfDyYaRNblj8MVUi0OBaGmKsOlseSs+m1TLtsqN4=;
 b=ppZBO8dYaU6vVvqg64rMpqpsPF2N+xJf1j90Pm1+g+B6qRKQA8eHm9RCF/4bPpxYng
 S34KiB0B+IsGJH516CMxfD6/TmRc+ynODzdhZiIwA5h23uf0x1IoydgAHAAcp2Tkt/Dc
 9Dq0SvpQDfClL8zEPoUhG5tZFAtrXjyKckfTXmi554Je2ZRug1Qz9B5sDY6KXojGNFnK
 ODUwJhMJ2hfOllfr30YumGJ13SZXfEYcmqyEdfZo79tYzdSWoN90VUZHWncKSrnAyVwf
 eysCLQyK3PBJ4jOBg3tnStxc/6SK7/rH7+K62XvDSZQjDsrtSdsH4G/rbpmYdfYFteOS
 FbVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAf++H97S8eQR3r5kPyTvNYRRXdQXSGorx21Yp5UfO7rniMqCRyMDh8PzO9IeUQgvj5uUNUyE=@lists.denx.de
X-Gm-Message-State: AOJu0Yw9/+nvIc4mAof/2a+M12cg7mcoJGBA41gvR5WlwnGUCqm3EHl1
 I4+BKUCy6EA8jSq47UU5aQvI6E8tUEyQEaHc46cg5u3XG42oVws1Td7Ao7u9oPM61XY=
X-Gm-Gg: AY/fxX42nBNITxlI6vtobPS5U3X+nJtN6UwzgWjWF8Eqny8+0VhL3/l32nSk+5PBvKi
 t5q0cyvo1PyuKijnQZ/RkN+dAMFP3YSRv0SwA4xrw/b/u7dV9jiQ1d//UNR6MMysAZChcwubCeO
 QoHz0/HO0UWM9BRonHwHCUUHdROAlSqjvK+CWWVCAbup4YjE3/PsMD+INHMUOG/vv4bwhU6dcex
 1eRRn1tJ5DjBNNAPxlWq9rLoHPy1NeSYjx60p8vWxmnNiSOGh9vHyWfyV50x7fKhCjzmdFvhf+G
 jvxqtFCvS/H/iGbp8T/PS0oFhzxzHa+6ZjjNlZ9PaT3tW/8/CQhCWNbJw2BzU152z8O1wcwUBZ4
 8nQcuGcvDHB+T++JglZdz3WhWT3pMjTGsg/suT5GCP7JXyz7zKtU5pGgvJ9yJ1puvWByXLpsjQL
 30s/21N8BzKtkfaP39rRYzoMX5BqPquQ/w0uqFMPqlP6tHOeZjG2uCg1uNPMf4
X-Google-Smtp-Source: AGHT+IFP22BFgdzUQxM7I1jd0PE/DoEBZ4f+MlxHeGwKpMassaVu+RJexbh8AQZ+XxLv4i4F7AgsnQ==
X-Received: by 2002:a05:6870:8452:b0:3f9:ff05:438 with SMTP id
 586e51a60fabf-3fda56c99ccmr6438894fac.24.1766513278989; 
 Tue, 23 Dec 2025 10:07:58 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaab5ccb9sm8971049fac.10.2025.12.23.10.07.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 10:07:58 -0800 (PST)
Date: Tue, 23 Dec 2025 12:07:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 3/3] configs: sandbox: Enable environment in SPI NOR
 support
Message-ID: <20251223180756.GF847766@bill-the-cat>
References: <20251223143130.16266-1-marek.vasut+renesas@mailbox.org>
 <20251223143130.16266-3-marek.vasut+renesas@mailbox.org>
 <d7313d07-7b4e-4f89-b2fd-a6edcde31528@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="f8sTKt/f0Vo08Oox"
Content-Disposition: inline
In-Reply-To: <d7313d07-7b4e-4f89-b2fd-a6edcde31528@gmx.de>
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


--f8sTKt/f0Vo08Oox
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 06:58:13PM +0100, Heinrich Schuchardt wrote:
> On 12/23/25 15:31, Marek Vasut wrote:
> > Make environment support in SPI NOR available in sandbox,
> > so the environment storage in SPI NOR can be tested in CI.
> > Enable redundant environment support as well to cover this
> > in CI tests too.
>=20
> Applying: configs: sandbox: Enable environment in SPI NOR support
> error: patch failed: configs/sandbox64_defconfig:106
> error: configs/sandbox64_defconfig: patch does not apply
> error: patch failed: configs/sandbox_defconfig:154
> error: configs/sandbox_defconfig: patch does not apply
> Patch failed at 0001 configs: sandbox: Enable environment in SPI NOR supp=
ort

This depends on the FAT fix that Marek posted around v1 timeframe.

--=20
Tom

--f8sTKt/f0Vo08Oox
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaUrafAAKCRAr4qD1Cr/k
Cj/OAP9pKwpiLybns1EXc/LT4LuyYO/Dx298bdierMZL3UNDnwEAheIGrX7mwk/h
kIeiuWe5CMm85Y8VfsQ4BiiM4WCaIQc=
=yyYg
-----END PGP SIGNATURE-----

--f8sTKt/f0Vo08Oox--
