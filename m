Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F62E7716B
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 07:28:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E558988C98;
	Wed,  4 Dec 2024 08:28:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QqhiE/JU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A61098910E; Wed,  4 Dec 2024 08:28:27 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 381E788730
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 08:28:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d0e75335e3so4046129a12.3
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 23:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733297305; x=1733902105; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aWdZ7FYEBhPuv5cTef4iXakw0ISBv6kVF3GF5GfSre8=;
 b=QqhiE/JU2SkdCZWhNYn9tPygcTjocE0Zq2ik5aRFV9sA0SZIu8zhUVtwc/x9mcs78Y
 kO2qcaRX9/fRxqiC8pY3wjR3NKcEr+0MNbt6G3PZ7CO73FS+WlSVDYic5ruVlOJ9Tt5W
 7N15gJnw75hl0fNlQVGR4ZwT7gisyIkkWBy7XMLrjiH0AgqCmp8S52mnUdn9bd1LNCus
 zIfxcIO38NTUwA6pfxjD1T2o7Sen2FV1eIisB+/MunU9sMPULuScaDWu21wD6NlXemTt
 RZ26TQ/hpkiHMBYmeoUKm2uVAMaTlIZUxNQjBN8QKC2UjADGNd1ko1udmmQHiJsUF5QF
 lTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733297305; x=1733902105;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aWdZ7FYEBhPuv5cTef4iXakw0ISBv6kVF3GF5GfSre8=;
 b=KipLvwfhUOXyOBcjK2Bh4Se2EQlFlaaINK4231Z+cowT42NbZ8AdE6ESLtLSzjAxX/
 oHVD7ZFfMdgkPqRzylCEFYeeYFyFbEokgbFZd90+Z8PhLQ17XKxKAhGt9Olw/MstFY6v
 QHX7GqpOdlnhRB5ILyPTG3/+Ljr2cxwLQ6i6SfInv/5ywbUWsuaXyTCCMXxnhWf46HES
 //6QIz1edTaMCYQagK4uVGNzOXOt91PbnEKEkN4yL0jhkzTynPj+mnFnB5/UkBKNmEJm
 yPN4wjXTkh80UycXEpVRN3cqm2fxOC5gYOC7NDW2VXxjgnNGdSi4IZ3AFhvFAMnNCKSp
 mn6g==
X-Gm-Message-State: AOJu0YxVEbt28vdBscyNT3QtbIUCuaNkbtxQjIaTSBa3O2qSn3x5f3FT
 A9auDxLGvY7nm0jXt0Ks2agRVyD7OdsIWACLdCzj+DgvJEvRl3A1Grr47HQbLEDDOKPpnJe9XWi
 3D3JF6X48wdWkjPSfCTNJZbVkmZU8nZUG0k13yNOAU23nvXmzxO4=
X-Gm-Gg: ASbGncsSc4BUyiDYZKNwEo0jNPOj+DvISQdboGNiJHHiXkYMTa4ROCgeLUBDRbEMq8X
 owaSsMHMN+Hv+0rUqWekpFOyHfNx8fB63
X-Google-Smtp-Source: AGHT+IHc1UOVPCAd62LE7xKoxqrj7V/BcwE/C+OIqvCvhGnoU+xWB7SzLCHefdcZi4ZaHYgxisSAz2EQbULXuMfNdpo=
X-Received: by 2002:a05:6402:34cb:b0:5d0:e568:7ba1 with SMTP id
 4fb4d7f45d1cf-5d10cb984e6mr4758021a12.30.1733297304565; Tue, 03 Dec 2024
 23:28:24 -0800 (PST)
MIME-Version: 1.0
References: <20241203163605.1482152-1-sughosh.ganu@linaro.org>
 <20241203163605.1482152-2-sughosh.ganu@linaro.org>
 <CAFLszTgyOvi-DvBqLzD_n7UqTUxZo98G9RGddkMpcrXaYzJfpg@mail.gmail.com>
In-Reply-To: <CAFLszTgyOvi-DvBqLzD_n7UqTUxZo98G9RGddkMpcrXaYzJfpg@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 4 Dec 2024 12:58:13 +0530
Message-ID: <CADg8p96DCmjyCJM1XA9wjAUgfWavKCY5D6ko+Cz8dYkoDtq6Ng@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] fdt: add support for adding pmem nodes
To: Simon Glass <sjg@chromium.org>
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

