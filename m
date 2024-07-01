Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEEECC27C4F
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 00:23:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90CA98824C;
	Mon,  1 Jul 2024 02:23:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ayNg1jhO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5676F8824C; Mon,  1 Jul 2024 02:23:06 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0B3B88005
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 02:23:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-79d5d14fa8bso330483885a.0
 for <u-boot@lists.denx.de>; Sun, 30 Jun 2024 17:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719793382; x=1720398182; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f010g8WmXA63f2Ob8s/1tAXYs6k1vhHKzjJl93MXJSQ=;
 b=ayNg1jhOSzexd8uMyABNT31CzCmQ0yPX/TwOgXdNAKFB6IkPZLa+2DhlHl6b68yNJr
 r/5qg/FKYESF83hKZG/XIyC6MpjyOX+2GCUsnffu6oBsCzxR0GX4lj3WqT3yqKszTYAg
 /8TKEGHpnWdI2Is2wea4XXcqsVmUfju2E7GO81V0jGHR8TqXuRxrYovjQXVtVOkFvrmx
 qwJJwaHMG8d6M/jHK4bKycP9QQ+hFKcir/NHf1AFk28cZhIJaGpB3f2ACsdfGc3WOUdk
 Tx6nr/wi5Qfhk37STMVOgekDZM41hyIrAwBIZziEuP/mmXEy1QnBgAzQDUEjVhaFP5rX
 cJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719793382; x=1720398182;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f010g8WmXA63f2Ob8s/1tAXYs6k1vhHKzjJl93MXJSQ=;
 b=d4JEAGKbXLgXJe3Er0369OCJ9u1oyCU43JyGuNgLpqAPmpyp2LjgR5rUGLy9Nfxy5v
 cflOiuwXfkQ8V/AdfEqIIdOqOQRv59oHWJsDqgj+CbtQb0UNpvhO7jyNyK2AuWMugGMN
 FkCcBWb91KtJ0iChSzKfwulCb+zOuex3WFqvzB7if+i8IKTowViC5a3eYbvhmN9FWWKJ
 Ec3ugLOGSyqFwaB65WloS92xgDWeqZI7zJIv9fi6gW2hnQSJdI4qCZr9FQfM1gYMZ4+A
 DA1njNAEYnQeQ94NnvemPzJu2bnmlfpMVOw/JgUrgO/1mFNNoMnfOxVdnB/dNij3OV6M
 O8zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOeNoaklWZqionGFoTUN7X6U8do4GVEn4do5x1Y/myokWm9WYzqY0XHezTv24PboGLot+evzT39JL+ldjfqspvbt0jdQ==
X-Gm-Message-State: AOJu0YwwVeGQhoomtONFqSNpqpZmlO7l+d0+/7uPkyK1fiNG4pPkN3ce
 +yOVfa/8DykavyeEJjBBCqLFRffxuO16EoltdSj5pX2yhb6DeYZk
X-Google-Smtp-Source: AGHT+IGXUOKwgMtZGiKsf8Hfar5G+TXb+hGTCGoHLUBm9jp3lRUwbQaaslGi0fIbOvoNpyVHSZLhfA==
X-Received: by 2002:a05:620a:2016:b0:795:e9cd:f5b8 with SMTP id
 af79cd13be357-79d6ba6657bmr1078004885a.23.1719793382536; 
 Sun, 30 Jun 2024 17:23:02 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79d6925ebbfsm296605085a.13.2024.06.30.17.23.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Jun 2024 17:23:01 -0700 (PDT)
Message-ID: <279949a8-26da-e480-e498-e9a85cdbf479@gmail.com>
Date: Sun, 30 Jun 2024 20:23:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ext4: Improve feature checking
Content-Language: en-US
To: Richard Weinberger <richard@nod.at>, u-boot@lists.denx.de
Cc: Jixiong.Hu@mediatek.com, sjg@chromium.org, patrick.delaunay@foss.st.com,
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, trini@konsulko.com,
 upstream+uboot@sigma-star.at
References: <20240630212556.5627-1-richard@nod.at>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240630212556.5627-1-richard@nod.at>
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

On 6/30/24 17:25, Richard Weinberger wrote:
> Evaluate the filesystem incompat and ro_compat bit fields to judge
> whether the filesystem can be read or written.
> For the read side only a scary warning is shown so far.
> I'd love to about mounting too, but I fear this will break some setups

