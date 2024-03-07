Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCAD8C54798
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 16:13:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 316F387B77;
	Thu,  7 Mar 2024 17:13:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks-com.20230601.gappssmtp.com header.i=@gateworks-com.20230601.gappssmtp.com header.b="XrvzC9zS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5544C87D16; Thu,  7 Mar 2024 17:13:33 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F0FA87DA0
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 17:13:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a44ad785a44so147734866b.3
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 08:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks-com.20230601.gappssmtp.com; s=20230601; t=1709828009; x=1710432809;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Ux4B6Ne1U9xXW+f+FyCqueED2C/l+4KB10kSMYpP5k=;
 b=XrvzC9zScsYQ6+W7Pw4ktY6TscjWiKSo5/03snrO1SqKfhfJYHPgDm85jwmyUt4ZX4
 C3pHXG9VRvOz+1LlAt4ype27YG/tVLEU+1dYb+bvWIaqVenIQEJ0jAijTzutFzRluyEx
 EwqGXgTKdbYGROrGHEZMuBIEURV4bVI4o4j/f0yTUQX2TrDWhYgoL29xlXy6TytQ9KcR
 e99SH0ufWoM7Vu//M/QRHPVsYrpeHpb8C5tt363mB+/EpOOKKqqZYIsO0/WCi4Ih5wsy
 nOFZ3nDhkVil7wcQQbGMZyh1J7ayj/3myEgbU4xJT23k8R5ujrnVJEupLkrNYQzhauWY
 HHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709828009; x=1710432809;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Ux4B6Ne1U9xXW+f+FyCqueED2C/l+4KB10kSMYpP5k=;
 b=JOTOJmY0keeZV1QebQoVnGLRMY8pU73kBSr2uOrsPCx69/N6oJXE4/WYTY51P2MXNM
 aGzpJL5Qgi0B4XRY88pGLDeDu/bn6P0ewWFZPrGwLaTTSTZOwy1gcZnjq5IDbUxyoAwZ
 JEsVE/PSjhRKBsjZNwlTXEMyQCobAshtxq1c9yCjwlEIU2crym/38jTJBksHU4475+zD
 EDpJxAB9xrtiYCOsGW1IgkkrqMdk8jtT0tn/wCHeh28lRQL4/SHCjdK7Vd4kltK5oyXC
 I4sctwjPZRmyKT8KfCK+L0GvqN8yvu2suQUv+ApzYGrEinQ9DEuP6VDna0TJKaFEwfyb
 S0TA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaENrwjX4tTWA7ofUyW2CMW/rvxyZiBDx2RWq5S5CuaIsZUf4OKoZs2WxKmLnb0cAxwJxfPAKD+m7bO/Ck0H6oUFFwkg==
X-Gm-Message-State: AOJu0YyGodgBQz3DoN3aKs26tHNfUv7388v9ou9k5hAn2WFQBVVM5zL9
 UyF5XzXUjG0wBQUGpxM/uI2zgvon9ToL7FybXNBNL8BMZEw7gfmF/BD1pTrM+puwMumUhAcSXtx
 QInepudA/OXmWRl8EiGZhs0tp22weyQVeC+5nxQ==
X-Google-Smtp-Source: AGHT+IH06xjtGwmYhkvOSAAgZ4r9ZXMSJ6EgrEPOb3ccXpyR+NAwpo/y0m6iJnGQTHdZ8VUfURJ/GF/46qbSOvs4mN0=
X-Received: by 2002:a17:906:ff53:b0:a43:f9ff:2571 with SMTP id
 zo19-20020a170906ff5300b00a43f9ff2571mr12806567ejb.45.1709828008771; Thu, 07
 Mar 2024 08:13:28 -0800 (PST)
MIME-Version: 1.0
References: <20240226080433.3307154-1-sumit.garg@linaro.org>
 <20240226080433.3307154-6-sumit.garg@linaro.org>
 <CAHCN7x+wwoiLO_hpSkiHXFmAUwa0bhbYeQD_UHK10e2YOX+WKA@mail.gmail.com>
 <CAFA6WYNJ4BVHOFftSdwdMv2SMJ8ZQh3S7CRjJHfiAnosSbmgGQ@mail.gmail.com>
 <CAFA6WYPNsRsWnFLVcMXX_KxmN2YTbysu_ZPan1jyrVASrS==rQ@mail.gmail.com>
 <CAHCN7xLqKdydxRVfdVJ2RmS+=tdQT3fR52uVMhLEoZSoObcq3Q@mail.gmail.com>
 <CAHCN7x+fgQ0woDyaV1R2W28Sjs3Tahq=BuQQ7AE_df8BGpoBnw@mail.gmail.com>
 <CAJ+vNU0DrrU4sZZi06jGQVCsaBznc4sMJtraJAu0KdkHXubU+w@mail.gmail.com>
 <CAFA6WYN7D2UmQ7WCBxsGbmo_QC2KRNgJ_n-4CqD2RFJbYVittg@mail.gmail.com>
