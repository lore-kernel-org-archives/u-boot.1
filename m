Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BF4C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 08:55:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F32E482CBB;
	Wed, 18 Jun 2025 10:55:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JBxoe+rw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E3FE82CBC; Wed, 18 Jun 2025 10:55:19 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B3AA82C55
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 10:55:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-7111d02c777so56979287b3.3
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 01:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750236916; x=1750841716; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vnSicJ3kX25dIMf/Zfu4DnGDrSEH01cDLCXUj3EwG5k=;
 b=JBxoe+rwM5dp92Y9DY7TRuubj2ldAIbe1GfoV+dQ35uCunhAa0VVt3in5U3np1zmcS
 eMHIQB2aGJZ6Ep9wWLFIPSuwuE5pgREZsQT5+JQHoTBNdGWunEZpURojfjblSa6jyN99
 Q1+4U5mu7Mj4O5oyvrjLHpa+TOao19pLtp8epsALnbKfr00g1DffrhXKKGzY/6b1WJr4
 hzqgs1bBXfaibGLjYK7U+91fAJ8b/cm2amy9SjJ2QcoHL5yudf7dS1SnHNQz0l5MJtZr
 EDRTjeRH1UQkrIJYLg6ho/UM8Lm48oWgDpT/icGp1CABS09Fjej0SQCdHgQsKk1ZOK30
 w1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750236916; x=1750841716;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vnSicJ3kX25dIMf/Zfu4DnGDrSEH01cDLCXUj3EwG5k=;
 b=AFStJts5IrH/e224W3i9v8sdj/cWeWfuLQynuGpbzpFwiRFowef6RggDhhRHloBWpo
 hwNe17OFPFKNsTnJYtSvm2ffaqaweWsNDuQmwzRM4vimU1irlG3V+VvgSLEIT52PRxrq
 iSGWwUfFVkz4VqiQ0d4KxRFKpI63OnrI2i+mzJDtESq/jpgnMplUyP1fsCTCSJk9Zgr9
 oxOvGL4NhMEJ/RF8vp41qwv6ckLPV6vGQ8z4WezOwtmm9d5HnuA5CMfViAXimXs+Oq1m
 TVn5Q7XRPls74A+r1Gb6qwWhzpxUnpvFra72KAuhjWiuOd+s+lTcx6D5QdY0CYr8Dr43
 ZS/Q==
X-Gm-Message-State: AOJu0Ywxlp1ES7o8c2OY2ybyOSREc67eRdnELHV17GngZ4kDnN03Kx0F
 2fwAhs7GLY6SByZ+39OHYPAVqAdCCOsy4FUZ3h5X4l+deT98QfflzHe6vTV9Dp2Q8B8QS3g2zfn
 OxitjkNo25RLt9+efN3i/X3bHK026g1nlxbjJVQ1rkA==
X-Gm-Gg: ASbGncsQO4PrNBoKOqGP8clCa0jmbaHIXMLpHiyxrgrb/k/ttenDrhEgUE1IbZBoBKy
 68H7HrN7lVLb25cELcuWPHFC0jz5J11ahh7KTRMR6wQckLtTUC0aNu9xcESYtslizA6dbZfO3Me
 A2FNSFlTcjIAVdSX6OMNIKaNgjXNUZzefJr3Z2UKg86VAW
X-Google-Smtp-Source: AGHT+IHE87u76KyfFS4DvFohGYB6ov9W5TRfwvfZMm2F9856Zu/c/frUj9fOoh5y9wdvV5hBzPp23+S88B3ja4m4TJU=
X-Received: by 2002:a05:690c:599a:b0:711:af14:3981 with SMTP id
 00721157ae682-711af144040mr56330777b3.31.1750236916051; Wed, 18 Jun 2025
 01:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250618080056.1973311-1-javierm@redhat.com>
 <20250618080056.1973311-4-javierm@redhat.com>
In-Reply-To: <20250618080056.1973311-4-javierm@redhat.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 18 Jun 2025 11:54:40 +0300
X-Gm-Features: AX0GCFsifT7spCzdDQkXJCQKm9oPx18C768YtYMlkTkYk40IVAceXhtvdGAAGc0
Message-ID: <CAC_iWjLTHfckxa13rGkacL+dUWGj_-jGffOLqzc4ACKZoYYSQA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] efi_loader: disk: add EFI_PARTITION_INFO_PROTOCOL
 support
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: u-boot@lists.denx.de, mripard@redhat.com, Tom Rini <trini@konsulko.com>, 
 alexl@redhat.com, mkorpers@redhat.com, eballetb@redhat.com, 
 mskrivan@redhat.com, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Maks Mishin <maks.mishinfz@gmail.com>, Simon Glass <sjg@chromium.org>
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

