Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8395FCE8D61
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 09:36:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A115189122;
	Thu, 19 Sep 2024 11:36:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=agner.ch header.i=@agner.ch header.b="uo6R7pO1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A7C089126; Thu, 19 Sep 2024 11:36:07 +0200 (CEST)
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21FD089121
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 11:36:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=stefan@agner.ch
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
 by mail.kmu-office.ch (Postfix) with ESMTPSA id 5C05C5CB398;
 Thu, 19 Sep 2024 11:36:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
 t=1726738562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hZFuVGyS+tmdwb/zpgze/hW9hPj885EMtaRXUhsD/VM=;
 b=uo6R7pO1Xr1Co3WxC3wVqBfvuSonXpfzJPhaw493aWV4DdY3lPVdO3VSykkITaCcBrnPeo
 k2nfnVfq3YpskBiAZudEByqel2aQiX66H1SngKHW6n2f+/qBVXTa9JjXh3FdqqysguaX7c
 pkIlS8X72RimiAK2UlVrq1zDkBB2lJ4=
MIME-Version: 1.0
Date: Thu, 19 Sep 2024 11:36:01 +0200
From: Stefan Agner <stefan@agner.ch>
To: "Ivan T. Ivanov" <iivanov@suse.de>
Cc: Matthias Brugger <mbrugger@suse.com>, Peter Robinson
 <pbrobinson@gmail.com>, Dmitry Malkin <dmitry@bedrocksystems.com>, Thomas
 Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>, Jaehoon
 Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 wahrenst@gmx.net, florian.fainelli@broadcom.com, u-boot@lists.denx.de,
 =?UTF-8?Q?Jan_=C4=8Cerm=C3=A1k?= <sairon@sairon.cz>
Subject: Re: [PATCH v4 0/6] rpi5: initial support
In-Reply-To: <20240110122908.31612-1-iivanov@suse.de>
References: <20240110122908.31612-1-iivanov@suse.de>
Message-ID: <9943877347134e40cee8c0d9cc7f641c@agner.ch>
X-Sender: stefan@agner.ch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

Hi Ivan,

I am looking into enabling NVMe boot support using U-Boot on Raspberry
Pi 5. Which brings me to some questions wrt PCIe support (see below).

On 2024-01-10 13:29, Ivan T. Ivanov wrote:
> Hi,
> 
> These patches are slight update for patches posted earlier here[1].
> They are adding basic support for RPi5 and are based on v2 series
> from Dmitry Malkin[2].
> 
> What changed:
> 
> * Initial memory map now includes whole first 1GB of DRAM. At runtime,
>   the firmware will adjust this size depending on whether an HDMI cable
>   is plugged in or not. If there is HDMI monitor connected it will reserve
>   framebufer memory region and will add simple-framebuffer device into
>   devicetree.
> 
> * Dynamically calculate bits per pixel in video driver. This works
>   on all prevous RPi's models that I have.
> 
> * I am dropping PCIe patch for now. I made some progress on porting changes
>   from vendor Linux tree to U-Boot. Unfortunatly testing it is little bit
>   tricky. They are many devices behind PCIe, but more or less all of them
>   requires missing either "reset-controller" or "clock-controller" or
>   "pin-controller" drivers. I was able to probe "cdns,macb" device, but
>   access to ethernet PHY over MDIO bus is stucking. Then I ported
>   "raspberrypi,rp1-adc" driver from vendor Linux tree, but it requires
>   missing clock. And on top of that machine that I used for developing this
>   crashed and I lost my PCIe changes :-|. Anyway.

Have you tried using a M.2 HAT? This likely won't require much in terms
of enabling the device.

You write that you made some progress, is that compared to v3? Do you
mind sharing the latest version of your patches?

Best regards,
Stefan

> 
> These patches allows me to boot current openSUSE Tumbleweed without
> modification. I can see serial console log and boot process on HDMI
> connected monitor.
> 
> I think these patches should be enough for start. Please consider for
> inclusion.
> 
> Thanks,
> Ivan
> 
> [1] https://lore.kernel.org/all/20231218210341.30073-1-iivanov@suse.de/
> [2] https://lore.kernel.org/all/CAKRNjQ0dsWozGo4n8g58m4cCEk3n=qx1R+L24WBgpo-iP1yo7A@mail.gmail.com/
> 
> Dmitry Malkin (2):
>   rpi5: add initial memory map for bcm2712
>   rpi5: Use devicetree as alternative way to read IO base addresses
> 
> Ivan T. Ivanov (4):
>   rpi5: Use devicetree to retrieve board revision
>   bcm2835: Dynamically calculate bytes per pixel parameter
>   mmc: bcmstb: Add support for bcm2712 SD controller
>   configs: rpi_arm64: enable SDHCI BCMSTB driver
> 
>  arch/arm/mach-bcm283x/include/mach/base.h  |   5 +-
>  arch/arm/mach-bcm283x/include/mach/mbox.h  |   3 +-
>  arch/arm/mach-bcm283x/include/mach/sdhci.h |   3 +-
>  arch/arm/mach-bcm283x/include/mach/timer.h |   3 +-
>  arch/arm/mach-bcm283x/include/mach/wdog.h  |   3 +-
>  arch/arm/mach-bcm283x/init.c               |  74 ++++++++-
>  board/raspberrypi/rpi/rpi.c                |  22 ++-
>  configs/rpi_arm64_defconfig                |   1 +
>  drivers/mmc/bcmstb_sdhci.c                 | 173 ++++++++++++++++++++-
>  drivers/video/bcm2835.c                    |  18 ++-
>  10 files changed, 282 insertions(+), 23 deletions(-)
