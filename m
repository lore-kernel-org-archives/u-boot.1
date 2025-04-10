Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA360C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 15:16:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6E5883B8F;
	Thu, 10 Apr 2025 17:16:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ivi7YfAO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D41898192A; Thu, 10 Apr 2025 17:16:18 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2170F83D39
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 17:16:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso7595745e9.3
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 08:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744298175; x=1744902975; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2qrIYvhrPni0ORHgstbrNs0wtrrGI1JHSjKov0eTU/E=;
 b=Ivi7YfAOuFYdfQ6QF8K8mVcCf6/xZwtRd//dMlRu+JkV24JRvoJAqUPXNMWYisN9eY
 gkbRCAqCpyVXQ72DkIbouwmJy1P+iPk3XfmesPXw1WSxnEJMpMYwb1JLEoxoThQZhKHB
 eeSKvPDXnY49zPlw2E3brsrKDe+x3WCEXrjXRYyoSUl6X8MvMtLI7gPehRiWFYI3IYfp
 h625IK8gPj5UpXMuNHa1YK5lhq4MFlqSXRdoYSfu5b9TfA2cYqYx6l+lL3mSSBDJm+0e
 Xo8gdu30NIXACygmjalXlIhb7SnuvJUR/I0Ht4ar+XIciCneRiLj0OZGu2Nl4DxHlRK0
 axTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744298175; x=1744902975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2qrIYvhrPni0ORHgstbrNs0wtrrGI1JHSjKov0eTU/E=;
 b=B5Er0o003RkMvlsoaPB4IumP0pIFEfnk2OoXdPAJj6l2jE8QfYxu6Kk+dykVvaA39j
 ZD/erfQSa+g797gVwK2Oguz6/EKBqC2gg6vVX9u2H6ClXEyGDqQ7rGo/rFjHuDEf2A+k
 2m+D6go9TF2HoEIyxliBQkq1dEg3JdEnfZZH1FhS5LHRS6XtIz629uC2IsRjY2bGKqyw
 vEsd9lKSfXmIAorxRPeY7vUHbEHrn6s27G/nyliqPJvh1BRF7IdO7HRw63Z7p0HQ20Uq
 mj7a94UbbPJVuEF0DCIN3bg16M7trmKXuOp+Z0q8h2io6Vaw7oyz1TX/VrmWJTP2gDiV
 GNBQ==
X-Gm-Message-State: AOJu0YyB0uZs8AGVZIf5GXiLRQnonKCMSm0VaN/a4UDURv6MClHprBzh
 gMfZi6a0VEB+5KAeaC5MjGhx3p9AaXy+LuXAu2pVu/zTBLOM20Tov4zP4WoelEnSDO+DcoLP5Bw
 v7bM=
X-Gm-Gg: ASbGnctsdxAxbgXoCwYxzSNlnDrvnBjiBfGSRPssIZQUCtX72Yt0Ztr0mE2MSnIejQb
 mE5NF9fTSBmu3PqPoAaRnvBK8aoBk4zT4EqnUhxj1GB4ZrkeqBE0IrOF25i1NyWG52io8l31fyS
 I6mshR0zGeP159JPnf8zwS8QnBTb98U3P84HlTvXBSOaj3IIqnUDpjmx+cQMfp2MPRijMWpLch6
 afOp0HDldnQ/T4J32VfTIOATHz2B2HXHWgYp1CPFds1g7UPNITan1r9JvRpFInLvNEiX2MAPy12
 6MrsalBvCBUcvqc2th0rDpyROq+K4ZMwYEE7v/28b+opjEhOtg==
X-Google-Smtp-Source: AGHT+IHiyP4TfRTV/Mm4fAIj0TjNL8Eu6ZXTk4zDPS2KEglK63UcOXoFr/41HHEsoBDU7xxE9MA+JA==
X-Received: by 2002:a5d:64e3:0:b0:39a:cc34:2f9b with SMTP id
 ffacd0b85a97d-39d8f469224mr3200185f8f.16.1744298175285; 
 Thu, 10 Apr 2025 08:16:15 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:7edb:df05:a425:37cd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f233c824bsm54873225e9.24.2025.04.10.08.16.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 08:16:14 -0700 (PDT)
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
Subject: [PATCH v3 2/3] net-lwip: wget: add LMB and buffer checks
Date: Thu, 10 Apr 2025 17:14:53 +0200
Message-ID: <20250410151600.3370247-3-jerome.forissier@linaro.org>
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

Legacy NET wget invokes a store_block() function which performs buffer
validation (LMB, address wrapping). Do the same with NET_LWIP.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Suggested-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---

Changes in v3:
- store_block() [wget]: add Sphinx-like documentation
- store_block() [wget]: do not print to the console if ctx->silent

Changes in v2:
- httpc_recv_cb(): add a call to altcp_abort(). Otherwise the transfer
continues and we try to write later blocks which makes no sense if one
has been rejected already. Thanks Sughosh G. for testing and reporting.

 net/lwip/wget.c | 63 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 54 insertions(+), 9 deletions(-)

diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index d3628cf72de..ebea6ea21a0 100644
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
@@ -202,11 +203,57 @@ static int parse_legacy_arg(char *arg, char *nurl, size_t rem)
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
+			if (!ctx->silent) {
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
+		printf("#");
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
@@ -215,19 +262,17 @@ static err_t httpc_recv_cb(void *arg, struct altcp_pcb *pcb, struct pbuf *pbuf,
 		ctx->start_time = get_timer(0);
 
 	for (buf = pbuf; buf; buf = buf->next) {
-		memcpy((void *)ctx->daddr, buf->payload, buf->len);
-		ctx->daddr += buf->len;
-		ctx->size += buf->len;
-		if (!ctx->silent &&
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

