Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 395F3D41C3F
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 13:04:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C11DB89274;
	Wed, 13 Nov 2024 14:04:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PKkJrElU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6F0089274; Wed, 13 Nov 2024 14:04:50 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 737B38919B
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 14:04:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c9404c0d50so8148998a12.3
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 05:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731503088; x=1732107888; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=roEEbApTHxlj8W/1lhW1Ga54k/hd+i8aDVNvKUceg9Y=;
 b=PKkJrElUx4YHh3rXrrVwmS4dPonX4XkatyIjZqW1jZjyv7exn7T2kJQeeCSRYiRdIx
 3q3+KD6p+SpoYi4N8LVZP8JIcZHIB3cnm7b1Z0BX39yqm70DVy7aRLoqj46PFvRe8qI5
 EcQpdBdnNNLVqfQV201EZGnhJZDTlOsuDOp9kfAXgMhKnr6FR4t7QQ5IHxpE59KlwlmJ
 tyH5B9MkGHNDNsjYFfmGMCyKC8unoz5TRdecMAmboaAm+T67yLkpBO+EZNrP4YF6PJjv
 /WQV3lc8vDtxlapxOO415/gtrsQsvbNpYwGgWFtF4xUYleHvKDpyZPWwk/F7Xa8nLQTp
 7p4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731503088; x=1732107888;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=roEEbApTHxlj8W/1lhW1Ga54k/hd+i8aDVNvKUceg9Y=;
 b=D8J9lxWS1H+3t8GfJ9VsWWEAogXWQ3vZE3dgZqvhDUSBO+a3sHl1MXYogKk0juks+i
 QYbngrglA/b4UuSqQ49MUEUY2zHklF1FxK5KFICsPvapHjr6DCOaTfwk3cj2fcc48VhL
 lwKQC/iLRgdkkzasosw1zUODEvLFr3uOvG7vR0QFEGBQcGGf+m4uXZb21lqbdU1vOCYT
 HD23eltQOZSjjfka+r5dqmJHvk85H0icsutnn74LfaNqJq3hzY7wcJ10aq3X273wv8xk
 xg6vJ80jRHJWeSZeO+VcZPLmV9CJMVBwcMnRRZRbeHfGleZRs02903sDOeUqIoioOVe4
 +uxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+DQ+5UyRmAahbQn3mZby5qZt5A7XSyT2OesBpiB7X5sK4/B5ooIZVicaaRSD9efih2N9nYGI=@lists.denx.de
X-Gm-Message-State: AOJu0Yz3hXv8gYB4BegQiph29KirrPuybCmE1yCRAhLq7SMr0cdPVkd3
 JHnT1T8/9adv4rgNhqaONbLfvuO16mA9ulBKO8wdEV73dbqznn+mU+chF7xvuOso5v60QMJd/X1
 CYCfrdN2hrWi2CP2iSr3ME+WH+9IBSWoq7USi1Q==
X-Google-Smtp-Source: AGHT+IGHuj7IgN9C5E3i65YIJL7V6zUz6osmhi244Xb+CUD3T9jPiLcT1wK6yo074asez9Rej0EFVeuyUXShmU0V5vw=
X-Received: by 2002:a05:6402:5109:b0:5cf:7282:8059 with SMTP id
 4fb4d7f45d1cf-5cf728280c4mr264015a12.19.1731503087764; Wed, 13 Nov 2024
 05:04:47 -0800 (PST)
MIME-Version: 1.0
References: <20241112131830.576864-1-sjg@chromium.org>
 <CADg8p949qx=irjZKgf9-B4wtCYx1pDj29LFH86YR4T1zyKtAvg@mail.gmail.com>
 <CAC_iWj+U945S96mE4E3d_bLxQ-9iQhErXBaJW0WCpLB1X=VVqQ@mail.gmail.com>
 <dc1d08c6-45c9-4826-bae4-15bd1216ea7e@gmx.de>
In-Reply-To: <dc1d08c6-45c9-4826-bae4-15bd1216ea7e@gmx.de>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 13 Nov 2024 18:34:36 +0530
Message-ID: <CADg8p94OnmXEf2zOxgdus2khm9edas-cO3PkiQRckkVO70-+CA@mail.gmail.com>
Subject: Re: [PATCH] Revert "efi_memory: do not add U-Boot memory to the
 memory map"
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
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

On Wed, 13 Nov 2024 at 18:03, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 11/13/24 12:28, Ilias Apalodimas wrote:
> > Hi Sughosh
> >
> > On Tue, 12 Nov 2024 at 20:46, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >>
> >> On Tue, 12 Nov 2024 at 18:48, Simon Glass <sjg@chromium.org> wrote:
> >>>
> >>> A bisect of Ubuntu 2022.04 boot-failure on qemu-x86_64 resulted in this
> >>> patch. I am not sure how to investigate it.
> >>>
> >>> The boot hangs at some point during booting of the install image, before
> >>> the Ubuntu logo appears.
>
> I tried to replicate the problem with an Ubuntu 24.04.1 cloud image
> using a 6.8 kernel.
>
> I see efi_exit_boot_services being reached but not
> efi_set_virtual_address_map. The kernel seems to be stuck in an endless
> loop in a virtual address range (0xffffffff????????).

There are two issues to consider here. As Ilias had pointed out, I
looked at why the U-Boot memory region was showing up as Reserved. And
turns out that the e820 platform code defines efi_add_known_memory(),
and this function seems to be overwriting memory regions' attribute
with what gets set by the lmb code. So it turns out that the lmb code
is setting the U-Boot memory region as EFI_BOOT_SERVICES_CODE indeed.
But the install_e820_map() function in arch/x86/cpu/qemu/e820.c is
setting the memory region occupied by U-Boot as reserved. This was
getting masked earlier, as the add_u_boot_and_runtime() would set the
U-Boot memory region with correct attributes. I think the correct fix
would be to not mark the U-Boot memory regions as reserved by the e820
platform code.

