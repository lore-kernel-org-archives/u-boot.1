Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3557C54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 13:51:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0050788064;
	Tue,  5 Mar 2024 14:51:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G9Zr6ApY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96FCB88075; Tue,  5 Mar 2024 14:51:45 +0100 (CET)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DB0A88064
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 14:51:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e622b46f45so1758030b3a.1
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 05:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709646701; x=1710251501; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pTIgysxFvqpITCgSW50mYAj0qa+PlvPjhH/ttygcAfw=;
 b=G9Zr6ApYqNFgVRPi/md9EgjJiubSM/DL+w96kIWeM/Hx9ZZyr34D5XaD2lXMfdHEpS
 qY8/UnzSs6iSsJAL2vY//bGoO3qyh/dVhMicqVdl2o51+Y3OOaq8TI3nxKPenQ06zKA+
 E/avGjxmOxjH1og+q2oRKjaQGVAS+gV29cnxkAH1kcfq3PM8LeWWBWlKC0jyj3mflV3+
 kusNxgj8gIBJLqFfBocEbwWx3CgLFF2V1zuVhZNW0I3leoKqztL6Qr4PDpZJ7k4tPnCE
 bZLUWi0sE+ttrHb2Qy8BBHfWbGP9tktp/QlWmjJOB4ERQAYr1X/1kdj/NMldqRIwcRP5
 +0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709646701; x=1710251501;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pTIgysxFvqpITCgSW50mYAj0qa+PlvPjhH/ttygcAfw=;
 b=KSmF259AMpSCVMvYJQJyzq+GepHQVttjGFc/3pgmfbRwySXIeydylQJ6owKao0iaw2
 khr8ruZOqgMuFL1NXPt0FBROG33sbkMR0Apmgpvam/6NA67KPVab0VfnZq8UXoU49lWo
 EsAf2NfOUNhWuSFIB+//AiGnIu01hqyzfet2nuaOEz5s7XP2Ed3ciFi4pbRIeDOrpVKM
 frq1MsBXLhnvswVGbANRrkvUm42cp4zk4Z8Y4jJhslfLDShHgy2Z+nCjdj/RaBSOHZAI
 /CiJ4fxGmQTv9fqENR0NHvZMBSEsNHWC9LU59DPXw2Pv46jViqOsiV/w58sKmHm84g5A
 YJag==
X-Gm-Message-State: AOJu0YzKAby+abchogMlRf1zVSld4KvDQfDjoe6G+XG7KJ0fjXraOpYr
 ucwAWPLDWnw88Y0htcvj1DiQOpKHKT2lyMrbtdh4lAA4HqzXqbxZ/o7LRmccUcSu8Ji1r2+aFgI
 fir0cOrdpMLE4AP1/Yrtzu5NIh7hRnUJLMOU=
X-Google-Smtp-Source: AGHT+IGj7vjamME1vQmfnPttjR6sDcRVemTKUovalaM49DSAqpLrJsjFwS0Gw+u1yX03TXtfDAbaZknlxBXOyJ4a0Tk=
X-Received: by 2002:a05:6a21:6d95:b0:1a1:4da9:8d76 with SMTP id
 wl21-20020a056a216d9500b001a14da98d76mr2048714pzb.13.1709646700881; Tue, 05
 Mar 2024 05:51:40 -0800 (PST)
MIME-Version: 1.0
References: <20240226080433.3307154-1-sumit.garg@linaro.org>
 <20240226080433.3307154-6-sumit.garg@linaro.org>
 <CAHCN7x+wwoiLO_hpSkiHXFmAUwa0bhbYeQD_UHK10e2YOX+WKA@mail.gmail.com>
 <CAFA6WYNJ4BVHOFftSdwdMv2SMJ8ZQh3S7CRjJHfiAnosSbmgGQ@mail.gmail.com>
 <CAFA6WYPNsRsWnFLVcMXX_KxmN2YTbysu_ZPan1jyrVASrS==rQ@mail.gmail.com>
In-Reply-To: <CAFA6WYPNsRsWnFLVcMXX_KxmN2YTbysu_ZPan1jyrVASrS==rQ@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Tue, 5 Mar 2024 07:51:29 -0600
Message-ID: <CAHCN7xLqKdydxRVfdVJ2RmS+=tdQT3fR52uVMhLEoZSoObcq3Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] phy: phy-imx8m-pcie: Add support for i.MX8M{M/P}
 PCIe PHY
To: Sumit Garg <sumit.garg@linaro.org>
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

On Tue, Mar 5, 2024 at 7:48=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> w=
rote:
>
> Hi Adam,
>
> On Wed, 28 Feb 2024 at 12:29, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Hi Adam,
> >
> > On Wed, 28 Feb 2024 at 04:42, Adam Ford <aford173@gmail.com> wrote:
> > >
> > > On Mon, Feb 26, 2024 at 2:05=E2=80=AFAM Sumit Garg <sumit.garg@linaro=
.org> wrote:
> > > >
> > > > Add initial support for i.MX8M{M/P} PCIe PHY. On i.MX8M{M/P} SoCs P=
CIe
> > > > PHY initialization moved to this standalone PHY driver.
> > > >
> > > > Inspired from counterpart Linux kernel v6.8-rc3 driver:
> > > > drivers/phy/freescale/phy-fsl-imx8m-pcie.c.
> > >
> > > I have a PCIe device that works just fine in Linux.  I have applied
> > > your series an enabled the same config options as you did along with
> > > some others to resolve some build issues.
> > >
> > > Any ideas how to address:
> > >
> > > nxp_imx8_pcie_phy pcie-phy@32f00000: PHY: Failed to power on
> > > pcie-phy@32f00000: -110.
> > >
> > > My PHY node looks like this
> > >
> > > &pcie_phy {
> > >     fsl,refclk-pad-mode =3D <IMX8_PCIE_REFCLK_PAD_INPUT>;
> > >     clocks =3D <&pcie0_refclk>;
> > >     clock-names =3D "ref";
> > >     status =3D "okay";
> > > };
> > >
> > > The pcie_refcllk is defined as a 100MHz fixed clock in U-Boot.  clk
> > > dump shows it to be:
> > >
> > > 100000000            0        |-- clock-pcie
> > >
> >
> > I suppose that's an EVK board, try enabling MPCIE_3V3 regulator
> > required for EVK board via following patch:
> >
> > diff --git a/drivers/pci/pcie_dw_imx.c b/drivers/pci/pcie_dw_imx.c
> > index 7856823c9188..32fd2cb05d4b 100644
> > --- a/drivers/pci/pcie_dw_imx.c
> > +++ b/drivers/pci/pcie_dw_imx.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/iopoll.h>
> >  #include <log.h>
> >  #include <pci.h>
> > +#include <power/regulator.h>
> >  #include <regmap.h>
> >  #include <reset.h>
> >  #include <syscon.h>
> > @@ -158,6 +159,8 @@ static int pcie_dw_imx_probe(struct udevice *dev)
> >         struct pci_controller *hose =3D dev_get_uclass_priv(ctlr);
> >         int ret;
> >
> > +       regulator_autoset_by_name("MPCIE_3V3", NULL);
> > +
> >         ret =3D imx_pcie_assert_core_reset(priv);
> >         if (ret) {
> >                 dev_err(dev, "failed to assert core reset\n");
> >
>
> Were you able to give a retry with the above diff?

Not yet, but I'll try to do it tonight.

adam
>
> -Sumit
