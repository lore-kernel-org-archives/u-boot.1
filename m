Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A13C001B0
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 15:04:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A251386895;
	Mon, 14 Aug 2023 17:04:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PuNgrR4B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8958A865B6; Mon, 14 Aug 2023 17:04:14 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 360D486927
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 17:04:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3a7781225b4so3623634b6e.3
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 08:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692025451; x=1692630251;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=29+/nP3xLslOoqLnr2Xtqp5LP3/zx5ykaSuc0tbstxI=;
 b=PuNgrR4BYWkbzOlDdBIq1S1zE7HM2YlKUM7Wgf5fcqOISeGTZ7bRIWu6Bo/KIa04vy
 R0MBMfKQ6KjdZX89vSRHByLZmFbpxdu4WJnB1wiuX6zYfl4tcLiu2UennwC1HPAffKdP
 BA/7dwai9ciUF97qPl2U27kuWmmV8yCs72frw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692025451; x=1692630251;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=29+/nP3xLslOoqLnr2Xtqp5LP3/zx5ykaSuc0tbstxI=;
 b=DdCdCzPSZ55Vcqrad1tPYMB6J/hb5aUQALAiIbZiUy7Lu8UaSniwaNyeedieOPMibB
 TvxqtiMC9Pwx1R8wbhHtUTBtk/r3+eobok6EOO6+RuvrLdh41l1WBKBoVAG3bIAX9+8z
 Yaj/dxL8qQuFLsYzvmNgh2fgULGENtCmcTArr5OCiRiMG09mRvTvDmr4tgdjpe8N0UtY
 T0rQRmmGJso48u/WtlRLUlOA7RAGLFOCbtwu43CCSDkZv7oz1OkIqr5bzDfNWjPV40uf
 7gNrY2C831NAzv8nWnqDkFDzOv7Xc37maEa4AYQX8yi73EfjOGR3PhfA/4KnEoiZRoWc
 D/kQ==
X-Gm-Message-State: AOJu0YwaZklopJOFQ5ZF7wJ90Em91Eqss50n3PQEo76r4E6VZpcBzwpf
 My+FPejkjpNPSX+PIEGt8dYf4sg28YXGR6yVPZi3bQ==
X-Google-Smtp-Source: AGHT+IFurKkZO3xK0RGPkKHJuR2hdzrm3+Rd9XfB8bHcOANh7J/hsKaSzFJ3bpHViZoOQLJ0SLbg3A==
X-Received: by 2002:a05:6808:17a6:b0:3a3:640d:ed71 with SMTP id
 bg38-20020a05680817a600b003a3640ded71mr10860936oib.10.1692025450759; 
 Mon, 14 Aug 2023 08:04:10 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1d1b-2873-dbaa-7ea0.res6.spectrum.com.
 [2603:6081:7b00:6400:1d1b:2873:dbaa:7ea0])
 by smtp.gmail.com with ESMTPSA id
 g63-20020a0dc442000000b005772fc5912dsm2832960ywd.91.2023.08.14.08.04.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 08:04:10 -0700 (PDT)
Date: Mon, 14 Aug 2023 11:04:08 -0400
From: Tom Rini <trini@konsulko.com>
To: Anatolij Gustschin <agust@denx.de>
Cc: u-boot <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-video
Message-ID: <20230814150408.GT3630934@bill-the-cat>
References: <20230814080254.1be1094e@crub>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rHqyDKMfw30GPos/"
Content-Disposition: inline
In-Reply-To: <20230814080254.1be1094e@crub>
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


--rHqyDKMfw30GPos/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 08:02:54AM +0200, Anatolij Gustschin wrote:

> Hi Tom,
>=20
> please pull video driver fixes for for v2023.10.
>=20
> CI: https://source.denx.de/u-boot/custodians/u-boot-video/-/pipelines/173=
38
>=20
> Thanks,
> Anatolij
>=20
> The following changes since commit a5899cc69a99379f01e8e2f9f98e0e09b24f16=
56:
>=20
>   Merge https://source.denx.de/u-boot/custodians/u-boot-watchdog (2023-08=
-10 11:40:09 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-video.git tags/video-20=
230814
>=20
> for you to fetch changes up to 04cc66c047d959dc1b22a625b7949a26793ac52b:
>=20
>   rpi: set the correct parameter for simple framebuffer node (2023-08-13 =
23:57:46 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--rHqyDKMfw30GPos/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTaQmgACgkQFHw5/5Y0
tyyoiwv+IbB8jKhchDYRzDerCt2WpxE7B+Iy8BVgfg2JLBJkfvB5UAq8sgJ8yJr4
N/CPYvnyPi1x1aLcbzcbvf1kL/x6X45TWv2+e9hV+ESiJxwmk38i8C9insaEG1qu
McuZpMzVYpTc+bdVufpAKgsAWJCLX6F4DXoJTu/GFhQE8cem6wZy0hBlx+CJ0HF9
WCCNaRHPzJAuUzs7FOIF7A7ybkbbm/1vM32EoXk2MuyhEGxKd78Kj3QUOBfXG3tH
7ijmfNYn/mzdF8lGj1gWBQ/fNdpE6Uz7CO8xnpUpeQGVaAii+wbfC/UryzHToG8E
Ld0JkhyNW6zZ4/cZ6Oo2K3LpssgWvqZdEuB7OkpSwR3pQ2S3YLB2WasRznL9jS0g
CW1tddBFN2jopDCpi1eUscC96U4a7N6CV8QvYPLhCP6gfArcbwAzEBMtqzzGI0Fl
vFGsaE3BXJ73MExJJFWDWehwGDeJup2kz6oFoTu6M/vkTTXWZjM1RbK1nF3oyACR
lC45s8lS
=se3H
-----END PGP SIGNATURE-----

--rHqyDKMfw30GPos/--
