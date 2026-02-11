Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34C9ECD6D6
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 18:27:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9447A83E1E;
	Wed, 11 Feb 2026 19:26:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZVY9VD7t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8611883E1E; Wed, 11 Feb 2026 19:26:49 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 765D483DE4
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 19:26:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d18d02af68so4930643a34.2
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 10:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770834406; x=1771439206; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7bO6ADVZRwrqCNKv1P7Bd7VGBzNLqVGKMNAQ1gVI0rg=;
 b=ZVY9VD7tXj9+TDw745QW6e0uTDz8/OkFZx0jfD4D9qFy68OgtihHUMgcn5O0mEIIFW
 buEhvKc5cRUDw7sIvv8xe6/22WjshlvIDzWgG+myAboYZtb49O3H9PjzVIxU3+GsJzkX
 wY1gWYb5YRiXp6WD3yi5nd+LArs2J+7cYsmwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770834406; x=1771439206;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=7bO6ADVZRwrqCNKv1P7Bd7VGBzNLqVGKMNAQ1gVI0rg=;
 b=GPXXZWwDCV2S399kgiQqPNdJwz71e8Q5NW4iISNkIX/r+GGfX0iqX+l1+pfzf45yr9
 4368qRRNYw+0M4QCsfGmzY6enRPnWdRT8vDHk5zqUdtdJLMtyP41hwFAdawbcF7UIZay
 saJrEK/3bnRizlbLIYXLeAyMbuF4Nvx+wCch0gBFbrWqS1j5gPa72oACGNLrU8Ykt4Ex
 G6PPmfxDTUCMTnsGYHOQX5omr9TaWitI2TKYQDBZvmU+tGir2Wb07B0elhb/9VfQi+Js
 J98jioIqd+SYCFCQV0pTKcDgIYlrv2bKlbGKGPazbFf3r8zRSNXxTUHftjgfISosUsOL
 DG7Q==
X-Gm-Message-State: AOJu0YwiunD2bBOCQmQtdGiMvZ47uDJBrerfuRPx095ePbXkFYUBAATs
 AJNaO5nVlZhIBbtW0lJ2frtw6oZ0lrngOWBb4MpJq7CsFw0ZRYwHEXVgDT6oN8NXWyJQ0PBhRoW
 jZVov5HI=
X-Gm-Gg: AZuq6aJWUGjsOwHeZXNDsFLiNv/E17Kob5jVu/wI+g7CZbYco7vM5e+o5BM2+spi3Ad
 PnY9qCBkrX0jUbzPbV+Q5qdrm3BN4LWHMtTVQUUUyAK8kohPv2hyWuvlupY8gyojR4STun2BkNu
 mb/i8uQWOhmqGx1AXPE+VPVDVLPINZm9+1XBRiA/YDP49aQeLm6+VYRrS7ql0yd/F8+IzNLuTGu
 KnIFtulQJNbGZaZjRZLTLGDGMTFZuFFQZPryQIcH+cXqj0MkIwIL2u9lNIDJN19muC3pAaaEBQN
 Y5WQ8Tp9QfY17Ihd/HBpXy7FUvsr7iGbPcY9IiCweA7GVmJ7grzrpXvgXxAAU1pJxebQPv0NwQP
 /5WStzFlXG3vZqodKhcnpqpLqUT9ZqV2HSj5i4jAlZyQBbi8fdPQQc/DYrfssSW8kLWtBC/OVT8
 knMllK+mRa6JVmFBUhu/Usr6jYRATwgLE8XikYUTQSQp29f5qfrKLBmulKPLofl65ofU+W6aoRr
 fvu8oeLnBQG7oPcixLlXa/p69ylcrs02yJeR/B+to0kg+USrtvwnbKEpzYRjw==
X-Received: by 2002:a05:6820:208:b0:663:5fa:c2be with SMTP id
 006d021491bc7-67598a3a882mr69545eaf.27.1770834406003; 
 Wed, 11 Feb 2026 10:26:46 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40eaef220cesm1834035fac.9.2026.02.11.10.26.45
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 10:26:45 -0800 (PST)
Date: Wed, 11 Feb 2026 12:26:43 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [ANN] Updating next to v6.19-dts
Message-ID: <20260211182643.GC2747538@bill-the-cat>
References: <20260210175119.GA2728096@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sgb6OL69vQMfv3sO"
Content-Disposition: inline
In-Reply-To: <20260210175119.GA2728096@bill-the-cat>
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


--sgb6OL69vQMfv3sO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026 at 11:51:19AM -0600, Tom Rini wrote:

> Hey all,
>=20
> I'm planning to update the next branch to use the v6.19-dts tag shortly.
> Assuming nothing fails to build/run in CI, this will be going in to the
> next branch today or tomorrow.

I've pushed this now.

--=20
Tom

--sgb6OL69vQMfv3sO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYzJ3wAKCRAr4qD1Cr/k
CkYjAQDZzytNmJu8YhoT56t/5fIbDE0dyDDKgV7VoJoEDdwTKAD/R7cHUqXXChkF
iLCX5lOp77TdmpuHgQfnpWqpwueMtgs=
=e7nQ
-----END PGP SIGNATURE-----

--sgb6OL69vQMfv3sO--
