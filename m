Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B42C48260
	for <u-boot@archiver.kernel.org>; Fri, 16 Feb 2024 18:39:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C400487C68;
	Fri, 16 Feb 2024 19:38:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="a2rambEZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B3FB87DE6; Fri, 16 Feb 2024 19:38:52 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7946587B89
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 19:38:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33d211c27abso416993f8f.3
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 10:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708108725; x=1708713525; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JoRTLsTmjlI7hIXMoXjUShSiLcP4vRvqo7cHnkT5tSM=;
 b=a2rambEZ9j0C+e1vR6LrmFDFS9E1wdgen4siZr3rMJoCvCEQCNJ7oyczpHEscANUsF
 5BJrnqh3VOLit7IGtl5lo435Re0qCm94yX880HBjKasB+Y5sXS73e9rtYQZO2fownut2
 ThVw0XTgHURnhZcwsS7C1JmMXwa00fsG6kktdHhQCAxVEugNr+lbEyKWD7TXnkQ/pv+y
 CxiTY0MVhvW7u2aUVN+iNvVH4jnleyHIS6843Zp4TSWq8CypaZOBk8FPGmQrDOF1DddX
 F3pZRLqUuQhI5zM/jJhAJL3fWsUwb90yNrLhJTkxg/iC30lfRWWMkVwR2zI25saOipY6
 3gWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708108725; x=1708713525;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JoRTLsTmjlI7hIXMoXjUShSiLcP4vRvqo7cHnkT5tSM=;
 b=kYquXSHURdG3vCqS7WwEN0ZP7Zvl1T9aa4AkP147IP/sDIQ1B46xthl5+4MESAAHJe
 /c3G3+HkT+m8t8S9SEAvF3JGrMqIatuuNL0pC8iNoC2UzKu7HNYPV5xaiLuIaW0hsREk
 Ifr5MG033JQTiWCHFUgy6IAgT9ErbC+GVBrYApdIxGOWK9ZRNZby35cQUV44P8oAPG2r
 9xLyUu+8usEhmRHas9UWjMDApVIAkBPw+hqwlAoK8ArqYT/sUjGCMfol4OIFLGm+Q0IS
 DWjUYTH1btuTVGcMeASbEenUn8Qqq+ELtBK9qbl40/jrG6e5lmaThFS+oov6i9TSZZV+
 4CHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfRJRLTveRCYQ1AIib/rOavUsHitLDjcpJfUoeqvYoeV1OLqO+kWS7Tca0iGGgZgV10FVgaOVy5QQLccqdemjMFZ5fSw==
X-Gm-Message-State: AOJu0YzMk2z2PmPlnzZrmMwksW4Yre5TujQDpr340ZQuuxTfOi08tK2j
 LW6tcEs7s8//jMzLk/+kKiu4K/pXb5FvJUTyZBQzotA4A/4qmh23qS5uMiMbdL8=
X-Google-Smtp-Source: AGHT+IHBchc5ra4fyXtcMiQoweG2xnO3OwfnZ565fG5nJLSOeYdzEF1xaviVCfhQnM1+00P0AqLsdg==
X-Received: by 2002:adf:f892:0:b0:33c:fb94:1e12 with SMTP id
 u18-20020adff892000000b0033cfb941e12mr4317644wrp.54.1708108725311; 
 Fri, 16 Feb 2024 10:38:45 -0800 (PST)
Received: from lion.caleb.rex.connolly.tech (host-92-17-96-232.as13285.net.
 [92.17.96.232]) by smtp.gmail.com with ESMTPSA id
 w12-20020a05600c474c00b00411ec07674esm3117755wmo.31.2024.02.16.10.38.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 10:38:44 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Anatolij Gustschin <agust@denx.de>,
	Tom Rini <trini@konsulko.com>
Cc: Rob Clark <robdclark@gmail.com>, u-boot@lists.denx.de,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH] video: simplefb: modernise DT parsing
Date: Fri, 16 Feb 2024 18:38:06 +0000
Message-ID: <20240216183840.879482-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.43.1
MIME-Version: 1.0
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

simplefb was using old style FDT parsing which doesn't behave well in
combination with livetree. Update it to use ofnode instead and add a
missing null check for the "format" property.

Standardise the error logging while we're here.

Fixes: 971d7e64245d ("video: simplefb")
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/video/simplefb.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/video/simplefb.c b/drivers/video/simplefb.c
index 235ec761f70b..3d83bf8f2e88 100644
--- a/drivers/video/simplefb.c
+++ b/drivers/video/simplefb.c
@@ -15,14 +15,14 @@ static int simple_video_probe(struct udevice *dev)
 {
 	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
 	struct video_priv *uc_priv = dev_get_uclass_priv(dev);
-	const void *blob = gd->fdt_blob;
-	const int node = dev_of_offset(dev);
+	ofnode node = dev_ofnode(dev);
 	const char *format;
+	int ret;
 	fdt_addr_t base;
 	fdt_size_t size;
+	u32 width, height, rot;
 
-	base = fdtdec_get_addr_size_auto_parent(blob, dev_of_offset(dev->parent),
-			node, "reg", 0, &size, false);
+	base = dev_read_addr_size(dev, &size);
 	if (base == FDT_ADDR_T_NONE) {
 		debug("%s: Failed to decode memory region\n", __func__);
 		return -EINVAL;
@@ -41,17 +41,25 @@ static int simple_video_probe(struct udevice *dev)
 
 	debug("%s: Query resolution...\n", __func__);
 
-	uc_priv->xsize = fdtdec_get_uint(blob, node, "width", 0);
-	uc_priv->ysize = fdtdec_get_uint(blob, node, "height", 0);
-	uc_priv->rot = fdtdec_get_uint(blob, node, "rot", 0);
-	if (uc_priv->rot > 3) {
-		log_debug("%s: invalid rot\n", __func__);
-		return log_msg_ret("rot", -EINVAL);
+	ret = ofnode_read_u32(node, "width", &width);
+	ret = ret ?: ofnode_read_u32(node, "height", &height);
+	if (ret || !width || !height) {
+		log_err("%s: invalid width or height: %d\n", __func__, ret);
+		return ret;
 	}
+	ofnode_read_u32(node, "rot", &rot);
+	uc_priv->rot = rot;
+	uc_priv->xsize = width;
+	uc_priv->ysize = height;
 
-	format = fdt_getprop(blob, node, "format", NULL);
+	format = ofnode_read_string(node, "format");
 	debug("%s: %dx%d@%s\n", __func__, uc_priv->xsize, uc_priv->ysize, format);
 
+	if (!format) {
+		log_err("%s: please add required property \"format\"\n", __func__);
+		return -EINVAL;
+	}
+
 	if (strcmp(format, "r5g6b5") == 0) {
 		uc_priv->bpix = VIDEO_BPP16;
 	} else if (strcmp(format, "a8b8g8r8") == 0 ||
@@ -67,7 +75,7 @@ static int simple_video_probe(struct udevice *dev)
 		uc_priv->bpix = VIDEO_BPP32;
 		uc_priv->format = VIDEO_X2R10G10B10;
 	} else {
-		printf("%s: invalid format: %s\n", __func__, format);
+		log_err("%s: invalid format: %s\n", __func__, format);
 		return -EINVAL;
 	}
 
-- 
2.43.1

