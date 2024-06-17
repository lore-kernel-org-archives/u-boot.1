Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1ECFC2BA15
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 13:10:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0476882B8;
	Mon, 17 Jun 2024 15:10:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6113F882D0; Mon, 17 Jun 2024 15:10:24 +0200 (CEST)
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch
 [45.157.188.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6080E88283
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 15:10:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4W2qxV0NqJzWQB;
 Mon, 17 Jun 2024 15:10:22 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4W2qxT17Kyz2Z5; Mon, 17 Jun 2024 15:10:20 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 17 Jun 2024 15:10:08 +0200
Subject: [PATCH COVER] rockchip: rk3399: fix SPI-NOR flash not found in
 U-Boot pre-reloc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-rk3399-fix-v1-1-69af21c2baed@cherry.de>
X-B4-Tracking: v=1; b=H4sIAK81cGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDM0Nz3aJsY2NLS920zArdFItkixTj5FQLE5NUJaCGgqJUoDDYsOjY2lo
 Ap7mr4VwAAAA=
To: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.0
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

In commit 100f489f58a6 ("rockchip: rk3399: Fix loading FIT from SD-card
when booting from eMMC"), the spi1 bootph properties were mistakenly
removed meaning, so re-add them back to fix SPI-NOR flash not being
found in U-Boot pre-reloc as required for RK3399 Puma.

Fixes: 100f489f58a6 ("rockchip: rk3399: Fix loading FIT from SD-card when booting from eMMC")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/dts/rk3399-u-boot.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
index b6b43271172..2bec139d833 100644
--- a/arch/arm/dts/rk3399-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-u-boot.dtsi
@@ -145,6 +145,11 @@
 	bootph-some-ram;
 };
 
+&spi1 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
 &spi1_clk {
 	bootph-pre-ram;
 	bootph-some-ram;

---
base-commit: 2248c96ea1cf0b65377040d9f87ce7d8cf534c63
change-id: 20240617-rk3399-fix-d8c8d3ce844e

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

