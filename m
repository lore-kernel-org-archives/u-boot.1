Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C688C2BD09
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 17:09:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C7FE88639;
	Tue,  9 Jul 2024 19:09:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="T9qQ+xUL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BABE988633; Tue,  9 Jul 2024 19:09:40 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C6FB883AC
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 19:09:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-25dfb580d1fso2616559fac.2
 for <u-boot@lists.denx.de>; Tue, 09 Jul 2024 10:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720544977; x=1721149777; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=09HCHM6gbF3kJC4gZWM6ZLd6t91y5+JvMu9MCOSmnAw=;
 b=T9qQ+xULgoJsJ/FQ9HRGwLiAT1jSBoecf5HuoSOBycp4MqTxGj2EMCjER7eAuSHlXd
 1WHq9uHv/ksXxa8xdPlVXSXZol3nVSU2OIWOFiwTUXhziqJnFINfUbQp86ngd7afyp4M
 ig5fI3zxO3SjCBLhEACYUQ//fH84yzkMTFg1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720544977; x=1721149777;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=09HCHM6gbF3kJC4gZWM6ZLd6t91y5+JvMu9MCOSmnAw=;
 b=REh8+rTnZUvF/wscjMF+Hap7jfJW7pgGCN3vT8w5ZBG+X6lfpA3zVgy1OyVZpvu/we
 s2aM3h9FgQGGl65q2M5jC06Sp/X+BCtxX8mmgWWQL9WesKBeu9OrNPdowaqRajXGei1L
 PEkbM4FAAYhSeX64WsWT8KS+w3ZGsot+rXDi23b0D5ZatRMDe+TQPpDQlJ9Onxk5OYJt
 mXrLp/acJ/DjhvLKv48PkEJpoBSGlD2fw4UNHqgyn1nqu83PkoBVLoywynCjqBGHYHIe
 JJH60QCxT00z69Kr11lYHwNKzIiD6XfTzV3HKMmmFCk+3fCPOgOZZgSLztnB8TxP2tMQ
 CRnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULsrTzyvUani4Dmaq2DZjd1ULbOVVv6ZrJ4KUedLcGT1PgxGXnGyRgVL707H+PwTEGqfMa8EnxIBSb9TtxF0yttWkuSg==
X-Gm-Message-State: AOJu0YyUnyT6VtwucbmhtahcDxKNuTPLLUT+NhVk8dEEm7HdxbZBmlLb
 nj04PnOdzyviKq2ML7tfyVLPpzjsCT689EEVp7X6bWqZxz7Xl9cqeyiMiMXxiZ4=
X-Google-Smtp-Source: AGHT+IEA8CmEg49a2rLPdi2g8kuOJdQy5dpD/cNVxhM41sY2ST0EDVnhikn90jVldsRdYgN/nGbP2w==
X-Received: by 2002:a05:6870:a2c8:b0:25e:1644:9323 with SMTP id
 586e51a60fabf-25eae7f5de7mr2468673fac.19.1720544977278; 
 Tue, 09 Jul 2024 10:09:37 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70374f6b4d5sm527787a34.1.2024.07.09.10.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 10:09:36 -0700 (PDT)
Date: Tue, 9 Jul 2024 11:09:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: Re: [PATCH v4 01/21] linux/bitmap.h: add bitmap_empty helper
Message-ID: <20240709170934.GO38804@bill-the-cat>
References: <20240709-b4-qcom-rpmh-v4-0-c06d0a26644a@linaro.org>
 <20240709-b4-qcom-rpmh-v4-1-c06d0a26644a@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6i9kvTRxLZRkchsk"
Content-Disposition: inline
In-Reply-To: <20240709-b4-qcom-rpmh-v4-1-c06d0a26644a@linaro.org>
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


--6i9kvTRxLZRkchsk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 09, 2024 at 11:34:29AM +0200, Caleb Connolly wrote:

> Import this function from Linux as of 6.10-rc6
>=20
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--6i9kvTRxLZRkchsk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaNbscACgkQFHw5/5Y0
tyzeGwv+JuBBSoc2V/zi10Hf4goZ2eoucOGHwoC7Y953/3KCcRCFDT9TH5xT7epB
E2VJGpAFr1BC47E8dKctAJedw2wKaP/lY9cYKnwQqzmHi0GzTDSY41atCvOO608F
lBoU2EoY1ZpLNXGoNBR+rpKp5i9xU7JWHoiMpYiM1mKYc43wroqwfP6K631YbctY
7Pj4I+0xMkUwVO0F7XK/8EsXphX0fatTYwNsE8cFOVF5OUQPB0yto9wNcyWyJfgu
SzXAn5baDGCQZFaoUqEasb0UscMDKec/dV7nAvdpMf0iMqNKb4BKvrHudcKW5MjU
0f455Cip6hClI6RECxIHYiTQ4DZZ82WcW66swNoRwLGSutJ2frkW0I6HAtv+46Yj
3wLPLjj+hTBImuQVtgc1dM2Fq0NQWow4Sr3NBHa6hmvpqAhn/j0YZhAF2ATvSaNu
NONj78V2AhieKgg4JkLnBXI7qM8fOyUSmaHoVTBGCiG2RrsmSFo95HJ8xcsoznUe
HMRqh4Ir
=jjui
-----END PGP SIGNATURE-----

--6i9kvTRxLZRkchsk--
