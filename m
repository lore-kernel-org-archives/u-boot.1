Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30034C83F17
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 11:46:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACC0483824;
	Thu, 31 Jul 2025 13:46:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TxerLRd0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C10AE8388C; Thu, 31 Jul 2025 13:46:13 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB30383816
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 13:46:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45618ddd62fso7819205e9.3
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 04:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753962371; x=1754567171; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cyDVf4CWgzKlzBHI/HJh9P0+CTibYzvPtFLz8BJUR6I=;
 b=TxerLRd0rmjTTvwCJc9ezXW0s5S8eGTzjfFT1hN5PaD6UlBxbhTbxQzz3AZn/GoPth
 DTBiXbKlU7q3JNx6rVjja12SRNa3HISgMAv+Caae48z3HB0i6KhxEuI5aiOLBcCQJDvi
 OlxVEjCNtEiUnX/22UNCxOulTDZCFDuVjMh+4q9Q9SKJjn8bwkI64PQmXafPBWhHaBSR
 JSG3kHp8KhVGZllYLEtCjHfb9gZLgp5fHGQwaL5yrwVIr5YTirTAVDUcHywIfcEc4hkJ
 73U/z0PewRPZbH8pzTOKMdK2Il4kBd+5e4FbQHa13z1H75E/AQ4o6DjCh6clTS9uXokD
 Dc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753962371; x=1754567171;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cyDVf4CWgzKlzBHI/HJh9P0+CTibYzvPtFLz8BJUR6I=;
 b=RsmgY6PKPmQ1SOc5Vltojcqx0fcahB+N97+9LM5xuaxz86oGhN2zaNa+K64uEO1AiQ
 MrXzMxcGF+sCyKT7wqEXolmkojdo+9cK2auWsXgre+PmMhnAv50b8oxIIOM9HIex8TJP
 1zK/JskSSSsX7pKAVGjiG2cypbIBbIVzfFkk3UGvKhI43ABuYkALODyGb8arUxXF6akX
 LJbYwQT3jXDpxd1kSkttdbJbxA8VLb5hOnCXllPXduOA+bhRWEtRjArIC9p8HfN7P48E
 jbZAc/JJoLdvMskfyeH3zdIKbSGRsc6FnZ1Ibk9mutWusEK5kwRXKF0PnoBryi3upE4V
 7LEg==
X-Gm-Message-State: AOJu0YxDc6RYOX19hQ1OmkmJE9pmeVLBTjD1DrZQJkQS7DuD/jPwkvQc
 1UA45EbeoPtv94VxoWk8Kc7rtQYJw/g7Ml599DGeEB3V1gLRn+/XleGjSRMvsrYgrMQ=
X-Gm-Gg: ASbGncveSbxS/Cx1VXhRcaMagZ4MpE8d+uOv4nfLrzNUliHn/fBaR4EonQn9BpXZBO8
 28ZgnAG4c24DpqMBcxoaPnEK9uIChpDYtuU8P2zEJ56cOOTsE1mqNpeApgXM3PfLf/kMuvUjl65
 cuSmuvYn3Jk78Vy5hAxJ79Q58v3GR9L3gtz1voHxGm3Np9Wsev705Qh0W9ZPtkgBK+lIzq1ltdM
 126VLwl38qJqDm8FSxjW3L8f4z6Swng0MyKmJc89R2n/z4VX2U4uOEhwVUuzUuu6Ftz14z4EHcH
 RnJQps+7FSHxw41/w9/+unVjFOj8zkuCZECSy2iHAEE03q7u+IXrgVlghhgaTaKD8WyORjjH2am
 o3sDNmmVBs7jNFUOgOHKB4+pMj2pYdw+2Y4XTT5n4/9/bq1neLzls+NgYGNVB
X-Google-Smtp-Source: AGHT+IGKAh2pCEoEdSGNn/C6msifgGKnvZUCv7p83IqhbwRbdsWHaPbQnXDzResqvbIbO6IczkIRyA==
X-Received: by 2002:a05:6000:2c0b:b0:3a5:57b7:cd7b with SMTP id
 ffacd0b85a97d-3b794fd735emr5714449f8f.22.1753962371221; 
 Thu, 31 Jul 2025 04:46:11 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:14a5:dbc6:afe:7138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3ac115sm2174846f8f.12.2025.07.31.04.46.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 04:46:10 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 31 Jul 2025 12:46:10 +0100
Subject: [PATCH] mmc: rockchip_sdhci: Do not test unsigned for being less
 than 0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-mmc_rockchip-v1-1-74baef656cca@linaro.org>
X-B4-Tracking: v=1; b=H4sIAIFXi2gC/x2N0QrCMAwAf2Xk2cLSMSr+iohkMdog7UYyRBj7d
 zsfj+O4DVxMxeHSbWDyUde5NsBTB5ypviToozHEPo59GjCUwneb+c1Zl5DOKSKlEXFAaMlELmE
 yqpyPqJCvYodYTJ76/X+ut33/ASYQ2zd3AAAA
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
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

In rockchip_sdhci_execute_tuning the variable tuning_loop_counter is
tested for being less than 0. Ensure that it is a signed type by
declaring it as s8 instead of char.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/mmc/rockchip_sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/rockchip_sdhci.c b/drivers/mmc/rockchip_sdhci.c
index 761e3619329..5e025d76a82 100644
--- a/drivers/mmc/rockchip_sdhci.c
+++ b/drivers/mmc/rockchip_sdhci.c
@@ -500,7 +500,7 @@ static int rockchip_sdhci_execute_tuning(struct mmc *mmc, u8 opcode)
 {
 	struct rockchip_sdhc *priv = dev_get_priv(mmc->dev);
 	struct sdhci_host *host = &priv->host;
-	char tuning_loop_counter = SDHCI_TUNING_LOOP_COUNT;
+	s8 tuning_loop_counter = SDHCI_TUNING_LOOP_COUNT;
 	struct mmc_cmd cmd;
 	u32 ctrl, blk_size;
 	int ret;

---
base-commit: 79f3e77133bd7248e4579827effc13f97a32a8a8
change-id: 20250731-mmc_rockchip-78721a751131

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

