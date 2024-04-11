Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4810DCD128A
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 06:52:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC139883B5;
	Thu, 11 Apr 2024 08:52:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="NJ40uadq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="12HH5p9N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DA98883C9; Thu, 11 Apr 2024 08:52:31 +0200 (CEST)
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24669883AC
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 08:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=namcao@linutronix.de
Date: Thu, 11 Apr 2024 08:52:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1712818348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KeLzG/9o+1n1hnKiN6otSFoXfzV5VcLQzMIVuvN3ve4=;
 b=NJ40uadqjGY9UC3RoNczKT3KVunFuq4Zeo2Vk/t3prD8yYXbuMdRLzlBEZkP4NaJfWBmrT
 4s8u+S43hNDGyJf4x0sUvbmMSp8SrxlWsZ7ph+9KUl1MDI7F6vvcMqK2nRwN4jvLI1+lCi
 2CSNgz7bgrkgaBbrmqm0pUoS7VGrsULE1J9qoisURxtfFkeZHM5Jrf7KkbW/yRfoHqGQk3
 SXAOQgjcBx2Fu38Ck1YNQM5ITOlYm18BC2216Pu1MRxkAOY7lJSkMrgHgC/Tfl1ShZcKXy
 YUsgC01luQ/HDLlLONrDo7bFk8br+JQCfpqdm8rWzgXMvNzjZC3bh7zJAKQyfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1712818348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KeLzG/9o+1n1hnKiN6otSFoXfzV5VcLQzMIVuvN3ve4=;
 b=12HH5p9NKxOTbiOw6xLoo9yGzqV2aHt/NhZ/U5b2y4lnCkx7TEcuJCXfbn4EloT6zi9mw9
 k+k56j4ybLLt8fDA==
From: Nam Cao <namcao@linutronix.de>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Bin Meng
 <bmeng.cn@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] bootflow: always initialize bootflow_iter_set_dev
 parameters
Message-ID: <20240411085225.0b36a0e0@namcao>
In-Reply-To: <20240410221206.22782-1-heinrich.schuchardt@canonical.com>
References: <20240410221206.22782-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On 11/Apr/2024 Heinrich Schuchardt wrote:
> method_flags may be passed uninitialized to bootflow_iter_set_dev()
> if dev is not NULL.
> 
> Always initialize method_flags.
> 
> Addresses-Coverity-ID: 467057 Uninitialized scalar variable
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>

> ---
>  boot/bootflow.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/boot/bootflow.c b/boot/bootflow.c
> index 68bf99329ab..f659a414c79 100644
> --- a/boot/bootflow.c
> +++ b/boot/bootflow.c
> @@ -244,7 +244,7 @@ static int iter_incr(struct bootflow_iter *iter)
>  	if (iter->flags & BOOTFLOWIF_SINGLE_DEV) {
>  		ret = -ENOENT;
>  	} else {
> -		int method_flags;
> +		int method_flags = 0;
>  
>  		ret = 0;
>  		dev = iter->dev;
> @@ -263,7 +263,6 @@ static int iter_incr(struct bootflow_iter *iter)
>  		} else if (IS_ENABLED(CONFIG_BOOTSTD_FULL) &&
>  			   iter->flags & BOOTFLOWIF_SINGLE_MEDIA) {
>  			log_debug("next in single\n");
> -			method_flags = 0;
>  			do {
>  				/*
>  				 * Move to the next bootdev child of this media
> @@ -305,7 +304,6 @@ static int iter_incr(struct bootflow_iter *iter)
>  				}
>  			} else {
>  				ret = bootdev_next_prio(iter, &dev);
> -				method_flags = 0;
>  			}
>  		}
>  		log_debug("ret=%d, dev=%p %s\n", ret, dev,

