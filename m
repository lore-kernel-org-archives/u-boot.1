Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC33CCED635
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 09:15:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DE8A891A1;
	Wed,  9 Oct 2024 11:15:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zdrfw7Zn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 419DA8916C; Wed,  9 Oct 2024 11:15:29 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1ACBD8918D
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 11:15:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-37d3ae4a048so302753f8f.3
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 02:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728465324; x=1729070124; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5Csy28MuwfyyOvD8LsV7L/AQigjp27hsbdzLrGJx/8A=;
 b=zdrfw7ZnMCPZjgCV6IhKwGDAlvyn4+Pa0Qv9vR2ie4j15hXM498HDa+SyYhhVrnHxg
 +bqm+eGQfrVBTjI56khtkBvlmaHeGzeAGD6MIBHMA9XObw7VLI8aVq+l6DvMIlsFQQQM
 rvDQmdqQlQZLhLmOwQ8V55YHXCRjIfrL3bIDRfFh0vY92EauDHvLWxzRSIu4bUY38t7f
 Y3bc83Ww5nPERsMeSQc0aAbeL1OAOcFCSaKboJnozweMZ/vefLJB6osqZSKeaSG5241B
 3B5vJVcDX08r38A8z+E2TR226xcJNEYvZcahiB4BDxgFTZ4uT/ki4MC/KhvFHz4IXkx7
 LEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728465324; x=1729070124;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Csy28MuwfyyOvD8LsV7L/AQigjp27hsbdzLrGJx/8A=;
 b=MyWPG/B2iuleljke//RwEBatfBVacxqdkhRccbbQe2RJZdo756uXFWNhSqv6jEfJE+
 oFzo1esqYnLV6CqzIhg91vQcacyR+t2bXqdp6RGYrJK87RnzFjEfPVYvew6lxy1Hx2ED
 sXb3oD6S2wqlqvxcgM/Zh5mkcnHcbNOkKyiwpXD3SNrDVfnGTtri0XbnkbpiCgqbv9dg
 54R4e9VuYlwIYzJyTmK8kvGna9nt95QFzp3mtXSvS4tDOrZyW+EP1YGwo+yaW1h83e7y
 e8J1b5msPCNT0mwjS+XFs9YeC8Xh6ceBjsbYBbyujwfDGWhFduAJujBJRYG6bePC/5+g
 3P8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUT8eWJW4JsEdO8BXmIooWcTnos9Wi7/tKb6UK3sEBgQHkoLT6l0zgzXeE+sEFFZqQmzmKPPTM=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6GFBPLiFszPd0IPLPRhfNQ6EHQ8P8Rzqfy151LccE8c7QCKVL
 QlssZkBEIpnhxDpB74wUJQFQt8Rx36yCEyfQhqRP11Aj61XrkTupBJBBp4EegHQ=
X-Google-Smtp-Source: AGHT+IGHNow1LZ+mSeFnZzPM+q52K4hqeNHttaBPX51tsvqfw87Jl93w5RxoL0CmooZ71XeCViGVpA==
X-Received: by 2002:a5d:5e05:0:b0:37d:41df:136b with SMTP id
 ffacd0b85a97d-37d41df1952mr553215f8f.13.1728465324551; 
 Wed, 09 Oct 2024 02:15:24 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1690f270sm9865471f8f.21.2024.10.09.02.15.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 02:15:23 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 09 Oct 2024 11:15:20 +0200
