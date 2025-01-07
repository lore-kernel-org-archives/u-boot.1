Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D48EE77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 09:39:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E1C380601;
	Tue,  7 Jan 2025 10:39:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nmBUbIbW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0753C801E8; Tue,  7 Jan 2025 10:38:59 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD1178036B
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 10:38:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5079cg4d003662;
 Tue, 7 Jan 2025 03:38:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1736242722;
 bh=ALEgWj/MMCgTAr4etfaneOOiWDiZNQ4G1mHcDXpNA3U=;
 h=From:To:CC:Subject:Date;
 b=nmBUbIbWA6cuY2uy8GTJHG4CsYCG6S2b6gT5b69sEOWaM+vXxRK5nbLew4MSKdfnc
 VfRqVeQr1zirJLCoBNWjxrYt+/Ad57VVzzqdxcwq9rxez2txnHaBOY1xzqCro77uTz
 XaIyVHV/UfVCCYke0TZFdVpjZd8SAG+vyxMh24pg=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5079cg9K089320
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 7 Jan 2025 03:38:42 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 Jan 2025 03:38:42 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 Jan 2025 03:38:42 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5079cfTm057359;
 Tue, 7 Jan 2025 03:38:41 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: AKASHI Takahiro <akashi.tkhro@gmail.com>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Nishanth Menon <nm@ti.com>, Roger Quadros
 <rogerq@kernel.org>, Hari Nagalla <hnagalla@ti.com>, Jonathan Humphreys
 <j-humphreys@ti.com>, Andreas Dannenberg <dannenberg@ti.com>, Simon Glass
 <sjg@chromium.org>, Jayesh Choudhary <j-choudhary@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>, Chintan Vankar
 <c-vankar@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew Davis
 <afd@ti.com>, Ramon Fried <rfried.dev@gmail.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <srk@ti.com>, <s-vadapalli@ti.com>, <danishanwar@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 00/13] Add support for Ethernet boot on AM62p-SK and AM68-SK
Date: Tue, 7 Jan 2025 15:08:27 +0530
Message-ID: <20250107093840.2211381-1-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

This series enables Ethernet boot on AM62p-SK and AM68-SK.

This series is based on commit
'6d41f0a39d6423c8e57e92ebbe9f8c0333a63f72' of origin/master branch of
U-Boot.

Logs:
AM62p-SK Ethernet boot:
https://gist.github.com/chintan013/cd622d329b0a5b894808daff3191bb9f
AM68-SK Etherent boot:
https://gist.github.com/chintan013/39e67a173327bcbdae1724c35341b445

Andreas Dannenberg (3):
  arm: mach-k3: am62p: Update SoC auto-gen data to enable CPSW boot
  board: ti: am62px: evm: Enable cache for AM62p
  configs: am62p: Add configs for enabling ETHBOOT in R5SPL

Chintan Vankar (10):
  net: tftp: Increase TFTP pkt string length to include null character
  arm: mach-k3: j721s2: Update SoC auto-gen data to enable Ethernet boot
  arm: mach-k3: j721s2_spl: Alias Ethernet boot to CPGMAC
  arm: mach-k3: j721s2_init: Probe AM65 CPSW NUSS for R5/A72 SPL
  configs: am68: Add configs for enabling Ethboot in R5SPL
  configs: am68: Enable configs required for Ethernet boot
  arm: dts: k3-am68-sk-base-board-u-boot: Add bootph-all property to
    necessary nodes
  arm: mach-k3: am62p5_init: Probe AM65 CPSW NUSS for R5/A53 SPL
  configs: am62p: Enable configs required for Ethboot
  arch: arm: dts: k3-am62p5-sk-u-boot: Add bootph-all property to
    necessary nodes

 arch/arm/dts/k3-am62p5-sk-u-boot.dtsi         | 32 ++++++++
 .../arm/dts/k3-am68-sk-base-board-u-boot.dtsi | 28 +++++++
 arch/arm/mach-k3/am62px/am62p5_init.c         | 10 +++
 arch/arm/mach-k3/include/mach/j721s2_spl.h    |  1 +
 arch/arm/mach-k3/j721s2/j721s2_init.c         | 10 +++
 arch/arm/mach-k3/r5/am62px/clk-data.c         | 44 +++++++++-
 arch/arm/mach-k3/r5/am62px/dev-data.c         | 24 +++---
 arch/arm/mach-k3/r5/j721s2/clk-data.c         | 58 +++++++++++++-
 arch/arm/mach-k3/r5/j721s2/dev-data.c         |  3 +-
 board/ti/am62px/evm.c                         |  8 ++
 configs/am62px_evm_a53_ethboot_defconfig      | 17 ++++
 configs/am62px_evm_r5_ethboot_defconfig       | 35 ++++++++
 configs/am68_sk_a72_ethboot_defconfig         | 18 +++++
 configs/am68_sk_r5_ethboot_defconfig          | 80 +++++++++++++++++++
 net/tftp.c                                    |  6 +-
 15 files changed, 353 insertions(+), 21 deletions(-)
 create mode 100644 configs/am62px_evm_a53_ethboot_defconfig
 create mode 100644 configs/am62px_evm_r5_ethboot_defconfig
 create mode 100644 configs/am68_sk_a72_ethboot_defconfig
 create mode 100644 configs/am68_sk_r5_ethboot_defconfig

-- 
2.34.1

