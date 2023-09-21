Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D231DE70713
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 10:52:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9B9F86AF7;
	Thu, 21 Sep 2023 12:51:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VnL51oug";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B57BA86BCF; Thu, 21 Sep 2023 12:51:30 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6B8086AE9
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 12:51:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38LApQoO003787;
 Thu, 21 Sep 2023 05:51:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695293486;
 bh=D8PbztdTgW4QT7DT1d5yuOkpKo5JWttRKXdsUAs/068=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=VnL51ougY64y4WToX3fwd5nPZKEWOXgyzDlm5Bv7nwxhvwQ2APOkm9PU2YMmY/K9G
 Ye00lW8CDU6vKzpCSVuIThApO5Jg8z2x+FKmzK9LIyKVMWa1+QiaabjFFvqofng8g+
 8Q/C7fsPUk9LCzJ5P+JtNNGSYpw8bCG5AWm06kmA=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38LApQhn032252
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Sep 2023 05:51:26 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Sep 2023 05:51:26 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Sep 2023 05:51:26 -0500
Received: from [127.0.1.1] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38LAp06x020650;
 Thu, 21 Sep 2023 05:51:23 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Thu, 21 Sep 2023 16:21:06 +0530
Subject: [PATCH v6 7/7] board: ti: j721s2: MAINTAINERS: Update the
 MAINTAINERS File.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230921-b4-upstream-j721s2-r5-pinmux-v6-7-ca9639c1ac67@ti.com>
References: <20230921-b4-upstream-j721s2-r5-pinmux-v6-0-ca9639c1ac67@ti.com>
In-Reply-To: <20230921-b4-upstream-j721s2-r5-pinmux-v6-0-ca9639c1ac67@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Reid Tonking <reidt@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Andrew Davis <afd@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695293461; l=1537;
 i=m-chawdhry@ti.com; s=20230324; h=from:subject:message-id;
 bh=IMpyoq7dGQhg50sDqv/3Gz9cJc20Ht6cbdCgzB83LME=;
 b=Eso0ArcxO6EXkwFzZ5cEXA/UblDjw/4/KFoPnd5x5wVtzg3z4RPA4OZLQ2JenHkjWLE84bJok
 lPmD5SH6wWlBPu7ZFPSNTnkG8urgGpytt6zVu0BNDsTj9rCXUx9xLFn
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

Reviewed-by: Nishanth Menon <nm@ti.com>
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

