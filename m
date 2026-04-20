Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FCBEA719F
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 04:07:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A747D80433;
	Mon, 20 Apr 2026 06:07:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YGfUij27";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FF6E80433; Mon, 20 Apr 2026 06:07:20 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57893842B7
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 06:07:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ba61a0a2d26so192934666b.2
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 21:07:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776658038; cv=none;
 d=google.com; s=arc-20240605;
 b=Y6a3QBmrLO5Z2W0NXMAE021su5rYRCwf56taANEW2JOH9n2J04dY5JzWmSS3jmg3Kl
 BV+OIxg2aghFPN54j8ZXAGvuQm5jMkYryDHcZhYlJNmhOaXLy3xSXdIRkngRH7R6cPd4
 XvLE2NaTlRdf5tNkQoz8WepxRXtxCMyljFNgc5PvyVQLo2+dRUmiszAFM2ykv0gLjKuP
 6TysWhhTTvLkLhjWNOmeMu6mnh9p6wPVGQAwC94HYVuP8Wp/5y7B6TAVqrvyusscANWb
 s3qYZNiSjQ2pVtEqPVuBhsheqk5Xi2hcRr8+RZ83qyzQdi7Vn9L2/CPUsEYanyMkDvfo
 8sdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4cNvyEEqka9r2pXqVpTQyvF520G1iLz8eLpi1EN1Rw4=;
 fh=dFCcCirmpEm4IniOCIHShPK6RefQ43DR32oEpS3whgs=;
 b=g3/su6tsK9lr9fDtz01+4/IjHFo196W0baBkOCY4VJC6DbC2zR/CMiyLapWjCx0opr
 81olf7ssSZkma8tgNMKnH+XRTo7aZX1leOscf2vGss5/TyXa+oTtl18LRPdAS268C0d/
 VGnvy8n6j28SeowANgW9zJWrY72a9Gmmnk0Uz3qoawFLRZuFl+H0S7B24eHRZnNcbNnr
 TYT3B9FX8r3mvRQO+IZ5baYY1byu8R4VtTrHlYsjJSJLA5jHHuh6j/GMW486Y3UmBjkH
 JAWQ1mFZ3sjNJ6p2LhYHNMxbLJXnBwX+3xlGw5XnJ1haXvZ75F004RH8T68qgru31XQ9
 GI1g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776658038; x=1777262838; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4cNvyEEqka9r2pXqVpTQyvF520G1iLz8eLpi1EN1Rw4=;
 b=YGfUij27GSYCzL/jaXMGvf0pbzf3x3n7CYmBzgv8wpP+pJYAtil1eg3PrKxhuWCsHS
 4BahJ7yC9/0LCVtKMk8XTwolnwQPzMP1r7jSTBNFz05sFgqIB0A9kIRbmzQkd1invYXm
 m19Wh3nCmn61i8m3dSGqMGjU5hj9OX9w/oGlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776658038; x=1777262838;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4cNvyEEqka9r2pXqVpTQyvF520G1iLz8eLpi1EN1Rw4=;
 b=ns/2y4AtNIZkXZ3RCyMzm1cN5qDSsqZKUgtHMAN/oEa9I49d77BTkuSTCJ5/NpVKjl
 BdCP6688r/cVBomdnncmYxGCc6ayZtJqZEm0HltwWtCg9bTIPzKScZ6xiIcQ5bcGsH9q
 aSfqHqqqC0WPDCxFrAQ6oXP0GTsGEFyw01hiOxfitLI60qb4D+7Gnm6Np4d1BZ/i+yt5
 4DqZnrkMiR1qDECN3oNwCxBsiFDWuZgwHrNXhyq3Wvst3EfR59EMWJAIyG4rabEDI248
 TB+v2lulXBgOYhjJRgoiE7TxmB2EYm567lsPmATapdRRoXMF22jrI/i3z+Mz9HIrkH7P
 XygQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+KPg6MwU96HXS+QkLtFokGPwng0o7JH5RUjFu+VmWVSROW7wBL2NI19B3kRckj+DRiONgv4NI=@lists.denx.de
X-Gm-Message-State: AOJu0YxA1q2wJg9hs8JhgMIUxY1Z1Fi/KA3Ta+9P4x549oeGgd1z29F6
 4vKWSS5flTVWYRPeiWUOeb0voy9IxsoCQnTXBdII4xnsNYbga9Ilnpff1rtL2ngWanhUWemZ2/N
 6WOaMR5o20X37NQFrS25ZxsSscqz8YMKyG5hU16Gf
X-Gm-Gg: AeBDies/6GiWGSVrV03BQfCf+y+IewBOwF854OItllgJ2lS2id4K6LF7XGSEG/UcCIT
 fEL2QKvAkk6yYnajsx2wq0FdbQDK8QqmGD1CZjt+zbfDpTSeIlQkJThc56OgkKtBILf/6tbKAsx
 i6cnjI6oAy3u3RXJSNNb8JGHWn9TkIR9eyc77hsBezZqMifdvltEJUcHQHPL0Gio7DXLj5u6OGk
 OVSOorgtm6jGjUJXOlKUV1EEwRJhgwPUK1i+dDgwznLxkY1xFZZT0YzWNZOCRFIKPqZjC346Zrk
 TgRCc0E1s9xPxL/MJqdX
