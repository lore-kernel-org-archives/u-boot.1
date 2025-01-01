Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15134E7718F
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:22:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 055D2803CE;
	Wed,  1 Jan 2025 23:22:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VxfS+mjY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3986803CE; Wed,  1 Jan 2025 23:22:25 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35B0F8031D
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:22:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2163b0c09afso143587705ad.0
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735770141; x=1736374941; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bXhfbIW+u9r1+3+AJ5+tkYBoF+OR3F7cfyyP+K9qpPs=;
 b=VxfS+mjY8Dc8GNUuu0hI2SiGbcOCBeQ6NNcnr3MW6wNs48veZWVuG+fzOaHtvn2j8g
 Qn08ojMr/WFKuB7wFsXhASnuLjFv225GBEtuXHct8lMCdJ93P0oxwic+NS/yuEytQrn2
 XAIwxqqxRT5N63G9QQKeMD+uKCw2bfAz8sJQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735770141; x=1736374941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bXhfbIW+u9r1+3+AJ5+tkYBoF+OR3F7cfyyP+K9qpPs=;
 b=UwA80OcqDjIFbA09atjnRzN+XCUcQuK7xzuztE4xmme21DTe9n3U7asjzs40uzGxzK
 0li8mXdyaN9IyrGwPscmboTmfasM4KISfPypqWjy9YYRLXUf2N6cY4CY2pkW1Jm9LP7X
 ci7va9AA9HkhRAnkg9Tfss2nFNVvw6Z2jUSI5c9UdPB/lj0YZqt0Sfy0xjCGOocyisIS
 VgacriZiUnPltJ5sLzdkVXYWA9C41gQP8nZtvV5gqK7qr7tt09t4nIoocTZs2yyTNpjh
 1lqMtp2ySZKuuJxoxkLT3q5Jtvh0dEtJ6YQIZFoI7B0ucjaYs3pjKeZIXOjEaXapgzKH
 qtPA==
X-Gm-Message-State: AOJu0YzwTP0c4nkOR/l6/KiWAmWsJrB/QcEscRwchAO0lsW1fIIEuBBS
 gz7l2IV7MGrswTzsl5GaqYyeZtWnFf/jPJBk1STMrnvE3/T8etiRP2IgvK+v3IR63eXcBi60np8
 =
X-Gm-Gg: ASbGncu/8cEE61lOONa0CUpM7+kNaDGiVHBKnE0MKISwpPo8mVjfdpzq6y0IHuLgnR3
 IPVLcqYA6xyzzmM0hycT2Zk38IIX1I8K8sfeKY+SZ7YO69e921dK39fcP2kHMFwnuAHgTX0CNoD
 ww/K20EdkvNtA5v//+cZwWXi1YJ4MQn6Wxxpe8IDXjSlC0rx+AbIZo4nRmK+u/6NFn+eIkavQD+
 VwqVGVWPQkYXAU8dzH39pAbNENGNXexqMUiJl4LrpqQ6kbpCB0ILSw=
X-Google-Smtp-Source: AGHT+IE2MI5wInp7IM3xK03bIBl7q/f7Dc83feeMk3Eu9K1SxIh1syB1x/JTEnbPR3boILZAG1H25A==
X-Received: by 2002:a05:6a20:6a25:b0:1d9:18af:d150 with SMTP id
 adf61e73a8af0-1e5e05a9e39mr68169239637.21.1735770141172; 
 Wed, 01 Jan 2025 14:22:21 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.22.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:22:20 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 47/67] upl: Move decode_addr_size() higher and rename
Date: Thu,  2 Jan 2025 11:09:33 +1300
Message-ID: <20250101221003.1944600-48-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

Move this function higher in the file so that it can later be used by
decode_upl_params()

Name the functions decode_reg() since it operates on an entire 'reg'
property.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/upl_read.c | 96 ++++++++++++++++++++++++-------------------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/boot/upl_read.c b/boot/upl_read.c
index be3e1d116e1..bf5aa8f785c 100644
--- a/boot/upl_read.c
+++ b/boot/upl_read.c
@@ -172,6 +172,49 @@ static int read_uint(ofnode node, const char *prop, uint *valp)
 	return 0;
 }
 
