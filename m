Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6AB1C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 06:31:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CCA687D33;
	Wed,  6 Mar 2024 07:31:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="whIHpqtm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 586BC87D14; Wed,  6 Mar 2024 07:31:07 +0100 (CET)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com
 [IPv6:2607:f8b0:4864:20::e32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFFE687D33
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 07:31:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-472967264e7so1643128137.3
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 22:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709706661; x=1710311461; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tHqB/JufYvjh1vhgHrATeKLomghGVXmuu3MQI26Al60=;
 b=whIHpqtmyjSRanAPkGwZTxOA64zuYtXV6YsG7hYxTTGqWBxgup91sMum50Wv0UYUhW
 dTCDP85NEJvMkWE5LvO5CP9OviieNC+7+CBSTdIP0I17p6KX/GuGKdIGypyK8o6n46kY
 sbOKJnm/Pj7qXPrp16ZQEqLgiZTDFZJBrz2S886qdovyxh7G0COP9KJyaDNm/RwWkHXZ
 Y06Lmbqsy/kQljyrOxPyOddmp31n4XBgiurv968DRiTpfdVzCua2/DX8CqoVTEDrlU2/
 xKM+fh4I3HWVeZe5virI6j6XILVLPhq3xVkSiDAm2Ckbq+tiMxJf0haDx8Ed3q/nKXS+
 7pCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709706661; x=1710311461;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tHqB/JufYvjh1vhgHrATeKLomghGVXmuu3MQI26Al60=;
 b=DqcGvS2NuQKA0Zewoyf+QD/iYqJ+qGuc3GGeworJWNqG10+ulrDDT2D/dwbL6K5OGU
 GAzAtSbx6qTlIVlOKRorB7qwMv5oZ89QtmZz64yhce+fekZCijFxuq/eE5zK2ptjVb5D
 b+24+Cafu2LzMS5cQ2R+Pbz/c11cHufsbd265ScD66OY7JR5FyPKzl7wKmvX9SUX2A6P
 b/i7OI8PLLyAocHqnk3byH/DxHYAeTN2MJicEp3Fv6MMxBL8742Y/rBk1uwlqlb6oaBT
 xGeoKRCPR20a/H4I5pmNPxHavjmeb6LZMhxGoSWMxkH8JpCngUiI5J6iRz0uQtc1ryOM
 RuLQ==
X-Gm-Message-State: AOJu0Yw1unZMQ0TFqlOPnulfWCDHm3zL6ayD4KO0msZan4tsrHGJbGgj
 IlHSFBWcyviLCH/0NYzAlmFBxv+2MfekD8SNj721YtRdZLI6JuuAEIbhrP6ulEOIwllo4y0s4ES
 sRO3CHyCnjx1+3CWcFM2LsLfYDRkBbIJzVvEmeQ==
X-Google-Smtp-Source: AGHT+IEVNoGLut2PWoSOAW9q5jFSKD1YF1wVoKrVu/QK/JIIxA8qbhuz9LiGsQSmrDUcojRgcoYD6Mnh62a0PSlTW60=
X-Received: by 2002:a67:ec50:0:b0:472:e281:2acc with SMTP id
 z16-20020a67ec50000000b00472e2812accmr2860136vso.5.1709706661517; Tue, 05 Mar
 2024 22:31:01 -0800 (PST)
MIME-Version: 1.0
References: <20240226080433.3307154-1-sumit.garg@linaro.org>
 <20240226080433.3307154-6-sumit.garg@linaro.org>
 <CAHCN7x+wwoiLO_hpSkiHXFmAUwa0bhbYeQD_UHK10e2YOX+WKA@mail.gmail.com>
 <CAFA6WYNJ4BVHOFftSdwdMv2SMJ8ZQh3S7CRjJHfiAnosSbmgGQ@mail.gmail.com>
 <CAFA6WYPNsRsWnFLVcMXX_KxmN2YTbysu_ZPan1jyrVASrS==rQ@mail.gmail.com>
 <CAHCN7xLqKdydxRVfdVJ2RmS+=tdQT3fR52uVMhLEoZSoObcq3Q@mail.gmail.com>
 <CAHCN7x+fgQ0woDyaV1R2W28Sjs3Tahq=BuQQ7AE_df8BGpoBnw@mail.gmail.com>
In-Reply-To: <CAHCN7x+fgQ0woDyaV1R2W28Sjs3Tahq=BuQQ7AE_df8BGpoBnw@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 6 Mar 2024 12:00:50 +0530
Message-ID: <CAFA6WYPhVY2jg55m6sZR_Aq3ErfAn1s5DfocZkvbT0_mj32a-w@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] phy: phy-imx8m-pcie: Add support for i.MX8M{M/P}
 PCIe PHY
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, marcel.ziswiler@toradex.com, francesco@dolcini.it, 
 trini@konsulko.com, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, 
 festevam@denx.de, andrejs.cainikovs@toradex.com, sjg@chromium.org, 
 peng.fan@nxp.com, marex@denx.de, ilias.apalodimas@linaro.org, 
 sahaj.sarup@linaro.org, fathi.boudra@linaro.org, remi.duraffort@linaro.org, 
 daniel.thompson@linaro.org
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

