Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3D7CAC58F
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 12:16:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBF428344E;
	Fri, 12 Sep 2025 14:16:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gWKwwiQj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 113EE833EB; Fri, 12 Sep 2025 14:16:32 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DD54830A0
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 14:16:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58CCGL2J966939;
 Fri, 12 Sep 2025 07:16:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757679381;
 bh=hkPSb/3vxip6YsCiGwvNRjP/cntj3jN23VnIttwSWMk=;
 h=From:To:CC:Subject:Date;
 b=gWKwwiQj2nbhOxS2aVL94w74I/WGNlkaPelFeJqkU2GaEqINqBl1qgxglvb7fZwLg
 gy0AU0BGmtQlanNm+Y2e0tLMeijqK50yNd3KxLJYOs+GYH7yIcJ2rKX+Vmb/ku1Igg
 WnY0nwcpHuabfbir2zMusjUGgDgUZUuu94iGpMiA=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58CCGLJB1965931
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 12 Sep 2025 07:16:21 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 12
 Sep 2025 07:16:20 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Sep 2025 07:16:20 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58CCGJNe3582142;
 Fri, 12 Sep 2025 07:16:20 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <d-gole@ti.com>, <b-padhi@ti.com>,
 <vigneshr@ti.com>, <trini@konsulko.com>, <nm@ti.com>,
 <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <afd@ti.com>, <bb@ti.com>, <u-kumar1@ti.com>,
 <devarsht@ti.com>, <ilias.apalodimas@linaro.org>
Subject: [PATCH -next v7 00/10] Add support for dynamic MMU configuration
Date: Fri, 12 Sep 2025 17:46:07 +0530
Message-ID: <20250912121618.1074054-1-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi all,

In U-Boot, TI only provides a single memory map for all k3 platforms, this
does not scale for devices where atf and optee lie outside the range 0x80000000
- 0x80080000 and 0x9e780000 - 0xa0000000 respectively.

There are also issues for devices with < 2GiB of memory (eg am62SiP with 512MiB
of RAM) as the maximum size for the first DRAM bank is hardcoded to 2GiB.
Furthermore the second DRAM bank is mapped even for devices that only have one.

Therefore this patch set adds the required functionality to create the MMU table
at runtime.

The patch set has been build tested on all effected platforms but boot-tested
only on TI's K3 EVMs, the beagleplay and phytec's phycore-am6* platforms.

The following effected boards have not been boot tested:
 - verdin-am62
 - iot2050

Depends on:
  [PATCH v1] mach-k3: fix reading size and addr from fdt on R5
  https://lore.kernel.org/u-boot/20250903111704.530700-1-anshuld@ti.com/

Best Wishes,
Anshul
---
Changes in v7:
 - Pick up R-by and Tested-by tags
 - Use nobreak API for unmapping MMU region
 - Better error messages and minor refactor
v6: https://lore.kernel.org/u-boot/20250905081902.489345-1-anshuld@ti.com/

Changes in v6:
 - Make use of generic MMU APIs
 - Extend core U-Boot functionality by adding mmu_unmap_reserved_mem and
   mem_map_fix_dram_banks
 - Keep same memory maps for SPL and U-Boot proper
 - Add fdt fixups from SPL stage for reserved memory nodes
v5: https://lore.kernel.org/u-boot/20250703133533.104758-1-anshuld@ti.com/

Changes in v5:
 - Don't create carveouts for every reserved-memory node
 - Only create carveouts for ATF/OP-TEE
 - Expand the call to k3_mem_map_init to vendor boards as well
 - Map area for framebuffer for CONFIG_VIDEO=y platforms
v4: https://lore.kernel.org/u-boot/20250618124210.1936140-1-anshuld@ti.com/

Changes for v4:
 - Add call to k3_mem_map_init for beagleplay
 - Mark reserved regions as non-cacheable
 - More debug logs
v3: https://lore.kernel.org/u-boot/20250617135844.2873701-1-anshuld@ti.com/

Changes for v3:
 - Remove unused memory regions in SPL's map
 - Add runtime addition of MMU entry for the framebuffer in SPL
 - Refactor k3_mem_map_init to use standard u-boot APIs
 - Unmap reserved-memory regions instead of keeping them uncached
v2: https://lore.kernel.org/u-boot/20250610160833.1705534-1-anshuld@ti.com/

Changes in v2:
- Removed dependency to:
  https://lore.kernel.org/u-boot/20250522150941.563959-1-anshuld@ti.com/
v1: https://lore.kernel.org/u-boot/20250602120054.1466951-1-anshuld@ti.com/
---
Anshul Dalal (10):
  mach-k3: use minimal memory map for all K3
  mach-k3: use custom enable_cache
  arm: armv8: mmu: export mmu_setup
  arm: armv8: invalidate dcache entries on dcache_enable
  arm: armv8: mmu: add mem_map_fix_dram_banks
  mach-k3: map all banks using mem_map_fix_dram_banks
  arm: armv8: mmu: add mmu_unmap_reserved_mem
  spl: split spl_board_fixups to arch/board specific
  mach-k3: add reserved memory fixups for next boot stage
  mach-k3: add carveouts for TFA and optee

 arch/arm/cpu/armv7m/cpu.c                  |  2 +-
 arch/arm/cpu/armv8/cache_v8.c              | 58 ++++++++++++++++++++--
 arch/arm/include/asm/armv8/mmu.h           | 24 +++++++++
 arch/arm/mach-k3/arm64/arm64-mmu.c         | 35 +++++--------
 arch/arm/mach-k3/common.c                  | 55 ++++++++++++++++++++
 arch/arm/mach-k3/include/mach/k3-ddr.h     |  6 +++
 arch/arm/mach-rockchip/spl-boot-order.c    |  2 +-
 arch/arm/mach-socfpga/spl_soc64.c          |  2 +-
 board/beagle/beagley-ai/beagley-ai.c       |  2 +-
 board/dhelectronics/dh_stm32mp1/board.c    |  2 +-
 board/phytec/phycore_am62x/phycore-am62x.c |  2 +-
 board/phytec/phycore_am64x/phycore-am64x.c |  2 +-
 board/renesas/sparrowhawk/sparrowhawk.c    |  2 +-
 board/starfive/visionfive2/spl.c           |  2 +-
 board/ti/am62ax/evm.c                      |  2 +-
 board/ti/am62px/evm.c                      |  2 +-
 board/ti/am62x/evm.c                       |  2 +-
 board/ti/am64x/evm.c                       |  2 +-
 board/ti/j721e/evm.c                       |  2 +-
 board/ti/j721s2/evm.c                      |  2 +-
 board/ti/j722s/evm.c                       |  2 +-
 board/ti/j784s4/evm.c                      |  2 +-
 common/spl/spl.c                           | 12 +++--
 include/spl.h                              | 12 +++--
 24 files changed, 186 insertions(+), 50 deletions(-)

-- 
2.51.0

