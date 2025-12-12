Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2979BD59D81
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 18:14:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1608F83A2B;
	Fri, 12 Dec 2025 19:13:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81B64839C6; Fri, 12 Dec 2025 19:13:43 +0100 (CET)
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::8fab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 983EF81D6A
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 19:13:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6c])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dScys2RbFznPF;
 Fri, 12 Dec 2025 19:13:41 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dScyq52rpzDvy; Fri, 12 Dec 2025 19:13:39 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 12 Dec 2025 19:13:20 +0100
Subject: [PATCH 8/8] power: regulator: remove SPL_REGULATOR_PWM due to
 unmeetable SPL_DM_PWM dependency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-kconfig-reorg-v1-8-72441d8cc53c@cherry.de>
References: <20251212-kconfig-reorg-v1-0-72441d8cc53c@cherry.de>
In-Reply-To: <20251212-kconfig-reorg-v1-0-72441d8cc53c@cherry.de>
To: u-boot@lists.denx.de, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Udit Kumar <u-kumar1@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>, 
 Andre Przywara <andre.przywara@arm.com>, Ye Li <ye.li@nxp.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Justin Klaassen <justin@tidylabs.net>, Samuel Holland <samuel@sholland.org>, 
 Rui Miguel Silva <rui.silva@linaro.org>, 
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

SPL_DM_PWM option simply doesn't exist. Moreover, drivers/pwm is only
included by drivers/Makefile for non-xPL stages so making
SPL_REGULATOR_PWM properly build for SPL/xPL is more involved than just
adding an SPL_DM_PWM option.

Reading the original commit (ddc824f89aa8 ("power: regulator: Allow PWM
regulator to be omitted from SPL."), the intent seemingly wasn't to
allow building support in XPL but rather to allow removing it which is
done by using $(PHASE_) ($(SPL_) at that time) in the Makefile. If
anyone needs that, let them figure out what they need to do without
misleading potential users of this symbol by simply removing it.

Fixes: 2a846e04c622 ("power: regulator: Correct dependencies on SPL_REGULATOR_PWM")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 drivers/power/regulator/Kconfig | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index d6b451ca407..124b0b34c41 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -141,13 +141,6 @@ config REGULATOR_PWM
 	This driver is controlled by a device tree node
 	which includes voltage limits.
 
-config SPL_REGULATOR_PWM
-	bool "Enable Driver for PWM regulators in SPL"
-	depends on SPL_DM_REGULATOR && SPL && SPL_DM_PWM
-	help
-	  This config enables implementation of driver-model regulator uclass
-	  features for PWM regulators in SPL.
-
 config DM_REGULATOR_MAX8907
 	bool "Enable Driver Model for REGULATOR MAX8907"
 	depends on DM_REGULATOR && DM_PMIC_MAX8907

-- 
2.52.0