Subject: [PATCH 1/2] clk: meson: gxbb: add HDMI clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-u-boot-topic-fix-hdmi-v1-1-2479cd90c4ea@linaro.org>
References: <20241009-u-boot-topic-fix-hdmi-v1-0-2479cd90c4ea@linaro.org>
In-Reply-To: <20241009-u-boot-topic-fix-hdmi-v1-0-2479cd90c4ea@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4868;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=3+iO8mS/jDInPmOoQBtOKqpVI8i1i3gSENKmC1sDqiE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnBkmper93Fd2VNWuWmhCoXzbYrcv3EE/IOKsndnHX
 T1LcOLWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZwZJqQAKCRB33NvayMhJ0WEND/
 4rHOR5h5mpGdJQ3UuKnF0ZbFkUK5wa/ZFw7+GN6qdKHdv4p+YSCwtk3r8yuaRZC8n8INA0K/QXGr7D
 anCypah9FUs3ZwPiR8+jb4chpNfyQY0uzQq1Vp+pHOWtzkXJ/ZNEme+kJEaiupZdQUxQt1Uybnk4UG
 U4cU+IV+jtMGPoI3Kup4X+HBi6itIRjoR/B78v2UZ+mJ8Be0mcxv+B9fPNU4f99EerewT5zoVhipjz
 VNVHtWIOBj2aa7Yhrvqo1/Nm29IOeFgqlzfX10ISiV+AAjCP7Rx152gV8+mz+mwp2wfuZr3jJp6vKS
 kRYB3YPegmn1frLYApwniN8jcynyXHMRktesf9A3MglRJYC1WF9uleYvw92z/b6l2bSzS37zOMrk5r
 fz3k2HKG4s5577zDQRboNc6Gj0w6vQz+exQLdzmr6ZQ5p9EqffEbD77SGwmsMcTwWc/VzMiT78Zt2m
 vz42v2lN2M//TAq86Ka4j19hNnndLfHQa1mDKctJNRXbdb3sCO2ml5Rtv9+bfGVDPJrfem5Zj+hTNd
 8NfkRSTnvaw/Lxhh3Kg5S/X+yOooE3KkFZDySSi9xVJDZDqnYbO/Cq7EufCKQjmDQaXWrN16hsQX3E
 DBkhPRTuQW5L7nedawCImryxYDBkR1VB3OR00NVdK0yY5FO/bw9E3p8IXtGw==
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

Align with g12a driver to handle the CLKID_HDMI, CLKID_HDMI_SEL
and CLKID_HDMI_DIV clocks since they were added to the upstream
GXBB/GXL Devicetree on v6.11 with [1]

[1] https://lore.kernel.org/all/20240626152733.1350376-1-jbrunet@baylibre.com/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/meson/gxbb.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 72ad4fd0e85..51f124869c9 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -66,6 +66,8 @@
 #define CLKID_VDEC_HEVC_SEL	  154
 #define CLKID_VDEC_HEVC_DIV	  155
 
