Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E10FF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 19:24:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EFEA84477;
	Sat, 25 Apr 2026 21:24:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XC9inRv5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D66E84486; Sat, 25 Apr 2026 21:24:46 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C313084150
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 21:24:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-8acb3daf2aaso141321346d6.0
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 12:24:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777145082; cv=none;
 d=google.com; s=arc-20240605;
 b=WtgTyB6UhpJ3epEmDIsP4c7IyPB5B3kyHtmlUc/PTf50S4z/1Ij0FncTLVg3rx+mL9
 25iSJjCRlC7Jj+DbhzpKcRodUInVH37kJayGEVQsdgDQQoUvt514KHRbuzuRC65y9aIj
 g6xVBSQh8dYIybStZlifZmQw6O07q7z7lhWYOwWfPkmgVNHTz/J9bDXamUr7NmvNaKDC
 c6jzFCJe3fDh0zSzg+i16meTvdx/fZLVCbKeDuiXDSY2tK3XK5/uvHjsQexl06Co0VoD
 D9qgt2rClkAiXGClWPWpVdEGZuDdGtQXDocO2n6ZTc23Vfq3P0QYIUvsrMkpVlAIk8Uf
 7vsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=S4yqOvf7Tn4TAglXif1b4tUkV91UewjtcMxLLm3X5ac=;
 fh=rGTlpI2g1HkNrGA1Gi/Rt1XiDrfE2UGZzvMpppubQLI=;
 b=bnpB1GPKMgGFJOtRO//lSusY/OCucU+0OB3l0U5AJP2mdiuOdXMICRtcZHlK86DAl6
 2SHfg2VdnOphRGv4ay1iRM8Ufud4lbUhjncDNJ20aBVkNYGvDs+wGDRr28Wb08tfCUw0
 QnAZa2iNZDqcOEFTpP5if5QmL1UEA/2E7EMlnDflh0IA1Mq2dqjCf0OPBlmniDaPfFsU
 Z/VWfSegzFKCbMoKObLIb3GewvV5bLiqWpmPkFIVT1+IjUs2RC/7ki+HVzTF79H2Yt3f
 KbdT+958dTU1XL7ML1CNtYYHTewNNwK5zRqgAMqZNdGD5XZxHZ7vARzy5yJ5UsOMS/66
 YT+A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777145082; x=1777749882; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S4yqOvf7Tn4TAglXif1b4tUkV91UewjtcMxLLm3X5ac=;
 b=XC9inRv5EPAC2kCrEcqb5rTEAyqdPOtxzptCwO6FjBiRJWpKsL7kqwahHxeisDI9az
 lJ42T8A7UJ95pWCB3G63eVTtp+kg1NYaqhw7uV0FCxPyJyqizLJ8wwY7UdwJh8+mvvWn
 tIKWA4mrzHWJoMsNqOy1raRElfEJL8JTj2NXqpOuIrwCwnw1WD5PWOZCQrKeHB9LRW0Y
 f2RmHnLm+qBvPDsbZRIyX7w5OiTzqOsmGekbHqw8dZ/GyzEbj9jUGfxFoK5VW/PR0WKG
 +YF9ev0GqsEDjozBqjJvYB1toH8M5mVWAXE5a227PXTnWOVjU0i0RYbKInGdLMtmsz9x
 oE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777145082; x=1777749882;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S4yqOvf7Tn4TAglXif1b4tUkV91UewjtcMxLLm3X5ac=;
 b=o2XNgKwht+PhdBXBkNWRZjYWoaAFZV2wTLGLOUPv/1YzZ6Rml9En+aHdBLAp72DDd5
 PsHgeBQVunwTqEhdvfWyIUMXwACFS3gLa06wC3W9RIBxalAGbBTt0QoJYtTjGMy359vt
 8peTvINlYgy4NcsiJWDh2GHdP2v0IvF9Bist1+g49mciPX9/TvSntHC0BwyEn6L/g4rq
 rwhUdFSJTCc/bvZEGaQ85IZ+MKUAfmlac+K2yVGICtqFZPLLMm5AXOCvZ0nwaZBsgrHY
 yZ9CwJWZyiHrw19c5A4bY6yESo3oN5yO+T94OUgvLpAFGDRrP163hldp4DPSq4U628DU
 HFDw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+V75HGik1eh3ujl/ARRZtjHuDyNPFcDXD1UbRtktjrsTyKW7PINHR0Tla++tyX7lowDNfmc8o=@lists.denx.de
