Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18978C54E66
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 05:39:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9659987FC2;
	Fri, 15 Mar 2024 06:39:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Lm68CIzt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BCCF87FC9; Fri, 15 Mar 2024 06:39:44 +0100 (CET)
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com
 [IPv6:2607:f8b0:4864:20::e2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D31C87FC0
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 06:39:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-4765792fc76so353049137.3
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 22:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710481179; x=1711085979; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hdQM2jfW8cLSOK8qVKGUcyDPjI2pHpemnxocOdeXULQ=;
 b=Lm68CIzt1OfK/EUZyI6IYMaolPaF4FZ2ZWbTQPamzVhPJ9aP2WH/zds8Kl1b/0f+LT
 /kTojaGI8n/qJeZMZ2A9fy60zHauBHuTm6hNG38IZz7NPDlRLOKSUKSxol80JNcvNIzk
 viIckYd3SqLQG932P6biLZfE4R+SRLFILjsMx7Tx64jVVFht3WiZA/rgeqXO8MmHdLiU
 +lQVF+LORNztk1+nXbO3PuG6g1AXSm4Rm1zZx8q1mvkjemxYbCjdJaXZ/xxumDGE77Mm
 x+Fcsf6XTD9ck15SJXOYgVcI9/jIc+qmneLAtds53na9MoJ09gZZNGYUEHFR0+p2vHp7
 a0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710481179; x=1711085979;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hdQM2jfW8cLSOK8qVKGUcyDPjI2pHpemnxocOdeXULQ=;
 b=DyxuvC759XD5kC9krmj3XSJBSF8qWu5MhVWvNVaMs4VteaQwzW7UdUXRiA6x/uLn3m
 fLZkWWvfjV7MMBBEy5WGSQu1kDWUqFDHHsb+WqX7khLDp5MTS0k0uA6XkDU4jrwOqysA
 hz+HfRFPFH3Y6sX4129/EDCiJ552MJuM5KHdGDAj3NSbmRyEZKT1geN/Qj5wT3S0BvyZ
 jAm5O/GAIELGMJ6lMLJzDHJ+tOHUztV5jGbxyP6+C9d27kaOgZ8/byfJ4h5dRh7oNhfL
 V4PFRpGjQxIgFLTPtnNhUk91qOJMLZL+qszdxlVE9TIZdq83NokxYi8qLhdIYisxQJdJ
 +lFA==
X-Gm-Message-State: AOJu0YyMqn7k1R3a2J2ZseZa82VhUkELmgCF+upUn1xkXK6iggD7FbKh
 w+GXjw1gV7WJukVZ3uB8kROHKlIdFaUbamynscpjrXbmPLcTBOYZVvq6B9pL4tkbZZN75Rlqgih
 UQ4UHQmPXuCoVkwS+Vu9x8uMPE8Z13bV/0lwjwQ==
X-Google-Smtp-Source: AGHT+IFpwoLIDCntW9umElnKYVeP8RpK2L/zUrhtTwTmOv4TnV2212V8rAXtZfPR3D765F7BUBtoHK0etjc/6+iBBGY=
X-Received: by 2002:a05:6102:3706:b0:476:4214:f90e with SMTP id
 s6-20020a056102370600b004764214f90emr4351403vst.1.1710481179149; Thu, 14 Mar
 2024 22:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240312070338.86127-1-sumit.garg@linaro.org>
 <20240312070338.86127-9-sumit.garg@linaro.org>
 <f3e37ebd-5740-4c8f-875d-4ab2d37411fd@denx.de>
In-Reply-To: <f3e37ebd-5740-4c8f-875d-4ab2d37411fd@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 15 Mar 2024 11:09:27 +0530
Message-ID: <CAFA6WYMVta4uvh=Yk_hALX_p5bOo1CjjTzRitRhueT6a4z4-qg@mail.gmail.com>
Subject: Re: [PATCH v3 08/11] pci: Add DW PCIe controller support for iMX8MP
 SoC
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, trini@konsulko.com, tharvey@gateworks.com, 
 marcel.ziswiler@toradex.com, francesco@dolcini.it, lukma@denx.de, 
 seanga2@gmail.com, jh80.chung@samsung.com, sjg@chromium.org, festevam@denx.de, 
 andrejs.cainikovs@toradex.com, peng.fan@nxp.com, aford173@gmail.com, 
 ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org, fathi.boudra@linaro.org, 
 remi.duraffort@linaro.org, daniel.thompson@linaro.org
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

On Thu, 14 Mar 2024 at 09:45, Marek Vasut <marex@denx.de> wrote:
>
> On 3/12/24 8:03 AM, Sumit Garg wrote:
> > pcie_imx doesn't seem to share any useful code for iMX8 SoC and it is
> > tied to quite old port of pcie_designware driver from Linux which
> > suffices only iMX6 specific needs.
> >
> > But currently we have the common DWC specific bits which alligns pretty
> > well with DW PCIe controller on iMX8MP SoC. So lets reuse those common
> > bits instead as a new driver for iMX8 SoCs. It should be fairly easy to
> > add support for other iMX8 variants to this driver.
> >
> > iMX8MP SoC also comes up with standalone PCIe PHY support, so hence we
> > can reuse the generic PHY infrastructure to power on PCIe PHY.
> >
> > Tested-by: Tim Harvey <tharvey@gateworks.com> #imx8mp-venice*
> > Tested-by: Adam Ford <aford173@gmail.com> #imx8mp-beacon-kit
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>
> [...]
>
> > +static int pcie_dw_imx_of_to_plat(struct udevice *dev)
> > +{
> > +     struct pcie_dw_imx *priv = dev_get_priv(dev);
> > +     ofnode gpr;
> > +     int ret;
> > +
> > +     /* Get the controller base address */
> > +     priv->dw.dbi_base = (void *)dev_read_addr_name(dev, "dbi");
> > +     if ((fdt_addr_t)priv->dw.dbi_base == FDT_ADDR_T_NONE) {
> > +             dev_err(dev, "failed to get dbi_base address\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* Get the config space base address and size */
> > +     priv->dw.cfg_base = (void *)dev_read_addr_size_name(dev, "config",
> > +                                                         &priv->dw.cfg_size);
> > +     if ((fdt_addr_t)priv->dw.cfg_base == FDT_ADDR_T_NONE) {
> > +             dev_err(dev, "failed to get cfg_base address\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     ret = clk_get_bulk(dev, &priv->clks);
> > +     if (ret) {
> > +             dev_err(dev, "failed to get PCIe clks\n");
> > +             return ret;
> > +     }
> > +
> > +     ret = reset_get_by_name(dev, "apps", &priv->apps_reset);
> > +     if (ret) {
> > +             dev_err(dev,
> > +                     "Failed to get PCIe apps reset control\n");
> > +             goto err_reset;
> > +     }
> > +
> > +     ret = gpio_request_by_name(dev, "reset-gpio", 0, &priv->reset_gpio,
> > +                                (GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE));
>
> The extra parenthesis () is not needed.
>

Ack.

> With that fixed:
>
> Reviewed-by: Marek Vasut <marex@denx.de>

Thanks.

-Sumit
