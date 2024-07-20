Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A5FBC3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 17:14:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB46488845;
	Sat, 20 Jul 2024 19:14:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qZ0beyBT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 821CA88860; Sat, 20 Jul 2024 19:14:22 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 682D0884BC
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 19:14:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-706dea920f3so1378066a34.1
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 10:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721495659; x=1722100459; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8loVbkb8m8vGN6/0kVpkglgJYN9ScAPRJ8PdoeWP720=;
 b=qZ0beyBT8otpQtJDHZbLsHuWXHEKtBLDsN3CAAY7FIHmKkwxKDGgTosRsUkFjKDx0e
 jNosniH7Frm8USeomjoEsjNsMkHOPF0zkkpnb1ZLl7Pb+rjtSMD1l8QUAtIOYasrfFDy
 DIDIggLfxG3HOqW+LehxIlPptdV8hIXFXU40A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721495659; x=1722100459;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8loVbkb8m8vGN6/0kVpkglgJYN9ScAPRJ8PdoeWP720=;
 b=s+XAcaQ4Mne3y9H5HQtfmGY/68LLWZsXihdzoALUNZIoSYULzYXcqbi14+oQocJAZi
 yFJqtIIOOiYS3oh7dOmn7n23moo9CRuU5bUVjXWMqeE0B0XOtc0agdgQYm4d3AsA7p5T
 1Mww1U/frwfEXxvK2wyyrf5zk2Ep/5vixuTibnz6HaOhQ1byawCEUbO+V/PwY9kVVj5t
 IUCYgwNyrvDmbHTgvXndgI4PiaDxJsyQWHU8B3XjfREzjVzh1me7Hocrq9o4Z8FC3Ai8
 O4RP7+SKw3TCyEkdGW727Fy7DtcW3m/c8TJHTcnv4NY/Cj1m7QYWvjYJF4vaoi12z8Y+
 FigQ==
X-Gm-Message-State: AOJu0YwdvBOdI/uUbNGW/QJADC07XrbOwZoqvnwva5bEkDhNndqZpV8Z
 spS9B0OwW4zQc5/t+EOAnALrZ+iJjvUIohjoIlypjvgmJ0h+abuUtvZWtXkWqKs=
X-Google-Smtp-Source: AGHT+IGfUJ1Wonm6IyIgH0EF61tRcgqSPgMxUJUAlzn4LYw3brdx7sYrSussEET44zyo1B9f84HQXw==
X-Received: by 2002:a05:6830:378d:b0:704:49d1:6c93 with SMTP id
 46e09a7af769-708fdb3b456mr1457847a34.5.1721495659173; 
 Sat, 20 Jul 2024 10:14:19 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708f6195e28sm773993a34.75.2024.07.20.10.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 10:14:18 -0700 (PDT)
Date: Sat, 20 Jul 2024 11:14:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] sunxi: dts: arm/arm64: update devicetree files from
 Linux-v6.10
Message-ID: <20240720171415.GG561963@bill-the-cat>
References: <20240717143415.343827-1-andre.przywara@arm.com>
 <20240717175153.GR561963@bill-the-cat>
 <191A0F66-E2AE-4D1B-ACBE-E411E135BB61@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xTSkFB0xJ5Uan9zl"
Content-Disposition: inline
In-Reply-To: <191A0F66-E2AE-4D1B-ACBE-E411E135BB61@arm.com>
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


--xTSkFB0xJ5Uan9zl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 11:21:54PM +0100, Andre Przywara wrote:
> Hi Tom,
> Sorry for top posting, am on the road.
>=20
> First: The Allwinner drivers in U-Boot work with mainline kernel DTs for =
ages, so there are no code changes required.
> We manually sync the DTs from the kernel for years, but I always do one c=
hange:
>=20
> In kernel v5.13 the Allwinner IRQ controller (not the GIC) DT binding and=
 DTs changed in an incompatible way, and some critical devices now route th=
eir IRQ through that controller instead of to the GIC. If an older kernel s=
ees such a new DT, some critical devices fail to probe due to that, and the=
 kernel does not boot. Using the old DT routing fixes that, at the expense =
of losing some advanced power saving features.
> So in the interest of  better compatibility with older kernels and $fdtco=
ntroladdr (default for UEFI boot), I always kept the old way during the U-B=
oot sync. This affects all devices with the popular H3, A64 and H6 SoCs, am=
ong others. A20 and older or H616s are not affected.
>=20
> So my plan was to migrate the latter group ASAP (after the v6.10 sync), a=
nd then maybe the others in the next cycle, which means pulling the plug on=
 original Debian Buster kernels, for instance. 5.13 is three years old by n=
ow, so I guess this might be fine now.
>=20
> Does that make sense?

Yes, that sounds reasonable, thanks for explaining.

--=20
Tom

--xTSkFB0xJ5Uan9zl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmab8GcACgkQFHw5/5Y0
tywviwv3eqNqWeeffp2JhUfw4aW60YZQZ4PtvZ7oaqtrzqVzwj82AOfY3T5ihh3F
6nw3l15O4qDDXeUY++MCMHxQ+w6Gm0sKmpk9p7B0mV7xTKsq2lp7YghVzG1Y/vzg
ATYmfaw6Nw0pHXOljIrO0Fg05bUUV6OUwhqlx9/5Teahpqh4i+3FuAieZqafWITK
DBBCcTsBS0S7ZDBNVEsaYwQtQqalE5HskUCktTnTU6A2CJvUWHIQ9O9IzbSsOEjg
wtIuNQWbbSAvbCU3kG8BsuUKbYK8mUbLYWDx1nPHUsgrz3xMl5rRyTy2NmIiF11N
9kHz7Vsc1T+3sK4mx0B4gUBzL9zFGv8cUHfl6KrUrPNEybGKDpRynyIea327U45G
QpwTeKsoB/OtpE1FUEgpFZ6M449n7iQEpcZ0hFHPf8oYUwBNOvRGbuMUltnrfRZ/
0rNWZWEfdHQN5Pqc+cfT/GMnJHnBbEJgp3R72V5QSW0Yar0fG9eXiB3/9GTuFwhD
X6pKsO4=
=HQMt
-----END PGP SIGNATURE-----

--xTSkFB0xJ5Uan9zl--
