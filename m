Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC25C3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:54:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59A6F889B8;
	Sun, 11 Aug 2024 16:51:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R9iE5gSL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E32CE88996; Sun, 11 Aug 2024 16:51:25 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28BF588914
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:51:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-81fd520fee5so137992139f.2
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387881; x=1723992681; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PVvXVHTbA2Zq1QVem+6NFJnoHXC/rRntQ5PeI0eBbU0=;
 b=R9iE5gSLqBi/p2izNQ+KDzRrJWH3QXOWhaU3U2zpN56QDtfgN16b7GTHtOyh4H33KS
 xCJl/wbrnFyKvfZoAZJcDz5r4WATzwE+cSbqEBNo5fLEGHE1rKpFTOUf275gIww6XtuW
 5eTF+cSDCwctjDMKBt8AiKt6U0f2bYzDqLHi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387881; x=1723992681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PVvXVHTbA2Zq1QVem+6NFJnoHXC/rRntQ5PeI0eBbU0=;
 b=QljjrnIie7VHhQMAGJOToAjIRexEx03l7AAWl61I4AzbkZbfeyfByQlBldYYUjdGuU
 b60IGD0Pgc9fH/hKtrpwu9BUgFWtQmcQZQjF1r3uU0z4TH0PoTqClDwcADQ1C8ihRo39
 zXDNCrbqlnC6RvyJqDKLv5tfjLgSROmTobgQxQqIxuXTgfbhSqB9chi1MPY3UHY0Dqem
 JeadkUkDLwYJ/znOZdjnWikt/ZODYcnWo2+MRa+fHHvl9b+dQ1g3EMiYOyPbWb97nse/
 /U+v2f46IjYNgcBO3fB9qWHpsRsQm0sExVSX+GGhBRiX53brSo/3vh6J2tvV7XoFAzHc
 sa/Q==
X-Gm-Message-State: AOJu0YxeewmT/amPQEHQfUVY+hxxiqIS44G1cXnxVGHIk6n45QcnIvuc
 dJLx3f8/bUZXBiT9MtGYXLKRc/vZFniId0+ItxRE/ny+6kX7BDTuGp/FMmyivREc7fuhRiukv0U
 =
X-Google-Smtp-Source: AGHT+IH364/QUa8yeugN1xefF/R4bJFZSdVa1FTe/bvqrTlOmXihvillfjNTOaY9xjM5YhtrqJAezQ==
X-Received: by 2002:a05:6602:6001:b0:81e:23e8:8d4 with SMTP id
 ca18e2360f4ac-8225ee767a4mr1105543839f.6.1723387881523; 
 Sun, 11 Aug 2024 07:51:21 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ca769fbe17sm1076047173.101.2024.08.11.07.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:51:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 10/18] fsl: mxc: Drop legacy I2c
Date: Sun, 11 Aug 2024 08:50:39 -0600
Message-Id: <20240811145047.4189460-11-sjg@chromium.org>
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

Drop some old code from the mxc_i2c and ddr/fsl drivers. This will allow
removal of very old common I2C code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Leave pg_wcom alone as its boards were converted

 drivers/ddr/fsl/main.c | 3 +--
 drivers/i2c/mxc_i2c.c  | 1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ddr/fsl/main.c b/drivers/ddr/fsl/main.c
index 31091bb4495..888dfb7ff33 100644
--- a/drivers/ddr/fsl/main.c
+++ b/drivers/ddr/fsl/main.c
@@ -111,7 +111,7 @@ static int ddr_i2c_read(DEV_TYPE *dev, unsigned int addr,
 #if CONFIG_IS_ENABLED(DM_I2C)
 	ret = dm_i2c_read(dev, 0, buf, len);
 #else
-	ret = i2c_read(dev->chip, addr, alen, buf, len);
+	ret = 0;
 #endif
 
 	return ret;
@@ -162,7 +162,6 @@ static void __get_spd(generic_spd_eeprom_t *spd, u8 i2c_address)
 	};
 	dev = &ldev;
 
-	i2c_set_bus_num(CONFIG_SYS_SPD_BUS_NUM);
 #endif
 
 #ifdef CONFIG_SYS_FSL_DDR4
diff --git a/drivers/i2c/mxc_i2c.c b/drivers/i2c/mxc_i2c.c
index 84c0050eac0..2f3cb5908c9 100644
--- a/drivers/i2c/mxc_i2c.c
+++ b/drivers/i2c/mxc_i2c.c
@@ -620,6 +620,7 @@ int enable_i2c_clk(unsigned char enable, unsigned int i2c_num)
 	__attribute__((weak, alias("__enable_i2c_clk")));
 
 #if !CONFIG_IS_ENABLED(DM_I2C)
+
 /*
  * Read data from I2C device
  *
-- 
2.34.1

