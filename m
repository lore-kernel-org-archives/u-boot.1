Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7A8D0C5FB
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 11:17:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68F8C88ED2;
	Fri, 25 Oct 2024 13:17:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="A6rd9/yq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDE8688F95; Fri, 25 Oct 2024 13:17:09 +0200 (CEST)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67CBB88ED2
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 13:17:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-71e49ef3b2bso1354890b3a.2
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 04:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729855022; x=1730459822; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wJmDUEJeub0z9ZacsW/x9bW1Fu4ZNVxZHsfy9hU8Jpo=;
 b=A6rd9/yqSIz1JCj2xKfmGXHUJxZqgOBKNzO8kte/+IVr0yn1Y87XiqnPn24FFEAqWe
 FFjki0AjEV9ZJuKOMjhl+xarmWQepXMl7HyU3P24+jaBw+iA25R8jf1Zcu1N0OP1aVvL
 dYFS0UmY76pcRc5JDLIdo8pGoRLzsiENQQfTXeSA4xECeq06XNVnh+TBak7a1XTVBaKT
 IDVUaFsezeUEy5aSxx2xoTaKNzAJs46qu5itFrzWf2wCbn7mcu45c8Ayk893nf16QTsZ
 Ub1GfEMM3Pr1zagpytO4sMTBqkZtoz1RkXgrbemJkXBuiqCUs6iEle3dQNQXz8+g8jKk
 zVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729855022; x=1730459822;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wJmDUEJeub0z9ZacsW/x9bW1Fu4ZNVxZHsfy9hU8Jpo=;
 b=Y8iC4HMthSlVUUg+s9DsCT+5j3QR//oCtfaojN7o0FquZExQKKRj/gZO7TGQXl+4/J
 I9jD0cU0HT8iXbliS7ZABTNCD1lHC7wmnonjTPEo0VV1ab1X5K+LFnbZnegVpfEVfXdU
 +p8IPPIn1mijI3dt8p4BIfAgQKtPcCWQ35lnn9jptuROItsqHH/5rWPXu4jgpGrVBpSo
 xBmewdU386EyaUuASIlFJbb1yQsZx30eq4xtkSC0nEmWKk1IJbRgIjVXUM0rEUEffLTu
 cqpSQ2SOIRTtkkfsjRJEVVk/NJynulusKEeYSH1dLE4wFNikopktYvUa8H1TP6sPPbcx
 1TJg==
X-Gm-Message-State: AOJu0Yww3sbZxA7eZ6SkRpsP7q73HTBXy1lAg/U29ydEIA+Fg56PEsSY
 t6Lmu71fzP9H+aXqnFnlbxtNtunU7jFclsCbzhi89ZS1Tq6A6anQ+J4P04vrC0I1s9Woz62EEUz
 86WWW3n+NAxHWgacXSYZUqbqcKoJHsK2XvuUV7w==
X-Google-Smtp-Source: AGHT+IFTuZYqxXfW6+oHVWn3HiSYgPymmWLuTGy2fKDtZZD8DhBe4u+6y/Qe+rnB44o1q/nt8S/MdUJT45jFFh926kM=
X-Received: by 2002:a05:6a00:2382:b0:71e:702c:a680 with SMTP id
 d2e1a72fcca58-72030ba33f8mr12296481b3a.26.1729855021722; Fri, 25 Oct 2024
 04:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <20241025111411.165904-1-sughosh.ganu@linaro.org>
 <20241025111411.165904-2-sughosh.ganu@linaro.org>
In-Reply-To: <20241025111411.165904-2-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 25 Oct 2024 14:16:25 +0300
Message-ID: <CAC_iWjK21Gzr7o0urO3ga-7kXUa6CTR39x=eGpoGEoNVQivzkw@mail.gmail.com>
Subject: Re: [PATCH 1/4] fdt: add support for adding pmem nodes
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Anton Antonov <Anton.Antonov@arm.com>
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

Thanks Sughosh

+CC Anton who tested that

On Fri, 25 Oct 2024 at 14:14, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
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
>  boot/fdt_support.c    | 41 +++++++++++++++++++++++++++++++++++++++--
>  include/fdt_support.h | 13 +++++++++++++
>  2 files changed, 52 insertions(+), 2 deletions(-)
>
> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> index 2392027d40..61f725389b 100644
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
> index 741e2360c2..63ece0de32 100644
> --- a/include/fdt_support.h
> +++ b/include/fdt_support.h
> @@ -473,4 +473,17 @@ void fdt_fixup_pstore(void *blob);
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
