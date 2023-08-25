Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5ECC3DA66
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 18:48:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0EBF86AA6;
	Fri, 25 Aug 2023 20:48:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Jx3YpNVs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88AFB86AA6; Fri, 25 Aug 2023 20:48:16 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C72C4863EF
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 20:48:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-59234aaca15so14824057b3.3
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 11:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692989292; x=1693594092;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JhlEziZwgLkeBEfxFbL+RBy8rRoJjdVLD3F8e8d3nmw=;
 b=Jx3YpNVsdtWWzvH1Gytjh5KVhDaushZG0CcSCu67U0+WzvNQuRgbcJbrEZADmEAIJz
 AmJ8lNMHdjfVa5YLhDcTtnbF8YNSgG1O1Aj8EQhUqnbhicgJ2NyTqkv1IJQocaGbswAi
 EVfcD8BaeY7DEnwkWdT8QcLAHmFV/M8MkQUww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692989292; x=1693594092;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JhlEziZwgLkeBEfxFbL+RBy8rRoJjdVLD3F8e8d3nmw=;
 b=FObbQOrhQjLvUxcnIQXSWirb8Z8QyVD6nvcderUAInLlQj3I7bWVoT9dHh8UVwCDVW
 vsh5CO5vIxZbkCGXP7CcPziPSnn5gYgGhHlWrvvFZ1ZKDaYE9tLJry62aEx5wTf16bxh
 SGkoDEeh5aqmLjfC0CtGde8Xyjen9dlKZPLKqbx5W2vqh7jGEd5k4P3O5Nenya0XxJdu
 QlgY+sjpSzJRG4J+FX+M+S7f+LTccef4BX0MBIz56KhFcR2jzqA9pxe91/rQChFi7RzM
 uC3qmxOWr2Y3Os/8z3rsdpbu+L/GHfvwa5YlNmr4iGr9ZXcsOWevvXwjGZBMvVWh41w7
 go3w==
X-Gm-Message-State: AOJu0YwDgqLky2pTsEajopy2vp8JA1YBh2/vmdDSiW6lbrEVuYL5PHoC
 j7c2IIIrf5SA4H4hg4P7AAk9Tg==
X-Google-Smtp-Source: AGHT+IHOyMEF8JnEJKViDXYWHw15c0s/bCSxv9hER4h+/NhkXFJbhUER2yo9SuAZhCCY0D+9DvEY3w==
X-Received: by 2002:a05:690c:2c88:b0:592:8b0b:56d1 with SMTP id
 ep8-20020a05690c2c8800b005928b0b56d1mr4878479ywb.38.1692989292488; 
 Fri, 25 Aug 2023 11:48:12 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-fcb7-366a-fd11-1c19.res6.spectrum.com.
 [2603:6081:7b00:6400:fcb7:366a:fd11:1c19])
 by smtp.gmail.com with ESMTPSA id
 y130-20020a0dd688000000b005704c4d3579sm640032ywd.40.2023.08.25.11.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 11:48:12 -0700 (PDT)
Date: Fri, 25 Aug 2023 14:48:10 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@google.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] CI: Move to latest Ubuntu "Jammy" tag
Message-ID: <20230825184810.GN3953269@bill-the-cat>
References: <20230825172127.3406461-1-trini@konsulko.com>
 <20230825172127.3406461-2-trini@konsulko.com>
 <CAPnjgZ2P2XUx2VzfTwT2DeDFH_T0sKh+M7cMy6P0un90De3=aA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="X4LviqzqXBC7lVOY"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2P2XUx2VzfTwT2DeDFH_T0sKh+M7cMy6P0un90De3=aA@mail.gmail.com>
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


--X4LviqzqXBC7lVOY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2023 at 12:06:09PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 25 Aug 2023 at 11:21, Tom Rini <trini@konsulko.com> wrote:
> >
> > Move to the latest "Jammy" tag from Ubuntu.
> >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> >  .azure-pipelines.yml    | 2 +-
> >  .gitlab-ci.yml          | 2 +-
> >  tools/docker/Dockerfile | 2 +-
> >  3 files changed, 3 insertions(+), 3 deletions(-)
> >
>=20
> Reviewed-by: Simon Glass <sjg@chromium.org>
>=20
> I wonder if they have a 'latest' tag? I suppose it wouldn't be safe to
> do this without trying it first, though.

Yes, but that would break reproducibility.

--=20
Tom

--X4LviqzqXBC7lVOY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTo92cACgkQFHw5/5Y0
tyyJFwv9H39fS58cgweUvj34WRGIuaEkGNNjC736jqDy+7Ams8tYdT2aup8eViRz
c/yBog8coJepHgPFBNf+pbG8gPvgrwlAxfnLJRMC2+2Ry0UzjohA0IRC+zapKPiq
FreZ4SKMmcZQ1kybivGoy1Jqz/C1zvWMRGKoqjiEsLx9BhSKH3qk2+QXUeeoZRZ+
jTS6zpq+NcgUTszXwMVolNdz84fGMysNkfiehvEClxK1maRjGpG22N2eJkcv0Du6
bHj0AeH1/QoUUPs+4KDKeoe9waXAy7BFGmzgsUP/VtLYSScRc3udk30hS+a94YFc
Od/w0QYBvjGRAdj7Prd7s9DDoDm88zfT3Nj+U+q+iSTgobSyxhNwCVKMZL/ejjSo
bF8HPRgeM/bX6nF4k40U7a1PoC3gQ3OhVl00hB2NsWHaFbnQmwP6fVIyRY8FbUTv
x7q28GH6/Y5enDKaQFVsOQ//dvuiK7UrxVYGJ75xZm9nW4x59P9VdRUd84dhMeCt
y0TptAVi
=XuTV
-----END PGP SIGNATURE-----

--X4LviqzqXBC7lVOY--
