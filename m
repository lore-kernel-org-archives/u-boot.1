Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE8DE77184
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 19:45:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0DB8801CE;
	Tue, 17 Dec 2024 20:45:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Rbn3jfvJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F23A5801FB; Tue, 17 Dec 2024 20:45:27 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 441D280107
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 20:45:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aa6aee68a57so836349166b.3
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 11:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734464725; x=1735069525; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uA9TOGWMva5j6djX4MlX3j3fAwZ2NNdQ5Nzf+105UhI=;
 b=Rbn3jfvJNf6OLIrcuqMYgUAUtNWKIpMjrbVI7zBERB4FSzNTad6OxSWvTfBibakaLW
 hcMOKFATIPNsn/jlDQKRnv2y2+ieAk/AhZzLHvp9xGjNEs2A56i/+EmdyUQ5jzMduy+2
 I/WZF901Ns7ckGfnf/RB8zMUAHw3h2rjKsp9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734464725; x=1735069525;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uA9TOGWMva5j6djX4MlX3j3fAwZ2NNdQ5Nzf+105UhI=;
 b=uL2Kzg1z5N8NxN6A8nHfCF3krWYsqKlcgwhDYR9LVWcwUtP4P0KN5/j9wQdNiS20cu
 23FcpX458rLgfaYO66n5ewWU3RgC1vvv53Hx5ri6CD2rZx+zygWIF5A2U+R7coRWv6qF
 eDbKmIclPNdx3a1Quk5WaXE4wm1XRkQwxkVpq66CMxtBtdWJmapNYEjfSPC2v6/Ktt3z
 8T74bPxOrGpuiN1piay/+jJafyEpwdpFTk+Grzh+GzqFqIR7Rduqnd3vCaQkcpDCW6j/
 9rzb5TWtIwPnqHJKWPdP9+/0534cY3xXtDk90NSUMWg9TgGjZndQygVKyEE/PUBxLWQa
 5eIw==
X-Gm-Message-State: AOJu0Yyh5/Lm2kuXpXnNzqZpAFQeKZRhNEtIKrsmRgnaq5LskcJ0zBCI
 4BeFM7uO2FP/x7RNtsEZZEaFxPZXPUc6ubkuMIFrJGcK6tDgmhwDX+OJ/pgK9pKjfbEnhuBVpEu
 Kpu5KVBHuYD00dYoGNJM1ZlV1kIfbtLA3RgYJ
X-Gm-Gg: ASbGncvDWPqd8qHSmj49RCQHxT8UZTiUKgBOXFz9wCs5UAE0iMrp77WWFidFv1d7A5y
 qG1sOaBDD6bLowUXbQL61elRX7yRJ7ZX62vxlvwo=
X-Google-Smtp-Source: AGHT+IF7w9pl/2BA/FsWC7v1R7efWgH/HjME+ITqQZCeSqy0ehy0lEMIlJj45sv5FDdqce+LSpCMLtSly4BVFj4fIl4=
X-Received: by 2002:a17:906:f586:b0:aa6:79fa:b480 with SMTP id
 a640c23a62f3a-aab778c1dcamr1611736966b.10.1734464724523; Tue, 17 Dec 2024
 11:45:24 -0800 (PST)
MIME-Version: 1.0
References: <20241211135418.563803-1-sjg@chromium.org>
 <CAC_iWjLXtTxbbcjf=dG=OpnNMh69HW69xpg4DJ4Es4TLjikgXg@mail.gmail.com>
 <CAFLszTghBQ6pMi4mrBwnWONwzS=dLC8k+VV+9gn75J8bVn=6vQ@mail.gmail.com>
 <CAC_iWjJVjYiywhCbcLDpZuriKGobxxdPYS2LQYod00JadHd1fw@mail.gmail.com>
 <CAFLszTiU0WXytXAWrp763dY9XZSfuk8GONhnoOFZCbZzpoqgNQ@mail.gmail.com>
 <CAFLszThNvbxZWOmLky0jpFPeUgFhAaFLVkMVVk9UCCP_PFSTTA@mail.gmail.com>
 <CAC_iWjKpMY11rXakk8xqEGk=UNn5bAAjqtBq-CAmVVOBBUrWRg@mail.gmail.com>
