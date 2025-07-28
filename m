Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F32C87FC9
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 15:04:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3625682CBB;
	Mon, 28 Jul 2025 17:04:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aqpG2nAx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B293B82E26; Mon, 28 Jul 2025 17:04:46 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A09E582CA4
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 17:04:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-455fdfb5d04so24925715e9.2
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 08:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753715084; x=1754319884; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=77EaQFaaBMAypnzqkem4N8T3B/GLUh4fYLru+9w9Dy8=;
 b=aqpG2nAxM5o0NWVIIXv9gFWNAUs7yGbrKG1EnZIpjzZ7YGM8CXdRf3vhfncKB0ClGz
 Fm41sxBBB4g1XNY+eofezrnSoLHe8SRglWZhN+x9ph7aYabhB59wO30Nys2UQUJNxMsX
 gmCvWypcOzYp5ngIbhJ4QsaHsVgjnmQbcvpezYWWsQQ9lxj8aW3E0eZ5XTxKHiRViKak
 54iordqGmIHRs5+yyNfOg3/4Dsgxw1amzhvbdv9af4xI00HrwT8q8f1rlRgGBOEtvo3/
 XJI1Pl0ObbM8T7v0gdkBrF1xnHxv88715PtmMuFcptsWWGNW++hhaoJsPcyWw+YGNHx8
 IIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753715084; x=1754319884;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=77EaQFaaBMAypnzqkem4N8T3B/GLUh4fYLru+9w9Dy8=;
 b=XSGZy2eD4qCIWNQWYcJwMQn/zjdCyWvExsLZ3rufr3rP1UTYtSTNyt/iicyVwPvU1o
 wd3vDhslaWcAA4xrp/WwI+aszWAXmC5+MHIJxweykcnTF86BddgUnjGVQIf6PTNNOoSo
 gJPYmzqOBDZHfLCN+JnJkvNeseCG67STZUA+IwqeWGiNk3qh0uerE/G5aqn0KbtrX3d6
 oW1IzWzwWQBRtHwk8Y0CfyS1UrUXReiKSvVcM9xqUANQbwL5zaq92JbxOtRnx00X2ody
 OnPRKphrMgAJQtz4odIN72AfajOJ6tIiDQk1Vqw0MDnEi4IC4+5b3OIECRGKigsdmqJx
 pJSA==
X-Gm-Message-State: AOJu0YzCMEZCjmojRFTT3X32zSe33m/PQ71wnSBqbiVH1y3FwlEu6Z+c
 pwwmmt3bbbV9Ey9v82Uj4Phj9Z7nOlLCi9tSZaNOpZIJW15D+r9JoROSrPQ1CtnCSnw=
X-Gm-Gg: ASbGncvDIbxAFm8FCTSkpj+Ox9uGmhS16aZQ5y5dkLkb1ppood0RLQUofhR9dJcDhhg
 vhc6PRy2dmXkcXXWV78Iclebpo7qTiSCPikUpShC3QrJ7LPAqcwvZCzWQUFLB9znIjX8iN0X6J0
 E3H4rAEpajlb5HraGDK299qiTwRAc+I3wmNoYyDRSzh1l0URppjpJ0b3j3VCBUfG+y8w/TMGTGm
 xp4ivL1rBpQKlxkD/xvWgJXa+X7n4fHM59Gmba3c2IulPivyTyKgWUhsMJeNjt6Kjw+4AZ1YpJv
 X/T8HumnC/HXRpFjKb8Opk9lmG2yDKanWyNF8unQd95E2bhpZNGEcCtx+PWGOzCmfQvJ2odMK7P
 4vKktxo9EoeVdHPXnZsH22LY5TaVWRrbtNyvwlKR0vsPaKZO0Tg==
X-Google-Smtp-Source: AGHT+IEOAWltYY3XOn3WxYLDZJ16uGAac9NHFyEX/BZY5WoSF1v89bT2DI0wicv0t3dEZcdku9n6Kw==
X-Received: by 2002:a05:600c:3e0e:b0:442:c993:6f94 with SMTP id
 5b1f17b1804b1-458828a9babmr52781125e9.12.1753715083914; 
 Mon, 28 Jul 2025 08:04:43 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:2df:19e4:8abd:eea3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4586eeb5f3asm108148115e9.2.2025.07.28.08.04.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 08:04:43 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 28 Jul 2025 16:04:43 +0100
Subject: [PATCH] i2c: rcar_iic: Do not use unitialised variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-rcar_iic-v1-1-00dd08660421@linaro.org>
X-B4-Tracking: v=1; b=H4sIAIqRh2gC/x2NQQqDQBAEvyJzzsJmiVHylRBkHFudQzZhRiQg/
 t01x6KrqY0cpnB6VBsZVnX95ALXS0Uyc54QdChMKaY6NqkNJmydqgRwhMjYDHy7U9F7doTeOMt
 8Ht7sC+wcvoZRf//G87XvB4HL0lFzAAAA
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Heiko Schocher <hs@denx.de>, 
 Tom Rini <trini@konsulko.com>
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

In rcar_iic_xfer if nmsgs == 0 the ret will not be assigned to. As ret
will always be 0 if the for loop is entered, may as well just return 0.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/i2c/rcar_iic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/rcar_iic.c b/drivers/i2c/rcar_iic.c
index e019d06be41..42d575e29ba 100644
--- a/drivers/i2c/rcar_iic.c
+++ b/drivers/i2c/rcar_iic.c
@@ -191,7 +191,7 @@ static int rcar_iic_xfer(struct udevice *dev, struct i2c_msg *msg, int nmsgs)
 			return -EREMOTEIO;
 	}
 
-	return ret;
+	return 0;
 }
 
 static int rcar_iic_set_speed(struct udevice *dev, uint speed)

---
base-commit: 4c3b5fcd810081bd7f3c51859fe1b5f0c159803c
change-id: 20250728-rcar_iic-ea0eccf7da46

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

