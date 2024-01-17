Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE392C47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 11:52:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB4CA87707;
	Wed, 17 Jan 2024 12:52:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zSaGT6jb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAF9A87971; Wed, 17 Jan 2024 12:52:14 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D164876D3
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 12:52:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50e7f58c5fbso14799883e87.1
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 03:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705492331; x=1706097131; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jGYgJMgYMh0Aor2pW2OI2Wj9gZ7fBUYPvETgX3fS+ko=;
 b=zSaGT6jb1CdhVuTODyneiyQ+qAYhLbl85N5EOOD4shAbRVOrsEniC5XWgjyrxQzKTu
 Bxcen/i4sBHqiawHPUTNSijOQ6pbYQspmfosZ/gSekXonjbbxMBo1M4ZSV16J4xpXj8o
 oMsE+Thj0Vj7ax98u8y69CSQmDz0/sd0rThrXe3U9oHZKAKAxbkE7D6ULZ0TIONr4Szb
 A0S8uLoTjP0K5fhcKpSZDWV4jrV0VD7eNVhFsH4DTTlzObh1LtLn8Qzkm+d/0/ulX4p1
 FgG8cOm2aGYe1d+CEVzb4ED0w59ZN6gq3Fwm97spFtyjnnQKGIipGCz+3yD+YeXlWhI4
 vXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705492331; x=1706097131;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jGYgJMgYMh0Aor2pW2OI2Wj9gZ7fBUYPvETgX3fS+ko=;
 b=gTkKXnqCYFfanN6ZfuWGWwPNNRJXHcdGOODU2yb2YFEckNde7eXlY871ks11uVw3gS
 It2zSzbWcVK7Mc+ovaIfD5aaukBwhxZS1FYQvCse0kEdwTaOf1RV9F0kDhTIsz9+QzfI
 mL8ZBG9g4/lOeVN105yj1+mKg/HDoyhAhle6LMl73X2LuEpX5dO6pwLibUB0VmJEGhNQ
 5+eEyENsiw07QJEw6V16APPkfNhQ0LsYt6s8zZuprwInFP52gquLiT6k2OS/UggoIzcZ
 0eLJPBYw7V3MOzK7CpcSLWhANnx63h17x6O1HNuwP/pWMz9rfEMI/cpmvCxmGq9WSlas
 ao6w==
X-Gm-Message-State: AOJu0Yzgr8ANmKgdVCQCCWn2bmjXk4wVY+ekVG1qsO6nX1D4jBC9/PYJ
 gGhc1FuOfiH+4U1FkkNOPgePaTx18dsGnt9tEv71kD/VIRXByg==
X-Google-Smtp-Source: AGHT+IFn7LMndfSy/U/UbPFwsRwbEr+3zrve7jYQwriDNMyhBugWYhQixB3gR52MTdH7Bka5PEwUJrF1KzWxkWYy/4o=
X-Received: by 2002:a05:6512:3a94:b0:50e:55d0:855c with SMTP id
 q20-20020a0565123a9400b0050e55d0855cmr5158003lfu.17.1705492331525; Wed, 17
 Jan 2024 03:52:11 -0800 (PST)
MIME-Version: 1.0
References: <20240117094432.1049168-1-masahisa.kojima@linaro.org>
 <20240117094432.1049168-2-masahisa.kojima@linaro.org>
In-Reply-To: <20240117094432.1049168-2-masahisa.kojima@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 17 Jan 2024 13:51:35 +0200
Message-ID: <CAC_iWjLWhaLtoooiqvM9AjMqp1rdtmAS3oPO+am5KV72OdGYfw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] efi_loader: avoid pointer access after calling
 efi_delete_handle
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>
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

Hi Kojima-san

On Wed, 17 Jan 2024 at 11:46, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> efi_delete_handle() calls efi_purge_handle(), then it finally
> frees the EFI handle.
> Both diskobj and handle variables in efi_disk_remove() have
> the same pointer, we can not access diskobj->dp after calling
> efi_delete_handle().
>
> This commit saves the struct efi_device_path pointer before
> calling efi_delete_handle(). This commit also fixes the
> missing free for volume member in struct efi_disk_obj.
>
> This commit also removes the container_of() calls, and
> adds the TODO comment of missing efi_close_protocol() call
> for the parent EFI_BLOCK_IO_PROTOCOL.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>  lib/efi_loader/efi_disk.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> index 013842f077..ce46c1092a 100644
> --- a/lib/efi_loader/efi_disk.c
> +++ b/lib/efi_loader/efi_disk.c
> @@ -707,35 +707,46 @@ int efi_disk_remove(void *ctx, struct event *event)
>         struct udevice *dev = event->data.dm.dev;
>         efi_handle_t handle;
>         struct blk_desc *desc;
> +       struct efi_device_path *dp = NULL;
>         struct efi_disk_obj *diskobj = NULL;
> +       struct efi_simple_file_system_protocol *volume = NULL;
>         efi_status_t ret;
>
>         if (dev_tag_get_ptr(dev, DM_TAG_EFI, (void **)&handle))
>                 return 0;
>
> +       if (!handle)
> +               return 0;
> +

Is there a chance dev_tag_get_ptr() will return a NULL handle?

>         id = device_get_uclass_id(dev);
>         switch (id) {
>         case UCLASS_BLK:
>                 desc = dev_get_uclass_plat(dev);
>                 if (desc && desc->uclass_id != UCLASS_EFI_LOADER)
> -                       diskobj = container_of(handle, struct efi_disk_obj,
> -                                              header);
> +                       diskobj = (struct efi_disk_obj *)handle;
>                 break;
>         case UCLASS_PARTITION:
> -               diskobj = container_of(handle, struct efi_disk_obj, header);
> +               diskobj = (struct efi_disk_obj *)handle;
> +
> +               /* TODO: closing the parent EFI_BLOCK_IO_PROTOCOL is missing. */
> +
>                 break;
>         default:
>                 return 0;
>         }
>
> +       if (diskobj) {
> +               dp = diskobj->dp;
> +               volume = diskobj->volume;
> +       }
> +
>         ret = efi_delete_handle(handle);

Hmm, in which context are the dp and volume pointers allocated? The
handle is now freed, can we reliably access dp and volume ptrs?

>         /* Do not delete DM device if there are still EFI drivers attached. */
>         if (ret != EFI_SUCCESS)
>                 return -1;
>
> -       if (diskobj)
> -               efi_free_pool(diskobj->dp);
> -
> +       efi_free_pool(dp);
> +       free(volume);
>         dev_tag_del(dev, DM_TAG_EFI);
>
>         return 0;
> --
> 2.34.1
>

Thanks
/Ilias
