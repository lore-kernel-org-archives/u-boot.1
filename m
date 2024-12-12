Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9471E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 10:23:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4E6D802C2;
	Thu, 12 Dec 2024 11:21:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Brx46tnx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECAA48025C; Thu, 12 Dec 2024 11:21:40 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3F61801DA
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 11:21:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aa66ead88b3so74579866b.0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 02:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733998898; x=1734603698; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gqJR+93fzbA6FFvLj8UuV2xfDchPhL2SktIPb/SVmO0=;
 b=Brx46tnxx5JLgRiIngTlcx9dZQDLbFCeBy989t1PTQBiYaFn4qjErPDPO0hp74cX0Q
 IKdLLCQDalMLf6SL2liMMvB1zFcG7/AjpXCfA21yW9Zp3kSYT2eOO4paeNwvvbWzLWOY
 soAS5bjc7kOD9HSSsI7DW/Ktuvi9+yE6p7TIGdoqyBkiEBczVT1qUqo94H5g8j5d3kkd
 lP07+KO+4TO+6Z48aBQAk4zoiB2oNorwiLo3RKvbWSOugLfWsSb3ba8wzKWAXL0QOsuI
 LZS+D60qULIw9lflMsc3B8JUDrlol70gdDdWNxZFAhzh4xPElmvRFvl9HCz1QGzhzpeQ
 GI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733998898; x=1734603698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gqJR+93fzbA6FFvLj8UuV2xfDchPhL2SktIPb/SVmO0=;
 b=K1cdR7+IrePMprG70ec69B8CwWe50r3FD7/+ybirrDEzm9qF72VGRKGoEnfkZRJUNb
 SKFBv4iCSB+31pH1cNe72oXpu34QXyi7KiKVTTy7Uqb5T9JPSMwUwwPdiPOfYNZg0bq3
 T1cJo/QXwjE4HzipTlOZn1sPL9tFbTFAiK9L0q8pybYuCfBR+c7TWguHtQZAcefDAeHp
 QLpQYSSNnwZuCu6T6zVQYkR7bdPRLz4PDRFwYz0BeIWz+M8zy0oIuerToXF3Y+n4UaoD
 chYpagV1KW1cH6wnsM7aTS2hGJOa37NYrvm+x07S+z8TRZ4CpaYlQd9AC4LapxA1BbAu
 +xiw==
X-Gm-Message-State: AOJu0YwfYAVTGiL3w1/TcLlh3opCps9gCDHOZGZ3a6mHv4CiOLzOgUY7
 9tCk5ctxUNeJ4NUT68EWYB8VeBiqFnQZg1qfsNCVLj4Aj1MaCbWX
X-Gm-Gg: ASbGncvcn4Eb1xXhKHqe63aWv2RS/2xow46yCHKk7zM4xFbZGxnk3EF0G4qa3pS6J5p
 PFHmyLO8eshOP7iSUQjtemA8JETXgR2iyKanUD1oknnSq5Cgg8c7iVBf8MvbvKpOiwk9r7sA+q/
 /5bW6SIn4KU/2YsHPextNorgvoEtECoPI22wYWGCZjBW6rLxwArEEemrrwzOdSaO/llb9nbrC97
 3CR4JMapSucaHAvoC7QobFfy7za7CAtUNGkk0A0PHXgb7YK
X-Google-Smtp-Source: AGHT+IGkAD/D6uI0hIAOngDEJlyjhKyzIRWWCHM60zfU6EGX7qI80qfbsZFHgCuAyB3HwnAL3nW/SA==
X-Received: by 2002:a17:906:314e:b0:aa6:b5d8:d5c4 with SMTP id
 a640c23a62f3a-aa6b5d8d617mr569273866b.17.1733998898234; 
 Thu, 12 Dec 2024 02:21:38 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa67d6fcd3dsm646818066b.80.2024.12.12.02.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 02:21:37 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 11/12] video: panel: lq101r1sx01: remove unnecessary setup
Date: Thu, 12 Dec 2024 12:21:18 +0200
Message-ID: <20241212102119.6466-12-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212102119.6466-1-clamor95@gmail.com>
References: <20241212102119.6466-1-clamor95@gmail.com>
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

Left-right split is enabled only by sending 0x1000 to
MIPI_DCS_SET_COLUMN_ADDRESS (0x2a) and does not require any other
manipulations. sharp_setup_symmetrical_split function is left as
a reference for possible even-odd split implementation or video
mode support where commands have to be sent to both links.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/sharp-lq101r1sx01.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/video/sharp-lq101r1sx01.c b/drivers/video/sharp-lq101r1sx01.c
index 5d8453fd796..504122abda6 100644
--- a/drivers/video/sharp-lq101r1sx01.c
+++ b/drivers/video/sharp-lq101r1sx01.c
@@ -57,9 +57,10 @@ static int sharp_lq101r1sx01_write(struct mipi_dsi_device *dsi,
 	return 0;
 }
 
-static int sharp_setup_symmetrical_split(struct mipi_dsi_device *left,
-					 struct mipi_dsi_device *right,
-					 struct display_timing *timing)
+static int __maybe_unused
+sharp_setup_symmetrical_split(struct mipi_dsi_device *left,
+			      struct mipi_dsi_device *right,
+			      struct display_timing *timing)
 {
 	int ret;
 
@@ -104,9 +105,7 @@ static int sharp_lq101r1sx01_enable_backlight(struct udevice *dev)
 		return 0;
 
 	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
-	struct mipi_dsi_panel_plat *plat_sec = dev_get_plat(priv->panel_sec);
 	struct mipi_dsi_device *link1 = plat->device;
-	struct mipi_dsi_device *link2 = plat_sec->device;
 	int ret;
 
 	ret = mipi_dsi_dcs_exit_sleep_mode(link1);
@@ -142,16 +141,17 @@ static int sharp_lq101r1sx01_enable_backlight(struct udevice *dev)
 	/*
 	 * TODO: The device supports both left-right and even-odd split
 	 * configurations, but this driver currently supports only the left-
-	 * right split. To support a different mode a mechanism needs to be
-	 * put in place to communicate the configuration back to the DSI host
-	 * controller.
+	 * right split in command mode. To support a different mode a
+	 * mechanism needs to be put in place to communicate the
+	 * configuration back to the DSI host controller.
+	 *
+	 * Left-right split is enabled only by sending 0x1000 to
+	 * MIPI_DCS_SET_COLUMN_ADDRESS (0x2a) and does not require any
+	 * other manipulations. sharp_setup_symmetrical_split function is
+	 * left as a reference for possible even-odd split implementation
+	 * or video mode support where commands have to be sent to both
+	 * links.
 	 */
-	ret = sharp_setup_symmetrical_split(link1, link2, &default_timing);
-	if (ret < 0) {
-		log_debug("%s: failed to set up symmetrical split: %d\n",
-			  __func__, ret);
-		return ret;
-	}
 
 	ret = mipi_dsi_dcs_set_display_on(link1);
 	if (ret < 0) {
-- 
2.43.0

