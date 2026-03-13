Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDE1106FD66
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 02:06:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50F3184166;
	Fri, 13 Mar 2026 03:06:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E615F84167; Fri, 13 Mar 2026 03:06:47 +0100 (CET)
Received: from Atcsqr.andestech.com (unknown [60.248.187.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBB5A84150
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 03:06:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 62D26T2F011797;
 Fri, 13 Mar 2026 10:06:29 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Mar
 2026 10:06:29 +0800
Date: Fri, 13 Mar 2026 10:06:24 +0800
From: Leo Liang <ycliang@andestech.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <rick@andestech.com>, <ycliang@andestech.com>,
 <heinrich.schuchardt@canonical.com>, <nick.hu@sifive.com>,
 <jimmy.ho@sifive.com>, <schwab@suse.de>
Subject: [GIT,PULL] u-boot-riscv/next
Message-ID: <abNxIFSAFWMgeEEf@swlinux02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 62D26T2F011797
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

The following changes since commit 8bc2a5196c1c0bb5dbdaca073323da0015a0de37:

  arm: k3: Kconfig: Enable fTPM and RPMB support (2026-03-10 12:35:18 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-riscv.git next

for you to fetch changes up to 12a9c83cba29b0acf3d41fb40de6416c473c0ba3:

  riscv: mpfs: SIFIVE_CLINT and SPL_SIFIVE_CLINT don't exist (2026-03-13 02:57:58 +0800)

CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/29497
----------------------------------------------------------------
- sifive: switch to OF_UPSTREAM
- driver: cache: Remove SiFive PL2 driver
- riscv: fixes for non-existent CONFIG
----------------------------------------------------------------
Andreas Schwab (1):
      sifive: switch to OF_UPSTREAM

Heinrich Schuchardt (3):
      riscv: don't imply non-existent CONFIG_IP_DYN
      openpiton: imply CONFIG_SPL_CPU
      riscv: mpfs: SIFIVE_CLINT and SPL_SIFIVE_CLINT don't exist

Nick Hu (1):
      driver: cache: Remove SiFive PL2 driver

 arch/riscv/cpu/fu540/Kconfig                  |   1 +
 arch/riscv/cpu/fu740/Kconfig                  |   1 +
 arch/riscv/cpu/mpfs/Kconfig                   |   2 -
 arch/riscv/dts/Makefile                       |   2 -
 arch/riscv/dts/fu540-c000-u-boot.dtsi         |  16 +-
 arch/riscv/dts/fu540-c000.dtsi                | 286 ----------------------
 arch/riscv/dts/fu740-c000.dtsi                | 326 --------------------------
 arch/riscv/dts/hifive-unleashed-a00.dts       | 105 ---------
 arch/riscv/dts/hifive-unmatched-a00.dts       | 246 -------------------
 arch/riscv/lib/sifive_cache.c                 |   3 -
 board/microchip/mpfs_generic/Kconfig          |   1 -
 board/openpiton/riscv64/Kconfig               |   2 +-
 board/sifive/unleashed/Kconfig                |   1 -
 board/sifive/unmatched/Kconfig                |   1 -
 board/starfive/visionfive2/Kconfig            |   1 -
 configs/sifive_unleashed_defconfig            |   2 +-
 configs/sifive_unmatched_defconfig            |   2 +-
 drivers/cache/Kconfig                         |   6 -
 drivers/cache/Makefile                        |   1 -
 drivers/clk/sifive/fu540-prci.c               |   8 +-
 include/dt-bindings/clock/sifive-fu540-prci.h |  18 --
 21 files changed, 17 insertions(+), 1014 deletions(-)
 delete mode 100644 arch/riscv/dts/fu540-c000.dtsi
 delete mode 100644 arch/riscv/dts/fu740-c000.dtsi
 delete mode 100644 arch/riscv/dts/hifive-unleashed-a00.dts
 delete mode 100644 arch/riscv/dts/hifive-unmatched-a00.dts
 delete mode 100644 include/dt-bindings/clock/sifive-fu540-prci.h

 Best regards,
 Leo
