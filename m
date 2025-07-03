Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EDE7C83F03
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 13:36:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E30D282F30;
	Thu,  3 Jul 2025 15:36:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UXN+mHzr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7272C82F14; Thu,  3 Jul 2025 15:36:24 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBFD380E9A
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 15:36:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 563DaIaP018329;
 Thu, 3 Jul 2025 08:36:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1751549778;
 bh=LqlSFd9uZPn74ENwp2gtJTfBwmgc2vvDi/cy61cVy0w=;
 h=From:To:CC:Subject:Date;
 b=UXN+mHzrXVkTorWTo2ca9+NoiXIsPgUB+CoG85/c6R1P7fNLiI5f0eaDWADZ/Ezxl
 cRhYgfAT1lvnBLgE41qJk66rxXs+9XwslS28KyMJEIxVyKEd4FW1dAEoKFSR14S07n
 vGulfoy7Hoqe532srAHROiPJDdYgNdZgPAdeX62k=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 563DaIfT405931
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 3 Jul 2025 08:36:18 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 3
 Jul 2025 08:36:18 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 3 Jul 2025 08:36:18 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 563DaHK0912222;
 Thu, 3 Jul 2025 08:36:17 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <nm@ti.com>, <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <a-nandan@ti.com>, <afd@ti.com>, <bb@ti.com>,
 <u-kumar1@ti.com>, <devarsht@ti.com>
Subject: [PATCH v5 0/4] Add support for dynamic MMU configuration
Date: Thu, 3 Jul 2025 19:05:25 +0530
Message-ID: <20250703133533.104758-1-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
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

In u-boot we only provide a single MMU table for all k3 platforms, this   does
not scale for devices where atf and optee lie outside the range   0x80000000 -
0x80080000 and 0x9e780000 - 0xa0000000 respectively.

There are also issues for devices with < 2GiB of memory (eg am62SiP with 512MiB
of RAM) as the maximum size is hardcoded to 2GiB. Furthermore higher DDR banks
are mapped even for devices with NR_DRAM_BANKS < 2.

Therefore this patch set adds the required functionality to create the MMU table
at runtime with proper configuration for the spl stage as well an added entry
for the framebuffer for supported platforms.

The patch set has been build tested on all effected platforms but boot-tested
only on TI's K3 EVMs and the beagleplay.

The following effected boards have not been boot tested:
 - phycore-am62a
 - phycore-am62x
 - phycore-am64x
 - verdin-am62
 - iot2050

Best Wishes,
Anshul
---
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
Anshul Dalal (4):
  mach-k3: use minimal MMU table for all k3
  mach-k3: add runtime configuration of MMU table
  mach-k3: add dynamic mmu fixups for SPL stage
  board: add call to k3_mem_map_init for all k3 boards

 arch/arm/mach-k3/arm64/arm64-mmu.c           | 182 ++++++++++++++++---
 arch/arm/mach-k3/common.c                    |  17 +-
 arch/arm/mach-k3/include/mach/k3-ddr.h       |   1 +
 arch/arm/mach-k3/r5/common.c                 |   5 +
 board/beagle/beagleplay/beagleplay.c         |   9 +-
 board/phytec/phycore_am62ax/phycore-am62ax.c |   9 +-
 board/phytec/phycore_am62x/phycore-am62x.c   |   3 +-
 board/phytec/phycore_am64x/phycore-am64x.c   |   3 +-
 board/siemens/iot2050/board.c                |   3 +-
 board/ti/common/k3-ddr.c                     |   9 +-
 board/toradex/verdin-am62/verdin-am62.c      |   3 +-
 11 files changed, 211 insertions(+), 33 deletions(-)

-- 
2.49.0

