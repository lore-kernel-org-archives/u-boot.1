Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57664E7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:22:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAA148058A;
	Wed,  1 Jan 2025 23:22:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cB08HFBa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BEC68031D; Wed,  1 Jan 2025 23:22:20 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C49528031D
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:22:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-216728b1836so129113515ad.0
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735770135; x=1736374935; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RFmprkeoYRhTRu86bR++TeFdg8QZ5le7g/vg+QfmsEw=;
 b=cB08HFBaN/TdCXXxndfrwJsVqlwgPvUDG01+JR5tSmsAjWigxvWfTlPy0dyrS7IAjt
 +tIHjI31be2qMgz2vqekYV/y0oV/9d5XO9UM76PIyltH2j/FrXy4zOp0MnVs2q/UKIwl
 0T8L6+6pDb/Z99pO0n2Ng7k6XEUsLWx8MyE6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735770135; x=1736374935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RFmprkeoYRhTRu86bR++TeFdg8QZ5le7g/vg+QfmsEw=;
 b=aVoK82Vmy87dxXJbzqtVkwgrPEhnBScbZJhJZg3CBIHXFdm+VERsIUgOvUk0eUaiL5
 rfT2Ka1y9wr39xvz/5fbvw0Oma1UAQY7DfiPxGFgIkwxE83JvKTjJZX7r28PWswpkehv
 jciu4wsZiOynj1BuGTilGMgH6D8xKKHqLyZYJIXtcerpvLXfIQ4v/A22Cp5N88Q0xM/9
 ufBbs7EMCpeFX2gyHkIJtVksial61fXYIUD6stOCdNvuQ2EqrEI88ZuS8EHO/fT1m6mQ
 ziARAz9y9tPK8VRuWOPouPF+lnlusWBwGkCbS8HZUdqjo7vXpy6f+46A9JEhgwCiz19s
 hAhg==
X-Gm-Message-State: AOJu0YzrAjIXMkXOhmb9YsQVbK3eFSsqG9MGpPUHUJFR6FqR6CwUbDlP
 p1El2cTotgYDMqsh+89mV7iJAesvsaLonSkvamSm2zkClA9EjgayPGUppRTxccDGEg3SYF9aNFI
 =
X-Gm-Gg: ASbGncsx+HLL+PsEpPNY0T8FLUa1njHURovJ1KTUPk3AC7AmXUr8j6qE44IQxpf00yX
 59n6NFdJF9DAPj2gL6mF6M9Y7qMed55w8dkANoV4EiSCJ0KvuKmaraZ8LqDSnK2XUmRJFLBA1zD
 KYQWhvrjqNZS8q/uJHOr9DYzngVvTsGAgZiZ1xTQsHIYsdI3pSwJW2t604kTdSrNizRR+IIhmbb
 Pwkin7CsaIbtcx0SVvyoO+bpvJf8u9EibVb7xC7GoJHxZLoWejMwfw=
X-Google-Smtp-Source: AGHT+IG/opNnXPVTJynx9eeCeUwU5YwziE1ydOvSKb+3lAjpreNzS8nqe0AurII9++FHTLJC0pDhnw==
X-Received: by 2002:a05:6a00:414a:b0:728:e745:23d8 with SMTP id
 d2e1a72fcca58-72abdeb53f3mr68097273b3a.24.1735770134831; 
 Wed, 01 Jan 2025 14:22:14 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:22:14 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 45/67] upl: Move buffer_addr_size() higher and rename
Date: Thu,  2 Jan 2025 11:09:31 +1300
Message-ID: <20250101221003.1944600-46-sjg@chromium.org>
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
add_upl_params()

Name the functions encode_reg() to better fit with the naming of the
equivalent upl_read functions.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/upl_write.c | 90 ++++++++++++++++++++++++------------------------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/boot/upl_write.c b/boot/upl_write.c
index c29848a9ce3..eed84832a42 100644
--- a/boot/upl_write.c
+++ b/boot/upl_write.c
@@ -143,6 +143,48 @@ static int ofnode_write_value(ofnode node, const char *prop,
 	return 0;
 }
 
