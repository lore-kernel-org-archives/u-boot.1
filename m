Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1497FC369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 04:11:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76ACC82EAA;
	Thu, 17 Apr 2025 06:11:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 261B782F85; Thu, 17 Apr 2025 06:11:05 +0200 (CEST)
Received: from smtp.gentoo.org (mail.gentoo.org
 [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D701F82DB4
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 06:11:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from localhost (unknown [116.232.27.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id CE87B343128;
 Thu, 17 Apr 2025 04:11:00 +0000 (UTC)
Date: Thu, 17 Apr 2025 04:10:55 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 0/3] sunxi: add "fake" FEL button feature
Message-ID: <20250417041055-GYC34332@gentoo>
References: <20250417000539.3709-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417000539.3709-1-andre.przywara@arm.com>
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

On 01:05 Thu 17 Apr     , Andre Przywara wrote:
> Some boards with Allwinner SoCs feature a "FEL" key, sometimes also
> labelled "uboot", which allows to easily enter the BootROM FEL mode, when
> pressed upon power-on or reset. This allows to access the USB-OTG boot
> protocol, for convenient access to memory and uploading code.
> 
> Add a software emulation of this functionality for boards without a button
> connected to this special SoC pin, to give easy FEL access to more
> boards. Any GPIO can be used, as long as the button uses active-low
> logic.
> 
> This is used on the X96 Mate TV box, where the hidden "update" button is
> actually just some GPIO, checked by the vendor firmware.
> 
> Please have a look!
> 
for the series

Tested-by: Yixun Lan <dlan@gentoo.org> # On A527 SoC
Reviewed-by: Yixun Lan <dlan@gentoo.org>

> Cheers,
> Andre
> 
> Changelog v1 .. v2:
> - add patch to fix return_to_fel() prototype
> - document signal needs to be active-low
> - activate internal pull-up resistors
> - add patch to activate button on the X96 Mate TV box
> 
> Andre Przywara (3):
>   sunxi: fix return_to_fel() prototype
>   sunxi: add "fake" FEL pin support
>   sunxi: x96_mate: Add "fake" FEL key definition
> 
>  arch/arm/include/asm/arch-sunxi/sys_proto.h |  4 +--
>  arch/arm/mach-sunxi/Kconfig                 | 10 +++++++
>  arch/arm/mach-sunxi/board.c                 | 31 +++++++++++++++++++++
>  configs/x96_mate_defconfig                  |  1 +
>  4 files changed, 44 insertions(+), 2 deletions(-)
> 
> -- 
> 2.46.3
> 

-- 
Yixun Lan (dlan)
