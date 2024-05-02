Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A1DC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:32:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F061688BD9;
	Thu,  2 May 2024 03:31:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="offo1dQ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF5BC88BDD; Thu,  2 May 2024 03:31:46 +0200 (CEST)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0BAB88B93
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:31:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-de60380c04aso4165715276.2
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613503; x=1715218303; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BDSjKB3c9xGVuAza+RZInZufp3/1JopnaYhAVATeZa8=;
 b=offo1dQ+0IO7qck3nhsbuxhQ7w7toHmclKK2CSrGBQ3p6sykSTHq4IKTHL6Pv/qIoL
 cH4+pUOqTO1SMT1Pca0JLLlhmWAHN3m3cAFm/yxrhQ6KMH+76bVTvuMVNwRpFdtQ2Aev
 UGLNktslqN6HdLXyKkf97EVKHwk2nYdCHjftg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613503; x=1715218303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BDSjKB3c9xGVuAza+RZInZufp3/1JopnaYhAVATeZa8=;
 b=YdLHfje1pCmiEPq6OyWfYXiFZB747zlp7DIWwiLnyvq/8mmmjvXTuHfHkRrzeOb8yK
 RuhNUYBYwsY4waNeukmWmFLihURYV1qA2oDMmUqgESax9TfXUfK3Jo/zkwhIG7l4Jtpa
 yB32RqHfxiwQohsIrjHXitfmYN+rPGHvunONtRcUXXp+CDPdgL0mGYL/w0ARvKAIrxzI
 z8yGCIU6uMKNNSIujaGWJSNlHcC2DAmiAndUyT8NV1i3NOp1r2nXq9+8I3HyfB2VgzaC
 /TqAFScVUg1Rt1mZS1BGKQUT8dtTu2fXDJ+Q06qHYn1Ouo9B+ZHXGGNV0lPET5rmcbuu
 Y1zw==
X-Gm-Message-State: AOJu0Yxy0Jr69L2H4TFnjqMTFr2cYcaY679pyLmV+9htlCEIjFiWGFsR
 qISeT8n5x4zVgYSrh742ORfUeBHVOMpBGDUqvRvPGp6LLfqMobSWkMm5qkoon+z4AU0JEgfeO7x
 GHGOd/KFQ
X-Google-Smtp-Source: AGHT+IEZWLs4DRKF+N6XFDYpK1OvjBiRp/Xf1WiyPk62KNMaO19EpTc5pc11deSn76HwpbRzArkrtA==
X-Received: by 2002:a25:9181:0:b0:de6:4ff:3164 with SMTP id
 w1-20020a259181000000b00de604ff3164mr4858251ybl.36.1714613503178; 
 Wed, 01 May 2024 18:31:43 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:31:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>
Subject: [PATCH 02/81] arm: aspeed: Add missing <linux/types.h>
Date: Wed,  1 May 2024 19:30:19 -0600
Message-Id: <20240502013138.2383421-2-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502013138.2383421-1-trini@konsulko.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
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

The scu* files have many "Linux" style types in them, add
<linux/types.h>

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>
Cc: Joel Stanley <joel@jms.id.au>
---
 arch/arm/include/asm/arch-aspeed/scu_ast2500.h | 1 +
 arch/arm/include/asm/arch-aspeed/scu_ast2600.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/include/asm/arch-aspeed/scu_ast2500.h b/arch/arm/include/asm/arch-aspeed/scu_ast2500.h
index 50d6a6bc7605..a415693de6ea 100644
--- a/arch/arm/include/asm/arch-aspeed/scu_ast2500.h
+++ b/arch/arm/include/asm/arch-aspeed/scu_ast2500.h
@@ -140,6 +140,7 @@
 #define SCU_CLKDUTY_RGMII2TXCK_MASK	(0x7f << SCU_CLKDUTY_RGMII2TXCK_SHIFT)
 
 #ifndef __ASSEMBLY__
+#include <linux/types.h>
 
 struct ast2500_clk_priv {
 	struct ast2500_scu *scu;
diff --git a/arch/arm/include/asm/arch-aspeed/scu_ast2600.h b/arch/arm/include/asm/arch-aspeed/scu_ast2600.h
index 251bfa269bf4..a2c8852db842 100644
--- a/arch/arm/include/asm/arch-aspeed/scu_ast2600.h
+++ b/arch/arm/include/asm/arch-aspeed/scu_ast2600.h
@@ -125,6 +125,8 @@
 #define SCU_MISC_CTRL1_UART5_DIV		BIT(12)
 
 #ifndef __ASSEMBLY__
+#include <linux/types.h>
+
 struct ast2600_scu {
 	uint32_t prot_key1;		/* 0x000 */
 	uint32_t chip_id1;		/* 0x004 */
-- 
2.34.1

