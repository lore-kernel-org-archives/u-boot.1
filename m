Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0122BC021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 15:52:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8197180C98;
	Sat, 15 Feb 2025 16:52:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PL3bmxmE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4232080C77; Sat, 15 Feb 2025 16:52:19 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35E7C80C77
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 16:52:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5439a6179a7so3120451e87.1
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 07:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739634736; x=1740239536; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8UaB0V2z4wlJF51fzX5AgeeKg3sioCX/+q0DhfpLzUs=;
 b=PL3bmxmEif4RtdyWHBfm4xHN+ocPNV2GxB0n/nI0RPbhr3HpV2udLQtuVK+rccEM+A
 5bCCslyQ/26ZONi5F9vXF4/79HldxSnXlcLP9y6ezCf53XkpIGSMKkTg08aYGMKk8xjo
 +ABUjfthNstEOTWDnr6LGf49udRtXIBeBH545X8p2P5Vz05D7jeGx9+C4xr3asLWosnF
 ru3z+UJgThyW4QrHiyIF/eYBoolQ3dUwVLmG/wDZor+/mcgNscC6q3rMESx02rdZN1aX
 MrbJHGbF90cK34pqVw7I7TSIsJTiOBzFfhFy8+3iY9SUkw0fZI9UqBrhe8icXmOBGA54
 PeYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739634736; x=1740239536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8UaB0V2z4wlJF51fzX5AgeeKg3sioCX/+q0DhfpLzUs=;
 b=c0aicaTJZwPsHWj4Njn8/WPS2+4gk12YkdZesz/zcydxrUhukVdVxIwZhYrmVG5gFg
 1y0gAe9IZFE+/fW+rV6RKKLzyspEuDumbzXQsPjYBCpa5l79F9ACE5Y+um8O0/HXfBjs
 TMMLMpPiuXeZw4L4+yo24kgRdyV8s/2HeNIo8vaJw5uUyNY5KpbhB1JDC7TmMGxxUHZW
 NesjI6ngkEd99UkqORzMj+wllg4kUtqZ5/njkfmxbgjrnrssEctMii94DZMZTZiXG5r4
 22w8cYLdCjk7z16DJT1pFMa4NuM9h3cJv+r/tz2PkI0twGnUSWLHxFfqZpR4ZriZ4BoQ
 cZ6g==
X-Gm-Message-State: AOJu0Yxfpt2Uae+vP3npPvQ7p/H1MnvaXK+W7kx3KcaGrbwF4wvHkPRS
 Uf84Z3PWgIaQydEvDidctkCngrguh5qO/3TcxN60gdw3ZrSbQ4+3
X-Gm-Gg: ASbGncsMMdSqzqZ0BZCLpvsp7JvQniS+4htRofh378/ohdzrmwNDrxoOMKE/KTQjzSC
 zVvKYyZdER55oqOcP81dSsyyyiXNxa8DDfqaDZnsWVCRczS1Wl+T/dxVhq0zu9QjJy+EA1cvJTS
 /X6Ujp7Vd99F2Mm0PhFIJvvUxIn3pTPy1R2Q4xZqrLV0C7b90tZbAsR42wHpK07EWjitkonKTAk
 oWqrF/qjoUEQPdOzgHpM9QblFQ7m93npOh39vIxbNzBZCV1Aw73rWTw4GaNs79juOvPr8rLSdB5
 HnQ0e/c=
X-Google-Smtp-Source: AGHT+IFfU8Oho4Z9o3JOYAH8EcGIM2gptGotJMgLM9qniLOnUy00VfMi/i0GMUB7W7PTdhllydFyyg==
X-Received: by 2002:a05:6512:401e:b0:545:649:d4fb with SMTP id
 2adb3069b0e04-5451dfdbff2mr3339408e87.13.1739634736076; 
 Sat, 15 Feb 2025 07:52:16 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5452faeea50sm358471e87.151.2025.02.15.07.52.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 07:52:15 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/1] video: bridge-uclass: add get_display_timing ops
Date: Sat, 15 Feb 2025 17:51:55 +0200
Message-ID: <20250215155155.152271-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215155155.152271-1-clamor95@gmail.com>
References: <20250215155155.152271-1-clamor95@gmail.com>
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
 include/video_bridge.h                     | 18 ++++++++++++++++++
 2 files changed, 29 insertions(+)

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
index 3b429eac578..3860bf2cfee 100644
--- a/include/video_bridge.h
+++ b/include/video_bridge.h
@@ -53,6 +53,16 @@ struct video_bridge_ops {
 	 */
 	int (*set_backlight)(struct udevice *dev, int percent);
 
+	/**
+	 * get_display_timing() - Get display timings from bridge.
+	 *
+	 * @dev:	Bridge device containing the linked display timings
+	 * @tim:	Place to put timings
+	 * @return 0 if OK, -ve on error
+	 */
+	int (*get_display_timing)(struct udevice *dev,
+				  struct display_timing *timing);
+
 	/**
 	 * read_edid() - Read information from EDID
 	 *
@@ -98,6 +108,14 @@ int video_bridge_set_active(struct udevice *dev, bool active);
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

