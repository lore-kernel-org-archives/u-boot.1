Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51504C3DA4A
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 11:13:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 496C188CAB;
	Sat,  3 Aug 2024 13:13:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hpzM+abf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE0EE88CAB; Sat,  3 Aug 2024 13:13:05 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4229488C8B
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 13:13:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-428e0d184b4so19356335e9.2
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 04:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722683583; x=1723288383; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CFIu3Xo5u3gKh3u396SMqHcfNLJMHqCmnONohW3sQug=;
 b=hpzM+abfj1bEwykDhGdItm/jxpSvr7uE8Hby2RGuu8TZoyljeWGMzQZALGdv7t3Rk9
 px/N/MbW5Ior9JEckWh5v4HLVvtLJ+oP2nDmluxUdlF0/jjp//BuZIq8Ttfk2Zxi7VKC
 Gep7Ru1VP7qADFO8J3ZedXj27+jx+sVU4lDqWnGd0yySkxnKRnnVOIcYhS6MfL/6IV/M
 pVbJpCNjh0E+6M2kfcyol5dIZpWCOP3/bSyxA1w34rPVYq/Z94BhTsZw8y/vNr1DrTST
 5BJCYbJHpBE6RtsEKxfKJBwz0eWRo/g89IfAbXO2MNSAOza/+Eu0fWAs5kZ7GJLp5aPc
 7Uhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722683583; x=1723288383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CFIu3Xo5u3gKh3u396SMqHcfNLJMHqCmnONohW3sQug=;
 b=ORhil6VGuaBgQGq7zvZA11F1A6VzkOi9VQ07GAZ/Mmh7XAITp4tVAUA2Y4tfxpsV6K
 /lqijLVvJbndQvXD4TdwroNpo2FwYv9R3FmaDbwRGv6bHhN4B7TCvChP/lCfPQPllW5w
 eK+6VYUhhQhtRHaowKN69zXZ9R4uLxBa/MwKg5CTE5SYvytlSZ4DUAGojd13pbl7kWRF
 z55GzdIp6Borh26v/NWGoCF8zAUpjdG0o564Jtx5dJCbh6shqjHqYL7JZtcJKAWQAs2E
 oFgomixS7lOB6druIM+asyHcPZyzvVAsJDvWzs7vF7CyTHVXRxGZ7/DXxXEaeLYgkQU6
 JOOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUL388XPH6GqmwVgacEipjegb1nvGjOO6qXBdy62hJ0l9kpRUwgwL0XTodCEoCYqALK5KQsMhnLzNJFQTd/mEvL6zwrgQ==
X-Gm-Message-State: AOJu0YzPAoKGa+eSSOIHOnArZG3z9TxgwW7OcJrS7etYbl5dQwzM85dg
 fpCzYi95zI7fjEDnop91Oo4Nglk7KMsTU0Bwa4StNVzYy84cA9xW
X-Google-Smtp-Source: AGHT+IEAE3nK/hI5oeFYrxmRHso95FIZisvxRjneRvV41b3R4l5LUU7CRMmAffKsIYaBu/1dpXrkhg==
X-Received: by 2002:a05:600c:3111:b0:426:5c9b:dee6 with SMTP id
 5b1f17b1804b1-428e6b7f2c7mr40694525e9.26.1722683582378; 
 Sat, 03 Aug 2024 04:13:02 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-428e6d648a0sm63835655e9.10.2024.08.03.04.13.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Aug 2024 04:13:02 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2 1/8] clk: mediatek: mt7622: fix broken peri_cgs clk with
 XTAL parents
Date: Sat,  3 Aug 2024 10:43:19 +0200
Message-ID: <20240803084329.1688-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240803084329.1688-1-ansuelsmth@gmail.com>
References: <20240803084329.1688-1-ansuelsmth@gmail.com>
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

Fix broken peri_cgs clock with XTAL parents as they have wrong
definition of the parent type.

Correctly fix them and use CLK_PARENT_XTAL for them.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mt7622.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 2beb63030f2..4a7c5faff1a 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -402,13 +402,17 @@ static const struct mtk_gate_regs peri1_cg_regs = {
 	.sta_ofs = 0x1C,
 };
 
