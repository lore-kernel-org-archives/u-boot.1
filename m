Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97D3D3B7F0
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 08:34:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9ADE89662;
	Mon, 25 Nov 2024 09:34:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QbghRAUZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 660EE89657; Mon, 25 Nov 2024 09:34:35 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07D3089664
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 09:34:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-434a1833367so960175e9.1
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 00:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732523670; x=1733128470; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SMvJyZbRWuNnAFE7yfo6z+S4N5WqjLo7zpl5KRC4qj8=;
 b=QbghRAUZpfeKnqUivFU2/x0qurszpPHAuyMUvawRVqFR5+jxzfDhMGdbdXLLlCP1D+
 m3/TquU6NclBO4+DNZyV0X+UvhNsfuioxvNJN8fI7/+kOZC7Bb4vhyYRTIfHugmlU1wC
 sXSZ8D3rSs9ySCAn0RqJ72N1/7vSS5ZDCq0Dj1CbjoElOM4X87LWaVSPip+dcOwAOUAY
 aBSLut8iB3eMs/7o/esbIqiHHXOXUH9B3gcEl7f1/F10bwb50wsHbJLi1xaD61j5hrMF
 dc0YcNzv/v8H0mVRRGBWIYDRBj1wyg357qEMYBlYUcCMJ1A30cmK+KohdluKBN06EmW/
 H7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732523670; x=1733128470;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SMvJyZbRWuNnAFE7yfo6z+S4N5WqjLo7zpl5KRC4qj8=;
 b=IiJE0GUYoVFNIM+ViMDYmIGLLdreDzbT6YQEOocFmbHFn8ws4pAp8ky2zD44b4KdDi
 WWJ+/KAhbs2ay+Yt1y2sP5SZ5mUwRk1ztpc2j8NLR6hlTdGD6PwH6xKoP/9J5VykhDxu
 MIpIgdh2Ko0tVQD2kB0cMNknO3XnFHEU+I+BYA0y2ySCaMIZ+NhSFlaRwHlRywZRgMMZ
 u0w++mu1idqfklGaV2B9M9zaEr9+dEsazuk/SPRbxuSRS1ZRRlOpmuO3DJ0YS/HmEPZJ
 pUy8pnZoMVxYmhG8+bhWR/qLSFb46Dk1pkaKv03Y+6YBHZOnjldiLk6tZzxF6mCg0+Oj
 bckg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3BwK6/WkoH1M1sHUosi2cAT1R8aURJJUZaqrqnFiFRSbVtnBAO0Jlot3zlC5bBy4k63PFObI=@lists.denx.de
X-Gm-Message-State: AOJu0YySh2Z+gVBtIB3voDRUxUfR2jbnUoisiJV9LCm6qb/so6BWmG6J
 WFpjENk2O4I9IUXHLD6Tk4ZqwfYB9fbPZ8Bl7oBSkoEiZI4uJzil2RiiUfpn6Zk=
X-Gm-Gg: ASbGncvYfwTnh625ZP9e09PE8tcGxgRjJ0LV5UvH62trG9uBA1L0Ktjy0L6KBUqZMen
 iOET+I8/pz8ivMJHqPBr38jgUPIXEAy8HQmdTbE9JjdLdOf+relqT1j0Yw11UXFg1fCliKaKW64
 2oITp+ymgQ9Ec2/nDvDKbz8sJQJ8wGYpujjVa1PJIkYPm2Qjc8WTLqIiPGhTswpNRECL703arOu
 teFW7f+U/ItlidntyHdyGrWHS3VZfCbU71oVSg59mTqIkLUun80HA9B2FLeds1KPEpPukE=
X-Google-Smtp-Source: AGHT+IF+QQwx9tjnaSC2nJssiEkPXqohS1+f+w/s1/k2TUnJUrkuDW5n5+LXPCntOzHOMybP3pCoXg==
X-Received: by 2002:a05:600c:5008:b0:431:7ccd:ff8a with SMTP id
 5b1f17b1804b1-433cdc2e16cmr96305805e9.14.1732523670486; 
 Mon, 25 Nov 2024 00:34:30 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825f98b3a4sm10013421f8f.0.2024.11.25.00.34.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 00:34:30 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 25 Nov 2024 09:34:26 +0100
Subject: [PATCH 1/4] clk: qcom: add clk_phy_mux_enable() for PCIe PIPE
 clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-topic-pcie-clk-v1-1-4315d1e4e164@linaro.org>
