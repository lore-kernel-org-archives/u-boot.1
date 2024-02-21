Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD4B0C48BF6
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 06:14:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA45E87E2E;
	Wed, 21 Feb 2024 07:14:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WcvmiKv1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 809E687E2E; Wed, 21 Feb 2024 07:14:20 +0100 (CET)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com
 [IPv6:2607:f8b0:4864:20::92d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85AC487DCF
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 07:14:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-7d5c890c67fso3110738241.0
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 22:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708496055; x=1709100855; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XkZIBekAFe+72fHUYyh1I9bvm0QXT1wbt31oo8aBvrs=;
 b=WcvmiKv1pdRtEyzwwb2/bUM/R2qGWkFnnJSulJW+Ha1H2Ebsr6WdxBzokBjSNnU12N
 Rcv/iP3WP50ibafjk5A/gF9+HRF8G5ChDYCdwvIYPCa97q9RJ6uraJIgUjBmNUJoSRN7
 MywfIS3evosUaRSLQiPcLxAyosnJmFtBNeYhR85k/8jL64iLkLTsbwwdP1VxTVirCRMi
 nOPVKauqvPKu7iQzuJ2QS/RjCSSZx9y5WORTgsWoBW2hE7qYee5ASJX7CmFady2xDJIM
 7zvqBbo9J2Pxissyeo1iDJVHfaDjc7aHA1LyU6fqMLqCxSmXluxxDhBSPAnLbosHhhjF
 zepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708496055; x=1709100855;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XkZIBekAFe+72fHUYyh1I9bvm0QXT1wbt31oo8aBvrs=;
 b=pexFmo9/OejP52MR5t0JTCm17NwSqc1INtrYI7TBt7OrVmnTE40bMijxOANNpxQYwv
 oXbBI0EM4A2piwfqrGGljw2EG/zNxhzFhBuHbXlttnHqjFcm9Fq559Kr5Af0qtHBSu+1
 ElFhZytlK/GT/blFgi9EQ24OV7roprUkzVaKZl0ltfORLH6MPNUEsp1pH1gVvZd9f/iz
 hWvOjfsHHqAQqTC66YgBNTZmqvu0AR9ng1Fzis1tuHn0jev32VdWHS2eERzYsieqhAUT
 Pv5pN7+c9xOL2gCLaur+X9CtRdtBs5JVW3/6twfeP1B808aEAZeZqRLycwuiHsHqybUw
 GyKA==
X-Gm-Message-State: AOJu0Yw/jDcBQrgqDfQFzGK5vbKvdY004c7VIq/BtkMRW/VXjhG3TE9W
 emsfzLR8i9AVrrG95L/jH738g6YqQQWmbEATigvdQOsaXUSm6Gdv5DlIjTYNmFtxxrZa6I5ozjC
 1rjbdIufbO5eh5r0ZfCbqjCXUZYOI8tkUF4VSEw==
X-Google-Smtp-Source: AGHT+IESGnVNfNfxONp5M8AKLxIg3h4Cejd2gfulx94OrFoTiCh7Xmt8xUbVOAwRrCMIQw+Zad4hTjUjyldkQL8SMnc=
X-Received: by 2002:a05:6102:ac5:b0:470:5503:c9e4 with SMTP id
 m5-20020a0561020ac500b004705503c9e4mr6852313vsh.26.1708496055234; Tue, 20 Feb
 2024 22:14:15 -0800 (PST)
MIME-Version: 1.0
References: <20240220131056.2962331-1-sumit.garg@linaro.org>
 <20240220131056.2962331-5-sumit.garg@linaro.org>
 <947bbd39-451b-4ce0-86dc-47d95db2885d@denx.de>
In-Reply-To: <947bbd39-451b-4ce0-86dc-47d95db2885d@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 21 Feb 2024 11:44:03 +0530
Message-ID: <CAFA6WYPzNoZBxpX-ywwHsycX1jjKP7s4Kx_y7F8CnnZnr3nT3Q@mail.gmail.com>
Subject: Re: [PATCH 4/7] imx8mp: power-domain: Expose high performance PLL
 clock
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, marcel.ziswiler@toradex.com, trini@konsulko.com, 
 lukma@denx.de, seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de, 
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com, 
 aford173@gmail.com, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org, 
 fathi.boudra@linaro.org, remi.duraffort@linaro.org, 
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

On Tue, 20 Feb 2024 at 21:02, Marek Vasut <marex@denx.de> wrote:
>
> On 2/20/24 14:10, Sumit Garg wrote:
> > PCIe PHY can use it when there is no external refclock provided.
>
> Commit message needs to be fixed.

How about the following?

    Expose high performance PLL clock, so the PCIe PHY can
    use it when there is no external refclock provided.

>
> > +static int hsio_pll_enable(struct udevice *dev)
> > +{
> > +     struct imx8mp_hsiomix_priv *priv = dev_get_priv(dev);
> > +     unsigned long start;
> > +     u32 val;
> > +
> > +     /* Setup HSIO PLL */
> > +     val = readl(priv->base + GPR_REG2);
> > +     val &= ~(P_PLL_MASK | M_PLL_MASK | S_PLL_MASK);
> > +     val |= (FIELD_PREP(P_PLL_MASK, 12) | FIELD_PREP(M_PLL_MASK, 800) |
> > +             FIELD_PREP(S_PLL_MASK, 4));
> > +     writel(val, priv->base + GPR_REG2);
>
> clrsetbits_le32()

Ack

>
> > +     /* de-assert PLL reset */
> > +     setbits_le32(priv->base + GPR_REG3, PLL_RST);
> > +
> > +     /* enable PLL */
> > +     setbits_le32(priv->base + GPR_REG3, PLL_CKE);
> > +
> > +     /* Check if PLL is locked */
> > +     start = get_timer(0);
>
> wait_for_bit() or readl_poll_timeout()

Let me use readl_poll_timeout() instead.

>
> > +     for (;;) {
> > +             if (readl(priv->base + GPR_REG1) & PLL_LOCK)
> > +                     break;
> > +
> > +             if (get_timer(start) > 100) {
> > +                     dev_err(dev, "failed to lock HSIO PLL\n");
> > +                     return -ETIMEDOUT;
> > +             }
> > +
> > +             udelay(10);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void hsio_pll_disable(struct udevice *dev)
> > +{
> > +     struct imx8mp_hsiomix_priv *priv = dev_get_priv(dev);
> > +
> > +     /* de-assert PLL reset */
> > +     clrbits_le32(priv->base + GPR_REG3, PLL_RST);
> > +
> > +     /* enable PLL */
> > +     clrbits_le32(priv->base + GPR_REG3, PLL_CKE);
> > +}
> > +
> >   static int imx8mp_hsiomix_on(struct power_domain *power_domain)
> >   {
> >       struct udevice *dev = power_domain->dev;
> > @@ -69,16 +127,23 @@ static int imx8mp_hsiomix_on(struct power_domain *power_domain)
> >       if (ret)
> >               goto err_clk_pcie;
> >
> > -     if (power_domain->id == IMX8MP_HSIOBLK_PD_USB)
> > +     if (power_domain->id == IMX8MP_HSIOBLK_PD_USB) {
> >               setbits_le32(priv->base + GPR_REG0, USB_CLOCK_MODULE_EN);
> > -     else if (power_domain->id == IMX8MP_HSIOBLK_PD_PCIE)
> > +     } else if (power_domain->id == IMX8MP_HSIOBLK_PD_PCIE) {
> >               setbits_le32(priv->base + GPR_REG0, PCIE_CLOCK_MODULE_EN);
> > -     else if (power_domain->id == IMX8MP_HSIOBLK_PD_PCIE_PHY)
> > +     } else if (power_domain->id == IMX8MP_HSIOBLK_PD_PCIE_PHY) {
> >               setbits_le32(priv->base + GPR_REG0, PCIE_PHY_APB_RST |
> >                                                   PCIE_PHY_INIT_RST);
> >
> > +             ret = hsio_pll_enable(dev);
>
> Is this how Linux handles this PLL ?
>
> Seems like this should be either syscon or clock driver .

It isn't similar to what Linux does but I can't find suitable
infrastructure in U-Boot to expose it as a regular clock. Are there
any APIs available similar to devm_of_clk_add_hw_provider() in Linux?

-Sumit

>
> [...]
