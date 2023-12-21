Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0762FC35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 17:35:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00FF2878BF;
	Thu, 21 Dec 2023 18:34:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TCugtGGt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0347D8789A; Thu, 21 Dec 2023 18:34:40 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 159328788D
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 18:34:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zajec5@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a26988a86f0so123094566b.3
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 09:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703180077; x=1703784877; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uejKEmqNBQrYztiORMBuyN6ikCtupKPpOgESMooLig8=;
 b=TCugtGGt+qN5uyHkpyXAhH6rKpCyXju+fBX/oZM9y68WlO88Q4JnOY1HvDtfqk02a7
 jJgGvJcjuRUsAV7qN7eK9KLdrDsFIjASTAh0NBTpYZV7wo3HvL0LZn0qU0EUFmtYDG3M
 AkTA/vkeBHmoRWVWNKE/YpMWSZdV/Y31hXPFAHY9tZdCUtZsx9JOlPC1UDJR54kVmrO3
 HMJDoArrj8wNmBB0LappJkQQmI6QYDnkLEdDMZcW4gSAyyCahTFjXnM+kxfP80RWg5NJ
 IjzjMS2W9e9QvA7GHqT61kZ0sAHlRlYgwPU2ZFWke/5jpVQ4zBDf4PrsLwtNgAxhpRCA
 1/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703180077; x=1703784877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uejKEmqNBQrYztiORMBuyN6ikCtupKPpOgESMooLig8=;
 b=NSLlGOVI+2LVss/gFDn3VsPsmE2TANxjRo5HkXuoJpbfnj1ZhMzpiSvMBAw61cYa+M
 t5q4yJ5CSzF3CLGmB+GodXRLncQHjmpF4Tl5VkvrYEpik4EdtFWDWCBW3OCvcm6283sh
 inxBsmari/HbF3ZQFt8n/ICL/s3WhkbkmHMDVFg2cwlNR2iZ9+9Diih2C6bsZ0ewwKn3
 UwmjT+8ZMxwHhHNJlEmzZsyZeWe1QSCeVOy/2ywkhgbr2h1oy7pTGVC6Db2Qf/MpgfZw
 h08MiV504ufDsUUD0o0p4foXyOld2V46mC2SDUzdtINtEpqib6aZznV0MjvEQb62CU0K
 s+wg==
X-Gm-Message-State: AOJu0Yyd4wUAUL4oDDkyu9zrumOwpmCsEMWt84kKR9sEeqdTElqG6reC
 WEKqcCEMCg8Fc1isZraAtz8=
X-Google-Smtp-Source: AGHT+IHBM2cuaZaaA6HZDolSKAmB6b+hcQMYNNQNKu4rhLvbzqoo/2RVerHBx7krYnQ1piWwRFQhkw==
X-Received: by 2002:a17:906:29cf:b0:a23:8a00:cfbe with SMTP id
 y15-20020a17090629cf00b00a238a00cfbemr73085eje.132.1703180077492; 
 Thu, 21 Dec 2023 09:34:37 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl.
 [31.11.218.106]) by smtp.gmail.com with ESMTPSA id
 z25-20020a1709060ad900b00a23499f1d7dsm1176118ejf.209.2023.12.21.09.34.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 09:34:37 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Walle <michael@walle.cc>,
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-mtd@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, u-boot@lists.denx.de,
 =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V3 4/6] nvmem: u-boot-env: use nvmem device helpers
Date: Thu, 21 Dec 2023 18:34:19 +0100
Message-Id: <20231221173421.13737-4-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231221173421.13737-1-zajec5@gmail.com>
References: <20231221173421.13737-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Rafał Miłecki <rafal@milecki.pl>

Use nvmem_dev_size() and nvmem_device_read() to make this driver less
mtd dependent.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
V2: Don't introduce memleak when handling nvmem_device_read() failures
V3: Split PATCH 3/3 into two

 drivers/nvmem/u-boot-env.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index dd9d0ad22712..111905189341 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -127,27 +127,34 @@ static int u_boot_env_add_cells(struct u_boot_env *priv, uint8_t *buf,
 
 static int u_boot_env_parse(struct u_boot_env *priv)
 {
+	struct nvmem_device *nvmem = priv->nvmem;
 	struct device *dev = priv->dev;
 	size_t crc32_data_offset;
 	size_t crc32_data_len;
 	size_t crc32_offset;
 	size_t data_offset;
 	size_t data_len;
+	size_t dev_size;
 	uint32_t crc32;
 	uint32_t calc;
-	size_t bytes;
 	uint8_t *buf;
+	int bytes;
 	int err;
 
-	buf = kcalloc(1, priv->mtd->size, GFP_KERNEL);
+	dev_size = nvmem_dev_size(nvmem);
+
+	buf = kcalloc(1, dev_size, GFP_KERNEL);
 	if (!buf) {
 		err = -ENOMEM;
 		goto err_out;
 	}
 
-	err = mtd_read(priv->mtd, 0, priv->mtd->size, &bytes, buf);
-	if ((err && !mtd_is_bitflip(err)) || bytes != priv->mtd->size) {
-		dev_err(dev, "Failed to read from mtd: %d\n", err);
+	bytes = nvmem_device_read(nvmem, 0, dev_size, buf);
+	if (bytes < 0) {
+		err = bytes;
+		goto err_kfree;
+	} else if (bytes != dev_size) {
+		err = -EIO;
 		goto err_kfree;
 	}
 
@@ -169,8 +176,8 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 		break;
 	}
 	crc32 = le32_to_cpu(*(__le32 *)(buf + crc32_offset));
-	crc32_data_len = priv->mtd->size - crc32_data_offset;
-	data_len = priv->mtd->size - data_offset;
+	crc32_data_len = dev_size - crc32_data_offset;
+	data_len = dev_size - data_offset;
 
 	calc = crc32(~0, buf + crc32_data_offset, crc32_data_len) ^ ~0L;
 	if (calc != crc32) {
@@ -179,7 +186,7 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 		goto err_kfree;
 	}
 
-	buf[priv->mtd->size - 1] = '\0';
+	buf[dev_size - 1] = '\0';
 	err = u_boot_env_add_cells(priv, buf, data_offset, data_len);
 	if (err)
 		dev_err(dev, "Failed to add cells: %d\n", err);
-- 
2.35.3

