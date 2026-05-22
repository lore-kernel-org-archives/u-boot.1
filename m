Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D45ECD5BB0
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 13:28:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B69D846DE;
	Fri, 22 May 2026 15:28:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="1LIpjX1B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FAD6846E2; Fri, 22 May 2026 15:28:49 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 405D1846C0
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 15:28:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id CC6E94E42D24;
 Fri, 22 May 2026 13:28:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 9137B6003C;
 Fri, 22 May 2026 13:28:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EFE561081140A; 
 Fri, 22 May 2026 15:28:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779456526; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=fvBLjvRMFbLF5Z8VyR4l0rmjKwZYP8BAKj6EmnDUkrk=;
 b=1LIpjX1BC+b20sTVRLGGe7OfCBW4jWYxs1M8AqoUa/X3zPzw0MwK52D7pPbPdSrIzvIvgB
 cAF6AFzvthTk3RM+uD5KIdvRs3otwp/GA+c4xAwQCaQhI6j/Brb4Wp2m5aP90o3I0nwDCC
 FQVj5Dr/nuIaASlrYw+SOlVhboPBI1PtDkfAolw1wwgvdrDFZJFtcUTKZ6E+W9du8ARq1J
 6oyoMjg2gNNAzAXagwfYvyqaMuPJG0a3sP+y4lWbWYgYFXIaRXihxcaLboEY08+gIjYaB9
 Vp377M3G8F186ElVOMpEpeCGSQHCzoVs0V8rMFGGHIGMluY8CTFwOsrL3k//aw==
Message-ID: <a4167328-4ca3-4e71-9d77-a287131891ea@bootlin.com>
Date: Fri, 22 May 2026 15:28:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] fs/squashfs: fix heap exhaustion during symlink
 resolution
To: Allan ELKAIM <allan.elkaim@gmail.com>, u-boot@lists.denx.de
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Joao Marcos Costa <jmcosta944@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tom Rini <trini@konsulko.com>
References: <"CACgNL-F2=KJtZ+gThpx_BuWsn6puqFxK0uLOmnABSS9=rRQmeQ@mail.gmail.com">
 <20260514181854.399679-3-allan.elkaim@gmail.com>
 <20260514181854.399679-5-allan.elkaim@gmail.com>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <20260514181854.399679-5-allan.elkaim@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Le 14/05/2026 à 20:18, Allan ELKAIM a écrit :
> When sqfs_read_nest() encounters a symlink it resolves it by calling
> itself recursively. In the unfixed code this looks like:
> 
>    // dirsp is open: inode_table + dir_table still on heap
>    resolved = sqfs_resolve_symlink(symlink, filename);
>    ret = sqfs_read_nest(resolved, ...); // recursive: allocates a new
>                                         // inode_table + dir_table pair
>    free(resolved);
>    goto out;
>    // out: sqfs_closedir(dirsp) <- parent tables freed HERE, too late
> 
> There is no permanent leak: the parent's tables are freed at the
> out: label once the recursive call returns. However, for the entire
> duration of the recursive call both the parent's inode_table +
> dir_table and the child's inode_table + dir_table are live on the
> heap simultaneously. On large squashfs images these tables can be
> significant in size, and this temporary double allocation may exhaust
> the heap budget.
> 
> A superficial workaround would be to increase CONFIG_SYS_MALLOC_LEN,
> but that wastes memory on all boards and does not address the
> structural problem. The correct fix is to change the freeing order:
> release the parent directory's resources before recursing. This way
> only one set of inode and directory tables is live at any given time,
> halving the peak heap usage during symlink resolution.
> 
> When heap exhaustion does occur and malloc returns NULL for dir_table
> or pos_list inside sqfs_read_directory_table(), the failure is
> currently silent and cascading:
> 
>    - metablks_count is not reset to -1 before the goto out, so the
>      function returns a positive block count alongside a NULL pointer.
>    - sqfs_opendir_nest() does not detect the failure (it only checks
>      metablks_count < 1) and calls sqfs_search_dir() with m_list=NULL.
>    - sqfs_dir_offset() iterates over m_list[0..n], reading from
>      addresses 0x0, 0x4, 0x8, ... None of those values match the
>      inode's start_block, so the function returns -EINVAL.
>    - The error propagates up as a load failure with no indication
>      that the root cause was heap exhaustion:
> 
>        Error: invalid inode reference to directory table.
>        Failed to load '<symlink path>'
> 
> Two fixes:
> 1. In sqfs_read_directory_table(), set metablks_count = -1 whenever
>     malloc fails after sqfs_count_metablks() returns a positive value,
>     so that the caller's "metablks_count < 1" check correctly detects
>     the failure and avoids calling sqfs_search_dir() with a NULL
>     pos_list.
> 2. In sqfs_read_nest() and sqfs_size_nest(), call sqfs_closedir() on
>     the parent dirsp before the recursive call so that the parent's
>     inode and directory tables are freed before the child allocates
>     its own. Only one set of tables is then live at any given time,
>     halving peak heap usage during symlink resolution.
> 
> Link: https://lists.denx.de/pipermail/u-boot/2026-May/618533.html
> 
This looks great!

Reviewed-by: Richard Genoud <richard.genoud@bootlin.com>
> Signed-off-by: Allan ELKAIM <allan.elkaim@gmail.com>
> ---
> 
>   fs/squashfs/sqfs.c | 22 ++++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
> index 9cb8b4af..07e2bd82 100644
> --- a/fs/squashfs/sqfs.c
> +++ b/fs/squashfs/sqfs.c
> @@ -853,12 +853,16 @@ static int sqfs_read_directory_table(unsigned char **dir_table, u32 **pos_list)
>   		goto out;
>   
>   	*dir_table = malloc(metablks_count * SQFS_METADATA_BLOCK_SIZE);
> -	if (!*dir_table)
> +	if (!*dir_table) {
> +		metablks_count = -1;
>   		goto out;
> +	}
>   
>   	*pos_list = malloc(metablks_count * sizeof(u32));
> -	if (!*pos_list)
> +	if (!*pos_list) {
> +		metablks_count = -1;
>   		goto out;
> +	}
>   
>   	ret = sqfs_get_metablk_pos(*pos_list, dtb, table_offset,
>   				   metablks_count);
> @@ -1473,6 +1477,15 @@ static int sqfs_read_nest(const char *filename, void *buf, loff_t offset,
>   
>   		symlink = (struct squashfs_symlink_inode *)ipos;
>   		resolved = sqfs_resolve_symlink(symlink, filename);
> +		/*
> +		 * Free the parent directory resources before recursing so that
> +		 * the recursive call can allocate its own inode and directory
> +		 * tables without exhausting the heap.
> +		 */
> +		free(dirs->entry);
> +		dirs->entry = NULL;
> +		sqfs_closedir(dirsp);
> +		dirsp = NULL;
>   		ret = sqfs_read_nest(resolved, buf, offset, len, actread);
>   		free(resolved);
>   		goto out;
> @@ -1731,6 +1744,11 @@ static int sqfs_size_nest(const char *filename, loff_t *size)
>   
>   		symlink = (struct squashfs_symlink_inode *)ipos;
>   		resolved = sqfs_resolve_symlink(symlink, filename);
> +		/*
> +		 * Free the parent directory resources before recursing.
> +		 */
> +		sqfs_closedir(dirsp);
> +		dirsp = NULL;
>   		ret = sqfs_size(resolved, size);
>   		free(resolved);
>   		break;

Thanks!
