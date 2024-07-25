Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFBAC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 09:36:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60B7C8795E;
	Thu, 25 Jul 2024 11:36:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="eXd2ltFD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96CD886D4C; Thu, 25 Jul 2024 11:36:50 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 574DD87E64
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 11:36:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46P9aiIK122037;
 Thu, 25 Jul 2024 04:36:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1721900204;
 bh=1WBDOdzN52orIVnjkmVnxmorVgJyF4QDnPQZjvG9oEc=;
 h=From:To:CC:Subject:Date;
 b=eXd2ltFDzZct3IzLL7X48sjZ3g4kozaULol4SF3sSRUFLBVzOt6D22VtMADmokPnv
 7YRvU1r+fpRdmIIcsG6KUyY4Zw4Q7qRuIwNPvAdqdWffB4WxCFJlT4WWKxorL1g3Eg
 B/9ZBB7em03tCoB//3fbrVERcUB1zEDeb4SlqIgY=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46P9ainI032509
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 25 Jul 2024 04:36:44 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Jul 2024 04:36:44 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Jul 2024 04:36:44 -0500
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46P9ad8R066876;
 Thu, 25 Jul 2024 04:36:40 -0500
From: Dhruva Gole <d-gole@ti.com>
To: Tom Rini <trini@konsulko.com>, Nishant Menon <nm@ti.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>,
 <c-shilwant@ti.com>, <m-chawdhry@ti.com>, <vigneshr@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>,
 Vibhore Vardhan <vibhore@ti.com>, Vishal Mahaveer <vishalm@ti.com>,
 Sebin Francis <sebin.francis@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, <t.remmet@phytec.de>,
 <mkorpershoek@baylibre.com>, Daniel Schultz <d.schultz@phytec.de>,
 Dhruva Gole <d-gole@ti.com>
Subject: [PATCH V7 0/7] Low Power Mode: Package TIFS Stub in BeaglePlay
Date: Thu, 25 Jul 2024 15:05:40 +0530
Message-ID: <20240725093546.4193107-1-d-gole@ti.com>
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

Hello,

This series aims to add documentation around the boot flow and tispl
packaging details regarding the TIFS Stub. While at it, also refactors the
k3 common docs to add more labels to provide more granularity on how we
include chunks from common docs into SoC specific docs.

This series also includes the binman related changes required to package
TIFS Stub to support Low Power Modes on BeaglePlay and phycore-am625 SOM.

Changelog:
**********
* fixup wording of tifs stub docs as per comments from Nishanth on v6.
* Add packaging of tifs stub in phycore am62 as well. (Build-tested)
* Minor fixup in am64-phycore docs include sysfw

Link to v6:
https://lore.kernel.org/all/20240719070312.3771755-1-d-gole@ti.com/


Dhruva Gole (7):
  MAINTAINERS: Include the TI docs under ARM TI
  doc: ti: k3: Add TIFS Stub documentation
  doc: board: ti: Update to use the new boot firmware labels
  doc: ti: am62*: Mention TIFS Stub in img fmts and boot flow
  arm: dts: k3-am625-beagleplay: Package TIFS Stub
  doc: beagle: am62x_beagleplay: Document the use of TIFS Stub
  arm: dts: phycore-am62x: Package TIFS Stub

 MAINTAINERS                                   |    1 +
 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi  |   33 +-
 arch/arm/dts/k3-am625-phycore-som-binman.dtsi |  101 +-
 doc/board/beagle/am62x_beagleplay.rst         |    8 +-
 doc/board/beagle/j721e_beagleboneai64.rst     |    4 +
 doc/board/phytec/phycore-am62x.rst            |    4 +
 doc/board/phytec/phycore-am64x.rst            |    4 +
 doc/board/ti/am62ax_sk.rst                    |    8 +-
 doc/board/ti/am62px_sk.rst                    |    8 +-
 doc/board/ti/am62x_sk.rst                     |    8 +-
 doc/board/ti/am64x_evm.rst                    |    4 +
 doc/board/ti/am65x_evm.rst                    |    4 +
 doc/board/ti/img/boot_diagram_am62.svg        | 1983 +++++++++++++++++
 doc/board/ti/img/tifsstub_dm_tispl.bin.svg    |  353 +++
 doc/board/ti/j7200_evm.rst                    |    4 +
 doc/board/ti/j721e_evm.rst                    |    4 +
 doc/board/ti/j721s2_evm.rst                   |    4 +
 doc/board/ti/j722s_evm.rst                    |    4 +
 doc/board/ti/j784s4_evm.rst                   |    4 +
 doc/board/ti/k3.rst                           |   51 +-
 doc/board/toradex/verdin-am62.rst             |    4 +
 21 files changed, 2571 insertions(+), 27 deletions(-)
 create mode 100644 doc/board/ti/img/boot_diagram_am62.svg
 create mode 100644 doc/board/ti/img/tifsstub_dm_tispl.bin.svg


base-commit: f659ba43837e5ae5a35fdff3736c8e13f9062abd
-- 
2.34.1

