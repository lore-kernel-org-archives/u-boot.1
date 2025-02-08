Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CFE6C02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 20:17:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F318480820;
	Sat,  8 Feb 2025 21:17:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="k6oHeO8q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 911C080821; Sat,  8 Feb 2025 21:17:11 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B6C980805
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 21:17:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1739045811; x=1739650611; i=xypron.glpk@gmx.de;
 bh=hT6ULd6TnZSjx7jhHLcPdhvmLy+dSmbdA8WjugHxLPo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=k6oHeO8qzdCGhez8nNFqAnx60VdL9oYXE6JjSi+Zqi1BPgFeFcLw9L3Sq2kcw1x+
 eSTvJwaYM3Lin/knUwtwy0wlGOF3qJNWqKGs9sGLFVMwec4TDUEvWQUvPjWN/6i4B
 tNGLBBzTIlb98F0E9du4rMCB4N9ElNdMWaFlDxyH3nxAAf0E8TBaopm9wgpyMhLYc
 cTZKSXNYd/vlAnMfZs7o8Wz9TbxCXAR4NXc8LFe3VbqOJc9s3BuYEka1RFxxLeP0X
 w5jFMnyO90MxuNe/DtMM3vUj73asA1BS6kytLYMWp+2/BeMTes1t+BHcbagj59qaF
 yqQrEORidSu4xudUng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MI5Q5-1taTzQ370p-00CPg1; Sat, 08
 Feb 2025 21:16:51 +0100
Message-ID: <a3a46c62-9c09-462f-a3b1-a9d059c74510@gmx.de>
Date: Sat, 8 Feb 2025 21:16:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] fs: Add unimplemented rename hook to FS layer
To: Daniel Venzin <Daniel.Venzin@mt.com>
Cc: burak@gerz.io, gabriel.dalimonte@gmail.com, Manuel.Traut@mt.com,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250207124523.85026-1-Daniel.Venzin@mt.com>
 <20250207124523.85026-2-Daniel.Venzin@mt.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250207124523.85026-2-Daniel.Venzin@mt.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TjoQT5sslwEvTMtPNRlZlS4M851OrxB4DwcfTRO4+vzp2+qnEt1
 gceFTLu0erXNOe6FYBCqHvqoNbhi5prOTXZp4Q7vV9bo9Fz3/HSIzyNisZAklML3jsgbi3U
 7FpjoLs4L3ouHj5DA+jlFcSYFOP06FufdDZqZQtQr790Mm2CMlfWimqkhjNHp7nGbdKhRVy
 D/NS8luG6Z41wydTVNwKg==
