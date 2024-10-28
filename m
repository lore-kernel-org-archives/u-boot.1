Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E7ED1039A
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 12:24:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 218DD88360;
	Mon, 28 Oct 2024 13:24:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 679CF8907E; Mon, 28 Oct 2024 13:24:31 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07AB987CF8
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:24:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 49SCOBYc028629
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Mon, 28 Oct 2024 20:24:11 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 20:24:12 +0800
Date: Mon, 28 Oct 2024 20:24:07 +0800
From: Leo Liang <ycliang@andestech.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <ycliang@andestech.com>, <rick@andestech.com>
Subject: [GIT PULL] u-boot-riscv/master
Message-ID: <Zx-CZxLR6dNGASwK@swlinux02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 49SCOBYc028629
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

The following changes since commit 3df6145db0ed3430a2af089db5a82372bea3f4d5:

  x86: Missed removal of CMD_BOOTEFI_HELLO_COMPILE (2024-10-27 20:11:36 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-riscv.git 

for you to fetch changes up to 9e859849e2caa17d730bc4507fd6ef3c7959d3b4:

  riscv: cache: Add CBO instructions (2024-10-28 18:56:54 +0800)

CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/23051
----------------------------------------------------------------
- risc-v: Add Zicbom support
- board: Support RVVM board
- DTS: device tree fixes
- configs: Enable some configs
----------------------------------------------------------------
E Shattow (2):
      riscv64: dts: starfive: Star64 ethernet0 phy delay values sync with upstream Linux
      riscv64: dts: starfive: Mars ethernet0 phy delay values sync with upstream Linux

Heinrich Schuchardt (3):
      cmd: sbi: Add FWFT, MPXY extensions
      riscv: add missing linefeed in error message
      configs: visionfive2: enable CONFIG_CMD_ERASEENV

LekKit (3):
      riscv: qemu: Enable booting from NVMe
      riscv: qemu: Enable EFI framebuffer
      riscv: qemu: Explicitly advertise RVVM support

Maksim Kiselev (2):
      gpio: dw: Add ngpios DT-property support
      configs: th1520_lpi4a: Enable CMD_GPIO, DM_GPIO and DWAPB_GPIO driver

Mayuresh Chitale (2):
      riscv: Add support for defining instructions
      riscv: cache: Add CBO instructions

 arch/riscv/Kconfig                     |  6 ++-
 arch/riscv/include/asm/insn-def.h      | 39 ++++++++++++++
 arch/riscv/include/asm/sbi.h           |  4 +-
 arch/riscv/lib/cache.c                 | 96 ++++++++++++++++++++++++++++++++++
 arch/riscv/lib/fdt_fixup.c             |  2 +-
 board/emulation/qemu-riscv/Kconfig     |  2 +
 board/starfive/visionfive2/spl.c       |  6 +--
 cmd/riscv/sbi.c                        |  4 +-
 configs/starfive_visionfive2_defconfig |  1 +
 configs/th1520_lpi4a_defconfig         |  4 +-
 drivers/gpio/dwapb_gpio.c              |  4 +-
 include/configs/qemu-riscv.h           |  1 +
 12 files changed, 159 insertions(+), 10 deletions(-)
 create mode 100644 arch/riscv/include/asm/insn-def.h

Best regards,
Leo
