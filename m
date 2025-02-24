Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CEE3C021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 12:02:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4455580F5C;
	Mon, 24 Feb 2025 13:02:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SbQMKFM0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60B3380F5C; Mon, 24 Feb 2025 13:02:39 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DE45805C4
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 13:02:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-30737db1aa9so41737751fa.1
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 04:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740398556; x=1741003356; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wtmyrb/h9dQz46wR+thZEPTTAznOxavyO77fI0n0qIk=;
 b=SbQMKFM0LJzhbzHIHVZtAzsVl79XY5a1qKf9i1zke3WZ6cEVoF6DNdgs3Jk2cpFXP+
 ckWZ5jNysyshi0ZzYvVCZ4UHjpJ96+w6AZyXM5afEn5bR9J7Cb+h9MwrZdP/KnWWHJ0b
 c4ykwTUPiSIc6DdXKil82akjscHalSshxJMNifIdM2jSR+H7F/lrUmtJedhK1o+Feqha
 0lbRyjCMFsCRfCbf3jLIZKy278HFQ/cRnCRwxQ8bF9wx7TZ9AtihQ2KDUwW/NC73OGqX
 byjz1o5699b12HchHR7M+sFWCnvkqp56F0Dy3vR6pp2gH6ahnHGs1sk/OnI7KxnYJhW7
 ImtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740398556; x=1741003356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wtmyrb/h9dQz46wR+thZEPTTAznOxavyO77fI0n0qIk=;
 b=EJTfuNdPJpwWQYcQJWjYJC7YgHzTS+ad4tQh0lOZNZyFERFw4bqB76+MNe8w10nMYG
 iaXTWZlFQwtI4aCebcuXdemcIPixtAvpVI+7RJnzr7H2z6o3wQ6OKlVEzF/Mkbqm0tg/
 IpTTTcBBXl3EjHbbIJLv+q+eDRYZLX25LVImzh5np3DIEfJQ3+CahOkDrTTeCwUivH/G
 DrKTMh5H1qQaX/NwV25uSPR2XgiEdWPE/eLSJ+DJByr1S36U58C7W2BnzhuWCin73ypp
 Q7QluypMHt5YrEoaexA+1p0mcSTpQ3t7NHLQvd0WmdW8oUTOaYuuy7ud2O019GillBiJ
 7utA==
X-Gm-Message-State: AOJu0YzXssGLw1St+p6lpWw6RZNxfLntfs5v7ZWGYd3hTRfKSFVxn0cD
 fLhd/sVSVzIzdmiD0CqcRMX3LFT7tz24eduY03J1T05foOu+xl8T
X-Gm-Gg: ASbGncswTYr5CcroK/ojXkOA0AbCeMkk0IqbpQ56x+1zFNNdF8F4uY1PgOaUbhEwcRn
 NuRPfxWO3DTbGwJ3hTwh4gjo09B6gp0hHVDkz6wmHUuvjXaMUgwsxe803z/LJdYYO9HPyB3X39o
 +ZQ8SoxEgmmzXF6zldnHGqb9crmfmm1YxmeUDBCPOQJzwirSsVS61RpIlP0zGH3DpSwJ70GXQOx
 w1pwZk/dmfXCk3zJNNrm0tfsrI5jBIrJ9R5srusyJxFGx4n49cYi8IiUQrMOhlcPJDgqC3FMMRZ
 ZHwmTNpFOyWC1H3b
X-Google-Smtp-Source: AGHT+IH+62xY30jHrefqEFA2NrbonuhBMfNzBwz1yu2BfyvCn32O18g1NbFwkhsmG2Kp3FuXxC2meg==
X-Received: by 2002:a05:6512:1244:b0:545:1104:617d with SMTP id
 2adb3069b0e04-54838eddea5mr5720032e87.11.1740398556148; 
 Mon, 24 Feb 2025 04:02:36 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54838eabfd7sm987159e87.187.2025.02.24.04.02.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 04:02:35 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heiko Schocher <hs@denx.de>, Guillaume La Roque <glaroque@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 1/4] video: bridge-uclass: add get_display_timing ops
Date: Mon, 24 Feb 2025 14:02:11 +0200
Message-ID: <20250224120214.147646-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224120214.147646-1-clamor95@gmail.com>
References: <20250224120214.147646-1-clamor95@gmail.com>
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

Add get_display_timing ops for internal bridges linked to
panels that do not support EDID (MIPI-DSI panels for example)
or have EDID not routed.

Tested-by: Dang Huynh <danct12@riseup.net> (PineTab 2)
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/bridge/video-bridge-uclass.c | 11 +++++++++++
 include/video_bridge.h                     | 21 +++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/video/bridge/video-bridge-uclass.c b/drivers/video/bridge/video-bridge-uclass.c
index 2084a2e03ee..1b8aa12b9e8 100644
--- a/drivers/video/bridge/video-bridge-uclass.c
+++ b/drivers/video/bridge/video-bridge-uclass.c
@@ -33,6 +33,17 @@ int video_bridge_attach(struct udevice *dev)
 	return ops->attach(dev);
 }
 
+int video_bridge_get_display_timing(struct udevice *dev,
+				    struct display_timing *timings)
+{
+	struct video_bridge_ops *ops = video_bridge_get_ops(dev);
+
+	if (!ops->get_display_timing)
+		return -ENOSYS;
+
+	return ops->get_display_timing(dev, timings);
+}
+
 int video_bridge_check_attached(struct udevice *dev)
 {
 	struct video_bridge_priv *uc_priv = dev_get_uclass_priv(dev);
diff --git a/include/video_bridge.h b/include/video_bridge.h
index 3b429eac578..7158deb299a 100644
--- a/include/video_bridge.h
+++ b/include/video_bridge.h
@@ -53,6 +53,19 @@ struct video_bridge_ops {
 	 */
 	int (*set_backlight)(struct udevice *dev, int percent);
 
+	/**
+	 * get_display_timing() - Get display timings from bridge.
+	 *
+	 * @dev:	Bridge device containing the linked display timings
+	 * @tim:	Place to put timings
+	 * @return 0 if OK, -ve on error
+	 *
+	 * This call it totally optional and useful mainly for integrated
+	 * bridges with fixed output device.
+	 */
+	int (*get_display_timing)(struct udevice *dev,
+				  struct display_timing *timing);
+
 	/**
 	 * read_edid() - Read information from EDID
 	 *
@@ -98,6 +111,14 @@ int video_bridge_set_active(struct udevice *dev, bool active);
  */
 int video_bridge_check_attached(struct udevice *dev);
 
+/**
+ * video_bridge_get_display_timing() - Get display timings from bridge.
+ *
+ * @dev:	Bridge device containing the linked display timings
+ * Return: 0 if OK, -ve on error
+ */
+int video_bridge_get_display_timing(struct udevice *dev,
+				    struct display_timing *timing);
 /**
  * video_bridge_read_edid() - Read information from EDID
  *
-- 
2.43.0

