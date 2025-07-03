Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314C5C77B7C
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 14:10:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F6A382063;
	Thu,  3 Jul 2025 16:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6219E8206E; Thu,  3 Jul 2025 16:10:12 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7526080E9A
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 16:10:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 563E9WJR082563
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Thu, 3 Jul 2025 22:09:32 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Jul
 2025 22:09:32 +0800
Date: Thu, 3 Jul 2025 22:09:24 +0800
From: Leo Liang <ycliang@andestech.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <rick@andestech.com>, <ziyao@disroot.org>,
 <conor@kernel.org>, <ben.dooks@codethink.co.uk>
Subject: [GIT PULL] u-boot-riscv/next
Message-ID: <aGaPFKZQNGrEbCnV@swlinux02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 563E9WJR082563
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

Hi Tom,

The following changes since commit c405bab7661dd60420e97a4edeb3162e9d7e02c5:

  Merge tag 'mmc-next-2025-07-02' of https://source.denx.de/u-boot/custodians/u-boot-mmc into next (2025-07-02 07:51:57 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-riscv.git next

for you to fetch changes up to f62062a64daeb3f3b148372d0afae3821aff16de:

  cache: Update dependency for ANDES_L2_CACHE (2025-07-03 18:11:06 +0800)

CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/26936
----------------------------------------------------------------
- RISC-V: Add big-endian build support
- Board: aclint_ipi: Support T-Head C900 CLINT
- Board: mpfs_icicle: Implement board_fdt_blob_setup()/board_fit_config_name_match()
- Driver: pinctrl: Port pin controller driver for T-Head TH1520 SoC
- Driver: cache: Update dependency for ANDES_L2_CACHE
----------------------------------------------------------------
Ben Dooks (2):
      riscv: add build support for big-endian
      riscv: byteorder: add test for big-endian

Conor Dooley (1):
      board: mpfs_icicle: implement board_fdt_blob_setup()/board_fit_config_name_match()

Tom Rini (1):
      cache: Update dependency for ANDES_L2_CACHE

Yao Zi (8):
      riscv: aclint_ipi: Support T-Head C900 CLINT
      riscv: cpu: th1520: Setup CPU feature CSRs in harts_early_init
      riscv: cpu: th1520: Add a routine to bring up secondary cores
      riscv: dts: th1520: Preserve CLINT node for SPL
      board: thead: licheepi4a: Bring up secondary cores in SPL
      pinctrl: Port pin controller driver for T-Head TH1520 SoC
      riscv: dts: th1520: Add pin controllers
      riscv: cpu: th1520: Enable pinctrl by default

 MAINTAINERS                               |   1 +
 arch/riscv/config.mk                      |  18 +-
 arch/riscv/cpu/th1520/Kconfig             |   1 +
 arch/riscv/cpu/th1520/cpu.c               |  29 +-
 arch/riscv/cpu/th1520/spl.c               |  83 ++++
 arch/riscv/dts/th1520.dtsi                |  29 ++
 arch/riscv/include/asm/arch-th1520/cpu.h  |   1 +
 arch/riscv/include/asm/byteorder.h        |   2 +-
 arch/riscv/lib/aclint_ipi.c               |   5 +
 board/microchip/mpfs_icicle/mpfs_icicle.c |  63 +++
 board/thead/th1520_lpi4a/spl.c            |   3 +
 configs/th1520_lpi4a_defconfig            |   1 +
 drivers/cache/Kconfig                     |   1 +
 drivers/pinctrl/Kconfig                   |   8 +
 drivers/pinctrl/Makefile                  |   1 +
 drivers/pinctrl/pinctrl-th1520.c          | 700 ++++++++++++++++++++++++++++++
 16 files changed, 940 insertions(+), 6 deletions(-)
 create mode 100644 drivers/pinctrl/pinctrl-th1520.c

Best regards,
Leo
