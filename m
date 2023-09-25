Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD190CE7A94
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 14:22:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3129986D38;
	Mon, 25 Sep 2023 16:22:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hW6v5MLe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFC5F86D38; Mon, 25 Sep 2023 16:22:09 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C90486B2E
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 16:22:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-59c215f2f4aso82735047b3.1
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 07:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695651726; x=1696256526; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JjvI43wAw71Hgxdpfq1E0Z+sTG6LjEtgvLBvLt2Si7E=;
 b=hW6v5MLeLLzXhMqqfqW8whAMNpCdFgw3ShPMlzWL3YDt6wg2QvEUKoTS8SVTkX1ZU0
 IJs2khZ28EkVTOaFCPKzpYCqGFVOOHdzkn8auy7IsyDI+gCuu9fsW/NGXH0QYeEXz4Ul
 iqtp4s7nOHionCMOef4GdniRKSkpHWeYunNX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695651726; x=1696256526;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JjvI43wAw71Hgxdpfq1E0Z+sTG6LjEtgvLBvLt2Si7E=;
 b=haQNjaS34YnlpC7e+icoMopNZtmP9rbZX61dNfMOdzefy1eS6dVTCvisZ69u/FJ/I2
 9vFTtOCpcpQ4IiQpBAbleGSmK1w3h6UMQHuOc76bVdyC33m6pEewNyQhKnAI06rQe5sw
 OE+kuTTI7tyNbioPA/N0Nyo4XFAtJXL46if7jap5aiu1CWU1s125ignoU5IhvoPe2iOe
 wCSPoA+YA5EA5lGYziSVBOzmJ60p5A51xvypS5XzVlP3v7ETxPFhkXGDh8AHTsQ9v7mV
 /RTf27FoiC26Zp98q4hGOrpe4HSGbPdtysygyxkVHfRL49wjc39kQt/ql+ieHgwhV0ZC
 pyWQ==
X-Gm-Message-State: AOJu0YypglsmGLeXzZhoNPeDGvjAuD2El8UQp3R1qQT0TQbVpMpJ0Zna
 1varIcYFoBx3CJzCrKS2JWwL9WBRWcoKXSkGRoIjRg==
X-Google-Smtp-Source: AGHT+IEcdjNPN4yU2dMx4ksQtRrgwPDWrB3MubO0/bDFdjQKwkeO0j7B/NsiYqS7c/wz2EyIdJINxA==
X-Received: by 2002:a81:4f4d:0:b0:586:a170:7dbe with SMTP id
 d74-20020a814f4d000000b00586a1707dbemr6811211ywb.13.1695651725931; 
 Mon, 25 Sep 2023 07:22:05 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d32b-b307-decd-cdc4.res6.spectrum.com.
 [2603:6081:7b00:6400:d32b:b307:decd:cdc4])
 by smtp.gmail.com with ESMTPSA id
 t190-20020a0dd1c7000000b0059b17647dcbsm2405867ywd.69.2023.09.25.07.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 07:22:05 -0700 (PDT)
Date: Mon, 25 Sep 2023 10:22:03 -0400
From: Tom Rini <trini@konsulko.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] bmips: Add Inteno XG6846 board
Message-ID: <20230925142203.GX305624@bill-the-cat>
References: <20230920074225.1130769-1-linus.walleij@linaro.org>
 <20230920142252.GO305624@bill-the-cat>
 <CACRpkdYqO1nH51VxjbpnPjaPy7eHaMDCSP5tWBDB1SB3R0cCcQ@mail.gmail.com>
 <20230920185547.GP305624@bill-the-cat>
 <ea1b9ef4-0cf5-ed92-2b70-6d8f70be17ac@gmail.com>
 <20230921172506.GV305624@bill-the-cat>
 <CACRpkdYWK15i=KEFc_VM+xqgmmnT6AQX3OgnznFrmPhkjCfOiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1onmtoLxzj78Jzul"
Content-Disposition: inline
In-Reply-To: <CACRpkdYWK15i=KEFc_VM+xqgmmnT6AQX3OgnznFrmPhkjCfOiQ@mail.gmail.com>
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


--1onmtoLxzj78Jzul
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2023 at 03:56:07PM +0200, Linus Walleij wrote:
> On Thu, Sep 21, 2023 at 7:25=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> > On Thu, Sep 21, 2023 at 04:00:24PM +0200, Daniel Schwierzeck wrote:
> >
> > [snip]
> > > I just tested it, you can simply add an empty board/inteno/xg6846/Mak=
efile and
> > > remove board/inteno/xg6846/xg6846.c. But you can also remove the Make=
file.
> > > Just the Kconfig and MAINTAINERS file are needed.
> >
> > An empty Makefile is OK, but no Makefile requires a bit more as we first
> > try and include it unconditionally and then try and link in built-in.o.
> > I'm poking at this now.
>=20
> Did you get anywhere with this? If it's on the master I'll just rebase and
> be done with it, else I can go with an empty Makefile simply.

Please rebase on top of:
https://patchwork.ozlabs.org/project/uboot/list/?series=3D374302

--=20
Tom

--1onmtoLxzj78Jzul
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmURl4sACgkQFHw5/5Y0
tyzoJgv/fgIx08JonqQTXUVjMxvjDjY1pr2haJ7pR+ExbrD0OX8HKaDKY3p1gDyx
TtJuWhN/APIn/RijatI9TQyacNYaTF8hxmmSaToXzlGbRwgHLwWj6BjVPmy1glx6
iKExy2Obq8DpVCtmzHVl743pbuX4mOAvOjEXqtUyoOdQzYGhQv+8RR0b3pFzoNEE
ETQATnojlNBODEpRXzwfpnOrOkXNENQmKUL3UJAuy6ztRBVdqEdZeFTM+oFuFrCi
0DxPXcvnlEogZKXQQlMKM85aIdVtDV/NzWgvDTgdV+BoZoiqIvT+/7/W5a1+GJca
nMy0JkhuGIcFWoPt3/Ng+OxOPRh+pqZfglXqTHH8M6P4ylKEzQKrE6Nphn/YPr+y
M9ouU6OUB3+VEnZurhA+TjjITIlt49IuTmz8q6IgQgdK41i8I74IeeNapNztV80k
+4RxdLNedkHp5yLjX+FWFxrr5jUONoB0XjBVhVJCULYPhlEk8PuK/rwzbXZvHG3N
xHaoQ2lm
=3cOR
-----END PGP SIGNATURE-----

--1onmtoLxzj78Jzul--
