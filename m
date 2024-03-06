Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19AC6C54E49
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 00:47:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35F8E87C4C;
	Wed,  6 Mar 2024 01:47:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GYV5cSJz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47D6187D06; Wed,  6 Mar 2024 01:47:23 +0100 (CET)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 801C087C4C
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 01:47:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5e152c757a5so4446641a12.2
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 16:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709686039; x=1710290839; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bd9XoNbv88daRuhDkXcYucuyapNfjWMEs08YyKWlkTE=;
 b=GYV5cSJzZ8q3luxAoPbI8OlvOBUskCgzR8N8Qd17+i1TYOpdALvGv/CA6MawitfBxG
 yX8i95myluge63IbbsZc9h7oEh/7Pchajn/BqWT7qyl3iyFt3I5pSgFh5s1xYVt+0knI
 X1cFn0stmzmr+4xCri3h+oPpH2CDk2/RgnS2xzgdmzcKty1seDaqJpgj3PW+EoqPMxEL
 DisFNZKgTpITxX73BY0bza6CKNL3wLD0R85ynmj4if4+Z3lSJfa6Q8ZBIAaPKt/h4dzZ
 6u+Vioxb6Au0NT7KAisrbd83AcBdFXiKGlsAXr2uTwO7QGWIektdz8CYc59jPdYnkiUv
 XCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709686039; x=1710290839;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bd9XoNbv88daRuhDkXcYucuyapNfjWMEs08YyKWlkTE=;
 b=ZF9gls9CYGCOegMEYd33yisymdIx9aEsM2aaZ/HayepZLZYXrZ9D7eU44hwDaQInLi
 /yQsYVrcoiGhuDWe7kv2RaLoIdGOA0ZhSm8bZv/dn8GHNjttDI9Qri38g8UlNhXsqwqc
 DZ7JnVsxLdN1IHgZBJ8J/fSSSybbP9nxoeIer6dlNVgeJt5Q/tu6GxJTg8imLVmnd8k5
 Ku24ITYlNHdaJPCs/D7n8H/0+FSoRUPtXXwRMmw3LKA1vz9YnCDTnpJE85mu0mwlwwkN
 /SJaoNRrfT9wspcnruudiwAalCmayt0/gEGFWNIg4ckgMHg3UvVMnWdmN0L5yWtT8mdW
 admg==
X-Gm-Message-State: AOJu0YwRPz+a2/qmuBEkWV0/RpJYOF5cOKFx6EuwziAerNSJMKXP+2cZ
 6UQsRzre7PpqmQiXz10TlIuj1ZG9IbEpRCWA4NPHDTTBzQ2IvM76KHs6QD64l9XbF4o8R6if0l9
 LvTuwxnpHGagVWGo8WM5bqAWdOIY=
X-Google-Smtp-Source: AGHT+IGEh/2UFOWnP9zYFpfP3RV1bPurRekDSMptSTAC/fTbEYzMESI6CsmdmtVXuCaj/TmgbHYIyT/cngxcMm09/98=
X-Received: by 2002:a05:6a20:3d1e:b0:1a1:1571:84d8 with SMTP id
 y30-20020a056a203d1e00b001a1157184d8mr3692479pzi.47.1709686038523; Tue, 05
 Mar 2024 16:47:18 -0800 (PST)
MIME-Version: 1.0
References: <20240226080433.3307154-1-sumit.garg@linaro.org>
 <20240226080433.3307154-6-sumit.garg@linaro.org>
 <CAHCN7x+wwoiLO_hpSkiHXFmAUwa0bhbYeQD_UHK10e2YOX+WKA@mail.gmail.com>
 <CAFA6WYNJ4BVHOFftSdwdMv2SMJ8ZQh3S7CRjJHfiAnosSbmgGQ@mail.gmail.com>
 <CAFA6WYPNsRsWnFLVcMXX_KxmN2YTbysu_ZPan1jyrVASrS==rQ@mail.gmail.com>
 <CAHCN7xLqKdydxRVfdVJ2RmS+=tdQT3fR52uVMhLEoZSoObcq3Q@mail.gmail.com>
