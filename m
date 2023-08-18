Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B8E3EE498B
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 17:50:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2D1186EFF;
	Fri, 18 Aug 2023 19:49:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Pqng+zje";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 451778082A; Fri, 18 Aug 2023 19:49:59 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E7D386F30
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 19:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-d6b1025fc7aso1137552276.3
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 10:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692380995; x=1692985795;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=J9f7GB8T9X2AS471V0uQyThmrA+d0CFSyM7h1Z04HBM=;
 b=Pqng+zjeXutJdc4OIloXE28pH/s9kU1bkXNd28hX+JmJf0Mt+lg9ccw46enFlMhd2C
 4OGVaq6q4AxiD3SjY96UNQGDMENtQTjKEHP7GExCKix/sqpOjo2QrdC49sDNiPzpcPS7
 0B0GwADGd8uwN7ZjFKwU/ILfzuaFmRJBK/TFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692380995; x=1692985795;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J9f7GB8T9X2AS471V0uQyThmrA+d0CFSyM7h1Z04HBM=;
 b=g/eOpzjx6WdMbbZwCoBnP4AS4IZ/pRpoeZBSI4EPWUeh4Jz4+njxn1MgN2D6ep3vo6
 sc9XLNPDuHOl2NwzFnREzz69bCSVy6QJtneiZWttJXY3grulcxTSWDfr+FOadayAhR8D
 G1RTeoTVqbtzGKF8A78zH4jwy1VoxeFcqF+BqsWy3ngQlhI72iIDsjko2LfsKcFyk8bN
 RK1tbsKw83pnIGOxR30EazQMnlVfzYo5+H2XhD7s0Eozo6jFEj2ePKEv6k5AydYQAHdx
 HPqX6mx85lll0bbFIn3UB0mDb2tXY9EM183Eatm+HPuNCPVEWJ75W2iV00mVTbBMGQbI
 rNUw==
X-Gm-Message-State: AOJu0Ywwx5CNWiJQh+lqY2okaCljZnBZIf1te1/jW+PODXeJBGiv6WR0
 4QSMXx5Fsc/Vx2fbHYY0XwCWK8qqReTxefAERX6ekg==
X-Google-Smtp-Source: AGHT+IFItUax956uJ9qdRGOfQl6wowyM7M0TizMTLq8ps2+Lojwhen3mD8qo9h4bsnd0gfXTGptM/g==
X-Received: by 2002:a25:2742:0:b0:c3c:5eb1:e975 with SMTP id
 n63-20020a252742000000b00c3c5eb1e975mr3142974ybn.47.1692380995307; 
 Fri, 18 Aug 2023 10:49:55 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-38f7-b1b8-9b5e-5709.res6.spectrum.com.
 [2603:6081:7b00:6400:38f7:b1b8:9b5e:5709])
 by smtp.gmail.com with ESMTPSA id
 m6-20020a056902004600b00c62e0df7ca8sm548150ybh.24.2023.08.18.10.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:49:54 -0700 (PDT)
Date: Fri, 18 Aug 2023 13:49:53 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH] ufs: cdns: Drop extra space
Message-ID: <20230818174953.GH1515023@bill-the-cat>
References: <20230806181842.22342-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="At2B16GL67mp54ot"
Content-Disposition: inline
In-Reply-To: <20230806181842.22342-1-marek.vasut+renesas@mailbox.org>
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


--At2B16GL67mp54ot
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 06, 2023 at 08:18:42PM +0200, Marek Vasut wrote:

> Drop extra space before UCLASS. No functional change.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Applied to u-boot/next, thanks!

--=20
Tom

--At2B16GL67mp54ot
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTfr0EACgkQFHw5/5Y0
tyxM/QwAsqU6g6qVMpzGVkre6b5C57i/nWA+AGKl0669xgdgSjRo8O01gw+vnyqh
/LQ6hdSb0ZSt3SkHkopx+Brb5JIByLQrtbIinXve+Gpss3/WLLiBp96VHXusy+1L
kLhbPcPMZ/oWbXkuKtcOF+DNYAjJpGWwB2aGkIobLo7Xo4l578U+Yej+E8Wh9DP2
voB689u9bUbFTOfVpYFIbCTyGFKseqmfpqFzsCvWVp+sTLmIGjrX5DqN+xW6ORM2
4VFiyCjIeA6ChdPJNDkWAeIUcH9PY4Qfx7/YsOQxjqTnwc46MpLIwNLPzW1bZl6W
seCi2LXTlckBlABG5t7LgtwaiYwLiJUdSh4xcZ/Lk0OPVYfpjjMhWxhzOiNsY+tZ
6NcCjRTX+eKpmuUgoX+bsJyOhOVCjAzDqT28qgto3S8X3cNfSuHx/GnqL2Okb/Oj
yoadgeSLikiDQiN8XOgdm1m6uW0lMTXO6fTHUp3O9OW5Nm4mCwueL852cEnfAxXc
zM2OoYL0
=TBr0
-----END PGP SIGNATURE-----

--At2B16GL67mp54ot--
