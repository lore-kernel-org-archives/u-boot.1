Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 197DFEA8105
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 12:50:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A24C183CEE;
	Tue, 10 Feb 2026 13:50:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BthPtlF/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C7A383D77; Tue, 10 Feb 2026 13:50:08 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EDDA83D9F
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 13:50:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b884ad1026cso126420166b.2
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 04:50:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770727802; cv=none;
 d=google.com; s=arc-20240605;
 b=ilLJpwfmSdcrx1zxvtdKpASBAoVs9xYhF2BDOGOwphGsYbhYS+sDg8Zw/RtNtfmLi4
 HhKwqauhaipTHmHXzBOEs1hl3uDubr4FHzqwnDPt6MavYq9Cg8qvRZKwrfABhSqblc5g
 /7/3OmpxH9nf7cUPLZhQyIe5b/QW8tPUSI8PqCvnwXDPVnhkeosROh8rW2xS+aopltFM
 +ybAj7oJdnpRBKkTA5H/LKmoXvQowtG72ZjZT5UOrdDTmKLBzSvVsFyXlv4pRTSSeXqN
 dxl5aiILxhJdrblcoHDkB6R6VoAGNR4BabnpaPNNVnNAFdmJpzeSOxCtsO0MbBNTdLMp
 QZpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=awSjb8J9JnE/UDuNZdBjNUmgZqwlDXnm4pR5zxIiWnw=;
 fh=Q5BxwxaFNWDiUfFAZsaF4NlVG9dWUR1UoWYQA9/ol3Y=;
 b=jqa01z7O6RbOl9+t+vGm3rBUIWt9vFRg2N8r9x6LiFYrhQhUgUC/CExPmgFqn0MADR
 3NbrloKA8NQnSqjrjQm524wsL+jgvQIjrbGfC6KEA95ISUz6pZxWqJoigcYrLzV+D2ty
 CkjDewsiNhYYHwCMuaOw/6HjmWdD36LBvzfuSYdb1hIyXHTrGl2+UlOb96E5QdkdxImi
 NG+2aZ+V5RDKlUsFhoO+gG4dR96c2RQkYsreaz75KhINmPANnTagu1eXFNfFoKOsnVlX
 hF9mKrrl6R34XAu7/5LSYgy4fs36GwCSC9kF/2QQit0tyK2cesxAWnARtsnoGYrZRSH0
 y5tw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1770727802; x=1771332602; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=awSjb8J9JnE/UDuNZdBjNUmgZqwlDXnm4pR5zxIiWnw=;
 b=BthPtlF/G/yzEc0ZPH9mZCgPIy9pVCnCqDH8n2KMvE1pqo0RdKiToY7Q5uLUShwBtB
 aXsftG8poPPZCNkdl5fG1EPkkN8vi0UnkvdoruU8PurPu4zgLqW9D6Y9SVV4iVeF7+xT
 9faWgCa2MAkli2RtRAQ2fG/T9LdgXEVYczh1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770727802; x=1771332602;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=awSjb8J9JnE/UDuNZdBjNUmgZqwlDXnm4pR5zxIiWnw=;
 b=B/nQ8m4hVOKV0FmhKnMzJa4H64hxBHiNEcyAKDMvlyGAygjZ4L/XddR30sNKhJNXJu
 SdQx8QVwRD81wDIWuhXdBBCjCw/XUbZP4RQ6/qdlX65l163j2wsydQ3SAaTz18MSFZMk
 Z56L65e97eo5BhjRKWWTXPwTJoCPczy18p1PpZaqqlywgNUkgCViRTVbNpg0a7XHGLaP
 TdU0nmLEhMkUS8zClhZaLA8sXYCvjVa28uKKRxksm2dYj653sCjWh6tmbCgnJhBrTrvC
 DZHAsBGDYFYm5J3klTABkKQf1PkVk7tOs2QhoeFOlz43aT2DCF1CWmrRQamvq/pQkAqv
 Fciw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwqIPuFIKcAszKYTLWLlVqZrvn/1rWfZqdL+EqPcamNgJfoNgE8xPfyt9IHTVpZCjELBhioG4=@lists.denx.de
X-Gm-Message-State: AOJu0YwodeAngKM/SZoRMI6OdI+UNzPEHRjZSuB2/C8Ay8Vp15EH/EXR
 OsNpZeaz+dMQsIxqchuj58l1gBY/yypYdd2ydO/jlTD+vglAGqSvcPadLLUFDT13krxRBv82gGX
 HIcHY2xcN+6SvNQA8wlpbGUKaEr/BauszEpkhAFusLITOces4IS8=
X-Gm-Gg: AZuq6aLzAUgwz4QSt6mh3IEmnsGLub45Enar3skl9SjMqPgJo34elVPYltE4W5Yxtcb
 Os5e/cocRfbmH9TtrV0j6APTLjWnJopn9C6JjDuJmIH4jy7ZrJFS0nIbF8bOCfNOVGhld+zKpUi
 PHS5ruyNaozI+BXeCd1erCD8wD6i8OG+/tVlWZxmJsPBp+WxBT3Uwfa7oETAuaT9zPRPck43YzM
 Eqq2Do1QxcDDmvpafHWVbuiDwHhoYrc8U6vA4B7uPn7Xufj4hA8UPmlcPSJ8vCzPkbFTzmMVvH1
 xkaK7A==
X-Received: by 2002:a17:907:9723:b0:b88:4102:8932 with SMTP id
 a640c23a62f3a-b8edf384485mr866408366b.44.1770727802133; Tue, 10 Feb 2026
 04:50:02 -0800 (PST)
MIME-Version: 1.0
References: <20260129184817.224101-1-aswin.murugan@oss.qualcomm.com>
 <20260129184817.224101-3-aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260129184817.224101-3-aswin.murugan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 10 Feb 2026 05:49:49 -0700
X-Gm-Features: AZwV_Qi-_LM9RXEVNaDvTAUZtKZAipti9TTER1mKb75BHQNBHd3z3oqPYQKnC7M
Message-ID: <CAFLszTh00E6LPx+vTxtDp2Oy4SX9qvUvrRmpq6-gLVHArLxXEQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mach-snapdragon: Add FIT multi-DTB selection
 support
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
> Implement multi DTB selection from FIT images based on hardware
> detection via SMEM.
>
> The implementation provides:
>
> 1. Hardware Detection: Reads SoC parameters from SMEM including chip ID,
>    version, platform ID, OEM variant, DDR size, and storage type from IMEM.
>
> 2. Metadata DTB Processing: Parses a metadata DTB (first image in FIT)
>    to build a "bucket list" of hardware-specific node names that match
>    the detected hardware parameters.
>
> 3. FIT Configuration Matching: Uses standard FIT mechanisms to find the
>    configuration with the most matching tokens in its compatible string
>    compared to the hardware-derived bucket list.
>
> 4. DTB Loading and Overlays: Loads the base DTB and applies any DTBOs
>    specified in the selected configuration using standard FIT overlay
>    application.
>
> 5. EFI Integration: Loads selected dtb from qclinux_fit.img and sets
>    fdt_addr for use by the EFI boot flow.
>
> This enables multi DTB selection across hardware variants.
>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>  arch/arm/mach-snapdragon/Kconfig             |  14 +
>  arch/arm/mach-snapdragon/Makefile            |   1 +
>  arch/arm/mach-snapdragon/board.c             |   7 +
>  arch/arm/mach-snapdragon/qcom_fit_multidtb.c | 997 +++++++++++++++++++
>  arch/arm/mach-snapdragon/qcom_fit_multidtb.h | 181 ++++
>  5 files changed, 1200 insertions(+)
>  create mode 100644 arch/arm/mach-snapdragon/qcom_fit_multidtb.c
>  create mode 100644 arch/arm/mach-snapdragon/qcom_fit_multidtb.h

