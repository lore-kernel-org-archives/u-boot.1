Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E6ECA1016
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 06:15:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0088982AE9;
	Mon,  8 Sep 2025 08:15:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TqLvvti7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54B0382B20; Mon,  8 Sep 2025 08:15:53 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75F7582A9E
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 08:15:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e97021a3695so3103588276.3
 for <u-boot@lists.denx.de>; Sun, 07 Sep 2025 23:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757312149; x=1757916949; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IzY5HE3AWnm3gHmxop6Ejs/rwHlWepQwEnkRLrURhJc=;
 b=TqLvvti7IM5/Kqi4iDym844XBzIYvnY9bo4l4QCH0gEkaIEWZUuT/u/47V85nwgTFY
 t18pz4V5jFBYUjJGrb1hr6ytHI7F1A+Szl+1nDOZo8cw//4VY04aEKBENMzRKzGIadxv
 S5Dgl7fLuTP9bSDsVDWkLSM2TsKjS3jZIW6vfJ1kZyviKoLN07tJomXrBESjVuMeUwVN
 plH+V4AayzHeHKP33fjrF5bMvFcaO0FGed8mfVWqBVV45iQ02bd03murJl4Rgg5SLeuD
 XPtkNa3hANDTEznIxGgFDe5/nP/BhXRM2/qfYQS6ydlemGLpXQDpKsHFbrauBMxbwn6r
 lZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757312149; x=1757916949;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IzY5HE3AWnm3gHmxop6Ejs/rwHlWepQwEnkRLrURhJc=;
 b=rRMQgF3AWpqLKPUX/ZjnTPaFD1Wl+C9HhpL2C6J4nVCJDTFhR5Dj/hhQW5agpFRcd/
 1GUDWDKW1a6Oo9tTmSjcGLDlByeXurdsvCe9FeS1MRSbuuE65ukAFic8v4HNriPtjalX
 I/f0KTJx/iuRD7zY2p2oDIf/CgFgNnbwMuQ4FLZD732AK1RyHhzqPB4gilpEDEl1BNZU
 ZV1s6BlUujcKsUz2CRHoc3EVkxRno++aud+XpiUgk5aKYzflCfJvcGsUo7/AJj/2WXk2
 /5+/BfjR1xEWj5L/x4KB73hh94IPlPPT1vhpXxH+au+u+DO8j8OCNUsiu7EVHgZZ1pfZ
 rtTA==
X-Gm-Message-State: AOJu0Yy35sH95kgrd4GD1pFIAB9Bu4Eeu9/X9g8pc+ocDz9ZBpfkZG7b
 dvFBxxoThOOItT8ucZlsg99DPGbMxGQwL9/C9HR8gWGAT16tH88qcJKGMs2KG1QGryBP3U4L0CK
 xW3o1GIFhdPnj/yAJpHuXkX++QvKb+gWS1CB9zmAcFw==
X-Gm-Gg: ASbGncv3rG7p2iXqPbC7aO/3UVb6K4BxO0CPw6Uj796pobZ/x43MRBNcc6Jtrz1ROUW
 LaTLJgTD7SgPO3u2sK97XmrsdMEuiCxJiwZPCjDdIZ8yzslX+LRMZmwrlgUiATTicpSQ2vLtEDI
 fADn7ctqJGmT0663y4c0a68QENH7M2R98T/FMkcaylmQ+JHA5MPoI8aaUvLi0y/hdJ3/NnJQ3aq
 bnffBH8Qe6avIjuiBRd/aRfm5zJRYGIlG9MjF0AlIgDrior0B0rARYtk8LGF3LdIf1j6g4j+SSr
 nyFVznrRs44lPoannm7sChJMmOEFc8/ZuJafNhdGjo57kjdBeohsbOZ73arep0Xa6howr0MvedG
 4v9LECAjO9wcyqGzk8ck=
X-Google-Smtp-Source: AGHT+IF/FuFUpg2iPMFtUPqEfkEh/cEkRzBFDi9bL9kbdGP5VPRvr+KZ4hogImb7lPKqUMqrzsF4YjmIv/V1XNS7bw4=
X-Received: by 2002:a05:690c:7108:b0:71e:715b:a988 with SMTP id
 00721157ae682-727f583dd24mr59106187b3.42.1757312149133; Sun, 07 Sep 2025
 23:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250905172330.135550-1-javier.tia@linaro.org>
