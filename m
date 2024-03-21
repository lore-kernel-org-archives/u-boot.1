Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B316C54E68
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 16:20:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C85287DA8;
	Thu, 21 Mar 2024 17:20:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="BGoh3Pd3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FB8487E8E; Thu, 21 Mar 2024 17:20:44 +0100 (CET)
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E07AF87D91
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 17:20:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@linux.dev
Message-ID: <dcc310e3-fa22-4459-a0ab-b44176c4bd2e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1711038041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q0P3t0b4K26QJMRxYHqTxy2J35JWMP1da87JWa5Cl9Q=;
 b=BGoh3Pd3ahwrBe/TrCR8CqVtZK5gI2YyhjI9Go601S2FZNJNmJDi8cKOJz5JxpE2e/uKTw
 Ki1s36uD06r/4pOCKsir15hLLSAih1Uay9D+ugHAW4ZruITOsYaK95Q10whsktIs/B8y2/
 nsVmYUT8qsdWasEKW0ZXtN+YTwc15cY=
Date: Thu, 21 Mar 2024 12:20:35 -0400
MIME-Version: 1.0
Subject: Re: [PATCH] arm64: zynqmp: Also support JTAG as alternative boot mode
Content-Language: en-US
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@xilinx.com
Cc: Tom Rini <trini@konsulko.com>
References: <ed51a9d51948ab939a53e0b9dc6c2d2546f97a4f.1710933505.git.michal.simek@amd.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <ed51a9d51948ab939a53e0b9dc6c2d2546f97a4f.1710933505.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
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

On 3/20/24 07:18, Michal Simek wrote:
> if (reg >> BOOT_MODE_ALT_SHIFT) condition rules out alternative jtag boot
> mode which is 0. When 0 was used origin(HW) boot mode was used instead.
> That's why directly fill reg variable with requested boot mode and don't
> let code to read value back. "else" part of code remain unchanged.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>  arch/arm/mach-zynqmp/spl.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-zynqmp/spl.c b/arch/arm/mach-zynqmp/spl.c
> index 5af735aa5cef..979ff3aef6c2 100644
> --- a/arch/arm/mach-zynqmp/spl.c
> +++ b/arch/arm/mach-zynqmp/spl.c
> @@ -91,13 +91,14 @@ u32 spl_boot_device(void)
>  
>  #if defined(CONFIG_SPL_ZYNQMP_ALT_BOOTMODE_ENABLED)
>  	/* Change default boot mode at run-time */
> +	reg = CONFIG_SPL_ZYNQMP_ALT_BOOTMODE;
>  	writel(CONFIG_SPL_ZYNQMP_ALT_BOOTMODE << BOOT_MODE_ALT_SHIFT,
>  	       &crlapb_base->boot_mode);
> -#endif
> -
> +#else
>  	reg = readl(&crlapb_base->boot_mode);
>  	if (reg >> BOOT_MODE_ALT_SHIFT)
>  		reg >>= BOOT_MODE_ALT_SHIFT;
> +#endif
>  
>  	bootmode = reg & BOOT_MODES_MASK;
>  

Looks fine; can we change this to

if (IS_ENABLED(CONFIG_SPL_ZYNQMP_ALT_BOOTMODE_ENABLED)) {
	...
} else {
	...
}

?

--Sean
