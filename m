Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A74C46CA3
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 07:28:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D641A8773B;
	Mon,  4 Dec 2023 08:28:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1701674894;
	bh=T/rU7BiDtjswUkODMx71236pkC9UKQx7UB9TN9q5JL0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xl9a7Hzfj+NyXVnaa1uswKz4QCFusK4sNLmCdBzDuRMT0qETo/b+6QTDJyqiU0vH/
	 RUHJ7fBxlW5OY6vAaitZrovykvYqXJUWV02TBp49XI4zwD8xdHeVwacRa8TCM9MwIj
	 86hrBpMaWrEC0RaEUYx5t9gSEnUk59lLt+Hpsmt0QGgJ57/hWHJKDqNMeZvWtp+asm
	 dbEeXbIAQMgAQ7YZ9WmRcWJ0AbwTWyetu8ZLZ6/EAr0HTf62apdz/AABrzRVU29pC5
	 sOa0AGaEKdrploibnUJ84PAu0I/3dK8kOBuYpkvbKItN4aXN8NsVVqiEf3Xu6g21mz
	 OAmppWrVpKahg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BC248774E; Mon,  4 Dec 2023 08:28:13 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7977C8759E
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 08:28:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4SkFd66BpYz9sNv;
 Mon,  4 Dec 2023 08:28:10 +0100 (CET)
Message-ID: <d2624b56-af2d-4d6d-ab54-c1c9c354e627@denx.de>
Date: Mon, 4 Dec 2023 08:28:06 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/5] cyclic: Add a symbol for SPL
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng@tinylab.org>, Devarsh Thakkar <devarsht@ti.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Harald Seiler <hws@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Nikhil M Jain
 <n-jain1@ti.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Troy Kisky <troykiskyboundary@gmail.com>
References: <20231202153400.537050-1-sjg@chromium.org>
 <20231202153400.537050-2-sjg@chromium.org>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20231202153400.537050-2-sjg@chromium.org>
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

On 12/2/23 16:33, Simon Glass wrote:
> The cyclic subsystem is currently enabled either in all build phases
> or none. For tools this should not be enabled, but since lib/shc256.c
> and other files include watchdog.h in the host build, we must make
> sure that it is not enabled there.
> 
> Add an SPL symbol so that there is more control of this.
> 
> Add an include into cyclic.h so that tools can include this file.
> 
> Also add the kconfig.h header so that CONFIG_IS_ENABLED() works. We
> could avoid this for now by moving the location of the watchdog.h
> inclusion to outside the USE_HOSTCC area. But at some point the #ifdefs
> from these files will likely be removed, so there is no benefit in
> going that way.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
> 
> Changes in v2:
> - Add an SPL_CYCLIC symbol
> - Add a lot more explanation about the header files
> 
>   common/Kconfig                    | 8 ++++++++
>   common/Makefile                   | 2 +-
>   drivers/watchdog/Kconfig          | 1 +
>   include/asm-generic/global_data.h | 2 +-
>   include/cyclic.h                  | 6 ++++--
>   5 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/common/Kconfig b/common/Kconfig
> index 0283701f1d05..5906a4af7c33 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -626,6 +626,14 @@ config CYCLIC
>   
>   if CYCLIC
>   
> +config SPL_CYCLIC
> +	bool "General-purpose cyclic execution mechanism (SPL)"
> +	help
> +	  This enables a general-purpose cyclic execution infrastructure in SPL,
> +	  to allow "small" (run-time wise) functions to be executed at
> +	  a specified frequency. Things like LED blinking or watchdog
> +	  triggering are examples for such tasks.
> +
>   config CYCLIC_MAX_CPU_TIME_US
>   	int "Sets the max allowed time for a cyclic function in us"
>   	default 1000
> diff --git a/common/Makefile b/common/Makefile
> index 1495436d5d45..27443863bf9b 100644
> --- a/common/Makefile
> +++ b/common/Makefile
> @@ -77,7 +77,7 @@ obj-$(CONFIG_CROS_EC) += cros_ec.o
>   obj-y += dlmalloc.o
>   obj-$(CONFIG_$(SPL_TPL_)SYS_MALLOC_F) += malloc_simple.o
>   
> -obj-$(CONFIG_CYCLIC) += cyclic.o
> +obj-$(CONFIG_$(SPL_TPL_)CYCLIC) += cyclic.o
>   obj-$(CONFIG_$(SPL_TPL_)EVENT) += event.o
>   
>   obj-$(CONFIG_$(SPL_TPL_)HASH) += hash.o
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 07fc4940e918..378435c55cc7 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -395,6 +395,7 @@ config WDT_ARM_SMC
>   config SPL_WDT
>   	bool "Enable driver model for watchdog timer drivers in SPL"
>   	depends on SPL_DM
> +	select SPL_CYCLIC if CYCLIC
>   	help
>   	  Enable driver model for watchdog timer in SPL.
>   	  This is similar to CONFIG_WDT in U-Boot.
> diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
> index e8c6412e3f8d..77f11a4383c9 100644
> --- a/include/asm-generic/global_data.h
> +++ b/include/asm-generic/global_data.h
> @@ -485,7 +485,7 @@ struct global_data {
>   	 */
>   	struct event_state event_state;
>   #endif
> -#ifdef CONFIG_CYCLIC
> +#if CONFIG_IS_ENABLED(CYCLIC)
>   	/**
>   	 * @cyclic_list: list of registered cyclic functions
>   	 */
> diff --git a/include/cyclic.h b/include/cyclic.h
> index 44ad3cb6b803..d3b368dd90df 100644
> --- a/include/cyclic.h
> +++ b/include/cyclic.h
> @@ -11,6 +11,7 @@
>   #ifndef __cyclic_h
>   #define __cyclic_h
>   
> +#include <linux/kconfig.h>
>   #include <linux/list.h>
>   #include <asm/types.h>
>   
> @@ -44,7 +45,8 @@ struct cyclic_info {
>   /** Function type for cyclic functions */
>   typedef void (*cyclic_func_t)(void *ctx);
>   
> -#if defined(CONFIG_CYCLIC)
> +#if CONFIG_IS_ENABLED(CYCLIC)
> +
>   /**
>    * cyclic_register - Register a new cyclic function
>    *
> @@ -122,6 +124,6 @@ static inline int cyclic_unregister_all(void)
>   {
>   	return 0;
>   }
> -#endif
> +#endif /* CYCLIC */
>   
>   #endif

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
