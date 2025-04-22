Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041CCC369D1
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 10:54:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BACAA81FC0;
	Tue, 22 Apr 2025 12:54:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="k8k2CtHm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7925B810E8; Tue, 22 Apr 2025 12:54:40 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80707810E8
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 12:54:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5f62d3ed994so6227555a12.2
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 03:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745319278; x=1745924078; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dUcI7MfQkW7X4R8QG3689yPkCv0tGLqKd5obOxVaDHA=;
 b=k8k2CtHmw0llDGxkjE8llXpwK3bx84QYIIb1FSYdSigHQ9hCPW89FMMNQu+upsQjCF
 gMFDh4u+d1/iKUB5JVKsej18kURFYRxplBowMbpfk5C0x5k/glnwAmWGXCewLkHSEbW1
 Ukq9RJfX0bRybjFw40XphlkQlvvnBr0ef2faugaUvGcgACzWJ8auIps5CLY90EtMFAM+
 aWoHBH+ruKcxlUl9UoEX3kAWFSz3TadGuhkt346h/pHyhRi1sMa8h9e9w8yZAlwp2Jmk
 yYiHlB+7mj8xHPgyF4n1CTWki8IicLUk/8iGc4FjZj+AK1442kpok+mDgSgwn2KkTPzA
 v2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745319278; x=1745924078;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dUcI7MfQkW7X4R8QG3689yPkCv0tGLqKd5obOxVaDHA=;
 b=qCUr/39K5VO49IBTEmb8QCGbKOjSCKE1sJX9ZI48lpPDgSQHQea8k8f304l0XGCL/R
 QNPk2DgadILR/6esbViIlJDX+r/WVaoG5HwZOBQC8lAdI/tbjVLavTKzaEAeNelE0x90
 TN9O/cNdZBdg+XRFbyITl/feCl9qNGPeHsNJuG8zkj1hYO6I6tB7F4xnHtVHJJnNL5n0
 9tXZv0LogftK1p56QKhdUk0oiHecEAi0lOrRAmR/mOVG3jJvC26Db2dB8r1+3khVroJ3
 vIqNbKVhiVnmeGUPe4A3Ua+vP1gdfdXU0SW6I/I6uvzdy502vmzwsFVw9jZ9vTL0ZqZt
 dzLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXul59JCFftzTqAvOgkc1/7wgz5/q1C7N4zTT5RtsxhNl+bfuxxLkHlxLvKubOqxeTt8b7V0Bw=@lists.denx.de
X-Gm-Message-State: AOJu0YwQqSk8hJ1CNr2GfJZSO8Ddql6YH4dYt9fsjIEGTz4sPz8YmKrv
 ghDWFF/RvGW5wu04vA4FLoLzQ8e/hK0lfvv9XvRfNsYGipdk+eW7fDQFCz7vFgI=
X-Gm-Gg: ASbGncu5y8URwzL1hvp7tTvMal98o/PIsNrBSZA+jHEC5Qo6773FKoWrL5TTwa5O/Om
 wNsSJJ4iDrbB+cotoYUuu+zFZ+UrO4HR9CP1vE+7MDKe5iltGnCK1o2iNTYaOTxAwQePWc7b87R
 ayY/uEWxlUqUaTEbcYlFoubKaGAHgUReGqBCwmjVnEL4lLN9h0NsmS29UMxB3cFpaZp3gPbozQ9
 WiQjbom73WA+1JpkU9slxjyPd8YRIqGDFb5JlRe43WV1oHmXkWEGiTniv2GddotyXPKqTjAXcoP
 STSey74LRUf8NTjJvm4StCdE/hbVX1n9Pax54wyurCRrSCAItGwCMw==
X-Google-Smtp-Source: AGHT+IHtmeRGnBzwA+OCoFH4KhlOGo4zmzSBKLkVrWVyIlH5/QnEp7137o3rDbcGpHJ/AEoRtYX38w==
X-Received: by 2002:a05:6402:849:b0:5f3:4194:187 with SMTP id
 4fb4d7f45d1cf-5f62854636bmr13525616a12.18.1745319277806; 
 Tue, 22 Apr 2025 03:54:37 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:d722:61ae:90dc:b4e7])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f62554a1desm5709635a12.8.2025.04.22.03.54.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 03:54:37 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Tue, 22 Apr 2025 12:54:07 +0200
Subject: [PATCH 2/6] clk: qcom: Move qcom_gate_clk_en() to C file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-apq8016-clock-fixes2-v1-2-bfc9dd933da6@linaro.org>
References: <20250422-apq8016-clock-fixes2-v1-0-bfc9dd933da6@linaro.org>
In-Reply-To: <20250422-apq8016-clock-fixes2-v1-0-bfc9dd933da6@linaro.org>
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

