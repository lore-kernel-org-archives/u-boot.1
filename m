Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0228FC5475B
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 06:01:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1958A87DE1;
	Wed, 21 Feb 2024 07:01:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J/4aeHZn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8054F87DF8; Wed, 21 Feb 2024 07:01:32 +0100 (CET)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D1F687DEC
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 07:01:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-7d2e1832d4dso2547540241.2
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 22:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708495274; x=1709100074; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4ADv0vG62IHDdB3wZoAodlVawcOMJHTiZA3a7Xvbrb0=;
 b=J/4aeHZnSntbuqGYEqqtg93dZFvyNpH18RtdGzjS02avdz3Dv66qx6KcqkzjfBOYya
 JEj97nbI4h+sA5QjjyqAxRXM7D0jlq0R95RFK9YxG4tUCfWRI3+kk3fql80fABNghK/3
 jAFaf6RR+CkIwJov4ugBquiX2HC0Q0DMg6H98KoJclc1N23RMOL+uHdaNCxowgJMvzhP
 AaBZomRtbV93LGv9Tab+tWzFjxb1ICOF/xIMfF0pYReXwU3iUNdmCtrrbttyO7NIDjki
 +0V96EMBh4xDRVOhLM8jKsr4vHyZyPOO5ScE49r1N6WTi8DOp9+eePjafZ0iaDBlZtJB
 +FjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708495274; x=1709100074;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4ADv0vG62IHDdB3wZoAodlVawcOMJHTiZA3a7Xvbrb0=;
 b=H3LlJi/fl5rDNEADtbZRixjxuWqIm2YdCx0LSB15iMpb00A1F7uLrPHXsgVjAM4Ppx
 dp+p7FllMkyqgViMxCssx8OsYH6MfZbu4rU7+RjPjLIibW4KOYugKelXt+nn3dSNykRS
 PR4wLI+V4SdlcJRg6NdAtlctFKQ8fhhr+cWE5Z1488UD82e2V6hl9LUaP1uWBdOh4bUK
 jkpkKTJHc/UKuG55S2o6yA8GixTJTQ9CcRjzTALN/VtowvnrTIJyv4Tfq8GGK+xb+0a8
 1AR1OsmzIaBfn1WuBt4HK9LqN7M1lWe1oj1eSomjUomUxIPsMNL4b5EuHVVQEqro5ojy
 DDfw==
X-Gm-Message-State: AOJu0Yw2Pq6mJusogd4KXktYPtdIi/q8vTv1GR5qEyNuuL0M99o8yCJf
 gH2bSOrCn08Jx9BzYZgi61dWHPKtHEcZ8X3JpeocYdUzIxiaDn7Z7hsCKdSYMVWRSw4H7EyS0MS
 vBC5FAYjb6iAX+0nhs9vzBfHOJ0Oj6Bgzec1q7w==
X-Google-Smtp-Source: AGHT+IG29xMVYE/oFdzzNK8W4P2lKeArZhjhuJsJ0P/FtKi7LFST0ggtNqQ3kNzBve3Qbnx0vFi5U371/cZQgqiHPFM=
X-Received: by 2002:a67:f414:0:b0:470:5b9b:8693 with SMTP id
 p20-20020a67f414000000b004705b9b8693mr5685382vsn.6.1708495274255; Tue, 20 Feb
 2024 22:01:14 -0800 (PST)
MIME-Version: 1.0
References: <20240220131056.2962331-1-sumit.garg@linaro.org>
 <20240220131056.2962331-4-sumit.garg@linaro.org>
 <d3bd5acf-ad1e-4a99-b7fc-84fbddf33880@denx.de>
In-Reply-To: <d3bd5acf-ad1e-4a99-b7fc-84fbddf33880@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 21 Feb 2024 11:31:03 +0530
Message-ID: <CAFA6WYP8ks2hsjUSq51T1E7k7bkyDi+AvYeGJu=maNMJgqrQVA@mail.gmail.com>
Subject: Re: [PATCH 3/7] imx8mp: power-domain: Add PCIe support
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
> > Pre-requisite to enable PCIe support on iMX8MP SoC.
>
> This commit message is useless, write a proper one.
>

How about the following?

    Add support for GPCv2 power domains and clock handling
    for PCIe and PCIe PHY. It is required to enable PCIe support
    on the iMX8MP SoC.

> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >   drivers/power/domain/imx8mp-hsiomix.c | 50 +++++++++++++++++++++++++--
> >   1 file changed, 48 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/power/domain/imx8mp-hsiomix.c b/drivers/power/domain/imx8mp-hsiomix.c
> > index e2d772c5ec7..62145e0261b 100644
> > --- a/drivers/power/domain/imx8mp-hsiomix.c
> > +++ b/drivers/power/domain/imx8mp-hsiomix.c
> > @@ -16,14 +16,19 @@
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
> > @@ -43,6 +48,10 @@ static int imx8mp_hsiomix_on(struct power_domain *power_domain)
> >               domain = &priv->pd_usb_phy1;
> >       } else if (power_domain->id == IMX8MP_HSIOBLK_PD_USB_PHY2) {
> >               domain = &priv->pd_usb_phy2;
> > +     } else if (power_domain->id == IMX8MP_HSIOBLK_PD_PCIE) {
> > +             domain = &priv->pd_pcie;
> > +     } else if (power_domain->id == IMX8MP_HSIOBLK_PD_PCIE_PHY) {
> > +             domain = &priv->pd_pcie_phy;
> >       } else {
> >               ret = -EINVAL;
> >               goto err_pd;
> > @@ -54,14 +63,25 @@ static int imx8mp_hsiomix_on(struct power_domain *power_domain)
> >
> >       ret = clk_enable(&priv->clk_usb);
> >       if (ret)
> > -             goto err_clk;
> > +             goto err_clk_usb;
> > +
> > +     ret = clk_enable(&priv->clk_pcie);
> > +     if (ret)
> > +             goto err_clk_pcie;
>
> Does this mean that when USB power domains get enabled, PCIe clock are
> also enabled ? Why ?
>
> What if the PCIe clock enable fails, do USB clock remain enabled ?

Let me gate them behind corresponding power domain IDs.

>
> >       if (power_domain->id == IMX8MP_HSIOBLK_PD_USB)
> >               setbits_le32(priv->base + GPR_REG0, USB_CLOCK_MODULE_EN);
> > +     else if (power_domain->id == IMX8MP_HSIOBLK_PD_PCIE)
> > +             setbits_le32(priv->base + GPR_REG0, PCIE_CLOCK_MODULE_EN);
> > +     else if (power_domain->id == IMX8MP_HSIOBLK_PD_PCIE_PHY)
> > +             setbits_le32(priv->base + GPR_REG0, PCIE_PHY_APB_RST |
> > +                                                 PCIE_PHY_INIT_RST);
>
> Shouldn't the reset bits be cleared here ?
>

Although I can't find their reference in the TRM, as per Linux commit
[1], setting the reset bit is actually deassertion of PCIe PHY reset.
You can think of it like an active low signal.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5506018d3dec41e6678efb92b836586e9ee1d628

-Sumit