Please can you add something to doc/ as this is a major feature

>
> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> index 976c0e35fce..a1496d43c7b 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -45,4 +45,18 @@ config SYS_CONFIG_NAME
>           Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
>           will be used for board configuration.
>
> +config QCOM_FIT_MULTIDTB
> +       bool "Enable FIT multi-DTB selection for Qualcomm platforms"
> +       depends on FIT
> +       help
> +         Enable FIT multi-DTB selection for Qualcomm platforms.
> +         This allows U-Boot to select the appropriate device tree
> +         from a FIT image.

A FIT image is actually an image within a FIT :-) Really we should
just say 'FIT' in most cases.

> +
> +config QCOM_IMEM_SIZE
> +       hex "QCOM IMEM size"
> +       default 0x0
> +       help
> +         Platform-specific IMEM size for calculating shared IMEM base address.

How do you calculate this?

Does it belong in the earlier patch?

> +
>  endif
> diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
> index 343e825c6fd..76e285021a1 100644
> --- a/arch/arm/mach-snapdragon/Makefile
> +++ b/arch/arm/mach-snapdragon/Makefile
> @@ -5,3 +5,4 @@
>  obj-y += board.o
>  obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += capsule_update.o
>  obj-$(CONFIG_OF_LIVE) += of_fixup.o
> +obj-$(CONFIG_QCOM_FIT_MULTIDTB) += qcom_fit_multidtb.o
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index cbe2aaeba6e..8f46ba2d677 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -34,6 +34,7 @@
>  #include <sort.h>
>  #include <time.h>
>
> +#include "qcom_fit_multidtb.h"
>  #include "qcom-priv.h"
>
>  DECLARE_GLOBAL_DATA_PTR;
> @@ -581,6 +582,12 @@ int board_late_init(void)
>         /* Configure the dfu_string for capsule updates */
>         qcom_configure_capsule_updates();
>
> +       /* Try FIT multi-DTB selection if enabled */
> +       if (IS_ENABLED(CONFIG_QCOM_FIT_MULTIDTB)) {
> +               if (qcom_fit_multidtb_setup() != 0)

if (!...

> +                       log_debug("FIT multi-DTB selection not available or failed\n");
> +       }
> +
>         return 0;
>  }
>
> diff --git a/arch/arm/mach-snapdragon/qcom_fit_multidtb.c b/arch/arm/mach-snapdragon/qcom_fit_multidtb.c
> new file mode 100644
> index 00000000000..eaf565b7a8a
> --- /dev/null
> +++ b/arch/arm/mach-snapdragon/qcom_fit_multidtb.c
> @@ -0,0 +1,997 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Qualcomm FIT Multi-DTB Selection
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * Automatic DTB selection from FIT images based on hardware detection via SMEM.
> + * Loads qclinux_fit.img from dtb partition, detects hardware parameters,
> + * and selects the best matching DTB configuration.
> + */
> +
> +#include <dm.h>
> +#include <efi_loader.h>
> +#include <efi_api.h>
> +#include <image.h>
> +#include <smem.h>
> +#include <malloc.h>
> +#include <linux/libfdt.h>
> +#include <linux/list.h>
> +#include <linux/sizes.h>
> +#include <linux/errno.h>
> +#include <linux/string.h>
> +#include <soc/qcom/socinfo.h>
> +#include <log.h>
> +#include <part.h>
> +#include <blk.h>
> +#include <env.h>
> +#include <lmb.h>
> +#include "qcom_fit_multidtb.h"
> +#include "qcom-priv.h"

header order: https://docs.u-boot.org/en/latest/develop/codingstyle.html#include-files

> +
> +#define lmb_alloc(size, addr) lmb_alloc_mem(LMB_MEM_ALLOC_ANY, SZ_2M, addr, size, LMB_NONE)
> +
> +/* Maximum values to match (SOC needs 2) */
> +#define MAX_MATCH_VALUES 2
> +
> +/* FIT image paths */
> +#define FIT_IMAGES_PATH        "/images"
> +#define FIT_CONFIGURATIONS_PATH "/configurations"

These should be in image.h

> +
> +/* Metadata DTB node names */
> +#define META_NODE_OEM          "oem"
> +#define META_NODE_SOC          "soc"
> +#define META_NODE_BOARD        "board"
> +#define META_NODE_SOC_SKU      "soc-sku"
> +#define META_NODE_BOARD_SUBTYPE_PERIPHERAL "board-subtype-peripheral-subtype"
> +#define META_NODE_BOARD_SUBTYPE_STORAGE    "board-subtype-storage-type"
> +#define META_NODE_BOARD_SUBTYPE_MEMORY     "board-subtype-memory-size"
> +#define META_NODE_SOFTSKU      "softsku"
> +
> +/* Property names */
> +#define PROP_OEM_ID            "oem-id"
> +#define PROP_MSM_ID            "msm-id"
> +#define PROP_BOARD_ID          "board-id"
> +#define PROP_BOARD_SUBTYPE     "board-subtype"
> +#define PROP_SOFTSKU_ID        "softsku-id"
> +#define PROP_COMPATIBLE        "compatible"
> +#define PROP_FDT               "fdt"
> +#define PROP_DATA              "data"

Are these additions to the FIT schema, or something else?

