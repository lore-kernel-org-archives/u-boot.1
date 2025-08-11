Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6A0CA0ED1
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 16:25:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90E3C831B4;
	Mon, 11 Aug 2025 18:25:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LzQmtSmC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CC25831E1; Mon, 11 Aug 2025 18:25:21 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24CD982063
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 18:25:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3b7862bd22bso2777893f8f.1
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 09:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754929518; x=1755534318; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=v/ZWU34/Ty+ltTooc9zJ4CBYv/wYTota4L8/a+y3Qgs=;
 b=LzQmtSmClj4zFIlLc6Zx0aDTpR0EN2m+FT+LWDlMcg1a4htNp9ZWQomtKfYrjcTvQQ
 JxTVoWdqRS6+1ljcTeweqgRHK5uRg1814bQAI2g3MZyJOA+viQaYasbov1H+RL/CZG41
 YFKplWsaNzURYmyZsJ5ZqAiijOeVDNVChL6X3mDQsf/ZrT2fuWZbEM84gBBPQUV8rcsM
 X/PN+PaTX5WnumAJoZlsK981yXrETmV7bmNisWHA5QUBhzVCvJAwuiD7y9QTpyjowuKq
 /k5MCJUQPSIEqhfpt8xcOE2c/vcLI2OdS9vi/qSucrRKJPIfDhe7CqxKC/yc8H31klyy
 xeYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754929518; x=1755534318;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v/ZWU34/Ty+ltTooc9zJ4CBYv/wYTota4L8/a+y3Qgs=;
 b=RY49OM7wMX4sfJBEeq268L84FIkrdSa/jV/h2CtcDMFuMgFIcq8INF7wQ3OkOKe5KM
 xH+PlTrkyVRmBWnng36LMM1uxAHgU8GScwt6HOXjIs847Tc3IoX35uBu3N/JXbBpwfQZ
 1OQcG7pNRW2CqZBin+2HVAhD8YijgX+T5xBXbL4zd6oeKxNJt3UG99C7V09o0NTsqwWh
 3HaC/vvbPkUzJ351vX78pNA8pVarRj74dP73FowtH/Y+uTlVDJLg+P2iSkemG69JIroe
 D+O9LeJYJxNImNysUKlWlh8rll5r5bEy1cfiudlA1kr5PV94LHZf0ZnQPwSX6sj/gvYw
 zM5w==
X-Gm-Message-State: AOJu0YyOPc0UjMzChhFsnO9+CJoLtH55VYWYZgYBHgEbvCGwoTcZkUuq
 qxvu4TAzcDv5aTD0z2WYw7VyJ7E+CxskPxBQDFCR1fwmIE+OAvTWEwLvfXIU0zt3ml/LwPFTWVu
 4LwBA
X-Gm-Gg: ASbGncsmzanC4YTd/ERoyfpA0dn662JJxwhNF+OgJvwzYZ4CYJf5tXoa758brRR/m/o
 nfglE30oFxTtoKpcyH3tAJlEtgIFgr/M4MWsxftt5PwtTK72/3tYQfdSoghddVX0/4XdQ0yRlmd
 yG2bEjIJh0iG9sVrHSJ66Umlqflr1C+SRvlRci+Z2Sv4kYHQvo6JzaTv/5D7KVaSS0cCjOePjDt
 xqnDXr5kqmJddYEPm1yYySsT4li0A5E5FYLhdCsDvOVRiuccEcrGJvQgCOm8ioIrAA9txjwF7eg
 Wjw9Px4WH4Y2ipkZImawYuAYHlX77wsU/EslZm/IbalKVxPO06/IRhD5pm1Md5A0E9/n8ZLM/7a
 /NA1tst/l189zqsOUYRQOOJ6BMGi04H7jAu+rVJTGOertrgzV9Ow=
X-Google-Smtp-Source: AGHT+IEh18lEa5JcmPy4zH6c9OSoca+E3oMP/GlnLp6Gv9WPE2PGJPnSOU5nYfHyJCLkZhA1LlS9oA==
X-Received: by 2002:adf:e549:0:b0:3b7:8ed8:1c80 with SMTP id
 ffacd0b85a97d-3b91113c95dmr127609f8f.3.1754929518455; 
 Mon, 11 Aug 2025 09:25:18 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:3e73:96b1:418e:3053])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459ee17535bsm223882985e9.16.2025.08.11.09.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 09:25:17 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 11 Aug 2025 17:25:17 +0100
Subject: [PATCH] serial: lpuart: Return value from correct variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-serial_lpuart-v1-1-6f498328554d@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGwZmmgC/x2NUQqDMBAFryL73UCiFLVXkSJrutEFG2VXpSDev
 Ymfw7zhnaAkTAqv4gShg5WXmMA9CvATxpEMfxJDacunbZwzeY9zP687ymYwhLrxNlR120JqBlQ
 yg2D0U66+qBtJFqtQ4N991L2v6w99TdV9eAAAAA==
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In get_lpuart_clk_rate if the call to clk_get_rate returns an error then
the call to return should pass the value of the error which is in rate
rather than ret which will be 0 as its value is not affected by this
error.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/serial/serial_lpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/serial/serial_lpuart.c b/drivers/serial/serial_lpuart.c
index 93602797b83..9fdb6503085 100644
--- a/drivers/serial/serial_lpuart.c
+++ b/drivers/serial/serial_lpuart.c
@@ -129,7 +129,7 @@ static int get_lpuart_clk_rate(struct udevice *dev, u32 *clk_rate)
 	rate = clk_get_rate(&clk);
 	if ((long)rate <= 0) {
 		dev_err(dev, "Failed to get clk rate: %ld\n", (long)rate);
-		return ret;
+		return rate;
 	}
 	*clk_rate = rate;
 	return 0;

---
base-commit: 83ce0b483c1680cb39565a9d91c6ef113a309c38
change-id: 20250811-serial_lpuart-aff78c0f3799

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

