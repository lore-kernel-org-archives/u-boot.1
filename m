Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F4FE7D0A0
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 17:25:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EC5C86898;
	Thu, 21 Sep 2023 19:25:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="O7AEHCEq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 210D8864D4; Thu, 21 Sep 2023 19:25:12 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22AD886898
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 19:25:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-58dce1f42d6so33892627b3.0
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 10:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695317108; x=1695921908; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Eub2QXyacuH/7vXqsD2Dns4T0P49Ryyf9GDq44q0gYY=;
 b=O7AEHCEqLxaJsBg6YfXKWUB87yWzQNR2potKfkUO2EWv9eftc4MLGVh/KsF+EKpI9r
 aCcacMNELZk8LulSjJ9ufciPtzb9e4gGW6y7QhvtvSoUl76WcHkHN4Y7QM5ERb7fgtCH
 RtYMayyN2bztNaAtl5xIiVUZztlLzRrZJNhyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695317108; x=1695921908;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eub2QXyacuH/7vXqsD2Dns4T0P49Ryyf9GDq44q0gYY=;
 b=iASVvlpC+wKkrBjveGzlz1u4sdBsi310wTraSH36x8+is7DhPt9Y+/TSG4DNUy4psq
 wlyM06UMlZu/ooxb4BgrauplJh0z8/ejSXrOJoih2ht5dJxZQD1P5x7MLYUPka+raR+r
 GgB2H5ZjdcuEFf4KM/Ou/7rx4NCha/ezbAjUWqzS8SYSh/dRi45y1gKP1dXCnENcYUw5
 d1kra3yPUYpwuGySs7kmTBZMKvo9Kk1khAAYu1yebDL0dxi1nzVQFnW3w0KCGsL9a+D8
 o7s348Pb0gFV5+8HjA2FUK8ZwvhCEQaeP59sfqicUHiSMFECNMeerlqtk7iLi6SRYm6+
 xhEg==
X-Gm-Message-State: AOJu0Yx79dzdw4YATSAWTgQeSi3qnepRG8vFWpaBmzuWqbtC5OUZ+I/5
 ggvL/ueipBd6YOvK1P+Y9J4tRA==
X-Google-Smtp-Source: AGHT+IHB8IcXkQjC/Vv+CZ+gNb9liAoXEiAL1I2G46A9gwgOiPXud/ncL0D+olnrmsK8vYf1MC3F9w==
X-Received: by 2002:a81:8314:0:b0:56f:f0db:759a with SMTP id
 t20-20020a818314000000b0056ff0db759amr253414ywf.13.1695317108699; 
 Thu, 21 Sep 2023 10:25:08 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-46ac-83a0-07b5-e9a6.res6.spectrum.com.
 [2603:6081:7b00:6400:46ac:83a0:7b5:e9a6])
 by smtp.gmail.com with ESMTPSA id
 h144-20020a816c96000000b00583d44b4b30sm434409ywc.99.2023.09.21.10.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 10:25:07 -0700 (PDT)
Date: Thu, 21 Sep 2023 13:25:06 -0400
From: Tom Rini <trini@konsulko.com>
To: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] bmips: Add Inteno XG6846 board
Message-ID: <20230921172506.GV305624@bill-the-cat>
References: <20230920074225.1130769-1-linus.walleij@linaro.org>
 <20230920142252.GO305624@bill-the-cat>
 <CACRpkdYqO1nH51VxjbpnPjaPy7eHaMDCSP5tWBDB1SB3R0cCcQ@mail.gmail.com>
 <20230920185547.GP305624@bill-the-cat>
 <ea1b9ef4-0cf5-ed92-2b70-6d8f70be17ac@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="moWWq5SAFglk42qQ"
Content-Disposition: inline
In-Reply-To: <ea1b9ef4-0cf5-ed92-2b70-6d8f70be17ac@gmail.com>
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


--moWWq5SAFglk42qQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 04:00:24PM +0200, Daniel Schwierzeck wrote:

[snip]
> I just tested it, you can simply add an empty board/inteno/xg6846/Makefil=
e and
> remove board/inteno/xg6846/xg6846.c. But you can also remove the Makefile.
> Just the Kconfig and MAINTAINERS file are needed.

An empty Makefile is OK, but no Makefile requires a bit more as we first
try and include it unconditionally and then try and link in built-in.o.
I'm poking at this now.

--=20
Tom

--moWWq5SAFglk42qQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUMfG8ACgkQFHw5/5Y0
tywz1wwAg+3vVanIcdhawV3dpPVmysi8gYG5sRltqtChzQ6803MfhWYGIWoKcINs
5Flns7tbHjxCJJwsXLhU5kcrRnI1n7UeJUGJT9A5eUMXjDZxrCUmPTM8Uklsmkxf
2asVfD2cQ2U/uUQeo592M+qSk3Be2wP5rNUHmDIrTEGnqUUZIo3yPvTEpUXQNFtq
4YJCQhFhbOL0U581EcrsfvD0j8M6/o1y6oY7rQ0JH7RkFiYLOrRR3in6V6gVgNSo
JOKcqxKtQmgt2gxBDeMc4o8w+vjoNyBedQvMUBtubBTzZWNbN03R3JEgw/975jQv
ot4VFLp5TfIsZO3La6xgNB/8R+zDRXdw9d1HQ7/lfUvD68lDwILkJnolvo8JQZDM
ZTtJBNIMKarrFLwRw+unBltoPLh259KSYHv0dYv0xw6cCNILmaaC5guaogB0jp/g
uD4ygYseuYaBdQZ2cczD1FPfxYK0IlROoJAv3RhVahc+xlmlOT1JaW37KFCljjrl
0r0xa9ox
=Ji6x
-----END PGP SIGNATURE-----

--moWWq5SAFglk42qQ--
