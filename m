Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBB5C25B6B
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 18:36:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BEE087BD9;
	Thu, 26 Oct 2023 20:32:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PBoRS6aU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5BE287641; Thu, 26 Oct 2023 20:32:07 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C694D87B95
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 20:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-66cfd0b2d58so8364006d6.2
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 11:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698345123; x=1698949923; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g88hwTg6rmZDSMeVyHuCFrzIHNtM50KFsX9LSGw86RM=;
 b=PBoRS6aUROOj6E7xmHOFKBXpvdhrDTHusB6vQ9HVaVx4CEZJuu0rg6vTmBPnBbyPT7
 ieJHtQMpzOnCtdsp35Bck5jLrdD3Py8mWwEza9NU6Wq2HLUtAiaRtvq0jxas7GlMN87x
 ZAGgSGxaol7Bd4JIoHrd16t3us+qyH53igOyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698345123; x=1698949923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g88hwTg6rmZDSMeVyHuCFrzIHNtM50KFsX9LSGw86RM=;
 b=kEdvO1NUKoVVUOi5GEo0FqLRsesTkIMl1FFtBuUwb/+EceSKFfyN46topqInYPKS2R
 3iFDyNv59atzUYWTTPig2KdIjv4ojk3qyqhvYLUniyipMGT+F7P85kxTZTTMC0bSyxAg
 lkAbViUUAj2fo9rwPWrokXpwpzJY/zqSiJWxJjsxu3vh2SgdMx6mzWmW13VlpZ0EhDtX
 1VzAcvGE3h0Plb8/ykc14Vjk169fXiC763j0dKVV8WKO5k4jy6vQcjcHJ+RF5rqNSjRk
 2kpjucTPHrh74h7aRSsQnWWhDBBpFMsWY0zWbGCld+qzQ0IJ58NGpq+P9p8koLF1RdY/
 P6Fw==
X-Gm-Message-State: AOJu0YzTn2xANxduadxLmbD6B+z/iCQcXtLJWgDusHVFD6RHCKOxEytl
 QFGOyAg/0LrSFIE8VXNfhRepztX6EztF27SmKBia7g==
X-Google-Smtp-Source: AGHT+IHotleUnqsiv92ViroSpH/HcY2z3VthO1x/JZBjse5V7/yKpmSb4D5Q/eimG9Il9JLtLJsnsg==
X-Received: by 2002:a05:6214:508f:b0:66d:35be:e573 with SMTP id
 kk15-20020a056214508f00b0066d35bee573mr485131qvb.46.1698345123348; 
 Thu, 26 Oct 2023 11:32:03 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-6a0e-a72f-3fdd-31b7.res6.spectrum.com.
 [2603:6081:7b00:6400:6a0e:a72f:3fdd:31b7])
 by smtp.gmail.com with ESMTPSA id
 az39-20020a05620a172700b00777611164c5sm5175623qkb.106.2023.10.26.11.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 11:32:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>
Subject: [v5 28/30] clk_k210.c: Clean up how we handle nop
Date: Thu, 26 Oct 2023 14:31:36 -0400
Message-Id: <20231026183138.636948-28-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026183138.636948-1-trini@konsulko.com>
References: <20231026183138.636948-1-trini@konsulko.com>
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

Now that sandbox has <asm/barrier.h> and defines nop() there we should
include that in our driver for clarity and then remove our local nop()
from <k210/pll.h>.

Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Sean Anderson <seanga2@gmail.com>
---
Changes in v5:
- Add Sean's RB, drop explanation portion
---
 drivers/clk/clk_k210.c | 1 +
 include/k210/pll.h     | 3 ---
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/clk_k210.c b/drivers/clk/clk_k210.c
index c534cc07e092..b9469b93853b 100644
--- a/drivers/clk/clk_k210.c
+++ b/drivers/clk/clk_k210.c
@@ -16,6 +16,7 @@
 #include <dt-bindings/mfd/k210-sysctl.h>
 #include <k210/pll.h>
 #include <linux/bitfield.h>
+#include <asm/barrier.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/include/k210/pll.h b/include/k210/pll.h
index fd16a89cb203..175c47f6f233 100644
--- a/include/k210/pll.h
+++ b/include/k210/pll.h
@@ -16,9 +16,6 @@ struct k210_pll_config {
 #ifdef CONFIG_UNIT_TEST
 TEST_STATIC int k210_pll_calc_config(u32 rate, u32 rate_in,
 				     struct k210_pll_config *best);
-#ifndef nop
-#define nop()
-#endif
 
 #endif
 #endif /* K210_PLL_H */
-- 
2.34.1

