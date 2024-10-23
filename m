Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB23CDDE66
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 10:54:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FA9D892F5;
	Wed, 23 Oct 2024 12:53:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729680838;
	bh=4GOzjQ2uQkWSUi5ty6WKF+ZiQY196AEt+hID5SEkPuc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rmnbHGqjavvkzjhTWv6yPJqXZhiMG6pLD3/wF8DARfNNuVN7EoLmLm1DNMAEb+yR2
	 7pXmy8CRYS+ZDN1e9nkX88B1sn7WgTPJL5OFxOKdPX0H8CDkkwWzygTiFJDkS+zuSM
	 8QQsiMufGr8t8NRy21AlqD/hK9viQZ6S0eU1EtZoHbjwuq4x5uWECKl9rSJkSXTMJJ
	 8LMsHFo8LWycGItMYAAtSaTVthQoQEJ7qZ/esL3W7bJv6dZOA4EDN1jIqRsVDb4DoY
	 AZVC/gFYozrqy1XCse5xSA0IdzwGIlh1he0pv6hPyBOL4R8tLqIUE4Oi91LZ9grG22
	 6DkVhEq4Sl29w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C0D8892F4; Wed, 23 Oct 2024 12:53:57 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61AE8892DC
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 12:53:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4XYQrn27Vgz9sT8;
 Wed, 23 Oct 2024 12:53:45 +0200 (CEST)
Message-ID: <b1a951a0-df3f-456e-9d1e-102c7eb83bc1@denx.de>
Date: Wed, 23 Oct 2024 12:53:44 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] watchdog: introduce separate SPL symbol for WDT_GPIO
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20241007174716.1068936-1-ravi@prevas.dk>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20241007174716.1068936-1-ravi@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10/7/24 19:47, Rasmus Villemoes wrote:
> Currently, enabling WDT_GPIO on a board which uses SPL, but does not
> have SPL_WDT, SPL_DM_GPIO or SPL_OF_CONTROL enabled, breaks the build.
> 
> Make it possible to use the WDT_GPIO driver on such boards by
> introducing a separate symbol controlling whether the driver is built
> for SPL. Make it default to WDT_GPIO such that boards that already
> have it enabled and all the SPL prerequisites satisfied will continue
> to have it in SPL.
> 
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

Applied to u-boot-watchdog/master

Thanks,
Stefan

> ---
>   drivers/watchdog/Kconfig  | 9 +++++++++
>   drivers/watchdog/Makefile | 2 +-
>   2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 0c3e9913318..18028269b9e 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -178,6 +178,15 @@ config WDT_GPIO
>   	  doc/device-tree-bindings/watchdog/gpio-wdt.txt for
>   	  information on how to describe the watchdog in device tree.
>   
> +config SPL_WDT_GPIO
> +	bool "External gpio watchdog support in SPL"
> +	depends on SPL_WDT
> +	depends on SPL_DM_GPIO
> +	depends on SPL_OF_REAL
> +	default WDT_GPIO
> +	help
> +	  Support for external watchdog fed by toggling a gpio in SPL.
> +
>   config WDT_MAX6370
>   	bool "MAX6370 watchdog timer support"
>   	depends on WDT
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 7b39adcf0ff..a450c33b3ad 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -30,7 +30,7 @@ obj-$(CONFIG_WDT_CORTINA) += cortina_wdt.o
>   obj-$(CONFIG_WDT_ORION) += orion_wdt.o
>   obj-$(CONFIG_WDT_CDNS) += cdns_wdt.o
>   obj-$(CONFIG_WDT_FTWDT010) += ftwdt010_wdt.o
> -obj-$(CONFIG_WDT_GPIO) += gpio_wdt.o
> +obj-$(CONFIG_$(SPL_TPL_)WDT_GPIO) += gpio_wdt.o
>   obj-$(CONFIG_WDT_MAX6370) += max6370_wdt.o
>   obj-$(CONFIG_WDT_MCF) += mcf_wdt.o
>   obj-$(CONFIG_WDT_MESON_GXBB) += meson_gxbb_wdt.o

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
