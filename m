Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 173CAC369A1
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 12:20:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14505836A9;
	Wed,  9 Apr 2025 14:20:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gq6dBjjb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80F5183061; Wed,  9 Apr 2025 14:20:33 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7871E835D8
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 14:20:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cf680d351so4211295e9.0
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 05:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744201231; x=1744806031; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ecr9mA8B/XT3q1WS1zIsHDSSDRS9fkSDgar2rILpkPA=;
 b=gq6dBjjbo6GN2Gb2GwDEHiv2czMNvB9xaj8AiY8lzBSNj4O2x6GNqSomSXNGRBnEKU
 UzzxlrZK2oDG8aUUGR4oMRYvao2c/Kr5AkVnH/xx8FGzaVimpQyJ2PCRxD1zo9X+IujM
 YUTaQ/tEq2X08O7aLXrvGXIZW+94gf6RshsZffNIeGTEImwwdmu3QmyMy4eK+eYColgQ
 V4v+8MSG4NPhiliwgPbOY3LxkMfXtWbKkUZyJK7Wum6KmzCzRLMFxgMljVn4YCge6o6x
 Zgm2StOP9h6AbFN7TNpB6hlzwXCI6qHSZKOzSd1dm9SbsA2wmM3AcKMmu9DlrGEJbYbC
 bAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744201231; x=1744806031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ecr9mA8B/XT3q1WS1zIsHDSSDRS9fkSDgar2rILpkPA=;
 b=f3M5rof0BJkRKDm3KxwYJYbikjEbwnDhBWfHx0jm7q/kL/Kn0ps0TNJn/XAx0uDfi/
 LBOe1mBOqBkcF9YHmg54ZWsGBlvEFBSdu/i5MW95j8ZxJtQ9myFQUp0vtvau88y8caAq
 AwnTwue7fQylzBSDLfPQHZE5NUjmS3pbZOLhqGUz23gAfDNe5eHbTN71nGoAEzNgzP0/
 Q8HvyNcZqt7DuHNCk6XSUeMkjS8JtVYa6+8LKFq1lqGD/BfpeYG7n63Y9ZbAs8eHxQYB
 zT11uAloEvCN4ikv2Qi21dFA8eh4n4+21ai1X6dR7w/CoH7eH0ML2NpxkAKcjCbZLIZE
 hhqw==
X-Gm-Message-State: AOJu0YzGbCunSWdg8Nk9XcDXa4cmNJFhPCE7uJeANG7jkdXRa5BP58Y6
 RNXzcgaLoGASVj9VDQCtZTNHoj2/pXE6Jp31HpOLOeHne2f0zAYdFG/V7jPYEisYNq5passX3XW
 XXNBVDwhF
X-Gm-Gg: ASbGncufSvVR/1plw2i5NRwHfKHi3HCPdNA5o86b5CM+W94OBBvwkn/WXC6zE1vhVHF
 7gWMPjte5/bYlDy9sphU2dKfVYksS/iab5dN/zVce/JZvBt8AkAGKB6HoabChQ/4dyRNKM1u00M
 XvKubj//149j/iN6e4RWpeQx7PgdrKWqD8En/GHdmf6XUxZIiVrCYXP1n+ZhHiGlXjqaOd2Veob
 0XEzU7D7XVVJGZq1oL3ebcl0kmWQ1P/zkk2iQLbQgzuCRE0O7JmKjyHqwhwkHu+Zd/oU0nXBTVU
 uyFbAKpeCgzuOYSEhuZYQ611iGTaYfDhWNOMifmS6EWedmNu
X-Google-Smtp-Source: AGHT+IGx8FOYkXAMnx1z4NAFYt2APXnoZGON8LrWrDcxz8JvNWVnuUyajs4Zvi7FhTahBQBisSxbHA==
X-Received: by 2002:a05:6000:40c8:b0:39c:1f02:44d8 with SMTP id
 ffacd0b85a97d-39d87e8057amr2095085f8f.4.1744201230479; 
 Wed, 09 Apr 2025 05:20:30 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:7528:8f22:ca44:64f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d89389f72sm1464169f8f.42.2025.04.09.05.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 05:20:30 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 1/2] net-lwip: wget: add LMB and buffer checks
Date: Wed,  9 Apr 2025 14:20:05 +0200
Message-ID: <20250409122007.2560668-2-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250409122007.2560668-1-jerome.forissier@linaro.org>
References: <20250409122007.2560668-1-jerome.forissier@linaro.org>
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
 net/lwip/wget.c | 49 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index 14f27d42998..746c8164d66 100644
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
@@ -214,18 +248,17 @@ static err_t httpc_recv_cb(void *arg, struct altcp_pcb *pcb, struct pbuf *pbuf,
 		ctx->start_time = get_timer(0);
 
 	for (buf = pbuf; buf; buf = buf->next) {
-		memcpy((void *)ctx->daddr, buf->payload, buf->len);
-		ctx->daddr += buf->len;
-		ctx->size += buf->len;
-		if (ctx->size - ctx->prevsize > PROGRESS_PRINT_STEP_BYTES) {
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

