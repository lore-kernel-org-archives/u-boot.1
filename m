Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F36C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 19:22:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5A0C8840D;
	Tue, 16 Apr 2024 21:22:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s4JJrxCp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 454E28840D; Tue, 16 Apr 2024 21:22:34 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BF9188390
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 21:22:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-69b40061bbeso25462716d6.1
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 12:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713295350; x=1713900150; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=o4/zJp1TzquAMVFmEeAWSFkX+nB8tMcqGU3t1tklQbM=;
 b=s4JJrxCprpms0mP6uDx9BHQK1lH12qAa1a46TkCNBmWFzU9XWOgXHz/rVLCo4iXjd5
 xGKU0IoycfV3XzR+69ROKGOpBcnf0kPOKTs0tpNmoF/vvMPpHKurvlrsUlowRNKKPXLm
 OtKO1LLp0KDZcknQ4Vw4q5nzpgyOWAOVxme2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713295350; x=1713900150;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o4/zJp1TzquAMVFmEeAWSFkX+nB8tMcqGU3t1tklQbM=;
 b=ApeZgpHWSxLWbfvUyqgggMEvWGcTr1YkZUSG2h+FC4Vv+2RaM/3bGNJ63h4zHtd+cA
 tAsowwqyUQ7ruyna/rfoGWM+Ej1tTM7TFC8IhWXJs8vv/fq03MJz6rCPbSfCGnK4EDMy
 My9pOm7/vB9KFxo96bW1nRMVJK+nAglodSrG2rxSygMSLZN8KCsGGnGcrIKtEIvlrVWH
 netcm0sqyNKpCfRjJmAqZFqNPFv5SrOeY6oeZ8aX0o0H07MMg+YgAtyoh9ZMHfULkpK6
 H7utut8pv9D/zsQ+9R9SvgWlPvrl70R7IE8tLxW1tY/D1tyUZcXVWy1m7ztOaz5ClbVC
 Dn1g==
X-Gm-Message-State: AOJu0YzFpOeN5BVbzqNpm8AFPKzmEu/4gFqPyYMoNFM2fr8WDBoV3M3p
 WAhdWfPJ1dBGJLLZ/f6bYKSP9CBaGzh8/d9VIuSJUElYFP+Rq66bnZt63pJuifw=
X-Google-Smtp-Source: AGHT+IFGGPO7Nc5+FGSgJAuKt79uoOjM1Zgqo4TZC+6ibhGDOBbhzU+58C8Hn5Zd5XYk1oNv/E+otg==
X-Received: by 2002:a0c:eb09:0:b0:69b:8099:4742 with SMTP id
 j9-20020a0ceb09000000b0069b80994742mr6081948qvp.55.1713295349798; 
 Tue, 16 Apr 2024 12:22:29 -0700 (PDT)
Received: from bill-the-cat ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 a11-20020a0ce34b000000b0069b748abd98sm3387722qvm.89.2024.04.16.12.22.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 12:22:29 -0700 (PDT)
Date: Tue, 16 Apr 2024 13:22:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, xypron.glpk@gmx.de
Subject: Re: [PATCH 11/23] efi_loader: switch sha256 to mbedtls
Message-ID: <20240416192226.GW1054907@bill-the-cat>
References: <20240416190019.81016-1-raymond.mao@linaro.org>
 <20240416190019.81016-12-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="D30P5dNY1QHGM2v0"
Content-Disposition: inline
In-Reply-To: <20240416190019.81016-12-raymond.mao@linaro.org>
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


--D30P5dNY1QHGM2v0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 12:00:07PM -0700, Raymond Mao wrote:

> When MBEDTLS_LIB_CRYPTO is enabled, use the APIs of sha256 from
> hash shim layer instead.
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  lib/efi_loader/efi_tcg2.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Why can't we have the abstraction be at the level where we include one
library or the other so that the calling code doesn't change?

--=20
Tom

--D30P5dNY1QHGM2v0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYez/IACgkQFHw5/5Y0
tyy43Qv+LTq+97hu8CZyhLOqvlsGfwvHPhRdN/pNx8zbYiKEAZ3re4soB0WU/nTY
P4Mx9t6g1GVH8D4E0l+VRLykA/vzUeUIf2szQgJX/CLNUjASr3Pe3io35LJ2tJsl
lXuqR2AULA3hyFCJN49j+tqOxw5hV07GwWRPJmKjWatRtO6Y+6zFQcO7NvCQQuKP
WU0JZWS9aPnEvV2tN2yAGywy0tCRuL336JgSe2eJwp/6Lbq/107JmXWY6Xv50cv+
ChysgLeBEb1npx1/ClT7djRZPUMSQJzYDf96HVBFY+FrKos9vtjm/J45EhcY/ff9
ibCgO0SKbyXRKKOmk5aNP98YfZMCx6/d5cfQLwatdjoNZU/5oq1/amWDu383hvd4
sQLGxLPjMkXHP8kjlkbKI3/Jzp0UBqb8Hu2OK9KMWLjxIz+JxiTALy0jDq5DMZPf
R+szUoC1GG+Ul35IRiJU3miNhkIzRdO2Vx7F5hx6zCHBAV4VE1yQNDAGpY+DqyuU
9jCuEJss
=P0eS
-----END PGP SIGNATURE-----

--D30P5dNY1QHGM2v0--
