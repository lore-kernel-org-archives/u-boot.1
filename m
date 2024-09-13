Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E57CFA3738
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 10:00:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EA1B88C3E;
	Fri, 13 Sep 2024 11:57:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Hinl+xU7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E0BB8855C; Fri, 13 Sep 2024 11:57:36 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8EE688965
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:57:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a8d0d0aea3cso233669966b.3
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 02:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1726221446; x=1726826246;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XyZMgmVmdG4fiZHCiw9uZQLu6FufQEMaaUVl/Ul2c4M=;
 b=Hinl+xU7rMJZpsrnZDsLvo4o30jR7/nAtxSFMM3yERNj43fbz4U+zPj2bIuQWCB3rS
 1W7/JLHl09m8WDJ7a26IKqYKMZRMdirLaXanm+Wp/IlckBXZsuMqAeZHXBmKQk+UEgWr
 LbDbTlPUqtcZqBMG+71U1ZsmjK3hLSezwMMDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726221446; x=1726826246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XyZMgmVmdG4fiZHCiw9uZQLu6FufQEMaaUVl/Ul2c4M=;
 b=SXBH2NhgffN4V69Et//dG7Q92JrSlxLPy96zsR46ZDdrh3Z5TN2kMgM8x0Z0vUhHxa
 H39ZCJMV9JTlK6QkFOsZ/qTwaluW+caLNQRX0zfybz9sHzTK0FgUceUtQLVc1efIwkz9
 YqzB+x2mYXhb6xPibehK5q4Oj0UDc6o9frb+a5DcJa41TF/Kob36hc0ZI79Q6yvXJaqC
 tnYdumzYNrnkVZqZ2Na89fWxT70V4l/C/xoqpyNnW+EEz8eUWcoa/qpTCBmKdmKaqAV6
 WIBO5f3E0cpXAXAjQo/SSDnWPe3OxEaJ2RwDhA5ho0H/a5JJr3acn9Qb0jAQLxlHi4YB
 zAgg==
X-Gm-Message-State: AOJu0Yziq6gp1OJozZzVAmch7Dzb7N4BK0QPl5bRTtwVmy0pIZxxg0cv
 RZvyVlp4CkBXt1HFK00iMthlfJNw7G9CR1rfi0JKAiJC7Xtli77CcaWMTFskTr2jZbjgzkO6ujP
 Oweo=
X-Google-Smtp-Source: AGHT+IG0Czi0LmJj3dy0YYZHDEX/5oqiJFTFpX3m0uGqky2KRToMVPuU4UslRz325va17AolnXMLkg==
X-Received: by 2002:a17:906:d7ce:b0:a8d:4e13:55f9 with SMTP id
 a640c23a62f3a-a9029438220mr553279966b.19.1726221446083; 
 Fri, 13 Sep 2024 02:57:26 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-87-4-102-18.retail.telecomitalia.it. [87.4.102.18])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25cee72bsm863224766b.173.2024.09.13.02.57.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 02:57:25 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>, linux-amarula@amarulasolutions.com,
 michael@amarulasolutions.com, Miquel Raynal <miquel.raynal@bootlin.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>,
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH 22/26] video: mxsfb: support simple frame-buffer
Date: Fri, 13 Sep 2024 11:56:04 +0200
Message-ID: <20240913095622.72377-23-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
References: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

If you want to pass the frame-buffer to the kernel, the video output is
initialized by U-Boot, and kept by the kernel. The patch does not turn
off the power domains or reset the peripheral if you want to support
such feature.

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/video/mxsfb.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index 45431f0a1047..06b2a2461246 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -422,7 +422,8 @@ static int mxs_video_remove(struct udevice *dev)
 	if (priv->disp_dev)
 		device_remove(priv->disp_dev, DM_REMOVE_NORMAL);
 
-	mxs_remove_common(priv->reg_base, plat->base);
+	if (!IS_ENABLED(CONFIG_VIDEO_DT_SIMPLEFB))
+		mxs_remove_common(priv->reg_base, plat->base);
 
 	return 0;
 }
@@ -445,6 +446,10 @@ U_BOOT_DRIVER(mxs_video) = {
 	.bind	= mxs_video_bind,
 	.probe	= mxs_video_probe,
 	.remove = mxs_video_remove,
+#if !IS_ENABLED(CONFIG_VIDEO_DT_SIMPLEFB)
 	.flags	= DM_FLAG_PRE_RELOC | DM_FLAG_OS_PREPARE,
+#else
+	.flags	= DM_FLAG_PRE_RELOC | DM_FLAG_OS_PREPARE | DM_FLAG_LEAVE_PD_ON,
+#endif
 	.priv_auto   = sizeof(struct mxsfb_priv),
 };
-- 
2.43.0

