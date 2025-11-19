Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6897DCF394B
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 16:44:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A016883FC5;
	Wed, 19 Nov 2025 17:44:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58E4683F42; Wed, 19 Nov 2025 17:44:22 +0100 (CET)
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::8fa8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A04283015
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 17:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dBS4M3Xk2zlCv;
 Wed, 19 Nov 2025 17:44:19 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dBS4L1lRVzC22; Wed, 19 Nov 2025 17:44:18 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 19 Nov 2025 17:43:47 +0100
Subject: [PATCH 3/5] arm: omap3: remove leftover from CM_T35 support
 removal
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-legacy-led-unused-code-v1-3-bc0ae1235baa@cherry.de>
References: <20251119-legacy-led-unused-code-v1-0-bc0ae1235baa@cherry.de>
In-Reply-To: <20251119-legacy-led-unused-code-v1-0-bc0ae1235baa@cherry.de>
To: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Alexander Graf <agraf@csgraf.de>, Peter Robinson <pbrobinson@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Weijie Gao <hackpascal@gmail.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>, Mario Six <mario.six@gdsys.cc>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>, 
 Sinan Akman <sinan@writeme.com>, Jesse Taube <mr.bossman075@gmail.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
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

Commit 76386d6195a1 ("arm: Remove cm_t35 board") removed support for the
board that was built when TARGET_CM_T35 is selected, but removal of the
symbol was forgotten, so let's fix this oversight.

While at it, update the README for omap3 to remove the last mention of
cm_t35.

Fixes: 76386d6195a1 ("arm: Remove cm_t35 board")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/mach-omap2/omap3/Kconfig | 6 ------
 doc/README.omap3                  | 6 ------
 2 files changed, 12 deletions(-)

diff --git a/arch/arm/mach-omap2/omap3/Kconfig b/arch/arm/mach-omap2/omap3/Kconfig
index b50b8a5f6bd..f6cad7d9d82 100644
--- a/arch/arm/mach-omap2/omap3/Kconfig
+++ b/arch/arm/mach-omap2/omap3/Kconfig
@@ -34,12 +34,6 @@ config TARGET_AM3517_EVM
 	select MMC
 	imply CMD_DM
 
-config TARGET_CM_T35
-	bool "CompuLab CM-T3530 and CM-T3730 boards"
-	select OMAP3_GPIO_2
-	select OMAP3_GPIO_5
-	select OMAP3_GPIO_6 if LED_STATUS
-
 config TARGET_DEVKIT8000
 	bool "TimLL OMAP3 Devkit8000"
 	select DM
diff --git a/doc/README.omap3 b/doc/README.omap3
index d1e6be94a11..527bcfc4acc 100644
--- a/doc/README.omap3
+++ b/doc/README.omap3
@@ -46,12 +46,6 @@ make
 make omap3_zoom2_config
 make
 
-* CM-T35:
-
-make cm_t35_config
-make
-
-
 Custom commands
 ===============
 

-- 
2.51.1

