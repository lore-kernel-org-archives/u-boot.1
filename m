Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA8C7C369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 19:35:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6974782B7F;
	Tue, 15 Apr 2025 21:34:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DnVAKGho";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95E8E82B72; Tue, 15 Apr 2025 21:34:55 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8577082B32
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 21:34:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-39c0dfad22aso3501376f8f.2
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 12:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745693; x=1745350493; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K6SlZ+QrGe7TdAv9GQXjMxCdI1gWfzU65+/7rndF1tg=;
 b=DnVAKGhoj56vjxRh2T4lyMe8c7+3HbW+IBJ6gqB48diSzHHFGkBkN3fU4ZlGcgOe7a
 114pdvr7GMDGtpIklkTknr3VRmAnEGPqYYJ5Rhk2y5kz6+1uwe7wqiIKQ/Dg9b4e4+f1
 CfBJAZi+s7xSAlHO9QkzCv9bBaHb+i25gLD3p0yLcIqhmOTiTjfUPbuUR4baPYhTm5Hp
 TyA+k1gAHYMJnFwhcSbfAA1BN/maynqbT0OiQzhDo/0TmBjWNhRKeFgj0STYEoyBf9Yl
 OmhuFkxnJzWhebGMypk61CmofHQOQNEmbxA2CiocIEHRgpPwRZFDPZzKMQy2+Sg96bXV
 gudw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745693; x=1745350493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K6SlZ+QrGe7TdAv9GQXjMxCdI1gWfzU65+/7rndF1tg=;
 b=H/ycrbxyar3kBG8Y6cqLYolX6uFzTR/iw6KMnpBQ2r7sEmdBzM5t0WpD7nYdOaL9/r
 lG27Ze0PWrAzFUZQ9h3eG/3kiBk/PEV3mvj8YYdbxNJsEx9DVFD8NR7+w6I2bzuhroMI
 puO5tx0FPTN0BHY1XOy2LcBJ3q5xv1OrMKDYYu9mKtfweXR+HBeCFze6XdtVn63K1UfP
 R4uab5c6VSexRs2LOHsDqqbZvyuud2tguucVAofO6BsuRChhxriS5S8xmHivcYkc5K+J
 7Sj7lgHw3zP5gAxaXi7P6qyym8e+/Dq7KB6Z1TSjC9hFUaeOjsJ9B4HZa0Ft8Etp+HYd
 bO7w==
X-Gm-Message-State: AOJu0YzAJkhKeg3BKdKSnSQesMpkmHEvCs/xZ2sqD9mrAD9D4ymbkcId
 NWf9A/OS+uGtiJ4z/O8Ks21WQ1t7dtlh9j/Qtqtduf8FwbtN55h7dr8gNZEmPPOJxwZwe1qSd0X
 TwVg=
X-Gm-Gg: ASbGncufeQlcPqjKEBvSlVkdwV5sW6nNETVNeO6gOINYBnNQwVFOh/YcNsxIlGxD+M3
 kbg53v97lk9Gm/PKFEFTMK7dLTtMz4DdfDgp++3yBLtDBL5AoM7dKEZIqkul+PeLzKZ0kYqkTH3
 XinxxN09OZuRQDkAEXzdOi2wZe/hEiyMNufnLqKr1fN0RuRVQKY6BQO8shwDdBsEIf2y19Hp2SB
 CoQwCRVMTJvjeBaGCmWiRbH+BMNtqThoKc5BeK2FQlqBTXIDDJqVqDfaJs+bDSbddN1dEriZ09r
 iy6Wl9VOmjPsnNuuO2iQY99mbdzpi9NAWz/J0FA/flbrJVQ1Bmr7PEWbGpI=
