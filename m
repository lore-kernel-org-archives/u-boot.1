Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF82C27C75
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 12:29:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 652D6889D0;
	Fri, 14 Jun 2024 14:29:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="LDQ1Pk5X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C984A889DC; Fri, 14 Jun 2024 14:29:31 +0200 (CEST)
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com
 [95.215.58.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E27FA884A3
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 14:29:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=contact@jookia.org
X-Envelope-To: contact@jookia.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1718368169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2SstxzwLuaWLNaN2qvkPdHDnoLcV88uTeiGaKgGNQss=;
 b=LDQ1Pk5XftK/x2YdCpWzvgBwc9J0mMc4QDjX+rV6Q4fwXGuivmt1JQqhvomyfZ+IIx7mlZ
 tHnR7hJCH13/nWdSH57OGryUqN/W4RbCDKrAzDk9m9ertbZceotuvpCYtd2U8ABF9hTaL1
 LypxrTO5eaQQCRMa+4AYew7InNX12ywLhtAlg/qQU7N2WF5Ah7ZdyayfUUwDWNfgaCrbl6
 eU1aB3hnmHTcFAa2zD10MOGrqU8dpEEHl8zU9rdVPg6hpV3FU7NQ4F8LQQPQvMmHKRftRo
 r6cdXDIOm2OYqYZkt8wllenDImAhOutDCi2duH3brFFRCiPeui4tjILDDdhkMQ==
X-Envelope-To: trini@konsulko.com
X-Envelope-To: andre.przywara@arm.com
X-Envelope-To: u-boot@lists.denx.de
X-Envelope-To: jagan@amarulasolutions.com
X-Envelope-To: agust@denx.de
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: John Watts <contact@jookia.org>
Date: Fri, 14 Jun 2024 22:28:46 +1000
Subject: [PATCH 2/2] sunxi: video: Support DE_LOW and PIXDATA_NEGEDGE
 display flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-sunxipolarities-v1-2-15bbbf57dfff@jookia.org>
References: <20240614-sunxipolarities-v1-0-15bbbf57dfff@jookia.org>
In-Reply-To: <20240614-sunxipolarities-v1-0-15bbbf57dfff@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Anatolij Gustschin <agust@denx.de>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1718368135; l=1552;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=Fv4I0zdEA+jH2aUh2u33beAMBt9bYVguEqkk2lqjMoo=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgPs7MDd2XR
 g2uRE9caV1lPPPeu0VzIG9fPrrVmYyAhLcAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAjQHKrBiWZSBjVZjhxTlW7R9
 35hwWHfA/fPJiX9klVhXuWJEVtETMCfaO86nnGUZxCtAyOV8PAjCUACVY9tLkAAUAAP/p
X-Developer-Key: i=contact@jookia.org; a=openssh;
 fpr=SHA256:/gEvgms/9HpbgpcH+K7O4GYXmqkP7siJx9zHeEWRZTg
X-Migadu-Flow: FLOW_OUT
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

Implement these by inverting the DE and PCLK polarities.

Signed-off-by: John Watts <contact@jookia.org>
---
 arch/arm/include/asm/arch-sunxi/lcdc.h | 2 ++
 drivers/video/sunxi/lcdc.c             | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/include/asm/arch-sunxi/lcdc.h b/arch/arm/include/asm/arch-sunxi/lcdc.h
index 90216bcfd5..580cd6af20 100644
--- a/arch/arm/include/asm/arch-sunxi/lcdc.h
+++ b/arch/arm/include/asm/arch-sunxi/lcdc.h
@@ -64,6 +64,8 @@ struct sunxi_lcdc_reg {
 #define SUNXI_LCDC_Y(y)				(((y) - 1) << 0)
 #define SUNXI_LCDC_TCON_VSYNC_MASK		(1 << 24)
 #define SUNXI_LCDC_TCON_HSYNC_MASK		(1 << 25)
+#define SUNXI_LCDC_TCON_PIXDATA_MASK		(1 << 26)
+#define SUNXI_LCDC_TCON_DE_MASK			(1 << 27)
 #define SUNXI_LCDC_CTRL_IO_MAP_MASK		(1 << 0)
 #define SUNXI_LCDC_CTRL_IO_MAP_TCON0		(0 << 0)
 #define SUNXI_LCDC_CTRL_IO_MAP_TCON1		(1 << 0)
diff --git a/drivers/video/sunxi/lcdc.c b/drivers/video/sunxi/lcdc.c
index 4fcea6050a..169da7654e 100644
--- a/drivers/video/sunxi/lcdc.c
+++ b/drivers/video/sunxi/lcdc.c
@@ -137,6 +137,10 @@ void lcdc_tcon0_mode_set(struct sunxi_lcdc_reg * const lcdc,
 		val |= SUNXI_LCDC_TCON_HSYNC_MASK;
 	if (mode->flags & DISPLAY_FLAGS_VSYNC_HIGH)
 		val |= SUNXI_LCDC_TCON_VSYNC_MASK;
+	if (mode->flags & DISPLAY_FLAGS_DE_LOW)
+		val |= SUNXI_LCDC_TCON_DE_MASK;
+	if (mode->flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
+		val |= SUNXI_LCDC_TCON_PIXDATA_MASK;
 
 #ifdef CONFIG_VIDEO_VGA_VIA_LCD_FORCE_SYNC_ACTIVE_HIGH
 	if (for_ext_vga_dac)

-- 
2.45.2

