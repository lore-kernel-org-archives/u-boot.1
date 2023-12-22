Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58805C41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 12:32:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6F9E87860;
	Fri, 22 Dec 2023 13:32:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uRi94CeC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74C248786B; Fri, 22 Dec 2023 13:32:07 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BC3887860
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 13:32:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6dbcebaf9a9so10171a34.3
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 04:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703248324; x=1703853124; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IIWwV9UjnAHUW/U74hk7S81Kn2WR1Gg+4f5Q/D+urDs=;
 b=uRi94CeCXyCZK8A2JfpomntZbSEc2kOMtoDl1dL3PM0FBOHSqRqv6etbcAVD46oQBW
 ogN3VyQX1OryAlZ9vjFJ0FEcXIMBkGcldbjXxjqwMxTLGX4R8L/sWslqcOv+crXhD1k6
 3ysuSxeJCS7VvQns9C5uVSqlTwXp5wwUySDR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703248324; x=1703853124;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IIWwV9UjnAHUW/U74hk7S81Kn2WR1Gg+4f5Q/D+urDs=;
 b=kpHV+qazYZgxuu0aLg5x+ukh2gMMGkdA2j7k4A0cN9bfXkF4DLP5VTIYB8L1Lh2QTd
 ZNKeNQRkuMCOzy1aTKfmqBbOMJotywMED4TT8p5vtTN6+MVEHHlj0UB2+nefwqeezn8T
 VFXYsmWAu899O4LwM/q01S4g/An+4S16iBskKzP0518ZEIiFT9p06txZ5AZuKhReFkf1
 MruMiAk16gMOXGTaXRugHoyUi6lE/1q8CnYI2UJiapPoo6mljoTTsmcVQQox6NMkIg/J
 j1o4ffaABBV8NxeSPl1xhA7KB2hG6sokanKTLRQEwF/QslYeSK/2V+V6bz8naTvgjWrr
 2gJg==
X-Gm-Message-State: AOJu0YxvPLBWdQq4AhcS28puSUlVolDaf5lxV4jhj6bCYPmkBfMiZcLh
 U4PDKbx9LXL6VmyKoFbFb4xAc6ze2GXZLg==
X-Google-Smtp-Source: AGHT+IF+GyaabKLZ1MzFHrOlcDrFBjpk4uErXg50n/oN4lNN/qQWacmy+KbeqsNnqLYo+GWOyrg4aA==
X-Received: by 2002:a05:6870:9a1d:b0:204:474d:2993 with SMTP id
 fo29-20020a0568709a1d00b00204474d2993mr765411oab.8.1703248324047; 
 Fri, 22 Dec 2023 04:32:04 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a6f1-1968-9d2f-89bf.res6.spectrum.com.
 [2603:6081:7b00:6400:a6f1:1968:9d2f:89bf])
 by smtp.gmail.com with ESMTPSA id
 o4-20020a05620a110400b0077d8526bcdesm1330754qkk.86.2023.12.22.04.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 04:32:03 -0800 (PST)
Date: Fri, 22 Dec 2023 07:32:00 -0500
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de, sjg@chromium.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor@kernel.org, neil.armstrong@linaro.org,
 caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de,
 michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk,
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com,
 marex@denx.de
Subject: Re: [PATCH v2 1/8] CI: Exclude devicetree-rebasing subtree for
 CONFIG checks
Message-ID: <20231222123200.GY2513409@bill-the-cat>
References: <20231222061208.3009970-1-sumit.garg@linaro.org>
 <20231222061208.3009970-2-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CbmdpzM48/ZeShEe"
Content-Disposition: inline
In-Reply-To: <20231222061208.3009970-2-sumit.garg@linaro.org>
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


--CbmdpzM48/ZeShEe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 11:42:01AM +0530, Sumit Garg wrote:

> Since devicetree-rebasing is an external repo with its own coding style,
> exclude it from Azure and gitlab CI CONFIG checks.
>=20
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--CbmdpzM48/ZeShEe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWFgcAACgkQFHw5/5Y0
tyxmzQwAkNSmyr0iwHsYguUE4gmpTf0EklUKJmCSwmYRz/3+sE2joEHF/3gyhojq
Tq4gI0tMU6w1xtCYtk94GWGupyMD9/rWgkCSwr2HoceSRZSQfaAU9BUtx8TtH4Xw
6mBRvYLMZt0IAbveXPO6vL09Ha3RP2aV7x46UWB6WTUWPR70gwT6/xpcCGzAxJna
rN45gD0WkvCw9uleYpUJg26wfLMyGMarZfFWT0lAMgmUiUnq+kC75/MZ6j6Vj6GE
vBRcge6PMMNqzdEd4x54w2JK4AViS+AsIOZVmCCP7r61y4SWs2jTxRq2GRs074m5
BunHk/rv6dlHIsl4vKOlq5CmLfZikdN2unID2C7B/a+xI9TWezD6Rcz19MW6cy5/
4FjiaaTmOAKqTges3b8iiV6TclzvlxvTMKXg3YlS/pkdYrKRr7VcebZpdtijiTRZ
wjcrWbLZ1zlgmW+2und8vs1L3FIEBg5Mfphwjmn9P4JOZOTyG/Fo4OvYjGh6oeV1
1AtVKWRL
=C9eF
-----END PGP SIGNATURE-----

--CbmdpzM48/ZeShEe--
