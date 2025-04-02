Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BF3C28B20
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 13:36:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4297E81703;
	Wed,  2 Apr 2025 15:36:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FI1suoUT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC9C081F54; Wed,  2 Apr 2025 15:36:17 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94B8081CF0
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 15:36:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cf848528aso57633655e9.2
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 06:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743600975; x=1744205775; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hP1/8XcfmvmPgxVa3cctoueqTlAU8EvkA12Y8bBL5JM=;
 b=FI1suoUTYQLG75Uj9CzDDlbcFO46soXVthbqPnL+ubWOPoJx/peCayTLrCloyWVZUG
 UrIBYpzQ14vUnN6jyQj3PACEMEB3fKjGzmLuQc6fm7/yIReSzrFpzRLVB0YIlQZU+lZk
 Wl39klgdqpj6XFblTfe2HzdHyQJ031IPt5mw1oq646DjeLCy+0dbaTKDlx4CIGeIbAxc
 SsG4GF4+WVDctF7891Eo5DWzUMouUCNbhtgrfYcIEulZ0+CxOtAY4cc05O3GzbKtzL1A
 3ZYc9ezgO5aX/JByX64UyGoXROPG/ZWPHptF+VCUPQDiKfrXrXZ9d1hsHP/plsZEZErz
 FJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743600975; x=1744205775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hP1/8XcfmvmPgxVa3cctoueqTlAU8EvkA12Y8bBL5JM=;
 b=JpcncnoEunMtkxoML6XIKOO4j1imKkS/vjCfFfZPXHM1YN7kdeCy3i0Xv8nHbJN6eo
 wJtj00Wjs2GMvpdaO605npUpy4XqUP5OSnAk3VG3zp6aQyr+bPDmwd0iOCwODPOJwJze
 b96UHINBk4BixmdPEUlp6iCqSuowed7XxDSn/0bcE2OLvGzLJXeCnWxZCB7z6LnUVx9J
 BkBghoptqlhOgIoHvf3K/2FTI9Ieq+W64iEYCrB5ANHYJkrjndg3+n4dcq02Xn+zy42W
 WyuNDCl1LmfWwXBk2ONz99KRHUHsDY7+aMfRbdfjwmpoPZV2YoaVZhsB3QBi6wJQAGVz
 09og==
X-Gm-Message-State: AOJu0Yw8ADkkUv4rcY0BFuRL6Divjm2ggGREIDhBugzSa5ZgRjgHG984
 hZ8t6qEoFPfMafmdS8c1NHR+Xd1CEzg/9CM7zrr2v56WdpKFoSrncG+kjAHM0NrmssAieiH2wEr
 72GbOlA==
X-Gm-Gg: ASbGncvaXz86bU7aRDZI0A+toe+PKUI9A18HPzZwFucIXTgb14hXJS4iqDwheC9gql3
 1f+1r3pmfFgGr8Mx94sNRDnpkqOuhTiSGfIkx3J2PlJI1s6QWpUhO6awSTbIHGELqAYi0hICmHu
 lB+wxgdrtiTjmITt3oE0rGUhTFPVoxfSgl16/IbvGG66M5dIey+Sd8D8jfkiuA1O7275fgGs1tQ
 6Ai/rEygV2SJbslqdUryLXf1/vDq/AmjgfmG/Dg4ai7c16TUYc1fsFjv6tZge0g0UvgZ7esmL1X
 Tqup/Zkw6DkE0zR8XHratLDy78P0+G5KMou4JbI9e2HsXq2KiPMYPEW4SwMKty2J
X-Google-Smtp-Source: AGHT+IH+oBQkSQTGQX4ReOKqE4fSngsp4yqia++yBLzL5BKcc6ThRiPS0NA7KgT3ABCcoDsv/01OWw==
X-Received: by 2002:a05:600c:ccc:b0:43c:f87c:24d3 with SMTP id
 5b1f17b1804b1-43eb5c95779mr20181165e9.20.1743600974859; 
 Wed, 02 Apr 2025 06:36:14 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:1e67:7bcc:e97a:7477])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b66a991sm16928961f8f.49.2025.04.02.06.36.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 06:36:14 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/2] net-lwip: wget: add LMB and buffer checks
Date: Wed,  2 Apr 2025 15:35:55 +0200
Message-ID: <20250402133557.2079137-2-jerome.forissier@linaro.org>
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

Legacy NET wget invokes a store_block() function which performs buffer
validation (LMB, address wrapping). Do the same with NET_LWIP.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Suggested-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 net/lwip/wget.c | 48 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index 14f27d42998..51fe745f5cc 100644
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
@@ -201,11 +202,44 @@ static int parse_legacy_arg(char *arg, char *nurl, size_t rem)
 	return 0;
 }
 
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
+			printf("\nwget error: ");
+			printf("trying to overwrite reserved memory...\n");
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
@@ -214,18 +248,16 @@ static err_t httpc_recv_cb(void *arg, struct altcp_pcb *pcb, struct pbuf *pbuf,
 		ctx->start_time = get_timer(0);
 
 	for (buf = pbuf; buf; buf = buf->next) {
-		memcpy((void *)ctx->daddr, buf->payload, buf->len);
-		ctx->daddr += buf->len;
-		ctx->size += buf->len;
-		if (ctx->size - ctx->prevsize > PROGRESS_PRINT_STEP_BYTES) {
-			printf("#");
-			ctx->prevsize = ctx->size;
+		if (store_block(ctx, buf->payload, buf->len) < 0) {
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

