Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93FCC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 13:45:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 596D887E1A;
	Mon, 18 Dec 2023 14:45:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PN9x/+GY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1D8587E1C; Mon, 18 Dec 2023 14:45:33 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B023A87D85
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 14:45:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zajec5@gmail.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-336437ae847so2954720f8f.2
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 05:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702907131; x=1703511931; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cWStvqK6KrlPpDCxoD+LXp2BPwdp0DZEpw1OHP4LGGI=;
 b=PN9x/+GY/VrfBYy5+ETud2l2LRZgyeuL7vLQXFzK/WLxvVTLNGqXcWQh7ql4jeorqv
 ehGAkKGg/mjH0bqCmXtwXgNk9sqfJiz15S+nGYFOrpX7+Y/un7M8YHzcE1QhZRn1fN+9
 N5BjhnoM9JUjK72CuvO5JbSAc8o0+HaJHSVSmyt3Xykd/d0gqSOPYfybpl4/u6VabDzi
 ByLgQizh783TgCbwLv+52EFSVrKV8V4Mj5XR7RQhqauIqYbg16aOJb02J60U1H4uN2IK
 cs8wUOjbsMSfszxWZSco7ogWuw+jEPU11ToOjcyB8kVQ6Edkw8dYOOgSLOaivyt835YR
 XUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702907131; x=1703511931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cWStvqK6KrlPpDCxoD+LXp2BPwdp0DZEpw1OHP4LGGI=;
 b=M/I4DR8Y7y3sIgMFOelUwJXxSAMOAhVuoXZHalQtLnxJ99R4w1CrDlcEaByxiC2aat
 wxn5vSOM7CJ/WCNzr3v123fOMD/6ae7YjVHuagmYsQ8Ae9iueyVVGy9qyd8lxU0boc8p
 fKfLZ8BVHcUF1qQcwtP+BGPWA/KU7xk+UUktPNAWFbyaqFacX+TbRdTfP86Ufr3PGMyV
 guqqo1CrlDlVtkgcxSfHDQIDfL0WzQ0y6PN3i5HtCWDM/Y+cIBpGEifz1zlO9nSrG1I1
 OidF0O5rxpYqxhzLtaG/ESfX/ZSC4cS8RzcB5DW/lwNX7FEa0TLa5WFZjKRi1iGvGByq
 DIqg==
X-Gm-Message-State: AOJu0Yzxo+VK50HdLS3hfMI6wTpAA5lfPJGvK4xW5Lxxruc0aQzGHsSf
 nlOwVNugbXC6yGo3QS8yXuVRLJ+GkzY=
X-Google-Smtp-Source: AGHT+IHp95pnHBpGST+4vtRvNyTH5biaemOYZgB8XiiCBPCxXrTDcGLJjvu3bDnbMTy8rJsQqRJ+XQ==
X-Received: by 2002:a05:6512:39cb:b0:50b:f03c:1ea2 with SMTP id
 k11-20020a05651239cb00b0050bf03c1ea2mr10860168lfu.84.1702906664468; 
 Mon, 18 Dec 2023 05:37:44 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl.
 [31.11.218.106]) by smtp.gmail.com with ESMTPSA id
 f20-20020a1709067f9400b00a234907311asm1891537ejr.55.2023.12.18.05.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 05:37:44 -0800 (PST)
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
Subject: [PATCH 3/4] nvmem: u-boot-env: use more nvmem subsystem helpers
Date: Mon, 18 Dec 2023 14:37:21 +0100
Message-Id: <20231218133722.16150-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231218133722.16150-1-zajec5@gmail.com>
References: <20231218133722.16150-1-zajec5@gmail.com>
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

1. Use nvmem_dev_size() and nvmem_device_read() to make this driver less
   mtd dependent
2. Use nvmem_add_one_cell() to simplify adding NVMEM cells

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/nvmem/u-boot-env.c | 79 +++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 44 deletions(-)

diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index c4ae94af4af7..ab8c9bf63d99 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -23,13 +23,10 @@ enum u_boot_env_format {
 
 struct u_boot_env {
 	struct device *dev;
+	struct nvmem_device *nvmem;
 	enum u_boot_env_format format;
 
 	struct mtd_info *mtd;
-
-	/* Cells */
-	struct nvmem_cell_info *cells;
-	int ncells;
 };
 
 struct u_boot_env_image_single {
@@ -94,72 +91,69 @@ static int u_boot_env_read_post_process_ethaddr(void *context, const char *id, i
 static int u_boot_env_add_cells(struct u_boot_env *priv, uint8_t *buf,
 				size_t data_offset, size_t data_len)
 {
+	struct nvmem_device *nvmem = priv->nvmem;
 	struct device *dev = priv->dev;
 	char *data = buf + data_offset;
 	char *var, *value, *eq;
-	int idx;
-
-	priv->ncells = 0;
-	for (var = data; var < data + data_len && *var; var += strlen(var) + 1)
-		priv->ncells++;
 
-	priv->cells = devm_kcalloc(dev, priv->ncells, sizeof(*priv->cells), GFP_KERNEL);
-	if (!priv->cells)
-		return -ENOMEM;
-
-	for (var = data, idx = 0;
+	for (var = data;
 	     var < data + data_len && *var;
-	     var = value + strlen(value) + 1, idx++) {
+	     var = value + strlen(value) + 1) {
+		struct nvmem_cell_info info = {};
+
 		eq = strchr(var, '=');
 		if (!eq)
 			break;
 		*eq = '\0';
 		value = eq + 1;
 
-		priv->cells[idx].name = devm_kstrdup(dev, var, GFP_KERNEL);
-		if (!priv->cells[idx].name)
+		info.name = devm_kstrdup(dev, var, GFP_KERNEL);
+		if (!info.name)
 			return -ENOMEM;
-		priv->cells[idx].offset = data_offset + value - data;
-		priv->cells[idx].bytes = strlen(value);
-		priv->cells[idx].np = of_get_child_by_name(dev->of_node, priv->cells[idx].name);
+		info.offset = data_offset + value - data;
+		info.bytes = strlen(value);
+		info.np = of_get_child_by_name(dev->of_node, info.name);
 		if (!strcmp(var, "ethaddr")) {
-			priv->cells[idx].raw_len = strlen(value);
-			priv->cells[idx].bytes = ETH_ALEN;
-			priv->cells[idx].read_post_process = u_boot_env_read_post_process_ethaddr;
+			info.raw_len = strlen(value);
+			info.bytes = ETH_ALEN;
+			info.read_post_process = u_boot_env_read_post_process_ethaddr;
 		}
-	}
 
-	if (WARN_ON(idx != priv->ncells))
-		priv->ncells = idx;
+		nvmem_add_one_cell(nvmem, &info);
+	}
 
 	return 0;
 }
 
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
-		goto err_kfree;
-	}
+	bytes = nvmem_device_read(nvmem, 0, dev_size, buf);
+	if (bytes < 0)
+		return bytes;
+	else if (bytes != dev_size)
+		return -EIO;
 
 	switch (priv->format) {
 	case U_BOOT_FORMAT_SINGLE:
@@ -179,8 +173,8 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 		break;
 	}
 	crc32 = le32_to_cpu(*(__le32 *)(buf + crc32_offset));
-	crc32_data_len = priv->mtd->size - crc32_data_offset;
-	data_len = priv->mtd->size - data_offset;
+	crc32_data_len = dev_size - crc32_data_offset;
+	data_len = dev_size - data_offset;
 
 	calc = crc32(~0, buf + crc32_data_offset, crc32_data_len) ^ ~0L;
 	if (calc != crc32) {
@@ -189,7 +183,7 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 		goto err_kfree;
 	}
 
-	buf[priv->mtd->size - 1] = '\0';
+	buf[dev_size - 1] = '\0';
 	err = u_boot_env_add_cells(priv, buf, data_offset, data_len);
 	if (err)
 		dev_err(dev, "Failed to add cells: %d\n", err);
@@ -209,7 +203,6 @@ static int u_boot_env_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct u_boot_env *priv;
-	int err;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -224,17 +217,15 @@ static int u_boot_env_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->mtd);
 	}
 
-	err = u_boot_env_parse(priv);
-	if (err)
-		return err;
-
 	config.dev = dev;
-	config.cells = priv->cells;
-	config.ncells = priv->ncells;
 	config.priv = priv;
 	config.size = priv->mtd->size;
 
-	return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &config));
+	priv->nvmem = devm_nvmem_register(dev, &config);
+	if (IS_ERR(priv->nvmem))
+		return PTR_ERR(priv->nvmem);
+
+	return u_boot_env_parse(priv);
 }
 
 static const struct of_device_id u_boot_env_of_match_table[] = {
-- 
2.35.3

