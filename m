Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFC7E74AC8
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 19:45:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84B6789662;
	Tue,  3 Dec 2024 20:45:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PwtTTZq/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D00C89662; Tue,  3 Dec 2024 20:45:34 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E98F8967C
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 20:45:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ee4980f085so3635185a91.2
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 11:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733255130; x=1733859930; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CvjUGn76qzhEiO7sja2Y9X4YDi3u7MvtV8W6IKrEEKo=;
 b=PwtTTZq/FMHUYhSVovotw6HttJWRX8wrzLSrptHxCRDTlbk5bwEzHHu4zsoYqYaslu
 P38k0FRTcQHsvvKiZhlnXVHGbeiwYwFJsPjxBaU9Nn/IzRO6OL1YxPDPqrz0QWRi7+zT
 XfLG2gbfEvRx1xmG9ssnYF8zD0PgajJbtEvfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733255130; x=1733859930;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CvjUGn76qzhEiO7sja2Y9X4YDi3u7MvtV8W6IKrEEKo=;
 b=iudt7BxwWlyXGuoHm6xpA6aEm0bWRi8j9tXthwZncH67GvYLSwQwNLtAON3OTf9Y/m
 Jp4B+PNNkzSnbqWWq7nX0KVx8VJZ8drAaiYUIcJbUSWyZh6XefyBAYGn4dtpG93ynVIB
 s/1uNm/HMPtK5yvBacrRoZu5kv9uxxkpcyXdHK9jHrXiEAPlzQ4LXz7RebJlZvs4KU2l
 goj7NBz6pcZWoAvxY9buYJOIpf1kYexhXIpnpXr04kXLeZNpzaREHmkSv/7EVluKcO6R
 NzSFLMQDbqGMLmpXOZI9i63jDbanNg//XZ6yvKJk66tuwyQge+1OUUrRB39ZA0kkEBbB
 ufEQ==
X-Gm-Message-State: AOJu0Ywhn7AGS8lsZ1LFXAINUND8gPYcjStruTRJaak7+NWEw5w7WImn
 6dUr+eZfjCWlpyfyFW++XMZQuoGlksxtDHe2O2VPeGBXieIYvI5RXQAr756jHNDiQxg28Pq/mc8
 sZPtXwKPFlOLwgjUCBMMheZfHWJFVHxA1rKZ+
X-Gm-Gg: ASbGncuNSoe1c7kFnM+nvKiYlcFkfHcjCwAeZTixcebEB7RY1qfc3Z63rpJTY8aMRd9
 EqRqwJldCVE/X1DYJrjTsv9xQzajZcl+t
X-Google-Smtp-Source: AGHT+IE1yqyDftb39YIoH5XWsTAU4nElLSjVRouWdM40k16FpOOgowEipGreC8mZc+jxVxAXDIr8Nll93UVTJLW/MlU=
X-Received: by 2002:a17:90b:394d:b0:2ee:d35c:39ab with SMTP id
 98e67ed59e1d1-2ef012115damr4324420a91.22.1733255130079; Tue, 03 Dec 2024
 11:45:30 -0800 (PST)
MIME-Version: 1.0
References: <20241203163605.1482152-1-sughosh.ganu@linaro.org>
 <20241203163605.1482152-2-sughosh.ganu@linaro.org>
In-Reply-To: <20241203163605.1482152-2-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Dec 2024 12:45:06 -0700
Message-ID: <CAFLszTgyOvi-DvBqLzD_n7UqTUxZo98G9RGddkMpcrXaYzJfpg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] fdt: add support for adding pmem nodes
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Anton Antonov <Anton.Antonov@arm.com>, Tom Rini <trini@konsulko.com>
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

Hi Sughosh,

