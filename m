Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7833BC48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 23:44:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C16BB8800D;
	Tue,  5 Mar 2024 00:44:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZKYAdId6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 253D387FFA; Tue,  5 Mar 2024 00:44:37 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21DB587FE0
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 00:44:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-42ef1822b07so6966451cf.0
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 15:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709595872; x=1710200672; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bMnmbUrpzkvIgz77k8kgqJXr3t799Jq6nqp6f+WwtBk=;
 b=ZKYAdId6x+8I7nme1M6UZiiJITjpXqmmF9Cl55S51oetRJCbzESHNmd8uwR3pTWpJM
 aSWgs8GGcXc+AWZfVw55gu3IDJ7yJ/jV3Uu6OjB02SVHR/4IHJDwmaxUK1KFO7zViXaQ
 j9eDzX4dQhvzUwrQpSqQGvqMu09NRE237dRUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709595872; x=1710200672;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bMnmbUrpzkvIgz77k8kgqJXr3t799Jq6nqp6f+WwtBk=;
 b=hqGuAtWRe43gCdxLH/7Lwlm9c1S74W8N1iPuJc+fPM0eOUAcH5onKiCw8kJG564inf
 2ec12lxbB0AIcPRPEG4sC6AppeRxyDg9WE9JCGAJ3IbQgBEsGIEk+xfsk0nCeoS9/PAc
 JPds6QF1vj/B0u6ugJ4rFQ7Ub385vRFCjI4wfP5WAgM6dWw2nLrUe3lou3a4qqp9Vssj
 3/OTxSuEUOHqtyTXxySzafOmVlDjszuBknzHYOp4bbZu7UM2ArbQ015MwR03bu+gTuil
 dU+R70BA4uHmyudNm8NP2ASLfAiy0rP8irDiyhhApp8QBbuwRSomwN4d16mfk+kPQ3pj
 BBLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLeFAo/KrU1uLJhzwNWgpQ64fOtMR67jrWXqP/DtR/N5YzSyzfLWNPokE4VoywknsrnBvn8+lAu7hMon4WX52aC/Up7Q==
X-Gm-Message-State: AOJu0Yx50uAXRkeep+OJnreyOuishvIamPi/W31dQ0OztV3ZLz5Cs+sn
 3Wf1fh4PoXRgOrLNTrG8pq0nIU4/vU9jTkHL0YzqX0cEbRkTy8Nv5FlAjIZ19nw=
X-Google-Smtp-Source: AGHT+IF88f2CNMupW6Zuh6UxEbdQ51CpOjbg74gIoJ7s28ahgMuiysj0HWP3oiHTE7k9gAj/OY1yBQ==
X-Received: by 2002:ac8:5c08:0:b0:42e:a842:b90b with SMTP id
 i8-20020ac85c08000000b0042ea842b90bmr430254qti.44.1709595872297; 
 Mon, 04 Mar 2024 15:44:32 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 h13-20020ae9ec0d000000b0078775971344sm4866724qkg.38.2024.03.04.15.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 15:44:31 -0800 (PST)
Date: Mon, 4 Mar 2024 18:44:29 -0500
From: Tom Rini <trini@konsulko.com>
To: Udit Kumar <u-kumar1@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, danishanwar@ti.com, sjg@chromium.org,
 matthias.schiffer@ew.tq-group.com, r-gunasekaran@ti.com,
 u-boot@lists.denx.de, j-humphreys@ti.com, Jai Luthra <j-luthra@ti.com>
Subject: Re: [PATCH v2] dma: ti: k3-udma: Fix ring_idx to pair k3 nav rings
Message-ID: <20240304234429.GV1523872@bill-the-cat>
References: <20240221142343.3652840-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hizeNYrZ8h4rSNyL"
Content-Disposition: inline
In-Reply-To: <20240221142343.3652840-1-u-kumar1@ti.com>
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


--hizeNYrZ8h4rSNyL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 07:53:44PM +0530, Udit Kumar wrote:

> ring_idx was not correctly assigned in case of tflow_id is zero.
> Which leads to wrong pairing of DMA for drivers like OSPI.
>=20
> Fixes: 4312a1dfca26 ("dma: ti: k3-udma: Use ring_idx to pair k3 nav rings=
")
> Reviewed-by: Jai Luthra <j-luthra@ti.com>
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>

Applied to u-boot/next, thanks!

--=20
Tom

--hizeNYrZ8h4rSNyL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXmXN0ACgkQFHw5/5Y0
tyxsSQv/d0SKgKGW7QDekVYDkxGMMunZWxqvRZ5b/tpu4zMuHvxYvW5G9qnh2dXN
T1WusBtpf2VVqBt13nh51JIqOGDRfIURE5voQx17Cqgc/f0qgSEc5MmfiNguk+zN
1tXRaG9GZiZ1502NWE2o7Llk84fjR6yRjlARFjEWbqzqezh140APLgTjbm5ZiqLe
XtEI+60S9eoPV+TIDoJFLMZbkMczIB3FmnQ7PgVxnEE0KZs7jPArkYooqxUrzjCs
pLjD5Mq02WMLKAF+MkaL0VpoTJx+JIEWtmNh3uNpGlaMwXfZIO34+HLAKu2hCf6k
7lZQoeXrrWOAT4xZQDRsWTMhjVfKaUO8XMFluOekcyAzgzI2qcSjj0PAXM7bAsDQ
iHOaGI+WwHdz+mVE9DzIsmmSQ1aVwUhNm0SDRDjSaQz0OUkE+HvovKRu7utfJUw0
NYvk2GStriFX+XdmAQx5p4QpgPBjb4/2vWE63Sj0vSk3Dk/cI+ips+0ljyQKbfL3
O0+euPWm
=ZJvN
-----END PGP SIGNATURE-----

--hizeNYrZ8h4rSNyL--
