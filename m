Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBB8CFC282
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 14:29:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDF028397A;
	Fri, 21 Nov 2025 15:29:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n5zIqYnU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFEC08397A; Fri, 21 Nov 2025 15:29:29 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 932A48388D
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 15:29:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c52fa75cd3so1519618a34.3
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 06:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763735366; x=1764340166; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+Phffw5lNCYnjHYipRAjzOTLAyz3Bygw7EeM+viSMRc=;
 b=n5zIqYnUwbBCwn8AvXankaPw5vdwSMRNehUfMVs4d7A/8CB8O3c2Z+WoPqW1f0so2p
 paqpraZvOwb7TUDLD9ZnfeF83CK/UuO18y+074T4y5zkrBDO3zCmgoyeKFxKgLlpQb24
 8X0DseuyfmksGU6ds1ReUuuT9HZHwRXdlIp9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763735366; x=1764340166;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Phffw5lNCYnjHYipRAjzOTLAyz3Bygw7EeM+viSMRc=;
 b=S51cWtX8SSus/zZugXZFrvblpCVpIwkPFvj1uuIWD5p8QEzuKl/y5so9ZuFfGrweKA
 nE+MOdkKGqTZjwpgbdb9cNjj7oHo2KETYaZtnerntw1sgjawLEtiLz8atotUpA718IsF
 aqjBCRS9LID/Ya307n6f07k5iHPWxmLg6hDKh6NPAdlozd0Gs8p3w3z9E4uQTR6Sf1lb
 kbuPYX1KIZVxGlaUfhn/DNOdcqVsC9mYupBFwzK7NTkXhhKySTFPSpVBvQd4yFDjaQmO
 UPA0ZucGcsOjpy6W/s1vj195+DflrjOkJ0KADCWZe6PYf5Q2GHWeUxPaCOQjpQylc0z8
 8bDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqu/9RNmhSZ0CWmHLauU7h8CvJulJgxNGW3ntaX0ntgCclerWFWj0N/umZ4yGom2VKsRmC2l8=@lists.denx.de
X-Gm-Message-State: AOJu0YzBQgVt6G79UtXVoMxYK9YiH5a1jBVnEua1Sah1yiU5v1jsNjlX
 Hv91UA3ZB2ADqND9si0mYl3d4zepUjEEgUDLMNQZlpAO2NdWgarkEj0tIB2cgi9y1Qs=
X-Gm-Gg: ASbGnctj3VGtzz9KR5M+a04QJNrfcV50MxnpyXFoP1to6glykjVm9XU2ijExbO4pV1O
 8WpYVEybVnrCtLT6AYSY8tyjUeaI8LG5zTU5XAky3lAl6BEGFWIJMrDr0b8f55MTzT9Ceq52gy0
 yWSMvEs5z4do51q9zcorUxsK94DtyZcif1OGnJVhjGKyim+osqC2Cx+SXg4yvbFJY20tl07eQBC
 516PsePQaKJZQPNZMQOESyIikSDUFoCG+KrmkZWPgB4Ppx9xr1dJZjSsV6WABFBfqqJ1U+5UO+d
 7SfrcOyJ3qXZ4O+FvssEFrd8GnI1PCebtPdNb3jwmZBya7w23yyKaqVtPfPt5IaefFmBbdTOYGp
 BhSH/EfzKi1MtrsKHnx+CWiy8gDME7UfndHigfmDbPQ4wpvgcUZoBQH2vL4Jdyu1RwCQMT2O+8y
 77zZ52qcCBNPO/gyz27LrVsUJ2Qv0/yiHiJNCwzCfZRe7xTD2WZg==
X-Google-Smtp-Source: AGHT+IFcWfrCAniNCHrN6kTS4miKi15XkyHNzJUQwvIwm8CqoFAIO6oA07Rh05HNeBMr2CPxTCdoxA==
X-Received: by 2002:a05:6830:4486:b0:7c7:6043:dd87 with SMTP id
 46e09a7af769-7c798c4b2b8mr1295444a34.6.1763735366247; 
 Fri, 21 Nov 2025 06:29:26 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c78d4021afsm2249593a34.25.2025.11.21.06.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 06:29:25 -0800 (PST)
Date: Fri, 21 Nov 2025 08:29:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Max Merchel <Max.Merchel@ew.tq-group.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Fabio Estevam <festevam@denx.de>, Stefan Roese <sr@denx.de>,
 u-boot@lists.denx.de, u-boot@ew.tq-group.com
Subject: Re: [PATCH 3/4] board: [cosmetic] tqma6: adjust SPDX tag
Message-ID: <20251121142923.GV2125796@bill-the-cat>
References: <20251121081138.73285-1-Max.Merchel@ew.tq-group.com>
 <20251121081138.73285-4-Max.Merchel@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XJp9IWk5LFVl05Hu"
Content-Disposition: inline
In-Reply-To: <20251121081138.73285-4-Max.Merchel@ew.tq-group.com>
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


--XJp9IWk5LFVl05Hu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 09:11:29AM +0100, Max Merchel wrote:

> While at it, adjust the TQ-Systems copyright info to include
> consistent company information, the mail address to reach all
> developers at TQ-Systems for questions regarding U-Boot support
> for our SOM and remove author's company mail address not suitable
> for plain text mail.
>=20
> Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>

My only concern here is you're extending copyright years without
significant changes, and this is both a bad practice and potentially
also worthless change. Can you please just update the texts? Thanks!

--=20
Tom

--XJp9IWk5LFVl05Hu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaSB3QwAKCRAr4qD1Cr/k
Cq5sAPwL+jAOtWuH8P9zWgnf/D+Zz40a1mMEnVARzyMiN0C14AEAiYwvtqGS/X6Q
r3PsJVXm+6SlSf/n+v1leYb2oDAeGws=
=GV4T
-----END PGP SIGNATURE-----

--XJp9IWk5LFVl05Hu--
