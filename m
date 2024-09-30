Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1B6CE8372
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 16:30:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB73688E00;
	Mon, 30 Sep 2024 18:30:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CqJdLtHi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B550A88E07; Mon, 30 Sep 2024 18:30:50 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F83988CF1
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 18:30:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5e5a0519d00so1958722eaf.3
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 09:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727713847; x=1728318647; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9yWxlzNGbz0gJ45EQq1aQlRj1Cvu/8CPRFXeLe9A8b0=;
 b=CqJdLtHiij6bHSxQvUHunLdy4pggd3TD0UJoZNYfvMQ76QXt7r5siTlnPqxkm1XVQO
 DmuwvD00LoYtuHrxdzYh5DrHr6oSOLvfrj4Qp5G806SVj4/pDacJgnYfIJAjMOcWs4ca
 J7yKFi3dMHLs5HJP5DJ43SBIWyPemPgYjEzxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727713847; x=1728318647;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9yWxlzNGbz0gJ45EQq1aQlRj1Cvu/8CPRFXeLe9A8b0=;
 b=u3LJmFFJyIc9Qpkqv/6nY2kn3W6kk5PPfC6HPEhf9P/8JuVU4mnx3v08TkNN69KjSm
 8NufsAgvdqXyUTF07MewK/148VUH8mePyYhevenKT++NnIb76+nXo/at2ZcF8IfNT95K
 bAWNTH/JHGrwnUpUAGdcL0GI0Ko9k3OB8cVB19FfxWl/l79yIHLZciCdJi2BW8ykDHMe
 /dqdos1Za9+lBhUJ0wbg3GHqwFzTsvPJKDabkz59MHp59K0PbjO+Rd4PVYg35vvk5J1N
 m1LCWJFbFsHjX0oQkqmyb0ePYpl8HSzwDIIvymQ7CWuW4CuPAPtMegarKYXqtGkT2FwL
 1YnA==
X-Gm-Message-State: AOJu0YwBD472mekq7Nh808PBa2mvqFGilgwHqWpRlGG/A9psn00We7v+
 wmZtOjWcg+tEYRWSrFPvnq1PS6S0OpYklVi4DdnPr45vW5yF4vnyCEY+uocYxd7opUk/dyRXzMl
 F
X-Google-Smtp-Source: AGHT+IG0NSOHPtTLfu4/KffV3LknZdg62ASKIfAcew39wy6fpcw2wC7acH5w8xUstm5O9d27dk8Uhg==
X-Received: by 2002:a05:6358:2d86:b0:1bc:2d00:84ad with SMTP id
 e5c5f4694b2df-1becbb38c67mr350231755d.3.1727713846830; 
 Mon, 30 Sep 2024 09:30:46 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f36337csm37347301cf.96.2024.09.30.09.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 09:30:46 -0700 (PDT)
Date: Mon, 30 Sep 2024 10:30:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de
Subject: Re: Pull request: u-boot-rockchip-20240930
Message-ID: <20240930163043.GD5579@bill-the-cat>
References: <20240930091424.2696174-1-kever.yang@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RowyH7+J6A9vSK33"
Content-Disposition: inline
In-Reply-To: <20240930091424.2696174-1-kever.yang@rock-chips.com>
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


--RowyH7+J6A9vSK33
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 05:14:24PM +0800, Kever Yang wrote:

> Hi Tom,
>=20
> Please pull the fixex for rockchip platform:
> - rk8xx pmic fix
>=20
> CI:
> https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/22470
>=20
> Thanks,
> - Kever
>=20
> The following changes since commit 596465138175cd7e4171cad1e68a2ef7c5c002=
bc:
>=20
>   regulator: rk8xx: Fix buck get and set enabled state on RK806 (2024-09-=
27 18:20:49 +0800)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boo=
t-rockchip-20240930
>=20
> for you to fetch changes up to 7210de40a25a222043aed1348ec667a5ccc204b6:
>=20
>   regulator: rk8xx: Use buck variable consistently (2024-09-27 18:20:49 +=
0800)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--RowyH7+J6A9vSK33
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb60jAACgkQFHw5/5Y0
tyz44wv+IXevEvu4fcCYSAQ86wHlJe0FDR3o0cBlmqVBdU447f/Aa+UQP9f2eJ8c
MmAqz/kEeRMX2F28JdjTpEiW9W2SAAAOC8bNREzbFc5xnVcHCC8Z9peDJ6wD8eD7
xkgoO79+K6G+ot0C9uCJbFSam0Et1TYM6l1gvjuG73RG9TTFBkHXMWpXzoyrGNJR
Mt6gD9NLrv/khKZIDRgX1XNy2wHsJBpFmb1Dh+JbH+kAENmLr+hv3S+3s1GjgCAC
lik2q7Vimwl4DLQt112Th0f3LvoXXGXAKN1QbXIo5Th7N8+XbakVlel1GBtpzgXg
b0trOfEP36fOKHMrD5sCUGv13lc89zuHxLEPR48qL+zvsftGeL2KJnVkGYGYXvv1
ZQw2aJcyhh/7hzIq2YlJWBpZqLVnEnVWdLpUlPP8Q+Ug1uGqUuSiJxkX4FCJkbXY
HNjAhuX2SXxTY6ldsNS3Gh2InNh8xe16oJB/zkczCVBN+yyqtDlq8QqVfBSxQvk7
NudeAVGM
=URK5
-----END PGP SIGNATURE-----

--RowyH7+J6A9vSK33--
