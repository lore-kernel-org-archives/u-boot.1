Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09A7C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 10:26:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BE9684A0F;
	Thu,  2 Jul 2026 12:26:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oQ5SiaIJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E17384A1D; Thu,  2 Jul 2026 12:26:42 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 190C384987
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 12:26:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c1268f71572so59900166b.0
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 03:26:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782987999; cv=none;
 d=google.com; s=arc-20260327;
 b=nH3joJ4qPtHaeTlN9vmpPNB0jz5OvjApjcdlMWqt/nPyEAodN/Vdj9LAn3u0WIaJyo
 Z1AYrkiL/LBXgF4fz8xzqB4XHed4OjJXL4+YBPt9PtyxiI378FgXu1TKwyk+lbEhB/tW
 hUtzLR0ZuKlcsjKOHrdanvg8UoB6UpVSeXToJV/HEcth/QxeTWKVQ3/tPKGi4z0r5szY
 4Tsmo9JsDp3GwEq4i5PcDfXnvp0jJ2zbpZcCkcAy9cwsn39N0oVOodm6mhNcsSvo96Bc
 AWkYXZGw2VA3CKXawDztbCBEwYZF3K8Ssomb8ZFjy6g03rDa5vqYDNpbXDdy67sL0GJ6
 6fAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1SwZPpjFkBJ3LDpOXEi04idIWdde4bFc7geI+f83p8o=;
 fh=3hhYZlhan2cJV/nAk4Ua7uc4BncujvM8xU6z29X0QZo=;
 b=i3VuBP6y+IjU6RI5knYrzz/yJvvZf9WGjjZeBezCViao2WPyEC3jJ1adrB+2EBbsgt
 1vZeD/FhQT3eboUFZbWI67xUXoLjgHENBDxP360DBK+AyoPWSCO4TOQcwkFdQaEV6Hfl
 M1wpBynlmtoe4bc0A1sMLlDjmnaJ9ZOu0+r5wFi94IYywsblAuo5lVCXrWTRDl76nSJf
 58EONsxoeyZpiD29zW9EFvAzqP1HapiyzBWRUq4yGsrK8Yo1O3JM0Hl3IOpDHNVCZBXp
 krZnId+03t5mBrzG5cAuFuAObOhHFBBSZXxpZU+4nmsmRJFcI8QeHcG0yxUVzN2pjSd8
 KSeA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782987999; x=1783592799; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1SwZPpjFkBJ3LDpOXEi04idIWdde4bFc7geI+f83p8o=;
 b=oQ5SiaIJT4NkLhTrXnD9UdxwTTEclgAMYo1Fyzh7I6/Stpw3pdqYjetL0Ivl9Zdeq8
 8Ly+XgvZ0XuNDOqR3gyyzadPGZCsJgTRiZ6Jb8DQW5byOwXz+0EYFaz/X9Kvlx5nePGP
 Sbk2+N9qMR36EQkGcJXfp2c3h1uUrCtQT/dOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782987999; x=1783592799;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1SwZPpjFkBJ3LDpOXEi04idIWdde4bFc7geI+f83p8o=;
 b=idlwXPpwuA6M1YPntWQYzQH3zNjhy7Zs6qkSDe86i6iNwqf9EZzFWAaRQlHFiznEyd
 uJrK1tzH8f8rXxKBNlpJHWMdHyB0XDhTBvvb8NbH3qVkoOmnFXm1U5uifGi/QNJuCM5B
 246HhhjsaPvaO8Vrded6xgRP1fvPGxTVF5FYBPlSx8wbYXYlkjJOG/Z7rYLFug5Hyvj9
 WPiyFbKXCaCZFsCVAJMY82RT3OJ77gRf0TAi27/NvBDMkTxfjzQMOzwM+fbGffsyVhbX
 6oF3W5eQrxuHJDaDluyNYnqfClYJEA6uPuiYqE6rbkgB0GFaI6+CkKa2B5itSds0AVIf
 /vbA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpu4iYKNRMZe3OVk9OLJviQAWNqeGj5oXyxfNBTBx/dof2P08adV1W7Sc41PtP3LVY+qTlhLNo=@lists.denx.de
