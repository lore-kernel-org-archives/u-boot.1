Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D8ECCD184
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 16:08:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7B95835B0;
	Tue, 21 Oct 2025 18:08:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gaQOjf/u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2793182B20; Tue, 21 Oct 2025 18:08:32 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34A8B82B20
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 18:08:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3ece1102998so4926197f8f.2
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 09:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761062910; x=1761667710; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hhO1CBL1fETXY44AkbZSlcIZaV9InnXlfZYhCJZciHc=;
 b=gaQOjf/uUj/eP2dLXGVgkJl3JTtQgn8D5T8fLYOsovKjrGLsKcl+XxG/h+mMmHTyQd
 nbU7IarBEQuFb1y6h2bw/slVNdXLujhdgIY1/F3nSgAN4ssWw1RB070qlnsTqnIr5B0C
 BuAJcQHgMXwk3nXcR1EGW342aqYfcoJLh1XCYqll2P66lNcw3uMzNsaXLTM9hyNOGiNj
 j9BKmm2tKmYc8//f1Z2wZkhR2Wyk1yEC6CiiXzTJ94bfYVu5XTPJWqZHkzO5LucksJdh
 nyDdqkAM+3twJ4pqCVg/Y2YwPxTDUAK4VpIr6iUfiLbEFIcIYkBCTGOq+E6rfWNoQPuz
 XtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761062910; x=1761667710;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hhO1CBL1fETXY44AkbZSlcIZaV9InnXlfZYhCJZciHc=;
 b=KmtXgEN7GL8D6JlTPXMNEsz9GN9lOzcv8up6WcMdjZvugxEsVVIvL8OL3sWc3ySFHk
 8nHoHmBmSccpYfO0UlEfYRArSxIgwOLc+ZnIJ/c0+tNb0z8dMcklpcUvGxaDV3nEeHBN
 u8spcuOGYz+TIYQdeby4BwJ7xaGGOHfp42rbuTuM6B+8wLyT51Sriwv2urGocbKJPX3J
 +IfTwq7CionOrLdYwEXKMsRJHZ5qNQnL3N6SEyVg9YD81oIRaNVDv4XAIADHf+aRJGr2
 xWMUjDjfQN4RRz6oJDF/9q8HvWb3r5QsTQ/v09d7/0ejFQ5DUXHHHkkjIS05ZJ0laQ3l
 ldwA==
X-Gm-Message-State: AOJu0YwlmtaZhuMWeRJ7Kgayzm45rHpMSz/yWIqJGF32z+fEh4LpsSlm
 T91TPaqttOnhsr6YUCrHdR8fHxZbZcux1zxmaQBl5r70kGKQCooMLE4oKPUt6RgEfWg=
X-Gm-Gg: ASbGnctHhCC9KB7F/5oplfA1yqrPV/BbgUsGF0HHEPEovI0yeAb0CiijWMHs9laRw8Y
 h9q0e2hvrhkfZ+FqC2XrXheV+xOx5V6faO3UtW9KUHIVNMyTwNLqoVLZ0UB52/sfMNPom2aqdEI
 WgD/GPtO0E9lm72cYjq+gg+RLCjCDHwYx8s2PJlN41Rq7y5bAW42DX1SQ5hUoalKIMowBpHn2Se
 NIg8y95vpUCGDBbVf5RH33HigzvoM/OAOxZMSN9HsxaGgBbZ+YG8qyCzp46mjVL/Y9MaQPtMSDQ
 I8ubKIUtvZx3R/hO1hHQpeGh1y95WqThmj4rUoRcDA12H9b3dbNr+VJdbLEQnhqOaPaFuQWPJM7
 wky29oHcyIy2fSGIRbM0oAbfaXwlcY1Fw7RMz6yyvuS8CvSq3I6eR8GqX/kA/a7py58uAMpMUoB
 mjW1CWSqCKCHa8pYHU/ZkC90SJOqU=
X-Google-Smtp-Source: AGHT+IGtCD0fvt6cA/KhdAjvoZ0qq8bhudTw4oSMwbhvkcJ4OPm4lU+D1F0K/rl/SsO6TM9Nnys5iA==
X-Received: by 2002:a05:6000:1884:b0:427:167:c2ce with SMTP id
 ffacd0b85a97d-42704dc9f6cmr12811912f8f.42.1761062909590; 
 Tue, 21 Oct 2025 09:08:29 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:ff54:533:2c9b:1f57])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5b3ae9sm20830245f8f.13.2025.10.21.09.08.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 09:08:28 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 21 Oct 2025 17:08:25 +0100
Subject: [PATCH 1/6] mmc: hi6220_dw_mmc: Fix error detection for clk_get_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-clk_funcs-v1-1-acf51a40eea7@linaro.org>
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

clk_get_rate() returns a ulong and that return value is assigned to a
member of a struct that is an unsigned int. So testing this value to <=
0 will only detect a return of 0. Also the code in the if block assumes
ret holds the return value when it does not. So update the test to one
that will work as intended and update the if block to actually refer to
the return value.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/mmc/hi6220_dw_mmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/hi6220_dw_mmc.c b/drivers/mmc/hi6220_dw_mmc.c
index 0302f5c296b90c6fd89f7d32b91758291499f6af..27609e90b1f4741dcb1a95afff8be5ce2d5e5a8a 100644
--- a/drivers/mmc/hi6220_dw_mmc.c
+++ b/drivers/mmc/hi6220_dw_mmc.c
@@ -114,9 +114,9 @@ static int hi6220_dwmmc_probe(struct udevice *dev)
 		}
 
 		host->bus_hz = clk_get_rate(priv->clks[HI6220_DWMMC_CLK_CIU]);
-		if (host->bus_hz <= 0) {
-			dev_err(dev, "Failed to get ciu clock rate(ret = %d).\n", ret);
-			return log_msg_ret("clk", ret);
+		if (!host->bus_hz || IS_ERR_VALUE(host->bus_hz)) {
+			dev_err(dev, "Failed to get ciu clock rate(ret = %d).\n", host->bus_hz);
+			return log_msg_ret("clk", host->bus_hz);
 		}
 	}
 	dev_dbg(dev, "bus clock rate: %d.\n", host->bus_hz);

-- 
2.47.3

