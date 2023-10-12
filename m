Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEA0CDB474
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 21:38:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B179B86E14;
	Thu, 12 Oct 2023 23:04:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jAjdt5YF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7C7586C79; Thu, 12 Oct 2023 23:04:19 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DA4D86D17
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 23:03:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-59b5484fbe6so17961077b3.1
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 14:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697144614; x=1697749414; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bb/JyiJHPcgCrVbg3IL5yhQI1Gx5UJZnY4o3/PDI0LQ=;
 b=jAjdt5YFwqLWUZsdN32bOcaV4q0B2IeDN8lz/zhRcBskQnC6TAngt77WzEO3/H4GyU
 vp8YSAv/eCGt4ry+Gt5vjHHknz6UiNhxCIT9XueMpMrpTuPMOFoMGnQ+s25OtfovPQPa
 JPTt2QrBYqGBs1wvwS+vFXX4cUUhVRiUDSxBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697144614; x=1697749414;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bb/JyiJHPcgCrVbg3IL5yhQI1Gx5UJZnY4o3/PDI0LQ=;
 b=aQzMvoiE9DRIg71XsDnE/mCL+9ZSaI91H6OLlZkiWEEryH86d3muBBeCRHAscJeUFN
 evqHBs0RU/CPDx7U4hlsWIhVZEKH3C1//TT0RhN9GdTEgWNUtD+ChYfs7VYWGUziek4J
 B402uwa6zA837j5MaXThEexnEPVPkSG6ejPFwG/h9r/vXbXOrEIaRjpAYgQwDo4WFInQ
 yzKqK8Riu/LQXV+gkG6+qKzH2CsQlIutXp/GBTaaZUOFZGEHbvRtNgbIoVNTmCsTQi+Z
 1bwYhTj4aQ05cPRf4uC3J2Qaeq6WF3G4ANg+1LBPCqL1JCp51OaxOJumxERoTpqsz8LI
 +AeQ==
X-Gm-Message-State: AOJu0Yz1qWT4VGuuC0pv2lrDnF2unP650jDE9InQng/VEvNexYO2KBvi
 3BXHN/kZD9Ej/J5jNHuJuCCRIQ==
X-Google-Smtp-Source: AGHT+IHz5DuDJEq/2WS+gehqYO4UtJng6Sxdm9jlWr+U8MU9qcFu4r2qroSx6TZwtY6Gal9MXs+Y7g==
X-Received: by 2002:a81:6203:0:b0:59b:bd55:8452 with SMTP id
 w3-20020a816203000000b0059bbd558452mr29030612ywb.36.1697144614536; 
 Thu, 12 Oct 2023 14:03:34 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5647-4a14-f04e-8d8d.res6.spectrum.com.
 [2603:6081:7b00:6400:5647:4a14:f04e:8d8d])
 by smtp.gmail.com with ESMTPSA id
 w83-20020a0dd456000000b005a1cc37aff1sm218400ywd.20.2023.10.12.14.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 14:03:34 -0700 (PDT)
Date: Thu, 12 Oct 2023 17:03:32 -0400
From: Tom Rini <trini@konsulko.com>
To: Dominik Haller <d.haller@phytec.de>
Cc: u-boot@lists.denx.de, bb@ti.com, nm@ti.com, n-francis@ti.com,
 vigneshr@ti.com, afd@ti.com, upstream@phytec.de
Subject: Re: [PATCH] arm: mach-k3: j721s2_init: Enable memory with
 CONFIG_K3_J721E_DDRSS
Message-ID: <20231012210332.GT3119521@bill-the-cat>
References: <20230811100444.32834-1-d.haller@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+TJoLzTrUlzu1Y5D"
Content-Disposition: inline
In-Reply-To: <20230811100444.32834-1-d.haller@phytec.de>
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


--+TJoLzTrUlzu1Y5D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 11, 2023 at 12:04:44PM +0200, Dominik Haller wrote:

> Make that condition more generic by checking if the memory controller
> driver is enabled instead of using the EVM's config.
>=20
> Signed-off-by: Dominik Haller <d.haller@phytec.de>

Applied to u-boot/master, thanks!

--=20
Tom

--+TJoLzTrUlzu1Y5D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUoXyEACgkQFHw5/5Y0
tyw3MQv+I0aQrB045LWh5tsVt/Ohv7Fh5atqnJgexd16f9UZv5jn/rG9/cAcwZdT
gh0sArO/kchXhPkJAiofceg5BlSynAVeF/NX/9aFxMoqE7YOU/rPflEv7d8Jyjax
zz7Uv2J3xtA+lzQqe9txeJnki96/xOqO9n6fGxal5dcuqS7/H+ZMw+HhR1f6Vrqi
tpx4sHrmdAM5Zg3kOoDvUfp/odpQF96zeVBaBlsBqEm/kH31VSkJ2Jotn/be/Wyn
yU8e2btSduSBzrV78rfRqMQVaSs0YZyEDFKZIB4a6VvConhHk82wlmu8GNkL7f3p
U8XW+H51z8PKeW9N4N7s40iubqRkPcXqAwtbEqAQFuHpp6qG/cWIEtWtq+N6XYMr
GuNyFvX6zKwTqmXkM/F9/WvZmChfYHBEtt2b0O8VUVaHt4UDbfFu92wFawovw8xk
vU7zjrupIJVTKEHQr+YLQ78OxGptW0n23IKabADEPHKKm+IA1KqXKpgMxFLOnRzq
X+9FdOtC
=R+Rk
-----END PGP SIGNATURE-----

--+TJoLzTrUlzu1Y5D--
