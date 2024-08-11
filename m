Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73BB8C3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:55:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82D7488980;
	Sun, 11 Aug 2024 16:51:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UkoGhL5x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACD74889C3; Sun, 11 Aug 2024 16:51:29 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4350988977
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:51:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-81f921c40f2so142314939f.0
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387884; x=1723992684; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GijPcpR0GDPCrKPdbPlCQoRYyZ0NCmQSpbKWvHz2k18=;
 b=UkoGhL5xmWLNGtAEKKuLsIMILiHMqV4miUkATU8q9bkkYsdXZiJxTIeCOAua5Z/3W4
 ybtb8gdrXjeJZMFo40Rp6ac5o5nbeRPrG7D6JErna+qk8Dd2/LEH5vAvRlAJol1DdvV0
 emZu3DNdYu0fhLjgiXbno+BpXDQF9bSUMrfcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387884; x=1723992684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GijPcpR0GDPCrKPdbPlCQoRYyZ0NCmQSpbKWvHz2k18=;
 b=Ypq7WNIb3nlkBi0ybctW67lyyQQpxuQ6x62lxLbYQffXtvbqmijmuy+qySmBvvxB4m
 TFottYPmnaR5cZcSvNqMIujzNh8nqaZKRF5fFE6cQgV0Tk9ELoYJ27gUQgcFXktXXOH2
 fcHurSgYE5+/SIX0mjLKC02PEkJoDyjIzpzdFL7cg5yGdtefuscf/YbW4PaJhpNUSpum
 4Jr6xFPx71G29EY1+NefF6VkX3StyjM6tPbu8yRBTsmA5urLDu1dwzIKXO50LbFmGBMJ
 tsWqUwL0riznSXf36Vu34OMqfAp/maPLbvv57CedLIACvJxHZ4CJWdYQ/sJ0iHIAIeNX
 8uxw==
X-Gm-Message-State: AOJu0YwL3QyBwp7ZQASh4z8kggiru8649jsb3ERxglnvwOedi8ytRL78
 Pwq5hPip1Oc1EZfyhbEQPQGhDUkoFvspNW+xvVSM0KPS5aM1R9xPNxHqvRjiG9+YK/Rr8oxVB/0
 =
X-Google-Smtp-Source: AGHT+IHvFXJOktpsTCrbQyOeBtFZJJuIXURDgxkmhRlqnagfaY16pUdqxbdtf1cLrBNTMEiZx1lFDA==
X-Received: by 2002:a05:6602:6b0f:b0:805:dcda:116c with SMTP id
 ca18e2360f4ac-8225ee77217mr990493339f.7.1723387883879; 
 Sun, 11 Aug 2024 07:51:23 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ca769fbe17sm1076047173.101.2024.08.11.07.51.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:51:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 13/18] i2c: Remove I2C_SET_BUS()
Date: Sun, 11 Aug 2024 08:50:42 -0600
Message-Id: <20240811145047.4189460-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811145047.4189460-1-sjg@chromium.org>
References: <20240811145047.4189460-1-sjg@chromium.org>
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

This is very old, predating even the legacy I2C support, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/power/power_i2c.c | 5 -----
 include/i2c.h             | 7 -------
 2 files changed, 12 deletions(-)

diff --git a/drivers/power/power_i2c.c b/drivers/power/power_i2c.c
index a871fc41987..c2fc1c6b42f 100644
--- a/drivers/power/power_i2c.c
+++ b/drivers/power/power_i2c.c
@@ -33,8 +33,6 @@ int pmic_reg_write(struct pmic *p, u32 reg, u32 val)
 		       p->bus);
 		return -ENXIO;
 	}
-#else /* Non DM I2C support - will be removed */
-	I2C_SET_BUS(p->bus);
 #endif
 
 	switch (pmic_i2c_tx_num) {
@@ -93,9 +91,6 @@ int pmic_reg_read(struct pmic *p, u32 reg, u32 *val)
 		return -ENXIO;
 	}
 	ret = dm_i2c_read(dev, reg, buf, pmic_i2c_tx_num);
-#else /* Non DM I2C support - will be removed */
-	I2C_SET_BUS(p->bus);
-	ret = i2c_read(pmic_i2c_addr, reg, 1, buf, pmic_i2c_tx_num);
 #endif
 	if (ret)
 		return ret;
diff --git a/include/i2c.h b/include/i2c.h
index 45ca3d63e3f..1d1430b74a6 100644
--- a/include/i2c.h
+++ b/include/i2c.h
@@ -954,13 +954,6 @@ static inline unsigned int I2C_GET_BUS(void)
 	return I2C_MULTI_BUS ? i2c_get_bus_num() : 0;
 }
 
-static inline void I2C_SET_BUS(unsigned int bus) __attribute__((always_inline));
-static inline void I2C_SET_BUS(unsigned int bus)
-{
-	if (I2C_MULTI_BUS)
-		i2c_set_bus_num(bus);
-}
-
 /**
  * Find the I2C bus number by given a FDT I2C node.
  *
-- 
2.34.1

