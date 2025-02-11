Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC19C0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 12:50:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4B5480C5A;
	Tue, 11 Feb 2025 13:50:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D87B5800B3; Tue, 11 Feb 2025 13:50:44 +0100 (CET)
Received: from inet13.abb.com (inet13.abb.com [138.225.1.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3549880EEF
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 13:50:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bernhard.messerklinger@br-automation.com
Received: from brsmtp01.br-automation.co.at ([10.43.60.20])
 by inet13.abb.com (8.15.2/8.14.7) with ESMTPS id 51BCo1gF1946192
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 11 Feb 2025 13:50:02 +0100
Received: from extmail.br-automation.com ([192.168.112.26])
 by brsmtp01.br-automation.co.at (HCL Domino Release 14.0FP3 HF8)
 with ESMTP id 2025021113500246-2243 ;
 Tue, 11 Feb 2025 13:50:02 +0100 
Received: from ATEGGE3725.br-automation.co.at ([10.43.64.28])
 by extmail.br-automation.com (HCL Domino Build V1202_05192022)
 with ESMTP id 2025021113500228-556 ; Tue, 11 Feb 2025 13:50:02 +0100 
From: "Bernhard Messerklinger" <bernhard.messerklinger@br-automation.com>
To: u-boot@lists.denx.de
Cc: "Bernhard Messerklinger" <bernhard.messerklinger@br-automation.com>,
 "Adam Ford" <aford173@gmail.com>,
 "Andre Przywara" <andre.przywara@arm.com>,
 "Caleb Connolly" <caleb.connolly@linaro.org>,
 "Fabio Estevam" <festevam@denx.de>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Kever Yang" <kever.yang@rock-chips.com>,
 "Marek Vasut" <marek.vasut+renesas@mailbox.org>,
 "Michal Simek" <michal.simek@amd.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Oliver Gaskell" <Oliver.Gaskell@analog.com>,
 "Prasad Kummari" <prasad.kummari@amd.com>,
 "Simon Glass" <sjg@chromium.org>, "Sumit Garg" <sumit.garg@linaro.org>,
 "Tom Rini" <trini@konsulko.com>, "Tony Dinh" <mibodhi@gmail.com>,
 "Wolfgang Wallner" <wolfgang.wallner@br-automation.com>
Subject: [PATCH v2 0/4] Add support for BR Xylinx Zynq boards in mainline
 U-Boot.
Date: Tue, 11 Feb 2025 13:49:27 +0100
Message-ID: <20250211124957.104907-1-bernhard.messerklinger@br-automation.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on BRSMTPINTERN2/InternSMTP(Build
 V1202_05192022|May 19, 2022) at 02/11/2025 01:50:02 PM,
 Serialize by Router on BRSMTPINTERN2/InternSMTP(Build V1202_05192022|May 19,
 2022) at 02/11/2025 01:50:02 PM,
 Itemize by SMTP Server on BRSMTP01/Eggelsberg/AT/B&R(Release 14.0FP3
 HF8|December 13, 2024) at 02/11/2025 01:50:02 PM,
 Serialize by Router on BRSMTP01/Eggelsberg/AT/B&R(Release 14.0FP3 HF8|December
 13, 2024) at 02/11/2025 01:50:06 PM,
 Serialize complete at 02/11/2025 01:50:06 PM
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

 arch/arm/dts/Makefile                         |   8 +-
 arch/arm/dts/zynq-brcp1-u-boot.dtsi           | 110 +++++++
 arch/arm/dts/zynq-brcp1.dtsi                  | 133 +++++++++
 arch/arm/dts/zynq-brcp150-u-boot.dtsi         | 129 ++++++++
 arch/arm/dts/zynq-brcp150.dts                 | 174 +++++++++++
 arch/arm/dts/zynq-brcp170-u-boot.dtsi         | 113 +++++++
 arch/arm/dts/zynq-brcp170.dts                 | 140 +++++++++
 arch/arm/dts/zynq-brcp1=5F1r.dts                |  29 ++
 arch/arm/dts/zynq-brcp1=5F1r=5Fswitch.dts         |  30 ++
 arch/arm/dts/zynq-brcp1=5F2r.dts                |  22 ++
 arch/arm/dts/zynq-brsmarc2-u-boot.dtsi        | 110 +++++++
 arch/arm/dts/zynq-brsmarc2.dts                | 158 ++++++++++
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
 configs/brcp150=5Fdefconfig                     | 123 ++++++++
 configs/brcp170=5Fdefconfig                     | 122 ++++++++
 configs/brcp1=5F1r=5Fdefconfig                    | 122 ++++++++
 configs/brcp1=5F1r=5Fswitch=5Fdefconfig             | 123 ++++++++
 configs/brcp1=5F2r=5Fdefconfig                    | 122 ++++++++
 configs/brsmarc2=5Fdefconfig                    | 122 ++++++++
 include/configs/brzynq.h                      |  21 ++
 42 files changed, 4200 insertions(+), 60 deletions(-)
 create mode 100644 arch/arm/dts/zynq-brcp1-u-boot.dtsi
 create mode 100644 arch/arm/dts/zynq-brcp1.dtsi
 create mode 100644 arch/arm/dts/zynq-brcp150-u-boot.dtsi
 create mode 100644 arch/arm/dts/zynq-brcp150.dts
 create mode 100644 arch/arm/dts/zynq-brcp170-u-boot.dtsi
 create mode 100644 arch/arm/dts/zynq-brcp170.dts
 create mode 100644 arch/arm/dts/zynq-brcp1=5F1r.dts
 create mode 100644 arch/arm/dts/zynq-brcp1=5F1r=5Fswitch.dts
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
2.48.1

