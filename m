Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE80CCD1AB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 10:26:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A130583303;
	Wed, 22 Oct 2025 12:26:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qEkP5j7c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8613B8323A; Wed, 22 Oct 2025 12:26:17 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 528308323A
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 12:26:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59MAQBfM1381905;
 Wed, 22 Oct 2025 05:26:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1761128771;
 bh=BCeVe5VL9k+iutvZf40+bvWF0xRa02QuCUWj3j6RKwg=;
 h=From:Subject:Date:To:CC;
 b=qEkP5j7cfKQGakUCwSspjq5za7zeSdybejEVtLKWHP2C8l9ze1fKJGNZoNfyfIzQE
 ZBmzEj2D3qmpWBu4uoK2knjVJhanHlTXMItdsnMMQy74UzdRQuCuDwnnzugzLfgZgc
 yAaIMwZ5CgC+f+rimZGA2LIWzoQdy3IVCvyf3Cig=
Received: from DFLE204.ent.ti.com (dfle204.ent.ti.com [10.64.6.62])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59MAQBpE2281585
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 22 Oct 2025 05:26:11 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 05:26:11 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 22 Oct 2025 05:26:11 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59MAQAu11048426;
 Wed, 22 Oct 2025 05:26:11 -0500
From: Anshul Dalal <anshuld@ti.com>
Subject: [PATCH 0/8] Add support for TI AM6254atl SiP
Date: Wed, 22 Oct 2025 15:55:36 +0530
Message-ID: <20251022-62sip_support-v1-0-eed08d15e76d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACGx+GgC/yXMW2rDMBCF4a0YPVdBI1kj24TSfZRQxtG4EcSXa
 OxSCNl7lPjxP3C+uxLOiUV11V1l/kuS5qkEfFTqfKHpl3WKpZU11oOxVqOVtPzItixzXnXvTOQ
 avWtDVOWzZB7S/9v7Pu2d+bYVdt1HNbIIvdmuOu4qBHDga3Nw6NBg0KBpkst2jV9rOpzn8fNF9
 ySsS4xp7aoGHJk42EANDb4JfbSekOoA7YCNQexdMKYFdXo8nn8D6ZbkAAAA
X-Change-ID: 20251022-62sip_support-b30de465397d
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Beleswar Padhi <b-padhi@ti.com>, Nishanth
 Menon <nm@ti.com>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, Vignesh R <vigneshr@ti.com>,
 Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761128770; l=4147;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=/ijH1/r/xdFdhgmDXTr8mFa8hC/Ov89tkaU+q+v6UB4=;
 b=87E5CAaqSxmV2cprDyOxNv6i71+kQn3Mk6WW0kYOpLJ9Seat7xN+2hBFisS1kjZYsZO4sUpl+
 QOAvHppK164D7sov1YqlQOLMY/Uff4vW9/pypthB7kDpbt0UU70o1By
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
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

Hi all,

This patch series adds support for AM6254atl SiP (or AM62x SiP for
short) to U-Boot.

The OPN (Orderable Part Number) 'AM6254atl' expands as follows[1]:

