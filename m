Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D30BCD44C48
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 13:53:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1846280325;
	Thu, 15 Jan 2026 14:53:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="jXIiFgow";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 490C48388D; Thu, 15 Jan 2026 14:53:27 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E898836A3
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 14:53:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.bonnefille@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 488E4C1F1F0;
 Thu, 15 Jan 2026 13:52:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 06245606B6;
 Thu, 15 Jan 2026 13:53:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7F77B10B68637; Thu, 15 Jan 2026 14:53:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1768485204; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=YYsat+DPZ90G5V/H66snwPX+nLrXk6IhngjZC0yjKFg=;
 b=jXIiFgow3hus4guz5Hh/DIkIboax9iV2Fa8UBzt+YeXs8h5qnv8WaZwXv97PxH7kr+BOPy
 9+ShRaDfTEApJ2mMt5D6xGUvc2K/z6X7+/7pAxyYeXCLswRdUFjJGumBDKnkZIfbWnEp1t
 Xn0s3V+szpSIo24uOZmXdwONyzq3ruZm3R5B5U4GuCDM3axPBBIGB5ed+PG9dNlgZ94V4j
 Me92+SVteSxkLoCDA8jr5UKFMlrNen3fpXTUwgC8Tjh9LvTFiOsBS5P1knkVrZ1Kax2lK3
 DWqxYrfejAiuTCiy/REoLSELiCo6O2Evvf/twg0ReWw1QBcCAPd60UVNZk8EHA==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Thu, 15 Jan 2026 14:52:46 +0100
Subject: [PATCH v2 3/5] mx7: clock: add pwm enabling clock function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-repair_imx7_splash-v2-3-6595491341ba@bootlin.com>
References: <20260115-repair_imx7_splash-v2-0-6595491341ba@bootlin.com>
In-Reply-To: <20260115-repair_imx7_splash-v2-0-6595491341ba@bootlin.com>
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

