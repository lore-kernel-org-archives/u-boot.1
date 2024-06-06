Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB4BC25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 08:46:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CC7B881D9;
	Thu,  6 Jun 2024 10:45:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 781818839F; Thu,  6 Jun 2024 10:45:46 +0200 (CEST)
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch
 [185.125.25.13])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93679881B8
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 10:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VvybD1vTCzsyW;
 Thu,  6 Jun 2024 10:45:44 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VvybC1sKpzBxQ; Thu,  6 Jun 2024 10:45:43 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 06 Jun 2024 10:45:33 +0200
Subject: [PATCH next v3 3/6] rockchip: rk3399-puma: remove unnecessary
 simple-bin:fit:offset override
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-misc-tsd-v3-3-728d721c464a@cherry.de>
References: <20240606-misc-tsd-v3-0-728d721c464a@cherry.de>
In-Reply-To: <20240606-misc-tsd-v3-0-728d721c464a@cherry.de>
To: Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.13.0
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

Since commit 6007b69d544e ("rockchip: rk3399-puma: Update SPL_PAD_TO
Kconfig option"), SPL_PAD_TO matches
(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR - 64) * 512 and the default
value for simple-bin:fit:offset in rockchip-u-boot.dtsi is
SPL_PAD_TO, so let's remove this override.

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi b/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi
index 5a9bd320ec4..55895d0dd19 100644
--- a/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi
@@ -33,12 +33,6 @@
 };
 
 &binman {
-	simple-bin {
-		fit {
-			offset = <((CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR - 64) * 512)>;
-		};
-	};
-
 #ifdef CONFIG_ROCKCHIP_SPI_IMAGE
 	simple-bin-spi {
 		fit {

-- 
2.45.2

