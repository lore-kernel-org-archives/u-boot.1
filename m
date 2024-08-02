Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C76C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 19:58:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C96EA88C6C;
	Fri,  2 Aug 2024 21:56:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DZoXrZeP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6748A88BF2; Fri,  2 Aug 2024 21:56:52 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F094788C45
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 21:56:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-428119da952so55211875e9.0
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 12:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722628607; x=1723233407; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kxRqvNWN9qqFwmXFrp08c7uVpbndKE+PhecZNSsquNI=;
 b=DZoXrZePXyMT+yh5AMCOyihbSm0kBOEovQzomLUZfiZTy1b1LCf4GWPa44U2sgwoTt
 vtCJtdg+KxRRJO9YlJ8+ltoVpsBNbZJMiDBlP1d5VjUMW6bypTJVVSrCgDdg+Rz896Ze
 A/zaT+/qQE3iMIGxeFoY0hfsp88CQiuaEHUXMobNsPg7nBIVMiYJ7Skdfw8n4VYiK0YV
 vy2h+00I6fSmvtCY53qWf1pFCb7LC28cAMNZgauVST7foIgq9ON2wJABUksTtT7CFPoD
 3DDBhvAbbv8W7KVt7KjaOStsdcCiltf42TakgWOt8vxkS624FXMHt9D5C11FmcBojket
 wUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722628607; x=1723233407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kxRqvNWN9qqFwmXFrp08c7uVpbndKE+PhecZNSsquNI=;
 b=Ewzhn9HTrm7Hg9r1LmUO+ri5RThdM08G8idDVcINxLbPzY8kFnicnOJMJnSpJ0GHSn
 se97Y7Extog9kzot0qEtMQi0m+04xPlBfszJ396v4muauEld9tMhDlr+t8krHN7HEzRw
 uW4800puaxTZT8nMJf5ZvIBY/JXAYD/H9Vii7aHeRkUX1IwC7WFmkq5iF5ZifOo10MLL
 90N4jvZ7CFtQppG94YeVda8BSAT+zZ07wp949Yememk6ssoWoz1CMbMC+cttsXCYhm5i
 vfzT0HK8kxwBop68qPiR6cA0RR84wLinL3ifhFDB2GUny3Sw4zlMrfcUbA3ZLsagTkA0
 Ia7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCN1qWaoVvDMNo3Ngsq83Z5nli3854cXwWt7WTL+TE5Uet6IPFpEka3W2cOO3ERCmwaCiNjQwLCAry/Bqa9rguQyK5Zw==
X-Gm-Message-State: AOJu0Yxi4f04sW6OMnkVzHM/fBZpKk8DKWNxFdn2cgjQAJULYn9BrX45
 slF77KRiTUEnklWTxafEUS+LB22mAMttRyEVObOpf+/TihfL97KH
X-Google-Smtp-Source: AGHT+IFEzuIexKYJ4XZU1+MO1zMwYj7eThhxvrYAstYTzorSjmUUxW8EQv3tlqkFJbB9PGNxbYV1Fw==
X-Received: by 2002:a05:600c:4f55:b0:426:5269:983a with SMTP id
 5b1f17b1804b1-428e6af2f12mr35657525e9.8.1722628607322; 
 Fri, 02 Aug 2024 12:56:47 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-428e6e01d0asm43350485e9.16.2024.08.02.12.56.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 12:56:47 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Crispin John <john@phrozen.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Sam Shih <sam.shih@mediatek.com>,
 u-boot@lists.denx.de
Subject: [PATCH 12/14] clk: mediatek: mt7981: fix support for pwm3 clock
Date: Fri,  2 Aug 2024 15:53:13 +0200
Message-ID: <20240802135326.25303-13-ansuelsmth@gmail.com>
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

Add and fix support for pwm3 clock. In the pwm DTSI node we were
actually using PWM2 clock for PWM3. Now that we have correct ID also add
the missing entry of gate and mux to support PWM3 clock.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/mt7981.dtsi          | 3 +--
 drivers/clk/mediatek/clk-mt7981.c | 3 +++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/mt7981.dtsi b/arch/arm/dts/mt7981.dtsi
index fc13b90caf6..b3f8a50cd10 100644
--- a/arch/arm/dts/mt7981.dtsi
+++ b/arch/arm/dts/mt7981.dtsi
@@ -144,8 +144,7 @@
 			 <&infracfg_ao CK_INFRA_PWM_BSEL>,
 			 <&infracfg_ao CK_INFRA_PWM1_CK>,
 			 <&infracfg_ao CK_INFRA_PWM2_CK>,
-			 /* FIXME */
-			 <&infracfg_ao CK_INFRA_PWM2_CK>;
+			 <&infracfg_ao CK_INFRA_PWM3_CK>;
 		assigned-clocks = <&topckgen CK_TOP_PWM_SEL>;
 		assigned-clock-parents = <&topckgen CK_TOP_CB_CKSQ_40M>;
 		clock-names = "top", "main", "pwm1", "pwm2", "pwm3";
diff --git a/drivers/clk/mediatek/clk-mt7981.c b/drivers/clk/mediatek/clk-mt7981.c
index 4435430dcde..7b692186dc1 100644
--- a/drivers/clk/mediatek/clk-mt7981.c
+++ b/drivers/clk/mediatek/clk-mt7981.c
@@ -381,6 +381,8 @@ static const struct mtk_composite infra_muxes[] = {
 		  9, 1),
 	INFRA_MUX(CK_INFRA_PWM2_SEL, "infra_pwm2_sel", infra_pwm1_parents, 0x10,
 		  11, 1),
+	INFRA_MUX(CK_INFRA_PWM3_SEL, "infra_pwm3_sel", infra_pwm1_parents, 0x10,
+		  15, 1),
 	INFRA_MUX(CK_INFRA_PWM_BSEL, "infra_pwm_bsel", infra_pwm_bsel_parents,
 		  0x10, 13, 2),
 	INFRA_MUX(CK_INFRA_PCIE_SEL, "infra_pcie_sel", infra_pcie_parents, 0x20,
@@ -445,6 +447,7 @@ static const struct mtk_gate infracfg_ao_gates[] = {
 	GATE_INFRA0_INFRA(CK_INFRA_PWM_STA, "infra_pwm_sta", CK_INFRA_PWM_BSEL, 2),
 	GATE_INFRA0_INFRA(CK_INFRA_PWM1_CK, "infra_pwm1", CK_INFRA_PWM1_SEL, 3),
 	GATE_INFRA0_INFRA(CK_INFRA_PWM2_CK, "infra_pwm2", CK_INFRA_PWM2_SEL, 4),
+	GATE_INFRA0_INFRA(CK_INFRA_PWM3_CK, "infra_pwm3", CK_INFRA_PWM3_SEL, 27),
 	GATE_INFRA0_TOP(CK_INFRA_CQ_DMA_CK, "infra_cq_dma", CK_TOP_SYSAXI, 6),
 	GATE_INFRA0_TOP(CK_INFRA_AUD_BUS_CK, "infra_aud_bus", CK_TOP_SYSAXI, 8),
 	GATE_INFRA0_TOP(CK_INFRA_AUD_26M_CK, "infra_aud_26m", CK_TOP_F26M_SEL, 9),
-- 
2.45.2

