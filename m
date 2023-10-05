Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E860E7C4F4
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 08:13:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CFD586EA3;
	Thu,  5 Oct 2023 10:13:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9437B86EC0; Thu,  5 Oct 2023 10:13:19 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86DB386C4B
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 10:13:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3958D3X6078472;
 Thu, 5 Oct 2023 16:13:03 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Thu, 5 Oct 2023 16:12:59 +0800
Date: Thu, 5 Oct 2023 16:10:55 +0800
From: Leo Liang <ycliang@andestech.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <rick@andestech.com>, <ycliang@andestech.com>
Subject: [PULL] u-boot-riscv/master
Message-ID: <ZR5vj5SgDa3RbDV5@swlinux02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3958D3X6078472
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

The following changes since commit 65b9b3462bec2966911658836983819ab4e4823e:

  Merge branch 'next_pinctrl_sync' of https://source.denx.de/u-boot/custodians/u-boot-sh (2023-10-02 15:19:02 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-riscv.git 

for you to fetch changes up to 7cfdacbe8020292845bd5eba63b576b8586c433c:

  configs: sifive: enable poweroff command on Unmatched (2023-10-04 18:23:59 +0800)

CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/18005

----------------------------------------------------------------

+ ae350: modify memory layout and target name
+ ae350: use generic RISC-V timer driver in S-mode
+ Support bootstage report for RISC-V
+ Support C extension exception command for RISC-V
+ Add Starfive timer support

----------------------------------------------------------------
Chanho Park (3):
      riscv: bootstage: correct bootstage_report guard
      riscv: timer: add timer_get_boot_us for BOOTSTAGE
      timer: riscv_aclint_timer: add timer_get_boot_us for BOOTSTAGE

Heinrich Schuchardt (4):
      cmd/exception: support RISC-V compressed instruction
      cmd/exception: test RISC-V 16 bit aligned instruction
      riscv: enable CONFIG_DEBUG_UART by default
      configs: sifive: enable poweroff command on Unmatched

Kuan Lim Lee (1):
      timer: starfive: Add Starfive timer support

Randolph (2):
      configs: andes: add vender prefix for target name
      configs: andes: rearrange SPL mode memory layout

Yu Chien Peter Lin (1):
      riscv: andesv5: Prefer using the generic RISC-V timer driver in S-mode

 arch/riscv/Kconfig                   |  5 +-
 arch/riscv/cpu/andesv5/Kconfig       |  3 +-
 arch/riscv/dts/Makefile              |  2 +-
 arch/riscv/lib/bootm.c               |  2 +-
 board/AndesTech/ae350/Kconfig        |  2 +-
 cmd/riscv/exception.c                | 34 +++++++++++--
 configs/ae350_rv32_defconfig         |  3 +-
 configs/ae350_rv32_spl_defconfig     | 10 ++--
 configs/ae350_rv32_spl_xip_defconfig |  7 +--
 configs/ae350_rv32_xip_defconfig     |  2 +-
 configs/ae350_rv64_defconfig         |  2 +-
 configs/ae350_rv64_spl_defconfig     | 11 +++--
 configs/ae350_rv64_spl_xip_defconfig |  8 +--
 configs/ae350_rv64_xip_defconfig     |  2 +-
 configs/sifive_unmatched_defconfig   |  1 +
 drivers/timer/Kconfig                | 16 +++++-
 drivers/timer/Makefile               |  3 +-
 drivers/timer/riscv_aclint_timer.c   | 23 +++++++++
 drivers/timer/riscv_timer.c          | 22 +++++++++
 drivers/timer/starfive-timer.c       | 94 ++++++++++++++++++++++++++++++++++++
 20 files changed, 223 insertions(+), 29 deletions(-)
 create mode 100644 drivers/timer/starfive-timer.c

Best regards,
Leo
