Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27ED4D10BE3
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 03:48:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3D3F88DF1;
	Sat, 26 Oct 2024 05:48:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tX8oAPMu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1385488DF8; Sat, 26 Oct 2024 05:48:19 +0200 (CEST)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A54E988D94
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 05:48:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4609c96b2e5so17833171cf.0
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 20:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729914482; x=1730519282; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jZD5rd7tsAztYZv/YKRUtDA6uEWZVwJwg0bv3L77IPA=;
 b=tX8oAPMum52YvU9QHegkrSO8NJ79/JfIc449QC1NRI/pmnUxMAmkS5ws4NYCH1cZ2F
 i4Cu+gSOSXWfV2ilidiAuJk0X/J0bvEFel5ajOrA1Y9PAle6u0ElYeYK4RddpRzqeTlJ
 6Aq6UhK450W3K5EddC9nDEmV1LtGqKEOxFOw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729914482; x=1730519282;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jZD5rd7tsAztYZv/YKRUtDA6uEWZVwJwg0bv3L77IPA=;
 b=DZqF392Rs1nTIoMiaryOMTVd1ZbXm3KVVjz8lB4BEa3FtbEndoltkeuHW7WkHF+rlT
 xOF0YpUt2d7JRec8rncXJlvlnsgt6bczL8MF4fVaQ58Z84kh4QVCPfPqAip2RZ7iYLBu
 rNBkg7rNZzFgQtq/aFezStGXDAW4eUf+GEY1NCCuSncG9CLVyQFsK+HI82w/RzxqQ3fw
 cXQV5Hg7KJz0sPlyZ/t45xIjaybnj4S0CQWPKDAJKmDMUVDuONX0kabHXOM26DHguOHg
 l4v3KZ4rsTOOuBtu8W92UvxPgnD1sw8+0t5EPtAEHxlmgJbIO9LYJWTHVA+0qCR72r08
 24hw==
X-Gm-Message-State: AOJu0YyoiNf8BrIxxpD1fkvJKILgfWX384mkpV5ffLrQRz9PL69hf1Sf
 UTWCJw/6LjU/+fS361kTipz08qVoKQCQy8sCRMk2sMJWJ8IXtEYLBJzPOQHHSqvBXC2Ir3wbZ8z
 zgb0=
X-Google-Smtp-Source: AGHT+IEhl1G3NshpsrCFKlubuZ/izhUXAUS4V6AN6B6a2DKDRWqA+A7tlSBWAJvv+Kb0+qDx8K0z0A==
X-Received: by 2002:ac8:5787:0:b0:460:bb93:4b00 with SMTP id
 d75a77b69052e-4613c19a915mr24910611cf.50.1729914482457; 
 Fri, 25 Oct 2024 20:48:02 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46132375104sm12372421cf.69.2024.10.25.20.48.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 20:48:01 -0700 (PDT)
Date: Fri, 25 Oct 2024 21:47:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL v2] Please pull u-boot-imx-master-20241025a
Message-ID: <20241026034759.GF4959@bill-the-cat>
References: <20241026002000.3667382-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NnY/dV7/vgEy7KWz"
Content-Disposition: inline
In-Reply-To: <20241026002000.3667382-1-festevam@gmail.com>
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


--NnY/dV7/vgEy7KWz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 09:20:00PM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx/master, thanks.
>=20
> The following changes since commit 08ae12be8509daf3d1c5a148b8a50c0ffb6457=
c2:
>=20
>   Mark a few functions static inline (2024-10-24 11:21:48 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-master-20241025a
>=20
> for you to fetch changes up to 0ccff7f8dca1e30863374a69c9292c82c142eb5e:
>=20
>   ARM: imx: soc: Move default TEXT_BASE for i.MX7 (2024-10-25 20:22:01 -0=
300)
>=20
> u-boot-imx-master-20241025a

Applied to u-boot/master, thanks!

--=20
Tom

--NnY/dV7/vgEy7KWz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmccZmsACgkQFHw5/5Y0
tyyyWAwAs/Pnh2kQ8NfeKEbusXko1/IXBli/GkubSHUzXh6EZNAowFmeEUd0Z0MT
nPjW2zVS8DpzhlZodbwoSLV3sguC6NeeVgoG1LgSkd+Oz44u1agHnytzPmRykn2r
B6w1gF6jAPuzcH+fKmFWQcIrxzJonmxCXNCSo21sAC3vUE5V4Lc4R7qKEtG7Jokt
gj9KTJ9nTpZ1qDSwzhZTEElVF8lSB+ubTemU7mC4uNh4CnKYn+YXvnPWNw6D9HTI
4mHC5D6Ff8DW1GNfQF8OLCVFIZQjnvMjEULE3i8F/1WAhy/favl6LTTdnnLD6Y4C
rdvwmmMxlkaAnLP04RLtBwXuagLMs/+t7zScGb6zBt+TlugYFMvYphBe9af48FnA
iowOU9jtzkzgXpiCBHU0jwvlqube3LCZUu8n7Ge7aDkyM4i5q/2lbq+zGXT76Yja
wmE9XCkdl8ZlLJDecRH7mEVmbEaN9B95wXr6VqKJRyTmXs4BzNg042pgQ5JigAw8
q57zLPg4
=CuiP
-----END PGP SIGNATURE-----

--NnY/dV7/vgEy7KWz--
