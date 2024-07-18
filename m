Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9671CC3DA63
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 17:13:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4914D88B0C;
	Thu, 18 Jul 2024 19:13:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NrBxNEqw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CB2C88A8E; Thu, 18 Jul 2024 19:13:33 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1EE188ADC
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 19:13:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3d9e233873aso603950b6e.1
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 10:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721322809; x=1721927609; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qihi6oJDe0Qt1mY3/VAzR7MiaeB+lT6t6ZuMejIc39k=;
 b=NrBxNEqwx0N3vlHT3o1zvhC4QCXLt+M2aiOPAQZb+DR+jwrXWDv0IZBQaXa9cSlEMY
 IGWzOZCyprg/N99135nnfntV3E3Tze+XQhAvEKf+z/2MfHV+1ITzuIAXudl6s74y7+xe
 44iYtJvky0yogyzXTCfMmix4Ivj7RCV6qX22g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721322809; x=1721927609;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qihi6oJDe0Qt1mY3/VAzR7MiaeB+lT6t6ZuMejIc39k=;
 b=K5d7USbMV2tSwSpiftLnUIvGyaXtqupea6XSARF5vC/MOjCwjw9UTootLWc4ZC57Og
 1BS50QeSIj5cHhz7g+OeWqDT5d6xmrsy/5jMoJRdw+TXtJBD05/9+gbiaMoIxOWPnc2q
 9+mq1lESpDOE3+9Bwpw2YrVtjLVsgjvSj270qFpUcBcKhmvUOHhoCshw2Fhh4pKYTK6S
 hT2bIhe0ec3c6YsFhr+gQ77K0XsHHcKkEnXqP+SEGJa+YjpmUcWcu1oP3Q1cT2fF2I3/
 E6MdJdIUw8aGCoKv+xXgRBwKrnUjHuBZRUPZwyyFkKbHuNvNoz4WSAlNFwNUteM+Lo6u
 oomw==
X-Gm-Message-State: AOJu0Yz93e7bCZ8Jvf73Y1pCMOUVdfzvQGQo8oyyoLk+bLXecJSm1saV
 6QnYOZGFD68vZomLOGH/PnC+0a9zsQX+h9TQHvInl2InEMXuRvjpmTrPGUaX4OFkiPvQ1Pw4v2p
 KlQ8=
X-Google-Smtp-Source: AGHT+IEOLTABwwGcBpPKFX5Dz1zxixZfO+ca8id7ychQbZr3lUn6Jp0oD2kDpvkvqgSaDbcWUHI/Mw==
X-Received: by 2002:a05:6808:1494:b0:3d9:23ad:1ff1 with SMTP id
 5614622812f47-3dad1f216a9mr6628669b6e.3.1721322809270; 
 Thu, 18 Jul 2024 10:13:29 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3dad52bf232sm486388b6e.48.2024.07.18.10.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 10:13:28 -0700 (PDT)
Date: Thu, 18 Jul 2024 11:13:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de
Subject: Re: Pull request: u-boot-rockchip-20240718
Message-ID: <20240718171326.GY561963@bill-the-cat>
References: <20240718083341.401564-1-kever.yang@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4RMpHH1P3mc+aen3"
Content-Disposition: inline
In-Reply-To: <20240718083341.401564-1-kever.yang@rock-chips.com>
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


--4RMpHH1P3mc+aen3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 04:33:41PM +0800, Kever Yang wrote:

> Hi Tom,
>=20
> Please pull the updates for rockchip platform:
> - Add boards:=20
>   rk3328: Radxa ROCK Pi E v3;
>   rk3588s: FriendlyElec NanoPi R6C/S;
> - Remove board: Theobroma Systems RK3368 Lion;
> - Add rk3588 pcie support;
> - Misc updates for board and config;
>=20
>=20
> CI:
> https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/21635
>=20
> Thanks,
> - Kever
>=20
> The following changes since commit b182816c1fb436916661949213c543bf4d4225=
0b:
>=20
>   turris_1x: Normalize Kconfig usage (2024-07-13 10:42:15 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boo=
t-rockchip-20240718
>=20
> for you to fetch changes up to e8b3f6c1018e1401bcc697a8aed8120061e4f189:
>=20
>   configs: rockchip: imply OF_LIBFDT_OVERLAY for rk3308 and rk3328 (2024-=
07-17 16:26:55 +0800)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--4RMpHH1P3mc+aen3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaZTTMACgkQFHw5/5Y0
tyyJOgv/QldhW0nv63DGILqj+SzIaCtrepkkaMcuvPd6SBoic0UaJHiKCQZYlBp6
tRpGqY5oIbrqgryQrPyYKKNoaMC48qMh5cyBKbFR5akue55dReV0xZOv7Oera1xu
dGqyg3DfbHTt4eEYgDRsx5Z3h6JlsHZrpzenktPilYxW3BVo/2CQ0786sgSq36hB
DtE2jg3e/4s+ATqzPufOCtxdcjKKDch7QJH2xYaUiomT3uU5eYTX8onrNNlhRbZq
+i0G+l3twt9qAh62NQfW1dbN3bKH+be1e2A3WtjmArwJyPWxHw4j+jio4aY9n9y3
nI9KxQcJCeroVAuxy/BZAHgY/kkCCxq4eyE9HIIxwau0XlLVlrEVVMS4W7693FMt
j+gzDk9xMzsOQmS/2jDShQC23sA6qh9ZgdO+GIiww51Xxc5tycoATM4vsnmgu5lH
0wGq/l0frbT4363MEHKtWYvSA3yzIAuOIghb2vOqAHp6aG4UuDwqTy4kVEDkLyPa
OkUXeTEM
=CnSL
-----END PGP SIGNATURE-----

--4RMpHH1P3mc+aen3--
