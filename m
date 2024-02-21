Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B3E8C48BF6
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 14:31:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7AE787E30;
	Wed, 21 Feb 2024 15:31:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="kL4SyUle";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB85187C86; Wed, 21 Feb 2024 15:31:41 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D240288021
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 15:31:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
 by mail11.truemail.it (Postfix) with ESMTPA id 8AB821FE32;
 Wed, 21 Feb 2024 15:31:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1708525891;
 bh=4IPJcR5Sn9EnpGDHmqgLxa7gk/d2ugqjYtDZ9qTpgsA=; h=From:To:Subject;
 b=kL4SyUle28p4sWasFpeKVAY/xDihew1wwpF9sN92CVnrEddDDRB9SF2L82hVc1U1h
 TGm2g7FB/YKri5rk2y67EVsLFmcTx5zIPbiOpgBdUCjrvvehRIwa5S5si6j6t7WBd+
 vsUTBsAWA3hiSnkzWm5V/BDhXsCjGISu+ShQqImrtwN4gEz7XxZMSvelO8PM6tBEza
 p88E3h8Fuhr4i2hVzUdexL+iPEtlECl9JV7WSx1nX4OpxcGPbDGTXNcd53qgrs5d1s
 t2OBdBlrLhGcL1a865zOmIwd1qd8equtqeUR09vtnqxUXt2V1X9f3QUgOElxQSX/lw
 tXJVaeAkFCAFw==
Date: Wed, 21 Feb 2024 15:31:19 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 "sumit.garg@linaro.org" <sumit.garg@linaro.org>
Cc: "francesco@dolcini.it" <francesco@dolcini.it>,
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
 "sahaj.sarup@linaro.org" <sahaj.sarup@linaro.org>,
 "peng.fan@nxp.com" <peng.fan@nxp.com>,
 "remi.duraffort@linaro.org" <remi.duraffort@linaro.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "trini@konsulko.com" <trini@konsulko.com>, "marex@denx.de" <marex@denx.de>,
 "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
 "lukma@denx.de" <lukma@denx.de>, "aford173@gmail.com" <aford173@gmail.com>,
 "seanga2@gmail.com" <seanga2@gmail.com>,
 "festevam@denx.de" <festevam@denx.de>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "sjg@chromium.org" <sjg@chromium.org>,
 "fathi.boudra@linaro.org" <fathi.boudra@linaro.org>
Subject: Re: [PATCH 7/7] verdin-imx8mp_defconfig: Enable PCIe/NVMe support
Message-ID: <20240221143119.GA9552@francesco-nb>
References: <20240220131056.2962331-1-sumit.garg@linaro.org>
 <20240220131056.2962331-8-sumit.garg@linaro.org>
 <20240221075516.GA5131@francesco-nb>
 <fba9ba00b218a9c0c9be4958b2f08f1dee3e7a15.camel@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fba9ba00b218a9c0c9be4958b2f08f1dee3e7a15.camel@toradex.com>
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

On Wed, Feb 21, 2024 at 09:18:51AM +0000, Marcel Ziswiler wrote:
> On Wed, 2024-02-21 at 08:55 +0100, Francesco Dolcini wrote:
> > On Tue, Feb 20, 2024 at 06:40:56PM +0530, Sumit Garg wrote:
> > > Also, enable reset driver which is a prerequisite for PCIe support.
> > > 
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > ---
> > >  configs/verdin-imx8mp_defconfig | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/configs/verdin-imx8mp_defconfig b/configs/verdin-imx8mp_defconfig
> > > index 22b8a334dfa..d8bd644322b 100644
> > > --- a/configs/verdin-imx8mp_defconfig
> > > +++ b/configs/verdin-imx8mp_defconfig
> > > @@ -185,3 +185,12 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
> > >  CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
> > >  CONFIG_IMX_WATCHDOG=y
> > >  CONFIG_HEXDUMP=y
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
> > This will increase the u-boot proper size
> 
> Yes, I checked and it is actually slightly more than 32 K.
> 
> > and marginally increase the
> > boot time (because of a bigger binary to be read from the eMMC).
> 
> That was also my concern.
> 
> > Apart of that do you expect any other impact on those changes? SPL
> > binary size should not be affected, correct?
> > 
> > Asking this out loudly to confirm that nothing unexpected is going to
> > happen because of these changes.
> 
> Other than that I actually gave it a quick try and PCIe/NVMe does indeed work and the regular boot is not
> affected (other than the slight size and boot time increase, of course).
> 
> > For my curiosity, care to share what's the use case? Do you plan to have
> > the OS stored into an NVME device?
> 
> For us the question is basically whether that use case does mandate
> enforcing such changes for each and every customer. Plus the regular
> expected maintenance effort any such change brings with it, of course.

Marcel, given all you wrote here I would personally be fine
on having this enabled in the verdin_imx8mp defconfig.

What's your idea? Are you good with it?

Francesco