In-Reply-To: <CAC_iWjKpMY11rXakk8xqEGk=UNn5bAAjqtBq-CAmVVOBBUrWRg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 17 Dec 2024 12:45:12 -0700
Message-ID: <CAFLszTjUaOwFSjQME++L1Ci62t6jMxP6WYgGBxaW=PvqPczYAA@mail.gmail.com>
Subject: Re: [PATCH v5 00/23] efi: Tidy up confusion between pointers and
 addresses
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Janne Grunau <j@jannau.net>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Matthew Garrett <mgarrett@aurora.tech>, Matthias Brugger <mbrugger@suse.com>, 
 Moritz Fischer <moritzf@google.com>, Patrick Wildt <pwildt@google.com>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, 
 Stefan Roese <sr@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

Hi Ilias,

On Tue, 17 Dec 2024 at 00:09, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Mon, 16 Dec 2024 at 17:14, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi again Ilias,
> >
> > On Fri, 13 Dec 2024 at 07:02, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Ilias,
> > >
> > > On Thu, 12 Dec 2024 at 08:51, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > On Thu, 12 Dec 2024 at 15:45, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Ilias,
> > > > >
> > > > > On Wed, 11 Dec 2024 at 23:40, Ilias Apalodimas
> > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > >
> > > > > >  Hi Simon,
> > > > > >
> > > > > > On Wed, 11 Dec 2024 at 15:54, Simon Glass <sjg@chromium.org> wrote:
> > > > > > >
> > > > > > > The EFI-loader implementation converts things back and forth between
> > > > > > > addresses and pointers, with not much consistency in how this is done.
> > > > > > >
> > > > > > > Within most of U-Boot a pointer is a void * and an address is a ulong
> > > > > > >
> > > > > > > This convention is very helpful, since it is obvious in common code as
> > > > > > > to whether you need to call map_sysmem() and friends, or not.
> > > > > > >
> > > > > > > As part of cleaning up the EFI memory-management, I found it almost
> > > > > > > impossible to know in some cases whether something is an address or a
> > > > > > > pointer. I decided to give up on that and come back to it when this is
> > > > > > > resolved.
> > > > > > >
> > > > > > > This series starts applying the normal ulong/void * convention to the
> > > > > > > EFI_loader code, so making things easier to follow. For now, u64 is
> > > > > > > often used instead of ulong, but the effect is the same.
> > > > > > >
> > > > > > > The main changes are:
> > > > > > > - Rather than using the external struct efi_mem_desc data-structure for
> > > > > > >   internal bookkeeping, create a new one, so it can have different
> > > > > > >   semantics
> > > > > > > - Within efi_memory.c addresses are used, rather than addresses
> > > > > > >   masquerading as pointers. The conversions are done in efi_boottime
> > > > > > >
> > > > > > > Unforunately my foray into attempting to use enum for the memory type
> > > > > > > failed. The problem is not just that the external interface cannot use
> > > > > > > an enum. In fact the enum in the spec is really just confusing, since
> > > > > > > values not mentioned in the enum are valid. While we could handle this
> > > > > > > by declaring a few more values in enum efi_memory_type, it doesn't seem
> > > > > > > worth it. For example, if we declare 0x6fffffff and -1 as valid values,
> > > > > > > we get the correct range, but then we need to be careful about
> > > > > > > conversion in efi_boottime. If we declare 0xffffffff as valid, then the
> > > > > > > enum ends up being 64-bits wide! Yes, that would work, I suppose it
> > > > > > > wouldn't matter, but at that point I believe using an enum is actually
> > > > > > > more confusing than not. It also made passing SCT tricky, since invalid
> > > > > > > values are passed in...
> > > > > > >
> > > > > >
> > > > > > So my general feedback on this is
> > > > > > - Split it into a number of reviewable patches
> > > > > > - Send the typos & doc changes in one patchset that we can easily pick
> > > > > > up since it's mostly reviewed
> > > > > > - Drop the two patches that add 'sjg' stuff that are removed later
> > > > > > - Investigate why there's a reserved member in efi_mem_desc -- which I
> > > > > > think is a bug and send the fix as a single patch
> > > > > > - Drop the renames and duplication of efi_mem_desc with priv_mem_desc.
> > > > > > I don't see any point in duplication that, keeping the memory
> > > > > > descriptors in a list as it currently works is fine
> > > > >
> > > > > All the other points are OK, just more work. However, this one defeats
> > > > > the purpose of the series. As you can see, I am lining up the EFI
> > > > > internal-table more with how U-Boot and lmb do things, with addresses.
> > > >
> > > > I think Heinrich and I have repeated this more than once.
> > >
> > > As an aside, I notice that you say this every now and then but I don't
> > > think you realise how it comes across to the other person.
> > >
> > > > EFI works
> > > > with physical addresses, just like sandbox needs to map_sysmem. It's
> > > > way easier for us to review and look at code exactly how the spec
> > > > describes it.
> > >
> > > So it looks like this series is not going to fly, because you *want*
> > > the internal EFI tables to hold pointers-as-u64, rather than
> > > addresses. You don't want to do that translation at the EFI boundary.
> > > Is that right?
> >
> > Just let me know what you want to do here. From what you said, this is
> > a NAK, but if I have interpreted this incorrectly, and you are OK with
> > the concept and just want some code changes, PLMK.
>
> It's all summarized here
> https://lore.kernel.org/u-boot/CAFLszThNvbxZWOmLky0jpFPeUgFhAaFLVkMVVk9UCCP_PFSTTA@mail.gmail.com/T/#m5ce9e8591ee5889134b47983731113e66b624ef9

