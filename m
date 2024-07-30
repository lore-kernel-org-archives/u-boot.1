Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3651C3DA61
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 07:13:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C025887D4;
	Tue, 30 Jul 2024 09:13:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="nKQq/zdO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19AB688827; Tue, 30 Jul 2024 09:13:20 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37B76887DB
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 09:13:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a7ac469e4c4so835464866b.0
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 00:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1722323598; x=1722928398;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ug5wHidVHwAE2YIQwU+B/Yi/LPGW16Aa+fQHP3VBC+Q=;
 b=nKQq/zdOVKuTITcgKjavJnepb/sSMMtzbWTQGyYAd/7fdyu6HDhBC1oC/7QZSNlX1N
 vCaA/f/te6M1roavT3YAmXYU+vRwdIz1OWelRT6k3mo5hZm0euO/jgY1lroNwcBtg5nT
 /puyphIP2U13YPbTRmQ44RTzuiqlQl2RTR7JI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722323598; x=1722928398;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ug5wHidVHwAE2YIQwU+B/Yi/LPGW16Aa+fQHP3VBC+Q=;
 b=kBfsKEPlptGG+xmWTrPzWxE0OnAHTKSFI0BxQgcw/hkePLBgGQ8Vuu20K9O33izxx7
 swZUua53neHgcnCUATjuTPCxAVFCoNvl3xd8XjycTvNRrtTv1ui+BWfh/O+YC8GjSmYz
 OE+d5ECAT9Hre0QSbOKarFnr/zSBHRr0QBj4/80iCeUJ4H4crcNyVa3HL6o610DVF8XY
 yCf1SbUtn5gb6a33cJ3wvPMj3GYmBKxqyvv85ut/bTqWR4LzqbqAoUBRzjcIGsu7IW+L
 aPXlhPrMCC7DfXxOyOc3OtV5gKQwdT5dSaAZuLLo0PEK3ENlfbQeY1xBE5D1isX76Y5g
 Aiww==
X-Gm-Message-State: AOJu0YyxoT9h6/lDMCyzRwn1UEJBVcsNj6STmjypNOoBaruPK1z9ybku
 6GNIx8Bmz+ijXrSmCS1uLEKY2WwAmbby5C4h2KERsTKzKCxLY+LEl9NPsoQcY3VmvPfLnimUQGL
 Fc+SNxTqNYtQTIu4rgDrmFX+G1K2jU6TUdigslQ==
X-Google-Smtp-Source: AGHT+IFlUfSn5pD+Rw5h77YO3vbccIrM25aRFv/xpgbSCqGwPeC5XgKpa/sqa/nHlYqDlUaKmKuiQ8P/4PljmhP6KEE=
X-Received: by 2002:a17:906:6187:b0:a72:5f3f:27a2 with SMTP id
 a640c23a62f3a-a7d85a426f1mr91141766b.26.1722323597585; Tue, 30 Jul 2024
 00:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240730073003.28892-1-Zhiqiang.Hou@nxp.com>
 <20240730073003.28892-6-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20240730073003.28892-6-Zhiqiang.Hou@nxp.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 30 Jul 2024 09:13:06 +0200
Message-ID: <CAOf5uw=B6Wc-vYvttvWw2+TLUMvwAByhXw8Zi014NpRDNm_vKg@mail.gmail.com>
Subject: Re: [PATCHv4 05/14] cpu: imx: fix the CPU frequency in
 cpu_imx_get_info()
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, peng.fan@nxp.com, 
 festevam@gmail.com, sjg@chromium.org, marex@denx.de, lukma@denx.de, 
 seanga2@gmail.com, xypron.glpk@gmx.de
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

Hi

On Tue, Jul 30, 2024 at 9:10=E2=80=AFAM Zhiqiang Hou <Zhiqiang.Hou@nxp.com>=
 wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> The cpu_freq stores the current CPU frequency in Hz.
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V4:
>  - Rewrote the change log.
>
>  drivers/cpu/imx8_cpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c
> index 4781a56554..601a7071a6 100644
> --- a/drivers/cpu/imx8_cpu.c
> +++ b/drivers/cpu/imx8_cpu.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright 2019 NXP
> + * Copyright 2019, 2024 NXP
>   */
>
>  #include <cpu.h>
> @@ -193,7 +193,7 @@ static int cpu_imx_get_info(const struct udevice *dev=
, struct cpu_info *info)
>  {
>         struct cpu_imx_plat *plat =3D dev_get_plat(dev);
>
> -       info->cpu_freq =3D plat->freq_mhz * 1000;
> +       info->cpu_freq =3D plat->freq_mhz * 1000000;
>         info->features =3D BIT(CPU_FEAT_L1_CACHE) | BIT(CPU_FEAT_MMU);

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>


>         return 0;
>  }
> --
> 2.17.1
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
