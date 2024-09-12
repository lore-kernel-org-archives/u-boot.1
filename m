Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98340EE6450
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 12:35:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8C9288FA8;
	Thu, 12 Sep 2024 14:35:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kl7QMKFs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59E4C88FA9; Thu, 12 Sep 2024 14:35:13 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D49888FA0
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 14:35:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2f66423686bso8826501fa.3
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 05:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726144510; x=1726749310; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mLPHQUCam4B0APDzJH0If0p2IihCI8kBPg1UVK0ENOs=;
 b=kl7QMKFsbDsXxlLpPdstKa7hNI7gOFkhXrPBSXcCGAkGDtBx3aKJzbaPJoasvgAxhn
 3HvOZyiSoaCzfeTJ1kofvDEmyZ/wgC0x/rbD0nAB2+ZR9FDpdHPBu60guMtK4B9CTTuH
 b5aXWbYRnShom4+E1/J86LF2KfQJd8ZErIYP7PbKX6L/TZs6OXBdDEhB9XhH/DCZcKdf
 PteO/plYZMAHa1Pub0Nc3FuNrxXXBQqpMl7btTfTsPzspoLs2RVj6TStttuHdiU/ivb4
 sisOSeiDu6HnD3Io3NbfBu8YRIC+aKg9zpP/TBi1SFvRmoqM63hQkXoRnBfmpQd6X/rW
 KkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726144510; x=1726749310;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mLPHQUCam4B0APDzJH0If0p2IihCI8kBPg1UVK0ENOs=;
 b=q4IWxRo7aDXF7d4DOGQhVIGCm0NAT/Z4YH3Iff5P/tYQ/nCp7om5+Gt94NkXT8jEXl
 D/v17O9MfTi1X78YBRHE74zuEckHjeZjTU9Utxl+oQsog8B84VvIHFVphMh7WSYUl5Zi
 Mg5ePTr7tsAx0uZrgijx8M5jTPm3AcEVOXMgF+ghdY7gSUWE7KQQd4dx/Qizh5JX4JZI
 I3Ljk1Y2ZJWqNmUZYi2LR1q2AZbCzBPugn7f1ayIAou/wKQRzqQdwGHiYwLA2VimzHrS
 AaU+rOyL6QuZm7U+5TF6ND48s/Tw8VQs18WfTR6+/C1lEf5G9pQ8Xr2/Y6VHQ5UYWBVd
 TtfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyOb/Gb2/s+LgLG4RWIonK3eBUSZIRbclJUPis4oZmyRxsjyEAorruR9B21hNwOwQOI8VC/LU=@lists.denx.de
X-Gm-Message-State: AOJu0YxzAQzLrTVamFmijpffGO3kCFhlQWpjvvpUtbXvK1YMBmGBo6M0
 7km7sxJLsuYsiviT0+JQZwGBqbOQYUdpk5vkhwksIva0nH1XGPorw8e5oanOLwyJBrCIaNxB3Fa
 YlcP++B69ZvHTllm+MsdqCwwdn/M=
X-Google-Smtp-Source: AGHT+IFy1WPuWs9scSPugT1wnTqOzcnsWJMPJ/xfMfULAiOFXKD5GUY6LTDrrUA3SGDPk8xSg1w3WUFyE6Uym6DHyro=
X-Received: by 2002:a2e:b8c1:0:b0:2ef:22ed:3818 with SMTP id
 38308e7fff4ca-2f787f2e664mr14051821fa.32.1726144509353; Thu, 12 Sep 2024
 05:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240910101344.110633-1-miquel.raynal@bootlin.com>
 <20240910101344.110633-5-miquel.raynal@bootlin.com>
In-Reply-To: <20240910101344.110633-5-miquel.raynal@bootlin.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 12 Sep 2024 09:34:58 -0300
Message-ID: <CAOMZO5BXRK4fN=k1Tt457NWFdT2eT6wRHCiYVH27CkNuyS6m6A@mail.gmail.com>
Subject: Re: [PATCH 4/8] imx: power-domain: Describe the i.MX8 MEDIAMIX domain
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Anatolij Gustschin <agust@denx.de>, u-boot@lists.denx.de, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ian Ray <ian.ray@gehealthcare.com>, Marek Vasut <marek.vasut@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Sep 10, 2024 at 7:31=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:

> +       [IMX8MP_POWER_DOMAIN_MEDIAMIX] =3D {
> +               .bits =3D {
> +                       .pxx =3D IMX8MP_MEDIAMIX_Pxx_REQ,
> +                       .map =3D IMX8MP_MEDIAMIX_A53_DOMAIN,
> +                       .hskreq =3D IMX8MP_MEDIAMIX_PWRDNREQN,
> +                       .hskack =3D IMX8MP_MEDIAMIX_PWRDNACKN,
> +               },
> +               .pgc =3D BIT(IMX8MP_PGC_MEDIAMIX),
> +               .keep_clocks =3D true,
> +       },

Great, this matches the drivers/pmdomain/imx/gpcv2.c kernel driver:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