UI-OutboundReport: notjunk:1;M01:P0:toYSV4t6Ga4=;NGFHubV8+lcx0IoTP9j2IL5QFcB
 duy/F4hd2BLPl+0oovzAx4x4GtUjhKNFiZqDHvrKfuGIA2dyOb8Qt9fq5AHTdEMfUta8RYUA1
 Osw0F3OltdcwN4WKdlcrC1YdL1g1eUMg6m28X8rqUJhHlEIiJDsuI+xCk5J1jkCX0JT5PMNu7
 sPk1dDERkypXVBGZ1mPoudB+9z7RuUTbxMmYXVgWBBPclFHmtzYgO3c54nSmVWSolM4i9yAIy
 alwz4F4mBdMUriBOBc1Ka2JGKrIHkPvgsiCtBYsw/9EZTfvgQfObjPR/1vWqmTGU1nZZY8oYs
 gq5LAy8jdXrYl2VEI2sS3e9RZvX9rBLinz8fCjFq20ZUNX9c5FreIqys1/AVXLGLbShrm3kIi
 CB/Tt167UPnFCBOiQUYLtr1a9tmMWUhmRc6N4mj1C0YNNgj5Kg1OsSrTRKGD5YL3b3w63mioV
 sVqrcLQSTRUrk0ncDDzBiLXUjIriB/FJobA9GCnQ/Py15PlPC8G9yW4r0gDDiXRhC5oNsWLwn
 pR9F/Snjt2J2wKls3qhGjzVteKgfdihPtLc1/FDzVrPW45e41BQc6xCJx8fUUdvf1HB0Nq29F
 qic5kGgVHWVS9GCd7eWgZXIJIJ/8A5hoolSJbX7tHj4oWEAn9LD6eb3y6YJGhughrCR9qvzIz
 wcLrpk7Ttg66b0Jiiko19gTQu3J+tUMc6KXjkW2nOrFrQsz5zpq4cei/FnSB8WF38r4uAyqRy
 DZqw7gaVflCloCWlC4057+qRigjdrMPb7IJv7911rvjYwjhsCk/n+bW1Zx3epGKEap78AxcXr
 dxUYUQWRIaCBJxfo0WjW2D9Yv/kSdsvUlY/qFt8Ik9YrpzdhjVi/NgosWm7dAdJ1xChOsczV7
 6nt2eKq5eJeVpyVdXHeaMte8P858CtA8n0FFezB8KAYsEXWQ1ZkCFov62CwIhGrLC+VD5A1ay
 hqC51gA+QKrFs9LCl96bPqAKLhNr1m6g93ewIqPlQ+q7XGk8UL5EvAUWqWSuDga6Fkyx08zTF
 EctEgKzCxxUTv5nQ0G+QSPfJppEcKZb2GwtUVHx2tLQS3tranmnza4poQL0vcPKMU+TdRSl7F
 KAgCv5TOcvO8MwY0XcEZqMwd/x3YJdQqH3TtHKZ2DKZZMNLIgYS8DbXLcbveccgbWeE7g3wRW
 V+HbskIZhwgq7vm7D0gg8G/KN4tpvGiADdOyQ/NmFdzorZKl0oLitp95FBlHTO8VOi4xPUhot
 rgb5EFvrMXMPQkaVK0va2o+S+0gyB3wVjtjB5+XhzZSpL+WhKpkAUEY+FDFA3JraQ9Ql+zEVv
 wqMLOmtUgp60/PQBEzFoyqZtpBIwDnUHEQxarP7OgHtWgLt3644shGHG5Xd1mW1vpv5eajX70
 Q1haFmBtiWJcii3S92Xxd96vrO8vk5oBSamoNGmvSFZIoP14GmrLCzRoU1
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
> The EFI API supports file renaming, which is required by
> systemd-stub for its bootcounting implementation.
>
> Signed-off-by: Daniel Venzin <Daniel.Venzin@mt.com>
>
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Adapt variable names for better consistency
> - Add missing rename hooks
>
>   fs/fs.c      | 30 ++++++++++++++++++++++++++++++
>   include/fs.h |  9 +++++++++
>   2 files changed, 39 insertions(+)
>
> diff --git a/fs/fs.c b/fs/fs.c
> index 99ddcc5e37b..b746d05ebcd 100644
> --- a/fs/fs.c
> +++ b/fs/fs.c
> @@ -143,6 +143,12 @@ static inline int fs_mkdir_unsupported(const char *=
dirname)
>   	return -1;
>   }
>
> +static inline int fs_rename_unsupported(const char *old_filename,
> +					 const char *new_filename)
> +{
> +	return -1;
> +}
> +
>   struct fstype_info {
>   	int fstype;
>   	char *name;
> @@ -182,6 +188,7 @@ struct fstype_info {
>   	void (*closedir)(struct fs_dir_stream *dirs);
>   	int (*unlink)(const char *filename);
>   	int (*mkdir)(const char *dirname);

The structure and its elements should be documented.

The expected return values should be described.

> +	int (*rename)(const char *old_filename, const char *new_filename);
>   	int (*ln)(const char *filename, const char *target);
>   };
>
> @@ -201,10 +208,12 @@ static struct fstype_info fstypes[] =3D {
>   		.write =3D file_fat_write,
>   		.unlink =3D fat_unlink,
>   		.mkdir =3D fat_mkdir,
> +		.rename =3D fs_rename_unsupported,
>   #else
>   		.write =3D fs_write_unsupported,
>   		.unlink =3D fs_unlink_unsupported,
>   		.mkdir =3D fs_mkdir_unsupported,
> +		.rename =3D fs_rename_unsupported,
>   #endif
>   		.uuid =3D fat_uuid,
>   		.opendir =3D fat_opendir,
> @@ -238,6 +247,7 @@ static struct fstype_info fstypes[] =3D {
>   		.closedir =3D ext4fs_closedir,
>   		.unlink =3D fs_unlink_unsupported,
>   		.mkdir =3D fs_mkdir_unsupported,
> +		.rename =3D fs_rename_unsupported,
>   	},
>   #endif
>   #if IS_ENABLED(CONFIG_SANDBOX) && !IS_ENABLED(CONFIG_XPL_BUILD)
> @@ -256,6 +266,7 @@ static struct fstype_info fstypes[] =3D {
>   		.opendir =3D fs_opendir_unsupported,
>   		.unlink =3D fs_unlink_unsupported,
>   		.mkdir =3D fs_mkdir_unsupported,
> +		.rename =3D fs_rename_unsupported,
>   		.ln =3D fs_ln_unsupported,
>   	},
>   #endif
> @@ -275,6 +286,7 @@ static struct fstype_info fstypes[] =3D {
>   		.opendir =3D fs_opendir_unsupported,
>   		.unlink =3D fs_unlink_unsupported,
>   		.mkdir =3D fs_mkdir_unsupported,
> +		.rename =3D fs_rename_unsupported,
>   		.ln =3D fs_ln_unsupported,
>   	},
>   #endif
> @@ -295,6 +307,7 @@ static struct fstype_info fstypes[] =3D {
>   		.opendir =3D fs_opendir_unsupported,
>   		.unlink =3D fs_unlink_unsupported,
>   		.mkdir =3D fs_mkdir_unsupported,
> +		.rename =3D fs_rename_unsupported,
>   		.ln =3D fs_ln_unsupported,
>   	},
>   #endif
> @@ -316,6 +329,7 @@ static struct fstype_info fstypes[] =3D {
>   		.opendir =3D fs_opendir_unsupported,
>   		.unlink =3D fs_unlink_unsupported,
>   		.mkdir =3D fs_mkdir_unsupported,
> +		.rename =3D fs_rename_unsupported,
>   		.ln =3D fs_ln_unsupported,
>   	},
>   #endif
> @@ -339,6 +353,7 @@ static struct fstype_info fstypes[] =3D {
>   		.ln =3D fs_ln_unsupported,
>   		.unlink =3D fs_unlink_unsupported,
>   		.mkdir =3D fs_mkdir_unsupported,
> +		.rename =3D fs_rename_unsupported,
>   	},
>   #endif
>   #if IS_ENABLED(CONFIG_FS_EROFS)
> @@ -360,6 +375,7 @@ static struct fstype_info fstypes[] =3D {
>   		.ln =3D fs_ln_unsupported,
>   		.unlink =3D fs_unlink_unsupported,
>   		.mkdir =3D fs_mkdir_unsupported,
> +		.rename =3D fs_rename_unsupported,
>   	},
>   #endif
>   	{
> @@ -377,6 +393,7 @@ static struct fstype_info fstypes[] =3D {
>   		.opendir =3D fs_opendir_unsupported,
>   		.unlink =3D fs_unlink_unsupported,
>   		.mkdir =3D fs_mkdir_unsupported,
> +		.rename =3D fs_rename_unsupported,
>   		.ln =3D fs_ln_unsupported,
>   	},
>   };
> @@ -697,6 +714,19 @@ int fs_mkdir(const char *dirname)
>   	return ret;
>   }
>
> +int fs_rename(const char *old_filename, const char *new_filename)
> +{
> +	int ret;
> +
> +	struct fstype_info *info =3D fs_get_info(fs_type);
> +
> +	ret =3D info->rename(old_filename, new_filename);
> +
> +	fs_close();
> +
> +	return ret;
> +}
> +
>   int fs_ln(const char *fname, const char *target)
>   {
>   	struct fstype_info *info =3D fs_get_info(fs_type);
> diff --git a/include/fs.h b/include/fs.h
> index 2474880385d..8c1aa9c1a7b 100644
> --- a/include/fs.h
> +++ b/include/fs.h
> @@ -270,6 +270,15 @@ int fs_unlink(const char *filename);
>    */
>   int fs_mkdir(const char *filename);
>
> +/*

/**

> + * fs_rename - Rename a file

fs_rename()

Please, have a look at
https://docs.kernel.org/doc-guide/kernel-doc.html#function-documentation

Please, describe that set_blk_dev() must be called before invoking
fs_rename() and that fs_close() is called implicitly.

> + *
> + * @old_filename: Name of the file to rename
> + * @new_filename: New name for the file
> + * Return: 0 on success, -1 on error conditions

Other file system functions return a negative error code like -ENOENT,
-EIO, or -ENOMEM. Why do you require -1 here?

Best regards

Heinrich

> + */
> +int fs_rename(const char *old_filename, const char *new_filename);
> +
>   /*
>    * Common implementation for various filesystem commands, optionally l=
imited
>    * to a specific filesystem type via the fstype parameter.

