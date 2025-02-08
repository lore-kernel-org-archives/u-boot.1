Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02196C02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 21:20:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 573AA80805;
	Sat,  8 Feb 2025 22:20:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="iVLHq73D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1BBE80821; Sat,  8 Feb 2025 22:20:28 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93DFE807FE
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 22:20:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1739049607; x=1739654407; i=xypron.glpk@gmx.de;
 bh=tMKiMKU28oFcLjAmo/W4AX94VTlorUKZNUWnkUMeLQk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=iVLHq73Dqh1XfyXff0IQ0nmIjFciv+5xD4oYQoohWZXbufevXtYU4eu7o44hq3LL
 XgnwieUCc8tKOEQ4HU3ZdecFMRJM5QTe/NvszYF+8ODFqW0odPCvBfvb5fhq8jiaG
 IZXwYc8HLAtp74cNy16A5zvMg8Zy8CsbXo1p90yQE/ryfQtCAmgIH2ZQQDyXcE69O
 u2lD0FdtsOCeBHN/oqugzaXohwEQ5wL0eUo+DLsbhtKbwDXl/GGcXjnXWkD8V8ydL
 +nPPOzTyPs7O/PwA1KWkikOEHm7maWoRgeoAjU77sNK5Q4v743YTvPvlkw39uCFLI
 ePlB5aYIAm8hGEH3gw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1fn0-1tIUkJ1dUG-014oVT; Sat, 08
 Feb 2025 22:20:07 +0100
Message-ID: <fdbd0ef3-240a-4d5e-a1c5-34d5861faf0f@gmx.de>
Date: Sat, 8 Feb 2025 22:20:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] fs: fat: Support basic file rename
To: Daniel Venzin <Daniel.Venzin@mt.com>
Cc: burak@gerz.io, gabriel.dalimonte@gmail.com, Manuel.Traut@mt.com,
 Baruch Siach <baruch@tkos.co.il>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250207124523.85026-1-Daniel.Venzin@mt.com>
 <20250207124523.85026-5-Daniel.Venzin@mt.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250207124523.85026-5-Daniel.Venzin@mt.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PGKgj8Vgi+hdbLOQdF48C1TxNGWnV3Kw8s2lG2tTPfvsBKFntiT
 W8Kz+Wx235X6vAclfUQ3KTG/SYLqbvj8OONN/BzYSFsOLfvklY3kxXCeOY2Nw0CyJiRyFIZ
 lArseFET4Ez9/EEl5+k0tSJ6EYoUJ580eLHlOFx/vK2Ix9JfmfjOZilabd0N/wp5hI3lcLe
 KxuwJ2uL16opU26fs2Iyg==
UI-OutboundReport: notjunk:1;M01:P0:M1qbAvsyquY=;rUtEiWxJ9+4wuKD37Hop51d/fP+
 O0OG4daFteYtgSdnR5NjN4dS+GqKDCdKZVI1/r+3LGpSQTZM1QAYl+LnjcwwTfFYzIT4UNLxP
 56FpdRZWcctZcjY/Eut0kjhL8AXIjegTjj3Sgp/1NmQ1fIaAsazk8RMNsnOF+CdhfXDwkPC/a
 ct1pKR/1bzf6+SdBZJwxiBFfuW112ER4/4tbuVoqT7l8YW0gqVE3aifHrenrNNWPzpnvAW5lW
 NWzRqxpiDe0o5yWGyMCATWTadfMb5P+4Wo1LB/LfMWdCcCVs1kuT9SewQcPiHBWpVKykcK0s/
 RMXBCODaUJhssNbAl3fSJi7i68uXPr+COigcOYWcUfdb5gUjMqInJeeFzor0bKeSWz6oXVjql
 aDlPLVB/LhsmmqzS8sQJ6yCEJdmftYwKMfK89GxW8VomyFTRbL26oOFeHaCu5NsD5y81lfiWH
 U9qo3D7O8X613I/DKikwrfaATnyWBvqwkrpzb+VW7YKG0M10UwU5SjuUxLj4o8d/ZV0ZZMiZz
 aq8RTTJn3svUyKvomDSCBQwUR8pLP4KMfElyBKQJJfMmJHqSwsQetUICa8kM3SqYYYcitWZAd
 8LrhFgWmLtQ4Y4i9q/L7NEuRjhHBoOGT1wCXnxrasvAl/3D9Ja1Hzhbka0WLg7sQ9Z4t9Urk3
 I7CGXDZ2ZY76l/6UlLHCW5OsH7mwl+bLO+m3ftDmn8OKXug69t4vKlFO64SS69uim5vsHAPaj
 f4/OHJocEJwqndeCBkHf7L1vwmQAnrqUbq/vaVQCiiUkRzbnSal22yPilUMyic/nNX1W68DQt
 U+kUz6JbFfDea9qQXxbwJFV8PbaAAlU/ZGKbhI8+na/eh+MFugOA04xbtby3SE+pSkMwOBy3U
 dYFc/fC/pWOsbf2D1WaMK4YDyp/npxLwRCW4ufddWZYfMEyzdx95CYc8hjIZSenR8SnvvFVI0
 pS8wFxZhQCasMLNej6SJlQqTJQwZ2Izj+btqIsDNmpe629vQ5JZECzu7hxAt/nx6DzftqaFvl
 /Mr2T2jdc3B43W0Qs42gZBriN2L1pRHID7oXU0d9t+JAQhukawHwSfptyMwmCfzk7s2Kv0ZJI
 p5WysdV+9+iG+L0f9JsGPwK01WcJK/GuZD4i75F7Sws14Pt3gWPPIAbb77u7nAWfaaqwE8yVh
 NW1rvjedY7vbgLG18maX+nikA64EL1cKHqM8ZhOpQgzN7yPpZBhptBB6bO4tXaFpz3oF0CoDt
 eDZDY0kDMpTf5zgywxOQzbU/zvMIhmn/9kfh/miOgZUY4v0vD6E21QF9dV0HmRTqwW4XX7y8+
 xQVueev6Cp0svqnMB34Q2jXMdqPwdlkqlx2ECRxf1oUKYecPiYQurWD3gRP64uWQihj788FQ1
 7UC13q/nelx+TsNos/se645JkIwPMkubDqp++3gy2+v5y0plhcGbJWxYnu
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

