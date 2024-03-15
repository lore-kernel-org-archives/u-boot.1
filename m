Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C2E7C54E58
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 05:38:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9501F87F63;
	Fri, 15 Mar 2024 06:38:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R6rjN+kI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2CC687F63; Fri, 15 Mar 2024 06:38:12 +0100 (CET)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com
 [IPv6:2607:f8b0:4864:20::e32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C68DD87D6B
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 06:38:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-4766537b40fso51732137.2
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 22:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710481087; x=1711085887; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=byB8PIF4NnnvJlcMoiTtrWd3j5lXGfr00fCe0K82Vw0=;
 b=R6rjN+kImxwo4sbtNoFtdeEGQz9/+ssYRfo5eTdbU6QITdFZTOr+en950YhpJi48YE
 s6h55qvYl7Q78QrrGftrDX3h0ouMrjPCGPqlxN0sBc+D/vU/RAF2dh5QnLNQPe3+K77F
 3nRMyp9dyUPokrYW4wpAbR0DEnwbG30Q/sPy22Twdl8Z7cec+DDvp8wBpRlCF4e8jrca
 sJYaID8wNztX6sdYqhgHMy1bj7THbypbR0NwolVz21rSp+n7f+MEFUbzcWz6eOuLhyY1
 w/YtU9HGYJJeJ7woLoQ32izfcS233YB4DnCVI6ftHUwsyBViGyaZa1FpUxMvfrvjXTbc
 RAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710481087; x=1711085887;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=byB8PIF4NnnvJlcMoiTtrWd3j5lXGfr00fCe0K82Vw0=;
 b=O219xZ+a/ctUw0FmWzlnIZ6/baH1CB0MBc407bgB6WKzyvzwiHcB+6r5HqsxThTHpA
 RbcvtDw284PoQEx8G2fMRZy8X2vAd7n6OMbP4gxNiHsaoaw0iBfLUtfrcVJlDI/i9UVr
 ZRPxn5nIZnXnPim1S3jGj2/NF6Z6Dt0DCJsgQw5e+/1VNWduJRkg5FKihbC0FN2QIGLB
 f+b5UMk5TGSKvKU49t9hkL1fHqCpFTYxn/8QE2uPPvDiwovuk6X3TAQq8T4CYrwGh88b
 ygssa/mq6eDjczavuxR++nlz4v5LsWRYQ8PkBPXPQIlW362VjZ/Tes4+gHyMzCZtKmc3
 Oijw==
X-Gm-Message-State: AOJu0YxPBq0sYekVHEhlH39EJ2eYo/8yaeP5jrQ8txCFlRH1TTOfDXJT
 nK5xz3Boh8vuJ3flXLMMNWrrobKneR4PHK0apoX2StoYDhROSY/7LFG1a8WrmX/VhLBB2TIKL7S
 UUrFXCIbevRzsMrz5c3Ai2k0LULW2jushNrWhzA==
X-Google-Smtp-Source: AGHT+IGucICdNIh+DlJ8SM8tE3OnpFSOMwhaXUfX3YYEEYbm5MKifIQ8xhbRIQ8JqWbEaim8LRAMmHwDf4KduJKMko8=
X-Received: by 2002:a67:ead5:0:b0:473:21e6:d14d with SMTP id
 s21-20020a67ead5000000b0047321e6d14dmr4068596vso.5.1710481087545; Thu, 14 Mar
 2024 22:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240312070338.86127-1-sumit.garg@linaro.org>
 <20240312070338.86127-8-sumit.garg@linaro.org>
 <48de4f52-aa8a-414a-9094-ccfee70d55f8@denx.de>
In-Reply-To: <48de4f52-aa8a-414a-9094-ccfee70d55f8@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 15 Mar 2024 11:07:55 +0530
Message-ID: <CAFA6WYMpWEP6D-q=Tk1XqeKuC1gkNpNSP_RWE7_PkD78n=C5UQ@mail.gmail.com>
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

Ack.

> With that fixed:
>
> Reviewed-by: Marek Vasut <marex@denx.de>
>

Thanks.

-Sumit

> [...]