X-Gm-Message-State: AOJu0YzPbsgiZqvsa7GR/t2aYOib1rKEwX32UaFxnV7ZwHb9/KA9D1vY
 bBr2L8UvkGDyhVMBGVWR+lPVdF435woV4kSBMezbOTDVuXfrXV7oN9pffAtYDi1in/x8BsgXTCQ
 QiEsD8JVdmocDQDNjJzIJa1V8Gl3yTFMV9UuVLnz/
X-Gm-Gg: AfdE7cmIdOnZlDsG8vTWDHz4YGQR/OJ7CeHxX82YkhNKonLGKYB1EZLsq5nBG9zh4MW
 WQXbYJxI8wEvYr5WQY3XphxHuFN71uWs79PUsVMeAzUEa95ZRyXl92L9+4s2qqPAOXaWj54p0W8
 RJ9f0gFnAo6eHj1BwOSjwK83V8WXV5reZAXbV4vp88DI6rDa6tNh5tcYM6r6fOIHWFFrzXQg7i7
 ujygCOrkscZBO2BkvSs86oOf9eNd3FO/gwHolpeHqWnSBa2ulBbGC50JPzXRj946RbtYeinpw==
X-Received: by 2002:a17:907:1805:b0:c12:c69:ba0 with SMTP id
 a640c23a62f3a-c12904f5d45mr470187566b.20.1782987999459; Thu, 02 Jul 2026
 03:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-11-me@ziyao.cc>
In-Reply-To: <20260701111808.870705-11-me@ziyao.cc>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 11:26:23 +0100
X-Gm-Features: AVVi8CcNqnrtcJ0Tt58g2LNrGhigG4bGToDKUW8MqqVmpbs_4jaQ9pVeqEHpiro
Message-ID: <CAFLszTiXWp6CeENHzYnw0621NxwGta_Fk-06EO6JiZtKuP7MQQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/16] LoongArch: Boot Image bits
To: me@ziyao.cc
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

Hi Yao,

On 2026-07-01T11:17:53, Yao Zi <me@ziyao.cc> wrote:
> LoongArch: Boot Image bits
>
> Implement loading and booting functions for LoongArch
> standard kernel image as per spec.
>
> LoongArch kernel do expect us to fake a efi systemtable
> for passing fdt to kernel, we don't need to implement any
> EFI functions for kernel because it won't look into anything
> beside devicetree from that table if we tell kernel we are
> not efi compatible by setting a0 boot argument to zero.
>
> Link: https://docs.kernel.org/arch/loongarch/booting.html
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>
>
> arch/loongarch/lib/Makefile |   2 +
>  arch/loongarch/lib/bootm.c  | 163 ++++++++++++++++++++++++++++++++++++++++++++
>  arch/loongarch/lib/image.c  |  66 ++++++++++++++++++
>  cmd/Kconfig                 |   2 +-
>  4 files changed, 232 insertions(+), 1 deletion(-)

> diff --git a/arch/loongarch/lib/bootm.c b/arch/loongarch/lib/bootm.c
> @@ -0,0 +1,163 @@
> +#include <bootstage.h>
> +#include <bootm.h>
> +#include <command.h>
> +#include <dm.h>
> +#include <efi.h>
> +#include <efi_api.h>
> +#include <fdt_support.h>
> +#include <hang.h>
> +#include <log.h>
> +#include <linux/sizes.h>
> +#include <memalign.h>
> +#include <asm/global_data.h>
> +#include <dm/root.h>
> +#include <image.h>
> +#include <asm/byteorder.h>
> +#include <dm/device.h>
> +#include <dm/root.h>
> +#include <u-boot/zlib.h>

