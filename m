Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3255C369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 13:27:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CFBA83045;
	Thu, 17 Apr 2025 15:27:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w+l+8lxm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D5118304A; Thu, 17 Apr 2025 15:27:34 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A3AB82CA8
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 15:27:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39ac56756f6so797111f8f.2
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 06:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744896451; x=1745501251; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NH2Pl2IO51nijsyi+Ru2HA3FymfKngVtLYLV5gURHcg=;
 b=w+l+8lxmuwbgDX9PjM+xgrpUWc/yqxLVQKFznMWNWXxpuhHYXNpRv1L5AVpYCLI/nv
 OE+EwL9eMmBYP3gM+89/tUUJCIHeS1bTDqH7O/cbiqpwutGWwaQ/+9DF6VKQyQw8C/pB
 BElP4A4lrPuitJojKcOa0tOgdk0cn6yJxzUXqGAW5Br1ZI2mTDlK6QMwTAKyCwXJFcOR
 pJ4y128NLIpofs+ER5VStOgEIi14AxWJZBgWFd/w/R4eDiYs+8tN/wPTN1tg6pJXrKcA
 8YmshZGsjZtfqrXNxmq7hAH2kLUvPfDLXtdhvhIBAsUPKjY/tVVEHxG852t3oWU2kk5b
 y/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744896451; x=1745501251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NH2Pl2IO51nijsyi+Ru2HA3FymfKngVtLYLV5gURHcg=;
 b=a8+rHDmYGI4ZcR2eeu9R/f3a/3CYg71pPW2yaT2IXVAO6jmOxwKED18NVHHyUW6H82
 wx2Eu87lifw1yluCXCrR+oPhPW+KQuGMBUVfjswPYrDWAU/D5lsJHGm05N8BwrDgkwOF
 u6r5VZ9Cgrp7nZDNpu6b6By8IY36C2qEOHh3tVK7FfQJpRv5dpSMcJEwTjn/7Cl6JkB4
 H5tJ6zwfzIzRgBDmvBSFQYif+wOwzmbXQcH2m5UAQS6Dzpmql2iwtf6CJGLGzDbexQ2l
 WizljagaECOQQvSpFp5i0dkzcrH6k0nhBHdlqyNxXNKPnpZ97OsQehBhoEcwPd67epP/
 hpZw==
X-Gm-Message-State: AOJu0Yw4s7SJMT4YmWBc5+AYe5yHq3luW80UoH83JfJ5zobrJ4mHftUZ
 dIGHMxGB3QZxRSi0LhyCWBMu0uhQpuP3G2MZ17U/5jPyVO5lWhbz2PSru+DBCj2bndadk3ZxH79
 8kx0=
X-Gm-Gg: ASbGnct6Pi3DSFCh9qCerNDF7kbjX1DhzNQL2EVajaJORIY5zUFSbf6OfUeEHbhYa48
 a2p4wiWN8n7jVGO/wP4jS7ZjFtjTk4Tts8IDVNtGraBZPj5bdfIHOOSPZXZsyjje9LTdYwlfrtn
 Az/V/MgNTbgWuBgMO+PfsLXnHkAjuSEB2ok04tj0r1++eTKuIly8X+aeaYNPeMip6VN4zwEn0Ml
 fLCDcjxD5dDgPFgZ8i6Qyyi25uUn0mE2frnCxPxo7vDjDtnQ+mL9KaEGXE6Io0HMmo1xbkx+rQK
 FFy0q2CfaaPgl4BJAm/QHY/5urPVQAJAJi0H+gQGFFgntpEkaw==
X-Google-Smtp-Source: AGHT+IGo60Y2iDX91mNBXvoAzT8ALtlfVVJbkoF7mKwM5C5Wba7bWInZ/y4TkAac1kKjq+0sciWZcQ==
X-Received: by 2002:a05:6000:18ab:b0:39c:1f02:44ae with SMTP id
 ffacd0b85a97d-39ee5b35dbemr5924491f8f.27.1744896451434; 
 Thu, 17 Apr 2025 06:27:31 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:a07e:3f08:7eef:b036])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae977513sm19951605f8f.42.2025.04.17.06.27.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 06:27:31 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 3/4] net-lwip: wget: add LMB and buffer checks
Date: Thu, 17 Apr 2025 15:26:59 +0200
Message-ID: <20250417132718.2023555-4-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417132718.2023555-1-jerome.forissier@linaro.org>
References: <20250417132718.2023555-1-jerome.forissier@linaro.org>
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
Acked-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---

(no changes since v4)

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
index 63583e4c6e7..4ec00de96b2 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -6,6 +6,7 @@
 #include <display_options.h>
 #include <efi_loader.h>
 #include <image.h>
+#include <linux/kconfig.h>
 #include <lwip/apps/http_client.h>
 #include "lwip/altcp_tls.h"
 #include <lwip/errno.h>
@@ -202,11 +203,58 @@ static int parse_legacy_arg(char *arg, char *nurl, size_t rem)
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
@@ -215,19 +263,17 @@ static err_t httpc_recv_cb(void *arg, struct altcp_pcb *pcb, struct pbuf *pbuf,
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

