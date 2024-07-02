Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B861C3064D
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 10:26:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 527AA88495;
	Tue,  2 Jul 2024 12:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mCavL2WV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 678B98824C; Tue,  2 Jul 2024 12:26:24 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C6138824C
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 12:26:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a724cd0e9c2so404889666b.3
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 03:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1719915982; x=1720520782;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5cqSYj+CjsXbHNn2F7LbkjKwjHh71ZZUgZg1g4T2Q38=;
 b=mCavL2WV/cm2NnzeAiPVkRdHdAfZby9PXZxsUnW+8ZDseZ2F2Z4KzjNsoJukVwq3l/
 ImevqhYj7pLUMa4Q8KO7YbnBOVwJLJZhvbp+5WKdhkwuLQiW903Ru+swCTU9RhajTsb2
 WRBox7RI7Eq+ZBMBkfvTgnivEI9awp6VXRbUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719915982; x=1720520782;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5cqSYj+CjsXbHNn2F7LbkjKwjHh71ZZUgZg1g4T2Q38=;
 b=sZOdCPbHAEhbZCI3Ik94pRCBy5uc5tv1uL07/9xvajmPFZ6KWfbxCz+kFaTumoHVWp
 IizBY8+wFog+KkGGWLc7MBcru5/HQDc69AQdvngi/pB9NPDGi6xgzlC4MdWsyLpgFQJy
 fiTiMpj3gaz81Jfv4lBonJw7rOJaueciO97UnLZ9EqFClHsvmrg7r9vVsUUWt9CqQDFA
 I/Esr9yIEDceUV8RR43qbsPmD7hJmZE7uHNt/D625Yw5oTiKkKjGTPzLy9Go4l+INUD4
 rTZ1Ha+9DAm6DZUDDPmf1NioZmiUrgo/YEy++Fj1s7VLwthYHWJLJdRcOPMO8HLLJAtD
 K9kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8N7y+YmQXOAEDxo4lp8gAMDJPjDCMqjdtU/RZayz+BQlq2hf1bxIDgWDFpChdO1qIiRP5m5IDpQwZGEf+k/s5wacoDA==
X-Gm-Message-State: AOJu0Yzq35twtfvqjmIWZvuyTeI2Yft0u1HMz5B/3rkD6oqNrhw7cDgi
 il3Fw/uFlXlwWhRx1LenHPKQXkCjkUc9DWbEGVBWBs5KLDW8Y1tEfgGqyLBL1eQ=
X-Google-Smtp-Source: AGHT+IHmdOAzRRiLsSWEhH9mkZkbyWZs3UB/6dB6ZhzSdgSh1KHqfpBMGnj0Ke05BKm09YywqANd2w==
X-Received: by 2002:a17:906:1b10:b0:a72:8f73:a95a with SMTP id
 a640c23a62f3a-a75144b8824mr471498266b.65.1719915981680; 
 Tue, 02 Jul 2024 03:26:21 -0700 (PDT)
Received: from panicking.. ([2001:b07:6474:ebbf:8e6e:944f:275e:2a97])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ae84b3d8sm391253066b.121.2024.07.02.03.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 03:26:21 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: Lukasz Majewski <lukma@denx.de>,
	Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, linux-amarula@amarulasolutions.com,
 u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH 1/2] clk: imx: Fix wrong flags assignment clk-composite-8m
Date: Tue,  2 Jul 2024 12:26:17 +0200
Message-ID: <20240702102618.466652-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
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

The mux flags (u8), div flags (u8), and gate flags (u8)  are not the clk
flags (unsigned long). They have different meanings

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 drivers/clk/imx/clk-composite-8m.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
index 494156751da..560d74aac80 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -135,7 +135,6 @@ struct clk *imx8m_clk_composite_flags(const char *name,
 	mux->shift = PCG_PCS_SHIFT;
 	mux->mask = PCG_PCS_MASK;
 	mux->num_parents = num_parents;
-	mux->flags = flags;
 	mux->parent_names = parent_names;
 
 	div = kzalloc(sizeof(*div), GFP_KERNEL);
@@ -145,7 +144,7 @@ struct clk *imx8m_clk_composite_flags(const char *name,
 	div->reg = reg;
 	div->shift = PCG_PREDIV_SHIFT;
 	div->width = PCG_PREDIV_WIDTH;
-	div->flags = CLK_DIVIDER_ROUND_CLOSEST | flags;
+	div->flags = CLK_DIVIDER_ROUND_CLOSEST;
 
 	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
 	if (!gate)
@@ -153,7 +152,6 @@ struct clk *imx8m_clk_composite_flags(const char *name,
 
 	gate->reg = reg;
 	gate->bit_idx = PCG_CGC_SHIFT;
-	gate->flags = flags;
 
 	clk = clk_register_composite(NULL, name,
 				     parent_names, num_parents,
-- 
2.43.0

