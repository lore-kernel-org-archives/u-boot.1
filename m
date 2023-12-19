Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61561C46CA2
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 17:40:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F06387603;
	Tue, 19 Dec 2023 18:40:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nno9iwqo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 220058718F; Tue, 19 Dec 2023 18:40:43 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8923875B5
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 18:40:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zajec5@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a236d2cc372so221492366b.3
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 09:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703007640; x=1703612440; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HS/utwklj/mQdHgmYltSxcVR9bMR4HdMDBmcgJXrZDU=;
 b=Nno9iwqoiPB7nLEVHBqw0HS9sIgbAb1iujtSv1VDKzknHNZjauXqNpjNGDmZrK5Hpt
 qj5lEU6pqHeRB8RNxsny8WWi3l/C6cQ0EbrkJOUbj7QRybduOR2RxxcoOaqC3ut+q/+b
 l7Fm3LnGncL+aooDLv6urz/hr6xGKXSbpGhrcLQDqwF992U3fh7NaprTfQmB+Qx/c3gN
 57VuYa7oaetymWsv3hzWv+WGBlox7w2IfOqxN7ePbn0jqL9r/+9yleZfT/BJtc0AHP7u
 XQExsyRlOqt+7mc9lh61+eT2g2JZxkK2o9uhXmGKofywvV1/CTCvpm90itT7xMjlnkIM
 JoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703007640; x=1703612440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HS/utwklj/mQdHgmYltSxcVR9bMR4HdMDBmcgJXrZDU=;
 b=tQg4sS4n4dhnQ//SSwRipBeZVBFUlsNwZpQUVraGGBCEbwUUIvrDWGsw9M9jExTarW
 XhTUiU7+ZnadHrQxODDvVofOEgA1hDAgR+3kN4tml57ZAx1wYKjk19xOqaz6xlPFIWop
 NvMpBW+rxqqLKnVFpV1H5WKB5vv9hXAT6TEmMzT15JQyl+1Sj0LqxWhfn8fsDB0l8eOa
 bNf3fwwhnirUfW6AUiWUaYXetQrCgZzJ0sA97ZY0dpdywe9cKSyypy5h2XU1LVQuMz9M
 3Ssk7NB8OvBpVxyDGYwtou1js8zrAicjdh+55cWuB8BTVcz8jqORySdgP27R1NUspndd
 brsw==
X-Gm-Message-State: AOJu0YzzY4+eZ08kCr5WYOEpXWs4hoJw55NmHf69+c8hMm0nz7CBxsYs
 JlFSGh/6BXIKiXwVYynZeJA=
X-Google-Smtp-Source: AGHT+IE4Iweh6+hO7rOhKCZkig6kqe51ihdxK4L/LdTZ6cXOsGys0uUBqLTu6ozGXqXinvBp5StI5w==
X-Received: by 2002:a17:906:74d0:b0:a26:8c0f:b0ca with SMTP id
 z16-20020a17090674d000b00a268c0fb0camr53272ejl.75.1703007640440; 
 Tue, 19 Dec 2023 09:40:40 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl.
 [31.11.218.106]) by smtp.gmail.com with ESMTPSA id
 tx27-20020a1709078e9b00b00a1c85124b08sm15834840ejc.94.2023.12.19.09.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 09:40:40 -0800 (PST)
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
Subject: [PATCH V2 2/5] nvmem: core: add nvmem_dev_size() helper
Date: Tue, 19 Dec 2023 18:40:22 +0100
Message-Id: <20231219174025.15228-2-zajec5@gmail.com>
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

