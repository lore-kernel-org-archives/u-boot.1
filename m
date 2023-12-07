Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C90C4167B
	for <u-boot@archiver.kernel.org>; Thu,  7 Dec 2023 13:46:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30E2F874D9;
	Thu,  7 Dec 2023 14:46:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36CC7874F3; Thu,  7 Dec 2023 14:46:45 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50FFA8642A
 for <u-boot@lists.denx.de>; Thu,  7 Dec 2023 14:46:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3B7DkRFi074645;
 Thu, 7 Dec 2023 21:46:27 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Thu, 7 Dec 2023 21:46:25 +0800
Date: Thu, 7 Dec 2023 21:46:23 +0800
From: Leo Liang <ycliang@andestech.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <rick@andestech.com>, <ycliang@andestech.com>
Subject: [GIT PULL] u-boot-riscv/master
Message-ID: <ZXHMh3tIsPEZa3Vc@swlinux02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3B7DkRFi074645
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

The following changes since commit 2f0282922b2c458eea7f85c500a948a587437b63:

  Prepare v2024.01-rc4 (2023-12-04 13:46:56 -0500)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-riscv.git 

for you to fetch changes up to 94533cd9c15a60b74420e53a725fab54d38dd555:

  starfive: visionfive2: add device tree overlay support (2023-12-06 16:05:39 +0800)

CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/18812

----------------------------------------------------------------
- StarFive: Add StarFive watchdog driver
- VisionFive2: Support device tree overlay for VisionFive2 board
- Andes: Fix PLIC-SW setting
- RISC-V: Fix NVMe support by implying NVME_PCI for QEMU
- RISC-V: Fix binman for 64 bit format load address
----------------------------------------------------------------
Chanho Park (4):
      clk: starfive: jh7110: Add watchdog clocks
      watchdog: Add StarFive Watchdog driver
      riscv: dts: jh7110: Add watchdog device tree node
      configs: visionfive2: Enable watchdog driver

Heinrich Schuchardt (1):
      risc-v: qemu: imply NVME_PCI

John Clark (1):
      starfive: visionfive2: add device tree overlay support

Randolph (1):
      riscv: binman: fix the load field format

Yu Chien Peter Lin (1):
      riscv: andes: Fix enable register settings of PLICSW

 arch/riscv/dts/binman.dtsi             |  14 +-
 arch/riscv/dts/jh7110.dtsi             |  10 +
 arch/riscv/lib/andes_plicsw.c          |  33 ++--
 board/emulation/qemu-riscv/Kconfig     |   2 +-
 configs/starfive_visionfive2_defconfig |   5 +
 drivers/clk/starfive/clk-jh7110.c      |   9 +
 drivers/watchdog/Kconfig               |   7 +
 drivers/watchdog/Makefile              |   1 +
 drivers/watchdog/starfive_wdt.c        | 329 +++++++++++++++++++++++++++++++++
 include/configs/starfive-visionfive2.h |   1 +
 10 files changed, 382 insertions(+), 29 deletions(-)
 create mode 100644 drivers/watchdog/starfive_wdt.c

 Best regards,
 Leo
