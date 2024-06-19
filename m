Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE330C27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 21:44:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA89F884B8;
	Wed, 19 Jun 2024 23:44:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4137A884AA; Wed, 19 Jun 2024 23:44:09 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E07588485
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 23:44:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1sK365-00FQRA-M1;
 Wed, 19 Jun 2024 21:44:05 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Fabio Estevam <festevam@gmail.com>,
	u-boot@lists.denx.de
Cc: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2] imx8mp-venice-gw74xx: default USB1 to host mode
Date: Wed, 19 Jun 2024 14:44:04 -0700
Message-Id: <20240619214404.2095943-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The GW74xx USB1 controller connects to a dual-role connector using a GPIO
for role detection via the usb-connector Linux driver (usb-conn-gpio.c).

This drive does not exist yet in U-Boot so for now we will just default
USB1 to host mode.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v2: provide missing commit message
---
 arch/arm/dts/imx8mp-venice-gw74xx-u-boot.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/imx8mp-venice-gw74xx-u-boot.dtsi b/arch/arm/dts/imx8mp-venice-gw74xx-u-boot.dtsi
index 240fbc1b568f..a90794d8108a 100644
--- a/arch/arm/dts/imx8mp-venice-gw74xx-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-venice-gw74xx-u-boot.dtsi
@@ -243,3 +243,8 @@
 &wdog1 {
 	bootph-pre-ram;
 };
+
+/* gpio-usb-con not supported yet in U-Boot so make this a host for now */
+&usb_dwc3_0 {
+	dr_mode = "host";
+};
-- 
2.25.1

