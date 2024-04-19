Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C82C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 16:48:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C38EE887FB;
	Fri, 19 Apr 2024 18:48:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FCEEXVAq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B40B887E0; Fri, 19 Apr 2024 18:48:49 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 143AA887FB
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 18:48:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thierry.reding@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a5544fd07easo252577266b.0
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 09:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713545326; x=1714150126; darn=lists.denx.de;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wWcMZvvi+/hkX5dug+b+Z6Zix6kWiw6C//SgHWl3f40=;
 b=FCEEXVAqepEJl6CivtWyqFVekrFI1FzDq4WGx4ELuSLFwUqEG5WW3t+WapPy03WfJL
 Rvhggc3tCXMZPi8ugWSwEpLxnOSfIT2YnOvPODOM2QH9crsOtJPDZ39BVvOjpWAZGIRF
 gsSZ+anjDUYR/rMs7Pl486pBrt5rrUx6cIlBwTRrKfedzxbNKxesPIIFw1lJ0JPaitoY
 vyEvwtq+Mg/j8M6b07+ps8qfw6iY+HOmlEvLWpDVx7iLn4vXBP9niAJSS7okS08EhvGg
 +t1fWpRdk9+nZ8b0vtRAy7t+cEme69kDpHbivQlXq8NECVscGwCUJ7VkRKCLRCbM3fd8
 QVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713545326; x=1714150126;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wWcMZvvi+/hkX5dug+b+Z6Zix6kWiw6C//SgHWl3f40=;
 b=khGXwpWnajBZjUO4g2WuUkEA6SW1S6eBaruvA8sg7xw1H6R6amCYZnbALMhDqwh1Df
 SOg0ze409EVS1jSxz8i2NmMJQjC6lYfXlJQ5o89h/XLss2mGBy06aCmxWGsrR6R9cKG5
 NS8IwaLVNmY3GM85Ql4UoxzZqTH2cj4enpy/ejC3q3HpFZBHLTe4MgjTPAO2mh3fos++
 eM1OBemgPqaCyzIWc6H4SbcAqTwYS193u83RFzbbvcIYFOnmK7MdkFGCrWz2GewdcWVO
 JeCug/DbC4yDnVnJi7ZEILQyYY13Y+gCt/ztjehQz6x77W6hRZ2/Qu9mAyBGkhy4fHit
 fQag==
X-Gm-Message-State: AOJu0Yze7ao2WhgFVNO3J13zMtbgZjWcTwPJtBIw0eOvNefV1vCMeiry
 p0jwOd5vh76Y9NEEE8DVFdA6D+egOIy5VYvJ9Pl20hfzzyOv8KFR
X-Google-Smtp-Source: AGHT+IH78VCyfuSmD46dZ428Ln2V/I6KxaezTJQBhZpAmPAmxIaVPl7X4S41rjImyhpaswrDQNQcRA==
X-Received: by 2002:a17:906:3bcb:b0:a52:6d20:7559 with SMTP id
 v11-20020a1709063bcb00b00a526d207559mr1691135ejf.40.1713545326418; 
 Fri, 19 Apr 2024 09:48:46 -0700 (PDT)
Received: from localhost
 (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 m19-20020a1709062b9300b00a524476aac9sm2421661ejg.108.2024.04.19.09.48.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 09:48:46 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=3118598f6dbc0f52f6a918ba388a5dc1bfed081e65249721fa4e8b14733d;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Mime-Version: 1.0
Date: Fri, 19 Apr 2024 18:48:45 +0200
Message-Id: <D0O94F99JWEQ.1KY2XXP0S1TFZ@gmail.com>
Cc: <u-boot@lists.denx.de>
Subject: Re: [PATCH v6 08/18] video: tegra20: dc: configure behavior if
 PLLD/D2 is used
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Svyatoslav Ryhel" <clamor95@gmail.com>, "Thierry Reding"
 <treding@nvidia.com>, "Anatolij Gustschin" <agust@denx.de>, "Simon Glass"
 <sjg@chromium.org>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240123171633.246057-1-clamor95@gmail.com>
 <20240123171633.246057-9-clamor95@gmail.com>
In-Reply-To: <20240123171633.246057-9-clamor95@gmail.com>
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

--3118598f6dbc0f52f6a918ba388a5dc1bfed081e65249721fa4e8b14733d
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jan 23, 2024 at 6:16 PM CET, Svyatoslav Ryhel wrote:
> If DISP1 is a PLLD/D2 child, it cannot go over 370MHz. The cause
> of this is not quite clear. This can be overcomed by further
> halving the PLLD/D2 if the target parent rate is over 800MHz.
> This way DISP1 and DSI clocks will have the same frequency. The
> shift divider in this case has to be calculated from the
> original PLLD/D2 frequency and is passed from the DSI driver.
>
> Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # ASUS Grouper E156=
5
> Tested-by: Ion Agorria <ion@agorria.com> # HTC One X
> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Nvidia Tegratab T114
> Tested-by: Jonas Schw=C3=B6bel <jonasschwoebel@yahoo.de> # Microsoft Surf=
ace 2
> Signed-off-by: Jonas Schw=C3=B6bel <jonasschwoebel@yahoo.de>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/video/tegra20/tegra-dc.c  | 34 +++++++++++++++++++------------
>  drivers/video/tegra20/tegra-dc.h  |  1 +
>  drivers/video/tegra20/tegra-dsi.c | 14 +++++++++++++
>  3 files changed, 36 insertions(+), 13 deletions(-)

I'm not very familiar with these clocks, but seeing that this was
extensively tested, I guess this is okay, so:

Acked-by: Thierry Reding <treding@nvidia.com>

--3118598f6dbc0f52f6a918ba388a5dc1bfed081e65249721fa4e8b14733d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmYioG0ACgkQ3SOs138+
s6E+tg/8DwhEwhF4ecf0rK6/xw/ugWzmO257puZ+U0p28zGwtpomvk5rd5YHh6VJ
/sVU41/5oXptAOTo6wu+T5MepkItho6e7heECJkyy+pp+3sNhjK1HKFPxEp/gOKm
fGvgnFR5U63W9MNdgvTo4ntykYFzJqKeBNhZCMWkjtasOkh3BJiwULSTaaDvofiF
kd519X5nAAZ08TaXUmivnq01Mm0WTeC29l/xvkTmFhIiiRrbKQrzOq404dQBehv0
IEkVXrKNSdeL9OhcFOOGLmjr6Yu3Gonvw/9L2cdsvn714LW93gf+DWfALVqh0nHj
h+o8WbB9tUq3C6wDUfUUbkQdeI6Vo4NPxHHXcPznB5I3XWAluJCGDVQoYiGtBqhk
CktgyGrs7rw6f+jKICGPiF0gIjPqaZvOeUo1Ur9Rd8IK2k2FNuEuGiinOG0VNCTi
F/6/HTI7ijQwxHoz0Hrvqpg4b6pGWLphyA89XzrR7rQvqQKP0bOk7I2na2JbpQET
bCUwPxj+mA72Bzm/NesGEPBMHiBmxnYiI2aFdV2PDS9ZPzKQFFFacNbG6ael7tpn
YGKbsqEc4/4mLG84Tlsr9iprqm55YXXd9GqoPsPcdrZw1eqxkks3nH+RKKTQ2y3K
choERsz9tgev8QNaLGdM6cWvSJ47V5CoH0ZfAR1Au6KWuJKIerk=
=nlOO
-----END PGP SIGNATURE-----

--3118598f6dbc0f52f6a918ba388a5dc1bfed081e65249721fa4e8b14733d--
