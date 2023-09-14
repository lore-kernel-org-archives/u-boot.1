Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FABDEEAA52
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 16:08:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D119869C3;
	Thu, 14 Sep 2023 18:08:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="huaR9qZg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3532C86A30; Thu, 14 Sep 2023 18:08:45 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D951869C3
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 18:08:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-59be8a2099bso13095297b3.0
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694707722; x=1695312522; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0DDghFH/s1gXOMYDyjlpLFjXvp4oWu58XPO2i94j4hE=;
 b=huaR9qZgjXyrZgP/H97guITqKK+SeAmo9yDDB7VUxFty+QeWSAOgUJoQIrLBZHRWzM
 lkjQrgV410BYobeYX5shN8RPVJKiAe+EnNpMCcF/i99KX0LwUj+UkVKsHd+EJtew7qZM
 23FULhIrXTrNxyVRrLZbQBlzBmMjU/jzd+E6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694707722; x=1695312522;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0DDghFH/s1gXOMYDyjlpLFjXvp4oWu58XPO2i94j4hE=;
 b=T+F+9JrId0FJOMAjOjWeRcPchgNTrOkd9g3vqLIy9Q44JSpczjzJoo0m81o30N992u
 zaDBbET2HafSCKbiCT7wV1Q1JNYUsCZnYbEdWzZXAas/PN3KPtz743T56zfanHo0Psil
 /3bguexkhbc1eYCaiBHZojMJkT2mcp7U9T11QlJ13rL+Ecv0xS4rBfT33Qk6EsG7qMCB
 QyNd6XGpUGt4kQM+B2/uq+7kunlEvsVICFQ9hduhow2ENl4duhpInpowpbUtjwauhe9W
 q0fbRmsYpxokGjzsTScmXNDuXmEaGLPJWSk56aenuO94mQ3jnrc4xqTYYTut6pKXOBKV
 H80Q==
X-Gm-Message-State: AOJu0Yw+gbZBdGZ2EFJkXJdinYvIB7SCjK4ekVoMjhDQSjm0AjpJwCUL
 iNvnDRmR7vbfRQeTh+7pGMhE6w==
X-Google-Smtp-Source: AGHT+IHMmsDYbmOl9zzvlNemVFTpJ5WuQdU7eIfKegvwRu5czLI9nWZtDv50DZ8jvDpzHmOzRD2QPQ==
X-Received: by 2002:a0d:d854:0:b0:589:d942:5e8d with SMTP id
 a81-20020a0dd854000000b00589d9425e8dmr6415786ywe.9.1694707721939; 
 Thu, 14 Sep 2023 09:08:41 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d1a3-6cda-a8be-914f.res6.spectrum.com.
 [2603:6081:7b00:6400:d1a3:6cda:a8be:914f])
 by smtp.gmail.com with ESMTPSA id
 x11-20020a817c0b000000b0054bfc94a10dsm385976ywc.47.2023.09.14.09.08.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:08:41 -0700 (PDT)
Date: Thu, 14 Sep 2023 12:08:39 -0400
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@denx.de>
Cc: Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de,
 ryder.lee@mediatek.com, weijie.gao@mediatek.com, chunfeng.yun@mediatek.com
Subject: Re: [PATCH] drivers: mediatek: Fix error handling in
 mtk_i2c_do_transfer
Message-ID: <20230914160839.GZ305624@bill-the-cat>
References: <AM7P191MB06955AC8974FA0226ED937A5DAEDA@AM7P191MB0695.EURP191.PROD.OUTLOOK.COM>
 <ae5d1c8d-a01a-0986-da4c-b64f755ba090@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+1zwSpArV6s3RpHz"
Content-Disposition: inline
In-Reply-To: <ae5d1c8d-a01a-0986-da4c-b64f755ba090@denx.de>
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


--+1zwSpArV6s3RpHz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 05:16:43PM +0200, Heiko Schocher wrote:
> Hello Francois,
>=20
> On 08.09.23 18:47, Francois Berder wrote:
> > Errors were handled only if an I2C transfer timed out
> > and received a NACK which is very unlikely. This commit
> > changes the condition such that errors are handled if
> > an I2C transfer times out or received a NACK.
> >=20
> > Signed-off-by: Francois Berder <fberder@outlook.fr>
> > ---
> >  drivers/i2c/mtk_i2c.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Good catch!
>=20
> Reviewed-by: Heiko Schocher <hs@denx.de>
>=20
> @Tom: Can this go into the release so late? If so, I can make a
>   pull request...

I'll pick it up, thanks.

--=20
Tom

--+1zwSpArV6s3RpHz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUDMAQACgkQFHw5/5Y0
tywnnQwApdbwo3DrPQYSYNLETYKzW5yZSfu7coyXcSW6TXpLXeHa55HpXy+Vw/Xx
nc9agQ9r9+R9HmnCoBqGC07493r6W/mKkwPvzUBfoWWix9zmSiVEkoRuGErX48s+
o6K7Phm6r0Y4jzgdNeK7sD+uX8aO2rRIZcR1e4dHfvQT1AXEoNDcfq3v14wgWIcS
44PABQsNN49AFFCqxy/teqAIF48bYZe1ZMrYAGzG+tyeBkbuSUCCjknySjC/M+ct
ONLC+L2Pr4LE2yHEazSuvbjIrLoql5XqeyF6iTRYeQHlCV77JbQ3FRscK2N/S8FS
BHrH/MikrXHDZ5xhdKkpytYsp2IW80rMvGTUYyuTOIsLwk2lYTXV3+ti9LK4/4ER
25X/4ku+Ox40jJXBCJpuFJ/RWJaGFEP84wZ2ACsLfCyoVM8v2LtYvOB6LxoPk64s
NfuQe1Eza1JGuMLUmugGcj6cwgOcpSxupTYXgdGdLi2hJuUtJRtWyiWHIfBrdP0M
JjHD7f8p
=DIFd
-----END PGP SIGNATURE-----

--+1zwSpArV6s3RpHz--
