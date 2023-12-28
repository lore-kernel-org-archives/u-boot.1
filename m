Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C44C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 11:04:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EDA4871A7;
	Thu, 28 Dec 2023 12:04:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ICbrWnJQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F11187960; Thu, 28 Dec 2023 12:04:28 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E411686FB5
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 12:04:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ccea7e5899so617291fa.2
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 03:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703761465; x=1704366265; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H9g0rGekO+o8yrsXyS7xdOZOmQM5AK2BA9ZuRGf6jNw=;
 b=ICbrWnJQwLkoTqIE/Zg1qvIGCfUFTE6GrC5/b8zERmQuRgx8zApOp+1r1FeNIyue83
 qfLxwKJdo4sZfcvnRUfuQxwEHzt6r30GJ43HsLbcf6SL9voiJU7NOxgErw72ktQG6Rnr
 iPyW6RKhA3cAJVt7hPmVKKpCObqT5rno03MGh0X6xPAMHDeBIcd3s0QTvVLpkUZ7Vvln
 9Lq2/dFW8saAZLQ4TaRnxQGn7Wp1PZpRyjRpNN07NO2al86eg+fVYm1xF8nYreu1is2D
 +WnhjVimNSiX+tsM/BdxeWVMH+mkcT/ww1SrBEJs33kz9jgLEogGEIe4gpO3P/1z+fBJ
 VRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703761465; x=1704366265;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H9g0rGekO+o8yrsXyS7xdOZOmQM5AK2BA9ZuRGf6jNw=;
 b=RBKkF037fyOJKerLDBdiriu15oJMHRZd5Gz++HJvAdQr/v24HwOiRsP86myk2UeKQF
 94Lc7/c42HEVS0MTF4MRKYbOYHVEKNOuz6PfQTXlkATNjLZsgn9XTvq9IOxm+FoaevkK
 rz8Qdo+DTh8YqQR/Qmkzilky91fHFAk62zRMPHE2eOYVmlKVzuZHnINmgkdJ32K0Jcx0
 MdbfBhp3g5KUnWArczuzksGCL5HkA4X+HfTTsr1FZq7xjDDBU8V03a71j46il4KtmYMk
 6X4P1yvIRhOXnUcWI30zgCsvsCvwDXAjisWSRulQtll+T0CPS7uuq1uDcqD0azSflW18
 VyUA==
X-Gm-Message-State: AOJu0YygQ4EAVsTuvaGaGDJC9anlhRepXdAy+jKV2m9h2k54dd6f/Bhg
 GMqJsM/pNhiLGAmCLwt2QlV08XXMOETVTWoJTQG7exmUuEGbUA==
X-Google-Smtp-Source: AGHT+IEFbr/I7kQQQj/s7SS35Hv1eCvNHmMJktYv+TKxrsHegyskJresbwUGKoN1JTIaQNIzAoVAdDJobbs3m4N7k0g=
X-Received: by 2002:a19:690b:0:b0:50e:39e0:43c1 with SMTP id
 e11-20020a19690b000000b0050e39e043c1mr3636717lfc.8.1703761465114; Thu, 28 Dec
 2023 03:04:25 -0800 (PST)
MIME-Version: 1.0
References: <20231227210712.712937-1-raymond.mao@linaro.org>
 <20231227210712.712937-3-raymond.mao@linaro.org>
In-Reply-To: <20231227210712.712937-3-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 28 Dec 2023 13:03:49 +0200
Message-ID: <CAC_iWjKS6q7nZVh=AbNBDoz+8cwVDH+U-rj3oPS3jqsQcEZRog@mail.gmail.com>
Subject: Re: [PATCH v4 02/12] bloblist: Adjust API to align in powers of 2
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>
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

