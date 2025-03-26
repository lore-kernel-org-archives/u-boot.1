Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39345C36008
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 08:19:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 659A380756;
	Wed, 26 Mar 2025 09:19:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X2lmPxin";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDC3E808B6; Wed, 26 Mar 2025 09:18:58 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B6128070C
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 09:18:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e46ebe19489so4999435276.2
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 01:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742977134; x=1743581934; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4ewg0AMwmBZjFILerdI0wplmDGaLpX0vpl079LUxqNQ=;
 b=X2lmPxinFmLzTtkN7yCkD6QPmMgJPVNR322INpckRuTAq+pN+AKJoAbt+a+h2kyuaZ
 DLkRthXrfv6bAwlH9JYB0YgpGgiv4xuW3UCKNvATBr56jaCNLSsg+ZKqXcfYAfrZI+Nl
 Dti8QOdBgmQGChgMvEZ9wO6KvlKYpMMmdwOuFReKIbMjfI0KLSwYV3XKvOp8ikgXxvkh
 YGTH6LCuAOqXz1F7zBnyl16uq+k6xIrDHt3dTeonpFLg6HCA4pUDYJotFG7OKxPx/aqF
 alXzWyd4g0W/WhvHbTgZ4e06IBEh9tmLJ+jGHDZ3ce04zDBOYW39OCQBpSF1EEVI2A/2
 TlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742977134; x=1743581934;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4ewg0AMwmBZjFILerdI0wplmDGaLpX0vpl079LUxqNQ=;
 b=Cy/bNST1qKD+ObDjpxq5bwx4TVmOae65axULftyibjojYPHbLeFpg90azgZFWIkqMa
 EXwWko7vucPDwnU/krhYjB0e7w7yruSy1vWmZnVm7cqSNSEOIirHy1E0FMSQROjxxZ9p
 jcZ2kXE6/TXKCzffKgn427RBI+ewJsYuEocb4OmJsfxIqjQn4UsjgVBpr0BeJnp8NpKb
 bu7UAeEtCoLRBZ3ReE8HWY1P4dXi2PgpcrmpwSe+uk6faV0hpfgOkGyBkq1OaPrflmtZ
 v54WbUeCJdv2vPVsyuQTfu/8QFi2isZa1vPHYV4672XppQ4x0ifnlPKleBcnUrWbu9UD
 tUog==
X-Gm-Message-State: AOJu0YzKWjtVA44VaqbTP3rFdbXBVzHARQLZtvhfSxH/m9UlNeBA5Nf3
 sNTdBpQmFMUzsFFgm+tfN8hXnTptYE1m5HWV1Cs5ilikSA+QspfGW8pjvrF1Dye4GH5OtSXEgQH
 LvgCRA1mzdF9l7u+N2UL97PISjj3UlzURu0tqRg==
X-Gm-Gg: ASbGncv652fpJ9STiRz8NBnBRzvkuC9nAelDwiHTvwEKgqpfbekNly5o89M6Xyl8CQn
 BeKXrVFsfd1l0uSXCCGmyplXTiAQOLcCApUf5iV5fTsVIkdyllRWqHTsKgkMka+7gI3NISNR1Py
 1CU8MorBEFJ1NTRvPfg1fT5iGG1wg=
X-Google-Smtp-Source: AGHT+IGD42Hmzpytr6FZ8Ww9Gn+1KoMJ6MgrJ9AaT4xGqf5iNraL3l+rbO6F82njKFOQBH+zNWqss6wWT7sY8+puQRs=
X-Received: by 2002:a05:6902:4806:b0:e5d:c30f:22ec with SMTP id
 3f1490d57ef6-e66a4d3d6e8mr24415357276.9.1742977134049; Wed, 26 Mar 2025
 01:18:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250317083402.412310-1-sughosh.ganu@linaro.org>
 <20250317083402.412310-4-sughosh.ganu@linaro.org>
In-Reply-To: <20250317083402.412310-4-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 26 Mar 2025 10:18:18 +0200
X-Gm-Features: AQ5f1Jp0oEgxzdJIcIDJPmajtpVJz-NcR4VP3onfKnroEPMAj9ePvdqbHChtotM
Message-ID: <CAC_iWj+FsYrus9n9B0=ZBuxOfH_E4m4fZf73q-4LAcq_8Ad84A@mail.gmail.com>
Subject: Re: [PATCH v9 3/8] fdt: add support for adding pmem nodes
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Anton Antonov <Anton.Antonov@arm.com>, 
 Tobias Waldekranz <tobias@waldekranz.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
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

