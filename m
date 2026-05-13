Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D22CD4F21
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 16:39:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF20E8341A;
	Wed, 13 May 2026 18:39:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S4GG5sQg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DEE3836AC; Wed, 13 May 2026 18:39:33 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECD5180F0E
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 18:39:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-bcceb394417so559821366b.0
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 09:39:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778690370; cv=none;
 d=google.com; s=arc-20240605;
 b=DpNPKp+3XuIQ82PVsXxZecMSUKDo05aMP/ujKo/dD14ForAey7HONgnGcBQeA2FxPv
 4ELAKwm/YHXVG0Q2zg2u+msRWzZ1QQB6fJnyoEpszuk8IsSJ0ACa/7j+UU0QEsYq/TFs
 Z30Fgie1Eo65JSeJjvbs2O3JARyoQAZr9aPdI0Z7Moe3xBOQCcX+BAv1Vf3ICXjsQdNR
 VYwg0SbDshdOqRrXkfqsalwyaV22W5mIdkdpIwRwGPqvDtEi74Gy1adVn2sfEplKgxYL
 dr3YnaTTnqkti7zNbSHt1qHmtu1UxxIYnzeguF4b1Ytrx+7+yIBD+vbkbLAEZSNY5qPH
 dC+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vjGmkZIe9xnPaStTwF7Hrt8Gv3VtVoJ5/6aptaqBOds=;
 fh=/HhErjq+iMbpEBsjr+YK4OvJrWKTrIh+zXyAvusMq7M=;
 b=grfnaJ6jA8zKXwaGSK4Qj3UTJmYGGGMDSHp+FCjrGdQ3UwAUJzXA+Z25Gjb6AWxP8H
 eDWYNzgg8JZ0zHWAsAh98Bw4GVZkHWyjhhxywvxC+3cAHay1rzoLF/rd1JklSAE1QwKz
 PXw8xKagRgYPoCuSgyf3moXE++s6Xk4SfnPvkt3fBA2vqX1usa5uWSkLtzyZZG35Dqrw
 erYjJUs1bX2ZW4zukf6Zntdg6Mpkc7V/HKIhmvOfJRH6Tw8s6xFsGPndGvIuhBEi6ReE
 yXkyuk0yD/tJnb3adNvFH0tkwQ/z6LfhPS30wn1mh5VP0tx5Lh4NLrgmYOzUdS7keSj4
 G7+Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778690370; x=1779295170; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vjGmkZIe9xnPaStTwF7Hrt8Gv3VtVoJ5/6aptaqBOds=;
 b=S4GG5sQgCKhxFaN/NsZKCTMIy4zYDUV222ImVxjlj5g8I6a4lCWQsHyBeRKII0sqTb
 g2yYTMQdLRDoVgtqNWCV2+E8fQCxGJYaBhig38bgrZHU03OknRZekjzBswcWQPiLIWT+
 x6ETtp/vm6glgahLUm/+2vZWbFUfkVwLa3ijU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778690370; x=1779295170;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vjGmkZIe9xnPaStTwF7Hrt8Gv3VtVoJ5/6aptaqBOds=;
 b=SExV4Dpi68hji8bzQSqSIV1mImzLeEIwyDdY7/CAIKNhXT5YIg7yPI7F/CAiU/HC8L
 SeFiGCat/OH9Q+JobOZhJUd6nNuv95cIM1nvm3lI9dOiyMvj4S3AJsvOfNPGEKlU4+aP
 kQwh88gyFvIvyWIGeTLHbOy3iHwhrjeIru97EvZpYwzFM8iCtnGz67R8gWULwweGWKTf
 A9mb9T9+8C+8CNTzPpeYQaUbeXu0xF4ye79POZk31pCGAOortuHy20SN+IUvGlgyGTtW
 hYCyWjmOtINDgpN+F8sbjNZrW0pDvwG5WZK+Sq50bIJosiwNF2d0y7aOo5Il7z9G1YAz
 xw5g==
