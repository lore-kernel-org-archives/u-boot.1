Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D2C7C021AA
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 08:38:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46B908056B;
	Fri, 21 Feb 2025 09:38:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="wWRWa8hE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7E76806FE; Fri, 21 Feb 2025 09:38:21 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E7808007D
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 09:38:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E7CBF148034F; Fri, 21 Feb 2025 09:38:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1740127098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4KxfIzPFuxaSkB6vDc2geTFIK1MGBteUkJCx1YTJbe8=;
 b=wWRWa8hElvO+t2PD4V9TfpQ4+/aVOKlrPuTYZ8a+vO0wrbm/p7s/SeUl6YRKyROp9u61LY
 ZU2AbhDhHjWcRHFhAz5gY2WfBTbistDFgRgE/ci2LailerkgT3WlQ7emgqiVXluIAHTwM4
 yABomPyZDu8YT4fCAXcNgQtrwunxTl/c46rRRcyukY5cPigtNJqoCq5QhZ/ILlOtWCDUhC
 CVuM2v4nSDwPLx1fX846YggiHczQzgdzXSv/Cd+B6n/FX+2O+zRhHlzh52+PbZRs1Ralhh
 imXZlEAiz5KeJjMleq9KeFohXR3+t1WAPyiwYYXjc7ucWYL95E+/DuMjnJUjsg==
Date: Fri, 21 Feb 2025 09:38:08 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Liya Huang <1425075683@qq.com>,
 Adriano Cordova <adrianox@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Janne Grunau <j@jannau.net>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] lmb: move lmb_map_update_notify() to EFI
Message-ID: <20250221-evaluate-freefall-dccd46ec232c@thorsis.com>
Mail-Followup-To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Liya Huang <1425075683@qq.com>,
 Adriano Cordova <adrianox@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Janne Grunau <j@jannau.net>, u-boot@lists.denx.de
References: <20250216111241.6846-1-heinrich.schuchardt@canonical.com>
 <20250216111241.6846-3-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250216111241.6846-3-heinrich.schuchardt@canonical.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3
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

Hei hei,

Am Sun, Feb 16, 2025 at 12:12:40PM +0100 schrieb Heinrich Schuchardt:
> When building with qemu_arm64_defconfig with CONFIG_CC_OPTIMIZE_FOR_DEBUG=y
> and CONFIG_EFI_LOADER an error undefined reference to efi_add_memory_map_pg
> occurs.
> 
> Move the EFI dependent part of lmb_map_update_notify() to the EFI
> sub-system.
> 
> Reported-by: Liya Huang <1425075683@qq.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Acked-by: Liya Huang <1425075683@qq.com>

This seems to be the same underlying problem I reported back in January:

https://lore.kernel.org/u-boot/20250117-molecular-quicksand-e80bf947313e@thorsis.com/

FWIW, while your patch hit master, and the follow-up to my report did
not yet … you might be interested that master does not fail to build
the armv5 targets with CC_OPTIMIZE_FOR_DEBUG anymore.

Besides: keeping EFI code in the EFI subsystem seems the right
approach to me, too. ;-)

Thanks and Greets
Alex

> ---
>  include/efi_loader.h        | 15 +++++++++++++++
>  lib/efi_loader/efi_memory.c | 27 +++++++++++++++++++++++++++
>  lib/lmb.c                   | 31 +++----------------------------
>  3 files changed, 45 insertions(+), 28 deletions(-)
> 
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index dcae6a731a0..db3d20fd753 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -1263,6 +1263,21 @@ efi_status_t efi_disk_get_device_name(const efi_handle_t handle, char *buf, int
>   */
>  void efi_add_known_memory(void);
>  
> +/**
> + * efi_map_update_notify() - notify EFI of memory map changes
> + *
> + * @addr:	start of memory area
> + * @size:	size of memory area
> + * @op:		type of change
> + * Return:	0 if change could be processed
> + */
> +#ifdef CONFIG_EFI_LOADER
> +int efi_map_update_notify(phys_addr_t addr, phys_size_t size,
> +			  enum lmb_map_op op);
> +#else
> +#define efi_map_update_notify(addr, size, op) (0)
> +#endif
> +
>  /**
>   * efi_load_option_dp_join() - join device-paths for load option
>   *
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 1212772471e..11d092dc289 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -865,3 +865,30 @@ int efi_memory_init(void)
>  
>  	return 0;
>  }
> +
> +int efi_map_update_notify(phys_addr_t addr, phys_size_t size,
> +			  enum lmb_map_op op)
> +{
> +	u64 efi_addr;
> +	u64 pages;
> +	efi_status_t status;
> +
> +	efi_addr = (uintptr_t)map_sysmem(addr, 0);
> +	pages = efi_size_in_pages(size + (efi_addr & EFI_PAGE_MASK));
> +	efi_addr &= ~EFI_PAGE_MASK;
> +
> +	status = efi_add_memory_map_pg(efi_addr, pages,
> +				       op == LMB_MAP_OP_RESERVE ?
> +				       EFI_BOOT_SERVICES_DATA :
> +				       EFI_CONVENTIONAL_MEMORY,
> +				       false);
> +	if (status != EFI_SUCCESS) {
> +		log_err("LMB Map notify failure %lu\n",
> +			status & ~EFI_ERROR_MASK);
> +		return -1;
> +	}
> +	unmap_sysmem((void *)(uintptr_t)efi_addr);
> +
> +	return 0;
> +}
> +
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 7534a231c99..93fc1bea07c 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -426,37 +426,12 @@ long io_lmb_free(struct lmb *io_lmb, phys_addr_t base, phys_size_t size)
>  
>  static struct lmb lmb;
>  
> -static bool lmb_should_notify(u32 flags)
> -{
> -	return !lmb.test && !(flags & LMB_NONOTIFY) &&
> -		CONFIG_IS_ENABLED(EFI_LOADER);
> -}
> -
>  static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size,
>  				 enum lmb_map_op op, u32 flags)
>  {
> -	u64 efi_addr;
> -	u64 pages;
> -	efi_status_t status;
> -
> -	if (!lmb_should_notify(flags))
> -		return 0;
> -
> -	efi_addr = (uintptr_t)map_sysmem(addr, 0);
> -	pages = efi_size_in_pages(size + (efi_addr & EFI_PAGE_MASK));
> -	efi_addr &= ~EFI_PAGE_MASK;
> -
> -	status = efi_add_memory_map_pg(efi_addr, pages,
> -				       op == LMB_MAP_OP_RESERVE ?
> -				       EFI_BOOT_SERVICES_DATA :
> -				       EFI_CONVENTIONAL_MEMORY,
> -				       false);
> -	if (status != EFI_SUCCESS) {
> -		log_err("%s: LMB Map notify failure %lu\n", __func__,
> -			status & ~EFI_ERROR_MASK);
> -		return -1;
> -	}
> -	unmap_sysmem((void *)(uintptr_t)efi_addr);
> +	if (CONFIG_IS_ENABLED(EFI_LOADER) &&
> +	    !lmb.test && !(flags & LMB_NONOTIFY))
> +		return efi_map_update_notify(addr, size, op);
>  
>  	return 0;
>  }
> -- 
> 2.47.1
> 
