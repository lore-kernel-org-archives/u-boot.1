Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DD5C83F33
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 03:31:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BAFE86538;
	Tue,  5 Sep 2023 05:31:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46FB286538; Tue,  5 Sep 2023 05:31:48 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3275A864F5
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 05:31:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3853VYcm099905;
 Tue, 5 Sep 2023 11:31:34 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Tue, 5 Sep 2023 11:31:33 +0800
Date: Tue, 5 Sep 2023 11:30:34 +0800
From: Leo Liang <ycliang@andestech.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <rick@andestech.com>, <ycliang@andestech.com>
Subject: [PULL] u-boot-riscv/master
Message-ID: <ZPag2qB1EH18MN8F@swlinux02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3853VYcm099905
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

The following changes since commit 493fd3363f6da6a784514657d689c7cda0f390d5:

  nokia_rx51: Remove platform (2023-09-04 21:14:32 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-riscv.git

for you to fetch changes up to dfe08374943c0e898fcfaf7327f69e0fb56b7d23:

  risc-v: implement DBCN based debug console (2023-09-05 10:53:55 +0800)

CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/17650
----------------------------------------------------------------

+ Implement OpenSBI DBCN extension for early debug console
+ Fixes for VisionFive2 board
      + Fix timer missing
      + Fix L2 LIM issue
      + Enable PCIE auto enumeration to support USB and NVMe by default
+ Set eth0 mac address properly
+ Add __noreturn attribute to spl_invoke_opensbi

----------------------------------------------------------------
Chanho Park (1):
      spl: add __noreturn attribute to spl_invoke_opensbi function

Heinrich Schuchardt (2):
      risc-v: implement DBCN write byte
      risc-v: implement DBCN based debug console

Seung-Woo Kim (1):
      eeprom: starfive: set eth0 mac address properly

Shengyu Qu (6):
      configs: starfive: Enable PCIE auto enum and NVME/USB stuff for Starfive Visionfive 2
      doc: board: starfive: Add more info about supported driver
      Kconfig: Add SPL_SYS_MALLOC_CLEAR_ON_INIT
      dlmalloc: Add support for SPL_SYS_MALLOC_CLEAR_ON_INIT
      riscv: cpu: jh7110: Imply SPL_SYS_MALLOC_CLEAR_ON_INIT
      configs: starfive: Disable SYS_MALLOC_CLEAR_ON_INIT by default

Torsten Duwe (2):
      riscv: allow riscv timer to be instantiated via device tree
      riscv: jh7110: enable riscv,timer in the device tree

 Kconfig                                            | 11 +++++++++
 arch/riscv/cpu/jh7110/Kconfig                      |  1 +
 arch/riscv/dts/jh7110.dtsi                         |  9 +++++++
 arch/riscv/include/asm/sbi.h                       |  1 +
 arch/riscv/lib/sbi.c                               | 16 +++++++++++++
 .../starfive/visionfive2/visionfive2-i2c-eeprom.c  |  2 +-
 common/dlmalloc.c                                  |  6 ++---
 common/spl/spl_opensbi.c                           |  7 +++---
 configs/starfive_visionfive2_defconfig             | 10 +++++++-
 doc/board/starfive/visionfive2.rst                 |  2 ++
 drivers/serial/Kconfig                             |  5 +++-
 drivers/serial/serial_sbi.c                        | 20 ++++++++++++++++
 drivers/timer/riscv_timer.c                        | 28 ++++++++++++++++++++--
 include/spl.h                                      |  2 +-
 14 files changed, 108 insertions(+), 12 deletions(-)

Best regards,
Leo
