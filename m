Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A748C3DA66
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 11:17:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA5738681D;
	Fri, 25 Aug 2023 13:17:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EgI165P/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A64C6868CA; Fri, 25 Aug 2023 13:17:37 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C4F38622D
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 13:17:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37PBHWM8005053;
 Fri, 25 Aug 2023 06:17:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692962252;
 bh=5dL8FVCQL75Lnu3I5O0oBe298ZLIBCaVa+6gdiKSNIE=;
 h=From:Subject:Date:To:CC;
 b=EgI165P/qnwLAYqZjZphc7PoZwG03DzQcBMPdsvPzVc5uwUAEf6i0M/p/QfeeSg+3
 buISICCC7OZ/v6KMLUpMQWI5R+jgReUFoGvWiqAYBxpJaUx1hmAUbL/yBqAKvfDmXT
 xB66RsgZnfyn41XX6YPrNR/HmFSBDPx2SP/moOK4=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37PBHWkc073117
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Aug 2023 06:17:32 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Aug 2023 06:17:30 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Aug 2023 06:17:30 -0500
Received: from [127.0.1.1] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37PBHQC5023435;
 Fri, 25 Aug 2023 06:17:27 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH v2 0/6] DTS Sync from v6.5-rc1 to u-boot
Date: Fri, 25 Aug 2023 16:46:58 +0530
Message-ID: <20230816-b4-upstream-j721s2-r5-pinmux-v2-0-a5f141be40bc@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKqN6GQC/42OTQ6DIBCFr2JYdxqYgpqueo/GBeBYaSIaQGNjv
 HvRRdddfu/l/WwsUnAU2b3YWKDFRTf6DHgpmO21fxG4NjNDjjdeixKMhHmKKZAe4F2hiAhBweT
 8MK+AykrblsKgqlmuMDoSmKC97Y+SX9DTmg5/CtS59Zx/Npl7F9MYPuebRRzqn8OLAA6dVLKWC
 quS60dyVzsOrNn3/Qs28k695QAAAA==
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Reid Tonking <reidt@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Andrew Davis <afd@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Nikhil M Jain <n-jain1@ti.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692962247; l=3453;
 i=m-chawdhry@ti.com; s=20230324; h=from:subject:message-id;
 bh=BvQYTbJX+3baTSDvSLfbVPfldp8mI2Q2zqDC5nlWr3c=;
 b=4awuNhMv0LI53EMH3rMfo3ldkhUbqfsuyqjyRepWAIvYjkTxjrVXbDJgtT1uOYPKeokneJwtK
 WQNMUnT3Bh3Aly0ORLKucWsZSHHAF2e8uAZP1jk/9zT/jS8EZL0AK50
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=Z51yAzxWCcDqKRLHiDBrUxIdXbB21R89ms8xgECdiak=
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

The sync tries to ensure that U-boot remains functional with the updated
Linux DTS and all the fixes from Linux move to U-boot during the sync.

The series tries to sync from Linux v6.5-rc1 along with addition of
the documentation for J721S2 that had been previously missing.

MCU Ringacc [0] and DMA fixes [1] are currently being upstreamed to Linux. 
They'll be fixed in U-boot post their merge in Linux hopefully during
v6.6-rc1 timeframe.

Test Logs are included in [2]

[0]: https://lore.kernel.org/all/20230809175932.2553156-1-vigneshr@ti.com/
[1]: https://lore.kernel.org/all/20230810174356.3322583-1-vigneshr@ti.com/
[2]: https://gist.github.com/manorit2001/dbad09fd00e8b7c3872e85874c8e648c

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Changes in v2:
- Add an additional patch required for booting the board after rebasing
  to uboot-next
- Use v6.5-rc1 for the Sync and revert the changed done for -next
  (Nishanth)
- Change <> to "" in #include and fix the order of includes(Nishanth)
- Remove duplicates among -u-boot.dtsi and -r5 dtsi files moving the 
  nodes to appropriate files (Nishanth)
- Remove fs_loader0 node (Nishanth)
- Remove /delete-property/ and add the dev-data and clk-data (Nishanth)
- Update documentation with better wordings (Nishanth)
- Added openocd section (Nishanth)
- Fix section numbering that was pointed out (Nishanth)
- Change to use explicit-targets for cross-referencing in documentation
  (Nishanth)
- Propose myself as a Maintainer for J721S2 as a separate commit (Nishanth)
- Link to v1: https://lore.kernel.org/r/20230816-b4-upstream-j721s2-r5-pinmux-v1-0-f4548452760a@ti.com

---
Manorit Chawdhry (5):
      arm: mach-k3: j721s2: Add mcu_timer0 id to the dev list
      k3-j721s2: Sync from Linux tag v6.5-rc1
      k3-am68: Sync from Linux tag v6.5-rc1
      docs: ti: j721s2_evm: Create documentation from J7200 docs
      board: ti: j721s2: MAINTAINERS: Update the MAINTAINERS File.

Udit Kumar (1):
      configs: j721s2_evm_r5_defconfig: Increase malloc pool size in DRAM

 arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi     |  69 +--
 arch/arm/dts/k3-am68-sk-base-board.dts             | 389 ++++++++------
 arch/arm/dts/k3-am68-sk-r5-base-board.dts          | 143 +----
 arch/arm/dts/k3-am68-sk-som.dtsi                   | 112 +---
 .../dts/k3-j721s2-common-proc-board-u-boot.dtsi    |  60 +--
 arch/arm/dts/k3-j721s2-common-proc-board.dts       | 330 ++++++------
 arch/arm/dts/k3-j721s2-main.dtsi                   | 585 ++++++++++++++++++++-
 arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi             | 365 ++++++++++++-
 arch/arm/dts/k3-j721s2-r5-common-proc-board.dts    | 151 +-----
 arch/arm/dts/k3-j721s2-som-p0.dtsi                 | 165 +++---
 arch/arm/dts/k3-j721s2-thermal.dtsi                | 101 ++++
 arch/arm/dts/k3-j721s2.dtsi                        |  12 +-
 arch/arm/mach-k3/j721s2/dev-data.c                 |   1 +
 board/ti/j721s2/MAINTAINERS                        |   5 +-
 configs/j721s2_evm_r5_defconfig                    |   1 +
 doc/board/ti/j721s2_evm.rst                        | 263 +++++++++
 doc/board/ti/k3.rst                                |   1 +
 17 files changed, 1908 insertions(+), 845 deletions(-)
---
base-commit: 97841de680430e235f0954a188f245775cbbb962
change-id: 20230816-b4-upstream-j721s2-r5-pinmux-25c4cd61b258

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

