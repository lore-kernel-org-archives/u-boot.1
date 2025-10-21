Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9653CCD1A7
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 16:09:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BF5D832BC;
	Tue, 21 Oct 2025 18:08:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ale5lKSs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EDE383621; Tue, 21 Oct 2025 18:08:34 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18BEF80107
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 18:08:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-426ff694c1fso1040535f8f.2
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 09:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761062911; x=1761667711; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=h5/+hwKMaiC3Gv8GGkNC9jn+oy9J+A3/VC8stB67yJM=;
 b=Ale5lKSsbTo6CkU6P1mXh99ncZR84mXtgivZ7cZZVxoZTDId8WDKXqFkUfdL6G06gn
 4+RjHMYa2u8amEaweRlbq27OeW/tYAY3nDR7MTc0zKKI3Mz1iHVuQ7zZxBEj4qIVUO1q
 1a4LneGlNn1KecZ6M8OSjShQ7gTGQSLZ5OWFSQnR9/HBVDX9DDawRyv2Lxd8uAuzZNBd
 Ohe6EYrv89C4wM0PBPF7lDsh1dwlLop1Jt0IZ79rKDyfjl/Mj9xv4EYEItxBxS/6QEWX
 5cGzdCatu0pHHB4JbweaoNzexuIG1MzM8EqD1p1DyolrUyvpmazxTrZCInLrAAtyiB10
 2u6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761062911; x=1761667711;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h5/+hwKMaiC3Gv8GGkNC9jn+oy9J+A3/VC8stB67yJM=;
 b=f8ezbHSBJitFq7QqrNhr/cStkS8Z8Ia7J3g+cpKuGxkAuJLz/nI/XCxYEtHvbVyrha
 cE3ythLNMde4n/M8VjEdQATRNu3N7sBFwWu05WF4IfAmFcsryz9PZ9pMGoWbrGvOK6Hk
 jR2bMt6emSPTOiN9ccogNAenIYhGu6y6dACtX2sGQz98Iq0ffmTxfun+EKM9cDEctkHl
 v+zOYPkyr5HGTIe1BmPrXnW5pQ7tM78GpKpgSA+1UC7HDGJZ55V6U9J8u2I/KU7Bw3RZ
 NRtBuegwh4drUsneK0rstbcmCiW1WlQDxDd9W5nI8Uuhm1BYrZ339cK+TP+1GYy8hBAj
 W6AQ==
X-Gm-Message-State: AOJu0YyzGSDIBQ8blBtfrfEEFn/8+RHIGFQn5Meozb60UXQiZawQ5qJr
 fD9fh8ktKN7OuIV19EPf8Qvj6bvxax7km1KD3PQ2bPf7Abv0fxPcBYgVVyNb22iCxxA=
X-Gm-Gg: ASbGncuUSoJYo8Zw7Mz6bS9+jrKhn2wP7rU9pcz+9JNMYTPSc/BxvuXvaGnADN2sg6H
 9xCnF3C06DwTX8vyQQPdg7NEOy2/7/YchDTajppSCMueohDmIUqUpKfpV/6sfkrwdTCdrTuIcWj
 HZklqUCOnqIdd1feiJlWcwBoRujfCkUJcGVXdiBlQ6d8ttS78DvivAHru7tDVS3NVOykIbjB7XJ
 UU3Zk5EtwPMH1BKuw0ZroYbkfJLTKN2Uvk7BhiLOZlAPY9TAxJI6IpEH1jUf/TfNvaytifXCkyQ
 OzseuVZ+n6dGyE/j5L/D5haI7FxPaGhJsAg/i3oUS69PcTcs8r3Z2IZFNSzJ5FF9hNl5r8dD5HW
 TJ8xBWpOlpW4YsS2hEbQWW0VMXLAvNx9BzLzZ39dwAb2HPxcDEXIgm46CZ5Hxk8Gx/gUbNaO+WL
 X6swrEtbflErU7xF68R0Br03kvdIw=
