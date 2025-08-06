Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E5EC87FDA
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 16:55:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F9B384375;
	Wed,  6 Aug 2025 18:55:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wtGaV5T8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9611184376; Wed,  6 Aug 2025 18:55:21 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1106684371
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 18:55:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3b78d13bf10so24636f8f.1
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 09:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754499307; x=1755104107; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3cQPCP3VfSJE7qDMCeQoegngcIRNScdLaCp7Xtn1GmA=;
 b=wtGaV5T8CZjouaYZRGRhurhun02HzfF/T3UvHJbQYSqGE2pXSWINrGmSPmsjNRr6KY
 5Wo0VVAjYETcLEOjOPsa2ZHksMDiasczdmlNAxbZcLzwz0oxYrlmLrcVJ5q3OFXPm9KE
 5DEEgL7iI9lqXL8tX9pz3kf9E2ldtbedrlom7++AFIPHZbLTysp90rhgYNlWX368zJmO
 KnVVKNvG+sIvVw89Fg18LmA4CdIynGVkBEPy6HwBwnkmX14NaPYcYDx+ewzTtA5ASpk5
 vGjhFgwJ+RQTYsY3FE3ZdkU6+kDyKkEVHgkGR338/GuWkiwZF/hQ2hN4X61VXcHQZqUx
 anGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754499307; x=1755104107;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3cQPCP3VfSJE7qDMCeQoegngcIRNScdLaCp7Xtn1GmA=;
 b=v8ZLSB/egyaG6vO8qwWvksRYzyQ8AlzNTPgOOZEaYeNoeSXntqsHBJ8LF9mfN+Ryj4
 8h+16jS0ZIPBKD4yH2Laaqo+oRwKvaEooQBV7gQgXiHI+63uxD5vEAB+eds1DuHEUN9L
 +KAxFBr32WcYiiKtS9eCnoN+sPawNLPmJc3KvsYkvFx3amBI/kWnbVrs7te8gLvOuk3W
 p7xaR/Xvi2NDfbO4ho86bjzECiJwkXYX4F1R4MrxIpQuDrkQKZpwzgWV+BVvwo+nPR7w
 7fTh1DMF+U5+3xTvU2eEk9md8nBcZT9JMj4KYOWD9kanQ/xnwktwfUHpS/XXyWbHTNAN
 y6Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGbB2glFE4QYW82GZIgV7sL6Zi3OnTJQAQ9IKLi9JSDStqBa+qHViprfFMJzpitbshqpR4m4c=@lists.denx.de
X-Gm-Message-State: AOJu0Yzg8oo6b92atVjtCVt7NjAYUxJclsXK8y90WsfaQdwjO3d4YP91
 jWRRTau9bKTl+8nQ3DI/2fvY77HjAhSQin4HeEDM/RlgYPeuk0pP+lHIXBZE6uDUl1I=
X-Gm-Gg: ASbGncsTwEw7xxcl1SMhI456P9qDeipWkk4plNPpm8TZyDZx2KpBTMToVA2jGrQdtar
 uaD7jBVe8UNqt4ZlTyYOQzOXzkWNqLfvFf2yPqWpSsnCsg4jFTMjD3XWsuOsz4qvlS0xhzeaXoU
 7kcAr66FA86YYGUoVIrgFiOZDvI0Da06A9uxwgWg0n40ZVrtWw730UgweD0G2EQZgXcBkCuj8Ev
 13xBR4iq9orQMzuBNxZuNoLJbMRSmX+/gTMSpO7j+84cin3CVMH0L93wGLURQF3j6tnrd8EDA0F
 UTbYIzF+KG1p9PoS/9BCiv0ir5I8h9Rg/o9zD4KF4eav/SvQzGgue0RXWkx2VfkfhdtLyhNqzbx
 f5jw3xI/45zxRIsZHuh0SB+NMP+C3+yW9X2ih5YYcKoYct+y4F5o=
X-Google-Smtp-Source: AGHT+IGjU/LfwjRhYZExdwe8+JreOEDnIcYu4xva3mEEdWnHCuGmo5er9gSj0J+2B8HQrYUKSpcTRA==
X-Received: by 2002:a05:6000:1acf:b0:3b8:d082:41e with SMTP id
 ffacd0b85a97d-3b8f41b96dfmr2948906f8f.57.1754499307043; 
 Wed, 06 Aug 2025 09:55:07 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:6501:9a0d:7129:a02b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3abf0csm23137476f8f.14.2025.08.06.09.55.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 09:55:06 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 06 Aug 2025 17:55:04 +0100
Subject: [PATCH] phy: qcom: Fix ret is uninitialised
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-phy_qcom_snps-v1-1-5cda830026c7@linaro.org>
X-B4-Tracking: v=1; b=H4sIAOeIk2gC/x2NywqDMBAAf0X2bCDGV+uvSJGYrmYPxrgrpUX8d
 2OPwzDMAYJMKNBlBzB+SGgNCYo8A+dtmFHROzEYbWr90I2K/jdsbl0GCVFUWZTVZNyzNm0DqRm
 toBrZBufvarGyI98iMk70/Y/613leBZfgAXgAAAA=
To: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
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

In qcom_snps_eusb2_phy_probe after the call to devm_clk_get if an error
is found then ret is printed but has not been assigned to by the code.
Decode the error from the pointer and assign it to ret.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/phy/qcom/phy-qcom-snps-eusb2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/qcom/phy-qcom-snps-eusb2.c b/drivers/phy/qcom/phy-qcom-snps-eusb2.c
index b2655ac007c..28502c46f67 100644
--- a/drivers/phy/qcom/phy-qcom-snps-eusb2.c
+++ b/drivers/phy/qcom/phy-qcom-snps-eusb2.c
@@ -331,8 +331,9 @@ static int qcom_snps_eusb2_phy_probe(struct udevice *dev)
 
 	qcom_snps_eusb2->ref_clk = devm_clk_get(dev, "ref");
 	if (IS_ERR(qcom_snps_eusb2->ref_clk)) {
+		ret = PTR_ERR(qcom_snps_eusb2->ref_clk);
 		printf("%s: failed to get ref clk %d\n", __func__, ret);
-		return PTR_ERR(qcom_snps_eusb2->ref_clk);
+		return ret;
 	}
 
 	ret = reset_get_bulk(dev, &qcom_snps_eusb2->resets);

---
base-commit: 007610da2cca405ea7739fc120d90085be4b6ac2
change-id: 20250806-phy_qcom_snps-3134f2c95276

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

