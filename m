Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857DDC41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 17:41:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70BEA876B1;
	Tue, 19 Dec 2023 18:40:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f0VetKGA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DBA4876E9; Tue, 19 Dec 2023 18:40:46 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9F1087692
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 18:40:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zajec5@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a234dc0984fso331032666b.0
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 09:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703007644; x=1703612444; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lvbpVGdOkFoSIrqGEOI2u72GgRBjNjQRomAfCiRlrrE=;
 b=f0VetKGAjU5qKHiTM9shL0x9JZHEIFSnnXwGaOyjoWu/ovyZMKNcxUTIajeWelCba+
 JWIfaq4QOXSSK0nD7kmUY8eQLws4QVBC3Ms0FJgnBH6n6jYmWoqLHfTyDmr2D9F+/857
 jjp8upW7qGrpeeQXNC9NH7gS+Zrv0l1Y/a8paKebIo6q581jPTD83eOrYKfTx3g/Fy85
 Jz7MibPEXcCAG4s9iHmdryEn7Aq2CduM7lZkcBaeOnZy3B+D0AbeCPKJlJlUb/g+3aNo
 44j47r40P/Opi92lNYf13L0Ckw43qgV1HfwiF3Vc0h1+7ax7ElEj9wsDwTuU5lg8EUEy
 hH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703007644; x=1703612444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lvbpVGdOkFoSIrqGEOI2u72GgRBjNjQRomAfCiRlrrE=;
 b=huflONL5Yam13XaNSQdLuuxOShxgXhfU1+Cakvo8hZ7L8+mbWWdONJkxu1/yZqVHTI
 KuoiN4YzKL6xGvKCKWdAcxzCgG3igBlFL9VOOUiCXXCOWcp7WL0P1aRUcq2dDw7Bnngo
 NEsQw/Z9s0ZVfYhTzGAXpLgu3o4clsKz1sOYjz/ai+qNMp0BDPZEXVnci+D3HQm4VOBc
 e2kA7guKi9Qawk/4UJbEQ5Jm3JFY+laBTTAqRz9g8ovlZ/NjH1Bk3nu6MfJC7IzCJJxw
 JJ5CyXj1kVMtzZodTN7sW++ac1oYwVjb1ldqmcyXFwyfyshJlLv34Hpz7hl774BGU7wF
 cwPw==
X-Gm-Message-State: AOJu0Ywv3h3Tki3zMloZKZSXr1UuT/TlqRIcXzL5euWtiUvpYx1ULacj
 Vxmgniol4BFbaVX9hfQ1ybU8OdVPR2c=
X-Google-Smtp-Source: AGHT+IF7v0el0xOUJw8FCEGpmE14E0MqTBdoBv0Uaj9ZYjmK4P8W4YVF7oTGw5Pmx8ydiXStN/I61g==
X-Received: by 2002:a17:906:da04:b0:a26:8919:6d99 with SMTP id
 fi4-20020a170906da0400b00a2689196d99mr274634ejb.2.1703007643985; 
 Tue, 19 Dec 2023 09:40:43 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl.
 [31.11.218.106]) by smtp.gmail.com with ESMTPSA id
 tx27-20020a1709078e9b00b00a1c85124b08sm15834840ejc.94.2023.12.19.09.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 09:40:43 -0800 (PST)
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
Subject: [PATCH V2 4/5] nvmem: u-boot-env: improve coding style
Date: Tue, 19 Dec 2023 18:40:24 +0100
Message-Id: <20231219174025.15228-4-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231219174025.15228-1-zajec5@gmail.com>
References: <20231219174025.15228-1-zajec5@gmail.com>
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

1. Prefer kzalloc() over kcalloc()
   See memory-allocation.rst which says: "to be on the safe side it's
   best to use routines that set memory to zero, like kzalloc()"
2. Drop dev_err() for u_boot_env_add_cells() fail
   It can fail only on -ENOMEM. We don't want to print error then.
3. Add extra "crc32_addr" variable
   It makes code reading header's crc32 easier to understand / review.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: New patch with suggestions from Miquel

 drivers/nvmem/u-boot-env.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index 111905189341..befbab156cda 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -132,6 +132,7 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 	size_t crc32_data_offset;
 	size_t crc32_data_len;
 	size_t crc32_offset;
+	__le32 *crc32_addr;
 	size_t data_offset;
 	size_t data_len;
 	size_t dev_size;
@@ -143,7 +144,7 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 
 	dev_size = nvmem_dev_size(nvmem);
 
-	buf = kcalloc(1, dev_size, GFP_KERNEL);
+	buf = kzalloc(dev_size, GFP_KERNEL);
 	if (!buf) {
 		err = -ENOMEM;
 		goto err_out;
@@ -175,7 +176,8 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 		data_offset = offsetof(struct u_boot_env_image_broadcom, data);
 		break;
 	}
-	crc32 = le32_to_cpu(*(__le32 *)(buf + crc32_offset));
+	crc32_addr = (__le32 *)(buf + crc32_offset);
+	crc32 = le32_to_cpu(*crc32_addr);
 	crc32_data_len = dev_size - crc32_data_offset;
 	data_len = dev_size - data_offset;
 
@@ -188,8 +190,6 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 
 	buf[dev_size - 1] = '\0';
 	err = u_boot_env_add_cells(priv, buf, data_offset, data_len);
-	if (err)
-		dev_err(dev, "Failed to add cells: %d\n", err);
 
 err_kfree:
 	kfree(buf);
-- 
2.35.3

