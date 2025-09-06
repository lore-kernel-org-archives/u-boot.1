Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F439CA1002
	for <u-boot@archiver.kernel.org>; Sat,  6 Sep 2025 18:06:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31C03836A4;
	Sat,  6 Sep 2025 20:06:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iS1zcFB0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8250F83885; Sat,  6 Sep 2025 20:06:18 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADC44835EA
 for <u-boot@lists.denx.de>; Sat,  6 Sep 2025 20:06:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-322f0a39794so76291fac.2
 for <u-boot@lists.denx.de>; Sat, 06 Sep 2025 11:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757181974; x=1757786774; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1ZATcPpPri9JSlujDIQqmaIZhGS/w+DfMQk9KaFvqY4=;
 b=iS1zcFB08345mx9AKgpLcNUVfvFXZmduAwU7qSbOuaPeiqrotRftC6mTeJFbonBDnP
 klDc+3OR1K2Izfae+LpcHEsKfi12hUU00CZEfQ42PSrovaBqeI3M20x7QUAX37nfba7d
 yA5GFJi3n9/9/tggw1vTvAKmd9WedrNMdQhHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757181974; x=1757786774;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ZATcPpPri9JSlujDIQqmaIZhGS/w+DfMQk9KaFvqY4=;
 b=A8XltaEcuAhxNPaZQsUhE7KNBvOlm4fS5wHvnhzvSvfYqoMwuGUpb2RVTteP7rYgdE
 7UQzPZQrOqyZ970uoTVQZjpSL4F6T/e5URqevqJdzHtPuQOWzp+rSxHkSiXAJBAZ0s3/
 QAfuEX2VYpl/jmjfUDtBb2PHEM6HjOwHOCMZQE4o2+Iug2Uuibsz8t8GLbE4RWejLavp
 14AtL8ZqenWAXF+qfsW50VpnxkiezViLENG27RBB4MXdu0HIslni7nCUzEcAy7Wf2eb8
 AB22RcijQvAR/zXS5u5H8qlGSLofX5Bj3jwMhv9+x0NrR5hbiUO8HXCs/Eqy/sAhc1wl
 TLKg==
X-Gm-Message-State: AOJu0YyNUgRIoK3XpfOYrtzvGrYBvhZWAiT1wISspUdOKDc53EpfH+2k
 jW1yiA/g6hRScS338TOSV8rcSxDQXqneBhy703g0qEcuGTcLLRHzIrAsTWjDzmt1yfs=
X-Gm-Gg: ASbGncsS56+RkY9DwO/i1v+hRHSPEDzfaKGW6j982n+alE7axR2T2CnovIETh2I4eDR
 Fjl6JuswjbEY0h33uzGVq3hUWCdiIKm/yJplttD0LR44UcYdqGF4A15cV8AGEQTLECHw0tpQB9Q
 jbM3GrLnXl/cz0q/FWlDEIOO5VqI+7HkyqaJnqcD0bCqNie+wMKtP4AwnjvomRGq9CGt/H7GAdB
 /YuRdz0E2t3wPVfCg1WUwtLU8TZj2Q4xecvgOy3Osf7DkSGLLsQ8sW0Rb1fnTOk5qRm4nwcUwG8
 /JCiaMwBvbpHf2cwwa/2ZxR0/E7ywEuQq8dVcxHwHLPnz4qwk+++2huMzZuvoWDt5bsLQ7CVAHN
 qT92OJBx7tFjLdOGaUoNGWCzae8oUG3LewwOKgw+6lKLbbmsfwWQfcQYc
X-Google-Smtp-Source: AGHT+IHt1SQssW/u0A9EV+AfqKaNAd+2wYrSSqKxIbYT1srwCOFWDpSPh2ru+caYzvAPqvR9DVJ8Wg==
X-Received: by 2002:a05:6870:e391:b0:2e8:f5d6:2247 with SMTP id
 586e51a60fabf-322645fbc97mr1119855fac.32.1757181974352; 
 Sat, 06 Sep 2025 11:06:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3212c4aa7fcsm1735279fac.19.2025.09.06.11.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Sep 2025 11:06:13 -0700 (PDT)
Date: Sat, 6 Sep 2025 12:06:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Adam Ford <aford173@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 David Zang <davidzangcs@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Mathieu Othacehe <othacehe@gnu.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@nabladev.com>, Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH] thermal: Convert .get_temp() return value to millicelsius
Message-ID: <20250906180610.GP124814@bill-the-cat>
References: <20250906000609.284902-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="v5tn8bip5qGij2M6"
Content-Disposition: inline
In-Reply-To: <20250906000609.284902-1-marek.vasut+renesas@mailbox.org>
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


--v5tn8bip5qGij2M6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 06, 2025 at 02:05:33AM +0200, Marek Vasut wrote:

> Linux kernel .get_temp() callback reports values in millicelsius,
> U-Boot currently reports them in celsius. Align the two and report
> in millicelsius. Update drivers accordingly. Update callsites that
> use thermal_get_temp() as well.
>=20
> The 'temperature' command now reports temperature in millicelsius
> as well, with additional accuracy. This changes command line ABI
> slightly.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

While I don't like changing APIs/ABIs like this, I think it's worthwhile
to keep in sync with the kernel overall here, and visible output is
either the same (and calculated) or visibly changed too.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--v5tn8bip5qGij2M6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaLx4DwAKCRAr4qD1Cr/k
Ci99AQDoY9Si3+iQ1uHB1VOmIUm3bgkHGOeuOlm8mkZnzapnZQD/bmcy+TKA07W+
F6Z2ugtrC9HUuYuD126nEN0yOZ6ebQw=
=UMCR
-----END PGP SIGNATURE-----

--v5tn8bip5qGij2M6--
