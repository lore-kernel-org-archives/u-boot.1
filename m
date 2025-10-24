Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A7ECCF9E0
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 16:55:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F2A583678;
	Fri, 24 Oct 2025 18:55:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lADgZ2TO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84862836B4; Fri, 24 Oct 2025 18:55:28 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5444183677
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 18:55:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-65382808209so1159284eaf.3
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 09:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761324925; x=1761929725; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1bVKCouzTgy/x5QqJKOi+3FkFqWkXi7HjKJqchR2RAY=;
 b=lADgZ2TOddO66t2ZWpBIsAMhBPFP2baU2TpJxZl11qdV3ri4Azx3p8K6mEojSRIJi7
 0QHXmUbAvtNVgoXC728o/K2FkQ4wpmXhvZcWLYU0vwbCtzLmUZ1ygBCRRIk5WcnBnMqt
 uBQKS3Uguu4NmhlZMgUmMIoMgDePMMAUTT58I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761324925; x=1761929725;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1bVKCouzTgy/x5QqJKOi+3FkFqWkXi7HjKJqchR2RAY=;
 b=VTTr4ZNH+uDJvjVw7fcGv7AlaIyNKPj3Oo912uDb4kUUZCTkS+vkJDA/wXSzZdPOIN
 xTXCK/uPXFcItbTpY8ytsdE5JjakEqujnuWKF/II2soxR+obbf/7JTg4Y6oHhrbRnw3L
 8szZC9jNhPu3W4oPyG4ViCDxBM3ohvBeZcqm4JWMmVNPgnT41vgcbLIEbGHuB95K1gUK
 9Zi3kfbLNxR/wtVZlpP0WI3wjKXDz1cBQ0VA96b52KHa/kjPwNidjiLTUDYSwGEXilfx
 YjmPE4RrGnQviJgaroRKX/HODxfp734QokOJBi+GD4997GPj514F4sbys7qCRIGTBVSD
 aC4w==
X-Gm-Message-State: AOJu0Yx1Rdic7d7571zfVEUmfNmIce36Si0ysWlm6+QNqdntWzsMDMar
 CJMQfUgybQPv7pYqYlTjoFfOJGYXqwfdX3tNDDIXVWrgA0WOtePH02YivzwAuKWcooo=
X-Gm-Gg: ASbGnctDhr5y0x1EeY2zpndO+8qBaJEhwZurDr8Ni6H6skp+l9tDX6P/qhh6BJASjDe
 h8C+umK3AZSDiu1Y/C7jT0uUkSVVq5cMiE1p5A7JFSp0G9av/dox8iLDDHOw2rbJYpiHGNQdlb+
 FdWUmUEfUBBCFYz2YlnoYiwPV6QDyz/IlXFvpvsPEACv3SQqAbmSmLx8c87WL9J/RZogCwS+qbh
 kPNA+8pEKj48m+8dsxNkIAC7U9pHcL3+z14JObYy8WHS82D0YpmrG4lP51QG+0RuEmtrzvsopYP
 kCm7aeuNd1oUmhlHYvqJfJXQduXI+l8pr+X9KmisfCeGAQeo+HJtvSjeFlAITn4IuC8lmdzn29/
 1UQ7tTD+fWzYYwzjWccIRVLOFmQ6cqWAH+53BGbQbsfyUPtM0+NrkYd5r+CkhgvflGZcz3iMt0/
 VyLN0QA4YOrSC7CytZ6TR2xx9LjMURGyJsb6Zq24aW+xNZq2qNGQ==
X-Google-Smtp-Source: AGHT+IF02LZDVG6a0FQyU9Foo+3ddMZUif4WHm/qVQ8WNxOItDtPoqa0IJU2P4VyrhuEQ13iFD4cUA==
X-Received: by 2002:a4a:e913:0:b0:651:d041:d167 with SMTP id
 006d021491bc7-651d041d26amr10531033eaf.1.1761324925047; 
 Fri, 24 Oct 2025 09:55:25 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-654d7e8a196sm1324084eaf.0.2025.10.24.09.55.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 09:55:24 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:55:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2 1/3] doc: usage: Add general rule for `$?`
Message-ID: <20251024165522.GQ6688@bill-the-cat>
References: <20251024160557.2317081-1-trini@konsulko.com>
 <20251024160557.2317081-2-trini@konsulko.com>
 <b79c4e53-e7f7-47bd-9134-4943ef2e5138@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="teV8Np5upfh9vbO6"
Content-Disposition: inline
In-Reply-To: <b79c4e53-e7f7-47bd-9134-4943ef2e5138@cherry.de>
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


--teV8Np5upfh9vbO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 06:47:45PM +0200, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 10/24/25 6:02 PM, Tom Rini wrote:
> > For nearly all commands in U-Boot the '?' variable is handled the same
> > way with 0 meaning success, 1 meaning any failure.  Explain this in the
> > general rules section of the cmdline documentation (with a link to a
> > counter example) and then remove the redundant wording from most
> > commands. We retain a section about the return value in a number of
> > places where we are doing something such as always returning a specific
> > value or we have useful additional information to go along with the
> > normal return codes.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Changes in v2:
> > - Rewordings suggested by Quentin
> > - After confirming that invalid syntax also always returns 1 and not -1,
>=20
> For example cmd/scmi.c do_scmi_set_proto() can return CMD_RET_USAGE which=
 is
> a -1 enum and the function returns an int, so I assume this would be
> propagated properly?
>=20
> I don't have time today to check the cmd function call stack to see if it
> is, but this seems odd to me.

I spent a while Tuesday trying to dig in to this. We always pass
CMD_RET_USAGE internally, CMD_RET_USAGE is -1. I ended up getting stuck
on where we actually set the '?' environment variable. I don't know if
we have ever actually passed -1 to the shell. Testing things out in a
real shell, "2" is the value of invalid invalid syntax for a command
(e.g. /bin/bash --keyboardsmash;echo $?).

--=20
Tom

--teV8Np5upfh9vbO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPuvdgAKCRAr4qD1Cr/k
CvfNAQCh65ErL+K8WGhz/CtM026FFWHWRJ30O71Q/zKMW2Y3iAEA7I1BHQ1NTbc9
fvtTsFNQCcZlEXUUmELS4fOhC1YAygc=
=A+dq
-----END PGP SIGNATURE-----

--teV8Np5upfh9vbO6--
