Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741C9C61DFD
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 09:21:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F9696086A;
	Wed,  2 Sep 2026 09:21:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a7QBE_z8osqO; Wed,  2 Sep 2026 09:21:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788340901;
	bh=bl2vlfwvvQ4JLwMipAgCLCpoKA4VFVLWBvkZlhYqtkk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xboOZBLkMGFefRid1wdMl8YNM/DmAq0GPG0QudrsfKEaJaXp79eG1XOdxWVHwZ73g
	 QqmRgSBwp7uISvK7OtVPtF9RZEJCZFdm71iu8HeUSXHyLWVCex3OcxSVo9mASoVAih
	 RVzVTcOZXgYdlpi+1NhC0YR0CvRIjW1nLaTIPXpQVtInlVFpZU74JDmFRiApDa/ycM
	 kHgb+T4FcCp8O5dsTzjEzW04n+jLzr/uOt3kAdRoPJ8cDsCzIT5tv49mAJMemsq9j2
	 04TvBE685P/vXlRjZGzvSYvU4tNcx4BavY+a0/bnnDW4YFZMxry3zkHqDUxP+dvIE1
	 z2j9mdu2SRtBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 11C1660829;
	Wed,  2 Sep 2026 09:21:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5AA3E2FE
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 09:21:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4C40140852
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 09:21:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rqMlu2YQv4XA for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 09:21:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=l+rNWA00
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 55FD4407ED
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 09:21:36 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c250c6a6a6eso111462766b.0
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 02:21:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788340894; cv=none;
 d=google.com; s=arc-20260327;
 b=fHjQpW9cJdjPbtXwaIjX06+5+Q2Z/w3jj5pPmhRdNEcSJaOy7wCw6NKKt0sx2s32CW
 KIi8x+r2ais84+/YG7vfCxzdkeHZh4C9J/TxL8S8utJvkIkq8kd11bjNjwl0bR+rLM7M
 mgTX7onTUkGCw2qCydV3ULXWrqFywBG99c+xdwQ3PMXm3zJ/i8m3mJuK+FhwU22qcaMF
 9Xl7aLR8xRc5sHowsYZ3Cghyx7gnpDKJiLBA+jStkWd9oNsjvhUqHVwGsNOl+Lm2iooG
 /8tnAy8iDEGXA3DoXQsbVbwLLOzldcbxWpbYL2UHQ/vqfpBPatm0PiGRS8Cpj7XdUQqg
 jrMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bl2vlfwvvQ4JLwMipAgCLCpoKA4VFVLWBvkZlhYqtkk=;
 fh=2m6p1x5/JpwxysHz1mM+EbXGt6aN26qlKnrzTcB3ctc=;
 b=MAqbd6reXoF5/XmAa0uVlyWyt7b2aPV/lHtoOVxEWnYzX4fWRNEpPcN8VqreQoD37X
 Ij1ex2nXZErqiTbK0FYXj1N9asRKTlpTolbDkPUGGdRR++BRR0IBlA62bmx+b1R7rXlt
 lTGZ2+txbyR4TGLjhW43VfNFIEzXTiYUqe4uogjcQSri8MuWOA9VHaIdM9QORD1qpsLG
 aoWcHOjbYW0vybXoC7BOuKe/DHDgRebFlQFQf4c72Z3dTlOPmzaFGB3umdGc4Id6oktd
 QYKxabC8EBEfMM5XcQiQV/GHeCRr8loHoY/JnCoerJD49k74VRhq9hcodWCeiYspY8//
 TWfQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788340894; x=1788945694;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bl2vlfwvvQ4JLwMipAgCLCpoKA4VFVLWBvkZlhYqtkk=;
 b=l+rNWA00lQvXf0q/XHhQMVqWQzhNcSXmDxOg7pRw93qkCOxBljjWRC8SrgcIDVU/3z
 BhbtTz4B6jmJIJ9MsNm1Oc9rXQf3HWlrd1Wwcl6hlNHDlt12IXguPIFzXg0aAHRXkrJS
 vk5fvp5bYjibpSg+tTmwVReQ1kyNobfpe/NNeGf35wNhInd810KyYyqPDqTdk7LVYx+h
 T61ZZr9jHxRmOsgc5+TL4aOo+U9jsTpS2ehoweOsJ+N+31QjD450v4Ye3ojZ2Wu/2FX9
 tb7XjLhdggSKguUvTy2eY4xZtJEv0eq6t99ECJmZgo5RYcxYMCdP11ru8vlFCL/Mxepz
 jaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788340894; x=1788945694;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bl2vlfwvvQ4JLwMipAgCLCpoKA4VFVLWBvkZlhYqtkk=;
 b=kMKwptcoXpfF/n9MsTC939Tnp+S0ZUz3viTC8PPmeUBDCS2EwBLgBsQsQtWRWR20Sy
 Ir4HV6UwWrsZQQVkbB18Ix8vROg8k4Cq4BPizVKpfM8tv2G+BY7hnsB4Q2aI5/A4VU9/
 VDkA6URxvmpEiR3sCl47K/UVhpLKYqVeV4GISlWmRuqwL3onih9evK+OeVMWq20O6d5G
 iea+Uj03+lKjeNudd3OaksScR0rL4biybNZAM6aQ87z53OVj5UPuLhNErrZ19yl5jkoh
 fgIVFBhS3B3MpNavgkNcU49WmTAyNYjOpGk4LFMQd/U8BNZmCiqGGGZ7vTzbESkrlR2K
 EREQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoolZ2Rar3jph2ssd7P6M/YN7kGLURWOsLcYWRTYUIQK9CAOgtigL4pWehIj4mrDw4WTdjVbME=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nxo69QCjxUniT3Pgq6f6i5VTG5y3hd9dFWGu64wLVDkLpa5/Aq
 rFSaXZP6/s1W6y2Lt1iPVq0liEV5YA/BShgLyvAIi4hrrT+czdDmwkJfXSq2m7F4KQB33KsjFTi
 uZffmYL0xz6sstXVMuc44Cnczhvod+pPbhjFehBlNrQ==
