Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04669D1BDC2
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 16:11:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F5AA8826E;
	Mon,  4 Nov 2024 17:11:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PX1gXgNK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00293881FD; Mon,  4 Nov 2024 17:11:15 +0100 (CET)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72A1F88DC7
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 17:11:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7eb0bc007edso2167642a12.3
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 08:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730736672; x=1731341472; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FfaGsWbEuxzNUVf3LRS4dgQPsjSlRXn1mXBOHY+rcyE=;
 b=PX1gXgNKexcL5cTJdrmjWuYv15mx/44/nwRcJyHwTowTAfsmUza/6+wbqCQOMep419
 lmH0FXJj0qbxbBMa1nlnvghhagYR3tri7LBGUEgFR3ePA8B6k5K98jpkJpQEYQS5zPUZ
 LOAiKxL/CsGDtbNxaxT7FJ84iq3qBRzGQb4VbhdaWGCt8EnOOiq3R540VMy5ZRoqUvSQ
 yYN9hdseulwVf99FSb0aKfLJZQOzGN2DeUaJv0X6k4seImmFo/c2Zm5/l9U4t/nN+pW2
 raQI5L/9pxYeo93grmwAoZAA1TOBU99wVTLHRfaGeoK0ZWiTaGUqSrGK6Xqa+FqQELKX
 Lr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730736672; x=1731341472;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FfaGsWbEuxzNUVf3LRS4dgQPsjSlRXn1mXBOHY+rcyE=;
 b=QxolyMRCna0jeQXrDEiXONmjWBX6MRAOWV+FYFQfJ739r2G3ysiLot3pRGysH+ihYk
 twEM6I0HE5nfvUxHAY6Vk35Y4JXSf18TwrrilkTn1+MkA0p0ly4Wi/1aOQ/2/8DwIEWl
 Cgg2hz414nQONC9qRD/+flRPE5Q8JYFlU9T53YA5hX6UCiirYQfthiw5f14O0bXsyRRA
 PICFJrrAvi0snhkSrmkmNanfmMrqXOMnPwRSSSydOAYqso//ecSJHzkdMWmoXohmheLX
 FY2TGWDnnqMdDcR3LCVZjYnT/eGGsCls5mZAE9FePE/AOSALS0G9DdVSf+dJh088jyKN
 iOTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoSTsm1ASO9wlDRIVmu9S77bDkCYMz2D7vcmlDTQYEc74VuZ8h2YNx80SLQ4X6K6RiQ4TIHq0=@lists.denx.de
X-Gm-Message-State: AOJu0Ywa2sxw5agmJdulyv6jxYlU9rSbQjcAc90KGwrC7avShhhy+oS6
 WDT6onYMz7/S6Rt4D1scyqDxh9ALCJN4AMcM/Y4LEAIaVf8RHUL6gw0x5H4WysuSEHnPHCs3VPh
 itbKJAethfJkQGW6qXeeEuiYMGH0=
X-Google-Smtp-Source: AGHT+IGf91QSzJsSNWrJ4VjNQP3N3BZauvQ6Dt7Up8i7KvTzh+ywGAVS5FUrQw2ztIPRU471T8ybrBACvwCw95tcq8k=
X-Received: by 2002:a17:90b:254b:b0:2e2:8f39:98d9 with SMTP id
 98e67ed59e1d1-2e93c1a60f7mr22050756a91.18.1730736671691; Mon, 04 Nov 2024
 08:11:11 -0800 (PST)
MIME-Version: 1.0
References: <20240707082001.20746-1-michael@amarulasolutions.com>
 <20240707082001.20746-2-michael@amarulasolutions.com>
In-Reply-To: <20240707082001.20746-2-michael@amarulasolutions.com>
From: Adam Ford <aford173@gmail.com>
Date: Mon, 4 Nov 2024 10:10:59 -0600
Message-ID: <CAHCN7xK4YgEt7xaA6Ln3Q3GzvOP-iZM+YtZwP1Hg402VstBcOg@mail.gmail.com>
Subject: Re: [PATCH 1/4] clk: imx: clk-imx8mn Fix nand and spi clock parent
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Fabio Estevam <festevam@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, linux-amarula@amarulasolutions.com, 
 u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Marek Vasut <marex@denx.de>
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

