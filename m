Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33B6C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 17:34:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E37087886;
	Thu, 21 Dec 2023 18:34:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dl58rL0Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCD66878A1; Thu, 21 Dec 2023 18:34:36 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 020C087886
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 18:34:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zajec5@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-55370780c74so1261013a12.1
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 09:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703180074; x=1703784874; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HS/utwklj/mQdHgmYltSxcVR9bMR4HdMDBmcgJXrZDU=;
 b=dl58rL0YZM3iU7ZuutZVQ2iPM8x+fUO5iTkhkSj+hJdQnoQcICw9PVJ7/+FBhWuzQk
 w8QrMEdp3p8UywNa2+NML7P3PWRtHhXcMQIce9/LxC2MjnhEyBaJhmu/rD8gdNwX9PSE
 CF0GNzjTYMeOfnFjYPAkxhrka1Rva5Pb8L1MaHc8Zkp1pNGed1YhF3jEUjn4jEN/6Bnx
 6mZSVvGaqPS6esVVHUNtzTgFIW39oOclUdcAFrZhiluYKe6HNUgfDd9Q5tkqSmXr/YSt
 t0QPNuhDP5qIc+LXvi7M5im3PBW3zhF+0ucJBjBRgWGf0P7kIP7ADHBpXGm5jiIqVYvp
 g9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703180074; x=1703784874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HS/utwklj/mQdHgmYltSxcVR9bMR4HdMDBmcgJXrZDU=;
 b=vV2F5smdFvQTIDDFQvy935ItjCLneJ/XyN+vj3ebm18EondR5Y+MTHsrtazQKMhmJH
 Zy35+cJvAJrz1b73zweBy3OwJ0EV+4OiOziRNueJVGOFisAx9WzhRCdNtCxTh1FA0qRx
 1ftaJRwEzUGhGry3X66+wZoCUu2ytDzu+w4P1PtKP5ygaWw+TjjnqHSM9Kpd4odasyh9
 haw5rq95GUA/Ta8NKptFQmdSpnIHKQHZ76RET/dplBycchNEo2BJSipUdMiLZ7qCxUz0
 NcOi8zSZbC4bJf0jNNWL7Q4Lt6ARorU+IC9HVaSIJQyXjyOprAZWtUs+aFEgMoNIhrCv
 jNpw==
X-Gm-Message-State: AOJu0YwuX3lAbexSVo81BdTC6xgYMRo7gC3aEoLLRge5phhBXe6m5FMD
 ng4Q9mTqKR9wJs/aqcqMYww=
X-Google-Smtp-Source: AGHT+IGgwY5w6AQTHQ1MgBWS25JJJBhWhKSdij/Jvg0xGBl8Vj+fXysVr5sbWXq5EX6J52TSERKREQ==
X-Received: by 2002:a17:906:4749:b0:a23:65de:419c with SMTP id
 j9-20020a170906474900b00a2365de419cmr75233ejs.144.1703180074094; 
 Thu, 21 Dec 2023 09:34:34 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl.
 [31.11.218.106]) by smtp.gmail.com with ESMTPSA id
 z25-20020a1709060ad900b00a23499f1d7dsm1176118ejf.209.2023.12.21.09.34.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 09:34:33 -0800 (PST)
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
Subject: [PATCH V3 2/6] nvmem: core: add nvmem_dev_size() helper
Date: Thu, 21 Dec 2023 18:34:17 +0100
Message-Id: <20231221173421.13737-2-zajec5@gmail.com>
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

This is required by layouts that need to read whole NVMEM content. It's
especially useful for NVMEM devices without hardcoded layout (like
U-Boot environment data block).

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/nvmem/core.c           | 13 +++++++++++++
 include/linux/nvmem-consumer.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 4ed54076346d..980123fb4dde 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -2163,6 +2163,19 @@ const char *nvmem_dev_name(struct nvmem_device *nvmem)
 }
 EXPORT_SYMBOL_GPL(nvmem_dev_name);
 
+/**
+ * nvmem_dev_size() - Get the size of a given nvmem device.
+ *
+ * @nvmem: nvmem device.
+ *
+ * Return: size of the nvmem device.
+ */
+size_t nvmem_dev_size(struct nvmem_device *nvmem)
+{
+	return nvmem->size;
+}
+EXPORT_SYMBOL_GPL(nvmem_dev_size);
+
 static int __init nvmem_init(void)
 {
 	int ret;
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 2d306fa13b1a..34c0e58dfa26 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -81,6 +81,7 @@ int nvmem_device_cell_write(struct nvmem_device *nvmem,
 			    struct nvmem_cell_info *info, void *buf);
 
 const char *nvmem_dev_name(struct nvmem_device *nvmem);
+size_t nvmem_dev_size(struct nvmem_device *nvmem);
 
 void nvmem_add_cell_lookups(struct nvmem_cell_lookup *entries,
 			    size_t nentries);
-- 
2.35.3

