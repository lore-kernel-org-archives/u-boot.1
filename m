Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB022CDB480
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 19:15:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D90D386E52;
	Wed, 11 Oct 2023 20:49:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lM2+Cxwb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A265386DC4; Wed, 11 Oct 2023 20:39:20 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E461286E08
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:38:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-d81adf0d57fso137551276.1
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 11:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697049498; x=1697654298; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=r+dKpX4lOco0QlHtDGp7+4CEyYNAiWY0pfEtFqFdb3Q=;
 b=lM2+CxwbVWVAdaZ+xHTOTCPixFwxPK7z13dmlj00KJ/AJDNf2E2tW0zvB0WoiOgcH5
 1Rqptqyq4qYyYVQXoXhOJUpHgv2jj1SmSXITKQLr3pRfPqyxPSiFm/CGia9BmTHonCCD
 5q8Yyqy6v+PRRs2Vr0Zsk59ZelNYCK+kpfm5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697049498; x=1697654298;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r+dKpX4lOco0QlHtDGp7+4CEyYNAiWY0pfEtFqFdb3Q=;
 b=OYOPFBYaFyqrsOE7EI6uRjT9cABhLgkJ+ic/I/AAM24IrrCszMqaF/WoW0mK/yYWHy
 DXdHMsZf2yTXp2hoMsnJNqh2uXSg953SqHlXS2vg6gEdIkz+uyPfEdXyazy0RrQnsCMQ
 lHIAM+WifFq2dU8yUKp7AULhXeNJtsJH9wIb9Diczp6qJNJCTarbGCd/Z3tyfgHn3wE0
 v8RYO1u2RsChDS/ymGKLEfl7l52xoyXKjJfyxnvYP7b27iBN8gClYRUA3oOZtVt4Q9SB
 eXo1nQ+7xfxcNsAhuhhssnoNvnKvAD4wefZ9bfoG+JpTYrfQtGqVAmPKXavs3CqHF9Ul
 9/JQ==
X-Gm-Message-State: AOJu0YxwHQSCQOVKQz4c6WhtP4k3MIMMymRaaCY7pue9zKnALNzbsHBE
 1YXiYH8H88qfOG/oZIghiWx5Ug==
X-Google-Smtp-Source: AGHT+IFo6W2QgQ2IAwis4BYNYkpuEwf4zXv2+cAJtj8x+MaXqgXou1fVv9+CrTEFZvqaHkl2sK4KvA==
X-Received: by 2002:a5b:e8b:0:b0:d85:ae5c:527a with SMTP id
 z11-20020a5b0e8b000000b00d85ae5c527amr20986079ybr.10.1697049498405; 
 Wed, 11 Oct 2023 11:38:18 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2621-cda6-b3e1-0b3d.res6.spectrum.com.
 [2603:6081:7b00:6400:2621:cda6:b3e1:b3d])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a5b0b0e000000b00d81425266c1sm4547097ybp.42.2023.10.11.11.38.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 11:38:17 -0700 (PDT)
Date: Wed, 11 Oct 2023 14:38:15 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 1/1] input: avoid NULL dereference
Message-ID: <20231011183815.GE3119521@bill-the-cat>
References: <20231003010901.98121-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="h7cF1XBKeemYMUcI"
Content-Disposition: inline
In-Reply-To: <20231003010901.98121-1-heinrich.schuchardt@canonical.com>
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


--h7cF1XBKeemYMUcI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 03, 2023 at 03:09:01AM +0200, Heinrich Schuchardt wrote:

> Before using the result of env_get("stdin") we must check if it is NULL.
>=20
> Avoid #if. This resolves the -Wunused-but-set-variable issue and we don't
> need a dummy assignment in the else branch. Anyway this warning is
> disabled in the Makefile.
>=20
> For sake of readability use an early return after the configuration check.
>=20
> Checking CONFIG_SPL_BUILD is incorrect as env_get() is only defined if
> CONFIG_$(SPL_TPL)ENV_SUPPORT=3Dy.
>=20
> Fixes: 985ca3945fa3 ("spl: input: Allow input in SPL and TPL")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/master, thanks!

--=20
Tom

--h7cF1XBKeemYMUcI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUm65cACgkQFHw5/5Y0
tywcewv/YV1PvH+c82lUoE/9JH8OpICe92no6KGP8woMW5mpBVuqEjgfvL7sr9Pp
gkBjCEiboz0n+sszwEudfKRPsNgaueZA5+2//TIYCfH01QsWSyZCT2F63NC2oe7s
GOrtMGwCX4wByFiZfpGJa1Rv6XcUOtSlpbEPK9j8zf5QyWolac5J3tw9GmwX+5po
YFFOdFgLGd6In/i5Ds+hIagi1NWghGqf4T+LMpkHsVQcMF78yU7vS1oloNiNdNCs
UC+8aDgTC0lqmVTJ0ZJZvsY5bVw1v/LgGbwa+z841QV5H1/J/w69mDt2yIHGPge0
FIB1Mh+1ePqu3UYUIPOZGu5B3LEvcvk8ef5om78MdJyVmq+C7YeJ1CzeUPipjvO6
nmv3hdVbBbWq+CDg5qoGkgVUKQUmPJSK3KjxNwGGnv728ohiQZIu2DqyX8y6//qk
5GGGx2wPiTb4CVqdBvoYdq5NwPUxJUw8sX6XNv0czsRhEXqQc9Sk3nhwdGsv4vlY
o9dLbVR2
=KPax
-----END PGP SIGNATURE-----

--h7cF1XBKeemYMUcI--
