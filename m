Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4EEC369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 10:55:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E5DC812BC;
	Tue, 22 Apr 2025 12:54:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IiuthVap";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC4B381F54; Tue, 22 Apr 2025 12:54:42 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEFFA81E1F
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 12:54:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5f6214f189bso7882398a12.2
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 03:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745319280; x=1745924080; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7lQLZNK2st2obVKa6WmWatHhBUzlo8OEXZ30099aP9A=;
 b=IiuthVapZCi4P3QAMRMthCp13cUCTX3RwTYUL0Ql8GYzJIGTLS9O+K7J6g7HdtRsQm
 +vxloRmiqa1YJyf6mN5HCLrsPAtXrDgnLhbI8i09x0bMXgo9wCsI4ECikbzkyC2IONnj
 HCRJvUjBQDCSJqp2tPRu4LpHMP2T9Mewl1X42j5k5KYbd9cpL1L1bj1wKQI0GMYo4zpo
 LVrl0EhGPLyUIaeq9fbJEEPuSwRrW02FWGxfM3WJ4rCOT5H8q217aGc4FZb7cKG4V114
 J0LMrtJZs7hSvZXCXTHmmYeRPcW/IcotDnBvC+troF+7niRqfoQKg2N616680VqmBrRK
 njEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745319280; x=1745924080;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7lQLZNK2st2obVKa6WmWatHhBUzlo8OEXZ30099aP9A=;
 b=kl7rSwk2YRZmlrhWt9kYaT7Ye9CiBRc7e3LY+QC0QiOu8s92eyKMzGsK7Ra0QAuWPX
 49Wm0pyL9nysgCmuPVu/Pxj9IAF8DcukxhoWyJPfRYryXyHsxee2YkQZ2QWDQum+aCXH
 c7XMYXU2HXBqeESWBgQSfmMJ44GZQKOEOgUYAuo6pKIV5pOg1klvy451X5/ohO7Nppnc
 bjMtSZbd1jnWGJTd7oosuAifXiKFowTVjZZlSGSQOGkRXXetbV5wH2xPTdsoaD/BcnYg
 TMOwqF16XRWhNAPQnRx0rhdI2qD+fSxICGP2hUDVj8b66OwJ2OxWpZS3FjCElZApq7E1
 v2GA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDOlYCp9Tg0WWiI2Z+u8ylRtsTFfW4T1akxXpZ/wdT5BHfNalTBB2YX7zhTodPXqo3Vcqe5ew=@lists.denx.de
X-Gm-Message-State: AOJu0YwWlMOeY/rlzAlcaYE1o39/z8eHhWWml2m1EQ/FyxZsFDRwXnwf
 WIw4fuLJmLXmS0xRqRNCZG5vjji99rUNR6rC2Ycaim6eblFhctk1YRRFAts639Q=
X-Gm-Gg: ASbGncv+QEwlTYZvy+5STrmKw67hjOqRyt/E4OLbkIw+bKxWPebMZfl8qFtY8AWK43t
 TeBD0AkHSsy449ky2dK5BLDqJ7JHetXivF65Ey88gjprHPtFoFfgnbp+dDHUYJb+pntiMeCrgGt
 z+Mph4gkXzDxjaxSaijQ/DkQPh6XfZoRVE/rNrK4Topbtp5BRQW596ctgURyq0BlbasOJBuNaJv
 1F8rkJS+5DcgOub/xEwuaU9Uuh6Wb5mogX9txwz5MVxM9/0J+37uTN7/3080d3h7EUruuc5JH4d
 hTwiOMkNOE+swdY0LyvXKDRcCKPWwlmA8rE7QatAB/HtI1OPtITxSQ==
X-Google-Smtp-Source: AGHT+IGd8TXkV/6xRbAj/EGbCzYc4LmNDfhkx+PHbShiRx2lmiSjbEfEWODIgTeMPwWc73A5fO4vSA==
X-Received: by 2002:a50:fb95:0:b0:5f3:f04b:5663 with SMTP id
 4fb4d7f45d1cf-5f6285d3f15mr10251884a12.24.1745319280345; 
 Tue, 22 Apr 2025 03:54:40 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:d722:61ae:90dc:b4e7])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f62554a1desm5709635a12.8.2025.04.22.03.54.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 03:54:39 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Tue, 22 Apr 2025 12:54:09 +0200
Subject: [PATCH 4/6] clk: qcom: Allow polling for clock status in
 qcom_gate_clk_en()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-apq8016-clock-fixes2-v1-4-bfc9dd933da6@linaro.org>
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

GATE_CLK() in its current state is unsafe: A simple write to the clock
enable register does not guarantee that the clock is immediately running.
Without polling the clock status, we may issue writes to registers before
the necessary clocks start running. This doesn't seem to cause issues in
U-Boot at the moment, but for example removing the CLK_OFF polling in TF-A
for the SMMU clocks on DB410c reliably triggers an exception during boot.

Make it possible to poll the branch clock status register, by adding a new
BRANCH_CLK() macro that takes the extra register address. Existing usages
work just as before, without polling the clock status. Ideally all usages
should be updated to specify the correct poll address in the future.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/clk/qcom/clock-qcom.c | 15 +++++++++++++++
 drivers/clk/qcom/clock-qcom.h |  7 +++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

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
index ee0347d9d86716c09e7f57b343f12b5908f8cb92..28145061844255460e8a6868b69ffe9a7dd663b0 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -52,13 +52,16 @@ struct freq_tbl {
 struct gate_clk {
 	uintptr_t reg;
 	u32 en_val;
+	uintptr_t cbcr_reg;
 	const char *name;
 };
 
 #ifdef DEBUG
-#define GATE_CLK(clk, reg, val) [clk] = { reg, val, #clk }
+#define GATE_CLK(clk, reg, val) [clk] = { reg, val, 0, #clk }
+#define BRANCH_CLK(clk, en_reg, val, cbcr_reg) [clk] = { en_reg, val, cbcr_reg, #clk }
 #else
-#define GATE_CLK(clk, reg, val) [clk] = { reg, val, NULL }
+#define GATE_CLK(clk, reg, val) [clk] = { reg, val, 0, NULL }
+#define BRANCH_CLK(clk, en_reg, val, cbcr_reg) [clk] = { en_reg, val, cbcr_reg, NULL }
 #endif
 
 struct qcom_reset_map {

-- 
2.47.2