+/**
+ * encode_reg() - Generate a set of addr/size pairs
+ *
+ * Each base/size value from each region is written to the buffer in a suitable
+ * format to be written to the devicetree
+ *
+ * @upl: UPL state
+ * @buf: Buffer to write to
+ * @size: Buffer size
+ * @num_regions: Number of regions to process
+ * @region: List of regions to process (struct memregion)
+ * Returns: Number of bytes written, or -ENOSPC if the buffer is too small
+ */
+static int encode_reg(const struct upl *upl, char *buf, int size,
+		      uint num_regions, const struct alist *region)
+{
+	char *ptr, *end = buf + size;
+	int i;
+
+	ptr = buf;
+	for (i = 0; i < num_regions; i++) {
+		const struct memregion *reg = alist_get(region, i,
+							struct memregion);
+
+		if (upl->addr_cells == 1)
+			*(u32 *)ptr = cpu_to_fdt32(reg->base);
+		else
+			*(u64 *)ptr = cpu_to_fdt64(reg->base);
+		ptr += upl->addr_cells * sizeof(u32);
+
+		if (upl->size_cells == 1)
+			*(u32 *)ptr = cpu_to_fdt32(reg->size);
+		else
+			*(u64 *)ptr = cpu_to_fdt64(reg->size);
+		ptr += upl->size_cells * sizeof(u32);
+		if (ptr > end)
+			return log_msg_ret("uer", -ENOSPC);
+	}
+
+	return ptr - buf;
+}
+
 /**
  * add_addr_size_cells() - Add #address/#size-cells properties to the tree
  *
@@ -247,48 +289,6 @@ static int add_upl_image(const struct upl *upl, ofnode options)
 	return 0;
 }
 
-/**
- * buffer_addr_size() - Generate a set of addr/size pairs
- *
- * Each base/size value from each region is written to the buffer in a suitable
- * format to be written to the devicetree
- *
- * @upl: UPL state
- * @buf: Buffer to write to
- * @size: Buffer size
- * @num_regions: Number of regions to process
- * @region: List of regions to process (struct memregion)
- * Returns: Number of bytes written, or -ENOSPC if the buffer is too small
- */
-static int buffer_addr_size(const struct upl *upl, char *buf, int size,
-			    uint num_regions, const struct alist *region)
-{
-	char *ptr, *end = buf + size;
-	int i;
-
-	ptr = buf;
-	for (i = 0; i < num_regions; i++) {
-		const struct memregion *reg = alist_get(region, i,
-							struct memregion);
-
-		if (upl->addr_cells == 1)
-			*(u32 *)ptr = cpu_to_fdt32(reg->base);
-		else
-			*(u64 *)ptr = cpu_to_fdt64(reg->base);
-		ptr += upl->addr_cells * sizeof(u32);
-
-		if (upl->size_cells == 1)
-			*(u32 *)ptr = cpu_to_fdt32(reg->size);
-		else
-			*(u64 *)ptr = cpu_to_fdt64(reg->size);
-		ptr += upl->size_cells * sizeof(u32);
-		if (ptr > end)
-			return -ENOSPC;
-	}
-
-	return ptr - buf;
-}
-
 /**
  * write_mem_node() - Write a memory node and reg property
  *
@@ -322,7 +322,7 @@ static int write_mem_node(const struct upl *upl, ofnode parent,
 	if (ret)
 		return log_msg_ret("wmn", ret);
 
-	len = buffer_addr_size(upl, buf, sizeof(buf), mem->count, mem);
+	len = encode_reg(upl, buf, sizeof(buf), mem->count, mem);
 	ret = ofnode_write_prop(node, UPLP_REG, buf, len, true);
 	if (ret)
 		return log_msg_ret("wm1", ret);
@@ -483,7 +483,7 @@ static int add_upl_serial(const struct upl *upl, ofnode root,
 		char buf[16];
 		int len;
 
-		len = buffer_addr_size(upl, buf, sizeof(buf), 1, &ser->reg);
+		len = encode_reg(upl, buf, sizeof(buf), 1, &ser->reg);
 		if (len < 0)
 			return log_msg_ret("buf", len);
 
@@ -538,7 +538,7 @@ static int add_upl_graphics(const struct upl *upl, ofnode root)
 		char buf[16];
 		int len;
 
-		len = buffer_addr_size(upl, buf, sizeof(buf), 1, &gra->reg);
+		len = encode_reg(upl, buf, sizeof(buf), 1, &gra->reg);
 		if (len < 0)
 			return log_msg_ret("buf", len);
 
-- 
2.43.0