In-Reply-To: <20250905172330.135550-1-javier.tia@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 8 Sep 2025 09:15:13 +0300
X-Gm-Features: Ac12FXyUhqbhUHL2Elh3dxqytmQtjIlVIittQ4-p0YXuHmBBCmLFBiawQY819pI
Message-ID: <CAC_iWjJt_99wqCvKRy89ynY0tL9TFGmyLDOshGeFHM95orDgrQ@mail.gmail.com>
Subject: Re: [PATCH v5] disk: efi_loader: Improve disk image detection in
 efi_bootmgr
To: Javier Tia <javier.tia@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Javier, Heinrich

On Fri, 5 Sept 2025 at 20:24, Javier Tia <javier.tia@linaro.org> wrote:
>
> Enhances the process for identifying disk images within the EFI boot
> manager. Utilize part_driver_lookup_type() to verify the validity of a
> downloaded file as a disk image, rather than depending on file
> extensions.
>
> part_driver_lookup_type() is now used in the prepare_loaded_image()
> function in the EFI boot manager to detect partitions on a block device
> created from a downloaded image. This allows the boot manager to boot
> from any disk image that can be recognized by a partition driver, not
> just ISO and IMG images.
>
> Update prepare_loaded_image() to create the ramdisk block device
> internally, obtain the blk_desc and use part_driver_lookup_type() to
> detect a valid partition table.
>
> In try_load_from_uri_path(), try prepare_loaded_image() first to detect
> disk images, and fall back to PE-COFF detection only if that fails.
>
> Include part.h in the EFI loader and export part_driver_lookup_type and
> add its prototype and documentation in include/part.h. This makes the
> partition-driver lookup available to other code paths that need to
> detect partition tables on a block descriptor.
>
> Signed-off-by: Javier Tia <javier.tia@linaro.org>

The patch looks ok now. Two more nits, but those can be taken care of
during mering
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

44

[...]


> +       /* Create the ramdisk block device internally */
>         ramdisk_blk = mount_image(label, addr, size);
> -       if (!ramdisk_blk)
> -               return EFI_LOAD_ERROR;
> +       if (!ramdisk_blk) {
> +               log_err("Failed to create ramdisk block device\n");
> +               return EFI_DEVICE_ERROR;

This message will show up as an error even if we load an EFI app.
Perhaps switch to log_warn()?

> +       }
> +
> +       /* Get the block descriptor and detect partitions */
> +       desc = dev_get_uclass_plat(ramdisk_blk);
> +       if (!desc) {
> +               log_err("Failed to get block descriptor\n");
> +               ret = EFI_DEVICE_ERROR;
> +               goto err;
> +       }
> +
> +       /* Use part_driver_lookup_type for comprehensive partition detection */
> +       part_drv = part_driver_lookup_type(desc);
> +       if (!part_drv) {
> +               log_err("Image is not a valid disk image\n");
> +               ret = EFI_INVALID_PARAMETER;
> +               goto err;
> +       }
>
>         ret = fill_default_file_path(ramdisk_blk, dp);
>         if (ret != EFI_SUCCESS) {
> @@ -389,7 +414,6 @@ static efi_status_t prepare_loaded_image(u16 *label, ulong addr, ulong size,
>  err:
>         if (blkmap_destroy(ramdisk_blk->parent))
>                 log_err("Destroying blkmap failed\n");
> -
>         return ret;
>  }
>
> @@ -407,7 +431,7 @@ static efi_status_t efi_bootmgr_release_uridp(struct uridp_context *ctx)
>         if (!ctx)
>                 return ret;
>
> -       /* cleanup for iso or img image */
> +       /* cleanup for disk image */
>         if (ctx->ramdisk_blk_dev) {
>                 ret = efi_add_memory_map(ctx->image_addr, ctx->image_size,
>                                          EFI_CONVENTIONAL_MEMORY);
> @@ -452,6 +476,7 @@ static void EFIAPI efi_bootmgr_http_return(struct efi_event *event,
>         EFI_EXIT(ret);
>  }
>
> +

You don't need a new line here.

[...]


Cheers
/Ilias
