Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E62FE77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 15:31:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59790801E8;
	Tue,  7 Jan 2025 16:31:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZBeW53T9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1071801C3; Tue,  7 Jan 2025 16:31:29 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44AB2806A7
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 16:31:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2165448243fso32414905ad.1
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 07:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736263883; x=1736868683; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uSNar2F3eLa+eGmutj8GYVieSLyYbGDtdEeh8x2uLIE=;
 b=ZBeW53T9oKu4W2mCToBhaMdjsO2lretoUhfI39N6dnG4xc+t0iYwLCAfol29k1JcSH
 FSREheZWH14fuCMbbCiMpvNNdS8F+2ju68uDoF+bZ8Bhjv5jPZoXp0mGC0X3FMBfjcWK
 c4DCgAj+8rtMAR6fL06oxX7PB5PX8L3xqdjMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736263883; x=1736868683;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uSNar2F3eLa+eGmutj8GYVieSLyYbGDtdEeh8x2uLIE=;
 b=sI42aI/M68sUBhaRLDEfWeyDtN3Um1yO1RY/nSLBU2lisUqLsFD61UgtpNCxCRWx6p
 cHj8eN5dEaye0UE7R4Rf5zZrtgSjqdDkiSJUIu9S4WiBE2n5TmEt8ytkODkB29nnaDdu
 saMBt9XYO1/tkYbBWv74mnBeOAsDw8olDtdDpy1QV4nfO1GgvQHswf2JYgqhmXb7/f47
 i1j6oLigOsmpqC+SQPKO6uK6xlrTqPeo9NxhP0PM3nbHH+jxy3MLz6cYUkTow8ueDfq5
 H2stNpoGrvM+eXgedH1W/x2T5RDmod8harimNAN62h30XA6A2wDga8FhmvHYQbbF+KDj
 oyxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvqDNfr04gBRayGsg+uUI9zG3GDQEOwW1XoEcG0v8Z2orHn2gQY5oFR1m14R4nX7v/oeiSdLI=@lists.denx.de
X-Gm-Message-State: AOJu0Yx9epo5FyeKNOOR12cLpGo+PJd3qIwlC1TZKkPD4HS3KrKGQsQL
 369gXxY5MJ7FC2Ne8eXdn8Gs6olRnSamERscsIBkFWy5UXrMACsQQA9EFsIr13A+4Emg90PC2XH
 VjzKxOZx0yc0+DVULZRsJVzv5lZQEql+nDLDj
X-Gm-Gg: ASbGncsYnQIhPzxEoo5NaagZjkgoGr37iMnAqWZJDmht1gPh9j3HOQR29wk7Kr2/j67
 H/01dxhvfVXAJg6mU4lb/WSldCi4dwvb72/+u1bw=
X-Google-Smtp-Source: AGHT+IE0D11lrouY8hiBmFBG1U5w3whBpOtqOpjFZ/1z1e/F4rMwdTU/4T/kFl2lx13C31UnVjyIwbk1pmFr03uc4X8=
X-Received: by 2002:a17:90a:e18f:b0:2ee:c291:765a with SMTP id
 98e67ed59e1d1-2f452debd4fmr103866404a91.8.1736263882487; Tue, 07 Jan 2025
 07:31:22 -0800 (PST)
MIME-Version: 1.0
References: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
 <20241124-b4-modernise-smem-v1-7-b7852c11b67c@linaro.org>
In-Reply-To: <20241124-b4-modernise-smem-v1-7-b7852c11b67c@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Jan 2025 08:30:37 -0700
X-Gm-Features: AbW1kvZ5Enn7R_qJn7QyVqXQtA6Hiav9RnuCoYrdH8xgiRXyVoQaHD7UMcpS9Sk
Message-ID: <CAFLszTjyvVu2erS-AfAd9OFYL9L=GPxmSEUS-NtGuyNjQmO++Q@mail.gmail.com>
Subject: Re: [PATCH 07/15] soc: qcom: smem: adjust for U-Boot
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Mario Six <mario.six@gdsys.cc>, u-boot@lists.denx.de, u-boot-qcom@groups.io
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

Hi Caleb,

