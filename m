Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3EDC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 13:37:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30DF987DF8;
	Mon, 18 Dec 2023 14:37:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DxrP/VLf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 669B087E04; Mon, 18 Dec 2023 14:37:45 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8184E87DF8
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 14:37:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zajec5@gmail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a2331e7058aso200665666b.2
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 05:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702906663; x=1703511463; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lNpHTEQT4LZHegIzvZ+kMOyv6eP7HeX0Sd04kR5jmCY=;
 b=DxrP/VLf4aPCBZJ5/vGr/Rl8eaVLGvvIFIsIxcvuPEpHQX06QjXrQst1m/nONIYzOv
 5BGCa0ewZQdAXvNEniS8zs11Iaby3TXf2Wg0k4CjTPmdvgpoDmTprWAVxxs9ncv8KChQ
 yEZKXIE1Qm516hpcnAY2Ul2MtsxRnc/or1QTq3eTicTaj4Ku0HIfnMOG2J+qKVT2Q7dP
 CKrNHUjR5zB696/hS1Posjj+wy/BU3NJ8r1Q4Eg31X+NqHosA0WHCP5MyzB7MwUzmcwT
 k7QupVihdb/hWhy3HjRrkYdxAVhRQCL7vNZDa90jiubP2kPLHktBh3iMgcdzVFK3HN/l
 Emdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702906663; x=1703511463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lNpHTEQT4LZHegIzvZ+kMOyv6eP7HeX0Sd04kR5jmCY=;
 b=u+6H9g8SUNy3iPPOgbyu0bsjj4PBW/LuwOjgSNjdMqkLWlJ3U1FmVNZfnuT9+fCh8H
 UAwDRnoFxaKpoIUnJH2OMfD5FQNYGMkVx8ntQCEAIzB/NqVRl/mSFUT6ecOPiyOkBApK
 izMKAda6HiUe9UdPgcjsYnfWe6TYKglplDBqKXHJ+sZWFR/8bDS6G3VyZ4tF3N8Yh3IJ
 7BFS+JooJ5YYYyZx/kroMqsLAedv3kmjWjjNsQsYqFxD/bRgej+Ge4oAIWOH0op/uWrA
 mbwpFMJSEtNDTnPM4NGZqrX8MLgwvJVK9sqS659ZmPun6DoXczDyxyohe+NCKhsfhhxu
 HGfA==
X-Gm-Message-State: AOJu0YxAesXq7x+OzxE7VvO2bCIZFT2xIZJ4+aVBbOwiPb7rLJDfFuJI
 HUyelstlJMe0JqJObEmVQD4=
X-Google-Smtp-Source: AGHT+IGtGbsdUUc3O88BnV6j6UsM+dxyCX5fJtxHEDFGyKvcLjEb50ze3OtdtgF9HqxDX13eg9axjw==
X-Received: by 2002:a17:906:3f46:b0:a19:a1ba:bad8 with SMTP id
 f6-20020a1709063f4600b00a19a1babad8mr3339416ejj.126.1702906662688; 
 Mon, 18 Dec 2023 05:37:42 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl.
 [31.11.218.106]) by smtp.gmail.com with ESMTPSA id
 f20-20020a1709067f9400b00a234907311asm1891537ejr.55.2023.12.18.05.37.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 05:37:42 -0800 (PST)
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
Subject: [PATCH 2/4] nvmem: core: add nvmem_dev_size() helper
Date: Mon, 18 Dec 2023 14:37:20 +0100
Message-Id: <20231218133722.16150-2-zajec5@gmail.com>
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

This is required by layouts that need to read whole NVMEM content. It's
especially useful for NVMEM devices without hardcoded layout (like
U-Boot environment data block).

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/nvmem/core.c           | 13 +++++++++++++
 include/linux/nvmem-consumer.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index ba559e81f77f..1b08bb072f86 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -2176,6 +2176,19 @@ const char *nvmem_dev_name(struct nvmem_device *nvmem)
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

