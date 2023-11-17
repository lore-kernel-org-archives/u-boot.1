Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D6DC54FB9
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 19:43:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33548874DE;
	Fri, 17 Nov 2023 20:42:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BQJvcvHn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46FE58749E; Fri, 17 Nov 2023 20:42:28 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 802E8874CA
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 20:42:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-41cbd2cf3bbso30266781cf.0
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 11:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700250127; x=1700854927; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Pkvt6BAYUOcYQW3gYm86nD6geEHfyvNab2/Q8bY1ebY=;
 b=BQJvcvHnhVZVQEJGKpLRjX9Q1j0gzVhgbQfud0i6R9sPfNF0YE0BLE9V7el3ZHkkxd
 8KO+H/IXGimMzFp/4IZ5ab3aRGhuoYgBtKYG76ZS4xiaXrvRbIDsuyjg8rzLX7cw/LF1
 n6xgpGlc5i7OjCt1wsk5dse4N8A0Yr7qDUtIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700250127; x=1700854927;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pkvt6BAYUOcYQW3gYm86nD6geEHfyvNab2/Q8bY1ebY=;
 b=r/zY7rmMDcu3GBkeVDAaZMjNB0yJiLFihYBfWpCO+EYaYUXx/WJJ8n7e7wpt+cI/Vp
 OqJThTSmlsN2n/OKYiIEGF+YCgLOiqVFVfJUSrBbfGAoxCdGjzvQV3y7Lrf6Gw2IfWt1
 No8EgGgmEP+O+yN0evfmPw8AVMEASoyuU5LXCampxRY9NeGM5eYAGOFBWn+X+lBNFEhd
 2D+hnUqCNraR25LyR4/bFWlkm/+bLxV4zEHDy1K2Pkdq56qORkpBjSeJxdBbe20VVkKw
 z2UxRVhDS0LTj4rsOfy/lQqb4cWr71Kr78uM+3fYVxebfpk7QQ7svMTBbu/5YFqA9dA7
 i5HQ==
X-Gm-Message-State: AOJu0Yy+OI6cZd9csk4KNdcgtBe9N8PcHORoWlseaOgq84TGGZiC2vlD
 3lmWVXh9yAN2pcRaTMBPFVeTPA==
X-Google-Smtp-Source: AGHT+IFa1bt3Aui5Gh/ZKABtaeB6wNpOo5tD2yTpuCaMfWDBY5QvJqS4a7gxhE8B2kp6uwyT+zR2jw==
X-Received: by 2002:ac8:5845:0:b0:417:b53d:a898 with SMTP id
 h5-20020ac85845000000b00417b53da898mr448287qth.9.1700250127304; 
 Fri, 17 Nov 2023 11:42:07 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 i8-20020ac84f48000000b0041cf5ec8b75sm782992qtw.96.2023.11.17.11.42.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 11:42:06 -0800 (PST)
Date: Fri, 17 Nov 2023 14:42:05 -0500
From: Tom Rini <trini@konsulko.com>
To: Marcel Ziswiler <marcel@ziswiler.com>
Cc: u-boot@lists.denx.de, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Stefano Babic <sbabic@denx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v1 2/2] imx: spl_imx_romapi: fix emmc fast boot mode case
Message-ID: <20231117194205.GT170968@bill-the-cat>
References: <20231026073220.244387-1-marcel@ziswiler.com>
 <20231026073220.244387-3-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ggMmqXVALcgHzdY9"
Content-Disposition: inline
In-Reply-To: <20231026073220.244387-3-marcel@ziswiler.com>
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


--ggMmqXVALcgHzdY9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 09:32:20AM +0200, Marcel Ziswiler wrote:

> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>=20
> This fixes a regression in the eMMC fast boot mode case where the buffer
> was missing 464 bytes.
>=20
> The code figures out how many bytes must at least be fetched to honor
> the current read, rounds that up to the ss->pagesize [which is a no-op
> in the USB download case because that has ->pagesize=3D=3D1], fetches that
> many bytes, but then recorded the original upper bound as the new end of
> the valid data. However, this did not take into account the rounding up
> to the ss->pagesize. Fix this by recording the actual bytes downloaded.
>=20
> Fixes: 4b4472438f5a ("imx: spl_imx_romapi: avoid tricky use of spl_load_s=
imple_fit() to get full FIT size")
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Acked-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Applied to u-boot/master, thanks!

--=20
Tom

--ggMmqXVALcgHzdY9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXwg0ACgkQFHw5/5Y0
tywyVQwApZNy2XCSLHmYggJ3r1DlrVxPjq2cdEt6tupQrwPdyRKuzUFYP0Ojk4az
8ko4taVrbJ+dDGKfqlqH1XKatFFNtVkDP2xH6QIXaQa/TjqBq5cbPGQ4v/ic6h6c
xEAyfkTP8pv7w7wn9vzdksv9YJVSGzFsiW00s+TyWLJAo87I7SiX1Zt9rXuHRRn4
2L/GifEVNehYLjpDQhRnlZEmWjCxYhYGJEOBiScT3YrHYG+h+rCC78AcOFnHEa9h
yMSP7XWe05F+1QoV6cjzbbmztDKBrWnFATZ/qEDjbI+aB6NYkbYhRXX8DAQUbOEs
OO1NnqrIue0D5C9Da9EUBG4T7IgxJ5Xzvb1qBOKnNcBX4skkcTaqq48JP85Br7sm
HWoig+xMuPDEaEa6w8KlqFiApE5oWBXa7wY8trGceKiei3jAZyxb3ypSzOBUH5Pd
txmRQKpw4lgCQv2Owo6nwdkxwAX86TTvQgxLH2LVOHLjnSmLQCQARVm7QJuS28Hq
zgeNlpg2
=X2Pu
-----END PGP SIGNATURE-----

--ggMmqXVALcgHzdY9--
