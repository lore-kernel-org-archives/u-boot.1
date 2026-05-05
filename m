Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A581FF885A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 11:25:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF176848A7;
	Tue,  5 May 2026 13:25:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IInZ6CDM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6D93848B3; Tue,  5 May 2026 13:25:39 +0200 (CEST)
Received: from mail-yx1-xb12a.google.com (mail-yx1-xb12a.google.com
 [IPv6:2607:f8b0:4864:20::b12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F06A08489F
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 13:25:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-64d5a7926cfso4952844d50.2
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 04:25:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777980335; cv=none;
 d=google.com; s=arc-20240605;
 b=iFfXFUHSUtwB+UtLrGtXZUIdziYc+kaO0JbtH2uDEBHAvpSMY0rHd5cgUcq3q08v1p
 nxWJoSPJ2lAkwf12LWYRBZ1hi0o/MTIfQWRs8Y6RGkwIf2++N969S+pvYl3c/VFzmjaY
 Iu3fKDa9YHOQclRYYGL9oqp3ao8txVyRctwgZwmJGZQvYjSMS94xCGYoCTaYyFltnB8i
 bEB3folC2FoGhP/37E9n5frQJw93otTCUqvy4+huAH7BwL14VK4+CzvGQ0c60MNmhwqR
 QbG13ORwRcEyCTCvGWauOc1Ki3D2Yk43pMz15n4PQJv3qKF9VIvyrsGhLDI4P/kSjyzM
 XTUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EznyehUoq8PLAOW4hQe3oY/3oeyZ01uxcz7vBB0rn9Y=;
 fh=igr8kmD/q1pcdh7Ar1wjn+myTld39sINyohQx5wH7kE=;
 b=AmJIybtRquEE0LyVl0yiZ/5oryJZM81+Cx6Z043DFjvLgaua8JAyluo5uQyMPc9iQ6
 yfH9LTwhK0SiJiCEnWx2vvuhd4Zdr3sM1RUaHMXeHqVzQnKVJnaWI1RI5zJ55/GF+G4/
 +3pg0d4SArKF123JnBhkRWDX7rRSyRJepWQUBRm/akkOP2yz268w9DTVTsrsYkoeY00/
 C7Fm5J/Sk9Tk1TWSI3LcNsxTnMwpPAfrUjC8Gj8e1qyZ0bCFfAktB3ctPcY2DkL1iNLb
 JoSNi61y3uL8NR8j+gORbDA+gKzFeYt9gJW11qag1x8ucHBp38vuH9kPx2PpbgP1drjD
 MiZg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777980335; x=1778585135; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EznyehUoq8PLAOW4hQe3oY/3oeyZ01uxcz7vBB0rn9Y=;
 b=IInZ6CDMSrOH4S2ggh+p+L1bNCDn+Zzl1teJsskC9hGA/3sIXRc0FsAQ55MHyW/aCc
 iFP2ltcZojQd/f05eMCLNwHlR8z84NIP4kYuJ7zsI6wTb62hTOvct2La3lpp4J2BJlqh
 G5eSZCZtOUj+JRiPxh5il+CrbPOKJCDr/fN0b4X9zvBiRKOSAQFEVZGkhJygs45oeCqx
 NtWPGKMvq4Cwl3EB4D+3pMliNVzJZc7pHn15+/9OZMn8CFF2VvRDv4lUCdB9ZdJXBRBt
 PcuHcIgwOstI5Em4QrCHNhm8RM+g4fa4xGnICvn3trxrKlGmRCbFLil8BOWXG/XX4uRD
 Z10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777980335; x=1778585135;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EznyehUoq8PLAOW4hQe3oY/3oeyZ01uxcz7vBB0rn9Y=;
 b=SZB3sRN3t5+4sVVvStiW7Z/8EmLKgBNoVxnUUlQb6ckl40ARMaG4EA5Zx32wFAQbIk
 q/diKCAZxjjLAeP8VRTcXQp/y4aHO4N4QmHAldiRIlHrlzF9Xzode2jXpMv5QzTsD9w7
 t0AqauPCpMhAlYLdAFOwq0OBDlMZJLDBgJrQY3xfaMXUiFx167p+RayBZDXYFwikfFp3
 iZ3vbk+/SL6sX37shwDtZPbKyPb3tD9CMUUtN+aQbkBSe+MomucmF8x57isM4p8yshTG
 8QPBBdUB/v4NOcODjdUE6ag3jXBHzxHiSyUwnrqNiWjv2FXT+WJH9yH37VNGzcbA+Zz8
 9MNQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Cb1bzIzl03ROaRuW2y+oLQxKMZSOXsXMyub/VmMPIvp820pJpqLZY/lNEmdc6x7207Prh3d8=@lists.denx.de
X-Gm-Message-State: AOJu0YycWwnYf85MDrrVYrRSyHEc+o75Le/Bt/MaknHh7q53hzY85VGQ
 pBCjYJ1wrzM+emSf9uVzJ8SQmIV8nGhNXvdpfwNnOtdzSrrEQeUfgImijaNJYBxMQL6rf5B2vzj
 mRw+Kn3l8b26iOHGDofHAXY2PTWka7mdMFBKS80aw4g==
X-Gm-Gg: AeBDiesb8pHTe2HPoSMrSFF05cuo35dlo7D7FjwF2tKCEYxwnF90Gk5v3L8LY7PCeeq
 OZl0vGsxPvHF1mZNkLh9UUArN6BwDXohXriCU/8bdgOF6lWWqNKIsHteYhXPa1fvgRocMw9gCpL
 OGhJJBxDlhuRAW5jqTuKIpieC3zBDewQu8a+FY1icqzodw61zzVEeYE9Rmav7BLH0UEDidWrE5C
 buF1OpKPYW+i0qGu1FSex5V9r5S7ZgseT9ofFqSZV5rmKyTOFEDALkPodBFY96OkHox4YFVvpYc
 mpN+ah5h3wp1XBzK3+c2HnJvHFOj0Iy4zD8zSUSE6HF2FBPXmJqUb89HpxqpGIUU3bGChC4egQZ
 9z/ZOjvfi5cJ0ijse9F64kQlU+Dj3KeVKebYw9EGXIJ4Nr2tXwFziNKQ3PJ79bihJcbc+GastLL
 MeWrmCZBgjNHciw8F8HkTzpVJousP10U5nwg7GWb40Rtxox0OfMAXFKnTMLOLJB8EU4RpTdJWPt
 vuXuBmnOa8nCXPYbCJHqudnz2n3eU+KbQiZkbM+gkQmkJMG61gkYrmfiK0S2XdiBv9PragPvR2F
 okGqrSvsl+r81xw/qXIcZu0wYdb5ZkqpGO+aDk6VL8nd6V29tYUY1khFAQxWKFuhRfyiHFAc0pp
 IjrcKBFOTDqHBCXGF
X-Received: by 2002:a05:690e:4847:b0:64e:e2d7:7c28 with SMTP id
 956f58d0204a3-65c3da9e57amr9279085d50.41.1777980334600; Tue, 05 May 2026
 04:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260422170946.3394481-1-rs@ti.com>
 <20260422170946.3394481-7-rs@ti.com>
In-Reply-To: <20260422170946.3394481-7-rs@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 5 May 2026 14:24:57 +0300
X-Gm-Features: AVHnY4JyR3KXNUvbkwFsg6sM2xb2TAk6lGmVyLNNJQnrGXodfwRkSPc7QKGLCwI
Message-ID: <CAC_iWjJBO=8y9A21U84diAma02VTc88Uib-LFiBei-XULK=d6Q@mail.gmail.com>
Subject: Re: [PATCHv5 6/6] memory: reserve from start_addr_sp to
 initial_relocaddr
To: rs@ti.com
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, u-boot@lists.denx.de
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

On Wed, 22 Apr 2026 at 20:10, <rs@ti.com> wrote:
>
> From: Randolph Sapp <rs@ti.com>
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

Several CI tests are complaining with this series.
https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/29989

Can you have a look?

Thanks
/Ilias

>
> Signed-off-by: Randolph Sapp <rs@ti.com>
> ---
>  common/board_f.c                  |  9 ++++++-
>  include/asm-generic/global_data.h |  7 ++++++
>  lib/efi_loader/efi_memory.c       |  2 +-
>  lib/lmb.c                         | 39 +++++--------------------------
>  4 files changed, 22 insertions(+), 35 deletions(-)
>
> diff --git a/common/board_f.c b/common/board_f.c
> index ce87c619e68..31c6eb725fb 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -330,6 +330,8 @@ __weak int arch_setup_dest_addr(void)
>
>  static int setup_dest_addr(void)
>  {
> +       int ret;
> +
>         debug("Monitor len: %08x\n", gd->mon_len);
>         /*
>          * Ram is setup, size stored in gd !!
> @@ -356,7 +358,12 @@ static int setup_dest_addr(void)
>         gd->relocaddr = gd->ram_top;
>         debug("Ram top: %08llX\n", (unsigned long long)gd->ram_top);
>
> -       return arch_setup_dest_addr();
> +       ret = arch_setup_dest_addr();
> +       if (ret != 0)
> +               return ret;
> +
> +       gd->initial_relocaddr = gd->relocaddr;
> +       return ret;
>  }
>
>  #ifdef CFG_PRAM
> diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
> index 745d2c3a966..6c60a79c2ab 100644
> --- a/include/asm-generic/global_data.h
> +++ b/include/asm-generic/global_data.h
> @@ -107,6 +107,13 @@ struct global_data {
>          * GDB using the 'add-symbol-file u-boot <relocaddr>' command.
>          */
>         unsigned long relocaddr;
> +       /**
> +        * @initial_relocaddr: end of memory currently in use by uboot
> +        *
> +        * This should be the original value of relocaddr before any other
> +        * allocations or reservations shift it.
> +        */
> +       unsigned long initial_relocaddr;
>         /**
>          * @irq_sp: IRQ stack pointer
>          */
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 046a2bb4641..ece05c142f0 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -869,7 +869,7 @@ static void add_u_boot_and_runtime(void)
>         /* Add U-Boot */
>         uboot_start = ((uintptr_t)map_sysmem(gd->start_addr_sp, 0) -
>                        uboot_stack_size) & ~EFI_PAGE_MASK;
> -       uboot_pages = ((uintptr_t)map_sysmem(gd->ram_top - 1, 0) -
> +       uboot_pages = ((uintptr_t)map_sysmem(gd->initial_relocaddr, 0) -
>                        uboot_start + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT;
>         efi_update_memory_map(uboot_start, uboot_pages, EFI_BOOT_SERVICES_CODE,
>                               false, false);
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 9a8c70b778a..e5d4d726ab1 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -534,46 +534,19 @@ static long lmb_reserve(phys_addr_t base, phys_size_t size, u32 flags)
>
>  static void lmb_reserve_uboot_region(void)
>  {
> -       int bank;
> -       ulong end, bank_end;
> +       ulong size;
>         phys_addr_t rsv_start;
> -       ulong pram = 0;
>
>         rsv_start = gd->start_addr_sp - CONFIG_STACK_SIZE;
> -       end = gd->ram_top;
> +       size = gd->initial_relocaddr - rsv_start;
>
> -       /*
> -        * Reserve memory from aligned address below the bottom of U-Boot stack
> -        * until end of RAM area to prevent LMB from overwriting that memory.
> -        */
> -       debug("## Current stack ends at 0x%08lx ", (ulong)rsv_start);
> +       debug("## Current stack ends at 0x%08lx\n", (ulong)rsv_start);
>
> -#ifdef CFG_PRAM
> -       pram = env_get_ulong("pram", 10, CFG_PRAM);
> -       pram = pram << 10; /* size is in kB */
> -#endif
> -
> -       for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
> -               if (!gd->bd->bi_dram[bank].size ||
> -                   rsv_start < gd->bd->bi_dram[bank].start)
> -                       continue;
> -               /* Watch out for RAM at end of address space! */
> -               bank_end = gd->bd->bi_dram[bank].start +
> -                       gd->bd->bi_dram[bank].size - 1;
> -               if (rsv_start > bank_end)
> -                       continue;
> -               if (bank_end > end)
> -                       bank_end = end - 1;
> +       lmb_reserve(rsv_start, size, LMB_NOOVERWRITE);
>
> -               lmb_reserve(rsv_start, bank_end - rsv_start - pram + 1,
> +       if (gd->flags & GD_FLG_SKIP_RELOC)
> +               lmb_reserve((phys_addr_t)(uintptr_t)_start, gd->mon_len,
>                             LMB_NOOVERWRITE);
> -
> -               if (gd->flags & GD_FLG_SKIP_RELOC)
> -                       lmb_reserve((phys_addr_t)(uintptr_t)_start,
> -                                   gd->mon_len, LMB_NOOVERWRITE);
> -
> -               break;
> -       }
>  }
>
>  static void lmb_reserve_common(void *fdt_blob)
> --
> 2.53.0
>