X-Gm-Gg: AYBFou125z08nvDLCz7GOZyuYhCQhy2IaqhrQQKBWooxOAkXf+0yV6bWYnflPCzIZcv
 lgjLTecdNm3Ct954TMltLgkXlEQ8tsb9nXDPJUmWrJtO1A7faLTRcwWqJRXpWLQF8/xw+VuRNRB
 BUmf6VT6FhTo7rwtRELdcLkIPeL+JgyL9fA6y16bUeaIwYp4SO2i9l4ZKtjtz9CafJPlHzOIuWE
 XPvowQJBfa22IgcSwCatNsu/XDVRGNr7//QLBGpyxWiru3/ACw38NMbKhYnCnkHVf0aJSdLyGr2
 I8/jLeWBqSuhl3X8h3So5/VkhnKyzjFqp/chXORO1cSkvXJrS/I4w3ooAjVuaj6NSHo3DVuz4EC
 w1XElReSfk+xnHDzPzfZI4B3LMPD56sq2Iv2TihEfR/9ae2kr7zPCQ4VeA29uau2KuXSf0fPXSA
 g7
X-Received: by 2002:a17:906:6a05:b0:c24:c24f:e176 with SMTP id
 a640c23a62f3a-c25d5440617mr177443966b.15.1788340894358; Wed, 02 Sep 2026
 02:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260814-mtk-pwm-disp-backlight-v1-1-847992f0b815@baylibre.com>
