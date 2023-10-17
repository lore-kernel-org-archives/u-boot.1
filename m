Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D98CDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 13:40:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A57B86D9C;
	Tue, 17 Oct 2023 15:40:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UZaZhhgA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8A5486D9C; Tue, 17 Oct 2023 15:40:15 +0200 (CEST)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9F6B86E14
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 15:40:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-d9a3d737d66so6006296276.2
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 06:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697550007; x=1698154807; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iCvcgJO0TrWaHDAUV+nLw9r2CSqAT0gz3074j7eyhkM=;
 b=UZaZhhgA0lyDpFVTWT70qrfMuTMdeWH7TQaR4bPx3R/IrNZVVKQisOcMCh24DC5cTN
 QQNRv9hSKFubDnt/+SmdWRp5hG0k6H2PzCg+S9lItC30jph5kKUfg+FW6JcPYEod0FrZ
 WQ8im3OGPL7JwiVp8i8Ottm7O8S0j2edkMFgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697550007; x=1698154807;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iCvcgJO0TrWaHDAUV+nLw9r2CSqAT0gz3074j7eyhkM=;
 b=bY9G7ha1ZxoN/sHMwalEsBJ91TFpYDT9bZ5kFrL6NrYZlNymFVudlUVHa1ub6R1vez
 QmehE68w62D8tTEK4vzqrzxdoMtGp1Xh6sI+DqAlQRYqKz1n551R5z+JfxuPu85pEtqq
 kg01LLK5+sJniBncOZPY+jfw3hbB5myBZbMou4CrYOJunyVm8UUT4ttuQKVVEbpQtCSq
 fK4fzgMJV4nmJR/t8qexECYTdI6cRgEVVUa3tL2g7NvWtjXjCoLUh1SzEi5pMfJQVLp6
 MPnABAsygjQZ261X8qMTVMshawc54FgDdZSTsn8FLrM6OYc6wkQ9ozll6RUPoU0qSASg
 L3tw==
X-Gm-Message-State: AOJu0YyCCP0hE/w6oAvnyPegwSGAUcPSaVzcZvFdo3xUL7LmLOYFfIuQ
 fOmD+AbHeRh4xV6uN4q0I4RCWg==
X-Google-Smtp-Source: AGHT+IHDRO8g3rZEErj5X2yBBcOdklfzpKxtIshgJqTB3mUaKcj2yF5bYypIqOtkvzGq5MNOGnNsaw==
X-Received: by 2002:a5b:d44:0:b0:d9a:c391:503 with SMTP id
 f4-20020a5b0d44000000b00d9ac3910503mr1967544ybr.3.1697550007346; 
 Tue, 17 Oct 2023 06:40:07 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 u13-20020a258f8d000000b00d8140b7e641sm508074ybl.18.2023.10.17.06.40.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 06:40:06 -0700 (PDT)
Date: Tue, 17 Oct 2023 09:40:05 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Joe Hershberger <joe.hershberger@ni.com>
Subject: Re: [PATCH v3 12/32] env: Split out non-command code into a new file
Message-ID: <20231017134005.GV3119521@bill-the-cat>
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-13-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uCY11sA0L5EQnJkn"
Content-Disposition: inline
In-Reply-To: <20231016222835.596572-13-sjg@chromium.org>
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


--uCY11sA0L5EQnJkn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 04:28:03PM -0600, Simon Glass wrote:

> It is not possible to set environment variables without having
> CONFIG_CMD_NVEDIT enabled. When CONFIG_CMDLINE is disabled, we need a
> way to set variables.
>=20
> Split the setting code out into its own file, so that env_set() is
> available even when CONFIG_CMDLINE is not. If it is never called, the
> code will be dropped at link time.
>=20
> Update the Makefile rule to only include the env commands when
> CONFIG_CMD_NVEDIT is enabled.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v1)
>=20
>  cmd/Makefile           |   2 +-
>  cmd/nvedit.c           | 122 ++-----------------------------------
>  env/Makefile           |   1 +
>  env/env_set.c          | 132 +++++++++++++++++++++++++++++++++++++++++
>  include/env_internal.h |  23 +++++++
>  5 files changed, 161 insertions(+), 119 deletions(-)
>  create mode 100644 env/env_set.c

This feels like it's partly but not entirely correct.  We need to split
cmd/nvedit.c in to cmd/env.c and env/nvedit.c instead I think.  And keep
in mind that SPL + ENV (and so - CMDLINE I believe) does work today.

--=20
Tom

--uCY11sA0L5EQnJkn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUujrQACgkQFHw5/5Y0
tywLRQv+KU3JCxqgfyxIRxlVuEfO3zQq8LaEV/J+Z55rkyRiu6Uv6AlCronc/DnT
v4etBW0Jyy4q3QqH1p/ZtKiNJojxyzMOmUCyah/wtke1uCH4ylioicx2EwpVQJV1
XfPG36Rh51LacDcqbax+hFJvYdGUi5v3mIImIWeTS+8zasfvEJDIQdbCwZM/DSYA
gt8JejVFMcNDFwtwGCnzTGIjSiNHAezB7et0qgawm4gAskCIM1R1pWwMfi2sLaX8
B3+YSEDLO3qFw+Kpl+b401uaY3AhMAHKr/IBtf7AxJ/oxTm2gPguNr9JOzlc7IP3
Xljj7YcXuqnSMV2LgJ7kTBOAFpw7sgRcTi0eFMjjfrMSiMYnr/Btf12uDhD8Hzt/
cuRixy7iW4HfXJ5OeRrmmragqgYFQGwtPF35U3YLyEPfM+3LKO6SqZjxxCZG38oT
lXomfduND2spPibNqA7DoMH8RYPcI2GsILQS2SEATKRrG9vdINzC3tVvR3zD3mNH
QAtsRR5W
=NY1B
-----END PGP SIGNATURE-----

--uCY11sA0L5EQnJkn--
