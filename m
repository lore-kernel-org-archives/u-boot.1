Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF31C5DF87
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 12:31:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 12D074061B;
	Thu, 20 Aug 2026 12:31:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0buRVXX2CtAq; Thu, 20 Aug 2026 12:31:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787229098;
	bh=mnRtRsALa5cYqoktUWgxqw05jYkNozVc9TnEqDfOZWE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GBoL7x4fLVqcoAjQDywUHiyLYS/jvxboEuHu6xdwH9BCDrteJdtYzNCf2UIpFUYwp
	 bpSvKNvop1bxccW3pX3vG5R/IGg8Y98jsAE2oHGgir2LkJYPl5QRHnANDO0AN4YLaz
	 jXNnGGQdFleEqojPGZ/CZIf1M+wKCbJcFWkWq5u0RXEVPjsvFAz5ixp3tavGD6hVZc
	 9myF9Bv8CxMp5Tl31ajIuARGdtceAujUkgX+FhNGCyYkBhbPi9lXuuiqWqA2gAbHwF
	 +DCFePBBd+HPQMV7ADeCxZSPiTlx3d5JGMyo7qcGAuLOJ4To4oAy7p/rnkWNR48pT3
	 d1lNMNBkNDMjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 029BC405F6;
	Thu, 20 Aug 2026 12:31:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5A41B323
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:31:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 48B1140275
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:31:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D5xedAfy11Nm for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 12:31:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=KURnKjji
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 585A340292
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:31:34 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2cca0c5799eso18156285ad.0
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 05:31:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787229093; cv=none;
 d=google.com; s=arc-20260327;
 b=IkcJYS1QIIkt2aD60WxiuzDON4HBCQ30LxbxUd2IHAerqSJtbc0czvya5VuujuRhaK
 MHKrVrod+CWKrQTT5jZcDf1ypd8IEdJWmx8ITanAwgmPvwLyclIaWhSUJIpVV1ZWJFUY
 1amVV2mXxk+TYUQFwtjGXi7N7kN9CWKArE+HvyruQWcXCd9h9zti4uHDJ8hKXiERkDV8
 dDpgx3HrtmodZQ9KljzWjIIR0pEqwjqXnZi5xWPNN6wB6BJEaW+OGj78oB37rvWm0yiy
 wdQzny3zsSlL1ixVbgW1FNg26iCaJM2hKrhFm/DrHv/kb8U4hOWfYHbeQg3PHN5nzI+F
 pj3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mnRtRsALa5cYqoktUWgxqw05jYkNozVc9TnEqDfOZWE=;
 fh=dt7UrUXnn871sXXPbwCgP8Qcn2KjxTAP32yeWYOSxNo=;
 b=osDNdN4BPkab2x2G+E6R9stXCVrcwj+HPpDcvYwwpSTPo4qIT/31v5tJXxhaSu8peJ
 kQfF2mjriZK3yS99pG+OwzW71EwSWyNSBqikzRwz2UPIawNI0m/hxg9zqr1LYQ6LCe+B
 C5SxI04nGAdF4lsHtGJtuAZ2jyBQKHo859e5YCcx8DgIWVLT70YJnyJSSROqNAhVRU0H
 SHwPauaMpPa9+LNFr4MR7kDW6q1l2RYwKtXnOGm2H6XBauT5b+BoqlsJx+vgAyg0zRZv
 6+tv4d0y2ZqCWxhCfUB75y7MJ5eFfoWbAGsDvA7ElR4DMW7OkMwfSvhrAyGF90JLlTkb
 JEgA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1787229093; x=1787833893;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mnRtRsALa5cYqoktUWgxqw05jYkNozVc9TnEqDfOZWE=;
 b=KURnKjjijUQ4KiP+ZByOmaUTzDOBtzgymxVLyAOenwOj+CXivX8zK7htO0XItPxEb6
 2t0mFID5QzkgV7yTxAugbkKBz27BdCEYJzAgciwT7HDin7AlxVxB27sPVYvTYjiZ/SUi
 a0MtK8cXO9hBLYoVOJ59ZFd4IiEI+CDbreAq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787229093; x=1787833893;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mnRtRsALa5cYqoktUWgxqw05jYkNozVc9TnEqDfOZWE=;
 b=KCsCB2ltfUqalOISf98vCqFottGv32RAehj2uKoi1fnhfzLlfJzzT3Y/HnSODBr8PV
 PLyX34u7b0ZdMvhCcYx2DLDhCzkcuT3qUYDcWBNL0MtHTBs18unFYMtg9sQssELAP3bV
 HRLMRa/9RqU87jIdca0xc9U5B3rkUA/yKrnGbbF0+YIIGCYaUKQp+QFB+nyDcqfVi/YJ
 2dZnE+EBo8H4R65TUxEUKytUPS+no7duaA5OMfYTmNAnjsY7Ekk25ZzCi0ot13sOfDGB
 IJj0gG1rmEZ7Z55SHQ1KIizPmy2fM5wC3gfrs8NNR8mX9UV3kGPKL0jfMjWfy3gvEI9L
 48fg==
