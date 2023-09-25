Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722CCCE7A81
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 14:02:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A7C486D3E;
	Mon, 25 Sep 2023 16:02:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nsG8DH2O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8196386D3B; Mon, 25 Sep 2023 16:02:39 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24BF386D49
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 16:02:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-59f630612a4so38320107b3.1
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 07:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695650556; x=1696255356; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oN17j+r/esR9jdyFjC+QOTT2bfIbeaXybXfg4qRpXk0=;
 b=nsG8DH2OgNIDsalwGiLtimwDsnqDF1kA8wAdKvmGySjWYw2iJIyvksC9nSzpfkXkvS
 BPOJ5YYUijo1cwnMabJLU1w3MkW2JIiwMETDiDKaViIvo44ha32b8O3uf3x/eK5YZpUK
 bihTMpDj3b8RCePhB3nw8gLj3BPOWB0JLs9RI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695650556; x=1696255356;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oN17j+r/esR9jdyFjC+QOTT2bfIbeaXybXfg4qRpXk0=;
 b=LlxP6/mRNW0skx4s1fBUm1Chab4ehBpSqBfct8hrVK6fyi7sA4jPeGxJcCnz4q1Ezq
 PzXOXlHLnA2xvfrFSvk1t9K0XLZWQxjyThb75+Ze9m0lmdCRyVE/LrfNdwaA74wjrhEH
 9b76r8xpdy4RUJvODHxbRw5TbChiyiWq8rNWXte1HZnHfAnX/5F6rF7xJKyiqyIqSa4G
 zKUEXuwKXfyjhjbLPZWBEXFhi31PiWhr7x7X9JbD7N/eKBN22/q/kxutV6knDkXmUz/7
 JV4OqXppj/dy7y16daq+zgQuNn6Vcy8STLdq1EUHC7gbhLfujdi9VF7GL4BX7ODIdn/2
 63Fg==
X-Gm-Message-State: AOJu0Yzlb2EvuJ471BjkqHGbRQNjIeJblLzHi+jebK3ZArn23FlGwwrI
 /U0NUOjUn+sP9ZC17a51wndNaGC7huhOrVhKEQgZJw==
X-Google-Smtp-Source: AGHT+IHSHkjbG5vt1sXyvNcfaQDm5gXFwjP4pM/VsrlMxcGP0sI5rWWi4k1RaRvygM/YhiUhEfFpBA==
X-Received: by 2002:a81:988b:0:b0:59f:6212:e174 with SMTP id
 p133-20020a81988b000000b0059f6212e174mr2967143ywg.12.1695650555669; 
 Mon, 25 Sep 2023 07:02:35 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d32b-b307-decd-cdc4.res6.spectrum.com.
 [2603:6081:7b00:6400:d32b:b307:decd:cdc4])
 by smtp.gmail.com with ESMTPSA id
 e62-20020a0df541000000b005844ae2bfa3sm2439284ywf.95.2023.09.25.07.02.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 07:02:35 -0700 (PDT)
Date: Mon, 25 Sep 2023 10:02:33 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-dm
Message-ID: <20230925140233.GR305624@bill-the-cat>
References: <CAPnjgZ2kgk1Oc17wNJqH+33PGYf150Aaex_ZnoZMY45f0YsifQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="knvPKYCIQvezeypt"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2kgk1Oc17wNJqH+33PGYf150Aaex_ZnoZMY45f0YsifQ@mail.gmail.com>
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


--knvPKYCIQvezeypt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 23, 2023 at 12:16:40PM -0600, Simon Glass wrote:

> Hi Tom,
>=20
> https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/17830
> https://dev.azure.com/simon0972/u-boot/_build/results?buildId=3D48&view=
=3Dresults
>=20
>=20
> The following changes since commit 4cb31a9f3560b293670de95e76c1f3cf2f9e1c=
a8:
>=20
>   Merge branch '2023-09-22-assorted-bugfixes' (2023-09-22 18:25:37 -0400)
>=20
> are available in the Git repository at:
>=20
>   git://git.denx.de/u-boot-dm.git tags/dm-pull-23sep23
>=20
> for you to fetch changes up to e278ad9a2ea5e4a089773a8fd79a5ea0e8572316:
>=20
>   trace: Fix alignment logic in flyrecord header (2023-09-23 09:00:37 -06=
00)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--knvPKYCIQvezeypt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmURkvkACgkQFHw5/5Y0
tyyefwwAqDXlPSIIy5MivfLXfzWu6G3WB5MrG5MxfnjcnywS4E4eftKWGpXYUxfr
RN0rTU9bIpgKGKG9EDQQhPXQfTdON/FZVBvgzPMg8lZcINtHUQEnuAd3QZElCDri
epK96DAsp0OPf/HvuuaVsZdB/Lxdh1jXRUDo9sugl/mtITfZ7YE6UvZjz1L4Tatm
uKqLW8gFa1bSQlnnQnSYiHcYvOZ6Bzz5SinHqhL6a37GBXJpuI4Gh8o0tUSZeLTX
zldHMk0xOiRFlyLbD80oHRZaAPG8ZJ0Dr+dHatbOOwrQRsTbekTwDEpJHmjIXsBd
fQTbPoBEFaBYnH2gHfPQC/7BOr7yHGSBP70jva/tPuW7zJakML+C+toIlabiIUpc
p+aK0eM+FoVQARjolRi52AycfQZN6+YqyYO90CMkL8eLX3175fbp8u+zR5sJGkbM
0OVu6yBHuSoWKwZGSx1UfVt4oPHUqL1gh1tAv2uiP1QYRYDF1GDM0ZQjsnNBZy68
F3DD2us9
=Fh/Z
-----END PGP SIGNATURE-----

--knvPKYCIQvezeypt--
