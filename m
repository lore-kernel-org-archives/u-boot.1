Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6572CC4453C
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 15:23:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0224C408F2;
	Wed, 22 Jul 2026 15:23:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xgbZ9b7tvDHG; Wed, 22 Jul 2026 15:23:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A77DC40763
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784733796;
	bh=i4vflK/s/7NEyQeCGhKioQ31Uc2tN2gMJH2/ovKcakA=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=K2dhL5Ao47RTb6hBwrd4FxrAFM3XyNjP8V3zAw5tv8IB5XGXDD45WI+vRHCKwFzzR
	 2X5Wh2GGcN54GKD5I5JjpejpDUcNED8fa7Q6TXECFr/DLrYVbFicfdO7L41N7VDVvB
	 4Rhn2fTlUVn1dXukWAILzQGVnu7wb41Tn5wNxVAE0UslloZN/1QJisZ6wsBGVQzq2r
	 ZeFC0X3u8psiRHJ659bHGrRcl82Xep+9AIs56ZgH9UDdKlJfO+6VJPxaaN+IN8nG0R
	 Bms0vqGRfYUh/XC80K8fyOlnlnrU9fbjqIPF7dh11a903ATnaQeMqD+UljOirjobk7
	 +bteECw8Z7/BA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A77DC40763;
	Wed, 22 Jul 2026 15:23:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 466C11093
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:23:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2D28880F29
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:23:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L1M8eGJZ_OW8 for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 15:23:14 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org DEAEA80F24
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DEAEA80F24
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DEAEA80F24
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:23:13 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 589F98494B; Wed, 22 Jul 2026 17:23:12 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2553E848BA
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 17:23:10 +0200 (CEST)
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-39c9452243cso88537811fa.3
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 08:23:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784733789; cv=none;
 d=google.com; s=arc-20260327;
 b=MhdQecmVOLw9dZscSlWkx8bm9gENb7OpMK4tLuBtuRHbW8/XG4rqw1bdc19JT8WcL7
 LVlYI5bfFT/kCeRCfExzjUWVOgRViNf5IVJ5zC3p2nq1JC1+jwN48NG9WdRM3erelte3
 LMBscee11wUu+1EtllEnUfqD2jvDjDG6++aC/qUkNUBiN6O7RhsFvw5LY4TCNee+EjAX
 mW/yuZlyGmb2hMbQhEPCq33XLrNiFO8sT06hMlH4Qss1TPcddzUb0kE+d41eBbrWRiiG
 ub/BH5skoOegWxh405cUZgrZ6RxjeqnyEHqbWfNMA/brXw1/Fv4OxONLyj9EkpQ+QnUr
 c2dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=i4vflK/s/7NEyQeCGhKioQ31Uc2tN2gMJH2/ovKcakA=;
 fh=rH9ffyJlF3eOkkMUOXEl/wCQ0mrJdEKWXf1T2kavwP4=;
 b=DJJZQJBCqQA5ByYZkoZ4fEFK+KUGz6wnGICEX6n1pi+jnTp+m3/N/Ag893kDZJPfvS
 jccthE9z0X6ijoQ05HNLRHZwi2Ho/cZWX7CqocwQkXXB/1iLalyrgTuNaoyGFCXjKoMc
 8sj1nkf3XZdi42vV0EtpWHxVNFQtEIoxUrtmdM0lkwE2kC7c8dI4P6fSSjhGRXMFqBJG
 TxaPKAZnYNd+Feccs/r0oeZPQXdwposN2QvLegtNGGw+hfQIztBlGBnBxjwYauGXhZlW
 N69jywI85J2kPJtkBgq01bTfcOwNuQ08hZuRhHLIufBGGHqa0pTo85a5/k7pxh/LF5sW
 Ahmw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784733789; x=1785338589;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i4vflK/s/7NEyQeCGhKioQ31Uc2tN2gMJH2/ovKcakA=;
 b=dCW2P/YYGmjy028y5PevkCrFDb0RNuxKpt0Kvg4F4To4WG8Qg2eATe2V5tliqGwneB
 JA7fLHZn+0SiRJ8TeRGmEvMoHkstPU5ZB+nx4gdH9z0LZCHAipm3UCRivA3exAw/XU4g
 rqvY/dazue0Z0WPxtmYE/hrlbsJ2hBFDgLGYbPQEVuobkZvpl4tqiAI7C/FiA6pBKnDl
 ddkaErv97cGATpZsnLXJcXXleFMgVoN8exsui3uClgntoSa79QjJSYXCeCjqLnfgf9q8
 JbykXB48Bgqx/nFd828TOZhspvVfeFYi0QsSv9p65imxu0YQeG8idShircDkchv98SbW
 5ZrA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr3w7pbAEfurVw7ET0DRc7BfJRp5sKP89vEsVXQAczywOS/aCZdbn5WyId78R802ar6b1R0FGQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1BVdJBr+XTJfc7oJVVSxcfJbKKJPOG5iAiPKKvtyfJJOmcDFm
 3SyiM+obb4+dqrsw/FGoz6XUWb+8m/I9NwraOIINgvmk3brv1nsd4Ka6L4Oetew395ZukeO2Ekx
 CDdyYLDlo0tmDbokWhyZbrJTC/k5gaXBkWsCBt+eKZQ==
