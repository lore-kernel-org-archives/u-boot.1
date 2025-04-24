Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B9DC369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 09:17:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACE4A820E8;
	Thu, 24 Apr 2025 11:17:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="a59CneAW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB08582075; Thu, 24 Apr 2025 11:17:04 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8151809D4
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 11:17:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43edb40f357so4661335e9.0
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 02:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745486222; x=1746091022; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VwCiqo3gcSiW4f27TNbxRtT10Fl64eb1lY3LS3hiPeU=;
 b=a59CneAW5pOia8jYe9LA55vEfSRQ/C5a/l1oNLwLG+FJxK9TUUkB/yGhl42iH06edF
 Lhjs38luPmG2f4Cvpet9wI1VzeZ/7FXTK7xRvGhjLT8wbaXz6JWmTJXIuFHNFQysnd2W
 pfJH7jm9El/16ROO53Ii0dMLfu0Pe3WpHFdRkIjXoh3oP5P4XsEMGv75kvdJfpD+G8LT
 u9k36gb+QtmoRB4p76/nF2KiS0enQ+dNtZyEbM1NKjZdmSgEBA3oxFq5KLNR0ET/psvl
 YYPQc7d9rBDeGoAbnBmQZiMlOYt00wtebJ90gSgkvz06oNPDZyEqR1MG8K7/CRL2EIjW
 mTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745486222; x=1746091022;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VwCiqo3gcSiW4f27TNbxRtT10Fl64eb1lY3LS3hiPeU=;
 b=gvLCToi+CPo2tLw0rGpW4QVCOD/le56LcWM2nZnxnjW5JatUouHSAtdXhK74i9vncK
 d3FjVylqj+z3XOiKbPlXMIDcSvTbtUX7DPtm7YzqUCxtqqi77kpPEy5bynX5CRpQxbgj
 4xhfC+4GE1+mXZXFhaABTCe5nCkyzia8IMaYGq6fDQUymYr7bAgByEDyTkSEpZ5pP4fl
 UinezbDuQPUCP0L+WDuwu5gJvR9BmrVfgjq/04DaGeWPh0Diy8KzLqzxpEBESlSk29Yh
 UKoEAIdiVTZdvlGO/8aLfPiOxAh9HV1nfWChlSYIJt0B2yP9diWMqeDG+SwlllnlG4G0
 wa6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhGmT1lx7nT1K0qeBvV6oIyYCXc4k7X6ipa2kGSVRXrNGCC3zXICUu/r3EMJ9hk4WIBfPmQxs=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6CUfgZeF5mLMynMBTBMHuSf0CSDF6bGVhtmVEzf9RVeew+pYa
 8wF6p7lM3EPGPiY5HkCJfCy2PNRb4q2LcUMLii742icdeGXJIRoPaEOnTY1eIBs=
X-Gm-Gg: ASbGnctb1rICTWo5LN32lA/8YtofLmGdMFo3SXGpiQr6OavVaOgqzlfXY3cE2f6xZV7
 MERYmTDGF5C9thnpST6P9A09JbFVluesif4vK1XCNp2/pFicsLjDlwUFV3veskTEj0oDoIij2v0
 sTBEoJny6jMrSD1U25BCGl/qPrc7aQByDfJoT0O/Oc5eQBkbpTz1JgisM7apKu8gV49W+SCg7Lh
 A6fQEJaGcD+KqBPRw32Y6yi4RFRyCQfiiuguqPe8AD0MYMsiMaUsskdvT2DJa1nS9lGPeyPlpxq
 EsffgOhpMYGNQIiJNHl6suXsoQHl10VCUYu1td0rfKturogSyGvrvPHwjH7SYQ==
X-Google-Smtp-Source: AGHT+IGYA51D/2qP/K45Jpmq0/64XWNM3+A817MCqhhksvZJAX99QRSVk7r4dzfs+NUja3o0/TdTcQ==
X-Received: by 2002:a05:600c:3482:b0:43d:94:2d1e with SMTP id
 5b1f17b1804b1-4409bd23196mr20100145e9.13.1745486222132; 
 Thu, 24 Apr 2025 02:17:02 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:d677:e5de:3a6:836])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d1e19e1sm13000945e9.0.2025.04.24.02.17.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 02:17:01 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Thu, 24 Apr 2025 11:16:44 +0200