> +
> +/**
> + * add_to_bucket() - Add a node name to the bucket list
> + * @name: Node name to add
> + * @name_len: Length of the name
> + * @bucket_head: Head of the bucket list
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int add_to_bucket(const char *name, int name_len, struct list_head *bucket_head)
> +{
> +       struct bucket_node *node;
> +
> +       node = malloc(sizeof(*node));
> +       if (!node)
> +               return -ENOMEM;
> +
> +       node->name = malloc(name_len + 1);
> +       if (!node->name) {
> +               free(node);
> +               return -ENOMEM;
> +       }
> +
> +       memcpy(node->name, name, name_len);
> +       node->name[name_len] = '\0';

Does strlcpy(node->name, name, name_len + 1) work?

> +
> +       list_add_tail(&node->list, bucket_head);
> +
> +       return 0;
> +}
> +
> +/**
> + * search_in_bucket() - Check if a name exists in the bucket list

What is a bucket list? How about a comment at the top explaining this?

> + * @name: Name to search for
> + * @bucket_head: Head of the bucket list
> + *
> + * Return: true if found, false otherwise
> + */
> +static bool search_in_bucket(const char *name, struct list_head *bucket_head)
> +{
> +       struct bucket_node *node;
> +
> +       list_for_each_entry(node, bucket_head, list) {
> +               if (strcmp(node->name, name) == 0)

!strcmp

> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
> +/**
> + * free_bucket_list() - Free all nodes in the bucket list
> + * @bucket_head: Head of the bucket list
> + */
> +static void free_bucket_list(struct list_head *bucket_head)
> +{
> +       struct bucket_node *node, *tmp;
> +
> +       list_for_each_entry_safe(node, tmp, bucket_head, list) {
> +               list_del(&node->list);
> +               free(node->name);
> +               free(node);
> +       }
> +}
> +
> +/**
> + * qcom_get_ddr_size_type() - Get DDR size type from SMEM RAM partitions
> + * @ddr_type: Pointer to store DDR type
> + *
> + * This function reads RAM partition information from SMEM and calculates
> + * the total DDR size, then maps it to a DDR type constant (0-10).
> + *
> + * Return: 0 on success, negative on failure
> + */
> +static int qcom_get_ddr_size_type(u32 *ddr_type)
> +{
> +       struct usable_ram_partition_table *rpt;
> +       struct ram_partition_entry *rpe;
> +       u64 total_ddr_size = 0;
> +       int part;
> +
> +       rpt = qcom_get_ram_partitions();
> +       if (!rpt) {
> +               log_err("Failed to get RAM partition table\n");
> +               return -ENODEV;

This is used by driver model to indicate there is no device. Can you
use a different code, perhaps -ENOENT ?

> +       }
> +
> +       rpe = &rpt->ram_part_entry[0];
> +       for (part = 0; part < rpt->num_partitions; part++, rpe++) {
> +               if (rpe->partition_category == RAM_PARTITION_SDRAM &&
> +                   rpe->partition_type == RAM_PARTITION_SYS_MEMORY) {
> +                       total_ddr_size += rpe->available_length;
> +                       log_debug("RAM partition %d: start=0x%llx size=0x%llx\n",
> +                                 part, rpe->start_address, rpe->available_length);
> +               }
> +       }
> +
> +       log_info("Total DDR Size: 0x%llx (%llu MB)\n",
> +                total_ddr_size, total_ddr_size / SZ_1M);
> +
> +       *ddr_type = 0;
> +       if (total_ddr_size <= DDR_128MB)
> +               *ddr_type = DDRTYPE_128MB;
> +       else if (total_ddr_size <= DDR_256MB)
> +               *ddr_type = DDRTYPE_256MB;
> +       else if (total_ddr_size <= DDR_512MB)
> +               *ddr_type = DDRTYPE_512MB;
> +       else if (total_ddr_size <= DDR_1024MB)
> +               *ddr_type = DDRTYPE_1024MB;
> +       else if (total_ddr_size <= DDR_2048MB)
> +               *ddr_type = DDRTYPE_2048MB;
> +       else if (total_ddr_size <= DDR_3072MB)
> +               *ddr_type = DDRTYPE_3072MB;
> +       else if (total_ddr_size <= DDR_4096MB)
> +               *ddr_type = DDRTYPE_4096MB;
> +
> +       log_debug("DDR Type: %u\n", *ddr_type);
> +
> +       return 0;
> +}
> +
> +/**
> + * qcom_get_storage_type() - Detect storage type (UFS/EMMC/NAND)
> + *
> + * Reads the boot device type from the shared IMEM cookie structure populated
> + * by the bootloader. The shared region is located at the top 4KB of IMEM space.
> + * Validates magic number and version before reading the boot device type.
> + *
> + * Requires CONFIG_QCOM_IMEM_SIZE to be set in platform defconfig. If not set,
> + * returns default UFS type.
> + *
> + * Return: mem_card_type enum value (UFS/EMMC/NAND), or UFS as fallback
> + */
> +static enum mem_card_type qcom_get_storage_type(void)
> +{
> +       struct boot_shared_imem_cookie_type *cookie;
> +       uintptr_t shared_imem_base;
> +
> +       if (CONFIG_QCOM_IMEM_SIZE == 0) {
> +               log_warning("QCOM_IMEM_SIZE not configured, using default UFS\n");
> +               return UFS;
> +       }
> +
> +       shared_imem_base = SCL_IMEM_BASE + CONFIG_QCOM_IMEM_SIZE - SHARED_IMEM_SIZE;
> +       cookie = (struct boot_shared_imem_cookie_type *)shared_imem_base;

boot_shared_imem_cookie_type is very, very long - can you shorten it?
imem_cookie? Should this be a driver, if it is mapped into memory?

> +
> +       log_debug("Shared IMEM base: 0x%lx (IMEM size: 0x%x)\n",
> +                 shared_imem_base, CONFIG_QCOM_IMEM_SIZE);
> +
> +       if (cookie->shared_imem_magic != BOOT_SHARED_IMEM_MAGIC_NUM) {
> +               log_warning("Invalid shared IMEM magic: 0x%x (expected 0x%x)\n",
> +                           cookie->shared_imem_magic, BOOT_SHARED_IMEM_MAGIC_NUM);
> +               return UFS;
> +       }
> +
> +       if (cookie->shared_imem_version < BOOT_SHARED_IMEM_VERSION_NUM) {
> +               log_warning("Invalid shared IMEM version: %u (expected >= %u)\n",
> +                           cookie->shared_imem_version, BOOT_SHARED_IMEM_VERSION_NUM);
> +               return UFS;
> +       }
> +
> +       log_info("Shared IMEM: magic=0x%x, version=%u, boot_device_type=%u\n",
> +                cookie->shared_imem_magic, cookie->shared_imem_version,
> +                cookie->boot_device_type);
> +
> +       switch (cookie->boot_device_type) {
> +       case UFS_FLASH:
> +               log_info("Boot device from shared IMEM: UFS\n");
> +               return UFS;
> +       case MMC_FLASH:
> +       case SDC_FLASH:
> +               log_info("Boot device from shared IMEM: eMMC\n");
> +               return EMMC;
> +       case NAND_FLASH:
> +               log_info("Boot device from shared IMEM: NAND\n");
> +               return NAND;
> +       default:
> +               log_warning("Unknown shared IMEM boot device: %u\n",
> +                           cookie->boot_device_type);
> +               return UFS;
> +       }
> +}
> +
> +/**
> + * qcom_detect_hardware_params() - Detect all hardware parameters from SMEM
> + * @params: Pointer to hardware parameters structure
> + *
> + * This function reads hardware information from SMEM and populates the
> + * qcom_hw_params structure with all necessary data for DTB selection.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int qcom_detect_hardware_params(struct qcom_hw_params *params)
> +{
> +       struct socinfo *soc_info;
> +       int ret;
> +       u32 raw_version;
> +
> +       memset(params, 0, sizeof(*params));

'\0'

> +
> +       soc_info = qcom_get_socinfo();
> +       if (!soc_info) {
> +               log_err("Failed to get SOC info from SMEM\n");
> +               return -ENODEV;
> +       }
> +
> +       params->chip_id = le32_to_cpu(soc_info->id) & 0xFFFF;
> +
> +       raw_version = le32_to_cpu(soc_info->plat_ver);
> +       params->chip_version = (SOCINFO_MAJOR(raw_version) << 4) | SOCINFO_MINOR(raw_version);
> +
> +       params->platform = le32_to_cpu(soc_info->hw_plat);
> +       params->subtype = le32_to_cpu(soc_info->hw_plat_subtype);
> +
> +       if (le32_to_cpu(soc_info->fmt) >= 17)
> +               params->oem_variant_id = le32_to_cpu(soc_info->oem_variant);
> +       else
> +               params->oem_variant_id = 0;

but you did a memset() above

> +
> +       if (le32_to_cpu(soc_info->fmt) >= 9)
> +               params->foundry_id = le32_to_cpu(soc_info->foundry_id);
> +       else
> +               params->foundry_id = 0;
> +
> +       ret = qcom_get_ddr_size_type(&params->ddr_size_type);
> +       if (ret) {
> +               log_warning("Failed to get DDR size, defaulting to 0\n");
> +               params->ddr_size_type = 0;
> +       }
> +
> +       params->storage_type = qcom_get_storage_type();
> +
> +       log_info("Hardware Parameters:\n");
> +       log_info("  Chip ID: 0x%x\n", params->chip_id);
> +       log_info("  Chip Version: 0x%x\n", params->chip_version);
> +       log_info("  Platform: 0x%x\n", params->platform);
> +       log_info("  Subtype: 0x%x\n", params->subtype);
> +       log_info("  OEM Variant ID: 0x%x\n", params->oem_variant_id);
> +       log_info("  DDR Size Type: %u\n", params->ddr_size_type);
> +       log_info("  Storage Type: %u\n", params->storage_type);
> +       log_info("  Foundry ID: 0x%x\n", params->foundry_id);
> +
> +       return 0;
> +}
> +
> +/**
> + * process_metadata_node() - Generic metadata node processor
> + * @type: Type of node to process
> + * @metadata: Metadata DTB pointer
> + * @root_offset: Root node offset
> + * @params: Hardware parameters
> + * @bucket_head: Bucket list head
> + *
> + * This function provides a generic way to process different types of nodes

Provides a generic way...  (since we know it is a function)

> + * in the metadata DTB. It handles matching hardware parameters against DTB
> + * properties, with support for bit masking/shifting and fallback values.
> + *
> + * Return: 0 on success, -ENOENT if no match, other negative on error
> + */
> +static int process_metadata_node(enum node_process_type type,
> +                                void *metadata,
> +                                int root_offset,
> +                                struct qcom_hw_params *params,
> +                                struct list_head *bucket_head)
> +{

process_node() would be shorter

> +       int node_offset, subnode;
> +       const u32 *prop;
> +       int len;
> +       const char *subnode_name;
> +       int name_len;
> +       const char *node_name, *prop_name, *log_type;
> +       const char *fallback;
> +       u32 match_values[MAX_MATCH_VALUES];
> +       u32 masks[MAX_MATCH_VALUES];
> +       int shifts[MAX_MATCH_VALUES];
> +       int num_match_values;
> +       int i;
> +       bool all_match;

You could perhaps collect the ints here.

> +
> +       fallback = NULL;
> +       num_match_values = 1;
> +       memset(shifts, 0, sizeof(shifts));
> +       memset(masks, 0xFF, sizeof(masks));
> +
> +       switch (type) {
> +       case NODE_TYPE_OEM:
> +               node_name = META_NODE_OEM;
> +               prop_name = PROP_OEM_ID;
> +               match_values[0] = params->oem_variant_id;
> +               log_type = "OEM";
> +               fallback = "qcom";
> +               break;
> +

drop blank lines after break

> +       case NODE_TYPE_SOC:
> +               node_name = META_NODE_SOC;
> +               prop_name = PROP_MSM_ID;
> +               match_values[0] = params->chip_id;
> +               match_values[1] = params->chip_version;
> +               masks[0] = 0xFFFF;
> +               num_match_values = 2;
> +               log_type = "SOC";
> +               break;
> +
> +       case NODE_TYPE_BOARD:
> +               node_name = META_NODE_BOARD;
> +               prop_name = PROP_BOARD_ID;
> +               match_values[0] = params->platform;
> +               log_type = "Board";
> +               break;
> +
> +       case NODE_TYPE_PERIPHERAL:
> +               node_name = META_NODE_BOARD_SUBTYPE_PERIPHERAL;
> +               prop_name = PROP_BOARD_SUBTYPE;
> +               match_values[0] = params->subtype;
> +               log_type = "Peripheral Subtype";
> +               break;
> +
> +       case NODE_TYPE_STORAGE:
> +               node_name = META_NODE_BOARD_SUBTYPE_STORAGE;
> +               prop_name = PROP_BOARD_SUBTYPE;
> +               match_values[0] = params->storage_type;
> +               masks[0] = 0x7000;
> +               shifts[0] = 12;
> +               log_type = "Storage";
> +               break;
> +
> +       case NODE_TYPE_MEMORY:
> +               node_name = META_NODE_BOARD_SUBTYPE_MEMORY;

NAME_MEMORY ?

> +               prop_name = PROP_BOARD_SUBTYPE;
> +               match_values[0] = params->ddr_size_type;
> +               masks[0] = 0xF00;
> +               shifts[0] = 8;
> +               log_type = "Memory";
> +               break;
> +
> +       case NODE_TYPE_SOFTSKU:
> +               node_name = META_NODE_SOFTSKU;
> +               prop_name = PROP_SOFTSKU_ID;
> +               match_values[0] = params->softsku_id;
> +               log_type = "SoftSKU";
> +               break;
> +
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       node_offset = fdt_subnode_offset(metadata, root_offset, node_name);
> +       if (node_offset < 0) {
> +               log_debug("%s node not found\n", log_type);
> +               return node_offset;
> +       }

It would be nice to be able to use the ofnode interface here.

> +
> +       fdt_for_each_subnode(subnode, metadata, node_offset) {
> +               prop = fdt_getprop(metadata, subnode, prop_name, &len);
> +               if (!prop || len < (int)(num_match_values * sizeof(u32)))
> +                       continue;
> +
> +               all_match = true;
> +               for (i = 0; i < num_match_values; i++) {
> +                       u32 dtb_value = fdt32_to_cpu(prop[i]);
> +
> +                       dtb_value = (dtb_value & masks[i]) >> shifts[i];
> +
> +                       if (dtb_value != match_values[i]) {
> +                               all_match = false;
> +                               break;
> +                       }
> +               }
> +
> +               if (!all_match)
> +                       continue;
> +
> +               subnode_name = fdt_get_name(metadata, subnode, &name_len);
> +               if (subnode_name) {
> +                       log_info("Matched %s: %s (", log_type, subnode_name);
> +
> +                       for (i = 0; i < num_match_values; i++) {
> +                               if (i > 0)
> +                                       log_info(", ");
> +                               log_info("val%d=0x%x", i + 1, match_values[i]);
> +                       }
> +
> +                       log_info(")\n");
> +                       return add_to_bucket(subnode_name, name_len, bucket_head);
> +               }
> +       }

Could you put that loop into a separate function? This one is getting very long.

> +
> +       if (fallback) {
> +               log_info("No %s match, using fallback '%s'\n", log_type, fallback);
> +               return add_to_bucket(fallback, strlen(fallback), bucket_head);
> +       }
> +
> +       log_debug("No %s match\n", log_type);

blank line here

> +       return -ENOENT;
> +}
> +
> +/**
> + * qcom_build_bucket_list() - Build bucket list from metadata DTB
> + * @metadata: Metadata DTB pointer
> + * @params: Hardware parameters
> + * @bucket_head: Bucket list head
> + *
> + * This function parses the metadata DTB and builds a list of matching
> + * node names based on the detected hardware parameters.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int qcom_build_bucket_list(void *metadata,
> +                                 struct qcom_hw_params *params,
> +                                 struct list_head *bucket_head)
> +{
> +       int root_offset;
> +       int ret;
> +       struct bucket_node *node;
> +
> +       log_debug("Building bucket list from hardware parameters\n");
> +
> +       root_offset = fdt_path_offset(metadata, "/");
> +       if (root_offset < 0) {
> +               log_err("Failed to find root node in metadata DTB\n");
> +               return root_offset;
> +       }
> +
> +       ret = process_metadata_node(NODE_TYPE_OEM, metadata, root_offset,
> +                                   params, bucket_head);
> +       if (ret < 0 && ret != -ENOENT)
> +               return ret;
> +
> +       ret = process_metadata_node(NODE_TYPE_SOC, metadata, root_offset,
> +                                   params, bucket_head);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = process_metadata_node(NODE_TYPE_BOARD, metadata, root_offset,
> +                                   params, bucket_head);
> +       if (ret < 0)
> +               return ret;
> +
> +       process_metadata_node(NODE_TYPE_PERIPHERAL, metadata, root_offset,
> +                             params, bucket_head);
> +
> +       process_metadata_node(NODE_TYPE_STORAGE, metadata, root_offset,
> +                             params, bucket_head);
> +
> +       process_metadata_node(NODE_TYPE_MEMORY, metadata, root_offset,
> +                             params, bucket_head);
> +
> +       process_metadata_node(NODE_TYPE_SOFTSKU, metadata, root_offset,
> +                             params, bucket_head);
> +
> +       log_debug("Bucket list: ");
> +       list_for_each_entry(node, bucket_head, list)
> +               log_debug("%s ", node->name);
> +       log_debug("\n");
> +
> +       return 0;
> +}
> +
> +/**
> + * qcom_load_fit_image() - Load FIT image from EFI partition
> + * @fit: Pointer to store FIT image address

Returns FIT address on success

> + * @fit_size: Pointer to store FIT image size

Returns FIT size on success

> + *
> + * This function loads qclinux_fit.img from the EFI partition using the
> + * EFI Simple File System Protocol, matching the pattern from efi_fdt.c
> + *
> + * Return: EFI_SUCCESS on success, error code on failure

Shouldn't this return a normal error code? This function perhaps
belongs in EFI code if not.

> + */
> +static efi_status_t qcom_load_fit_image(void **fit, efi_uintn_t *fit_size)

It is nice to put a 'p' on the end of those so it is obvious that they
return a value (fitp, fit_sizep)

> +{
> +       efi_status_t ret;
> +       efi_handle_t *volume_handles = NULL;
> +       efi_uintn_t count;
> +       struct efi_handler *handler;
> +       struct efi_simple_file_system_protocol *v;

vol ? We try to use single chars only for loop / simple pointer variables.

> +       struct efi_file_handle *root = NULL;
> +       struct efi_file_handle *file = NULL;
> +       u16 fit_name[] = u"/qclinux_fit.img";
> +       u32 i;
> +
> +       log_info("%s: Loading FIT image from EFI partition\n", __func__);
> +
> +       ret = efi_locate_handle_buffer_int(BY_PROTOCOL,
> +                                          &efi_simple_file_system_protocol_guid,
> +                                          NULL, &count, &volume_handles);

It looks like this code belongs in an EFI-specific file. Does it
assume that U-Boot is running as an EFI app?

> +       if (ret != EFI_SUCCESS) {
> +               log_err("Failed to locate file system volumes: %lu\n", ret);
> +               return ret;
> +       }
> +
> +       for (i = 0; i < count; i++) {
> +               ret = efi_search_protocol(volume_handles[i],
> +                                         &efi_simple_file_system_protocol_guid,
> +                                         &handler);
> +               if (ret != EFI_SUCCESS)
> +                       continue;
> +
> +               ret = efi_protocol_open(handler, (void **)&v, efi_root, NULL,
> +                                       EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> +               if (ret != EFI_SUCCESS)
> +                       continue;
> +
> +               ret = EFI_CALL(v->open_volume(v, &root));
> +               if (ret != EFI_SUCCESS)
> +                       continue;
> +
> +               ret = EFI_CALL(root->open(root, &file, fit_name,
> +                                         EFI_FILE_MODE_READ, 0));
> +               if (ret == EFI_SUCCESS) {
> +                       log_info("%s: %ls found!\n", __func__, fit_name);
> +                       break;
> +               }
> +
> +               EFI_CALL(root->close(root));
> +               root = NULL;
> +       }
> +
> +       if (!file) {
> +               log_err("FIT image not found on any volume\n");
> +               efi_free_pool(volume_handles);
> +               return EFI_NOT_FOUND;
> +       }
> +
> +       ret = efi_file_size(file, fit_size);
> +       if (ret != EFI_SUCCESS) {
> +               log_err("Failed to get FIT file size: %lu\n", ret);
> +               goto out;
> +       }
> +
> +       log_info("FIT image size: %lu bytes\n", *fit_size);
> +
> +       ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
> +                                EFI_BOOT_SERVICES_DATA,
> +                                efi_size_in_pages(*fit_size),
> +                                (efi_physical_addr_t *)fit);

Should this use malloc()? All of U-Boot's data is boot-services data,
I believe. Or perhaps code.

> +       if (ret != EFI_SUCCESS) {
> +               log_err("Failed to allocate memory for FIT image: %lu\n", ret);
> +               goto out;
> +       }
> +
> +       ret = EFI_CALL(file->read(file, fit_size, *fit));
> +       if (ret != EFI_SUCCESS) {
> +               log_err("Failed to read FIT image: %lu\n", ret);
> +               efi_free_pages((uintptr_t)*fit, efi_size_in_pages(*fit_size));
> +               *fit = NULL;
> +       }
> +
> +out:
> +       if (file)
> +               EFI_CALL(file->close(file));
> +       if (root)
> +               EFI_CALL(root->close(root));
> +       efi_free_pool(volume_handles);
> +
> +       return ret;
> +}
> +
> +/**
> + * qcom_extract_metadata_dtb() - Extract metadata DTB from FIT image
> + * @fit: FIT image pointer
> + * @metadata: Pointer to store metadata DTB address
> + * @metadata_size: Pointer to store metadata DTB size
> + *
> + * The metadata DTB is the first image in the FIT (fdt-0).
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int qcom_extract_metadata_dtb(void *fit, void **metadata,
> +                                    size_t *metadata_size)
> +{
> +       int images_node, first_image;
> +       const void *data;
> +       size_t size;
> +       int ret;
> +
> +       images_node = fdt_path_offset(fit, FIT_IMAGES_PATH);
> +       if (images_node < 0) {
> +               log_err("Cannot find /images node in FIT\n");
> +               return images_node;
> +       }
> +
> +       first_image = fdt_first_subnode(fit, images_node);
> +       if (first_image < 0) {
> +               log_err("Cannot find first image in FIT\n");
> +               return first_image;
> +       }
> +
> +       ret = fit_image_get_data(fit, first_image, &data, &size);
> +       if (ret) {
> +               log_err("Failed to get metadata DTB data\n");
> +               return ret;
> +       }

It would be nice if fit_image_load() could be used here, but it may
not be suitable.

> +
> +       *metadata = malloc(size);
> +       if (!*metadata) {
> +               log_err("Failed to allocate memory for metadata DTB\n");
> +               return -ENOMEM;
> +       }
> +
> +       memcpy(*metadata, data, size);
> +       *metadata_size = size;
> +
> +       log_info("Extracted metadata DTB: %zu bytes\n", size);
> +
> +       return 0;
> +}
> +
> +/**
> + * qcom_find_matching_config() - Find matching FIT configuration
> + * @fit: FIT image pointer
> + * @bucket_head: Bucket list head
> + * @config_node: Pointer to store matching configuration node offset
> + *
> + * This function iterates through all FIT configurations and finds the one
> + * with the most matching tokens in its compatible string.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int qcom_find_matching_config(void *fit, struct list_head *bucket_head,
> +                                    int *config_node)
> +{
> +       int configs_node, cfg;
> +       const char *compatible;
> +       int compat_len;
> +       const char *cfg_name;
> +       int name_len;
> +       int best_match_count = 0;
> +       int best_config = -1;
> +       char *compat_copy;
> +       char *token;
> +       int match_count;
> +
> +       configs_node = fdt_path_offset(fit, FIT_CONFIGURATIONS_PATH);
> +       if (configs_node < 0) {
> +               log_err("Cannot find /configurations node in FIT\n");
> +               return configs_node;
> +       }
> +
> +       fdt_for_each_subnode(cfg, fit, configs_node) {
> +               cfg_name = fdt_get_name(fit, cfg, &name_len);
> +               compatible = fdt_getprop(fit, cfg, PROP_COMPATIBLE, &compat_len);
> +
> +               if (!compatible || compat_len <= 0) {
> +                       log_debug("Config %s has no compatible property\n", cfg_name);
> +                       continue;
> +               }
> +
> +               log_debug("Checking config: %s, compatible: %s\n",
> +                         cfg_name, compatible);
> +
> +               compat_copy = malloc(compat_len + 1);
> +               if (!compat_copy)
> +                       continue;
> +
> +               memcpy(compat_copy, compatible, compat_len);
> +               compat_copy[compat_len] = '\0';
> +
> +               match_count = 0;
> +
> +               /* First split by comma to get vendor prefix (e.g., "qcom") */
> +               token = strtok(compat_copy, ",");
> +               if (token && search_in_bucket(token, bucket_head))
> +                       match_count++;
> +
> +               /* Then split remaining parts by dash */
> +               token = strtok(NULL, "-");
> +               while (token) {
> +                       if (search_in_bucket(token, bucket_head))
> +                               match_count++;
> +                       token = strtok(NULL, "-");
> +               }
> +
> +               free(compat_copy);
> +
> +               log_debug("Config %s: %d matches\n", cfg_name, match_count);
> +
> +               if (match_count > best_match_count) {
> +                       best_match_count = match_count;
> +                       best_config = cfg;
> +               }

This seems to duplicate the logic in fit_conf_find_compat() ?

> +       }
> +
> +       if (best_config < 0) {
> +               log_err("No matching configuration found\n");
> +               return -ENOENT;
> +       }
> +
> +       cfg_name = fdt_get_name(fit, best_config, &name_len);
> +       compatible = fdt_getprop(fit, best_config, PROP_COMPATIBLE, &compat_len);
> +       log_info("Selected configuration: %s (compatible: %s, matches: %d)\n",
> +                cfg_name, compatible, best_match_count);
> +
> +       *config_node = best_config;
> +       return 0;
> +}
> +
> +/**
> + * qcom_load_dtb_with_overlays() - Load DTB and apply overlays
> + * @fit: FIT image pointer
> + * @config_node: Configuration node offset
> + * @final_dtb: Pointer to store final DTB address
> + * @final_dtb_size: Pointer to store final DTB size
> + *
> + * This function loads the base DTB and applies all DTBOs specified in the
> + * configuration's "fdt" property.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int qcom_load_dtb_with_overlays(void *fit, int config_node,
> +                                      void **final_dtb,
> +                                      size_t *final_dtb_size)
> +{
> +       int images_node;
> +       const char *fdt_name;
> +       int fdt_name_len;
> +       int fdt_node;
> +       const void *fdt_data;
> +       size_t fdt_size;
> +       void *base_dtb = NULL;
> +       size_t base_dtb_size = 0;
> +       phys_addr_t dtb_addr;
> +       int i, ret;
> +       int fixups_offset;
> +
> +       images_node = fdt_path_offset(fit, FIT_IMAGES_PATH);
> +       if (images_node < 0)
> +               return images_node;
> +
> +       fdt_name = fdt_stringlist_get(fit, config_node, PROP_FDT, 0, &fdt_name_len);
> +       if (!fdt_name) {
> +               log_err("No fdt property in configuration\n");
> +               return -EINVAL;
> +       }
> +
> +       printf("DTB: %s\n", fdt_name);
> +
> +       fdt_node = fdt_subnode_offset(fit, images_node, fdt_name);
> +       if (fdt_node < 0) {
> +               log_err("Cannot find DTB node: %s\n", fdt_name);
> +               return fdt_node;
> +       }
> +
> +       ret = fit_image_get_data(fit, fdt_node, &fdt_data, &fdt_size);
> +       if (ret) {
> +               log_err("Failed to get DTB data\n");
> +               return ret;
> +       }

This seems to duplicate code above.

> +
> +       /* Allocate base DTB with extra space for overlays using LMB */
> +       base_dtb_size = fdt_size + (8 * 1024); /* Add 8KB for overlays */
> +       ret = lmb_alloc(base_dtb_size, &dtb_addr);

Shouldn't this use malloc()? lmb is used when relocating / setting up
things to pass to the OS.

> +       if (ret) {
> +               log_err("Failed to allocate LMB memory for base DTB: %zu bytes\n", base_dtb_size);
> +               return -ENOMEM;
> +       }
> +       base_dtb = (void *)dtb_addr;
> +
> +       memcpy(base_dtb, fdt_data, fdt_size);
> +       ret = fdt_open_into(base_dtb, base_dtb, base_dtb_size);
> +       if (ret) {
> +               log_err("Failed to open DTB: %d\n", ret);
> +               return ret;
> +       }
> +
> +       /* Apply overlays (remaining fdt entries) */
> +       for (i = 1; ; i++) {
> +               fdt_name = fdt_stringlist_get(fit, config_node, PROP_FDT, i,
> +                                             &fdt_name_len);
> +               if (!fdt_name)
> +                       break;
> +
> +               log_info("Applying overlay: %s\n", fdt_name);
> +
> +               fdt_node = fdt_subnode_offset(fit, images_node, fdt_name);
> +               if (fdt_node < 0) {
> +                       log_err("Cannot find overlay node: %s\n", fdt_name);
> +                       continue;
> +               }
> +
> +               ret = fit_image_get_data(fit, fdt_node, &fdt_data, &fdt_size);
> +               if (ret) {
> +                       log_err("Failed to get overlay data\n");
> +                       continue;
> +               }
> +
> +               fixups_offset = fdt_path_offset(fdt_data, "/__fixups__");
> +               if (fixups_offset == -FDT_ERR_NOTFOUND) {
> +                       log_warning("%s is not a valid overlay (no __fixups__)\n", fdt_name);
> +                       continue;
> +               }
> +
> +               ret = fdt_overlay_apply_verbose(base_dtb, (void *)fdt_data);
> +               if (ret)
> +                       log_err("Failed to apply overlay %s: %d\n", fdt_name, ret);
> +       }

Can you use the existing overlay-creation code?

> +
> +       ret = fdt_pack(base_dtb);
> +       if (ret) {
> +               log_err("Failed to pack DTB: %d\n", ret);
> +               return ret;
> +       }
> +
> +       *final_dtb = base_dtb;
> +       *final_dtb_size = fdt_totalsize(base_dtb);
> +
> +       log_info("Final DTB size: %zu bytes\n", *final_dtb_size);
> +
> +       return 0;
> +}
> +
> +/**
> + * qcom_fit_multidtb_setup() - Main entry point for FIT multi-DTB selection
> + *
> + * This is the main function that orchestrates the entire DTB selection process:
> + * 1. Load qclinux_fit.img from EFI partition
> + * 2. Extract metadata DTB
> + * 3. Detect hardware parameters from SMEM
> + * 4. Build bucket list from metadata
> + * 5. Find matching FIT configuration
> + * 6. Load DTB and apply overlays
> + * 7. Install FDT for EFI
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +int qcom_fit_multidtb_setup(void)
> +{
> +       void *fit = NULL;
> +       efi_uintn_t fit_size = 0;
> +       void *metadata = NULL;
> +       size_t metadata_size = 0;
> +       struct qcom_hw_params hw_params;
> +       LIST_HEAD(bucket_list);
> +       int config_node;
> +       void *final_dtb = NULL;
> +       size_t final_dtb_size = 0;
> +       efi_status_t efi_ret;
> +       int ret;
> +
> +       log_debug("=== FIT Multi-DTB Selection ===\n");
> +
> +       log_debug("Loading FIT image\n");
> +       efi_ret = qcom_load_fit_image(&fit, &fit_size);
> +       if (efi_ret != EFI_SUCCESS) {
> +               log_err("Failed to load FIT image\n");
> +               ret = -EIO;
> +               goto cleanup_fit;
> +       }
> +
> +       ret = fdt_check_header(fit);
> +       if (ret) {
> +               log_err("Invalid FIT header\n");
> +               ret = -EINVAL;
> +               goto cleanup_fit;
> +       }
> +
> +       ret = fit_check_format(fit, IMAGE_SIZE_INVAL);
> +       if (ret) {
> +               log_err("Invalid FIT format\n");
> +               ret = -EINVAL;
> +               goto cleanup_fit;
> +       }
> +
> +       log_debug("Extracting metadata DTB\n");
> +       ret = qcom_extract_metadata_dtb(fit, &metadata, &metadata_size);
> +       if (ret) {
> +               log_err("Failed to extract metadata DTB\n");
> +               goto cleanup_metadata;
> +       }
> +
> +       log_debug("Detecting hardware parameters\n");
> +       ret = qcom_detect_hardware_params(&hw_params);
> +       if (ret) {
> +               log_err("Failed to detect hardware parameters\n");
> +               goto cleanup_metadata;
> +       }
> +
> +       log_debug("Building bucket list\n");
> +       ret = qcom_build_bucket_list(metadata, &hw_params, &bucket_list);
> +       if (ret) {
> +               log_err("Failed to build bucket list\n");
> +               goto cleanup_bucket;
> +       }
> +
> +       log_debug("Finding matching configuration\n");
> +       ret = qcom_find_matching_config(fit, &bucket_list, &config_node);
> +       if (ret) {
> +               log_err("Failed to find matching configuration\n");
> +               goto cleanup_bucket;
> +       }
> +
> +       log_debug("Loading DTB and applying overlays\n");
> +       ret = qcom_load_dtb_with_overlays(fit, config_node, &final_dtb,
> +                                         &final_dtb_size);
> +       if (ret) {
> +               log_err("Failed to load DTB with overlays\n");
> +               goto cleanup_dtb;
> +       }
> +
> +       log_debug("Setting fdt_addr to selected DTB address\n");
> +
> +       ret = fdt_check_header(final_dtb);
> +       if (ret) {
> +               log_err("Invalid final DTB header: %d\n", ret);
> +               ret = -EINVAL;
> +               goto cleanup_dtb;
> +       }
> +
> +       /* Update fdt_addr environment variable to point to our DTB */
> +       env_set_hex("fdt_addr", (ulong)final_dtb);
> +       log_info("Updated fdt_addr=0x%lx, DTB size=%zu bytes\n", (ulong)final_dtb, final_dtb_size);
> +       log_info("EFI boot flow will use DTB directly from this address\n");
> +
> +       /* Don't free final_dtb - LMB manages memory and EFI boot flow will use it */
> +       final_dtb = NULL;
> +
> +       log_debug("=== FIT Multi-DTB Selection Complete ===\n");

