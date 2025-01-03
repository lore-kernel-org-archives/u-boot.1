Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DDC2E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 22:59:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DB9280295;
	Fri,  3 Jan 2025 23:59:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="RwWlL93u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD34C802EF; Fri,  3 Jan 2025 23:59:56 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FD87801F5
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 23:59:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1735945190; x=1736549990; i=xypron.glpk@gmx.de;
 bh=5lmE0Yoq7IrL6yY5BmF9mQnWZgqrHmPBuVCtx9CzptU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=RwWlL93u4NBhSD1Sajqiu/qCLzWGcDIGqLJjD+F0GsbQMFQPWDYc9ur2ALrYDdLB
 iv3pBapb3UZ2Q/PFVOwfHvhRfnAb82pd62KtHpC00MTv8Oh1hg/3HJfOHoJ+DZaPA
 F0Xn9Bx8xNPpr/ECCL/9pq23mhospUxoo3AC5/d5prt2nK4z6IR95KAVKVyXFFbE9
 iAT7Sz2LxEXf7JKSuNGxHIsR14GNZ2Kx0aSUfJckRbsooUOFPxj4ratqU8NdaKCrX
 /n8t+TJPcEzhsQ5hq7YpBhRSK+6tcoKBDVjEAWOVFqQ9PrMWmU7i9TbqPSgZp9pHm
 EY68HVuqsd5prmt5fA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.106] ([46.114.109.94]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1OXZ-1tbIJ43Ndr-00xmqB; Fri, 03
 Jan 2025 23:59:49 +0100
Message-ID: <de097106-70b2-4247-a27f-1094d39d98dd@gmx.de>
Date: Fri, 3 Jan 2025 23:59:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fs: fat: Implement FAT file rename
To: Burak Gerz <burak@gerz.io>
Cc: Daniel.Venzin@mt.com, eballetb@redhat.com, manut@mecka.net,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, Nam Cao
 <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20241212220635.25971-1-burak@gerz.io>
 <20241212220635.25971-3-burak@gerz.io>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241212220635.25971-3-burak@gerz.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wV4nJS7wtEXm762VY1Ff7DuM1uxw5GyA7lXJ9+XrW0daEdnL3En
 ZzUa1KYwocdVFwtDpSUmygKBOfaE+1f/XDSeuYcqssT7kd0M4Ocq0Jff49gJe0/UDfR4dsn
 Md6mf6qw7BEqoit+HxPanPlnwIY+ajrWC9qhxYv1CGAwUomuc0BltTpNU0sdXg0JAnbVSGs
 pDdKrg2e9CGwIG4X5M0Uw==
UI-OutboundReport: notjunk:1;M01:P0:cYWH4ZJDRpY=;pyH5twSMr1nPsX8WCDfTPVNaigZ
 Jx9Ap+t9lI237aA4U1UGUTyW8MBjIUXuUDJtn6vN/dusZ8OcvH96mMWwlZBjKRteQe1LCxOQN
 Y+eb/DvNktZz49tMnIQjhRfixfVlGOg8vsre31ChGXV8bcnbDYZbNmDtVjasNDXc34EW8jvzV
 JH8MoXmbsRi2VNjssu2aWFryzTMZc7bk3NkzVv4nZ2EklS5V+bSw+r2/7MfmneFfwcyJhM2KA
 wiB2BNEjkmX4zLwiDoBfJfFI+X+Ft4NlWT7KNSuQ9yodvVvhTJvkTpi02lkdDRyLH0p450l9F
 kpWRedNJTGXsGy3jUjni+lQK9Wy9nhENooh5XG9eeiU0DKcJAhx9DhX6QF6W4HQN9jCRVs0lR
 D33n3pPMnleXLL3+L0OU5ffiYehjuakBZub/I4fpJ6NqI41z22bCrGpzUbo6cT4gLeAfJD15J
 GU2HIoW9sp+rCGmW3U7iSdCBHXJh+6inb4X4hL1xu9RT76Kh1nYU/uuiN8WbCVy0NJk2iFyFO
 PXPp4yfhA6Fp9c7N06RZVHgb36Wvhw/ErfesNQEqnx4/5t5UfVD4svj5OHpQMSiv22wcnjCqC
 JG3SZdBaiNFw3Fr1lg9xBAIilO1pd3xBjl4Ma8G0jkIEAeEe92u2R2E7H1PNfV8rvbGTCt+8H
 Lz9ckdMSHotZ0sJY22019BgAzPQUbDVqGZPuhjXQjAm8VMR35SfiddZGGWMTzPbLkivAq5+Ks
 ayoTG1NYHrLVvlxLduLrg1ynFq1N590mIsBwzqxLOz4ktprKWkRs8oqZDTCNbd4+U5Re37eO6
 QIfr+2nTCE+WmkvUFMOQneajKPpxxE12HszvC9kRD6fFQF36shKudS0DS/xgzoKBNp4dP0aCT
 CCizE8id/Csj3xpNH0ny/fnb804OBmeXfDEVHjfnn/0zqc4Xr8JzKchQdBj7SZaX61QTndzAp
 SQR4ZhycGShsJDCKrzmxoG64+HlMloiaZUwkrwmmbaaahluTZtMoczPe1OSF7rC+bx45HAWkA
 t59M7ks5qgZ2gZM84nCrMYWz6LnyMbBIamsEVVay4l+GaE65AsIHTqHQYbLsj8/TODcKEruZ8
 rAQjmzkVw/9aTP2zm9LBKsXVzoVkzV
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

On 12.12.24 23:06, Burak Gerz wrote:
> Implement a simple FAT file rename.
>
> Signed-off-by: Burak Gerz <burak@gerz.io>

Please, separate the change into two patches.

1) define fs_rename()
2) implement ffat_rename()

