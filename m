Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DFA4E77180
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 10:15:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81DA789327;
	Mon,  9 Dec 2024 11:15:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HCi96r2T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41ADA8960F; Mon,  9 Dec 2024 11:15:36 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE11D892A4
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 11:15:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aa5f1909d6fso790039966b.3
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 02:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733739333; x=1734344133; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=su/x2AeB9A+MWsmpW5mJDB2NEVa6nTYASJGxM3NHowo=;
 b=HCi96r2TalcYp99HsHc03V6zIkTz3udceTS4Rc0wqc1RxeD2bTxLPX5U414SOisKXJ
 Dtk7hOks3SsRYqS40BcLHEDA3V+8N5k3zr7KDTPDxCmlO0WwnnNPLEFJE6Ir2MQ4bBRx
 QvOHNzEfEroe+BZbnpx+icIqFgereVetU//YB3omEA62RkccrYYKPWJuAOwqisb4w+CU
 GCng6Y5f91kY4fQjMyEmKfdyLawRfEJnle0IMoDxe4T/94Z4XI7f50eLI/J2L6A77Cpa
 qy/GZzQXRQK6uz0vkvR3KMKgJV3GPLktuF6tRNrBo+akz/2bcwHgD+8O3N3/N7X7cJg8
 nPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733739333; x=1734344133;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=su/x2AeB9A+MWsmpW5mJDB2NEVa6nTYASJGxM3NHowo=;
 b=cPJiVFoOklZxIfdJEPGAYDk6g9PwnNW3HVMc+mMmoG+VQ9DkBR/hSuLkDwHWBuRgh6
 TcjZvI7mX35kmscrGn2SwfMLcNJ3i9U1vlHEk/niYup8alCwSXq8CEJAY6Fzhm1gLMYu
 9IlEKFoQLo6LSfy7PonAPU9/VRqB4LWoxnO/Gh0/E5FpgX+AjoGNaUGEvXhZl09c4MB9
 zDcEl4+w4BZ5UDfndLinVubwW/Exndalol5YyE36gWy9muz7IjnY8DfU50178r1jffZ1
 whp8qTm5XOP+471inl6j2JA4rGQ612qzlUo/nlrJZ24ZWNBTWAWg79Ukv2a4AcqTHAtx
 /TcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNSLuSpVssJAjvXHNggPDao3QzpKC3JSZ9Ft8wnJsoFi6bMa3rldbxND4zJPA0LXrJ4Oq1LcY=@lists.denx.de
X-Gm-Message-State: AOJu0YzcloA4oPHGDbWX1yOPzrnbLVoV/oob0YVifB7imvXKbIx5XCUT
 fCuB3+A7U4j5Z80nVIi8Yn/4WIKYQHS63XjcQnwC/dDQAyiIo5uiXz89CW6UXaUbjHUHssW8tBF
 UHy9oXoxczj93uEavQrBQHio2r1g=
X-Gm-Gg: ASbGncsMwSJ+e2OXPy256oa3lN6EBpI4qCPge+cO52c6g9B/gtiV5UHZVEzVDJGZMRb
 7Oxsekt5+TNqZiDX+LnKDh9Ai7Xx+28I=
X-Google-Smtp-Source: AGHT+IHEf04ZAQqTicy2BA+zDvUs91CRI3D5c5KIUaQ9TutYLIDeHoe0K4am0sLMJrmp4L5s4fw7bPVwfuC6QgnWdJk=
X-Received: by 2002:a17:907:3a0f:b0:aa6:3f93:fb99 with SMTP id
 a640c23a62f3a-aa63f9405bamr1073968966b.36.1733739332872; Mon, 09 Dec 2024
 02:15:32 -0800 (PST)
MIME-Version: 1.0
References: <20241201150704.44462-1-bigunclemax@gmail.com>
 <CGME20241201150730epcas1p18a5e2e7eb226f2ef589728704ce3faee@epcas1p1.samsung.com>
 <20241201150704.44462-2-bigunclemax@gmail.com>
 <02bf01db46a5$6a017470$3e045d50$@samsung.com>
