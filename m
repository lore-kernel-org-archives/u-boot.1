Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA88DC02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 14:02:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 675AF805C5;
	Mon, 20 Jan 2025 15:02:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iexeFEPd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89DDA806DC; Mon, 20 Jan 2025 15:02:34 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6EAB801CF
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 15:02:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b6c3629816so231954885a.1
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 06:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737381751; x=1737986551; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bOkTeLkUmIuM55kidFSsBRif8TsbUpWA0xE/yIBUuKw=;
 b=iexeFEPdTJpVOizHAz3oM0+iEEMJ6tfj3dFFzBw8kpJcNnHxYmEUc1FZQCDk9C/wYi
 FKqsavOZ3aF0rceh7zqTWLm8lKIkDyi9ERHosW+UPXbORjmKNU7fksRBrazhDcTCoo8u
 ZCNvKivROdCET1WOpIvQgawDadhvEJGiFNVDTRDpHI7+WvC97mB7qFl554URTnU1hOpI
 MYJAgzqeA82yvENHxoUKLdm+iuLovTJBmxnwo3owYChTjDGvqKrQ+jiPset5hOtThy5j
 IF9fj9clu7FXAhoyq263WukmEALVSqY1Wy5oHZAcYqQpjFc5UdsiZgN8lg1DSr83chYJ
 XjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737381751; x=1737986551;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bOkTeLkUmIuM55kidFSsBRif8TsbUpWA0xE/yIBUuKw=;
 b=CQl4qlqmVmALRtyQM3UeBYV8M8lMANrQPGJz9FQwymG/rAj795SMDhFAT+RWSwdV0x
 h3ICT16lm0kTlH1xKILZHa/xdocgXWaphO6rGNMxYID91C334OjYEHEw5aU+EaT1zx/f
 CWRRAVDXozZw09JqE/1rsNR0CP/XPQEIifVmLVnyV0gAnUghCjCfxm7PjlZOS4zuhNAt
 PTrbi9hCvIFE4vS9xXKlb29S7FZl51mnwb4pV/EUD9vPxmwZvMZp5kblpnMacbmNV7pQ
 PGtJP/0euRwLhwjvcRI9fIYZMq3GZe4NcIWEgG+GY69k042zT3NN+jhR8aKC3RmBO+2n
 G2Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAwPm/5/lofwK7mp7rJ0iLdyIJ+KOij97PCYV/6WXw0wVlfNSoarbbxADqrOBtPryQjHHsVlY=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2N2tSC0W3zpZ8VC309C/Bd1GwP2tfxBMpvaq4CcSzx9+HIY6F
 0zA+0aox8qnjp3V9GUwAhXqETvohYpaJuOejOO0Y/+K0DkzCW6a95Az9qfT7Kao3uVGAKbr9rE4
 t8LSeQ73jQnrhbm6wGYSIQH/ZqvZ5Poob5sjybQ==
X-Gm-Gg: ASbGnct6v081fjvaI2gsdzh8t6Ym2OQiOe/CGtYW1Yw24cP5B9LIkFULkTBsJbHMk2s
 k+6rjzi3ReYDSRzgXhD/XEl2aAOP98Q2raUUPy23rrI+pprNPxuvB
X-Google-Smtp-Source: AGHT+IGyniwQy2S+Qtj3f6pJkC/dMuEIe25mqYYKieJRicntRJvCh+4f5k34XUlI1b16laJfQIwfRrvm7UsAGnul0vw=
X-Received: by 2002:a05:620a:2551:b0:7b6:cb07:24bc with SMTP id
 af79cd13be357-7be63251a00mr2500603685a.48.1737381750505; Mon, 20 Jan 2025
 06:02:30 -0800 (PST)
MIME-Version: 1.0
References: <20250120105045.1281262-1-sughosh.ganu@linaro.org>
 <20250120105045.1281262-2-sughosh.ganu@linaro.org>
 <67f57223-2c0d-414b-9e8c-138fdc57d92a@gmx.de>
