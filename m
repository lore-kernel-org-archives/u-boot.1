Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9498FC282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 16:53:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 163CA81EDD;
	Fri, 14 Mar 2025 17:53:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sLkJVpOO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC44981EDD; Fri, 14 Mar 2025 17:53:21 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77C6E81E6C
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 17:53:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6e8f06e13a4so30260406d6.0
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 09:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741971198; x=1742575998; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vgCFE5Zrm6R4MCLwk9M3MrBZwscDs5ZsZAH7lTWFR9Y=;
 b=sLkJVpOOxEk0OL165O2D3OE3Y92hwHRI1hiAkRTcORl02tHsBdvkqyvxXAPBHA7Caj
 L1V5I4++qm7xLz3OPmsMc/rj2IrK5klcSQMv4g75xqHWycOPblqEPw+lqNPxe4v6ZLUw
 SoWPj3wKiP4iL080JYL87BGdrIIFtRLmjwNmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741971198; x=1742575998;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vgCFE5Zrm6R4MCLwk9M3MrBZwscDs5ZsZAH7lTWFR9Y=;
 b=XPFUCmseAvijgvBOXFptBai4uoSm7nIOYF+7XpKLqpH8Q5IUxBmnZasUMOwitBFVxz
 vxKhdemrkC6TVXVSYs8lMTrymK0m9k4N/L8bcr6pnlvT5jIRRilel7sTZKKb3KiTPoIj
 1iSOssgFMpm0J/GbvByZAx7EudqaqQF7Et5JY1gfB0fRK6hcX4vSL54UoWRwMKCPoKHp
 v9vn5Bap/WqI1O3k/e12O15Qv2C8K5O9M1GxuWLxHw5uIiCCEee9J9Ju8RWts80LJ09o
 vVlqOyv3CHr5UIdFDlPRpEZQ8BqT0Or4VaY3wbR9TyPljTXaQyLvpKqqWgJNBmBbcuKx
 ZvrA==
X-Gm-Message-State: AOJu0YwYH0KwuAuOO+mURI6dIA7f7IWmNCcHxL0xHYM6NBKLgScUGocw
 /j51bDE2TtH8zcL9/g/B53Y/rMRy7bMorw90RG5i735fi+n9xAXEEMrTDARrlSE=
X-Gm-Gg: ASbGncsbJCFTl6o/BbSJRFP8uckcbjOeXaKQks3wZ6NOJETPwqgfk7buojOg/fjIcZR
 6Vk1RFC32sX03BHApteK1V0oPC3LXNqBdkffPmAgHfackoyHJjpK9wemo0qaPtZWXvHu+VI+GMX
 8c+T954tDJ711cmltSv+HQ5kdCH7pXyScPqcPnjn48Rq5cXKRdhq4pzAPP3dMlcWgOTm27TPr04
 0DTHffiki8WpbE8wEdYSkLJB4Nxr3ihdKXiOiJBB0p0SCSDJI5uIjIzGpepiS+nLwZhYqrkD7iv
 mfVtpnUt/OXJ7V9EI5SjfXmDHc4k7bodA4kY/W3Q0bZJVg==
X-Google-Smtp-Source: AGHT+IGD6pYajRXk4+A+J+8GJ0vleHCiZt01MJZU/Rn3rtQ7K/wEVk7JC9ze51xJOzB3y2FmxTpPZQ==
X-Received: by 2002:a05:6214:5016:b0:6e4:4012:b6f1 with SMTP id
 6a1803df08f44-6eaeabdde9cmr47619526d6.3.1741971198348; 
 Fri, 14 Mar 2025 09:53:18 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade209bcdsm26394586d6.24.2025.03.14.09.53.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 09:53:17 -0700 (PDT)
Date: Fri, 14 Mar 2025 10:53:13 -0600
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
Subject: Re: [resend v2 05/13] drivers: i3c: Enabled Kconfig and Makefile for
 DWI3C
Message-ID: <20250314165313.GY2640854@bill-the-cat>
References: <20250314040902.43621-1-dinesh.maniyam@altera.com>
 <20250314040902.43621-6-dinesh.maniyam@altera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/KDpCkW9Gbq+tRh3"
Content-Disposition: inline
In-Reply-To: <20250314040902.43621-6-dinesh.maniyam@altera.com>
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


--/KDpCkW9Gbq+tRh3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 12:08:54PM +0800, dinesh.maniyam@altera.com wrote:

> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>=20
> Enable the Kconfig and Makefile for the MIPI DWI3C driver.
>=20
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>  drivers/i3c/Kconfig         |  3 +++
>  drivers/i3c/Makefile        |  1 +
>  drivers/i3c/master/Kconfig  | 11 +++++++++++
>  drivers/i3c/master/Makefile |  3 +++
>  4 files changed, 18 insertions(+)
>  create mode 100755 drivers/i3c/master/Kconfig
>  create mode 100755 drivers/i3c/master/Makefile
>=20
> diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
> index fa68612787b..8140b530bb5 100755
> --- a/drivers/i3c/Kconfig
> +++ b/drivers/i3c/Kconfig
> @@ -14,3 +14,6 @@ menuconfig I3C
>  	  If you want I3C support, you should say Y here and also to the
>  	  specific driver for your bus adapter(s) below.
> =20
> +if I3C
> +source "drivers/i3c/master/Kconfig"
> +endif # I3C

We should have empty lines around if / endif here.

--=20
Tom

--/KDpCkW9Gbq+tRh3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfUXvkACgkQFHw5/5Y0
tyxeJgv/U2T3hVXDXOMtipqsoe7G5H9RTZgqMGwdChzysczgQ4idW2vKsNK30tdv
ZflBUtnf3VDm6YN9hSYVVbH/SYEG6ZDOrKdxJtbzUqe5fawk5q76LTEmzjBcxfoi
rxn3uPDBBoKcPSUidhmw7HsCzPabor2EH2TjMF0zAHFzQFLw9wuumlYYq5KXUP0X
Xv5GpRXcBqsYG8bLcJ89m5T24OOMPVdnltdxZ0Qd0Tl34Um19hh5PLRB2dS6Fmdj
TZSErf0OmaaHOgNjE99FWwPVMAcAHJB9JR4Iq7j7U0H9IZRstjiI4HrYA8q7U9bD
RcfHpksL2iUJeDPIAgTd1mb0+dUbCOXwzF4CWiks8MYRlWhHp/CHqikfEhYDEtv5
SrFJgseWbKmjuw7LOOULbCxSp25THNwNHkXcjuTu7Nm0jnKUQdhsj7RZI8WkGGdm
zfVe1PLDpNwtL57OoxI3vkulA8vYwoW+31TaOB8PGbbaEG2e9jz14JvN449Or60j
WNYKDuV3
=gOlU
-----END PGP SIGNATURE-----

--/KDpCkW9Gbq+tRh3--
