Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54195C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 11:21:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D2F586E7E;
	Mon,  4 Dec 2023 12:21:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vGKg9llh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D92283CF3; Mon,  4 Dec 2023 12:21:56 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1841D875EA
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 12:21:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B4BLkwt062555;
 Mon, 4 Dec 2023 05:21:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701688906;
 bh=J0sIDMOf76Qvc8RPUAI0sG/IOx1jqO9rbtATeELC7AE=;
 h=From:To:CC:Subject:Date;
 b=vGKg9llhtiycXD2KX2415ulATVDchzCnnYfUE15b3AxCa4B+O9VVEW6BbPR3zr4lE
 Kh1c8DvweKI7FmFKU0BH68hBn6/Rbvk5Yq8S9hNbE7x8TQ98hbA7GmiSRd8Ds8hMB3
 DiornDykPPMngNUhSzc8yvr9ZAn77+EaFln0+eGI=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B4BLkwH083025
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 4 Dec 2023 05:21:46 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 4
 Dec 2023 05:21:45 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 4 Dec 2023 05:21:45 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B4BLfit002315;
 Mon, 4 Dec 2023 05:21:42 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <marcel.ziswiler@toradex.com>, <sjg@chromium.org>,
 <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, <hs@denx.de>, <christophe.leroy@csgroup.eu>,
 <mr.bossman075@gmail.com>, <afd@ti.com>, <m-chawdhry@ti.com>,
 <kamlesh@ti.com>, <nm@ti.com>, <c-shilwant@ti.com>, <u-kumar1@ti.com>,
 <n-francis@ti.com>
Subject: [PATCH 0/3] binman: Add support for TI_DM entry
Date: Mon, 4 Dec 2023 16:51:38 +0530
Message-ID: <20231204112141.2036907-1-n-francis@ti.com>
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

This series adds support for the TI_DM entry and moves all K3 platforms
to using the same. With this feature introduced, if TI_DM argument is
provided binman picks the pathname it provides; else, it defaults to
picking up the ti-dm.bin file. This makes it flexible for users to build
tispl.bin with custom DM binaries.

Boot logs:
https://gist.github.com/nehamalcom/37ce8a32e37ddf3e1afcc4c8bd941159

Neha Malcom Francis (3):
  binman: etype: dm: Add entry type for TI DM
  arm: dts: k3-*-binman: Move to using ti-dm entry type
  doc: board: ti: k3: Mention TI_DM argument

 Makefile                                      |  1 +
 arch/arm/dts/k3-am625-sk-binman.dtsi          |  4 ++--
 .../dts/k3-am625-verdin-wifi-dev-binman.dtsi  |  4 ++--
 arch/arm/dts/k3-am62a-sk-binman.dtsi          |  4 ++--
 arch/arm/dts/k3-j7200-binman.dtsi             |  4 ++--
 arch/arm/dts/k3-j721e-binman.dtsi             |  4 ++--
 arch/arm/dts/k3-j721s2-binman.dtsi            |  4 ++--
 doc/board/ti/k3.rst                           |  7 ++++++
 tools/binman/entries.rst                      | 14 ++++++++++++
 tools/binman/etype/ti_dm.py                   | 22 +++++++++++++++++++
 tools/binman/ftest.py                         |  7 ++++++
 tools/binman/test/225_ti_dm.dts               | 13 +++++++++++
 12 files changed, 76 insertions(+), 12 deletions(-)
 create mode 100644 tools/binman/etype/ti_dm.py
 create mode 100644 tools/binman/test/225_ti_dm.dts

-- 
2.34.1

