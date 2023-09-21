Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0CFDE71096
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 16:38:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 439A9864EC;
	Thu, 21 Sep 2023 18:38:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinet.cat
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EF21866D0; Thu, 21 Sep 2023 18:38:52 +0200 (CEST)
Received: from mx1.tinet.cat (mx1.dipta.cat [195.76.233.59])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C53C864E9
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 18:38:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinet.cat
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xdrudis@tinet.cat
X-ASG-Debug-ID: 1695314329-12aaf22b8c125920001-4l7tJC
Received: from smtp01.tinet.cat (smtp.tinet.org [195.77.216.131]) by
 mx1.tinet.cat with ESMTP id ZiKCxibp2xmfqcVx;
 Thu, 21 Sep 2023 18:38:49 +0200 (CEST)
X-Barracuda-Envelope-From: xdrudis@tinet.cat
X-Barracuda-Effective-Source-IP: smtp.tinet.org[195.77.216.131]
X-Barracuda-Apparent-Source-IP: 195.77.216.131
Received: from xdrudis.tinet.cat (42.red-79-152-186.dynamicip.rima-tde.net
 [79.152.186.42])
 by smtp01.tinet.cat (Postfix) with ESMTPSA id E5A7B605DE41;
 Thu, 21 Sep 2023 18:38:48 +0200 (CEST)
Date: Thu, 21 Sep 2023 18:38:39 +0200
From: Xavier Drudis Ferran <xdrudis@tinet.cat>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: lukma@denx.de, seanga2@gmail.com, u-boot@lists.denx.de
Subject: Re: [SPAM] [PATCH] clk: fix count parameter type for clk_release_all
Message-ID: <ZQxxjz3S+3yJhC5R@xdrudis.tinet.cat>
X-ASG-Orig-Subj: Re: [SPAM] [PATCH] clk: fix count parameter type for
 clk_release_all
References: <20230619104752.278500-1-eugen.hristev@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230619104752.278500-1-eugen.hristev@collabora.com>
X-Barracuda-Connect: smtp.tinet.org[195.77.216.131]
X-Barracuda-Start-Time: 1695314329
X-Barracuda-URL: https://webmail.tinet.cat:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 2633
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5076 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=6.0 KILL_LEVEL=8.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.114412
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
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

El Mon, Jun 19, 2023 at 01:47:52PM +0300, Eugen Hristev deia:
> The second parameter for clk_release_all is used as an unsigned
> (which makes sense) but the function prototype declares it as an int.
> This causes warnings/error like such below:
> 
> include/clk.h:422:48: error: conversion to ‘int’ from ‘unsigned int’ may change the sign of the result [-Werror=sign-conversion]
>   422 |         return clk_release_all(bulk->clks, bulk->count);
> 
> To fix this, changed the type of the count to `unsigned int`
> 
> Fixes: 82a8a669b4f7 ("clk: add clk_release_all()")
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>

Reviewed-by: Xavier Drudis Ferran <xdrudis@tinet.cat>

> ---
>  drivers/clk/clk-uclass.c | 7 ++++---
>  include/clk.h            | 4 ++--
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> index dc3e9d6a2615..eada3a3a5b62 100644
> --- a/drivers/clk/clk-uclass.c
> +++ b/drivers/clk/clk-uclass.c
> @@ -416,12 +416,13 @@ int clk_get_by_name_nodev(ofnode node, const char *name, struct clk *clk)
>  	return clk_get_by_index_nodev(node, index, clk);
>  }
>  
> -int clk_release_all(struct clk *clk, int count)
> +int clk_release_all(struct clk *clk, unsigned int count)
>  {
> -	int i, ret;
> +	unsigned int i;
> +	int ret;
>

This could also be changed in clk_enable_blk() and clk_disable_blk().
It's unlikely that we get so many clocks for it to matter, but it's
till wrong to compare int i to unsigned int bulk->count.  That'd be a
different patch, though.

>  	for (i = 0; i < count; i++) {
> -		debug("%s(clk[%d]=%p)\n", __func__, i, &clk[i]);
> +		debug("%s(clk[%u]=%p)\n", __func__, i, &clk[i]);
>  
>  		/* check if clock has been previously requested */
>  		if (!clk[i].dev)
> diff --git a/include/clk.h b/include/clk.h
> index d91285235f79..a342297007b6 100644
> --- a/include/clk.h
> +++ b/include/clk.h
> @@ -243,7 +243,7 @@ static inline struct clk *devm_clk_get_optional(struct udevice *dev,
>   *
>   * Return: zero on success, or -ve error code.
>   */
> -int clk_release_all(struct clk *clk, int count);
> +int clk_release_all(struct clk *clk, unsigned int count);
>  
>  /**
>   * devm_clk_put	- "free" a managed clock source
> @@ -307,7 +307,7 @@ clk_get_by_name_nodev(ofnode node, const char *name, struct clk *clk)
>  	return -ENOSYS;
>  }
>  
> -static inline int clk_release_all(struct clk *clk, int count)
> +static inline int clk_release_all(struct clk *clk, unsigned int count)
>  {
>  	return -ENOSYS;
>  }
> -- 
> 2.34.1
> 
