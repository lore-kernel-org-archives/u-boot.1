Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6A0D60D1B
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 10:07:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F07C58953A;
	Tue, 19 Nov 2024 11:07:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="X4/ENpIr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1409F8953E; Tue, 19 Nov 2024 11:07:35 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B89638951C
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 11:07:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AJA7VoZ041484;
 Tue, 19 Nov 2024 04:07:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732010851;
 bh=WrMrnSbnwK8lb9GkmPk/Q6ATksQ1oV7GfJa7nMKYbnw=;
 h=From:To:CC:Subject:Date;
 b=X4/ENpIr92Jgk7NIFMWSRbvl5NR4Llnt9EGm2QGkdPN9/j2W3CdGym8xyneVjJX6v
 amPvk/fyrIA5IPmgvjfUYyjZpEDoAh6/pO/TnT8/W547I5O1rvDWJzd7XWa9z8WHAs
 8hIpB0gPGtGLAM69OLR9IFiG88oGAjD07v3s/P8M=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AJA7VYI011880
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Nov 2024 04:07:31 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Nov 2024 04:07:30 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Nov 2024 04:07:30 -0600
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.6])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AJA7REo126790;
 Tue, 19 Nov 2024 04:07:28 -0600
From: Udit Kumar <u-kumar1@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>
CC: <n-francis@ti.com>, <afd@ti.com>, <u-boot@lists.denx.de>, <nm@ti.com>,
 Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j7200: Fix OSPI boot
Date: Tue, 19 Nov 2024 15:37:20 +0530
Message-ID: <20241119100720.1297067-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

OSPI boot is broken due to missing bootph property
in pin mux of OSPI.
So add bootph to fix OSPI boot.

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---

This fix is already merged into kernel with[0] series.
Sending this patch to allow OSPI boot, 
till above fix is getting merged to u-boot.

Bootlog : https://gist.github.com/uditkumarti/4c827d6801b3fde60a4902ffefd5354c

[0]: https://lore.kernel.org/all/173021674661.3859929.13298221281337904627.b4-ty@ti.com/ 

 dts/upstream/src/arm64/ti/k3-j7200-som-p0.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dts/upstream/src/arm64/ti/k3-j7200-som-p0.dtsi b/dts/upstream/src/arm64/ti/k3-j7200-som-p0.dtsi
index 21fe194a57..014cf1805f 100644
--- a/dts/upstream/src/arm64/ti/k3-j7200-som-p0.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-j7200-som-p0.dtsi
@@ -124,6 +124,7 @@
 	};
 
 	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			J721E_WKUP_IOPAD(0x0000, PIN_OUTPUT, 0) /* MCU_OSPI0_CLK */
 			J721E_WKUP_IOPAD(0x002c, PIN_OUTPUT, 0) /* MCU_OSPI0_CSn0 */
-- 
2.34.1

