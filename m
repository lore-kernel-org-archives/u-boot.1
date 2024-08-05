Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABF4C3DA7F
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 07:05:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC27D88677;
	Mon,  5 Aug 2024 09:05:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="WbxfEYND";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31B1A88677; Mon,  5 Aug 2024 09:05:04 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07D0C880E6
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 09:05:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 200672027C;
 Mon,  5 Aug 2024 09:05:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1722841501;
 bh=Ql4Oml6YLXP4fNoEzuWQcBVoZxcBLcQdEtHwBFXMMr8=;
 h=Received:From:To:Subject;
 b=WbxfEYNDqs3oxyKPXKqgSoASdpcNwXt7cXR405rWHkUZmcCXaKHgin2wH40mklmeH
 yJf2mUs54pPXU+tLqKH59ecAyDKZgiPDnUFZaej07Vb/A8HHqZ0nZO7L2ZFCEhSrce
 gZ5YXL75fzb0ocppJqnVkmdAvk1xqtX/2GNyskwF6AZGpaDB5GmcdsXwfUFm0s+RAb
 An1D6EZpasqaOZUJHa0kErRECvlaBqluPzYqWAGWaUF1NrK+3JLQxrh5x2ZDh+DsEU
 D+fNJshyLkWg+qSUsHZldNqrZtQV74kw0gL+32hk3JxK40/X8jksdR+QrrAsq39ICq
 yYdW+0e9Nb0Iw==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
 id B914C7F89E; Mon,  5 Aug 2024 09:05:00 +0200 (CEST)
Date: Mon, 5 Aug 2024 09:05:00 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, Tom Rini <trini@konsulko.com>,
 Jonas =?iso-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 Thierry Reding <treding@nvidia.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Fabio Estevam <festevam@gmail.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/1] board: tegra: convert tegra-based boards to text
 env
Message-ID: <ZrB5nBI3GLA--gPQ@gaggiata.pivistrello.it>
References: <20240801055738.7601-1-clamor95@gmail.com>
 <20240801055738.7601-2-clamor95@gmail.com>
 <20240805053157.GA7516@francesco-nb>
 <CAPVz0n1TQ=bzvEv3OW_k+sBYVx13oRH6Oc_yfrhjNoe5+ujgoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n1TQ=bzvEv3OW_k+sBYVx13oRH6Oc_yfrhjNoe5+ujgoA@mail.gmail.com>
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

