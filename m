Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E79C54E49
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 11:46:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0573B87EB5;
	Mon, 26 Feb 2024 12:46:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SUUvE1y+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B7AE863D3; Mon, 26 Feb 2024 12:46:36 +0100 (CET)
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com
 [IPv6:2607:f8b0:4864:20::92b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6072887EB5
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 12:46:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-7da6e831958so379944241.0
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 03:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708947990; x=1709552790; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tmKksEZLdH7bBoQbtGqh5NsyAOhUn7vQ8xY0GTgrvC0=;
 b=SUUvE1y+F8jYrXW4177aU1ar8KLUMkYQ85zNkpuWZaH2bNJNtZNrFN4CvBMPTFQIn/
 cqqKIq8JcYDg1vP2VD828dh5TIO+4D0DBhmFv/lRfv2mhLMoRp0gNbBH5aJ95Z3Kdqdz
 HgC9mEp81PLrRBsT9Ba66FIIjhKGZVNVa8sh9zK9XPZNRIcnAFpZQXvzfoh9bipV9iVA
 JiuU1WGm5nlb3YKZo9T/izBA2LdbJHdBwk/hj0E3eid0ElSPyG+FpNtfS1DYaKruI1pg
 qZUgtuYPpAYB3T+FV/U8Iyu/1rsSqXrkMy8Co0w7CJ0hZj9sE+6kFJ6FGY/YaN5kGRQc
 4CuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708947990; x=1709552790;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tmKksEZLdH7bBoQbtGqh5NsyAOhUn7vQ8xY0GTgrvC0=;
 b=IZ4VlAHuQ8EjAjecIVQp6H1N/Ly+egRhVgEK2X6lVFN10QJTNOHBgfKUrSV118YMB6
 bexBUvnZgGcA4DxX7R1oyvXP/6r/bqfKT9KmKl3Gyde9BYEmxSIEZAAN63SterT1AsHC
 a4mnl22t6UfQR8TIESi5tsy/CfqgY5h7dk50EEylLjnrkze2GgDN+ZjPvGRCRHGk0Y1/
 l9k2WscmvWlxRsxtYfknukwA/d4vnKkqPCNafs3oaZzk7LcD9MDB7fDUTghWyyNcypM5
 mt16h9MbGMs87DofywXQ3RTcUqiYYmrud34dtt43ydxcBkKBSSlfb+l3HOQHGABf/GCW
 QPww==
X-Gm-Message-State: AOJu0Yzes1GX8QkejX07Q85X0+WB7+IodrPKtUvzFOWTr2+82XuH15H6
 z0ceqhI1ZQWlwiQWiN5ibm3el00BuxngZWktaO0ssYrpwDnOUYFUkqTkFFtOodqLwUQ9YLydpBy
 QtIK8eT0CgW10fUOjohCj40AVnjL+VMNE8XUqgw==
X-Google-Smtp-Source: AGHT+IH4fIu7TEcYUXZEu+VQEapnCzciHKvt557f0nFujXYfWjQrh7fEipKnoC85H2WHOUJLwFinccSuZ1JtC0s/ny8=
X-Received: by 2002:a05:6102:3082:b0:470:3a99:f3c with SMTP id
 l2-20020a056102308200b004703a990f3cmr3395426vsb.23.1708947989999; Mon, 26 Feb
 2024 03:46:29 -0800 (PST)
MIME-Version: 1.0
References: <20240226080433.3307154-1-sumit.garg@linaro.org>
 <20240226080433.3307154-4-sumit.garg@linaro.org>
 <73e06c3c-ac55-4fa1-923d-add85eb96505@denx.de>
In-Reply-To: <73e06c3c-ac55-4fa1-923d-add85eb96505@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 26 Feb 2024 17:16:18 +0530
Message-ID: <CAFA6WYNJHnMHrkXUmOpXGTyGXPxqxwE0oQdmFUaC7yWGwnoHiQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] imx8mp: power-domain: Add PCIe support
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, marcel.ziswiler@toradex.com, francesco@dolcini.it, 
 trini@konsulko.com, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, 
 festevam@denx.de, andrejs.cainikovs@toradex.com, sjg@chromium.org, 
 peng.fan@nxp.com, aford173@gmail.com, ilias.apalodimas@linaro.org, 
 sahaj.sarup@linaro.org, fathi.boudra@linaro.org, remi.duraffort@linaro.org, 
 daniel.thompson@linaro.org
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