X-Gm-Message-State: AOJu0YzW3dJfUMX+lo7vFV7vi7ItIyO8EQ98IfqrKpxj/rSGYBIZ5XU5
 1jkyIWC5CTM82JSTpiaYXFyyB7MRAvlh6LgMCtfe1C0xJoZmqzwSQKmqIDXWZYVdB1hbGU7hKnD
 fHSXRYxXuduqCn438JVdRcYfSZP2R//kbICV3T+ZjauUQgv+PGkE1
X-Gm-Gg: AeBDieuDOkh5z2Qtt7G6iZs+0QLU/ta7X5shBnFpyg9XF2U+QO/2JvIVdMnnNmkG/Aa
 LFcWumedx91i1WZzvEazMf119Pt3FU4/b3GENkQ6Yc7w/gT1hG/4TZzzVkqoLHn2LeVEbUEj1sB
 V3JkQlrRUr+2/Jfz107AzdGDd/YnGM0X3DVtcJUwTQf+WShgCQ4B3xkq1xwZ91kVwjhqP7jnpUQ
 G9NxJ/Z+MGRLSm/C6HEe+dbLIc6J4sUo/RHt4dZmxqvK0AO076nrAI4IJcOYT44WUrCK1raLJ2O
 i8AN42YZzOw/sEmTw9QpERsTmbQMyjDrxSoyHeajnY5uomj86J4b6SRejyIl0SBe4r6q/5UJaNB
 dC9LReHC9CEP4FMkRPWh4R+xmXg7CPdRICe8FbEA4zXFr9r5Ug0o+nBOvSQbg7wAqzY77GNEt1d
 yEMtXT6UjKiC2qbFwHEmSstL27OYZ+cL0XAddCQX7ygDnX967glfmVWfQefbZchhTxoCqwbqF+b
 kwwlHiRw7H91HfmrGLcbNVCEUeGy9T1ODdyqDlqfdM2i2d0gwuUGRash6Nk0Q2c2UUsV+rudqdg
 LSzbhx+SZWxRrjwMP3QYjPdTab1PpdphxQX4UOO+MlBjUDNTsuoYQA==
X-Received: by 2002:a05:690e:2445:b0:651:cf77:f7cd with SMTP id
 956f58d0204a3-653107f85f0mr19865670d50.13.1776957345340; Thu, 23 Apr 2026
 08:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260416055948.130041-1-ilias.apalodimas@linaro.org>
 <8dd2dc28-5e3a-4b0a-9377-7e4bc6060633@amd.com>
In-Reply-To: <8dd2dc28-5e3a-4b0a-9377-7e4bc6060633@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 23 Apr 2026 18:15:04 +0300
X-Gm-Features: AQROBzCLIUCffInxFX0jYpfTbMqtxg1xJDBP_FPKa8EArV3IYLoXd944hZ-7wwU
Message-ID: <CAC_iWj+JmwW6gDmUf76OX0WiW+RQy-DA2STs+ROHH-i0AbGJ2A@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Relocate U-Boot in the last bank
To: Michal Simek <michal.simek@amd.com>
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, 
 anshuld@ti.com, sjg@chromium.org, u-boot@lists.denx.de
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

Thanks Michal!