On Mon, 17 Mar 2025 at 10:34, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> From: Masahisa Kojima <kojima.masahisa@socionext.com>
>
> One of the problems an OS may face, when running in EFI, is that
> a mounted ISO, after calling ExitBootServices goes away, if that ISO
> is resident in RAM memory as a ramdisk.
>
> ACPI has NFIT and NVDIMM support to provide ramdisks to the OS, but we
> don't have anything in place for DTs. Linux and device trees have support
> for persistent memory devices. So add a function that can inject a pmem
> node in a DT, so we can pass information on the ramdisk the OS.
>
> Signed-off-by: Masahisa Kojima <kojima.masahisa@socionext.com>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>


Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
> Changes since V8:
> * Re-word the commit message to indicate that the ramdisk information
>   is being passed to the OS through pmem node
> * Change the type of addr and size parameters to the
>   fdt_fixup_pmem_region() as u64
> * Rename the first parameter of fdt_fixup_pmem_region() as fdt instead
>   of blob
> * Modify the format specifier of snprintf() call in
>   fdt_fixup_pmem_region() accordingly
> * Remove pmem_start and pmem_size array variables in
>   fdt_fixup_pmem_region()
> * s/pmem_node/node_name/g
> * Do not initialise node_name variable
>
>  boot/fdt_support.c    | 39 ++++++++++++++++++++++++++++++++++++++-
>  include/fdt_support.h | 14 ++++++++++++++
>  2 files changed, 52 insertions(+), 1 deletion(-)
>
> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> index 49efeec3681..92f2f534ee0 100644
> --- a/boot/fdt_support.c
> +++ b/boot/fdt_support.c
> @@ -18,6 +18,7 @@
>  #include <dm/ofnode.h>
>  #include <linux/ctype.h>
>  #include <linux/types.h>
> +#include <linux/sizes.h>
>  #include <asm/global_data.h>
>  #include <asm/unaligned.h>
>  #include <linux/libfdt.h>
> @@ -464,7 +465,6 @@ void do_fixup_by_compat_u32(void *fdt, const char *compat,
>         do_fixup_by_compat(fdt, compat, prop, &tmp, 4, create);
>  }
>
> -#ifdef CONFIG_ARCH_FIXUP_FDT_MEMORY
>  /*
>   * fdt_pack_reg - pack address and size array into the "reg"-suitable stream
>   */
> @@ -493,6 +493,7 @@ static int fdt_pack_reg(const void *fdt, void *buf, u64 *address, u64 *size,
>         return p - (char *)buf;
>  }
>
> +#ifdef CONFIG_ARCH_FIXUP_FDT_MEMORY
>  #if CONFIG_NR_DRAM_BANKS > 4
>  #define MEMORY_BANKS_MAX CONFIG_NR_DRAM_BANKS
>  #else
> @@ -2222,3 +2223,39 @@ int fdt_valid(struct fdt_header **blobp)
>         }
>         return 1;
>  }
> +
> +int fdt_fixup_pmem_region(void *fdt, u64 pmem_start, u64 pmem_size)
> +{
> +       char node_name[32];
> +       int nodeoffset, len;
> +       int err;
> +       u8 tmp[4 * 16]; /* Up to 64-bit address + 64-bit size */
> +
> +       if (!IS_ALIGNED(pmem_start, SZ_2M) ||
> +           !IS_ALIGNED(pmem_start + pmem_size, SZ_2M)) {
> +               printf("Start and end address must be 2MiB aligned\n");
> +               return -1;
> +       }
> +
> +       snprintf(node_name, sizeof(node_name), "pmem@%llx", pmem_start);
> +       nodeoffset = fdt_find_or_add_subnode(fdt, 0, node_name);
> +       if (nodeoffset < 0)
> +               return nodeoffset;
> +
> +       err = fdt_setprop_string(fdt, nodeoffset, "compatible", "pmem-region");
> +       if (err)
> +               return err;
> +       err = fdt_setprop_empty(fdt, nodeoffset, "volatile");
> +       if (err)
> +               return err;
> +
> +       len = fdt_pack_reg(fdt, tmp, &pmem_start, &pmem_size, 1);
> +       err = fdt_setprop(fdt, nodeoffset, "reg", tmp, len);
> +       if (err < 0) {
> +               printf("WARNING: could not set pmem %s %s.\n", "reg",
> +                      fdt_strerror(err));
> +               return err;
> +       }
> +
> +       return 0;
> +}
> diff --git a/include/fdt_support.h b/include/fdt_support.h
> index f0ad2e6b365..049190cf3d7 100644
> --- a/include/fdt_support.h
> +++ b/include/fdt_support.h
> @@ -471,6 +471,20 @@ int fdt_valid(struct fdt_header **blobp);
>   */
>  int fdt_get_cells_len(const void *blob, char *nr_cells_name);
>
> +/**
> + * fdt_fixup_pmem_region() - add a pmem node on the device tree
> + *
> + * This functions adds/updates a pmem node to the device tree.
> + * Usually used with EFI installers to preserve installer
> + * images
> + *
> + * @fdt:       device tree provided by caller
> + * @addr:      start address of the pmem node
> + * @size:      size of the memory of the pmem node
> + * Return:     0 on success or < 0 on failure
> + */
> +int fdt_fixup_pmem_region(void *fdt, u64 pmem_start, u64 pmem_size);
> +
>  #endif /* !USE_HOSTCC */
>
>  #ifdef USE_HOSTCC
> --
> 2.34.1
>
