Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C43E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 11:25:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38C7D801CF;
	Tue, 17 Dec 2024 12:25:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="zBPWjg/V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEC798020C; Tue, 17 Dec 2024 12:25:42 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96AFF801CE
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 12:25:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 3A59620668;
 Tue, 17 Dec 2024 12:25:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1734434739;
 bh=+gWWdclnRrE5oGoWXMyP89Z7YpyfzwVfOE7ODzjqT6Y=; h=From:To:Subject;
 b=zBPWjg/VVk7B8F/76d9Ygu1Pdhhf4KGNEUdcw0HG3qpTItA2Hvuj+fImju3BThezA
 mAgMUShSXYGJo1/40vZGLiLp6ERd58L7NpJEBfXu2y/iVIuB4yrSKVCrCqNJvTcB10
 9BjNqv2Fvw5+t8qUXoWPorEnep9+0Bi1/CYRAErn3xqdLjUStMm0S5Ka7MQPPKqYGC
 deVz3lNQ5EYFhdpKBam27k6+AxL71WLB4hxF0ON/6A756RaUNe/CtS0OpkEnPxvfEg
 Aj6lo1YYeGQswppp3OpxLcVslDSerOy0wuGGzG9F9lNk3tPVeZL4PWbLZczDEf7bgX
 KmT2K/feqAKCw==
Date: Tue, 17 Dec 2024 12:25:35 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Francesco Dolcini <francesco@dolcini.it>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Fabio Estevam <festevam@denx.de>,
 Frieder Schrempf <frieder.schrempf@kontron.de>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [REGRESSION] Out of memory error: unable to boot on imx8mp/imx8mm
Message-ID: <20241217112535.GA43472@francesco-nb>
References: <CADg8p95K5sgLbqutnGWwcggU+o94GFrS5w3=GQecuO_NT5y6PQ@mail.gmail.com>
 <20241216142842.p5j4otcinwpszt5l@joaog-nb.corp.toradex.com>
 <20241216190255.GA55577@francesco-nb>
 <CADg8p96Aiy-DBNc8piA5gN01E+iWHZJ4OGhY5qjOK1wCUS-O7Q@mail.gmail.com>
 <Z2B_sqO2XcAMIF3H@gaggiata.pivistrello.it>
 <CADg8p94S5kzr_yDhs0m8M_J8U_jKLCkdQ+RXiQAbmL+uF+F4+w@mail.gmail.com>
 <CAC_iWjKV09uXouhvLTKXk3B+Qfw481_unXc1phLq674R0CKyZQ@mail.gmail.com>
 <Z2CCOS76kgh_Kun9@gaggiata.pivistrello.it>
 <CADg8p970OvCpHnXaL2iMKN+uDBom-gZ5DQcq3GshFYf-VvZDJw@mail.gmail.com>
 <20241217111850.sazfsh3majbgy7iu@joaog-nb.corp.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241217111850.sazfsh3majbgy7iu@joaog-nb.corp.toradex.com>
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

+Fabio, Marex, Peng, Frieder

On Tue, Dec 17, 2024 at 08:18:50AM -0300, João Paulo Gonçalves wrote:
> > 
> > Okay. Please try changing the value of ram_top to 0x1_0000_0000
> > instead of 0xFFFF_FFFF. That should work.
> >
> 
> Changing ram_top to 0x1_0000_0000 worked:
> 
> U-Boot SPL 2025.01-rc4-00025-g100a40dd79f8 (Dec 17 2024 - 08:05:06 -0300)
> DDR configured as dual rank
> WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
> SEC0:  RNG instantiated
> Normal Boot
> Trying to boot from BOOTROM
> Boot Stage: Primary boot
> Find img info 0x4802d400, size 1116
> Need continue download 1024
> NOTICE:  BL31: v2.6(release):lf_v2.6-g3c1583ba0a
> NOTICE:  BL31: Built : 11:00:38, Nov 21 2022
> 
> 
> U-Boot 2025.01-rc4-00025-g100a40dd79f8 (Dec 17 2024 - 08:05:06 -0300)
> 
> CPU:   Freescale i.MX8MP[8] rev1.1 1600 MHz (running at 1200 MHz)
> CPU:   Industrial temperature grade (-40C to 105C) at 54C
> Reset cause: POR
> DRAM:  Ram top: 100000000
> 8 GiB
> Core:  183 devices, 31 uclasses, devicetree: separate
> WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
> MMC:   FSL_SDHC: 1, FSL_SDHC: 2
> Loading Environment from MMC... Reading from MMC(2)... OK
> In:    serial@30880000
> Out:   serial@30880000
> Err:   serial@30880000
> Model: Toradex 0070 Verdin iMX8M Plus Quad 8GB WB IT V1.1A
> Serial#: 15207893
> Carrier: Toradex Dahlia V1.1C, Serial# 11060859
> SEC0:  RNG instantiated
> Setting variant to wifi
> Net:   eth1: ethernet@30be0000, eth0: ethernet@30bf0000 [PRIME]
> Hit any key to stop autoboot:  0 
> MMC: no card present
> switch to partitions #0, OK
> mmc2(part 0) is current device
> Scanning mmc 2:1...
> Found U-Boot script /boot.scr
> 5974 bytes read in 1 ms (5.7 MiB/s)
> ## Executing script at 50280000
> Loading DeviceTree: imx8mp-verdin-wifi-dev.dtb
> ...
> Starting kernel ...
> 
> The change is shown in the patch below, but I am unsure if this is the
> correct solution. Should ram_top be the last valid address or the upper
> bound?
> 
> diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
> index 9588b8b28bf2..e01774ebc8a4 100644
> --- a/arch/arm/mach-imx/imx8m/soc.c
> +++ b/arch/arm/mach-imx/imx8m/soc.c
> @@ -362,7 +362,7 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>          * space below the 4G address boundary (which is 3GiB big),
>          * even when the effective available memory is bigger.
>          */
> -       top_addr = clamp_val((u64)PHYS_SDRAM + gd->ram_size, 0, 0xffffffff);
> +       top_addr = clamp_val((u64)PHYS_SDRAM + gd->ram_size, 0, 0x100000000);
>  
>         /*
>          * rom_pointer[0] stores the TEE memory start address.

see commit e27bddff4b97 ("imx8m: Restrict usable memory to space below 4G boundary").

I assume such a change might introduce regressions.

Francesco


