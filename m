Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B34CD4840
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 18:29:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9A6C83E36;
	Mon, 11 May 2026 20:29:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BTi7QdVC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F4D983E76; Mon, 11 May 2026 20:29:04 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0B4883C2B
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 20:29:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-bcc2b199c17so308547066b.3
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 11:29:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778524141; cv=none;
 d=google.com; s=arc-20240605;
 b=ELj7dMAx3cjMcQniSpl8aAPgB4X7HYcRAhyIwOjWIJOYVP9xxO0n7ccYybxGUMbL/r
 2ST4bBbv4+q4ToNgs4KN3mIwDnavjzCT1erm4QysMvZuJWtclz2nwQljulEN6AgrO2Eo
 BSz6CF4nGUb9YlFntMY6zknaP1zktSNji0sRakOWWIhXuC5jod5GT2pb7oGe+DZPTxRN
 uljQIF/1zkWqBD2zomyovPb5Q7YpGej2d5Qpj9UMa3LHjlYFghD617ZJ+fviMjD91iWj
 1JSotjjVfESbXr/JyhXVQZR5Ad/TKbcjsj9li690xN77F03LTChOgk2Cm/K4UBtSWjgQ
 BdZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GafHjnUWcPcCeAL/ZfBNu5qQaFrK7LTSBAbaCln7DgY=;
 fh=50QxIj9bNMkYLs8Y0MV/5ticH1BhzapD7QYdeldhBtA=;
 b=Jb8dunYbqL3tGs7k9yDFPAZ/FstJ9B0byEtM8+WTQoQfJ0mviBY15pnM1kIUx6xYON
 zjeCSZVFGtX02GkI0sDPs4BypeOspg8HiLXRs4JL1w7udNvRrzasXb6cp2DKHI+ARV5s
 UiCc5h+1D3Hyq9EpdBbbbHBT/G5rZukNvThmpMaxzMyljgy8gh50mvDnRXECJ2ULlN3s
 Cwgi5SUfnfPWFq1DM6egOdbfV+Sx2fdXot0YnioxbH/jSk1KpznPNJ/dNoL4kPp+rBWf
 zOhXIfltLIWUC81PPAWxgHhbGjuJLzSZ26NMlBAtyUhAulCQgGqUYuv6hwyLDMlbT5fn
 33Jg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778524141; x=1779128941; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GafHjnUWcPcCeAL/ZfBNu5qQaFrK7LTSBAbaCln7DgY=;
 b=BTi7QdVCyZfYEFZIfv5t99Ix6C/F/LJQbpZ6jUFsXhdINQugasg1Yr54NATZpbCMA7
 ymsp//6cVWwM7BW2kcr/kGLmTUmNrx0BoQuMRZbTvAIOHORb8HUYB/yrYkyJCa/ehNQV
 UFEBvazvYQPvF9ZwUCpg2V2AcyxSQIZuNTA5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778524141; x=1779128941;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GafHjnUWcPcCeAL/ZfBNu5qQaFrK7LTSBAbaCln7DgY=;
 b=A/4S8CN4Ogz2ATcOr4vWZA9vir1/a5NoG1xzQntLKVuB+CMpiGX30IdiGLmIeS4dlZ
 RbKxBZ5u+uNQEaQkkciJBofnchpoJXHkqABGBc3157XUNhsYZW6Ld/kJpnkDFIubeM6Z
 bVf5JiMJ/4tsEcRU+iv8xCvxM3jmvpRvVFVWGLv1pTaWPtne5rjpAAonvAuBsKcX6sb0
 Cl+lCo3tK1h8NV4CUjeRYEK6zlyysi5K8hyse9H5OfZpWjWmPLKH6ksNH6qQtPaIpmvr
 P0ymllOxo1Kz2QVZ/xOm2h/13MP3rWmI1bj+j5FySEUcmCJ1cMyyu8/PKF+z+fjX0eXg
 E+Vw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9c8B71N6frFwUTcIpYALhNom0pU9gLQqcd/xWKwvI9nA0mtHkmMgc4dDYLDiYB3ciJP5fUloM=@lists.denx.de
X-Gm-Message-State: AOJu0YypYnshIkAJrJwKMhNob14HoCiCCPAJ3WDyngT8nC9a6qiIeK0l
 ChBRM1Ibns4hCSQV/fhSpJ+PoHHyzOyzM0YAKGGkF2dTP6gNXSArIfGexL1xpFstl+sftdl66jB
 mUft8CGpJLKUA5bp5WiSGxR12g+SXecu+Ceank7vNJnWAxnzkQuc=
