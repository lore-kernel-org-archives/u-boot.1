Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34D4EA8105
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 12:50:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DA1E83D0B;
	Tue, 10 Feb 2026 13:50:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VaYT+/jR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4EAE83DAE; Tue, 10 Feb 2026 13:50:04 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBB7E83D0F
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 13:49:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b872f1c31f1so100576666b.0
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 04:49:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770727799; cv=none;
 d=google.com; s=arc-20240605;
 b=le6xnA9K+vsxksaznfY9AWJAHtD/H1oiNdk+Uv1HqyJNnh9peUUrBWsMK9RlYyV5of
 lCd8k5hA6GzLF837RXnKf/FN5Vm1pODQwWqTHzW2AniaMNfnHg/4YDv/uv2O2ov0E52W
 22VGUDYNC+o/4XA8B/Su6SF3TMhq5PTUbzOAYRVh0OespBOa8c9R2lUag58kcW90dZHY
 5kwwQ8M9k2OdPbk2q97NzaFOKQPVRQ7gOZwcht+BjBZDZ1h/1XpLSvl/zKqe0bt5Nm6C
 f3ZiaACo6WKy+Xmllz7ri2lT9oYwlZORRWhf5SOVcarKyfZrBqrhABDIjV9xxFFUEcjr
 zClQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EzNs5hXXaVA5YM1/m9LgxCfn6Qa43BLPrrVQAHBheLY=;
 fh=z47MHo7WVpeVKn72CWD8bMTxdnWeJEi4fmtxTxG5jIY=;
 b=ffwMIgDiE6Rea8zYjPvawuejkyfRb2KN/xFPyELr4a/XNpI5tsErqw+IeukI2xgy2X
 OW6WBWk4nIQ4oUonB26W4+1rePWbJkRUv93ZtpHZ6bBcT6ZxztSkTszFCke7aygS42OT
 f4GDcooGgIugoEydTPxOWmKviOB/6MiK5LapAAjZVN1sxm/e4iwTIDmE0U/bVmTmvo4b
 vXwLTW3mfb26N+/1+iIkQlcRDE6ZhNzeIF/zfCkh3t/iCyFwQkbo2av+1uecFjkBYFaT
 AjzJPzX9NHs1qSji7e1z52y0P8sTtwWMylaBFoFohrw/iNfiNnPAEGszK/puAy+IqqIi
 ju1g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1770727799; x=1771332599; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EzNs5hXXaVA5YM1/m9LgxCfn6Qa43BLPrrVQAHBheLY=;
 b=VaYT+/jR6zpPFAIQ9k+a8YRH0eXFzFhxOpAUv1/wiaECEQB0hFa9+214hmrCXYV9VH
 rAcDP6VD1PH45PT5G06kOO+vSNIqcEGqKJBFQ4SVt2+a4vWhugCL3CAQhXgQgwhNsDZM
 F/3otj3eUhZsA9tqSSVbYvBso/SHyOC4bRje4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770727799; x=1771332599;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EzNs5hXXaVA5YM1/m9LgxCfn6Qa43BLPrrVQAHBheLY=;
 b=P7aoKzKNVgaJfdE6H/DE22VsW7xXqfD++iv3RQ/IrmsUbH/Xn03sLWNQSVsh1gM0OI
 H+m2/kvZ92BNwhHhXv5TbPsJRFQQB7dVVaXCiYGg4CqfGb0gmUCzMcZqQA/Cv6DlqKBc
 By1t5D5E/YLTT74R+rJ6idtHoU8hPbtzTHZo9PYo1ouRfvhBfyo7LgAKaRXfFIZpmT31
 1I1M63JKoeHgb0mxpAbwreJQt58zjd9cLcH2zVvGGAAZGSql8TTixWsQ8jm54urPRSOQ
 ShJGAhILqAZ2Do0DtAcfywaZANHjMmBK1QrzzYW7xVJEZkX9ywlR7uyakJ4HSU76NXYz
 CkAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl1XWKJWiK0ardr/afZOhgtv09r13GhI37chtJ9tbwtWPB59hb5N93NL+PB1y4fUAaXxqwaYc=@lists.denx.de
