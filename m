Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29158C47DB7
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 19:52:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 792DF87BC1;
	Thu, 18 Jan 2024 20:52:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dPdyvxpH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F76287BC9; Thu, 18 Jan 2024 20:52:20 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6544C87BC1
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 20:52:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rfried.dev@gmail.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2046c724383so57183fac.1
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 11:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705607537; x=1706212337; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hf0k5CE9SFAXdBj1dS69Dh8qgKjIsLTkk81n/033VP8=;
 b=dPdyvxpHd9QQaNvfHZCsRgBojSC0RRbXju0CUR5+bS/ZxKxwlruIpdSs9NGj1R2VGx
 6f+Ic8KrZtzUNa9QP1viZGtg/avaSjGiVymYPyvmlsEfx8rVeAAfVDn97OKrngz770CZ
 26z8ri7GyHpFWPfBy6jSwKESrVG1z/sZFqV2OT+DrUuK14g07wmMDEBHsqNX8OC/gjcd
 nMi2dolSra3viSuXgzl63TOjj/G0BB/VSM6HEEsOX7dPWmYeiksO/O77gY5bkcaCXWTU
 5qEtmw/Wd7dkIsv26YmFGWSvSaBHs+E+nrXOv4/Y+ghqCcmxh3ut/jQ559BrSC5glYRN
 o1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705607537; x=1706212337;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hf0k5CE9SFAXdBj1dS69Dh8qgKjIsLTkk81n/033VP8=;
 b=RXXVxt1dtNXCBoYCuh5A+2ftM+NNWtGPBB4QEGyGTZTo3WxV/EBFFvH9EXkHOzoE31
 FqMR7rauHRUz/j+MPXRVv8bRoXyAk6rD+CqwMEChlKhdYW5+UihX1rukjbEb8lYYDOtK
 f7pFZVQkbheHO44RWjirNoljguNGZCM1ncOAOBbCMuWqWU38UNKmcU9XVV56LoFmaIkS
 jhEGUSJmfm2tbIZ34hmOmAXvBaTI5dSTBfTZvyZOh469uWOdpbGZ0lF2z7yzf58RPVhE
 APFa9iiUP5Vj20vlH7hr6QR3a7/jFeS1yeGTbyzLFfD84pFl5QbhuX1nqO6k9Z4TJmBz
 EYVA==
X-Gm-Message-State: AOJu0YyX6/maEaX7gYo2kSeqnWrZmiLla1I2GLM3G1UVX0M17HPxA1RH
 Sd2uorD3FhlKMK2o1F+RTzNZcsJw0Olx6juf6JSbVBrY/peQyjH73e6RNlUHWihPe/9wqEjM+en
 13DgvCIwNSI6N84WdaGqMr5chVvM=
X-Google-Smtp-Source: AGHT+IHZPsz+GoSRnzByGo8DoIraX79hYGNLEELPaQ0ZUWI+Aff/BrZOvlD5bbgGSsEOvwUwKctkXiro4wSnZ7atu2s=
X-Received: by 2002:a05:6870:8984:b0:206:b561:72cd with SMTP id
 f4-20020a056870898400b00206b56172cdmr1401608oaq.85.1705607537008; Thu, 18 Jan
 2024 11:52:17 -0800 (PST)
MIME-Version: 1.0
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
 <20231219-b4-qcom-common-target-v2-3-b6dd9704219e@linaro.org>
In-Reply-To: <20231219-b4-qcom-common-target-v2-3-b6dd9704219e@linaro.org>
From: Ramon Fried <rfried.dev@gmail.com>
Date: Thu, 18 Jan 2024 23:52:06 +0200
Message-ID: <CAGi-RUKNboK9_HTBhNQjhBB6p+y16Q4NkvQyGuYE2-yVkqrOeg@mail.gmail.com>
Subject: Re: [PATCH v2 03/32] mmc: msm_sdhci: use modern clock handling
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
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

