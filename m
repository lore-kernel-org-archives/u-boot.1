Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B15AC4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 04:57:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB050882DA;
	Mon, 22 Apr 2024 06:57:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="maSmgQca";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B00E8832C; Mon, 22 Apr 2024 06:57:17 +0200 (CEST)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com
 [IPv6:2607:f8b0:4864:20::935])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F06188301
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 06:57:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-7ed6cf3e7f8so241962241.2
 for <u-boot@lists.denx.de>; Sun, 21 Apr 2024 21:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713761834; x=1714366634; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OXA284Komj/cwzq+KrHHOT1eANoRnLMqIBxJ9xMyUPA=;
 b=maSmgQcaG/5ldC7OaNIWPsSeDCjFohxcgMTBsPAkR0nEVk+AoMGLuXg0Zt6V168szN
 t9LMmEW0aTzCv7uvAfLHlOmdaQEAUxUt/qYLJKKHY6bj645ZGvVMkGaNmI4/RqY7gdJp
 +8qN9BNwM02JNVq0m9ry2/MDXmS+FgQ2WqPG4wrO94T7qPVCaMFvN75pdcGYLxDkHcgi
 3w9j6X5GNpjEG7x99JmoFIpKLsPyIkcm+xq+IVewrecoH+CBYWKHyKzR5kA478cNFjz7
 dPEdpmeDVKrtW0dIL8IdPlEQJlLUz62PFsgvJj21F27dafwNppqDWLXyXywJhVwwnDZ4
 +sAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713761834; x=1714366634;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OXA284Komj/cwzq+KrHHOT1eANoRnLMqIBxJ9xMyUPA=;
 b=R8e39URJ7F7KdWG/jaYRYyMgrikcA2++imzxEXuF4OL4z/n2o81DDfxIrrUWxXpH3k
 3f7EAMzsWbrtavW4ogB1DgLu3voZwsqaGggViMVVucEJyA/09/cCGeeqQ9PHZw5mpjR9
 I81ukmPIBd3FWh1yAnSzZaABJZN1Fif9qHVXrNYyT/+eD7ynTi3x9CWRnL1vnhnpkXrG
 24rVJi/xvgeFvGlFbcKki9ZIQWZ/AesM0TW8a0aC23dQn12c5tMcRDGmJhkqoukbqyT6
 SxfTAEnRuI2DhWbCxM7+tvn5JEX3X5SUUBspieU5ppxkf9MyCeOuHb5fNWcInzrFyB/+
 dyLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNCiBywWEY5IxYVKp2+caqa5sP+LiEqTZBTW8McveYn9usxNfOrmZuIHlTZswcyIzKFIIf1Sb0/Vz3h94A/lipDNuaeQ==
X-Gm-Message-State: AOJu0YwYxEQvCtvxHtcsINmVw9a9wJYKsPg38IFiLiQAaCTcSYkq2AfK
 0R1REwkQCGZw3NGp010SogkM/U9uBFB5YWnwZIs48YEsdTRK8bHW5UyMVQoR33eO9TlycG8V7MX
 t3NhjJXLud4uqavTfqXWLNgSt7Y0yb8tUWiT7Qw==
X-Google-Smtp-Source: AGHT+IHZY6uY35GlrY7YB17ubaBl1eHmc4VljnYiDtww77jm1NvEbnHyq50Bnh2IZ++y7D4/KffqlDNbdTTE/dk2xjc=
X-Received: by 2002:a05:6102:3555:b0:47b:dcbd:2b4d with SMTP id
 e21-20020a056102355500b0047bdcbd2b4dmr6923846vss.11.1713761834087; Sun, 21
 Apr 2024 21:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240419152902.4156600-1-tharvey@gateworks.com>
In-Reply-To: <20240419152902.4156600-1-tharvey@gateworks.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Sun, 21 Apr 2024 21:57:00 -0700
Message-ID: <CAFA6WYMWdvrqMHE9unR1mqk+Kg0-cYHp0q5JoGohpiAnn+1qxQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] clk: imx8mm: Add support for PCIe clocks
To: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Martyn Welch <martyn.welch@collabora.com>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Tim,

