Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9EBCCDB482
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 11:44:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EC9786F6C;
	Thu, 19 Oct 2023 13:44:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA4CF86F6D; Thu, 19 Oct 2023 13:44:43 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52B0586F67
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 13:44:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 39JBiOx7055393;
 Thu, 19 Oct 2023 19:44:24 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Thu, 19 Oct 2023 19:44:21 +0800
Date: Thu, 19 Oct 2023 19:41:24 +0800
From: Leo Liang <ycliang@andestech.com>
To: <trini@konsulko.com>
CC: <ycliang@andestech.com>, <rick@andestech.com>, <u-boot@lists.denx.de>
Subject: [PULL] u-boot-riscv/master
Message-ID: <ZTEV5KksRDvCHqkT@swlinux02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 39JBiOx7055393
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

The following changes since commit 9a0cf3993f71043ba08c315572c54622de42d447:

  Merge branch '2023-10-17-spl-test-some-load-methods' (2023-10-18 08:28:00 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-riscv.git 

for you to fetch changes up to bc5a50452bd42029d6587e1596b44ff235655e90:

  riscv: Add Zbb support for building U-Boot (2023-10-19 17:29:50 +0800)

CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/18215
----------------------------------------------------------------

+ riscv: Add Zbb support
+ riscv: Add preliminary RISC-V falcon mode support
+ riscv: Remove dram_init_banksize()
+ andes: rearrange PLICSW scheme
+ visionfive2: enable bootstage configs

----------------------------------------------------------------
Chanho Park (1):
      configs: visionfive2: enable bootstage configs

Heinrich Schuchardt (1):
      riscv: remove dram_init_banksize()

Mayuresh Chitale (1):
      riscv: binman: Fix compilation error

Randolph (8):
      riscv: andes: Rearrange Andes PLICSW to single-bit-per-hart strategy
      spl: riscv: opensbi: change the default os_type as varible
      riscv: kconfig: introduce SPL_LOAD_FIT_OPENSBI_OS_BOOT symbol
      riscv: dts: binman: add condition for opensbi os boot
      Makefile: delete file *.itb when make clean
      spl: riscv: add os type for next booting stage
      andes: config: add riscv falcon mode for ae350 platform
      riscv: spl: andes: Move the DTB in front of kernel

Yu Chien Peter Lin (1):
      riscv: Add Zbb support for building U-Boot

 Makefile                                |   2 +-
 arch/riscv/Kconfig                      |  99 +++++++++++++++++++++++++++++++
 arch/riscv/Makefile                     |   5 +-
 arch/riscv/cpu/generic/dram.c           |  16 -----
 arch/riscv/dts/binman.dtsi              |  38 ++++++++++--
 arch/riscv/include/asm/string.h         |  18 ++++++
 arch/riscv/lib/Makefile                 |   3 +
 arch/riscv/lib/andes_plicsw.c           |  24 ++++----
 arch/riscv/lib/strcmp_zbb.S             |  81 +++++++++++++++++++++++++
 arch/riscv/lib/strlen_zbb.S             | 101 ++++++++++++++++++++++++++++++++
 arch/riscv/lib/strncmp_zbb.S            |  94 +++++++++++++++++++++++++++++
 board/AndesTech/ae350/ae350.c           |  25 ++++++++
 common/spl/spl_fit.c                    |   3 +-
 common/spl/spl_opensbi.c                |  31 ++++++----
 configs/ae350_rv32_falcon_defconfig     |  60 +++++++++++++++++++
 configs/ae350_rv32_falcon_xip_defconfig |  61 +++++++++++++++++++
 configs/ae350_rv64_falcon_defconfig     |  60 +++++++++++++++++++
 configs/ae350_rv64_falcon_xip_defconfig |  61 +++++++++++++++++++
 configs/starfive_visionfive2_defconfig  |   2 +
 19 files changed, 738 insertions(+), 46 deletions(-)
 create mode 100644 arch/riscv/lib/strcmp_zbb.S
 create mode 100644 arch/riscv/lib/strlen_zbb.S
 create mode 100644 arch/riscv/lib/strncmp_zbb.S
 create mode 100644 configs/ae350_rv32_falcon_defconfig
 create mode 100644 configs/ae350_rv32_falcon_xip_defconfig
 create mode 100644 configs/ae350_rv64_falcon_defconfig
 create mode 100644 configs/ae350_rv64_falcon_xip_defconfig

 Best regards,
 Leo
