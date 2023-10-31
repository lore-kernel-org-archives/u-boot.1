Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D498EC4167B
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 13:28:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F01BD875F9;
	Tue, 31 Oct 2023 14:28:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Xt2rKM9j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA8BF87B5D; Tue, 31 Oct 2023 14:28:18 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31D7587469
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 14:28:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-yadav@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39VDSBAH015879;
 Tue, 31 Oct 2023 08:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698758891;
 bh=FND/CPBG6hp4pe4czPZh8KdxFg8X2UDE7DtqVJpxeUg=;
 h=From:To:CC:Subject:Date;
 b=Xt2rKM9jfLyLK7k5RdXBje6pm/XfC65SkpezgiLy6nFVIRET+eBGmWmGNiv/rFh6A
 QjZdNkhSSGPu6I5lBATjhZUbfXe03kH88qJ6ARtsbwB/3z6hBjsHjCH6YvzZtlWzzM
 t3qQlOvHHN3SAecLGnUxVr4nX3EYew8e1q1PhbwM=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39VDSB7w106352
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 31 Oct 2023 08:28:11 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 31
 Oct 2023 08:28:10 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 31 Oct 2023 08:28:10 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39VDS9n4003302;
 Tue, 31 Oct 2023 08:28:10 -0500
From: Nitin Yadav <n-yadav@ti.com>
To: <nm@ti.com>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH 0/6] Add AM62SIP SK support
Date: Tue, 31 Oct 2023 18:58:03 +0530
Message-ID: <20231031132809.1524341-1-n-yadav@ti.com>
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

This series adds support of AM62SIP SK board. The AM62SIP SK
is different from AM62x SK in terms of DDR Memory size which
is reduced to 512 M and embedded as part of SoC.

Note:
 - Please apply this series after applying AM62x LP SK support series.
   (https://lore.kernel.org/all/20231030110138.1347603-1-n-yadav@ti.com/)
 - The link provided in board documentaion will be active at
   later point. (https://www.ti.com/tool/SK-AM62-SIP)

Nitin Yadav (6):
  arm: dts: k3-am62x-sip-ddr-lp4-50-800: Add DDR configuration for
    AM62-SIP
  ram: k3-ddrss: k3-ddrss: Fix updating ddr size with ecc off
  board: ti: am62x: Avoid overwriting reserve mem for AM62 SIP
  arm: dts: Add support for AM62x SIP SKEVM at R5 SPL
  board: ti: am62x: Add am62xsip_sk_r5.config defconfig fragment
  doc: ti: Add AM62SIP SK Board information

 arch/arm/dts/Makefile                         |    1 +
 arch/arm/dts/k3-am62sip-r5-sk.dts             |   23 +
 arch/arm/dts/k3-am62x-sip-ddr-lp4-50-800.dtsi | 2191 +++++++++++++++++
 board/ti/am62x/am62xsip_sk_r5.config          |    5 +
 board/ti/am62x/evm.c                          |   11 +
 doc/board/ti/am62x_sk.rst                     |    7 +
 drivers/ram/k3-ddrss/k3-ddrss.c               |    3 -
 7 files changed, 2238 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/dts/k3-am62sip-r5-sk.dts
 create mode 100644 arch/arm/dts/k3-am62x-sip-ddr-lp4-50-800.dtsi
 create mode 100644 board/ti/am62x/am62xsip_sk_r5.config

-- 
2.25.1

