Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088E7C021B5
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 18:38:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6446B80EC0;
	Fri, 21 Feb 2025 19:38:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ngF7s1CH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA8E880F56; Fri, 21 Feb 2025 19:38:15 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 748EA807C4
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 19:38:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e5dd7b439e3so2163403276.1
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 10:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740163091; x=1740767891; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WMX6OREwLtWjrg6JK46ElsuzPeNXarYManqBpzvyUpY=;
 b=ngF7s1CHKUpnsd/Ilu1tKW5Eg7QSRdPZq2+JyugY1HCSEZgE2H31vvmH2N1SK5UI5e
 j5wxsd1GeoaYMln80UovzT2z2M4nPPDOHVS0qHU6NbUbaKESFHdMKmyQULC4t/H6bmoJ
 FHJHPYdmw3hrhP91Zpy9RUWAXxIhSu33B+Z0sIyHrym+Fbid24aadrzS4/wiA8VEuwGt
 0AbUHtqFKY9lJH3Gg+ZyE9FgYHep4QDU1BOK+LOQAJSk9uHOWv/oMsUaWL0/GQOkPPY8
 Bo2G3gPEOoSkWzGoySNhd4XNp79yJLfJHzutJgSoT9b6Vxx42P1dsngV3k47Ryi3Zukk
 uaPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740163091; x=1740767891;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WMX6OREwLtWjrg6JK46ElsuzPeNXarYManqBpzvyUpY=;
 b=ZG8gzxbZmGNQktVvHQg81bmc/vzN+o/DKHbsLOU4zjZMWybE6ourKdGONva0eIyz5J
 RHp5udzjV/b/h6DeHWWH25IBlBK9bnTT8WpL+tPV3c83yrikcwOVBFaD8yCRiQQgBuxw
 KVHRrwwcpv+EkEDFeTRkOIz88B7otstdl1LB+C1PsoPMHopzHKjctGPkmvThQLGkeEWN
 5VrJdyOwqo6FIEcgiDdficXNTeSdSGk8l9HSYp5tfVoFO95xmGYhuqor2aDaIRQD2hVD
 zkwnbV4/qgpctv0LOHpKcuA+hxyBH8HlQWfNOhpvECTeT/iPIuZjHteFctnu3GjG0b67
 vPqQ==
X-Gm-Message-State: AOJu0YwE+DDpU6+J3HgBtmvTB1vKhOmsAh4x5qryO9mR8WCYY70Y2Kd8
 LaxYD8UD/GQWaWoef+2YJzckeTxqBfnq0xmSjUVd+ApX3N12Pn4mYEb5GqvXmm9raXxAeKRNyzJ
 yspZ+3jV4qeG3jZES5yxTPg/sTXjw8FsHHaHi5g==
X-Gm-Gg: ASbGncswfSO51bl1Ra76eKHVWVDIT93L09yKwctpRioKzMtVQFPGEXCPehM4E/SvFGx
 PMNvNyTUBGppQBWbUvtyZ/hEfvZPSuq6js9bstGuNw0agyERmF2nub+BfATbKVOICF4vGi6x7z7
 j6NmLo648z
X-Google-Smtp-Source: AGHT+IEIz89y4ZVpH0/DmaPaUtf39kcSS3e5OuuQ4z9i61Me+Edxy4D3caJ9ija0hS1SXy/UBIzHE5G8b3hiSLxctBU=
X-Received: by 2002:a05:6902:2290:b0:e5d:ddf0:e66c with SMTP id
 3f1490d57ef6-e5e8afe6dfemr2798174276.29.1740163091025; Fri, 21 Feb 2025
 10:38:11 -0800 (PST)
MIME-Version: 1.0
References: <20250203105912.196654-1-sughosh.ganu@linaro.org>
 <20250203105912.196654-2-sughosh.ganu@linaro.org>
In-Reply-To: <20250203105912.196654-2-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 21 Feb 2025 20:37:35 +0200
X-Gm-Features: AWEUYZk9r9xCU2MijWEEUH053wPVmUmtGqsPySRrdWetkmla1qiIKQ_3dtGYmbU
Message-ID: <CAC_iWjKODKvfjuqtMyyE66=R-oGd3dyEwB5gnyyfhrAVH4KQGA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] fdt: add support for adding pmem nodes
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Anton Antonov <Anton.Antonov@arm.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, 
 Bin Meng <bmeng@tinylab.org>, Masahisa Kojima <kojima.masahisa@socionext.com>
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

On Mon, 3 Feb 2025 at 12:59, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
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
> Changes since V3:
> * Rephrased the 2MiB alignment error message as suggested by Heinrich
> * Rephrased the description of fdt_fixup_pmem_region() function as
>   suggested by Heinrich
>
>  boot/fdt_support.c    | 41 ++++++++++++++++++++++++++++++++++++++++-
>  include/fdt_support.h | 14 ++++++++++++++
>  2 files changed, 54 insertions(+), 1 deletion(-)
>
> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> index 49efeec3681..e20b9759138 100644
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
> @@ -2222,3 +2223,41 @@ int fdt_valid(struct fdt_header **blobp)
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
> +               printf("Start and end address must be 2MiB aligned\n");
> +               return -1;
> +       }
> +
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
> index f0ad2e6b365..b72cd2920de 100644
> --- a/include/fdt_support.h
> +++ b/include/fdt_support.h
> @@ -507,4 +507,18 @@ void fdt_fixup_pstore(void *blob);
>   */
>  int fdt_kaslrseed(void *blob, bool overwrite);
>
> +/**
> + * fdt_fixup_pmem_region() - add a pmem node on the device tree
> + *
> + * This functions adds/updates a pmem node to the device tree.
> + * Usually used with EFI installers to preserve installer
> + * images
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

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