On Thu, 23 Apr 2026 at 16:54, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 4/16/26 07:59, Ilias Apalodimas wrote:
> > Hi This is v2 of [1]!
> >
> > There was a discussion recently on the mailing lists regarding our
> > management of memory above ram_top [0]. The tl;dr is that we have two problems.
> >
> > The first one is that U-Boot always relocates to the top of the first available
> > bank unless there's special board code to sidestep that. The second is we don't
> > successfully deal with devices that can only do 32-bit DMA.
> >
> > This patch series deals with the first problem by adding a Kconfig option
> > allowing platforms to relocate to the top of the last discovered bank.
> >
> > It's worth noting that this is easily testable with QEMU
> >
> > qemu-system-aarch64 -m 8192 -smp 2 -nographic -cpu cortex-a57 \
> >      -machine virt,secure=off \
> >      -bios u-boot.bin \
> >      -device virtio-rng-pci \
> >      -drive id=os,if=none,file="$image" \
> >      -device virtio-blk-device,drive=os \
> >      -object memory-backend-ram,id=ram0,size=4G \
> >      -object memory-backend-ram,id=ram1,size=4G \
> >      -numa node,memdev=ram0 \
> >      -numa node,memdev=ram1
> >
> > # RELOCATE_LAST_BANK not set
> > Hit any key to stop autoboot: 0
> > => bdinfo
> > [...]
> > relocaddr   = 0x000000013f66c000
> > reloc off   = 0x000000013f66c000
> > [...]
> > lmb_dump_all:
> >   memory.count = 0x1
> >   memory[0]   [0x40000000-0x23fffffff], 0x200000000 bytes, flags: none
> >   reserved.count = 0x2
> >   reserved[0] [0x13d507000-0x13d509fff], 0x3000 bytes, flags: no-notify, no-overwrite
> >   reserved[1] [0x13d50aff0-0x23fffffff], 0x102af5010 bytes, flags: no-overwrite
> > devicetree  = board
> > [...]
> > TLB addr    = 0x000000013ffe0000
> > irq_sp      = 0x000000013e50aff0
> > sp start    = 0x000000013e50aff0
> > Early malloc usage: e88 / 2000
> > =>
> >
> > # RELOCATE_LAST_BANK enabled
> >
> > => bdinfo
> > [...]
> > relocaddr   = 0x000000023f66c000
> > reloc off   = 0x000000023f66c000
> > [...]
> > lmb_dump_all:
> >   memory.count = 0x1
> >   memory[0]   [0x40000000-0x23fffffff], 0x200000000 bytes, flags: none
> >   reserved.count = 0x2
> >   reserved[0] [0x23d507000-0x23d509fff], 0x3000 bytes, flags: no-notify, no-overwrite
> >   reserved[1] [0x23d50aff0-0x23fffffff], 0x2af5010 bytes, flags: no-overwrite
> > devicetree  = board
> > [...]
> > TLB addr    = 0x000000023ffe0000
> > irq_sp      = 0x000000023e50aff0
> > sp start    = 0x000000023e50aff0
> > Early malloc usage: e88 / 2000
> > =>
> >
> > Patch #1 - Clean up from Marek
> > Patch #2 - Introduce fdtdec_setup_mem_ram_top() from Marek
> > Patch #3 - The boilerplate code that moves bi_dram from bd to gd
> > Patch #4 - Moves the ram_base calculation in its own initcall
> > Patch #5 - Cleans up and prepares setup_dest_addr()
> > Patch #6 - Adds the Kconfig option and code to allow us to relocate in top
> >             memory banks
> >
> > [1] https://lore.kernel.org/u-boot/20260403090109.3564638-1-ilias.apalodimas@linaro.org/
> >
> > Changes since v1:
> > - Rebased and added Marek's cleanup patches
> > - Remove the ifdefery on patch #6 in favor of 'if (CONFIG_IS_ENABLED)'
> > - Added a warning on the Kconfig message about breaking devices that
> >    can't DMA to high memory
> > - Added depends on EXPERT for relocatiing to the last bank
> > - Using %llx instead of %llX on debug prints
> > - Removed 2 remaining comments of bd->bi_dram[]
> > - Collected Tested/Reviewed-by tags
> >
> > Ilias Apalodimas (4):
> >    treewide: move bi_dram[] from bd to gd
> >    common: move ram_base calculation to independent INITCALL()
> >    common: Clean up setup_dest_addr()
> >    common: Add an option to relocate on ram top
> >
> > Marek Vasut (2):
> >    fdtdec: Deduplicate iterator function
> >    fdtdec: Introduce fdtdec_setup_mem_ram_top() to determine end of
> >      topmost DRAM bank
> >
> >   Kconfig                                       |  10 ++
> >   api/api_platform.c                            |   4 +-
> >   arch/arm/cpu/armv8/cache_v8.c                 |   6 +-
> >   arch/arm/cpu/armv8/fsl-layerscape/cpu.c       | 116 +++++++++---------
> >   arch/arm/lib/bootm-fdt.c                      |   5 +-
> >   arch/arm/lib/bootm.c                          |   4 +-
> >   arch/arm/lib/cache-cp15.c                     |   9 +-
> >   arch/arm/lib/image.c                          |   2 +-
> >   arch/arm/mach-airoha/an7581/init.c            |   8 +-
> >   arch/arm/mach-apple/board.c                   |   4 +-
> >   arch/arm/mach-davinci/misc.c                  |   4 +-
> >   arch/arm/mach-imx/ele_ahab.c                  |   7 +-
> >   arch/arm/mach-imx/imx8/ahab.c                 |   7 +-
> >   arch/arm/mach-imx/imx8/cpu.c                  |  44 +++----
> >   arch/arm/mach-imx/imx8m/soc.c                 |  24 ++--
> >   arch/arm/mach-imx/imx8ulp/soc.c               |  20 +--
> >   arch/arm/mach-imx/imx9/scmi/soc.c             |  24 ++--
> >   arch/arm/mach-imx/imx9/soc.c                  |  24 ++--
> >   arch/arm/mach-imx/mx5/mx53_dram.c             |   8 +-
> >   arch/arm/mach-imx/spl.c                       |   4 +-
> >   arch/arm/mach-k3/k3-ddr.c                     |   4 +-
> >   arch/arm/mach-mvebu/alleycat5/cpu.c           |   4 +-
> >   arch/arm/mach-mvebu/armada3700/cpu.c          |  10 +-
> >   arch/arm/mach-mvebu/armada8k/dram.c           |  10 +-
> >   arch/arm/mach-mvebu/dram.c                    |   6 +-
> >   arch/arm/mach-omap2/am33xx/board.c            |   4 +-
> >   arch/arm/mach-omap2/omap-cache.c              |   5 +-
> >   arch/arm/mach-omap2/omap3/emif4.c             |   8 +-
> >   arch/arm/mach-omap2/omap3/sdrc.c              |   8 +-
> >   arch/arm/mach-owl/soc.c                       |   4 +-
> >   arch/arm/mach-renesas/memmap-gen3.c           |   8 +-
> >   arch/arm/mach-renesas/memmap-rzg2l.c          |   4 +-
> >   arch/arm/mach-rockchip/rk3588/rk3588.c        |   8 +-
> >   arch/arm/mach-rockchip/sdram.c                |  40 +++---
> >   arch/arm/mach-snapdragon/board.c              |  12 +-
> >   arch/arm/mach-socfpga/board.c                 |   5 +-
> >   arch/arm/mach-socfpga/misc_arria10.c          |   7 +-
> >   .../mach-stm32mp/cmd_stm32prog/stm32prog.c    |   4 +-
> >   arch/arm/mach-stm32mp/stm32mp1/cpu.c          |   7 +-
> >   arch/arm/mach-tegra/board2.c                  |  14 +--
> >   arch/arm/mach-tegra/cboot.c                   |   4 +-
> >   arch/arm/mach-uniphier/dram_init.c            |   6 +-
> >   arch/arm/mach-uniphier/fdt-fixup.c            |   8 +-
> >   arch/arm/mach-versal-net/cpu.c                |   8 +-
> >   arch/arm/mach-versal/cpu.c                    |  16 +--
> >   arch/arm/mach-versal2/cpu.c                   |   6 +-
> >   arch/arm/mach-zynqmp/cpu.c                    |   8 +-
> >   arch/mips/mach-octeon/dram.c                  |   4 +-
> >   arch/riscv/cpu/k1/dram.c                      |  12 +-
> >   arch/sandbox/cpu/spl.c                        |   4 +-
> >   arch/x86/cpu/coreboot/sdram.c                 |   4 +-
> >   arch/x86/cpu/efi/payload.c                    |   4 +-
> >   arch/x86/cpu/efi/sdram.c                      |   4 +-
> >   arch/x86/cpu/intel_common/mrc.c               |   4 +-
> >   arch/x86/cpu/ivybridge/sdram_nop.c            |   4 +-
> >   arch/x86/cpu/qemu/dram.c                      |   8 +-
> >   arch/x86/cpu/quark/dram.c                     |   4 +-
> >   arch/x86/cpu/slimbootloader/sdram.c           |   4 +-
> >   arch/x86/cpu/tangier/sdram.c                  |   4 +-
> >   arch/x86/lib/bootm.c                          |   5 +-
> >   arch/x86/lib/fsp/fsp_dram.c                   |  18 +--
> >   board/CZ.NIC/turris_1x/turris_1x.c            |  42 +++----
> >   board/armltd/corstone1000/corstone1000.c      |   4 +-
> >   board/armltd/integrator/integrator.c          |   4 +-
> >   board/armltd/total_compute/total_compute.c    |   6 +-
> >   board/armltd/vexpress/vexpress_common.c       |   8 +-
> >   board/atmel/common/video_display.c            |   2 +-
> >   .../sam9x60_curiosity/sam9x60_curiosity.c     |   2 +-
> >   .../sam9x75_curiosity/sam9x75_curiosity.c     |   2 +-
> >   .../atmel/sama5d27_som1_ek/sama5d27_som1_ek.c |   2 +-
> >   .../sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c   |   2 +-
> >   .../sama5d29_curiosity/sama5d29_curiosity.c   |   2 +-
> >   .../atmel/sama5d2_xplained/sama5d2_xplained.c |   2 +-
> >   .../sama7d65_curiosity/sama7d65_curiosity.c   |   2 +-
> >   .../sama7g54_curiosity/sama7g54_curiosity.c   |   2 +-
> >   board/broadcom/bcmns3/ns3.c                   |   4 +-
> >   board/compulab/cm_fx6/cm_fx6.c                |  28 ++---
> >   board/elgin/elgin_rv1108/elgin_rv1108.c       |   4 +-
> >   board/esd/meesc/meesc.c                       |   4 +-
> >   board/friendlyarm/nanopi2/board.c             |  10 +-
> >   board/ge/mx53ppd/mx53ppd.c                    |   8 +-
> >   board/hisilicon/hikey/hikey.c                 |  24 ++--
> >   board/hisilicon/hikey960/hikey960.c           |   4 +-
> >   board/hisilicon/poplar/poplar.c               |   4 +-
> >   board/k+p/kp_imx53/kp_imx53.c                 |   4 +-
> >   board/keymile/pg-wcom-ls102xa/ddr.c           |   4 +-
> >   board/kontron/sl28/sl28.c                     |   4 +-
> >   board/kontron/sl28/spl_atf.c                  |   6 +-
> >   board/liebherr/btt/btt.c                      |   2 +-
> >   board/menlo/m53menlo/m53menlo.c               |   8 +-
> >   board/nuvoton/arbel_evb/arbel_evb.c           |  26 ++--
> >   board/nxp/imxrt1020-evk/imxrt1020-evk.c       |   2 +-
> >   board/nxp/imxrt1050-evk/imxrt1050-evk.c       |   2 +-
> >   board/nxp/imxrt1170-evk/imxrt1170-evk.c       |   2 +-
> >   board/nxp/ls1021aqds/ddr.c                    |   4 +-
> >   board/nxp/ls1028a/ls1028a.c                   |  10 +-
> >   board/nxp/ls1043aqds/ls1043aqds.c             |   8 +-
> >   board/nxp/ls1043ardb/ls1043ardb.c             |   8 +-
> >   board/nxp/ls1046afrwy/ls1046afrwy.c           |   8 +-
> >   board/nxp/ls1046aqds/ls1046aqds.c             |   8 +-
> >   board/nxp/ls1046ardb/ls1046ardb.c             |   8 +-
> >   board/nxp/ls1088a/ls1088a.c                   |   6 +-
> >   board/nxp/ls2080aqds/ls2080aqds.c             |  14 +--
> >   board/nxp/ls2080ardb/ls2080ardb.c             |  14 +--
> >   board/nxp/lx2160a/lx2160a.c                   |   6 +-
> >   board/phytec/phycore_am62x/phycore-am62x.c    |  26 ++--
> >   board/phytec/phycore_am64x/phycore-am64x.c    |  18 +--
> >   board/phytium/durian/durian.c                 |   4 +-
> >   board/phytium/pe2201/pe2201.c                 |   4 +-
> >   board/raspberrypi/rpi/rpi.c                   |   4 +-
> >   board/renesas/common/rcar64-common.c          |   6 +-
> >   board/renesas/genmai/genmai.c                 |   4 +-
> >   board/renesas/sparrowhawk/sparrowhawk.c       |   8 +-
> >   board/ronetix/pm9261/pm9261.c                 |   4 +-
> >   board/ronetix/pm9263/pm9263.c                 |   4 +-
> >   board/ronetix/pm9g45/pm9g45.c                 |   4 +-
> >   board/samsung/arndale/arndale.c               |   4 +-
> >   board/samsung/common/board.c                  |   6 +-
> >   board/samsung/exynos-mobile/exynos-mobile.c   |   4 +-
> >   board/samsung/goni/goni.c                     |  12 +-
> >   board/samsung/smdkc100/smdkc100.c             |   4 +-
> >   board/samsung/smdkv310/smdkv310.c             |  16 +--
> >   board/siemens/iot2050/board.c                 |  16 +--
> >   board/socionext/developerbox/developerbox.c   |   6 +-
> >   board/st/stih410-b2260/board.c                |   4 +-
> >   board/ste/stemmy/stemmy.c                     |   4 +-
> >   board/ti/dra7xx/evm.c                         |   8 +-
> >   board/ti/ks2_evm/board.c                      |   4 +-
> >   board/toradex/colibri_imx7/colibri_imx7.c     |   8 +-
> >   board/toradex/verdin-am62/verdin-am62.c       |   2 +-
> >   board/toradex/verdin-am62p/verdin-am62p.c     |   2 +-
> >   board/traverse/ten64/ten64.c                  |   6 +-
> >   board/xilinx/zynq/cmds.c                      |   6 +-
> >   board/xilinx/zynqmp/zynqmp.c                  |   6 +-
> >   boot/image-board.c                            |   2 +-
> >   boot/image-fdt.c                              |   4 +-
> >   cmd/bdinfo.c                                  |   6 +-
> >   cmd/ti/ddr4.c                                 |   8 +-
> >   cmd/ufetch.c                                  |   4 +-
> >   common/board_f.c                              |  65 +++++++---
> >   common/init/handoff.c                         |  10 +-
> >   drivers/bootcount/bootcount_ram.c             |   4 +-
> >   drivers/ddr/altera/sdram_agilex.c             |   4 +-
> >   drivers/ddr/altera/sdram_agilex5.c            |  18 +--
> >   drivers/ddr/altera/sdram_agilex7m.c           |   4 +-
> >   drivers/ddr/altera/sdram_arria10.c            |  12 +-
> >   drivers/ddr/altera/sdram_n5x.c                |   4 +-
> >   drivers/ddr/altera/sdram_s10.c                |   4 +-
> >   drivers/ddr/altera/sdram_soc64.c              |  28 ++---
> >   drivers/mmc/mvebu_mmc.c                       |   4 +-
> >   drivers/net/mvgbe.c                           |   4 +-
> >   drivers/pci/pci-uclass.c                      |   8 +-
> >   drivers/usb/host/ehci-marvell.c               |   4 +-
> >   drivers/video/meson/meson_vpu.c               |   8 +-
> >   drivers/video/sunxi/sunxi_de2.c               |   2 +-
> >   drivers/video/sunxi/sunxi_display.c           |   2 +-
> >   include/asm-generic/global_data.h             |   7 ++
> >   include/asm-generic/u-boot.h                  |   4 -
> >   include/configs/m53menlo.h                    |   4 +-
> >   include/configs/mx53cx9020.h                  |   4 +-
> >   include/configs/mx53loco.h                    |   4 +-
> >   include/configs/mx53ppd.h                     |   4 +-
> >   include/fdtdec.h                              |  23 +++-
> >   include/init.h                                |   2 +-
> >   lib/fdtdec.c                                  | 102 +++++++--------
> >   lib/lmb.c                                     |  13 +-
> >   test/cmd/bdinfo.c                             |   7 +-
> >   167 files changed, 802 insertions(+), 756 deletions(-)
> >
> > --
> > 2.53.0
> >
>
> Tested-by: Michal Simek <michal.simek> # Versal Gen 2 Vek385
>
> Thanks,
> Michal
>
>
