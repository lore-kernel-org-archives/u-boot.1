Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8D3C71136
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 09:45:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39CA082B00;
	Mon, 16 Jun 2025 11:45:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hToYt2Gj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F4BE829F5; Mon, 16 Jun 2025 11:44:58 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94A0C81760
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 11:44:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a531fcaa05so2611370f8f.3
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 02:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750067096; x=1750671896; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3UV57k4rVnijtDtvo0BY0z3lwOaNoI6EVcU6lW1NM8o=;
 b=hToYt2GjwQ+k/e2Tai6wTe6iKbPnfUjL0dnBghpbAHcA3wg0J1dyNxbSgWIwGNy5Fd
 asSCmtJ2Vx7xWBv7sZyczoBhHmw1M/TLbbV58962ivueAwwBvMuF5al8z2Hew2KIi/hh
 pNGsSZJO3AC+1srrnEcYja9NKytgOsJ0WfsaQ5KSDDHyZR0AD2FJHP7wlbM7moxir2op
 256lq7m+M2P4sGF/NTVLteSounSwLnNRuNi3cyXV6Sm46wtyv4S1qsHLKLjkQYRqzJmr
 WW3QbiWoS4s2QHozycwYktPn915nXthJcamHosT3EYPOIKljOXZ+hZ7Ee3wEEVor3yQx
 iLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750067096; x=1750671896;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3UV57k4rVnijtDtvo0BY0z3lwOaNoI6EVcU6lW1NM8o=;
 b=EUp3MmNyFJQkqvEPAiA4ARTtjUV4URiEznIpMO6UlNBy0rpTtUGScnTr4KeF6oYsKO
 y36Mzb8FWcJ+9ydFsmS4gGNO6iSFW2CP5BIQak9Od+YY8ENlqAoNe05di4IwtKWbSIsj
 30qFVdMbUfHv7N7xgtoO552CssjEbiNrSKUcK1MHjs3HP8h9E5c1s6OI8FCMLeMW5cJQ
 tjo3dZ5AkM0UXe3odXodCVHRGr0BA3M57repwjNwWQBmU17E3KNAxNn2JxdMAU/kp7tc
 E/6iSMkLDIV/wKDbHXtfz5/neROhlE3AfJHrnx2t/gur5Z2BpZm9prKmeiSTu54Le9uV
 neSA==
X-Gm-Message-State: AOJu0Yx2UxtqoMrdB82ndrLIwybxWCTKY2Eb0h6m7xqhq93Ob8dK/Ppg
 8AUkQ2d2A1t+VWmBrVWCkaVhyMG+NqZmKHPP4EnyNbVXN3gFEG01whHAPyQ1JqJGpw0=
X-Gm-Gg: ASbGncvT2peKew5uCbqtX2doJYL00v6gMU/sXwMbqdfKg00h+cc/KHk9B3vkq5B+aIB
 8IjtrNCceYXiUgk3IEVcBfA15tsSXU9jLGeMn/5C81w8qZO1VkUBMGutc7fgESllzhT7dtLtQeK
 bOsAE6CbxAaYjXrMvH55LcVxAPtPCJPnyGr+hvXdkdv79hl7KetQjvzPG8WSRQUq6R+hFM7JGPS
 PrtSyKtOijNVj8j7YNwWhyynOQizvyyo6KwXktpI0g6S196F1wZ2cHIkQqKlQ39RbK/lNv5Ie7U
 8sVf/UtbyTmAhGTfioNsiqElx9mWxqcDceOSUq611Ngh0ZoAgtYYgZ1GGU7UaQRELQI4M9Cq/mv
 dURbu
X-Google-Smtp-Source: AGHT+IFBigejFNkVxdTJbb+ySi2+K7l4MoaT+DAEMSre8XIOiywrkP5WT7efSrRnpjRf7OoBJEHPtA==
X-Received: by 2002:a05:6000:4284:b0:3a4:d6ed:8df7 with SMTP id
 ffacd0b85a97d-3a572ea7ff9mr7549441f8f.59.1750067096019; 
 Mon, 16 Jun 2025 02:44:56 -0700 (PDT)