On Tue, 3 Dec 2024 at 09:36, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> From: Masahisa Kojima <kojima.masahisa@socionext.com>
>
> One of the problems OS installers face, when running in EFI, is that
> the mounted ISO after calling ExitBootServices goes away. For some
> distros this is a problem since they rely on finding some core packages
> before continuing the installation. Distros have works around this --
> e.g Fedora has a special kernel command line parameter called
> inst.stage2 [0].
>
> ACPI has NFIT and NVDIMM support to provide ramdisks to the OS, but we
> don't have anything in place for DTs. Linux and device trees have support
> for persistent memory devices. So add a function that can inject a pmem
> node in a DT, so we can use it when launhing OS installers with EFI.
>
> [0]
> https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/html/installation_guide/chap-anaconda-boot-options#sect-boot-options-installer
>
> Signed-off-by: Masahisa Kojima <kojima.masahisa@socionext.com>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1: None
>
>  boot/fdt_support.c    | 41 +++++++++++++++++++++++++++++++++++++++--
>  include/fdt_support.h | 13 +++++++++++++
>  2 files changed, 52 insertions(+), 2 deletions(-)
>
> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> index 2392027d40b..61f725389b7 100644
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
> @@ -463,7 +464,6 @@ void do_fixup_by_compat_u32(void *fdt, const char *compat,
>         do_fixup_by_compat(fdt, compat, prop, &tmp, 4, create);
>  }
>
> -#ifdef CONFIG_ARCH_FIXUP_FDT_MEMORY
>  /*
>   * fdt_pack_reg - pack address and size array into the "reg"-suitable stream
>   */
> @@ -491,7 +491,7 @@ static int fdt_pack_reg(const void *fdt, void *buf, u64 *address, u64 *size,
>
>         return p - (char *)buf;
>  }
> -
> +#ifdef CONFIG_ARCH_FIXUP_FDT_MEMORY
>  #if CONFIG_NR_DRAM_BANKS > 4
>  #define MEMORY_BANKS_MAX CONFIG_NR_DRAM_BANKS
>  #else
> @@ -2221,3 +2221,40 @@ int fdt_valid(struct fdt_header **blobp)
>         }
>         return 1;
>  }
> +
> +int fdt_fixup_pmem_region(void *blob, ulong addr, u32 size)
> +{
> +       u64 pmem_start[2] = { 0 };
> +       u64 pmem_size[2] = { 0 };
> +       char pmem_node[32] = {0};
> +       int nodeoffset, len;
> +       int err;
> +       u8 tmp[4 * 16]; /* Up to 64-bit address + 64-bit size */
> +
> +       if (!IS_ALIGNED(addr, SZ_2M) || !IS_ALIGNED(addr + size, SZ_2M)) {
> +               printf("Start and end address needs at 2MB alignment\n");
> +               return -1;
> +       }
> +       snprintf(pmem_node, sizeof(pmem_node), "pmem@%lx", addr);
> +       nodeoffset = fdt_find_or_add_subnode(blob, 0, pmem_node);
> +       if (nodeoffset < 0)
> +               return nodeoffset;
> +
> +       err = fdt_setprop_string(blob, nodeoffset, "compatible", "pmem-region");
> +       if (err)
> +               return err;
> +       err = fdt_setprop_empty(blob, nodeoffset, "volatile");
> +       if (err)
> +               return err;

I believe I asked this already, but is it possible to use the ofnode
interface, instead of adding more and more code which we need to
migrate later?

> +       pmem_start[0] = addr;
> +       pmem_size[0] = size;
> +       len = fdt_pack_reg(blob, tmp, pmem_start, pmem_size, 1);
> +       err = fdt_setprop(blob, nodeoffset, "reg", tmp, len);
> +       if (err < 0) {
> +               printf("WARNING: could not set pmem %s %s.\n", "reg",
> +                      fdt_strerror(err));
> +               return err;
> +       }
> +
> +       return 0;
> +}
> diff --git a/include/fdt_support.h b/include/fdt_support.h
> index 9447a64e060..980feb27d27 100644
> --- a/include/fdt_support.h
> +++ b/include/fdt_support.h
> @@ -474,4 +474,17 @@ void fdt_fixup_pstore(void *blob);
>   */
>  int fdt_kaslrseed(void *blob, bool overwrite);
>
> +/**
> + * fdt_fixup_pmem_region() - add a pmem node on the device tree
> + *
> + * This functions injects a pmem node to the device tree. Usually
> + * used with EFI installers to preserve installer images
> + *
> + * @blob:      device tree provided by caller
> + * @addr:      start address of the pmem node
> + * @size:      size of the memory of the pmem node
> + * Return:     0 on success or < 0 on failure
> + */
> +int fdt_fixup_pmem_region(void *blob, ulong addr, u32 size);
> +
>  #endif /* ifndef __FDT_SUPPORT_H */
> --
> 2.34.1
>

Regards,
Simon
