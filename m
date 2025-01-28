Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59052C0218A
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 23:02:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8D4D81870;
	Wed, 29 Jan 2025 00:02:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b6W8cUWI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAB3481870; Wed, 29 Jan 2025 00:02:29 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BC5F811E1
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 00:02:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-467b74a1754so84072251cf.1
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 15:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738105346; x=1738710146; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uDsnhYUwLxNPNtg2TOMUy8mBJ0g+UlVjPV86Vj0LgAQ=;
 b=b6W8cUWIiwkTGL2K9lcR5wifpgkQC1g1U7BVn+p7ayUCOU/SQKefaO4NWMbMhx55Pk
 Y2DoD2mDVXXpWQgeOh+wKX8Nq40F3Qqhel0iffXDfOkQKWt0EYBfaRICnm2h7dKWIKOR
 ZqcgOwg4cpRsUEg3041nvHqxFsCRb+i0+cOMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738105346; x=1738710146;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uDsnhYUwLxNPNtg2TOMUy8mBJ0g+UlVjPV86Vj0LgAQ=;
 b=KVE0Jj9i8GqjvXeNUlZOECjxbpnK24EZ+gzNOCf+qVXaCXEM4+GSOVg9agpPq9W3vO
 85BHywRCiH7eGtqAgJ26D2U+wOSRM8A9dZx8NKT5+cLZXYzonnOfLVM5sdSBIGPYEteA
 LK2X2InkGcSq9aHRazagfSdz6+UUSCYnkcTUqNfVIH0OTT1OsxbQeGTEXmg1aAvxQuQQ
 agnbT5TK2iJWmQEzAsOII865D/AVhD0hUJkIfWAQJ17WVPxn09LS1tw5DRFmdf17PLa9
 pQs1g2xpU+O5v5H6keYMOCb0azvZEVIIFi1ELMe3+i2z9TW1nYbCUEkbFbbk072oP2pf
 MUsg==
X-Gm-Message-State: AOJu0Yybv4E0QXuanLs1KdJ0awXYpKJKScH/91DvTa8o8jJvlXkfL/xY
 U85Wl8WL5titSYDE8I6fM4y+Trska3c0hgaULTn3QmNWVtYNoHloy3i6Qc2uigg5FO4c55KLt7Y
 7
X-Gm-Gg: ASbGncuLAvOX0XfyoV7BuHmBv29aEO7WgRJGgwpDi61zk5V3rX8r+8pxfc0mCCH0pJj
 rMwtOQnByQoeOTUK41hhIHIQKP/4+PY9at/nRR6yrJfuKwzGqXOE97uP6dKjQrVhcmnWKeM0lLx
 mNUR9x06Rh/bkp05yVJtBbY3qC7Mxn4Uhzbb+pNwxJAIutlK9BPNFEU8CsQQUHLkbKdyOlwke8a
 YgkZZ99hxqFT8krkJMRfmq7NqV9Uk6kh3YMyFHx4Ho9wS/AIboVqGtQ9VEVSllh1AW7qejGVXrd
 kwJngYwtRjXC4e0=
X-Google-Smtp-Source: AGHT+IHn/ggc5C8Z6jXctWNeq9Kj9FEperSH9f6amhEUN0sOhs03+ltWLbkKZjky2ukk0+WGCIh1bw==
X-Received: by 2002:a05:622a:14cb:b0:463:eef:bab4 with SMTP id
 d75a77b69052e-46fd0accc23mr14093561cf.26.1738105346076; 
 Tue, 28 Jan 2025 15:02:26 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e66b67dd5sm55974531cf.51.2025.01.28.15.02.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 15:02:24 -0800 (PST)
Date: Tue, 28 Jan 2025 17:02:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Stefan Roese <sr@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-marvell/master
Message-ID: <20250128230222.GT1233568@bill-the-cat>
References: <e26044f3-dd59-4d06-b2d4-e9c9d0cf936f@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8x+JKTDamJA4ACA4"
Content-Disposition: inline
In-Reply-To: <e26044f3-dd59-4d06-b2d4-e9c9d0cf936f@denx.de>
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


--8x+JKTDamJA4ACA4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 01:57:40PM +0100, Stefan Roese wrote:

> Hi Tom,
>=20
> please pull this next batch of mostly Marvell related patches:
>=20
> ----------------------------------------------------------------
> - kirkwood: Enable bootstd and other modernization for OpenRD boards (Ton=
y)
> - board: solidrun: clearfog: enable ddr odt0 on write for both chip-select
> (Josua)
> - configs: mvebu_espressobin_ultra-88f3720_defconfig: enable full bootflow
> functionality (Ben)
> - Initial support for PXA1908 and samsung-coreprimevelte (Duje)
> ----------------------------------------------------------------
>=20
> Here the Azure build, without any issues:
>=20
> https://dev.azure.com/sr0718/u-boot/_build/results?buildId=3D389&view=3Dr=
esults
>=20
> Thanks,
> Stefan
>=20
> The following changes since commit a517796cfa5d8f4ca2f0c11c78c24a08a102c0=
47:
>=20
>   Prepare v2025.04-rc1 (2025-01-27 16:38:46 -0600)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-marvell.git

FYI, if you do something like this in your .git/config:
[remote "origin"]
        fetch =3D +refs/heads/*:refs/remotes/origin/*
	url =3D https://source.denx.de/u-boot/custodians/u-boot-marvell.git
	pushurl =3D git@source.denx.de:u-boot/custodians/u-boot-marvell.git

then the resulting pull-request email will be in the form that "b4 pr"
will see and grab. And if you put the notes in the tag I won't have to
copy/paste them in (and you can amend the tag with the CI link :)).
Thanks!

Applied to u-boot/master.

--=20
Tom

--8x+JKTDamJA4ACA4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeZYfsACgkQFHw5/5Y0
tyyPdwv+MkiPVq6xBqCkHTuFC3EvG5macUe0nsmlHtfEBIhHX6l8i5F0GPUIggds
0yRIEgovS8WHoEKFaXa2lKpsDCY+4g7a/pBByDPfzldFbwM4XPDkjzdXvjmZ/9UA
mVtneKZQXH7YXLor/PNQieQQLX/4VccwPoVTZy7SPYkZxac3bFMs0rNr09XCLl0L
X4lQr22LjIzXEMEVndnVY1ufjFcf86kgcE6N6peUHk6AGcgoQ0yLH1jiUhPJr159
vDzcvp90gBU0fsnSHEQBqEGCntKGrJ55gJRdskfxTtzcS++A1yISbkQISf1ngba2
jigA1CyxcaBGof9fRW5hKhAF7LQ9qhF6t/BjyMyQ/UIeLR4va3vIiz8zYuXyJYUh
AKeZJlWEVhtjPj6pTW13FhtNbvngvybNOQzM38uKzm08YJtM8TDKZCWqh/ExCkQW
Eu8VZZJUgpVIdYL4hKZlR7mWu4qYxShTutqkiUSNIF9a5TDDAgD+6hfA7Sgjyw/r
FDx3xl0g
=lHZI
-----END PGP SIGNATURE-----

--8x+JKTDamJA4ACA4--
