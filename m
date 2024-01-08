Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C76BC3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 17:34:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F26A87B04;
	Mon,  8 Jan 2024 18:33:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Xss4Ei3H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C90A387AF0; Mon,  8 Jan 2024 18:33:25 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C9A787AD7
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 18:33:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 408HX9Bp109414;
 Mon, 8 Jan 2024 11:33:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704735189;
 bh=Ob0gbmWdasJldya/RlSoWYc2Zw3FFnPB4Arbz8WNRZo=;
 h=From:To:CC:Subject:Date;
 b=Xss4Ei3H4pZT+DGst6p2sDTWbY5YumNqZc1PddPD32VnpEmixhiSnq/kpOa/uTWrV
 mr+nOWWhSNLfrFI32nrhz6APyPBznSYyt+/3k213NdHKatrEQUML54G5PTG8WAO2Gf
 rF+/dteMVUJ8K3B7ibZZcqQuXrMnx7zaAKFfqhhE=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 408HX9fY009225
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 8 Jan 2024 11:33:09 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Jan 2024 11:33:08 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Jan 2024 11:33:08 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 408HX8oj045323;
 Mon, 8 Jan 2024 11:33:08 -0600
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Kamlesh Gurudasani <kamlesh@ti.com>, Sinthu Raja <sinthu.raja@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Roger Quadros <rogerq@kernel.org>, Simon Glass
 <sjg@chromium.org>, Andrew Davis <afd@ti.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>,
 Nikhil M Jain <n-jain1@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Bryan Brattlof <bb@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 <u-boot@lists.denx.de>, Jon Humphreys <j-humphreys@ti.com>,
 Nishanth Menon <nm@ti.com>
Subject: [PATCH 00/10] board/ti:  k3 boards: Stop using findfdt
Date: Mon, 8 Jan 2024 11:32:51 -0600
Message-ID: <20240108173301.2692332-1-nm@ti.com>
X-Mailer: git-send-email 2.43.0
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

This is a wide cleanup to switch to setting fdtfile using env_set
instead of scripted magic. 'fdtfile' is expected to be set by default.
This allows the stdboot triggered efi loaders to find the correct OS
device tree file.

This is a refresh of
https://lore.kernel.org/all/86le9dwz4d.fsf@udb0321960.dhcp.ti.com/ which
was the wrong approach.

Bootlogs: https://gist.github.com/nmenon/2f4a142c1bcaa09d544b1f2e206ea134

NOTE: There are a couple of checkpatch WARN (around LATE_INIT) and
CHECK (fdt_ops #ifdeffery) that on closer inspection looks fine and
consistent with other similar usage.

Based on next branch at: c2c598e87cfe Merge branch 'staging' of https://source.denx.de/u-boot/custodians/u-boot-tegra into next

Nishanth Menon (10):
  board: ti: common: Introduce a common fdt ops library
  board: ti: am62ax: Set fdtfile from C code instead of findfdt script
  board: ti: am62x: Set fdtfile from C code instead of findfdt script
  board: ti: am64x: Set fdtfile from C code instead of findfdt script
  board: ti: am65x: Set fdtfile from C code instead of findfdt script
  board: ti: j721e: Set fdtfile from C code instead of findfdt script
  board: ti: j721s2: Set fdtfile from C code instead of findfdt script
  board: beagle: beagleboneai64: Set fdtfile from C code instead of
    findfdt script
  board: beagle: beagleplay: Set fdtfile from C code instead of findfdt
    script
  include: env: ti: Drop default_findfdt

 board/beagle/beagleboneai64/beagleboneai64.c  | 14 ++++
 .../beagle/beagleboneai64/beagleboneai64.env  |  1 -
 board/beagle/beagleplay/beagleplay.c          | 14 ++++
 board/beagle/beagleplay/beagleplay.env        |  1 -
 board/ti/am62ax/am62ax.env                    |  1 -
 board/ti/am62ax/evm.c                         | 10 +++
 board/ti/am62x/am62x.env                      |  1 -
 board/ti/am62x/evm.c                          |  8 +++
 board/ti/am64x/am64x.env                      |  9 ---
 board/ti/am64x/evm.c                          |  8 +++
 board/ti/am65x/am65x.env                      |  3 -
 board/ti/am65x/evm.c                          |  2 +
 board/ti/common/Kconfig                       | 12 ++++
 board/ti/common/Makefile                      |  1 +
 board/ti/common/fdt_ops.c                     | 65 +++++++++++++++++++
 board/ti/common/fdt_ops.h                     | 41 ++++++++++++
 board/ti/j721e/evm.c                          |  8 +++
 board/ti/j721e/j721e.env                      | 10 ---
 board/ti/j721s2/evm.c                         |  8 +++
 board/ti/j721s2/j721s2.env                    |  8 ---
 configs/am62ax_evm_a53_defconfig              |  1 +
 configs/am62x_beagleplay_a53_defconfig        |  3 +-
 configs/am62x_evm_a53_defconfig               |  1 +
 configs/j721e_beagleboneai64_a72_defconfig    |  3 +-
 include/env/ti/default_findfdt.env            | 12 ----
 25 files changed, 197 insertions(+), 48 deletions(-)
 create mode 100644 board/ti/common/fdt_ops.c
 create mode 100644 board/ti/common/fdt_ops.h
 delete mode 100644 include/env/ti/default_findfdt.env

-- 
2.43.0