On Wed, 18 Jun 2025 at 11:06, Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> The UEFI 2.10 specification mentions that this protocol shall be installed
> along with EFI_BLOCK_IO_PROTOCOL. It provides cached partition information
> for MBR and GPT partition types.
>
> This patch just implements support for GPT partition types. The legacy MBR
> partition types is only needed for backward compatibility and can be added
> as a follow-up if needed, to make it fully compliant with the EFI spec.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>
> (no changes since v1)
>
>  include/part_efi.h        | 20 ++++++++++++++++++++
>  lib/efi_loader/efi_disk.c | 38 ++++++++++++++++++++++++++++++++++++--
>  2 files changed, 56 insertions(+), 2 deletions(-)
>
> diff --git a/include/part_efi.h b/include/part_efi.h
> index 59b7895b8a23..fb402df6f13e 100644
> --- a/include/part_efi.h
> +++ b/include/part_efi.h
> @@ -138,4 +138,24 @@ typedef struct _legacy_mbr {
>         __le16 signature;
>  } __packed legacy_mbr;
>
> +#define EFI_PARTITION_INFO_PROTOCOL_GUID \
> +       EFI_GUID(0x8cf2f62c, 0xbc9b, 0x4821, 0x80, \
> +                0x8d, 0xec, 0x9e, 0xc4, 0x21, 0xa1, 0xa0)
> +
> +#define EFI_PARTITION_INFO_PROTOCOL_REVISION 0x0001000
> +#define PARTITION_TYPE_OTHER 0x00
> +#define PARTITION_TYPE_MBR 0x01
> +#define PARTITION_TYPE_GPT 0x02
> +
> +struct efi_partition_info {
> +       u32 revision;
> +       u32 type;
> +       u8 system;
> +       u8 reserved[7];
> +       union {
> +               struct partition mbr;
> +               gpt_entry gpt;
> +       } info;
> +} __packed;
> +
>  #endif /* _DISK_PART_EFI_H */
> diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> index 47b583cc5e12..ba41b77b9d1c 100644
> --- a/lib/efi_loader/efi_disk.c
> +++ b/lib/efi_loader/efi_disk.c
> @@ -26,6 +26,7 @@ struct efi_system_partition efi_system_partition = {
>
>  const efi_guid_t efi_block_io_guid = EFI_BLOCK_IO_PROTOCOL_GUID;
>  const efi_guid_t efi_system_partition_guid = PARTITION_SYSTEM_GUID;
> +const efi_guid_t efi_partition_info_guid = EFI_PARTITION_INFO_PROTOCOL_GUID;
>
>  /**
>   * struct efi_disk_obj - EFI disk object
> @@ -35,6 +36,7 @@ const efi_guid_t efi_system_partition_guid = PARTITION_SYSTEM_GUID;
>   * @media:     block I/O media information
>   * @dp:                device path to the block device
>   * @volume:    simple file system protocol of the partition
> + * @info:      EFI partition info protocol interface
>   */
>  struct efi_disk_obj {
>         struct efi_object header;
> @@ -42,6 +44,7 @@ struct efi_disk_obj {
>         struct efi_block_io_media media;
>         struct efi_device_path *dp;
>         struct efi_simple_file_system_protocol *volume;
> +       struct efi_partition_info info;
>  };
>
>  /**
> @@ -426,6 +429,7 @@ static efi_status_t efi_disk_add_dev(
>         /* Fill in object data */
>         if (part_info) {
>                 struct efi_device_path *node = efi_dp_part_node(desc, part);
> +               struct efi_partition_info *info = &diskobj->info;
>                 struct efi_handler *handler;
>                 void *protocol_interface;
>
> @@ -454,18 +458,47 @@ static efi_status_t efi_disk_add_dev(
>                         goto error;
>                 }
>
> +               info->revision = EFI_PARTITION_INFO_PROTOCOL_REVISION;
> +
> +               switch (desc->part_type) {
> +               case PART_TYPE_EFI:
> +                       info->type = PARTITION_TYPE_GPT;
> +                       ret = part_get_gpt_pte(desc, part, &info->info.gpt);
> +                       if (ret) {
> +                               log_debug("get PTE for part %d failed %ld\n",
> +                                         part, ret);
> +                               goto error;
> +                       }
> +
> +                       break;
> +               case PART_TYPE_DOS:
> +                       info->type = PARTITION_TYPE_MBR;
> +
> +                       /* TODO: implement support for MBR partition types */
> +                       log_debug("EFI_PARTITION_INFO_PROTOCOL doesn't support MBR\n");
> +
> +                       break;
> +               default:
> +                       info->type = PARTITION_TYPE_OTHER;
> +
> +                       break;
> +               }
> +
>                 diskobj->dp = efi_dp_append_node(dp_parent, node);
>                 efi_free_pool(node);
>                 diskobj->media.last_block = part_info->size - 1;
> -               if (part_info->bootable & PART_EFI_SYSTEM_PARTITION)
> +               if (part_info->bootable & PART_EFI_SYSTEM_PARTITION) {
>                         esp_guid = &efi_system_partition_guid;
> +                       info->system = 1;
> +               }
> +
>         } else {
>                 diskobj->dp = efi_dp_from_part(desc, part);
>                 diskobj->media.last_block = desc->lba - 1;
>         }
>
>         /*
> -        * Install the device path and the block IO protocol.
> +        * Install the device path, the block IO and partition info protocols.
>          *
>          * InstallMultipleProtocolInterfaces() checks if the device path is
>          * already installed on an other handle and returns EFI_ALREADY_STARTED
> @@ -476,6 +509,7 @@ static efi_status_t efi_disk_add_dev(
>                                         &handle,
>                                         &efi_guid_device_path, diskobj->dp,
>                                         &efi_block_io_guid, &diskobj->ops,
> +                                       &efi_partition_info_guid, &diskobj->info,
>                                         /*
>                                          * esp_guid must be last entry as it
>                                          * can be NULL. Its interface is NULL.
> --
> 2.49.0
>