On Mon, 26 Feb 2024 at 14:24, Marek Vasut <marex@denx.de> wrote:
>
> On 2/26/24 9:04 AM, Sumit Garg wrote:
> > Add support for GPCv2 power domains and clock handling for PCIe and
> > PCIe PHY.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >   drivers/power/domain/imx8mp-hsiomix.c | 101 ++++++++++++++++++++------
> >   1 file changed, 78 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/power/domain/imx8mp-hsiomix.c b/drivers/power/domain/imx8mp-hsiomix.c
> > index e2d772c5ec78..58cc3f63bb56 100644
> > --- a/drivers/power/domain/imx8mp-hsiomix.c
> > +++ b/drivers/power/domain/imx8mp-hsiomix.c
> > @@ -16,48 +16,73 @@
> >   #define GPR_REG0            0x0
> >   #define  PCIE_CLOCK_MODULE_EN       BIT(0)
> >   #define  USB_CLOCK_MODULE_EN        BIT(1)
> > +#define  PCIE_PHY_APB_RST    BIT(4)
> > +#define  PCIE_PHY_INIT_RST   BIT(5)
> >
> >   struct imx8mp_hsiomix_priv {
> >       void __iomem *base;
> >       struct clk clk_usb;
> > +     struct clk clk_pcie;
> >       struct power_domain pd_bus;
> >       struct power_domain pd_usb;
> > +     struct power_domain pd_pcie;
> >       struct power_domain pd_usb_phy1;
> >       struct power_domain pd_usb_phy2;
> > +     struct power_domain pd_pcie_phy;
> >   };
> >
> >   static int imx8mp_hsiomix_on(struct power_domain *power_domain)
> >   {
> >       struct udevice *dev = power_domain->dev;
> >       struct imx8mp_hsiomix_priv *priv = dev_get_priv(dev);
> > -     struct power_domain *domain;
> > +     struct power_domain *domain = NULL;
> > +     struct clk *clk = NULL;
> > +     u32 gpr_reg0_bits = 0;
> >       int ret;
> >
> > -     ret = power_domain_on(&priv->pd_bus);
> > -     if (ret)
> > -             return ret;
> > -
> > -     if (power_domain->id == IMX8MP_HSIOBLK_PD_USB) {
> > +     switch (power_domain->id) {
> > +     case IMX8MP_HSIOBLK_PD_USB:
> >               domain = &priv->pd_usb;
> > -     } else if (power_domain->id == IMX8MP_HSIOBLK_PD_USB_PHY1) {
> > +             clk = &priv->clk_usb;
> > +             gpr_reg0_bits |= USB_CLOCK_MODULE_EN;
> > +             break;
> > +     case IMX8MP_HSIOBLK_PD_USB_PHY1:
> >               domain = &priv->pd_usb_phy1;
> > -     } else if (power_domain->id == IMX8MP_HSIOBLK_PD_USB_PHY2) {
> > +             break;
> > +     case IMX8MP_HSIOBLK_PD_USB_PHY2:
> >               domain = &priv->pd_usb_phy2;
> > -     } else {
> > -             ret = -EINVAL;
> > -             goto err_pd;
> > +             break;
> > +     case IMX8MP_HSIOBLK_PD_PCIE:
> > +             domain = &priv->pd_pcie;
> > +             clk = &priv->clk_pcie;
> > +             gpr_reg0_bits |= PCIE_CLOCK_MODULE_EN;
> > +             break;
> > +     case IMX8MP_HSIOBLK_PD_PCIE_PHY:
> > +             domain = &priv->pd_pcie_phy;
> > +             /* Bits to deassert PCIe PHY reset */
> > +             gpr_reg0_bits |= PCIE_PHY_APB_RST | PCIE_PHY_INIT_RST;
> > +             break;
> > +     default:
> > +             dev_err(dev, "unknown power domain id: %ld\n",
> > +                     power_domain->id);
> > +             return -EINVAL;
> >       }
> >
> > +     ret = power_domain_on(&priv->pd_bus);
> > +     if (ret)
> > +             return ret;
> > +
> >       ret = power_domain_on(domain);
> >       if (ret)
> >               goto err_pd;
> >
> > -     ret = clk_enable(&priv->clk_usb);
> > -     if (ret)
> > -             goto err_clk;
> > +     if (clk) {
> > +             ret = clk_enable(clk);
> > +             if (ret)
> > +                     goto err_clk;
> > +     }
> >
> > -     if (power_domain->id == IMX8MP_HSIOBLK_PD_USB)
> > -             setbits_le32(priv->base + GPR_REG0, USB_CLOCK_MODULE_EN);
> > +     setbits_le32(priv->base + GPR_REG0, gpr_reg0_bits);
>
> Are you sure it is OK to do this unconditionally ?
>

Although setbits_le32(addr, 0) should be a nop but...

> Why not this:
>
> if (gpr_reg0_bits)
>    setbits_le32(priv->base + GPR_REG0, gpr_reg0_bits);
>

...if we can avoid that then it's better. I will make it conditional.

> >       return 0;
> >
> > @@ -73,17 +98,31 @@ static int imx8mp_hsiomix_off(struct power_domain *power_domain)
> >       struct udevice *dev = power_domain->dev;
> >       struct imx8mp_hsiomix_priv *priv = dev_get_priv(dev);
> >
> > -     if (power_domain->id == IMX8MP_HSIOBLK_PD_USB)
> > +     switch (power_domain->id) {
> > +     case IMX8MP_HSIOBLK_PD_USB:
> >               clrbits_le32(priv->base + GPR_REG0, USB_CLOCK_MODULE_EN);
> > -
> > -     clk_disable(&priv->clk_usb);
> > -
> > -     if (power_domain->id == IMX8MP_HSIOBLK_PD_USB)
> > +             clk_disable(&priv->clk_usb);
> >               power_domain_off(&priv->pd_usb);
> > -     else if (power_domain->id == IMX8MP_HSIOBLK_PD_USB_PHY1)
> > +             break;
> > +     case IMX8MP_HSIOBLK_PD_USB_PHY1:
> >               power_domain_off(&priv->pd_usb_phy1);
> > -     else if (power_domain->id == IMX8MP_HSIOBLK_PD_USB_PHY2)
> > +             break;
> > +     case IMX8MP_HSIOBLK_PD_USB_PHY2:
> >               power_domain_off(&priv->pd_usb_phy2);
> > +             break;
> > +     case IMX8MP_HSIOBLK_PD_PCIE:
>
> Maybe we need some function ... imx8mp_hsiomix_id_to_pd() to avoid this
> duplicate switch statement:
>
> pd = imx8mp_hsiomix_id_to_pd(...)
> ...
> power_domain_off(fd);

But still we need another switch case for clocks and GPR_REG0 bits to
be configured.

>
> > +             clrbits_le32(priv->base + GPR_REG0, PCIE_CLOCK_MODULE_EN);
> > +             clk_disable(&priv->clk_pcie);
> > +             power_domain_off(&priv->pd_pcie);
> > +             break;
> > +     case IMX8MP_HSIOBLK_PD_PCIE_PHY:
> > +             clrbits_le32(priv->base + GPR_REG0, PCIE_PHY_APB_RST |
> > +                                                 PCIE_PHY_INIT_RST);
> > +             power_domain_off(&priv->pd_pcie_phy);
>
> Is it OK to turn off the bus PD after this ?
> Please double-check if power_domain_on/off() is refcounted .

I can't see refcounting being implemented in imx8m-power-domain.c.
This seems to be an existing issue with USB support too.

>
> > +             break;
> > +     default:
> > +             break;
> > +     }
> >
> >       power_domain_off(&priv->pd_bus);

I suppose we should just be fine to drop bus PD off from here.

> >
> > @@ -109,6 +148,10 @@ static int imx8mp_hsiomix_probe(struct udevice *dev)
> >       if (ret < 0)
> >               return ret;
> >
> > +     ret = clk_get_by_name(dev, "pcie", &priv->clk_pcie);
> > +     if (ret < 0)
> > +             return ret;
> > +
> >       ret = power_domain_get_by_name(dev, &priv->pd_bus, "bus");
> >       if (ret < 0)
> >               return ret;
>
> Some clk_put() seems to be missing for clk_pcie .

I can't see clk_put() as any generic API. However, there used to be
clk_free() which was dropped by this commit [1].

[1] https://source.denx.de/u-boot/u-boot/-/commit/c9309f40a6831b1ac5cd0a7227b5c3717d34c812

-Sumit
