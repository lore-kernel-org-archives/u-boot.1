Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D37C02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 08:10:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0CDC80283;
	Wed, 22 Jan 2025 09:10:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Grj1z7Qf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44B6D80586; Wed, 22 Jan 2025 09:10:22 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29D19801FB
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 09:10:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1737533418; x=1738138218; i=xypron.glpk@gmx.de;
 bh=kgzc8BGnlWGVWqMc/6DCFml0guYbnrsyaByIsC6VheI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Grj1z7QfHeytWFDwf2apWlgNh6dtlFMQ0nkvLs+FXPC45f6O+2YeM4NQTmceepV5
 Q2mXlPD06qkJPM4F1uOFZMl/RZ/3YZf45N+TJwaKuHUhuzs9vb89gFOeMgRp5xGuN
 Yz1v3V/i2nj107az27XKjO8pOTfHynq1Tj8eY1lItUdF+yFkjf8rAigo4lubRyrxH
 QZqLEhRs/jJ3EnwAVYyl8aydsScd9B5+PHlNICFfLlDK5QAelj0+knmO0sEFGi5fI
 iBat+PxtLiZBmrLQNWd5G5F064ENraJeTm15Tu4zSmBfJB3WAnxS4AJV1mIAWegU5
 DtsC4PyWJUsVao0vUg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([46.114.109.130]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpUYu-1t8rYs2yiq-00p8qK; Wed, 22
 Jan 2025 09:10:18 +0100
Message-ID: <4a2a96b2-dc0e-4cd2-96c5-399d96f2b5fb@gmx.de>
Date: Wed, 22 Jan 2025 09:10:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] fs: add rename infrastructure
To: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250122053232.17365-1-gabriel.dalimonte@gmail.com>
 <20250122053232.17365-3-gabriel.dalimonte@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250122053232.17365-3-gabriel.dalimonte@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LZxV1U7TJXg7/qdidycCvewIJiOVUt1Jzakd/Bmp1gyMHP78n5S
 ppCANkropAz2FcWyMc1f86/rTvcmlk0eOVqd9JB+MhFXBH5rdUHvQBeGVW9BbslQv5PC0AM
 hx/tlw783m0kfaLwYC/ouWVT1WVt1HBrUMor/II21bcFHxRnPqZvLnNndSbCeAD3sM30KID
 bYx5kn4CGDzOlIXcty6qw==
UI-OutboundReport: notjunk:1;M01:P0:ZxTxiq/HWXs=;k8C7SOxpqw1Q0vrCfMr9xUdIIzD
 nvHRzdDqkleTcjhjgG2gf8ImjsFDkA2h52Z2NHLtiHNlU2EGUNsBeZNdhEz71UPgWxe/D+tIf
 O1YXd4Vei3CN2D8STBuH60+n6bsnJldVXAbEBK7/QMikIkAjDWg1LfwJKm905ykNYHZrFSaoL
 rtVysEbAK4scCzacXKeWR2k7s5eLFkm+wEF/2rkKOtFsIaRBxTMMRttUmkZRN85MLGuhyM8G2
 MIRtR3GF7w+YcwACgvyorTPPfeL15T3UjBfiJ5ZhPVwZ7tsEJzqeHV2MpQTfB1moVDWsBc0BJ
 B88HMoq2zxd6DAFaayHNC3FRrs2znnbbDkIgJW6jYnVftw/SLQ5hZKEbwSs9QWNBAJk+S9vMg
 0jxGJ9nRzM6ETo2M8W+y+MBwmCCH/E2yVSQrYFq7VJJp8837oho6KubAfbkjM5x4NKDb7dbkZ
 A1he0ODX0JfpijsBGT3h898oUAnqlIM5HcjbpvdZa4EwwWWtyD87CExfchf9QS1cYPT+DlnbP
 jDMKt/Vaio9KphGJ1TenVHM6aG2u9o71dcG1B1TuNpS88+kF3P1WjabTYBEz9HNcV75jZS9oZ
 eCmNEFZv9AS8obT3N1x1YFmLU+NdB94CLoRN0vqOO0TYH/CElx0XviN8HcXMsVP2jHxJcyJ/k
 qLAhxVtYRNDRl0YWyYgMQzkaYc0aOC63WMhStzDp0LEeZ7BmzEkXNwSVfSJrkKDgn9t3WmBPA
 WOVRyLSgxJllyaTP2J89l80xuex8EEFOTy45thPFUDFjj3tSoiWBcxSoO9I7wlR+AMz6v0BZn
 8BSv5xcVYnwT2Dgc2xUDpsTh2rZ0LaZ6eV9gNzwvYu2uZsh3otcwSmX9o9ZltO+yP4FSU1NDo
 eRjhzRfAixHbaXQHK6qsIvmjgjjNZCv91UT7D6errUfKdEP4Zv/kfGBReCGHIeyWUjcNdU59A
 fY+d0LvTNxXusQb/fXcKnmYmBH11c3087szDKoCdRKD40BcPzwPCRyV2eztIz2ymOgaziBsv4
 kIsTqtFV+vHlj0bghPz+Bk+Oq1mtCL2Mem2vcLiDjUyWM+gFSHrHZGFEtCor9hdBmB8B0v1Sd
 +nQcLftp5Bb4y86nkj5gh8JFJ4pubDIqq9AvyZwjFU4UL1PhTloYsQkcpYqAWIMeRK5Wdlcpl
 Lc87esyS3TC5GBVC7GqpyRRSEAtljmvZHXUsKiN3hRA==
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
> Signed-off-by: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
> ---