In-Reply-To: <20260814-mtk-pwm-disp-backlight-v1-1-847992f0b815@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 2 Sep 2026 11:21:25 +0200
X-Gm-Features: AcwNN1XriLDQd18h8V_om3gADrsFXiUAK9CLXxsSvL-awej69lnOE5I6B-YGoxA
Message-ID: <CAEHHSvYvw3c54QCthkhCuD9Hgo_G-YHHJkvMEA1GxRX=3Z-B4g@mail.gmail.com>
Subject: Re: [PATCH] pwm: add MediaTek display PWM driver
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Le ven. 14 ao=C3=BBt 2026 =C3=A0 21:30, David Lechner <dlechner@baylibre.co=
m> a =C3=A9crit :
>
> Add a new driver for MediaTek display PWM controller. This is generally
> used for backlight control on MediaTek SoCs.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> This driver will be used by MediaTek Genio 360 EVK that we are currently
> working on bringing up.
> ---
>  drivers/pwm/Kconfig        |   8 ++
>  drivers/pwm/Makefile       |   1 +
>  drivers/pwm/pwm-mtk-disp.c | 178 +++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 187 insertions(+)
>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index a69fe37caff..8a2b140fe97 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -74,6 +74,14 @@ config PWM_MTK
>           This PWM is found on MT7622, MT7623, and MT7629. It supports a
>           programmable period and duty cycle.
>
> +config PWM_MTK_DISP
> +       bool "Enable support for MediaTek display PWM"
> +       depends on ARCH_MEDIATEK
> +       help
> +         This PWM is found on the display subsystem of several MediaTek
> +         SoCs (e.g. MT8183, MT8366). It is typically used to drive the
> +         backlight of a display panel.
> +
>  config PWM_ROCKCHIP
>         bool "Enable support for the Rockchip PWM"
>         depends on ARCH_ROCKCHIP
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 2682c536c6f..7c409c3c620 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_PWM_EXYNOS)      +=3D exynos_pwm.o
>  obj-$(CONFIG_PWM_IMX)          +=3D pwm-imx.o
>  obj-$(CONFIG_PWM_MESON)                +=3D pwm-meson.o
>  obj-$(CONFIG_PWM_MTK)          +=3D pwm-mtk.o
> +obj-$(CONFIG_PWM_MTK_DISP)     +=3D pwm-mtk-disp.o
>  obj-$(CONFIG_PWM_ROCKCHIP)     +=3D rk_pwm.o
>  obj-$(CONFIG_PWM_SANDBOX)      +=3D sandbox_pwm.o
>  obj-$(CONFIG_PWM_SIFIVE)       +=3D pwm-sifive.o
> diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
> new file mode 100644
> index 00000000000..540539e6167
> --- /dev/null
> +++ b/drivers/pwm/pwm-mtk-disp.c
> @@ -0,0 +1,178 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * MediaTek display pulse-width-modulation controller driver.
> + *
> + * Copyright (c) 2015 MediaTek Inc.
> + * Copyright (C) 2026 BayLibre, SAS
> + */
> +
> +#include <clk.h>
> +#include <dm.h>
> +#include <pwm.h>
> +#include <asm/io.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/errno.h>
> +#include <linux/time.h>
> +
> +#define DISP_PWM_EN            0x00
> +
> +#define PWM_CLKDIV_MASK                GENMASK(25, 16)
> +
> +#define PWM_PERIOD_BIT_WIDTH   12
> +#define PWM_PERIOD_MASK                GENMASK(PWM_PERIOD_BIT_WIDTH - 1,=
 0)
> +
> +#define PWM_HIGH_WIDTH_MASK    GENMASK(28, 16)
> +
> +struct mtk_disp_pwm_data {
> +       u32 enable_mask;
> +       u32 con0;
> +       u32 con0_sel;
> +       u32 con1;
> +       bool has_commit;
> +       u32 commit;
> +       u32 commit_mask;
> +       u32 bls_debug;
> +       u32 bls_debug_mask;
> +};
> +
> +struct mtk_disp_pwm_priv {
> +       void __iomem *base;
> +       struct clk clk_main;
> +       struct clk clk_mm;
> +       const struct mtk_disp_pwm_data *data;
> +};
> +
> +static void mtk_disp_pwm_update_bits(void __iomem *base, u32 offset, u32=
 mask, u32 data)
