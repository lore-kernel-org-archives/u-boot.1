Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4018C54E41
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 08:42:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17CA087DAB;
	Wed, 28 Feb 2024 09:42:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="GyM5qlul";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 484A787E16; Wed, 28 Feb 2024 09:42:30 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27EEB83346
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 09:42:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1709109746; x=1711701746;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IR2twhOz/7kggoC6rIPQdnSb8+60jHBJj5ULqTQoQwE=;
 b=GyM5qlulgeVH0xwwDaDG4Ag19qFMt1rI1ZeitinpElpba6lG24srFzDcwb3QsJrI
 G44qwcqc5x5iyHqvjs+TRgO4YKmomZ1Ofd0Db5xYLG3qEvXCEx0e+UAOtkKSwsWZ
 ssAhbMmwtXL8IFkf2jeF/LtKEaAok3Xsrknyicur5u8=;
X-AuditID: ac14000a-fadff7000000290d-a8-65def1f21650
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 33.B3.10509.2F1FED56;
 Wed, 28 Feb 2024 09:42:26 +0100 (CET)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 28 Feb
 2024 09:42:26 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>
CC: <nm@ti.com>, <trini@konsulko.com>, <upstream@lists.phytec.de>,
 <d-gole@ti.com>
Subject: [PATCH v3 0/2] *** Add support for phyCORE-AM64x ***
Date: Wed, 28 Feb 2024 09:42:15 +0100
Message-ID: <20240228084217.935848-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsWyRpKBR/fTx3upBj9uqVm0rPWwePPjLJPF
 1Emb2S3e7u1kt+h+p+7A6vHqwCp2j7N3djB69He3sHocv7GdKYAlissmJTUnsyy1SN8ugSvj
 2tV/7AU/xSrWbz7J2MD4TKiLkZNDQsBE4tzTDSxdjFwcQgKLmSTWrd/NDOE8ZpR48WYLC0gV
 m4C6xJ0N31hBbBEBKYmXnRuZQWxmgRCJs4372UBsYQFbidv3PoHZLAKqErv+fAfr5RWwkHiz
 9BwjxDZ5iZmXvrNDxAUlTs58wgIxR16ieetsqJkSEgdfvACzhYDiLy4tZ4HpnXbuNTOEHSpx
 ZNNqpgmMArOQjJqFZNQsJKMWMDKvYhTKzUzOTi3KzNYryKgsSU3WS0ndxAgKYBEGrh2MfXM8
 DjEycTAeYpTgYFYS4ZURvJsqxJuSWFmVWpQfX1Sak1p8iFGag0VJnHd1R3CqkEB6Yklqdmpq
 QWoRTJaJg1OqgdHqu8TKmLfHTguxtzlZCi7b1xFm+0LJle227+mEg1FzlKpadvLayt8P5Hi6
 6en9HWceLbt68OLuhYXrwuur+VkC/M5ndGa3ih15MbuC9etV0WS3AqYnR22dzeXu7pl7+FdT
 +6LjrfI76i2/7Pv8MNo+Lratw7bklE6J051Z/wvfhadFp34+eUGJpTgj0VCLuag4EQC5YhHF
 TgIAAA==
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

Add basic support for the phyCORE-AM64x.

v1: https://lists.denx.de/pipermail/u-boot/2024-January/544649.html
v2: https://lists.denx.de/pipermail/u-boot/2024-February/546757.html
v3:
  - Update doc to use proper binary artifacts for HSFS devices
  - Add Dhruva's Reviewed-by

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
 configs/phycore_am64x_a53_defconfig           |  167 ++
 configs/phycore_am64x_r5_defconfig            |  179 ++
 doc/board/phytec/index.rst                    |    1 +
 doc/board/phytec/phycore-am64x.rst            |  159 ++
 include/configs/phycore_am64x.h               |   15 +
 22 files changed, 5870 insertions(+), 1 deletion(-)
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

