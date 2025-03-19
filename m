Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB807C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:39:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 345DE81E8C;
	Wed, 19 Mar 2025 15:38:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FzVzgIha";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6982981E5A; Wed, 19 Mar 2025 15:38:51 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58AE381DE3
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:38:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-399749152b4so434097f8f.3
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742395128; x=1742999928; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5mhrjpw3koy+Vx3c5a83iU4xGjpXnBXWUlWPK1716RI=;
 b=FzVzgIhapW2Y/8IpO10SUcbZuolQX+LL1l3/ZChx7XZboxC5Qa0IQZxviY/LcZOPHg
 vOFfFA1mZn2S/LXtYdaab4GA8WfHkvigs1MNeIovsm76SDzgBMZY+hoQV9GYxlkwrI6L
 MNRo/IxI363y03N8/OSmruRurkJUpIDciTK7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742395128; x=1742999928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5mhrjpw3koy+Vx3c5a83iU4xGjpXnBXWUlWPK1716RI=;
 b=Nrc7ZAd+38hXgKgDdsGpgVXIMvyOgjyvZxCn9YCdIIKRkOXAHfhZEHpRmxgOj1kTli
 KP2SdtAojSYy1uMixo0HhFuH/WT+g+urg1UbBE2pMWOaV1kngVqve1C6/sKvCD3n2Qeh
 17QCi9sHM6lxayN47pTRsHWVxP9juWzzlbH8WzJH+YDgPzjDx9Rt7u1dUZ3zb6fVh0N9
 uJCOk86rxNdSP3Oz0KmapbO7Xbw1yJSznAX0XAYQuO5ezg+9rKprE45ofn1b834hXggY
 AA7BHhKJtZG6qWgnuzSiQ8Rexivze6q7aNPF41MMvWOa/rzdeA74rKCe9Q2mHnVXOA9I
 U10g==
X-Gm-Message-State: AOJu0YwfzPAzZ28j0CmOHWrO98TPcUrUhegh4LBakbiYFUcgA+zszW0x
 Andz3ljrrHunnjbFSlL0GY7AYGd3sQNe6V65CUj7kqisN414dC+wLMora3hDnawxwdNGGCriL6A
 =
X-Gm-Gg: ASbGncsPm3W45gCpVgJ0NneKjnIGET/HEFMKU2dnirKoSnzAtnjZ+yNRWcwIx0BJ7wC
 QrDX8LzHLl4fbqRrlt6Rn2IBqMQhu4+tfGtUmC0HwDIh5LUk/pjE+mwB1trgHjMm+N6PW4KmhSW
 7rKeSWL09MI2FEgSyeLEzX0vBlqpyh8q8Fq1HxhXeFe09GA/fNyD99a4oDzWTmO2GNao1P3NW0m
 yoNvg8uQjW7aoNAWcBANX1iPfEqhezVFTOWgoijJNBNSU4Q8lXpZ0R7a+bIcDX9zGtBisnthxWZ
 6clPHWXEgtLHq59Mw9wyQcArYCvvYE6kUYWZnJRBVg==
X-Google-Smtp-Source: AGHT+IEJcI4UG6yHCdmwTsA//UXZAfqKs3zofT1LTw/6cxbfqQvHmZ0L3lG+jEleIp/4auK8QfpkWA==
X-Received: by 2002:a5d:59a7:0:b0:399:6af3:7a77 with SMTP id
 ffacd0b85a97d-399739bf15emr3034359f8f.19.1742395128206; 
 Wed, 19 Mar 2025 07:38:48 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb318a80sm21534428f8f.61.2025.03.19.07.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:38:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/17] fs: boot: Update bootmeth_alloc_other() to use abuf
Date: Wed, 19 Mar 2025 15:37:57 +0100
Message-ID: <20250319143820.2385092-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319143820.2385092-1-sjg@chromium.org>
References: <20250319143820.2385092-1-sjg@chromium.org>
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

Using an abuf for this function simplifies returning the size and also
makes it easier to free memory afterwards. Update the API and callers.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootmeth-uclass.c | 12 ++++--------
 boot/bootmeth_script.c |  6 ++++--
 cmd/bootflow.c         |  2 +-
 include/bootflow.h     |  2 +-
 include/bootmeth.h     |  5 ++---
 5 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/boot/bootmeth-uclass.c b/boot/bootmeth-uclass.c
