Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BD8CD128A
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 18:04:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0BA3880D6;
	Tue,  9 Apr 2024 20:03:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lbSQxL6G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48C1C8818F; Tue,  9 Apr 2024 20:03:16 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A1D788197
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 20:03:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a47385a4379so1280708166b.0
 for <u-boot@lists.denx.de>; Tue, 09 Apr 2024 11:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712685794; x=1713290594; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qG8QW672E0qOVkoIEEJNxqc76r9IS55XX4LLV2UPi/I=;
 b=lbSQxL6GWOdwty2NmnNvmfMLtnN5TB3EPonVDX0/bfqFlA3d006F+apLxd50VnGC9g
 qrZMzN/wz5KHjgwMtOz4HwE8htr93Z2boxK7Zh48+DRr/aHY9DY3r5KQSNeghpeaqc28
 DeW1tz6I8f04M+0g2qFksm95bmGtDkBXv37Bdof7QTNToaweZl+hyNj4po6E0mA73dJF
 nNbV8JdHzi7omQErApXmKwTOGVXs1WpfSA3+rfWec3ZBFBFrMuzM6rttEGVUAQBicco+
 ws0qdQsKOlLf1orG2fb0r3nTxAqrN4cdoMhhVfFXb022XLi910j7AvLTNnaGaFS2O6Nz
 K9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712685794; x=1713290594;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qG8QW672E0qOVkoIEEJNxqc76r9IS55XX4LLV2UPi/I=;
 b=wVBGzE1zN67S8J7uOmBAfruEFw9sOhNHCiZRq+4qEafZrzZ6c0zY7pmcvaq6pwXmbF
 HlqaXhziw7PqhjChLlkU7cBSqtpU0C1FpC+NgJ0v1aXl7dlyqoxbqP2RxJelD9DXOSvv
 OCWXonVwxQpmWuzW09wF2OPCVAZI7SVa+ngBOSIpMs9RqZ6f8GQ04IDveYvebsabeGCr
 SEpuQeH+6UVm05RZU+ePKt/r+q2Whblpz+cytT8X3b5XwAVlaNhUwwy260bgvhZS4MUY
 PNQcklMZ6QwzqdplAI8h8PomEEtzxA25s82aH8C8HZezE9sgi5UMDzVpsZg42KpVKbP9
 pZyA==
X-Gm-Message-State: AOJu0YwWdEuGKZ/5nfwsFqGXmcYSBddkvKau03eRMX2HYFmj7mu3PmHw
 GLw2iAk/NK/1XhaHEtCMx8sm/ovToOOME3+RrOI4XfXcodFxZijGTutTS/Kuo6A=
X-Google-Smtp-Source: AGHT+IGy1pHS8hmAGxn+wpxswtYCbwxyPbJzXw1zlvOnLlUJbw+Y1qT9PCaCz6Q5x03P1DfTt8o0+Q==
X-Received: by 2002:a17:906:30da:b0:a51:9e23:dc44 with SMTP id
 b26-20020a17090630da00b00a519e23dc44mr324356ejb.31.1712685793897; 
 Tue, 09 Apr 2024 11:03:13 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::570d])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a170907272400b00a4e5866448bsm5928783ejl.155.2024.04.09.11.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 11:03:13 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 09 Apr 2024 20:03:04 +0200