X-Gm-Gg: AR+sD11Rn4oCOftyLrbU2Gi2RmNgAPlV6ANRqBsOMFs3mnhxV+lcAuJC+ADNhcsQ0mx
 u3A9NYgia7if603mUVwApaC1ngFxA8b8FUUq9RmLZC9RoJfB/5ERwEFW4TAy47+G8PmYG914itA
 SAuEp77B6Tkr9jNU0dvjEoo8KBAHjL5zWmh0P90yl7SUu45N2XU9pdmfk54ASvj7sFAI2lSZ99b
 G6n6oN2EYsi9Jr8khdpZ/ACf5rJ4Enxvtc8ZwklT9Y+dmY7Jra0ediybqHtrQVhjM8xL0798KJL
 RRwWKy04cvWhUZqkNYxfohtrkexul9cILE+fFIAVJIo6YxU0AS2geSXZm0yc4X8k70Xwh5mHMYu
 m0/8QhiM20VJruk4Ts9VrpEy0PekJiw==
X-Received: by 2002:a05:6512:2216:b0:5ae:a9ed:162e with SMTP id
 2adb3069b0e04-5b28fbcb090mr4476293e87.65.1784733789195; Wed, 22 Jul 2026
 08:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260707-m4-v4-0-dbd01185f911@riscstar.com>
 <20260707-m4-v4-4-dbd01185f911@riscstar.com> <al0NcAmLqTlIShq7@pie>