X-Gm-Gg: Acq92OG6cZpopN6rXGiIJW09f3RPTy03/D0W31DL0sdADs5DS/OhWCYYO0aoyjk2tyS
 P559/dBfq0a04TWfcbb0I2XbN52KWG5pxD4vqPfA6fTZ5Y+PRwsmHN/Illr4gocBMoryf1iPSeU
 AFf7OyDBO4KCFO5/JpFfTI3VErLDuryz72Qf5ulbc3ctI1oZqwQ/gygrs4ZwEgQX2S0L1B2uG8i
 3N+LLwldip+hV5tKMSpSCaDV5UirkPAtDL+wtlqncfXKgNULm0b1YatOsoq8JfZrt4eCOH91UXh
 aM7jRgxgQd57jNYX
X-Received: by 2002:a17:907:3d10:b0:bcd:53e5:c8f1 with SMTP id
 a640c23a62f3a-bcd53e5deb7mr493327866b.13.1778524140956; Mon, 11 May 2026
 11:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260508222911.450165-1-rs@ti.com>
 <20260508222911.450165-4-rs@ti.com>
In-Reply-To: <20260508222911.450165-4-rs@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 May 2026 12:28:47 -0600
X-Gm-Features: AVHnY4JEziwJAxPNAAd7EETPl-YBRYDewrEVxqo8k9qEVQEduyZWKLRSOZaI-hQ
Message-ID: <CAFLszTjPttabQ-Pqm3JrHmV8vBY77NFJmUKixkwEYYytkshgjA@mail.gmail.com>
Subject: Re: [PATCHv6 3/3] memory: reserve from start_addr_sp to
 initial_relocaddr
To: rs@ti.com
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org, 
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

On 2026-05-08T22:29:09, Randolph Sapp <rs@ti.com> wrote:
> memory: reserve from start_addr_sp to initial_relocaddr
>
> Add a new global data struct member called initial_relocaddr. This
> stores the original value of relocaddr, directly from setup_dest_addr.
> This is specifically to avoid any adjustments made by other init
> functions.
>
> Reserve the memory from gd->start_addr_sp - CONFIG_STACK_SIZE to
> gd->initial_relocaddr instead of gd->ram_top. This allows platform
> specific relocation addresses to work without unnecessarily painting
> over a large range.
>
> Since PRAM comes out of this initial area up to initial_relocaddr, we no
> longer need to account for it separately.
>
> Signed-off-by: Randolph Sapp <rs@ti.com>
>
> common/board_f.c                  |  9 ++++++++-
>  include/asm-generic/global_data.h |  7 +++++++
>  lib/efi_loader/efi_memory.c       |  2 +-
>  lib/lmb.c                         | 39 ++++++---------------------------------
>  4 files changed, 22 insertions(+), 35 deletions(-)

BTW I am missing a change long in this patch, so a bit of guesswork here.

