Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF8DCCFA0D
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 16:41:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B92C83AAE;
	Wed,  5 Nov 2025 17:41:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hSMpF0yZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD73483AB8; Wed,  5 Nov 2025 17:41:21 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6453683AA4
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 17:41:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-656b1f906f8so3195eaf.1
 for <u-boot@lists.denx.de>; Wed, 05 Nov 2025 08:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762360878; x=1762965678; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rVvzVXBSbMiG2k0pYCJTLbPPjlzDgVsw/hRRL7SbyUQ=;
 b=hSMpF0yZclP3/vRMKJuNG1K452x1+ImjxeRjizo6isf71jnbiA8W2Ib97IS6O55+nf
 8eeEZ3EcYHlrMcSDCo3FWuHJPApL1cJirghcw27KvgLNKWv/+u76p/DTVA8tJwkp8rp5
 A8fHKLlPhUL6Sv5JKtjVpbTnK7BkNoMbBtEUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762360878; x=1762965678;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rVvzVXBSbMiG2k0pYCJTLbPPjlzDgVsw/hRRL7SbyUQ=;
 b=Kx+496hBX99gBI8PSGjG2MieK8HJZup5dHECIhR28mxTlqlyE7+2vFgcC339tiVYCS
 sYzP3hyFF2+Dj/orlrej3IBud+UO8cWqtOKuiGS/MDGvnXZskoL3YRq0QNeETHBCXG7a
 ZpVGBLOA8Obca4bhsjPlNhedspWZlR0bbSKj8K2pYYsiRnLmd2F+4oFepG2CM2+AOgY2
 06HKNfGEV2yO07kg8Y+hkoMaoyRSXHVI1xGe3eSMsFtqlVAkwse88y+CoS0W0SrhC3kf
 dHm1Mpr+6dhclLXJCTzb0nJjQl+NLqmYjpSviCL5gm6ZoJqg5espNtehw+WF0teqbO0Q
 D1Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr5unuYOSLSp4vlVI8YerC5eyMmPugxRRY0lreenVlLetxpptWzOO+MTH/IfksLULwvh66Qr4=@lists.denx.de
X-Gm-Message-State: AOJu0YxyXoh+TbMPS+URf4343FkKq0vLUnc+K8aoAor9fipeOXXZjQhp
 lTyCVlgixcnnggHIriUL/V0KTuUwkH/EcqLmKWo1rnPDcpIlHKnj8UsGDkJN37E6yDY=
X-Gm-Gg: ASbGncu5QsjG2HTqVsxvGf7wHLDq3PdGkNlIoGsBRgUfh05+RP7eG8QXM1dl3eyrZSh
 qQ/dde/PsiGGWZFrs7AmMPK621snKZgse1IWR/VkijxKxA4toCAyIgGN2up7Xs9f3XwZQY+yWwh
 F+Sc+26QFK5pq/8NFGxVcB1ymViXniv0agA/5oIyljCD83ntv276DZ6dmU+sN3ob/VYkWctBMXs
 cgmQwsm8jgYcZmKC+j9WqO4LzyOx6jcSUaymz7LLa+zkiO5KY4XHtX1MgwHOy0tS2I+I2LJGlvg
 xdV9Li0amH/2Tors0Lt9lC0PXq1pQ5QUqK3SlmQJUW69EI5lkyhSajU3OZwLlr8ncNIWVgphqil
 dJZ3H2slGVxk1YI1VxXqyscv3jV8IcaN+Urpze14uPz/kWci82oH+MzHrmsPQLD25t2Lz/dYQHh
 M7zWDx2NPcuLIb+vh3ss4Cq73lJAbtO4NL/indvCA=