References: <20241125-topic-pcie-clk-v1-0-4315d1e4e164@linaro.org>
In-Reply-To: <20241125-topic-pcie-clk-v1-0-4315d1e4e164@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2239;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=g0FjaoqpfjI6frI33mzwzYPVRURIl7UqnNT+yHjBoio=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnRDaT+K3wVPO02SpP+t0Pd6n+o9pk7xcXINgm2VIl
 7tXrAtSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ0Q2kwAKCRB33NvayMhJ0XTqD/
 45IA0o/uj35dAGlA3Jn6F2kdMMIZYReGVQX9r1hs/wo2Z4CHLQ5wIinhQ4rzE01FVZNzrFTF4TnqBO
 MUaOhVePDzrElio2aWBxKAlnYHb+xkTHlqVI1S7wCni7fGL/yFQKQwGCc+c5gn4twTQ1CelyqiA+Dl
 P3rzJnp6Cg505FL4nmTBTWPTbM0e+LXuyuzhDEtjCdmuan+1io8FV1m/oNtf8uwmT5ahicLPQwHkJB
 D/1fl7qKYwuyZ8ZGh/6DZLZA9AOzUjHlvdwOf8o8y57lCSSDF5YJU3RIAPiem2w5+hPjKcpUPToVqj
 k35RBf0LLeiTiRSw1aqhI9TbJ2qCKo84N+766t2mzdSMvxLAz5ZF2cHdk6inIdZe8QCBXJ/9EEXBzi
 ezhaWB1xqD75kbsNyOrhDV/JDnHcRSeccbL/vu6aQ7uyZVB+v693IHe/jod/5zgpd+61yFaWtnsLUf
 C9gR1pXVk66mXUK4kNWJkihh3DliPBJ5icaK0GnKZQK09q4OE2Lg1ApJtNkaDEe1f6BrOk6Z86sPA5
 1FcZFlXCYavDGjL9zWagSNSdWjQrprGZfRX6thpv/cBG9g+tjSLLnnciP7HwzCFXQ8cciEyAZYADs3
 ssnLyYj/v5m6PPswy3YjOfld6ieb+C7MmP5ljIoctWLZCLeqbYGI7x31GW/A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

The PCIe PIPE clock requires a special setup function to
mux & enable the clock from the PCIe PHY before the PHY
has enabled the clock.

Import the clk_phy_mux_enable() from the Linux driver to
use the same implementation regarding the PIPE clock.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/qcom/clock-qcom.c | 19 +++++++++++++++++++
 drivers/clk/qcom/clock-qcom.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index 25ca67e537d112dda236837d3d3984f9b666365e..7687bbe6a23b436e4ddf3b29d1c910062961126d 100644
--- a/drivers/clk/qcom/clock-qcom.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -166,6 +166,25 @@ void clk_rcg_set_rate(phys_addr_t base, uint32_t cmd_rcgr, int div,
 	clk_bcr_update(base + cmd_rcgr);
 }
 
+#define PHY_MUX_MASK		GENMASK(1, 0)
+#define PHY_MUX_PHY_SRC		0
+#define PHY_MUX_REF_SRC		2
+
+void clk_phy_mux_enable(phys_addr_t base, uint32_t cmd_rcgr, bool enabled)
+{
+	u32 cfg;
+
+	/* setup src select and divider */
+	cfg  = readl(base + cmd_rcgr);
+	cfg &= ~(PHY_MUX_MASK);
+	if (enabled)
+		cfg |= FIELD_PREP(PHY_MUX_MASK, PHY_MUX_PHY_SRC);
+	else
+		cfg |= FIELD_PREP(PHY_MUX_MASK, PHY_MUX_REF_SRC);
+
+	writel(cfg, base + cmd_rcgr);
+}
+
 const struct freq_tbl *qcom_find_freq(const struct freq_tbl *f, uint rate)
 {
 	if (!f)
diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index 78d9b1d81ece1b3dd96b7bd0ab1a69fa016523b6..ff336dea39cf5cbe35f37f93669285897ba185a4 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -6,6 +6,7 @@
 #define _CLOCK_QCOM_H
 
 #include <asm/io.h>
+#include <linux/bitfield.h>
 
 #define CFG_CLK_SRC_CXO   (0 << 8)
 #define CFG_CLK_SRC_GPLL0 (1 << 8)
@@ -102,6 +103,7 @@ void clk_rcg_set_rate_mnd(phys_addr_t base, uint32_t cmd_rcgr,
 			  int div, int m, int n, int source, u8 mnd_width);
 void clk_rcg_set_rate(phys_addr_t base, uint32_t cmd_rcgr, int div,
 		      int source);
+void clk_phy_mux_enable(phys_addr_t base, uint32_t cmd_rcgr, bool enabled);
 
 static inline void qcom_gate_clk_en(const struct msm_clk_priv *priv, unsigned long id)
 {

-- 
2.34.1

