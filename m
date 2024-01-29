Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E44C47DA9
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 09:13:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3011587CD1;
	Mon, 29 Jan 2024 10:13:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="ULs2+JtM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D79D287CE9; Mon, 29 Jan 2024 10:13:24 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAFBE877E2
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 10:13:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1706519602; x=1709111602;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3xYS3Lan1k3yh2pEbN1kVN5BEOmFsU+X5zibbqyq1lE=;
 b=ULs2+JtMrp9sIthhH+w2kcp+OvcKl9O661h+LT+w5/MgcCLyQ9F/p3UM1JHiAQ0s
 MC87DaDlLlJ53go7AeJde+vGmZv1dJm+mFtnl8I522clcCJIREf/BKXn/0qzBr9X
 P19POXOxa5RN1mKU/FIqu8VT2hZoLfBjVufl7aYw0do=;
X-AuditID: ac14000a-fadff7000000290d-15-65b76c32cb84
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 96.62.10509.23C67B56;
 Mon, 29 Jan 2024 10:13:22 +0100 (CET)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 29 Jan
 2024 10:13:22 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>
CC: <nm@ti.com>, <d-gole@ti.com>, <trini@konsulko.com>,
 <upstream@lists.phytec.de>
Subject: [PATCH 0/2] *** Add support for phyCORE-AM64x ***
Date: Mon, 29 Jan 2024 10:13:12 +0100
Message-ID: <20240129091314.925120-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLMWRmVeSWpSXmKPExsWyRpKBR9coZ3uqwfMjOhYtaz0s3vw4y2Qx
 ddJmdou3ezvZLbrfqTuwerw6sIrd4+ydHYwe/d0trB7Hb2xnCmCJ4rJJSc3JLEst0rdL4Mro
 PbiLvaBLtOLs5QmMDYzTBLsYOTgkBEwkVvyy6GLk5BASWMwkMf+6fxcjF5D9mFFizf1XzCAJ
 NgF1iTsbvrGC2CICUhIvOzeCxZkFQiQWXpvBDmILC1hJ7G/pArNZBFQldizYAlbDK2Ah8XHm
 Y7BeCQF5iZmXvrNDxAUlTs58wgIxR16ieetsqJkSEgdfvGCGOEhe4sWl5SwwvdPOvWaGsEMl
 jmxazTSBUWAWklGzkIyahWTUAkbmVYxCuZnJ2alFmdl6BRmVJanJeimpmxhBwSvCwLWDsW+O
 xyFGJg7GQ4wSHMxKIrw/NbemCvGmJFZWpRblxxeV5qQWH2KU5mBREudd3RGcKiSQnliSmp2a
 WpBaBJNl4uCUamBskxQr/jYhbk3Q6qJ/bC6f31RmdZd+OxDAwM9mohvyZNKL9TMPex3unC2R
 /mPZw/KFy88mHzghcfnW9Z64kCyJ+rv68QJ3uc+57Sp0LMsU2Nz2W/vNme8bT2/u3Mz09avh
 97drZf0O5TorThPo6X+1Vmkpo9f6lqIvXfzx7xRUsp3c039kukcpsRRnJBpqMRcVJwIAMfYk
 TkwCAAA=
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

Add basic support for the phyCORE-AM64x..

Wadim Egorov (2):
  board: phytec: am64x: Add PHYTEC phyCORE-AM64x SoM
  doc: board: phytec: Add phyCORE-AM64x

 arch/arm/dts/Makefile                         |    4 +-
 .../arm/dts/k3-am64-phycore-som-ddr4-2gb.dtsi | 2189 +++++++++++++++++
 arch/arm/dts/k3-am64-phycore-som.dtsi         |  320 +++
 .../k3-am642-phyboard-electra-rdk-u-boot.dtsi |  147 ++
 .../arm/dts/k3-am642-phyboard-electra-rdk.dts |  302 +++
 arch/arm/dts/k3-am642-phycore-som-binman.dtsi |  457 ++++
 arch/arm/dts/k3-am642-r5-phycore-som-2gb.dts  |  140 ++
 arch/arm/mach-k3/am64x/Kconfig                |   19 +
 board/phytec/phycore_am64x/Kconfig            |   33 +
 board/phytec/phycore_am64x/MAINTAINERS        |   15 +
 board/phytec/phycore_am64x/Makefile           |    9 +
 board/phytec/phycore_am64x/board-cfg.yaml     |   36 +
 board/phytec/phycore_am64x/phycore-am64x.c    |   50 +
 board/phytec/phycore_am64x/phycore_am64x.env  |   23 +
 board/phytec/phycore_am64x/pm-cfg.yaml        |   12 +
 board/phytec/phycore_am64x/rm-cfg.yaml        | 1215 +++++++++
 board/phytec/phycore_am64x/sec-cfg.yaml       |  379 +++
 configs/phycore_am64x_a53_defconfig           |  168 ++
 configs/phycore_am64x_r5_defconfig            |  180 ++
 doc/board/phytec/index.rst                    |    1 +
 doc/board/phytec/phycore-am64x.rst            |  159 ++
 include/configs/phycore_am64x.h               |   15 +
 22 files changed, 5872 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/k3-am64-phycore-som-ddr4-2gb.dtsi
 create mode 100644 arch/arm/dts/k3-am64-phycore-som.dtsi
 create mode 100644 arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi
 create mode 100644 arch/arm/dts/k3-am642-phyboard-electra-rdk.dts
 create mode 100644 arch/arm/dts/k3-am642-phycore-som-binman.dtsi
 create mode 100644 arch/arm/dts/k3-am642-r5-phycore-som-2gb.dts
 create mode 100644 board/phytec/phycore_am64x/Kconfig
 create mode 100644 board/phytec/phycore_am64x/MAINTAINERS
 create mode 100644 board/phytec/phycore_am64x/Makefile
 create mode 100644 board/phytec/phycore_am64x/board-cfg.yaml
 create mode 100644 board/phytec/phycore_am64x/phycore-am64x.c
 create mode 100644 board/phytec/phycore_am64x/phycore_am64x.env
 create mode 100644 board/phytec/phycore_am64x/pm-cfg.yaml
 create mode 100644 board/phytec/phycore_am64x/rm-cfg.yaml
 create mode 100644 board/phytec/phycore_am64x/sec-cfg.yaml
 create mode 100644 configs/phycore_am64x_a53_defconfig
 create mode 100644 configs/phycore_am64x_r5_defconfig
 create mode 100644 doc/board/phytec/phycore-am64x.rst
 create mode 100644 include/configs/phycore_am64x.h

-- 
2.34.1

