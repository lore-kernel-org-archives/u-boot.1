Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA2ACCA470
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 06:45:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98392838BB;
	Tue,  7 Oct 2025 08:45:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kN1XegpN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC80F838BF; Tue,  7 Oct 2025 08:45:12 +0200 (CEST)
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE889838AE
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 08:45:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-63bbf5f77daso3469365d50.3
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 23:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759819508; x=1760424308; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ynzZZ7dJgoFtVRC3qG8jTD/v2rJt9KJvTMzNpUs9OFo=;
 b=kN1XegpNbUCdZCCtlLQJjHV2EH7JxvK6h1VTg1oq1YnA+OcQZKFELlxd9Pc7f5UFgf
 TAmWpLOkiNNGdcP55Q34NsjsYZeDOK+c8miyr0CRp4Cv8GkagNjmXvhAxaDmiJEwYCrd
 oVAc40uHbvi4MYHo7Z9HH+EkgCBcX+i8VfeSaAkL0IjncvUJ4viEDu6jN+Q2TWAmgtAi
 lLYD2OymFhXtOiuXicz6p2iEgf7blubHsAnlYezUMiLYNe9ArdIebHB/YGs/y/EQp4a9
 vbxtLQGNJY3QD1PR4GR2v6dArKHM1MloUDtFrq+sXrmVe90FjjkB1X+jiZZCSfr8BzwM
 mQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759819508; x=1760424308;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ynzZZ7dJgoFtVRC3qG8jTD/v2rJt9KJvTMzNpUs9OFo=;
 b=FfxIur3ui0uEapw93fptJUTDGp/hVSAQ8Hgu0gYff6Vru/STM1rXXpECvWR9IC7z1W
 ctTnaqGrjQC/jHtbrd5XupUU8jDt+8hgKyfxgWwYS12g6PzqDHvWCxGg4YVRc9oPsGPA
 7yHBGlRYkqaG1v3BET7iVcPT/dlOMTMIPOK4gQ/Cx+fCraUAx0S2uLPP72P8jIZorSIw
 mfpXEZ/BgyL7cWJL76GgxeNGiyNYvMe+FYotf1KxSG3ahChpepoNi8Lbqx/KL69zcH0w
 jO8HjTy+pOU0prZXJ6h/EtX44aw028Vqa28rRFycmrfVOzASfTs+aFTK8QQgVsLopiaG
 qNMA==
X-Gm-Message-State: AOJu0YyysZBjDQOSHf6XJdH3SxJoWwhBbOMGtQ4R146QgnnQ0CtUcXiQ
 Ttr/6THZVJWtBIrb/8IKgChPoRqNGjUBrz3qtFYuIVjyIlYIz7ppQn+9FJM4PB815/QZ3aR/r8H
 LV/pxblmg/3ShoCFhoACSaq3whZzqNUUTVCxdYxuGHA==
X-Gm-Gg: ASbGncuDOv2QwdEvL1MXefPZMuR/KA6Al+bxCLR/8qdUBoEw1dnzpbCrSgaXfcyQ1cb
 r0k3GQsQ4+iIrfsXlAsa73yA+bv8SLqNHgq3OBYK0sdCDJ/ETI0DQam7iYbNoHERdA82ywF0W/8
 Emzhv4vOW9w5h1NMUWPsyN0DLxi6MCSykDwm0EHFkW5iQ2rOOQ3JbRDTBvMy8ktzebJw4ScJCJy
 NolCIes0UuU8U2qLHDfoyr48i5tGQuHoq0=
X-Google-Smtp-Source: AGHT+IGteOhhT1lJkQPfK5IqYt2h94NLZ8Dp+vQYE6EMG6zEUlDFONUeZ4H6QhVS67FzkCXNT4D+3VGaVYuhMmoayrc=
X-Received: by 2002:a53:ac41:0:b0:633:bf4d:f0e7 with SMTP id
 956f58d0204a3-63b9a0e0f15mr10565897d50.30.1759819507783; Mon, 06 Oct 2025
 23:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <20251006082852.4008937-1-anshuld@ti.com>
In-Reply-To: <20251006082852.4008937-1-anshuld@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 7 Oct 2025 09:44:31 +0300
X-Gm-Features: AS18NWDcu2c8ptqvB6JBbwFs_OxpCLTN69bj07GLPLQQjExnF8USpZArujzVrdg
Message-ID: <CAC_iWjJ58nUm9ZGk0Q+n1kPSQ+GKxDGfPOXheoPDkUt+2A-6dQ@mail.gmail.com>
Subject: Re: [PATCH -next v8 00/11] Add support for dynamic MMU configuration
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, d-gole@ti.com, b-padhi@ti.com, vigneshr@ti.com, 
 trini@konsulko.com, nm@ti.com, robertcnelson@gmail.com, w.egorov@phytec.de, 
 francesco.dolcini@toradex.com, ggiordano@phytec.com, m-chawdhry@ti.com, 
 afd@ti.com, bb@ti.com, u-kumar1@ti.com, devarsht@ti.com, xypron.glpk@gmx.de
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

Hi Anshul,

Apologies for not looking at this earlier.

I'll have a look within the week.

Regards
/Ilias

