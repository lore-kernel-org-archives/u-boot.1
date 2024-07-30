Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47481C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 07:12:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC1D188640;
	Tue, 30 Jul 2024 09:12:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="FC9buFE/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2409088640; Tue, 30 Jul 2024 09:12:09 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1142E88570
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 09:12:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a7a8e73b29cso311070166b.3
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 00:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1722323526; x=1722928326;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mgaA76KiKsArl4oUcGVcliIcYMldk+Zp8+2JAs4n1To=;
 b=FC9buFE/mIAqpUxJ2T/ClBBp6WyEwxXGZTVVpxn2xSY9EEG0TUbgeRlnsDTznh8D2D
 wVgNMjNP4vX0qPHkp+rGCa6bCcBkR91wdN2JYqo6bJzcaznL9rsTIV2QfE27i+SMIHFY
 lADkbLMSiGWSv+k5b1yF2NSDgRB8H72wDwo34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722323526; x=1722928326;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mgaA76KiKsArl4oUcGVcliIcYMldk+Zp8+2JAs4n1To=;
 b=WhBvB2zzkVFbp1knqzqnZQmXxDgqWjj+f9velC7iJM6QpjLHDE2Kzo+Y4H0T8hLieK
 6J+j+AM5rHi9KTIqribpDqqGpDsoo9QTquMJ79h+svsC3UT29pCN7nGOBCuuPSzCYT9p
 L2TJqaP4nIFO3JL5W801NNB+JAr7dJ5vvi6uHvTSkcWSxO4uHwuOxt9DlBxLd4an14LW
 ds4okV0eyD1qJwOLvvQTgHtvOXyIpgygQ/PDqksXApH+FrYvOmbZ3QNmNf7K1xJ9rMVv
 +KBXQl9S/tVDghgtkVpJr4VbdW9wvH7z2/r4QgBL9B1tATVgJg//w1e4rTB0JwV2nJTN
 JTyQ==
X-Gm-Message-State: AOJu0YwVRS863euInsW2/pBdM6sOXNaNH1c24RVLmZb0aYYbbSt62J3S
 qSsdO0L/tvu5t2zCD3zrdKi1aRJ6qareBxXWTEog2VF748k1elzYuTPzbwQltE7eMc6R5hGynHJ
 SoA64+XElxzAlf7643luhANvk4JVuG6G2lQYvHQ==
X-Google-Smtp-Source: AGHT+IGh6TZ4qNtIQ4ausBSPp9Adui2zT1a0EI+xs0Bg88Tbwq/eq4/g7N/T/0azuxm+BkVObxZRoS0ZuR0LWSod9zs=
X-Received: by 2002:a17:906:fe0b:b0:a7d:391f:17af with SMTP id
 a640c23a62f3a-a7d40128701mr654485766b.51.1722323526320; Tue, 30 Jul 2024
 00:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240730073003.28892-1-Zhiqiang.Hou@nxp.com>
 <20240730073003.28892-2-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20240730073003.28892-2-Zhiqiang.Hou@nxp.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 30 Jul 2024 09:11:55 +0200
Message-ID: <CAOf5uwk4CMFphnskngXierUoZLwR6deMw+MDa98Xco6GJ=Rf+A@mail.gmail.com>
Subject: Re: [PATCHv4 01/14] clk: imx8m: register ARM A53 core clock
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

On Tue, Jul 30, 2024 at 9:09=E2=80=AFAM Zhiqiang Hou <Zhiqiang.Hou@nxp.com>=
 wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> Register ARM A53 core clock for i.MX 8M Mini, Nano and Plus, preparing
