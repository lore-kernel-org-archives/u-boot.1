Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2FCC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 19:49:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EFB888C0F;
	Fri,  2 Aug 2024 21:49:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ki1vkt6s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09B2288BE4; Fri,  2 Aug 2024 21:48:58 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B5A488BDA
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 21:48:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4280c55e488so21509115e9.0
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 12:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722628135; x=1723232935; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O3ok3kYAHfT+LZCRu0xli2BIEOEEnSiVPKmVFCfYqvQ=;
 b=Ki1vkt6sYaPjvyprNcmfu+PAOgeXTRxlG0gfxZL+xEq4pHiGon0IkbWpA5lo/+rU2Q
 MimTft8HMXCQ5N1lZqgKx3kIuPN/yUozoaUr7hjU7l2kJSY5ww/yw78vSbwB7tcj9RvN
 QlzbVsV074emcgyGiyxnUrdJCIdmuTzYS6yNcS49pvgB7qyEGj3q0RCgii7ticKyWy5O
 w/evDX1nIM9EXCu71bEpCmuM4gnX4iQHKtanVV/lurYjy69uXuA8vMNI5ie+yrWwJHx3
 R79X0PZcjiGn1iiJfvkIk5Gb4S98uZub73X1niZPraU8h8wCNiAdQcQ6ySxfH2vRzsWR
 CphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722628135; x=1723232935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O3ok3kYAHfT+LZCRu0xli2BIEOEEnSiVPKmVFCfYqvQ=;
 b=AiQ0c5+5L/6s5V5u1mG073t/ADHPVMpqOBRKYx4mMc8wTwV1wRkTmtCMb8bFCxTGeQ
 SBfuzk0e9l1tN2p2YHKugX5IOoPUeSuD5QQaA6mP+rwhxLKGNnwftBbWpxKfXMyPB8IJ
 6upO/eHE0PoiggyZCyYNsbDfJWw3MLWGHx5OFKr1g5yF4j0mNjXDB7TsRSLjB2rybCYb
 lMVRV26LSlxSElaguE4csA+2d0B3kfpAJDJN/+xLFvFO001inQnSFehTp2Ev2vaDZMOR
 v8tYoBIT9XL+OoqzoF/k8PqvMVztWol60jD54hEQszB6NJtfKKsQDdcsDO8n0OFBoRkT
 VgXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXm5BcP+7CUahx8kBU4EDgdZEaGDHLKDKEKsmCt9NG4teejjWOdztrJCGQ76agSir84kNvi3EGkLT+Q9HcYhZUn+wzcCQ==
X-Gm-Message-State: AOJu0YwBXGmuMrFmMCBQqHYzZVgqZPigFjM87k7DLV2O58nHGXew0KIc
 8W53ruL8AYIP1J49MsTfJmR87RXD5xNoZHDHGHimHkmZV0j7kHFj
X-Google-Smtp-Source: AGHT+IHGfaNf1cqOo9AT4BI/7ar/WQbqsisaIfNveQUF9aY25Jq5k1yIgxjXOptCJHuMWJexKrbWiA==
X-Received: by 2002:a05:600c:19d2:b0:428:9a1:f226 with SMTP id
 5b1f17b1804b1-428e4706d1fmr47467555e9.1.1722628135469; 
 Fri, 02 Aug 2024 12:48:55 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-428ebbe18c0sm24827455e9.17.2024.08.02.12.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 12:48:55 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH 4/5] clk: mediatek: mt7623: remap apmixedsys clock ID
Date: Fri,  2 Aug 2024 15:45:04 +0200
Message-ID: <20240802134511.23608-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802134511.23608-1-ansuelsmth@gmail.com>
References: <20240802134511.23608-1-ansuelsmth@gmail.com>
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

Define remap table also for apmixedsys clock ID. The clock ID starts
from 1 instead of 0 in upstream kernel linux.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mt7623.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt7623.c b/drivers/clk/mediatek/clk-mt7623.c
index 6af6f9f11bd..78e390d49f8 100644
--- a/drivers/clk/mediatek/clk-mt7623.c
+++ b/drivers/clk/mediatek/clk-mt7623.c
@@ -25,6 +25,22 @@
 #define AXI_DIV_SEL(x)			(x)
 
 /* apmixedsys */
+static const int pll_id_offs_map[] = {
+	[CLK_APMIXED_ARMPLL]			= 0,
+	[CLK_APMIXED_MAINPLL]			= 1,
+	[CLK_APMIXED_UNIVPLL]			= 2,
+	[CLK_APMIXED_MMPLL]			= 3,
+	[CLK_APMIXED_MSDCPLL]			= 4,
+	[CLK_APMIXED_TVDPLL]			= 5,
+	[CLK_APMIXED_AUD1PLL]			= 6,
+	[CLK_APMIXED_TRGPLL]			= 7,
+	[CLK_APMIXED_ETHPLL]			= 8,
+	[CLK_APMIXED_VDECPLL]			= 9,
+	[CLK_APMIXED_HADDS2PLL]			= 10,
+	[CLK_APMIXED_AUD2PLL]			= 11,
+	[CLK_APMIXED_TVD2PLL]			= 12,
+};
+
 #define PLL(_id, _reg, _pwr_reg, _en_mask, _flags, _pcwbits, _pd_reg,	\
 	    _pd_shift, _pcw_reg, _pcw_shift) {				\
 		.id = _id,						\
@@ -911,6 +927,7 @@ static const struct mtk_gate hif_cgs[] = {
 
 static const struct mtk_clk_tree mt7623_apmixedsys_clk_tree = {
 	.xtal2_rate = 26 * MHZ,
+	.id_offs_map = pll_id_offs_map,
 	.plls = apmixed_plls,
 };
 
-- 
2.45.2

