Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C62C54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 13:49:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9A9E88077;
	Tue,  5 Mar 2024 14:49:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MM945Db+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98A7A88085; Tue,  5 Mar 2024 14:49:02 +0100 (CET)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com
 [IPv6:2607:f8b0:4864:20::935])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE1118803A
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 14:48:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-7db44846727so738055241.0
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 05:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709646536; x=1710251336; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qArn7E9r0OkmmARR+3LQJjFHPHGtOPugJlQfNj68M2c=;
 b=MM945Db+Qg4cGBvzMuuiLFw/WNcXkjJSrVQfaXJvs0Z76NSal2bMyhB/0zwCRGVJLh
 Y0XtP92ZSmk05OVIANBKIkSzzRwgmVlwrw5j3gA3ITtpxGq2urUK+veLhQ/2oRKrrGa0
 2URdWIW52HJ0zl/BvCXDs+noQ19syqZwhq6XkC/zAr85PvcIxWLkCtV0s0opFxx0RJ98
 qLTWPbY4uUo1Y+em3NJ2PUqPGgFevFeSrF7yBY0QlSRWWmSV+n4IYiMeSX7NRooFvHMf
 lEQJnDa+oIgICrcIZIzgTbHXOHzJ8J4cMAKffb3ZSq7MMfBR5SwByDPxO5WPRExoV0VN
 CWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709646536; x=1710251336;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qArn7E9r0OkmmARR+3LQJjFHPHGtOPugJlQfNj68M2c=;
 b=se0mphJl365LS/+w4IA67H1hs4lRk57bsjMDO1XxT1bKd4oYraTgSZJVBB8yEvvBd9
 s6h2l9vZ/VPh35hoa021dWxGcM9MgMCoY4wJuEXIbWwcpGfnjTqxE+5gxFVHGMCzfIO7
 wOH9sfoGTiN4EYtjhvd3bOIUdd2vTCB0NIeWNLzOcEt4uyQEF/HBZDDrd910v1StYLU0
 TzPtYCZgWVSEc4Nk4DOk0tm+lxELjzsHJaV8u+AKbJ7h2hieAeOs+nXyw7m71zUQYiYh
 8DVlnS+SVB6FUle8+YARiVnwTgfZZ6AYBYmE5iGC6TIF3/uINkZUjOBjJsfHsGasxgIx
 iyeg==
X-Gm-Message-State: AOJu0YxC9pPJXh+p6kYYQbcERMF2oj2kjMgfY4T0TniGUGCtfwMAXuwz
 M/S/Gg1Iqx8tunpGiWXtfrmg1b+wTiOQyjQbBHz1o2B2cD8WECeHV+31rwTOj3CreoF/rKiX+iU
 jlMFDidfF1cNle0L60Cw59/9XLNUCSHMdnZPPQw==
X-Google-Smtp-Source: AGHT+IGEghoEtCTVld+5wE2k1pXiTHB48eNH1KbF+ymrT57v5tNiEwI5He9YJ7B/cMnobS0tfmg2TuaxtN+z6UCGG9k=
X-Received: by 2002:a67:fc96:0:b0:472:7429:5d14 with SMTP id
 x22-20020a67fc96000000b0047274295d14mr1426118vsp.10.1709646536338; Tue, 05
 Mar 2024 05:48:56 -0800 (PST)
MIME-Version: 1.0
References: <20240226080433.3307154-1-sumit.garg@linaro.org>
 <20240226080433.3307154-6-sumit.garg@linaro.org>
 <CAHCN7x+wwoiLO_hpSkiHXFmAUwa0bhbYeQD_UHK10e2YOX+WKA@mail.gmail.com>
 <CAFA6WYNJ4BVHOFftSdwdMv2SMJ8ZQh3S7CRjJHfiAnosSbmgGQ@mail.gmail.com>
In-Reply-To: <CAFA6WYNJ4BVHOFftSdwdMv2SMJ8ZQh3S7CRjJHfiAnosSbmgGQ@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 5 Mar 2024 19:18:45 +0530
Message-ID: <CAFA6WYPNsRsWnFLVcMXX_KxmN2YTbysu_ZPan1jyrVASrS==rQ@mail.gmail.com>
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

Hi Adam,

On Wed, 28 Feb 2024 at 12:29, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Adam,
>
> On Wed, 28 Feb 2024 at 04:42, Adam Ford <aford173@gmail.com> wrote:
> >
> > On Mon, Feb 26, 2024 at 2:05=E2=80=AFAM Sumit Garg <sumit.garg@linaro.o=
rg> wrote:
> > >
> > > Add initial support for i.MX8M{M/P} PCIe PHY. On i.MX8M{M/P} SoCs PCI=
e
> > > PHY initialization moved to this standalone PHY driver.
> > >
> > > Inspired from counterpart Linux kernel v6.8-rc3 driver:
> > > drivers/phy/freescale/phy-fsl-imx8m-pcie.c.
> >
> > I have a PCIe device that works just fine in Linux.  I have applied
> > your series an enabled the same config options as you did along with
> > some others to resolve some build issues.
> >
> > Any ideas how to address:
> >
> > nxp_imx8_pcie_phy pcie-phy@32f00000: PHY: Failed to power on
> > pcie-phy@32f00000: -110.
> >
> > My PHY node looks like this
> >
> > &pcie_phy {
> >     fsl,refclk-pad-mode =3D <IMX8_PCIE_REFCLK_PAD_INPUT>;
> >     clocks =3D <&pcie0_refclk>;
> >     clock-names =3D "ref";
> >     status =3D "okay";
> > };
> >
> > The pcie_refcllk is defined as a 100MHz fixed clock in U-Boot.  clk
> > dump shows it to be:
> >
> > 100000000            0        |-- clock-pcie
> >
>
> I suppose that's an EVK board, try enabling MPCIE_3V3 regulator
> required for EVK board via following patch:
>
> diff --git a/drivers/pci/pcie_dw_imx.c b/drivers/pci/pcie_dw_imx.c
> index 7856823c9188..32fd2cb05d4b 100644
> --- a/drivers/pci/pcie_dw_imx.c
> +++ b/drivers/pci/pcie_dw_imx.c
> @@ -17,6 +17,7 @@
>  #include <linux/iopoll.h>
>  #include <log.h>
>  #include <pci.h>
> +#include <power/regulator.h>
>  #include <regmap.h>
>  #include <reset.h>
>  #include <syscon.h>
> @@ -158,6 +159,8 @@ static int pcie_dw_imx_probe(struct udevice *dev)
>         struct pci_controller *hose =3D dev_get_uclass_priv(ctlr);
>         int ret;
>
> +       regulator_autoset_by_name("MPCIE_3V3", NULL);
> +
>         ret =3D imx_pcie_assert_core_reset(priv);
>         if (ret) {
>                 dev_err(dev, "failed to assert core reset\n");
>

Were you able to give a retry with the above diff?

-Sumit
