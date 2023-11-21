Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A6EC61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 15:24:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37F6C87582;
	Tue, 21 Nov 2023 16:24:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s2PX2dY6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A7B987545; Tue, 21 Nov 2023 16:24:51 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A53F587480
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 16:24:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-77ba957043cso362994085a.2
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 07:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700580287; x=1701185087; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EPAjyw/B+Cpmq/3UrkrY3iKnYpKCHEj5VlztPXUr+SM=;
 b=s2PX2dY6t/AC0l9vM2ckB5zjRVCKQAVZ9FAtZBrtx1knU6c/FeTW1UzYAeCAAhWbD/
 ZtTabhvMU6ZyMCHfVUPKfiuT1LVl1BTY//PV74fLBo9R2rPBY0uFGc4tGJLfirW2TVgx
 +OBp+a/U4sCvILuWKL6NaJnNRjR83etKUkMqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700580287; x=1701185087;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EPAjyw/B+Cpmq/3UrkrY3iKnYpKCHEj5VlztPXUr+SM=;
 b=msdsALZgrm48WPSYlXZCKYE1Nomst5O0qB0px7zc3cF/RDFgkyqoivIM41MZYzqzgN
 s7ve1GaHRFFiAwmfbwyjshB69mdbCqUna+nFV1mNoXayguesuSd0d5BrJgsyDb87CsJi
 vlGupGctKd9wsBKqtist1wFGqkZzfqwd/Mex3kZE519jrU2Iye6Bv8C3zd0x897SIawE
 wwdXla11fDpWRv+FDWYkwdM7hR08IcgN5hwxwa7JbZQ3+phXvtbKUPnsCx38SVue4r7U
 EcgGEyu8xdayrpgdJId2kqLx/vhDODnR3lgf39fZFnp7I/37fNQvIay4RF7uKxaIhlK/
 sQ+w==
X-Gm-Message-State: AOJu0YzckhPOke88kN+Ahz9qbE8DMbIQcl4YIWZLHDqUx7aReuXBxzba
 /DdUMKcR3LPCPoUMdWj2DBMa4w==
X-Google-Smtp-Source: AGHT+IFN70FRdNwyKQVMUYhxnxaS7XxP7CfIr6qLgeGG1D6WUhjw+U4QWwsiLgaa8jnmUkBwKMthHw==
X-Received: by 2002:a05:620a:191a:b0:76d:bb77:b295 with SMTP id
 bj26-20020a05620a191a00b0076dbb77b295mr12421510qkb.78.1700580287365; 
 Tue, 21 Nov 2023 07:24:47 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-92fa-6f17-75b6-6213.res6.spectrum.com.
 [2603:6081:7b00:6400:92fa:6f17:75b6:6213])
 by smtp.gmail.com with ESMTPSA id
 bm20-20020a05620a199400b00767e98535b7sm3683391qkb.67.2023.11.21.07.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 07:24:46 -0800 (PST)
Date: Tue, 21 Nov 2023 10:24:45 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Pull request efi-2024-01-rc4
Message-ID: <20231121152445.GW2513409@bill-the-cat>
References: <d35c315b-4106-42ea-b017-01c16d32b9e5@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SmalsRcLiFZWufqt"
Content-Disposition: inline
In-Reply-To: <d35c315b-4106-42ea-b017-01c16d32b9e5@gmx.de>
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


--SmalsRcLiFZWufqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 03:34:34AM +0100, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit 24ca49b33af98d54d6cd2e845f071f6565345f=
fd:
>=20
>   Prepare v2024.01-rc3 (2023-11-20 08:43:46 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2024-01-rc4
>=20
> for you to fetch changes up to 64658007f3c61e32bf241f3048a23b1728774d57:
>=20
>   cmd: eficonfig: create shortened boot options (2023-11-20 19:06:22 +010=
0)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/18655
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--SmalsRcLiFZWufqt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVcy7cACgkQFHw5/5Y0
tyxsFwv/fvhdnrR3AMoRnxlVQbGIZqVc+fFUNLUwnL0iq9Y0CR71sgNUQihPwMg0
/r+adYpmRMWAd0+c0mjLv9vYLnCpRF0gJKk4OBP1DS1yMZ53AbuRRtmTxYqn2v/L
nOkQumm6Xrw4hVLdIn8t9JBVOyDZ71jMX+F/IsYpcnl4aBmLDECF367lnYp1g7b0
lfNRepbfrZrgm3SWUmdPLUSQ9aOkyhdu3zYWZHg6GY9f7RPcAD2TLYqA5tiVjZ26
HYMwNv7Wxlpedp2grX6E76CGLoAtmPf7+yzqiMZCAKSUcMAACtoaJutjcCQJDkO4
G6k2NvCDrKAyQ5Lg7FUouBrIi4t/dEl6IatqlSUqtAi1D9Aj514tKCtHFasMEUQs
YtYpPb6wS7YjiKABX2KGRofmS+LF5FM7AZJCbCWNMjDYntjI//NVjeViVx6LXCDk
73+uSdK1TtDtCJMOfcN44pts6MkNxEUubKAcBZqWiowNxf9F89EG4z/O2JwtWkQ4
VfX3k2fE
=M/6c
-----END PGP SIGNATURE-----

--SmalsRcLiFZWufqt--
