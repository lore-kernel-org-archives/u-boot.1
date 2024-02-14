Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092D4C48BC1
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 16:31:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10E4187E07;
	Wed, 14 Feb 2024 17:30:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="f8jwjttN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE27387E5C; Wed, 14 Feb 2024 17:30:21 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB45587E25
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 17:30:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41EGUA4M101802;
 Wed, 14 Feb 2024 10:30:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1707928210;
 bh=TLCg/0JgW1m7sQrr9z22rp8nmya3H4kppzyORiCFoKY=;
 h=From:To:CC:Subject:Date;
 b=f8jwjttNhW76y61kNnyEP76EIloHU+1tD1WdtQ129YjqisZxntRQUyGYAmJqgo4nd
 jNhGNuEWjWcoevBZHh1rkgqJYCBKJnFeU0al1Q0qjrGsCUXbseIBFi2S/nGs6g8CWh
 mEVPTuvcIatabL4ivPxqLz65EYNDPAybULVvJbgg=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41EGUAgg049388
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 14 Feb 2024 10:30:10 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Feb 2024 10:30:10 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Feb 2024 10:30:10 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41EGU9rr014388;
 Wed, 14 Feb 2024 10:30:09 -0600
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH 0/6] Move DRAM address of ATF
Date: Wed, 14 Feb 2024 10:30:03 -0600
Message-ID: <20240214163009.983034-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
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

Hello all,

Explanation for this series is mostly in [4/6]. First 3
patches should be safe to take independent of the last 3.

Thanks,
Andrew

Andrew Davis (6):
  arm: mach-k3: Add default ATF location for AM62/AM62a
  arm: mach-k3: Add config option for setting OP-TEE address
  arm: mach-k3: am62: Enable OF_SYSTEM_SETUP for all boards
  arm: mach-k3: am62: Fixup TF-A/OP-TEE reserved-memory node in FDT
  arm: mach-k3: am62a: Fixup TF-A/OP-TEE reserved-memory node in FDT
  arm: mach-k3: Move DRAM address of ATF for AM62/AM62a

 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi  |  4 +-
 arch/arm/dts/k3-am65-iot2050-boot-image.dtsi  |  4 +-
 arch/arm/dts/k3-binman.dtsi                   |  8 +--
 .../dts/k3-j721e-beagleboneai64-u-boot.dtsi   |  4 +-
 arch/arm/mach-k3/Kconfig                      | 10 +++-
 arch/arm/mach-k3/Makefile                     |  1 +
 arch/arm/mach-k3/am625_fdt.c                  |  2 +
 arch/arm/mach-k3/am62a7_fdt.c                 | 16 ++++++
 arch/arm/mach-k3/am62ax/Kconfig               |  1 +
 arch/arm/mach-k3/am62x/Kconfig                |  3 ++
 arch/arm/mach-k3/common_fdt.c                 | 52 +++++++++++++++++++
 arch/arm/mach-k3/common_fdt.h                 |  2 +
 configs/am62ax_evm_a53_defconfig              |  1 -
 configs/am62x_beagleplay_a53_defconfig        |  1 -
 configs/am62x_evm_a53_defconfig               |  1 -
 configs/phycore_am62x_a53_defconfig           |  1 -
 configs/verdin-am62_a53_defconfig             |  2 -
 17 files changed, 96 insertions(+), 17 deletions(-)
 create mode 100644 arch/arm/mach-k3/am62a7_fdt.c

-- 
2.39.2

