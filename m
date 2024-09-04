Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE63CD4F4A
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 23:44:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ED8588C24;
	Thu,  5 Sep 2024 01:44:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="d8jZ/VQK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78C1D88BFA; Thu,  5 Sep 2024 01:44:41 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 532C488B6A
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 01:44:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 9D97B1FA00;
 Thu,  5 Sep 2024 01:44:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1725493478;
 bh=tEU1lab1orMM8n1Bgd0S4necrYxWondX4SlDLGFyBs8=;
 h=Received:From:To:Subject;
 b=d8jZ/VQK6swQjVeJmagSC+DZEwpPc8BALAoBrn/dHxxBHJWkvM0uOA+bPDKbLV6D3
 EF3kflMVNN5yyG36dgoUnQI/KWXYQScYRbAYls7PLVVsfmzBqqEPZgjGc+xi+9sW0U
 ZWotIQ51d/9UXO8j1cnkf52twU8Rdb2ScqXe8jbremrxSy8ogcWgWf0qf/OR4LGr+y
 juev/Zq6TDN+4i2GPn5kg7fBYPRUSDOg3W9h0DYFP2ZWrQtYBgPRdmcqpvuKVHGQjl
 lhdLqjiay1+6LHyuv4EOcSVC85pMv2d+XpnUlYHV/NfrXhJKhAdh6/QR4C7F+4l+th
 p88+BR/7Wz4YA==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
 id D62AE7F918; Thu,  5 Sep 2024 01:44:37 +0200 (CEST)
Date: Thu, 5 Sep 2024 01:44:37 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Tom Rini <trini@konsulko.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
 Hiago De Franco <hiagofranco@gmail.com>, Keerthy <j-keerthy@ti.com>,
 Amjad Ouled-Ameur <aouledameur@baylibre.com>, u-boot@lists.denx.de,
 Hiago De Franco <hiago.franco@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH] fs: Fix SPL build if SPL_FS_LOADER is enabled and
 FS_LOADER is disabled
Message-ID: <Ztjw5bGI0RKpAIVP@gaggiata.pivistrello.it>
References: <20240826181933.252020-1-hiagofranco@gmail.com>
 <20240830205119.GA3268574@bill-the-cat>
 <20240831134911.GA32220@francesco-nb>
 <20240904212721.GZ2479150@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904212721.GZ2479150@bill-the-cat>
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

Hello Tom,

On Wed, Sep 04, 2024 at 03:27:21PM -0600, Tom Rini wrote:
> On Sat, Aug 31, 2024 at 03:49:11PM +0200, Francesco Dolcini wrote:
> > On Fri, Aug 30, 2024 at 02:51:19PM -0600, Tom Rini wrote:
> > > On Mon, Aug 26, 2024 at 03:19:33PM -0300, Hiago De Franco wrote:
> > > 
> > > > From: Hiago De Franco <hiago.franco@toradex.com>
> > > > 
> > > > When SPL_FS_LOADER is set to y and FS_LOADER is not enabled, the SPL build
> > > > fails with the following errors:
> > > > 
> > > >   AR      spl/boot/built-in.o
> > > >   LD      spl/u-boot-spl
> > > > arm-none-linux-gnueabihf-ld.bfd: drivers/misc/fs_loader.o: in function
> > > > `fw_get_filesystem_firmware':
> > > > /u-boot/drivers/misc/fs_loader.c:162: undefined reference to
> > > > `fs_set_blk_dev'
> > > > arm-none-linux-gnueabihf-ld.bfd: /home/frh/tdx/src/u-boot/drivers/misc/
> > > > fs_loader.c:185: undefined reference to `fs_read'
> > > > arm-none-linux-gnueabihf-ld.bfd: drivers/misc/fs_loader.o: in function
> > > > `select_fs_dev':
> > > > /u-boot/drivers/misc/fs_loader.c:89: undefined reference to
> > > > `fs_set_blk_dev_with_part'
> > > > make[1]: *** [scripts/Makefile.spl:527: spl/u-boot-spl] Error 1
> > > > make: *** [Makefile:2055: spl/u-boot-spl] Error 2
> > > > 
> > > > Fix it by replacing the FS_LOADER with SPL_FS_LOADER in the Makefile, so
> > > > the fs.c with the necessary function definitions are compiled.
> > > > 
> > > > Fixes: b071a07743d4 ("drivers: misc: Makefile: Enable fs_loader compilation at SPL Level")
> > > > Suggested-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > > Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
> > > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > > 
> > > This leads to failure to build on sandbox_noinst_defconfig.
> > 
> > --- a/drivers/block/Kconfig
> > +++ b/drivers/block/Kconfig
> > @@ -110,6 +110,7 @@ config EFI_MEDIA
> >  config SPL_BLK_FS
> >         bool "Load images from filesystems on block devices"
> >         depends on SPL_BLK
> > +       select SPL_FS_LOADER
> >         help
> >           Use generic support to load images from fat/ext filesystems on
> >           different types of block devices such as NVMe.
> > 
> > 
> > ?
> 
> I think "depends on" and sandbox_noinst_defconfig should enable
> CONFIG_SPL_FS_LOADER too.

What do you mean?

The change I proposed fixes the issue you reported with sandbox_noinst_defconfig and I
think is the right solution. Are you ok with that or are you proposing to just
change sandbox_noinst_defconfig enabling CONFIG_SPL_FS_LOADER explicitly?

Francesco

