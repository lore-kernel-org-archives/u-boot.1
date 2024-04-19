Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164ACC4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 16:50:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 437C0886C2;
	Fri, 19 Apr 2024 18:50:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WnXj5aS2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 020B0887E5; Fri, 19 Apr 2024 18:50:21 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DC6C886B2
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 18:50:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thierry.reding@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-51abd9fcbf6so1656015e87.1
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 09:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713545418; x=1714150218; darn=lists.denx.de;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/q6fb7/TAhF1HcUqQQ7jgBpG4gRzbb7UYwozLuT6LOQ=;
 b=WnXj5aS27tzEUHUryHjfhpLFe1nWKRzH7WFOTYoK5Yf0/2TMzpFq18eUbadif1fpNy
 xKdOdiPpQzAU18gzXLkjuBRI3UXsUaN/Ev9GBRd1bB0YqDsGT8ednNV3Zzvnv0jEZAB4
 SvFmNP8U6laGikXjZ1cryJx9JRBw2hhg7K4JJ1nnRBMDMdaxi4InKun7tIkiMiCGJ0wx
 Ga35B77cF88ilKQSKjffNVsvxlQlLxB97BaNvGQp9gFv7sFU27bhXQYl98ApRNmA7DpB
 Xf6ujXK+OAq5LlrpFt69hV9MxknQxJ4du3FEbLdsQKzmT37T35fEBWH8RgiAVdjxqxXV
 /swQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713545418; x=1714150218;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/q6fb7/TAhF1HcUqQQ7jgBpG4gRzbb7UYwozLuT6LOQ=;
 b=FGp0rkwa9FrbCi8fvf9PQdBQy32/gVeTrfK/Fij3eGdYC/8+yvWvEAh7R7P9rsOSLu
 VzdAReMbH2BfTdbIIQREJ5mD1ceftOfRZzH+qxKnqalZMBOU2IYOfxmnTYYm7Cb4hBIz
 4R+ARj+wzT6VtwzXmLKkQWg4K0RPcinTt7F03n3/dab4oE8kgCK/LgCCCW9WybZUsoiy
 cnxFkVE5W5HHDtdGkkSpM+99GPRzaVTVQqlII/m8teaW3V6SsD5t7ETLVsmB4/+2vio2
 lYiaWKUioGDN1a+fKK0vBGbQkAbN1rvwfZLVBFGKEH2yy2PkRit75CMBxduJzpFdTpqt
 7bCQ==
X-Gm-Message-State: AOJu0YyVJ14dkw5lk/Numf8atzFU2Qi+Uf9rS//7h3nA0uTQACTc9p07
 PsQgd/2OEXAvSg3ZcbQNcc2fn4AymzbP8CmXb+cqsoXICXdqQEelGqZFWA==
X-Google-Smtp-Source: AGHT+IE3f4//E1zPmAPd2VaxEBdMmmOIuPHmkKXuCgorxMMoDCZDM533gJ6OhZtSh4u5ei6RAi4rTw==
X-Received: by 2002:ac2:4642:0:b0:516:d232:2516 with SMTP id
 s2-20020ac24642000000b00516d2322516mr2398977lfo.6.1713545417872; 
 Fri, 19 Apr 2024 09:50:17 -0700 (PDT)
Received: from localhost
 (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 ig11-20020a1709072e0b00b00a525492801dsm2402406ejc.119.2024.04.19.09.50.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 09:50:17 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=f2187cbcf020c8cdfd79b319897a4841e84614162381c930ad9ab9b1e30d;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Mime-Version: 1.0
Date: Fri, 19 Apr 2024 18:50:16 +0200
Message-Id: <D0O95L5RA8EK.25BOW85QA8LS7@gmail.com>
Cc: <u-boot@lists.denx.de>
Subject: Re: [PATCH v6 05/18] video: tegra20: dc: add PLLD2 parent support
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Svyatoslav Ryhel" <clamor95@gmail.com>, "Thierry Reding"
 <treding@nvidia.com>, "Anatolij Gustschin" <agust@denx.de>, "Simon Glass"
 <sjg@chromium.org>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240123171633.246057-1-clamor95@gmail.com>
 <20240123171633.246057-6-clamor95@gmail.com>
In-Reply-To: <20240123171633.246057-6-clamor95@gmail.com>
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

--f2187cbcf020c8cdfd79b319897a4841e84614162381c930ad9ab9b1e30d
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jan 23, 2024 at 6:16 PM CET, Svyatoslav Ryhel wrote:
> T30+ SOC have second PLLD - PLLD2 which can be actively used by
> DC and act as main DISP1/2 clock parent.
>
> Tested-by: Agneli <poczt@protonmail.ch> # Toshiba AC100 T20
> Tested-by: Robert Eckelmann <longnoserob@gmail.com> # ASUS TF101
> Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # ASUS Grouper E156=
5
> Tested-by: Ion Agorria <ion@agorria.com> # HTC One X
> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Nvidia Tegratab T114
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/video/tegra20/tegra-dc.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--f2187cbcf020c8cdfd79b319897a4841e84614162381c930ad9ab9b1e30d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmYioMkACgkQ3SOs138+
s6ENpA//YrWEBkqw88mHZJruSceNvlZhjOVOoFs49O0tAnAlctd9AIHcfD3f8cTb
tiNz8SH6mBNzFYmBNxieDeKH5xkWmd+6qlgzUA+C8oE74VYBw8P8yKa1jLo6/RdF
tpFGXcM2/lpDW1vWLHcCSaeTsWJsj5Q/9q/x7MHKcnBaB+IERPptPt/hYZHU2wlR
mMQYz1MkSSzvq4BdU2bmffQMqK1nHRghr4E65tvNgg9E7hHsfHbwRl4sv4DwJ/68
IJlpZFTZA6lFT5vWwfW8+ygWalhocX/UKRKulT0Yy8W8mnvlGR+6aR+9gj7wEQ7z
6DrAyBwT3GKozf9G3uCO2FMOzumV3E0CNlot+Dj2YqYjYeDLeP+UgCEPl3LX5XPB
bXJzI2lSlNWhjUgq/+lS6ux6m6rV+btZRT/IdZtlk8Kbv8TutgqIqbNVLB/a4Kxn
6XV/OYNLreT2OCiDcpjH+0dcM9EBcZeW2AzF9T0pbYznXQfbn7KIluep+a6s+vyU
vNLdfSA33ZEtLPgA1Pfyq6JtSMG4GQASayAkeFBN6dzLmfkgaEQrrzojBGPEw0fM
lRXyjb/tcGe56JQAWd9KBE4Rav27Zx588V7YqpHos+NHhq8sXLIIJJxZPQTXbRTe
3riWIlVQuK6GB1DsPzQ3ru081tYZm999BydigSsa3dqjOV+yCf0=
=NhTD
-----END PGP SIGNATURE-----

--f2187cbcf020c8cdfd79b319897a4841e84614162381c930ad9ab9b1e30d--
