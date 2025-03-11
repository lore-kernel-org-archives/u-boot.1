Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FC8C282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 09:58:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D90181335;
	Tue, 11 Mar 2025 10:58:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ly4YbLlp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFDFA8141D; Tue, 11 Mar 2025 10:58:13 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F868807D7
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 10:58:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52B9w87Q1157524
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 11 Mar 2025 04:58:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741687088;
 bh=N7aMEWbqzQbISPy6Oz9qq/rfyv7mbTwJJv3OG0Dc2y8=;
 h=From:To:CC:Subject:Date;
 b=Ly4YbLlpZZKk9ZgSRarPFFu5kz2nPDjRZUPiCWxt0plqqQWgsibOXYILr1HjiU3Tr
 QqUqZNH5wXyIvzrSqBaqtXPgQq1IGnLAY3P/JuThbNhPZcKjcd88mxTGc40HNYIfpV
 9lnhL1dWuVRBZOtNo2tYdZ73K3STaIk8c3999d4M=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52B9w8o3077741;
 Tue, 11 Mar 2025 04:58:08 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Mar 2025 04:58:08 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Mar 2025 04:58:08 -0500
Received: from localhost (a0543016.dhcp.ti.com [172.24.227.225])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52B9w7AI040634;
 Tue, 11 Mar 2025 04:58:08 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>
Subject: [PATCH v2 0/8] Add falcon support for am62a, 62p and 62x
Date: Tue, 11 Mar 2025 15:27:49 +0530
Message-ID: <20250311095758.3383047-1-anshuld@ti.com>
X-Mailer: git-send-email 2.43.0
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
 * [PATCH v1] spl: remove usage of CMD_(BOOTI|BOOTZ) from image parsing [3]

[1]: https://lore.kernel.org/u-boot/20250311093546.3371193-1-anshuld@ti.com/
[2]: https://lore.kernel.org/u-boot/20250311044414.3155688-1-anshuld@ti.com/
[3]: https://lore.kernel.org/u-boot/20250311093709.3372104-1-anshuld@ti.com/

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
Changes in v2:
 * Move to CONFIG_SYS_SPI_* as per [2]
 * Remove the need for CMD_BOOTI as per [3]
v1: https://lore.kernel.org/u-boot/20250307075541.2571104-1-anshuld@ti.com/
---
Anshul Dalal (8):
  spl: Kconfig: allow K3 devices to use falcon mode
  mach-k3: fix reading size and addr from fdt on R5
  arm: dts: am62a: allow booting from eMMC
  arch: arm: k3-binman: add fit for falcon boot
  mach-k3: add eMMC FS boot support for am62[ap]
  mach-k3: sysfw-loader: update img_hdr for falcon
  config: add falcon boot config fragment for am62x
  mach-k3: common: add falcon support for 62[axp]

 arch/arm/dts/k3-am625-sk-binman.dtsi  |  64 ++++++++++++++++
 arch/arm/dts/k3-am62a-sk-binman.dtsi  |  64 ++++++++++++++++
 arch/arm/dts/k3-am62a7-sk-u-boot.dtsi |   4 +
 arch/arm/dts/k3-am62p-sk-binman.dtsi  |  51 +++++++++++++
 arch/arm/dts/k3-binman.dtsi           |  53 +++++++++++++
 arch/arm/mach-k3/am62ax/am62a7_init.c |   4 +
 arch/arm/mach-k3/am62px/am62p5_init.c |   4 +
 arch/arm/mach-k3/common.c             | 105 ++++++++++++++++++++++++++
 arch/arm/mach-k3/common_fdt.c         |   4 +-
 arch/arm/mach-k3/r5/sysfw-loader.c    |   6 +-
 common/spl/Kconfig                    |   3 +-
 configs/am62x_r5_falcon.config        |  36 +++++++++
 12 files changed, 395 insertions(+), 3 deletions(-)
 create mode 100644 configs/am62x_r5_falcon.config

-- 
2.43.0