On Mon, Aug 05, 2024 at 10:01:27AM +0300, Svyatoslav Ryhel wrote:
> пн, 5 серп. 2024 р. о 08:32 Francesco Dolcini <francesco@dolcini.it> пише:
> > On Thu, Aug 01, 2024 at 08:57:38AM +0300, Svyatoslav Ryhel wrote:
> > > Convert boards to use text based env. This is the first stage of
> > > conversion, common inclusions should be converted next.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  board/asus/grouper/grouper.env                | 15 +++
> > >  .../asus/transformer-t20/transformer-t20.env  | 16 ++++
> > >  .../transformer-t30/configs/tf600t.config     |  1 +
> > >  board/asus/transformer-t30/tf600t.env         | 16 ++++
> > >  .../asus/transformer-t30/transformer-t30.env  | 16 ++++
> > >  board/htc/endeavoru/endeavoru.env             | 13 +++
> > >  .../ideapad-yoga-11/ideapad-yoga-11.env       | 16 ++++
> > >  board/lg/x3-t30/configs/p880.config           |  1 +
> > >  board/lg/x3-t30/configs/p895.config           |  1 +
> > >  board/lg/x3-t30/p880.env                      | 14 +++
> > >  board/lg/x3-t30/p895.env                      | 13 +++
> > >  board/microsoft/surface-rt/surface-rt.env     | 14 +++
> > >  board/nvidia/cardhu/cardhu.env                |  2 +
> > >  board/nvidia/p2771-0000/p2771-0000.env        | 22 +++++
> > >  board/nvidia/p3450-0000/p3450-0000.env        |  7 ++
> > >  board/toradex/apalis-tk1/apalis_tk1.env       | 45 +++++++++
> > >  board/toradex/apalis_t30/apalis_t30.env       |  9 ++
> > >  board/toradex/colibri_t20/colibri_t20.env     |  3 +
> > >  board/toradex/colibri_t30/colibri_t30.env     |  9 ++
> > >  board/wexler/qc750/qc750.env                  | 14 +++
> > >  configs/apalis-tk1_defconfig                  |  1 +
> > >  configs/apalis_t30_defconfig                  |  1 +
> > >  configs/cardhu_defconfig                      |  1 +
> > >  configs/colibri_t20_defconfig                 |  1 +
> > >  configs/colibri_t30_defconfig                 |  1 +
> >
> > ...
> >
> > > diff --git a/board/toradex/apalis-tk1/apalis_tk1.env b/board/toradex/apalis-tk1/apalis_tk1.env
> > > new file mode 100644
> > > index 0000000000..90db361be3
> > > --- /dev/null
> > > +++ b/board/toradex/apalis-tk1/apalis_tk1.env
> > > @@ -0,0 +1,45 @@
> > > +/*
> > > + * Custom Distro Boot configuration:
> > > + * 1. 8bit SD port (MMC1)
> > > + * 2. 4bit SD port (MMC2)
> > > + * 3. eMMC (MMC0)
> > > + */
> > > +boot_targets=mmc1 mmc2 mmc0 usb pxe dhcp
> > > +
> > > +boot_file=zImage
> > > +boot_script_dhcp=boot.scr
> > > +console=ttyS0
> > > +defargs=lp0_vec=2064@0xf46ff000 core_edp_mv=1150 core_edp_ma=4000
> > > +     usb_port_owner_info=2 lane_owner_info=6 emc_max_dvfs=0
> > > +     user_debug=30 pcie_aspm=off
> > > +dfu_alt_info=apalis-tk1.img raw 0x0 0x500 mmcpart 1;
> > > +     boot part 0 1 mmcpart 0;
> > > +     rootfs part 0 2 mmcpart 0;
> > > +     zImage fat 0 1 mmcpart 0;
> > > +     tegra124-apalis-eval.dtb fat 0 1 mmcpart 0
> > > +fdt_board=eval
> > > +fdt_fixup=;
> > > +fdt_module=apalis-v1.2
> > > +uboot_hwpart=1
> > > +uboot_blk=0
> > > +set_blkcnt=setexpr blkcnt ${filesize} + 0x1ff &&
> > > +     setexpr blkcnt ${blkcnt} / 0x200
> > > +update_uboot=run set_blkcnt && mmc dev 0 ${uboot_hwpart} &&
> > > +     mmc write ${loadaddr} ${uboot_blk} ${blkcnt}
> > > +setethupdate=if env exists ethaddr; then; else setenv ethaddr
> > > +     00:14:2d:00:00:00; fi; pci enum && tftpboot ${loadaddr}
> > > +     flash_eth.img && source ${loadaddr}
> > > +setsdupdate=setenv interface mmc; setenv drive 1; mmc rescan;
> > > +     load ${interface} ${drive}:1 ${loadaddr} flash_blk.img
> > > +     || setenv drive 2; mmc rescan; load ${interface} ${drive}:1
> > > +     ${loadaddr} flash_blk.img &&
> > > +     source ${loadaddr}
> > > +setup=setenv setupargs igb_mac=${ethaddr}
> > > +     consoleblank=0 no_console_suspend=1 console=tty1
> > > +     console=${console},${baudrate}n8 debug_uartport=lsport,0
> > > +     ${memargs}
> > > +setupdate=run setsdupdate || run setusbupdate || run setethupdate
> > > +setusbupdate=usb start && setenv interface usb; setenv drive 0;
> > > +     load ${interface} ${drive}:1 ${loadaddr} flash_blk.img &&
> > > +     source ${loadaddr}
> > > +vidargs=fbcon=map:1
> >
> > ...
> >
> > > diff --git a/include/configs/apalis-tk1.h b/include/configs/apalis-tk1.h
> > > index 71d4727ca9..4c690a1785 100644
> > > --- a/include/configs/apalis-tk1.h
> > > +++ b/include/configs/apalis-tk1.h
> > > @@ -18,64 +18,6 @@
> > >  #define FDT_MODULE                   "apalis-v1.2"
> > >  #define FDT_MODULE_V1_0                      "apalis"
> > >
> > > -/*
> > > - * Custom Distro Boot configuration:
> > > - * 1. 8bit SD port (MMC1)
> > > - * 2. 4bit SD port (MMC2)
> > > - * 3. eMMC (MMC0)
> > > - */
> > > -#define BOOT_TARGET_DEVICES(func) \
> > > -     func(MMC, mmc, 1) \
> > > -     func(MMC, mmc, 2) \
> > > -     func(MMC, mmc, 0) \
> > > -     func(USB, usb, 0) \
> > > -     func(PXE, pxe, na) \
> > > -     func(DHCP, dhcp, na)
> > > -
> >
> > I do recall that to transition to text env file it was required to move
> > from standard boot to distroboot. Did I recall incorrectly?
> 
> Are you 100% sure? Have you tried?

No, I am not, but Simon in copy knows for sure.

What I am sure is that I mean migrating from distroboot to standard boot, the
opposite of what I wrote ...

Francesco


