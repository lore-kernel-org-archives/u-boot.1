Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B78DEC1136
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 20:38:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0C7D83C39;
	Mon, 23 Feb 2026 21:38:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dj/u7jQ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 019B983C8C; Mon, 23 Feb 2026 21:38:49 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFA4683935
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 21:38:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-463967f35d7so3017452b6e.1
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 12:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771879125; x=1772483925; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HFwJvf62QJwGuB1yIwNr5af9+pab1wGIHv7xrRb74EU=;
 b=dj/u7jQ2aoaeDAgUbOXuJ7Yk25b2wUpYKb/CDYhIUKgPgjB9LKJYcNAzoldGVwZ24K
 hGHzanMBGhb3HV4LIn45WNze1YE2/FAUFXwBhEaBFxSEbE9MJEv88Wm7YUM9OdvcxK7t
 dMuFc0SnRiUFJbGLimbSdxtfHCvm8MTi9xMc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771879125; x=1772483925;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HFwJvf62QJwGuB1yIwNr5af9+pab1wGIHv7xrRb74EU=;
 b=OtIgicMTYsTdp89HZIc/2qSg9gXOTINEgRQ88x9f7dq8U0xhdaWI5NqYDzmrkp5MzB
 FnO55DHchVkKW7ElALRVNwHgR61GpCOvMDiDc73UNs566flRAJfzQysJv54bX9fyh+AM
 FEFi2faM02L9ub582Xxwv4unm1bvrDRkgZGWjiVhoJEdelx1stVaI0qTx+BCkmYsZaL4
 L6CfpgbpfqL8zk0DuYW9QzrELREBnhjdPFbc9H7WnvKog5M6JpAkvPtK4Ux9bUz5zgF4
 mvcl0LZPdPIrjFMy+22L4znRo8HmoJQbQ5g51U3apEB/MN9VXax3fcgvcoUfOM54fym2
 srDg==
X-Gm-Message-State: AOJu0YyMsZDiydIIuY7XBuGIoD4SmKhRZhZwMWQeA6PA4Cqi2RBCwfDd
 hmjCF19uVG7FmSiJ21blP9uQvHc18RQzoZkoIhV0KMvZdb59WYuDVZUDO3aNJRClDV0=
X-Gm-Gg: ATEYQzy8OkxPM1wPZjb2CVRIdoyDDHIu4QB28kgi8586nYpm5V8gj0Gfg1OO9X9NOte
 i8sV1JAxoguyHEdWwk6NMfyuZqldrUipeOIshQ/BIyqPmdWNvjplES6u7lKjYvZ+Zvicfc/CeZ3
 /p4G4HZLaoSOoPgDwcjN/51MywS5i0WSidt6PPuqZ0hb1Cn2eh7asoJZq5RceDVLdZUm5JEjWE4
 HqJJrV9W3YwtlF2DqVOIZ9xiky86zJvW3lATw+ZAm4QvEj1yLNamTsZl6PQk6+hsyEI1T+N9zjZ
 S7wCaP059M0+bejWG0rHZzZq7UJlShaYe40jjK1IHW7mX6vf/VLXWQX35wLFI2OoXY0WTgr/+vz
 blyPwHABkdikY2sx6xeahLXw9A2zvCK9K6Ighz6wCzWN6tCOkMlS2M65M/03UyLIMMvyorHecd3
 d0YRmJUcfpbLQldcmmbEWXJMa5IMT7lDTvutgyR546SN/YnEWUgf6isTC+Yke5md2XJFHlKHguc
 jy+0O703JVso/Sx4Tm1MqZBIKgI0hhoU7ifXqfnc1FjRpssFrc=
X-Received: by 2002:a05:6870:a1a2:b0:3e8:8e56:6718 with SMTP id
 586e51a60fabf-4157b20c686mr5577553fac.52.1771879125350; 
 Mon, 23 Feb 2026 12:38:45 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157cd54ed8sm8140929fac.1.2026.02.23.12.38.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 12:38:44 -0800 (PST)
Date: Mon, 23 Feb 2026 14:38:42 -0600
From: Tom Rini <trini@konsulko.com>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: u-boot@lists.denx.de, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 6/6] fw_env: drop unneeded variables from flash_write_buf()
Message-ID: <20260223203842.GI3233182@bill-the-cat>
References: <20260221100011.29049-1-zajec5@gmail.com>
 <20260221100011.29049-7-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KJks+Eb9Jtb50aue"
Content-Disposition: inline
In-Reply-To: <20260221100011.29049-7-zajec5@gmail.com>
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


--KJks+Eb9Jtb50aue
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 21, 2026 at 11:00:11AM +0100, Rafa=C5=82 Mi=C5=82ecki wrote:

> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> Recent cleanups made some variables redundant. Both: "blocklen" and
> "erase_len" ended up being used as temporary variables used locally in
> some short code paths.
>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--KJks+Eb9Jtb50aue
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZy60gAKCRAr4qD1Cr/k
CgvnAQD+wb069bEvFw08sNQqSzkA6tw+UWfWN3tHfKwThod7+AEArlWEiw20KIAO
anp1QIXJT0uW+CCCe/zlVqCXuu1DhAg=
=EFmj
-----END PGP SIGNATURE-----

--KJks+Eb9Jtb50aue--
