Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75404C369B8
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 21:19:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD9FC82B97;
	Tue, 15 Apr 2025 23:18:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Fgha74XX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 248AA82B97; Tue, 15 Apr 2025 23:18:35 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BABF808AF
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 23:18:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39c1efbefc6so3665698f8f.1
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 14:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744751912; x=1745356712; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BMFSo5rTzMOkXMbVrWRVb8mV2yauGRyvMKAne1KLBYI=;
 b=Fgha74XXfNg8T/6uzm7I7yohzqGtMTGmsinCM7d1bRro1ySiyVAoFaGJNDIlL/eFi6
 +TcDEEH86hXsveXaYJMUfHPWYF322K3HRxF809VLaI0voDlgVL4Fh7jaicIwcN/Fnt2A
 n456LJsu2l53w+GUYXb1OST2o7dLVGWRxDqblZ5Oc61f//G78RnpFSTj3TcOCuRJDuLg
 PDpAH0NGXJyFpr8zJzXQnQyLP0Nsmsu2FH+azgoH50saDnRPY3B6AHKOardhgCUtfITt
 b0g6vVd1r1rSrrbpj0ssP1W+a7zstAticgcBzuPusSSCJm10Aev84foZMi2zBKEMK7TW
 2hrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744751912; x=1745356712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BMFSo5rTzMOkXMbVrWRVb8mV2yauGRyvMKAne1KLBYI=;
 b=i/n7rBWNE4TrymCP6Lo1szHgy0aj2yOu3i7HLlPiGkUG05irT4yaSzkWjzu50vR4CG
 9JL9FYOCtPdo4nn2OP6hQGHFIFtIhGFFWc0g0LQZoDlbBnHE3+y5+VYfdAN9MX7LN0zm
 KY4YpxX62DLVkBA3Oo0kbq1FxAp9kPy0knOin11u9wQFrsqCpy5altwiZVuhwoMymtA+
 Csz49pwUmPfdFRGMfYCi2cPyJbNzCIPooAR4d9zv51LJHhoOCBOsG5r5xZoXXKUFQJqs
 OsIcT/zHre5C7cYc5II8CQQf1uME7Zn9+mnTNr4aAgF0qTT1JifDqeG57Q3GCLUzrpwW
 b6rg==
X-Gm-Message-State: AOJu0YwED5ulIZp8aYPrUPe/IXFNCcI1JXQzc8jvCKNZXjjwE9sPPuvl
 koMcNk5K6bvhX9tz4TlTttdkyNzgSCIuCfzlyUB8OUbo/x4xVwJtFoJKCkRcd3T23r2guMqngxq
 bU34=
X-Gm-Gg: ASbGnculFttrEaNT+9YVrcpdRTlgOVUcH4gymIFmWgk638tyImyB2Et7r3ee5//xoew
 p3KENjzQ080aK0UqC2ru4teOQAh0OEzgXKeXGnlD/c9wn+jlLnQtikiehcOXbghi9yCZMBCAGCr
 jWy6bRWclA/vh7pwyN5p5daOKpj0kt4hPw5CTfcBvW5O8Jaith0A2JpiOSY2QoDkKVXxJpxPpVq
 gNLnOIlCVMTJSjWF7g6hr1TNCABRiSnIo7nl71k3/MMGKFBZQDrPhWrJyHDNO4U+3zHO1UgQJFX
 aj+YZ11GWzAp+lVv/ImfT/8l8t2OmTpWlxBmzGpelTfv05rX
X-Google-Smtp-Source: AGHT+IFyKkreboc4quJMTgmp4lbtSGnJv5tbFtUBVBXVlYYoKdxjS52FUja5aVwG5v359wVioGdHzw==
X-Received: by 2002:a5d:598e:0:b0:39c:12ce:1054 with SMTP id
 ffacd0b85a97d-39ee2737d2amr783938f8f.8.1744751912448; 
 Tue, 15 Apr 2025 14:18:32 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6ebc:6ce:770e:95f9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf43cce3sm15530917f8f.74.2025.04.15.14.18.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 14:18:32 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 04/11] net: lwip: use timer_early_get_count() when
 CONFIG_SANDBOX_TIMER=y
Date: Tue, 15 Apr 2025 23:17:39 +0200
Message-ID: <20250415211819.1254435-5-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415211819.1254435-1-jerome.forissier@linaro.org>
References: <20250415211819.1254435-1-jerome.forissier@linaro.org>
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

When the sandbox timer is available, use it. This allows skipping
time in the tests (sandbox_eth_skip_timeout()).

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 net/lwip/net-lwip.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index d566f9f8e6b..f05c4cd3f64 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -14,6 +14,7 @@
 #include <lwip/init.h>
 #include <lwip/prot/etharp.h>
 #include <net.h>
+#include <timer.h>
 
 /* xx:xx:xx:xx:xx:xx\0 */
 #define MAC_ADDR_STRLEN 18
@@ -339,7 +340,11 @@ int net_loop(enum proto_t protocol)
 
 u32_t sys_now(void)
 {
+#if CONFIG_IS_ENABLED(SANDBOX_TIMER)
+	return timer_early_get_count();
+#else
 	return get_timer(0);
+#endif
 }
 
 int net_start_again(void)
-- 
2.43.0

