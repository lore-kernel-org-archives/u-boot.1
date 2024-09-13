Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0981FA3738
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 10:01:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 887C788CC1;
	Fri, 13 Sep 2024 11:57:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BF7my6NE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7CCB88D7C; Fri, 13 Sep 2024 11:57:37 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04A0488D97
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:57:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a8d2b4a5bf1so253489066b.2
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 02:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1726221447; x=1726826247;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uMqrX/ueWFxmHIyE51MucJPFAAWhhqGdobRjvQZoM2o=;
 b=BF7my6NE/DdZLQZA7z1yQW3uQlrW5nkqev8R2AZPdgDy7o38zcsxdiwMqzF1+aeCsx
 +gQYpjdzi+D/HiCLRfCecraEh/0WuQjxzV/cnxjEOgUhUA8r7oI3anLDhxxLleTznsHb
 /9h2ms/7yIngkUBhwHCF6sHCusQtUkzhNSh58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726221447; x=1726826247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uMqrX/ueWFxmHIyE51MucJPFAAWhhqGdobRjvQZoM2o=;
 b=ngAdSfek9FtiZqtg5DJpQft0KS33RSvjmdVjTbNsv0YIBqm/TcVzmpalOMQ7u0Xxb+
 cfX65EAlk0u0zUxWE1+RDrrnKSti6mqbuwjUrXLyWG6tawQzl8Utbu1wIZ0TX56J5Q9Y
 SX7k4o2p+XwsG76Jdvwe0iuRfVu05RlEkL7VtuCXVqACcxM7ljsLkSwHJ+azNozjs78Z
 iQ3r+LZL+o6VUqq1IVt0h+1CARE3GybUqaVYrcP3A+es7314JbbO1OXTiwdaLdXOab6S
 VufRxoNaPy7pGMI7Z2E3jVVEWVzWLbqHY1biezfI+eTd4OFjw6F9aOM+AGsQ0gj3AOh+
 wDHQ==
X-Gm-Message-State: AOJu0YzqTATCsjkdBcBHkOZLRYWAwfNCkTI6Z7vBf5HD9mPtYVWYM6nK
 /MP2Em2ba4BnkRAYWNlPCJQpSvqP20Udic5/h76TzoL/RmHtmUEl1BPxekTolI5uZWVDpBg9/8O
 kSco=
X-Google-Smtp-Source: AGHT+IF81BEZ+dPAcVN6E8N0UNF8DJjXuSFKCGg4X9rhVoAZQ74agL+4vo8uB4PYCuIFBjeZjwt8Bg==
X-Received: by 2002:a17:907:e6e8:b0:a86:7ddf:2909 with SMTP id
 a640c23a62f3a-a90294fcf3bmr574413166b.14.1726221447125; 
 Fri, 13 Sep 2024 02:57:27 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-87-4-102-18.retail.telecomitalia.it. [87.4.102.18])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25cee72bsm863224766b.173.2024.09.13.02.57.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 02:57:26 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>, linux-amarula@amarulasolutions.com,
 michael@amarulasolutions.com, Miquel Raynal <miquel.raynal@bootlin.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, Minkyu Kang <mk7.kang@samsung.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 23/26] video: bridge: samsung: support simple frame-buffer
Date: Fri, 13 Sep 2024 11:56:05 +0200
Message-ID: <20240913095622.72377-24-dario.binacchi@amarulasolutions.com>
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
off the power domains or disable the peripheral if you want to support
such feature.

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/video/bridge/samsung-dsi-host.c | 9 +++++++++
 drivers/video/bridge/samsung-dsim.c     | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/drivers/video/bridge/samsung-dsi-host.c b/drivers/video/bridge/samsung-dsi-host.c
index dd3e33c4edc7..2d0e8f71a756 100644
--- a/drivers/video/bridge/samsung-dsi-host.c
+++ b/drivers/video/bridge/samsung-dsi-host.c
@@ -1281,6 +1281,7 @@ static void samsung_dsi_set_standby(struct samsung_dsi *dsim, bool standby)
 	samsung_dsim_write(dsim, DSIM_MDRESOL_REG, mdresol);
 }
 
+#if (!IS_ENABLED(CONFIG_VIDEO_DT_SIMPLEFB))
 static void samsung_dsi_disable_clock(struct samsung_dsi *dsim)
 {
 	u32 reg;
@@ -1294,6 +1295,7 @@ static void samsung_dsi_disable_clock(struct samsung_dsi *dsim)
 	reg &= ~DSIM_PLL_EN;
 	samsung_dsim_write(dsim, DSIM_PLLCTRL_REG, reg);
 }
+#endif
 
 static inline struct samsung_dsi *host_to_dsi(struct mipi_dsi_host *host)
 {
@@ -1515,6 +1517,12 @@ static int samsung_dsi_enable(struct udevice *dev)
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_VIDEO_DT_SIMPLEFB)
+static int samsung_dsi_disable(struct udevice *dev)
+{
+	return 0;
+}
+#else
 static int samsung_dsi_disable(struct udevice *dev)
 {
 	u32 intsrc;
@@ -1532,6 +1540,7 @@ static int samsung_dsi_disable(struct udevice *dev)
 
 	return 0;
 }
+#endif
 
 struct dsi_host_ops samsung_dsi_ops = {
 	.init = samsung_dsi_init,
diff --git a/drivers/video/bridge/samsung-dsim.c b/drivers/video/bridge/samsung-dsim.c
index 986f1d830844..36e45abb3009 100644
--- a/drivers/video/bridge/samsung-dsim.c
+++ b/drivers/video/bridge/samsung-dsim.c
@@ -144,5 +144,8 @@ U_BOOT_DRIVER(samsung_dsim) = {
 	.remove				= samsung_dsim_remove,
 	.probe				= samsung_dsim_probe,
 	.ops				= &samsung_dsim_ops,
+#if IS_ENABLED(CONFIG_VIDEO_DT_SIMPLEFB)
+	.flags				= DM_FLAG_LEAVE_PD_ON,
+#endif
 	.priv_auto		= sizeof(struct samsung_dsim_priv),
 };
-- 
2.43.0