In-Reply-To: <67f57223-2c0d-414b-9e8c-138fdc57d92a@gmx.de>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 20 Jan 2025 19:32:18 +0530
X-Gm-Features: AbW1kvYNPyC_I7Cagji2mrDoiWLYrIfNvchW6GDSjuV8Bo6l_EirhB_A2y442eE
Message-ID: <CADg8p979JG5QVQi_Qc7520xHvkmcr7PpJq6kHJ8qN204sL7uoQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] fdt: add support for adding pmem nodes
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Anton Antonov <Anton.Antonov@arm.com>, 
 Tobias Waldekranz <tobias@waldekranz.com>, Bin Meng <bmeng@tinylab.org>, 
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

On Mon, 20 Jan 2025 at 18:01, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 20.01.25 11:50, Sughosh Ganu wrote:
> > From: Masahisa Kojima <kojima.masahisa@socionext.com>
> >
> > One of the problems OS installers face, when running in EFI, is that
> > the mounted ISO after calling ExitBootServices goes away. For some
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
> We also have ACPI support in U-Boot. In a future patch series I guess we
> could add the generation of said ACPI tables.
>
> >
> > [0]
> > https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/html/installation_guide/chap-anaconda-boot-options#sect-boot-options-installer
> >
> > Signed-off-by: Masahisa Kojima <kojima.masahisa@socionext.com>
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since V2:
> > * Fix a checkpatch error by putting a blank line after a function
> >
> >   boot/fdt_support.c    | 40 +++++++++++++++++++++++++++++++++++++++-
> >   include/fdt_support.h | 13 +++++++++++++
> >   2 files changed, 52 insertions(+), 1 deletion(-)
> >
> > diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> > index 49efeec3681..613685b80eb 100644
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
> > -#ifdef CONFIG_ARCH_FIXUP_FDT_MEMORY>   /*
> >    * fdt_pack_reg - pack address and size array into the "reg"-suitable stream
> >    */
> > @@ -493,6 +493,7 @@ static int fdt_pack_reg(const void *fdt, void *buf, u64 *address, u64 *size,
> >       return p - (char *)buf;
> >   }
> >
> > +#ifdef CONFIG_ARCH_FIXUP_FDT_MEMORY
>
> Do we need this #ifdef at all? We tend to leave it to the linker to
> eliminate functions.

This patch was authored by Kojima-san. I will have to check if we need
to keep the ifdef.

>
> >   #if CONFIG_NR_DRAM_BANKS > 4
> >   #define MEMORY_BANKS_MAX CONFIG_NR_DRAM_BANKS
> >   #else
> > @@ -2222,3 +2223,40 @@ int fdt_valid(struct fdt_header **blobp)
> >       }
> >       return 1;
> >   }
> > +
> > +int fdt_fixup_pmem_region(void *blob, ulong addr, u32 size)
> > +{
> > +     u64 pmem_start[2] = { 0 };
> > +     u64 pmem_size[2] = { 0 };
> > +     char pmem_node[32] = {0};
> > +     int nodeoffset, len;
> > +     int err;
> > +     u8 tmp[4 * 16]; /* Up to 64-bit address + 64-bit size */
> > +
> > +     if (!IS_ALIGNED(addr, SZ_2M) || !IS_ALIGNED(addr + size, SZ_2M)) {
> > +             printf("Start and end address needs at 2MB alignment\n");
>
> Nits:
>
> %s/needs at 2MB alignment/must be 2 MiB aligned/

Will change

>
> > +             return -1;
> > +     }
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
> > index f0ad2e6b365..aea24df828f 100644
> > --- a/include/fdt_support.h
> > +++ b/include/fdt_support.h
> > @@ -507,4 +507,17 @@ void fdt_fixup_pstore(void *blob);
> >    */
> >   int fdt_kaslrseed(void *blob, bool overwrite);
> >
> > +/**
> > + * fdt_fixup_pmem_region() - add a pmem node on the device tree
> > + *
> > + * This functions injects a pmem node to the device tree. Usually
> > + * used with EFI installers to preserve installer images
>
> If I understand the code correctly, the function adds or updates a pmem
> device-tree node for the given start address.

Will reword the comment.

-sughosh

>
> Otherwise looks good to me.
>
> Best regards
>
> Heinrich
>
> > + *
> > + * @blob:    device tree provided by caller
> > + * @addr:    start address of the pmem node
> > + * @size:    size of the memory of the pmem node
> > + * Return:   0 on success or < 0 on failure
> > + */
> > +int fdt_fixup_pmem_region(void *blob, ulong addr, u32 size);
> > +
> >   #endif /* ifndef __FDT_SUPPORT_H */
>
