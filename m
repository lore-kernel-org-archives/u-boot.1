Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80C6C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 10:00:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D81E8845C;
	Tue, 28 May 2024 12:00:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CLBa6W9n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D18AF884A1; Tue, 28 May 2024 12:00:04 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A5918845C
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 12:00:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5789733769dso4125303a12.1
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 03:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716890401; x=1717495201; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zn4qHRIEXQRZCGdD33LaWO+TFK6M/LsyWODLoP7skpw=;
 b=CLBa6W9nTLi7xdje/HO5eW4aBuUIn1m8JzoDaAalzI+NAWf7TM3fx4M2IwtqKTueES
 jcxPN1MlB4cvfZD1Vjc2OnM1FJoz7CVevxE42FfV2wS98jMc6ZowlIRSX2ghN/+D1yId
 9DEF3er2gWEBxOxlbM2GG+JIB9uKtVuNjeS0wiOwokYyd8kJr/nUOqkE6xrVzeR298Ur
 XNC1qioLK17i7xW0XL55EDDRRPG4daLkZc0wP5NlFJhQ2OOduojExOyPQqo6vwTM1ilY
 A1Cx7egwHy7n68Ljpv9kUvJFJctXORf47mEDJiP37iBHDYZE2BOuFwtjEVbUV1q0OvIZ
 Mzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716890401; x=1717495201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zn4qHRIEXQRZCGdD33LaWO+TFK6M/LsyWODLoP7skpw=;
 b=WgZVz8RqzlE2Y8CSxtXTIFAHaYYNo1x3lFr2RnAxDhUH7QCotG7Se3mKK1ZZQ6c9lv
 ZfN2TgrKfgqM3S3DPT0VkIjk907TeWlkaVTq0HD8BweKapzQV5a7rdaXBZ6BuJbg0Aoq
 +lccUP08fKDKpxR9yZrXLLiGFMi8W/wouoEPgvXH/HcP3ZIVxNoIdCYeKidPY810Ef10
 8OVxyBzbvDStRdM4MFa+drSGosjlAnLYZw+NbJrtM/RRAqyjt2ZHwE6C+ojrdTPkATCb
 aMckSWMxvb8jIcsL/eJydWbYnsS5beYxpEqxHDyR6XH4L7SMJpNU7q7cQ51QGbjUZVTy
 7F6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/4KQRAfWB6/qYItrf+yRaHSYnWyL9uOadstgP9RnPv1OsfPm22SaMmlUFhPaF+9kypBx0n1SS0l4M+UL/9q1fnSRZyw==
X-Gm-Message-State: AOJu0YyC8uXUmS5mPgX9P3Om5o28I2EGUoTilrUKmBxC5FiAQnB7gosm
 tPKKcGmlVPzVpTuDzu5CzVQycLdG991ZrKbwJyzKlnpXVsttFw/D
X-Google-Smtp-Source: AGHT+IHq68W5hWy5gSNJV9eVt2UuhEsG+jdfRkAp5sWz9kvs9tA0rKKQJAUY5ecPWrFbVCfVZWUEqA==
X-Received: by 2002:a17:906:a04e:b0:a62:44e1:3f56 with SMTP id
 a640c23a62f3a-a6244e14068mr1159231466b.37.1716890401327; 
 Tue, 28 May 2024 03:00:01 -0700 (PDT)
Received: from emanuele-nb.corp.toradex.com (31-10-206-125.static.upc.ch.
 [31.10.206.125]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a634da2e2absm33239266b.87.2024.05.28.03.00.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 03:00:00 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v1 2/5] board: toradex: verdin-imx8mm: increase maximum
 addressable ram to 4GB
Date: Tue, 28 May 2024 11:59:38 +0200
Message-Id: <20240528095941.872693-3-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528095941.872693-1-ghidoliemanuele@gmail.com>
References: <20240528095941.872693-1-ghidoliemanuele@gmail.com>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Add support for SKUs with higher memory sizes.
Actual memory size is auto-detected.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 board/toradex/verdin-imx8mm/verdin-imx8mm.c | 2 +-
 include/configs/verdin-imx8mm.h             | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/board/toradex/verdin-imx8mm/verdin-imx8mm.c b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
index 55c02653da68..31e8d5fb04b5 100644
--- a/board/toradex/verdin-imx8mm/verdin-imx8mm.c
+++ b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
@@ -117,7 +117,7 @@ int board_phys_sdram_size(phys_size_t *size)
 	if (!size)
 		return -EINVAL;
 
-	*size = get_ram_size((void *)PHYS_SDRAM, PHYS_SDRAM_SIZE);
+	*size = get_ram_size((void *)PHYS_SDRAM, PHYS_SDRAM_SIZE + PHYS_SDRAM_2_SIZE);
 
 	return 0;
 }
diff --git a/include/configs/verdin-imx8mm.h b/include/configs/verdin-imx8mm.h
index 34238d3b505c..12d2b6823058 100644
--- a/include/configs/verdin-imx8mm.h
+++ b/include/configs/verdin-imx8mm.h
@@ -58,8 +58,10 @@
 #define CFG_SYS_SDRAM_BASE           0x40000000
 
 /* SDRAM configuration */
-#define PHYS_SDRAM                      0x40000000
-#define PHYS_SDRAM_SIZE			SZ_2G /* 2GB DDR */
+#define PHYS_SDRAM                   0x40000000
+#define PHYS_SDRAM_SIZE              (long)(SZ_2G + SZ_1G)
+#define PHYS_SDRAM_2                 0x100000000
+#define PHYS_SDRAM_2_SIZE            (long)(SZ_1G)
 
 /* USB Configs */
 #define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
-- 
2.34.1