X-Google-Smtp-Source: AGHT+IH7LWTeN9wuaWnK7Q8YRl9TFKIuF96K6ee1agbcd8/dlV8shWJiVJLVRZJ5skJFldheji8PPA==
X-Received: by 2002:a05:6000:220b:b0:3ec:1154:7dec with SMTP id
 ffacd0b85a97d-42704d8e21bmr14223533f8f.25.1761062911495; 
 Tue, 21 Oct 2025 09:08:31 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:ff54:533:2c9b:1f57])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5b3ae9sm20830245f8f.13.2025.10.21.09.08.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 09:08:30 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 21 Oct 2025 17:08:27 +0100
Subject: [PATCH 3/6] clk: microchip: mpfs: Fix error detection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-clk_funcs-v1-3-acf51a40eea7@linaro.org>
References: <20251021-clk_funcs-v1-0-acf51a40eea7@linaro.org>
In-Reply-To: <20251021-clk_funcs-v1-0-acf51a40eea7@linaro.org>
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Heiko Schocher <hs@nabladev.com>, 
 Jim Liu <JJLIU0@nuvoton.com>, Stanley Chu <yschu@nuvoton.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

clk_register() will return standard error codes so the use of ERR_PTR()
is incorrect. Furthermore the code was ineffective as it lacked a return
statement that would have actually made use of the result. Add the
return statement and remove the use of ERR_PTR to correct this.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/clk/microchip/mpfs_clk_cfg.c    | 2 +-
 drivers/clk/microchip/mpfs_clk_msspll.c | 2 +-
 drivers/clk/microchip/mpfs_clk_periph.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/microchip/mpfs_clk_cfg.c b/drivers/clk/microchip/mpfs_clk_cfg.c
index 7da1fc77120b63d569ee0490a72e1616dd6e8f74..b64fb6b719317dca58169ca9d339332929143874 100644
--- a/drivers/clk/microchip/mpfs_clk_cfg.c
+++ b/drivers/clk/microchip/mpfs_clk_cfg.c
@@ -131,7 +131,7 @@ int mpfs_clk_register_cfgs(struct clk *parent, struct regmap *regmap)
 		name = mpfs_cfg_clks[i].cfg.name;
 		ret = clk_register(hw, MPFS_CFG_CLOCK, name, parent->dev->name);
 		if (ret)
-			ERR_PTR(ret);
+			return ret;
 		id = mpfs_cfg_clks[i].cfg.id;
 		clk_dm(id, hw);
 	}
diff --git a/drivers/clk/microchip/mpfs_clk_msspll.c b/drivers/clk/microchip/mpfs_clk_msspll.c
index d0e7b1ff844f00c4fd97f9188a376d1837ef1d99..02b4a34446717532972e0d460765d6d1864d17fc 100644
--- a/drivers/clk/microchip/mpfs_clk_msspll.c
+++ b/drivers/clk/microchip/mpfs_clk_msspll.c
@@ -99,7 +99,7 @@ int mpfs_clk_register_msspll(void __iomem *base, struct clk *parent)
 	name = mpfs_msspll_clks[0].name;
 	ret = clk_register(hw, MPFS_MSSPLL_CLOCK, name, parent->dev->name);
 	if (ret)
-		ERR_PTR(ret);
+		return ret;
 	id = mpfs_msspll_clks[0].id;
 	clk_dm(id, hw);
 
diff --git a/drivers/clk/microchip/mpfs_clk_periph.c b/drivers/clk/microchip/mpfs_clk_periph.c
index b734f49d81aa2f19d5b142d74de5bb8644d5e52b..706d6841ee493bdbf6a1d4568b0327bcd54e668b 100644
--- a/drivers/clk/microchip/mpfs_clk_periph.c
+++ b/drivers/clk/microchip/mpfs_clk_periph.c
@@ -176,7 +176,7 @@ int mpfs_clk_register_periphs(struct udevice *dev, struct regmap *regmap)
 		name = mpfs_periph_clks[i].periph.name;
 		ret = clk_register(hw, MPFS_PERIPH_CLOCK, name, parent.dev->name);
 		if (ret)
-			ERR_PTR(ret);
+			return ret;
 		id = mpfs_periph_clks[i].periph.id;
 		clk_dm(id, hw);
 	}

-- 
2.47.3

