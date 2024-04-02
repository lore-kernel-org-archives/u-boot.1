Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C0FCD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 16:09:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4C9188153;
	Tue,  2 Apr 2024 18:09:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gp9PpAwF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB29788169; Tue,  2 Apr 2024 18:09:15 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BE3D880BB
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 18:09:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 432G9Amk046259;
 Tue, 2 Apr 2024 11:09:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712074150;
 bh=DMXINa5ggfCvcRQDLpjynk3EOyB6DGvsxoiryhLJ254=;
 h=From:To:CC:Subject:Date;
 b=gp9PpAwF4bCxQs3MwE9vi5AiBvRx5f+t2rOiApVoMZ0gVj360iXZGcO43+08QLPrm
 gd+U4nMxGDXmmaK/3dC8TLICxZHcob7tvdxq67mkSJ79U4BUgPyAeLiacYAmnMGcNB
 MEHYvJ9D7nCOGdoIQa5sgYOtCR1T9k8L80MIlUf8=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 432G9ArP062791
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 2 Apr 2024 11:09:10 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Apr 2024 11:09:10 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Apr 2024 11:09:10 -0500
Received: from fllvsmtp7.itg.ti.com ([10.249.42.149])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 432G99qR029595;
 Tue, 2 Apr 2024 11:09:09 -0500
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH 0/2] Remove ti,sci-sysreset
Date: Tue, 2 Apr 2024 11:09:06 -0500
Message-ID: <20240402160908.508974-1-afd@ti.com>
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

Idea here is to remove one more delta between the U-Boot and Linux
DTB files: ti,sci-sysreset. We currently have to add this to every
board's -u-boot.dtsi file as this is not a standard node. Instead do
what we are moving the kernel towards[0] and remove this node.

Thanks,
Andrew

[0] https://lore.kernel.org/lkml/20240326223730.54639-1-afd@ti.com/

Andrew Davis (2):
  firmware: ti_sci: Bind sysreset driver when enabled
  arm: dts: k3: Remove unneeded ti,sci-sysreset binding and nodes

 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi  |  7 -----
 .../k3-am625-phyboard-lyra-rdk-u-boot.dtsi    |  7 -----
 .../dts/k3-am625-verdin-wifi-dev-u-boot.dtsi  |  7 -----
 arch/arm/dts/k3-am62a7-sk-u-boot.dtsi         |  4 ---
 arch/arm/dts/k3-am62p5-sk-u-boot.dtsi         |  5 ----
 arch/arm/dts/k3-am642-evm-u-boot.dtsi         |  7 -----
 .../k3-am642-phyboard-electra-rdk-u-boot.dtsi |  4 ---
 arch/arm/dts/k3-am642-sk-u-boot.dtsi          |  7 -----
 .../dts/k3-am65-iot2050-common-u-boot.dtsi    |  4 ---
 .../arm/dts/k3-am68-sk-base-board-u-boot.dtsi |  4 ---
 arch/arm/dts/k3-am69-sk-u-boot.dtsi           |  7 -----
 .../k3-j7200-common-proc-board-u-boot.dtsi    |  4 ---
 .../dts/k3-j721e-beagleboneai64-u-boot.dtsi   |  4 ---
 .../k3-j721e-common-proc-board-u-boot.dtsi    |  4 ---
 arch/arm/dts/k3-j721e-sk-u-boot.dtsi          |  4 ---
 .../k3-j721s2-common-proc-board-u-boot.dtsi   |  4 ---
 arch/arm/dts/k3-j784s4-evm-u-boot.dtsi        |  7 -----
 .../sysreset/ti,sci-sysreset.txt              | 29 -------------------
 drivers/firmware/ti_sci.c                     |  7 +++++
 drivers/sysreset/sysreset-ti-sci.c            |  6 ----
 20 files changed, 7 insertions(+), 125 deletions(-)
 delete mode 100644 doc/device-tree-bindings/sysreset/ti,sci-sysreset.txt

-- 
2.39.2

