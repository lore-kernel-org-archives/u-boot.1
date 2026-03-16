Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C455F506D9
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 14:50:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA81884099;
	Mon, 16 Mar 2026 15:50:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BiIqaDi3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61B2B8409A; Mon, 16 Mar 2026 15:50:34 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3398784090
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 15:50:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-4671cbce626so2102555b6e.1
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 07:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773672631; x=1774277431; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=irqskA4wuZ4JVrLJ+uKJdzaOmQKW5MHSInWn4NK+Kqw=;
 b=BiIqaDi3oo/hxjwRnRMWbOueP4NhTAMvIrVd+zUZTAirbgTYl6DuhdPGPsgcKzFoPY
 VOZ6iZ8vbvzyoPSK8YAvNgsuzkgyN8O00Qtd1G5KDqy6Ossr9uob+N0RoG5ALqZ8gAz5
 TivTlvZvrkvMe5ucp+jMBSREhqDfTaqmJqO0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773672631; x=1774277431;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=irqskA4wuZ4JVrLJ+uKJdzaOmQKW5MHSInWn4NK+Kqw=;
 b=eIWjzjknLtn1CfOL3kGi9NYCZQxzMwFKdveG7XFwnimbnzDmjnI2yLxkN6D1Huqest
 WLMVhuLAF4QkXAP2+PIngG1HwMSJGuFaX66n5pm3VIIoNLL444SJXUCexNLJ+8vXayej
 B8LAwpeBLRI+YpzMk/+I1Nw5pEXEOv34uQ2DXpaATgmu/VgH1xeSI++ohaPYUAmILoxd
 WunyoFjSdEZ/ZyAS1UbehEMhe94UUWuoZBQ3yuB1hM9sK/zsdF9ZDGP/OCwJKyYciP1P
 gZB3GzYWaAUZoLvlJzm4I9sZig8GkUwu+ive3VlC1csHsA78FA8RkcEaFD1Dgkv1nAKP
 82cA==
X-Gm-Message-State: AOJu0YyvPGMv8XdecattPfDsRfIWPwTR5ygjkvAyWV6fQYdkoLbrjXHD
 yQ2tpRbG/8krmDiiA/B/AKDZ3DGvYSsoRaSadwgghFnCXKXCP9+/93eLllYcjqJ2gwk=
X-Gm-Gg: ATEYQzzHKE0M8Va9uCIpept4kla6IiIQ3+XPBxs7dgXpWo4p0ocEctck083hrquiz92
 mq8Zu2eVENEoiNwj+rpNJ8e9ImFCzuAwwLTpQXuBSgQfSnrK6azRuRl7Nr5w9pIyw4DcrmODtED
 S98BYC7aG/PXmz+VLBy9RWmsWQDF5b5sEb+yZCuN1m2sjwco3k299J8Z4AcaGKQr93/rbZyA/wA
 dOiFX6ROnjvHGi6XoCKtg5zcwsW4HBaivB546UE+G23MOKIwe3hCuilSO7ytXy7sXDZaRrEuT/W
 HA/SrQYr82zAB7pCOLtK4Z0QAl59lYdZxLmTr44Lsqe/Tc9MszHGeFfztp7ICt90Yzdteg7ie58
 nH2zCr7VOGMKFnhG9kkaccn/2Ip57ZCYx2kJGtmgqJCkYKaIQ3YSUAgOGdUSP9nL/ApbXjX7h1A
 9xn21cLOWItAg7TVJBCyEl+Hvz9tO4cKohj1jwqgtPy9xO+1ucfuv3FqH7jvfgS6bzIIMOMo6LP
 CcNSFD0U6t5O4vlfwFM7KLtwUbjx5OEzOf5E+9AdtFx7tBbN8KLZgJZds0=
X-Received: by 2002:a05:6808:1b24:b0:450:d471:dce5 with SMTP id
 5614622812f47-4675701babbmr7255277b6e.6.1773672630544; 
 Mon, 16 Mar 2026 07:50:30 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ac3230fsm12437541a34.4.2026.03.16.07.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 07:50:29 -0700 (PDT)
Date: Mon, 16 Mar 2026 08:50:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <sjg@chromium.org>, Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH] arm: relocate: Introduce data-only relocation mode
Message-ID: <20260316145027.GK502704@bill-the-cat>
References: <20260315235510.304677-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1H8NtsMkloteDnY/"
Content-Disposition: inline
In-Reply-To: <20260315235510.304677-1-marek.vasut+renesas@mailbox.org>
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


--1H8NtsMkloteDnY/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 12:54:05AM +0100, Marek Vasut wrote:

> Introduce new mode of relocation which relocates only data, not code.
> This is mainly meant to relocate data to read-write portion of the RAM,
> while the code remains in read-only portion of the RAM from which it is
> allowed to execute. This split configuration is present on various secure
> cores.
>=20
> The result of the relocation is U-Boot running at its original address,
> data relocated to the end of DRAM, but with added read-write area offset.
> The U-Boot binary area is not reserved from the end of the DRAM in this
> relocation mode, because U-Boot itself is not relocated.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
[snip]
> diff --git a/Kconfig b/Kconfig
> index ce25ea24a60..575ee3b574f 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -474,6 +474,23 @@ config SKIP_RELOCATE
>  	  Skips relocation of U-Boot allowing for systems that have extremely
>  	  limited RAM to run U-Boot.
> =20
> +config SKIP_RELOCATE_CODE
> +	bool "Skips relocation of U-Boot code to end of RAM"
> +	help
> +	  Skips relocation of U-Boot code to the end of RAM, but still does
> +	  relocate data to the end of RAM. This is mainly meant to relocate
> +	  data to read-write portion of the RAM, while the code remains in
> +	  read-only portion of the RAM from which it is allowed to execute.
> +	  This split configuration is present on various secure cores.

Is this really configurable, or is this determined by the SoC? This
feels like something a board should be select'ing rather than
configuring and I do worry about boards abusing this in the same of some
possibly dubious speed-up rather than the intented and valid use case.

[snip]
> diff --git a/arch/arm/lib/relocate.S b/arch/arm/lib/relocate.S
> index 6ee58f4edfe..b6a648708f4 100644
> --- a/arch/arm/lib/relocate.S
> +++ b/arch/arm/lib/relocate.S
> @@ -79,6 +79,15 @@ ENDPROC(relocate_vectors)
>  ENTRY(relocate_code)
>  relocate_base:
>  	adr	r3, relocate_base
> +
> +#ifdef CONFIG_SKIP_RELOCATE_CODE
> +	mov r4,	#CONFIG_SKIP_RELOCATE_CODE_DATA_OFFSET

Spacing. But if there's no other comments and propmting the user is
correct, I can fix when applying.

--=20
Tom

--1H8NtsMkloteDnY/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCabgYrAAKCRAr4qD1Cr/k
CueGAQCwbYXyipbPcIq9GFXrX/eiAOXi6A9QDroCxMVV1qulmwD/b6aMVMt9zOOw
ieS97I47/1O+u49K40oM91ZVRauy0Aw=
=qfg2
-----END PGP SIGNATURE-----

--1H8NtsMkloteDnY/--
