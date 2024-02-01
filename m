Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EC9C4828D
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 14:46:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99EC087CA8;
	Thu,  1 Feb 2024 15:46:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="cOPqZ5lK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D71187CD3; Thu,  1 Feb 2024 15:46:45 +0100 (CET)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 849F487C92
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 15:46:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2cf4d2175b2so11552091fa.0
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 06:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1706798803; x=1707403603; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BM8udHT5+fAxzM5rai+bmk13ktSrH0Dy8ZtthJTBZ8E=;
 b=cOPqZ5lKwkLRKk3zrtv00VOZYaUh946kZiPWxgs7CJzLNAP3+NGYTnrG98cGndP3sS
 KGpA9XR3Vyct38WEOKr0d2NFNXLfnzge8BhuyYuk+TSdPmLt/ItD5/NuS4vpf7CvVAhq
 gfGBPdiybSWA2r6A9/Z2uzLFUTijlncV8VhQSpAv/x7zPG5KDx6rGuBT1rkt0olmMUyc
 hvrS89FVwKxlrC0dqIFoeN4BBaWsQHiEENas6CBhCAcLAAoQ5iGik/e2PNZDmermqWLE
 v50kYKSafHJxE9mBaxMdtaOsi9YM21r54MiLwXe2gaq1ayRoTKApdqw3nds86vrfxZcd
 rdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706798803; x=1707403603;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BM8udHT5+fAxzM5rai+bmk13ktSrH0Dy8ZtthJTBZ8E=;
 b=aT8e0x9LJey3clnNmxqtShR4q+jaUMJjIVrKhc/YYRNQKX5g2uRkenuW98OzkIiSiz
 QTAHNmkd6A3GfR762AXbfG5jYiDVFL8phoak6YZPx9Zso8H/aG5ch9wC0PNo6eTaX4z+
 w6syX7trjMojcdIr7OHjfktoQwmg+afHrhXabNEQ3QKN6JJxKnwMaPz1i7vc0ZahQWB6
 v5AC1uAtfcrXYnrIS73ySOgiolZh8Au3aE2q/KDfOjiVX5IIzyvAUBUd7BEdF5BlkCl/
 tAGCmYaxMoU0l+vFCeyIwHZwSo1SqucGzJN8hZEQxDKtE0ctk29VWAQaTomvm5s7FFff
 KIBQ==
X-Gm-Message-State: AOJu0YzxGDhGiHebiFTQP54e73Sn20B2XhHTeknQkWPxrWhy3haT1y7b
 EEhSqte86IaoGoA7ixCg5PNbjydlsW6OiQMhTQn9R4ZM+n9jmv7T0SHiex3+6XptwucqnXrqRQF
 jS7nJ7cOPcvqMd9sKBgPNPvg/Ir7p90ANdBAVvuxFOQXlq4+yLzw=
X-Google-Smtp-Source: AGHT+IHfGvIZmFJQBXrrh9DJh9MeWzKdCoe0aO9cB9Kh860Omo5L10oxBlGbY1XtR+hcL7Y94/Kl2/xSb4xre7cMjSU=
X-Received: by 2002:a2e:848d:0:b0:2cf:4731:f170 with SMTP id
 b13-20020a2e848d000000b002cf4731f170mr3705571ljh.51.1706798802820; Thu, 01
 Feb 2024 06:46:42 -0800 (PST)
MIME-Version: 1.0
References: <20240201030634.1120963-16-bb@ti.com>
 <20240201030634.1120963-19-bb@ti.com>
In-Reply-To: <20240201030634.1120963-19-bb@ti.com>
From: Igor Opaniuk <igor.opaniuk@foundries.io>
Date: Thu, 1 Feb 2024 15:46:31 +0100
Message-ID: <CAL6CDMHrKdDpE6k0eh-ACLEdfAGkvYC8J5FSk17ZVyx0br5gvw@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] power: domain: ti: use IS_ENABLED macro
To: Bryan Brattlof <bb@ti.com>
Cc: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Hari Nagalla <hnagalla@ti.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Nishanth Menon <nm@ti.com>,
 Andrew Davis <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 UBoot Mailing List <u-boot@lists.denx.de>
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

On Thu, Feb 1, 2024 at 4:07=E2=80=AFAM Bryan Brattlof <bb@ti.com> wrote:
>
> Cleanup this list and standardize on using the IS_ENABLED macro for the
> power domain data list.
>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>  drivers/power/domain/ti-power-domain.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/power/domain/ti-power-domain.c b/drivers/power/domai=
n/ti-power-domain.c
> index b34c982f4f5fa..dc5d74539edcf 100644
> --- a/drivers/power/domain/ti-power-domain.c
> +++ b/drivers/power/domain/ti-power-domain.c
> @@ -81,19 +81,20 @@ static const struct soc_attr ti_k3_soc_pd_data[] =3D =
{
>                 .family =3D "J7200",
>                 .data =3D &j7200_pd_platdata,
>         },
> -#elif CONFIG_SOC_K3_J721S2
> +#endif
> +#if IS_ENABLED(CONFIG_SOC_K3_J721S2)
>         {
>                 .family =3D "J721S2",
>                 .data =3D &j721s2_pd_platdata,
>         },
>  #endif
> -#ifdef CONFIG_SOC_K3_AM625
> +#if IS_ENABLED(CONFIG_SOC_K3_AM625)
>         {
>                 .family =3D "AM62X",
>                 .data =3D &am62x_pd_platdata,
>         },
>  #endif
> -#ifdef CONFIG_SOC_K3_AM62A7
> +#if IS_ENABLED(CONFIG_SOC_K3_AM62A7)
>         {
>                 .family =3D "AM62AX",
>                 .data =3D &am62ax_pd_platdata,
> --
> 2.43.0
>

Reviewed-by: Igor Opaniuk <igor.opaniuk@foundries.io>
--=20
Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations

Igor Opaniuk
Senior Software Engineer, Embedded & Security
E: igor.opaniuk@foundries.io
W: www.foundries.io
