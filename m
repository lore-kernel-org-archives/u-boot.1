Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42B4C4829A
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 22:33:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 414E187D8B;
	Tue, 13 Feb 2024 23:33:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="J5WJFF1u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9E5F87D8B; Tue, 13 Feb 2024 23:33:08 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 392CA86F67
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 23:32:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-604aaf2d047so49495167b3.0
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 14:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707863578; x=1708468378; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Tt/R9zxmT1F/l5LMM9XnOjphX7UVt2rnqldzcghl57Q=;
 b=J5WJFF1uRAW0c9Q4bhb7rcgX9YJUPvYp2hhQxXsyq3Nwcp9lH/BwFMxbNLfJ4A7MGL
 6rnvUwmgXe6pqeMh+B4M9rLUUhn1QsomyRdGVIOkeKG4XrSoeJiESg1HbICLslKLvllC
 NbVla8sGjLcSoLSVqrbvX2entgRZsxEgByrw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707863578; x=1708468378;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tt/R9zxmT1F/l5LMM9XnOjphX7UVt2rnqldzcghl57Q=;
 b=FNa+Hhq5XsSDIFx8BcvEOkHKMkRIbbdzVns0tUO1x9aq/7/zLA+5YWzg5omprEg3XE
 x/65VnrGKWY5omahVUNnqmjJHw2mth03+H1lpvYVPAud1dI6AR/hzlo1OmtnjmtCBg/V
 wNzk50w+xlxj8QkpEcj7u0TpFg5nQhyAff98mtVWmzfU7FOskp/ViHc7cWbTvjohO7wf
 Dtz/xMT1seRE6g81o+D3iBkGDdz9xsmFBipfhe5ckx4LOyhZhTFs1boJ4FgVC2druS0D
 tPOOObsesXCJ+bY9E3DJQQj1k3Aj3HXi2J2Awwh5IbTqp9ftnOpvZ7hFunPWgxZDQkh9
 K1Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV16g7m70jXp1L4mLhDpxFggxY+h80NTRbXK9XtD/rEyrsc9HsklrM9KIO90A5EvKgM5oUZ2tmRto95ohuWeC1PrSXl3A==
X-Gm-Message-State: AOJu0YyCWvYXlTWaCGnZ1bR9BhoFAGOF2eWlmuzarWa5fy1IcQpupGju
 JObKzTpzoMOZj9Ok0PA5ghJsD5lkQMOvSXGGLlIg2i23nzPG+tQgyaLpdMmadVw=
X-Google-Smtp-Source: AGHT+IFV2fbn/DCr+cl72UO3jBcPpCcfpZKe1EQpx9lHHzYq/XyuGpc4E30OfBzqdkfPac/USWLrRA==
X-Received: by 2002:a0d:eac3:0:b0:604:3efb:938f with SMTP id
 t186-20020a0deac3000000b006043efb938fmr749518ywe.3.1707863577688; 
 Tue, 13 Feb 2024 14:32:57 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVIi0I5JCSOWbEL7bM+bMqGW8WkeOFDlNCb8ePXMVkFN9jzFn8X+NrkQEGBlo4Jg7bIf6CNE8xYW0KiFCYD4zdX0z4qf0MRb8bYnCP0OOQXDu8eDnB+pGmO0hO5/mNHHczsGJmchcVJoC48qgZ3LCQ=
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 h13-20020a81b40d000000b00604941e2f1fsm1905476ywi.130.2024.02.13.14.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 14:32:56 -0800 (PST)
Date: Tue, 13 Feb 2024 17:32:54 -0500
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 u-boot@lists.denx.de, Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH v2] boot: add support for button commands
Message-ID: <20240213223254.GT3040305@bill-the-cat>
References: <20240109115310.1917139-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3RJHRciI5HABbZHX"
Content-Disposition: inline
In-Reply-To: <20240109115310.1917139-1-caleb.connolly@linaro.org>
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


--3RJHRciI5HABbZHX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2024 at 11:51:09AM +0000, Caleb Connolly wrote:

> With the relatively new button API in U-Boot, it's now much easier to
> model the common usecase of mapping arbitrary actions to different
> buttons during boot - for example entering fastboot mode, setting some
> additional kernel cmdline arguments, or booting with a custom recovery
> ramdisk, to name a few.
>=20
> Historically, this functionality has been implemented in board code,
> making it fixed for a given U-Boot binary and requiring the code be
> duplicated and modified for every board.
>=20
> Implement a generic abstraction to run an arbitrary command during boot
> when a specific button is pressed. The button -> command mapping is
> configured via environment variables with the following format:
>=20
>   button_cmd_N_name=3D<button label>
>   button_cmd_N=3D<command to run>
>=20
> Where N is the mapping number starting from 0. For example:
>=20
>   button_cmd_0_name=3Dvol_down
>   button_cmd_0=3Dfastboot usb 0
>=20
> This will cause the device to enter fastboot mode if volume down is held
> during boot.
>=20
> After we enter the cli loop the button commands are no longer valid,
> this allows the buttons to additionally be used for navigating a boot
> menu.
>=20
> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Tegra30
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Applied to u-boot/master, thanks!

--=20
Tom

--3RJHRciI5HABbZHX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXL7hAACgkQFHw5/5Y0
tywAeAwAoKRFm8UhbFN57SsVmvcKp0EPO0hST0BZKB+dqxTkVuyTp7OnPnr/cA9T
Ssz8sq6qufNnJ/0lNo/iqWdhBjr2xkwkd1OMnqTL4/66HgoE6X+o/8USetIAIcB8
xDiZnk15mQBVrZIofIwc3HMK8sOOrRtMrPZDA19M5nIEGnQwjpHkF6LP17ulCUIi
JKaL45NVaijkxwcnZtGcW4Op7EWrY5IH4JB3670cF2KLQ6dVvXa9CFTUlhYEShOX
c4Ql2QH5sDa8t5vqEuqQ4VQ87QRJnlGdnpno2xYHdiK8jUVNBfGd9K5Dh1XT5PL2
7kMX6Ztqzl950NsKynSvTsRspvvyvqUStSXbNeSPlFbdV25YFkCA1+/0+PNYhhSU
YkUbJRLB4gRxRdG+sFDcW5H3oSWQTifheE0hNHtspk55cKOih74Jraj647G8eUTh
YAta3ojxvJ/WYfF2TKae6is5gGH+qkPesuxDoHCXiHSCXswQMO2Q4jUTJna8DToW
gheXQrBn
=wrBR
-----END PGP SIGNATURE-----

--3RJHRciI5HABbZHX--
