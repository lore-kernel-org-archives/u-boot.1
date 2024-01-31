Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579EEC47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 15:17:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76FD987DC9;
	Wed, 31 Jan 2024 16:17:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oZJYm2eu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AFA787D8A; Wed, 31 Jan 2024 16:17:09 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08DF087C38
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 16:17:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3394ca0c874so4232471f8f.2
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 07:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706714226; x=1707319026; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UFqjXWR2EyRY181MoxOm1kupuAVudbHRyYSyeMvdfE4=;
 b=oZJYm2eugi1OPCrHM3IC1FbizZGt2fplcmlCCngqarHy792pdoea1sMqVYwVZEEC+y
 RosUndm4Yqvt8dcZFtR//xN/ICW608IjL0RDgVjRISX0eTWrjfJLM4Qpo0BhHI3F3iFt
 +FkaPyiGvgJkKkHjCE2SAJnXpfDmTXwqTPC/akkSpjJzrysPtkQIlU49kJcHCiHXjszL
 7+JjuIUindEelPTHWmc84IFnxuH7vH/9+gbGSz0grc1ScakhcHNkst+mSfTnsV1rGo/k
 qUhH+RFNTiMRU4nkbr3Ro2oAwr6hLDM/WUnr37crVNuEd0ke15w6NsY0Sv6ge8nT3ETm
 A/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706714226; x=1707319026;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UFqjXWR2EyRY181MoxOm1kupuAVudbHRyYSyeMvdfE4=;
 b=OErBjG9DneLaXPmP2m3/Mp5g2c2rYChiyKZiWrKX+G5WacxS4h5uspp28T6EWHBOAy
 x48PqiAQnXT67yGisZPnouGy+4kGslf2TYCebEwsuNYQRjMPgt5dJxLo2swhtHOICMnv
 dLjOUMvNn7EJmfA7NDGw4wLA4YupMvRpkrv7ExEcza/IQiU17UE9Kk9L80Xk4gm8o84z
 ykRhMHkLbSiRrCBPabwHrzVY6FawNmJm2D6wGYY/NcmWNm9ZstNTVmJkbTVrqnqXg8jj
 A7ScjDca2jlfDP6FefIsxyxo962vYFZQE+RcVrPfu7L08E0/yBLwmkqKUBwnh0d5YZkU
 P+IQ==
X-Gm-Message-State: AOJu0Yz6V+63sAnPl77w3XwWwX3Prj/40ZRTbfTnM5m3nv25xCTpu5Zp
 BzpkXz4xVHK/Fuwbuy3RUz/fNidO2t5Kpu01Gq1GwhP/EZHilDu4DBJtNlxpfGCLMlByUHTNVp1
 2
X-Google-Smtp-Source: AGHT+IG9ad/Vi3FyapHxhY5YGnFJCQMvm30KMNBEe6d+q6vuolxCxJRQJrvehIfmzLLCLcgaghr1qA==
X-Received: by 2002:a5d:5088:0:b0:33a:ff67:74f with SMTP id
 a8-20020a5d5088000000b0033aff67074fmr1230495wrt.41.1706714226294; 
 Wed, 31 Jan 2024 07:17:06 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 en6-20020a056000420600b0033ae5b637d4sm11109031wrb.35.2024.01.31.07.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 07:17:05 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 31 Jan 2024 15:16:57 +0000
Subject: [PATCH 05/13] clk/qcom: add gdsc_enable helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-b4-qcom-livetree-v1-5-4071c0787db0@linaro.org>
References: <20240131-b4-qcom-livetree-v1-0-4071c0787db0@linaro.org>
In-Reply-To: <20240131-b4-qcom-livetree-v1-0-4071c0787db0@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=2590;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=BSNiNlwYSEmQfLDCyKskK/nWEh4PijXssqGk2AWtGPs=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRdKTltD6cmito+VWh+XrqI6dsNFw7GA97bQyeUXTtVd
 vHB5LuqHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAiwkcZGVauePmNPVZ60qFz
 xi6K5988cPjk3/SKU+Vpw4sznVckVvgwMizOCJML8t/D9ZF580qvyR+eGsh/7Vt5v0aYtZU57ff
 CCHsA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Global Distributed Switch Controllers are per-domain switches which are
used to toggle power and clocks to an entire subsystem. They live under
the GCC block and might need to be enabled before certain clocks, so
handle them as part of the clock driver.

Linux models these as power domains, however this additional complexity
doesn't offer much benefit to us in U-Boot. For now they can be turned
on as-needed when a relevant clock is enabled.

In the future, we can add a power-domain driver to model these properly.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/qcom/clock-qcom.c | 18 ++++++++++++++++++
 drivers/clk/qcom/clock-qcom.h |  4 ++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index d912b673d0d8..0e89e7fe429e 100644
--- a/drivers/clk/qcom/clock-qcom.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -39,6 +39,24 @@ void clk_enable_cbc(phys_addr_t cbcr)
 		;
 }
 
+/* Global Distributed Switch Controller - these are
+ * breaker switches for entire peripherals like USB,
+ * they control power and clocks and must be turned on
+ * before configuring clocks or accessing the peripheral.
+ */
+void gdsc_enable(phys_addr_t gdscr)
+{
+	u32 count;
+
+	clrbits_le32(gdscr, GDSC_SW_COLLAPSE);
+	for (count = 0; count < 1500; count++) {
+		if (readl(gdscr) & GDSC_PWR_ON)
+			break;
+		udelay(1);
+	}
+	WARN(count == 1500, "WARNING: GDSC @ %#llx stuck at off\n", gdscr);
+}
+
 void clk_enable_gpll0(phys_addr_t base, const struct pll_vote_clk *gpll0)
 {
 	if (readl(base + gpll0->status) & gpll0->status_bit)
diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index 7eb26369cd8f..2e074d0401c4 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -12,6 +12,9 @@
 #define CFG_CLK_SRC_GPLL0_EVEN (6 << 8)
 #define CFG_CLK_SRC_MASK  (7 << 8)
 
+#define GDSC_PWR_ON		BIT(31)
+#define GDSC_SW_COLLAPSE	BIT(0)
+
 #define RCG_CFG_REG		0x4
 #define RCG_M_REG		0x8
 #define RCG_N_REG		0xc
@@ -78,6 +81,7 @@ int qcom_cc_bind(struct udevice *parent);
 void clk_enable_gpll0(phys_addr_t base, const struct pll_vote_clk *gpll0);
 void clk_bcr_update(phys_addr_t apps_cmd_rgcr);
 void clk_enable_cbc(phys_addr_t cbcr);
+void gdsc_enable(phys_addr_t gdscr);
 void clk_enable_vote_clk(phys_addr_t base, const struct vote_clk *vclk);
 const struct freq_tbl *qcom_find_freq(const struct freq_tbl *f, uint rate);
 void clk_rcg_set_rate_mnd(phys_addr_t base, uint32_t cmd_rcgr,

-- 
2.43.0