On Mon, 6 Oct 2025 at 11:29, Anshul Dalal <anshuld@ti.com> wrote:
>
> Hi all,
>
> In U-Boot, TI only provides a single memory map for all k3 platforms, this
> does not scale for devices where atf and optee lie outside the range 0x80000000
> - 0x80080000 and 0x9e780000 - 0xa0000000 respectively.
>
> There are also issues for devices with < 2GiB of memory (eg am62SiP with 512MiB
> of RAM) as the maximum size for the first DRAM bank is hardcoded to 2GiB in the
> current memory map. Furthermore the second DRAM bank is mapped even for devices
> that only have a single bank.
>
> Therefore this patch set adds the required functionality to create the MMU table
> at runtime based on the device-tree.
>
> The patch set has been build tested on all effected platforms but boot-tested
> only on TI's K3 EVMs, the beagleplay and phytec's phycore-am6* platforms.
>
> The following effected boards have not been boot tested:
>  - verdin-am62
>  - iot2050
>
> Best Wishes,
> Anshul
> ---
> Changes in v8:
>  - Reserve extra space for page table entries for performing fixups
> v7: https://lore.kernel.org/u-boot/20250912121618.1074054-1-anshuld@ti.com/
>
> Changes in v7:
>  - Pick up R-by and Tested-by tags
>  - Use nobreak API for unmapping MMU region
>  - Better error messages and minor refactor
> v6: https://lore.kernel.org/u-boot/20250905081902.489345-1-anshuld@ti.com/
>
> Changes in v6:
>  - Make use of generic MMU APIs
>  - Extend core U-Boot functionality by adding mmu_unmap_reserved_mem and
>    mem_map_fix_dram_banks
>  - Keep same memory maps for SPL and U-Boot proper
>  - Add fdt fixups from SPL stage for reserved memory nodes
> v5: https://lore.kernel.org/u-boot/20250703133533.104758-1-anshuld@ti.com/
>
> Changes in v5:
>  - Don't create carveouts for every reserved-memory node
>  - Only create carveouts for ATF/OP-TEE
>  - Expand the call to k3_mem_map_init to vendor boards as well
>  - Map area for framebuffer for CONFIG_VIDEO=y platforms
> v4: https://lore.kernel.org/u-boot/20250618124210.1936140-1-anshuld@ti.com/
>
> Changes for v4:
>  - Add call to k3_mem_map_init for beagleplay
>  - Mark reserved regions as non-cacheable
>  - More debug logs
> v3: https://lore.kernel.org/u-boot/20250617135844.2873701-1-anshuld@ti.com/
>
> Changes for v3:
>  - Remove unused memory regions in SPL's map
>  - Add runtime addition of MMU entry for the framebuffer in SPL
>  - Refactor k3_mem_map_init to use standard u-boot APIs
>  - Unmap reserved-memory regions instead of keeping them uncached
> v2: https://lore.kernel.org/u-boot/20250610160833.1705534-1-anshuld@ti.com/
>
> Changes in v2:
> - Removed dependency to:
>   https://lore.kernel.org/u-boot/20250522150941.563959-1-anshuld@ti.com/
> v1: https://lore.kernel.org/u-boot/20250602120054.1466951-1-anshuld@ti.com/
> ---
>
> Anshul Dalal (11):
>   mach-k3: use minimal memory map for all K3
>   mach-k3: use custom enable_cache
>   arm: armv8: mmu: export mmu_setup
>   arm: armv8: invalidate dcache entries on dcache_enable
>   arm: armv8: mmu: add mem_map_fix_dram_banks
>   mach-k3: map all banks using mem_map_fix_dram_banks
>   arm: armv8: mmu: add mmu_unmap_reserved_mem
>   spl: split spl_board_fixups to arch/board specific
>   mach-k3: add reserved memory fixups for next boot stage
>   mach-k3: add carveouts for TFA and optee
>   arm: mach-k3: reserve space for page table entries
>
>  arch/arm/cpu/armv7m/cpu.c                  |  2 +-
>  arch/arm/cpu/armv8/cache_v8.c              | 58 ++++++++++++++++++++--
>  arch/arm/include/asm/armv8/mmu.h           | 24 +++++++++
>  arch/arm/mach-k3/arm64/arm64-mmu.c         | 40 +++++++--------
>  arch/arm/mach-k3/common.c                  | 55 ++++++++++++++++++++
>  arch/arm/mach-k3/include/mach/k3-ddr.h     |  6 +++
>  arch/arm/mach-rockchip/spl-boot-order.c    |  2 +-
>  arch/arm/mach-socfpga/spl_soc64.c          |  2 +-
>  board/beagle/beagley-ai/beagley-ai.c       |  2 +-
>  board/dhelectronics/dh_stm32mp1/board.c    |  2 +-
>  board/phytec/phycore_am62x/phycore-am62x.c |  2 +-
>  board/phytec/phycore_am64x/phycore-am64x.c |  2 +-
>  board/renesas/sparrowhawk/sparrowhawk.c    |  2 +-
>  board/starfive/visionfive2/spl.c           |  2 +-
>  board/ti/am62ax/evm.c                      |  2 +-
>  board/ti/am62px/evm.c                      |  2 +-
>  board/ti/am62x/evm.c                       |  2 +-
>  board/ti/am64x/evm.c                       |  2 +-
>  board/ti/j721e/evm.c                       |  2 +-
>  board/ti/j721s2/evm.c                      |  2 +-
>  board/ti/j722s/evm.c                       |  2 +-
>  board/ti/j784s4/evm.c                      |  2 +-
>  common/spl/spl.c                           | 12 +++--
>  include/spl.h                              | 12 +++--
>  24 files changed, 191 insertions(+), 50 deletions(-)
>
> --
> 2.51.0
>