In-Reply-To: <CAFA6WYN7D2UmQ7WCBxsGbmo_QC2KRNgJ_n-4CqD2RFJbYVittg@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 7 Mar 2024 08:13:17 -0800
Message-ID: <CAJ+vNU1oP9tk3nwJ-2i6FhRfq7ge21LTbKGED4LLNY=Wk2U4hg@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] phy: phy-imx8m-pcie: Add support for i.MX8M{M/P}
 PCIe PHY
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Adam Ford <aford173@gmail.com>, u-boot@lists.denx.de,
 marcel.ziswiler@toradex.com, 
 francesco@dolcini.it, trini@konsulko.com, lukma@denx.de, seanga2@gmail.com, 
 jh80.chung@samsung.com, festevam@denx.de, andrejs.cainikovs@toradex.com, 
 sjg@chromium.org, peng.fan@nxp.com, marex@denx.de, 
 ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org, fathi.boudra@linaro.org, 
 remi.duraffort@linaro.org, daniel.thompson@linaro.org
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

On Wed, Mar 6, 2024 at 10:35=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> On Wed, 6 Mar 2024 at 22:56, Tim Harvey <tharvey@gateworks.com> wrote:
> >
> > On Tue, Mar 5, 2024 at 4:47=E2=80=AFPM Adam Ford <aford173@gmail.com> w=
rote:
> > >
> > > On Tue, Mar 5, 2024 at 7:51=E2=80=AFAM Adam Ford <aford173@gmail.com>=
 wrote:
> > > >
> > > > On Tue, Mar 5, 2024 at 7:48=E2=80=AFAM Sumit Garg <sumit.garg@linar=
o.org> wrote:
> > > > >
> > > > > Hi Adam,
> > > > >
> > > > > On Wed, 28 Feb 2024 at 12:29, Sumit Garg <sumit.garg@linaro.org> =
wrote:
> > > > > >
> > > > > > Hi Adam,
> > > > > >
> > > > > > On Wed, 28 Feb 2024 at 04:42, Adam Ford <aford173@gmail.com> wr=
ote:
> > > > > > >
> > > > > > > On Mon, Feb 26, 2024 at 2:05=E2=80=AFAM Sumit Garg <sumit.gar=
g@linaro.org> wrote:
> > > > > > > >
> > > > > > > > Add initial support for i.MX8M{M/P} PCIe PHY. On i.MX8M{M/P=
} SoCs PCIe
> > > > > > > > PHY initialization moved to this standalone PHY driver.
> > > > > > > >
> > > > > > > > Inspired from counterpart Linux kernel v6.8-rc3 driver:
> > > > > > > > drivers/phy/freescale/phy-fsl-imx8m-pcie.c.
> > > > > > >
> > > > > > > I have a PCIe device that works just fine in Linux.  I have a=
pplied
> > > > > > > your series an enabled the same config options as you did alo=
ng with
> > > > > > > some others to resolve some build issues.
> > > > > > >
> > > > > > > Any ideas how to address:
> > > > > > >
> > > > > > > nxp_imx8_pcie_phy pcie-phy@32f00000: PHY: Failed to power on
> > > > > > > pcie-phy@32f00000: -110.
> > > > > > >
> > > > > > > My PHY node looks like this
> > > > > > >
> > > > > > > &pcie_phy {
> > > > > > >     fsl,refclk-pad-mode =3D <IMX8_PCIE_REFCLK_PAD_INPUT>;
> > > > > > >     clocks =3D <&pcie0_refclk>;
> > > > > > >     clock-names =3D "ref";
> > > > > > >     status =3D "okay";
> > > > > > > };
> > > > > > >
> > > > > > > The pcie_refcllk is defined as a 100MHz fixed clock in U-Boot=
.  clk
> > > > > > > dump shows it to be:
> > > > > > >
> > > > > > > 100000000            0        |-- clock-pcie
> > > > > > >
> > > > > >
> > > > > > I suppose that's an EVK board, try enabling MPCIE_3V3 regulator
> > > > > > required for EVK board via following patch:
> > > > > >
> > > > > > diff --git a/drivers/pci/pcie_dw_imx.c b/drivers/pci/pcie_dw_im=
x.c
> > > > > > index 7856823c9188..32fd2cb05d4b 100644
> > > > > > --- a/drivers/pci/pcie_dw_imx.c
> > > > > > +++ b/drivers/pci/pcie_dw_imx.c
> > > > > > @@ -17,6 +17,7 @@
> > > > > >  #include <linux/iopoll.h>
> > > > > >  #include <log.h>
> > > > > >  #include <pci.h>
> > > > > > +#include <power/regulator.h>
> > > > > >  #include <regmap.h>
> > > > > >  #include <reset.h>
> > > > > >  #include <syscon.h>
> > > > > > @@ -158,6 +159,8 @@ static int pcie_dw_imx_probe(struct udevice=
 *dev)
