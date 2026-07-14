Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E57BC4450A
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 16:57:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D64D684D31;
	Tue, 14 Jul 2026 18:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="o3JlXECL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15BCF84D31; Tue, 14 Jul 2026 18:57:47 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10D6B84D22
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 18:57:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1784048257; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=J9VpSPZppWwxTnQsuErl2NO4Rivyy69SVb0kFBqTJblI1sofQiyjC3NUK+nHSQhsJoJXplJPnb3zyRP9g0pcCEj7907e4lnrP1JTaZtYnNStIDL00YIwHah0lE3Hf/JihvEQ+Szxy+Szv1agLXDy3vdK+A+YLz0KYPr7dsguZbM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784048257;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=5QpcDK58+soDBuqrMXLUyefSmNUJmFvPyYyNWw4RFAU=; 
 b=czKnErNuq/JjgYGiCvUUJbFP2/GmiaFdKtUHwJ8SKLsC8BG2/WGPcFTo7JOfLVXzRBiUUMJFt4ZAvnOJGLdFR+ZiIkia/mqtjrhSYj4H9fyCgVxKsprK7pEZJmqbxQuXHqMojBSsgQkq8Hzi2nx8vZpKEebhS92EHcReNveXb5Q=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784048257; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=5QpcDK58+soDBuqrMXLUyefSmNUJmFvPyYyNWw4RFAU=;
 b=o3JlXECLIK2BnXEJH9YILerpQqnfBAFq3RO9z3jCJ2Mrevb4kSzB819JZb5b/RWj
 LO/rALxtD/iVBTIkffpGzuLmCEuS3eig3s3zdFojEtAl0QsJNxt+QrnabTWuwU3cqu8
 mVdnm0IBLCfgvhkDxRbB9+2KB+jl5vh7vEVAIKZ4=
Received: by mx.zohomail.com with SMTPS id 178404825532855.905853835756375;
 Tue, 14 Jul 2026 09:57:35 -0700 (PDT)
Date: Tue, 14 Jul 2026 16:57:29 +0000
From: Yao Zi <me@ziyao.cc>
To: Simon Glass <sjg@chromium.org>, me@ziyao.cc
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 10/16] LoongArch: Boot Image bits
Message-ID: <alZqPsdSZ_Pd4RBF@pie>
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-11-me@ziyao.cc>
 <CAFLszTiXWp6CeENHzYnw0621NxwGta_Fk-06EO6JiZtKuP7MQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTiXWp6CeENHzYnw0621NxwGta_Fk-06EO6JiZtKuP7MQQ@mail.gmail.com>
X-ZohoMailClient: External
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

On Thu, Jul 02, 2026 at 11:26:23AM +0100, Simon Glass wrote:
> Hi Yao,
> 
> On 2026-07-01T11:17:53, Yao Zi <me@ziyao.cc> wrote:
> > LoongArch: Boot Image bits
> >
> > Implement loading and booting functions for LoongArch
> > standard kernel image as per spec.
> >
> > LoongArch kernel do expect us to fake a efi systemtable
> > for passing fdt to kernel, we don't need to implement any
> > EFI functions for kernel because it won't look into anything
> > beside devicetree from that table if we tell kernel we are
> > not efi compatible by setting a0 boot argument to zero.
> >
> > Link: https://docs.kernel.org/arch/loongarch/booting.html
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Signed-off-by: Yao Zi <me@ziyao.cc>
> >
> > arch/loongarch/lib/Makefile |   2 +
> >  arch/loongarch/lib/bootm.c  | 163 ++++++++++++++++++++++++++++++++++++++++++++
> >  arch/loongarch/lib/image.c  |  66 ++++++++++++++++++
> >  cmd/Kconfig                 |   2 +-
> >  4 files changed, 232 insertions(+), 1 deletion(-)

...

