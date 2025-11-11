Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 664BFCCFA18
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 08:23:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2DCD83AB4;
	Tue, 11 Nov 2025 09:22:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="na7JeLI9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0620D83B30; Tue, 11 Nov 2025 09:22:58 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2281E83A91
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 09:22:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-8b22a30986fso386626785a.2
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 00:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762849374; x=1763454174; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6L9tSVM5AOdd/LGCuKJDmuYlplmaR7FiU05onLA85Tc=;
 b=na7JeLI9EPF0tm/dEw0IYAR9Y95arOD63I4IGYeYUTtPU8R1dU5wezMdqgZzP3MOzQ
 gd0Nstxb+/WWG2WCP9rzcWg9pRJGJyb54jxQ37GEcmZeh5FeyakMaqXFWOX0Pbh2O08Q
 OA5JTVpB4MzOrmW41b5RL2Dvnfp6kbsz/U+U4txuK3FcbkmtbFES3LvU6ZIpU5X5C4jf
 fy5w/2fk897LyXZOrBpIZGq5Dwj3TwSqS+jYjDc4tIveC6oU+j5jgwJKvkIsuO6Bhxi5
 nfmdoZpldEc7RR1k+8q67TP9lq6XNXlr5J40Cg1uZfJK8JizgADP8+0Uyp1sPC+KAigQ
 qphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762849374; x=1763454174;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6L9tSVM5AOdd/LGCuKJDmuYlplmaR7FiU05onLA85Tc=;
 b=I9EKGvoEK+96NzEZv63njH1nueETuYULt76CPk83rhae81YZCNkHlkdOM31g8eNNp7
 8VGxDfqQZWrWpWgK0wvgVcc5As8WyWQL8o361zG30g+R+ab2KB/hwFqYJQ00iqbPZcqo
 Y2rlHZK4zOLx0954GQ0G2rjHbM6P16sN05C5b/L9YpFUoE1f2fCk7DZIbc6dMS/p0uJF
 ezklDNWo/9mRrbMruiWABR+SfS+zF0F6I4dhdPbtbbzGs1fK3CJEEYvJ2hMV6OeQnYrL
 4fQUu76HoJMjsnvsi4FRP8oVxYTzIhDWIEFOfzIm+QYvbIL5bWCzz1EMa3oYizPM0V0A
 JKYg==
X-Gm-Message-State: AOJu0Yzv+j8wYoYX8Fh95P7EZzq3VyevHSS7w1otF2posXRl7e5qm4ue
 mh7yQPWhhNDTzcvERjPgvuhkwJjx0Bcpb+Y2D5ZXeXm7z06qlC7iNJANGzxspNnR6ucYFSbPglJ
 yUOLb92htBNFSIVVr/6lZCeGi2Rjenr0MYMpbicgWGA==
X-Gm-Gg: ASbGncudS/RgBKHYOT64ZcYzGJACUbjkMSH3VH1n/F5/rxdvMZ7F8ceamEaTWFBHgJ5
 d93kAeTUauPrZaAf3v40VwSIL3PTBKQ5fvCnfnTlkvWBy/iLJ/1LtsorXyKep69k3TXN1/ZaQmH
 nAdiHXQCcIb5ZHviEtK6mMcPH5L7WsFmNWPW1b0CujdgjerBzwOB+uKrzhV3dXrxTMAbtYftzQS
 MELIsW/4fKKydbEEvq4OHIiFutUSKrZHVyP3cROSzPuL66yUfSkZDf/RgolmA==
X-Google-Smtp-Source: AGHT+IEcsOikfR7fT+dFVm2Cy66qEVbNiJmZsYvLq49vZjHyO8pl8yEpJqB6P3focP0D0ti/xMsaaFEWR2szpVNcgAg=
X-Received: by 2002:a05:620a:480a:b0:85c:bb2:ad8c with SMTP id
 af79cd13be357-8b257f50ca2mr1365414985a.74.1762849373866; Tue, 11 Nov 2025
 00:22:53 -0800 (PST)
MIME-Version: 1.0
References: <20250926141351.1755829-1-abdellatif.elkhlifi@arm.com>
 <20250926141351.1755829-10-abdellatif.elkhlifi@arm.com>
