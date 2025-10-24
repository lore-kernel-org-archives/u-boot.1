Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C389ACCD1A5
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 08:33:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F66B8362A;
	Fri, 24 Oct 2025 10:33:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bf5gHuHx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AD018362A; Fri, 24 Oct 2025 10:33:28 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA2058331F
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 10:33:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59O8XNVm721634;
 Fri, 24 Oct 2025 03:33:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1761294803;
 bh=jja/QN+YLAuOuBhksgujwehA3iUxemhpFE9GtMErm1I=;
 h=From:Subject:Date:To:CC;
 b=bf5gHuHxu3VdWxCYb/meRr20Qb+Oc0Z8FAKTDu91d+x6pluFj7LK69xSrNQ7eZ8k2
 CizLBQO0/qr7j9Ht6oZXjTIMnm+2rz17piBtwaldJNlQWYb6qobbVsJ1jNnbE2eSbY
 aAVqSD2xKWhMPmLeXcwXQpEHmk9/rkd6NoRzT0DU=
Received: from DFLE207.ent.ti.com (dfle207.ent.ti.com [10.64.6.65])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59O8XNWT3755356
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 24 Oct 2025 03:33:23 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Oct
 2025 03:33:23 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Oct 2025 03:33:23 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59O8XLvh059190;
 Fri, 24 Oct 2025 03:33:22 -0500
From: Anshul Dalal <anshuld@ti.com>
Subject: [PATCH v2 0/8] Add support for TI AM6254atl SiP
Date: Fri, 24 Oct 2025 14:02:54 +0530
Message-ID: <20251024-62sip_support-v2-0-23d4948af70c@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALY5+2gC/3WOSw7CMAxEr1J5TVCc1OWz4h6oQkljwAtoSUIFq
 np3QlmzfCPNm5kgcRROsK8miDxKkv5ewKwq6K7ufmEloTAYbQi1MaoxSYZTeg5DH7PyVgeuG7K
 7TYDSGSKf5bX4ju2PIz+eRZt/IXiXWHX97SZ5X3nUnSYKNaMnJOusRdcgn7fGkdcl9L7uaoKv6
 yop9/G9XB1xkf15NaLSijnobUDiTRMOWdZlE9p5nj8//8CZ8wAAAA==
X-Change-ID: 20251022-62sip_support-b30de465397d
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Beleswar Padhi <b-padhi@ti.com>, Nishanth
 Menon <nm@ti.com>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, Vignesh R <vigneshr@ti.com>,
 Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761294801; l=3396;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=XS2ymzLLDiOlvvvfuunhIfW1KigMhEXtrh8QQOImIVY=;
 b=8jO8F6RuLZF8D185zWjdaJG/otFscPhg81HMApm3SOz/gGDG0pn/gY14du56TO6rTJnC2gwYt
 F+EWxSaruVFAoC7dd3c5BLzxJsm6lICFnIfgTwOCgrmgcLBaLD8BGVA
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
Changes in v2:
- Add a new-line at the end of env file
- Update the dependencies and rebase to master
- Remove bloblist addr from the A53 defconfig
- Link to v1:
https://lore.kernel.org/r/20251022-62sip_support-v1-0-eed08d15e76d@ti.com

---
Anshul Dalal (7):
      arm64: dts: ti: k3-am62*: remove SoC dtsi from common dtsi
      arm64: dts: ti: Introduce base support for AM6254atl SiP
      arm64: dts: ti: Add support for AM6254atl SiP SK
      arm: dts: add support for AM6254atl at R5 SPL
      configs: add defconfigs for AM6254atl
      board: am62x: add env file for AM6254atl
      doc: add documentation for AM6254atl SiP

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

