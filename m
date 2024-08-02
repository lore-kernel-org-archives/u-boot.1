Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6B7C3DA7F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 19:52:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0F5B88C16;
	Fri,  2 Aug 2024 21:52:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T4/feyfJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D58B88C37; Fri,  2 Aug 2024 21:52:00 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 167C888C0F
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 21:51:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3686b554cfcso4306174f8f.1
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 12:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722628317; x=1723233117; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CFIu3Xo5u3gKh3u396SMqHcfNLJMHqCmnONohW3sQug=;
 b=T4/feyfJOqFKZ0sJGbN+Vz5mZJdekbQPlciZBm2NO6utMGo/wN3ZinTvMQ8kPA7IZz
 WwuoijSZu/n/KEkT/6eZHhPzH8C0otYGRqzeo+grKif60nURgAeihg6K1QcfcOO6I2vz
 QIzdoD//QrGA6BmhcwAipJcG8yjWlFKok9aQwKj4mhJs61wwwBzpupgng7gn3zWKNcSo
 7VAVrFqlhGyS8btgNY8QQfzxwA0t+PRz8gcWaqBonvT4aw9oMmVC9pK9MtZ6VgjySVAm
 /4zwvh5wjrQTo3nvsWcjx7atNEGKOmNEAnMaf1yk2UNA6DOpOmBKSn9WWbtmBDAC7Uwp
 3B9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722628317; x=1723233117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CFIu3Xo5u3gKh3u396SMqHcfNLJMHqCmnONohW3sQug=;
 b=lIHY41jnqtyS9kmAD0vT+/vDYQu90KqeD7+iqsN1zDZgVdBpxLqkspKhivsXeFHEdo
 BfnGNdiJvHW6GjIgQ0Yi276DzVkUl60CzU9tSxRToXraN7y/1M2e+etsUEhRkqWtP5gx
 w5Wz71u/WUujYxrtlDcLxoguxSw2kfq76xw6/mL40nccZ/5wCX+Og9fwr0gSSAm3yKOP
 f6E/IERXo5jn38YD8BYwowsS241Jv7KmIjUUs3kUdT7sAG4DakxK94OLm7iVQlvloNHL
 8IIH6QDD4LWkBBNshTru3AISo9Ru2ssCYKtUY1nHNmLPK5XwllWPHuzY9liNQxaBegMV
 itqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUa0xaVur8bXV/W/3WriyRCxZPk3ynx2N6MIsw2n963XhybNn3rQS5qb/1Z1BI6g8nI3j2jEYMSsbeKymPTMyfgje53bA==
X-Gm-Message-State: AOJu0Yx9gBzrcRoZjPzEHrbQECYQWI8T/ZjAArWBgRpDlvVyX7gTspOr
 cabzf8dOhyhbcc3ifFU/sA7xPYS6/vWktxQW7oNtNU0ZlUwN9eLu
X-Google-Smtp-Source: AGHT+IEt56vzgu/tWDr3aPQdEQvYQ46wgGySL1NmqlhPt+m/vMgjcCAMZZmUMpxbJ34HNSZuK/Eshg==
X-Received: by 2002:adf:cc89:0:b0:368:68d3:32b3 with SMTP id
 ffacd0b85a97d-36bbc11aaa5mr2832196f8f.26.1722628317255; 
 Fri, 02 Aug 2024 12:51:57 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-36bbd06d03fsm2643344f8f.91.2024.08.02.12.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 12:51:56 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH 1/8] clk: mediatek: mt7622: fix broken peri_cgs clk with XTAL
 parents
Date: Fri,  2 Aug 2024 15:48:25 +0200
Message-ID: <20240802134835.24006-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802134835.24006-1-ansuelsmth@gmail.com>
References: <20240802134835.24006-1-ansuelsmth@gmail.com>
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