Subject: [PATCH v2 4/6] clk: qcom: Allow polling for clock status in
 qcom_gate_clk_en()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-apq8016-clock-fixes2-v2-4-fcc371c9e45f@linaro.org>
References: <20250424-apq8016-clock-fixes2-v2-0-fcc371c9e45f@linaro.org>
In-Reply-To: <20250424-apq8016-clock-fixes2-v2-0-fcc371c9e45f@linaro.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Sam Day <me@samcday.com>, 
 u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14.2
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

GATE_CLK() in its current state is unsafe: A simple write to the clock
enable register does not guarantee that the clock is immediately running.
Without polling the clock status, we may issue writes to registers before
the necessary clocks start running. This doesn't seem to cause issues in
U-Boot at the moment, but for example removing the CLK_OFF polling in TF-A
for the SMMU clocks on DB410c reliably triggers an exception during boot.

Make it possible to poll the branch clock status register, by adding a new
GATE_CLK_POLLED() macro that takes the extra register address. Existing
usages work just as before, without polling the clock status. Ideally all
usages should be updated to specify the correct poll address in the future.

The Qualcomm naming for these clocks is "branch" and not "gate", but let's
keep the existing naming for now to avoid confusion until all others
drivers have been converted.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/clk/qcom/clock-qcom.c | 15 +++++++++++++++
 drivers/clk/qcom/clock-qcom.h | 11 +++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index 7a259db79342c31dfe85220c68c82197861ccdf6..6b46d9db744b87538b796bf729d16785bca08545 100644
--- a/drivers/clk/qcom/clock-qcom.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -83,6 +83,21 @@ int qcom_gate_clk_en(const struct msm_clk_priv *priv, unsigned long id)
 	}
 
 	setbits_le32(priv->base + priv->data->clks[id].reg, priv->data->clks[id].en_val);
+	if (priv->data->clks[id].cbcr_reg) {
+		unsigned int count;
+		u32 val;
+
+		for (count = 0; count < 200; count++) {
+			val = readl(priv->base + priv->data->clks[id].cbcr_reg);
+			val &= BRANCH_CHECK_MASK;
+			if (val == BRANCH_ON_VAL || val == BRANCH_NOC_FSM_ON_VAL)
+				break;
+			udelay(1);
+		}
+		if (WARN(count == 200, "WARNING: Clock @ %#lx [%#010x] stuck at off\n",
+			 priv->data->clks[id].cbcr_reg, val))
+			return -EBUSY;
+	}
 	return 0;
 }
 
diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index ee0347d9d86716c09e7f57b343f12b5908f8cb92..1b60882dae47547b6ee9470f8b4072bd6a1c1568 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -52,13 +52,20 @@ struct freq_tbl {
 struct gate_clk {
 	uintptr_t reg;
 	u32 en_val;
+	uintptr_t cbcr_reg;
 	const char *name;
 };
 
+/*
+ * GATE_CLK() is deprecated: Use GATE_CLK_POLLED() instead to ensure the clock
+ * is running before we start making use of devices or registers.
+ */
 #ifdef DEBUG
-#define GATE_CLK(clk, reg, val) [clk] = { reg, val, #clk }
+#define GATE_CLK(clk, reg, val) [clk] = { reg, val, 0, #clk }
+#define GATE_CLK_POLLED(clk, en_reg, val, cbcr_reg) [clk] = { en_reg, val, cbcr_reg, #clk }
 #else
-#define GATE_CLK(clk, reg, val) [clk] = { reg, val, NULL }
+#define GATE_CLK(clk, reg, val) [clk] = { reg, val, 0, NULL }
+#define GATE_CLK_POLLED(clk, en_reg, val, cbcr_reg) [clk] = { en_reg, val, cbcr_reg, NULL }
 #endif
 
 struct qcom_reset_map {

-- 
2.47.2