So far as I understand this, it seems to provide a new way to select a
FIT configuration, i.e. bypassing the existing compatible string?
Could it instead produce a compatible string which is then used by the
normal FIT config-matching mechanism?

> +
> +       ret = 0;
> +       goto cleanup_success;
> +
> +cleanup_dtb:
> +       if (ret && final_dtb)
> +               final_dtb = NULL;
> +
> +cleanup_success:
> +cleanup_bucket:
> +       free_bucket_list(&bucket_list);
> +
> +cleanup_metadata:
> +       if (metadata)
> +               free(metadata);
> +
> +cleanup_fit:
> +       if (fit)
> +               efi_free_pages((uintptr_t)fit, efi_size_in_pages(fit_size));
> +
> +       return ret;
> +}
> diff --git a/arch/arm/mach-snapdragon/qcom_fit_multidtb.h b/arch/arm/mach-snapdragon/qcom_fit_multidtb.h
> new file mode 100644
> index 00000000000..fd2d233ec72
> --- /dev/null
> +++ b/arch/arm/mach-snapdragon/qcom_fit_multidtb.h
> @@ -0,0 +1,181 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Qualcomm FIT Multi-DTB Selection
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * This implements automatic DTB selection from FIT images based on hardware
> + * detection via SMEM.
> + */
> +
> +#ifndef __QCOM_FIT_MULTIDTB_H__
> +#define __QCOM_FIT_MULTIDTB_H__
> +
> +#include <linux/types.h>
> +#include <linux/list.h>
> +
> +/* DDR size thresholds (in bytes) */
> +#define MB             (1024 * 1024UL)
> +#define DDR_128MB      (128 * MB)
> +#define DDR_256MB      (256 * MB)
> +#define DDR_512MB      (512 * MB)
> +#define DDR_1024MB     (1024 * MB)
> +#define DDR_2048MB     (2048 * MB)
> +#define DDR_3072MB     (3072 * MB)
> +#define DDR_4096MB     (4096 * MB)

