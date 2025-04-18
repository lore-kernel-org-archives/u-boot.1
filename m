Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CEBC369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 19:40:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4FA08334D;
	Fri, 18 Apr 2025 21:40:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QljxzVal";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CF668329B; Fri, 18 Apr 2025 21:40:07 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53A50832BC
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 21:40:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53IJduiS365337
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Apr 2025 14:39:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745005196;
 bh=NxAI36XSivldDYTZJnsdIXlLuWjD63HbAzMwy3kcK0Y=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=QljxzValZnFA6iljjgUx/qtTJagGTUOHfg+I14p2ggwfljnNrMpJPs6GEFXQ/xutf
 jvCFxRQWMlr5rPv9jr6cVxXIFeJAmV31DAoDRRm7cNYqDGCSXntjmbjXTCibMACbfX
 toAxjozgbufE9mYUUjUKZE+8TYMMq0zZhl02vWH4=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53IJduOa003014
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 18 Apr 2025 14:39:56 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 18
 Apr 2025 14:39:56 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 18 Apr 2025 14:39:55 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53IJdtaE028499;
 Fri, 18 Apr 2025 14:39:55 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Neha Malcom Francis <n-francis@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>
CC: Beleswar Padhi <b-padhi@ti.com>, Udit Kumar <u-kumar1@ti.com>, Jonathan
 Humphreys <j-humphreys@ti.com>, Andrew Davis <afd@ti.com>,
 <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 2/9] arch: arm: dts: k3-am67a-beagley-ai-u-boot: Mark
 main_gpio1 as bootph-all
Date: Fri, 18 Apr 2025 14:39:36 -0500
Message-ID: <20250418193943.953952-3-nm@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250418193943.953952-1-nm@ti.com>
References: <20250418193943.953952-1-nm@ti.com>
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

main_gpio1 controls the voltage for the SDcard from 3.3v to 1.8v.
This is required for proper operation of SDcard through various boot
stages.

Fixes the following seen in the boot log:
failed to set vqmmc-voltage to 3.3V

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes Since v1:
- None

V1: https://lore.kernel.org/r/20250411225717.3117370-3-nm@ti.com

Side note: patch was posted to upstream linux kernel:
https://lore.kernel.org/all/20250411203950.2859356-1-nm@ti.com/

I had originally thought it was OK to delay this patch, but the error
messages in boot log is annoying.

 arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi b/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
index 6c52038cdcaf..6330ca93fc74 100644
--- a/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
+++ b/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
@@ -53,6 +53,10 @@
 	status = "disabled";
 };
 
+&main_gpio1 {
+	bootph-all;
+};
+
 #if IS_ENABLED(CONFIG_TARGET_J722S_R5_BEAGLEY_AI)
 
 &binman {
-- 
2.47.0

