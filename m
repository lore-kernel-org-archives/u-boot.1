Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A9AC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 05:38:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4D038706B;
	Thu, 28 Dec 2023 06:38:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 883AF870B5; Thu, 28 Dec 2023 06:38:27 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 320BC87067
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 06:38:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3BS5cGpV047539;
 Thu, 28 Dec 2023 13:38:16 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Thu, 28 Dec 2023 13:38:14 +0800
Date: Thu, 28 Dec 2023 13:38:11 +0800
From: Leo Liang <ycliang@andestech.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <rick@andestech.com>, <ycliang@andestech.com>
Subject: [GIT PULL] u-boot-riscv/next
Message-ID: <ZY0Jwxaqw6bGOvBI@swlinux02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3BS5cGpV047539
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

The following changes since commit 4b151562bb8e54160adedbc6a1c0c749c00a2f84:

  bootmeth: pass size to efi_binary_run() (2023-12-22 10:36:50 -0500)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-riscv.git next

for you to fetch changes up to 9924d44dbcd47bd3664fa9f1f9f24044d83eaebf:

  andes: ae350: Enable MISC_INIT_R for ae350 platform (2023-12-27 17:29:11 +0800)

CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/19106
----------------------------------------------------------------
- Andes: Enable Andes CPU memboost and ECC feature by default 
- Sifive: Add private L2 cache driver
----------------------------------------------------------------
Leo Yu-Chi Liang (6):
      andes: csr.h: Clean up CSR definition
      andes: ae350: Implement cache switch via Kconfig
      andes: cpu: Enable memboost feature
      andes: cpu: Enable cache and TLB ECC support
      andes: ae350: Save cpu name to env
      andes: ae350: Enable MISC_INIT_R for ae350 platform

Michal Simek (1):
      riscv: Extend board compatible string with "qemu,mbv"

Zong Li (2):
      cache: add sifive private L2 cache driver
      riscv: cache: support cache enable in SPL stage

 arch/riscv/cpu/andesv5/cpu.c            | 33 ++++++++++++++++++-------
 arch/riscv/dts/xilinx-mbv32.dts         |  2 +-
 arch/riscv/include/asm/arch-andes/csr.h | 29 +++++++++++++---------
 arch/riscv/include/asm/csr.h            |  1 +
 arch/riscv/lib/sifive_cache.c           | 21 ++++++++++++++++
 board/AndesTech/ae350/ae350.c           | 26 ++++++++++++++++++-
 configs/ae350_rv32_defconfig            |  5 ++--
 configs/ae350_rv32_spl_defconfig        |  5 ++--
 configs/ae350_rv32_spl_xip_defconfig    |  5 ++--
 configs/ae350_rv32_xip_defconfig        |  5 ++--
 configs/ae350_rv64_defconfig            |  5 ++--
 configs/ae350_rv64_spl_defconfig        |  5 ++--
 configs/ae350_rv64_spl_xip_defconfig    |  5 ++--
 configs/ae350_rv64_xip_defconfig        |  5 ++--
 drivers/cache/Kconfig                   |  7 ++++++
 drivers/cache/Makefile                  |  1 +
 drivers/cache/cache-sifive-pl2.c        | 44 +++++++++++++++++++++++++++++++++
 17 files changed, 165 insertions(+), 39 deletions(-)
 create mode 100644 drivers/cache/cache-sifive-pl2.c

Best regards,
Leo
