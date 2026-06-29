Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8075C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 19:24:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F6B084AB3;
	Mon, 29 Jun 2026 21:23:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NLqLymg2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C3D384AB3; Mon, 29 Jun 2026 21:23:50 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9B6C84A92
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 21:23:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andreas.zdziarstek@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-493a7bd27c2so14910245e9.3
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 12:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782761026; x=1783365826; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CHaI/tqqREe47a7Q47dEK1sWWeF7ypGS8ImD27EHe3w=;
 b=NLqLymg2VlQYfRaNi8jQJOq8P31LpjTqySNxCTTRn9bo4xbyDcHRUQhTLrMTtkd1w2
 JfVvVsTv4SIysLbG01+ZJ/6Ah4mg3Ap6bHtE6h03N2fAsm1c49A75sVPUEPKHWPc5Va3
 DweqDqmtSg9XfY1nYiPPftWSvV9UFbESt4gr/V2tz9D8roRiWBGN+PuJWzN5JkidgnGB
 7fUrRiL6Kal0Mdh5s70qzV7laT7EcY92751p8U8EAe164PKx+XFCE2+Kn1cqEzKnOrNr
 vbC7o1iZd1EBkk0AG0eGd0WROsomrxMnmL61oT7ZREceDCeRwCcab1ZMrn8BeBTxyGZY
 7kng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782761026; x=1783365826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CHaI/tqqREe47a7Q47dEK1sWWeF7ypGS8ImD27EHe3w=;
 b=OOIj0JYd6P77Cf3HzNDiw7vparZjSZ9KUjGCygEogeoYwB1+3qUc+hy6hXGxZkSFUH
 XhULnHAFhdngXovhLCp2H/gaidT/22o8M6LLN23Okwfs+FBZafxuwyk+dGVE3GJA8wGS
 AxElfjyKefzSyCuocL/L9dRMvlCOWlSmA5QOv7BGslyf5p48qrizDUAhGEHCpS82rpWb
 hG+tod5RUjGTBXNqj1ZRRgj0jeL3H0yj+lGVU0KM/vmahCG6FGfX4rJTdolJPfUh0+tV
 5h6fJTXD2OF5T6B86nYwfuFIEEjU+4vSCW1yyUMVWScHH75Yp9Iz/TxZ2Fr8Wn7RjRez
 /scg==
X-Gm-Message-State: AOJu0Ywt0D8Sw+pM0xpt33pUOVgdY/WjyjSvzeJhNONE64HBVs7LTD4Z
 Wt7zRSLLcEoup6VYbfa1OiyINPJimBK4DP3C9MxGXKeMA0rwPKbZZ7RzthgIo2w8
X-Gm-Gg: AfdE7clGWdwROQJK3IWAunlqkgwbEkf+gxNLJnEocwmBPCxhubWeBfPGksCPBtKpHBd
 7fEP4XC11t7ztwW1Zs6REzdljkIoIihP1BrJeHCchU92eeJFKDjnzyJQkEFFRPsOanY07Uby4Lc
 yHuNZIku8qNaTqESApcW7Ya8IRAt2oiNp69gFkNRa6wpG9m8x7K6HFYO54KE3KMxKVeMOodpPqh
 J1BQVS30Ms+LX3dRcXNUw6MqZuX33drNu7fI1f7o1PcByfv+9U2PCuRu3srG6YJ1IxobOuUiqFO
 mCMsGrJZluA8/T1qDsFPDE9wZAIlbPB6iNr3dyuLtnPzA9d3aUNzcnkKmyOiEfPmUcOe0W1aBk6
 WHa0UH8q160kG2R2OddcMJPqsS5dqIBfHXZ6lUWIgBHDu6xmvD9vMA7VdhEq3jACgSLM01le51r
 xpu2Mf57jl/6kqUk+5f2kO2j4HL9aBAYQY9ssU7JNrHA0yzB459uYfEBpZx0HKEeU=
X-Received: by 2002:a05:600c:698d:b0:493:b8d9:f28b with SMTP id
 5b1f17b1804b1-493b8d9f306mr7677555e9.23.1782761026025; 
 Mon, 29 Jun 2026 12:23:46 -0700 (PDT)
Received: from turbine.fritz.box (p5784ea85.dip0.t-ipconnect.de.
 [87.132.234.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493b8ca8b1csm8734785e9.9.2026.06.29.12.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 12:23:45 -0700 (PDT)
From: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, jonas@kwiboo.se, quentin.schulz@cherry.de,
 Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
Subject: [PATCH v4 2/4] rockchip: rk3568: make the TSADC trigger a first
 global reset
Date: Mon, 29 Jun 2026 21:23:34 +0200
Message-ID: <20260629192336.1555651-3-andreas.zdziarstek@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260629192336.1555651-1-andreas.zdziarstek@gmail.com>
References: <20260629192336.1555651-1-andreas.zdziarstek@gmail.com>
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

Same rationale as the watchdog: the default second global reset leaves
the SoC hung. Set the TSADC to the first global reset as well, so a
thermal shutdown reliably resets the whole SoC.

Signed-off-by: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
---
 arch/arm/mach-rockchip/rk3568/rk3568.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3568/rk3568.c b/arch/arm/mach-rockchip/rk3568/rk3568.c
index 8bed529a5c1..5e6f79450db 100644
--- a/arch/arm/mach-rockchip/rk3568/rk3568.c
+++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
@@ -40,6 +40,7 @@
 
 #define CRU_BASE		0xfdd20000
 #define WDT_GLB_SRST_CTRL	BIT(1)
+#define TSADC_GLB_SRST_CTRL	BIT(0)
 
 /* PMU_GRF_GPIO0D_IOMUX_L */
 enum {
@@ -152,8 +153,9 @@ int arch_cpu_init(void)
 	writel((PMU_PD_VO_DWN_ENA << 16),
 	       PMU_BASE_ADDR + PMU_PWR_GATE_SFTCON);
 
-	/* Make WDT trigger a first global reset */
-	setbits_le32(&cru->glb_rst_con, WDT_GLB_SRST_CTRL);
+	/* Make WDT and TSADC trigger a first global reset */
+	setbits_le32(&cru->glb_rst_con,
+		     WDT_GLB_SRST_CTRL | TSADC_GLB_SRST_CTRL);
 #endif
 	return 0;
 }
-- 
2.53.0