On Tue, Dec 19, 2023 at 6:04=E2=80=AFPM Caleb Connolly
<caleb.connolly@linaro.org> wrote:
>
> Use the clk_* helper functions and the correct property name for clocks.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/mmc/msm_sdhci.c | 69 ++++++++++++++++++++++++++++++++-----------=
------
>  1 file changed, 46 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
> index 604f9c3ff99c..863e6007a905 100644
> --- a/drivers/mmc/msm_sdhci.c
> +++ b/drivers/mmc/msm_sdhci.c
> @@ -44,6 +44,7 @@ struct msm_sdhc_plat {
>  struct msm_sdhc {
>         struct sdhci_host host;
>         void *base;
> +       struct clk_bulk clks;
>  };
>
>  struct msm_sdhc_variant_info {
> @@ -54,36 +55,56 @@ DECLARE_GLOBAL_DATA_PTR;
>
>  static int msm_sdc_clk_init(struct udevice *dev)
>  {
> -       int node =3D dev_of_offset(dev);
> -       uint clk_rate =3D fdtdec_get_uint(gd->fdt_blob, node, "clock-freq=
uency",
> -                                       400000);
> -       uint clkd[2]; /* clk_id and clk_no */
> -       int clk_offset;
> -       struct udevice *clk_dev;
> -       struct clk clk;
> -       int ret;
> +       struct msm_sdhc *prv =3D dev_get_priv(dev);
> +       ofnode node =3D dev_ofnode(dev);
> +       uint clk_rate;
> +       int ret, i =3D 0, n_clks;
> +       const char *clk_name;
>
> -       ret =3D fdtdec_get_int_array(gd->fdt_blob, node, "clock", clkd, 2=
);
> +       ret =3D ofnode_read_u32(node, "clock-frequency", &clk_rate);
>         if (ret)
> -               return ret;
> +               clk_rate =3D 400000;
>
> -       clk_offset =3D fdt_node_offset_by_phandle(gd->fdt_blob, clkd[0]);
> -       if (clk_offset < 0)
> -               return clk_offset;
> -
> -       ret =3D uclass_get_device_by_of_offset(UCLASS_CLK, clk_offset, &c=
lk_dev);
> -       if (ret)
> +       ret =3D clk_get_bulk(dev, &prv->clks);
> +       if (ret) {
> +               debug("Couldn't get mmc clocks: %d\n", ret);
>                 return ret;
> +       }
>
> -       clk.id =3D clkd[1];
> -       ret =3D clk_request(clk_dev, &clk);
> -       if (ret < 0)
> +       ret =3D clk_enable_bulk(&prv->clks);
> +       if (ret) {
> +               debug("Couldn't enable mmc clocks: %d\n", ret);
>                 return ret;
> +       }
>
> -       ret =3D clk_set_rate(&clk, clk_rate);
> -       clk_free(&clk);
> -       if (ret < 0)
> -               return ret;
> +       /* If clock-names is unspecified, then the first clock is the cor=
e clock */
> +       if (!ofnode_get_property(node, "clock-names", &n_clks)) {
> +               if (!clk_set_rate(&prv->clks.clks[0], clk_rate)) {
> +                       printf("Couldn't set core clock rate: %d\n", ret)=
;
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       /* Find the index of the "core" clock */
> +       while (i < n_clks) {
> +               ofnode_read_string_index(node, "clock-names", i, &clk_nam=
e);
> +               if (!strcmp(clk_name, "core"))
> +                       break;
> +               i++;
> +       }
> +
> +       if (i >=3D prv->clks.count) {
> +               printf("Couldn't find core clock (index %d but only have =
%d clocks)\n", i,
> +                      prv->clks.count);
> +               return -EINVAL;
> +       }
> +
> +       /* The clock is already enabled by the clk_bulk above */
> +       ret =3D clk_set_rate(&prv->clks.clks[i], clk_rate);
> +       if (!ret) {
> +               printf("Couldn't set core clock rate: %d\n", ret);
> +               return -EINVAL;
> +       }
>
>         return 0;
>  }
> @@ -188,6 +209,8 @@ static int msm_sdc_remove(struct udevice *dev)
>         if (!var_info->mci_removed)
>                 writel(0, priv->base + SDCC_MCI_HC_MODE);
>
> +       clk_release_bulk(&priv->clks);
> +
>         return 0;
>  }
>
>
> --
> 2.42.1
>
Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
