Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7297C27C77
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 16:03:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E2508886C;
	Wed, 12 Jun 2024 18:03:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dSHAiS1C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E18E88850; Wed, 12 Jun 2024 18:03:03 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3ABB883D3
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 18:03:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3d2255f84e9so531237b6e.0
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 09:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718208179; x=1718812979; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=g3AB+4bCnL7WERIviCuF8UiF1LzXZls9ZlRD3ZnRtRY=;
 b=dSHAiS1C2nF6h2AjvX50RSHqTJ9hY2lNAeN3+LHF+zn8CPHIB/AHeZGok3BuLvMZH3
 rVYpOKIIBcjjvl9cweIMwaGyydKljQD/wSS00RH2WzkWxMTQ7czpin8It1EAsKvHd1sf
 49plkycE06MeVj03JAbAhM/txTHfjeHkfmM3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718208179; x=1718812979;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g3AB+4bCnL7WERIviCuF8UiF1LzXZls9ZlRD3ZnRtRY=;
 b=tSUOB7Rm27jjWdo5Ukq6VLpCJQhUfDMV1NzBgKzXrJbTS3q117mbSXocx1RBFesmg5
 c1ChKvHnaXdMH2qOoxO4MPCJQg13vqhuBdsoLjO3g8d246UQc72ryYybAfn1QMkL8vQ5
 dYLL+JtSFwIpPF11qhqWeIpXhsgxoz0rxJjvI87h/xEUjI8iKry80xuoSUq05q0q3wYx
 c5z2DNbRueyFDEiS24l22pN3pgnaCsIweqSBllJTex2VaBHPlieq0V7FtQjmyuMWD+3/
 eYgE3TEy7vIUM3HE2TGaNjO+5D1G6hYpNE3IMlPlwN4O8rieFMtHD5/2jicXr+QQp/oV
 Nz6g==
X-Gm-Message-State: AOJu0Yyg48pUie4bGsTOjnlM5gGIqzeGFol0rAtGrGrozKS309VxusoN
 ldMrSD/tmT2Gw7/9MAx52mr5P5WLDTt96ghpMoZHm7vGdSDg+iJdkSRhCypxPZY=
X-Google-Smtp-Source: AGHT+IFmb/EW8OrQZKsyZiN5YXwRboJY3dra7sVw9Jskg36Fq4oaNVbZTNewiJ1W+f3tkUk9OxLhDQ==
X-Received: by 2002:a05:6808:30a4:b0:3d2:239d:e0a8 with SMTP id
 5614622812f47-3d244efb786mr10067b6e.26.1718208179456; 
 Wed, 12 Jun 2024 09:02:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d20b66cb7asm2363145b6e.7.2024.06.12.09.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 09:02:58 -0700 (PDT)
Date: Wed, 12 Jun 2024 10:02:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 23/42] test: Release board after tests complete
Message-ID: <20240612160257.GA68077@bill-the-cat>
References: <20240611200156.2245525-1-sjg@chromium.org>
 <20240611200156.2245525-24-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8Wu1uFSwmFcqwrt7"
Content-Disposition: inline
In-Reply-To: <20240611200156.2245525-24-sjg@chromium.org>
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


--8Wu1uFSwmFcqwrt7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 02:01:37PM -0600, Simon Glass wrote:

> When a board is finished with, the lab may want to power it off, or
> perform some other function. Add a new script which is called when tests
> are complete.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  test/py/u_boot_console_exec_attach.py | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Given that all of my wrapper scripts include a "turn it all on" and then
catch for "turn everything off", this sounds very handy.

--=20
Tom

--8Wu1uFSwmFcqwrt7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZpxrEACgkQFHw5/5Y0
tyx1sAv/cuoxwPE2Ua4FbSRgyE2tcpgQdx6943CMhMlizyjQyIcrAgZ6yIBEN67M
O+eMbP+jPg+TDKOjls7RGGl9ihsp7s2JTa4av8AL7BA8UYc7g8wca+RyK5MlqfOp
yKLbRVuowmgW0+XpaW4ueHe2d3A5pXWmGr1V3vbm0ulFQ9ODTnR7oMYvxNAYTj1N
OiylaM0mRp99ZlufxqmHjn/XYnGi1dDB8xIrKo4zwPyGwo/VPlPzW/uzXdmtFevu
SCeuGhZKfr5Yvhks6RreoUsDgB4rDEUCew0UePWiAj9YFZa9VbYzPCIqnRpLlK7U
Oq2l727gtzPJlF+bjI9uPc00C5bbfAUxB0M62LFwi1y4NVEcYF08W3EzVYwRrT9N
nuRPx8wRYVxF62vEYLNdnHjTCcF+9cEX68tnuItPAdHtSu/OIfqORsAPnOSM8cGM
wM1pPHR4+D3azCDAgsIMW+gw7porRh0DeiXguVpOo6zqLlhEPxW8bu7PfYNZ3B4g
AtaMW/qN
=fCW/
-----END PGP SIGNATURE-----

--8Wu1uFSwmFcqwrt7--
