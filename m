Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBCAC282C5
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 12:34:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C90B811C1;
	Mon,  3 Mar 2025 13:34:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="fTeYPPDq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5B15811CE; Mon,  3 Mar 2025 13:34:23 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B90F810ED
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 13:34:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2feb867849fso5418987a91.3
 for <u-boot@lists.denx.de>; Mon, 03 Mar 2025 04:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1741005258; x=1741610058;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5/xfWACXf8w24X7F2WiLZ/CQUmLelMP6O62cy/K1rQA=;
 b=fTeYPPDqFW9gU4NmOqpJ95idWKh6IB2lnAbn/Ah0Cr5s5Y7m/Nfh8UZ2s8zfsMj2UT
 kVYe6XtHqT/qYAj1M2BpooPzGLXb3SGAXH3vycAFW5ZV0XBy6g8m57ioDnSQFLXgW/gr
 e9q0xIQn9RBWsua7WqfACFX6Vm+pfq6EyBffE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741005258; x=1741610058;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5/xfWACXf8w24X7F2WiLZ/CQUmLelMP6O62cy/K1rQA=;
 b=DAkRXd4EU1ZC3nOfY/zMso2OYA6kapijZAbareZDrgMdCBJiiCCEwcDX2QItVJsBJS
 uiBhQQT4nAWrdPT9r/puHq6YJ2tEXNStvUI3eFpeB9yLpA4ITS06mER/5QhuWxG0GgXY
 HbPJRP2sT06LYD7fAjVAzvPQuebriEVAS9lg8moqFh7kGJGzThgwhZ4p3vSSWfpB2q+w
 OfoUZxlRQksxEt00F6f6uKzy4ULCnV7pwbM33SEc7lGrJWp/4nQoI1g4OYXTKLg8PrRm
 BcgiROZ6wxrS44LxMlaTHwLYZvK6JI9qdUwBBMVsxmvdugO1oFGoL7N+utC/ij+19k+3
 nFlg==
X-Gm-Message-State: AOJu0YxoDXxt7pkMnLJri5Wio9EfQ+NZv+B95CuGd8ieirufc5hg2Vn+
 tSd7u7jaA7OM25YrYXD7o1pXBirGv+vnOmLN3gzutKCnjltGJasLwckd1Ge3Rs9tQsTyCU/5s/K
 s9P9jDzxWRLOSqUjtIIPON/ASDn40Rw09UsuEeg==
X-Gm-Gg: ASbGnct/bWqQqY8+rtHK96dZyhuT6Rydgw3UCquW20HCQS6DPyo7fIOlgG5c+co0t8H
 dE0/vUaC9tonI4MBR7hhPFPFHXzX4AyMnyWHz/sVzogW6SiYA7fn9cYVqY9es3pUgHFX3KT/AvU
 azyKlOUrWvgnt3t4WMF0TEQ6ylY40UR4qNPwjaoAslYcdqDQCDudgYQ0MllAw=
X-Google-Smtp-Source: AGHT+IE6TAvggHM7HFff4KFS23SRgkPCi2fflM9v9JUgMJPJVH04y9raaRK7jGDPfCTI6FVcijGGp0As66y8kG+kt58=
X-Received: by 2002:a17:90b:2f87:b0:2f2:3efd:96da with SMTP id
 98e67ed59e1d1-2febabf1aeamr21372688a91.24.1741005258421; Mon, 03 Mar 2025
 04:34:18 -0800 (PST)
MIME-Version: 1.0
References: <20250302165249.267992-1-aford173@gmail.com>
 <20250302165249.267992-2-aford173@gmail.com>
In-Reply-To: <20250302165249.267992-2-aford173@gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 3 Mar 2025 13:34:07 +0100
X-Gm-Features: AQ5f1JrNjOv3_rg1vJWDoTbCbfhCem4nWDQRb_xz_rp--M81SribS97KNRY5iVI
Message-ID: <CAOf5uwm3y4n9m3hw2OCV9kproJGAG6qiJU-ZcRrb4f3j1sQxXA@mail.gmail.com>
Subject: Re: [PATCH 01/10] clk: imx6q: Properly handle imx6qp ESPI clk_sels
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Tim Harvey <tharvey@gateworks.com>, Peter Robinson <pbrobinson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Adam

