Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6A5C54E71
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 19:05:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C0CB8808F;
	Tue, 19 Mar 2024 20:04:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SHit/FG3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C26388089; Tue, 19 Mar 2024 20:04:56 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66DCD88092
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 20:04:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-dcbef31a9dbso4165366276.1
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 12:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710875093; x=1711479893; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hmV9MRbmEaAflyPqkMXQwREOSVyTGGs4XurvcvgLe+Q=;
 b=SHit/FG3EYLiNZGouU290T+hmnwvX3EbZRIoz0I3tOnuCvG4Ib0yIU8/BhuE9LBd9/
 kfgeRytu9CBpuJ2biCU61DxAjDlYYVndQgMS0hhIYnfnvpedDB0DN1CcWe9LUNa4v1Lg
 dK1108oGUPfU01J7ZaKYkTvLGsucnwbXKcZrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710875093; x=1711479893;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hmV9MRbmEaAflyPqkMXQwREOSVyTGGs4XurvcvgLe+Q=;
 b=eUU1X2lN34fX/tjywBINqa2A+xQzWfv1bqKy7tv1ut5cJ051jFztbh/htKrSPx8uNt
 6QhENrBDG+HET0piSZMXcsOcnKIGb26K5TXIS4nqGkwlgUDykqvvf/aaqWYb6mKO/9u7
 daSQtliqQVub8XErXJ/aXdn1+IZRgRqbIqmN2VrO73GGB7ZDKF3McK+yl15hP7n34Tyi
 h/33USblk8TH3AGTcCOVAXmlK3L9Ucg7D347pzgUFiplFFnNzf8l/48a3grX3xejvDyl
 z6Wa6S2fnzZ4SWLm0ws1ItLP/Gd5L7Fhe80YDy7b8YN/2LBJ0XPGBhKQfddQASsGVSAr
 83Mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVzJ06dvN7NQ+Nta6k/gj/2oNmQv2p9R38FCtgLBb59H+QBIlNcyZZlqeWTXbbfxJnROJE5yQDi/tjwTduVHB2M/P0YQ==
X-Gm-Message-State: AOJu0YzTP5UvvUUvvgVauVEHs3WocAgY7yQDdj5tEd/+MJw1aK30A7eu
 qIf/lBRQ5T8q0rOakUQvhJDS6yEXIQ5QpJDzTeyfaIiBI5NveAy61cBsXWhhB1Q=
X-Google-Smtp-Source: AGHT+IFyGdZ6iORtmNAOlKaOxDLF5gatIt7S3a3cXQlR5JSmpQUjTlrLGTl/7vHKv8qfXdYV8ZLZMg==
X-Received: by 2002:a25:4f46:0:b0:dcf:afe3:11bf with SMTP id
 d67-20020a254f46000000b00dcfafe311bfmr2711105ybb.0.1710875092739; 
 Tue, 19 Mar 2024 12:04:52 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 l36-20020a25ad64000000b00dcbce4abc32sm2364597ybe.36.2024.03.19.12.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 12:04:52 -0700 (PDT)
Date: Tue, 19 Mar 2024 15:04:50 -0400
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>, seanga2@gmail.com
Cc: peng.fan@nxp.com, ye.li@nxp.com, u-boot@lists.denx.de,
 marcel.ziswiler@toradex.com, francesco.dolcini@toradex.com,
 hiago.franco@toradex.com, joao.goncalves@toradex.com
Subject: Re: [PATCH 1/2] clk: clk-imx8qxp: Add LPUART IPG entries
Message-ID: <20240319190450.GI3442575@bill-the-cat>
References: <20240308201316.1721909-1-festevam@gmail.com>
 <CAOMZO5Aa_EaTtL9r7k0P7CaJQ0fixGLJSR3WvxHAD2=5RJdncQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SeKFQluJCpceJP9O"
Content-Disposition: inline
In-Reply-To: <CAOMZO5Aa_EaTtL9r7k0P7CaJQ0fixGLJSR3WvxHAD2=5RJdncQ@mail.gmail.com>
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


--SeKFQluJCpceJP9O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 09:14:53PM -0300, Fabio Estevam wrote:
> Hi Tom and Sean,
>=20
> On Fri, Mar 8, 2024 at 5:13=E2=80=AFPM Fabio Estevam <festevam@gmail.com>=
 wrote:
> >
> > Since commit cc7df0b9e8bc ("serial: lpuart: Enable IPG clock")
> > the colibri-imx8qxp board no longer boots.
> >
> > The reason is that the imx8qxp clock driver does not handle the
> > LPUART IPG clocks inside get_rate(), set_rate() and enable() functions.
> >
> > Fix the boot regression by adding the LPUART IPG entries.
> >
> > Fixes: cc7df0b9e8bc ("serial: lpuart: Enable IPG clock")
> > Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > Signed-off-by: Fabio Estevam <festevam@gmail.com>
>=20
> Please consider applying this series to 2024.04.
>=20
> It fixes a boot regression on imx8qxp and imx8qm.

Fine with me, Sean?

--=20
Tom

--SeKFQluJCpceJP9O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmX54dIACgkQFHw5/5Y0
tywRIAv/WtRdgDKnzgQSrzifgBkO0ZAJz1TVU0VoxjAmreasOK3ahTP7AGbQtMS/
kX30Fqv9kLP/YhLAN86IIzchSfYhsOC+PlEbdt1jMZuNjp4jaZRqlFFZU8VQV/GY
qWnlqbx+HzJxnz0729Q+3MNNMQ65HBzVW2Uz9WLHqBj8SQaTRjX7kaulLgqRBbq0
9+3RSO7euJt+46R4aeOkQMQtNEu3zpZR8xwR27HakioroKl+llvgxrTjT/fHG/3o
oXZXMQw4JDbSykDlPQzSxKEyrlHUtqoVfO5FkzI0IftlnoeQGRLlXcx531NWQoI/
1SamgBwpirnHK7mp4NNro47QmYqJrLsWeQVKv5og9uRBFtx1zjg7rGk2O9oDFTkg
WYszmgu3PY0D/pVQD+KTFjfuCdurG2Giko7QDgkQlH2GpiSdmSOxKy+7R+EVSkUF
/vdTjcKnjJrNhB7cARSR14agEvUDB06OkBPLLoYS0Bxut+kOzBD3WKy+YXrTOaDT
m2U9EsXo
=SoTE
-----END PGP SIGNATURE-----

--SeKFQluJCpceJP9O--
