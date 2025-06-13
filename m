Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D4DC71136
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 18:26:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEA5282D60;
	Fri, 13 Jun 2025 20:26:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AVz1z0fZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2BC182E5A; Fri, 13 Jun 2025 20:26:06 +0200 (CEST)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F12A382D5E
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 20:26:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-87f161d449dso372384241.3
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 11:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749839163; x=1750443963; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2Ik/tfH0e0qVm+E1fmSNyVsPaG3xqPaazebwbYuPsNs=;
 b=AVz1z0fZtpHXI1oHEp/O4mdEy0GeGemEom3n5z+grH+0Rc7Qj6XQuz6p37Q9Rcfyju
 xqvBP9qb/FzYlvGqnbdgcadKGOyyxaGiK2f+aVuDaJ3wcOUv7uA1jF0Ws06crb/F41Kg
 oSYOW5RfYCKUAFLijmilfaONMFzahQISHEk70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749839163; x=1750443963;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Ik/tfH0e0qVm+E1fmSNyVsPaG3xqPaazebwbYuPsNs=;
 b=incSHluu4FEoZ5uKgexF6uirPbe/p5h/7z73cKd7J36imxdrzuW9aW0Xd8A0XAtpQF
 JhEa5/vAbFMu7NWvJcUdJGBVvV7b6uu+qhMCJGgk25fo1e6t2qDsy/5tKoNAwwYCIl17
 bXA3e4opFlgWy2q64jGdWNW94H8IIYTdBKAe40WWDfy1bCskCd2sEH5p7aqPlcYzBHBj
 xlempcCajr8nXYwJujPQEUHpLmajCoD700yq8xg2rM/mksr/gYLQXOOXiewjj0IHf6c5
 ZVGrlHxE3FPfKnvLbh8FPZAg0gUXTQu0FRdK/dz6McCw8s5xAmzEBnLmaZwaQBx4kZ10
 hH4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWM3cj+hj/iCrY/sTQ1aZRH52Up8NU9a155X71H4h768m1M1GuWxsreuyKF9GGbE26nubBimIc=@lists.denx.de
X-Gm-Message-State: AOJu0Yyrmlvdy6jJFLmWz2ZNJfWL+Lr2EuPQ6BducMBXy7DRBboIuhCc
 k3PNQejwewDikr1Iqy0ZQUCDuswOuE8lxE8640CmhyM14TryN5tBNf/Smr+71wSXiw8NTLKsqB+
 KpycZXOA=
X-Gm-Gg: ASbGncuTfiflh/2Y/h78y97qG+2Opel2Hih3A1agacb9kn8XIVcsLqT/630Nq+m799f
 U0WlRiPhG7B7LN2I3nBZz5tUgv19Z28Qg2fPdTSrH9ow7ATFsneeopXbW/Pj/ZoTVGqHITpXbE6
 jB6NOylX88wHMOkdL4IUG0VhsKdpjWJS0pioNcoOFzEbOnLxpzBWvTsIHFqWDc/2pGHDo/gqYxi
 TuH56TH58DhxPH6lWsSX0pXpNeIBFGaHfyXL3dMxgbvdxBGww9W0EncsDzKcSRToJ2GRp/2/ZQF
 2ne0oX0QGhEMaE07pBr/zUldI410l8pxu/z0/NVwxAHO1/2xWtHnu6IwD7958nid6To2lOOfLK8
 dcHwgED+L0SoW/jXZiSHM1jc=
X-Google-Smtp-Source: AGHT+IG8EoZaVzQX2/gb4ULOxk4/veloVjEno0Mc2U1ps1njX9HrxlLC4yzdtycqxA/tiV7SQcDg5Q==
X-Received: by 2002:a05:6871:202:b0:2d0:4a2c:7c22 with SMTP id
 586e51a60fabf-2eaf0847ceemr517387fac.18.1749839152515; 
 Fri, 13 Jun 2025 11:25:52 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a28555b7fsm287363a34.65.2025.06.13.11.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 11:25:51 -0700 (PDT)
Date: Fri, 13 Jun 2025 12:25:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Heiko Schocher <hs@denx.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: Re: [PATCH v3 2/5] misc: introduce Qcom GENI wrapper
Message-ID: <20250613182549.GC1382132@bill-the-cat>
References: <20250613-geni-load-fw-v3-0-be778b3b101b@linaro.org>
 <20250613-geni-load-fw-v3-2-be778b3b101b@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4pJd+8q4jA1LOr1X"
Content-Disposition: inline
In-Reply-To: <20250613-geni-load-fw-v3-2-be778b3b101b@linaro.org>
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


--4pJd+8q4jA1LOr1X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 08:10:15PM +0200, Casey Connolly wrote:

> Qualcomm peripherals like UART, SPI, I2C, etc are all exposed under a
> common GENI Serial Engine wrapper device. Replace the stub driver we use
> for this currently with a full-on misc device and implement support for
> loading peripheral firmware.
>=20
> Each of the peripherals has it's own protocol-specific firmware, this is
> stored on the internal storage of the device with a well-known partition
> type GUID.
>=20
> To support this, GENI will bind peripherals in two stages. First the
> ones that already have firmware loaded (such as the serial port) are
> bound in the typical way. But devices that require firmware loading are
> deferred until EVT_LAST_STAGE_INIT. At this point we can be sure that
> the storage device is available, so we load the firmware and then bind
> and probe the remaining children.
>=20
> Child devices are expected to determine if firmware loading is necessary
> and call qcom_geni_load_firmware().
>=20
> Since Linux currently doesn't support loading firmware (and firmware may
> not be available), we probe all GENI peripherals to ensure that they
> always load firmware if necessary.
>=20
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  arch/arm/Kconfig                 |   1 +
>  drivers/misc/Kconfig             |   9 +

You forgot to change the Kconfig logic from last time, it's still
select'ing and not everyone has MISC enabled.

--=20
Tom

--4pJd+8q4jA1LOr1X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhMbSoACgkQFHw5/5Y0
tyxjMAv/QzFkbyco2uCmWO0QPNNdga/aKozSB0fjlqvYdIGn1oxyqu9Tj04SrACa
eLRvBsFLpKwvK9nxE6+7FCOsjhDNR5I1vFKKuQcJBfdJRzovhg+w7X4zn+VR2b8n
d1lSJVrUFz/gUIxsvD3YScPpGndpnDwvmbjKBWnJnSFEflWpv3ndPzpIhPtZ8PqF
GKr7npCKdHUvbBCorHsiDpMDKW03BpaQCcjU0UJKxNL0985CNrDfky3q46cKKUI1
mqApXaA6htqKXOMjtJMMouF0OLLLwcVip1sePZqxOgRfuRmRWRThupT/KtEsdWIi
lbuntK5EzB1q0uf7HEo035u5q6FVfffuFXc/I2l3WsFfaNh3vprdqhGylk2gR50E
bZlIzOgLio7LWeq+ChkjkAzKAsP9TPXfeeFL9a+DYzl6absvZSaCWIfCSP/4HtOh
Ot+baIG31P9au0guI6KLfxgqbcppwtj9NQnWV7rtTVVOFuuM6ZUox27YXu+KqdBv
W1Stqcm3
=//zO
-----END PGP SIGNATURE-----

--4pJd+8q4jA1LOr1X--
