Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBEAC021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 12:02:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B5CB80F56;
	Mon, 24 Feb 2025 13:02:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="js8srJDM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EAE880F88; Mon, 24 Feb 2025 13:02:40 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91E9E80F53
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 13:02:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-546210287c1so4486638e87.2
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 04:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740398558; x=1741003358; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IvLAPLBjp2456CxZbGHRRFLrr78uOKJXhmAAQ6F6zxg=;
 b=js8srJDM5ZRf8xtVwNWyCjb4r4GEaZiwWlrRv1XCXXhjXPTEXYR3wv+pkSxfryFHMP
 gDwW7AEceSSFkreH2HjoC0EYyjaTPf0hFLtPx4ThqxIfXPf9e45rmcVPrr+PXaZ9ZlWV
 9/Acd5WO2Xy8vUPvqwn+De+a8lgnA+aYl4S3qCFG3PG6538GqL6ephF12eIOjdam/3fe
 nTrwUT2nk3+xP7roFLGiu7KneG0E0TpRTXsGGX7uDf/2AhjH9KNR7aS1XQmiLhvRb//r
 5HNC2LJkJFA2Qc0Ys/p/WAu6/sgnopFUpJELeV2aT/6jmmO7cmjcRIgin0wKDp2vMy/q
 W1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740398558; x=1741003358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IvLAPLBjp2456CxZbGHRRFLrr78uOKJXhmAAQ6F6zxg=;
 b=Yt3tXDh9mSn5I1V7SZXdWYGIwhTplOgcuT74apbfgodWmZGGu0hbmPScuhGoNvJxJb
 FonqHB4fQaQh+v9iq3I4Kjh7QtvqvY6aLdr1vEy5MLDVJot8eDi3HQtiF2j421WCIKHI
 HgFbI2a7ZG/xuFM2ZkoPF8/743gDYeXfd9AaLFyah7HUh4WDroX3yHCl0k79KmgXr/fh
 ybv09onb0ulGIIdWE1N9rTrrTagFT8yuLk+QXbFFnJH22LCWIEV/RESOxcSDEDplEgOK
 JNRIftPSjnO/RIFgG9xUe80tFnMZiVCu5hyz+jDj2HD2gUB2P2YX0BZ+h4KiEAM0q0BU
 fMLg==
X-Gm-Message-State: AOJu0Yx8J0gmX25e0PnrVN7brgj9vD6zMnXxx6bgXUkl2xXra3TmNBpn
 xL2ppzflZGUCNnhbjOxnm0clJm0XZKvQKwwxi8ZXjQK60ktjhZET
X-Gm-Gg: ASbGnctFIwLM5KdDmyKwIz/CMKtSk2yxYs8tZZye7gZR2MVFR+b2EiWGXHO+ZryrRd1
 mhjQrSWJDDNIOdepcEkeM3Dyo1XPhNP7gXMDdXEEMoQW9ks8Symtv/fjE1S9RX/UkuDVXlUUxjQ
 Y0jNhoyEIfxfDV61FLwmeK/qpgVcaPw7+fEI+pNYAGT20YvZUkArkYbuJgmOHYXlzqh+/NPSxOV
 jhQH4aeCwUeucmRULBLl6ZCFBDoHpqN7gstsrtEuRTCza0VT3aL5ksI7qwsSXFjY4hHd0+uCfWu
 vOLSFCS/xkf4mLqE
X-Google-Smtp-Source: AGHT+IEz0ctNlGJLq37yIUboZUMNix48ALoaVz/Do9Gw+ZPWvSaPYLSUXm1XjVgpRNIXz0j99qfpuA==
X-Received: by 2002:a05:6512:b0a:b0:545:1d96:d701 with SMTP id
 2adb3069b0e04-548392598eamr4963941e87.36.1740398557643; 
 Mon, 24 Feb 2025 04:02:37 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54838eabfd7sm987159e87.187.2025.02.24.04.02.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 04:02:37 -0800 (PST)
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
Subject: [PATCH v3 2/4] video: bridge-uclass: add inline fallbacks of video
 bridge functions
Date: Mon, 24 Feb 2025 14:02:12 +0200
Message-ID: <20250224120214.147646-3-clamor95@gmail.com>
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

Hide video bridge functions behind config condition and add inline
fallbacks to avoid erroring out when using header without config
enabled.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 include/video_bridge.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/include/video_bridge.h b/include/video_bridge.h
index 7158deb299a..00e9804565c 100644
--- a/include/video_bridge.h
+++ b/include/video_bridge.h
@@ -80,6 +80,7 @@ struct video_bridge_ops {
 #define video_bridge_get_ops(dev) \
 		((struct video_bridge_ops *)(dev)->driver->ops)
 
+#if CONFIG_IS_ENABLED(VIDEO_BRIDGE)
 /**
  * video_bridge_attach() - attach a video bridge
  *
@@ -128,5 +129,37 @@ int video_bridge_get_display_timing(struct udevice *dev,
  * Return: number of bytes read, <=0 for error
  */
 int video_bridge_read_edid(struct udevice *dev, u8 *buf, int buf_size);
+#else
+static inline int video_bridge_attach(struct udevice *dev)
+{
+	return -ENOSYS;
+}
+
+static inline int video_bridge_set_backlight(struct udevice *dev, int percent)
+{
+	return -ENOSYS;
+}
+
+static inline int video_bridge_set_active(struct udevice *dev, bool active)
+{
+	return -ENOSYS;
+}
+
+static inline int video_bridge_check_attached(struct udevice *dev)
+{
+	return -ENOSYS;
+}
+
+static inline int video_bridge_get_display_timing(struct udevice *dev,
+						  struct display_timing *timing)
+{
+	return -ENOSYS;
+}
+
+static inline int video_bridge_read_edid(struct udevice *dev, u8 *buf, int buf_size)
+{
+	return -ENOSYS;
+}
+#endif /* CONFIG_VIDEO_BRIDGE */
 
 #endif
-- 
2.43.0