> +{
> +       u32 value =3D readl(base + offset);
> +
> +       value &=3D ~mask;
> +       value |=3D data;
> +
> +       writel(value, base + offset);
> +}
> +
> +static void mtk_disp_pwm_set_bits(void __iomem *base, u32 offset, u32 ma=
sk)
> +{
> +       mtk_disp_pwm_update_bits(base, offset, mask, mask);
> +}
> +
> +static void mtk_disp_pwm_clear_bits(void __iomem *base, u32 offset, u32 =
mask)
> +{
> +       mtk_disp_pwm_update_bits(base, offset, mask, 0);
> +}
> +
> +static int mtk_disp_pwm_set_config(struct udevice *dev, u32 channel,
> +                                  u32 period_ns, u32 duty_ns)
> +{
> +       struct mtk_disp_pwm_priv *priv =3D dev_get_priv(dev);
> +       const struct mtk_disp_pwm_data *data =3D priv->data;
> +       u64 rate, div, clk_div, period, high_width;
> +
> +       rate =3D clk_get_rate(&priv->clk_main);
> +
> +       /*
> +        * period_ns =3D 10^9 * (clk_div + 1) * (period + 1) / rate
> +        * duty_ns =3D 10^9 * (clk_div + 1) * high_width / rate
> +        */
> +       clk_div =3D (((u64)period_ns * rate) / NSEC_PER_SEC) >> PWM_PERIO=
D_BIT_WIDTH;
> +       if (!FIELD_FIT(PWM_CLKDIV_MASK, clk_div))
> +               return -EINVAL;
> +
> +       div =3D NSEC_PER_SEC * (clk_div + 1);
> +       period =3D ((u64)period_ns * rate) / div;
> +       if (period > 0)
> +               period--;
> +
> +       high_width =3D ((u64)duty_ns * rate) / div;
> +
> +       if (data->bls_debug && !data->has_commit) {
> +               /* Disable double buffer and select manual mode before wr=
iting */
> +               mtk_disp_pwm_set_bits(priv->base, data->bls_debug, data->=
bls_debug_mask);
> +               mtk_disp_pwm_set_bits(priv->base, data->con0, data->con0_=
sel);
> +       }
> +
> +       mtk_disp_pwm_update_bits(priv->base, data->con0, PWM_CLKDIV_MASK,
> +                                FIELD_PREP(PWM_CLKDIV_MASK, clk_div));
> +       mtk_disp_pwm_update_bits(priv->base, data->con1,
> +                                PWM_PERIOD_MASK | PWM_HIGH_WIDTH_MASK,
> +                                FIELD_PREP(PWM_PERIOD_MASK, period) |
> +                                FIELD_PREP(PWM_HIGH_WIDTH_MASK, high_wid=
th));
> +
> +       if (data->has_commit) {
> +               mtk_disp_pwm_set_bits(priv->base, data->commit, data->com=
mit_mask);
> +               mtk_disp_pwm_clear_bits(priv->base, data->commit, data->c=
ommit_mask);
> +       }
> +
> +       return 0;
> +}
> +
> +static int mtk_disp_pwm_set_enable(struct udevice *dev, u32 channel, boo=
l enable)
> +{
> +       struct mtk_disp_pwm_priv *priv =3D dev_get_priv(dev);
> +
> +       mtk_disp_pwm_update_bits(priv->base, DISP_PWM_EN, priv->data->ena=
ble_mask,
> +                                field_prep(priv->data->enable_mask, enab=
le));
> +
> +       return 0;
> +}
> +
> +static int mtk_disp_pwm_probe(struct udevice *dev)
> +{
> +       struct mtk_disp_pwm_priv *priv =3D dev_get_priv(dev);
> +       int ret;
> +
> +       priv->data =3D (const void *)dev_get_driver_data(dev);
> +
> +       priv->base =3D dev_read_addr_ptr(dev);
> +       if (!priv->base)
> +               return -EINVAL;
> +
> +       ret =3D clk_get_by_name(dev, "main", &priv->clk_main);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D clk_get_by_name(dev, "mm", &priv->clk_mm);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D clk_enable(&priv->clk_main);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D clk_enable(&priv->clk_mm);
> +       if (ret)
> +               return ret;

should we disable clk_main here?

> +
> +       return 0;
> +}
> +
> +static const struct pwm_ops mtk_disp_pwm_ops =3D {
> +       .set_config =3D mtk_disp_pwm_set_config,
> +       .set_enable =3D mtk_disp_pwm_set_enable,
> +};
> +
> +static const struct mtk_disp_pwm_data mt8183_pwm_data =3D {
> +       .enable_mask =3D BIT(0),
> +       .con0 =3D 0x18,
> +       .con0_sel =3D 0x0,
> +       .con1 =3D 0x1c,
> +       .has_commit =3D false,
> +       .bls_debug =3D 0x80,
> +       .bls_debug_mask =3D GENMASK(1, 0),
> +};
> +
> +static const struct udevice_id mtk_disp_pwm_ids[] =3D {
> +       { .compatible =3D "mediatek,mt8183-disp-pwm", .data =3D (ulong)&m=
t8183_pwm_data },
> +       { }
> +};
> +
> +U_BOOT_DRIVER(mtk_disp_pwm) =3D {
> +       .name           =3D "mtk_disp_pwm",
> +       .id             =3D UCLASS_PWM,
> +       .of_match       =3D mtk_disp_pwm_ids,
> +       .ops            =3D &mtk_disp_pwm_ops,
> +       .probe          =3D mtk_disp_pwm_probe,
> +       .priv_auto      =3D sizeof(struct mtk_disp_pwm_priv),
> +};
>
> ---
> base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
> change-id: 20260814-mtk-pwm-disp-backlight-3951aeb966f7
>
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>
>

Except for the error-path unwind of clk_main, which can be fixed while
applying:

Reviewed-by: Julien Stephan <jstephan@baylibre.com>
