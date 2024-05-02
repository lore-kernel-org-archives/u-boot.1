Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA7AFC04FFE
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 06:48:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2279A88D10;
	Thu,  2 May 2024 08:48:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="d8fMrWRU";
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="s5y6sOwc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C74888D11; Thu,  2 May 2024 08:48:16 +0200 (CEST)
Received: from mail.kernel-space.org (mail.kernel-space.org [195.201.34.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FC0C88D03
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 08:48:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
Received: from kernel-space.org (localhost [127.0.0.1])
 by kernel-space.org (OpenSMTPD) with ESMTP id 908cb0aa;
 Thu, 2 May 2024 06:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=s1; bh=pb
 mwUqvhu2Sc7OAAKWKFC19ziEg=; b=d8fMrWRUyrGK+fWvSsaIQH5UGI0usO7JR3
 4Ji9zp0eYA4h2k2Dc2xs8dJBaNlGXSt9TE9pzlTieftekATnvL+8phGt3LE5rAWe
 B4wjc/rRknbvoBeZDtQGez3NQ1+W66P4txTrB6vY4pjdwkdwAreJvWY9BVuNiRqX
 lG96YSPvo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:references:from
 :in-reply-to:content-type:content-transfer-encoding; q=dns; s=s1; b=
 tZIaJ/zml3dtvvOamiE9K5vEshbaUg2c+wbg5hdVuFyAR1l2vTZ0TGw+D2GR3nUZ
 2Ab1/OdnWn9JnqTvOvw1GXbGlPQ8lq9IHYCM3wW0jBjDZrGws3j8g1ZktojN0GIj
 h7lLipeY8ZYKWcAJPwxXr8KmxNqwWcBvhZkngyocjOQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1714632490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=//AKa2Okcf0pibVzz1ZikDaUfkOzeUj+cIOb4zyL9co=;
 b=s5y6sOwcBvl4tFxTn6Pk0dyzzhbcWrzK926jAaUDEL3PfNyPYyYbpbxPZ9SLAbR6QonFwO
 fI8KXnSS06UBw2Bqj2Jh5VcA3sfrhWoHljN0kOQZNRQZ0QrMjLcVj4i1KTFyTh7iKd+pnz
 8eFxYBVcmDz1HrJFMR+9u3dDrIFQcZY=
Received: from [192.168.0.2] (host-79-16-6-199.retail.telecomitalia.it
 [79.16.6.199])
 by kernel-space.org (OpenSMTPD) with ESMTPSA id 17f0c139
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 2 May 2024 06:48:10 +0000 (UTC)
Message-ID: <01742e9c-4736-43ae-8b69-507367d63a97@kernel-space.org>
Date: Thu, 2 May 2024 08:47:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 040/149] board: cobra5272: Remove <common.h> and add
 needed includes
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20240501024316.1767971-1-trini@konsulko.com>
 <20240501024316.1767971-40-trini@konsulko.com>
Content-Language: en-US
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <20240501024316.1767971-40-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Tom,

Acked-by:Angelo Dureghello <angelo@kernel-space.org>

On 01/05/24 4:41 AM, Tom Rini wrote:
> Remove <common.h> from this board vendor directory and when needed
> add missing include files directly.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Angelo Dureghello <angelo@kernel-space.org>
> ---
>   board/cobra5272/cobra5272.c | 2 +-
>   board/cobra5272/flash.c     | 6 +++++-
>   2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/board/cobra5272/cobra5272.c b/board/cobra5272/cobra5272.c
> index 69a9df942311..774aa82b57fe 100644
> --- a/board/cobra5272/cobra5272.c
> +++ b/board/cobra5272/cobra5272.c
> @@ -4,7 +4,7 @@
>    * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
>    */
>   
> -#include <common.h>
> +#include <config.h>
>   #include <init.h>
>   #include <asm/global_data.h>
>   #include <asm/immap.h>
> diff --git a/board/cobra5272/flash.c b/board/cobra5272/flash.c
> index 8416af163ad1..157b71da85e8 100644
> --- a/board/cobra5272/flash.c
> +++ b/board/cobra5272/flash.c
> @@ -4,13 +4,17 @@
>    * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
>    */
>   
> -#include <common.h>
> +#include <config.h>
>   #include <console.h>
>   #include <cpu_func.h>
>   #include <flash.h>
>   #include <irq_func.h>
> +#include <stdio.h>
> +#include <time.h>
>   #include <uuid.h>
> +#include <vsprintf.h>
>   #include <linux/delay.h>
> +#include <linux/string.h>
>   
>   #define PHYS_FLASH_1 CFG_SYS_FLASH_BASE
>   #define FLASH_BANK_SIZE 0x200000
