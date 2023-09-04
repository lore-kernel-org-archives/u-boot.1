Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FE8C83F2C
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 10:38:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6D4086453;
	Mon,  4 Sep 2023 12:38:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="eAq64jFV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED9F786500; Mon,  4 Sep 2023 12:38:27 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9446186453
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 12:38:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 384AcLpL107419;
 Mon, 4 Sep 2023 05:38:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693823901;
 bh=vCwKi8Ljhax2aIB6KJJE6Z0JsuVHeIoST5SNxwh1OfM=;
 h=From:Subject:Date:To:CC;
 b=eAq64jFVjbOrAEge26fEsdMjheTd5LkmN5vUfj0pPBBLi/cqvoTuJgLwOLzKrvcZC
 yBFKIMStsS4I1ILhYlFXqBtMX3O19HTJIWQtSYpwa2jHb1zG/npDK0x85/yU4u8FVJ
 QNj9ENvGyds2YH7ZPggLVxzTtFXeBUosG0pNpNwo=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 384AcL3b092454
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 4 Sep 2023 05:38:21 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 4
 Sep 2023 05:38:20 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 4 Sep 2023 05:38:20 -0500
Received: from [127.0.1.1] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 384AcHYr029746;
 Mon, 4 Sep 2023 05:38:18 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH v4 0/6] DTS Sync from v6.5-rc1 to u-boot
Date: Mon, 4 Sep 2023 16:08:15 +0530
Message-ID: <20230816-b4-upstream-j721s2-r5-pinmux-v4-0-dc114bece5d7@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJez9WQC/5XOwQ7CIAwG4FcxnK2BDnB68j2MB2Cdw2RsgbnMm
 L274MHEmx7/Nv36P1mi6Cmx4+bJIs0++SHkILcb5joTrgS+yZkhx4rXQoOVcB/TFMn0cNujSAh
 RwehDf18AlZOu0cKiqlkmrEkENprguoJ8DgMtU9mPkVq/vN+fLzl3Pk1DfLzbzKJMf3w8C+DQS
 iVrqXCvuTlNfueGnhV1xn8kzJJRrZDCkuTWfUnVP1JVOjVaczwIVJX+SOu6vgD80t/veQEAAA=
 =
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Reid Tonking <reidt@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Andrew Davis <afd@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Nikhil M Jain <n-jain1@ti.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693823897; l=2961;
 i=m-chawdhry@ti.com; s=20230324; h=from:subject:message-id;
 bh=W+D7uLVIQsK4KlBfZZiOUB+zdd7zugJaXsuHL3Agp7k=;
 b=vgqPsV3KlQdsTgrV7kspWFQEsA2fG87fSleoghrJPyCFR27aui+PAlImjFzn6LzxS8f/IuGNV
 z12yH5z5936Bu4V+B0DPkIl0Fry+46zLNhtoFlGPhN53OQKhfJ1XNpW
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
Changes in v4:
- Change the documentation commit description. (Nishanth)
- Remove extra spaces (Nishanth)
- Update J721S2 as J721S2-EVM and similar for AM68 (Nishanth)
- Add documentation for AM68 openocd (Nishanth)
- Add k3-j721s2-thermal.dtsi and arch/arm/mach-k3/j721s2 folder 
  in MAINTAINERS file
- Link to v3: https://lore.kernel.org/r/20230816-b4-upstream-j721s2-r5-pinmux-v3-0-fd6602912536@ti.com

---
Manorit Chawdhry (5):
      arm: mach-k3: j721s2: Add mcu_timer0 id to the dev list
      k3-j721s2: Sync from Linux tag v6.5-rc1
      k3-am68: Sync from Linux tag v6.5-rc1
      docs: board: ti: Add j721s2_evm documentation
      board: ti: j721s2: MAINTAINERS: Update the MAINTAINERS File.

Udit Kumar (1):
      configs: j721s2_evm_r5_defconfig: Increase malloc pool size in DRAM

 arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi     |  69 +--
 arch/arm/dts/k3-am68-sk-base-board.dts             | 389 ++++++++------
 arch/arm/dts/k3-am68-sk-r5-base-board.dts          | 151 +-----
 arch/arm/dts/k3-am68-sk-som.dtsi                   | 112 +---
 .../dts/k3-j721s2-common-proc-board-u-boot.dtsi    |  60 +--
 arch/arm/dts/k3-j721s2-common-proc-board.dts       | 330 ++++++------
 arch/arm/dts/k3-j721s2-main.dtsi                   | 585 ++++++++++++++++++++-
 arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi             | 365 ++++++++++++-
 arch/arm/dts/k3-j721s2-r5-common-proc-board.dts    | 158 +-----
 arch/arm/dts/k3-j721s2-som-p0.dtsi                 | 165 +++---
 arch/arm/dts/k3-j721s2-thermal.dtsi                | 101 ++++
 arch/arm/dts/k3-j721s2.dtsi                        |  12 +-
 arch/arm/mach-k3/j721s2/dev-data.c                 |   1 +
 board/ti/j721s2/MAINTAINERS                        |  11 +-
 configs/j721s2_evm_r5_defconfig                    |   1 +
 doc/board/ti/j721s2_evm.rst                        | 341 ++++++++++++
 doc/board/ti/k3.rst                                |   1 +
 17 files changed, 1998 insertions(+), 854 deletions(-)
---
base-commit: f2bb6d9ffd9ba0d0d89c00445a70cf81327a7af2
change-id: 20230816-b4-upstream-j721s2-r5-pinmux-25c4cd61b258

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

