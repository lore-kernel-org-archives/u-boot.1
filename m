Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 053AFD44C46
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 13:53:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B72D83623;
	Thu, 15 Jan 2026 14:53:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="n63uYwpJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 287BF83655; Thu, 15 Jan 2026 14:53:24 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBB7180077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 14:53:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.bonnefille@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 7A81E4E420FA
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 13:53:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4FC2C606B6;
 Thu, 15 Jan 2026 13:53:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D418E10B6851D; Thu, 15 Jan 2026 14:53:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1768485200; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=PpNBLc3cVNj6T9NPs/pyu5Wgaq6Vd9NStSa66indWoI=;
 b=n63uYwpJWXWhVGR4kIqIWZv7ija8e2CEANr89mvJH9WwR6uL37eMf7opug4Hsspyloi1mx
 IJB5EduWBD77CD6dTmmgE0h2zvhtH7lBY8oIrjO+8ZZy4FWQ3Lo98heTwalCHJ1RhW1K8i
 pSmW4sAdu/JDxZo8+SlUpdbtokOrmUhh9Wy9JgE4PIKq9rZUBxkuSJqTxx/WB0rxlPNruf
 2HpmhvmUYIl+EXoM4L3ImmTiWF7ge/Pnwim507XQ0VzvXYn59QqM9svEJFl/EAY0sf21Ym
 36Fzgh4jZ1PrWikMBfxG7909WwQliBNU9t4CSP2vqWmyTzjg7tRZwcOfy/EOzQ==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Subject: [PATCH v2 0/5] i.MX7 Splash Screen and PWM fixes
Date: Thu, 15 Jan 2026 14:52:43 +0100
Message-Id: <20260115-repair_imx7_splash-v2-0-6595491341ba@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQqDMBBFryKzbkoywUa66j2KSNSxDqgJiQSLe
 Pemdtvle/Df3yFSYIpwL3YIlDiyWzLgpYButMuLBPeZASWWSsqbCOQth4bnzTTRTzaOAq0eyko
 hkdaQhz7QwNsZfdaZR46rC+/zI6mv/eUU/s0lJaTodWWMHVqjK/VonVsnXq6dm6E+juMDQpqlt
 rYAAAA=
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
Changes in v2:
- Sort includes in board toradex/colibri_imx7/colibri_imx7.c
- Fix non-void function returning nothing in setup_lcd
- Reformat commit log
- Link to v1: https://lore.kernel.org/r/20251126-repair_imx7_splash-v1-0-d3877afb7381@bootlin.com

---
Thomas Bonnefille (5):
      drivers: video: mxsfb: Use kconfig VIDEO_REMOVE to remove video
      arm: include: imx7: rename PWM registers to match driver name
      mx7: clock: add pwm enabling clock function
      pwm: imx: allow i.MX7 to use PWM3 and PWM4
      board: toradex: add splash screen to Toradex i.MX7D Colibri board

 arch/arm/include/asm/arch-mx7/clock.h     |  3 +++
 arch/arm/include/asm/arch-mx7/imx-regs.h  | 25 ++++++++++++++++---
 arch/arm/mach-imx/mx7/clock.c             | 29 ++++++++++++++++++++++
 board/toradex/colibri_imx7/colibri_imx7.c | 41 +++++++++++++++++++++++--------
 drivers/pwm/pwm-imx.c                     |  2 +-
 drivers/video/mxsfb.c                     |  6 +++--
 6 files changed, 89 insertions(+), 17 deletions(-)
---
base-commit: 2e48ce04a690a6916f1dadd7ca79470fae3ddbb2
change-id: 20251006-repair_imx7_splash-2a3f5812ee33

Best regards,
-- 
Thomas Bonnefille <thomas.bonnefille@bootlin.com>