In addition to the above, the x86 architecture specific efi stub code
seems to require a region of memory with EfiBootServicesCode memory.
But looking at the EFI spec, I do not see where this is mandated --
the spec only seems to mention that after the ExitBootServices() call,
the EFI OS loader can treat EfiBootServices{Code,Data} as available
free memory. Agreed that it would be better to mark the region of
memory occupied by the firmware as EfiBootServicesCode, but then that
would still not be strictly correct, as the U-Boot region contains
code as well as data. So marking the region of memory occupied by
U-Boot as EfiBootServicesData should not be an issue, at least based
on what I understand. Moreover since this looks like a requirement
only for the x86 architecture.

-sughosh

>
> The memory map looks wrong:
>
> => efidebug memmap
> Type             Start            End              Attributes
> ================ ================ ================ ==========
> CONVENTIONAL     0000000000000000-00000000000a0000 WB
> RESERVED         00000000000a0000-00000000000f0000 WB
> ACPI RECLAIM MEM 00000000000f0000-00000000000f1000 WB
> RESERVED         00000000000f1000-0000000000100000 WB
> CONVENTIONAL     0000000000100000-000000003dca4000 WB
> BOOT DATA        000000003dca4000-000000003dca6000 WB
> RUNTIME DATA     000000003dca6000-000000003dca7000 WB|RT
> BOOT DATA        000000003dca7000-000000003dca8000 WB
> RUNTIME DATA     000000003dca8000-000000003dcca000 WB|RT
> BOOT DATA        000000003dcca000-000000003ecda000 WB
> RESERVED         000000003ecda000-000000003ece0000 WB
> ACPI RECLAIM MEM 000000003ece0000-000000003ed02000 WB
> RUNTIME DATA     000000003ed02000-000000003ed03000 WB|RT
> RESERVED         000000003ed03000-000000003ef1a000 WB
> RUNTIME CODE     000000003ef1a000-000000003ef1c000 WB|RT
> RESERVED         000000003ef1c000-0000000040000000 WB
> RESERVED         00000000e0000000-00000000f0000000 WB
>
> The relocated U-Boot code should not be marked as EfiReservedMemoryType
> but as EfiServicesCode according to the UEFI specification.
>
> The ACPI table is marked as EfiACPIReclaimMemory but I don't think
> memory in the BIOS memory range should be reclaimable. In the journal on
> my laptop I see
>
> BIOS-provided physical RAM map
> BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
>
> The e820 table is generated from the EFI memory map in setup_e820() of
> the Linux efi stub.
>
> Best regards
>
> Heinrich
>
> >>>
> >>> I will sent a series with a script showing how it is run.
> >>>
> >>> This reverts commit a68c9ac5d8afc51c619c5d3e865fcf147bea90cb.
> >>>
> >>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>> ---
> >>
> >> This seems to be an issue specific to the x86 architecture. The
> >> installation works on arm64 and riscv (confirmed by Heinrich)
> >> architectures. I checked the output of the EFI memory map with the
> >> above commit against the master branch, and the only difference is
> >> that with this revert, the EFI memory map has the u-boot memory region
> >> marked as EFI_BOOT_SERVICES_CODE, whereas without this commit, that
> >> region is marked as reserved.
> >
> > Hmm why? LMB is adding this with EFI_BOOT_SERVICES_CODE  in
> > lmb_map_update_notify(). Who's switching it to reserved?
> > This is a pretty big change since the memory switches from reusable to
> > reserved for the OS.
> >
> >> I need to look into this in more detail,
> >> but it would seem like the x86 kernel (or some efi stub code ?) is
> >> expecting some region of memory marked as EFI_BOOT_SERVICES_CODE,
> >> which is not the case for other architectures.
> >
> > Not EFI_BOOT_SERVICES_CODE explicitly, probably just a reusable type of memory.
> >
> > Cheers
> > /Ilias
> >
> >
> >
> >>
> >> -sughosh
> >>
> >>>
> >>>   lib/efi_loader/efi_memory.c | 10 ++++++++++
> >>>   1 file changed, 10 insertions(+)
> >>>
> >>> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> >>> index d2f5d563f2a..c7400ec9854 100644
> >>> --- a/lib/efi_loader/efi_memory.c
> >>> +++ b/lib/efi_loader/efi_memory.c
> >>> @@ -809,6 +809,16 @@ static void add_u_boot_and_runtime(void)
> >>>   {
> >>>          unsigned long runtime_start, runtime_end, runtime_pages;
> >>>          unsigned long runtime_mask = EFI_PAGE_MASK;
> >>> +       unsigned long uboot_start, uboot_pages;
> >>> +       unsigned long uboot_stack_size = CONFIG_STACK_SIZE;
> >>> +
> >>> +       /* Add U-Boot */
> >>> +       uboot_start = ((uintptr_t)map_sysmem(gd->start_addr_sp, 0) -
> >>> +                      uboot_stack_size) & ~EFI_PAGE_MASK;
> >>> +       uboot_pages = ((uintptr_t)map_sysmem(gd->ram_top - 1, 0) -
> >>> +                      uboot_start + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT;
> >>> +       efi_add_memory_map_pg(uboot_start, uboot_pages, EFI_BOOT_SERVICES_CODE,
> >>> +                             false);
> >>>
> >>>   #if defined(__aarch64__)
> >>>          /*
> >>> --
> >>> 2.34.1
> >>>
>