X-Forwarded-Encrypted: i=1;
 AFNElJ98HJpMRBiVUehofkGNKstbxPcOxwEIllukOurVSAT5PkSsurVRYM+XCu7XSn9qRBVICr+p/NM=@lists.denx.de
X-Gm-Message-State: AOJu0YxfezYMc8azZVgTMv3aNQKA7ohkskjE8bUfmJ4Hai+qTDeaQSY6
 wdXcMZAE9CJOystRGCEc4quFR9lqDswBeU+cXPm5jgVLY0sTqPaH7jFpumDzIkCbFBVI3AmaZ5o
 B50basGfVN6rxtxQTIArkL6mH7iBnIJFRVF32JHqy
X-Gm-Gg: Acq92OFo4ZrEvV2ZSNB2+u1I3I3fOlLpWFog/BDAE6/I5XxleJ1L3j0uu+DCCv9W3jj
 ssvVGTzvOW1G7BfcU0kgwxqjcCsF6Lmomr7p0Cir1dOu4HEhBw2x5Ibd1Yc9u5s65KU0RiaYbPY
 PC76+ZbwLs9VQCbvw9tLrWknlLcmsP1oS+6Sst6NI9NWQuhJX6AfJl87HdTeNLqQL/u9AflRntf
 wR7SLRAbii0KAHIPXXDr2uONFGnZkwIpoHQWmg2ZZcT/o73kq3DKAixe9TPH1pdeSHqd9MXR9Pr
 FL8PVQ==
X-Received: by 2002:a17:907:a396:b0:ba1:1181:b773 with SMTP id
 a640c23a62f3a-bd3bfb8f597mr289640866b.10.1778690370182; Wed, 13 May 2026
 09:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260508222911.450165-1-rs@ti.com>
 <20260508222911.450165-4-rs@ti.com>
 <CAFLszTjPttabQ-Pqm3JrHmV8vBY77NFJmUKixkwEYYytkshgjA@mail.gmail.com>
 <DIG3Q08V6K3T.3CISX3G3X19LO@ti.com>
In-Reply-To: <DIG3Q08V6K3T.3CISX3G3X19LO@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 May 2026 10:39:17 -0600
X-Gm-Features: AVHnY4IuNSxRcl1gnVUTgdvwwnjx1yDdZxC27iOGP6Ek9-2eg0Hn8H7r1IeS88g
Message-ID: <CAFLszTgO6M-+iHXTZdSUcXggwcemHWUyoBgujxri+NwtN37GBQ@mail.gmail.com>
Subject: Re: [PATCHv6 3/3] memory: reserve from start_addr_sp to
 initial_relocaddr
To: Randolph Sapp <rs@ti.com>
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, 
 u-boot@lists.denx.de
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

Hi Randolph,

On Mon, 11 May 2026 at 13:41, Randolph Sapp <rs@ti.com> wrote:
>
> On Mon May 11, 2026 at 1:28 PM CDT, Simon Glass wrote:
> > Hi Randolph,
> >
> > On 2026-05-08T22:29:09, Randolph Sapp <rs@ti.com> wrote:
> >> memory: reserve from start_addr_sp to initial_relocaddr
> >>
> >> Add a new global data struct member called initial_relocaddr. This
> >> stores the original value of relocaddr, directly from setup_dest_addr.
> >> This is specifically to avoid any adjustments made by other init
> >> functions.
> >>
> >> Reserve the memory from gd->start_addr_sp - CONFIG_STACK_SIZE to
> >> gd->initial_relocaddr instead of gd->ram_top. This allows platform
> >> specific relocation addresses to work without unnecessarily painting
> >> over a large range.
> >>
> >> Since PRAM comes out of this initial area up to initial_relocaddr, we no
> >> longer need to account for it separately.
> >>
> >> Signed-off-by: Randolph Sapp <rs@ti.com>
> >>
> >> common/board_f.c                  |  9 ++++++++-
> >>  include/asm-generic/global_data.h |  7 +++++++
> >>  lib/efi_loader/efi_memory.c       |  2 +-
> >>  lib/lmb.c                         | 39 ++++++---------------------------------
> >>  4 files changed, 22 insertions(+), 35 deletions(-)
> >
> > BTW I am missing a change long in this patch, so a bit of guesswork here.
>
> I tend to keep the changelogs for a series in the series cover letter. I assume
> tracking per patch is the preference for this list based on this message.

