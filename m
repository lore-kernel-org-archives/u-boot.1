Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE29F9D0D5
	for <u-boot@archiver.kernel.org>; Tue, 14 Apr 2026 14:53:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68DA484214;
	Tue, 14 Apr 2026 16:53:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dSw/lPWx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 319DB8421D; Tue, 14 Apr 2026 16:53:58 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09214841F2
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 16:53:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-4710c186d8aso1680279b6e.3
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 07:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776178435; x=1776783235; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5HOkJr16gc1vzdWMQa30RMocdono0gbVjFA2rWxm1Qc=;
 b=dSw/lPWxvrL6Hhv8TsvhVso+WcfEqm+YjQHlYysjAMQYj68P9q8wAIq26ZAV+D3XvS
 XWqx1uFxD1qC3SjGYynho2E/4XQtbGthFxtJFhTrJJB0CTwjHExrw/BJaVOuz8I9Yts7
 LEQynGmETC5B1Ui6SLFTicq2yCNz9974rEbvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776178435; x=1776783235;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5HOkJr16gc1vzdWMQa30RMocdono0gbVjFA2rWxm1Qc=;
 b=bIw5VcIAlOONv4CZsWUFQx9/+RkqIeSVYUOF4/Vgrs7+L7O1jlJ9Don4p4wZWSUaVM
 K3OJlBIEB+e8eOdl6beauYS9lInrYPlq5G9QTzLF/xReMwmWuLdnJonO1eYFL0b1Vao/
 G1z7yiBz08N/9dDApHVwNYs+CvdSgX5NWZMb7REc6o0oESGFEDIhAQxAZ0p9eb+Kj/e1
 9Wejo478DHZk1YQrOVIeFdzzYxU8XNXRSz59dNa19WSgmiZnJJmhkwGnw5KNrD1DyYw2
 AcnN34tHggIMqrZf8bUFZNinn+Qs1P+NSqeoSaX9IX4ctI28NFwXqOlq4GbGpUkKfUyx
 a6zg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ubP4duUptMEms9si9n9+L2Noea0JwK5Gded5O9EYNV3fGV75vy6Zf2W05Yg5Xp/aOV58jfk0=@lists.denx.de
X-Gm-Message-State: AOJu0YzCBIDPkTrxbPz7MDRwCVDhr63jXZGI+LY78O0aWfir7F2FQZA5
 LlUTpP/Y0Wp7ul7NKBef2r2Mu/h5a3bTMXZ7QQoN0HOXaVYY3MlLEk06GjFpETKWx7c=
X-Gm-Gg: AeBDievJ2+VZpPoWEkpFn2tF07HWofJsX7yYpS5fC6T4SQ4HI3Ct/eo6wUJE4M8/r7Y
 86UcETTsREwwxSY0FnEw7VuH6fl70uiWUFDYBIXO2b+U2WyjqE1lSy9KCICy/WesoWcDpFE3G1R
 HOz36GHndRR5qncJk9yYX39Srd6YdKVOeLDIcP2Yl0K7VuOXPHYg+3d4CEgsGMVj+wIE9tsjM+y
 fkpkwH7488KU11fueYtDL10WC+S/Bxbrwhvat/L/3hawmMK3Oa4XKCU9USAnXgoYl6G06CS/HE5
 RbyJneCjbW2FipBO/9ErKhTONzzBg/s5HDy2RtqwifJXY+DgTPQUYiwynuOU40h7gcKOkUnjlcW
 /N8TfkJnLwi0u7dsH0RjDuincaAnjUTFLVy0lpV+lzmhVd5TFATC6nI1LV8mUf+cdCltbmyJH3k
 3Qui7X6s9PRTALKnqoC5eO3rynWVZ7H74giBN44dC7axMIWzxpWmxptrJv/8E67AoCpypO55+aa
 d9FPu5enIsaVBhvP+C6HSJwp+RlqJ+2wTs35kgF8AIxaYC7LwHJOntakyWdVw==
X-Received: by 2002:a54:4e83:0:b0:467:143c:7733 with SMTP id
 5614622812f47-4789f50b735mr6885897b6e.46.1776178434581; 
 Tue, 14 Apr 2026 07:53:54 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-478a2f565d1sm8250838b6e.10.2026.04.14.07.53.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 07:53:53 -0700 (PDT)
Date: Tue, 14 Apr 2026 08:53:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul@pbarker.dev>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] misc: Add RZG2L OTP support
Message-ID: <20260414145351.GJ41863@bill-the-cat>
References: <20260414091422.16952-1-othacehe@gnu.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3jDiOwEkizPbfOqj"
Content-Disposition: inline
In-Reply-To: <20260414091422.16952-1-othacehe@gnu.org>
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


--3jDiOwEkizPbfOqj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 11:14:21AM +0200, Mathieu Othacehe wrote:

> Add OTP support through the fuse command. Fusing is directly performed by
> U-Boot, which means that the trusted-firmware must allow the non-secure
> world to perform fusing operations.
>=20
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
> ---
>  drivers/misc/Kconfig     |   7 ++
>  drivers/misc/Makefile    |   1 +
>  drivers/misc/rzg2l_otp.c | 222 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 230 insertions(+)
>  create mode 100644 drivers/misc/rzg2l_otp.c
>=20
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index ea785793d18..16cb800a393 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -132,6 +132,13 @@ config SPL_ROCKCHIP_IODOMAIN
>  	  for the IO-domain setting of the SoC to match the voltage supplied
>  	  by the regulators.
> =20
> +config RZG2L_OTP
> +	bool "Renesas RZ/G2L OTP support"
> +	depends on MISC
> +	help
> +	  Enable support for the OTP controller on
> +	  Renesas RZ/G2L SoCs.
> +

If there's other feedback, this should have some dependency on CMD_FUSE
as well (since that's what makes use of the functionality) but indeed
it's very inconsistent currently, and the area in general could use some
modernization.

--=20
Tom

--3jDiOwEkizPbfOqj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCad5U/AAKCRAr4qD1Cr/k
CmqcAQCbsk5GPSFbd1Tgqm/IKfX9KDTiSpFoPRsWm824YqO1KAEAvdEvys/3ut4M
Qaa6W1QTXqfgmUJpuLLv2b8/uIY7pgA=
=/qn2
-----END PGP SIGNATURE-----

--3jDiOwEkizPbfOqj--