> for enabling the 'cpu' command, which depends on this to print CPU core
> frequency.
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V4:
>  - Moved here from other thread.
>
>  drivers/clk/imx/clk-imx8mm.c | 6 ++++++
>  drivers/clk/imx/clk-imx8mn.c | 7 +++++++
>  drivers/clk/imx/clk-imx8mp.c | 7 +++++++
>  3 files changed, 20 insertions(+)
>
> diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
> index e538f047b3..8d98fbaaa9 100644
> --- a/drivers/clk/imx/clk-imx8mm.c
> +++ b/drivers/clk/imx/clk-imx8mm.c
> @@ -21,6 +21,8 @@ static const char * const sys_pll1_bypass_sels[] =3D {"=
sys_pll1", "sys_pll1_ref_se
>  static const char * const sys_pll2_bypass_sels[] =3D {"sys_pll2", "sys_p=
ll2_ref_sel", };
>  static const char * const sys_pll3_bypass_sels[] =3D {"sys_pll3", "sys_p=
ll3_ref_sel", };
>
> +static const char * const imx8mm_arm_core_sels[] =3D {"arm_a53_src", "ar=
m_pll_out", };
> +
>  static const char * const imx8mm_a53_sels[] =3D {"clock-osc-24m", "arm_p=
ll_out", "sys_pll2_500m",
>                                                "sys_pll2_1000m", "sys_pll=
1_800m", "sys_pll1_400m",
>                                                "audio_pll1_out", "sys_pll=
3_out", };
> @@ -417,6 +419,10 @@ static int imx8mm_clk_probe(struct udevice *dev)
>                imx_clk_gate4("qspi_root_clk", "qspi", base + 0x42f0, 0));
>  #endif
>
> +       clk_dm(IMX8MM_CLK_ARM,
> +              imx_clk_mux2("arm_core", base + 0x9880, 24, 1,
> +                           imx8mm_arm_core_sels,
> +                           ARRAY_SIZE(imx8mm_arm_core_sels)));
>         return 0;

imx_clk_mux2_flags I think you should mark this clock CLK_IS_CRITICAL

Michael

>  }
>
> diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
> index 8911e342f1..3de03e1f3b 100644
> --- a/drivers/clk/imx/clk-imx8mn.c
> +++ b/drivers/clk/imx/clk-imx8mn.c
> @@ -23,6 +23,8 @@ static const char * const sys_pll1_bypass_sels[] =3D {"=
sys_pll1", "sys_pll1_ref_se
>  static const char * const sys_pll2_bypass_sels[] =3D {"sys_pll2", "sys_p=
ll2_ref_sel", };
>  static const char * const sys_pll3_bypass_sels[] =3D {"sys_pll3", "sys_p=
ll3_ref_sel", };
>
> +static const char * const imx8mn_arm_core_sels[] =3D {"arm_a53_src", "ar=
m_pll_out", };
> +
>  static const char * const imx8mn_a53_sels[] =3D {"clock-osc-24m", "arm_p=
ll_out", "sys_pll2_500m",
>                                                "sys_pll2_1000m", "sys_pll=
1_800m", "sys_pll1_400m",
>                                                "audio_pll1_out", "sys_pll=
3_out", };
> @@ -403,6 +405,11 @@ static int imx8mn_clk_probe(struct udevice *dev)
>                imx_clk_gate4("ecspi3_root_clk", "ecspi3", base + 0x4090, =
0));
>  #endif
>
> +       clk_dm(IMX8MN_CLK_ARM,
> +              imx_clk_mux2("arm_core", base + 0x9880, 24, 1,
> +                           imx8mn_arm_core_sels,
> +                           ARRAY_SIZE(imx8mn_arm_core_sels)));
> +
>         return 0;
>  }
>
> diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
> index 6b18483c81..32ea60f11e 100644
> --- a/drivers/clk/imx/clk-imx8mp.c
> +++ b/drivers/clk/imx/clk-imx8mp.c
> @@ -21,6 +21,8 @@ static const char * const sys_pll1_bypass_sels[] =3D {"=
sys_pll1", "sys_pll1_ref_se
>  static const char * const sys_pll2_bypass_sels[] =3D {"sys_pll2", "sys_p=
ll2_ref_sel", };
>  static const char * const sys_pll3_bypass_sels[] =3D {"sys_pll3", "sys_p=
ll3_ref_sel", };
>
> +static const char * const imx8mp_arm_core_sels[] =3D {"arm_a53_src", "ar=
m_pll_out", };
> +
>  static const char * const imx8mp_a53_sels[] =3D {"clock-osc-24m", "arm_p=
ll_out", "sys_pll2_500m",
>                                                "sys_pll2_1000m", "sys_pll=
1_800m", "sys_pll1_400m",
>                                                "audio_pll1_out", "sys_pll=
3_out", };
> @@ -354,6 +356,11 @@ static int imx8mp_clk_probe(struct udevice *dev)
>
>         clk_dm(IMX8MP_CLK_USDHC3_ROOT, imx_clk_gate4("usdhc3_root_clk", "=
usdhc3", base + 0x45e0, 0));
>
> +       clk_dm(IMX8MP_CLK_ARM,
> +              imx_clk_mux2("arm_core", base + 0x9880, 24, 1,
> +                           imx8mp_arm_core_sels,
> +                           ARRAY_SIZE(imx8mp_arm_core_sels)));
> +
>         return 0;
>  }
>
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
