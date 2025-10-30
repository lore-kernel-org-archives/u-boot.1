Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDA6CCF9F0
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 10:04:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50580808AF;
	Thu, 30 Oct 2025 11:04:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E595838D7; Thu, 30 Oct 2025 11:04:07 +0100 (CET)
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch
 [84.16.66.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C59C808AF
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 11:04:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cy07n1dsSzgwd;
 Thu, 30 Oct 2025 11:04:05 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4cy07m5QV5zDY3; Thu, 30 Oct 2025 11:04:04 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 30 Oct 2025 11:03:55 +0100
Subject: [PATCH v2 1/4] pwm: move all PWM related topics inside a Kconfig menu
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-pwm-kconfig-v2-1-d151a42784ce@cherry.de>
References: <20251030-pwm-kconfig-v2-0-d151a42784ce@cherry.de>
In-Reply-To: <20251030-pwm-kconfig-v2-0-d151a42784ce@cherry.de>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Sukrut Bellary <sbellary@baylibre.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Cheick Traore <cheick.traore@foss.st.com>, 
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
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

So it's visually better split from the other subsystems when using
menuconfig.

Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 drivers/pwm/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 06f42f699de..ec57a967721 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -1,3 +1,5 @@
+menu "Pulse-width modulation (PWM)"
+
 config DM_PWM
 	bool "Enable support for pulse-width modulation devices (PWM)"
 	depends on DM
@@ -133,3 +135,5 @@ config PWM_TI_ECAP
 	depends on DM_PWM && ARCH_OMAP2PLUS
 	help
 	  PWM driver support for the ECAP controller found on TI SOCs.
+
+endmenu

-- 
2.51.0