I think you are missing a verb in the first half of your sentence

> where the driver works by chance.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
> After facing ext4 write corruptions and read errors I checked
> the ext4 implementation briefly.
> Hopefully this patch helps other users to detect earlier that
> they're using ext4 features which are not supported by u-boot.
> 
> To make feature checking possible I had to figure what this
> implementation actually supports.
> I hope I got them right, feedback is welcome!
> 
> Thanks,
> //richard
> ---
>   fs/ext4/ext4_common.c |  8 +++++++
>   fs/ext4/ext4_write.c  | 12 ++++++++--
>   include/ext4fs.h      | 55 ++++++++++++++++++++++++++++++++++++++++++-
>   3 files changed, 72 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/ext4_common.c b/fs/ext4/ext4_common.c
> index 2ff0dca249..7148d35ee0 100644
> --- a/fs/ext4/ext4_common.c
> +++ b/fs/ext4/ext4_common.c
> @@ -2386,6 +2386,14 @@ int ext4fs_mount(void)
>   		fs->inodesz = 128;
>   		fs->gdsize = 32;
>   	} else {
> +		int missing = __le32_to_cpu(data->sblock.feature_incompat) & \
> +			      ~(EXT4_FEATURE_INCOMPAT_SUPP | \
> +				EXT4_FEATURE_INCOMPAT_SUPP_LAZY_RO);
> +
> +		if (missing)
> +			log_err("fs uses incompatible features: %08x, failures *are* expected!\n",
> +				missing);
> +

I think it is a bit unclear to the user what their action should be. Maybe something like

printf("EXT4 incompatible features: %08x, ignoring...\n")
  
and then maybe add a comment like what you have in the commit message.

>   		debug("EXT4 features COMPAT: %08x INCOMPAT: %08x RO_COMPAT: %08x\n",
>   		      __le32_to_cpu(data->sblock.feature_compatibility),
>   		      __le32_to_cpu(data->sblock.feature_incompat),
> diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
> index d057f6b5a7..4aae3c5f7f 100644
> --- a/fs/ext4/ext4_write.c
> +++ b/fs/ext4/ext4_write.c
> @@ -869,6 +869,7 @@ int ext4fs_write(const char *fname, const char *buffer,
>   	ALLOC_CACHE_ALIGN_BUFFER(char, filename, 256);
>   	bool store_link_in_inode = false;
>   	memset(filename, 0x00, 256);
> +	int missing_feat;
>   
>   	if (type != FILETYPE_REG && type != FILETYPE_SYMLINK)
>   		return -1;
> @@ -882,8 +883,15 @@ int ext4fs_write(const char *fname, const char *buffer,
>   		return -1;
>   	}
>   
> -	if (le32_to_cpu(fs->sb->feature_ro_compat) & EXT4_FEATURE_RO_COMPAT_METADATA_CSUM) {
> -		printf("Unsupported feature metadata_csum found, not writing.\n");
> +	missing_feat = le32_to_cpu(fs->sb->feature_incompat) & ~EXT4_FEATURE_INCOMPAT_SUPP;
> +	if (missing_feat) {
> +		log_err("Unsupported features found %08x, not writing.\n", missing_feat);
> +		return -1;
> +	}
> +
> +	missing_feat = le32_to_cpu(fs->sb->feature_ro_compat) & ~EXT4_FEATURE_RO_COMPAT_SUPP;
> +	if (missing_feat) {
> +		log_err("Unsupported RO compat features found %08x, not writing.\n", missing_feat);
>   		return -1;
>   	}
>   
> diff --git a/include/ext4fs.h b/include/ext4fs.h
> index d96edfd057..01b66f469f 100644
> --- a/include/ext4fs.h
> +++ b/include/ext4fs.h
> @@ -34,12 +34,65 @@ struct disk_partition;
>   #define EXT4_TOPDIR_FL		0x00020000 /* Top of directory hierarchies*/
>   #define EXT4_EXTENTS_FL		0x00080000 /* Inode uses extents */
>   #define EXT4_EXT_MAGIC			0xf30a
> -#define EXT4_FEATURE_RO_COMPAT_GDT_CSUM	0x0010
> +
> +#define EXT4_FEATURE_RO_COMPAT_SPARSE_SUPER  0x0001
> +#define EXT4_FEATURE_RO_COMPAT_LARGE_FILE    0x0002
> +#define EXT4_FEATURE_RO_COMPAT_BTREE_DIR     0x0004
> +#define EXT4_FEATURE_RO_COMPAT_HUGE_FILE     0x0008
> +#define EXT4_FEATURE_RO_COMPAT_GDT_CSUM      0x0010
> +#define EXT4_FEATURE_RO_COMPAT_DIR_NLINK     0x0020
> +#define EXT4_FEATURE_RO_COMPAT_EXTRA_ISIZE   0x0040
> +#define EXT4_FEATURE_RO_COMPAT_QUOTA         0x0100
> +#define EXT4_FEATURE_RO_COMPAT_BIGALLOC      0x0200
>   #define EXT4_FEATURE_RO_COMPAT_METADATA_CSUM 0x0400
> +
> +#define EXT4_FEATURE_INCOMPAT_FILETYPE  0x0002
> +#define EXTE_FEATURE_INCOMPAT_RECOVER   0x0004
>   #define EXT4_FEATURE_INCOMPAT_EXTENTS	0x0040
>   #define EXT4_FEATURE_INCOMPAT_64BIT	0x0080
> +#define EXT4_FEATURE_INCOMPAT_MMP       0x0100
> +#define EXT4_FEATURE_INCOMPAT_FLEX_BG   0x0200
> +#define EXT4_FEATURE_INCOMPAT_CSUM_SEED 0x2000
> +#define EXT4_FEATURE_INCOMPAT_ENCRYPT   0x10000
> +
>   #define EXT4_INDIRECT_BLOCKS		12
>   
> +/*
> + * Incompat features supported by this implementation.
> + */
> +#define EXT4_FEATURE_INCOMPAT_SUPP ( EXT4_FEATURE_INCOMPAT_FILETYPE \
> +				   | EXTE_FEATURE_INCOMPAT_RECOVER \

EXT4

> +				   | EXT4_FEATURE_INCOMPAT_EXTENTS \
> +				   | EXT4_FEATURE_INCOMPAT_64BIT \
> +				   | EXT4_FEATURE_INCOMPAT_FLEX_BG \
> +				   )

Operators should go at the end of the line. So like

#define EXT4_FEATURE_INCOMPAT_SUPP (EXT4_FEATURE_INCOMPAT_FILETYPE | \
				    EXT4_FEATURE_INCOMPAT_RECOVER | \
				    EXT4_FEATURE_INCOMPAT_EXTENTS | \
				    EXT4_FEATURE_INCOMPAT_64BIT | \
				    EXT4_FEATURE_INCOMPAT_FLEX_BG)

> +/*
> + * Incompat features supported by this implementation only in a lazy
> + * way, good enough for reading files.
> + *
> + * - Multi mount protection (mmp) is not supported, but for read-only
> + *   we get away with it.
> + * - Same fore metadata_csum_seed and metadata_csum.

nit: for

> + * - The implementation has also no clue about fscrypt, but it can read
> + *   unencrypted files. Reading encrypted files will read garbage.
> + */
> +#define EXT4_FEATURE_INCOMPAT_SUPP_LAZY_RO ( EXT4_FEATURE_INCOMPAT_MMP \
> +					   | EXT4_FEATURE_INCOMPAT_CSUM_SEED \
> +					   | EXT4_FEATURE_INCOMPAT_ENCRYPT \
> +					   )

ditto

> +/*
> + * Read-only compat features we support.
> + * If unknown ro compat features are detected, writing to the fs is denied.
> + */
> +#define EXT4_FEATURE_RO_COMPAT_SUPP ( EXT4_FEATURE_RO_COMPAT_SPARSE_SUPER \
> +				    | EXT4_FEATURE_RO_COMPAT_LARGE_FILE \
> +				    | EXT4_FEATURE_RO_COMPAT_HUGE_FILE \
> +				    | EXT4_FEATURE_RO_COMPAT_DIR_NLINK \
> +				    | EXT4_FEATURE_RO_COMPAT_EXTRA_ISIZE \
> +				    )

ditto

>   #define EXT4_BG_INODE_UNINIT		0x0001
>   #define EXT4_BG_BLOCK_UNINIT		0x0002
>   #define EXT4_BG_INODE_ZEROED		0x0004

Anyway, the substance of this patch is good. Just needs a little cosmetic cleanup.

--Sean
