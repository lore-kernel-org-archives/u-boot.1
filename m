Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7669CC4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 16:00:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1F3988758;
	Fri, 19 Apr 2024 18:00:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YX3kalXJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C19398876E; Fri, 19 Apr 2024 18:00:49 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D443288651
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 18:00:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thierry.reding@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a52aa665747so259462366b.2
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 09:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713542447; x=1714147247; darn=lists.denx.de;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0qAv9BEG7yTiTzXHypEaMGXTBAcDsDd6TcTg/cGGVBs=;
 b=YX3kalXJF9agqAXfOq+rTl5rpKsZF7ibQAnY0kERPMfm3rLe/24knUHWnWitzh2CEs
 +wtFUyVEbUUHA7g2gyuK+cBTN8zVasVzx+qejyUSIQlceYQobQTvm6fYCDY0fr8qdcqQ
 B3Vt6MjdCU1DG+Ik6XlJUtNFeyVS4x59sx6HfytcoXlEU+Q7GTWn3kP1XHI/IbKIs7jl
 jfqtpiAB8DxaH9TiECcu/k/JrcUU08GTSrpaGa8MIuZuv1jmZHpYjFAqye2LJN/mScKa
 xfUXQnDdRrL05kt7BOhe7CKKBCArVPHZAvGUPzAE68J6qq1FhtiILPBagXD2Wm1rLKMn
 hbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713542447; x=1714147247;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0qAv9BEG7yTiTzXHypEaMGXTBAcDsDd6TcTg/cGGVBs=;
 b=wtck7AvBPU8t1cSbM3kUN+TYDJ/RJnxxb7fc/+7fp6+NbGN7tObUyOfCkNDT6MsNrz
 HGdtcKFeem+0jstbpVMYohiE9NaoQ1aVN46Ti0TM8mOsMQNqTkIE1fdLEN28U94BfPCC
 dtvAi5aY9Qx3EHJKnH/4L/pWrDLLh1cGGLe9vkTkNRPSTFJCUUVypHoPXlrcunEkzoLj
 udsLgvPSXIB+qr7bi6bocLfM9CipntqioIoeSfFP7STrmcL/zOPsYZbSEZ4+2Skl5xap
 hrRMDSTo/IFDAvM5E23gh4DJrAdae7cJE24NzQZFuJ7uIiN9JpomVaD+OhyxL/8wEncH
 FO1Q==
X-Gm-Message-State: AOJu0YxyzKTvvSDZJiSJXMtjdJwAoRN7ng5XE1mCm7a6jgmGCP21whEw
 RbDXUZVvy4OSgjtrB4wiMaulYJEmVYTkYY9sfRkcWSG4D1c39Zys
X-Google-Smtp-Source: AGHT+IGHn8U5LUsnLKdtfxhXZmAXT4tihwq6BgphdEARirOjBNfWAjr8rdIyk5AuTuD8GUKKS4N4yQ==
X-Received: by 2002:a17:906:f582:b0:a55:90df:616b with SMTP id
 cm2-20020a170906f58200b00a5590df616bmr637078ejd.42.1713542447069; 
 Fri, 19 Apr 2024 09:00:47 -0700 (PDT)
Received: from localhost
 (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a170906b30b00b00a5242e285aesm2323727ejz.184.2024.04.19.09.00.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 09:00:46 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=80ff2cf9d0f22b38fd391acb59b0afaeb25aa39da0aaa6d92df1ed030dee;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Mime-Version: 1.0
Date: Fri, 19 Apr 2024 18:00:46 +0200
Message-Id: <D0O83OGN6PSZ.1CU7XFIMOJD59@gmail.com>
Subject: Re: [PATCH v6 18/18] video: tegra20: dsi: use set_backlight for
 backlight only
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Svyatoslav Ryhel" <clamor95@gmail.com>, "Thierry Reding"
 <treding@nvidia.com>, "Anatolij Gustschin" <agust@denx.de>, "Simon Glass"
 <sjg@chromium.org>
Cc: <u-boot@lists.denx.de>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240123171633.246057-1-clamor95@gmail.com>
 <20240123171633.246057-19-clamor95@gmail.com>
In-Reply-To: <20240123171633.246057-19-clamor95@gmail.com>
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

--80ff2cf9d0f22b38fd391acb59b0afaeb25aa39da0aaa6d92df1ed030dee
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jan 23, 2024 at 6:16 PM CET, Svyatoslav Ryhel wrote:
> From: Jonas Schw=C3=B6bel <jonasschwoebel@yahoo.de>
>
> Shift the backlight set further to prevent visual glitches on
> panel init.
>
> Signed-off-by: Jonas Schw=C3=B6bel <jonasschwoebel@yahoo.de>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/video/tegra20/tegra-dsi.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

I vaguely recall that some devices may have had the panel and the
backlight hooked up to the same regulator or enable GPIO, so calling
panel_set_backlight() too late may cause the DSI panel to malfunction.

That said, I'm not familiar with panel_set_backlight(), so perhaps it
always only sets the brightness and the power may already be on earlier?

Ah... nevermind... I see that panel_enable_backlight() is called prior
to panel_set_backlight(), so this looks like it should be fine.

Reviewed-by: Thierry Reding <treding@nvidia.com>

--80ff2cf9d0f22b38fd391acb59b0afaeb25aa39da0aaa6d92df1ed030dee
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmYilS4ACgkQ3SOs138+
s6FCGRAAu8ZbcBy4Sm+8MLiGi/7cA9UD572znCogxyTuoN7pezGsWO3u0vL1/AQv
wr0ZnAWSHiqadSZA7f8yKTMDLK2gqsai3QmLbS254MCfIvlCjCvAv+EpevJNym/H
fxQkpZAMOO2Xp8rYU9PBeyV9+H9jqMfEfjxPp90QLxAW+Z1Q2rd52oeGprUBZfv6
79LF76ony3zjTtj5J094tIoCSJrzC5EapoUZ2s5W057tYMVdf+OQ/KmRSqjzRcyc
/w3uOYogZ6nuheRDzS4kTl51Kw19jp5REEW9MTG2DikZ0yJM37x/clD0yi8+jyvq
vBCPYaWduU9qRgjIakChzDMMH/en4HIrGIUO6D4QhQlq81ooRoX57foKQpAlZNv1
e6egFhva9sT8cEOa2ooChGfRDITJazFLcVXXNytZfS19h5OdA4JdkOAFIwe5YWuN
T+TayNjCPv6hL65EIF87eqqQxiODaaehFPKMUH1gl0Tju5aO/BY1mFMlNMrkrsR9
m6ALwGpHuzEislzYJRSLx1mtsRQ5cpUlscwAor9sWa+Injs3+/mzFwHhh68kgGjf
uCf5iaU+9J2BdmzjeACdutcBpUih6xnYEd0NVvDiXMcioFSZzhRraBcV7e57NTEt
qg4kfvf5K6lnsHHnzB6ElqGQ3m0+B6kSFQ3xXP97yu1bdTVUyjk=
=qv90
-----END PGP SIGNATURE-----

--80ff2cf9d0f22b38fd391acb59b0afaeb25aa39da0aaa6d92df1ed030dee--
