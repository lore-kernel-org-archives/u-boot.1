Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE60C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 09:17:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F4A780F9C;
	Thu, 24 Apr 2025 11:17:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X+KF+hZ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 214BD8205A; Thu, 24 Apr 2025 11:17:04 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1619C81B4B
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 11:17:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43d07ca6a80so3156005e9.1
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 02:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745486220; x=1746091020; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pKeqe/yy58kjh/OQtfL2D8uIfRy6AGxbwRpWgf+RTiw=;
 b=X+KF+hZ/o2U9GCCsBIsxs4QTh61dVB1FdFXAlg9fkednGW9Yu7+R168H5c+cxzJwGP
 d/54WLrVWsQhxOfLAixmkgJJmNid+s6Tg5XrenC/Nb4Kof7E3ztcJvkLgbZQoB82kNAF
 LkdAt61hSfr/DdkeFm5V1eYUXpKbO0Kyj47rmpVPQ/AjeNxUS6Gtz6aTDlIqpeLHBOhN
 X+a7MzTG+VE49W0uq6of1sYdAvtgNyp65fgzLQewhPqfyWVScUqIFzZET1+ncQ6OWwva
 3pzzSuFkiL7bgH0yBiAG8GVcQlLlTWLKbZPcHkTfMQAEpTEeTj/A9XYdspQ1dn/3EYTc
 LIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745486220; x=1746091020;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pKeqe/yy58kjh/OQtfL2D8uIfRy6AGxbwRpWgf+RTiw=;
 b=HsSmSn8akYwt4KiXPeXaaSjcHHRSTXpolP39G2mb+z5GQ2a1MNZXd6t4+nve3grTEs
 hsEQosZq5hkKjLSqgyj8Xjjpl0FHu0uc/TmtZ+sFkdEKsbjnh6l8hogSHVZQfEUfN2c/
 CG9unW0TPhHDPj00YxXJj1IoyyDui6rwS2Pc80Q92nuJfw71DBfDLB8ybKM8gQ5hO97d
 x+oHi/vqPWpndyavTlhs3/gB5Io+vpUgseZpqYmT0J8nSkAagYJJYKb0hB5/jnrXiFX+
 Yxe/8v3BWL9OqBrhVb4h/TiCwG+VOYIFRxux/GmVp5PLl/I2XfHC6PlnQZF9OaxHmHBc
 vNeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXm+f/T7E5SaACiLuCFNQHlNANlsJ+SO0YfwM7LnZqDzMkx6DLgILK7hrA6WcfDY6wIsEXCe1g=@lists.denx.de
X-Gm-Message-State: AOJu0YzF5eePd2LJdhKJ3OZg62zSQTwp7pFmheqloumvODihpUoFqCmQ
 Qdh90bRGkZx3M4M8l7dxAqSSeUCLW9sGDfUNcEyGauXLjk1gKA2JdFCyaLuAn88=
X-Gm-Gg: ASbGnctFXHLZ69usQu9Jq2xPiBpCnuVVnvlAg0/5SIkzVQ107/w9T7CVIMqunfyPE8S
 VeNVLj5Glf4YGc3S0GMynaW5ZjNKg7INCvFfN+6If0WPNR02UuqSIHZttunLXyWTFeCgOqKj8dq
 jXzd7CTWVttnr3ysvvfAtWwDSCL3BS6BaivXDzatGmRnksjAhS2pwjPQ4FpcfTzaSBIB83eQtWN
 5x7S73RB2O/zlvJjNA1xfPqtJ/BNpFpkuB4d4VQmD7jwChpDar+q3BllzeptVaVAmRcxRUGIn7Q
 ny0UJ8PsxGzPK2Sfxz2tzTOnXgvrrFtClnY7tQH2F7uw9aAkCN0=
X-Google-Smtp-Source: AGHT+IG8H7brsGo7uVLNcTHV1WqSZMUW3cjet2IhiYiJDawKlBLaCtwNGfCxCgkA0vqwJU6e+D9xgA==
X-Received: by 2002:a05:600c:1913:b0:43b:d0fe:b8ac with SMTP id
 5b1f17b1804b1-4409bdaac04mr18378925e9.30.1745486220478; 
 Thu, 24 Apr 2025 02:17:00 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:d677:e5de:3a6:836])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d1e19e1sm13000945e9.0.2025.04.24.02.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 02:17:00 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Thu, 24 Apr 2025 11:16:42 +0200
Subject: [PATCH v2 2/6] clk: qcom: Move qcom_gate_clk_en() to C file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-apq8016-clock-fixes2-v2-2-fcc371c9e45f@linaro.org>
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

This avoids having to inline it separately into every single clock driver,
when U-Boot is built with support for multiple SoCs.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/clk/qcom/clock-qcom.c | 15 +++++++++++++++
 drivers/clk/qcom/clock-qcom.h | 15 +--------------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index 7687bbe6a23b436e4ddf3b29d1c910062961126d..5018851725b03d1c55c6fc40934bd7bea6344da1 100644
--- a/drivers/clk/qcom/clock-qcom.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -74,6 +74,21 @@ void clk_enable_vote_clk(phys_addr_t base, const struct vote_clk *vclk)
 	} while ((val != BRANCH_ON_VAL) && (val != BRANCH_NOC_FSM_ON_VAL));
 }
 
+int qcom_gate_clk_en(const struct msm_clk_priv *priv, unsigned long id)
+{
+	u32 val;
+	if (id >= priv->data->num_clks || priv->data->clks[id].reg == 0) {
+		log_err("gcc@%#08llx: unknown clock ID %lu!\n",
+			priv->base, id);
+		return -ENOENT;
+	}
+
+	val = readl(priv->base + priv->data->clks[id].reg);
+	writel(val | priv->data->clks[id].en_val, priv->base + priv->data->clks[id].reg);
+
+	return 0;
+}
+
 #define APPS_CMD_RCGR_UPDATE BIT(0)
 
 /* Update clock command via CMD_RCGR */
diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index f43edea25253305b34e7d879624ea5ee1a751746..ee0347d9d86716c09e7f57b343f12b5908f8cb92 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -107,19 +107,6 @@ void clk_rcg_set_rate(phys_addr_t base, uint32_t cmd_rcgr, int div,
 		      int source);
 void clk_phy_mux_enable(phys_addr_t base, uint32_t cmd_rcgr, bool enabled);
 
-static inline int qcom_gate_clk_en(const struct msm_clk_priv *priv, unsigned long id)
-{
-	u32 val;
-	if (id >= priv->data->num_clks || priv->data->clks[id].reg == 0) {
-		log_err("gcc@%#08llx: unknown clock ID %lu!\n",
-			priv->base, id);
-		return -ENOENT;
-	}
-
-	val = readl(priv->base + priv->data->clks[id].reg);
-	writel(val | priv->data->clks[id].en_val, priv->base + priv->data->clks[id].reg);
-
-	return 0;
-}
+int qcom_gate_clk_en(const struct msm_clk_priv *priv, unsigned long id);
 
 #endif

-- 
2.47.2

