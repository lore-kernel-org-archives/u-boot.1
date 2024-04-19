Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5BCC4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 21:30:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B731886B2;
	Fri, 19 Apr 2024 23:29:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZVS4o7Dd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF07F88682; Fri, 19 Apr 2024 23:29:26 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 904A0885E5
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 23:29:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43JLTBdx126381;
 Fri, 19 Apr 2024 16:29:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1713562151;
 bh=vOouQbECB7vqBefwxJCSt+ijzQkxwrTb/EuRmfzlb3Q=;
 h=From:To:CC:Subject:Date;
 b=ZVS4o7Dd33AZ/3w0jcI5TW3vPRLFbfpAFTjaDYi5FlS4Aj4lvM72dY8gA/8v1BmMm
 2Gnef3QATnqZHNxx9zrI5IyZNcOSoIJHHkDZKWzz/8wE2ESCOMw5wv4hV+7oJlMUaX
 u3Be6+u0u6AlSUzMrh1jTlloPTfRd+5MmvPExZ9c=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43JLTBqh098849
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 19 Apr 2024 16:29:11 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 19
 Apr 2024 16:29:11 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 19 Apr 2024 16:29:11 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43JLTBFA013829;
 Fri, 19 Apr 2024 16:29:11 -0500
From: Jonathan Humphreys <j-humphreys@ti.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Kamlesh Gurudasani
 <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Judith Mendez <jm@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Simon Glass <sjg@chromium.org>,
 Nikhil M Jain <n-jain1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Maxime Ripard
 <mripard@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>, Jonathan Humphreys <j-humphreys@ti.com>
Subject: [PATCH v2 0/7] binman: ti: create binman nodes for EFI capsules
Date: Fri, 19 Apr 2024 16:28:12 -0500
Message-ID: <20240419212819.170033-1-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
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

Add binman nodes for EFI capsules of firmware components so that capsules are
automatically created during the UBoot builds.

This is enabled for several TI SoC based platforms: AM64, AM62, AM62p,
BeaglePlay, J7, and BeagleboneAI.

Changes from v1:
- on GP devices, still use signed images in capsules where available
- Insert board specific capsule GUIDs into the capsule node's image-guid.

Jonathan Humphreys (7):
  dts: ti: binman: Add base K3 firmware capsule nodes
  dts: am64x: binman: Include firmware capsules binman nodes
  dts: j721e: binman: Include firmware capsules binman nodes
  dts: beagleplay: binman: Include firmware capsules binman nodes
  dts: am62px: binman: Include firmware capsules binman nodes
  dts: am62x: binman: Include firmware capsules binman nodes
  dts: beagleboneai64: binman: Include firmware capsules binman nodes

 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi  | 27 ++++++++++
 arch/arm/dts/k3-am625-r5-beagleplay.dts       | 15 ++++++
 arch/arm/dts/k3-am625-sk-binman.dtsi          | 30 ++++++++++++
 arch/arm/dts/k3-am62p-sk-binman.dtsi          | 29 +++++++++++
 arch/arm/dts/k3-am64x-binman.dtsi             | 30 ++++++++++++
 arch/arm/dts/k3-binman-capsule-r5.dtsi        | 21 ++++++++
 arch/arm/dts/k3-binman-capsule.dtsi           | 38 ++++++++++++++
 .../dts/k3-j721e-beagleboneai64-u-boot.dtsi   | 23 +++++++++
 arch/arm/dts/k3-j721e-binman.dtsi             | 49 +++++++++++++++++++
 arch/arm/dts/k3-j721e-r5-beagleboneai64.dts   | 29 +++++++++++
 10 files changed, 291 insertions(+)
 create mode 100644 arch/arm/dts/k3-binman-capsule-r5.dtsi
 create mode 100644 arch/arm/dts/k3-binman-capsule.dtsi

-- 
2.34.1