index 78a3671f96a..02bbe77b563 100644
--- a/boot/bootmeth-uclass.c
+++ b/boot/bootmeth-uclass.c
@@ -360,13 +360,11 @@ int bootmeth_alloc_file(struct bootflow *bflow, uint size_limit, uint align,
 }
 
 int bootmeth_alloc_other(struct bootflow *bflow, const char *fname,
-			 enum bootflow_img_t type, void **bufp, uint *sizep)
+			 enum bootflow_img_t type, struct abuf *buf)
 {
 	struct blk_desc *desc = NULL;
-	struct abuf buf;
 	char path[200];
 	loff_t size;
-	size_t bsize;
 	int ret;
 
 	snprintf(path, sizeof(path), "%s%s", bflow->subdir, fname);
@@ -386,16 +384,14 @@ int bootmeth_alloc_other(struct bootflow *bflow, const char *fname,
 	if (ret)
 		return log_msg_ret("fs", ret);
 
-	ret = fs_read_alloc(path, size, 0, &buf);
+	ret = fs_read_alloc(path, size, 0, buf);
 	if (ret)
 		return log_msg_ret("all", ret);
 
-	if (!bootflow_img_add(bflow, bflow->fname, type, abuf_addr(&buf), size))
+	if (!bootflow_img_add(bflow, bflow->fname, type, map_to_sysmem(buf),
+			      size))
 		return log_msg_ret("boi", -ENOMEM);
 
-	*bufp = abuf_uninit_move(&buf, &bsize);
-	*sizep = bsize;
-
 	return 0;
 }
 
diff --git a/boot/bootmeth_script.c b/boot/bootmeth_script.c
index 020cb8a7aec..b3a51a35e89 100644
--- a/boot/bootmeth_script.c
+++ b/boot/bootmeth_script.c
@@ -8,6 +8,7 @@
 
 #define LOG_CATEGORY UCLASS_BOOTSTD
 
+#include <abuf.h>
 #include <blk.h>
 #include <bootflow.h>
 #include <bootmeth.h>
@@ -68,6 +69,7 @@ static int script_read_bootflow_file(struct udevice *bootstd,
 	struct blk_desc *desc = NULL;
 	const char *const *prefixes;
 	const char *prefix;
+	struct abuf buf;
 	int ret, i;
 
 	ret = uclass_first_device_err(UCLASS_BOOTSTD, &bootstd);
@@ -107,8 +109,8 @@ static int script_read_bootflow_file(struct udevice *bootstd,
 	if (ret)
 		return log_msg_ret("inf", ret);
 
-	ret = bootmeth_alloc_other(bflow, "boot.bmp", BFI_LOGO,
-				   &bflow->logo, &bflow->logo_size);
+	ret = bootmeth_alloc_other(bflow, "boot.bmp", BFI_LOGO, &buf);
+	bflow->logo = abuf_uninit_move(&buf, &bflow->logo_size);
 	/* ignore error */
 
 	return 0;
diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index e9ac9746104..0163129deba 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -419,7 +419,7 @@ static int do_bootflow_info(struct cmd_tbl *cmdtp, int flag, int argc,
 	printf("Logo:      %s\n", bflow->logo ?
 	       simple_xtoa((ulong)map_to_sysmem(bflow->logo)) : "(none)");
 	if (bflow->logo) {
-		printf("Logo size: %x (%d bytes)\n", bflow->logo_size,
+		printf("Logo size: %zx (%zd bytes)\n", bflow->logo_size,
 		       bflow->logo_size);
 	}
 	printf("FDT:       %s\n", bflow->fdt_fname);
diff --git a/include/bootflow.h b/include/bootflow.h
index 2caeb80b878..d988bc9355b 100644
--- a/include/bootflow.h
+++ b/include/bootflow.h
@@ -101,7 +101,7 @@ struct bootflow {
 	char *subdir;
 	char *fname;
 	void *logo;
-	uint logo_size;
+	size_t logo_size;
 	char *buf;
 	int size;
 	int err;
diff --git a/include/bootmeth.h b/include/bootmeth.h
index 03301c90580..c32bbbab7e9 100644
--- a/include/bootmeth.h
+++ b/include/bootmeth.h
@@ -385,12 +385,11 @@ int bootmeth_alloc_file(struct bootflow *bflow, uint size_limit, uint align,
  * @bflow: Information about file to read
  * @fname: Filename to read from (within bootflow->subdir)
  * @type: File type (IH_TYPE_...)
- * @bufp: Returns a pointer to the allocated buffer
- * @sizep: Returns the size of the buffer
+ * @buf: Returns the allocated buffer
  * Return: 0 if OK,  -ENOMEM if out of memory, other -ve on other error
  */
 int bootmeth_alloc_other(struct bootflow *bflow, const char *fname,
-			 enum bootflow_img_t type, void **bufp, uint *sizep);
+			 enum bootflow_img_t type, struct abuf *buf);
 
 /**
  * bootmeth_common_read_file() - Common handler for reading a file
-- 
2.43.0

