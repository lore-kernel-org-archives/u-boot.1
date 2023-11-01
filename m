Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2344BC4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 12:33:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4653A87B35;
	Wed,  1 Nov 2023 13:33:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34C9387B61; Wed,  1 Nov 2023 13:33:21 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 42CE886A4B
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 13:33:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E86362F4;
 Wed,  1 Nov 2023 05:33:56 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E7C33F738;
 Wed,  1 Nov 2023 05:33:14 -0700 (PDT)
Date: Wed, 1 Nov 2023 12:33:12 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Samuel Holland <samuel@sholland.org>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH] pinctrl: sunxi: Avoid using .bss for SPL
Message-ID: <20231101123312.3bdd7664@donnerap.manchester.arm.com>
In-Reply-To: <20231031045743.53647-1-samuel@sholland.org>
References: <20231031045743.53647-1-samuel@sholland.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
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

On Mon, 30 Oct 2023 23:57:40 -0500
Samuel Holland <samuel@sholland.org> wrote:

> sunxi platforms put .bss in DRAM, so .bss is not available in SPL before
> DRAM controller initialization. Therefore, this buffer must be placed in
> the .data section.

Right, this results in 0 bytes of .BSS, down from 5.
Though I am wondering how much of the (SPL-)DM code gets away without
using BSS, or if we get accidental BSS additions from the framework, over
time.

But if this patch helps your SPL_DM efforts:

> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
> 
>  drivers/pinctrl/sunxi/pinctrl-sunxi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> index bdf6360f176..37ea93715d1 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> @@ -50,7 +50,7 @@ static const char *sunxi_pinctrl_get_pin_name(struct udevice *dev,
>  					      uint pin_selector)
>  {
>  	const struct sunxi_pinctrl_desc *desc = dev_get_priv(dev);
> -	static char pin_name[sizeof("PN31")];
> +	static char pin_name[sizeof("PN31")] __section(".data");
>  
>  	snprintf(pin_name, sizeof(pin_name), "P%c%d",
>  		 pin_selector / SUNXI_GPIOS_PER_BANK + desc->first_bank + 'A',

