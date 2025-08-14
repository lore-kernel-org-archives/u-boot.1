Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC3DCA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 16:26:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B4358399D;
	Thu, 14 Aug 2025 18:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=psihoexpert.ro header.i=@psihoexpert.ro header.b="XbHkTgQ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B496D839A9; Thu, 14 Aug 2025 18:26:56 +0200 (CEST)
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.36])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 526888391B
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 18:26:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m95d+git@psihoexpert.ro
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:In-Reply-To:References;
 bh=rLRfo8di6RJDKVmO5Ggri142bskAESoak3ym2q9POCs=;
 b=XbHkTgQ6nz7OYSuReevR2tRAPa6ZZjfbA6nYEiHe5ytoLz3xG7MZoYawvFq+TtXslV3i+cQ2DnTkAK8DKCLgjsrMAXdWTTGT8QoVQAPogMyDuJnTnM5iRmX2JoEnTPaKvvXMpSzJIN8lXRZdoqQivdFYQ88K0kwdNggg3J+ZIfgxjhmu3eHJJ2dA1zlC2boqhvKIdnyxlbA/45Y57d7W55SNdsVLnAEl1bv/PxK9+RRNylGzuYs+QN0Y2p
 Xv5Q4okAD43GNzWkuXngKl7OYxQ+jsYwG9VyNGe44A3PvD5cX7fF0XQMK1qPXRhZ7/zc3Ql43SIQq4BOJOEQpjcgrxrQ==
Received: from GRAPHRT (188-24-194-92.rdsnet.ro [188.24.194.92])
 by mx1.wiredblade.com with ESMTPSA
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256)
 ; Thu, 14 Aug 2025 16:26:49 +0000
Date: Thu, 14 Aug 2025 19:26:47 +0300
From: Marius Dinu <m95d+git@psihoexpert.ro>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Marius Dinu <m95d+git@psihoexpert.ro>
Subject: Re: [PATCH 2/2] timer: Mark this as incompatible with SYS_ARCH_TIMER
Message-ID: <aJ4OR2rhl6eFV3GE@GRAPHRT>
References: <20250813205511.3420638-1-trini@konsulko.com>
 <20250813205511.3420638-2-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813205511.3420638-2-trini@konsulko.com>
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

On Wed, 2025-08-13 14.55.11 +-0600, Tom Rini wrote:
> The timers implemented under SYS_ARCH_TIMER are not part of the TIMER
> framework and thus cannot be enabled at the same time. Express this
> dependency in Kconfig and add a note to the help of SYS_ARCH_TIMER.
> 
> Reported-by: Marius Dinu <m95d+git@psihoexpert.ro>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Marius, I ended up reworking things a bit (and also found part 1/2 of
> this series) but please let me know if you feel this should retain your
> Author and such instead. Thanks!

No need for credits.
I think you should keep the warning message in the Timer drivers menu.
It provides a quick explanation why the menu is empty.

Bugs are reported in this mailing list too?
Thanks!

> ---
>  arch/arm/Kconfig      | 1 +
>  drivers/timer/Kconfig | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 73b4aad28b50..0dba2e2c8567 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -452,6 +452,7 @@ config SYS_ARCH_TIMER
>  	  interface to a timer source on an SoC.
>  	  It is mandatory for ARMv8 implementation and widely available
>  	  on ARMv7 systems.
> +	  This timer driver is incompatible with the DM timer framework.
>  
>  config ARM_SMCCC
>  	bool "Support for ARM SMC Calling Convention (SMCCC)"
> diff --git a/drivers/timer/Kconfig b/drivers/timer/Kconfig
> index cb6fc0e7fda8..2ab4d971dffa 100644
> --- a/drivers/timer/Kconfig
> +++ b/drivers/timer/Kconfig
> @@ -2,6 +2,7 @@ menu "Timer Support"
>  
>  config TIMER
>  	bool "Enable driver model for timer drivers"
> +	depends on !SYS_ARCH_TIMER
>  	depends on DM
>  	help
>  	  Enable driver model for timer access. It uses the same API as
> -- 
> 2.43.0
> 


