Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60813FA3737
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 09:58:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C9BD88CEC;
	Fri, 13 Sep 2024 11:57:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RnwYkMcZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D0DE88CEB; Fri, 13 Sep 2024 11:57:21 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61A7988CF5
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:57:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c413cf5de5so2475785a12.0
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 02:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1726221433; x=1726826233;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sxKn7zYHdkKdM/iSFyU24zxOLq0ckhHvTkHpRTNJoDw=;
 b=RnwYkMcZNbJfpFf/qI+1m9sP3GB/Rv5fZPDjHu7EKOiAkHhvyw5JJingAEKcXhodZv
 0SSVDl2Sub4ub3MpCgh6NfDX5xxoLRr8AG8Ul5pn/8qZoRTOSX0Zqeu1ng5BW0ZHt9lI
 0l7mIFP+XwBIRsWZrSVPWEIjVazD4Bt2Mk0FQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726221433; x=1726826233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sxKn7zYHdkKdM/iSFyU24zxOLq0ckhHvTkHpRTNJoDw=;
 b=tXn3hqkfAcyA70WLMv5lEq8UYxy6Ud2LYh/WeKiRFN8OFkULFkPuJ1zU80sAs3i+t/
 KLLTOS0KX/hjej9SPQhQnAwgRHErPjztUbL+fq51lZch4b+AnwMhmt0zSjdHrSJBHB5a
 OO1piDrhKluygznk4KSM5bHcS8uYGfn3BLgSKhVMAYkSlhUJuGoOUB3edkgLIfQn1X0Q
 01LZNGv/0M8Dj/jFDJrI5oEcU1FE/WgbYAbMovv9Csr3Whw50Va6PHQcbXLSnEhKwPY1
 wK2N1A/CKsxc1SwSklXMXYyrcvbVfLCjZFXXuyvU67X+uroKEt9liC9d69g0j+gpafk/
 ElMw==
X-Gm-Message-State: AOJu0YxOQ2vQ5LVJLBU1jYj24X0MnkTdwq+KsR6CpdOn0yPYjH64OGIw
 PNnTTnBLdInhIrVMKZRJCsQSO5f3DvlPt+ol0dg1BN7LGkrIjYYwPt94mR8fo5ISw2wr2jVuq4B
 ugn8=
X-Google-Smtp-Source: AGHT+IHplyITN096+8HVqCJbNcFo77Jt4U4HUojcVcs2DMa1R91PQTMyu0buWygVv+Dg1/Fxf8sw2Q==
X-Received: by 2002:a17:907:e61a:b0:a8a:913e:418b with SMTP id
 a640c23a62f3a-a9029438eedmr569126066b.20.1726221432570; 
 Fri, 13 Sep 2024 02:57:12 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-87-4-102-18.retail.telecomitalia.it. [87.4.102.18])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25cee72bsm863224766b.173.2024.09.13.02.57.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 02:57:12 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>, linux-amarula@amarulasolutions.com,
 michael@amarulasolutions.com, Miquel Raynal <miquel.raynal@bootlin.com>,
 Ye Li <ye.li@nxp.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/26] video: dsi_host: add disable host interface
Date: Fri, 13 Sep 2024 11:55:53 +0200
Message-ID: <20240913095622.72377-12-dario.binacchi@amarulasolutions.com>
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

From: Michael Trimarchi <michael@amarulasolutions.com>

Current operations structure has provided disable callback, but
there is no API from dsi_host uclass to use it.

Add this disable host interface, so that dsi bridge can call it
to disable host

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/video/dsi-host-uclass.c | 10 ++++++++++
 include/dsi_host.h              |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/video/dsi-host-uclass.c b/drivers/video/dsi-host-uclass.c
index fde275ad7e2e..745991f8dd94 100644
--- a/drivers/video/dsi-host-uclass.c
+++ b/drivers/video/dsi-host-uclass.c
@@ -34,6 +34,16 @@ int dsi_host_enable(struct udevice *dev)
 	return ops->enable(dev);
 }
 
+int dsi_host_disable(struct udevice *dev)
+{
+	struct dsi_host_ops *ops = dsi_host_get_ops(dev);
+
+	if (!ops->disable)
+		return -ENOSYS;
+
+	return ops->disable(dev);
+}
+
 UCLASS_DRIVER(dsi_host) = {
 	.id		= UCLASS_DSI_HOST,
 	.name		= "dsi_host",
diff --git a/include/dsi_host.h b/include/dsi_host.h
index 83f8839db68d..5873ab698d9e 100644
--- a/include/dsi_host.h
+++ b/include/dsi_host.h
@@ -70,4 +70,12 @@ int dsi_host_init(struct udevice *dev,
  */
 int dsi_host_enable(struct udevice *dev);
 
+/**
+ * dsi_host_disable
+ *
+ * @dev:	dsi host device
+ * @return 0 if OK, -ve on error
+ */
+int dsi_host_disable(struct udevice *dev);
+
 #endif
-- 
2.43.0

