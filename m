Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BA5C87FCB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 10:26:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFFAE82E34;
	Tue, 12 Aug 2025 12:26:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y2HeX3Us";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A3688317B; Tue, 12 Aug 2025 12:26:10 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF12D82D32
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 12:26:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3b7834f2e72so2580785f8f.2
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 03:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754994367; x=1755599167; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=abTm/152PcXbzn3M1086/LJcy4TplDgPOCZPqSCwstI=;
 b=y2HeX3UslikHaPgb1oViekXpAbZ/WYoNvqWXOf6VZT30AK9jyZO8VY7wSoSAs8dIyG
 1inTkniQ0oP3mT8dIGC2QbS/lYHgSequWI3puaZcsR6HNqcIPMcrW+mf+VrO8/1vAwCF
 +vTTM/nTQ5r5OyWhMram+jPBt5b98oNb/9kVMGh1MojhMOxI8bQTQxhfSc3Gn/c8GhWM
 CwogwcCnkGmZh+Zt065TPSEI+bwYFUy3a1xEo6kBaEKbyjG+mwrF9XELwxsiuJ7MDj6Z
 JCyXWPMlq0g+PexRJNLz/Q4B28zSxKaSPtkH5YgXiP3l4Lu98ifvHd1/JoQ4Y5+TFlFW
 vgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754994367; x=1755599167;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=abTm/152PcXbzn3M1086/LJcy4TplDgPOCZPqSCwstI=;
 b=H5fc6ZKHcJ0u1FGuDy/WrSsHycyNm2ZaLfp+opJ4SRv82BCZYRyAO/hQ+GZ/nUc23q
 KW1Sx/HGRSBr4jkpnEkiDe/B/6Of6WcB/Ge72VRGAPiFzGCxLtTChQDvWWuH0N22tXwc
 +I2VWgiBJTxDZZve+ouNN9D2PQtFq7IQIgubgCPGtzqzQUXss+W1roXov6FDL2I4K9Xg
 ZGXw7+g/Z3AwjQCvLWofJ9yZ2Epu2Ls+MlQ0aoY+YgVMpAeaO7NGLrboGxtEt8ZMe6Na
 K8RqxECmTsLfbI5HRb8QYWhkkwakFl4PdWuYc+4oRG8urUxMUaJ7VPH/Yq79FpQR856T
 97nw==
X-Gm-Message-State: AOJu0YxwL15cZaYLgBTS2rbns6THUDbNma3th9ZENKOj708ISfp6GpKY
 iYrYc07SQyPSZPRkBuE/JwI51SYRf+SA3/FgxBgDL4rt9Rhq8zAeyWDxcAIdnExc0bp9SDm2RGG
 hgLW+
X-Gm-Gg: ASbGncs0G/AiBZrGQzu5n7GvLGZIKH7mocpb8kfDquNM7lkwXH4qCNyv+pLLfVkJcr3
 G3IFHThZ1sS+OY34QQHL/lBPSkwUoRc6YfacV32u4vpRQIMMucBQP+lN/PxByTRl/tRzlrkJmsu
 38guoleYKkRCOijy6WqD8f6S5LAhXfVjNBaRQEsNeVt2Ha8Gebc179mgPbLoEe/y5qUIs6f1fCl
 sVa8iII9Qy4Sy+B9NGcQiBj/hiVaazNVkwl++ZiVMHDCR60OIepHVuueMHRQZSDLKzg14McyqVM
 8XsegPOn3ZQPys7meU0oC7rAOuXMReT4astszOEW4lxKMsaBk+G8Iqm99YZiZRU+2EcJT2fu+ey
 TZYBXIVRc5umYT01Z5xE5DVuK7upYBtsa/CBONkW4MFF8msQJC8E=
X-Google-Smtp-Source: AGHT+IGU4QWypBUtn9JuM2kKgfKoak2s9a9tWO7HgKRJftOpcsqPATBmup+JgJPKyxCL8CEYEYi5Eg==
X-Received: by 2002:a5d:5849:0:b0:3b8:f8e7:7fea with SMTP id
 ffacd0b85a97d-3b910fceceemr2315387f8f.7.1754994367212; 
 Tue, 12 Aug 2025 03:26:07 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:97a2:1bc7:9f2e:6519])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b910180aebsm4312717f8f.59.2025.08.12.03.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 03:26:06 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 12 Aug 2025 11:26:06 +0100
Subject: [PATCH] sound: maxim_codec: Fix coding mistake
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-maxim_codec-v1-1-3941a84c0795@linaro.org>
X-B4-Tracking: v=1; b=H4sIAL0Wm2gC/x2NwQqDMBAFf0X2bCBGbEN/RUTW9bXuwShJKQHx3
 409zsAwByVERaJXdVDET5NuoUBTVyQLhw+MzoXJWddZ3zizctZ1lG2GGIfu+Wi9b60wlWLiBDN
 FDrLcTUD+3nqPeGv+T/rhPC9c7WrNdAAAAA==
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

In maxim_i2c_read the code mistakenly just returned the return value
from dm_i2c_read leaving the following code unreachable. Instead assign
ret to be the return value from dm_i2c_read so that the following code
can operate as expected.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/sound/maxim_codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sound/maxim_codec.c b/drivers/sound/maxim_codec.c
index 98f094c0e9a..505a739ad7d 100644
--- a/drivers/sound/maxim_codec.c
+++ b/drivers/sound/maxim_codec.c
@@ -45,7 +45,7 @@ unsigned int maxim_i2c_read(struct maxim_priv *priv, unsigned int reg,
 {
 	int ret;
 
-	return dm_i2c_read(priv->dev, reg, data, 1);
+	ret = dm_i2c_read(priv->dev, reg, data, 1);
 	if (ret != 0) {
 		debug("%s: Error while reading register %#04x\n",
 		      __func__, reg);

---
base-commit: 7807ed921314cd7af83fd88162d0b8c6fb20a9ca
change-id: 20250812-maxim_codec-2e57638830ca

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

