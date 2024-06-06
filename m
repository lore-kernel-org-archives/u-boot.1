Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922CDC27C55
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 16:36:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60149884D5;
	Thu,  6 Jun 2024 18:33:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aIpsd8NW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09E6B88423; Thu,  6 Jun 2024 16:30:50 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C3E187E1D
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 16:30:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so6159105e9.1
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 07:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717684247; x=1718289047; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wTfHCeEdThYm0NrWUrNIMKGuPJLSBNhsTTFSCPR2st8=;
 b=aIpsd8NWb4SWOnM6fQAFJPNCRPvo9N8RaYcueRocOERk7tZKYYZf2b6B4zu027/0bn
 C5Gh8WWfRoAOBtMuVZLwcydam/4ykwplcfEZFZBpmeTY1asDVQJK6xiyDQF8BCcwIskv
 Eo6K4vjhCcy4KLCSkbynpX2d2Phx6hslgl8+0Ak5LuZ37noHlCSVoiQrsHnY1xU+VUHI
 uwy/xKbmUVXHA1NAck9JmNiDiG0zvbqHvoClvGblelemHxLa5JzLxylX71SfhoeJIPuG
 yYAnOByVBJ2CcFTSedLfGux7lZQbujniUSvRrsRGu0EOyvO2Scsci9WBC06zUxBBITzp
 lEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717684247; x=1718289047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wTfHCeEdThYm0NrWUrNIMKGuPJLSBNhsTTFSCPR2st8=;
 b=i/TQRlYwQI9CpuRayRAPhv5OQtvUvyjQmYIwYUIhU/TdzOYcKokQY6rk93ZpFxAr3M
 6ZeZTbveFm/HrEwlS37ZsXT8mLuW9EayPYp55b5fpJoNdNh+U9UAoecVbqFuAbEWySSn
 ZfUEtvTJ46l98RpqBn/MI0pL5o/YSWiBRigKO68YcJgNNlJruD0aky5P0gfV0X1+4c0A
 VfnszmActLBZNZeTFb5/38nOZNjf4iHdo5tqIA6fixOCPLmLBW7tqSaoGVvVDuMfmUd7
 GBT5OxnbIwE1x3FOkf4CL4OpqkA82wVf5LNh9XjngMAWsj5PVwpnAW0+OaPJcvPkOhKH
 P0xA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPwjJQGFz8xAkSuhdqc2pGMuYTrv81UUTQ93terIt0/qkgj9P7YnIz2P4YTNOVc64ModNMwAJ7dM6TmqEMbhNmeIztEw==
X-Gm-Message-State: AOJu0YwN0HpE898uJz69DpMtOXQsb1P+vgs94m+WcFPTTkphX77C58Wu
 mDLSIaPDOWRS2jdZWRRH1wmpB/NMNcRHfDOMaB8zFJ532YVzK47Y
X-Google-Smtp-Source: AGHT+IF8d8iESoX0tuw0Z2mBRIjp5CcHgya6YFX8XfHulvMxA9dW3iSoXz5vSrSWV+GaQRjQKOiw3Q==
X-Received: by 2002:a05:600c:35c2:b0:421:4b0a:5006 with SMTP id
 5b1f17b1804b1-4215acd81e0mr27020265e9.7.1717684247521; 
 Thu, 06 Jun 2024 07:30:47 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-35ef5e989b3sm1718060f8f.71.2024.06.06.07.30.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 07:30:47 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Dmitry Dunaev <dunaev@tecon.ru>,
 Devarsh Thakkar <devarsht@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Stefan Bosch <stefan_b@posteo.net>, Eugene Uriev <eugeneuriev@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Shiji Yang <yangshiji66@outlook.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Subject: [PATCH v2 7/8] ubi: implement support for LED status activity
Date: Thu,  6 Jun 2024 16:29:28 +0200
Message-ID: <20240606143024.20024-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240606143024.20024-1-ansuelsmth@gmail.com>
References: <20240606143024.20024-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Jun 2024 18:33:44 +0200
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

Implement support for LED status activity. If the feature is enabled,
make the defined ACTIVITY LED to signal ubi write operation.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 cmd/ubi.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/cmd/ubi.c b/cmd/ubi.c
index 0a6a80bdd10..37c16048b19 100644
--- a/cmd/ubi.c
+++ b/cmd/ubi.c
@@ -20,6 +20,7 @@
 #include <mtd.h>
 #include <nand.h>
 #include <onenand_uboot.h>
+#include <status_led.h>
 #include <dm/devres.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
@@ -417,7 +418,19 @@ int ubi_volume_begin_write(char *volume, void *buf, size_t size,
 
 int ubi_volume_write(char *volume, void *buf, size_t size)
 {
-	return ubi_volume_begin_write(volume, buf, size, size);
+	int ret;
+
+#ifdef CONFIG_LED_STATUS_ACTIVITY_ENABLE
+	status_led_activity_start(CONFIG_LED_STATUS_ACTIVITY);
+#endif
+
+	ret = ubi_volume_begin_write(volume, buf, size, size);
+
+#ifdef CONFIG_LED_STATUS_ACTIVITY_ENABLE
+	status_led_activity_stop(CONFIG_LED_STATUS_ACTIVITY);
+#endif
+
+	return ret;
 }
 
 int ubi_volume_read(char *volume, char *buf, size_t size)
-- 
2.43.0

