Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139FECDB466
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 08:11:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 907BB8493F;
	Thu, 25 Jun 2026 10:11:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="VMH7OJdi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AADC847C8; Thu, 25 Jun 2026 10:11:53 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 832B5847C8
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 10:11:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 321B04E408CB;
 Thu, 25 Jun 2026 08:11:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id F2AD05FF03;
 Thu, 25 Jun 2026 08:11:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5ABAF106C8415; 
 Thu, 25 Jun 2026 10:11:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782375109; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=k/6Fr1w6fC1W+teCtLHRWlg+2zYKDxevvGATrzVFP1Q=;
 b=VMH7OJdiWuUzcE6anQGr1aue0n2/EJX7RhThNFILKjY3TuCgH/xvdm1U7a8Y+7y4ohhQzp
 K0xF9Le351zTbijRMgvdZMBUR+U8mWaTMe2Q9fNKfigjSC3SGYi+xjg9/fjbisYfZbvRKZ
 GicntWbTvvKbqRloDcIDdnmGMOH3iXp40iq1JJecyiypYEIkBKa+mapkAReGvtP3w1iEO5
 fCr11h0HGIyqt1l1UeByGSLMnkvkuD14SlA6lwNxrcKNVFdgosEdbYHMYAJDqJLHNUcE72
 TtKRO4VuLoT/VCOEh2r8yx2pDHV8QMygtLp1DNJDd9IGFRAJBzQZw/xagm8MIg==
Message-ID: <84778359-6df5-4853-950f-78301950a1c5@bootlin.com>
Date: Thu, 25 Jun 2026 10:11:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/squashfs: fix out-of-bounds read while walking the
 inode table
To: Hem Parekh <hemparekh1596@gmail.com>, u-boot@lists.denx.de
Cc: joaomarcos.costa@bootlin.com, thomas.petazzoni@bootlin.com,
 miquel.raynal@bootlin.com, trini@konsulko.com, eric.kilmer@trailofbits.com
References: <20260611042151.57535-1-hemparekh1596@gmail.com>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <20260611042151.57535-1-hemparekh1596@gmail.com>
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

Hi Hem,
Le 11/06/2026 à 06:21, Hem Parekh a écrit :
> sqfs_find_inode() walks the uncompressed inode table for sblk->inodes
> iterations, advancing 'offset' by sqfs_inode_size() each step. Both the
> inode count and every per-inode size are taken verbatim from the on-disk
> (attacker-controlled) SquashFS image, but the walk was never bounded
> against the end of the heap buffer allocated in sqfs_read_inode_table()
> (metablks_count * SQFS_METADATA_BLOCK_SIZE bytes). A malformed image can
> therefore drive 'base = inode_table + offset' and the field reads in
> sqfs_inode_size() past the buffer, an out-of-bounds read reachable from
> any path lookup (e.g. 'ls'/'load' of a squashfs filesystem).
> 
> The SQFS_LDIR_TYPE branch of sqfs_inode_size() makes this worse: it
> loops i_count times reading di->size and advancing 'di' by
> sizeof(*di) + size with no bounds check at all, so a single crafted
> extended-directory inode walks 'di' arbitrarily far past the buffer.
> 
> Propagate the inode-table buffer size from sqfs_read_inode_table() into
> the dir stream and on into sqfs_find_inode(), and:
>   - reject any base inode whose fixed fields fall outside the table;
>   - pass the buffer end to sqfs_inode_size() and bound the LDIR index
>     walk against it;
>   - reject any computed inode size that pushes 'offset' past the buffer.
> 
> Reproduced with a standalone libc + AddressSanitizer harness replicating
> the verbatim sqfs_find_inode()/sqfs_inode_size() logic: the unpatched
> code faults on an OOB read inside the LDIR loop, the patched code rejects
> the malformed inode and returns NULL cleanly.
> 
> Signed-off-by: Hem Parekh <hemparekh1596@gmail.com>

While this patch is nice, IMHO the one from Piyush is addresses more issues
while solving the same problem.
cf https://lore.kernel.org/u-boot/20260612075424.83462-1-piyushthepal@gmail.com/


Thanks!

Regards,
Richard

