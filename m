Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7BED44C46
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 13:53:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89B9C836C8;
	Thu, 15 Jan 2026 14:53:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Zihlhl1b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F9C883655; Thu, 15 Jan 2026 14:53:25 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0181782BF2
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 14:53:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.bonnefille@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 9D25B1A2889;
 Thu, 15 Jan 2026 13:53:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7261E606B6;
 Thu, 15 Jan 2026 13:53:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 035E610B68602; Thu, 15 Jan 2026 14:53:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1768485201; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=wnCfrdoyHud71GD6d1BgHsXnPXhn7y69V1MZyPF0zuI=;
 b=Zihlhl1bEGMaJyUU8Va1FMXAhxBweT3mf8Jf/lJGgGBgwkkn3/QlJ915cCx4Xlcdln73Zb
 JqTxAWycOOrIWzlMqApOOE+ptHkFwnPxRa7XKxTunJAt65BBx8JRlv8wAmqJPhCn41yi77
 m2dfccmUu+qY4rGbsp2tgXM+BxS64TAAamdrMxBZ8ZslZCgsHcA26x685utbV+4c/Je3E1
 JtpMtHZUkswU5cHrvlQ2elkl2u2mgsgPL27r2fCPpKbQPElCRnj5cvnlbuQ3Hx1NxuwFkv
 K37fIJ0hAQ603pucu84YfDoIHo8kaGoBDzs0wG8iXArKL+A348vxBNp9sVxXxg==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Thu, 15 Jan 2026 14:52:44 +0100
Subject: [PATCH v2 1/5] drivers: video: mxsfb: Use kconfig VIDEO_REMOVE to
 remove video
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-repair_imx7_splash-v2-1-6595491341ba@bootlin.com>
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

Conditions the removal of the video driver to the existence of the
VIDEO_REMOVE kconfig parameter on the model of what has been done on
commit b8d3a6c7d12f ("drivers: video: tidss: tidss_drv: Use kconfig
VIDEO_REMOVE to remove video") for TI DSS driver.

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
 drivers/video/mxsfb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index e72839cead4..f30818d90c7 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -375,9 +375,11 @@ static int mxs_video_bind(struct udevice *dev)
 
 static int mxs_video_remove(struct udevice *dev)
 {
-	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
+	if (CONFIG_IS_ENABLED(VIDEO_REMOVE)) {
+		struct video_uc_plat *plat = dev_get_uclass_plat(dev);
 
-	mxs_remove_common(plat->base);
+		mxs_remove_common(plat->base);
+	}
 
 	return 0;
 }

-- 
2.52.0

