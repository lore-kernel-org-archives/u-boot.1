Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6AC3C28B2F
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 19:01:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E19A081FBB;
	Fri, 14 Mar 2025 20:00:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jhrg6xIg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0C5B81FAB; Fri, 14 Mar 2025 20:00:27 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FD9F81F66
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 20:00:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4394a823036so669865e9.0
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 12:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741978824; x=1742583624; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gz7xVo25ZniNVv/AIkklTHPTasntSVjmcAGICMQmdxo=;
 b=Jhrg6xIgiHm/6LQH3tlSC47jz/gHJix+XfAzlNohHrnnniNjN0kLTOkeGUP0cAc+Eq
 rfr4QluW86LfSk+vzs6PqxIPtt4zB4dMbHR4A5mR5om/b8EjeAwxNlyXQBO+CPOaIVGx
 3EWsYFsdkFsyIX3oJ6gvfTFACL+OddYzIhcbjSQA7J22YfmPb+HyM3ZtOdyxwNyM+/6O
 6VWg2tlN1poVIIFv1A8VfGDNlkYsMmDZ20YjmfsUZZqyQ41/YHadK58db/F3T7UKCI1B
 SS2cWqEyrHSIobOtCQnwPOd4uYWdtWhNQURZLGHKc1t0dDo/Smy6RGFsj0zYY2WcCDCW
 kNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741978824; x=1742583624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gz7xVo25ZniNVv/AIkklTHPTasntSVjmcAGICMQmdxo=;
 b=o96jgfrmybhKVgpZf8x/YIAekBlNhQlXx7cIAOw3tZgc6iLM+eZCvwxYZBixANHM5E
 ini8iGRDI54xBCWcxpYkfT9+cWDALT2mn5HqDlBiA4MuNsUr3P/ZEKJmIfLBTpBnAYoS
 Cq9lEn9MPpTkUo/mh1B5wEfAESvUa9ySFtoEkMjPor81jXOL2EDreyse3oUcEUMhJy2i
 /h8pGRawFpFZ4CbrP0cJS1eyM3oz8lgNlmfEmxQDNO3QTzjLdJTscmVKHYlAx3DLzZw6
 DhuN/Q78SKTdqC9Zm5f191XsGlo6pgFnFgzmOFG1UiWlxgECIzwdFZxMyazb/xbwlbG1
 QMRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQFbnBWOLMkiZr0YFxqyNYuKXBCYlLht6sKS47qHHtD8m2ylXYkLgJuHMa6CuwmOjnjuQgKbI=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6TO6FFT3twvGuYtOUorXvcA9geZTCJhaAh7D1vG00LV1N8lPg
 w5MLPIMs9LrCPeJUYOMEmpumC8kXwmLbaN2ZR1lRxUKYYM+KfdQM
X-Gm-Gg: ASbGnctZwqE6kaQig7+Q5SDLqip/lSUPMV/lilARLAtgGc4C/yrW+Yu5+PWS54ctcsZ
 aKjl0onsL7buuFpVU0XuTYaf4XzhjGsQ3cjOfueXwhPewvNXwsacKwacYODfxckq1JNCX63xXKn
 f+larfOGsKveRlZN1VDqk8zl9QOfXN/Dwub/Y336ygX0WNx7O1PsMt6KJsUlZgOzL8mxMLbav39
 +I/IYcFYM/Nw7nGyO9iGURwUAKKl/Snv4FpmBq/UpfS5x6Vn2x4OlDpLL5cHeVQXG6l4DwKXH8N
 rTLov9OOuML7i1ymxqkIIlPIpY2hXm1I9jubPm/lKd1xFOSoGiRkbWa1qmNundsMedRoY94Savm
 XXNvesjshfLeQSA==
X-Google-Smtp-Source: AGHT+IGhMQ0ETB2DJb+sJETrdFwtw7Z/uFef+Bohle2dReYLWAnyejElRsVoR8v/s8c4+XC+stYO9A==
X-Received: by 2002:a05:6000:1ac6:b0:391:4873:7935 with SMTP id
 ffacd0b85a97d-3971d80285dmr4090438f8f.28.1741978823662; 
 Fri, 14 Mar 2025 12:00:23 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it.
 [93.34.90.129]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43d1ffc3e67sm25547965e9.17.2025.03.14.12.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 12:00:23 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor.dooley@microchip.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2 6/6] dt-bindings: clock: add ID for eMMC for EN7581
Date: Fri, 14 Mar 2025 19:59:26 +0100
Message-ID: <20250314185941.27834-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314185941.27834-1-ansuelsmth@gmail.com>
References: <20250314185941.27834-1-ansuelsmth@gmail.com>
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

Add ID for eMMC for EN7581. This is to control clock selection of eMMC
between 200MHz and 150MHz.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20250113231030.6735-4-ansuelsmth@gmail.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>

[ upstream commit: 82108ad3285f58f314ad41398f44017c7dbe44de ]
---
 dts/upstream/include/dt-bindings/clock/en7523-clk.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/dts/upstream/include/dt-bindings/clock/en7523-clk.h b/dts/upstream/include/dt-bindings/clock/en7523-clk.h
index 28e56745ccf..edfa64045f5 100644
--- a/dts/upstream/include/dt-bindings/clock/en7523-clk.h
+++ b/dts/upstream/include/dt-bindings/clock/en7523-clk.h
@@ -12,4 +12,6 @@
 #define EN7523_CLK_CRYPTO	6
 #define EN7523_CLK_PCIE		7
 
+#define EN7581_CLK_EMMC		8
+
 #endif /* _DT_BINDINGS_CLOCK_AIROHA_EN7523_H_ */
-- 
2.48.1