> ---
>   fs/squashfs/sqfs.c            | 29 +++++++++++++++++------------
>   fs/squashfs/sqfs_filesystem.h |  5 +++--
>   fs/squashfs/sqfs_inode.c      | 20 ++++++++++++++++----
>   3 files changed, 36 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
> index 0768fc4a7b2..d92f8869284 100644
> --- a/fs/squashfs/sqfs.c
> +++ b/fs/squashfs/sqfs.c
> @@ -486,8 +486,9 @@ static int sqfs_search_dir(struct squashfs_dir_stream *dirs, char **token_list,
>   	dirsp = (struct fs_dir_stream *)dirs;
>   
>   	/* Start by root inode */
> -	table = sqfs_find_inode(dirs->inode_table, le32_to_cpu(sblk->inodes),
> -				sblk->inodes, sblk->block_size);
> +	table = sqfs_find_inode(dirs->inode_table, dirs->inode_table_size,
> +				le32_to_cpu(sblk->inodes), sblk->inodes,
> +				sblk->block_size);
>   	if (!table)
>   		return -EINVAL;
>   
> @@ -543,8 +544,9 @@ static int sqfs_search_dir(struct squashfs_dir_stream *dirs, char **token_list,
>   			dirs->dir_header->inode_number;
>   
>   		/* Get reference to inode in the inode table */
> -		table = sqfs_find_inode(dirs->inode_table, new_inode_number,
> -					sblk->inodes, sblk->block_size);
> +		table = sqfs_find_inode(dirs->inode_table, dirs->inode_table_size,
> +					new_inode_number, sblk->inodes,
> +					sblk->block_size);
>   		if (!table)
>   			return -EINVAL;
>   		dir = (struct squashfs_dir_inode *)table;
> @@ -719,7 +721,8 @@ static int sqfs_get_metablk_pos(u32 *pos_list, void *table, u32 offset,
>   	return ret;
>   }
>   
> -static int sqfs_read_inode_table(unsigned char **inode_table)
> +static int sqfs_read_inode_table(unsigned char **inode_table,
> +				 size_t *inode_table_size)
>   {
>   	struct squashfs_super_block *sblk = ctxt.sblk;
>   	u64 start, n_blks, table_offset, table_size;
> @@ -773,6 +776,8 @@ static int sqfs_read_inode_table(unsigned char **inode_table)
>   		goto free_itb;
>   	}
>   
> +	*inode_table_size = (size_t)metablks_count * SQFS_METADATA_BLOCK_SIZE;
> +
>   	src_table = itb + table_offset + SQFS_HEADER_SIZE;
>   
>   	/* Extract compressed Inode table */
> @@ -933,7 +938,7 @@ static int sqfs_opendir_nest(const char *filename, struct fs_dir_stream **dirsp)
>   	dirs->inode_table = NULL;
>   	dirs->dir_table = NULL;
>   
> -	ret = sqfs_read_inode_table(&inode_table);
> +	ret = sqfs_read_inode_table(&inode_table, &dirs->inode_table_size);
>   	if (ret) {
>   		ret = -EINVAL;
>   		goto out;
> @@ -1071,8 +1076,8 @@ static int sqfs_readdir_nest(struct fs_dir_stream *fs_dirs, struct fs_dirent **d
>   	}
>   
>   	i_number = dirs->dir_header->inode_number + dirs->entry->inode_offset;
> -	ipos = sqfs_find_inode(dirs->inode_table, i_number, sblk->inodes,
> -			       sblk->block_size);
> +	ipos = sqfs_find_inode(dirs->inode_table, dirs->inode_table_size,
> +			       i_number, sblk->inodes, sblk->block_size);
>   	if (!ipos)
>   		return -SQFS_STOP_READDIR;
>   
> @@ -1430,8 +1435,8 @@ static int sqfs_read_nest(const char *filename, void *buf, loff_t offset,
>   	}
>   
>   	i_number = dirs->dir_header->inode_number + dirs->entry->inode_offset;
> -	ipos = sqfs_find_inode(dirs->inode_table, i_number, sblk->inodes,
> -			       sblk->block_size);
> +	ipos = sqfs_find_inode(dirs->inode_table, dirs->inode_table_size,
> +			       i_number, sblk->inodes, sblk->block_size);
>   	if (!ipos) {
>   		ret = -EINVAL;
>   		goto out;
> @@ -1699,8 +1704,8 @@ static int sqfs_size_nest(const char *filename, loff_t *size)
>   	}
>   
>   	i_number = dirs->dir_header->inode_number + dirs->entry->inode_offset;
> -	ipos = sqfs_find_inode(dirs->inode_table, i_number, sblk->inodes,
> -			       sblk->block_size);
> +	ipos = sqfs_find_inode(dirs->inode_table, dirs->inode_table_size,
> +			       i_number, sblk->inodes, sblk->block_size);
>   
>   	if (!ipos) {
>   		*size = 0;
> diff --git a/fs/squashfs/sqfs_filesystem.h b/fs/squashfs/sqfs_filesystem.h
> index be56498a5e3..2e4224ea78a 100644
> --- a/fs/squashfs/sqfs_filesystem.h
> +++ b/fs/squashfs/sqfs_filesystem.h
> @@ -275,6 +275,7 @@ struct squashfs_dir_stream {
>   	 * sqfs_opendir() and freed in sqfs_closedir().
>   	 */
>   	unsigned char *inode_table;
> +	size_t inode_table_size;
>   	unsigned char *dir_table;
>   };
>   
> @@ -293,8 +294,8 @@ struct squashfs_file_info {
>   	bool comp;
>   };
>   
> -void *sqfs_find_inode(void *inode_table, int inode_number, __le32 inode_count,
> -		      __le32 block_size);
> +void *sqfs_find_inode(void *inode_table, size_t inode_table_size,
> +		      int inode_number, __le32 inode_count, __le32 block_size);
>   
>   int sqfs_dir_offset(void *dir_i, u32 *m_list, int m_count);
>   
> diff --git a/fs/squashfs/sqfs_inode.c b/fs/squashfs/sqfs_inode.c
> index ce9a8ff8e2a..da347becaff 100644
> --- a/fs/squashfs/sqfs_inode.c
> +++ b/fs/squashfs/sqfs_inode.c
> @@ -17,7 +17,8 @@
>   #include "sqfs_filesystem.h"
>   #include "sqfs_utils.h"
>   
> -int sqfs_inode_size(struct squashfs_base_inode *inode, u32 blk_size)
> +int sqfs_inode_size(struct squashfs_base_inode *inode, u32 blk_size,
> +		    const void *end)
>   {
>   	u16 inode_type = get_unaligned_le16(&inode->inode_type);
>   
> @@ -53,9 +54,13 @@ int sqfs_inode_size(struct squashfs_base_inode *inode, u32 blk_size)
>   
>   		di = ldir->index;
>   		while (l < i_count) {
> +			if ((void *)di + sizeof(*di) > end)
> +				return -EINVAL;
>   			sz = get_unaligned_le32(&di->size) + 1;
>   			index_list_size += sz;
>   			di = (void *)di + sizeof(*di) + sz;
> +			if ((void *)di > end || (void *)di < (void *)ldir)
> +				return -EINVAL;
>   			l++;
>   		}
>   
> @@ -114,9 +119,10 @@ int sqfs_inode_size(struct squashfs_base_inode *inode, u32 blk_size)
>    * Given the uncompressed inode table, the inode to be found and the number of
>    * inodes in the table, return inode position in case of success.
>    */
> -void *sqfs_find_inode(void *inode_table, int inode_number, __le32 inode_count,
> -		      __le32 block_size)
> +void *sqfs_find_inode(void *inode_table, size_t inode_table_size,
> +		      int inode_number, __le32 inode_count, __le32 block_size)
>   {
> +	const void *end = inode_table + inode_table_size;
>   	struct squashfs_base_inode *base;
>   	unsigned int offset = 0, k;
>   	int sz;
> @@ -128,14 +134,20 @@ void *sqfs_find_inode(void *inode_table, int inode_number, __le32 inode_count,
>   
>   	for (k = 0; k < le32_to_cpu(inode_count); k++) {
>   		base = inode_table + offset;
> +		/* Ensure the base inode fields lie within the table */
> +		if ((void *)(base + 1) > end)
> +			return NULL;
>   		if (get_unaligned_le32(&base->inode_number) == inode_number)
>   			return inode_table + offset;
>   
> -		sz = sqfs_inode_size(base, le32_to_cpu(block_size));
> +		sz = sqfs_inode_size(base, le32_to_cpu(block_size), end);
>   		if (sz < 0)
>   			return NULL;
>   
>   		offset += sz;
> +		/* The computed inode must not run past the table buffer */
> +		if (offset > inode_table_size)
> +			return NULL;
>   	}
>   
>   	printf("Inode not found.\n");


-- 
Richard Genoud, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
