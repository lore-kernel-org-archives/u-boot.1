Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A54ACD98F0
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 02:41:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96AB7848A2;
	Wed, 17 Jun 2026 04:41:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="acePFg5V";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="reKb55vF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4E4F848D1; Wed, 17 Jun 2026 04:41:15 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADBD584894
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 04:41:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gg7Qd2bcFz9v0w;
 Wed, 17 Jun 2026 04:41:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781664073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=x1Qp4yzLInw0GsNGtvS9lmr3g9CKPZ3S49stwT8GCkA=;
 b=acePFg5Vd00Vmp9ewhxK9JsVr1u5j+GZsxpyxTKlCoC5x5hWOsm/zzmo7lRSozQzfZ/78G
 cATZ63HcjsSnqkEVgdOX04x6SJtHe53xseRwHx/FnAFmCPAlfcO7lqDrcjHCV1qSd4WGmy
 JW3WbQ+pmGEBi6z46gFQ/OQZHIVBi1aVNPBGEndrjtIpKVTcdqZWkEBKS4b23KXQiqtNhI
 ZSEI2Z2O/qNQ0pKp1NobsChqTzIAP/S8HSrfVR7B7/tSWXAGlsIQZd7ZllwhnVy3iJwM0/
 Fj1s8kVcsbYbiJI5bnN1curamAyRJLFzSCjlwK59me/dSN6IdRD3SnzRJz4ROw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=reKb55vF;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781664071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=x1Qp4yzLInw0GsNGtvS9lmr3g9CKPZ3S49stwT8GCkA=;
 b=reKb55vFMhg0S2ePfNfxXT+egFVv2ztvQ369GRDgyxpV2nkl4oYBtIpbaSly/YZ6ajoPTR
 7+AV+B5j5KBSgJuprYW9mZcsQsaa3CR1E+46AZ6csgnm6fzH4ehibndPXxcp8nIwH93K10
 ELw02WTWEQwSuhfIISm7tDNbdyhMGC54L/ICDY6KgOttytfWZHtbAAdPlHhDUaTZsZn2NV
 HY1QhmjJcR9x/CxbFbbxhTkHsI9GRws26liD0UqQSXRLY0KlrnfBbpu5pf1N3hM+jXMIki
 htXVa2PrVKgt0DU46WyzVvDG97T6winsMv0d+KuGUYImpnnXdoIbaOrvOooj1Q==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 David Lechner <dlechner@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH] MAINTAINERS: Replace Mediatek with N:
Date: Wed, 17 Jun 2026 04:40:53 +0200
Message-ID: <20260617024105.152655-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1f846b3835b7bbc7ff1
X-MBO-RS-META: cc9bftrxnwi7pb9txftut5mctgn6r1i7
X-Rspamd-Queue-Id: 4gg7Qd2bcFz9v0w
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

Use N: to match on all mediatek/mtk files, drop the large list of
entries which represent the same set of relevant files and miss a
few in the process.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: David Lechner <dlechner@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: Julien Stephan <jstephan@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>
Cc: u-boot@lists.denx.de
---
 MAINTAINERS | 36 +-----------------------------------
 1 file changed, 1 insertion(+), 35 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ced8c6948c0..01c17489765 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -373,45 +373,11 @@ R:	GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
 T:	git https://source.denx.de/u-boot/custodians/u-boot-mediatek.git
 S:	Maintained
 F:	arch/arm/dts/mt*
-F:	arch/arm/mach-mediatek/
-F:	arch/arm/include/asm/arch-mediatek/
-F:	board/mediatek/
-F:	doc/device-tree-bindings/phy/phy-mtk-*
-F:	doc/device-tree-bindings/usb/mediatek,*
-F:	doc/README.mediatek
-F:	drivers/clk/mediatek/
-F:	drivers/cpu/mtk_cpu.c
-F:	drivers/i2c/mtk_i2c.c
-F:	drivers/mmc/mtk-sd.c
-F:	drivers/net/mtk_eth/
-F:	drivers/net/phy/mediatek/
-F:	drivers/phy/phy-mtk-*
-F:	drivers/pinctrl/mediatek/
-F:	drivers/power/domain/mtk-power-domain.c
-F:	drivers/power/pmic/mtk-pwrap.c
 F:	drivers/power/regulator/mt*.c
-F:	drivers/pci/pcie_mediatek_gen3.c
-F:	drivers/pci/pcie_mediatek.c
-F:	drivers/pwm/pwm-mtk.c
-F:	drivers/ram/mediatek/
-F:	drivers/spi/mtk_snfi_spi.c
-F:	drivers/spi/mtk_spim.c
-F:	drivers/spi/mtk_snor.c
-F:	drivers/timer/mtk_timer.c
-F:	drivers/ufs/ufs-mediatek*
-F:	drivers/usb/host/xhci-mtk.c
 F:	drivers/usb/mtu3/
-F:	drivers/watchdog/mtk_wdt.c
-F:	drivers/reset/reset-mediatek.c
-F:	drivers/serial/serial_mtk.c
-F:	include/dt-bindings/clock/mediatek,*
-F:	include/dt-bindings/power/mediatek,*
 F:	include/power/mt*.h
-F:	tools/mtk_image.c
-F:	tools/mtk_image.h
-F:	tools/mtk_nand_headers.c
-F:	tools/mtk_nand_headers.h
 N:	mediatek
+N:	mtk
 
 ARM METHODE SUPPORT
 M:	Robert Marko <robert.marko@sartura.hr>
-- 
2.53.0

