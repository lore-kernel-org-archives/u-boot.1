Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1C2D1036D
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 23:42:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81EC18415E;
	Wed, 26 Nov 2025 00:42:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="YJx7JOUK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCF9E8416E; Wed, 26 Nov 2025 00:42:37 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B62984159
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 00:42:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.bonnefille@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 97CC54E418D0;
 Tue, 25 Nov 2025 23:42:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6E7FF606A1;
 Tue, 25 Nov 2025 23:42:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E7D0F102F080E; Wed, 26 Nov 2025 00:42:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1764114152; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=6w9R2ziFxsYT5rvLlWrH9pSIOD2XpvYd7U3LbxXRWHo=;
 b=YJx7JOUKed9EViGM5JlVa5q0e2D5MK71ogJO4SBpGbWNQV4MWg1576hmjM0hxIEZhUr+Ln
 iOcmGc0Hg3c6zwtLAhxZih+llJevYdWO9ehsUrGROj/YzT9UesoW4deh7S+Fi53FBMvfQz
 kQkh2n65aFERUSlXpYrPaDk874BfFXQ3Y180FPqAyGS7Z8tEBw8x3n6pOUFEbVXWREsHRO
 J19+UKsKBKnqowrGe09D6IX2KN9Ac2iQYwTYC6o9fVjq+7KERZGk2+WrYSaSb9WW649XPY
 v4+zZxCOdxa1yZPP0BBtXn3x3gWAoUGll3LFxyPokyVnH4/0AKQKJ9Eei/spzw==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Wed, 26 Nov 2025 00:41:53 +0100
Subject: [PATCH 1/5] drivers: video: mxsfb: Use kconfig VIDEO_REMOVE to
 remove video
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-repair_imx7_splash-v1-1-d3877afb7381@bootlin.com>
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

This commit condition the removal of the video driver to the existence
of the VIDEO_REMOVE kconfig parameter on the model of what has been done
on commit b8d3a6c7d12f ("drivers: video: tidss: tidss_drv: Use kconfig
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

