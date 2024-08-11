Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC21C52D7B
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:55:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4017788966;
	Sun, 11 Aug 2024 16:51:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jHQgesvY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5E0F885F4; Sun, 11 Aug 2024 16:51:30 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90F8E87E9D
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:51:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-81f9339e534so122482439f.3
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387885; x=1723992685; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tb4BwZWlqDar1p+Z0t1zWzR9eiml12OLAF+htqqIEzc=;
 b=jHQgesvYfC55M6vZhMDqEUFdZpATouwWOwJ2VP7kGM44Qp5wscgNa+iK+wEenZp+rH
 d70J9IwIdgFESDyVadzOeBhGa4VoSl2/w8WC91yYwMGO7UUhgPeyvgwXSrlWAfR9vW+S
 5E1jZuZj2B/f2uzgT8EyWnrBC/z7KVMAGZWAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387885; x=1723992685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tb4BwZWlqDar1p+Z0t1zWzR9eiml12OLAF+htqqIEzc=;
 b=kfcnGkYd8k3KKDGx/wKEDv8l8G5fIo5sslbfIMGDx+WEutseS8Roo4+XSIpKJ1E87/
 acuoASSnBmzUnKPFAxbstj17cMtdT4R50dGwOAH524I47++A0V8dQ9dboyGIcw3a2wn0
 ClKBpcTpljNzMweFWyhj/Vmb2nueL8p1h4/Zm6uIeVNh/D/JxMpcOUvPpFf44CmG3eBb
 ujoTD3K/WYR1aTZbVrij0ILQ9gQ+fCkubkqS0u4JAfoDDnMZbyPX3HvuXHk87NOGtzbV
 K5UF2kwQX4QEF2rM4uZ1GUTEHCMMqB2rVBv3IfpxU08DlTvneXm/0Yas2RgtOuSB34Kk
 S5VA==
X-Gm-Message-State: AOJu0Yyayq6Rg+prsMnElxn7unO6FzVkDUBbM4w2pW+ROmGHjdZSgoT4
 oD06DAEJOjYOLfgxJqs8euwvcVOJApfHEH82A7vhxhfrSxfdlwyPGfvCdf/MzkUwaHUPQ93lxLI
 =
X-Google-Smtp-Source: AGHT+IG1syxzTwp/yDpgI7fncinglKKOfzyjtwHPTLqPyUgFKVPf0XHycsOi9YUcUlTTMPpRUmIgDg==
X-Received: by 2002:a05:6602:1691:b0:7fa:8178:d672 with SMTP id
 ca18e2360f4ac-8225ee68c00mr1170594239f.4.1723387885240; 
 Sun, 11 Aug 2024 07:51:25 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ca769fbe17sm1076047173.101.2024.08.11.07.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:51:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 15/18] i2c: Drop CFG_SYS_MAX_I2C_BUS
Date: Sun, 11 Aug 2024 08:50:44 -0600
Message-Id: <20240811145047.4189460-16-sjg@chromium.org>
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

Only one board uses this option and it is very old. Let's drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/configs/ethernut5.h |  3 ---
 include/i2c.h               | 14 --------------
 2 files changed, 17 deletions(-)

diff --git a/include/configs/ethernut5.h b/include/configs/ethernut5.h
index 807c6963192..c327bbbe07d 100644
--- a/include/configs/ethernut5.h
+++ b/include/configs/ethernut5.h
@@ -59,9 +59,6 @@
 #define CFG_SYS_I2C_RTC_ADDR		0x51
 #endif
 
-/* I2C */
-#define CFG_SYS_MAX_I2C_BUS	1
-
 #define I2C_SOFT_DECLARATIONS
 
 #define GPIO_I2C_SCL		AT91_PIO_PORTA, 24
diff --git a/include/i2c.h b/include/i2c.h
index b6727bb2a73..282f3cd700f 100644
--- a/include/i2c.h
+++ b/include/i2c.h
@@ -933,20 +933,6 @@ int i2c_set_bus_speed(unsigned int);
 unsigned int i2c_get_bus_speed(void);
 #endif /* CONFIG_SYS_I2C_LEGACY */
 
-/*
- * only for backwardcompatibility, should go away if we switched
- * completely to new multibus support.
- */
-#if CONFIG_IS_ENABLED(SYS_I2C_LEGACY)
-# if !defined(CFG_SYS_MAX_I2C_BUS)
-#  define CFG_SYS_MAX_I2C_BUS		2
-# endif
-# define I2C_MULTI_BUS				1
-#else
-# define CFG_SYS_MAX_I2C_BUS		1
-# define I2C_MULTI_BUS				0
-#endif
-
 /**
  * Find the I2C bus number by given a FDT I2C node.
  *
-- 
2.34.1

