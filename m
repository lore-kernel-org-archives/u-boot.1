Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC4FC54E66
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 08:52:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACA4487CAC;
	Tue, 12 Mar 2024 09:52:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE6DE87DB0; Tue, 12 Mar 2024 09:52:17 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B72C8792D
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 09:52:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 42C8q23q017285;
 Tue, 12 Mar 2024 16:52:02 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Tue, 12 Mar 2024 16:51:58 +0800
Date: Tue, 12 Mar 2024 16:51:50 +0800
From: Leo Liang <ycliang@andestech.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <rick@andestech.com>, <ycliang@andestech.com>
Subject: [GIT PULL] u-boot-riscv/master
Message-ID: <ZfAXpj_WS-QxCHuC@swlinux02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 42C8q23q017285
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

The following changes since commit f3c979dd0053c082d2df170446923e7ce5edbc2d:

  Prepare v2024.04-rc4 (2024-03-11 13:11:46 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-riscv.git 

for you to fetch changes up to 544af8207c69829b1697f3aa5dd682a299a6dea4:

  board: starfive: maintainer: Add visionfive2 PCIe driver (2024-03-12 14:36:13 +0800)

CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/19910
----------------------------------------------------------------

* riscv: lib: improve extension detection
* riscv: sbi: fix display format and global variable storage
* sifive: fu740: reduce DDR speed
* board: starfive vf2: switch to standard boot and fix DTS

----------------------------------------------------------------
Bo Gan (1):
      riscv: dts: jh7110: Enable PLL node in SPL

Conor Dooley (1):
      riscv: cpu: improve multi-letter extension detection in supports_extension()

Heinrich Schuchardt (3):
      serial: move sbi_dbcn_available to .data section
      cmd: sbi: Correctly display unknown implementation IDs
      cmd: sbi: formatting PolarFire Hart Software Services version

Leon M. Busch-George (1):
      riscv: dts: jh7110: fix indentation

Minda Chen (2):
      board: starfive: Update maintainer of VisionFive v2 board
      board: starfive: maintainer: Add visionfive2 PCIe driver

Nam Cao (1):
      starfive: visionfive2: switch to standard boot

Thomas Perrot (1):
      riscv: sifive: fu740: reduce DDR speed from 1866MT/s to 1600MT/s

 arch/riscv/cpu/cpu.c                               | 22 ++++++++++++++++------
 arch/riscv/dts/fu740-c000-u-boot.dtsi              |  2 +-
 .../dts/jh7110-starfive-visionfive-2-u-boot.dtsi   |  2 +-
 arch/riscv/dts/jh7110-u-boot.dtsi                  |  4 ++++
 board/starfive/visionfive2/MAINTAINERS             |  3 ++-
 cmd/riscv/sbi.c                                    |  3 ++-
 configs/starfive_visionfive2_defconfig             |  2 +-
 drivers/serial/serial_sbi.c                        |  2 +-
 include/configs/starfive-visionfive2.h             | 14 +-------------
 9 files changed, 29 insertions(+), 25 deletions(-)

Best regards,
Leo
