Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D28C35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 10:55:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EAE480EEF;
	Tue, 25 Mar 2025 11:55:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E81F2810E8; Tue, 25 Mar 2025 11:55:52 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99EDC808AF
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 11:55:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 52PAtd3e093242
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Tue, 25 Mar 2025 18:55:39 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Mar
 2025 18:55:38 +0800
Date: Tue, 25 Mar 2025 18:55:35 +0800
From: Leo Liang <ycliang@andestech.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <rick@andestech.com>, <ycliang@andestech.com>
Subject: [GIT PULL] u-boot-riscv/next
Message-ID: <Z-KLp1zWkAXvvmRU@swlinux02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 52PAtd3e093242
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

The following changes since commit d574229880378081691dc06c430424015be0740c:

  Merge tag 'qcom-next-20250324' of https://gitlab.denx.de/u-boot/custodians/u-boot-snapdragon into next (2025-03-24 12:38:48 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-riscv.git next

for you to fetch changes up to 9c40d92305db53f71ae31431b99f73ced11f334e:

  Add reset config options for k1 (2025-03-25 16:34:50 +0800)

CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/25323
----------------------------------------------------------------
- board: k1: Add reset driver
- board: starfive: Simplify binman config
- Some modifications on DTS and configs
----------------------------------------------------------------
Heinrich Schuchardt (6):
      configs: SiFive Unmatched: add 'nvme scan' to preboot
      riscv: qemu: imply CONFIG_RNG_RISCV_ZKR
      riscv: dts: add OF_LIST handling to binman.dtsi
      riscv: dts: no default configuration for MULTI_DTB_FIT
      board: starfive: spl: strip off 'starfive/' prefix
      riscv: dts: starfive: remove duplicate itb entries

Huan Zhou (4):
      riscv: dt-binding: k1: Add reset driver binding definition
      riscv: reset: k1: Add reset driver
      riscv: dts: k1: add reset controller node in device tree
      Add reset config options for k1

Jimmy Ho (1):
      RISCV: config: Remove CFG_SYS_SDRAM_BASE

Junhui Liu (1):
      riscv: dts: spacemit: Update UART compatible for k1

Yao Zi (1):
      riscv: dts: cv18xx: Drop unused dummy clocks

 arch/riscv/cpu/k1/Kconfig                       |   1 +
 arch/riscv/dts/binman.dtsi                      |  10 +-
 arch/riscv/dts/cv18xx.dtsi                      |  14 -
 arch/riscv/dts/k1.dtsi                          |  35 +-
 arch/riscv/dts/starfive-visionfive2-binman.dtsi |  76 ----
 board/emulation/qemu-riscv/Kconfig              |   1 +
 board/starfive/visionfive2/spl.c                |   4 +
 configs/bananapi-f3_defconfig                   |   1 +
 configs/sifive_unmatched_defconfig              |   2 +-
 drivers/reset/Kconfig                           |   6 +
 drivers/reset/Makefile                          |   1 +
 drivers/reset/reset-spacemit-k1.c               | 548 ++++++++++++++++++++++++
 include/configs/sifive-unleashed.h              |   1 -
 include/configs/sifive-unmatched.h              |   1 -
 include/dt-bindings/reset/spacemit-k1-reset.h   | 118 +++++
 15 files changed, 713 insertions(+), 106 deletions(-)
 create mode 100644 drivers/reset/reset-spacemit-k1.c
 create mode 100644 include/dt-bindings/reset/spacemit-k1-reset.h

Best regards,
Leo
