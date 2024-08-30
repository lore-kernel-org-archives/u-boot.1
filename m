Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD28CA0EFB
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 10:18:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7CD288ABF;
	Fri, 30 Aug 2024 12:17:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bV0M8e+5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97F9888A7F; Fri, 30 Aug 2024 12:17:31 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA8E0889C3
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 12:17:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42bbbff40bbso3999895e9.2
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 03:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725013049; x=1725617849; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/iiygZqhsa2/rcZegQdrTNzQtquA4zWX6yxDfOnJ/8o=;
 b=bV0M8e+5tRmFIiiHDOdpfJ7Uubmt8po/m+GWxo5vPYT2uDYNnD/FS3z8oNguwSQlWI
 Fbj8Y6kVDV9prYovsFbu5/L2teg66Y3QX3a/D/DxgWWXAvqgEJ9mB15/x+Kkgct3CXB1
 J7uSfdL2ZtJYIXIu86Lsl+jYw2ddnnf8LHSMa5FJ8zneL6wOZ1kQNboF7k56s/xie5fY
 zUPLk+LjWbfxZTgtAjVYfNGCP6T0Yu1aRESYIVJclsFWN0z8EhWTH19NzuYnX9mClUFy
 TQ0Hqt9iXfy5OE4THuXwXA1stavzr16+3VwISxPe8/bhGPZCiOs5aJerhVt7my8yn5Sh
 6FQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725013049; x=1725617849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/iiygZqhsa2/rcZegQdrTNzQtquA4zWX6yxDfOnJ/8o=;
 b=v30YQRA5Pc6gdPAQ7MdMm3oT20be6KVYr9cHLCJdch1RKgd5rv3M3JVuUkfvFz5snS
 8Q1Uc2ZMGypa8zqIZwC9aqas9K6VaCHKjCWfi8xPASC10BnvJXFV3UOeo9a6mmgppbDz
 gbJF+PwUvznuWJWXgIeV6HLr6f3tq+EUxXHoPBaKjlZ/FY4azAc2vT29SprVC8D/S5jz
 oNDisUzsyyjZs8U+gHOIWvpmzMzJChpfIyQ3baEIzDzkvsVrdMHZ7avvZwdQM+A1fePo
 9Bh/eYoT1vHX9QV6gtzDzKaQDyFO45JdBsQ0AGsEZerlGN71dFetlduO5tjEyUT3mqTD
 t22Q==
X-Gm-Message-State: AOJu0YwR9qCuQ9nMw/ciVc6MDg3+KdYJRRQw634pMETyNvEd6J+trOAF
 oLPYpGBzjfB+WItRtDQ6vncTrNA8L+2RUU31pZC3IJqKCH3oKMo3e5mHjXjDv1xVJJKXCop8krz
 eb7rg4w==
X-Google-Smtp-Source: AGHT+IGbpW+OEcnbuw1C8iU0N1ozTe88IIbRzkBWghsG7ljfPpcc7MLDW7RW81v/o0d3ppymVradOQ==
X-Received: by 2002:a05:600c:35cf:b0:428:1799:35e3 with SMTP id
 5b1f17b1804b1-42bbb216871mr14436215e9.21.1725013048768; 
 Fri, 30 Aug 2024 03:17:28 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374b6a3d27fsm472728f8f.59.2024.08.30.03.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 03:17:28 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 05/16] arm: omap2: add missing #include <netdev.h>
Date: Fri, 30 Aug 2024 12:16:48 +0200
Message-Id: <880f3e793afdc93023e8c05bfe3ac9a7afd1a0a1.1725012294.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725012294.git.jerome.forissier@linaro.org>
References: <cover.1725012294.git.jerome.forissier@linaro.org>
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

emac.c implements cpu_eth_init() so it needs to pull the corresponding
header file.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/mach-omap2/omap3/emac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/omap3/emac.c b/arch/arm/mach-omap2/omap3/emac.c
index 7348e92cab..1e30a06361 100644
--- a/arch/arm/mach-omap2/omap3/emac.c
+++ b/arch/arm/mach-omap2/omap3/emac.c
@@ -9,6 +9,7 @@
 #include <net.h>
 #include <asm/io.h>
 #include <asm/arch/am35x_def.h>
+#include <netdev.h>
 
 /*
  * Initializes on-chip ethernet controllers.
-- 
2.40.1

