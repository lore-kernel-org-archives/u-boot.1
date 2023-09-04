Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41446C71153
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 10:39:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD82C86936;
	Mon,  4 Sep 2023 12:38:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="F3Ud3fK7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF41C86958; Mon,  4 Sep 2023 12:38:44 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7BB88693D
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 12:38:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 384Ace96107465;
 Mon, 4 Sep 2023 05:38:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693823920;
 bh=D0GdWrsKd/WddRvks9GWqafmJtNAUBSCAQGJN5JJylQ=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=F3Ud3fK7EhBKVtjnGDqc2Fx3/stvERq5NRdiqFNmraNmyLwZph9eRrvHHrCIKoKyn
 EtJHuxH3ET7ahIYFPrw9xo0uLRh6BOxYnewpm8h2ZmpWYZuXjPiMhIJ1Wr0QZb8oEp
 9eqsCR2HJihKpD13ZOwJ9wgOXBidxUTMjYr5cpk0=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 384AceVR092592
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 4 Sep 2023 05:38:40 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 4
 Sep 2023 05:38:39 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 4 Sep 2023 05:38:39 -0500
Received: from [127.0.1.1] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 384AcHYx029746;
 Mon, 4 Sep 2023 05:38:37 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Mon, 4 Sep 2023 16:08:21 +0530
Subject: [PATCH v4 6/6] board: ti: j721s2: MAINTAINERS: Update the
 MAINTAINERS File.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230816-b4-upstream-j721s2-r5-pinmux-v4-6-dc114bece5d7@ti.com>
References: <20230816-b4-upstream-j721s2-r5-pinmux-v4-0-dc114bece5d7@ti.com>
In-Reply-To: <20230816-b4-upstream-j721s2-r5-pinmux-v4-0-dc114bece5d7@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Reid Tonking <reidt@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Andrew Davis <afd@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693823897; l=1496;
 i=m-chawdhry@ti.com; s=20230324; h=from:subject:message-id;
 bh=sIWlO7GX6X6vKgAIkXFXZ/UQjCIRJrcz1l8oISnXINo=;
 b=oF1sutChXUcbxWh7sTpr8+sLNUNiGzP/TKUpF9Km92WG5i0LDKSAXXi1n0EllwXlGnh6UZpE5
 5h9tZAdqw/OD203ABpxVmeVFOz553YcigCN1MyBR0KA2lFEgoug7RMs
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
 board/ti/j721s2/MAINTAINERS | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/board/ti/j721s2/MAINTAINERS b/board/ti/j721s2/MAINTAINERS
index 323bd2353a7e..08c8d110ac0a 100644
--- a/board/ti/j721s2/MAINTAINERS
+++ b/board/ti/j721s2/MAINTAINERS
@@ -1,16 +1,23 @@
 J721S2 BOARD
-M:	Aswath Govindraju <a-govindraju@ti.com>
+M:	Manorit Chawdhry <m-chawdhry@ti.com>
 S:	Maintained
 F:	board/ti/j721s2
+F:	arch/arm/mach-k3/j721s2
+F:	doc/board/ti/j721s2_evm.rst
 F:	include/configs/j721s2_evm.h
 F:	configs/j721s2_evm_r5_defconfig
 F:	configs/j721s2_evm_a72_defconfig
 F:	arch/arm/dts/k3-j721s2.dtsi
 F:	arch/arm/dts/k3-j721s2-main.dtsi
 F:	arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi
+F:	arch/arm/dts/k3-j721s2-thermal.dtsi
 F:	arch/arm/dts/k3-j721s2-som-p0.dtsi
 F:	arch/arm/dts/k3-j721s2-common-proc-board.dts
 F:	arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
-F:	arch/arm/dts//k3-j721s2-r5-common-proc-board.dts
+F:	arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
 F:	arch/arm/dts/k3-j721s2-ddr.dtsi
 F:	arch/arm/dts/k3-j721s2-ddr-evm-lp4-4266.dtsi
+F:	arch/arm/dts/k3-am68-sk-som.dtsi
+F:	arch/arm/dts/k3-am68-sk-base-board.dts
+F:	arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi
+F:	arch/arm/dts/k3-am68-sk-r5-base-board.dts

-- 
2.41.0

