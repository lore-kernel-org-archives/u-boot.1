Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4526C54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 23:01:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E52E183466;
	Sat, 24 May 2025 01:00:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Of1KKBPC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C91EA83420; Sat, 24 May 2025 00:58:57 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9599C8334D
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 00:58:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso312603b3a.1
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748041134; x=1748645934; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zxnHd2QMLLi2gaQ+i1zk8OkDRNWNJwBkFpi+DfWO1Ls=;
 b=Of1KKBPCrO/yd/awg4q5VRLnFqyD4qPStydnHzGORu7MKFAowuBcS0b/MkuU3QDR72
 39zxQTP97+UGmribppGZfxs9O1eJxzdgtPE8puqbwZUrvxyDcndXYd++m0BnWEbHFuDw
 IShZSB4CpLPozQNV6wKFhjwGOBqAZmm1RrjPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748041134; x=1748645934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zxnHd2QMLLi2gaQ+i1zk8OkDRNWNJwBkFpi+DfWO1Ls=;
 b=NgrK4orJ0HmPtBB/U26IG9RlmaU/OcuXvKJA2U+6AfK9f90pDozoLR65CeHBowSCZA
 P7H53GaCjXENUS3EfYodwb+2LgobNpa6cvB/Mt40xSXcIitvFxJOEu0skZ1cpHyvUM++
 7S9wsi0A1cPtjRqHAuSH6OwsDkDQnyJBrToDIUH4+NPrq4YjH7rYfiBQeHfy+eU7yRap
 vuoyb2MydCXreOVGOTwaoif/wN2LCsio2aBHNzksV+hYn5tZe0PiSe3WY2i49LcUkKWD
 mt2inSX0Wv6f/M4ULZ1DD6z2PXt5fXgGNL6DFtevkG/WMaUrUkzMzfsyevNn6ea9cSxU
 gnVw==
X-Gm-Message-State: AOJu0YxG21NoAkZrjGPyPkW6lQT3EZQImJh80SSK0iv+MXY/lqE1IA/+
 eRyc4hAGS8Me7WS+wGnLVV4wmju4el2FWvmIcIV778EvbSa2oorOQS6raY57kb9C5rn/leSZRPA
 eNEE=
X-Gm-Gg: ASbGncsLeqNloiKp9bfPanNW78gFqygOgCh/E9JiaN5c+Z0WuZzwcxmM4Q0X4KOhqb5
 y+5AME9W+w3LCVSpkyLSQTySqHqaBgHs24GxfijynGizGzDYXA5vwSdb1EnTNjk+y0gs9zvpnS6
 GnbEWTBClFhiBD1utvstcRuM+wkOpop6g1WsvRCE4oofeuO7Q/T53/bNPR8ch0GpRc+V1xxcs7G
 oSk1GXWiohvXjubJySmF5/93Zlwf6dTVy6SL9aAJqejP2qCpkI4QzwvG+ZfjrOhXdl6i3UHkfoP
 xT3EhThlim3pyXSb4yhtyZ5dHRnnyjIx/MF34d0HG+fZ09W5So0Vn9jB+0HhANjBXkhGP2ZvFQt
 lJ3JVNBr8fYjTPoA=
X-Google-Smtp-Source: AGHT+IEMguNUDbyW0t4n/7UK1RzXzuSOhaPduHqWTu+pHL6zrPlU5vtQz1RMq9xKMyCBQoRFJbV0dA==
X-Received: by 2002:a05:6a20:6f8c:b0:215:d1dd:df4c with SMTP id
 adf61e73a8af0-2188b571a1fmr2018129637.6.1748041133964; 
 Fri, 23 May 2025 15:58:53 -0700 (PDT)
Received: from localhost (188.139.125.34.bc.googleusercontent.com.
 [34.125.139.188]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-745e8f6d278sm2596092b3a.81.2025.05.23.15.58.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 15:58:53 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v4 04/28] clk: qcom: Support uart clk on sc7280 CRD
Date: Fri, 23 May 2025 15:58:19 -0700
Message-ID: <20250523225845.2311989-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
In-Reply-To: <20250523225845.2311989-1-swboyd@chromium.org>
References: <20250523225845.2311989-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 24 May 2025 01:00:29 +0200
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

Support setting the frequency of the UART clk on sc7280 so that the
serial console works on devices like hoglin.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/clk/qcom/clock-sc7280.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/clock-sc7280.c
index 9aff8a847ad1..b9152c129df1 100644
--- a/drivers/clk/qcom/clock-sc7280.c
+++ b/drivers/clk/qcom/clock-sc7280.c
@@ -38,6 +38,22 @@ static const struct freq_tbl ftbl_gcc_usb30_sec_master_clk_src[] = {
 	{ }
 };
 
+static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s2_clk_src[] = {
+        F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
+        F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
+        F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+        F(29491200, CFG_CLK_SRC_GPLL0_EVEN, 1, 1536, 15625),
+        F(32000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 75),
+        F(48000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 25),
+        F(52174000, CFG_CLK_SRC_GPLL0, 1, 2, 23),
+        F(64000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 16, 75),
+        F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
+        F(80000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 15),
+        F(96000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 25),
+        F(100000000, CFG_CLK_SRC_GPLL0, 6, 0, 0),
+        { }
+};
+
 static ulong sc7280_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
@@ -47,6 +63,11 @@ static ulong sc7280_set_rate(struct clk *clk, ulong rate)
 		debug("%s: %s, requested rate=%ld\n", __func__, priv->data->clks[clk->id].name, rate);
 
 	switch (clk->id) {
+	case GCC_QUPV3_WRAP0_S5_CLK: /* UART5 */
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, 0x17600,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
 	case GCC_USB30_PRIM_MASTER_CLK:
 		freq = qcom_find_freq(ftbl_gcc_usb30_prim_master_clk_src, rate);
 		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR,
@@ -107,6 +128,7 @@ static const struct gate_clk sc7280_clks[] = {
 	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK, 0x52008, BIT(10)),
 	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK, 0x52008, BIT(11)),
 	GATE_CLK(GCC_QUPV3_WRAP0_S3_CLK, 0x52008, BIT(13)),
+	GATE_CLK(GCC_QUPV3_WRAP0_S5_CLK, 0x52008, BIT(15)),
 	GATE_CLK(GCC_UFS_PHY_AXI_CLK, 0x77010, BIT(0)),
 	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x770cc, BIT(0)),
 	GATE_CLK(GCC_UFS_PHY_AHB_CLK, 0x77018, BIT(0)),
-- 
Sent by a computer, using git, on the internet

