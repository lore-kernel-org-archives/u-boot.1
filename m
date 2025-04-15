Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D717C369BA
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 19:35:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFC2982BA7;
	Tue, 15 Apr 2025 21:34:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jzJTSAxx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B218682B92; Tue, 15 Apr 2025 21:34:56 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63E5182B4A
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 21:34:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39c0e0bc733so5168484f8f.1
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 12:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745693; x=1745350493; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g48XLGI3oYJiC+FEguq2qZRcjoaBxDTm/BABIiCSeQY=;
 b=jzJTSAxxVDpg5ndWE3PxZPn5f5SiMI8exzQr7h3oCJcbQu33AuL8NhvNmqmHhv/f67
 vs5emf/5rjem/LnzCoHM9tuwY6y8sk5ahKxbwXR9hVWSWJw3p6j4UX9Eh/1YkrglSHzO
 hJSG4sqakslomfD1C2KMQuvrcoUXUR0k0SSoUcjXPQ0npbk4bw3cj4EySmrM371BKJh0
 9AEkUp34Y2XBrzYvKfBXxQNLBmE+zWpFHgIYqXNNQJeW+ThDjH+5LifiorZ9EiG/kl9c
 uMbeKo+zsYAnAJyrXFft76x7sDlP4h0ihUUZ1hIgb1yK2KfA6vi95clO6FTzdGT3PTV0
 bFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745693; x=1745350493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g48XLGI3oYJiC+FEguq2qZRcjoaBxDTm/BABIiCSeQY=;
 b=tkJAP4ifmwitoIEsNg5fGMHWkbnSHTjAoVfdbkxJHZ86I+qcm4Orv6101wnrPd0bLe
 /FTPEbTCEJRQ0V1YybhXWQxmtMF6KnDa601t0cST1J88YRhIlPoXueo4f10Np1u+Ir84
 3RXFoZgcF18/TKyIoIak/H7CqnK/VAMFagWXe1/uugFg0irWb8CxL0v+KBdO6Gt1mup3
 ZdRopD4jbWKGbnutIgqzChL7IJY2nSTkWBxF62Dxsmugnv+lxOFZgfMNOmQKBqiJi3gD
 Ec1ZWOVA8wyJBbWJr8xbssm5q24Xi/IlRJCnotsQNWcPrbrJL45yeXDFSeFkVfc/RNv5
 p6JA==
X-Gm-Message-State: AOJu0YxJc5jyqlcNacXsvzVWgdqmNHRnNqYj2lsWH9b+0qK+SgoTNXMn
 2waL6C+QzjN7mgvuA5b6hjTRcZJfCOQ/smDdLfvPRL8TQk2XgLcmJeefqidQMT6+6+S+O6noTjE
 3E0k=
X-Gm-Gg: ASbGncsa1mSv6C3pmVkV1IygpEjr4eNuEYA4V/fS41+R5h+xxK+87sqwpvRvykXeniB
 QU7o0Eb8s2aw+O73mMNygBqP87f4yp6waQ/WSnbrDIEx5f59sAap4becg2kWqFcBkmfKF6txiWs
 K6u9xnGNvXr8MgdvoQQYJZS5GlgiVWUBG8m/dKuPpmbmdOGk3VAV1TXkmfH6xup6hD/YoCZQ4s6
 m69286mQ2wTDY5grrXOcSW7DdAgCqRctyo88D9RSH15EjjrsfKW2C7cNo0oD3Z7vO4ZWvd2rUnF
 iMwsC2SVLiry6Ee6Ya7D4BngMzw8AHzcmKb66vOTsFZz+GNr
X-Google-Smtp-Source: AGHT+IEbr2JvLlr+zzZYtgF0tjrfjYz/KKgR7+KKUEGs6sQG7CEQnWEUKZU3/cGqM4XAaSJgbmhnbg==
X-Received: by 2002:a05:6000:22c2:b0:39e:cbde:8889 with SMTP id
 ffacd0b85a97d-39ee27295fdmr652202f8f.6.1744745693582; 
 Tue, 15 Apr 2025 12:34:53 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6ebc:6ce:770e:95f9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf43d046sm15520484f8f.63.2025.04.15.12.34.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:34:53 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 4/4] net-lwip: tftp: add LMB and buffer checks
Date: Tue, 15 Apr 2025 21:34:29 +0200
Message-ID: <20250415193436.1240804-5-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415193436.1240804-1-jerome.forissier@linaro.org>
References: <20250415193436.1240804-1-jerome.forissier@linaro.org>
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

(no changes since v3)

Changes in v3:
- store_block(): add Sphinx-like documentation

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

