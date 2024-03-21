Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E98C54E58
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 12:41:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CAF087E8E;
	Thu, 21 Mar 2024 13:41:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ecpUr9LD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EDC788013; Thu, 21 Mar 2024 13:41:07 +0100 (CET)
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com
 [IPv6:2607:f8b0:4864:20::933])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32F1087E8E
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 13:41:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-7e045d2cdeeso342834241.1
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 05:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711024864; x=1711629664; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uSjIQBrykJ8wSgux+HrxOJPhnEsy/7ANE+i3Qj1N4E0=;
 b=ecpUr9LDeo4c4o5kBN5YxhtX3++Z0iOXH2fxeaFkWZEvOrrLH0ktNfy4av+2HbkeEY
 HFUBFOSI3XsPwc2nIWvDcNOKSuTFIiDIbAaV31EmsFVtp2F/Low39P2hyh6S1N3PP9vW
 XKMwLod1Vgp+VVsSsPe5lkyJwZ3YDocQ8tIZpf0W/DuMovRYJfq30em0j+Y0ePJzgexO
 900Wl9wCGF0j9MXrvxQvh+VtCc/jkUSxtN1tNvJHq1Raf8McQqfaJGt0HiiCNDiKhwEl
 TTgZYtT3uhhGTfZRTZ0Wt0cG/YM/nqBC+54vWpPtTMwFOe5awqKMy8nNbziSJsM0FtXL
 3sFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711024864; x=1711629664;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uSjIQBrykJ8wSgux+HrxOJPhnEsy/7ANE+i3Qj1N4E0=;
 b=d4tVJMAn8uK9fvldGm6Szxl93GHDmkqrFBFzllpN1DbpGvIwdafbWqIqmYc3uFj9kA
 8Tkuq7uDS8VrdCIAyydBzahCFgwW/pGjWZ9Pr9MQKmU+X3Wu9AhBpFWejaNQs8KsDvm2
 zP8JW1vN1Gyl5aPzRTdSAo3cN6E/FaKZzTrBN5P/2ALKcH0R3qK0ZzLh6Ih/eulY1ZiU
 KdUu+B0wIufw603afnGoez0AjHxP4h0K4QcBUo8eG4V4QdcZ8DuKTPPSZk1YWDpRmTWe
 Zj6bgllmrULy+5JAag9+rnpcXN47kY64w6RZl/ASZzf1M5JM8RyM/0Ai7j+tJaPxUbmY
 6CPA==
X-Gm-Message-State: AOJu0Yw9+fvV+lDfblrVb6Hl0a8Azj3CGGwOATzjEblrMmS8HUrq+rtt
 I356cBMw9asviAgwUNuPhDi5PIzr9VjCIW9RCng9IOXU/DmA9WpzsEsHP7SOBty3AVeAoA6m9Bq
 fVNRuxn4qP90wNCq1wkWbyJm5n8DfrrCisXdVIw==
X-Google-Smtp-Source: AGHT+IGkdP0tA3HGnE8fCUu0Xj/JXCIMEG4KE1XlC5+D+wug1KMq7j+hiXBbUVspv7N0DEtvP5eBe9a25sF62wNLcLU=
X-Received: by 2002:a67:f2d3:0:b0:472:af6c:3f64 with SMTP id
 a19-20020a67f2d3000000b00472af6c3f64mr1449376vsn.18.1711024863968; Thu, 21
 Mar 2024 05:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240312070338.86127-1-sumit.garg@linaro.org>
 <20240312070338.86127-8-sumit.garg@linaro.org>
 <48de4f52-aa8a-414a-9094-ccfee70d55f8@denx.de>
In-Reply-To: <48de4f52-aa8a-414a-9094-ccfee70d55f8@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 21 Mar 2024 18:10:52 +0530
Message-ID: <CAFA6WYNM_Fg=F3k5fR7Be-xmy1pkcVxhU2sAbe0z4WMqV_8TDA@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] phy: phy-imx8m-pcie: Add support for i.MX8M{M/P}
 PCIe PHY
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

On Thu, 14 Mar 2024 at 09:46, Marek Vasut <marex@denx.de> wrote:
>
> On 3/12/24 8:03 AM, Sumit Garg wrote:
> > Add initial support for i.MX8M{M/P} PCIe PHY. On i.MX8M{M/P} SoCs PCIe
> > PHY initialization moved to this standalone PHY driver.
> >
> > Inspired from counterpart Linux kernel v6.8-rc3 driver:
> > drivers/phy/freescale/phy-fsl-imx8m-pcie.c. Use last Linux kernel driver
> > reference commit 7559e7572c03 ("phy: Explicitly include correct DT
> > includes").
>
> [...]
>
> > +static int imx8_pcie_phy_probe(struct udevice *dev)
> > +{
> > +     struct imx8_pcie_phy *imx8_phy = dev_get_priv(dev);
> > +     ofnode gpr;
> > +     int ret = 0;
> > +
> > +     imx8_phy->drvdata = (void *)dev_get_driver_data(dev);
> > +     imx8_phy->base = dev_read_addr(dev);
> > +     if (!imx8_phy->base)
> > +             return -EINVAL;
> > +
> > +     /* get PHY refclk pad mode */
> > +     dev_read_u32(dev, "fsl,refclk-pad-mode", &imx8_phy->refclk_pad_mode);
> > +
> > +     imx8_phy->tx_deemph_gen1 = dev_read_u32_default(dev,
> > +                                                     "fsl,tx-deemph-gen1",
> > +                                                     0);
> > +     imx8_phy->tx_deemph_gen2 = dev_read_u32_default(dev,
> > +                                                     "fsl,tx-deemph-gen2",
> > +                                                     0);
> > +     imx8_phy->clkreq_unused = dev_read_bool(dev, "fsl,clkreq-unsupported");
> > +
> > +     /* Grab GPR config register range */
> > +     gpr = ofnode_by_compatible(ofnode_null(), imx8_phy->drvdata->gpr);
> > +     if (ofnode_equal(gpr, ofnode_null())) {
> > +             dev_err(dev, "unable to find GPR node\n");
> > +             return -ENODEV;
> > +     }
> > +
> > +     imx8_phy->iomuxc_gpr = syscon_node_to_regmap(gpr);
> > +     if (IS_ERR(imx8_phy->iomuxc_gpr)) {
> > +             dev_err(dev, "unable to find iomuxc registers\n");
> > +             return PTR_ERR(imx8_phy->iomuxc_gpr);
> > +     }
>
> syscon_regmap_lookup_by_compatible() should simplify these two steps ^ .
>

After a close look, that API isn't supported by U-Boot yet. So I will
keep the existing implementation with your review tag. I hope that's
fine with you.

-Sumit

> With that fixed:
>
> Reviewed-by: Marek Vasut <marex@denx.de>
>
> [...]
