Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9727C19F5C
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 12:12:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3305687467;
	Fri, 20 Oct 2023 14:12:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6752A87470; Fri, 20 Oct 2023 14:12:54 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 4ED1586FCD
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 14:12:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A402F2F4;
 Fri, 20 Oct 2023 05:13:32 -0700 (PDT)
Received: from e130802.arm.com (unknown [10.57.95.16])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A2D333F5A1;
 Fri, 20 Oct 2023 05:12:50 -0700 (PDT)
Date: Fri, 20 Oct 2023 13:12:43 +0100
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: sjg@chromium.org
Cc: nd@arm.com, trini@konsulko.com, u-boot@lists.denx.de,
 xueliang.zhong@arm.com
Subject: Re: [PATCH v2 1/2] log: select physical address formatting in a
 generic way
Message-ID: <20231020121243.GA162561@e130802.arm.com>
References: <CAPnjgZ34z865voaKeShSJpdvWcFLbN0OEWBnus4qt0W_1P4jBw@mail.gmail.com>
 <20230816110551.86930-1-abdellatif.elkhlifi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816110551.86930-1-abdellatif.elkhlifi@arm.com>
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

> sets the log formatting according to the platform (64-bit vs 32-bit)
> 
> Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  cmd/armffa.c  | 8 --------
>  include/log.h | 9 +++++++++
>  2 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/cmd/armffa.c b/cmd/armffa.c
> index 7e6eafc03a..ab0fd54d97 100644
> --- a/cmd/armffa.c
> +++ b/cmd/armffa.c
> @@ -13,14 +13,6 @@
>  #include <stdlib.h>
>  #include <asm/io.h>
>  
> -/* Select the right physical address formatting according to the platform */
> -#ifdef CONFIG_PHYS_64BIT
> -#define PhysAddrLength "ll"
> -#else
> -#define PhysAddrLength ""
> -#endif
> -#define PHYS_ADDR_LN "%" PhysAddrLength "x"
> -
>  /**
>   * ffa_get_dev() - Return the FF-A device
>   * @devp:	pointer to the FF-A device
> diff --git a/include/log.h b/include/log.h
> index 6e84f080ef..3f631d6816 100644
> --- a/include/log.h
> +++ b/include/log.h
> @@ -370,6 +370,15 @@ void __assert_fail(const char *assertion, const char *file, unsigned int line,
>  #define log_msg_retz(_msg, _ret) ((void)(_msg), _ret)
>  #endif
>  
> +/* Select the right physical address formatting according to the platform */
> +#ifdef CONFIG_PHYS_64BIT
> +#define PhysAddrLength "ll"
> +#else
> +#define PhysAddrLength ""
> +#endif
> +#define PHYS_ADDR_LN "%" PhysAddrLength "x"
> +#define PHYS_ADDR_LNU "%" PhysAddrLength "u"
> +
>  /** * enum log_rec_flags - Flags for a log record */
>  enum log_rec_flags {
>  	/** @LOGRECF_FORCE_DEBUG: Force output of debug record */
> -- 
> 2.25.1
> 

Any feedback about this specific commit please ?

A gentle reminder about the context: While I was working on the FF-A support,
you suggested that I move PHYS_ADDR_LN macros to a common location so it can be used
in a generic way.

Cheers,
Abdellatif
