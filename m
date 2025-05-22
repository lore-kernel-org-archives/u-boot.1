Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B89C54756
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 07:05:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 247A482E31;
	Thu, 22 May 2025 09:05:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HApxgxVZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E26F82F8E; Thu, 22 May 2025 09:05:51 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B46182E28
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 09:05:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7333049E75;
 Thu, 22 May 2025 07:05:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09944C4CEE4;
 Thu, 22 May 2025 07:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747897547;
 bh=9TQXwCkIUH8zZRRTjJHmlWXnlq2qodIvp5Vw0Plcqjw=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=HApxgxVZ1+NXCe16wYzAvvqYJ8SW2GT9Ex3wBRYEwnzgt0vEGdg1M1Mdmskb+PiPO
 FOBlABxGpjXmBOMwc2qdooWq+bKfYlkglSQJvwUobsd0Af1xZwkxs8IH2LmB3E/gCU
 /raYrWkuW93KeISWW2l/JF1eYSnOeX6ONw+dR1BNzcTg1wOeEJPT2cao5ewdfdnGJo
 rbLBKjD3tAp2ua7N8vKD7Pe1mUMVHjV8ZOh6saXdp1C/4cl/IZvVl5eBY8/alrUpdU
 /AWrn/ACNDPq3baZAAvdb7wpf2cJ8tGL34yTjNClWKIJAnFV8tSUTFkeAd3uaoKsyj
 LhVu1XLpPuRsw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH 09/17] include/dfu.h: Audit include list
In-Reply-To: <20250521230119.2084088-10-trini@konsulko.com>
References: <20250521230119.2084088-1-trini@konsulko.com>
 <20250521230119.2084088-10-trini@konsulko.com>
Date: Thu, 22 May 2025 09:05:45 +0200
Message-ID: <877c29gm5y.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Thank you for the patch.

On mer., mai 21, 2025 at 16:51, Tom Rini <trini@konsulko.com> wrote:

> This file does not need a forward declaration of 'struct list_head' as
> it includes <linux/list.h> so remove it.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> ---
>  include/dfu.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/dfu.h b/include/dfu.h
> index 12f9dfcdfcdf..80593a906fd2 100644
> --- a/include/dfu.h
> +++ b/include/dfu.h
> @@ -173,7 +173,6 @@ struct dfu_entity {
>  	unsigned int inited:1;
>  };
>  
> -struct list_head;
>  extern struct list_head dfu_list;
>  
>  #ifdef CONFIG_SET_DFU_ALT_INFO
> -- 
> 2.43.0