dm/root.h is listed twice - please drop the duplicate, and sort the
block while you are here.

https://docs.u-boot.org/en/latest/develop/codingstyle.html#include-files

> diff --git a/arch/loongarch/lib/bootm.c b/arch/loongarch/lib/bootm.c
> @@ -0,0 +1,163 @@
> +/* LoongArch do expect a EFI style systab */
> +static int generate_systab(struct bootm_headers *images)
> +{
> +     const int nr_cfgtab = 1;
> +     struct bd_info *kbd = images->kbd;
> +     struct efi_system_table *systab;
> +     struct efi_configuration_table *cfgtab;
> +     size_t table_size = sizeof(struct efi_system_table) +
> +                         nr_cfgtab * sizeof(struct efi_configuration_table);
> +
> +     systab = memalign(SZ_64K, table_size);

Please add a comment on why 64K alignment is required.

> diff --git a/arch/loongarch/lib/bootm.c b/arch/loongarch/lib/bootm.c
> @@ -0,0 +1,163 @@
> +static void boot_jump_linux(struct bootm_headers *images, int flag)
> +{
> +     void (*kernel)(ulong efi_boot, char *argc, void *dtb);
> +     int fake = (flag & BOOTM_STATE_OS_FAKE_GO);
> +
> +     kernel = (void (*)(ulong efi_boot, char *argc, void *dtb))images->ep;

The second argument is the kernel command line, not argc - please
rename to cmdline. The third is the fake systab pointer, not a raw
dtb; please rename that too.

> diff --git a/arch/loongarch/lib/bootm.c b/arch/loongarch/lib/bootm.c
> @@ -0,0 +1,163 @@
> +     if (!fake) {
> +             if (CONFIG_IS_ENABLED(OF_LIBFDT) && images->ft_len)
> +                     kernel(0, NULL, (void *)images->kbd->bi_boot_params);
> +     }

Per the LoongArch booting spec, a1 is the kernel command line.
Passing NULL means the bootargs env var never reaches the kernel
via that path - it will only be seen in /chosen/bootargs

So don't you wan to pass images->cmdline_start here?

Also, if OF_LIBFDT is disabled or ft_len is zero we drop through
without jumping *after* announce_and_cleanup() has torn devices
down. Please panic() / hang() in that case rather than silently return.

> diff --git a/arch/loongarch/lib/image.c b/arch/loongarch/lib/image.c
> @@ -0,0 +1,66 @@
> +struct linux_image_h {
> +     uint32_t        code0;                  /* Executable code */
> +     uint32_t        code1;                  /* Executable code */
> +     uint64_t        kernel_entry;   /* Kernel entry point */
> +     uint64_t        image_size;             /* Effective Image size */
> +     uint64_t        load_offset;    /* load offset */
> +     uint64_t        res1;                   /* reserved */
> +     uint64_t        res2;                   /* reserved */
> +     uint64_t        res3;                   /* reserved */
> +     uint32_t        magic;                  /* Magic number */
> +     uint32_t        pe_header;              /* Offset to the PE header */
> +};

Comment tabs after kernel_entry/image_size/load_offset are
inconsistent with the first two members - please tidy so the
comments line up. Also use u32/u64 for consistency with the rest
of U-Boot.

I have to wonder whether it would be OK to share this struct with
RISC-V in a header file?

> diff --git a/arch/loongarch/lib/image.c b/arch/loongarch/lib/image.c
> @@ -0,0 +1,66 @@
> +     /* To workaround kernel supplying DMW based virtual address */
> +     ep_phys = TO_PHYS(lhdr->kernel_entry);
> +     *ep = *relocated_addr + (ep_phys - lhdr->load_offset);

Please expand this comment - from context it looks like kernel_entry
is a DMW virtual address, and you are converting to a physical
offset within the image and re-basing onto the relocated load
address. Spell that out, with a pointer to the relevant paragraph
of the booting spec.

Regards,
Simon
