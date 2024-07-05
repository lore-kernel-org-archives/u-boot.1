Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 325A6C3271E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 16:49:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AC3C8899C;
	Fri,  5 Jul 2024 18:49:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FGmRNaN5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68752889AA; Fri,  5 Jul 2024 18:49:00 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4C6A88905
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 18:48:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 465GmnBm003405;
 Fri, 5 Jul 2024 11:48:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1720198129;
 bh=rYMMpO1/0lefTIhjTdN7gbOnDXTafRfoeo1IQItZiG4=;
 h=From:To:CC:Subject:Date;
 b=FGmRNaN5xetmwvkdQ3A+ahcSQgnzftuiDd5+JpR/jACA/dra3Hvg1JI5rs4T1YYQ9
 HZ5w2CaO68BOntUg1tldI6+276NbxcVjElXXBAmARyKIZdKD1ie9tAR9hHpaxC71A6
 H75cufbQl2m2Eekbsu1777yzSN/DhJnz1KVFxPmw=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 465GmnnV113248
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 5 Jul 2024 11:48:49 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 Jul 2024 11:48:48 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 Jul 2024 11:48:48 -0500
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 465Gmhcx028675;
 Fri, 5 Jul 2024 11:48:44 -0500
From: Dhruva Gole <d-gole@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Nishant
 Menon <nm@ti.com>, <c-shilwant@ti.com>, <m-chawdhry@ti.com>,
 <vigneshr@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Vibhore Vardhan
 <vibhore@ti.com>, Vishal Mahaveer <vishalm@ti.com>, Sebin Francis
 <sebin.francis@ti.com>,
 Wadim Egorov <w.egorov@phytec.de>, <t.remmet@phytec.de>,
 <mkorpershoek@baylibre.com>, Daniel Schultz <d.schultz@phytec.de>,
 Dhruva Gole <d-gole@ti.com>
Subject: [PATCH V5 0/6] Low Power Mode: Package TIFS Stub in BeaglePlay
Date: Fri, 5 Jul 2024 22:18:27 +0530
Message-ID: <20240705164833.2386549-1-d-gole@ti.com>
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

This series includes the binman related changes required to package TIFS
Stub to support Low Power Modes on BeaglePlay.
It also documents the boot flow and tispl packaging details regarding
the same.

Changelog:
* Add more documentation around last time's discussion[1] on packaging TIFS
  Stub in DM.

Link to previous series:
https://lore.kernel.org/u-boot/20240704084207.2211801-1-d-gole@ti.com/

[1] https://lore.kernel.org/u-boot/20240705151753.7v3geqkupqu673x3@ambiance/

Thanks for the explanation given in [1] Sebin,
Cc: Sebin Francis <sebin.francis@ti.com>

Dhruva Gole (6):
  arm: dts: k3-am625-beagleplay: Package TIFS Stub
  doc: beagle: am62x_beagleplay: Update the boot flow to show TIFS Stub
  doc: beagle: am62x_beagleplay: Add TIFS Stub in image format
  doc: ti: k3: Add TIFS Stub documentation
  doc: ti: am62*: Mention TIFS Stub in img fmts and boot flow
  MAINTAINERS: Include the TI docs under ARM TI

 MAINTAINERS                                  |    1 +
 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi |   33 +-
 doc/board/beagle/am62x_beagleplay.rst        |    4 +-
 doc/board/ti/am62ax_sk.rst                   |    4 +-
 doc/board/ti/am62px_sk.rst                   |    4 +-
 doc/board/ti/am62x_sk.rst                    |    4 +-
 doc/board/ti/img/boot_diagram_am62.svg       | 1983 ++++++++++++++++++
 doc/board/ti/img/tifsstub_dm_tispl.bin.svg   |  353 ++++
 doc/board/ti/k3.rst                          |   11 +
 9 files changed, 2388 insertions(+), 9 deletions(-)
 create mode 100644 doc/board/ti/img/boot_diagram_am62.svg
 create mode 100644 doc/board/ti/img/tifsstub_dm_tispl.bin.svg


base-commit: a9b3723e74aacb5197dc77c9979036dc6b3d9c03
-- 
2.34.1