-#define GATE_PERI0(_id, _parent, _shift) {			\
+#define GATE_PERI0_FLAGS(_id, _parent, _shift, _flags) {	\
 		.id = _id,					\
 		.parent = _parent,				\
 		.regs = &peri0_cg_regs,				\
 		.shift = _shift,				\
-		.flags = CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN,	\
+		.flags = _flags,				\
 	}
+#define GATE_PERI0(_id, _parent, _shift) \
+	GATE_PERI0_FLAGS(_id, _parent, _shift, CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN)
+#define GATE_PERI0_XTAL(_id, _parent, _shift) \
+	GATE_PERI0_FLAGS(_id, _parent, _shift, CLK_GATE_SETCLR | CLK_PARENT_XTAL)
 
 #define GATE_PERI1(_id, _parent, _shift) {			\
 		.id = _id,					\
@@ -421,14 +425,14 @@ static const struct mtk_gate_regs peri1_cg_regs = {
 static const struct mtk_gate peri_cgs[] = {
 	/* PERI0 */
 	GATE_PERI0(CLK_PERI_THERM_PD, CLK_TOP_AXI_SEL, 1),
-	GATE_PERI0(CLK_PERI_PWM1_PD, CLK_XTAL, 2),
-	GATE_PERI0(CLK_PERI_PWM2_PD, CLK_XTAL, 3),
-	GATE_PERI0(CLK_PERI_PWM3_PD, CLK_XTAL, 4),
-	GATE_PERI0(CLK_PERI_PWM4_PD, CLK_XTAL, 5),
-	GATE_PERI0(CLK_PERI_PWM5_PD, CLK_XTAL, 6),
-	GATE_PERI0(CLK_PERI_PWM6_PD, CLK_XTAL, 7),
-	GATE_PERI0(CLK_PERI_PWM7_PD, CLK_XTAL, 8),
-	GATE_PERI0(CLK_PERI_PWM_PD, CLK_XTAL, 9),
+	GATE_PERI0_XTAL(CLK_PERI_PWM1_PD, CLK_XTAL, 2),
+	GATE_PERI0_XTAL(CLK_PERI_PWM2_PD, CLK_XTAL, 3),
+	GATE_PERI0_XTAL(CLK_PERI_PWM3_PD, CLK_XTAL, 4),
+	GATE_PERI0_XTAL(CLK_PERI_PWM4_PD, CLK_XTAL, 5),
+	GATE_PERI0_XTAL(CLK_PERI_PWM5_PD, CLK_XTAL, 6),
+	GATE_PERI0_XTAL(CLK_PERI_PWM6_PD, CLK_XTAL, 7),
+	GATE_PERI0_XTAL(CLK_PERI_PWM7_PD, CLK_XTAL, 8),
+	GATE_PERI0_XTAL(CLK_PERI_PWM_PD, CLK_XTAL, 9),
 	GATE_PERI0(CLK_PERI_AP_DMA_PD, CLK_TOP_AXI_SEL, 12),
 	GATE_PERI0(CLK_PERI_MSDC30_0_PD, CLK_TOP_MSDC30_0_SEL, 13),
 	GATE_PERI0(CLK_PERI_MSDC30_1_PD, CLK_TOP_MSDC30_1_SEL, 14),
@@ -441,7 +445,7 @@ static const struct mtk_gate peri_cgs[] = {
 	GATE_PERI0(CLK_PERI_I2C1_PD, CLK_TOP_AXI_SEL, 24),
 	GATE_PERI0(CLK_PERI_I2C2_PD, CLK_TOP_AXI_SEL, 25),
 	GATE_PERI0(CLK_PERI_SPI1_PD, CLK_TOP_SPI1_SEL, 26),
-	GATE_PERI0(CLK_PERI_AUXADC_PD, CLK_XTAL, 27),
+	GATE_PERI0_XTAL(CLK_PERI_AUXADC_PD, CLK_XTAL, 27),
 	GATE_PERI0(CLK_PERI_SPI0_PD, CLK_TOP_SPI0_SEL, 28),
 	GATE_PERI0(CLK_PERI_SNFI_PD, CLK_TOP_NFI_INFRA_SEL, 29),
 	GATE_PERI0(CLK_PERI_NFI_PD, CLK_TOP_AXI_SEL, 30),
-- 
2.45.2