On Wed, 4 Dec 2024 at 01:15, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Tue, 3 Dec 2024 at 09:36, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
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
> >
> > [0]
> > https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/html/installation_guide/chap-anaconda-boot-options#sect-boot-options-installer
> >
> > Signed-off-by: Masahisa Kojima <kojima.masahisa@socionext.com>
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since V1: None
> >
> >  boot/fdt_support.c    | 41 +++++++++++++++++++++++++++++++++++++++--
> >  include/fdt_support.h | 13 +++++++++++++
> >  2 files changed, 52 insertions(+), 2 deletions(-)
> >
> > diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> > index 2392027d40b..61f725389b7 100644
> > --- a/boot/fdt_support.c
> > +++ b/boot/fdt_support.c
> > @@ -18,6 +18,7 @@
> >  #include <dm/ofnode.h>
> >  #include <linux/ctype.h>
> >  #include <linux/types.h>
> > +#include <linux/sizes.h>
> >  #include <asm/global_data.h>
> >  #include <asm/unaligned.h>
> >  #include <linux/libfdt.h>
> > @@ -463,7 +464,6 @@ void do_fixup_by_compat_u32(void *fdt, const char *compat,
> >         do_fixup_by_compat(fdt, compat, prop, &tmp, 4, create);
> >  }
> >
> > -#ifdef CONFIG_ARCH_FIXUP_FDT_MEMORY
> >  /*
> >   * fdt_pack_reg - pack address and size array into the "reg"-suitable stream
> >   */
> > @@ -491,7 +491,7 @@ static int fdt_pack_reg(const void *fdt, void *buf, u64 *address, u64 *size,
> >
> >         return p - (char *)buf;
> >  }
> > -
> > +#ifdef CONFIG_ARCH_FIXUP_FDT_MEMORY
> >  #if CONFIG_NR_DRAM_BANKS > 4
> >  #define MEMORY_BANKS_MAX CONFIG_NR_DRAM_BANKS
> >  #else
> > @@ -2221,3 +2221,40 @@ int fdt_valid(struct fdt_header **blobp)
> >         }
> >         return 1;
> >  }
> > +
> > +int fdt_fixup_pmem_region(void *blob, ulong addr, u32 size)
> > +{
> > +       u64 pmem_start[2] = { 0 };
> > +       u64 pmem_size[2] = { 0 };
> > +       char pmem_node[32] = {0};
> > +       int nodeoffset, len;
> > +       int err;
> > +       u8 tmp[4 * 16]; /* Up to 64-bit address + 64-bit size */
> > +
> > +       if (!IS_ALIGNED(addr, SZ_2M) || !IS_ALIGNED(addr + size, SZ_2M)) {
> > +               printf("Start and end address needs at 2MB alignment\n");
> > +               return -1;
> > +       }
> > +       snprintf(pmem_node, sizeof(pmem_node), "pmem@%lx", addr);
> > +       nodeoffset = fdt_find_or_add_subnode(blob, 0, pmem_node);
> > +       if (nodeoffset < 0)
> > +               return nodeoffset;
> > +
> > +       err = fdt_setprop_string(blob, nodeoffset, "compatible", "pmem-region");
> > +       if (err)
> > +               return err;
> > +       err = fdt_setprop_empty(blob, nodeoffset, "volatile");
> > +       if (err)
> > +               return err;
>
> I believe I asked this already, but is it possible to use the ofnode
> interface, instead of adding more and more code which we need to
> migrate later?

I had spent some time understanding what exactly is happening with the
livetree code. I had responded to you earlier [1] as to why I don't
think using livetree would be a good fit for this use case.

-sughosh

[1] - https://lists.denx.de/pipermail/u-boot/2024-December/573556.html

>
> > +       pmem_start[0] = addr;
> > +       pmem_size[0] = size;
> > +       len = fdt_pack_reg(blob, tmp, pmem_start, pmem_size, 1);
> > +       err = fdt_setprop(blob, nodeoffset, "reg", tmp, len);
> > +       if (err < 0) {
> > +               printf("WARNING: could not set pmem %s %s.\n", "reg",
> > +                      fdt_strerror(err));
> > +               return err;
> > +       }
> > +
> > +       return 0;
> > +}
> > diff --git a/include/fdt_support.h b/include/fdt_support.h
> > index 9447a64e060..980feb27d27 100644
> > --- a/include/fdt_support.h
> > +++ b/include/fdt_support.h
> > @@ -474,4 +474,17 @@ void fdt_fixup_pstore(void *blob);
> >   */
> >  int fdt_kaslrseed(void *blob, bool overwrite);
> >
> > +/**
> > + * fdt_fixup_pmem_region() - add a pmem node on the device tree
> > + *
> > + * This functions injects a pmem node to the device tree. Usually
> > + * used with EFI installers to preserve installer images
> > + *
> > + * @blob:      device tree provided by caller
> > + * @addr:      start address of the pmem node
> > + * @size:      size of the memory of the pmem node
> > + * Return:     0 on success or < 0 on failure
> > + */
> > +int fdt_fixup_pmem_region(void *blob, ulong addr, u32 size);
> > +
> >  #endif /* ifndef __FDT_SUPPORT_H */
> > --
> > 2.34.1
> >
>
> Regards,
> Simon