On Sun, 24 Nov 2024 at 12:17, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Port over the smem code to U-Boot and remove socinfo.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/soc/qcom/smem.c | 320 +++++++++---------------------------------------
>  include/soc/qcom/smem.h |   9 +-
>  2 files changed, 63 insertions(+), 266 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

I'd really rather have static inlines for the semaphores and locks,
rather than changing the code. This is changing more a quarter of the
code in the C file. Can you take a look?

Also note that in U-Boot, header files need comments. Is that
permitted in Linux?

Regards,
Simon


>
> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> index 7143856e85c3..5166f289dfb6 100644
> --- a/drivers/soc/qcom/smem.c
> +++ b/drivers/soc/qcom/smem.c
> @@ -3,17 +3,18 @@
>   * Copyright (c) 2015, Sony Mobile Communications AB.
>   * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
>   */
>
> +#define pr_fmt(fmt) "smem: " fmt
> +
>  #include <dm/device.h>
>  #include <dm/device_compat.h>
>  #include <dm/ofnode.h>
>  #include <linux/bug.h>
>  #include <linux/io.h>
>  #include <linux/ioport.h>
>  #include <linux/sizes.h>
>  #include <soc/qcom/smem.h>
> -#include <soc/qcom/socinfo.h>
>
>  /*
>   * The Qualcomm shared memory system is a allocate only heap structure that
>   * consists of one of more memory areas that can be accessed by the processors
> @@ -260,31 +261,23 @@ struct smem_region {
>  };
>
>  /**
>   * struct qcom_smem - device data for the smem device
> - * @dev:       device pointer
> - * @hwlock:    reference to a hwspinlock
>   * @ptable: virtual base of partition table
>   * @global_partition: describes for global partition when in use
>   * @partitions: list of partitions of current processor/host
>   * @item_count: max accepted item number
> - * @socinfo:   platform device pointer
>   * @num_regions: number of @regions
>   * @regions:   list of the memory regions defining the shared memory
>   */
>  struct qcom_smem {
> -       struct device *dev;
> -
> -       struct hwspinlock *hwlock;
> -
>         u32 item_count;
> -       struct platform_device *socinfo;
>         struct smem_ptable *ptable;
>         struct smem_partition global_partition;
>         struct smem_partition partitions[SMEM_HOST_COUNT];
>
>         unsigned num_regions;
> -       struct smem_region regions[] __counted_by(num_regions);
> +       struct smem_region regions[];
>  };
>
>  static void *
>  phdr_to_last_uncached_entry(struct smem_partition_header *phdr)
> @@ -351,38 +344,9 @@ static void *cached_entry_to_item(struct smem_private_entry *e)
>         return p - le32_to_cpu(e->size);
>  }
>
>  /* Pointer to the one and only smem handle */
> -static struct qcom_smem *__smem;
> -
> -/* Timeout (ms) for the trylock of remote spinlocks */
> -#define HWSPINLOCK_TIMEOUT     1000
> -
> -/* The qcom hwspinlock id is always plus one from the smem host id */
> -#define SMEM_HOST_ID_TO_HWSPINLOCK_ID(__x) ((__x) + 1)
> -
> -/**
> - * qcom_smem_bust_hwspin_lock_by_host() - bust the smem hwspinlock for a host
> - * @host:      remote processor id
> - *
> - * Busts the hwspin_lock for the given smem host id. This helper is intended
> - * for remoteproc drivers that manage remoteprocs with an equivalent smem
> - * driver instance in the remote firmware. Drivers can force a release of the
> - * smem hwspin_lock if the rproc unexpectedly goes into a bad state.
> - *
> - * Context: Process context.
> - *
> - * Returns: 0 on success, otherwise negative errno.
> - */
> -int qcom_smem_bust_hwspin_lock_by_host(unsigned int host)
> -{
> -       /* This function is for remote procs, so ignore SMEM_HOST_APPS */
> -       if (host == SMEM_HOST_APPS || host >= SMEM_HOST_COUNT)
> -               return -EINVAL;
> -
> -       return hwspin_lock_bust(__smem->hwlock, SMEM_HOST_ID_TO_HWSPINLOCK_ID(host));
> -}
> -EXPORT_SYMBOL_GPL(qcom_smem_bust_hwspin_lock_by_host);
> +static struct qcom_smem *__smem __section(".data") = NULL;
>
>  /**
>   * qcom_smem_is_available() - Check if SMEM is available
>   *
> @@ -429,9 +393,9 @@ static int qcom_smem_alloc_private(struct qcom_smem *smem,
>
>         /* Check that we don't grow into the cached region */
>         alloc_size = sizeof(*hdr) + ALIGN(size, 8);
>         if ((void *)hdr + alloc_size > cached) {
> -               dev_err(smem->dev, "Out of memory\n");
> +               log_err("Out of memory\n");
>                 return -ENOSPC;
>         }
>
>         hdr->canary = SMEM_PRIVATE_CANARY;
> @@ -449,9 +413,9 @@ static int qcom_smem_alloc_private(struct qcom_smem *smem,
>         le32_add_cpu(&phdr->offset_free_uncached, alloc_size);
>
>         return 0;
>  bad_canary:
> -       dev_err(smem->dev, "Found invalid canary in hosts %hu:%hu partition\n",
> +       log_err("Found invalid canary in hosts %hu:%hu partition\n",
>                 le16_to_cpu(phdr->host0), le16_to_cpu(phdr->host1));
>
>         return -EINVAL;
>  }
> @@ -500,29 +464,21 @@ static int qcom_smem_alloc_global(struct qcom_smem *smem,
>   */
>  int qcom_smem_alloc(unsigned host, unsigned item, size_t size)
>  {
>         struct smem_partition *part;
> -       unsigned long flags;
>         int ret;
>
>         if (!__smem)
>                 return -EPROBE_DEFER;
>
>         if (item < SMEM_ITEM_LAST_FIXED) {
> -               dev_err(__smem->dev,
> -                       "Rejecting allocation of static entry %d\n", item);
> +               log_err("Rejecting allocation of static entry %d\n", item);
>                 return -EINVAL;
>         }
>
>         if (WARN_ON(item >= __smem->item_count))
>                 return -EINVAL;
>
> -       ret = hwspin_lock_timeout_irqsave(__smem->hwlock,
> -                                         HWSPINLOCK_TIMEOUT,
> -                                         &flags);
> -       if (ret)
> -               return ret;
> -
>         if (host < SMEM_HOST_COUNT && __smem->partitions[host].virt_base) {
>                 part = &__smem->partitions[host];
>                 ret = qcom_smem_alloc_private(__smem, part, item, size);
>         } else if (__smem->global_partition.virt_base) {
> @@ -531,10 +487,8 @@ int qcom_smem_alloc(unsigned host, unsigned item, size_t size)
>         } else {
>                 ret = qcom_smem_alloc_global(__smem, item, size);
>         }
>
> -       hwspin_unlock_irqrestore(__smem->hwlock, &flags);
> -
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(qcom_smem_alloc);
>
> @@ -660,9 +614,9 @@ static void *qcom_smem_get_private(struct qcom_smem *smem,
>
>         return ERR_PTR(-ENOENT);
>
>  invalid_canary:
> -       dev_err(smem->dev, "Found invalid canary in hosts %hu:%hu partition\n",
> +       log_err("Found invalid canary in hosts %hu:%hu partition\n",
>                         le16_to_cpu(phdr->host0), le16_to_cpu(phdr->host1));
>
>         return ERR_PTR(-EINVAL);
>  }
> @@ -796,63 +750,8 @@ phys_addr_t qcom_smem_virt_to_phys(void *p)
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(qcom_smem_virt_to_phys);
>
> -/**
> - * qcom_smem_get_soc_id() - return the SoC ID
> - * @id:        On success, we return the SoC ID here.
> - *
> - * Look up SoC ID from HW/SW build ID and return it.
> - *
> - * Return: 0 on success, negative errno on failure.
> - */
> -int qcom_smem_get_soc_id(u32 *id)
> -{
> -       struct socinfo *info;
> -
> -       info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID, NULL);
> -       if (IS_ERR(info))
> -               return PTR_ERR(info);
> -
> -       *id = __le32_to_cpu(info->id);
> -
> -       return 0;
> -}
> -EXPORT_SYMBOL_GPL(qcom_smem_get_soc_id);
> -
> -/**
> - * qcom_smem_get_feature_code() - return the feature code
> - * @code: On success, return the feature code here.
> - *
> - * Look up the feature code identifier from SMEM and return it.
> - *
> - * Return: 0 on success, negative errno on failure.
> - */
> -int qcom_smem_get_feature_code(u32 *code)
> -{
> -       struct socinfo *info;
> -       u32 raw_code;
> -
> -       info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID, NULL);
> -       if (IS_ERR(info))
> -               return PTR_ERR(info);
> -
> -       /* This only makes sense for socinfo >= 16 */
> -       if (__le32_to_cpu(info->fmt) < SOCINFO_VERSION(0, 16))
> -               return -EOPNOTSUPP;
> -
> -       raw_code = __le32_to_cpu(info->feature_code);
> -
> -       /* Ensure the value makes sense */
> -       if (raw_code > SOCINFO_FC_INT_MAX)
> -               raw_code = SOCINFO_FC_UNKNOWN;
> -
> -       *code = raw_code;
> -
> -       return 0;
> -}
> -EXPORT_SYMBOL_GPL(qcom_smem_get_feature_code);
> -
>  static int qcom_smem_get_sbl_version(struct qcom_smem *smem)
>  {
>         struct smem_header *header;
>         __le32 *versions;
> @@ -873,10 +772,9 @@ static struct smem_ptable *qcom_smem_get_ptable(struct qcom_smem *smem)
>                 return ERR_PTR(-ENOENT);
>
>         version = le32_to_cpu(ptable->version);
>         if (version != 1) {
> -               dev_err(smem->dev,
> -                       "Unsupported partition header version %d\n", version);
> +               log_err("Unsupported partition header version %d\n", version);
>                 return ERR_PTR(-EINVAL);
>         }
>         return ptable;
>  }
> @@ -906,42 +804,42 @@ static struct smem_partition_header *
>  qcom_smem_partition_header(struct qcom_smem *smem,
>                 struct smem_ptable_entry *entry, u16 host0, u16 host1)
>  {
>         struct smem_partition_header *header;
> -       u32 phys_addr;
> +       u64 phys_addr;
>         u32 size;
>
>         phys_addr = smem->regions[0].aux_base + le32_to_cpu(entry->offset);
> -       header = devm_ioremap_wc(smem->dev, phys_addr, le32_to_cpu(entry->size));
> +       header = (void *)phys_addr; // devm_ioremap_wc()
>
>         if (!header)
>                 return NULL;
>
>         if (memcmp(header->magic, SMEM_PART_MAGIC, sizeof(header->magic))) {
> -               dev_err(smem->dev, "bad partition magic %4ph\n", header->magic);
> +               log_err("bad partition magic %4ph\n", header->magic);
>                 return NULL;
>         }
>
>         if (host0 != le16_to_cpu(header->host0)) {
> -               dev_err(smem->dev, "bad host0 (%hu != %hu)\n",
> -                               host0, le16_to_cpu(header->host0));
> +               log_err("bad host0 (%hu != %hu)\n",
> +                       host0, le16_to_cpu(header->host0));
>                 return NULL;
>         }
>         if (host1 != le16_to_cpu(header->host1)) {
> -               dev_err(smem->dev, "bad host1 (%hu != %hu)\n",
> -                               host1, le16_to_cpu(header->host1));
> +               log_err("bad host1 (%hu != %hu)\n",
> +                       host1, le16_to_cpu(header->host1));
>                 return NULL;
>         }
>
>         size = le32_to_cpu(header->size);
>         if (size != le32_to_cpu(entry->size)) {
> -               dev_err(smem->dev, "bad partition size (%u != %u)\n",
> +               log_err("bad partition size (%u != %u)\n",
>                         size, le32_to_cpu(entry->size));
>                 return NULL;
>         }
>
>         if (le32_to_cpu(header->offset_free_uncached) > size) {
> -               dev_err(smem->dev, "bad partition free uncached (%u > %u)\n",
> +               log_err("bad partition free uncached (%u > %u)\n",
>                         le32_to_cpu(header->offset_free_uncached), size);
>                 return NULL;
>         }
>
> @@ -956,9 +854,9 @@ static int qcom_smem_set_global_partition(struct qcom_smem *smem)
>         bool found = false;
>         int i;
>
>         if (smem->global_partition.virt_base) {
> -               dev_err(smem->dev, "Already found the global partition\n");
> +               log_err("Already found the global partition\n");
>                 return -EINVAL;
>         }
>
>         ptable = qcom_smem_get_ptable(smem);
> @@ -981,9 +879,9 @@ static int qcom_smem_set_global_partition(struct qcom_smem *smem)
>                 }
>         }
>
>         if (!found) {
> -               dev_err(smem->dev, "Missing entry for global partition\n");
> +               log_err("Missing entry for global partition\n");
>                 return -EINVAL;
>         }
>
>         header = qcom_smem_partition_header(smem, entry,
> @@ -1030,14 +928,14 @@ qcom_smem_enumerate_partitions(struct qcom_smem *smem, u16 local_host)
>                 else
>                         continue;
>
>                 if (remote_host >= SMEM_HOST_COUNT) {
> -                       dev_err(smem->dev, "bad host %u\n", remote_host);
> +                       log_err("bad host %u\n", remote_host);
>                         return -EINVAL;
>                 }
>
>                 if (smem->partitions[remote_host].virt_base) {
> -                       dev_err(smem->dev, "duplicate host %u\n", remote_host);
> +                       log_err("duplicate host %u\n", remote_host);
>                         return -EINVAL;
>                 }
>
>                 header = qcom_smem_partition_header(smem, entry, host0, host1);
> @@ -1058,12 +956,12 @@ static int qcom_smem_map_toc(struct qcom_smem *smem, struct smem_region *region)
>  {
>         u32 ptable_start;
>
>         /* map starting 4K for smem header */
> -       region->virt_base = devm_ioremap_wc(smem->dev, region->aux_base, SZ_4K);
> +       region->virt_base = (void *)region->aux_base;
>         ptable_start = region->aux_base + region->size - SZ_4K;
>         /* map last 4k for toc */
> -       smem->ptable = devm_ioremap_wc(smem->dev, ptable_start, SZ_4K);
> +       smem->ptable = (struct smem_ptable *)(u64)ptable_start;
>
>         if (!region->virt_base || !smem->ptable)
>                 return -ENOMEM;
>
> @@ -1071,54 +969,29 @@ static int qcom_smem_map_toc(struct qcom_smem *smem, struct smem_region *region)
>  }
>
>  static int qcom_smem_map_global(struct qcom_smem *smem, u32 size)
>  {
> -       u32 phys_addr;
> +       u64 phys_addr;
>
>         phys_addr = smem->regions[0].aux_base;
>
>         smem->regions[0].size = size;
> -       smem->regions[0].virt_base = devm_ioremap_wc(smem->dev, phys_addr, size);
> +       smem->regions[0].virt_base = (void *)phys_addr;
>
>         if (!smem->regions[0].virt_base)
>                 return -ENOMEM;
>
>         return 0;
>  }
>
> -static int qcom_smem_resolve_mem(struct qcom_smem *smem, const char *name,
> -                                struct smem_region *region)
> -{
> -       struct device *dev = smem->dev;
> -       struct device_node *np;
> -       struct resource r;
> -       int ret;
> -
> -       np = of_parse_phandle(dev->of_node, name, 0);
> -       if (!np) {
> -               dev_err(dev, "No %s specified\n", name);
> -               return -EINVAL;
> -       }
> -
> -       ret = of_address_to_resource(np, 0, &r);
> -       of_node_put(np);
> -       if (ret)
> -               return ret;
> -
> -       region->aux_base = r.start;
> -       region->size = resource_size(&r);
> -
> -       return 0;
> -}
> -
> -static int qcom_smem_probe(struct platform_device *pdev)
> +int qcom_smem_init(void)
>  {
>         struct smem_header *header;
> -       struct reserved_mem *rmem;
>         struct qcom_smem *smem;
> -       unsigned long flags;
>         int num_regions;
> -       int hwlock_id;
> +       fdt_size_t reg_size = 0;
> +       u32 phandle;
> +       ofnode node, mem_node;
>         u32 version;
>         u32 size;
>         int ret;
>         int i;
> @@ -1126,85 +999,58 @@ static int qcom_smem_probe(struct platform_device *pdev)
>         if (__smem)
>                 return 0;
>
>         num_regions = 1;
> -       if (of_property_present(pdev->dev.of_node, "qcom,rpm-msg-ram"))
> -               num_regions++;
>
> -       smem = devm_kzalloc(&pdev->dev, struct_size(smem, regions, num_regions),
> +       node = ofnode_by_compatible(ofnode_root(), "qcom,smem");
> +       if (!ofnode_valid(node))
> +               return -ENODEV;
> +
> +       if (ofnode_has_property(node, "memory-region")) {
> +               ofnode_read_u32(node, "memory-region", &phandle);
> +               mem_node = ofnode_get_by_phandle(phandle);
> +       } else {
> +               mem_node = node;
> +       }
> +
> +       smem = kzalloc(sizeof(struct smem_region) * num_regions +
> +                      sizeof(struct qcom_smem),
>                             GFP_KERNEL);
> -       if (!smem)
> +       if (!smem) {
> +               log_err("Failed to allocate memory for smem\n");
>                 return -ENOMEM;
> +       }
>
> -       smem->dev = &pdev->dev;
>         smem->num_regions = num_regions;
>
> -       rmem = of_reserved_mem_lookup(pdev->dev.of_node);
> -       if (rmem) {
> -               smem->regions[0].aux_base = rmem->base;
> -               smem->regions[0].size = rmem->size;
> -       } else {
> -               /*
> -                * Fall back to the memory-region reference, if we're not a
> -                * reserved-memory node.
> -                */
> -               ret = qcom_smem_resolve_mem(smem, "memory-region", &smem->regions[0]);
> -               if (ret)
> -                       return ret;
> +       smem->regions[0].aux_base = ofnode_get_addr(mem_node);
> +       reg_size = ofnode_get_size(mem_node);
> +       if (smem->regions[0].aux_base == FDT_ADDR_T_NONE) {
> +               log_err("Failed to get base address\n");
> +               return -EINVAL;
>         }
> -
> -       if (num_regions > 1) {
> -               ret = qcom_smem_resolve_mem(smem, "qcom,rpm-msg-ram", &smem->regions[1]);
> -               if (ret)
> -                       return ret;
> -       }
> -
> +       smem->regions[0].size = reg_size;
>
>         ret = qcom_smem_map_toc(smem, &smem->regions[0]);
> -       if (ret)
> +       if (ret) {
> +               log_err("Failed to map toc\n");
>                 return ret;
> +       }
>
>         for (i = 1; i < num_regions; i++) {
> -               smem->regions[i].virt_base = devm_ioremap_wc(&pdev->dev,
> -                                                            smem->regions[i].aux_base,
> -                                                            smem->regions[i].size);
> -               if (!smem->regions[i].virt_base) {
> -                       dev_err(&pdev->dev, "failed to remap %pa\n", &smem->regions[i].aux_base);
> -                       return -ENOMEM;
> -               }
> +               smem->regions[i].virt_base = (void *)smem->regions[i].aux_base;
>         }
>
>         header = smem->regions[0].virt_base;
>         if (le32_to_cpu(header->initialized) != 1 ||
>             le32_to_cpu(header->reserved)) {
> -               dev_err(&pdev->dev, "SMEM is not initialized by SBL\n");
> +               log_err("SMEM is not initialized by SBL\n");
>                 return -EINVAL;
>         }
>
> -       hwlock_id = of_hwspin_lock_get_id(pdev->dev.of_node, 0);
> -       if (hwlock_id < 0) {
> -               if (hwlock_id != -EPROBE_DEFER)
> -                       dev_err(&pdev->dev, "failed to retrieve hwlock\n");
> -               return hwlock_id;
> -       }
> -
> -       smem->hwlock = hwspin_lock_request_specific(hwlock_id);
> -       if (!smem->hwlock)
> -               return -ENXIO;
> -
> -       ret = hwspin_lock_timeout_irqsave(smem->hwlock, HWSPINLOCK_TIMEOUT, &flags);
> -       if (ret)
> -               return ret;
>         size = readl_relaxed(&header->available) + readl_relaxed(&header->free_offset);
> -       hwspin_unlock_irqrestore(smem->hwlock, &flags);
>
>         version = qcom_smem_get_sbl_version(smem);
> -       /*
> -        * smem header mapping is required only in heap version scheme, so unmap
> -        * it here. It will be remapped in qcom_smem_map_global() when whole
> -        * partition is mapped again.
> -        */
> -       devm_iounmap(smem->dev, smem->regions[0].virt_base);
>         switch (version >> 16) {
>         case SMEM_GLOBAL_PART_VERSION:
>                 ret = qcom_smem_set_global_partition(smem);
>                 if (ret < 0)
> @@ -1215,63 +1061,19 @@ static int qcom_smem_probe(struct platform_device *pdev)
>                 qcom_smem_map_global(smem, size);
>                 smem->item_count = SMEM_ITEM_COUNT;
>                 break;
>         default:
> -               dev_err(&pdev->dev, "Unsupported SMEM version 0x%x\n", version);
> +               log_err("Unsupported SMEM version 0x%x\n", version);
>                 return -EINVAL;
>         }
>
>         BUILD_BUG_ON(SMEM_HOST_APPS >= SMEM_HOST_COUNT);
>         ret = qcom_smem_enumerate_partitions(smem, SMEM_HOST_APPS);
> -       if (ret < 0 && ret != -ENOENT)
> +       if (ret < 0 && ret != -ENOENT) {
> +               log_err("Failed to enumerate partitions\n");
>                 return ret;
> +       }
>
>         __smem = smem;
>
> -       smem->socinfo = platform_device_register_data(&pdev->dev, "qcom-socinfo",
> -                                                     PLATFORM_DEVID_NONE, NULL,
> -                                                     0);
> -       if (IS_ERR(smem->socinfo))
> -               dev_dbg(&pdev->dev, "failed to register socinfo device\n");
> -
>         return 0;
>  }
> -
> -static void qcom_smem_remove(struct platform_device *pdev)
> -{
> -       platform_device_unregister(__smem->socinfo);
> -
> -       hwspin_lock_free(__smem->hwlock);
> -       __smem = NULL;
> -}
> -
> -static const struct of_device_id qcom_smem_of_match[] = {
> -       { .compatible = "qcom,smem" },
> -       {}
> -};
> -MODULE_DEVICE_TABLE(of, qcom_smem_of_match);
> -
> -static struct platform_driver qcom_smem_driver = {
> -       .probe = qcom_smem_probe,
> -       .remove_new = qcom_smem_remove,
> -       .driver  = {
> -               .name = "qcom-smem",
> -               .of_match_table = qcom_smem_of_match,
> -               .suppress_bind_attrs = true,
> -       },
> -};
> -
> -static int __init qcom_smem_init(void)
> -{
> -       return platform_driver_register(&qcom_smem_driver);
> -}
> -arch_initcall(qcom_smem_init);
> -
> -static void __exit qcom_smem_exit(void)
> -{
> -       platform_driver_unregister(&qcom_smem_driver);
> -}
> -module_exit(qcom_smem_exit)
> -
> -MODULE_AUTHOR("Bjorn Andersson <bjorn.andersson@sonymobile.com>");
> -MODULE_DESCRIPTION("Qualcomm Shared Memory Manager");
> -MODULE_LICENSE("GPL v2");
> diff --git a/include/soc/qcom/smem.h b/include/soc/qcom/smem.h
> index f946e3beca21..a955db08c0f0 100644
> --- a/include/soc/qcom/smem.h
> +++ b/include/soc/qcom/smem.h
> @@ -3,18 +3,13 @@
>  #define __QCOM_SMEM_H__
>
>  #define QCOM_SMEM_HOST_ANY -1
>
> +int qcom_smem_init(void);
> +
>  bool qcom_smem_is_available(void);
>  int qcom_smem_alloc(unsigned host, unsigned item, size_t size);
>  void *qcom_smem_get(unsigned host, unsigned item, size_t *size);
>
>  int qcom_smem_get_free_space(unsigned host);
>
> -phys_addr_t qcom_smem_virt_to_phys(void *p);
> -
> -int qcom_smem_get_soc_id(u32 *id);
> -int qcom_smem_get_feature_code(u32 *code);
> -
> -int qcom_smem_bust_hwspin_lock_by_host(unsigned int host);
> -
>  #endif
>
> --
> 2.47.0
>
