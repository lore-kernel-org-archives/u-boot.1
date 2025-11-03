Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1EA2CCFA03
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 23:44:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FB088144A;
	Tue,  4 Nov 2025 00:44:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S+6qD6CF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACF32836D1; Tue,  4 Nov 2025 00:44:43 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D6608004F
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 00:44:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-29555415c5fso33086315ad.1
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 15:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762213480; x=1762818280; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=QR+oOhLi89D5uOCTcoQrkInRpZnZ/BjNWZ09T2TWh4E=;
 b=S+6qD6CF1GP9EXwcWZrZdrQCU7zMu3p8FklU0ww3t7MiqUNtUiYnsHM/32gkJlL31y
 9T057/vDLXNHE7bBN5GZqXT7I/AnVaq2yL0eVVGiG26w0C1B3YajEcD0ufaABxr1h/0f
 xQAEkKX1JVGVtfqeypTEHUF78wTaH4BeF6XXbscAkXT5mcTX2YI39jR6JtnedsDYrn1f
 a46m3/cfeWdLUQVSeDbynLOXYffr7U0USQw2RKQlsKm70di66fvlLIp6cDpx+21VLiMC
 Je1BhnNMb14gejrdXNQRCIyT9G3ufYGb3+UNgAlSwUHXAfxi7jY2yy4tFtj9T1FhWAHn
 N+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762213480; x=1762818280;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QR+oOhLi89D5uOCTcoQrkInRpZnZ/BjNWZ09T2TWh4E=;
 b=ZZ9/P9Qk9IygWVww42Cs4gJC/sBDPUUr9kXbp4kDRIxP/U0EzT//i+rXvwkFAnNMvd
 sMu3ac1O6tY6IHg3E5YiXmgTDFS7wB2y/OcJSAOa8Xbi8UqVyP9RawZtFivxXgRYDOYc
 WplItBJSs3nwq4moF7eW/IVpWY1f+uWzTPt1+vPrA4xB6uf4o8DuWZ7ZI6XGUEaUiVVV
 dTlOowoi8xzhQCcVR6aGtPiR6QPXTsSj4V1fO9zveZ/9Klf+IK2eXIstXcHiaIym/A9R
 Kc+SHObRiAdih2dgl7xRUKe92IPPchedQxVziIRzR7eSO7+ewsdFmqh+D/0x19MA6gtO
 t5dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa5mdHLUKIaHEDn4AGhU7hAO5VkMyEeq5kP6s4ra/F9+tCHQOTBv6h0U9UK5HUI/kssGTRXCM=@lists.denx.de
X-Gm-Message-State: AOJu0YyHMl6nrHjD9LmFw2hQf+FrCvOacTXz867gdSX0aWCapa6MiNU/
 IteM6WCgf28tTjckFqMIUhF7UcYbOP3nW7AofshsOnBVGH+0BCR/sTjESAZa6U7s
X-Gm-Gg: ASbGnctkRlw+puov+7e+1B6nee08VMHQibKO5MCpYHLDmVSG2yEz1iSFvrZ6XVczaj/
 Nm99g+a/gkDHIe310iNReV5W/mmr2GgKAO+ZAj9NMHHfqvpCHEypkaob9GxKmUjB9fZwqy/S+/c
 pJ4LSeLw/JnYnqK2lGWHbqzTizXNbJjbG/qi/juTvYNHEpGU9MQw81TBO3MkDcEp6QoEIyRROY6
 HLtfDH6wViOWz9Aqc4wh4L2BshWdJWrKuEqSEp6SS0XKacYfyP5z8A+DEeRzSkIhgze96pQa9f4
 B3/bC8jEUmfLlNG6qWgE+CtW3HjbcB5XgUeoVFhDcDu7h3i7wRGEtQRIJgBirnoiFRi+kY1rSA9
 KsvI5ay/k5rEB62inoZx1IRA6vg5txdIPhUNsWraqCpjJYNksmqTv+nGlFeLmw0iwTUatXIw7Bd
 OYOw9LWQAmibJMPzBYDYjZprX5RuwyEyL5SE7sBQ==
X-Google-Smtp-Source: AGHT+IGydGIozwV3oUVvpTL9gHGdItVnTBjIzIiKmzFx/YBtF49JIamIWj1VrFIRSrsNP3SGfja90A==
X-Received: by 2002:a17:902:ce89:b0:295:7b8c:6611 with SMTP id
 d9443c01a7336-2957b8c6829mr91237165ad.15.1762213479753; 
 Mon, 03 Nov 2025 15:44:39 -0800 (PST)
