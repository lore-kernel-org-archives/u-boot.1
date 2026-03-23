Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861ECF46130
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 14:41:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CED884082;
	Mon, 23 Mar 2026 15:41:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tNs3DeO/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 014A2841DA; Mon, 23 Mar 2026 15:41:54 +0100 (CET)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD86A8406D
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 15:41:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.alibaba.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hsiangkao@linux.alibaba.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1774276905; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=0MLXON+tffXeSNtv8HxcDcXnRXOeI/mVCRcpRJJJa3E=;
 b=tNs3DeO/058cFcESysqVwhdl64RvVaWI2d7SZtzn4LMjGRAYWKTnXg3s0WXJUOjkBbR8cGGpq6LUV5EESNgEFYI/vuus0HF2YRPZwJ9JzNskecp//MEZTJhAnCuxIchRJKt+vxp+AVThwrWRm73f3WvusTczlzD7Y4SYmpbawm0=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045098064;
 MF=hsiangkao@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0X.YqmWQ_1774276895; 
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0X.YqmWQ_1774276895 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 23 Mar 2026 22:41:36 +0800
Message-ID: <b761dcf1-db25-47f3-8ef6-096c7a2f0493@linux.alibaba.com>
Date: Mon, 23 Mar 2026 22:41:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] fs/erofs: align the malloc'ed data
To: Michael Walle <mwalle@kernel.org>, Huang Jianan <jnhuang95@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: linux-erofs@lists.ozlabs.org, u-boot@lists.denx.de
References: <20260323134305.2675822-1-mwalle@kernel.org>
 <20260323134305.2675822-2-mwalle@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260323134305.2675822-2-mwalle@kernel.org>
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

Hi Michael,

On 2026/3/23 21:42, Michael Walle wrote:
> The data buffers are used to transfer from or to hardware peripherals.
> Often, there are restrictions on addresses, i.e. they have to be aligned
> at a certain size. Thus, allocate the data on the heap instead of the
> stack (at a random address alignment). Use malloc_cache_aligned() to get
> an aligned buffer.

Many thanks for the patch, I wonder if it's possible to
submit the patches to erofs-utils first (even make
malloc_cache_aligned() as another malloc() for example)?

Since I'd like to make u-boot codebase following
erofs-utils, but I don't think Jianan have the
bandwidth now, but if you have some use cases,
you could help syncing up a bit.

Or at least, let's keep these four patches in sync
between erofs-utils and u-boot.

Many thanks!
Gao Xiang

> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>   fs/erofs/data.c     | 11 ++++-------
>   fs/erofs/internal.h |  1 +
>   2 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index b58ec6fcc66..61dbae51a9a 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -319,15 +319,13 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
>   		}
>   
>   		if (map.m_plen > bufsize) {
> -			char *tmp;
> -
>   			bufsize = map.m_plen;
> -			tmp = realloc(raw, bufsize);
> -			if (!tmp) {
> +			free(raw);
> +			raw = malloc_cache_aligned(bufsize);
> +			if (!raw) {
>   				ret = -ENOMEM;
>   				break;
>   			}
> -			raw = tmp;
>   		}
>   
>   		ret = z_erofs_read_one_data(inode, &map, raw,
> @@ -336,8 +334,7 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
>   		if (ret < 0)
>   			break;
>   	}
> -	if (raw)
> -		free(raw);
> +	free(raw);
>   	return ret < 0 ? ret : 0;
>   }
>   
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 1875f37fcd2..13c862325a6 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -11,6 +11,7 @@
>   #include <linux/printk.h>
>   #include <linux/log2.h>
>   #include <inttypes.h>
> +#include <memalign.h>
>   #include "erofs_fs.h"
>   
>   #define erofs_err(fmt, ...)	\

