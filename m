Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9231EC369C2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 13:28:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07C608303B;
	Thu, 17 Apr 2025 15:27:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YJbfr9GX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9C3782CA8; Thu, 17 Apr 2025 15:27:34 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3EE28303B
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 15:27:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-39c266c1389so565665f8f.1
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 06:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744896452; x=1745501252; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fAuMqpH5iZGzS2bdQo+tUVHECNwVltITZ8VKenT7qZw=;
 b=YJbfr9GXkDBW0Fsew3UADo7Nit6C3suY27wip4ahULWM+8ZrqB7WAXUH/IgEVYEYqj
 S02IaDZDDMHkjxGX+40d5XGLAqXT19nhScLjYr8EsTBXRolwerY5Vg6lQIT+GaLSCRDR
 IHm9JCk/W2hhXlr+kA5d2f4IE3/dXNhtEUJK0XmphbbfR4xX20nqy/zA1tilpyivuLB1
 Q2e9SduOUcwJ4egVPiVeb78CaA9dL/SsJRinmGo4eUuld6RqUeuTgp86Yl41P4dKnxCB
 OxnbLZ+nalQ525JhgWMOYAKNOnlAHlyNqTf9BrutxuMQmVKF3+qpcF4GfClP4muBAeXb
 7tCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744896452; x=1745501252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fAuMqpH5iZGzS2bdQo+tUVHECNwVltITZ8VKenT7qZw=;
 b=cSGWS692N30SeWd/Ld8qy65JC04CO660xdFqdbG/c/ekq4J4gmzVqj7X83eN2W9eXZ
 yGID/eaCKcGBA7D2sFKu2IBOBbpfQ4PEyDfpcRCrQYSa9LxYQ3JxIObQebiySQK4QmHY
 bJvLmbV1tGObjrpqkMNo37rLMa0XOMUvf0VaLXFTYVx9nTyhZR7Cr7Rbon953nnV6/0V
 0NBL2gvGNWhw/84UN3omOG6/Yyx6tdc4c4z90aM+V63GD9y3cBXxnD7gqqKr9qPXcGki
 vBmqus7b6SCiODp+bjVpsRt5XFinYz94WlPT1OE6dnp32cACIUbxLSnDJkFQueMqtroT
 t0Rg==
X-Gm-Message-State: AOJu0Yz8lHjxK7VsBWtEw+cno+F0/vUaazceL0VIombHNn+m8GGRPtkH
 2QmNpGFj1y1OmC8FxadT/UIy8e8P2a20LN8CdiZCjsm9DPTf0yW8KuljaZfiRN9mOJYjuhiQl2M
 gX3Q=
X-Gm-Gg: ASbGnctvtUo1T1SLMtngAuvVP7QLILQSPwy/shfJu0kVpPfBLJdUfBxIAnQEdPq8Z3d
 Ydk6gwLj9+qzICMzCrsWFria/o7bMXVoWhQpCV2Ir8Lun6mQ0SZ17pLUISrA2gQHDBgsdmUx/Hw
 ciaSCX+JqVAjKYTwrIHqNlwOHqaGYovqydgXYLztev9jfTaLZnSGZHvldrbOBC+j8d24+NbFmn/
 oA8z0DE6Udj/wRRSPpjv4CvbuHQ7vUO/SRngfvKGYfqOy03fk5mIkTo0kqZmhUBhf0yEIwP8kni
 k3uj7YJHVrTXDN7toY5JR3o1a1xEvjFfVO8oKBlHbOIc6CNrYXd9RpRSJ6Fx
X-Google-Smtp-Source: AGHT+IGNWSGhAx0arhlTigw2TW/RyHg4t5xhAj+GmJSxq+d2r1ipCI9kKqa6nJFOgz9aWKQHKpnqBQ==
X-Received: by 2002:a05:6000:2209:b0:391:39bd:a361 with SMTP id
 ffacd0b85a97d-39ee5b19f89mr4975308f8f.18.1744896452156; 
 Thu, 17 Apr 2025 06:27:32 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:a07e:3f08:7eef:b036])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae977513sm19951605f8f.42.2025.04.17.06.27.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 06:27:31 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 4/4] net-lwip: tftp: add LMB and buffer checks
Date: Thu, 17 Apr 2025 15:27:00 +0200
Message-ID: <20250417132718.2023555-5-jerome.forissier@linaro.org>
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

Legacy NET tftp invokes a store_block() function which performs buffer
validation (LMB, address wrapping). Do the same with NET_LWIP.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Suggested-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Acked-by: Sughosh Ganu <sughosh.ganu@linaro.org>
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

