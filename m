Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545EEC3064D
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 09:33:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A529A88590;
	Fri, 28 Jun 2024 11:33:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="j1qhtrTf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D573987D40; Fri, 28 Jun 2024 11:33:29 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 516B788286
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 11:33:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45S9XJOp028109;
 Fri, 28 Jun 2024 04:33:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1719567199;
 bh=oJ/iJvNFbPXAOY4o/VZ+WuLWRJ4SKHBfadWtXzJOjFE=;
 h=From:To:CC:Subject:Date;
 b=j1qhtrTfGHXtS6T7/MAxJI0Niqkh4VAfaekXwxA1VJw3hETVTGXz2sN5G76KfKL53
 nqaRzVDReSfQ+NutL6TWqTYPVj2Tw+CKssWjp5KLalwuksCW1ohbjpSOktQ+MHS7o7
 Bw3K5eIO7bITE3mTwHJOCKasGSq05Z4TOL2VakfQ=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45S9XJ7U127706
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 28 Jun 2024 04:33:19 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jun 2024 04:33:19 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jun 2024 04:33:19 -0500
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45S9XFW7088895;
 Fri, 28 Jun 2024 04:33:16 -0500
From: Dhruva Gole <d-gole@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Nishant
 Menon <nm@ti.com>, <c-shilwant@ti.com>, <m-chawdhry@ti.com>,
 <vigneshr@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Vibhore Vardhan
 <vibhore@ti.com>, Vishal Mahaveer <vishalm@ti.com>, Dhruva Gole
 <d-gole@ti.com>
Subject: [PATCH V3 0/4] Low Power Mode: Pakage TIFS Stub on BeaglePlay
Date: Fri, 28 Jun 2024 15:02:48 +0530
Message-ID: <20240628093252.1864609-1-d-gole@ti.com>
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

This series includes the binman related changes required to package tIFS
Stub to support Low Power Modes on BeaglePlay.
Also, based on comments from previous patch [0] documentation has been
added to describe small addition in boot flow as well as tispl image
format.

I am aware that the new boot flow image will need to be updated in
other places like am62a, am62p and even other boards that use am62x.
However, I would like to keep this series beagleplay TIFSStub specific
and so I will be sending a follow up series to update other places
seperately if that's ok.

Changelog:
* Add new image format for TISPL
* Add new changes in boot flow for am62 family of devices.

[0] https://lore.kernel.org/u-boot/20240618045610.271884-1-d-gole@ti.com/

Dhruva Gole (4):
  arm: dts: k3-am625-beagleplay: Package TIFS Stub
  doc: beagle: am62x_beagleplay: Update the boot flow to show TIFS Stub
  doc: beagle: am62x_beagleplay: Add TIFS Stub in image format
  doc: ti: k3: Add TIFS Stub documentation

 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 33 +++++++++++++++++++-
 doc/board/beagle/am62x_beagleplay.rst        |  4 +--
 doc/board/ti/img/boot_diagram_am62.svg       |  4 +++
 doc/board/ti/img/tifsstub_dm_tispl.bin.svg   |  4 +++
 doc/board/ti/k3.rst                          |  5 +++
 5 files changed, 47 insertions(+), 3 deletions(-)
 create mode 100644 doc/board/ti/img/boot_diagram_am62.svg
 create mode 100644 doc/board/ti/img/tifsstub_dm_tispl.bin.svg


base-commit: c53b344475734d0d29f522b7b1d80c5b8204442d
-- 
2.34.1

