Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19460C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 21:56:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28F6481FC7;
	Fri, 14 Mar 2025 22:56:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sK+eQY23";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63EA282051; Fri, 14 Mar 2025 22:55:58 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E35581F0B
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 22:55:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-390fdaf2897so2302384f8f.0
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 14:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741989356; x=1742594156; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8vutLLp6mDmf9uD3PMZBJ8FR3riSioyMt/NxuHW024A=;
 b=sK+eQY23j2gkif8jkKLaEGzA/pNKc52eBVduPO3N/0PuRqfdMakc/Tt4fWHvzvaQYE
 g0fezAdX2QCPXQvnWhBl0DqcDQ+lMJ1XkyfPf0ie9SJPCZWCZCHWJDLeXHRXR5dOEFIC
 LC5DfocKFpYls0oxUPtq4RtGy7t91CcBEduerKIUAuJduuLiEO4ymM7CtOLzQIKk/n6l
 2P9zQI0JvlxW/uEGtqAbY5ggypzc65eSI7ZJuIamFd5R22mDymRZ/TD+P/FTy9c4zzV1
 sUer5SzDkB2mkQ8XMByDrb4QWTMFGXBo0+uq8jA3Voxsl1MKYLLP6mKAjKyNzP6pvtI1
 X+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741989356; x=1742594156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8vutLLp6mDmf9uD3PMZBJ8FR3riSioyMt/NxuHW024A=;
 b=XtlxMBkQV94WLZv8iqZnrDKouTZOP1PLKb3dUwquaXYtCH4WqueYmsiBIPlHJQZQSl
 j3bD9o0O8GFcyHabo75NFjA2cuZAIMWFrCo7xlnQ3Vp30nkhVXHXiqrx4wZ2Hc/XkacZ
 MH/ZudqTpYwBbodLScvyIDcIJMfVQh+7dy5dNgocoGlzj8A3ZN30ME+ELw7RjMCg3sMl
 ESg3C6MkQVI8s9Dr1rzJAW97E0px2etbZNUDE+sd/OF9h7x82vbOTgvx2pcV/nRxBV5M
 y7h2UuF47VlGtz88xiWUBCiLdLVcUDyQzUiHhH1rvG4rRCzm26XkZGO4LKWHA4//yUYz
 4aFw==
X-Gm-Message-State: AOJu0YwBhOskKmauLFrpeHI6NxF2BplnAQ+qWR5Cce0w5XYNEh2XXM2t
 fTMnAl0Ufqla61WlKV3B0xHLlGNasmPudBhhpoPo0TmnOHJMPbMXkKUyv6F+thCOUlMad4OsQXb
 3wHM=
X-Gm-Gg: ASbGncs+0IG8zKGZO9jXNF6wBAxSiALQJZLZZwo3z6s+lt/8vNC1PDVP27WhgNaRxCN
 Gv/YFQP4aTnZN87sJrQAhtdDzmXIvp0n+vxeh7gwlpVEuqWWFrD1RNOEUlsMmFQbblii8u2sIo+
 /X1hVBHU43UUH6pDD5EmPitlHMQ7mdbHS14CA5F9OBTNSVIh058IWQRpddBpJTK+za6RmjuLCQn
 VVoedh5+RmkhKgVtkpcABHxmkKvbzr1CA97qf2hEYFqslj6osGnS4Tfc4MaP34TcI0vpwUhOlCs
 e53zyxKifBZoFw4/+XeeXfEUHwD9LanDwXUNFC1mxBpaxftvaXxmgw==
X-Google-Smtp-Source: AGHT+IF/wgEptGFgRUpnDUsI3QRGrusoX72+gN96qQ7yLR29M6FVnweXZve686khkmMmHvdSn7ZFeA==
X-Received: by 2002:a5d:6d08:0:b0:391:4940:45c3 with SMTP id
 ffacd0b85a97d-39720e3c9bcmr6173583f8f.54.1741989355672; 
 Fri, 14 Mar 2025 14:55:55 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:5485:bb38:c353:6b0c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe05ff4sm29064395e9.10.2025.03.14.14.55.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 14:55:55 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/12] net: lwip: use timer_early_get_count() when
 CONFIG_SANDBOX_TIMER=y
Date: Fri, 14 Mar 2025 22:55:07 +0100
Message-ID: <20250314215525.579655-6-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314215525.579655-1-jerome.forissier@linaro.org>
References: <20250314215525.579655-1-jerome.forissier@linaro.org>
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
---
 net/lwip/net-lwip.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index 5d862e038a9..c20bdaf8086 100644
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

