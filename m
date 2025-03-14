Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BE3C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 16:53:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B488381E81;
	Fri, 14 Mar 2025 17:53:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CCsCM0tu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0D0781ECA; Fri, 14 Mar 2025 17:53:11 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7678A81E6C
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 17:53:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6e17d3e92d9so17931766d6.1
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 09:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741971188; x=1742575988; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EIBJik3Hb9yVHwVx9OMoRlTduNWi+41nAp1Eyx27coM=;
 b=CCsCM0tuFDWKy7L0J2Nmwf0f5qRFW5gmhOPlJkSgatnu5ZjXUnXlB4T98uhkIGM1Ar
 9ANZoPHJflSl7rfWY2kN4x41JQrfCWqRsefZNAkbdGOlEImj/DZF1REM5k9U30cyrOkp
 Fq1Vs0zYIZNAlSGd1wglToYN42ery+PRgNchI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741971188; x=1742575988;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EIBJik3Hb9yVHwVx9OMoRlTduNWi+41nAp1Eyx27coM=;
 b=pzw4LaEbQPJKt6+r1xSQrKY69aZ5VuaBAzggS1wI/oS99ntK0+N/cfa6fyKtlmz4/Z
 VHEWdYDCnqUhsvzeHb/G4TgMjlxuuGFesKIWWXVFqK4kPcv/zF4qhwWITnSlHuVrKiFE
 0S2jOe1nz5EZ3NRovIZocBixtB0zlQl9laHjuoLuweaZEyByUMcGDw2CkDU95A65FWOh
 gIZKyWAKBtMnWRi0lhEWwNpiAMRL+suOSob6pInBS8Lr0ACV/VdS2bI7kYEYM3iztH5i
 Lafyk9Dqb/ZrO/tLX62Mc5GOGTFV+3kqZ/LBS1XAkHl1AnWZky+eei42QBKA+LknKN7c
 uMtg==
X-Gm-Message-State: AOJu0YxvQel2NZtNkBVWlvq69HD5Vhej8aboBY4fsOQzc06VxZbHO5cz
 sHdIbhOqXk77c7YgRIqinZNIw8jythJcrRmfo16xVogbF8pswwPH1S2lTXpk3Bk=
X-Gm-Gg: ASbGncvCbxAnPBd2lyOlRhjQxOGcDmV6L06S9WU7wWFHBnDC/A8YX5Fip8z0NtBwTE4
 08cDli/9AC+ij+8MCxsTLeNqHv/s9eeryKWE6oK0eeGCJa8CM9ALYp6imIoNQcVXLogBGjhi7NT
 UaxsuJ0nvXYs12oVjlQrG041ex7p0GxbB0VTxEIIZnwEioUL4nCnhtLFrD/baX0MwiXMbhzBJnu
 q37jVR9fto8pRre6b+szFBAW7c6O8uJB3TKkDVFsICmL/aAFPXIUB/dYiH4xWtz3UuTxkXqhx7+
 +wW/6dmRug0RN8IOhMiPepUe6Tyh1mWtH9Z9MyRotPuWVzptOw05KMn9
X-Google-Smtp-Source: AGHT+IEz4P3RbSPdVazIn/yy2rV7RlB4IRGxsc7oq2LxR4o+LBdiorwvysUq/SPzeQLqDJWJyi5S5g==
X-Received: by 2002:a05:6214:27e4:b0:6e4:6ee1:a282 with SMTP id
 6a1803df08f44-6eaeaa63b85mr43863996d6.18.1741971188100; 
 Fri, 14 Mar 2025 09:53:08 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade237957sm26071156d6.42.2025.03.14.09.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 09:53:07 -0700 (PDT)
Date: Fri, 14 Mar 2025 10:53:03 -0600
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
Subject: Re: [resend v2 04/13] drivers: Enabled Kconfig and Makefile for i3c
 support
Message-ID: <20250314165303.GX2640854@bill-the-cat>
References: <20250314040902.43621-1-dinesh.maniyam@altera.com>
 <20250314040902.43621-5-dinesh.maniyam@altera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5XLRei0yCyYR1I3r"
Content-Disposition: inline
In-Reply-To: <20250314040902.43621-5-dinesh.maniyam@altera.com>
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


--5XLRei0yCyYR1I3r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 12:08:53PM +0800, dinesh.maniyam@altera.com wrote:

> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>=20
> Add new i3c driver to U-Boot drivers.
>=20
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>  drivers/Kconfig      |  2 ++
>  drivers/Makefile     |  1 +
>  drivers/i3c/Kconfig  | 16 ++++++++++++++++
>  drivers/i3c/Makefile |  3 +++
>  4 files changed, 22 insertions(+)
>  create mode 100755 drivers/i3c/Kconfig
>  create mode 100755 drivers/i3c/Makefile

In this patch you should update the top-level MAINTAINERS file and list
I3C and list yourself there.

--=20
Tom

--5XLRei0yCyYR1I3r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfUXugACgkQFHw5/5Y0
tywlPwv9GtXsH9wz0GtpsI1xEJXaOcrO+sMB5gBXmUvTYSW6LshlYoj9tsRbjgPo
7s8OBtOqhso9bdopdpxbPoFMCtjRx6tgSbzXaLfIlJGzXHteGX+fXpjIMDrMIIig
OQ4L/H8a184I1j/rJOZn5gkossdAm0e29rksEhU6YcBvpXL8aOrat2ZtKBsD4val
ItEvP8Jh6DEvVBrIoez+HYjh7R94ttbznnzmk7XwZyLPrKe0e19vM96m0oYNbfCn
Ae7rtgWU1DNTvOXXNgZB85wzQkFpLbSmYw8iDmMmESRSoMneDmYsQa9uGnII8Whe
S7+CandSB4Grjv8Yusl4IUlg/oj0acZMxn4gKidXykmpdSho4Ivdzyt8QoaqSDDH
MSeh7cNdQrMUX5qcjxdg5M2AEeGxZMwhZVgMEFIhtKLnOrkRRpCZA//DKOIPaXWs
xIT/ivCJqVm7N29LfHJhgfU2R1o4qg8CYGy0VE92QpQN/jixwgDjrQS8jYKqNyTS
u9KUWEF7
=Y7bE
-----END PGP SIGNATURE-----

--5XLRei0yCyYR1I3r--
