Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D451FC25B74
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 12:59:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 867B188702;
	Thu, 30 May 2024 14:59:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eVtpLvXI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B647D88700; Thu, 30 May 2024 14:59:52 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5A0D886FD
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 14:59:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-62a0c011d53so8299847b3.0
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 05:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717073989; x=1717678789; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BW1wBpyFRYMtcpcI5nhqrTkXC+/qJQeUJWJe2rMH+W4=;
 b=eVtpLvXIDevrA0uMOyFbhI1Y5ZjefgxQj/cH9MoJ3PmMHjuFYQmx8pcvpGB56+KBmb
 i1r10rIOz/wJYZ/0bU/YMeG/EmouaDCJI3xwids+zQcJCSx8w6wh4eVy+2twQsRA2HvC
 kGPGqPZVpgQO1cOXNhS8YXphCCvQXvjda4fBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717073989; x=1717678789;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BW1wBpyFRYMtcpcI5nhqrTkXC+/qJQeUJWJe2rMH+W4=;
 b=M3qdegXdOepI+27LzdROjRP0riOWqg2zwkLmoAjyz9z3h8Xw9Ub6tiAlqnzJpAfrpA
 mLYxiej8bR1lA+FjJC++qYq0S88lUbWok5l0TghYTWcC4P2h65Y1B7+5xu3VXytaoPau
 rdvi0UC3ag0/ScDOOooB+Rj6e+huCBuOxwyM+NmA9FmaxSsaLdJh0JSwpHOECBc1BsXx
 1nAku52/T0Lz+bIuSFYmN3d6vWEeULd5qLzX+D3+LaRUMPBWuWseAEGJChkL1Jlfk3Mk
 0DX26QdjkSWOvl+LQ9V3xWJNesvTTvQvOpCtQgpqjRDHTNwVdyGviF6mxHD0zlB0eSOU
 Waqg==
X-Gm-Message-State: AOJu0YxuEOwtbNcNnOAn/+4l3qiiX10aUqTk234KcWpR8IKqoYJr3/P1
 ZAFZlMaf5DZbvns64UJ2nK3JHy2fyB3+3wS+6pYIhTSQxSgNBIlnlXQL1+OyMgA=
X-Google-Smtp-Source: AGHT+IG9QNd7CDQdp+YovyeMm/ZsZm7SqOS1kjefDDGm9Ky/uYpjvudCa2jbfw1PeEjgb+gvJAc6eA==
X-Received: by 2002:a81:ae04:0:b0:61a:e2f8:f7ca with SMTP id
 00721157ae682-62c6bbfda9bmr27312417b3.21.1717073989431; 
 Thu, 30 May 2024 05:59:49 -0700 (PDT)
Received: from bill-the-cat ([189.177.150.58])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794e0cbb512sm138955685a.51.2024.05.30.05.59.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 05:59:48 -0700 (PDT)
Date: Thu, 30 May 2024 06:59:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Kristian Amlie <kristian.amlie@northern.tech>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] Update maintainer for Versatile Express.
Message-ID: <20240530125946.GH3714513@bill-the-cat>
References: <20240524115705.2816843-1-kristian.amlie@northern.tech>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KRqeYOAATNNX0RAT"
Content-Disposition: inline
In-Reply-To: <20240524115705.2816843-1-kristian.amlie@northern.tech>
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


--KRqeYOAATNNX0RAT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 01:57:05PM +0200, Kristian Amlie wrote:

> Signed-off-by: Kristian Amlie <kristian.amlie@northern.tech>

Applied to u-boot/master, thanks!

--=20
Tom

--KRqeYOAATNNX0RAT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZYeEIACgkQFHw5/5Y0
tywrAAv/S3yDDRAW5OrNsx39LBiWS9x+gMZxaDgevhJkoi968VvXUxjsMDFwt/JB
XW2bN+cXUF9pKQfKyLTflRhECesrtj10hzZIOJYgMSe+imCiRuOHTN3Kx/7Zv2v7
EnyWE4BwMbzuHDv1QLIcFUpBpSkUn+Ji0F+kRUOJJLIc74v6rJQLPOxLCLahAgmO
JfteCVdTwrg6vXqNXwyRAenlThgEhVafsOEvVyuLKthjINFI3iLz7UkPRHbMYG2A
ike4xn93TvF76ktv6vcI3k2WpQbc6z+scqSeXCM/10Iw3ohjTUqa5PcRfP0NyIOo
9VjjVnqwk+uQvzpVsE3aoUHnm8JH1f7nEDKzmUD/Mb4nV33JzmKLYDhHehDu6sJy
yKXoSnlLpMY0Zfzn325Gis1C2egG/buvBahzCKjVtIiD+S011ocbAxu2IPkBQt3L
6/JLye/NCbDryeiope/42dFAreMDJg9DTmrDJUXPu6iMUe/AemXMsk7qwX27USmr
SN/zK4Vh
=SjzK
-----END PGP SIGNATURE-----

--KRqeYOAATNNX0RAT--
