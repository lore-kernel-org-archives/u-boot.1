Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D53C369B1
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 07:46:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B01782CD6;
	Wed, 16 Apr 2025 09:46:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xLPcTDHe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 798DB82CEB; Wed, 16 Apr 2025 09:46:35 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D207282CA2
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 09:46:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53G7kVOZ2706210
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Apr 2025 02:46:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744789591;
 bh=wJQLd2n0M2KesVDP5LQduOoNgMBWHAclVtK0qnRSixI=;
 h=From:To:CC:Subject:Date;
 b=xLPcTDHeqELmKU0d98hxVykseAa5dePDb85061NWonkELmfemFoqJWcYpOM+K+8Ih
 NlY6DCbYs/dX+ODnHWy7uOzrAOahgct9RpCoYkcyStMpmtzyhAoKVpD9ItcuPhMKfn
 jKROgIoloH9819+P14u+T+uF/wWVTmrMzGPJFYs0=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53G7kV2u093110
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Apr 2025 02:46:31 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Apr 2025 02:46:30 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Apr 2025 02:46:30 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53G7kTMd069740;
 Wed, 16 Apr 2025 02:46:30 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>
Subject: [PATCH v4 0/8] Add falcon support for am62a, 62p and 62x
Date: Wed, 16 Apr 2025 13:15:06 +0530
Message-ID: <20250416074515.1452854-1-anshuld@ti.com>
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

 * [PATCH v1] k3: migrate SPL_TEXT_BASE to new address [1]

[1]: https://lore.kernel.org/u-boot/20250416073058.1441001-1-anshuld@ti.com/

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
Changes in v4:
 * Move emmc boot fixes to saperate patch
 * Update load address for kernel to 0x82200000
 * Add jump_stub config
v3: https://lore.kernel.org/u-boot/20250403215910.1292922-1-anshuld@ti.com/
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

Anshul Dalal (8):
  spl: Kconfig: allow K3 devices to use falcon mode
  mach-k3: fix reading size and addr from fdt on R5
  arch: arm: k3-binman: add fit for falcon boot
  mach-k3: sysfw-loader: update img_hdr for falcon
  config: add falcon boot config fragment for am62x
  board: ti: add default dtb for am62[axp] in falcon mode
  mach-k3: common: add falcon support for 62[axp]
  Makefile: update tispl regex to also clean falcon spl

 Makefile                             |   2 +-
 arch/arm/dts/k3-am625-sk-binman.dtsi |  64 ++++++++++++++++
 arch/arm/dts/k3-am62a-sk-binman.dtsi |  64 ++++++++++++++++
 arch/arm/dts/k3-am62p-sk-binman.dtsi |  51 +++++++++++++
 arch/arm/dts/k3-binman.dtsi          |  69 +++++++++++++++++
 arch/arm/mach-k3/common.c            | 107 +++++++++++++++++++++++++++
 arch/arm/mach-k3/common_fdt.c        |   4 +-
 arch/arm/mach-k3/r5/sysfw-loader.c   |   6 +-
 board/ti/am62ax/Kconfig              |   3 +
 board/ti/am62px/Kconfig              |   3 +
 board/ti/am62x/Kconfig               |   3 +
 common/spl/Kconfig                   |   3 +-
 configs/am62x_r5_falcon.config       |  42 +++++++++++
 13 files changed, 417 insertions(+), 4 deletions(-)
 create mode 100644 configs/am62x_r5_falcon.config

-- 
2.49.0