X-Received: by 2002:a17:907:9729:b0:b8f:b32e:e196 with SMTP id
 a640c23a62f3a-ba41a6339f0mr495218366b.30.1776658037621; Sun, 19 Apr 2026
 21:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260417120951.3454249-1-aswin.murugan@oss.qualcomm.com>
 <20260417120951.3454249-6-aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260417120951.3454249-6-aswin.murugan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 16:06:49 +1200
X-Gm-Features: AQROBzD83hkiiO4d8s-oqR9AXmZ9KjULuYTMNQJxlrcB-_m4D_8G0mh0Fwnw8PI
Message-ID: <CAFLszTjpyaqAASy8na9jBLLz_E=A59PBTSrq8KMvLu7ab8=8kA@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] mkimage: add fatfs image type for FAT partition
 images
To: aswin.murugan@oss.qualcomm.com
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, sughosh.ganu@arm.com, ilias.apalodimas@linaro.org, 
 gchan9527@gmail.com, mchitale@ventanamicro.com, maximmosk4@gmail.com, 
 jonas@kwiboo.se, marek.vasut@mailbox.org, quentin.schulz@cherry.de, 
 peng.fan@nxp.com, sajattack@postmarketos.org, 
 balaji.selvanathan@oss.qualcomm.com, wolfgang.wallner@at.abb.com, 
 e@freeshell.de, yangshiji66@outlook.com, jan.kiszka@siemens.com, 
 funderscore@postmarketos.org, hs@nabladev.com, kory.maincent@bootlin.com, 
 jj251510319013@gmail.com, carlos.lopezr4096@gmail.com, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
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

Hi Aswin,

On 2026-04-17T12:09:44, Aswin Murugan <aswin.murugan@oss.qualcomm.com> wrote:
> mkimage: add fatfs image type for FAT partition images
>
> Add a new mkimage image type 'fatfs' that creates a raw FAT
> filesystem partition image from a directory of files.
>
> The image handler (fatimage.c) uses mkfs.vfat (dosfstools)
> to format the image and mcopy (mtools) to populate it. The
> image size is calculated automatically from the input
> directory size plus FAT metadata overhead.
>
> New long options added to mkimage:
>   --fat-extra-space <KB>  extra padding (default: 512 KB)
>   --fat-type <0|12|16|32> FAT type (0 = auto-detect)
>   --fat-volume-id <label> volume label (default: BOOT)
>   --fat-mkfs-opts <opts>  extra mkfs.vfat options
>
> Usage:
>   mkimage -T fatfs -d <input-dir> \
>       --fat-extra-space 512 \
>       --fat-volume-id "MYBOOT" \
> [...]
>
> tools/Makefile   |   1 +
>  tools/fatimage.c | 495 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tools/fatimage.h |  25 +++
>  tools/mkimage.c  |  21 +++
>  tools/mkimage.h  |  15 ++
>  5 files changed, 557 insertions(+)

> diff --git a/tools/mkimage.c b/tools/mkimage.c
> @@ -204,6 +204,10 @@ static const struct option longopts[] = {
> +{ "fat-extra-space", required_argument, NULL, OPT_FAT_EXTRA },
> +     { "fat-type", required_argument, NULL, OPT_FAT_TYPE },

The first line is missing its leading tab.

> diff --git a/tools/fatimage.c b/tools/fatimage.c
> @@ -0,0 +1,495 @@
> +static int fatimage_set_header(void *ptr, struct stat *sbuf, int ifd,
> +                            struct image_tool_params *params)

The set_header callback in struct image_type_params returns void, not int

Assuming you don't want to update that (which you might?), please
change the return type to void and call exit() on unrecoverable
errors, like the other image handlers.

> diff --git a/tools/fatimage.c b/tools/fatimage.c
> @@ -0,0 +1,495 @@
> +static int fatimage_check_params(struct image_tool_params *params)
> +{
> +     if (!fatparams.input_dir) {
> +             fprintf(stderr, "Error: Input directory not specified\n");
> +             fprintf(stderr, "Use -d <directory> to specify input directory\n");
> +             return -1;
> +     }
> +
> +     struct stat st;
> +     if (stat(fatparams.input_dir, &st) < 0) {

Please move the decl to the start to the top of the function.

> diff --git a/tools/fatimage.c b/tools/fatimage.c
> @@ -0,0 +1,495 @@
> +void fatimage_set_dir(const char *dir)
> +{
> +     fatparams.input_dir = strdup(dir);
> +}
> +
> +void fatimage_set_extra_space(int space_kb)
> +{
> +     fatparams.extra_space = space_kb;
> +}
> +
> +void fatimage_set_fat_type(int type)
> +{
> +     fatparams.fat_type = type;
> +}
> +
> +void fatimage_set_volume_id(const char *volid)
> +{
> +     fatparams.volume_id = strdup(volid);
> +}
> +
> +void fatimage_set_mkfs_opts(const char *opts)
> +{
> +     fatparams.mkfs_opts = strdup(opts);
> +}

The strdup() calls in fatimage_set_dir(), fatimage_set_volume_id() and
fatimage_set_mkfs_opts() can return NULL, but the return value is not
checked. Please check for NULL and handle the error.

Regards,
Simon
