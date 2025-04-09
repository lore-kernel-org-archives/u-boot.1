Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274D1C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 12:20:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BA71836C5;
	Wed,  9 Apr 2025 14:20:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aaMH7ZtC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0E0C83061; Wed,  9 Apr 2025 14:20:34 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DF9A83677
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 14:20:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-399737f4fa4so3708550f8f.0
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 05:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744201231; x=1744806031; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gWEisPS6q2fBGe+ElLWhnrxim85hqSZmazy45tx2acE=;
 b=aaMH7ZtCwSTNpmvPqq2oiWMYE7LpYsgR2kAnur5/Hqc/L9IDDl5fptDtdh5R3uQ7K2
 1qrTyuqKdAzXDsnfLMxdWZelbELj5rI+ZobYH05Uk8EGsjtMz1aBadRrZBBShPcnP6oO
 u6blSFLpCGq5b1zl2e8Z2m7X3s+RnRP/BDKRC+OG8fEFGD9yVTN/Z1FQcDYGqmDa7k1b
 4Oci5nhq2kmw2jAkgrUhJzPihJtM9p0mF3tM1q+9nK7gBljfJjkCST4xSitigX3Gfh8z
 2KUNiMCV1Jdsfeu+y2qfylDEVGLXmd+RSSYDIU/4asSR19jLci7XUakomfMCKi3C+Ha1
 r15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744201231; x=1744806031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gWEisPS6q2fBGe+ElLWhnrxim85hqSZmazy45tx2acE=;
 b=v5oGquHPACrwmSvxdU/48dRwoEQ6r8Ricw41KOcb6HmiHUPUBqGPGwe4KhNG9+w8o2
 XqCntznPgsR+tG7paBOi+8FvSSUt36zueOgywGXKghTICzQFQuy4m/owqB6fITDAqCQo
 Yv1zhFQu5cdCGo7httkQkkfpNbrO+VkRr3GteCSIMlxmFY4ir01CrcYnMmAXCPCXQgLJ
 DVVmO60cWL/AvnGd0eLxMxzU/GU0kb6vCfISocJRpPAAzd69lI49Uo41xIXYMlmtnMJv
 0f54hBx/uQde1lrPponXhuLFAYekMu3lpxmcJQN0ng7iTlk1UE5VhTADJplQDa1tCmAz
 NTvQ==
X-Gm-Message-State: AOJu0YzM1bFEY9apHTqb5222PBjsj/RYllJoDGL/OGd2KAfCBgJoTTzQ
 CymHGmzZTCuYB+dMPfDbcWWEq0Tx09aGysZAJoCI5ZD3ff9TPpBG921NWsIxLEV+3nOLAS+68mk
 FerzezxLk
X-Gm-Gg: ASbGncsjkMYg9Z+iUj+KydSQAw2vRnXn0gZqV5CCThfI/zvU3nwdaKKGTTfc02k0OhC
 9LWVzic/q2HRP6NJYyRcZ4NoqI6PRKf0gDFmCHTT1tPYSqW79GgGD7sdd+kKlg9W8rpLOShE/th
 atWV3F9G1hB9GIA8Lx9FgoROGiLrNKG2sAt6A7ie/wSnGURyM2mM1t4ECXnHOT/dKpyEXFXxyPE
 7kmiR4vwkMvIY2S65RL0txtOtAuAIPIzc0JkTkQXNA6jusgEtq0wPZl/bdIm0gH7lhZtMDfeA/B
 bxdUTdh77IPvxaAPWRvQ9eI4Kv6W43y2dV4vIX18bXXKPx/s6NEKY7pHWlU=
X-Google-Smtp-Source: AGHT+IFsNztdzsS0A67wGYj1g3xGLd+SW0JXgt9wA9+m8UB406CA4OadwgXoNBt7WZAuSlsiuL06Aw==
X-Received: by 2002:a05:6000:1acd:b0:399:6d26:7752 with SMTP id
 ffacd0b85a97d-39d87cd0014mr2521287f8f.38.1744201231526; 
 Wed, 09 Apr 2025 05:20:31 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:7528:8f22:ca44:64f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d89389f72sm1464169f8f.42.2025.04.09.05.20.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 05:20:31 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/2] net-lwip: tftp: add LMB and buffer checks
Date: Wed,  9 Apr 2025 14:20:06 +0200
Message-ID: <20250409122007.2560668-3-jerome.forissier@linaro.org>
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