X-Google-Smtp-Source: AGHT+IE/7oT+OQUPTaELVC4ST11dNWPU+vm63ytDsb0sKokhEOl1sSYlrYqj08B13By8apQqe8bavQ==
X-Received: by 2002:a05:6808:6909:b0:44f:e1af:21f3 with SMTP id
 5614622812f47-44fed365d86mr1809161b6e.19.1762360878061; 
 Wed, 05 Nov 2025 08:41:18 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44fd8864d94sm1760232b6e.11.2025.11.05.08.41.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 08:41:17 -0800 (PST)
Date: Wed, 5 Nov 2025 10:41:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Swamil Jain <s-jain1@ti.com>
Cc: devarsht@ti.com, aradhya.bhatia@linux.dev, n-jain1@ti.com,
 tomi.valkeinen@ideasonboard.com, jd@denx.de, tl@denx.de,
 agust@denx.de, vigneshr@ti.com, praneeth@ti.com, h-shenoy@ti.com,
 u-kumar1@ti.com, n-francis@ti.com, u-boot@lists.denx.de
Subject: Re: [RESEND PATCH v3 1/2] drivers: video: tidss: Refactor tidss_drv
Message-ID: <20251105164114.GQ6688@bill-the-cat>
References: <20251105163040.4086273-1-s-jain1@ti.com>
 <20251105163040.4086273-2-s-jain1@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="07YhVLgklgZF9M8R"
Content-Disposition: inline
In-Reply-To: <20251105163040.4086273-2-s-jain1@ti.com>
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


--07YhVLgklgZF9M8R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 05, 2025 at 10:00:39PM +0530, Swamil Jain wrote:

> - Refactor tidss_drv to improve modularity, enabling support for more
>   display interfaces beyond OLDI in the future
> - Add detection and initialization of active OLDI panels using the DT
> - Port tidss_oldi.c from the upstream Linux kernel oldi series[0] and
>   derive several APIs from it to determine the dual link pixel order
> - Add tidss_oldi_init() and helper routines to handle OLDI-specific
>   setup and move related helper routines to tidss_oldi.c
>=20
> [0]: https://lore.kernel.org/all/20250528122544.817829-1-aradhya.bhatia@l=
inux.dev/
>=20
> Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
> Signed-off-by: Swamil Jain <s-jain1@ti.com>
> ---
>  drivers/video/tidss/Makefile     |   2 +-
>  drivers/video/tidss/tidss_drv.c  | 235 +++++++++++++-------
>  drivers/video/tidss/tidss_drv.h  |  40 ++--
>  drivers/video/tidss/tidss_oldi.c | 364 +++++++++++++++++++++++++++++++
>  drivers/video/tidss/tidss_oldi.h |  72 ++++++
>  drivers/video/tidss/tidss_regs.h |  21 --
>  6 files changed, 612 insertions(+), 122 deletions(-)
>  create mode 100644 drivers/video/tidss/tidss_oldi.c
>  create mode 100644 drivers/video/tidss/tidss_oldi.h

You didn't include my feedback about making sure this either builds on
sandbox or updates the Kconfig to have appropriate dependencies. I
checked the build failure more, and we fail to build this on sandbox
(and so allyesconfig) because <asm/utils.h> doesn't exist on sandbox,
but also isn't needed here. It really is only needed in two files
because it only defines what should be generic math header functions.
So, here's my request. In a follow up patch, please do either of:
- Remove <asm/utils.h> from everything that doesn't call
  log_2_n_round_{up,down}.
- Remove arch/arm/include/asm/utils.h and replace the calls of
  log_2_n_round_(up,down} with what must be the common linux kernel
  equivalent that's been added in the last 15 years.

Thanks.

--=20
Tom

--07YhVLgklgZF9M8R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQt+JgAKCRAr4qD1Cr/k
Ct7/AQCfZH4aFl89tHa6Uy6BU2kuRQjlC1bCZ1HhHvzQaPbSvwEA11AKrLZHpLTX
a/uu/UHgbvJ7lPneL5qWsvLOywZ67g4=
=5qG0
-----END PGP SIGNATURE-----

--07YhVLgklgZF9M8R--
