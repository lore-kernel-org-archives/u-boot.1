Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E4E8C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 11:45:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B812987DFF;
	Mon, 18 Dec 2023 12:45:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9D7987C9E; Mon, 18 Dec 2023 12:45:10 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6856387032
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 12:45:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3BIBiqLY058864;
 Mon, 18 Dec 2023 19:44:52 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Mon, 18 Dec 2023 19:44:47 +0800
Date: Mon, 18 Dec 2023 19:44:15 +0800
From: Leo Liang <ycliang@andestech.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <rick@andestech.com>, <ycliang@andestech.com>
Subject: [GIT PULL] u-boot-riscv/next
Message-ID: <ZYAwj034fNBg1HOk@swlinux02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3BIBiqLY058864
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

The following changes since commit fdefb4e194c65777fa11479119adaa71651f41d4:

  Merge tag 'efi-next-20231217' of https://source.denx.de/u-boot/custodians/u-boot-efi into next (2023-12-17 09:11:06 -0500)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-riscv.git next

for you to fetch changes up to 44a792c99498f5a9d3526019779d66585978c491:

  riscv: sifive: unmatched: migrate to text environment (2023-12-18 11:09:01 +0800)

CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/18996
----------------------------------------------------------------
- VisionFive2: Enable CONFIG_SYSRESET
- StarFive: Modify starfive timer driver
- AMD/Xilinx: Add MicroBlaze V support
- Unmatched: Migrate to text environment
----------------------------------------------------------------
Jaehoon Chung (2):
      riscv: dts: jh7110: Add a gpio-restart node
      configs: visionfive2: Enable CONFIG_SYSRESET config

Kuan Lim Lee (1):
      timer: starfive: Add Starfive timer support

Michal Simek (1):
      riscv: Add support for AMD/Xilinx MicroBlaze V

Yong-Xuan Wang (1):
      riscv: sifive: unmatched: migrate to text environment

 arch/riscv/Kconfig                               |   4 +
 arch/riscv/dts/Makefile                          |   2 +
 arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi |   5 ++
 arch/riscv/dts/xilinx-mbv32.dts                  | 106 +++++++++++++++++++++++
 board/sifive/unmatched/unmatched.env             |  19 ++++
 board/xilinx/Kconfig                             |   3 +-
 board/xilinx/common/board.c                      |   5 ++
 board/xilinx/mbv/Kconfig                         |  28 ++++++
 board/xilinx/mbv/MAINTAINERS                     |   7 ++
 board/xilinx/mbv/Makefile                        |   5 ++
 board/xilinx/mbv/board.c                         |  11 +++
 configs/sifive_unmatched_defconfig               |   2 +-
 configs/starfive_visionfive2_defconfig           |   1 +
 configs/xilinx_mbv32_defconfig                   |  30 +++++++
 configs/xilinx_mbv32_smode_defconfig             |  32 +++++++
 drivers/timer/starfive-timer.c                   |  16 ++--
 include/configs/sifive-unmatched.h               |  37 --------
 include/configs/xilinx_mbv.h                     |   6 ++
 18 files changed, 273 insertions(+), 46 deletions(-)
 create mode 100644 arch/riscv/dts/xilinx-mbv32.dts
 create mode 100644 board/sifive/unmatched/unmatched.env
 create mode 100644 board/xilinx/mbv/Kconfig
 create mode 100644 board/xilinx/mbv/MAINTAINERS
 create mode 100644 board/xilinx/mbv/Makefile
 create mode 100644 board/xilinx/mbv/board.c
 create mode 100644 configs/xilinx_mbv32_defconfig
 create mode 100644 configs/xilinx_mbv32_smode_defconfig
 create mode 100644 include/configs/xilinx_mbv.h

Best regards,
Leo