On Sun, Jul 7, 2024 at 3:45=E2=80=AFAM Michael Trimarchi
<michael@amarulasolutions.com> wrote:
>
> The osc_24m is the clock-output-name and not the one that
> is used as internal name reference from the strcmp. The clock
> that use osc_24m, will not be able to reparent it as they should.
> We need anyway register the osc_24m clock fixed factor in the clock
> tree.
>
> Fixes: 710c4ffb890 ("clk: imx: clk-imx8mn add gpmi nand clocks")
> Fixes: 85b1c11989c ("clk: imx: Add ECSPI to iMX8MN")
> Cc: Marek Vasut <marex@denx.de>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>  drivers/clk/imx/clk-imx8mn.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
> index ed9e16d7c1..bfd1677520 100644
> --- a/drivers/clk/imx/clk-imx8mn.c
> +++ b/drivers/clk/imx/clk-imx8mn.c
> @@ -57,15 +57,15 @@ static const char *imx8mn_usdhc2_sels[] =3D {"clock-o=
sc-24m", "sys_pll1_400m", "sy
>                                            "sys_pll3_out", "sys_pll1_266m=
", "audio_pll2_out", "sys_pll1_100m", };
>
>  #if CONFIG_IS_ENABLED(DM_SPI)
> -static const char *imx8mn_ecspi1_sels[] =3D {"osc_24m", "sys_pll2_200m",=
 "sys_pll1_40m",
> +static const char *imx8mn_ecspi1_sels[] =3D {"clock-osc-24m", "sys_pll2_=
200m", "sys_pll1_40m",
>                                            "sys_pll1_160m", "sys_pll1_800=
m", "sys_pll3_out",
>                                            "sys_pll2_250m", "audio_pll2_o=
ut", };
>
> -static const char *imx8mn_ecspi2_sels[] =3D {"osc_24m", "sys_pll2_200m",=
 "sys_pll1_40m",
> +static const char *imx8mn_ecspi2_sels[] =3D {"clock-osc-24m", "sys_pll2_=
200m", "sys_pll1_40m",
>                                            "sys_pll1_160m", "sys_pll1_800=
m", "sys_pll3_out",
>                                            "sys_pll2_250m", "audio_pll2_o=
ut", };
>
> -static const char *imx8mn_ecspi3_sels[] =3D {"osc_24m", "sys_pll2_200m",=
 "sys_pll1_40m",
> +static const char *imx8mn_ecspi3_sels[] =3D {"clock-osc-24m", "sys_pll2_=
200m", "sys_pll1_40m",
>                                            "sys_pll1_160m", "sys_pll1_800=
m", "sys_pll3_out",
>                                            "sys_pll2_250m", "audio_pll2_o=
ut", };
>  #endif
> @@ -105,7 +105,7 @@ static const char *imx8mn_usdhc3_sels[] =3D {"clock-o=
sc-24m", "sys_pll1_400m", "sy
>  static const char *imx8mn_qspi_sels[] =3D {"clock-osc-24m", "sys_pll1_40=
0m", "sys_pll2_333m", "sys_pll2_500m",
>                                            "audio_pll2_out", "sys_pll1_26=
6m", "sys_pll3_out", "sys_pll1_100m", };
>
> -static const char * const imx8mn_nand_sels[] =3D {"osc_24m", "sys_pll2_5=
00m", "audio_pll1_out",
> +static const char * const imx8mn_nand_sels[] =3D {"clock-osc-24m", "sys_=
pll2_500m", "audio_pll1_out",
>                                                 "sys_pll1_400m", "audio_p=
ll2_out", "sys_pll3_out",
>                                                 "sys_pll2_250m", "video_p=
ll_out", };
>
> @@ -119,7 +119,9 @@ static const char * const imx8mn_usb_phy_sels[] =3D {=
"clock-osc-24m", "sys_pll1_10
>
>  static int imx8mn_clk_probe(struct udevice *dev)
>  {
> +       struct clk osc_24m_clk;
>         void __iomem *base;
> +       int ret;
>
>         base =3D (void *)ANATOP_BASE_ADDR;
>
> @@ -238,6 +240,11 @@ static int imx8mn_clk_probe(struct udevice *dev)
>         clk_dm(IMX8MN_SYS_PLL2_1000M,
>                imx_clk_fixed_factor("sys_pll2_1000m", "sys_pll2_out", 1, =
1));
>

I know it's late, but I didn't get around to testing my Nano board for
a while.  Sorry for the delayed feedback...

> +       ret =3D clk_get_by_name(dev, "osc_24m", &osc_24m_clk);
> +       if (ret)
> +               return ret;
> +       clk_dm(IMX8MN_CLK_24M, dev_get_clk_ptr(osc_24m_clk.dev));
> +

These four lines appear to have introduced a regression on the
imx8mn-beacon board.  In the SPL phase, I get an error message
indicating it cannot find the i2c clk, then access to the PMIC fails.
If I remove these four lines, the error message disappears, and the
PMIC is happy again.

I have confirmed that CLK, and SPL_CLK are both defined.   I checked
the u-boot-spl.dtb and it shows clock-osc-24m with clock-output-names
=3D "osc_24m"

I have also tried to mark the 24m clock as with bootph-pre-ram;:
&{/clock-osc-24m} {
  bootph-pre-ram;
};

Unfortunately, nothing is helping, and I am not sure what else to try.
clk_fixed_rate.o is built into my SPL, so I don't think it's a config
issue.  I need to the PMIC to increase the voltage since we run the
Nano in overdrive mode to run the LPDDR4 at the highest speed.

Might anyone have any suggestions?

adam

>         base =3D dev_read_addr_ptr(dev);
>         if (!base)
>                 return -EINVAL;
> --
> 2.43.0
>