> diff --git a/common/board_f.c b/common/board_f.c
> @@ -330,6 +330,8 @@ __weak int arch_setup_dest_addr(void)
>
>  static int setup_dest_addr(void)
>  {
> +     int ret;
> +
>       debug("Monitor len: %08x\n", gd->mon_len);
>       /*
>        * Ram is setup, size stored in gd !!
> @@ -356,7 +358,12 @@ static int setup_dest_addr(void)
>       gd->relocaddr = gd->ram_top;
>       debug("Ram top: %08llX\n", (unsigned long long)gd->ram_top);
>
> -     return arch_setup_dest_addr();
> +     ret = arch_setup_dest_addr();
> +     if (ret != 0)
> +             return ret;
> +
> +     gd->initial_relocaddr = gd->relocaddr;
> +     return ret;
>  }

Please use 'if (ret)' to match U-Boot style. The trailing 'return
ret;' is misleading since ret is known to be zero - make it 'return
0;'.

> diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
> @@ -107,6 +107,13 @@ struct global_data {
>        * GDB using the 'add-symbol-file u-boot <relocaddr>' command.
>        */
>       unsigned long relocaddr;
> +     /**
> +      * @initial_relocaddr: end of memory currently in use by uboot
> +      *
> +      * This should be the original value of relocaddr before any other
> +      * allocations or reservations shift it.
> +      */
> +     unsigned long initial_relocaddr;

The kerneldoc summary is misleading: 'currently in use' suggests live
state, but this is written once at the end of setup_dest_addr() and
never updated. Please reword to something like 'initial top of the
U-Boot reservation' and note that it is set once in setup_dest_addr().
Also 'uboot' should be 'U-Boot'.

> diff --git a/lib/lmb.c b/lib/lmb.c
> @@ -534,46 +534,19 @@ static long lmb_reserve(phys_addr_t base, phys_size_t size, u32 flags)
>
>  static void lmb_reserve_uboot_region(void)
>  {
> -     int bank;
> -     ulong end, bank_end;
> +     ulong size;
>       phys_addr_t rsv_start;
> -     ulong pram = 0;
>
>       rsv_start = gd->start_addr_sp - CONFIG_STACK_SIZE;
> -     end = gd->ram_top;
> +     size = gd->initial_relocaddr - rsv_start;
>
> -     /*
> -      * Reserve memory from aligned address below the bottom of U-Boot stack
> -      * until end of RAM area to prevent LMB from overwriting that memory.
> -      */
> -     debug("## Current stack ends at 0x%08lx ", (ulong)rsv_start);
> +     debug("## Current stack ends at 0x%08lx\n", (ulong)rsv_start);

Please keep a trimmed version of the explanatory comment - it
documents the intent of this reservation and is more useful than the
surrounding context.

> diff --git a/lib/lmb.c b/lib/lmb.c
> @@ -534,46 +534,19 @@ static long lmb_reserve(phys_addr_t base, phys_size_t size, u32 flags)
> -     for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
> -             if (!gd->bd->bi_dram[bank].size ||
> -                 rsv_start < gd->bd->bi_dram[bank].start)
> -                     continue;
> -             /* Watch out for RAM at end of address space! */
> -             bank_end = gd->bd->bi_dram[bank].start +
> -                     gd->bd->bi_dram[bank].size - 1;
> -             if (rsv_start > bank_end)
> -                     continue;
> -             if (bank_end > end)
> -                     bank_end = end - 1;
> +     lmb_reserve(rsv_start, size, LMB_NOOVERWRITE);

The old code walked CONFIG_NR_DRAM_BANKS and clamped the reservation
to the bank containing rsv_start. The new code drops that and just
reserves [rsv_start, initial_relocaddr). On platforms with
non-contiguous banks (where U-Boot occupies the top bank and there is
a hole below it), this can mark a range that is not all RAM. Is that
intentional? If so the commit message should call it out; if not,
please re-add a sanity check so we do not reserve across holes.

> diff --git a/lib/lmb.c b/lib/lmb.c
> @@ -534,46 +534,19 @@ static long lmb_reserve(phys_addr_t base, phys_size_t size, u32 flags)
> -#ifdef CFG_PRAM
> -     pram = env_get_ulong('pram', 10, CFG_PRAM);
> -     pram = pram << 10; /* size is in kB */
> -#endif

PRAM previously sat above the LMB reservation (the old code subtracted
pram from the size so PRAM was left out of used_mem). With this patch,
PRAM ends up inside the [rsv_start, initial_relocaddr) range and is
now marked LMB_NOOVERWRITE - likely this is more correct, but it is a
behaviour change for boards setting pram at runtime to be larger than
CFG_PRAM - those bytes used to be available to LMB clients and now are
not.

Please spell this out in the commit message rather than the brief
'PRAM comes out of this initial area' line, so reviewers on PRAM-using
boards know to look.

> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> @@ -869,7 +869,7 @@ static void add_u_boot_and_runtime(void)
>       /* Add U-Boot */
>       uboot_start = ((uintptr_t)map_sysmem(gd->start_addr_sp, 0) -
>                      uboot_stack_size) & ~EFI_PAGE_MASK;
> -     uboot_pages = ((uintptr_t)map_sysmem(gd->ram_top - 1, 0) -
> +     uboot_pages = ((uintptr_t)map_sysmem(gd->initial_relocaddr, 0) -
>                      uboot_start + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT;

Hmmm, the current expression uses ram_top - 1 (inclusive top byte) and
then rounded up via EFI_PAGE_MASK. The new one passes
initial_relocaddr without the - 1 - so when initial_relocaddr is
page-aligned this adds an extra page. What is the intention here?

Regards,
Simon
