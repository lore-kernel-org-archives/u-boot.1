Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1A5D44D54
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 12:12:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 979C588FE5;
	Wed,  6 Nov 2024 13:12:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE3DA8901B; Wed,  6 Nov 2024 13:12:19 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95C0688FA8
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 13:12:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 4A6CC9aH007026
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Wed, 6 Nov 2024 20:12:09 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Nov
 2024 20:12:09 +0800
Date: Wed, 6 Nov 2024 20:12:06 +0800
From: Leo Liang <ycliang@andestech.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <ycliang@andestech.com>, <rick@andestech.com>
Subject: [GIT PULL] u-boot-riscv/master
Message-ID: <ZytdFmEgu6DgeRRf@swlinux02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 4A6CC9aH007026
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

The following changes since commit 56accc56b9aab87ef4809ccc588e1257969cd271:

  bios_emulator: fix first argument of pci_{read,write}_config_* function calls (2024-11-04 18:01:58 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-riscv.git 

for you to fetch changes up to d5f5e778183d5908caa2954b9438614252b806dd:

  riscv: Introduce configuration for 64bit version Microblaze V (2024-11-06 19:42:54 +0800)

CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/23239
----------------------------------------------------------------
- configs: visionfive2 defconfig: re-enable SPL_SYS_MMCSD_RAW_MODE
- driver: sifive ccache: enable TRUNKCLOCKGATE & REGIONCLOCKGATE
- board: support 64bit Microblaze V
----------------------------------------------------------------
Andreas Schwab (1):
      configs: visionfive2: re-enable SPL_SYS_MMCSD_RAW_MODE

Michal Simek (3):
      xilinx: mbv: Place DTB by default to DDR location
      xilinx: mbv: Align smode_defconfig with upstream QEMU
      riscv: Introduce configuration for 64bit version Microblaze V

Nick Hu (1):
      driver: sifive ccache: enable TRUNKCLOCKGATE and REGIONCLOCKGATE

 arch/riscv/dts/Makefile                |  1 +
 arch/riscv/dts/xilinx-mbv64.dts        | 99 ++++++++++++++++++++++++++++++++++
 board/xilinx/Kconfig                   |  2 +-
 configs/starfive_visionfive2_defconfig |  3 ++
 configs/xilinx_mbv32_smode_defconfig   | 12 ++---
 configs/xilinx_mbv64_defconfig         | 44 +++++++++++++++
 configs/xilinx_mbv64_smode_defconfig   | 48 +++++++++++++++++
 drivers/cache/cache-sifive-ccache.c    | 33 ++++++++++--
 8 files changed, 232 insertions(+), 10 deletions(-)
 create mode 100644 arch/riscv/dts/xilinx-mbv64.dts
 create mode 100644 configs/xilinx_mbv64_defconfig
 create mode 100644 configs/xilinx_mbv64_smode_defconfig

Best regards,
Leo
