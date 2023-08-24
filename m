Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E33C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:27:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70AFC869B9;
	Thu, 24 Aug 2023 21:26:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oHAxpgEQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFE53869B9; Thu, 24 Aug 2023 21:26:56 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE9C28698D
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:26:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fee843b44cso1631815e9.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692905213; x=1693510013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nkSynOGWPqBWY/Jr3KDbDKbN2rDKko8pZ38Gh5RHUEA=;
 b=oHAxpgEQdg6004oJjB5Hc9n+H8IaQbbZNHZqCk2Bi9P9r5RgFAK1PriOZ0ednRZUoN
 2CQvtX3CsISZ97ES9SA+zRSGKUcpMuX3PE4Dtr12ea+nU8QW1cgQkkB60KH4T5+trhld
 +byhcgQuCj9LfOA00ZLCp+bYLs3ia1/rgpUrND+x9FDwyVnQaR8stBjqlxIA+cwq6VL2
 HwHKUP7AHtHrgoBhTTmYitA3lxLkHy+Q5pbMBd8b23HwOKugQqrAezE96CYtBKGhdbjY
 RS5LjFLx4Q4CEo4OA9QT5V1kJh6lntB5m0mSH5nOdkrNrk69veeO9Ir8d62alFWcVbW0
 jraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692905213; x=1693510013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nkSynOGWPqBWY/Jr3KDbDKbN2rDKko8pZ38Gh5RHUEA=;
 b=cjWYPgp05uWe7k27Z7+Ibbi6mj0pYmjQUTWZK3uhrAlkTqhX0fmi1WUIWAGGyodCDE
 EyPFY9D+Q0iJfnM34tOhvVszIGNZWIk2SUinivoAAJcG0mACFiLQ8SwdCoadqq5zOlsr
 TX9smV5JWVH7YnqXbkyV0rKq+KydZAKUxWHXQGxpY7fGCcst1urdRJC++7+sJjgc3qw+
 Dd9rEQGPpXlPoqWgo1/fLu5faDihKrk8+EdIwmqxeWsHe9rMBanun5hFc6hFesB205w1
 Kz5YGDIYlZTzwi9+iGmUSGj+KvGSKrHJg7qiGr4ZVn7oKHmtMLuUVLQ6veGB3HcP1m9o
 9xJQ==
X-Gm-Message-State: AOJu0YymGiTWeVxfC3lxdPL0CM3roVUkyvEnWEo3dPB14U2dfWIlar/F
 MSdWyut92fM5u4jLruxzzRi2BkeRebl1Gw==
X-Google-Smtp-Source: AGHT+IEgPnR7WzU87GD8HdkqhekXbBpdZaF15Gg/MmkxbJSS7Q7IRI6NGclooOcBd+UfI60VHF7f8w==
X-Received: by 2002:a5d:6041:0:b0:31a:e5e8:1d8e with SMTP id
 j1-20020a5d6041000000b0031ae5e81d8emr11861348wrt.5.1692905213167; 
 Thu, 24 Aug 2023 12:26:53 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 be20-20020a0564021a3400b0052a1d98618bsm96033edb.54.2023.08.24.12.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:26:52 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 05/16] board: asus: transformer-t30: remove PMIC GPIOs
 configuration
Date: Thu, 24 Aug 2023 22:25:52 +0300
Message-Id: <20230824192603.240104-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824192603.240104-1-clamor95@gmail.com>
References: <20230824192603.240104-1-clamor95@gmail.com>
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

Default configuration matches values which are set in the board
so this configuration is not required.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 board/asus/transformer-t30/transformer-t30.c | 25 --------------------
 1 file changed, 25 deletions(-)

diff --git a/board/asus/transformer-t30/transformer-t30.c b/board/asus/transformer-t30/transformer-t30.c
index b6fd19d28e..5c1bac004f 100644
--- a/board/asus/transformer-t30/transformer-t30.c
+++ b/board/asus/transformer-t30/transformer-t30.c
@@ -33,11 +33,6 @@
 #define TPS65911_LDO5			0x32
 #define TPS65911_LDO6			0x35
 
-#define TPS65911_GPIO0			0x60
-#define TPS65911_GPIO6			0x66
-#define TPS65911_GPIO7			0x67
-#define TPS65911_GPIO8			0x68
-
 #define TPS65911_DEVCTRL		0x3F
 #define   DEVCTRL_PWR_OFF_MASK		BIT(7)
 #define   DEVCTRL_DEV_ON_MASK		BIT(2)
@@ -146,26 +141,6 @@ static void tps65911_voltage_init(void)
 		if (ret)
 			log_debug("vddio_usd set failed: %d\n", ret);
 	}
-
-	/* TPS659110: GPIO0_REG output high to VDD_5V0_SBY */
-	ret = dm_i2c_reg_write(dev, TPS65911_GPIO0, 0x07);
-	if (ret)
-		log_debug("vdd_5v0_sby set failed: %d\n", ret);
-
-	/* TPS659110: GPIO6_REG output high to VDD_3V3_SYS */
-	ret = dm_i2c_reg_write(dev, TPS65911_GPIO6, 0x07);
-	if (ret)
-		log_debug("vdd_3v3_sys set failed: %d\n", ret);
-
-	/* TPS659110: GPIO7_REG output high to VDD_1V5_DDR */
-	ret = dm_i2c_reg_write(dev, TPS65911_GPIO7, 0x07);
-	if (ret)
-		log_debug("vdd_1v5_ddr set failed: %d\n", ret);
-
-	/* TPS659110: GPIO8_REG pull_down output high to VDD_5V0_SYS */
-	ret = dm_i2c_reg_write(dev, TPS65911_GPIO8, 0x0f);
-	if (ret)
-		log_debug("vdd_5v0_sys set failed: %d\n", ret);
 }
 
 /*
-- 
2.39.2