X-Gm-Message-State: AOJu0YyCIueyGdycIShvZ4hDaELOGKGL7ATfqJC30371wANa3GfH1snd
 e+pXv56Am48gyuoO58jBzC9HW7NtI66TtYHBHxEMEhNYoyAClmD5kOR3rfJGwXu7dVpDVGb6N9F
 BB4bM9yoH5HQKG8JHhHuYVpK1BMYsUbmDnk+Za+wm
X-Gm-Gg: AZuq6aLtaovzr/EEszQpyqYVg7Ci541QxJqBLdqAqZiTkiBXe79/R2kbJQ+FGx8Bguo
 nTHzHdPE9dOhrKiAS7vMKYfnipp0IgO6WvNV7C789hqxzD4Bynj6D0o7MakeKZCXwAKyj+pzqng
 0kvYnJyAbc+8mwqJXzE0jml6DrQQmb33Xgv3RRw/RA0/jXGQUFo4cuQlhWA33NOoGKgRdwv3l+h
 IzP6fppFtf8aCM27z56aJAOKEcyrxsmeMMB5OvRbUNqJ6My04arNJJvaeZ5ny6MDRViqXz+Hw1/
 /tr1Aw==
X-Received: by 2002:a17:907:7205:b0:b88:5158:d0fc with SMTP id
 a640c23a62f3a-b8edf42ec5bmr937365166b.58.1770727798508; Tue, 10 Feb 2026
 04:49:58 -0800 (PST)
MIME-Version: 1.0
References: <20260129184817.224101-1-aswin.murugan@oss.qualcomm.com>
 <20260129184817.224101-2-aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260129184817.224101-2-aswin.murugan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 10 Feb 2026 05:49:46 -0700
X-Gm-Features: AZwV_Qgp__ie68vw2kRI6pZ1kW0Rr-JQfxv_wiVAtJR7nk4jRcT_iDSBBlxCAeE
Message-ID: <CAFLszTjsXtPiWVGVpS6eBfEguWhxnu9M1YH9Nm2wBZVn-2nKKw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mach-snapdragon: Add generic SMEM cache
 infrastructure
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, quic_varada@quicinc.com, me@samcday.com, 
 sughosh.ganu@linaro.org, ilias.apalodimas@linaro.org, 
 balaji.selvanathan@oss.qualcomm.com, marek.vasut+renesas@mailbox.org, 
 u-boot-qcom@groups.io, u-boot@lists.denx.de
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

On Thu, 29 Jan 2026 at 11:48, Aswin Murugan
<aswin.murugan@oss.qualcomm.com> wrote:
>
> Add cached access functions for commonly used SMEM data to reduce
> redundant SMEM lookups across the boot process.

What is SMEM? Could you add some mention of this in doc/board/qualcomm/ ?

>
> This patch introduces three generic caching functions:
> - qcom_get_smem_device(): Cached SMEM device access
> - qcom_get_socinfo(): Cached socinfo structure access
> - qcom_get_ram_partitions(): Cached RAM partition table access
>
> The implementation includes new header files for data structures:
> - include/soc/qcom/socinfo.h: Added socinfo header from Linux [1]
>   Provides socinfo structure definitions for SoC identification
>   and hardware parameters
> - arch/arm/mach-snapdragon/rampart.h: Provides RAM partition table
>   structures for memory layout information
>
> The caching mechanism initializes SMEM data on first access and
> returns cached pointers on subsequent calls, avoiding expensive
> SMEM lookups during boot. This infrastructure is designed to be
> reusable by other Qualcomm-specific features that require hardware
> information from SMEM.
>
> The functions provide a clean API for accessing:
> - SoC information (chip ID, version, platform details)
> - RAM partition layout for memory size calculations
> - Hardware parameters needed for device-specific configurations
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/soc/qcom/socinfo.h?id=7dcc1dfaa3d1cd3aafed2beb7086ed34fdb22303
>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>  arch/arm/mach-snapdragon/board.c     |  92 +++++++++++
>  arch/arm/mach-snapdragon/qcom-priv.h |  10 ++
>  arch/arm/mach-snapdragon/rampart.h   | 236 +++++++++++++++++++++++++++
>  include/soc/qcom/socinfo.h           | 114 +++++++++++++
>  4 files changed, 452 insertions(+)
>  create mode 100644 arch/arm/mach-snapdragon/rampart.h
>  create mode 100644 include/soc/qcom/socinfo.h
>
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 5fb3240acc5..cbe2aaeba6e 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -30,6 +30,7 @@
>  #include <malloc.h>
>  #include <fdt_support.h>
>  #include <usb.h>
> +#include <smem.h>
>  #include <sort.h>
>  #include <time.h>