In-Reply-To: <20250926141351.1755829-10-abdellatif.elkhlifi@arm.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 11 Nov 2025 13:52:42 +0530
X-Gm-Features: AWmQ_bngAd_4RIGEU1qyccMINrMfdwynDJcYOdpkhD9toQpo8X6WnrogjA80peg
Message-ID: <CADg8p95fUPu3U7mvPu47ZnFP4t_-uU4qVFOyRoQMtAw9whtfXw@mail.gmail.com>
Subject: Re: [PATCH v5 09/24] fwu_arm_psa: Initialize the update agent
To: abdellatif.elkhlifi@arm.com
Cc: u-boot@lists.denx.de, Davidson kumaresan <davidson.kumaresan@arm.com>, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>
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

On Fri, 26 Sept 2025 at 19:44, <abdellatif.elkhlifi@arm.com> wrote:
>
> From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>
> Add the initializations required for the update agent
>
> The aim is adding support for the Trusted Services (aka TS)
> Firmware Update API. This API allows the interaction with
> the FWU services provided by Secure world.
> At U-Boot level, we provide the PSA FWU ABI built on top of the
> FF-A bus to invoke the FWU services in Secure world.
>
> The design is based on the Platform Security Firmware Update
> for the A-profile Arm Architecture specification [1].
>
> In our design, the Secure world is the update agent. U-Boot
> is the update client.
>
> The update agent is initialized as follows:
>
> - Trusted Services FWU SP discovery
> - Setting up the shared buffer between the Normal world (U-Boot) and
>   Secure world (Trusted Services)
> - Notifying FWU SP about the shared buffer
>
> [1]: DEN0118, 1.0 A:
>     https://developer.arm.com/documentation/den0118/latest/
>
> Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> Signed-off-by: Davidson kumaresan <davidson.kumaresan@arm.com>
> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Casey Connolly <casey.connolly@linaro.org>
>
> ---
>
> Changelog of changes:
> ===========================
>
> v5:
>
> * Address kernel-doc warnings
>
> v4:
>
> * Update the function headers in fwu_arm_psa.c to pass kernel-doc tests
>
> v1:
>
> * Add the feature
>
>  MAINTAINERS                   |   7 +
>  include/fwu_arm_psa.h         |  55 +++++++
>  lib/fwu_updates/Kconfig       |  18 +++
>  lib/fwu_updates/Makefile      |   2 +
>  lib/fwu_updates/fwu_arm_psa.c | 263 ++++++++++++++++++++++++++++++++++
>  5 files changed, 345 insertions(+)
>  create mode 100644 include/fwu_arm_psa.h
>  create mode 100644 lib/fwu_updates/fwu_arm_psa.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 92119667618..fdf34c74049 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1227,6 +1227,13 @@ T:       git https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq.git
>  F:     drivers/watchdog/sp805_wdt.c
>  F:     drivers/watchdog/sbsa_gwdt.c
>
> +FWU ARM PSA
> +M:     Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> +M:     Davidson kumaresan <davidson.kumaresan@arm.com>
> +S:     Maintained
> +F:     include/fwu_arm_psa.h
> +F:     lib/fwu_updates/fwu_arm_psa.c
> +
>  FWU Multi Bank Update
>  M:     Sughosh Ganu <sughosh.ganu@linaro.org>
>  S:     Maintained
> diff --git a/include/fwu_arm_psa.h b/include/fwu_arm_psa.h
> new file mode 100644
> index 00000000000..5e1229f3bdb
> --- /dev/null
> +++ b/include/fwu_arm_psa.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2025 Arm Limited and/or its affiliates <open-source-office@arm.com>
> + *
> + * Authors:
> + *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> + *   Davidson kumaresan <davidson.kumaresan@arm.com>
> + */
> +
> +#ifndef __FWU_ARM_PSA_H
> +#define __FWU_ARM_PSA_H
> +
> +#include <linux/bitfield.h>
> +#include <u-boot/uuid.h>
> +
> +#define FWU_BUFFER_PAGES               (1024)
> +
> +/* 4 MB buffer shared with secure world */
> +#define FWU_BUFFER_SIZE                        (FWU_BUFFER_PAGES * EFI_PAGE_SIZE)
> +
> +/* TS UUID string for detecting all SPs  (in big-endian format) */
> +#define ALL_TS_SP_UUID                 "d776cdbd-5e82-5147-3b96-ac4349f8d486"
> +/* In little-endian equivalent to: bdcd76d7-825e-4751-963b-86d4f84943ac */
> +
> +/* TS FWU service UUID string (in big-endian format) */
> +#define TS_FWU_SERVICE_UUID            "38a82368-061b-0e47-7497-fd53fb8bce0c"
> +/* In little-endian equivalent to:  6823a838-1b06-470e-9774-0cce8bfb53fd */
> +
> +#define TS_RPC_MEM_RETRIEVE            (0xff0001)
> +#define TS_RPC_SERVICE_INFO_GET                (0xff0003)
> +#define RPC_SUCCESS                    (0)
> +
> +#define SVC_IFACE_ID_GET_MASK          GENMASK(7, 0)
> +#define GET_SVC_IFACE_ID(x)            \
> +                        ((u8)(FIELD_GET(SVC_IFACE_ID_GET_MASK, (x))))
> +
> +#define HANDLE_MSW_MASK                        GENMASK(63, 32)
> +#define HANDLE_LSW_MASK                        GENMASK(31, 0)
> +#define GET_FWU_BUF_MSW(x)             \
> +                               ((u32)(FIELD_GET(HANDLE_MSW_MASK, (x))))
> +#define GET_FWU_BUF_LSW(x)             \
> +                               ((u32)(FIELD_GET(HANDLE_LSW_MASK, (x))))
> +
> +/**
> + * fwu_agent_init() - Setup the FWU agent
> + * Perform the initializations required to communicate
> + * and use the FWU agent in secure world.
> + * The frontend of the FWU agent is the Trusted Services (aka TS)
> + * FWU SP (aka Secure Partition).
> + *
> + * Return: 0 on success. Otherwise, failure
> + */
> +int fwu_agent_init(void);
> +
> +#endif
> diff --git a/lib/fwu_updates/Kconfig b/lib/fwu_updates/Kconfig
> index a722107c129..cdc96109f0a 100644
> --- a/lib/fwu_updates/Kconfig
> +++ b/lib/fwu_updates/Kconfig
> @@ -46,4 +46,22 @@ config FWU_MDATA_V2
>           metadata structure. This option enables support for FWU
>           Metadata version 2 access.
>
> +config FWU_ARM_PSA
> +       bool "FMP driver for Arm PSA FWU specification"
> +       depends on EFI_CAPSULE_FIRMWARE_MANAGEMENT && \
> +               EFI_CAPSULE_FIRMWARE_RAW && \
> +               ARM_FFA_TRANSPORT && (ARM64 || SANDBOX)
> +       select EFI_CAPSULE_FIRMWARE
> +       help
> +         Select this option if you want to enable firmware management protocol
> +         driver that supports the Arm PSA firmware update specification as
> +         mentioned in https://developer.arm.com/documentation/den0118/a/
> +
> +config FWU_BUFFER_PAGES
> +       int "Number of 4KB pages in the FWU shared buffer"
> +       depends on FWU_ARM_PSA
> +       default 1024
> +       help
> +         This defines the size of the FWU shared buffer used for communication.
> +
>  endif
> diff --git a/lib/fwu_updates/Makefile b/lib/fwu_updates/Makefile
> index 3681bef46cd..ae8e4b27793 100644
> --- a/lib/fwu_updates/Makefile
> +++ b/lib/fwu_updates/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  #
>  # Copyright (c) 2022, Linaro Limited
> +# Copyright 2025 Arm Limited and/or its affiliates <open-source-office@arm.com>
>  #

