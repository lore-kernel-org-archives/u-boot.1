Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD092E810A4
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 08:21:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4F6386AB9;
	Wed, 27 Sep 2023 10:21:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NTjK1a9r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CF8286CAD; Wed, 27 Sep 2023 10:21:11 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5368C86410
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 10:21:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-yadav@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38R8L7eY105399;
 Wed, 27 Sep 2023 03:21:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695802867;
 bh=zItUngRN52D9SjZ+XLb4CTMrVq7zxRrihg7MxDhpixs=;
 h=From:To:CC:Subject:Date;
 b=NTjK1a9rIBBLcM75GgrRzhUQlb7dfrBGFJazO3r45fdhq63zqxxk3vO1eLq0ly+kL
 8zzmQCBuKuev5QkJEM3qSK7ead94NAjsSY9L/8Wy9mo5RTh3JdpSQuZSOI165HgG1c
 XuuEvih+dtgMN10d2ZChYveCFASIeGLHO4yrEC5I=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38R8L7fH017114
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 27 Sep 2023 03:21:07 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Sep 2023 03:21:07 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Sep 2023 03:21:07 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38R8L6gl021219;
 Wed, 27 Sep 2023 03:21:06 -0500
From: Nitin Yadav <n-yadav@ti.com>
To: <nm@ti.com>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH 0/4] Add AM62x LP SK support
Date: Wed, 27 Sep 2023 13:51:01 +0530
Message-ID: <20230927082105.3729470-1-n-yadav@ti.com>
X-Mailer: git-send-email 2.25.1
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

This series adds support of AM62x LP SK. The AM62x LP SK board
is similar to AM62x SK but has some significant changes that
requires different set of device tree at each stage of bootloader.
Also refactors to have common nodes at k3-am62x-r5-sk-common.dtsi
and k3-am62x-sk-common-u-boot.dtsi for all am62x SoC varients.

Nitin Yadav (4):
  arm: dts: Refactor common dtsi file for R5 and A53 SPL
  arm: dts: Add support for AM62x LP SK
  arm: dts: k3-am62-lp-sk-binman: Add binman support
  board: ti: am62x: add am62x_lpsk_* defconfigs and env files

 arch/arm/dts/Makefile                         |    2 +
 arch/arm/dts/k3-am62-lp-sk-binman.dtsi        |   29 +
 arch/arm/dts/k3-am62-lp-sk-u-boot.dtsi        |    9 +
 arch/arm/dts/k3-am62-lp-sk.dts                |  231 ++
 arch/arm/dts/k3-am62-r5-lp-sk.dts             |   21 +
 arch/arm/dts/k3-am625-r5-sk.dts               |   94 +-
 arch/arm/dts/k3-am625-sk-u-boot.dtsi          |  110 +-
 arch/arm/dts/k3-am62x-ddr-lp4-50-800-800.dtsi | 2190 +++++++++++++++++
 arch/arm/dts/k3-am62x-r5-sk-common.dtsi       |   96 +
 arch/arm/dts/k3-am62x-sk-common-u-boot.dtsi   |  109 +
 board/ti/am62x/am62x_lpsk_a53.config          |    5 +
 board/ti/am62x/am62x_lpsk_r5.config           |    5 +
 board/ti/am62x/am62xlpsk.env                  |   21 +
 13 files changed, 2724 insertions(+), 198 deletions(-)
 create mode 100644 arch/arm/dts/k3-am62-lp-sk-binman.dtsi
 create mode 100644 arch/arm/dts/k3-am62-lp-sk-u-boot.dtsi
 create mode 100644 arch/arm/dts/k3-am62-lp-sk.dts
 create mode 100644 arch/arm/dts/k3-am62-r5-lp-sk.dts
 create mode 100644 arch/arm/dts/k3-am62x-ddr-lp4-50-800-800.dtsi
 create mode 100644 arch/arm/dts/k3-am62x-r5-sk-common.dtsi
 create mode 100644 arch/arm/dts/k3-am62x-sk-common-u-boot.dtsi
 create mode 100644 board/ti/am62x/am62x_lpsk_a53.config
 create mode 100644 board/ti/am62x/am62x_lpsk_r5.config
 create mode 100644 board/ti/am62x/am62xlpsk.env

-- 
2.25.1

