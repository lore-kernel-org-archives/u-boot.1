Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5350FD1036D
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 23:43:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1900184159;
	Wed, 26 Nov 2025 00:42:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="vlfwD+j+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E096D84184; Wed, 26 Nov 2025 00:42:45 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29C738415D
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 00:42:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.bonnefille@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id BFC8F1A1D5A;
 Tue, 25 Nov 2025 23:42:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 96968606A1;
 Tue, 25 Nov 2025 23:42:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id F4068102F080E; Wed, 26 Nov 2025 00:42:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1764114157; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=XTLxaiDc7FDxW9JVaXd8dHxTlyfYFlItGH60B0Cq6a0=;
 b=vlfwD+j+XmXUHW+LS6E97lQO2cYvJ254dO5Xo1Tgb2s0PdLHIc7b3RyNvFhtlaqT7RcEYk
 7pBGklkXTow91bmcTYIjqvZHh/i6CY9swBckT8r8CVzW1Jr1goFl+o2lMy/9+JeJfEPBrL
 08VRx0sPwEGi8LyWfrrjO0eLNjhULadGPpqnjDhJ6YCOCopfNeQPGAS/vLhaqgCHKy7bh1
 rKykPopWH2SJW1I7sgN5IzfAjii5sl9K0mJLdHSMKzcFUz9ABTM1DO0+JuRIuP2eik3aBd
 iAv/JrV4D58QnEuAYwK3pM1sEvF+M/1I0aBQgbi/4I+ZAcL/3ltr8JG2IkG2yw==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Wed, 26 Nov 2025 00:41:56 +0100
Subject: [PATCH 4/5] pwm: imx: allow i.MX7 to use PWM3 and PWM4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-repair_imx7_splash-v1-4-d3877afb7381@bootlin.com>
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

This commit creates a new condition in which i.MX7 SoCs will be able to
use the third and fourth PWM controllers in the pwm-imx driver.

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
 drivers/pwm/pwm-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 28187b4fcbb..8e655943eec 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -43,7 +43,7 @@ struct pwm_regs *pwm_id_to_reg(int pwm_id)
 		return (struct pwm_regs *)PWM1_BASE_ADDR;
 	case 1:
 		return (struct pwm_regs *)PWM2_BASE_ADDR;
-#ifdef CONFIG_MX6
+#if defined(CONFIG_MX6) || defined(CONFIG_MX7)
 	case 2:
 		return (struct pwm_regs *)PWM3_BASE_ADDR;
 	case 3:

-- 
2.52.0

