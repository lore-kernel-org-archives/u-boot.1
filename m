Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36C0C47422
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 16:15:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A28F187BF6;
	Thu, 25 Jan 2024 17:15:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GD4wP9Zh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC4B58783B; Thu, 25 Jan 2024 17:15:07 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A98B987BFD
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 17:15:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-dc24ead4428so4875751276.1
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 08:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706199299; x=1706804099; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pmA1+cCQ5TunyrkCnHcHLUZAHOfcBOGeK7uubnMVaiw=;
 b=GD4wP9ZhDxuW2W8ole18BrHO37cUm+8HylTYsJXHW+FxxwkcpCtMEVSwEt/LoqUBi/
 RAzYWrwgfhuQ4LpVeLVy6gYT5NMweLwx785IINeRfC9B5fQCBI1g5z8+37a3HhZlA2uS
 X3gX+mqGRhH461LxNfgegJXD+OsnwwtY4Kj0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706199299; x=1706804099;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pmA1+cCQ5TunyrkCnHcHLUZAHOfcBOGeK7uubnMVaiw=;
 b=lExX3jcbjW1mF2Px6BJR7c9XMVCnYgKeStNaNq1WDaQNCildAX/B1VA0fVQtwOzrUb
 i0ZWM+Fw0rv7BkZKpkOPx4waH0CMu0xPvGWoLlH5WblkteDKOYxsRfNy/SVU1/bnFsVR
 Dja/G3gBjl/9sCy/12zyZEnA1uypA2kEU1cPaid1jXiu66he/3fmRnOM+80mGe0yY+9l
 WhP/y+y4z3tOM/4cgaLDZhK6cUEc0gLzr9QsE4QNDSj8vJQSgoIx7qvs07NVTg3hQkcK
 5/yd4reBDQ+3iJk/aMFP9rNvdMOMlaR5fsbqWenZfJNxEKGbZaQUgygWH94HwoihNCmc
 ppGg==
X-Gm-Message-State: AOJu0YzMLKPOElHWx1vvUSbzo5pCbpKHW5CI+n0E5wWCnsOofFTnY64G
 AM0tITDNBEGkRnF/IuVvHFeF5fanVBY2GEwbvfd6ilUtp1yql4Q5gsqaagnpU6M=
X-Google-Smtp-Source: AGHT+IFjRQxiQz9//vYZ9h7uaJw2v2bV+WxpHgDkRt+ZkiyIjUXpgsRrGTncQRa8ZQ27Ez4zJIh9og==
X-Received: by 2002:a25:9704:0:b0:dc2:21fd:b17d with SMTP id
 d4-20020a259704000000b00dc221fdb17dmr44550ybo.8.1706199299256; 
 Thu, 25 Jan 2024 08:14:59 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 e78-20020a256951000000b00dbf52d2844bsm3571633ybc.11.2024.01.25.08.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 08:14:58 -0800 (PST)
Date: Thu, 25 Jan 2024 11:14:57 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Janne Grunau <j@jannau.net>
Subject: Re: [PATCH 1/1] test: enhance unicode_test_utf8_to_utf32_stream()
Message-ID: <20240125161457.GW3652023@bill-the-cat>
References: <20240118175712.51068-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4u7NFZZ6R6nj/CWy"
Content-Disposition: inline
In-Reply-To: <20240118175712.51068-1-heinrich.schuchardt@canonical.com>
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


--4u7NFZZ6R6nj/CWy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 06:57:12PM +0100, Heinrich Schuchardt wrote:

> Additionally test a UTF-8 string where each code point translates to three
> UTF-8 bytes.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Applied to u-boot/master, thanks!

--=20
Tom

--4u7NFZZ6R6nj/CWy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWyiQEACgkQFHw5/5Y0
tyxLTAv/b/zbfkS3ROX68QfZTG6cKGTe6wUC9y4jk6H1oT3sFfrMlopBROKVOZqA
F2UXBt77ukwevuXkw+3vu/lonrsDYYfZQUyk4fHXXeVziLiaB7s8xVN1rUGIj7cn
zDwS1ntT0mHOZhvObA6G/8rnUOvn0g309rHqDzbM66waaQAzMv1XciYulz9k9JFG
qgLppnXn258n8CWFCL2VhS0jz3EQvonlTHl6w/R86dEtCidm2jk73263UyyCQfCg
TBYNs0fkkwH63nNZ+K61OwbH7DG4b/rPQ8dB51dTXriBIYCM82BbE5LLkSH2PhEg
AWB2uXSbJJk1LzbFAE15ZGdSX9VYKxaJnBgQfDEozD95kTOeApTO6c4Ye4FuwAra
mVD6z7Cc0Ht036w59S3np0JoMSEIfFkQESp/i9BjtySAhhxm6NIe7GMmMebRs3yu
rQtRxyh89Q3gIBTwNasKVMZ57R8KW6EiLVfb6/jzUk9z2DzlgqUxioV/cXDK9erg
RyoIRYMR
=1llT
-----END PGP SIGNATURE-----

--4u7NFZZ6R6nj/CWy--
