Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB74CD6E75
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 20:32:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80C01848DC;
	Thu,  4 Jun 2026 22:32:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x3oCMGMY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C0A684944; Thu,  4 Jun 2026 22:32:12 +0200 (CEST)
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com
 [IPv6:2607:f8b0:4864:20::b12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF35683EF9
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 22:32:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-66061993294so1377954d50.3
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 13:32:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780605128; cv=none;
 d=google.com; s=arc-20240605;
 b=aEOiQGqTpLe8kfB6BzVsXr8lgpbFYeu8iakjIa7zJ22IuUE/a6E9UfO27QgSTjazMT
 AMgfeMw/ZUPJTS9We0WW1jI6zLzkViwQoDeDUWzZ/B7OmiytlJtiuTLrRzqzkpNCdFxh
 HBpqhDTxGtVdrlqIk/rF/rhgzPWkpE5HMdDoNlFmPOqCufg+9dAvIugqRLVg79k7+SL5
 EWtWoU9xhCBQlR3L0E8Tue/Jls+BgL8SE0Wg7RqOFDsG/DeULnHpOgkkjvliei8aR2GZ
 AhzccmLak6TV3E99QAdP2XIlLT8+0IGJxUbLlzEpvjXmJdn5qluedOeV71b7wT43HwED
 Jj6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Te4HUtc6ff5pjez4qbpw+qYRx5ZZ+wUUHKH6eXxdvzQ=;
 fh=YJ2yIWPixFzJ2s+7nGegmlr/MjzpFaspNtRA82AUVec=;
 b=kW3Ikto0MO8WucdtciY44JvL9/GIwjzSlJZF53HBPP+BA6Y+dHfyuZuOF9Pbwm9v+u
 S9+mMnkDQu4X0tgLcGPlIyvgVm8MOc2Zcvqirejf9JjkzBRhBDB3J30sVLFjDTmyM1ac
 VNqq26cfqRFyRP8TBtsFyu/oet8eesn7modt1Lx0ASybXmQ3ftzMaMv8OFpzWpeKrNnV
 BPQlYjZVTmx1Yx9Xujs5k+ArhK3XldJFYvqK04iv2aJ0b4MWRpAX3lWTlMFsNnB0ZJ7o
 bu7fgkhVBFne4p2QkD/22kZsD6y1W7t8N5y8VrcYu+f8oACs35mex602Qy85O/zaIEWA
 M+UQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780605128; x=1781209928; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Te4HUtc6ff5pjez4qbpw+qYRx5ZZ+wUUHKH6eXxdvzQ=;
 b=x3oCMGMYMsP5t+IoaP+4wKcqtxHj+FgZNavsUvxuQGltOQYCM4kxBEn0/vbUrJ4orC
 E55N7VlhHJ0HRm52FCN8otl2dsL2rgiKuJClD0lESZLSwxb0G0gQ3PjdkdYfGc7oDozG
 G/eogxMVAiOf7DZuHchVtj5D17Qzi2PSJM1pRD5aA/Gm9k4DD5oJfjXd9wY3JvzjNQVp
 bq9J2w/Vy+QreIv7DKVFl7zsV4SmQjYqG6auB8yKYBP2bzMlqgCdyzEUcgQMJ36wzhq4
 QCU9Hjbk1Hmh3vxoLp8G/zNMz5dc2i3YV+4u0anQZ0rH8fK3YTO93BTlTOtBc2NNpGur
 wlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780605128; x=1781209928;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Te4HUtc6ff5pjez4qbpw+qYRx5ZZ+wUUHKH6eXxdvzQ=;
 b=TzaLzI19nWg+OnkasX368zbcgk2KYF0N20KaD9gjY6wXOUI4xIFCwVfrqKksOU4wNs
 J4FSSfykqVJFxkJPuKnvINqZU2X50ZpAaOy/g9MdpAqbRcmsGtgsPBHmxUk1334NR/cE
 YhhmHAkDLmIGBavXYPPatN83+kFIcq6kPqoDWiU18XGJgiZNvhyhohYV9fweH1GQbhYG
 LWr3krLRnqdLXV37Ub6vJoNvKu8ruJRa1hq+NbU4eDWtRXStLeSB2zgXrbhUFN6RsSFq
 e3i6FrR+gg8oALZZIFxX1DDM8oTYDm+ExlZkjQD7K0MNu3m1k9vhLdgULjppxeZc522N
 Nfdg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ofO9bJmyQFyMbG1q3/1Hjt/fOII2gohEkmqQJGL6BfYH5mYjFICXTFA2AuOIc+lSuRYd3l2I=@lists.denx.de
X-Gm-Message-State: AOJu0YymP6qWFPYhgoB5uEX3iBDlaAFHjOFfH8LNAlVhwQFXpb8lVbY3
 /12t3UCd+2tRt19QcBcO1BWtsR27VBld0eJdymGKMbAnzGFqnYHvfysC7OWZhZ2yftZgnDfrpeg
 NIg25nNEXK95Rt1XrhKNuWvLu5Egq/PIQQ8tSBhIvHg==
X-Gm-Gg: Acq92OH6vgGLVaTrPGdJvNEu1pYt+IjW6ne2hmje3skzwKUXNGJOs2kLbFECGvCjtha
 dxww8lp6izj5lV148BxuiyUOJJI57peZQY6Kgq4j+jsX6GSTy+Av9S4qMaek1WbwEFCvKVFqUCD
 gpJe+rE/gDtZsTCsB0RmuTtX6m+Rm0ib2np6cSDgRnelhR8OPHkvZifxyag5mpEuDgdNUvHlNoT
 RHzDX1x+JSBDNCLgu98cmbyzLnMtfdLb/rhhnEJ+esF8B8JNc88d/x8mnbVgipCLzujpeCTrD3X
 xOFmOLsI0r4M+WzfFqt7qR+fyhezHJPNu4OJp4RPJlc3iv1Eys3cHuOGIAoBLI+9ZQASO6xV3V+
 xDgUH/DCwsJIktVzwE1m0AmFqVXk6ULKAgS1WeEZKawnUXGbgyfsCHmxXLFo7qYNtBK2l/zyixW
 u+Hn/CENZJeZYWwIFvGNeQydehmKmXDxQXdvmLCa4BdXj/FpITqGFhtO17FLPCYDpDxFRjtKegL
 NfiZMyXtM0TMz8PVWpvXhM6FzCIBYoKKWdQMv8e0KujsajFlXIYwLGw2PP4iklIy2rGZlGAm1Xs
 oLQkObULeFeXbPJQD/34dGZTnIVRBEJxXYfldZxuOalK+flTdvCO49Wlulqz81t5hMnPXJJy/1y
 sZCzkgIDWYnf0hwxK
X-Received: by 2002:a53:ea85:0:b0:660:e9ff:35f with SMTP id
 956f58d0204a3-66106e572c3mr352988d50.27.1780605122896; Thu, 04 Jun 2026
 13:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260604155038.3182-1-rs@ti.com> <20260604155038.3182-5-rs@ti.com>
 <CAC_iWjK=e2zqCg3rKSr0-w5Poi6q4nHKeq5eZsDBkSOz8e8xRA@mail.gmail.com>
In-Reply-To: <CAC_iWjK=e2zqCg3rKSr0-w5Poi6q4nHKeq5eZsDBkSOz8e8xRA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 4 Jun 2026 23:31:26 +0300
X-Gm-Features: AVHnY4JF2V2lldFPa4UP-IlLmll33hnMncXywG7QrRLnMWziPkTEUiAq0czdcDM
Message-ID: <CAC_iWjJ-fnjbxO_r9mMWJhN2x+H8ezLqEaGkX8B_Ka=wsQqKBQ@mail.gmail.com>
Subject: Re: [PATCHv10 4/4] memory: reserve from start_addr_sp to
 initial_relocaddr
To: rs@ti.com
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, sjg@chromium.org, u-boot@lists.denx.de
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

On Thu, 4 Jun 2026 at 23:19, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Randolph
>
> On Thu, 4 Jun 2026 at 18:51, <rs@ti.com> wrote:
> >
> > From: Randolph Sapp <rs@ti.com>
> >
> > Add a new global data struct member called initial_relocaddr. This
> > stores the original value of relocaddr, directly from setup_dest_addr.
> > This is specifically to avoid any adjustments made by other init
> > functions.
> >
> > Reserve the memory from gd->start_addr_sp - CONFIG_STACK_SIZE to
> > gd->initial_relocaddr instead of gd->ram_top. This allows platform
> > specific relocation addresses to work without unnecessarily painting
> > over a large range.
>
> Looking at this again, I don't think you can reserve only up to
> initial_relocaddr. That's the base address we relocate and everything
> else (.data, .bss) etc should be living above that address. We have to
> account for the size of the relocated u-boot binary + bss and reserve
> those areas as well.

Ok ignore this, I forgot we subtract all that from the initial reloc
addr, so this is fine

You can keep the r-b tag

Cheers
/Ilias
>
> Cheers
> /Ilias
> >
> > Signed-off-by: Randolph Sapp <rs@ti.com>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> > v7:
> >         - Reinstate bank hopping logic for U-Boot reserved region
> >         - Update description for gd->initial_relocaddr, make it clear this is
> >           also an exclusive value
> >         - Leave the PRAM region out of the reservation. Previous commit messages
> >           indicate that this is intended.
> > v8:
> >         - Adjust initial_relocaddr doc string
> > ---
> >  common/board_f.c                  | 9 ++++++++-
> >  include/asm-generic/global_data.h | 9 +++++++++
> >  lib/efi_loader/efi_memory.c       | 2 +-
> >  lib/lmb.c                         | 7 ++++---
> >  4 files changed, 22 insertions(+), 5 deletions(-)
> >
> > diff --git a/common/board_f.c b/common/board_f.c
> > index ce87c619e68..aeb53b4c274 100644
> > --- a/common/board_f.c
> > +++ b/common/board_f.c
> > @@ -330,6 +330,8 @@ __weak int arch_setup_dest_addr(void)
> >
> >  static int setup_dest_addr(void)
> >  {
> > +       int ret;
> > +
> >         debug("Monitor len: %08x\n", gd->mon_len);
> >         /*
> >          * Ram is setup, size stored in gd !!
> > @@ -356,7 +358,12 @@ static int setup_dest_addr(void)
> >         gd->relocaddr = gd->ram_top;
> >         debug("Ram top: %08llX\n", (unsigned long long)gd->ram_top);
> >
> > -       return arch_setup_dest_addr();
> > +       ret = arch_setup_dest_addr();
> > +       if (ret)
> > +               return ret;
> > +
> > +       gd->initial_relocaddr = gd->relocaddr;
> > +       return 0;
> >  }
> >
> >  #ifdef CFG_PRAM
> > diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
> > index 745d2c3a966..8d1d49b1133 100644
> > --- a/include/asm-generic/global_data.h
> > +++ b/include/asm-generic/global_data.h
> > @@ -107,6 +107,15 @@ struct global_data {
> >          * GDB using the 'add-symbol-file u-boot <relocaddr>' command.
> >          */
> >         unsigned long relocaddr;
> > +       /**
> > +        * @initial_relocaddr: top address of U-Boot in RAM
> > +        *
> > +        * This should be the value of relocaddr after setup_dest_addr() and
> > +        * before reserve_pram() or any other allocations or reservations shift
> > +        * it. This address will, depending on the platform, be equivalent to
> > +        * ram_top and should also be considered an exclusive address.
> > +        */
> > +       unsigned long initial_relocaddr;
> >         /**
> >          * @irq_sp: IRQ stack pointer
> >          */
> > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > index 2feb29f0a2c..c3da7c20cb2 100644
> > --- a/lib/efi_loader/efi_memory.c
> > +++ b/lib/efi_loader/efi_memory.c
> > @@ -871,7 +871,7 @@ static void add_u_boot_and_runtime(void)
> >         /* Add U-Boot */
> >         uboot_start = ((uintptr_t)map_sysmem(gd->start_addr_sp, 0) -
> >                        uboot_stack_size) & ~EFI_PAGE_MASK;
> > -       uboot_pages = ((uintptr_t)map_sysmem(gd->ram_top - 1, 0) -
> > +       uboot_pages = ((uintptr_t)map_sysmem(gd->initial_relocaddr - 1, 0) -
> >                        uboot_start + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT;
> >         efi_update_memory_map(uboot_start, uboot_pages, EFI_BOOT_SERVICES_CODE,
> >                               false, false);
> > diff --git a/lib/lmb.c b/lib/lmb.c
> > index 8f12c6ad8e5..27c8565e590 100644
> > --- a/lib/lmb.c
> > +++ b/lib/lmb.c
> > @@ -540,13 +540,14 @@ static void lmb_reserve_uboot_region(void)
> >         ulong pram = 0;
> >
> >         rsv_start = gd->start_addr_sp - CONFIG_STACK_SIZE;
> > -       end = gd->ram_top;
> > +       end = gd->initial_relocaddr;
> >
> >         /*
> >          * Reserve memory from aligned address below the bottom of U-Boot stack
> > -        * until end of RAM area to prevent LMB from overwriting that memory.
> > +        * until the original relocation address to prevent LMB from
> > +        * overwriting that memory.
> >          */
> > -       debug("## Current stack ends at 0x%08lx ", (ulong)rsv_start);
> > +       debug("## Current stack ends at 0x%08lx\n", (ulong)rsv_start);
> >
> >  #ifdef CFG_PRAM
> >         pram = env_get_ulong("pram", 10, CFG_PRAM);
> > --
> > 2.54.0
> >
