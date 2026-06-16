Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 711EDCD98E4
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 14:36:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E33A6848A2;
	Tue, 16 Jun 2026 16:36:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FmppRH3u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63F02848A6; Tue, 16 Jun 2026 16:36:55 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 478F88484C
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 16:36:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-43f1f2b82c6so2828090fac.3
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 07:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781620612; x=1782225412; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=V7DrHMYOoqvtrW/q7ocCOyPWOSj1KTNtkGIfNAGc5tU=;
 b=FmppRH3uDzK7oZ4B/pIo4VcHE1trNIR/hICN+E+zTHdbwE3rhlfGKf5oXhXqtM0S7X
 3hG2tc1YKi4jzUvdKpaCI9UPcsDhjwD4G71Kh1lYeEhhW4TQ0mCATV8wsVMAUBDjoyTg
 OcKKAndgr07cMunLy3xD32rCCbochpE72JjDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781620612; x=1782225412;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V7DrHMYOoqvtrW/q7ocCOyPWOSj1KTNtkGIfNAGc5tU=;
 b=Nt6I0GyWccFH6PsOifqp9v9Mh/B1zhR598nJqYuMlNbojQmPGyOoA5JhSB8QFN+WJQ
 oXh7DlIFfIhkbjaHb0Oa+feW1f7xBOycjybO9bk38L0fH29H8hwi5dbY+3SrX2SmUPO1
 l3unWuPSJqf+P54ljfUbSyv5e1MX2bVs7qklZSrz/MtbPVze//fFIt0d1CWR5zFvtI/N
 ooEpukJQhDxffzqTrcWmawr7MgeFJbZLvKlmyaohVcAG4hnsHH/tIJybgAdrwklX1GtS
 lLmuDB8AqNVJeL6EU2TGGXfixsx1oblIgd+GpxL3gyxgne6BxHF/6HF9z6UTTADL8fKA
 K11g==
X-Gm-Message-State: AOJu0YzkqluU1HShjKmPj7g1J1W9EgXAVylfFl+Y4NSf64/L1D4ehW3t
 ykZgB+XJrDOULMJCTKfPCsFq34aukSIzuI8qxh1tI61AAuqwBL3I5RRpZr158RDOOZfWevhqv2t
 u3xPsTXI=
X-Gm-Gg: Acq92OFmGacXArYFkrmvUOrzR+xXsUePVyCKGx04cr02NCslizR4Gtq/BjdlbaB3JZa
 3aCW46M+hPLaqhCOrXSXt3/t1yYYNDgPcmzlCPqtQd6jNqQu29r3wu2lU90WtuskdI+TVq9QVDu
 g9I2kJJsSJQA0lWmUPNBGR6sq0M3F9QOP17M3Nc2wdUlqKhy0JDmKVmbgG/1YcGBz0942ZxNMPI
 Sw5RxG4GP0HCP6ZFdh0DEriUfqeHaTzbSlk6jFojARwnwXRAivMZlYSF04demTMFChaCk80Y6ka
 Az5k4TLePyHNWPZ9qTsSsPqsc+QtDxdSqoUs1GHKpoHqQWs88fp/JN/bm29Kr1m3MXSoGjZz1UW
 wO2nTSL9VfG+M46qluzAx1RInyqnHvDZykJBGPNBIj3P2b4T/je5LY+60I1HaYM6CXCVkJ1TOtT
 DfBLPSDmjxitmuO1gqKEjmVV05mqUa2GPCxO1D6V/DA34/hk/xc/Ix2aj5QubnBkqszfnbrEohJ
 6Zu60ifsGRanjxv6KB690NBvYBDmF0ZQcbc147AEAvBgnZh52Wg4KyDaVauLg==
X-Received: by 2002:a05:6870:6122:b0:430:b01:1f79 with SMTP id
 586e51a60fabf-4430b2f75c9mr2876871fac.2.1781620611919; 
 Tue, 16 Jun 2026 07:36:51 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-245.totalplay.net.
 [187.190.197.245]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44308fa61f2sm2047410fac.13.2026.06.16.07.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 07:36:51 -0700 (PDT)
Date: Tue, 16 Jun 2026 08:36:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] get_maintainer: ignore Tingting Meng
Message-ID: <20260616143649.GH382693@bill-the-cat>
References: <20260616131133.2143136-1-casey.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="A2X32dL4gttRWOzj"
Content-Disposition: inline
In-Reply-To: <20260616131133.2143136-1-casey.connolly@linaro.org>
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


--A2X32dL4gttRWOzj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 03:11:26PM +0200, Casey Connolly wrote:

> Their email is no longer valid and bounces, ensure we don't include it
> in get_maintainer.pl output.
>=20
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  .get_maintainer.ignore | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/.get_maintainer.ignore b/.get_maintainer.ignore
> index 899a1469b2ae..5b7d84646f62 100644
> --- a/.get_maintainer.ignore
> +++ b/.get_maintainer.ignore
> @@ -1 +1,2 @@
>  "Pali Roh=E1r" <pali@kernel.org>
> +Tingting Meng <tingting.meng@altera.com>

The .get_maintainer.ignore file is a heavy-handed measure for things
more serious than just bouncing email. It looks like Tingting Meng just
comes up via git history and so will roll out of emails in a few months
now, so I don't want to go this path.

--=20
Tom

--A2X32dL4gttRWOzj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCajFffQAKCRAr4qD1Cr/k
CoFRAQDe1REXhfBptFcb1+/Np5VHsKlwf9UPw/bc1Es6lWv8tAD+OHrS9mQ9QQJA
+54J2euyboHmQ4ylIKkUGVsRwLgxxQA=
=j91l
-----END PGP SIGNATURE-----

--A2X32dL4gttRWOzj--
