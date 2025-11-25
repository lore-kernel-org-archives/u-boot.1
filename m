Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76AB6D1036D
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 23:42:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C431B84142;
	Wed, 26 Nov 2025 00:42:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="t8Q0Uioi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DF9C8415E; Wed, 26 Nov 2025 00:42:36 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E460C840B0
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 00:42:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.bonnefille@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 9B18BC15D63;
 Tue, 25 Nov 2025 23:42:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4D9CB606A1;
 Tue, 25 Nov 2025 23:42:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C24EA102F08B6; Wed, 26 Nov 2025 00:42:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1764114151; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=UiwtdX/Wa/vfM7kOlPNuuLOVJNCwpIlYqbvbNHjzT4E=;
 b=t8Q0UioiiYWZqWV551owR2Q6u1rNfbUBtwBTrr6vRTKWcZqYD/2IEPdiBBHXXbvHBc50wd
 NBRmeVAkqGXv+ZLHEYEnZcnLZZAdb9Q2tsIG8dkCn2rYhIJDP29ns5pd7Pjvs7O5bm9ozn
 5UBXecdwA0AFj1yJ1vlDwN0GPqJG7dWhWOSOhXQL8lJDgKgDPjoCw1lbFSPhvgdgEplcph
 j6SuHu187XTgOuNTmFEfCYgrieCPVahpafJNonxOTZKJBI2A4QC5YgpQ8nD9eG2+0BbUeh
 /z31Z6Z8KegcUl7iKfC2x95Lb6SEciYznXwzAyk6TIp4IlnrTSD2MrEuoY5weQ==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Subject: [PATCH 0/5] i.MX7 Splash Screen and PWM fixes
Date: Wed, 26 Nov 2025 00:41:52 +0100
Message-Id: <20251126-repair_imx7_splash-v1-0-d3877afb7381@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMA+JmkC/x3MSQqAMAxA0atI1hY6UBWvIiJFUw04lASkIN7d4
 vIt/n9AkAkF+uoBxpuErrPA1BXMWzhXVLQUg9XWG60bxZgC8URHbidJe5BN2eCi74xFdA5KmBg
 j5X86jO/7AdpThZ1kAAAA
X-Change-ID: 20251006-repair_imx7_splash-2a3f5812ee33
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Simon Glass <sjg@chromium.org>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.14.3
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

This series adds support for the PWM functions of the i.MX7 SoC, it also
allows a splash screen to stay when booting the OS by letting the video
driver up when the OS is started.

---
Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>

---
Thomas Bonnefille (5):
      drivers: video: mxsfb: Use kconfig VIDEO_REMOVE to remove video
      arm: include: imx7: rename PWM registers to match driver name
      mx7: clock: add pwm enabling clock function
      pwm: imx: allow i.MX7 to use PWM3 and PWM4
      board: toradex: add splash screen to Toradex i.MX7D Colibri board

 arch/arm/include/asm/arch-mx7/clock.h     |  3 +++
 arch/arm/include/asm/arch-mx7/imx-regs.h  | 25 +++++++++++++++----
 arch/arm/mach-imx/mx7/clock.c             | 29 ++++++++++++++++++++++
 board/toradex/colibri_imx7/colibri_imx7.c | 40 +++++++++++++++++++++++--------
 drivers/pwm/pwm-imx.c                     |  2 +-
 drivers/video/mxsfb.c                     |  6 +++--
 6 files changed, 88 insertions(+), 17 deletions(-)
---
base-commit: 020688fb85624ce7fb01dbf412f9ecfacc9ef8d3
change-id: 20251006-repair_imx7_splash-2a3f5812ee33

Best regards,
-- 
Thomas Bonnefille <thomas.bonnefille@bootlin.com>

