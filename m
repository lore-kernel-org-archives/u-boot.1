Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA8EFD9E10
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 20:40:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B25C383E63;
	Thu, 26 Feb 2026 21:40:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DUSM9+hI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1622983E8E; Thu, 26 Feb 2026 20:32:39 +0100 (CET)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D11283D1A
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 20:32:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=blfizzyy@gmail.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-824a9348603so496663b3a.2
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 11:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772134355; x=1772739155; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=G1vx/jeIl8YtRxBnYTtmCsOHyWLUgb9eFDD5PAZxUV8=;
 b=DUSM9+hIJblavgLmsY7MN5C1Ht6YDoJPf0avZqMtPpQi7YZ8m04r5MrXoTB0AhuEA6
 bz0oNiDkzv2pfq3Inj3zaWmGo7WsVj2XePHEk2AxM8k2kQxCtBHnC0EnHcnHJrOngyCe
 ZtFRN5wmeuhAo3dXGHCqTDBXAkZcMirC6Jipu4OyG+DoU9QY5UT7kP43Gj0xs4rLuy2r
 Y1Pv/Vmjtkvgiq6NNzI9Pe6Yvrhv63N3o/tOqNa7Pck0rCOlJogpFQDvrkflB1gmiXOQ
 caG8pXv0l0FREoN2JgxfIuThbcOBdF8+NxPlZoYnaEsdpTW+zOT3w/CTRtX2N9Nw8AtJ
 g8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772134355; x=1772739155;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G1vx/jeIl8YtRxBnYTtmCsOHyWLUgb9eFDD5PAZxUV8=;
 b=gJqtakQcEsrLFgXmuskIcGYMLuqXsUZjQ6+VZWtrCj19A/uxQoyw609hPAsAReBHWO
 jp240beJyr0KFOy/Ww20txwnJufk9nHmv2OTYEcyl0E3X2e7sbuldenxpDJrmC/ScDmc
 Rhns7QOPM7rqd7QhgeEOGkxKArf93i9O8MoO5uqzwmzdRTwyANOPC5UwXCl12eJoEcHl
 /phkzcpXBTRdg++Xq680bYYRx0doWTfKdSF3RyKFlLRqwE7vgcvaleDCAMzHHn+tVv6G
 b3ZdTihNWqC3iY50Ck4rkcl2rDlvlSRgklG864rs+d7fVF1EsOtN5GxJzEML7kaYNtN/
 WPwA==
X-Gm-Message-State: AOJu0YyVEZs8rkWKCacBoysY1bSTb6wvQvAk5E8ujdUvYwvsD5SqMXjt
 RMkzlVIjsY4vSxx00ozVx5n/33Oe8FlL3lSzD4yV8ikakofmD2tHZZsVuq0G6uMH
X-Gm-Gg: ATEYQzx8y9mPs8SDPxEfxxrJ15yZZH9TaTaXEvj1Mq6+btOgJTv/KbxJ2xJv6yizQap
 NfWrKJEXlEPbz7b6e266Ta0krgOHCSwQB0/Xx2JsScq1HbiJwRXCH+ZU+hh9SuwMeivQAPon4c/
 Si2/10eVZGRbDafyq28LdVHeXiCH/wke90u+nX/Pa/KmepQGprYDuwmd/LCq9e1fDEWiLe14iCX
 4EYpMmzsJc69RU6p6jOBJLNLweN/lj/C1gwOwBNKCNeyWmbCf5mjnkKmg/Vkso9baRZD4YAdq4f
 c6JCyyJZQPf8GAxjzYEt9BUixxaDrQ3Qv6VUVbeEehFC6nwcPVL2GKHxmBryvQgJWrXE5vNQDTS
 4gX2+6ePpT0P5CroS5KXTNgSZNm4u7O0Qc76Vqfb0wwWTtP1VcXhICZSjNoqpYD5mreAJQJPTxz
 PEJf5QHsZA5/wIz8HfCM7S0+W9kcIWneJvG1SQ64y1312ItUN7VpavWCIRBzE=
X-Received: by 2002:a05:6a20:729c:b0:38b:d9b0:e944 with SMTP id
 adf61e73a8af0-395c3af178fmr355744637.53.1772134354513; 
 Thu, 26 Feb 2026 11:32:34 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:88b7:799:4d33:657c:6c3c:3b52])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2adfb6b9b32sm49097505ad.66.2026.02.26.11.32.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Feb 2026 11:32:34 -0800 (PST)
From: Ajit Singh <blfizzyy@gmail.com>
To: u-boot@lists.denx.de,
	u-boot-qcom@groups.io
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Luca Weiss <luca.weiss@fairphone.com>, Ajit Singh <blfizzyy@gmail.com>
Subject: [PATCH] clk: qcom: sc7280: add missing SDCC1 clocks
Date: Fri, 27 Feb 2026 01:02:17 +0530
Message-ID: <20260226193217.82657-1-blfizzyy@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Feb 2026 21:40:10 +0100
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

Add GCC_SDCC1_AHB_CLK and GCC_SDCC1_APPS_CLK gate clocks.
Required on platforms where SDCC1 is used for eMMC.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=a3cc092196ef63570c8744c3ac88c3c6c67ab44b

Signed-off-by: Ajit Singh <blfizzyy@gmail.com>
---
 drivers/clk/qcom/clock-sc7280.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/clock-sc7280.c
index 7b6ed826023..acdaccf7462 100644
--- a/drivers/clk/qcom/clock-sc7280.c
+++ b/drivers/clk/qcom/clock-sc7280.c
@@ -155,6 +155,8 @@ static const struct gate_clk sc7280_clks[] = {
 	GATE_CLK(GCC_UFS_1_CLKREF_EN, 0x8c000, BIT(0)),
 	GATE_CLK(GCC_SDCC2_AHB_CLK, 0x14008, BIT(0)),
 	GATE_CLK(GCC_SDCC2_APPS_CLK, 0x14004, BIT(0)),
+	GATE_CLK(GCC_SDCC1_AHB_CLK,  0x75004, BIT(0)),
+	GATE_CLK(GCC_SDCC1_APPS_CLK, 0x75008, BIT(0)),
 };
 
 static int sc7280_enable(struct clk *clk)
-- 
2.50.1 (Apple Git-155)

