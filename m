Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7058AFA3738
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 09:58:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E02C88C35;
	Fri, 13 Sep 2024 11:57:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="XNP17Uhx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40DE988C39; Fri, 13 Sep 2024 11:57:20 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BB6688CED
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:57:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c24c92f699so1734721a12.2
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 02:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1726221432; x=1726826232;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FFRO6COzZ3cv5Gq5S+ZSJewQI2yeUOKQWAgGGqlan8k=;
 b=XNP17Uhx7EwcoY42BtfUbOoIdSx9nKcAzzcBpvlU5OqxjeiWDpMisWWaLthL9siM2Y
 S23RWlp9S3+tw5b27sZB0cmGSXLGmZFERFqZeyb2s/Y5cq1RI1FnUtoHnK9L8nN7l094
 LMm/Rswr7cUiODpEp3BiwfqB7tqp0MRzr6ccg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726221432; x=1726826232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FFRO6COzZ3cv5Gq5S+ZSJewQI2yeUOKQWAgGGqlan8k=;
 b=oaXXVFd6u/eIFbA4c7x+hJ4vF/BcYb72Jqdks2GBn0UTl1CQX6hhH44OMQtC9J0jdw
 2s/aG9QlrjwexAF4r1XW9rErDVDNndSBN5+5kpaclkLZo6aSAoIcvC1nazNk/vKW1QrM
 WUGfsQrJI4tvnNwa0CcHujBnctL+IiOWdyydhn7wxokKervykT6ZLDseSe5LVwUuZFOy
 QQoYRTQ408EIAEN5FpuhBaJmKpy8hcmnWAuPt1j52B8iNVAyK8i62i1Vy3iZDAMnFfTJ
 l4poQm/4OnxRx0grqaSCgU6FRV+GE1shEPAn6aszmxtX0831y43NN2XrI/5wwC/cK0/y
 kqPA==
X-Gm-Message-State: AOJu0YyMtbEi197IUAF1muHaOtvktw0eO7fo1TFVPxn3J2mGl+4yZ2xq
 Ft6ox69msjbAuVEu8sQIYj0/RWKot+swy97dUU288W+GR8X2jRI8RWOTkoMWJ/R8KZjEvi0sO/U
 rXBM=
X-Google-Smtp-Source: AGHT+IH2VNdua9VM8+E7BbbOxGIpkymnKo9rlbG/NtsacVAVHCC6tDC8aMfoFK8PhM7u+zU2ryDzFg==
X-Received: by 2002:a17:907:1b05:b0:a72:69e8:f039 with SMTP id
 a640c23a62f3a-a902941d803mr498746166b.12.1726221431502; 
 Fri, 13 Sep 2024 02:57:11 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-87-4-102-18.retail.telecomitalia.it. [87.4.102.18])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25cee72bsm863224766b.173.2024.09.13.02.57.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 02:57:11 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>, linux-amarula@amarulasolutions.com,
 michael@amarulasolutions.com, Miquel Raynal <miquel.raynal@bootlin.com>,
 Ye Li <ye.li@nxp.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/26] video: bridge: Add check_timing interface
Date: Fri, 13 Sep 2024 11:55:52 +0200
Message-ID: <20240913095622.72377-11-dario.binacchi@amarulasolutions.com>
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

Add new interface check_timing to video bridge uclass. For bridge device
who may update timing needs to implement the callback. So host device can
sync the timing with the bridge.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/video/bridge/video-bridge-uclass.c | 10 ++++++++++
 include/video_bridge.h                     | 20 ++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/video/bridge/video-bridge-uclass.c b/drivers/video/bridge/video-bridge-uclass.c
index 2084a2e03ee8..7432107238cc 100644
--- a/drivers/video/bridge/video-bridge-uclass.c
+++ b/drivers/video/bridge/video-bridge-uclass.c
@@ -48,6 +48,16 @@ int video_bridge_check_attached(struct udevice *dev)
 	return ops->check_attached(dev);
 }
 
+int video_bridge_check_timing(struct udevice *dev, struct display_timing *timing)
+{
+	struct video_bridge_ops *ops = video_bridge_get_ops(dev);
+
+	if (ops->check_timing)
+		return ops->check_timing(dev, timing);
+
+	return 0;
+}
+
 int video_bridge_read_edid(struct udevice *dev, u8 *buf, int buf_size)
 {
 	struct video_bridge_ops *ops = video_bridge_get_ops(dev);
diff --git a/include/video_bridge.h b/include/video_bridge.h
index 3b429eac578a..8b71b04a1119 100644
--- a/include/video_bridge.h
+++ b/include/video_bridge.h
@@ -44,6 +44,17 @@ struct video_bridge_ops {
 	 */
 	int (*check_attached)(struct udevice *dev);
 
+	/**
+	 * check_timing() - check if the timing need update after the bridge device attached
+	 *
+	 * This method is optional - if not provided then return 0
+	 *
+	 * @dev:	Device to check
+	 * @active:	The timing to be checked and updated
+	 * Return: 0 if OK, -ve on error
+	 */
+	int (*check_timing)(struct udevice *dev, struct display_timing *timing);
+
 	/**
 	 * set_backlight() - Set the backlight brightness
 	 *
@@ -98,6 +109,15 @@ int video_bridge_set_active(struct udevice *dev, bool active);
  */
 int video_bridge_check_attached(struct udevice *dev);
 
+/**
+ * check_timing() - check if the timing need update after the bridge device attached
+ *
+ * @dev:	Device to check
+ * @active:	The timing to be checked and updated
+ * Return: 0 if OK, -ve on error
+ */
+int video_bridge_check_timing(struct udevice *dev, struct display_timing *timing);
+
 /**
  * video_bridge_read_edid() - Read information from EDID
  *
-- 
2.43.0

