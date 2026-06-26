Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A7ACD4F26
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 06:39:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2271984894;
	Fri, 26 Jun 2026 08:39:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="OEmY8j+1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 251378495B; Fri, 26 Jun 2026 08:38:59 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEC7A8460E
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 08:38:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wqu@suse.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-491609cdd8fso3807225e9.2
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 23:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782455935; x=1783060735; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=MlZjyuLh3+FM/+5q3QBAkx4Y28rvsXbke3N1Fwrq2mI=;
 b=OEmY8j+1bw/huIuVsdXiZ/CleSbwQ79DfATLZRuGb67CKuRn2oJFK/nfXwCN5+mtRP
 NnHSPPeVPblcqVEVLdEk3XKfn5L6qC3yqSZ7CjAfKHhKQChe/17wiTZQDOt3KAXAya6U
 du+jrhwYDgAvJgwAJS9OmVrzuMLy/nI1mGkxsat54vuYcoks94nCzXs20jtmtoyLhrVj
 0YIDQNOOTJ4qmFJK62OraOdU64q3s7I/o6aSRoj9dEh9OAcwfMDPW5UcnbUGl+R3uuyO
 hY74qVs35jKYl9HLJIkdsmVvf9tN9pm6YVwhiugfOCZmjd4GlUN3ObFWmeP2afFaXg/K
 s4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782455935; x=1783060735;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MlZjyuLh3+FM/+5q3QBAkx4Y28rvsXbke3N1Fwrq2mI=;
 b=DJsweGWW7ettRvzrg8gyLyDEbHZdyxdP/0InaLXuTYGJMvb9/ukKsb8ozbyHkCuhaW
 R09AdXja7zx2tmslG5Wmb7uiOTbRHIkhWfwSmv4CsSkFssnN5x8suSmN8G+DrnHJBbDh
 o6w/HM0WA4iSHRW513WokJmYxq3gGfEpv0FqZgTEyhC1mBN4MqHaxH65A6tpTq6cNL+m
 dZ5F1IVtx1k+pgcVBmI+m42533SEf+rtE+5sh2Ajh2E6oT+J5ABGQ7NZs+LiQtZuE7aw
 KyYDVNIHQNsW0w7xvBG/24iANyEpUeDOdwFcHdQZ//SmgTuwdAHJJYPjkGsSq6GTF9gN
 3nLQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9hP5wlXkakGIoeEWm99WP1uZpmPl/RUQHKiJLvKxexljgd+Jocqao5fmqUyKC2GGVpZyiPboE=@lists.denx.de
X-Gm-Message-State: AOJu0YyFI+qbvV9qGFXcps2UDpS7MF6OqkzNiAb9OmGbOpI0otODjIVd
 UZaKkO8/My8WT+RtOos0F+r/+Ly28PXGMDaH0zHO2m+WE2orqrUC/hY4fBFJYTpQ8cg=
X-Gm-Gg: AfdE7clJzw5kWW7U3xMX/Ii1kWRsJ5+6NTVAj982zG4aEsCk+e2fe7TXe2IufPj+HpO
 VTLeEV8w2GEhWGNr79VM4laxQ2d5Zx7tjjajbs2bBKX8jd3rx2u9KYJSoyoVd0MgQz7FDutyxeE
 QYeMXPycI8Hzr7S3IemtXMAbKMAh8jDdJ5ncI04Tv7twXvNRl7MPQJVXXNaEv9yKZMwzY8q60HX
 sqTQXrXpjecMNRBJf7+7VTGXNTQrjKmI963hYHh/CM76FLk0mP78oglvA6GC49JxQZVmAiEbZ9j
 pT4uPVIYX3VtBgZkgUA2gOZYNwZMYek/XqwnZ7qw5B6HM94AwQ63OEDDapg02CH91bNPRb4C+i4
 cdDNM0jzWPOFVvSA0Lv4oRGneP4FfZrkW1rZNpSHA5UIeqvGOEtaTvulxR3D9OPdvEoZDUyNAyQ
 lZP6zJhtywJEkX7+W61zFZTyL3+itzMh7RgKghMlAQ
