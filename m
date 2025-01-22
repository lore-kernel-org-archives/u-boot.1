Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D9BC02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 08:41:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFCD080283;
	Wed, 22 Jan 2025 09:41:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="dLpVxG/o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ED5680586; Wed, 22 Jan 2025 09:41:46 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D73B801FB
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 09:41:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1737535269; x=1738140069; i=xypron.glpk@gmx.de;
 bh=lhKlYlBneJRZp3V4p7+IM9of1ByDn5UFwJSiP1VHzxs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=dLpVxG/oKJYzTGGAdru74o9FsfkylyedzqQxh+Db5e5uaU6ZKmiNDdmp1ya0l7Sg
 K3aQ7ForufS26/ylo9DZYHhOhbPm5p3cxG7QQpUP2IHQ7Bgf7Dn1OFUt5064FtV80
 AmyPQ49QEQr3b0LrAOvf0f31BdNLDKfzVPXuaxjKQhung415E2+nJro4kFtwOXCyl
 SV8EQnD3VTXzEHnc2yagOMJP8mPkgzzjvsSaQKhW2rJEgIo8bBTY4WglHJDm5NXvm
 1X9OPG2whEdkwWJnnuGTudqyAu6kao3qH5YLy0hIPpcZit/oGQDxUicatu0aDlN0e
 VYZ1y9OVPhrnm6gJ8Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MqJmF-1t6OCk1ZLP-00oC2e; Wed, 22
 Jan 2025 09:41:09 +0100
Message-ID: <f5c27e26-24d5-4731-812f-4d857201ce8f@gmx.de>
Date: Wed, 22 Jan 2025 09:41:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] fs: fat: add rename
To: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
Cc: Baruch Siach <baruch@tkos.co.il>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nam Cao <namcao@linutronix.de>, Richard Weinberger <richard@nod.at>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250122053232.17365-1-gabriel.dalimonte@gmail.com>
 <20250122053232.17365-4-gabriel.dalimonte@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250122053232.17365-4-gabriel.dalimonte@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:r29a8rovpSWlIH9TELjB/toZZzE3DZ/vXZgL89Y8C5LAc+cRU38
 YiGdG36uz6tbCoiqxara96gkQHvsuE0StZWHZG28ukGGZDDNOfRCRZGVbyr+7PAggk2WhR2
 yEi0UDepYRpJ3PckM+q0XopJTXpM/dSKA0v0OQQiLbyd0ydhuLvZVM+IMHIN6aYuafezBrT
 0k0osZ9COdLnd2rrJX6mA==
UI-OutboundReport: notjunk:1;M01:P0:wSrQXaT4Vsw=;ZL3zNF9FCeNPtMOorHRdWN9wiA/
 huLv0lSYfnwQopaABwTjaRuPjO3mU8i06DEX2HZrVg30p6YeZDsoy+SkcwxcozUzorwgFsafP
 oRTM+05bwX4tcH8OZA4/4HMGGOaIrqz9WIiCXPhT9aT2B4u57fBi/q+JF0XwQQ5LwNg8GY6cx
 U9isnFokA58nup7HkxPf2UCt14Us4Bs58qMpTgdz+ZcEWVMLTAx/JYHbJY+BS+12bezLhRl/e
 ZA2EW3sLYf+8ATry+s42FE6tDF7LgAQ2NyUJsDtYFveHqS1Gpx9hPvvI9PpYg1+972gJLVXTk
 cQh47bl10DCw+CRGuNd4fpnpOumAZsybceaBaaEN8lxMw5cEY9T4YJ8XgRnR+bZ1USR6OXQ/c
 tIvLzNlzWBQqaOf5aV8aq6NrYn2zYopGEUCxF4tU4P453aZhmUonRutflUpppqSzEQmA00HnL
 p/RwTDR/Lx5iK3BsEzWOJM18MheNdQtl+ger1urfY5UEGgCAdtptPTyaTj245/zjc4BCvQjJD
 g5fW+wFfpJP0oTheMokVukr/rMM3zACHnxeSJiW45H7PABT15B7/DjF5KETutqMFKEhuSUET5
 A4w1A7rnzlCvIxEvGyGljghgZpQORUFyzyYtdTrItlPT3SIfp2A2dkHXOG4K1FpqIIrx8rLV0
 d7T7ykFLhE9BRiBIUKwI4FNZCDaR2nG666KtSMfNmLAQtJeg4W3EFAb6T5BDjgKqbw9ZZDpyp
 1eIKG9y0EN+6hAeEgrKP1T1XOgWFsbVz0NFBzy2un7mTbjCEbiuWBwXcjF/Ng2A+ZL8/R3BdM
 EzifvR7SkiacqFKSD4IFgq3g8+Q3I1O+RcBAYReItIRTO6wkRXcXv656JfBhDRX1DyPFd8Bvy
 i0nzT+WDof5bUMPZiQXwIVBAD/+zID2zKSCq/brB6WYU2Vs9Lu/HpfzZ4DQX+gG94UC0thI5R
 aVkP3xlbicD6oRgKyhpLASmMUm0cHBgVUF5SUhdjUuGsN2e6DPmrEREBhDOhpNQpKcBA3OnGz
 c5SRs/YtMdlIWRH3zCc32fFa00SoPbKEFIEulSo0YyLavwUHfAigOmMBkXd0DebCtgB1Ix2vX
 vg2sT6xp63wYVlJM9bfyLKmgY3rN062K+MVOVu2YMrIw2wC7vMJHgeqR2BDspMKkYU9Fj7I7d
 XUqcNeG00MzqwpBv8YYBCWudLUH/VbNkoEayUcWtEM8+8mkJUP2+MQAVElgwLhL+kqhGY5tED
 LTG9dDmM+9PSXFwyzMxZkh7l34NrEC8dyJlxQORoY0fMCRgi9BJe0GA8D1gBQJsG3W2n2H5UY
 pUOcOoG5e+LqHWubdHHxup0TeLMrJr2gxiKjo0JSHxzanU=
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