> > diff --git a/arch/loongarch/lib/bootm.c b/arch/loongarch/lib/bootm.c
> > @@ -0,0 +1,163 @@
> > +/* LoongArch do expect a EFI style systab */
> > +static int generate_systab(struct bootm_headers *images)
> > +{
> > +     const int nr_cfgtab = 1;
> > +     struct bd_info *kbd = images->kbd;
> > +     struct efi_system_table *systab;
> > +     struct efi_configuration_table *cfgtab;
> > +     size_t table_size = sizeof(struct efi_system_table) +
> > +                         nr_cfgtab * sizeof(struct efi_configuration_table);
> > +
> > +     systab = memalign(SZ_64K, table_size);
> 
> Please add a comment on why 64K alignment is required.

This is a mistake, we wrongly assumed the system table must be aligned
to page size, and on LoongArch the least common multiple among possible
page sizes (4K, 16K, 64K) is 64K. However such requirements do not
really exist at all, and I'll remove them in v3.

> > diff --git a/arch/loongarch/lib/bootm.c b/arch/loongarch/lib/bootm.c
> > @@ -0,0 +1,163 @@
> > +static void boot_jump_linux(struct bootm_headers *images, int flag)
> > +{
> > +     void (*kernel)(ulong efi_boot, char *argc, void *dtb);
> > +     int fake = (flag & BOOTM_STATE_OS_FAKE_GO);
> > +
> > +     kernel = (void (*)(ulong efi_boot, char *argc, void *dtb))images->ep;
> 
> The second argument is the kernel command line, not argc - please
> rename to cmdline. The third is the fake systab pointer, not a raw
> dtb; please rename that too.
> 
> > diff --git a/arch/loongarch/lib/bootm.c b/arch/loongarch/lib/bootm.c
> > @@ -0,0 +1,163 @@
> > +     if (!fake) {
> > +             if (CONFIG_IS_ENABLED(OF_LIBFDT) && images->ft_len)
> > +                     kernel(0, NULL, (void *)images->kbd->bi_boot_params);
> > +     }
> 
> Per the LoongArch booting spec, a1 is the kernel command line.
> Passing NULL means the bootargs env var never reaches the kernel
> via that path - it will only be seen in /chosen/bootargs
> 
> So don't you wan to pass images->cmdline_start here?

Yes, thanks for catching this. It doesn't cause any issues yet, since
LoongArch platform kernel code currently appends the cmdline passed in
a1 to /chosen/bootargs.

> Also, if OF_LIBFDT is disabled or ft_len is zero we drop through
> without jumping *after* announce_and_cleanup() has torn devices
> down. Please panic() / hang() in that case rather than silently return.

boot_prep_linux() does a check against OF_LIBFDT and ft_len, too, and
might emit an error and hang. I'm not very familiar with bootm, could
boot_jump_linux be called with BOOTM_STATE_OS_GO set but
BOOTM_STATE_OS_PREP unset, which is the only possible case of dropping
through this if? This doesn't really make sense to me at the first
glance...

But anyway, panic/hang() here makes the intention more clear, and I'm
willing to add one here.

> > diff --git a/arch/loongarch/lib/image.c b/arch/loongarch/lib/image.c
> > @@ -0,0 +1,66 @@
> > +struct linux_image_h {
> > +     uint32_t        code0;                  /* Executable code */
> > +     uint32_t        code1;                  /* Executable code */
> > +     uint64_t        kernel_entry;   /* Kernel entry point */
> > +     uint64_t        image_size;             /* Effective Image size */
> > +     uint64_t        load_offset;    /* load offset */
> > +     uint64_t        res1;                   /* reserved */
> > +     uint64_t        res2;                   /* reserved */
> > +     uint64_t        res3;                   /* reserved */
> > +     uint32_t        magic;                  /* Magic number */
> > +     uint32_t        pe_header;              /* Offset to the PE header */
> > +};
> 
> Comment tabs after kernel_entry/image_size/load_offset are
> inconsistent with the first two members - please tidy so the
> comments line up. Also use u32/u64 for consistency with the rest
> of U-Boot.
> 
> I have to wonder whether it would be OK to share this struct with
> RISC-V in a header file?

RISC-V header is compatible with the AArch64 one, but not the LoongArch
one, here's RISC-V's definition,

u32 code0;                /* Executable code */
u32 code1;                /* Executable code */
u64 text_offset;          /* Image load offset, little endian */
u64 image_size;           /* Effective Image size, little endian */
u64 flags;                /* kernel flags, little endian */
u32 version;              /* Version of this header */
u32 res1 = 0;             /* Reserved */
u64 res2 = 0;             /* Reserved */
u64 magic = 0x5643534952; /* Magic number, little endian, "RISCV" */
u32 magic2 = 0x05435352;  /* Magic number 2, little endian, "RSC\x05" */
u32 res3;                 /* Reserved for PE COFF offset */

LoongArch's header has an additional kernel_entry field, but no flags
field. It also has only one magic number. So I don't think merging
RISC-V and LoongArch's definitions make much sense.

> > diff --git a/arch/loongarch/lib/image.c b/arch/loongarch/lib/image.c
> > @@ -0,0 +1,66 @@
> > +     /* To workaround kernel supplying DMW based virtual address */
> > +     ep_phys = TO_PHYS(lhdr->kernel_entry);
> > +     *ep = *relocated_addr + (ep_phys - lhdr->load_offset);
> 
> Please expand this comment - from context it looks like kernel_entry
> is a DMW virtual address, and you are converting to a physical
> offset within the image and re-basing onto the relocated load
> address. Spell that out, with a pointer to the relevant paragraph
> of the booting spec.

DMW is abbreviated from Direct Mapping Window. Both load_offset and
kernel_entry should be physical addresses, respectively represent the
expected kernel image loading address and entry point. However, Linux
kernel before v6.10 wrongly fills in a DMW virtual address in
kernel_entry, so we must convert it back to physical address to
calculate the entrypoint offset relative to the image start.

On loongarch64, if an virtual address matches any configured DMW,
it would be translated to the physical address represented by its lowest
48 bits, and TO_PHYS() does the same thing.

Here's the Linux commit fixing the issue[1], and I'll make the comment
more clear in the next version.

> Regards,
> Simon

Regards,
Yao Zi

[1]: https://github.com/torvalds/linux/commit/beb2800074c1
