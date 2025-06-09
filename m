Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F3AC5B552
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 08:06:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E714282A36;
	Mon,  9 Jun 2025 10:06:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C52182A65; Mon,  9 Jun 2025 10:06:55 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4CB280E9A
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 10:06:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 55986fT9030179
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Mon, 9 Jun 2025 16:06:41 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Jun
 2025 16:06:41 +0800
Date: Mon, 9 Jun 2025 16:06:41 +0800
From: Leo Liang <ycliang@andestech.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <ycliang@andestech.com>, <rick@andestech.com>,
 <ziyao@disroot.org>
Subject: [v2 PULL] u-boot-riscv/next
Message-ID: <aEaWEeJ0WQPMJfGP@swlinux02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 55986fT9030179
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

The following changes since commit e96b6c0c18c29fba63a1ceb21dc29afb9d9b2910:

  Merge patch series "Remove as much arch/arm/dts/*.h as possible" (2025-06-06 13:54:42 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-riscv.git next

for you to fetch changes up to c89f2b10784f940ce8e177348efff5538e905b5f:

  MAINTAINERS: riscv: cpu: th1520: Assign myself as maintainer (2025-06-09 10:44:14 +0800)

CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/26569
----------------------------------------------------------------
- SoC: add SPL support for licheepi4a
- RISC-V: raise SPL_SYS_MALLOC_SIZE to 8 MiB
----------------------------------------------------------------
Heinrich Schuchardt (1):
      configs: raise SPL_SYS_MALLOC_SIZE to 8 MiB on RISC-V

Yao Zi (6):
      riscv: cpu: th1520: Build spl.c for SPL only
      riscv: cpu: th1520: Support cache enabling/disabling in M mode only
      riscv: dts: th1520: Prepare binman configuration for loading OpenSBI
      board: thead: licheepi4a: Run proper U-Boot in S-Mode
      doc: thead: lpi4a: Update for S-Mode proper U-Boot support
      MAINTAINERS: riscv: cpu: th1520: Assign myself as maintainer

 MAINTAINERS                             |   7 ++
 arch/riscv/cpu/th1520/Makefile          |   2 +-
 arch/riscv/cpu/th1520/cache.c           |   2 +
 arch/riscv/dts/thead-th1520-binman.dtsi |  32 +++++++-
 common/spl/Kconfig                      |   2 +-
 configs/starfive_visionfive2_defconfig  |   1 -
 configs/th1520_lpi4a_defconfig          |   2 +-
 configs/xilinx_mbv32_defconfig          |   1 -
 configs/xilinx_mbv32_smode_defconfig    |   1 -
 configs/xilinx_mbv64_defconfig          |   1 -
 configs/xilinx_mbv64_smode_defconfig    |   1 -
 doc/board/thead/lpi4a.rst               | 125 +++++++++-----------------------
 12 files changed, 76 insertions(+), 101 deletions(-)

 Best regards,
 Leo
