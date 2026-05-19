Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DA0CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 20:00:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 972AE84717;
	Tue, 19 May 2026 22:00:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W05yAabs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67D3B84717; Tue, 19 May 2026 22:00:07 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7C36846E7
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 21:59:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-bd5047a2a4cso663010766b.3
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 12:59:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779220799; cv=none;
 d=google.com; s=arc-20240605;
 b=Owruv9Acsnow8eH4rB4zKgFbNbmpYHMK9C2kwa+iijX/Ek9kjLPC2vvtwycgHTDVzk
 pi1ly3GrGy/WtiY3A2YkJWTySdEZ6mQapaw1AP9U8AuhCTxsncKNSSWplsVEGD1iAdfx
 jORMPeqQX6vpVWwwDQ3d7IraZP9VpyCfiNlVJodCOcPgbVmhq9oiuR6my9QJaKnmPmzk
 z3Zq8AkbB5p+gF6diltG2s83UyMub8qG37+FnF7bPmSMWzcNTRzhYYDchXrgqmwesKqz
 GOGQCKZCsic2VddUvg/ARe1f/yl7iePwW3PR1V35MNCPKo0OkOhqrpqKm9t+J+V2aQ+i
 ZZ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lXqkBgBHWHlFsx8yNZ4rQdprriQHQw/FDVzH+CX72Ho=;
 fh=mBlfBbUxe3eZHGkr7mG/GmZ+VXtgaBBejbkQdstC1C4=;
 b=RBbudyRDMH6fQ1CpmyX/2h3OY9aM82P5ka1lM1l4XjwK3MGQrpkqOq1FMjZwBmO2sp
 ZIEybCSEZ/9iFTvuwvO0nSaAmDsMjlb3CHZ70JLFWM44Tvq8BtmuMm+a+2ApOPtOBb9z
 Wmewvi4avfANzRED4dYQaEmh5c83tR2U3jwIF3s5yBXpL6QxyAXqqL4JsoG4FpC1Kyrw
 SNANd4IRp70nc6S/ylb6pEIpnvus4aCFOg6pn6XOcO8+HYvF4ybTiYQMVMCJuNSjIZRX
 SHomw+8BVgZdMy3Zg2Pl6VN+xS+v0uIkjNoNRw8Lvim5AypUEyrOUVnLL8PXz1FIzQjF
 CjwA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779220799; x=1779825599; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lXqkBgBHWHlFsx8yNZ4rQdprriQHQw/FDVzH+CX72Ho=;
 b=W05yAabse8zqv5CaQ/ljMkMTnyB728dKoIKv+Miax3h79meDR/91M+wNw56JFnXOBv
 qW19UNR85IlFB1JqX6ZrAXt3bOt2WHd61Op35YRSo/ggPIswH1BFqOVglZR9LP0Js+NI
 yEtKI7TwFBGYtmP5voN2ig4S2gb/AvJmKtaFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779220799; x=1779825599;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lXqkBgBHWHlFsx8yNZ4rQdprriQHQw/FDVzH+CX72Ho=;
 b=BMBD2UjxPaQ+0760JHO/iXNzaU5jL1cm9ENFeZUifMeQFQdpr85VGWy3aMCQarmhIV
 2pmONf6Zat3hUqjyxk24Xl59c5f4dyt/EBEvP/NuMRbY83SYaBqwGQCrVIe02eubvFBj
 FvsISsxuacVtp/KkVm1r1zWe/7dYkF45nOpvaWH91nMXXnfk7NYBk3mP1koic2zLgyKm
 Bn8MR7OctZyr8MZhfe4hskimoDY+STXuLkVZ+lCyrQRrwH21j4LaKHh2L8VD6+ej5HQX
 j5Bkwr3IEtc8G/s9nISyZqZxCWYhMZ0jHlnT9SjXq6YW00rLC7pMBr9Ouctli8+p2n44
 fjnQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9KPdVhzZ5I7AbRegjlEfvNeLAaaAFQiQv210wbNlEeyrTWDHKTsw0AWevNFpJoxwUrr5qrG/8=@lists.denx.de
X-Gm-Message-State: AOJu0YxOsEWXsPlzKqm29vPsKaZIJUa6pKjQJRulQVusPDp9R9AswPGr
 e3IkvQeiSYlwpNWyhZW7d5iEQsn5hSJluWO0CIi1xr2/DyYq39z9xL+2+qPrvKCL33upFUT75eW
 wKo8u/D9V6vByweNbZFCeZ5N/YnXvuBL4YvgJbDkw
X-Gm-Gg: Acq92OHGRBAif66cwDSUXLbBCYs+JeNkRIGg0hWalagf2zos2TIPthCV3opdbNwmy4W
 dTZOgJIKVyKJiUMzEm3HkO6DOwdiI4lY7+4KxmQtf+j9lEWy2ZhmwhcMmruDnPTodVhxnygDVOI
 WClkk0soQz8hqc/IO7G4uqZBCfhGLcf5ED4VV5XVaKpvTrm3x+02mJ/cSoTiJfSLcg3JddDnSYq
 N3MDtx06wOIU0wSIZ4HdEBJ5XLNkQW0+vY4RpcFpohRQ62ReUkSDwEuiZkgOfCXDogsxMAw1gS8
 Lvl6+Q==
