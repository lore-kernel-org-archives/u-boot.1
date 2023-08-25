Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ACC6C3DA66
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 11:18:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4A3F869DD;
	Fri, 25 Aug 2023 13:17:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tERvYFps";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A258086898; Fri, 25 Aug 2023 13:17:55 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0D2F86A65
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 13:17:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37PBHpjs005097;
 Fri, 25 Aug 2023 06:17:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692962271;
 bh=Rfs0Y1cU0pH5+Ut/L86F6ow8s4TTIa2b/momIneZLok=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=tERvYFpsb4wShpEC5JsgvxUBxSkJNqTDEceA7x6kxmwuwiPXqgcQaKKffWoHTRCv9
 GR+YHgU60GmHmmHvQSCKECnbdg0Jd3d6vjXClS90VBaW5oSIW/7r4Wc6Vl11h6EoYB
 6spxB/2PadBBvV9REcDc1lzRRWhK999GOo6vn5HE=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37PBHpsZ130348
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Aug 2023 06:17:51 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Aug 2023 06:17:50 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Aug 2023 06:17:50 -0500
Received: from [127.0.1.1] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37PBHQCB023435;
 Fri, 25 Aug 2023 06:17:47 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Fri, 25 Aug 2023 16:47:04 +0530
Subject: [PATCH v2 6/6] board: ti: j721s2: MAINTAINERS: Update the
 MAINTAINERS File.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230816-b4-upstream-j721s2-r5-pinmux-v2-6-a5f141be40bc@ti.com>
References: <20230816-b4-upstream-j721s2-r5-pinmux-v2-0-a5f141be40bc@ti.com>
In-Reply-To: <20230816-b4-upstream-j721s2-r5-pinmux-v2-0-a5f141be40bc@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Reid Tonking <reidt@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Andrew Davis <afd@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692962247; l=1182;
 i=m-chawdhry@ti.com; s=20230324; h=from:subject:message-id;
 bh=cfFtjxk/BVy4pBSko5Knrka+uGcV9tihSQbcM7d80+A=;
 b=PM1inO5reDQoQKAj8deNpFalzPjklH3fyaKEUddY6gxLH9HcLHVSQnwXt0bANPn/wlEob/FKA
 h0qu6Vpd9z2AlNoEuv2Ysr/7n7L2tNVqmEUTqDyBPDQa5pYPWMkbzw9
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=Z51yAzxWCcDqKRLHiDBrUxIdXbB21R89ms8xgECdiak=
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

Update the MAINTAINERS file and propose a new MAINTAINER for j721s2 due
to the previous MAINTAINER not being associated with TI.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 board/ti/j721s2/MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/board/ti/j721s2/MAINTAINERS b/board/ti/j721s2/MAINTAINERS
index 323bd2353a7e..97a0581d0405 100644
--- a/board/ti/j721s2/MAINTAINERS
+++ b/board/ti/j721s2/MAINTAINERS
@@ -1,7 +1,8 @@
 J721S2 BOARD
-M:	Aswath Govindraju <a-govindraju@ti.com>
+M:	Manorit Chawdhry <m-chawdhry@ti.com>
 S:	Maintained
 F:	board/ti/j721s2
+F:	doc/board/ti/j721s2_evm.rst
 F:	include/configs/j721s2_evm.h
 F:	configs/j721s2_evm_r5_defconfig
 F:	configs/j721s2_evm_a72_defconfig
@@ -11,6 +12,6 @@ F:	arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi
 F:	arch/arm/dts/k3-j721s2-som-p0.dtsi
 F:	arch/arm/dts/k3-j721s2-common-proc-board.dts
 F:	arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
-F:	arch/arm/dts//k3-j721s2-r5-common-proc-board.dts
+F:	arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
 F:	arch/arm/dts/k3-j721s2-ddr.dtsi
 F:	arch/arm/dts/k3-j721s2-ddr-evm-lp4-4266.dtsi

-- 
2.41.0

