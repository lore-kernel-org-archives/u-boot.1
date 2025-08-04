Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC237C87FCF
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 12:42:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FBB683E18;
	Mon,  4 Aug 2025 14:42:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="fL6qaiwn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D09383EF1; Mon,  4 Aug 2025 14:42:32 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB84B83E04
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 14:42:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4ce3=2R=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: Cc:
 References: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1754311348;
 bh=kOjrzeUMZEzCsEyR0SfH4QCW56tvNgxP+vY/9jnXZ7k=;
 b=fL6qaiwnHVWJv5nP3NZkw1cTobsna2mXPE3DYeYsQczEMN7JlGyrKNUlNVydRSCERc+Sn53bO
 GkEHKT9wWHsorqS2a/GKMK42ART0bMW+7FweopdXEg15NxLwxspmC1TREVb32k7a4tXoMAtx/Y/
 eEEb6zbNtBYppRI2P2YUA0zTqCxU6GqiiEMGGOcAA5p7t6IE4xUxkxRluK67K20GbVafbDNxr5z
 jaaC0wWrJ+ktWEMd3I1qiwaTTGIqOwk4RFh6fRFDhE+O6RLe2/zXholB2snwleQMk1XThOvh1es
 0aegUq9+17fn76zhXemMmjrYFCIQh767o6580eJh4BcA==
X-Forward-Email-ID: 6890aaa75b829a2afb5f2a9e
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <6541cce1-f779-46fe-b3c8-e76303e59eab@kwiboo.se>
Date: Mon, 4 Aug 2025 14:42:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB OTG: make dwc2 otg driver dependent on Exynos platform
To: Marius Dinu <m95d+git@psihoexpert.ro>
References: <20250804094353.28658-1-m95d+git@psihoexpert.ro>
Content-Language: en-US
Cc: u-boot@lists.denx.de
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250804094353.28658-1-m95d+git@psihoexpert.ro>
Content-Type: text/plain; charset=UTF-8
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

Hi Marius,

On 8/4/2025 11:43 AM, Marius Dinu wrote:
> drivers/usb/gadget/dwc2_udc_otg_phy.c uses s5p_cpu_id,
> which is only defined for Exynos CPUs.
> 
> Signed-off-by: Marius Dinu <m95d+git@psihoexpert.ro>
> ---
>  drivers/usb/gadget/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index 46a83141481..deabcb3e51f 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -108,10 +108,11 @@ config USB_GADGET_AT91
>  
>  config USB_GADGET_DWC2_OTG
>  	bool "DesignWare USB2.0 HS OTG controller (gadget mode)"
> +	depends on ARCH_EXYNOS5

There are other platforms using this driver not just exynos.

You should probably change

  if (s5p_cpu_id == 0x4412)

into something like

  if (IS_ENABLED(CONFIG_ARCH_EXYNOS5) && s5p_cpu_id == 0x4412)

instead of breaking use of this driver for other platforms.

Regards,
Jonas

>  	select USB_GADGET_DUALSPEED
>  	help
>  	  The Designware USB2.0 high-speed gadget controller
> -	  integrated into many SoCs. Select this option if you want the
> +	  integrated into many Exynos SoCs. Select this option if you want the
>  	  driver to operate in Peripheral mode. This option requires
>  	  USB_GADGET to be enabled.
>  

