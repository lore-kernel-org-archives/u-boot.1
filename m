Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C827AD0E6F7
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 11:41:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88E0B892BA;
	Mon, 21 Oct 2024 13:39:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C6Gis73L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DC07892D8; Mon, 21 Oct 2024 13:39:12 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8720892BA
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 13:39:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a9a3da96a8aso680199866b.0
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 04:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729510748; x=1730115548; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PPEFC5UuvFfHW/m5jiHYWWxLBS9DLPYeUD5NuPr2exU=;
 b=C6Gis73LW5vtiWZoBW+Se9wIkuC2aMPTFw9W5YdHPJGR8kShYDI6IbJg5YcoedV0ZO
 PQl0ObX1sx/dUo5w98Kys9bmAM68zFU5X/AB8vsUADrXGV44ljo6sunsc2mseYBtQG7T
 jhDb7yqNkr2PQPa53WATN8VWefDUgQIwtkIWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729510748; x=1730115548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PPEFC5UuvFfHW/m5jiHYWWxLBS9DLPYeUD5NuPr2exU=;
 b=sH95iw/TRdEw3pu+iijZz1eqBjOSuuraBROmnMMfmt+VXgMXj+cJfAwdtvq/uZ9qdS
 1mkrZlzW5xUbFio1u94tfU+RZf7Lp3PmRvI4VhXeMobLsbk0qcAQ9Lbb0VpAXhaO8doo
 PKjqMe3GR8DzHgg2Vxtbh9npOfgA61Z0hx3j/pPsJPjR1w5yoJOLTHiPOxa2u/qrfAee
 kdU1uk4Pj4p4D5tBrdVNY1YX3MWAeMXrwFz1EUEtbia6Kak4Ya/9pvjzyNnW51jLunoa
 5whxREMg06XFZbNsy12zfINjLXsw3H8YjP1ZrTuFKEDm9c0FpHvDR+TReC2xYKmQfnPu
 4HLQ==
X-Gm-Message-State: AOJu0YynTKYLPecOQmI3ruNMYQdDsstyAFYz9PMCsDGT1TE0ShcUfGXa
 Vgur6wY5BJTfXm61EnQiMg6JFWAnprmNMdDDD9XG4bT1wuP39WoutQZF5NItmBo9xCfzriveZ45
 yHy2S
X-Google-Smtp-Source: AGHT+IFkkAm/+H/pPNjDb0gW4dUuWFAzGyFRwXiDafdXhdJuMXqnPhoQVURDsNHh5RK6QcBeu6zHpQ==
X-Received: by 2002:a17:907:7250:b0:a9a:5b84:ac81 with SMTP id
 a640c23a62f3a-a9a6a5b1a5dmr1080417066b.31.1729510747990; 
 Mon, 21 Oct 2024 04:39:07 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91571ea5sm191604366b.160.2024.10.21.04.39.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 04:39:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Okhunjon Sobirjonov <okhunjon72@gmail.com>,
 Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH v2 19/25] sunxi: Drop status-LED code
Date: Mon, 21 Oct 2024 13:38:27 +0200
Message-ID: <20241021113839.318572-20-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021113839.318572-1-sjg@chromium.org>
References: <20241021113839.318572-1-sjg@chromium.org>
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