Subject: [PATCH 5/7] clk/qcom: sdm845: enable SDCC2 core clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-b4-qcom-mmc-fixes-v1-5-5039164ecbf7@linaro.org>
References: <20240409-b4-qcom-mmc-fixes-v1-0-5039164ecbf7@linaro.org>
In-Reply-To: <20240409-b4-qcom-mmc-fixes-v1-0-5039164ecbf7@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2686;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=0V4x2W6N+8jfI8icaL5U6rr4j4Ai8OIHFh8munzyrRI=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmFYLYmsLvJXnBEPCCP1V/+B2UdqoqgWEzsjjfO
 HqiVKMzUPaJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZhWC2AAKCRAFgzErGV9k
 tvkjD/wJc+OVwum5FM3HGa98GoFrQxxhkQkBLA3KzuSWA38M5XUrJ+0FSUDp5C01QFbyMN1k/Fx
 fwZhdMtrhLmoUHNlRjiPDOSm86Yzy/xMdddcMwKNVoeaXCQaPFu2L6ijXaIbqYTF+o9ZSsf07uh
 S4SASmc1+pzC4jCqPbaz4iR6Etg5qUT06MdHxxKBfjEdV+a+SfO8jfCVV/H6QPI6xxuXhLEQUp3
 rojj1/XlytK4dvnpjSMdiqQZRWlTYlDAH/ZFZB1ey5aRWS6+FLQM0SdofjdeZm4ShCGVApgF5vN
 /DrzmdEq0PTD/Qqxepdi54MAC9hU+QQL2gmNKyz3zD11obrp/4QdPh7WCNLXPEg0jiQa2xA3MQK
 2kfiklPflK/dy8cecOAjKIRS1SdQ0p022ef0mbYBd/1UKRTakoQpm4P6uB2OM9nH4VFxNN7Olog
 zSD4CDnt3TOHTsuXrGxZo93HPrTWgwLefUN15lnwqwGw4DipbSxzzxneLRrgLIaDKM98s4yLr82
 LqCvln1swjTGSF8KNJJa+rcIOB1aM4wn7clmii/W2frBkY6AZOik22wB7pVb6K8fAvKkrYpO2DO
 QzCh+qFGIh+SCuSziATofVYnoC4lBBUAv1UQAJ+ISqnIOakpEcm7PBCoOlGV8kCnt0gIpGod6n1
 NisWYHhGZcKyABg==
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

Allow setting the clock rate for the SD card core clock. This is
required for SD card support on SDM845 devices.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/qcom/clock-qcom.h   |  1 +
 drivers/clk/qcom/clock-sdm845.c | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index cc170d8e3f9e..f6445c8f566f 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -12,8 +12,9 @@
 #define CFG_CLK_SRC_GPLL0_AUX2 (2 << 8)
 #define CFG_CLK_SRC_GPLL9 (2 << 8)
 #define CFG_CLK_SRC_GPLL6 (4 << 8)
 #define CFG_CLK_SRC_GPLL7 (3 << 8)
+#define CFG_CLK_SRC_GPLL4 (5 << 8)
 #define CFG_CLK_SRC_GPLL0_EVEN (6 << 8)
 #define CFG_CLK_SRC_MASK  (7 << 8)
 
 #define RCG_CFG_REG		0x4
diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
index e9c61eb480de..782df7da8444 100644
--- a/drivers/clk/qcom/clock-sdm845.c
+++ b/drivers/clk/qcom/clock-sdm845.c
@@ -23,8 +23,9 @@
 
 #define USB30_PRIM_MASTER_CLK_CMD_RCGR 0xf018
 #define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR 0xf030
 #define USB3_PRIM_PHY_AUX_CMD_RCGR 0xf05c
+#define SDCC2_APPS_CLK_CMD_RCGR 0x1400c
 
 static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
 	F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
 	F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
@@ -43,8 +44,19 @@ static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
 	F(128000000, CFG_CLK_SRC_GPLL0, 1, 16, 75),
 	{ }
 };
 
+static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
+	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
+	F(9600000, CFG_CLK_SRC_CXO, 2, 0, 0),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(25000000, CFG_CLK_SRC_GPLL0_EVEN, 12, 0, 0),
+	F(50000000, CFG_CLK_SRC_GPLL0_EVEN, 6, 0, 0),
+	F(100000000, CFG_CLK_SRC_GPLL0, 6, 0, 0),
+	F(201500000, CFG_CLK_SRC_GPLL4, 4, 0, 0),
+	{ }
+};
+
 static ulong sdm845_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct freq_tbl *freq;
@@ -54,8 +66,13 @@ static ulong sdm845_clk_set_rate(struct clk *clk, ulong rate)
 		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
 		clk_rcg_set_rate_mnd(priv->base, SE9_UART_APPS_CMD_RCGR,
 				     freq->pre_div, freq->m, freq->n, freq->src, 16);
 		return freq->freq;
+	case GCC_SDCC2_APPS_CLK:
+		freq = qcom_find_freq(ftbl_gcc_sdcc2_apps_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, SDCC2_APPS_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
 	default:
 		return 0;
 	}
 }

-- 
2.44.0