I don't think adding a single line justifies adding a copyright.

>
>  obj-$(CONFIG_FWU_MULTI_BANK_UPDATE) += fwu.o
> @@ -8,3 +9,4 @@ obj-$(CONFIG_FWU_MDATA_GPT_BLK) += fwu_gpt.o
>  obj-$(CONFIG_FWU_MDATA_MTD) += fwu_mtd.o
>  obj-$(CONFIG_FWU_MDATA_V1) += fwu_v1.o
>  obj-$(CONFIG_FWU_MDATA_V2) += fwu_v2.o
> +obj-$(CONFIG_FWU_ARM_PSA) += fwu_arm_psa.o
> diff --git a/lib/fwu_updates/fwu_arm_psa.c b/lib/fwu_updates/fwu_arm_psa.c
> new file mode 100644
> index 00000000000..8ac53cc9152
> --- /dev/null
> +++ b/lib/fwu_updates/fwu_arm_psa.c
> @@ -0,0 +1,263 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2025 Arm Limited and/or its affiliates <open-source-office@arm.com>
> + *
> + * Authors:
> + *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> + *   Davidson kumaresan <davidson.kumaresan@arm.com>
> + */
> +#include <arm_ffa.h>
> +#include <dm.h>
> +#include <fwu_arm_psa.h>
> +#include <efi_loader.h>
> +#include <fwu.h>
> +#include <log.h>
> +#include <malloc.h>
> +#include <mapmem.h>
> +#include <linux/errno.h>
> +
> +static void *g_fwu_buf;
> +static u64 g_fwu_buf_handle;
> +static u16 g_fwu_sp_id;
> +static struct udevice *g_dev;
> +static u16 g_svc_interface_id;
> +static bool g_fwu_initialized;
> +
> +/**
> + * fwu_discover_ts_sp_id() - Query the FWU partition ID
> + *
> + * Description: Use the FF-A driver to get the FWU partition ID.
> + * If multiple partitions are found, use the first one.
> + *
> + * Return: 0 on success. Otherwise, failure.
> + */
> +static int fwu_discover_ts_sp_id(void)
> +{
> +       u32 count = 0;
> +       int ret;
> +       u32 i;
> +       struct ffa_partition_desc *descs = NULL;
> +       struct ffa_send_direct_data msg;
> +       struct ffa_partition_uuid fwu_service_uuid = {0};
> +
> +       /* Ask the driver to fill the buffer with the SPs info */
> +
> +       ret = ffa_partition_info_get(g_dev, ALL_TS_SP_UUID, &count, &descs);
> +       if (ret) {
> +               log_err("FWU: Failure in querying partitions (err: %d)\n", ret);
> +               return ret;
> +       }
> +
> +       if (!count) {
> +               log_err("FWU: No Trusted Service partition found\n");
> +               return -ENODATA;
> +       }
> +
> +       if (!descs) {
> +               log_err("FWU: No partitions descriptors filled\n");
> +               return -EINVAL;
> +       }
> +
> +       if (uuid_str_to_le_bin(TS_FWU_SERVICE_UUID,
> +                              (unsigned char *)&fwu_service_uuid)) {
> +               log_err("FWU: invalid FWU SP  UUID\n");
> +               return -EINVAL;
> +       }
> +
> +       for (i = 0; i < count ; i++) {
> +               log_debug("FWU: Enquiring service from SP 0x%x\n",
> +                         descs[i].info.id);
> +
> +               msg.data0 = TS_RPC_SERVICE_INFO_GET;
> +               msg.data1 = fwu_service_uuid.a1;
> +               msg.data2 = fwu_service_uuid.a2;
> +               msg.data3 = fwu_service_uuid.a3;
> +               msg.data4 = fwu_service_uuid.a4;
> +
> +               ret = ffa_sync_send_receive(g_dev, descs[i].info.id, &msg, 0);
> +               if (ret) {
> +                       log_err("FWU: FF-A error for SERVICE_INFO_GET (err: %d)\n",
> +                               ret);
> +                       return ret;
> +               }
> +
> +               if (msg.data0 != TS_RPC_SERVICE_INFO_GET) {
> +                       log_err("FWU: Wrong SERVICE_INFO_GET return: (%lx)\n",
> +                               msg.data0);
> +                       continue;
> +               }
> +
> +               if (msg.data1 == RPC_SUCCESS) {
> +                       g_svc_interface_id = GET_SVC_IFACE_ID(msg.data2);
> +                       g_fwu_sp_id = descs[i].info.id;
> +                       log_debug("FWU: Service interface ID 0x%x found\n",
> +                                 g_svc_interface_id);
> +                       return 0;
> +               }
> +
> +               log_debug("FWU: service not found\n");
> +       }
> +
> +       log_err("FWU: No SP provides the service\n");
> +
> +       return -ENOENT;
> +}
> +
> +/**
> + * fwu_shared_buf_reclaim() - Reclaim the shared communication buffer
> + *
> + * Description: In case of errors, this function can be called to retrieve
> + * the FWU shared buffer.
> + *
> + * Return: 0 on success. Otherwise, failure.
> + */
> +static int fwu_shared_buf_reclaim(void)
> +{
> +       int reclaim_ret;
> +
> +       reclaim_ret = ffa_memory_reclaim(g_dev, g_fwu_buf_handle, 0);
> +       if (reclaim_ret)
> +               log_err("FWU: FF-A memory reclaim failure (err: %d)\n",
> +                       reclaim_ret);
> +       else
> +               log_debug("FWU: Shared buffer reclaimed\n");
> +
> +       free(g_fwu_buf);
> +       g_fwu_buf = NULL;
> +
> +       return reclaim_ret;
> +}
> +
> +/**
> + * fwu_shared_buf_init() - Setup the FWU shared communication buffer
> + *
> + * Description: The communication with the TS FWU SP is based on a buffer shared
> + * between U-Boot and TS FWU SP allocated in normal world and accessed
> + * by both sides. The buffer contains the data exchanged between both sides
> + * such as the payloads data.
> + *
> + * Return: 0 on success. Otherwise, failure.
> + */
> +static int fwu_shared_buf_init(void)
> +{
> +       struct ffa_mem_ops_args args = {0};
> +       struct ffa_mem_region_attributes attrs = {0};
> +       struct ffa_send_direct_data msg;
> +       int ret;
> +
> +       g_fwu_buf = memalign(EFI_PAGE_SIZE, FWU_BUFFER_SIZE);
> +       if (!g_fwu_buf) {
> +               log_err("FWU: Failure to allocate the shared buffer\n");
> +               return -ENOMEM;
> +       }
> +
> +       /* Setting up user arguments */
> +       args.use_txbuf = true;
> +       args.address = g_fwu_buf;
> +       args.pg_cnt = FWU_BUFFER_PAGES;
> +       args.nattrs = 1;
> +       attrs.receiver = g_fwu_sp_id;
> +       attrs.attrs = FFA_MEM_RW;
> +       args.attrs = &attrs;
> +
> +       /* Registering the shared buffer with secure world (Trusted Services) */
> +       ret = ffa_memory_share(g_dev, &args);
> +       if (ret) {
> +               free(g_fwu_buf);
> +               g_fwu_buf = NULL;
> +               log_err("FWU: Failure setting up the shared buffer (err: %d)\n",
> +                       ret);
> +               return ret;
> +       }
> +
> +       g_fwu_buf_handle = args.g_handle;
> +
> +       log_debug("FWU: shared buffer handle 0x%llx\n", g_fwu_buf_handle);
> +
> +       /* Inform the FWU SP know about the shared buffer */
> +
> +       msg.data0 = TS_RPC_MEM_RETRIEVE;
> +       msg.data1 = GET_FWU_BUF_LSW(g_fwu_buf_handle);
> +       msg.data2 = GET_FWU_BUF_MSW(g_fwu_buf_handle);
> +
> +       ret = ffa_sync_send_receive(g_dev, g_fwu_sp_id, &msg, 0);
> +       if (ret) {
> +               log_err("FWU: FF-A message error for MEM_RETRIEVE (err: %d)\n",
> +                       ret);
> +               goto failure;
> +       }
> +
> +       if (msg.data0 != TS_RPC_MEM_RETRIEVE) {
> +               log_err("FWU: Unexpected MEM_RETRIEVE return: (%lx)\n",
> +                       msg.data0);
> +               ret = -EINVAL;
> +               goto failure;
> +       }
> +
> +       if (msg.data1 != RPC_SUCCESS) {
> +               log_err("FWU: MEM_RETRIEVE failed\n");
> +               ret = -EOPNOTSUPP;
> +               goto failure;
> +       }
> +
> +       log_debug("FWU: MEM_RETRIEVE success for SP 0x%x\n", g_fwu_sp_id);
> +
> +       return 0;
> +
> +failure:
> +       fwu_shared_buf_reclaim();
> +       return ret;
> +}
> +
> +/**
> + * fwu_agent_init() - Setup the FWU agent
> + *
> + * Description: Perform the initializations required to communicate
> + * and use the FWU agent in secure world.
> + * The frontend of the FWU agent is the Trusted Services (aka TS)
> + * FWU SP (aka Secure Partition).
> + *
> + * Return: 0 on success. Otherwise, failure.
> + */
> +int fwu_agent_init(void)
> +{
> +       int ret;
> +       struct fwu_data *fwu_data;
> +       u32 active_idx;
> +
> +       fwu_data = fwu_get_data();
> +       if (!fwu_data) {
> +               log_err("FWU: Cannot get FWU data\n");
> +               return -EINVAL;
> +       }

Why are you calling this function?

> +
> +       ret = fwu_get_active_index(&active_idx);
> +       if (ret) {
> +               log_err("FWU: Failed to read boot index, err (%d)\n",
> +                       ret);
> +               return ret;
> +       }

Same here. Why is this function being called when U-Boot is a update client?

-sughosh

> +
> +       if (fwu_data->trial_state)
> +               log_info("FWU: System booting in Trial State\n");
> +       else
> +               log_info("FWU: System booting in Regular State\n");
> +
> +       ret = uclass_first_device_err(UCLASS_FFA, &g_dev);
> +       if (ret) {
> +               log_err("FWU: Cannot find FF-A bus device, err (%d)\n", ret);
> +               return ret;
> +       }
> +
> +       ret = fwu_discover_ts_sp_id();
> +       if (ret)
> +               return ret;
> +
> +       ret = fwu_shared_buf_init();
> +       if (ret)
> +               return ret;
> +
> +       g_fwu_initialized = true;
> +
> +       return 0;
> +}
> --
> 2.43.0
>
