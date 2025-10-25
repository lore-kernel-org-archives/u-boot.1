Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B024DCCF9E0
	for <u-boot@archiver.kernel.org>; Sat, 25 Oct 2025 02:48:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92AEA838D2;
	Sat, 25 Oct 2025 04:48:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lr2wfrkd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FBAD838BB; Sat, 25 Oct 2025 04:48:38 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58EA8836A3
 for <u-boot@lists.denx.de>; Sat, 25 Oct 2025 04:48:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59P2mXTX873149;
 Fri, 24 Oct 2025 21:48:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1761360513;
 bh=OpmL5+XvSiruSUebduF2rwd6gMNtifCSADbGLAH9evM=;
 h=From:Subject:Date:To:CC;
 b=lr2wfrkdP4CJg+M2eYsikHOUQUEI5eKD/spUbS/wKY4B8St6ipmYxq8mtapgDRd/y
 ybZsJfB03tzbgsCmQUYFEhbVMUFQ92htIZ/2Zgl8A1EOCTVbLWI/3D67ovgCXrzJgI
 a0hsg7MzNCb2uSLCjMNrwF7cjwzM5iqHgKr/kX+I=
Received: from DFLE204.ent.ti.com (dfle204.ent.ti.com [10.64.6.62])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59P2mXHb4007247
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 24 Oct 2025 21:48:33 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Oct
 2025 21:48:33 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Oct 2025 21:48:33 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59P2mWWl1259290;
 Fri, 24 Oct 2025 21:48:32 -0500
From: Anshul Dalal <anshuld@ti.com>
Subject: [PATCH v3 0/5] Add support for TI AM6254atl SiP
Date: Sat, 25 Oct 2025 08:18:06 +0530
Message-ID: <20251025-62sip_support-v3-0-b4c8314d0055@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGY6/GgC/3WOzWrDMBCEX8XoXJXdldZ2cup7lFL0s250SOxKi
 mkJfveqDpRS6HEGvm/mporkJEUdu5vKsqaS5ksL5qFT4eQub6JTbFkRECMQ6Z5KWl7LdVnmXLU
 3EMX2bA5DVI1ZskzpY/c9v9xzlvdr09Z7qbwrosN8Pqd67DxCAOZoBT0jG2cMuh5lGsmxh1Z6b
 4Nl9e06pVLn/LlfXXGX/fNqRQ1aJMIYkWXo41NNj21z16z0G7V/UWoomWgPdnTTAOEH3bbtC9b
 ieLwuAQAA
X-Change-ID: 20251022-62sip_support-b30de465397d
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Beleswar Padhi <b-padhi@ti.com>, Nishanth
 Menon <nm@ti.com>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, Vignesh R <vigneshr@ti.com>,
 Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761360511; l=3424;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=5iPMtFQmkW2tSlelE8aHoKVZH0kC3OzQkL99aMUUnK8=;
 b=ccVujgU4LtKVSqHEkKwIqnbgT6r1esFGu88grzySqRsG8piRrglKwjpQZVcRTDdq2fTdXc/O9
 KZOfrEEaSGJCYorjxpIik9DfojvskmptQ0/mCbSTf8F3nScMzf9lxKD
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
     ||+--- Device Speed Grade (T indicates 1.25GHz on A53 cores)
     |+---- Silicon PG Revision (A indicates SR 1.0)
     +----- Core configuration (4 indicates A53's in Quad core config)

AM62x SiP provides the existing AM62x SoC with 512MiB of DDR
integrated in a single packages. The first 4 patches in the series
are cherry-picked from the devicetree-rebasing repository at
'v6.18-rc2-dts'.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
Changes in v3:
- Squash non cherry-picked commits to 'ti: add support for AM6254atl SiP'
- Link to v2: https://lore.kernel.org/r/20251024-62sip_support-v2-0-23d4948af70c@ti.com

Changes in v2:
- Add a new-line at the end of env file
- Update the dependencies and rebase to master
- Remove bloblist addr from the A53 defconfig
- Link to v1: https://lore.kernel.org/r/20251022-62sip_support-v1-0-eed08d15e76d@ti.com

---
Anshul Dalal (4):
      arm64: dts: ti: k3-am62*: remove SoC dtsi from common dtsi
      arm64: dts: ti: Introduce base support for AM6254atl SiP
      arm64: dts: ti: Add support for AM6254atl SiP SK
      ti: add support for AM6254atl SiP

Beleswar Padhi (1):
      arm64: dts: ti: k3-am6*-boards: Add label to reserved-memory node

 arch/arm/dts/k3-am6254atl-r5-sk.dts                |  102 +
 arch/arm/dts/k3-am6254atl-sip-ddr-lp4-50-800.dtsi  | 2191 ++++++++++++++++++++
 arch/arm/dts/k3-am6254atl-sk-u-boot.dtsi           |   21 +
 board/ti/am62x/MAINTAINERS                         |    2 +
 board/ti/am62x/am6254atl.env                       |   37 +
 configs/am6254atl_evm_a53_defconfig                |   15 +
 configs/am6254atl_evm_r5_defconfig                 |   10 +
 doc/board/ti/am6254atl_sk.rst                      |  308 +++
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
 27 files changed, 3046 insertions(+), 318 deletions(-)
---
base-commit: b10c055d4e1b5153a331a61ef82a5b01b5bb4c45
change-id: 20251022-62sip_support-b30de465397d

Best regards,
-- 
Anshul Dalal <anshuld@ti.com>

