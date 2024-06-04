Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A046C25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 00:35:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C40F0883C8;
	Tue,  4 Jun 2024 02:35:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ueYDhILc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33E8087D33; Tue,  4 Jun 2024 02:35:49 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D36DE87D33
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 02:35:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5b97b5822d8so244548eaf.3
 for <u-boot@lists.denx.de>; Mon, 03 Jun 2024 17:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717461345; x=1718066145; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ptK6b7Oy3oVCrIBo6a0/lphZ9OyiIgpVpYxBRvVy7W8=;
 b=ueYDhILcKWat8J/Uo0xKyNQGpMt0MhcaiydYtYnrm1QPnt6+OUW2nYRyfSYcPxvw90
 yAcJH25BULM7ANpSiQce7I2UNOvqTb30guZPk1gu3a2QR7pNu+7SG2K0Od+Uq5azDcyz
 MDpL2sg4O+KFTb/eoCa7fu8Q8Z0QBwGRydHYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717461345; x=1718066145;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ptK6b7Oy3oVCrIBo6a0/lphZ9OyiIgpVpYxBRvVy7W8=;
 b=e0uvYl8ppB7gj8NDyGKe9h4UKpUN26bEXOyDxlpDLYXTIqlIx0KHxkWJGrzoW8LzNu
 doY1+Tj2RMf9V0b2bLViFM70WTIrgzwvTgVSLTJQKANiWhDfvEIcOD4n4F45YCMu6wHj
 IE5+0lyAuX8/JC4MgQqqWpPGAQYQj46E27M353QLxbaWvaturrAfZiQtQsu6Q8U3cbRl
 AVRcMh+UJev1qB56PvzCXAttO0u/zW0CwGEHIU1Cac1KJpW8pUAXqex3z7zmK6prZt/k
 c+Firntzx++ZweWkhex3ZY2XmWNQhD+04o7/NQUoRdKPKmcaaAnztP/1SSBi4Y2T1bnJ
 RqzA==
X-Gm-Message-State: AOJu0Yyt8KBVzi5+YZl6+cdw86q8L4IHqoqNkgJ1htIwBYDGyiYR7Ie0
 wm3GmqlAEsSG5wF6H4vA0hBZ3mpztParrsDx7ufxZYeAGcGFXwV4OpGDR17g1Eo=
X-Google-Smtp-Source: AGHT+IGLHDpRu7xeH2/MktxQ0pVdJ319anz4q8RwlKu+R//xwp3ErmUrhfzQGcPTPPsJp8pDbceotQ==
X-Received: by 2002:a05:6870:b14d:b0:24f:c5cb:cff4 with SMTP id
 586e51a60fabf-2508bb2fe3amr11627928fac.31.1717461345473; 
 Mon, 03 Jun 2024 17:35:45 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-250852250fdsm2861976fac.44.2024.06.03.17.35.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 17:35:44 -0700 (PDT)
Date: Mon, 3 Jun 2024 18:35:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20240603
Message-ID: <20240604003543.GH68077@bill-the-cat>
References: <20240603164303.2659176-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZQn/7lm37R3k2eZv"
Content-Disposition: inline
In-Reply-To: <20240603164303.2659176-1-festevam@gmail.com>
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


--ZQn/7lm37R3k2eZv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 03, 2024 at 01:43:03PM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx/next, thanks.
>=20
> The following changes since commit 7e52d6ccfb76e2afc2d183b357abe2a2e2f948=
cf:
>=20
>   Merge patch series "FWU: Add support for FWU metadata version 2" (2024-=
05-24 13:42:07 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-next-20240603
>=20
> for you to fetch changes up to fb95661116fb4269883721afd80578e6d88ce043:
>=20
>   imx8mm-cl-iot-gate: Add support for the Realtek RTL8211E PHY (2024-06-0=
3 12:14:29 -0300)
>=20
> u-boot-imx-next-20240603

Applied to u-boot/next, thanks!

--=20
Tom

--ZQn/7lm37R3k2eZv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZeYV8ACgkQFHw5/5Y0
tywl+Av+PI5ytJY8IbY93xj8PCwFJHUGuXR6Wh9KzMqBMoLz/Zdjv+l4LZyK8rNS
w14Pv5OKNnHREWbPiwmEX0AqZ8n01CuwBYcA5c2Sh6ZKIQ49GkF7hZQMuk0Ox+V7
ulIm2fdqUJQ2cHWZfQMjw/WBaZcCzaeZbTn+Yy1Qf3n9QAsJLfbOIEQt5itdL31O
GEjzme6QsHo0XBh70bVNA4mXANNdGhswHn7hVNnBLLOn4f6TC8zbopKJf5F7UerL
JcBNHNfDrn0nl26vkYy42b7hlrVKflQrdXvDY7xCTvCU8TKfHMZGRd7pNGW/UcAN
z7iY5NOA28W0NVA1gUFZ+8f/651KV7p6ksxaR2z9dsu3IPGzonJ2uMfsYC9u8ACk
TJcBLFxDwsENFrRT1evd7NZu1Moz/617mtX4HJFxzUeNi/R5FRBHY05XrADgSDAK
2VgVj853/FbA/61mg8SuJjwaBaBrNzeMOAdYKZyUwKZo9wCZ3uPhCCWZ6nTUfeuP
Gp+csqGk
=ubUg
-----END PGP SIGNATURE-----

--ZQn/7lm37R3k2eZv--
