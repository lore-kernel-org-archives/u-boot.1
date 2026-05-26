Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDBBCD5BB4
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 07:35:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4F0E8404D;
	Tue, 26 May 2026 09:35:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="jbr+Ny12";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D6D284659; Tue, 26 May 2026 09:35:45 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E5E383EF9
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 09:35:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 259AE1A3161;
 Tue, 26 May 2026 07:35:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id EECB160732;
 Tue, 26 May 2026 07:35:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 61F43108883B9; 
 Tue, 26 May 2026 09:35:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779780941; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=rg1Wtp3sSwhBRvdaIuHNdCabGVsFNmIjbmm6Xsrsrb4=;
 b=jbr+Ny12eITOsgcNxvtTHSp3FeJn0z4ZWfVi/S9qAfdUmGgWiOZiukrUojP0tXxNDmunD8
 mMJ2ZnqnYN+62cQmH2qKVKPjNo1cqHt43SJl/WVkn8ETRELl4N0npmTh70XLnQ8t/6aT+i
 sVT+kWX9dKFsXfmFFb6KjY1HJo7g599JxqixuzkAXGlvt6unxosEEIvQQSFddJfzPvplvW
 K3G2beLD7R7htyYOhRXzx2m4qihIW09R+1iyyPVta3iEwa7XqLpnUU2AQb3XdlNYhptNVK
 ZLzfDhjv3S1Fg+vJjE+l5mqRjarfuk5XO1KTX5wBL4mt3qHSpUw7sUKrds68QA==
Message-ID: <b7225b81-e3c8-4295-8eb1-53e0dd07b43a@bootlin.com>
Date: Tue, 26 May 2026 09:35:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs/squashfs: fix missing error checks causing
 Synchronous Abort
To: Allan ELKAIM <allan.elkaim@gmail.com>, u-boot@lists.denx.de
Cc: jmcosta944@gmail.com, miquel.raynal@bootlin.com,
 thomas.petazzoni@bootlin.com, trini@konsulko.com
References: <4c039e22-4766-4b43-9d01-2f0a31b556fc@bootlin.com>
 <20260523144809.2271703-1-allan.elkaim@gmail.com>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <20260523144809.2271703-1-allan.elkaim@gmail.com>
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

Hi Allan,

Le 23/05/2026 à 16:48, Allan ELKAIM a écrit :
> sqfs_find_inode() returns NULL on failure, and sqfs_dir_offset()
> returns -EINVAL on failure. At 8 call sites in sqfs.c neither return
> value was validated before the result was cast to a struct pointer or
> used as an array index.
> 
> On squashfs images with large inode/directory tables (e.g. containing
> the tzdata timezone database), sqfs_dir_offset() fails to locate a
> start_block in the metadata-block position list and returns -EINVAL.
> The caller then computes &dir_table[-22], producing a faulting address
> of 0xffffffffffffffea and a Synchronous Abort on ARM64:
> 
>    "Synchronous Abort" handler, esr 0x96000004, far 0xffffffffffffffea
> 
> The "Error: invalid inode reference to directory table." message
> printed just before the abort confirms the sqfs_dir_offset() path.
> Additionally, sqfs_find_inode() can return NULL when the inode table
> scan encounters an unknown or malformed inode type, after which any
> dereference of the cast pointer crashes.
> 
> Add NULL guards after every sqfs_find_inode() call and negative-value
> guards after every sqfs_dir_offset() call so that any lookup failure
> propagates as -EINVAL rather than crashing.
> 
> Signed-off-by: Allan Elkaim <allan.elkaim@gmail.com>

