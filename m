Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F5D6C3DA7F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 19:56:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 343BF88C3D;
	Fri,  2 Aug 2024 21:56:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VJNcQA69";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA88D88BE4; Fri,  2 Aug 2024 21:56:36 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42AEA88C16
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 21:56:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-427fc97a88cso58351135e9.0
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 12:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722628594; x=1723233394; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=42Ttjhnqvu+VUpByPnMFgSJgZY+SKsiQu28HON6IhxQ=;
 b=VJNcQA69UBTUOCQR6VW6NwLkAVnxFcqlSeZLaJxhm6apCWHhvLrDjGjD/ijzPi0MXM
 ivboKFTIcOTI5b3TwA5H/G65uHLVrTpdcOVrSyOhiPQCWCYePlMG68g9UoUr4LNSWm1g
 oNOSYX+Iqiuz7hCGy7qV5s+3vsO357uWtExChfCCGm2IJM+3qj1UBnC+MU2GV255UlAe
 WhQuhwfk2f6pq4lL8Ld0Pw5+Xkc1t/VL9vDvDsNhk2R2UM+0CRQi4WbBSjZPD0wzEd1d
 STu1vBb1ltvWPgTR7N8lyOrv/C3F8T6KD63FJKFyCrfVvSfQaFCyEh4vJQ4MrD6BwAEr
 dlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722628594; x=1723233394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=42Ttjhnqvu+VUpByPnMFgSJgZY+SKsiQu28HON6IhxQ=;
 b=qk+jrwFaT2o3FZIAz7AKM0FMLHqaCk/wUtCe5cjhXr5d+xp8Tt8p6uRZBtwIQaSaXF
 kpcGAa0qBnjhIk+aO9Dbqh9S9qZEE4QfiX/WpVZe6CUf0AhJUmDwYAjtFlrUHj5HDN08
 Ka+i5XenLWEQRUQd2sj8Bb1PcGjbOKHbJb50d+8VSd4zloh0smJPe7c0amXKKqlbC8un
 P1+c+o9TYNDbBd05ovbeUrspGGGKtFRcdjwcWUfg/ue9Gs6x5ZvI8CYX2SQJNZ6AKSIQ
 uGqjIqlvbaeIbf5ogJLQD9YssroQ51GjM0VP46FdjD+9sV658QZQ+pT0QzN15k8wZiWI
 V1LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWrGisUqv0E9LB6p+FnxmPt//nLyMWlsT9FuJtDC7C0ttykBoLP9T9D1TSlOGqQJ5TVqbHVOkyt/qKfN6CXVzLSkc4wQ==
X-Gm-Message-State: AOJu0Yxq3i434HuyKkyK+OZlSkqxQQNkgsZBURIPee6s5OKnyeL0LO4J
 FTgUx1P0y7LrqO/6owc0oxYtomcswdrP0YVqyS9F2MRXIzTpg+xr
X-Google-Smtp-Source: AGHT+IFOTPzGBEqRB4gCeH6npco/GK6C+5QGCuEcc7g2e4QyhwdT1yilqJPlqTCTk7xe9SS3al1Rag==
X-Received: by 2002:a05:600c:4f0c:b0:426:6099:6eaa with SMTP id
 5b1f17b1804b1-428e6b7c61emr30077865e9.26.1722628593606; 
 Fri, 02 Aug 2024 12:56:33 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-428e6e01d0asm43350485e9.16.2024.08.02.12.56.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 12:56:33 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Crispin John <john@phrozen.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Sam Shih <sam.shih@mediatek.com>,
 u-boot@lists.denx.de
Subject: [PATCH 02/14] clk: mediatek: mt7981: fix typo for infra_i2c0_ck
Date: Fri,  2 Aug 2024 15:53:03 +0200
Message-ID: <20240802135326.25303-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802135326.25303-1-ansuelsmth@gmail.com>
References: <20240802135326.25303-1-ansuelsmth@gmail.com>
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

Fix a typo for infra_i2c0_ck where 0 was misspelled as O.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/mt7981.dtsi               | 2 +-
 drivers/clk/mediatek/clk-mt7981.c      | 2 +-
 include/dt-bindings/clock/mt7981-clk.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/mt7981.dtsi b/arch/arm/dts/mt7981.dtsi
index 7aaa7770f83..1056667ba65 100644
--- a/arch/arm/dts/mt7981.dtsi
+++ b/arch/arm/dts/mt7981.dtsi
@@ -158,7 +158,7 @@
 		      <0x10217080 0x80>;
 		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
 		clock-div = <1>;
-		clocks = <&infracfg_ao CK_INFRA_I2CO_CK>,
+		clocks = <&infracfg_ao CK_INFRA_I2C0_CK>,
 			 <&infracfg_ao CK_INFRA_AP_DMA_CK>;
 		clock-names = "main", "dma";
 		#address-cells = <1>;
diff --git a/drivers/clk/mediatek/clk-mt7981.c b/drivers/clk/mediatek/clk-mt7981.c
index 7a699162421..69d018b817a 100644
--- a/drivers/clk/mediatek/clk-mt7981.c
+++ b/drivers/clk/mediatek/clk-mt7981.c
@@ -474,7 +474,7 @@ static const struct mtk_gate infracfg_ao_gates[] = {
 	GATE_INFRA0(CK_INFRA_SEJ_CK, "infra_sej", CK_INFRA_66M_MCK, 24),
 	GATE_INFRA0(CK_INFRA_SEJ_13M_CK, "infra_sej_13m", CK_INFRA_CK_F26M, 25),
 	GATE_INFRA1(CK_INFRA_THERM_CK, "infra_therm", CK_INFRA_CK_F26M, 0),
-	GATE_INFRA1(CK_INFRA_I2CO_CK, "infra_i2co", CK_INFRA_I2CS_CK, 1),
+	GATE_INFRA1(CK_INFRA_I2C0_CK, "infra_i2c0", CK_INFRA_I2CS_CK, 1),
 	GATE_INFRA1(CK_INFRA_UART0_CK, "infra_uart0", CK_INFRA_MUX_UART0, 2),
 	GATE_INFRA1(CK_INFRA_UART1_CK, "infra_uart1", CK_INFRA_MUX_UART1, 3),
 	GATE_INFRA1(CK_INFRA_UART2_CK, "infra_uart2", CK_INFRA_MUX_UART2, 4),
diff --git a/include/dt-bindings/clock/mt7981-clk.h b/include/dt-bindings/clock/mt7981-clk.h
index 1c2781cd765..2dae6766ac3 100644
--- a/include/dt-bindings/clock/mt7981-clk.h
+++ b/include/dt-bindings/clock/mt7981-clk.h
@@ -196,7 +196,7 @@
 #define CK_INFRA_SEJ_CK			(24 - INFRACFG_AO_OFFSET)
 #define CK_INFRA_SEJ_13M_CK		(25 - INFRACFG_AO_OFFSET)
 #define CK_INFRA_THERM_CK		(26 - INFRACFG_AO_OFFSET)
-#define CK_INFRA_I2CO_CK		(27 - INFRACFG_AO_OFFSET)
+#define CK_INFRA_I2C0_CK		(27 - INFRACFG_AO_OFFSET)
 #define CK_INFRA_UART0_CK		(28 - INFRACFG_AO_OFFSET)
 #define CK_INFRA_UART1_CK		(29 - INFRACFG_AO_OFFSET)
 #define CK_INFRA_UART2_CK		(30 - INFRACFG_AO_OFFSET)
-- 
2.45.2