Received: from toyger.localdomain ([213.240.182.76])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532de8c229sm139308105e9.6.2025.06.16.02.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 02:44:55 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 16 Jun 2025 11:44:47 +0200
Subject: [PATCH v4 5/9] clk/qcom: sc7280: add uart7 clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-geni-load-fw-v4-5-e7df44205505@linaro.org>
References: <20250616-geni-load-fw-v4-0-e7df44205505@linaro.org>
In-Reply-To: <20250616-geni-load-fw-v4-0-e7df44205505@linaro.org>
To: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1851;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=ilc+MkFAWqEHp3xVjnRqOgd0tHQQmGiRxLtjzyftWZk=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoT+eOfHHxcCMk/2EkzTQGXFEJJO2k1RCyohwQS
 iDrjp98ocmJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaE/njgAKCRAFgzErGV9k
 tlJ+D/9OPc5dkb8vLCbUhM13IYn9nGMx1k/9bXOcv+af4mGIArEP/bXWTR/A46oQg4WDsGbvRi6
 akbk+pCNhZrUXHVO9gUHO4etAcCdqmKqgwH8Iq7vWUjEsZ4luBFhPYPNQ+59Y1tkqC3qT1CwDsA
 iiHdc6ZXvLcJYg112dD5Eayc9Nh0GDV4/8FiPdiop4Nty3G5KKBfG5HwOftYCJt15sqlQsXi05P
 hfbp/iiGg8sQ4dtzDiqDwGhnXhI2Wfns8DnKMjWb6QtgCLU6BRdDRxyr7+J6w2Kw1BEgnBA97w1
 0VmX57nUwnRhbbEhS/TyMYjCr6rJCcRjluc+SNkiQhe0IjeKnism5xbAQtI8/x4VnJvV//BNF2F
 4o62ROlITPBIEZyiYZthMctZijPsjbns0K8hwTlUl23yoJo/bZ/b4fh/FjiEDgBmAdB8wLmjfsX
 IFvj0f+nd+SGFnXwhW/FYqCyxjs+hyxRKhmqxRknbjpWj8nCuAPXDMsMG4MI3rnUWu0EfyXta3W
 0mJPjsPqss6VGXr8UAYqGEs6wWUlwcdyYyRAdIKpd7T5IWInSpWUec7qYE9LnykhtI7XFqGxJRY
 xenaVHNuRDy5IIT2u757YBGiNItVgN1/l9DCkTqBHfVKxEkPqRZxwc7qNpNW7Xbm0bGerc9Yuj1
 OYbM8pEUTp+fWJw==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
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

Allow us to power up UART7 so we can load the QUP firmware, this is used
for bluetooth on RB3 Gen 2 and possibly other boards.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/qcom/clock-sc7280.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/clock-sc7280.c
index bf3c6c4ae647a46f7f96b10c0e3ed76a2f2ebee1..55a233df39450e511aebf7892214967c284a603e 100644
--- a/drivers/clk/qcom/clock-sc7280.c
+++ b/drivers/clk/qcom/clock-sc7280.c
@@ -67,8 +67,13 @@ static ulong sc7280_set_rate(struct clk *clk, ulong rate)
 		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s2_clk_src, rate);
 		clk_rcg_set_rate_mnd(priv->base, 0x17600,
 				     freq->pre_div, freq->m, freq->n, freq->src, 16);
 		return freq->freq;
+	case GCC_QUPV3_WRAP0_S7_CLK: /* UART7 */
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, 0x17860,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
 	case GCC_USB30_PRIM_MASTER_CLK:
 		freq = qcom_find_freq(ftbl_gcc_usb30_prim_master_clk_src, rate);
 		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR,
 				     freq->pre_div, freq->m, freq->n, freq->src, 8);
@@ -128,8 +133,9 @@ static const struct gate_clk sc7280_clks[] = {
 	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK, 0x52008, BIT(10)),
 	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK, 0x52008, BIT(11)),
 	GATE_CLK(GCC_QUPV3_WRAP0_S3_CLK, 0x52008, BIT(13)),
 	GATE_CLK(GCC_QUPV3_WRAP0_S5_CLK, 0x52008, BIT(15)),
+	GATE_CLK(GCC_QUPV3_WRAP0_S7_CLK, 0x52008, BIT(17)),
 	GATE_CLK(GCC_UFS_PHY_AXI_CLK, 0x77010, BIT(0)),
 	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x770cc, BIT(0)),
 	GATE_CLK(GCC_UFS_PHY_AHB_CLK, 0x77018, BIT(0)),
 	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x7705c, BIT(0)),

-- 
2.49.0

