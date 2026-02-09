Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE772E81BD3
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 18:10:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 244948397D;
	Mon,  9 Feb 2026 19:10:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timmermann.space
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAB2E805D7; Mon,  9 Feb 2026 19:02:45 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49EAC80325
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 19:02:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=timmermann.space
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux@timmermann.space
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4f8sws6tVLz9tDy;
 Mon,  9 Feb 2026 19:02:37 +0100 (CET)
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of linux@timmermann.space designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=linux@timmermann.space
Date: Mon, 9 Feb 2026 19:02:27 +0100
From: Lukas Timmermann <linux@timmermann.space>
To: Minkyu Kang <mk7.kang@samsung.com>, 
 'Lukas Timmermann' <uboot@timmermann.space>, u-boot@lists.denx.de
Cc: 'Alif Zakuan Yuslaimi' <alif.zakuan.yuslaimi@altera.com>, 
 'Arturs Artamonovs' <arturs.artamonovs@analog.com>,
 'Eoin Dickson' <eoin.dickson@microchip.com>, 
 'Greg Malysa' <malysagreg@gmail.com>, 'Heiko Schocher' <hs@nabladev.com>, 
 'Henrik	Grimler' <henrik@grimler.se>, 'Ian Roberts' <ian.roberts@timesys.com>, 
 =?utf-8?Q?'J=2E_Neusch=C3=A4fer'?= <j.ne@posteo.net>,
 'Jerome Forissier' <jerome.forissier@linaro.org>, 
 "'Kory Maincent (TI.com)'" <kory.maincent@bootlin.com>,
 'Marek Vasut' <marek.vasut+renesas@mailbox.org>, 
 'Mattijs Korpershoek' <mkorpershoek@kernel.org>,
 'Nathan Barrett-Morrison' <nathan.morrison@timesys.com>, 
 'Neil Armstrong' <neil.armstrong@linaro.org>,
 'Oliver Gaskell' <Oliver.Gaskell@analog.com>, 
 'Patrice Chotard' <patrice.chotard@foss.st.com>, 'Peng Fan' <peng.fan@nxp.com>,
 'Philip Molloy' <philip.molloy@analog.com>, 'Simon Glass' <sjg@chromium.org>, 
 'Stefan Roese' <stefan.roese@mailbox.org>, 'Tom Rini' <trini@konsulko.com>, 
 'Utsav Agarwal' <utsav.agarwal@analog.com>,
 'Vasileios Bimpikas' <vasileios.bimpikas@analog.com>, 
 'Yao Zi' <ziyao@disroot.org>
Subject: Re: [PATCH v2 0/2] Modern pinctrl for Exynos5250 devices
Message-ID: <aYodQu98Sv3L06EU@archstation>
References: <CGME20251103191515epcas1p209371cc60bfa83914a77194d3899619b@epcas1p2.samsung.com>
 <20251103191427.2410755-1-uboot@timmermann.space>
 <0e2901dc941e$a80ac4c0$f8204e40$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e2901dc941e$a80ac4c0$f8204e40$@samsung.com>
X-Rspamd-Queue-Id: 4f8sws6tVLz9tDy
X-Mailman-Approved-At: Mon, 09 Feb 2026 19:10:04 +0100
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

No worries. I'm still interested in upstreaming this patch and the
corresponding DT for my device into the linux kernel.

The error you've got would be expected if you didn't disable the pinctrl part of the
older S5P (see Patch v2 1/2). Please be sure to disable it in order for my suggested driver
to compile correctly. The older driver didn't support newer style DTs
pinctrl, which my device uses and will be upstreamed soon.

I acknowledge, that this is a less than optimal solution and I'm willing
to discuss alternatives. The issue appears because the older pinmux
driver did much more than the newer pinctrl driver I've written does.

Also I just noticed that I left behind "Copyright Linaro Ltd." in the header of
pinctrl-exynos5250.c so please don't merge this yet. A v3 is obligatory
at this point.

Best regards
Lukas Timmermann

On Mon, Feb 02, 2026 at 05:33:50PM +0900, Minkyu Kang wrote:
> Dear Timmermann,
> 
> Sorry I missed this patch..
> 
> I tested this patch but I've got compile errors.
> Could you please check?; tested with smdk5250.
> 
> /opt/toolchain/gcc-arm-none-eabi-10.3-2021.10/bin/arm-none-eabi-ld: drivers/gpio/s5p_gpio.o: in function `gpio_set_pull':
> /home/work/git/u-boot-samsung/drivers/gpio/s5p_gpio.c:240: multiple definition of `gpio_set_pull'; arch/arm/mach-exynos/pinmux.o:pinmux.c:(.text.gpio_set_pull+0x0): first defined here
> /opt/toolchain/gcc-arm-none-eabi-10.3-2021.10/bin/arm-none-eabi-ld: drivers/gpio/s5p_gpio.o: in function `gpio_set_drv':
> /home/work/git/u-boot-samsung/drivers/gpio/s5p_gpio.c:246: multiple definition of `gpio_set_drv'; arch/arm/mach-exynos/pinmux.o:pinmux.c:(.text.gpio_set_drv+0x0): first defined here
> /opt/toolchain/gcc-arm-none-eabi-10.3-2021.10/bin/arm-none-eabi-ld: drivers/gpio/s5p_gpio.o: in function `gpio_cfg_pin':
> /home/work/git/u-boot-samsung/drivers/gpio/s5p_gpio.c:252: multiple definition of `gpio_cfg_pin'; arch/arm/mach-exynos/pinmux.o:/home/work/git/u-boot-samsung/arch/arm/mach-exynos/pinmux.c:952: first defined here
> 
> Thanks,
> Minkyu Kang.
> 