I'm not sure about others, but for me I struggle with a change log in
another place. It's OK to have it in both places (like patman does),
but trying to read a different email and figure out what change
relates to what patch is hard, particularly when it might have been a
day or a week since I last saw the patch.

>
> >> diff --git a/common/board_f.c b/common/board_f.c
> >> @@ -330,6 +330,8 @@ __weak int arch_setup_dest_addr(void)
> >>
> >>  static int setup_dest_addr(void)
> >>  {
> >> +     int ret;
> >> +
> >>       debug("Monitor len: %08x\n", gd->mon_len);
> >>       /*
> >>        * Ram is setup, size stored in gd !!
> >> @@ -356,7 +358,12 @@ static int setup_dest_addr(void)
> >>       gd->relocaddr = gd->ram_top;
> >>       debug("Ram top: %08llX\n", (unsigned long long)gd->ram_top);
> >>
> >> -     return arch_setup_dest_addr();
> >> +     ret = arch_setup_dest_addr();
> >> +     if (ret != 0)
> >> +             return ret;
> >> +
> >> +     gd->initial_relocaddr = gd->relocaddr;
> >> +     return ret;
> >>  }
> >
> > Please use 'if (ret)' to match U-Boot style. The trailing 'return
> > ret;' is misleading since ret is known to be zero - make it 'return
> > 0;'.
> >
> >> diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
> >> @@ -107,6 +107,13 @@ struct global_data {
> >>        * GDB using the 'add-symbol-file u-boot <relocaddr>' command.
> >>        */
> >>       unsigned long relocaddr;
> >> +     /**
> >> +      * @initial_relocaddr: end of memory currently in use by uboot
> >> +      *
> >> +      * This should be the original value of relocaddr before any other
> >> +      * allocations or reservations shift it.
> >> +      */
> >> +     unsigned long initial_relocaddr;
> >
> > The kerneldoc summary is misleading: 'currently in use' suggests live
> > state, but this is written once at the end of setup_dest_addr() and
> > never updated. Please reword to something like 'initial top of the
> > U-Boot reservation' and note that it is set once in setup_dest_addr().
> > Also 'uboot' should be 'U-Boot'.
> >
> >> diff --git a/lib/lmb.c b/lib/lmb.c
> >> @@ -534,46 +534,19 @@ static long lmb_reserve(phys_addr_t base, phys_size_t size, u32 flags)
> >>
> >>  static void lmb_reserve_uboot_region(void)
> >>  {
> >> -     int bank;
> >> -     ulong end, bank_end;
> >> +     ulong size;
> >>       phys_addr_t rsv_start;
> >> -     ulong pram = 0;
> >>
> >>       rsv_start = gd->start_addr_sp - CONFIG_STACK_SIZE;
> >> -     end = gd->ram_top;
> >> +     size = gd->initial_relocaddr - rsv_start;
> >>
> >> -     /*
> >> -      * Reserve memory from aligned address below the bottom of U-Boot stack
> >> -      * until end of RAM area to prevent LMB from overwriting that memory.
> >> -      */
> >> -     debug("## Current stack ends at 0x%08lx ", (ulong)rsv_start);
> >> +     debug("## Current stack ends at 0x%08lx\n", (ulong)rsv_start);
> >
> > Please keep a trimmed version of the explanatory comment - it
> > documents the intent of this reservation and is more useful than the
> > surrounding context.
> >
> >> diff --git a/lib/lmb.c b/lib/lmb.c
> >> @@ -534,46 +534,19 @@ static long lmb_reserve(phys_addr_t base, phys_size_t size, u32 flags)
> >> -     for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
> >> -             if (!gd->bd->bi_dram[bank].size ||
> >> -                 rsv_start < gd->bd->bi_dram[bank].start)
> >> -                     continue;
> >> -             /* Watch out for RAM at end of address space! */
> >> -             bank_end = gd->bd->bi_dram[bank].start +
> >> -                     gd->bd->bi_dram[bank].size - 1;
> >> -             if (rsv_start > bank_end)
> >> -                     continue;
> >> -             if (bank_end > end)
> >> -                     bank_end = end - 1;
> >> +     lmb_reserve(rsv_start, size, LMB_NOOVERWRITE);
> >
> > The old code walked CONFIG_NR_DRAM_BANKS and clamped the reservation
> > to the bank containing rsv_start. The new code drops that and just
> > reserves [rsv_start, initial_relocaddr). On platforms with
> > non-contiguous banks (where U-Boot occupies the top bank and there is
> > a hole below it), this can mark a range that is not all RAM. Is that
> > intentional? If so the commit message should call it out; if not,
> > please re-add a sanity check so we do not reserve across holes.
>
> I had a few thoughts about this in the past week. Initially this bank walking
> behavior seemed more than a little unusual to me. It appears here and in 2 other
> places. (FDT and kernel image loading, if I recall correctly.)
>
> I was mulling over adding it back in as-is, but this really feels like something
> LMB should be aware of and should handle on it's own during the reservation of
> those regions. Something akin to the EFI allocator's conventional memory overlap
> check.
>
> Seems like most of the infrastructure for that is already there. We have a
> separate list tracking memory banks already. It was just bothering me that there
> are quite a few instances where the allocator is blindly receiving external
> information instead of taking more agency in the act of reserving that memory.
>
> Suppose I'll just reinstate that old logic though as this series has drug out
> much longer than I initially intended.

I think Ilias would be the right person to sort out the LMB stuff...I
don't really have much insight on that.

>
> >> diff --git a/lib/lmb.c b/lib/lmb.c
> >> @@ -534,46 +534,19 @@ static long lmb_reserve(phys_addr_t base, phys_size_t size, u32 flags)
> >> -#ifdef CFG_PRAM
> >> -     pram = env_get_ulong('pram', 10, CFG_PRAM);
> >> -     pram = pram << 10; /* size is in kB */
> >> -#endif
> >
> > PRAM previously sat above the LMB reservation (the old code subtracted
> > pram from the size so PRAM was left out of used_mem). With this patch,
> > PRAM ends up inside the [rsv_start, initial_relocaddr) range and is
> > now marked LMB_NOOVERWRITE - likely this is more correct, but it is a
> > behaviour change for boards setting pram at runtime to be larger than
> > CFG_PRAM - those bytes used to be available to LMB clients and now are
> > not.
> >
> > Please spell this out in the commit message rather than the brief
> > 'PRAM comes out of this initial area' line, so reviewers on PRAM-using
> > boards know to look.
> >
> >> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> >> @@ -869,7 +869,7 @@ static void add_u_boot_and_runtime(void)
> >>       /* Add U-Boot */
> >>       uboot_start = ((uintptr_t)map_sysmem(gd->start_addr_sp, 0) -
> >>                      uboot_stack_size) & ~EFI_PAGE_MASK;
> >> -     uboot_pages = ((uintptr_t)map_sysmem(gd->ram_top - 1, 0) -
> >> +     uboot_pages = ((uintptr_t)map_sysmem(gd->initial_relocaddr, 0) -
> >>                      uboot_start + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT;
> >
> > Hmmm, the current expression uses ram_top - 1 (inclusive top byte) and
> > then rounded up via EFI_PAGE_MASK. The new one passes
> > initial_relocaddr without the - 1 - so when initial_relocaddr is
> > page-aligned this adds an extra page. What is the intention here?
> >
> > Regards,
> > Simon
>
> This stemmed from the misinterpretation of board_get_usable_ram_top being
> exclusive. This is to be adjusted in the next revision.

OK ta.

REgards,
Simon