Actually, when sending a v2, you should re-send the whole series (patches
0/2, 1/2, 2/2), as a new thread (not replying to v1).
Then, in cover letter (v0), you should describe the changes from v1 to v2
ex:
https://lore.kernel.org/u-boot/20260523163239.8EEA768BEB@verein.lst.de/T/
(example taken randomly)
(here, it would be
The subject should remain the same so that we don't get lost.
Also, it's nice to use --base argument on git format-patch so that we know
which commit this series is based on.

On a v2, you are also expected to gather the Reviewed-by/Acked-by (here,
it would be my reviewed-by on patch 1/2, and Miquel's Acked-by on both patches)

Some documentation about that:
https://elixir.bootlin.com/u-boot/v2026.07-rc2/source/doc/develop/sending_patches.rst

> ---
>   fs/squashfs/sqfs.c | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 
> diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
> index 1430e671..da8fbb5a 100644
> --- a/fs/squashfs/sqfs.c
> +++ b/fs/squashfs/sqfs.c
> @@ -472,12 +472,16 @@ static int sqfs_search_dir(struct squashfs_dir_stream *dirs, char **token_list,
>   	/* Start by root inode */
>   	table = sqfs_find_inode(dirs->inode_table, le32_to_cpu(sblk->inodes),
>   				sblk->inodes, sblk->block_size);
> +	if (!table)
> +		return -EINVAL;
This is weird since this check is already in uboot tree, so this patch
doesn't apply.
(it was introduced by: 3fb1df1e57ee ("squashfs: Check sqfs_find_inode() return value"))

Please resent a v3 (whole series), with changes described and the commit
it's based on. (v2026.07-rc3 for example)

Thanks!

Regards,
Richard
>   
>   	dir = (struct squashfs_dir_inode *)table;
>   	ldir = (struct squashfs_ldir_inode *)table;
>   
>   	/* get directory offset in directory table */
>   	offset = sqfs_dir_offset(table, m_list, m_count);
> +	if (offset < 0)
> +		return offset;
>   	dirs->table = &dirs->dir_table[offset];
>   
>   	/* Setup directory header */
> @@ -527,6 +531,12 @@ static int sqfs_search_dir(struct squashfs_dir_stream *dirs, char **token_list,
>   		/* Get reference to inode in the inode table */
>   		table = sqfs_find_inode(dirs->inode_table, new_inode_number,
>   					sblk->inodes, sblk->block_size);
> +		if (!table) {
> +			free(dirs->entry);
> +			dirs->entry = NULL;
> +			ret = -EINVAL;
> +			goto out;
> +		}
>   		dir = (struct squashfs_dir_inode *)table;
>   
>   		/* Check for symbolic link and inode type sanity */
> @@ -599,6 +609,12 @@ static int sqfs_search_dir(struct squashfs_dir_stream *dirs, char **token_list,
>   
>   		/* Get dir. offset into the directory table */
>   		offset = sqfs_dir_offset(table, m_list, m_count);
> +		if (offset < 0) {
> +			free(dirs->entry);
> +			dirs->entry = NULL;
> +			ret = offset;
> +			goto out;
> +		}
>   		dirs->table = &dirs->dir_table[offset];
>   
>   		/* Copy directory header */
> @@ -623,6 +639,12 @@ static int sqfs_search_dir(struct squashfs_dir_stream *dirs, char **token_list,
>   	}
>   
>   	offset = sqfs_dir_offset(table, m_list, m_count);
> +	if (offset < 0) {
> +		free(dirs->entry);
> +		dirs->entry = NULL;
> +		ret = offset;
> +		goto out;
> +	}
>   	dirs->table = &dirs->dir_table[offset];
>   
>   	if (get_unaligned_le16(&dir->inode_type) == SQFS_DIR_TYPE)
> @@ -1023,6 +1045,8 @@ int sqfs_readdir(struct fs_dir_stream *fs_dirs, struct fs_dirent **dentp)
>   	i_number = dirs->dir_header->inode_number + dirs->entry->inode_offset;
>   	ipos = sqfs_find_inode(dirs->inode_table, i_number, sblk->inodes,
>   			       sblk->block_size);
> +	if (!ipos)
> +		return -SQFS_STOP_READDIR;
>   
>   	base = (struct squashfs_base_inode *)ipos;
>   
> @@ -1379,6 +1403,10 @@ int sqfs_read(const char *filename, void *buf, loff_t offset, loff_t len,
>   	i_number = dirs->dir_header->inode_number + dirs->entry->inode_offset;
>   	ipos = sqfs_find_inode(dirs->inode_table, i_number, sblk->inodes,
>   			       sblk->block_size);
> +	if (!ipos) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
>   
>   	base = (struct squashfs_base_inode *)ipos;
>   	switch (get_unaligned_le16(&base->inode_type)) {
> @@ -1629,6 +1657,11 @@ int sqfs_size(const char *filename, loff_t *size)
>   			       sblk->block_size);
>   	free(dirs->entry);
>   	dirs->entry = NULL;
> +	if (!ipos) {
> +		*size = 0;
> +		ret = -EINVAL;
> +		goto free_strings;
> +	}
>   
>   	base = (struct squashfs_base_inode *)ipos;
>   	switch (get_unaligned_le16(&base->inode_type)) {


-- 
Richard Genoud, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
