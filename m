Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1452E67819
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 00:38:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 649E98908F;
	Sun,  3 Nov 2024 01:38:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LOJ/USza";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DC08890F8; Sun,  3 Nov 2024 01:38:06 +0100 (CET)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A54C8908F
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 01:38:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7ea9739647bso2243707a12.0
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 17:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730594281; x=1731199081; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PPEFC5UuvFfHW/m5jiHYWWxLBS9DLPYeUD5NuPr2exU=;
 b=LOJ/USzaxJg7CBOBJEmuRmA4kNbGyoYyUttsuOPC20rDAeci5vuYz81VdDVAA4pl1M
 MlHwa5Xd/2ToI0BtF/DEElpHx3qTPOB11yh60qbwr50jn7TaZ7vWiuRgui9V+2QInaES
 Krxc+ZPTdqPV4ZOoTzyPOepKZAZY0Mj+sS2Hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730594281; x=1731199081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PPEFC5UuvFfHW/m5jiHYWWxLBS9DLPYeUD5NuPr2exU=;
 b=YcR8H4qOfUXI5OweeJNR7lDVVVMsQgDPBiQLFbb5wpL+pccsJjNlBEfbD6v6KG56ec
 LoUkleWi9e0wKkXriqgk2/Bw4eSnPlc5Fja08VNY9ZtcoiI/qd4J1WiZ6hncG67fYstl
 QBzvWe19QY7uEa9rz+KUF2ST3FGkWZh7ipFCzO9rgrUiuyOa48S7Dx9INyLprDjuQyC3
 wP/4Qo/LGlP0X9AVDxKjYMiyc3G6QQ8tEt21ULqJIMhIW4+3xnjaNdVy+UI5OMplKgdR
 HIcIURWKgfVkCZJwO4f3zblGWo9kHQYCSgYaAGQeDfSI9HEJCt6p91R+u/2TL1RwWBR0
 oukw==
X-Gm-Message-State: AOJu0YyzTphQ4hkV59/ft2KHyEWG+aN57z6o8lggG6EiTNz+PYSI/xli
 4goeJF6FsFHaB/o3E7D41fcfc9HUEVJB2OkoA2/fRa7YTHKjLQoFomBokRffv+Dl1wxO3xI6pyf
 h4Q==
X-Google-Smtp-Source: AGHT+IH8mdbwfrJKMwckdipsndK+INFZd3ytDE0ET+7xNbgX9cYLs+8AfNXXGiLYuBcSj+Z99jgelg==
X-Received: by 2002:a17:903:32c8:b0:20c:e2ff:4a50 with SMTP id
 d9443c01a7336-210c68786dfmr357898005ad.9.1730594281526; 
 Sat, 02 Nov 2024 17:38:01 -0700 (PDT)
Received: from chromium.org ([205.220.129.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211057a63f2sm38987995ad.168.2024.11.02.17.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 17:38:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v3 18/25] sunxi: Drop status-LED code
Date: Sat,  2 Nov 2024 18:33:10 -0600
Message-ID: <20241103003322.626036-19-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241103003322.626036-1-sjg@chromium.org>
References: <20241103003322.626036-1-sjg@chromium.org>
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

This is not used anymore, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 board/sunxi/board.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index 824c322a0dc..cff7b8eb247 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -49,7 +49,6 @@
 #include <spl.h>
 #include <sy8106a.h>
 #include <asm/setup.h>
-#include <status_led.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -550,11 +549,6 @@ void sunxi_board_init(void)
 {
 	int power_failed = 0;
 
-#ifdef CONFIG_LED_STATUS
-	if (IS_ENABLED(CONFIG_SPL_DRIVERS_MISC))
-		status_led_init();
-#endif
-
 #ifdef CONFIG_SY8106A_POWER
 	power_failed = sy8106a_set_vout1(CONFIG_SY8106A_VOUT1_VOLT);
 #endif
-- 
2.43.0

