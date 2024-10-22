Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690DFD0E6FC
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 11:11:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D04F488D5C;
	Tue, 22 Oct 2024 13:11:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729595471;
	bh=Wd4clslP5gHepLuyXq5aB9/tdfNdeXRnS/0XptcKRO0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mCekaCsG2g6OAXnlEu+EIjCKcteJW6MHof+1z6SKESPV2rdr3Rhom5PsRjwJtLrpv
	 MOCXfrwMxZCJWyrDFcm2GsZU00J1wkhnFA7T42yZHRts8oKDvbfqq3FjBHVu/dWRYf
	 z7VWx2/s/TBMFfp0xuUlx40lbbrIhbzZc9ytQ3JcrhqZx4+9vwvlr7OrJheI4K2pi3
	 94Bz4r+TFWNfW4e+cWex1icTvEgUHP32oEs6y2wuPZBxZg33V4N2nS06hokNYluxeb
	 6TJt8DIpkVxKdb+jj+lojFNgwr99TFnG3NZIW3ZQssM7KsDziVTr8IDp7lKx+csJe+
	 /3RRTW9yvIYpA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B702288F4D; Tue, 22 Oct 2024 13:11:10 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D131888D5A
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 13:11:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4XXqHG5ZKJz9smy;
 Tue, 22 Oct 2024 13:11:06 +0200 (CEST)
Message-ID: <2a66e3b4-42de-4686-a1af-5dee67603df3@denx.de>
Date: Tue, 22 Oct 2024 13:11:05 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 02/13] cyclic: introduce u-boot/schedule.h
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20241003212802.3810-1-ravi@prevas.dk>
 <20241003212802.3810-3-ravi@prevas.dk>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20241003212802.3810-3-ravi@prevas.dk>
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

On 10/3/24 23:27, Rasmus Villemoes wrote:
> I noticed an "unnecessary" include of <cyclic.h> in
> global_data.h, in the sense that nothing in cyclic.h is needed in
> order to define 'struct global_data'.
> 
> Well, it's not unnecessary, as it implicitly ensures that everybody
> gets a declaration of schedule(), and schedule() is (obviously) called
> all over the tree. Almost none of those places directly include
> <cyclic.h>, but for historical reasons, many do include
> <watchdog.h> (most schedule() instances are replacements of
> WATCHDOG_RESET()).
> 
> However, very few TUs actually need the declarations of the
> cyclic_register() and struct cyclic_info, and they also don't really
> need anything from the watchdog.h header.
> 
> So introduce a new header which just contains a declaration of
> schedule(), which can then be included from all the places that do
> call schedule(). I removed the direct reference to cyclic_run(),
> because we shouldn't have two public functions for doing roughly the
> same without being very explicit about when one should call one or the
> other.
> 
> Testing of later patches that explicitly include <schedule.h> when
> schedule() is used revealed a problem with host tool build on win32,
> which apparently picked up a host <schedule.h>. To avoid that problem,
> put the new header in include/u-boot/ and hence make the include
> statements say <u-boot/schedule.h>.
> 
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   common/cyclic.c           |  1 +
>   include/cyclic.h          | 12 +-----------
>   include/u-boot/schedule.h | 24 ++++++++++++++++++++++++
>   3 files changed, 26 insertions(+), 11 deletions(-)
>   create mode 100644 include/u-boot/schedule.h
> 
> diff --git a/common/cyclic.c b/common/cyclic.c
> index ec38fad6775..38d815bec35 100644
> --- a/common/cyclic.c
> +++ b/common/cyclic.c
> @@ -15,6 +15,7 @@
>   #include <linux/errno.h>
>   #include <linux/list.h>
>   #include <asm/global_data.h>
> +#include <u-boot/schedule.h>
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> diff --git a/include/cyclic.h b/include/cyclic.h
> index cd95b691d48..e8de616dcd5 100644
> --- a/include/cyclic.h
> +++ b/include/cyclic.h
> @@ -13,6 +13,7 @@
>   
>   #include <linux/list.h>
>   #include <asm/types.h>
> +#include <u-boot/schedule.h> // to be removed later
>   
>   /**
>    * struct cyclic_info - Information about cyclic execution function
> @@ -94,13 +95,6 @@ struct hlist_head *cyclic_get_list(void);
>    */
>   void cyclic_run(void);
>   
> -/**
> - * schedule() - Schedule all potentially waiting tasks
> - *
> - * Basically a wrapper for cyclic_run(), pontentially enhanced by some
> - * other parts, that need to get handled periodically.
> - */
> -void schedule(void);
>   #else
>   
>   static inline void cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
> @@ -116,10 +110,6 @@ static inline void cyclic_run(void)
>   {
>   }
>   
> -static inline void schedule(void)
> -{
> -}
> -
>   static inline int cyclic_unregister_all(void)
>   {
>   	return 0;
> diff --git a/include/u-boot/schedule.h b/include/u-boot/schedule.h
> new file mode 100644
> index 00000000000..4fd34c41229
> --- /dev/null
> +++ b/include/u-boot/schedule.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef _U_BOOT_SCHEDULE_H
> +#define _U_BOOT_SCHEDULE_H
> +
> +#if CONFIG_IS_ENABLED(CYCLIC)
> +/**
> + * schedule() - Schedule all potentially waiting tasks
> + *
> + * Run all pending tasks registered via the cyclic framework, and
> + * potentially perform other actions that need to be done
> + * periodically.
> + */
> +void schedule(void);
> +
> +#else
> +
> +static inline void schedule(void)
> +{
> +}
> +
> +#endif
> +
> +#endif

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
