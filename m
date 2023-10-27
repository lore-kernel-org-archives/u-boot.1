Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64218C25B67
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 00:54:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95F1287550;
	Fri, 27 Oct 2023 02:54:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jv621sw3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C17E3874D3; Fri, 27 Oct 2023 02:54:28 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AA1087550
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 02:54:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-778a47bc09aso111375385a.3
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 17:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698368065; x=1698972865; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0uPVK03P+qYEUdtCwkZbTI/Pjcvrcj34VEjugBisGI8=;
 b=jv621sw3tWEBOINonHs0Qg/V6E0Mu9cESPXobDXQI0fzFPqn4/9xm5t65ylMm5t9jB
 Ln+6SNTCF3k2saqRZNopi1Dq2cnxET3PDFofxWnbNwN2tdVQ3hHPqIiwnobmknXgoYNe
 HLGGi3dGR2xfDnlZVT3XxngDbtH7P4YFykn1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698368065; x=1698972865;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0uPVK03P+qYEUdtCwkZbTI/Pjcvrcj34VEjugBisGI8=;
 b=s4iVT4k0q7KG6RLHIu1IHi0R+V/NxY1SOJyO2JpvLi8w/vU1BYblbPQOisuWmvxy4J
 2x8XYW9+4y7FozBqGa97MuC1G2Pn3wc7PK3fuaqtcaYa+JSs8DCZBq2QUCrxKqM+fZSL
 c3Vv60eOoBaehpF/EN6vSSO8LjFXXEWXuXhweJn01Q4U5ThEOhfP/xEBG7dAS5Kk0l4r
 AtJYptSBlkOigqM0SwLgAqVEzl8Y8c/r/2J9n6GwU4kOQptOQbI4QiVIXUhVowQjq6iQ
 tm3HFBKvMTAD5/rVECwMnX3/IVtS4z7zLslBWuvCpAthgaYdbTRloM7FsxfACax46eOW
 cqdg==
X-Gm-Message-State: AOJu0YzdAKYXN0YyQJmTd+k/eXUv7uH1M0TRE8H+KD55BJ6HIV51cOz7
 1SiXVoQJXtjOgcIdCMt7egMDNg==
X-Google-Smtp-Source: AGHT+IGJZPEzPdYTgKCUd/MMyVNOtENdgSKmFq2rFzCLa0+UN+ZgfMamZ8qhOb9l19fLFlfGiekexA==
X-Received: by 2002:a05:6214:1bc8:b0:66d:3300:a51b with SMTP id
 m8-20020a0562141bc800b0066d3300a51bmr1607077qvc.41.1698368064825; 
 Thu, 26 Oct 2023 17:54:24 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6a0e-a72f-3fdd-31b7.res6.spectrum.com.
 [2603:6081:7b00:6400:6a0e:a72f:3fdd:31b7])
 by smtp.gmail.com with ESMTPSA id
 es16-20020a056214193000b0065b0554ae78sm204866qvb.100.2023.10.26.17.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 17:54:23 -0700 (PDT)
Date: Thu, 26 Oct 2023 20:54:22 -0400
From: Tom Rini <trini@konsulko.com>
To: Chris Packham <judge.packham@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] arm: mvebu: AC5: Use finer grained memory map
Message-ID: <20231027005422.GQ496310@bill-the-cat>
References: <20231027004430.442136-1-judge.packham@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GOVo36+p7fehFNbc"
Content-Disposition: inline
In-Reply-To: <20231027004430.442136-1-judge.packham@gmail.com>
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


--GOVo36+p7fehFNbc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 01:44:11PM +1300, Chris Packham wrote:

> The ATF implementation for AC5/AC5X ends up with bl31 living in some
> internal SRAM. This is in the middle of the large MMIO region that we
> were using. Adjust this to be finer grained blocks based on the address
> map from the AC5X Family Control and Management Subsystem Functional
> Datasheet.
>=20
> Signed-off-by: Chris Packham <judge.packham@gmail.com>

Does this mean we don't need to revert that other patch, or is this
unrelated? Thanks.

--=20
Tom

--GOVo36+p7fehFNbc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU7CjsACgkQFHw5/5Y0
tyxZXgv/YebwEXoSf3iMawKxh0O/79Q4LB5mDeGHJQ/QCQDXuwGub6hEmfmCJvCB
uSwCwGdLcy7b8t/gthnKimu4Hn2/RD71Rl0S7JG8TK2QpX95e/EGojFD2z7Ys8nm
KyahKgTtY+jFHhthJKf65Gwg0yeVne2gZiDis1iVmLiWPduKeg55k5rZmk518ILY
NesRlnWcCBxih65r0s1vf3QXtOCj5W74QBQ6hqdBnT0xuS56ZX0OTgNdPNt8WTdD
6dAHQDd9iU75D+YPk2lurzlwxA36T+MDRqd4GKr+CQ4wWnGM1ECViHhJdAo2qrmr
5KjLEeaJWruHfj9cvEDcEjFM3gKOpVhym6WauGOZpMsYLixcrd2KXJTjqOgH37VV
EPqm388qnVlhGCMeXd/jeMMDO8y3Nh4qThWph0PisI+vFhp3pIkC2/MO+ewWxp4o
cbf5A6BwZVUwI7b4w+3mPBoQppa6RdD9+SOKVSA4o2nfyEnjn+WOqErGrV0zbdom
2REqLymc
=BuLC
-----END PGP SIGNATURE-----

--GOVo36+p7fehFNbc--