header order

https://docs.u-boot.org/en/latest/develop/codingstyle.html#include-files

>
> @@ -39,6 +40,13 @@ DECLARE_GLOBAL_DATA_PTR;
>
>  enum qcom_boot_source qcom_boot_source __section(".data") = 0;
>
> +/* SMEM cache structure */
> +static struct {
> +       struct udevice *smem_dev;
> +       struct socinfo *soc_info;
> +       struct usable_ram_partition_table *ram_partition_table;

how about 'ram_part' as the name, since it is shorter? Please comment
the struct too.

> +} smem_cache;
> +
>  static struct mm_region rbx_mem_map[CONFIG_NR_DRAM_BANKS + 2] = { { 0 } };

This should already be zero. Can you move this to device-private data?
Then it can be allocated/freed by driver model.

Perhaps you could just have smem_dev as a variable with the other two
fields (from the above struct) kept in driver-private data?

>
>  struct mm_region *mem_map = rbx_mem_map;
> @@ -749,3 +757,87 @@ void enable_caches(void)
>         }
>         dcache_enable();
>  }
> +
> +/**
> + * qcom_get_smem_device() - Get cached SMEM device
> + *
> + * This function provides cached access to the SMEM device.
> + * On first call, it initializes the SMEM device.
> + * Subsequent calls return the cached pointer.
> + *
> + * Return: Pointer to SMEM device on success, NULL on failure
> + */
> +struct udevice *qcom_get_smem_device(void)
> +{
> +       if (smem_cache.smem_dev)
> +               return smem_cache.smem_dev;
> +
> +       if (uclass_get_device(UCLASS_SMEM, 0, &smem_cache.smem_dev)) {

If there is only ever one, then uclass_first_device_err()

> +               log_err("Failed to get SMEM device\n");
> +               return NULL;
> +       }
> +
> +       return smem_cache.smem_dev;
> +}
> +
> +/**
> + * qcom_get_socinfo() - Get cached socinfo from SMEM
> + *
> + * This function provides cached access to the socinfo structure from SMEM.
> + * On first call, it initializes the SMEM device and retrieves the socinfo.
> + * Subsequent calls return the cached pointer.
> + *
> + * Return: Pointer to socinfo structure on success, NULL on failure
> + */
> +struct socinfo *qcom_get_socinfo(void)
> +{
> +       size_t size;
> +       struct udevice *dev;
> +
> +       if (smem_cache.soc_info)
> +               return smem_cache.soc_info;
> +
> +       dev = qcom_get_smem_device();
> +       if (!dev)
> +               return NULL;
> +
> +       smem_cache.soc_info = smem_get(dev, 0, SMEM_HW_SW_BUILD_ID, &size);
> +       if (!smem_cache.soc_info) {
> +               log_err("Failed to get socinfo from SMEM\n");
> +               return NULL;
> +       }
> +
> +       return smem_cache.soc_info;
> +}
> +
> +/**
> + * qcom_get_ram_partitions() - Get cached RAM partition table from SMEM
> + *
> + * This function provides cached access to the RAM partition table from SMEM.
> + * On first call, it retrieves the partition table from SMEM.
> + * Subsequent calls return the cached pointer.
> + *
> + * Return: Pointer to RAM partition table on success, NULL on failure
> + */
> +struct usable_ram_partition_table *qcom_get_ram_partitions(void)
> +{
> +       size_t size;
> +       struct udevice *dev;
> +
> +       if (smem_cache.ram_partition_table)
> +               return smem_cache.ram_partition_table;
> +
> +       dev = qcom_get_smem_device();
> +       if (!dev)
> +               return NULL;
> +
> +       smem_cache.ram_partition_table = smem_get(dev, 0,
> +                                                 SMEM_USABLE_RAM_PARTITION_TABLE,
> +                                                 &size);
> +       if (!smem_cache.ram_partition_table) {
> +               log_err("Failed to get RAM partition table from SMEM\n");
> +               return NULL;
> +       }
> +
> +       return smem_cache.ram_partition_table;
> +}
> diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
> index b8bf574e8bb..ca1363514ae 100644
> --- a/arch/arm/mach-snapdragon/qcom-priv.h
> +++ b/arch/arm/mach-snapdragon/qcom-priv.h
> @@ -3,6 +3,9 @@
>  #ifndef __QCOM_PRIV_H__
>  #define __QCOM_PRIV_H__
>
> +#include <soc/qcom/socinfo.h>
> +#include "rampart.h"
> +
>  /**
>   * enum qcom_boot_source - Track where we got loaded from.
>   * Used for capsule update logic.
> @@ -17,6 +20,13 @@ enum qcom_boot_source {
>
>  extern enum qcom_boot_source qcom_boot_source;
>
> +/*
> + * SMEM Cache API - Provides cached access to SMEM data structures
> + */
> +struct udevice *qcom_get_smem_device(void);
> +struct socinfo *qcom_get_socinfo(void);
> +struct usable_ram_partition_table *qcom_get_ram_partitions(void);