X-Gm-Message-State: AFuF++mqr6Ry3dNCB4yfWdOPNQlKH+Nl7tU4zCBvUaONP4tXztglPI7h
 2YxsQbRkpEpM70raS2kC2/IiZdJcW5X/VvwAuLkoLg9xBRjJtxG6Bh/CY7sXbaoDXJgnhXPCsaN
 JKD/uQokQJ9pReqUhfbLwWib4wFNzgqt53YD/d/LLCLNjq5N+hH0=
X-Gm-Gg: AR+sD10i6PA3Hy4p1F1waonEeAXAgV1pnX/URCMZnxUVm1qwG1qw8yLBgWMt86eVVpG
 SJQk19TvXX3dfA6hjNOwtq562CH7teHhaBA+yRbp1FVKZm2BliX2NOmYVodlhPblm3WsFO2U4A/
 y2R0YDlOwXTTfDdNsHoryXar/IygWpKbHGIuEDraTgPlGfjs4fEhwn3QRDn9BERg4m9vaCM4AIq
 x94A88n9fK9nQYXuQeY/54YHGl4aN2hdeHFr6fVTtW+XaqPwGb/S01C/I050ABzL6ubw1rOhbWo
 mGNeKhzzqOzEJ69HUshmZk3Vz+rChvyD6E0NHFWOI8E=
X-Received: by 2002:a17:902:d4c6:b0:2c9:c517:d070 with SMTP id
 d9443c01a7336-2d5fd5b0008mr209106815ad.3.1787229093476; Thu, 20 Aug 2026
 05:31:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260818175301.818739-1-valentinliu@icloud.com>
In-Reply-To: <20260818175301.818739-1-valentinliu@icloud.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Aug 2026 06:31:18 -0600
X-Gm-Features: AcwNN1Vdicn45QQzey78yK_xxZS44LvYXq84Howd3979g9V9qyq3rWoXgyNueBY
Message-ID: <CAFLszTj8g4xxzt9A7txOhDMU6hLe2=twZoZPo_sr7Z5m=6BC4A@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] boot: android: Add Android 13+ bootflow support to
 bootmeth.
To: valentinliu@icloud.com
Cc: u-boot@lists.u-boot-project.org, mkorpershoek@kernel.org, sjg@chromium.org,
 trini@konsulko.com, igor.opaniuk@gmail.com, alchark@flipper.net, 
 quentin.schulz@cherry.de, marek.vasut+renesas@mailbox.org, 
 daniel@makrotopia.org, rs@ti.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Valentin,

On 2026-08-18T17:53:00, Valentin Liu <valentinliu@icloud.com> wrote:
> boot: android: Add Android 13+ bootflow support to bootmeth.

Please drop the trailing period and keep the subject under 60 characters.

>
> The devices launching Android 13+ were using a new partition
> named init_boot to store generic ramdisk.

>
> In the new bootflow, kernel still be stored in boot image,
> however, the First Stage files in ramdisk were moved to
> init_boot image. We should load it to memory and verify it
> so that the kernel can execute init program to continue booting.
>
> Currently, we have supported loading the init_boot image by
> abootimg command, but we still need bring this ability to
> bootmeth, so that booting Android 13+ will be more easily.

Please use present/imperative tense throughout: 'were using' -> 'use',
'kernel still be stored' -> 'the kernel is still stored', 'were moved'
-> 'are moved', 'we still need bring' -> 'we still need to bring',
'more easily' -> 'easier'.

>
> In the new bootflow, kernel still be stored in boot image,
> however, the First Stage files in ramdisk were moved to
> init_boot image. We should load it to memory and verify it
> so that the kernel can execute init program to continue booting.
>
> Currently, we have supported loading the init_boot image by
> abootimg command, but we still need bring this ability to
> bootmeth, so that booting Android 13+ will be more easily.
> Bootmeth will be able to recognize the new partition layout,
> and boot Android normally.
>
> Link: https://source.android.com/docs/core/architecture/partitions/generic-boot
> Signed-off-by: Valentin Liu <valentinliu@icloud.com>
>
> boot/bootmeth_android.c          | 67 ++++++++++++++++++++++++++++++++++++++++
>  boot/image-android.c             | 16 ++++++++++
>  cmd/abootimg.c                   |  5 +++
>  doc/develop/bootstd/overview.rst |  3 ++
>  include/android_image.h          |  1 +
>  include/image.h                  | 35 +++++++++++++++++++++
>  6 files changed, 127 insertions(+)

Please can you look at how to add a test for this addition?

> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
> @@ -113,6 +115,51 @@ static int scan_boot_part(struct udevice *blk, struct android_priv *priv)
> +static int scan_init_boot_part(struct udevice *blk, struct android_priv *priv)
> +{
> +     struct blk_desc *desc = dev_get_uclass_plat(blk);
> +     struct disk_partition partition;
> +     char partname[PART_NAME_LEN];
> +     ulong num_blks, bufsz;
> +     char *buf;
> +     int ret;
> +
> +     if (priv->slot)
> +             sprintf(partname, INIT_BOOT_PART_NAME "_%s", priv->slot);
> +     else
> +             sprintf(partname, INIT_BOOT_PART_NAME);

This is a near-duplicate of scan_boot_part() and
scan_vendor_boot_part(). Please factor the common logic (build
partname, read the header block, check magic, extract size) into a
helper rather than adding a third copy.

> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
> @@ -291,6 +338,17 @@ static int android_read_bootflow(struct udevice *dev, struct bootflow *bflow)
> +     if (priv->header_version >= 4) {
> +             ret = scan_init_boot_part(bflow->blk, priv);
> +             if (ret < 0) {
> +                     /*
> +                      * Android 12 devices do not have the init_boot partition.
> +                      * Some devices upgraded to Android 13 or later from
> +                      * earlier Android versions may also not have one.
> +                      */
> +                     log_debug("scan init_boot failed: err=%d\n", ret);
> +             }
> +     }

priv is allocated with plain malloc() above, so it is not zeroed. On
failure here priv->init_boot_img_size is left uninitialised, then
boot_android_normal() and (in patch 2) run_avb_verification() read it
back as 'priv->init_boot_img_size > 0'. Please use calloc()/memset(),
or explicitly set priv->init_boot_img_size = 0 before the call and on
the failure path.

> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
> @@ -556,6 +614,7 @@ static int boot_android_normal(struct bootflow *bflow)
>       ulong loadaddr = env_get_hex("loadaddr", 0);
> +     ulong iloadaddr = env_get_hex("init_boot_comp_addr_r", 0);
>       ulong vloadaddr = env_get_hex("vendor_boot_comp_addr_r", 0);

If init_boot_comp_addr_r is unset, env_get_hex() returns 0 and you
silently load init_boot at address 0 and call
set_ainit_bootimg_addr(0). Please check that iloadaddr is non-zero and
error out with a clear message before using it - the vendor_boot path
has the same weakness, but let's not extend the pattern.

> diff --git a/boot/image-android.c b/boot/image-android.c
> @@ -326,6 +326,22 @@ bool android_image_get_data(const void *boot_hdr, const void *vendor_boot_hdr,
> +bool android_image_get_data_v4(const void *boot_hdr, const void *vendor_boot_hdr,
> +                            const void *init_boot_hdr, struct andr_image_data *data)
> +{
> +     if (!android_image_get_data(boot_hdr, vendor_boot_hdr, data))
> +             return false;
> +
> +     if (!is_android_boot_image_header(init_boot_hdr)) {
> +             printf("Incorrect init boot image header\n");
> +             return false;
> +     }
> +
> +     android_boot_image_v3_v4_parse_hdr(init_boot_hdr, data);
> +
> +     return true;
> +}

I can't find any caller of android_image_get_data_v4(). Please either
wire it up to whatever consumes init_boot_img_total_size, or drop it
(and the new struct field, and the header declaration) until it is
needed.

> diff --git a/include/image.h b/include/image.h
> @@ -2167,6 +2184,17 @@ bool android_image_print_dtb_contents(ulong hdr_addr);
> +/**
> + * is_android_init_boot_image_header() - Check the magic of init boot image
> + *
> + * This checks the header of Android init boot image and verifies the
> + * magic is "ANDROID!" (same with the boot image)
> + *
> + * @init_boot_img: Pointer to boot image
> + * Return: non-zero if the magic is correct, zero otherwise
> + */
> +bool is_android_init_boot_image_header(const void *init_boot_img);

Declared but never defined or called - scan_init_boot_part() uses
is_android_boot_image_header() directly, which is correct since the
magic is identical. Please drop the declaration.

> diff --git a/include/image.h b/include/image.h
> @@ -2199,6 +2227,13 @@ void set_abootimg_addr(ulong addr);
> +/**
> + * set_ainit_bootimg_addr() - Set Android init boot image address
> + *
> + * Return: no returned results
> + */
> +void set_ainit_bootimg_addr(ulong addr);

Missing @addr: description, and a void function does not need a
Return: line - please drop it.

> diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
> @@ -293,6 +293,9 @@ script_offset_f
> +init_boot_comp_addr_r
> +    Address to which to load the init_boot Android image, e.g. 0xd0000000

Since this env var is required for Android 13+ to boot, please also
document it in the relevant board README(s) / sample env, and handle
the missing case gracefully in the code (see comment on
boot_android_normal()).

Regards,
Simon