+/**
+ * decode_reg() - Decide a set of addr/size pairs
+ *
+ * Each base/size value from the devicetree is written to the region list
+ *
+ * @upl: UPL state
+ * @buf: Bytes to decode
+ * @size: Number of bytes to decode
+ * @regions: List of regions to process (struct memregion)
+ * Returns: number of regions found, if OK, else -ve on error
+ */
+static int decode_reg(const struct upl *upl, const char *buf, int size,
+		      struct alist *regions)
+{
+	const char *ptr, *end = buf + size;
+	int i;
+
+	alist_init_struct(regions, struct memregion);
+	ptr = buf;
+	for (i = 0; ptr < end; i++) {
+		struct memregion reg;
+
+		if (upl->addr_cells == 1)
+			reg.base = fdt32_to_cpu(*(u32 *)ptr);
+		else
+			reg.base = fdt64_to_cpu(*(u64 *)ptr);
+		ptr += upl->addr_cells * sizeof(u32);
+
+		if (upl->size_cells == 1)
+			reg.size = fdt32_to_cpu(*(u32 *)ptr);
+		else
+			reg.size = fdt64_to_cpu(*(u64 *)ptr);
+		ptr += upl->size_cells * sizeof(u32);
+		if (ptr > end)
+			return -ENOSPC;
+
+		if (!alist_add(regions, reg))
+			return log_msg_ret("reg", -ENOMEM);
+	}
+
+	return i;
+}
+
 /**
  * decode_root_props() - Decode root properties from the tree
  *
@@ -269,49 +312,6 @@ static int decode_upl_images(struct upl *upl, ofnode options)
 	return 0;
 }
 
-/**
- * decode_addr_size() - Decide a set of addr/size pairs
- *
- * Each base/size value from the devicetree is written to the region list
- *
- * @upl: UPL state
- * @buf: Bytes to decode
- * @size: Number of bytes to decode
- * @regions: List of regions to process (struct memregion)
- * Returns: number of regions found, if OK, else -ve on error
- */
-static int decode_addr_size(const struct upl *upl, const char *buf, int size,
-			    struct alist *regions)
-{
-	const char *ptr, *end = buf + size;
-	int i;
-
-	alist_init_struct(regions, struct memregion);
-	ptr = buf;
-	for (i = 0; ptr < end; i++) {
-		struct memregion reg;
-
-		if (upl->addr_cells == 1)
-			reg.base = fdt32_to_cpu(*(u32 *)ptr);
-		else
-			reg.base = fdt64_to_cpu(*(u64 *)ptr);
-		ptr += upl->addr_cells * sizeof(u32);
-
-		if (upl->size_cells == 1)
-			reg.size = fdt32_to_cpu(*(u32 *)ptr);
-		else
-			reg.size = fdt64_to_cpu(*(u64 *)ptr);
-		ptr += upl->size_cells * sizeof(u32);
-		if (ptr > end)
-			return -ENOSPC;
-
-		if (!alist_add(regions, reg))
-			return log_msg_ret("reg", -ENOMEM);
-	}
-
-	return i;
-}
-
 /**
  * node_matches_at() - Check if a node name matches "base@..."
  *
@@ -345,7 +345,7 @@ static int decode_upl_memory_node(struct upl *upl, ofnode node)
 			    ofnode_get_name(node), UPLP_REG);
 		return log_msg_ret("reg", -EINVAL);
 	}
-	len = decode_addr_size(upl, buf, size, &mem.region);
+	len = decode_reg(upl, buf, size, &mem.region);
 	if (len < 0)
 		return log_msg_ret("buf", len);
 	mem.hotpluggable = ofnode_read_bool(node, UPLP_HOTPLUGGABLE);
@@ -381,7 +381,7 @@ static int decode_upl_memmap(struct upl *upl, ofnode root)
 			continue;
 		}
 
-		len = decode_addr_size(upl, buf, size, &memmap.region);
+		len = decode_reg(upl, buf, size, &memmap.region);
 		if (len < 0)
 			return log_msg_ret("buf", len);
 		ret = ofnode_read_bitmask(node, UPLP_USAGE, usage_names,
@@ -422,7 +422,7 @@ static int decode_upl_memres(struct upl *upl, ofnode root)
 			continue;
 		}
 
-		len = decode_addr_size(upl, buf, size, &memres.region);
+		len = decode_reg(upl, buf, size, &memres.region);
 		if (len < 0)
 			return log_msg_ret("buf", len);
 		memres.no_map = ofnode_read_bool(node, UPLP_NO_MAP);
@@ -467,7 +467,7 @@ static int decode_upl_serial(struct upl *upl, ofnode node)
 		return log_msg_ret("reg", -EINVAL);
 	}
 
-	len = decode_addr_size(upl, buf, sizeof(buf), &ser->reg);
+	len = decode_reg(upl, buf, sizeof(buf), &ser->reg);
 	if (len < 0)
 		return log_msg_ret("buf", len);
 
@@ -520,7 +520,7 @@ static int decode_upl_graphics(struct upl *upl, ofnode node)
 		return log_msg_ret("reg", -EINVAL);
 	}
 
-	len = decode_addr_size(upl, buf, size, &gra->reg);
+	len = decode_reg(upl, buf, size, &gra->reg);
 	if (len < 0)
 		return log_msg_ret("buf", len);
 
-- 
2.43.0

