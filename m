Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD519C02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 21:12:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2728B80834;
	Sat,  8 Feb 2025 22:12:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Rr3x9gzZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B06C380805; Sat,  8 Feb 2025 22:12:16 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83A6A80821
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 22:12:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1739049133; x=1739653933; i=xypron.glpk@gmx.de;
 bh=q8RXmnV4aBFEHemzX69PpS0LA6vlI5Ww/1bDZnWUC5E=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Rr3x9gzZeRUCSvfW9sO0oELonEl67ggsnCmBoI7ucaGJAW198X/VVsnQv9aMN1UP
 UPShmtZvfNQUk8Dcd4rvo2/QrEni9TGj2cxTfGDCnJKm15L1+0gKWBpxqldKY8gSw
 zJ2cyG8d+Jbm1vzRJrLLmCCKNytfZn77wgAUX4mSftvlC9AhT+4RnimAraKyA7D9C
 pbsQvapjsEosJMPy1i9V4f7ip77vd9vlv+vOI827w+43LwBVnv12fGoIaJOHEfzxL
 k373FE1i/7JseUVivZMvWH3yARY7qYuNoSXue08Mj2GWI7fKeCDKryUHrKgFsE2C4
 0YlUqy17Qf4QUQkalw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsUv-1tcnVi2MrX-00ADfT; Sat, 08
 Feb 2025 22:12:13 +0100
Message-ID: <b2b3a759-a33e-46a4-bc1f-6d0545db784c@gmx.de>
Date: Sat, 8 Feb 2025 22:12:12 +0100
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
X-Provags-ID: V03:K1:5vfsP2toSCfFopmiTDJH92xOmPR7MQqi9LGS57zOyO202vz1D/j
 rhb7VTzFiLiunkZCboWieU9IrbYnuUJ1VQywmHCJvzzkoLo54dxUXfyohQxL3vGL0BWbsqu
 9yCb0/O8f1JjuiAqJGmfBVrgtUHItUtE2Oqp0oE+fJuBP8nZOSp5GVHo2WrOh8tmPyE3PA4
 wtK66dV+jbVkmo/OT/iNA==
UI-OutboundReport: notjunk:1;M01:P0:S0NRFOoljsg=;+TTcrgTHZ446wOHabEkqxzBuZIf
 boONUHZ2LnYELNh7n0fD/FP0jNj5dsTDCDFtlyy0eL8VUkLswooWY8xonH6QJjku1N9fMB3EH
 iZ/8X7hHwUD5LoBU2PsLhgml6DqbGkMxYOGCWD3mqaORzjb59k9x4TQWWlk6xV61hOTiM9ig/
 4dHWVCHJ7y4zunVyAd446YIzUKKO2yEcpHTVUfu/ikjmA343F36julU47XC+FlnRn1GqxAsL5
 8fmhnXVr+hS8DZ6h6FuhT2mkfGNV5kABZLV1rSjTLpGG+PYoqgttthg4e5OOoxzMrs16pxZ2q
 psiX/8KNiWTaaESPE4IO4Yrwad8SbBINHTEtpCytmcCWlnsx7Zz6kXIWmDdrt7JuUNdQs62ec
 UoOUwIKZ5YPAilihN/WtzgIffHxrdRI2eAukjxkPR3RoqaLfhl2aPyANTPQ8ZkpXt0VIXBLED
 UyuXo+05IwogW1ek/zD4hXcXDkafb0lj3G4dpxEETW6TQfye4WeYtOrjrWEZ2zOsYGZjJbFj1
 zo60clrReHSG97ltzT3ztAses980ZjyLFcocQMlr8Zcq8ZnTePfuwdgmVyMe986dYMz2bvDxY
 N9iHucFfjET09kREX++mtvGbz0QPSSRZNmtOhc26bSqAbfVN0flkCQAAHu6Op3Qd0fY2malhu
 C+OAn2N07naoZ+M79ekV+K5DzIggbsYyqd0HWR2ZWEqpaO3U85DVxRed4yp6qgan6GvvlFBc5
 3I6XuEb2hVrjkuFiDTtZ8GHkgM+p1xO7ckH8guSAMRANPE5zDWM7AvLClkDAPCRbAMdbf3tdq
 I2v286FxQpnhfE3ATsNSqVDitBDhRllPdliGQMSIGn+ORvvpRiqGABWI4FJYvdUMA/yzroSL9
 uKZRcHb1iZ8HKtf0gcCZlkSH3yZmz68YTiVh6iNCFH4WbvRNiSZmM+H6MKJjUhVL/1RiP+kBg
 cCf156a4IwWnLOLpQjSYOZpiYxcCB/yH7CtS/m7zAtNgfJLAqqScHG08aHxd+Jv29ZnEK0Oin
 TYlWfFpbntlQ8MWD+vRGdvtrfvKTNKAjvZyCDtgUd0D45FtpvX8hkRKzHOHTNiPbHwQnnRsQ8
 XOFJEZdK1p9F7Pfe+w2bHzip1xD45hJa8GQDBZA2Jlm8uu7VUDqWjCW6r6idH4+gzTCeyTtGc
 sgZdE3wW3ToLb4f2mraj+s7BSiGqeADiYFW1RaeXGB6Qf7w/gaJpQp1Q1LXEfK8FCj7RWYiN6
 ZT868qzmBjx80mBWQ42y6UTtn7JAiMpulQrOZn8uBtLTeTv9Xa51BEALFaBnlrghAs9fQZJ/N
 6rKbVkHXLxBuwi9oYlbGHRwcak8eJB/S01SSZ72zzhOZCPj+JduhpNRZh2bgUiW28CsMGDUDs
 KAwAiyhbAtmTWPZWPES768/6HXIWtbbHniNcfDuqB7v+ohdEiEfCq2p21E
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

Having a separate rename and move functionality makes no sense to me.

The implementation for FAT would be nearly the same.

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
> + * fs_rename - Rename a file

fs_move() - move file

> + *
> + * @old_filename: Name of the file to rename
> + * @new_filename: New name for the file

@old_path: path to file or directory to move
@new_path: new path to file or directory

Best regards

Heinrich

> + * Return: 0 on success, -1 on error conditions
> + */
> +int fs_rename(const char *old_filename, const char *new_filename);
> +
>   /*
>    * Common implementation for various filesystem commands, optionally l=
imited
>    * to a specific filesystem type via the fstype parameter.

