Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE074CA0FED
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 05:35:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0634383807;
	Fri,  5 Sep 2025 07:35:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ek4TXl2Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E4C6831A4; Fri,  5 Sep 2025 07:35:22 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62AAD831A4
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 07:35:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-72267c05050so17317957b3.3
 for <u-boot@lists.denx.de>; Thu, 04 Sep 2025 22:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757050518; x=1757655318; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Bw+gvpj9H6VQ/M7pZ56PsXSGk5lRr8HZ9SFu8I9dbhw=;
 b=Ek4TXl2QjMGZX8Bdxp2K5ezalogVgK9kaPwXIY8KRRYNvyXFR6brKmCSPtqmsJ27XX
 I8icaOFNxn1powEmQaNaW4Sjk431KXF7A4hdrxmXmAvxidTtHMk+2XmUf3UpKjrGAWcl
 UzrdkcTIVwf4FhR92/Bo2S3x8S9Wq1Z5dyoHSNzSRpFXMo4dpf/DbUtXKAyTj3nJOULA
 bYgpLNhi/msbyatArEwx+wG0SIHjtlR8WMgkzvuoH8Da+81quDqwwnvAtEK7T5smzuwx
 Z/VItPq065oSSbotUBFThjvERb+65V15geMnQuQXwU715K8MB4jYfMG67XO3tGoApV06
 aTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757050518; x=1757655318;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bw+gvpj9H6VQ/M7pZ56PsXSGk5lRr8HZ9SFu8I9dbhw=;
 b=NohzGEQiVZx14ImSgKSGsdeUjmw76IK8HdkrR+bVsgLP18cr9ZErBL9+Qaay6BG7gX
 LspUcb3g12Rjui/iWlvB+dnr10YdUsAdm1ZA6IAFx8a9aSKYRkstJcajfJ+lBiR680qt
 1xQZyrBzb6F4S2LpZC/KRRasSZztpQseqYn/gSXGxJrO8FO5wwka/4BQByMsliULLiIa
 B9iAjS7IoXvLt3/JyvSGDnl8hcnmJ7BlY4q+x9OwdVFMr0G6109blBCoch6fwHGUZY9I
 kGMpvoz+HZPfeAoDICGzQwYJCtOYCEGrjpBmpCazL8xPLzOntjlVmRKoHpuHqnUETzkg
 3kDQ==
X-Gm-Message-State: AOJu0YwvRIrqlWRRewRuxDLcljsbUcwS0q6xEvd/ONSlNFMRMHI55aHE
 hV/2nyydCl6c36ySqdtWCVt5qvRQFGEcVwkfu00vMRFQDu0h/FKu+5rXq3uM/czb4mb5gb+tAEE
 YqTkLe5+e0QVkYgsGNxK/WEMKFS2wNE/uO/UW8n+nkJZaBBlwfXvb+v2sTmgGqQs=
X-Gm-Gg: ASbGncsUigR7yiWPlrRBHMeTB2d4CGVq5yvMhXshAfERN1J/MOlLitwrsaPSW3lb96x
 f7LFoeeYg1fn+yw7fbUnroAC9cOvRtufZoHVNCrb9qS6MpCC239Sn1J6//hiDk+MfQTVO3wta8k
 4JDfEoaVtz2N9IeiOYJpwoaqlUEd1GZrcsz6fx+uK9ODwaV1reMx17W/BX7XttrlnORU/y0Eocw
 rV2c9KCmEQiEgmlOHcgwnUrKgHb0U5Np22sr28Jigh1R5GauEVA9I/4JJPbnWSfnMr4P/k7m7SZ
 Yw33HQmckDtuH4FEqZMLrAPTz0llwSQJd7EQTCDnwAEI+3BQOf4YeqLwPMs24WEDpEg2k9OQW/S
 W0qrZ2YNj
X-Google-Smtp-Source: AGHT+IEh5aVsmJCYSyu9n7Q5kF1x10Hn5vJWP46F/+/NBG0TwMNug6HVLwwwb6yG1O5l10NVOP87nPR5Ms7zTuUI9WU=
X-Received: by 2002:a05:690c:250a:b0:721:369e:44e1 with SMTP id
 00721157ae682-7227652b5b5mr196011997b3.40.1757050518068; Thu, 04 Sep 2025
 22:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250903214417.431985-1-javier.tia@linaro.org>
In-Reply-To: <20250903214417.431985-1-javier.tia@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 5 Sep 2025 08:34:42 +0300
X-Gm-Features: Ac12FXyjDXr5qRsRmOjoH0EluwrsuULexi6jmY2x3-2FC63vjb_kZKhJanEHUmA
Message-ID: <CAC_iWjLqgd5yiBbuvHTqSKUi9qX5Tmu8TLccPhUxGWV52b_Nwg@mail.gmail.com>
Subject: Re: [PATCH v4] disk: efi_loader: Improve disk image detection in
 efi_bootmgr
To: Javier Tia <javier.tia@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Javier

Generally speaking this looks ok now. A few nits below and I think we
can pull it

