Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C38DFE7491F
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 21:00:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B483B86DBC;
	Mon,  2 Oct 2023 23:00:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UUBjeJJj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 148B286E16; Mon,  2 Oct 2023 23:00:29 +0200 (CEST)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C788D86D56
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 23:00:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-d8162698f0dso237996276.0
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 14:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696280425; x=1696885225; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aYpZ5qwdsHqTDapn9VjI5pKK13wpNEmLuS5Bnuih5o4=;
 b=UUBjeJJjxie8ZumuGYJr5hjdMVsbaDI9+ZRLCyRRn2ojR1lx8AAYZgUWrOFWcXenjE
 GuVqfbwDy+dAERhmLzliUNaIdOTQXJ5MZV5MVxjrHyWvqwCXYRU0VRdxO+MwUisLIvBa
 luPsvHAMAahGIzSGDIXiSQLpvANj2OnzGJPNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696280425; x=1696885225;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aYpZ5qwdsHqTDapn9VjI5pKK13wpNEmLuS5Bnuih5o4=;
 b=JcNbCJA2N9AXGypSj7FrD9AWGLshFd0FinWkjAH3QyRxtIRnaCWYIpvRoIgUhlxir+
 gSFPBLePP2TSH0JH5MOtXWBEZ03okR8cYY7LUzp2hraKvggsn2v+NHZR9PaRO3YekaM3
 NoDYNz6kzn+49URKVwcW8ZYsac1qJWx3+XowWLpg3kWRjRJfGDKwc6YDeSfS94aA5I7H
 B0fEluIW+LRGurBVxC6SyhMp8ZHh91X/6MR6Ym9eBYvMG/NyCgqwsiZbVQAHwM6DN8rc
 imhecb5MCeLR+i/94w7+y1n3m524WlMpP6j+/iZVShKz4WWXMIYoya2ZCvNcptohchCS
 jtLg==
X-Gm-Message-State: AOJu0YzgZTQy0odFED5ebPBo0Tm1pni78gsuZl5s/aDJig6XODq/noTh
 SnmvjMdP3y/B95BEpiW9l3i0iQ==
X-Google-Smtp-Source: AGHT+IFC9mQhckARMp8fyLbTTbsae732jkaBog7JrbOqYyk6Bg7RXxwYZy9Bxt9It5CR6VddFMnJOg==
X-Received: by 2002:a25:3747:0:b0:d81:65a9:ac6c with SMTP id
 e68-20020a253747000000b00d8165a9ac6cmr11444901yba.24.1696280425289; 
 Mon, 02 Oct 2023 14:00:25 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1bd6-f13c-2029-607c.res6.spectrum.com.
 [2603:6081:7b00:6400:1bd6:f13c:2029:607c])
 by smtp.gmail.com with ESMTPSA id
 n80-20020a25da53000000b00d217e46d25csm7167187ybf.4.2023.10.02.14.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 14:00:24 -0700 (PDT)
Date: Mon, 2 Oct 2023 17:00:23 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PULL] u-boot-sh/next_pinctrl_sync
Message-ID: <20231002210023.GA8465@bill-the-cat>
References: <20231002104756.6132-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+PjK0C3NGHrGP/Jo"
Content-Disposition: inline
In-Reply-To: <20231002104756.6132-1-marek.vasut+renesas@mailbox.org>
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


--+PjK0C3NGHrGP/Jo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 02, 2023 at 12:47:56PM +0200, Marek Vasut wrote:

> The following changes since commit 90c81f407dd4a7747385b10f9b8f732202c45c=
de:
>=20
>   Merge tag 'dm-next-23sep23' of https://source.denx.de/u-boot/custodians=
/u-boot-dm into next (2023-09-24 12:43:00 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git next_pinctrl_sync
>=20
> for you to fetch changes up to 30c210b9bee474d3ca5803f866ed07a6bac56fd4:
>=20
>   ARM: renesas: Align env eMMC device number with Linux 6.5.3 DT changes =
on R-Car Gen3 Salvator-X (2023-10-01 00:08:29 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--+PjK0C3NGHrGP/Jo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUbL1QACgkQFHw5/5Y0
tywg/wwAos/9wYlL0cmZotAjugp7T/+QUq8QnuhwNjpa+yyNK84+h1dzV5RU/tAu
A4CY3ORi+zvdUyYLDg2lBsKiSZkyeYnkMlzUFIw1M+2ECoOzeLWW6TUc1ywrI2Q/
phS6AlJb97PGQ6In39qruIcxTC5eGKu/dZi4cepmyBojOIn5yT0jPMCbY7eBFIW4
wZJA6f9aCv/CRNY45G3pNp69uW5c53nCMj2IHc3Fnb5xN3MvZB3UgmrCvZRvjlTx
FKGmBW+M0fhckTluYQ6IRwn9EADPPpGz5QeBTYflh6xSVVQDsfm/AuZKGchWT/rg
v1icxGsfFjgabU1L5RFAgUUecCyU+vTi/mqdJCZkOpgkcUMxJV8gI3ImRP9E3ov8
nb+/zm3ADZhmjhQGo4M82FaSBwTRMjbEY6AApptAXs4RwL4lMa1uKVvHWqXBdYdV
biMiPlCGCup+8sk4j29lemJzgyUxZvtF2cna84RzJrsiyMmMmD1aCMhaGOD8Uwzm
QsvsFuJu
=0gac
-----END PGP SIGNATURE-----

--+PjK0C3NGHrGP/Jo--