>
> ---
>
>   fs/fat/fat_write.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++
>   fs/fs.c            | 30 ++++++++++++++
>   include/fat.h      |  1 +
>   include/fs.h       |  2 +
>   4 files changed, 132 insertions(+)
>
> diff --git a/fs/fat/fat_write.c b/fs/fat/fat_write.c
> index ea877ee917..acd0e22652 100644
> --- a/fs/fat/fat_write.c
> +++ b/fs/fat/fat_write.c
> @@ -1813,3 +1813,102 @@ exit:
>   	free(dotdent);
>   	return ret;
>   }
> +
> +int file_fat_rename(const char *path, const char *new_filename)

%s/file_fat_rename/fat_rename/

> +{
> +	char *dirname, *basename;
> +	char path_copy[VFAT_MAXLEN_BYTES];
> +	char new_path[VFAT_MAXLEN_BYTES];
> +	dir_entry *dentry_src, *dentry_dst;
> +	fsdata src_datablock =3D { .fatbuf =3D NULL };
> +	fsdata dst_datablock =3D { .fatbuf =3D NULL };
> +	fat_itr *src_itr =3D NULL;
> +	fat_itr *dst_itr =3D NULL;
> +	loff_t actwrite;
> +	int ret;
> +	void *buffer =3D &actwrite;
> +
> +	if (strlen(new_filename) > VFAT_MAXLEN_BYTES)
> +		return -EINVAL;
> +	strcpy(path_copy, path);
> +	split_filename(path_copy, &dirname, &basename);
> +	strcpy(new_path, dirname);
> +	strcat(new_path, "/");
> +	strcat(new_path, new_filename);
> +	src_itr =3D malloc_cache_aligned(sizeof(*src_itr));
> +		if (!src_itr)
> +			goto exit;
> +	dst_itr =3D malloc_cache_aligned(sizeof(*dst_itr));
> +		if (!dst_itr)
> +			goto exit;
> +	ret =3D fat_itr_root(src_itr, &src_datablock);
> +	if (ret)
> +		goto exit;
> +	ret =3D fat_itr_root(dst_itr, &dst_datablock);
> +	if (ret)
> +		goto exit;
> +	ret =3D fat_itr_resolve(src_itr, dirname, TYPE_DIR);
> +	if (ret)
> +		goto exit;
> +	dentry_src =3D find_directory_entry(src_itr, (char *)basename);
> +	if (!dentry_src)
> +		goto exit;
> +
> +	dst_datablock.fatbuf =3D NULL;
> +	fat_itr_root(dst_itr, &dst_datablock);
> +	ret =3D fat_itr_resolve(dst_itr, dirname, TYPE_DIR);
> +	if (ret)
> +		goto exit;
> +	dentry_dst =3D find_directory_entry(dst_itr, (char *)new_filename);
> +	if (dentry_dst)
> +		goto exit;

This duplicates code from fat_mkdir() and file_fat_write_at().
Please, carve out a common functions.

> +	ret =3D file_fat_write(new_path, buffer, 0, 0, &actwrite);

Before any update you must check that new_path does not exist.

> +	if (ret)
> +		goto exit;
> +	dst_datablock.fatbuf =3D NULL;
> +	fat_itr_root(dst_itr, &dst_datablock);
> +	ret =3D fat_itr_resolve(dst_itr, dirname, TYPE_DIR);
> +	if (ret)
> +		goto exit;
> +	dentry_dst =3D find_directory_entry(dst_itr, (char *)new_filename);
> +	if (!dentry_dst)
> +		goto exit;
> +	dentry_dst->starthi =3D dentry_src->starthi;
> +	dentry_dst->start =3D dentry_src->start;
> +	dentry_dst->size =3D dentry_src->size;
> +	ret =3D flush_dir(dst_itr);
> +	if (ret)
> +		return -1;
> +	src_datablock.fatbuf =3D NULL;
> +	ret =3D fat_itr_root(src_itr, &src_datablock);
> +	if (ret)
> +		goto exit;
> +	ret =3D fat_itr_resolve(src_itr, dirname, TYPE_DIR);
> +	if (ret)
> +		goto exit;
> +	dentry_src =3D find_directory_entry(src_itr, (char *)basename);
> +	if (!dentry_src)
> +		goto exit;
> +	dir_entry *dent =3D src_itr->dent;
> +
> +	if (src_itr->clust !=3D src_itr->dent_clust) {
> +		ret =3D fat_move_to_cluster(src_itr, src_itr->dent_clust);
> +		if (ret)
> +			goto exit;
> +	}
> +	src_itr->dent =3D src_itr->dent_start;
> +	src_itr->remaining =3D src_itr->dent_rem;
> +	dent =3D src_itr->dent_start;
> +	if ((dent->attr & ATTR_VFAT) =3D=3D ATTR_VFAT &&
> +	    (dent->nameext.name[0] & LAST_LONG_ENTRY_MASK)) {
> +		ret =3D delete_long_name(src_itr);
> +		if (ret)
> +			goto exit;
> +	}
> +	delete_single_dentry(src_itr);

You are duplicating code from delete_dentry_long(). This can be avoided
by moving the freeing of cluster blocks out of delete_dentry_long() and
calling this function here.

> +	ret =3D flush_dir(src_itr);
> +exit:
> +	free(src_itr);
> +	free(dst_itr);
> +	return ret;
> +}
> diff --git a/fs/fs.c b/fs/fs.c
> index 21a23efd93..3024bd2cec 100644
> --- a/fs/fs.c
> +++ b/fs/fs.c
> @@ -118,6 +118,11 @@ static inline int fs_ln_unsupported(const char *fil=
ename, const char *target)
>   	return -1;
>   }
>
> +static inline int fs_rename_unsupported(const char *filename, const cha=
r *target)
> +{
> +	return -1;
> +}
> +
>   static inline void fs_close_unsupported(void)
>   {
>   }
> @@ -183,6 +188,7 @@ struct fstype_info {
>   	int (*unlink)(const char *filename);
>   	int (*mkdir)(const char *dirname);
>   	int (*ln)(const char *filename, const char *target);
> +	int (*rename)(const char *old_filename_path, const char *new_filename)=
;
>   };
>
>   static struct fstype_info fstypes[] =3D {
> @@ -201,6 +207,7 @@ static struct fstype_info fstypes[] =3D {
>   		.write =3D file_fat_write,
>   		.unlink =3D fat_unlink,
>   		.mkdir =3D fat_mkdir,
> +		.rename =3D file_fat_rename,
>   #else
>   		.write =3D fs_write_unsupported,
>   		.unlink =3D fs_unlink_unsupported,
> @@ -222,6 +229,7 @@ static struct fstype_info fstypes[] =3D {
>   		.probe =3D ext4fs_probe,
>   		.close =3D ext4fs_close,
>   		.ls =3D fs_ls_generic,
> +		.rename =3D fs_rename_unsupported,
>   		.exists =3D ext4fs_exists,
>   		.size =3D ext4fs_size,
>   		.read =3D ext4_read_file,
> @@ -247,6 +255,7 @@ static struct fstype_info fstypes[] =3D {
>   		.null_dev_desc_ok =3D true,
>   		.probe =3D sandbox_fs_set_blk_dev,
>   		.close =3D sandbox_fs_close,
> +		.rename =3D fs_rename_unsupported,
>   		.ls =3D sandbox_fs_ls,
>   		.exists =3D sandbox_fs_exists,
>   		.size =3D sandbox_fs_size,
> @@ -266,6 +275,7 @@ static struct fstype_info fstypes[] =3D {
>   		.null_dev_desc_ok =3D true,
>   		.probe =3D smh_fs_set_blk_dev,
>   		.close =3D fs_close_unsupported,
> +		.rename =3D fs_rename_unsupported,
>   		.ls =3D fs_ls_unsupported,
>   		.exists =3D fs_exists_unsupported,
>   		.size =3D smh_fs_size,
> @@ -284,6 +294,7 @@ static struct fstype_info fstypes[] =3D {
>   		.fstype =3D FS_TYPE_UBIFS,
>   		.name =3D "ubifs",
>   		.null_dev_desc_ok =3D true,
> +		.rename =3D fs_rename_unsupported,
>   		.probe =3D ubifs_set_blk_dev,
>   		.close =3D ubifs_close,
>   		.ls =3D ubifs_ls,
> @@ -305,6 +316,7 @@ static struct fstype_info fstypes[] =3D {
>   		.fstype =3D FS_TYPE_BTRFS,
>   		.name =3D "btrfs",
>   		.null_dev_desc_ok =3D false,
> +		.rename =3D fs_rename_unsupported,
>   		.probe =3D btrfs_probe,
>   		.close =3D btrfs_close,
>   		.ls =3D btrfs_ls,
> @@ -327,6 +339,7 @@ static struct fstype_info fstypes[] =3D {
>   		.null_dev_desc_ok =3D false,
>   		.probe =3D sqfs_probe,
>   		.opendir =3D sqfs_opendir,
> +		.rename =3D fs_rename_unsupported,
>   		.readdir =3D sqfs_readdir,
>   		.ls =3D fs_ls_generic,
>   		.read =3D sqfs_read,
> @@ -348,6 +361,7 @@ static struct fstype_info fstypes[] =3D {
>   		.null_dev_desc_ok =3D false,
>   		.probe =3D erofs_probe,
>   		.opendir =3D erofs_opendir,
> +		.rename =3D fs_rename_unsupported,
>   		.readdir =3D erofs_readdir,
>   		.ls =3D fs_ls_generic,
>   		.read =3D erofs_read,
> @@ -369,6 +383,7 @@ static struct fstype_info fstypes[] =3D {
>   		.probe =3D fs_probe_unsupported,
>   		.close =3D fs_close_unsupported,
>   		.ls =3D fs_ls_unsupported,
> +		.rename =3D fs_rename_unsupported,
>   		.exists =3D fs_exists_unsupported,
>   		.size =3D fs_size_unsupported,
>   		.read =3D fs_read_unsupported,
> @@ -697,6 +712,21 @@ int fs_mkdir(const char *dirname)
>   	return ret;
>   }
>
> +int fs_rename(const char *path, const char *new_filename)
> +{
> +	struct fstype_info *info =3D fs_get_info(fs_type);
> +	int ret;
> +
> +	ret =3D info->rename(path, new_filename);

Please, check if the name is equal before calling rename().

Best regards

Heinrich

> +	if (ret < 0) {
> +		log_err("** Unable to rename from %s to %s **\n", path, new_filename)=
;
> +	    ret =3D -1;
> +	}
> +	fs_close();
> +
> +	return ret;
> +}
> +
>   int fs_ln(const char *fname, const char *target)
>   {
>   	struct fstype_info *info =3D fs_get_info(fs_type);
> diff --git a/include/fat.h b/include/fat.h
> index 3dce99a23c..1155e59c68 100644
> --- a/include/fat.h
> +++ b/include/fat.h
> @@ -208,6 +208,7 @@ void fat_closedir(struct fs_dir_stream *dirs);
>   int fat_unlink(const char *filename);
>   int fat_mkdir(const char *dirname);
>   void fat_close(void);
> +int file_fat_rename(const char *filename, const char *buffer);
>   void *fat_next_cluster(fat_itr *itr, unsigned int *nbytes);
>
>   /**
> diff --git a/include/fs.h b/include/fs.h
> index 2474880385..c8d0eb41c9 100644
> --- a/include/fs.h
> +++ b/include/fs.h
> @@ -165,6 +165,8 @@ int fs_read(const char *filename, ulong addr, loff_t=
 offset, loff_t len,
>   int fs_write(const char *filename, ulong addr, loff_t offset, loff_t l=
en,
>   	     loff_t *actwrite);
>
> +int fs_rename(const char *path, const char *filename);
> +
>   /*
>    * Directory entry types, matches the subset of DT_x in posix readdir(=
)
>    * which apply to u-boot.

