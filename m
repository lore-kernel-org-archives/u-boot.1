Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D39D44C46
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 13:53:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54303838BB;
	Thu, 15 Jan 2026 14:53:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="PT4FHQwQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 985CA82BF2; Thu, 15 Jan 2026 14:53:28 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBFEE80077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 14:53:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.bonnefille@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 765B81A2892;
 Thu, 15 Jan 2026 13:53:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4C404606B6;
 Thu, 15 Jan 2026 13:53:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B5C7410B68602; Thu, 15 Jan 2026 14:53:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1768485205; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=nXX+axz1cXhhxEdxsgsB3aATtq3231FrpsoWmzubn24=;
 b=PT4FHQwQpslwLv1Jy/yos/P4CDM49nxG/vh8Mra3hOx/HEXsrZikIiKhDWsIG6FklYtXnH
 JXGUCoCnGYG4mjNpivUSuYFwoDRtyOhr8/gau54ktW3sh88H5m0ndFiqM4spuiROCYoKWn
 eh0SvXx/StkqHMd8O8Gy1UPExhxaf82+0GY/3Exr05b4IAIBATVPzhvreztlGTYyx4PDpI
 HVSDsi++irn0URPbPBFCWI8TpU2YClya5RqNI6K2B93JxsJw9+Cxq9uG1f2obqLYLNu+Ga
 DiuMs4cHFUbaPsu2g6qUI+YE4+SiuX2U6/G0gPKSEstQIrFcKYlby/ue3XIFjw==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Thu, 15 Jan 2026 14:52:47 +0100
Subject: [PATCH v2 4/5] pwm: imx: allow i.MX7 to use PWM3 and PWM4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-repair_imx7_splash-v2-4-6595491341ba@bootlin.com>
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

Creates a new condition in which i.MX7 SoCs will be able to use the
third and fourth PWM controllers in the pwm-imx driver.

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