On 2/7/25 13:45, Daniel Venzin wrote:
> This implementation currently does not support
> moving files between directories.

Why would we make such a restriction?

>
> Signed-off-by: Daniel Venzin <Daniel.Venzin@mt.com>
>
> ---
>
> Changes in v3:
> - Abort the rename if the destination is a path instead of a file
>
> Changes in v2:
> - Separate the rename implementation from changes in the filesystem laye=
r
> - Eliminate code duplication with delete_dentry_long(..)
> - Ensure that the source file exists, but not the destination file
> - Free the fatbuf if it has been reinitialized with fat_itr_root
> - Delete orphaned FAT entry after copying file metadata
>
>   fs/fat/fat_write.c | 125 +++++++++++++++++++++++++++++++++++++++++++++
>   fs/fs.c            |   2 +-
>   include/fat.h      |   1 +
>   3 files changed, 127 insertions(+), 1 deletion(-)
>
> diff --git a/fs/fat/fat_write.c b/fs/fat/fat_write.c
> index c78b80e0b7a..6e4ff7c57d4 100644
> --- a/fs/fat/fat_write.c
> +++ b/fs/fat/fat_write.c
> @@ -1821,3 +1821,128 @@ exit:
>   	free(dotdent);
>   	return ret;
>   }
> +
> +int file_fat_rename(const char *path, const char *new_fname)

Below you are expecting that new_fname is a path not only a file name.

%s/new_fname/new_path/

