Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7364CC46CA1
	for <u-boot@archiver.kernel.org>; Mon, 18 Sep 2023 14:22:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E076F869F1;
	Mon, 18 Sep 2023 16:22:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hacutVbN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 431B3869F2; Mon, 18 Sep 2023 16:22:23 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B349869E6
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 16:22:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-59be6605e1dso49002617b3.3
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 07:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695046940; x=1695651740; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Too3zN3m/INZ9ggHfkJ1r6R0i5F0DsYTbT8XCfpj0No=;
 b=hacutVbNWdqAy7AZCFeD9zuqUt3/tMmRqFI6LnbNiZp/k+DCJ0Spll4lEVwdxeoMgO
 LkscIl3n1ykxlQK6yuTft2dTevp1WLHvcOTfnBv7egLfIg5Jcfbezp/hJn8tOdP5j1Sq
 gatdS5E0nP9C91MMahwDuCd3APBemmgNrCyXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695046940; x=1695651740;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Too3zN3m/INZ9ggHfkJ1r6R0i5F0DsYTbT8XCfpj0No=;
 b=LYN9/45ZNm/67fgotpP2uXmFY66cZ/8550oIceW3b41/A1htLEN1opszo3FUeBQhFk
 gTytC1pA65URtnQ5DMM0f4Sp3c1IjkfLmE8JTdZWd8duSdcG61K38guOB3Sj6c4kAbWC
 v8KcnhBQc0lRmJaQqLxCRzeOde7eTJ5MRC+UFZOD+2Yb0gG70uYFx9Id9TkO4Pr3EjMm
 onReyX7O9xHpVBSHKc42m0iXANUWOjbRPPHrG6vW6piQUN0rxD3lau9vwbbkFQmHdtwn
 Q+NRAA3qyGSxjDjNe2GRAMSYzIVOLszdnI1xBmRwMf8kgJbhc9uv2mHPpHMB5fYW8sEz
 rzew==
X-Gm-Message-State: AOJu0YyQXEIYRmRizHjjhFqmhdOvTyQ0URK3dgq9a0aaMrPBiRvT7dgI
 3oFRoBvtr4EWOqAkiaDRADgBdirf/GiAtRIiWH67sw==
X-Google-Smtp-Source: AGHT+IEtgCXJpWY/SFkx3CCgxsTS/LQgINXxsa36H9YmX9cYAraJ8SIGIh+IsQOvEaKgkb4aqhLNcQ==
X-Received: by 2002:a0d:ebc6:0:b0:58f:a190:f6b with SMTP id
 u189-20020a0debc6000000b0058fa1900f6bmr9266280ywe.26.1695046940009; 
 Mon, 18 Sep 2023 07:22:20 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-fccb-cc62-ada8-13e0.res6.spectrum.com.
 [2603:6081:7b00:6400:fccb:cc62:ada8:13e0])
 by smtp.gmail.com with ESMTPSA id
 m202-20020a0dcad3000000b00570253fc3e5sm2558886ywd.105.2023.09.18.07.22.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Sep 2023 07:22:19 -0700 (PDT)
Date: Mon, 18 Sep 2023 10:22:17 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] linux/compat.h: Define empty __initconst and __initdata
Message-ID: <20230918142217.GO305624@bill-the-cat>
References: <20230917140939.379762-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8C2OdR7u6yCPLzNc"
Content-Disposition: inline
In-Reply-To: <20230917140939.379762-1-marek.vasut+renesas@mailbox.org>
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


--8C2OdR7u6yCPLzNc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 17, 2023 at 04:09:39PM +0200, Marek Vasut wrote:

> Introduce two new empty macros used in various static tables in Linux.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--8C2OdR7u6yCPLzNc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUIXRkACgkQFHw5/5Y0
tywF/wv+MV9Ur1ARUGqj9Fk8ZaQd6HpNs7x2/D5R/+j+deOmPYzvBhNH/0aLqnLZ
3ujjh2iCRdthdOFOQJBfbn3dHC2WiePcBlaQJhSH574rEtVxtYAcjRg6V4DqbKA9
bc3AHBlpiiKgSSs7bJ7nUCVLsaj61RTvmkw3Wh4E80xRTgE1xtSw6dEoik8Egsrv
EvSmDlBqMIy7fqFb8LZRrv96LhQ+fgMuQ18JYqaEUye2DJ18euHl0OirxarVvYdX
j0YiT+IdDZwidS0uJEZjFXRiIhWYARDwCOylQx9kjrntxbCIb1mqtTDoWafxb4t9
e6LeQZfOG1wfMqkxSDBPOfwYQtyEEUCehlbZZldOh4hn6FTXBQMYP36eBf70xXeg
xErcZYqCPHk41oArWAjstl1MiNtd7sDwoq9eF+2Pt6hhERIf5xIsU9OmC/8My1yX
oED7MyZ7mDpUO7Ck/Xiy6HnB1lfCajyzA/Y2QZZMHllMdG+4luFhfDAhgf/zDx0I
bhj9NVge
=IfUG
-----END PGP SIGNATURE-----

--8C2OdR7u6yCPLzNc--
