Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 689B1C369D1
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 10:55:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09F2182054;
	Tue, 22 Apr 2025 12:54:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ux6fs9HH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12D8A817C4; Tue, 22 Apr 2025 12:54:42 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 157EA812BC
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 12:54:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5f3f04b5dbcso6941867a12.1
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 03:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745319279; x=1745924079; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=S3cuc1N4YFsXf4X4TFbGvQl95S/zc1vp4BUoPJMKJ9o=;
 b=ux6fs9HHr3fAiFTDd4OH/RQ0Iv6hyMjUWp5LlPQqIzhq9LqQ8ndGWZgEfb0Moy5E2p
 I05pkAJ1AOpqE96fXRZbsptPj+P9GvPDuaEJ0dDoMIJfC6XI8ZFm5jUAD4xTVX+ILIjk
 9EEA+mXozTk+ZghouMAcVpsM54MOWyhAJZpjuck5Agx0bv74t2ic2DnStZAKuNYLzYsO
 kxQ0XxvTRzWqaaV56YQdAFeltqaNRPAbJpglOB2/Y7CglEgRqjDUA/CgSLJRTysuYAND
 C6zTQz9pjDybY+yHTwE8vIqkauquxehYhrFEJYWvSDpIC9wt8Y37NMxadwPkOuYfr0hA
 jNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745319279; x=1745924079;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S3cuc1N4YFsXf4X4TFbGvQl95S/zc1vp4BUoPJMKJ9o=;
 b=Oe9omTW0HWvS1CjDWLgk/F9ucxSlSv3Mr+S/GRWg3TCCsyKiJSdhLWWfhndImNAiyT
 sEsR1UqKhx/LEGDbO/WYkhU6l2R7RdHSPPiGc8+8M3AIFlcagqiCBMITCQka8LQr2cvg
 JmOdIWX7p78baNa4YJ8c6EU0uC1kwT9TAFe7ofSLyC80hWAhqgj8PL2ee5inRvb3W7/i
 LOPNyqzQOrvsLM4NBututpbhdpe/gLn9JbObtVkYyteemCU+6m9oPyaWUteBsLjwaaTY
 KvwiUa8cnvwwsfrmkQ0hl8xxiYeCFsEwnnIkQ9tqF5WDXQqYIa+WYBQ2+4FVvqRcTMTV
 ZwQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVKNCZLtkqIG3c5FXAgiB5LMOLqOJzkbsb4UJlK1Y5DUj2IyDVgQWws5fsYUvt2HFVufM+V/Y=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6pdrj+/7rcSWYvSlYyiyrVLgdT7eVVbFIDNm6Fp6HHlgCs7uF
 bEK49NcnuX8EDV2A5v+oPlJe1QwR/WjuWtmocHR196gYuLfSxM24Q4AvrNGhags=
X-Gm-Gg: ASbGncsgJz5O+YDaipOyoNI4+60nFvIiZ1B5gtiblOjL9zcj1okV5ZVZ06ytFMHRjl3
 mS8EPboMcODn839S4dZ+BYwe596PSrDziG1AcVylqcooZFAV7P/3hjH11N/YLX1YM/xmIOnxkDV
 hSJN77Hewqh+f/fox3C0MtBtZzJMl67fGvcEjLr54wDuP4nVQUQN6yMDai8nXNz99fZjXqyhRB2
 vX/8uzUfmypMIZGeiuncE++gdRA9GUkn3EO+fl4FIt99E6rZV96/S+elISQoZsjQB4x2FnI8Ol/
 dCukJJGEuWhbgA3Qkqh7OBzJIU8B3xWngJVKfrfmZY/xVMQfez/K8g==
X-Google-Smtp-Source: AGHT+IGRnRzndOjirozF7KuuTC9l/0751zI74SNEU/tCjyS2FSFWy3w73NOfAUrH5vQaDszkhglklw==
X-Received: by 2002:a05:6402:4404:b0:5f3:f04b:b5d7 with SMTP id
 4fb4d7f45d1cf-5f628578024mr13534162a12.18.1745319279497; 
 Tue, 22 Apr 2025 03:54:39 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:d722:61ae:90dc:b4e7])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f62554a1desm5709635a12.8.2025.04.22.03.54.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 03:54:38 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Tue, 22 Apr 2025 12:54:08 +0200
Subject: [PATCH 3/6] clk: qcom: Use setbits_le32() for qcom_gate_clk_en()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-apq8016-clock-fixes2-v1-3-bfc9dd933da6@linaro.org>
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

The other clock enable functions in clock-qcom.c use setbits_le32() to
read/modify/write the enable registers. Use the same for qcom_gate_clk_en()
to simplify the code a bit.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/clk/qcom/clock-qcom.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index 5018851725b03d1c55c6fc40934bd7bea6344da1..7a259db79342c31dfe85220c68c82197861ccdf6 100644
--- a/drivers/clk/qcom/clock-qcom.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -76,16 +76,13 @@ void clk_enable_vote_clk(phys_addr_t base, const struct vote_clk *vclk)
 
 int qcom_gate_clk_en(const struct msm_clk_priv *priv, unsigned long id)
 {
-	u32 val;
 	if (id >= priv->data->num_clks || priv->data->clks[id].reg == 0) {
 		log_err("gcc@%#08llx: unknown clock ID %lu!\n",
 			priv->base, id);
 		return -ENOENT;
 	}
 
-	val = readl(priv->base + priv->data->clks[id].reg);
-	writel(val | priv->data->clks[id].en_val, priv->base + priv->data->clks[id].reg);
-
+	setbits_le32(priv->base + priv->data->clks[id].reg, priv->data->clks[id].en_val);
 	return 0;
 }
 

-- 
2.47.2