On 22.01.25 06:32, Gabriel Dalimonte wrote:
> The implementation roughly follows the POSIX specification for
> rename(). The ordering of operations attempting to minimize the chance
> for data loss in unexpected circumstances.
>
> The fatrename command is added mostly for the purpose of testing
> through the sandbox build.

We should not introduce a FAT specific commands. A file-system specific
command like 'fatload' does not offer a user benefit over a generic
command like 'load'.

Instead, please, create a 'mv' command that will use whatever
file-system is on the partition.

Please, add documentation for every new command in doc/usage/cmd/.

The FAT file system is used in SPL where we need to avoid binary size
increases.

Please, create a Kconfig symbol for renaming support.

Please, don't add the rename field in fs/fs.c to the driver if the
Kconfig symbol is not set or if in SPL.

This should be enough for the linker to eliminate the rename support
from the FAT driver if not needed.

>
> Signed-off-by: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
> ---
>
>   cmd/fat.c                               |  14 +
>   fs/fat/fat_write.c                      | 284 ++++++++++++++++++
>   fs/fs.c                                 |   3 +-
>   include/fat.h                           |   1 +
>   test/py/tests/test_fs/conftest.py       | 121 ++++++++
>   test/py/tests/test_fs/fstest_helpers.py |   2 +
>   test/py/tests/test_fs/test_rename.py    | 366 ++++++++++++++++++++++++
>   7 files changed, 790 insertions(+), 1 deletion(-)
>   create mode 100644 test/py/tests/test_fs/test_rename.py
>
> diff --git a/cmd/fat.c b/cmd/fat.c
> index 5b7484dc1a..56e6bd0f89 100644
> --- a/cmd/fat.c
> +++ b/cmd/fat.c
> @@ -132,4 +132,18 @@ U_BOOT_CMD(
>   	"<interface> [<dev[:part]>] <directory>\n"
>   	"    - create a directory in 'dev' on 'interface'"
>   );
> +
> +static int do_fat_rename(struct cmd_tbl *cmdtp, int flag, int argc,
> +			 char *const argv[])
> +{
> +	return do_rename(cmdtp, flag, argc, argv, FS_TYPE_FAT);
> +}
> +
> +U_BOOT_CMD(
> +	fatrename,	5,	1,	do_fat_rename,
> +	"rename a file/directory",
> +	"<interface> [<dev[:part]>] <old_path> <new_path>\n"
> +	"    - renames a file/directory in 'dev' on 'interface' from 'old_path=
'\n"
> +	"      to 'new_path'"
> +);
>   #endif
> diff --git a/fs/fat/fat_write.c b/fs/fat/fat_write.c
> index b86e78abc0..f9f7051e30 100644
> --- a/fs/fat/fat_write.c
> +++ b/fs/fat/fat_write.c
> @@ -1823,3 +1823,287 @@ exit:
>   	free(dotdent);
>   	return ret;
>   }
> +
> +/**
> + * fat_itr_parent() - modifies the iterator to the parent directory of =
the
> + * current iterator.
> + *
> + * @itr:	iterator positioned anywhere in a directory
> + * @Return:	0 if the iterator is in the parent directory, -errno otherw=
ise
> + */
> +static int fat_itr_parent(fat_itr *itr)
> +{
> +	int ret;
> +
> +	if (itr->is_root)
> +		return -EIO;
> +
> +	/* ensure iterator is at the first directory entry */
> +	ret =3D fat_move_to_cluster(itr, itr->start_clust);
> +	if (ret)
> +		return ret;
> +
> +	return fat_itr_resolve(itr, "..", TYPE_DIR);
> +}
> +
> +/**
> + * check_path_prefix() - errors if a proposed path contains another pat=
h

 From the description it remains unclear to me what this checks.

> + *
> + * note: the iterator may be pointing to any directory entry in the dir=
ectory
> + *
> + * @prefix_clust:	start cluster of the final directory in the prefix pa=
th
> + * @path_itr:	iterator of the path to check.
> + * Return:	-errno on error, 0 on success
> + */
> +static int check_path_prefix(loff_t prefix_clust, fat_itr *path_itr)
> +{
> +	fat_itr *itr =3D NULL;
> +	fsdata fsdata =3D { .fatbuf =3D NULL, }, *mydata =3D &fsdata;
> +	int ret;
> +
> +	itr =3D malloc_cache_aligned(sizeof(fat_itr));
> +	if (!itr) {
> +		debug("Error: allocating memory\n");
> +		ret =3D -ENOMEM;
> +		goto exit;
> +	}
> +
> +	/* duplicate fsdata */
> +	*itr =3D *path_itr;
> +	fsdata =3D *itr->fsdata;
> +
> +	/* allocate local fat buffer */
> +	fsdata.fatbuf =3D malloc_cache_aligned(FATBUFSIZE);
> +	if (!fsdata.fatbuf) {
> +		debug("Error: allocating memory\n");
> +		ret =3D -ENOMEM;
> +		goto exit;
> +	}
> +
> +	fsdata.fatbufnum =3D -1;
> +	itr->fsdata =3D &fsdata;
> +
> +	/* ensure iterator is at the first directory entry */
> +	ret =3D fat_move_to_cluster(itr, itr->start_clust);
> +	if (ret)
> +		goto exit;
> +
> +	while (1) {
> +		if (prefix_clust =3D=3D itr->start_clust) {
> +			ret =3D -EINVAL;
> +			break;
> +		}
> +
> +		if (itr->is_root) {
> +			ret =3D 0;
> +			break;
> +		}
> +
> +		/* Should not occur in a well-formed FAT filesystem besides the root =
*/
> +		if (fat_itr_parent(itr)) {

This deserves a log_debug() message pointing to the file-system corruption=
.

> +			ret =3D -EIO;
> +			break;

Somebody adding code after the loop might not see this. Therefore I
would prefer `goto exit;` here.

> +		}
> +	}
> +
> +exit:
> +	free(fsdata.fatbuf);
> +	free(itr);
> +	return ret;
> +}
> +
> +/**
> + * fat_rename - rename/move a file or directory
> + *
> + * @old_path:	path to the existing file/directory
> + * @new_path:	new path/name for the rename/move
> + * Return:	0 on success, -errno otherwise
> + */
> +int fat_rename(const char *old_path, const char *new_path)
> +{
> +	fat_itr *old_itr =3D NULL, *new_itr =3D NULL;
> +	fsdata old_datablock =3D { .fatbuf =3D NULL, };
> +	fsdata new_datablock =3D { .fatbuf =3D NULL, };
> +	/* used for START macro */
> +	fsdata *mydata =3D &old_datablock;
> +	int ret =3D -EIO, is_old_dir;
> +	char *old_path_copy, *old_dirname, *old_basename;
> +	char *new_path_copy, *new_dirname, *new_basename;

All of these cannot be longer than 256 characters.

Can we allocate the on the stack.

> +	char l_new_basename[VFAT_MAXLEN_BYTES];
> +	__u32 old_clust;
> +	dir_entry *found_existing;
> +	/* only set if found_existing !=3D NULL */
> +	__u32 new_clust;
> +
> +	old_path_copy =3D strdup(old_path);
> +	new_path_copy =3D strdup(new_path);
> +	old_itr =3D malloc_cache_aligned(sizeof(fat_itr));
> +	new_itr =3D malloc_cache_aligned(sizeof(fat_itr));
> +	if (!old_path_copy || !new_path_copy || !old_itr || !new_itr) {
> +		printf("Error: out of memory\n");

log_debug()

Please, do not write messages in the FAT driver. log_debug() is ok.


> +		ret =3D -ENOMEM;
> +		goto exit;
> +	}
> +	split_filename(old_path_copy, &old_dirname, &old_basename);
> +	split_filename(new_path_copy, &new_dirname, &new_basename);
> +
> +	if (normalize_longname(l_new_basename, new_basename)) {
> +		printf("FAT: illegal filename (%s)\n", new_basename);

log_debug()

> +		ret =3D -EINVAL;
> +		goto exit;
> +	}
> +
> +	if (!strcmp(old_basename, ".") || !strcmp(old_basename, "..") ||
> +	    !strcmp(old_basename, "") || !strcmp(l_new_basename, ".") ||
> +	    !strcmp(l_new_basename, "..") || !strcmp(l_new_basename, "")) {
> +		ret =3D -EINVAL;
> +		goto exit;
> +	}
> +
> +	/* checking for old_path =3D=3D new_path is deferred until they're res=
olved */
> +
> +	/* resolve old_path */
> +	ret =3D fat_itr_root(old_itr, &old_datablock);
> +	if (ret)
> +		goto exit;
> +
> +	ret =3D fat_itr_resolve(old_itr, old_dirname, TYPE_DIR);
> +	if (ret) {
> +		printf("%s: doesn't exist (%d)\n", old_dirname, ret);

"%s doesn't exist (%d)\n"

log_debug()

> +		ret =3D -ENOENT;
> +		goto exit;
> +	}
> +
> +	if (!find_directory_entry(old_itr, old_basename)) {
> +		log_err("%s: doesn't exist (%d)\n", old_basename, -ENOENT);

"%s doesn't exist (%d)\n"

log_debug()

> +		ret =3D -ENOENT;
> +		goto exit;
> +	}
> +
> +	/* store clust old_path points to, to relink later */
> +	total_sector =3D old_datablock.total_sect;
> +	old_clust =3D START(old_itr->dent);
> +	is_old_dir =3D fat_itr_isdir(old_itr);
> +
> +	/* resolve new_path*/
> +	ret =3D fat_itr_root(new_itr, &new_datablock);
> +	if (ret)
> +		goto exit;
> +
> +	ret =3D fat_itr_resolve(new_itr, new_dirname, TYPE_DIR);
> +	if (ret) {
> +		printf("%s: doesn't exist (%d)\n", new_dirname, ret);

"%s doesn't exist (%d)\n"

log_debug()

Best regards

Heinrich

> +		ret =3D -ENOENT;
> +		goto exit;
> +	}
> +
> +	found_existing =3D find_directory_entry(new_itr, l_new_basename);
> +
> +	if (found_existing) {
> +		/* store cluster of new_path since it may need to be deleted */
> +		new_clust =3D START(new_itr->dent);
> +
> +		/* old_path is new_path, noop */
> +		if (old_clust =3D=3D new_clust) {
> +			ret =3D 0;
> +			goto exit;
> +		}
> +
> +		if (fat_itr_isdir(new_itr) !=3D is_old_dir) {
> +			if (is_old_dir)
> +				ret =3D -ENOTDIR;
> +			else
> +				ret =3D -EISDIR;
> +			goto exit;
> +		}
> +	}
> +
> +	if (is_old_dir) {
> +		ret =3D check_path_prefix(old_clust, new_itr);
> +		if (ret)
> +			goto exit;
> +	}
> +
> +	/* create/update dentry to point to old_path's data cluster */
> +	if (found_existing) {
> +		struct nameext new_name =3D new_itr->dent->nameext;
> +		__u8 lcase =3D new_itr->dent->lcase;
> +
> +		if (is_old_dir) {
> +			int n_entries =3D fat_dir_entries(new_itr);
> +
> +			if (n_entries < 0) {
> +				ret =3D n_entries;
> +				goto exit;
> +			}
> +			if (n_entries > 2) {
> +				printf("Error: directory is not empty: %d\n",
> +				       n_entries);
> +				ret =3D -EINVAL;
> +				goto exit;
> +			}
> +		}
> +
> +		*new_itr->dent =3D *old_itr->dent;
> +		new_itr->dent->nameext =3D new_name;
> +		new_itr->dent->lcase =3D lcase;
> +	} else {
> +		/* reset iterator to the start of the directory */
> +		ret =3D fat_move_to_cluster(new_itr, new_itr->start_clust);
> +		if (ret)
> +			goto exit;
> +
> +		ret =3D create_link(new_itr, l_new_basename, old_clust,
> +				  old_itr->dent->size, old_itr->dent->attr);
> +		if (ret)
> +			goto exit;
> +	}
> +
> +	ret =3D flush_dir(new_itr);
> +	if (ret)
> +		goto exit;
> +
> +	/* with new_path data cluster unreferenced, clear it */
> +	if (found_existing) {
> +		ret =3D clear_fatent(&new_datablock, new_clust);
> +		if (ret)
> +			goto exit;
> +	}
> +
> +	/* update moved directory so the parent is new_path */
> +	if (is_old_dir) {
> +		__u32 clust =3D new_itr->start_clust;
> +		dir_entry *dent;
> +
> +		fat_itr_child(new_itr, new_itr);
> +		dent =3D find_directory_entry(new_itr, "..");
> +		if (!dent) {
> +			printf("Error: Directory missing parent entry (..)\n");
> +			ret =3D -EIO;
> +			goto exit;
> +		}
> +		set_start_cluster(&new_datablock, dent, clust);
> +		ret =3D flush_dir(new_itr);
> +		if (ret)
> +			goto exit;
> +	}
> +
> +	/* refresh old in case write happened to the same block. */
> +	ret =3D fat_move_to_cluster(old_itr, old_itr->dent_clust);
> +	if (ret)
> +		goto exit;
> +
> +	ret =3D delete_dentry_link(old_itr);
> +	if (ret)
> +		goto exit;
> +
> +exit:
> +	free(new_datablock.fatbuf);
> +	free(old_datablock.fatbuf);
> +	free(new_itr);
> +	free(old_itr);
> +	free(new_path_copy);
> +	free(old_path_copy);
> +
> +	return ret;
> +}
> diff --git a/fs/fs.c b/fs/fs.c
> index 160a43c957..424adfbbfb 100644
> --- a/fs/fs.c
> +++ b/fs/fs.c
> @@ -208,12 +208,13 @@ static struct fstype_info fstypes[] =3D {
>   		.write =3D file_fat_write,
>   		.unlink =3D fat_unlink,
>   		.mkdir =3D fat_mkdir,
> +		.rename =3D fat_rename,
>   #else
>   		.write =3D fs_write_unsupported,
>   		.unlink =3D fs_unlink_unsupported,
>   		.mkdir =3D fs_mkdir_unsupported,
> -#endif
>   		.rename =3D fs_rename_unsupported,
> +#endif
>   		.uuid =3D fat_uuid,
>   		.opendir =3D fat_opendir,
>   		.readdir =3D fat_readdir,
> diff --git a/include/fat.h b/include/fat.h
> index 3dce99a23c..ca97880de1 100644
> --- a/include/fat.h
> +++ b/include/fat.h
> @@ -206,6 +206,7 @@ int fat_opendir(const char *filename, struct fs_dir_=
stream **dirsp);
>   int fat_readdir(struct fs_dir_stream *dirs, struct fs_dirent **dentp);
>   void fat_closedir(struct fs_dir_stream *dirs);
>   int fat_unlink(const char *filename);
> +int fat_rename(const char *old_path, const char *new_path);
>   int fat_mkdir(const char *dirname);
>   void fat_close(void);
>   void *fat_next_cluster(fat_itr *itr, unsigned int *nbytes);
> diff --git a/test/py/tests/test_fs/conftest.py b/test/py/tests/test_fs/c=
onftest.py
> index af2adaf164..9e188f2228 100644
> --- a/test/py/tests/test_fs/conftest.py
> +++ b/test/py/tests/test_fs/conftest.py
> @@ -18,6 +18,7 @@ supported_fs_fat =3D ['fat12', 'fat16']
>   supported_fs_mkdir =3D ['fat12', 'fat16', 'fat32']
>   supported_fs_unlink =3D ['fat12', 'fat16', 'fat32']
>   supported_fs_symlink =3D ['ext4']
> +supported_fs_rename =3D ['fat12', 'fat16', 'fat32']
>
>   #
>   # Filesystem test specific setup
> @@ -55,6 +56,7 @@ def pytest_configure(config):
>       global supported_fs_mkdir
>       global supported_fs_unlink
>       global supported_fs_symlink
> +    global supported_fs_rename
>
>       def intersect(listA, listB):
>           return  [x for x in listA if x in listB]
> @@ -68,6 +70,7 @@ def pytest_configure(config):
>           supported_fs_mkdir =3D  intersect(supported_fs, supported_fs_m=
kdir)
>           supported_fs_unlink =3D  intersect(supported_fs, supported_fs_=
unlink)
>           supported_fs_symlink =3D  intersect(supported_fs, supported_fs=
_symlink)
> +        supported_fs_rename =3D  intersect(supported_fs, supported_fs_r=
ename)
>
>   def pytest_generate_tests(metafunc):
>       """Parametrize fixtures, fs_obj_xxx
> @@ -99,6 +102,9 @@ def pytest_generate_tests(metafunc):
>       if 'fs_obj_symlink' in metafunc.fixturenames:
>           metafunc.parametrize('fs_obj_symlink', supported_fs_symlink,
>               indirect=3DTrue, scope=3D'module')
> +    if 'fs_obj_rename' in metafunc.fixturenames:
> +        metafunc.parametrize('fs_obj_rename', supported_fs_rename,
> +            indirect=3DTrue, scope=3D'module')
>
>   #
>   # Helper functions
> @@ -527,6 +533,121 @@ def fs_obj_symlink(request, u_boot_config):
>           call('rm -rf %s' % scratch_dir, shell=3DTrue)
>           call('rm -f %s' % fs_img, shell=3DTrue)
>
> +#
> +# Fixture for rename test
> +#
> +@pytest.fixture()
> +def fs_obj_rename(request, u_boot_config):
> +    """Set up a file system to be used in rename tests.
> +
> +    Args:
> +        request: Pytest request object.
> +        u_boot_config: U-Boot configuration.
> +
> +    Return:
> +        A fixture for rename tests, i.e. a triplet of file system type,
> +        volume file name, and dictionary of test identifier and md5val.
> +    """
> +    def new_rand_file(path):
> +        check_call('dd if=3D/dev/urandom of=3D%s bs=3D1K count=3D1' % p=
ath, shell=3DTrue)
> +
> +    def file_hash(path):
> +        out =3D check_output(
> +            'dd if=3D%s bs=3D1K skip=3D0 count=3D1 2> /dev/null | md5su=
m' % path,
> +            shell=3DTrue
> +        )
> +        return out.decode().split()[0]
> +
> +    fs_type =3D request.param
> +    fs_img =3D ''
> +
> +    fs_ubtype =3D fstype_to_ubname(fs_type)
> +    check_ubconfig(u_boot_config, fs_ubtype)
> +
> +    mount_dir =3D u_boot_config.persistent_data_dir + '/scratch'
> +
> +    try:
> +        check_call('mkdir -p %s' % mount_dir, shell=3DTrue)
> +    except CalledProcessError as err:
> +        pytest.skip('Preparing mount folder failed for filesystem: ' + =
fs_type + '. {}'.format(err))
> +        call('rm -f %s' % fs_img, shell=3DTrue)
> +        return
> +
> +    try:
> +        md5val =3D {}
> +        # Test Case 1
> +        check_call('mkdir %s/test1' % mount_dir, shell=3DTrue)
> +        new_rand_file('%s/test1/file1' % mount_dir)
> +        md5val['test1'] =3D file_hash('%s/test1/file1' % mount_dir)
> +
> +        # Test Case 2
> +        check_call('mkdir %s/test2' % mount_dir, shell=3DTrue)
> +        new_rand_file('%s/test2/file1' % mount_dir)
> +        new_rand_file('%s/test2/file_exist' % mount_dir)
> +        md5val['test2'] =3D file_hash('%s/test2/file1' % mount_dir)
> +
> +        # Test Case 3
> +        check_call('mkdir -p %s/test3/dir1' % mount_dir, shell=3DTrue)
> +        new_rand_file('%s/test3/dir1/file1' % mount_dir)
> +        md5val['test3'] =3D file_hash('%s/test3/dir1/file1' % mount_dir=
)
> +
> +        # Test Case 4
> +        check_call('mkdir -p %s/test4/dir1' % mount_dir, shell=3DTrue)
> +        check_call('mkdir %s/test4/dir2' % mount_dir, shell=3DTrue)
> +        new_rand_file('%s/test4/dir1/file1' % mount_dir)
> +        md5val['test4'] =3D file_hash('%s/test4/dir1/file1' % mount_dir=
)
> +
> +        # Test Case 5
> +        check_call('mkdir -p %s/test5/dir1' % mount_dir, shell=3DTrue)
> +        new_rand_file('%s/test5/file2' % mount_dir)
> +        md5val['test5'] =3D file_hash('%s/test5/file2' % mount_dir)
> +
> +        # Test Case 6
> +        check_call('mkdir -p %s/test6/dir2' % mount_dir, shell=3DTrue)
> +        new_rand_file('%s/test6/file1' % mount_dir)
> +        md5val['test6'] =3D file_hash('%s/test6/file1' % mount_dir)
> +
> +        # Test Case 7
> +        check_call('mkdir -p %s/test7/dir1' % mount_dir, shell=3DTrue)
> +        check_call('mkdir -p %s/test7/dir2' % mount_dir, shell=3DTrue)
> +        new_rand_file('%s/test7/dir2/file1' % mount_dir)
> +        md5val['test7'] =3D file_hash('%s/test7/dir2/file1' % mount_dir=
)
> +
> +        # Test Case 8
> +        check_call('mkdir -p %s/test8/dir1' % mount_dir, shell=3DTrue)
> +        new_rand_file('%s/test8/dir1/file1' % mount_dir)
> +        md5val['test8'] =3D file_hash('%s/test8/dir1/file1' % mount_dir=
)
> +
> +        # Test Case 9
> +        check_call('mkdir -p %s/test9/dir1/nested/inner' % mount_dir, s=
hell=3DTrue)
> +        new_rand_file('%s/test9/dir1/nested/inner/file1' % mount_dir)
> +
> +        # Test Case 10
> +        check_call('mkdir -p %s/test10' % mount_dir, shell=3DTrue)
> +        new_rand_file('%s/test10/file1' % mount_dir)
> +        md5val['test10'] =3D file_hash('%s/test10/file1' % mount_dir)
> +
> +        # Test Case 11
> +        check_call('mkdir -p %s/test11/dir1' % mount_dir, shell=3DTrue)
> +        new_rand_file('%s/test11/dir1/file1' % mount_dir)
> +        md5val['test11'] =3D file_hash('%s/test11/dir1/file1' % mount_d=
ir)
> +
> +        try:
> +            # 128MiB volume
> +            fs_img =3D fs_helper.mk_fs(u_boot_config, fs_type, 0x800000=
0, '128MB', mount_dir)
> +        except CalledProcessError as err:
> +            pytest.skip('Creating failed for filesystem: ' + fs_type + =
'. {}'.format(err))
> +            return
> +
> +    except CalledProcessError:
> +        pytest.skip('Setup failed for filesystem: ' + fs_type)
> +        return
> +    else:
> +        yield [fs_ubtype, fs_img, md5val]
> +    finally:
> +        call('rm -rf %s' % mount_dir, shell=3DTrue)
> +        call('rm -f %s' % fs_img, shell=3DTrue)
> +
>   #
>   # Fixture for fat test
>   #
> diff --git a/test/py/tests/test_fs/fstest_helpers.py b/test/py/tests/tes=
t_fs/fstest_helpers.py
> index faec298248..c1447b4d43 100644
> --- a/test/py/tests/test_fs/fstest_helpers.py
> +++ b/test/py/tests/test_fs/fstest_helpers.py
> @@ -9,5 +9,7 @@ def assert_fs_integrity(fs_type, fs_img):
>       try:
>           if fs_type =3D=3D 'ext4':
>               check_call('fsck.ext4 -n -f %s' % fs_img, shell=3DTrue)
> +        elif fs_type in ['fat12', 'fat16', 'fat32']:
> +            check_call('fsck.fat -n %s' % fs_img, shell=3DTrue)
>       except CalledProcessError:
>           raise
> diff --git a/test/py/tests/test_fs/test_rename.py b/test/py/tests/test_f=
s/test_rename.py
> new file mode 100644
> index 0000000000..1a849da910
> --- /dev/null
> +++ b/test/py/tests/test_fs/test_rename.py
> @@ -0,0 +1,366 @@
> +# SPDX-License-Identifier:      GPL-2.0+
> +# Copyright 2025 Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
> +#
> +# U-Boot File System:rename Test
> +
> +
> +import pytest
> +
> +from fstest_defs import *
> +from fstest_helpers import assert_fs_integrity
> +
> +@pytest.mark.boardspec('sandbox')
> +@pytest.mark.slow
> +class TestRename(object):
> +    def test_rename1(self, u_boot_console, fs_obj_rename):
> +        """
> +        Test Case 1 - rename a file
> +        """
> +        fs_type, fs_img, md5val =3D fs_obj_rename
> +        with u_boot_console.log.section('Test Case 1 - rename a file'):
> +            d =3D 'test1'
> +            src =3D '%s/file1' % d
> +            dst =3D '%s/file2' % d
> +            output =3D u_boot_console.run_command_list([
> +                'host bind 0 %s' % fs_img,
> +                'setenv filesize',
> +                '%srename host 0:0 %s %s ' % (fs_type, src, dst),
> +            ])
> +            assert('' =3D=3D ''.join(output))
> +
> +            output =3D u_boot_console.run_command_list([
> +                '%sload host 0:0 %x /%s' % (fs_type, ADDR, dst),
> +                'printenv filesize'])
> +            assert('filesize=3D400' in output)
> +
> +            output =3D u_boot_console.run_command_list([
> +                '%sls host 0:0 %s' % (fs_type, d),
> +            ])
> +            assert('file1' not in ''.join(output))
> +
> +            output =3D u_boot_console.run_command_list([
> +                'md5sum %x $filesize' % ADDR,
> +                'setenv filesize'])
> +            assert(md5val['test1'] in ''.join(output))
> +            assert_fs_integrity(fs_type, fs_img)
> +
> +    def test_rename2(self, u_boot_console, fs_obj_rename):
> +        """
> +        Test Case 2 - rename a file to an existing file
> +        """
> +        fs_type, fs_img, md5val =3D fs_obj_rename
> +        with u_boot_console.log.section('Test Case 2 - rename a file to=
 an existing file'):
> +            d =3D 'test2'
> +            src =3D '%s/file1' % d
> +            dst =3D '%s/file_exist' % d
> +            output =3D u_boot_console.run_command_list([
> +                'host bind 0 %s' % fs_img,
> +                'setenv filesize',
> +                '%srename host 0:0 %s %s ' % (fs_type, src, dst),
> +            ])
> +            assert('' =3D=3D ''.join(output))
> +
> +            output =3D u_boot_console.run_command_list([
> +                '%sload host 0:0 %x /%s' % (fs_type, ADDR, dst),
> +                'printenv filesize'])
> +            assert('filesize=3D400' in output)
> +
> +            output =3D u_boot_console.run_command_list([
> +                '%sls host 0:0 %s' % (fs_type, d),
> +            ])
> +            assert('file1' not in ''.join(output))
> +
> +            output =3D u_boot_console.run_command_list([
> +                'md5sum %x $filesize' % ADDR,
> +                'setenv filesize'])
> +            assert(md5val['test2'] in ''.join(output))
> +            assert_fs_integrity(fs_type, fs_img)
> +
> +    def test_rename3(self, u_boot_console, fs_obj_rename):
> +        """
> +        Test Case 3 - rename a directory
> +        """
> +        fs_type, fs_img, md5val =3D fs_obj_rename
> +        with u_boot_console.log.section('Test Case 3 - rename a directo=
ry'):
> +            d =3D 'test3'
> +            src =3D '%s/dir1' % d
> +            dst =3D '%s/dir2' % d
> +            output =3D u_boot_console.run_command_list([
> +                'host bind 0 %s' % fs_img,
> +                'setenv filesize',
> +                '%srename host 0:0 %s %s ' % (fs_type, src, dst),
> +            ])
> +            assert('' =3D=3D ''.join(output))
> +
> +            output =3D u_boot_console.run_command_list([
> +                '%sload host 0:0 %x /%s/file1' % (fs_type, ADDR, dst),
> +                'printenv filesize'])
> +            assert('filesize=3D400' in output)
> +
> +            output =3D u_boot_console.run_command_list([
> +                '%sls host 0:0 %s' % (fs_type, d),
> +            ])
> +            assert('dir1' not in ''.join(output))
> +
> +            output =3D u_boot_console.run_command_list([
> +                'md5sum %x $filesize' % ADDR,
> +                'setenv filesize'])
> +            assert(md5val['test3'] in ''.join(output))
> +            assert_fs_integrity(fs_type, fs_img)
> +
> +    def test_rename4(self, u_boot_console, fs_obj_rename):
> +        """
> +        Test Case 4 - rename a directory to an existing directory
> +        """
> +        fs_type, fs_img, md5val =3D fs_obj_rename
> +        with u_boot_console.log.section('Test Case 4 - rename a directo=
ry to an existing directory'):
> +            d =3D 'test4'
> +            src =3D '%s/dir1' % d
> +            dst =3D '%s/dir2' % d
> +            output =3D u_boot_console.run_command_list([
> +                'host bind 0 %s' % fs_img,
> +                'setenv filesize',
> +                '%srename host 0:0 %s %s ' % (fs_type, src, dst),
> +            ])
> +            assert('' =3D=3D ''.join(output))
> +
> +            output =3D u_boot_console.run_command_list([
> +                '%sload host 0:0 %x /%s/file1' % (fs_type, ADDR, dst),
> +                'printenv filesize'])
> +            assert('filesize=3D400' in output)
> +
> +            output =3D u_boot_console.run_command_list([
> +                '%sls host 0:0 %s' % (fs_type, d),
> +            ])
> +            assert('dir1' not in ''.join(output))
> +
> +            output =3D u_boot_console.run_command_list([
> +                'md5sum %x $filesize' % ADDR,
> +                'setenv filesize'])
> +            assert(md5val['test4'] in ''.join(output))
> +            assert_fs_integrity(fs_type, fs_img)
> +
> +    def test_rename5(self, u_boot_console, fs_obj_rename):
> +        """
> +        Test Case 5 - rename a directory to an existing file
> +        """
> +        fs_type, fs_img, md5val =3D fs_obj_rename
> +        with u_boot_console.log.section('Test Case 5 - rename a directo=
ry to an existing file'):
> +            d =3D 'test5'
> +            src =3D '%s/dir1' % d
> +            dst =3D '%s/file2' % d
> +            output =3D u_boot_console.run_command_list([
> +                'host bind 0 %s' % fs_img,
> +                'setenv filesize',
> +                '%srename host 0:0 %s %s ' % (fs_type, src, dst),
> +            ])
> +            #assert('' =3D=3D ''.join(output))
> +
> +            output =3D u_boot_console.run_command_list([
> +                '%sls host 0:0 %s' % (fs_type, d),
> +            ])
> +            assert('dir1' in ''.join(output))
> +            assert('file2' in ''.join(output))
> +
> +            output =3D u_boot_console.run_command_list([
> +                '%sload host 0:0 %x /%s' % (fs_type, ADDR, dst),
> +                'printenv filesize'])
> +            assert('filesize=3D400' in output)
> +
> +            output =3D u_boot_console.run_command_list([
> +                'md5sum %x $filesize' % ADDR,
> +                'setenv filesize'])
> +            assert(md5val['test5'] in ''.join(output))
> +            assert_fs_integrity(fs_type, fs_img)
> +
> +    def test_rename6(self, u_boot_console, fs_obj_rename):
> +        """
> +        Test Case 6 - rename a file to an existing empty directory
> +        """
> +        fs_type, fs_img, md5val =3D fs_obj_rename
> +        with u_boot_console.log.section('Test Case 6 - rename a file to=
 an existing empty directory'):
> +            d =3D 'test6'
> +            src =3D '%s/file1' % d
> +            dst =3D '%s/dir2' % d
> +            output =3D u_boot_console.run_command_list([
> +                'host bind 0 %s' % fs_img,
> +                'setenv filesize',
> +                '%srename host 0:0 %s %s ' % (fs_type, src, dst),
> +            ])
> +            #assert('' =3D=3D ''.join(output))
> +
> +            output =3D u_boot_console.run_command_list([
> +                '%sload host 0:0 %x /%s' % (fs_type, ADDR, src),
> +                'printenv filesize'])
> +            assert('filesize=3D400' in output)
> +
> +            output =3D u_boot_console.run_command_list([
> +                '%sls host 0:0 %s' % (fs_type, d),
> +            ])
> +            assert('dir2' in ''.join(output))
> +            assert('file1' in ''.join(output))
> +
> +            output =3D u_boot_console.run_command_list([
> +                'md5sum %x $filesize' % ADDR,
> +                'setenv filesize'])
> +            assert(md5val['test6'] in ''.join(output))
> +            assert_fs_integrity(fs_type, fs_img)
> +
> +    def test_rename7(self, u_boot_console, fs_obj_rename):
> +        """
> +        Test Case 7 - rename a directory to a non-empty directory shoul=
d fail
> +        """
> +        fs_type, fs_img, md5val =3D fs_obj_rename
> +        with u_boot_console.log.section('Test Case 7 - rename a directo=
ry to a non-empty directory should fail'):
> +            d =3D 'test7'
> +            src =3D '%s/dir1' % d
> +            dst =3D '%s/dir2' % d
> +            output =3D u_boot_console.run_command_list([
> +                'host bind 0 %s' % fs_img,
> +                'setenv filesize',
> +                '%srename host 0:0 %s %s ' % (fs_type, src, dst),
> +            ])
> +            assert('directory is not empty' in ''.join(output))
> +
> +            output =3D u_boot_console.run_command_list([
> +                '%sload host 0:0 %x /%s/file1' % (fs_type, ADDR, dst),
> +                'printenv filesize'])
> +            assert('filesize=3D400' in output)
> +
> +            output =3D u_boot_console.run_command_list([
> +                '%sls host 0:0 %s' % (fs_type, d),
> +            ])
> +            assert('dir1' in ''.join(output))
> +            assert('dir2' in ''.join(output))
> +
> +            output =3D u_boot_console.run_command_list([
> +                'md5sum %x $filesize' % ADDR,
> +                'setenv filesize'])
> +            assert(md5val['test7'] in ''.join(output))
> +            assert_fs_integrity(fs_type, fs_img)
> +
> +    def test_rename8(self, u_boot_console, fs_obj_rename):
> +        """
> +        Test Case 8 - rename a directory inside itself
> +        """
> +        fs_type, fs_img, md5val =3D fs_obj_rename
> +        with u_boot_console.log.section('Test Case 8 - rename a directo=
ry inside itself'):
> +            d =3D 'test8'
> +            src =3D '%s/dir1' % d
> +            dst =3D '%s/dir1/dir1' % d
> +            output =3D u_boot_console.run_command_list([
> +                'host bind 0 %s' % fs_img,
> +                'setenv filesize',
> +                '%srename host 0:0 %s %s ' % (fs_type, src, dst),
> +            ])
> +
> +            output =3D u_boot_console.run_command_list([
> +                '%sload host 0:0 %x /%s/file1' % (fs_type, ADDR, src),
> +                'printenv filesize'])
> +            assert('filesize=3D400' in output)
> +
> +            output =3D u_boot_console.run_command_list([
> +                '%sls host 0:0 %s' % (fs_type, d),
> +            ])
> +            assert('dir1' in ''.join(output))
> +
> +            output =3D u_boot_console.run_command_list([
> +                '%sls host 0:0 %s' % (fs_type, src),
> +            ])
> +            assert('file1' in ''.join(output))
> +            assert('dir1' not in ''.join(output))
> +
> +            output =3D u_boot_console.run_command_list([
> +                'md5sum %x $filesize' % ADDR,
> +                'setenv filesize'])
> +            assert(md5val['test8'] in ''.join(output))
> +            assert_fs_integrity(fs_type, fs_img)
> +
> +    def test_rename9(self, u_boot_console, fs_obj_rename):
> +        """
> +        Test Case 9 - rename a directory inside itself with backtracks
> +        """
> +        fs_type, fs_img, md5val =3D fs_obj_rename
> +        with u_boot_console.log.section('Test Case 9 - rename a directo=
ry inside itself with backtracks'):
> +            d =3D 'test9'
> +            src =3D '%s/dir1/nested' % d
> +            dst =3D '%s/dir1/nested/inner/./../../../dir1/nested/inner/=
another' % d
> +            output =3D u_boot_console.run_command_list([
> +                'host bind 0 %s' % fs_img,
> +                'setenv filesize',
> +                '%srename host 0:0 %s %s ' % (fs_type, src, dst),
> +            ])
> +
> +            output =3D u_boot_console.run_command_list([
> +                '%sls host 0:0 %s/dir1' % (fs_type, d),
> +            ])
> +            assert('nested' in ''.join(output))
> +
> +            output =3D u_boot_console.run_command_list([
> +                '%sls host 0:0 %s' % (fs_type, src),
> +            ])
> +            assert('inner' in ''.join(output))
> +            assert('nested' not in ''.join(output))
> +            assert_fs_integrity(fs_type, fs_img)
> +
> +    def test_rename10(self, u_boot_console, fs_obj_rename):
> +        """
> +        Test Case 10 - rename a file to itself
> +        """
> +        fs_type, fs_img, md5val =3D fs_obj_rename
> +        with u_boot_console.log.section('Test Case 10 - rename a file t=
o itself'):
> +            d =3D 'test10'
> +            src =3D '%s/file1' % d
> +            output =3D u_boot_console.run_command_list([
> +                'host bind 0 %s' % fs_img,
> +                'setenv filesize',
> +                '%srename host 0:0 %s %s ' % (fs_type, src, src),
> +            ])
> +            assert('' =3D=3D ''.join(output))
> +
> +            output =3D u_boot_console.run_command_list([
> +                '%sload host 0:0 %x /%s' % (fs_type, ADDR, src),
> +                'printenv filesize'])
> +            assert('filesize=3D400' in output)
> +
> +            output =3D u_boot_console.run_command_list([
> +                '%sls host 0:0 %s' % (fs_type, d),
> +            ])
> +            assert('file1' in ''.join(output))
> +
> +            output =3D u_boot_console.run_command_list([
> +                'md5sum %x $filesize' % ADDR,
> +                'setenv filesize'])
> +            assert(md5val['test10'] in ''.join(output))
> +            assert_fs_integrity(fs_type, fs_img)
> +
> +    def test_rename11(self, u_boot_console, fs_obj_rename):
> +        """
> +        Test Case 11 - rename a directory to itself
> +        """
> +        fs_type, fs_img, md5val =3D fs_obj_rename
> +        with u_boot_console.log.section('Test Case 11 - rename a direct=
ory to itself'):
> +            d =3D 'test11'
> +            src =3D '%s/dir1' % d
> +            output =3D u_boot_console.run_command_list([
> +                'host bind 0 %s' % fs_img,
> +                'setenv filesize',
> +                '%srename host 0:0 %s %s ' % (fs_type, src, src),
> +            ])
> +            assert('' =3D=3D ''.join(output))
> +
> +            output =3D u_boot_console.run_command_list([
> +                '%sload host 0:0 %x /%s/file1' % (fs_type, ADDR, src),
> +                'printenv filesize'])
> +            assert('filesize=3D400' in output)
> +
> +            output =3D u_boot_console.run_command_list([
> +                '%sls host 0:0 %s' % (fs_type, d),
> +            ])
> +            assert('dir1' in ''.join(output))
> +
> +            output =3D u_boot_console.run_command_list([
> +                'md5sum %x $filesize' % ADDR,
> +                'setenv filesize'])
> +            assert(md5val['test11'] in ''.join(output))
> +            assert_fs_integrity(fs_type, fs_img)

