Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A052C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 17:26:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 816DE87DCF;
	Wed,  6 Mar 2024 18:26:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks-com.20230601.gappssmtp.com header.i=@gateworks-com.20230601.gappssmtp.com header.b="mEPmXoBg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D131D87D9D; Wed,  6 Mar 2024 18:26:19 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7EDF87C0A
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 18:26:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a293f2280c7so4757466b.1
 for <u-boot@lists.denx.de>; Wed, 06 Mar 2024 09:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks-com.20230601.gappssmtp.com; s=20230601; t=1709745974; x=1710350774;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7NvLOW7eAwKoIkq8bHXpFRKX7nD4MlNHh41PcLCsWGk=;
 b=mEPmXoBg4BnvD0IxjTRiIwUTHrhlsyB5W6cReiEOcJiNDBSG5v5BcY6Hs0qx2TvOmN
 9MNoFarJWllLkH7IcVDltw1owqpsaq4ZbZ/w4xMPdwOp9cABwq22tYSx2spBgAd3rZUw
 wleBHWgIO4aWKLklqXOoaELY0kC/LZh6tHIX7KCljlHojlZwXqbQM9X6pIjoUzuV8fl0
 DoY+UNNQaKKR+fx3ifs2XKKRx49sO+REqNKwYy5bJ3rz2c0+eSVUSxZepIBysuCTe4He
 uM+E1ya//BZkqoRYRnF/PgGhBjWiu1wk+SRPKQA8iRVcJiR29glN64+NFm4wH8iuil89
 CqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709745974; x=1710350774;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7NvLOW7eAwKoIkq8bHXpFRKX7nD4MlNHh41PcLCsWGk=;
 b=UoaOCiCoeC7XqEwLr/SGjWQ370cn3izdHMdrhiN23MI2PWkk/xWafeE6RIuxwt0OrT
 eaP58T8JwzwxJbBwYEC6Pjqle8SYfWyhy7iTqY/o0NKOJ+w+zqEvqkafhvf8OqviMK15
 AaB5I9tgIArwriMg/66pIlZCluKdRKQ4zespnhwmQE2U27gaT8FPuzL/5Ae4QJoshpnI
 v3zPV7XP0f1XFg2lY0Colv5M2PZvW8RBhWe5+nD78NNHwJYC7yoS8G4DSw/ApvytuRZz
 LhHdz9w8bNAMP+FZfar1PnbmTQ7WlmzxYwh1E9I0vwBHAZr9Zfnk4RXZdNQUTsCbDqkp
 W6dA==
X-Gm-Message-State: AOJu0Yxb0WbHjtYdDcuBQj9NNnWAkegqy+CoRQtwNhSh64qPlwPhLE7O
 LW1L/mXANSZdxbHrFrkJPHT67z+NH5LHgUe04fdbWlZJswkTve1mxLzze/ouX+4Pv/akia75inF
 5A+XTvh2F+E1j6G128OrbioPUrFl+k8MJ0s5Idw==
X-Google-Smtp-Source: AGHT+IGL5IyjHBOO5IlFBWNac1M+6koXBN2F1DmA3yZkWrt3h1LIA9gFToiYY6zo//wqXxXUZrKoq7jvCwZcdhzMyEc=
X-Received: by 2002:a17:906:4087:b0:a45:ad81:4ab3 with SMTP id
 u7-20020a170906408700b00a45ad814ab3mr3751323ejj.54.1709745974608; Wed, 06 Mar
 2024 09:26:14 -0800 (PST)
MIME-Version: 1.0
References: <20240226080433.3307154-1-sumit.garg@linaro.org>
 <20240226080433.3307154-6-sumit.garg@linaro.org>
 <CAHCN7x+wwoiLO_hpSkiHXFmAUwa0bhbYeQD_UHK10e2YOX+WKA@mail.gmail.com>
 <CAFA6WYNJ4BVHOFftSdwdMv2SMJ8ZQh3S7CRjJHfiAnosSbmgGQ@mail.gmail.com>
 <CAFA6WYPNsRsWnFLVcMXX_KxmN2YTbysu_ZPan1jyrVASrS==rQ@mail.gmail.com>
 <CAHCN7xLqKdydxRVfdVJ2RmS+=tdQT3fR52uVMhLEoZSoObcq3Q@mail.gmail.com>
 <CAHCN7x+fgQ0woDyaV1R2W28Sjs3Tahq=BuQQ7AE_df8BGpoBnw@mail.gmail.com>
In-Reply-To: <CAHCN7x+fgQ0woDyaV1R2W28Sjs3Tahq=BuQQ7AE_df8BGpoBnw@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 6 Mar 2024 09:26:02 -0800
Message-ID: <CAJ+vNU0DrrU4sZZi06jGQVCsaBznc4sMJtraJAu0KdkHXubU+w@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] phy: phy-imx8m-pcie: Add support for i.MX8M{M/P}
 PCIe PHY
To: Adam Ford <aford173@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
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

On Tue, Mar 5, 2024 at 4:47=E2=80=AFPM Adam Ford <aford173@gmail.com> wrote=
:
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
>
> I'll investigate a bit more and let you know if I make any progress.
>

Adam and Sumit,