X-Google-Smtp-Source: AGHT+IFTF027lKwV6p1fM5GxbbUUC5Sq1xWJQDodkezP3KFeeTrokNcv2g80gErQhuBCwD+CnI2B7Q==
X-Received: by 2002:a05:6000:1449:b0:39a:c9ae:9efe with SMTP id
 ffacd0b85a97d-39ee2736ce7mr585613f8f.18.1744745692680; 
 Tue, 15 Apr 2025 12:34:52 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6ebc:6ce:770e:95f9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf43d046sm15520484f8f.63.2025.04.15.12.34.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:34:52 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 3/4] net-lwip: wget: add LMB and buffer checks
Date: Tue, 15 Apr 2025 21:34:28 +0200
Message-ID: <20250415193436.1240804-4-jerome.forissier@linaro.org>
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

Legacy NET wget invokes a store_block() function which performs buffer
validation (LMB, address wrapping). Do the same with NET_LWIP.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Suggested-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---

Changes in v4:
- The 'silent' boolean in stored in struct wget_http_info (same as NET)

Changes in v3:
- store_block(): add Sphinx-like documentation
- store_block(): do not print to the console if ctx->silent

Changes in v2:
- httpc_recv_cb(): add a call to altcp_abort(). Otherwise the transfer
continues and we try to write later blocks which makes no sense if one
has been rejected already. Thanks Sughosh G. for testing and reporting.

 net/lwip/wget.c | 64 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 55 insertions(+), 9 deletions(-)

diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index 3529768eb06..42d364e4115 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -6,6 +6,7 @@
 #include <display_options.h>
 #include <efi_loader.h>
 #include <image.h>
+#include <linux/kconfig.h>
 #include <lwip/apps/http_client.h>
 #include "lwip/altcp_tls.h"
 #include <lwip/timeouts.h>
@@ -201,11 +202,58 @@ static int parse_legacy_arg(char *arg, char *nurl, size_t rem)
 	return 0;
 }
 
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
+static int store_block(struct wget_ctx *ctx, void *src, u16_t len)
+{
+	ulong store_addr = ctx->daddr;
+	uchar *ptr;
+
+	/* Avoid overflow */
+	if (wget_info->buffer_size && wget_info->buffer_size < ctx->size + len)
+		return -1;
+
+	if (CONFIG_IS_ENABLED(LMB) && wget_info->set_bootdev) {
+		if (store_addr + len < store_addr ||
+		    lmb_read_check(store_addr, len)) {
+			if (!wget_info->silent) {
+				printf("\nwget error: ");
+				printf("trying to overwrite reserved memory\n");
+			}
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
+	if (ctx->size - ctx->prevsize > PROGRESS_PRINT_STEP_BYTES) {
+		if (!wget_info->silent)
+			printf("#");
+		ctx->prevsize = ctx->size;
+	}
+
+	return 0;
+}
+
 static err_t httpc_recv_cb(void *arg, struct altcp_pcb *pcb, struct pbuf *pbuf,
 			   err_t err)
 {
 	struct wget_ctx *ctx = arg;
 	struct pbuf *buf;
+	err_t ret;
 
 	if (!pbuf)
 		return ERR_BUF;
@@ -214,19 +262,17 @@ static err_t httpc_recv_cb(void *arg, struct altcp_pcb *pcb, struct pbuf *pbuf,
 		ctx->start_time = get_timer(0);
 
 	for (buf = pbuf; buf; buf = buf->next) {
-		memcpy((void *)ctx->daddr, buf->payload, buf->len);
-		ctx->daddr += buf->len;
-		ctx->size += buf->len;
-		if (!wget_info->silent &&
-		    ctx->size - ctx->prevsize > PROGRESS_PRINT_STEP_BYTES) {
-			printf("#");
-			ctx->prevsize = ctx->size;
+		if (store_block(ctx, buf->payload, buf->len) < 0) {
+			altcp_abort(pcb);
+			ret = ERR_BUF;
+			goto out;
 		}
 	}
-
 	altcp_recved(pcb, pbuf->tot_len);
+	ret = ERR_OK;
+out:
 	pbuf_free(pbuf);
-	return ERR_OK;
+	return ret;
 }
 
 static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
-- 
2.43.0

