Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138AFFF885D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 09:03:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A059845E3;
	Tue, 28 Apr 2026 11:03:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HA9ch525";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1620B845E3; Tue, 28 Apr 2026 11:03:32 +0200 (CEST)
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B12FB845D0
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 11:03:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-6579254f996so1780951d50.1
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 02:03:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777367005; cv=none;
 d=google.com; s=arc-20240605;
 b=EcctNk9cnwvJP1ADOihisrvcXexGZGvGhLGITw/nVjXGYO/FJGfWh/7yNg/X/hYJry
 tz8xtS+Aj2fNkX4UrrAt0uf1Pnl9FX7swtp3/XHDXau1RyROZSr2lEgSM6YRuynyuWff
 t8p43XEAD0yRnVZc/+baFuCG1fqsUi9MaQlEyRNYUfaES9h/p2fXS3/z/ITFrLrPmTHA
 EaHaotXkINmO+VMS65CfDN6gu6T8NrnRWFBfC1ifDQiQrTaP4qgVl4RyJYXPPS7slFWY
 r44iWhFhplVeoq4nxQXAn5e4gFubAEimUQvIroyRSGCJ3/2imCi3QUWCnI2s0L6NA+hC
 WVJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Bx7ru0zSOCgiEboKHjZP53TQNaG/DuzgA3qQQBs5Tzc=;
 fh=zWfFTWCuXvOjM3LDz/lM7B2RDNqudaMbYcPQVJofaSo=;
 b=lUUGMQc5BsQm2Z0sldSUJmJV/S68aF7TFgfYw33x0ULYaBkqfa+9y2NzGthsN8gIM5
 RbNXiBsHUaVXkBH3GGXJCIXav0G4FjWvhMHjueo/whmX+jrB0NjCQo3fw1omsm5bpzx/
 V0s8+PctS+nURdgQrS02a3Nhj81N1KFTexp+AGGXoKx+qQcTTlNgnevJ/UJqA8avO0Gy
 aoj6+xv8S0l3FuZi5yWl5jvrNKoZ9IwzjnUVohQ8UpROHGyvfhB0G/Kj/aC4NyqNms0+
 m9Nut3Jve2S5BNxt+O6TrgY2xIxhVLZu7mPcPMUZTTVo93uCKKHpSiPOYg/EZ/1YDwy8
 PHhA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777367005; x=1777971805; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Bx7ru0zSOCgiEboKHjZP53TQNaG/DuzgA3qQQBs5Tzc=;
 b=HA9ch525VKLRP2x9r/cL4dJywwmq1QPoaQPX2GiIjGCR/HplNFbPzUGCeOHId75FoW
 uXRq/Jh0ODSDCQC0acxU42cJSuST435FYKh0K0eIzL9Q5ivsloWUbx6lW/vIrjMFtwjW
 MpBjxKiEefYevgaGnT0tEIzMOWvbTalHy7++JKAO0NNheTI2WmQkfa4JJKgJRj7Si89v
 M9km68BJb585BGwaxiPNTuK87RHMndPVPBSEZNRA1oRs5622HTBf7lMw5XgtXh2jBjAw
 y7lKIQ7h2FJCZcnlVz2JXYbBiXRce3fhSC3i1BY3EuCBLvnfv+krYaKhR29n0uaTEHSy
 L/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777367005; x=1777971805;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bx7ru0zSOCgiEboKHjZP53TQNaG/DuzgA3qQQBs5Tzc=;
 b=hYHl3EtL7I8aeGTCSjm9zA6TmXYkWF41RP+fHLvylPpHsPxWGMbijsLPht/gGDBnRY
 EwVqqmLHESVQ+y1DH1/TB9uBHV6WutwYn8QbAKyian+FTqEnYB0J7gvaoN+DdA+pxWU6
 EaVMZ2s98YXOSk37IBLiWHPhXPGr0pgNtz8jcDRDhUnk2ErXYJnKJdja9RGW0LnIAlQ3
 FcPPGyjvi5vPIkSjnqHC/Cdy8J3V1zxA+Iq0StmJ25y5npfofHmtFDBrDj2fNC9KI4jE
 Kr2N4sarNW5gQM4uowBe32tLelSyZQXFSFDvh+pCIvbui0AGEDcUvYQzVvLeHjOvYseh
 tuSQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+rUheizQPs9nsz17Wcqi1etTJJdkCELnpCO96uQCOae5s2jidE5BcELZBjqBEb7IiSJxahStE=@lists.denx.de
X-Gm-Message-State: AOJu0YwT7vrW9ZB+nSqBrAoAarmbvQwz91t/0uymxdvJgN8sL7aE1ixd
 phf2CwTrECHRiAjh0cfcGssuJJkRzG5+zqLQtXCPdX3v02v1hidUtxnZXvyfT0mBgypwfuyzLn/
 4DnhNR3VQmYhAbSnk5CGlLO457OMqfb4e28FhIcLs0Q==
