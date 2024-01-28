Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA320C47258
	for <u-boot@archiver.kernel.org>; Sun, 28 Jan 2024 14:24:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4348C87DED;
	Sun, 28 Jan 2024 15:24:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rDyTnSHf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C65F87E2C; Sun, 28 Jan 2024 15:24:24 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD26E87DC6
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 15:24:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-602cf7dfeb1so16530517b3.0
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 06:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706451860; x=1707056660; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pNZqgW5DQXUs4Tcrh/YLJoYzlcTnAKui0i+BTB0l8Hk=;
 b=rDyTnSHfFayTd3BrWvaarIGRwsikNd+jHx0ZDCK0/lgrhpCRXSEKvtL8ElVMTE+isq
 dmH1WUm1+FlPcLOohJeMkxP2gncc78WPH0W74tOypjW7hG52IqifJfUO7lcSC4GA2FkF
 XEvDGH8LiqTd2VA69yvBQMOkt8rnpQ7pSxilg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706451860; x=1707056660;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pNZqgW5DQXUs4Tcrh/YLJoYzlcTnAKui0i+BTB0l8Hk=;
 b=kjZ+FQNcE5PkfzdNv+A65nRjJQs6u10QirS89+qn+gUIT5t0g+DdhmikCzgFsMc+H4
 utrhiqug/qsvTCIcobI6H/P+/WeTMP6Lrwhxc8YeP+cAA+7F32q9CWNkwf4zVydroWjR
 ISeG4LufSglW9tSrs5FZcZBOKRgHPn8fHSFDm/8K0v0zEQEO/GjP2sdl7BDcw/bA2ANi
 ZVLEQLJm1cLDddVejMxPfDw9EOZZhURpVZfl53FaVrpcCRq0PROHQMtMK9cheuflbVEx
 81Qkgg7DKmvbRDNILeEhopTbkTkQmr4nAjfYPCrm+zRu01EDsiLP+6FjZwRxVwtRWJ2H
 WJ5w==
X-Gm-Message-State: AOJu0YyNX04t2+PsTSXfkRGm1PhjfsBQVn4InxVoI2d9KGP4I3ol3ED5
 yijUuyhXeLnorl9YJYBszOtbAUuR+0GXcXxxHpDNPQh6iabhFhhA37rjLTFZZzU=
X-Google-Smtp-Source: AGHT+IHQllpXKSyEb9wXkKIsivxwHMrn0yyBpsjecQbnIti2DnACTxccdS/30+X6MYqRruy1bsew/g==
X-Received: by 2002:a0d:cb41:0:b0:600:255e:9320 with SMTP id
 n62-20020a0dcb41000000b00600255e9320mr2272481ywd.21.1706451860355; 
 Sun, 28 Jan 2024 06:24:20 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 x84-20020a0dd557000000b005ffa1fbfa7esm1779904ywd.101.2024.01.28.06.24.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jan 2024 06:24:19 -0800 (PST)
Date: Sun, 28 Jan 2024 09:24:18 -0500
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PULL] u-boot-sh/master-cleanup
Message-ID: <20240128142418.GD785631@bill-the-cat>
References: <20240128012125.60127-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="N+6bD5sUB76ZaTqB"
Content-Disposition: inline
In-Reply-To: <20240128012125.60127-1-marek.vasut+renesas@mailbox.org>
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


--N+6bD5sUB76ZaTqB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 02:20:50AM +0100, Marek Vasut wrote:
> The following changes since commit fea3efb757f7a9c6831c023cb456f9fa5fd027=
8e:

>=20
>   Kconfig: boot: Imply BOOTSTD_DEFAULT when BOOTSTD_FULL=3Dy (2024-01-19 =
18:30:08 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master-cleanup
>=20
> for you to fetch changes up to 8a725c610675846b380d865ad68c2295cf15782e:
>=20
>   ARM: renesas: whitehawk: Drop extra leading space (2024-01-27 20:17:04 =
+0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--N+6bD5sUB76ZaTqB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmW2Y4gACgkQFHw5/5Y0
tyzmGAv/ZMuhGmpg5AIvgE1JeT8Od60cMTp+zQLHdE+ySkNgiTaKBzGBmpMNgkZl
CvUl7lBiy6g2MtByCaG8el5sOH7v6OepRxWlSdYSNLswsEOrdetC957cXVo465pz
alQeLJcy/tHPQqjqhPSkCM//YQVXXgjlXZ41yv7QRt5JblZtQwNrOnvNCMP+iEEv
fuPi8e/zx5KbS99Kg2damwNONsRde7GRnPnltqLXK/FDIrlmvjfMKDIKXp5PG8d5
YsOcNUBv1pVHRsdAe2G8O5dx5QklfPzoUQCLCEU7fzJAt5JtD+NrJZZV9YT9IZAh
fOAUNWmGFF4dM+khX4HbPiHF7h3hPm2/cGJ2ebrGlL7s4Brcx1dMNMgD7Wpdgo7P
Pxb+J8ZaDu1gkzzhRKptFQ1rUoB/1IUKmGMO5csWWvG5HZxMILPqZ6eP44ZiBzXz
pxH7T/T6Ns8ZQXS7IGw7Fsl254rF3e8NPFnn1tKfDx3PhFxoRNHbMcajLgPP7iUN
kAdCLX1E
=Pp0a
-----END PGP SIGNATURE-----

--N+6bD5sUB76ZaTqB--
