Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E82C87FD2
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 13:13:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8C9283477;
	Mon, 11 Aug 2025 15:12:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="oNlh7XQI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86D4E83477; Mon, 11 Aug 2025 15:12:40 +0200 (CEST)
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABCC983020
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 15:12:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EE3D3C9760; Mon, 11 Aug 2025 15:12:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1754917958; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=y/+m+HVeBY52RO+QjgBqaW5UYSvm8qAX9RU09ULV/8U=;
 b=oNlh7XQIAJeWlngRF+P5iXAAPhsntTSrju5duKyciZxNS+yZ3q3Tz39E5uToLGd7rvgou0
 +OrbBjT+D40j2dpelZXlXu4L2Y1Ik/rlZ+5Czj86m0faesrtAnqOjw/n72l+dFa0jt6ly4
 D1czlLTEB6IrxOwRX2hmucg1CpKrLie/qJgAdVKvgyHyyKwkdHVx4Nn8c7eR13ev840CkQ
 +CR0kuTWqhQG2SSYlQjOiep7zjI+IjgQzy1X92EZ5Loxeqzozrd67zctQ9sqiVr9atdfnC
 bkD7qFrWdOyZyBuEixvk85JQR5ixWbP2m4btMFAkiONJpBNOsVCWZcf4DA8C7Q==
From: Frieder Schrempf <frieder@fris.de>
To: u-boot@lists.denx.de, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@denx.de>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Subject: [PATCH 5/6] arm: dts: imx8mp-data-modul-edm-sbc: Remove deprecated
 sd-vsel-gpios
Date: Mon, 11 Aug 2025 15:12:01 +0200
Message-ID: <20250811131213.211124-6-frieder@fris.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811131213.211124-1-frieder@fris.de>
References: <20250811131213.211124-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The sd-vsel-gpios property in the root of the PMIC node is deprecated
and therefore not parsed by the driver anymore. We can safely remove
this as it wasn't used anyway due to the pad not having the correct
pinmux settings.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm/dts/imx8mp-data-modul-edm-sbc.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/dts/imx8mp-data-modul-edm-sbc.dts b/arch/arm/dts/imx8mp-data-modul-edm-sbc.dts
index 8066f7fb649..6b40106e3bd 100644
--- a/arch/arm/dts/imx8mp-data-modul-edm-sbc.dts
+++ b/arch/arm/dts/imx8mp-data-modul-edm-sbc.dts
@@ -344,7 +344,6 @@
 		pinctrl-0 = <&pinctrl_pmic>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
-		sd-vsel-gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
 
 		/*
 		 * i.MX 8M Plus Data Sheet for Consumer Products
-- 
2.50.1