Could use SZ_ macros here

> +
> +/* DDR type enum */
> +enum ddr_type {
> +       DDRTYPE_256MB = 1,
> +       DDRTYPE_512MB,          /* 2 */
> +       DDRTYPE_1024MB,         /* 3 */
> +       DDRTYPE_2048MB,         /* 4 */
> +       DDRTYPE_3072MB,         /* 5 */
> +       DDRTYPE_4096MB,         /* 6 */
> +       DDRTYPE_128MB,          /* 7 */
> +};
> +
> +/* Storage type enum */
> +enum mem_card_type {
> +       UFS = 0,
> +       EMMC = 1,
> +       NAND = 2,
> +       STORAGE_UNKNOWN,
> +};
> +
> +/* Boot device types from shared IMEM */

needs docs

> +enum boot_media_type {
> +       NO_FLASH         = 0,
> +       NOR_FLASH        = 1,
> +       NAND_FLASH       = 2,
> +       ONENAND_FLASH    = 3,
> +       SDC_FLASH        = 4,
> +       MMC_FLASH        = 5,
> +       SPI_FLASH        = 6,
> +       PCIE_FLASHLESS   = 7,
> +       UFS_FLASH        = 8,
> +       RESERVED_0_FLASH = 9,
> +       RESERVED_1_FLASH = 10,
> +       USB_FLASHLESS    = 11
> +};
> +
> +/* Shared IMEM constants */
> +#define BOOT_SHARED_IMEM_MAGIC_NUM    0xC1F8DB40
> +#define BOOT_SHARED_IMEM_VERSION_NUM  0x3
> +#define SCL_IMEM_BASE                 0x14680000
> +#define SHARED_IMEM_SIZE              0x1000      /* 4KB */
> +
> +/* Boot shared IMEM cookie structure */