AM6254atl
     ||||
     |||+-- Feature Lookup (L indicates 512MiB of integrated LPDDR4)
     ||+--- Device Speed Grade (T indicates 1.25GHz/1.4GHz on the A53 cores)
     |+---- Silicon PG Revision (A indicates SR 1.0)
     +----- Core configuration (4 indicates A53's in Quad core config)

AM62x SiP provides the existing AM62x SoC with 512MiB of DDR
integrated in a single packages. The first 4 patches in the series
are cherry-picked from the devicetree-rebasing repository at
'v6.18-rc2-dts'.

Depends on:
 [PATCH v11 00/11] Add support for dynamic MMU configuration
 https://lore.kernel.org/u-boot/20251017131540.3636067-1-anshuld@ti.com/

base-commit: 813a0df27a8af587bd25a6a4719f68066b370091
Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
Anshul Dalal (7):
      arm64: dts: ti: k3-am62*: remove SoC dtsi from common dtsi
      arm64: dts: ti: Introduce base support for AM6254atl SiP
      arm64: dts: ti: Add support for AM6254atl SiP SK
      arm: dts: add support for am6254atl at R5 SPL
      configs: add defconfigs for am6254atl
      board: am62x: add env file for am6254atl
      doc: add documentation for am6254atl SiP

Beleswar Padhi (1):
      arm64: dts: ti: k3-am6*-boards: Add label to reserved-memory node

 arch/arm/dts/k3-am6254atl-r5-sk.dts                |  102 +
 arch/arm/dts/k3-am6254atl-sip-ddr-lp4-50-800.dtsi  | 2191 ++++++++++++++++++++
 arch/arm/dts/k3-am6254atl-sk-u-boot.dtsi           |   21 +
 board/ti/am62x/MAINTAINERS                         |    2 +
 board/ti/am62x/am6254atl.env                       |   37 +
 configs/am6254atl_evm_a53_defconfig                |   16 +
 configs/am6254atl_evm_r5_defconfig                 |   10 +
 doc/board/ti/am6254atl_sk.rst                      |  313 +++
 doc/board/ti/k3.rst                                |    1 +
 dts/upstream/src/arm64/ti/k3-am62-lp-sk.dts        |    8 +
 dts/upstream/src/arm64/ti/k3-am62-verdin.dtsi      |    2 +-
 dts/upstream/src/arm64/ti/k3-am625-sk-common.dtsi  |  296 +++
 dts/upstream/src/arm64/ti/k3-am625-sk.dts          |  301 +--
 dts/upstream/src/arm64/ti/k3-am6254atl-sk.dts      |   15 +
 dts/upstream/src/arm64/ti/k3-am6254atl.dtsi        |   23 +
 .../src/arm64/ti/k3-am62a-phycore-som.dtsi         |    2 +-
 dts/upstream/src/arm64/ti/k3-am62a7-sk.dts         |    2 +-
 dts/upstream/src/arm64/ti/k3-am62d2-evm.dts        |    2 +-
 dts/upstream/src/arm64/ti/k3-am62p-verdin.dtsi     |    2 +-
 dts/upstream/src/arm64/ti/k3-am62p5-sk.dts         |    2 +-
 dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi  |   10 +-
 dts/upstream/src/arm64/ti/k3-am642-evm.dts         |    2 +-
 dts/upstream/src/arm64/ti/k3-am642-sk.dts          |    2 +-
 dts/upstream/src/arm64/ti/k3-am642-sr-som.dtsi     |    2 +-
 dts/upstream/src/arm64/ti/k3-am642-tqma64xxl.dtsi  |    2 +-
 .../src/arm64/ti/k3-am65-iot2050-common.dtsi       |    2 +-
 dts/upstream/src/arm64/ti/k3-am654-base-board.dts  |    2 +-
 27 files changed, 3052 insertions(+), 318 deletions(-)
---
base-commit: 813a0df27a8af587bd25a6a4719f68066b370091
change-id: 20251022-62sip_support-b30de465397d
prerequisite-message-id: <20251017131540.3636067-1-anshuld@ti.com>
prerequisite-patch-id: 1018cc18afaeb7993897c79d04dfa8812c7d461a
prerequisite-patch-id: 47c896471b88586ec5eeaa036d6d317c200fa2ff
prerequisite-patch-id: ef20d522581fc85473d4f2dc3db2e69f24db2335
prerequisite-patch-id: be1a02a345cf90ce9b0adbda7e4c2c6b894cea57
prerequisite-patch-id: 20e5259c6f65feb27061042d51cfbb042690d307
prerequisite-patch-id: c1ae18611c1eebd56a8ccdb187da036be3806328
prerequisite-patch-id: 70e3b998d505a35ce74c53bde99d9b8a55d9ca64
prerequisite-patch-id: f16a9d170e5e4cdad99749aad8b6eb448661e01e
prerequisite-patch-id: 85aab27a129ee0cc9fdf0ccd5252e8631743528b
prerequisite-patch-id: d6ba686cce569f824c84f431bff3bf7cfc68ffbc
prerequisite-patch-id: 17e205969bfccfef6a4c2e45467c09a868d165a2

Best regards,
-- 
Anshul Dalal <anshuld@ti.com>

