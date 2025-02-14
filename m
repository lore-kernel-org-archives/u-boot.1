Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D874C02198
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 09:12:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE4B6801CF;
	Fri, 14 Feb 2025 10:12:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="IEeu+ycc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01906806FE; Fri, 14 Feb 2025 10:12:20 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [IPv6:2003:a:e28:26e4::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4293801BE
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 10:12:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 190001483D0F; Fri, 14 Feb 2025 10:12:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1739524336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uAecr0jtUsv0ZDCwKHV0gv9cZpK7OBlbhuDIuIXQd6k=;
 b=IEeu+yccSOOAFHYiGEkttnbpV7dcE6i7wPLTeO/MnWCHlRgkkceITE5CwvoKB1v6vomyXY
 Uu85kVnk8o9jGv759zFWmcCyRvzoB+nzbLDU71rMOrIlfLMvfpdHj/bxuBmqW3vzBESACp
 F85Q5qlubeUAEf7lg7XcUnyB10ruBeLylq1ZXKfp5DCUQycXvfclQ+KKTLo++Nu1/cVFG1
 rH5r2JoGRF4RUKJs0M4Wsp8qjouLs9vrJ5+3oEpUix79eBJ+IlkiN5TB8hJM/rB2OgBKK+
 JQ6UCcqbqNnkzlo8B+aaPc8MscKKCxMWzEDFkBiYJ1jE2UuM2KL55YOZK4KBfQ==
Date: Fri, 14 Feb 2025 10:12:09 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Udit Kumar <u-kumar1@ti.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 4/4] lmb: build lmb_map_update_notify() only with
 EFI_LOADER
Message-ID: <20250214-succulent-bleak-670947fe654f@thorsis.com>
Mail-Followup-To: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Udit Kumar <u-kumar1@ti.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
References: <20250213131104.186663-1-sughosh.ganu@linaro.org>
 <20250213131104.186663-5-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213131104.186663-5-sughosh.ganu@linaro.org>
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

Hello,

Am Thu, Feb 13, 2025 at 06:41:04PM +0530 schrieb Sughosh Ganu:
> The lmb_map_update_notify() function is used to update the EFI memory
> map based on corresponding changes in the LMB map. This is causing
> build failure with a certain old architecture(armv5) toolchain, when
> building with CONFIG_CC_OPTIMIZE_FOR_DEBUG symbol on platforms which
> do not enable the EFI_LOADER code. Build the code in
> lmb_map_update_notify() only when the EFI_LOADER config is enabled to
> get around this issue.
> 
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> Suggested-by: Tom Rini <trini@konsulko.com>
> ---
>  lib/lmb.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/lmb.c b/lib/lmb.c
> index a55bfe289db..7f4b2315b15 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -428,7 +428,7 @@ long io_lmb_free(struct lmb *io_lmb, phys_addr_t base, phys_size_t size)
>  
>  static struct lmb lmb;
>  
> -static bool lmb_should_notify(u32 flags)
> +static bool __maybe_unused lmb_should_notify(u32 flags)
>  {
>  	return !lmb.test && !(flags & LMB_NONOTIFY) &&
>  		CONFIG_IS_ENABLED(EFI_LOADER);
> @@ -437,6 +437,7 @@ static bool lmb_should_notify(u32 flags)
>  static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size, u8 op,
>  				 u32 flags)
>  {
> +#if CONFIG_IS_ENABLED(EFI_LOADER)
>  	u64 efi_addr;
>  	u64 pages;
>  	efi_status_t status;
> @@ -464,7 +465,7 @@ static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size, u8 op,
>  		return -1;
>  	}
>  	unmap_sysmem((void *)(uintptr_t)efi_addr);
> -
> +#endif
>  	return 0;
>  }
>  

Ported the post v2025.01 lmb changes to my tree, applied this series
on top, built with and without CONFIG_CC_OPTIMIZE_FOR_DEBUG set, and
briefly tested it on one of my targets.  Looks fine so far, now I can
proceed porting my things over to the latest release, and use gdb
again.  Thanks and you might add to this last patch:

Tested-by: Alexander Dahl <ada@thorsis.com>

Greets
Alex

