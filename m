Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46213D111A8
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 10:37:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAFD383ABA;
	Mon,  1 Dec 2025 11:37:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5AE683AEC; Mon,  1 Dec 2025 11:37:09 +0100 (CET)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBA1683AA4
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 11:37:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from localhost (unknown [116.232.18.222])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id 9A1FC3410A3;
 Mon, 01 Dec 2025 10:37:05 +0000 (UTC)
Date: Mon, 1 Dec 2025 18:37:00 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Paul Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 06/10] gpio: a733: add initial support
Message-ID: <20251201103700-GYB1814866@gentoo.org>
References: <20251130-01-a733-soc-support-v2-0-18bdd4376fad@gentoo.org>
 <20251130-01-a733-soc-support-v2-6-18bdd4376fad@gentoo.org>
 <20251201000125.GB303283@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201000125.GB303283@bill-the-cat>
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

Hi Tom,

On 18:01 Sun 30 Nov     , Tom Rini wrote:
> On Sun, Nov 30, 2025 at 09:45:15PM +0000, Yixun Lan wrote:
> 
> > In A733 SoC, the GPIO IP block has changed its arrangement, so initial
> > GPIO base address and bank size need to be adjusted.
> > 
> > Introduce new SUNXI_NEW2_PINCTRL in order to reuse the driver in future.
> > 
> > There is no PA bank exist in A733, but introducing a virtual one as offset
> > 0x80, and with the bank size 0x80, it will iterate other bank correctly
> > starting from PB as offset 0x100.
> > 
> > Signed-off-by: Yixun Lan <dlan@gentoo.org>
> 
> So, looking at:
> 
> commit 452369cd0c636123321d021298b4bc35a34f4941
> Author: Andre Przywara <andre.przywara@arm.com>
> Date:   Tue Sep 6 12:12:50 2022 +0100
> 
>     pinctrl: sunxi: add new D1 pinctrl support
>     
>     For the first time since at least the Allwinner A10 SoCs, the D1 (and
>     related cores) use a new pincontroller MMIO register layout, so we
>     cannot use our hardcoded, fixed offsets anymore.
>     Ideally this would all be handled by devicetree and DM drivers, but for
>     the DT-less SPL we still need the legacy interfaces.
>     
>     Add a new Kconfig symbol to differenciate between the two generations of
>     pincontrollers, and just use that to just switch some basic symbols.
>     The rest is already abstracted enough, so works out of the box.
>     
>     Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>     Reviewed-by: Sam Edwards <CFSworks@gmail.com>
>     Tested-by: Sam Edwards <CFSworks@gmail.com>
>     Tested-by: Samuel Holland <samuel@sholland.org>
> 
> Is there some way to abstract things so that again, non-SPL has a single
> driver, and for SPL we can just hard-code a few things?
> 
I think we've already went this way..

And after second thought, we probably could squash A733 into exist
SUNXI_NEW_PINCTRL Kconfig option, with different register offset,

e.g. in file include/sunxi_gpio.h, we can do something like:

#ifdef CONFIG_SUNXI_NEW_PINCTRL 

 #if defined(CONFIG_MACH_SUN60I_A733)
    #define SUNXI_PINCTRL_BANK_SIZE 0x80
 #else
    #define SUNXI_PINCTRL_BANK_SIZE 0x30
 #endif

    #define SUNXI_GPIO_DISABLE  0xf
#endif

similar with file drivers/gpio/sunxi_gpio.c

Andre, please let me know if you like this way or not

-- 
Yixun Lan (dlan)
