Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0A0C3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 21:59:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0A11826B2;
	Thu,  3 Apr 2025 23:59:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uCWwmz6R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9D2B82786; Thu,  3 Apr 2025 23:59:28 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46BE18215D
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 23:59:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 533LxOU73796626
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Apr 2025 16:59:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1743717564;
 bh=7YWKbkuFF8fy7IyDSRiNdXtew4DUWCNmmRy9LekgxFg=;
 h=From:To:CC:Subject:Date;
 b=uCWwmz6Rw84OqS7JF0idwq0i8MQWlegVTjmBen8Bx8wTii7pXoK9Q+GGiwr6VKsR5
 X/a6rwjtoACdS662MXcvBv7iGjNT/Jonv6zz1Bc/y48WCSN0pK61ECCA5IDqMwusAR
 3Y+H7NOaEPxSDxAOq0x0n5+qVugDlf75poutD6z4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 533LxOGj057806
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 3 Apr 2025 16:59:24 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Apr 2025 16:59:24 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Apr 2025 16:59:24 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 533LxNa8089570;
 Thu, 3 Apr 2025 16:59:24 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>
Subject: [PATCH v3 00/10] Add falcon support for am62a, 62p and 62x
Date: Fri, 4 Apr 2025 03:28:57 +0530
Message-ID: <20250403215910.1292922-1-anshuld@ti.com>
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

This patch set adds support for falcon boot on AM62a, 62p and 62x by
bypassing A53 SPL and U-boot.

Existing Boot flow:
R5 SPL -> ATF -> A53 SPL -> U-Boot -> Linux Kernel

Updated flow:
R5 SPL -> ATF -> Linux Kernel

U-boot's falcon flow expects the jump from SPL to kernel to happen on
the same core which is not directly applicable for our heterogeneous
platforms since ATF, OPTEE and other non SPL binaries from tispl.bin
should be loaded before the kernel by the R5 SPL.

So we have to use a non std flow to bypass A53 SPL and U-Boot, we first
load the newly added tispl_falcon.bin instead of tispl.bin which lacks
u-boot-spl.bin (A53's SPL) and the corresponding fdt. This sets up dm,
tifs, optee and atf. Once loaded, we load the kernel and the dtb (with
fixups) at ATF's PRELOADED_BL33_BASE and K3_HW_CONFIG_BASE.

NOTE:
Since we're now using the SPL to load the kernel and kernel expects a
2MiB aligned load address, the existing PRELOADED_BL33_BASE has to be
changed for ATF to 0x80200000.

This patch depends on:

 * [PATCH v3] spl: return header size to spl_load in os boot [1]
 * [PATCH v2] config: falcon: move CFG_SYS_SPI_* to Kconfig [2]
 * [PATCH v6] spl: remove usage of CMD_(BOOTI|BOOTZ) from image parsing [3]

[1]: https://lore.kernel.org/u-boot/20250311093546.3371193-1-anshuld@ti.com/
[2]: https://lore.kernel.org/u-boot/20250311044414.3155688-1-anshuld@ti.com/
[3]: https://lore.kernel.org/u-boot/20250403215522.1284502-1-anshuld@ti.com/

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
Changes in v3:
 * Make tifs load and entry address consistent with tispl for am62a and 62p
 * Update loadables order to be same as tispl.bin
 * Use rootfs for boot instead of boot partition
 * Disable SPL_HAS_BOOTZ to save space
 * Add default dtbs for each board in Kconfig
 * Fix fdt totalsize in the header before applying fixups
 * Update Makefile to clean tispl_falcon.bin on `make clean`
v2: https://lore.kernel.org/u-boot/20250311095758.3383047-1-anshuld@ti.com/
Changes in v2:
 * Move to CONFIG_SYS_SPI_* as per [2]
 * Remove the need for CMD_BOOTI as per [3]
v1: https://lore.kernel.org/u-boot/20250307075541.2571104-1-anshuld@ti.com/
---

Anshul Dalal (10):
  spl: Kconfig: allow K3 devices to use falcon mode
  mach-k3: fix reading size and addr from fdt on R5
  arm: dts: am62a: allow booting from eMMC
  arch: arm: k3-binman: add fit for falcon boot
  mach-k3: add eMMC FS boot support for am62[ap]
  mach-k3: sysfw-loader: update img_hdr for falcon
  config: add falcon boot config fragment for am62x
  board: ti: add default dtb for am62[axp] in falcon mode
  mach-k3: common: add falcon support for 62[axp]
  Makefile: update tispl regex to also clean falcon spl

 Makefile                              |   2 +-
 arch/arm/dts/k3-am625-sk-binman.dtsi  |  64 +++++++++++++++
 arch/arm/dts/k3-am62a-sk-binman.dtsi  |  64 +++++++++++++++
 arch/arm/dts/k3-am62a7-sk-u-boot.dtsi |   4 +
 arch/arm/dts/k3-am62p-sk-binman.dtsi  |  51 ++++++++++++
 arch/arm/dts/k3-binman.dtsi           |  53 +++++++++++++
 arch/arm/mach-k3/am62ax/am62a7_init.c |   4 +
 arch/arm/mach-k3/am62px/am62p5_init.c |   4 +
 arch/arm/mach-k3/common.c             | 107 ++++++++++++++++++++++++++
 arch/arm/mach-k3/common_fdt.c         |   4 +-
 arch/arm/mach-k3/r5/sysfw-loader.c    |   6 +-
 board/ti/am62ax/Kconfig               |   3 +
 board/ti/am62px/Kconfig               |   3 +
 board/ti/am62x/Kconfig                |   3 +
 common/spl/Kconfig                    |   3 +-
 configs/am62x_r5_falcon.config        |  42 ++++++++++
 16 files changed, 413 insertions(+), 4 deletions(-)
 create mode 100644 configs/am62x_r5_falcon.config

-- 
2.49.0

