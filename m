Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB39CD54A8
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 08:39:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD81B86AB9;
	Tue, 19 Sep 2023 10:39:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RP9qqg73";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CCF486AA4; Tue, 19 Sep 2023 10:39:43 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CCFE86A26
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 10:39:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38J8dcWH098228;
 Tue, 19 Sep 2023 03:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695112778;
 bh=z9t+1spsM+vnwGgzR8mkznrtXW2u4NtVy3MUWB8+GZg=;
 h=From:Subject:Date:To:CC;
 b=RP9qqg737XamnLBgMexkL2uvuxeGUoct806U88K3+YSa8pL75YU8jGYmO6ctXeEt7
 JjiaZsI6WLf56ji0fsAQwxoupTE2u4V2u+JEi9wfWHSVvPQkSJ2WQXAQ4DotoOZEbl
 gaAFoyjJMMYd2nu7IcO2sQj7/CxWLUOQbPbVnqmI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38J8dc05018698
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Sep 2023 03:39:38 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Sep 2023 03:39:38 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Sep 2023 03:39:38 -0500
Received: from [127.0.1.1] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38J8dYu5001331;
 Tue, 19 Sep 2023 03:39:35 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH] J721S2 DTS Sync from v6.6-rc1 to u-boot
Date: Tue, 19 Sep 2023 14:09:30 +0530
Message-ID: <20230919-b4-upstream-j721s2-r5-pinmux-v5-0-a54d6ee26310@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEJeCWUC/5XOu27DMAwF0F8JNJeFSEuy26n/UXTQg65VwA9Ij
 uEi8L9XyhAgWz1eEjy8N5E5Rc7i/XITibeY4zyVoF8uwg92+maIoWRBkhrZoQGn4LrkNbEd4ac
 lzARJwxKn8boDaa98MOhId6IQzmYGl+zkh4o8Dife17pfEvdxv7///Cp5iHmd0++9zYZ1+s/HG
 4KEXmnVKU2tkfZjja9+HkVVNzojUZGs7lGhYyWdf5KaM1JTOwVjJL0h6cY8SeqMpIoUPKJy7Fm
 H9iEdx/EHg0JJPsMBAAA=
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Reid Tonking <reidt@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Andrew Davis <afd@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Nikhil M Jain <n-jain1@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695112774; l=2960;
 i=m-chawdhry@ti.com; s=20230324; h=from:subject:message-id;
 bh=AkLMRBsTGpZXnEmVjm11bN64C7GCl07Qx4roALmvc0Q=;
 b=CvQi2OdVeaT8nF97Sb//uXtfceckAYciT+hVpV7LvxQUmE6lEJdA5TQQ5QwdelTDot17+EhME
 5y8YJO6cp3XCNShmxqS9XIMnjnbQkcG/p56kbJafCXiExL+2M4Vudvp
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

The series tries to sync from Linux v6.6-rc1 along with addition of
the documentation for J721S2 that had been previously missing.

DMA fixes [0] are currently being upstreamed to Linux. 

Test Logs are included in [1]

[0]: https://lore.kernel.org/all/20230810174356.3322583-1-vigneshr@ti.com/
[1]: https://gist.github.com/manorit2001/dbad09fd00e8b7c3872e85874c8e648c

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Changes in v5:
- Fix the link ( Apurva )
- Sync with v6.6-rc1
    - Remove mcu_ringacc override from -u-boot.dtsi
- Added a patch revert that bring some instability in SK-AM68
- Update the commit messages to that of 6.6-rc1
- Link to v4: https://lore.kernel.org/r/20230816-b4-upstream-j721s2-r5-pinmux-v4-0-dc114bece5d7@ti.com

---
Manorit Chawdhry (6):
      Revert "arm: dts: k3-j7*: ddr: Update to 0.10 version of DDR config tool"
      arm: mach-k3: j721s2: Add mcu_timer0 id to the dev list
      k3-j721s2: Sync from Linux tag v6.6-rc1
      k3-am68: Sync from Linux tag v6.6-rc1
      docs: board: ti: Add j721s2_evm documentation
      board: ti: j721s2: MAINTAINERS: Update the MAINTAINERS File.

Udit Kumar (1):
      configs: j721s2_evm_r5_defconfig: Increase malloc pool size in DRAM

 arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi     |  75 +-
 arch/arm/dts/k3-am68-sk-base-board.dts             | 524 +++++++++-----
 arch/arm/dts/k3-am68-sk-r5-base-board.dts          | 151 +---
 arch/arm/dts/k3-am68-sk-som.dtsi                   | 112 +--
 arch/arm/dts/k3-j721e-ddr-evm-lp4-4266.dtsi        |  98 +--
 .../dts/k3-j721s2-common-proc-board-u-boot.dtsi    |  66 +-
 arch/arm/dts/k3-j721s2-common-proc-board.dts       | 376 ++++++----
 arch/arm/dts/k3-j721s2-ddr-evm-lp4-4266.dtsi       | 464 ++++++------
 arch/arm/dts/k3-j721s2-main.dtsi                   | 777 ++++++++++++++++++++-
 arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi             | 374 +++++++++-
 arch/arm/dts/k3-j721s2-r5-common-proc-board.dts    | 158 +----
 arch/arm/dts/k3-j721s2-som-p0.dtsi                 | 172 ++---
 arch/arm/dts/k3-j721s2-thermal.dtsi                | 101 +++
 arch/arm/dts/k3-j721s2.dtsi                        |  12 +-
 arch/arm/dts/k3-serdes.h                           | 204 ++++++
 arch/arm/mach-k3/j721s2/dev-data.c                 |   1 +
 board/ti/j721s2/MAINTAINERS                        |  11 +-
 configs/j721s2_evm_r5_defconfig                    |   1 +
 doc/board/ti/j721s2_evm.rst                        | 341 +++++++++
 doc/board/ti/k3.rst                                |   1 +
 20 files changed, 2859 insertions(+), 1160 deletions(-)
---
base-commit: 2fe4b54556ea6271237b35de68dc458bfceab94c
change-id: 20230816-b4-upstream-j721s2-r5-pinmux-25c4cd61b258

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

