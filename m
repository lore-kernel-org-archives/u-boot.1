Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B12C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 09:18:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69E6C8752B;
	Wed, 20 Dec 2023 10:18:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="d13zkR3s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1341287695; Wed, 20 Dec 2023 10:18:24 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9D0587480
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 10:18:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1703063899; x=1705655899;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CrtlMaWQbpLj1DNuPPiKp33iyz3qk/jQHPFLj8K3QMw=;
 b=d13zkR3s2QpmuZ0FmMDGzRS//XNviOvDGM4VgIU0aa9LprR80Am8dH2+rqG+axWP
 Vl6EJyDjhWI7txUhpMg5JYtPUc2VleYfBj6laseebYPddDxcWTbm2KDE/qUe6tPg
 LJ05mc+xkQhUrQ9tQ3O+hnME7jY/twgeMp8acrbUegY=;
X-AuditID: ac14000a-fbefe7000000290d-98-6582b15bb93c
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id EB.31.10509.B51B2856;
 Wed, 20 Dec 2023 10:18:19 +0100 (CET)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 20 Dec
 2023 10:18:19 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>, <nm@ti.com>, <trini@konsulko.com>
Subject: [PATCH v4 0/2] *** Add support for phyCORE-AM62x ***
Date: Wed, 20 Dec 2023 10:18:09 +0100
Message-ID: <20231220091811.80373-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsWyRpKBRzd6Y1OqQcMfNYs3P84yWUydtJnd
 4u3eTnaL7nfqDiwerw6sYvc4e2cHo0d/dwurx/Eb25kCWKK4bFJSczLLUov07RK4Mq6fusZc
 sEa8Yurp36wNjD+Euhg5OSQETCQ+znvF2MXIxSEksJhJ4tm5E+wQzmNGibdbm5lBqtgE1CXu
 bPjGCmKLCEhJvOzcCBZnFnCUePrpPguILSxgK9Gw5zQbiM0ioCpxpWsCkM3BwStgLnHgOT/E
 MnmJmZe+s4PYvAKCEidnPmGBGCMv0bx1NtRICYmDL16A2UJA8ReXlrPA9E4795oZwg6VOLJp
 NdMERoFZSEbNQjJqFpJRCxiZVzEK5WYmZ6cWZWbrFWRUlqQm66WkbmIEha0IA9cOxr45HocY
 mTgYDzFKcDArifDu7WxKFeJNSaysSi3Kjy8qzUktPsQozcGiJM67uiM4VUggPbEkNTs1tSC1
 CCbLxMEp1cBoqbIh6MCaWTZ6NiYvrXVmNdYtqzPZoWyalDvPc86kySlzOEJcVM5837r/TVaq
 5z2W/T8Xnyv9sOzsktvB/wrklirP4Zwm0X62wmvJnuBdVktnJodZTQ7mLOT4zVxqJat4S5Dz
 w9baqq8bF0fJ/54xl/HHDBnj70tC3haJ8RcrF278NTs7cDGjEktxRqKhFnNRcSIAbwEovEkC
 AAA=
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

v4:
  - Rebase on current next
  - Drop schema file overrides from binman

v3: https://lists.denx.de/pipermail/u-boot/2023-December/539779.html
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
 arch/arm/dts/k3-am625-phycore-som-binman.dtsi |  314 +++
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
 23 files changed, 5472 insertions(+), 1 deletion(-)
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

