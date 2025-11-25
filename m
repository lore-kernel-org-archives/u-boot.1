Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BF3D1036C
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 23:43:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CC3884180;
	Wed, 26 Nov 2025 00:42:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Lx7lQ/3I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C249784159; Wed, 26 Nov 2025 00:42:38 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9F328415E
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 00:42:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.bonnefille@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 78F6D4E418D1;
 Tue, 25 Nov 2025 23:42:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 50405606A1;
 Tue, 25 Nov 2025 23:42:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 952C4102F08B6; Wed, 26 Nov 2025 00:42:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1764114155; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=YYsat+DPZ90G5V/H66snwPX+nLrXk6IhngjZC0yjKFg=;
 b=Lx7lQ/3IPU35cxd1mzS1EuPKmpdiSM+ONZhSeLOQJKkQzVcteyFBUIgCiz6nZJBFpAHQS0
 9hykZl2rKKya8HBvkhvLSIfU8i+evvA4b7icU1sJKurS/SOAz68q/ZV5u082UVD0fCtwsY
 cILu5gogVyojr96EaNYEMgCq3wXQRSvVGUy0drXbntCiava0t6r7kEAiEBlSBOEZ1bgaW2
 eESg4R/lvNdHNRKhZz0t3pspRwqb8DfOmThvyGrJZ5sNWk/KP/Gp5iP7g3ov1DYexPx3FI
 ooTk3MQgFu1dFSPuTyEyiHipj1fpJ6leQJLxdxdO40czSXot2+MQ0n5nGCSqXg==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Wed, 26 Nov 2025 00:41:55 +0100
Subject: [PATCH 3/5] mx7: clock: add pwm enabling clock function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-repair_imx7_splash-v1-3-d3877afb7381@bootlin.com>
References: <20251126-repair_imx7_splash-v1-0-d3877afb7381@bootlin.com>
In-Reply-To: <20251126-repair_imx7_splash-v1-0-d3877afb7381@bootlin.com>
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

Add function to enable the clock of the different PWM controllers on i.MX7.

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
 arch/arm/include/asm/arch-mx7/clock.h |  3 +++
 arch/arm/mach-imx/mx7/clock.c         | 29 +++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/arm/include/asm/arch-mx7/clock.h b/arch/arm/include/asm/arch-mx7/clock.h
index 48c7c3367a5..03d1cc76e53 100644
--- a/arch/arm/include/asm/arch-mx7/clock.h
+++ b/arch/arm/include/asm/arch-mx7/clock.h
@@ -347,6 +347,9 @@ void clock_init(void);
 #ifdef CONFIG_SYS_I2C_MXC
 int enable_i2c_clk(unsigned char enable, unsigned i2c_num);
 #endif
+#ifdef CONFIG_PWM_IMX
+int enable_pwm_clk(unsigned char enable, unsigned int pwm_num);
+#endif
 #ifdef CONFIG_FEC_MXC
 int set_clk_enet(enum enet_freq type);
 #endif
diff --git a/arch/arm/mach-imx/mx7/clock.c b/arch/arm/mach-imx/mx7/clock.c
index a8328a0b224..72e0051373f 100644
--- a/arch/arm/mach-imx/mx7/clock.c
+++ b/arch/arm/mach-imx/mx7/clock.c
@@ -524,6 +524,35 @@ unsigned int mxc_get_clock(enum mxc_clock clk)
 	return 0;
 }
 
+#ifdef CONFIG_PWM_IMX
+/* pwm_num can be 0 - 3 */
+int enable_pwm_clk(unsigned char enable, unsigned int pwm_num)
+{
+	u32 target;
+
+	if (pwm_num >= 4)
+		return -EINVAL;
+
+	if (enable) {
+		clock_enable(CCGR_PWM1 + pwm_num, 0);
+
+		/* Set i2c root clock to PLL_SYS_MAIN_120M_CLK */
+
+		target = CLK_ROOT_ON |
+			 PWM1_CLK_ROOT_FROM_PLL_SYS_MAIN_120M_CLK |
+			 CLK_ROOT_PRE_DIV(CLK_ROOT_PRE_DIV1) |
+			 CLK_ROOT_POST_DIV(CLK_ROOT_POST_DIV2);
+		clock_set_target_val(PWM1_CLK_ROOT + pwm_num, target);
+
+		clock_enable(CCGR_PWM1 + pwm_num, 1);
+	} else {
+		clock_enable(CCGR_PWM1 + pwm_num, 0);
+	}
+
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_SYS_I2C_MXC
 /* i2c_num can be 0 - 3 */
 int enable_i2c_clk(unsigned char enable, unsigned i2c_num)

-- 
2.52.0

