Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20811C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 15:16:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09F1083D3C;
	Thu, 10 Apr 2025 17:16:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qI47O1w4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 102918192A; Thu, 10 Apr 2025 17:16:19 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDEBC83B8F
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 17:16:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43edecbfb94so10460105e9.1
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 08:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744298176; x=1744902976; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GiQhEdzxFC/SizZUKx6GlyeI6XqT1jcQhvAy1drEgA8=;
 b=qI47O1w4IXxfzshbZ32bylguhhTu9auFbqsTm9CNhcYeSVWcFVK6JX0psyLpvimBky
 BiqjzghFuZByh0K0BcbXPG1WfHxnzyQqMjZ3UFUj71NRgq8lYWgfsaBlV7s7SFaS69CR
 Z9A0YF8uc0iEx4KKwn5/IgdRiBT9Uo3J1T3o2N1er+f/6D/qoeicPoefDgvHdQj7BGjm
 ZxcLdiP1QC2xxj0Nlak5V3JfWGzlSVFC3uSQc8gZKA/wFJJfKWlAFt5y0TnwCltVjNfo
 7zSwwrUJQWpXb4dMhUA++NqFkA/8l3pLJ0ysyejYNLfx0Z58Z9M1mC+xkjlNgbjYkbn7
 /w+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744298176; x=1744902976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GiQhEdzxFC/SizZUKx6GlyeI6XqT1jcQhvAy1drEgA8=;
 b=u/AEvrOxdZnrikmy8eF7KrFnTy8uc22ZspSMTCFeYDkJZXepjz2qHbveCwZ4QkeeFx
 3/4jZPfSUXNd7U/eJAVuApOXULHet5mBI6VtYi/cKVXHVEpZHAEl3tmQAZsU7LLaiVIo
 Pwt1Hj+SjTzD4elFnZr5g8yaLbPzmutnHDRK8BqIrOycBv4dJ56/4g0JMJHOhePvrDoN
 rxFng37nuvwaQL+jV9laFUDgEHLF1zr6Cw/cVc2WgeGvCPZx4qS5Zq7bxwGdNshhyVpq
 qt4ENVqHsYxy/51YEAXGNbWdfUI8V1/VnGNfKE9l7/o/JE3YN/a3l6/2MwfWPFfAHV8R
 xa5Q==
X-Gm-Message-State: AOJu0YyEIojvhvoYdp7XaI9o/hn+KE9fztu6FmdFMCCFwMudhryrBCgc
 brnK+jfAMME/k4eZ7VDtgA+/3WnlJtdPt3mkmxaxdhZyoZSHDizvuhM473+wDbQazM3BuNogJt7
 BvAE=
X-Gm-Gg: ASbGncuZRhjG6MQT3cZwMN1DxeGF4W1BPknuPS3GjqEZxJq/VJHfQierMm6tqXaVDHk
 5dd3HMZsayprJETrKONh/sK4AB5sUNupgIoQEQ1lDDC79teTjbbUjQDLD3LcZNF0QiRnrSsf8bj
 dB1hXDlCFrmLk0W5gfeu+3e1bknN6yE38lw4AKC+c9etgzMm2drTnXG+BY6RKgrDEwl3YA/KZWp
 hJG+mLviZqkjQ5b3STLO5bY+jHPDRDIZWPhpYAEyTmAFIh6bmJDaSUh4Immc7DIHZF0lrooEnJ8
 DWa3gvgr89/cPiR9TUSB+aGE0zo1GoMj4rdWNE8xJF+ujx397g==
X-Google-Smtp-Source: AGHT+IGAPy/4daGlUUK/1WvTItgLlJhYtzOuFp1MMMWxD2A5+A9IAa4XfScw+/vmWiYjJCjUhKcFCg==
X-Received: by 2002:a5d:5f4b:0:b0:399:6d26:7752 with SMTP id
 ffacd0b85a97d-39d8fd8b4bamr2633423f8f.38.1744298176113; 
 Thu, 10 Apr 2025 08:16:16 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:7edb:df05:a425:37cd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f233c824bsm54873225e9.24.2025.04.10.08.16.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 08:16:15 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 3/3] net-lwip: tftp: add LMB and buffer checks
Date: Thu, 10 Apr 2025 17:14:54 +0200
Message-ID: <20250410151600.3370247-4-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250410151600.3370247-1-jerome.forissier@linaro.org>
References: <20250410151600.3370247-1-jerome.forissier@linaro.org>
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

Legacy NET tftp invokes a store_block() function which performs buffer
validation (LMB, address wrapping). Do the same with NET_LWIP.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Suggested-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---

Changes in v3:
- store_block() [tftp]: add Sphinx-like documentation

 net/lwip/tftp.c | 56 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 45 insertions(+), 11 deletions(-)

diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
index 123d66b5dba..c7f1420ca0f 100644
--- a/net/lwip/tftp.c
+++ b/net/lwip/tftp.c
@@ -8,6 +8,7 @@
 #include <efi_loader.h>
 #include <image.h>
 #include <linux/delay.h>
+#include <linux/kconfig.h>
 #include <lwip/apps/tftp_client.h>
 #include <lwip/timeouts.h>
 #include <mapmem.h>
@@ -31,6 +32,47 @@ struct tftp_ctx {
 	enum done_state done;
 };
 
+/**
+ * store_block() - copy received data
+ *
+ * This function is called by the receive callback to copy a block of data
+ * into its final location (ctx->daddr). Before doing so, it checks if the copy
+ * is allowed.
+ *
+ * @ctx: the context for the current transfer
+ * @src: the data received from the TCP stack
+ * @len: the length of the data
+ */
+static int store_block(struct tftp_ctx *ctx, void *src, u16_t len)
+{
+	ulong store_addr = ctx->daddr;
+	void *ptr;
+
+	if (CONFIG_IS_ENABLED(LMB)) {
+		if (store_addr + len < store_addr ||
+		    lmb_read_check(store_addr, len)) {
+			puts("\nTFTP error: ");
+			puts("trying to overwrite reserved memory...\n");
+			return -1;
+		}
+	}
+
+	ptr = map_sysmem(store_addr, len);
+	memcpy(ptr, src, len);
+	unmap_sysmem(ptr);
+
+	ctx->daddr += len;
+	ctx->size += len;
+	ctx->block_count++;
+	if (ctx->block_count % 10 == 0) {
+		putc('#');
+		if (ctx->block_count % (65 * 10) == 0)
+			puts("\n\t ");
+	}
+
+	return 0;
+}
+
 static void *tftp_open(const char *fname, const char *mode, u8_t is_write)
 {
 	return NULL;
@@ -71,17 +113,9 @@ static int tftp_write(void *handle, struct pbuf *p)
 	struct tftp_ctx *ctx = handle;
 	struct pbuf *q;
 
-	for (q = p; q; q = q->next) {
-		memcpy((void *)ctx->daddr, q->payload, q->len);
-		ctx->daddr += q->len;
-		ctx->size += q->len;
-		ctx->block_count++;
-		if (ctx->block_count % 10 == 0) {
-			putc('#');
-			if (ctx->block_count % (65 * 10) == 0)
-				puts("\n\t ");
-		}
-	}
+	for (q = p; q; q = q->next)
+		if (store_block(ctx, q->payload, q->len) < 0)
+			return -1;
 
 	return 0;
 }
-- 
2.43.0

