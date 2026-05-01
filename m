Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E9FCD3423
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 14:46:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04C2F842FC;
	Fri,  1 May 2026 16:46:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="OE+OX+Oe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C05083E36; Fri,  1 May 2026 16:38:12 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id DB03380086
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 16:38:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B05B82A9A;
 Fri,  1 May 2026 07:38:03 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.68.2])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 317FB3F7B4;
 Fri,  1 May 2026 07:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777646289; bh=ttzaPs/bY+ZYQrwjWPTEOd/zSTfEGjsD0HTq5GwWDrc=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
 b=OE+OX+OeYxjjNp5nJyt/kpDSu5cpJPwaf6NYaUk9RniSjtc6oakY10SP1h8ISuSVO
 cqEJnwqzsuvoZFeMoN4ccf65OyQZHPMQRn7D7Hg8fT/DlATtKgY+E30be7Gb2dC/cf
 eV3xIBLHVkU6YrYFK07OxIHnq8v8K08u9VKBXPt4=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] efi_loader: fix AllocatePages overlap status
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>, 
 u-boot@lists.denx.de, trini@konsulko.com
In-Reply-To: <28B9184F-96D7-45AF-84AA-98EB2ECE713A@gmx.de>
References: <20260427150530.3156000-1-harsimransingh.tungal@arm.com>
 <CAC_iWj+iD0m9JL+A++W85+sYQGYSqVHP287ga7g13dkVevy9AA@mail.gmail.com>
 <28B9184F-96D7-45AF-84AA-98EB2ECE713A@gmx.de>
Date: Fri, 01 May 2026 15:38:01 +0100
Message-Id: <177764628159.1446310.9289654256628987669.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Fri, 01 May 2026 16:46:21 +0200
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

On 2026-04-27 19:04 +0200, Heinrich Schuchardt wrote:
> Am 27. April 2026 17:48:21 MESZ schrieb Ilias Apalodimas <ilias.apalodimas@linaro.org>:
> >Hi Harsiman,
> >
> >On Mon, 27 Apr 2026 at 18:05, Harsimran Singh Tungal
> ><harsimransingh.tungal@arm.com> wrote:
> >>
> >> Return EFI_NOT_FOUND for EFI_ALLOCATE_ADDRESS overlap
> >>
> >> When efi_allocate_pages() is called with EFI_ALLOCATE_ADDRESS, UEFI
> >> expects EFI_NOT_FOUND if the requested address range is already
> >> allocated or unavailable.
> >>  U-Boot currently returns
> >> EFI_OUT_OF_RESOURCES when efi_update_memory_map() detects an overlap
> >> after a successful lmb_alloc_mem(), which does not match
> >> EFI_ALLOCATE_ADDRESS semantics.
> >>
> >> Return EFI_NOT_FOUND for EFI_ALLOCATE_ADDRESS requests that fail due
> >> to an overlapping EFI memory descriptor, while keeping
> >> EFI_OUT_OF_RESOURCES for other allocation types.
> >>
> >> The UEFI specification [1] specifies that
> >> EFI_BOOT_SERVICES.AllocatePages must return EFI_NOT_FOUND when the
> >> requested address range is unavailable or already allocated;
> >> EFI_OUT_OF_RESOURCES applies to non‑address‑specific allocation
> >> failures.
> >
> >Where does the EFI spec say that? EDKII indeed returns EFI_NOT_FOUND
> >for AllocateAddress but looking at the function description, I can't
> >find anything specific.
> >
> >Thanks
> >/Ilias
> 
> Thank you Harsimran for investigating this difference to EDJ II.
> 
> The spec has:
> 
> EFI_NOT_FOUND
> The requested pages could not be found.
> 
> and
> 
> EFI_OUT_OF_RESOURCEST
> The pages could not be allocated.
> 
> Looking at the text one could assume that EFI_NOT_FOUND should be returned if the pages requested with AllocateAddress don't exist in the memory map.
> 
> If the pages exist and are already allocated EFI_NOT_FOUND does not look like the right return code according to the spec.
> 
> It is unclear if for AllocateMaxAddress a comparison to the memory bottom is required.
> 
> The specification should be clarified in the UEFI forum.
> 
> Best regards
> 
> Heinrich 
> 

Hi Ilias, Hi Heinrich,

Thanks for the clarification.

You are right.
The AllocatePages() text only lists the generic status codes, and it
does not explicitly say that an AllocateAddress request on an already
allocated range must return EFI_NOT_FOUND.

My motivation for this change was tlso he UEFI SCT expectation rather just a 
direct statement in the UEFI base spec. The SCT AllocatePages tests expect
EFI_NOT_FOUND for AllocateAddress both with non-existent memory and with
allocated memory, and that is the behavior I was trying to align U-Boot
with, which matches with EDK II as well.

Is this solution acceptable for now?

Thanks,
Harsimran Singh Tungal 
> 
> 
> >
> >>
> >> [1] https://uefi.org/specs/UEFI/2.10_A/07_Services_Boot_Services.html
> >>
> >> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
> >> ---
> >>  lib/efi_loader/efi_memory.c | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> >> index b77c2f980cc..63cf1a7277f 100644
> >> --- a/lib/efi_loader/efi_memory.c
> >> +++ b/lib/efi_loader/efi_memory.c
> >> @@ -510,7 +510,9 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
> >>                 /* Map would overlap, bail out */
> >>                 lmb_free(addr, (u64)pages << EFI_PAGE_SHIFT, flags);
> >>                 unmap_sysmem((void *)(uintptr_t)efi_addr);
> >> -               return  EFI_OUT_OF_RESOURCES;
> >> +               if (type == EFI_ALLOCATE_ADDRESS)
> >> +                       return EFI_NOT_FOUND;
> >> +               return EFI_OUT_OF_RESOURCES;
> >>         }
> >>
> >>         *memory = efi_addr;
> >> --
> >> 2.34.1
> >>
> 
> 