OK, I understand that the address/pointer thing does not suit you.

I'll apply this to my tree for now.

>
> Thanks
> /Ilias
> >
> > >
> > > Also the reason for duplicating that in the commit
> > > > message is
> > > > - the name is confusing, which reallys int
> > >
> > > I am unsure what you are referring to here.
> > >
> > > > - The 'reserved' filed isn't needed, which is probably just a generic
> > > > bug in the EFI struct  definition
> > >
> > > I was surprised to see that I wrote that code. My guess is that it is
> > > there to ensure the alignment is correct. The first field is u32 and
> > > the third is u64 so perhaps I was concerned that the compiler would
> > > not naturally align the u64? It was over 9 years ago and I don't
> > > remember.
> > >
> > > struct efi_mem_desc {
> > >    u32 type;
> > >    u32 reserved;
> > >    efi_physical_addr_t physical_start;
> > >    efi_virtual_addr_t virtual_start;
> > >    u64 num_pages;
> > >    u64 attribute;
> > > };
> > >
> > > The spec says "Unless otherwise specified all data types are naturally
> > > aligned. Structures are aligned on
> > > boundaries equal to the largest internal datum of the structure and
> > > internal data are implicitly padded to
> > > achieve natural alignment."
> > >
> > > I'm pretty sure any compiler that we use will handle this, so you are
> > > right, we don't need the field.
> > >
> > > Regards,
> > > Simon
> > >
> > > >
> > > >
> > > > Thanks
> > > > /Ilias
> > > > > I cannot use both addresses and pointers in the same struct...I
> > > > > initially did that but it was just far too confusing.
> > > > >
> > > > > > - Send the map_to_sysmem() places you need in a different patchset
> > > > > > with an explanation of *why* this is working currently (or not
> > > > > > working)
> > > > > >
> > > > > > Hope this helps
> > > > > > /Ilias
> > > > > >
> > > > > > > Link: https://lore.kernel.org/u-boot/20240725135629.3505072-1-sjg@chromium.org/
> > > > > > >
> > > > > > > Changes in v5:
> > > > > > > - Drop the enum / mem_type patch as it is not needed
> > > > > > > - Drop the patch to remove extra brackets in efi_mem_carve_out()
> > > > > > >
> > > > > > > Changes in v4:
> > > > > > > - Add new patch to show the address for pool allocations
> > > > > > > - Combine the various pointer-to-address patches into one
> > > > > > >
> > > > > > > Changes in v3:
> > > > > > > - Adjust comments
> > > > > > > - Show the returned address rather than the pointer
> > > > > > > - Put the header-file in its own section
> > > > > > > - Add comment to struct efi_device_path_memory
> > > > > > > - Use a pointer for the values in struct efi_device_path_memory
> > > > > > >
> > > > > > > Changes in v2:
> > > > > > > - Fix missing @
> > > > > > > - Note that this holds pointers, not addresses
> > > > > > > - Add a new patch with comments where incorrect addresses are used
> > > > > > > - Use EFI_PRINT() instead of log_debug()
> > > > > > > - Rebase on early patch
> > > > > > > - Add new patch to add the EFI-loader API documentation
> > > > > > > - Add new patch to use a separate stuct for memory nodes
> > > > > > > - Drop patch 'Convert efi_get_memory_map() to return pointers'
> > > > > > > - Drop patch 'efi_loader: Make more use of ulong'
> > > > > > > - Significantly expand and redirect the series
> > > > > > >
> > > > > > > Simon Glass (23):
> > > > > > >   efi: Define fields in struct efi_mem_desc
> > > > > > >   efi_loader: Fix typos in enum efi_allocate_type
> > > > > > >   efi_loader: Add comments where incorrect addresses are used
> > > > > > >   efi_loader: Show the resulting memory address from an alloc
> > > > > > >   efi_loader: Update startimage_exit self-test to check error
> > > > > > >   efi_loader: Move some memory-function comments to header
> > > > > > >   doc: efi: Add the EFI-loader API documentation
> > > > > > >   efi_loader: Use a separate struct for memory nodes
> > > > > > >   efi_loader: Drop virtual_start from priv_mem_desc
> > > > > > >   efi_loader: Drop reserved from priv_mem_desc
> > > > > > >   efi_loader: Use the enum for the memory type in priv_mem_desc
> > > > > > >   efi_loader: Avoid assigning desc in efi_mem_carve_out()
> > > > > > >   efi_loader: Move struct efi_mem_list fields together
> > > > > > >   efi_loader: Rename struct efi_mem_list to mem_node
> > > > > > >   efi_loader: Rename physical_start to base
> > > > > > >   efi_loader: Use correct type in efi_add_runtime_mmio()
> > > > > > >   efi_loader: Show the address for pool allocations
> > > > > > >   efi_loader: Don't try to add sandbox runtime code
> > > > > > >   efi_loader: Update to use addresses internally
> > > > > > >   efi_loader: Correct address-usage in copy_fdt()
> > > > > > >   efi_loader: Drop comments about incorrect addresses
> > > > > > >   efi_bootmgr: Avoid casts in try_load_from_uri_path()
> > > > > > >   efi_loader: Simplify efi_dp_from_mem()
> > > > > > >
> > > > > > >  arch/arm/cpu/armv8/fsl-layerscape/cpu.c       |   2 +-
> > > > > > >  arch/arm/mach-bcm283x/reset.c                 |   2 +-
> > > > > > >  doc/api/efi.rst                               |   6 +
> > > > > > >  include/efi.h                                 |  23 +-
> > > > > > >  include/efi_api.h                             |  10 +
> > > > > > >  include/efi_loader.h                          |  87 +++++-
> > > > > > >  lib/efi_loader/efi_bootbin.c                  |   3 +-
> > > > > > >  lib/efi_loader/efi_bootmgr.c                  |  10 +-
> > > > > > >  lib/efi_loader/efi_boottime.c                 |  43 ++-
> > > > > > >  lib/efi_loader/efi_device_path.c              |  16 +-
> > > > > > >  lib/efi_loader/efi_dt_fixup.c                 |   4 -
> > > > > > >  lib/efi_loader/efi_helper.c                   |   4 +-
> > > > > > >  lib/efi_loader/efi_image_loader.c             |   3 +-
> > > > > > >  lib/efi_loader/efi_memory.c                   | 261 +++++++-----------
> > > > > > >  lib/efi_loader/efi_runtime.c                  |   7 +-
> > > > > > >  lib/efi_loader/efi_var_mem.c                  |   6 +-
> > > > > > >  .../efi_selftest_startimage_exit.c            |   6 +-
> > > > > > >  lib/lmb.c                                     |  10 +-
> > > > > > >  18 files changed, 278 insertions(+), 225 deletions(-)
> > > > > > >
> > > > > > > --
> > > > > > > 2.34.1
> > > > > > >

Regards,
Simon
