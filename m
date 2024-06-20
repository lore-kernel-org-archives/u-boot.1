Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0F6C2BA1A
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 01:30:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCE168844C;
	Thu, 20 Jun 2024 03:30:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FEDB884A4; Thu, 20 Jun 2024 03:30:24 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEF7D831A1
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 03:30:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1sK6d1-005wqd-KY;
 Thu, 20 Jun 2024 01:30:19 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Fabio Estevam <festevam@gmail.com>,
	u-boot@lists.denx.de
Cc: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] imx8mp-venice-gw702x: Drop EQos clock workaround
Date: Wed, 19 Jun 2024 18:30:18 -0700
Message-Id: <20240620013018.2283965-1-tharvey@gateworks.com>
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

The assigned-clock no longer have to be dropped, the clock are now
defined in clk-imx8mp.c and used by DWMAC driver to configure the
DWMAC clock. Drop the workarounds from U-Boot specific DT extras.

Having the clocks dropped causes the EQoS to be non-functional.

See commit c7ea9612df0f ("arm64: dts: imx8mp: Drop EQoS clock
workaround").

Fixes: 48c6f9777cee ("board: gateworks: venice: add imx8mp-gw7905-2x support")
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/dts/imx8mp-venice-gw702x-u-boot.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/dts/imx8mp-venice-gw702x-u-boot.dtsi b/arch/arm/dts/imx8mp-venice-gw702x-u-boot.dtsi
index b9e3db7de937..98f71c73c986 100644
--- a/arch/arm/dts/imx8mp-venice-gw702x-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-venice-gw702x-u-boot.dtsi
@@ -4,9 +4,3 @@
  */
 
 #include "imx8mp-venice-u-boot.dtsi"
-
-&eqos {
-	/delete-property/ assigned-clocks;
-	/delete-property/ assigned-clock-parents;
-	/delete-property/ assigned-clock-rates;
-};
-- 
2.25.1

