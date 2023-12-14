Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D63C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 02:38:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20EF587863;
	Thu, 14 Dec 2023 03:38:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5474C87863; Thu, 14 Dec 2023 03:38:29 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE67087858
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 03:38:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3BE2cFXv010042;
 Thu, 14 Dec 2023 10:38:15 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Thu, 14 Dec 2023 10:38:12 +0800
Date: Thu, 14 Dec 2023 10:38:07 +0800
From: Leo Yu-Chi =?utf-8?B?TGlhbmco5qKB6IKy6b2KKQ==?= <ycliang@andestech.com>
To: "trini@konsulko.com" <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Rick Jian-Zhi
 =?utf-8?B?Q2hlbijpmbPlu7rlv5cp?= <rick@andestech.com>, Leo Yu-Chi
 =?utf-8?B?TGlhbmco5qKB6IKy6b2KKQ==?= <ycliang@andestech.com>
Subject: [GIT PULL] u-boot-riscv/master
Message-ID: <KL1PR03MB6059E8E8F10CAE683A330D1FA58DA@KL1PR03MB6059.apcprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Thread-Topic: [GIT PULL] u-boot-riscv/master
Thread-Index: AQHaLZ5pXAqhkrwn90aRO1POGe26RQ==
Content-Language: en-US
x-ms-exchange-imapappendstamp: KL1PR0302MB5265.apcprd03.prod.outlook.com
 (15.20.7113.000)
Content-ID: <D0450E86D33A17408082A13F344749DF@andesone.onmicrosoft.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3BE2cFXv010042
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

The following changes since commit 20d0464300c25db673cfb5e4539aa3767606d151:

  Merge tag 'u-boot-imx-20231212' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2023-12-12 16:33:57 -0500)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-riscv.git 

for you to fetch changes up to 8c785ddb7ae8d675faf558c81a29938cb0ec2b35:

  riscv: sifive: unmatched: migrate to text environment (2023-12-13 16:19:43 +0800)

CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/18889
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