Please, add a commit message.

>
>   fs/fs.c      | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>   include/fs.h | 13 +++++++++++++
>   2 files changed, 60 insertions(+)
>
> diff --git a/fs/fs.c b/fs/fs.c
> index 99ddcc5e37..160a43c957 100644
> --- a/fs/fs.c
> +++ b/fs/fs.c
> @@ -143,6 +143,12 @@ static inline int fs_mkdir_unsupported(const char *=
dirname)
>   	return -1;
>   }
>
> +static inline int fs_rename_unsupported(const char *old_path,
> +					const char *new_path)
> +{
> +	return -1;
> +}
> +
>   struct fstype_info {
>   	int fstype;
>   	char *name;
> @@ -183,6 +189,7 @@ struct fstype_info {
>   	int (*unlink)(const char *filename);
>   	int (*mkdir)(const char *dirname);
>   	int (*ln)(const char *filename, const char *target);
> +	int (*rename)(const char *old_path, const char *new_path);
>   };
>
>   static struct fstype_info fstypes[] =3D {
> @@ -206,6 +213,7 @@ static struct fstype_info fstypes[] =3D {
>   		.unlink =3D fs_unlink_unsupported,
>   		.mkdir =3D fs_mkdir_unsupported,
>   #endif
> +		.rename =3D fs_rename_unsupported,
>   		.uuid =3D fat_uuid,
>   		.opendir =3D fat_opendir,
>   		.readdir =3D fat_readdir,
> @@ -238,6 +246,7 @@ static struct fstype_info fstypes[] =3D {
>   		.closedir =3D ext4fs_closedir,
>   		.unlink =3D fs_unlink_unsupported,
>   		.mkdir =3D fs_mkdir_unsupported,
> +		.rename =3D fs_rename_unsupported,
>   	},
>   #endif
>   #if IS_ENABLED(CONFIG_SANDBOX) && !IS_ENABLED(CONFIG_XPL_BUILD)
> @@ -257,6 +266,7 @@ static struct fstype_info fstypes[] =3D {
>   		.unlink =3D fs_unlink_unsupported,
>   		.mkdir =3D fs_mkdir_unsupported,
>   		.ln =3D fs_ln_unsupported,
> +		.rename =3D fs_rename_unsupported,
>   	},
>   #endif
>   #if CONFIG_IS_ENABLED(SEMIHOSTING)
> @@ -276,6 +286,7 @@ static struct fstype_info fstypes[] =3D {
>   		.unlink =3D fs_unlink_unsupported,
>   		.mkdir =3D fs_mkdir_unsupported,
>   		.ln =3D fs_ln_unsupported,
> +		.rename =3D fs_rename_unsupported,
>   	},
>   #endif
>   #ifndef CONFIG_XPL_BUILD
> @@ -296,6 +307,7 @@ static struct fstype_info fstypes[] =3D {
>   		.unlink =3D fs_unlink_unsupported,
>   		.mkdir =3D fs_mkdir_unsupported,
>   		.ln =3D fs_ln_unsupported,
> +		.rename =3D fs_rename_unsupported,
>   	},
>   #endif
>   #endif
> @@ -317,6 +329,7 @@ static struct fstype_info fstypes[] =3D {
>   		.unlink =3D fs_unlink_unsupported,
>   		.mkdir =3D fs_mkdir_unsupported,
>   		.ln =3D fs_ln_unsupported,
> +		.rename =3D fs_rename_unsupported,
>   	},
>   #endif
>   #endif
> @@ -339,6 +352,7 @@ static struct fstype_info fstypes[] =3D {
>   		.ln =3D fs_ln_unsupported,
>   		.unlink =3D fs_unlink_unsupported,
>   		.mkdir =3D fs_mkdir_unsupported,
> +		.rename =3D fs_rename_unsupported,
>   	},
>   #endif
>   #if IS_ENABLED(CONFIG_FS_EROFS)
> @@ -360,6 +374,7 @@ static struct fstype_info fstypes[] =3D {
>   		.ln =3D fs_ln_unsupported,
>   		.unlink =3D fs_unlink_unsupported,
>   		.mkdir =3D fs_mkdir_unsupported,
> +		.rename =3D fs_rename_unsupported,
>   	},
>   #endif
>   	{
> @@ -378,6 +393,7 @@ static struct fstype_info fstypes[] =3D {
>   		.unlink =3D fs_unlink_unsupported,
>   		.mkdir =3D fs_mkdir_unsupported,
>   		.ln =3D fs_ln_unsupported,
> +		.rename =3D fs_rename_unsupported,
>   	},
>   };
>
> @@ -713,6 +729,22 @@ int fs_ln(const char *fname, const char *target)
>   	return ret;
>   }
>
> +int fs_rename(const char *old_path, const char *new_path)
> +{
> +	struct fstype_info *info =3D fs_get_info(fs_type);
> +	int ret;
> +
> +	ret =3D info->rename(old_path, new_path);
> +
> +	if (ret < 0) {
> +		log_err("** Unable to rename %s -> %s **\n", old_path, new_path);

We should not write messages by default. This will may lead to output
layout in EFI applications looking wrong.

log_debug() would be adequate.

We don't need the "** " first characters.

Otherwise the patch looks good to me.

Best regards

Heinrich

> +		ret =3D -1;
> +	}
> +	fs_close();
> +
> +	return ret;
> +}
> +
>   int do_size(struct cmd_tbl *cmdtp, int flag, int argc, char *const arg=
v[],
>   	    int fstype)
>   {
> @@ -975,6 +1007,21 @@ int do_ln(struct cmd_tbl *cmdtp, int flag, int arg=
c, char *const argv[],
>   	return 0;
>   }
>
> +int do_rename(struct cmd_tbl *cmdtp, int flag, int argc, char *const ar=
gv[],
> +	      int fstype)
> +{
> +	if (argc !=3D 5)
> +		return CMD_RET_USAGE;
> +
> +	if (fs_set_blk_dev(argv[1], argv[2], fstype))
> +		return 1;
> +
> +	if (fs_rename(argv[3], argv[4]))
> +		return 1;
> +
> +	return 0;
> +}
> +
>   int do_fs_types(struct cmd_tbl *cmdtp, int flag, int argc, char * cons=
t argv[])
>   {
>   	struct fstype_info *drv =3D fstypes;
> diff --git a/include/fs.h b/include/fs.h
> index 2474880385..24b121f55d 100644
> --- a/include/fs.h
> +++ b/include/fs.h
> @@ -270,6 +270,17 @@ int fs_unlink(const char *filename);
>    */
>   int fs_mkdir(const char *filename);
>
> +/**
> + * fs_rename - rename a file or directory
> + *
> + * @old_path: existing path of the file/directory to rename
> + * @new_path: new path of the file/directory. If this points to an exis=
ting
> + * file or empty directory, the existing file/directory will be unlinke=
d.
> + *
> + * Return: 0 on success, -1 on error conditions
> + */
> +int fs_rename(const char *old_path, const char *new_path);
> +
>   /*
>    * Common implementation for various filesystem commands, optionally l=
imited
>    * to a specific filesystem type via the fstype parameter.
> @@ -290,6 +301,8 @@ int do_mkdir(struct cmd_tbl *cmdtp, int flag, int ar=
gc, char *const argv[],
>   	     int fstype);
>   int do_ln(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[=
],
>   	  int fstype);
> +int do_rename(struct cmd_tbl *cmdtp, int flag, int argc, char *const ar=
gv[],
> +	      int fstype);
>
>   /*
>    * Determine the UUID of the specified filesystem and print it. Option=
ally it is

