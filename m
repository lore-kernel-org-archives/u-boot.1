Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9FFC5478C
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 18:53:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A5DF87DE3;
	Fri,  1 Mar 2024 19:53:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="faThf2an";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 877388815A; Fri,  1 Mar 2024 19:53:55 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BDB187903
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 19:53:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-dbed179f0faso2613121276.1
 for <u-boot@lists.denx.de>; Fri, 01 Mar 2024 10:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709319232; x=1709924032; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JO0afBI9cLs1F+4JNhZhI9icLHf9ul0JwD+NPpFymyM=;
 b=faThf2an2EgF+eNL4do3/dM4qEbs9HKXqDpvgNXnjtMFkeGj42g7CZwgcUHQ90FH7/
 LRU7McM+BuqAikBz6knQZrYk8yOdjdHRWJcUb4T3IbYVO84ElqI87EPlV3HM3zsiFp9n
 jetKGVO5JZ4nWVI/xSyEr88hK6tiv9AvD5Iys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709319232; x=1709924032;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JO0afBI9cLs1F+4JNhZhI9icLHf9ul0JwD+NPpFymyM=;
 b=JZOCiyQzeBGaBavHSJAnp4zmLbb4ChbB7CT6AEoR72ewjUHA59LDDMMtxHji0geYA6
 y9+/g0CPASM8y74+VagYbxlWBn2U4vBxs1uatlwx6k87YHeNScPud0qUXIV11cPeB0Dv
 wq3wf081OMSU+ryq6WSctOkdOeNwvrx3Rcr2PpStsZXHu+Pf11kvd78Lthll7KJZ21cn
 QhRjn4TpE12A92lc265vbvk9wxuon0wLbYHivJY1VGsxZXQ+aIone9fvhtHFxRWMCox9
 /UIlqmI4DuYKpwCdlNttAbThUQABmtMtuZRg2CA7t7lc9GBlfN+Y5TCA3NkExDiINUcE
 d/0A==
X-Gm-Message-State: AOJu0YxhctBjgmrH1bM8wyxtbHb6Sq/itAJhJ5Q1aYPc6FkYVlF9ILEE
 jghfILQsn/UwnOWIDF2BSTLOB/gvWHTS6nzpymnWvVSz1CNGOjcTPnEp4CydboL0q/JC7rBgEE8
 m
X-Google-Smtp-Source: AGHT+IFjfjjod8QAHPWGkrl69VE8Ph6g7QURZbWUqH/8PIztjfs/mi2Ugipsw2PsX1Au+ZpTHtw0tw==
X-Received: by 2002:a5b:147:0:b0:dc6:f0ac:6b53 with SMTP id
 c7-20020a5b0147000000b00dc6f0ac6b53mr2080926ybp.15.1709319232197; 
 Fri, 01 Mar 2024 10:53:52 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 e72-20020a25694b000000b00dc701e0bdbcsm944340ybc.44.2024.03.01.10.53.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 10:53:51 -0800 (PST)
Date: Fri, 1 Mar 2024 13:53:49 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] dtoc: avoid invalid escape sequence '\s'
Message-ID: <20240301185349.GA3040305@bill-the-cat>
References: <20240227215138.236403-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tDhGkVm1IX7Ihawd"
Content-Disposition: inline
In-Reply-To: <20240227215138.236403-1-heinrich.schuchardt@canonical.com>
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


--tDhGkVm1IX7Ihawd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 10:51:38PM +0100, Heinrich Schuchardt wrote:

> \s is not a valid escape sequence in strings.
> Mark regular expressions with r''.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Applied to u-boot/master, thanks!

--=20
Tom

--tDhGkVm1IX7Ihawd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXiJDMACgkQFHw5/5Y0
tyxhFwv+JeZCGo0D9238ZHG0CaZaZXmlayeI8QoYvtolOV7eemZDKmLxsnLJgaNd
u4qwfOTx93dzmidOXPNQOksZmdzPsNgEEVS4QGQHGBAb0MnYZuS4gLcysMKB/kK2
SKMQjVx32Kh6S9d6TnMf4Cbb7m2utT/RAst4e79oIT7zlrz0D01rYtEo4qKQg2vg
S6II+UYkzQllSqnbZPr/eVgSRyl1QiqQ2CrS5Va+xvTt+1SzcmM3OmsVsa+NDxrj
SYGvivNoXn61qOpysD35JiIlKhJVp8w0VfqxKgqryq5ESNYtvJFTpWMAyGh+ZXnK
trLhxEjnhM+9NIS40FQmVKcdda3VP/fZuu2nz1xNHHOz3XvuDk9WkIcsrGci44v5
RXUNgk24RG/6+Y8fmwOsUyDlo55QfWCKwPOecGkLzb44/Q9VQL5qHZVJO1sigPuQ
VCLgWPPvZugRRRlJkwPbsspOZM6bkWKVcx03Bqt1zs7S7ejaJyP+1VrJCCYK92/2
Lacvlt1o
=CqHV
-----END PGP SIGNATURE-----

--tDhGkVm1IX7Ihawd--