needs docs

> +struct boot_shared_imem_cookie_type {
> +       u32 shared_imem_magic;
> +       u32 shared_imem_version;
> +       u64 etb_buf_addr;
> +       u64 l2_cache_dump_buff_addr;
> +       u32 a64_pointer_padding;
> +       u32 uefi_ram_dump_magic;
> +       u32 ddr_training_cookie;
> +       u32 abnormal_reset_occurred;
> +       u32 reset_status_register;
> +       u32 rpm_sync_cookie;
> +       u32 debug_config;
> +       u64 boot_log_addr;
> +       u32 boot_log_size;
> +       u32 boot_fail_count;
> +       u32 sbl1_error_type;
> +       u32 uefi_image_magic;
> +       u32 boot_device_type;
> +       u64 boot_devtree_addr;
> +       u64 boot_devtree_size;
> +};
> +
> +/* FDT configuration types */
> +#define FDT_TYPE_DTB   0
> +#define FDT_TYPE_DTBO  1

Use an enum?

> +
> +/* Maximum string lengths */
> +#define MAX_NODE_NAME_LEN  64

Could you use NODE_MAX_NAME_LEN

> +#define MAX_COMPATIBLE_LEN 256

Is this the length of each string, or the entire list? Please add a comment.

> +
> +/**
> + * struct qcom_hw_params - Hardware parameters detected from SMEM
> + * @chip_id: SoC chip ID (from socinfo->id)
> + * @chip_version: SoC version (from socinfo->plat_ver)
> + * @platform: Hardware platform ID (from socinfo->hw_plat)
> + * @subtype: Hardware platform subtype (from socinfo->hw_plat_subtype)
> + * @oem_variant_id: OEM variant ID (from socinfo->oem_variant)
> + * @ddr_size_type: DDR size type (0-10, calculated from RAM partitions)
> + * @storage_type: Storage type (UFS=1, EMMC=2, NAND=3)
> + * @foundry_id: Foundry ID (from socinfo->foundry_id)
> + * @softsku_id: Software SKU ID (if available)
> + *
> + * This structure holds all hardware parameters needed for DTB selection.
> + */
> +struct qcom_hw_params {
> +       u32 chip_id;
> +       u32 chip_version;
> +       u32 platform;
> +       u32 subtype;
> +       u32 oem_variant_id;
> +       u32 ddr_size_type;
> +       u32 storage_type;
> +       u32 foundry_id;
> +       u32 softsku_id;
> +};
> +
> +/**
> + * struct bucket_node - Node in the bucket list
> + * @list: List head for linking nodes
> + * @name: Node name string (e.g., "qcom", "sa8775p-v2", "ride", "ufs", "8gb")

Good to have an example! This could go in doc/

> + *
> + * The bucket list contains all matching node names from the metadata DTB.
> + * These are used to match against FIT configuration compatible strings.
> + */
> +struct bucket_node {
> +       struct list_head list;
> +       char *name;
> +};
> +
> +/**
> + * struct fdt_config_node - FDT configuration entry
> + * @list: List head for linking nodes
> + * @name: FDT image name (e.g., "fdt-base", "fdt-overlay-1")
> + * @type: FDT type (FDT_TYPE_DTB or FDT_TYPE_DTBO)
> + *
> + * This structure represents an entry in the FIT configuration's "fdt" property.

Represents an entry... (we know it is a struct)

> + */
> +struct fdt_config_node {
> +       struct list_head list;
> +       char *name;
> +       u8 type;
> +};
> +
> +/* Node processing types for metadata DTB parsing */
> +enum node_process_type {
> +       NODE_TYPE_OEM,
> +       NODE_TYPE_SOC,
> +       NODE_TYPE_BOARD,
> +       NODE_TYPE_PERIPHERAL,
> +       NODE_TYPE_STORAGE,
> +       NODE_TYPE_MEMORY,
> +       NODE_TYPE_SOFTSKU,
> +};
> +
> +/* Function prototypes */
> +
> +/**
> + * qcom_fit_multidtb_setup() - Main entry point for FIT multi-DTB selection
> + *
> + * This function:
> + * 1. Loads qclinux_fit.img from EFI partition
> + * 2. Extracts metadata DTB
> + * 3. Detects hardware parameters from SMEM
> + * 4. Builds bucket list from metadata
> + * 5. Finds matching FIT configuration
> + * 6. Loads DTB and applies overlays
> + * 7. Installs FDT for EFI

This last part should be done by the 'bootefi' process, I suspect.

> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +int qcom_fit_multidtb_setup(void);
> +
> +#endif /* __QCOM_FIT_MULTIDTB_H__ */
> --
> 2.34.1
>

Regards,
SImon