In-Reply-To: <al0NcAmLqTlIShq7@pie>
Date: Wed, 22 Jul 2026 23:22:57 +0800
X-Gm-Features: AUfX_mx0vhvtmhRfh6t6w-HVIMNSn2LKb6H_0Mcsh9gjTxxiN-3ub5eb3D1wgig
Message-ID: <CAH22mJzE7wMf8_NGjD0qMApK6RmVZCsS9J7k48qn_UihZuiDGg@mail.gmail.com>
Subject: Re: [PATCH v4 04/10] mmc: k1: add sdhci platform driver
To: Yao Zi <me@ziyao.cc>
Cc: u-boot-spacemit@groups.io, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Han Xu <han.xu@nxp.com>, Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>,
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Guodong Xu <guodong.xu@riscstar.com>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1784733789; x=1785338589;
 darn=lists.denx.de; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=i4vflK/s/7NEyQeCGhKioQ31Uc2tN2gMJH2/ovKcakA=;
 b=KD84QXsvYAjcUohfzBO24xcUXuj4M2NYHp4cFwqja/oqj+JAfDe18df1zGv1NYBIAR
 zp+jUfAjphCbb+6JcSSzgWDYQ8rF6+hWSWEXFtn9VxNhcFcjR3Z/QDo/Ei9UlQ6GSSwe
 D4ArUrWUgXoGN8UF5j2P2WrMguQh5cVyXISF9Kfowh+wmPNW66LcvozXqZGe9uA46sn3
 ljwdFPrEnY0w218lVRsGL6OQektN3k7/eM5f86GbFSdGzHRpWJq4fYMVoCAv8nVX4VOd
 aYIRIlRwdmDusLPegZQ1ojTOo7mxlBdcMKkdEPILTt2HbJmvf+Fi2kOEvmTxFBR6lsaq
 ZtlA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=fail (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=KD84QXsv
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=eric.chung@riscstar.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.b="KD84QXsv"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Eric Chung via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Eric Chung <eric.chung@riscstar.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon, Jul 20, 2026 at 1:47=E2=80=AFAM Yao Zi <me@ziyao.cc> wrote:
>
> On Tue, Jul 07, 2026 at 11:21:45PM +0800, Eric Chung wrote:
> > Add SDHCI platform driver support for SpacemiT K1 SoC. This driver
> > implements the necessary platform-specific operations for the SDHCI
> > controller, enabling MMC/SD card functionality on K1-based platforms.
> >
> > Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> >
> > ---
> > v4:
> > - Add bulk release operations on reset and clock.
> > v3:
> > - Enable CMD23 in capability.
> > v2:
> > - Enable ADMA mode support.
> > - Use CMD23 for multi-block read/write.
> > - Move ASR/AIB register into pinctrl driver.
> > - Correct pinctrl state from "fast" to "uhs".
> > - Migrate tuning support from the spacemit linux driver.
> > ---
> >  drivers/mmc/Kconfig          |   7 +
> >  drivers/mmc/Makefile         |   1 +
> >  drivers/mmc/spacemit_sdhci.c | 685 +++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 693 insertions(+)
>
> ...
>
> > diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.=
c
> > new file mode 100644
> > index 00000000000..1c7dd3a5870
> > --- /dev/null
> > +++ b/drivers/mmc/spacemit_sdhci.c
> > @@ -0,0 +1,685 @@
>
> ...
>
> > +#define SPACEMIT_SDHC_RX_CFG_REG        0x118
> > +#define  SDHC_RX_SDCLK_SEL0_MASK        GENMASK(1, 0)
> > +#define  SDHC_RX_SDCLK_SEL1_MASK        GENMASK(3, 2)
> > +#define  SDHC_RX_SDCLK_SEL1             FIELD_PREP(SDHC_RX_SDCLK_SEL1_=
MASK, 1)
>
> Space and TABs are both used in definitions of macros in this file,
> please choose a consistent style.
>
> ...
>
> > +static int spacemit_sdhci_set_vqmmc_voltage(struct mmc *mmc, int volta=
ge)
> > +{
> > +#if CONFIG_IS_ENABLED(DM_REGULATOR)
> > +     int ret;
> > +
> > +     if (!mmc->vqmmc_supply)
> > +             return 0;
> > +
> > +     ret =3D regulator_set_value(mmc->vqmmc_supply, voltage);
> > +     if (ret) {
> > +             log_err("failed to set vqmmc voltage to %d.%dV\n",
> > +                     voltage / 1000000, (voltage / 100000) % 10);
> > +             return ret;
> > +     }
> > +     ret =3D regulator_set_enable_if_allowed(mmc->vqmmc_supply, true);
> > +     if (ret) {
> > +             log_err("failed to enable vqmmc supply\n");
> > +             return ret;
> > +     }
> > +#endif
> > +     return 0;
> > +}
> > +
> > +static void spacemit_sdhci_set_voltage(struct sdhci_host *host)
> > +{
> > +     if (IS_ENABLED(CONFIG_MMC_IO_VOLTAGE)) {
> > +             struct mmc *mmc =3D host->mmc;
> > +             u32 ctrl;
> > +
> > +             ctrl =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
> > +
> > +             switch (mmc->signal_voltage) {
> > +             case MMC_SIGNAL_VOLTAGE_330:
> > +             case MMC_SIGNAL_VOLTAGE_180: {
> > +                     bool to_180 =3D mmc->signal_voltage =3D=3D
> > +                                   MMC_SIGNAL_VOLTAGE_180;
> > +                     bool ok;
> > +                     int voltage_mv =3D to_180 ? 1800000 : 3300000;
> > +
> > +                     if (spacemit_sdhci_set_vqmmc_voltage(mmc, voltage=
_mv))
> > +                             return;
> > +                     if (!IS_SD(mmc))
> > +                             return;
> > +                     if (to_180)
> > +                             ctrl |=3D SDHCI_CTRL_VDD_180;
> > +                     else
> > +                             ctrl &=3D ~SDHCI_CTRL_VDD_180;
> > +                     sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
> > +
> > +                     mdelay(5);
> > +
> > +                     ctrl =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
> > +                     ok =3D !!(ctrl & SDHCI_CTRL_VDD_180) =3D=3D to_18=
0;
> > +                     if (ok)
> > +                             return;
> > +
> > +                     log_err("%d.%dV regulator output not stable\n",
> > +                             voltage_mv / 1000000,
> > +                             (voltage_mv / 100000) % 10);
> > +                     break;
> > +             }
> > +             default:
> > +                     /* No signal voltage switch required */
> > +                     return;
> > +             }
> > +     }
>
> It seems the only difference between spacemit_sdhci_set_voltage() and
> sdhci_set_voltage() is that the earlier doesn't disable vqmmc before
> changing its voltage, is this really necessary, since I don't see
> similar behavior in the kernel MMC driver? And if it is, please point
> the difference out in comment, and explain why if possible.
>

I can't find the code of disabling vqmmc before changing its voltage in ker=
nel.
mmc_regulator_set_vqmmc() only sets the voltage directly.

> > +}
>
> ...
>
> > +static int spacemit_sdhci_wait_dat0(struct udevice *dev, int state,
> > +                                 int timeout_us)
> > +{
> > +     struct mmc *mmc =3D mmc_get_mmc_dev(dev);
> > +     struct sdhci_host *host =3D mmc->priv;
> > +     unsigned long timeout =3D timer_get_us() + timeout_us;
> > +     u32 tmp;
> > +
> > +     /*
> > +      * readx_poll_timeout is unsuitable because sdhci_readl accepts
> > +      * two arguments
> > +      */
>
> But read_poll_timeout() accepts op with arbitrary number of arguments,
> could it be used?
>
> > +     do {
> > +             tmp =3D sdhci_readl(host, SDHCI_PRESENT_STATE);
> > +             if (!!(tmp & SDHCI_DATA_0_LVL_MASK) =3D=3D !!state) {
> > +                     if (spacemit_sdhci_is_voltage_switch_cmd(host))
> > +                             spacemit_sdhci_set_clk_gate(host, 1);
> > +                     return 0;
> > +             }
> > +     } while (!timeout_us || !time_after(timer_get_us(), timeout));
> > +
> > +     return -ETIMEDOUT;
> > +}
> > +
> > +static void spacemit_sdhci_set_control_reg(struct sdhci_host *host)
> > +{
>
> ...
>
> > +     /* Set pinctrl state */
> > +     if (IS_ENABLED(CONFIG_PINCTRL)) {
> > +             if (mmc->clock >=3D 200000000)
> > +                     pinctrl_select_state(mmc->dev, "uhs");
> > +             else
> > +                     pinctrl_select_state(mmc->dev, "default");
>
> Shouldn't pinctrl setting be switched based on mode (whether it's
> UHS or not) instead of clock frequency, as what has been done in the
> kernel side?
>
OK. I'll switch it based on mode.

> In v1 of this series, the spacemit_sdhci_set_aib_mmc1_io() is also
> called with the selected signal voltage, so I think voltage switching
> logic is incorrect here.
>
I moved the content of spacemit_sdhci_set_aib_mmc1_io() into pinctrl driver=
.

> ...
>
> > +#if CONFIG_IS_ENABLED(MMC_HS400_ES_SUPPORT)
> > +static int spacemit_sdhci_phy_dll_init(struct sdhci_host *host)
> > +{
> > +     u32 reg;
> > +     int i;
> > +
> > +     /* Configure DLL predly, fulldly, and vreg */
> > +     spacemit_sdhci_clrsetbits(host, SDHC_DLL_PREDLY_NUM |
> > +                               SDHC_DLL_FULLDLY_RANGE |
> > +                               SDHC_DLL_VREG_CTRL,
> > +                               FIELD_PREP(SDHC_DLL_PREDLY_NUM, 1) |
> > +                               FIELD_PREP(SDHC_DLL_FULLDLY_RANGE, 1) |
> > +                               FIELD_PREP(SDHC_DLL_VREG_CTRL, 1),
> > +                               SPACEMIT_SDHC_PHY_DLLCFG);
> > +
> > +     reg =3D sdhci_readl(host, SPACEMIT_SDHC_PHY_DLLCFG1);
> > +     reg |=3D FIELD_PREP(SDHC_DLL_REG1_CTRL, 0x92);
>
> What does 0x92 mean here? Please define it as a macro with meaningful
> name if possible, like SPACEMIT_SDHC_PHY_DLLCFG's case.
>
> > +     sdhci_writel(host, reg, SPACEMIT_SDHC_PHY_DLLCFG1);
>
> ...
>
> > +     /* Wait for DLL lock */
> > +     i =3D 0;
> > +     while (i++ < 100) {
> > +             if (sdhci_readl(host, SPACEMIT_SDHC_PHY_DLLSTS) & SDHC_DL=
L_LOCK_STATE)
> > +                     break;
> > +             udelay(10);
> > +     }
> > +     if (i =3D=3D 100) {
> > +             log_err("%s: phy dll lock timeout\n", host->name);
> > +             return -ETIMEDOUT;
> > +     }
>
> Please use read*_poll_timeout() family to replace the loop and the
> following check.
>
> > +
> > +     return 0;
> > +}
>
> ...
>
> > +static int spacemit_sdhci_probe(struct udevice *dev)
> > +{
>
> ...
>
> > +     /* Set quirks */
>
> I think it's obvious, and there's no need to comment it, but
>
> > +     if (IS_ENABLED(CONFIG_SPL_BUILD))
> > +             host->quirks =3D SDHCI_QUIRK_WAIT_SEND_CMD;
> > +     else
> > +             host->quirks =3D SDHCI_QUIRK_WAIT_SEND_CMD |
> > +                             SDHCI_QUIRK_32BIT_DMA_ADDR;
>
> Why SDHCI_QUIRK_32BIT_DMA_ADDR is only enabled in SPL build? Even it
> isn't used by any code, it shouldn't hurt to set the flag, which is
> less confusing.
>
> ...
>
> > +static const struct udevice_id spacemit_sdhci_ids[] =3D {
> > +     {
> > +             .compatible =3D "spacemit,k1-sdhci",
> > +             .data =3D 0,
>
> Uninitialized fields of static variables are automatically zeroed in C,
> so please remove this assignment.
>
> > +     }, {
> > +     }
> > +};
>
> Regards,
> Yao Zi
