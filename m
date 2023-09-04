Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0834C83F2C
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 16:51:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20227869C7;
	Mon,  4 Sep 2023 18:49:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GPwmV2zx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0F3B86960; Mon,  4 Sep 2023 18:49:52 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 829B38693D
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 18:49:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4ffa248263cso2562379e87.2
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 09:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693846185; x=1694450985; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nxU3u3mrkVwurYd3SnJbI6h0AL82jl5B4J/vi3th8F0=;
 b=GPwmV2zxWwc0Jp2Ywsdua2BgaBNhQmEw6V9/u+xCV7oOA2S5N56Aq4SNnvH1NniTE/
 5JPaKL3WsO8cmOICtVbaUm4PFkMrXW5dBIQON1F8CbNnTyJjv/jX8uX99nlQmWEGETtN
 +jjJ9bcpfOLdLfG9GAHJ9An7jLNmSMlEtO0dU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693846185; x=1694450985;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nxU3u3mrkVwurYd3SnJbI6h0AL82jl5B4J/vi3th8F0=;
 b=J2NytL/haghGNQGgyWt4EZuXd85EbJJZfz0HZHf3qUjwQ7FhMpb8EWnusVNUtho49R
 1Z7OLyCIKLL5tQ67z9SCye/UBBghireYghZdHnasR2Sk+3HX2QcxjeS2a5M7nsSp02xZ
 gettAp9qDw6J/X8EwTC20DvYLbb1sqiOjgnb9xCJFqMe4HgmYBsUSxS5mHj6BL9+6wie
 Si9Dl0E/JSaG2LftghA0z/pHK5Bv/04iO2Xs28wqdNnQRSjQBzJWYPK/Wt7jHmIsGHXL
 AzHJJ/AzUvAyfC8i8bYsveN7E5rZrIOnkz6v54ZSvLUu5ciToZY5Dd2BYFGMMsUU/gVi
 adEw==
X-Gm-Message-State: AOJu0Yz16irVvBvXEDz3YjBb6I168QonP7OMjlEvo4LkxhbixYAgSr1z
 p4epwoxVCUzUaYNfKu0vMAdYMiJpl66Ye6RInPa6Tg==
X-Google-Smtp-Source: AGHT+IGKQrj9E/GXZeq4yFu3KtxdW4O5pBLlEPcLgu7uBr0VSr8mIx3CU+ae27NR0sTty3MD9HZvwPHwgkiQWON2h7k=
X-Received: by 2002:a19:674e:0:b0:500:8257:4b34 with SMTP id
 e14-20020a19674e000000b0050082574b34mr5757830lfj.68.1693846184556; Mon, 04
 Sep 2023 09:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230902073524.87451-1-heinrich.schuchardt@canonical.com>
 <20230902073524.87451-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20230902073524.87451-2-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 Sep 2023 10:48:51 -0600
Message-ID: <CAPnjgZ0UYquSyqyCoAYVG3UmiB-K07oyUsE6pXds_E1BiGf9NA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] part: rename disk_partition_type_uuid()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Joshua Watt <jpewhacker@gmail.com>,
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

Hi Heinrich,

On Sat, 2 Sept 2023 at 01:34, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Rename disk_partition_type_uuid to disk_partition_type_guid.
>
> Provide function descriptions for the getter and setter.
>
> Fixes: bcd645428c34 ("part: Add accessors for struct disk_partition type_uuid")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         new patch
> ---
>  disk/part_efi.c |  2 +-
>  include/part.h  | 26 +++++++++++++++++++++++---
>  2 files changed, 24 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

But this doesn't look like a rename


>
> diff --git a/disk/part_efi.c b/disk/part_efi.c
> index 39382c5fae..b7aef3731b 100644
> --- a/disk/part_efi.c
> +++ b/disk/part_efi.c
> @@ -299,7 +299,7 @@ int part_get_info_efi(struct blk_desc *desc, int part,
>         }
>         if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID)) {
>                 uuid_bin_to_str(gpt_pte[part - 1].partition_type_guid.b,
> -                               (char *)disk_partition_type_uuid(info),
> +                               (char *)disk_partition_type_guid(info),
>                                 UUID_STR_FORMAT_GUID);
>         }
>
> diff --git a/include/part.h b/include/part.h
> index f321479a5e..db34bc6bb7 100644
> --- a/include/part.h
> +++ b/include/part.h
> @@ -108,18 +108,38 @@ static inline void disk_partition_clr_uuid(struct disk_partition *info)
>  }
>
>  /* Accessors for struct disk_partition field ->type_guid */
> -extern char *__invalid_use_of_disk_partition_type_uuid;
> +extern char *__invalid_use_of_disk_partition_type_guid;
>
> +/**
> + * disk_partition_type_guid() - get partition type GUID
> + *
> + * By using this function to get the partition type GUID we can use
> + * 'if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID))' instead of
> + * '#ifdef CONFIG_PARTITION_TYPE_GUID'.
> + *
> + * @info:      partition information
> + * Return:     partition type GUID
> + */
>  static inline const
> -char *disk_partition_type_uuid(const struct disk_partition *info)
> +char *disk_partition_type_guid(const struct disk_partition *info)
>  {
>  #ifdef CONFIG_PARTITION_TYPE_GUID
>         return info->type_guid;
>  #else
> -       return __invalid_use_of_disk_partition_type_uuid;
> +       return __invalid_use_of_disk_partition_type_guid;
>  #endif
>  }
>
> +/**
> + * disk_partition_set_type_guid() - set partition type GUID
> + *
> + * By using this function to set the partition type GUID we can use
> + * 'if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID))' instead of
> + * '#ifdef CONFIG_PARTITION_TYPE_GUID'.
> + *
> + * @info:      partition information
> + * @val:       partition type GUID as string
> + */
>  static inline void disk_partition_set_type_guid(struct disk_partition *info,
>                                                 const char *val)
>  {
> --
> 2.40.1
>