On Thu, 4 Sept 2025 at 00:44, Javier Tia <javier.tia@linaro.org> wrote:
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
> ---

We usually add a changelog across patches here, to make the reviewers
life easier.

>  disk/part.c                  |  2 +-
>  include/part.h               | 18 ++++++++++
>  lib/efi_loader/efi_bootmgr.c | 64 +++++++++++++++++++++++++-----------
>  3 files changed, 63 insertions(+), 21 deletions(-)
>
> diff --git a/disk/part.c b/disk/part.c
> index 66e2b3a7219..f0c6866e210 100644
> --- a/disk/part.c
> +++ b/disk/part.c
> @@ -63,7 +63,7 @@ static struct part_driver *part_driver_get_type(int part_type)
>   * @dev_desc: Device descriptor
>   * Return: Driver found, or NULL if none
>   */

[...]


>  static efi_status_t prepare_loaded_image(u16 *label, ulong addr, ulong size,
>                                          struct efi_device_path **dp,
> @@ -355,15 +359,36 @@ static efi_status_t prepare_loaded_image(u16 *label, ulong addr, ulong size,
>         u64 pages;
>         efi_status_t ret;
>         struct udevice *ramdisk_blk;
> +       struct blk_desc *desc;
> +       struct part_driver *part_drv;
>
> +       /* Create the ramdisk block device internally */
>         ramdisk_blk = mount_image(label, addr, size);
> -       if (!ramdisk_blk)
> -               return EFI_LOAD_ERROR;
> +       if (!ramdisk_blk) {
> +               log_err("Failed to create ramdisk block device\n");
> +               return EFI_DEVICE_ERROR;
> +       }
> +
> +       /* Get the block descriptor and detect partitions */
> +       desc = dev_get_uclass_plat(ramdisk_blk);
> +       if (!desc) {
> +               log_err("Failed to get block descriptor\n");
> +               ret = EFI_DEVICE_ERROR;
> +               goto err_cleanup_blkdev;

Don't rename 'err' to 'err_cleanup_blkdev'. Keep the patches simnple
and change one thing at a time.
The only thing this change does is make the review harder.

> +       }
> +
> +       /* Use part_driver_lookup_type for comprehensive partition detection */
> +       part_drv = part_driver_lookup_type(desc);
> +       if (!part_drv) {
> +               log_err("Image is not a valid disk image\n");
> +               ret = EFI_INVALID_PARAMETER;
> +               goto err_cleanup_blkdev;
> +       }
>
>         ret = fill_default_file_path(ramdisk_blk, dp);
>         if (ret != EFI_SUCCESS) {
>                 log_info("Cannot boot from downloaded image\n");
> -               goto err;
> +               goto err_cleanup_blkdev;
>         }
>
>         /*
> @@ -379,17 +404,17 @@ static efi_status_t prepare_loaded_image(u16 *label, ulong addr, ulong size,
>                                     false, true);
>         if (ret != EFI_SUCCESS) {
>                 log_err("Failed to reserve memory\n");
> -               goto err;
> +               goto err_cleanup_blkdev;
>         }
>
>         *blk = ramdisk_blk;
>
>         return EFI_SUCCESS;
>
> -err:
> +err_cleanup_blkdev:
> +       /* Clean up the created block device on error */
>         if (blkmap_destroy(ramdisk_blk->parent))
> -               log_err("Destroying blkmap failed\n");
> -
> +               log_err("Destroying blkmap failed during cleanup\n");

Same here. If you want to change these send them on a different patch.
r.g one that renames the error tag and changes some error messages

>         return ret;
>  }
>
> @@ -407,7 +432,7 @@ static efi_status_t efi_bootmgr_release_uridp(struct uridp_context *ctx)
>         if (!ctx)
>                 return ret;
>
> -       /* cleanup for iso or img image */

[...]

>
> +       /* First, try to treat the image as a disk image */
> +       ret = prepare_loaded_image(lo_label, image_addr, image_size,
> +                                  &loaded_dp, &blk);
> +       if (ret == EFI_SUCCESS) {
> +               /* Image is a disk image, set up for disk boot */
>                 source_buffer = NULL;
>                 source_size = 0;
>         } else if (efi_check_pe((void *)image_addr, image_size, NULL) == EFI_SUCCESS) {
> +               /* Image is a PE-COFF executable */

We don't need the comment, it's obvious from the else if check

>                 /*
>                  * loaded_dp must exist until efi application returns,
>                  * will be freed in return_to_efibootmgr event callback.
> @@ -545,7 +568,8 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
>                 source_buffer = (void *)image_addr;
>                 source_size = image_size;
>         } else {
> -               log_err("Error: file type is not supported\n");
> +               /* Neither disk image nor PE-COFF */
> +               log_err("Error: downloaded image is not supported\n");

Same here. Don't change ther error message in this patch.

>                 ret = EFI_UNSUPPORTED;
>                 goto err;
>         }
> --
> 2.51.0
>

I suggest just resending a single patch removing the changes on prints
and error tags.
If we think the messages need to change after that you can do it on a follow up

Cheers
/Ilias
