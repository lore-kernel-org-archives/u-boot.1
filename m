Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4476E81DE3
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 11:26:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4090E86EC4;
	Fri,  6 Oct 2023 13:26:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21A0E86844; Fri,  6 Oct 2023 13:26:18 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF70A86ED0
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 13:26:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=randolph@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 396BQ64j058200;
 Fri, 6 Oct 2023 19:26:06 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0;
 Fri, 6 Oct 2023 19:26:04 +0800
From: Randolph <randolph@andestech.com>
To: <u-boot@lists.denx.de>
CC: <randolph.sklin@gmail.com>, <dylan@andestech.com>, <tim609@andestech.com>, 
 <peterlin@andestech.com>, Randolph <randolph@andestech.com>
Subject: [PATCH RESEND 0/7] riscv: spl: OpenSBI OS boot mode
Date: Fri, 6 Oct 2023 19:23:44 +0800
Message-ID: <20231006112351.2275090-1-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 396BQ64j058200
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

Introduce a shortcut boot mode for RISC-V. 

As we know, in ARM architecture has the Falcon mode to do the shortcut
boot to the Linux kernel. (by enabling CONFIG_SPL_OS_BOOT)
ARM Falcon mode boot flow would be as follows:
u-boot SPL -> Linux kernel

But for RISC-V, OpenSBI is required to allows the supervisor to execute
some privileged operations.
The RISC-V Normal boot flow as follows:
u-boot SPL -> OpenSBI -> u-boot proper -> Linux kernel

Quoting the same ideas as ARM's Falcon mode,
OpenSBI OS boot flow as follows:
u-boot SPL -> OpenSBI -> Linux kernel

An important part of OpenSBI OS boot mode is to prepare the device tree. 
A normal U-Boot does FDT fixups when booting Linux. 
For OpenSBI OS boot mode, Linux boots directly from SPL, 
skipping the normal U-Boot. 
The device tree has to be prepared in advance.
The device tree in memory is the one needed for OpenSBI OS boot mode.

The Linux kernel image will also need to be provided for the generation
of the FIT file.

Randolph (7):
  riscv: dts: Introduce SPL_LOAD_FIT_CONFIG symbol
  riscv: dts: add binman_linux.dtsi for opensbi os boot mode
  spl: riscv: opensbi: change the default os_type as varible
  riscv: dts: introduce SPL_LOAD_FIT_OPENSBI_OS_BOOT symbol
  spl: riscv: add os type for next booting stage
  andes: config: add riscv falcon mode for ae350 platform
  riscv: spl: andes: Move the DTB in front of kernel

 arch/riscv/Kconfig                      | 16 +++++
 arch/riscv/dts/ae350-u-boot.dtsi        |  1 +
 arch/riscv/dts/ae350_32.dts             |  1 -
 arch/riscv/dts/ae350_64.dts             |  1 -
 arch/riscv/dts/binman_linux.dtsi        | 79 +++++++++++++++++++++++++
 board/AndesTech/ae350/ae350.c           | 25 ++++++++
 common/spl/spl_fit.c                    |  4 ++
 common/spl/spl_opensbi.c                | 31 ++++++----
 configs/ae350_rv32_falcon_defconfig     | 60 +++++++++++++++++++
 configs/ae350_rv32_falcon_xip_defconfig | 61 +++++++++++++++++++
 configs/ae350_rv64_falcon_defconfig     | 60 +++++++++++++++++++
 configs/ae350_rv64_falcon_xip_defconfig | 61 +++++++++++++++++++
 12 files changed, 388 insertions(+), 12 deletions(-)
 create mode 100644 arch/riscv/dts/binman_linux.dtsi
 create mode 100644 configs/ae350_rv32_falcon_defconfig
 create mode 100644 configs/ae350_rv32_falcon_xip_defconfig
 create mode 100644 configs/ae350_rv64_falcon_defconfig
 create mode 100644 configs/ae350_rv64_falcon_xip_defconfig

-- 
2.34.1

