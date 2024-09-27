Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C01ADCEBF66
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 01:24:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFA3788F9B;
	Fri, 27 Sep 2024 03:24:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nso8Hfw3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BD6E8905F; Fri, 27 Sep 2024 03:24:33 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A28A88F89
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 03:24:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-719ba0654f9so1337412b3a.3
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 18:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727400270; x=1728005070; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P8devojGrhaz81913PgUgK2Z1VAPxOaMNPVXag73vEQ=;
 b=nso8Hfw3PZJTS+ZYgbEl7q+g8q+AHnts+CZptJ72orimTmgd/NV+eKHaNcDdqREsrg
 UxNOMQvOo+MD+M4IM9zt3tIms9fukUQvgknDAAInQkMawVxvEcKBEaN0iX1b/KAwSPvj
 56MGXgi1OFdKivDNwM9C17GGuzORUpQoXkJXqdV3Qnh0SIP8sIQ/6Xj+4IIhpTmReeq+
 6atZDDTuC65fpDjfYpJodgrK7nFMauVwgqgRu953+PFC6N9JmUjcwCZ+SQ7CZHHo7rBq
 tm8J41htoX4qb1bEkPm/zzPbW45oGWOPUdLyMMaVhfvRkyyUmGUi0jMs546uqSpw0j2g
 cVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727400270; x=1728005070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P8devojGrhaz81913PgUgK2Z1VAPxOaMNPVXag73vEQ=;
 b=mCUJcmPnaHQFSCjA4sCfZHCti0YnHzsm9/hR00JzbJ1xSdsJ5O8mf9U1RjKImfJifl
 T73+ELq9AFAUXvr9T3/bISb9uznEbfroyaZqmAq+sGu7dU1L3JVnQ1onI5IuJFosbUa6
 Py06lSs/tc0FPz8K+7cRUxUlT1f6pXKnEwAcHEY9kJZXJ+jGf43g7xdo//rCfn07uTFV
 FSZm1zUzwscf8MFsJS0IoUFhVegzQrTGkrhGrESAC4CSrdYs/kX30YgrfM+tNYa5uiSe
 Z4d4sp+ZilflVMYwebXAkdXXI0Yh/hnAPnvTQdsZUXQ+auCzEz+m5RTBQRuSjzn6Y146
 LFpw==
X-Gm-Message-State: AOJu0YysyCYFM5IjpIFPBFBdfxltLaqr/vf5Yc3RG1qT7cIoOz7cR2jq
 zsGq1IOnVKY2mmJzTRj7sdetu5GVbrw5q+vGYB2mYEt+fGiLgf8vA5cGkg==
X-Google-Smtp-Source: AGHT+IERKW1bMf4BME4X55MUaURN02z8wGuaP0Ev0HYe+FBvxQ+mCw+ttAk+navJe81KRXUau+WrMA==
X-Received: by 2002:a05:6a00:39a2:b0:717:8d5d:94d6 with SMTP id
 d2e1a72fcca58-71b25f4416cmr2574305b3a.12.1727400269671; 
 Thu, 26 Sep 2024 18:24:29 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71b2652e609sm516341b3a.182.2024.09.26.18.24.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 18:24:29 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, tkuw584924@gmail.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [RESEND PATCH v2 2/2] mtd: spi-nor-ids: Add NO_CHIP_ERASE flag to
 Infineon s28hs02gt
Date: Fri, 27 Sep 2024 10:24:16 +0900
Message-Id: <eabd1311458353111ff4a42d5001e60e9d0f6759.1727400131.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1727400131.git.Takahiro.Kuwano@infineon.com>
References: <cover.1727400131.git.Takahiro.Kuwano@infineon.com>
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

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

S28HS02GT is dual-die package parts and do not support chip erase.

Fixes: 16dd1095101 ("mtd: spi-nor-ids: Add Infineon(Cypress) s28hs02gt ID")
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 3270ebb533c..4e7e89eb65a 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -388,7 +388,7 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("s28hl01gt",  0x345a1b,      0, 256 * 1024, 512, SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("s28hs512t",  0x345b1a,      0, 256 * 1024, 256, SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("s28hs01gt",  0x345b1b,      0, 256 * 1024, 512, SPI_NOR_OCTAL_DTR_READ) },
-	{ INFO("s28hs02gt",  0x345b1c,      0, 256 * 1024, 1024, SPI_NOR_OCTAL_DTR_READ) },
+	{ INFO("s28hs02gt",  0x345b1c,      0, 256 * 1024, 1024, SPI_NOR_OCTAL_DTR_READ | NO_CHIP_ERASE) },
 #endif
 #endif
 #ifdef CONFIG_SPI_FLASH_SST		/* SST */
-- 
2.34.1

