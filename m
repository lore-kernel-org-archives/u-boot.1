Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01458C54E49
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 12:52:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C74787EE7;
	Mon, 26 Feb 2024 13:52:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QAPk4UFV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9031087BFD; Mon, 26 Feb 2024 13:52:54 +0100 (CET)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9420E87EED
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 13:52:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-47051c7635dso346216137.1
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 04:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708951969; x=1709556769; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zri7pDB5pfIN/Z5mFLnD5F8Nwk+RPz0wt3KBAqiSRHY=;
 b=QAPk4UFVUwnCnAmfxL13o+AXg3x8EAvH3xDQ4Ozf42PtMU5ftkL2mVDIrjVH9bbmPa
 cwrlPYhEYxjeCseVCV1wF6OPJyvN9xA4PLZBnq+QVBLjV72KQyVJgBrudNC5tSDgA8HO
 emHkFW+rOP0J+S8n/V3KbZ1LPA9IqsEMuu0/P/+9S1poDrdhZgjO75ADwmNWpN+gUW98
 qqdypqxj7/M2l5lMpC5oud7oHmvYA1rd8a+6DIqU9Fwjg/sDYjvKEIj0EtrRA0AblaGw
 PYMGmm22dEq6eO1ira+GXobU+MfrTwubUzN9aySOFbR05Qx9vS6hrVJrhMA+uPjZhqMW
 ER1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708951969; x=1709556769;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zri7pDB5pfIN/Z5mFLnD5F8Nwk+RPz0wt3KBAqiSRHY=;
 b=JbtUEIppXBKExLgez6GYJBoUXJMqzyPYV8Gn0HqhOR7rFQWwlOMGRIzy+AG2JOh5F9
 3JeRbCBpXRtVDuni76y1ZBtIj8+8HGydXdmGHjpMyUAGJQ3AB4ofFmQ4dXWYdENMtitm
 lvBkrhl5qsjXCFR5YKdiQi4PEjfa4lnT/8tUQ6gm0Jd+aKuRdBazaboGYVOqGMcCLy8l
 0Up/0DuzV91smJpdFdFHz5steehwr/lxUxzqzvWq+SqBwmZHfkGWnTPKxsaDybz4MXuX
 IO+oLxkUrDoLa0nvfuz4Ts6Jj70965hQgIK7R3cSpoIi5ixmL26RcWb/Ry6KcV/szsA1
 8Cbg==
X-Gm-Message-State: AOJu0Yy6rmKoDOl6rr/3N0RMI3pWhtHtjs+XrVufhMj3aSNyEqhDnmTi
 0jgU1yzM5CFvVGA8NnZzWv/22n5/m00Z+ZZxqwz8abxnCv2GCH0/Q16Cv35zDGdv5aLLr+MwdWD
 gg6LlEFjB1w+l5Kzz8wHxDFsm+T+5DUgFWYsCSQ==
X-Google-Smtp-Source: AGHT+IHbmyznC+uVzNimWoXzYUkfaQkKnchmC9Yze7+gYhe8lyKMJo9wxHcbyW9ZJLxAzeZgfRJyijMBlz5v3sWNBFk=
X-Received: by 2002:a67:b914:0:b0:471:e1da:ae79 with SMTP id
 q20-20020a67b914000000b00471e1daae79mr2813908vsn.15.1708951969343; Mon, 26
 Feb 2024 04:52:49 -0800 (PST)
MIME-Version: 1.0
References: <20240226080433.3307154-1-sumit.garg@linaro.org>
 <20240226080433.3307154-7-sumit.garg@linaro.org>
 <3f5cf71b-ef9a-4e8b-99c2-cb51d342db7f@denx.de>
In-Reply-To: <3f5cf71b-ef9a-4e8b-99c2-cb51d342db7f@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 26 Feb 2024 18:22:38 +0530
Message-ID: <CAFA6WYOb_DiZoe4v=heUTTj4ku0AO1gndF_rTTSd3NBFfDM3ZA@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] pci: Add DW PCIe controller support for iMX8MP SoC
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
> > pcie_imx doesn't seem to share any useful code for iMX8 SoC and it is
> > tied to quite old port of pcie_designware driver from Linux which
> > suffices only iMX6 specific needs.
>
> It is probably hand-rolled, but it does suck, that's true.
>
> > But currently we have the common DWC specific bits which alligns pretty
> > well with DW PCIe controller on iMX8MP SoC. So lets reuse those common
> > bits instead as a new driver for iMX8 SoCs. It should be fairly easy to
> > add support for other iMX8 variants to this driver.
> >
> > iMX8MP SoC also comes up with standalone PCIe PHY support, so hence we
> > can reuse the generic PHY infrastructure to power on PCIe PHY.
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
> > +             return ret;
> > +     }
> > +
> > +     ret = gpio_request_by_name(dev, "reset-gpio", 0, &priv->reset_gpio,
> > +                                (GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE));
> > +     if (ret) {
> > +             dev_err(dev, "unable to get reset-gpio\n");
> > +             return ret;
> > +     }
> > +
> > +     ret = generic_phy_get_by_name(dev, "pcie-phy", &priv->phy);
> > +     if (ret) {
> > +             dev_err(dev, "failed to get pcie phy\n");
> > +             return ret;
> > +     }
> > +
> > +     gpr = ofnode_by_compatible(ofnode_null(), "fsl,imx8mp-iomuxc-gpr");
> > +     if (ofnode_equal(gpr, ofnode_null())) {
> > +             dev_err(dev, "unable to find GPR node\n");
> > +             return -ENODEV;
> > +     }
>
> You likely need a fail path here too, to undo allocation and co.

Ack.

-Sumit
