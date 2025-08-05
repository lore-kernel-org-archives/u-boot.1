Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054E6C87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 11:04:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EFEB831D8;
	Tue,  5 Aug 2025 13:04:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RgWT9s7E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0668832EB; Tue,  5 Aug 2025 13:04:08 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58ACA83189
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 13:04:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3b8de6f7556so1237021f8f.1
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 04:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754391841; x=1754996641; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OakmwBTkVBV7W5heAXHfdiIuighr+Es2lre4jMpjifU=;
 b=RgWT9s7EJRW0PwpkpUOoKz/gK9mdaJoc6FRyu6L/LXx3d9Pv9go6QUOL8nTIpTcfcL
 mPArVlQSuJ/1/Dv4Vda/de5uRjQWnEfVZMF/5PqWdmPinV6aKHKBOStjSBOuL4Uo5wTC
 Yva3NurDB6nfaGmMnQqZ8xFNgDkykvAXqFKQE43t6UYydtBJDkXQx1A+tAje79VGnoNI
 osFjAj1Jmfsg4URpZJhBz89Mk4qrT0IW/4CgKe9iLyTS3tGizc3GEKnTifCqR65wT2my
 BewCzBNwXA8u9t/axxH2cdgzis91BrVULRU7uSK1hLXJPU8yCk9qOnmYKIqdWDKbNVEw
 7zrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754391841; x=1754996641;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OakmwBTkVBV7W5heAXHfdiIuighr+Es2lre4jMpjifU=;
 b=BQ0vOmop518sI35JEAuFeaw5azrstjUjdeGisPybyRYksYhO0KyoC93+Vd8sZLOHr3
 0yhOp7VoJklWFbAO7IvZSztgZjBO1xbre2n1sRjGFPrCvj54S3EnG1R5Q9wuMA+yfFnE
 3bUO3L81brWjXqC9UZQRhzk0wvt17P6LjZShm/EZ+UvdID7SC7tgU0GemwZniCZDNCOO
 ezJpNTlEhxBTUHnViktuMW0vobPohWyMqBSczpsMuKBJ34WISj6CnyXOEYNkDgW2s2Ft
 jlsN4UzTZWjyHMCdpzdyv8m+EIDUlnvBVYIJli0e897yIti2bzl6XdQesvbUbMmzqzVS
 lSng==
X-Gm-Message-State: AOJu0YzApYxUVUp0jMepeksxiuZ2V6nHsHCL4pOdcVJf0OfA6ZAPecEs
 bmUfLCiXOk4j1+5vWStqcTdtws6HXAQG/woq+gJeaBN+VXnx4BddZxlLmyoCrP9XqTg=
X-Gm-Gg: ASbGncsgiY9113+3spMqQtnTY0XO/kkIQb7rfeJuxupdPZDEdUysfpBDFa+HftES97L
 70uuvsDm5GewrmSx5ca2thgZ/6FKVd0bsqLL26XWkK6jDbj0lwGNYe55dbGiPO2q4Yx/SVkFa/X
 m+xuk+Bi6rD+Tw0R8JMT1uorcs3u2gz2+0jNf25XeBprXkP4QDBy2JWAlJjepK4TxXZoSIo713F
 1kK2c41aPXzZjn7hDpz9ohqyFrwSZzPjt2ykBJpFYV+IYLC+xVAzQG7yMYgFFZTL2Q6IpRvuTA7
 p0y1dIQ+8N9Q6v0VAQEzHbg1I4N7+PJImhxd+EpxMN+q4fTiJhYuU1sy7zMUr/4t7ko6T2IrSd9
 vi4aYoGbyp41xcBqB7M5R1JPjJIn8UiXhh/TmKcVhx9WjoQM55A0GE+XhaGlLPw==
X-Google-Smtp-Source: AGHT+IGNtql4W/bR5VtqbIkyvCAVov10xGET9WQZir7qmyFFiCnzFc9Tv2AEJW1YKq3M34hP+OTaRA==
X-Received: by 2002:a05:6000:4203:b0:3b5:dafc:1525 with SMTP id
 ffacd0b85a97d-3b8d94b5c13mr9085091f8f.33.1754391841550; 
 Tue, 05 Aug 2025 04:04:01 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:60bc:24e3:6dcd:9f35])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e0e70218sm29667485e9.20.2025.08.05.04.04.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 04:04:01 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 05 Aug 2025 12:04:00 +0100
Subject: [PATCH] net: mediatek: Use correct variable for return
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-mtk_eth-v1-1-eff84af1ca5c@linaro.org>
X-B4-Tracking: v=1; b=H4sIAB/lkWgC/x2NXQrCMBAGr1L22UB+KBSvIiLb9NMs0ii7QYTSu
 5v6OMzAbGRQgdF52EjxEZNX7RBOA+XC9QEnS2eKPo5+8qNb2/OGVhxSmFJM7JccqNczG9ysXHM
 5+pWtQQ/xVtzl+19crvv+AyzPKHlyAAAA
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
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

In mtk_eth_of_to_plat, the last error check has the value in
'priv->phy_addr' but returns ret. Correct to return 'priv->phy_addr'
instead.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/net/mtk_eth/mtk_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mtk_eth/mtk_eth.c b/drivers/net/mtk_eth/mtk_eth.c
index 5d6a42bceb4..b172838ba3a 100644
--- a/drivers/net/mtk_eth/mtk_eth.c
+++ b/drivers/net/mtk_eth/mtk_eth.c
@@ -1461,7 +1461,7 @@ static int mtk_eth_of_to_plat(struct udevice *dev)
 		priv->phy_addr = ofnode_read_s32_default(args.node, "reg", -1);
 		if (priv->phy_addr < 0) {
 			printf("error: phy address is not specified\n");
-			return ret;
+			return priv->phy_addr;
 		}
 	}
 

---
base-commit: 007610da2cca405ea7739fc120d90085be4b6ac2
change-id: 20250805-mtk_eth-e318323a0dc1

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