Received: from localhost.localdomain ([185.213.82.232])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29601998887sm3741535ad.42.2025.11.03.15.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 15:44:39 -0800 (PST)
From: Brian Sune <briansune@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Subject: [PATCH v4] Add make feature support for SoCFPGA Handoff
Date: Tue,  4 Nov 2025 07:44:23 +0800
Message-ID: <20251103234423.487-1-briansune@gmail.com>
X-Mailer: git-send-email 2.47.1.windows.1
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

Introduce socfpga_gen5_handoff_prepare target in U-Boot Makefile
Automatically detects Altera/Intel SoCFPGA boards from .config
Checks for presence of hps_isw_handoff folder and .hiof files
Runs BSP generator script tools/cv_bsp_generator/cv_bsp_generator.py 
if files exist
Non-blocking: prepare continues even if handoff folder or files are missing
HANDOFF_PATH user define: override the auto detection in board folder

Signed-off-by: Brian Sune <briansune@gmail.com>
---
 Makefile | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/Makefile b/Makefile
index 32568a6c477..f5efe679259 100644
--- a/Makefile
+++ b/Makefile
@@ -2207,23 +2207,28 @@ socfpga_g5_hanoff_prepare:
 		exit 0; \
 	fi; \
 	BOARD_DIR=board/$$VENDOR/$$BOARD; \
-	HANDOFF_BASE=$$BOARD_DIR/hps_isw_handoff; \
-	if [ ! -d $$HANDOFF_BASE ]; then \
-		exit 0; \
-	fi; \
-	echo "[INFO] Handoff folder found: $$HANDOFF_BASE"; \
-	HANDOFF_FOLDER_NAME=$$(basename "$$(find $$HANDOFF_BASE -mindepth 1 -maxdepth 1 -type d | head -n1)"); \
-	if [ -z "$$HANDOFF_FOLDER_NAME" ]; then \
-		exit 0; \
-	fi; \
-	echo "[INFO] Handoff subfolder found under $$HANDOFF_BASE"; \
-	if [ -f $$HANDOFF_BASE/$$HANDOFF_FOLDER_NAME/$$HANDOFF_FOLDER_NAME.hiof ]; then \
-		echo "[INFO] Found hiof file: $$HANDOFF_BASE/$$HANDOFF_FOLDER_NAME/$$HANDOFF_FOLDER_NAME.hiof"; \
-		echo "[INFO] Using handoff folder: $$HANDOFF_FOLDER_NAME"; \
-		echo "[INFO] Running BSP generator..."; \
+	if [ -n "$$HANDOFF_PATH" ]; then \
+		echo "[INFO] Using manually assigned handoff path: $$HANDOFF_PATH"; \
+	else \
+		HANDOFF_BASE=$$BOARD_DIR/hps_isw_handoff; \
+		if [ ! -d $$HANDOFF_BASE ]; then \
+			exit 0; \
+		fi; \
+		echo "[INFO] Handoff folder found: $$HANDOFF_BASE"; \
+		HANDOFF_FOLDER_NAME=$$(basename "$$(find $$HANDOFF_BASE -mindepth 1 -maxdepth 1 -type d | head -n1)"); \
+		if [ -z "$$HANDOFF_FOLDER_NAME" ]; then \
+			exit 0; \
+		fi; \
+		echo "[INFO] Handoff subfolder found under $$HANDOFF_BASE"; \
+		if [ -f $$HANDOFF_BASE/$$HANDOFF_FOLDER_NAME/$$HANDOFF_FOLDER_NAME.hiof ]; then \
+			echo "[INFO] Found hiof file: $$HANDOFF_BASE/$$HANDOFF_FOLDER_NAME/$$HANDOFF_FOLDER_NAME.hiof"; \
+			echo "[INFO] Using handoff folder: $$HANDOFF_FOLDER_NAME"; \
+			echo "[INFO] Running BSP generator..."; \
+		fi; \
+		HANDOFF_PATH=$$BOARD_DIR/hps_isw_handoff/$$HANDOFF_FOLDER_NAME; \
 	fi; \
 	python3 tools/cv_bsp_generator/cv_bsp_generator.py \
-		-i $$BOARD_DIR/hps_isw_handoff/$$HANDOFF_FOLDER_NAME \
+		-i $$HANDOFF_PATH \
 		-o $$BOARD_DIR/qts || echo "[WARN] BSP generator failed, continuing..."; \
 	echo "[DONE] SoCFPGA QTS handoff conversion complete."
 
-- 
2.25.1

