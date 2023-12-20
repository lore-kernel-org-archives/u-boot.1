Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C62C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 19:12:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96D7787834;
	Wed, 20 Dec 2023 20:12:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NYo+gTCw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED7948718F; Wed, 20 Dec 2023 20:12:16 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE7DF8781D
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 20:12:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6d9e993d94dso4356433a34.0
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 11:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703099533; x=1703704333; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=u8VRY9Jtv0wWT5MWICrEqciFpoi2SbCUPvC5GsWRZyg=;
 b=NYo+gTCwcL1KyqS4GnMjCkuhsFh/UWJjZyAuRa1OA58sGwzQdjkWiUXenWZvCaH31F
 Y1zoIUgrC8K8mAxczs2U8zf+dZ9YFJ9BMKDZT682d9PgzsatxJDhYJyprvCI2wI/yeDO
 c/4w3vzvURDRLGmRaD/7A6a5cXWDr/yb7f6tk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703099533; x=1703704333;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u8VRY9Jtv0wWT5MWICrEqciFpoi2SbCUPvC5GsWRZyg=;
 b=DnX+HG0RtU3Fhq2TnA0jt0QeT/cMvL3VtE80WSWO86CofQba9TDlESMGyF0JfJyzaS
 GSX/NeDbNIiqx792mjlWTKkqippqqcDarI4ghzd6JuSicMjEW3zgOT3yhgrcWSuaBG0p
 pHhu9TAkNR7z0B+V0QdbidL8GQN6XEUM9mpScZawq7JlIgXZsn/anX3GtPmAMbp82ElR
 QK6/wcMy2fk8wEDI3dVwtX5n87tU1kZdKOH4o/z0TzI4pwNBBjkxHKoanLeQ2Ip54keK
 DgkH7PQI/b7fE10pS5jOjSe/uHe2oBmEK8In41ZvzNra+HWlOevSldQZmmQB+15DSb1u
 K1fw==
X-Gm-Message-State: AOJu0Yz8NDgDwRnx0rg3pytkW2EEae8Bvo6q5Wa3UcLaBc6dUptHoJ+0
 eAeGa2saj00dssTvb6kFejJ1muD3CQb89SsIUek=
X-Google-Smtp-Source: AGHT+IFD+7KRTM4s2F6MRWtJGxy1LY0WRYMkMqmHpxSiVTF4fxwRRJowHo08rl4iFCbmCoVIvfBPVw==
X-Received: by 2002:a9d:66cd:0:b0:6db:a784:e636 with SMTP id
 t13-20020a9d66cd000000b006dba784e636mr2085655otm.27.1703099533549; 
 Wed, 20 Dec 2023 11:12:13 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ae12-866a-2c78-8ee6.res6.spectrum.com.
 [2603:6081:7b00:6400:ae12:866a:2c78:8ee6])
 by smtp.gmail.com with ESMTPSA id
 s187-20020a8177c4000000b005e8da478ccasm148951ywc.97.2023.12.20.11.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 11:12:13 -0800 (PST)
Date: Wed, 20 Dec 2023 14:12:11 -0500
From: Tom Rini <trini@konsulko.com>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: u-boot@lists.denx.de, "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH] sbp1: Add support for IBM SBP1 board
Message-ID: <20231220191211.GO2513409@bill-the-cat>
References: <20231220091236.1059109-1-naresh.solanki@9elements.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="K8m+DZ3L171BUWA/"
Content-Disposition: inline
In-Reply-To: <20231220091236.1059109-1-naresh.solanki@9elements.com>
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


--K8m+DZ3L171BUWA/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 02:42:24PM +0530, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>=20
> Add defconfig & devicetree for IBM SBP1 board BMC based on AST2600 SoC.
>=20
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> ---
>=20
> Changes:
> - Update MAINTAINERS
> ---
>  arch/arm/dts/Makefile                |   4 +-
>  arch/arm/dts/ast2600-sbp1.dts        |  96 ++++++++++++++++++++
>  board/aspeed/evb_ast2600/MAINTAINERS |   1 +
>  configs/ibm-sbp1_defconfig           | 126 +++++++++++++++++++++++++++
>  4 files changed, 226 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/dts/ast2600-sbp1.dts
>  create mode 100644 configs/ibm-sbp1_defconfig

Is this device tree submitted upstream?

--=20
Tom

--K8m+DZ3L171BUWA/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWDPIsACgkQFHw5/5Y0
tyxAqAwAmcyQ9HO/UlYQKdlAuBxMK+WDUNBRfESr6PEwb+9qfkHt1cZB4SEIRrng
4Uod5peF/qfjTAd6eYH4SaJL3adp45EWlIA+2Z6sBdBqAgHksgpsIe88b36UGuZu
97aJKzFuLZvwQ98WbhvKljH0HFUCsZCBaBBV48Twp6Uholifb5VlAQ5DWoGDljCu
63TtN4XOnkuWzzsf9fk159s8J1oygrmvt2L8hpVbgB3zDEvzroLfnUUjZNMo5hAI
CRG2KGx0pp+S372Yx+izXinkyEfvMwF7EUg0+7ewbiSZdrFfSUkFRp7VqNtt5jgs
9zQUeNN4vsK/wEqeyyFnMy0JbmK7eRVT7MRNyYuXOebBlk1Fo+QlxqVYCPebuJKK
2NVxM8CE9OR5S51HxVtZP1j/wtqEKpImonuywYpOJBr2O/mi5DC/9EQcLJeDSgKY
J5N2EWJ82zkB1OOLn3uUGE3wLwDufaZpcbNROvWH8mhkVo7imzBU3xk5TmAWpJll
iYx0zv/p
=w47u
-----END PGP SIGNATURE-----

--K8m+DZ3L171BUWA/--