X-Received: by 2002:a17:907:9453:b0:bd5:28e0:239c with SMTP id
 a640c23a62f3a-bd8caf01170mr447957466b.30.1779220799140; Tue, 19 May 2026
 12:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
 <20260518055728.178507-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260518055728.178507-3-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 May 2026 13:59:48 -0600
X-Gm-Features: AVHnY4J1NxSRZ1DLlaK8cbYb-0YapjfPgHvlgSlKTXiSqHGxHFAYWvr8vAKi88s
Message-ID: <CAFLszTieLo3iVU2PqDUbX5oOeoRGT2A2fCH8R_utrbjDLsuEUA@mail.gmail.com>
Subject: Re: [PATCH 2/9] fs: print change date in directory listing for FAT
To: heinrich.schuchardt@canonical.com
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Huang Jianan <jnhuang95@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Tony Dinh <mibodhi@gmail.com>,
 =?UTF-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>, 
 Francois Berder <fberder@outlook.fr>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Daniel Palmer <daniel@thingy.jp>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.denx.de, linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Heinrich,

On 2026-05-18T05:57:19, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> fs: print change date in directory listing for FAT
>
> fs_ls_generic() displays file sizes but no timestamps. The FAT
> filesystem stores a change date in every directory entry and already
> populates fs_dirent::change_time in fat_readdir(). Print the date
> alongside the file size for filesystems that provide it.
>
> Add a u32 capability bitmap (caps) to struct fstype_info. Each bit
> documents a property that the filesystem's readdir() implementation
> guarantees:
>
>   FS_CAP_DATE  BIT(0)  change_time in fs_dirent is valid
>
> fs_ls_generic() tests FS_CAP_DATE once before the loop to select a
> consistent output format for the entire listing:
>
>   12345678  2024-03-15 09:30  filename.txt    (FAT)
>   12345678   filename.txt                     (ext4, squashfs, ...)
>
> Set FS_CAP_DATE for FAT. fat2rtc() loses the __maybe_unused annotation
> [...]
>
> fs/fat/fat.c |  2 +-
>  fs/fs.c      | 38 +++++++++++++++++++++++++++++++++++---
>  2 files changed, 36 insertions(+), 4 deletions(-)

> diff --git a/fs/fat/fat.c b/fs/fat/fat.c
> @@ -1539,7 +1539,7 @@ int fat_readdir(struct fs_dir_stream *dirs, struct fs_dirent **dentp)
>
>       memset(dent, 0, sizeof(*dent));
>       strcpy(dent->name, dir->itr.name);
> -     if (CONFIG_IS_ENABLED(EFI_LOADER)) {
> +     if (!IS_ENABLED(CONFIG_XPL_BUILD)) {
>               dent->attr = dir->itr.dent->attr;

The commit message says fat2rtc() loses __maybe_unused, but the diff
does not touch fat2rtc()

> diff --git a/fs/fs.c b/fs/fs.c
> @@ -38,6 +38,11 @@ static int fs_dev_part;
>  static struct disk_partition fs_partition;
>  static int fs_type = FS_TYPE_ANY;
>
> +/*
> + * define FS_CAP_DATE - readdir() populates fs_dirent::change_time
> + */
> +#define FS_CAP_DATE  BIT(0)

The leading 'define' reads like a half-finished kernel-doc. Please
make this a plain comment:

   /* FS_CAP_DATE: readdir() populates fs_dirent::change_time */

> diff --git a/fs/fs.c b/fs/fs.c
> @@ -98,10 +107,19 @@ static inline int fs_ls_unsupported(const char *dirname)
>       return -1;
>  }
>
> +/* Forward declaration - defined after fstypes[] */
> +static struct fstype_info *fs_get_info(int fstype);
> +

Patch 1 moved struct fstype_info to the top precisely to avoid this.
Please move fs_get_info() up next to the struct (or just before
fs_ls_generic()) and drop the forward decl.

> diff --git a/fs/fs.c b/fs/fs.c
> @@ -112,15 +130,26 @@ static int fs_ls_generic(const char *dirname)
>       while ((dent = fs_readdir(dirs))) {
>               if (dent->type == FS_DT_DIR) {
> -                     printf("            %s/\n", dent->name);
> +                     printf("          ");
>                       ndirs++;
>               } else if (dent->type == FS_DT_LNK) {
> -                     printf("    <SYM>   %s\n", dent->name);
> +                     printf("    <SYM> ");
>                       nfiles++;
>               } else {
> -                     printf(" %8lld   %s\n", dent->size, dent->name);
> +                     printf(" %8lld ", dent->size);
>                       nfiles++;
>               }

This silently narrows the gap between size and name from three spaces
to one for every filesystem, not only the ones opting into FS_CAP_DATE

That is why patch 9 has to fix up the erofs test, but ubifs, sandbox
etc. get the same churn for no functional gain. How about keeping the
original layout when has_date is false?

> diff --git a/fs/fs.c b/fs/fs.c
> @@ -112,15 +130,26 @@ static int fs_ls_generic(const char *dirname)
> +             if (has_date)
> +                     printf("%04d-%02d-%02d %02d:%02d ",
> +                            dent->change_time.tm_year,
> +                            dent->change_time.tm_mon,
> +                            dent->change_time.tm_mday,
> +                            dent->change_time.tm_hour,
> +                            dent->change_time.tm_min);

If the date was never set, this presumably prints '0000-00-00 00:00
filename', which is more misleading than no date at all. It is is
unset it would be better to show nothing.

Regards,
Simon
