Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C089C48BC4
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 07:52:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68F6C871A5;
	Fri, 23 Feb 2024 08:52:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="MyY9tiRN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C41CE871A5; Fri, 23 Feb 2024 08:52:27 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A744F8780E
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 08:52:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 5D0E11F8DC;
 Fri, 23 Feb 2024 08:52:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1708674727;
 bh=P4/ADDeFS+URuxn/Q8i5bMeucLk/kdPn6M+hcINEBxU=; h=From:To:Subject;
 b=MyY9tiRN53ru1bFCxqH68pWRdgubjdeuSUYe9TpzmPomh54TPM1cKAcXb9rl8Zx8G
 plHFtbZCGCiC7bfWPBRN0bRQaRJ+X5mcwyhRGM15trby9eXHwc+SwwxVcUav2GfDgQ
 RZtkCMBSPrFJI4hJZdwSrc9drii8Wh8H0jY9aYL67Aw7NusX6DWv54VAOrj2wUYQmM
 cGOl2EYbgy68MH+f6rdDAV8TWE+A0JbUY4e8ezhooPeDnHXH8lD7AvzxNMq3VHzgB2
 wRta/ey6FJL1Sit/Pc2BDT3OoO1xkbcLYeiQVtUtP1A+D7OOavUMit0i2YZvsMM25o
 Ntaqd0DcSsKjQ==
Date: Fri, 23 Feb 2024 08:52:02 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 marcel.ziswiler@toradex.com, trini@konsulko.com, lukma@denx.de,
 seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de,
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com,
 aford173@gmail.com, ilias.apalodimas@linaro.org,
 sahaj.sarup@linaro.org, fathi.boudra@linaro.org,
 remi.duraffort@linaro.org, daniel.thompson@linaro.org,
 Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 7/7] verdin-imx8mp_defconfig: Enable PCIe/NVMe support
Message-ID: <20240223075202.GA3700@francesco-nb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFA6WYNOb0HyTC3gC1FE+=A=foV4OdjXvRM25U_n5WO53rkV6Q@mail.gmail.com>
 <CAFA6WYNeenqPXtpbOi0ps8e6xfieq9U=XovqqCY1m+CYCNbDsw@mail.gmail.com>
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

On Wed, Feb 21, 2024 at 11:57:51AM +0530, Sumit Garg wrote:
> On Tue, 20 Feb 2024 at 21:02, Marek Vasut <marex@denx.de> wrote:
> > On 2/20/24 14:10, Sumit Garg wrote:
> > > Also, enable reset driver which is a prerequisite for PCIe support.
> > Commit message needs to be fixed.
> 
> Let me reiterate the header here too.
> 
>     Enable PCIe/NVMe support. Also, enable the reset driver which
>     is a prerequisite for PCIe support.

With the commit message improved ..

On Wed, Feb 21, 2024 at 11:59:10AM +0530, Sumit Garg wrote:
> On Tue, 20 Feb 2024 at 21:34, Fabio Estevam <festevam@gmail.com> wrote:
> > On Tue, Feb 20, 2024 at 10:51 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> > > diff --git a/configs/verdin-imx8mp_defconfig b/configs/verdin-imx8mp_defconfig
> > > index 22b8a334dfa..d8bd644322b 100644
> > > --- a/configs/verdin-imx8mp_defconfig
> > > +++ b/configs/verdin-imx8mp_defconfig
> > > @@ -185,3 +185,12 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
> > >  CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
> > >  CONFIG_IMX_WATCHDOG=y
> > >  CONFIG_HEXDUMP=y
> > > +CONFIG_DM_RESET=y
> > > +CONFIG_RESET_IMX=y
> > > +CONFIG_PCI=y
> > > +CONFIG_PCIE_DW_IMX8=y
> > > +CONFIG_PHY_IMX8M_PCIE=y
> > > +CONFIG_CMD_PCI=y
> > > +CONFIG_NVME=y
> > > +CONFIG_NVME_PCI=y
> > > +CONFIG_CMD_NVME=y
> >
> > Please don't group all these new config options at the end of the file.
> That sounds better, I will do that for v2.

... and this change, feel free to add in v2

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Francesco