In-Reply-To: <CAHCN7xLqKdydxRVfdVJ2RmS+=tdQT3fR52uVMhLEoZSoObcq3Q@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Tue, 5 Mar 2024 18:47:07 -0600
Message-ID: <CAHCN7x+fgQ0woDyaV1R2W28Sjs3Tahq=BuQQ7AE_df8BGpoBnw@mail.gmail.com>
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

On Tue, Mar 5, 2024 at 7:51=E2=80=AFAM Adam Ford <aford173@gmail.com> wrote=
:
>
> On Tue, Mar 5, 2024 at 7:48=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
> >
> > Hi Adam,
> >
> > On Wed, 28 Feb 2024 at 12:29, Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > Hi Adam,
> > >
> > > On Wed, 28 Feb 2024 at 04:42, Adam Ford <aford173@gmail.com> wrote:
> > > >
> > > > On Mon, Feb 26, 2024 at 2:05=E2=80=AFAM Sumit Garg <sumit.garg@lina=
ro.org> wrote:
> > > > >
> > > > > Add initial support for i.MX8M{M/P} PCIe PHY. On i.MX8M{M/P} SoCs=
 PCIe
> > > > > PHY initialization moved to this standalone PHY driver.
> > > > >
> > > > > Inspired from counterpart Linux kernel v6.8-rc3 driver:
> > > > > drivers/phy/freescale/phy-fsl-imx8m-pcie.c.
> > > >
> > > > I have a PCIe device that works just fine in Linux.  I have applied
> > > > your series an enabled the same config options as you did along wit=
h
> > > > some others to resolve some build issues.
> > > >
> > > > Any ideas how to address:
> > > >
> > > > nxp_imx8_pcie_phy pcie-phy@32f00000: PHY: Failed to power on
> > > > pcie-phy@32f00000: -110.
> > > >
> > > > My PHY node looks like this
> > > >
> > > > &pcie_phy {
> > > >     fsl,refclk-pad-mode =3D <IMX8_PCIE_REFCLK_PAD_INPUT>;
> > > >     clocks =3D <&pcie0_refclk>;
> > > >     clock-names =3D "ref";
> > > >     status =3D "okay";
> > > > };
> > > >
> > > > The pcie_refcllk is defined as a 100MHz fixed clock in U-Boot.  clk
> > > > dump shows it to be:
> > > >
> > > > 100000000            0        |-- clock-pcie
> > > >
> > >
> > > I suppose that's an EVK board, try enabling MPCIE_3V3 regulator
> > > required for EVK board via following patch:
> > >
> > > diff --git a/drivers/pci/pcie_dw_imx.c b/drivers/pci/pcie_dw_imx.c
> > > index 7856823c9188..32fd2cb05d4b 100644
> > > --- a/drivers/pci/pcie_dw_imx.c
> > > +++ b/drivers/pci/pcie_dw_imx.c
> > > @@ -17,6 +17,7 @@
> > >  #include <linux/iopoll.h>
> > >  #include <log.h>
> > >  #include <pci.h>
> > > +#include <power/regulator.h>
> > >  #include <regmap.h>
> > >  #include <reset.h>
> > >  #include <syscon.h>
> > > @@ -158,6 +159,8 @@ static int pcie_dw_imx_probe(struct udevice *dev)
> > >         struct pci_controller *hose =3D dev_get_uclass_priv(ctlr);
> > >         int ret;
> > >
> > > +       regulator_autoset_by_name("MPCIE_3V3", NULL);

I think you should search the device tree for "vpcie-supply" and
enable the corresponding regulator, because is more flexible than
hard-coding regulator names. This is also more of a standard practice.

> > > +
> > >         ret =3D imx_pcie_assert_core_reset(priv);
> > >         if (ret) {
> > >                 dev_err(dev, "failed to assert core reset\n");
> > >
> >
> > Were you able to give a retry with the above diff?
>
> Not yet, but I'll try to do it tonight.

That didn't work for me.  I am using a Beacon Embedded kit which does
not use a regulator, so this had no impact, but I think having the
vpcie-supply regulator is a good idea.

I'll investigate a bit more and let you know if I make any progress.

adam
>
> adam
> >
> > -Sumit