On Fri, 19 Apr 2024 at 08:29, Tim Harvey <tharvey@gateworks.com> wrote:
>
> Add support for PCIe clocks required to enable PCIe support on
> iMX8MM SoC.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
> v3: wrap pcie clk config around IS_ENABLED to avoid SPL growth as
>     suggested by Marek
> ---
>  drivers/clk/imx/clk-imx8mm.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>

Although I was at EOSS last week, it is really nice to see more iMX
SoCs adopting the modern PCIe DW iMX driver.

-Sumit

> diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
> index b5c253e49663..1a00dd1d287b 100644
> --- a/drivers/clk/imx/clk-imx8mm.c
> +++ b/drivers/clk/imx/clk-imx8mm.c
> @@ -66,6 +66,17 @@ static const char *imx8mm_i2c3_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_
>  static const char *imx8mm_i2c4_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m", "sys_pll3_out", "audio_pll1_out",
>                                          "video_pll1_out", "audio_pll2_out", "sys_pll1_133m", };
>
> +#if CONFIG_IS_ENABLED(PCIE_DW_IMX)
> +static const char *imx8mm_pcie1_ctrl_sels[] = {"clock-osc-24m", "sys_pll2_250m", "sys_pll2_200m", "sys_pll1_266m",
> +                                              "sys_pll1_800m", "sys_pll2_500m", "sys_pll2_333m", "sys_pll3_out", };
> +
> +static const char *imx8mm_pcie1_phy_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll2_500m", "clk_ext1", "clk_ext2",
> +                                             "clk_ext3", "clk_ext4", "sys_pll1_400m", };
> +
> +static const char *imx8mm_pcie1_aux_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll2_50m", "sys_pll3_out",
> +                                             "sys_pll2_100m", "sys_pll1_80m", "sys_pll1_160m", "sys_pll1_200m", };
> +#endif
> +
>  #ifndef CONFIG_SPL_BUILD
>  static const char *imx8mm_pwm1_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m", "sys_pll1_40m",
>                                          "sys_pll3_out", "clk_ext1", "sys_pll1_80m", "video_pll1_out", };
> @@ -256,6 +267,17 @@ static int imx8mm_clk_probe(struct udevice *dev)
>                 imx8m_clk_composite("usb_bus", imx8mm_usb_bus_sels, base + 0x8b80));
>
>         /* IP */
> +#if CONFIG_IS_ENABLED(PCIE_DW_IMX)
> +       clk_dm(IMX8MM_CLK_PCIE1_CTRL,
> +              imx8m_clk_composite("pcie1_ctrl", imx8mm_pcie1_ctrl_sels,
> +                                  base + 0xa300));
> +       clk_dm(IMX8MM_CLK_PCIE1_PHY,
> +              imx8m_clk_composite("pcie1_phy", imx8mm_pcie1_phy_sels,
> +                                  base + 0xa380));
> +       clk_dm(IMX8MM_CLK_PCIE1_AUX,
> +              imx8m_clk_composite("pcie1_aux", imx8mm_pcie1_aux_sels,
> +                                  base + 0xa400));
> +#endif
>         clk_dm(IMX8MM_CLK_USDHC1,
>                imx8m_clk_composite("usdhc1", imx8mm_usdhc1_sels,
>                                    base + 0xac00));
> @@ -339,6 +361,11 @@ static int imx8mm_clk_probe(struct udevice *dev)
>                imx_clk_gate4("pwm4_root_clk", "pwm4", base + 0x42b0, 0));
>  #endif
>
> +#if CONFIG_IS_ENABLED(PCIE_DW_IMX)
> +       clk_dm(IMX8MM_CLK_PCIE1_ROOT,
> +              imx_clk_gate4("pcie1_root_clk", "pcie1_ctrl", base + 0x4250, 0));
> +#endif
> +
>  #if CONFIG_IS_ENABLED(DM_SPI)
>         clk_dm(IMX8MM_CLK_ECSPI1,
>                imx8m_clk_composite("ecspi1", imx8mm_ecspi1_sels, base + 0xb280));
> --
> 2.25.1
>
