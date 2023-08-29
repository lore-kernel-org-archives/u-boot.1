Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84867C83F14
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 07:32:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA60E864F5;
	Tue, 29 Aug 2023 09:32:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=siemens.com header.i=huaqian.li@siemens.com header.b="c8sTCtD2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3028786420; Tue, 29 Aug 2023 05:46:53 +0200 (CEST)
Received: from mta-65-228.siemens.flowmailer.net
 (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45BA0864D2
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 05:46:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=huaqian.li@siemens.com
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id
 20230829034649d1babc939b87fbb100 for <u-boot@lists.denx.de>;
 Tue, 29 Aug 2023 05:46:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=huaqian.li@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=ltJuHlzU22xPhXZ5o2wA6aNzvoirXph4y6LKnsiY6cE=;
 b=c8sTCtD2v2kNMPZpI0dSLT/fshoRL8E0HmUCxeit3e4hnqhKB0hIMVSEBXvN9MWaqg4Mn+
 Pu+626UkONV41VoogeKbt0PdTTEfvYCLW0QgLob6RAJLNtOUCVBClsszUtIzE8RBew+s4Vfs
 6Ho97rAkKzY2oBvm0ubZb4YhHSo30=;
From: huaqian.li@siemens.com
To: u-boot@lists.denx.de
Cc: huaqianlee@gmail.com, jan.kiszka@siemens.com, baocheng.su@siemens.com,
 lokeshvutla@ti.com, Li Hua Qian <huaqian.li@siemens.com>
Subject: [PATCH 1/1] Watchdog: Support WDIOF_CARDRESET on TI AM65x platform
Date: Tue, 29 Aug 2023 11:46:21 +0800
Message-Id: <20230829034620.119207-1-huaqian.li@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-959203:519-21489:flowmailer
X-Mailman-Approved-At: Tue, 29 Aug 2023 09:32:30 +0200
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

From: Li Hua Qian <huaqian.li@siemens.com>

To have the WDIOF_CARDRESET support for the TI AM65x platform watchdog,
this patch reserves some memories, which indicate if the current boot due
to a watchdog reset.

Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>

---
Here is the Kernel Reviewed-by Submission:
  https://lore.kernel.org/all/20230718021007.1338761-1-huaqian.li@siemens.com/

 arch/arm/dts/k3-am65-iot2050-common.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/dts/k3-am65-iot2050-common.dtsi b/arch/arm/dts/k3-am65-iot2050-common.dtsi
index 65da226847..b6135b849f 100644
--- a/arch/arm/dts/k3-am65-iot2050-common.dtsi
+++ b/arch/arm/dts/k3-am65-iot2050-common.dtsi
@@ -64,6 +64,12 @@
 			alignment = <0x1000>;
 			no-map;
 		};
+
+		/* To reserve the power-on(PON) reason for watchdog reset */
+		wdt_reset_memory_region: wdt-memory@a2200000 {
+			reg = <0x00 0xa2200000 0x00 0x00001000>;
+			no-map;
+		};
 	};
 
 	leds {
@@ -720,6 +726,11 @@
 	mboxes = <&mailbox0_cluster1 &mbox_mcu_r5fss0_core1>;
 };
 
+&mcu_rti1 {
+	memory-region = <&wdt_reset_memory_region>;
+
+};
+
 &icssg0_mdio {
 	status = "disabled";
 };
-- 
2.34.1

