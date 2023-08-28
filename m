Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E1B9C83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 08:00:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8090C8056A;
	Mon, 28 Aug 2023 10:00:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qVCMdoxo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8486986481; Mon, 28 Aug 2023 10:00:50 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F097F803AB
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 10:00:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-401187f8071so17967825e9.0
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 01:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693209647; x=1693814447;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r2QzUlc0gkkczaAUyLAILQ8GrcHJN8Tov2gM+Ukpdzo=;
 b=qVCMdoxoPp6dkPLWX9FCOpP2uEM0+mZTJbN4BlBvQpXHCksDbwf8KemUJdrYKMaiCz
 BxsRtjwrj8dW9OYjS0dK5wj8lGGZvDQ8JGM5oqgEM3EEyIoVBTnffnuEjTbEHDkxzABz
 dtv9mzdHeoldwf/MYlTbmg2Yrxo0h+F+xVqpjfmmwTzW0ItqFlJj3djOcty5YOvbpGWe
 2jCOT3CwgnyNn0B9MhPnxTh46XTWNV5afMYZvtd+mP3ykH0xO6IVIBFwgt5MyCtQvcf/
 PZH366aM8AwmpJx87QaMgbR4/0zCKXdlM5Vm1/beoCxlDKwuAA6vr3TaFIar+q+g1/Es
 eDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693209647; x=1693814447;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r2QzUlc0gkkczaAUyLAILQ8GrcHJN8Tov2gM+Ukpdzo=;
 b=lFvTOUPkKKWIYX8yfSDPkfyIU4tI2fcWC05+WNy9OLMaDwTRRUEAoVRuhdAYBbgXLd
 X5vbqEjqTJeyZXjZRla/44QN7vR+Fk+Ner4nv9yo8bNX0FxBQ1L5/4fmQC/q0pa6GCKJ
 loxWbHeAjEJuuJm2wC/Ee5+Q30MZjIi9KLPzEMPKzv2Yr+McLTQl18TfI2xClgeBBccV
 9d9+8OYUh7xDYV/oWMQhrXOnEBYaH2SPQ757FNwnJ1eRCWrYK2CFiNMuXOff07efdrYa
 9FtRbciHYcFx7l2nrx0faRPJcHH3ZzReWGW6nZj0125SBNXD+h0kYghn++WqslS1mKrD
 6ssg==
X-Gm-Message-State: AOJu0YyChl3mC4zzkTOO2hPF+vx28Qh55RZE6t68e/PaDdaP1yYJFPND
 2Z+1vliljPVUcHIwxfUit/ZRCXXUigg9pIIMyPA=
X-Google-Smtp-Source: AGHT+IECx1gb26vyeW+LzuTCJlAvG/iGHREQynr9cjdqTzzIbz4NyJHealCJa+wAT+7oaKYtSzbdkwphYSFYXGyWirA=
X-Received: by 2002:a05:600c:3113:b0:3ff:786:e811 with SMTP id
 g19-20020a05600c311300b003ff0786e811mr11873756wmo.3.1693209647120; Mon, 28
 Aug 2023 01:00:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230827082106.6255-1-clamor95@gmail.com>
 <20230827082106.6255-3-clamor95@gmail.com>
In-Reply-To: <20230827082106.6255-3-clamor95@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 28 Aug 2023 11:00:35 +0300
Message-ID: <CAPVz0n1iG8gXd3CQU==wPNFisk1fchA-7dDyPqwTJvORoV7BwQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] arm: mach-tegra: enable sysreset driver
To: Thierry Reding <treding@nvidia.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

=D0=BD=D0=B4, 27 =D1=81=D0=B5=D1=80=D0=BF. 2023=E2=80=AF=D1=80. =D0=BE 11:2=
1 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  arch/arm/mach-tegra/Kconfig | 3 +++
>  arch/arm/mach-tegra/pmc.c   | 9 ---------
>  2 files changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
> index 464bd0798f..453f94bcf2 100644
> --- a/arch/arm/mach-tegra/Kconfig
> +++ b/arch/arm/mach-tegra/Kconfig
> @@ -61,6 +61,9 @@ config TEGRA_COMMON
>         select MISC
>         select OF_CONTROL
>         select SPI
> +       select SYSRESET
> +       select SPL_SYSRESET
> +       select SYSRESET_TEGRA
>         imply CMD_DM
>         imply CRC32_VERIFY

Hello, Thierry! This causes buildman warnings on aarch64 (t184 and t210)

+ WARNING: unmet direct dependencies detected for SPL_SYSRESET
+  Depends on [n]: SYSRESET [=3Dy] && SPL_DM [=3Dn]
+  Selected by [y]:
+  - TEGRA_COMMON [=3Dy] && ARM [=3Dy] && ARCH_TEGRA [=3Dy]
   aarch64:  w+   p2771-0000-000

It lacks SPL_DM and since aarch64 is your main area of maintenance, may
you help setting it in a way which does not break anything from aarch64
perspective?

Context is next: I am trying to convert tegra PMC reset ability to DM sysre=
set
driver. Reason is to be able to use do_poweroff in DM sysreset form and it
stated that OR both do_reset and do_poweroff are in DM driver form or none.
Assume at some point this convertation will be requested anyway, like with
timer driver.

> diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c
> index 8d617bee63..c4f5106750 100644
> --- a/arch/arm/mach-tegra/pmc.c
> +++ b/arch/arm/mach-tegra/pmc.c
> @@ -84,12 +84,3 @@ void tegra_pmc_writel(u32 value, unsigned long offset)
>
>         writel(value, NV_PA_PMC_BASE + offset);
>  }
> -
> -void reset_cpu(void)
> -{
> -       u32 value;
> -
> -       value =3D tegra_pmc_readl(PMC_CNTRL);
> -       value |=3D PMC_CNTRL_MAIN_RST;
> -       tegra_pmc_writel(value, PMC_CNTRL);
> -}
> --
> 2.39.2
>