comments

> +
>  #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
>  void qcom_configure_capsule_updates(void);
>  #else
> diff --git a/arch/arm/mach-snapdragon/rampart.h b/arch/arm/mach-snapdragon/rampart.h
> new file mode 100644
> index 00000000000..cfddaca0d5f
> --- /dev/null
> +++ b/arch/arm/mach-snapdragon/rampart.h
> @@ -0,0 +1,236 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * RAM partition table definitions
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + */
> +
> +#define SMEM_USABLE_RAM_PARTITION_TABLE                402
> +
> +#define RAM_PARTITION_H_MAJOR  03
> +#define RAM_PARTITION_H_MINOR  00
> +
> +typedef u8 uint8;
> +typedef u32 uint32;
> +typedef u64 uint64;

We already have these definitions - see asm-generic/int-ll64.h

> +
> +/**
> + * Total length of zero filled name string. This is not a C
> + * string, as it can occupy the total number of bytes, and if
> + * it does, it does not require a zero terminator. It cannot
> + * be manipulated with standard string handling library functions.
> + */
> +#define RAM_PART_NAME_LENGTH 16
> +
> +/**
> + * Number of RAM partition entries which are usable by APPS.
> + */
> +#define RAM_NUM_PART_ENTRIES 32
> +
> +/**
> + * @name: Magic numbers
> + * Used in identifying valid RAM partition table.
> + */
> +#define RAM_PART_MAGIC1     0x9DA5E0A8
> +#define RAM_PART_MAGIC2     0xAF9EC4E2

