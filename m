Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D3BC3DA63
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 17:38:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEF9288B40;
	Thu, 18 Jul 2024 19:36:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Kv0Ke4Qk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88B9688B83; Thu, 18 Jul 2024 19:36:52 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44EF288B3C
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 19:36:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4266ea6a488so6002335e9.1
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 10:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721324204; x=1721929004; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fVdUB5kDIZISS9Cgbu0NWCL+1o75Oe1Hn72y4DoziBw=;
 b=Kv0Ke4Qk61mo96oWPPJrF7l2WpI2pADGyemx0R2UWmkuCSCxgQKa5CytY7QVwApulS
 8zFhl+bcPA1RhLQxNhMTMj0DBAr2N+hMqvLKbWQxePhxzWWwjjn3SSQc3PgyIpdexrz0
 jl0zau81m5acGXS0qvCudGyXLUGCZ0NFWELVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721324204; x=1721929004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fVdUB5kDIZISS9Cgbu0NWCL+1o75Oe1Hn72y4DoziBw=;
 b=fa/Qx9+uZhdSV3aXnM96UDniMAGuZLitZ3+ozdWLjtA5Ls0RCU2Wrrgap62N1ckBNK
 Xrml50t1W4kagvQDS/8KHb8pyH1lkH7VlNqKUvXp0ZIHUZxzrUVg5uO6sIg1kX3LF+SM
 BC6xtfrw26RH1Fo16XunPCHoHqxtR1/riOQ4wMbm4comGiJFjuWb/8Yqn52hvDBQkqOk
 CuSdnJ4/ZOeyvB212O08WfR1VdLfPWfhz1FEQtQTQxTpQbHsNavShKMqDMOB8LZnjryp
 YkU8njDcN6lm9TSbyTUYh7xL2OO5PY1K/5RD0egozFL97RpPXhR3drZRh7HKqKR0GdAW
 OUWw==
X-Gm-Message-State: AOJu0YySd+cYVbe3xHF7pe8FDIvWcy47ojEuZy9HgHfv0XX+R08ZyCel
 UUkEHgfXH8Jy1Q8dMCHJ8Ln8O5uiP8y/vtGwAV5W5JkWCbysly1DNTsMuU4bQ7Aci8NhRR2Ckx0
 =
X-Google-Smtp-Source: AGHT+IHoW00ACA59oNs0UV55A8A5C3hAnnWbh4Y8io8Ww20De2yqrafSOnbOmyPQq3yL/GpKsH/z8g==
X-Received: by 2002:a05:600c:3595:b0:426:5c81:2538 with SMTP id
 5b1f17b1804b1-427c2cb8a05mr43293365e9.14.1721324204642; 
 Thu, 18 Jul 2024 10:36:44 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2b29396sm20950715e9.32.2024.07.18.10.36.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 10:36:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 12/20] i2c: mxc: pg_wcom: Drop legacy I2c
Date: Thu, 18 Jul 2024 18:36:03 +0100
Message-Id: <20240718173611.4014274-13-sjg@chromium.org>
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

Drop use of this feature, but keep the board building. This will allow
removal of very old common I2C code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/ddr/fsl/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ddr/fsl/main.c b/drivers/ddr/fsl/main.c
index 31091bb4495..6474e0d64c7 100644
--- a/drivers/ddr/fsl/main.c
+++ b/drivers/ddr/fsl/main.c
@@ -111,7 +111,7 @@ static int ddr_i2c_read(DEV_TYPE *dev, unsigned int addr,
 #if CONFIG_IS_ENABLED(DM_I2C)
 	ret = dm_i2c_read(dev, 0, buf, len);
 #else
-	ret = i2c_read(dev->chip, addr, alen, buf, len);
+	ret = -ENOSYS;
 #endif
 
 	return ret;
@@ -162,7 +162,6 @@ static void __get_spd(generic_spd_eeprom_t *spd, u8 i2c_address)
 	};
 	dev = &ldev;
 
-	i2c_set_bus_num(CONFIG_SYS_SPD_BUS_NUM);
 #endif
 
 #ifdef CONFIG_SYS_FSL_DDR4
-- 
2.34.1