In case it helps this series works for PCI bus scanning for the
imx8mp-venice-* boards with the following patch:
diff --git a/configs/imx8mp_venice_defconfig b/configs/imx8mp_venice_defcon=
fig
index 11b356b77856..ff7ea9811ed6 100644
--- a/configs/imx8mp_venice_defconfig
+++ b/configs/imx8mp_venice_defconfig
@@ -12,6 +12,7 @@ CONFIG_DEFAULT_DEVICE_TREE=3D"imx8mp-venice"
 CONFIG_SPL_TEXT_BASE=3D0x920000
 CONFIG_TARGET_IMX8MP_VENICE=3Dy
 CONFIG_OF_LIBFDT_OVERLAY=3Dy
+CONFIG_DM_RESET=3Dy
 CONFIG_SYS_MONITOR_LEN=3D524288
 CONFIG_SPL_MMC=3Dy
 CONFIG_SPL_SERIAL=3Dy
@@ -21,6 +22,7 @@ CONFIG_SPL=3Dy
 CONFIG_ENV_OFFSET_REDUND=3D0x3f8000
 CONFIG_SPL_IMX_ROMAPI_LOADADDR=3D0x48000000
 CONFIG_SYS_LOAD_ADDR=3D0x40480000
+CONFIG_PCI=3Dy
 CONFIG_SYS_MEMTEST_START=3D0x40000000
 CONFIG_SYS_MEMTEST_END=3D0x80000000
 CONFIG_LTO=3Dy
@@ -65,6 +67,7 @@ CONFIG_CMD_FUSE=3Dy
 CONFIG_CMD_GPIO=3Dy
 CONFIG_CMD_I2C=3Dy
 CONFIG_CMD_MMC=3Dy
+CONFIG_CMD_PCI=3Dy
 CONFIG_CMD_USB=3Dy
 CONFIG_SYS_DISABLE_AUTOLOAD=3Dy
 CONFIG_CMD_CACHE=3Dy
@@ -86,6 +89,8 @@ CONFIG_NET_RANDOM_ETHADDR=3Dy
 CONFIG_IP_DEFRAG=3Dy
 CONFIG_TFTP_BLOCKSIZE=3D4096
 CONFIG_SPL_DM=3Dy
+CONFIG_REGMAP=3Dy
+CONFIG_SYSCON=3Dy
 CONFIG_CLK_COMPOSITE_CCF=3Dy
 CONFIG_CLK_IMX8MP=3Dy
 CONFIG_GPIO_HOG=3Dy
@@ -114,7 +119,10 @@ CONFIG_FEC_MXC=3Dy
 CONFIG_KSZ9477=3Dy
 CONFIG_RGMII=3Dy
 CONFIG_MII=3Dy
+CONFIG_NVME_PCI=3Dy
+CONFIG_PCIE_DW_IMX=3Dy
 CONFIG_PHY_IMX8MQ_USB=3Dy
+CONFIG_PHY_IMX8M_PCIE=3Dy
 CONFIG_PINCTRL=3Dy
 CONFIG_SPL_PINCTRL=3Dy
 CONFIG_PINCTRL_IMX8M=3Dy

on an imx8mp-venice-gw71xx-2x (imx8mp with miniPCIe socket using a
miniPCIe to NVMe adapter)
u-boot=3D> pci enum
PCIE-0: Link up (Gen1-x1, Bus0)
u-boot=3D> pci
BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
_____________________________________________________________
00.00.00   0x16c3     0xabcd     Bridge device           0x04
01.00.00   0x10ec     0x5765     Mass storage controller 0x08
u-boot=3D> nvme scan
u-boot=3D> nvme info
Device 0: Vendor: 0x10ec Rev: 0426-D00 Prod: 60272-0005
            Type: Hard Disk
            Capacity: 57241.8 MB =3D 55.9 GB (117231408 x 512)

I also verified this works imx8mp-venice-gw74xx (imx8mp with PCIe
switch to multiple miniPCIe sockets using a miniPCIe to NVMe adapter)
u-boot=3D> pci enum
PCIE-0: Link up (Gen1-x1, Bus0)
u-boot=3D> pci
BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
_____________________________________________________________
00.00.00   0x16c3     0xabcd     Bridge device           0x04
01.00.00   0x12d8     0x2608     Bridge device           0x04
02.01.00   0x12d8     0x2608     Bridge device           0x04
02.02.00   0x12d8     0x2608     Bridge device           0x04
02.03.00   0x12d8     0x2608     Bridge device           0x04
02.04.00   0x12d8     0x2608     Bridge device           0x04
05.00.00   0x10ec     0x5765     Mass storage controller 0x08
u-boot=3D> nvme scan
u-boot=3D> nvme info
Device 0: Vendor: 0x10ec Rev: 0426-D00 Prod: 60272-0005
            Type: Hard Disk
            Capacity: 57241.8 MB =3D 55.9 GB (117231408 x 512)

It looks like the imx8mp-beacon-kit has almost the same setup as the
imx8mp-venice-gw74xx with the exception of you having a PCIe_nDIS gpio
defined in pinctrl (used nowhere) and the gw74xx does not support
CLKREQ so has 'fsl,clkreq-unsupported'.

tested-by: Tim Harvey <tharvey@gateworks.com> : imx8mp-venice*

Best regards,

Tim