X-Received: by 2002:a05:600c:a111:b0:492:68bc:3237 with SMTP id
 5b1f17b1804b1-49268bc34e3mr35713465e9.32.1782455935144; 
 Thu, 25 Jun 2026 23:38:55 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299?
 (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7f65088cesm32603075ad.80.2026.06.25.23.38.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2026 23:38:54 -0700 (PDT)
Message-ID: <bbeac2f6-685d-4ace-b689-10d64c4e3ce5@suse.com>
Date: Fri, 26 Jun 2026 16:08:47 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fs: btrfs: implement opendir(), readdir() and
 closedir()
To: Alexey Charkov <alchark@flipper.net>, linux-btrfs@vger.kernel.org,
 u-boot@lists.denx.de
Cc: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>,
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Yao Zi <me@ziyao.cc>
References: <20260625-btrfs-readdir-v1-0-dd781a2b3965@flipper.net>
 <20260625-btrfs-readdir-v1-1-dd781a2b3965@flipper.net>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <20260625-btrfs-readdir-v1-1-dd781a2b3965@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



在 2026/6/26 02:54, Alexey Charkov 写道:
> Add support for generic directory iteration with opendir(), readdir() and
> closedir() in the btrfs filesystem driver, following the ext4fs
> implementation for opendir()/closedir() and the btrfs_iter_dir() function
> for readdir().
> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>   fs/btrfs/btrfs.c    | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/ctree.h    |  2 ++
>   fs/btrfs/dir-item.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   fs/fs.c             |  4 ++-
>   include/btrfs.h     |  5 +++
>   5 files changed, 193 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
> index f3087f690fa4..c647c8dedf4e 100644
> --- a/fs/btrfs/btrfs.c
> +++ b/fs/btrfs/btrfs.c
> @@ -9,6 +9,7 @@
>   #include <malloc.h>
>   #include <u-boot/uuid.h>
>   #include <linux/time.h>
> +#include <fs.h>
>   #include "btrfs.h"
>   #include "crypto/hash.h"
>   #include "disk-io.h"
> @@ -159,6 +160,97 @@ int btrfs_ls(const char *path)
>   	return 0;
>   }
>   
> +struct btrfs_dir_stream {
> +	struct fs_dir_stream parent;
> +	struct fs_dirent dirent;
> +	char *dirname;
> +	u64 offset;

This doesn't look correct to me, for an opened dir, we should have at 
least the root id or pointer, and an inode number.

Not just an @dirname and re-do the path resolution again and again.

In fact, I do not even think we should save @dirname here.


> +};
> +
> +int btrfs_opendir(const char *dirname, struct fs_dir_stream **dirsp)
> +{
> +	struct btrfs_fs_info *fs_info = current_fs_info;
> +	struct btrfs_dir_stream *dirs;
> +	struct btrfs_root *root;
> +	u64 ino;
> +	u8 type;
> +	int ret;
> +
> +	*dirsp = NULL;
> +	ASSERT(fs_info);
> +
> +	ret = btrfs_lookup_path(fs_info->fs_root, BTRFS_FIRST_FREE_OBJECTID,
> +				dirname, &root, &ino, &type, 40);

You just discard the most important @root and @ino.

So what is the point here?
> +	if (ret < 0)
> +		return ret;
> +	if (type != BTRFS_FT_DIR)
> +		return -ENOTDIR;
> +
> +	dirs = calloc(1, sizeof(*dirs));
> +	if (!dirs)
> +		return -ENOMEM;
> +	dirs->dirname = strdup(dirname);
> +	if (!dirs->dirname) {
> +		free(dirs);
> +		return -ENOMEM;
> +	}
> +
> +	*dirsp = (struct fs_dir_stream *)dirs;
> +	return 0;
> +}
> +
> +int btrfs_readdir(struct fs_dir_stream *fs_dirs, struct fs_dirent **dentp)
> +{
> +	struct btrfs_dir_stream *dirs = (struct btrfs_dir_stream *)fs_dirs;
> +	struct btrfs_fs_info *fs_info = current_fs_info;
> +	struct fs_dirent *dent = &dirs->dirent;
> +	struct btrfs_root *root;
> +	u64 ino;
> +	u8 type;
> +	int ret;
> +
> +	*dentp = NULL;
> +	ASSERT(fs_info);
> +
> +	ret = btrfs_lookup_path(fs_info->fs_root, BTRFS_FIRST_FREE_OBJECTID,
> +				dirs->dirname, &root, &ino, &type, 40);

No, doing the same path resolution again and again is not sane.
> +	if (ret < 0)
> +		return ret;
> +	if (type != BTRFS_FT_DIR)
> +		return -ENOTDIR;
> +
> +	memset(dent, 0, sizeof(*dent));
> +	ret = btrfs_next_dir_entry(root, ino, &dirs->offset, dent->name,
> +				   sizeof(dent->name), &type);
> +	if (ret < 0)
> +		return ret;
> +	if (ret > 0)
> +		return -ENOENT;
> +
> +	switch (type) {
> +	case BTRFS_FT_DIR:
> +		dent->type = FS_DT_DIR;
> +		break;
> +	case BTRFS_FT_SYMLINK:
> +		dent->type = FS_DT_LNK;
> +		break;
> +	default:
> +		dent->type = FS_DT_REG;
> +		break;

So it looks like u-boot only supports the above 3 types, and unlike 
linux kernel the values doesn't match the btrfs internal ones.

In that case, I'd still prefer a proper convertor function.

[...]
> +
> +		*offset = key.offset + 1;
> +		type = btrfs_dir_type(path.nodes[0], di);
> +
> +		/* XATTRs share the key space but are not directory entries. */
> +		if (type == BTRFS_FT_XATTR) {

This doesn't looks correct again.

XATTR has their own keys, they should not show up among DIR_INDEX keys.

Thanks,
Qu
