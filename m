Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10EB1C4167B
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 15:33:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DE348754A;
	Fri,  8 Dec 2023 16:33:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="cXOxmgVJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4547B875A0; Fri,  8 Dec 2023 16:33:22 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08BED87536
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 16:33:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1702049599; x=1704641599;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zyGrAc+2LS7X4+ksm0pipOpS5QiFmd3kIZSyJ4oypvY=;
 b=cXOxmgVJH9HkMdOIuHbIrGATjQyxyzqHOZ7fwP7gDUu//hExZj4Yk/sxeV2OLjfQ
 puqkZGKJ5S+4V9H4eHlOPy3V7a2iq1bND13AM7xj7g5SqWTzgTJtKaCiknxjgkLP
 V5bSMKAusHLjS6IIL4GkXJ90rnOzof41ALUTtrgEVLs=;
X-AuditID: ac14000a-fbefe7000000290d-35-6573373f102d
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 3C.A0.10509.F3733756;
 Fri,  8 Dec 2023 16:33:19 +0100 (CET)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 8 Dec 2023
 16:33:19 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>, <nm@ti.com>, <trini@konsulko.com>
Subject: [PATCH v3 0/2] *** Add support for phyCORE-AM62x ***
Date: Fri, 8 Dec 2023 16:33:09 +0100
Message-ID: <20231208153311.2422720-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsWyRpKBR9fevDjV4ORzNYs3P84yWUydtJnd
 4u3eTnaL7nfqDiwerw6sYvc4e2cHo0d/dwurx/Eb25kCWKK4bFJSczLLUov07RK4Mia/vshc
 cF684s/HdpYGxi7hLkZODgkBE4lPf8+zgthCAouZJN7Oju9i5AKyHzFKLG+ewgSSYBNQl7iz
 4RtYkYiAlMTLzo3MIDazgKPE00/3WUBsYQFbiTUT/wHVcHCwCKhIfJobDRLmFbCUeHPnFRPE
 LnmJmZe+s0PEBSVOznzCAjFGXqJ562yokRISB1+8YIa4R17ixaXlLDC90869ZoawQyW2ftnO
 NIFRYBaSUbOQjJqFZNQCRuZVjEK5mcnZqUWZ2XoFGZUlqcl6KambGEFBK8LAtYOxb47HIUYm
 DsZDjBIczEoivDnn81OFeFMSK6tSi/Lji0pzUosPMUpzsCiJ867uCE4VEkhPLEnNTk0tSC2C
 yTJxcEo1MIY+4dqrrdtbs/dQvl/dh8w4l0ka135FbMjkMzrbl6TyxKW25q2CdXGW7vSQI28t
 TL5r9JyYfj09flmak++R0443Dz9eyq7nJBPwQcDqxtpwZfMJyYkf99w/G7DBqqOhSu/VVEUV
 72OPXjRdtgqtK1//1u9s89o1T5qkXRzqfgfu8C0QENL/rsRSnJFoqMVcVJwIADr6hNRIAgAA
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

v3:
  - Add boot modes chapter
  - Reference tiboot3.bin instead of GP binary for default flashing
  - Minor spelling fixes
  - Pick up Reviewed-by: Dhruva Gole <d-gole@ti.com>

v2: https://lists.denx.de/pipermail/u-boot/2023-November/538971.html
v1: https://lists.denx.de/pipermail/u-boot/2023-October/535750.html

Wadim Egorov (2):
  board: phytec: am62x: Add PHYTEC phyCORE-AM62x SoM
  doc: board: phytec: Add phyCORE-AM62x

 arch/arm/dts/Makefile                         |    4 +-
 .../arm/dts/k3-am62-phycore-som-ddr4-2gb.dtsi | 2190 +++++++++++++++++
 arch/arm/dts/k3-am62-phycore-som.dtsi         |  324 +++
 .../k3-am625-phyboard-lyra-rdk-u-boot.dtsi    |  166 ++
 arch/arm/dts/k3-am625-phyboard-lyra-rdk.dts   |  266 ++
 arch/arm/dts/k3-am625-phycore-som-binman.dtsi |  380 +++
 arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts  |  119 +
 arch/arm/mach-k3/am62x/Kconfig                |   17 +
 board/phytec/phycore_am62x/Kconfig            |   33 +
 board/phytec/phycore_am62x/MAINTAINERS        |   15 +
 board/phytec/phycore_am62x/Makefile           |    8 +
 board/phytec/phycore_am62x/board-cfg.yaml     |   36 +
 board/phytec/phycore_am62x/phycore-am62x.c    |   59 +
 board/phytec/phycore_am62x/phycore_am62x.env  |   23 +
 board/phytec/phycore_am62x/pm-cfg.yaml        |   12 +
 board/phytec/phycore_am62x/rm-cfg.yaml        | 1088 ++++++++
 board/phytec/phycore_am62x/sec-cfg.yaml       |  379 +++
 configs/phycore_am62x_a53_defconfig           |  115 +
 configs/phycore_am62x_r5_defconfig            |  130 +
 doc/board/phytec/index.rst                    |    1 +
 doc/board/phytec/phycore-am62x.rst            |  158 ++
 doc/board/ti/k3.rst                           |    1 +
 include/configs/phycore_am62x.h               |   15 +
 23 files changed, 5538 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/k3-am62-phycore-som-ddr4-2gb.dtsi
 create mode 100644 arch/arm/dts/k3-am62-phycore-som.dtsi
 create mode 100644 arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
 create mode 100644 arch/arm/dts/k3-am625-phyboard-lyra-rdk.dts
 create mode 100644 arch/arm/dts/k3-am625-phycore-som-binman.dtsi
 create mode 100644 arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts
 create mode 100644 board/phytec/phycore_am62x/Kconfig
 create mode 100644 board/phytec/phycore_am62x/MAINTAINERS
 create mode 100644 board/phytec/phycore_am62x/Makefile
 create mode 100644 board/phytec/phycore_am62x/board-cfg.yaml
 create mode 100644 board/phytec/phycore_am62x/phycore-am62x.c
 create mode 100644 board/phytec/phycore_am62x/phycore_am62x.env
 create mode 100644 board/phytec/phycore_am62x/pm-cfg.yaml
 create mode 100644 board/phytec/phycore_am62x/rm-cfg.yaml
 create mode 100644 board/phytec/phycore_am62x/sec-cfg.yaml
 create mode 100644 configs/phycore_am62x_a53_defconfig
 create mode 100644 configs/phycore_am62x_r5_defconfig
 create mode 100644 doc/board/phytec/phycore-am62x.rst
 create mode 100644 include/configs/phycore_am62x.h

-- 
2.34.1