On Sun, Mar 2, 2025 at 5:53=E2=80=AFPM Adam Ford <aford173@gmail.com> wrote=
:

> The ECSPI clock has the ability to select between pll3_60m and
> osc on the imx6qp, where it's fixed on other variants.  Fix this
> by adding using a helper function to determine SoC variant and
> register the clock accordingly.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
>  drivers/clk/imx/clk-imx6q.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
> index df9f0285e1e..de5e5d8132b 100644
> --- a/drivers/clk/imx/clk-imx6q.c
> +++ b/drivers/clk/imx/clk-imx6q.c
> @@ -13,6 +13,11 @@
>
>  #include "clk.h"
>
> +static inline int clk_on_imx6qp(void)
> +{
> +       return of_machine_is_compatible("fsl,imx6qp");
> +}
> +
>

It's static, why just not use direct compatible?


>  static int imx6q_clk_request(struct clk *clk)
>  {
>         if (clk->id < IMX6QDL_CLK_DUMMY || clk->id >=3D IMX6QDL_CLK_END) =
{
> @@ -35,6 +40,7 @@ static const char *const usdhc_sels[] =3D {
> "pll2_pfd2_396m", "pll2_pfd0_352m", };
>  static const char *const periph_sels[] =3D { "periph_pre", "periph_clk2"=
, };
>  static const char *const periph_pre_sels[] =3D { "pll2_bus",
> "pll2_pfd2_396m",
>                                                "pll2_pfd0_352m",
> "pll2_198m", };
> +static const char *const ecspi_sels[] =3D { "pll3_60m", "osc", };
>
>  static int imx6q_clk_probe(struct udevice *dev)
>  {
> @@ -78,6 +84,12 @@ static int imx6q_clk_probe(struct udevice *dev)
>                imx_clk_mux("usdhc4_sel", base + 0x1c, 19, 1,
>                            usdhc_sels, ARRAY_SIZE(usdhc_sels)));
>
> +       if (clk_on_imx6qp()) {
> +               clk_dm(IMX6QDL_CLK_ECSPI_SEL,
> +                      imx_clk_mux("ecspi_sel", base + 0x38, 18, 1,
> ecspi_sels,
> +                                  ARRAY_SIZE(ecspi_sels)));
> +       }
> +
>         clk_dm(IMX6QDL_CLK_USDHC1_PODF,
>                imx_clk_divider("usdhc1_podf", "usdhc1_sel",
>                                base + 0x24, 11, 3));
> @@ -91,9 +103,13 @@ static int imx6q_clk_probe(struct udevice *dev)
>                imx_clk_divider("usdhc4_podf", "usdhc4_sel",
>                                base + 0x24, 22, 3));
>
> -       clk_dm(IMX6QDL_CLK_ECSPI_ROOT,
> -              imx_clk_divider("ecspi_root", "pll3_60m", base + 0x38, 19,
> 6));
> -
> +       if (clk_on_imx6qp()) {
> +               clk_dm(IMX6QDL_CLK_ECSPI_ROOT,
> +                      imx_clk_divider("ecspi_root", "ecspi_sel", base +
> 0x38, 19, 6));
> +       } else {
> +               clk_dm(IMX6QDL_CLK_ECSPI_ROOT,
> +                      imx_clk_divider("ecspi_root", "pll3_60m", base +
> 0x38, 19, 6));
> +       }
>         clk_dm(IMX6QDL_CLK_ECSPI1,
>                imx_clk_gate2("ecspi1", "ecspi_root", base + 0x6c, 0));
>         clk_dm(IMX6QDL_CLK_ECSPI2,
>

Apart of that I'm almost fine with it.

Reviewed-By: Michael Trimarchi <michael@amarulasolutions.com>


> --
> 2.45.2
>
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
