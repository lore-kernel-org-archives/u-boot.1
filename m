Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B87C27C40
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 20:49:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16F4B87652;
	Wed, 22 Nov 2023 21:49:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uK3MwWTv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B631F87627; Wed, 22 Nov 2023 21:49:21 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B785A87646
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 21:49:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5cc642e4c69so2102247b3.0
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 12:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700686153; x=1701290953; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=W90QXfWZZeoUJemJick1mtxGm6r4q8Y81lJiSOCu+OE=;
 b=uK3MwWTvi8aHCAP/o/pgZ7cg2DgInrvyAg8tgUTQXJyaDQ1kMpYf8AsxyOZHEpHKoB
 b2CBP64k5D0/iAv+glDUTtjNdlrJW+3DaCukML+DtyC6DS1nlPSrfbay1O1wRWCpYDW9
 t51dSSDCQLg4ovFEqxvc4BD/ykUyvf4/bXW/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700686153; x=1701290953;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W90QXfWZZeoUJemJick1mtxGm6r4q8Y81lJiSOCu+OE=;
 b=qwnyfcDv5csXBmybwUYkRuG6uAPTi2gTwrB5ai7vS+7rJEdf16G+blv1uH4iaslK1w
 9cfQHf6i+yMvtp/V066+uEATOZTRmuQPwfVl50RIevl9mydYBuWwMHeImxyKnCqkuQeT
 E4gFpWPTwpw4NhJAueo1pFUnMCr0S45777Eqj7E/XBRq7jdmp/EgDAMJM/UIG/giw0h3
 eHw+VGXxy3ZLzQMUaa49vDUifxxfLLODdnuOJYc90Jp2xIPTY0eaeEO0u2Lpu9ySw2YY
 aMDq97a6YrqEs6ye2VtxMwoNzgT4UvgWRTuPChFDTKVfI12utOUI1daVNq5dIMUcHKNE
 dZLA==
X-Gm-Message-State: AOJu0YxrUp6AyRbcZNhf1Fe5IiprnoPYu2Bvfnq/Kkd7u1FpXI0gom7U
 hdSpNTLqZpRpi3cP/ej/7jGZtw==
X-Google-Smtp-Source: AGHT+IGzb+YmVt9RBpKDQFpgklAiZprfrHK+WTKzRTiSW3uj7Ertj/Gcow5DynBZlWjbVIWWJaboWA==
X-Received: by 2002:a0d:d692:0:b0:5c9:e98c:a6ae with SMTP id
 y140-20020a0dd692000000b005c9e98ca6aemr3362503ywd.4.1700686153418; 
 Wed, 22 Nov 2023 12:49:13 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 o124-20020a0de582000000b005ca9e337e2bsm86730ywe.112.2023.11.22.12.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 12:49:12 -0800 (PST)
Date: Wed, 22 Nov 2023 15:49:11 -0500
From: Tom Rini <trini@konsulko.com>
To: Andrew Davis <afd@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/3] arm: mach-k3: Move R5 specific code into new r5/
 directory
Message-ID: <20231122204911.GZ2513409@bill-the-cat>
References: <20231114155950.296644-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XFxzXpGmWlB7w8m7"
Content-Disposition: inline
In-Reply-To: <20231114155950.296644-1-afd@ti.com>
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


--XFxzXpGmWlB7w8m7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 09:59:48AM -0600, Andrew Davis wrote:

> This makes it clear these are only to be used by the R5 builds of SPL.
> And this will be used to later more cleanly split the two builds.
>=20
> Signed-off-by: Andrew Davis <afd@ti.com>

For the series, applied to u-boot/next, thanks!

--=20
Tom

--XFxzXpGmWlB7w8m7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVeaUcACgkQFHw5/5Y0
tyyV8wv/SxBXvclhYb3bLw4/vCx1rNT00nfM9bfXDdll4+Ft9PqxtF6SXiIA18Pk
U1DtOOZoUI6S5mKhqTokNQA1cqSbNmDc2TJcBtVXx0ZCudMuY59rjlvxbtsSmnQh
NKV0YD//a3kXnoey8hcqzOH4lEN9qHTUhGQVCcBVOp32geFhMRMEtyHt+grWnVun
PD1CBwNuCS/+4D5K06KSFsueuTfEA9CN+IeVvLLfgur2snv7kvijzBsRaeYr1ZYU
a1dPc42Duhi8OA2rzOi7ferDm8r7yPmKZ0RufNtp06pE4ZHCJw0DwcoeXNtNsWR9
/jcbaNwwBIKjScz6Tbn2yW4KwDHAMW6wPZWu9rnyTGTxbEQbXXN7VS7+j6vbg9wn
uFufXrQGmIaf/9Jxkhapv8T650zNbSiZdRnUaU9rcATlH0TK1DDxJ/NRNsYd3GYg
bwx0JRdITmz0h4sGg6fGIRhwnRtpdm5e/64kQzwTbj+GqUGA8C/q8ZZWL/By+b/w
tJSr3fWO
=9pnG
-----END PGP SIGNATURE-----

--XFxzXpGmWlB7w8m7--
