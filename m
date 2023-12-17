Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E76C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 17 Dec 2023 18:41:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAC8587D29;
	Sun, 17 Dec 2023 19:41:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N8C1aBkB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBCDE87D2A; Sun, 17 Dec 2023 19:41:00 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A0CE87D23
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 19:40:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-dbd085edf43so1024342276.1
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 10:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702838457; x=1703443257; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nABK1DajcwPlgMrm3B8LrZW2beYipvW6mTX2nB0X8c4=;
 b=N8C1aBkBtFhfw7Nty6L08mDUh6YFtnx36PO8Rio0inWgnzsYV70Kh8nSff8yDY3B36
 jbH0/XGRbG/NYerA0yy1i8WZvmO+9um61O/d4VXASDvAtJfLOeCb4UUsSYxu3izjKZUd
 3DBXQ9c8lh0jXEUCvJxnpRwCAJdOYwT7lWc/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702838457; x=1703443257;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nABK1DajcwPlgMrm3B8LrZW2beYipvW6mTX2nB0X8c4=;
 b=Ae4h8kuvGBQ+6Qjhun0hEf9kf682b1T31SUzp60ka+InNwzY1W+Un3WMaKleIx6yFc
 AiVchJ/4sQPyTYDIzgCsYNCmQgW6eNC8iWhzXw5b2zTFQbHmabqn5yhCI3lyanAMVcjM
 cfUHxozMS4S6ToPNjwdwkvHt/f/1v+sXn5lMTmVip7IqB5eETa4uCV4VHfFEPwKY9/z+
 NSi2onHqMN0eCAbJS22J33nB300ViHnn34U+aMyEJezMofR1Ft8m1zxHusivTy4jBsRG
 2GwNjaslIiOMPPcuFJN9s7E0d3BbRvx1iooCdc/AtXLWutk7sFwitKEmOKjaSWdC6IFo
 G90w==
X-Gm-Message-State: AOJu0Yx0jmq8OoUezWqqkTJSMnqNWwGXcg9CRSvJjARexMlj7FT6QyMp
 sy00DSgxjJxXNFWaPfUEBWJ5ww==
X-Google-Smtp-Source: AGHT+IFygLJ8RKsKJtwEe6U+X5QUIBF01lht/02Mll4EYc2S1/7Sxdjn4csENeJmHosgZfxa/D0lTg==
X-Received: by 2002:a0d:f583:0:b0:5d7:1940:b382 with SMTP id
 e125-20020a0df583000000b005d71940b382mr13003395ywf.78.1702838456930; 
 Sun, 17 Dec 2023 10:40:56 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-c7d6-a760-1f4b-e321.res6.spectrum.com.
 [2603:6081:7b00:6400:c7d6:a760:1f4b:e321])
 by smtp.gmail.com with ESMTPSA id
 p191-20020a0de6c8000000b005e3cbaa5ac3sm1461301ywe.105.2023.12.17.10.40.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Dec 2023 10:40:56 -0800 (PST)
Date: Sun, 17 Dec 2023 13:40:54 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: Re: [NEXT] Pull request for efi-next-20231217
Message-ID: <20231217184054.GB2513409@bill-the-cat>
References: <2836e8ee-2a9d-4d8f-848f-ce77ac8bf080@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mpa0SVxmHid0FH+1"
Content-Disposition: inline
In-Reply-To: <2836e8ee-2a9d-4d8f-848f-ce77ac8bf080@gmx.de>
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


--mpa0SVxmHid0FH+1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 02:47:40PM +0100, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> This pull request if for the next branch.
>=20
> The following changes since commit cd948210332783c2b1c6d10a982a80c0da4f69=
b9:
>=20
>   Revert "board: ti: am62x/am62ax: Update virtual interrupt allocations
> in board config" (2023-12-15 20:23:59 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-next-20231217
>=20
> for you to fetch changes up to 291ab919355df5ee28183546049d5fbdb2777d2d:
>=20
>   doc: Replace examples of MD5 and SHA1 with SHA256 (2023-12-17
> 13:06:48 +0100)
>=20
> Gitlab CI showed no issues:
>=20
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/18990
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--mpa0SVxmHid0FH+1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV/QLMACgkQFHw5/5Y0
tywEdQwArPf4GMAx8WXI4yffIcfadNCh6b0OuU0MKPXXqXq9ccEOfLzEApl3XJg2
sEKrQYDI9ALhaBlhCpnbzAHrOQ54//K7WnU3IskPjBqXzBRrFiSsIfXqCSCiXVgX
nd21YAGxD9Rn2EK/W3bSBX57mQYoQmW07+2LfDMZNAfBGM/IvFlV5epnTfFG/ya/
AKFkMTjDbfTWHGCyCdZioDqmrp120Ai7wHgxs+WUpf8bNcLS4mN9MCE+bvO/MW8M
+vPOLx0AF/b7kJDOE0FkrEhQO26u3Mc9Vg6i45D276Zs22jDfo7neroocOo1Miby
KuAfrybvxkVL4z7c3vQvLOXk5z/jSerBIDGsaj5uwHfms8dq63hENVsHrhEY2Pxl
i0B1Zin7cK1QHVJBiF6jkG0rV5iIk4zIA3X0FJ7TuV5Q7lcMHbQ2/WZ1JiJZDw5A
76iCSWLt3rXz5xuTSaeDw+MtvKGBnFYyMVWiZBbAivmKhiCz3KRqHNnolUw3BJRX
o/zgBm1h
=2SwQ
-----END PGP SIGNATURE-----

--mpa0SVxmHid0FH+1--
