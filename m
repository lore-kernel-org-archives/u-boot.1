Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED662CA0FED
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 18:29:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 399DE831B4;
	Wed, 27 Aug 2025 20:29:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ON67UdLT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26666831C6; Wed, 27 Aug 2025 20:29:29 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A15D83106
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 20:29:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-31589eab08dso170142fac.1
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 11:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756319366; x=1756924166; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mxNKmQncUaKKQDbeNmEmbCAiq1VVlYaJvoUI9/N7+Oc=;
 b=ON67UdLTwAZMEqGo28RYtqrCjwzWS/MLkWDhvzC4dCt6zEjyYEMSmdwaMn2m9quad9
 TuX0X4q0+dPIDDahn0zNjw4Ef0kfsQa8+ScAR0WTI9n6iWxTSlNeg/gBl9DheJs2lfKK
 bpS7+octV7sgoF0bi8CmNQJK+8P1nnckAYwkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756319366; x=1756924166;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mxNKmQncUaKKQDbeNmEmbCAiq1VVlYaJvoUI9/N7+Oc=;
 b=dTxyibcJfEH0Cz9e9ggjG5Mfl0F2pAcInZLkNiMCKqurLBSNfbbYMnKgrqEFAySonh
 Un1iMbXDaaT0WoBDC44OYHdrwdrfFKqkFwRjo8kqUMVCQCBERoQPMqwJhEPPzKMdC2zB
 /Neqb3Ao6tXHNsxmftCtLn5AmNopZgDIpTOo6pcgg8tE2zBK8nhDMYtFTOyLMZ1MvuhT
 MkDWEPNwPLwJiBojhyEQhMhhi7ONsEzCjgp0i0C2D0PSW/SuZpJKnQUrMGieOpz6uX4K
 5+c9f1rYGFlh2f3INnepH24+A3Yu2lsyYgZi7nuyL9ddD1LpqLQzBxMoSnTAvxVBI/42
 8Bcw==
X-Gm-Message-State: AOJu0YxmEY49FTGN03b4YQ6pjJTfeBnQvGcRRXyvPlNW6ilOTQ+mt6kI
 W8cZq5/waUKwgcf61iDEUHNXcD+yxv4b/gFvdxw9zMZtm4VdEnQmW84//FqkmpgNXiYYhn8Jm+H
 G0o4QXJY=
X-Gm-Gg: ASbGncsmlO8Qeu2NvpoF9uSqZHs1YOnTdo4OGFMvPPh4Pn6lacRaNFXupv8SsOr5eBU
 DH+sXHaqoDtq2SaB8/SysxM0D79rran8JDgijlQoR1Xq/wL5QTOdYWwLFQFKOYnAf5BO+zRp/p7
 EWaOmzWDdLVM+KthWVPVaycIZvIwcJIzjGK0f4L+0zw2tfpaLLlKZj2mMHopu+pPRjnVqEEXc9L
 bsIl9CvoSZ1rsNvKMfGyUSQYudz7x4g4qd8ecidwZsA4lxeX3STcPVU1O9crKEgqWMGpiZnCGK+
 U3xgLHzfi68YRhkHXIWKY3gUpHerp3PJ0boMLpAVwYkkm2hREDXc5drE2ma1qRhUK5/GaMVuNAP
 gb3NphZzPPT2NL8AfT4hcE3FjXruO5MKNYG0uu6A711z1pc91sJ6Xbo+n
X-Google-Smtp-Source: AGHT+IF5iuNYTFGWrYGoBXEvfd/QaR9RQ4YFW5pvhO5Xf2ft47CypYsffUNZG7eThK7t0QaQocKrqg==
X-Received: by 2002:a05:6870:ebc4:b0:2ea:7d72:23f7 with SMTP id
 586e51a60fabf-314dcc16a87mr10258451fac.16.1756319365580; 
 Wed, 27 Aug 2025 11:29:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-314f7d7595asm3400262fac.30.2025.08.27.11.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 11:29:24 -0700 (PDT)
Date: Wed, 27 Aug 2025 12:29:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: Re: [PATCH] fs: ext4fs: Add initialization failure recovery path in
 ext4fs_write
Message-ID: <20250827182922.GK124814@bill-the-cat>
References: <20250826193717.20543-1-mibodhi@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5+leJ02t5fmJNifK"
Content-Disposition: inline
In-Reply-To: <20250826193717.20543-1-mibodhi@gmail.com>
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


--5+leJ02t5fmJNifK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 12:37:17PM -0700, Tony Dinh wrote:

> Don't invoke ext4fs_deinit() in ext4fs_write() if the failure occurs
> during initialization. It would result in a crash since ext4fs_init()
> has already done that.
>=20
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--5+leJ02t5fmJNifK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaK9OggAKCRAr4qD1Cr/k
CmzuAPoDegWeWyOVRgejku6yySxe2ZmpU5XvLly57dmkhaDpbQD/TE4DtYqY6y/W
ZBP5vqGBQ7jT0f4NJpWdu4NXGcLY8Qo=
=7L9B
-----END PGP SIGNATURE-----

--5+leJ02t5fmJNifK--