+#define CLKID_XTAL				0x10000000
+
 #define XTAL_RATE 24000000
 
 struct meson_clk {
@@ -192,6 +194,7 @@ static struct meson_gate gates[] = {
 	MESON_GATE(CLKID_VAPB_0, HHI_VAPBCLK_CNTL, 8),
 	MESON_GATE(CLKID_VAPB_1, HHI_VAPBCLK_CNTL, 24),
 	MESON_GATE(CLKID_VAPB, HHI_VAPBCLK_CNTL, 30),
+	MESON_GATE(CLKID_HDMI, HHI_HDMI_CLK_CNTL, 8),
 };
 
 static int meson_set_gate_by_id(struct clk *clk, unsigned long id, bool on)
@@ -267,6 +270,12 @@ static struct parm meson_vapb_1_div_parm = {
 
 int meson_vapb_1_div_parent = CLKID_VAPB_1_SEL;
 
+static struct parm meson_hdmi_div_parm = {
+	HHI_HDMI_CLK_CNTL, 0, 7,
+};
+
+int meson_hdmi_div_parent = CLKID_HDMI_SEL;
+
 static ulong meson_div_get_rate(struct clk *clk, unsigned long id)
 {
 	struct meson_clk *priv = dev_get_priv(clk->dev);
@@ -292,6 +301,10 @@ static ulong meson_div_get_rate(struct clk *clk, unsigned long id)
 		parm = &meson_vapb_1_div_parm;
 		parent = meson_vapb_1_div_parent;
 		break;
+	case CLKID_HDMI_DIV:
+		parm = &meson_hdmi_div_parm;
+		parent = meson_hdmi_div_parent;
+		break;
 	default:
 		return -ENOENT;
 	}
@@ -347,6 +360,10 @@ static ulong meson_div_set_rate(struct clk *clk, unsigned long id, ulong rate,
 		parm = &meson_vapb_1_div_parm;
 		parent = meson_vapb_1_div_parent;
 		break;
+	case CLKID_HDMI_DIV:
+		parm = &meson_hdmi_div_parm;
+		parent = meson_hdmi_div_parent;
+		break;
 	default:
 		return -ENOENT;
 	}
@@ -443,6 +460,17 @@ static int meson_vapb_0_1_mux_parents[] = {
 	CLKID_FCLK_DIV7,
 };
 
+static struct parm meson_hdmi_mux_parm = {
+	HHI_HDMI_CLK_CNTL, 9, 2,
+};
+
+static int meson_hdmi_mux_parents[] = {
+	CLKID_XTAL,
+	CLKID_FCLK_DIV4,
+	CLKID_FCLK_DIV3,
+	CLKID_FCLK_DIV5,
+};
+
 static ulong meson_mux_get_parent(struct clk *clk, unsigned long id)
 {
 	struct meson_clk *priv = dev_get_priv(clk->dev);
@@ -475,6 +503,10 @@ static ulong meson_mux_get_parent(struct clk *clk, unsigned long id)
 		parm = &meson_vapb_1_mux_parm;
 		parents = meson_vapb_0_1_mux_parents;
 		break;
+	case CLKID_HDMI_SEL:
+		parm = &meson_hdmi_mux_parm;
+		parents = meson_hdmi_mux_parents;
+		break;
 	default:
 		return -ENOENT;
 	}
@@ -532,6 +564,10 @@ static ulong meson_mux_set_parent(struct clk *clk, unsigned long id,
 		parm = &meson_vapb_1_mux_parm;
 		parents = meson_vapb_0_1_mux_parents;
 		break;
+	case CLKID_HDMI_SEL:
+		parm = &meson_hdmi_mux_parm;
+		parents = meson_hdmi_mux_parents;
+		break;
 	default:
 		/* Not a mux */
 		return -ENOENT;
@@ -572,7 +608,7 @@ static unsigned long meson_clk81_get_rate(struct clk *clk)
 	unsigned long parent_rate;
 	uint reg;
 	int parents[] = {
-		-1,
+		CLKID_XTAL,
 		-1,
 		CLKID_FCLK_DIV7,
 		CLKID_MPLL1,
@@ -727,6 +763,9 @@ static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id)
 	ulong rate;
 
 	switch (id) {
+	case CLKID_XTAL:
+		rate = XTAL_RATE;
+		break;
 	case CLKID_FIXED_PLL:
 	case CLKID_SYS_PLL:
 		rate = meson_pll_get_rate(clk, id);
@@ -769,10 +808,14 @@ static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id)
 	case CLKID_VAPB_1:
 		rate = meson_div_get_rate(clk, CLKID_VAPB_1_DIV);
 		break;
+	case CLKID_HDMI:
+		rate = meson_div_get_rate(clk, CLKID_HDMI_DIV);
+		break;
 	case CLKID_VPU_0_DIV:
 	case CLKID_VPU_1_DIV:
 	case CLKID_VAPB_0_DIV:
 	case CLKID_VAPB_1_DIV:
+	case CLKID_HDMI_DIV:
 		rate = meson_div_get_rate(clk, id);
 		break;
 	case CLKID_VPU:
@@ -781,6 +824,7 @@ static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id)
 	case CLKID_VAPB_SEL:
 	case CLKID_VAPB_0_SEL:
 	case CLKID_VAPB_1_SEL:
+	case CLKID_HDMI_SEL:
 		rate = meson_mux_get_rate(clk, id);
 		break;
 	default:
@@ -851,7 +895,11 @@ static ulong meson_clk_set_rate_by_id(struct clk *clk, unsigned long id,
 	case CLKID_VPU_1_DIV:
 	case CLKID_VAPB_0_DIV:
 	case CLKID_VAPB_1_DIV:
+	case CLKID_HDMI_DIV:
 		return meson_div_set_rate(clk, id, rate, current_rate);
+	case CLKID_HDMI:
+		return meson_clk_set_rate_by_id(clk, CLKID_HDMI_DIV,
+						rate, current_rate);
 	default:
 		return -ENOENT;
 	}

-- 
2.34.1

