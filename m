Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF77C0218C
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 10:56:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2415807FE;
	Fri, 24 Jan 2025 11:56:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dRZ+DZuP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C6D980836; Fri, 24 Jan 2025 11:56:48 +0100 (CET)
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com
 [IPv6:2607:f8b0:4864:20::e34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28A21807E4
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 11:56:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-4afdf096fc5so485382137.2
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 02:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737716204; x=1738321004; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zVjAjXcPYZfKozB2ARh6aAZHlJsX4a6eq+XYmjE02lQ=;
 b=dRZ+DZuP0ohGHJpp1MxfuwLyNN4G2qw77ZB5lbNfeKaTLAib/7MCzdpEAz9FxlhHOY
 FoO79beQGi5pXn3n2nam1Sr6IPWDdrjPLHPZa1+RlhQsg3ApdGty6lSRtlpwrDIObzFt
 +Dcj/lCOB4pMhvNau5o4pqPIi2esiDGHpFU/0Q9f5Wg1Kwr4yib74lWIv5m4yPFdvdJd
 sTDx5Pxz/JmJ3hTnkhpq0cfZIKr497qO4KYpGFxFF0BznRzEyvSNbCw0tnpU+CctxEtn
 P4jcu9j5fVde0Jn2BvuLyNYQhtSSVihdPH1A+smLfasASXzG0oJrKWXY05EGOm9qNgkm
 4YXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737716204; x=1738321004;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zVjAjXcPYZfKozB2ARh6aAZHlJsX4a6eq+XYmjE02lQ=;
 b=PGRh7iGNKaGJOfytF1q5fBtpVOCEb1RyB03S+wLZn9NsdpFZxWff4IKE+Yry8nKsTd
 42MZW0yq7P6JIxCw0sU9n2BzLaiGgoMiav/8WPWqLT+dLv2IHpZahwYZpRPTNaGxK0mz
 WEBGaNlT/xdTSpUnmEiQ4S6XS1fxr6hTXtU5jt4xZB7c2Fjum3T4jecN6SvqNdDLi6KH
 FGiEh6ebUb6CnyIqxNlC4t4wzlyFgmaYF6dJtOY6XWzQvV5L6VojTSXi70K2EgMpBCtc
 SSTFPbIcQT6bIG7GTvoqzlt+O0WHFwo3BI2Q0hSR/iuC0HnOebwLOG5owcEV4o1L324h
 g4BQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnC8ODzYOVajygDUy+rl8wuAPmLFOtiyLaT2ZtuAZvFYL/wteHmWQWVo3lHXwgt/WkRNrPYX4=@lists.denx.de
X-Gm-Message-State: AOJu0YzE2EqFc4B49smVGSERSX9xR3u6GtZWLRWcNBdNFMIkgtLObUR0
 Ni+G5g+9T4gPwBHRiskMj9qQBsIj3jfsO6QFuKOwSFbV4d0O1g1G3s3SeOEB47D+5Ik65KjdIuj
 o0gNcQk7A+za1ZQaZEdImABkfNxjR2fCXaXq3rw==
X-Gm-Gg: ASbGncuTpEM600wNEbGrrnZrRw8Cr15NPRH9zveJzVmHIX9J1nnMgAeiuCJmZ7Sb2Qz
 gRO5NDALH3+S4Ifx/86gmjl3hPhSs57/+Z5Dj8n4N7jFWUbeFCcUH2VXEhHPeGZ8=
X-Google-Smtp-Source: AGHT+IGjuEuSrOmWaCSufAhCMogK613Q5tyBTnGdNIjyTG1RxITf0vf02z/EVtWXTOrEJ9Oaho6d3ig+GlJ5whE2O/w=
X-Received: by 2002:a05:6102:dcb:b0:4b6:1a4e:9ed7 with SMTP id
 ada2fe7eead31-4b690bb4cedmr23629899137.5.1737716203923; Fri, 24 Jan 2025
 02:56:43 -0800 (PST)
MIME-Version: 1.0
References: <20250120105045.1281262-1-sughosh.ganu@linaro.org>
 <20250120105045.1281262-2-sughosh.ganu@linaro.org>
 <67f57223-2c0d-414b-9e8c-138fdc57d92a@gmx.de>
 <CADg8p979JG5QVQi_Qc7520xHvkmcr7PpJq6kHJ8qN204sL7uoQ@mail.gmail.com>
In-Reply-To: <CADg8p979JG5QVQi_Qc7520xHvkmcr7PpJq6kHJ8qN204sL7uoQ@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 24 Jan 2025 16:26:33 +0530
X-Gm-Features: AWEUYZmIzQOVCz87JQ6tJ7ITYCkWCaJGOiY2Hn5L5V0ujZC4olTchr2k6-iazeM
Message-ID: <CADg8p95-toyV1HU387ysFZQDYx9b98HwMiADfjeevZgFK541YQ@mail.gmail.com>
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

On Mon, 20 Jan 2025 at 19:32, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Mon, 20 Jan 2025 at 18:01, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > On 20.01.25 11:50, Sughosh Ganu wrote:
> > > From: Masahisa Kojima <kojima.masahisa@socionext.com>
> > >
> > > One of the problems OS installers face, when running in EFI, is that
> > > the mounted ISO after calling ExitBootServices goes away. For some
> > > distros this is a problem since they rely on finding some core packages
> > > before continuing the installation. Distros have works around this --
> > > e.g Fedora has a special kernel command line parameter called
> > > inst.stage2 [0].
> > >
> > > ACPI has NFIT and NVDIMM support to provide ramdisks to the OS, but we
> > > don't have anything in place for DTs. Linux and device trees have support
> > > for persistent memory devices. So add a function that can inject a pmem
> > > node in a DT, so we can use it when launhing OS installers with EFI.
> >
> > We also have ACPI support in U-Boot. In a future patch series I guess we
> > could add the generation of said ACPI tables.
> >
> > >
> > > [0]
> > > https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/html/installation_guide/chap-anaconda-boot-options#sect-boot-options-installer
> > >
> > > Signed-off-by: Masahisa Kojima <kojima.masahisa@socionext.com>
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > > Changes since V2:
> > > * Fix a checkpatch error by putting a blank line after a function
> > >
> > >   boot/fdt_support.c    | 40 +++++++++++++++++++++++++++++++++++++++-
> > >   include/fdt_support.h | 13 +++++++++++++
> > >   2 files changed, 52 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> > > index 49efeec3681..613685b80eb 100644
> > > --- a/boot/fdt_support.c
> > > +++ b/boot/fdt_support.c
> > > @@ -18,6 +18,7 @@
> > >   #include <dm/ofnode.h>
> > >   #include <linux/ctype.h>
> > >   #include <linux/types.h>
> > > +#include <linux/sizes.h>
> > >   #include <asm/global_data.h>
> > >   #include <asm/unaligned.h>
> > >   #include <linux/libfdt.h>
> > > @@ -464,7 +465,6 @@ void do_fixup_by_compat_u32(void *fdt, const char *compat,
> > >       do_fixup_by_compat(fdt, compat, prop, &tmp, 4, create);
> > >   }
> > >
> > > -#ifdef CONFIG_ARCH_FIXUP_FDT_MEMORY>   /*
> > >    * fdt_pack_reg - pack address and size array into the "reg"-suitable stream
> > >    */
> > > @@ -493,6 +493,7 @@ static int fdt_pack_reg(const void *fdt, void *buf, u64 *address, u64 *size,
> > >       return p - (char *)buf;
> > >   }
> > >
> > > +#ifdef CONFIG_ARCH_FIXUP_FDT_MEMORY
> >
> > Do we need this #ifdef at all? We tend to leave it to the linker to
> > eliminate functions.
>
> This patch was authored by Kojima-san. I will have to check if we need
> to keep the ifdef.

I tried removing the ifdef from the said location. However, this
causes a size increase on platforms where this config symbol is not
enabled -- I tried this with the xilinx_zynqmp_virt_defconfig. This
could be because the fdt_fixup_memory() function is included on all
platforms as it gets called from cmd/fdt.c. The fdt_fixup_memory()
function calls fdt_fixup_memory_banks() which is protected by this
ifdef. Removing the ifdef then results in the fdt_fixup_memory_banks()
getting included, instead of the empty stub resulting in the size
increase.

-sughosh

>
> >
> > >   #if CONFIG_NR_DRAM_BANKS > 4
> > >   #define MEMORY_BANKS_MAX CONFIG_NR_DRAM_BANKS
> > >   #else
> > > @@ -2222,3 +2223,40 @@ int fdt_valid(struct fdt_header **blobp)
> > >       }
> > >       return 1;
> > >   }
> > > +
> > > +int fdt_fixup_pmem_region(void *blob, ulong addr, u32 size)
> > > +{
> > > +     u64 pmem_start[2] = { 0 };
> > > +     u64 pmem_size[2] = { 0 };
> > > +     char pmem_node[32] = {0};
> > > +     int nodeoffset, len;
> > > +     int err;
> > > +     u8 tmp[4 * 16]; /* Up to 64-bit address + 64-bit size */
> > > +
> > > +     if (!IS_ALIGNED(addr, SZ_2M) || !IS_ALIGNED(addr + size, SZ_2M)) {
> > > +             printf("Start and end address needs at 2MB alignment\n");
> >
> > Nits:
> >
> > %s/needs at 2MB alignment/must be 2 MiB aligned/
>
> Will change
>
> >
> > > +             return -1;
> > > +     }
> > > +     snprintf(pmem_node, sizeof(pmem_node), "pmem@%lx", addr);
> > > +     nodeoffset = fdt_find_or_add_subnode(blob, 0, pmem_node);
> > > +     if (nodeoffset < 0)
> > > +             return nodeoffset;
> > > +
> > > +     err = fdt_setprop_string(blob, nodeoffset, "compatible", "pmem-region");
> > > +     if (err)
> > > +             return err;
> > > +     err = fdt_setprop_empty(blob, nodeoffset, "volatile");
> > > +     if (err)
> > > +             return err;
> > > +     pmem_start[0] = addr;
> > > +     pmem_size[0] = size;
> > > +     len = fdt_pack_reg(blob, tmp, pmem_start, pmem_size, 1);
> > > +     err = fdt_setprop(blob, nodeoffset, "reg", tmp, len);
> > > +     if (err < 0) {
> > > +             printf("WARNING: could not set pmem %s %s.\n", "reg",
> > > +                    fdt_strerror(err));
> > > +             return err;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > diff --git a/include/fdt_support.h b/include/fdt_support.h
> > > index f0ad2e6b365..aea24df828f 100644
> > > --- a/include/fdt_support.h
> > > +++ b/include/fdt_support.h
> > > @@ -507,4 +507,17 @@ void fdt_fixup_pstore(void *blob);
> > >    */
> > >   int fdt_kaslrseed(void *blob, bool overwrite);
> > >
> > > +/**
> > > + * fdt_fixup_pmem_region() - add a pmem node on the device tree
> > > + *
> > > + * This functions injects a pmem node to the device tree. Usually
> > > + * used with EFI installers to preserve installer images
> >
> > If I understand the code correctly, the function adds or updates a pmem
> > device-tree node for the given start address.
>
> Will reword the comment.
>
> -sughosh
>
> >
> > Otherwise looks good to me.
> >
> > Best regards
> >
> > Heinrich
> >
> > > + *
> > > + * @blob:    device tree provided by caller
> > > + * @addr:    start address of the pmem node
> > > + * @size:    size of the memory of the pmem node
> > > + * Return:   0 on success or < 0 on failure
> > > + */
> > > +int fdt_fixup_pmem_region(void *blob, ulong addr, u32 size);
> > > +
> > >   #endif /* ifndef __FDT_SUPPORT_H */
> >
