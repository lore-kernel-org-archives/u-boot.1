Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDD5C4167B
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 12:48:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D4908754B;
	Wed,  8 Nov 2023 13:47:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="JtZ35EfO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F21D5875A7; Wed,  8 Nov 2023 13:47:58 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DDE58715E
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 13:47:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Date: Wed, 8 Nov 2023 13:47:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1699447674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U8tt3Bq5+s9AI5VsELJ3EA+amJATfR4X5+MeYawmScA=;
 b=JtZ35EfOYLPBx9oKOryaRU5rKxlQJjt3jvtbvUyyV9YYaVybNgtuYPUvbhVvRbZ32WncSL
 c59iplkbBM0Opx1ESv5C+InnAvxjX3UhmxD8Fbsrj4Ctwzj1pwe0omk0MDjIXwS1SiQ2Q0
 G23SjxNkQ5cRxhDfeFII8j4nMCq7/PsKKl5Vm+xVnH0IFkmiNltwYhsZoT3et8rKwGhAye
 VKMGP0Vq3B8ybnMNIRKs61PY0fpdsNmiTA/jjDlO3LBEbDe6wsEJtkXVAr4DnpIsrTxD5S
 Z+xXyuQ/4j/5ymJN3AE3FGBSB/v8RqRmCQDdNzhc6Uy1tPpJSwPXds2JOp2WPg==
From: Alexander Dahl <ada@thorsis.com>
To: christian.taedcke-oss@weidmueller.com
Cc: u-boot@lists.denx.de,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v1 1/2] fs: fat: add macro to convert u8[2] to u16
Message-ID: <20231108-yield-virtual-b8409f93318f@ifak-system.com>
Mail-Followup-To: christian.taedcke-oss@weidmueller.com, u-boot@lists.denx.de,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
References: <20231108121239.26737-1-christian.taedcke-oss@weidmueller.com>
 <20231108121239.26737-2-christian.taedcke-oss@weidmueller.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231108121239.26737-2-christian.taedcke-oss@weidmueller.com>
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

Hello Christian,

Am Wed, Nov 08, 2023 at 01:12:38PM +0100 schrieb christian.taedcke-oss@weidmueller.com:
> From: Christian Taedcke <christian.taedcke@weidmueller.com>
> 
> This reduces code duplications.
> 
> Signed-off-by: Christian Taedcke <christian.taedcke@weidmueller.com>
> ---
> 
>  fs/fat/fat.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/fat/fat.c b/fs/fat/fat.c
> index 8ff1fd0ec8..8a0f4e4e6c 100644
> --- a/fs/fat/fat.c
> +++ b/fs/fat/fat.c
> @@ -25,6 +25,8 @@
>  #include <linux/compiler.h>
>  #include <linux/ctype.h>
>  
> +#define FATU8ARRAY2CPU16(x) (((x)[1] << 8) + (x)[0])

This does the same as the generic `get_unaligned_le16()` … why not use
that?

Greets
Alex

> +
>  /*
>   * Convert a string to lowercase.  Converts at most 'len' characters,
>   * 'len' may be larger than the length of 'str' if 'str' is NULL
> @@ -571,7 +573,7 @@ static int get_fs_info(fsdata *mydata)
>  		mydata->total_sect = bs.total_sect;
>  	} else {
>  		mydata->fatlength = bs.fat_length;
> -		mydata->total_sect = (bs.sectors[1] << 8) + bs.sectors[0];
> +		mydata->total_sect = FATU8ARRAY2CPU16(bs.sectors);
>  		if (!mydata->total_sect)
>  			mydata->total_sect = bs.total_sect;
>  	}
> @@ -583,7 +585,7 @@ static int get_fs_info(fsdata *mydata)
>  
>  	mydata->rootdir_sect = mydata->fat_sect + mydata->fatlength * bs.fats;
>  
> -	mydata->sect_size = (bs.sector_size[1] << 8) + bs.sector_size[0];
> +	mydata->sect_size = FATU8ARRAY2CPU16(bs.sector_size);
>  	mydata->clust_size = bs.cluster_size;
>  	if (mydata->sect_size != cur_part_info.blksz) {
>  		log_err("FAT sector size mismatch (fs=%u, dev=%lu)\n",
> @@ -607,8 +609,7 @@ static int get_fs_info(fsdata *mydata)
>  					(mydata->clust_size * 2);
>  		mydata->root_cluster = bs.root_cluster;
>  	} else {
> -		mydata->rootdir_size = ((bs.dir_entries[1]  * (int)256 +
> -					 bs.dir_entries[0]) *
> +		mydata->rootdir_size = (FATU8ARRAY2CPU16(bs.dir_entries) *
>  					 sizeof(dir_entry)) /
>  					 mydata->sect_size;
>  		mydata->data_begin = mydata->rootdir_sect +
> -- 
> 2.34.1
> 
