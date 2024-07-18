Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4404AC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 17:37:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74AAF88B19;
	Thu, 18 Jul 2024 19:36:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NZ7UHHdQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DC7188B52; Thu, 18 Jul 2024 19:36:47 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DE7888B29
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 19:36:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-427d2c8c632so4853715e9.2
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 10:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721324201; x=1721929001; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2mFji/5mzUkqNrXDdEv1s+7AinRYOYKCXhWCguJtsW4=;
 b=NZ7UHHdQA3XOQOEVKc3ulgS5kf/Oxy8exVimcDR1DVzo4+pLFaut1zEgtN0xS5HXUn
 4mL3ME9OEn9iFC9o8+VJVZvoDzqlKmHFC6dVstvoNn7qGtLYeZd37XGIm+3LR9rP1M/S
 5nfwKDEZJc2U2rD0b21xyvpMr6jUdKyyzQljA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721324201; x=1721929001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2mFji/5mzUkqNrXDdEv1s+7AinRYOYKCXhWCguJtsW4=;
 b=lOW0g+KduMspRdqypI5jrfYZF5bK6SSi1Ak+TAkSmiKDw9czZlGoc+XaV8NPua41T4
 uhzCDIgkRG8HWll+YYvXBwEuBi/1bLmk/MgDI9J/l6dIJcd5hB3udDxYrKa3v9w3kQVb
 9GFR42OuWV3SXt4fTVqaD4PSYdKQDVMMEVYzxHCJdApVYwayQNkBfN5IUskM3K+ozcyM
 0xWGYKtiJ29kquHKRLXA1EMF9XwPXohZ/GKWWaWkpCRt0vSAj3kznEBHmHSegHi9+2/4
 Hi/V+yAviQkm8TrnQLvCuEWMqQiZbMAZlRm7Vn8qewNONl5YMio76ZQI3LDLv/yj86Pr
 oyCA==
X-Gm-Message-State: AOJu0Yy6aaqeJYeMXbBTW2/TmSsdUCD5c+7zPz4/aUrrjDwJMEDxSlJT
 zh85Co3kpCmLqtkTk03Lvp4iWgG68lUDm7ahHsdaWYRpdbaYPCu8kbAeoXDqZ31qrukxGRgO2js
 =
X-Google-Smtp-Source: AGHT+IHQu7gJhs2yzGySRVEivmKbdADoHT1ouWNKJs0pa4h7BXJh52dVfvyw+aS2Uhl7CSoTI8s4qA==
X-Received: by 2002:a05:600c:548d:b0:426:6a5e:73c5 with SMTP id
 5b1f17b1804b1-427c2d12842mr38896845e9.37.1721324200757; 
 Thu, 18 Jul 2024 10:36:40 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2b29396sm20950715e9.32.2024.07.18.10.36.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 10:36:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@denx.de>, Stefano Babic <sbabic@denx.de>
Subject: [PATCH 07/20] mx28 / mx51: Drop CMD_DATE
Date: Thu, 18 Jul 2024 18:35:58 +0100
Message-Id: <20240718173611.4014274-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718173611.4014274-1-sjg@chromium.org>
References: <20240718173611.4014274-1-sjg@chromium.org>
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

These use pre-driver model code and it is several years since the
migration deadline. Disable the 'date' command so that this old code can
be removed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 configs/mx28evk_defconfig | 1 -
 configs/mx51evk_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/configs/mx28evk_defconfig b/configs/mx28evk_defconfig
index 1fe68ef93f9..dddb57efd3e 100644
--- a/configs/mx28evk_defconfig
+++ b/configs/mx28evk_defconfig
@@ -32,7 +32,6 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_NAND_TRIMFFS=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_CACHE=y
-CONFIG_CMD_DATE=y
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
diff --git a/configs/mx51evk_defconfig b/configs/mx51evk_defconfig
index e5178fb3d6b..5932a15a33d 100644
--- a/configs/mx51evk_defconfig
+++ b/configs/mx51evk_defconfig
@@ -31,7 +31,6 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
-CONFIG_CMD_DATE=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-- 
2.34.1

