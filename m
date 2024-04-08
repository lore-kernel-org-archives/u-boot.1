Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28666CD1292
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 22:54:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CD8B882EB;
	Tue,  9 Apr 2024 00:46:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LkIBobcV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A44A880FE; Tue,  9 Apr 2024 00:17:53 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16B2B880F9
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 00:17:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 438MHi2L038039;
 Mon, 8 Apr 2024 17:17:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712614664;
 bh=SVnd3Kq2oDx9BvR3phRHi1liNCNfP/Uc48G3/dl/O7Y=;
 h=From:To:CC:Subject:Date;
 b=LkIBobcVsyOdpkSALoPn2HJQZJAkCT0d4PEVKA6j3iAEUvN/wzdp7d9v6BGtWKkrb
 orJ+Kn6ZGdLG7mYELtoXp1gaBU1xpYobMYZKxoZLBM25otnWxgMOHikzwvOBAWomCV
 DtwI6ld1a+BNBWdKfoOL6SHvCbGvJ9pgR78cxt8c=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 438MHiBj105126
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 8 Apr 2024 17:17:44 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Apr 2024 17:17:44 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Apr 2024 17:17:44 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 438MHiaw002262;
 Mon, 8 Apr 2024 17:17:44 -0500
From: Jonathan Humphreys <j-humphreys@ti.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Roger Quadros
 <rogerq@kernel.org>, Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Simon Glass <sjg@chromium.org>, Andrew Davis
 <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Bryan Brattlof
 <bb@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon
 <nm@ti.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Jonathan Humphreys <j-humphreys@ti.com>
Subject: [PATCH 0/7] binman: ti: create binman nodes for EFI capsules
Date: Mon, 8 Apr 2024 17:17:28 -0500
Message-ID: <20240408221735.164871-1-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Tue, 09 Apr 2024 00:46:15 +0200
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

Add binman nodes for EFI capsules of firmware components.

This is enabled for several TI SoC based platforms: AM64, AM62, AM62p,
BeaglePlay, J7, and BeagleboneAI.

Jonathan Humphreys (7):
  dts: ti: binman: Add base K3 firmware capsule nodes
  dts: am64x: binman: Include base K3 firmware capsule binman nodes
  dts: j721e: binman: Include firmware capsules binman nodes
  dts: beagleplay: binman: Include firmware capsules binman nodes
  dts: am62px: binman: Include base K3 firmware capsule binman nodes
  dts: am62x: binman: Include base K3 firmware capsule binman nodes
  dts: beagleboneai64: binman: Include firmware capsules binman nodes

 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi  |  9 ++++
 arch/arm/dts/k3-am625-r5-beagleplay.dts       |  5 +++
 arch/arm/dts/k3-am625-sk-binman.dtsi          |  5 +++
 arch/arm/dts/k3-am62p-sk-binman.dtsi          |  4 ++
 arch/arm/dts/k3-am64x-binman.dtsi             |  5 +++
 arch/arm/dts/k3-binman-capsule-r5.dtsi        | 24 +++++++++++
 arch/arm/dts/k3-binman-capsule.dtsi           | 42 +++++++++++++++++++
 .../dts/k3-j721e-beagleboneai64-u-boot.dtsi   |  9 ++++
 arch/arm/dts/k3-j721e-binman.dtsi             | 32 ++++++++++++++
 arch/arm/dts/k3-j721e-r5-beagleboneai64.dts   | 22 ++++++++++
 10 files changed, 157 insertions(+)
 create mode 100644 arch/arm/dts/k3-binman-capsule-r5.dtsi
 create mode 100644 arch/arm/dts/k3-binman-capsule.dtsi

-- 
2.34.1

