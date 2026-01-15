Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 256DBD44C48
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 13:53:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBB3D83923;
	Thu, 15 Jan 2026 14:53:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="HTFTnIrE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A39F8388D; Thu, 15 Jan 2026 14:53:26 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CE8080077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 14:53:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.bonnefille@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 0482E4E420FA;
 Thu, 15 Jan 2026 13:53:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C7587606B6;
 Thu, 15 Jan 2026 13:53:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2D0BC10B68631; Thu, 15 Jan 2026 14:53:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1768485203; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=+J1OhBZ4bgwkGWxr5sdSzLLtsLPAY+kDYa4BbNBiYwo=;
 b=HTFTnIrETct2Y+NaXY3dyyS0fr8jQ2TE3a3zU7XisqfImzcB0vQeNs4+ATM//k8Jnx89MU
 D3fD7XfmhqF7iUviX/g8s0N68VLx15D5a3x9vhrZtAu/36g+uUBLXgE/XUxuuolSXFKIhO
 a0RYxxdS3Eb6SMliXoFTXO27MlO5KnGnGSCFvzX1UlXV+W6Ex0+rPwN716UcaLWqpREQ67
 OAD6KSuCmwBdcFrh0QAWpTpVOFqeKfsOsyNhJBs/cIH2Ogk2WTBCQ26aEtyUP/1V8/0/IL
 f6U+q+/QAliWfFz+oNOdHtowvwadwMkK5IaxsvHitHmpnaWoxLYSNNsjpnyEqA==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Thu, 15 Jan 2026 14:52:45 +0100
Subject: [PATCH v2 2/5] arm: include: imx7: rename PWM registers to match
 driver name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-repair_imx7_splash-v2-2-6595491341ba@bootlin.com>
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

The imx pwm driver uses PWMn_BASE_ADDR as the address of the different
PWM controllers, as the current names used for the PWM addresses aren't
used anywhere, this commit renames the macro to match what has been done
for i.MX6 and i.MX5.

Also adds some basic bit descriptions, macros and structure to give to
the pwm-imx driver based on what has already been done for the other
i.MX models.

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
 arch/arm/include/asm/arch-mx7/imx-regs.h | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/arch-mx7/imx-regs.h b/arch/arm/include/asm/arch-mx7/imx-regs.h
index 849c5482241..d1cc176d6dc 100644
--- a/arch/arm/include/asm/arch-mx7/imx-regs.h
+++ b/arch/arm/include/asm/arch-mx7/imx-regs.h
@@ -127,10 +127,10 @@
 #define ECSPI4_BASE_ADDR                (AIPS2_OFF_BASE_ADDR+0x30000)
 #define FTM1_IPS_BASE_ADDR              (AIPS2_OFF_BASE_ADDR+0x40000)
 #define FTM2_IPS_BASE_ADDR              (AIPS2_OFF_BASE_ADDR+0x50000)
-#define PWM1_IPS_BASE_ADDR              (AIPS2_OFF_BASE_ADDR+0x60000)
-#define PWM2_IPS_BASE_ADDR              (AIPS2_OFF_BASE_ADDR+0x70000)
-#define PWM3_IPS_BASE_ADDR              (AIPS2_OFF_BASE_ADDR+0x80000)
-#define PWM4_IPS_BASE_ADDR              (AIPS2_OFF_BASE_ADDR+0x90000)
+#define PWM1_BASE_ADDR                  (AIPS2_OFF_BASE_ADDR + 0x60000)
+#define PWM2_BASE_ADDR                  (AIPS2_OFF_BASE_ADDR + 0x70000)
+#define PWM3_BASE_ADDR                  (AIPS2_OFF_BASE_ADDR + 0x80000)
+#define PWM4_BASE_ADDR                  (AIPS2_OFF_BASE_ADDR + 0x90000)
 #define SYSCNT_RD_IPS_BASE_ADDR         (AIPS2_OFF_BASE_ADDR+0xA0000)
 #define SYSCNT_CMP_IPS_BASE_ADDR        (AIPS2_OFF_BASE_ADDR+0xB0000)
 #define SYSCNT_CTRL_IPS_BASE_ADDR       (AIPS2_OFF_BASE_ADDR+0xC0000)
@@ -970,6 +970,23 @@ struct aipstz_regs {
 	u32	opacr4;
 };
 
+#define PWMCR_PRESCALER(x)	((((x) - 1) & 0xFFF) << 4)
+#define PWMCR_DOZEEN       BIT(24)
+#define PWMCR_WAITEN       BIT(23)
+#define PWMCR_DBGEN        BIT(22)
+#define PWMCR_CLKSRC_IPG_HIGH  (BIT(17) | BIT(16))
+#define PWMCR_CLKSRC_IPG   BIT(16)
+#define PWMCR_EN           BIT(0)
+
+struct pwm_regs {
+	u32	cr;
+	u32	sr;
+	u32	ir;
+	u32	sar;
+	u32	pr;
+	u32	cnr;
+};
+
 struct wdog_regs {
 	u16	wcr;	/* Control */
 	u16	wsr;	/* Service */

-- 
2.52.0

