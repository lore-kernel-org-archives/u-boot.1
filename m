Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93705C54E49
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 12:51:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF20A87E89;
	Mon, 26 Feb 2024 13:51:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qSYmTg5Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 580BF87BFD; Mon, 26 Feb 2024 13:51:12 +0100 (CET)
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com
 [IPv6:2607:f8b0:4864:20::933])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA20B87EC4
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 13:51:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-7d643a40a91so1791725241.0
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 04:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708951866; x=1709556666; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ef0E9+CQC4iWH9XxWD3PVAAN4B7aBuU//P4TbL8TXLA=;
 b=qSYmTg5QSIyuvMti93GEDGleVHP5X7+ma3GNCWHEw5I7lSOV7buF/MdeS4Ya1vwLjs
 Jq0Dhk3d0qcD+E7PQxXj8ilChA0fbRq75FVfaaiEKtGRkxfxjcHaYBgiy5r8MIrcovBe
 ZSsKorcS9Fsl237aDtLIPx8wrAOzNOZ59BUF7BxV91g//IogwOTG8lsYhou7VcOLA0XK
 i1NK5qwACxI7aa1pN9+/aHFT/HTtD7gAwdoji7yrpfNuh1OYW8H/BtMebUI0eKX8RR7e
 QMWXu/eVYAwjQROETK2OAd4X4LhZMJsZ9jMuKituVJPBcWU/KN7chu/jdknQ6T21SctM
 ykWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708951866; x=1709556666;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ef0E9+CQC4iWH9XxWD3PVAAN4B7aBuU//P4TbL8TXLA=;
 b=C/IrX3sXBv159g6JhDvBnvR+RBqOBzG3e+X8rqlKIz72QDEEzrC31jIn52yNF+S/8G
 Dln0OMD8k7EI6Y42EAGCAL8tMSAcNC32hK2G4tLRkU+D4AZ6sFSFi6RBOcAu3xmisMR0
 Ht8R1AtuZJMLuazGjcZbL53/DPr0wc+PVehrEK8WWXZ0qBG6RBsxupo/riYP3l59wwMW
 3sBI/TG8/l0JRWS+h74rWEWIxoCDRlzuh2kiizo2LSCxiEVyX4wr+bzOe4eeOZuZPwW/
 Rqx6U0IJ838yhogWG4fmYkDEZojIA/91rj14mhamB+tyK8kD8hrtoR6NyyoBc59EdKpQ
 YRNA==
X-Gm-Message-State: AOJu0YxbTG0zMzUsgCgiWCzb2+0dqtf8RlLPCy1CIDxauflAvAUaMWSX
 daJVuN2g9oJ+BTk9IWudsPhSvFHHtg+HPexXdc3E2N65zTs389lCiu2r8g8+iUI74765RRk6l0s
 3cKjbob3p/GqGt8Q3M/X/Z42lcuLJeIS4AuMWbw==
X-Google-Smtp-Source: AGHT+IGOZz/MYMyRoBLgFCblc62jyHyZCpbpUYXmUCnxd/vCOsSbTLHiib/Y5/AGMsBWdIsJ9eTzcLvoh+2HvFurWL8=
X-Received: by 2002:a05:6102:dcd:b0:472:4b21:207e with SMTP id
 e13-20020a0561020dcd00b004724b21207emr247017vst.30.1708951866694; Mon, 26 Feb
 2024 04:51:06 -0800 (PST)
MIME-Version: 1.0
References: <20240226080433.3307154-1-sumit.garg@linaro.org>
 <20240226080433.3307154-6-sumit.garg@linaro.org>
 <609581c7-d221-4eff-862b-6f172ba9d4e8@denx.de>
In-Reply-To: <609581c7-d221-4eff-862b-6f172ba9d4e8@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 26 Feb 2024 18:20:55 +0530
Message-ID: <CAFA6WYPdqsD7Xy1EwX7R_+A3UiskvxaTyvR6D9qP45WhUxxA6A@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] phy: phy-imx8m-pcie: Add support for i.MX8M{M/P}
 PCIe PHY
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
> > Add initial support for i.MX8M{M/P} PCIe PHY. On i.MX8M{M/P} SoCs PCIe
> > PHY initialization moved to this standalone PHY driver.
> >
> > Inspired from counterpart Linux kernel v6.8-rc3 driver:
> > drivers/phy/freescale/phy-fsl-imx8m-pcie.c.
>
> Commit ID , see previous comments.
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
> > +     if (dev_read_u32(dev, "fsl,tx-deemph-gen1", &imx8_phy->tx_deemph_gen1))
> > +             imx8_phy->tx_deemph_gen1 = 0;
>
> Use dev_read_u32_default() and you won't need the if (...)
>

Ack.

> > +     if (dev_read_u32(dev, "fsl,tx-deemph-gen2", &imx8_phy->tx_deemph_gen2))
> > +             imx8_phy->tx_deemph_gen2 = 0;
> > +
> > +     if (dev_read_bool(dev, "fsl,clkreq-unsupported"))
> > +             imx8_phy->clkreq_unused = true;
> > +     else
> > +             imx8_phy->clkreq_unused = false;
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
> > +
> > +     ret = clk_get_by_name(dev, "ref", &imx8_phy->hsio_clk);
> > +     if (ret) {
> > +             dev_err(dev, "Failed to get PCIEPHY ref clock\n");
> > +             return ret;
> > +     }
> > +
> > +     ret = reset_get_by_name(dev, "pciephy", &imx8_phy->reset);
> > +     if (ret) {
> > +             dev_err(dev, "Failed to get PCIEPHY reset control\n");
> > +             return ret;
> > +     }
>
> Some clk_put() and co. fail path is missing here.

Ditto for clk_put() not being available. However, I can add the fail
path for the other reset.

> Also .remove is missing .

Sure, I will add that to release resets.

-Sumit
