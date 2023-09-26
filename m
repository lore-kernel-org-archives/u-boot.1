Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37420E7D26B
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 09:08:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE7B586BF7;
	Tue, 26 Sep 2023 11:08:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cLB0mrEj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51CF086BF7; Tue, 26 Sep 2023 11:08:23 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B83BD86BEE
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 11:08:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1c5db4925f9so58536435ad.1
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 02:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695719298; x=1696324098; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+KfTCu1CnTtdycQtkhXo2/PI+KVg5rqlOitq1eYk+bA=;
 b=cLB0mrEj5Su8HnAyNJwhuDYNzv1i/QEDl08eEprCany4OW/BuZPHQ8z47tSwjhspNq
 Hrl184cbYNMCMGrxKWzPcmVzGPl9RweqwIZ14tUIEsAo9s17vyjANzIjwpGh9RGiEMNb
 wWFiNrPyDDQ1wOhEtN3GWHdjCN5s2PahCHF44mtvNJCJJScqYPixEjm+QzDjBFBP/e2O
 mJoGznpyDULAxPzD5A02R3a/s7baBUCER3FORc18AYI0Jzzjf73BKh5Eu72lsNvDtJ98
 P27AgxlA0duXxqA+7ZhKvT9C4bCOL33VDA1yIrfSnoU9HInCnJeSJXwhUf9ZdUdaIryu
 SZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695719298; x=1696324098;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+KfTCu1CnTtdycQtkhXo2/PI+KVg5rqlOitq1eYk+bA=;
 b=ujpGttyYNHaSvSApuSmx4UDzBiNLp7h8wWvKDZpvtWldFdLYgVxAxUmSM/6sm0AdDB
 U7yaEuQiyJPI0I8H9DDnI7AIj+cOr3BQE1CtlyMmMAg33tErwSwl7f10OWEZLh3zfvEC
 kJncVq48NcVd5bha+CkXw2u0I5i+GBacmrfw/Yyw/B3/7P/PAPBmsLi13dNcYVra8kY2
 gps7VbpReIxdxUbE2YwWMeWp7Yt6s1TRZX6QCC6WpqHbiZjDpCxL19D4lSH6na3HuoBa
 XqhV3aILwwZ9b9FQ897kAc4SD8FZFnb8c4cqC1kOA19JL4qwY+jqUzf9dzZA6Zxi8JUy
 Lqkg==
X-Gm-Message-State: AOJu0YzOGgutoTXvNZwWtOR9yH9pks29m+a5UcDB67P9JG3+21o6HULL
 kV46C+RzENtGOnAeUGHSQgnYPDF96jmk/Q==
X-Google-Smtp-Source: AGHT+IEW+tVR3puMavp0H9nW5/irtXwviccgZldmoC/fZ+eWBZF3QSw31l/zfp9wed09zFNXQDOV8g==
X-Received: by 2002:a17:902:da8e:b0:1bd:e258:a256 with SMTP id
 j14-20020a170902da8e00b001bde258a256mr3659738plx.32.1695719298064; 
 Tue, 26 Sep 2023 02:08:18 -0700 (PDT)
Received: from cs20-buildserver.lan ([2403:c300:c707:b24b:e4c0:3696:f2d7:f673])
 by smtp.gmail.com with ESMTPSA id
 be8-20020a170902aa0800b001bbd1562e75sm10421039plb.55.2023.09.26.02.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 02:08:17 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, KWLIU@nuvoton.com, jim.t90615@gmail.com,
 trini@konsulko.com, hs@denx.de
Cc: u-boot@lists.denx.de
Subject: [PATCH v1] i2c: nuvoton: add support fast mode
Date: Tue, 26 Sep 2023 17:08:08 +0800
Message-Id: <20230926090808.408095-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
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

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 drivers/i2c/npcm_i2c.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/i2c/npcm_i2c.c b/drivers/i2c/npcm_i2c.c
index ea4ef53256..b867b6c8e9 100644
--- a/drivers/i2c/npcm_i2c.c
+++ b/drivers/i2c/npcm_i2c.c
@@ -517,11 +517,6 @@ static int npcm_i2c_init_clk(struct npcm_i2c_bus *bus, u32 bus_freq)
 	u32 sclfrq;
 	u8 hldt, val;
 
-	if (bus_freq > I2C_FREQ_100K) {
-		printf("Support standard mode only\n");
-		return -EINVAL;
-	}
-
 	/* SCLFRQ = T(SCL)/4/T(CLK) = FREQ(CLK)/4/FREQ(SCL) */
 	sclfrq = freq / (bus_freq * 4);
 	if (sclfrq < SCLFRQ_MIN || sclfrq > SCLFRQ_MAX)
-- 
2.25.1

