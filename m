Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 495FFE7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:22:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A7BB8042A;
	Wed,  1 Jan 2025 23:22:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cXy70GG0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BB7B803DF; Wed,  1 Jan 2025 23:22:22 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16BC9804CE
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:22:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2161eb95317so151172675ad.1
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735770138; x=1736374938; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sh5yrwLnD7LIbLpKoae0YOr8QxSfo6SW0PQbfqh83l8=;
 b=cXy70GG0OZxlHzAhmVNkLMA+801T3PrQvlzaPZ+SCLSCGfJdgbhD6r/vEUV8JHRUno
 q0diacmHyme8vqjmXa6sELuoLbBH7kLOjeROE8ed/8qHvKTwesqfLEiN00W57qHGSB4u
 wBsI20b/9R3OuTJXM674Bk9r+YyXIwOurGZ88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735770138; x=1736374938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sh5yrwLnD7LIbLpKoae0YOr8QxSfo6SW0PQbfqh83l8=;
 b=G8F4kIFC58Weancrh2LyJ03MlEJiKfRRhz8YvAv4gWf00LpUwrN6OBRqpfa1qfxBkY
 mFk9lFj1Us9vo/RSrEF4ocJicfN4qRxfRovvogGUt1r0M2xblSM+iDwDkrBMVQeIPVzc
 KxXwstc21NOpUA9Fsop+BuFb5j0vcgEyZozOdSKiTxjgOj44CX6wCJ4zy6YYRd/Nq3D+
 ON9R1u9qRFAqFUxRde5LNczj4YI+Px7nKN86WuQ3FMZlHayPGfE12fNOK6hArahfNhKE
 xl3TLfl+WG4X7TsuuTIivOlpPKcrOSaiTRFz2iNOr+DazFpdUHVkUkebQGeblKohk+SE
 Srtw==
X-Gm-Message-State: AOJu0YxHomnCUpYxAPJR5ZU+nOknjfFPhLADEkFLPrU0YTUMjzPnA1Ca
 C75qNtPY5a89ca62e730jq1EnMfPtjr/mYfgG0uZxotJAQwK/VKeLvc1pHK2WhOJuGXRhCoV+Ag
 =
X-Gm-Gg: ASbGncueYZvkkvfjpg34Mz79bn6bxlK3F9vrMCfaPU/0/atjpeLxDbF1Myg6foOSmBp
 2Yom54dEWSzZMaxDk00xx++v3B7OolOcgs1itE5r/G4/XmMNgFlMZEiSwYrV/PlXFZrfcEci7tA
 Xk192chvSklXx40bo01FmQTl3f22mv1RzYHH7oqNLfvhJha4TwDEvDc537u/U/hRD7DtLN+lZoq
 QH8GNYLJCZZrbXmzJ0PYtmblT0/yE2J2wtofz4TFcZLmuOWvoNhQEc=
X-Google-Smtp-Source: AGHT+IFzP9riKCAhlhODmMcCHDASNBrQEJzsTewKjaTHjmpQzEzWRIuGdtDdMyv3vVoo853XXaLw9A==
X-Received: by 2002:a05:6a20:9151:b0:1e0:f472:e496 with SMTP id
 adf61e73a8af0-1e5e044b40bmr63043907637.4.1735770137946; 
 Wed, 01 Jan 2025 14:22:17 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.22.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:22:17 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 46/67] upl: Factor out part of encode_reg() to new function
Date: Thu,  2 Jan 2025 11:09:32 +1300
Message-ID: <20250101221003.1944600-47-sjg@chromium.org>
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

This function performs the same operation on each list element. Move
this processing into a separate function so that it can be called
without an alist

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/upl_write.c | 54 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 13 deletions(-)

diff --git a/boot/upl_write.c b/boot/upl_write.c
index eed84832a42..a1ecb809cbc 100644
--- a/boot/upl_write.c
+++ b/boot/upl_write.c
@@ -143,6 +143,42 @@ static int ofnode_write_value(ofnode node, const char *prop,
 	return 0;
 }
 
+/**
+ * encode_addr_size() - Write an address/size pair
+ *
+ * Writes an address and size into a buffer suitable for placing in a devicetree
+ * 'reg' property. This uses upl->addr/size_cells to determine the number of
+ * cells for each value
+ *
+ * @upl: UPL state
+ * @buf: Buffer to write to
+ * @size: Buffer size in bytes
+ * @reg: Region to process
+ * Returns: Number of bytes written, or -ENOSPC if the buffer is too small
+ */
+static int encode_addr_size(const struct upl *upl, char *buf, uint size,
+			    const struct memregion *reg)
+{
+	char *ptr = buf;
+
+	if (sizeof(fdt32_t) * (upl->addr_cells + upl->size_cells) > size)
+		return log_msg_ret("eas", -ENOSPC);
+
+	if (upl->addr_cells == 1)
+		*(u32 *)ptr = cpu_to_fdt32(reg->base);
+	else
+		*(u64 *)ptr = cpu_to_fdt64(reg->base);
+	ptr += upl->addr_cells * sizeof(u32);
+
+	if (upl->size_cells == 1)
+		*(u32 *)ptr = cpu_to_fdt32(reg->size);
+	else
+		*(u64 *)ptr = cpu_to_fdt64(reg->size);
+	ptr += upl->size_cells * sizeof(u32);
+
+	return ptr - buf;
+}
+
 /**
  * encode_reg() - Generate a set of addr/size pairs
  *
@@ -166,20 +202,12 @@ static int encode_reg(const struct upl *upl, char *buf, int size,
 	for (i = 0; i < num_regions; i++) {
 		const struct memregion *reg = alist_get(region, i,
 							struct memregion);
+		int ret;
 
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
-			return log_msg_ret("uer", -ENOSPC);
+		ret = encode_addr_size(upl, ptr, end - ptr, reg);
+		if (ret < 0)
+			return log_msg_ret("uer", ret);
+		ptr += ret;
 	}
 
 	return ptr - buf;
-- 
2.43.0