In-Reply-To: <02bf01db46a5$6a017470$3e045d50$@samsung.com>
From: Maxim Kiselev <bigunclemax@gmail.com>
Date: Mon, 9 Dec 2024 13:15:20 +0300
Message-ID: <CALHCpMhjx=HUuoTQKGr0wdo8xKSTfLjP3+NG1vdpFsqR6eCYtQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] mmc: snps_sdhci: Add sdhci driver support for
 TH1520 SoC
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Wei Fu <wefu@redhat.com>, 
 Yixun Lan <dlan@gentoo.org>, Peng Fan <peng.fan@nxp.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Greg Malysa <greg.malysa@timesys.com>, 
 Raymond Mao <raymond.mao@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Linus Walleij <linus.walleij@linaro.org>,
 Kongyang Liu <seashell11234455@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Wei Liang Lim <weiliang.lim@starfivetech.com>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Kuan Lim Lee <kuanlim.lee@starfivetech.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi, Jaehoon

Thanks for your review!

=D1=87=D1=82, 5 =D0=B4=D0=B5=D0=BA. 2024=E2=80=AF=D0=B3. =D0=B2 02:37, Jaeh=
oon Chung <jh80.chung@samsung.com>:

...[snip]...

> > +
> > +static void sdhci_phy_1_8v_init(struct sdhci_host *host)
> > +{
> > +     struct snps_sdhci_plat *plat =3D dev_get_plat(host->mmc->dev);
> > +     u32 val;
> > +
> > +     /* deassert phy reset & set tx drive strength */
> > +     val =3D PHY_CNFG_RSTN_DEASSERT;
> > +     val |=3D FIELD_PREP(PHY_CNFG_PAD_SP_MASK, PHY_CNFG_PAD_SP);
> > +     val |=3D FIELD_PREP(PHY_CNFG_PAD_SN_MASK, PHY_CNFG_PAD_SN);
> > +     sdhci_writel(host, val, PHY_CNFG_R);
> > +
> > +     /* disable delay line */
> > +     sdhci_writeb(host, PHY_SDCLKDL_CNFG_UPDATE, PHY_SDCLKDL_CNFG_R);
> > +
> > +     /* set delay line */
> > +     sdhci_writeb(host, plat->delay_line, PHY_SDCLKDL_DC_R);
> > +     sdhci_writeb(host, PHY_DLL_CNFG2_JUMPSTEP, PHY_DLL_CNFG2_R);
> > +
> > +     /* enable delay lane */
> > +     val =3D sdhci_readb(host, PHY_SDCLKDL_CNFG_R);
> > +     val &=3D ~(PHY_SDCLKDL_CNFG_UPDATE);
> > +     sdhci_writeb(host, val, PHY_SDCLKDL_CNFG_R);
> > +
> > +     /* configure phy pads */
> > +     val =3D PHY_PAD_RXSEL_1V8;
> > +     val |=3D FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLU=
P);
> > +     val |=3D FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CT=
RL_P);
> > +     val |=3D FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CT=
RL_N);
> > +     sdhci_writew(host, val, PHY_CMDPAD_CNFG_R);
> > +     sdhci_writew(host, val, PHY_DATAPAD_CNFG_R);
> > +     sdhci_writew(host, val, PHY_RSTNPAD_CNFG_R);
> > +
> > +     val =3D FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTR=
L_P);
> > +     val |=3D FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CT=
RL_N);
> > +     sdhci_writew(host, val, PHY_CLKPAD_CNFG_R);
> > +
> > +     val =3D PHY_PAD_RXSEL_1V8;
> > +     val |=3D FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLD=
OWN);
> > +     val |=3D FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CT=
RL_P);
> > +     val |=3D FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CT=
RL_N);
> > +     sdhci_writew(host, val, PHY_STBPAD_CNFG_R);
> > +
> > +     /* enable data strobe mode */
> > +     sdhci_writeb(host, FIELD_PREP(PHY_DLLDL_CNFG_SLV_INPSEL_MASK, PHY=
_DLLDL_CNFG_SLV_INPSEL),
> > +                  PHY_DLLDL_CNFG_R);
> > +
> > +     /* enable phy dll */
> > +     sdhci_writeb(host, PHY_DLL_CTRL_ENABLE, PHY_DLL_CTRL_R);
> > +}
> > +
> > +static void sdhci_phy_3_3v_init(struct sdhci_host *host)
> > +{
> > +     struct snps_sdhci_plat *plat =3D dev_get_plat(host->mmc->dev);
> > +     u32 val;
> > +
> > +     /* deassert phy reset & set tx drive strength */
> > +     val =3D PHY_CNFG_RSTN_DEASSERT;
> > +     val |=3D FIELD_PREP(PHY_CNFG_PAD_SP_MASK, PHY_CNFG_PAD_SP);
> > +     val |=3D FIELD_PREP(PHY_CNFG_PAD_SN_MASK, PHY_CNFG_PAD_SN);
> > +     sdhci_writel(host, val, PHY_CNFG_R);
> > +
> > +     /* disable delay line */
> > +     sdhci_writeb(host, PHY_SDCLKDL_CNFG_UPDATE, PHY_SDCLKDL_CNFG_R);
> > +
> > +     /* set delay line */
> > +     sdhci_writeb(host, plat->delay_line, PHY_SDCLKDL_DC_R);
> > +     sdhci_writeb(host, PHY_DLL_CNFG2_JUMPSTEP, PHY_DLL_CNFG2_R);
> > +
> > +     /* enable delay lane */
> > +     val =3D sdhci_readb(host, PHY_SDCLKDL_CNFG_R);
> > +     val &=3D ~(PHY_SDCLKDL_CNFG_UPDATE);
> > +     sdhci_writeb(host, val, PHY_SDCLKDL_CNFG_R);
> > +
> > +     /* configure phy pads */
> > +     val =3D PHY_PAD_RXSEL_3V3;
> > +     val |=3D FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLU=
P);
> > +     val |=3D FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CT=
RL_P);
> > +     val |=3D FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CT=
RL_N);
> > +     sdhci_writew(host, val, PHY_CMDPAD_CNFG_R);
> > +     sdhci_writew(host, val, PHY_DATAPAD_CNFG_R);
> > +     sdhci_writew(host, val, PHY_RSTNPAD_CNFG_R);
> > +
> > +     val =3D FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTR=
L_P);
> > +     val |=3D FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CT=
RL_N);
> > +     sdhci_writew(host, val, PHY_CLKPAD_CNFG_R);
> > +
> > +     val =3D PHY_PAD_RXSEL_3V3;
> > +     val |=3D FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLD=
OWN);
> > +     val |=3D FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CT=
RL_P);
> > +     val |=3D FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CT=
RL_N);
> > +     sdhci_writew(host, val, PHY_STBPAD_CNFG_R);
> > +
> > +     /* enable phy dll */
> > +     sdhci_writeb(host, PHY_DLL_CTRL_ENABLE, PHY_DLL_CTRL_R);
> > +}
> > +
> > +static void snps_sdhci_set_phy(struct sdhci_host *host)
> > +{
> > +     struct snps_sdhci_plat *plat =3D dev_get_plat(host->mmc->dev);
> > +     struct mmc *mmc =3D host->mmc;
> > +
> > +     /* Before power on, set PHY configs */
> > +     if ((plat->flags & FLAG_IO_FIXED_1V8) ||
> > +         mmc->signal_voltage =3D=3D MMC_SIGNAL_VOLTAGE_180)
> > +             sdhci_phy_1_8v_init(host);
> > +     else
> > +             sdhci_phy_3_3v_init(host);
>
>
> Well, if my reading is right, sdhci_phy_1_8v_init and sdhci_3_3v_init are=
 different PHY_PAD_RXSEL_1V8 and PHY_PAD_RXSEL_3V3.
> Also  enable data strobe mode part.
>
> I'm not sure why mainline kernel code doesn't re-use some code.
> It can be reducing code.
> Even though There are no objection because of mainline kernel codes, fran=
kly, it's not my preference.
>
> I have posted the kernel patch to reuse code. (I'm not sure if can be acc=
epted.)
> https://patchwork.kernel.org/project/linux-mmc/patch/20241204100507.33002=
5-1-jh80.chung@samsung.com/
>
>

Good catch, I'll wait when your linux patch will be accepted.
And I will make the same changes here.

...[snip]...

> > +static const struct sdhci_ops snps_sdhci_ops =3D {
> > +     .set_ios_post =3D snps_sdhci_set_ios_post,
> > +     .platform_execute_tuning =3D snps_sdhci_execute_tuning,
> > +     .set_enhanced_strobe =3D snps_sdhci_set_enhanced_strobe,
> > +#if CONFIG_IS_ENABLED(CONFIG_MMC_SDHCI_ADMA_HELPERS)
>
> CONFIG_IS_ENABLED(MMC_SDHCI_ADMA_HELPERS) ?
>

I'll fix it in v2.

> > +     .adma_write_desc =3D snps_sdhci_adma_write_desc,
> > +#endif
> > +};
> > +
> > +static int snps_sdhci_probe(struct udevice *dev)
> > +{
> > +     struct mmc_uclass_priv *upriv =3D dev_get_uclass_priv(dev);
> > +     struct snps_sdhci_plat *plat =3D dev_get_plat(dev);
> > +     struct mmc_config *cfg =3D &plat->cfg;
> > +     struct sdhci_host *host =3D dev_get_priv(dev);
> > +     struct clk clk;
> > +     int ret;
> > +
> > +     plat->delay_line =3D PHY_SDCLKDL_DC_DEFAULT;
> > +
> > +     host->max_clk =3D cfg->f_max;
> > +     ret =3D clk_get_by_index(dev, 0, &clk);
> > +     if (!ret) {
> > +             ret =3D clk_set_rate(&clk, host->max_clk);
> > +             if (IS_ERR_VALUE(ret))
> > +                     printf("%s clk set rate fail!\n", __func__);
>
> Even though clock set rate is failed, it doesn't matter to be still going=
?
>

Well, I took this part from the rockchip sdhci driver as is...
But mmc clk actually is fixed on TH1520 and we can't change it.
So I'll drop this in v2.

> > +     } else {
> > +             printf("%s fail to get clk\n", __func__);
>
> Ditto?
>
> > +     }
> > +
> > +     host->ops =3D &snps_sdhci_ops;
> > +
> > +     host->mmc =3D &plat->mmc;
> > +     host->mmc->priv =3D host;
> > +     host->mmc->dev =3D dev;
> > +     upriv->mmc =3D host->mmc;
> > +
> > +     ret =3D sdhci_setup_cfg(cfg, host, cfg->f_max, EMMC_MIN_FREQ);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if ((dev_read_bool(dev, "mmc-ddr-1_8v")) ||
> > +         (dev_read_bool(dev, "mmc-hs200-1_8v")) ||
> > +         (dev_read_bool(dev, "mmc-hs400-1_8v")))
> > +             plat->flags |=3D FLAG_IO_FIXED_1V8;
> > +     else
> > +             plat->flags &=3D ~FLAG_IO_FIXED_1V8;
> > +
> > +     return sdhci_probe(dev);
> > +}
> > +
> > +static int snps_sdhci_of_to_plat(struct udevice *dev)
> > +{
> > +     struct snps_sdhci_plat *plat =3D dev_get_plat(dev);
> > +     struct mmc_config *cfg =3D &plat->cfg;
> > +     struct sdhci_host *host =3D dev_get_priv(dev);
> > +     int ret;
> > +
> > +     host->name =3D dev->name;
> > +     host->ioaddr =3D dev_read_addr_ptr(dev);
> > +
> > +     ret =3D mmc_of_parse(dev, cfg);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return 0;
>
> Is it possible to use "return mmc_of_parse();"?

Yes, it is. Thanks, will be fixed in v2.

>
> Best Regards,
> Jaehoon Chung
>

Best wishes,
Maksim

> > +}
> > +
> > +static int snps_sdhci_bind(struct udevice *dev)
> > +{
> > +     struct snps_sdhci_plat *plat =3D dev_get_plat(dev);
> > +
> > +     return sdhci_bind(dev, &plat->mmc, &plat->cfg);
> > +}
> > +
> > +static const struct udevice_id snps_sdhci_ids[] =3D {
> > +     { .compatible =3D "thead,th1520-dwcmshc" }
> > +};
> > +
> > +U_BOOT_DRIVER(snps_sdhci_drv) =3D {
> > +     .name           =3D "snps_sdhci",
> > +     .id             =3D UCLASS_MMC,
> > +     .of_match       =3D snps_sdhci_ids,
> > +     .of_to_plat     =3D snps_sdhci_of_to_plat,
> > +     .ops            =3D &sdhci_ops,
> > +     .bind           =3D snps_sdhci_bind,
> > +     .probe          =3D snps_sdhci_probe,
> > +     .priv_auto =3D sizeof(struct sdhci_host),
> > +     .plat_auto =3D sizeof(struct snps_sdhci_plat),
> > +};
> > --
> > 2.45.2
