Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6647C369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 19:27:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 071B88215F;
	Mon, 28 Apr 2025 21:26:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G7paOr8r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 173AC820FE; Mon, 28 Apr 2025 21:24:39 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBD9880BAD
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 21:24:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-308702998fbso4414204a91.1
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745868275; x=1746473075; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=02NIdCs4zhnB9+h0eSTxPwWETTlYNKWX/2MyrGOgvKk=;
 b=G7paOr8rZdPZr23uB+kIGnKrRfrQKZRQlDef/tZcpanYed85wv+VPwW+an94CDcJtP
 ZvlBE3YvbkRbNAAChVbcP/arcs9b0oFqyFysG+8IS+6g34ObT4NxUk9TvlfRSG15hTAg
 BYGbDSyNdBwjqOr1NnGTydW33PnOqHvwOVs+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745868275; x=1746473075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=02NIdCs4zhnB9+h0eSTxPwWETTlYNKWX/2MyrGOgvKk=;
 b=LUSr5XnAY/BatLnMK2wbV0xia/9uslmdZqtufnhBiCNAMNc6/Jv9irMogORTNdmgWo
 o/yGEcWRWhnB85rtjcQgdRrOyFBwJWu9WoY89poUtVzIXkLbOPArJKuouLHvYli3Jw7s
 kT4ac8GqecldNYZqssNYf+nM0U0rK9cGjsAIeSjMJI4tkpc0mqDu/K6GL5KqldG5bRD6
 WDp6pRSBhBDR6RQroJv2yn4JWjAcx8RhnKNTaPJFXn5OXua0nze16VRdTePulcXGanRd
 3Eh0+MXZexg4RtbR6dsvwrgJbMqd28ZEwTGCqgQxjXG3oQ5REXdRg5PFoGtKYWB5dQ09
 8H4A==
X-Gm-Message-State: AOJu0Ywf4Z7l17teFNHWK9a42IhoWALTXflEDphAQZQhtlvpBDArDEWd
 uU+q72yXZA8ySuoiEmVYMTA0yjDjTvpCrrdzRAAYpq2hbE6cDdYmJoxW3nXUR0Ik4zcdS49HNGo
 =
X-Gm-Gg: ASbGnctXG3DSyTI+CpE1IOf5I2A+MOArjJ8BRoKSN2RxxnA7prZQleUX8MPtBv6op4b
 ew+pk9dsz9lsfPl1yiid8gb+KeI/kLvKAckZQx++3a4hlrjUWmMlOw5HATQyXOXzmGAPNBzDBpO
 y0Hge/zRIpV9yiDDRZ+SvZOT8Nko6u1kgW4sNpQGPDf8lPKs2jM1xlUDIeJWYH5M/OW17CMMxD4
 CFDZN6R2TUB9gfL/0DTB0kRxiuedWC5xlGyObstXG84Atv1bIV/SYkixy5NPAJqru06DKFRC0Mm
 CRL/QuwoWkssGPOxSoBs1oDfEaQ+X/3n5TINhm8hF1dz5pEz7T4MIOoY1vIQF58/8PS1EkJfenx
 IWA==
X-Google-Smtp-Source: AGHT+IGC6VkJKC3cj2NErtjGPu/gSxttfQ2xcuD1ouNJyetxw3GR/vviv0Tjnyp9exQWp7+Prt5yBg==
X-Received: by 2002:a17:90b:53d0:b0:2ff:702f:7172 with SMTP id
 98e67ed59e1d1-30a013bcbbdmr17362720a91.33.1745868275075; 
 Mon, 28 Apr 2025 12:24:35 -0700 (PDT)
Received: from localhost (199.24.125.34.bc.googleusercontent.com.
 [34.125.24.199]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-309f774e4e3sm7617254a91.15.2025.04.28.12.24.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 12:24:34 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v3 03/17] clk/stub: add sc7180-rpmh clock
Date: Mon, 28 Apr 2025 12:24:10 -0700
Message-ID: <20250428192427.3877612-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
In-Reply-To: <20250428192427.3877612-1-swboyd@chromium.org>
References: <20250428192427.3877612-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Apr 2025 21:26:55 +0200
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

Stub the RPMh clock controller on SC7180

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/clk/clk-stub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
index 5f5aca41d5b3..23670c2f4425 100644
--- a/drivers/clk/clk-stub.c
+++ b/drivers/clk/clk-stub.c
@@ -51,6 +51,7 @@ static struct clk_ops stub_clk_ops = {
 static const struct udevice_id stub_clk_ids[] = {
 	{ .compatible = "qcom,rpmcc" },
 	{ .compatible = "qcom,sdm845-rpmh-clk" },
+	{ .compatible = "qcom,sc7180-rpmh-clk" },
 	{ .compatible = "qcom,sc7280-rpmh-clk" },
 	{ .compatible = "qcom,sm8150-rpmh-clk" },
 	{ .compatible = "qcom,sm8250-rpmh-clk" },
-- 
Sent by a computer, using git, on the internet

