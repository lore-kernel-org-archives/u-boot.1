Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63966E7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:22:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64118804FA;
	Wed,  1 Jan 2025 23:22:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b3/8gOKw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26483803B7; Wed,  1 Jan 2025 23:22:29 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE3B08031D
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:22:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2163dc5155fso143763905ad.0
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735770144; x=1736374944; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5VcGS7HthbOqr3TNGHx6NwwH6CTCuYpdpzn14ImFH28=;
 b=b3/8gOKw28l2OC4uEBxE4ErUTP0TwLT6sJTdZ4VwbA7NtWQoR4ZcGcGDeaAKRbjAfc
 PGy5pVOyQV7zUIZdY36XG5RF2PSbowuhTx2+KSPkGCWwlB9hst0CF4EyZYZpLL1EOtaW
 kcH3YGW+3zIel4bweruqvWGj8I5czmT2HNBQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735770144; x=1736374944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5VcGS7HthbOqr3TNGHx6NwwH6CTCuYpdpzn14ImFH28=;
 b=JG3hNtIiRUwDxWDg8ICJb3RRHPL1VLHnm7JP53vr7iakO8HI6ZjKdKnqUGeNsymwYk
 qWRLe9/3JIJry/FtWWC7qeDwecTkdXy9LODLJUqdKSyiE81zPFLVaoPAoN9rZJxWLsGb
 YpEYD4gKYMW3iEozqCgGtSpahfn2CsEuqPvOCnO6nG9WLradfDHap0FJuEqwjaS2wRdA
 i0DaVJ63GaaOuZPfI4iijmvyslQaChZjJlr32GjctwIhSpyhf7FJM61YLeIEoXYIn60j
 mPbbtMf9NbA7HcQdNJ0owhtCDHhoeTtDScfqNz2mJfd/mmwFuINNMC965JWxoZp65M0f
 Gi5g==
X-Gm-Message-State: AOJu0Yy3mQtGCAiT2uQoitooI2Zjfg1BPBZIvDd/ZagA+w5zN0157zi1
 IUgG0e+6NTJgL9932wHlT+XAZUM/1RSh1ERuNqHNtAX8oPTLHzf6EfLuxVuffmDH6baahgUfjPA
 =
X-Gm-Gg: ASbGncuG6uqoEyzSG8YT4yHEDMMMB2seC9sajjbe8CEV5yllfmgwF6v+/3ipJijzqW2
 MIlGenR+cEqPorNvS80ckSH/d/95AlyFejbLsNv+013m29/3Icqc/Q0XV1VirV+udd3Is1iXWWp
 r+yek0rBxbIG/m3XDx1CjZc9YoSPN2P3n9ODItN/Bt5YtGKJPoodMeS4asGaJqOX/djpPhzks8D
 mWjW/AdDvcaN0BcUxs9+BhTRYKxDmPOh+PMh0tCJWctwLeH/XrwI30=
X-Google-Smtp-Source: AGHT+IF/rt1udX27b4RrUSBrfSOwc65lRunMXMr5VekyUUSvv4rrr9lesvovwFwx5DPihNZS0BD8EQ==
X-Received: by 2002:a05:6a21:3947:b0:1e1:b60c:5bcf with SMTP id
 adf61e73a8af0-1e5e0802911mr72619214637.32.1735770144527; 
 Wed, 01 Jan 2025 14:22:24 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:22:23 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 48/67] upl: Factor out part of decode_reg() to new function
Date: Thu,  2 Jan 2025 11:09:34 +1300
Message-ID: <20250101221003.1944600-49-sjg@chromium.org>
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

This function performs the same operation on each reg element. Move
this processing into a separate function so that it can be called
without an alist

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/upl_read.c | 55 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 13 deletions(-)

diff --git a/boot/upl_read.c b/boot/upl_read.c
index bf5aa8f785c..fe48ae31ffb 100644
--- a/boot/upl_read.c
+++ b/boot/upl_read.c
@@ -172,6 +172,42 @@ static int read_uint(ofnode node, const char *prop, uint *valp)
 	return 0;
 }
 
+/**
+ * decode_addr_size() - Read an address/size pair
+ *
+ * Reads an address and size from a buffer containing a devicetree 'reg'
+ * property. This uses upl->addr/size_cells to determine the number of cells for
+ * each value
+ *
+ * @upl: UPL state
+ * @buf: Buffer to read from
+ * @size: Buffer size in bytes
+ * @reg: Region to process
+ * Returns: Number of bytes written, or -ENOSPC if the buffer is too small
+ */
+static int decode_addr_size(const struct upl *upl, const char *buf, uint size,
+			    struct memregion *reg)
+{
+	const char *ptr = buf;
+
+	if (sizeof(fdt32_t) * (upl->addr_cells + upl->size_cells) > size)
+		return log_msg_ret("was", -ENOSPC);
+
+	if (upl->addr_cells == 1)
+		reg->base = fdt32_to_cpu(*(u32 *)ptr);
+	else
+		reg->base = fdt64_to_cpu(*(u64 *)ptr);
+	ptr += upl->addr_cells * sizeof(u32);
+
+	if (upl->size_cells == 1)
+		reg->size = fdt32_to_cpu(*(u32 *)ptr);
+	else
+		reg->size = fdt64_to_cpu(*(u64 *)ptr);
+	ptr += upl->size_cells * sizeof(u32);
+
+	return ptr - buf;
+}
+
 /**
  * decode_reg() - Decide a set of addr/size pairs
  *
@@ -193,23 +229,16 @@ static int decode_reg(const struct upl *upl, const char *buf, int size,
 	ptr = buf;
 	for (i = 0; ptr < end; i++) {
 		struct memregion reg;
+		int ret;
 
-		if (upl->addr_cells == 1)
-			reg.base = fdt32_to_cpu(*(u32 *)ptr);
-		else
-			reg.base = fdt64_to_cpu(*(u64 *)ptr);
-		ptr += upl->addr_cells * sizeof(u32);
+		ret = decode_addr_size(upl, ptr, end - ptr, &reg);
+		if (ret < 0)
+			return log_msg_ret("udr", ret);
 
-		if (upl->size_cells == 1)
-			reg.size = fdt32_to_cpu(*(u32 *)ptr);
-		else
-			reg.size = fdt64_to_cpu(*(u64 *)ptr);
-		ptr += upl->size_cells * sizeof(u32);
-		if (ptr > end)
-			return -ENOSPC;
+		ptr += ret;
 
 		if (!alist_add(regions, reg))
-			return log_msg_ret("reg", -ENOMEM);
+			return log_msg_ret("udm", -ENOMEM);
 	}
 
 	return i;
-- 
2.43.0

