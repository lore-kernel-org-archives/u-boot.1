Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F4C8C282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 07:20:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC30E80F9C;
	Thu, 13 Mar 2025 08:20:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LpSceZcK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D378580F9C; Thu, 13 Mar 2025 08:20:03 +0100 (CET)
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com
 [IPv6:2607:f8b0:4864:20::92a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE10180540
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 08:19:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-86ba07fe7a4so535841241.2
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 00:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741850396; x=1742455196; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9LTP0RT8StQX7Cd4dgZSYank/k+veb1yFNH3S0OIluk=;
 b=LpSceZcKwIM0N6Y47QZvRNycYYqqc+lBtQepCXWnjl5WXnB3QBnZSmerQH9J1LdCvz
 iJ/tKazDdfopNZHFWYPAeIP11exa4ONZIVoJ24bCRAznqI6SCH/NLq0MQdg+HYSYNMAY
 3yK34Q04aJSJElt70+BzC8/3+rA8DReA9bWwyz25+7lrOAy8/UkUW2GZgVJW0Cr2x5KT
 7IBmi+Ro/w+wEkuJspHEzFsOuVjA7SLfEXXT7KRgrFAD2X+EmBWHnj0rMQF7uFUTR6k5
 HchZka4Qc4RQCxNsJhq9sKnbdFhWSGn+grQ6+nz6dZAIphBOfcz+H4brc1WO0az4eQkH
 ZnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741850396; x=1742455196;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9LTP0RT8StQX7Cd4dgZSYank/k+veb1yFNH3S0OIluk=;
 b=hQGLuuaa7Ci53fm5zAP9mmYq+dshRG9O9cBSn0C4WuRi6LKLde8+7IMmjS9SuzyaK2
 cQjmAvtFyi16+IINqFjlyH5NkCt8208W88ysaj8br52fg65ypumTHcwY5KlqXXzpwnlx
 9JiWcl2LATFfyHR/YptzZ6wFQiV2ZA56nThNfO2KKPxhwPnll1hSfs1dRf6Qa2hI3Qsj
 Ni5XBXcWp4mIXugJkTvHb5e62TbFLHzAkwbmJrbniCME7g0rJmOZvuYv8huKRYjONykY
 PDp50vqGHzCczhwIbBTYWgPHE1KW4u8izknsEnmTv2h1C4XFV1rCNgQHhzEkKwTYI6Pj
 +x3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcL/ClWZXl2DSv4D2pGLhlLyaFlpS7wPA8Ogt7QqRaqPUmlzNXU75XmJf1skNxV9haaYZMSLQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyBD3k+yhGphSWQmk1Sg0XmNottDZ/kzx+xllmq/wM4j6TAII44
 Hq3AoPQ7RTFjCk3QQa2eEjWRd2OfZs5KcehoPNiJTwCHd5Nn+d6TXz2nv7i+3IL5EGkNkSqpgOA
 wro/vBZOAp3xG0gk0jNfv/OrYIVX78bLXl8/Q+w==
X-Gm-Gg: ASbGncvwKkjiCvmo108M+5cX51FMMzjnPtMjTnPAt75hWbxTH8eZvhGA1Z8MRLRQUaf
 ucFnSH+kE/4nMjxOpbK5AvLrIywkNpcCjAIKLpOgbbsz+k78vpiJBnWwPxclNGGpw++SHIQcFO8
 Gkr2eHB85aNq7qUaMhgtpUq4ALNes=
X-Google-Smtp-Source: AGHT+IF532Ijk7ioSsHzA+kKOs5cTMQG3vN/Ko2sBsD+75cVTc8T+zW1lSVNBGceff4q9j4GBwQp3dXe11Xd82gbsws=
X-Received: by 2002:a05:6102:a54:b0:4c1:b3a5:9fa with SMTP id
 ada2fe7eead31-4c30a6d2076mr18812593137.16.1741850396628; Thu, 13 Mar 2025
 00:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250312085424.1201148-1-sughosh.ganu@linaro.org>
 <20250312085424.1201148-4-sughosh.ganu@linaro.org>
 <0cc03dfd-2dda-47d8-83ad-cce8d3a3cad1@canonical.com>
In-Reply-To: <0cc03dfd-2dda-47d8-83ad-cce8d3a3cad1@canonical.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 13 Mar 2025 12:49:45 +0530
X-Gm-Features: AQ5f1JpVa5oSQ7oN0Dm6To0p0vD2Nakjgq9wG9UQBLqt4Y6J4bvsKGQBB0uo_gI
Message-ID: <CADg8p95F8PVXjwRQnYEUcGiBtE+x5AnF-tptfg_iKWQZaRurCg@mail.gmail.com>
Subject: Re: [PATCH v8 3/8] fdt: add support for adding pmem nodes
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Anton Antonov <Anton.Antonov@arm.com>, 
 Tobias Waldekranz <tobias@waldekranz.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
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

On Thu, 13 Mar 2025 at 02:12, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 12.03.25 09:54, Sughosh Ganu wrote:
> > From: Masahisa Kojima <kojima.masahisa@socionext.com>
> >
> > One of the problems OS installers face, when running in EFI, is that
> > the mounted ISO after calling ExitBootServices goes away. For some
>
> A mounted ISO only goes away if it is a RAM disk. But you do not mention
> RAM disks in the first paragraph. Please, add an introductory sentence
> that this patch is about RAM disk support.
>
> Whether the RAM disk contains an installer or a preinstalled OS or
> anything else is irrelevant for the the need of a pmem node to support
> RAM disks. If the RAM disk is partitioned (possibly as ISO9660) or is
> just a raw disk is irrelevant here, too.

Okay, I will re-word the commit message. Btw, I am not the author of
this patch, nor did I write this commit message. I will incorporate
all the review comments. But I do have one gripe. Please check below.

>
> > distros this is a problem since they rely on finding some core packages
> > before continuing the installation. Distros have works around this --
> > e.g Fedora has a special kernel command line parameter called
> > inst.stage2 [0].
> >
> > ACPI has NFIT and NVDIMM support to provide ramdisks to the OS, but we
> > don't have anything in place for DTs. Linux and device trees have support
> > for persistent memory devices. So add a function that can inject a pmem
> > node in a DT, so we can use it when launhing OS installers with EFI.
>
> Nits:
>
> %s/launhing/launching/
>
> >
> > [0]
> > https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/html/installation_guide/chap-anaconda-boot-options#sect-boot-options-installer
> >
> > Signed-off-by: Masahisa Kojima <kojima.masahisa@socionext.com>
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since V7: None
> >
> >   boot/fdt_support.c    | 41 ++++++++++++++++++++++++++++++++++++++++-
> >   include/fdt_support.h | 14 ++++++++++++++
> >   2 files changed, 54 insertions(+), 1 deletion(-)
> >
> > diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> > index 49efeec3681..e20b9759138 100644
> > --- a/boot/fdt_support.c
> > +++ b/boot/fdt_support.c
> > @@ -18,6 +18,7 @@
> >   #include <dm/ofnode.h>
> >   #include <linux/ctype.h>
> >   #include <linux/types.h>
> > +#include <linux/sizes.h>
> >   #include <asm/global_data.h>
> >   #include <asm/unaligned.h>
> >   #include <linux/libfdt.h>
> > @@ -464,7 +465,6 @@ void do_fixup_by_compat_u32(void *fdt, const char *compat,
> >       do_fixup_by_compat(fdt, compat, prop, &tmp, 4, create);
> >   }
> >
> > -#ifdef CONFIG_ARCH_FIXUP_FDT_MEMORY
> >   /*
> >    * fdt_pack_reg - pack address and size array into the "reg"-suitable stream
> >    */
> > @@ -493,6 +493,7 @@ static int fdt_pack_reg(const void *fdt, void *buf, u64 *address, u64 *size,
> >       return p - (char *)buf;
> >   }
> >
> > +#ifdef CONFIG_ARCH_FIXUP_FDT_MEMORY
> >   #if CONFIG_NR_DRAM_BANKS > 4
> >   #define MEMORY_BANKS_MAX CONFIG_NR_DRAM_BANKS
> >   #else
> > @@ -2222,3 +2223,41 @@ int fdt_valid(struct fdt_header **blobp)
> >       }
> >       return 1;
> >   }
> > +
> > +int fdt_fixup_pmem_region(void *blob, ulong addr, u32 size)
> > +{
> > +     u64 pmem_start[2] = { 0 };
> > +     u64 pmem_size[2] = { 0 };
>
> You never use index 1. There is no need for defining an array here.
> You could use:
>
> u64 pmem_start;
> u64 pmem_size;
>
> But better simply define the parameters addr and size of the function as
> u64 and use them directly.
>
> > +     char pmem_node[32] = {0};
>
> %s/pmem_node/node_name/g
>
> Why should we the initialize the field here?
>
> > +     int nodeoffset, len;
> > +     int err;
> > +     u8 tmp[4 * 16]; /* Up to 64-bit address + 64-bit size */
> > +
> > +     if (!IS_ALIGNED(addr, SZ_2M) || !IS_ALIGNED(addr + size, SZ_2M)) {
> > +             printf("Start and end address must be 2MiB aligned\n");
> > +             return -1;
> > +     }
> > +
> > +     snprintf(pmem_node, sizeof(pmem_node), "pmem@%lx", addr);
> > +     nodeoffset = fdt_find_or_add_subnode(blob, 0, pmem_node);
> > +     if (nodeoffset < 0)
> > +             return nodeoffset;
> > +
> > +     err = fdt_setprop_string(blob, nodeoffset, "compatible", "pmem-region");
> > +     if (err)
> > +             return err;
> > +     err = fdt_setprop_empty(blob, nodeoffset, "volatile");
> > +     if (err)
> > +             return err;
> > +     pmem_start[0] = addr;
> > +     pmem_size[0] = size;
> > +     len = fdt_pack_reg(blob, tmp, pmem_start, pmem_size, 1);
>
> len = fdt_pack_reg(blob, tmp, &addr, &size, 1);
>
> assuming that addr, size are changed to u64.
>
> > +     err = fdt_setprop(blob, nodeoffset, "reg", tmp, len);
> > +     if (err < 0) {
> > +             printf("WARNING: could not set pmem %s %s.\n", "reg",
> > +                    fdt_strerror(err));
> > +             return err;
> > +     }
> > +
> > +     return 0;
> > +}
> > diff --git a/include/fdt_support.h b/include/fdt_support.h
> > index f0ad2e6b365..b72cd2920de 100644
> > --- a/include/fdt_support.h
> > +++ b/include/fdt_support.h
> > @@ -507,4 +507,18 @@ void fdt_fixup_pstore(void *blob);
> >    */
> >   int fdt_kaslrseed(void *blob, bool overwrite);
> >
> > +/**
> > + * fdt_fixup_pmem_region() - add a pmem node on the device tree
> > + *
> > + * This functions adds/updates a pmem node to the device tree.
> > + * Usually used with EFI installers to preserve installer
> > + * images
> > + *
> > + * @blob:    device tree provided by caller
>
> Calling device-tree blob and not fdt is confusing.

I can make this change. But this is splitting hairs :). Anyone looking
at the code *has* to understand what this blob means.

Also,

grep -R '*blob' --include=*.c | wc -l
664

-sughosh

>
> Best regards
>
> Heinrich
>
> > + * @addr:    start address of the pmem node
> > + * @size:    size of the memory of the pmem node
> > + * Return:   0 on success or < 0 on failure
> > + */
> > +int fdt_fixup_pmem_region(void *blob, ulong addr, u32 size);
> > +
> >   #endif /* ifndef __FDT_SUPPORT_H */
>
