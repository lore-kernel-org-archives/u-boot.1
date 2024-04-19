Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375D2C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 16:29:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1126C88258;
	Fri, 19 Apr 2024 18:29:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T77ylcgp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BC638820C; Fri, 19 Apr 2024 18:29:16 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2D5588244
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 18:29:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thierry.reding@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-571e44067e0so44544a12.2
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 09:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713544152; x=1714148952; darn=lists.denx.de;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QjU52KTrWlZclxPw2AkgtwCzFeZwXyqLQRdpRkWyYTY=;
 b=T77ylcgpw5lH9h2n94zmTDnGsbUJbSzNLMmWFIFhHkJNZBXmHbo5lL8AxcjqGIXc0q
 DxuQDlfhEhFK4io8FI0Vu3e0+fJLq1eKRtRywaS/LXKCUI864CyrKL+iBvjnnEWAh7IP
 phk2ivuXRL7hF5cpFV3ZVOl7fA0GN5hdlm444MpB55xYSaztGbGJ5/LpekqjpwqrfxUO
 Vd9uVsVeKkUCrV/I0wgh6WkvpILpJNPWa3YCrGzi/UZnZf8U3oUyiBHnVF2O8hvhq+Ql
 sz4C+njNwXeG8zxy+rAxONtrS2jvoGhqQF8qJHkS0qNpGyXMdsEGvaaLcTFLOpfUEmsz
 hm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713544152; x=1714148952;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QjU52KTrWlZclxPw2AkgtwCzFeZwXyqLQRdpRkWyYTY=;
 b=swroXwu1jnsobBjr7sArvZc6kGZxKa3GIG0MrNe/UNLTzvAHFloBMTgEQbjsnN1hqE
 ics2E2dtAcQOg59DIXa6IsWXGPhH+yPMgDVKe64oLtWXvkLzD+Ge9rbawh41IHxLfslY
 hFaPWdSurGWJD1ulVhncY8GqQZHOwn0cGtB0ocQ7kXPYL4HC+LHPX6nlsnDIb5r+hE0i
 nvxv3gbwy0htEnNxXbH3mPBd5xutIKn6KX/2EF1VDcRNuym8ayWYJ5dpOUXzqH/zZaSf
 Gdz13sHu687UQoBVEP/96VLK5vlSIiALfY7mlAPFJyYQkEmYLJaOFB7ojVIMTrLdtIsI
 Hvqw==
X-Gm-Message-State: AOJu0YweycOdZPY1VeRRduHezNVqu00mYVLsIyJrDa5ACSBzq0qmouqv
 CSDa9Mwgd5irWPZ5O7/E+Da3+5ihcV85RJJRKbLLdbfMFCN9afyF
X-Google-Smtp-Source: AGHT+IERu0eAxSG3WWEhG43Ldpvp2rouK4S468NMiWuMsNMP7iBid8H8Tq5aNbuYdkfnaCO23Df/aA==
X-Received: by 2002:a50:8d17:0:b0:56b:d158:c5de with SMTP id
 s23-20020a508d17000000b0056bd158c5demr1638904eds.16.1713544151770; 
 Fri, 19 Apr 2024 09:29:11 -0700 (PDT)
Received: from localhost
 (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 j23-20020aa7ca57000000b0056e0376286bsm2296075edt.24.2024.04.19.09.29.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 09:29:11 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=b19341877a1283a00df8a076b240ace755da82e0156ce6a1287656a5ab4e;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Mime-Version: 1.0
Date: Fri, 19 Apr 2024 18:29:10 +0200
Message-Id: <D0O8PFLLUFAC.N45G26CHNBBY@gmail.com>
Cc: <u-boot@lists.denx.de>
Subject: Re: [PATCH v6 14/18] video: tegra20: dsi: add T114 support
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Svyatoslav Ryhel" <clamor95@gmail.com>, "Thierry Reding"
 <treding@nvidia.com>, "Anatolij Gustschin" <agust@denx.de>, "Simon Glass"
 <sjg@chromium.org>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240123171633.246057-1-clamor95@gmail.com>
 <20240123171633.246057-15-clamor95@gmail.com>
In-Reply-To: <20240123171633.246057-15-clamor95@gmail.com>
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

--b19341877a1283a00df8a076b240ace755da82e0156ce6a1287656a5ab4e
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jan 23, 2024 at 6:16 PM CET, Svyatoslav Ryhel wrote:
> Existing Tegra DSI driver mostly fits T114 apart MIPI calibration
> which on T114 has dedicated driver. To resolve this MIPI calibration
> logic was split for pre-T114 and T114+ devices.
>
> Tested-by: Ion Agorria <ion@agorria.com> # HTC One X
> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Nvidia Tegratab T114
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/video/tegra20/tegra-dsi.c             | 78 ++++++++++++++++++-
>  .../video/tegra20/tegra-dsi.h                 | 24 +++++-
>  2 files changed, 96 insertions(+), 6 deletions(-)
>  rename arch/arm/include/asm/arch-tegra30/dsi.h =3D> drivers/video/tegra2=
0/tegra-dsi.h (90%)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--b19341877a1283a00df8a076b240ace755da82e0156ce6a1287656a5ab4e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmYim9cACgkQ3SOs138+
s6HilA/+JQaz+Ubdsb0Qm1BnfWt76EU3j/4O9TQbhVfDoG9xFwngSEG3xNNCUcLB
+M6kfMJQCi87nFRBzbn3LI4gYPURVUkdWbyWMYNgyRq4xoLA4erKXtVISHaq8l3C
jGnGLdg+1l6IdHbobiE6GaOLyabPh2SzVGUsJMxsOqcNM363rcPJ2QxqYpjZdL7Q
2ndI3L+649sa28ahJ/uQaRLQ2hYPR1XJ7use2v5cES2htqsa3Jgrm3liSx957Ar1
4cIein+2hRJwEs+mBYj7qPaEyrvBX5BTAoubY+s7vlG1SiMllIRCEpsxeDTBhwtY
Rv/PWTQfH19ch8o8pDOUvmPE0gy/+8HRbjET0BmBVmKHqRs5o9yIZQ4GsK3j+gRJ
AMH1BpixMNBei3ztJSz8A00Ak4peRfnDLH6Wn4xbVFlkZ3fQzKMLg1Kydj5DA5TI
Bx1cjals5IPArHSK8O/qc1ytjLQFFmG2ch8Sp4PEExTtpA0qdsvDZnaPfX87NoHu
sr47e05GNPGnkDBpp5pCZM+sOXtFQaqNXBvfl3qca3SE13ptVP4FQzHfb0XTThg1
ws1q06alHhmlA49Yy3nnMnUQaDkC//JLrCAvOJATXCCxKh540Y3u+5syH1Y+uBha
OmtH7kcIyS8PlZOIoOgdh2b5N18LLlDo4nhUon3EtzG1PJT6AdM=
=JMe/
-----END PGP SIGNATURE-----

--b19341877a1283a00df8a076b240ace755da82e0156ce6a1287656a5ab4e--
