Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C74BC369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 15:03:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC97D8209C;
	Tue, 15 Apr 2025 17:03:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="UeBB2jbv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96A9081F54; Tue, 15 Apr 2025 17:03:52 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B74881F54
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 17:03:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
 by mail11.truemail.it (Postfix) with ESMTPA id CF4B21FA7C;
 Tue, 15 Apr 2025 17:03:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1744729429;
 bh=0P7N/P8yxM6BdxJZRKyUQ/sa2hgRq93fLuAVRN8jeUA=; h=From:To:Subject;
 b=UeBB2jbvCL+LFUBSfd0gRX8ovtBjEFXUYRRWtY5QoaTbev99YnPFjabzxkANl6WbA
 Yr5X8U/NqPpOPXEY9tG2oboCApWeBrhntI79BIfjUh7v2dAWqh+U/vkJ0UfHFgiWgQ
 nJjuPdwldoEYLUxFa2KXNtDWI+BEZEo1uh44PBgKym8SCBHN0164r2r9NH6ZF3W/Ji
 Fb2+i0bD//Z9kcZwPuxL5aC1WbwPUPN0UVY0qnoFaFLQwDekw5GUj8JAZyJpmdsn1X
 sIaHQMYEGW+g1KPeaG5r0sdwo0MdaDqHJcKZ2BvUzIdPTManRik5HBucw7uYsBpfiL
 thC2blGBk+Wjw==
Date: Tue, 15 Apr 2025 17:03:44 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Adam Ford <aford173@gmail.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, Marek Vasut <marex@denx.de>,
 Fabio Estevam <festevam@denx.de>, u-boot@lists.denx.de,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: Re: [REGRESSION] Re: [PATCH v2 16/24] clk: imx: Convert clock-osc-*
 back to osc_*
Message-ID: <20250415150344.GA246483@francesco-nb>
References: <20250323160107.145749-1-marex@denx.de>
 <20250323160107.145749-17-marex@denx.de>
 <20250415142846.GA244333@francesco-nb>
 <CAHCN7xLa5W-AtRso6RUZwZG_sfDm9CHierfzt_WfOqFjSGJZoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHCN7xLa5W-AtRso6RUZwZG_sfDm9CHierfzt_WfOqFjSGJZoA@mail.gmail.com>
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

On Tue, Apr 15, 2025 at 09:43:12AM -0500, Adam Ford wrote:
> On Tue, Apr 15, 2025 at 9:28 AM Francesco Dolcini <francesco@dolcini.it> wrote:
> >
> > Hello Marex, Fabio, all
> >
> > On Sun, Mar 23, 2025 at 04:58:45PM +0100, Marek Vasut wrote:
> > > Convert clock-osc-24m back to osc_24m and clock-osc-32k back to osc_32k.
> > > These are the clock which match clock tables in Linux. This is now
> > > possible because the clock drivers now resolve clock names based on
> > > clock-names DT property in the CCM DT node.
> > >
> > > Signed-off-by: Marek Vasut <marex@denx.de>
> >
> > Current USB fastboot functionality from U-Boot proper in master is broken
> > on Verdin iMX8M Plus since commit b4734c9c333b ("clk: imx: Convert
> > clock-osc-* back to osc_*"). Other i.MX SoCs might be affected, I have
> > not looked into every detail.
> >
> >   Could not fetch index
> >   Failed to get PHY0 for usb@38100000
> >   Could not fetch index
> >   Failed to get PHY0 for usb@38100000
> >   No USB device found
> >   USB init failed: -19
> >
> > Reverting this commit on top of master is not trivial (there are
> > conflicts, and I have not looked into the details).
> >
> > Full log for reference
> >
> >   U-Boot SPL 2025.04-rc4-00537-gb4734c9c333b (Apr 15 2025 - 16:14:09 +0200)
> >   Training FAILED
> >   DDR configured as single rank
> >   WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
> >   SEC0:  RNG instantiated
> >   Normal Boot
> >   Trying to boot from BOOTROM
> >   Boot Stage: USB boot
> >   Find img info 0x4802ec00, size 1116
> >   Need continue download 1024
> >   NOTICE:  Do not release JR0 to NS as it can be used by HAB
> >   NOTICE:  BL31: v2.12.0(release):v2.12.0-946-g4d913df8f85e
> >   NOTICE:  BL31: Built : 13:19:07, Apr 15 2025
> >
> >
> >   U-Boot 2025.04-rc4-00537-gb4734c9c333b (Apr 15 2025 - 16:14:09 +0200)
> >
> >   CPU:   Freescale i.MX8MP[8] rev1.1 1600 MHz (running at 1200 MHz)
> >   CPU:   Industrial temperature grade (-40C to 105C) at 56C
> >   Reset cause: POR
> >   DRAM:  4 GiB
> >   Core:  309 devices, 31 uclasses, devicetree: separate
> >   WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
> >   MMC:   FSL_SDHC: 1, FSL_SDHC: 2
> >   Loading Environment from nowhere... OK
> >   In:    serial@30880000
> >   Out:   serial@30880000
> >   Err:   serial@30880000
> >   Model: Toradex 0058 Verdin iMX8M Plus Quad 4GB WB IT V1.0B
> >   Serial#: 06849144
> >   Carrier: Toradex Dahlia V1.1A, Serial# 10763256
> >   SEC0:  RNG instantiated
> >   Setting variant to wifi
> >   Net:   pca953x gpio-expander@21: Error reading output register
> >   eth1: ethernet@30be0000, eth0: ethernet@30bf0000 [PRIME]
> >   Hit any key to stop autoboot:  0
> >   Could not fetch index
> >   Failed to get PHY0 for usb@38100000
> >   Could not fetch index
> >   Failed to get PHY0 for usb@38100000
> 
> When running my 8M Plus in Host mode, I got similar "Failed to get
> PHY0 for usb" failures, but I hadn't yet bisected it.  The PHY itself
> doesn't appear to have a clock reference itself, but it does reference
> a power-domain which uses multiple clocks. I wonder if one of the
> clocks in the hsio power domain isn't registering properly.   I won't
> be near my 8MP until much later tonight, but can you run 'dm tree' to
> see what clocks are enumerated and which might be missing?

Here the logs,
https://gist.github.com/dolcini/035ede9e94026c8f7f34e64ee07e124b

commit bcb141d11428 ("clk: imx: Pass struct udevice into
imx_clk_composite*()") is the last good, commit b4734c9c333b ("clk: imx:
Convert clock-osc-* back to osc_*") is the first bad.

Francesco




