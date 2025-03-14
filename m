Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBEECC282DE
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 01:24:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55E2680756;
	Fri, 14 Mar 2025 02:24:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72AAA8058A; Fri, 14 Mar 2025 02:24:10 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id EFC3C8058A
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 02:24:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 511DB1BCA;
 Thu, 13 Mar 2025 18:24:12 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E65683F5A1;
 Thu, 13 Mar 2025 18:24:00 -0700 (PDT)
Date: Fri, 14 Mar 2025 01:23:41 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: 1425075683@qq.com
Cc: Chris Morgan <macromorgan@hotmail.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maksim Kiselev <bigunclemax@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1] sunxi: kconfig : Make CHIP_DIP_SCAN depend on
 ARCH_SUNXI
Message-ID: <20250314012341.33707e89@minigeek.lan>
In-Reply-To: <tencent_48B2E03220334C9CC9441FA11E8A412A3607@qq.com>
References: <tencent_48B2E03220334C9CC9441FA11E8A412A3607@qq.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
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

On Fri, 31 Jan 2025 09:12:43 +0800
1425075683@qq.com wrote:

Hi,

thanks for the update, looks good to me now.

> From: Liya Huang <1425075683@qq.com>
> 
> The CHIP_DIP_SCAN configuration option
> is relevant only to ARCH_SUNXI.
> Make CHIP_DIP_SCAN dependent
> on ARCH_SUNXI so that it does not show up on other goals.
> 
> Signed-off-by: Liya Huang <1425075683@qq.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Queued for sunxi-next.

Cheers,
Andre

> ---
> 
> Changes in v1:
> - Modify the if ARCH_SUNXI endif range.
> 
>  arch/arm/mach-sunxi/Kconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index ba1b1541437..cc28f403fae 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -1131,10 +1131,6 @@ config BLUETOOTH_DT_DEVICE_FIXUP
>  	  The used address is "bdaddr" if set, and "ethaddr" with the LSB
>  	  flipped elsewise.
>  
> -source "board/sunxi/Kconfig"
> -
> -endif
> -
>  config CHIP_DIP_SCAN
>  	bool "Enable DIPs detection for CHIP board"
>  	select SUPPORT_EXTENSION_SCAN
> @@ -1143,3 +1139,7 @@ config CHIP_DIP_SCAN
>  	select W1_EEPROM
>  	select W1_EEPROM_DS24XXX
>  	select CMD_EXTENSION
> +
> +source "board/sunxi/Kconfig"
> +
> +endif

