Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D24CCF9E9
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 11:16:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D04F800D7;
	Wed, 29 Oct 2025 12:16:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93ECF8352B; Wed, 29 Oct 2025 12:16:32 +0100 (CET)
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::42af])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8F1F8003E
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 12:16:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cxPnp3FFxzy86;
 Wed, 29 Oct 2025 12:16:30 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4cxPnn41MMzJ5B; Wed, 29 Oct 2025 12:16:29 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH 0/3] pwm: put symbols into a menu + use if DM_PWM block
 instead of depends on
Date: Wed, 29 Oct 2025 12:16:07 +0100
Message-Id: <20251029-pwm-kconfig-v1-0-80186567f2e8@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHj3AWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyNL3YLyXN3s5Py8tMx0XYvEFOPkRLOkFMsUQyWgjoKi1LTMCrBp0bG
 1tQBjGhsLXQAAAA==
X-Change-ID: 20251029-pwm-kconfig-8ad3ca6bd9d1
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

This improves readability in menuconfig by putting PWM symbols under a
Kconfig menu.

It also groups PWM symbols that depend on DM_PWM together under an if
DM_PWM block so that we don't need to always list the dependency in the
depends on of the symbol.

I do have questions around the assumed missing dependency of DM_PWM for
PWM_SANDBOX.

No intended change in behavior except how it shows in menuconfig.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (3):
      pwm: move all PWM related topics inside a Kconfig menu
      pwm: put all UCLASS PWM drivers under an if condition on DM_PWM
      pwm: fix typo in PWM_MESON help text

 drivers/pwm/Kconfig | 140 ++++++++++++++++++++++++++--------------------------
 1 file changed, 71 insertions(+), 69 deletions(-)
---
base-commit: 4cad9faf8d2887b8851f0ced5194ffbaa92ca71e
change-id: 20251029-pwm-kconfig-8ad3ca6bd9d1

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

