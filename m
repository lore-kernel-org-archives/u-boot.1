Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9C5CA101F
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 18:15:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB12F833ED;
	Wed, 10 Sep 2025 20:14:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XHXqLpo1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A981D83280; Wed, 10 Sep 2025 20:14:51 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36723833C0
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 20:14:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-31d75b4d485so3960425fac.0
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 11:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757528088; x=1758132888; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hQw+k6bzTPufd7iuKccm3QhZS+Efs5UOVzyvOF90p50=;
 b=XHXqLpo1sjrufbseiRBy9eFTOMe34EcQO26uI/XXhyFlZZrlYGJZY43hmZIKcesROG
 vfDPBS5PUNud6iK5fZKAcdhdo4fdXlxKvx+X+GtYKGDYucbr4ldMWVyYlG2kQsYaj8hZ
 wRn3mKVZ1dqa4FyoH3eUqm5N95Q+Gy3XQCMMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757528088; x=1758132888;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hQw+k6bzTPufd7iuKccm3QhZS+Efs5UOVzyvOF90p50=;
 b=qtpltKjvR/KGRBya1cjFy3YXVLzQ2dAIBhgVocE27YCe2ooc/R/wdGwyovcgqcKV85
 +daL1+qjiToaQkm1dwOeJIdVy87GS44GJcZVEvu/Zyh4K3MObh1SjRJ08eILNLyRKZ1z
 u8ZITQtJVfvFkYBeDu60owgNnaAAgqZxrEnGzRSY03zsBX8MmsxBWSLgOGL7NeZbQLEp
 g0Lq1Q7i0ztvYCwXKyerUswzNR5kxPNvdYr24stgXknDI79CJzxV/ro1u/4cxMzMeN2c
 GCA53YTOco7jskDLphJ+TafuwRD1cM7zEp1Q6UcuLLpAdwQ31JMC1fbKxgLGv1zWmEuR
 a8/Q==
X-Gm-Message-State: AOJu0YyCY9OcbWyZwHDlJA79+sbJM+FaOoXJL6p4w+oNzMA/esD/OsR3
 Ixaf3qCH0AFqalPDyXUqv4dv7DpESucPBn/lPgC7d+wC4EeNasHRn7xuY3YW58yEp7k7IYQfjn/
 Ywg3XfX8=
X-Gm-Gg: ASbGncv9hIxpYLSjQ8dj750NG1ZNBQ/9TwzaL3vBzSiEuMYp9Xmj+fTBhUTgkvSpIYp
 yrHyT9UQoTX9sNOG7FJ5posoKn8o2OGRg/ImrflQInzxS/2pTabzv2B4aiwAL9s2U9mQAOzeMBe
 OnGP/88zuEzFdqrH4lAlyrTwR6D4Z11nPP19bGLdHhtpV+OmUl75h4Hd9l4l5v/IzoVzYaHrskx
 7u+wtsRuTfe7e5EOzKReI6g+BbYmcyUI6pPUfdiLXVAGGoodWed4IGYeF7dIR04f0E3Ie5RjPZK
 JAvryNTz8T9A+m/kxOciHwZIZEEXWE80moc8jkmfJw9YNkhkIycEEeHxNpR9UEsyYlBYJhD2kWq
 I6ig4ag9/xO5/g6hdrQ3jYm10BE2DVw4EnuvJMTsvdaNdnfU5jsICDkxR4z5Zqv/Fkkw=
X-Google-Smtp-Source: AGHT+IEVu2bOGUEm7aa+1/QfnsEf9IPrDptrs/vrORhmDDg+g7tyLtGGZYkm9o/46GT8GZeA8N2NVQ==
X-Received: by 2002:a05:6808:50c6:b0:43b:55c9:3a04 with SMTP id
 5614622812f47-43b55d88f75mr2484639b6e.25.1757528087873; 
 Wed, 10 Sep 2025 11:14:47 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-32ceb4ccf68sm13723fac.30.2025.09.10.11.14.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 11:14:47 -0700 (PDT)
Date: Wed, 10 Sep 2025 12:14:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
Cc: u-boot@lists.denx.de, Heiko Schocher <hs@nabladev.com>
Subject: Re: [PATCH v2] i2c: davinci: =?utf-8?Q?dro?=
 =?utf-8?Q?p_unnecessary_parentheses_in_REG=28&=E2=80=A6=29?=
Message-ID: <20250910181445.GI124814@bill-the-cat>
References: <20250828011908.5406-1-bhimeswararao.matsa@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iKUqTCO7TPeHlCzP"
Content-Disposition: inline
In-Reply-To: <20250828011908.5406-1-bhimeswararao.matsa@gmail.com>
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


--iKUqTCO7TPeHlCzP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 06:49:06AM +0530, Bhimeswararao Matsa wrote:

> checkpatch.pl reports that several parentheses in davinci_i2c.c
> are unnecessary. Remove them to clean up the code and silence
> checkpatch warnings.
>=20
> Signed-off-by: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
> ---
>  drivers/i2c/davinci_i2c.c | 118 +++++++++++++++++++-------------------
>  1 file changed, 59 insertions(+), 59 deletions(-)

Please rebase this on top of the current next branch where I have
applied your other patch, thanks.

--=20
Tom

--iKUqTCO7TPeHlCzP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMHAFQAKCRAr4qD1Cr/k
CtuxAP9R02E71SnUboArmMSmLA/ebZYvzy4UxoMHTYr9NXJRkwD/Vj5r2DxFpTQU
9QqrUJlEPiLHVQDWYT91in4cQMGPVgg=
=2yZl
-----END PGP SIGNATURE-----

--iKUqTCO7TPeHlCzP--
