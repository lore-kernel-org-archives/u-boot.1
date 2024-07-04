Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296ABC3065C
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 08:43:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 769CF888BC;
	Thu,  4 Jul 2024 10:43:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Xqt0EiYG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1200888BF; Thu,  4 Jul 2024 10:43:35 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4145C88679
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 10:43:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4648hU2H041362;
 Thu, 4 Jul 2024 03:43:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1720082610;
 bh=/y+rMzMCJGCO2F9EMbhp2UvWeYf4cHveMqEQ9pmIusA=;
 h=From:To:CC:Subject:Date;
 b=Xqt0EiYGoiiodayd/34DktXAUTN8bqtsEb41qy+Om3ujazY5Zvf1K2UXE9QA8lSQM
 5RGtj36FEXWHaSZq1vKfacXDb8ZoHL2jNxleW6Zm168qHAt8FOIwEsXce6rw/pUYzU
 +/+LiRg2QTkN8YjSj53MDfXf5WsdoNVOibocDN5g=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4648hUmi038716
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 4 Jul 2024 03:43:30 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Jul 2024 03:43:29 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Jul 2024 03:43:29 -0500
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4648hPV4010413;
 Thu, 4 Jul 2024 03:43:25 -0500
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
Subject: [PATCH V4 0/6] Low Power Mode: Package TIFS Stub in BeaglePlay
Date: Thu, 4 Jul 2024 14:12:02 +0530
Message-ID: <20240704084207.2211801-1-d-gole@ti.com>
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
* Add more documentation around TIFS Stub for AM62, 62A and 62P
* Fix documentation formatting errors.
* Add entry to MAINTAINERS for doc/board/ti

Link to previous series:
https://lore.kernel.org/u-boot/20240628093252.1864609-1-d-gole@ti.com/

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
 doc/board/ti/k3.rst                          |    5 +
 9 files changed, 2382 insertions(+), 9 deletions(-)
 create mode 100644 doc/board/ti/img/boot_diagram_am62.svg
 create mode 100644 doc/board/ti/img/tifsstub_dm_tispl.bin.svg


base-commit: 0f073e022ddc5070e5df1d053e4bdc1874fbcc0f
-- 
2.34.1

