Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA50C3DA49
	for <u-boot@archiver.kernel.org>; Sun, 14 Jul 2024 08:21:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A8C788210;
	Sun, 14 Jul 2024 10:21:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=testtoast.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=testtoast.com header.i=@testtoast.com header.b="9a63XTCX";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="AoxQaBck";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D825882B7; Sun, 14 Jul 2024 10:21:35 +0200 (CEST)
Received: from fhigh4-smtp.messagingengine.com
 (fhigh4-smtp.messagingengine.com [103.168.172.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B7B287CF8
 for <u-boot@lists.denx.de>; Sun, 14 Jul 2024 10:21:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=testtoast.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ryan@testtoast.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 927B511420AE;
 Sun, 14 Jul 2024 04:21:31 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
 by compute5.internal (MEProxy); Sun, 14 Jul 2024 04:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=testtoast.com;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1720945291; x=
 1721031691; bh=po1oCdvm18zLY5+6w4WOQn3fs5dbLvfSeGN+fl5jjxs=; b=9
 a63XTCXNYx1G9Dz0zRb4dDCRH9tOI/OTRZ8YTTT4nKIMKfh7dVv8mN9+5FqdKWDt
 RfRKRR2AIkVALqsCkyq3Vm4lB79ygdvETKpcS14wDgU+uXg5WymsP5bo5f/E2l0B
 TmSOQaIncNsDw4Fl3RoBjMm4uqZA6ueTtRbcnMf9FqTNrfkRom6uR8optvjpJbqy
 KRM0hiymjyecVmdtvBb+ngxLaxOsZRlEbN868AHkUkWkfX5Eal37ffELNROZefSr
 vw9jnYvuUEvLUWW2MAv7Rwjo0bhNs5Xf5zdpWN6yl8zgjHQbRrtpvCt/9H/sSPc3
 bMXPw2e3wthm0gGWuYb3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1720945291; x=1721031691; bh=po1oCdvm18zLY5+6w4WOQn3fs5db
 LvfSeGN+fl5jjxs=; b=AoxQaBckPtY0UTiAR3lY9fV+7Xy10sPH6ZdsAsz5XJb4
 Ehbw7APjPPxjbvpxqNKzPrE0rBqbD3kP/6w/HzC/NYzr09E4q6Dlek7BVTa0zffB
 1Qa1lRDyhvZmiRd2/xHojQHwvWAHNu/X77Np5au0hYnYUQ6p/O+2OA79IfryEqUY
 qJg964ZeHVDc9LetPoJHSoxenxOqww8Cr0k54zdi+KxvokxIRRFjOypgoEegd0A/
 EN+5ucAiqVNy9Id5/aMLRNJqHGw41RvionsSB/YhsaF/R4fDPu9Egg31kHIveaSL
 Tw6UpjUgg9blsA5B7o6k4OYL2gZkGQr0s55EJ+8wjA==
X-ME-Sender: <xms:ioqTZphpoc83BSf_N-Y5Pl3cWHfxC8m21IxI-3ZmM9dA-fKq00fntw>
 <xme:ioqTZuChrtyBEBa03ukWZ3D4_aXb28J-4Ri3NBYp4dSXqNqlRMvSSrBssZgQfm5bL
 V9TDZflrOt9GvKFdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgedtgddtfecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfthigr
 nhcuhggrlhhklhhinhdfuceorhihrghnsehtvghsthhtohgrshhtrdgtohhmqeenucggtf
 frrghtthgvrhhnpeehvdevieegudejueefgeffhefhffevudfhieejgfdtffetlefgteeu
 veeiudeijeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehrhigrnhesthgvshhtthhorghsthdrtghomh
X-ME-Proxy: <xmx:ioqTZpGEqk1IF6yqG6E7yBSpKQE-NLBw0KwKO9PAouXwJCbfR0MEMA>
 <xmx:ioqTZuQjRH3LIpkqSjcqzkNwlXzzYZiQv2N0nlaePMnzqHe-ZK252g>
 <xmx:ioqTZmzktZiJnellOxUFE9uyZWcEjhRt2Y7H_h0nEoG8xQuDv7Zaiw>
 <xmx:ioqTZk7mIS1OKWUFmclw6xXdksH5jfTvgtax-6GEiwP_Gjj1ooZffg>
 <xmx:i4qTZqcF-jaQoRSmBoXrV2g5xVDhuubk51MrITSB1HIlLfxuFjlliA5d>
Feedback-ID: idc0145fc:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 070B3A60078; Sun, 14 Jul 2024 04:21:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
MIME-Version: 1.0
Message-Id: <f970326b-3763-4179-a6ca-fd30a27fc793@app.fastmail.com>
In-Reply-To: <20240712165352.3767166-5-andre.przywara@arm.com>
References: <20240712165352.3767166-1-andre.przywara@arm.com>
 <20240712165352.3767166-5-andre.przywara@arm.com>
Date: Sun, 14 Jul 2024 20:20:44 +1200
From: "Ryan Walklin" <ryan@testtoast.com>
To: "Andre Przywara" <andre.przywara@arm.com>,
 "Tom Rini" <trini@konsulko.com>, "Jaehoon Chung" <jh80.chung@samsung.com>
Cc: "Jagan Teki" <jagan@amarulasolutions.com>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>,
 "Samuel Holland" <samuel@sholland.org>,
 "Chris Morgan" <macromorgan@hotmail.com>,
 "Philippe Simons" <simons.philippe@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 4/6] power: pmic: sunxi: add AXP717 SPL support
Content-Type: text/plain
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

Hi Andre,

On Sat, 13 Jul 2024, at 4:53 AM, Andre Przywara wrote:

>  #define AXP209_I2C_ADDR			0x34
> +#define AXP717_I2C_ADDR			0x34
> 
>  #define AXP305_I2C_ADDR			0x36
>  #define AXP313_I2C_ADDR			0x36
> @@ -36,6 +37,8 @@ static int pmic_i2c_address(void)
>  		return AXP305_I2C_ADDR;
>  	if (IS_ENABLED(CONFIG_AXP313_POWER))
>  		return AXP313_I2C_ADDR;
> +	if (IS_ENABLED(CONFIG_AXP717_POWER))
> +		return AXP717_I2C_ADDR;
> 
>  	/* Other AXP2xx and AXP8xx variants */
>  	return AXP209_I2C_ADDR;

Small point, but is this check strictly necessary, given that the AXP717 uses the same I2C address as the AXP209? If CONFIG_AXP717_POWER is not checked here, this logic will still fall through to the default AXP209 address, which will also be correct for the 717.

> diff --git a/board/sunxi/board.c b/board/sunxi/board.c
> index ed86f1df5dc..9928069c0eb 100644
> --- a/board/sunxi/board.c
> +++ b/board/sunxi/board.c
> @@ -562,7 +562,7 @@ void sunxi_board_init(void)
>  #if defined CONFIG_AXP152_POWER || defined CONFIG_AXP209_POWER || \
>  	defined CONFIG_AXP221_POWER || defined CONFIG_AXP305_POWER || \
>  	defined CONFIG_AXP809_POWER || defined CONFIG_AXP818_POWER || \
> -	defined CONFIG_AXP313_POWER
> +	defined CONFIG_AXP313_POWER || defined CONFIG_AXP717_POWER
>  	power_failed = axp_init();
> 
>  	if (IS_ENABLED(CONFIG_AXP_DISABLE_BOOT_ON_POWERON) && !power_failed) {
> diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
> index 33b8bc1214d..5556a22cf69 100644
> --- a/drivers/power/Kconfig
> +++ b/drivers/power/Kconfig
> @@ -109,6 +109,13 @@ config AXP313_POWER
>  	Select this to enable support for the AXP313 PMIC found on some
>  	H616 boards.
> 
> +config AXP717_POWER
> +	bool "axp717 pmic support"
> +	select AXP_PMIC_BUS
> +	select CMD_POWEROFF
> +	---help---
> +	Select this to enable support for the AXP717 PMIC found on some boards.
> +
>  config AXP809_POWER
>  	bool "axp809 pmic support"
>  	depends on MACH_SUN9I
> @@ -151,10 +158,11 @@ config AXP_DCDC1_VOLT
> 
>  config AXP_DCDC2_VOLT
>  	int "axp pmic dcdc2 voltage"
> -	depends on AXP152_POWER || AXP209_POWER || AXP221_POWER || 
> AXP809_POWER || AXP818_POWER || AXP313_POWER
> +	depends on AXP152_POWER || AXP209_POWER || AXP221_POWER || 
> AXP809_POWER || AXP818_POWER || AXP313_POWER || AXP717_POWER
>  	default 900 if AXP818_POWER
>  	default 1400 if AXP152_POWER || AXP209_POWER
>  	default 1000 if AXP313_POWER
> +	default 1000 if AXP717_POWER
>  	default 1200 if MACH_SUN6I
>  	default 1100 if MACH_SUN8I
>  	default 0 if MACH_SUN9I
> @@ -167,11 +175,11 @@ config AXP_DCDC2_VOLT
>  	On A80 boards dcdc2 powers the GPU and can be left off.
>  	On A83T boards dcdc2 is used for VDD-CPUA(cluster 0) and should be 
> 0.9V.
>  	On R40 boards dcdc2 is VDD-CPU and should be 1.1V
> -	On boards using the AXP313 it's often VDD-CPU.
> +	On boards using the AXP313 or AXP717 it's often VDD-CPU.
> 
>  config AXP_DCDC3_VOLT
>  	int "axp pmic dcdc3 voltage"
> -	depends on AXP152_POWER || AXP209_POWER || AXP221_POWER || 
> AXP809_POWER || AXP818_POWER || AXP313_POWER
> +	depends on AXP152_POWER || AXP209_POWER || AXP221_POWER || 
> AXP809_POWER || AXP818_POWER || AXP313_POWER || AXP717_POWER
>  	default 900 if AXP809_POWER || AXP818_POWER
>  	default 1500 if AXP152_POWER
>  	default 1250 if AXP209_POWER
> @@ -188,7 +196,8 @@ config AXP_DCDC3_VOLT
>  	On A80 boards dcdc3 is used for VDD-CPUA(cluster 0) and should be 
> 0.9V.
>  	On A83T boards dcdc3 is used for VDD-CPUB(cluster 1) and should be 
> 0.9V.
>  	On R40 boards dcdc3 is VDD-SYS and VDD-GPU and should be 1.1V.
> -	On boards using the AXP313 it's often VDD-DRAM and should be 1.1V for 
> LPDDR4.
> +	On boards using the AXP313 or AXP717 it's often VDD-DRAM and should
> +	be 1.1V for LPDDR4.
> 
>  config AXP_DCDC4_VOLT
>  	int "axp pmic dcdc4 voltage"
> diff --git a/drivers/power/Makefile b/drivers/power/Makefile
> index 0f39459dec4..6df23a81c29 100644
> --- a/drivers/power/Makefile
> +++ b/drivers/power/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_AXP209_POWER)	+= axp209.o
>  obj-$(CONFIG_AXP221_POWER)	+= axp221.o
>  obj-$(CONFIG_AXP305_POWER)	+= axp305.o
>  obj-$(CONFIG_AXP313_POWER)	+= axp313.o
> +obj-$(CONFIG_AXP717_POWER)	+= axp_spl.o
>  obj-$(CONFIG_AXP809_POWER)	+= axp809.o
>  obj-$(CONFIG_AXP818_POWER)	+= axp818.o
>  endif
> -- 
> 2.25.1

Tested with RG35XX-H and RG35XX-Plus boards (Allwinner H700 with AXP717). Confirmed both DCDC2 and DCDC3 are set correctly in SPL, allowing successful DRAM init and boot.

Tested-by: Ryan Walklin <ryan@testtoast.com>

Regards,

Ryan
