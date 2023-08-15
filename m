Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAF2C001B0
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 14:44:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C217869BC;
	Tue, 15 Aug 2023 16:43:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YmcNq7Yl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21096869BD; Tue, 15 Aug 2023 16:43:34 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C50D869BB
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 16:43:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5862a6ae535so52676947b3.0
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 07:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692110610; x=1692715410;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=i5cgL3xfvT9OET7VKPTsqzaVt3KgPZmtBHJljD9lfPA=;
 b=YmcNq7YlqP7nTcCi6JJ96JEkdOb2kokMUoKuxQeTNDLTgHSUxPgVwgqb+lEMRNOEXf
 lyotWrZ8THNM/jdNYjlr86DobWj58T/F5+UWk9V+kt0YUEyeRNEUKzwfB3lbBXzw873d
 lx+EDRjObjncCsA1YW7PM5CC6q+hfFE9q1QPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692110610; x=1692715410;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i5cgL3xfvT9OET7VKPTsqzaVt3KgPZmtBHJljD9lfPA=;
 b=ZKYj9EVnTX3JNpZpYcxGGIzKXeGhctoUs+XnP1l3zQXNUcmVr5xq4nN16hlLhnishQ
 Yqsb2zq3lpZhyE92HNpunxNraEHsjsAK55QpwIQmTTfwOdmFZtitQH/Ty8Mt87Js2QzP
 ZzoxLKCDh2RtGIj1HA5dXce2LCdYN3h7BkeC3b7VPQi0ECGrqGL8hI24u0ZEZLvD2LPe
 hThV68zwTwQZnU7w5IvdNabalOFCBTEr3NyRiv79H+LOqmbnFCSU0X7RoQnEVEvC7fNi
 XBDdMjJzE6I6ojqj/q73Tpfu/gx9NVrxOmH1ZgucMMY45XrgoEbCzUIzVLVrZoUI2DZI
 qOgw==
X-Gm-Message-State: AOJu0YzaNyjO2U+Zcz8l781eXOo9lrehImOK6lUlNjF3w3fxkFvkaBUy
 Ni++xH2nfsGZm4Qye3HtmYVtcA==
X-Google-Smtp-Source: AGHT+IFSD92jnSa483XZt0Nis6Y9GvgXGUhu6P2SrxvS47cHPD8LQJ5+3+AEgdFhGLXjasiK/wAByQ==
X-Received: by 2002:a81:5c04:0:b0:575:4b1c:e5f1 with SMTP id
 q4-20020a815c04000000b005754b1ce5f1mr11044258ywb.39.1692110610175; 
 Tue, 15 Aug 2023 07:43:30 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-14d5-2a24-c47a-465f.res6.spectrum.com.
 [2603:6081:7b00:6400:14d5:2a24:c47a:465f])
 by smtp.gmail.com with ESMTPSA id
 w187-20020a8162c4000000b0057a918d6644sm3435649ywb.128.2023.08.15.07.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 07:43:29 -0700 (PDT)
Date: Tue, 15 Aug 2023 10:43:27 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Sean Anderson <sean.anderson@seco.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] test: unit test for semihosting
Message-ID: <20230815144327.GT3630934@bill-the-cat>
References: <20230731200121.38095-1-heinrich.schuchardt@canonical.com>
 <20230731200121.38095-3-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XLXf56htwjxhZ3eG"
Content-Disposition: inline
In-Reply-To: <20230731200121.38095-3-heinrich.schuchardt@canonical.com>
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


--XLXf56htwjxhZ3eG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 31, 2023 at 10:01:21PM +0200, Heinrich Schuchardt wrote:

> Provide a unit test for semihosting testing reading and writing a file.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Sean Anderson <sean.anderson@seco.com>

Applied to u-boot/next, thanks!

--=20
Tom

--XLXf56htwjxhZ3eG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTbjw8ACgkQFHw5/5Y0
tyygOQv9EMy2AlCQUMD/j5b/IctoM0+h2Bfda4Vx3+TBQNJbEULC+/a0o/+EGV9E
ocK9uqaTFhklYWEX+wGEig6MCOObcKO2n9mAg+8vY0OAJvjUbv9CQ/e+odZC975W
in4JXsjh8iBBqfu5z2B//uVZJwjwhviJ1dLFNEAp1V9jrHtNDkQ5ETvpp+pllT9W
SM+Ln4x3Ucj7ARMhdj7gF9qI7znjSTlJiJm+upYbMZffVJO9okrPVbjcGjGI72Up
oKaYprKP9ujUX7d4XpZ8ZaT9DCmTLua5NTi5h7O3sijgLIDEtopegXOzRL6Rnh/r
u1FYwQYHl0FCz1YuZj1TME0fz6fxo2OEDNckmE2+4pWZrJE1T2PwhOQFlO1Wy7cS
BT8KC2LryvTO5WSoKp89nvDzZ/dt3lKrCv+o9jkYJt7cVsGwq2Ovh96bFEorza2S
LEf2TJ3ZDWM0HuCiprevZ4BNLjmjuBoRwDmYswTXaJCIKNdaYsYxbJLNa3FPgzg8
cuNijwMN
=ZqxN
-----END PGP SIGNATURE-----

--XLXf56htwjxhZ3eG--