On Wed, 27 Dec 2023 at 23:07, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> From: Simon Glass <sjg@chromium.org>
>
> The updated bloblist structure stores the alignment as a power-of-two
> value in its structures. Adjust the API to use this, to avoid needing to
> calling ilog2().
> Update the bloblist alignment from 16 bytes to 8 bytes.
> Drop a stale comment while we are here.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> Changes in v2
> - Update the bloblist alignment to align to FW handoff spec v0.9.
> Changes in v4
> - Update the commit message.
>
>  arch/x86/lib/tables.c |  3 ++-
>  common/bloblist.c     | 24 +++++++++++-------------
>  include/bloblist.h    | 12 +++++++-----
>  test/bloblist.c       |  4 ++--
>  4 files changed, 22 insertions(+), 21 deletions(-)
>
> diff --git a/arch/x86/lib/tables.c b/arch/x86/lib/tables.c
> index 5b5070f7ca..d43e77d373 100644
> --- a/arch/x86/lib/tables.c
> +++ b/arch/x86/lib/tables.c
> @@ -16,6 +16,7 @@
>  #include <asm/mpspec.h>
>  #include <asm/tables.h>
>  #include <asm/coreboot_tables.h>
> +#include <linux/log2.h>
>
>  DECLARE_GLOBAL_DATA_PTR;
>
> @@ -104,7 +105,7 @@ int write_tables(void)
>                         if (!gd->arch.table_end)
>                                 gd->arch.table_end = rom_addr;
>                         rom_addr = (ulong)bloblist_add(table->tag, size,
> -                                                      table->align);
> +                                                      ilog2(table->align));
>                         if (!rom_addr)
>                                 return log_msg_ret("bloblist", -ENOBUFS);
>
> diff --git a/common/bloblist.c b/common/bloblist.c
> index 5606487f5b..1e78a3d4b3 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -26,8 +26,6 @@
>   * start address of the data in each blob is aligned as required. Note that
>   * each blob's *data* is aligned to BLOBLIST_ALIGN regardless of the alignment
>   * of the bloblist itself or the blob header.
> - *
> - * So far, only BLOBLIST_ALIGN alignment is supported.
>   */
>
>  DECLARE_GLOBAL_DATA_PTR;
> @@ -128,24 +126,24 @@ static struct bloblist_rec *bloblist_findrec(uint tag)
>         return NULL;
>  }
>
> -static int bloblist_addrec(uint tag, int size, int align,
> +static int bloblist_addrec(uint tag, int size, int align_log2,
>                            struct bloblist_rec **recp)
>  {
>         struct bloblist_hdr *hdr = gd->bloblist;
>         struct bloblist_rec *rec;
>         int data_start, new_alloced;
>
> -       if (!align)
> -               align = BLOBLIST_ALIGN;
> +       if (!align_log2)
> +               align_log2 = BLOBLIST_ALIGN_LOG2;
>
>         /* Figure out where the new data will start */
>         data_start = map_to_sysmem(hdr) + hdr->alloced + sizeof(*rec);
>
>         /* Align the address and then calculate the offset from ->alloced */
> -       data_start = ALIGN(data_start, align) - map_to_sysmem(hdr);
> +       data_start = ALIGN(data_start, 1U << align_log2) - map_to_sysmem(hdr);
>
>         /* Calculate the new allocated total */
> -       new_alloced = data_start + ALIGN(size, align);
> +       new_alloced = data_start + ALIGN(size, 1U << align_log2);
>
>         if (new_alloced > hdr->size) {
>                 log_err("Failed to allocate %x bytes size=%x, need size=%x\n",
> @@ -169,7 +167,7 @@ static int bloblist_addrec(uint tag, int size, int align,
>  }
>
>  static int bloblist_ensurerec(uint tag, struct bloblist_rec **recp, int size,
> -                             int align)
> +                             int align_log2)
>  {
>         struct bloblist_rec *rec;
>
> @@ -182,7 +180,7 @@ static int bloblist_ensurerec(uint tag, struct bloblist_rec **recp, int size,
>         } else {
>                 int ret;
>
> -               ret = bloblist_addrec(tag, size, align, &rec);
> +               ret = bloblist_addrec(tag, size, align_log2, &rec);
>                 if (ret)
>                         return ret;
>         }
> @@ -204,22 +202,22 @@ void *bloblist_find(uint tag, int size)
>         return (void *)rec + rec->hdr_size;
>  }
>
> -void *bloblist_add(uint tag, int size, int align)
> +void *bloblist_add(uint tag, int size, int align_log2)
>  {
>         struct bloblist_rec *rec;
>
> -       if (bloblist_addrec(tag, size, align, &rec))
> +       if (bloblist_addrec(tag, size, align_log2, &rec))
>                 return NULL;
>
>         return (void *)rec + rec->hdr_size;
>  }
>
> -int bloblist_ensure_size(uint tag, int size, int align, void **blobp)
> +int bloblist_ensure_size(uint tag, int size, int align_log2, void **blobp)
>  {
>         struct bloblist_rec *rec;
>         int ret;
>
> -       ret = bloblist_ensurerec(tag, &rec, size, align);
> +       ret = bloblist_ensurerec(tag, &rec, size, align_log2);
>         if (ret)
>                 return ret;
>         *blobp = (void *)rec + rec->hdr_size;
> diff --git a/include/bloblist.h b/include/bloblist.h
> index 92dbfda21b..5ad1337d1f 100644
> --- a/include/bloblist.h
> +++ b/include/bloblist.h
> @@ -76,7 +76,9 @@
>  enum {
>         BLOBLIST_VERSION        = 0,
>         BLOBLIST_MAGIC          = 0xb00757a3,
> -       BLOBLIST_ALIGN          = 16,
> +
> +       BLOBLIST_ALIGN_LOG2     = 3,
> +       BLOBLIST_ALIGN          = 1 << BLOBLIST_ALIGN_LOG2,
>  };
>
>  /* Supported tags - add new ones to tag_name in bloblist.c */
> @@ -254,11 +256,11 @@ void *bloblist_find(uint tag, int size);
>   *
>   * @tag:       Tag to add (enum bloblist_tag_t)
>   * @size:      Size of the blob
> - * @align:     Alignment of the blob (in bytes), 0 for default
> + * @align_log2:        Alignment of the blob (in bytes log2), 0 for default
>   * Return: pointer to the newly added block, or NULL if there is not enough
>   * space for the blob
>   */
> -void *bloblist_add(uint tag, int size, int align);
> +void *bloblist_add(uint tag, int size, int align_log2);
>
>  /**
>   * bloblist_ensure_size() - Find or add a blob
> @@ -268,11 +270,11 @@ void *bloblist_add(uint tag, int size, int align);
>   * @tag:       Tag to add (enum bloblist_tag_t)
>   * @size:      Size of the blob
>   * @blobp:     Returns a pointer to blob on success
> - * @align:     Alignment of the blob (in bytes), 0 for default
> + * @align_log2:        Alignment of the blob (in bytes log2), 0 for default
>   * Return: 0 if OK, -ENOSPC if it is missing and could not be added due to lack
>   * of space, or -ESPIPE it exists but has the wrong size
>   */
> -int bloblist_ensure_size(uint tag, int size, int align, void **blobp);
> +int bloblist_ensure_size(uint tag, int size, int align_log2, void **blobp);
>
>  /**
>   * bloblist_ensure() - Find or add a blob
> diff --git a/test/bloblist.c b/test/bloblist.c
> index efa1e32afd..8b435e27ca 100644
> --- a/test/bloblist.c
> +++ b/test/bloblist.c
> @@ -336,7 +336,7 @@ static int bloblist_test_align(struct unit_test_state *uts)
>
>         /* Check larger alignment */
>         for (i = 0; i < 3; i++) {
> -               int align = 32 << i;
> +               int align = 5 - i;
>
>                 data = bloblist_add(3 + i, i * 4, align);
>                 ut_assertnonnull(data);
> @@ -351,7 +351,7 @@ static int bloblist_test_align(struct unit_test_state *uts)
>         ut_assertok(bloblist_new(TEST_ADDR + BLOBLIST_ALIGN, TEST_BLOBLIST_SIZE,
>                                  0));
>
> -       data = bloblist_add(1, 5, BLOBLIST_ALIGN * 2);
> +       data = bloblist_add(1, 5, BLOBLIST_ALIGN_LOG2 + 1);
>         ut_assertnonnull(data);
>         addr = map_to_sysmem(data);
>         ut_asserteq(0, addr & (BLOBLIST_ALIGN * 2 - 1));
> --
> 2.25.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
