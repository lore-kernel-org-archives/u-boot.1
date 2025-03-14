Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DA0C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 16:54:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2652981F28;
	Fri, 14 Mar 2025 17:54:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FVwq2bII";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17FC581ECA; Fri, 14 Mar 2025 17:54:03 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBBCC81F54
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 17:54:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6eaf1b6ce9aso4842536d6.2
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 09:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741971240; x=1742576040; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4CSG/UMdCOkaxjF6uBUE+ya6y5w2iSF1dzC+XYWgGkE=;
 b=FVwq2bIIdgkaK423BrBFpJt3qO9ygFW0VHFRJ0C8RpboVZbf+CyEl/Xx8w0wihWGTf
 fNckuDrHxTihNetoHNYuTHBfreDLMKtcQWX/8gXrg1nCRY9zq2+QJrV7EDM4F6aYWR/p
 Sfr+UhqRX7h2/JZfW/SkH5LdRqOZU/r1ZSeZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741971240; x=1742576040;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4CSG/UMdCOkaxjF6uBUE+ya6y5w2iSF1dzC+XYWgGkE=;
 b=xQHLUjSTWA0A9VAf9mA/7SobYowsfw9FRe0YOVeiY7J0HMJvfdRdpihVJNpAZsZ1H5
 BJhPNABwRI6RxkFCb1Jw/eFeZ8jkkWkEqttK+iOoz3XHfoeqeitfki+KgjEH219wfW22
 WlSpXtuPggZ7QepdEz22UCH4hnQhrANXuyqCy68728zqf/X6WOUsqV9aKOo+nfDsgkc+
 1aHQZXpFrhxtILcjVSg85KsWvCX7YQTo3QuIoM9dNeqbkLtsbVP+y6My+aeT73WlaLMm
 NP0GOmvXLRxiErXLjCVR+bnuLlbYLh1ArFy/uQzaEKwbJAbtsGgXXjonkDdmY1l2Udd3
 cVfA==
X-Gm-Message-State: AOJu0YyFUMeLoBnEw/Tje25++jqhM4UDHQbgqNrE8mNURE3JBXZCi9kX
 QoP/UdqNVgCanSzwf7eFnzvyGyVDJC9/8Ruo6Zra9RKFOSPf59K8js9jEU057So=
X-Gm-Gg: ASbGncu1hJZ2WOKRJlMXwGZrHw5jISPj8SEblbsXLCAJnGZx8sGIo+4T1MlPjnR4iMB
 JJT/evFsrgFZdZP5sVyfdt1qhbS/YS5RDJ+y46BloOM95/m1hs8hY1FfDBh1V3UoWoWDscdn6xD
 tEymwegpaXOK+CNFq2sc5m/9fzoacPeQkif6us+O87sgbLb2eMP8e1T3RT31jmTLfqWRwaxhzCF
 6FR6r26GpB0upLhhswxIMLZ407CU9abP1KDPrJ4vhKrsKRkcYudUEKnU3xIK/geKBjrYpDEjlGs
 sr93BuD1wsEnad/MLEQ092ZmSKyF4dXJNkqYxvAVrq48lA==
X-Google-Smtp-Source: AGHT+IFqpNce8X0yAHyQY7T99TVkkgP2Yf6u2IQuHQHLKhYT3GqRdh2nQHNhmzWBAC/9ZfmO35okCw==
X-Received: by 2002:a05:6214:2601:b0:6e4:242b:934 with SMTP id
 6a1803df08f44-6eaeaa5d768mr40644076d6.17.1741971239852; 
 Fri, 14 Mar 2025 09:53:59 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade209351sm26097326d6.12.2025.03.14.09.53.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 09:53:59 -0700 (PDT)
Date: Fri, 14 Mar 2025 10:53:54 -0600
From: Tom Rini <trini@konsulko.com>
To: dinesh.maniyam@altera.com
Cc: u-boot@lists.denx.de, Marek <marex@denx.de>,
 Simon <simon.k.r.goldschmidt@gmail.com>, Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Sieu Mun Tang <sieu.mun.tang@altera.com>
Subject: Re: [resend v2 10/13] cmd: Enabled Kconfig and Makefile for DWI3C
 cmd support
Message-ID: <20250314165354.GB2640854@bill-the-cat>
References: <20250314040902.43621-1-dinesh.maniyam@altera.com>
 <20250314040902.43621-11-dinesh.maniyam@altera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+X6XKsu71+iAmRSm"
Content-Disposition: inline
In-Reply-To: <20250314040902.43621-11-dinesh.maniyam@altera.com>
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


--+X6XKsu71+iAmRSm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 12:08:59PM +0800, dinesh.maniyam@altera.com wrote:

> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>=20
> Enable the Kconfig and Makefile for the
> DWI3C driver cmd support.
>=20
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>  cmd/Kconfig  | 6 ++++++
>  cmd/Makefile | 1 +
>  2 files changed, 7 insertions(+)

This should be part of the commit that introduces the code. Please check
the series for other places where patches should be refactored to not
increase the patch count unnecessarily.

--=20
Tom

--+X6XKsu71+iAmRSm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfUXyIACgkQFHw5/5Y0
tyztiAv/a/ALY0R3Gg31Ky/UUvmcidV6HdS9PjSYSNbmj3w13RL5I0+2d/kaFAvY
GqYXh/lQhBwMOBRJMJ71HAKJ9FikJjb4lbDnD9IJYNkcKrtD4XWhpBX0flcMlfPQ
E4EWVFgYvns5hqGzoimtdZ1Dk3UGN5VeHvtNtGWVWqkVuYBSL0SQZ8FqnXjXEhxr
TOuA/4o8qPYkyY/LpmYkOOfWUaXw1J0tDdY0/IuZ7eygNdNM6796JjwDXRec/yUQ
NfH/x0dLtCylL7u5HgxPO4MWnnBnuV+MZZvCMp3kqBSGhaoxAjXPGu/zrPJKLc1g
G5saTyu7qAtgDyQ00WSjr99XZqGxpi7+Ula57+sOCzsuG/vvS/uu0hvJUUm7UrM9
WCIo3E6XdG5zRPvkcGahk5V7dxiYKUklkd+ROSjp2M7dWkzjNO7f/I5ECLraHH+U
arkGa5Lkrk2RiH+b4R9tTWh+o5+pPvgD9GhQ9+z51BccH+JhfrznNO2VBaA3mj71
H3nw3fC/
=LPaj
-----END PGP SIGNATURE-----

--+X6XKsu71+iAmRSm--
