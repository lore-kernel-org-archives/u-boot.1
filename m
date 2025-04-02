Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F329C36017
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 13:36:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89C8B81F66;
	Wed,  2 Apr 2025 15:36:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ufh1T2DV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C891881E6C; Wed,  2 Apr 2025 15:36:18 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE4D780FDA
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 15:36:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso69871335e9.0
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 06:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743600976; x=1744205776; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gWEisPS6q2fBGe+ElLWhnrxim85hqSZmazy45tx2acE=;
 b=ufh1T2DVkFD3Kd1X/Ttn1VO+0ORZ5giW/HVClq52KZoxNdoLeCRXl46ir7vtd7EbeL
 IlPFhzD4z8Jfzf9zaWhM7Eu0PiZXf5CM33YWwYmMMcLBrKjcykM+UB3lPX4LgYJfWjf7
 c0WP6WN7qspSY4NOPWZ6iRqNJFkw/yQ1TtI6ZFrbGN0GBUJKTKeBtSzA2VJ8LMXNHEF5
 Xy3mdDo3W47OVt5xjoEV2kTBIhpOpdEY7o1p/JsEgeZHSaF7vPmdNftRZUAoo+F/praT
 zE0G5Wc+BMH4EViSEwGnLTSesVA267topWVkIC3US48Hc9UyVpWYPFTl36TjoXJbXfGE
 Td9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743600976; x=1744205776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gWEisPS6q2fBGe+ElLWhnrxim85hqSZmazy45tx2acE=;
 b=WFg6vUB9vfhuOdgFN/A5VbzyL7fy6ufsXfjYOubu1BGcfZheFrLLQq3tKdTPxBvLag
 UugopgVui4tYsfMCiQQ1HblaOTfrNvRMwUxA7ZX5pRjvvadGIqjUKnjEjIet6JRW6oB/
 JTl4ZaUVrSfLKebiRso0yKPV3tDuOeR/B4lVPKP7wBjZmypMnMTV9+KvrsLLBIYu+OpN
 Tk3+pDv2diGEl+FaLVF5DprEp/Sg6vmmxEBfR20P5aU57WKWG2awu1smjhHgI9lWRZqj
 CFmlL/WtJO6viTM20Fw2tOZbF52G7AEV7SbFPDJznCT2ZlyOl5+wREZ1Dp+jRDPX+a/r
 xcBQ==
X-Gm-Message-State: AOJu0YyB0MVuJUuM1vkmsSACRJsTQz8AVvDEKsoGEVWdhivV6BUeF4Qt
 TTW2CZqD7z4yUnS1CM+x4WLqjNxEScXHKJTGLzYy2qbzFdTCN/5LVC2BLsVUhWQFvefQeXmRSDb
 Po4ypqw==
X-Gm-Gg: ASbGncvl0QlWS/9mHBZ0sJWJeeACOx0wNq9MiXmXHn4QBBYWVowO/riZWYTNlskqalj
 x8266gKujsYtSvH9myytoO7YCmZAqnpHhNRDz7LAZ+0/e9gC4rwtROLMEIM1Pt/pwurxW/QkKPh
 vsBQOPnPr7ZHOvB7GZwkB3WHA/uEZ8f9uqt1l+7QcNd++2D5tOLuFNmC4V3cBRUqgFArMo+qCQU
 nsg7xAEktvCN+yeKMPmWTFFiLREBaLw/B9xEewC80yVaNCvW0NgZ+WGfbaMdUlSLje5TCYJxbii
 VKEMAlSzkELWMGwPhVHXPxdrdf8i1J6wHHWmI5ofNxC037IwSMPVKQ==
X-Google-Smtp-Source: AGHT+IFeop0sNgbeNBfJYt2EQfJ5e7gTTSabTW2o2XhLJ2RW3JeAu1qOjhOucegZeGqcRNA3Cbn+Fg==
X-Received: by 2002:a05:600c:3c93:b0:43c:fdbe:43be with SMTP id
 5b1f17b1804b1-43db62bf0f2mr153298995e9.27.1743600975991; 
 Wed, 02 Apr 2025 06:36:15 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:1e67:7bcc:e97a:7477])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b66a991sm16928961f8f.49.2025.04.02.06.36.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 06:36:15 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] net-lwip: tftp: add LMB and buffer checks
Date: Wed,  2 Apr 2025 15:35:56 +0200
Message-ID: <20250402133557.2079137-3-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250402133557.2079137-1-jerome.forissier@linaro.org>
References: <20250402133557.2079137-1-jerome.forissier@linaro.org>
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
 net/lwip/tftp.c | 45 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
index 123d66b5dba..38aa647df5c 100644
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
@@ -31,6 +32,36 @@ struct tftp_ctx {
 	enum done_state done;
 };
 
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
@@ -71,17 +102,9 @@ static int tftp_write(void *handle, struct pbuf *p)
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