lower-case hex (please fix throughout0

> +
> +/**
> + * Must increment this version number whenever RAM structure of
> + * RAM partition table changes.
> + */
> +#define RAM_PARTITION_VERSION   0x3
> +
> +/**
> + * Value which indicates the partition can grow to fill the
> + * rest of RAM. Must only be used on the last partition.
> + */
> +#define RAM_PARTITION_GROW  0xFFFFFFFF
> +
> +/**
> + * RAM partition API return types.
> + */
> +enum  ram_partition_return_type {
> +       RAM_PART_SUCCESS = 0,             /* Successful return from API */
> +       RAM_PART_NULL_PTR_ERR,            /* Partition table/entry null pointer */
> +       RAM_PART_OUT_OF_BOUND_PTR_ERR,    /* Partition table pointer is not in SMEM */
> +       RAM_PART_TABLE_EMPTY_ERR,         /* Trying to delete entry from empty table */
> +       RAM_PART_TABLE_FULL_ERR,          /* Trying to add entry to full table */
> +       RAM_PART_CATEGORY_NOT_EXIST_ERR,  /* Partition doesn't belong to any memory category */
> +       RAM_PART_OTHER_ERR,               /* Unknown error */
> +       RAM_PART_RETURN_MAX_SIZE = 0x7FFFFFFF
> +};
> +
> +/**
> + * RAM partition attributes.
> + */
> +enum ram_partition_attribute_t {
> +       RAM_PARTITION_DEFAULT_ATTRB = ~0,  /* No specific attribute definition */
> +       RAM_PARTITION_READ_ONLY = 0,       /* Read-only RAM partition */
> +       RAM_PARTITION_READWRITE,           /* Read/write RAM partition */
> +       RAM_PARTITION_ATTRIBUTE_MAX_SIZE = 0x7FFFFFFF
> +};
> +
> +/**
> + * RAM partition categories.
> + */
> +enum ram_partition_category_t {
> +       RAM_PARTITION_DEFAULT_CATEGORY = ~0,  /* No specific category definition */
> +       RAM_PARTITION_IRAM = 4,                   /* IRAM RAM partition */
> +       RAM_PARTITION_IMEM = 5,                   /* IMEM RAM partition */
> +       RAM_PARTITION_SDRAM = 14,                  /* SDRAM type without specific bus information**/
> +       RAM_PARTITION_CATEGORY_MAX_SIZE = 0x7FFFFFFF
> +};
> +
> +/**
> + * RAM Partition domains.
> + * @note: For shared RAM partition, domain value would be 0b11:\n
> + * RAM_PARTITION_APPS_DOMAIN | RAM_PARTITION_MODEM_DOMAIN.
> + */
> +enum ram_partition_domain_t {
> +       RAM_PARTITION_DEFAULT_DOMAIN = 0,  /* 0b00: No specific domain definition */
> +       RAM_PARTITION_APPS_DOMAIN = 1,     /* 0b01: APPS RAM partition */
> +       RAM_PARTITION_MODEM_DOMAIN = 2,    /* 0b10: MODEM RAM partition */
> +       RAM_PARTITION_DOMAIN_MAX_SIZE = 0x7FFFFFFF
> +};
> +
> +/**
> + * RAM Partition types.
> + * @note: The RAM_PARTITION_SYS_MEMORY type represents DDR rams that are attached
> + * to the current system.
> + */
> +enum ram_partition_type_t {
> +       RAM_PARTITION_SYS_MEMORY = 1,        /* system memory */
> +       RAM_PARTITION_BOOT_REGION_MEMORY1,   /* boot loader memory 1 */
> +       RAM_PARTITION_BOOT_REGION_MEMORY2,   /* boot loader memory 2, reserved */
> +       RAM_PARTITION_APPSBL_MEMORY,         /* apps boot loader memory */
> +       RAM_PARTITION_APPS_MEMORY,           /* apps usage memory */
> +       RAM_PARTITION_TOOLS_FV_MEMORY,       /* tools usage memory */
> +       RAM_PARTITION_QUANTUM_FV_MEMORY,     /* quantum usage memory */
> +       RAM_PARTITION_QUEST_FV_MEMORY,       /* quest usage memory */
> +       RAM_PARTITION_TYPE_MAX_SIZE = 0x7FFFFFFF
> +};
> +
> +/**
> + * @brief: Holds information for an entry in the RAM partition table.
> + */
> +struct ram_partition_entry {
> +       char name[RAM_PART_NAME_LENGTH];  /* Partition name, unused for now */
> +       uint64 start_address;             /* Partition start address in RAM */
> +       uint64 length;                    /* Partition length in RAM in Bytes */
> +       uint32 partition_attribute;       /* Partition attribute */
> +       uint32 partition_category;        /* Partition category */
> +       uint32 partition_domain;          /* Partition domain */
> +       uint32 partition_type;            /* Partition type */
> +       uint32 num_partitions;            /* Number of partitions on device */
> +       uint32 hw_info;                   /* hw information such as type and frequency */
> +       uint8 highest_bank_bit;           /* Highest bit corresponding to a bank */
> +       uint8 reserve0;                   /* Reserved for future use */
> +       uint8 reserve1;                   /* Reserved for future use */
> +       uint8 reserve2;                   /* Reserved for future use */
> +       uint32 min_pasr_size;             /* Minimum PASR size in MB */
> +       uint64 available_length;          /* Available Partition length in RAM in Bytes */
> +};
> +
> +/**
> + * @brief: Defines the RAM partition table structure
> + * @note: No matter how you change the structure, do not change the placement of the
> + * first four elements so that future compatibility will always be guaranteed
> + * at least for the identifiers.
> + *
> + * @note: The other portion of the structure may be changed as necessary to accommodate
> + * new features. Be sure to increment version number if you change it.
> + */
> +struct usable_ram_partition_table {
> +       uint32 magic1;          /* Magic number to identify valid RAM partition table */
> +       uint32 magic2;          /* Magic number to identify valid RAM partition table */
> +       uint32 version;         /* Version number to track structure definition changes */
> +       uint32 reserved1;       /* Reserved for future use */
> +
> +       uint32 num_partitions;  /* Number of RAM partition table entries */
> +
> +       uint32 reserved2;       /* Added for 8 bytes alignment of header */
> +
> +       /* RAM partition table entries */
> +       struct ram_partition_entry ram_part_entry[RAM_NUM_PART_ENTRIES];
> +};
> +
> +/**
> + * Version 1 structure 32 Bit
> + * @brief: Holds information for an entry in the RAM partition table.
> + */
> +struct ram_partition_entry_v1 {
> +       char name[RAM_PART_NAME_LENGTH];  /* Partition name, unused for now */
> +       uint64 start_address;             /* Partition start address in RAM */
> +       uint64 length;                    /* Partition length in RAM in Bytes */
> +       uint32 partition_attribute;       /* Partition attribute */
> +       uint32 partition_category;        /* Partition category */
> +       uint32 partition_domain;          /* Partition domain */
> +       uint32 partition_type;            /* Partition type */
> +       uint32 num_partitions;            /* Number of partitions on device */
> +       uint32 hw_info;                   /* hw information such as type and frequency */
> +       uint32 reserved4;                 /* Reserved for future use */
> +       uint32 reserved5;                 /* Reserved for future use */
> +};
> +
> +/**
> + * @brief: Defines the RAM partition table structure
> + * @note: No matter how you change the structure, do not change the placement of the
> + * first four elements so that future compatibility will always be guaranteed
> + * at least for the identifiers.
> + *
> + * @note: The other portion of the structure may be changed as necessary to accommodate
> + * new features. Be sure to increment version number if you change it.
> + */
> +struct usable_ram_partition_table_v1 {
> +       uint32 magic1;          /* Magic number to identify valid RAM partition table */
> +       uint32 magic2;          /* Magic number to identify valid RAM partition table */
> +       uint32 version;         /* Version number to track structure definition changes */
> +       uint32 reserved1;       /* Reserved for future use */
> +
> +       uint32 num_partitions;  /* Number of RAM partition table entries */
> +
> +       uint32 reserved2;       /* Added for 8 bytes alignment of header */
> +
> +       /* RAM partition table entries */
> +       struct ram_partition_entry_v1 ram_part_entry_v1[RAM_NUM_PART_ENTRIES];
> +};
> +
> +/**
> + * Version 0 structure 32 Bit
> + * @brief: Holds information for an entry in the RAM partition table.
> + */
> +struct ram_partition_entry_v0 {
> +       char name[RAM_PART_NAME_LENGTH];  /* Partition name, unused for now */
> +       uint32 start_address;             /* Partition start address in RAM */
> +       uint32 length;                    /* Partition length in RAM in Bytes */
> +       uint32 partition_attribute;       /* Partition attribute */
> +       uint32 partition_category;        /* Partition category */
> +       uint32 partition_domain;          /* Partition domain */
> +       uint32 partition_type;            /* Partition type */
> +       uint32 num_partitions;            /* Number of partitions on device */
> +       uint32 reserved3;                 /* Reserved for future use */
> +       uint32 reserved4;                 /* Reserved for future use */
> +       uint32 reserved5;                 /* Reserved for future use */
> +};
> +
> +/**
> + * @brief: Defines the RAM partition table structure
> + * @note: No matter how you change the structure, do not change the placement of the
> + * first four elements so that future compatibility will always be guaranteed
> + * at least for the identifiers.
> + *
> + * @note: The other portion of the structure may be changed as necessary to accommodate
> + * new features. Be sure to increment version number if you change it.
> + */

Is this actually kerneldoc? We don't normally use @brief etc.

> +struct usable_ram_partition_table_v0 {
> +       uint32 magic1;          /* Magic number to identify valid RAM partition table */
> +       uint32 magic2;          /* Magic number to identify valid RAM partition table */
> +       uint32 version;         /* Version number to track structure definition changes */
> +       uint32 reserved1;       /* Reserved for future use */
> +
> +       uint32 num_partitions;  /* Number of RAM partition table entries */
> +
> +       /* RAM partition table entries */
> +       struct ram_partition_entry_v0 ram_part_entry_v0[RAM_NUM_PART_ENTRIES];

very long identifiers!

> +};
> diff --git a/include/soc/qcom/socinfo.h b/include/soc/qcom/socinfo.h
> new file mode 100644
> index 00000000000..1bb6e200e1f
> --- /dev/null
> +++ b/include/soc/qcom/socinfo.h
> @@ -0,0 +1,114 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef __QCOM_SOCINFO_H__
> +#define __QCOM_SOCINFO_H__
> +
> +#include <linux/types.h>
> +
> +/*
> + * SMEM item id, used to acquire handles to respective
> + * SMEM region.
> + */
> +#define SMEM_HW_SW_BUILD_ID            137
> +
> +#define SMEM_SOCINFO_BUILD_ID_LENGTH   32
> +#define SMEM_SOCINFO_CHIP_ID_LENGTH    32
> +
> +/*
> + * SoC version type with major number in the upper 16 bits and minor
> + * number in the lower 16 bits.
> + */
> +#define SOCINFO_MAJOR(ver) (((ver) >> 16) & 0xffff)
> +#define SOCINFO_MINOR(ver) ((ver) & 0xffff)
> +#define SOCINFO_VERSION(maj, min)  ((((maj) & 0xffff) << 16) | ((min) & 0xffff))
> +
> +/* Socinfo SMEM item structure */
> +struct socinfo {
> +       __le32 fmt;
> +       __le32 id;
> +       __le32 ver;
> +       char build_id[SMEM_SOCINFO_BUILD_ID_LENGTH];
> +       /* Version 2 */
> +       __le32 raw_id;
> +       __le32 raw_ver;
> +       /* Version 3 */
> +       __le32 hw_plat;
> +       /* Version 4 */
> +       __le32 plat_ver;
> +       /* Version 5 */
> +       __le32 accessory_chip;
> +       /* Version 6 */
> +       __le32 hw_plat_subtype;
> +       /* Version 7 */
> +       __le32 pmic_model;
> +       __le32 pmic_die_rev;
> +       /* Version 8 */
> +       __le32 pmic_model_1;
> +       __le32 pmic_die_rev_1;
> +       __le32 pmic_model_2;
> +       __le32 pmic_die_rev_2;
> +       /* Version 9 */
> +       __le32 foundry_id;
> +       /* Version 10 */
> +       __le32 serial_num;
> +       /* Version 11 */
> +       __le32 num_pmics;
> +       __le32 pmic_array_offset;
> +       /* Version 12 */
> +       __le32 chip_family;
> +       __le32 raw_device_family;
> +       __le32 raw_device_num;
> +       /* Version 13 */
> +       __le32 nproduct_id;
> +       char chip_id[SMEM_SOCINFO_CHIP_ID_LENGTH];
> +       /* Version 14 */
> +       __le32 num_clusters;
> +       __le32 ncluster_array_offset;
> +       __le32 num_subset_parts;
> +       __le32 nsubset_parts_array_offset;
> +       /* Version 15 */
> +       __le32 nmodem_supported;
> +       /* Version 16 */
> +       __le32  feature_code;
> +       __le32  pcode;
> +       __le32  npartnamemap_offset;
> +       __le32  nnum_partname_mapping;
> +       /* Version 17 */
> +       __le32 oem_variant;
> +       /* Version 18 */
> +       __le32 num_kvps;
> +       __le32 kvps_offset;
> +       /* Version 19 */
> +       __le32 num_func_clusters;
> +       __le32 boot_cluster;
> +       __le32 boot_core;
> +};
> +
> +/* Internal feature codes */
> +enum qcom_socinfo_feature_code {
> +       /* External feature codes */
> +       SOCINFO_FC_UNKNOWN = 0x0,
> +       SOCINFO_FC_AA,
> +       SOCINFO_FC_AB,
> +       SOCINFO_FC_AC,
> +       SOCINFO_FC_AD,
> +       SOCINFO_FC_AE,
> +       SOCINFO_FC_AF,
> +       SOCINFO_FC_AG,
> +       SOCINFO_FC_AH,
> +};

Do these values have any meaning, or are they documented somewhere?

> +
> +/* Internal feature codes */
> +/* Valid values: 0 <= n <= 0xf */
> +#define SOCINFO_FC_Yn(n)               (0xf1 + (n))
> +#define SOCINFO_FC_INT_MAX             SOCINFO_FC_Yn(0xf)
> +
> +/* Product codes */
> +#define SOCINFO_PC_UNKNOWN             0
> +#define SOCINFO_PCn(n)                 ((n) + 1)
> +#define SOCINFO_PC_RESERVE             (BIT(31) - 1)
> +
> +#endif
> --
> 2.34.1
>

Regards,
Simon