X-Gm-Gg: AeBDiesWdhQKAYxBSIJx+Bl6pnrQkv/kj900AV17puhD/mMW7dANQjOmC1EMLvx69zz
 w8w0aGoQwfTYcB/eYEY9jaSK5wTq1ypeZ3fJU2RnIF8OOdep9Iv8TLcUatwYD2ECTIx8FYcpDPD
 DiGZvbPVJp+fDy5W2aD3UCOdPb7UW/HD8o70NYjBSrGCGjOORZoAp+JEQ7zTb4RVt1LNKXh+bOF
 BzTyq6MQNcXaNv792CkTnCBZCMDFH4Oj964I7VXqk3ay77f1XsQrqyNPp6aTxH/M39uBlQkZGwq
 F/cOCjATviWvi/yhduxJIPMoTfPTdjTRrBwWtcooWviAlwSMxjg/2L07jDulhwDKmkTUjcBZo7B
 Vcp/R6YeHoE+ehLb/7WFl/ZaL0Kzh40jm1t5xy6zhQ4PUTLNyw36hg6T3YYty0wZG8Wi5DRPLdT
 EktsSv2H8lNAkxHuin+t+L/6OItBbgaiqwWr/V4h9QXcFnZvwxV9JpCN4onBv+rMGpMI3NhCan3
 BuDkn4NWGmUBYTZXAivwYBOoqrHN0KYNYpqox35eD9KhXLHblFh06jKsMioLQkrO+JvthPALJkJ
 3X9CiSz51270QPLK9bqsrKulEyHT5VF84jB6qEwn5fpV8vtVEUCHdCS6sRyC0yunq7jh8JM1cjD
 BDEF9zikgGHjH075YPBVDba65avg=
X-Received: by 2002:a05:690e:1919:b0:651:c024:5733 with SMTP id
 956f58d0204a3-65beed6074cmr1756721d50.13.1777367004854; Tue, 28 Apr 2026
 02:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260422170946.3394481-1-rs@ti.com>
 <DI49CY1ANPIG.2ZJXQ5B7QUPFK@ti.com>
In-Reply-To: <DI49CY1ANPIG.2ZJXQ5B7QUPFK@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 28 Apr 2026 12:02:48 +0300
X-Gm-Features: AVHnY4LZ3z2knmCvJ8GHahgJVcBdAV9KyZgWg6wx-7CS5EeFWwS4pnwMzApPAf0
Message-ID: <CAC_iWjL20WKWT0FZ4VNLxM5XSONPYPFsE9Ms4h6ad=iu-9kGeQ@mail.gmail.com>
Subject: Re: [PATCHv5 0/6] various memory related fixups
To: Randolph Sapp <rs@ti.com>
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

On Tue, 28 Apr 2026 at 00:34, Randolph Sapp <rs@ti.com> wrote:
>
> On Wed Apr 22, 2026 at 12:09 PM CDT, rs wrote:
> > From: Randolph Sapp <rs@ti.com>
> >
> > Nitpicks and fixes from the discovery thread on adding PocketBeagle2 support
> > [1]. This does a lot of general setup required for the device, but these
> > modifications themselves aren't device specific. For those specifically
> > interested in PocketBeagle2 support and don't care about these details, my
> > development branch is public [2].
> >
> > That second patch may provoke some opinions, but honestly if that warning was
> > still present I wouldn't have spent a week poking holes in both the EFI and LMB
> > allocations systems. Please let me know if there is a specific usecase that it
> > breaks though.
> >
> > [1] https://lore.kernel.org/all/DHHC66BBMD27.YHGIH43C6XBK@ti.com/
> > [2] https://github.com/StaticRocket/u-boot/tree/feature/pocketbeagle2
> >
> > v2:
> >       - Remove additional increment and decrement in lmb_free_fdt_regions
> >       - Drop the patch to backfill EFI_CONVENTIONAL_MEMORY
> >       - Adjust the removal loop nitpick patch description
> >       - Change the reserve memory patch to use new end_addr_sp
> > v3:
> >       - Update lmb flags to use the macro documentation for constants
> >       - Change efi_mem_sort to use list_for_each_entry_safe
> > v4:
> >       - Fix typos in LMB allocation flags macro documentation
> >       - Rename end_addr_sp to initial_relocaddr
> >       - Keep the map_sysmem dance in the efi u-boot reservation
> >       - Use the active device tree pointed to by gd->fdt_blob to clean up old
> >         reservations
> > v5:
> >       - Keep return value as long in boot_fdt_reserve_region
> >       - Fix formatting in initial_relocaddr patch
> >
> >
> > Randolph Sapp (6):
> >   lmb: allocation flags macro documentation
> >   boot_fdt_add_mem_rsv_regions: free old dtb reservations
> >   efi_dt_fixup: use fdtdec_get_bool
> >   efi_selftest_memory: check for duplicates first
> >   efi_mem_sort: use list_for_each_entry_safe instead
> >   memory: reserve from start_addr_sp to initial_relocaddr
> >
> >  arch/mips/lib/bootm.c                  |  2 +-
> >  boot/bootm.c                           |  2 +-
> >  boot/bootm_os.c                        |  2 +-
> >  boot/image-board.c                     |  2 +-
> >  boot/image-fdt.c                       | 55 ++++++++++++++++++--------
> >  common/board_f.c                       |  9 ++++-
> >  include/asm-generic/global_data.h      |  7 ++++
> >  include/image.h                        |  2 +-
> >  include/lmb.h                          | 30 +++++++++++---
> >  lib/efi_loader/efi_dt_fixup.c          |  3 +-
> >  lib/efi_loader/efi_memory.c            | 49 ++++++++---------------
> >  lib/efi_selftest/efi_selftest_memory.c | 21 +++++-----
> >  lib/lmb.c                              | 41 ++++---------------
> >  13 files changed, 118 insertions(+), 107 deletions(-)
>
> Any more comments on this series?

Seen the emails, i got limited time to take a closer look. I'll try
doing it withing the week

Cheers
/Ilias
