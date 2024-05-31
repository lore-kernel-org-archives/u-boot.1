Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0399FC27C4F
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 22:22:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDA148881D;
	Sat,  1 Jun 2024 00:21:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YfsX7dVj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0083C881AD; Sat,  1 Jun 2024 00:21:48 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8501988124
 for <u-boot@lists.denx.de>; Sat,  1 Jun 2024 00:21:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44VMLVfx017743;
 Fri, 31 May 2024 17:21:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717194091;
 bh=wLMMX/ASDs3vmi/T3L+SWp/+mpvSRZOG0Tm2ceP8pYs=;
 h=From:To:CC:Subject:Date;
 b=YfsX7dVjr1vmFkqXnVNebOX5SAtaD8EFjh6OULIIYJ+nvTUAeourl5nD89b14KNca
 /MNiuYWF4F9oup5LhCv3rHub7+e8YVKHtDzoEGrQRhgIaPy4nkFIXsmAq87kiOmfTS
 Xvksb/2wWAKRZob7WmF8mxkHHcmk1c7dghr6t38k=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44VMLVt6006196
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 31 May 2024 17:21:31 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 31
 May 2024 17:21:31 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 31 May 2024 17:21:31 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44VMLV9P026015;
 Fri, 31 May 2024 17:21:31 -0500
From: Jonathan Humphreys <j-humphreys@ti.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Kamlesh Gurudasani
 <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Judith Mendez <jm@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Simon Glass <sjg@chromium.org>,
 Nikhil M Jain <n-jain1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Maxime Ripard
 <mripard@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>, Jonathan Humphreys <j-humphreys@ti.com>
Subject: [PATCH v5 00/23] EFI: ti: Enable EFI capsule updates
Date: Fri, 31 May 2024 17:20:55 -0500
Message-ID: <20240531222118.2618041-1-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Enable on disk capsule updates, which includes defining the firmware
components (tiboot3, spl, u-boot) and enabling processing of raw capsule
updates.

This is enabled for several TI SoC based platforms: AM64, AM62, AM62p,
AM69, BeaglePlay, J7, and BeagleboneAI.

This series also includes enabling seral flash DFU for AM62 and MMC DFU for
beagleplay.

Changes from v1:
- Added sysfw.itb capsule definition to beagleboneai64
- removed extra commas in structure definitions

Changes from v2:
- Added documentation on OSPI flash layouts
- Improved comments for capsule GUIDs definitions
- Defined board unique capsule GUIDs and put definitions in board specific
  files
- Added a Capsule Update porting section to the documentation

Changes from v3:
- Added better commit messages based upon checkpatch warnings.
- Remove conditional inclusion of capsule update firmware info
- Converted OSPI layout diagram to svg format
Link to v3: https://lore.kernel.org/r/20240419205701.163821-1-j-humphreys@ti.com

Changes from v4:
- Added am69 SK board
- Corrected a few spelling mistakes and clarity improvements in k3 docs
  section
- Added CONFIG_SET_DFU_ALT_INFO guard around set_dfu_alt_info()
Link to v4: https://lore.kernel.org/r/20240509164123.1753050-1-j-humphreys@ti.com

Jonathan Humphreys (23):
  doc: uefi: capsules: Add Capsule Update porting section
  doc: ti: k3: Correct spelling mistakes and improve clarity
  board: am64x: Define capsule update firmware info
  configs: am64x: Enable EFI capsule update
  doc: board: ti: am64x: document OSPI layout
  board: j721e: Define capsule update firmware info
  configs: j721e: Enable EFI capsule update
  doc: board: ti: j721e: document OSPI layout
  board: beagleplay: Define capsule update firmware info
  configs: beagleplay: Enable DFU for MMC
  configs: beagleplay: Enable EFI capsule update
  board: am62x: Define capsule update firmware info
  configs: am62x: Enable EFI capsule update
  doc: board: ti: am62x: document OSPI layout
  board: am62px: Define capsule update firmware info
  configs: am62px: Enable EFI capsule update
  doc: board: ti: am62px: document OSPI layout
  board: beagleboneai64: Define capsule update firmware info
  configs: beagleboneai64: Enable EFI capsule update
  configs: j784s4_evm: Enable serial flash DFU support
  board: sk-am69: Define capsule update firmware info
  configs: j784s4: Enable EFI capsule update
  doc: board: ti: j784s4: document OSPI NOR layout

 board/beagle/beagleboneai64/Kconfig          |    4 +-
 board/beagle/beagleboneai64/beagleboneai64.c |   39 +
 board/beagle/beagleplay/Kconfig              |    4 +-
 board/beagle/beagleplay/beagleplay.c         |   34 +
 board/ti/am62px/evm.c                        |   34 +
 board/ti/am62x/evm.c                         |   34 +
 board/ti/am64x/evm.c                         |   34 +
 board/ti/j721e/evm.c                         |   40 +
 board/ti/j784s4/evm.c                        |   34 +
 configs/am62px_evm_a53_defconfig             |    2 +
 configs/am62x_beagleplay_a53_defconfig       |    5 +
 configs/am62x_evm_a53_defconfig              |    2 +
 configs/am64x_evm_a53_defconfig              |    2 +
 configs/j721e_beagleboneai64_a72_defconfig   |    2 +
 configs/j721e_evm_a72_defconfig              |    2 +
 configs/j784s4_evm_a72_defconfig             |    5 +
 doc/board/ti/am62px_sk.rst                   |   24 +
 doc/board/ti/am62x_sk.rst                    |   24 +
 doc/board/ti/am64x_evm.rst                   |   24 +
 doc/board/ti/img/ospi_sysfw-am64.svg         |  802 ++++++++++
 doc/board/ti/img/ospi_sysfw.svg              | 1464 ++++++++++--------
 doc/board/ti/img/ospi_sysfw2.svg             |  802 ++++++++++
 doc/board/ti/img/ospi_sysfw3.svg             |  802 ++++++++++
 doc/board/ti/j721e_evm.rst                   |   58 +-
 doc/board/ti/j784s4_evm.rst                  |   28 +
 doc/board/ti/k3.rst                          |   10 +-
 doc/develop/uefi/uefi.rst                    |   12 +
 include/configs/am62px_evm.h                 |   24 +
 include/configs/am62x_evm.h                  |   24 +
 include/configs/am64x_evm.h                  |   24 +
 include/configs/beagleboneai64.h             |   55 +
 include/configs/beagleplay.h                 |   41 +
 include/configs/j721e_evm.h                  |   29 +
 include/configs/j784s4_evm.h                 |   24 +
 34 files changed, 3864 insertions(+), 684 deletions(-)
 create mode 100644 doc/board/ti/img/ospi_sysfw-am64.svg
 create mode 100644 doc/board/ti/img/ospi_sysfw2.svg
 create mode 100644 doc/board/ti/img/ospi_sysfw3.svg
 create mode 100644 include/configs/beagleboneai64.h
 create mode 100644 include/configs/beagleplay.h

-- 
2.34.1

