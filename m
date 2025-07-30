Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69380C87FC9
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 10:20:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B228081E13;
	Wed, 30 Jul 2025 12:20:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D3AF801DD; Wed, 30 Jul 2025 12:20:07 +0200 (CEST)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95225803CC
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 12:20:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.98.2) (envelope-from <daniel@makrotopia.org>)
 id 1uh3ul-0000000066h-3LvO; Wed, 30 Jul 2025 10:20:03 +0000
Date: Wed, 30 Jul 2025 11:19:55 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Roy Walker <roy.walker777@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: MT7621 help
Message-ID: <aInxy53WpORP46N2@pidgin.makrotopia.org>
References: <CAD-tQfVy8CqKGeeWXJaR1HoC9DMrZZ2Ynq1UkYt-0pxkt4oS5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD-tQfVy8CqKGeeWXJaR1HoC9DMrZZ2Ynq1UkYt-0pxkt4oS5w@mail.gmail.com>
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

Hi Roy,

On Tue, Jul 29, 2025 at 09:44:29PM -0500, Roy Walker wrote:
> I was attempting to put OpenWRT on a TP-Link Festa F61.  I messed up and
> wiped out the u-boot image.  I am trying to build a new u-boot image and
> ymodem it there.  Followed the exact steps here:
> https://docs.u-boot.org/en/stable/board/mediatek/mt7621.html.
> 
> When it boots I get this and it hangs:
> 
> U-Boot 2025.07-00889-gbd0ade7d090a (Jul 22 2025 - 16:25:47 -0500)
> 
> CPU:   MediaTek MT7621A ver 1, eco 3
> Boot:  DDR3, SPI-NOR 3-Byte Addr
> Clock: CPU: 880MHz, DDR: 1200MT/s, Bus: 220MHz, XTAL: 40MHz
> Model: MediaTek MT7621 RFB (SPI-NOR)
> DRAM:

Unless you are using the _noprint.bin you should see lots of output of the
DRAM calibration before U-Boot launches. That would be interesting to see,
as it will tell the results of the DRAM calibration and if anything went
wrong at that stage. If you are using OpenWrt to build U-Boot you can
enable the debug output by setting CONFIG_DEBUG=y in OpenWrt's main
.config file.

Note that there are some U-Boot Kconfig options to tune DRAM calibration,
see for example MT7621_DRAM_DDR3_2048M. I think, however, the default
should be fine for 256MB or DDR3.

Also, as your board seems to use SPI-NOR flash, make sure to *not*
select CONFIG_MT7621_BOOT_FROM_NAND or CONFIG_BOARD_MT7621_NAND_RFB.

> Is this a newer version of the MT7621 that is not compatible?  Maybe a
> different DRAM binary is needed?  Here is a link with DMESG and boot logs -
> https://forum.openwrt.org/t/support-for-tp-link-festa-f61-v1-6/236744/3.

There is an U-Boot build done using OpenWrt's toolchain and build-system
as well, and I've tried that also on newer MT7621A boards without
encountering the issue you describe. See package/boot/uboot-mediatek
in OpenWrt's tree.

