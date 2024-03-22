Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA178C47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 04:36:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A52D88154;
	Fri, 22 Mar 2024 05:36:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="z3KF0u+B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 822C588168; Fri, 22 Mar 2024 05:36:22 +0100 (CET)
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com
 [IPv6:2607:f8b0:4864:20::e34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE24C87D9C
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 05:36:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-4765cffb446so622044137.0
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 21:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711082177; x=1711686977; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FkI++2Q9RAERRBsjD+tDb69MCdgucJJaQUIDYCfXtds=;
 b=z3KF0u+B37xj/Z+kMuKLuNcXaV8uyuF+3KK2OumXeT+wc2e2OCiZXo4Yxotxiw741T
 ANRrRq0GilVY1uQzRStE5qxN5AK6g0eAzyeyGel/F75g98HMjAsvcaMG46OkqZxd9n5x
 Q7z631jUkKHJMxk6cwFz5MVGo1W6pOjseC5b7CJvS7+ibgqWdsUXNgw3URjWEFB0FB3z
 opyL8aiaNqRZ/I+8z0BoVNSepB9azs99zwx60Ckq0XAiUcBhAic/SK0dFAl6XbH3jg7K
 YibmpP8R0AGN4ijEeZImgQDVmJLHaaPV1pXflSoqU0tauULvKxmf1LhckLm2idKG52Sj
 2Jdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711082177; x=1711686977;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FkI++2Q9RAERRBsjD+tDb69MCdgucJJaQUIDYCfXtds=;
 b=aFA2DuGYhOSuQ7rvSf6mmDNZbpFAkrTQsljeTROD/GZ1bk8UI/K5eEht4jvK2opDEz
 CTFTTmOCd8J9TUi7+TQWoQL+5Jeedo5C4Fmfy2b0vsI18mqf/3+Aq1JnZba0ciPSsIEz
 +GKO2FvPPOIVlNAE5b5c0FHyVxF9qeZ2bTM6m4gfEMlglr7uT+UIvWZmEX7vOh9uKff8
 gkGJyxxt3jaki3NJWtL24SKZSzwKXx3lfsdUwLCcRQTL7er0qhzSIl+g/izxMswGrCXS
 YtkuSGrFiVStiNVKBSWhQxRV54BrgqO+y2gHIcgvSaOxBR2Q6y6pwk6b/59Sl0F580NA
 0gAg==
X-Gm-Message-State: AOJu0YyGZNfPtMWVcwe0DU4F0M+/LW2J4yDCxqYcVkzS6XveXM4Hnps0
 9qiq/zUWqzlJQP0gwm33Ss2t57xjSD9d5UDY/r9ChmbccWrKulfbL2q6gKakQLEc1dBnzXIRzfl
 S3zOoubOhF+LLhoT/81Y9xf+9iX/fJLWQ7hJuGQ==
X-Google-Smtp-Source: AGHT+IEnNOkxxi88/zPX/jrfBueBkaOvoGkz/sdnKUhems9ZdNW5HcGP6pEjY4TWLFEHMrIvo5lcwmntGTsEXAnUyQY=
X-Received: by 2002:a05:6102:464b:b0:474:a4ab:c851 with SMTP id
 jt11-20020a056102464b00b00474a4abc851mr1449967vsb.26.1711082177573; Thu, 21
 Mar 2024 21:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240312070338.86127-1-sumit.garg@linaro.org>
 <20240312070338.86127-8-sumit.garg@linaro.org>
 <48de4f52-aa8a-414a-9094-ccfee70d55f8@denx.de>
 <CAFA6WYNM_Fg=F3k5fR7Be-xmy1pkcVxhU2sAbe0z4WMqV_8TDA@mail.gmail.com>
 <f29a07bc-9f9b-466f-bc69-f5cf67e949d5@denx.de>
In-Reply-To: <f29a07bc-9f9b-466f-bc69-f5cf67e949d5@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 22 Mar 2024 10:06:06 +0530
Message-ID: <CAFA6WYPGi9CCbAOsidqLiNiR4Rtv07cx6A0bfkwWkWxz=FeR4Q@mail.gmail.com>
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

On Fri, 22 Mar 2024 at 00:47, Marek Vasut <marex@denx.de> wrote:
>
> On 3/21/24 1:40 PM, Sumit Garg wrote:
> > On Thu, 14 Mar 2024 at 09:46, Marek Vasut <marex@denx.de> wrote:
> >>
> >> On 3/12/24 8:03 AM, Sumit Garg wrote:
> >>> Add initial support for i.MX8M{M/P} PCIe PHY. On i.MX8M{M/P} SoCs PCIe
> >>> PHY initialization moved to this standalone PHY driver.
> >>>
> >>> Inspired from counterpart Linux kernel v6.8-rc3 driver:
> >>> drivers/phy/freescale/phy-fsl-imx8m-pcie.c. Use last Linux kernel driver
> >>> reference commit 7559e7572c03 ("phy: Explicitly include correct DT
> >>> includes").
> >>
> >> [...]
> >>
> >>> +static int imx8_pcie_phy_probe(struct udevice *dev)
> >>> +{
> >>> +     struct imx8_pcie_phy *imx8_phy = dev_get_priv(dev);
> >>> +     ofnode gpr;
> >>> +     int ret = 0;
> >>> +
> >>> +     imx8_phy->drvdata = (void *)dev_get_driver_data(dev);
> >>> +     imx8_phy->base = dev_read_addr(dev);
> >>> +     if (!imx8_phy->base)
> >>> +             return -EINVAL;
> >>> +
> >>> +     /* get PHY refclk pad mode */
> >>> +     dev_read_u32(dev, "fsl,refclk-pad-mode", &imx8_phy->refclk_pad_mode);
> >>> +
> >>> +     imx8_phy->tx_deemph_gen1 = dev_read_u32_default(dev,
> >>> +                                                     "fsl,tx-deemph-gen1",
> >>> +                                                     0);
> >>> +     imx8_phy->tx_deemph_gen2 = dev_read_u32_default(dev,
> >>> +                                                     "fsl,tx-deemph-gen2",
> >>> +                                                     0);
> >>> +     imx8_phy->clkreq_unused = dev_read_bool(dev, "fsl,clkreq-unsupported");
> >>> +
> >>> +     /* Grab GPR config register range */
> >>> +     gpr = ofnode_by_compatible(ofnode_null(), imx8_phy->drvdata->gpr);
> >>> +     if (ofnode_equal(gpr, ofnode_null())) {
> >>> +             dev_err(dev, "unable to find GPR node\n");
> >>> +             return -ENODEV;
> >>> +     }
> >>> +
> >>> +     imx8_phy->iomuxc_gpr = syscon_node_to_regmap(gpr);
> >>> +     if (IS_ERR(imx8_phy->iomuxc_gpr)) {
> >>> +             dev_err(dev, "unable to find iomuxc registers\n");
> >>> +             return PTR_ERR(imx8_phy->iomuxc_gpr);
> >>> +     }
> >>
> >> syscon_regmap_lookup_by_compatible() should simplify these two steps ^ .
> >>
> >
> > After a close look, that API isn't supported by U-Boot yet. So I will
> > keep the existing implementation with your review tag. I hope that's
> > fine with you.
>
> Oh, uh, I had a local patch from previous round of PCIe experiments, I
> just sent it out, you are on CC. Can you do a follow up fix once this
> series V4 is in ?

Sure I can do that as a followup once your patch is merged.

-Sumit
