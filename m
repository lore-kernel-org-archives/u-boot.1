Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A45EDE996
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 02:38:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C93288EBC;
	Tue, 10 Sep 2024 04:38:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB92688EDC; Tue, 10 Sep 2024 04:38:22 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A0ED88EB5
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 04:38:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 48A2c9o3045718
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Tue, 10 Sep 2024 10:38:09 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Sep
 2024 10:38:09 +0800
Date: Tue, 10 Sep 2024 10:38:06 +0800
From: Leo Liang <ycliang@andestech.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <ycliang@andestech.com>, <rick@andestech.com>
Subject: [PULL] u-boot-riscv/master
Message-ID: <Zt-xDgp2Yuwrek0z@swlinux02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 48A2c9o3045718
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

The following changes since commit 7b2d4ecd7f6593771dd3118c8bab525d727a91e0:

  Merge branch 'master-spi-fixes' of https://source.denx.de/u-boot/custodians/u-boot-sh (2024-09-09 13:54:10 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-riscv.git 

for you to fetch changes up to 1806fed0ce6b56365ecf6b84ce6d17aafd3af979:

  cmd: add rdcycle test to RISC-V exception command (2024-09-10 10:10:43 +0800)

CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/22292
----------------------------------------------------------------
- Add rdcycle to RISC-V exception command
- Some fixes and refactoring
----------------------------------------------------------------
Heinrich Schuchardt (7):
      clk: sifive: append missing \n to messages
      clk: sifive: avoid declaring static variables in includes
      board: fix compatible property Milk-V Mars CM
      riscv: CONFIG_SPL_FRAMEPOINTER must depend on CONFIG_SPL
      riscv: allow to enable SHOW_REGS in main U-Boot only
      riscv: show registers in crash dumps by default
      cmd: add rdcycle test to RISC-V exception command

Maxim Kochetkov (1):
      riscv: define find_{first,next}_zero_bit in asm/bitops.h

 arch/riscv/Kconfig                      | 14 ++++++++++++
 arch/riscv/include/asm/bitops.h         | 40 +++++++++++++++++++++++++++++++++
 arch/riscv/lib/interrupts.c             |  7 +++---
 board/starfive/visionfive2/spl.c        | 15 ++++++++++---
 cmd/riscv/exception.c                   | 15 +++++++++++--
 drivers/clk/analogbits/wrpll-cln28hpc.c |  6 ++---
 drivers/clk/sifive/fu540-prci.c         |  7 +++++-
 drivers/clk/sifive/fu540-prci.h         | 22 ------------------
 drivers/clk/sifive/fu740-prci.c         |  7 +++++-
 drivers/clk/sifive/fu740-prci.h         | 22 ------------------
 drivers/clk/sifive/sifive-prci.c        |  3 +--
 drivers/clk/sifive/sifive-prci.h        |  4 ++++
 12 files changed, 102 insertions(+), 60 deletions(-)
 delete mode 100644 drivers/clk/sifive/fu540-prci.h
 delete mode 100644 drivers/clk/sifive/fu740-prci.h

Best regards,
Leo
