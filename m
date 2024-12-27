Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0488E7718B
	for <u-boot@archiver.kernel.org>; Fri, 27 Dec 2024 18:51:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1542380435;
	Fri, 27 Dec 2024 19:51:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F33398043C; Fri, 27 Dec 2024 19:51:01 +0100 (CET)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06C93801A0
 for <u-boot@lists.denx.de>; Fri, 27 Dec 2024 19:50:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1tRFQG-002yx2-75;
 Fri, 27 Dec 2024 18:50:56 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] board: gateworks: venice: rename GW7905 to GW7500
Date: Fri, 27 Dec 2024 10:50:51 -0800
Message-Id: <20241227185051.2455906-1-tharvey@gateworks.com>
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

The GW7905 was renamed to GW7500 before release. Change the various
names in the dt files and references.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 ...w7905-0x-u-boot.dtsi => imx8mm-venice-gw75xx-0x-u-boot.dtsi} | 0
 ...w7905-2x-u-boot.dtsi => imx8mp-venice-gw75xx-2x-u-boot.dtsi} | 0
 board/gateworks/venice/spl.c                                    | 2 +-
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/arm/dts/{imx8mm-venice-gw7905-0x-u-boot.dtsi => imx8mm-venice-gw75xx-0x-u-boot.dtsi} (100%)
 rename arch/arm/dts/{imx8mp-venice-gw7905-2x-u-boot.dtsi => imx8mp-venice-gw75xx-2x-u-boot.dtsi} (100%)

diff --git a/arch/arm/dts/imx8mm-venice-gw7905-0x-u-boot.dtsi b/arch/arm/dts/imx8mm-venice-gw75xx-0x-u-boot.dtsi
similarity index 100%
rename from arch/arm/dts/imx8mm-venice-gw7905-0x-u-boot.dtsi
rename to arch/arm/dts/imx8mm-venice-gw75xx-0x-u-boot.dtsi
diff --git a/arch/arm/dts/imx8mp-venice-gw7905-2x-u-boot.dtsi b/arch/arm/dts/imx8mp-venice-gw75xx-2x-u-boot.dtsi
similarity index 100%
rename from arch/arm/dts/imx8mp-venice-gw7905-2x-u-boot.dtsi
rename to arch/arm/dts/imx8mp-venice-gw75xx-2x-u-boot.dtsi
diff --git a/board/gateworks/venice/spl.c b/board/gateworks/venice/spl.c
index fe538ec58332..275f9d3453ea 100644
--- a/board/gateworks/venice/spl.c
+++ b/board/gateworks/venice/spl.c
@@ -80,7 +80,7 @@ static int power_init_board(const char *model, struct udevice *gsc)
 	if ((!strncmp(model, "GW71", 4)) ||
 	    (!strncmp(model, "GW72", 4)) ||
 	    (!strncmp(model, "GW73", 4)) ||
-	    (!strncmp(model, "GW7905", 6))) {
+	    (!strncmp(model, "GW75", 4))) {
 		ret = uclass_get_device_by_seq(UCLASS_I2C, 0, &bus);
 		if (ret) {
 			printf("PMIC    : failed I2C1 probe: %d\n", ret);
-- 
2.25.1