> +{
> +	fsdata datablock =3D { .fatbuf =3D NULL, };
> +	fat_itr *itr =3D NULL;
> +
> +	dir_entry *dentry;
> +
> +	char new_path[VFAT_MAXLEN_BYTES];
> +	char *new_fname_copy =3D NULL, *new_fname_dirname, *new_fname_basename=
;
> +	char *path_copy =3D NULL, *path_dirname, *path_basename;
> +
> +	loff_t actwrite;
> +
> +	__u16 starthi, start;
> +	__u32 size, entry;
> +
> +	int ret =3D -1;
> +
> +	new_fname_copy =3D strdup(new_fname);
> +	if (!new_fname_copy)
> +		goto exit;
> +
> +	split_filename(new_fname_copy, &new_fname_dirname, &new_fname_basename=
);
> +
> +	if (strlen(new_fname_dirname) > 1 ||
> +		(strcmp(new_fname_dirname, "/") !=3D 0 &&
> +		 strcmp(new_fname_dirname, ".") !=3D 0)) {

No clue, why you expect "/" or "." at the beginning of a path.
In U-Boot file paths are always relative to the root directory.

Shouldn't fat_itr_resolve() take care of checking the validity of the path=
?

> +		ret =3D -EINVAL;
> +		goto exit;
> +	}
> +
> +	path_copy =3D strdup(path);
> +	if (!path_copy)
> +		goto exit;
> +
> +	split_filename(path_copy, &path_dirname, &path_basename);
> +	snprintf(new_path, sizeof(new_path), "%s/%s", path_dirname, new_fname_=
basename);

You already determined new_fname_dirname. You must not ignore it.
You should delete above statement.

> +
> +	if (!fat_exists(path)) {
> +		ret =3D -ENOENT;
> +		goto exit;
> +	}
> +
> +	if (fat_exists(new_path)) {
> +		ret =3D -EEXIST;
> +		goto exit;
> +	}
> +
> +	ret =3D file_fat_write(new_path, &actwrite, 0, 0, &actwrite);
> +	if (ret)
> +		goto exit;
> +
> +	itr =3D malloc_cache_aligned(sizeof(*itr));
> +	if (!itr) {
> +		ret =3D -ENOMEM;
> +		goto exit;
> +	}
> +
> +	ret =3D fat_itr_root(itr, &datablock);
> +	if (ret)
> +		goto exit;
> +
> +	ret =3D fat_itr_resolve(itr, path, TYPE_FILE);

Why don't we allow renaming of directories?

TYPE_FILE | TYPE_DIR

> +	if (ret)
> +		goto exit;
> +
> +	dentry =3D itr->dent;
> +
> +	starthi =3D dentry->starthi;
> +	start =3D dentry->start;
> +	size =3D dentry->size;
> +
> +	free(datablock.fatbuf);
> +	datablock.fatbuf =3D NULL;
> +
> +	ret =3D fat_itr_root(itr, &datablock);
> +	if (ret)
> +		goto exit;
> +
> +	ret =3D fat_itr_resolve(itr, new_path, TYPE_FILE);

This would not detect if new_path points to an existing or non-existing
directory.

Check that new_fname_dirname exists and then use the same itr to check
that new_fname_dirname/new_basename does not exist.

This avoids iterating once here and once in fat_rename().

> +	if (ret)
> +		goto exit;

We don't want to overwrite existing files or directories. Don't we
expect -ENOENT or -ENOTDIR here?

> +
> +	dentry =3D itr->dent;
> +
> +	fsdata *mydata =3D itr->fsdata;
> +
> +	entry =3D START(dentry);
> +
> +	dentry->starthi =3D starthi;
> +	dentry->start =3D start;
> +	dentry->size =3D size;
> +
> +	ret =3D flush_dir(itr);
> +	if (ret)
> +		goto exit;
> +
> +	clear_fatent(mydata, entry);
> +	if (flush_dirty_fat_buffer(mydata) < 0) {
> +		printf("Error: flush fat buffer\n");
> +		ret =3D -EIO;
> +		goto exit;
> +	}
> +
> +	free(datablock.fatbuf);
> +	datablock.fatbuf =3D NULL;
> +
> +	ret =3D fat_itr_root(itr, &datablock);
> +	if (ret)
> +		goto exit;
> +
> +	ret =3D fat_itr_resolve(itr, path, TYPE_FILE);
> +	if (ret)
> +		goto exit;

Why don't you use separate variables for the old and the new itr value?
Then you would not have to resolve the old path twice.

Best regards

Heinrich

> +
> +	ret =3D delete_dentry_long(itr, FATENT_CLEAR_SKIP);> +
> +exit:
> +	free(new_fname_copy);
> +	free(path_copy);
> +	free(datablock.fatbuf);
> +	free(itr);
> +	return ret;
> +}
> diff --git a/fs/fs.c b/fs/fs.c
> index b746d05ebcd..3576d5c6644 100644
> --- a/fs/fs.c
> +++ b/fs/fs.c
> @@ -208,7 +208,7 @@ static struct fstype_info fstypes[] =3D {
>   		.write =3D file_fat_write,
>   		.unlink =3D fat_unlink,
>   		.mkdir =3D fat_mkdir,
> -		.rename =3D fs_rename_unsupported,
> +		.rename =3D file_fat_rename,
>   #else
>   		.write =3D fs_write_unsupported,
>   		.unlink =3D fs_unlink_unsupported,
> diff --git a/include/fat.h b/include/fat.h
> index 3dce99a23cf..415ebd7b7c8 100644
> --- a/include/fat.h
> +++ b/include/fat.h
> @@ -207,6 +207,7 @@ int fat_readdir(struct fs_dir_stream *dirs, struct f=
s_dirent **dentp);
>   void fat_closedir(struct fs_dir_stream *dirs);
>   int fat_unlink(const char *filename);
>   int fat_mkdir(const char *dirname);
> +int file_fat_rename(const char *path, const char *new_filename);
>   void fat_close(void);
>   void *fat_next_cluster(fat_itr *itr, unsigned int *nbytes);
>

