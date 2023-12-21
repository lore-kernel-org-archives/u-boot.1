Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C465C46CCD
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 17:35:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 772AF878D0;
	Thu, 21 Dec 2023 18:34:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mRLwnXIh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56BF7878CC; Thu, 21 Dec 2023 18:34:42 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6710587858
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 18:34:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zajec5@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a22f59c6aeaso123262566b.2
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 09:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703180080; x=1703784880; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1XhPv1RG5GYBxA6YK5orD14R9QXHs06Ax0C4Bquly6M=;
 b=mRLwnXIhT2mik+JTDxWSanXZ+cqtFYU7wY1iJCnVlC+11XI+nmb+L5lmq6htZncB6b
 0RUsnqO1aIt+ekuulpDqysDQ8X4Zp0v+SHnIm/EYJ2sQWzM+LNdsuLeVEUByvtNMIRiS
 fGFC2zJd3dxRocvauIq5lICNitg313M+3DPlHV9RCzd4a9bqA5sfL6MQcxkSM9GhoZ1F
 BVjHQS08lJrw42dZP/W4E84vLLgxnr7MDsUF58VY5mJ92BWl5P0CYKU6YAyF0T0+udpR
 dAnVVb1H8oq64B40RDaBOBLwNKScuhijZ2wdqjeXHmC0YhjmbdH+8pEJOgl9M8pNaEJj
 WQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703180080; x=1703784880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1XhPv1RG5GYBxA6YK5orD14R9QXHs06Ax0C4Bquly6M=;
 b=NJyI9n+nLoPaN3boQ3eIXyDFuTvx6dXqtIofkNjfoeKDXDT8W0YzHoDMK4zIZl4SZ0
 s1gcrWhsLDSxDPTG8vqtW3uTnjw30Q+zPMDkHApOTKNSFfuca96/cRYsr9Mr7etnR2Oq
 wTobZcMl+gGbVScFCCgMf6olrk8m3pNk5XtQlsuUNPldC7m14YEyQlqarCkdLmmZXPFh
 OTZZJtqg4HPLFV5N0qzGJ/oazRzIgXuJd0hK5x+2usWJzTOkJ1yFnMh0teOWXCZdlVuF
 mzPVSkmjaqXeeE4VnEVSfjXjWHmumOaNjkt8AZUBxutJv5wor1qrc+e4+iHp+wB6TpcB
 M67w==
X-Gm-Message-State: AOJu0YzjkCTkPjsi+fZ0grIKYXVcDzevsSjOgnY2sSXuWQ9DMBeS4xDb
 QF5GuyrzbzWSABWo3iwYva4=
X-Google-Smtp-Source: AGHT+IEY+7wyVZIZ+h3uGtQYr+kF581gR4pDcml555wj8gHDXaLod5c5pIXzSSoJp59GcB1hlVt2Ww==
X-Received: by 2002:a17:906:3c18:b0:a22:e2ea:4fad with SMTP id
 h24-20020a1709063c1800b00a22e2ea4fadmr83814ejg.83.1703180079840; 
 Thu, 21 Dec 2023 09:34:39 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl.
 [31.11.218.106]) by smtp.gmail.com with ESMTPSA id
 z25-20020a1709060ad900b00a23499f1d7dsm1176118ejf.209.2023.12.21.09.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 09:34:39 -0800 (PST)
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
Subject: [PATCH V3 5/6] nvmem: u-boot-env: improve coding style
Date: Thu, 21 Dec 2023 18:34:20 +0100
Message-Id: <20231221173421.13737-5-zajec5@gmail.com>
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

1. Prefer kzalloc() over kcalloc()
   See memory-allocation.rst which says: "to be on the safe side it's
   best to use routines that set memory to zero, like kzalloc()"
2. Drop dev_err() for u_boot_env_add_cells() fail
   It can fail only on -ENOMEM. We don't want to print error then.
3. Add extra "crc32_addr" variable
   It makes code reading header's crc32 easier to understand / review.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
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

