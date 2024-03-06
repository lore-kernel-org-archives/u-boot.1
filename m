Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334BCC5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 12:09:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC4AD87E70;
	Wed,  6 Mar 2024 13:09:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Dw1a0Xa+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CADC087CBA; Wed,  6 Mar 2024 07:38:03 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C273887FA4
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 07:38:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4266c0tZ007294
 for <u-boot@lists.denx.de>; Wed, 6 Mar 2024 00:38:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709707080;
 bh=iOztYawOqomjM43xmccMOHhYnj7/gbKZdo15mqyjWKE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Dw1a0Xa+vNdb3+P9TLdPY4o90C6Vs4aAKWK5f4W+Q78oDNf96YPk86uSwS4Jpy469
 zENu6PpED89dFmq1fKewK+6KikyE9j0enmCfx0BvC7tYdbXFqns6GgbVbbgTsel3Wt
 hHmesxSkfKMqKmgpSgTbzCbO2uLXIh6MBUqFfzIE=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4266c0u2008471
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <u-boot@lists.denx.de>; Wed, 6 Mar 2024 00:38:00 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Mar 2024 00:38:00 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Mar 2024 00:38:00 -0600
Received: from PSDKL-Workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com
 [10.24.68.244])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4266bsdm012351;
 Wed, 6 Mar 2024 00:37:58 -0600
From: Aniket Limaye <a-limaye@ti.com>
To: <u-boot@lists.denx.de>
CC: <u-kumar1@ti.com>, <vaishnav.a@ti.com>, <a-nandan@ti.com>, Aniket Limaye
 <a-limaye@ti.com>
Subject: [PATCH 2/4] arm: dts: k3-j7200: Fix support for OSPI flash
Date: Wed, 6 Mar 2024 12:07:47 +0530
Message-ID: <20240306063749.1411176-3-a-limaye@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306063749.1411176-1-a-limaye@ti.com>
References: <20240306063749.1411176-1-a-limaye@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Wed, 06 Mar 2024 13:09:02 +0100
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

- Add the missing bootph-all property in the flash subnode for ospi
- Add the missing overrides for the ospi node in the r5 devicetree

Signed-off-by: Aniket Limaye <a-limaye@ti.com>
---
 arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi | 4 ++++
 arch/arm/dts/k3-j7200-r5-common-proc-board.dts      | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi b/arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi
index 60ca6d21ab..c9fee0ea99 100644
--- a/arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi
@@ -195,6 +195,10 @@
 
 &ospi0 {
 	bootph-all;
+
+	flash@0 {
+		bootph-all;
+	};
 };
 
 &serdes_ln_ctrl {
diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
index 018faaa13b..195637a836 100644
--- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
+++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
@@ -83,3 +83,8 @@
 &wkup_vtm0 {
 	bootph-pre-ram;
 };
+
+&ospi0 {
+    reg = <0x0 0x47040000 0x0 0x100>,
+          <0x0 0x50000000 0x0 0x8000000>;
+};
-- 
2.34.1

