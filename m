Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D58C07E97
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 10:37:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86B00878B4;
	Tue,  5 Dec 2023 11:37:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NDfJt/j/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1816878BA; Tue,  5 Dec 2023 11:37:34 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5693878B3
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 11:37:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B5AbLAn055298;
 Tue, 5 Dec 2023 04:37:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701772641;
 bh=EEScvxIyN43GckoW0UOXeRWxv6XEatwKE1Lsd3O7S8A=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=NDfJt/j/+Nu4MaQZZSiNDb3Da61MRB+zkrRU+WCGuwHyKdWuRrK0WthiZoRE5qajs
 OWmFk6PNEmN031UM2rkerLnLtesceUbnvJ3c8AMbZ8Kjf8HwfM7rnFQ8FQ3PXfD+Cr
 9T9kAZlHg87R0xfJhSQUVINtjv+5scup/0YtVT+Q=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B5AbLoL057029
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 5 Dec 2023 04:37:21 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Dec 2023 04:37:21 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Dec 2023 04:37:21 -0600
Received: from [172.24.227.6] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B5AbGdi071968;
 Tue, 5 Dec 2023 04:37:17 -0600
Message-ID: <bb8d22bb-e430-e10e-af6a-223aa56f28f7@ti.com>
Date: Tue, 5 Dec 2023 16:07:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/5] cyclic: Add a symbol for SPL
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin
 <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng@tinylab.org>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Harald Seiler <hws@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Nikhil M Jain
 <n-jain1@ti.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>, Sean
 Anderson <sean.anderson@seco.com>, Stefan Roese <sr@denx.de>, Troy Kisky
 <troykiskyboundary@gmail.com>
References: <20231202153400.537050-1-sjg@chromium.org>
 <20231202153400.537050-2-sjg@chromium.org>
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20231202153400.537050-2-sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi Simon,

On 02/12/23 21:03, Simon Glass wrote:
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

Reviewed-by: Devarsh Thakkar <devarsht@ti.com>

Regards
Devarsh
> ---
> 
> Changes in v2:
> - Add an SPL_CYCLIC symbol
> - Add a lot more explanation about the header files
> 
>  common/Kconfig                    | 8 ++++++++
>  common/Makefile                   | 2 +-
>  drivers/watchdog/Kconfig          | 1 +
>  include/asm-generic/global_data.h | 2 +-
>  include/cyclic.h                  | 6 ++++--
>  5 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/common/Kconfig b/common/Kconfig
> index 0283701f1d05..5906a4af7c33 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -626,6 +626,14 @@ config CYCLIC
>  
>  if CYCLIC
>  
> +config SPL_CYCLIC
> +	bool "General-purpose cyclic execution mechanism (SPL)"
> +	help
> +	  This enables a general-purpose cyclic execution infrastructure in SPL,
> +	  to allow "small" (run-time wise) functions to be executed at
> +	  a specified frequency. Things like LED blinking or watchdog
> +	  triggering are examples for such tasks.
> +
>  config CYCLIC_MAX_CPU_TIME_US
>  	int "Sets the max allowed time for a cyclic function in us"
>  	default 1000
> diff --git a/common/Makefile b/common/Makefile
> index 1495436d5d45..27443863bf9b 100644
> --- a/common/Makefile
> +++ b/common/Makefile
> @@ -77,7 +77,7 @@ obj-$(CONFIG_CROS_EC) += cros_ec.o
>  obj-y += dlmalloc.o
>  obj-$(CONFIG_$(SPL_TPL_)SYS_MALLOC_F) += malloc_simple.o
>  
> -obj-$(CONFIG_CYCLIC) += cyclic.o
> +obj-$(CONFIG_$(SPL_TPL_)CYCLIC) += cyclic.o
>  obj-$(CONFIG_$(SPL_TPL_)EVENT) += event.o
>  
>  obj-$(CONFIG_$(SPL_TPL_)HASH) += hash.o
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 07fc4940e918..378435c55cc7 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -395,6 +395,7 @@ config WDT_ARM_SMC
>  config SPL_WDT
>  	bool "Enable driver model for watchdog timer drivers in SPL"
>  	depends on SPL_DM
> +	select SPL_CYCLIC if CYCLIC
>  	help
>  	  Enable driver model for watchdog timer in SPL.
>  	  This is similar to CONFIG_WDT in U-Boot.
> diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
> index e8c6412e3f8d..77f11a4383c9 100644
> --- a/include/asm-generic/global_data.h
> +++ b/include/asm-generic/global_data.h
> @@ -485,7 +485,7 @@ struct global_data {
>  	 */
>  	struct event_state event_state;
>  #endif
> -#ifdef CONFIG_CYCLIC
> +#if CONFIG_IS_ENABLED(CYCLIC)
>  	/**
>  	 * @cyclic_list: list of registered cyclic functions
>  	 */
> diff --git a/include/cyclic.h b/include/cyclic.h
> index 44ad3cb6b803..d3b368dd90df 100644
> --- a/include/cyclic.h
> +++ b/include/cyclic.h
> @@ -11,6 +11,7 @@
>  #ifndef __cyclic_h
>  #define __cyclic_h
>  
> +#include <linux/kconfig.h>
>  #include <linux/list.h>
>  #include <asm/types.h>
>  
> @@ -44,7 +45,8 @@ struct cyclic_info {
>  /** Function type for cyclic functions */
>  typedef void (*cyclic_func_t)(void *ctx);
>  
> -#if defined(CONFIG_CYCLIC)
> +#if CONFIG_IS_ENABLED(CYCLIC)
> +
>  /**
>   * cyclic_register - Register a new cyclic function
>   *
> @@ -122,6 +124,6 @@ static inline int cyclic_unregister_all(void)
>  {
>  	return 0;
>  }
> -#endif
> +#endif /* CYCLIC */
>  
>  #endif