> > > > > >         struct pci_controller *hose =3D dev_get_uclass_priv(ctl=
r);
> > > > > >         int ret;
> > > > > >
> > > > > > +       regulator_autoset_by_name("MPCIE_3V3", NULL);
> > >
> > > I think you should search the device tree for "vpcie-supply" and
> > > enable the corresponding regulator, because is more flexible than
> > > hard-coding regulator names. This is also more of a standard practice=
.
> > >
> > > > > > +
> > > > > >         ret =3D imx_pcie_assert_core_reset(priv);
> > > > > >         if (ret) {
> > > > > >                 dev_err(dev, "failed to assert core reset\n");
> > > > > >
> > > > >
> > > > > Were you able to give a retry with the above diff?
> > > >
> > > > Not yet, but I'll try to do it tonight.
> > >
> > > That didn't work for me.  I am using a Beacon Embedded kit which does
> > > not use a regulator, so this had no impact, but I think having the
> > > vpcie-supply regulator is a good idea.
> > >
> > > I'll investigate a bit more and let you know if I make any progress.
> > >
> >
> > Adam and Sumit,
> >
> > In case it helps this series works for PCI bus scanning for the
> > imx8mp-venice-* boards with the following patch:
>
> Thanks Tim for taking time to test this series. I hope you are fine
> with me taking your below patch with you being the author.

Sumit,

Yes you can take that patch if you want to add it to your series - thanks!

Tim

>
> > diff --git a/configs/imx8mp_venice_defconfig b/configs/imx8mp_venice_de=
fconfig
> > index 11b356b77856..ff7ea9811ed6 100644
> > --- a/configs/imx8mp_venice_defconfig
> > +++ b/configs/imx8mp_venice_defconfig
> > @@ -12,6 +12,7 @@ CONFIG_DEFAULT_DEVICE_TREE=3D"imx8mp-venice"
> >  CONFIG_SPL_TEXT_BASE=3D0x920000
> >  CONFIG_TARGET_IMX8MP_VENICE=3Dy
> >  CONFIG_OF_LIBFDT_OVERLAY=3Dy
> > +CONFIG_DM_RESET=3Dy
> >  CONFIG_SYS_MONITOR_LEN=3D524288
> >  CONFIG_SPL_MMC=3Dy
> >  CONFIG_SPL_SERIAL=3Dy
> > @@ -21,6 +22,7 @@ CONFIG_SPL=3Dy
> >  CONFIG_ENV_OFFSET_REDUND=3D0x3f8000
> >  CONFIG_SPL_IMX_ROMAPI_LOADADDR=3D0x48000000
> >  CONFIG_SYS_LOAD_ADDR=3D0x40480000
> > +CONFIG_PCI=3Dy
> >  CONFIG_SYS_MEMTEST_START=3D0x40000000
> >  CONFIG_SYS_MEMTEST_END=3D0x80000000
> >  CONFIG_LTO=3Dy
> > @@ -65,6 +67,7 @@ CONFIG_CMD_FUSE=3Dy
> >  CONFIG_CMD_GPIO=3Dy
> >  CONFIG_CMD_I2C=3Dy
> >  CONFIG_CMD_MMC=3Dy
> > +CONFIG_CMD_PCI=3Dy
> >  CONFIG_CMD_USB=3Dy
> >  CONFIG_SYS_DISABLE_AUTOLOAD=3Dy
> >  CONFIG_CMD_CACHE=3Dy
> > @@ -86,6 +89,8 @@ CONFIG_NET_RANDOM_ETHADDR=3Dy
> >  CONFIG_IP_DEFRAG=3Dy
> >  CONFIG_TFTP_BLOCKSIZE=3D4096
> >  CONFIG_SPL_DM=3Dy
> > +CONFIG_REGMAP=3Dy
> > +CONFIG_SYSCON=3Dy
> >  CONFIG_CLK_COMPOSITE_CCF=3Dy
> >  CONFIG_CLK_IMX8MP=3Dy
> >  CONFIG_GPIO_HOG=3Dy
> > @@ -114,7 +119,10 @@ CONFIG_FEC_MXC=3Dy
> >  CONFIG_KSZ9477=3Dy
> >  CONFIG_RGMII=3Dy
> >  CONFIG_MII=3Dy
> > +CONFIG_NVME_PCI=3Dy
> > +CONFIG_PCIE_DW_IMX=3Dy
> >  CONFIG_PHY_IMX8MQ_USB=3Dy
> > +CONFIG_PHY_IMX8M_PCIE=3Dy
> >  CONFIG_PINCTRL=3Dy
> >  CONFIG_SPL_PINCTRL=3Dy
> >  CONFIG_PINCTRL_IMX8M=3Dy
> >
> > on an imx8mp-venice-gw71xx-2x (imx8mp with miniPCIe socket using a
> > miniPCIe to NVMe adapter)
> > u-boot=3D> pci enum
> > PCIE-0: Link up (Gen1-x1, Bus0)
> > u-boot=3D> pci
> > BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
> > _____________________________________________________________
> > 00.00.00   0x16c3     0xabcd     Bridge device           0x04
> > 01.00.00   0x10ec     0x5765     Mass storage controller 0x08
> > u-boot=3D> nvme scan
> > u-boot=3D> nvme info
> > Device 0: Vendor: 0x10ec Rev: 0426-D00 Prod: 60272-0005
> >             Type: Hard Disk
> >             Capacity: 57241.8 MB =3D 55.9 GB (117231408 x 512)
> >
> > I also verified this works imx8mp-venice-gw74xx (imx8mp with PCIe
> > switch to multiple miniPCIe sockets using a miniPCIe to NVMe adapter)
> > u-boot=3D> pci enum
> > PCIE-0: Link up (Gen1-x1, Bus0)
> > u-boot=3D> pci
> > BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
> > _____________________________________________________________
> > 00.00.00   0x16c3     0xabcd     Bridge device           0x04
> > 01.00.00   0x12d8     0x2608     Bridge device           0x04
> > 02.01.00   0x12d8     0x2608     Bridge device           0x04
> > 02.02.00   0x12d8     0x2608     Bridge device           0x04
> > 02.03.00   0x12d8     0x2608     Bridge device           0x04
> > 02.04.00   0x12d8     0x2608     Bridge device           0x04
> > 05.00.00   0x10ec     0x5765     Mass storage controller 0x08
> > u-boot=3D> nvme scan
> > u-boot=3D> nvme info
> > Device 0: Vendor: 0x10ec Rev: 0426-D00 Prod: 60272-0005
> >             Type: Hard Disk
> >             Capacity: 57241.8 MB =3D 55.9 GB (117231408 x 512)
> >
> > It looks like the imx8mp-beacon-kit has almost the same setup as the
> > imx8mp-venice-gw74xx with the exception of you having a PCIe_nDIS gpio
> > defined in pinctrl (used nowhere) and the gw74xx does not support
> > CLKREQ so has 'fsl,clkreq-unsupported'.
>
> Ah, I see. So it turns out that it's Adam Linux kernel DTS patch [1]
> which is missing for U-Boot DTS. This is one of the reasons why we
> should switch to OF_UPSTREAM to start regular sync with Linux kernel
> DTS.
>
> Adam,
>
> Can you make corresponding changes to U-Boot DTS for
> imx8mp-beacon-kit? Or better just switch to OF_UPSTREAM instead?
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/arch/arm64?id=3D63c46b51c7995d8aeb4b44493633f4ce1dcf62bc
>
> >
> > tested-by: Tim Harvey <tharvey@gateworks.com> : imx8mp-venice*
> >
>
> Thanks again.
>
> -Sumit
>
> > Best regards,
> >
> > Tim