On Wed, 6 Mar 2024 at 06:17, Adam Ford <aford173@gmail.com> wrote:
>
> On Tue, Mar 5, 2024 at 7:51=E2=80=AFAM Adam Ford <aford173@gmail.com> wro=
te:
> >
> > On Tue, Mar 5, 2024 at 7:48=E2=80=AFAM Sumit Garg <sumit.garg@linaro.or=
g> wrote:
> > >
> > > Hi Adam,
> > >
> > > On Wed, 28 Feb 2024 at 12:29, Sumit Garg <sumit.garg@linaro.org> wrot=
e:
> > > >
> > > > Hi Adam,
> > > >
> > > > On Wed, 28 Feb 2024 at 04:42, Adam Ford <aford173@gmail.com> wrote:
> > > > >
> > > > > On Mon, Feb 26, 2024 at 2:05=E2=80=AFAM Sumit Garg <sumit.garg@li=
naro.org> wrote:
> > > > > >
> > > > > > Add initial support for i.MX8M{M/P} PCIe PHY. On i.MX8M{M/P} So=
Cs PCIe
> > > > > > PHY initialization moved to this standalone PHY driver.
> > > > > >
> > > > > > Inspired from counterpart Linux kernel v6.8-rc3 driver:
> > > > > > drivers/phy/freescale/phy-fsl-imx8m-pcie.c.
> > > > >
> > > > > I have a PCIe device that works just fine in Linux.  I have appli=
ed
> > > > > your series an enabled the same config options as you did along w=
ith
> > > > > some others to resolve some build issues.
> > > > >
> > > > > Any ideas how to address:
> > > > >
> > > > > nxp_imx8_pcie_phy pcie-phy@32f00000: PHY: Failed to power on
> > > > > pcie-phy@32f00000: -110.
> > > > >
> > > > > My PHY node looks like this
> > > > >
> > > > > &pcie_phy {
> > > > >     fsl,refclk-pad-mode =3D <IMX8_PCIE_REFCLK_PAD_INPUT>;
> > > > >     clocks =3D <&pcie0_refclk>;
> > > > >     clock-names =3D "ref";
> > > > >     status =3D "okay";
> > > > > };
> > > > >
> > > > > The pcie_refcllk is defined as a 100MHz fixed clock in U-Boot.  c=
lk
> > > > > dump shows it to be:
> > > > >
> > > > > 100000000            0        |-- clock-pcie
> > > > >
> > > >
> > > > I suppose that's an EVK board, try enabling MPCIE_3V3 regulator
> > > > required for EVK board via following patch:
> > > >
> > > > diff --git a/drivers/pci/pcie_dw_imx.c b/drivers/pci/pcie_dw_imx.c
> > > > index 7856823c9188..32fd2cb05d4b 100644
> > > > --- a/drivers/pci/pcie_dw_imx.c
> > > > +++ b/drivers/pci/pcie_dw_imx.c
> > > > @@ -17,6 +17,7 @@
> > > >  #include <linux/iopoll.h>
> > > >  #include <log.h>
> > > >  #include <pci.h>
> > > > +#include <power/regulator.h>
> > > >  #include <regmap.h>
> > > >  #include <reset.h>
> > > >  #include <syscon.h>
> > > > @@ -158,6 +159,8 @@ static int pcie_dw_imx_probe(struct udevice *de=
v)
> > > >         struct pci_controller *hose =3D dev_get_uclass_priv(ctlr);
> > > >         int ret;
> > > >
> > > > +       regulator_autoset_by_name("MPCIE_3V3", NULL);
>
> I think you should search the device tree for "vpcie-supply" and
> enable the corresponding regulator, because is more flexible than
> hard-coding regulator names. This is also more of a standard practice.
>

Yeah I agree, this was sort of a minimal diff to test with.

> > > > +
> > > >         ret =3D imx_pcie_assert_core_reset(priv);
> > > >         if (ret) {
> > > >                 dev_err(dev, "failed to assert core reset\n");
> > > >
> > >
> > > Were you able to give a retry with the above diff?
> >
> > Not yet, but I'll try to do it tonight.
>
> That didn't work for me.  I am using a Beacon Embedded kit which does
> not use a regulator, so this had no impact, but I think having the
> vpcie-supply regulator is a good idea.

Sure, I can add that.

-Sumit

>
> I'll investigate a bit more and let you know if I make any progress.
>
> adam
> >
> > adam
> > >
> > > -Sumit
