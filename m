Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43AE3E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 12:46:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24E178030F;
	Wed, 18 Dec 2024 13:46:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="eLdJ0klc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA11B8022B; Wed, 18 Dec 2024 13:46:24 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22FD580239
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 13:46:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4BICkDeG008778;
 Wed, 18 Dec 2024 06:46:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734525973;
 bh=g87Yo8g2XqkpmTTSkrjvVI6AsFDOWBcmSHg9LWhq1Bk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=eLdJ0klcIBRLv2SaGFtRzq+OTKhIUvZIR0ANzXkspS1o1kW5YZGeUmR0AWhgFkSJv
 L2swqIwA2r12TRmHrqs14N3G8JrcDEoSK1eKWDHOReB9Hjl/PM7Bg3XhAnbw1QSHo6
 BcF/RBk4xs/uR/JGqRELqm2GYKCTMciMdeA/aWE8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BICkDkB044641;
 Wed, 18 Dec 2024 06:46:13 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Dec 2024 06:46:12 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Dec 2024 06:46:12 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BICjgTH003797;
 Wed, 18 Dec 2024 06:46:08 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <vigneshr@ti.com>, <bb@ti.com>, <trini@konsulko.com>, <lukma@denx.de>,
 <n-francis@ti.com>, <mkorpershoek@baylibre.com>, <afd@ti.com>,
 <glaroque@baylibre.com>, <sjoerd@collabora.com>,
 <martyn.welch@collabora.com>, <rasmus.villemoes@prevas.dk>,
 <caleb.connolly@linaro.org>, <j-humphreys@ti.com>, <rogerq@kernel.org>,
 <nm@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2 5/5] doc: board: document support for USB DFU boot on
 AM62Px SoC
Date: Wed, 18 Dec 2024 18:15:35 +0530
Message-ID: <20241218124542.3519447-6-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218124542.3519447-1-s-vadapalli@ti.com>
References: <20241218124542.3519447-1-s-vadapalli@ti.com>
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

Since USB DFU boot is supported on AM62Px SoC, document the steps
required to build the image for USB DFU boot along with the steps to
send images using the "dfu-util" tool.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
This patch has been newly introduced in this series based on the
discussion at:
https://patchwork.ozlabs.org/project/uboot/patch/20241217131658.2920799-3-s-vadapalli@ti.com/#3432702

NOTE: This patch should only be merged if all other patches in this
series will also be merged, in order to ensure that the feature is
documented only if it is supported (i.e. all patches in this series
which are required for the feature to be functional have been merged).

 doc/board/ti/am62px_sk.rst | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/doc/board/ti/am62px_sk.rst b/doc/board/ti/am62px_sk.rst
index 99bdc034869..75451ad76b5 100644
--- a/doc/board/ti/am62px_sk.rst
+++ b/doc/board/ti/am62px_sk.rst
@@ -124,6 +124,18 @@ Set the variables corresponding to this platform:
     :start-after: .. k3_rst_include_start_build_steps_spl_r5
     :end-before: .. k3_rst_include_end_build_steps_spl_r5
 
+* 3.1.1 Alternative build of R5 for DFU boot:
+
+  As the SPL size can exceed the limit when building it with support for
+  booting from both local storage *and* DFU, in order to disable the
+  configs not required for DFU boot, a config fragment should be used
+  to not only enable configs for DFU boot, but also disabled the unneeded
+  configs.
+
+.. prompt:: bash $
+
+   export UBOOT_CFG_CORTEXR="${UBOOT_CFG_CORTEXR} am62x_r5_usbdfu.config"
+
 * 3.2 A53:
 
 .. include::  ../ti/k3.rst
@@ -290,6 +302,25 @@ https://www.ti.com/lit/pdf/spruj83 under the `Boot Mode Pins` section.
 
 For SW2 and SW1, the switch state in the "ON" position = 1.
 
+DFU based boot
+--------------
+
+To boot the board over DFU, set the switches to DFU mode and connect to the
+USB type C DRD port on the board. After power-on the build artifacts needs to be
+uploaded one by one with a tool like dfu-util.
+
+The initial ROM will have a DFU alt named `bootloader` for the initial R5 spl
+upload. The next stages as exposed by U-Boot have target alts matching the name
+of the artifacts, for these a USB reset has to be done after each upload.
+
+When using dfu-util the following commands can be used to boot to a U-Boot shell:
+
+.. prompt:: bash $
+
+  dfu-util -a bootloader -D tiboot3.bin
+  dfu-util -R -a tispl -D tispl.bin
+  dfu-util -R -a u-boot.img -D u-boot.img
+
 Debugging U-Boot
 ----------------
 
-- 
2.43.0

