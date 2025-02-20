Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC05C021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 17:07:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 403A480F7D;
	Thu, 20 Feb 2025 18:06:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Iyr3HzM7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 708F480F68; Thu, 20 Feb 2025 18:06:57 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57B3480F53
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 18:06:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-54527a7270eso1268940e87.0
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 09:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740071215; x=1740676015; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rcutgW2n40HBioKAx9uRtbUGxHoarl0LhgAk1IdumhU=;
 b=Iyr3HzM7dcbcJjJzdrX8bIPWL/lq54yKloUn3M8gw0ymvobS4aPKr5Ki/tr9M2z9Fp
 AOo+o3GPGg69R8+f+EnbmES7L+QuGnTeoSxXZynpOqZmpmWXYXXefCvZVpihuZLuSkbJ
 4MdZ8Yuqj33R+pzXeHmrkfeEpcjgMglOK+3qJsRsDWuYSFNMbCuDKNcwI5agr9Q/EaQP
 RG9or3JU/7QV5IYM/q5nmGXjg345TUax4QcfF0op1tsOLqOyqHxkmbC33cQxJP7CBy4z
 ztE1mhPWap8QyC44b0FK1koTefWDpXi9Vjww4sWJOtpGlfXArtO4eNJOLiGXJ/poBj4c
 /VGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740071215; x=1740676015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rcutgW2n40HBioKAx9uRtbUGxHoarl0LhgAk1IdumhU=;
 b=VMWixYm+y8Ba7HNYNxF6CnYKumKVp9CA8FgLlpURvEfeDefi3pxY/vgky7ArA/8rC4
 t17ogCLVzvbd+eKdzciDrREjhFKpiIKQo9nP9tE7pdst0aZGAEeesRNxQlkTMH6vlqFQ
 7kgq5YqhS2mAprvJd24itt/T4s5uQqyDam5EusxIhc83Kz7BNP75G7RXc+5PAW6nJR9D
 3pk59ITJokCURiOaSKoQvjj0cfojRZIkKefSBbu9UyaIgHnZkrvPi3kxGyF9Kn+fINe1
 cqJl7fe1W2VH6l5Ky5uV1y3RHjHnMZHNUR0jp6NgAKt8/EDS+hbFwAu2GxV1AAz2xph1
 cTig==
X-Gm-Message-State: AOJu0Yx2s6NsYs1aLYL74/H67g/7WRpvVTVWwfGN+TnFDEUi2ofN7MAU
 3ft4pOjP+m6cQ6EOpA8rpiZXICHANuyL+W+LyAVNaeGPKMrBBri+
X-Gm-Gg: ASbGncs0s4q8SJP9HJkSWECxIVzPmaPw2tMG3p6RHqbKuSPPu+LUd9dQL9Mear1DP5N
 tHeQlju8cHnvHOHjq6+d/pv85kuHh7TLxfeFXVVMhXoROya5haftDDQwho6fLgjEBdaT8UUPsIz
 F/KY17gVDLxd3Ns2uoQY5Lk4R8pNIWetOija6AN54AzszNyl9Em5vaue4DaIJZO5OLFewxTifat
 CYk7BCW8GBF12mPlXZ10wgCMvKjmMpjL7snjVBSzkCTCiCS/bTdQcLWXLhm/SCE81XjAfhJC3I+
 j4gZH24=
X-Google-Smtp-Source: AGHT+IGvxaTtY/fZC8FVgc+S+ISBUPo99B6lW96SA+IVK+yiBtYOMJyq86tL0JOuPCe2p7n7dWzbWQ==
X-Received: by 2002:a05:6512:238a:b0:53e:39e6:a1c1 with SMTP id
 2adb3069b0e04-5452fe8f3c0mr10182705e87.43.1740071214352; 
 Thu, 20 Feb 2025 09:06:54 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-547df6106f6sm81828e87.204.2025.02.20.09.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 09:06:54 -0800 (PST)
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
Subject: [PATCH v2 1/3] video: bridge-uclass: add get_display_timing ops
Date: Thu, 20 Feb 2025 19:06:27 +0200
Message-ID: <20250220170629.228485-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220170629.228485-1-clamor95@gmail.com>
References: <20250220170629.228485-1-clamor95@gmail.com>
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

