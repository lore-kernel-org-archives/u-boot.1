Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6819FC28B20
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 05:40:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97C4281FDE;
	Wed,  2 Apr 2025 07:40:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5934B81F0D; Wed,  2 Apr 2025 07:40:06 +0200 (CEST)
Received: from inet11.abb.com (inet11.abb.com [138.225.1.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E06F682149
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 07:39:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bernhard.messerklinger@br-automation.com
Received: from brsmtp01.br-automation.co.at ([10.43.60.20])
 by inet11.abb.com (8.15.2/8.14.7) with ESMTPS id 5325d4tE3445461
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 2 Apr 2025 07:39:04 +0200
Received: from extmail.br-automation.com ([192.168.112.26])
 by brsmtp01.br-automation.co.at (HCL Domino Release 14.0FP3 HF8)
 with ESMTP id 2025040207390482-82127 ;
 Wed, 2 Apr 2025 07:39:04 +0200 
Received: from ATEGGE3725.br-automation.co.at ([10.43.64.28])
 by extmail.br-automation.com (HCL Domino Build V1202_05192022)
 with ESMTP id 2025040207390502-28498 ;
 Wed, 2 Apr 2025 07:39:05 +0200 
From: "Bernhard Messerklinger" <bernhard.messerklinger@br-automation.com>
To: u-boot@lists.denx.de
Cc: "Bernhard Messerklinger" <bernhard.messerklinger@br-automation.com>,
 "Adam Ford" <aford173@gmail.com>,
 "Andre Przywara" <andre.przywara@arm.com>,
 "Fabio Estevam" <festevam@denx.de>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Kever Yang" <kever.yang@rock-chips.com>,
 "Marek Vasut" <marek.vasut+renesas@mailbox.org>,
 "Michal Simek" <michal.simek@amd.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Oliver Gaskell" <Oliver.Gaskell@analog.com>,
 "Prasad Kummari" <prasad.kummari@amd.com>,
 "Simon Glass" <sjg@chromium.org>, "Sumit Garg" <sumit.garg@kernel.org>,
 "Tom Rini" <trini@konsulko.com>, "Tony Dinh" <mibodhi@gmail.com>,
 "Wolfgang Wallner" <wolfgang.wallner@br-automation.com>
Subject: [PATCH v3 0/4] Add support for BR Xilinx Zynq boards in mainline
 U-Boot.
Date: Wed, 2 Apr 2025 07:38:31 +0200
Message-ID: <20250402053901.8149-1-bernhard.messerklinger@br-automation.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on BRSMTPINTERN2/InternSMTP(Build
 V1202_05192022|May 19, 2022) at 04/02/2025 07:39:05 AM,
 Serialize by Router on BRSMTPINTERN2/InternSMTP(Build V1202_05192022|May 19,
 2022) at 04/02/2025 07:39:05 AM,
 Itemize by SMTP Server on BRSMTP01/Eggelsberg/AT/B&R(Release 14.0FP3
 HF8|December 13, 2024) at 04/02/2025 07:39:04 AM,
 Serialize by Router on BRSMTP01/Eggelsberg/AT/B&R(Release 14.0FP3 HF8|December
 13, 2024) at 04/02/2025 07:39:08 AM,
 Serialize complete at 04/02/2025 07:39:08 AM
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
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



Changes in v3:
- Split spi=5Fflash and qspi controller node in device tree for the usage
of bootph-all
- Merge binman descriptions into one zynq-binman-brcp1
- Add links instead of manually including u-boot.dtsi files
- Remove empty MAC addresses nodes from the device tree
- Seperate B&R Zynq device trees in the devicetree Makefile

Changes in v2:
- Move BR=5FRESETC=5FI2CBUS to Kconfig
- Remove all unnecessary device-tree entries
- Reviewed led names (no pattern restriction found)
- Fix maintainers file
- Cleanup of code
- Move preboot variable to env file

Bernhard Messerklinger (4):
  board/BuR/common: use strlcpy instead of strncpy
  board/BuR/common: add parameter for reset controller I2C bus selection
  board/BuR/common: split br=5Fresetc=5Fbmode function
  board/BuR/zynq: initial commit

 arch/arm/dts/Makefile                         |   7 +
 arch/arm/dts/zynq-binman-brcp1.dtsi           | 102 +++++++
 arch/arm/dts/zynq-brcp1.dtsi                  | 131 +++++++++
 arch/arm/dts/zynq-brcp150-u-boot.dtsi         |  34 +++
 arch/arm/dts/zynq-brcp150.dts                 | 173 +++++++++++
 arch/arm/dts/zynq-brcp170-u-boot.dtsi         |  26 ++
 arch/arm/dts/zynq-brcp170.dts                 | 139 +++++++++
 arch/arm/dts/zynq-brcp1=5F1r-u-boot.dtsi        |  30 ++
 arch/arm/dts/zynq-brcp1=5F1r.dts                |  28 ++
 arch/arm/dts/zynq-brcp1=5F1r=5Fswitch-u-boot.dtsi |   1 +
 arch/arm/dts/zynq-brcp1=5F1r=5Fswitch.dts         |  30 ++
 arch/arm/dts/zynq-brcp1=5F2r-u-boot.dtsi        |   1 +
 arch/arm/dts/zynq-brcp1=5F2r.dts                |  21 ++
 arch/arm/dts/zynq-brsmarc2-u-boot.dtsi        |  30 ++
 arch/arm/dts/zynq-brsmarc2.dts                | 157 ++++++++++
 arch/arm/mach-zynq/Kconfig                    |   1 +
 board/BuR/common/Kconfig                      |   8 +
 board/BuR/common/br=5Fresetc.c                  | 139 +++++----
 board/BuR/common/br=5Fresetc.h                  |   1 +
 board/BuR/common/common.c                     |   2 +-
 board/BuR/zynq/Kconfig                        |  14 +
 board/BuR/zynq/MAINTAINERS                    |  11 +
 board/BuR/zynq/Makefile                       |  15 +
 board/BuR/zynq/brcp150/board.c                |   4 +
 board/BuR/zynq/brcp150/ps7=5Finit=5Fgpl.c         | 278 ++++++++++++++++++
 board/BuR/zynq/brcp170/board.c                |   4 +
 board/BuR/zynq/brcp170/ps7=5Finit=5Fgpl.c         | 274 +++++++++++++++++
 board/BuR/zynq/brcp1=5F1r/board.c               |   4 +
 board/BuR/zynq/brcp1=5F1r/ps7=5Finit=5Fgpl.c        | 274 +++++++++++++++++
 board/BuR/zynq/brcp1=5F1r=5Fswitch/board.c        |   4 +
 board/BuR/zynq/brcp1=5F1r=5Fswitch/ps7=5Finit=5Fgpl.c | 270 ++++++++++++++=
+++
 board/BuR/zynq/brcp1=5F2r/board.c               |   4 +
 board/BuR/zynq/brcp1=5F2r/ps7=5Finit=5Fgpl.c        | 277 +++++++++++++++++
 board/BuR/zynq/brsmarc2/board.c               |  30 ++
 board/BuR/zynq/brsmarc2/ps7=5Finit=5Fgpl.c        | 276 +++++++++++++++++
 board/BuR/zynq/common/board.c                 | 231 +++++++++++++++
 board/BuR/zynq/env/brcp1.env                  | 109 +++++++
 board/BuR/zynq/env/brcp150.env                | 119 ++++++++
 configs/brcp150=5Fdefconfig                     | 121 ++++++++
 configs/brcp170=5Fdefconfig                     | 120 ++++++++
 configs/brcp1=5F1r=5Fdefconfig                    | 120 ++++++++
 configs/brcp1=5F1r=5Fswitch=5Fdefconfig             | 121 ++++++++
 configs/brcp1=5F2r=5Fdefconfig                    | 120 ++++++++
 configs/brsmarc2=5Fdefconfig                    | 120 ++++++++
 include/configs/brzynq.h                      |  21 ++
 45 files changed, 3943 insertions(+), 59 deletions(-)
 create mode 100644 arch/arm/dts/zynq-binman-brcp1.dtsi
 create mode 100644 arch/arm/dts/zynq-brcp1.dtsi
 create mode 100644 arch/arm/dts/zynq-brcp150-u-boot.dtsi
 create mode 100644 arch/arm/dts/zynq-brcp150.dts
 create mode 100644 arch/arm/dts/zynq-brcp170-u-boot.dtsi
 create mode 100644 arch/arm/dts/zynq-brcp170.dts
 create mode 100644 arch/arm/dts/zynq-brcp1=5F1r-u-boot.dtsi
 create mode 100644 arch/arm/dts/zynq-brcp1=5F1r.dts
 create mode 120000 arch/arm/dts/zynq-brcp1=5F1r=5Fswitch-u-boot.dtsi
 create mode 100644 arch/arm/dts/zynq-brcp1=5F1r=5Fswitch.dts
 create mode 120000 arch/arm/dts/zynq-brcp1=5F2r-u-boot.dtsi
 create mode 100644 arch/arm/dts/zynq-brcp1=5F2r.dts
 create mode 100644 arch/arm/dts/zynq-brsmarc2-u-boot.dtsi
 create mode 100644 arch/arm/dts/zynq-brsmarc2.dts
 create mode 100644 board/BuR/common/Kconfig
 create mode 100644 board/BuR/zynq/Kconfig
 create mode 100644 board/BuR/zynq/MAINTAINERS
 create mode 100644 board/BuR/zynq/Makefile
 create mode 100644 board/BuR/zynq/brcp150/board.c
 create mode 100644 board/BuR/zynq/brcp150/ps7=5Finit=5Fgpl.c
 create mode 100644 board/BuR/zynq/brcp170/board.c
 create mode 100644 board/BuR/zynq/brcp170/ps7=5Finit=5Fgpl.c
 create mode 100644 board/BuR/zynq/brcp1=5F1r/board.c
 create mode 100644 board/BuR/zynq/brcp1=5F1r/ps7=5Finit=5Fgpl.c
 create mode 100644 board/BuR/zynq/brcp1=5F1r=5Fswitch/board.c
 create mode 100644 board/BuR/zynq/brcp1=5F1r=5Fswitch/ps7=5Finit=5Fgpl.c
 create mode 100644 board/BuR/zynq/brcp1=5F2r/board.c
 create mode 100644 board/BuR/zynq/brcp1=5F2r/ps7=5Finit=5Fgpl.c
 create mode 100644 board/BuR/zynq/brsmarc2/board.c
 create mode 100644 board/BuR/zynq/brsmarc2/ps7=5Finit=5Fgpl.c
 create mode 100644 board/BuR/zynq/common/board.c
 create mode 100644 board/BuR/zynq/env/brcp1.env
 create mode 100644 board/BuR/zynq/env/brcp150.env
 create mode 100644 configs/brcp150=5Fdefconfig
 create mode 100644 configs/brcp170=5Fdefconfig
 create mode 100644 configs/brcp1=5F1r=5Fdefconfig
 create mode 100644 configs/brcp1=5F1r=5Fswitch=5Fdefconfig
 create mode 100644 configs/brcp1=5F2r=5Fdefconfig
 create mode 100644 configs/brsmarc2=5Fdefconfig
 create mode 100644 include/configs/brzynq.h

--=20
2.49.0

