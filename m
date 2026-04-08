Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FCF110F995C
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 16:26:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F06184148;
	Wed,  8 Apr 2026 18:26:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EAVm/TJl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B93508413A; Wed,  8 Apr 2026 18:26:16 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4619184148
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 18:26:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7d9bba96f7dso3269a34.1
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 09:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775665572; x=1776270372; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=orkyrN0jOMJUb2gjuv8Ph7s0M0XJBio6jcp5KreZBGI=;
 b=EAVm/TJlye+F5oGWx8kTCB/7Tj1wwVMOc0Q3GS6AMFPBvSQjLJ0KtWblSiJmwKVhMP
 YP+en04aAVbPY0uVbeVYl6OA2hgh3/uoca3EUgu3921R7hkuxXRk2zm0A6UiXgvEl0ba
 Cl3yE9AU28Jg40oJOzMEeGUSuFFXuDRzVK/5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775665572; x=1776270372;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=orkyrN0jOMJUb2gjuv8Ph7s0M0XJBio6jcp5KreZBGI=;
 b=gUJRMtundEdaNzCX4i8x1SV8d3ehmhTSyz9nbyUJ/Cnm927VZTGBMU7bQ4wmZf+UrG
 XX032vTpdMH1AbKNTnC1pps7t1yF6VBL25G3L0bCmZAK81hQ1+s1Qm1UnbNDVnGx8ibP
 Qpc0/KA7zUdeTCV2DmAlDvawcnYEcevw2hpJ8UJnBPXvmlmRKiDAP4v6eTzclvEl3W+v
 biUurnd7VVjNZwLQ0p/U66z+7w0rKih4LprnC7845SnMGKiQyR4A4OKyKsN1JQO858wN
 lSQeOZgXghApmlsIcC7agjx/518+zd3NU5espGNlqM5u+BVYg6CJMz0JDujc38MIGlku
 2KXA==
X-Gm-Message-State: AOJu0Yy1pKxyLIo01Z2+mf27T0U51x+nzBOuq9Dxhc13vhv9DpxaRFga
 BG49kHPGga0ZEXytIuBfBLBbXS0GURaoPOWRU8EOeWjmE3JmglTsVcYDHUBaNVjUXlo=
X-Gm-Gg: AeBDies1lr4942HOJ4ljR8bsA0iteHqs7g3DS/kSLa3BtD5EyfzlrV5wmyeUYyYd3D7
 Uz3fGu3Uq5BW56j9O1XJlFVBmWBW+Ise6uDyGNNJdhgUUgF6fqZvLxuURUou1DBclsGUnP6liBm
 XqCh3lGu69E3h4N9UzcCpO5w39H1wyXH0fcLCFSXcPlwj79uv+uPIe11svGrzkuuQCoAjsdgBlo
 HNktsOOm8Q0tjktHcns2bLd7im4hOyBg3TPWFZ9hRm2+mXoqVhNSf1pjA0bQ3WartiPbMb6zssG
 HlQrX6SCzcnCheDG8Vzok4065pjMQgXsskic08QYafY+SY9HJEsku+Z4a4FxXeDP0r7tUelSkkO
 jFUQPYsP+3hJ1/RVfjqTzuVR6oiGtEoKi8ZZ0cVUEUvPVPJWuxR46X07d+9lhvrUlnVnJ9tcBQ5
 8SLLAvzU++kl0oVNdFFD4BFlRZlYzjiYsf+xDqw53xPJ689T3Yei9l6ut8zC8wgg4SIoO975R9c
 4ZpqCOv5UKeS4tSZTG/AhfnZfGYx8cYR3EQqx3b8ejxF0L+
X-Received: by 2002:a05:6830:3898:b0:7d7:ea9f:c0f9 with SMTP id
 46e09a7af769-7dc16bcca2fmr229486a34.0.1775665571962; 
 Wed, 08 Apr 2026 09:26:11 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dbc8e64baesm10017689a34.24.2026.04.08.09.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:26:11 -0700 (PDT)
Date: Wed, 8 Apr 2026 10:26:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, James Hilliard <james.hilliard1@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 05/13] boot: Move handling of the load_op into a separate
 function
Message-ID: <20260408162609.GH41863@bill-the-cat>
References: <20260325165431.1027591-1-sjg@chromium.org>
 <20260325165431.1027591-6-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OTqCDhN/Jv17y9A3"
Content-Disposition: inline
In-Reply-To: <20260325165431.1027591-6-sjg@chromium.org>
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


--OTqCDhN/Jv17y9A3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 10:54:14AM -0600, Simon Glass wrote:

> Since fit_image_load() is still too long, move the load-operation
> handling into a separate function.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Same problem as patch #1.

--=20
Tom

--OTqCDhN/Jv17y9A3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCadaBoQAKCRAr4qD1Cr/k
Cjh2APwO4HTjgnWKwbnaVstjRml+N/r1PP3L4zWPX3v7Nn0lrQD/ftv/RFMTozeH
coqMnMIBGcOia8wdN2rbQNxZrOryTg4=
=1qWI
-----END PGP SIGNATURE-----

--OTqCDhN/Jv17y9A3--
